Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4CC66C549
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 17:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjAPQEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 11:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjAPQDn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:03:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1082925E14;
        Mon, 16 Jan 2023 08:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yWMoVbxjqe8C52IYg/jkHrGSHQbIvCeLUDAeg3xtuO0=; b=k2A2EtBHrs2Fa59e/eMYfU6dLQ
        FcznVdepbtgmE4fr6Jh0Ugel8QiZ1EYaV9M8P80FTOJOypBrl5uVaxbrOYXlZmENBJMEuikxVKugH
        29gRTbI5hNnb+dqqWm6FT1RR+nRGB+ZIBnjKouCfwl8MOd7N+nIeQtd8DRyjenTWg4So7dSEPaQAw
        eK8IOpj+Mns+E65GjPTVmTJZ+3rVGQvdTPLgwjfrCdIk8P2Qb9dt4sv6+FkERph0X72zHesoTY0us
        El1fStIhB0NdFqlfLQpwfd5qPWnvwDQsOSwPGnbEdVo5BjUFguJmLX6LRXi8aLSkpedkr59Oho2R0
        7yyUJIKQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHRwP-00BBry-Hb; Mon, 16 Jan 2023 16:02:33 +0000
Date:   Mon, 16 Jan 2023 08:02:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC v6 04/10] iomap: Add iomap_get_folio helper
Message-ID: <Y8V1GarEaTu0ytT0@infradead.org>
References: <20230108194034.1444764-1-agruenba@redhat.com>
 <20230108194034.1444764-5-agruenba@redhat.com>
 <20230109124642.1663842-1-agruenba@redhat.com>
 <Y70l9ZZXpERjPqFT@infradead.org>
 <Y71pWJ0JHwGrJ/iv@casper.infradead.org>
 <Y8QxYjy+4Kjg05rB@magnolia>
 <Y8QyqlAkLyysv8Qd@magnolia>
 <Y8TkmbZfe3L/Yeky@casper.infradead.org>
 <Y8T+Al0aqRcXWzwt@infradead.org>
 <Y8VOjyLW1Q4lbQvS@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8VOjyLW1Q4lbQvS@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 01:18:07PM +0000, Matthew Wilcox wrote:
> Essentially reverting 44835d20b2a0.

Yep.

> Although we retain the merging of
> the lock & get functions via the use of FGP flags.  Let me think about
> it for a day.

Yes.  But looking at the code again I wonder if even that is needed.
Out of the users of FGP_ENTRY / __filemap_get_folio_entry:

 - split_huge_pages_in_file really should not be using it at all,
   given that it checks for xa_is_value and treats that as !folio
 - one doesn't pass FGP_LOCK and could just use filemap_get_entry
 - the othr two are in shmem, so we could move the locking logic
   there (and maybe in future optimize it in the callers)

That would be something like this, although it should be split into
two or three patches:

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 29e1f9e76eb6dd..ecd1ff40a80621 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -504,9 +504,9 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
 #define FGP_NOFS		0x00000010
 #define FGP_NOWAIT		0x00000020
 #define FGP_FOR_MMAP		0x00000040
-#define FGP_ENTRY		0x00000080
-#define FGP_STABLE		0x00000100
+#define FGP_STABLE		0x00000080
 
+void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
 struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		int fgp_flags, gfp_t gfp);
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
diff --git a/mm/filemap.c b/mm/filemap.c
index c4d4ace9cc7003..85bd86c44e14d2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1832,7 +1832,7 @@ EXPORT_SYMBOL(page_cache_prev_miss);
  */
 
 /*
- * mapping_get_entry - Get a page cache entry.
+ * filemap_get_entry - Get a page cache entry.
  * @mapping: the address_space to search
  * @index: The page cache index.
  *
@@ -1843,7 +1843,7 @@ EXPORT_SYMBOL(page_cache_prev_miss);
  *
  * Return: The folio, swap or shadow entry, %NULL if nothing is found.
  */
-static void *mapping_get_entry(struct address_space *mapping, pgoff_t index)
+void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
 	struct folio *folio;
@@ -1887,8 +1887,6 @@ static void *mapping_get_entry(struct address_space *mapping, pgoff_t index)
  *
  * * %FGP_ACCESSED - The folio will be marked accessed.
  * * %FGP_LOCK - The folio is returned locked.
- * * %FGP_ENTRY - If there is a shadow / swap / DAX entry, return it
- *   instead of allocating a new folio to replace it.
  * * %FGP_CREAT - If no page is present then a new page is allocated using
  *   @gfp and added to the page cache and the VM's LRU list.
  *   The page is returned locked and with an increased refcount.
@@ -1913,12 +1911,9 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 	struct folio *folio;
 
 repeat:
-	folio = mapping_get_entry(mapping, index);
-	if (xa_is_value(folio)) {
-		if (fgp_flags & FGP_ENTRY)
-			return folio;
+	folio = filemap_get_entry(mapping, index);
+	if (xa_is_value(folio))
 		folio = NULL;
-	}
 	if (!folio)
 		goto no_page;
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index abe6cfd92ffa0e..b182eb99044e9a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3088,11 +3088,10 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 	mapping = candidate->f_mapping;
 
 	for (index = off_start; index < off_end; index += nr_pages) {
-		struct folio *folio = __filemap_get_folio(mapping, index,
-						FGP_ENTRY, 0);
+		struct folio *folio = filemap_get_folio(mapping, index);
 
 		nr_pages = 1;
-		if (xa_is_value(folio) || !folio)
+		if (!folio)
 			continue;
 
 		if (!folio_test_large(folio))
diff --git a/mm/shmem.c b/mm/shmem.c
index 028675cd97d445..4650192dbcb91b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -880,6 +880,28 @@ void shmem_unlock_mapping(struct address_space *mapping)
 	}
 }
 
+static struct folio *shmem_get_entry(struct address_space *mapping,
+		pgoff_t index)
+{
+	struct folio *folio;
+
+repeat:
+	folio = filemap_get_entry(mapping, index);
+	if (folio && !xa_is_value(folio)) {
+		folio_lock(folio);
+
+		/* Has the page been truncated? */
+		if (unlikely(folio->mapping != mapping)) {
+			folio_unlock(folio);
+			folio_put(folio);
+			goto repeat;
+		}
+		VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio);
+	}
+
+	return folio;
+}
+
 static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
 {
 	struct folio *folio;
@@ -888,8 +910,7 @@ static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
 	 * At first avoid shmem_get_folio(,,,SGP_READ): that fails
 	 * beyond i_size, and reports fallocated pages as holes.
 	 */
-	folio = __filemap_get_folio(inode->i_mapping, index,
-					FGP_ENTRY | FGP_LOCK, 0);
+	folio = shmem_get_entry(inode->i_mapping, index);
 	if (!xa_is_value(folio))
 		return folio;
 	/*
@@ -1860,7 +1881,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	sbinfo = SHMEM_SB(inode->i_sb);
 	charge_mm = vma ? vma->vm_mm : NULL;
 
-	folio = __filemap_get_folio(mapping, index, FGP_ENTRY | FGP_LOCK, 0);
+	folio = shmem_get_entry(mapping, index);
 	if (folio && vma && userfaultfd_minor(vma)) {
 		if (!xa_is_value(folio)) {
 			folio_unlock(folio);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 2927507b43d819..e7f2083ad7e40a 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -384,7 +384,7 @@ struct folio *filemap_get_incore_folio(struct address_space *mapping,
 {
 	swp_entry_t swp;
 	struct swap_info_struct *si;
-	struct folio *folio = __filemap_get_folio(mapping, index, FGP_ENTRY, 0);
+	struct folio *folio = filemap_get_entry(mapping, index);
 
 	if (!xa_is_value(folio))
 		goto out;
