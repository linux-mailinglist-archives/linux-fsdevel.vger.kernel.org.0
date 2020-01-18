Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9002514182C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2020 16:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgARPEi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 10:04:38 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45502 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgARPEi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 10:04:38 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so13146244pgk.12;
        Sat, 18 Jan 2020 07:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q1+nIcbVKE/ymPlTJxssTDLYlZLeeNj4k4BWR131W0E=;
        b=YYJ7ssESd5iyEAC2QC5XnHHp00MhSZCnDLn2qQDe0veIULaIzc9V0ug0UtEyDTjZ2A
         /jCVyHwZ3zbi7Gg82cTGfMfR5574EGyvcYv+I6swov2QZQbRESx1pkNlUDgrKL7V9W3j
         BGltHAAYbWXZL05EIX/0aUCNcXGxp9Vvl8e2XcvLqncIUPrf3VV+flVVRlzWYCp9FAWV
         Rj/sv9rN2SwhaHTl+cirSOnueGuVDodImIG4UilFW0D+l5wjTCtC+Az0jpHoRZ9pFafB
         JJy2nDEcxrbY/4I1fK9duG+3b643nfE+asirYBECwRQoXr4ud9RR87gl+OMx5SlDkXhk
         dwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q1+nIcbVKE/ymPlTJxssTDLYlZLeeNj4k4BWR131W0E=;
        b=e7068jGZ4ZcI+SpUaUTkEvuaBiMqui5B80tMLoA5KtZ796m31uFNsRK3m14qnRfNG5
         fSRiRarSIbDW6w0n06P9yzmna4slskjxjLNaBv+onN1SW0qTLSUWTMbHQ2YRGknpiv5t
         BgKI7ioAz/ZwuduN0NlgWjglSAwQONWSke3kS15MrNJu2h2LAzl+h/PZt0UBFMGQNWUg
         f76uh8X1KlXsy49WESzm6pw6COnwPer76ONhzHmXAurxMLK8jbHEDKRahEgVpZ3EdNnI
         8t7gi9JeFJd+/9ZgSHPY7b0lq/ijSHTeu7BTjdHLlyF2FkwwKiRyx/Wh8w5/1tKpMEET
         NbLA==
X-Gm-Message-State: APjAAAW7jpHzqR21yzvgmrwFrRjj9aOF9lrcSHxm40xkw1HpO0ya3XtO
        YOj+SG5n8PTTRExbw2q5H3kvgMHe
X-Google-Smtp-Source: APXvYqx78e4PhCvami5XpwqwrqV30Wgig5t4KRkChba9OVwbSzCZa3dk8YYqghfu4AmgkdmyoYAiyA==
X-Received: by 2002:aa7:8695:: with SMTP id d21mr8567048pfo.199.1579359877094;
        Sat, 18 Jan 2020 07:04:37 -0800 (PST)
Received: from localhost.localdomain ([221.146.116.86])
        by smtp.gmail.com with ESMTPSA id v10sm32072078pgk.24.2020.01.18.07.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 07:04:36 -0800 (PST)
From:   Namjae Jeon <linkinjeon@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        namjae.jeon@samsung.com, Namjae Jeon <linkinjeon@gmail.com>
Subject: [PATCH v11 07/14] exfat: add bitmap operations
Date:   Sun, 19 Jan 2020 00:03:41 +0900
Message-Id: <20200118150348.9972-8-linkinjeon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200118150348.9972-1-linkinjeon@gmail.com>
References: <20200118150348.9972-1-linkinjeon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Namjae Jeon <namjae.jeon@samsung.com>

This adds the implementation of bitmap operations for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
---
 fs/exfat/balloc.c | 282 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 282 insertions(+)
 create mode 100644 fs/exfat/balloc.c

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
new file mode 100644
index 000000000000..b568f5efc984
--- /dev/null
+++ b/fs/exfat/balloc.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/blkdev.h>
+#include <linux/slab.h>
+#include <linux/buffer_head.h>
+
+#include "exfat_raw.h"
+#include "exfat_fs.h"
+
+static const unsigned char free_bit[] = {
+	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2,/*  0 ~  19*/
+	0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 5, 0, 1, 0, 2, 0, 1, 0, 3,/* 20 ~  39*/
+	0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2,/* 40 ~  59*/
+	0, 1, 0, 6, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4,/* 60 ~  79*/
+	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 5, 0, 1, 0, 2,/* 80 ~  99*/
+	0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2, 0, 1, 0, 3,/*100 ~ 119*/
+	0, 1, 0, 2, 0, 1, 0, 7, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2,/*120 ~ 139*/
+	0, 1, 0, 4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 5,/*140 ~ 159*/
+	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2,/*160 ~ 179*/
+	0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 6, 0, 1, 0, 2, 0, 1, 0, 3,/*180 ~ 199*/
+	0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2,/*200 ~ 219*/
+	0, 1, 0, 5, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4,/*220 ~ 239*/
+	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0                /*240 ~ 254*/
+};
+
+static const unsigned char used_bit[] = {
+	0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4, 1, 2, 2, 3,/*  0 ~  19*/
+	2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5, 1, 2, 2, 3, 2, 3, 3, 4,/* 20 ~  39*/
+	2, 3, 3, 4, 3, 4, 4, 5, 2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5,/* 40 ~  59*/
+	4, 5, 5, 6, 1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,/* 60 ~  79*/
+	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 2, 3, 3, 4,/* 80 ~  99*/
+	3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4, 5, 4, 5, 5, 6,/*100 ~ 119*/
+	4, 5, 5, 6, 5, 6, 6, 7, 1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4,/*120 ~ 139*/
+	3, 4, 4, 5, 2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,/*140 ~ 159*/
+	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4, 5,/*160 ~ 179*/
+	4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7, 2, 3, 3, 4, 3, 4, 4, 5,/*180 ~ 199*/
+	3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6,/*200 ~ 219*/
+	5, 6, 6, 7, 3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,/*220 ~ 239*/
+	4, 5, 5, 6, 5, 6, 6, 7, 5, 6, 6, 7, 6, 7, 7, 8             /*240 ~ 255*/
+};
+
+/*
+ *  Allocation Bitmap Management Functions
+ */
+static int exfat_allocate_bitmap(struct super_block *sb,
+		struct exfat_dentry *ep)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	long long map_size;
+	unsigned int i, need_map_size;
+	sector_t sector;
+
+	sbi->map_clu = le32_to_cpu(ep->dentry.bitmap.start_clu);
+	map_size = le64_to_cpu(ep->dentry.bitmap.size);
+	need_map_size = ((EXFAT_DATA_CLUSTER_COUNT(sbi) - 1) / BITS_PER_BYTE)
+		+ 1;
+	if (need_map_size != map_size) {
+		exfat_msg(sb, KERN_ERR,
+				"bogus allocation bitmap size(need : %u, cur : %lld)",
+				need_map_size, map_size);
+		/*
+		 * Only allowed when bogus allocation
+		 * bitmap size is large
+		 */
+		if (need_map_size > map_size)
+			return -EIO;
+	}
+	sbi->map_sectors = ((need_map_size - 1) >>
+			(sb->s_blocksize_bits)) + 1;
+	sbi->vol_amap = kmalloc_array(sbi->map_sectors,
+				sizeof(struct buffer_head *), GFP_KERNEL);
+	if (!sbi->vol_amap)
+		return -ENOMEM;
+
+	sector = exfat_cluster_to_sector(sbi, sbi->map_clu);
+	for (i = 0; i < sbi->map_sectors; i++) {
+		sbi->vol_amap[i] = sb_bread(sb, sector + i);
+		if (!sbi->vol_amap[i]) {
+			/* release all buffers and free vol_amap */
+			int j = 0;
+
+			while (j < i)
+				brelse(sbi->vol_amap[j++]);
+
+			kfree(sbi->vol_amap);
+			sbi->vol_amap = NULL;
+			return -EIO;
+		}
+	}
+
+	sbi->pbr_bh = NULL;
+	return 0;
+}
+
+int exfat_load_bitmap(struct super_block *sb)
+{
+	unsigned int i, type;
+	struct exfat_chain clu;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+
+	exfat_chain_set(&clu, sbi->root_dir, 0, ALLOC_FAT_CHAIN);
+	while (clu.dir != EXFAT_EOF_CLUSTER) {
+		for (i = 0; i < sbi->dentries_per_clu; i++) {
+			struct exfat_dentry *ep;
+			struct buffer_head *bh;
+
+			ep = exfat_get_dentry(sb, &clu, i, &bh, NULL);
+			if (!ep)
+				return -EIO;
+
+			type = exfat_get_entry_type(ep);
+			if (type == TYPE_UNUSED)
+				break;
+			if (type != TYPE_BITMAP)
+				continue;
+			if (ep->dentry.bitmap.flags == 0x0) {
+				int err;
+
+				err = exfat_allocate_bitmap(sb, ep);
+				brelse(bh);
+				return err;
+			}
+			brelse(bh);
+		}
+
+		if (exfat_get_next_cluster(sb, &clu.dir))
+			return -EIO;
+	}
+
+	return -EINVAL;
+}
+
+void exfat_free_bitmap(struct super_block *sb)
+{
+	int i;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+
+	brelse(sbi->pbr_bh);
+
+	for (i = 0; i < sbi->map_sectors; i++)
+		__brelse(sbi->vol_amap[i]);
+
+	kfree(sbi->vol_amap);
+	sbi->vol_amap = NULL;
+}
+
+/*
+ * If the value of "clu" is 0, it means cluster 2 which is the first cluster of
+ * the cluster heap.
+ */
+int exfat_set_bitmap(struct inode *inode, unsigned int clu)
+{
+	int i, b;
+	unsigned int ent_idx;
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+
+	WARN_ON(clu < EXFAT_FIRST_CLUSTER);
+	ent_idx = CLUSTER_TO_BITMAP_ENT(clu);
+	i = BITMAP_OFFSET_SECTOR_INDEX(sb, ent_idx);
+	b = BITMAP_OFFSET_BIT_IN_SECTOR(sb, ent_idx);
+
+	set_bit_le(b, sbi->vol_amap[i]->b_data);
+	exfat_update_bh(sb, sbi->vol_amap[i], IS_DIRSYNC(inode));
+	return 0;
+}
+
+/*
+ * If the value of "clu" is 0, it means cluster 2 which is the first cluster of
+ * the cluster heap.
+ */
+void exfat_clear_bitmap(struct inode *inode, unsigned int clu)
+{
+	int i, b;
+	unsigned int ent_idx;
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_mount_options *opts = &sbi->options;
+
+	WARN_ON(clu < EXFAT_FIRST_CLUSTER);
+	ent_idx = CLUSTER_TO_BITMAP_ENT(clu);
+	i = BITMAP_OFFSET_SECTOR_INDEX(sb, ent_idx);
+	b = BITMAP_OFFSET_BIT_IN_SECTOR(sb, ent_idx);
+
+	clear_bit_le(b, sbi->vol_amap[i]->b_data);
+	exfat_update_bh(sb, sbi->vol_amap[i], IS_DIRSYNC(inode));
+
+	if (opts->discard) {
+		int ret_discard;
+
+		ret_discard = sb_issue_discard(sb,
+			exfat_cluster_to_sector(sbi, clu +
+						EXFAT_RESERVED_CLUSTERS),
+			(1 << sbi->sect_per_clus_bits), GFP_NOFS, 0);
+
+		if (ret_discard == -EOPNOTSUPP) {
+			exfat_msg(sb, KERN_ERR,
+				"discard not supported by device, disabling");
+			opts->discard = 0;
+		}
+	}
+}
+
+/*
+ * If the value of "clu" is 0, it means cluster 2 which is the first cluster of
+ * the cluster heap.
+ */
+unsigned int exfat_find_free_bitmap(struct super_block *sb, unsigned int clu)
+{
+	unsigned int i, map_i, map_b, ent_idx;
+	unsigned int clu_base, clu_free;
+	unsigned char k, clu_mask;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+
+	WARN_ON(clu < EXFAT_FIRST_CLUSTER);
+	ent_idx = CLUSTER_TO_BITMAP_ENT(clu);
+	clu_base = BITMAP_ENT_TO_CLUSTER(ent_idx & ~(BITS_PER_BYTE_MASK));
+	clu_mask = IGNORED_BITS_REMAINED(clu, clu_base);
+
+	map_i = BITMAP_OFFSET_SECTOR_INDEX(sb, ent_idx);
+	map_b = BITMAP_OFFSET_BYTE_IN_SECTOR(sb, ent_idx);
+
+	for (i = EXFAT_FIRST_CLUSTER; i < sbi->num_clusters;
+	     i += BITS_PER_BYTE) {
+		k = *(sbi->vol_amap[map_i]->b_data + map_b);
+		if (clu_mask > 0) {
+			k |= clu_mask;
+			clu_mask = 0;
+		}
+		if (k < 0xFF) {
+			clu_free = clu_base + free_bit[k];
+			if (clu_free < sbi->num_clusters)
+				return clu_free;
+		}
+		clu_base += BITS_PER_BYTE;
+
+		if (++map_b >= sb->s_blocksize ||
+		    clu_base >= sbi->num_clusters) {
+			if (++map_i >= sbi->map_sectors) {
+				clu_base = EXFAT_FIRST_CLUSTER;
+				map_i = 0;
+			}
+			map_b = 0;
+		}
+	}
+
+	return EXFAT_EOF_CLUSTER;
+}
+
+int exfat_count_used_clusters(struct super_block *sb, unsigned int *ret_count)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	unsigned int count = 0;
+	unsigned int i, map_i = 0, map_b = 0;
+	unsigned int total_clus = EXFAT_DATA_CLUSTER_COUNT(sbi);
+	unsigned int last_mask = total_clus & BITS_PER_BYTE_MASK;
+	unsigned char clu_bits;
+	const unsigned char last_bit_mask[] = {0, 0b00000001, 0b00000011,
+		0b00000111, 0b00001111, 0b00011111, 0b00111111, 0b01111111};
+
+	total_clus &= ~last_mask;
+	for (i = 0; i < total_clus; i += BITS_PER_BYTE) {
+		clu_bits = *(sbi->vol_amap[map_i]->b_data + map_b);
+		count += used_bit[clu_bits];
+		if (++map_b >= (unsigned int)sb->s_blocksize) {
+			map_i++;
+			map_b = 0;
+		}
+	}
+
+	if (last_mask) {
+		clu_bits = *(sbi->vol_amap[map_i]->b_data + map_b);
+		clu_bits &= last_bit_mask[last_mask];
+		count += used_bit[clu_bits];
+	}
+
+	*ret_count = count;
+	return 0;
+}
-- 
2.17.1

