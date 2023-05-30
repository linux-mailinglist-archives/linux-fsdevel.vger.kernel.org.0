Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE4B716011
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 14:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjE3MlH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 08:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjE3MlF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 08:41:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864EB102;
        Tue, 30 May 2023 05:40:40 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UCNvJA001911;
        Tue, 30 May 2023 12:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+BnaDz8GOFXK9Oo3BhAJjGeaM8iWRw27pFgOHNngyF0=;
 b=gM/wS2SPf5FIc+fIV1j8oWiRfV465rz+BEbTYy4VbR0BCP1hdAOulBuDTxp6sUiDQKly
 aINYu9qVJW+rWng6+cMTJsZjDh43QJtRMgrbwcKfS1gRdXoLp7iBApJkC+u2mlJk4avv
 LjbqF46OGuj/dtmmIMn9CoeuvyMv8Yi7TU2/zEFsm8WQ5lHXDhLVkUp7+m9fzksgZwIc
 KNYBPeFDg4jDlqmHDy8IOO1bnLEOlC2LSOeEZuKig7ADgq+ORkFPBC2lqn0t2Yxxacma
 aoOFC4oPvNN8gKLplE/X3tcWjgR7vcAwUyBSyLp9TbO8ucmgCDw/Utfbhkml/OeXZrPo cA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwh46r8gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:00 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UCPBkp005122;
        Tue, 30 May 2023 12:34:00 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwh46r8f3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:00 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34U2f7Gt007278;
        Tue, 30 May 2023 12:33:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qu9g59fdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:33:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34UCXtJa28967358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 12:33:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 646472004B;
        Tue, 30 May 2023 12:33:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6627820040;
        Tue, 30 May 2023 12:33:53 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 30 May 2023 12:33:53 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v2 01/12] Revert "ext4: remove ac->ac_found > sbi->s_mb_min_to_scan dead check in ext4_mb_check_limits"
Date:   Tue, 30 May 2023 18:03:39 +0530
Message-Id: <ddcae9658e46880dfec2fb0aa61d01fb3353d202.1685449706.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1685449706.git.ojaswin@linux.ibm.com>
References: <cover.1685449706.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MKzok8uVa59I_SxTeep2p2vJ_uz6d4jo
X-Proofpoint-GUID: gWtt9MZouc8fyq9c5n5xISEDpgCVchP2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_08,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 adultscore=0 mlxlogscore=996 mlxscore=0
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

This reverts commit 32c0869370194ae5ac9f9f501953ef693040f6a1.

The reverted commit was intended to remove a dead check however it was observed
that this check was actually being used to exit early instead of looping
sbi->s_mb_max_to_scan times when we are able to find a free extent bigger than
the goal extent. Due to this, a my performance tests (fsmark, parallel file
writes in a highly fragmented FS) were seeing a 2x-3x regression.

Example, the default value of the following variables is:

sbi->s_mb_max_to_scan = 200
sbi->s_mb_min_to_scan = 10

In ext4_mb_check_limits() if we find an extent smaller than goal, then we return
early and try again. This loop will go on until we have processed
sbi->s_mb_max_to_scan(=200) number of free extents at which point we exit and
just use whatever we have even if it is smaller than goal extent.

Now, the regression comes when we find an extent bigger than goal. Earlier, in
this case we would loop only sbi->s_mb_min_to_scan(=10) times and then just use
the bigger extent. However with commit 32c08693 that check was removed and hence
we would loop sbi->s_mb_max_to_scan(=200) times even though we have a big enough
free extent to satisfy the request. The only time we would exit early would be
when the free extent is *exactly* the size of our goal, which is pretty uncommon
occurrence and so we would almost always end up looping 200 times.

Hence, revert the commit by adding the check back to fix the regression. Also
add a comment to outline this policy.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index d4b6a2c1881d..7ac6d3524f29 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2063,7 +2063,7 @@ static void ext4_mb_check_limits(struct ext4_allocation_context *ac,
 	if (bex->fe_len < gex->fe_len)
 		return;
 
-	if (finish_group)
+	if (finish_group || ac->ac_found > sbi->s_mb_min_to_scan)
 		ext4_mb_use_best_found(ac, e4b);
 }
 
@@ -2075,6 +2075,20 @@ static void ext4_mb_check_limits(struct ext4_allocation_context *ac,
  * in the context. Later, the best found extent will be used, if
  * mballoc can't find good enough extent.
  *
+ * The algorithm used is roughly as follows:
+ *
+ * * If free extent found is exactly as big as goal, then
+ *   stop the scan and use it immediately
+ *
+ * * If free extent found is smaller than goal, then keep retrying
+ *   upto a max of sbi->s_mb_max_to_scan times (default 200). After
+ *   that stop scanning and use whatever we have.
+ *
+ * * If free extent found is bigger than goal, then keep retrying
+ *   upto a max of sbi->s_mb_min_to_scan times (default 10) before
+ *   stopping the scan and using the extent.
+ *
+ *
  * FIXME: real allocation policy is to be designed yet!
  */
 static void ext4_mb_measure_extent(struct ext4_allocation_context *ac,
-- 
2.31.1

