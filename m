Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0D3104A26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 06:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfKUF3X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 00:29:23 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:62312 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfKUF3W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 00:29:22 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191121052919epoutp01d00a771fc1dcb1f4455e19f7cc4ee337~ZFmL06nrH1281512815epoutp01D
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2019 05:29:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191121052919epoutp01d00a771fc1dcb1f4455e19f7cc4ee337~ZFmL06nrH1281512815epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574314159;
        bh=3zr4+P2+DByscJa2bJn0woI5FNm5jXGHqCX9i9Zg4P4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j5z0KTTQJJJ6FKcf+JcfwQeTHRrxKio6EJMyvtEDoBo3e1nQi0EdRjhjhGAVapo7K
         fhKR2hP04hsFmD+TAAsw3ujWRA7vCVwevhC8LV1UlNeefmNDkVGkowZHl7dwIRlfhD
         6uPF9mIArEM+/tnWCrwryfMgkQdW1p0ZCMQ8XVN4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191121052918epcas1p258feb314233990b5de296c391dcbff40~ZFmLUm-7Z0048000480epcas1p2l;
        Thu, 21 Nov 2019 05:29:18 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.162]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47JSmF2mzxzMqYkY; Thu, 21 Nov
        2019 05:29:17 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.30.04080.BA026DD5; Thu, 21 Nov 2019 14:29:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191121052915epcas1p36613f6c468471c95d02da5db92b5c6cd~ZFmINV9IZ3012130121epcas1p3D;
        Thu, 21 Nov 2019 05:29:15 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191121052915epsmtrp1d6a3b964f84059be571d3169f2057f12~ZFmIMn26U1320813208epsmtrp1r;
        Thu, 21 Nov 2019 05:29:15 +0000 (GMT)
X-AuditID: b6c32a37-7cdff70000000ff0-c9-5dd620ab1947
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FC.88.03814.AA026DD5; Thu, 21 Nov 2019 14:29:14 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191121052914epsmtip135810a5da79accd17cec89c0b80daf1f~ZFmH_suCO1142611426epsmtip11;
        Thu, 21 Nov 2019 05:29:14 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de, nborisov@suse.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v4 01/13] exfat: add in-memory and on-disk structures and
 headers
Date:   Thu, 21 Nov 2019 00:26:06 -0500
Message-Id: <20191121052618.31117-2-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121052618.31117-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTN60zbQalOCuhLVayjKEvA1lIYDXVFM1ESiegP2OAExpbYjU5B
        URNQFC0xUA2JshkVI6EY2Rr2irbWNdGIC4shbhHEoOKOwa1lEP0775x77nnvvosh4mKBBMsw
        WBizgdYRgmloszssKrJW+lgta7aFke6XJ4RkflWdgKyp9fDInoF+hOx03kLJB+0VAvJ32RCf
        HDuZS/4eOYSSjl/X+GT3+1F09XSqrWxASHVVXhRSHX15AqrIYQdUneMRSjXd2Ud9agymXC0j
        AurJYDOa6Jesi9MydDpjljKGNGN6hkGjIjYlpa5LVcbI5JHy5WQsITXQekZFxCckRm7I0Hkv
        S0izaV2Wl0qkWZZYujLObMyyMFKtkbWoCMaUrjPJZaYoltazWQZNVJpRv0Iuky1Teit36LSv
        3EWIqfcq2DPWfRfkgXtnQCHwwyAeDa8ftPIKwTRMjLcC+KapTMgdPgJY3WGbVL4C6OwdmrI8
        b7vM5wQngNaaPmTK8uzmBa+CYQI8Av5wBPkMgfgq2FR+BfXVIHgPgIP9p/g+IQBPgo8bziM+
        jOIhsKbk/oRXhMdBz+dgLmw+rK2/gvhoP1wFn47n+NpAvEcA7b3VKFcTD615pTwOB8A3NxxC
        DkvgcHGB0OeF+D74oQvh6KMAvv6m4rAC9tXVT6QieBisa1/K0Qtg23jlxHMRfAZ89+UYn+si
        gkcLxFxJCCzqdk+GzoGFR0YngyhorZrLzcMGoN1jR2wguOxfwBkA7GAWY2L1GoaVmxT/f1gj
        mFjG8NhWUH83wQVwDBD+Im3oI7WYT2ezOXoXgBhCBIo6ex6qxaJ0OmcvYzammrN0DOsCSu8U
        jyOSoDSjd7UNllS5cplCoSCjY2JjlApitggbu68W4xrawuxiGBNj/uvjYX6SPFDIu1G6db0/
        26A+rJccat84XFIbsmK3s966Ntc9GBFzeaErufr0JaH/pyXg3uKtm00z53V9KCjdEqrZNmPn
        koDvZz0HRjs+dqRcN9gsrauFjeuG5OeGf57udChb8z0vKhax1kzP15boJmdUyvaS/WtF5eGl
        KRXS2WOxe5VvMzNvF68hUFZLy8MRM0v/AdyNi6uiAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSnO5qhWuxBjuELA4/nsRu0bx4PZvF
        ytVHmSyu373FbLFn70kWi8u75rBZ/J/1nNXix/R6i/9vWlgstvw7wmpx6f0HFgduj52z7rJ7
        7J+7ht1j980GNo++LasYPdZvucrisfl0tcfnTXIeh7a/YfO4/WwbSwBnFJdNSmpOZllqkb5d
        AlfG08N9zAU3DjJW/Lh0jrGB8fwCxi5GTg4JAROJhzv3sXYxcnEICexmlFiwpY8ZIiEtcezE
        GSCbA8gWljh8uBii5gOjxLXvK9lA4mwC2hJ/toiClIsIOEr07jrMAlLDLPCYUeLE+SdgC4QF
        AiU2TO4Hs1kEVCVWTrnICtLLK2AjcfSLHMQqeYnVGw6AreIUsJW4/7sSJCwEVHH1xAvWCYx8
        CxgZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBIevltYOxhMn4g8xCnAwKvHwZmhc
        jRViTSwrrsw9xCjBwawkwrvn+pVYId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzy+ccihQTSE0tS
        s1NTC1KLYLJMHJxSDYxRyl2yZ5bt+T6P/5/B+t0ujX4zXmu2LRMLPiMb+ahAflkIj5LmTqkS
        1uNfF+kWyBi4H/LunxJ8I/FhikZKgZvwh2KNoA1yh3XUze9uqnDxF/RoZSgwyeMu2lN3paLh
        y1qPjtVPHtoaZnpp6R+6XvI+/57Xf7eTB1vbDx4tc3ngWBW/ck4EixJLcUaioRZzUXEiAEXB
        02xbAgAA
X-CMS-MailID: 20191121052915epcas1p36613f6c468471c95d02da5db92b5c6cd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191121052915epcas1p36613f6c468471c95d02da5db92b5c6cd
References: <20191121052618.31117-1-namjae.jeon@samsung.com>
        <CGME20191121052915epcas1p36613f6c468471c95d02da5db92b5c6cd@epcas1p3.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds in-memory and on-disk structures and headers.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/exfat_fs.h  | 538 +++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/exfat_raw.h | 194 ++++++++++++++++
 2 files changed, 732 insertions(+)
 create mode 100644 fs/exfat/exfat_fs.h
 create mode 100644 fs/exfat/exfat_raw.h

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
new file mode 100644
index 000000000000..ada7afc56c1c
--- /dev/null
+++ b/fs/exfat/exfat_fs.h
@@ -0,0 +1,538 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef _EXFAT_H
+#define _EXFAT_H
+
+#include <linux/fs.h>
+#include <linux/ratelimit.h>
+
+#define EXFAT_SUPER_MAGIC       (0x2011BAB0UL)
+#define EXFAT_ROOT_INO		1
+
+enum exfat_time_mode {
+	TM_CREATE,
+	TM_MODIFY,
+	TM_ACCESS,
+};
+
+/*
+ * exfat error flags
+ */
+enum exfat_error_mode {
+	EXFAT_ERRORS_CONT,	/* ignore error and continue */
+	EXFAT_ERRORS_PANIC,	/* panic on error */
+	EXFAT_ERRORS_RO,	/* remount r/o on error */
+};
+
+/*
+ * exfat nls lossy flag
+ */
+enum {
+	NLS_NAME_NO_LOSSY,	/* no lossy */
+	NLS_NAME_LOSSY,		/* just detected incorrect filename(s) */
+	NLS_NAME_OVERLEN,	/* the length is over than its limit */
+};
+
+/*
+ * exfat common MACRO
+ */
+#define CLUSTER_32(x)	((unsigned int)((x) & 0xFFFFFFFFU))
+#define EOF_CLUSTER	CLUSTER_32(~0)
+#define BAD_CLUSTER	(0xFFFFFFF7U)
+#define FREE_CLUSTER	(0)
+#define BASE_CLUSTER	(2)
+
+#define EXFAT_HASH_BITS		8
+#define EXFAT_HASH_SIZE		(1UL << EXFAT_HASH_BITS)
+
+/*
+ * Type Definitions
+ */
+#define ES_2_ENTRIES	2
+#define ES_ALL_ENTRIES	0
+
+#define DIR_DELETED	0xFFFF0321
+
+/* type values */
+#define TYPE_UNUSED		0x0000
+#define TYPE_DELETED		0x0001
+#define TYPE_INVALID		0x0002
+#define TYPE_CRITICAL_PRI	0x0100
+#define TYPE_BITMAP		0x0101
+#define TYPE_UPCASE		0x0102
+#define TYPE_VOLUME		0x0103
+#define TYPE_DIR		0x0104
+#define TYPE_FILE		0x011F
+#define TYPE_CRITICAL_SEC	0x0200
+#define TYPE_STREAM		0x0201
+#define TYPE_EXTEND		0x0202
+#define TYPE_ACL		0x0203
+#define TYPE_BENIGN_PRI		0x0400
+#define TYPE_GUID		0x0401
+#define TYPE_PADDING		0x0402
+#define TYPE_ACLTAB		0x0403
+#define TYPE_BENIGN_SEC		0x0800
+#define TYPE_ALL		0x0FFF
+
+#define MAX_CHARSET_SIZE	6 /* max size of multi-byte character */
+#define MAX_NAME_LENGTH		255 /* max len of file name excluding NULL */
+#define MAX_VFSNAME_BUF_SIZE	((MAX_NAME_LENGTH + 1) * MAX_CHARSET_SIZE)
+
+#define FAT_CACHE_SIZE		128
+#define FAT_CACHE_HASH_SIZE	64
+#define BUF_CACHE_SIZE		256
+#define BUF_CACHE_HASH_SIZE	64
+
+#define EXFAT_HINT_NONE		-1
+#define EXFAT_MIN_SUBDIR	2
+
+/*
+ * helpers for cluster size to byte conversion.
+ */
+#define EXFAT_CLU_TO_B(b, sbi)		((b) << (sbi)->cluster_size_bits)
+#define EXFAT_B_TO_CLU(b, sbi)		((b) >> (sbi)->cluster_size_bits)
+#define EXFAT_B_TO_CLU_ROUND_UP(b, sbi)	\
+	(((b - 1) >> (sbi)->cluster_size_bits) + 1)
+#define EXFAT_CLU_OFFSET(off, sbi)	((off) & ((sbi)->cluster_size - 1))
+
+/*
+ * helpers for block size to byte conversion.
+ */
+#define EXFAT_BLK_TO_B(b, sb)		((b) << (sb)->s_blocksize_bits)
+#define EXFAT_B_TO_BLK(b, sb)		((b) >> (sb)->s_blocksize_bits)
+#define EXFAT_B_TO_BLK_ROUND_UP(b, sb)	\
+	(((b - 1) >> (sb)->s_blocksize_bits) + 1)
+#define EXFAT_BLK_OFFSET(off, sb)	((off) & ((sb)->s_blocksize - 1))
+
+/*
+ * helpers for block size to dentry size conversion.
+ */
+#define EXFAT_B_TO_DEN_IDX(b, sbi)	\
+	((b) << ((sbi)->cluster_size_bits - DENTRY_SIZE_BITS))
+#define EXFAT_B_TO_DEN(b)		((b) >> DENTRY_SIZE_BITS)
+#define EXFAT_DEN_TO_B(b)		((b) << DENTRY_SIZE_BITS)
+
+#define EXFAT_SB_DIRTY		0
+
+struct exfat_timestamp {
+	unsigned short sec;	/* 0 ~ 59 */
+	unsigned short min;	/* 0 ~ 59 */
+	unsigned short hour;	/* 0 ~ 23 */
+	unsigned short day;	/* 1 ~ 31 */
+	unsigned short mon;	/* 1 ~ 12 */
+	unsigned short year;	/* 0 ~ 127 (since 1980) */
+};
+
+struct exfat_date_time {
+	unsigned short year;
+	unsigned short month;
+	unsigned short day;
+	unsigned short hour;
+	unsigned short minute;
+	unsigned short second;
+	unsigned short milli_second;
+};
+
+struct exfat_dentry_namebuf {
+	char *lfn;
+	int lfnbuf_len; /* usally MAX_UNINAME_BUF_SIZE */
+};
+
+/* unicode name structure */
+struct exfat_uni_name {
+	/* +3 for null and for converting */
+	unsigned short name[MAX_NAME_LENGTH + 3];
+	unsigned short name_hash;
+	unsigned char name_len;
+};
+
+/* directory structure */
+struct exfat_chain {
+	unsigned int dir;
+	unsigned int size;
+	unsigned char flags;
+};
+
+/* first empty entry hint information */
+struct exfat_hint_femp {
+	/* entry index of a directory */
+	int eidx;
+	/* count of continuous empty entry */
+	int count;
+	/* the cluster that first empty slot exists in */
+	struct exfat_chain cur;
+};
+
+/* hint structure */
+struct exfat_hint {
+	unsigned int clu;
+	union {
+		unsigned int off; /* cluster offset */
+		int eidx; /* entry index */
+	};
+};
+
+struct exfat_entry_set_cache {
+	/* sector number that contains file_entry */
+	sector_t sector;
+	/* byte offset in the sector */
+	unsigned int offset;
+	/* flag in stream entry. 01 for cluster chain, 03 for contig. */
+	int alloc_flag;
+	unsigned int num_entries;
+	struct exfat_dentry entries[];
+};
+
+struct exfat_dir_entry {
+	struct exfat_chain dir;
+	int entry;
+	unsigned int type;
+	unsigned int start_clu;
+	unsigned char flags;
+	unsigned short attr;
+	loff_t size;
+	unsigned int num_subdirs;
+	struct exfat_date_time create_timestamp;
+	struct exfat_date_time modify_timestamp;
+	struct exfat_date_time access_timestamp;
+	struct exfat_dentry_namebuf namebuf;
+};
+
+/*
+ * exfat mount in-memory data
+ */
+struct exfat_mount_options {
+	kuid_t fs_uid;
+	kgid_t fs_gid;
+	unsigned short fs_fmask;
+	unsigned short fs_dmask;
+	/* permission for setting the [am]time */
+	unsigned short allow_utime;
+	/* charset for filename input/display */
+	char *iocharset;
+	unsigned char utf8;
+	unsigned char case_sensitive;
+	unsigned char tz_utc;
+	/* on error: continue, panic, remount-ro */
+	enum exfat_error_mode errors;
+	/* flag on if -o dicard specified and device support discard() */
+	unsigned char discard;
+};
+
+/*
+ * EXFAT file system superblock in-memory data
+ */
+struct exfat_sb_info {
+	unsigned int vol_type; /* volume FAT type */
+	unsigned int vol_id; /* volume serial number */
+	unsigned long long num_sectors; /* num of sectors in volume */
+	unsigned int num_clusters; /* num of clusters in volume */
+	unsigned int cluster_size; /* cluster size in bytes */
+	unsigned int cluster_size_bits;
+	unsigned int sect_per_clus; /* cluster size in sectors */
+	unsigned int sect_per_clus_bits;
+	unsigned long long FAT1_start_sector; /* FAT1 start sector */
+	unsigned long long FAT2_start_sector; /* FAT2 start sector */
+	unsigned long long root_start_sector; /* root dir start sector */
+	unsigned long long data_start_sector; /* data area start sector */
+	unsigned int num_FAT_sectors; /* num of FAT sectors */
+	unsigned int root_dir; /* root dir cluster */
+	unsigned int dentries_in_root; /* num of dentries in root dir */
+	unsigned int dentries_per_clu; /* num of dentries per cluster */
+	unsigned int vol_flag; /* volume dirty flag */
+	struct buffer_head *pbr_bh; /* buffer_head of PBR sector */
+
+	unsigned int map_clu; /* allocation bitmap start cluster */
+	unsigned int map_sectors; /* num of allocation bitmap sectors */
+	struct buffer_head **vol_amap; /* allocation bitmap */
+
+	unsigned short *vol_utbl; /* upcase table */
+
+	unsigned int clu_srch_ptr; /* cluster search pointer */
+	unsigned int used_clusters; /* number of used clusters */
+
+	unsigned long s_state;
+	struct mutex s_lock; /* superblock lock */
+	struct super_block *host_sb; /* sb pointer */
+	struct exfat_mount_options options;
+	struct nls_table *nls_io; /* Charset used for input and display */
+	struct ratelimit_state ratelimit;
+
+	spinlock_t inode_hash_lock;
+	struct hlist_head inode_hashtable[EXFAT_HASH_SIZE];
+};
+
+/*
+ * EXFAT file system inode in-memory data
+ */
+struct exfat_inode_info {
+	struct exfat_chain dir;
+	int entry;
+	unsigned int type;
+	unsigned short attr;
+	unsigned int start_clu;
+	unsigned char flags;
+	/*
+	 * the copy of low 32bit of i_version to check
+	 * the validation of hint_stat.
+	 */
+	unsigned int version;
+	/* file offset or dentry index for readdir */
+	loff_t rwoffset;
+
+	/* hint for cluster last accessed */
+	struct exfat_hint hint_bmap;
+	/* hint for entry index we try to lookup next time */
+	struct exfat_hint hint_stat;
+	/* hint for first empty entry */
+	struct exfat_hint_femp hint_femp;
+
+	spinlock_t cache_lru_lock;
+	struct list_head cache_lru;
+	int nr_caches;
+	/* for avoiding the race between alloc and free */
+	unsigned int cache_valid_id;
+
+	/*
+	 * NOTE: i_size_ondisk is 64bits, so must hold ->inode_lock to access.
+	 * physically allocated size.
+	 */
+	loff_t i_size_ondisk;
+	/* block-aligned i_size (used in cont_write_begin) */
+	loff_t i_size_aligned;
+	/* on-disk position of directory entry or 0 */
+	loff_t i_pos;
+	/* hash by i_location */
+	struct hlist_node i_hash_fat;
+	/* protect bmap against truncate */
+	struct rw_semaphore truncate_lock;
+	struct inode vfs_inode;
+};
+
+static inline struct exfat_sb_info *EXFAT_SB(struct super_block *sb)
+{
+	return sb->s_fs_info;
+}
+
+static inline struct exfat_inode_info *EXFAT_I(struct inode *inode)
+{
+	return container_of(inode, struct exfat_inode_info, vfs_inode);
+}
+
+/*
+ * If ->i_mode can't hold 0222 (i.e. ATTR_RO), we use ->i_attrs to
+ * save ATTR_RO instead of ->i_mode.
+ *
+ * If it's directory and !sbi->options.rodir, ATTR_RO isn't read-only
+ * bit, it's just used as flag for app.
+ */
+static inline int exfat_mode_can_hold_ro(struct inode *inode)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(inode->i_sb);
+
+	if (S_ISDIR(inode->i_mode))
+		return 0;
+
+	if ((~sbi->options.fs_fmask) & 0222)
+		return 1;
+	return 0;
+}
+
+/* Convert attribute bits and a mask to the UNIX mode. */
+static inline mode_t exfat_make_mode(struct exfat_sb_info *sbi,
+		unsigned short attr, mode_t mode)
+{
+	if ((attr & ATTR_READONLY) && !(attr & ATTR_SUBDIR))
+		mode &= ~0222;
+
+	if (attr & ATTR_SUBDIR)
+		return (mode & ~sbi->options.fs_dmask) | S_IFDIR;
+
+	return (mode & ~sbi->options.fs_fmask) | S_IFREG;
+}
+
+/* Return the FAT attribute byte for this inode */
+static inline unsigned short exfat_make_attr(struct inode *inode)
+{
+	unsigned short attr = EXFAT_I(inode)->attr;
+
+	if (S_ISDIR(inode->i_mode))
+		attr |= ATTR_SUBDIR;
+	if (exfat_mode_can_hold_ro(inode) && !(inode->i_mode & 0222))
+		attr |= ATTR_READONLY;
+	return attr;
+}
+
+static inline void exfat_save_attr(struct inode *inode, unsigned short attr)
+{
+	if (exfat_mode_can_hold_ro(inode))
+		EXFAT_I(inode)->attr = attr & (ATTR_RWMASK | ATTR_READONLY);
+	else
+		EXFAT_I(inode)->attr = attr & ATTR_RWMASK;
+}
+
+static inline bool exfat_is_last_sector_in_cluster(struct exfat_sb_info *sbi,
+		sector_t sec)
+{
+	return ((sec - sbi->data_start_sector + 1) &
+			((1 << sbi->sect_per_clus_bits) - 1)) == 0;
+}
+
+static inline sector_t exfat_cluster_to_sector(struct exfat_sb_info *sbi,
+		unsigned int clus)
+{
+	return ((clus - BASE_CLUSTER) << sbi->sect_per_clus_bits)
+			+ sbi->data_start_sector;
+}
+
+static inline int exfat_sector_to_cluster(struct exfat_sb_info *sbi,
+		sector_t sec)
+{
+	return ((sec - sbi->data_start_sector) >> sbi->sect_per_clus_bits) +
+			BASE_CLUSTER;
+}
+
+/* super.c */
+int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag);
+
+/* fatent.c */
+#define exfat_get_next_cluster(sb, pclu) exfat_ent_get(sb, *(pclu), pclu)
+
+int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
+		struct exfat_chain *p_chain);
+int exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain);
+int exfat_ent_get(struct super_block *sb, unsigned int loc,
+		unsigned int *content);
+int exfat_ent_set(struct super_block *sb, unsigned int loc,
+		unsigned int content);
+int exfat_count_ext_entries(struct super_block *sb, struct exfat_chain *p_dir,
+		int entry, struct exfat_dentry *p_entry);
+int exfat_chain_cont_cluster(struct super_block *sb, unsigned int chain,
+		unsigned int len);
+struct exfat_dentry *exfat_get_dentry(struct super_block *sb,
+		struct exfat_chain *p_dir, int entry, struct buffer_head **bh,
+		sector_t *sector);
+struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
+		struct exfat_chain *p_dir, int entry, unsigned int type,
+		struct exfat_dentry **file_ep);
+int exfat_zeroed_cluster(struct inode *dir, unsigned int clu);
+int exfat_find_location(struct super_block *sb, struct exfat_chain *p_dir,
+		int entry, sector_t *sector, int *offset);
+int exfat_find_last_cluster(struct super_block *sb, struct exfat_chain *p_chain,
+		unsigned int *ret_clu);
+int exfat_mirror_bh(struct super_block *sb, sector_t sec,
+		struct buffer_head *bh);
+int exfat_count_num_clusters(struct super_block *sb,
+		struct exfat_chain *p_chain, unsigned int *ret_count);
+int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain *p_dir);
+
+/* balloc.c */
+int exfat_load_bitmap(struct super_block *sb);
+void exfat_free_bitmap(struct super_block *sb);
+int exfat_set_bitmap(struct inode *inode, unsigned int clu);
+void exfat_clear_bitmap(struct inode *inode, unsigned int clu);
+unsigned int exfat_test_bitmap(struct super_block *sb, unsigned int clu);
+int exfat_count_used_clusters(struct super_block *sb, unsigned int *ret_count);
+
+/* file.c */
+extern const struct file_operations exfat_file_operations;
+int __exfat_truncate(struct inode *inode, loff_t new_size);
+void exfat_truncate(struct inode *inode, loff_t size);
+int exfat_setattr(struct dentry *dentry, struct iattr *attr);
+int exfat_getattr(const struct path *path, struct kstat *stat,
+		unsigned int request_mask, unsigned int query_flags);
+
+/* namei.c */
+extern const struct dentry_operations exfat_dentry_ops;
+extern const struct dentry_operations exfat_ci_dentry_ops;
+int exfat_find_empty_entry(struct inode *inode, struct exfat_chain *p_dir,
+		int num_entries);
+
+/* cache.c */
+int exfat_cache_init(void);
+void exfat_cache_shutdown(void);
+void exfat_cache_init_inode(struct inode *inode);
+void exfat_cache_inval_inode(struct inode *inode);
+int exfat_get_cluster(struct inode *inode, unsigned int cluster,
+		unsigned int *fclus, unsigned int *dclus,
+		unsigned int *last_dclus, int allow_eof);
+
+/* dir.c */
+extern const struct inode_operations exfat_dir_inode_operations;
+extern const struct file_operations exfat_dir_operations;
+void exfat_get_uniname_from_ext_entry(struct super_block *sb,
+		struct exfat_chain *p_dir, int entry, unsigned short *uniname);
+unsigned int exfat_get_entry_type(struct exfat_dentry *p_entry);
+void exfat_get_entry_time(struct exfat_dentry *p_entry,
+		struct exfat_timestamp *tp, unsigned char mode);
+void exfat_set_entry_time(struct exfat_dentry *p_entry,
+		struct exfat_timestamp *tp, unsigned char mode);
+int exfat_init_dir_entry(struct inode *inode, struct exfat_chain *p_dir,
+		int entry, unsigned int type, unsigned int start_clu,
+		unsigned long long size);
+int exfat_init_ext_entry(struct inode *inode, struct exfat_chain *p_dir,
+		int entry, int num_entries, struct exfat_uni_name *p_uniname);
+int exfat_remove_entries(struct inode *inode, struct exfat_chain *p_dir,
+		int entry, int order, int num_entries);
+int update_dir_chksum(struct inode *inode, struct exfat_chain *p_dir,
+		int entry);
+int exfat_update_dir_chksum_with_entry_set(struct super_block *sb,
+		struct exfat_entry_set_cache *es, int sync);
+int exfat_get_num_entries(struct exfat_uni_name *p_uniname);
+int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
+		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
+		int num_entries, unsigned int type);
+int exfat_alloc_new_dir(struct inode *inode, struct exfat_chain *clu);
+
+/* inode.c */
+extern const struct inode_operations exfat_file_inode_operations;
+void exfat_sync_inode(struct inode *inode);
+struct inode *exfat_build_inode(struct super_block *sb,
+		struct exfat_dir_entry *info, loff_t i_pos);
+void exfat_hash_inode(struct inode *inode, loff_t i_pos);
+void exfat_unhash_inode(struct inode *inode);
+void exfat_truncate(struct inode *inode, loff_t size);
+struct inode *exfat_iget(struct super_block *sb, loff_t i_pos);
+int exfat_write_inode(struct inode *inode, struct writeback_control *wbc);
+void exfat_evict_inode(struct inode *inode);
+int exfat_read_inode(struct inode *inode, struct exfat_dir_entry *info);
+
+/* exfat/nls.c */
+int exfat_nls_cmp_uniname(struct super_block *sb, unsigned short *a,
+		unsigned short *b);
+int exfat_nls_uni16s_to_vfsname(struct super_block *sb,
+		struct exfat_uni_name *uniname, unsigned char *p_cstring,
+		int len);
+int exfat_nls_vfsname_to_uni16s(struct super_block *sb,
+		const unsigned char *p_cstring, const int len,
+		struct exfat_uni_name *uniname, int *p_lossy);
+int exfat_create_upcase_table(struct super_block *sb);
+void exfat_free_upcase_table(struct super_block *sb);
+
+/* exfat/misc.c */
+void __exfat_fs_error(struct super_block *sb, int report, const char *fmt, ...)
+		__printf(3, 4) __cold;
+#define exfat_fs_error(sb, fmt, args...)          \
+		__exfat_fs_error(sb, 1, fmt, ## args)
+#define exfat_fs_error_ratelimit(sb, fmt, args...) \
+		__exfat_fs_error(sb, __ratelimit(&EXFAT_SB(sb)->ratelimit), \
+		fmt, ## args)
+void exfat_msg(struct super_block *sb, const char *lv, const char *fmt, ...)
+		__printf(3, 4) __cold;
+void exfat_time_fat2unix(struct exfat_sb_info *sbi, struct timespec64 *ts,
+		struct exfat_date_time *tp);
+void exfat_time_unix2fat(struct exfat_sb_info *sbi, struct timespec64 *ts,
+		struct exfat_date_time *tp);
+struct exfat_timestamp *exfat_tm_now(struct exfat_sb_info *sbi,
+		struct exfat_timestamp *tm);
+unsigned short exfat_calc_chksum_2byte(void *data, int len,
+		unsigned short chksum, int type);
+void exfat_update_bh(struct super_block *sb, struct buffer_head *bh, int sync);
+void exfat_chain_set(struct exfat_chain *ec, unsigned int dir,
+		unsigned int size, unsigned char flags);
+struct exfat_chain *exfat_chain_dup(struct exfat_chain *dir);
+
+#endif /* !_EXFAT_H */
diff --git a/fs/exfat/exfat_raw.h b/fs/exfat/exfat_raw.h
new file mode 100644
index 000000000000..5f962043f913
--- /dev/null
+++ b/fs/exfat/exfat_raw.h
@@ -0,0 +1,194 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef _EXFAT_RAW_H
+#define _EXFAT_RAW_H
+
+#include <linux/types.h>
+
+#define PBR_SIGNATURE		0xAA55
+
+#define VOL_CLEAN		0x0000
+#define VOL_DIRTY		0x0002
+
+/* AllocationPossible and NoFatChain field in GeneralSecondaryFlags Field */
+#define ALLOC_FAT_CHAIN		0x01
+#define ALLOC_NO_FAT_CHAIN	0x03
+
+#define DENTRY_SIZE		32 /* directory entry size */
+#define DENTRY_SIZE_BITS	5
+/* exFAT allows 8388608(256MB) directory entries */
+#define MAX_EXFAT_DENTRIES	8388608
+
+/* dentry types */
+#define MSDOS_DELETED		0xE5	/* deleted mark */
+#define MSDOS_UNUSED		0x00	/* end of directory */
+
+#define EXFAT_UNUSED		0x00	/* end of directory */
+#define EXFAT_DELETE		~(0x80)
+#define IS_EXFAT_DELETED(x)	((x) < 0x80) /* deleted file (0x01~0x7F) */
+#define EXFAT_INVAL		0x80	/* invalid value */
+#define EXFAT_BITMAP		0x81	/* allocation bitmap */
+#define EXFAT_UPCASE		0x82	/* upcase table */
+#define EXFAT_VOLUME		0x83	/* volume label */
+#define EXFAT_FILE		0x85	/* file or dir */
+#define EXFAT_GUID		0xA0
+#define EXFAT_PADDING		0xA1
+#define EXFAT_ACLTAB		0xA2
+#define EXFAT_STREAM		0xC0	/* stream entry */
+#define EXFAT_NAME		0xC1	/* file name entry */
+#define EXFAT_ACL		0xC2	/* stream entry */
+
+/* checksum types */
+#define CS_DIR_ENTRY		0
+#define CS_PBR_SECTOR		1
+#define CS_DEFAULT		2
+
+/* file attributes */
+#define ATTR_READONLY		0x0001
+#define ATTR_HIDDEN		0x0002
+#define ATTR_SYSTEM		0x0004
+#define ATTR_VOLUME		0x0008
+#define ATTR_SUBDIR		0x0010
+#define ATTR_ARCHIVE		0x0020
+#define ATTR_EXTEND		(ATTR_READONLY | ATTR_HIDDEN | ATTR_SYSTEM | \
+				 ATTR_VOLUME) /* 0x000F */
+
+#define ATTR_EXTEND_MASK	(ATTR_EXTEND | ATTR_SUBDIR | ATTR_ARCHIVE)
+#define ATTR_RWMASK		(ATTR_HIDDEN | ATTR_SYSTEM | ATTR_VOLUME | \
+				 ATTR_SUBDIR | ATTR_ARCHIVE)
+
+#define ATTR_READONLY_LE	cpu_to_le16(0x0001)
+#define ATTR_HIDDEN_LE		cpu_to_le16(0x0002)
+#define ATTR_SYSTEM_LE		cpu_to_le16(0x0004)
+#define ATTR_VOLUME_LE		cpu_to_le16(0x0008)
+#define ATTR_SUBDIR_LE		cpu_to_le16(0x0010)
+#define ATTR_ARCHIVE_LE		cpu_to_le16(0x0020)
+
+/* EXFAT BIOS parameter block (64 bytes) */
+struct bpb64 {
+	__u8 jmp_boot[3];
+	__u8 oem_name[8];
+	__u8 res_zero[53];
+};
+
+/* EXFAT EXTEND BIOS parameter block (56 bytes) */
+struct bsx64 {
+	__le64 vol_offset;
+	__le64 vol_length;
+	__le32 fat_offset;
+	__le32 fat_length;
+	__le32 clu_offset;
+	__le32 clu_count;
+	__le32 root_cluster;
+	__le32 vol_serial;
+	__u8 fs_version[2];
+	__le16 vol_flags;
+	__u8 sect_size_bits;
+	__u8 sect_per_clus_bits;
+	__u8 num_fats;
+	__u8 phy_drv_no;
+	__u8 perc_in_use;
+	__u8 reserved2[7];
+};
+
+/* EXFAT PBR[BPB+BSX] (120 bytes) */
+struct pbr64 {
+	struct bpb64 bpb;
+	struct bsx64 bsx;
+};
+
+/* Common PBR[Partition Boot Record] (512 bytes) */
+struct pbr {
+	union {
+		__u8 raw[64];
+		struct bpb64 f64;
+	} bpb;
+	union {
+		__u8 raw[56];
+		struct bsx64 f64;
+	} bsx;
+	__u8 boot_code[390];
+	__le16 signature;
+};
+
+struct exfat_dentry {
+	__u8 type;
+	union {
+		struct {
+			__u8 num_ext;
+			__le16 checksum;
+			__le16 attr;
+			__le16 reserved1;
+			__le16 create_time;
+			__le16 create_date;
+			__le16 modify_time;
+			__le16 modify_date;
+			__le16 access_time;
+			__le16 access_date;
+			__u8 create_time_ms;
+			__u8 modify_time_ms;
+			__u8 access_time_ms;
+			__u8 reserved2[9];
+		} __packed file; /* file directory entry */
+		struct {
+			__u8 flags;
+			__u8 reserved1;
+			__u8 name_len;
+			__le16 name_hash;
+			__le16 reserved2;
+			__le64 valid_size;
+			__le32 reserved3;
+			__le32 start_clu;
+			__le64 size;
+		} __packed stream; /* stream extension directory entry */
+		struct {
+			__u8 flags;
+			__le16 unicode_0_14[15];
+		} __packed name; /* file name directory entry */
+		struct {
+			__u8 flags;
+			__u8 reserved[18];
+			__le32 start_clu;
+			__le64 size;
+		} __packed bitmap; /* allocation bitmap directory entry */
+		struct {
+			__u8 reserved1[3];
+			__le32 checksum;
+			__u8 reserved2[12];
+			__le32 start_clu;
+			__le64 size;
+		} __packed upcase; /* up-case table directory entry */
+	} __packed dentry;
+} __packed;
+
+#define file_num_ext			dentry.file.num_ext
+#define file_checksum			dentry.file.checksum
+#define file_attr			dentry.file.attr
+#define file_create_time		dentry.file.create_time
+#define file_create_date		dentry.file.create_date
+#define file_modify_time		dentry.file.modify_time
+#define file_modify_date		dentry.file.modify_date
+#define file_access_time		dentry.file.access_time
+#define file_access_date		dentry.file.access_date
+#define file_create_time_ms		dentry.file.create_time_ms
+#define file_modify_time_ms		dentry.file.modify_time_ms
+#define file_access_time_ms		dentry.file.access_time_ms
+#define stream_flags			dentry.stream.flags
+#define stream_name_len			dentry.stream.name_len
+#define stream_name_hash		dentry.stream.name_hash
+#define stream_start_clu		dentry.stream.start_clu
+#define stream_valid_size		dentry.stream.valid_size
+#define stream_size			dentry.stream.size
+#define name_flags			dentry.name.flags
+#define name_unicode			dentry.name.unicode_0_14
+#define bitmap_flags			dentry.bitmap.flags
+#define bitmap_start_clu		dentry.bitmap.start_clu
+#define bitmap_size			dentry.bitmap.size
+#define upcase_start_clu		dentry.upcase.start_clu
+#define upcase_size			dentry.upcase.size
+#define upcase_checksum			dentry.upcase.checksum
+
+#endif /* !_EXFAT_RAW_H */
-- 
2.17.1

