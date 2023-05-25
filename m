Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0A8710B17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 13:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240957AbjEYLeQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 07:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbjEYLdn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 07:33:43 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39D912F;
        Thu, 25 May 2023 04:33:41 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PB31U2026246;
        Thu, 25 May 2023 11:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hlzOi87vQ6A+8zabEmuFbG1ZOr9eYKzr/E32RkRRSMs=;
 b=e5nj081MvRoVUe1fckayiLF5ho+5gKoftg3rL7P66matGFvA79IoJGK3m4hY+WGLmSy9
 X8Hzy6p7UM6izDoaTqQ0wla2H0SzFqA6XO28cBy8lqsW6AtWNXlBszzQbBTcJtVY3F4z
 6pAgGIKS6CqLwn5vwfPILjv6BQLL2zC2MR2kT6btKvHMW4wiermbvGo2ZbcjUGNrpgt1
 5YoClimiXtRJPkziPVjlFWqLYp74XIW/mTnIJ4RuNDhF+B3UNdUDp/tTb0xKocMqcY8a
 A8Z3yNT73nqsT5PM/esidyqsnbcX/g+rAHcZGmz89pxPnmL4+gfZnIMlnyUtLPnDfG7F eA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qt6ey0r90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:34 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34PB3bNh028783;
        Thu, 25 May 2023 11:33:33 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qt6ey0r8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:33 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34P4mNUG007648;
        Thu, 25 May 2023 11:33:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qppc3jduv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:31 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34PBXTxq18023056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 May 2023 11:33:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66B812004B;
        Thu, 25 May 2023 11:33:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7317720040;
        Thu, 25 May 2023 11:33:27 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 25 May 2023 11:33:27 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH 08/13] ext4: Avoid scanning smaller extents in BG during CR1
Date:   Thu, 25 May 2023 17:03:02 +0530
Message-Id: <b39b81f92eb5fc4544d52eaaa5942c22e5ce378f.1685009579.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1685009579.git.ojaswin@linux.ibm.com>
References: <cover.1685009579.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HAIt1W54NP6mZBnLszOc69MHT05C_kgN
X-Proofpoint-GUID: fUmjCosOw7NFolhXAk-h29IsQAXj_BtC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_06,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=756 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we are inside ext4_mb_complex_scan_group() in CR1, we can be sure
that this group has atleast 1 big enough continuous free extent to satisfy
our request because (free / fragments) > goal length.

Hence, instead of wasting time looping over smaller free extents, only
try to consider the free extent if we are sure that it has enough
continuous free space to satisfy goal length. This is particularly
useful when scanning highly fragmented BGs in CR1 as, without this
patch, the allocator might stop scanning early before reaching the big
enough free extent (due to ac_found > mb_max_to_scan) which causes us to
uncessarily trim the request.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 8786aa0dd57a..855fb7d440f1 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2307,7 +2307,7 @@ void ext4_mb_complex_scan_group(struct ext4_allocation_context *ac,
 	struct super_block *sb = ac->ac_sb;
 	void *bitmap = e4b->bd_bitmap;
 	struct ext4_free_extent ex;
-	int i;
+	int i, j, freelen;
 	int free;
 
 	free = e4b->bd_info->bb_free;
@@ -2334,6 +2334,23 @@ void ext4_mb_complex_scan_group(struct ext4_allocation_context *ac,
 			break;
 		}
 
+		if (ac->ac_criteria < CR2) {
+			/*
+			 * In CR1, we are sure that this group will
+			 * have a large enough continuous free extent, so skip
+			 * over the smaller free extents
+			 */
+			j = mb_find_next_bit(bitmap,
+						EXT4_CLUSTERS_PER_GROUP(sb), i);
+			freelen = j - i;
+
+			if (freelen < ac->ac_g_ex.fe_len) {
+				i = j;
+				free -= freelen;
+				continue;
+			}
+		}
+
 		mb_find_extent(e4b, i, ac->ac_g_ex.fe_len, &ex);
 		if (WARN_ON(ex.fe_len <= 0))
 			break;
-- 
2.31.1

