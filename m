Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6632D7CF7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 18:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395286AbgLKReD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 12:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395072AbgLKRdw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 12:33:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33570C0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 09:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PBIrwD1P7M5TNEvEysxG6boHsOMcDdQN593BPQ8Y0dQ=; b=aEoh0RYSgtERt+pIvEOSwE/ZiY
        B6eU4rWxBovW2vkY8to/gYLLRpRaBsdayWU5donmhfytziLGEtjceuIgWw9eZBG6yy3Aub7wV7eQ0
        nKPuSBuI6+Bo84cONLPUjih2Jh6BeKLvnYRjEX0aT5LwXYaO6p+fGhzCZgoVOv8vkYdCgE/sguFH7
        PRAjJ5fShZelvCxq0RmLJ3PTlX9KnO3qQnJHfUnT7iQggIiNQcp8iHHRSrk5mqxL29hgjaGXMRSQe
        FHk4NLtDqVNxmC7saimJewYfmNuWMIPHL3gppAbtEnk6VJShlPf2rKmyUUwiV4UzTZnbtQavutqu2
        +VoDD1+w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knmHy-00072b-2f; Fri, 11 Dec 2020 17:33:06 +0000
Date:   Fri, 11 Dec 2020 17:33:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] fs: add support for LOOKUP_NONBLOCK
Message-ID: <20201211173305.GB2443@casper.infradead.org>
References: <20201210200114.525026-1-axboe@kernel.dk>
 <20201210200114.525026-2-axboe@kernel.dk>
 <CAHk-=wif32e=MvP-rNn9wL9wXinrL1FK6OQ6xPMtuQ2VQTxvqw@mail.gmail.com>
 <139ecda1-bb08-b1f2-655f-eeb9976e8cff@kernel.dk>
 <20201211024553.GW3579531@ZenIV.linux.org.uk>
 <89f96b42-9d58-cd46-e157-758e91269d89@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89f96b42-9d58-cd46-e157-758e91269d89@kernel.dk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 11, 2020 at 09:05:26AM -0700, Jens Axboe wrote:
> On 12/10/20 7:45 PM, Al Viro wrote:
> > So how hard are your "we don't want to block here" requirements?  Because
> > the stuff you do after complete_walk() can easily be much longer than
> > everything else.
> 
> Ideally it'd extend a bit beyond the RCU lookup, as things like proc
> resolution will still fail with the proposed patch. But that's not a
> huge deal to me, I consider the dentry lookup to be Good Enough.

FWIW, /proc/$pid always falls back to REF walks.  Here's a patch from
one of my colleagues that aims to fix that.

https://lore.kernel.org/linux-fsdevel/20201204000212.773032-1-stephen.s.brennan@oracle.com/

Maybe you had one of the other parts of /proc in mind?
