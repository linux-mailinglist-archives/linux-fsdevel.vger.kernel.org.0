Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75FD81753C1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 07:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgCBG1E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 01:27:04 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:22771 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgCBG0Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 01:26:25 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200302062622epoutp02e8cef8d0deab1f83f75d348000f0fe17~4aLH6TISb0078800788epoutp025
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2020 06:26:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200302062622epoutp02e8cef8d0deab1f83f75d348000f0fe17~4aLH6TISb0078800788epoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583130382;
        bh=gdRNN+7VEr4ETsR61dyhAw+XlLdq/m6AI8adq0uQJPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AM7Hutfm7eL9jn1vYNyrGlL11rgfGdSF80rqKJ3r+c0pjygC/z50mF8WfGD9dCNkZ
         brtb0sFQOZMvGSoTfVitmAvhSmHSFWzf4vJLA1nQtLlAU6qq5BrpybqChoMATex9+B
         uDjRiksi6xey5vj1KrEHBkTwyl5xym8uIZC18vuk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200302062622epcas1p3d048c4f212ec39a192cd8b67b55ea603~4aLHXoIKR0424204242epcas1p3b;
        Mon,  2 Mar 2020 06:26:22 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.159]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48W9C10hxvzMqYkp; Mon,  2 Mar
        2020 06:26:21 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.2D.57028.C07AC5E5; Mon,  2 Mar 2020 15:26:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200302062620epcas1p3ba4cc2c52d4e9e88d8a6cb08e9ef6995~4aLGKGvzZ0424204242epcas1p3U;
        Mon,  2 Mar 2020 06:26:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200302062620epsmtrp2aec196bf519ba497f881bcba17af0114~4aLGEWAiF1821918219epsmtrp2d;
        Mon,  2 Mar 2020 06:26:20 +0000 (GMT)
X-AuditID: b6c32a35-974d39c00001dec4-15-5e5ca70c9578
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.39.10238.C07AC5E5; Mon,  2 Mar 2020 15:26:20 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302062620epsmtip2fdea56783a2d390aa5cba137c9f8cc0a~4aLF1Izu71396013960epsmtip2P;
        Mon,  2 Mar 2020 06:26:20 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        linkinjeon@gmail.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v14 06/14] exfat: add fat entry operations
Date:   Mon,  2 Mar 2020 15:21:37 +0900
Message-Id: <20200302062145.1719-7-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302062145.1719-1-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TaUwTQRjN7LbbRa3ZFpEJJlg3oikKtNbiitRo8NioBBKPKAi4oZuC9tjs
        FiOaKLECWhXFmBiqqBUTFAyQpiiHiEE8i0hqIvEgHmi88SCeVbRlMfLvfW/em/d9c+CosgWL
        wvOtdpa3MmYSGyM5f0UdFyevXp+teVoMqN+HrskoR1U9Rp2tvYpQvX0PUOpi200JdbflGEZ9
        P7KDKvcFEMo71Cml/B8+Sqg7v69LF4ylAz8PAbrZ1Sej2yvPyejW+0UYXeatAfSgJ5ruuPAO
        oz3P3yPpeIY5OY9ljCyvYq25NmO+1WQgl6/MScnRJ2q0cdq51BxSZWUsrIFctCI9bkm+Odgo
        qdrMmAuCVDojCGTC/GTeVmBnVXk2wW4gWc5o5rQaLl5gLEKB1RSfa7MkaTWaWfqgcoM573Gt
        F+EeZmy5VdwLioB7qROE4ZCYDdv6qjAnGIMriSYAe30emVh8BtCzyycVi68A1u1yok6AD1sc
        l3iRbwPw6uvW/47q/joQEmHEDPjLGxGKmEBMgl0H/EhIgxJFCHRc3ikLLYQTSfBdwDWMJUQM
        7G68hoWwnJgHK/oDQOxvMqxtuIyGcBiRDB+19ABRo4A3K55LQhgNahyNR1FR75DBH682iXgR
        LNm7BxFxOHxz3SsTcRQcHGjDxGG2wU/tI9bdAL76ZhCxDt6vb5CGJCihhvUtCSI9BTYHKoGY
        Oh4OfNknFXeRw90lSlESA8v8V0ZCJ0Fn6ceRUBq+eOZCxJM6AOCdW+Wyg0DlGjWMa9Qwrv/J
        JwFaAyaynGAxsYKW046+Xw8Yfrex+iZwuHtFByBwQI6TN73MzFZKmc1CoaUDQBwlJ8hTw4KU
        3MgUbmV5Ww5fYGaFDqAPnns5GhWRawv+Aqs9R6ufpdPpqNmJcxL1OjJS/nSdOltJmBg7u4ll
        OZb/50PwsKgiMK3LXjxznMYfMT3F7yszlEVvXLJY3j3ldlpMT6G9qqfTcprMvHf8l7lct2wh
        TiWqV7uTwhu6uPFuXUJPU+mJVe6hU+uGfDX9VRWvWUd0p6IOyWpcyZ2JvOFWLF4b+bbBmHJx
        6o0n+7fHDphq13SnpiVPy1rIDyrUj7al4oE/pixSIuQx2liUF5i/YtRKZ80DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJXpdneUycwd+NShZ/Jx1jt2hevJ7N
        YuXqo0wW1+/eYrbYs/cki8XlXXPYLH5Mr7eYePo3k8WWf0dYLS69/8Bicf7vcVYHbo/fvyYx
        euycdZfdY//cNeweu282sHn0bVnF6PF5k5zHoe1v2Dw2PXnLFMARxWWTkpqTWZZapG+XwJVx
        f/UWpoLbURWnWq8zNjAudO9i5OCQEDCRaN5X1MXIxSEksJtR4vTUH4xdjJxAcWmJYyfOMEPU
        CEscPlwMUfOBUWLm87csIHE2AW2JP1tEQcpFgMrP9F9iAqlhFuhhkvg8ZTETSEJYwErize9Z
        7CA2i4CqxLmtx9hAbF4Ba4mZj39D7ZKXWL3hADOIzSlgI3Fn1wWwuBBQzdMXd5kh6gUlTs58
        AraXWUBdYv08IZAwM1Br89bZzBMYBWchqZqFUDULSdUCRuZVjJKpBcW56bnFhgWGeanlesWJ
        ucWleel6yfm5mxjBMaSluYPx8pL4Q4wCHIxKPLw7n0fHCbEmlhVX5h5ilOBgVhLh9eUECvGm
        JFZWpRblxxeV5qQWH2KU5mBREud9mncsUkggPbEkNTs1tSC1CCbLxMEp1cDov/rkoyb1S0uW
        fbfsFpzySPjG32C9CotfOVqrG/QvvXML/3xL+IDT8XCd8E0rhFq/PTd64874NtRy6uvVtauT
        j+xZet9D//HVw1Ov7wzqKl/Y6zBT55VmamhvpvyeG3MytwhN+xDupFv0a7P9GXUdXt/EdJ12
        hlpWnnXvfjde1NV9fIgvY66lEktxRqKhFnNRcSIAASswaZ0CAAA=
X-CMS-MailID: 20200302062620epcas1p3ba4cc2c52d4e9e88d8a6cb08e9ef6995
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200302062620epcas1p3ba4cc2c52d4e9e88d8a6cb08e9ef6995
References: <20200302062145.1719-1-namjae.jeon@samsung.com>
        <CGME20200302062620epcas1p3ba4cc2c52d4e9e88d8a6cb08e9ef6995@epcas1p3.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the implementation of fat entry operations for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

