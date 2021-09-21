Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B411B413B8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 22:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhIUUlw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 16:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhIUUlv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 16:41:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E859DC061574;
        Tue, 21 Sep 2021 13:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GVJlkCVZHRNXzlp5wu6spEzRD7PBCcXgh0lGOQnwm5A=; b=W1tKb5WjUS/ACQUPHSdZb1RSrc
        NgMe8M7KBYZNkOL82B+Dc/CM1NocR8vFQ12l04IpNYY63bsZJDjqAIKR5nt5fa8dEl1F23ZbvhVLU
        hHPxd+Z6FLOH8bGYP3gCe0Abl6n6bcLsYxa03BZNJR2KNAnBsqumj7TWl7DBhpfSQPK1INswyt6M7
        wj8CMMFe4t8meFysy+xU3ldQcdQXGcOy74+pMzepEE23OdhgUAyEDqp1fz/eOnC9N1QyCJK8rJCkv
        3GI/uq3qf47vctHS0CmJheWrdCUz+Y1fVF+IMnrG0ZLPIaWslGm4DpOvJm1ov8ewjG75z3J/orE7m
        UVXkGUZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSmXW-0049bT-IU; Tue, 21 Sep 2021 20:39:14 +0000
Date:   Tue, 21 Sep 2021 21:38:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <YUpC3oV4II+u+lzQ@casper.infradead.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUo20TzAlqz8Tceg@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 21, 2021 at 03:47:29PM -0400, Johannes Weiner wrote:
> This discussion is now about whether folio are suitable for anon pages
> as well. I'd like to reiterate that regardless of the outcome of this
> discussion I think we should probably move ahead with the page cache
> bits, since people are specifically blocked on those and there is no
> dependency on the anon stuff, as the conversion is incremental.

So you withdraw your NAK for the 5.15 pull request which is now four
weeks old and has utterly missed the merge window?

> and so the justification for replacing page with folio *below* those
> entry points to address tailpage confusion becomes nil: there is no
> confusion. Move the anon bits to anon_page and leave the shared bits
> in page. That's 912 lines of swap_state.c we could mostly leave alone.

Your argument seems to be based on "minimising churn".  Which is certainly
a goal that one could have, but I think in this case is actually harmful.
There are hundreds, maybe thousands, of functions throughout the kernel
(certainly throughout filesystems) which assume that a struct page is
PAGE_SIZE bytes.  Yes, every single one of them is buggy to assume that,
but tracking them all down is a never-ending task as new ones will be
added as fast as they can be removed.

> The same is true for the LRU code in swap.c. Conceptually, already no
> tailpages *should* make it onto the LRU. Once the high-level page
> instantiation functions - add_to_page_cache_lru, do_anonymous_page -
> have type safety, you really do not need to worry about tail pages
> deep in the LRU code. 1155 more lines of swap.c.

It's actually impossible in practice as well as conceptually.  The list
LRU is in the union with compound_head, so you cannot put a tail page
onto the LRU.  But yet we call compound_head() on every one of them
multiple times because our current type system does not allow us to
express "this is not a tail page".

> The anon_page->page relationship may look familiar too. It's a natural
> type hierarchy between superclass and subclasses that is common in
> object oriented languages: page has attributes and methods that are
> generic and shared; anon_page and file_page encode where their
> implementation differs.
> 
> A type system like that would set us up for a lot of clarification and
> generalization of the MM code. For example it would immediately
> highlight when "generic" code is trying to access type-specific stuff
> that maybe it shouldn't, and thus help/force us refactor - something
> that a shared, flat folio type would not.

If you want to try your hand at splitting out anon_folio from folio
later, be my guest.  I've just finished splitting out 'slab' from page,
and I'll post it later.  I don't think that splitting anon_folio from
folio is worth doing, but will not stand in your way.  I do think that
splitting tail pages from non-tail pages is worthwhile, and that's what
this patchset does.

