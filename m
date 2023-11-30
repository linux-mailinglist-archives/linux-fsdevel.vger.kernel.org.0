Return-Path: <linux-fsdevel+bounces-4401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB537FF2B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EABAB1F20F16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1FD51018
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S0BMmChv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AF91BE9;
	Thu, 30 Nov 2023 05:53:52 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUDnWZM001318;
	Thu, 30 Nov 2023 13:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=x3P0yh8GCW7CNkQcAyNbHKBz4AByo20w32YCb9GgXDc=;
 b=S0BMmChv8ihQGtq9Dr2E3FLQ7xqvBQTn/bWpQiBbUl1/HGlCNFq7+kgrQndbnCqeSsiA
 1dDq5WYAe9BeE9rguXAu38Odr81MOO5kH5BCzqLW7qQGWeyeDGlelvxgvLfu4afq287+
 FgKGbSrXk8OvxZUZFVfQpgdkJUkZ4Inaqb7iQ3aq3aF3g3MyDzY7yEZKjAyd+PiTIYIb
 Nasccus7n2pApiZC5PFxjBsVgPEugwGyQPT1YxQM77s/m9V8LbE211Wa6hpniJcPT7Nr
 vsTZRpf9NVD0UkJayVAY2oSUArIqYr5oFNe5Yma+9nMjMeaAwR+rK/5Icez8zT9ZXA6Y Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3upu2vh3p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 13:53:47 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AUDrG8D012183;
	Thu, 30 Nov 2023 13:53:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3upu2vh3nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 13:53:46 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUDnEkm008135;
	Thu, 30 Nov 2023 13:53:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukvrkx99b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 13:53:45 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AUDrh9541943586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 13:53:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DE8A20040;
	Thu, 30 Nov 2023 13:53:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF84020043;
	Thu, 30 Nov 2023 13:53:40 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.43.76.38])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Nov 2023 13:53:40 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>, dchinner@redhat.com
Subject: [RFC 6/7] ext4: Add aligned allocation support for atomic direct io
Date: Thu, 30 Nov 2023 19:23:15 +0530
Message-Id: <12ce535f947babf9fbb61e371e9127d91d9feac0.1701339358.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1701339358.git.ojaswin@linux.ibm.com>
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZcgJSjyHH58BRnZA9_Ag4OpYE70IFd08
X-Proofpoint-ORIG-GUID: X6yvcBpGxZPW6v1tnY7tMz3ypETzozu-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_12,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300102

If the direct IO write is meant to be atomic, ext4 will now try to
allocate aligned physical blocks so that atomic write request can be
satisfied.

This patch also makes the ext4_map_blocks() family of function alignment
aware and defines ext4_map_blocks_aligned() function that can allow
users to ask for aligned blocks and has checks to ensure the returned
extent actually follows the alignment requirements. As usual, alignment
requirement is always determined by the length and the offset should be
naturally aligned to this len.

Although aligned mapping usually makes sense with EXT4_GET_BLOCKS_CREATE
we can call ext4_map_blocks_aligned() without that flag aswell. This can
be useful to check:

 1. If an aligned extent is already present and can be reused.

 2. If a pre-existing extent at the location can't satisfy the alignment
 in which case and aligned write of given len and offset won't be
 possible.

 3. If there is a hole, is it big enough that a subsequent map blocks
 would be able to allocate the required aligned extent of off and len.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/ext4.h              |   4 ++
 fs/ext4/extents.c           |  14 +++++
 fs/ext4/file.c              |  49 +++++++++++++++++
 fs/ext4/inode.c             | 104 +++++++++++++++++++++++++++++++++++-
 include/trace/events/ext4.h |   1 +
 5 files changed, 170 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 38a77148b85c..1a57662e6a7a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -717,6 +717,8 @@ enum {
 #define EXT4_GET_BLOCKS_IO_SUBMIT		0x0400
 	/* Caller is in the atomic contex, find extent if it has been cached */
 #define EXT4_GET_BLOCKS_CACHED_NOWAIT		0x0800
+/* Caller wants strictly aligned allocation */
+#define EXT4_GET_BLOCKS_ALIGNED			0x1000
 
 /*
  * The bit position of these flags must not overlap with any of the
@@ -3683,6 +3685,8 @@ extern int ext4_convert_unwritten_io_end_vec(handle_t *handle,
 					     ext4_io_end_t *io_end);
 extern int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			   struct ext4_map_blocks *map, int flags);
+extern int ext4_map_blocks_aligned(handle_t *handle, struct inode *inode,
+			   struct ext4_map_blocks *map, int flags);
 extern int ext4_ext_calc_credits_for_single_extent(struct inode *inode,
 						   int num,
 						   struct ext4_ext_path *path);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 202c76996b62..2334fa767a6b 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4091,6 +4091,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	int err = 0, depth, ret;
 	unsigned int allocated = 0, offset = 0;
 	unsigned int allocated_clusters = 0;
+	unsigned int orig_mlen = map->m_len;
 	struct ext4_allocation_request ar;
 	ext4_lblk_t cluster_offset;
 
@@ -4282,6 +4283,19 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 		ar.flags |= EXT4_MB_DELALLOC_RESERVED;
 	if (flags & EXT4_GET_BLOCKS_METADATA_NOFAIL)
 		ar.flags |= EXT4_MB_USE_RESERVED;
+	if (flags & EXT4_GET_BLOCKS_ALIGNED) {
+		/*
+		 * During aligned allocation we dont want to map a length smaller
+		 * than the originally requested length since we use this len to
+		 * determine alignment and changing it can misalign the blocks.
+		 */
+		if (ar.len != orig_mlen) {
+			ext4_warning(inode->i_sb,
+				     "Tried to modify requested len of aligned allocation.");
+			goto out;
+		}
+		ar.flags |= EXT4_MB_ALIGNED_ALLOC;
+	}
 	newblock = ext4_mb_new_blocks(handle, &ar, &err);
 	if (!newblock)
 		goto out;
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 6830ea3a6c59..c928c2e8c067 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -430,6 +430,48 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
 	.end_io = ext4_dio_write_end_io,
 };
 
+/*
+ * Check loff_t because the iov_iter_count() used in blkdev was size_t
+ */
+static bool ext4_dio_atomic_write_checks(struct kiocb *iocb,
+					 struct iov_iter *from)
+{
+	struct inode *inode = iocb->ki_filp->f_inode;
+	struct block_device *bdev = inode->i_sb->s_bdev;
+	size_t len = iov_iter_count(from);
+	loff_t pos = iocb->ki_pos;
+	u8 blkbits = inode->i_blkbits;
+
+	/*
+	 * Currently aligned alloc, which is needed for atomic IO, is only
+	 * supported with extent based files and non bigalloc file systems
+	 */
+	if (EXT4_SB(inode->i_sb)->s_cluster_ratio > 1) {
+		ext4_warning(inode->i_sb,
+			     "Atomic write not supported with bigalloc");
+		return false;
+	}
+	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
+		ext4_warning(inode->i_sb,
+			     "Atomic write not supported on non-extent files");
+		return false;
+	}
+	if (len & ((1 << blkbits) - 1))
+		/* len should be blocksize aligned */
+		return false;
+	else if (pos % len)
+		/* pos should be naturally aligned to len */
+		return false;
+	else if (!is_power_of_2(len >> blkbits))
+		/*
+		 * len in blocks should be power of 2 for mballoc to ensure
+		 * alignment
+		 */
+		return false;
+
+	return blkdev_atomic_write_valid(bdev, pos, len);
+}
+
 /*
  * The intention here is to start with shared lock acquired then see if any
  * condition requires an exclusive inode lock. If yes, then we restart the
@@ -458,12 +500,19 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 	size_t count;
 	ssize_t ret;
 	bool overwrite, unaligned_io;
+	bool atomic_write = (iocb->ki_flags & IOCB_ATOMIC);
 
 restart:
 	ret = ext4_generic_write_checks(iocb, from);
 	if (ret <= 0)
 		goto out;
 
+	if (atomic_write && !ext4_dio_atomic_write_checks(iocb, from)) {
+		ext4_warning(inode->i_sb, "Atomic write checks failed.");
+		ret = -EIO;
+		goto out;
+	}
+
 	offset = iocb->ki_pos;
 	count = ret;
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4ce35f1c8b0a..d185ec54ffa3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -453,6 +453,77 @@ static void ext4_map_blocks_es_recheck(handle_t *handle,
 }
 #endif /* ES_AGGRESSIVE_TEST */
 
+/*
+ * This function checks if the map returned by ext4_map_blocks satisfies aligned
+ * allocation requirements. This should be used as the entry point for aligned
+ * allocations
+ */
+static bool ext4_map_check_alignment(struct ext4_map_blocks *map,
+				     unsigned int orig_mlen,
+				     ext4_lblk_t orig_mlblk,
+				     int flags)
+{
+	if (flags & EXT4_GET_BLOCKS_CREATE) {
+		/*
+		 * A create lookup must be mapped to satisfy alignment
+		 * requirements
+		 */
+		if (!(map->m_flags & EXT4_MAP_MAPPED))
+			return false;
+	} else {
+		/*
+		 * For create=0, if we find a hole, this hole should be big
+		 * enough to accommodate our aligned extent later
+		 */
+		if (!(map->m_flags & EXT4_MAP_MAPPED) &&
+		    (!(map->m_flags & EXT4_MAP_UNWRITTEN))) {
+			if (map->m_len < orig_mlen)
+				return false;
+			if (map->m_lblk != orig_mlblk)
+				/* Ideally shouldn't happen */
+				return false;
+			return true;
+		}
+	}
+
+	/*
+	 * For all the remaining cases, to satisfy alignment, the extent should
+	 * be exactly as big as requests and be at the right physical block
+	 * alignment
+	 */
+	if (map->m_len != orig_mlen)
+		return false;
+	if (map->m_lblk != orig_mlblk)
+		return false;
+	if (!map->m_len || map->m_pblk % map->m_len)
+		return false;
+
+	return true;
+}
+
+int ext4_map_blocks_aligned(handle_t *handle, struct inode *inode,
+			    struct ext4_map_blocks *map, int flags)
+{
+	int ret;
+	unsigned int orig_mlen = map->m_len;
+	ext4_lblk_t orig_mlblk = map->m_lblk;
+
+	if (flags & EXT4_GET_BLOCKS_CREATE)
+		flags |= EXT4_GET_BLOCKS_ALIGNED;
+
+	ret = ext4_map_blocks(handle, inode, map, flags);
+
+	if (ret >= 0 &&
+	    !ext4_map_check_alignment(map, orig_mlen, orig_mlblk, flags)) {
+		ext4_warning(
+			inode->i_sb,
+			"Returned extent couldn't satisfy alignment requirements");
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
 /*
  * The ext4_map_blocks() function tries to look up the requested blocks,
  * and returns if the blocks are already mapped.
@@ -474,6 +545,12 @@ static void ext4_map_blocks_es_recheck(handle_t *handle,
  * indicate the length of a hole starting at map->m_lblk.
  *
  * It returns the error in case of allocation failure.
+ *
+ * Note for aligned allocations: While most of the alignment related checks are
+ * done by higher level functions, we do have some optimizations here. When
+ * trying to *create* a new aligned extent if at any point we are sure that the
+ * extent won't be as big as the full length, we exit early instead of going for
+ * the allocation and failing later.
  */
 int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		    struct ext4_map_blocks *map, int flags)
@@ -481,6 +558,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	struct extent_status es;
 	int retval;
 	int ret = 0;
+	unsigned int orig_mlen = map->m_len;
 #ifdef ES_AGGRESSIVE_TEST
 	struct ext4_map_blocks orig_map;
 
@@ -583,6 +661,12 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	if ((flags & EXT4_GET_BLOCKS_CREATE) == 0)
 		return retval;
 
+	/* For aligned allocation, we must not change original alignment */
+	if (retval < 0 && (flags & EXT4_GET_BLOCKS_ALIGNED) &&
+	    map->m_len != orig_mlen) {
+		return retval;
+	}
+
 	/*
 	 * Returns if the blocks have already allocated
 	 *
@@ -3307,7 +3391,10 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
 	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
 
-	ret = ext4_map_blocks(handle, inode, map, m_flags);
+	if (flags & IOMAP_ATOMIC_WRITE)
+		ret = ext4_map_blocks_aligned(handle, inode, map, m_flags);
+	else
+		ret = ext4_map_blocks(handle, inode, map, m_flags);
 
 	/*
 	 * We cannot fill holes in indirect tree based inodes as that could
@@ -3353,7 +3440,11 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		 * especially in multi-threaded overwrite requests.
 		 */
 		if (offset + length <= i_size_read(inode)) {
-			ret = ext4_map_blocks(NULL, inode, &map, 0);
+			if (flags & IOMAP_ATOMIC_WRITE)
+				ret = ext4_map_blocks_aligned(NULL, inode, &map, 0);
+			else
+				ret = ext4_map_blocks(NULL, inode, &map, 0);
+
 			if (ret > 0 && (map.m_flags & EXT4_MAP_MAPPED))
 				goto out;
 		}
@@ -3372,6 +3463,15 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	 */
 	map.m_len = fscrypt_limit_io_blocks(inode, map.m_lblk, map.m_len);
 
+	/*
+	 * Ensure the found extent meets the alignment requirements for aligned
+	 * allocation
+	 */
+	if ((flags & IOMAP_ATOMIC_WRITE) &&
+	    ((map.m_pblk << blkbits) % length ||
+	     (map.m_len << blkbits) != length))
+		return -EIO;
+
 	ext4_set_iomap(inode, iomap, &map, offset, length, flags);
 
 	return 0;
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 56895cfb5781..7bf116021408 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -50,6 +50,7 @@ struct partial_cluster;
 	{ EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,	"CONVERT_UNWRITTEN" },  \
 	{ EXT4_GET_BLOCKS_ZERO,			"ZERO" },		\
 	{ EXT4_GET_BLOCKS_IO_SUBMIT,		"IO_SUBMIT" },		\
+	{ EXT4_GET_BLOCKS_ALIGNED,		"ALIGNED" },		\
 	{ EXT4_EX_NOCACHE,			"EX_NOCACHE" })
 
 /*
-- 
2.39.3


