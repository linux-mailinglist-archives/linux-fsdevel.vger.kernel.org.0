Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7FF419DD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 20:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbhI0SIt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 14:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbhI0SIs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:08:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C9DC061575;
        Mon, 27 Sep 2021 11:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KIiyuFcQAjPzsk642oitN3a7sbbUrS6ZmU/9sdezjAU=; b=UDzuHesmpTLHLvrdN4ldNTBtHt
        9j9vJ5YaXpkIqvR31CxwzuMi54is5yAHiA8wdIeOIjjutLmmUGSapiJarbT88qB1XATx0/kE38KLE
        H3PZOEsCvA5WDbbZid7vlVZpD+UmFqjsFdQSEGBEPt5vZRRDVxYtAWYtUo5opRDWFiVHKVV+yqGvG
        nuBvrSh0fWwIyLAFyMgb/r090kLxIHtRohmPR70tkynQKEKi6XghCgnnGBSUg2ISPPezgEyRQHz1x
        pjhaj3iTMGLs28BwfSdjyJTq/p7tU+vKa+YSeMEgDLLMiZ/NN1c75akHC2JzmSRdZn/1h8XLHdg1t
        mMa252cA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUv0I-00A3WT-Kh; Mon, 27 Sep 2021 18:05:35 +0000
Date:   Mon, 27 Sep 2021 19:05:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Struct page proposal
Message-ID: <YVIH5j5xkPafvNds@casper.infradead.org>
References: <YUvWm6G16+ib+Wnb@moria.home.lan>
 <bc22b4d0-ba63-4559-88d9-a510da233cad@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc22b4d0-ba63-4559-88d9-a510da233cad@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 07:48:15PM +0200, Vlastimil Babka wrote:
> On 9/23/21 03:21, Kent Overstreet wrote:
> > So if we have this:
> > 
> > struct page {
> > 	unsigned long	allocator;
> > 	unsigned long	allocatee;
> > };
> > 
> > The allocator field would be used for either a pointer to slab/slub's state, if
> > it's a slab page, or if it's a buddy allocator page it'd encode the order of the
> > allocation - like compound order today, and probably whether or not the
> > (compound group of) pages is free.
> 
> The "free page in buddy allocator" case will be interesting to implement.
> What the buddy allocator uses today is:
> 
> - PageBuddy - determine if page is free; a page_type (part of mapcount
> field) today, could be a bit in "allocator" field that would have to be 0 in
> all other "page is allocated" contexts.
> - nid/zid - to prevent merging accross node/zone boundaries, now part of
> page flags
> - buddy order
> - a list_head (reusing the "lru") to hold the struct page on the appropriate
> free list, which has to be double-linked so page can be taken from the
> middle of the list instantly
> 
> Won't be easy to cram all that into two unsigned long's, or even a single
> one. We should avoid storing anything in the free page itself. Allocating
> some external structures to track free pages is going to have funny
> bootstrap problems. Probably a major redesign would be needed...

Wait, why do we want to avoid using the memory that we're allocating?
