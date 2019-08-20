Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95FA195F76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 15:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbfHTNHH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 09:07:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13570 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729351AbfHTNHH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:07:07 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7KD3sBn083448
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2019 09:07:05 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ugh0j9fr4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2019 09:07:04 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 20 Aug 2019 14:07:03 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 20 Aug 2019 14:06:59 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7KD6xuh59441308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Aug 2019 13:06:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E002811C050;
        Tue, 20 Aug 2019 13:06:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CD0F11C05E;
        Tue, 20 Aug 2019 13:06:57 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.31.57])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 20 Aug 2019 13:06:57 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca, jack@suse.cz, tytso@mit.edu,
        mbobrowski@mbobrowski.org, linux-fsdevel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 2/2] ext4: Move ext4_fiemap to iomap infrastructure
Date:   Tue, 20 Aug 2019 18:36:34 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820130634.25954-1-riteshh@linux.ibm.com>
References: <20190820130634.25954-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19082013-0008-0000-0000-0000030B0EF9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082013-0009-0000-0000-00004A293647
Message-Id: <20190820130634.25954-3-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-20_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=923 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908200137
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This moves ext4_fiemap to use iomap infrastructure.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/extents.c | 294 +++++++---------------------------------------
 fs/ext4/inline.c  |  41 -------
 fs/ext4/inode.c   |  15 ++-
 3 files changed, 52 insertions(+), 298 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 92266a2da7d6..a03e14e50085 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -28,6 +28,7 @@
 #include <linux/uaccess.h>
 #include <linux/fiemap.h>
 #include <linux/backing-dev.h>
+#include <linux/iomap.h>
 #include "ext4_jbd2.h"
 #include "ext4_extents.h"
 #include "xattr.h"
@@ -97,9 +98,6 @@ static int ext4_split_extent_at(handle_t *handle,
 			     int split_flag,
 			     int flags);
 
-static int ext4_find_delayed_extent(struct inode *inode,
-				    struct extent_status *newes);
-
 static int ext4_ext_truncate_extend_restart(handle_t *handle,
 					    struct inode *inode,
 					    int needed)
@@ -2166,155 +2164,6 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 	return err;
 }
 
-static int ext4_fill_fiemap_extents(struct inode *inode,
-				    ext4_lblk_t block, ext4_lblk_t num,
-				    struct fiemap_extent_info *fieinfo)
-{
-	struct ext4_ext_path *path = NULL;
-	struct ext4_extent *ex;
-	struct extent_status es;
-	ext4_lblk_t next, next_del, start = 0, end = 0;
-	ext4_lblk_t last = block + num;
-	int exists, depth = 0, err = 0;
-	unsigned int flags = 0;
-	unsigned char blksize_bits = inode->i_sb->s_blocksize_bits;
-
-	while (block < last && block != EXT_MAX_BLOCKS) {
-		num = last - block;
-		/* find extent for this block */
-		down_read(&EXT4_I(inode)->i_data_sem);
-
-		path = ext4_find_extent(inode, block, &path, 0);
-		if (IS_ERR(path)) {
-			up_read(&EXT4_I(inode)->i_data_sem);
-			err = PTR_ERR(path);
-			path = NULL;
-			break;
-		}
-
-		depth = ext_depth(inode);
-		if (unlikely(path[depth].p_hdr == NULL)) {
-			up_read(&EXT4_I(inode)->i_data_sem);
-			EXT4_ERROR_INODE(inode, "path[%d].p_hdr == NULL", depth);
-			err = -EFSCORRUPTED;
-			break;
-		}
-		ex = path[depth].p_ext;
-		next = ext4_ext_next_allocated_block(path);
-
-		flags = 0;
-		exists = 0;
-		if (!ex) {
-			/* there is no extent yet, so try to allocate
-			 * all requested space */
-			start = block;
-			end = block + num;
-		} else if (le32_to_cpu(ex->ee_block) > block) {
-			/* need to allocate space before found extent */
-			start = block;
-			end = le32_to_cpu(ex->ee_block);
-			if (block + num < end)
-				end = block + num;
-		} else if (block >= le32_to_cpu(ex->ee_block)
-					+ ext4_ext_get_actual_len(ex)) {
-			/* need to allocate space after found extent */
-			start = block;
-			end = block + num;
-			if (end >= next)
-				end = next;
-		} else if (block >= le32_to_cpu(ex->ee_block)) {
-			/*
-			 * some part of requested space is covered
-			 * by found extent
-			 */
-			start = block;
-			end = le32_to_cpu(ex->ee_block)
-				+ ext4_ext_get_actual_len(ex);
-			if (block + num < end)
-				end = block + num;
-			exists = 1;
-		} else {
-			BUG();
-		}
-		BUG_ON(end <= start);
-
-		if (!exists) {
-			es.es_lblk = start;
-			es.es_len = end - start;
-			es.es_pblk = 0;
-		} else {
-			es.es_lblk = le32_to_cpu(ex->ee_block);
-			es.es_len = ext4_ext_get_actual_len(ex);
-			es.es_pblk = ext4_ext_pblock(ex);
-			if (ext4_ext_is_unwritten(ex))
-				flags |= FIEMAP_EXTENT_UNWRITTEN;
-		}
-
-		/*
-		 * Find delayed extent and update es accordingly. We call
-		 * it even in !exists case to find out whether es is the
-		 * last existing extent or not.
-		 */
-		next_del = ext4_find_delayed_extent(inode, &es);
-		if (!exists && next_del) {
-			exists = 1;
-			flags |= (FIEMAP_EXTENT_DELALLOC |
-				  FIEMAP_EXTENT_UNKNOWN);
-		}
-		up_read(&EXT4_I(inode)->i_data_sem);
-
-		if (unlikely(es.es_len == 0)) {
-			EXT4_ERROR_INODE(inode, "es.es_len == 0");
-			err = -EFSCORRUPTED;
-			break;
-		}
-
-		/*
-		 * This is possible iff next == next_del == EXT_MAX_BLOCKS.
-		 * we need to check next == EXT_MAX_BLOCKS because it is
-		 * possible that an extent is with unwritten and delayed
-		 * status due to when an extent is delayed allocated and
-		 * is allocated by fallocate status tree will track both of
-		 * them in a extent.
-		 *
-		 * So we could return a unwritten and delayed extent, and
-		 * its block is equal to 'next'.
-		 */
-		if (next == next_del && next == EXT_MAX_BLOCKS) {
-			flags |= FIEMAP_EXTENT_LAST;
-			if (unlikely(next_del != EXT_MAX_BLOCKS ||
-				     next != EXT_MAX_BLOCKS)) {
-				EXT4_ERROR_INODE(inode,
-						 "next extent == %u, next "
-						 "delalloc extent = %u",
-						 next, next_del);
-				err = -EFSCORRUPTED;
-				break;
-			}
-		}
-
-		if (exists) {
-			err = fiemap_fill_next_extent(fieinfo,
-				(__u64)es.es_lblk << blksize_bits,
-				(__u64)es.es_pblk << blksize_bits,
-				(__u64)es.es_len << blksize_bits,
-				flags);
-			if (err < 0)
-				break;
-			if (err == 1) {
-				err = 0;
-				break;
-			}
-		}
-
-		block = es.es_lblk + es.es_len;
-	}
-
-	ext4_ext_drop_refs(path);
-	kfree(path);
-	return err;
-}
-
 /*
  * ext4_ext_determine_hole - determine hole around given block
  * @inode:	inode we lookup in
@@ -4968,143 +4817,80 @@ int ext4_convert_unwritten_extents(handle_t *handle, struct inode *inode,
 	return ret > 0 ? ret2 : ret;
 }
 
-/*
- * If newes is not existing extent (newes->ec_pblk equals zero) find
- * delayed extent at start of newes and update newes accordingly and
- * return start of the next delayed extent.
- *
- * If newes is existing extent (newes->ec_pblk is not equal zero)
- * return start of next delayed extent or EXT_MAX_BLOCKS if no delayed
- * extent found. Leave newes unmodified.
- */
-static int ext4_find_delayed_extent(struct inode *inode,
-				    struct extent_status *newes)
-{
-	struct extent_status es;
-	ext4_lblk_t block, next_del;
-
-	if (newes->es_pblk == 0) {
-		ext4_es_find_extent_range(inode, &ext4_es_is_delayed,
-					  newes->es_lblk,
-					  newes->es_lblk + newes->es_len - 1,
-					  &es);
-
-		/*
-		 * No extent in extent-tree contains block @newes->es_pblk,
-		 * then the block may stay in 1)a hole or 2)delayed-extent.
-		 */
-		if (es.es_len == 0)
-			/* A hole found. */
-			return 0;
-
-		if (es.es_lblk > newes->es_lblk) {
-			/* A hole found. */
-			newes->es_len = min(es.es_lblk - newes->es_lblk,
-					    newes->es_len);
-			return 0;
-		}
-
-		newes->es_len = es.es_lblk + es.es_len - newes->es_lblk;
-	}
-
-	block = newes->es_lblk + newes->es_len;
-	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, block,
-				  EXT_MAX_BLOCKS, &es);
-	if (es.es_len == 0)
-		next_del = EXT_MAX_BLOCKS;
-	else
-		next_del = es.es_lblk;
-
-	return next_del;
-}
 /* fiemap flags we can handle specified here */
 #define EXT4_FIEMAP_FLAGS	(FIEMAP_FLAG_SYNC|FIEMAP_FLAG_XATTR)
 
-static int ext4_xattr_fiemap(struct inode *inode,
-				struct fiemap_extent_info *fieinfo)
+static int ext4_xattr_iomap_fiemap(struct inode *inode, struct iomap *iomap)
 {
-	__u64 physical = 0;
-	__u64 length;
-	__u32 flags = FIEMAP_EXTENT_LAST;
+	u64 physical = 0;
+	u64 length;
 	int blockbits = inode->i_sb->s_blocksize_bits;
-	int error = 0;
+	int ret = 0;
 
 	/* in-inode? */
 	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
 		struct ext4_iloc iloc;
-		int offset;	/* offset of xattr in inode */
+		int offset;     /* offset of xattr in inode */
 
-		error = ext4_get_inode_loc(inode, &iloc);
-		if (error)
-			return error;
+		ret = ext4_get_inode_loc(inode, &iloc);
+		if (ret)
+			goto out;
 		physical = (__u64)iloc.bh->b_blocknr << blockbits;
 		offset = EXT4_GOOD_OLD_INODE_SIZE +
 				EXT4_I(inode)->i_extra_isize;
 		physical += offset;
 		length = EXT4_SB(inode->i_sb)->s_inode_size - offset;
-		flags |= FIEMAP_EXTENT_DATA_INLINE;
 		brelse(iloc.bh);
 	} else { /* external block */
 		physical = (__u64)EXT4_I(inode)->i_file_acl << blockbits;
 		length = inode->i_sb->s_blocksize;
 	}
 
-	if (physical)
-		error = fiemap_fill_next_extent(fieinfo, 0, physical,
-						length, flags);
-	return (error < 0 ? error : 0);
+	iomap->addr = physical;
+	iomap->offset = 0;
+	iomap->length = length;
+	iomap->type = IOMAP_INLINE;
+	iomap->flags = 0;
+out:
+	return ret;
 }
 
-int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
-		__u64 start, __u64 len)
+static int ext4_xattr_iomap_begin(struct inode *inode, loff_t offset,
+				  loff_t length, unsigned flags,
+				  struct iomap *iomap)
 {
-	ext4_lblk_t start_blk;
-	int error = 0;
-
-	if (ext4_has_inline_data(inode)) {
-		int has_inline = 1;
+	int ret;
 
-		error = ext4_inline_data_fiemap(inode, fieinfo, &has_inline,
-						start, len);
+	ret = ext4_xattr_iomap_fiemap(inode, iomap);
+	if (ret == 0 && (offset >= iomap->length))
+		ret = -ENOENT;
+	return ret;
+}
 
-		if (has_inline)
-			return error;
-	}
+const struct iomap_ops ext4_xattr_iomap_ops = {
+	.iomap_begin		= ext4_xattr_iomap_begin,
+};
 
+int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		u64 start, u64 length)
+{
+	int ret;
 	if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) {
-		error = ext4_ext_precache(inode);
-		if (error)
-			return error;
+		ret = ext4_ext_precache(inode);
+		if (ret)
+			return ret;
 	}
 
-	/* fallback to generic here if not in extents fmt */
-	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
-		return generic_block_fiemap(inode, fieinfo, start, len,
-			ext4_get_block);
-
 	if (fiemap_check_flags(fieinfo, EXT4_FIEMAP_FLAGS))
 		return -EBADR;
 
 	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR) {
-		error = ext4_xattr_fiemap(inode, fieinfo);
-	} else {
-		ext4_lblk_t len_blks;
-		__u64 last_blk;
-
-		start_blk = start >> inode->i_sb->s_blocksize_bits;
-		last_blk = (start + len - 1) >> inode->i_sb->s_blocksize_bits;
-		if (last_blk >= EXT_MAX_BLOCKS)
-			last_blk = EXT_MAX_BLOCKS-1;
-		len_blks = ((ext4_lblk_t) last_blk) - start_blk + 1;
-
-		/*
-		 * Walk the extent tree gathering extent information
-		 * and pushing extents back to the user.
-		 */
-		error = ext4_fill_fiemap_extents(inode, start_blk,
-						 len_blks, fieinfo);
+		fieinfo->fi_flags &= ~FIEMAP_FLAG_XATTR;
+		return iomap_fiemap(inode, fieinfo, start, length,
+				&ext4_xattr_iomap_ops);
 	}
-	return error;
+
+	return iomap_fiemap(inode, fieinfo, start, length, &ext4_iomap_ops);
 }
 
 /*
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 88cdf3c90bd1..1e22f3f798de 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1855,47 +1855,6 @@ int ext4_inline_data_iomap(struct inode *inode, struct iomap *iomap)
 	return error;
 }
 
-int ext4_inline_data_fiemap(struct inode *inode,
-			    struct fiemap_extent_info *fieinfo,
-			    int *has_inline, __u64 start, __u64 len)
-{
-	__u64 physical = 0;
-	__u64 inline_len;
-	__u32 flags = FIEMAP_EXTENT_DATA_INLINE | FIEMAP_EXTENT_NOT_ALIGNED |
-		FIEMAP_EXTENT_LAST;
-	int error = 0;
-	struct ext4_iloc iloc;
-
-	down_read(&EXT4_I(inode)->xattr_sem);
-	if (!ext4_has_inline_data(inode)) {
-		*has_inline = 0;
-		goto out;
-	}
-	inline_len = min_t(size_t, ext4_get_inline_size(inode),
-			   i_size_read(inode));
-	if (start >= inline_len)
-		goto out;
-	if (start + len < inline_len)
-		inline_len = start + len;
-	inline_len -= start;
-
-	error = ext4_get_inode_loc(inode, &iloc);
-	if (error)
-		goto out;
-
-	physical = (__u64)iloc.bh->b_blocknr << inode->i_sb->s_blocksize_bits;
-	physical += (char *)ext4_raw_inode(&iloc) - iloc.bh->b_data;
-	physical += offsetof(struct ext4_inode, i_block);
-
-	brelse(iloc.bh);
-out:
-	up_read(&EXT4_I(inode)->xattr_sem);
-	if (physical)
-		error = fiemap_fill_next_extent(fieinfo, start, physical,
-						inline_len, flags);
-	return (error < 0 ? error : 0);
-}
-
 int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 {
 	handle_t *handle;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d6a34214e9df..92705e99e07c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3581,15 +3581,24 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		iomap->type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
 		iomap->addr = IOMAP_NULL_ADDR;
 	} else {
-		if (map.m_flags & EXT4_MAP_MAPPED) {
-			iomap->type = IOMAP_MAPPED;
-		} else if (map.m_flags & EXT4_MAP_UNWRITTEN) {
+		/*
+		 * There can be a case where map.m_flags may
+		 * have both EXT4_MAP_UNWRITTEN & EXT4_MAP_MERGED
+		 * set. This is when we do fallocate first and
+		 * then try to write to that area, then it may have
+		 * both flags set. So check for unwritten first.
+		 */
+		if (map.m_flags & EXT4_MAP_UNWRITTEN) {
 			iomap->type = IOMAP_UNWRITTEN;
+		} else if (map.m_flags & EXT4_MAP_MAPPED) {
+			iomap->type = IOMAP_MAPPED;
 		} else {
 			WARN_ON_ONCE(1);
 			return -EIO;
 		}
 		iomap->addr = (u64)map.m_pblk << blkbits;
+		if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+			iomap->flags |= IOMAP_F_MERGED;
 	}
 
 	if (map.m_flags & EXT4_MAP_NEW)
-- 
2.21.0

