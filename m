Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C823C30A91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 10:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfEaIrX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 04:47:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58674 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaIrX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 04:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bOMlPYuwhgNbgzcW47Xzr7NLkqTLvvZFQzwh9Q0CgQ0=; b=oLrLydqEYkud8wnFoaqc9lIXF
        HGHM28f+TVN8TeRcewuei7Mcw5lGYTzy2Rx6epTJDzc3urw5N/6Kq+tnjPgQSVAlSLDspniCQ5QBg
        SDULeC//qqu3DLv5JTOcAKzx6Zxks2E9qg3/sBmYp2KeYDDYtrjLl0dJsOkJ/eSCIgtSrdc2uMZSI
        pS8Z3FMlDMidlUyLDDNFdJz5SebER8isgaZjADqbUDCi/eptpU3U+7CwBH9nbN1LMU/uewFD5ioy1
        It/OotQLeY9DmPDyLLRItNsIYUvnyn35xP5U5ER3PzSk6eTukrsH5UZcaqn/qgODJwFXcZ4dXtg2C
        b+OJmkpOQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWdC1-0002qV-63; Fri, 31 May 2019 08:47:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9109F201B8CFE; Fri, 31 May 2019 10:47:14 +0200 (CEST)
Date:   Fri, 31 May 2019 10:47:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, viro@zeniv.linux.org.uk,
        raven@themaw.net, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-block@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] General notification queue with user mmap()'able
 ring buffer
Message-ID: <20190531084714.GL2677@hirez.programming.kicks-ass.net>
References: <20190528231218.GA28384@kroah.com>
 <20190528162603.GA24097@kroah.com>
 <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <155905931502.7587.11705449537368497489.stgit@warthog.procyon.org.uk>
 <4031.1559064620@warthog.procyon.org.uk>
 <31936.1559146000@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31936.1559146000@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 29, 2019 at 05:06:40PM +0100, David Howells wrote:

> Looking at the perf ring buffer, there appears to be a missing barrier in
> perf_aux_output_end():
> 
> 	rb->user_page->aux_head = rb->aux_head;
> 
> should be:
> 
> 	smp_store_release(&rb->user_page->aux_head, rb->aux_head);

I've answered that in another email; the aux bit is 'magic'.

> It should also be using smp_load_acquire().  See
> Documentation/core-api/circular-buffers.rst

We use the control dependency instead, as described in the comment of
perf_output_put_handle():

	 *   kernel				user
	 *
	 *   if (LOAD ->data_tail) {		LOAD ->data_head
	 *			(A)		smp_rmb()	(C)
	 *	STORE $data			LOAD $data
	 *	smp_wmb()	(B)		smp_mb()	(D)
	 *	STORE ->data_head		STORE ->data_tail
	 *   }
	 *
	 * Where A pairs with D, and B pairs with C.
	 *
	 * In our case (A) is a control dependency that separates the load of
	 * the ->data_tail and the stores of $data. In case ->data_tail
	 * indicates there is no room in the buffer to store $data we do not.
	 *
	 * D needs to be a full barrier since it separates the data READ
	 * from the tail WRITE.
	 *
	 * For B a WMB is sufficient since it separates two WRITEs, and for C
	 * an RMB is sufficient since it separates two READs.

Userspace can choose to use smp_load_acquire() over the first smp_rmb()
if that is efficient for the architecture (for w ahole bunch of archs
load-acquire would end up using mb() while rmb() is adequate and
cheaper).
