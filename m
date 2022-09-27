Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062E45EBE54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 11:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiI0JUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 05:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiI0JT4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:19:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A2BD33CF;
        Tue, 27 Sep 2022 02:18:52 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28R8Noui032801;
        Tue, 27 Sep 2022 09:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=3T8n4DAzpX8976dEkrHYHNj0usjR1dSkjNzRQWeQKjk=;
 b=gRadkLVPYVRIZEtrGmRmQ5poktXRMLx7ZLeg5f84EBrn8jHJNUOQnrDTxEaPNMyJwuGJ
 eAyNbwxrV9Vk6mArVSgJgGs1Ma3ilbWqr+DZyusDfzpxI4r+tB47JFVU7Pvh0MCIkTjy
 jIsX3P7FK1XPTpdCxHOd5NYu18AeEeo8+wTWNsmvNsVRhHYeTQS4fEL6qcIpnCW4CH4d
 y2iGHJDiZ92knZrxsZ2qltnqgNWJB5PPjyge/q9MografJWWcedozpGOh1AMmKvViB9N
 q0XwPwpc1tv9DPJyH+9/XLazUnQUER/cLkUzgIKdz2J7FiXa/BXKkgv8b+E53P65g2jo 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3juwmmsry5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 09:18:27 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28R8PGsW038989;
        Tue, 27 Sep 2022 09:18:26 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3juwmmsrx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 09:18:26 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28R95UB3008880;
        Tue, 27 Sep 2022 09:18:24 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3juapuh8tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 09:18:23 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28R9Insp32768326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 09:18:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A966C42041;
        Tue, 27 Sep 2022 09:18:21 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FC2C4203F;
        Tue, 27 Sep 2022 09:18:19 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.61.44])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Sep 2022 09:18:18 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC v3 1/8] ext4: Stop searching if PA doesn't satisfy non-extent file
Date:   Tue, 27 Sep 2022 14:46:41 +0530
Message-Id: <113e30014fdcf409680e20ec1ef4455ace33884d.1664269665.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1664269665.git.ojaswin@linux.ibm.com>
References: <cover.1664269665.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pyBo8hJ_sehz19seRojpMZCKujjzUPXS
X-Proofpoint-ORIG-GUID: DUPyLToIthNE97Yc6NeHZbFYflEEOqNh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_02,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 mlxscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 mlxlogscore=950 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209270053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
---
 fs/ext4/mballoc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 71f5b67d7f28..2e3eb632a216 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4383,8 +4383,13 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
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

