Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8860102100
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 10:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfKSJk3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 04:40:29 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:28226 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfKSJk2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:40:28 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191119094026epoutp03e63fdd2e6179eb94f7587ebb8a5138da~Yhu3i3q_d1901319013epoutp03K
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2019 09:40:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191119094026epoutp03e63fdd2e6179eb94f7587ebb8a5138da~Yhu3i3q_d1901319013epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574156426;
        bh=iRjw2RD0asFmnqKKqPfk/KOVSDaCUefdsIbM8/AfuQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7Bp0nrr7hZAl4GWU8rkN8GmNdaLz+0dz5MIS7XBkGHczyO8fyvi2XGZ/fHQ3xgRL
         YOG95yHfvMNa2DyO3ulH5ivzNaOP6XVmtpW6asQg19fIwcb1P1wPDiAY5E4y5x3exc
         KWpibvkXZfUEy6i3XTwWZ2VhRZFK3V8cAelMYEwY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191119094025epcas1p42cbfeb77c5bbd97ea5a3d5000d41d203~Yhu3GX8BB0056700567epcas1p4i;
        Tue, 19 Nov 2019 09:40:25 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.162]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47HLQw4ms5zMqYls; Tue, 19 Nov
        2019 09:40:24 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.07.04080.888B3DD5; Tue, 19 Nov 2019 18:40:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191119094024epcas1p3991c5d94c2cf40388d64c0bd9c30092d~Yhu18H9J41136411364epcas1p3Q;
        Tue, 19 Nov 2019 09:40:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191119094024epsmtrp13bb86cbc7e8295cbc47f0f2dc516fe02~Yhu17VuUH0080100801epsmtrp1o;
        Tue, 19 Nov 2019 09:40:24 +0000 (GMT)
X-AuditID: b6c32a37-7b5ff70000000ff0-b6-5dd3b888b195
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.12.03654.888B3DD5; Tue, 19 Nov 2019 18:40:24 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191119094024epsmtip276d03d903383562cbb05b922b592d982~Yhu1vRChc0820508205epsmtip2D;
        Tue, 19 Nov 2019 09:40:24 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v3 07/13] exfat: add bitmap operations
Date:   Tue, 19 Nov 2019 04:37:12 -0500
Message-Id: <20191119093718.3501-8-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119093718.3501-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTN6ywdiNVJVXxWo2UCMaItrbXtqKAmEpwoMU38QROCIx0p2mUy
        0yLKh7ghEgXlQxJANNG4FFkUwuIGKatLDFKNK3EhbELcF4gG7TBuf+eee867J/ddAlHvxTVE
        htvLCW7WSeHhaH3rQp0urzGYYih/Hkm39hUp6f1nqnH6YkW7gn7U+xShr9+4hdLBq2U4/bNk
        EKPHivfQdRNtGN3z7j26OpxpKulVMs0nLymZa09ycKagzg+Y2jvZzKcr85hAwyjOPBuoR23E
        Zmecg2PtnKDl3Gkee4Y7PZ5avzF1TarZYjDqjMtoK6V1sy4unkpIsukSM5yhiJQ2k3X6QpSN
        FUUqdmWc4PF5Oa3DI3rjKY63O3mjgdeLrEv0udP1aR7XcqPBsMQcUm5xOoreRfGHErI6/Y4c
        0GHKB2EEJJfCsv5KLB+EE2qyEcCG7su4XHwE8MuJEiAXXwHsPtAe6hCTlryqjZJbTd4A8Oi4
        76+h8FstkDQ4uQj+qJspaWaQq2BtaQsqaRCyDcChz8eUUmM6aYHDE12ohFEyGg75ezAJq8gV
        8GzHQ6Ucbz6sqGlBJBxGxsFXpeeAzHfhcLTTKuMEWFndgsl4OnzTWffbq4HDhblKOXM2/NCM
        yHReKMO3eBmb4JPqGkySIORCWH01VqYjYdP3k5OTEHIqfPvlCCa/ooJ5uWpZEg0LeloVMp4D
        8w+9/z2UgdeKgwp5I4UA3r3wADkG5pX8m3AaAD+I4HjRlc6JRt70/2ddAZPnF2NtBDX3kgKA
        JAA1RaVdEExRY2ymuMsVAJBAqBmqDa+7U9QqO7trNyd4UgWfkxMDwBza43FEMzPNEzpmtzfV
        aF5iMpnopRarxWyiZqmIsfspajKd9XI7OI7nhD8+BRGmyQHTdD1Rva8X/ayq8vdr9P5tiS8P
        Lz74QkvN3TyuDyZoz+xHda2VQnd5YC1fu28w+2bpbEvxbiIied0FtWfnglOG7eP+jg/4G81I
        1qbBga22XPsEQyUP6ysJ7r7tNriH8X0R1pFyNjbubFvfcnRFTeltxVjjU+Ex++m81Z5c0Emh
        ooM1xiCCyP4C1emoxpQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSvG7HjsuxBtO281gcfjyJ3aJ58Xo2
        i5WrjzJZXL97i9liz96TLBaXd81hs/g/6zmrxY/p9RZb/h1htbj0/gOLA5fHzll32T32z13D
        7rH7ZgObR9+WVYwem09Xe3zeJOdxaPsbNo/bz7axBHBEcdmkpOZklqUW6dslcGVMeq9S0O5S
        cXxVRgPjMeMuRg4OCQETiY51wV2MXBxCArsZJf5P+sbWxcgJFJeWOHbiDDNEjbDE4cPFEDUf
        GCV2HJ7NAhJnE9CW+LNFFKRcRMBRonfXYRaQGmaBc4wSO58tYwRJCAuYSbz8d4IFxGYRUJV4
        seoSK4jNK2AtseTYVXaIXfISqzccYAaxOQVsJB7OhugVAqppfNTMPoGRbwEjwypGydSC4tz0
        3GLDAsO81HK94sTc4tK8dL3k/NxNjOAw1dLcwXh5SfwhRgEORiUe3hMql2OFWBPLiitzDzFK
        cDArifD6PboQK8SbklhZlVqUH19UmpNafIhRmoNFSZz3ad6xSCGB9MSS1OzU1ILUIpgsEwen
        VAMjw47ARoFfn97/9RF5FFc7o5GlcQJDjCuzoMF/Py8vC+6pjacV3fsk3ltueKW+YEkH46O5
        b+Tsjv7W21WtIxsyxUojUex964scXje3B7VP1r2fkGD7SXTeyVf6er0HUh7WTvmZXrnjLZPU
        nd2rOjezevzW8Nseournbb/GTygjpXCyvfqWifpKLMUZiYZazEXFiQCzaXQBTwIAAA==
X-CMS-MailID: 20191119094024epcas1p3991c5d94c2cf40388d64c0bd9c30092d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191119094024epcas1p3991c5d94c2cf40388d64c0bd9c30092d
References: <20191119093718.3501-1-namjae.jeon@samsung.com>
        <CGME20191119094024epcas1p3991c5d94c2cf40388d64c0bd9c30092d@epcas1p3.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the implementation of bitmap operations for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/balloc.c | 271 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 271 insertions(+)
 create mode 100644 fs/exfat/balloc.c

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
new file mode 100644
index 000000000000..930e0ea3dbfd
--- /dev/null
+++ b/fs/exfat/balloc.c
@@ -0,0 +1,271 @@
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
+	need_map_size = (((sbi->num_clusters - BASE_CLUSTER) - 1) >> 3) + 1;
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
+	struct exfat_dentry *ep = NULL;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct buffer_head *bh;
+
+	exfat_chain_set(&clu, sbi->root_dir, 0, 0x01);
+
+	while (clu.dir != EOF_CLUSTER) {
+		for (i = 0; i < sbi->dentries_per_clu; i++) {
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
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+
+	i = clu >> (sb->s_blocksize_bits + 3);
+	b = clu & ((sb->s_blocksize << 3) - 1);
+
+	set_bit_le(b, sbi->vol_amap[i]->b_data);
+	exfat_update_bh(sb, sbi->vol_amap[i], IS_DIRSYNC(inode));
+
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
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_mount_options *opts = &sbi->options;
+
+	i = clu >> (sb->s_blocksize_bits + 3);
+	b = clu & ((sb->s_blocksize << 3) - 1);
+
+	clear_bit_le(b, sbi->vol_amap[i]->b_data);
+	exfat_update_bh(sb, sbi->vol_amap[i], IS_DIRSYNC(inode));
+
+	if (opts->discard) {
+		int ret_discard;
+
+		ret_discard = sb_issue_discard(sb,
+				exfat_cluster_to_sector(sbi, clu + 2),
+				(1 << sbi->sect_per_clus_bits), GFP_NOFS, 0);
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
+unsigned int exfat_test_bitmap(struct super_block *sb, unsigned int clu)
+{
+	unsigned int i, map_i, map_b;
+	unsigned int clu_base, clu_free;
+	unsigned char k, clu_mask;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+
+	clu_base = (clu & ~(0x7)) + 2;
+	clu_mask = (1 << (clu - clu_base + 2)) - 1;
+
+	map_i = clu >> (sb->s_blocksize_bits + 3);
+	map_b = (clu >> 3) & (unsigned int)(sb->s_blocksize - 1);
+
+	for (i = 2; i < sbi->num_clusters; i += 8) {
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
+		clu_base += 8;
+
+		if (++map_b >= sb->s_blocksize ||
+		    clu_base >= sbi->num_clusters) {
+			if (++map_i >= sbi->map_sectors) {
+				clu_base = 2;
+				map_i = 0;
+			}
+			map_b = 0;
+		}
+	}
+
+	return EOF_CLUSTER;
+}
+
+int exfat_count_used_clusters(struct super_block *sb, unsigned int *ret_count)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	unsigned int count = 0;
+	unsigned int i, map_i = 0, map_b = 0;
+	unsigned int total_clus = sbi->num_clusters - 2;
+	unsigned int last_mask = total_clus & 7;
+	unsigned char clu_bits;
+	const unsigned char last_bit_mask[] = {0, 0b00000001, 0b00000011,
+		0b00000111, 0b00001111, 0b00011111, 0b00111111, 0b01111111};
+
+	total_clus &= ~last_mask;
+	for (i = 0; i < total_clus; i += 8) {
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

