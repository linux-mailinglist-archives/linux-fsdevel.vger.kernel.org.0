Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 875D819A872
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 11:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbgDAJRv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 05:17:51 -0400
Received: from mx04.melco.co.jp ([192.218.140.144]:60571 "EHLO
        mx04.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgDAJRv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 05:17:51 -0400
Received: from mr04.melco.co.jp (mr04 [133.141.98.166])
        by mx04.melco.co.jp (Postfix) with ESMTP id 1A8AD3A4497;
        Wed,  1 Apr 2020 18:17:49 +0900 (JST)
Received: from mr04.melco.co.jp (unknown [127.0.0.1])
        by mr04.imss (Postfix) with ESMTP id 48sgb107w0zRkCp;
        Wed,  1 Apr 2020 18:17:49 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr04.melco.co.jp (Postfix) with ESMTP id 48sgb06xV5zRkCT;
        Wed,  1 Apr 2020 18:17:48 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 48sgb06qPCzRkHS;
        Wed,  1 Apr 2020 18:17:48 +0900 (JST)
Received: from tux532.tad.melco.co.jp (unknown [133.141.243.226])
        by mf03.melco.co.jp (Postfix) with ESMTP id 48sgb06M2fzRkHR;
        Wed,  1 Apr 2020 18:17:48 +0900 (JST)
Received:  from tux532.tad.melco.co.jp
        by tux532.tad.melco.co.jp (unknown) with ESMTP id 0319Hm4N005340;
        Wed, 1 Apr 2020 18:17:48 +0900
Received: from tux390.tad.melco.co.jp (tux390.tad.melco.co.jp [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 9DABB17E075;
        Wed,  1 Apr 2020 18:17:48 +0900 (JST)
Received: from tux554.tad.melco.co.jp (tux100.tad.melco.co.jp [10.168.7.223])
        by tux390.tad.melco.co.jp (Postfix) with ESMTP id 9154417E073;
        Wed,  1 Apr 2020 18:17:48 +0900 (JST)
Received: from tux554.tad.melco.co.jp
        by tux554.tad.melco.co.jp (unknown) with ESMTP id 0319HmtE007069;
        Wed, 1 Apr 2020 18:17:48 +0900
From:   Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp
Cc:     Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] exfat: Unify access to the boot sector
Date:   Wed,  1 Apr 2020 18:17:45 +0900
Message-Id: <20200401091745.107261-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Unify access to boot sector via 'sbi>pbr_bh'.
This fixes vol_flags inconsistency at read failed in fs_set_vol_flags(),
and buffer_head leak in __exfat_fill_super().

Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
---
 fs/exfat/balloc.c |  3 ---
 fs/exfat/super.c  | 43 ++++++++++++++++---------------------------
 2 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index 6a04cc0256..6774a5a6de 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -91,7 +91,6 @@ static int exfat_allocate_bitmap(struct super_block *sb,
 		}
 	}
 
-	sbi->pbr_bh = NULL;
 	return 0;
 }
 
@@ -137,8 +136,6 @@ void exfat_free_bitmap(struct exfat_sb_info *sbi)
 {
 	int i;
 
-	brelse(sbi->pbr_bh);
-
 	for (i = 0; i < sbi->map_sectors; i++)
 		__brelse(sbi->vol_amap[i]);
 
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 16ed202ef5..2dd62543a4 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -49,6 +49,7 @@ static void exfat_put_super(struct super_block *sb)
 		sync_blockdev(sb->s_bdev);
 	exfat_set_vol_flags(sb, VOL_CLEAN);
 	exfat_free_bitmap(sbi);
+	brelse(sbi->pbr_bh);
 	mutex_unlock(&sbi->s_lock);
 
 	call_rcu(&sbi->rcu, exfat_delayed_free);
@@ -100,7 +101,7 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	struct pbr64 *bpb;
+	struct pbr64 *bpb = (struct pbr64 *)sbi->pbr_bh->b_data;
 	bool sync = 0;
 
 	/* flags are not changed */
@@ -115,15 +116,6 @@ int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag)
 	if (sb_rdonly(sb))
 		return 0;
 
-	if (!sbi->pbr_bh) {
-		sbi->pbr_bh = sb_bread(sb, 0);
-		if (!sbi->pbr_bh) {
-			exfat_msg(sb, KERN_ERR, "failed to read boot sector");
-			return -ENOMEM;
-		}
-	}
-
-	bpb = (struct pbr64 *)sbi->pbr_bh->b_data;
 	bpb->bsx.vol_flags = cpu_to_le16(new_flag);
 
 	if (new_flag == VOL_DIRTY && !buffer_dirty(sbi->pbr_bh))
@@ -355,10 +347,10 @@ static int exfat_read_root(struct inode *inode)
 	return 0;
 }
 
-static struct pbr *exfat_read_pbr_with_logical_sector(struct super_block *sb,
-		struct buffer_head **prev_bh)
+static struct pbr *exfat_read_pbr_with_logical_sector(struct super_block *sb)
 {
-	struct pbr *p_pbr = (struct pbr *) (*prev_bh)->b_data;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct pbr *p_pbr = (struct pbr *) (sbi->pbr_bh)->b_data;
 	unsigned short logical_sect = 0;
 
 	logical_sect = 1 << p_pbr->bsx.f64.sect_size_bits;
@@ -378,26 +370,23 @@ static struct pbr *exfat_read_pbr_with_logical_sector(struct super_block *sb,
 	}
 
 	if (logical_sect > sb->s_blocksize) {
-		struct buffer_head *bh = NULL;
-
-		__brelse(*prev_bh);
-		*prev_bh = NULL;
+		brelse(sbi->pbr_bh);
+		sbi->pbr_bh = NULL;
 
 		if (!sb_set_blocksize(sb, logical_sect)) {
 			exfat_msg(sb, KERN_ERR,
 				"unable to set blocksize %u", logical_sect);
 			return NULL;
 		}
-		bh = sb_bread(sb, 0);
-		if (!bh) {
+		sbi->pbr_bh = sb_bread(sb, 0);
+		if (!sbi->pbr_bh) {
 			exfat_msg(sb, KERN_ERR,
 				"unable to read boot sector (logical sector size = %lu)",
 				sb->s_blocksize);
 			return NULL;
 		}
 
-		*prev_bh = bh;
-		p_pbr = (struct pbr *) bh->b_data;
+		p_pbr = (struct pbr *)sbi->pbr_bh->b_data;
 	}
 	return p_pbr;
 }
@@ -408,21 +397,20 @@ static int __exfat_fill_super(struct super_block *sb)
 	int ret;
 	struct pbr *p_pbr;
 	struct pbr64 *p_bpb;
-	struct buffer_head *bh;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 
 	/* set block size to read super block */
 	sb_min_blocksize(sb, 512);
 
 	/* read boot sector */
-	bh = sb_bread(sb, 0);
-	if (!bh) {
+	sbi->pbr_bh = sb_bread(sb, 0);
+	if (!sbi->pbr_bh) {
 		exfat_msg(sb, KERN_ERR, "unable to read boot sector");
 		return -EIO;
 	}
 
 	/* PRB is read */
-	p_pbr = (struct pbr *)bh->b_data;
+	p_pbr = (struct pbr *)sbi->pbr_bh->b_data;
 
 	/* check the validity of PBR */
 	if (le16_to_cpu((p_pbr->signature)) != PBR_SIGNATURE) {
@@ -433,7 +421,7 @@ static int __exfat_fill_super(struct super_block *sb)
 
 
 	/* check logical sector size */
-	p_pbr = exfat_read_pbr_with_logical_sector(sb, &bh);
+	p_pbr = exfat_read_pbr_with_logical_sector(sb);
 	if (!p_pbr) {
 		ret = -EIO;
 		goto free_bh;
@@ -514,7 +502,7 @@ static int __exfat_fill_super(struct super_block *sb)
 free_upcase_table:
 	exfat_free_upcase_table(sbi);
 free_bh:
-	brelse(bh);
+	brelse(sbi->pbr_bh);
 	return ret;
 }
 
@@ -605,6 +593,7 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 free_table:
 	exfat_free_upcase_table(sbi);
 	exfat_free_bitmap(sbi);
+	brelse(sbi->pbr_bh);
 
 check_nls_io:
 	unload_nls(sbi->nls_io);
-- 
2.25.0

