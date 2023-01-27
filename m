Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062CB67F103
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 23:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjA0WPw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 17:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjA0WPv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:15:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2348661D
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jan 2023 14:15:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B2E061CC5
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jan 2023 22:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6422C433EF;
        Fri, 27 Jan 2023 22:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674857746;
        bh=nby6qwkp63ZY6a1Um6aeO+ZU/IqyXTEx5svGq8gIjQ4=;
        h=From:To:Cc:Subject:Date:From;
        b=cCD6JPF/4WV7GFZZ6rXaKk9s7/V1xRfpE5AdOmyP4l0xe15qqZGq0GXBxtRfXbNAM
         +H2DflV/hlqP86yEyj8e9mdHJMHUh4jlGzNcQ1Bk1KdM7bhYIN7dyCgP5/oLPhoX3p
         fvvxRAIOoZ7xsiDjIzuUkITgiP6CcjGYegjIRS79UHxpKKnN2sE1isaPNRDiTSEeTo
         NWQrYFeIe44l14ZIUNLThgdhOzmqxOjRtj55xXB9W4wgDgW83jK58U78yNxlgVv8OW
         tijPEpblKi5+93y923mDB1qSUIImyGALMEIGbj4CbB4tJ9g+DGXdLQSpIYzutvHOVV
         cw22AJlglyrnw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     fsverity@lists.linux.dev
Cc:     linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] fsverity: support verifying data from large folios
Date:   Fri, 27 Jan 2023 14:15:29 -0800
Message-Id: <20230127221529.299560-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Try to make fs/verity/verify.c aware of large folios.  This includes
making fsverity_verify_bio() support the case where the bio contains
large folios, and adding a function fsverity_verify_folio() which is the
equivalent of fsverity_verify_page().

There's no way to actually test this with large folios yet, but I've
tested that this doesn't cause any regressions.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---

This patch is targeting 6.3, and it applies to
https://git.kernel.org/pub/scm/fs/fsverity/linux.git/log/?h=for-next
Note: to avoid a cross-tree dependency, in fs/buffer.c I used
page_folio(bh->b_page) instead of bh->b_folio.

 Documentation/filesystems/fsverity.rst | 20 ++++++------
 fs/buffer.c                            |  3 +-
 fs/verity/verify.c                     | 43 +++++++++++++-------------
 include/linux/fsverity.h               | 15 ++++++---
 4 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index 2d9ef906aa2a3..ede672dedf110 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -568,22 +568,22 @@ Pagecache
 ~~~~~~~~~
 
 For filesystems using Linux's pagecache, the ``->read_folio()`` and
-``->readahead()`` methods must be modified to verify pages before they
-are marked Uptodate.  Merely hooking ``->read_iter()`` would be
+``->readahead()`` methods must be modified to verify folios before
+they are marked Uptodate.  Merely hooking ``->read_iter()`` would be
 insufficient, since ``->read_iter()`` is not used for memory maps.
 
 Therefore, fs/verity/ provides the function fsverity_verify_blocks()
 which verifies data that has been read into the pagecache of a verity
-inode.  The containing page must still be locked and not Uptodate, so
+inode.  The containing folio must still be locked and not Uptodate, so
 it's not yet readable by userspace.  As needed to do the verification,
 fsverity_verify_blocks() will call back into the filesystem to read
 hash blocks via fsverity_operations::read_merkle_tree_page().
 
 fsverity_verify_blocks() returns false if verification failed; in this
-case, the filesystem must not set the page Uptodate.  Following this,
+case, the filesystem must not set the folio Uptodate.  Following this,
 as per the usual Linux pagecache behavior, attempts by userspace to
-read() from the part of the file containing the page will fail with
-EIO, and accesses to the page within a memory map will raise SIGBUS.
+read() from the part of the file containing the folio will fail with
+EIO, and accesses to the folio within a memory map will raise SIGBUS.
 
 In principle, verifying a data block requires verifying the entire
 path in the Merkle tree from the data block to the root hash.
@@ -624,8 +624,8 @@ each bio and store it in ``->bi_private``::
 verity, or both is enabled.  After the bio completes, for each needed
 postprocessing step the filesystem enqueues the bio_post_read_ctx on a
 workqueue, and then the workqueue work does the decryption or
-verification.  Finally, pages where no decryption or verity error
-occurred are marked Uptodate, and the pages are unlocked.
+verification.  Finally, folios where no decryption or verity error
+occurred are marked Uptodate, and the folios are unlocked.
 
 On many filesystems, files can contain holes.  Normally,
 ``->readahead()`` simply zeroes hole blocks and considers the
@@ -791,9 +791,9 @@ weren't already directly answered in other parts of this document.
 :A: There are many reasons why this is not possible or would be very
     difficult, including the following:
 
-    - To prevent bypassing verification, pages must not be marked
+    - To prevent bypassing verification, folios must not be marked
       Uptodate until they've been verified.  Currently, each
-      filesystem is responsible for marking pages Uptodate via
+      filesystem is responsible for marking folios Uptodate via
       ``->readahead()``.  Therefore, currently it's not possible for
       the VFS to do the verification on its own.  Changing this would
       require significant changes to the VFS and all filesystems.
diff --git a/fs/buffer.c b/fs/buffer.c
index 2e65ba2b3919b..8499c79ae13d4 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -308,7 +308,8 @@ static void verify_bh(struct work_struct *work)
 	struct buffer_head *bh = ctx->bh;
 	bool valid;
 
-	valid = fsverity_verify_blocks(bh->b_page, bh->b_size, bh_offset(bh));
+	valid = fsverity_verify_blocks(page_folio(bh->b_page), bh->b_size,
+				       bh_offset(bh));
 	end_buffer_async_read(bh, valid);
 	kfree(ctx);
 }
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index e59ef9d0e21cf..f50e3b5b52c93 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -266,20 +266,23 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 
 static bool
 verify_data_blocks(struct inode *inode, struct fsverity_info *vi,
-		   struct ahash_request *req, struct page *data_page,
-		   unsigned int len, unsigned int offset,
-		   unsigned long max_ra_pages)
+		   struct ahash_request *req, struct folio *data_folio,
+		   size_t len, size_t offset, unsigned long max_ra_pages)
 {
 	const unsigned int block_size = vi->tree_params.block_size;
-	u64 pos = (u64)data_page->index << PAGE_SHIFT;
+	u64 pos = (u64)data_folio->index << PAGE_SHIFT;
 
 	if (WARN_ON_ONCE(len <= 0 || !IS_ALIGNED(len | offset, block_size)))
 		return false;
-	if (WARN_ON_ONCE(!PageLocked(data_page) || PageUptodate(data_page)))
+	if (WARN_ON_ONCE(!folio_test_locked(data_folio) ||
+			 folio_test_uptodate(data_folio)))
 		return false;
 	do {
-		if (!verify_data_block(inode, vi, req, data_page,
-				       pos + offset, offset, max_ra_pages))
+		struct page *data_page =
+			folio_page(data_folio, offset >> PAGE_SHIFT);
+
+		if (!verify_data_block(inode, vi, req, data_page, pos + offset,
+				       offset & ~PAGE_MASK, max_ra_pages))
 			return false;
 		offset += block_size;
 		len -= block_size;
@@ -288,21 +291,20 @@ verify_data_blocks(struct inode *inode, struct fsverity_info *vi,
 }
 
 /**
- * fsverity_verify_blocks() - verify data in a page
- * @page: the page containing the data to verify
- * @len: the length of the data to verify in the page
- * @offset: the offset of the data to verify in the page
+ * fsverity_verify_blocks() - verify data in a folio
+ * @folio: the folio containing the data to verify
+ * @len: the length of the data to verify in the folio
+ * @offset: the offset of the data to verify in the folio
  *
  * Verify data that has just been read from a verity file.  The data must be
- * located in a pagecache page that is still locked and not yet uptodate.  The
+ * located in a pagecache folio that is still locked and not yet uptodate.  The
  * length and offset of the data must be Merkle tree block size aligned.
  *
  * Return: %true if the data is valid, else %false.
  */
-bool fsverity_verify_blocks(struct page *page, unsigned int len,
-			    unsigned int offset)
+bool fsverity_verify_blocks(struct folio *folio, size_t len, size_t offset)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct fsverity_info *vi = inode->i_verity_info;
 	struct ahash_request *req;
 	bool valid;
@@ -310,7 +312,7 @@ bool fsverity_verify_blocks(struct page *page, unsigned int len,
 	/* This allocation never fails, since it's mempool-backed. */
 	req = fsverity_alloc_hash_request(vi->tree_params.hash_alg, GFP_NOFS);
 
-	valid = verify_data_blocks(inode, vi, req, page, len, offset, 0);
+	valid = verify_data_blocks(inode, vi, req, folio, len, offset, 0);
 
 	fsverity_free_hash_request(vi->tree_params.hash_alg, req);
 
@@ -338,8 +340,7 @@ void fsverity_verify_bio(struct bio *bio)
 	struct inode *inode = bio_first_page_all(bio)->mapping->host;
 	struct fsverity_info *vi = inode->i_verity_info;
 	struct ahash_request *req;
-	struct bio_vec *bv;
-	struct bvec_iter_all iter_all;
+	struct folio_iter fi;
 	unsigned long max_ra_pages = 0;
 
 	/* This allocation never fails, since it's mempool-backed. */
@@ -358,9 +359,9 @@ void fsverity_verify_bio(struct bio *bio)
 		max_ra_pages = bio->bi_iter.bi_size >> (PAGE_SHIFT + 2);
 	}
 
-	bio_for_each_segment_all(bv, bio, iter_all) {
-		if (!verify_data_blocks(inode, vi, req, bv->bv_page, bv->bv_len,
-					bv->bv_offset, max_ra_pages)) {
+	bio_for_each_folio_all(fi, bio) {
+		if (!verify_data_blocks(inode, vi, req, fi.folio, fi.length,
+					fi.offset, max_ra_pages)) {
 			bio->bi_status = BLK_STS_IOERR;
 			break;
 		}
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 991a444589966..119a3266791fd 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -12,6 +12,7 @@
 #define _LINUX_FSVERITY_H
 
 #include <linux/fs.h>
+#include <linux/mm.h>
 #include <crypto/hash_info.h>
 #include <crypto/sha2.h>
 #include <uapi/linux/fsverity.h>
@@ -169,8 +170,7 @@ int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg);
 
 /* verify.c */
 
-bool fsverity_verify_blocks(struct page *page, unsigned int len,
-			    unsigned int offset);
+bool fsverity_verify_blocks(struct folio *folio, size_t len, size_t offset);
 void fsverity_verify_bio(struct bio *bio);
 void fsverity_enqueue_verify_work(struct work_struct *work);
 
@@ -230,8 +230,8 @@ static inline int fsverity_ioctl_read_metadata(struct file *filp,
 
 /* verify.c */
 
-static inline bool fsverity_verify_blocks(struct page *page, unsigned int len,
-					  unsigned int offset)
+static inline bool fsverity_verify_blocks(struct folio *folio, size_t len,
+					  size_t offset)
 {
 	WARN_ON(1);
 	return false;
@@ -249,9 +249,14 @@ static inline void fsverity_enqueue_verify_work(struct work_struct *work)
 
 #endif	/* !CONFIG_FS_VERITY */
 
+static inline bool fsverity_verify_folio(struct folio *folio)
+{
+	return fsverity_verify_blocks(folio, folio_size(folio), 0);
+}
+
 static inline bool fsverity_verify_page(struct page *page)
 {
-	return fsverity_verify_blocks(page, PAGE_SIZE, 0);
+	return fsverity_verify_blocks(page_folio(page), PAGE_SIZE, 0);
 }
 
 /**

base-commit: 245edf445c3421584f541307cd7a8cd847c3d8d7
-- 
2.39.1

