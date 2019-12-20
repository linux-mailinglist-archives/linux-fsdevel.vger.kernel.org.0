Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B29181275C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 07:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfLTG23 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 01:28:29 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:38344 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfLTG1l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 01:27:41 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191220062737epoutp0320bdb886f0f9c823a0488d969c7f2984~iAGYAoWLX1199711997epoutp03I
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2019 06:27:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191220062737epoutp0320bdb886f0f9c823a0488d969c7f2984~iAGYAoWLX1199711997epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576823257;
        bh=cO+GUYiBMvjYEv9739sfEIroe+wTPfcnZN1piWL+gcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rqbV6UrrL/0EgwktKPxhTQs/nGEX5y2CGeXuJR6bRtoSJTuK3P9iMGb6gWoLTp3Ln
         /QiobqOhWTJRDPR33pwst5i1xbfD5DkaLUYvu/Ztqh1lqkFEeTEiS8f/AGcjus25qm
         Novb65JoJFOI1LG1pxJ86zzisL/mkIujn1+FAtAQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191220062737epcas1p1173e7292be0df29558c57f30ab6941d1~iAGXvGmxg1442014420epcas1p1R;
        Fri, 20 Dec 2019 06:27:37 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.165]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47fJh81cRQzMqYlm; Fri, 20 Dec
        2019 06:27:36 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.1E.57028.6D96CFD5; Fri, 20 Dec 2019 15:27:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191220062734epcas1p2ba4db24017a2eca92eeeedd101200a7f~iAGVVPFnc0239502395epcas1p2a;
        Fri, 20 Dec 2019 06:27:34 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191220062734epsmtrp1d8790ee477d79f27c93177e37da8f3c2~iAGVUeWQt2110821108epsmtrp1N;
        Fri, 20 Dec 2019 06:27:34 +0000 (GMT)
X-AuditID: b6c32a35-50bff7000001dec4-f6-5dfc69d6e0e2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.BA.06569.6D96CFD5; Fri, 20 Dec 2019 15:27:34 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191220062734epsmtip11c4867ebcb459c5f50631be883f3eded~iAGVJAXrG2891928919epsmtip1n;
        Fri, 20 Dec 2019 06:27:34 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v8 05/13] exfat: add file operations
Date:   Fri, 20 Dec 2019 01:24:11 -0500
Message-Id: <20191220062419.23516-6-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220062419.23516-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmru71zD+xBgs6GS2aF69ns1i5+iiT
        xfW7t5gt9uw9yWJxedccNosf0+sttvw7wmpx6f0HFgcOj52z7rJ77J+7ht1j980GNo++LasY
        PT5vkvM4tP0NWwBbVI5NRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2S
        i0+ArltmDtA9SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCQ4MCveLE3OLSvHS9
        5PxcK0MDAyNToMqEnIzdD2+zFjz3rei928LewLjProuRk0NCwETiy44d7CC2kMAORoll10O6
        GLmA7E+MEis2fmGHcL4xSqy8dJcRpuPX7HusEIm9jBIdPTAOUMvZD7vYuhg5ONgEtCX+bBEF
        aRARsJfYPPsAC0gNs8AcRokdvbMYQWqEgSYt/6UFUsMioCrRtnwZK4jNK2Aj8XDbV6hl8hKr
        NxxgBrE5BWwlfn99zgQyR0JgDZvE7v2TWCGKXCT2LLgO1SAs8er4FnYIW0riZX8bO8guCYFq
        iY/7mSHCHYwSL77bQtjGEjfXb2AFKWEW0JRYv0sfIqwosfP3XLCJzAJ8Eu++9rBCTOGV6GgT
        gihRlei7dJgJwpaW6Gr/ALXUQ2LpkbNMkBCZwCgx60Ej2wRGuVkIGxYwMq5iFEstKM5NTy02
        LDBEjq9NjODkpmW6g3HKOZ9DjAIcjEo8vA5pv2OFWBPLiitzDzFKcDArifDe7vgZK8SbklhZ
        lVqUH19UmpNafIjRFBiQE5mlRJPzgYk3ryTe0NTI2NjYwsTM3MzUWEmcl+PHxVghgfTEktTs
        1NSC1CKYPiYOTqkGxg2e614HG8zUWa0sJ2RkbvrIdjFT/4V3Rmbrrf/uPSPsueS6UGr/owru
        qyIvLjBrqXSszCtZKcXZe7AzK+Cln7P//4gzd0p5H01f/XbO/4W8yc1x4YceB72Y+iTJ90hA
        PNOTNX7ZL87fOfKv4vSEZ+4HbJstb/jlFPTfD/uTZiBvkHBL+E/gYyWW4oxEQy3mouJEAL61
        P2iEAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSnO61zD+xBqc3aVk0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbbPl3hNXi0vsPLA4cHjtn3WX32D93DbvH7psNbB59W1Yx
        enzeJOdxaPsbtgC2KC6blNSczLLUIn27BK6M3Q9vsxY8963ovdvC3sC4z66LkZNDQsBE4tfs
        e6xdjFwcQgK7GSW2/5/NDJGQljh24gyQzQFkC0scPlwMUfOBUeLj5H4WkDibgLbEny2iIOUi
        Ao4SvbsOs4DUMAssYpR493EyK0iNMNCC5b+0QGpYBFQl2pYvYwWxeQVsJB5u+8oIsUpeYvWG
        A2BrOQVsJX5/fc4EYgsB1TRuW8M4gZFvASPDKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT8
        3E2M4CDU0trBeOJE/CFGAQ5GJR5eh7TfsUKsiWXFlbmHGCU4mJVEeG93/IwV4k1JrKxKLcqP
        LyrNSS0+xCjNwaIkziuffyxSSCA9sSQ1OzW1ILUIJsvEwSnVwOh5SrZhEteRp+nLdZWyPybd
        93+3Yl3uN6V+1+//t7Ty9Hr+evzHZ976GpaZXr8k5eeciXLiYj32XkTc7ee32NayGc/vM8kb
        Fq+KXyzvHO8vcuRr3hk9M14bt/vJDS4vMpp+bj0x4/ACJsb1W+3Tc86I91e4d0gfOmjgcf1F
        VxLXnDQTrvS8fiWW4oxEQy3mouJEAAlkkWk+AgAA
X-CMS-MailID: 20191220062734epcas1p2ba4db24017a2eca92eeeedd101200a7f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191220062734epcas1p2ba4db24017a2eca92eeeedd101200a7f
References: <20191220062419.23516-1-namjae.jeon@samsung.com>
        <CGME20191220062734epcas1p2ba4db24017a2eca92eeeedd101200a7f@epcas1p2.samsung.com>
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
index 000000000000..3baa46c09c99
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
+	unsigned int last_clu = EXFAT_FREE_CLUSTER;
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
+		if (ei->start_clu == EXFAT_EOF_CLUSTER)
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
+			ep2->stream_start_clu = EXFAT_FREE_CLUSTER;
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

