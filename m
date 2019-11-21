Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0CE104A2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 06:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfKUF3a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 00:29:30 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:62454 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfKUF32 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 00:29:28 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191121052921epoutp014abd216293324fea0d790cf0a11436ec~ZFmODSAhU1241312413epoutp01f
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2019 05:29:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191121052921epoutp014abd216293324fea0d790cf0a11436ec~ZFmODSAhU1241312413epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574314161;
        bh=RtpjVDaWLsFj//FQ3s03FyYysJjApJaPpaoU1aZx3WI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=INABp1vUla0z4PQgmJEPa/zVCbt9GWDdyDjrv+/s91HnjrBZU9DSJXNyYWDr/4EcQ
         bHlrwkTh/LCq6ZZdbqs9LEjW0ZZW5SPYjnDRGTXxf3Tm6dKZHo0DvyZaujOxYRqP2S
         xMqtanwM/l7NrdAQHj+JemjhrBsLQEye3wnWap6c=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191121052920epcas1p4e72a456ebf4196c734a8540e56c16022~ZFmNgNh7m1333513335epcas1p4V;
        Thu, 21 Nov 2019 05:29:20 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.160]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47JSmH50h3zMqYkw; Thu, 21 Nov
        2019 05:29:19 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        79.E7.04235.FA026DD5; Thu, 21 Nov 2019 14:29:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191121052918epcas1p31b6aa77d4642ea390e8390bc782d590e~ZFmLpWCLc3089030890epcas1p30;
        Thu, 21 Nov 2019 05:29:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191121052918epsmtrp1ba3863cc540c4da35058b6e63e5e7269~ZFmLokt5R1320813208epsmtrp10;
        Thu, 21 Nov 2019 05:29:18 +0000 (GMT)
X-AuditID: b6c32a36-e07ff7000000108b-2a-5dd620afa816
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.06.03654.EA026DD5; Thu, 21 Nov 2019 14:29:18 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191121052918epsmtip1a75e800f0d638debaeb735f95b07292d~ZFmLbZETR1143211432epsmtip1v;
        Thu, 21 Nov 2019 05:29:18 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de, nborisov@suse.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v4 07/13] exfat: add bitmap operations
Date:   Thu, 21 Nov 2019 00:26:12 -0500
Message-Id: <20191121052618.31117-8-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121052618.31117-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm85ydHa3FYWp9GNo6IWmy2sXNU7gSGnEgQcMfQSB20JOTdmNn
        hhaUYqXONJWyssJSgrzQvAwz0yzXhUosbw21C5HMLtMyqSxF23bs8u95n+953+fh/V4cEZdh
        YXiW0cpajIyexILQdme0VGqXvEiVnbggpJzvKoVUQZ0do+obHwRQrldjCNXV/RilhjovYdRS
        9aSAmjt3jFryHEcpx+J9ATX4+QuasIK+Vf1KSPdcbhLSt0fzMLrM0QBou2MEpdueHqFnWyPo
        3psejB53t6PJgfv08TqWyWAtEtaYbsrIMmZqyN0paTvTVGqZXCrfSsWREiNjYDWkNjFZuitL
        7w1LSg4x+mwvlcxwHLlle7zFlG1lJToTZ9WQrDlDb5bLzJs5xsBlGzM3p5sM2+QymULlVe7X
        6ybbRoTmUm1Oe8M9YR7oU9pAIA6JWPjzqhOxgSBcTHQAWFnlwfjiK4Afx4oBX3wHcNZm88pw
        f8vAqJTnuwF09eWjfzuaqpaAT4QRMXDBEeqzCCF2wLaLd/0ahHAB6B47L/A9BBNqWLl4xo9R
        IhK6HndgPiwi4uHDum7A51sHG5vv+o0DCQ18M5/rmwOJcQzWjD9b1mjh5AO3kMfB8OMjxzIO
        gx9OnxTyoY/AmR6Ep4sAfP9Dw2MlHLU3C3wShIiG9s4tPL0e3pq/7J+OEKvg9LdTAn6KCBad
        FPOSSFg26Azg8VpoK/yybErD4vO1yzssB7DEU4OWg4jqfw5XAGgAq1kzZ8hkOblZ8f9/tQL/
        LW5Sd4Da/sReQOCAXCnSRY2kigXMIS7X0AsgjpAhoi7XcKpYlMHkHmYtpjRLtp7leoHKu8cK
        JCw03eS9bKM1Ta5SKJVKKlYdp1YpyTUifG4gVUxkMlb2IMuaWcufvgA8MCwPhHtiTh/4PnNt
        oqWMcoe/LNbE5lSkjE3lb5g/Wj+48dnzPQGv051aVWFJgfoXrQhxr6syn82p6U8c6Wv+ecdu
        y6tNGmh5Oxv9ZOt1xpTQr1VwCuWNDtnu4alr6qjRT+WVZHA9W5LgjFm1V7V0HRdMD/fHXhgq
        Da2YOBa+EJ2UJCZRTsfINyEWjvkND6DwK6EDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsWy7bCSnO46hWuxBtMWalkcfjyJ3aJ58Xo2
        i5WrjzJZXL97i9liz96TLBaXd81hs/g/6zmrxY/p9Rb/37SwWGz5d4TV4tL7DywO3B47Z91l
        99g/dw27x+6bDWwefVtWMXqs33KVxWPz6WqPz5vkPA5tf8PmcfvZNpYAzigum5TUnMyy1CJ9
        uwSujOebr7IX9LpUbFt1kL2B8YxxFyMHh4SAicTFm7pdjFwcQgK7GSWuX//N2sXICRSXljh2
        4gwzRI2wxOHDxRA1HxglNk56BxZnE9CW+LNFFKRcRMBRonfXYRaQGmaBx4wSJ84/YQRJCAuY
        SUz6NwVsJouAqsT1kzvYQGxeARuJY4v3MkLskpdYveEA2ExOAVuJ+78rQcJCQCVXT7xgncDI
        t4CRYRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnDwamnuYLy8JP4QowAHoxIPb4bG
        1Vgh1sSy4srcQ4wSHMxKIrx7rl+JFeJNSaysSi3Kjy8qzUktPsQozcGiJM77NO9YpJBAemJJ
        anZqakFqEUyWiYNTqoHRbb1z06so4b+HNv5O6Q3nnbTvxZys9OsTJxRvtp2v3uxkH/T3/MR3
        lgz8i0wsD31nKXRo1bO0faMxf+OOWbHRjdKNxxJXrlbRnPdFkvPt7YrCxCmVJRqqyvOWPHzw
        Z5qQapHIoWUrBPNnnXD0d3v54NEtl4BHVQePrpr7ISikRLKzxoFj+ocPSizFGYmGWsxFxYkA
        9C6WnVoCAAA=
X-CMS-MailID: 20191121052918epcas1p31b6aa77d4642ea390e8390bc782d590e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191121052918epcas1p31b6aa77d4642ea390e8390bc782d590e
References: <20191121052618.31117-1-namjae.jeon@samsung.com>
        <CGME20191121052918epcas1p31b6aa77d4642ea390e8390bc782d590e@epcas1p3.samsung.com>
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
index 000000000000..6a8d88db4a0e
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
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct buffer_head *bh;
+
+	exfat_chain_set(&clu, sbi->root_dir, 0, ALLOC_FAT_CHAIN);
+
+	while (clu.dir != EOF_CLUSTER) {
+		for (i = 0; i < sbi->dentries_per_clu; i++) {
+			struct exfat_dentry *ep;
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

