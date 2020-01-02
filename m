Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3792112E3DA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 09:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgABIYo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 03:24:44 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:52858 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgABIYK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 03:24:10 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200102082406epoutp03fc87f07697a2766a43510fc1f80ea0be~mBEylKB-R3211832118epoutp03Q
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jan 2020 08:24:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200102082406epoutp03fc87f07697a2766a43510fc1f80ea0be~mBEylKB-R3211832118epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1577953446;
        bh=1LnUulq5gwtyRrrIOVhZDkN56Ab6+IhciLYTwDgRufk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rR8gx0X1yEj/KEr2mQiKxEpbvA/qPQz8YFfdCcCxuTPDz/AqJs3pstBTbqbxGGFdL
         IN1R7oNQqzgWfwpJYIvBmKhZJ4m064Wfnh/DOUyFGYp8ZZCiVHWO5LsGF7Gq++1asN
         Y13nxNKNTpxd6GVWjIeF8GRZFxAGt2Bl5m7gPJQw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200102082406epcas1p384a2b9c271c3795a09ea54e5ceecc537~mBEyTFMc13061930619epcas1p3B;
        Thu,  2 Jan 2020 08:24:06 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.162]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47pLfY3SzTzMqYkj; Thu,  2 Jan
        2020 08:24:05 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.1F.48019.5A8AD0E5; Thu,  2 Jan 2020 17:24:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200102082405epcas1p41dd62d00104cb0daa4fe85641cb8ee22~mBExH18wQ2549925499epcas1p41;
        Thu,  2 Jan 2020 08:24:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200102082405epsmtrp27f3962fb2d66a6d759196fd26433233c~mBExG3vJZ2039720397epsmtrp2T;
        Thu,  2 Jan 2020 08:24:05 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-13-5e0da8a55e9a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.68.10238.4A8AD0E5; Thu,  2 Jan 2020 17:24:04 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200102082404epsmtip2702326355ae308fabad3309ed635850c~mBEw5xeFS2457824578epsmtip2h;
        Thu,  2 Jan 2020 08:24:04 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, pali.rohar@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v9 07/13] exfat: add bitmap operations
Date:   Thu,  2 Jan 2020 16:20:30 +0800
Message-Id: <20200102082036.29643-8-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200102082036.29643-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH++1u1zvxxm2Z/VpR60ZFme7l5tVcBUVcKMrQfyrSrnrZpL3a
        3UqLSLKH2AONIp3PyMpHoNnI18ZkJqaJqIFlYPiPlL3UJLUMabdrj/++v/P7fM85nHMwRDYj
        kWOZVifrsDJmEg0VP+3Yooy6X42nqL73r6Fy79WjVE1dp4h6NfIGoby+bjH1srUUpebunKcK
        X8yLKM/CMwk1ODEp3iWlW9wjIbS/7FEI3Tacg9I3PLWAnm5cSweaPqGJ6BFzgollMliHgrWm
        2zIyrUYDuS8pdXeqTq9SR6njqFhSYWUsrIHcsz8xam+mOdgUqTjFmF3BUCLDcaRyR4LD5nKy
        CpONcxpI1p5htqtV9miOsXAuqzE63WaJV6tUGl2QPG42TZWXiezVdFZD63VxDuiPzQdSDBIx
        sM29APJBKCYjmgEccleJhMdXADufj4TwlIyYAbC0V/PH0V95dRHyATj/YAD56/hwvyTowDCU
        iIQ/PSt4QzixEz4paRfzDEI0Auit+CbhP5YTelj0zCfmtZjYCO9MNqO8xokEWPM2BxWqrYN1
        De0Ir6WEARZPXEL5RJDwovBmwZMQAdoDZ8cfI4JeDj90eRbjcjj9xYfyDUHiLJzyLyJ5AL6f
        NQhaC4frGyQ8ghBbYH2rUgivhy3zZYDXCLEUfvl2TSJkwWHeZZmAbIQ3BjtEgl4N869MLhal
        4b2e26gwtwIAL5QkFYC17n8FKgGoBRGsnbMYWU5tj/l/X43g981tpZqBt29/ABAYIMPw1+Vh
        KTIJc4rLtgQAxBAyHD99CE+R4RlM9hnWYUt1uMwsFwC64BwLEfmKdFvwgq3OVLVOo9VqqRh9
        rF6nJVfi2NzAMRlhZJzsCZa1s44/PhEmleeAKrf+In14rKrhrNfQnHb0XVFkj//mwTfbW37s
        LuwCVE98nv9ITXfpLmRBmfxxfKz3etxAX1Juwa3ZB6CrInfba6m1fHulKCu4urt0vGc0+vbD
        IcWBzg3uCM25tLhhZNmqmcjkQ5+XbJLjvUdn0ZNNWMIQ6yTzRgNxoZvHfFPFpJgzMeqtiINj
        fgEkdBt5iQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSvO6SFbxxBs8fWVs0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbTDz9m8liy78jrBaX3n9gceD02DnrLrvH/rlr2D1232xg
        8+jbsorR4/MmOY9D29+wBbBFcdmkpOZklqUW6dslcGV8nDeXqWCFR8WGXb0sDYwXzLsYOTkk
        BEwkLizoZupi5OIQEtjNKNG09CMTREJa4tiJM8xdjBxAtrDE4cPFEDUfGCXuTuplBYmzCWhL
        /NkiClIuIuAo0bvrMAtIDbPALkaJE6dPM4IkhAXMJGYc2csCYrMIqEpM/7CDDcTmFbCRWHmv
        gQ1il7zE6g0HmEFsTgFbiZnvW8HiQkA1r/49ZpvAyLeAkWEVo2RqQXFuem6xYYFhXmq5XnFi
        bnFpXrpecn7uJkZwQGpp7mC8vCT+EKMAB6MSD++NeTxxQqyJZcWVuYcYJTiYlUR4ywN544R4
        UxIrq1KL8uOLSnNSiw8xSnOwKInzPs07FikkkJ5YkpqdmlqQWgSTZeLglGpgTD6zx3e+/+Jj
        i1YWGV3ILWux31Rw+t/S8JC/0cf3FOwVW/Gd3bXK8NDZiVJbD3tprOdTKI1IZxfTFJ5z6Ld3
        2E7Tcu+tF5fdcZywyOmf6N90+cz9k++6bpz+1oAvICVuYqYq8z+zyZWbGNesNJi3m8fy6km2
        hHnTxKV3rHrOGnvtctHx5ycn2CqxFGckGmoxFxUnAgBQBo2GRAIAAA==
X-CMS-MailID: 20200102082405epcas1p41dd62d00104cb0daa4fe85641cb8ee22
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200102082405epcas1p41dd62d00104cb0daa4fe85641cb8ee22
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
        <CGME20200102082405epcas1p41dd62d00104cb0daa4fe85641cb8ee22@epcas1p4.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the implementation of bitmap operations for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/balloc.c | 282 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 282 insertions(+)
 create mode 100644 fs/exfat/balloc.c

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
new file mode 100644
index 000000000000..7612d68f5664
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
+	sbi->map_clu = le32_to_cpu(ep->bitmap_start_clu);
+	map_size = le64_to_cpu(ep->bitmap_size);
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
+			if (ep->bitmap_flags == 0x0) {
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

