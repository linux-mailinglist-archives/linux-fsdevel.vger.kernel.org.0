Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF4E715FF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 14:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjE3Mgq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 08:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjE3Mgj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 08:36:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41367106;
        Tue, 30 May 2023 05:35:42 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UCW8rj024088;
        Tue, 30 May 2023 12:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kgn6xxT26VWoUhCb9TpkGjQxt+cWGDoSd5p0LUKRKO8=;
 b=IXHQhXiaTf+uWz3yuWByrm4yEz77MJAlzw1jXbrA1aFozNWfRoNlpLX4ftT/oIVotQXo
 xvQypdnkmMEsSclWlLTUhHnt9Cnl+K/uprcIfT+l4CEiNp09EVg1zs7drbzTLWg6MHL3
 xaH4lEr+ttBngEdVS7joJY79JwiVCdNeZxUKGqKyVWZB+66MFmjzyYqPMLeKgYb2q11A
 0xp3EloVocUUEmYWBtUt9PXZHZmt80o9EFRJjUOgFDc2v1+1HWvEKItgTHYnKt6TXLyv
 vn96RTdR2FVfNl7Sz+O9e0kBY4cUd86cdCS5HIwK8pHE05GTm9SZFF9DL04Eo29BCAUD TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwf7dkq68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:24 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UAd286030036;
        Tue, 30 May 2023 12:34:23 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwf7dkq59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:23 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34U4dNL9014942;
        Tue, 30 May 2023 12:34:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qu9g59fe4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:19 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34UCYGbP40174082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 12:34:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C67A22004B;
        Tue, 30 May 2023 12:34:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D31F320043;
        Tue, 30 May 2023 12:34:14 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 30 May 2023 12:34:14 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v2 10/12] ext4: Abstract out logic to search average fragment list
Date:   Tue, 30 May 2023 18:03:48 +0530
Message-Id: <028c11d95b17ce0285f45456709a0ca922df1b83.1685449706.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1685449706.git.ojaswin@linux.ibm.com>
References: <cover.1685449706.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PemJ3zz3lhNLePB5y_gdddgvJW7yGTip
X-Proofpoint-ORIG-GUID: TKJFp6tHV7kOUTR9Fj3AW-KubOntF-Y3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_08,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make the logic of searching average fragment list of a given order reusable
by abstracting it out to a differnet function. This will also avoid
code duplication in upcoming patches.

No functional changes.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 51 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 6775d73dfc68..f59e1e0e01b1 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -905,6 +905,37 @@ static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
 	}
 }
 
+/*
+ * Find a suitable group of given order from the average fragments list.
+ */
+static struct ext4_group_info *
+ext4_mb_find_good_group_avg_frag_lists(struct ext4_allocation_context *ac, int order)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+	struct list_head *frag_list = &sbi->s_mb_avg_fragment_size[order];
+	rwlock_t *frag_list_lock = &sbi->s_mb_avg_fragment_size_locks[order];
+	struct ext4_group_info *grp = NULL, *iter;
+	enum criteria cr = ac->ac_criteria;
+
+	if (list_empty(frag_list))
+		return NULL;
+	read_lock(frag_list_lock);
+	if (list_empty(frag_list)) {
+		read_unlock(frag_list_lock);
+		return NULL;
+	}
+	list_for_each_entry(iter, frag_list, bb_avg_fragment_size_node) {
+		if (sbi->s_mb_stats)
+			atomic64_inc(&sbi->s_bal_cX_groups_considered[cr]);
+		if (likely(ext4_mb_good_group(ac, iter->bb_group, cr))) {
+			grp = iter;
+			break;
+		}
+	}
+	read_unlock(frag_list_lock);
+	return grp;
+}
+
 /*
  * Choose next group by traversing average fragment size list of suitable
  * order. Updates *new_cr if cr level needs an update.
@@ -913,7 +944,7 @@ static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
 		enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
-	struct ext4_group_info *grp = NULL, *iter;
+	struct ext4_group_info *grp = NULL;
 	int i;
 
 	if (unlikely(ac->ac_flags & EXT4_MB_CR1_OPTIMIZED)) {
@@ -923,23 +954,7 @@ static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
 
 	for (i = mb_avg_fragment_size_order(ac->ac_sb, ac->ac_g_ex.fe_len);
 	     i < MB_NUM_ORDERS(ac->ac_sb); i++) {
-		if (list_empty(&sbi->s_mb_avg_fragment_size[i]))
-			continue;
-		read_lock(&sbi->s_mb_avg_fragment_size_locks[i]);
-		if (list_empty(&sbi->s_mb_avg_fragment_size[i])) {
-			read_unlock(&sbi->s_mb_avg_fragment_size_locks[i]);
-			continue;
-		}
-		list_for_each_entry(iter, &sbi->s_mb_avg_fragment_size[i],
-				    bb_avg_fragment_size_node) {
-			if (sbi->s_mb_stats)
-				atomic64_inc(&sbi->s_bal_cX_groups_considered[CR1]);
-			if (likely(ext4_mb_good_group(ac, iter->bb_group, CR1))) {
-				grp = iter;
-				break;
-			}
-		}
-		read_unlock(&sbi->s_mb_avg_fragment_size_locks[i]);
+		grp = ext4_mb_find_good_group_avg_frag_lists(ac, i);
 		if (grp)
 			break;
 	}
-- 
2.31.1

