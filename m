Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC47E67E585
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 13:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbjA0MjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 07:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbjA0Miz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:38:55 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3682677AC;
        Fri, 27 Jan 2023 04:38:11 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RCM9Q8006083;
        Fri, 27 Jan 2023 12:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=25XjohbFV2CvFZCrVi5Ol25gUnamkQMJyOCZ53Pxucs=;
 b=Ml+0HC/YzZNmKnIihe+BH7Vey+OgGBo+EFMiiDP+r3Q/bd4285J4Oyp7J6hP7fMgDuAO
 Udvv1fO2r4qAwVTCh2KlQn4bOkCVDbvE7c6puUXLVeTtBdT8MeRXx3xBdgAUWrs+f2k4
 Augr4JJA9IH8XWyJSKHKj/qA/K+mAhaI26olsRv0e5+ndXO+itx+dNkfEZW/iD06Wi7U
 1YLNv9z792bIJjqL4hZcfOIYrtu921/8E1c/X18R/ha7YLwr4l8V7HeTQ4PemDYZEF7G
 CSX7S+MAjkS/R7MU0DAidkyqM0S6BCgb3c61PElgBOj/Ql+ydVQNNs4LluZvvV2ixSZu gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nce8m8vhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:38:07 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30RCXd7s013631;
        Fri, 27 Jan 2023 12:38:07 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nce8m8vh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:38:07 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30R5jmcL014941;
        Fri, 27 Jan 2023 12:38:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n87affhcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:38:05 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30RCc3cC22151574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 12:38:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BB0220040;
        Fri, 27 Jan 2023 12:38:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3171520043;
        Fri, 27 Jan 2023 12:38:01 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.40.88])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jan 2023 12:38:00 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 08/11] ext4: Don't skip prefetching BLOCK_UNINIT groups
Date:   Fri, 27 Jan 2023 18:07:35 +0530
Message-Id: <4881693a4f5ba1fed367310b27c793e4e78520d3.1674822311.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1674822311.git.ojaswin@linux.ibm.com>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pNaIHWS1mSNMwSyOrlEmrsCHnjwazt_I
X-Proofpoint-GUID: Src4obuxj8IyQs2NKNTbDUMwAoNocL00
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_07,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 phishscore=0
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
---
 fs/ext4/mballoc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 14529d2fe65f..48726a831264 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2557,9 +2557,7 @@ ext4_group_t ext4_mb_prefetch(struct super_block *sb, ext4_group_t group,
 		 */
 		if (!EXT4_MB_GRP_TEST_AND_SET_READ(grp) &&
 		    EXT4_MB_GRP_NEED_INIT(grp) &&
-		    ext4_free_group_clusters(sb, gdp) > 0 &&
-		    !(ext4_has_group_desc_csum(sb) &&
-		      (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)))) {
+		    ext4_free_group_clusters(sb, gdp) > 0 ) {
 			bh = ext4_read_block_bitmap_nowait(sb, group, true);
 			if (bh && !IS_ERR(bh)) {
 				if (!buffer_uptodate(bh) && cnt)
@@ -2600,9 +2598,7 @@ void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
 		grp = ext4_get_group_info(sb, group);
 
 		if (EXT4_MB_GRP_NEED_INIT(grp) &&
-		    ext4_free_group_clusters(sb, gdp) > 0 &&
-		    !(ext4_has_group_desc_csum(sb) &&
-		      (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)))) {
+		    ext4_free_group_clusters(sb, gdp) > 0) {
 			if (ext4_mb_init_group(sb, group, GFP_NOFS))
 				break;
 		}
-- 
2.31.1

