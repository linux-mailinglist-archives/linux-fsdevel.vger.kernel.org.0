Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E0467F155
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 23:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjA0WpC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 17:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjA0WpB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:45:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45D51C599;
        Fri, 27 Jan 2023 14:44:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63C6A61DCE;
        Fri, 27 Jan 2023 22:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9990EC433EF;
        Fri, 27 Jan 2023 22:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674859498;
        bh=qmaYywhpGfsp/0wQNY9IGdj460P+vOpZmgs1GHbrg50=;
        h=From:To:Cc:Subject:Date:From;
        b=Ww57U6DtV90RKWGcGyvPY0dvlo1Mn679oh+SnXJCEJfpI9TT8rfXn8wp2wpwudo6d
         8q0fzxNDU5GdJUiL60YiKGPPXU5YVS7HMq0lJ9gwaDeUTDKZfGsb5H9+EhQo40ps+3
         dqJixzUj9n0Fxa9ucA0vMqsYsM6FZMVVKCI7y1lBQDAXtLouxLmR1rmBTt4e+Et6dS
         iRx4quz9iBqzi9ymdjzvZC/X7NWCCY5fthOfzD6cWr5aiHyYKB1yt8LMjaJGWNyLVa
         nfhefsSbuOf+zixjbNjO4l/19VKP0kBQb5IyF1M+j/tAAKYKPWn9TxyDHVZ8l8qv6p
         tr8QTrTV10eUQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] fscrypt: support decrypting data from large folios
Date:   Fri, 27 Jan 2023 14:42:02 -0800
Message-Id: <20230127224202.355629-1-ebiggers@kernel.org>
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

Try to make the filesystem-level decryption functions in fs/crypto/
aware of large folios.  This includes making fscrypt_decrypt_bio()
support the case where the bio contains large folios, and making
fscrypt_decrypt_pagecache_blocks() take a folio instead of a page.

There's no way to actually test this with large folios yet, but I've
tested that this doesn't cause any regressions.

Note that this patch just handles *decryption*, not encryption which
will be a little more difficult.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/fscrypt.rst |  4 ++--
 fs/buffer.c                           |  4 ++--
 fs/crypto/bio.c                       | 10 ++++------
 fs/crypto/crypto.c                    | 28 ++++++++++++++-------------
 fs/ext4/inode.c                       |  6 ++++--
 include/linux/fscrypt.h               |  9 ++++-----
 6 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index ef183387da208..eccd327e6df50 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1277,8 +1277,8 @@ the file contents themselves, as described below:
 
 For the read path (->read_folio()) of regular files, filesystems can
 read the ciphertext into the page cache and decrypt it in-place.  The
-page lock must be held until decryption has finished, to prevent the
-page from becoming visible to userspace prematurely.
+folio lock must be held until decryption has finished, to prevent the
+folio from becoming visible to userspace prematurely.
 
 For the write path (->writepage()) of regular files, filesystems
 cannot encrypt data in-place in the page cache, since the cached
diff --git a/fs/buffer.c b/fs/buffer.c
index d9c6d1fbb6dde..4e7f169acb2ca 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -307,8 +307,8 @@ static void decrypt_bh(struct work_struct *work)
 	struct buffer_head *bh = ctx->bh;
 	int err;
 
-	err = fscrypt_decrypt_pagecache_blocks(bh->b_page, bh->b_size,
-					       bh_offset(bh));
+	err = fscrypt_decrypt_pagecache_blocks(page_folio(bh->b_page),
+					       bh->b_size, bh_offset(bh));
 	end_buffer_async_read(bh, err == 0);
 	kfree(ctx);
 }
diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 1b4403136d05c..d57d0a020f71c 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -30,13 +30,11 @@
  */
 bool fscrypt_decrypt_bio(struct bio *bio)
 {
-	struct bio_vec *bv;
-	struct bvec_iter_all iter_all;
+	struct folio_iter fi;
 
-	bio_for_each_segment_all(bv, bio, iter_all) {
-		struct page *page = bv->bv_page;
-		int err = fscrypt_decrypt_pagecache_blocks(page, bv->bv_len,
-							   bv->bv_offset);
+	bio_for_each_folio_all(fi, bio) {
+		int err = fscrypt_decrypt_pagecache_blocks(fi.folio, fi.length,
+							   fi.offset);
 
 		if (err) {
 			bio->bi_status = errno_to_blk_status(err);
diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index e78be66bbf015..bf642479269a5 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -237,41 +237,43 @@ EXPORT_SYMBOL(fscrypt_encrypt_block_inplace);
 
 /**
  * fscrypt_decrypt_pagecache_blocks() - Decrypt filesystem blocks in a
- *					pagecache page
- * @page:      The locked pagecache page containing the block(s) to decrypt
+ *					pagecache folio
+ * @folio:     The locked pagecache folio containing the block(s) to decrypt
  * @len:       Total size of the block(s) to decrypt.  Must be a nonzero
  *		multiple of the filesystem's block size.
- * @offs:      Byte offset within @page of the first block to decrypt.  Must be
+ * @offs:      Byte offset within @folio of the first block to decrypt.  Must be
  *		a multiple of the filesystem's block size.
  *
- * The specified block(s) are decrypted in-place within the pagecache page,
- * which must still be locked and not uptodate.  Normally, blocksize ==
- * PAGE_SIZE and the whole page is decrypted at once.
+ * The specified block(s) are decrypted in-place within the pagecache folio,
+ * which must still be locked and not uptodate.
  *
  * This is for use by the filesystem's ->readahead() method.
  *
  * Return: 0 on success; -errno on failure
  */
-int fscrypt_decrypt_pagecache_blocks(struct page *page, unsigned int len,
-				     unsigned int offs)
+int fscrypt_decrypt_pagecache_blocks(struct folio *folio, size_t len,
+				     size_t offs)
 {
-	const struct inode *inode = page->mapping->host;
+	const struct inode *inode = folio->mapping->host;
 	const unsigned int blockbits = inode->i_blkbits;
 	const unsigned int blocksize = 1 << blockbits;
-	u64 lblk_num = ((u64)page->index << (PAGE_SHIFT - blockbits)) +
+	u64 lblk_num = ((u64)folio->index << (PAGE_SHIFT - blockbits)) +
 		       (offs >> blockbits);
-	unsigned int i;
+	size_t i;
 	int err;
 
-	if (WARN_ON_ONCE(!PageLocked(page)))
+	if (WARN_ON_ONCE(!folio_test_locked(folio)))
 		return -EINVAL;
 
 	if (WARN_ON_ONCE(len <= 0 || !IS_ALIGNED(len | offs, blocksize)))
 		return -EINVAL;
 
 	for (i = offs; i < offs + len; i += blocksize, lblk_num++) {
+		struct page *page = folio_page(folio, i >> PAGE_SHIFT);
+
 		err = fscrypt_crypt_block(inode, FS_DECRYPT, lblk_num, page,
-					  page, blocksize, i, GFP_NOFS);
+					  page, blocksize, i & ~PAGE_MASK,
+					  GFP_NOFS);
 		if (err)
 			return err;
 	}
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9d9f414f99fec..0fe1b746fe864 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1136,7 +1136,8 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
 		for (i = 0; i < nr_wait; i++) {
 			int err2;
 
-			err2 = fscrypt_decrypt_pagecache_blocks(page, blocksize,
+			err2 = fscrypt_decrypt_pagecache_blocks(page_folio(page),
+								blocksize,
 								bh_offset(wait[i]));
 			if (err2) {
 				clear_buffer_uptodate(wait[i]);
@@ -3858,7 +3859,8 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 		if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
 			/* We expect the key to be set. */
 			BUG_ON(!fscrypt_has_encryption_key(inode));
-			err = fscrypt_decrypt_pagecache_blocks(page, blocksize,
+			err = fscrypt_decrypt_pagecache_blocks(page_folio(page),
+							       blocksize,
 							       bh_offset(bh));
 			if (err) {
 				clear_buffer_uptodate(bh);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 4f5f8a6512132..433504422d02d 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -257,8 +257,8 @@ int fscrypt_encrypt_block_inplace(const struct inode *inode, struct page *page,
 				  unsigned int len, unsigned int offs,
 				  u64 lblk_num, gfp_t gfp_flags);
 
-int fscrypt_decrypt_pagecache_blocks(struct page *page, unsigned int len,
-				     unsigned int offs);
+int fscrypt_decrypt_pagecache_blocks(struct folio *folio, size_t len,
+				     size_t offs);
 int fscrypt_decrypt_block_inplace(const struct inode *inode, struct page *page,
 				  unsigned int len, unsigned int offs,
 				  u64 lblk_num);
@@ -422,9 +422,8 @@ static inline int fscrypt_encrypt_block_inplace(const struct inode *inode,
 	return -EOPNOTSUPP;
 }
 
-static inline int fscrypt_decrypt_pagecache_blocks(struct page *page,
-						   unsigned int len,
-						   unsigned int offs)
+static inline int fscrypt_decrypt_pagecache_blocks(struct folio *folio,
+						   size_t len, size_t offs)
 {
 	return -EOPNOTSUPP;
 }

base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
-- 
2.39.1

