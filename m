Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B125F69AB22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 13:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjBQMO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 07:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBQMOp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 07:14:45 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9525A6A070;
        Fri, 17 Feb 2023 04:14:40 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HAGnfL006498;
        Fri, 17 Feb 2023 12:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KZS3hSXgTaegBvRxQgY6cJoL6DE+TBJpdySt/Ob5gMI=;
 b=G1wwk4qY9Qk//IIKj6O9DuMFAYoNqwUxEoPhIp/tsO+NjM+xjNTex1U46b0sZ2OcpdBU
 E6lENY3FcQU91PbDoBKD/0joazQt19f1X5vW0pmkiitLwu9tZXoEg02T1OOwQomVr+yq
 CuOr5U7X1Y/e/enD51/v0acdAmdHUV4Vy6eYLcvdSnL85tCbsY9GtpM6s3nL1g3dmp5u
 bS2we1hguUgW7tZDo+7ezjejNVh7Kef+2sXrdlRWDHzzkwPWNL0VG04hxKi2WEX2qKz3
 j/PMWgONIyjoy7a6BarV6SC5jH4Ux1UQ31Fg/rzWtLrGfCjR8C47xOqIPEzfgk69VsF7 Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nsv6f1mjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 12:14:36 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31HBc2QT013530;
        Fri, 17 Feb 2023 12:14:35 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nsv6f1mhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 12:14:35 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31GKwiBH009276;
        Fri, 17 Feb 2023 12:14:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3np2n6dvtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 12:14:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31HCEU7s49479970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 12:14:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B562B2004B;
        Fri, 17 Feb 2023 12:14:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BCB420040;
        Fri, 17 Feb 2023 12:14:28 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.3.39])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Feb 2023 12:14:28 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v4 3/9] ext4: Refactor code in ext4_mb_normalize_request() and ext4_mb_use_preallocated()
Date:   Fri, 17 Feb 2023 17:44:12 +0530
Message-Id: <a1198e2ceff3fe03835e940020a4d8b9eae2a9ad.1676634592.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1676634592.git.ojaswin@linux.ibm.com>
References: <cover.1676634592.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PO1ovVJa2qzeHoJ3gOOut16nI5nsw4V-
X-Proofpoint-ORIG-GUID: PVGHYUfRd1LogOErqR4UrYTVN8D9ax3Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_06,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change some variable names to be more consistent and
refactor some of the code to make it easier to read.

There are no functional changes in this patch

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 97 ++++++++++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 48 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a5f2803aff93..f4e699bce99f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3999,7 +3999,8 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	loff_t orig_size __maybe_unused;
 	ext4_lblk_t start;
 	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
-	struct ext4_prealloc_space *pa;
+	struct ext4_prealloc_space *tmp_pa;
+	ext4_lblk_t tmp_pa_start, tmp_pa_end;
 
 	/* do normalize only data requests, metadata requests
 	   do not need preallocation */
@@ -4102,56 +4103,53 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 
 	/* check we don't cross already preallocated blocks */
 	rcu_read_lock();
-	list_for_each_entry_rcu(pa, &ei->i_prealloc_list, pa_inode_list) {
-		ext4_lblk_t pa_end;
-
-		if (pa->pa_deleted)
+	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
+		if (tmp_pa->pa_deleted)
 			continue;
-		spin_lock(&pa->pa_lock);
-		if (pa->pa_deleted) {
-			spin_unlock(&pa->pa_lock);
+		spin_lock(&tmp_pa->pa_lock);
+		if (tmp_pa->pa_deleted) {
+			spin_unlock(&tmp_pa->pa_lock);
 			continue;
 		}
 
-		pa_end = pa->pa_lstart + EXT4_C2B(EXT4_SB(ac->ac_sb),
-						  pa->pa_len);
+		tmp_pa_start = tmp_pa->pa_lstart;
+		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
 
 		/* PA must not overlap original request */
-		BUG_ON(!(ac->ac_o_ex.fe_logical >= pa_end ||
-			ac->ac_o_ex.fe_logical < pa->pa_lstart));
+		BUG_ON(!(ac->ac_o_ex.fe_logical >= tmp_pa_end ||
+			ac->ac_o_ex.fe_logical < tmp_pa_start));
 
 		/* skip PAs this normalized request doesn't overlap with */
-		if (pa->pa_lstart >= end || pa_end <= start) {
-			spin_unlock(&pa->pa_lock);
+		if (tmp_pa_start >= end || tmp_pa_end <= start) {
+			spin_unlock(&tmp_pa->pa_lock);
 			continue;
 		}
-		BUG_ON(pa->pa_lstart <= start && pa_end >= end);
+		BUG_ON(tmp_pa_start <= start && tmp_pa_end >= end);
 
 		/* adjust start or end to be adjacent to this pa */
-		if (pa_end <= ac->ac_o_ex.fe_logical) {
-			BUG_ON(pa_end < start);
-			start = pa_end;
-		} else if (pa->pa_lstart > ac->ac_o_ex.fe_logical) {
-			BUG_ON(pa->pa_lstart > end);
-			end = pa->pa_lstart;
+		if (tmp_pa_end <= ac->ac_o_ex.fe_logical) {
+			BUG_ON(tmp_pa_end < start);
+			start = tmp_pa_end;
+		} else if (tmp_pa_start > ac->ac_o_ex.fe_logical) {
+			BUG_ON(tmp_pa_start > end);
+			end = tmp_pa_start;
 		}
-		spin_unlock(&pa->pa_lock);
+		spin_unlock(&tmp_pa->pa_lock);
 	}
 	rcu_read_unlock();
 	size = end - start;
 
 	/* XXX: extra loop to check we really don't overlap preallocations */
 	rcu_read_lock();
-	list_for_each_entry_rcu(pa, &ei->i_prealloc_list, pa_inode_list) {
-		ext4_lblk_t pa_end;
+	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
+		spin_lock(&tmp_pa->pa_lock);
+		if (tmp_pa->pa_deleted == 0) {
+			tmp_pa_start = tmp_pa->pa_lstart;
+			tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
 
-		spin_lock(&pa->pa_lock);
-		if (pa->pa_deleted == 0) {
-			pa_end = pa->pa_lstart + EXT4_C2B(EXT4_SB(ac->ac_sb),
-							  pa->pa_len);
-			BUG_ON(!(start >= pa_end || end <= pa->pa_lstart));
+			BUG_ON(!(start >= tmp_pa_end || end <= tmp_pa_start));
 		}
-		spin_unlock(&pa->pa_lock);
+		spin_unlock(&tmp_pa->pa_lock);
 	}
 	rcu_read_unlock();
 
@@ -4361,7 +4359,8 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	int order, i;
 	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
 	struct ext4_locality_group *lg;
-	struct ext4_prealloc_space *pa, *cpa = NULL;
+	struct ext4_prealloc_space *tmp_pa, *cpa = NULL;
+	ext4_lblk_t tmp_pa_start, tmp_pa_end;
 	ext4_fsblk_t goal_block;
 
 	/* only data can be preallocated */
@@ -4370,18 +4369,20 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 
 	/* first, try per-file preallocation */
 	rcu_read_lock();
-	list_for_each_entry_rcu(pa, &ei->i_prealloc_list, pa_inode_list) {
+	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
 
 		/* all fields in this condition don't change,
 		 * so we can skip locking for them */
-		if (ac->ac_o_ex.fe_logical < pa->pa_lstart ||
-		    ac->ac_o_ex.fe_logical >= (pa->pa_lstart +
-					       EXT4_C2B(sbi, pa->pa_len)))
+		tmp_pa_start = tmp_pa->pa_lstart;
+		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
+
+		if (ac->ac_o_ex.fe_logical < tmp_pa_start ||
+		    ac->ac_o_ex.fe_logical >= tmp_pa_end)
 			continue;
 
 		/* non-extent files can't have physical blocks past 2^32 */
 		if (!(ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS)) &&
-		    (pa->pa_pstart + EXT4_C2B(sbi, pa->pa_len) >
+		    (tmp_pa->pa_pstart + EXT4_C2B(sbi, tmp_pa->pa_len) >
 		     EXT4_MAX_BLOCK_FILE_PHYS)) {
 			/*
 			 * Since PAs don't overlap, we won't find any
@@ -4391,16 +4392,16 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 		}
 
 		/* found preallocated blocks, use them */
-		spin_lock(&pa->pa_lock);
-		if (pa->pa_deleted == 0 && pa->pa_free) {
-			atomic_inc(&pa->pa_count);
-			ext4_mb_use_inode_pa(ac, pa);
-			spin_unlock(&pa->pa_lock);
+		spin_lock(&tmp_pa->pa_lock);
+		if (tmp_pa->pa_deleted == 0 && tmp_pa->pa_free) {
+			atomic_inc(&tmp_pa->pa_count);
+			ext4_mb_use_inode_pa(ac, tmp_pa);
+			spin_unlock(&tmp_pa->pa_lock);
 			ac->ac_criteria = 10;
 			rcu_read_unlock();
 			return true;
 		}
-		spin_unlock(&pa->pa_lock);
+		spin_unlock(&tmp_pa->pa_lock);
 	}
 	rcu_read_unlock();
 
@@ -4424,16 +4425,16 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	 */
 	for (i = order; i < PREALLOC_TB_SIZE; i++) {
 		rcu_read_lock();
-		list_for_each_entry_rcu(pa, &lg->lg_prealloc_list[i],
+		list_for_each_entry_rcu(tmp_pa, &lg->lg_prealloc_list[i],
 					pa_inode_list) {
-			spin_lock(&pa->pa_lock);
-			if (pa->pa_deleted == 0 &&
-					pa->pa_free >= ac->ac_o_ex.fe_len) {
+			spin_lock(&tmp_pa->pa_lock);
+			if (tmp_pa->pa_deleted == 0 &&
+					tmp_pa->pa_free >= ac->ac_o_ex.fe_len) {
 
 				cpa = ext4_mb_check_group_pa(goal_block,
-								pa, cpa);
+								tmp_pa, cpa);
 			}
-			spin_unlock(&pa->pa_lock);
+			spin_unlock(&tmp_pa->pa_lock);
 		}
 		rcu_read_unlock();
 	}
-- 
2.31.1

