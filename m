Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E56311051A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 20:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfLCTac (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 14:30:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:33398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfLCTac (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 14:30:32 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BB2020640;
        Tue,  3 Dec 2019 19:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575401430;
        bh=3gyEXfaqpedy6uRB/8VMCVxDlcKhW09vYVAVCCnolyc=;
        h=From:To:Cc:Subject:Date:From;
        b=FgKYpKIkk9MEV83ohzNgDB9G/T4o/iQ9m7o1UFMrbwOfpVwLcE5dD9OHGkoTo2LwO
         PnmEWqfvlFJ7EEGzDeoEmMV/1up/GnGaLng94nHb2TTD2h7CF+SsoBT/rBFnFdPT08
         Bdspll56L0sEIIuHxA4aDIZrtITbN6Fv1Bv4tK0E=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        Victor Hsieh <victorhsieh@google.com>
Subject: [PATCH] fs-verity: implement readahead for FS_IOC_ENABLE_VERITY
Date:   Tue,  3 Dec 2019 11:30:01 -0800
Message-Id: <20191203193001.66906-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

When it builds the first level of the Merkle tree, FS_IOC_ENABLE_VERITY
sequentially reads each page of the file using read_mapping_page().
This works fine if the file's data is already in pagecache, which should
normally be the case, since this ioctl is normally used immediately
after writing out the file.

But in any other case this implementation performs very poorly, since
only one page is read at a time.

Fix this by implementing readahead using the functions from
mm/readahead.c.

This improves performance in the uncached case by about 20x, as seen in
the following benchmarks done on a 250MB file (on x86_64 with SHA-NI):

    FS_IOC_ENABLE_VERITY uncached (before) 3.299s
    FS_IOC_ENABLE_VERITY uncached (after)  0.160s
    FS_IOC_ENABLE_VERITY cached            0.147s
    sha256sum uncached                     0.191s
    sha256sum cached                       0.145s

Note: we could instead switch to kernel_read().  But that would mean
we'd no longer be hashing the data directly from the pagecache, which is
a nice optimization of its own.  And using kernel_read() would require
allocating another temporary buffer, hashing the data and tree pages
separately, and explicitly zero-padding the last page -- so it wouldn't
really be any simpler than direct pagecache access, at least for now.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/enable.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index eabc6ac19906..f7eaffa60196 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -13,14 +13,44 @@
 #include <linux/sched/signal.h>
 #include <linux/uaccess.h>
 
-static int build_merkle_tree_level(struct inode *inode, unsigned int level,
+/*
+ * Read a file data page for Merkle tree construction.  Do aggressive readahead,
+ * since we're sequentially reading the entire file.
+ */
+static struct page *read_file_data_page(struct inode *inode,
+					struct file_ra_state *ra,
+					struct file *filp,
+					pgoff_t index,
+					pgoff_t num_pages_in_file)
+{
+	struct page *page;
+
+	page = find_get_page(inode->i_mapping, index);
+	if (!page || !PageUptodate(page)) {
+		if (page)
+			put_page(page);
+		page_cache_sync_readahead(inode->i_mapping, ra, filp,
+					  index, num_pages_in_file - index);
+		page = read_mapping_page(inode->i_mapping, index, NULL);
+		if (IS_ERR(page))
+			return page;
+	}
+	if (PageReadahead(page))
+		page_cache_async_readahead(inode->i_mapping, ra, filp, page,
+					   index, num_pages_in_file - index);
+	return page;
+}
+
+static int build_merkle_tree_level(struct file *filp, unsigned int level,
 				   u64 num_blocks_to_hash,
 				   const struct merkle_tree_params *params,
 				   u8 *pending_hashes,
 				   struct ahash_request *req)
 {
+	struct inode *inode = file_inode(filp);
 	const struct fsverity_operations *vops = inode->i_sb->s_vop;
 	unsigned int pending_size = 0;
+	struct file_ra_state ra = { 0 };
 	u64 dst_block_num;
 	u64 i;
 	int err;
@@ -36,6 +66,8 @@ static int build_merkle_tree_level(struct inode *inode, unsigned int level,
 		dst_block_num = 0; /* unused */
 	}
 
+	file_ra_state_init(&ra, inode->i_mapping);
+
 	for (i = 0; i < num_blocks_to_hash; i++) {
 		struct page *src_page;
 
@@ -45,7 +77,8 @@ static int build_merkle_tree_level(struct inode *inode, unsigned int level,
 
 		if (level == 0) {
 			/* Leaf: hashing a data block */
-			src_page = read_mapping_page(inode->i_mapping, i, NULL);
+			src_page = read_file_data_page(inode, &ra, filp, i,
+						       num_blocks_to_hash);
 			if (IS_ERR(src_page)) {
 				err = PTR_ERR(src_page);
 				fsverity_err(inode,
@@ -103,17 +136,18 @@ static int build_merkle_tree_level(struct inode *inode, unsigned int level,
 }
 
 /*
- * Build the Merkle tree for the given inode using the given parameters, and
+ * Build the Merkle tree for the given file using the given parameters, and
  * return the root hash in @root_hash.
  *
  * The tree is written to a filesystem-specific location as determined by the
  * ->write_merkle_tree_block() method.  However, the blocks that comprise the
  * tree are the same for all filesystems.
  */
-static int build_merkle_tree(struct inode *inode,
+static int build_merkle_tree(struct file *filp,
 			     const struct merkle_tree_params *params,
 			     u8 *root_hash)
 {
+	struct inode *inode = file_inode(filp);
 	u8 *pending_hashes;
 	struct ahash_request *req;
 	u64 blocks;
@@ -139,7 +173,7 @@ static int build_merkle_tree(struct inode *inode,
 	blocks = (inode->i_size + params->block_size - 1) >>
 		 params->log_blocksize;
 	for (level = 0; level <= params->num_levels; level++) {
-		err = build_merkle_tree_level(inode, level, blocks, params,
+		err = build_merkle_tree_level(filp, level, blocks, params,
 					      pending_hashes, req);
 		if (err)
 			goto out;
@@ -227,7 +261,7 @@ static int enable_verity(struct file *filp,
 	 */
 	pr_debug("Building Merkle tree...\n");
 	BUILD_BUG_ON(sizeof(desc->root_hash) < FS_VERITY_MAX_DIGEST_SIZE);
-	err = build_merkle_tree(inode, &params, desc->root_hash);
+	err = build_merkle_tree(filp, &params, desc->root_hash);
 	if (err) {
 		fsverity_err(inode, "Error %d building Merkle tree", err);
 		goto rollback;
-- 
2.24.0

