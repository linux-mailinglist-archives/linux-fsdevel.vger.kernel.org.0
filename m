Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAA111DE05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 06:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732202AbfLMFyM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 00:54:12 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:21453 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732119AbfLMFxs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 00:53:48 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191213055344epoutp0394546a7cbf88fc393e662b0cbb870502~f2HygbWtU1401114011epoutp03o
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2019 05:53:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191213055344epoutp0394546a7cbf88fc393e662b0cbb870502~f2HygbWtU1401114011epoutp03o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576216424;
        bh=BJvju5QhWjtb2eYhKreE08SNPSJhtLs4tuCV9yV5sBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iAfrc4YoZFAaMh765I5QVvcOrA7YNzBjtRH0X3lQCLDe859KtDwsfmzPlwKprEo1K
         Ypi32xVts2U3DZs7r26vlJ8ZhaQRVFRm8/5bwNtwtCCBYqC6CCv6O8Syiu6xAW2AKP
         klHFhBrmww4vdeCwXIDLByACYuMmKPFxTy5/kaIw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191213055343epcas1p3305bf850f75a52e337b79f03e92d7aad~f2HyFhyzT0380703807epcas1p32;
        Fri, 13 Dec 2019 05:53:43 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.163]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47Z0GF5QC0zMqYks; Fri, 13 Dec
        2019 05:53:41 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.EB.48498.56723FD5; Fri, 13 Dec 2019 14:53:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191213055341epcas1p4340dae4923a8e512326f7be75a4426e1~f2HvrdrGc0641506415epcas1p4a;
        Fri, 13 Dec 2019 05:53:41 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191213055341epsmtrp1fb758644ee80ba4bd10bc1abdc25566b~f2HvqJv270541405414epsmtrp1M;
        Fri, 13 Dec 2019 05:53:41 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-ee-5df32765217c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.92.06569.56723FD5; Fri, 13 Dec 2019 14:53:41 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191213055341epsmtip2e985286e1b972166ecf9e0bc6c92b08f~f2HvcjOyO1077310773epsmtip2Q;
        Fri, 13 Dec 2019 05:53:41 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v7 06/13] exfat: add exfat entry operations
Date:   Fri, 13 Dec 2019 00:50:21 -0500
Message-Id: <20191213055028.5574-7-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191213055028.5574-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7bCmgW6q+udYg6MrdSyaF69ns1i5+iiT
        xZ69J1ksLu+aw2bxY3q9xZZ/R1gtLr3/wOLA7rF/7hp2j903G9g8+rasYvT4vEnO49D2N2wB
        rFE5NhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAVygp
        lCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCgwNCvSKE3OLS/PS9ZLzc60MDQyMTIEq
        E3Iy+padZCr4G10x8dgu9gbGeR5djJwcEgImEkfbrjB2MXJxCAnsYJTY+mAbO4TziVFi0YcW
        JgjnG6PEl+0zWWFaZkxZBNWyl1HixrI2NriWIw+2ArVwcLAJaEv82SIK0iAiYC+xefYBFpAa
        ZoEWRokFp38wgySEBawldvTfZAOpZxFQlbjyPAIkzAsU/rH4LNQyeYnVGw6AlXMK2EjMm/wB
        7DwJgTlsEn9/dbOD9EoIuEhsWcIMUS8s8er4FnYIW0riZX8bVEm1xMf9UCUdjBIvvttC2MYS
        N9dvYAUpYRbQlFi/Sx8irCix8/dcRhCbWYBP4t3XHlaIKbwSHW1CECWqEn2XDjNB2NISXe0f
        oBZ5SCy6FwkJj35GiaWf57FMYJSbhbBgASPjKkax1ILi3PTUYsMCI+To2sQITmNaZjsYF53z
        OcQowMGoxMPLkPIpVog1say4MvcQowQHs5IIr30NUIg3JbGyKrUoP76oNCe1+BCjKTAUJzJL
        iSbnA1NsXkm8oamRsbGxhYmZuZmpsZI4L8ePi7FCAumJJanZqakFqUUwfUwcnFINjMrPeDOf
        /e1Ru3dh+eeLwSf2OM39rbNXO8z2errGiZ0+nf9bJ+pYWc36q268503+3d2vOYvvfTJec+vQ
        qXsMq08f3xeT/srIp0r7XYhDeKbRtqV/02bb2rx2a7607MWjOXdn1fU9fWz53HvP2b2+lo+0
        1aVyO+66ioZKvrNoytxVkaf5N2ZN0xclluKMREMt5qLiRACgkA42eQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrILMWRmVeSWpSXmKPExsWy7bCSvG6q+udYg6dbBCyaF69ns1i5+iiT
        xZ69J1ksLu+aw2bxY3q9xZZ/R1gtLr3/wOLA7rF/7hp2j903G9g8+rasYvT4vEnO49D2N2wB
        rFFcNimpOZllqUX6dglcGX3LTjIV/I2umHhsF3sD4zyPLkZODgkBE4kZUxYxdjFycQgJ7GaU
        aO2dzwqRkJY4duIMcxcjB5AtLHH4cDFEzQdGiUfzVjGCxNkEtCX+bBEFKRcRcJTo3XWYBaSG
        WaALqKbpGzNIQljAWmJH/002kHoWAVWJK88jQMK8QOEfi89CrZKXWL3hAFg5p4CNxLzJH9hB
        bCGgmrtvX7FNYORbwMiwilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOOC0tHYwnjgR
        f4hRgINRiYd3ReKnWCHWxLLiytxDjBIczEoivPY1QCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
        8vnHIoUE0hNLUrNTUwtSi2CyTBycUg2MhYc++629PqvQ6k2FpExBXWbBxO829gcq068yXuo9
        xrE/2GXB+hip/jq2ZJPsrZab2Y9qXjFafubv2QPqX0+e8mu/o9/xQ+R1nX4pp+AEpSlfXyoq
        Hu9KmCQtsCkuNTqhIvFD+Fu1qYvWB0t4K20xir3A03WQZ53JY7W2eRKTU26mnw5myU1VYinO
        SDTUYi4qTgQAD2uiijQCAAA=
X-CMS-MailID: 20191213055341epcas1p4340dae4923a8e512326f7be75a4426e1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191213055341epcas1p4340dae4923a8e512326f7be75a4426e1
References: <20191213055028.5574-1-namjae.jeon@samsung.com>
        <CGME20191213055341epcas1p4340dae4923a8e512326f7be75a4426e1@epcas1p4.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the implementation of exfat entry operations for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/fatent.c | 472 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 472 insertions(+)
 create mode 100644 fs/exfat/fatent.c

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
new file mode 100644
index 000000000000..aa688ae4db41
--- /dev/null
+++ b/fs/exfat/fatent.c
@@ -0,0 +1,472 @@
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
+static int __exfat_ent_get(struct super_block *sb, unsigned int loc,
+		unsigned int *content)
+{
+	unsigned int off, _content;
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
+	_content = le32_to_cpu(*(__le32 *)(&bh->b_data[off]));
+
+	/* remap reserved clusters to simplify code */
+	if (_content >= CLUSTER_32(0xFFFFFFF8))
+		_content = EXFAT_EOF_CLUSTER;
+
+	*content = CLUSTER_32(_content);
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
+static inline bool is_reserved_cluster(unsigned int clus)
+{
+	if (clus == EXFAT_FREE_CLUSTER || clus == EXFAT_EOF_CLUSTER ||
+	    clus == EXFAT_BAD_CLUSTER)
+		return true;
+	return false;
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
+	if (!is_reserved_cluster(*content) &&
+			!is_valid_cluster(sbi, *content)) {
+		exfat_fs_error(sb,
+			"invalid access to FAT (entry 0x%08x) bogus content (0x%08x)",
+			loc, *content);
+		return -EIO;
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
+
+int exfat_mirror_bh(struct super_block *sb, sector_t sec,
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
-- 
2.17.1

