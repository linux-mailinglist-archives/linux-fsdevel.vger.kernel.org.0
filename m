Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5C64B8189
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 08:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiBPH25 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 02:28:57 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiBPH24 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:28:56 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B2415A3D;
        Tue, 15 Feb 2022 23:28:44 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21G6kj88025963;
        Wed, 16 Feb 2022 07:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=J8e7vLR+x5aOYIOMQQQr6N+RLGfSJeiaz45/gwORjRo=;
 b=M6kjWzbFmwnQ2fhGvDk2cX5HCnJq7U7RuY6O8WgJ0dH268V3WTuC17YMQNNv2EGClwia
 tNDeg4++CoBRvA0gyTzm8FgxemFh9W+l4BBojl/P8vRMqU+QPify3nsAWsLRrKgVPCfv
 3rgX1JujOOoZAowcaj3lKhxSoJoI4EzKQyDQt6+3T3uCyF4zsmTprIdWEyq3rtswvNpI
 u51UyRifuYDYE5Rh5tfSIFLWRFP+a3QzQXQ5uLE8GCkgYFt6oCVCRPprY3vSHyUSHZgk
 W7jZryUFAY9iAeWIyX5qxULvo0bdEow9OzRSN6Xg1T7zNsh7PWDYJUk8V/ETXYP449vB JA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e8va4g98m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 07:03:06 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21G71t4t013016;
        Wed, 16 Feb 2022 07:03:06 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e8va4g97q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 07:03:05 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21G72bsw021823;
        Wed, 16 Feb 2022 07:03:04 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3e64h9v19a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 07:03:04 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21G7311x31195530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 07:03:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAAAEA405C;
        Wed, 16 Feb 2022 07:03:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 529EFA405B;
        Wed, 16 Feb 2022 07:03:01 +0000 (GMT)
Received: from localhost (unknown [9.43.85.173])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Feb 2022 07:03:01 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 3/9] ext4: Refactor ext4_free_blocks() to pull out ext4_mb_clear_bb()
Date:   Wed, 16 Feb 2022 12:32:45 +0530
Message-Id: <22c30fbb26ba409cf8aa5f0c7912970272c459e8.1644992610.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1644992609.git.riteshh@linux.ibm.com>
References: <cover.1644992609.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dOy8XWFc2Rt22eWzrQwi8lYZiZIguy6w
X-Proofpoint-ORIG-GUID: pOwrNQevF3gwxN7j8qo654j4bwDnVVRN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_02,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=794 phishscore=0 lowpriorityscore=0
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

ext4_free_blocks() function became too long and confusing, this patch
just pulls out the ext4_mb_clear_bb() function logic from it
which clears the block bitmap and frees it.

No functionality change in this patch

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 180 ++++++++++++++++++++++++++--------------------
 1 file changed, 102 insertions(+), 78 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 816322eddd2b..7b80c5dd9f40 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5872,7 +5872,8 @@ static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
 }
 
 /**
- * ext4_free_blocks() -- Free given blocks and update quota
+ * ext4_mb_clear_bb() -- helper function for freeing blocks.
+ *			Used by ext4_free_blocks()
  * @handle:		handle for this transaction
  * @inode:		inode
  * @bh:			optional buffer of the block to be freed
@@ -5880,9 +5881,9 @@ static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
  * @count:		number of blocks to be freed
  * @flags:		flags used by ext4_free_blocks
  */
-void ext4_free_blocks(handle_t *handle, struct inode *inode,
-		      struct buffer_head *bh, ext4_fsblk_t block,
-		      unsigned long count, int flags)
+static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
+			       ext4_fsblk_t block, unsigned long count,
+			       int flags)
 {
 	struct buffer_head *bitmap_bh = NULL;
 	struct super_block *sb = inode->i_sb;
@@ -5899,80 +5900,6 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 
 	sbi = EXT4_SB(sb);
 
-	if (sbi->s_mount_state & EXT4_FC_REPLAY) {
-		ext4_free_blocks_simple(inode, block, count);
-		return;
-	}
-
-	might_sleep();
-	if (bh) {
-		if (block)
-			BUG_ON(block != bh->b_blocknr);
-		else
-			block = bh->b_blocknr;
-	}
-
-	if (!(flags & EXT4_FREE_BLOCKS_VALIDATED) &&
-	    !ext4_inode_block_valid(inode, block, count)) {
-		ext4_error(sb, "Freeing blocks not in datazone - "
-			   "block = %llu, count = %lu", block, count);
-		goto error_return;
-	}
-
-	ext4_debug("freeing block %llu\n", block);
-	trace_ext4_free_blocks(inode, block, count, flags);
-
-	if (bh && (flags & EXT4_FREE_BLOCKS_FORGET)) {
-		BUG_ON(count > 1);
-
-		ext4_forget(handle, flags & EXT4_FREE_BLOCKS_METADATA,
-			    inode, bh, block);
-	}
-
-	/*
-	 * If the extent to be freed does not begin on a cluster
-	 * boundary, we need to deal with partial clusters at the
-	 * beginning and end of the extent.  Normally we will free
-	 * blocks at the beginning or the end unless we are explicitly
-	 * requested to avoid doing so.
-	 */
-	overflow = EXT4_PBLK_COFF(sbi, block);
-	if (overflow) {
-		if (flags & EXT4_FREE_BLOCKS_NOFREE_FIRST_CLUSTER) {
-			overflow = sbi->s_cluster_ratio - overflow;
-			block += overflow;
-			if (count > overflow)
-				count -= overflow;
-			else
-				return;
-		} else {
-			block -= overflow;
-			count += overflow;
-		}
-	}
-	overflow = EXT4_LBLK_COFF(sbi, count);
-	if (overflow) {
-		if (flags & EXT4_FREE_BLOCKS_NOFREE_LAST_CLUSTER) {
-			if (count > overflow)
-				count -= overflow;
-			else
-				return;
-		} else
-			count += sbi->s_cluster_ratio - overflow;
-	}
-
-	if (!bh && (flags & EXT4_FREE_BLOCKS_FORGET)) {
-		int i;
-		int is_metadata = flags & EXT4_FREE_BLOCKS_METADATA;
-
-		for (i = 0; i < count; i++) {
-			cond_resched();
-			if (is_metadata)
-				bh = sb_find_get_block(inode->i_sb, block + i);
-			ext4_forget(handle, is_metadata, inode, bh, block + i);
-		}
-	}
-
 do_more:
 	overflow = 0;
 	ext4_get_group_no_and_offset(sb, block, &block_group, &bit);
@@ -6140,6 +6067,103 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 	return;
 }
 
+/**
+ * ext4_free_blocks() -- Free given blocks and update quota
+ * @handle:		handle for this transaction
+ * @inode:		inode
+ * @bh:			optional buffer of the block to be freed
+ * @block:		starting physical block to be freed
+ * @count:		number of blocks to be freed
+ * @flags:		flags used by ext4_free_blocks
+ */
+void ext4_free_blocks(handle_t *handle, struct inode *inode,
+		      struct buffer_head *bh, ext4_fsblk_t block,
+		      unsigned long count, int flags)
+{
+	struct super_block *sb = inode->i_sb;
+	unsigned int overflow;
+	struct ext4_sb_info *sbi;
+
+	sbi = EXT4_SB(sb);
+
+	if (sbi->s_mount_state & EXT4_FC_REPLAY) {
+		ext4_free_blocks_simple(inode, block, count);
+		return;
+	}
+
+	might_sleep();
+	if (bh) {
+		if (block)
+			BUG_ON(block != bh->b_blocknr);
+		else
+			block = bh->b_blocknr;
+	}
+
+	if (!(flags & EXT4_FREE_BLOCKS_VALIDATED) &&
+	    !ext4_inode_block_valid(inode, block, count)) {
+		ext4_error(sb, "Freeing blocks not in datazone - "
+			   "block = %llu, count = %lu", block, count);
+		return;
+	}
+
+	ext4_debug("freeing block %llu\n", block);
+	trace_ext4_free_blocks(inode, block, count, flags);
+
+	if (bh && (flags & EXT4_FREE_BLOCKS_FORGET)) {
+		BUG_ON(count > 1);
+
+		ext4_forget(handle, flags & EXT4_FREE_BLOCKS_METADATA,
+			    inode, bh, block);
+	}
+
+	/*
+	 * If the extent to be freed does not begin on a cluster
+	 * boundary, we need to deal with partial clusters at the
+	 * beginning and end of the extent.  Normally we will free
+	 * blocks at the beginning or the end unless we are explicitly
+	 * requested to avoid doing so.
+	 */
+	overflow = EXT4_PBLK_COFF(sbi, block);
+	if (overflow) {
+		if (flags & EXT4_FREE_BLOCKS_NOFREE_FIRST_CLUSTER) {
+			overflow = sbi->s_cluster_ratio - overflow;
+			block += overflow;
+			if (count > overflow)
+				count -= overflow;
+			else
+				return;
+		} else {
+			block -= overflow;
+			count += overflow;
+		}
+	}
+	overflow = EXT4_LBLK_COFF(sbi, count);
+	if (overflow) {
+		if (flags & EXT4_FREE_BLOCKS_NOFREE_LAST_CLUSTER) {
+			if (count > overflow)
+				count -= overflow;
+			else
+				return;
+		} else
+			count += sbi->s_cluster_ratio - overflow;
+	}
+
+	if (!bh && (flags & EXT4_FREE_BLOCKS_FORGET)) {
+		int i;
+		int is_metadata = flags & EXT4_FREE_BLOCKS_METADATA;
+
+		for (i = 0; i < count; i++) {
+			cond_resched();
+			if (is_metadata)
+				bh = sb_find_get_block(inode->i_sb, block + i);
+			ext4_forget(handle, is_metadata, inode, bh, block + i);
+		}
+	}
+
+	ext4_mb_clear_bb(handle, inode, block, count, flags);
+	return;
+}
+
 /**
  * ext4_group_add_blocks() -- Add given blocks to an existing group
  * @handle:			handle to this transaction
-- 
2.31.1

