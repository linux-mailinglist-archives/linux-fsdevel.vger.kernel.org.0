Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0FC3D10E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 16:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238615AbhGUNbf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 09:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbhGUNbf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:31:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADA7C061575;
        Wed, 21 Jul 2021 07:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pCqdwefLOL0fhBrx/OBvnT5ccjRgtPGA+iSizhy+8vw=; b=ZIkbTOlnfMdhdbTbZj82Cs/2GN
        c5CiRzbRJ62q+oZagyh6yMQsS0MfMC7fxPfxd6IWOwCHSMGJyvAHCJg1VQeC/KAwdi1W82gK/37Dd
        xrFgudNbSVrauIKc13XQKvvT5ljxlNmLhwMR7edOzu91h19OBXIxTNG0byYiBoTO0OUCod2UPBOCA
        Beib9ruIADNIxQaMzE7EdUh9KjlUDd1EcRxX2DY8Xjfsc+37X4VbwnkscG9Vj85IUInEWjDX9tIyL
        ks9DgKgTtwXLEJ5p5rwSQ1nDcPvdaL4vyfm52ZZVspUUgZD294+/InP9LR5wHpim5/P2pvu1DVCN8
        18hMeDCg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6Cx9-009GeH-Ex; Wed, 21 Jul 2021 14:12:05 +0000
Date:   Wed, 21 Jul 2021 15:12:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 054/138] mm: Add kmap_local_folio()
Message-ID: <YPgrM9P3CFjkpP5A@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-55-willy@infradead.org>
 <YPfvwNHk6H9dOCKK@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPfvwNHk6H9dOCKK@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 12:58:24PM +0300, Mike Rapoport wrote:
> > +/**
> > + * kmap_local_folio - Map a page in this folio for temporary usage
> > + * @folio:	The folio to be mapped.
> > + * @offset:	The byte offset within the folio.
> > + *
> > + * Returns: The virtual address of the mapping
> > + *
> > + * Can be invoked from any context.
> 
> Context: Can be invoked from any context.
> 
> > + *
> > + * Requires careful handling when nesting multiple mappings because the map
> > + * management is stack based. The unmap has to be in the reverse order of
> > + * the map operation:
> > + *
> > + * addr1 = kmap_local_folio(page1, offset1);
> > + * addr2 = kmap_local_folio(page2, offset2);
> 
> Please s/page/folio/g here and in the description below
> 
> > + * ...
> > + * kunmap_local(addr2);
> > + * kunmap_local(addr1);
> > + *
> > + * Unmapping addr1 before addr2 is invalid and causes malfunction.
> > + *
> > + * Contrary to kmap() mappings the mapping is only valid in the context of
> > + * the caller and cannot be handed to other contexts.
> > + *
> > + * On CONFIG_HIGHMEM=n kernels and for low memory pages this returns the
> > + * virtual address of the direct mapping. Only real highmem pages are
> > + * temporarily mapped.
> > + *
> > + * While it is significantly faster than kmap() for the higmem case it
> > + * comes with restrictions about the pointer validity. Only use when really
> > + * necessary.
> > + *
> > + * On HIGHMEM enabled systems mapping a highmem page has the side effect of
> > + * disabling migration in order to keep the virtual address stable across
> > + * preemption. No caller of kmap_local_folio() can rely on this side effect.
> > + */

kmap_local_folio() only maps one page from the folio.  So it's not
appropriate to s/page/folio/g.  I fiddled with the description a bit to
make this clearer:

 /**
  * kmap_local_folio - Map a page in this folio for temporary usage
- * @folio:     The folio to be mapped.
- * @offset:    The byte offset within the folio.
- *
- * Returns: The virtual address of the mapping
- *
- * Can be invoked from any context.
+ * @folio: The folio containing the page.
+ * @offset: The byte offset within the folio which identifies the page.
  *
  * Requires careful handling when nesting multiple mappings because the map
  * management is stack based. The unmap has to be in the reverse order of
  * the map operation:
  *
- * addr1 = kmap_local_folio(page1, offset1);
- * addr2 = kmap_local_folio(page2, offset2);
+ * addr1 = kmap_local_folio(folio1, offset1);
+ * addr2 = kmap_local_folio(folio2, offset2);
  * ...
  * kunmap_local(addr2);
  * kunmap_local(addr1);
@@ -131,6 +127,9 @@ static inline void *kmap_local_page(struct page *page);
  * On HIGHMEM enabled systems mapping a highmem page has the side effect of
  * disabling migration in order to keep the virtual address stable across
  * preemption. No caller of kmap_local_folio() can rely on this side effect.
+ *
+ * Context: Can be invoked from any context.
+ * Return: The virtual address of @offset.
  */
 static inline void *kmap_local_folio(struct folio *folio, size_t offset);


