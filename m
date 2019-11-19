Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75CC0101A2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 08:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfKSHOM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 02:14:12 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:62576 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbfKSHOK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 02:14:10 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191119071407epoutp02c23649ca9ae5b7e19483431cb6688394~YfvIW8RfB1270812708epoutp02J
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2019 07:14:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191119071407epoutp02c23649ca9ae5b7e19483431cb6688394~YfvIW8RfB1270812708epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574147648;
        bh=moFSjqom8tMKVgnAIE+bliJo2nyGZ77U3BbjnQGWtEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SAZqnBIhNh7K3LceeHn8uobPMA+4GMsC4zAgtlnqWrksIgWsViDX/XiDUIWN4CS1P
         PgmUBVaSnDgnhNLvtNLR17X8nQEySZ5cOnEaDAkVGp/Y8JGrEisML3jtKHktC3NdxS
         NXer8a2uZEyGsLVHgCLsqzoi+ziEZCqE5flmpU54=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191119071407epcas1p2e1051e841f2846887fb7ec1d583ed056~YfvIAoxfE1345313453epcas1p2D;
        Tue, 19 Nov 2019 07:14:07 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.164]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47HHB64SWjzMqYm1; Tue, 19 Nov
        2019 07:14:06 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.6B.04072.D3693DD5; Tue, 19 Nov 2019 16:14:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191119071405epcas1p29e1af8242cce221c45eb529921028e48~YfvFyNF8c1345313453epcas1p28;
        Tue, 19 Nov 2019 07:14:05 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191119071405epsmtrp15d7e934aede522fa7359bee17b85e6fc~YfvFu3eGc3109231092epsmtrp17;
        Tue, 19 Nov 2019 07:14:05 +0000 (GMT)
X-AuditID: b6c32a35-9bdff70000000fe8-a2-5dd3963ddb5d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.84.03814.C3693DD5; Tue, 19 Nov 2019 16:14:05 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191119071404epsmtip121d635b38fbd09398eaf56d236c30020~YfvFfhz3g1281112811epsmtip1b;
        Tue, 19 Nov 2019 07:14:04 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v2 06/13] exfat: add exfat entry operations
Date:   Tue, 19 Nov 2019 02:11:00 -0500
Message-Id: <20191119071107.1947-7-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119071107.1947-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmga7dtMuxBseOqFg0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBb/Zz1ntfgxvd5iy78jrBaX3n9gceD02DnrLrvH/rlr2D1232xg
        8+jbsorR4/MmOY9D29+wedx+to0lgD0qxyYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ
        0sJcSSEvMTfVVsnFJ0DXLTMH6DIlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToGh
        QYFecWJucWleul5yfq6VoYGBkSlQZUJOxq0lpgVNURXH/55hamDscOti5OCQEDCROLvWtIuR
        i0NIYAejxOrvWxghnE+MEvuXH2GHcL4xSvSu/AiU4QTruHj6ClRiL6PExH3PEFp2NTYwgcxl
        E9CW+LNFFKRBRMBeYvPsAywgNcwCmxklHm5aygKSEBawltj17hjYVBYBVYnn26eD2bxA8aUX
        v7BDbJOXWL3hADOIzSlgI9E/7ztUfAebxLEWCQjbRWLT1lMsELawxKvjW6BqpCRe9rexQ/xZ
        LfFxPzNEuINR4sV3WwjbWOLm+g2sICXMApoS63fpQ4QVJXb+ngt2DbMAn8S7rz2sEFN4JTra
        hCBKVCX6Lh1mgrClJbraP0At9ZA4OXs6GyRE+hkl5j7uYZ/AKDcLYcMCRsZVjGKpBcW56anF
        hgWGyNG1iRGc7rRMdzBOOedziFGAg1GJh1dB/XKsEGtiWXFl7iFGCQ5mJRFev0cXYoV4UxIr
        q1KL8uOLSnNSiw8xmgLDcSKzlGhyPjAV55XEG5oaGRsbW5iYmZuZGiuJ83L8uBgrJJCeWJKa
        nZpakFoE08fEwSnVwCgoeHphVv8TNh3Gf737jPbaPLhiobgySqdu3m7ht8lNu40uN7EL6F5m
        9Jv6WdTrjPXcwrnb3gbuf8tjfv5Nfa6AhVqESNMd1bV9EmdCZrvv5d4jsXmO0BGF9nt1POxN
        AUdvLX9z4s5GsYfKcvkrlnEYOYq6Oe/KaBObHMeRs/bencnOS545zFZiKc5INNRiLipOBABu
        o3XdjQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWy7bCSnK7ttMuxBtefs1g0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBb/Zz1ntfgxvd5iy78jrBaX3n9gceD02DnrLrvH/rlr2D1232xg
        8+jbsorR4/MmOY9D29+wedx+to0lgD2KyyYlNSezLLVI3y6BK+PWEtOCpqiK43/PMDUwdrh1
        MXJySAiYSFw8fYW9i5GLQ0hgN6PEpC8PWSAS0hLHTpxh7mLkALKFJQ4fLoao+cAocfrUZyaQ
        OJuAtsSfLaIg5SICjhK9uw6zgNQwg8zZMv0XI0hCWMBaYte7Y2A2i4CqxPPt08FsXqD40otf
        2CF2yUus3nCAGcTmFLCR6J/3HSwuBFSzedES1gmMfAsYGVYxSqYWFOem5xYbFhjlpZbrFSfm
        Fpfmpesl5+duYgQHppbWDsYTJ+IPMQpwMCrx8J5QuRwrxJpYVlyZe4hRgoNZSYTX79GFWCHe
        lMTKqtSi/Pii0pzU4kOM0hwsSuK88vnHIoUE0hNLUrNTUwtSi2CyTBycUg2MbaeXSLCtvfns
        0qzrD5JjfAVME1Z+uZ799kd51hRRHZHqu+sY3xeGbV+54rNB3YXT395f3F4n13dRWkhq38yi
        3W5xl7ymmTVdK9D5klV8hV/UykjsiV2PEouETddTz/1PvgosYv3k1c8eLmz2KT1IYmqHe6OX
        59aD0W4HHda8sEutKdz1UM5BiaU4I9FQi7moOBEAne5BCUgCAAA=
X-CMS-MailID: 20191119071405epcas1p29e1af8242cce221c45eb529921028e48
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191119071405epcas1p29e1af8242cce221c45eb529921028e48
References: <20191119071107.1947-1-namjae.jeon@samsung.com>
        <CGME20191119071405epcas1p29e1af8242cce221c45eb529921028e48@epcas1p2.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the implementation of exfat entry operations for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/fatent.c | 475 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 475 insertions(+)
 create mode 100644 fs/exfat/fatent.c

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
new file mode 100644
index 000000000000..006c513ae5c0
--- /dev/null
+++ b/fs/exfat/fatent.c
@@ -0,0 +1,475 @@
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
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct buffer_head *bh;
+
+	sec = sbi->FAT1_start_sector + (loc >> (sb->s_blocksize_bits-2));
+	off = (loc << 2) & (sb->s_blocksize - 1);
+
+	bh = sb_bread(sb, sec);
+	if (!bh)
+		return -EIO;
+
+	_content = le32_to_cpu(*(__le32 *)(&bh->b_data[off]));
+
+	/* remap reserved clusters to simplify code */
+	if (_content >= CLUSTER_32(0xFFFFFFF8))
+		_content = EOF_CLUSTER;
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
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct buffer_head *bh;
+
+	sec = sbi->FAT1_start_sector + (loc >> (sb->s_blocksize_bits-2));
+	off = (loc << 2) & (sb->s_blocksize - 1);
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
+	if (clus == FREE_CLUSTER || clus == EOF_CLUSTER || clus == BAD_CLUSTER)
+		return true;
+	return false;
+}
+
+static inline bool is_valid_cluster(struct exfat_sb_info *sbi,
+		unsigned int clus)
+{
+	if (clus < BASE_CLUSTER || sbi->num_clusters <= clus)
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
+	if (*content == FREE_CLUSTER) {
+		exfat_fs_error(sb,
+			"invalid access to FAT free cluster (entry 0x%08x)",
+			loc);
+		return -EIO;
+	}
+
+	if (*content == BAD_CLUSTER) {
+		exfat_fs_error(sb,
+			"invalid access to FAT bad cluster (entry 0x%08x)",
+			loc);
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
+	if (exfat_ent_set(sb, chain, EOF_CLUSTER))
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
+	if (p_chain->dir == FREE_CLUSTER || p_chain->dir == EOF_CLUSTER)
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
+	WRITE_ONCE(sbi->s_dirt, true);
+	clu = p_chain->dir;
+
+	if (p_chain->flags == 0x03) {
+		do {
+			exfat_clear_bitmap(inode, clu-2);
+			clu++;
+
+			num_clusters++;
+		} while (num_clusters < p_chain->size);
+	} else {
+		do {
+			exfat_clear_bitmap(inode, (clu - BASE_CLUSTER));
+
+			if (exfat_get_next_cluster(sb, &clu))
+				goto out;
+
+			num_clusters++;
+		} while (clu != EOF_CLUSTER);
+	}
+
+out:
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
+	if (p_chain->flags == 0x03) {
+		*ret_clu = next + p_chain->size - 1;
+		return 0;
+	}
+
+	do {
+		count++;
+		clu = next;
+		if (exfat_ent_get(sb, clu, &next))
+			return -EIO;
+	} while (next != EOF_CLUSTER);
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
+			goto error;
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
+					goto error;
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
+			goto error;
+	}
+
+	for (i = 0; i < n; i++)
+		brelse(bhs[i]);
+
+	return 0;
+
+error:
+	exfat_msg(sb, KERN_ERR, "failed zeroed sect %llu\n",
+		(unsigned long long)blknr);
+	for (i = 0; i < n; i++)
+		bforget(bhs[i]);
+
+	return err;
+}
+
+int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
+		struct exfat_chain *p_chain)
+{
+	int ret = -ENOSPC;
+	unsigned int num_clusters = 0, total_cnt;
+	unsigned int hint_clu, new_clu, last_clu = EOF_CLUSTER;
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+
+	total_cnt = sbi->num_clusters - BASE_CLUSTER;
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
+	if (hint_clu == EOF_CLUSTER) {
+		if (sbi->clu_srch_ptr < BASE_CLUSTER) {
+			exfat_msg(sb, KERN_ERR,
+				"sbi->clu_srch_ptr is invalid (%u)\n",
+				sbi->clu_srch_ptr);
+			sbi->clu_srch_ptr = BASE_CLUSTER;
+		}
+
+		hint_clu = exfat_test_bitmap(sb,
+				sbi->clu_srch_ptr - BASE_CLUSTER);
+		if (hint_clu == EOF_CLUSTER)
+			return -ENOSPC;
+	}
+
+	/* check cluster validation */
+	if (hint_clu < BASE_CLUSTER && hint_clu >= sbi->num_clusters) {
+		exfat_msg(sb, KERN_ERR, "hint_cluster is invalid (%u)\n",
+			hint_clu);
+		hint_clu = BASE_CLUSTER;
+		if (p_chain->flags == 0x03) {
+			if (exfat_chain_cont_cluster(sb, p_chain->dir,
+					num_clusters))
+				return -EIO;
+			p_chain->flags = 0x01;
+		}
+	}
+
+	WRITE_ONCE(sbi->s_dirt, true);
+
+	p_chain->dir = EOF_CLUSTER;
+
+	while ((new_clu = exfat_test_bitmap(sb,
+			hint_clu - BASE_CLUSTER)) != EOF_CLUSTER) {
+		if (new_clu != hint_clu && p_chain->flags == 0x03) {
+			if (exfat_chain_cont_cluster(sb, p_chain->dir,
+					num_clusters)) {
+				ret = -EIO;
+				goto error;
+			}
+			p_chain->flags = 0x01;
+		}
+
+		/* update allocation bitmap */
+		if (exfat_set_bitmap(inode, new_clu - BASE_CLUSTER)) {
+			ret = -EIO;
+			goto error;
+		}
+
+		num_clusters++;
+
+		/* update FAT table */
+		if (p_chain->flags == 0x01) {
+			if (exfat_ent_set(sb, new_clu, EOF_CLUSTER)) {
+				ret = -EIO;
+				goto error;
+			}
+		}
+
+		if (p_chain->dir == EOF_CLUSTER) {
+			p_chain->dir = new_clu;
+		} else if (p_chain->flags == 0x01) {
+			if (exfat_ent_set(sb, last_clu, new_clu)) {
+				ret = -EIO;
+				goto error;
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
+			hint_clu = BASE_CLUSTER;
+
+			if (p_chain->flags == 0x03) {
+				if (exfat_chain_cont_cluster(sb, p_chain->dir,
+						num_clusters)) {
+					ret = -EIO;
+					goto error;
+				}
+				p_chain->flags = 0x01;
+			}
+		}
+	}
+error:
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
+	if (!p_chain->dir || p_chain->dir == EOF_CLUSTER) {
+		*ret_count = 0;
+		return 0;
+	}
+
+	if (p_chain->flags == 0x03) {
+		*ret_count = p_chain->size;
+		return 0;
+	}
+
+	clu = p_chain->dir;
+	count = 0;
+	for (i = BASE_CLUSTER; i < sbi->num_clusters; i++) {
+		count++;
+		if (exfat_ent_get(sb, clu, &clu))
+			return -EIO;
+		if (clu == EOF_CLUSTER)
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
+		if (!c_bh) {
+			err = -ENOMEM;
+			goto out;
+		}
+		memcpy(c_bh->b_data, bh->b_data, sb->s_blocksize);
+		set_buffer_uptodate(c_bh);
+		mark_buffer_dirty(c_bh);
+		if (sb->s_flags & SB_SYNCHRONOUS)
+			err = sync_dirty_buffer(c_bh);
+		brelse(c_bh);
+	}
+out:
+	return err;
+}
-- 
2.17.1

