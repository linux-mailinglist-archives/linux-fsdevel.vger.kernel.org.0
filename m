Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404914AA953
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 15:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380102AbiBEOKr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Feb 2022 09:10:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1380101AbiBEOKq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Feb 2022 09:10:46 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 215DwYpb015218;
        Sat, 5 Feb 2022 14:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jgUOYnoApNWO/7D/f9O8p/0YQ97k7kU6dJA7hGu2TY4=;
 b=YRQAUNdgYEvcYWojYQkj1CiTZFWFVJh4XqvstLFdOMwuQYvzc6iUtwen0kMwH1C4a3Nn
 1qqNNZbpxBCLzSC93s2RSXSWIoQ/CKep7TfWzDBLnlSuwwNX3doT2YPC01HFiItnSTjf
 Rje3SQ5leaoDLnSSATjv43qGXmJDioFnqmqiUGIkhvPdatdcKi35tDylfmO0/QeidzTY
 E7+FQEUNyZ+vPrGB9JVR7VgaJWwBTQzq042cI8dczAyC72L4/Kuy8ApTVC4jeDeGDaZD
 xvOqqkCYHgFVoc33XIdvWskzCUzJo37RoxCkrfdNkE32QmSQq75Np7St4+xe2eGVppnV vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e1hw9xtq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:42 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 215EAgpL027294;
        Sat, 5 Feb 2022 14:10:42 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e1hw9xtpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:41 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 215E3bIf010957;
        Sat, 5 Feb 2022 14:10:40 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3e1gv8j5wt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:40 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 215EAbs247776170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Feb 2022 14:10:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD5C452052;
        Sat,  5 Feb 2022 14:10:37 +0000 (GMT)
Received: from localhost (unknown [9.43.12.205])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BB77252050;
        Sat,  5 Feb 2022 14:10:36 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv1 7/9] ext4: Add ext4_sb_block_valid() refactored out of ext4_inode_block_valid()
Date:   Sat,  5 Feb 2022 19:39:56 +0530
Message-Id: <1c5fae30be49b5116e4e5604e6224b33b778feaf.1644062450.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1644062450.git.riteshh@linux.ibm.com>
References: <cover.1644062450.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rGmoi0aTES3-FNQbaaZDHn8IeIN3RIv1
X-Proofpoint-GUID: HtNOSnJKFu5xbl1HtgK6wu1ZWxyw9K5a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-05_10,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=899
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202050095
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This API will be needed at places where we don't have an inode
for e.g. while freeing blocks in ext4_group_add_blocks()

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/block_validity.c | 25 ++++++++++++++++---------
 fs/ext4/ext4.h           |  3 +++
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 4666b55b736e..a9195d5ac1e7 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -292,15 +292,10 @@ void ext4_release_system_zone(struct super_block *sb)
 		call_rcu(&system_blks->rcu, ext4_destroy_system_zone);
 }
 
-/*
- * Returns 1 if the passed-in block region (start_blk,
- * start_blk+count) is valid; 0 if some part of the block region
- * overlaps with some other filesystem metadata blocks.
- */
-int ext4_inode_block_valid(struct inode *inode, ext4_fsblk_t start_blk,
-			  unsigned int count)
+int ext4_sb_block_valid(struct super_block *sb, struct inode *inode,
+				ext4_fsblk_t start_blk, unsigned int count)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_system_blocks *system_blks;
 	struct ext4_system_zone *entry;
 	struct rb_node *n;
@@ -329,7 +324,8 @@ int ext4_inode_block_valid(struct inode *inode, ext4_fsblk_t start_blk,
 		else if (start_blk >= (entry->start_blk + entry->count))
 			n = n->rb_right;
 		else {
-			ret = (entry->ino == inode->i_ino);
+			if (inode)
+				ret = (entry->ino == inode->i_ino);
 			break;
 		}
 	}
@@ -338,6 +334,17 @@ int ext4_inode_block_valid(struct inode *inode, ext4_fsblk_t start_blk,
 	return ret;
 }
 
+/*
+ * Returns 1 if the passed-in block region (start_blk,
+ * start_blk+count) is valid; 0 if some part of the block region
+ * overlaps with some other filesystem metadata blocks.
+ */
+int ext4_inode_block_valid(struct inode *inode, ext4_fsblk_t start_blk,
+			  unsigned int count)
+{
+	return ext4_sb_block_valid(inode->i_sb, inode, start_blk, count);
+}
+
 int ext4_check_blockref(const char *function, unsigned int line,
 			struct inode *inode, __le32 *p, unsigned int max)
 {
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 8c1d0e352f47..4f7851c1e432 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3706,6 +3706,9 @@ extern int ext4_inode_block_valid(struct inode *inode,
 				  unsigned int count);
 extern int ext4_check_blockref(const char *, unsigned int,
 			       struct inode *, __le32 *, unsigned int);
+extern int ext4_sb_block_valid(struct super_block *sb, struct inode *inode,
+				ext4_fsblk_t start_blk, unsigned int count);
+
 
 /* extents.c */
 struct ext4_ext_path;
-- 
2.31.1

