Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC291CC77A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 09:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgEJHI7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 03:08:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30940 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728575AbgEJHI7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 03:08:59 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04A73pCK072597;
        Sun, 10 May 2020 03:08:53 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30xa2g2ue8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 03:08:52 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04A75nw9000693;
        Sun, 10 May 2020 07:08:51 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 30wm568tvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 07:08:50 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04A78lDs7406024
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 May 2020 07:08:48 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBB4B4204C;
        Sun, 10 May 2020 07:08:47 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37C3F4203F;
        Sun, 10 May 2020 07:08:46 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.61.127])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 10 May 2020 07:08:45 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFCv4 4/6] ext4: mballoc: Add blocks to PA list under same spinlock after allocating blocks
Date:   Sun, 10 May 2020 12:38:24 +0530
Message-Id: <e1fcc47a29ba74b3b3c55670dce1476fe3719c07.1589086820.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1589086820.git.riteshh@linux.ibm.com>
References: <cover.1589086820.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-10_02:2020-05-08,2020-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 mlxscore=0
 suspectscore=3 malwarescore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005100065
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ext4_mb_discard_preallocations() only checks for grp->bb_prealloc_list
of every group to discard the group's PA to free up the space if
allocation request fails. Consider below race:-

Process A  				Process B

1. allocate blocks
					1. Fails block allocation from
					     ext4_mb_regular_allocator()
   ext4_lock_group()
	allocated blocks
	more than ac_o_ex.fe_len
   ext4_unlock_group()
					2. Scans the
					   grp->bb_prealloc_list (under
					   ext4_lock_group()) and
					   find nothing and thus return
					   -ENOSPC.

2. Add the additional blocks to PA list

   ext4_lock_group()
   	add blocks to grp->bb_prealloc_list
   ext4_unlock_group()

Above race could be avoided if we add those additional blocks to
grp->bb_prealloc_list at the same time with block allocation when
ext4_lock_group() was still held.
With this discard-PA will know if there are actually any blocks which
could be freed from the PA

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/mballoc.c | 97 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 35 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 7d766dc34cdd..574ce400a3b5 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -349,6 +349,7 @@ static void ext4_mb_generate_from_pa(struct super_block *sb, void *bitmap,
 					ext4_group_t group);
 static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
 						ext4_group_t group);
+static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac);
 
 static inline void *mb_correct_addr_and_bit(int *bit, void *addr)
 {
@@ -1701,6 +1702,14 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 		sbi->s_mb_last_start = ac->ac_f_ex.fe_start;
 		spin_unlock(&sbi->s_md_lock);
 	}
+	/*
+	 * As we've just preallocated more space than
+	 * user requested originally, we store allocated
+	 * space in a special descriptor.
+	 */
+	if (ac->ac_o_ex.fe_len < ac->ac_b_ex.fe_len)
+		ext4_mb_new_preallocation(ac);
+
 }
 
 /*
@@ -1949,7 +1958,7 @@ void ext4_mb_simple_scan_group(struct ext4_allocation_context *ac,
 
 		ext4_mb_use_best_found(ac, e4b);
 
-		BUG_ON(ac->ac_b_ex.fe_len != ac->ac_g_ex.fe_len);
+		BUG_ON(ac->ac_f_ex.fe_len != ac->ac_g_ex.fe_len);
 
 		if (EXT4_SB(sb)->s_mb_stats)
 			atomic_inc(&EXT4_SB(sb)->s_bal_2orders);
@@ -3702,7 +3711,7 @@ static void ext4_mb_put_pa(struct ext4_allocation_context *ac,
 /*
  * creates new preallocated space for given inode
  */
-static noinline_for_stack int
+static noinline_for_stack void
 ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 {
 	struct super_block *sb = ac->ac_sb;
@@ -3715,10 +3724,9 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 	BUG_ON(ac->ac_o_ex.fe_len >= ac->ac_b_ex.fe_len);
 	BUG_ON(ac->ac_status != AC_STATUS_FOUND);
 	BUG_ON(!S_ISREG(ac->ac_inode->i_mode));
+	BUG_ON(ac->ac_pa == NULL);
 
-	pa = kmem_cache_alloc(ext4_pspace_cachep, GFP_NOFS);
-	if (pa == NULL)
-		return -ENOMEM;
+	pa = ac->ac_pa;
 
 	if (ac->ac_b_ex.fe_len < ac->ac_g_ex.fe_len) {
 		int winl;
@@ -3762,7 +3770,6 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 	pa->pa_pstart = ext4_grp_offs_to_block(sb, &ac->ac_b_ex);
 	pa->pa_len = ac->ac_b_ex.fe_len;
 	pa->pa_free = pa->pa_len;
-	atomic_set(&pa->pa_count, 1);
 	spin_lock_init(&pa->pa_lock);
 	INIT_LIST_HEAD(&pa->pa_inode_list);
 	INIT_LIST_HEAD(&pa->pa_group_list);
@@ -3782,21 +3789,17 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 	pa->pa_obj_lock = &ei->i_prealloc_lock;
 	pa->pa_inode = ac->ac_inode;
 
-	ext4_lock_group(sb, ac->ac_b_ex.fe_group);
 	list_add(&pa->pa_group_list, &grp->bb_prealloc_list);
-	ext4_unlock_group(sb, ac->ac_b_ex.fe_group);
 
 	spin_lock(pa->pa_obj_lock);
 	list_add_rcu(&pa->pa_inode_list, &ei->i_prealloc_list);
 	spin_unlock(pa->pa_obj_lock);
-
-	return 0;
 }
 
 /*
  * creates new preallocated space for locality group inodes belongs to
  */
-static noinline_for_stack int
+static noinline_for_stack void
 ext4_mb_new_group_pa(struct ext4_allocation_context *ac)
 {
 	struct super_block *sb = ac->ac_sb;
@@ -3808,11 +3811,9 @@ ext4_mb_new_group_pa(struct ext4_allocation_context *ac)
 	BUG_ON(ac->ac_o_ex.fe_len >= ac->ac_b_ex.fe_len);
 	BUG_ON(ac->ac_status != AC_STATUS_FOUND);
 	BUG_ON(!S_ISREG(ac->ac_inode->i_mode));
+	BUG_ON(ac->ac_pa == NULL);
 
-	BUG_ON(ext4_pspace_cachep == NULL);
-	pa = kmem_cache_alloc(ext4_pspace_cachep, GFP_NOFS);
-	if (pa == NULL)
-		return -ENOMEM;
+	pa = ac->ac_pa;
 
 	/* preallocation can change ac_b_ex, thus we store actually
 	 * allocated blocks for history */
@@ -3822,7 +3823,6 @@ ext4_mb_new_group_pa(struct ext4_allocation_context *ac)
 	pa->pa_lstart = pa->pa_pstart;
 	pa->pa_len = ac->ac_b_ex.fe_len;
 	pa->pa_free = pa->pa_len;
-	atomic_set(&pa->pa_count, 1);
 	spin_lock_init(&pa->pa_lock);
 	INIT_LIST_HEAD(&pa->pa_inode_list);
 	INIT_LIST_HEAD(&pa->pa_group_list);
@@ -3843,26 +3843,20 @@ ext4_mb_new_group_pa(struct ext4_allocation_context *ac)
 	pa->pa_obj_lock = &lg->lg_prealloc_lock;
 	pa->pa_inode = NULL;
 
-	ext4_lock_group(sb, ac->ac_b_ex.fe_group);
 	list_add(&pa->pa_group_list, &grp->bb_prealloc_list);
-	ext4_unlock_group(sb, ac->ac_b_ex.fe_group);
 
 	/*
 	 * We will later add the new pa to the right bucket
 	 * after updating the pa_free in ext4_mb_release_context
 	 */
-	return 0;
 }
 
-static int ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
+static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
 {
-	int err;
-
 	if (ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC)
-		err = ext4_mb_new_group_pa(ac);
+		ext4_mb_new_group_pa(ac);
 	else
-		err = ext4_mb_new_inode_pa(ac);
-	return err;
+		ext4_mb_new_inode_pa(ac);
 }
 
 /*
@@ -4177,6 +4171,29 @@ void ext4_discard_preallocations(struct inode *inode)
 	}
 }
 
+static int ext4_mb_pa_alloc(struct ext4_allocation_context *ac)
+{
+	struct ext4_prealloc_space *pa;
+
+	BUG_ON(ext4_pspace_cachep == NULL);
+	pa = kmem_cache_zalloc(ext4_pspace_cachep, GFP_NOFS);
+	if (!pa)
+		return -ENOMEM;
+	atomic_set(&pa->pa_count, 1);
+	ac->ac_pa = pa;
+	return 0;
+}
+
+static void ext4_mb_pa_free(struct ext4_allocation_context *ac)
+{
+	struct ext4_prealloc_space *pa = ac->ac_pa;
+
+	BUG_ON(!pa);
+	ac->ac_pa = NULL;
+	WARN_ON(!atomic_dec_and_test(&pa->pa_count));
+	kmem_cache_free(ext4_pspace_cachep, pa);
+}
+
 #ifdef CONFIG_EXT4_DEBUG
 static inline void ext4_mb_show_pa(struct super_block *sb)
 {
@@ -4633,23 +4650,28 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 	if (!ext4_mb_use_preallocated(ac)) {
 		ac->ac_op = EXT4_MB_HISTORY_ALLOC;
 		ext4_mb_normalize_request(ac, ar);
+
+		*errp = ext4_mb_pa_alloc(ac);
+		if (*errp)
+			goto errout;
 repeat:
 		/* allocate space in core */
 		*errp = ext4_mb_regular_allocator(ac);
-		if (*errp)
-			goto discard_and_exit;
-
-		/* as we've just preallocated more space than
-		 * user requested originally, we store allocated
-		 * space in a special descriptor */
-		if (ac->ac_status == AC_STATUS_FOUND &&
-		    ac->ac_o_ex.fe_len < ac->ac_b_ex.fe_len)
-			*errp = ext4_mb_new_preallocation(ac);
+		/*
+		 * pa allocated above is added to grp->bb_prealloc_list only
+		 * when we were able to allocate some block i.e. when
+		 * ac->ac_status == AC_STATUS_FOUND.
+		 * And error from above mean ac->ac_status != AC_STATUS_FOUND
+		 * So we have to free this pa here itself.
+		 */
 		if (*errp) {
-		discard_and_exit:
+			ext4_mb_pa_free(ac);
 			ext4_discard_allocated_blocks(ac);
 			goto errout;
 		}
+		if (ac->ac_status == AC_STATUS_FOUND &&
+			ac->ac_o_ex.fe_len >= ac->ac_f_ex.fe_len)
+			ext4_mb_pa_free(ac);
 	}
 	if (likely(ac->ac_status == AC_STATUS_FOUND)) {
 		*errp = ext4_mb_mark_diskspace_used(ac, handle, reserv_clstrs);
@@ -4664,6 +4686,11 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 		freed  = ext4_mb_discard_preallocations(sb, ac->ac_o_ex.fe_len);
 		if (freed)
 			goto repeat;
+		/*
+		 * If block allocation fails then the pa allocated above
+		 * needs to be freed here itself.
+		 */
+		ext4_mb_pa_free(ac);
 		*errp = -ENOSPC;
 	}
 
-- 
2.21.0

