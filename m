Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE6D1C0E1C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 08:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgEAGal (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 02:30:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728126AbgEAGak (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 02:30:40 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04162Xpo078113;
        Fri, 1 May 2020 02:30:36 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30r7mc9gmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 02:30:36 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0416AtK0015132;
        Fri, 1 May 2020 06:30:34 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 30mcu5bae2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 06:30:33 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0416UVJi786768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 May 2020 06:30:31 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB1EAA4065;
        Fri,  1 May 2020 06:30:30 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68F28A405C;
        Fri,  1 May 2020 06:30:29 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.81.13])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 May 2020 06:30:29 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 11/20] ext4: mballoc: Refactor code inside DOUBLE_CHECK into separate function
Date:   Fri,  1 May 2020 11:59:53 +0530
Message-Id: <a54c09e2ad968fd7b65a3f892977b40b27cc7f4f.1588313626.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1588313626.git.riteshh@linux.ibm.com>
References: <cover.1588313626.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-01_01:2020-04-30,2020-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=940
 impostorscore=0 suspectscore=3 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005010040
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
index 4d6effe22652..5e59c18c89c0 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -540,6 +540,26 @@ static void mb_cmp_bitmaps(struct ext4_buddy *e4b, void *bitmap)
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
@@ -555,6 +575,17 @@ static inline void mb_cmp_bitmaps(struct ext4_buddy *e4b, void *bitmap)
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
@@ -2482,20 +2513,7 @@ int ext4_mb_add_groupinfo(struct super_block *sb, ext4_group_t group,
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
@@ -2762,9 +2780,7 @@ int ext4_mb_release(struct super_block *sb)
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

