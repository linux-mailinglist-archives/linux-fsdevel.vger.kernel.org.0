Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F04713BAF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 09:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgAOI2e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 03:28:34 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:56739 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbgAOI23 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:28:29 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200115082825epoutp04b5a67943870b5884751649bbc6f08bb8~qAhRlP5lb0504105041epoutp043
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2020 08:28:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200115082825epoutp04b5a67943870b5884751649bbc6f08bb8~qAhRlP5lb0504105041epoutp043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579076906;
        bh=zF4N1+TosXQUJu+sGU8k4j0YPFSqmFz1zUBEplnI9YI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k6Yz+D3nU+V5WN2VAAAIadev5aMtleR47e/Ac+fBAY2bCuKdvy+8LvZL6GLzdjNJ4
         i91Q4yiYyj/sxgoeEzLZQxuQZZKRtsIAnyaKpQXT0E9O3uMimgTxj+ShpdOEw2ws9t
         P50EHTzI19A1+wFPlc7702yAIFL9UJB2tus3R4a8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200115082825epcas1p2d7b555803924318dca7bc4dfdeed2ff4~qAhRHeijl1549115491epcas1p2n;
        Wed, 15 Jan 2020 08:28:25 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.164]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47yL7X38sHzMqYm0; Wed, 15 Jan
        2020 08:28:24 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.AE.57028.72DCE1E5; Wed, 15 Jan 2020 17:28:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200115082822epcas1p384d080724d8bb0a8cd4c3e3015a0895c~qAhOwu61o0348603486epcas1p3S;
        Wed, 15 Jan 2020 08:28:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200115082822epsmtrp2622fa9fb03f4a742a127ca17db066230~qAhOv223C1143311433epsmtrp2T;
        Wed, 15 Jan 2020 08:28:22 +0000 (GMT)
X-AuditID: b6c32a35-4f3ff7000001dec4-6e-5e1ecd27a328
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.4A.10238.62DCE1E5; Wed, 15 Jan 2020 17:28:22 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200115082822epsmtip1f867717ae0837bfa0e052c68aa9d0b2f~qAhOkPQ9g0431104311epsmtip1R;
        Wed, 15 Jan 2020 08:28:22 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, pali.rohar@gmail.com,
        arnd@arndb.de, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v10 07/14] exfat: add bitmap operations
Date:   Wed, 15 Jan 2020 17:24:40 +0900
Message-Id: <20200115082447.19520-8-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200115082447.19520-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0gUURiGOTuzM6u0Nq2mB61tHbLU2txxXZ3KrSCLqayEoqDSbViHVdob
        O6tkEdkFLdPKVLqYFCmFaazoVmp5zZIMpQsS3op+CCFmmZWlGc04Rf17znve73K+8ykQ1bQ8
        WJFud3MuO2slMV/03qMIrXZptzpF1+KZS89ceILTJ8o9GF1Z9VhGvx7qR+iHTU9R+lXjVYz+
        fvEoXfhsWkZ7f3XI6ZcfP6HrfJnpqQuAabgyhDMtZdU486AvG2POem8DZqJWzbTfH8WS8D3W
        +DSOTeVcGs5udqSm2y1GcssO03qTIVZHaamVdBypsbM2zkgmJCZpN6ZbhfZITSZrzRCkJJbn
        yag18S5HhpvTpDl4t5HknKlWJ6VzruBZG59ht6wwO2yrKJ0u2iA491vTfnpCnSPMwfKqPpAN
        Cug8oFBAIgaWzCzOAz4KFVEPYO+7EIk/A/h2cp/E3wA8XhIusmjPLf0mzwO+gt4k6IWVqHQQ
        Aiq7B1AxKUYsgz+988WAAGItrCttnfUgRBuAo8/LcPHCn4iDXyqKMJFRIgwOdjbOspKIh+c8
        DbhUbRGsqmlFRPYhjLDD++qP3oHB8RdLJE6AD7vvYBL7w5FO7x9PMJwYa8KkRx6G4y2IJJ8C
        8P2kUWI97PPUyEULQkRAT2OUJIfChukyIDJC+MGxr/lyKYsSnspRSZYwePblI5nEITAv9xMu
        WRh4LNskDeQ8gA+6ZvDzQH3lX4HrANwGgZyTt1k4nnJS/39VLZhdvEhDPSjuSWwHhAKQc5Sa
        wYUpKjmbyWfZ2gFUIGSA8uklQVKmslmHOJfD5Mqwcnw7MAhjLESC55sdwhrb3SbKEK3X6+mY
        2LhYg54MUiZcV6eoCAvr5g5wnJNz/Y2TKXyCs0H5sKnGfkaz3TA5L2i8OvJGz+VmSy/6JlB5
        a2Tw5NgPsqDj5oC+7kjE6eYs1QcTWhql33tyrM1pPMGEopSpz7yA3Hl3Yrirguo5unxXTvJU
        p2z3Nd3auK0hnUWb8P5wWVvi5vRD6NzW4m0qdYvfNj90db5DuTG57tqGI+bhgvwZEuXTWCoS
        cfHsb4V78wGOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsWy7bCSnK7aWbk4g/lvjSz+TjrGbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyYXm8x8fRvJost/46wWlx6/4HFgcvj969JjB47Z91l
        99g/dw27x+6bDWwefVtWMXp83iTncWj7G7YA9igum5TUnMyy1CJ9uwSujD/rFQteeVQsXn2T
        sYGx16KLkZNDQsBEon32N9YuRi4OIYHdjBKre1ayQiSkJY6dOMPcxcgBZAtLHD5cDFHzgVHi
        4weQGg4ONgFtiT9bREHKRQQcJXp3HWYBqWEWOM0o0b3xIRNIQljAXOLLkslsIDaLgKrEneO7
        wGxeARuJ/vU72SF2yUus3nCAGcTmFLCVOLLlMlhcCKhm2pOTTBMY+RYwMqxilEwtKM5Nzy02
        LDDMSy3XK07MLS7NS9dLzs/dxAgOUS3NHYyXl8QfYhTgYFTi4VW4IxsnxJpYVlyZe4hRgoNZ
        SYT35AygEG9KYmVValF+fFFpTmrxIUZpDhYlcd6neccihQTSE0tSs1NTC1KLYLJMHJxSDYyr
        lQr/sMaf8OENaC210k18n6BY0pmy91zsnn16hwMurFffY2q5dBm/wP5vO+V9nMUk7ao3y1Ye
        Nhap836gdF/vk9Ozu/YL5nLrRF34fOzCx2qXFo5FEs7B01VN+NR/LmKNyL07QfrNjOkeVwMW
        r2GVWtSx6ojwEes9LZv+vvTg3nvuwWnZGnclluKMREMt5qLiRAC3cPVxTQIAAA==
X-CMS-MailID: 20200115082822epcas1p384d080724d8bb0a8cd4c3e3015a0895c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200115082822epcas1p384d080724d8bb0a8cd4c3e3015a0895c
References: <20200115082447.19520-1-namjae.jeon@samsung.com>
        <CGME20200115082822epcas1p384d080724d8bb0a8cd4c3e3015a0895c@epcas1p3.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the implementation of bitmap operations for exfat.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
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

