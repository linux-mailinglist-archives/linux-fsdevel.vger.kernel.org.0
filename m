Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99D631A4F85
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Apr 2020 13:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgDKLLl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Apr 2020 07:11:41 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:49816 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgDKLLl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Apr 2020 07:11:41 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 25DA812F211;
        Sat, 11 Apr 2020 20:11:40 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-18) with ESMTPS id 03BBBch9072071
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 11 Apr 2020 20:11:39 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-18) with ESMTPS id 03BBBcXk237946
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 11 Apr 2020 20:11:38 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 03BBBcF6237945;
        Sat, 11 Apr 2020 20:11:38 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "hyeongseok.kim" <hyeongseok.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH resend] fat: Improve the readahead for FAT entries
Date:   Sat, 11 Apr 2020 20:11:38 +0900
Message-ID: <87d08e1dlh.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Current readahead for FAT entries is very simple but is having some
flaws, so it is not working well for some environments. This patch
improves the readahead more or less.

The key points of modification are,

  - make the readahead size tunable by using bdi->ra_pages
  - care the bdi->io_pages to avoid the small size I/O request
  - update readahead window before fully exhausting

With this patch, on slow USB connected 2TB hdd:

[before]
383.18sec

[after]
51.03sec

Tested-by: hyeongseok.kim <hyeongseok.kim@lge.com>
Reviewed-by: hyeongseok.kim <hyeongseok.kim@lge.com>
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---
 fs/fat/fatent.c |  103 ++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 75 insertions(+), 28 deletions(-)

diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index 3647c65..bbfe18c 100644
--- a/fs/fat/fatent.c	2020-04-01 23:57:18.572871992 +0900
+++ b/fs/fat/fatent.c	2020-04-01 23:57:35.256611854 +0900
@@ -632,20 +632,80 @@ error:
 }
 EXPORT_SYMBOL_GPL(fat_free_clusters);
 
-/* 128kb is the whole sectors for FAT12 and FAT16 */
-#define FAT_READA_SIZE		(128 * 1024)
+struct fatent_ra {
+	sector_t cur;
+	sector_t limit;
+
+	unsigned int ra_blocks;
+	sector_t ra_advance;
+	sector_t ra_next;
+	sector_t ra_limit;
+};
 
-static void fat_ent_reada(struct super_block *sb, struct fat_entry *fatent,
-			  unsigned long reada_blocks)
+static void fat_ra_init(struct super_block *sb, struct fatent_ra *ra,
+			struct fat_entry *fatent, int ent_limit)
 {
-	const struct fatent_operations *ops = MSDOS_SB(sb)->fatent_ops;
-	sector_t blocknr;
-	int i, offset;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	const struct fatent_operations *ops = sbi->fatent_ops;
+	sector_t blocknr, block_end;
+	int offset;
+	/*
+	 * This is the sequential read, so ra_pages * 2 (but try to
+	 * align the optimal hardware IO size).
+	 * [BTW, 128kb covers the whole sectors for FAT12 and FAT16]
+	 */
+	unsigned long ra_pages = sb->s_bdi->ra_pages;
+	unsigned int reada_blocks;
+
+	if (ra_pages > sb->s_bdi->io_pages)
+		ra_pages = rounddown(ra_pages, sb->s_bdi->io_pages);
+	reada_blocks = ra_pages << (PAGE_SHIFT - sb->s_blocksize_bits + 1);
 
+	/* Initialize the range for sequential read */
 	ops->ent_blocknr(sb, fatent->entry, &offset, &blocknr);
+	ops->ent_blocknr(sb, ent_limit - 1, &offset, &block_end);
+	ra->cur = 0;
+	ra->limit = (block_end + 1) - blocknr;
+
+	/* Advancing the window at half size */
+	ra->ra_blocks = reada_blocks >> 1;
+	ra->ra_advance = ra->cur;
+	ra->ra_next = ra->cur;
+	ra->ra_limit = ra->cur + min_t(sector_t, reada_blocks, ra->limit);
+}
 
-	for (i = 0; i < reada_blocks; i++)
-		sb_breadahead(sb, blocknr + i);
+/* Assuming to be called before reading a new block (increments ->cur). */
+static void fat_ent_reada(struct super_block *sb, struct fatent_ra *ra,
+			  struct fat_entry *fatent)
+{
+	if (ra->ra_next >= ra->ra_limit)
+		return;
+
+	if (ra->cur >= ra->ra_advance) {
+		struct msdos_sb_info *sbi = MSDOS_SB(sb);
+		const struct fatent_operations *ops = sbi->fatent_ops;
+		struct blk_plug plug;
+		sector_t blocknr, diff;
+		int offset;
+
+		ops->ent_blocknr(sb, fatent->entry, &offset, &blocknr);
+
+		diff = blocknr - ra->cur;
+		blk_start_plug(&plug);
+		/*
+		 * FIXME: we would want to directly use the bio with
+		 * pages to reduce the number of segments.
+		 */
+		for (; ra->ra_next < ra->ra_limit; ra->ra_next++)
+			sb_breadahead(sb, ra->ra_next + diff);
+		blk_finish_plug(&plug);
+
+		/* Advance the readahead window */
+		ra->ra_advance += ra->ra_blocks;
+		ra->ra_limit += min_t(sector_t,
+				      ra->ra_blocks, ra->limit - ra->ra_limit);
+	}
+	ra->cur++;
 }
 
 int fat_count_free_clusters(struct super_block *sb)
@@ -653,27 +713,20 @@ int fat_count_free_clusters(struct super
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	const struct fatent_operations *ops = sbi->fatent_ops;
 	struct fat_entry fatent;
-	unsigned long reada_blocks, reada_mask, cur_block;
+	struct fatent_ra fatent_ra;
 	int err = 0, free;
 
 	lock_fat(sbi);
 	if (sbi->free_clusters != -1 && sbi->free_clus_valid)
 		goto out;
 
-	reada_blocks = FAT_READA_SIZE >> sb->s_blocksize_bits;
-	reada_mask = reada_blocks - 1;
-	cur_block = 0;
-
 	free = 0;
 	fatent_init(&fatent);
 	fatent_set_entry(&fatent, FAT_START_ENT);
+	fat_ra_init(sb, &fatent_ra, &fatent, sbi->max_cluster);
 	while (fatent.entry < sbi->max_cluster) {
 		/* readahead of fat blocks */
-		if ((cur_block & reada_mask) == 0) {
-			unsigned long rest = sbi->fat_length - cur_block;
-			fat_ent_reada(sb, &fatent, min(reada_blocks, rest));
-		}
-		cur_block++;
+		fat_ent_reada(sb, &fatent_ra, &fatent);
 
 		err = fat_ent_read_block(sb, &fatent);
 		if (err)
@@ -707,9 +760,9 @@ int fat_trim_fs(struct inode *inode, str
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	const struct fatent_operations *ops = sbi->fatent_ops;
 	struct fat_entry fatent;
+	struct fatent_ra fatent_ra;
 	u64 ent_start, ent_end, minlen, trimmed = 0;
 	u32 free = 0;
-	unsigned long reada_blocks, reada_mask, cur_block = 0;
 	int err = 0;
 
 	/*
@@ -727,19 +780,13 @@ int fat_trim_fs(struct inode *inode, str
 	if (ent_end >= sbi->max_cluster)
 		ent_end = sbi->max_cluster - 1;
 
-	reada_blocks = FAT_READA_SIZE >> sb->s_blocksize_bits;
-	reada_mask = reada_blocks - 1;
-
 	fatent_init(&fatent);
 	lock_fat(sbi);
 	fatent_set_entry(&fatent, ent_start);
+	fat_ra_init(sb, &fatent_ra, &fatent, ent_end + 1);
 	while (fatent.entry <= ent_end) {
 		/* readahead of fat blocks */
-		if ((cur_block & reada_mask) == 0) {
-			unsigned long rest = sbi->fat_length - cur_block;
-			fat_ent_reada(sb, &fatent, min(reada_blocks, rest));
-		}
-		cur_block++;
+		fat_ent_reada(sb, &fatent_ra, &fatent);
 
 		err = fat_ent_read_block(sb, &fatent);
 		if (err)
_
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
