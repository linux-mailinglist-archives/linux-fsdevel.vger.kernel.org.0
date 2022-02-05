Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679C34AA956
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 15:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380105AbiBEOKy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Feb 2022 09:10:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1380101AbiBEOKt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Feb 2022 09:10:49 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 215B3qEx012245;
        Sat, 5 Feb 2022 14:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DuGudSqE6S8R83bPkCtMC6kcBgA6R9CxDU/Id7eFzog=;
 b=SSxlRjjZyykqP25VqM9i5+QV52dqaRY3DH3mTm7ghVRK6FFY94gIFcQRpy2IEdMEp6ox
 5rw+OC/LK1qwWlYVZO8YeHbFUKTmSo344Z0ZgWW4T2DcsCzwt/kbCcVeFzXp/vjkfzKu
 M5CNFPfJPkd6R+JTx5DAbjb8IbVN7Jm8Zumo0H8M9CgzXHGJpUt0LbnfzyeV2sUGtZKs
 3QsNuPfIIqSQufeO2kQzVF9cemf2QrPqhOhDO0IqgQPlLHEC+0TVW3ShqeqGFZlnGeZx
 7kQSerIPqzOGNT8BFnY6zR2EmLT9ssbWGDBpQZlI6WzbVob24cIii55uZJynRYBmNlrz tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e1hw9xtqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:45 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 215EAj9O027355;
        Sat, 5 Feb 2022 14:10:45 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e1hw9xtqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:44 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 215E3lxj001307;
        Sat, 5 Feb 2022 14:10:43 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3e1gv8t0wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:42 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 215E0gNN49676752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Feb 2022 14:00:42 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41F1CA4059;
        Sat,  5 Feb 2022 14:10:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A6A0A4055;
        Sat,  5 Feb 2022 14:10:39 +0000 (GMT)
Received: from localhost (unknown [9.43.12.205])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  5 Feb 2022 14:10:39 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv1 8/9] ext4: Add strict range checks while freeing blocks
Date:   Sat,  5 Feb 2022 19:39:57 +0530
Message-Id: <7d16dee931f42fa415ffe86fc3968b4b3d7269c8.1644062450.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1644062450.git.riteshh@linux.ibm.com>
References: <cover.1644062450.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FTGdeqo5REIdYiIvzyuamWXGWfW96X0i
X-Proofpoint-GUID: WijiMSnog_80SOflcXKA3eg27YWP0izf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-05_10,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=624
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202050095
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently ext4_mb_clear_bb() & ext4_group_add_blocks() only checks
whether the given block ranges (which is to be freed) belongs to any FS
metadata blocks or not, of the block's respective block group.
But to detect any FS error early, it is better to add more strict
checkings in those functions which checks whether the given blocks
belongs to any critical FS metadata or not within system-zone.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/mballoc.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 23313963bb56..9f2b3a057918 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5930,13 +5930,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 		goto error_return;
 	}
 
-	if (in_range(ext4_block_bitmap(sb, gdp), block, count) ||
-	    in_range(ext4_inode_bitmap(sb, gdp), block, count) ||
-	    in_range(block, ext4_inode_table(sb, gdp),
-		     sbi->s_itb_per_group) ||
-	    in_range(block + count - 1, ext4_inode_table(sb, gdp),
-		     sbi->s_itb_per_group)) {
-
+	if (!ext4_inode_block_valid(inode, block, count)) {
 		ext4_error(sb, "Freeing blocks in system zone - "
 			   "Block = %llu, count = %lu", block, count);
 		/* err = 0. ext4_std_error should be a no op */
@@ -6007,7 +6001,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 						 NULL);
 			if (err && err != -EOPNOTSUPP)
 				ext4_msg(sb, KERN_WARNING, "discard request in"
-					 " group:%d block:%d count:%lu failed"
+					 " group:%u block:%d count:%lu failed"
 					 " with %d", block_group, bit, count,
 					 err);
 		} else
@@ -6220,11 +6214,7 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
 		goto error_return;
 	}
 
-	if (in_range(ext4_block_bitmap(sb, desc), block, count) ||
-	    in_range(ext4_inode_bitmap(sb, desc), block, count) ||
-	    in_range(block, ext4_inode_table(sb, desc), sbi->s_itb_per_group) ||
-	    in_range(block + count - 1, ext4_inode_table(sb, desc),
-		     sbi->s_itb_per_group)) {
+	if (!ext4_sb_block_valid(sb, NULL, block, count)) {
 		ext4_error(sb, "Adding blocks in system zones - "
 			   "Block = %llu, count = %lu",
 			   block, count);
-- 
2.31.1

