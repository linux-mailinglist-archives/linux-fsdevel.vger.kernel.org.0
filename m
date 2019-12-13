Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 715A011DE04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 06:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbfLMFyY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 00:54:24 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:30428 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731762AbfLMFxr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 00:53:47 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191213055344epoutp023a086e42a268e341f2986df69d3dc053~f2Hyf91qI2310923109epoutp02b
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2019 05:53:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191213055344epoutp023a086e42a268e341f2986df69d3dc053~f2Hyf91qI2310923109epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576216424;
        bh=1LnUulq5gwtyRrrIOVhZDkN56Ab6+IhciLYTwDgRufk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MQkMlYQ+bjIHxet7snL22m72oAAE+ZJjjSe/FiseJobMV4OQmQrYKVv6hgoaypw7i
         sV5jfmJj0VXh+n1OC0ki5+fTuFULDVXLfXCBV6WJlvltKpcWoSBHwS7KHHZmsIf3Vb
         1aZRXKSx+SNuV9fjFTFljYC3Is9ZF/zhN7UK8qOI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191213055344epcas1p3c230aa2a888459c504339a31d991b83c~f2HySZQbT0380703807epcas1p34;
        Fri, 13 Dec 2019 05:53:44 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.166]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47Z0GG5ZwszMqYkn; Fri, 13 Dec
        2019 05:53:42 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.BA.57028.66723FD5; Fri, 13 Dec 2019 14:53:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191213055341epcas1p291e09a7a59f59bfd6802e18987bec9e4~f2HwJ3sXr2013320133epcas1p2j;
        Fri, 13 Dec 2019 05:53:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191213055341epsmtrp124f682fffadbc26214cf73ab21e51871~f2HwJPAte0538305383epsmtrp1Y;
        Fri, 13 Dec 2019 05:53:41 +0000 (GMT)
X-AuditID: b6c32a35-4f3ff7000001dec4-0e-5df32766e891
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.E0.10238.56723FD5; Fri, 13 Dec 2019 14:53:41 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191213055341epsmtip24f232ef2286fa674fd459a84078a4c6b~f2Hv_1DK51249412494epsmtip2h;
        Fri, 13 Dec 2019 05:53:41 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v7 07/13] exfat: add bitmap operations
Date:   Fri, 13 Dec 2019 00:50:22 -0500
Message-Id: <20191213055028.5574-8-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191213055028.5574-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7bCmnm6a+udYgxer+S2aF69ns1i5+iiT
        xZ69J1ksLu+aw2bxY3q9xZZ/R1gtLr3/wOLA7rF/7hp2j903G9g8+rasYvT4vEnO49D2N2wB
        rFE5NhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAVygp
        lCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCgwNCvSKE3OLS/PS9ZLzc60MDQyMTIEq
        E3IyPs6by1SwwqNiw65elgbGC+ZdjJwcEgImEp8WPWXrYuTiEBLYwSixcedcVgjnE6PEpZNb
        oZxvjBL/Duxn6WLkAGvZ8SMSpFtIYC+jxPS9WnAN+9oXMYHUsAloS/zZIgpSIyJgL7F59gEW
        kBpmgRZGiQWnfzCDJIQFzCQmNH1nBbFZBFQlOjv/sIDYvALWEh+nL2KHOE9eYvWGA2D1nAI2
        EvMmf2AHGSQhMIdN4tz2F1AHuUjsX1sPUS8s8er4FqheKYmX/W3sECXVEh/3M0OEOxglXny3
        hbCNJW6u38AKUsIsoCmxfpc+RFhRYufvuYwgNrMAn8S7rz2sEFN4JTrahCBKVCX6Lh1mgrCl
        JbraP0At9ZA4dXUpNDz7GSX+b3/JNoFRbhbChgWMjKsYxVILinPTU4sNCwyRo2sTIziNaZnu
        YJxyzucQowAHoxIP74rET7FCrIllxZW5hxglOJiVRHjta4BCvCmJlVWpRfnxRaU5qcWHGE2B
        4TiRWUo0OR+YYvNK4g1NjYyNjS1MzMzNTI2VxHk5flyMFRJITyxJzU5NLUgtgulj4uCUamB0
        9kh2mZnAxz2XaSfz2XX7/um/+DHt4N/Qls873viJxizuqf5xsqJc7Z/RKTaW8uJJl/veRe/f
        fGTP+syoa3OtfPgMsyuzdzQ9cmIyf9cSdP9ik7X659nSC7PLNqSurLdL1d+i/e+P58LKozUc
        sQvbA67X9lj+ZnBQqtJ58CpgRtSLA+ZTnr1UYinOSDTUYi4qTgQAMb4k8nkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrILMWRmVeSWpSXmKPExsWy7bCSvG6q+udYgxOd+hbNi9ezWaxcfZTJ
        Ys/ekywWl3fNYbP4Mb3eYsu/I6wWl95/YHFg99g/dw27x+6bDWwefVtWMXp83iTncWj7G7YA
        1igum5TUnMyy1CJ9uwSujI/z5jIVrPCo2LCrl6WB8YJ5FyMHh4SAicSOH5FdjFwcQgK7GSWu
        /3/C2MXICRSXljh24gwzRI2wxOHDxRA1Hxgl9i6HiLMJaEv82SIKUi4i4CjRu+swC0gNs0AX
        o8Sjpm/MIAlhATOJCU3fWUFsFgFVic7OPywgNq+AtcTH6YvYIXbJS6zecACsnlPARmLe5A9g
        cSGgmrtvX7FNYORbwMiwilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOOC0NHcwXl4S
        f4hRgINRiYeXIeVTrBBrYllxZe4hRgkOZiURXvsaoBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe
        p3nHIoUE0hNLUrNTUwtSi2CyTBycUg2M7d++TNrsmV2d/4TFZlffHhnXtJYV3nmi2d3zOVb0
        sqSVWi3ewXWva2FAlsGdXdPn1Ozj3Pgj6/W/b70zJ6nxCtrOOaO3r4CnpTY6ycx2wW63Ppsv
        RnbHVn8XV4vZYr7py7uWSVcbmX7/9fkpNOnFy8b+6TObTCOF+Gb+0s9VCHiV6jtpfdxmJZbi
        jERDLeai4kQAVYdenTQCAAA=
X-CMS-MailID: 20191213055341epcas1p291e09a7a59f59bfd6802e18987bec9e4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191213055341epcas1p291e09a7a59f59bfd6802e18987bec9e4
References: <20191213055028.5574-1-namjae.jeon@samsung.com>
        <CGME20191213055341epcas1p291e09a7a59f59bfd6802e18987bec9e4@epcas1p2.samsung.com>
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

