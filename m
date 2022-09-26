Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C475E9A22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 09:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbiIZHHu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 03:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbiIZHHg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:07:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7096B32053;
        Mon, 26 Sep 2022 00:07:05 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28Q4ZPGU003596;
        Mon, 26 Sep 2022 07:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5qAdjYeOo3rtNC1zCVP1HJAhQUo/mXSsy+ptv58QnzQ=;
 b=JDrby8iQBE9qImvd3+dytF9PT4bDcnDQ4XPWf2+tIvwU1Uq7gC/nDjhG/G07bgs+k5vQ
 9NZ8AFiQspV1XOESEM2+wTV2wXyRkwkbRxOJMjqH7btjRealixQApd2/S4eBfpfY/+c9
 IALm0JWGF88UYbH8a3DoMARLYm+1rCgFDYCmzDZAbhYcWHKoBCXVEBWn+KVcojSToSFW
 69Q9fLv+k4LmZ09upQ/PQkOxXm250SwlH7+Mok7c92lYCwhOMx8IYSFsVqh5xduW/XVi
 m2r0TqraIN0NTjktlcTvmFNOZTxqGujP7u2LjpI4rHan2FjzykcEIupbrxbkoBtjKvWl JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jtbh4w9px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 07:07:01 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28Q6qcSK006838;
        Mon, 26 Sep 2022 07:07:01 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jtbh4w9p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 07:07:00 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28Q7679B025676;
        Mon, 26 Sep 2022 07:06:59 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3jssh8sgw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 07:06:59 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28Q76ux28847748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 07:06:56 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0CB311C052;
        Mon, 26 Sep 2022 07:06:56 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 954BA11C04C;
        Mon, 26 Sep 2022 07:06:53 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.30.221])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 26 Sep 2022 07:06:53 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC v2 7/8] ext4: Use rbtrees to manage PAs instead of inode i_prealloc_list
Date:   Mon, 26 Sep 2022 12:34:58 +0530
Message-Id: <94b9ed776b051271072ab9cef6eba00635640ad2.1664172580.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1664172580.git.ojaswin@linux.ibm.com>
References: <cover.1664172580.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ztP3nrrVlNa10Ad0Rx7KOUfN6R47N1K6
X-Proofpoint-GUID: wIIky415OJcEJora31rFjotBfem3XVGD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_04,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260043
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h    |   4 +-
 fs/ext4/mballoc.c | 175 ++++++++++++++++++++++++++++++----------------
 fs/ext4/mballoc.h |   6 +-
 fs/ext4/super.c   |   4 +-
 4 files changed, 123 insertions(+), 66 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 3bf9a6926798..d54b972f1f0f 100644
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
index b91710fe881f..ec66a5a094f0 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3985,6 +3985,24 @@ static void ext4_mb_normalize_group_request(struct ext4_allocation_context *ac)
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
+ext4_mb_pa_rb_next_iter(int new_start, int cur_start, struct rb_node *node)
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
@@ -3993,27 +4011,31 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
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
+	iter = ei->i_prealloc_node.rb_node;
+	while (iter) {
+		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
+				  pa_node.inode_node);
+		tmp_pa_start = tmp_pa->pa_lstart;
+		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
 
+		spin_lock(&tmp_pa->pa_lock);
+		if (tmp_pa->pa_deleted == 0)
 			BUG_ON(!(start >= tmp_pa_end || end <= tmp_pa_start));
-		}
 		spin_unlock(&tmp_pa->pa_lock);
+
+		iter = ext4_mb_pa_rb_next_iter(start, tmp_pa_start, iter);
 	}
-	rcu_read_unlock();
+	read_unlock(&ei->i_prealloc_lock);
 }
-
 /*
  * Given an allocation context "ac" and a range "start", "end", check
  * and adjust boundaries if the range overlaps with any of the existing
  * preallocatoins stored in the corresponding inode of the allocation context.
  *
- *Parameters:
+ * Parameters:
  *	ac			allocation context
  *	start			start of the new range
  *	end			end of the new range
@@ -4025,6 +4047,7 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
 	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_prealloc_space *tmp_pa;
+	struct rb_node *iter;
 	ext4_lblk_t new_start, new_end;
 	ext4_lblk_t tmp_pa_start, tmp_pa_end;
 
@@ -4032,19 +4055,29 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
 	new_end = *end;
 
 	/* check we don't cross already preallocated blocks */
-	rcu_read_lock();
-	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
-		if (tmp_pa->pa_deleted)
+	read_lock(&ei->i_prealloc_lock);
+	iter = ei->i_prealloc_node.rb_node;
+	while (iter) {
+		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
+				  pa_node.inode_node);
+		tmp_pa_start = tmp_pa->pa_lstart;
+		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
+
+		/*
+		 * If pa is deleted, ignore overlaps and just iterate in rbtree
+		 * based on tmp_pa_start
+		 */
+		if (tmp_pa->pa_deleted) {
+			iter = ext4_mb_pa_rb_next_iter(new_start, tmp_pa_start, iter);
 			continue;
+		}
 		spin_lock(&tmp_pa->pa_lock);
 		if (tmp_pa->pa_deleted) {
 			spin_unlock(&tmp_pa->pa_lock);
+			iter = ext4_mb_pa_rb_next_iter(new_start, tmp_pa_start, iter);
 			continue;
 		}
 
-		tmp_pa_start = tmp_pa->pa_lstart;
-		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
-
 		/* PA must not overlap original request */
 		BUG_ON(!(ac->ac_o_ex.fe_logical >= tmp_pa_end ||
 			ac->ac_o_ex.fe_logical < tmp_pa_start));
@@ -4052,6 +4085,7 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
 		/* skip PAs this normalized request doesn't overlap with */
 		if (tmp_pa_start >= new_end || tmp_pa_end <= new_start) {
 			spin_unlock(&tmp_pa->pa_lock);
+			iter = ext4_mb_pa_rb_next_iter(new_start, tmp_pa_start, iter);
 			continue;
 		}
 		BUG_ON(tmp_pa_start <= new_start && tmp_pa_end >= new_end);
@@ -4065,8 +4099,9 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
 			new_end = tmp_pa_start;
 		}
 		spin_unlock(&tmp_pa->pa_lock);
+		iter = ext4_mb_pa_rb_next_iter(new_start, tmp_pa_start, iter);
 	}
-	rcu_read_unlock();
+	read_unlock(&ei->i_prealloc_lock);
 
 	/* XXX: extra loop to check we really don't overlap preallocations */
 	ext4_mb_pa_assert_overlap(ac, new_start, new_end);
@@ -4193,7 +4228,6 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	ext4_mb_pa_adjust_overlap(ac, &start, &end);
 
 	size = end - start;
-
 	/*
 	 * In this function "start" and "size" are normalized for better
 	 * alignment and length such that we could preallocate more blocks.
@@ -4402,6 +4436,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	struct ext4_locality_group *lg;
 	struct ext4_prealloc_space *tmp_pa, *cpa = NULL;
 	ext4_lblk_t tmp_pa_start, tmp_pa_end;
+	struct rb_node *iter;
 	ext4_fsblk_t goal_block;
 
 	/* only data can be preallocated */
@@ -4409,17 +4444,23 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 		return false;
 
 	/* first, try per-file preallocation */
-	rcu_read_lock();
-	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
+	read_lock(&ei->i_prealloc_lock);
+	iter = ei->i_prealloc_node.rb_node;
+	while (iter) {
+		tmp_pa = rb_entry(iter, struct ext4_prealloc_space, pa_node.inode_node);
 
 		/* all fields in this condition don't change,
 		 * so we can skip locking for them */
 		tmp_pa_start = tmp_pa->pa_lstart;
 		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
 
+		/* original request start doesn't lie in this PA */
 		if (ac->ac_o_ex.fe_logical < tmp_pa_start ||
-		    ac->ac_o_ex.fe_logical >= tmp_pa_end)
+		    ac->ac_o_ex.fe_logical >= tmp_pa_end) {
+			iter = ext4_mb_pa_rb_next_iter(ac->ac_o_ex.fe_logical,
+						  tmp_pa_start, iter);
 			continue;
+		}
 
 		/* non-extent files can't have physical blocks past 2^32 */
 		if (!(ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS)) &&
@@ -4439,12 +4480,14 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 			ext4_mb_use_inode_pa(ac, tmp_pa);
 			spin_unlock(&tmp_pa->pa_lock);
 			ac->ac_criteria = 10;
-			rcu_read_unlock();
+			read_unlock(&ei->i_prealloc_lock);
 			return true;
 		}
 		spin_unlock(&tmp_pa->pa_lock);
+		iter = ext4_mb_pa_rb_next_iter(ac->ac_o_ex.fe_logical,
+				tmp_pa_start, iter);
 	}
-	rcu_read_unlock();
+	read_unlock(&ei->i_prealloc_lock);
 
 	/* can we use group allocation? */
 	if (!(ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC))
@@ -4596,6 +4639,7 @@ static void ext4_mb_put_pa(struct ext4_allocation_context *ac,
 {
 	ext4_group_t grp;
 	ext4_fsblk_t grp_blk;
+	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
 
 	/* in this short window concurrent discard can set pa_deleted */
 	spin_lock(&pa->pa_lock);
@@ -4641,16 +4685,34 @@ static void ext4_mb_put_pa(struct ext4_allocation_context *ac,
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
+
+static int ext4_mb_pa_cmp(struct rb_node *new, struct rb_node *cur)
+{
+	ext4_grpblk_t cur_start, new_start;
+	struct ext4_prealloc_space *cur_pa = rb_entry(cur,
+						      struct ext4_prealloc_space,
+						      pa_node.inode_node);
+	struct ext4_prealloc_space *new_pa = rb_entry(new,
+						      struct ext4_prealloc_space,
+						      pa_node.inode_node);
+	cur_start = cur_pa->pa_lstart;
+	new_start = new_pa->pa_lstart;
 
-	call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
+	if (new_start < cur_start)
+		return 1;
+	else
+		return -1;
 }
 
 /*
@@ -4716,7 +4778,6 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 	pa->pa_len = ac->ac_b_ex.fe_len;
 	pa->pa_free = pa->pa_len;
 	spin_lock_init(&pa->pa_lock);
-	INIT_LIST_HEAD(&pa->pa_node.inode_list);
 	INIT_LIST_HEAD(&pa->pa_group_list);
 	pa->pa_deleted = 0;
 	pa->pa_type = MB_INODE_PA;
@@ -4736,9 +4797,10 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 
 	list_add(&pa->pa_group_list, &grp->bb_prealloc_list);
 
-	spin_lock(pa->pa_node_lock.inode_lock);
-	list_add_rcu(&pa->pa_node.inode_list, &ei->i_prealloc_list);
-	spin_unlock(pa->pa_node_lock.inode_lock);
+	write_lock(pa->pa_node_lock.inode_lock);
+	ext4_mb_rb_insert(&ei->i_prealloc_node, &pa->pa_node.inode_node,
+			  ext4_mb_pa_cmp);
+	write_unlock(pa->pa_node_lock.inode_lock);
 	atomic_inc(&ei->i_prealloc_active);
 }
 
@@ -4904,6 +4966,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	struct ext4_prealloc_space *pa, *tmp;
 	struct list_head list;
 	struct ext4_buddy e4b;
+	struct ext4_inode_info *ei;
 	int err;
 	int free = 0;
 
@@ -4967,18 +5030,21 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
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
@@ -5008,6 +5074,7 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 	ext4_group_t group = 0;
 	struct list_head list;
 	struct ext4_buddy e4b;
+	struct rb_node *iter;
 	int err;
 
 	if (!S_ISREG(inode->i_mode)) {
@@ -5030,17 +5097,18 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 
 repeat:
 	/* first, collect all pa's in the inode */
-	spin_lock(&ei->i_prealloc_lock);
-	while (!list_empty(&ei->i_prealloc_list) && needed) {
-		pa = list_entry(ei->i_prealloc_list.prev,
-				struct ext4_prealloc_space, pa_node.inode_list);
+	write_lock(&ei->i_prealloc_lock);
+	for (iter = rb_first(&ei->i_prealloc_node); iter && needed; iter = rb_next(iter)) {
+		pa = rb_entry(iter, struct ext4_prealloc_space,
+				pa_node.inode_node);
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
@@ -5051,7 +5119,7 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 		if (pa->pa_deleted == 0) {
 			ext4_mb_mark_pa_deleted(sb, pa);
 			spin_unlock(&pa->pa_lock);
-			list_del_rcu(&pa->pa_node.inode_list);
+			rb_erase(&pa->pa_node.inode_node, &ei->i_prealloc_node);
 			list_add(&pa->u.pa_tmp_list, &list);
 			needed--;
 			continue;
@@ -5059,7 +5127,7 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 
 		/* someone is deleting pa right now */
 		spin_unlock(&pa->pa_lock);
-		spin_unlock(&ei->i_prealloc_lock);
+		write_unlock(&ei->i_prealloc_lock);
 
 		/* we have to wait here because pa_deleted
 		 * doesn't mean pa is already unlinked from
@@ -5076,7 +5144,7 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 		schedule_timeout_uninterruptible(HZ);
 		goto repeat;
 	}
-	spin_unlock(&ei->i_prealloc_lock);
+	write_unlock(&ei->i_prealloc_lock);
 
 	list_for_each_entry_safe(pa, tmp, &list, u.pa_tmp_list) {
 		BUG_ON(pa->pa_type != MB_INODE_PA);
@@ -5108,7 +5176,7 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 		put_bh(bitmap_bh);
 
 		list_del(&pa->u.pa_tmp_list);
-		call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
+		ext4_mb_pa_free(pa);
 	}
 }
 
@@ -5484,7 +5552,6 @@ static void ext4_mb_trim_inode_pa(struct inode *inode)
 static int ext4_mb_release_context(struct ext4_allocation_context *ac)
 {
 	struct inode *inode = ac->ac_inode;
-	struct ext4_inode_info *ei = EXT4_I(inode);
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_prealloc_space *pa = ac->ac_pa;
 	if (pa) {
@@ -5511,16 +5578,6 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
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
index 9a66abcca1a8..5e4fd4ea65fc 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1330,9 +1330,9 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 
 	inode_set_iversion(&ei->vfs_inode, 1);
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

