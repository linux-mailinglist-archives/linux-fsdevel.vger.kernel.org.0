Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 495CD4C14F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 21:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbfFSTNd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 15:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfFSTNd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 15:13:33 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6F1721734;
        Wed, 19 Jun 2019 19:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560971611;
        bh=BvrAJo9OP8H3C9s3rVqQqXtsbSqik5cPysGQ9U0pT1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=08NZEZenqJJe78sHdfbDN+CdCUbVKBiiv/0p+GftwaMduJPSTonwbXUAfrdjCxRU7
         SlSqae74VIMz+3fORBk9blnRKpGcIrhuampyn5ptogt4Nd6hH67yP88O0O1mM1OZ7G
         gg+6CLf48Zeh0h4UFBUBpn2aZBacTnTtyMJ5mZ88=
Date:   Wed, 19 Jun 2019 12:13:29 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 14/16] ext4: add basic fs-verity support
Message-ID: <20190619191328.GB33328@gmail.com>
References: <20190606155205.2872-1-ebiggers@kernel.org>
 <20190606155205.2872-15-ebiggers@kernel.org>
 <20190615153112.GO6142@mit.edu>
 <20190618175117.GF184520@gmail.com>
 <20190618224615.GB4576@mit.edu>
 <20190618234133.GL184520@gmail.com>
 <20190619030522.GA28351@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619030522.GA28351@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 18, 2019 at 11:05:22PM -0400, Theodore Ts'o wrote:
> On Tue, Jun 18, 2019 at 04:41:34PM -0700, Eric Biggers wrote:
> > 
> > I don't think your proposed solution is so simple.  By definition the last
> > extent ends on a filesystem block boundary, while the Merkle tree ends on a
> > Merkle tree block boundary.  In the future we might support the case where these
> > differ, so we don't want to preclude that in the on-disk format we choose now.
> > Therefore, just storing the desc_size isn't enough; we'd actually have to store
> > (desc_pos, desc_size), like I'm doing in the xattr.
> 
> I don't think any of this matters much, since what you're describing
> above is all about the Merkle tree, and that doesn't affect how we
> find the fsverity descriptor information.  We can just say that
> fsverity descriptor block begins on the next file system block
> boundary after the Merkle tree.  And in the case where say, the Merkle
> tree is 4k and the file system block size is 64k, that's fine --- the
> fs descriptor would just begin at the next 64k (fs blocksize)
> boundary.
> 

Sure, that works.

I implemented this for ext4 and extents only, and it does work, though it's a
bit more complex than the xattr solution -- about 70 extra lines of code
including comments.  See diff for fs/ext4/verity.c below.

But we can go with it if you think it's worthwhile to avoid using xattrs at all.

diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index 6333b9dd2dff2a..9ae89489f01bf3 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -9,7 +9,7 @@
  * Implementation of fsverity_operations for ext4.
  *
  * ext4 stores the verity metadata (Merkle tree and fsverity_descriptor) past
- * the end of the file, starting at the first page fully beyond i_size.  This
+ * the end of the file, starting at the first 64K boundary beyond i_size.  This
  * approach works because (a) verity files are readonly, and (b) pages fully
  * beyond i_size aren't visible to userspace but can be read/written internally
  * by ext4 with only some relatively small changes to ext4.  This approach
@@ -17,13 +17,22 @@
  * ext4's xattr support to support paging multi-gigabyte xattrs into memory, and
  * to support encrypting xattrs.  Note that the verity metadata *must* be
  * encrypted when the file is, since it contains hashes of the plaintext data.
+ *
+ * Using a 64K boundary rather than a 4K one keeps things ready for
+ * architectures with 64K pages, and it doesn't necessarily waste space on-disk
+ * since there can be a hole between i_size and the start of the Merkle tree.
  */
 
 #include <linux/quotaops.h>
 
 #include "ext4.h"
+#include "ext4_extents.h"
 #include "ext4_jbd2.h"
-#include "xattr.h"
+
+static inline loff_t ext4_verity_metadata_pos(const struct inode *inode)
+{
+	return round_up(inode->i_size, 65536);
+}
 
 /*
  * Read some verity metadata from the inode.  __vfs_read() can't be used because
@@ -32,8 +41,6 @@
 static int pagecache_read(struct inode *inode, void *buf, size_t count,
 			  loff_t pos)
 {
-	const size_t orig_count = count;
-
 	while (count) {
 		size_t n = min_t(size_t, count,
 				 PAGE_SIZE - offset_in_page(pos));
@@ -55,7 +62,7 @@ static int pagecache_read(struct inode *inode, void *buf, size_t count,
 		pos += n;
 		count -= n;
 	}
-	return orig_count;
+	return 0;
 }
 
 /*
@@ -96,22 +103,10 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 	return 0;
 }
 
-/*
- * Format of ext4 verity xattr.  This points to the location of the verity
- * descriptor within the file data rather than containing it directly because
- * the verity descriptor *must* be encrypted when ext4 encryption is used.  But,
- * ext4 encryption does not encrypt xattrs.
- */
-struct fsverity_descriptor_location {
-	__le32 version;
-	__le32 size;
-	__le64 pos;
-};
-
 static int ext4_begin_enable_verity(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
-	int credits = 2; /* superblock and inode for ext4_orphan_add() */
+	const int credits = 2; /* superblock and inode for ext4_orphan_add() */
 	handle_t *handle;
 	int err;
 
@@ -119,10 +114,24 @@ static int ext4_begin_enable_verity(struct file *filp)
 	if (err)
 		return err;
 
+	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
+		ext4_warning_inode(inode,
+				   "verity is only allowed on extent-based files");
+		return -EINVAL;
+	}
+
 	err = ext4_inode_attach_jinode(inode);
 	if (err)
 		return err;
 
+	/*
+	 * ext4 uses the last allocated block to find the verity descriptor, so
+	 * we must remove any other blocks which might confuse things.
+	 */
+	err = ext4_truncate(inode);
+	if (err)
+		return err;
+
 	err = dquot_initialize(inode);
 	if (err)
 		return err;
@@ -139,32 +148,55 @@ static int ext4_begin_enable_verity(struct file *filp)
 	return err;
 }
 
+/*
+ * ext4 stores the verity descriptor beginning on the next filesystem block
+ * boundary after the Merkle tree.  Then, the descriptor size is stored in the
+ * last 4 bytes of the last allocated filesystem block --- which is either the
+ * block in which the descriptor ends, or the next block after that if there
+ * weren't at least 4 bytes remaining.
+ *
+ * We can't simply store the descriptor in an xattr because it *must* be
+ * encrypted when ext4 encryption is used, but ext4 encryption doesn't encrypt
+ * xattrs.  Also, if the descriptor includes a large signature blob it may be
+ * too large to store in an xattr without the EA_INODE feature.
+ */
+static int ext4_write_verity_descriptor(struct inode *inode, const void *desc,
+					size_t desc_size, u64 merkle_tree_size)
+{
+	const u64 desc_pos = round_up(ext4_verity_metadata_pos(inode) +
+				      merkle_tree_size, i_blocksize(inode));
+	const u64 desc_end = desc_pos + desc_size;
+	const __le32 desc_size_disk = cpu_to_le32(desc_size);
+	const u64 desc_size_pos = round_up(desc_end + sizeof(desc_size_disk),
+					   i_blocksize(inode)) -
+				  sizeof(desc_size_disk);
+	int err;
+
+	err = pagecache_write(inode, desc, desc_size, desc_pos);
+	if (err)
+		return err;
+
+	return pagecache_write(inode, &desc_size_disk, sizeof(desc_size_disk),
+			       desc_size_pos);
+}
+
 static int ext4_end_enable_verity(struct file *filp, const void *desc,
 				  size_t desc_size, u64 merkle_tree_size)
 {
 	struct inode *inode = file_inode(filp);
-	u64 desc_pos = round_up(inode->i_size, PAGE_SIZE) + merkle_tree_size;
-	struct fsverity_descriptor_location dloc = {
-		.version = cpu_to_le32(1),
-		.size = cpu_to_le32(desc_size),
-		.pos = cpu_to_le64(desc_pos),
-	};
-	int credits = 0;
+	const int credits = 2; /* superblock and inode for ext4_orphan_add() */
 	handle_t *handle;
 	int err1 = 0;
 	int err;
 
 	if (desc != NULL) {
 		/* Succeeded; write the verity descriptor. */
-		err1 = pagecache_write(inode, desc, desc_size, desc_pos);
+		err1 = ext4_write_verity_descriptor(inode, desc, desc_size,
+						    merkle_tree_size);
 
 		/* Write all pages before clearing VERITY_IN_PROGRESS. */
 		if (!err1)
 			err1 = filemap_write_and_wait(inode->i_mapping);
-
-		if (!err1)
-			err1 = ext4_xattr_set_credits(inode, sizeof(dloc), true,
-						      &credits);
 	} else {
 		/* Failed; truncate anything we wrote past i_size. */
 		ext4_truncate(inode);
@@ -173,14 +205,12 @@ static int ext4_end_enable_verity(struct file *filp, const void *desc,
 	/*
 	 * We must always clean up by clearing EXT4_STATE_VERITY_IN_PROGRESS and
 	 * deleting the inode from the orphan list, even if something failed.
-	 * If everything succeeded, we'll also set the verity bit and descriptor
-	 * location xattr in the same transaction.
+	 * If everything succeeded, we'll also set the verity bit in the same
+	 * transaction.
 	 */
 
 	ext4_clear_inode_state(inode, EXT4_STATE_VERITY_IN_PROGRESS);
 
-	credits += 2; /* superblock and inode for ext4_orphan_del() */
-
 	handle = ext4_journal_start(inode, EXT4_HT_INODE, credits);
 	if (IS_ERR(handle)) {
 		ext4_orphan_del(NULL, inode);
@@ -194,13 +224,6 @@ static int ext4_end_enable_verity(struct file *filp, const void *desc,
 	if (desc != NULL && !err1) {
 		struct ext4_iloc iloc;
 
-		err = ext4_xattr_set_handle(handle, inode,
-					    EXT4_XATTR_INDEX_VERITY,
-					    EXT4_XATTR_NAME_VERITY,
-					    &dloc, sizeof(dloc), XATTR_CREATE);
-		if (err)
-			goto out_stop;
-
 		err = ext4_reserve_inode_write(handle, inode, &iloc);
 		if (err)
 			goto out_stop;
@@ -213,43 +236,103 @@ static int ext4_end_enable_verity(struct file *filp, const void *desc,
 	return err ?: err1;
 }
 
-static int ext4_get_verity_descriptor(struct inode *inode, void *buf,
-				      size_t buf_size)
+static int ext4_get_verity_descriptor_location(struct inode *inode,
+					       size_t *desc_size_ret,
+					       u64 *desc_pos_ret)
 {
-	struct fsverity_descriptor_location dloc;
-	int res;
-	u32 size;
-	u64 pos;
-
-	/* Get the descriptor location */
-	res = ext4_xattr_get(inode, EXT4_XATTR_INDEX_VERITY,
-			     EXT4_XATTR_NAME_VERITY, &dloc, sizeof(dloc));
-	if (res < 0 && res != -ERANGE)
-		return res;
-	if (res != sizeof(dloc) || dloc.version != cpu_to_le32(1)) {
-		ext4_warning_inode(inode, "unknown verity xattr format");
-		return -EINVAL;
+	struct ext4_ext_path *path;
+	struct ext4_extent *last_extent;
+	u32 end_lblk;
+	u64 desc_size_pos;
+	__le32 desc_size_disk;
+	u32 desc_size;
+	u64 desc_pos;
+	int err;
+
+	/*
+	 * Descriptor size is in last 4 bytes of last allocated block.
+	 * See ext4_write_verity_descriptor().
+	 */
+
+	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
+		EXT4_ERROR_INODE(inode, "verity file doesn't use extents");
+		return -EFSCORRUPTED;
 	}
-	size = le32_to_cpu(dloc.size);
-	pos = le64_to_cpu(dloc.pos);
 
-	/* Get the descriptor */
-	if (pos + size < pos || pos + size > inode->i_sb->s_maxbytes ||
-	    pos < round_up(inode->i_size, PAGE_SIZE) || size > INT_MAX) {
-		ext4_warning_inode(inode, "invalid verity xattr");
+	path = ext4_find_extent(inode, EXT_MAX_BLOCKS - 1, NULL, 0);
+	if (IS_ERR(path))
+		return PTR_ERR(path);
+
+	last_extent = path[path->p_depth].p_ext;
+	if (!last_extent) {
+		EXT4_ERROR_INODE(inode, "verity file has no extents");
+		ext4_ext_drop_refs(path);
+		kfree(path);
 		return -EFSCORRUPTED;
 	}
-	if (buf_size == 0)
-		return size;
-	if (size > buf_size)
-		return -ERANGE;
-	return pagecache_read(inode, buf, size, pos);
+
+	end_lblk = le32_to_cpu(last_extent->ee_block) +
+		   ext4_ext_get_actual_len(last_extent);
+	desc_size_pos = (u64)end_lblk << inode->i_blkbits;
+	ext4_ext_drop_refs(path);
+	kfree(path);
+
+	if (desc_size_pos < sizeof(desc_size_disk))
+		goto bad;
+	desc_size_pos -= sizeof(desc_size_disk);
+
+	err = pagecache_read(inode, &desc_size_disk, sizeof(desc_size_disk),
+			     desc_size_pos);
+	if (err)
+		return err;
+	desc_size = le32_to_cpu(desc_size_disk);
+
+	/*
+	 * The descriptor is stored just before the desc_size_disk, but starting
+	 * on a filesystem block boundary.
+	 */
+
+	if (desc_size > INT_MAX || desc_size > desc_size_pos)
+		goto bad;
+
+	desc_pos = round_down(desc_size_pos - desc_size, i_blocksize(inode));
+	if (desc_pos < ext4_verity_metadata_pos(inode))
+		goto bad;
+
+	*desc_size_ret = desc_size;
+	*desc_pos_ret = desc_pos;
+	return 0;
+
+bad:
+	EXT4_ERROR_INODE(inode, "verity file corrupted; can't find descriptor");
+	return -EFSCORRUPTED;
+}
+
+static int ext4_get_verity_descriptor(struct inode *inode, void *buf,
+				      size_t buf_size)
+{
+	size_t desc_size = 0;
+	u64 desc_pos = 0;
+	int err;
+
+	err = ext4_get_verity_descriptor_location(inode, &desc_size, &desc_pos);
+	if (err)
+		return err;
+
+	if (buf_size) {
+		if (desc_size > buf_size)
+			return -ERANGE;
+		err = pagecache_read(inode, buf, desc_size, desc_pos);
+		if (err)
+			return err;
+	}
+	return desc_size;
 }
 
 static struct page *ext4_read_merkle_tree_page(struct inode *inode,
 					       pgoff_t index)
 {
-	index += DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
+	index += ext4_verity_metadata_pos(inode) >> PAGE_SHIFT;
 
 	return read_mapping_page(inode->i_mapping, index, NULL);
 }
@@ -257,8 +340,7 @@ static struct page *ext4_read_merkle_tree_page(struct inode *inode,
 static int ext4_write_merkle_tree_block(struct inode *inode, const void *buf,
 					u64 index, int log_blocksize)
 {
-	loff_t pos = round_up(inode->i_size, PAGE_SIZE) +
-		     (index << log_blocksize);
+	loff_t pos = ext4_verity_metadata_pos(inode) + (index << log_blocksize);
 
 	return pagecache_write(inode, buf, 1 << log_blocksize, pos);
 }
