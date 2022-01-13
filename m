Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BEF48D0E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 04:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiAMD1D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 22:27:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8650 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232064AbiAMD0y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 22:26:54 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20D2rtKw031844;
        Thu, 13 Jan 2022 03:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=So5zsErXFfIz2qcy42dL31E8n2hfsDHOp76u8qE6AnI=;
 b=g4+Rq5+5LZT5gC0T3DEmHgmuP5oP0lIzY9DPv2yYxnfeJbr0Cz7Z3UES+vNikNX4mqUk
 qDF2qvdj6e/GI+RGxEVnvEV55Ivh73mqqYYTYZeR3e3QdYo1yL8yPPq1ctUex0Xd3jNF
 HYNWLXiUTXy3zlzKCLSJagpT3isjrDpt6oLec5t+fuUYq6oonQgnptx20525PLQwuYQ9
 VcvwlhKnXVTG8fyrmR95/ED56tFQ39sqEKmlyCu2FB7GkZgIquLM/WmK2rZziuDveQ27
 ex0eM3cV7gj7mxOeDtyyrcmsB3uwTRmrb23X2M2jQKhLCzfwdOMcO9YBLRPxttd6FnWm Og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3djbprrd3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 03:26:46 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20D3QBEx015446;
        Thu, 13 Jan 2022 03:26:46 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3djbprrd39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 03:26:45 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20D3D6hY008473;
        Thu, 13 Jan 2022 03:26:43 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3df289pt07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 03:26:43 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20D3QenM37290242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 03:26:40 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAB3AA4040;
        Thu, 13 Jan 2022 03:26:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A561A4055;
        Thu, 13 Jan 2022 03:26:40 +0000 (GMT)
Received: from localhost (unknown [9.43.54.234])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jan 2022 03:26:40 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, tytso@mit.edu,
        Eric Whitney <enwlinux@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        luo penghao <luo.penghao@zte.com.cn>,
        Lukas Czerner <lczerner@redhat.com>
Subject: [PATCH 3/6] ext4: Fix error handling in ext4_fc_record_modified_inode()
Date:   Thu, 13 Jan 2022 08:56:26 +0530
Message-Id: <4b779e7ac657f94f8680a8944bff191f7474db5b.1642044249.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642044249.git.riteshh@linux.ibm.com>
References: <cover.1642044249.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: l2QlaYEOTSmum5V1JbTsGMVSXdbkURye
X-Proofpoint-GUID: vuBysyb28ePs_jjF8rpKe0pPNnpEseB_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-12_08,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 adultscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201130013
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Current code does not fully takes care of krealloc() error case,
which could lead to silent memory corruption or a kernel bug.
This patch fixes that.

Also it cleans up some duplicated error handling logic from various functions
in fast_commit.c file.

Reported-by: luo penghao <luo.penghao@zte.com.cn>
Suggested-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/fast_commit.c | 64 ++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 35 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 5ae8026a0c56..4541c8468c01 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1392,14 +1392,15 @@ static int ext4_fc_record_modified_inode(struct super_block *sb, int ino)
 		if (state->fc_modified_inodes[i] == ino)
 			return 0;
 	if (state->fc_modified_inodes_used == state->fc_modified_inodes_size) {
-		state->fc_modified_inodes_size +=
-			EXT4_FC_REPLAY_REALLOC_INCREMENT;
 		state->fc_modified_inodes = krealloc(
-					state->fc_modified_inodes, sizeof(int) *
-					state->fc_modified_inodes_size,
-					GFP_KERNEL);
+				state->fc_modified_inodes,
+				sizeof(int) * (state->fc_modified_inodes_size +
+				EXT4_FC_REPLAY_REALLOC_INCREMENT),
+				GFP_KERNEL);
 		if (!state->fc_modified_inodes)
 			return -ENOMEM;
+		state->fc_modified_inodes_size +=
+			EXT4_FC_REPLAY_REALLOC_INCREMENT;
 	}
 	state->fc_modified_inodes[state->fc_modified_inodes_used++] = ino;
 	return 0;
@@ -1431,7 +1432,9 @@ static int ext4_fc_replay_inode(struct super_block *sb, struct ext4_fc_tl *tl,
 	}
 	inode = NULL;
 
-	ext4_fc_record_modified_inode(sb, ino);
+	ret = ext4_fc_record_modified_inode(sb, ino);
+	if (ret)
+		goto out;
 
 	raw_fc_inode = (struct ext4_inode *)
 		(val + offsetof(struct ext4_fc_inode, fc_raw_inode));
@@ -1621,6 +1624,8 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 	}
 
 	ret = ext4_fc_record_modified_inode(sb, inode->i_ino);
+	if (ret)
+		goto out;
 
 	start = le32_to_cpu(ex->ee_block);
 	start_pblk = ext4_ext_pblock(ex);
@@ -1638,18 +1643,14 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 		map.m_pblk = 0;
 		ret = ext4_map_blocks(NULL, inode, &map, 0);
 
-		if (ret < 0) {
-			iput(inode);
-			return 0;
-		}
+		if (ret < 0)
+			goto out;
 
 		if (ret == 0) {
 			/* Range is not mapped */
 			path = ext4_find_extent(inode, cur, NULL, 0);
-			if (IS_ERR(path)) {
-				iput(inode);
-				return 0;
-			}
+			if (IS_ERR(path))
+				goto out;
 			memset(&newex, 0, sizeof(newex));
 			newex.ee_block = cpu_to_le32(cur);
 			ext4_ext_store_pblock(
@@ -1663,10 +1664,8 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 			up_write((&EXT4_I(inode)->i_data_sem));
 			ext4_ext_drop_refs(path);
 			kfree(path);
-			if (ret) {
-				iput(inode);
-				return 0;
-			}
+			if (ret)
+				goto out;
 			goto next;
 		}
 
@@ -1679,10 +1678,8 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 			ret = ext4_ext_replay_update_ex(inode, cur, map.m_len,
 					ext4_ext_is_unwritten(ex),
 					start_pblk + cur - start);
-			if (ret) {
-				iput(inode);
-				return 0;
-			}
+			if (ret)
+				goto out;
 			/*
 			 * Mark the old blocks as free since they aren't used
 			 * anymore. We maintain an array of all the modified
@@ -1702,10 +1699,8 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 			ext4_ext_is_unwritten(ex), map.m_pblk);
 		ret = ext4_ext_replay_update_ex(inode, cur, map.m_len,
 					ext4_ext_is_unwritten(ex), map.m_pblk);
-		if (ret) {
-			iput(inode);
-			return 0;
-		}
+		if (ret)
+			goto out;
 		/*
 		 * We may have split the extent tree while toggling the state.
 		 * Try to shrink the extent tree now.
@@ -1717,6 +1712,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 	}
 	ext4_ext_replay_shrink_inode(inode, i_size_read(inode) >>
 					sb->s_blocksize_bits);
+out:
 	iput(inode);
 	return 0;
 }
@@ -1746,6 +1742,8 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl,
 	}
 
 	ret = ext4_fc_record_modified_inode(sb, inode->i_ino);
+	if (ret)
+		goto out;
 
 	jbd_debug(1, "DEL_RANGE, inode %ld, lblk %d, len %d\n",
 			inode->i_ino, le32_to_cpu(lrange.fc_lblk),
@@ -1755,10 +1753,8 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl,
 		map.m_len = remaining;
 
 		ret = ext4_map_blocks(NULL, inode, &map, 0);
-		if (ret < 0) {
-			iput(inode);
-			return 0;
-		}
+		if (ret < 0)
+			goto out;
 		if (ret > 0) {
 			remaining -= ret;
 			cur += ret;
@@ -1773,15 +1769,13 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl,
 	ret = ext4_ext_remove_space(inode, lrange.fc_lblk,
 				lrange.fc_lblk + lrange.fc_len - 1);
 	up_write(&EXT4_I(inode)->i_data_sem);
-	if (ret) {
-		iput(inode);
-		return 0;
-	}
+	if (ret)
+		goto out;
 	ext4_ext_replay_shrink_inode(inode,
 		i_size_read(inode) >> sb->s_blocksize_bits);
 	ext4_mark_inode_dirty(NULL, inode);
+out:
 	iput(inode);
-
 	return 0;
 }
 
-- 
2.31.1

