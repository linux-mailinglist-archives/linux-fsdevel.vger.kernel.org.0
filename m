Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B46E66B83A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 08:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjAPHel (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 02:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjAPHej (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 02:34:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2089446B1;
        Sun, 15 Jan 2023 23:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v+Y/Qbu9bnR4CAANcDCF/aewkUrEMou8fk9syv0UZ7Y=; b=4sPI06ClLPiTXUKdwwI7mhp/Cx
        tSzz1J7Urf2ntBaI8Hzxz29gPmXdcrNzVk6j29NvOJb+okjveROEH1pXXkNGgE5bxVz0GBzrBl+eA
        sGTprbR9ACupdIrRkTEWCTzIb/UuBeEbLtlfYJ0TcnORmKw9N5PumvpplqfVCSYfmRqBeQyH8IQKm
        feN1yQY6fS68e8oKXmox2KVNFp1zk46N/9E2R8VPwtczW0GW9mmtTWUQIOzeocAjTEfE0PxPJzz5l
        //CwR+RvP5CHiAxAydxOz4QkVdh2+RI26pD918F3lM+qzv5wb4Odkjp/z/+zO7QnP0Sbf3L3AEWQ6
        WuymAxDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHK0g-008zqQ-5p; Mon, 16 Jan 2023 07:34:26 +0000
Date:   Sun, 15 Jan 2023 23:34:26 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC v6 04/10] iomap: Add iomap_get_folio helper
Message-ID: <Y8T+Al0aqRcXWzwt@infradead.org>
References: <20230108213305.GO1971568@dread.disaster.area>
 <20230108194034.1444764-1-agruenba@redhat.com>
 <20230108194034.1444764-5-agruenba@redhat.com>
 <20230109124642.1663842-1-agruenba@redhat.com>
 <Y70l9ZZXpERjPqFT@infradead.org>
 <Y71pWJ0JHwGrJ/iv@casper.infradead.org>
 <Y8QxYjy+4Kjg05rB@magnolia>
 <Y8QyqlAkLyysv8Qd@magnolia>
 <Y8TkmbZfe3L/Yeky@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8TkmbZfe3L/Yeky@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 05:46:01AM +0000, Matthew Wilcox wrote:
> > OFC now I wonder, can we simply say that the return value is "The found
> > folio or NULL if you set FGP_ENTRY; or the found folio or a negative
> > errno if you don't" ?
> 
> Erm ... I would rather not!

Agreed.

> 
> Part of me remembers that x86-64 has the rather nice calling convention
> of being able to return a struct containing two values in two registers:

We could do that.  But while reading what Darrick wrote I came up with
another idea I quite like.  Just split the FGP_ENTRY handling into
a separate helper.  The logic and use cases are quite different from
the normal page cache lookup, and the returning of the xarray entry
is exactly the kind of layering violation that Dave is complaining
about.  So what about just splitting that use case into a separate
self contained helper?

---
From b4d10f98ea57f8480c03c0b00abad6f2b7186f56 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 16 Jan 2023 08:26:57 +0100
Subject: mm: replace FGP_ENTRY with a new __filemap_get_folio_entry helper

Split the xarray entry returning logic into a separate helper.  This will
allow returning ERR_PTRs from __filemap_get_folio, and also isolates the
logic that needs to known about xarray internals into a separate
function.  This causes some code duplication, but as most flags to
__filemap_get_folio are not applicable for the users that care about an
entry that amount is very limited.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/pagemap.h |  6 +++--
 mm/filemap.c            | 50 ++++++++++++++++++++++++++++++++++++-----
 mm/huge_memory.c        |  4 ++--
 mm/shmem.c              |  5 ++---
 mm/swap_state.c         |  2 +-
 5 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 4b3a7124c76712..e06c14b610caf2 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -504,8 +504,7 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
 #define FGP_NOFS		0x00000010
 #define FGP_NOWAIT		0x00000020
 #define FGP_FOR_MMAP		0x00000040
-#define FGP_ENTRY		0x00000080
-#define FGP_STABLE		0x00000100
+#define FGP_STABLE		0x00000080
 
 struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		int fgp_flags, gfp_t gfp);
@@ -546,6 +545,9 @@ static inline struct folio *filemap_lock_folio(struct address_space *mapping,
 	return __filemap_get_folio(mapping, index, FGP_LOCK, 0);
 }
 
+struct folio *__filemap_get_folio_entry(struct address_space *mapping,
+		pgoff_t index, int fgp_flags);
+
 /**
  * find_get_page - find and get a page reference
  * @mapping: the address_space to search
diff --git a/mm/filemap.c b/mm/filemap.c
index c4d4ace9cc7003..d04613347b3e71 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1887,8 +1887,6 @@ static void *mapping_get_entry(struct address_space *mapping, pgoff_t index)
  *
  * * %FGP_ACCESSED - The folio will be marked accessed.
  * * %FGP_LOCK - The folio is returned locked.
- * * %FGP_ENTRY - If there is a shadow / swap / DAX entry, return it
- *   instead of allocating a new folio to replace it.
  * * %FGP_CREAT - If no page is present then a new page is allocated using
  *   @gfp and added to the page cache and the VM's LRU list.
  *   The page is returned locked and with an increased refcount.
@@ -1914,11 +1912,8 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 
 repeat:
 	folio = mapping_get_entry(mapping, index);
-	if (xa_is_value(folio)) {
-		if (fgp_flags & FGP_ENTRY)
-			return folio;
+	if (xa_is_value(folio))
 		folio = NULL;
-	}
 	if (!folio)
 		goto no_page;
 
@@ -1994,6 +1989,49 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 }
 EXPORT_SYMBOL(__filemap_get_folio);
 
+
+/**
+ * __filemap_get_folio_entry - Find and get a reference to a folio.
+ * @mapping: The address_space to search.
+ * @index: The page index.
+ * @fgp_flags: %FGP flags modify how the folio is returned.
+ *
+ * Looks up the page cache entry at @mapping & @index.  If there is a shadow /
+ * swap / DAX entry, return it instead of allocating a new folio to replace it.
+ *
+ * @fgp_flags can be zero or more of these flags:
+ *
+ * * %FGP_LOCK - The folio is returned locked.
+ *
+ * If there is a page cache page, it is returned with an increased refcount.
+ *
+ * Return: The found folio or %NULL otherwise.
+ */
+struct folio *__filemap_get_folio_entry(struct address_space *mapping,
+		pgoff_t index, int fgp_flags)
+{
+	struct folio *folio;
+
+	if (WARN_ON_ONCE(fgp_flags & ~FGP_LOCK))
+		return NULL;
+
+repeat:
+	folio = mapping_get_entry(mapping, index);
+	if (folio && !xa_is_value(folio) && (fgp_flags & FGP_LOCK)) {
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
 static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
 		xa_mark_t mark)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index abe6cfd92ffa0e..88b517c338a6db 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3088,10 +3088,10 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 	mapping = candidate->f_mapping;
 
 	for (index = off_start; index < off_end; index += nr_pages) {
-		struct folio *folio = __filemap_get_folio(mapping, index,
-						FGP_ENTRY, 0);
+		struct folio *folio;
 
 		nr_pages = 1;
+		folio = __filemap_get_folio_entry(mapping, index, 0);
 		if (xa_is_value(folio) || !folio)
 			continue;
 
diff --git a/mm/shmem.c b/mm/shmem.c
index c301487be5fb40..0a36563ef7a0c1 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -888,8 +888,7 @@ static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
 	 * At first avoid shmem_get_folio(,,,SGP_READ): that fails
 	 * beyond i_size, and reports fallocated pages as holes.
 	 */
-	folio = __filemap_get_folio(inode->i_mapping, index,
-					FGP_ENTRY | FGP_LOCK, 0);
+	folio = __filemap_get_folio_entry(inode->i_mapping, index, FGP_LOCK);
 	if (!xa_is_value(folio))
 		return folio;
 	/*
@@ -1860,7 +1859,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	sbinfo = SHMEM_SB(inode->i_sb);
 	charge_mm = vma ? vma->vm_mm : NULL;
 
-	folio = __filemap_get_folio(mapping, index, FGP_ENTRY | FGP_LOCK, 0);
+	folio = __filemap_get_folio_entry(mapping, index, FGP_LOCK);
 	if (folio && vma && userfaultfd_minor(vma)) {
 		if (!xa_is_value(folio)) {
 			folio_unlock(folio);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 2927507b43d819..1f45241987aea2 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -384,7 +384,7 @@ struct folio *filemap_get_incore_folio(struct address_space *mapping,
 {
 	swp_entry_t swp;
 	struct swap_info_struct *si;
-	struct folio *folio = __filemap_get_folio(mapping, index, FGP_ENTRY, 0);
+	struct folio *folio = __filemap_get_folio_entry(mapping, index, 0);
 
 	if (!xa_is_value(folio))
 		goto out;
-- 
2.39.0

