Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105EF710B1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 13:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241048AbjEYLeU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 07:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241003AbjEYLdw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 07:33:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EE21A2;
        Thu, 25 May 2023 04:33:46 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PBHmMp013908;
        Thu, 25 May 2023 11:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Z6fcc6NNSqJTClFZZHh8m3+GU7KSwuMd/F4hQa7lo3s=;
 b=SWU4L2q/d4QhD8WSxBNmXkwpD/f6we2yNtQYVFjKFX2aQ+Ff5VnrQrb7hRq6uOvfS43E
 OLYUq39Gzy5TQBmejg7fq02RyKyRJnYKkbGg4+Pg5ddGZq3VSsViLmevoQVJrcXbcoyY
 hDsngZaaBbDDfG/2JxooL3jwIWSnkn9jlcStly+0aVFyFSJpRkitY75L9ENaSHy3Nhn9
 K4Pb34RnQWNV/sTou/eBXq/dOBq6LuVNkpB7zArhLGa/ZBD7uGKn3vs3AQaWyRzmk7bg
 EQocvIb1vFLoeWGaKmToDrjmT2ThIp4HUanqz70OaifZr1LMXKAN343rryQidBSZoxWE Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qt6p60c6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:37 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34PBORPr004252;
        Thu, 25 May 2023 11:33:36 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qt6p60c4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:36 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34P3J8eu014849;
        Thu, 25 May 2023 11:33:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qppcuadwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:34 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34PBXVjE43385460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 May 2023 11:33:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B031E20043;
        Thu, 25 May 2023 11:33:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9A5220040;
        Thu, 25 May 2023 11:33:29 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 25 May 2023 11:33:29 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH 09/13] ext4: Don't skip prefetching BLOCK_UNINIT groups
Date:   Thu, 25 May 2023 17:03:03 +0530
Message-Id: <7e648187c5cd4174ba798fc8305dfc7bedd8e89a.1685009579.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1685009579.git.ojaswin@linux.ibm.com>
References: <cover.1685009579.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a9414PY9CEuaZhH2xPIKN9MFkU620ZSj
X-Proofpoint-GUID: gqLPfRKrArgDeGCJVFrlin0dtcBN1fa5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_06,2023-05-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 impostorscore=0 mlxlogscore=994
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
index 855fb7d440f1..b35c408cccc2 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2587,9 +2587,7 @@ ext4_group_t ext4_mb_prefetch(struct super_block *sb, ext4_group_t group,
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
@@ -2630,9 +2628,7 @@ void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
 		grp = ext4_get_group_info(sb, group);
 
 		if (gdp && grp && EXT4_MB_GRP_NEED_INIT(grp) &&
-		    ext4_free_group_clusters(sb, gdp) > 0 &&
-		    !(ext4_has_group_desc_csum(sb) &&
-		      (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)))) {
+		    ext4_free_group_clusters(sb, gdp) > 0) {
 			if (ext4_mb_init_group(sb, group, GFP_NOFS))
 				break;
 		}
-- 
2.31.1

