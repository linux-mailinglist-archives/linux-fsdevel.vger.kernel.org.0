Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90E7112E3DD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 09:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgABIYu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 03:24:50 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:52851 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgABIYJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 03:24:09 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200102082406epoutp036dc6cb7920c998537252c7ac0b81873f~mBEyFM6ij3233932339epoutp037
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jan 2020 08:24:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200102082406epoutp036dc6cb7920c998537252c7ac0b81873f~mBEyFM6ij3233932339epoutp037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1577953446;
        bh=MTqo9s1x8qshK+AINkNLwwQ5rk3AQzECOO5xdakBG5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c5oIbQ6D0FGtF24SplvnkQyVnAdJQlH6b85RjjoY+9fZGJ8QI0lFYk2HsCKE7KDJN
         YjTO8bUo6BzcZK9aAbF/vxalB/BX+OCfE7en3JndONTkMULBCwYmbcmlKyqzrQjMBR
         uOa2TPOOtBq/w2UxGopUwHIGzqG/SSZllEsZJ7DE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200102082405epcas1p3265ef4a23db3b07a3f6ec7658cf1395b~mBExvDWQy2864828648epcas1p3w;
        Thu,  2 Jan 2020 08:24:05 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.166]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47pLfX52rBzMqYkV; Thu,  2 Jan
        2020 08:24:04 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.B7.52419.4A8AD0E5; Thu,  2 Jan 2020 17:24:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200102082404epcas1p4a28c34799df317165ddf8bd5a0b433e9~mBEwd20ES0403204032epcas1p4P;
        Thu,  2 Jan 2020 08:24:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200102082404epsmtrp2311c91df205329b84629066c97c5804b~mBEwc-f7m2039720397epsmtrp2S;
        Thu,  2 Jan 2020 08:24:04 +0000 (GMT)
X-AuditID: b6c32a37-5b7ff7000001ccc3-bc-5e0da8a48a41
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.68.10238.4A8AD0E5; Thu,  2 Jan 2020 17:24:04 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200102082404epsmtip27f6645b41d51a1d287d7b2d563520e92~mBEwPmcqS2215622156epsmtip2X;
        Thu,  2 Jan 2020 08:24:04 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, pali.rohar@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v9 06/13] exfat: add exfat entry operations
Date:   Thu,  2 Jan 2020 16:20:29 +0800
Message-Id: <20200102082036.29643-7-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200102082036.29643-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmnu6SFbxxBi9eq1k0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbTDz9m8liy78jrBaX3n9gceD02DnrLrvH/rlr2D1232xg
        8+jbsorR4/MmOY9D29+wBbBF5dhkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynk
        Jeam2iq5+AToumXmAB2lpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwNCjQK07M
        LS7NS9dLzs+1MjQwMDIFqkzIyZjbIVPQElPx5s1ZlgbGJR5djJwcEgImEr2LvrN1MXJxCAns
        YJToPPmWHcL5xCjRN+kBE4TzjVHizJe9rDAtZ379gmrZyygxddYxRpAEWEvD5oAuRg4ONgFt
        iT9bREHCIgL2EptnH2ABqWcW2MQosWf+V7BBwgLWEne3/WUFqWcRUJV4vt8aJMwrYCPxvuUv
        C8QueYnVGw4wg9icArYSM9+3gu2VENjCJrG/6y4TRJGLxPVNq9ghbGGJV8e3QNlSEp/f7WUD
        mS8hUC3xcT8zRLiDUeLFd1sI21ji5voNYCcwC2hKrN+lDxFWlNj5ey7YV8wCfBLvvvawQkzh
        lehoE4IoUZXou3QY6gBpia72D1BLPSQud0xmhYTOBEaJZ58esUxglJuFsGEBI+MqRrHUguLc
        9NRiwwJj5OjaxAhOclrmOxg3nPM5xCjAwajEw3tjHk+cEGtiWXFl7iFGCQ5mJRHe8kDeOCHe
        lMTKqtSi/Pii0pzU4kOMpsBwnMgsJZqcD0zAeSXxhqZGxsbGFiZm5mamxkrivBw/LsYKCaQn
        lqRmp6YWpBbB9DFxcEo1MKqUa9ve0Ptwqjt43cqKAKPaH3InbpS2BjjeVX0u8UQ+kcn80qmz
        ak1cMcLqZ1ffu3ffY869m5qT7PenXrlr0387U0llo9T2JwcPPCk5rZ2UuOVPtnejZaBGpIjt
        yex+16g7DR1hDxkePXX75cKdeWDFpUs2S3xWaBR2d889u2Uf72/u003ebUosxRmJhlrMRcWJ
        AFBQvpWIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPLMWRmVeSWpSXmKPExsWy7bCSvO6SFbxxBnOWC1s0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbTDz9m8liy78jrBaX3n9gceD02DnrLrvH/rlr2D1232xg
        8+jbsorR4/MmOY9D29+wBbBFcdmkpOZklqUW6dslcGXM7ZApaImpePPmLEsD4xKPLkZODgkB
        E4kzv36xdTFycQgJ7GaUeHL3MyNEQlri2IkzzF2MHEC2sMThw8UQNR8YJQ4deg4WZxPQlviz
        RRSkXETAUaJ312EWkBpmgV2MEidOnwabIyxgLXF3219WkHoWAVWJ5/utQcK8AjYS71v+skCs
        kpdYveEAM4jNKWArMfN9KxuILQRU8+rfY7YJjHwLGBlWMUqmFhTnpucWGxYY5qWW6xUn5haX
        5qXrJefnbmIEB6OW5g7Gy0viDzEKcDAq8fDemMcTJ8SaWFZcmXuIUYKDWUmEtzyQN06INyWx
        siq1KD++qDQntfgQozQHi5I479O8Y5FCAumJJanZqakFqUUwWSYOTqkGxnbWFuEysUerzKrz
        t2dNe1r8PmYN08XObydmzg8+zXCIXbRB7O2Hs9/jlfbF8NYJmrpHXO74dthPXHq/W8++i90f
        V7zZo5VS08nAvvFXpMMx94VJC8VltoRISSgK/phw8R/ji7jsEP/qS20KtkwKh02bu3qXlfdz
        ZQus1btomLp3a4W7hsMXJZbijERDLeai4kQAy7L1/0ICAAA=
X-CMS-MailID: 20200102082404epcas1p4a28c34799df317165ddf8bd5a0b433e9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200102082404epcas1p4a28c34799df317165ddf8bd5a0b433e9
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
        <CGME20200102082404epcas1p4a28c34799df317165ddf8bd5a0b433e9@epcas1p4.samsung.com>
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
index 000000000000..4079ef28e15e
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
-- 
2.17.1

