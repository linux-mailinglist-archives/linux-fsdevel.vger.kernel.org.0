Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 400FD1753C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 07:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgCBG1S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 01:27:18 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:22759 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgCBG0X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 01:26:23 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200302062621epoutp02b2d7767301238ebe9ab3b032cadc5176~4aLGlu7Ap0078800788epoutp024
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2020 06:26:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200302062621epoutp02b2d7767301238ebe9ab3b032cadc5176~4aLGlu7Ap0078800788epoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583130381;
        bh=cMKwx77T9+wIdpY/cGfj/Mphk9OIwbwK/zh6xBFYIHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KVCOZCPIKWyHDzIrHm9yqnSBgGiZV+mIU1ahIXvD0uvd7O/QfhMpc3WSJms6+Pvgn
         NOKdKN4dT0qHb/33+CXnsuZqf2/95H7uC/s5vQ8tbNxlxxY9qWkNK5rAYCVgip6jc0
         GpMeMAsQgQBlHaImzxl7MBx8Fkp74ThUbXRf3z+Q=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200302062620epcas1p3bc4555a2eaa7a83c74cc1d766205b20b~4aLGCiryz0686306863epcas1p3T;
        Mon,  2 Mar 2020 06:26:20 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.166]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 48W9Bz4ZNmzMqYkl; Mon,  2 Mar
        2020 06:26:19 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.0B.48498.B07AC5E5; Mon,  2 Mar 2020 15:26:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200302062619epcas1p3baada4a058b582bc1a75ed9355320979~4aLEtR7JJ0424204242epcas1p3H;
        Mon,  2 Mar 2020 06:26:19 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200302062619epsmtrp214f53cf376e69e2e440ae4bed70d0f9a~4aLEsmjqB1821918219epsmtrp2a;
        Mon,  2 Mar 2020 06:26:19 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-70-5e5ca70bdae2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.EA.06569.B07AC5E5; Mon,  2 Mar 2020 15:26:19 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302062618epsmtip2bbe06843044dba37deab5b9d34777608~4aLEhFtWK2169121691epsmtip2f;
        Mon,  2 Mar 2020 06:26:18 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        linkinjeon@gmail.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v14 05/14] exfat: add file operations
Date:   Mon,  2 Mar 2020 15:21:36 +0900
Message-Id: <20200302062145.1719-6-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302062145.1719-1-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmgS738pg4g8PnFS3+TjrGbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyYXm8x8fRvJost/46wWlx6/4HF4vzf46wO3B6/f01i
        9Ng56y67x/65a9g9dt9sYPPo27KK0ePzJjmPQ9vfsHlsevKWKYAjKscmIzUxJbVIITUvOT8l
        My/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hQJYWyxJxSoFBAYnGxkr6dTVF+
        aUmqQkZ+cYmtUmpBSk6BoUGBXnFibnFpXrpecn6ulaGBgZEpUGVCTkbfp4WsBfeDKi7f+cna
        wHjBqYuRg0NCwETi9L/KLkYuDiGBHYwSy7sOMkI4nxgl/r66BOV8Y5R41DKXtYuRE6zjyp9Z
        jCC2kMBeRolp9/3hOpo2vmADGcsmoC3xZ4soSI2IgLTEmf5LTCA1zAINTBLNB5rYQRLCAqYS
        nX8ug9ksAqoS05ZPZQOxeQWsJe7OWcIEsUxeYvWGA8wgNqeAjcSdXRcYIWoEJU7OfMICYjMD
        1TRvnc0MskBCoJldYsevK2wQzS4S977/YIGwhSVeHd/CDmFLSXx+t5cN4v9qiY/7mSHCHYwS
        L77bQtjGEjfXb2AFKWEW0JRYv0sfIqwosfP3XEaItXwS7772sEJM4ZXoaBOCKFGV6Lt0GOp6
        aYmu9g9QSz0kNlw4zAQJqn5GidbeM6wTGBVmIflmFpJvZiFsXsDIvIpRLLWgODc9tdiwwAg5
        fjcxgtOtltkOxkXnfA4xCnAwKvHw7ngeHSfEmlhWXJl7iFGCg1lJhNeXEyjEm5JYWZValB9f
        VJqTWnyI0RQY8BOZpUST84G5IK8k3tDUyNjY2MLEzNzM1FhJnPdhpGackEB6YklqdmpqQWoR
        TB8TB6dUA+OKyuaLJw+lnHBImty2SHTrvu83Wrdl5Wxysr8abRtq5D2P99FHvbjTNT4BfMZT
        87kETa4e3yef8f1a/U6x5Nm3DUVmaohcuLH0oPtyubw1n4wuNctoXTqepL1kRt4kf6dMvv+a
        ZwLqDGbrt4oe1M9hPHNbbw7rXGWD6xOvemXP3ydrveFsz0olluKMREMt5qLiRACxg3Q1zQMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJXpd7eUycwZfZ7BZ/Jx1jt2hevJ7N
        YuXqo0wW1+/eYrbYs/cki8XlXXPYLH5Mr7eYePo3k8WWf0dYLS69/8Bicf7vcVYHbo/fvyYx
        euycdZfdY//cNeweu282sHn0bVnF6PF5k5zHoe1v2Dw2PXnLFMARxWWTkpqTWZZapG+XwJXR
        92kha8H9oIrLd36yNjBecOpi5OSQEDCRuPJnFmMXIxeHkMBuRokbreeZIRLSEsdOnAGyOYBs
        YYnDh4shaj4wStyb9ZYFJM4moC3xZ4soSLkIUPmZ/ktMIDXMAj1MEp+nLGYCSQgLmEp0/rnM
        DmKzCKhKTFs+lQ3E5hWwlrg7ZwkTxC55idUbDoDt5RSwkbiz6wIjiC0EVPP0xV1miHpBiZMz
        n4DtZRZQl1g/TwgkzAzU2rx1NvMERsFZSKpmIVTNQlK1gJF5FaNkakFxbnpusWGBUV5quV5x
        Ym5xaV66XnJ+7iZGcBRpae1gPHEi/hCjAAejEg/vjufRcUKsiWXFlbmHGCU4mJVEeH05gUK8
        KYmVValF+fFFpTmpxYcYpTlYlMR55fOPRQoJpCeWpGanphakFsFkmTg4pRoYI/fWdWS/lfty
        ds7J0q6GaG23+8bpmgc8bFep3Wp/PbXB1tWId64Ao26bsuj6sve/H4vcvDjvyYlFp9suVd22
        vh9swjFzAXesV9h/vRudnIlWPatUxZY+jWiSOCj0JUG18xa3NI9O35pXk2ybX8nLBSwptz3R
        3Kxs3NXItknrs3jnnoevF0YqsRRnJBpqMRcVJwIAkdOvsp4CAAA=
X-CMS-MailID: 20200302062619epcas1p3baada4a058b582bc1a75ed9355320979
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200302062619epcas1p3baada4a058b582bc1a75ed9355320979
References: <20200302062145.1719-1-namjae.jeon@samsung.com>
        <CGME20200302062619epcas1p3baada4a058b582bc1a75ed9355320979@epcas1p3.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the implementation of file operations for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/exfat/file.c | 360 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 360 insertions(+)
 create mode 100644 fs/exfat/file.c

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
new file mode 100644
index 000000000000..483f683757aa
--- /dev/null
+++ b/fs/exfat/file.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/slab.h>
+#include <linux/cred.h>
+#include <linux/buffer_head.h>
+
+#include "exfat_raw.h"
+#include "exfat_fs.h"
+
+static int exfat_cont_expand(struct inode *inode, loff_t size)
+{
+	struct address_space *mapping = inode->i_mapping;
+	loff_t start = i_size_read(inode), count = size - i_size_read(inode);
+	int err, err2;
+
+	err = generic_cont_expand_simple(inode, size);
+	if (err)
+		return err;
+
+	inode->i_ctime = inode->i_mtime = current_time(inode);
+	mark_inode_dirty(inode);
+
+	if (!IS_SYNC(inode))
+		return 0;
+
+	err = filemap_fdatawrite_range(mapping, start, start + count - 1);
+	err2 = sync_mapping_buffers(mapping);
+	if (!err)
+		err = err2;
+	err2 = write_inode_now(inode, 1);
+	if (!err)
+		err = err2;
+	if (err)
+		return err;
+
+	return filemap_fdatawait_range(mapping, start, start + count - 1);
+}
+
+static bool exfat_allow_set_time(struct exfat_sb_info *sbi, struct inode *inode)
+{
+	mode_t allow_utime = sbi->options.allow_utime;
+
+	if (!uid_eq(current_fsuid(), inode->i_uid)) {
+		if (in_group_p(inode->i_gid))
+			allow_utime >>= 3;
+		if (allow_utime & MAY_WRITE)
+			return true;
+	}
+
+	/* use a default check */
+	return false;
+}
+
+static int exfat_sanitize_mode(const struct exfat_sb_info *sbi,
+		struct inode *inode, umode_t *mode_ptr)
+{
+	mode_t i_mode, mask, perm;
+
+	i_mode = inode->i_mode;
+
+	mask = (S_ISREG(i_mode) || S_ISLNK(i_mode)) ?
+		sbi->options.fs_fmask : sbi->options.fs_dmask;
+	perm = *mode_ptr & ~(S_IFMT | mask);
+
+	/* Of the r and x bits, all (subject to umask) must be present.*/
+	if ((perm & 0555) != (i_mode & 0555))
+		return -EPERM;
+
+	if (exfat_mode_can_hold_ro(inode)) {
+		/*
+		 * Of the w bits, either all (subject to umask) or none must
+		 * be present.
+		 */
+		if ((perm & 0222) && ((perm & 0222) != (0222 & ~mask)))
+			return -EPERM;
+	} else {
+		/*
+		 * If exfat_mode_can_hold_ro(inode) is false, can't change
+		 * w bits.
+		 */
+		if ((perm & 0222) != (0222 & ~mask))
+			return -EPERM;
+	}
+
+	*mode_ptr &= S_IFMT | perm;
+
+	return 0;
+}
+
+/* resize the file length */
+int __exfat_truncate(struct inode *inode, loff_t new_size)
+{
+	unsigned int num_clusters_new, num_clusters_phys;
+	unsigned int last_clu = EXFAT_FREE_CLUSTER;
+	struct exfat_chain clu;
+	struct exfat_dentry *ep, *ep2;
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+	struct exfat_entry_set_cache *es = NULL;
+	int evict = (ei->dir.dir == DIR_DELETED) ? 1 : 0;
+
+	/* check if the given file ID is opened */
+	if (ei->type != TYPE_FILE && ei->type != TYPE_DIR)
+		return -EPERM;
+
+	exfat_set_vol_flags(sb, VOL_DIRTY);
+
+	num_clusters_new = EXFAT_B_TO_CLU_ROUND_UP(i_size_read(inode), sbi);
+	num_clusters_phys =
+		EXFAT_B_TO_CLU_ROUND_UP(EXFAT_I(inode)->i_size_ondisk, sbi);
+
+	exfat_chain_set(&clu, ei->start_clu, num_clusters_phys, ei->flags);
+
+	if (new_size > 0) {
+		/*
+		 * Truncate FAT chain num_clusters after the first cluster
+		 * num_clusters = min(new, phys);
+		 */
+		unsigned int num_clusters =
+			min(num_clusters_new, num_clusters_phys);
+
+		/*
+		 * Follow FAT chain
+		 * (defensive coding - works fine even with corrupted FAT table
+		 */
+		if (clu.flags == ALLOC_NO_FAT_CHAIN) {
+			clu.dir += num_clusters;
+			clu.size -= num_clusters;
+		} else {
+			while (num_clusters > 0) {
+				last_clu = clu.dir;
+				if (exfat_get_next_cluster(sb, &(clu.dir)))
+					return -EIO;
+
+				num_clusters--;
+				clu.size--;
+			}
+		}
+	} else {
+		ei->flags = ALLOC_NO_FAT_CHAIN;
+		ei->start_clu = EXFAT_EOF_CLUSTER;
+	}
+
+	i_size_write(inode, new_size);
+
+	if (ei->type == TYPE_FILE)
+		ei->attr |= ATTR_ARCHIVE;
+
+	/* update the directory entry */
+	if (!evict) {
+		struct timespec64 ts;
+
+		es = exfat_get_dentry_set(sb, &(ei->dir), ei->entry,
+				ES_ALL_ENTRIES, &ep);
+		if (!es)
+			return -EIO;
+		ep2 = ep + 1;
+
+		ts = current_time(inode);
+		exfat_set_entry_time(sbi, &ts,
+				&ep->dentry.file.modify_tz,
+				&ep->dentry.file.modify_time,
+				&ep->dentry.file.modify_date,
+				&ep->dentry.file.modify_time_ms);
+		ep->dentry.file.attr = cpu_to_le16(ei->attr);
+
+		/* File size should be zero if there is no cluster allocated */
+		if (ei->start_clu == EXFAT_EOF_CLUSTER) {
+			ep->dentry.stream.valid_size = 0;
+			ep->dentry.stream.size = 0;
+		} else {
+			ep->dentry.stream.valid_size = cpu_to_le64(new_size);
+			ep->dentry.stream.size = ep->dentry.stream.valid_size;
+		}
+
+		if (new_size == 0) {
+			/* Any directory can not be truncated to zero */
+			WARN_ON(ei->type != TYPE_FILE);
+
+			ep2->dentry.stream.flags = ALLOC_FAT_CHAIN;
+			ep2->dentry.stream.start_clu = EXFAT_FREE_CLUSTER;
+		}
+
+		if (exfat_update_dir_chksum_with_entry_set(sb, es,
+		    inode_needs_sync(inode)))
+			return -EIO;
+		kfree(es);
+	}
+
+	/* cut off from the FAT chain */
+	if (ei->flags == ALLOC_FAT_CHAIN && last_clu != EXFAT_FREE_CLUSTER &&
+			last_clu != EXFAT_EOF_CLUSTER) {
+		if (exfat_ent_set(sb, last_clu, EXFAT_EOF_CLUSTER))
+			return -EIO;
+	}
+
+	/* invalidate cache and free the clusters */
+	/* clear exfat cache */
+	exfat_cache_inval_inode(inode);
+
+	/* hint information */
+	ei->hint_bmap.off = EXFAT_EOF_CLUSTER;
+	ei->hint_bmap.clu = EXFAT_EOF_CLUSTER;
+	if (ei->rwoffset > new_size)
+		ei->rwoffset = new_size;
+
+	/* hint_stat will be used if this is directory. */
+	ei->hint_stat.eidx = 0;
+	ei->hint_stat.clu = ei->start_clu;
+	ei->hint_femp.eidx = EXFAT_HINT_NONE;
+
+	/* free the clusters */
+	if (exfat_free_cluster(inode, &clu))
+		return -EIO;
+
+	exfat_set_vol_flags(sb, VOL_CLEAN);
+
+	return 0;
+}
+
+void exfat_truncate(struct inode *inode, loff_t size)
+{
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	unsigned int blocksize = 1 << inode->i_blkbits;
+	loff_t aligned_size;
+	int err;
+
+	mutex_lock(&sbi->s_lock);
+	if (EXFAT_I(inode)->start_clu == 0) {
+		/*
+		 * Empty start_clu != ~0 (not allocated)
+		 */
+		exfat_fs_error(sb, "tried to truncate zeroed cluster.");
+		goto write_size;
+	}
+
+	err = __exfat_truncate(inode, i_size_read(inode));
+	if (err)
+		goto write_size;
+
+	inode->i_ctime = inode->i_mtime = current_time(inode);
+	if (IS_DIRSYNC(inode))
+		exfat_sync_inode(inode);
+	else
+		mark_inode_dirty(inode);
+
+	inode->i_blocks = ((i_size_read(inode) + (sbi->cluster_size - 1)) &
+			~(sbi->cluster_size - 1)) >> inode->i_blkbits;
+write_size:
+	aligned_size = i_size_read(inode);
+	if (aligned_size & (blocksize - 1)) {
+		aligned_size |= (blocksize - 1);
+		aligned_size++;
+	}
+
+	if (EXFAT_I(inode)->i_size_ondisk > i_size_read(inode))
+		EXFAT_I(inode)->i_size_ondisk = aligned_size;
+
+	if (EXFAT_I(inode)->i_size_aligned > i_size_read(inode))
+		EXFAT_I(inode)->i_size_aligned = aligned_size;
+	mutex_unlock(&sbi->s_lock);
+}
+
+int exfat_getattr(const struct path *path, struct kstat *stat,
+		unsigned int request_mask, unsigned int query_flags)
+{
+	struct inode *inode = d_backing_inode(path->dentry);
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+
+	generic_fillattr(inode, stat);
+	stat->result_mask |= STATX_BTIME;
+	stat->btime.tv_sec = ei->i_crtime.tv_sec;
+	stat->btime.tv_nsec = ei->i_crtime.tv_nsec;
+	stat->blksize = EXFAT_SB(inode->i_sb)->cluster_size;
+	return 0;
+}
+
+int exfat_setattr(struct dentry *dentry, struct iattr *attr)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(dentry->d_sb);
+	struct inode *inode = dentry->d_inode;
+	unsigned int ia_valid;
+	int error;
+
+	if ((attr->ia_valid & ATTR_SIZE) &&
+	    attr->ia_size > i_size_read(inode)) {
+		error = exfat_cont_expand(inode, attr->ia_size);
+		if (error || attr->ia_valid == ATTR_SIZE)
+			return error;
+		attr->ia_valid &= ~ATTR_SIZE;
+	}
+
+	/* Check for setting the inode time. */
+	ia_valid = attr->ia_valid;
+	if ((ia_valid & (ATTR_MTIME_SET | ATTR_ATIME_SET | ATTR_TIMES_SET)) &&
+	    exfat_allow_set_time(sbi, inode)) {
+		attr->ia_valid &= ~(ATTR_MTIME_SET | ATTR_ATIME_SET |
+				ATTR_TIMES_SET);
+	}
+
+	error = setattr_prepare(dentry, attr);
+	attr->ia_valid = ia_valid;
+	if (error)
+		goto out;
+
+	if (((attr->ia_valid & ATTR_UID) &&
+	     !uid_eq(attr->ia_uid, sbi->options.fs_uid)) ||
+	    ((attr->ia_valid & ATTR_GID) &&
+	     !gid_eq(attr->ia_gid, sbi->options.fs_gid)) ||
+	    ((attr->ia_valid & ATTR_MODE) &&
+	     (attr->ia_mode & ~(S_IFREG | S_IFLNK | S_IFDIR | 0777)))) {
+		error = -EPERM;
+		goto out;
+	}
+
+	/*
+	 * We don't return -EPERM here. Yes, strange, but this is too
+	 * old behavior.
+	 */
+	if (attr->ia_valid & ATTR_MODE) {
+		if (exfat_sanitize_mode(sbi, inode, &attr->ia_mode) < 0)
+			attr->ia_valid &= ~ATTR_MODE;
+	}
+
+	if (attr->ia_valid & ATTR_SIZE) {
+		error = exfat_block_truncate_page(inode, attr->ia_size);
+		if (error)
+			goto out;
+
+		down_write(&EXFAT_I(inode)->truncate_lock);
+		truncate_setsize(inode, attr->ia_size);
+		exfat_truncate(inode, attr->ia_size);
+		up_write(&EXFAT_I(inode)->truncate_lock);
+	}
+
+	setattr_copy(inode, attr);
+	mark_inode_dirty(inode);
+
+out:
+	return error;
+}
+
+const struct file_operations exfat_file_operations = {
+	.llseek      = generic_file_llseek,
+	.read_iter   = generic_file_read_iter,
+	.write_iter  = generic_file_write_iter,
+	.mmap        = generic_file_mmap,
+	.fsync       = generic_file_fsync,
+	.splice_read = generic_file_splice_read,
+};
+
+const struct inode_operations exfat_file_inode_operations = {
+	.setattr     = exfat_setattr,
+	.getattr     = exfat_getattr,
+};
-- 
2.17.1

