Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18447FAC09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 09:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfKMIXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 03:23:38 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:58115 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfKMIWZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 03:22:25 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191113082223epoutp031462cb52f8398d682e49461c8c2845a3~WqzAnglJk1718517185epoutp03L
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 08:22:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191113082223epoutp031462cb52f8398d682e49461c8c2845a3~WqzAnglJk1718517185epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573633343;
        bh=moFSjqom8tMKVgnAIE+bliJo2nyGZ77U3BbjnQGWtEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ayWVlRnZRxtflNDRZQHn6sMHRmlrBoBnEz41OFDrFknQxCFC9LFCqXa3QRdzQ8V1u
         Wmc1UHtuHozYjgy+swsWbjgnMU8E9g0Mx21Jyu67dUIxmCIn//5VUyJPpAS3VTQMz0
         ksMbICg+p1l3IgvSP0qc/tRFCCEnOl0QfnbkyWmk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191113082222epcas1p3d321eb1e945cb62c61f4aeedf5758876~WqzAR-pYZ1452214522epcas1p3G;
        Wed, 13 Nov 2019 08:22:22 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.165]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47Cczd5bpyzMqYkj; Wed, 13 Nov
        2019 08:22:21 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.56.04144.C3DBBCD5; Wed, 13 Nov 2019 17:22:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191113082220epcas1p1233a27705b2ab2cd4fd3d2ba9c505dff~Wqy_Mw_Mj0424504245epcas1p1b;
        Wed, 13 Nov 2019 08:22:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191113082220epsmtrp1d09dddd161b227d58a77ebf69c488e6f~Wqy_L8pyo2822528225epsmtrp1C;
        Wed, 13 Nov 2019 08:22:20 +0000 (GMT)
X-AuditID: b6c32a35-2c7ff70000001030-e7-5dcbbd3ceb7e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.84.24756.C3DBBCD5; Wed, 13 Nov 2019 17:22:20 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191113082220epsmtip1ba1767bda843b3f195f2d652e39ec1e2~Wqy99y-uV2165921659epsmtip1g;
        Wed, 13 Nov 2019 08:22:20 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH 06/13] exfat: add exfat entry operations
Date:   Wed, 13 Nov 2019 03:17:53 -0500
Message-Id: <20191113081800.7672-7-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191113081800.7672-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02SW0wTURCGc7q9LGDNWlBHvMFGH9BUu5biqhQvKNbIA4kvhgTrChsg9ka3
        RdQHEQ0SUJQEFQrFKhABIVysCkgjVhRBI4iJBgxi1EQEU/GuAdSWBfXtP3++f2YyZ3BM5hEF
        46kGC2s2MDpS7C+8fidMLle7HiQoXnUg+lh5vZiuvnJXQD8bHMDoNleXkH7SWiqmf5w/Qjt/
        dYjovg9jwk24psU2KNHcstdKNDf7M8WafGcN0nxuWqJx33gvjhPH6yJTWCaJNYewhkRjUqoh
        WU3u3KWN1qoiFJScWkevJUMMjJ5Vk1tj4+QxqTrvPGRIOqOzeq04huPI1VGRZqPVwoakGDmL
        mmRNSToTpTCt4hg9ZzUkr0o06tdTCsUalZfcq0sZqFCZsuIzOicfCjJRTkwu8sOBCIe28W+S
        XOSPy4hmBG87bwv5xycEIx2TmI+SEd8Q5JeZZxJuZ7WI910I+l+k/Q2cLbahXITjYmIlTDjn
        +pggYiNcLWmfKooRpQiaT/FMIEFDw8XdPkZILIdLribk01JiA/SODyG+11K40tCO+XA/IhKe
        1ql9ZYCoFYPd3ifgma1wtMAh4XUgjHQ6p3UwvDudLfFlgTgMH29hvJ2DYPi7mtdK6K9vEPkQ
        jAiD+tbVvB0KLeP2qQkwYjZ4vp4U8VWkkJMt45HlkN93Z3qAhZB7Ymy6qQbst52IX8hpBLZ7
        eYIzaIntXwcHQjVoHmvi9MksR5mo/z+rCU3d2gpVMyp8FOtGBI7IWdL2su4EmYhJ5w7q3Qhw
        jAySNmfcT5BJk5iDh1izUWu26ljOjVTePRZgwXMTjd7LNVi0lGqNUqmkwyPWRqiU5Hzp5suV
        CTIimbGw+1nWxJpncgLcLzgT7elevGhB3TZU+3uQvDjupt7Tkr2KS735mbYDo+XD/ta0QoW1
        6+VITMlr+Z4blXCspSigccL1pf555/Yii31Lxs9Qo7bHnVexz3HOUwePO56NerQVF6LthTsa
        q76P5O3Dli2sdkTEjqnyqorvaUqODEmPl+nq3kRlBXFzeq4FOEghl8JQKzAzx/wBg9LaM4ED
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSnK7N3tOxBr8OS1o0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbbPl3hNXi0vsPLA4cHjtn3WX32D93DbvH7psNbB59W1Yx
        enzeJOdxaPsbtgC2KC6blNSczLLUIn27BK6MW0tMC5qiKo7/PcPUwNjh1sXIySEhYCJxaMtK
        VhBbSGA3o8SU5kCIuLTEsRNnmLsYOYBsYYnDh4u7GLmASj4wSsycupQFJM4moC3xZ4soSLmI
        gKNE767DLCA1zAKLGCXefZzMClIjLGAhsWFhBEgNi4CqxKK9mxhBbF4Ba4kLv+8zQqySl1i9
        4QDYKk4BG4lra20hrrGW+Pr2APMERr4FjAyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNz
        NzGCw09Lcwfj5SXxhxgFOBiVeHglFp6KFWJNLCuuzD3EKMHBrCTCu6PiRKwQb0piZVVqUX58
        UWlOavEhRmkOFiVx3qd5xyKFBNITS1KzU1MLUotgskwcnFINjJMXLLZ91MKxjzE3cH3SkoVX
        5iwUfqLlci3q4o0DXRyij53VJj5L+qt9jXXhfZv+qT/93lRd/SWkL//zi3f+wckZgd8FHt+f
        ETeLR6orqU5r45//FzPCj6oJGql3a/W5HP+otStTIPbo9/DHTt5/Phi77myczKOYH5q6dMsb
        lVOWVpwGZpvTGZVYijMSDbWYi4oTAXsAdeg7AgAA
X-CMS-MailID: 20191113082220epcas1p1233a27705b2ab2cd4fd3d2ba9c505dff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191113082220epcas1p1233a27705b2ab2cd4fd3d2ba9c505dff
References: <20191113081800.7672-1-namjae.jeon@samsung.com>
        <CGME20191113082220epcas1p1233a27705b2ab2cd4fd3d2ba9c505dff@epcas1p1.samsung.com>
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

