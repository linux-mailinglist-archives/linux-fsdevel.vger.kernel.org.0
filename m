Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9338F1753BD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 07:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgCBG1D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 01:27:03 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:42813 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgCBG00 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 01:26:26 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200302062624epoutp034f9907031d8ff64c12d4e37a189a9a3c~4aLJ4SxDT2719227192epoutp03G
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2020 06:26:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200302062624epoutp034f9907031d8ff64c12d4e37a189a9a3c~4aLJ4SxDT2719227192epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583130384;
        bh=UtlrpQVorFx8+8mT7jug8QqVW0g4E2gK7qVkKnYR7BY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FosXKwUQOp5+xsaJEH2/kTzg5JPe1LCMDAuSyZRh4oOg281Y4hJ9cpa7zAtGInreg
         TM5VQ7xTT29v3p4d7aZdO/J00mB9iB3WQLDr23XC3GyEOyxKan7Pmng5D3YMKfPNSY
         todTDPhKA/UxPlCXuM/Vzr6cvzCAIbUVqqxGxyMQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200302062624epcas1p40461aa2a47afec887c410940cd042819~4aLJcgAc-1512915129epcas1p4u;
        Mon,  2 Mar 2020 06:26:24 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.163]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48W9C16cjgzMqYkk; Mon,  2 Mar
        2020 06:26:21 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        39.E0.48019.D07AC5E5; Mon,  2 Mar 2020 15:26:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200302062621epcas1p1be0044bf44ff08c90a3a8208fe3215e8~4aLG4bFB52066720667epcas1p1D;
        Mon,  2 Mar 2020 06:26:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200302062621epsmtrp2ecbdb76db5f0548bd68027cd9ea297d3~4aLG3n_OY1821918219epsmtrp2h;
        Mon,  2 Mar 2020 06:26:21 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-bd-5e5ca70d2851
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.39.10238.D07AC5E5; Mon,  2 Mar 2020 15:26:21 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302062621epsmtip2743dd343f96c3a93ace5704b2363a614~4aLGtuAyk2285622856epsmtip2Z;
        Mon,  2 Mar 2020 06:26:21 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        linkinjeon@gmail.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v14 07/14] exfat: add bitmap operations
Date:   Mon,  2 Mar 2020 15:21:38 +0900
Message-Id: <20200302062145.1719-8-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302062145.1719-1-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmvi7v8pg4g0NTzS3+TjrGbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyYXm8x8fRvJost/46wWlx6/4HF4vzf46wO3B6/f01i
        9Ng56y67x/65a9g9dt9sYPPo27KK0ePzJjmPQ9vfsHlsevKWKYAjKscmIzUxJbVIITUvOT8l
        My/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hQJYWyxJxSoFBAYnGxkr6dTVF+
        aUmqQkZ+cYmtUmpBSk6BoUGBXnFibnFpXrpecn6ulaGBgZEpUGVCTsb1w6/ZCq57VCz7+5K1
        gbHRoouRg0NCwESiZ5ZMFyMXh5DADkaJkwdXs0M4nxglWh5OYIVwvjFKPDp5jq2LkROsY0JD
        A1TVXqCW7m9McC0bPy9nA5nLJqAt8WeLKEiDiIC0xJn+S2A1zAINTBLNB5rYQWqEBcwl/m6y
        BalhEVCVWNS6kAXE5hWwlvjybxUjxDJ5idUbDjCD2JwCNhJ3dl1ghKgRlDg58wlYPTNQTfPW
        2cwg8yUEmtklXq5ZA3WpC1DiEDuELSzx6vgWKFtK4vO7vWwQ/1dLfNzPDBHuYJR48d0WwjaW
        uLl+AytICbOApsT6XfoQYUWJnb/nMkKs5ZN497WHFWIKr0RHmxBEiapE36XDTBC2tERX+weo
        pR4S/z5tY4GEVD+jxJIlbewTGBVmIflmFpJvZiFsXsDIvIpRLLWgODc9tdiwwAQ5fjcxgtOt
        lsUOxj3nfA4xCnAwKvHw7ngeHSfEmlhWXJl7iFGCg1lJhNeXEyjEm5JYWZValB9fVJqTWnyI
        0RQY8BOZpUST84G5IK8k3tDUyNjY2MLEzNzM1FhJnPdhpGackEB6YklqdmpqQWoRTB8TB6dU
        A6Nga3Diqil+DG8duv9cjG/fxD+p9YNuXXuefePjxRnGVfYXfvTtE/X/3Z1vWHMhufJsx6Sr
        /ueyvSZd11Frr12lfSfAerq/896pk96p2dfwl7RXB/El28bEt5iVyka/sL/3y9FDVeDM/ckT
        Trs6N25eHqXyQ5JRe5lmT5TKZNH9L3b6PljercRSnJFoqMVcVJwIAKxtwpfNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJXpd3eUycwbfdMhZ/Jx1jt2hevJ7N
        YuXqo0wW1+/eYrbYs/cki8XlXXPYLH5Mr7eYePo3k8WWf0dYLS69/8Bicf7vcVYHbo/fvyYx
        euycdZfdY//cNeweu282sHn0bVnF6PF5k5zHoe1v2Dw2PXnLFMARxWWTkpqTWZZapG+XwJVx
        /fBrtoLrHhXL/r5kbWBstOhi5OSQEDCRmNDQwA5iCwnsZpTY0h0IEZeWOHbiDHMXIweQLSxx
        +HBxFyMXUMkHRontpx4zgsTZBLQl/mwRBSkXASo/03+JCaSGWaCHSeLzlMVMIDXCAuYSfzfZ
        gtSwCKhKLGpdyAJi8wpYS3z5t4oRYpW8xOoNB5hBbE4BG4k7uy4wQpxjLfH0xV1miHpBiZMz
        n7CAjGQWUJdYP08IJMwM1Nq8dTbzBEbBWUiqZiFUzUJStYCReRWjZGpBcW56brFhgWFearle
        cWJucWleul5yfu4mRnAEaWnuYLy8JP4QowAHoxIP787n0XFCrIllxZW5hxglOJiVRHh9OYFC
        vCmJlVWpRfnxRaU5qcWHGKU5WJTEeZ/mHYsUEkhPLEnNTk0tSC2CyTJxcEo1MDZvXz7H3/pL
        tWL33kIDITk5mav3lwhHnXaYHxl8tnuOrIvIg3kcafa12ZpnXa4d/CC0+1qDMpfhGp+5Wxnj
        PzYwmij1utmX+J0OM5A/3eoVPvH0kphUljvWuYcurn3Z7m20Z9VhZ5OZMg39h3eKNRyun9ry
        pcjxR37tfcNDLNN6mWcKvfv0VImlOCPRUIu5qDgRABerqv+cAgAA
X-CMS-MailID: 20200302062621epcas1p1be0044bf44ff08c90a3a8208fe3215e8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200302062621epcas1p1be0044bf44ff08c90a3a8208fe3215e8
References: <20200302062145.1719-1-namjae.jeon@samsung.com>
        <CGME20200302062621epcas1p1be0044bf44ff08c90a3a8208fe3215e8@epcas1p1.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the implementation of bitmap operations for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/exfat/balloc.c | 280 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 280 insertions(+)
 create mode 100644 fs/exfat/balloc.c

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
new file mode 100644
index 000000000000..6a04cc02565a
--- /dev/null
+++ b/fs/exfat/balloc.c
@@ -0,0 +1,280 @@
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
+void exfat_free_bitmap(struct exfat_sb_info *sbi)
+{
+	int i;
+
+	brelse(sbi->pbr_bh);
+
+	for (i = 0; i < sbi->map_sectors; i++)
+		__brelse(sbi->vol_amap[i]);
+
+	kfree(sbi->vol_amap);
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

