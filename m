Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AB66C8C76
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Mar 2023 09:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjCYIPT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Mar 2023 04:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjCYIOf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:14:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6FA10411;
        Sat, 25 Mar 2023 01:14:17 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32P7DZJq032164;
        Sat, 25 Mar 2023 08:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=/yoeCE6V6jvLdau19B+JvbTtBQvaVEOxZ182cPGsGNo=;
 b=OPe6fZUNPl+3Oulik83sNnlioeUT/nqWbqDMQvCIIYIzqJ/I2czN4MD07deRphV4xHJO
 ncU6VNUoU88xQB3EuSk8yPI7kB/rewg4euC8veb8vJQf2nQDV5RTzjouZhJFhuOJQTNj
 xRDIEdx3Gwg/ENjB7lsy3E7t6bYOTwWu+OrKAcrPgpTptznftZG2Cg6zfdKRq+nPh0x6
 wxXyGJfP4TVkOGnmpaB9/S0XM/H/PIxcugoou82SlYPGzm9U4ocoCqE2J/UlM1nT23Dq
 gR50d5mvax2w3Pi8HU8swRgGIU7VxrRr4Dh7DNXYyAgTuUqg4WBL7H43ilcm+t/khFRa RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3phvckgpet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Mar 2023 08:14:11 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32P8EBJ0011221;
        Sat, 25 Mar 2023 08:14:11 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3phvckgpek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Mar 2023 08:14:11 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32P2shDa007247;
        Sat, 25 Mar 2023 08:14:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3phrk6g71p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Mar 2023 08:14:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32P8E6bT23528010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Mar 2023 08:14:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7DDD2004E;
        Sat, 25 Mar 2023 08:14:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67A6020040;
        Sat, 25 Mar 2023 08:14:04 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.63.61])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 25 Mar 2023 08:14:04 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v6 8/9] ext4: Use rbtrees to manage PAs instead of inode i_prealloc_list
Date:   Sat, 25 Mar 2023 13:43:41 +0530
Message-Id: <4137bce8f6948fedd8bae134dabae24acfe699c6.1679731817.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1679731817.git.ojaswin@linux.ibm.com>
References: <cover.1679731817.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SEZGFNdGb4HUQE7p8f7Rh9eILq_cgym1
X-Proofpoint-GUID: 8xkAkoI41Whd5WHQ3XS_B3o5ZppAkHs3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303250065
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, the kernel uses i_prealloc_list to hold all the inode
preallocations. This is known to cause degradation in performance in
workloads which perform large number of sparse writes on a single file.
This is mainly because functions like ext4_mb_normalize_request() and
ext4_mb_use_preallocated() iterate over this complete list, resulting in
slowdowns when large number of PAs are present.

Patch 27bc446e2 partially fixed this by enforcing a limit of 512 for
the inode preallocation list and adding logic to continually trim the
list if it grows above the threshold, however our testing revealed that
a hardcoded value is not suitable for all kinds of workloads.

To optimize this, add an rbtree to the inode and hold the inode
preallocations in this rbtree. This will make iterating over inode PAs
faster and scale much better than a linked list. Additionally, we also
had to remove the LRU logic that was added during trimming of the list
(in ext4_mb_release_context()) as it will add extra overhead in rbtree.
The discards now happen in the lowest-logical-offset-first order.

** Locking notes **

With the introduction of rbtree to maintain inode PAs, we can't use RCU
to walk the tree for searching since it can result in partial traversals
which might miss some nodes(or entire subtrees) while discards happen
in parallel (which happens under a lock).  Hence this patch converts the
ei->i_prealloc_lock spin_lock to rw_lock.

Almost all the codepaths that read/modify the PA rbtrees are protected
by the higher level inode->i_data_sem (except
ext4_mb_discard_group_preallocations() and ext4_clear_inode()) IIUC, the
only place we need lock protection is when one thread is reading
"searching" the PA rbtree (earlier protected under rcu_read_lock()) and
another is "deleting" the PAs in ext4_mb_discard_group_preallocations()
function (which iterates all the PAs using the grp->bb_prealloc_list and
deletes PAs from the tree without taking any inode lock (i_data_sem)).

So, this patch converts all rcu_read_lock/unlock() paths for inode list
PA to use read_lock() and all places where we were using
ei->i_prealloc_lock spinlock will now be using write_lock().

Note that this makes the fast path (searching of the right PA e.g.
ext4_mb_use_preallocated() or ext4_mb_normalize_request()), now use
read_lock() instead of rcu_read_lock/unlock().  Ths also will now block
due to slow discard path (ext4_mb_discard_group_preallocations()) which
uses write_lock().

But this is not as bad as it looks. This is because -

1. The slow path only occurs when the normal allocation failed and we
   can say that we are low on disk space.  One can argue this scenario
   won't be much frequent.

2. ext4_mb_discard_group_preallocations(), locks and unlocks the rwlock
   for deleting every individual PA.  This gives enough opportunity for
   the fast path to acquire the read_lock for searching the PA inode
   list.

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h    |   4 +-
 fs/ext4/mballoc.c | 286 +++++++++++++++++++++++++++++++++-------------
 fs/ext4/mballoc.h |   6 +-
 fs/ext4/super.c   |   4 +-
 4 files changed, 214 insertions(+), 86 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9b2cfc32cf78..8cf955b1dca5 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1120,8 +1120,8 @@ struct ext4_inode_info {
 
 	/* mballoc */
 	atomic_t i_prealloc_active;
-	struct list_head i_prealloc_list;
-	spinlock_t i_prealloc_lock;
+	struct rb_root i_prealloc_node;
+	rwlock_t i_prealloc_lock;
 
 	/* extents status tree */
 	struct ext4_es_tree i_es_tree;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 711661219473..f7603dafb672 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3978,6 +3978,24 @@ static void ext4_mb_normalize_group_request(struct ext4_allocation_context *ac)
 	mb_debug(sb, "goal %u blocks for locality group\n", ac->ac_g_ex.fe_len);
 }
 
+/*
+ * This function returns the next element to look at during inode
+ * PA rbtree walk. We assume that we have held the inode PA rbtree lock
+ * (ei->i_prealloc_lock)
+ *
+ * new_start	The start of the range we want to compare
+ * cur_start	The existing start that we are comparing against
+ * node	The node of the rb_tree
+ */
+static inline struct rb_node*
+ext4_mb_pa_rb_next_iter(ext4_lblk_t new_start, ext4_lblk_t cur_start, struct rb_node *node)
+{
+	if (new_start < cur_start)
+		return node->rb_left;
+	else
+		return node->rb_right;
+}
+
 static inline void
 ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
 			  ext4_lblk_t start, ext4_lblk_t end)
@@ -3986,19 +4004,22 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
 	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
 	struct ext4_prealloc_space *tmp_pa;
 	ext4_lblk_t tmp_pa_start, tmp_pa_end;
+	struct rb_node *iter;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
-		spin_lock(&tmp_pa->pa_lock);
-		if (tmp_pa->pa_deleted == 0) {
-			tmp_pa_start = tmp_pa->pa_lstart;
-			tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
+	read_lock(&ei->i_prealloc_lock);
+	for (iter = ei->i_prealloc_node.rb_node; iter;
+	     iter = ext4_mb_pa_rb_next_iter(start, tmp_pa_start, iter)) {
+		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
+				  pa_node.inode_node);
+		tmp_pa_start = tmp_pa->pa_lstart;
+		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
 
+		spin_lock(&tmp_pa->pa_lock);
+		if (tmp_pa->pa_deleted == 0)
 			BUG_ON(!(start >= tmp_pa_end || end <= tmp_pa_start));
-		}
 		spin_unlock(&tmp_pa->pa_lock);
 	}
-	rcu_read_unlock();
+	read_unlock(&ei->i_prealloc_lock);
 }
 
 /*
@@ -4006,60 +4027,140 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
  * and adjust boundaries if the range overlaps with any of the existing
  * preallocatoins stored in the corresponding inode of the allocation context.
  *
- *Parameters:
+ * Parameters:
  *	ac			allocation context
  *	start			start of the new range
  *	end			end of the new range
  */
 static inline void
 ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
-			 ext4_lblk_t *start, ext4_lblk_t *end)
+			  ext4_lblk_t *start, ext4_lblk_t *end)
 {
 	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
-	struct ext4_prealloc_space *tmp_pa;
+	struct ext4_prealloc_space *tmp_pa = NULL, *left_pa = NULL, *right_pa = NULL;
+	struct rb_node *iter;
 	ext4_lblk_t new_start, new_end;
-	ext4_lblk_t tmp_pa_start, tmp_pa_end;
+	ext4_lblk_t tmp_pa_start, tmp_pa_end, left_pa_end = -1, right_pa_start = -1;
 
 	new_start = *start;
 	new_end = *end;
 
-	/* check we don't cross already preallocated blocks */
-	rcu_read_lock();
-	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
-		if (tmp_pa->pa_deleted)
-			continue;
-		spin_lock(&tmp_pa->pa_lock);
-		if (tmp_pa->pa_deleted) {
-			spin_unlock(&tmp_pa->pa_lock);
-			continue;
-		}
-
+	/*
+	 * Adjust the normalized range so that it doesn't overlap with any
+	 * existing preallocated blocks(PAs). Make sure to hold the rbtree lock
+	 * so it doesn't change underneath us.
+	 */
+	read_lock(&ei->i_prealloc_lock);
+
+	/* Step 1: find any one immediate neighboring PA of the normalized range */
+	for (iter = ei->i_prealloc_node.rb_node; iter;
+	     iter = ext4_mb_pa_rb_next_iter(ac->ac_o_ex.fe_logical,
+					    tmp_pa_start, iter)) {
+		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
+				  pa_node.inode_node);
 		tmp_pa_start = tmp_pa->pa_lstart;
 		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
 
 		/* PA must not overlap original request */
-		BUG_ON(!(ac->ac_o_ex.fe_logical >= tmp_pa_end ||
-			ac->ac_o_ex.fe_logical < tmp_pa_start));
+		spin_lock(&tmp_pa->pa_lock);
+		if (tmp_pa->pa_deleted == 0)
+			BUG_ON(!(ac->ac_o_ex.fe_logical >= tmp_pa_end ||
+				 ac->ac_o_ex.fe_logical < tmp_pa_start));
+		spin_unlock(&tmp_pa->pa_lock);
+	}
 
-		/* skip PAs this normalized request doesn't overlap with */
-		if (tmp_pa_start >= new_end || tmp_pa_end <= new_start) {
+	/*
+	 * Step 2: check if the found PA is left or right neighbor and
+	 * get the other neighbor
+	 */
+	if (tmp_pa) {
+		if (tmp_pa->pa_lstart < ac->ac_o_ex.fe_logical) {
+			struct rb_node *tmp;
+
+			left_pa = tmp_pa;
+			tmp = rb_next(&left_pa->pa_node.inode_node);
+			if (tmp) {
+				right_pa = rb_entry(tmp,
+						    struct ext4_prealloc_space,
+						    pa_node.inode_node);
+			}
+		} else {
+			struct rb_node *tmp;
+
+			right_pa = tmp_pa;
+			tmp = rb_prev(&right_pa->pa_node.inode_node);
+			if (tmp) {
+				left_pa = rb_entry(tmp,
+						   struct ext4_prealloc_space,
+						   pa_node.inode_node);
+			}
+		}
+	}
+
+	/* Step 3: get the non deleted neighbors */
+	if (left_pa) {
+		for (iter = &left_pa->pa_node.inode_node;;
+		     iter = rb_prev(iter)) {
+			if (!iter) {
+				left_pa = NULL;
+				break;
+			}
+
+			tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
+					  pa_node.inode_node);
+			left_pa = tmp_pa;
+			spin_lock(&tmp_pa->pa_lock);
+			if (tmp_pa->pa_deleted == 0) {
+				spin_unlock(&tmp_pa->pa_lock);
+				break;
+			}
 			spin_unlock(&tmp_pa->pa_lock);
-			continue;
 		}
-		BUG_ON(tmp_pa_start <= new_start && tmp_pa_end >= new_end);
-
-		/* adjust start or end to be adjacent to this pa */
-		if (tmp_pa_end <= ac->ac_o_ex.fe_logical) {
-			BUG_ON(tmp_pa_end < new_start);
-			new_start = tmp_pa_end;
-		} else if (tmp_pa_start > ac->ac_o_ex.fe_logical) {
-			BUG_ON(tmp_pa_start > new_end);
-			new_end = tmp_pa_start;
+	}
+
+	if (right_pa) {
+		for (iter = &right_pa->pa_node.inode_node;;
+		     iter = rb_next(iter)) {
+			if (!iter) {
+				right_pa = NULL;
+				break;
+			}
+
+			tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
+					  pa_node.inode_node);
+			right_pa = tmp_pa;
+			spin_lock(&tmp_pa->pa_lock);
+			if (tmp_pa->pa_deleted == 0) {
+				spin_unlock(&tmp_pa->pa_lock);
+				break;
+			}
+			spin_unlock(&tmp_pa->pa_lock);
 		}
-		spin_unlock(&tmp_pa->pa_lock);
 	}
-	rcu_read_unlock();
+
+	if (left_pa) {
+		left_pa_end =
+			left_pa->pa_lstart + EXT4_C2B(sbi, left_pa->pa_len);
+		BUG_ON(left_pa_end > ac->ac_o_ex.fe_logical);
+	}
+
+	if (right_pa) {
+		right_pa_start = right_pa->pa_lstart;
+		BUG_ON(right_pa_start <= ac->ac_o_ex.fe_logical);
+	}
+
+	/* Step 4: trim our normalized range to not overlap with the neighbors */
+	if (left_pa) {
+		if (left_pa_end > new_start)
+			new_start = left_pa_end;
+	}
+
+	if (right_pa) {
+		if (right_pa_start < new_end)
+			new_end = right_pa_start;
+	}
+	read_unlock(&ei->i_prealloc_lock);
 
 	/* XXX: extra loop to check we really don't overlap preallocations */
 	ext4_mb_pa_assert_overlap(ac, new_start, new_end);
@@ -4400,6 +4501,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	struct ext4_locality_group *lg;
 	struct ext4_prealloc_space *tmp_pa, *cpa = NULL;
 	ext4_lblk_t tmp_pa_start, tmp_pa_end;
+	struct rb_node *iter;
 	ext4_fsblk_t goal_block;
 
 	/* only data can be preallocated */
@@ -4407,14 +4509,19 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 		return false;
 
 	/* first, try per-file preallocation */
-	rcu_read_lock();
-	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
+	read_lock(&ei->i_prealloc_lock);
+	for (iter = ei->i_prealloc_node.rb_node; iter;
+	     iter = ext4_mb_pa_rb_next_iter(ac->ac_o_ex.fe_logical,
+					    tmp_pa_start, iter)) {
+		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
+				  pa_node.inode_node);
 
 		/* all fields in this condition don't change,
 		 * so we can skip locking for them */
 		tmp_pa_start = tmp_pa->pa_lstart;
 		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
 
+		/* original request start doesn't lie in this PA */
 		if (ac->ac_o_ex.fe_logical < tmp_pa_start ||
 		    ac->ac_o_ex.fe_logical >= tmp_pa_end)
 			continue;
@@ -4437,12 +4544,12 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 			ext4_mb_use_inode_pa(ac, tmp_pa);
 			spin_unlock(&tmp_pa->pa_lock);
 			ac->ac_criteria = 10;
-			rcu_read_unlock();
+			read_unlock(&ei->i_prealloc_lock);
 			return true;
 		}
 		spin_unlock(&tmp_pa->pa_lock);
 	}
-	rcu_read_unlock();
+	read_unlock(&ei->i_prealloc_lock);
 
 	/* can we use group allocation? */
 	if (!(ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC))
@@ -4595,6 +4702,7 @@ static void ext4_mb_put_pa(struct ext4_allocation_context *ac,
 {
 	ext4_group_t grp;
 	ext4_fsblk_t grp_blk;
+	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
 
 	/* in this short window concurrent discard can set pa_deleted */
 	spin_lock(&pa->pa_lock);
@@ -4640,16 +4748,41 @@ static void ext4_mb_put_pa(struct ext4_allocation_context *ac,
 	ext4_unlock_group(sb, grp);
 
 	if (pa->pa_type == MB_INODE_PA) {
-		spin_lock(pa->pa_node_lock.inode_lock);
-		list_del_rcu(&pa->pa_node.inode_list);
-		spin_unlock(pa->pa_node_lock.inode_lock);
+		write_lock(pa->pa_node_lock.inode_lock);
+		rb_erase(&pa->pa_node.inode_node, &ei->i_prealloc_node);
+		write_unlock(pa->pa_node_lock.inode_lock);
+		ext4_mb_pa_free(pa);
 	} else {
 		spin_lock(pa->pa_node_lock.lg_lock);
 		list_del_rcu(&pa->pa_node.lg_list);
 		spin_unlock(pa->pa_node_lock.lg_lock);
+		call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
 	}
+}
 
-	call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
+static void ext4_mb_pa_rb_insert(struct rb_root *root, struct rb_node *new)
+{
+	struct rb_node **iter = &root->rb_node, *parent = NULL;
+	struct ext4_prealloc_space *iter_pa, *new_pa;
+	ext4_lblk_t iter_start, new_start;
+
+	while (*iter) {
+		iter_pa = rb_entry(*iter, struct ext4_prealloc_space,
+				   pa_node.inode_node);
+		new_pa = rb_entry(new, struct ext4_prealloc_space,
+				   pa_node.inode_node);
+		iter_start = iter_pa->pa_lstart;
+		new_start = new_pa->pa_lstart;
+
+		parent = *iter;
+		if (new_start < iter_start)
+			iter = &((*iter)->rb_left);
+		else
+			iter = &((*iter)->rb_right);
+	}
+
+	rb_link_node(new, parent, iter);
+	rb_insert_color(new, root);
 }
 
 /*
@@ -4723,7 +4856,6 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 	pa->pa_len = ac->ac_b_ex.fe_len;
 	pa->pa_free = pa->pa_len;
 	spin_lock_init(&pa->pa_lock);
-	INIT_LIST_HEAD(&pa->pa_node.inode_list);
 	INIT_LIST_HEAD(&pa->pa_group_list);
 	pa->pa_deleted = 0;
 	pa->pa_type = MB_INODE_PA;
@@ -4743,9 +4875,9 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 
 	list_add(&pa->pa_group_list, &grp->bb_prealloc_list);
 
-	spin_lock(pa->pa_node_lock.inode_lock);
-	list_add_rcu(&pa->pa_node.inode_list, &ei->i_prealloc_list);
-	spin_unlock(pa->pa_node_lock.inode_lock);
+	write_lock(pa->pa_node_lock.inode_lock);
+	ext4_mb_pa_rb_insert(&ei->i_prealloc_node, &pa->pa_node.inode_node);
+	write_unlock(pa->pa_node_lock.inode_lock);
 	atomic_inc(&ei->i_prealloc_active);
 }
 
@@ -4907,6 +5039,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	struct ext4_prealloc_space *pa, *tmp;
 	struct list_head list;
 	struct ext4_buddy e4b;
+	struct ext4_inode_info *ei;
 	int err;
 	int free = 0;
 
@@ -4970,18 +5103,21 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 			list_del_rcu(&pa->pa_node.lg_list);
 			spin_unlock(pa->pa_node_lock.lg_lock);
 		} else {
-			spin_lock(pa->pa_node_lock.inode_lock);
-			list_del_rcu(&pa->pa_node.inode_list);
-			spin_unlock(pa->pa_node_lock.inode_lock);
+			write_lock(pa->pa_node_lock.inode_lock);
+			ei = EXT4_I(pa->pa_inode);
+			rb_erase(&pa->pa_node.inode_node, &ei->i_prealloc_node);
+			write_unlock(pa->pa_node_lock.inode_lock);
 		}
 
-		if (pa->pa_type == MB_GROUP_PA)
+		list_del(&pa->u.pa_tmp_list);
+
+		if (pa->pa_type == MB_GROUP_PA) {
 			ext4_mb_release_group_pa(&e4b, pa);
-		else
+			call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
+		} else {
 			ext4_mb_release_inode_pa(&e4b, bitmap_bh, pa);
-
-		list_del(&pa->u.pa_tmp_list);
-		call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
+			ext4_mb_pa_free(pa);
+		}
 	}
 
 	ext4_unlock_group(sb, group);
@@ -5011,6 +5147,7 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 	ext4_group_t group = 0;
 	struct list_head list;
 	struct ext4_buddy e4b;
+	struct rb_node *iter;
 	int err;
 
 	if (!S_ISREG(inode->i_mode)) {
@@ -5032,17 +5169,19 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 
 repeat:
 	/* first, collect all pa's in the inode */
-	spin_lock(&ei->i_prealloc_lock);
-	while (!list_empty(&ei->i_prealloc_list) && needed) {
-		pa = list_entry(ei->i_prealloc_list.prev,
-				struct ext4_prealloc_space, pa_node.inode_list);
+	write_lock(&ei->i_prealloc_lock);
+	for (iter = rb_first(&ei->i_prealloc_node); iter && needed;
+	     iter = rb_next(iter)) {
+		pa = rb_entry(iter, struct ext4_prealloc_space,
+			      pa_node.inode_node);
 		BUG_ON(pa->pa_node_lock.inode_lock != &ei->i_prealloc_lock);
+
 		spin_lock(&pa->pa_lock);
 		if (atomic_read(&pa->pa_count)) {
 			/* this shouldn't happen often - nobody should
 			 * use preallocation while we're discarding it */
 			spin_unlock(&pa->pa_lock);
-			spin_unlock(&ei->i_prealloc_lock);
+			write_unlock(&ei->i_prealloc_lock);
 			ext4_msg(sb, KERN_ERR,
 				 "uh-oh! used pa while discarding");
 			WARN_ON(1);
@@ -5053,7 +5192,7 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 		if (pa->pa_deleted == 0) {
 			ext4_mb_mark_pa_deleted(sb, pa);
 			spin_unlock(&pa->pa_lock);
-			list_del_rcu(&pa->pa_node.inode_list);
+			rb_erase(&pa->pa_node.inode_node, &ei->i_prealloc_node);
 			list_add(&pa->u.pa_tmp_list, &list);
 			needed--;
 			continue;
@@ -5061,7 +5200,7 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 
 		/* someone is deleting pa right now */
 		spin_unlock(&pa->pa_lock);
-		spin_unlock(&ei->i_prealloc_lock);
+		write_unlock(&ei->i_prealloc_lock);
 
 		/* we have to wait here because pa_deleted
 		 * doesn't mean pa is already unlinked from
@@ -5078,7 +5217,7 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 		schedule_timeout_uninterruptible(HZ);
 		goto repeat;
 	}
-	spin_unlock(&ei->i_prealloc_lock);
+	write_unlock(&ei->i_prealloc_lock);
 
 	list_for_each_entry_safe(pa, tmp, &list, u.pa_tmp_list) {
 		BUG_ON(pa->pa_type != MB_INODE_PA);
@@ -5110,7 +5249,7 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 		put_bh(bitmap_bh);
 
 		list_del(&pa->u.pa_tmp_list);
-		call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
+		ext4_mb_pa_free(pa);
 	}
 }
 
@@ -5484,7 +5623,6 @@ static void ext4_mb_trim_inode_pa(struct inode *inode)
 static int ext4_mb_release_context(struct ext4_allocation_context *ac)
 {
 	struct inode *inode = ac->ac_inode;
-	struct ext4_inode_info *ei = EXT4_I(inode);
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_prealloc_space *pa = ac->ac_pa;
 	if (pa) {
@@ -5511,16 +5649,6 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
 			}
 		}
 
-		if (pa->pa_type == MB_INODE_PA) {
-			/*
-			 * treat per-inode prealloc list as a lru list, then try
-			 * to trim the least recently used PA.
-			 */
-			spin_lock(pa->pa_node_lock.inode_lock);
-			list_move(&pa->pa_node.inode_list, &ei->i_prealloc_list);
-			spin_unlock(pa->pa_node_lock.inode_lock);
-		}
-
 		ext4_mb_put_pa(ac, ac->ac_sb, pa);
 	}
 	if (ac->ac_bitmap_page)
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 398a6688c341..f8e8ee493867 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -115,7 +115,7 @@ struct ext4_free_data {
 
 struct ext4_prealloc_space {
 	union {
-		struct list_head	inode_list; /* for inode PAs */
+		struct rb_node	inode_node;		/* for inode PA rbtree */
 		struct list_head	lg_list;	/* for lg PAs */
 	} pa_node;
 	struct list_head	pa_group_list;
@@ -132,10 +132,10 @@ struct ext4_prealloc_space {
 	ext4_grpblk_t		pa_free;	/* how many blocks are free */
 	unsigned short		pa_type;	/* pa type. inode or group */
 	union {
-		spinlock_t		*inode_lock;	/* locks the inode list holding this PA */
+		rwlock_t		*inode_lock;	/* locks the rbtree holding this PA */
 		spinlock_t		*lg_lock;	/* locks the lg list holding this PA */
 	} pa_node_lock;
-	struct inode		*pa_inode;	/* hack, for history only */
+	struct inode		*pa_inode;	/* used to get the inode during group discard */
 };
 
 enum {
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f226f8ab469b..54fb600bf51f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1325,9 +1325,9 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	inode_set_iversion(&ei->vfs_inode, 1);
 	ei->i_flags = 0;
 	spin_lock_init(&ei->i_raw_lock);
-	INIT_LIST_HEAD(&ei->i_prealloc_list);
+	ei->i_prealloc_node = RB_ROOT;
 	atomic_set(&ei->i_prealloc_active, 0);
-	spin_lock_init(&ei->i_prealloc_lock);
+	rwlock_init(&ei->i_prealloc_lock);
 	ext4_es_init_tree(&ei->i_es_tree);
 	rwlock_init(&ei->i_es_lock);
 	INIT_LIST_HEAD(&ei->i_es_list);
-- 
2.31.1

