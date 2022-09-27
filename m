Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9B95EBE57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 11:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiI0JU1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 05:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbiI0JUC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:20:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B59CBAEA;
        Tue, 27 Sep 2022 02:19:00 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28R8prQW024330;
        Tue, 27 Sep 2022 09:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=WCaGnJR/nP95v1L/TPEC5EtqwHoBOZ14pf7HGb7yqys=;
 b=PI0UCiE3aUNIv1rCpNVu1yaTNSsO9NGSGW8tYUsj3QjgnAvJ+glVd6QGh2Amy/cEZeW8
 6RbJUdI+lfkE4QCc4ZFxj49aFtQhg5wJY0eI+Uz55jXrLDHAb5tGCTR7ksvuOggkvYHz
 zaMd+/k6YQv5jSCJSzDy2rz7uuM/UqdcFVf5uLrpH11QNMqszcWYs5oQfpqEqnXrYG96
 qZiL4Yuy/LNiN7gzh/2Ig/POdptTYqjQW9X0lks4wPsipqjWhjUkxo7zqh3R8h9abNyW
 gr34FcGwADyl7EY/tZs7hcg5saYJXWC/nXGv2dFtWyKdG846WYOHGLaG4rinJV1YGb6N KQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jux1h8v8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 09:18:32 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28R8u7k0007286;
        Tue, 27 Sep 2022 09:18:31 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jux1h8v7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 09:18:31 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28R95crM018785;
        Tue, 27 Sep 2022 09:18:29 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3jssh9bm46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 09:18:29 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28R9IRrN1442536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 09:18:27 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CED942045;
        Tue, 27 Sep 2022 09:18:27 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9FE04203F;
        Tue, 27 Sep 2022 09:18:24 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.61.44])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Sep 2022 09:18:24 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC v3 3/8] ext4: Refactor code in ext4_mb_normalize_request() and ext4_mb_use_preallocated()
Date:   Tue, 27 Sep 2022 14:46:43 +0530
Message-Id: <8ec3ed728f046495c39f01881b57ef12fdabeb2a.1664269665.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1664269665.git.ojaswin@linux.ibm.com>
References: <cover.1664269665.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zQ0qJIhywe2olsnwms96I-qVDIS_1S1X
X-Proofpoint-GUID: hBjVDWFxNkTLSzirXs2JQtcQ8AS2KAAM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_02,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2209270053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
---
 fs/ext4/mballoc.c | 97 ++++++++++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 48 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 8be6f8765a6f..84950df709bb 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4000,7 +4000,8 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	loff_t orig_size __maybe_unused;
 	ext4_lblk_t start;
 	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
-	struct ext4_prealloc_space *pa;
+	struct ext4_prealloc_space *tmp_pa;
+	ext4_lblk_t tmp_pa_start, tmp_pa_end;
 
 	/* do normalize only data requests, metadata requests
 	   do not need preallocation */
@@ -4103,56 +4104,53 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 
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
 
@@ -4362,7 +4360,8 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	int order, i;
 	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
 	struct ext4_locality_group *lg;
-	struct ext4_prealloc_space *pa, *cpa = NULL;
+	struct ext4_prealloc_space *tmp_pa, *cpa = NULL;
+	ext4_lblk_t tmp_pa_start, tmp_pa_end;
 	ext4_fsblk_t goal_block;
 
 	/* only data can be preallocated */
@@ -4371,18 +4370,20 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 
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
@@ -4392,16 +4393,16 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
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
 
@@ -4425,16 +4426,16 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
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

