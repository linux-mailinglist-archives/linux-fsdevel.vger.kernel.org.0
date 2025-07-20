Return-Path: <linux-fsdevel+bounces-55542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C39B0B83F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 23:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84CC189076E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 21:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB2F238C3C;
	Sun, 20 Jul 2025 20:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Nw6Iyvdr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76336223DDD;
	Sun, 20 Jul 2025 20:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753045097; cv=none; b=po34pnVGvyuj1U/Es0Eo+v9q8kpp1cb5O0R71t77CJ3KwSIzpmNOBjmD7Cxfcsa+gf1cvtNRctRLO8pZuYGwc5S+Nf3K7CP77GDhiew6bfEjDpxTGXficgcsVyhhZ7B6wd7m55lQ/egUvi/XLQQ6QMzTNIH07hq9gqpmatraKh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753045097; c=relaxed/simple;
	bh=PTTFrl6Cd9hxxNHnWudsPqS4EzDCkfuCyCz6kF0pSHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMIIMSa7DYFexvZHlCDcJodBtynXT1k6PrN8FpzT2ISP70UNPui0YqHefCLHRWYqSV0d7wIbB47ZgoZaUAyctdSk/mJnDvGCynLzu9kFmm5jZfbaXAMYjNcDuZzJDyfs/sqBHH1jfsaREDrP4auI889RCKWyVfDawBSwJ/p27X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Nw6Iyvdr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KAdMS2006887;
	Sun, 20 Jul 2025 20:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fuhU0cfDIvt1XI5VJ
	H1HL1G5dpQMSzc2Xe57uoNNAgs=; b=Nw6Iyvdr7uI1ogkP4m+EAYz/sZdvlUQCd
	3RGCVj7GkBkzzHSgynCxZ7vW2vH1lq394Y/8MTFijq5B/TdMtO9JKllwNEG9fjAx
	CAkVaDa6zyvt13hNN2ndv0tog5T1P2TK9fZt8Igm5qADVtzjT39IK39Uf1YyC7lq
	E70m0FrabVWUerDOcOHSxBNDkuzdloTd022GCMMpGTJGBVOepJh4sxMPjkG54HCA
	OZzKINNjKrrZIASj6MjuiJJEjp6l6gIOT5z86Z3IGjtXfE2HzULNF4jrHZ2ZmIt6
	MwaqcoeaUqzJdH52lfsyfNX9cyhmsRGPyh2sQWNI7WpK9aERAHINQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805uqngmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 20:57:54 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56KKsiHI031542;
	Sun, 20 Jul 2025 20:57:54 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805uqngmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 20:57:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56KITBAh024766;
	Sun, 20 Jul 2025 20:57:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 480rd22yds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 20:57:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56KKvpuQ35651884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 20:57:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1653220043;
	Sun, 20 Jul 2025 20:57:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80E8520040;
	Sun, 20 Jul 2025 20:57:48 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.16.241])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 20 Jul 2025 20:57:48 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        linux-kernel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [RFC v4 5/7] ext4: add extsize hint support
Date: Mon, 21 Jul 2025 02:27:31 +0530
Message-ID: <2dbc12e409a5a951f199caa2e9475b0764fac238.1753044253.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1753044253.git.ojaswin@linux.ibm.com>
References: <cover.1753044253.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZRsnN8uMegDhtn5EjeJ_OHjcUKMe1qPb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE5OCBTYWx0ZWRfX1R4Pt+s9o4Kv
 XNdQZ63Q4NNTT910ZZK3D4Rb1lFU9FfkoH8ajIgOb2DLM+5ZZbCUzjxUm5BtvL1+8/H1x9E5J8r
 5D7hcpnmyyPDLhqEn96j39DBtxSsOFswS3vViGxY5KBINp21HUsOuSFTYebimmAz5gBTtnXlDeI
 bYYtWCQZr8IorTJiBxpwmXLrFFMyJrycYDwm57M2fN40CrBEk/b0uRvbp6Oj7bNsQHo7u/fjURA
 PISLLRRrmivGUNMxtvsbc65RmhZtiz2Jlm6gs5HpdtCBgkC3cW3937ioL7CqH16xdmnIdLG9+Zo
 m40Yz/L+rLwvKu6djColloD8iBYs/LAR1vfAK2T0LeelnDcK2C5MMh76i+OLKTXz6YwtL6+hi1C
 zJQWTAXKwu3/SLEnlDQK93zrrqyi1SQgj0Qp9cWynFYXyFaWVFxe6DW5sL/P6aD0rFniGTTr
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=687d5852 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=UwJ6RSJUFbryGgyKpEoA:9
X-Proofpoint-GUID: uQ7f2q9NjL_iC_MvJjHECDtOtAHeyEGZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507200198

Now that the ioctl is in place, add the underlying infrastructure
to support extent size hints.

** MOTIVATION **

1. This feature allows us to ask the allocator for blocks that are
logically AS WELL AS physically aligned to an extent size hint (aka
extsize), that is generally a power of 2.

2. This means both start and the length of the physical and logical range
should be aligned to the extsize.

3. This sets up the infra we'll eventually need for supporting
  non-torn/atomic writes that need to follow a certain alignment as
  required by hardware.

4. This can also be extent to other use cases like stripe alignment

** DESIGN NOTES **

* Physical Alignment *

1. Since the extsize is always a power-of-2 (for now) in fs blocks, we
leverage CR_POWER2_ALIGNED allocation to get the blocks. This ensures the
blocks are physically aligned

2. Since this is just a hint, incase we are not able to get any aligned
blocks we simply drop back to non aligned allocation.

* Logical Alignment *

The flow of extsize aligned allocation with buffered and
direct IO:

            +--------------------------------------------------------+
            |                     Buffered IO                        |
            +--------------------------------------------------------+
            |    ext4_map_blocks() call with extsize allocation      |
            +--------------------------------------------------------+
                                       |
                 +--------------------------------------------+
                 |  Adjust lblk and len to align to extsize   |
                 +--------------------------------------------+
                                       |
            +--------------------------------------------------------+
            |Pre-existing written/unwritten blocks in extsize range? |
            +--------------------------+-----------------------------+
                   YES                                     NO
                    |                                       |
    +---------------v---------------+      +----------------v--------------+
    |     Covers orig range?        |      |    Allocate extsize range     |
    +---------------+---------------+      +----------------+--------------+
         |                    |                             |
        YES                  NO                             |
         |                    |              +--------------v--------------+
+--------v-------+    +-------v---------+    |   Mark allocated extent as  |
| Return blocks  |    | Fallback to     |    |           unwritten         |
+----------------+    | non-extsize     |    +--------------+--------------+
                      | allocation      |                   |
                      +-----------------+    +--------------v--------------+
                                             |   Insert extsize extent     |
                                             |         into tree           |
                                             +--------------+--------------+
                                                            |
                                             +--------------v--------------+
                                             |   Return allocated blocks   |
                                             +-----------------------------+

                   +--------------------------------------------+
                   |           During writeback:                |
                   +--------------------------------------------+
                   |  Use PRE_IO to split only the dirty extent |
                   +--------------------------------------------+

                   +--------------------------------------------+
                   |              After IO:                     |
                   +--------------------------------------------+
                   |    Convert the extent under IO to written  |
                   +--------------------------------------------+

Same flow for direct IO:

+----------------------------------------------------------------------+
|                              Direct IO                               |
+----------------------------------------------------------------------+
|   ext4_map_blocks() called with extsize allocation and PRE-IO        |
+----------------------------------------------------------------------+
                                   |
+----------------------------------------------------------------------+
|         Adjust lblk and len to align to extsize                      |
+----------------------------------------------------------------------+
                                   |
+----------------------------------------------------------------------+
|        Pre-existing written blocks in extsize range?                 |
+----------------------------------+-----------------------------------+
             YES                                    NO
              |                                      |
    +---------v----------+        +------------------v-----------------+
    | Covers orig range? |        | Unwritten blocks in extsize range? |
    +---------+----------+        +------------------+-----------------+
        |            |                     |                    |
       YES          NO                    YES                  NO
        |            |                     |                    |
+-------v----+ +-----v--------+ +----------v----------+ +-------v----------+
|   Return   | | Fallback to  | | Call ext4_ext_map_  | | Allocate extsize |
|   blocks   | | non-extsize  | | blocks() ->ext4_ext | |      range       |
+------------+ | allocation   | | _handle_unwritten_  | +-------+----------+
               +--------------+ |     extents()       |         |
                                +----------+----------+ +-------v----------+
                                           |            |  Mark complete   |
                                +----------v----------+ | range unwritten  |
                                | Split orig range    | |  & insert in     |
                                | from bigger         | |      tree        |
                                | unwritten extent    | +-------+----------+
                                +----------+----------+         |
                                           |            +-------v----------+
                                +----------v----------+ | Split orig range |
                                | Mark split extent   | | from bigger      |
                                |    as unwritten     | | allocated extent |
                                +----------+----------+ +-------+----------+
                                           |                    |
                                +----------v----------+ +-------v----------+
                                | Return split extent | | Mark split extent|
                                |      to user        | |   as unwritten   |
                                +---------------------+ +-------+----------+
                                                                |
                                                        +-------v----------+
                                                        | Return split     |
                                                        | extent to user   |
                                                        +------------------+

              +--------------------------------------------+
              |              After IO:                     |
              +--------------------------------------------+
              |    Convert the extent under IO to written  |
              +--------------------------------------------+

** IMPLEMENTATION NOTES **

* Callers of ext4_map_blocks work under the assumption that
  ext4_map_blocks will always only return as much as requested or less
  but now we might end up allocating more so make changes to
  ext4_map_blocks to make sure we adjust the allocated map to only
  return as much as user requested.

* Further, we now maintain 2 maps in ext4_map_blocks - the original map
  and the extsize map that is used when extsize hint allocation is taking
  place. We also pass these 2 maps down because some functions might now
  need information of the original map as well as the extsize map.
  * For example, when we go for direct IO and there's a hole in the orig
    range requested, we allocate based on extsize range and then split the
    bigger unwritten extent onto smaller unwritten extents based on orig
    range. (Needed so we dont have to split after IO). For this, we need
    the information of extsize range as well as orig range hence 2 maps.

* Since now we allocate more than the user requested, to avoid stale
  data exposure, we mark the bigger extsize extent as unwritten and then
  use the similar flow of dioread_nolock to only mark the extent under
  write as written.

* We disable extsize hints when writes are beyond EOF (for now)

* When extsize is set on an inode, we drop to no delalloc allocations
  similar to XFS.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/ext4.h      |   7 +-
 fs/ext4/ext4_jbd2.h |  15 ++
 fs/ext4/extents.c   | 174 +++++++++++++++++++--
 fs/ext4/inode.c     | 359 +++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 497 insertions(+), 58 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index d00870cb15f2..4b69326a0f2f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -746,6 +746,7 @@ enum {
  * Look EXT4_MAP_QUERY_LAST_IN_LEAF.
  */
 #define EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF	0x1000
+#define EXT4_GET_BLOCKS_EXTSIZE		0x2000
 
 /*
  * The bit position of these flags must not overlap with any of the
@@ -765,7 +766,8 @@ enum {
  */
 #define EXT4_EX_QUERY_FILTER	(EXT4_EX_NOCACHE | EXT4_EX_FORCE_CACHE |\
 				 EXT4_EX_NOFAIL |\
-				 EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF)
+				 EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF |\
+				 EXT4_GET_BLOCKS_EXTSIZE)
 
 /*
  * Flags used by ext4_free_blocks
@@ -3755,7 +3757,8 @@ struct ext4_extent;
 extern void ext4_ext_tree_init(handle_t *handle, struct inode *inode);
 extern int ext4_ext_index_trans_blocks(struct inode *inode, int extents);
 extern int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
-			       struct ext4_map_blocks *map, int flags);
+			       struct ext4_map_blocks *orig_map,
+			       struct ext4_map_blocks *extsize_map, int flags);
 extern int ext4_ext_truncate(handle_t *, struct inode *);
 extern int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 				 ext4_lblk_t end);
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 63d17c5201b5..dbac8d4f7f78 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -458,4 +458,19 @@ static inline int ext4_journal_destroy(struct ext4_sb_info *sbi, journal_t *jour
 	return err;
 }
 
+static inline int ext4_should_use_extsize(struct inode *inode)
+{
+	if (!S_ISREG(inode->i_mode))
+		return 0;
+	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
+		return 0;
+	return (ext4_inode_get_extsize(EXT4_I(inode)) > 0);
+}
+
+static inline int ext4_should_use_unwrit_extents(struct inode *inode)
+{
+	return (ext4_should_dioread_nolock(inode) ||
+		ext4_should_use_extsize(inode));
+}
+
 #endif	/* _EXT4_JBD2_H */
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 3233ab89c99e..8ea8b03a4a16 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3892,15 +3892,24 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 
 static struct ext4_ext_path *
 ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
-			struct ext4_map_blocks *map,
+			struct ext4_map_blocks *orig_map,
+			struct ext4_map_blocks *extsize_map,
 			struct ext4_ext_path *path, int flags,
 			unsigned int *allocated, ext4_fsblk_t newblock)
 {
+	struct ext4_map_blocks *map;
 	int err = 0;
 
-	ext_debug(inode, "logical block %llu, max_blocks %u, flags 0x%x, allocated %u\n",
-		  (unsigned long long)map->m_lblk, map->m_len, flags,
-		  *allocated);
+	if (flags & EXT4_GET_BLOCKS_EXTSIZE) {
+		BUG_ON(extsize_map == NULL);
+		map = extsize_map;
+	} else
+		map = orig_map;
+
+	ext_debug(
+		inode,
+		"logical block %llu, max_blocks %u, flags 0x%x, allocated %u\n",
+		(unsigned long long)map->m_lblk, map->m_len, flags, *allocated);
 	ext4_ext_show_leaf(inode, path);
 
 	/*
@@ -3909,13 +3918,14 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 	 */
 	flags |= EXT4_GET_BLOCKS_METADATA_NOFAIL;
 
-	trace_ext4_ext_handle_unwritten_extents(inode, map, flags,
-						*allocated, newblock);
+	trace_ext4_ext_handle_unwritten_extents(inode, map, flags, *allocated,
+						newblock);
 
 	/* get_block() before submitting IO, split the extent */
 	if (flags & EXT4_GET_BLOCKS_PRE_IO) {
+		/* Split should always happen based on original mapping */
 		path = ext4_split_convert_extents(
-			handle, inode, map->m_lblk, map->m_len, path,
+			handle, inode, orig_map->m_lblk, orig_map->m_len, path,
 			flags | EXT4_GET_BLOCKS_CONVERT, allocated);
 		if (IS_ERR(path))
 			return path;
@@ -3930,11 +3940,19 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 			err = -EFSCORRUPTED;
 			goto errout;
 		}
+
+		/*
+		 * For extsize case we need to adjust lblk to start of split
+		 * extent because the m_len will be set to len of split extent.
+		 * No change for non extsize case
+		 */
+		map->m_lblk = orig_map->m_lblk;
 		map->m_flags |= EXT4_MAP_UNWRITTEN;
 		goto out;
 	}
 	/* IO end_io complete, convert the filled extent to written */
 	if (flags & EXT4_GET_BLOCKS_CONVERT) {
+		BUG_ON(map == extsize_map);
 		path = ext4_convert_unwritten_extents_endio(handle, inode,
 							    map, path);
 		if (IS_ERR(path))
@@ -4192,7 +4210,8 @@ static ext4_lblk_t ext4_ext_determine_insert_hole(struct inode *inode,
  * return < 0, error case.
  */
 int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
-			struct ext4_map_blocks *map, int flags)
+			struct ext4_map_blocks *orig_map,
+			struct ext4_map_blocks *extsize_map, int flags)
 {
 	struct ext4_ext_path *path = NULL;
 	struct ext4_extent newex, *ex, ex2;
@@ -4203,6 +4222,17 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	unsigned int allocated_clusters = 0;
 	struct ext4_allocation_request ar;
 	ext4_lblk_t cluster_offset;
+	struct ext4_map_blocks *map;
+#ifdef CONFIG_EXT4_DEBUG
+	struct ext4_ext_path *test_path = NULL;
+#endif
+
+	if (flags & EXT4_GET_BLOCKS_EXTSIZE) {
+		BUG_ON(extsize_map == NULL);
+		map = extsize_map;
+	} else
+		map = orig_map;
+
 
 	ext_debug(inode, "blocks %u/%u requested\n", map->m_lblk, map->m_len);
 	trace_ext4_ext_map_blocks_enter(inode, map->m_lblk, map->m_len, flags);
@@ -4259,6 +4289,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 			 */
 			if ((!ext4_ext_is_unwritten(ex)) &&
 			    (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN)) {
+				BUG_ON(map == extsize_map);
 				path = convert_initialized_extent(handle,
 					inode, map, path, &allocated);
 				if (IS_ERR(path))
@@ -4275,8 +4306,8 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 			}
 
 			path = ext4_ext_handle_unwritten_extents(
-				handle, inode, map, path, flags,
-				&allocated, newblock);
+				handle, inode, orig_map, extsize_map, path,
+				flags, &allocated, newblock);
 			if (IS_ERR(path))
 				err = PTR_ERR(path);
 			goto out;
@@ -4309,6 +4340,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	 */
 	if (cluster_offset && ex &&
 	    get_implied_cluster_alloc(inode->i_sb, map, ex, path)) {
+		BUG_ON(map == extsize_map);
 		ar.len = allocated = map->m_len;
 		newblock = map->m_pblk;
 		goto got_allocated_blocks;
@@ -4329,6 +4361,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	 * cluster we can use. */
 	if ((sbi->s_cluster_ratio > 1) && err &&
 	    get_implied_cluster_alloc(inode->i_sb, map, &ex2, path)) {
+		BUG_ON(map == extsize_map);
 		ar.len = allocated = map->m_len;
 		newblock = map->m_pblk;
 		err = 0;
@@ -4383,6 +4416,8 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 		ar.flags |= EXT4_MB_DELALLOC_RESERVED;
 	if (flags & EXT4_GET_BLOCKS_METADATA_NOFAIL)
 		ar.flags |= EXT4_MB_USE_RESERVED;
+	if (flags & EXT4_GET_BLOCKS_EXTSIZE)
+		ar.flags |= EXT4_MB_HINT_ALIGNED;
 	newblock = ext4_mb_new_blocks(handle, &ar, &err);
 	if (!newblock)
 		goto out;
@@ -4404,9 +4439,114 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 		map->m_flags |= EXT4_MAP_UNWRITTEN;
 	}
 
-	path = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
-	if (IS_ERR(path)) {
-		err = PTR_ERR(path);
+	if ((flags & EXT4_GET_BLOCKS_EXTSIZE) &&
+	    (flags & EXT4_GET_BLOCKS_PRE_IO)) {
+		/*
+		 * With EXTSIZE and PRE-IO (direct io case) we have to be careful
+		 * because we want to insert the complete extent but split only the
+		 * originally requested range.
+		 *
+		 * Below are the different (S)cenarios and the (A)ction we take:
+		 *
+		 * S1: New extent covers the original range completely/partially.
+		 * A1: Insert new extent, allow merges. Then split the original
+		 * range from this. Adjust the length of split if new extent only
+		 * partially covers original.
+		 *
+		 * S2: New extent doesn't cover original range at all
+		 * A2: Just insert this range and return. Rest is handled in
+		 * ext4_map_blocks()
+		 * NOTE: We can handle this as an error with EAGAIN in future.
+		 */
+		ext4_lblk_t newex_lblk = le32_to_cpu(newex.ee_block);
+		loff_t newex_len = ext4_ext_get_actual_len(&newex);
+
+		if (in_range(orig_map->m_lblk, newex_lblk, newex_len)) {
+			/* S1 */
+			loff_t split_len = 0;
+
+			BUG_ON(!ext4_ext_is_unwritten(&newex));
+
+			if (newex_lblk + newex_len >=
+			    orig_map->m_lblk + (loff_t)orig_map->m_len)
+				split_len = orig_map->m_len;
+			else
+				split_len = newex_len -
+					    (orig_map->m_lblk - newex_lblk);
+
+			path = ext4_ext_insert_extent(
+				handle, inode, path, &newex,
+				(flags & ~EXT4_GET_BLOCKS_PRE_IO));
+			if (IS_ERR(path)) {
+				err = PTR_ERR(path);
+				goto insert_error;
+			}
+
+			/*
+			 * Update path before split
+			 * NOTE: This might no longer be needed with recent
+			 * changes in ext4_ext_insert_extent()
+			 */
+			path = ext4_find_extent(inode, orig_map->m_lblk, path, 0);
+			if (IS_ERR(path)) {
+				err = PTR_ERR(path);
+				goto insert_error;
+			}
+
+			/*
+			 * GET_BLOCKS_CONVERT is needed to make sure split
+			 * extent is marked unwritten although the flags itself
+			 * means that the extent should be converted to written.
+			 *
+			 * TODO: This is because ext4_split_convert_extents()
+			 * doesn't respect the flags at all but fixing this
+			 * needs more involved design changes.
+			 */
+			path = ext4_split_convert_extents(
+				handle, inode, orig_map->m_lblk, split_len,
+				path, flags | EXT4_GET_BLOCKS_CONVERT, NULL);
+			if (IS_ERR(path)) {
+				err = PTR_ERR(path);
+				goto insert_error;
+			}
+
+#ifdef CONFIG_EXT4_DEBUG
+			test_path = ext4_find_extent(inode, orig_map->m_lblk,
+						     NULL, 0);
+			if (!IS_ERR(test_path)) {
+				/* Confirm we've correctly split and marked the extent unwritten */
+				struct ext4_extent *test_ex =
+					test_path[ext_depth(inode)].p_ext;
+				WARN_ON(!ext4_ext_is_unwritten(test_ex));
+				WARN_ON(test_ex->ee_block != orig_map->m_lblk);
+				WARN_ON(ext4_ext_get_actual_len(test_ex) !=
+					orig_map->m_len);
+				kfree(test_path);
+			}
+#endif
+		} else {
+			/* S2 */
+			BUG_ON(orig_map->m_lblk < newex_lblk + newex_len);
+
+			path = ext4_ext_insert_extent(
+				handle, inode, path, &newex,
+				(flags & ~EXT4_GET_BLOCKS_PRE_IO));
+			if (IS_ERR(path)) {
+				err = PTR_ERR(path);
+				goto insert_error;
+			}
+		}
+	} else {
+		path = ext4_ext_insert_extent(handle, inode, path, &newex,
+					      flags);
+		if (IS_ERR(path)) {
+			err = PTR_ERR(path);
+			goto insert_error;
+		}
+	}
+
+insert_error:
+	if (err) {
 		if (allocated_clusters) {
 			int fb_flags = 0;
 
@@ -4690,7 +4830,7 @@ static long ext4_do_fallocate(struct file *file, loff_t offset,
 	loff_t end = offset + len;
 	loff_t new_size = 0;
 	ext4_lblk_t start_lblk, len_lblk;
-	int ret;
+	int ret, flags;
 
 	trace_ext4_fallocate_enter(inode, offset, len, mode);
 	WARN_ON_ONCE(!inode_is_locked(inode));
@@ -4712,8 +4852,12 @@ static long ext4_do_fallocate(struct file *file, loff_t offset,
 			goto out;
 	}
 
+	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
+	if (ext4_should_use_extsize(inode))
+		flags |= EXT4_GET_BLOCKS_EXTSIZE;
+
 	ret = ext4_alloc_file_blocks(file, start_lblk, len_lblk, new_size,
-				     EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT);
+				     flags);
 	if (ret)
 		goto out;
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 664218228fd5..385fbd745e12 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -459,7 +459,7 @@ static void ext4_map_blocks_es_recheck(handle_t *handle,
 	 */
 	down_read(&EXT4_I(inode)->i_data_sem);
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
-		retval = ext4_ext_map_blocks(handle, inode, map, 0);
+		retval = ext4_ext_map_blocks(handle, inode, map, NULL, 0);
 	} else {
 		retval = ext4_ind_map_blocks(handle, inode, map, 0);
 	}
@@ -501,7 +501,7 @@ static int ext4_map_query_blocks_next_in_leaf(handle_t *handle,
 	map2.m_lblk = map->m_lblk + map->m_len;
 	map2.m_len = orig_mlen - map->m_len;
 	map2.m_flags = 0;
-	retval = ext4_ext_map_blocks(handle, inode, &map2, 0);
+	retval = ext4_ext_map_blocks(handle, inode, &map2, NULL, 0);
 
 	if (retval <= 0) {
 		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
@@ -539,17 +539,37 @@ static int ext4_map_query_blocks_next_in_leaf(handle_t *handle,
 }
 
 static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
-				 struct ext4_map_blocks *map, int flags)
+				 struct ext4_map_blocks *orig_map,
+				 struct ext4_map_blocks *extsize_map,
+				 int flags)
 {
 	unsigned int status;
 	int retval;
-	unsigned int orig_mlen = map->m_len;
+	unsigned int orig_mlen;
+	struct ext4_map_blocks *map;
 
 	flags &= EXT4_EX_QUERY_FILTER;
+
+	if (flags & EXT4_GET_BLOCKS_EXTSIZE) {
+		BUG_ON(extsize_map == NULL);
+		map = extsize_map;
+	} else
+		map = orig_map;
+
+	orig_mlen = map->m_len;
+
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		retval = ext4_ext_map_blocks(handle, inode, map, flags);
-	else
+		if (flags & EXT4_GET_BLOCKS_EXTSIZE) {
+			retval = ext4_ext_map_blocks(handle, inode, orig_map,
+						     map, flags);
+		} else {
+			retval = ext4_ext_map_blocks(handle, inode, map, NULL,
+						     flags);
+		}
+	else {
+		BUG_ON(flags & EXT4_GET_BLOCKS_EXTSIZE);
 		retval = ext4_ind_map_blocks(handle, inode, map, flags);
+	}
 
 	if (retval <= 0)
 		return retval;
@@ -581,11 +601,20 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
 }
 
 static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
-				  struct ext4_map_blocks *map, int flags)
+				  struct ext4_map_blocks *orig_map,
+				  struct ext4_map_blocks *extsize_map,
+				  int flags)
 {
 	struct extent_status es;
 	unsigned int status;
 	int err, retval = 0;
+	struct ext4_map_blocks *map;
+
+	if (flags & EXT4_GET_BLOCKS_EXTSIZE) {
+		BUG_ON(extsize_map == NULL);
+		map = extsize_map;
+	} else
+		map = orig_map;
 
 	/*
 	 * We pass in the magic EXT4_GET_BLOCKS_DELALLOC_RESERVE
@@ -606,8 +635,15 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
 	 * changed the inode type in between.
 	 */
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
-		retval = ext4_ext_map_blocks(handle, inode, map, flags);
+		if (flags & EXT4_GET_BLOCKS_EXTSIZE) {
+			retval = ext4_ext_map_blocks(handle, inode, orig_map,
+						     map, flags);
+		} else {
+			retval = ext4_ext_map_blocks(handle, inode, map, NULL,
+						     flags);
+		}
 	} else {
+		BUG_ON(flags & EXT4_GET_BLOCKS_EXTSIZE);
 		retval = ext4_ind_map_blocks(handle, inode, map, flags);
 
 		/*
@@ -662,6 +698,80 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
 	return retval;
 }
 
+/**
+ * Extsize hint will change the mapped range and hence we'll end up mapping more.
+ * To not confuse the caller, adjust the struct ext4_map_blocks to reflect the
+ * original mapping requested by them.
+ *
+ * @cur_map:		The block mapping we are working with (for sanity check)
+ * @orig_map:		The originally requested mapping
+ * @extsize_map:	The mapping after adjusting for extsize hint
+ * @flags		Get block flags (for sanity check)
+ *
+ * This function assumes that the orig_mlblk is contained within the mapping
+ * held in extsize_map. Caller must make sure this is true.
+ */
+static inline unsigned int ext4_extsize_adjust_map(struct ext4_map_blocks *cur_map,
+					   struct ext4_map_blocks *orig_map,
+					   struct ext4_map_blocks *extsize_map,
+					   int flags)
+{
+	__u64 map_end = (__u64)extsize_map->m_lblk + extsize_map->m_len;
+
+	BUG_ON(cur_map != extsize_map || !(flags & EXT4_GET_BLOCKS_EXTSIZE));
+
+	orig_map->m_len = min(orig_map->m_len, map_end - orig_map->m_lblk);
+	orig_map->m_pblk =
+		extsize_map->m_pblk + (orig_map->m_lblk - extsize_map->m_lblk);
+	orig_map->m_flags = extsize_map->m_flags;
+
+	return orig_map->m_len;
+}
+
+/**
+ * ext4_error_adjust_map - Adjust map returned upon error in ext4_map_blocks()
+ *
+ * @cur_map: current map we are working with
+ * @orig_map: original map that would be returned to the user.
+ *
+ * Most of the callers of ext4_map_blocks() ignore the map on error, however
+ * some use it for debug logging. In this case, they log state of the map just
+ * before the error, hence this function ensures that map returned to caller is
+ * the one we were working with when error happened. Mostly useful when extsize
+ * hints are enabled.
+ */
+static inline void ext4_error_adjust_map(struct ext4_map_blocks *cur_map,
+					 struct ext4_map_blocks *orig_map)
+{
+	if (cur_map != orig_map)
+		memcpy(orig_map, cur_map, sizeof(*cur_map));
+}
+
+/*
+ * This functions resets the mapping to it's original state after it has been
+ * modified due to extent size hint and drops the extsize hint. To be used
+ * incase we want to fallback from extsize based aligned allocation to normal
+ * allocation
+ *
+ * @map:		The block mapping where lblk and len have been modified
+ *			because	of extsize hint
+ * @flags:		The get_block flags
+ * @orig_mlblk:		The originally requested logical block to map
+ * @orig_mlen:		The originally requested len to map
+ * @orig_flags:		The originally requested get_block flags
+ */
+static inline void ext4_extsize_reset_map(struct ext4_map_blocks *map,
+					  int *flags, ext4_lblk_t orig_mlblk,
+					  unsigned int orig_mlen,
+					  int orig_flags)
+{
+	/* Drop the extsize hint from original flags */
+	*flags = orig_flags & ~EXT4_GET_BLOCKS_EXTSIZE;
+	map->m_lblk = orig_mlblk;
+	map->m_len = orig_mlen;
+	map->m_flags = 0;
+}
+
 /*
  * The ext4_map_blocks() function tries to look up the requested blocks,
  * and returns if the blocks are already mapped.
@@ -686,30 +796,40 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
  * It returns the error in case of allocation failure.
  */
 int ext4_map_blocks(handle_t *handle, struct inode *inode,
-		    struct ext4_map_blocks *map, int flags)
+		    struct ext4_map_blocks *orig_map, int flags)
 {
 	struct extent_status es;
 	int retval;
 	int ret = 0;
-	unsigned int orig_mlen = map->m_len;
+
+	ext4_lblk_t orig_mlblk, extsize_mlblk;
+	unsigned int orig_mlen, extsize_mlen;
+	int orig_flags;
+
+	struct ext4_map_blocks *map = NULL;
+	struct ext4_map_blocks extsize_map = {0};
+
+	__u32 extsize = ext4_inode_get_extsize(EXT4_I(inode));
+	bool should_extsize = false;
+
 #ifdef ES_AGGRESSIVE_TEST
-	struct ext4_map_blocks orig_map;
+	struct ext4_map_blocks test_map;
 
-	memcpy(&orig_map, map, sizeof(*map));
+	memcpy(&test_map, map, sizeof(*map));
 #endif
 
-	map->m_flags = 0;
-	ext_debug(inode, "flag 0x%x, max_blocks %u, logical block %lu\n",
-		  flags, map->m_len, (unsigned long) map->m_lblk);
+	orig_map->m_flags = 0;
+	ext_debug(inode, "flag 0x%x, max_blocks %u, logical block %lu\n", flags,
+		  orig_map->m_len, (unsigned long)orig_map->m_lblk);
 
 	/*
 	 * ext4_map_blocks returns an int, and m_len is an unsigned int
 	 */
-	if (unlikely(map->m_len > INT_MAX))
-		map->m_len = INT_MAX;
+	if (unlikely(orig_map->m_len > INT_MAX))
+		orig_map->m_len = INT_MAX;
 
 	/* We can handle the block number less than EXT_MAX_BLOCKS */
-	if (unlikely(map->m_lblk >= EXT_MAX_BLOCKS))
+	if (unlikely(orig_map->m_lblk >= EXT_MAX_BLOCKS))
 		return -EFSCORRUPTED;
 
 	/*
@@ -722,6 +842,73 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	else
 		ext4_check_map_extents_env(inode);
 
+	orig_mlblk = orig_map->m_lblk;
+	orig_mlen = orig_map->m_len;
+	orig_flags = flags;
+
+set_map:
+	should_extsize = (extsize && (flags & EXT4_GET_BLOCKS_CREATE) &&
+			       (flags & EXT4_GET_BLOCKS_EXTSIZE));
+	if (should_extsize) {
+		/*
+		 * We adjust the extent size here but we still return the
+		 * original lblk and len while returning to keep the behavior
+		 * compatible.
+		 */
+		int len, align;
+		/*
+		 * NOTE: Should we import EXT_UNWRITTEN_MAX_LEN from
+		 * ext4_extents.h here?
+		 */
+		int max_unwrit_len = ((1UL << 15) - 1);
+		loff_t end;
+
+		align = orig_map->m_lblk % extsize;
+		len = orig_map->m_len + align;
+
+		extsize_map.m_lblk = orig_map->m_lblk - align;
+		extsize_map.m_len =
+			max_t(unsigned int, roundup_pow_of_two(len), extsize);
+
+		/*
+		 * For now allocations beyond EOF don't use extsize hints so
+		 * that we can avoid dealing with extra blocks allocated past
+		 * EOF. We have inode lock since extsize allocations are
+		 * non-delalloc so i_size can be accessed safely
+		 */
+		end = (extsize_map.m_lblk + (loff_t)extsize_map.m_len) << inode->i_blkbits;
+		if (end > inode->i_size) {
+			flags = orig_flags & ~EXT4_GET_BLOCKS_EXTSIZE;
+			goto set_map;
+		}
+
+		/* Fallback to normal allocation if we go beyond max len */
+		if (extsize_map.m_len >= max_unwrit_len) {
+			flags = orig_flags & ~EXT4_GET_BLOCKS_EXTSIZE;
+			goto set_map;
+		}
+
+		/*
+		 * We are allocating more than requested. We'll have to convert
+		 * the extent to unwritten and then convert only the part
+		 * requested to written. For now we are using the same flow as
+		 * dioread nolock to achieve this. Hence the caller has to pass
+		 * CREATE_UNWRIT with EXTSIZE
+		 */
+		if (WARN_ON_ONCE(!(flags & EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT))) {
+			/* Fallback to non extsize allocation */
+			flags = orig_flags & ~EXT4_GET_BLOCKS_EXTSIZE;
+			goto set_map;
+		}
+
+		extsize_mlblk = extsize_map.m_lblk;
+		extsize_mlen = extsize_map.m_len;
+
+		extsize_map.m_flags = orig_map->m_flags;
+		map = &extsize_map;
+	} else
+		map = orig_map;
+
 	/* Lookup extent status tree firstly */
 	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
 		if (ext4_es_is_written(&es) || ext4_es_is_unwritten(&es)) {
@@ -750,7 +937,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			return retval;
 #ifdef ES_AGGRESSIVE_TEST
 		ext4_map_blocks_es_recheck(handle, inode, map,
-					   &orig_map, flags);
+					   &test_map, flags);
 #endif
 		if (!(flags & EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF) ||
 				orig_mlen == map->m_len)
@@ -770,19 +957,58 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	 * file system block.
 	 */
 	down_read(&EXT4_I(inode)->i_data_sem);
-	retval = ext4_map_query_blocks(handle, inode, map, flags);
+	if (should_extsize) {
+		BUG_ON(map != &extsize_map);
+		retval = ext4_map_query_blocks(handle, inode, orig_map, map, flags);
+	} else {
+		BUG_ON(map != orig_map);
+		retval = ext4_map_query_blocks(handle, inode, map, NULL, flags);
+	}
 	up_read((&EXT4_I(inode)->i_data_sem));
 
 found:
 	if (retval > 0 && map->m_flags & EXT4_MAP_MAPPED) {
 		ret = check_block_validity(inode, map);
-		if (ret != 0)
+		if (ret != 0) {
+			ext4_error_adjust_map(map, orig_map);
 			return ret;
+		}
 	}
 
 	/* If it is only a block(s) look up */
-	if ((flags & EXT4_GET_BLOCKS_CREATE) == 0)
+	if ((flags & EXT4_GET_BLOCKS_CREATE) == 0) {
+		BUG_ON(flags & EXT4_GET_BLOCKS_EXTSIZE);
 		return retval;
+	}
+
+	/* Handle some special cases when extsize based allocation is needed */
+	if (retval >= 0 && flags & EXT4_GET_BLOCKS_EXTSIZE) {
+		bool orig_in_range =
+			in_range(orig_mlblk, (__u64)map->m_lblk, map->m_len);
+		/*
+		 * Special case: if the extsize range is mapped already and
+		 * covers the original start, we return it.
+		 */
+		if (map->m_flags & EXT4_MAP_MAPPED && orig_in_range) {
+			/*
+			 * We don't use EXTSIZE with CONVERT_UNWRITTEN so
+			 * we can directly return the written extent
+			 */
+			return ext4_extsize_adjust_map(map, orig_map, &extsize_map, flags);
+		}
+
+		/*
+		 * Fallback case: if the found mapping (or hole) doesn't cover
+		 * the extsize required, then just fall back to normal
+		 * allocation to keep things simple.
+		 */
+
+		if (map->m_lblk != extsize_mlblk ||
+		    map->m_len != extsize_mlen) {
+			flags = orig_flags & ~EXT4_GET_BLOCKS_EXTSIZE;
+			goto set_map;
+		}
+	}
 
 	/*
 	 * Returns if the blocks have already allocated
@@ -808,12 +1034,22 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	 * with create == 1 flag.
 	 */
 	down_write(&EXT4_I(inode)->i_data_sem);
-	retval = ext4_map_create_blocks(handle, inode, map, flags);
+	if (should_extsize) {
+		BUG_ON(map != &extsize_map);
+		retval = ext4_map_create_blocks(handle, inode, orig_map, map,
+						flags);
+	} else {
+		BUG_ON(map != orig_map);
+		retval = ext4_map_create_blocks(handle, inode, map, NULL,
+						flags);
+	}
 	up_write((&EXT4_I(inode)->i_data_sem));
 	if (retval > 0 && map->m_flags & EXT4_MAP_MAPPED) {
 		ret = check_block_validity(inode, map);
-		if (ret != 0)
+		if (ret != 0) {
+			ext4_error_adjust_map(map, orig_map);
 			return ret;
+		}
 
 		/*
 		 * Inodes with freshly allocated blocks where contents will be
@@ -835,16 +1071,38 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			else
 				ret = ext4_jbd2_inode_add_write(handle, inode,
 						start_byte, length);
-			if (ret)
+			if (ret) {
+				ext4_error_adjust_map(map, orig_map);
 				return ret;
+			}
 		}
 	}
 	if (retval > 0 && (map->m_flags & EXT4_MAP_UNWRITTEN ||
 				map->m_flags & EXT4_MAP_MAPPED))
 		ext4_fc_track_range(handle, inode, map->m_lblk,
 					map->m_lblk + map->m_len - 1);
-	if (retval < 0)
+
+	if (retval > 0 && flags & EXT4_GET_BLOCKS_EXTSIZE) {
+		/*
+		 * In the rare case that we have a short allocation and orig
+		 * lblk doesn't lie in mapped range just try to retry with
+		 * actual allocation. This is not ideal but this should be an
+		 * edge case near ENOSPC.
+		 *
+		 * NOTE: This has a side effect that blocks are allocated but
+		 * not used. Can we avoid that?
+		 */
+		if (!in_range(orig_mlblk, (__u64)map->m_lblk, map->m_len)) {
+			flags = orig_flags & ~EXT4_GET_BLOCKS_EXTSIZE;
+			goto set_map;
+		}
+		return ext4_extsize_adjust_map(map, orig_map, &extsize_map, flags);
+	}
+
+	if (retval < 0) {
+		ext4_error_adjust_map(map, orig_map);
 		ext_debug(inode, "failed with err %d\n", retval);
+	}
 	return retval;
 }
 
@@ -900,18 +1158,20 @@ static int _ext4_get_block(struct inode *inode, sector_t iblock,
 {
 	struct ext4_map_blocks map;
 	int ret = 0;
+	unsigned int orig_mlen = bh->b_size >> inode->i_blkbits;
 
 	if (ext4_has_inline_data(inode))
 		return -ERANGE;
 
 	map.m_lblk = iblock;
-	map.m_len = bh->b_size >> inode->i_blkbits;
+	map.m_len = orig_mlen;
 
 	ret = ext4_map_blocks(ext4_journal_current_handle(), inode, &map,
 			      flags);
 	if (ret > 0) {
 		map_bh(bh, inode->i_sb, map.m_pblk);
 		ext4_update_bh_state(bh, map.m_flags);
+		WARN_ON(map.m_len != orig_mlen);
 		bh->b_size = inode->i_sb->s_blocksize * map.m_len;
 		ret = 0;
 	} else if (ret == 0) {
@@ -937,11 +1197,14 @@ int ext4_get_block_unwritten(struct inode *inode, sector_t iblock,
 			     struct buffer_head *bh_result, int create)
 {
 	int ret = 0;
+	int flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
+
+	if (ext4_should_use_extsize(inode))
+		flags |= EXT4_GET_BLOCKS_EXTSIZE;
 
 	ext4_debug("ext4_get_block_unwritten: inode %lu, create flag %d\n",
 		   inode->i_ino, create);
-	ret = _ext4_get_block(inode, iblock, bh_result,
-			       EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT);
+	ret = _ext4_get_block(inode, iblock, bh_result, flags);
 
 	/*
 	 * If the buffer is marked unwritten, mark it as new to make sure it is
@@ -1298,7 +1561,8 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 			ext4_journal_blocks_per_folio(inode)) + 1;
 	index = pos >> PAGE_SHIFT;
 
-	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
+	if (!ext4_should_use_extsize(inode) &&
+	    ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
 		ret = ext4_try_to_write_inline_data(mapping, inode, pos, len,
 						    foliop);
 		if (ret < 0)
@@ -1354,7 +1618,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	/* In case writeback began while the folio was unlocked */
 	folio_wait_stable(folio);
 
-	if (ext4_should_dioread_nolock(inode))
+	if (ext4_should_use_unwrit_extents(inode))
 		ret = ext4_block_write_begin(handle, folio, pos, len,
 					     ext4_get_block_unwritten);
 	else
@@ -1948,7 +2212,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
 	if (ext4_has_inline_data(inode))
 		retval = 0;
 	else
-		retval = ext4_map_query_blocks(NULL, inode, map, 0);
+		retval = ext4_map_query_blocks(NULL, inode, map, NULL, 0);
 	up_read(&EXT4_I(inode)->i_data_sem);
 	if (retval)
 		return retval < 0 ? retval : 0;
@@ -1971,7 +2235,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
 			goto found;
 		}
 	} else if (!ext4_has_inline_data(inode)) {
-		retval = ext4_map_query_blocks(NULL, inode, map, 0);
+		retval = ext4_map_query_blocks(NULL, inode, map, NULL, 0);
 		if (retval) {
 			up_write(&EXT4_I(inode)->i_data_sem);
 			return retval < 0 ? retval : 0;
@@ -2344,6 +2608,7 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
 	struct ext4_map_blocks *map = &mpd->map;
 	int get_blocks_flags;
 	int err, dioread_nolock;
+	int extsize = ext4_should_use_extsize(inode);
 
 	/* Make sure transaction has enough credits for this extent */
 	err = ext4_journal_ensure_extent_credits(handle, inode);
@@ -2371,11 +2636,14 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
 	dioread_nolock = ext4_should_dioread_nolock(inode);
 	if (dioread_nolock)
 		get_blocks_flags |= EXT4_GET_BLOCKS_IO_CREATE_EXT;
+	if (extsize)
+		get_blocks_flags |= EXT4_GET_BLOCKS_PRE_IO;
 
 	err = ext4_map_blocks(handle, inode, map, get_blocks_flags);
 	if (err < 0)
 		return err;
-	if (dioread_nolock && (map->m_flags & EXT4_MAP_UNWRITTEN)) {
+	if ((extsize || dioread_nolock) &&
+	    (map->m_flags & EXT4_MAP_UNWRITTEN)) {
 		if (!mpd->io_submit.io_end->handle &&
 		    ext4_handle_valid(handle)) {
 			mpd->io_submit.io_end->handle = handle->h_rsv_handle;
@@ -2832,12 +3100,13 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 	}
 	mpd->journalled_more_data = 0;
 
-	if (ext4_should_dioread_nolock(inode)) {
-		int bpf = ext4_journal_blocks_per_folio(inode);
+	if (ext4_should_use_unwrit_extents(inode)) {
 		/*
-		 * We may need to convert up to one extent per block in
-		 * the folio and we may dirty the inode.
+		 * For extsize allocation or dioread_nolock, we may need to
+		 * convert up to one extent per block in the page and we may
+		 * dirty the inode.
 		 */
+		int bpf = ext4_journal_blocks_per_folio(inode);
 		rsv_blocks = 1 + ext4_ext_index_trans_blocks(inode, bpf);
 	}
 
@@ -3125,7 +3394,8 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 
 	index = pos >> PAGE_SHIFT;
 
-	if (ext4_nonda_switch(inode->i_sb) || ext4_verity_in_progress(inode)) {
+	if (ext4_nonda_switch(inode->i_sb) || ext4_verity_in_progress(inode) ||
+	    ext4_should_use_extsize(inode)) {
 		*fsdata = (void *)FALL_BACK_TO_NONDELALLOC;
 		return ext4_write_begin(file, mapping, pos,
 					len, foliop, fsdata);
@@ -3740,12 +4010,19 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
 	 * can complete at any point during the I/O and subsequently push the
 	 * i_disksize out to i_size. This could be beyond where direct I/O is
 	 * happening and thus expose allocated blocks to direct I/O reads.
+	 *
+	 * NOTE for extsize hints: We only support it for writes inside
+	 * EOF (for now) to not have to deal with blocks past EOF
 	 */
 	else if (((loff_t)map->m_lblk << blkbits) >= i_size_read(inode))
 		m_flags = EXT4_GET_BLOCKS_CREATE;
-	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
 		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
 
+		if (ext4_should_use_extsize(inode))
+			m_flags |= EXT4_GET_BLOCKS_EXTSIZE;
+	}
+
 	if (flags & IOMAP_ATOMIC)
 		ret = ext4_map_blocks_atomic_write(handle, inode, map, m_flags,
 						   &force_commit);
@@ -6778,7 +7055,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	}
 	folio_unlock(folio);
 	/* OK, we need to fill the hole... */
-	if (ext4_should_dioread_nolock(inode))
+	if (ext4_should_use_unwrit_extents(inode))
 		get_block = ext4_get_block_unwritten;
 retry_alloc:
 	/* Start journal and allocate blocks */
-- 
2.49.0


