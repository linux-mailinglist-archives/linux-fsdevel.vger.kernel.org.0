Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767495A3C60
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 08:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiH1Grj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Aug 2022 02:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiH1Gq5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Aug 2022 02:46:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355D852810;
        Sat, 27 Aug 2022 23:46:53 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27S3LUGO023118;
        Sun, 28 Aug 2022 06:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tOkZDEh0aUaGuIa2VbIpqE/cX205BLcfLnM/t8FIlSk=;
 b=qaTuw2BuGGvzWcQrVr9E78VF3frIC+XwXvwzugNrbjo+sNATFzucuXQycDGHiM8SsNEx
 N74ps/Vp7CERl1lA+uhcjbD8gsc0DYQuFTj8UYt1QRDYTFHcyz4BZSCkeXTlUoxKAgub
 Zzll+Mp8wPZrRzigszrL4j9OhtJnzisIfvfV+pZl3nHNlU9wdKteFWsXpIvu5n5PrEFV
 MOAXceFaC4Wm066FQYcaeMgs1QjOKxEmQxFevomKIV7vdX8O8aNnK7taXRLOV+4bP2AH
 Upy6C6h6gjQBTtFqTtDy9Hp4NjNuMedXDaG0DyJaqbzvo4Jw0W3bDWwDYAWKmI78Tn2E /g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3j80cwkq9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Aug 2022 06:46:50 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27S6hepR022354;
        Sun, 28 Aug 2022 06:46:50 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3j80cwkq9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Aug 2022 06:46:49 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27S6Zv4r015613;
        Sun, 28 Aug 2022 06:46:48 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3j7aw8s16q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Aug 2022 06:46:48 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27S6kjCS24314176
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Aug 2022 06:46:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C35FC5204E;
        Sun, 28 Aug 2022 06:46:45 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.118.96])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A95885204F;
        Sun, 28 Aug 2022 06:46:43 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 6/8] ext4: Convert pa->pa_inode_list and pa->pa_obj_lock into a union
Date:   Sun, 28 Aug 2022 12:16:19 +0530
Message-Id: <02203566d5275be9e9697bcdec1a7e1dc775b5d7.1661632343.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1661632343.git.ojaswin@linux.ibm.com>
References: <cover.1661632343.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: V_9thxS4yHjftEkE1a1q95iY1WF6iRmu
X-Proofpoint-GUID: Hahz6-dkJWNq0Rc3RSKblDoFuJ8giccE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-27_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208280025
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
---
 fs/ext4/mballoc.c | 76 +++++++++++++++++++++++++++--------------------
 fs/ext4/mballoc.h | 10 +++++--
 2 files changed, 52 insertions(+), 34 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 49bc4b8fd849..e2078c45898a 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4030,7 +4030,7 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
 	ext4_lblk_t tmp_pa_start, tmp_pa_end;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
+	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
 		spin_lock(&tmp_pa->pa_lock);
 		if (tmp_pa->pa_deleted == 0) {
 			tmp_pa_start = tmp_pa->pa_lstart;
@@ -4068,7 +4068,7 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
 
 	/* check we don't cross already preallocated blocks */
 	rcu_read_lock();
-	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
+	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
 		if (tmp_pa->pa_deleted)
 			continue;
 		spin_lock(&tmp_pa->pa_lock);
@@ -4445,7 +4445,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 
 	/* first, try per-file preallocation */
 	rcu_read_lock();
-	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
+	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
 
 		/* all fields in this condition don't change,
 		 * so we can skip locking for them */
@@ -4502,7 +4502,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	for (i = order; i < PREALLOC_TB_SIZE; i++) {
 		rcu_read_lock();
 		list_for_each_entry_rcu(tmp_pa, &lg->lg_prealloc_list[i],
-					pa_inode_list) {
+					pa_node.lg_list) {
 			spin_lock(&tmp_pa->pa_lock);
 			if (tmp_pa->pa_deleted == 0 &&
 					tmp_pa->pa_free >= ac->ac_o_ex.fe_len) {
@@ -4675,9 +4675,15 @@ static void ext4_mb_put_pa(struct ext4_allocation_context *ac,
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
@@ -4745,7 +4751,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 	pa->pa_len = ac->ac_b_ex.fe_len;
 	pa->pa_free = pa->pa_len;
 	spin_lock_init(&pa->pa_lock);
-	INIT_LIST_HEAD(&pa->pa_inode_list);
+	INIT_LIST_HEAD(&pa->pa_node.inode_list);
 	INIT_LIST_HEAD(&pa->pa_group_list);
 	pa->pa_deleted = 0;
 	pa->pa_type = MB_INODE_PA;
@@ -4760,14 +4766,14 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
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
 
@@ -4799,7 +4805,7 @@ ext4_mb_new_group_pa(struct ext4_allocation_context *ac)
 	pa->pa_len = ac->ac_b_ex.fe_len;
 	pa->pa_free = pa->pa_len;
 	spin_lock_init(&pa->pa_lock);
-	INIT_LIST_HEAD(&pa->pa_inode_list);
+	INIT_LIST_HEAD(&pa->pa_node.lg_list);
 	INIT_LIST_HEAD(&pa->pa_group_list);
 	pa->pa_deleted = 0;
 	pa->pa_type = MB_GROUP_PA;
@@ -4815,7 +4821,7 @@ ext4_mb_new_group_pa(struct ext4_allocation_context *ac)
 	lg = ac->ac_lg;
 	BUG_ON(lg == NULL);
 
-	pa->pa_obj_lock = &lg->lg_prealloc_lock;
+	pa->pa_node_lock.lg_lock = &lg->lg_prealloc_lock;
 	pa->pa_inode = NULL;
 
 	list_add(&pa->pa_group_list, &grp->bb_prealloc_list);
@@ -4991,9 +4997,15 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
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
@@ -5056,8 +5068,8 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
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
@@ -5074,7 +5086,7 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 		if (pa->pa_deleted == 0) {
 			ext4_mb_mark_pa_deleted(sb, pa);
 			spin_unlock(&pa->pa_lock);
-			list_del_rcu(&pa->pa_inode_list);
+			list_del_rcu(&pa->pa_node.inode_list);
 			list_add(&pa->u.pa_tmp_list, &list);
 			needed--;
 			continue;
@@ -5363,7 +5375,7 @@ ext4_mb_discard_lg_preallocations(struct super_block *sb,
 
 	spin_lock(&lg->lg_prealloc_lock);
 	list_for_each_entry_rcu(pa, &lg->lg_prealloc_list[order],
-				pa_inode_list,
+				pa_node.lg_list,
 				lockdep_is_held(&lg->lg_prealloc_lock)) {
 		spin_lock(&pa->pa_lock);
 		if (atomic_read(&pa->pa_count)) {
@@ -5386,7 +5398,7 @@ ext4_mb_discard_lg_preallocations(struct super_block *sb,
 		ext4_mb_mark_pa_deleted(sb, pa);
 		spin_unlock(&pa->pa_lock);
 
-		list_del_rcu(&pa->pa_inode_list);
+		list_del_rcu(&pa->pa_node.lg_list);
 		list_add(&pa->u.pa_tmp_list, &discard_list);
 
 		total_entries--;
@@ -5447,7 +5459,7 @@ static void ext4_mb_add_n_trim(struct ext4_allocation_context *ac)
 	/* Add the prealloc space to lg */
 	spin_lock(&lg->lg_prealloc_lock);
 	list_for_each_entry_rcu(tmp_pa, &lg->lg_prealloc_list[order],
-				pa_inode_list,
+				pa_node.lg_list,
 				lockdep_is_held(&lg->lg_prealloc_lock)) {
 		spin_lock(&tmp_pa->pa_lock);
 		if (tmp_pa->pa_deleted) {
@@ -5456,8 +5468,8 @@ static void ext4_mb_add_n_trim(struct ext4_allocation_context *ac)
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
@@ -5468,7 +5480,7 @@ static void ext4_mb_add_n_trim(struct ext4_allocation_context *ac)
 		lg_prealloc_count++;
 	}
 	if (!added)
-		list_add_tail_rcu(&pa->pa_inode_list,
+		list_add_tail_rcu(&pa->pa_node.lg_list,
 					&lg->lg_prealloc_list[order]);
 	spin_unlock(&lg->lg_prealloc_lock);
 
@@ -5524,9 +5536,9 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
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
@@ -5536,9 +5548,9 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
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
index 39da92ceabf8..c5fc6eec19a3 100644
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

