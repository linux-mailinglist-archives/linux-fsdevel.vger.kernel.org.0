Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCF9309FD4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 02:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhBABE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jan 2021 20:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBABEH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jan 2021 20:04:07 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6054CC061573;
        Sun, 31 Jan 2021 17:03:27 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u15so9062877plf.1;
        Sun, 31 Jan 2021 17:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HHTgRPDaj1JDsiKjlc8F/LkMGWq5sipTZH1ZsYplwI0=;
        b=WxTSAw0vOhWFuX0UI6eCbQhxizJ5TQMsJxY7kktLvfjO46sNnyE74m5QV8g1MzKcnS
         8cRs/J9sb8hvBAgqR3VGmrvjy2bASm1RGpM3cd3gtlxFTKxZzLqbaaNjvFNiaDVIfOeF
         CHqY9IiOCmnm8OivkQCrtClW9S3aZIa1b/s/tBP/j3zwUhLNEPXKIMWgxcwRZEsXeupI
         BGD7J1bUaYQcq1WlMkItw0+d0/unqDEjGhgPq4hx0YCfH2SDQusptws4Sl+V1hzjFfcX
         gfKIkLs0q4yos07ShIHiQz/85bAWPdbv3p3dEj82ckaIJzvNbbK3ytMwGEUziWMGMlKY
         0pHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HHTgRPDaj1JDsiKjlc8F/LkMGWq5sipTZH1ZsYplwI0=;
        b=c22KYQMMzOX/tVoLQhiP1kob603J8Oj/H4cahbEzrSyv65OLh/tIeEauRWzFDxC/Cr
         G8VUvrD/LZCAy0A+6W1CSluD/59FmCkaorvInK+oxpWD5MITiQj0CUPbWeqHtajDeFVr
         ZcL+Dc3/IBzYNO0EWXHT1wztQLXd/3D8YEDS1WsbZTwaMlln8McJ+7FsZFDKdbJf4vwN
         JsdESvIf7P7CpfGqOqMSFNWjR2+FCzCzjml8V0OrvkABYrZBfASomiyQAGOEEf8wTSJa
         Cb96a8/xbEnO7KrHTQxQPcR/vQnpIqt8YGnGkEhxBLXbzc/9zVt/no7KB7f0L6Q4/usw
         na4Q==
X-Gm-Message-State: AOAM531jn5F2y6P0uaD9SUFATgIBLfHfslTH1onpcSneNGGkH4JNrwgn
        gpOdnWEaIBoApmDoflE3P7o=
X-Google-Smtp-Source: ABdhPJySg4lY4SBh3D+Vt+eImNi1ovIOOwQcU7t5749m6LAAxadtOX7+PjtqhwlbXD43kjdxjLMIFw==
X-Received: by 2002:a17:90b:1992:: with SMTP id mv18mr15280132pjb.174.1612141406865;
        Sun, 31 Jan 2021 17:03:26 -0800 (PST)
Received: from localhost.localdomain ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id o190sm15219481pga.2.2021.01.31.17.03.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Jan 2021 17:03:25 -0800 (PST)
From:   Hyeongseok Kim <hyeongseok@gmail.com>
To:     namjae.jeon@samsung.com, sj1557.seo@samsung.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hyeongseok Kim <hyeongseok@gmail.com>
Subject: [PATCH v2] exfat: improve performance of exfat_free_cluster when using dirsync mount option
Date:   Mon,  1 Feb 2021 10:02:46 +0900
Message-Id: <20210201010246.25873-1-hyeongseok@gmail.com>
X-Mailer: git-send-email 2.27.0.83.g0313f36
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are stressful update of cluster allocation bitmap when using
dirsync mount option which is doing sync buffer on every cluster bit
clearing. This could result in performance degradation when deleting
big size file.
Fix to update only when the bitmap buffer index is changed would make
less disk access, improving performance especially for truncate operation.

Testing with Samsung 256GB sdcard, mounted with dirsync option
(mount -t exfat /dev/block/mmcblk0p1 /temp/mount -o dirsync)

Remove 4GB file, blktrace result.
[Before] : 39 secs.
Total (blktrace):
 Reads Queued:      0,        0KiB   Writes Queued:      32775,    16387KiB
 Read Dispatches:   0,        0KiB   Write Dispatches:   32775,    16387KiB
 Reads Requeued:    0                Writes Requeued:        0
 Reads Completed:   0,        0KiB   Writes Completed:   32775,    16387KiB
 Read Merges:       0,        0KiB   Write Merges:           0,        0KiB
 IO unplugs:        2                Timer unplugs:          0

[After] : 1 sec.
Total (blktrace):
 Reads Queued:      0,        0KiB   Writes Queued:         13,        6KiB
 Read Dispatches:   0,        0KiB   Write Dispatches:      13,        6KiB
 Reads Requeued:    0                Writes Requeued:        0
 Reads Completed:   0,        0KiB   Writes Completed:      13,        6KiB
 Read Merges:       0,        0KiB   Write Merges:           0,        0KiB
 IO unplugs:        1                Timer unplugs:          0

Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
---
 fs/exfat/balloc.c   |  4 ++--
 fs/exfat/exfat_fs.h |  2 +-
 fs/exfat/fatent.c   | 43 +++++++++++++++++++++++++++++++++++++------
 3 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index a987919686c0..761c79c3a4ba 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -166,7 +166,7 @@ int exfat_set_bitmap(struct inode *inode, unsigned int clu)
  * If the value of "clu" is 0, it means cluster 2 which is the first cluster of
  * the cluster heap.
  */
-void exfat_clear_bitmap(struct inode *inode, unsigned int clu)
+void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync)
 {
 	int i, b;
 	unsigned int ent_idx;
@@ -180,7 +180,7 @@ void exfat_clear_bitmap(struct inode *inode, unsigned int clu)
 	b = BITMAP_OFFSET_BIT_IN_SECTOR(sb, ent_idx);
 
 	clear_bit_le(b, sbi->vol_amap[i]->b_data);
-	exfat_update_bh(sbi->vol_amap[i], IS_DIRSYNC(inode));
+	exfat_update_bh(sbi->vol_amap[i], sync);
 
 	if (opts->discard) {
 		int ret_discard;
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index b8f0e829ecbd..764bc645241e 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -408,7 +408,7 @@ int exfat_count_num_clusters(struct super_block *sb,
 int exfat_load_bitmap(struct super_block *sb);
 void exfat_free_bitmap(struct exfat_sb_info *sbi);
 int exfat_set_bitmap(struct inode *inode, unsigned int clu);
-void exfat_clear_bitmap(struct inode *inode, unsigned int clu);
+void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync);
 unsigned int exfat_find_free_bitmap(struct super_block *sb, unsigned int clu);
 int exfat_count_used_clusters(struct super_block *sb, unsigned int *ret_count);
 
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index c3c9afee7418..7b2e8af17193 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -157,6 +157,7 @@ int exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain)
 	unsigned int clu;
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	int cur_cmap_i, next_cmap_i;
 
 	/* invalid cluster number */
 	if (p_chain->dir == EXFAT_FREE_CLUSTER ||
@@ -176,21 +177,51 @@ int exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain)
 
 	clu = p_chain->dir;
 
+	cur_cmap_i = next_cmap_i =
+		BITMAP_OFFSET_SECTOR_INDEX(sb, CLUSTER_TO_BITMAP_ENT(clu));
+
 	if (p_chain->flags == ALLOC_NO_FAT_CHAIN) {
+		unsigned int last_cluster = p_chain->dir + p_chain->size - 1;
 		do {
-			exfat_clear_bitmap(inode, clu);
-			clu++;
+			bool sync = false;
+
+			if (clu < last_cluster)
+				next_cmap_i =
+				  BITMAP_OFFSET_SECTOR_INDEX(sb, CLUSTER_TO_BITMAP_ENT(clu+1));
 
+			/* flush bitmap only if index would be changed or for last cluster */
+			if (clu == last_cluster || cur_cmap_i != next_cmap_i) {
+				sync = true;
+				cur_cmap_i = next_cmap_i;
+			}
+
+			exfat_clear_bitmap(inode, clu, (sync && IS_DIRSYNC(inode)));
+			clu++;
 			num_clusters++;
 		} while (num_clusters < p_chain->size);
 	} else {
 		do {
-			exfat_clear_bitmap(inode, clu);
-
-			if (exfat_get_next_cluster(sb, &clu))
-				goto dec_used_clus;
+			bool sync = false;
+			unsigned int n_clu = clu;
+			int err = exfat_get_next_cluster(sb, &n_clu);
+
+			if (err || n_clu == EXFAT_EOF_CLUSTER)
+				sync = true;
+			else
+				next_cmap_i =
+				  BITMAP_OFFSET_SECTOR_INDEX(sb, CLUSTER_TO_BITMAP_ENT(n_clu));
+
+			if (cur_cmap_i != next_cmap_i) {
+				sync = true;
+				cur_cmap_i = next_cmap_i;
+			}
 
+			exfat_clear_bitmap(inode, clu, (sync && IS_DIRSYNC(inode)));
+			clu = n_clu;
 			num_clusters++;
+
+			if (err)
+				goto dec_used_clus;
 		} while (clu != EXFAT_EOF_CLUSTER);
 	}
 
-- 
2.27.0.83.g0313f36

