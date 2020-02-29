Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC2441743BC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 01:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgB2AO3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 19:14:29 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28546 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726046AbgB2AO3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 19:14:29 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01T058fS009269
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2020 16:14:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=54qrPCjj2xg1JSMPnr0yRA36FAicW6ZVn6PlvT5gTU0=;
 b=IcA9q2sZ0zV84z6i/Ul3t/w4uXwDZzbVtSIsRp+DmuXwht+h/ezymNUFI1fWfUOf6T9J
 dk+sD8eMnhtKvAL699qJD0rScSNYXgWYzzht9PqEJYDugRZQJ/XFO3lIP27iBpNdncZl
 CUOxKnqW3p0DqqCWmqwbtlYqzXBIeNDhl9k= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yeputxbua-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2020 16:14:27 -0800
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 28 Feb 2020 16:14:26 -0800
Received: by devvm4439.prn2.facebook.com (Postfix, from userid 111017)
        id 33081739F065; Fri, 28 Feb 2020 16:14:19 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm4439.prn2.facebook.com
To:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Roman Gushchin <guro@fb.com>,
        Andrew Perepechko <andrew.perepechko@seagate.com>,
        Theodore Ts'o <tytso@mit.edu>, Gioh Kim <gioh.kim@lge.com>,
        Jan Kara <jack@suse.cz>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2] ext4: use non-movable memory for superblock readahead
Date:   Fri, 28 Feb 2020 16:14:11 -0800
Message-ID: <20200229001411.128010-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-28_09:2020-02-28,2020-02-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 mlxlogscore=871 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002280176
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

v2: found a similar issue in __ext4_get_inode_loc()

Fixes: 85c8f176a611 ("ext4: preload block group descriptors")
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Andrew Perepechko <andrew.perepechko@seagate.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Gioh Kim <gioh.kim@lge.com>
Cc: Jan Kara <jack@suse.cz>
---
 fs/buffer.c                 | 11 +++++++++++
 fs/ext4/inode.c             |  2 +-
 fs/ext4/super.c             |  2 +-
 include/linux/buffer_head.h |  8 ++++++++
 4 files changed, 21 insertions(+), 2 deletions(-)

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
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fa0ff78dc033..b131fedc6b77 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4348,7 +4348,7 @@ static int __ext4_get_inode_loc(struct inode *inode,
 			if (end > table)
 				end = table;
 			while (b <= end)
-				sb_breadahead(sb, b++);
+				sb_breadahead_unmovable(sb, b++);
 		}
 
 		/*
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ff1b764b0c0e..fb2338a5220e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4331,7 +4331,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
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

