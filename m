Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C84710B1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 13:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241060AbjEYLeV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 07:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241014AbjEYLdx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 07:33:53 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8691A7;
        Thu, 25 May 2023 04:33:48 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PAlSXp016248;
        Thu, 25 May 2023 11:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Fuw4V0h6Y7p4d6qJwiwd6fcmAPHJrIzLvuvBDJ8fdeA=;
 b=dPkmr2wX5zErpW1kdFKUSw9AJ6cvK+0ikPzAx418tTka9QkWzGyDB5/BKQRNT/cvV9pC
 +3yuxl8L0kVvSDUGSp+SoXvil2wSxbfwl/B/IZjWWZkHPh7uZNSAsfgy7RGplUN3qHWt
 Yx6IP9miiaoDorvwdxqE2KuGVrEYAkao74xFl2TXqZQwsgnbF2W564ujLVfGV8+ddpi/
 qJrGJoGILRKKN2YdGLy8wgWPrJrn+Zh6cWit73vB/wrwgSQyROpD7EJvImNg81X3CgG/
 lKv3Qijj5He6/VQExz5xoa3daQYIOPezu8fpY80dcAcssKDxgH5DRaXYFORCckkXyo+g 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qt67w14ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:41 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34PBBRYC013230;
        Thu, 25 May 2023 11:33:41 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qt67w14k8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:41 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34PAuch0022314;
        Thu, 25 May 2023 11:33:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qppcuadwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34PBXaxp38863136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 May 2023 11:33:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7651F2004B;
        Thu, 25 May 2023 11:33:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82E2220040;
        Thu, 25 May 2023 11:33:34 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 25 May 2023 11:33:34 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH 11/13] ext4: Abstract out logic to search average fragment list
Date:   Thu, 25 May 2023 17:03:05 +0530
Message-Id: <0ad6ab5b9000b6ce11cbfc64ef0f73684ad85710.1685009579.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1685009579.git.ojaswin@linux.ibm.com>
References: <cover.1685009579.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qxy2P6yHD8T4kv6NLAQSa-42njPLjf-3
X-Proofpoint-GUID: ZirREitoO_bZa0wCRapLScgI11_5BT3M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_06,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305250092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index b6bb314d778e..fd29ee02685d 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -904,6 +904,37 @@ static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
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
@@ -912,7 +943,7 @@ static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
 		enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
-	struct ext4_group_info *grp = NULL, *iter;
+	struct ext4_group_info *grp = NULL;
 	int i;
 
 	if (unlikely(ac->ac_flags & EXT4_MB_CR1_OPTIMIZED)) {
@@ -922,23 +953,7 @@ static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
 
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

