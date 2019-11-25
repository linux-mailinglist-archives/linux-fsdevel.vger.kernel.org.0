Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6E5C1085D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 01:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfKYAGg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Nov 2019 19:06:36 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:21665 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfKYAGg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Nov 2019 19:06:36 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191125000633epoutp044bbc527b22d0d31211273d7adcc20f9b~aPxhMkDja1280612806epoutp04L
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2019 00:06:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191125000633epoutp044bbc527b22d0d31211273d7adcc20f9b~aPxhMkDja1280612806epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574640393;
        bh=9bEzzOhUMxf7gBYWRripcTQol6c+Tk1hsbR7EopfI/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PwEXI07Uq2prw3qpraZdnaQfLcDt5qjlXyp9GxT5sep1nwRncXCT+AOWvGDlXng5o
         8NSKFdHobSVRY7HDSjCYbPg/jT1rqgxVMZQVrRIt4NWm+H/n276sft7sVwNR2Bdz1V
         zSTvah0qo2zFeF35mFQOL2GE61OysT+3h832QRKs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191125000632epcas1p215eb79cd82ed123d23a56d3b205e2130~aPxggPYrP0156901569epcas1p2R;
        Mon, 25 Nov 2019 00:06:32 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.165]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47LnPz4SLbzMqYkc; Mon, 25 Nov
        2019 00:06:31 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.F3.51241.70B1BDD5; Mon, 25 Nov 2019 09:06:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191125000631epcas1p19c6023ffa6388994d77d182a799e27bc~aPxfN0XrB0109001090epcas1p1B;
        Mon, 25 Nov 2019 00:06:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191125000631epsmtrp14e32bf3331a223aa7a41e44d04bb1841~aPxfNGuQy2803928039epsmtrp1S;
        Mon, 25 Nov 2019 00:06:31 +0000 (GMT)
X-AuditID: b6c32a39-163ff7000001c829-a8-5ddb1b074e0b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.60.10238.70B1BDD5; Mon, 25 Nov 2019 09:06:31 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191125000630epsmtip25fe8ce94f05eee41ad4fff894f280cb1~aPxe82bKZ2189121891epsmtip2n;
        Mon, 25 Nov 2019 00:06:30 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de, nborisov@suse.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v5 06/13] exfat: add exfat entry operations
Date:   Sun, 24 Nov 2019 19:03:19 -0500
Message-Id: <20191125000326.24561-7-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191125000326.24561-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdljTQJdd+naswa53KhaHH09it2hevJ7N
        YuXqo0wW1+/eYrbYs/cki8XlXXPYLP7Pes5q8WN6vcX/Ny0sFlv+HWG1uPT+A4sDt8fOWXfZ
        PfbPXcPusftmA5tH35ZVjB7rt1xl8dh8utrj8yY5j0Pb37B53H62jSWAMyrHJiM1MSW1SCE1
        Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoWCWFssScUqBQQGJxsZK+
        nU1RfmlJqkJGfnGJrVJqQUpOgaFBgV5xYm5xaV66XnJ+rpWhgYGRKVBlQk5G61uFgrvRFQ83
        /mZsYHzj3sXIwSEhYCLx+15eFyMXh5DADkaJj6eeM0M4nxglNp95yQrhfGOUmLj4NksXIydY
        x64lW9ggEnsZJR50LWKBa7m9cBIryFw2AW2JP1tEQRpEBOwlNs8+AFbDLHCdUeLZrRlgNcIC
        1hKfGqRBalgEVCXe9rWygdi8AjYSez4cZ4dYJi+xesMBZhCbU8BW4sSpbWDnSQjcZpNY2Hqb
        GaLIRaL33lkmCFtY4tXxLVDNUhIv+9vYIf6slvi4H6q8g1HixXdbCNtY4ub6DWDnMAtoSqzf
        pQ8RVpTY+XsuI4jNLMAn8e5rDyvEFF6JjjYhiBJVib5Lh6GWSkt0tX+AWuohsezBfWi4TWCU
        2LhoEtsERrlZCBsWMDKuYhRLLSjOTU8tNiwwRY6uTYzgpKhluYPx2DmfQ4wCHIxKPLwb1t6K
        FWJNLCuuzD3EKMHBrCTC63b2RqwQb0piZVVqUX58UWlOavEhRlNgQE5klhJNzgcm7LySeENT
        I2NjYwsTM3MzU2MlcV6OHxdjhQTSE0tSs1NTC1KLYPqYODilGhiPFXS/ijh0JNvWRvvTlvxv
        TacUy/9qrD/zV+1SbP3bs4cPbt/k6FqofjvnUHNdgXJIpo2f5vo9TzQX5b7UE1zi/2iL/8yi
        ItHJWZP6JZsN5/i+etLzdPOsrt19t83api8WcX/wx8ZYpWZS2jZbpbqfNY/WPJPhFlN5JLhJ
        yev/Kpsb5sp2DXOVWIozEg21mIuKEwGmzVAcoAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsWy7bCSvC679O1Yg4+L2SwOP57EbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyf9ZzV4sf0eov/b1pYLLb8O8Jqcen9BxYHbo+ds+6y
        e+yfu4bdY/fNBjaPvi2rGD3Wb7nK4rH5dLXH501yHoe2v2HzuP1sG0sAZxSXTUpqTmZZapG+
        XQJXRutbhYK70RUPN/5mbGB8497FyMkhIWAisWvJFrYuRi4OIYHdjBIvn85lg0hISxw7cYa5
        i5EDyBaWOHy4GKLmA6PEqsb1rCBxNgFtiT9bREHKRQQcJXp3HWYBqWEWeMwoceL8E0aQGmEB
        a4lPDdIgNSwCqhJv+1rBxvMK2Ejs+XCcHWKVvMTqDQeYQWxOAVuJE6e2gdlCQDXth46yTWDk
        W8DIsIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzh4tTR3MF5eEn+IUYCDUYmHd8Pa
        W7FCrIllxZW5hxglOJiVRHjdzt6IFeJNSaysSi3Kjy8qzUktPsQozcGiJM77NO9YpJBAemJJ
        anZqakFqEUyWiYNTqoFRZErJchHJhUvZxW9bWwjsbCzWuMbtzXiM+/zqVTmG0RO+H126ZQOv
        x4QtYtvC7QW3Wgjx7829KbzIMOxHP1dZ5/N25qf8y9QeT1afkXNmd6LsneSPZTnqmRMzZd/+
        sp0kMMPh2xS2zOCzBpsKLjB5RQvcjqwxjN3UyJd0+rvOenMrvs8vf3MosRRnJBpqMRcVJwIA
        eHta51oCAAA=
X-CMS-MailID: 20191125000631epcas1p19c6023ffa6388994d77d182a799e27bc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191125000631epcas1p19c6023ffa6388994d77d182a799e27bc
References: <20191125000326.24561-1-namjae.jeon@samsung.com>
        <CGME20191125000631epcas1p19c6023ffa6388994d77d182a799e27bc@epcas1p1.samsung.com>
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
index 000000000000..0598aa2d04c1
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
+				goto dec_used_clus;
+
+			num_clusters++;
+		} while (clu != EOF_CLUSTER);
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

