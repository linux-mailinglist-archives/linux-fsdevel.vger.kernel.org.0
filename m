Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A19710B18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 13:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjEYLeT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 07:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240984AbjEYLdr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 07:33:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92341A1;
        Thu, 25 May 2023 04:33:45 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PBHmMs013908;
        Thu, 25 May 2023 11:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bgdXhjl65x7+l2OGSSsYoGp2ZCBpNnTjVWIKj+On1qM=;
 b=CDNtnI6ElzJZQvCVaujLjtEMtWBj/Nks5UVyGE/ghXMI2mdYWrAAYExkMdVuCULuFX8B
 fWTGdjT9poWnw5g41QQTFcP207SJO9l3byGwNZt/u9kNTUrKw44wjtQVsh1eMTTIBaky
 81x6LCOakyW/kt0WFPoNCEFiZ5H/zr+q6r2CCI2F0OpmfSjfvwF3BDcTRaXng5K8r6wG
 cim2nSLTjl4PwvvD5mq1L0kJGft4HYy0zHWec+qDt6x2yck+gJV14fLsbNCHqyVYuKxF
 5WweCl7NybAumP+XROtzlXozJYr1SHkum3zP2ZNghAlkx9cNmVcy2vQ/0C2ErwWV+0h6 WA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qt6p60c7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:39 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34PBTF2R018004;
        Thu, 25 May 2023 11:33:38 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qt6p60c6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:38 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34P2E9oR001905;
        Thu, 25 May 2023 11:33:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qppdk2dst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34PBXYtw62063088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 May 2023 11:33:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B5A020043;
        Thu, 25 May 2023 11:33:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CD0C20040;
        Thu, 25 May 2023 11:33:32 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 25 May 2023 11:33:31 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH 10/13] ext4: Ensure ext4_mb_prefetch_fini() is called for all prefetched BGs
Date:   Thu, 25 May 2023 17:03:04 +0530
Message-Id: <c25f6f22dd232ba5fc150e0ed306cb19565c4bb2.1685009579.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1685009579.git.ojaswin@linux.ibm.com>
References: <cover.1685009579.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MhX1_wziKztF6Z7ovYNvKBhCISpLw5hM
X-Proofpoint-GUID: hA6Pdv86fDJjuckfV-ZEOD-Nrpg5odjj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_06,2023-05-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 impostorscore=0 mlxlogscore=908
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Before this patch, the call stack in ext4_run_li_request is as follows:

  /*
   * nr = no. of BGs we want to fetch (=s_mb_prefetch)
   * prefetch_ios = no. of BGs not uptodate after
   * 		    ext4_read_block_bitmap_nowait()
   */
  next_group = ext4_mb_prefetch(sb, group, nr, prefetch_ios);
  ext4_mb_prefetch_fini(sb, next_group prefetch_ios);

ext4_mb_prefetch_fini() will only try to initialize buddies for BGs in
range [next_group - prefetch_ios, next_group). This is incorrect since
sometimes (prefetch_ios < nr), which causes ext4_mb_prefetch_fini() to
incorrectly ignore some of the BGs that might need initialization. This
issue is more notable now with the previous patch enabling "fetching" of
BLOCK_UNINIT BGs which are marked buffer_uptodate by default.

Fix this by passing nr to ext4_mb_prefetch_fini() instead of
prefetch_ios so that it considers the right range of groups.

Similarly, make sure we don't pass nr=0 to ext4_mb_prefetch_fini() in
ext4_mb_regular_allocator() since we might have prefetched BLOCK_UNINIT
groups that would need buddy initialization.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c |  4 ----
 fs/ext4/super.c   | 11 ++++-------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index b35c408cccc2..b6bb314d778e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2732,8 +2732,6 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			if ((prefetch_grp == group) &&
 			    (cr > CR1 ||
 			     prefetch_ios < sbi->s_mb_prefetch_limit)) {
-				unsigned int curr_ios = prefetch_ios;
-
 				nr = sbi->s_mb_prefetch;
 				if (ext4_has_feature_flex_bg(sb)) {
 					nr = 1 << sbi->s_log_groups_per_flex;
@@ -2742,8 +2740,6 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 				}
 				prefetch_grp = ext4_mb_prefetch(sb, group,
 							nr, &prefetch_ios);
-				if (prefetch_ios == curr_ios)
-					nr = 0;
 			}
 
 			/* This now checks without needing the buddy page */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 495f99c10085..37a6fa118ced 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3694,16 +3694,13 @@ static int ext4_run_li_request(struct ext4_li_request *elr)
 	ext4_group_t group = elr->lr_next_group;
 	unsigned int prefetch_ios = 0;
 	int ret = 0;
+	int nr = EXT4_SB(sb)->s_mb_prefetch;
 	u64 start_time;
 
 	if (elr->lr_mode == EXT4_LI_MODE_PREFETCH_BBITMAP) {
-		elr->lr_next_group = ext4_mb_prefetch(sb, group,
-				EXT4_SB(sb)->s_mb_prefetch, &prefetch_ios);
-		if (prefetch_ios)
-			ext4_mb_prefetch_fini(sb, elr->lr_next_group,
-					      prefetch_ios);
-		trace_ext4_prefetch_bitmaps(sb, group, elr->lr_next_group,
-					    prefetch_ios);
+		elr->lr_next_group = ext4_mb_prefetch(sb, group, nr, &prefetch_ios);
+		ext4_mb_prefetch_fini(sb, elr->lr_next_group, nr);
+		trace_ext4_prefetch_bitmaps(sb, group, elr->lr_next_group, nr);
 		if (group >= elr->lr_next_group) {
 			ret = 1;
 			if (elr->lr_first_not_zeroed != ngroups &&
-- 
2.31.1

