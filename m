Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C953D11D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 17:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239346AbhGUOWb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 10:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239510AbhGUOVr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:21:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76376C061575;
        Wed, 21 Jul 2021 08:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=36rD6Wb6Yd/QwjBFd0xntesjrDvCLO/ZMPTZtTD0QUg=; b=IbAsiplG3kaBoKMtU7f2oPHIkK
        5dlac78FL49HMshsrcmvadPy1WmsH18q106Jpb+Iee7TQCqlyesdsEivr4A+9de5In08wYaD60kV3
        aREeTdRGTpwoQLzIHAe5QO6jzOThu2wCuUF4UCC6eW7w8I2liXJ2Xhr8+VS4ZARCwDf/tZB6K4B32
        /8YoqTPTNIqUuA4wrAQr2sVmliK0aY17e9w6lgoAmB2ymku1YrsbFpqoXB40WHYlzF9Jnxeb4Ri5b
        JfHtjcepGm1lA8OilRECyGF/A460xIrBYxJE7PjPO5zcahBURWNuhONWHRksJUnfoj0aR7uELh3rU
        4c081oQw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6Djb-009JG6-8B; Wed, 21 Jul 2021 15:02:11 +0000
Date:   Wed, 21 Jul 2021 16:02:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 054/138] mm: Add kmap_local_folio()
Message-ID: <YPg2756QFreokTIg@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-55-willy@infradead.org>
 <YPfvwNHk6H9dOCKK@kernel.org>
 <YPgrM9P3CFjkpP5A@casper.infradead.org>
 <YPgtmCtE5Xj56+LM@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPgtmCtE5Xj56+LM@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 05:22:16PM +0300, Mike Rapoport wrote:
> On Wed, Jul 21, 2021 at 03:12:03PM +0100, Matthew Wilcox wrote:
> > On Wed, Jul 21, 2021 at 12:58:24PM +0300, Mike Rapoport wrote:
> > > > +/**
> > > > + * kmap_local_folio - Map a page in this folio for temporary usage
> > > > + * @folio:	The folio to be mapped.
> > > > + * @offset:	The byte offset within the folio.
> > > > + *
> > > > + * Returns: The virtual address of the mapping
> > > > + *
> > > > + * Can be invoked from any context.
> > > 
> > > Context: Can be invoked from any context.
> > > 
> > > > + *
> > > > + * Requires careful handling when nesting multiple mappings because the map
> > > > + * management is stack based. The unmap has to be in the reverse order of
> > > > + * the map operation:
> > > > + *
> > > > + * addr1 = kmap_local_folio(page1, offset1);
> > > > + * addr2 = kmap_local_folio(page2, offset2);
> > > 
> > > Please s/page/folio/g here and in the description below
> > > 
> > > > + * ...
> > > > + * kunmap_local(addr2);
> > > > + * kunmap_local(addr1);
> > > > + *
> > > > + * Unmapping addr1 before addr2 is invalid and causes malfunction.
> > > > + *
> > > > + * Contrary to kmap() mappings the mapping is only valid in the context of
> > > > + * the caller and cannot be handed to other contexts.
> > > > + *
> > > > + * On CONFIG_HIGHMEM=n kernels and for low memory pages this returns the
> > > > + * virtual address of the direct mapping. Only real highmem pages are
> > > > + * temporarily mapped.
> > > > + *
> > > > + * While it is significantly faster than kmap() for the higmem case it
> > > > + * comes with restrictions about the pointer validity. Only use when really
> > > > + * necessary.
> > > > + *
> > > > + * On HIGHMEM enabled systems mapping a highmem page has the side effect of
> > > > + * disabling migration in order to keep the virtual address stable across
> > > > + * preemption. No caller of kmap_local_folio() can rely on this side effect.
> > > > + */
> > 
> > kmap_local_folio() only maps one page from the folio.  So it's not
> > appropriate to s/page/folio/g.  I fiddled with the description a bit to
> > make this clearer:
> > 
> >  /**
> >   * kmap_local_folio - Map a page in this folio for temporary usage
> > - * @folio:     The folio to be mapped.
> > - * @offset:    The byte offset within the folio.
> > - *
> > - * Returns: The virtual address of the mapping
> > - *
> > - * Can be invoked from any context.
> > + * @folio: The folio containing the page.
> > + * @offset: The byte offset within the folio which identifies the page.
> >   *
> >   * Requires careful handling when nesting multiple mappings because the map
> >   * management is stack based. The unmap has to be in the reverse order of
> >   * the map operation:
> >   *
> > - * addr1 = kmap_local_folio(page1, offset1);
> > - * addr2 = kmap_local_folio(page2, offset2);
> > + * addr1 = kmap_local_folio(folio1, offset1);
> > + * addr2 = kmap_local_folio(folio2, offset2);
> >   * ...
> >   * kunmap_local(addr2);
> >   * kunmap_local(addr1);
> > @@ -131,6 +127,9 @@ static inline void *kmap_local_page(struct page *page);
> >   * On HIGHMEM enabled systems mapping a highmem page has the side effect of
> >   * disabling migration in order to keep the virtual address stable across
> >   * preemption. No caller of kmap_local_folio() can rely on this side effect.
> > + *
> > + * Context: Can be invoked from any context.
> > + * Return: The virtual address of @offset.
> >   */
> >  static inline void *kmap_local_folio(struct folio *folio, size_t offset)
> 
> This is clearer, thanks! 
> 
> Maybe just add page to Return: description:
> 
> * Return: The virtual address of page @offset.

No, it really does return the virtual address of @offset.  If you ask
for offset 0x1234 within a (sufficiently large) folio, it will map the
second page of that folio and return the address of the 0x234'th byte
within it.
