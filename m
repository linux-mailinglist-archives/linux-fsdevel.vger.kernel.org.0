Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C33B816875B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 20:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgBUTUt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 14:20:49 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:26340 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729397AbgBUTUt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 14:20:49 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LJIq6n013505
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2020 11:20:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=oSUqE3CPa7fT0s8lzoQooeoYfSz0kynevewb7clFdNY=;
 b=TavbpvOLHjAAi5v63YCL5mVcfJSUIJlyTMF9Rvnss1uIW7KLsXapaaToMGnxoKQd+pNu
 CxVfeyEcUvIn4MGN/KpmrUisCTbkKHiFKYk3OG4cx1RNeOFa1j+EI45C0eFtdd6V8F63
 +0jnMzRGtNQtDK9dgK610Njv2nEK/Bs3LhQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yam6a0dqa-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2020 11:20:47 -0800
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 21 Feb 2020 11:20:44 -0800
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 4F35E240CB8E1; Fri, 21 Feb 2020 11:20:43 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Roman Gushchin <guro@fb.com>,
        Andrew Perepechko <andrew.perepechko@seagate.com>,
        Theodore Ts'o <tytso@mit.edu>, Gioh Kim <gioh.kim@lge.com>,
        Jan Kara <jack@suse.cz>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH] ext4: use non-movable memory for superblock readahead
Date:   Fri, 21 Feb 2020 11:20:35 -0800
Message-ID: <20200221192035.180546-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_06:2020-02-21,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=829 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210147
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since commit a8ac900b8163 ("ext4: use non-movable memory for the
superblock") buffers for ext4 superblock were allocated using
the sb_bread_unmovable() helper which allocated buffer heads
out of non-movable memory blocks. It was necessarily to not block
page migrations and do not cause cma allocation failures.

However commit 85c8f176a611 ("ext4: preload block group descriptors")
broke this by introducing pre-reading of the ext4 superblock.
The problem is that __breadahead() is using __getblk() underneath,
which allocates buffer heads out of movable memory.

It resulted in page migration failures I've seen on a machine
with an ext4 partition and a preallocated cma area.

Fix this by introducing sb_breadahead_unmovable() and
__breadahead_gfp() helpers which use non-movable memory for buffer
head allocations and use them for the ext4 superblock readahead.

Fixes: 85c8f176a611 ("ext4: preload block group descriptors")
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Andrew Perepechko <andrew.perepechko@seagate.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Gioh Kim <gioh.kim@lge.com>
Cc: Jan Kara <jack@suse.cz>
---
 fs/buffer.c                 | 11 +++++++++++
 fs/ext4/super.c             |  2 +-
 include/linux/buffer_head.h |  8 ++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 4299e100a05b..25462edd920e 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1414,6 +1414,17 @@ void __breadahead(struct block_device *bdev, sector_t block, unsigned size)
 }
 EXPORT_SYMBOL(__breadahead);
 
+void __breadahead_gfp(struct block_device *bdev, sector_t block, unsigned size,
+		      gfp_t gfp)
+{
+	struct buffer_head *bh = __getblk_gfp(bdev, block, size, gfp);
+	if (likely(bh)) {
+		ll_rw_block(REQ_OP_READ, REQ_RAHEAD, 1, &bh);
+		brelse(bh);
+	}
+}
+EXPORT_SYMBOL(__breadahead_gfp);
+
 /**
  *  __bread_gfp() - reads a specified block and returns the bh
  *  @bdev: the block_device to read from
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 3a401f930bca..6a10f7d44719 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4321,7 +4321,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	/* Pre-read the descriptors into the buffer cache */
 	for (i = 0; i < db_count; i++) {
 		block = descriptor_loc(sb, logical_sb_block, i);
-		sb_breadahead(sb, block);
+		sb_breadahead_unmovable(sb, block);
 	}
 
 	for (i = 0; i < db_count; i++) {
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 7b73ef7f902d..b56cc825f64d 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -189,6 +189,8 @@ struct buffer_head *__getblk_gfp(struct block_device *bdev, sector_t block,
 void __brelse(struct buffer_head *);
 void __bforget(struct buffer_head *);
 void __breadahead(struct block_device *, sector_t block, unsigned int size);
+void __breadahead_gfp(struct block_device *, sector_t block, unsigned int size,
+		  gfp_t gfp);
 struct buffer_head *__bread_gfp(struct block_device *,
 				sector_t block, unsigned size, gfp_t gfp);
 void invalidate_bh_lrus(void);
@@ -319,6 +321,12 @@ sb_breadahead(struct super_block *sb, sector_t block)
 	__breadahead(sb->s_bdev, block, sb->s_blocksize);
 }
 
+static inline void
+sb_breadahead_unmovable(struct super_block *sb, sector_t block)
+{
+	__breadahead_gfp(sb->s_bdev, block, sb->s_blocksize, 0);
+}
+
 static inline struct buffer_head *
 sb_getblk(struct super_block *sb, sector_t block)
 {
-- 
2.24.1

