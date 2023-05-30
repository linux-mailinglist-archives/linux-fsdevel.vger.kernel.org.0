Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042C0715FF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 14:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjE3MhO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 08:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjE3Mgw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 08:36:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33F811C;
        Tue, 30 May 2023 05:36:06 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UCOl2u003371;
        Tue, 30 May 2023 12:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1H7yBmKwWS6qLPxfXmhxuHALtpCrbdFBBi5pueIf3Tg=;
 b=OnQQRUnko7IbhupkBuSuquCGB4Po1talukgUbWNFC82+GscTtiZf69fVPBSaVWxIAvAR
 crYtpbUQsL8a5amGipEpRgt3QeMAC9imuOrlvAJStO3Nc/A5b/zBX1kyAq1aTiYxlpU/
 3xz/L81EJN0p5rAUyi8AJDTphMEzS5/v6/Yte5S/7BeXGTEE/P2IMlMvacamWqQ+jpyY
 157K7hf2wP3uo4vMprIfqnagGPJGdE4WSXH1OlMcx7XENvCvvBGeMbJZEsmHtdXVggMn
 +GhMq1LdayA9FqGTSTsPPy573WLBYists2VjO0bTv6SwaqWe677BukU8yFqi7ix/+Fsk yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwh46r8xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:17 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UCRhtm010960;
        Tue, 30 May 2023 12:34:17 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwh46r8wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:17 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34U5fcYK001036;
        Tue, 30 May 2023 12:34:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3qu9g5989e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34UCYC7a13173334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 12:34:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3E122004B;
        Tue, 30 May 2023 12:34:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25C0520043;
        Tue, 30 May 2023 12:34:10 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 30 May 2023 12:34:09 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v2 08/12] ext4: Don't skip prefetching BLOCK_UNINIT groups
Date:   Tue, 30 May 2023 18:03:46 +0530
Message-Id: <dc3130b8daf45ffe63d8a3c1edcf00eb8ba70e1f.1685449706.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1685449706.git.ojaswin@linux.ibm.com>
References: <cover.1685449706.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: g4xofLyjXWLwfN4tMZgNFLF-Bbnq3IcV
X-Proofpoint-GUID: ac0-LLC3goxZyURTmM3K18cL4EsiDN4K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_08,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 adultscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Currently, ext4_mb_prefetch() and ext4_mb_prefetch_fini() skip
BLOCK_UNINIT groups since fetching their bitmaps doesn't need disk IO.
As a consequence, we end not initializing the buddy structures and CR0/1
lists for these BGs, even though it can be done without any disk IO
overhead. Hence, don't skip such BGs during prefetch and prefetch_fini.

This improves the accuracy of CR0/1 allocation as earlier, we could have
essentially empty BLOCK_UNINIT groups being ignored by CR0/1 due to their buddy
not being initialized, leading to slower CR2 allocations. With this patch CR0/1
will be able to discover these groups as well, thus improving performance.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index c86565606359..79455c7e645b 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2590,9 +2590,7 @@ ext4_group_t ext4_mb_prefetch(struct super_block *sb, ext4_group_t group,
 		 */
 		if (gdp && grp && !EXT4_MB_GRP_TEST_AND_SET_READ(grp) &&
 		    EXT4_MB_GRP_NEED_INIT(grp) &&
-		    ext4_free_group_clusters(sb, gdp) > 0 &&
-		    !(ext4_has_group_desc_csum(sb) &&
-		      (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)))) {
+		    ext4_free_group_clusters(sb, gdp) > 0 ) {
 			bh = ext4_read_block_bitmap_nowait(sb, group, true);
 			if (bh && !IS_ERR(bh)) {
 				if (!buffer_uptodate(bh) && cnt)
@@ -2633,9 +2631,7 @@ void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
 		grp = ext4_get_group_info(sb, group);
 
 		if (grp && gdp && EXT4_MB_GRP_NEED_INIT(grp) &&
-		    ext4_free_group_clusters(sb, gdp) > 0 &&
-		    !(ext4_has_group_desc_csum(sb) &&
-		      (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)))) {
+		    ext4_free_group_clusters(sb, gdp) > 0) {
 			if (ext4_mb_init_group(sb, group, GFP_NOFS))
 				break;
 		}
-- 
2.31.1

