Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45CADFABEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 09:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfKMIWs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 03:22:48 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:21119 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfKMIW2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 03:22:28 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191113082223epoutp02ba2edcfa706adfbd23b6832c6b915b7b~WqzBNHv0m0038000380epoutp02f
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 08:22:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191113082223epoutp02ba2edcfa706adfbd23b6832c6b915b7b~WqzBNHv0m0038000380epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573633343;
        bh=cG7O/TfkmDh77SHbEt4btQKu+oWIWr/YPwUD2CLcs0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q2JDVxm8Hs1nKFkpbaJoo18qbKRWuDbBbG+yMgSqY1sWfsGoas12KwDfXQmEMsrf3
         13B3Tns1SDz1LjHrSCrQrfiQkRPSpNg8cOZ3nMcHJgBNsbRnkXZBOaIpDKEld+drIE
         MRTRrAFfsrkXdEVxaSeqHxDr7jqgTD62w6FRCXXw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191113082223epcas1p25ef6c84de73d17685c77991ba0f846b5~WqzAijbpw0268702687epcas1p2u;
        Wed, 13 Nov 2019 08:22:23 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.165]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47Cczf10gPzMqYkV; Wed, 13 Nov
        2019 08:22:22 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.8B.04085.D3DBBCD5; Wed, 13 Nov 2019 17:22:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191113082221epcas1p3dba436231d4d6893e2bda4b0aaeda575~Wqy_xG_sX1452214522epcas1p3B;
        Wed, 13 Nov 2019 08:22:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191113082221epsmtrp258ee4df46d0843ddd2a4b8c27c3ed126~Wqy_v1UGG2391923919epsmtrp2C;
        Wed, 13 Nov 2019 08:22:21 +0000 (GMT)
X-AuditID: b6c32a37-e31ff70000000ff5-83-5dcbbd3da8e5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.84.24756.D3DBBCD5; Wed, 13 Nov 2019 17:22:21 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191113082220epsmtip194b76eff358f70b2eb46d0098da87b72~Wqy_mMU6f2165921659epsmtip1h;
        Wed, 13 Nov 2019 08:22:20 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH 07/13] exfat: add bitmap operations
Date:   Wed, 13 Nov 2019 03:17:54 -0500
Message-Id: <20191113081800.7672-8-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191113081800.7672-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTm5727Xkery9T6tUDtglHGcnNOb+Z6SgzyD6E/eo55cbcpbrvr
        3ilqYKsgZZgaBYZpJWraC0WXWiau9bRIaJJlJYkSWZbT2cPsue0q9d853/m+8x3OOTgi9Ypk
        eI7FxnAW2kRiYrTjzhq5XNPzWKdo7l9OHatvwahLV+6FUM+HXyLUrZ4+lBq4WYNRs1WHKefv
        uyLK451CN+PaG9XDodre2quh2u4hO6Ytd14G2pm2KK278yOWge01pWYztIHhYhhLFmvIsRg1
        5I6d+m16dZJCKVeup5LJGAttZjRkWnqGfHuOyT8PGZNPm/L8UAbN82T8xlSOzbMxMdksb9OQ
        jNVgsioV1nU8bebzLMZ1Waw5RalQJKj9zExT9qlnJSHWiq0Fvru3UTuYUDpAGA6JRHi+phE4
        gBiXEl0Avh58jgqJD0DXuyOYkHwFsPfI+5AFyVz9HCIUegDsfFMKAoWg5HNfsQPgOEashT+d
        kQE4gtgE28+6gl0RogbArhPVQX44oYKn6zwgwEeJWFjZJA7AEmID/O6cCBW8ouGVVhcSoIQR
        qXDwmkaAWzH4sCNBiNOgvdGLCnE4/PDAOS+VwZnJHiwghcQhON2LCHApgOPf5tuo4FBLqyhA
        QYg1sOVmvACvhDd+1AZnRIjFcPJLmUjoIoGlx6UCJRaWe+7M72MFdJRMzZtq4Wj5k1BhNxUA
        zg1eF1WCqOp/DhcAuAyWMlbebGR4pVX1/7XaQPDZ4pK7QGt/uhsQOCAXSWDdI51UROfzhWY3
        gDhCRki6Ch7qpBIDXVjEcKyeyzMxvBuo/Vs8icgis1j/61pseqU6QaVSUYlJyUlqFblMsqWp
        UScljLSNyWUYK8Mt6ELwMJkdnPMZjLEdtWdQ9GKsbvWeeFA8UHPJ2/DWtWJXXZgiQ1WlYTWc
        fqStzzfmnRg6mvbYdz83hxurH/+W8rrf/Oc8MiJml9h3ywc+ZTaUVBTNJDzFm7lpm4ttOOgp
        q2rpfhU1Ep2b6T4gdjRG7n8yulU2u6q8v+GLx/xC82tfIt1Oonw2rYxDOJ7+C25Qc4KCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSnK7t3tOxBn+nMVs0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbbPl3hNXi0vsPLA4cHjtn3WX32D93DbvH7psNbB59W1Yx
        enzeJOdxaPsbtgC2KC6blNSczLLUIn27BK6MyVfbmQr6nSo+HTnI0sD42rCLkZNDQsBE4tfi
        X8xdjFwcQgK7GSUO/J/KApGQljh24gxQggPIFpY4fLgYouYDo8SFPUfB4mwC2hJ/toiClIsI
        OEr07jrMAlLDLLCIUeLdx8msIAlhAWOJKQsvMYLUswioSkxYzgUS5hWwlvi55TU7xCp5idUb
        DoCN5BSwkbi21hYkLARU8vXtAeYJjHwLGBlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefn
        bmIEh6CW5g7Gy0viDzEKcDAq8fBKLDwVK8SaWFZcmXuIUYKDWUmEd0fFiVgh3pTEyqrUovz4
        otKc1OJDjNIcLErivE/zjkUKCaQnlqRmp6YWpBbBZJk4OKUaGBUnTmfIfH95ypkpMx+JLO3e
        0pm675DwtSjB3TKPU5W3mmzYpnuptf7AguImrR+873SWRFc+XRPpL/L7a/QNmxcxzNnX9KTD
        bRfte2piy2LMeu/ijclTt5d0Wys5MJ81emZ4pifv3yPZ7i0KB9fy7VXR+mqeUud3XSow+mPf
        k20Gidt/6TWYZSixFGckGmoxFxUnAgC5nMaFPQIAAA==
X-CMS-MailID: 20191113082221epcas1p3dba436231d4d6893e2bda4b0aaeda575
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191113082221epcas1p3dba436231d4d6893e2bda4b0aaeda575
References: <20191113081800.7672-1-namjae.jeon@samsung.com>
        <CGME20191113082221epcas1p3dba436231d4d6893e2bda4b0aaeda575@epcas1p3.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the implementation of bitmap operations for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/balloc.c | 267 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 267 insertions(+)
 create mode 100644 fs/exfat/balloc.c

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
new file mode 100644
index 000000000000..f2b15b8d1991
--- /dev/null
+++ b/fs/exfat/balloc.c
@@ -0,0 +1,267 @@
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
+	unsigned int count = 0;
+	unsigned int i, map_i, map_b;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	unsigned int total_clus = sbi->num_clusters - 2;
+
+	map_i = map_b = 0;
+
+	for (i = 0; i < total_clus; i += 8) {
+		unsigned char k = *(sbi->vol_amap[map_i]->b_data + map_b);
+
+		count += used_bit[k];
+		if (++map_b >= (unsigned int)sb->s_blocksize) {
+			map_i++;
+			map_b = 0;
+		}
+	}
+
+	/* FIXME : abnormal bitmap count should be handled as more smart */
+	if (total_clus < count)
+		count = total_clus;
+
+	*ret_count = count;
+	return 0;
+}
-- 
2.17.1

