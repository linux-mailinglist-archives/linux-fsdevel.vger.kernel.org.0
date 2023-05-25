Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D292C710AFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 13:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240796AbjEYLdc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 07:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjEYLd3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 07:33:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88A412F;
        Thu, 25 May 2023 04:33:28 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PBCCBu019043;
        Thu, 25 May 2023 11:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7YSNE0XaB12wnQLwuj40MZnYICKAfTn2RoMLDFH90Vg=;
 b=lAtddoqcM/NeGjQvk6SSANEkkj+N9rmLjAqCsGA6LrAKc2P2oJPHOpkCjMK2dBd9vLEh
 uqkbeCs9d1oiuwOeExDInflWfMev9Kir05EiclLMUsAj6UALGgxk9hQtftc/7VcB0VQk
 ZlugFvUzgZhdcHWOJkpm/CexxhZKUT2PXXv/NZzOh/D4WwnjKsVigiE1Qd/IOHi7ioj4
 twDAuIF36sNbnHksrU/L6u/hMvmQmlljHWXN49Icv7mRUnC8Zh1VAgdMxgn6bHKLW0iZ
 QeB2OwYWZ08mmJgUQY2Z8RCiLSDhn2WzoJBF714VT+9RTwxIIWFPAMiEHabLYYzFKdI7 ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qt6kb0gjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:18 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34PBD5Pg021935;
        Thu, 25 May 2023 11:33:17 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qt6kb0ggg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:17 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34P4U8Xk021476;
        Thu, 25 May 2023 11:33:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3qppe09ysc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:15 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34PBXDXr63439224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 May 2023 11:33:13 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E524D2004B;
        Thu, 25 May 2023 11:33:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F07DB20043;
        Thu, 25 May 2023 11:33:10 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 25 May 2023 11:33:10 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH 01/13] Revert "ext4: remove ac->ac_found > sbi->s_mb_min_to_scan dead check in ext4_mb_check_limits"
Date:   Thu, 25 May 2023 17:02:55 +0530
Message-Id: <cd639a08cc9824c927591d9de14049f2461e1923.1685009579.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1685009579.git.ojaswin@linux.ibm.com>
References: <cover.1685009579.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zoLrth61KtZYUg7XNY8MpkZIf7hNVpgV
X-Proofpoint-GUID: wO0Lo-cL5UQuthSRFm5tVrZ3ddMC12eQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_06,2023-05-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=919 spamscore=0
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
---
 fs/ext4/mballoc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9c7881a4ea75..2e1a5f001883 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2062,7 +2062,7 @@ static void ext4_mb_check_limits(struct ext4_allocation_context *ac,
 	if (bex->fe_len < gex->fe_len)
 		return;
 
-	if (finish_group)
+	if (finish_group || ac->ac_found > sbi->s_mb_min_to_scan)
 		ext4_mb_use_best_found(ac, e4b);
 }
 
@@ -2074,6 +2074,20 @@ static void ext4_mb_check_limits(struct ext4_allocation_context *ac,
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

