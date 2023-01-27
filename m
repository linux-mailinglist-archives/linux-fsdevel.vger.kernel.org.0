Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5831467E576
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 13:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbjA0MiJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 07:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbjA0MiB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:38:01 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C3C12061;
        Fri, 27 Jan 2023 04:38:00 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RC1RsW010141;
        Fri, 27 Jan 2023 12:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=86vbvxV3oTbbVZUf0y4m/BYO8NK+DMGh0g9SOSIp/ko=;
 b=ZXzl+yCpV7nEXzO/FxLkftTFCrIkzZFhTCCHHjVMCJ83snzUGfGbA18OoGcb1hUNvSGO
 kK/sMis5w4qUJiLLXf6NGMjDxYwlmxdnniHKK5UqTR8OUu5jVAp6ISJa4JtsBD1GNh7D
 7E4PzTyluNsgzgYAQIt6ObueLJqTmsSoE0L3Cn8qWuegzr1y4whXv0E3tNOykS/3mwKI
 /JHfwhaCOMSFVPElPWO5yNVwv1OQ3LLMGBvWDLTaOE+4dvdEhD5ijNM9e6F9m7idyC5j
 MUZL26iCMgG2jAKjTR7ZGYb+yJWyZ1sg9FJH2rOEteY9VZ3xXd1ECAjuDIG07V7oW6I3 cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nce8m8vcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:37:55 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30RCKn4A002183;
        Fri, 27 Jan 2023 12:37:55 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nce8m8vce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:37:55 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30R4ux3h026714;
        Fri, 27 Jan 2023 12:37:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6fhrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:37:53 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30RCbpRA21889394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 12:37:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4439920040;
        Fri, 27 Jan 2023 12:37:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEC9F20043;
        Fri, 27 Jan 2023 12:37:48 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.40.88])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jan 2023 12:37:48 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 03/11] ext4: mballoc: Fix getting the right group desc in ext4_mb_prefetch_fini
Date:   Fri, 27 Jan 2023 18:07:30 +0530
Message-Id: <85bbcb3774e38de65b737ef0000241ddbdda73aa.1674822311.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1674822311.git.ojaswin@linux.ibm.com>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hB3dcAg9-TZnWCKfKG4vQUi6nytJgI2c
X-Proofpoint-GUID: PBpOGYKAC-JEASkWHryYuXUdGurJD6df
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_07,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=917 priorityscore=1501 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

group descriptor and group info are not of the same group in
ext4_mb_prefetch_fini(). This problem was found during code
review/walkthrough and seems like a bug, so fix it.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/mballoc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 572e79a698d4..8b22cc07b054 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2569,14 +2569,14 @@ ext4_group_t ext4_mb_prefetch(struct super_block *sb, ext4_group_t group,
 void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
 			   unsigned int nr)
 {
-	while (nr-- > 0) {
-		struct ext4_group_desc *gdp = ext4_get_group_desc(sb, group,
-								  NULL);
-		struct ext4_group_info *grp = ext4_get_group_info(sb, group);
+	struct ext4_group_desc *gdp;
+	struct ext4_group_info *grp;
 
+	while (nr-- > 0) {
 		if (!group)
 			group = ext4_get_groups_count(sb);
 		group--;
+		gdp = ext4_get_group_desc(sb, group, NULL);
 		grp = ext4_get_group_info(sb, group);
 
 		if (EXT4_MB_GRP_NEED_INIT(grp) &&
-- 
2.31.1

