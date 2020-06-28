Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E1520C664
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jun 2020 08:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgF1GKr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Jun 2020 02:10:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgF1GKg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Jun 2020 02:10:36 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A572212CC;
        Sun, 28 Jun 2020 06:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593324635;
        bh=bnp+eCD5Gi7nbCry4mjWrBi8MESGj+FmNcYNdBjKM5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQKCt3cGJZ0QdodNb4/Q0KOHutI+GqY7Jh91UAaVoJU//3NMXtNTbEqatg26eagoW
         lhsA9NkXA0QfgPI6Yq5F9hHTGSwRUy+qiCdGQPtBsGURzVLDqW/rX29Wi5NvLP/K3M
         yASw0LCQzJhtfkACRbvpNE3gpxL9kMK7Ux8UJiIE=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH 4/6] fs/minix: set s_maxbytes correctly
Date:   Sat, 27 Jun 2020 23:08:43 -0700
Message-Id: <20200628060846.682158-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200628060846.682158-1-ebiggers@kernel.org>
References: <20200628060846.682158-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The minix filesystem leaves super_block::s_maxbytes at MAX_NON_LFS
rather than setting it to the actual filesystem-specific limit.  This is
broken because it means userspace doesn't see the standard behavior like
getting EFBIG and SIGXFSZ when exceeding the maximum file size.

Fix this by setting s_maxbytes correctly.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/minix/inode.c    | 12 +++++++-----
 fs/minix/itree_v1.c |  2 +-
 fs/minix/itree_v2.c |  3 +--
 fs/minix/minix.h    |  1 -
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 0dd929346f3f..7b09a9158e40 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -150,8 +150,10 @@ static int minix_remount (struct super_block * sb, int * flags, char * data)
 	return 0;
 }
 
-static bool minix_check_superblock(struct minix_sb_info *sbi)
+static bool minix_check_superblock(struct super_block *sb)
 {
+	struct minix_sb_info *sbi = minix_sb(sb);
+
 	if (sbi->s_imap_blocks == 0 || sbi->s_zmap_blocks == 0)
 		return false;
 
@@ -161,7 +163,7 @@ static bool minix_check_superblock(struct minix_sb_info *sbi)
 	 * of indirect blocks which places the limit well above U32_MAX.
 	 */
 	if (sbi->s_version == MINIX_V1 &&
-	    sbi->s_max_size > (7 + 512 + 512*512) * BLOCK_SIZE)
+	    sb->s_maxbytes > (7 + 512 + 512*512) * BLOCK_SIZE)
 		return false;
 
 	return true;
@@ -202,7 +204,7 @@ static int minix_fill_super(struct super_block *s, void *data, int silent)
 	sbi->s_zmap_blocks = ms->s_zmap_blocks;
 	sbi->s_firstdatazone = ms->s_firstdatazone;
 	sbi->s_log_zone_size = ms->s_log_zone_size;
-	sbi->s_max_size = ms->s_max_size;
+	s->s_maxbytes = ms->s_max_size;
 	s->s_magic = ms->s_magic;
 	if (s->s_magic == MINIX_SUPER_MAGIC) {
 		sbi->s_version = MINIX_V1;
@@ -233,7 +235,7 @@ static int minix_fill_super(struct super_block *s, void *data, int silent)
 		sbi->s_zmap_blocks = m3s->s_zmap_blocks;
 		sbi->s_firstdatazone = m3s->s_firstdatazone;
 		sbi->s_log_zone_size = m3s->s_log_zone_size;
-		sbi->s_max_size = m3s->s_max_size;
+		s->s_maxbytes = m3s->s_max_size;
 		sbi->s_ninodes = m3s->s_ninodes;
 		sbi->s_nzones = m3s->s_zones;
 		sbi->s_dirsize = 64;
@@ -245,7 +247,7 @@ static int minix_fill_super(struct super_block *s, void *data, int silent)
 	} else
 		goto out_no_fs;
 
-	if (!minix_check_superblock(sbi))
+	if (!minix_check_superblock(s))
 		goto out_illegal_sb;
 
 	/*
diff --git a/fs/minix/itree_v1.c b/fs/minix/itree_v1.c
index 046cc96ee7ad..c0d418209ead 100644
--- a/fs/minix/itree_v1.c
+++ b/fs/minix/itree_v1.c
@@ -29,7 +29,7 @@ static int block_to_path(struct inode * inode, long block, int offsets[DEPTH])
 	if (block < 0) {
 		printk("MINIX-fs: block_to_path: block %ld < 0 on dev %pg\n",
 			block, inode->i_sb->s_bdev);
-	} else if (block >= (minix_sb(inode->i_sb)->s_max_size/BLOCK_SIZE)) {
+	} else if (block >= inode->i_sb->s_maxbytes/BLOCK_SIZE) {
 		if (printk_ratelimit())
 			printk("MINIX-fs: block_to_path: "
 			       "block %ld too big on dev %pg\n",
diff --git a/fs/minix/itree_v2.c b/fs/minix/itree_v2.c
index f7fc7ecccccc..ee8af2f9e282 100644
--- a/fs/minix/itree_v2.c
+++ b/fs/minix/itree_v2.c
@@ -32,8 +32,7 @@ static int block_to_path(struct inode * inode, long block, int offsets[DEPTH])
 	if (block < 0) {
 		printk("MINIX-fs: block_to_path: block %ld < 0 on dev %pg\n",
 			block, sb->s_bdev);
-	} else if ((u64)block * (u64)sb->s_blocksize >=
-			minix_sb(sb)->s_max_size) {
+	} else if ((u64)block * (u64)sb->s_blocksize >= sb->s_maxbytes) {
 		if (printk_ratelimit())
 			printk("MINIX-fs: block_to_path: "
 			       "block %ld too big on dev %pg\n",
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index df081e8afcc3..168d45d3de73 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -32,7 +32,6 @@ struct minix_sb_info {
 	unsigned long s_zmap_blocks;
 	unsigned long s_firstdatazone;
 	unsigned long s_log_zone_size;
-	unsigned long s_max_size;
 	int s_dirsize;
 	int s_namelen;
 	struct buffer_head ** s_imap;
-- 
2.27.0

