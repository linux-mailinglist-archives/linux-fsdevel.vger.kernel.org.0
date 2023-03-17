Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0F46BE3FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 09:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCQIkb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 04:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjCQIil (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:38:41 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0856C1AB;
        Fri, 17 Mar 2023 01:38:08 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H6rhIm020277;
        Fri, 17 Mar 2023 08:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HSDS+Qx+SjPNvm1jwTuGxSQbPBt82pI2ogEXSkF/j4Y=;
 b=rzr6eiFpukyYV4hLc9fSeBNE8ptPp/atFcyKUCETOQ+Zgw8UiJQ8eDsbYSIQDi29iZbm
 U8SzULOnaDx+8VMk+ih9xJLcz3LItCqcHoC8LY2PLVlAP6JiWyIzE4EA/TPRS+4DH+qw
 Ztc/VPoQlbGztEqv3g+ypLQtviAzAS3rTfe0ewcaoGlnIdfda992nNiaiFcqn/cVDWXH
 aT/0W2dilt4f2QBWUKJiDF/Vv0vXTj6cxzyigzdSy9h2ukQ3dvo5D72lTKcOFur+1Cde
 b6nbKxbErq4hvCgECE3qkFnm4P7Q19fZju5kGSKTwenNToW1kDG2/1/6EjaBcLoXORlr GA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pcjfhkf1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 08:37:48 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32H7fhUa005878;
        Fri, 17 Mar 2023 08:37:48 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pcjfhkf1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 08:37:47 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32H6Wulb015005;
        Fri, 17 Mar 2023 08:37:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3pbsf3hwac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 08:37:45 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32H8bhDb28967632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 08:37:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79DDC20F72;
        Fri, 17 Mar 2023 08:37:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5884020F6F;
        Fri, 17 Mar 2023 08:37:41 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.91.202])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Mar 2023 08:37:41 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v5 9/9] ext4: Remove the logic to trim inode PAs
Date:   Fri, 17 Mar 2023 14:07:13 +0530
Message-Id: <c5615ef200217c8d3145add2ee01dc6a1737c21b.1679042083.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1679042083.git.ojaswin@linux.ibm.com>
References: <cover.1679042083.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KhD8h4OwYX3pwDnxCHUYdMfFAYO2nq5Y
X-Proofpoint-ORIG-GUID: diH0tfxZsi3-YLSZe5J9I6h0FJ48ex3i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_04,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Earlier, inode PAs were stored in a linked list. This caused a need to
periodically trim the list down inorder to avoid growing it to a very
large size, as this would severly affect performance during list
iteration.

Recent patches changed this list to an rbtree, and since the tree scales
up much better, we no longer need to have the trim functionality, hence
remove it.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 Documentation/admin-guide/ext4.rst |  3 ---
 fs/ext4/ext4.h                     |  1 -
 fs/ext4/mballoc.c                  | 20 --------------------
 fs/ext4/mballoc.h                  |  5 -----
 fs/ext4/sysfs.c                    |  2 --
 5 files changed, 31 deletions(-)

diff --git a/Documentation/admin-guide/ext4.rst b/Documentation/admin-guide/ext4.rst
index 4c559e08d11e..5740d85439ff 100644
--- a/Documentation/admin-guide/ext4.rst
+++ b/Documentation/admin-guide/ext4.rst
@@ -489,9 +489,6 @@ Files in /sys/fs/ext4/<devname>:
         multiple of this tuning parameter if the stripe size is not set in the
         ext4 superblock
 
-  mb_max_inode_prealloc
-        The maximum length of per-inode ext4_prealloc_space list.
-
   mb_max_to_scan
         The maximum number of extents the multiblock allocator will search to
         find the best extent.
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 8cf955b1dca5..993d3284b430 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1613,7 +1613,6 @@ struct ext4_sb_info {
 	unsigned int s_mb_stats;
 	unsigned int s_mb_order2_reqs;
 	unsigned int s_mb_group_prealloc;
-	unsigned int s_mb_max_inode_prealloc;
 	unsigned int s_max_dir_size_kb;
 	/* where last allocation was done - for stream allocation */
 	unsigned long s_mb_last_group;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index f7603dafb672..d5837c5acbc7 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3417,7 +3417,6 @@ int ext4_mb_init(struct super_block *sb)
 	sbi->s_mb_stats = MB_DEFAULT_STATS;
 	sbi->s_mb_stream_request = MB_DEFAULT_STREAM_THRESHOLD;
 	sbi->s_mb_order2_reqs = MB_DEFAULT_ORDER2_REQS;
-	sbi->s_mb_max_inode_prealloc = MB_DEFAULT_MAX_INODE_PREALLOC;
 	/*
 	 * The default group preallocation is 512, which for 4k block
 	 * sizes translates to 2 megabytes.  However for bigalloc file
@@ -5600,29 +5599,11 @@ static void ext4_mb_add_n_trim(struct ext4_allocation_context *ac)
 	return ;
 }
 
-/*
- * if per-inode prealloc list is too long, trim some PA
- */
-static void ext4_mb_trim_inode_pa(struct inode *inode)
-{
-	struct ext4_inode_info *ei = EXT4_I(inode);
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
-	int count, delta;
-
-	count = atomic_read(&ei->i_prealloc_active);
-	delta = (sbi->s_mb_max_inode_prealloc >> 2) + 1;
-	if (count > sbi->s_mb_max_inode_prealloc + delta) {
-		count -= sbi->s_mb_max_inode_prealloc;
-		ext4_discard_preallocations(inode, count);
-	}
-}
-
 /*
  * release all resource we used in allocation
  */
 static int ext4_mb_release_context(struct ext4_allocation_context *ac)
 {
-	struct inode *inode = ac->ac_inode;
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_prealloc_space *pa = ac->ac_pa;
 	if (pa) {
@@ -5658,7 +5639,6 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
 	if (ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC)
 		mutex_unlock(&ac->ac_lg->lg_mutex);
 	ext4_mb_collect_stats(ac);
-	ext4_mb_trim_inode_pa(inode);
 	return 0;
 }
 
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index f8e8ee493867..6d85ee8674a6 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -73,11 +73,6 @@
  */
 #define MB_DEFAULT_GROUP_PREALLOC	512
 
-/*
- * maximum length of inode prealloc list
- */
-#define MB_DEFAULT_MAX_INODE_PREALLOC	512
-
 /*
  * Number of groups to search linearly before performing group scanning
  * optimization.
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 12d6252e3e22..3042bc605bbf 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -214,7 +214,6 @@ EXT4_RW_ATTR_SBI_UI(mb_min_to_scan, s_mb_min_to_scan);
 EXT4_RW_ATTR_SBI_UI(mb_order2_req, s_mb_order2_reqs);
 EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
 EXT4_RW_ATTR_SBI_UI(mb_group_prealloc, s_mb_group_prealloc);
-EXT4_RW_ATTR_SBI_UI(mb_max_inode_prealloc, s_mb_max_inode_prealloc);
 EXT4_RW_ATTR_SBI_UI(mb_max_linear_groups, s_mb_max_linear_groups);
 EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
 EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
@@ -264,7 +263,6 @@ static struct attribute *ext4_attrs[] = {
 	ATTR_LIST(mb_order2_req),
 	ATTR_LIST(mb_stream_req),
 	ATTR_LIST(mb_group_prealloc),
-	ATTR_LIST(mb_max_inode_prealloc),
 	ATTR_LIST(mb_max_linear_groups),
 	ATTR_LIST(max_writeback_mb_bump),
 	ATTR_LIST(extent_max_zeroout_kb),
-- 
2.31.1

