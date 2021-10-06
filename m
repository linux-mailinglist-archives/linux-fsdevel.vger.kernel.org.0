Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DBC424179
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 17:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhJFPmJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 11:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhJFPmJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:42:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148D0C061746
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Oct 2021 08:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NQwTO7FkpLZVbuuUmZZA3meW3NcqE6QyvtCNvwRhmWg=; b=bPwGJgk0NDgedUrWcPFTvyEPex
        jzW2MI4zNKtYBvW8xc+NK5o+O0jBbt3sdJgmZrpYTjAr4JQvTj72H33DR4ws2ySzu4hq/bhgxJXBB
        Qj65gm7+Sd6+Rq6w3WbzLF967Mbr9TMFl6gEIj8zEGkHmgE3SvN2yYhUfYcjo2CA3QVLo54YJxIyh
        oiUySk4nkcMKiRAUifhVoHHCcUi7QGmOp+IaKfUetrpIFSMmWLRnri9uJQjE6dyXHCluqCy+VyITM
        18DZatCjSJBEQtV7Tz8WnvsoPIkzreLfgET2oPeISy9W62jA9b+XlVVrucEdMSNkFYjF6gjvvb+9d
        Qh0TJ2nA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mY90L-00120B-1I; Wed, 06 Oct 2021 15:39:03 +0000
Date:   Wed, 6 Oct 2021 16:38:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] pgflags_t
Message-ID: <YV3DCX92lvOA4fni@casper.infradead.org>
References: <YV25hsgfJ2qAYiRJ@casper.infradead.org>
 <YV2/NZjsmSK6/vlB@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV2/NZjsmSK6/vlB@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 06, 2021 at 03:22:29PM +0000, Al Viro wrote:
> On Wed, Oct 06, 2021 at 03:58:14PM +0100, Matthew Wilcox wrote:
> > David expressed some unease about the lack of typesafety in patches
> > 1 & 2 of the page->slab conversion [1], and I'll admit to not being
> > particularly a fan of passing around an unsigned long.  That crystallised
> > in a discussion with Kent [2] about how to lock a page when you don't know
> > its type (solution: every memory descriptor type starts with a
> > pgflags_t)
> 
> Why bother making it a struct?  What's wrong with __bitwise and letting
> sparse catch conversions?

People don't run sparse.  I happen to have a built allmodconfig tree
here and running make C=2 fs/ gives 1147 lines of warnings.  Why would
adding more warnings help?

