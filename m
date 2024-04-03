Return-Path: <linux-fsdevel+bounces-15980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 070B2896677
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 09:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D4B284BAF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 07:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE186D1A0;
	Wed,  3 Apr 2024 07:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="lKp/CokE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC41565BAA;
	Wed,  3 Apr 2024 07:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129590; cv=none; b=q2y1VU0QpOMA7VErhKKowlscDwqjTnYkuRNb5mfptZlpFy1oNK52lwjt79qaTFOCLawCuBRERyQU5veiH+MCa2+hHld0f+z+pOndYGTp6o0Sb2flFWGxggFVGASpL/OOVts6EkXOmq5ijiW05TcGivClSvvpK+aDKC6+e9tMn2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129590; c=relaxed/simple;
	bh=HfFh43eOQ7BBP8UDPoelIqPTjR0UFDaCRfKQjLQWiQk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtZF9uigcat8OcvXyTfi67753LPtzgUDPdvo+YVUm5oZ2QPWd6hVJq7T6xjL6iDILlMuySsaNDJPmFaVSI+WsoeZCMBnQ8gT4PtJTiDqCuI+9QWxhmRd6Ck1b60urS1uGC/scPycCrA16EBvcpShOaqCMMJyXHOPCoRHTKagpII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=lKp/CokE; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 7C9F8807A7;
	Wed,  3 Apr 2024 03:33:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1712129588; bh=HfFh43eOQ7BBP8UDPoelIqPTjR0UFDaCRfKQjLQWiQk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lKp/CokELlh7R28OoZ/U/MxOHn/kYmAEz9J++4sLbkHmqUE0V65SHaRMgOOESHyLi
	 jM5dIweXn3I95igLAcMl6++BFRqGzdPFaSwHuvw2pcEA2vd7BpQQ3rb0yT4S/2japf
	 GpNDRn54Z6e46HhYTzT8YGOxKymBHnQb7fk7IL9QKA7r+FFIUrgbkWIbVLb9Cdm14D
	 KePODvET23VnxVWN3zEbmA9AZZnqQiKkjoR33qDDRl1hNAA0YRcTw/iRPtHBrB0NXQ
	 4mYBx7+MIQzRuOyBh0f4nieTlWgzGOSvtDqhxRJd8NxYp8ofzngPCRaLFK/cwvXUo3
	 vD/zgtXiQreeA==
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To: Jonathan Corbet <corbet@lwn.net>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 02/13] fs: fiemap: update fiemap_fill_next_extent() signature
Date: Wed,  3 Apr 2024 03:22:43 -0400
Message-ID: <58f9c9eef8b0e33a8d46a3ad8a8db46890e1fbe8.1712126039.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1712126039.git.sweettea-kernel@dorminy.me>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the signature of fiemap_fill_next_extent() to allow passing a
physical length. Update all callers to pass a 0 physical length -- since
none set the EXTENT_HAS_PHYS_LEN flag, this value doesn't matter.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 Documentation/filesystems/fiemap.rst | 3 ++-
 fs/bcachefs/fs.c                     | 7 ++++---
 fs/btrfs/extent_io.c                 | 4 ++--
 fs/ext4/extents.c                    | 1 +
 fs/f2fs/data.c                       | 8 +++++---
 fs/f2fs/inline.c                     | 3 ++-
 fs/ioctl.c                           | 9 +++++----
 fs/iomap/fiemap.c                    | 2 +-
 fs/nilfs2/inode.c                    | 6 +++---
 fs/ntfs3/frecord.c                   | 7 ++++---
 fs/ocfs2/extent_map.c                | 4 ++--
 fs/smb/client/smb2ops.c              | 1 +
 include/linux/fiemap.h               | 2 +-
 13 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/Documentation/filesystems/fiemap.rst b/Documentation/filesystems/fiemap.rst
index c2bfa107c8d7..c060bb83f5d8 100644
--- a/Documentation/filesystems/fiemap.rst
+++ b/Documentation/filesystems/fiemap.rst
@@ -236,7 +236,8 @@ For each extent in the request range, the file system should call
 the helper function, fiemap_fill_next_extent()::
 
   int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 logical,
-			      u64 phys, u64 len, u32 flags, u32 dev);
+			      u64 phys, u64 log_len, u64 phys_len, u32 flags,
+                              u32 dev);
 
 fiemap_fill_next_extent() will use the passed values to populate the
 next free extent in the fm_extents array. 'General' extent flags will
diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 71013256fc39..f830578a9cd1 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -931,7 +931,8 @@ static int bch2_fill_extent(struct bch_fs *c,
 			ret = fiemap_fill_next_extent(info,
 						bkey_start_offset(k.k) << 9,
 						offset << 9,
-						k.k->size << 9, flags|flags2);
+						k.k->size << 9, 0,
+						flags|flags2);
 			if (ret)
 				return ret;
 		}
@@ -940,13 +941,13 @@ static int bch2_fill_extent(struct bch_fs *c,
 	} else if (bkey_extent_is_inline_data(k.k)) {
 		return fiemap_fill_next_extent(info,
 					       bkey_start_offset(k.k) << 9,
-					       0, k.k->size << 9,
+					       0, k.k->size << 9, 0,
 					       flags|
 					       FIEMAP_EXTENT_DATA_INLINE);
 	} else if (k.k->type == KEY_TYPE_reservation) {
 		return fiemap_fill_next_extent(info,
 					       bkey_start_offset(k.k) << 9,
-					       0, k.k->size << 9,
+					       0, k.k->size << 9, 0,
 					       flags|
 					       FIEMAP_EXTENT_DELALLOC|
 					       FIEMAP_EXTENT_UNWRITTEN);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index eceef5ff780b..9e421d99fd5c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2577,7 +2577,7 @@ static int flush_fiemap_cache(struct fiemap_extent_info *fieinfo,
 		int ret;
 
 		ret = fiemap_fill_next_extent(fieinfo, entry->offset,
-					      entry->phys, entry->len,
+					      entry->phys, entry->len, 0,
 					      entry->flags);
 		/*
 		 * Ignore 1 (reached max entries) because we keep track of that
@@ -2793,7 +2793,7 @@ static int emit_last_fiemap_cache(struct fiemap_extent_info *fieinfo,
 		return 0;
 
 	ret = fiemap_fill_next_extent(fieinfo, cache->offset, cache->phys,
-				      cache->len, cache->flags);
+				      cache->len, 0, cache->flags);
 	cache->cached = false;
 	if (ret > 0)
 		ret = 0;
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e57054bdc5fd..2adade3c202a 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2215,6 +2215,7 @@ static int ext4_fill_es_cache_info(struct inode *inode,
 				(__u64)es.es_lblk << blksize_bits,
 				(__u64)es.es_pblk << blksize_bits,
 				(__u64)es.es_len << blksize_bits,
+				0,
 				flags);
 		if (next == 0)
 			break;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d9494b5fc7c1..87f8d828e038 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1834,7 +1834,8 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 		if (!xnid)
 			flags |= FIEMAP_EXTENT_LAST;
 
-		err = fiemap_fill_next_extent(fieinfo, 0, phys, len, flags);
+		err = fiemap_fill_next_extent(
+				fieinfo, 0, phys, len, 0, flags);
 		trace_f2fs_fiemap(inode, 0, phys, len, flags, err);
 		if (err)
 			return err;
@@ -1860,7 +1861,8 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 	}
 
 	if (phys) {
-		err = fiemap_fill_next_extent(fieinfo, 0, phys, len, flags);
+		err = fiemap_fill_next_extent(
+				fieinfo, 0, phys, len, 0, flags);
 		trace_f2fs_fiemap(inode, 0, phys, len, flags, err);
 	}
 
@@ -1979,7 +1981,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			flags |= FIEMAP_EXTENT_DATA_ENCRYPTED;
 
 		ret = fiemap_fill_next_extent(fieinfo, logical,
-				phys, size, flags);
+				phys, size, 0, flags);
 		trace_f2fs_fiemap(inode, logical, phys, size, flags, ret);
 		if (ret)
 			goto out;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index ac00423f117b..49d2f87fe048 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -806,7 +806,8 @@ int f2fs_inline_data_fiemap(struct inode *inode,
 	byteaddr = (__u64)ni.blk_addr << inode->i_sb->s_blocksize_bits;
 	byteaddr += (char *)inline_data_addr(inode, ipage) -
 					(char *)F2FS_INODE(ipage);
-	err = fiemap_fill_next_extent(fieinfo, start, byteaddr, ilen, flags);
+	err = fiemap_fill_next_extent(
+			fieinfo, start, byteaddr, ilen, 0, flags);
 	trace_f2fs_fiemap(inode, start, byteaddr, ilen, flags, err);
 out:
 	f2fs_put_page(ipage, 1);
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 8afd32e1a27a..1830baca532b 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -99,7 +99,8 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
  * @fieinfo:	Fiemap context passed into ->fiemap
  * @logical:	Extent logical start offset, in bytes
  * @phys:	Extent physical start offset, in bytes
- * @len:	Extent length, in bytes
+ * @log_len:	Extent logical length, in bytes
+ * @phys_len:	Extent physical length, in bytes (optional)
  * @flags:	FIEMAP_EXTENT flags that describe this extent
  *
  * Called from file system ->fiemap callback. Will populate extent
@@ -110,7 +111,7 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
  * extent that will fit in user array.
  */
 int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
-			    u64 phys, u64 len, u32 flags)
+			    u64 phys, u64 log_len, u64 phys_len, u32 flags)
 {
 	struct fiemap_extent extent;
 	struct fiemap_extent __user *dest = fieinfo->fi_extents_start;
@@ -138,8 +139,8 @@ int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
 	memset(&extent, 0, sizeof(extent));
 	extent.fe_logical = logical;
 	extent.fe_physical = phys;
-	extent.fe_logical_length = len;
-	extent.fe_physical_length = len;
+	extent.fe_logical_length = log_len;
+	extent.fe_physical_length = phys_len;
 	extent.fe_flags = flags;
 
 	dest += fieinfo->fi_extents_mapped;
diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
index 610ca6f1ec9b..013e843c8d10 100644
--- a/fs/iomap/fiemap.c
+++ b/fs/iomap/fiemap.c
@@ -36,7 +36,7 @@ static int iomap_to_fiemap(struct fiemap_extent_info *fi,
 
 	return fiemap_fill_next_extent(fi, iomap->offset,
 			iomap->addr != IOMAP_NULL_ADDR ? iomap->addr : 0,
-			iomap->length, flags);
+			iomap->length, 0, flags);
 }
 
 static loff_t iomap_fiemap_iter(const struct iomap_iter *iter,
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 7340a01d80e1..4d3c347c982b 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -1190,7 +1190,7 @@ int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			if (size) {
 				/* End of the current extent */
 				ret = fiemap_fill_next_extent(
-					fieinfo, logical, phys, size, flags);
+					fieinfo, logical, phys, size, 0, flags);
 				if (ret)
 					break;
 			}
@@ -1240,7 +1240,7 @@ int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 					flags |= FIEMAP_EXTENT_LAST;
 
 				ret = fiemap_fill_next_extent(
-					fieinfo, logical, phys, size, flags);
+					fieinfo, logical, phys, size, 0, flags);
 				if (ret)
 					break;
 				size = 0;
@@ -1256,7 +1256,7 @@ int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 					/* Terminate the current extent */
 					ret = fiemap_fill_next_extent(
 						fieinfo, logical, phys, size,
-						flags);
+						0, flags);
 					if (ret || blkoff > end_blkoff)
 						break;
 
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 7f27382e0ce2..ef0ed913428b 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1947,7 +1947,7 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 	if (!attr || !attr->non_res) {
 		err = fiemap_fill_next_extent(
 			fieinfo, 0, 0,
-			attr ? le32_to_cpu(attr->res.data_size) : 0,
+			attr ? le32_to_cpu(attr->res.data_size) : 0, 0,
 			FIEMAP_EXTENT_DATA_INLINE | FIEMAP_EXTENT_LAST |
 				FIEMAP_EXTENT_MERGED);
 		goto out;
@@ -2042,7 +2042,7 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 				flags |= FIEMAP_EXTENT_LAST;
 
 			err = fiemap_fill_next_extent(fieinfo, vbo, lbo, dlen,
-						      flags);
+						      0, flags);
 			if (err < 0)
 				break;
 			if (err == 1) {
@@ -2062,7 +2062,8 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 		if (vbo + bytes >= end)
 			flags |= FIEMAP_EXTENT_LAST;
 
-		err = fiemap_fill_next_extent(fieinfo, vbo, lbo, bytes, flags);
+		err = fiemap_fill_next_extent(fieinfo, vbo, lbo, bytes, 0,
+					      flags);
 		if (err < 0)
 			break;
 		if (err == 1) {
diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index 70a768b623cf..eabdf97cd685 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -723,7 +723,7 @@ static int ocfs2_fiemap_inline(struct inode *inode, struct buffer_head *di_bh,
 					 id2.i_data.id_data);
 
 		ret = fiemap_fill_next_extent(fieinfo, 0, phys, id_count,
-					      flags);
+					      0, flags);
 		if (ret < 0)
 			return ret;
 	}
@@ -794,7 +794,7 @@ int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		virt_bytes = (u64)le32_to_cpu(rec.e_cpos) << osb->s_clustersize_bits;
 
 		ret = fiemap_fill_next_extent(fieinfo, virt_bytes, phys_bytes,
-					      len_bytes, fe_flags);
+					      len_bytes, 0, fe_flags);
 		if (ret)
 			break;
 
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 87b63f6ad2e2..23a193512f96 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3779,6 +3779,7 @@ static int smb3_fiemap(struct cifs_tcon *tcon,
 				le64_to_cpu(out_data[i].file_offset),
 				le64_to_cpu(out_data[i].file_offset),
 				le64_to_cpu(out_data[i].length),
+				0,
 				flags);
 		if (rc < 0)
 			goto out;
diff --git a/include/linux/fiemap.h b/include/linux/fiemap.h
index c50882f19235..17a6c32cdf3f 100644
--- a/include/linux/fiemap.h
+++ b/include/linux/fiemap.h
@@ -16,6 +16,6 @@ struct fiemap_extent_info {
 int fiemap_prep(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		u64 start, u64 *len, u32 supported_flags);
 int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 logical,
-			    u64 phys, u64 len, u32 flags);
+			    u64 phys, u64 log_len, u64 phys_len, u32 flags);
 
 #endif /* _LINUX_FIEMAP_H 1 */
-- 
2.43.0


