Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F021CC73A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 08:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgEJGZo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 02:25:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbgEJGZn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 02:25:43 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04A62eNk007530;
        Sun, 10 May 2020 02:25:39 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30ws2dbyd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 02:25:39 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04A6K01S022770;
        Sun, 10 May 2020 06:25:37 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 30wm558tep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 06:25:37 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04A6ONDh62521772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 May 2020 06:24:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3290342047;
        Sun, 10 May 2020 06:25:34 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 897AF4203F;
        Sun, 10 May 2020 06:25:32 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.61.127])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 10 May 2020 06:25:32 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 08/16] ext4: mballoc: Refactor code inside DOUBLE_CHECK into separate function
Date:   Sun, 10 May 2020 11:54:48 +0530
Message-Id: <8c2095d74b779f0254a19b24982490dc6f07c4f9.1589086800.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1589086800.git.riteshh@linux.ibm.com>
References: <cover.1589086800.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-10_01:2020-05-08,2020-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=3
 mlxlogscore=940 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005100050
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch implemets mb_group_bb_bitmap_alloc() and
mb_group_bb_bitmap_free() function to remove #ifdef DOUBLE_CHECK macro
and it's related code from inside
ext4_mb_add_groupinfo()/ext4_mb_release().

There should be no functionality change in this patch.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/mballoc.c | 50 +++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 262a53f1d283..3555e72f149c 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -511,6 +511,26 @@ static void mb_cmp_bitmaps(struct ext4_buddy *e4b, void *bitmap)
 	}
 }
 
+static void mb_group_bb_bitmap_alloc(struct super_block *sb,
+			struct ext4_group_info *grp, ext4_group_t group)
+{
+	struct buffer_head *bh;
+
+	grp->bb_bitmap = kmalloc(sb->s_blocksize, GFP_NOFS);
+	BUG_ON(grp->bb_bitmap == NULL);
+
+	bh = ext4_read_block_bitmap(sb, group);
+	BUG_ON(IS_ERR_OR_NULL(bh));
+
+	memcpy(grp->bb_bitmap, bh->b_data, sb->s_blocksize);
+	put_bh(bh);
+}
+
+static void mb_group_bb_bitmap_free(struct ext4_group_info *grp)
+{
+	kfree(grp->bb_bitmap);
+}
+
 #else
 static inline void mb_free_blocks_double(struct inode *inode,
 				struct ext4_buddy *e4b, int first, int count)
@@ -526,6 +546,17 @@ static inline void mb_cmp_bitmaps(struct ext4_buddy *e4b, void *bitmap)
 {
 	return;
 }
+
+static inline void mb_group_bb_bitmap_alloc(struct super_block *sb,
+			struct ext4_group_info *grp, ext4_group_t group)
+{
+	return;
+}
+
+static inline void mb_group_bb_bitmap_free(struct ext4_group_info *grp)
+{
+	return;
+}
 #endif
 
 #ifdef AGGRESSIVE_CHECK
@@ -2456,20 +2487,7 @@ int ext4_mb_add_groupinfo(struct super_block *sb, ext4_group_t group,
 	meta_group_info[i]->bb_free_root = RB_ROOT;
 	meta_group_info[i]->bb_largest_free_order = -1;  /* uninit */
 
-#ifdef DOUBLE_CHECK
-	{
-		struct buffer_head *bh;
-		meta_group_info[i]->bb_bitmap =
-			kmalloc(sb->s_blocksize, GFP_NOFS);
-		BUG_ON(meta_group_info[i]->bb_bitmap == NULL);
-		bh = ext4_read_block_bitmap(sb, group);
-		BUG_ON(IS_ERR_OR_NULL(bh));
-		memcpy(meta_group_info[i]->bb_bitmap, bh->b_data,
-			sb->s_blocksize);
-		put_bh(bh);
-	}
-#endif
-
+	mb_group_bb_bitmap_alloc(sb, meta_group_info[i], group);
 	return 0;
 
 exit_group_info:
@@ -2736,9 +2754,7 @@ int ext4_mb_release(struct super_block *sb)
 		for (i = 0; i < ngroups; i++) {
 			cond_resched();
 			grinfo = ext4_get_group_info(sb, i);
-#ifdef DOUBLE_CHECK
-			kfree(grinfo->bb_bitmap);
-#endif
+			mb_group_bb_bitmap_free(grinfo);
 			ext4_lock_group(sb, i);
 			ext4_mb_cleanup_pa(grinfo);
 			ext4_unlock_group(sb, i);
-- 
2.21.0

