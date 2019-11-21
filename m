Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8E4104A3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 06:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfKUFaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 00:30:07 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:58250 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKUF3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 00:29:24 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191121052921epoutp0421dbbb8a918e22168eb8f04794dd5eee~ZFmOJ3KVc2288822888epoutp04c
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2019 05:29:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191121052921epoutp0421dbbb8a918e22168eb8f04794dd5eee~ZFmOJ3KVc2288822888epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574314161;
        bh=q+DS758cICJ9MN7R5oiW9hdAyzmeIFAdgs2e0Psslu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XuqnqScpfoOYHy/ZDuTA5W4y2wgEQDhyIF7z1oqIzHYVu1jVFZoFRemEHoyBAcmYJ
         oEOxBgpygcKUDLFCpbIDm/3emEr0SSy1jL6uw1jyMT148ZWov7azB7vUCSjDaAv/GP
         6z73AIe7hYL3KYEVEW/fO2MuoyF6oYsjSFD137gg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191121052921epcas1p1faa03449b245cabf93f71be352c0623c~ZFmN1ZSE00315303153epcas1p1c;
        Thu, 21 Nov 2019 05:29:21 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.162]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47JSmJ10NwzMqYkf; Thu, 21 Nov
        2019 05:29:20 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.3A.04237.EA026DD5; Thu, 21 Nov 2019 14:29:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191121052918epcas1p284be629c57ced93afe88b94a35437cb2~ZFmLFhGwZ3070730707epcas1p2h;
        Thu, 21 Nov 2019 05:29:18 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191121052918epsmtrp180d27d903eb1c535685d6463d4940141~ZFmLEz6ah1320813208epsmtrp1x;
        Thu, 21 Nov 2019 05:29:18 +0000 (GMT)
X-AuditID: b6c32a39-913ff7000000108d-31-5dd620aee97b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.98.03814.EA026DD5; Thu, 21 Nov 2019 14:29:18 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191121052917epsmtip1aa939bec21308f7d2224b35f1df328ef~ZFmK36xNw1041710417epsmtip19;
        Thu, 21 Nov 2019 05:29:17 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de, nborisov@suse.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v4 06/13] exfat: add exfat entry operations
Date:   Thu, 21 Nov 2019 00:26:11 -0500
Message-Id: <20191121052618.31117-7-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121052618.31117-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdljTQHedwrVYg7YuGYvDjyexWzQvXs9m
        sXL1USaL63dvMVvs2XuSxeLyrjlsFv9nPWe1+DG93uL/mxYWiy3/jrBaXHr/gcWB22PnrLvs
        HvvnrmH32H2zgc2jb8sqRo/1W66yeGw+Xe3xeZOcx6Htb9g8bj/bxhLAGZVjk5GamJJapJCa
        l5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0rJJCWWJOKVAoILG4WEnf
        zqYov7QkVSEjv7jEVim1ICWnwNCgQK84Mbe4NC9dLzk/18rQwMDIFKgyISdj78J37AWPoyu6
        2ywbGJ+5dzFyckgImEg82PWCtYuRi0NIYAejxK6vixhBEkICnxglDuyxgLC/MUocvxML0/Dq
        8zIWiIa9jBKPbqxlh3CAGlp/NTB1MXJwsAloS/zZIgrSICJgL7F59gGwBmaB64wSz27NYAWp
        ERawlth7OhKkhkVAVaLp6WNWEJtXwEZi5vHTbBDL5CVWbzjADFLOKWArcf93JcgYCYHrbBIv
        j1xlgahxkTjQ0w1lC0u8Or6FHcKWknjZ38YO0ishUC3xcT8zRLiDUeLFd1sI21ji5voNYNcw
        C2hKrN+lDxFWlNj5ey44GJgF+CTefe1hhZjCK9HRJgRRoirRd+kwE4QtLdHV/gFqqYfEha4l
        bJAAmcAocXX1IqYJjHKzEDYsYGRcxSiWWlCcm55abFhgihxZmxjBCVHLcgfjsXM+hxgFOBiV
        eHgzNK7GCrEmlhVX5h5ilOBgVhLh3XP9SqwQb0piZVVqUX58UWlOavEhRlNgOE5klhJNzgcm
        67ySeENTI2NjYwsTM3MzU2MlcV6OHxdjhQTSE0tSs1NTC1KLYPqYODilGhg3XT4ctvj5v/f3
        t0QGGHGqqGWuE5gUcLueZeUL0wvt8+RXLr7JarlTs2eZBNO2PNmT1z92aasLFxd7SXD9EdVh
        r7i6e8umpvNfc8NuOZavl76rw/xeZ0pYvle3QHtkrPUJ7uYrX4q4f3Qesj3AuHCmfpKqadry
        Y7GB4vvDTWOMTbRvzJ8nEqHEUpyRaKjFXFScCAC99OmOngMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWy7bCSnO46hWuxBmuOcVgcfjyJ3aJ58Xo2
        i5WrjzJZXL97i9liz96TLBaXd81hs/g/6zmrxY/p9Rb/37SwWGz5d4TV4tL7DywO3B47Z91l
        99g/dw27x+6bDWwefVtWMXqs33KVxWPz6WqPz5vkPA5tf8PmcfvZNpYAzigum5TUnMyy1CJ9
        uwSujL0L37EXPI6u6G6zbGB85t7FyMkhIWAi8erzMpYuRi4OIYHdjBKLe7vZIBLSEsdOnGHu
        YuQAsoUlDh8uBgkLCXxglNjaJgwSZhPQlvizRRQkLCLgKNG76zDYGGaBx4wSJ84/YQSpERaw
        lth7OhKkhkVAVaLp6WNWEJtXwEZi5vHTUJvkJVZvOAC2iVPAVuL+70qITTYSV0+8YJ3AyLeA
        kWEVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZw4Gpp7WA8cSL+EKMAB6MSD2+GxtVY
        IdbEsuLK3EOMEhzMSiK8e65fiRXiTUmsrEotyo8vKs1JLT7EKM3BoiTOK59/LFJIID2xJDU7
        NbUgtQgmy8TBKdXAWDZ/pmiEyNUstTO9S82z3jCGHZvkE7K6Tj/Aok0vi6090GeL7pMLyY/c
        tFsWSC5RD3HlmRwyy/Nx1ZOA9b9TBQ7wF5moClg9iF34MnNawdctV5zdGPh2ca/77bnlOP+E
        ee43xWzS9wZ/Ed/aJVBfK6tVunpTl270P/Yz64VThaQn5i59Uq+ixFKckWioxVxUnAgApa/D
        NlgCAAA=
X-CMS-MailID: 20191121052918epcas1p284be629c57ced93afe88b94a35437cb2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191121052918epcas1p284be629c57ced93afe88b94a35437cb2
References: <20191121052618.31117-1-namjae.jeon@samsung.com>
        <CGME20191121052918epcas1p284be629c57ced93afe88b94a35437cb2@epcas1p2.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the implementation of exfat entry operations for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/fatent.c | 474 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 474 insertions(+)
 create mode 100644 fs/exfat/fatent.c

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
new file mode 100644
index 000000000000..dc5f38fc56fe
--- /dev/null
+++ b/fs/exfat/fatent.c
@@ -0,0 +1,474 @@
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
+	set_bit(EXFAT_SB_DIRTY, &sbi->s_state);
+	clu = p_chain->dir;
+
+	if (p_chain->flags == ALLOC_NO_FAT_CHAIN) {
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
+	p_chain->dir = EOF_CLUSTER;
+
+	while ((new_clu = exfat_test_bitmap(sb,
+			hint_clu - BASE_CLUSTER)) != EOF_CLUSTER) {
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
+		if (exfat_set_bitmap(inode, new_clu - BASE_CLUSTER)) {
+			ret = -EIO;
+			goto free_cluster;
+		}
+
+		num_clusters++;
+
+		/* update FAT table */
+		if (p_chain->flags == ALLOC_FAT_CHAIN) {
+			if (exfat_ent_set(sb, new_clu, EOF_CLUSTER)) {
+				ret = -EIO;
+				goto free_cluster;
+			}
+		}
+
+		if (p_chain->dir == EOF_CLUSTER) {
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
+			hint_clu = BASE_CLUSTER;
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
+	if (!p_chain->dir || p_chain->dir == EOF_CLUSTER) {
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

