Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28D021085DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 01:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfKYAHQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Nov 2019 19:07:16 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:36306 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfKYAGe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Nov 2019 19:06:34 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191125000632epoutp036f3cdaa2b4586f234d62c17c888325cb~aPxgUcgdr1698316983epoutp03H
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2019 00:06:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191125000632epoutp036f3cdaa2b4586f234d62c17c888325cb~aPxgUcgdr1698316983epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574640392;
        bh=q8NHNkei2g+2E93N4CekuUTdRWeizLX7oaRQaekENwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TV/G+eswMnNJDjPUPVo/9ReujFUzJdOf0AMIUgGKV5cq4RiONOYvCjXIrQVSK0Ac8
         pZx/bZX+t4u+Ws1QxSJcm3A6oIJ9pyaqY39dKMtEItAouB2/jqNq9sTgju5RojJIcd
         TXsA9ohRUiuEDQVgmDQsmMTkOFeqy3Dgj5x2jTBg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191125000631epcas1p1ba1718fe19df9bf46b9a421e78b5149b~aPxf7-4D90109001090epcas1p1E;
        Mon, 25 Nov 2019 00:06:31 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.160]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47LnPy68q5zMqYkq; Mon, 25 Nov
        2019 00:06:30 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.23.48498.60B1BDD5; Mon, 25 Nov 2019 09:06:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191125000630epcas1p2f4bf0b1ca1a8cc4327f120060ca0a9f1~aPxenFgY60613906139epcas1p2q;
        Mon, 25 Nov 2019 00:06:30 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191125000630epsmtrp2c68db4d88fa6681e46cdacd6bd6f2a4f~aPxemLgBO2415424154epsmtrp2k;
        Mon, 25 Nov 2019 00:06:30 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-a1-5ddb1b0695aa
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.11.06569.60B1BDD5; Mon, 25 Nov 2019 09:06:30 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191125000630epsmtip237eaadca121b32279052b11ec5b419db~aPxeeFPO01614516145epsmtip2i;
        Mon, 25 Nov 2019 00:06:30 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de, nborisov@suse.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v5 05/13] exfat: add file operations
Date:   Sun, 24 Nov 2019 19:03:18 -0500
Message-Id: <20191125000326.24561-6-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191125000326.24561-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHOd7H7qzFbWoeJtW8NUhD3ZyzWzkrMrvhREOKKIZe3EWlvdyd
        valRpiIW9jQsIYweauJrqZlroVnZOyVMpxEE9iStsEkv27y9/vue3/l8v78fv3MIRFqGy4g8
        s52zmVkjhQeird0Ryig8zKNXdg7H0t0vj4roA+cacLqmrieAHhgZQuhOVy9K93ecwempylcY
        PVmxj556X4jSzp83MbpvbBxdOYO5WjkiYtxVl0XMtUEHzhx21gKmwfkUZVru7WY+N89jutre
        44xntBVNF282JuRyrIGzyTlztsWQZ87RUikZmaszNfFKVZRqKb2EkptZE6elknTpUcl5Rt+w
        lHwbayzwldJZnqdiEhNslgI7J8+18HYtxVkNRqtKaY3mWRNfYM6JzraYlqmUyliNj8wy5h7r
        bQ6wNqXuqLiU4AAliaVATEAyDvaMleJ+LSXbAXR5w0tBoE9/ArD263EgHL4A+GbSDf44vNVl
        IsHhAtA7LP3rePTc64MIAicXw+/OED8TTK6ALadvoH4GIQcAHB06hfkvgnxBp08KQSipgHXF
        xdNjSMgE2Hn/PC40mw/rGm8gfi0mtfDO3VbEHwRJDw4nmsZRAUqCJ93Vv6cLgm9vO0WClsHP
        H1y4fyBI7oYf3YhQLgHwtVcraDUcbGjE/AhCRsCGjhihHA6vfquaTkTIWfDDRBkmpEhgSZFU
        QBTwcF93gKDDYGnxuEhAGHjinUnYSDmA1w8dx8rBvMp/Dc4CUAvmcFbelMPxKmvs/6/VDKZ/
        YmR8O6h+qOsCJAGomZLG+iG9FGO38TtNXQASCBUsSX7wTC+VGNiduzibJdNWYOT4LqDx7fEI
        IgvJtvj+tdmeqdLEqtVqOi5+SbxGTYVKiMkneimZw9q5rRxn5Wx/fAGEWOYAii0fH9c7ytfq
        UwqL9+jT5HNkU57e/eJE6kuZe/Yk19/21XAhuc2Apl5bfyR41bpDgx13Q+8NFGVVZGU7pMsV
        azr35rteRI+sjijyHByt0S3EtutTz+aHKQofLGA2RcozbNgstVu3J7SQ+rHRWLImLVG7aGLD
        hOfKxaW35uqqWkIplM9lVZGIjWd/AdIFkXmfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSvC6b9O1Yg1Pr5CwOP57EbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyf9ZzV4sf0eov/b1pYLLb8O8Jqcen9BxYHbo+ds+6y
        e+yfu4bdY/fNBjaPvi2rGD3Wb7nK4rH5dLXH501yHoe2v2HzuP1sG0sAZxSXTUpqTmZZapG+
        XQJXxuSTm5gKNvpWTF9h08DYYdfFyMkhIWAi8X1RD3sXIxeHkMBuRomZK48zQSSkJY6dOMPc
        xcgBZAtLHD5cDFHzgVHi9cZWRpA4m4C2xJ8toiDlIgKOEr27DrOA1DALPGaUOHH+CSNIQhho
        wexpIAs4OVgEVCVWt7ezgdi8AjYSe84sZYPYJS+xesMBZhCbU8BW4sSpbWC2EFBN+6GjbBMY
        +RYwMqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAgOXy2tHYwnTsQfYhTgYFTi4eXY
        cCtWiDWxrLgy9xCjBAezkgiv29kbsUK8KYmVValF+fFFpTmpxYcYpTlYlMR55fOPRQoJpCeW
        pGanphakFsFkmTg4pRoYBVa+2mx2907BylcKzhxLVuVt2L0r41pW34r2u2xhBu6JrqX/3C6s
        f7/ITfzpGqtMa7fAZ//3p0cwL+iSkJqv/e7ims1xf3zZii64FL3Qk+PTnx7fX6Aus3Wvp0jo
        B81KLY7jW88F/lnov+O/h3LP2rws5+DfjFNZTlrNEN494cPrlbOfZUZNV2Ipzkg01GIuKk4E
        AE9PtlBbAgAA
X-CMS-MailID: 20191125000630epcas1p2f4bf0b1ca1a8cc4327f120060ca0a9f1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191125000630epcas1p2f4bf0b1ca1a8cc4327f120060ca0a9f1
References: <20191125000326.24561-1-namjae.jeon@samsung.com>
        <CGME20191125000630epcas1p2f4bf0b1ca1a8cc4327f120060ca0a9f1@epcas1p2.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the implementation of file operations for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/file.c | 343 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 343 insertions(+)
 create mode 100644 fs/exfat/file.c

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
new file mode 100644
index 000000000000..1a32a88e2055
--- /dev/null
+++ b/fs/exfat/file.c
@@ -0,0 +1,343 @@
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
+			ep2->stream_flags = ALLOC_FAT_CHAIN;
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
+	if (ei->flags == ALLOC_FAT_CHAIN && last_clu != FREE_CLUSTER &&
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

