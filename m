Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBC035064C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 20:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbhCaS3W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 14:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbhCaS3J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:29:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3710C061574;
        Wed, 31 Mar 2021 11:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qYhvdw4avJJTMESp5tkYv8hNlLwk4YC4NiuAbxqOmUI=; b=bQREb+OIGfQRwa5BZwbbhbTPhe
        OMmGr72DRF/ibKkSoMlZxncoj0uKIhhm/cJC2KYCdcW66Tys1ZkVFrQFH9n/X41ZZqx4h0M3Wn5oO
        FDMf9AHknldQgkKoQh3Dk6JCwE1EcVfiehS12lEDh+yo5+ODq1nYG22feVAJG4XO/j0+bo7M8Iprx
        ONxh+YWEVrr8QpBm3Jk2xEFwjPON0nYwrtVKDS+umG/9mapvs5/CpZjN+Cc2pGbeh03rnsGZ+GKlb
        puXhOFfsxdKTZfWcnHZ/JeqFnvY+eRWQUkwW88sszzGW0PBhCLr1+dMf7bMnR/2ptjB3S6Nr+muXs
        Qj02o9/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRfaD-004xa8-Hb; Wed, 31 Mar 2021 18:28:53 +0000
Date:   Wed, 31 Mar 2021 19:28:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v5 00/27] Memory Folios
Message-ID: <20210331182849.GZ351017@casper.infradead.org>
References: <20210320054104.1300774-1-willy@infradead.org>
 <YFja/LRC1NI6quL6@cmpxchg.org>
 <20210322184744.GU1719932@casper.infradead.org>
 <YFqH3B80Gn8pcPqB@cmpxchg.org>
 <20210324062421.GQ1719932@casper.infradead.org>
 <YF4eX/VBPLmontA+@cmpxchg.org>
 <20210329165832.GG351017@casper.infradead.org>
 <YGN8biqigvPP0SGN@cmpxchg.org>
 <20210330210929.GR351017@casper.infradead.org>
 <YGS76CfjNc2jfYQ7@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGS76CfjNc2jfYQ7@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 02:14:00PM -0400, Johannes Weiner wrote:
> Anyway, we digressed quite far here. My argument was simply that it's
> conceivable we'll switch to a default allocation block and page size
> that is larger than the smallest paging size supported by the CPU and
> the kernel. (Various architectures might support multiple page sizes,
> but once you pick one, that's the smallest quantity the kernel pages.)

We've had several attempts in the past to make 'struct page' refer to
a different number of bytes than the-size-of-a-single-pte, and they've
all failed in one way or another.  I don't think changing PAGE_SIZE to
any other size is reasonable.

Maybe we have a larger allocation unit in the future, maybe we do
something else, but that should have its own name, not 'struct page'.
I think the shortest path to getting what you want is having a superpage
allocator that the current page allocator can allocate from.  When a
superpage is allocated from the superpage allocator, we allocate an
array of struct pages for it.

> I don't think folio as an abstraction is cooked enough to replace such
> a major part of the kernel with it. so I'm against merging it now.
> 
> I would really like to see a better definition of what it actually
> represents, instead of a fluid combination of implementation details
> and conveniences.

Here's the current kernel-doc for it:

/**
 * struct folio - Represents a contiguous set of bytes.
 * @flags: Identical to the page flags.
 * @lru: Least Recently Used list; tracks how recently this folio was used.
 * @mapping: The file this page belongs to, or refers to the anon_vma for
 *    anonymous pages.
 * @index: Offset within the file, in units of pages.  For anonymous pages,
 *    this is the index from the beginning of the mmap.
 * @private: Filesystem per-folio data (see attach_folio_private()).
 *    Used for swp_entry_t if FolioSwapCache().
 * @_mapcount: How many times this folio is mapped to userspace.  Use
 *    folio_mapcount() to access it.
 * @_refcount: Number of references to this folio.  Use folio_ref_count()
 *    to read it.
 * @memcg_data: Memory Control Group data.
 *
 * A folio is a physically, virtually and logically contiguous set
 * of bytes.  It is a power-of-two in size, and it is aligned to that
 * same power-of-two.  It is at least as large as %PAGE_SIZE.  If it is
 * in the page cache, it is at a file offset which is a multiple of that
 * power-of-two.
 */
struct folio {
        /* private: don't document the anon union */
        union {
                struct {
        /* public: */
                        unsigned long flags;
                        struct list_head lru;
                        struct address_space *mapping;
                        pgoff_t index;
                        unsigned long private;
                        atomic_t _mapcount;
                        atomic_t _refcount;
#ifdef CONFIG_MEMCG
                        unsigned long memcg_data;
#endif
        /* private: the union with struct page is transitional */
                };
                struct page page;
        };
};

