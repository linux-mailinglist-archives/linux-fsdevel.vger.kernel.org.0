Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69B5211DE00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 06:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbfLMFyH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 00:54:07 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:21411 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbfLMFxt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 00:53:49 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191213055340epoutp03e3866d8a63a7a4585fae3a5d56deb935~f2HvVW3Ly1349013490epoutp03O
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2019 05:53:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191213055340epoutp03e3866d8a63a7a4585fae3a5d56deb935~f2HvVW3Ly1349013490epoutp03O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576216421;
        bh=i3GFR/xYM+GI/oRMnENvTKn3OUFwFg2UptQQZz5s75I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q69avtdtFS5Jus+Tc5hpBzdd48ls0hqC/xwPXDEe/QSONwb6DYuov1CiNDgi/ptIZ
         D6gwdAuRqx/+lIE3HyzEnr19dJxJOUhqYtOaaiO+9qXi83dnt9vCDjVHtQmMWq7bBt
         OkPFesVay+YEAzz427MeeW77dZLjp0hne9KaAho0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191213055340epcas1p147db8fe8f5db7270b786b142fef9bd39~f2Hu_iFH40207402074epcas1p1p;
        Fri, 13 Dec 2019 05:53:40 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.166]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47Z0GC3S7zzMqYm4; Fri, 13 Dec
        2019 05:53:39 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.00.48019.36723FD5; Fri, 13 Dec 2019 14:53:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191213055339epcas1p2ff141746e3bc076293c7633252387feb~f2HthzPCq1053210532epcas1p2W;
        Fri, 13 Dec 2019 05:53:39 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191213055339epsmtrp1bcbfbabd107917e4e5bef50e1dd3b7dc~f2HthEU6V0541405414epsmtrp1K;
        Fri, 13 Dec 2019 05:53:39 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-b0-5df32763f873
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.92.06569.26723FD5; Fri, 13 Dec 2019 14:53:38 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191213055338epsmtip20c1d7c3f1a296957235868a399bb42ec~f2HtU4nwa1338213382epsmtip2a;
        Fri, 13 Dec 2019 05:53:38 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v7 03/13] exfat: add inode operations
Date:   Fri, 13 Dec 2019 00:50:18 -0500
Message-Id: <20191213055028.5574-4-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191213055028.5574-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7bCmvm6y+udYg/Pd0hbNi9ezWaxcfZTJ
        Ys/ekywWl3fNYbP4Mb3eYsu/I6wWl95/YHFg99g/dw27x+6bDWwefVtWMXp83iTncWj7G7YA
        1qgcm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygK5QU
        yhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BYYGBXrFibnFpXnpesn5uVaGBgZGpkCV
        CTkZPzZ2sxccvctc8XT9AdYGxqsNzF2MHBwSAiYS014EdDFycQgJ7GCUuNa3mxXC+cQoMfPZ
        TxYI5xujRM+u++xdjJxgHZuvTYGq2sso8f77eza4liVLu5hA5rIJaEv82SIK0iAiYC+xefYB
        sEnMAi2MEgtO/2AGSQgLmEr07doMVs8ioCoxrVUeJMwrYC3x8fk9qGXyEqs3HAAr5xSwkZg3
        +QM7yBwJgTlsEg+m9LFCFLlIbNz4lhHCFpZ4dXwLVLOUxMv+NnaIP6slPu5nhgh3MEq8+G4L
        YRtL3Fy/gRWkhFlAU2L9Ln2IsKLEzt9zwSYyC/BJvPvawwoxhVeio00IokRVou/SYSYIW1qi
        q/0D1FIPiT/tnxghIdLPKPHy+kH2CYxysxA2LGBkXMUollpQnJueWmxYYIIcY5sYwclMy2IH
        455zPocYBTgYlXh4GVI+xQqxJpYVV+YeYpTgYFYS4bWvAQrxpiRWVqUW5ccXleakFh9iNAWG
        40RmKdHkfGCizSuJNzQ1MjY2tjAxMzczNVYS5+X4cTFWSCA9sSQ1OzW1ILUIpo+Jg1OqgVF/
        8W/36M2TenovzRVPvH2OrZWP5W323gkeza23J4QK6VS+mHGHM8XoP29X7sxdS1kSLjUKbj23
        eLY3D/OpO99SJnnoZwRLvVi1dr3ZM0tdkctL/7BPunfSc+qap86bfubGv1+hVdq+dObcbwZh
        Zx4+fKdv1bn3gbT/imzF6QHcXDrahrc/y/9XYinOSDTUYi4qTgQA6KvevnwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsWy7bCSvG6S+udYgwePLS2aF69ns1i5+iiT
        xZ69J1ksLu+aw2bxY3q9xZZ/R1gtLr3/wOLA7rF/7hp2j903G9g8+rasYvT4vEnO49D2N2wB
        rFFcNimpOZllqUX6dglcGT82drMXHL3LXPF0/QHWBsarDcxdjJwcEgImEpuvTWHtYuTiEBLY
        zShx7e8sqIS0xLETZ4BsDiBbWOLw4WKImg+MEhPmPAOLswloS/zZIgpSLiLgKNG76zALSA2z
        QBejxKOmb2BzhAVMJfp2bWYCqWcRUJWY1ioPEuYVsJb4+PweO8QqeYnVGw6AlXMK2EjMm/wB
        LC4EVHP37Su2CYx8CxgZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBAedltYOxhMn
        4g8xCnAwKvHwrkj8FCvEmlhWXJl7iFGCg1lJhNe+BijEm5JYWZValB9fVJqTWnyIUZqDRUmc
        Vz7/WKSQQHpiSWp2ampBahFMlomDU6qBUSDBTpFvJmdkxIosU/nrlfn9Cfel7PuKPhzN2rNx
        /T2zzkVcUiv573tUPZ4mKsaxaMrRMqG8c4UBE59PNOjrufjnFcNO43vzF9qKHFvHcb1m8cY5
        U+ZptjS3xoUqSjNxWdr2zVOJrZhW+HmXZ/f0HQqqr3dNdGBot7GI4L50QZtTXiNk03s/JZbi
        jERDLeai4kQA9LBnBDYCAAA=
X-CMS-MailID: 20191213055339epcas1p2ff141746e3bc076293c7633252387feb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191213055339epcas1p2ff141746e3bc076293c7633252387feb
References: <20191213055028.5574-1-namjae.jeon@samsung.com>
        <CGME20191213055339epcas1p2ff141746e3bc076293c7633252387feb@epcas1p2.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the implementation of inode operations for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/inode.c |  694 ++++++++++++++++++++++
 fs/exfat/namei.c | 1459 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 2153 insertions(+)
 create mode 100644 fs/exfat/inode.c
 create mode 100644 fs/exfat/namei.c

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
new file mode 100644
index 000000000000..1d3cffa2df10
--- /dev/null
+++ b/fs/exfat/inode.c
@@ -0,0 +1,694 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/init.h>
+#include <linux/buffer_head.h>
+#include <linux/mpage.h>
+#include <linux/bio.h>
+#include <linux/blkdev.h>
+#include <linux/time.h>
+#include <linux/writeback.h>
+#include <linux/uio.h>
+#include <linux/random.h>
+#include <linux/iversion.h>
+
+#include "exfat_raw.h"
+#include "exfat_fs.h"
+
+/* 2-level option flag */
+enum {
+	BMAP_NOT_CREATE,
+	BMAP_ADD_CLUSTER,
+};
+
+static int __exfat_write_inode(struct inode *inode, int sync)
+{
+	int ret = -EIO;
+	unsigned long long on_disk_size;
+	struct exfat_timestamp tm;
+	struct exfat_dentry *ep, *ep2;
+	struct exfat_entry_set_cache *es = NULL;
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+	bool is_dir = (ei->type == TYPE_DIR) ? true : false;
+	struct exfat_dir_entry info;
+
+	if (inode->i_ino == EXFAT_ROOT_INO)
+		return 0;
+
+	info.attr = exfat_make_attr(inode);
+	info.size = i_size_read(inode);
+
+	exfat_time_unix2fat(sbi, &inode->i_mtime, &info.modify_timestamp);
+	exfat_time_unix2fat(sbi, &inode->i_ctime, &info.create_timestamp);
+	exfat_time_unix2fat(sbi, &inode->i_atime, &info.access_timestamp);
+
+	/*
+	 * If the indode is already unlinked, there is no need for updating it.
+	 */
+	if (ei->dir.dir == DIR_DELETED)
+		return 0;
+
+	if (is_dir && ei->dir.dir == sbi->root_dir && ei->entry == -1)
+		return 0;
+
+	exfat_set_vol_flags(sb, VOL_DIRTY);
+
+	/* get the directory entry of given file or directory */
+	es = exfat_get_dentry_set(sb, &(ei->dir), ei->entry, ES_ALL_ENTRIES,
+		&ep);
+	if (!es)
+		return -EIO;
+	ep2 = ep + 1;
+
+	ep->file_attr = cpu_to_le16(info.attr);
+
+	/* set FILE_INFO structure using the acquired struct exfat_dentry */
+	tm.sec  = info.create_timestamp.second;
+	tm.min  = info.create_timestamp.minute;
+	tm.hour = info.create_timestamp.hour;
+	tm.day  = info.create_timestamp.day;
+	tm.mon  = info.create_timestamp.month;
+	tm.year = info.create_timestamp.year;
+	exfat_set_entry_time(ep, &tm, TM_CREATE);
+
+	tm.sec  = info.modify_timestamp.second;
+	tm.min  = info.modify_timestamp.minute;
+	tm.hour = info.modify_timestamp.hour;
+	tm.day  = info.modify_timestamp.day;
+	tm.mon  = info.modify_timestamp.month;
+	tm.year = info.modify_timestamp.year;
+	exfat_set_entry_time(ep, &tm, TM_MODIFY);
+
+	/* File size should be zero if there is no cluster allocated */
+	on_disk_size = info.size;
+
+	if (ei->start_clu == EXFAT_EOF_CLUSTER)
+		on_disk_size = 0;
+
+	ep2->stream_valid_size = cpu_to_le64(on_disk_size);
+	ep2->stream_size = ep2->stream_valid_size;
+
+	ret = exfat_update_dir_chksum_with_entry_set(sb, es, sync);
+	kfree(es);
+	return ret;
+}
+
+int exfat_write_inode(struct inode *inode, struct writeback_control *wbc)
+{
+	int ret;
+
+	mutex_lock(&EXFAT_SB(inode->i_sb)->s_lock);
+	ret = __exfat_write_inode(inode, wbc->sync_mode == WB_SYNC_ALL);
+	mutex_unlock(&EXFAT_SB(inode->i_sb)->s_lock);
+
+	return ret;
+}
+
+void exfat_sync_inode(struct inode *inode)
+{
+	lockdep_assert_held(&EXFAT_SB(inode->i_sb)->s_lock);
+	__exfat_write_inode(inode, 1);
+}
+
+/*
+ * Input: inode, (logical) clu_offset, target allocation area
+ * Output: errcode, cluster number
+ * *clu = (~0), if it's unable to allocate a new cluster
+ */
+static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
+		unsigned int *clu, int create)
+{
+	int ret, modified = false;
+	unsigned int last_clu;
+	struct exfat_chain new_clu;
+	struct exfat_dentry *ep;
+	struct exfat_entry_set_cache *es = NULL;
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+	unsigned int local_clu_offset = clu_offset;
+	unsigned int num_to_be_allocated = 0, num_clusters = 0;
+
+	ei->rwoffset = EXFAT_CLU_TO_B(clu_offset, sbi);
+
+	if (EXFAT_I(inode)->i_size_ondisk > 0)
+		num_clusters =
+			EXFAT_B_TO_CLU_ROUND_UP(EXFAT_I(inode)->i_size_ondisk,
+			sbi);
+
+	if (clu_offset >= num_clusters)
+		num_to_be_allocated = clu_offset - num_clusters + 1;
+
+	if (!create && (num_to_be_allocated > 0)) {
+		*clu = EXFAT_EOF_CLUSTER;
+		return 0;
+	}
+
+	*clu = last_clu = ei->start_clu;
+
+	if (ei->flags == ALLOC_NO_FAT_CHAIN) {
+		if (clu_offset > 0 && *clu != EXFAT_EOF_CLUSTER) {
+			last_clu += clu_offset - 1;
+
+			if (clu_offset == num_clusters)
+				*clu = EXFAT_EOF_CLUSTER;
+			else
+				*clu += clu_offset;
+		}
+	} else if (ei->type == TYPE_FILE) {
+		unsigned int fclus = 0;
+		int err = exfat_get_cluster(inode, clu_offset,
+				&fclus, clu, &last_clu, 1);
+		if (err)
+			return -EIO;
+
+		clu_offset -= fclus;
+	} else {
+		/* hint information */
+		if (clu_offset > 0 && ei->hint_bmap.off != EXFAT_EOF_CLUSTER &&
+		    ei->hint_bmap.off > 0 && clu_offset >= ei->hint_bmap.off) {
+			clu_offset -= ei->hint_bmap.off;
+			/* hint_bmap.clu should be valid */
+			WARN_ON(ei->hint_bmap.clu < 2);
+			*clu = ei->hint_bmap.clu;
+		}
+
+		while (clu_offset > 0 && *clu != EXFAT_EOF_CLUSTER) {
+			last_clu = *clu;
+			if (exfat_get_next_cluster(sb, clu))
+				return -EIO;
+			clu_offset--;
+		}
+	}
+
+	if (*clu == EXFAT_EOF_CLUSTER) {
+		exfat_set_vol_flags(sb, VOL_DIRTY);
+
+		new_clu.dir = (last_clu == EXFAT_EOF_CLUSTER) ?
+				EXFAT_EOF_CLUSTER : last_clu + 1;
+		new_clu.size = 0;
+		new_clu.flags = ei->flags;
+
+		/* allocate a cluster */
+		if (num_to_be_allocated < 1) {
+			/* Broken FAT (i_sze > allocated FAT) */
+			exfat_fs_error(sb, "broken FAT chain.");
+			return -EIO;
+		}
+
+		ret = exfat_alloc_cluster(inode, num_to_be_allocated, &new_clu);
+		if (ret)
+			return ret;
+
+		if (new_clu.dir == EXFAT_EOF_CLUSTER ||
+		    new_clu.dir == EXFAT_FREE_CLUSTER) {
+			exfat_fs_error(sb,
+				"bogus cluster new allocated (last_clu : %u, new_clu : %u)",
+				last_clu, new_clu.dir);
+			return -EIO;
+		}
+
+		/* append to the FAT chain */
+		if (last_clu == EXFAT_EOF_CLUSTER) {
+			if (new_clu.flags == ALLOC_FAT_CHAIN)
+				ei->flags = ALLOC_FAT_CHAIN;
+			ei->start_clu = new_clu.dir;
+			modified = true;
+		} else {
+			if (new_clu.flags != ei->flags) {
+				/* no-fat-chain bit is disabled,
+				 * so fat-chain should be synced with
+				 * alloc-bitmap
+				 */
+				exfat_chain_cont_cluster(sb, ei->start_clu,
+					num_clusters);
+				ei->flags = ALLOC_FAT_CHAIN;
+				modified = true;
+			}
+			if (new_clu.flags == ALLOC_FAT_CHAIN)
+				if (exfat_ent_set(sb, last_clu, new_clu.dir))
+					return -EIO;
+		}
+
+		num_clusters += num_to_be_allocated;
+		*clu = new_clu.dir;
+
+		if (ei->dir.dir != DIR_DELETED) {
+			es = exfat_get_dentry_set(sb, &(ei->dir), ei->entry,
+				ES_ALL_ENTRIES, &ep);
+			if (!es)
+				return -EIO;
+			/* get stream entry */
+			ep++;
+
+			/* update directory entry */
+			if (modified) {
+				if (ep->stream_flags != ei->flags)
+					ep->stream_flags = ei->flags;
+
+				if (le32_to_cpu(ep->stream_start_clu) !=
+						ei->start_clu)
+					ep->stream_start_clu =
+						cpu_to_le32(ei->start_clu);
+
+				ep->stream_valid_size =
+					cpu_to_le64(i_size_read(inode));
+				ep->stream_size = ep->stream_valid_size;
+			}
+
+			if (exfat_update_dir_chksum_with_entry_set(sb, es,
+			    inode_needs_sync(inode)))
+				return -EIO;
+			kfree(es);
+
+		} /* end of if != DIR_DELETED */
+
+		inode->i_blocks +=
+			num_to_be_allocated << sbi->sect_per_clus_bits;
+
+		/*
+		 * Move *clu pointer along FAT chains (hole care) because the
+		 * caller of this function expect *clu to be the last cluster.
+		 * This only works when num_to_be_allocated >= 2,
+		 * *clu = (the first cluster of the allocated chain) =>
+		 * (the last cluster of ...)
+		 */
+		if (ei->flags == ALLOC_NO_FAT_CHAIN) {
+			*clu += num_to_be_allocated - 1;
+		} else {
+			while (num_to_be_allocated > 1) {
+				if (exfat_get_next_cluster(sb, clu))
+					return -EIO;
+				num_to_be_allocated--;
+			}
+		}
+
+	}
+
+	/* hint information */
+	ei->hint_bmap.off = local_clu_offset;
+	ei->hint_bmap.clu = *clu;
+
+	return 0;
+}
+
+static int exfat_bmap(struct inode *inode, sector_t sector, sector_t *phys,
+		unsigned long *mapped_blocks, int *create)
+{
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	sector_t last_block;
+	unsigned int cluster, clu_offset, sec_offset;
+	int err = 0;
+
+	*phys = 0;
+	*mapped_blocks = 0;
+
+	last_block = EXFAT_B_TO_BLK_ROUND_UP(i_size_read(inode), sb);
+	if (sector >= last_block && *create == BMAP_NOT_CREATE)
+		return 0;
+
+	/* Is this block already allocated? */
+	clu_offset = sector >> sbi->sect_per_clus_bits;  /* cluster offset */
+
+	err = exfat_map_cluster(inode, clu_offset, &cluster,
+		*create & BMAP_ADD_CLUSTER);
+	if (err) {
+		if (err != -ENOSPC)
+			return -EIO;
+		return err;
+	}
+
+	if (cluster != EXFAT_EOF_CLUSTER) {
+		/* sector offset in cluster */
+		sec_offset = sector & (sbi->sect_per_clus - 1);
+
+		*phys = exfat_cluster_to_sector(sbi, cluster) + sec_offset;
+		*mapped_blocks = sbi->sect_per_clus - sec_offset;
+	}
+
+	if (sector < last_block)
+		*create = BMAP_NOT_CREATE;
+	return 0;
+}
+
+static int exfat_get_block(struct inode *inode, sector_t iblock,
+		struct buffer_head *bh_result, int create)
+{
+	struct super_block *sb = inode->i_sb;
+	unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;
+	int err = 0;
+	unsigned long mapped_blocks;
+	sector_t phys;
+	loff_t pos;
+	int bmap_create = create ? BMAP_ADD_CLUSTER : BMAP_NOT_CREATE;
+
+	mutex_lock(&EXFAT_SB(sb)->s_lock);
+	err = exfat_bmap(inode, iblock, &phys, &mapped_blocks, &bmap_create);
+	if (err) {
+		if (err != -ENOSPC)
+			exfat_fs_error_ratelimit(sb,
+				"failed to bmap (inode : %p iblock : %llu, err : %d)",
+				inode, (unsigned long long)iblock, err);
+		goto unlock_ret;
+	}
+
+	if (phys) {
+		max_blocks = min(mapped_blocks, max_blocks);
+
+		/* Treat newly added block / cluster */
+		if (bmap_create || buffer_delay(bh_result)) {
+			/* Update i_size_ondisk */
+			pos = EXFAT_BLK_TO_B((iblock + 1), sb);
+			if (EXFAT_I(inode)->i_size_ondisk < pos)
+				EXFAT_I(inode)->i_size_ondisk = pos;
+
+			if (bmap_create) {
+				if (buffer_delay(bh_result) &&
+				    pos > EXFAT_I(inode)->i_size_aligned) {
+					exfat_fs_error(sb,
+						"requested for bmap out of range(pos : (%llu) > i_size_aligned(%llu)\n",
+						pos,
+						EXFAT_I(inode)->i_size_aligned);
+					err = -EIO;
+					goto unlock_ret;
+				}
+				set_buffer_new(bh_result);
+
+				/*
+				 * adjust i_size_aligned if i_size_ondisk is
+				 * bigger than it. (i.e. non-DA)
+				 */
+				if (EXFAT_I(inode)->i_size_ondisk >
+				    EXFAT_I(inode)->i_size_aligned) {
+					EXFAT_I(inode)->i_size_aligned =
+						EXFAT_I(inode)->i_size_ondisk;
+				}
+			}
+
+			if (buffer_delay(bh_result))
+				clear_buffer_delay(bh_result);
+		}
+		map_bh(bh_result, sb, phys);
+	}
+
+	bh_result->b_size = EXFAT_BLK_TO_B(max_blocks, sb);
+unlock_ret:
+	mutex_unlock(&EXFAT_SB(sb)->s_lock);
+	return err;
+}
+
+static int exfat_readpage(struct file *file, struct page *page)
+{
+	return mpage_readpage(page, exfat_get_block);
+}
+
+static int exfat_readpages(struct file *file, struct address_space *mapping,
+		struct list_head *pages, unsigned int nr_pages)
+{
+	return mpage_readpages(mapping, pages, nr_pages, exfat_get_block);
+}
+
+static int exfat_writepage(struct page *page, struct writeback_control *wbc)
+{
+	return block_write_full_page(page, exfat_get_block, wbc);
+}
+
+static int exfat_writepages(struct address_space *mapping,
+		struct writeback_control *wbc)
+{
+	return mpage_writepages(mapping, wbc, exfat_get_block);
+}
+
+static void exfat_write_failed(struct address_space *mapping, loff_t to)
+{
+	struct inode *inode = mapping->host;
+
+	if (to > i_size_read(inode)) {
+		truncate_pagecache(inode, i_size_read(inode));
+		exfat_truncate(inode, EXFAT_I(inode)->i_size_aligned);
+	}
+}
+
+static int exfat_write_begin(struct file *file, struct address_space *mapping,
+		loff_t pos, unsigned int len, unsigned int flags,
+		struct page **pagep, void **fsdata)
+{
+	int ret;
+
+	*pagep = NULL;
+	ret = cont_write_begin(file, mapping, pos, len, flags, pagep, fsdata,
+			       exfat_get_block,
+			       &EXFAT_I(mapping->host)->i_size_ondisk);
+
+	if (ret < 0)
+		exfat_write_failed(mapping, pos+len);
+
+	return ret;
+}
+
+static int exfat_write_end(struct file *file, struct address_space *mapping,
+		loff_t pos, unsigned int len, unsigned int copied,
+		struct page *pagep, void *fsdata)
+{
+	struct inode *inode = mapping->host;
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+	int err;
+
+	err = generic_write_end(file, mapping, pos, len, copied, pagep, fsdata);
+
+	if (EXFAT_I(inode)->i_size_aligned < i_size_read(inode)) {
+		exfat_fs_error(inode->i_sb,
+			"invalid size(size(%llu) > aligned(%llu)\n",
+			i_size_read(inode), EXFAT_I(inode)->i_size_aligned);
+		return -EIO;
+	}
+
+	if (err < len)
+		exfat_write_failed(mapping, pos+len);
+
+	if (!(err < 0) && !(ei->attr & ATTR_ARCHIVE)) {
+		inode->i_mtime = inode->i_ctime = current_time(inode);
+		ei->attr |= ATTR_ARCHIVE;
+		mark_inode_dirty(inode);
+	}
+
+	return err;
+}
+
+static ssize_t exfat_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
+	struct inode *inode = mapping->host;
+	loff_t size = iocb->ki_pos + iov_iter_count(iter);
+	int rw = iov_iter_rw(iter);
+	ssize_t ret;
+
+	if (rw == WRITE) {
+		/*
+		 * FIXME: blockdev_direct_IO() doesn't use ->write_begin(),
+		 * so we need to update the ->i_size_aligned to block boundary.
+		 *
+		 * But we must fill the remaining area or hole by nul for
+		 * updating ->i_size_aligned
+		 *
+		 * Return 0, and fallback to normal buffered write.
+		 */
+		if (EXFAT_I(inode)->i_size_aligned < size)
+			return 0;
+	}
+
+	/*
+	 * Need to use the DIO_LOCKING for avoiding the race
+	 * condition of exfat_get_block() and ->truncate().
+	 */
+	ret = blockdev_direct_IO(iocb, inode, iter, exfat_get_block);
+	if (ret < 0 && (rw & WRITE))
+		exfat_write_failed(mapping, size);
+	return ret;
+}
+
+static sector_t exfat_aop_bmap(struct address_space *mapping, sector_t block)
+{
+	sector_t blocknr;
+
+	/* exfat_get_cluster() assumes the requested blocknr isn't truncated. */
+	down_read(&EXFAT_I(mapping->host)->truncate_lock);
+	blocknr = generic_block_bmap(mapping, block, exfat_get_block);
+	up_read(&EXFAT_I(mapping->host)->truncate_lock);
+	return blocknr;
+}
+
+static const struct address_space_operations exfat_aops = {
+	.readpage	= exfat_readpage,
+	.readpages	= exfat_readpages,
+	.writepage	= exfat_writepage,
+	.writepages	= exfat_writepages,
+	.write_begin	= exfat_write_begin,
+	.write_end	= exfat_write_end,
+	.direct_IO	= exfat_direct_IO,
+	.bmap		= exfat_aop_bmap
+};
+
+static inline unsigned long exfat_hash(loff_t i_pos)
+{
+	return hash_32(i_pos, EXFAT_HASH_BITS);
+}
+
+void exfat_hash_inode(struct inode *inode, loff_t i_pos)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(inode->i_sb);
+	struct hlist_head *head = sbi->inode_hashtable + exfat_hash(i_pos);
+
+	spin_lock(&sbi->inode_hash_lock);
+	EXFAT_I(inode)->i_pos = i_pos;
+	hlist_add_head(&EXFAT_I(inode)->i_hash_fat, head);
+	spin_unlock(&sbi->inode_hash_lock);
+}
+
+void exfat_unhash_inode(struct inode *inode)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(inode->i_sb);
+
+	spin_lock(&sbi->inode_hash_lock);
+	hlist_del_init(&EXFAT_I(inode)->i_hash_fat);
+	EXFAT_I(inode)->i_pos = 0;
+	spin_unlock(&sbi->inode_hash_lock);
+}
+
+struct inode *exfat_iget(struct super_block *sb, loff_t i_pos)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_inode_info *info;
+	struct hlist_head *head = sbi->inode_hashtable + exfat_hash(i_pos);
+	struct inode *inode = NULL;
+
+	spin_lock(&sbi->inode_hash_lock);
+	hlist_for_each_entry(info, head, i_hash_fat) {
+		WARN_ON(info->vfs_inode.i_sb != sb);
+
+		if (i_pos != info->i_pos)
+			continue;
+		inode = igrab(&info->vfs_inode);
+		if (inode)
+			break;
+	}
+	spin_unlock(&sbi->inode_hash_lock);
+	return inode;
+}
+
+/* doesn't deal with root inode */
+static int exfat_fill_inode(struct inode *inode, struct exfat_dir_entry *info)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(inode->i_sb);
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+	loff_t size = info->size;
+
+	memcpy(&ei->dir, &info->dir, sizeof(struct exfat_chain));
+	ei->entry = info->entry;
+	ei->attr = info->attr;
+	ei->start_clu = info->start_clu;
+	ei->flags = info->flags;
+	ei->type = info->type;
+
+	ei->version = 0;
+	ei->hint_stat.eidx = 0;
+	ei->hint_stat.clu = info->start_clu;
+	ei->hint_femp.eidx = EXFAT_HINT_NONE;
+	ei->rwoffset = 0;
+	ei->hint_bmap.off = EXFAT_EOF_CLUSTER;
+	ei->i_pos = 0;
+
+	inode->i_uid = sbi->options.fs_uid;
+	inode->i_gid = sbi->options.fs_gid;
+	inode_inc_iversion(inode);
+	inode->i_generation = prandom_u32();
+
+	if (info->attr & ATTR_SUBDIR) { /* directory */
+		inode->i_generation &= ~1;
+		inode->i_mode = exfat_make_mode(sbi, info->attr, 0777);
+		inode->i_op = &exfat_dir_inode_operations;
+		inode->i_fop = &exfat_dir_operations;
+		set_nlink(inode, info->num_subdirs);
+	} else { /* regular file */
+		inode->i_generation |= 1;
+		inode->i_mode = exfat_make_mode(sbi, info->attr, 0777);
+		inode->i_op = &exfat_file_inode_operations;
+		inode->i_fop = &exfat_file_operations;
+		inode->i_mapping->a_ops = &exfat_aops;
+		inode->i_mapping->nrpages = 0;
+	}
+
+	i_size_write(inode, size);
+
+	/* ondisk and aligned size should be aligned with block size */
+	if (size & (inode->i_sb->s_blocksize - 1)) {
+		size |= (inode->i_sb->s_blocksize - 1);
+		size++;
+	}
+
+	ei->i_size_aligned = size;
+	ei->i_size_ondisk = size;
+
+	exfat_save_attr(inode, info->attr);
+
+	inode->i_blocks = ((i_size_read(inode) + (sbi->cluster_size - 1)) &
+		~(sbi->cluster_size - 1)) >> inode->i_blkbits;
+
+	exfat_time_fat2unix(sbi, &inode->i_mtime, &info->modify_timestamp);
+	exfat_time_fat2unix(sbi, &inode->i_ctime, &info->create_timestamp);
+	exfat_time_fat2unix(sbi, &inode->i_atime, &info->access_timestamp);
+
+	exfat_cache_init_inode(inode);
+
+	return 0;
+}
+
+struct inode *exfat_build_inode(struct super_block *sb,
+		struct exfat_dir_entry *info, loff_t i_pos)
+{
+	struct inode *inode;
+	int err;
+
+	inode = exfat_iget(sb, i_pos);
+	if (inode)
+		goto out;
+	inode = new_inode(sb);
+	if (!inode) {
+		inode = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+	inode->i_ino = iunique(sb, EXFAT_ROOT_INO);
+	inode_set_iversion(inode, 1);
+	err = exfat_fill_inode(inode, info);
+	if (err) {
+		iput(inode);
+		inode = ERR_PTR(err);
+		goto out;
+	}
+	exfat_hash_inode(inode, i_pos);
+	insert_inode_hash(inode);
+out:
+	return inode;
+}
+
+void exfat_evict_inode(struct inode *inode)
+{
+	truncate_inode_pages(&inode->i_data, 0);
+
+	if (!inode->i_nlink) {
+		i_size_write(inode, 0);
+		mutex_lock(&EXFAT_SB(inode->i_sb)->s_lock);
+		__exfat_truncate(inode, 0);
+		mutex_unlock(&EXFAT_SB(inode->i_sb)->s_lock);
+	}
+
+	invalidate_inode_buffers(inode);
+	clear_inode(inode);
+	exfat_cache_inval_inode(inode);
+	exfat_unhash_inode(inode);
+}
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
new file mode 100644
index 000000000000..6a3e1974df77
--- /dev/null
+++ b/fs/exfat/namei.c
@@ -0,0 +1,1459 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/iversion.h>
+#include <linux/namei.h>
+#include <linux/slab.h>
+#include <linux/buffer_head.h>
+#include <linux/nls.h>
+
+#include "exfat_raw.h"
+#include "exfat_fs.h"
+
+static inline unsigned long exfat_d_version(struct dentry *dentry)
+{
+	return (unsigned long) dentry->d_fsdata;
+}
+
+static inline void exfat_d_version_set(struct dentry *dentry,
+		unsigned long version)
+{
+	dentry->d_fsdata = (void *) version;
+}
+
+/*
+ * If new entry was created in the parent, it could create the 8.3
+ * alias (the shortname of logname).  So, the parent may have the
+ * negative-dentry which matches the created 8.3 alias.
+ *
+ * If it happened, the negative dentry isn't actually negative
+ * anymore.  So, drop it.
+ */
+static int __exfat_revalidate_common(struct dentry *dentry)
+{
+	int ret = 1;
+
+	spin_lock(&dentry->d_lock);
+	if (!inode_eq_iversion(d_inode(dentry->d_parent),
+			exfat_d_version(dentry)))
+		ret = 0;
+	spin_unlock(&dentry->d_lock);
+	return ret;
+}
+
+static int __exfat_revalidate(struct dentry *dentry)
+{
+	/* This is not negative dentry. Always valid. */
+	if (d_really_is_positive(dentry))
+		return 1;
+	return __exfat_revalidate_common(dentry);
+}
+
+static int __exfat_revalidate_ci(struct dentry *dentry, unsigned int flags)
+{
+	/*
+	 * This is not negative dentry. Always valid.
+	 *
+	 * Note, rename() to existing directory entry will have ->d_inode,
+	 * and will use existing name which isn't specified name by user.
+	 *
+	 * We may be able to drop this positive dentry here. But dropping
+	 * positive dentry isn't good idea. So it's unsupported like
+	 * rename("filename", "FILENAME") for now.
+	 */
+	if (d_really_is_positive(dentry))
+		return 1;
+	/*
+	 * Drop the negative dentry, in order to make sure to use the
+	 * case sensitive name which is specified by user if this is
+	 * for creation.
+	 */
+	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET))
+		return 0;
+	return __exfat_revalidate_common(dentry);
+}
+
+
+/* returns the length of a struct qstr, ignoring trailing dots */
+static unsigned int __exfat_striptail_len(unsigned int len, const char *name)
+{
+	while (len && name[len - 1] == '.')
+		len--;
+	return len;
+}
+
+static unsigned int exfat_striptail_len(const struct qstr *qstr)
+{
+	return __exfat_striptail_len(qstr->len, qstr->name);
+}
+
+static inline unsigned int __exfat_full_name_hash(const struct dentry *dentry,
+		const char *name, unsigned int len)
+{
+	return full_name_hash(dentry, name, len);
+}
+
+static inline unsigned long __exfat_init_name_hash(const struct dentry *dentry)
+{
+	return init_name_hash(dentry);
+}
+
+/*
+ * Compute the hash for the exfat name corresponding to the dentry.
+ * Note: if the name is invalid, we leave the hash code unchanged so
+ * that the existing dentry can be used. The exfat fs routines will
+ * return ENOENT or EINVAL as appropriate.
+ */
+static int exfat_d_hash(const struct dentry *dentry, struct qstr *qstr)
+{
+	unsigned int len = exfat_striptail_len(qstr);
+
+	qstr->hash = __exfat_full_name_hash(dentry, qstr->name, len);
+	return 0;
+}
+
+/*
+ * Compute the hash for the exfat name corresponding to the dentry.
+ * Note: if the name is invalid, we leave the hash code unchanged so
+ * that the existing dentry can be used. The exfat fs routines will
+ * return ENOENT or EINVAL as appropriate.
+ */
+static int exfat_d_hashi(const struct dentry *dentry, struct qstr *qstr)
+{
+	struct nls_table *t = EXFAT_SB(dentry->d_sb)->nls_io;
+	const unsigned char *name;
+	unsigned int len;
+	unsigned long hash;
+
+	name = qstr->name;
+	len = exfat_striptail_len(qstr);
+
+	hash = __exfat_init_name_hash(dentry);
+	while (len--)
+		hash = partial_name_hash(nls_tolower(t, *name++), hash);
+	qstr->hash = end_name_hash(hash);
+
+	return 0;
+}
+
+/*
+ * Case sensitive compare of two exfat names.
+ */
+static int exfat_cmp(const struct dentry *dentry, unsigned int len,
+		const char *str, const struct qstr *name)
+{
+	unsigned int alen, blen;
+
+	/* A filename cannot end in '.' or we treat it like it has none */
+	alen = exfat_striptail_len(name);
+	blen = __exfat_striptail_len(len, str);
+	if (alen == blen) {
+		if (strncmp(name->name, str, alen) == 0)
+			return 0;
+	}
+	return 1;
+}
+
+/*
+ * Case insensitive compare of two exfat names.
+ */
+static int exfat_cmpi(const struct dentry *dentry, unsigned int len,
+		const char *str, const struct qstr *name)
+{
+	struct nls_table *t = EXFAT_SB(dentry->d_sb)->nls_io;
+	unsigned int alen, blen;
+
+	/* A filename cannot end in '.' or we treat it like it has none */
+	alen = exfat_striptail_len(name);
+	blen = __exfat_striptail_len(len, str);
+	if (alen == blen) {
+		if (nls_strnicmp(t, name->name, str, alen) == 0)
+			return 0;
+	}
+	return 1;
+}
+
+static int exfat_revalidate(struct dentry *dentry, unsigned int flags)
+{
+	if (flags & LOOKUP_RCU)
+		return -ECHILD;
+
+	return __exfat_revalidate(dentry);
+}
+
+static int exfat_revalidate_ci(struct dentry *dentry, unsigned int flags)
+{
+	if (flags & LOOKUP_RCU)
+		return -ECHILD;
+
+	return __exfat_revalidate_ci(dentry, flags);
+}
+
+const struct dentry_operations exfat_dentry_ops = {
+	.d_revalidate	= exfat_revalidate,
+	.d_hash		= exfat_d_hash,
+	.d_compare	= exfat_cmp,
+};
+
+const struct dentry_operations exfat_ci_dentry_ops = {
+	.d_revalidate	= exfat_revalidate_ci,
+	.d_hash		= exfat_d_hashi,
+	.d_compare	= exfat_cmpi,
+};
+
+/* used only in search empty_slot() */
+#define CNT_UNUSED_NOHIT        (-1)
+#define CNT_UNUSED_HIT          (-2)
+/* search EMPTY CONTINUOUS "num_entries" entries */
+static int exfat_search_empty_slot(struct super_block *sb,
+		struct exfat_hint_femp *hint_femp, struct exfat_chain *p_dir,
+		int num_entries)
+{
+	int i, dentry, num_empty = 0;
+	int dentries_per_clu;
+	unsigned int type;
+	struct exfat_chain clu;
+	struct exfat_dentry *ep;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct buffer_head *bh;
+
+	dentries_per_clu = sbi->dentries_per_clu;
+
+	if (hint_femp->eidx != EXFAT_HINT_NONE) {
+		dentry = hint_femp->eidx;
+		if (num_entries <= hint_femp->count) {
+			hint_femp->eidx = EXFAT_HINT_NONE;
+			return dentry;
+		}
+
+		exfat_chain_dup(&clu, &hint_femp->cur);
+	} else {
+		exfat_chain_dup(&clu, p_dir);
+		dentry = 0;
+	}
+
+	while (clu.dir != EXFAT_EOF_CLUSTER) {
+		i = dentry & (dentries_per_clu - 1);
+
+		for (; i < dentries_per_clu; i++, dentry++) {
+			ep = exfat_get_dentry(sb, &clu, i, &bh, NULL);
+			if (!ep)
+				return -EIO;
+			type = exfat_get_entry_type(ep);
+			brelse(bh);
+
+			if (type == TYPE_UNUSED || type == TYPE_DELETED) {
+				num_empty++;
+				if (hint_femp->eidx == EXFAT_HINT_NONE) {
+					hint_femp->eidx = dentry;
+					hint_femp->count = CNT_UNUSED_NOHIT;
+					exfat_chain_set(&hint_femp->cur,
+						clu.dir, clu.size, clu.flags);
+				}
+
+				if (type == TYPE_UNUSED &&
+				    hint_femp->count != CNT_UNUSED_HIT)
+					hint_femp->count = CNT_UNUSED_HIT;
+			} else {
+				if (hint_femp->eidx != EXFAT_HINT_NONE &&
+				    hint_femp->count == CNT_UNUSED_HIT) {
+					/* unused empty group means
+					 * an empty group which includes
+					 * unused dentry
+					 */
+					exfat_fs_error(sb,
+						"found bogus dentry(%d) beyond unused empty group(%d) (start_clu : %u, cur_clu : %u)",
+						dentry, hint_femp->eidx,
+						p_dir->dir, clu.dir);
+					return -EIO;
+				}
+
+				num_empty = 0;
+				hint_femp->eidx = EXFAT_HINT_NONE;
+			}
+
+			if (num_empty >= num_entries) {
+				/* found and invalidate hint_femp */
+				hint_femp->eidx = EXFAT_HINT_NONE;
+				return (dentry - (num_entries - 1));
+			}
+		}
+
+		if (clu.flags == ALLOC_NO_FAT_CHAIN) {
+			if (--clu.size > 0)
+				clu.dir++;
+			else
+				clu.dir = EXFAT_EOF_CLUSTER;
+		} else {
+			if (exfat_get_next_cluster(sb, &clu.dir))
+				return -EIO;
+		}
+	}
+
+	return -ENOSPC;
+}
+
+static int exfat_check_max_dentries(struct inode *inode)
+{
+	if (EXFAT_B_TO_DEN(i_size_read(inode)) >= MAX_EXFAT_DENTRIES) {
+		/*
+		 * exFAT spec allows a dir to grow upto 8388608(256MB)
+		 * dentries
+		 */
+		return -ENOSPC;
+	}
+	return 0;
+}
+
+/* find empty directory entry.
+ * if there isn't any empty slot, expand cluster chain.
+ */
+int exfat_find_empty_entry(struct inode *inode, struct exfat_chain *p_dir,
+		int num_entries)
+{
+	int dentry;
+	unsigned int ret, last_clu;
+	sector_t sector;
+	loff_t size = 0;
+	struct exfat_chain clu;
+	struct exfat_dentry *ep = NULL;
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+	struct exfat_hint_femp hint_femp;
+
+	hint_femp.eidx = EXFAT_HINT_NONE;
+
+	if (ei->hint_femp.eidx != EXFAT_HINT_NONE) {
+		memcpy(&hint_femp, &ei->hint_femp,
+				sizeof(struct exfat_hint_femp));
+		ei->hint_femp.eidx = EXFAT_HINT_NONE;
+	}
+
+	while ((dentry = exfat_search_empty_slot(sb, &hint_femp, p_dir,
+					num_entries)) < 0) {
+		if (dentry == -EIO)
+			break;
+
+		if (exfat_check_max_dentries(inode))
+			return -ENOSPC;
+
+		/* we trust p_dir->size regardless of FAT type */
+		if (exfat_find_last_cluster(sb, p_dir, &last_clu))
+			return -EIO;
+
+		/*
+		 * Allocate new cluster to this directory
+		 */
+		exfat_chain_set(&clu, last_clu + 1, 0, p_dir->flags);
+
+		/* allocate a cluster */
+		ret = exfat_alloc_cluster(inode, 1, &clu);
+		if (ret)
+			return ret;
+
+		if (exfat_zeroed_cluster(inode, clu.dir))
+			return -EIO;
+
+		/* append to the FAT chain */
+		if (clu.flags != p_dir->flags) {
+			/* no-fat-chain bit is disabled,
+			 * so fat-chain should be synced with alloc-bitmap
+			 */
+			exfat_chain_cont_cluster(sb, p_dir->dir, p_dir->size);
+			p_dir->flags = ALLOC_FAT_CHAIN;
+			hint_femp.cur.flags = ALLOC_FAT_CHAIN;
+		}
+
+		if (clu.flags == ALLOC_FAT_CHAIN)
+			if (exfat_ent_set(sb, last_clu, clu.dir))
+				return -EIO;
+
+		if (hint_femp.eidx == EXFAT_HINT_NONE) {
+			/* the special case that new dentry
+			 * should be allocated from the start of new cluster
+			 */
+			hint_femp.eidx = EXFAT_B_TO_DEN_IDX(p_dir->size, sbi);
+			hint_femp.count = sbi->dentries_per_clu;
+
+			exfat_chain_set(&hint_femp.cur, clu.dir, 0, clu.flags);
+		}
+		hint_femp.cur.size++;
+		p_dir->size++;
+		size = EXFAT_CLU_TO_B(p_dir->size, sbi);
+
+		/* update the directory entry */
+		if (p_dir->dir != sbi->root_dir) {
+			struct buffer_head *bh;
+
+			ep = exfat_get_dentry(sb,
+				&(ei->dir), ei->entry + 1, &bh, &sector);
+			if (!ep)
+				return -EIO;
+
+			ep->stream_valid_size = cpu_to_le64(size);
+			ep->stream_size = ep->stream_valid_size;
+			ep->stream_flags = p_dir->flags;
+			exfat_update_bh(sb, bh, IS_DIRSYNC(inode));
+			brelse(bh);
+			if (update_dir_chksum(inode, &(ei->dir), ei->entry))
+				return -EIO;
+		}
+
+		/* directory inode should be updated in here */
+		i_size_write(inode, size);
+		EXFAT_I(inode)->i_size_ondisk += sbi->cluster_size;
+		EXFAT_I(inode)->i_size_aligned += sbi->cluster_size;
+		EXFAT_I(inode)->flags = p_dir->flags;
+		inode->i_blocks += 1 << sbi->sect_per_clus_bits;
+	}
+
+	return dentry;
+}
+
+/*
+ * Name Resolution Functions :
+ * Zero if it was successful; otherwise nonzero.
+ */
+static int __exfat_resolve_path(struct inode *inode, const unsigned char *path,
+		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
+		int lookup)
+{
+	int namelen;
+	int lossy = NLS_NAME_NO_LOSSY;
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+
+	/* DOT and DOTDOT are handled by VFS layer */
+
+	/* strip all trailing spaces */
+	/* DO NOTHING : Is needed? */
+
+	/* strip all trailing periods */
+	namelen = __exfat_striptail_len(strlen(path), path);
+	if (!namelen)
+		return -ENOENT;
+
+	/* the limitation of linux? */
+	if (strlen(path) > (MAX_NAME_LENGTH * MAX_CHARSET_SIZE))
+		return -ENAMETOOLONG;
+
+	/*
+	 * strip all leading spaces :
+	 * "MS windows 7" supports leading spaces.
+	 * So we should skip this preprocessing for compatibility.
+	 */
+
+	/* file name conversion :
+	 * If lookup case, we allow bad-name for compatibility.
+	 */
+	namelen = exfat_nls_vfsname_to_uni16s(sb, path, namelen, p_uniname,
+			&lossy);
+	if (namelen < 0)
+		return namelen; /* return error value */
+
+	if ((lossy && !lookup) || !namelen)
+		return -EINVAL;
+
+	exfat_chain_set(p_dir, ei->start_clu,
+		EXFAT_B_TO_CLU(i_size_read(inode), sbi), ei->flags);
+
+	return 0;
+}
+
+static inline int exfat_resolve_path(struct inode *inode,
+		const unsigned char *path, struct exfat_chain *dir,
+		struct exfat_uni_name *uni)
+{
+	return __exfat_resolve_path(inode, path, dir, uni, 0);
+}
+
+static inline int exfat_resolve_path_for_lookup(struct inode *inode,
+		const unsigned char *path, struct exfat_chain *dir,
+		struct exfat_uni_name *uni)
+{
+	return __exfat_resolve_path(inode, path, dir, uni, 1);
+}
+
+static inline loff_t exfat_make_i_pos(struct exfat_dir_entry *info)
+{
+	return ((loff_t) info->dir.dir << 32) | (info->entry & 0xffffffff);
+}
+
+static int exfat_add_entry(struct inode *inode, const char *path,
+		struct exfat_chain *p_dir, unsigned int type,
+		struct exfat_dir_entry *info)
+{
+	int ret, dentry, num_entries;
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_uni_name uniname;
+	struct exfat_chain clu;
+	int clu_size = 0;
+	unsigned int start_clu = EXFAT_FREE_CLUSTER;
+
+	ret = exfat_resolve_path(inode, path, p_dir, &uniname);
+	if (ret)
+		goto out;
+
+	num_entries = exfat_calc_num_entries(&uniname);
+	if (num_entries < 0) {
+		ret = num_entries;
+		goto out;
+	}
+
+	/* exfat_find_empty_entry must be called before alloc_cluster() */
+	dentry = exfat_find_empty_entry(inode, p_dir, num_entries);
+	if (dentry < 0) {
+		ret = dentry; /* -EIO or -ENOSPC */
+		goto out;
+	}
+
+	if (type == TYPE_DIR) {
+		ret = exfat_alloc_new_dir(inode, &clu);
+		if (ret)
+			goto out;
+		start_clu = clu.dir;
+		clu_size = sbi->cluster_size;
+	}
+
+	/* update the directory entry */
+	/* fill the dos name directory entry information of the created file.
+	 * the first cluster is not determined yet. (0)
+	 */
+	ret = exfat_init_dir_entry(inode, p_dir, dentry, type,
+		start_clu, clu_size);
+	if (ret)
+		goto out;
+
+	ret = exfat_init_ext_entry(inode, p_dir, dentry, num_entries, &uniname);
+	if (ret)
+		goto out;
+
+	memcpy(&info->dir, p_dir, sizeof(struct exfat_chain));
+	info->entry = dentry;
+	info->flags = ALLOC_NO_FAT_CHAIN;
+	info->type = type;
+
+	if (type == TYPE_FILE) {
+		info->attr = ATTR_ARCHIVE;
+		info->start_clu = EXFAT_EOF_CLUSTER;
+		info->size = 0;
+		info->num_subdirs = 0;
+	} else {
+		int count;
+		struct exfat_chain cdir;
+
+		info->attr = ATTR_SUBDIR;
+		info->start_clu = start_clu;
+		info->size = clu_size;
+
+		exfat_chain_set(&cdir, info->start_clu,
+			EXFAT_B_TO_CLU(info->size, sbi), info->flags);
+		count = exfat_count_dir_entries(sb, &cdir);
+		if (count < 0)
+			return -EIO;
+		info->num_subdirs = count + EXFAT_MIN_SUBDIR;
+	}
+	memset(&info->create_timestamp, 0,
+			sizeof(struct exfat_date_time));
+	memset(&info->modify_timestamp, 0,
+			sizeof(struct exfat_date_time));
+	memset(&info->access_timestamp, 0,
+			sizeof(struct exfat_date_time));
+out:
+	return ret;
+}
+
+static int exfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
+		bool excl)
+{
+	struct super_block *sb = dir->i_sb;
+	struct inode *inode;
+	struct exfat_chain cdir;
+	struct exfat_dir_entry info;
+	loff_t i_pos;
+	int err;
+
+	mutex_lock(&EXFAT_SB(sb)->s_lock);
+	exfat_set_vol_flags(sb, VOL_DIRTY);
+	err = exfat_add_entry(dir, dentry->d_name.name, &cdir, TYPE_FILE,
+		&info);
+	exfat_set_vol_flags(sb, VOL_CLEAN);
+	if (err)
+		goto unlock;
+
+	inode_inc_iversion(dir);
+	dir->i_ctime = dir->i_mtime = dir->i_atime = current_time(dir);
+	if (IS_DIRSYNC(dir))
+		exfat_sync_inode(dir);
+	else
+		mark_inode_dirty(dir);
+
+	i_pos = exfat_make_i_pos(&info);
+	inode = exfat_build_inode(sb, &info, i_pos);
+	if (IS_ERR(inode))
+		goto unlock;
+
+	inode_inc_iversion(inode);
+	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
+
+	d_instantiate(dentry, inode);
+unlock:
+	mutex_unlock(&EXFAT_SB(sb)->s_lock);
+	return err;
+}
+
+/* lookup a file */
+static int exfat_find(struct inode *dir, struct qstr *qname,
+		struct exfat_dir_entry *info)
+{
+	int ret, dentry, num_entries, count;
+	struct exfat_chain cdir;
+	struct exfat_uni_name uni_name;
+	struct exfat_dentry *ep, *ep2;
+	struct exfat_entry_set_cache *es = NULL;
+	struct super_block *sb = dir->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_inode_info *ei = EXFAT_I(dir);
+	struct exfat_timestamp tm;
+
+	if (qname->len == 0)
+		return -ENOENT;
+
+	/* check the validity of directory name in the given pathname */
+	ret = exfat_resolve_path_for_lookup(dir, qname->name, &cdir, &uni_name);
+	if (ret)
+		return ret;
+
+	num_entries = exfat_calc_num_entries(&uni_name);
+	if (num_entries < 0)
+		return num_entries;
+
+	/* check the validation of hint_stat and initialize it if required */
+	if (ei->version != (inode_peek_iversion_raw(dir) & 0xffffffff)) {
+		ei->hint_stat.clu = cdir.dir;
+		ei->hint_stat.eidx = 0;
+		ei->version = (inode_peek_iversion_raw(dir) & 0xffffffff);
+		ei->hint_femp.eidx = EXFAT_HINT_NONE;
+	}
+
+	/* search the file name for directories */
+	dentry = exfat_find_dir_entry(sb, ei, &cdir, &uni_name,
+			num_entries, TYPE_ALL);
+
+	if ((dentry < 0) && (dentry != -EEXIST))
+		return dentry; /* -error value */
+
+	memcpy(&info->dir, &cdir.dir, sizeof(struct exfat_chain));
+	info->entry = dentry;
+	info->num_subdirs = 0;
+
+	/* root directory itself */
+	if (unlikely(dentry == -EEXIST)) {
+		int num_clu = 0;
+
+		info->type = TYPE_DIR;
+		info->attr = ATTR_SUBDIR;
+		info->flags = ALLOC_FAT_CHAIN;
+		info->start_clu = sbi->root_dir;
+		memset(&info->create_timestamp, 0,
+				sizeof(struct exfat_date_time));
+		memset(&info->modify_timestamp, 0,
+				sizeof(struct exfat_date_time));
+		memset(&info->access_timestamp, 0,
+				sizeof(struct exfat_date_time));
+
+		exfat_chain_set(&cdir, sbi->root_dir, 0, ALLOC_FAT_CHAIN);
+		if (exfat_count_num_clusters(sb, &cdir, &num_clu))
+			return -EIO;
+		info->size = num_clu << sbi->cluster_size_bits;
+
+		count = exfat_count_dir_entries(sb, &cdir);
+		if (count < 0)
+			return -EIO;
+
+		info->num_subdirs = count;
+	} else {
+		es = exfat_get_dentry_set(sb, &cdir, dentry, ES_2_ENTRIES, &ep);
+		if (!es)
+			return -EIO;
+		ep2 = ep + 1;
+
+		info->type = exfat_get_entry_type(ep);
+		info->attr = le16_to_cpu(ep->file_attr);
+		info->size = le64_to_cpu(ep2->stream_valid_size);
+		if ((info->type == TYPE_FILE) && (info->size == 0)) {
+			info->flags = ALLOC_NO_FAT_CHAIN;
+			info->start_clu = EXFAT_EOF_CLUSTER;
+		} else {
+			info->flags = ep2->stream_flags;
+			info->start_clu = le32_to_cpu(ep2->stream_start_clu);
+		}
+
+		if (ei->start_clu == EXFAT_FREE_CLUSTER) {
+			exfat_fs_error(sb,
+				"non-zero size file starts with zero cluster (size : %llu, p_dir : %u, entry : 0x%08x)",
+				i_size_read(dir), ei->dir.dir, ei->entry);
+			return -EIO;
+		}
+
+		exfat_get_entry_time(ep, &tm, TM_CREATE);
+		info->create_timestamp.year = tm.year;
+		info->create_timestamp.month = tm.mon;
+		info->create_timestamp.day = tm.day;
+		info->create_timestamp.hour = tm.hour;
+		info->create_timestamp.minute = tm.min;
+		info->create_timestamp.second = tm.sec;
+		info->create_timestamp.milli_second = 0;
+
+		exfat_get_entry_time(ep, &tm, TM_MODIFY);
+		info->modify_timestamp.year = tm.year;
+		info->modify_timestamp.month = tm.mon;
+		info->modify_timestamp.day = tm.day;
+		info->modify_timestamp.hour = tm.hour;
+		info->modify_timestamp.minute = tm.min;
+		info->modify_timestamp.second = tm.sec;
+		info->modify_timestamp.milli_second = 0;
+
+		memset(&info->access_timestamp, 0,
+				sizeof(struct exfat_date_time));
+		kfree(es);
+
+		if (info->type == TYPE_DIR) {
+			exfat_chain_set(&cdir, info->start_clu,
+				EXFAT_B_TO_CLU(info->size, sbi), info->flags);
+			count = exfat_count_dir_entries(sb, &cdir);
+			if (count < 0)
+				return -EIO;
+
+			info->num_subdirs = count + EXFAT_MIN_SUBDIR;
+		}
+	}
+	return 0;
+}
+
+static int exfat_d_anon_disconn(struct dentry *dentry)
+{
+	return IS_ROOT(dentry) && (dentry->d_flags & DCACHE_DISCONNECTED);
+}
+
+static struct dentry *exfat_lookup(struct inode *dir, struct dentry *dentry,
+		unsigned int flags)
+{
+	struct super_block *sb = dir->i_sb;
+	struct inode *inode;
+	struct dentry *alias;
+	struct exfat_dir_entry info;
+	int err;
+	loff_t i_pos;
+	mode_t i_mode;
+
+	mutex_lock(&EXFAT_SB(sb)->s_lock);
+	err = exfat_find(dir, &dentry->d_name, &info);
+	if (err) {
+		if (err == -ENOENT) {
+			inode = NULL;
+			goto out;
+		}
+		goto unlock;
+	}
+
+	i_pos = exfat_make_i_pos(&info);
+	inode = exfat_build_inode(sb, &info, i_pos);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		goto unlock;
+	}
+
+	i_mode = inode->i_mode;
+	alias = d_find_alias(inode);
+
+	/*
+	 * Checking "alias->d_parent == dentry->d_parent" to make sure
+	 * FS is not corrupted (especially double linked dir).
+	 */
+	if (alias && alias->d_parent == dentry->d_parent &&
+			!exfat_d_anon_disconn(alias)) {
+
+		/*
+		 * Unhashed alias is able to exist because of revalidate()
+		 * called by lookup_fast. You can easily make this status
+		 * by calling create and lookup concurrently
+		 * In such case, we reuse an alias instead of new dentry
+		 */
+		if (d_unhashed(alias)) {
+			WARN_ON(alias->d_name.hash_len !=
+				dentry->d_name.hash_len);
+			exfat_msg(sb, KERN_INFO,
+				"rehashed a dentry(%p) in read lookup", alias);
+			d_drop(dentry);
+			d_rehash(alias);
+		} else if (!S_ISDIR(i_mode)) {
+			/*
+			 * This inode has non anonymous-DCACHE_DISCONNECTED
+			 * dentry. This means, the user did ->lookup() by an
+			 * another name (longname vs 8.3 alias of it) in past.
+			 *
+			 * Switch to new one for reason of locality if possible.
+			 */
+			d_move(alias, dentry);
+		}
+		iput(inode);
+		mutex_unlock(&EXFAT_SB(sb)->s_lock);
+		return alias;
+	}
+	dput(alias);
+out:
+	mutex_unlock(&EXFAT_SB(sb)->s_lock);
+	if (!inode)
+		exfat_d_version_set(dentry, inode_query_iversion(dir));
+
+	return d_splice_alias(inode, dentry);
+unlock:
+	mutex_unlock(&EXFAT_SB(sb)->s_lock);
+	return ERR_PTR(err);
+}
+
+/* remove an entry, BUT don't truncate */
+static int exfat_unlink(struct inode *dir, struct dentry *dentry)
+{
+	struct exfat_chain cdir;
+	struct exfat_dentry *ep;
+	struct super_block *sb = dir->i_sb;
+	struct inode *inode = dentry->d_inode;
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+	struct buffer_head *bh;
+	sector_t sector;
+	int num_entries, entry, err = 0;
+
+	mutex_lock(&EXFAT_SB(sb)->s_lock);
+	exfat_chain_dup(&cdir, &ei->dir);
+	entry = ei->entry;
+	if (ei->dir.dir == DIR_DELETED) {
+		exfat_msg(sb, KERN_ERR, "abnormal access to deleted dentry");
+		err = -ENOENT;
+		goto unlock;
+	}
+
+	ep = exfat_get_dentry(sb, &cdir, entry, &bh, &sector);
+	if (!ep) {
+		err = -EIO;
+		goto unlock;
+	}
+	num_entries = exfat_count_ext_entries(sb, &cdir, entry, ep);
+	if (num_entries < 0) {
+		err = -EIO;
+		brelse(bh);
+		goto unlock;
+	}
+	num_entries++;
+	brelse(bh);
+
+	exfat_set_vol_flags(sb, VOL_DIRTY);
+	/* update the directory entry */
+	if (exfat_remove_entries(dir, &cdir, entry, 0, num_entries)) {
+		err = -EIO;
+		goto unlock;
+	}
+
+	/* This doesn't modify ei */
+	ei->dir.dir = DIR_DELETED;
+	exfat_set_vol_flags(sb, VOL_CLEAN);
+
+	inode_inc_iversion(dir);
+	dir->i_mtime = dir->i_atime = current_time(dir);
+	if (IS_DIRSYNC(dir))
+		exfat_sync_inode(dir);
+	else
+		mark_inode_dirty(dir);
+
+	clear_nlink(inode);
+	inode->i_mtime = inode->i_atime = current_time(inode);
+	exfat_unhash_inode(inode);
+	exfat_d_version_set(dentry, inode_query_iversion(dir));
+unlock:
+	mutex_unlock(&EXFAT_SB(sb)->s_lock);
+	return err;
+}
+
+static int exfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+{
+	struct super_block *sb = dir->i_sb;
+	struct inode *inode;
+	struct exfat_dir_entry info;
+	struct exfat_chain cdir;
+	loff_t i_pos;
+	int err;
+
+	mutex_lock(&EXFAT_SB(sb)->s_lock);
+	exfat_set_vol_flags(sb, VOL_DIRTY);
+	err = exfat_add_entry(dir, dentry->d_name.name, &cdir, TYPE_DIR,
+		&info);
+	exfat_set_vol_flags(sb, VOL_CLEAN);
+	if (err)
+		goto unlock;
+
+	inode_inc_iversion(dir);
+	dir->i_ctime = dir->i_mtime = dir->i_atime = current_time(dir);
+	if (IS_DIRSYNC(dir))
+		exfat_sync_inode(dir);
+	else
+		mark_inode_dirty(dir);
+	inc_nlink(dir);
+
+	i_pos = exfat_make_i_pos(&info);
+	inode = exfat_build_inode(sb, &info, i_pos);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		goto unlock;
+	}
+
+	inode_inc_iversion(inode);
+	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
+
+	d_instantiate(dentry, inode);
+
+unlock:
+	mutex_unlock(&EXFAT_SB(sb)->s_lock);
+	return err;
+}
+
+static int exfat_check_dir_empty(struct super_block *sb,
+		struct exfat_chain *p_dir)
+{
+	int i, dentries_per_clu;
+	unsigned int type;
+	struct exfat_chain clu;
+	struct exfat_dentry *ep;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct buffer_head *bh;
+
+	dentries_per_clu = sbi->dentries_per_clu;
+
+	exfat_chain_dup(&clu, p_dir);
+
+	while (clu.dir != EXFAT_EOF_CLUSTER) {
+		for (i = 0; i < dentries_per_clu; i++) {
+			ep = exfat_get_dentry(sb, &clu, i, &bh, NULL);
+			if (!ep)
+				return -EIO;
+			type = exfat_get_entry_type(ep);
+			brelse(bh);
+			if (type == TYPE_UNUSED)
+				return 0;
+
+			if (type != TYPE_FILE && type != TYPE_DIR)
+				continue;
+
+			return -ENOTEMPTY;
+		}
+
+		if (clu.flags == ALLOC_NO_FAT_CHAIN) {
+			if (--clu.size > 0)
+				clu.dir++;
+			else
+				clu.dir = EXFAT_EOF_CLUSTER;
+		} else {
+			if (exfat_get_next_cluster(sb, &(clu.dir)))
+				return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode = dentry->d_inode;
+	struct exfat_dentry *ep;
+	struct exfat_chain cdir, clu_to_free;
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+	struct buffer_head *bh;
+	sector_t sector;
+	int num_entries, entry, err;
+
+	mutex_lock(&EXFAT_SB(inode->i_sb)->s_lock);
+
+	exfat_chain_dup(&cdir, &ei->dir);
+	entry = ei->entry;
+
+	if (ei->dir.dir == DIR_DELETED) {
+		exfat_msg(sb, KERN_ERR, "abnormal access to deleted dentry");
+		err = -ENOENT;
+		goto unlock;
+	}
+
+	exfat_set_vol_flags(sb, VOL_DIRTY);
+	exfat_chain_set(&clu_to_free, ei->start_clu,
+		EXFAT_B_TO_CLU_ROUND_UP(i_size_read(inode), sbi), ei->flags);
+
+	err = exfat_check_dir_empty(sb, &clu_to_free);
+	if (err) {
+		if (err == -EIO)
+			exfat_msg(sb, KERN_ERR,
+				"failed to exfat_check_dir_empty : err(%d)",
+				err);
+		goto unlock;
+	}
+
+	ep = exfat_get_dentry(sb, &cdir, entry, &bh, &sector);
+	if (!ep) {
+		err = -EIO;
+		goto unlock;
+	}
+
+	num_entries = exfat_count_ext_entries(sb, &cdir, entry, ep);
+	if (num_entries < 0) {
+		err = -EIO;
+		brelse(bh);
+		goto unlock;
+	}
+	num_entries++;
+	brelse(bh);
+
+	err = exfat_remove_entries(dir, &cdir, entry, 0, num_entries);
+	if (err) {
+		exfat_msg(sb, KERN_ERR,
+				"failed to exfat_remove_entries : err(%d)",
+				err);
+		goto unlock;
+	}
+	ei->dir.dir = DIR_DELETED;
+	exfat_set_vol_flags(sb, VOL_CLEAN);
+
+	inode_inc_iversion(dir);
+	dir->i_mtime = dir->i_atime = current_time(dir);
+	if (IS_DIRSYNC(dir))
+		exfat_sync_inode(dir);
+	else
+		mark_inode_dirty(dir);
+	drop_nlink(dir);
+
+	clear_nlink(inode);
+	inode->i_mtime = inode->i_atime = current_time(inode);
+	exfat_unhash_inode(inode);
+	exfat_d_version_set(dentry, inode_query_iversion(dir));
+unlock:
+	mutex_unlock(&EXFAT_SB(inode->i_sb)->s_lock);
+	return err;
+}
+
+static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
+		int oldentry, struct exfat_uni_name *p_uniname,
+		struct exfat_inode_info *ei)
+{
+	int ret, num_old_entries, num_new_entries;
+	sector_t sector_old, sector_new;
+	struct exfat_dentry *epold, *epnew;
+	struct super_block *sb = inode->i_sb;
+	struct buffer_head *new_bh, *old_bh;
+	int sync = IS_DIRSYNC(inode);
+
+	epold = exfat_get_dentry(sb, p_dir, oldentry, &old_bh, &sector_old);
+	if (!epold)
+		return -EIO;
+
+	num_old_entries = exfat_count_ext_entries(sb, p_dir, oldentry, epold);
+	if (num_old_entries < 0)
+		return -EIO;
+	num_old_entries++;
+
+	num_new_entries = exfat_calc_num_entries(p_uniname);
+	if (num_new_entries < 0)
+		return num_new_entries;
+
+	if (num_old_entries < num_new_entries) {
+		int newentry;
+
+		newentry =
+			exfat_find_empty_entry(inode, p_dir, num_new_entries);
+		if (newentry < 0)
+			return newentry; /* -EIO or -ENOSPC */
+
+		epnew = exfat_get_dentry(sb, p_dir, newentry, &new_bh,
+			&sector_new);
+		if (!epnew)
+			return -EIO;
+
+		memcpy(epnew, epold, DENTRY_SIZE);
+		if (exfat_get_entry_type(epnew) == TYPE_FILE) {
+			epnew->file_attr |= ATTR_ARCHIVE_LE;
+			ei->attr |= ATTR_ARCHIVE;
+		}
+		exfat_update_bh(sb, new_bh, sync);
+		brelse(old_bh);
+		brelse(new_bh);
+
+		epold = exfat_get_dentry(sb, p_dir, oldentry + 1, &old_bh,
+			&sector_old);
+		epnew = exfat_get_dentry(sb, p_dir, newentry + 1, &new_bh,
+			&sector_new);
+		if (!epold || !epnew)
+			return -EIO;
+
+		memcpy(epnew, epold, DENTRY_SIZE);
+		exfat_update_bh(sb, new_bh, sync);
+		brelse(old_bh);
+		brelse(new_bh);
+
+		ret = exfat_init_ext_entry(inode, p_dir, newentry,
+			num_new_entries, p_uniname);
+		if (ret)
+			return ret;
+
+		exfat_remove_entries(inode, p_dir, oldentry, 0,
+			num_old_entries);
+		ei->entry = newentry;
+	} else {
+		if (exfat_get_entry_type(epold) == TYPE_FILE) {
+			epold->file_attr |= ATTR_ARCHIVE_LE;
+			ei->attr |= ATTR_ARCHIVE;
+		}
+		exfat_update_bh(sb, old_bh, sync);
+		brelse(old_bh);
+		ret = exfat_init_ext_entry(inode, p_dir, oldentry,
+			num_new_entries, p_uniname);
+		if (ret)
+			return ret;
+
+		exfat_remove_entries(inode, p_dir, oldentry, num_new_entries,
+			num_old_entries);
+	}
+	return 0;
+}
+
+static int exfat_move_file(struct inode *inode, struct exfat_chain *p_olddir,
+		int oldentry, struct exfat_chain *p_newdir,
+		struct exfat_uni_name *p_uniname, struct exfat_inode_info *ei)
+{
+	int ret, newentry, num_new_entries, num_old_entries;
+	sector_t sector_mov, sector_new;
+	struct exfat_dentry *epmov, *epnew;
+	struct super_block *sb = inode->i_sb;
+	struct buffer_head *mov_bh, *new_bh;
+
+	epmov = exfat_get_dentry(sb, p_olddir, oldentry, &mov_bh, &sector_mov);
+	if (!epmov)
+		return -EIO;
+
+	/* check if the source and target directory is the same */
+	if (exfat_get_entry_type(epmov) == TYPE_DIR &&
+	    le32_to_cpu(epmov->stream_start_clu) == p_newdir->dir)
+		return -EINVAL;
+
+	num_old_entries = exfat_count_ext_entries(sb, p_olddir, oldentry,
+		epmov);
+	if (num_old_entries < 0)
+		return -EIO;
+	num_old_entries++;
+
+	num_new_entries = exfat_calc_num_entries(p_uniname);
+	if (num_new_entries < 0)
+		return num_new_entries;
+
+	newentry = exfat_find_empty_entry(inode, p_newdir, num_new_entries);
+	if (newentry < 0)
+		return newentry; /* -EIO or -ENOSPC */
+
+	epnew = exfat_get_dentry(sb, p_newdir, newentry, &new_bh, &sector_new);
+	if (!epnew)
+		return -EIO;
+
+	memcpy(epnew, epmov, DENTRY_SIZE);
+	if (exfat_get_entry_type(epnew) == TYPE_FILE) {
+		epnew->file_attr |= ATTR_ARCHIVE_LE;
+		ei->attr |= ATTR_ARCHIVE;
+	}
+	exfat_update_bh(sb, new_bh, IS_DIRSYNC(inode));
+	brelse(mov_bh);
+	brelse(new_bh);
+
+	epmov = exfat_get_dentry(sb, p_olddir, oldentry + 1, &mov_bh,
+		&sector_mov);
+	epnew = exfat_get_dentry(sb, p_newdir, newentry + 1, &new_bh,
+		&sector_new);
+	if (!epmov || !epnew)
+		return -EIO;
+
+	memcpy(epnew, epmov, DENTRY_SIZE);
+	exfat_update_bh(sb, new_bh, IS_DIRSYNC(inode));
+	brelse(mov_bh);
+	brelse(new_bh);
+
+	ret = exfat_init_ext_entry(inode, p_newdir, newentry, num_new_entries,
+		p_uniname);
+	if (ret)
+		return ret;
+
+	exfat_remove_entries(inode, p_olddir, oldentry, 0, num_old_entries);
+
+	exfat_chain_set(&ei->dir, p_newdir->dir, p_newdir->size,
+		p_newdir->flags);
+
+	ei->entry = newentry;
+	return 0;
+}
+
+static void exfat_update_parent_info(struct exfat_inode_info *ei,
+		struct inode *parent_inode)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(parent_inode->i_sb);
+	struct exfat_inode_info *parent_ei = EXFAT_I(parent_inode);
+	loff_t parent_isize = i_size_read(parent_inode);
+
+	/*
+	 * the problem that struct exfat_inode_info caches wrong parent info.
+	 *
+	 * because of flag-mismatch of ei->dir,
+	 * there is abnormal traversing cluster chain.
+	 */
+	if (unlikely(parent_ei->flags != ei->dir.flags ||
+		     parent_isize != EXFAT_CLU_TO_B(ei->dir.size, sbi) ||
+		     parent_ei->start_clu != ei->dir.dir)) {
+		exfat_chain_set(&ei->dir, parent_ei->start_clu,
+			EXFAT_B_TO_CLU_ROUND_UP(parent_isize, sbi),
+			parent_ei->flags);
+	}
+}
+
+/* rename or move a old file into a new file */
+static int __exfat_rename(struct inode *old_parent_inode,
+		struct exfat_inode_info *ei, struct inode *new_parent_inode,
+		struct dentry *new_dentry)
+{
+	int ret;
+	int dentry;
+	struct exfat_chain olddir, newdir;
+	struct exfat_chain *p_dir = NULL;
+	struct exfat_uni_name uni_name;
+	struct exfat_dentry *ep;
+	struct super_block *sb = old_parent_inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	const unsigned char *new_path = new_dentry->d_name.name;
+	struct inode *new_inode = new_dentry->d_inode;
+	int num_entries;
+	struct exfat_inode_info *new_ei = NULL;
+	unsigned int new_entry_type = TYPE_UNUSED;
+	int new_entry = 0;
+	struct buffer_head *old_bh, *new_bh = NULL;
+
+	/* check the validity of pointer parameters */
+	if (new_path == NULL || strlen(new_path) == 0)
+		return -EINVAL;
+
+	if (ei->dir.dir == DIR_DELETED) {
+		exfat_msg(sb, KERN_ERR,
+				"abnormal access to deleted source dentry");
+		return -ENOENT;
+	}
+
+	exfat_update_parent_info(ei, old_parent_inode);
+
+	exfat_chain_dup(&olddir, &ei->dir);
+	dentry = ei->entry;
+
+	ep = exfat_get_dentry(sb, &olddir, dentry, &old_bh, NULL);
+	if (!ep) {
+		ret = -EIO;
+		goto out;
+	}
+	brelse(old_bh);
+
+	/* check whether new dir is existing directory and empty */
+	if (new_inode) {
+		ret = -EIO;
+		new_ei = EXFAT_I(new_inode);
+
+		if (new_ei->dir.dir == DIR_DELETED) {
+			exfat_msg(sb, KERN_ERR,
+				"abnormal access to deleted target dentry");
+			goto out;
+		}
+
+		exfat_update_parent_info(new_ei, new_parent_inode);
+
+		p_dir = &(new_ei->dir);
+		new_entry = new_ei->entry;
+		ep = exfat_get_dentry(sb, p_dir, new_entry, &new_bh, NULL);
+		if (!ep)
+			goto out;
+
+		new_entry_type = exfat_get_entry_type(ep);
+		brelse(new_bh);
+
+		/* if new_inode exists, update ei */
+		if (new_entry_type == TYPE_DIR) {
+			struct exfat_chain new_clu;
+
+			new_clu.dir = new_ei->start_clu;
+			new_clu.size =
+				EXFAT_B_TO_CLU_ROUND_UP(i_size_read(new_inode),
+				sbi);
+			new_clu.flags = new_ei->flags;
+
+			ret = exfat_check_dir_empty(sb, &new_clu);
+			if (ret)
+				goto out;
+		}
+	}
+
+	/* check the validity of directory name in the given new pathname */
+	ret = exfat_resolve_path(new_parent_inode, new_path, &newdir,
+			&uni_name);
+	if (ret)
+		goto out;
+
+	exfat_set_vol_flags(sb, VOL_DIRTY);
+
+	if (olddir.dir == newdir.dir)
+		ret = exfat_rename_file(new_parent_inode, &olddir, dentry,
+				&uni_name, ei);
+	else
+		ret = exfat_move_file(new_parent_inode, &olddir, dentry,
+				&newdir, &uni_name, ei);
+
+	if (!ret && new_inode) {
+		/* delete entries of new_dir */
+		ep = exfat_get_dentry(sb, p_dir, new_entry, &new_bh, NULL);
+		if (!ep) {
+			ret = -EIO;
+			goto del_out;
+		}
+
+		num_entries = exfat_count_ext_entries(sb, p_dir, new_entry, ep);
+		if (num_entries < 0) {
+			ret = -EIO;
+			goto del_out;
+		}
+		brelse(new_bh);
+
+		if (exfat_remove_entries(new_inode, p_dir, new_entry, 0,
+				num_entries + 1)) {
+			ret = -EIO;
+			goto del_out;
+		}
+
+		/* Free the clusters if new_inode is a dir(as if exfat_rmdir) */
+		if (new_entry_type == TYPE_DIR) {
+			/* new_ei, new_clu_to_free */
+			struct exfat_chain new_clu_to_free;
+
+			exfat_chain_set(&new_clu_to_free, new_ei->start_clu,
+				EXFAT_B_TO_CLU_ROUND_UP(i_size_read(new_inode),
+				sbi), new_ei->flags);
+
+			if (exfat_free_cluster(new_inode, &new_clu_to_free)) {
+				/* just set I/O error only */
+				ret = -EIO;
+			}
+
+			i_size_write(new_inode, 0);
+			new_ei->start_clu = EXFAT_EOF_CLUSTER;
+			new_ei->flags = ALLOC_NO_FAT_CHAIN;
+		}
+del_out:
+		/* Update new_inode ei
+		 * Prevent syncing removed new_inode
+		 * (new_ei is already initialized above code ("if (new_inode)")
+		 */
+		new_ei->dir.dir = DIR_DELETED;
+	}
+	exfat_set_vol_flags(sb, VOL_CLEAN);
+out:
+	return ret;
+}
+
+static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
+		struct inode *new_dir, struct dentry *new_dentry,
+		unsigned int flags)
+{
+	struct inode *old_inode, *new_inode;
+	struct super_block *sb = old_dir->i_sb;
+	loff_t i_pos;
+	int err;
+
+	/*
+	 * The VFS already checks for existence, so for local filesystems
+	 * the RENAME_NOREPLACE implementation is equivalent to plain rename.
+	 * Don't support any other flags
+	 */
+	if (flags & ~RENAME_NOREPLACE)
+		return -EINVAL;
+
+	mutex_lock(&EXFAT_SB(sb)->s_lock);
+	old_inode = old_dentry->d_inode;
+	new_inode = new_dentry->d_inode;
+
+	err = __exfat_rename(old_dir, EXFAT_I(old_inode), new_dir, new_dentry);
+	if (err)
+		goto unlock;
+
+	inode_inc_iversion(new_dir);
+	new_dir->i_ctime = new_dir->i_mtime = new_dir->i_atime =
+		current_time(new_dir);
+	if (IS_DIRSYNC(new_dir))
+		exfat_sync_inode(new_dir);
+	else
+		mark_inode_dirty(new_dir);
+
+	i_pos = ((loff_t)EXFAT_I(old_inode)->dir.dir << 32) |
+		(EXFAT_I(old_inode)->entry & 0xffffffff);
+	exfat_unhash_inode(old_inode);
+	exfat_hash_inode(old_inode, i_pos);
+	if (IS_DIRSYNC(new_dir))
+		exfat_sync_inode(old_inode);
+	else
+		mark_inode_dirty(old_inode);
+
+	if (S_ISDIR(old_inode->i_mode) && old_dir != new_dir) {
+		drop_nlink(old_dir);
+		if (!new_inode)
+			inc_nlink(new_dir);
+	}
+
+	inode_inc_iversion(old_dir);
+	old_dir->i_ctime = old_dir->i_mtime = current_time(old_dir);
+	if (IS_DIRSYNC(old_dir))
+		exfat_sync_inode(old_dir);
+	else
+		mark_inode_dirty(old_dir);
+
+	if (new_inode) {
+		exfat_unhash_inode(new_inode);
+
+		/* skip drop_nlink if new_inode already has been dropped */
+		if (new_inode->i_nlink) {
+			drop_nlink(new_inode);
+			if (S_ISDIR(new_inode->i_mode))
+				drop_nlink(new_inode);
+		} else {
+			exfat_msg(sb, KERN_WARNING,
+					"abnormal access to an inode dropped");
+			WARN_ON(new_inode->i_nlink == 0);
+		}
+		new_inode->i_ctime = current_time(new_inode);
+	}
+
+unlock:
+	mutex_unlock(&EXFAT_SB(sb)->s_lock);
+	return err;
+}
+
+const struct inode_operations exfat_dir_inode_operations = {
+	.create		= exfat_create,
+	.lookup		= exfat_lookup,
+	.unlink		= exfat_unlink,
+	.mkdir		= exfat_mkdir,
+	.rmdir		= exfat_rmdir,
+	.rename		= exfat_rename,
+	.setattr	= exfat_setattr,
+	.getattr	= exfat_getattr,
+};
-- 
2.17.1

