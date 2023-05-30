Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7BE715FEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 14:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjE3MgK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 08:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjE3MgF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 08:36:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1384E4D;
        Tue, 30 May 2023 05:35:32 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UBB2ZC019950;
        Tue, 30 May 2023 12:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=86pPEn07euotJE/N46+kGexbpyZlTqF7dkGt7c+ryg0=;
 b=UOm8DyZWISUEu7iX21VRjhm9bpni+zaW2L6qXRqMSNc/oNJ+tJBt7CdhYckZXBu5vrOh
 Vq9pu3ZP1NmnaNCLQ39CtpAHVzkBDfl9+1vXVwJ753VCPCjroi51Si5lEY2E8JGskieu
 AvLHAfY0gNdUvSJ2esH3VfrTiWnIuL59Z3MouRmOKqdlF/zmtCexdrwwrrEEc1l9+SFe
 QHCpGrd1VOiw3CYTLwHqsW700RjBd2CCZCUaao1UZ3sBu+vf3cBYYlgXp4OciUbj3PTK
 tNlG0sEZMMojqmDkYNvC93mk+SO7n5UCIdV3TqXnMv5vwxmcfbjMMUkT6KseCIV0Q/6f Rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwfsq2m16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:19 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UBbkun012737;
        Tue, 30 May 2023 12:34:19 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwfsq2m00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:19 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34TLXZnl001143;
        Tue, 30 May 2023 12:34:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qu94e1fjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34UCYEJk29360506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 12:34:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7012D2005A;
        Tue, 30 May 2023 12:34:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 633642004B;
        Tue, 30 May 2023 12:34:12 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 30 May 2023 12:34:12 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v2 09/12] ext4: Ensure ext4_mb_prefetch_fini() is called for all prefetched BGs
Date:   Tue, 30 May 2023 18:03:47 +0530
Message-Id: <05e648ae04ec5b754207032823e9c1de9a54f87a.1685449706.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1685449706.git.ojaswin@linux.ibm.com>
References: <cover.1685449706.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DlrV7AcFGp5JbYArQxun4zf-qADwkxi1
X-Proofpoint-ORIG-GUID: ImgblJZvIWi664sKlN_gPNvV8PJOhI5u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_08,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 adultscore=0 mlxlogscore=919
 impostorscore=0 mlxscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 79455c7e645b..6775d73dfc68 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2735,8 +2735,6 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			if ((prefetch_grp == group) &&
 			    (cr > CR1 ||
 			     prefetch_ios < sbi->s_mb_prefetch_limit)) {
-				unsigned int curr_ios = prefetch_ios;
-
 				nr = sbi->s_mb_prefetch;
 				if (ext4_has_feature_flex_bg(sb)) {
 					nr = 1 << sbi->s_log_groups_per_flex;
@@ -2745,8 +2743,6 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 				}
 				prefetch_grp = ext4_mb_prefetch(sb, group,
 							nr, &prefetch_ios);
-				if (prefetch_ios == curr_ios)
-					nr = 0;
 			}
 
 			/* This now checks without needing the buddy page */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 2da5476fa48b..27c1dabacd43 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3692,16 +3692,13 @@ static int ext4_run_li_request(struct ext4_li_request *elr)
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

