Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D490B4D13E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 10:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345506AbiCHJxT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 04:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345608AbiCHJxO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:53:14 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2592F3FBD2;
        Tue,  8 Mar 2022 01:52:18 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2288eFml016853;
        Tue, 8 Mar 2022 09:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+DbVfJM9T//JWovv3DB+Zga9LWmRsy++c1sznUWBOcc=;
 b=tAsy9WHjFvG4QIPmvLLx3qS+B57EXHbTabLvPV4uXznb7ZBMQ4xUQgDPJtYQmAHVcXTd
 ObTFvIoNLDILts8IKeqMjXCqGl8Q/W9/Bq9MFh+06hIQyF0XdPk4F1qqtXPLADWQVnZ4
 wpDX6R49+hANfwxb+1Z3ND31LIdm3GrCyB5Fw1x91TkrTplkj8FovC/8eJbpDwJ4DWz+
 cqCAQ3j761LMyXLY5IF8HlKe6NDdA5CvVerkGgHPao1gnOLGUkntXaWbS1+SPraXSB2f
 tg31YCAkErmnY1zi17M6wyfkGHl8Yc7yaBQKPlEoo3x2tXmSAmIObiwih5CuALzKb5fX yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ep0sccr2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 09:52:15 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2289aLQw013084;
        Tue, 8 Mar 2022 09:52:14 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ep0sccr22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 09:52:14 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2289h5Uu030993;
        Tue, 8 Mar 2022 09:52:13 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3eky4hy6av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 09:52:13 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2289qAPG40305086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Mar 2022 09:52:10 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E600A405F;
        Tue,  8 Mar 2022 09:52:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59431A4054;
        Tue,  8 Mar 2022 09:52:07 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.83.182])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Mar 2022 09:52:07 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnsastry@linux.ibm.com,
        Geetika Moolchandani <Geetika.Moolchandani1@ibm.com>
Subject: [PATCH 2/2] ext4: Make mb_optimize_scan performance mount option work with extents
Date:   Tue,  8 Mar 2022 15:22:01 +0530
Message-Id: <fc9a48f7f8dcfc83891a8b21f6dd8cdf056ed810.1646732698.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <c98970fe99f26718586d02e942f293300fb48ef3.1646732698.git.ojaswin@linux.ibm.com>
References: <c98970fe99f26718586d02e942f293300fb48ef3.1646732698.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gFRTUXBF-YZPRnQnchzBQPB9BGED1qVC
X-Proofpoint-GUID: VyyJX6WoVHVmI2TaY6gO4Q3BjUI3FA7-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_03,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203080049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently mb_optimize_scan scan feature which improves filesystem
performance heavily (when FS is fragmented), seems to be not working
with files with extents (ext4 by default has files with extents).

This patch fixes that and makes mb_optimize_scan feature work
for files with extents.

Below are some performance numbers obtained when allocating a 10M and 100M
file with and w/o this patch on a filesytem with no 1M contiguous block.

<perf numbers>
===============
Workload: dd if=/dev/urandom of=test conv=fsync bs=1M count=10/100

Time taken
=====================================================
no.     Size   without-patch     with-patch    Diff(%)
1       10M      0m8.401s         0m5.623s     33.06%
2       100M     1m40.465s        1m14.737s    25.6%

<debug stats>
=============
w/o patch:
  mballoc:
    reqs: 17056
    success: 11407
    groups_scanned: 13643
    cr0_stats:
            hits: 37
            groups_considered: 9472
            useless_loops: 36
            bad_suggestions: 0
    cr1_stats:
            hits: 11418
            groups_considered: 908560
            useless_loops: 1894
            bad_suggestions: 0
    cr2_stats:
            hits: 1873
            groups_considered: 6913
            useless_loops: 21
    cr3_stats:
            hits: 21
            groups_considered: 5040
            useless_loops: 21
    extents_scanned: 417364
            goal_hits: 3707
            2^n_hits: 37
            breaks: 1873
            lost: 0
    buddies_generated: 239/240
    buddies_time_used: 651080
    preallocated: 705
    discarded: 478

with patch:
  mballoc:
    reqs: 12768
    success: 11305
    groups_scanned: 12768
    cr0_stats:
            hits: 1
            groups_considered: 18
            useless_loops: 0
            bad_suggestions: 0
    cr1_stats:
            hits: 5829
            groups_considered: 50626
            useless_loops: 0
            bad_suggestions: 0
    cr2_stats:
            hits: 6938
            groups_considered: 580363
            useless_loops: 0
    cr3_stats:
            hits: 0
            groups_considered: 0
            useless_loops: 0
    extents_scanned: 309059
            goal_hits: 0
            2^n_hits: 1
            breaks: 1463
            lost: 0
    buddies_generated: 239/240
    buddies_time_used: 791392
    preallocated: 673
    discarded: 446

Fixes: 196e402 (ext4: improve cr 0 / cr 1 group scanning)
Reported-by: Geetika Moolchandani <Geetika.Moolchandani1@ibm.com>
Reported-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
Suggested-by: Ritesh Harjani <riteshh@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/mballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 67ac95c4cd9b..f9be6ab482a5 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1000,7 +1000,7 @@ static inline int should_optimize_scan(struct ext4_allocation_context *ac)
 		return 0;
 	if (ac->ac_criteria >= 2)
 		return 0;
-	if (ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
+	if (!ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
 		return 0;
 	return 1;
 }
-- 
2.27.0

