Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4061020FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 10:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfKSJk2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 04:40:28 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:40674 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfKSJk1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:40:27 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191119094024epoutp020f738416d205ab4689d8361b71f6b610~Yhu2kvLOB0392003920epoutp02E
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2019 09:40:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191119094024epoutp020f738416d205ab4689d8361b71f6b610~Yhu2kvLOB0392003920epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574156425;
        bh=UynEUjd2J6AJBENA5flggnmE+/uNET28DrdikmIOav4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bJxM0+lHm1snwimsEnnMZCnnDHOjB1Nxi8DA2tGoaBhhuho4/VSIJDXV+Unie55n2
         Jk8qo+RwL2AuZ/hBlkiE4u/7dQwLUQj4R5/y0X2kor0CnchIIiIfZcOcCfKqtlykoo
         AjxrCQopEQC3HaAB2p7o2UPIvzuEMYW5zlPkHytM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191119094024epcas1p1d0ee8b3a257efb0fa6fc80197a3e27be~Yhu2FBwrt0953109531epcas1p1y;
        Tue, 19 Nov 2019 09:40:24 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.165]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47HLQv3rMSzMqYkh; Tue, 19 Nov
        2019 09:40:23 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.73.04235.788B3DD5; Tue, 19 Nov 2019 18:40:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191119094023epcas1p157ea65111e4564d5da2f64f168440e2a~Yhu0xkJ0F0953109531epcas1p1t;
        Tue, 19 Nov 2019 09:40:23 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191119094023epsmtrp1866ca99a99cd538a79e23b0734327db6~Yhu0w7pVv0081500815epsmtrp1b;
        Tue, 19 Nov 2019 09:40:23 +0000 (GMT)
X-AuditID: b6c32a36-defff7000000108b-fe-5dd3b8871094
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.92.03814.688B3DD5; Tue, 19 Nov 2019 18:40:22 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191119094022epsmtip235dc2583aa03976649d0d7c31fe727cf~Yhu0ln2fy0708907089epsmtip2D;
        Tue, 19 Nov 2019 09:40:22 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v3 05/13] exfat: add file operations
Date:   Tue, 19 Nov 2019 04:37:10 -0500
Message-Id: <20191119093718.3501-6-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119093718.3501-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTURzm7G5319HqMq1O9lqXijTMzbl5K62gqAvNkAIDy+yiFyfuxe6d
        PSQSsjQptYgES0iToCyWuXRzmktnTYJKhdTK6IFZ4rMyBV9tu4v67/f7zvf7vu/8zsEQ2Xk0
        HMsycozFSOsJVCKsb4uIjipwdKcqLjetJdu+XBWT527bUPJuTbuA7Ol/i5BNzR1CsrvxJkou
        lA+KyOmys6R93iMiu8bGhbsklLO8X0y1VNwXU66+PJQqtt8DVN2LXOrnozVUa8MwSr37Wi9M
        wlL08TqGzmAscsaYbsrIMmYmEPsPpe1OU2sUyijlVjKOkBtpA5NA7NEmRe3N0vsiEvIcWm/1
        QUk0yxLRO+ItJivHyHUmlksgGHOG3qxUmLewtIG1GjO3pJsM25QKRYzaxzyu13157wXmae3J
        IdcnNA88SygCIRjEY2FZRa2wCEgwGe4A8Fn1NQHf/ACw7o0L5ZvfAFZf7AN/RzrcC0FWM4C1
        16fE/oPASP6r9UUAw1B8M5y1L/XDYfhOWHfDHbBAcA+A336VBvihPqGb/U0BUSG+ARYXTAj8
        tRTfDh2TNgFvthbWPHQj/joEj4efbtwBfiGIe1FYOdcQTLQHtrvaRHwdCoee28V8HQ6/l1wQ
        +wNBPBdOtCA8XOgLMRW8vwr22R6K/BQEj4C2xmgeXgedMxUBdQRfDEcnL4l4FSksvCDjKb7E
        XW3BlCthUcF40JSC+WNuEb+eEgC9nlqkFKwp/+dwC4B7YBljZg2ZDKs0x/z/YI9A4AtGahyg
        6qW2FeAYIBZJveu7U2UiOoc9ZWgFEEOIMOmBz69TZdIM+tRpxmJKs1j1DNsK1L5FXkHCl6ab
        fB/ayKUp1TEqlYqM1cRp1CpiuRSb7kyV4Zk0x2QzjJmx/J0TYCHheSCPHMite/D4ZaF1R8FC
        vJujvYkjXLGn83hysa5n0+TTuXcdtCfxifMo9V1yIrmknHPipasqG/dFxshWHKlaMpKyKLHz
        YG8pN/PY62wZ6v0wbnNIXo/1vv8YQZzZmD1fMzzQUKYZ3zCFjob+OqxNlg/iL9jNY9Zj7Qc3
        umZX27sIIaujlZGIhaX/AGSUo9aYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWy7bCSvG7bjsuxBts/WlkcfjyJ3aJ58Xo2
        i5WrjzJZXL97i9liz96TLBaXd81hs/g/6zmrxY/p9RZb/h1htbj0/gOLA5fHzll32T32z13D
        7rH7ZgObR9+WVYwem09Xe3zeJOdxaPsbNo/bz7axBHBEcdmkpOZklqUW6dslcGU8vnOCseCH
        T8Wr3Q/ZGhiP2XYxcnJICJhInDzwn6mLkYtDSGA3o8S1a5fZIRLSEsdOnGHuYuQAsoUlDh8u
        hqj5wChxov8uE0icTUBb4s8WUZByEQFHid5dh1lAapgFzjFK7Hy2jBEkIQy0YM7dPWA2i4Cq
        RF/7RyYQm1fAWmLH1/VMELvkJVZvOMAMYnMK2Eg8nA3RKwRU0/iomX0CI98CRoZVjJKpBcW5
        6bnFhgVGeanlesWJucWleel6yfm5mxjBwaqltYPxxIn4Q4wCHIxKPLwnVC7HCrEmlhVX5h5i
        lOBgVhLh9Xt0IVaINyWxsiq1KD++qDQntfgQozQHi5I4r3z+sUghgfTEktTs1NSC1CKYLBMH
        p1QDo53sjrBavW/P1Ldp7meeu/v01nzmR1Ea1ybVNgqW/2F9p+Bgb8aqMzctPLK5KVORwdX5
        5gb37bwfDJbuWL9v7d95fvvb3YvlThjkzbD/06642nqqtcViOb0ttxcqHDtjGR7sfexx4qqt
        kUwpSU4BM4VSjmTZzG147ijw6uyyk3LdarL1YTfPKLEUZyQaajEXFScCAIIfHCJSAgAA
X-CMS-MailID: 20191119094023epcas1p157ea65111e4564d5da2f64f168440e2a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191119094023epcas1p157ea65111e4564d5da2f64f168440e2a
References: <20191119093718.3501-1-namjae.jeon@samsung.com>
        <CGME20191119094023epcas1p157ea65111e4564d5da2f64f168440e2a@epcas1p1.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the implementation of file operations for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/file.c | 346 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 346 insertions(+)
 create mode 100644 fs/exfat/file.c

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
new file mode 100644
index 000000000000..5afd65a36eb5
--- /dev/null
+++ b/fs/exfat/file.c
@@ -0,0 +1,346 @@
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
+static int exfat_allow_set_time(struct exfat_sb_info *sbi, struct inode *inode)
+{
+	mode_t allow_utime = sbi->options.allow_utime;
+
+	if (!uid_eq(current_fsuid(), inode->i_uid)) {
+		if (in_group_p(inode->i_gid))
+			allow_utime >>= 3;
+		if (allow_utime & MAY_WRITE)
+			return 1;
+	}
+
+	/* use a default check */
+	return 0;
+}
+
+static int exfat_sanitize_mode(const struct exfat_sb_info *sbi,
+		struct inode *inode, umode_t *mode_ptr)
+{
+	mode_t i_mode, mask, perm;
+
+	i_mode = inode->i_mode;
+
+	if (S_ISREG(i_mode) || S_ISLNK(i_mode))
+		mask = sbi->options.fs_fmask;
+	else
+		mask = sbi->options.fs_dmask;
+
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
+	unsigned int last_clu = FREE_CLUSTER;
+	struct exfat_chain clu;
+	struct exfat_timestamp tm;
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
+		if (clu.flags == 0x03) {
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
+		ei->flags = 0x03;
+		ei->start_clu = EOF_CLUSTER;
+	}
+
+	i_size_write(inode, new_size);
+
+	if (ei->type == TYPE_FILE)
+		ei->attr |= ATTR_ARCHIVE;
+
+	/* update the directory entry */
+	if (!evict) {
+		es = exfat_get_dentry_set(sb, &(ei->dir), ei->entry,
+				ES_ALL_ENTRIES, &ep);
+		if (!es)
+			return -EIO;
+		ep2 = ep + 1;
+
+		exfat_set_entry_time(ep, exfat_tm_now(EXFAT_SB(sb), &tm),
+				TM_MODIFY);
+		ep->file_attr = cpu_to_le16(ei->attr);
+
+		/* File size should be zero if there is no cluster allocated */
+		if (ei->start_clu == EOF_CLUSTER)
+			ep->stream_valid_size = ep->stream_size = 0;
+		else {
+			ep->stream_valid_size = cpu_to_le64(new_size);
+			ep->stream_size = ep->stream_valid_size;
+		}
+
+		if (new_size == 0) {
+			/* Any directory can not be truncated to zero */
+			WARN_ON(ei->type != TYPE_FILE);
+
+			ep2->stream_flags = 0x01;
+			ep2->stream_start_clu = FREE_CLUSTER;
+		}
+
+		if (exfat_update_dir_chksum_with_entry_set(sb, es,
+		    inode_needs_sync(inode)))
+			return -EIO;
+		kfree(es);
+	}
+
+	/* cut off from the FAT chain */
+	if (ei->flags == 0x01 && last_clu != FREE_CLUSTER &&
+			last_clu != EOF_CLUSTER) {
+		if (exfat_ent_set(sb, last_clu, EOF_CLUSTER))
+			return -EIO;
+	}
+
+	/* invalidate cache and free the clusters */
+	/* clear exfat cache */
+	exfat_cache_inval_inode(inode);
+
+	/* hint information */
+	ei->hint_bmap.off = EOF_CLUSTER;
+	ei->hint_bmap.clu = EOF_CLUSTER;
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
+		goto out;
+	}
+
+	err = __exfat_truncate(inode, i_size_read(inode));
+	if (err)
+		goto out;
+
+	inode->i_ctime = inode->i_mtime = current_time(inode);
+	if (IS_DIRSYNC(inode))
+		exfat_sync_inode(inode);
+	else
+		mark_inode_dirty(inode);
+
+	inode->i_blocks = ((i_size_read(inode) + (sbi->cluster_size - 1)) &
+			~(sbi->cluster_size - 1)) >> inode->i_blkbits;
+out:
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
+
+	generic_fillattr(inode, stat);
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
+		return error;
+
+	if (((attr->ia_valid & ATTR_UID) &&
+	     !uid_eq(attr->ia_uid, sbi->options.fs_uid)) ||
+	    ((attr->ia_valid & ATTR_GID) &&
+	     !gid_eq(attr->ia_gid, sbi->options.fs_gid)) ||
+	    ((attr->ia_valid & ATTR_MODE) &&
+	     (attr->ia_mode & ~(S_IFREG | S_IFLNK | S_IFDIR | 0777))))
+		return -EPERM;
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
+		down_write(&EXFAT_I(inode)->truncate_lock);
+		truncate_setsize(inode, attr->ia_size);
+		exfat_truncate(inode, attr->ia_size);
+		up_write(&EXFAT_I(inode)->truncate_lock);
+	}
+
+	setattr_copy(inode, attr);
+	mark_inode_dirty(inode);
+
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

