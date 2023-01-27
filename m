Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8636F67E58A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 13:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbjA0Mjd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 07:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbjA0MjB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:39:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5FC4E52A;
        Fri, 27 Jan 2023 04:38:13 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RB1IX3026721;
        Fri, 27 Jan 2023 12:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=H4qhakP4j4IPrNknMbV0Ue+ap7BZD6C65A+YztZVLtk=;
 b=ZXcF52JZQgIQYnxh/YITf5cPSfeZa9SObyY4PMF9CePKC+CrIS2AU9LWfRvW4Rkzi+Ma
 KNkt6rfLV8eEQ32nDRcJzNGaJIKC6RASP2gPniK55JPCTeY233Q5QaQpvBO3LNvijFnJ
 o50zxzUnw0M/EOdsAjEqhhQTu1tHnhUowwwED/4gfM3o1slVVVbXf7wjYTM3w3lMJnhX
 YlmuB/kSIjgdCR5Ek/GVAVsfFsfXjzt76iI9U+f6+y/cETqOlZGJgOE5Map7UZPahSZX
 5/45quUdZvDQ4GXuUCYxQwnKgp3Qt+JoDwZXabhDsieZ5aZ5H1vf/Hc6f3Gp9uZ8ziyl 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncb55w9jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:38:10 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30RCToMI010837;
        Fri, 27 Jan 2023 12:38:09 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncb55w9j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:38:09 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QKRNG8006374;
        Fri, 27 Jan 2023 12:38:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3n87p6dduw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:38:07 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30RCc5wI21365072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 12:38:05 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7217120043;
        Fri, 27 Jan 2023 12:38:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77CCF20040;
        Fri, 27 Jan 2023 12:38:03 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.40.88])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jan 2023 12:38:03 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 09/11] ext4: Ensure ext4_mb_prefetch_fini() is called for all prefetched BGs
Date:   Fri, 27 Jan 2023 18:07:36 +0530
Message-Id: <7540e4069b22fce42dbef34ee0796d5cf5d82fe3.1674822311.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1674822311.git.ojaswin@linux.ibm.com>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Irr7xmvtPHPR9uAFXHZeB6fyyfaZRIIc
X-Proofpoint-ORIG-GUID: WfAo5dPNbML428YRoRBRWVokQpExi_5j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_06,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=937 clxscore=1015
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
---
 fs/ext4/mballoc.c |  4 ----
 fs/ext4/super.c   | 11 ++++-------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 48726a831264..410c9636907b 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2702,8 +2702,6 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			if ((prefetch_grp == group) &&
 			    (cr > CR1 ||
 			     prefetch_ios < sbi->s_mb_prefetch_limit)) {
-				unsigned int curr_ios = prefetch_ios;
-
 				nr = sbi->s_mb_prefetch;
 				if (ext4_has_feature_flex_bg(sb)) {
 					nr = 1 << sbi->s_log_groups_per_flex;
@@ -2712,8 +2710,6 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 				}
 				prefetch_grp = ext4_mb_prefetch(sb, group,
 							nr, &prefetch_ios);
-				if (prefetch_ios == curr_ios)
-					nr = 0;
 			}
 
 			/* This now checks without needing the buddy page */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 72ead3b56706..9dbb09cfc8f7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3636,16 +3636,13 @@ static int ext4_run_li_request(struct ext4_li_request *elr)
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

