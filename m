Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A76615B07E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 20:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgBLTLq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 14:11:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42032 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgBLTLp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 14:11:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Fdj4pjSLaEA0mriWg+9pPCfLYyKsbL26nDUwmXyEzZY=; b=BDKWxixyiR+ivlBsbW/hOT2dnx
        kmmfDKzRELyGIkQTNvQz34ICsJuL0HwBvqXENn0RKUhRNDWn/S8FiU9517p3DRTbcnwkpJfEC2dlB
        sSbJYkZ9PnUKiOXEkTPb1Dn4bb3fp4gtOf3eoSWsWTzrZFDux87hLp4n1RcackMkqQektV8tVOitw
        /tFW4hTg+1K7xbbSNhdy5Ka+FtlMXfIuiMwtLNOCOViJg8f4h1g6xHhcW4XJwcRbBCfzAkVvIfoLO
        9TtVSwyPFGkUqyNWVzC1ThG3bg9tWUlvSnt54FNNXOFp3HS6CnM7bw5pnvH3atoQQR1HJkfeJWdmd
        So7/134g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1xQH-0001lZ-L3; Wed, 12 Feb 2020 19:11:45 +0000
Date:   Wed, 12 Feb 2020 11:11:45 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/25] mm: Fix documentation of FGP flags
Message-ID: <20200212191145.GH7778@bombadil.infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-6-willy@infradead.org>
 <20200212074215.GF7068@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212074215.GF7068@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 11:42:15PM -0800, Christoph Hellwig wrote:
> On Tue, Feb 11, 2020 at 08:18:25PM -0800, Matthew Wilcox wrote:
> > - * @fgp_flags: PCG flags
> > + * @fgp_flags: FGP flags
> >   * @gfp_mask: gfp mask to use for the page cache data page allocation
> >   *
> >   * Looks up the page cache slot at @mapping & @offset.
> >   *
> > - * PCG flags modify how the page is returned.
> > + * FGP flags modify how the page is returned.
> 
> This still looks weird.  Why not just a single line:
> 
> 	* @fgp_flags: FGP_* flags that control how the page is returned.

Well, now you got me reading the entire comment for this function, and
looking at the html output, so I ended up rewriting it entirely.

+++ b/mm/filemap.c
@@ -1574,37 +1574,34 @@ struct page *find_lock_entry(struct address_space *mapping, pgoff_t offset)
 EXPORT_SYMBOL(find_lock_entry);
 
 /**
- * pagecache_get_page - find and get a page reference
- * @mapping: the address_space to search
- * @offset: the page index
- * @fgp_flags: FGP flags
- * @gfp_mask: gfp mask to use for the page cache data page allocation
- *
- * Looks up the page cache slot at @mapping & @offset.
+ * pagecache_get_page - Find and get a reference to a page.
+ * @mapping: The address_space to search.
+ * @offset: The page index.
+ * @fgp_flags: %FGP flags modify how the page is returned.
+ * @gfp_mask: Memory allocation flags to use if %FGP_CREAT is specified.
  *
- * FGP flags modify how the page is returned.
+ * Looks up the page cache entry at @mapping & @offset.
  *
- * @fgp_flags can be:
+ * @fgp_flags can be zero or more of these flags:
  *
- * - FGP_ACCESSED: the page will be marked accessed
- * - FGP_LOCK: Page is return locked
- * - FGP_CREAT: If page is not present then a new page is allocated using
- *   @gfp_mask and added to the page cache and the VM's LRU
- *   list. The page is returned locked and with an increased
- *   refcount.
- * - FGP_FOR_MMAP: Similar to FGP_CREAT, only we want to allow the caller to do
- *   its own locking dance if the page is already in cache, or unlock the page
- *   before returning if we had to add the page to pagecache.
+ * * %FGP_ACCESSED - The page will be marked accessed.
+ * * %FGP_LOCK - The page is returned locked.
+ * * %FGP_CREAT - If no page is present then a new page is allocated using
+ *   @gfp_mask and added to the page cache and the VM's LRU list.
+ *   The page is returned locked and with an increased refcount.
+ * * %FGP_FOR_MMAP - The caller wants to do its own locking dance if the
+ *   page is already in cache.  If the page was allocated, unlock it before
+ *   returning so the caller can do the same dance.
  *
- * If FGP_LOCK or FGP_CREAT are specified then the function may sleep even
- * if the GFP flags specified for FGP_CREAT are atomic.
+ * If %FGP_LOCK or %FGP_CREAT are specified then the function may sleep even
+ * if the %GFP flags specified for %FGP_CREAT are atomic.
  *
  * If there is a page cache page, it is returned with an increased refcount.
  *
- * Return: the found page or %NULL otherwise.
+ * Return: The found page or %NULL otherwise.
  */
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
-       int fgp_flags, gfp_t gfp_mask)
+               int fgp_flags, gfp_t gfp_mask)
 {

