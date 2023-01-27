Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A0767E591
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 13:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbjA0Mjt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 07:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbjA0MjD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:39:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6286C127;
        Fri, 27 Jan 2023 04:38:16 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RB9Wp2026743;
        Fri, 27 Jan 2023 12:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ViiwjZsYS8rJfVsorx/BK548xVcoUVwZZK3Mhl/vduY=;
 b=RzrfbvGMowJmW0yytR/6KWkBaEma0ssg9kMSkMNWEeRFHhELtJLFl1quPRS5hsszZw2V
 oaL4Nl8PAgMCX7zSiN7wsDcA8uj7uWNcohEaCsxM51WTzghHEbdY2Z4Gk2Fr+Jy3Irbl
 N+YfPoa4B+KXUUoUSDFNNsRH7Q39M7CGdfDj5oAMA1XWO1jYdKWefP8rcajaSl6tlF+Q
 0nmDW6OczfHAiVY8oniAXrtZ8PboZoJfk64IahgLgbq3xSYcVLLJwJDKV/ZjHPdGSpzh
 hg49IxhLdGyHSprkwh5h1xFVwttqDkOOLnvjNYDUNEqtO3bn+1R+GVZ2kPh6InA/9fLx SQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncb55w9kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:38:12 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30RCDHD0012119;
        Fri, 27 Jan 2023 12:38:12 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncb55w9ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:38:12 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30R5NAKZ010329;
        Fri, 27 Jan 2023 12:38:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6qgt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:38:10 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30RCc7BL44040462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 12:38:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D573520043;
        Fri, 27 Jan 2023 12:38:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBE4C20040;
        Fri, 27 Jan 2023 12:38:05 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.40.88])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jan 2023 12:38:05 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 10/11] ext4: Abstract out logic to search average fragment list
Date:   Fri, 27 Jan 2023 18:07:37 +0530
Message-Id: <3f0afae57eeaf47aa4b980eddc5e54efc78efa66.1674822311.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1674822311.git.ojaswin@linux.ibm.com>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8s6nDf2jbjAUlnTqX295flokxyhpNU5b
X-Proofpoint-ORIG-GUID: 4OR5m4pUhQrn4sSmhQNL4_mtsa7ErGzl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_06,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 priorityscore=1501 phishscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
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
---
 fs/ext4/mballoc.c | 51 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 410c9636907b..1ce1174aea52 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -902,6 +902,37 @@ static void ext4_mb_choose_next_group_cr0(struct ext4_allocation_context *ac,
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
@@ -910,7 +941,7 @@ static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
 		enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
-	struct ext4_group_info *grp = NULL, *iter;
+	struct ext4_group_info *grp = NULL;
 	int i;
 
 	if (unlikely(ac->ac_flags & EXT4_MB_CR1_OPTIMIZED)) {
@@ -920,23 +951,7 @@ static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
 
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

