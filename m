Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DF769AB2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 13:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjBQMPi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 07:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjBQMPR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 07:15:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074C26A05B;
        Fri, 17 Feb 2023 04:14:49 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HBSgYC040059;
        Fri, 17 Feb 2023 12:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=v53ZXlSNypmup6yBGc8VwIs3WgyLSerKKfvOgLaQpoU=;
 b=fko5isSZKqV9szcGCcMI1ps92Hr8uoxzBP2hCZC7sg2vvuVdNRfmdSbKkaRUxbtsixqc
 cAkvpV4ImPk87ro+Mdaee7IL2EnGsBxCYyypzCKaAQWCAXATw2BGblYFMKUbEUSNWt4z
 5tzjkyF2zr+Ral9EBmepYxBwHgDgt2MdIQEzbFecXyIBrXT22Z8UJF414Ee1VkEZKKsY
 +BS8nShFkVj6v+G0Z5CgSKEsUhhR78BLtmt/JB8TcB/sDNF8Vcy5eTUyiu4gtmN/3dHl
 Pp3vjkFpkfJG0z7Duvpppccp4cHNFn1an1sF+Eiz+3CxK1hoekJZqHrCSVU3yV9Pepv4 RA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nt3ngr4m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 12:14:45 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31HBZJLJ015429;
        Fri, 17 Feb 2023 12:14:45 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nt3ngr4kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 12:14:45 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31GNkTcK027510;
        Fri, 17 Feb 2023 12:14:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3np2n6nwem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 12:14:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31HCEeRZ46072098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 12:14:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F4C02004B;
        Fri, 17 Feb 2023 12:14:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B1CE20043;
        Fri, 17 Feb 2023 12:14:38 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.3.39])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Feb 2023 12:14:38 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v4 7/9] ext4: Convert pa->pa_inode_list and pa->pa_obj_lock into a union
Date:   Fri, 17 Feb 2023 17:44:16 +0530
Message-Id: <17125fbc2d6311515470320c1f6b1c71e66b6417.1676634592.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1676634592.git.ojaswin@linux.ibm.com>
References: <cover.1676634592.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ijJld_KUbTqUGjf3zmFL1rceLiV4WaB9
X-Proofpoint-ORIG-GUID: CKv3bqWvqxgBeqJ_JFjp4zriCUrF3t6L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_06,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

** Splitting pa->pa_inode_list **

Currently, we use the same pa->pa_inode_list to add a pa to either
the inode preallocation list or the locality group preallocation list.
For better clarity, split this list into a union of 2 list_heads and use
either of the them based on the type of pa.

** Splitting pa->pa_obj_lock **

Currently, pa->pa_obj_lock is either assigned &ei->i_prealloc_lock for
inode PAs or lg_prealloc_lock for lg PAs, and is then used to lock the
lists containing these PAs. Make the distinction between the 2 PA types
clear by changing this lock to a union of 2 locks. Explicitly use the
pa_lock_node.inode_lock for inode PAs and pa_lock_node.lg_lock for lg
PAs.

This patch is required so that the locality group preallocation code
remains the same as in upcoming patches we are going to make changes to
inode preallocation code to move from list to rbtree based
implementation. This patch also makes it easier to review the upcoming
patches.

There are no functional changes in this patch.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 76 +++++++++++++++++++++++++++--------------------
 fs/ext4/mballoc.h | 10 +++++--
 2 files changed, 52 insertions(+), 34 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index ba9d26e2f2aa..7b8bbfb9ad58 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3994,7 +3994,7 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
 	ext4_lblk_t tmp_pa_start, tmp_pa_end;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
+	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
 		spin_lock(&tmp_pa->pa_lock);
 		if (tmp_pa->pa_deleted == 0) {
 			tmp_pa_start = tmp_pa->pa_lstart;
@@ -4032,7 +4032,7 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
 
 	/* check we don't cross already preallocated blocks */
 	rcu_read_lock();
-	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
+	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
 		if (tmp_pa->pa_deleted)
 			continue;
 		spin_lock(&tmp_pa->pa_lock);
@@ -4410,7 +4410,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 
 	/* first, try per-file preallocation */
 	rcu_read_lock();
-	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
+	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
 
 		/* all fields in this condition don't change,
 		 * so we can skip locking for them */
@@ -4467,7 +4467,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	for (i = order; i < PREALLOC_TB_SIZE; i++) {
 		rcu_read_lock();
 		list_for_each_entry_rcu(tmp_pa, &lg->lg_prealloc_list[i],
-					pa_inode_list) {
+					pa_node.lg_list) {
 			spin_lock(&tmp_pa->pa_lock);
 			if (tmp_pa->pa_deleted == 0 &&
 					tmp_pa->pa_free >= ac->ac_o_ex.fe_len) {
@@ -4641,9 +4641,15 @@ static void ext4_mb_put_pa(struct ext4_allocation_context *ac,
 	list_del(&pa->pa_group_list);
 	ext4_unlock_group(sb, grp);
 
-	spin_lock(pa->pa_obj_lock);
-	list_del_rcu(&pa->pa_inode_list);
-	spin_unlock(pa->pa_obj_lock);
+	if (pa->pa_type == MB_INODE_PA) {
+		spin_lock(pa->pa_node_lock.inode_lock);
+		list_del_rcu(&pa->pa_node.inode_list);
+		spin_unlock(pa->pa_node_lock.inode_lock);
+	} else {
+		spin_lock(pa->pa_node_lock.lg_lock);
+		list_del_rcu(&pa->pa_node.lg_list);
+		spin_unlock(pa->pa_node_lock.lg_lock);
+	}
 
 	call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
 }
@@ -4723,7 +4729,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 	pa->pa_len = ac->ac_b_ex.fe_len;
 	pa->pa_free = pa->pa_len;
 	spin_lock_init(&pa->pa_lock);
-	INIT_LIST_HEAD(&pa->pa_inode_list);
+	INIT_LIST_HEAD(&pa->pa_node.inode_list);
 	INIT_LIST_HEAD(&pa->pa_group_list);
 	pa->pa_deleted = 0;
 	pa->pa_type = MB_INODE_PA;
@@ -4738,14 +4744,14 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 	ei = EXT4_I(ac->ac_inode);
 	grp = ext4_get_group_info(sb, ac->ac_b_ex.fe_group);
 
-	pa->pa_obj_lock = &ei->i_prealloc_lock;
+	pa->pa_node_lock.inode_lock = &ei->i_prealloc_lock;
 	pa->pa_inode = ac->ac_inode;
 
 	list_add(&pa->pa_group_list, &grp->bb_prealloc_list);
 
-	spin_lock(pa->pa_obj_lock);
-	list_add_rcu(&pa->pa_inode_list, &ei->i_prealloc_list);
-	spin_unlock(pa->pa_obj_lock);
+	spin_lock(pa->pa_node_lock.inode_lock);
+	list_add_rcu(&pa->pa_node.inode_list, &ei->i_prealloc_list);
+	spin_unlock(pa->pa_node_lock.inode_lock);
 	atomic_inc(&ei->i_prealloc_active);
 }
 
@@ -4777,7 +4783,7 @@ ext4_mb_new_group_pa(struct ext4_allocation_context *ac)
 	pa->pa_len = ac->ac_b_ex.fe_len;
 	pa->pa_free = pa->pa_len;
 	spin_lock_init(&pa->pa_lock);
-	INIT_LIST_HEAD(&pa->pa_inode_list);
+	INIT_LIST_HEAD(&pa->pa_node.lg_list);
 	INIT_LIST_HEAD(&pa->pa_group_list);
 	pa->pa_deleted = 0;
 	pa->pa_type = MB_GROUP_PA;
@@ -4793,7 +4799,7 @@ ext4_mb_new_group_pa(struct ext4_allocation_context *ac)
 	lg = ac->ac_lg;
 	BUG_ON(lg == NULL);
 
-	pa->pa_obj_lock = &lg->lg_prealloc_lock;
+	pa->pa_node_lock.lg_lock = &lg->lg_prealloc_lock;
 	pa->pa_inode = NULL;
 
 	list_add(&pa->pa_group_list, &grp->bb_prealloc_list);
@@ -4969,9 +4975,15 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	list_for_each_entry_safe(pa, tmp, &list, u.pa_tmp_list) {
 
 		/* remove from object (inode or locality group) */
-		spin_lock(pa->pa_obj_lock);
-		list_del_rcu(&pa->pa_inode_list);
-		spin_unlock(pa->pa_obj_lock);
+		if (pa->pa_type == MB_GROUP_PA) {
+			spin_lock(pa->pa_node_lock.lg_lock);
+			list_del_rcu(&pa->pa_node.lg_list);
+			spin_unlock(pa->pa_node_lock.lg_lock);
+		} else {
+			spin_lock(pa->pa_node_lock.inode_lock);
+			list_del_rcu(&pa->pa_node.inode_list);
+			spin_unlock(pa->pa_node_lock.inode_lock);
+		}
 
 		if (pa->pa_type == MB_GROUP_PA)
 			ext4_mb_release_group_pa(&e4b, pa);
@@ -5034,8 +5046,8 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 	spin_lock(&ei->i_prealloc_lock);
 	while (!list_empty(&ei->i_prealloc_list) && needed) {
 		pa = list_entry(ei->i_prealloc_list.prev,
-				struct ext4_prealloc_space, pa_inode_list);
-		BUG_ON(pa->pa_obj_lock != &ei->i_prealloc_lock);
+				struct ext4_prealloc_space, pa_node.inode_list);
+		BUG_ON(pa->pa_node_lock.inode_lock != &ei->i_prealloc_lock);
 		spin_lock(&pa->pa_lock);
 		if (atomic_read(&pa->pa_count)) {
 			/* this shouldn't happen often - nobody should
@@ -5052,7 +5064,7 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 		if (pa->pa_deleted == 0) {
 			ext4_mb_mark_pa_deleted(sb, pa);
 			spin_unlock(&pa->pa_lock);
-			list_del_rcu(&pa->pa_inode_list);
+			list_del_rcu(&pa->pa_node.inode_list);
 			list_add(&pa->u.pa_tmp_list, &list);
 			needed--;
 			continue;
@@ -5342,7 +5354,7 @@ ext4_mb_discard_lg_preallocations(struct super_block *sb,
 
 	spin_lock(&lg->lg_prealloc_lock);
 	list_for_each_entry_rcu(pa, &lg->lg_prealloc_list[order],
-				pa_inode_list,
+				pa_node.lg_list,
 				lockdep_is_held(&lg->lg_prealloc_lock)) {
 		spin_lock(&pa->pa_lock);
 		if (atomic_read(&pa->pa_count)) {
@@ -5365,7 +5377,7 @@ ext4_mb_discard_lg_preallocations(struct super_block *sb,
 		ext4_mb_mark_pa_deleted(sb, pa);
 		spin_unlock(&pa->pa_lock);
 
-		list_del_rcu(&pa->pa_inode_list);
+		list_del_rcu(&pa->pa_node.lg_list);
 		list_add(&pa->u.pa_tmp_list, &discard_list);
 
 		total_entries--;
@@ -5426,7 +5438,7 @@ static void ext4_mb_add_n_trim(struct ext4_allocation_context *ac)
 	/* Add the prealloc space to lg */
 	spin_lock(&lg->lg_prealloc_lock);
 	list_for_each_entry_rcu(tmp_pa, &lg->lg_prealloc_list[order],
-				pa_inode_list,
+				pa_node.lg_list,
 				lockdep_is_held(&lg->lg_prealloc_lock)) {
 		spin_lock(&tmp_pa->pa_lock);
 		if (tmp_pa->pa_deleted) {
@@ -5435,8 +5447,8 @@ static void ext4_mb_add_n_trim(struct ext4_allocation_context *ac)
 		}
 		if (!added && pa->pa_free < tmp_pa->pa_free) {
 			/* Add to the tail of the previous entry */
-			list_add_tail_rcu(&pa->pa_inode_list,
-						&tmp_pa->pa_inode_list);
+			list_add_tail_rcu(&pa->pa_node.lg_list,
+						&tmp_pa->pa_node.lg_list);
 			added = 1;
 			/*
 			 * we want to count the total
@@ -5447,7 +5459,7 @@ static void ext4_mb_add_n_trim(struct ext4_allocation_context *ac)
 		lg_prealloc_count++;
 	}
 	if (!added)
-		list_add_tail_rcu(&pa->pa_inode_list,
+		list_add_tail_rcu(&pa->pa_node.lg_list,
 					&lg->lg_prealloc_list[order]);
 	spin_unlock(&lg->lg_prealloc_lock);
 
@@ -5503,9 +5515,9 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
 			 * doesn't grow big.
 			 */
 			if (likely(pa->pa_free)) {
-				spin_lock(pa->pa_obj_lock);
-				list_del_rcu(&pa->pa_inode_list);
-				spin_unlock(pa->pa_obj_lock);
+				spin_lock(pa->pa_node_lock.lg_lock);
+				list_del_rcu(&pa->pa_node.lg_list);
+				spin_unlock(pa->pa_node_lock.lg_lock);
 				ext4_mb_add_n_trim(ac);
 			}
 		}
@@ -5515,9 +5527,9 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
 			 * treat per-inode prealloc list as a lru list, then try
 			 * to trim the least recently used PA.
 			 */
-			spin_lock(pa->pa_obj_lock);
-			list_move(&pa->pa_inode_list, &ei->i_prealloc_list);
-			spin_unlock(pa->pa_obj_lock);
+			spin_lock(pa->pa_node_lock.inode_lock);
+			list_move(&pa->pa_node.inode_list, &ei->i_prealloc_list);
+			spin_unlock(pa->pa_node_lock.inode_lock);
 		}
 
 		ext4_mb_put_pa(ac, ac->ac_sb, pa);
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index dcda2a943cee..398a6688c341 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -114,7 +114,10 @@ struct ext4_free_data {
 };
 
 struct ext4_prealloc_space {
-	struct list_head	pa_inode_list;
+	union {
+		struct list_head	inode_list; /* for inode PAs */
+		struct list_head	lg_list;	/* for lg PAs */
+	} pa_node;
 	struct list_head	pa_group_list;
 	union {
 		struct list_head pa_tmp_list;
@@ -128,7 +131,10 @@ struct ext4_prealloc_space {
 	ext4_grpblk_t		pa_len;		/* len of preallocated chunk */
 	ext4_grpblk_t		pa_free;	/* how many blocks are free */
 	unsigned short		pa_type;	/* pa type. inode or group */
-	spinlock_t		*pa_obj_lock;
+	union {
+		spinlock_t		*inode_lock;	/* locks the inode list holding this PA */
+		spinlock_t		*lg_lock;	/* locks the lg list holding this PA */
+	} pa_node_lock;
 	struct inode		*pa_inode;	/* hack, for history only */
 };
 
-- 
2.31.1

