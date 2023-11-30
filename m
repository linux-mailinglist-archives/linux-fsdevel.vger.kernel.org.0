Return-Path: <linux-fsdevel+bounces-4398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981B57FF2B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1432826CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0758651007
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ABOUMGVV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7A719B2;
	Thu, 30 Nov 2023 05:53:43 -0800 (PST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUDlTRp023890;
	Thu, 30 Nov 2023 13:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bYDR8LkQhx5OY1pT1Z1ofFxDBMEDbq4D27syqk5XqQU=;
 b=ABOUMGVVwncvaTZmqhRw6fiMBHpIhDnU6r7kID3adD037aHOcPvVbGPK9F2Qb/VISvAj
 4dRnxuimG2qamfS0ravs6RdX5UYiT+i6o8tMPPBesYzi9uvICUP9o0gUqsO4NF+/0E1B
 CkNJGhe6zp2Zj31fr0TOhJv0QdHfompNh+8vBkcuYWtN3M+ecpqwMoF46YCqjYP/iHzf
 MArsSA+FumxmYs2GGtlL4dYMmSgcEXCegJhWVbGrwG4hR38QIjlO60l1WXp4l6hoRHRJ
 c55KeMgNss6oFNlpBX6by7pQeqfnCwf872R+PH6/Tk7pJhn6OEkzHvznr3dOIAVhKh04 pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3upuk2r5dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 13:53:37 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AUDoT6K001367;
	Thu, 30 Nov 2023 13:53:37 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3upuk2r5cu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 13:53:37 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUDnBZj029489;
	Thu, 30 Nov 2023 13:53:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfke1sd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 13:53:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AUDrYss18350602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 13:53:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82CC820043;
	Thu, 30 Nov 2023 13:53:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F9442004B;
	Thu, 30 Nov 2023 13:53:31 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.43.76.38])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Nov 2023 13:53:31 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>, dchinner@redhat.com
Subject: [RFC 3/7] ext4: add aligned allocation support in mballoc
Date: Thu, 30 Nov 2023 19:23:12 +0530
Message-Id: <7c652ff11d4d52466e0d40fc9bdd1a0c24fc80fa.1701339358.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: IE4ZHkm339pwYeRMJWL0J4jJf1oSVeM2
X-Proofpoint-ORIG-GUID: fkaP7um2Xq0baNu7XtfiAy1OY4Z-VHN-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_12,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300102

Add support in mballoc for allocating blocks that are aligned
to a certain power-of-2 offset.

1. We define a new flag EXT4_MB_ALIGNED_ALLOC to indicate that we want
an aligned allocation.

2. The alignment is determined by the length of the allocation, for
example if we ask for 8192 bytes, then the alignment of physical blocks
will also be 8192 bytes aligned (ie 2 blocks aligned on 4k blocksize).

3. We dont yet support arbitrary alignment. For aligned writes, the
length/alignment must be power of 2 blocks, ie for 4k blocksize we
can get 4k byte aligned, 8k byte aligned, 16k byte aligned ...
allocation but not 12k byte aligned.

4. We use CR_POWER2_ALIGNED criteria for aligned allocation which by
design allocates in an aligned manner. Since CR_POWER2_ALIGNED needs the
ac->ac_g_ex.fe_len to be power of 2, thats where the restriction in
point 3 above comes from. Since right now aligned allocation support is
added mainly for atomic writes use case, this restriction should be fine
since atomic write capable devices usually support only power of 2
alignments

5. For ease of review enabling inode preallocation support is done in
upcoming patches and is disabled in this patch.

6. In case we can't find anything in CR_POWER2_ALIGNED, we return ENOSPC.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/ext4.h              |  6 ++--
 fs/ext4/mballoc.c           | 69 ++++++++++++++++++++++++++++++++++---
 include/trace/events/ext4.h |  1 +
 3 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9418359b1d9d..38a77148b85c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -216,9 +216,11 @@ enum criteria {
 /* Large fragment size list lookup succeeded at least once for cr = 0 */
 #define EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED		0x8000
 /* Avg fragment size rb tree lookup succeeded at least once for cr = 1 */
-#define EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED		0x00010000
+#define EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED		0x10000
 /* Avg fragment size rb tree lookup succeeded at least once for cr = 1.5 */
-#define EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED		0x00020000
+#define EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED		0x20000
+/* The allocation must respect alignment requirements for physical blocks */
+#define EXT4_MB_ALIGNED_ALLOC		0x40000
 
 struct ext4_allocation_request {
 	/* target inode for block we're allocating */
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 3eb7b639d36e..b1df531e6db3 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2150,8 +2150,11 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 	 * user requested originally, we store allocated
 	 * space in a special descriptor.
 	 */
-	if (ac->ac_o_ex.fe_len < ac->ac_b_ex.fe_len)
+	if (ac->ac_o_ex.fe_len < ac->ac_b_ex.fe_len) {
+		/* Aligned allocation doesn't have preallocation support */
+		WARN_ON(ac->ac_flags & EXT4_MB_ALIGNED_ALLOC);
 		ext4_mb_new_preallocation(ac);
+	}
 
 }
 
@@ -2784,10 +2787,15 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 
 	BUG_ON(ac->ac_status == AC_STATUS_FOUND);
 
-	/* first, try the goal */
-	err = ext4_mb_find_by_goal(ac, &e4b);
-	if (err || ac->ac_status == AC_STATUS_FOUND)
-		goto out;
+	/*
+	 * first, try the goal. Skip trying goal for aligned allocations since
+	 * goal determination logic is not alignment aware (yet)
+	 */
+	if (!(ac->ac_flags & EXT4_MB_ALIGNED_ALLOC)) {
+		err = ext4_mb_find_by_goal(ac, &e4b);
+		if (err || ac->ac_status == AC_STATUS_FOUND)
+			goto out;
+	}
 
 	if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
 		goto out;
@@ -2828,9 +2836,26 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	 */
 	if (ac->ac_2order)
 		cr = CR_POWER2_ALIGNED;
+	else
+		WARN_ON(ac->ac_flags & EXT4_MB_ALIGNED_ALLOC &&
+			ac->ac_g_ex.fe_len > 1);
 repeat:
 	for (; cr < EXT4_MB_NUM_CRS && ac->ac_status == AC_STATUS_CONTINUE; cr++) {
 		ac->ac_criteria = cr;
+
+		if (ac->ac_criteria > CR_POWER2_ALIGNED &&
+		    ac->ac_flags & EXT4_MB_ALIGNED_ALLOC &&
+		    ac->ac_g_ex.fe_len > 1
+		    ) {
+			/*
+			 * Aligned allocation only supports power 2 alignment
+			 * values which can only be satisfied by
+			 * CR_POWER2_ALIGNED. The exception being allocations of
+			 * 1 block which can be done via any criteria
+			 */
+			break;
+		}
+
 		/*
 		 * searching for the right group start
 		 * from the goal value specified
@@ -2955,6 +2980,23 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	if (!err && ac->ac_status != AC_STATUS_FOUND && first_err)
 		err = first_err;
 
+	if (ac->ac_flags & EXT4_MB_ALIGNED_ALLOC && ac->ac_status == AC_STATUS_FOUND) {
+		ext4_fsblk_t start = ext4_grp_offs_to_block(sb, &ac->ac_b_ex);
+		ext4_grpblk_t len = EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
+
+		if (!len) {
+			ext4_warning(sb, "Expected a non zero len extent");
+			ac->ac_status = AC_STATUS_BREAK;
+			goto exit;
+		}
+
+		WARN_ON(!is_power_of_2(len));
+		WARN_ON(start % len);
+		/* We don't support preallocation yet */
+		WARN_ON(ac->ac_b_ex.fe_len != ac->ac_o_ex.fe_len);
+	}
+
+ exit:
 	mb_debug(sb, "Best len %d, origin len %d, ac_status %u, ac_flags 0x%x, cr %d ret %d\n",
 		 ac->ac_b_ex.fe_len, ac->ac_o_ex.fe_len, ac->ac_status,
 		 ac->ac_flags, cr, err);
@@ -4475,6 +4517,13 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	if (ac->ac_flags & EXT4_MB_HINT_NOPREALLOC)
 		return;
 
+	/*
+	 * caller may have strict alignment requirements. In this case, avoid
+	 * normalization since it is not alignment aware.
+	 */
+	if (ac->ac_flags & EXT4_MB_ALIGNED_ALLOC)
+		return;
+
 	if (ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC) {
 		ext4_mb_normalize_group_request(ac);
 		return ;
@@ -4790,6 +4839,10 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	if (!(ac->ac_flags & EXT4_MB_HINT_DATA))
 		return false;
 
+	/* using preallocated blocks is not alignment aware. */
+	if (ac->ac_flags & EXT4_MB_ALIGNED_ALLOC)
+		return false;
+
 	/*
 	 * first, try per-file preallocation by searching the inode pa rbtree.
 	 *
@@ -6069,6 +6122,12 @@ static bool ext4_mb_discard_preallocations_should_retry(struct super_block *sb,
 	u64 seq_retry = 0;
 	bool ret = false;
 
+	/* No need to retry for aligned allocations */
+	if (ac->ac_flags & EXT4_MB_ALIGNED_ALLOC) {
+		ret = false;
+		goto out_dbg;
+	}
+
 	freed = ext4_mb_discard_preallocations(sb, ac->ac_o_ex.fe_len);
 	if (freed) {
 		ret = true;
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 65029dfb92fb..56895cfb5781 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -36,6 +36,7 @@ struct partial_cluster;
 	{ EXT4_MB_STREAM_ALLOC,		"STREAM_ALLOC" },	\
 	{ EXT4_MB_USE_ROOT_BLOCKS,	"USE_ROOT_BLKS" },	\
 	{ EXT4_MB_USE_RESERVED,		"USE_RESV" },		\
+	{ EXT4_MB_ALIGNED_ALLOC,		"ALIGNED_ALLOC" }, \
 	{ EXT4_MB_STRICT_CHECK,		"STRICT_CHECK" })
 
 #define show_map_flags(flags) __print_flags(flags, "|",			\
-- 
2.39.3


