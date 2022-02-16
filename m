Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5B94B8231
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 08:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiBPHtx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 02:49:53 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiBPHtw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:49:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DAC305;
        Tue, 15 Feb 2022 23:49:40 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21G69Cn0027786;
        Wed, 16 Feb 2022 07:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HObx5w/gi9lmLjsoTSt6Ac4sTLbXkAYMw1Z1rqqvGPU=;
 b=oBtPyXcW5ZYACGGjHTxUM9d7lBOKuHqcWKwgq5Kqvl5VFtYyDsJ/OMO2ZpP8gI7DP8FU
 D7Q6rE0A2EvzLiEpkXlovcTZxW3vg+0EJkoI7RDmROpZhh0daFrNGXQiFo/LQlTaoI8P
 5JUL9UuppVnYGwPnCxzyCK+/q/xvAa6A/6RD3Xd5qxbxSE661/0tSxlILN4SRtVACKuL
 dtbzj7dVKO24qGBzfUjOyGmj6ZMMhWyE3gS71Dc2E4Ii9XwCJfRbCvzLE27/oFj7hKaW
 wBbtoj9L0/LVt99UPlOBtdzkDLTwKoVdE0tKByCuVxYvQLa56HgOA6lzaIYO7Z1lTJAU Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e8udmh6sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 07:03:17 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21G6LH0f004196;
        Wed, 16 Feb 2022 07:03:17 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e8udmh6rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 07:03:16 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21G72lpn004570;
        Wed, 16 Feb 2022 07:03:14 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3e64ha5hd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 07:03:14 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21G73C8Q43123080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 07:03:12 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B6865205A;
        Wed, 16 Feb 2022 07:03:12 +0000 (GMT)
Received: from localhost (unknown [9.43.85.173])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B113552059;
        Wed, 16 Feb 2022 07:03:11 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 9/9] ext4: Add extra check in ext4_mb_mark_bb() to prevent against possible corruption
Date:   Wed, 16 Feb 2022 12:32:51 +0530
Message-Id: <53cbb6f2573db162a57f935365050d8b1df202ee.1644992610.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1644992609.git.riteshh@linux.ibm.com>
References: <cover.1644992609.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fCKu7Rfk1ad2HiSzXBh2lFLeatT9Mm3z
X-Proofpoint-GUID: ff-8BKh-ohjSAGWbAlu6bsJEaNjkOgtG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_02,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 phishscore=0 impostorscore=0 spamscore=0 mlxlogscore=608 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202160038
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds an extra checks in ext4_mb_mark_bb() function
to make sure we mark & report error if we were to mark/clear any
of the critical FS metadata specific bitmaps (&bail out) to prevent
from any accidental corruption.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 0a95bdb1e07b..5f0bc6d0aabe 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3918,6 +3918,14 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 			EXT4_BLOCKS_PER_GROUP(sb) - EXT4_C2B(sbi, blkoff));
 		clen = EXT4_NUM_B2C(sbi, thisgrp_len);
 
+		if (!ext4_sb_block_valid(sb, NULL, block, thisgrp_len)) {
+			ext4_error(sb, "Marking blocks in system zone - "
+				   "Block = %llu, len = %u",
+				   block, thisgrp_len);
+			bitmap_bh = NULL;
+			break;
+		}
+
 		bitmap_bh = ext4_read_block_bitmap(sb, group);
 		if (IS_ERR(bitmap_bh)) {
 			err = PTR_ERR(bitmap_bh);
-- 
2.31.1

