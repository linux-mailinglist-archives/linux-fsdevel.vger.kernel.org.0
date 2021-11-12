Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28D444EEF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 23:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhKLWDl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 17:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbhKLWDl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 17:03:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043A7C061766
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Nov 2021 14:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A8k6QFkLXBFZp+Kn5m60ye/dkCEoYqq9CywN61lzTAQ=; b=PSQzedWOn0yHCyeAKd+07gYYmE
        7EUWTeTU+yoe6rtiKNQdx9a1k1u4ays8XpOn2RRq+z93lJXpxnBdInTIgpQ0SVK5EHNjTFqLJisZW
        o2ZE0fT0vrumIiwAty9EteQ0XA2a22RGut93eOcEf1gFEwmcH74GVsae5wpL6ib3bK08+YP38eEfp
        9McbJFpaKdApWFi4UjuVCINO5DWoboDmCsGfP0bk72wq2c4fKijT3PcV3O/c6PqTV89g5C49TjxnA
        TDPgwN9zNRpFCmrbpzt//8k7xvlp6qeRBPMF3Rmm4FQcqKAOCeLzRDw67pS0qPGPENppPYGak+V3G
        /C469/Sg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlebH-003rtw-8y; Fri, 12 Nov 2021 22:00:47 +0000
Date:   Fri, 12 Nov 2021 22:00:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: xas_retry() based loops on PREEMPT_RT.
Message-ID: <YY7kD/JWy9zuUGub@casper.infradead.org>
References: <20211112173305.h36kodnm3awe3fn3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112173305.h36kodnm3awe3fn3@linutronix.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 12, 2021 at 06:33:05PM +0100, Sebastian Andrzej Siewior wrote:
> I've been looking at the xas_retry() based loops under PREEMPT_RT
> constraints that is xarray::xa_lock owner got preempted by a task with
> higher priority and this task is performing a xas_retry() based loop.
> Since the xarray::xa_lock owner got preempted it can't make any progress
> until the task the higher priority completes its task.
> 
> Based on my understanding this the XA_RETRY_ENTRY state is transient
> while a node is removed from the tree. That is, it is first removed from
> the tree, then set to XA_RETRY_ENTRY and then kfree()ed. Any RCU reader
> that retrieved this node before it was removed, will see this flag and
> will iterate the array from beginning at which point it won't see this
> node again. 

That is correct.  If you have found a case where this isn't true, it
is a bug and I would welcome the report.

> The XA_ZERO_ENTRY flag is different as it is not transient. It should be
> the responsibility of the reader not to start iterating the tree from
> the beginning because this state won't change.
> Most reader simply go to the next entry and I *assume* that for instance
> mapping_get_entry() or find_get_entry() in mm/filemap.c won't see here
> the XA_ZERO_ENTRY.

The ZERO entry is somewhat special.  Readers see it as a NULL, but it
occupies space in the tree unlike an actual NULL entry, which is liable
to having its space reclaimed.  It really exists for the purposes of
the IDR which distinguishes between a NULL entry and a deleted entry.
In XArray terms, it's a reserved entry (ie we've reserved the memory so
that a subsequent store doesn't need to allocate memory).

Readers should all be skipping over ZERO entries (as they do NULL
entries), not restarting the iteration if they see one.  So it shouldn't
factor into your "does it make progress" analysis, because an iteration
should continue, not retry.

Also, I am not aware of any user of ZERO entries in the page cache.
It's possible that somebody has added one without me noticing, but there
wasn't one earlier.
