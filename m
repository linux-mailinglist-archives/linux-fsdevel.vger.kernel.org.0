Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B6B118FDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 19:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfLJSgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 13:36:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:42214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727633AbfLJSgw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:36:52 -0500
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A67E20663;
        Tue, 10 Dec 2019 18:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576003011;
        bh=CgasdbtH3xcl2z0h0Kpxvo4k9RsFdfEY7tZI8ubO6AQ=;
        h=From:To:Cc:Subject:Date:From;
        b=ts1eFIaCmEokD3v+0sQE0NtgVgt/X5zZLcd9pI3yGGnUswABOG3RZYDVAbecNOLmx
         3kGiziH/g0I4/WoG7RleYTRs+8LdQoKhgnbU8RFJGDxY/4tF5zocNPLn+9P7AmUMNS
         ujUUOLf7E+IUcjSx3Vdv3wideomXuC3rtn0EvyTQ=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        Victor Hsieh <victorhsieh@google.com>
Subject: [PATCH v2] fs-verity: implement readahead for FS_IOC_ENABLE_VERITY
Date:   Tue, 10 Dec 2019 10:35:31 -0800
Message-Id: <20191210183531.179836-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
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

Changed v1 => v2:
- Only do sync readahead when the page wasn't found in the pagecache at all.
- Use ->f_mapping so that the inode doesn't have to be passed.


 fs/verity/enable.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index eabc6ac199064..60e74dc9c242a 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -13,13 +13,42 @@
 #include <linux/sched/signal.h>
 #include <linux/uaccess.h>
 
-static int build_merkle_tree_level(struct inode *inode, unsigned int level,
+/*
+ * Read a file data page for Merkle tree construction.  Do aggressive readahead,
+ * since we're sequentially reading the entire file.
+ */
+static struct page *read_file_data_page(struct file *filp, pgoff_t index,
+					struct file_ra_state *ra,
+					unsigned long remaining_pages)
+{
+	struct page *page;
+
+	page = find_get_page(filp->f_mapping, index);
+	if (!page || !PageUptodate(page)) {
+		if (page)
+			put_page(page);
+		else
+			page_cache_sync_readahead(filp->f_mapping, ra, filp,
+						  index, remaining_pages);
+		page = read_mapping_page(filp->f_mapping, index, NULL);
+		if (IS_ERR(page))
+			return page;
+	}
+	if (PageReadahead(page))
+		page_cache_async_readahead(filp->f_mapping, ra, filp, page,
+					   index, remaining_pages);
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
+	struct file_ra_state ra = { 0 };
 	unsigned int pending_size = 0;
 	u64 dst_block_num;
 	u64 i;
@@ -36,6 +65,8 @@ static int build_merkle_tree_level(struct inode *inode, unsigned int level,
 		dst_block_num = 0; /* unused */
 	}
 
+	file_ra_state_init(&ra, filp->f_mapping);
+
 	for (i = 0; i < num_blocks_to_hash; i++) {
 		struct page *src_page;
 
@@ -45,7 +76,8 @@ static int build_merkle_tree_level(struct inode *inode, unsigned int level,
 
 		if (level == 0) {
 			/* Leaf: hashing a data block */
-			src_page = read_mapping_page(inode->i_mapping, i, NULL);
+			src_page = read_file_data_page(filp, i, &ra,
+						       num_blocks_to_hash - i);
 			if (IS_ERR(src_page)) {
 				err = PTR_ERR(src_page);
 				fsverity_err(inode,
@@ -103,17 +135,18 @@ static int build_merkle_tree_level(struct inode *inode, unsigned int level,
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
@@ -139,7 +172,7 @@ static int build_merkle_tree(struct inode *inode,
 	blocks = (inode->i_size + params->block_size - 1) >>
 		 params->log_blocksize;
 	for (level = 0; level <= params->num_levels; level++) {
-		err = build_merkle_tree_level(inode, level, blocks, params,
+		err = build_merkle_tree_level(filp, level, blocks, params,
 					      pending_hashes, req);
 		if (err)
 			goto out;
@@ -227,7 +260,7 @@ static int enable_verity(struct file *filp,
 	 */
 	pr_debug("Building Merkle tree...\n");
 	BUILD_BUG_ON(sizeof(desc->root_hash) < FS_VERITY_MAX_DIGEST_SIZE);
-	err = build_merkle_tree(inode, &params, desc->root_hash);
+	err = build_merkle_tree(filp, &params, desc->root_hash);
 	if (err) {
 		fsverity_err(inode, "Error %d building Merkle tree", err);
 		goto rollback;
-- 
2.24.0.525.g8f36a354ae-goog

