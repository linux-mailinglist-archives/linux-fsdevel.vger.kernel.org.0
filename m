Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3473213BB02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 09:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgAOI3E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 03:29:04 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:37555 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbgAOI22 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:28:28 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200115082824epoutp011cb188dd4716caf678fe4dc192847db4~qAhQWiECd1574615746epoutp01S
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2020 08:28:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200115082824epoutp011cb188dd4716caf678fe4dc192847db4~qAhQWiECd1574615746epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579076904;
        bh=Bv/xH0aMYkb89l0b0dMAtiAEZSaR7Lrj0eVtrzw8YUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b+wrzkcNOCP96o5hdNVn2m0FlO440XvlhRy15DdAoH2Sx3AikRQNOr+K8Xfmhmjvu
         A+jSm2hqE9ChR3S7jgdOZaxCqWha0askjgl5vWf+geMoZi/lCG+CfMm8yMubEbuPw9
         YCX6eXHpEsPQROmRegWfm02+WPN3FYVTr8AWPvJ8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200115082823epcas1p289e1f23beaea9e60c0ed8185f45f5a27~qAhPtwQz-1293712937epcas1p2J;
        Wed, 15 Jan 2020 08:28:23 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.166]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47yL7V5ntRzMqYkg; Wed, 15 Jan
        2020 08:28:22 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.86.48019.62DCE1E5; Wed, 15 Jan 2020 17:28:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200115082822epcas1p37aca37dad0aa9159d7eddde01edfeec2~qAhOSrVnW0883908839epcas1p3T;
        Wed, 15 Jan 2020 08:28:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200115082822epsmtrp22306cdc84af4ecdbcbab0a0b6384ae3a~qAhOR9b-u1143311433epsmtrp2S;
        Wed, 15 Jan 2020 08:28:22 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-75-5e1ecd267c39
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.4A.10238.62DCE1E5; Wed, 15 Jan 2020 17:28:22 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200115082822epsmtip154363f7b87997ab99d8f61a9bb7a4f68~qAhODZAGp0110101101epsmtip1n;
        Wed, 15 Jan 2020 08:28:22 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, pali.rohar@gmail.com,
        arnd@arndb.de, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v10 06/14] exfat: add fat entry operations
Date:   Wed, 15 Jan 2020 17:24:39 +0900
Message-Id: <20200115082447.19520-7-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200115082447.19520-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdlhTV1ftrFycwdPJOhZ/Jx1jt2hevJ7N
        YuXqo0wW1+/eYrbYs/cki8XlXXPYLH5Mr7eYePo3k8WWf0dYLS69/8DiwOXx+9ckRo+ds+6y
        e+yfu4bdY/fNBjaPvi2rGD0+b5LzOLT9DVsAe1SOTUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7yp
        mYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QeUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XU
        gpScAkODAr3ixNzi0rx0veT8XCtDAwMjU6DKhJyMpfcXMhWsjqr427qaqYHxm1sXIyeHhICJ
        xOOOHrYuRi4OIYEdjBJnVr+Fcj4xSmxcupcJwvnGKHHw70NmmJaje58yQyT2Mkrcev6KFa5l
        8bH/QC0cHGwC2hJ/toiCNIgI2Etsnn2ABaSGWeAgo8SbC3PZQRLCAlYSB5beYAWxWQRUJfae
        fwFm8wrYSNx6t4MJYpu8xOoNB8A2cwrYShzZcpkdZJCEwBE2iZ8tbSwQRS4SD1d2sEPYwhKv
        jm+BsqUkPr/bywZykIRAtcTH/VAfdDBKvPhuC2EbS9xcv4EVpIRZQFNi/S59iLCixM7fcxlB
        bGYBPol3X3tYIabwSnS0CUGUqEr0XToMdaW0RFf7B6ilHhKbjh1ihATJBEaJzV9usUxglJuF
        sGEBI+MqRrHUguLc9NRiwwIT5BjbxAhOf1oWOxj3nPM5xCjAwajEw6twRzZOiDWxrLgy9xCj
        BAezkgjvyRlAId6UxMqq1KL8+KLSnNTiQ4ymwICcyCwlmpwPTM15JfGGpkbGxsYWJmbmZqbG
        SuK8rgvk4oQE0hNLUrNTUwtSi2D6mDg4pRoY23dMS2hs/X9xpoIkl/A514Vz5K7qB7wrPCyz
        fdKDDRc3zNtzRaHxSYBZmXmLexjn/RvGaZHmkpnR98M/3Q3pv7/54s+LvxuVZtw7pBHEr1V+
        OCEwyz7y0sq/jD1nLmirvV/fGJk7hcNpWsuO3kCWrtxvT5YVmr5et0lacslbRu0Y+ZkHORql
        lViKMxINtZiLihMBMumn5JUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsWy7bCSnK7aWbk4g947whZ/Jx1jt2hevJ7N
        YuXqo0wW1+/eYrbYs/cki8XlXXPYLH5Mr7eYePo3k8WWf0dYLS69/8DiwOXx+9ckRo+ds+6y
        e+yfu4bdY/fNBjaPvi2rGD0+b5LzOLT9DVsAexSXTUpqTmZZapG+XQJXxtL7C5kKVkdV/G1d
        zdTA+M2ti5GTQ0LAROLo3qfMXYxcHEICuxklmr5vY4ZISEscO3EGyOYAsoUlDh8uBgkLCXxg
        lNhxmg0kzCagLfFniyhIWETAUaJ312EWkDHMAqcZJbo3PmQCSQgLWEkcWHqDFcRmEVCV2Hv+
        BZjNK2AjcevdDiaIVfISqzccAFvLKWArcWTLZXaIXTYS056cZJrAyLeAkWEVo2RqQXFuem6x
        YYFhXmq5XnFibnFpXrpecn7uJkZwiGpp7mC8vCT+EKMAB6MSD6/CHdk4IdbEsuLK3EOMEhzM
        SiK8J2cAhXhTEiurUovy44tKc1KLDzFKc7AoifM+zTsWKSSQnliSmp2aWpBaBJNl4uCUamBM
        yfOfkVNwwejpp/8JvOaFZ0oEW30uKzw9qvGi2nHfNqW0KsbzqXIvZm15qGj7jF+JP3rj7YL5
        AcplCy953FGvTWHar3jIS7DH7ttvedXy6oU2jBaHTGdnLpjvWB1oMH3K9tzZM2yEvnRMao00
        tBW1cnyb0u9/TqHzocxUzVNdj3S/Nv3+UanEUpyRaKjFXFScCADYNyFSTQIAAA==
X-CMS-MailID: 20200115082822epcas1p37aca37dad0aa9159d7eddde01edfeec2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200115082822epcas1p37aca37dad0aa9159d7eddde01edfeec2
References: <20200115082447.19520-1-namjae.jeon@samsung.com>
        <CGME20200115082822epcas1p37aca37dad0aa9159d7eddde01edfeec2@epcas1p3.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the implementation of fat entry operations for exfat.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/fatent.c | 463 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 463 insertions(+)
 create mode 100644 fs/exfat/fatent.c

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
new file mode 100644
index 000000000000..a855b1769a96
--- /dev/null
+++ b/fs/exfat/fatent.c
@@ -0,0 +1,463 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/slab.h>
+#include <asm/unaligned.h>
+#include <linux/buffer_head.h>
+
+#include "exfat_raw.h"
+#include "exfat_fs.h"
+
+static int exfat_mirror_bh(struct super_block *sb, sector_t sec,
+		struct buffer_head *bh)
+{
+	struct buffer_head *c_bh;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	sector_t sec2;
+	int err = 0;
+
+	if (sbi->FAT2_start_sector != sbi->FAT1_start_sector) {
+		sec2 = sec - sbi->FAT1_start_sector + sbi->FAT2_start_sector;
+		c_bh = sb_getblk(sb, sec2);
+		if (!c_bh)
+			return -ENOMEM;
+		memcpy(c_bh->b_data, bh->b_data, sb->s_blocksize);
+		set_buffer_uptodate(c_bh);
+		mark_buffer_dirty(c_bh);
+		if (sb->s_flags & SB_SYNCHRONOUS)
+			err = sync_dirty_buffer(c_bh);
+		brelse(c_bh);
+	}
+
+	return err;
+}
+
+static int __exfat_ent_get(struct super_block *sb, unsigned int loc,
+		unsigned int *content)
+{
+	unsigned int off;
+	sector_t sec;
+	struct buffer_head *bh;
+
+	sec = FAT_ENT_OFFSET_SECTOR(sb, loc);
+	off = FAT_ENT_OFFSET_BYTE_IN_SECTOR(sb, loc);
+
+	bh = sb_bread(sb, sec);
+	if (!bh)
+		return -EIO;
+
+	*content = le32_to_cpu(*(__le32 *)(&bh->b_data[off]));
+
+	/* remap reserved clusters to simplify code */
+	if (*content > EXFAT_BAD_CLUSTER)
+		*content = EXFAT_EOF_CLUSTER;
+
+	brelse(bh);
+	return 0;
+}
+
+int exfat_ent_set(struct super_block *sb, unsigned int loc,
+		unsigned int content)
+{
+	unsigned int off;
+	sector_t sec;
+	__le32 *fat_entry;
+	struct buffer_head *bh;
+
+	sec = FAT_ENT_OFFSET_SECTOR(sb, loc);
+	off = FAT_ENT_OFFSET_BYTE_IN_SECTOR(sb, loc);
+
+	bh = sb_bread(sb, sec);
+	if (!bh)
+		return -EIO;
+
+	fat_entry = (__le32 *)&(bh->b_data[off]);
+	*fat_entry = cpu_to_le32(content);
+	exfat_update_bh(sb, bh, sb->s_flags & SB_SYNCHRONOUS);
+	exfat_mirror_bh(sb, sec, bh);
+	brelse(bh);
+	return 0;
+}
+
+static inline bool is_valid_cluster(struct exfat_sb_info *sbi,
+		unsigned int clus)
+{
+	if (clus < EXFAT_FIRST_CLUSTER || sbi->num_clusters <= clus)
+		return false;
+	return true;
+}
+
+int exfat_ent_get(struct super_block *sb, unsigned int loc,
+		unsigned int *content)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	int err;
+
+	if (!is_valid_cluster(sbi, loc)) {
+		exfat_fs_error(sb, "invalid access to FAT (entry 0x%08x)",
+			loc);
+		return -EIO;
+	}
+
+	err = __exfat_ent_get(sb, loc, content);
+	if (err) {
+		exfat_fs_error(sb,
+			"failed to access to FAT (entry 0x%08x, err:%d)",
+			loc, err);
+		return err;
+	}
+
+	if (*content == EXFAT_FREE_CLUSTER) {
+		exfat_fs_error(sb,
+			"invalid access to FAT free cluster (entry 0x%08x)",
+			loc);
+		return -EIO;
+	}
+
+	if (*content == EXFAT_BAD_CLUSTER) {
+		exfat_fs_error(sb,
+			"invalid access to FAT bad cluster (entry 0x%08x)",
+			loc);
+		return -EIO;
+	}
+
+	if (*content != EXFAT_EOF_CLUSTER && !is_valid_cluster(sbi, *content)) {
+		exfat_fs_error(sb,
+			"invalid access to FAT (entry 0x%08x) bogus content (0x%08x)",
+			loc, *content);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int exfat_chain_cont_cluster(struct super_block *sb, unsigned int chain,
+		unsigned int len)
+{
+	if (!len)
+		return 0;
+
+	while (len > 1) {
+		if (exfat_ent_set(sb, chain, chain + 1))
+			return -EIO;
+		chain++;
+		len--;
+	}
+
+	if (exfat_ent_set(sb, chain, EXFAT_EOF_CLUSTER))
+		return -EIO;
+	return 0;
+}
+
+int exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain)
+{
+	unsigned int num_clusters = 0;
+	unsigned int clu;
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+
+	/* invalid cluster number */
+	if (p_chain->dir == EXFAT_FREE_CLUSTER ||
+	    p_chain->dir == EXFAT_EOF_CLUSTER ||
+	    p_chain->dir < EXFAT_FIRST_CLUSTER)
+		return 0;
+
+	/* no cluster to truncate */
+	if (p_chain->size == 0)
+		return 0;
+
+	/* check cluster validation */
+	if (p_chain->dir < 2 && p_chain->dir >= sbi->num_clusters) {
+		exfat_msg(sb, KERN_ERR, "invalid start cluster (%u)",
+				p_chain->dir);
+		return -EIO;
+	}
+
+	set_bit(EXFAT_SB_DIRTY, &sbi->s_state);
+	clu = p_chain->dir;
+
+	if (p_chain->flags == ALLOC_NO_FAT_CHAIN) {
+		do {
+			exfat_clear_bitmap(inode, clu);
+			clu++;
+
+			num_clusters++;
+		} while (num_clusters < p_chain->size);
+	} else {
+		do {
+			exfat_clear_bitmap(inode, clu);
+
+			if (exfat_get_next_cluster(sb, &clu))
+				goto dec_used_clus;
+
+			num_clusters++;
+		} while (clu != EXFAT_EOF_CLUSTER);
+	}
+
+dec_used_clus:
+	sbi->used_clusters -= num_clusters;
+	return 0;
+}
+
+int exfat_find_last_cluster(struct super_block *sb, struct exfat_chain *p_chain,
+		unsigned int *ret_clu)
+{
+	unsigned int clu, next;
+	unsigned int count = 0;
+
+	next = p_chain->dir;
+	if (p_chain->flags == ALLOC_NO_FAT_CHAIN) {
+		*ret_clu = next + p_chain->size - 1;
+		return 0;
+	}
+
+	do {
+		count++;
+		clu = next;
+		if (exfat_ent_get(sb, clu, &next))
+			return -EIO;
+	} while (next != EXFAT_EOF_CLUSTER);
+
+	if (p_chain->size != count) {
+		exfat_fs_error(sb,
+			"bogus directory size (clus : ondisk(%d) != counted(%d))",
+			p_chain->size, count);
+		return -EIO;
+	}
+
+	*ret_clu = clu;
+	return 0;
+}
+
+static inline int exfat_sync_bhs(struct buffer_head **bhs, int nr_bhs)
+{
+	int i, err = 0;
+
+	for (i = 0; i < nr_bhs; i++)
+		write_dirty_buffer(bhs[i], 0);
+
+	for (i = 0; i < nr_bhs; i++) {
+		wait_on_buffer(bhs[i]);
+		if (!err && !buffer_uptodate(bhs[i]))
+			err = -EIO;
+	}
+	return err;
+}
+
+int exfat_zeroed_cluster(struct inode *dir, unsigned int clu)
+{
+	struct super_block *sb = dir->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct buffer_head *bhs[MAX_BUF_PER_PAGE];
+	int nr_bhs = MAX_BUF_PER_PAGE;
+	sector_t blknr, last_blknr;
+	int err, i, n;
+
+	blknr = exfat_cluster_to_sector(sbi, clu);
+	last_blknr = blknr + sbi->sect_per_clus;
+
+	if (last_blknr > sbi->num_sectors && sbi->num_sectors > 0) {
+		exfat_fs_error_ratelimit(sb,
+			"%s: out of range(sect:%llu len:%u)",
+			__func__, (unsigned long long)blknr,
+			sbi->sect_per_clus);
+		return -EIO;
+	}
+
+	/* Zeroing the unused blocks on this cluster */
+	n = 0;
+	while (blknr < last_blknr) {
+		bhs[n] = sb_getblk(sb, blknr);
+		if (!bhs[n]) {
+			err = -ENOMEM;
+			goto release_bhs;
+		}
+		memset(bhs[n]->b_data, 0, sb->s_blocksize);
+		exfat_update_bh(sb, bhs[n], 0);
+
+		n++;
+		blknr++;
+
+		if (n == nr_bhs) {
+			if (IS_DIRSYNC(dir)) {
+				err = exfat_sync_bhs(bhs, n);
+				if (err)
+					goto release_bhs;
+			}
+
+			for (i = 0; i < n; i++)
+				brelse(bhs[i]);
+			n = 0;
+		}
+	}
+
+	if (IS_DIRSYNC(dir)) {
+		err = exfat_sync_bhs(bhs, n);
+		if (err)
+			goto release_bhs;
+	}
+
+	for (i = 0; i < n; i++)
+		brelse(bhs[i]);
+
+	return 0;
+
+release_bhs:
+	exfat_msg(sb, KERN_ERR, "failed zeroed sect %llu\n",
+		(unsigned long long)blknr);
+	for (i = 0; i < n; i++)
+		bforget(bhs[i]);
+	return err;
+}
+
+int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
+		struct exfat_chain *p_chain)
+{
+	int ret = -ENOSPC;
+	unsigned int num_clusters = 0, total_cnt;
+	unsigned int hint_clu, new_clu, last_clu = EXFAT_EOF_CLUSTER;
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+
+	total_cnt = EXFAT_DATA_CLUSTER_COUNT(sbi);
+
+	if (unlikely(total_cnt < sbi->used_clusters)) {
+		exfat_fs_error_ratelimit(sb,
+			"%s: invalid used clusters(t:%u,u:%u)\n",
+			__func__, total_cnt, sbi->used_clusters);
+		return -EIO;
+	}
+
+	if (num_alloc > total_cnt - sbi->used_clusters)
+		return -ENOSPC;
+
+	hint_clu = p_chain->dir;
+	/* find new cluster */
+	if (hint_clu == EXFAT_EOF_CLUSTER) {
+		if (sbi->clu_srch_ptr < EXFAT_FIRST_CLUSTER) {
+			exfat_msg(sb, KERN_ERR,
+				"sbi->clu_srch_ptr is invalid (%u)\n",
+				sbi->clu_srch_ptr);
+			sbi->clu_srch_ptr = EXFAT_FIRST_CLUSTER;
+		}
+
+		hint_clu = exfat_find_free_bitmap(sb, sbi->clu_srch_ptr);
+		if (hint_clu == EXFAT_EOF_CLUSTER)
+			return -ENOSPC;
+	}
+
+	/* check cluster validation */
+	if (hint_clu < EXFAT_FIRST_CLUSTER && hint_clu >= sbi->num_clusters) {
+		exfat_msg(sb, KERN_ERR, "hint_cluster is invalid (%u)\n",
+			hint_clu);
+		hint_clu = EXFAT_FIRST_CLUSTER;
+		if (p_chain->flags == ALLOC_NO_FAT_CHAIN) {
+			if (exfat_chain_cont_cluster(sb, p_chain->dir,
+					num_clusters))
+				return -EIO;
+			p_chain->flags = ALLOC_FAT_CHAIN;
+		}
+	}
+
+	set_bit(EXFAT_SB_DIRTY, &sbi->s_state);
+
+	p_chain->dir = EXFAT_EOF_CLUSTER;
+
+	while ((new_clu = exfat_find_free_bitmap(sb, hint_clu)) !=
+	       EXFAT_EOF_CLUSTER) {
+		if (new_clu != hint_clu &&
+		    p_chain->flags == ALLOC_NO_FAT_CHAIN) {
+			if (exfat_chain_cont_cluster(sb, p_chain->dir,
+					num_clusters)) {
+				ret = -EIO;
+				goto free_cluster;
+			}
+			p_chain->flags = ALLOC_FAT_CHAIN;
+		}
+
+		/* update allocation bitmap */
+		if (exfat_set_bitmap(inode, new_clu)) {
+			ret = -EIO;
+			goto free_cluster;
+		}
+
+		num_clusters++;
+
+		/* update FAT table */
+		if (p_chain->flags == ALLOC_FAT_CHAIN) {
+			if (exfat_ent_set(sb, new_clu, EXFAT_EOF_CLUSTER)) {
+				ret = -EIO;
+				goto free_cluster;
+			}
+		}
+
+		if (p_chain->dir == EXFAT_EOF_CLUSTER) {
+			p_chain->dir = new_clu;
+		} else if (p_chain->flags == ALLOC_FAT_CHAIN) {
+			if (exfat_ent_set(sb, last_clu, new_clu)) {
+				ret = -EIO;
+				goto free_cluster;
+			}
+		}
+		last_clu = new_clu;
+
+		if (--num_alloc == 0) {
+			sbi->clu_srch_ptr = hint_clu;
+			sbi->used_clusters += num_clusters;
+
+			p_chain->size += num_clusters;
+			return 0;
+		}
+
+		hint_clu = new_clu + 1;
+		if (hint_clu >= sbi->num_clusters) {
+			hint_clu = EXFAT_FIRST_CLUSTER;
+
+			if (p_chain->flags == ALLOC_NO_FAT_CHAIN) {
+				if (exfat_chain_cont_cluster(sb, p_chain->dir,
+						num_clusters)) {
+					ret = -EIO;
+					goto free_cluster;
+				}
+				p_chain->flags = ALLOC_FAT_CHAIN;
+			}
+		}
+	}
+free_cluster:
+	if (num_clusters)
+		exfat_free_cluster(inode, p_chain);
+	return ret;
+}
+
+int exfat_count_num_clusters(struct super_block *sb,
+		struct exfat_chain *p_chain, unsigned int *ret_count)
+{
+	unsigned int i, count;
+	unsigned int clu;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+
+	if (!p_chain->dir || p_chain->dir == EXFAT_EOF_CLUSTER) {
+		*ret_count = 0;
+		return 0;
+	}
+
+	if (p_chain->flags == ALLOC_NO_FAT_CHAIN) {
+		*ret_count = p_chain->size;
+		return 0;
+	}
+
+	clu = p_chain->dir;
+	count = 0;
+	for (i = EXFAT_FIRST_CLUSTER; i < sbi->num_clusters; i++) {
+		count++;
+		if (exfat_ent_get(sb, clu, &clu))
+			return -EIO;
+		if (clu == EXFAT_EOF_CLUSTER)
+			break;
+	}
+
+	*ret_count = count;
+	return 0;
+}
-- 
2.17.1

