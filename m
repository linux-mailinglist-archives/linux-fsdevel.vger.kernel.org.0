Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629A843858D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Oct 2021 23:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhJWVqJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Oct 2021 17:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhJWVqI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Oct 2021 17:46:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA70C061714;
        Sat, 23 Oct 2021 14:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bAii4xMZqByIHvMd9gFyirN0kDgMFy2b1hEIBMKHPkw=; b=TgGlE8IG0zsWyBXVCWP20fXK52
        s6nhCeJuFPlKGwPgQkyD/O0DRQkH4S9BUPNvJQVWxmh5uIKfwevIh1WOSY/a30uleOD+oJab/Ks5Q
        yu3Md4zoEDY8XhIe/z1rTlHnqbPlOopnjMxEK858uIbNGhCfJhXQsQJ8tSKaw3xB3f/7ed25NCDud
        CPay5mVfCWAjYj1shy3CRM5BA6YM2M37T8tMyScjYjTDiXdEinwfdxV/aT1pCrPndSI1aK+blUfX1
        yJaqW2Vw+fKKXsCChbTjVVz0Y/ZGED5qNrSRq18WyJAU537dVtslD3LJB3ReBid59wuzg6BlRw6eC
        Mnx6Y71w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1meOlp-00Eu9k-Un; Sat, 23 Oct 2021 21:41:57 +0000
Date:   Sat, 23 Oct 2021 22:41:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YXSBlfLsOi2WzR72@casper.infradead.org>
References: <YW7hQlny+Go1K3LT@cmpxchg.org>
 <YXBUPguecSeSO6UD@moria.home.lan>
 <YXHdpQTL1Udz48fc@cmpxchg.org>
 <YXIZX0truEBv2YSz@casper.infradead.org>
 <326b5796-6ef9-a08f-a671-4da4b04a2b4f@redhat.com>
 <YXK2ICKi6fjNfr4X@casper.infradead.org>
 <c18923a1-8144-785e-5fb3-5cbce4be1310@redhat.com>
 <YXNx686gvsJMgS+z@casper.infradead.org>
 <404bdc05-487f-3d47-6b30-0687b74c2f2f@redhat.com>
 <YXQxptoPALVHHPCU@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXQxptoPALVHHPCU@moria.home.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 23, 2021 at 12:00:38PM -0400, Kent Overstreet wrote:
> I ran into a major roadblock when I tried converting buddy allocator freelists
> to radix trees: freeing a page may require allocating a new page for the radix
> tree freelist, which is fine normally - we're freeing a page after all - but not
> if it's highmem. So right now I'm not sure if getting struct page down to two
> words is even possible. Oh well.

I have a design in mind that I think avoids the problem.  It's somewhat
based on Bonwick's vmem paper, but not exactly.  I need to write it up.

> > Your patches introduce the concept of folio across many layers and your
> > point is to eventually clean up later and eventually remove it from all
> > layers again. I can understand that approach, yet I am at least asking
> > the question if this is the right order to do this.
> > 
> > And again, I am not blocking this, I think cleaning up compound pages is
> > very nice. I'm asking questions to see how the concept of folios would
> > fit in long-term and if it would be required at all if types are done right.
> 
> I'm also not really seeing the need to introduce folios as a replacement for all
> of compound pages, though - I think limiting it to file & anon and using the
> union-of-structs in struct page as the fault lines for introducing new types
> would be the reasonable thing to do. The struct slab patches were great, it's a
> real shame that the slab maintainers have been completely absent.

Right.  Folios are for unspecialised head pages.  If we decide
to specialise further in the future, that's great!  I think David
misunderstood me slightly; I don't know that specialising file + anon
pages (the aforementioned lru_mem) is the right approach.  It might be!
But it needs someone to try it, and find the advantages & disadvantages.

> Also introducing new types to be describing our current using of struct page
> isn't the only thing we should be doing - as we do that, that will (is!) uncover
> a lot of places where our ontology of struct page uses is just nonsensical (all
> the types of pages mapped into userspace!) - and part of our mission should be
> to clean those up.
> 
> That does turn things into a much bigger project than what Matthew signed up
> for, but we shouldn't all be sitting on the sidelines here...

I'm happy to help.  Indeed I may take on some of these sub-projects
myself.  I just don't want the perfect to be the enemy of the good.
