Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E076BE3DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 09:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjCQIim (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 04:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjCQIiQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:38:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0158E20C9;
        Fri, 17 Mar 2023 01:37:47 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H8MlT6008822;
        Fri, 17 Mar 2023 08:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Ce8f9KNGW5979wm/oVAOBIBZYIcLX/tzeGhMWRBko+8=;
 b=hEYZfTUAzDKlEG1AjYh+KD1IW52pVcNrxjKn19h6VQGxh27ghrrDLbhkkXodUPCpDnSO
 TzykaChrp14Nfwwwxua06+GOv6ktxjJoh4BV07SQGCZFCOiLmuF9l3ssxZHRF2YnMP1M
 d3TKrzXlgRHZE86XEHDHK9SRsRinOUEyawDgjyRQ57QlaAPIX31ce1Hbb3sp63lOeu9t
 DxJAZcc5NWwZQWo85gaDnKdXfKDIr8YjuPDTuVox/tF//p4AE4W4ZQk81RdrUnpjRe6i
 wwffuRIs1jc2YkJben83mgMJgUB5da6DEEv8MHqj6UFOLFrRQY5FPdnyY6Qr+nZ2+o4s NA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pcmn30abv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 08:37:27 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32H8PDg3020722;
        Fri, 17 Mar 2023 08:37:27 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pcmn30ab7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 08:37:27 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32GHsOSq007768;
        Fri, 17 Mar 2023 08:37:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3pbsu7hhbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 08:37:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32H8bMFn44499416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 08:37:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59E4A20F63;
        Fri, 17 Mar 2023 08:37:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D133220F51;
        Fri, 17 Mar 2023 08:37:19 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.91.202])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Mar 2023 08:37:19 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v5 1/9] ext4: Stop searching if PA doesn't satisfy non-extent file
Date:   Fri, 17 Mar 2023 14:07:05 +0530
Message-Id: <22bfc4e3494ceb700ff324f8ff821d6cff5490f7.1679042083.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1679042083.git.ojaswin@linux.ibm.com>
References: <cover.1679042083.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v-dTGKP7fa9lnaxC39___aAY4Q7O4DK7
X-Proofpoint-ORIG-GUID: TiRj6Mym3x9OIV42E1F7CwSnky2QP-bJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_04,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 adultscore=0 mlxscore=0 clxscore=1015 phishscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=973 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303170057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we come across a PA that matches the logical offset but is unable to
satisfy a non-extent file due to its physical start being higher than
that supported by non extent files, then simply stop searching for
another PA and break out of loop. This is because, since PAs don't
overlap, we won't be able to find another inode PA which can satisfy the
original request.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 63a68cee36c6..ed58cefed7fa 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4379,8 +4379,13 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 		/* non-extent files can't have physical blocks past 2^32 */
 		if (!(ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS)) &&
 		    (pa->pa_pstart + EXT4_C2B(sbi, pa->pa_len) >
-		     EXT4_MAX_BLOCK_FILE_PHYS))
-			continue;
+		     EXT4_MAX_BLOCK_FILE_PHYS)) {
+			/*
+			 * Since PAs don't overlap, we won't find any
+			 * other PA to satisfy this.
+			 */
+			break;
+		}
 
 		/* found preallocated blocks, use them */
 		spin_lock(&pa->pa_lock);
-- 
2.31.1

