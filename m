Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786253D113D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 16:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238110AbhGUNpg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 09:45:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239491AbhGUNmb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:42:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0EA66121F;
        Wed, 21 Jul 2021 14:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626877343;
        bh=4NTnFEe2l3CAr2NuivBsayg3RBvIVlGjYGI9vT1IRx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SWdacA+swjElFXK4xDg7Y5+tnh9JLsd2jeuI09FuvMfY7Uu72LwA9IBdw95kknr96
         Ob+ppAo/jhfJ9SSpZYKmpufBNfj1ZTdWC19ww9ZjZI78ry7I82EQUDvWdl8TNtUrg9
         KNcNhqlzqpNxhJsTOa3KTSnEWdUpe/Zf/HjqHbr7/kEFphV2T+3BB+MA1G+uUXvCLR
         Kyj1pDCgsSnybQHtv/jdu6dlmbck0jxtFrYQFUJcVNG2HcfDNblVz8TsTAtoBJHDBr
         5xFkROedkpIiHYC7h/TKPww3Jl87DCb1jMPhw8nG3mDCRGxyxPoAu9M4VyUxvp+Vzg
         yn6Uy2lXL/wuQ==
Date:   Wed, 21 Jul 2021 17:22:16 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 054/138] mm: Add kmap_local_folio()
Message-ID: <YPgtmCtE5Xj56+LM@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-55-willy@infradead.org>
 <YPfvwNHk6H9dOCKK@kernel.org>
 <YPgrM9P3CFjkpP5A@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPgrM9P3CFjkpP5A@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 03:12:03PM +0100, Matthew Wilcox wrote:
> On Wed, Jul 21, 2021 at 12:58:24PM +0300, Mike Rapoport wrote:
> > > +/**
> > > + * kmap_local_folio - Map a page in this folio for temporary usage
> > > + * @folio:	The folio to be mapped.
> > > + * @offset:	The byte offset within the folio.
> > > + *
> > > + * Returns: The virtual address of the mapping
> > > + *
> > > + * Can be invoked from any context.
> > 
> > Context: Can be invoked from any context.
> > 
> > > + *
> > > + * Requires careful handling when nesting multiple mappings because the map
> > > + * management is stack based. The unmap has to be in the reverse order of
> > > + * the map operation:
> > > + *
> > > + * addr1 = kmap_local_folio(page1, offset1);
> > > + * addr2 = kmap_local_folio(page2, offset2);
> > 
> > Please s/page/folio/g here and in the description below
> > 
> > > + * ...
> > > + * kunmap_local(addr2);
> > > + * kunmap_local(addr1);
> > > + *
> > > + * Unmapping addr1 before addr2 is invalid and causes malfunction.
> > > + *
> > > + * Contrary to kmap() mappings the mapping is only valid in the context of
> > > + * the caller and cannot be handed to other contexts.
> > > + *
> > > + * On CONFIG_HIGHMEM=n kernels and for low memory pages this returns the
> > > + * virtual address of the direct mapping. Only real highmem pages are
> > > + * temporarily mapped.
> > > + *
> > > + * While it is significantly faster than kmap() for the higmem case it
> > > + * comes with restrictions about the pointer validity. Only use when really
> > > + * necessary.
> > > + *
> > > + * On HIGHMEM enabled systems mapping a highmem page has the side effect of
> > > + * disabling migration in order to keep the virtual address stable across
> > > + * preemption. No caller of kmap_local_folio() can rely on this side effect.
> > > + */
> 
> kmap_local_folio() only maps one page from the folio.  So it's not
> appropriate to s/page/folio/g.  I fiddled with the description a bit to
> make this clearer:
> 
>  /**
>   * kmap_local_folio - Map a page in this folio for temporary usage
> - * @folio:     The folio to be mapped.
> - * @offset:    The byte offset within the folio.
> - *
> - * Returns: The virtual address of the mapping
> - *
> - * Can be invoked from any context.
> + * @folio: The folio containing the page.
> + * @offset: The byte offset within the folio which identifies the page.
>   *
>   * Requires careful handling when nesting multiple mappings because the map
>   * management is stack based. The unmap has to be in the reverse order of
>   * the map operation:
>   *
> - * addr1 = kmap_local_folio(page1, offset1);
> - * addr2 = kmap_local_folio(page2, offset2);
> + * addr1 = kmap_local_folio(folio1, offset1);
> + * addr2 = kmap_local_folio(folio2, offset2);
>   * ...
>   * kunmap_local(addr2);
>   * kunmap_local(addr1);
> @@ -131,6 +127,9 @@ static inline void *kmap_local_page(struct page *page);
>   * On HIGHMEM enabled systems mapping a highmem page has the side effect of
>   * disabling migration in order to keep the virtual address stable across
>   * preemption. No caller of kmap_local_folio() can rely on this side effect.
> + *
> + * Context: Can be invoked from any context.
> + * Return: The virtual address of @offset.
>   */
>  static inline void *kmap_local_folio(struct folio *folio, size_t offset)

This is clearer, thanks! 

Maybe just add page to Return: description:

* Return: The virtual address of page @offset.

-- 
Sincerely yours,
Mike.
