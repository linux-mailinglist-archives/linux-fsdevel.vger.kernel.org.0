Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03173708AB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 23:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjERVqw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 17:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjERVqv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 17:46:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCE318D;
        Thu, 18 May 2023 14:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gvVJOUsKiElhq9zQolbxtMbqOslGBiidrjppFq3b82c=; b=ooaIifHq1X8ltC8yeE5e7hpFS0
        TYcgcCEQYyxDhqN9jCBigeMFFi0Haea2VrD7f01eifBd1Ln9UnOTlcTF+RqH2XnNpujJ+kT/bx+gD
        KfuqxWCvpt57UgstyHlIXFkot71auiYmltqaiizTHED0VJUb7I88Z90yEHjosV6ia++wPgEp4yTWz
        DwIhxzUqOUpcJy9admNuh92YkUPaU87zgesWN5yS6jTTS/UpPRIcr3Q70I+9uZDVJlsgtM8gHlndq
        vQcBYZraDAN2+ORmajInpRKUzfFEFx9BbahUOwiMkHpfan/MDifyiwD3Xjw4ENMhxvHupuUtHELrn
        bDWvBIUg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pzlSN-0065yW-9D; Thu, 18 May 2023 21:46:43 +0000
Date:   Thu, 18 May 2023 22:46:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Creating large folios in iomap buffered write path
Message-ID: <ZGacw+1cu49qnttj@casper.infradead.org>
References: <20230510165055.01D5.409509F4@e16-tech.com>
 <20230511013410.GY3223426@dread.disaster.area>
 <20230517210740.6464.409509F4@e16-tech.com>
 <ZGZwNqYhttjREl0V@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGZwNqYhttjREl0V@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 07:36:38PM +0100, Matthew Wilcox wrote:
> Not so much a "folio problem" as "an enhancement nobody got around to doing
> yet".  Here's a first attempt.  It's still churning through an xfstests
> run for me.  I have seen this warning trigger:
> 
>                 WARN_ON_ONCE(!folio_test_uptodate(folio) &&
>                              folio_test_dirty(folio));
> 
> in iomap_invalidate_folio() as it's now possible to create a folio
> for write that is larger than the write, and therefore we won't
> mark it uptodate.  Maybe we should create slightly smaller folios.

Here's one that does.  A couple of other small problems also fixed.


diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index c739b258a2d9..3702e5e47b0f 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -971,7 +971,7 @@ gfs2_iomap_get_folio(struct iomap_iter *iter, loff_t pos, unsigned len)
 	if (status)
 		return ERR_PTR(status);
 
-	folio = iomap_get_folio(iter, pos);
+	folio = iomap_get_folio(iter, pos, len);
 	if (IS_ERR(folio))
 		gfs2_trans_end(sdp);
 	return folio;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 063133ec77f4..32ddddf9f35c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -461,19 +461,25 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
  * iomap_get_folio - get a folio reference for writing
  * @iter: iteration structure
  * @pos: start offset of write
+ * @len: length of write
  *
  * Returns a locked reference to the folio at @pos, or an error pointer if the
  * folio could not be obtained.
  */
-struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos)
+struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
 {
 	unsigned fgp = FGP_WRITEBEGIN | FGP_NOFS;
+	struct folio *folio;
 
 	if (iter->flags & IOMAP_NOWAIT)
 		fgp |= FGP_NOWAIT;
+	fgp |= fgp_order(len);
 
-	return __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
+	folio = __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
 			fgp, mapping_gfp_mask(iter->inode->i_mapping));
+	if (!IS_ERR(folio) && folio_test_large(folio))
+		printk("index:%lu len:%zu order:%u\n", (unsigned long)(pos / PAGE_SIZE), len, folio_order(folio));
+	return folio;
 }
 EXPORT_SYMBOL_GPL(iomap_get_folio);
 
@@ -510,8 +516,8 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
 		iomap_page_release(folio);
 	} else if (folio_test_large(folio)) {
 		/* Must release the iop so the page can be split */
-		WARN_ON_ONCE(!folio_test_uptodate(folio) &&
-			     folio_test_dirty(folio));
+		VM_WARN_ON_ONCE_FOLIO(!folio_test_uptodate(folio) &&
+				folio_test_dirty(folio), folio);
 		iomap_page_release(folio);
 	}
 }
@@ -603,7 +609,7 @@ static struct folio *__iomap_get_folio(struct iomap_iter *iter, loff_t pos,
 	if (folio_ops && folio_ops->get_folio)
 		return folio_ops->get_folio(iter, pos, len);
 	else
-		return iomap_get_folio(iter, pos);
+		return iomap_get_folio(iter, pos, len);
 }
 
 static void __iomap_put_folio(struct iomap_iter *iter, loff_t pos, size_t ret,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index e2b836c2e119..80facb9c9e5b 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -261,7 +261,7 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
 void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
 bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
-struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos);
+struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len);
 bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
 void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
 int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a56308a9d1a4..f4d05beb64eb 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -466,6 +466,19 @@ static inline void *detach_page_private(struct page *page)
 	return folio_detach_private(page_folio(page));
 }
 
+/*
+ * There are some parts of the kernel which assume that PMD entries
+ * are exactly HPAGE_PMD_ORDER.  Those should be fixed, but until then,
+ * limit the maximum allocation order to PMD size.  I'm not aware of any
+ * assumptions about maximum order if THP are disabled, but 8 seems like
+ * a good order (that's 1MB if you're using 4kB pages)
+ */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
+#else
+#define MAX_PAGECACHE_ORDER	8
+#endif
+
 #ifdef CONFIG_NUMA
 struct folio *filemap_alloc_folio(gfp_t gfp, unsigned int order);
 #else
@@ -505,14 +518,24 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
 #define FGP_NOWAIT		0x00000020
 #define FGP_FOR_MMAP		0x00000040
 #define FGP_STABLE		0x00000080
+#define FGP_ORDER(fgp)		((fgp) >> 26)	/* top 6 bits */
 
 #define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
 
+static inline unsigned fgp_order(size_t size)
+{
+	unsigned int shift = ilog2(size);
+
+	if (shift <= PAGE_SHIFT)
+		return 0;
+	return (shift - PAGE_SHIFT) << 26;
+}
+
 void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
 struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
-		int fgp_flags, gfp_t gfp);
+		unsigned fgp_flags, gfp_t gfp);
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
-		int fgp_flags, gfp_t gfp);
+		unsigned fgp_flags, gfp_t gfp);
 
 /**
  * filemap_get_folio - Find and get a folio.
@@ -586,7 +609,7 @@ static inline struct page *find_get_page(struct address_space *mapping,
 }
 
 static inline struct page *find_get_page_flags(struct address_space *mapping,
-					pgoff_t offset, int fgp_flags)
+					pgoff_t offset, unsigned fgp_flags)
 {
 	return pagecache_get_page(mapping, offset, fgp_flags, 0);
 }
diff --git a/mm/filemap.c b/mm/filemap.c
index b4c9bd368b7e..7abbb072d4d9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1910,7 +1910,7 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
  * Return: The found folio or an ERR_PTR() otherwise.
  */
 struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
-		int fgp_flags, gfp_t gfp)
+		unsigned fgp_flags, gfp_t gfp)
 {
 	struct folio *folio;
 
@@ -1952,7 +1952,9 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		folio_wait_stable(folio);
 no_page:
 	if (!folio && (fgp_flags & FGP_CREAT)) {
+		unsigned order = FGP_ORDER(fgp_flags);
 		int err;
+
 		if ((fgp_flags & FGP_WRITE) && mapping_can_writeback(mapping))
 			gfp |= __GFP_WRITE;
 		if (fgp_flags & FGP_NOFS)
@@ -1961,26 +1963,38 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			gfp &= ~GFP_KERNEL;
 			gfp |= GFP_NOWAIT | __GFP_NOWARN;
 		}
-
-		folio = filemap_alloc_folio(gfp, 0);
-		if (!folio)
-			return ERR_PTR(-ENOMEM);
-
 		if (WARN_ON_ONCE(!(fgp_flags & (FGP_LOCK | FGP_FOR_MMAP))))
 			fgp_flags |= FGP_LOCK;
 
-		/* Init accessed so avoid atomic mark_page_accessed later */
-		if (fgp_flags & FGP_ACCESSED)
-			__folio_set_referenced(folio);
+		if (order > MAX_PAGECACHE_ORDER)
+			order = MAX_PAGECACHE_ORDER;
+		/* If we're not aligned, allocate a smaller folio */
+		if (index & ((1UL << order) - 1))
+			order = __ffs(index);
 
-		err = filemap_add_folio(mapping, folio, index, gfp);
-		if (unlikely(err)) {
+		do {
+			err = -ENOMEM;
+			if (order == 1)
+				order = 0;
+			folio = filemap_alloc_folio(gfp, order);
+			if (!folio)
+				continue;
+
+			/* Init accessed so avoid atomic mark_page_accessed later */
+			if (fgp_flags & FGP_ACCESSED)
+				__folio_set_referenced(folio);
+
+			err = filemap_add_folio(mapping, folio, index, gfp);
+			if (!err)
+				break;
 			folio_put(folio);
 			folio = NULL;
-			if (err == -EEXIST)
-				goto repeat;
-		}
+		} while (order-- > 0);
 
+		if (err == -EEXIST)
+			goto repeat;
+		if (err)
+			return ERR_PTR(err);
 		/*
 		 * filemap_add_folio locks the page, and for mmap
 		 * we expect an unlocked page.
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index c6f056c20503..c96e88d9a262 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -92,7 +92,7 @@ EXPORT_SYMBOL(add_to_page_cache_lru);
 
 noinline
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
-		int fgp_flags, gfp_t gfp)
+		unsigned fgp_flags, gfp_t gfp)
 {
 	struct folio *folio;
 
diff --git a/mm/readahead.c b/mm/readahead.c
index 47afbca1d122..59a071badb90 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -462,19 +462,6 @@ static int try_context_readahead(struct address_space *mapping,
 	return 1;
 }
 
-/*
- * There are some parts of the kernel which assume that PMD entries
- * are exactly HPAGE_PMD_ORDER.  Those should be fixed, but until then,
- * limit the maximum allocation order to PMD size.  I'm not aware of any
- * assumptions about maximum order if THP are disabled, but 8 seems like
- * a good order (that's 1MB if you're using 4kB pages)
- */
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
-#else
-#define MAX_PAGECACHE_ORDER	8
-#endif
-
 static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
 		pgoff_t mark, unsigned int order, gfp_t gfp)
 {
