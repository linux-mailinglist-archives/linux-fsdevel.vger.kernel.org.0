Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E4F6BE3E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 09:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjCQIi7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 04:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjCQIib (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:38:31 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC226A1CA;
        Fri, 17 Mar 2023 01:37:57 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H8JSIQ016301;
        Fri, 17 Mar 2023 08:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=itKEK4oNCV7DlUSLzWA1Wtf6ATzED6UkuTpj584/Dpk=;
 b=CK974veiDR40zXwFlghM4ECNnviy4cNwFc5xWY/HqlPl36mjkL5dKwd2vzojgR6MWAZU
 fJVRhhLwdhtlKn2ATDOuR7EpGYBn1e1rUlMH7gvblADQe/qMeGlb1BvYT0cXAQTY6bc1
 l2wIeBw2NcXnHKcDu5J1L+/Ca3l5vGSBGV2QC2IrwI3b/r1KcBVfOPWZnVTJm913gOQ4
 1Eh6Wq21eRBIppy8ozJ8yP9jsC3xaitEBMjZWP5i/y7M6KWnAXJ0QqblvgDedgSkVatm
 0x+o+sXffs2Nn7j2NSJk5e41XvezPOAonFYe7K4ipzb+lniINWppVVrmdl/epGpB4F+W +w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pcmkjrb6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 08:37:37 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32H8TMat021274;
        Fri, 17 Mar 2023 08:37:36 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pcmkjrb4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 08:37:36 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32H6jEIS015009;
        Fri, 17 Mar 2023 08:37:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3pbsf3hwa6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 08:37:32 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32H8bUDr25690676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 08:37:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CF0920F63;
        Fri, 17 Mar 2023 08:37:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B2B020F67;
        Fri, 17 Mar 2023 08:37:28 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.91.202])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Mar 2023 08:37:27 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v5 4/9] ext4: Move overlap assert logic into a separate function
Date:   Fri, 17 Mar 2023 14:07:08 +0530
Message-Id: <9daf8d640692e03c2a710d2919a5cb70bbc6ef0d.1679042083.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1679042083.git.ojaswin@linux.ibm.com>
References: <cover.1679042083.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G6UsBIuJtdmIB91Wl4FLhYHqV5rt-aoc
X-Proofpoint-ORIG-GUID: XLjWzKe8dqXLT8kpUf6iR3wMf66zz2Ds
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_04,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Abstract out the logic to double check for overlaps in normalize_pa to
a separate function. Since there has been no reports in past where we
have seen any overlaps which hits this bug_on(), in future we can
consider calling this function under "#ifdef AGGRESSIVE_CHECK" only.

There are no functional changes in this patch

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a1429d5a1197..daa8411d6b61 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3978,6 +3978,29 @@ static void ext4_mb_normalize_group_request(struct ext4_allocation_context *ac)
 	mb_debug(sb, "goal %u blocks for locality group\n", ac->ac_g_ex.fe_len);
 }
 
+static inline void
+ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
+			  ext4_lblk_t start, ext4_lblk_t end)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
+	struct ext4_prealloc_space *tmp_pa;
+	ext4_lblk_t tmp_pa_start, tmp_pa_end;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
+		spin_lock(&tmp_pa->pa_lock);
+		if (tmp_pa->pa_deleted == 0) {
+			tmp_pa_start = tmp_pa->pa_lstart;
+			tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
+
+			BUG_ON(!(start >= tmp_pa_end || end <= tmp_pa_start));
+		}
+		spin_unlock(&tmp_pa->pa_lock);
+	}
+	rcu_read_unlock();
+}
+
 /*
  * Normalization means making request better in terms of
  * size and alignment
@@ -4135,17 +4158,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	size = end - start;
 
 	/* XXX: extra loop to check we really don't overlap preallocations */
-	rcu_read_lock();
-	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
-		spin_lock(&tmp_pa->pa_lock);
-		if (tmp_pa->pa_deleted == 0) {
-			tmp_pa_start = tmp_pa->pa_lstart;
-			tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
-			BUG_ON(!(start >= tmp_pa_end || end <= tmp_pa_start));
-		}
-		spin_unlock(&tmp_pa->pa_lock);
-	}
-	rcu_read_unlock();
+	ext4_mb_pa_assert_overlap(ac, start, end);
 
 	/*
 	 * In this function "start" and "size" are normalized for better
-- 
2.31.1

