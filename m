Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EF7710B2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 13:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241133AbjEYLgG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 07:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241039AbjEYLf4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 07:35:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B44E5C;
        Thu, 25 May 2023 04:34:22 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PBC7X7018940;
        Thu, 25 May 2023 11:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=GYCS2gbWixp7go99TTfbJvm/cCaCF0uTvpfxdLKNBkk=;
 b=TPeXskFjXSK9mNEGDh7s15rBojMUZDHurr0kKDSUy1XTQKwKGoLsIETfTHDsnAje4wO2
 +clkOP75UHcx4DhOfKRXsPXiadRbmGozJZua/rtlSHE+uHYwBVmGN7yGKJllG+i3rYcb
 KG9uBNyfWqAOTzplJQc0uQnMyCwNCDKvjWpn8OAm5FrDScFj7O+YHPqZl0IDJsOa21dJ
 OYMcL9QJMWnEF/44T4Ljmg2r8qZu0tyD+n7N8vUwuXieQijXu75TsuyOrdyjuLf9xWyW
 nzj/dZs6KEOCVlG/incTwpJV7h9h26osPgDjdm3gTpQj4cIOYZc9+7P6zNPVrkUgwLd3 og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qt6kb0jb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:34:14 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34PBEBCX026026;
        Thu, 25 May 2023 11:34:14 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qt6kb0j7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:34:14 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34P3IouD021721;
        Thu, 25 May 2023 11:33:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qppdk2dsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:20 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34PBXHEi43385440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 May 2023 11:33:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CEEB820040;
        Thu, 25 May 2023 11:33:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C28FA2004D;
        Thu, 25 May 2023 11:33:15 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 25 May 2023 11:33:15 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH 03/13] ext4: Remove unused extern variables declaration
Date:   Thu, 25 May 2023 17:02:57 +0530
Message-Id: <1784dcc5422f1f37068704be565b8e16f4d51f19.1685009579.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1685009579.git.ojaswin@linux.ibm.com>
References: <cover.1685009579.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6kHerCjYGCRvjrcGdZLss1tby-r8p3wA
X-Proofpoint-GUID: Xwq3s7sAwzL9f8yde6hmyItPOsmdNEBN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_06,2023-05-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

ext4_mb_stats & ext4_mb_max_to_scan are never used. We use
sbi->s_mb_stats and sbi->s_mb_max_to_scan instead.
Hence kill these extern declarations.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h    | 2 --
 fs/ext4/mballoc.h | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 7e8f66ba17f4..80e01fbcd0a3 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2815,8 +2815,6 @@ int ext4_fc_record_regions(struct super_block *sb, int ino,
 /* mballoc.c */
 extern const struct seq_operations ext4_mb_seq_groups_ops;
 extern const struct seq_operations ext4_mb_seq_structs_summary_ops;
-extern long ext4_mb_stats;
-extern long ext4_mb_max_to_scan;
 extern int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset);
 extern int ext4_mb_init(struct super_block *);
 extern int ext4_mb_release(struct super_block *);
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 6d85ee8674a6..24b666e558f1 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -49,7 +49,7 @@
 #define MB_DEFAULT_MIN_TO_SCAN		10
 
 /*
- * with 'ext4_mb_stats' allocator will collect stats that will be
+ * with 's_mb_stats' allocator will collect stats that will be
  * shown at umount. The collecting costs though!
  */
 #define MB_DEFAULT_STATS		0
-- 
2.31.1

