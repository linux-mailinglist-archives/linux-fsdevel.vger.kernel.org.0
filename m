Return-Path: <linux-fsdevel+bounces-44091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 747FAA61FD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 23:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F17E171837
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 22:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4C31C6FE8;
	Fri, 14 Mar 2025 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="IxGMnwzm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29DE3594C;
	Fri, 14 Mar 2025 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741990045; cv=none; b=ZmflyilrHmbGRBxmx9PauFl8Uq5jB63Yf1kdwVq9Zhpbxlny/KiqEUKPW2y4px/0UXU45hqelokDrQI6AgodbkP29s2YjscH1prYIHL+L8WrY2xjDOz6bbkw6XM5q2Wv/xWTvM0kQBISrXd+p5CQvqIKnBQO5z3GnlAQhz5Mboo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741990045; c=relaxed/simple;
	bh=1BaGm9tWBZww9V/eBabcaTqSyhQ80m2fbfLg9y52Oxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jsrTG9L4szItzFiMFDVPfXekJ+gh9SE0WKaZk0NnNvU1z5vTSn7nUlYAAnlHHDJ2XcRoo5O8P2GTgG5GV6YQ0lNBCF5YdIfTse3jETp/EkGnwqnxav11iiKE4KG2y9A6aNKcLfyVm7ydJAIw3engSWmb9bE0DFn1Uf1LOlAp7ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=IxGMnwzm; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZDytX04Nrz9sc4;
	Fri, 14 Mar 2025 22:58:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1741989524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LD+xpUlUpbYFs1nnAcV2yzV2JSYLMu72sqw+zLdABsI=;
	b=IxGMnwzmQoFgVKusIR4uZQyNAOpsLxqaGD7iiqtBOpkUciFxEJk9KW/hfHmse7XIuy4F5M
	iZk5GlyUCOV9h1/WqbR4Dg7JZ5zE0S+KyRWCFm/1z31p2aZ3iQxoDNJacghDnFF3Tysx4r
	2kLXoRTsuxnvQb77a88e6M2x7nyete85YygP9aiP5n4MRRS5AZmn0ToIeapBf2VIhHXKvl
	3UNZNPVHg6IzRICwGJxwY6BJGvuQKYYQgX25pvO9kx9z7yGy1XuajNDG0PqIfV7KcMQc5Y
	tFO7Q0YctEPHaJ32N/hDyhaZNhcOrJUXayZ2gDzHYIOFGmwFTqGMdDKAEVtnqw==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Fri, 14 Mar 2025 17:57:51 -0400
Subject: [PATCH RFC 5/8] staging: apfs: init APFS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250314-apfs-v1-5-ddfaa6836b5c@ethancedwards.com>
References: <20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com>
In-Reply-To: <20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tytso@mit.edu
Cc: ernesto.mnd.fernandez@gmail.com, dan.carpenter@linaro.org, 
 sven@svenpeter.dev, ernesto@corellium.com, gargaditya08@live.com, 
 willy@infradead.org, asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-staging@lists.linux.dev, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=562400;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=1BaGm9tWBZww9V/eBabcaTqSyhQ80m2fbfLg9y52Oxg=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBGOVpWcUZYckpVOHUwUHE3NG1YQ2N0YzErZUdSK3g3ClUxRC9kOEVYQVN2ZHg1TWYx
 cTNvS0dWaEVPTmlrQlZUWlBtZm81ejJVSE9Hd3M2L0xrMHdjMWlaUUlZd2NIRUsKd0VVdU1meFR
 XaUxPblBOKzA5MXQ3cnVOSjZ3OHEydVduRFpwbWxuQ1ZSMlJ3MHozSzA4S01qTE00anhvOUdhUg
 ovNVQxcDdvK3YxclVhNUh4Ni83V2liTzR0SnZNTThVZlNENWhCd0NGZjA5OQo9UkFDaQotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE
X-Rspamd-Queue-Id: 4ZDytX04Nrz9sc4

This adds read support and experimental write support for the APFS
filesystem.

Please note that this is all included in one commit in order to maintain
git-bisect functionality and not break the build.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 drivers/staging/apfs/apfs.h        | 1193 ++++++++++++++++++
 drivers/staging/apfs/btree.c       | 1174 ++++++++++++++++++
 drivers/staging/apfs/compress.c    |  442 +++++++
 drivers/staging/apfs/dir.c         | 1440 ++++++++++++++++++++++
 drivers/staging/apfs/extents.c     | 2371 ++++++++++++++++++++++++++++++++++++
 drivers/staging/apfs/file.c        |  164 +++
 drivers/staging/apfs/inode.c       | 2235 +++++++++++++++++++++++++++++++++
 drivers/staging/apfs/key.c         |  337 +++++
 drivers/staging/apfs/message.c     |   29 +
 drivers/staging/apfs/namei.c       |  133 ++
 drivers/staging/apfs/node.c        | 2069 +++++++++++++++++++++++++++++++
 drivers/staging/apfs/object.c      |  315 +++++
 drivers/staging/apfs/snapshot.c    |  684 +++++++++++
 drivers/staging/apfs/spaceman.c    | 1433 ++++++++++++++++++++++
 drivers/staging/apfs/super.c       | 2099 +++++++++++++++++++++++++++++++
 drivers/staging/apfs/symlink.c     |   78 ++
 drivers/staging/apfs/transaction.c |  959 +++++++++++++++
 drivers/staging/apfs/xattr.c       |  912 ++++++++++++++
 drivers/staging/apfs/xfield.c      |  171 +++
 19 files changed, 18238 insertions(+)

diff --git a/drivers/staging/apfs/apfs.h b/drivers/staging/apfs/apfs.h
new file mode 100644
index 0000000000000000000000000000000000000000..dbee13911f5efcc7d2ff65d6d09768b3d1f0d6db
--- /dev/null
+++ b/drivers/staging/apfs/apfs.h
@@ -0,0 +1,1193 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2018 Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
+ * Copyright (C) 2025 Ethan Carter Edwards <ethan@ethancedwards.com>
+ */
+
+#ifndef _APFS_H
+#define _APFS_H
+
+#include <linux/buffer_head.h>
+#include <linux/fs.h>
+#include <linux/list.h>
+#include <linux/types.h>
+#include <linux/version.h>
+
+#include "apfs_raw.h"
+
+#define EFSBADCRC	EBADMSG		/* Bad CRC detected */
+#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
+
+#define apfs_submit_bh(op, op_flags, bh) submit_bh(op | op_flags, bh)
+
+/*
+ * Parameter for the snapshot creation ioctl
+ */
+struct apfs_ioctl_snap_name {
+	char name[APFS_SNAP_MAX_NAMELEN + 1];
+};
+
+#define APFS_IOC_SET_DFLT_PFK	_IOW('@', 0x80, struct apfs_wrapped_crypto_state)
+#define APFS_IOC_SET_DIR_CLASS	_IOW('@', 0x81, u32)
+#define APFS_IOC_SET_PFK	_IOW('@', 0x82, struct apfs_wrapped_crypto_state)
+#define APFS_IOC_GET_CLASS	_IOR('@', 0x83, u32)
+#define APFS_IOC_GET_PFK	_IOR('@', 0x84, struct apfs_wrapped_crypto_state)
+#define APFS_IOC_TAKE_SNAPSHOT	_IOW('@', 0x85, struct apfs_ioctl_snap_name)
+
+/*
+ * In-memory representation of an APFS object
+ */
+struct apfs_object {
+	struct super_block *sb;
+	u64 block_nr;
+	u64 oid;
+
+	/*
+	 * Buffer head containing the one block of the object, may be NULL if
+	 * the object is only in memory. TODO: support objects with more than
+	 * one block.
+	 */
+	struct buffer_head *o_bh;
+	char *data; /* The raw object */
+	bool ephemeral; /* Is this an ephemeral object? */
+};
+
+/* Constants used in managing the size of a node's table of contents */
+#define APFS_BTREE_TOC_ENTRY_INCREMENT	8
+#define APFS_BTREE_TOC_ENTRY_MAX_UNUSED	(2 * BTREE_TOC_ENTRY_INCREMENT)
+
+/*
+ * In-memory representation of an APFS node
+ */
+struct apfs_node {
+	u32 tree_type;		/* Tree type (subtype of the node object) */
+	u16 flags;		/* Node flags */
+	u32 records;		/* Number of records in the node */
+
+	int key;		/* Offset of the key area in the block */
+	int free;		/* Offset of the free area in the block */
+	int val;		/* Offset of the value area in the block */
+
+	int key_free_list_len;	/* Length of the fragmented free key space */
+	int val_free_list_len;	/* Length of the fragmented free value space */
+
+	struct apfs_object object; /* Object holding the node */
+};
+
+/**
+ * apfs_node_is_leaf - Check if a b-tree node is a leaf
+ * @node: the node to check
+ */
+static inline bool apfs_node_is_leaf(struct apfs_node *node)
+{
+	return (node->flags & APFS_BTNODE_LEAF) != 0;
+}
+
+/**
+ * apfs_node_is_root - Check if a b-tree node is the root
+ * @node: the node to check
+ */
+static inline bool apfs_node_is_root(struct apfs_node *node)
+{
+	return (node->flags & APFS_BTNODE_ROOT) != 0;
+}
+
+/**
+ * apfs_node_has_fixed_kv_size - Check if a b-tree node has fixed key/value
+ * sizes
+ * @node: the node to check
+ */
+static inline bool apfs_node_has_fixed_kv_size(struct apfs_node *node)
+{
+	return (node->flags & APFS_BTNODE_FIXED_KV_SIZE) != 0;
+}
+
+struct apfs_ip_bitmap_block_info {
+	bool	dirty;		/* Do we need to commit this block to disk? */
+	void	*block;		/* In-memory address of the bitmap block */
+};
+
+/*
+ * Space manager data in memory.
+ */
+struct apfs_spaceman {
+	struct apfs_spaceman_phys *sm_raw; /* On-disk spaceman structure */
+	struct apfs_nxsb_info	  *sm_nxi; /* Container superblock */
+	u32			  sm_size; /* Size of @sm_raw in bytes */
+
+	u32 sm_blocks_per_chunk;	/* Blocks covered by a bitmap block */
+	u32 sm_chunks_per_cib;		/* Chunk count in a chunk-info block */
+	u64 sm_block_count;		/* Block count for the container */
+	u64 sm_chunk_count;		/* Number of bitmap blocks */
+	u32 sm_cib_count;		/* Number of chunk-info blocks */
+	u64 sm_free_count;		/* Number of free blocks */
+	u32 sm_addr_offset;		/* Offset of cib addresses in @sm_raw */
+
+	/*
+	 * A range of freed blocks not yet put in the free queue. Extend this as
+	 * much as possible before creating an actual record.
+	 */
+	u64 sm_free_cache_base;
+	u64 sm_free_cache_blkcnt;
+
+	/* Shift to match an ip block with its bitmap in the array */
+	int sm_ip_bmaps_shift;
+	/* Mask to find an ip block's offset inside its ip bitmap */
+	u32 sm_ip_bmaps_mask;
+	/* Number of ip bitmaps */
+	u32 sm_ip_bmaps_count;
+	/* List of ip bitmaps, in order */
+	struct apfs_ip_bitmap_block_info sm_ip_bmaps[];
+};
+
+#define APFS_TRANS_MAIN_QUEUE_MAX	10000
+#define APFS_TRANS_BUFFERS_MAX		65536
+#define APFS_TRANS_STARTS_MAX		65536
+
+/* Possible states for the container transaction structure */
+#define APFS_NX_TRANS_FORCE_COMMIT	1	/* Commit guaranteed */
+#define APFS_NX_TRANS_DEFER_COMMIT	2	/* Commit banned right now */
+#define APFS_NX_TRANS_COMMITTING	4	/* Commit ongoing */
+#define APFS_NX_TRANS_INCOMPLETE_BLOCK	8	/* A data block is not written in full */
+
+/*
+ * Structure that keeps track of a container transaction.
+ */
+struct apfs_nx_transaction {
+	unsigned int t_state;
+
+	struct delayed_work t_work;	/* Work task for transaction commits */
+	struct super_block *t_work_sb;	/* sb that last queued a commit */
+
+	struct list_head t_inodes;	/* List of inodes in the transaction */
+	struct list_head t_buffers;	/* List of buffers in the transaction */
+	size_t t_buffers_count;		/* Count of items on the list */
+	int t_starts_count;		/* Count of starts for transaction */
+};
+
+/* State bits for buffer heads in a transaction */
+#define BH_TRANS	BH_PrivateStart		/* Attached to a transaction */
+#define BH_CSUM		(BH_PrivateStart + 1)	/* Requires checksum update */
+BUFFER_FNS(TRANS, trans);
+BUFFER_FNS(CSUM, csum);
+
+/*
+ * Additional information for a buffer in a transaction.
+ */
+struct apfs_bh_info {
+	struct buffer_head	*bh;	/* The buffer head */
+	struct list_head	list;	/* List of buffers in the transaction */
+};
+
+/*
+ * Used to report how many operations may be needed for a transaction
+ */
+struct apfs_max_ops {
+	int cat;	/* Maximum catalog records that may need changing */
+	int blks;	/* Maximum extent blocks that may need changing */
+};
+
+/*
+ * List entry for an in-memory ephemeral object
+ */
+struct apfs_ephemeral_object_info {
+	u64	oid;		/* Ephemeral object id */
+	u32	size;		/* Size of the object in bytes */
+	void	*object;	/* In-memory address of the object */
+};
+
+/*
+ * We allocate a fixed space for the list of ephemeral objects. I don't
+ * actually know how big this should be allowed to get, but all the objects
+ * must be written down with each transaction commit, so probably not too big.
+ */
+#define APFS_EPHEMERAL_LIST_SIZE	32768
+#define APFS_EPHEMERAL_LIST_LIMIT	(APFS_EPHEMERAL_LIST_SIZE / sizeof(struct apfs_ephemeral_object_info))
+
+/* Mount option flags for a container */
+#define APFS_CHECK_NODES	1
+#define APFS_READWRITE		2
+/*
+ * Mount options for a container are decided on its first mount. This flag lets
+ * future mounts know that has happened already.
+ */
+#define APFS_FLAGS_SET		4
+
+/*
+ * Wrapper around block devices for portability.
+ */
+struct apfs_blkdev_info {
+	struct block_device *blki_bdev;
+	struct file *blki_bdev_file;
+
+	/*
+	 * For tier 2, we need to remember the mount path for show_options().
+	 * We don't need this for the main device of course, but better to
+	 * keep things consistent.
+	 */
+	char *blki_path;
+};
+
+/*
+ * Container superblock data in memory
+ */
+struct apfs_nxsb_info {
+	/* Block device info for the container */
+	struct apfs_blkdev_info *nx_blkdev_info;
+	struct apfs_blkdev_info *nx_tier2_info;
+	u64 nx_tier2_bno; /* Offset for tier 2 block numbers */
+
+	struct apfs_nx_superblock *nx_raw; /* On-disk main sb */
+	u64 nx_bno; /* Current block number for the checkpoint superblock */
+	u64 nx_xid; /* Latest transaction id */
+
+	/* List of ephemeral objects in memory (except the superblock) */
+	struct apfs_ephemeral_object_info *nx_eph_list;
+	int nx_eph_count;
+
+	struct list_head vol_list;	/* List of mounted volumes in container */
+
+	unsigned int nx_flags;	/* Mount options shared by all volumes */
+	unsigned int nx_refcnt; /* Number of mounted volumes in container */
+
+	/* TODO: handle block sizes above the maximum of PAGE_SIZE? */
+	unsigned long nx_blocksize;
+	unsigned char nx_blocksize_bits;
+
+	struct apfs_spaceman *nx_spaceman;
+	struct apfs_nx_transaction nx_transaction;
+	int nx_trans_buffers_max;
+
+	/* For now, a single semaphore for every operation */
+	struct rw_semaphore nx_big_sem;
+
+	/* List of currently mounted containers */
+	struct list_head nx_list;
+};
+
+extern struct mutex nxs_mutex;
+
+/*
+ * Omap mapping in memory.
+ * TODO: could this and apfs_omap_rec be the same struct?
+ */
+struct apfs_omap_map {
+	u64 xid;
+	u64 bno;
+	u32 flags;
+};
+
+/*
+ * Omap record data in memory
+ */
+struct apfs_omap_rec {
+	u64 oid;
+	u64 bno;
+};
+
+#define APFS_OMAP_CACHE_SLOTS		128
+#define APFS_OMAP_CACHE_SLOT_MASK	(APFS_OMAP_CACHE_SLOTS - 1)
+
+/**
+ * Cache of omap records
+ */
+struct apfs_omap_cache {
+	struct apfs_omap_rec recs[APFS_OMAP_CACHE_SLOTS];
+	bool disabled;
+	spinlock_t lock;
+};
+
+/*
+ * Omap structure shared by all snapshots for the same volume.
+ */
+struct apfs_omap {
+	struct apfs_node *omap_root;
+	struct apfs_omap_cache omap_cache;
+
+	/* Transaction id for most recent snapshot */
+	u64 omap_latest_snap;
+
+	/* Number of snapshots sharing this omap */
+	unsigned int omap_refcnt;
+};
+
+/*
+ * Volume superblock data in memory
+ */
+struct apfs_sb_info {
+	struct apfs_nxsb_info *s_nxi; /* In-memory container sb for volume */
+	struct list_head list;		/* List of mounted volumes in container */
+	struct apfs_superblock *s_vsb_raw; /* On-disk volume sb */
+
+	dev_t s_anon_dev; /* Anonymous device for this volume-snapshot */
+
+	char *s_tier2_path; /* Path to the tier 2 device */
+
+	char *s_snap_name; /* Label for the mounted snapshot */
+	u64 s_snap_xid; /* Transaction id for mounted snapshot */
+
+	struct apfs_node *s_cat_root;	/* Root of the catalog tree */
+	struct apfs_omap *s_omap;	/* The object map */
+
+	struct apfs_object s_vobject;	/* Volume superblock object */
+
+	/* Mount options */
+	unsigned int s_vol_nr;		/* Index of the volume in the sb list */
+	kuid_t s_uid;			/* uid to override on-disk uid */
+	kgid_t s_gid;			/* gid to override on-disk gid */
+
+	struct apfs_crypto_state_val *s_dflt_pfk; /* default per-file key */
+
+	struct inode *s_private_dir;	/* Inode for the private directory */
+	struct work_struct s_orphan_cleanup_work;
+};
+
+static inline struct apfs_sb_info *APFS_SB(struct super_block *sb)
+{
+	return sb->s_fs_info;
+}
+
+static inline bool apfs_is_sealed(struct super_block *sb)
+{
+	u64 flags = le64_to_cpu(APFS_SB(sb)->s_vsb_raw->apfs_incompatible_features);
+
+	return flags & APFS_INCOMPAT_SEALED_VOLUME;
+}
+
+/**
+ * apfs_vol_is_encrypted - Check if a volume is encrypting files
+ * @sb: superblock
+ */
+static inline bool apfs_vol_is_encrypted(struct super_block *sb)
+{
+	struct apfs_superblock *vsb_raw = APFS_SB(sb)->s_vsb_raw;
+
+	return (vsb_raw->apfs_fs_flags & cpu_to_le64(APFS_FS_UNENCRYPTED)) == 0;
+}
+
+/**
+ * APFS_NXI - Get the shared container info for a volume's superblock
+ * @sb: superblock structure
+ */
+static inline struct apfs_nxsb_info *APFS_NXI(struct super_block *sb)
+{
+	return APFS_SB(sb)->s_nxi;
+}
+
+/**
+ * APFS_SM - Get the shared spaceman struct for a volume's superblock
+ * @sb: superblock structure
+ */
+static inline struct apfs_spaceman *APFS_SM(struct super_block *sb)
+{
+	return APFS_NXI(sb)->nx_spaceman;
+}
+
+static inline bool apfs_is_case_insensitive(struct super_block *sb)
+{
+	return (APFS_SB(sb)->s_vsb_raw->apfs_incompatible_features &
+	       cpu_to_le64(APFS_INCOMPAT_CASE_INSENSITIVE)) != 0;
+}
+
+static inline bool apfs_is_normalization_insensitive(struct super_block *sb)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	u64 flags = le64_to_cpu(sbi->s_vsb_raw->apfs_incompatible_features);
+
+	if (apfs_is_case_insensitive(sb))
+		return true;
+	if (flags & APFS_INCOMPAT_NORMALIZATION_INSENSITIVE)
+		return true;
+	return false;
+}
+
+/**
+ * apfs_max_maps_per_block - Find the maximum map count for a mapping block
+ * @sb: superblock structure
+ */
+static inline int apfs_max_maps_per_block(struct super_block *sb)
+{
+	unsigned long maps_size;
+
+	maps_size = (sb->s_blocksize - sizeof(struct apfs_checkpoint_map_phys));
+	return maps_size / sizeof(struct apfs_checkpoint_mapping);
+}
+
+/*
+ * In-memory representation of a key, as relevant for a b-tree query.
+ */
+struct apfs_key {
+	u64		id;
+	u64		number;	/* Extent offset, name hash or transaction id */
+	const char	*name;	/* On-disk name string */
+	u8		type;	/* Record type (0 for the omap) */
+};
+
+/**
+ * apfs_init_free_queue_key - Initialize an in-memory key for a free queue query
+ * @xid:	transaction id
+ * @paddr:	block number
+ * @key:	apfs_key structure to initialize
+ */
+static inline void apfs_init_free_queue_key(u64 xid, u64 paddr,
+					    struct apfs_key *key)
+{
+	key->id = xid;
+	key->type = 0;
+	key->number = paddr;
+	key->name = NULL;
+}
+
+/**
+ * apfs_init_omap_key - Initialize an in-memory key for an omap query
+ * @oid:	object id
+ * @xid:	latest transaction id
+ * @key:	apfs_key structure to initialize
+ */
+static inline void apfs_init_omap_key(u64 oid, u64 xid, struct apfs_key *key)
+{
+	key->id = oid;
+	key->type = 0;
+	key->number = xid;
+	key->name = NULL;
+}
+
+/**
+ * apfs_init_extent_key - Initialize an in-memory key for an extentref query
+ * @bno:	physical block number for the start of the extent
+ * @key:	apfs_key structure to initialize
+ */
+static inline void apfs_init_extent_key(u64 bno, struct apfs_key *key)
+{
+	key->id = bno;
+	key->type = APFS_TYPE_EXTENT;
+	key->number = 0;
+	key->name = NULL;
+}
+
+/**
+ * apfs_init_inode_key - Initialize an in-memory key for an inode query
+ * @ino:	inode number
+ * @key:	apfs_key structure to initialize
+ */
+static inline void apfs_init_inode_key(u64 ino, struct apfs_key *key)
+{
+	key->id = ino;
+	key->type = APFS_TYPE_INODE;
+	key->number = 0;
+	key->name = NULL;
+}
+
+/**
+ * apfs_init_file_extent_key - Initialize an in-memory key for an extent query
+ * @id:		extent id
+ * @offset:	logical address (0 for a multiple query)
+ * @key:	apfs_key structure to initialize
+ */
+static inline void apfs_init_file_extent_key(u64 id, u64 offset,
+					     struct apfs_key *key)
+{
+	key->id = id;
+	key->type = APFS_TYPE_FILE_EXTENT;
+	key->number = offset;
+	key->name = NULL;
+}
+
+static inline void apfs_init_fext_key(u64 id, u64 offset, struct apfs_key *key)
+{
+	key->id = id;
+	key->type = 0;
+	key->number = offset;
+	key->name = NULL;
+}
+
+/**
+ * apfs_init_dstream_id_key - Initialize an in-memory key for a dstream query
+ * @id:		data stream id
+ * @key:	apfs_key structure to initialize
+ */
+static inline void apfs_init_dstream_id_key(u64 id, struct apfs_key *key)
+{
+	key->id = id;
+	key->type = APFS_TYPE_DSTREAM_ID;
+	key->number = 0;
+	key->name = NULL;
+}
+
+/**
+ * apfs_init_crypto_state_key - Initialize an in-memory key for a crypto query
+ * @id:		crypto state id
+ * @key:	apfs_key structure to initialize
+ */
+static inline void apfs_init_crypto_state_key(u64 id, struct apfs_key *key)
+{
+	key->id = id;
+	key->type = APFS_TYPE_CRYPTO_STATE;
+	key->number = 0;
+	key->name = NULL;
+}
+
+/**
+ * apfs_init_sibling_link_key - Initialize an in-memory key for a sibling query
+ * @ino:	inode number
+ * @id:		sibling id
+ * @key:	apfs_key structure to initialize
+ */
+static inline void apfs_init_sibling_link_key(u64 ino, u64 id,
+					      struct apfs_key *key)
+{
+	key->id = ino;
+	key->type = APFS_TYPE_SIBLING_LINK;
+	key->number = id; /* Only guessing (TODO) */
+	key->name = NULL;
+}
+
+/**
+ * apfs_init_sibling_map_key - Initialize in-memory key for a sibling map query
+ * @id:		sibling id
+ * @key:	apfs_key structure to initialize
+ */
+static inline void apfs_init_sibling_map_key(u64 id, struct apfs_key *key)
+{
+	key->id = id;
+	key->type = APFS_TYPE_SIBLING_MAP;
+	key->number = 0;
+	key->name = NULL;
+}
+
+extern void apfs_init_drec_key(struct super_block *sb, u64 ino, const char *name,
+			       unsigned int name_len, struct apfs_key *key);
+
+/**
+ * apfs_init_xattr_key - Initialize an in-memory key for a xattr query
+ * @ino:	inode number of the parent file
+ * @name:	xattr name (NULL for a multiple query)
+ * @key:	apfs_key structure to initialize
+ */
+static inline void apfs_init_xattr_key(u64 ino, const char *name,
+				       struct apfs_key *key)
+{
+	key->id = ino;
+	key->type = APFS_TYPE_XATTR;
+	key->number = 0;
+	key->name = name;
+}
+
+static inline void apfs_init_snap_metadata_key(u64 xid, struct apfs_key *key)
+{
+	key->id = xid;
+	key->type = APFS_TYPE_SNAP_METADATA;
+	key->number = 0;
+	key->name = NULL;
+}
+
+static inline void apfs_init_snap_name_key(const char *name, struct apfs_key *key)
+{
+	key->id = APFS_SNAP_NAME_OBJ_ID;
+	key->type = APFS_TYPE_SNAP_NAME;
+	key->number = 0;
+	key->name = name;
+}
+
+static inline void apfs_init_omap_snap_key(u64 xid, struct apfs_key *key)
+{
+	key->id = xid;
+	key->type = 0;
+	key->number = 0;
+	key->name = NULL;
+}
+
+/**
+ * apfs_key_set_hdr - Set the header for a raw catalog key
+ * @type:	record type
+ * @id:		record id
+ * @key:	the key to initialize
+ */
+static inline void apfs_key_set_hdr(u64 type, u64 id, void *key)
+{
+	struct apfs_key_header *hdr = key;
+
+	hdr->obj_id_and_type = cpu_to_le64(id | type << APFS_OBJ_TYPE_SHIFT);
+}
+
+/**
+ * apfs_cat_type - Read the record type of a catalog key
+ * @key: the raw catalog key
+ */
+static inline int apfs_cat_type(struct apfs_key_header *key)
+{
+	return (le64_to_cpu(key->obj_id_and_type) & APFS_OBJ_TYPE_MASK) >> APFS_OBJ_TYPE_SHIFT;
+}
+
+/**
+ * apfs_cat_cnid - Read the cnid value on a catalog key
+ * @key: the raw catalog key
+ *
+ * TODO: rename this function, since it's not just for the catalog anymore
+ */
+static inline u64 apfs_cat_cnid(struct apfs_key_header *key)
+{
+	return le64_to_cpu(key->obj_id_and_type) & APFS_OBJ_ID_MASK;
+}
+
+/* Flags for the query structure */
+#define APFS_QUERY_TREE_MASK	000177	/* Which b-tree we query */
+#define APFS_QUERY_OMAP		000001	/* This is a b-tree object map query */
+#define APFS_QUERY_CAT		000002	/* This is a catalog tree query */
+#define APFS_QUERY_FREE_QUEUE	000004	/* This is a free queue query */
+#define APFS_QUERY_EXTENTREF	000010	/* This is an extent reference query */
+#define APFS_QUERY_FEXT		000020	/* This is a fext tree query */
+#define APFS_QUERY_SNAP_META	000040	/* This is a snapshot meta query */
+#define APFS_QUERY_OMAP_SNAP	000100	/* This is an omap snapshots query */
+#define APFS_QUERY_NEXT		000200	/* Find next of multiple matches */
+#define APFS_QUERY_EXACT	000400	/* Search for an exact match */
+#define APFS_QUERY_DONE		001000	/* The search at this level is over */
+#define APFS_QUERY_ANY_NAME	002000	/* Multiple search for any name */
+#define APFS_QUERY_ANY_NUMBER	004000	/* Multiple search for any number */
+#define APFS_QUERY_MULTIPLE	(APFS_QUERY_ANY_NAME | APFS_QUERY_ANY_NUMBER)
+#define APFS_QUERY_PREV		010000	/* Find previous record */
+
+/*
+ * Structure used to retrieve data from an APFS B-Tree.
+ */
+struct apfs_query {
+	struct apfs_node *node;		/* Node being searched */
+	struct apfs_key key;		/* What the query is looking for */
+
+	struct apfs_query *parent;	/* Query for parent node */
+	unsigned int flags;
+
+	/* Set by the query on success */
+	int index;			/* Index of the entry in the node */
+	int key_off;			/* Offset of the key in the node */
+	int key_len;			/* Length of the key */
+	int off;			/* Offset of the value in the node */
+	int len;			/* Length of the value */
+
+	int depth;			/* Put a limit on recursion */
+};
+
+/**
+ * apfs_query_storage - Get the storage type for a query's btree
+ * @query: the query structure
+ */
+static inline u32 apfs_query_storage(struct apfs_query *query)
+{
+	if (query->flags & APFS_QUERY_OMAP)
+		return APFS_OBJ_PHYSICAL;
+	if (query->flags & APFS_QUERY_CAT)
+		return APFS_OBJ_VIRTUAL;
+	if (query->flags & APFS_QUERY_FEXT)
+		return APFS_OBJ_PHYSICAL;
+	if (query->flags & APFS_QUERY_FREE_QUEUE)
+		return APFS_OBJ_EPHEMERAL;
+	if (query->flags & APFS_QUERY_EXTENTREF)
+		return APFS_OBJ_PHYSICAL;
+	if (query->flags & APFS_QUERY_SNAP_META)
+		return APFS_OBJ_PHYSICAL;
+	if (query->flags & APFS_QUERY_OMAP_SNAP)
+		return APFS_OBJ_PHYSICAL;
+
+	/* Absurd, but don't panic: let the callers fail and report it */
+	return -1;
+}
+
+/*
+ * Extent record data in memory
+ */
+struct apfs_file_extent {
+	u64 logical_addr;
+	u64 phys_block_num;
+	u64 len;
+	u64 crypto_id;
+};
+
+/*
+ * Physical extent record data in memory
+ */
+struct apfs_phys_extent {
+	u64 bno;
+	u64 blkcount;
+	u64 len;	/* In bytes */
+	u32 refcnt;
+	u8 kind;
+};
+
+/*
+ * Data stream info in memory
+ */
+struct apfs_dstream_info {
+	struct super_block	*ds_sb;		/* Filesystem superblock */
+	struct inode		*ds_inode;	/* NULL for xattr dstreams */
+	u64			ds_id;		/* ID of the extent records */
+	u64			ds_size;	/* Length of the stream */
+	u64			ds_sparse_bytes;/* Hole byte count in stream */
+	struct apfs_file_extent	ds_cached_ext;	/* Latest extent record */
+	bool			ds_ext_dirty;	/* Is ds_cached_ext dirty? */
+	spinlock_t		ds_ext_lock;	/* Protects ds_cached_ext */
+	bool			ds_shared;	/* Has multiple references? */
+};
+
+/**
+ * apfs_alloced_size - Return the alloced size for a data stream
+ * @dstream: data stream info
+ *
+ * TODO: is this always correct? Or could the extents have an unused tail?
+ */
+static inline u64 apfs_alloced_size(struct apfs_dstream_info *dstream)
+{
+	struct super_block *sb = dstream->ds_sb;
+	u64 blks = (dstream->ds_size + sb->s_blocksize - 1) >> sb->s_blocksize_bits;
+
+	return blks << sb->s_blocksize_bits;
+}
+
+/*
+ * APFS inode data in memory
+ */
+struct apfs_inode_info {
+	u64			i_ino64;	 /* 32-bit-safe inode number */
+	u64			i_parent_id;	 /* ID of primary parent */
+	struct timespec64	i_crtime;	 /* Time of creation */
+	u32			i_nchildren;	 /* Child count for directory */
+	uid_t			i_saved_uid;	 /* User ID on disk */
+	gid_t			i_saved_gid;	 /* Group ID on disk */
+	u32			i_key_class;	 /* Security class for directory */
+	u64			i_int_flags;	 /* Internal flags */
+	u32			i_bsd_flags;	 /* BSD flags */
+	struct list_head	i_list;		 /* List of inodes in transaction */
+
+	bool			 i_has_dstream;	 /* Is there a dstream record? */
+	struct apfs_dstream_info i_dstream;	 /* Dstream data, if any */
+
+	bool			i_cleaned;	 /* Orphan data already deleted */
+
+	struct inode vfs_inode;
+};
+
+static inline struct apfs_inode_info *APFS_I(const struct inode *inode)
+{
+	return container_of(inode, struct apfs_inode_info, vfs_inode);
+}
+
+/**
+ * apfs_ino - Get the 64-bit id of an inode
+ * @inode: the vfs inode
+ *
+ * Returns all 64 bits of @inode's id, even on 32-bit architectures.
+ */
+static inline u64 apfs_ino(const struct inode *inode)
+{
+	return APFS_I(inode)->i_ino64;
+}
+
+/**
+ * apfs_set_ino - Set a 64-bit id on an inode
+ * @inode: the vfs inode
+ * @id:	   id to set
+ *
+ * Sets both the vfs inode number and the actual 32-bit-safe id.
+ */
+static inline void apfs_set_ino(struct inode *inode, u64 id)
+{
+	inode->i_ino = id; /* Higher bits may be lost, but it doesn't matter */
+	APFS_I(inode)->i_ino64 = id;
+}
+
+/* Make the compiler complain if we ever access i_ino directly by mistake */
+#define i_ino	DONT_USE_I_INO
+
+/*
+ * Directory entry record in memory
+ */
+struct apfs_drec {
+	u8 *name;
+	u64 ino;
+	u64 sibling_id; /* The sibling id; 0 if none */
+	int name_len;
+	unsigned int type;
+};
+
+/*
+ * Xattr record data in memory
+ */
+struct apfs_xattr {
+	u8 *name;
+	u8 *xdata;
+	int name_len;
+	int xdata_len;
+	bool has_dstream;
+};
+
+struct apfs_compressed_data {
+	bool has_dstream;
+	u64 size;
+	union {
+		struct apfs_dstream_info *dstream;
+		void *data;
+	};
+};
+
+/*
+ * Report function name and line number for the message types that are likely
+ * to signal a bug, to make things easier for reporters. Don't do this for the
+ * common messages, there is no point and it makes the console look too busy.
+ */
+#define apfs_emerg(sb, fmt, ...) apfs_msg(sb, KERN_EMERG, __func__, __LINE__, fmt, ##__VA_ARGS__)
+#define apfs_alert(sb, fmt, ...) apfs_msg(sb, KERN_ALERT, __func__, __LINE__, fmt, ##__VA_ARGS__)
+#define apfs_crit(sb, fmt, ...) apfs_msg(sb, KERN_CRIT, __func__, __LINE__, fmt, ##__VA_ARGS__)
+#define apfs_err(sb, fmt, ...) apfs_msg(sb, KERN_ERR, __func__, __LINE__, fmt, ##__VA_ARGS__)
+#define apfs_warn(sb, fmt, ...) apfs_msg(sb, KERN_WARNING, NULL, 0, fmt, ##__VA_ARGS__)
+#define apfs_notice(sb, fmt, ...) apfs_msg(sb, KERN_NOTICE, NULL, 0, fmt, ##__VA_ARGS__)
+#define apfs_info(sb, fmt, ...) apfs_msg(sb, KERN_INFO, NULL, 0, fmt, ##__VA_ARGS__)
+
+#ifdef CONFIG_APFS_DEBUG
+#define ASSERT(expr)	WARN_ON(!(expr))
+#define apfs_debug(sb, fmt, ...) apfs_msg(sb, KERN_DEBUG, __func__, __LINE__, fmt, ##__VA_ARGS__)
+#else
+#define ASSERT(expr)	((void)0)
+#define apfs_debug(sb, fmt, ...) no_printk(fmt, ##__VA_ARGS__)
+#endif /* CONFIG_APFS_DEBUG */
+
+/**
+ * apfs_assert_in_transaction - Assert that the object is in current transaction
+ * @sb:		superblock structure
+ * @obj:	on-disk object to check
+ */
+#define apfs_assert_in_transaction(sb, obj)				\
+do {									\
+	(void)sb;							\
+	(void)obj;							\
+	ASSERT(le64_to_cpu((obj)->o_xid) == APFS_NXI(sb)->nx_xid);	\
+} while (0)
+
+/* btree.c */
+extern struct apfs_node *apfs_query_root(const struct apfs_query *query);
+extern struct apfs_query *apfs_alloc_query(struct apfs_node *node,
+					   struct apfs_query *parent);
+extern void apfs_free_query(struct apfs_query *query);
+extern int apfs_btree_query(struct super_block *sb, struct apfs_query **query);
+extern int apfs_omap_lookup_block(struct super_block *sb, struct apfs_omap *omap, u64 id, u64 *block, bool write);
+extern int apfs_omap_lookup_newest_block(struct super_block *sb, struct apfs_omap *omap, u64 id, u64 *block, bool write);
+extern int apfs_create_omap_rec(struct super_block *sb, u64 oid, u64 bno);
+extern int apfs_delete_omap_rec(struct super_block *sb, u64 oid);
+extern int apfs_query_join_transaction(struct apfs_query *query);
+extern int __apfs_btree_insert(struct apfs_query *query, void *key, int key_len, void *val, int val_len);
+extern int apfs_btree_insert(struct apfs_query *query, void *key, int key_len,
+			     void *val, int val_len);
+extern int apfs_btree_remove(struct apfs_query *query);
+extern void apfs_btree_change_node_count(struct apfs_query *query, int change);
+extern int apfs_btree_replace(struct apfs_query *query, void *key, int key_len,
+			      void *val, int val_len);
+extern void apfs_query_direct_forward(struct apfs_query *query);
+
+/* compress.c */
+extern int apfs_compress_get_size(struct inode *inode, loff_t *size);
+
+/* dir.c */
+extern int apfs_inode_by_name(struct inode *dir, const struct qstr *child,
+			      u64 *ino);
+extern int apfs_mkany(struct inode *dir, struct dentry *dentry,
+		      umode_t mode, dev_t rdev, const char *symname);
+
+extern int apfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
+		      struct dentry *dentry, umode_t mode, dev_t rdev);
+extern int apfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+		      struct dentry *dentry, umode_t mode);
+extern int apfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
+		       struct dentry *old_dentry, struct inode *new_dir,
+		       struct dentry *new_dentry, unsigned int flags);
+extern int apfs_create(struct mnt_idmap *idmap, struct inode *dir,
+		       struct dentry *dentry, umode_t mode, bool excl);
+
+extern int apfs_link(struct dentry *old_dentry, struct inode *dir,
+		     struct dentry *dentry);
+extern int apfs_unlink(struct inode *dir, struct dentry *dentry);
+extern int apfs_rmdir(struct inode *dir, struct dentry *dentry);
+extern int apfs_delete_orphan_link(struct inode *inode);
+extern int APFS_DELETE_ORPHAN_LINK_MAXOPS(void);
+extern u64 apfs_any_orphan_ino(struct super_block *sb, u64 *ino_p);
+
+/* extents.c */
+extern int apfs_extent_from_query(struct apfs_query *query,
+				  struct apfs_file_extent *extent);
+extern int apfs_logic_to_phys_bno(struct apfs_dstream_info *dstream, sector_t dsblock, u64 *bno);
+extern int __apfs_get_block(struct apfs_dstream_info *dstream, sector_t iblock,
+			    struct buffer_head *bh_result, int create);
+extern int apfs_get_block(struct inode *inode, sector_t iblock,
+			  struct buffer_head *bh_result, int create);
+extern int apfs_flush_extent_cache(struct apfs_dstream_info *dstream);
+extern int apfs_dstream_get_new_bno(struct apfs_dstream_info *dstream, u64 dsblock, u64 *bno);
+extern int apfs_get_new_block(struct inode *inode, sector_t iblock,
+			      struct buffer_head *bh_result, int create);
+extern int APFS_GET_NEW_BLOCK_MAXOPS(void);
+extern int apfs_truncate(struct apfs_dstream_info *dstream, loff_t new_size);
+extern int apfs_inode_delete_front(struct inode *inode);
+extern loff_t apfs_remap_file_range(struct file *src_file, loff_t off, struct file *dst_file, loff_t destoff, loff_t len, unsigned int remap_flags);
+extern int apfs_clone_extents(struct apfs_dstream_info *dstream, u64 new_id);
+extern int apfs_nonsparse_dstream_read(struct apfs_dstream_info *dstream, void *buf, size_t count, u64 offset);
+extern void apfs_nonsparse_dstream_preread(struct apfs_dstream_info *dstream);
+
+/* file.c */
+extern int apfs_file_mmap(struct file *file, struct vm_area_struct *vma);
+extern int apfs_fsync(struct file *file, loff_t start, loff_t end, int datasync);
+
+/* inode.c */
+extern struct inode *apfs_iget(struct super_block *sb, u64 cnid);
+extern int apfs_update_inode(struct inode *inode, char *new_name);
+extern int APFS_UPDATE_INODE_MAXOPS(void);
+extern void apfs_orphan_cleanup_work(struct work_struct *work);
+extern void apfs_evict_inode(struct inode *inode);
+extern struct inode *apfs_new_inode(struct inode *dir, umode_t mode,
+				    dev_t rdev);
+extern int apfs_create_inode_rec(struct super_block *sb, struct inode *inode,
+				 struct dentry *dentry);
+extern int apfs_inode_create_exclusive_dstream(struct inode *inode);
+extern int APFS_CREATE_INODE_REC_MAXOPS(void);
+extern int __apfs_write_begin(struct file *file, struct address_space *mapping, loff_t pos, unsigned int len, unsigned int flags, struct page **pagep, void **fsdata);
+extern int __apfs_write_end(struct file *file, struct address_space *mapping, loff_t pos, unsigned int len, unsigned int copied, struct page *page, void *fsdata);
+extern int apfs_dstream_adj_refcnt(struct apfs_dstream_info *dstream, u32 delta);
+extern int apfs_setattr(struct mnt_idmap *idmap,
+			struct dentry *dentry, struct iattr *iattr);
+
+extern int apfs_update_time(struct inode *inode, int flags);
+long apfs_dir_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+long apfs_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+
+extern int apfs_getattr(struct mnt_idmap *idmap,
+		const struct path *path, struct kstat *stat, u32 request_mask,
+		unsigned int query_flags);
+
+extern int apfs_crypto_adj_refcnt(struct super_block *sb, u64 crypto_id, int delta);
+extern int APFS_CRYPTO_ADJ_REFCNT_MAXOPS(void);
+
+extern int apfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+extern int apfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry, struct fileattr *fa);
+
+/* key.c */
+extern int apfs_filename_cmp(struct super_block *sb, const char *name1, unsigned int len1, const char *name2, unsigned int len2);
+extern int apfs_keycmp(struct apfs_key *k1, struct apfs_key *k2);
+extern int apfs_read_cat_key(void *raw, int size, struct apfs_key *key, bool hashed);
+extern int apfs_read_fext_key(void *raw, int size, struct apfs_key *key);
+extern int apfs_read_free_queue_key(void *raw, int size, struct apfs_key *key);
+extern int apfs_read_omap_key(void *raw, int size, struct apfs_key *key);
+extern int apfs_read_extentref_key(void *raw, int size, struct apfs_key *key);
+extern int apfs_read_snap_meta_key(void *raw, int size, struct apfs_key *key);
+extern int apfs_read_omap_snap_key(void *raw, int size, struct apfs_key *key);
+
+/* message.c */
+extern __printf(5, 6) void apfs_msg(struct super_block *sb, const char *prefix, const char *func, int line, const char *fmt, ...);
+
+/* node.c */
+extern struct apfs_node *apfs_read_node(struct super_block *sb, u64 oid,
+					u32 storage, bool write);
+extern void apfs_update_node(struct apfs_node *node);
+extern int apfs_delete_node(struct apfs_node *node, int type);
+extern int apfs_node_query(struct super_block *sb, struct apfs_query *query);
+extern void apfs_node_query_first(struct apfs_query *query);
+extern int apfs_omap_map_from_query(struct apfs_query *query, struct apfs_omap_map *map);
+extern int apfs_node_split(struct apfs_query *query);
+extern int apfs_node_locate_key(struct apfs_node *node, int index, int *off);
+extern void apfs_node_free(struct apfs_node *node);
+extern void apfs_node_free_range(struct apfs_node *node, u16 off, u16 len);
+extern bool apfs_node_has_room(struct apfs_node *node, int length, bool replace);
+extern int apfs_node_replace(struct apfs_query *query, void *key, int key_len, void *val, int val_len);
+extern int apfs_node_insert(struct apfs_query *query, void *key, int key_len, void *val, int val_len);
+extern int apfs_create_single_rec_node(struct apfs_query *query, void *key, int key_len, void *val, int val_len);
+extern int apfs_make_empty_btree_root(struct super_block *sb, u32 subtype, u64 *oid);
+
+/* object.c */
+extern int apfs_obj_verify_csum(struct super_block *sb, struct buffer_head *bh);
+extern void apfs_obj_set_csum(struct super_block *sb, struct apfs_obj_phys *obj);
+extern int apfs_multiblock_verify_csum(char *object, u32 size);
+extern void apfs_multiblock_set_csum(char *object, u32 size);
+extern int apfs_create_cpm_block(struct super_block *sb, u64 bno, struct buffer_head **bh_p);
+extern int apfs_create_cpoint_map(struct super_block *sb, struct apfs_checkpoint_map_phys *cpm, struct apfs_obj_phys *obj, u64 bno, u32 size);
+extern struct apfs_ephemeral_object_info *apfs_ephemeral_object_lookup(struct super_block *sb, u64 oid);
+extern struct buffer_head *apfs_read_object_block(struct super_block *sb, u64 bno, bool write, bool preserve);
+extern u32 apfs_index_in_data_area(struct super_block *sb, u64 bno);
+extern u64 apfs_data_index_to_bno(struct super_block *sb, u32 index);
+
+/* snapshot.c */
+extern int apfs_ioc_take_snapshot(struct file *file, void __user *user_arg);
+extern int apfs_switch_to_snapshot(struct super_block *sb);
+
+/* spaceman.c */
+extern int apfs_read_spaceman(struct super_block *sb);
+extern int apfs_free_queue_insert_nocache(struct super_block *sb, u64 bno, u64 count);
+extern int apfs_free_queue_insert(struct super_block *sb, u64 bno, u64 count);
+extern int apfs_spaceman_allocate_block(struct super_block *sb, u64 *bno, bool backwards);
+extern int apfs_write_ip_bitmaps(struct super_block *sb);
+
+/* super.c */
+extern int apfs_map_volume_super_bno(struct super_block *sb, u64 bno, bool check);
+extern int apfs_map_volume_super(struct super_block *sb, bool write);
+extern void apfs_unmap_volume_super(struct super_block *sb);
+extern int apfs_read_omap(struct super_block *sb, bool write);
+extern int apfs_read_catalog(struct super_block *sb, bool write);
+extern int apfs_sync_fs(struct super_block *sb, int wait);
+
+/* transaction.c */
+extern int apfs_cpoint_data_free(struct super_block *sb, u64 bno);
+extern void apfs_transaction_init(struct apfs_nx_transaction *trans);
+extern int apfs_transaction_start(struct super_block *sb, struct apfs_max_ops maxops);
+extern int apfs_transaction_commit(struct super_block *sb);
+extern void apfs_inode_join_transaction(struct super_block *sb, struct inode *inode);
+extern int apfs_transaction_join(struct super_block *sb,
+				 struct buffer_head *bh);
+void apfs_transaction_abort(struct super_block *sb);
+extern int apfs_transaction_flush_all_inodes(struct super_block *sb);
+
+/* xattr.c */
+extern int ____apfs_xattr_get(struct inode *inode, const char *name, void *buffer,
+			      size_t size, bool only_whole);
+extern int __apfs_xattr_get(struct inode *inode, const char *name, void *buffer,
+			    size_t size);
+extern int apfs_delete_all_xattrs(struct inode *inode);
+extern int apfs_xattr_set(struct inode *inode, const char *name, const void *value,
+			  size_t size, int flags);
+extern int APFS_XATTR_SET_MAXOPS(void);
+extern ssize_t apfs_listxattr(struct dentry *dentry, char *buffer, size_t size);
+extern int apfs_xattr_get_compressed_data(struct inode *inode, const char *name, struct apfs_compressed_data *cdata);
+extern void apfs_release_compressed_data(struct apfs_compressed_data *cdata);
+extern int apfs_compressed_data_read(struct apfs_compressed_data *cdata, void *buf, size_t count, u64 offset);
+
+/* xfield.c */
+extern int apfs_find_xfield(u8 *xfields, int len, u8 xtype, char **xval);
+extern int apfs_init_xfields(u8 *buffer, int buflen);
+extern int apfs_insert_xfield(u8 *buffer, int buflen,
+			      const struct apfs_x_field *xkey,
+			      const void *xval);
+
+/*
+ * Inode and file operations
+ */
+
+/* compress.c */
+extern const struct address_space_operations apfs_compress_aops;
+extern const struct file_operations apfs_compress_file_operations;
+
+/* dir.c */
+extern const struct file_operations apfs_dir_operations;
+
+/* file.c */
+extern const struct file_operations apfs_file_operations;
+extern const struct inode_operations apfs_file_inode_operations;
+
+/* namei.c */
+extern const struct inode_operations apfs_dir_inode_operations;
+extern const struct inode_operations apfs_special_inode_operations;
+extern const struct dentry_operations apfs_dentry_operations;
+
+/* symlink.c */
+extern const struct inode_operations apfs_symlink_inode_operations;
+
+/* xattr.c */
+extern const struct xattr_handler *apfs_xattr_handlers[];
+
+/**
+ * apfs_assert_query_is_valid - Assert that all of a query's ancestors are set
+ * @query: the query to check
+ *
+ * A query may lose some of its ancestors during a node split, but nothing
+ * should be done to such a query until it gets refreshed.
+ */
+static inline void apfs_assert_query_is_valid(const struct apfs_query *query)
+{
+	ASSERT(apfs_node_is_root(apfs_query_root(query)));
+}
+
+/*
+ * TODO: the following are modified variants of buffer head functions that will
+ * work with the shared block device for the container. The correct approach
+ * here would be to avoid buffer heads and use bios, but for now this will do.
+ */
+
+static inline void
+apfs_map_bh(struct buffer_head *bh, struct super_block *sb, sector_t block)
+{
+	struct apfs_nxsb_info *nxi = NULL;
+	struct apfs_blkdev_info *info = NULL;
+
+	nxi = APFS_NXI(sb);
+	info = nxi->nx_blkdev_info;
+
+	/*
+	 * Block numbers above s_tier2_bno are for the tier 2 device of a
+	 * fusion drive. Don't bother returning an error code if a regular
+	 * drive gets corrupted and reports a tier 2 block number: just treat
+	 * it the same as any other out-of-range block.
+	 */
+	if (block >= nxi->nx_tier2_bno) {
+		if (nxi->nx_tier2_info) {
+			info = nxi->nx_tier2_info;
+			block -= nxi->nx_tier2_bno;
+		} else {
+			apfs_err(sb, "block number in tier 2 range (0x%llx)", (unsigned long long)block);
+		}
+	}
+
+	set_buffer_mapped(bh);
+	bh->b_bdev = info->blki_bdev;
+	bh->b_blocknr = block;
+	bh->b_size = sb->s_blocksize;
+}
+
+static inline struct buffer_head *
+apfs_sb_bread(struct super_block *sb, sector_t block)
+{
+	struct apfs_nxsb_info *nxi = NULL;
+	struct apfs_blkdev_info *info = NULL;
+
+	nxi = APFS_NXI(sb);
+	info = nxi->nx_blkdev_info;
+
+	if (block >= nxi->nx_tier2_bno) {
+		if (!nxi->nx_tier2_info) {
+			/* Not really a fusion drive, so it's corrupted */
+			apfs_err(sb, "block number in tier 2 range (0x%llx)", (unsigned long long)block);
+			return NULL;
+		}
+		info = nxi->nx_tier2_info;
+		block -= nxi->nx_tier2_bno;
+	}
+
+	return __bread_gfp(info->blki_bdev, block, sb->s_blocksize, __GFP_MOVABLE);
+}
+
+/* Like apfs_getblk(), but doesn't mark the buffer uptodate */
+static inline struct buffer_head *
+__apfs_getblk(struct super_block *sb, sector_t block)
+{
+	struct apfs_nxsb_info *nxi = NULL;
+	struct apfs_blkdev_info *info = NULL;
+
+	nxi = APFS_NXI(sb);
+	info = nxi->nx_blkdev_info;
+
+	if (block >= nxi->nx_tier2_bno) {
+		if (!nxi->nx_tier2_info) {
+			/* Not really a fusion drive, so it's corrupted */
+			apfs_err(sb, "block number in tier 2 range (0x%llx)", (unsigned long long)block);
+			return NULL;
+		}
+		info = nxi->nx_tier2_info;
+		block -= nxi->nx_tier2_bno;
+	}
+
+	return bdev_getblk(info->blki_bdev, block, sb->s_blocksize, __GFP_MOVABLE);
+}
+
+/* Use instead of apfs_sb_bread() for blocks that will just be overwritten */
+static inline struct buffer_head *
+apfs_getblk(struct super_block *sb, sector_t block)
+{
+	struct buffer_head *bh = NULL;
+
+	bh = __apfs_getblk(sb, block);
+	if (bh)
+		set_buffer_uptodate(bh);
+	return bh;
+}
+
+#endif	/* _APFS_H */
diff --git a/drivers/staging/apfs/btree.c b/drivers/staging/apfs/btree.c
new file mode 100644
index 0000000000000000000000000000000000000000..e0b4c29985e9011e946cb1f4eb5008d86700fa46
--- /dev/null
+++ b/drivers/staging/apfs/btree.c
@@ -0,0 +1,1174 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2018 Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
+ */
+
+#include <linux/buffer_head.h>
+#include <linux/slab.h>
+#include "apfs.h"
+
+struct apfs_node *apfs_query_root(const struct apfs_query *query)
+{
+	while (query->parent)
+		query = query->parent;
+	ASSERT(apfs_node_is_root(query->node));
+	return query->node;
+}
+
+static u64 apfs_catalog_base_oid(struct apfs_query *query)
+{
+	struct apfs_query *root_query = NULL;
+
+	root_query = query;
+	while (root_query->parent)
+		root_query = root_query->parent;
+
+	return root_query->node->object.oid;
+}
+
+/**
+ * apfs_child_from_query - Read the child id found by a successful nonleaf query
+ * @query:	the query that found the record
+ * @child:	Return parameter.  The child id found.
+ *
+ * Reads the child id in the nonleaf node record into @child and performs a
+ * basic sanity check as a protection against crafted filesystems.  Returns 0
+ * on success or -EFSCORRUPTED otherwise.
+ */
+static int apfs_child_from_query(struct apfs_query *query, u64 *child)
+{
+	struct super_block *sb = query->node->object.sb;
+	char *raw = query->node->object.data;
+
+	if (query->flags & APFS_QUERY_CAT && apfs_is_sealed(sb)) {
+		struct apfs_btn_index_node_val *index_val = NULL;
+
+		if (query->len != sizeof(*index_val)) {
+			apfs_err(sb, "bad sealed index value length (%d)", query->len);
+			return -EFSCORRUPTED;
+		}
+		index_val = (struct apfs_btn_index_node_val *)(raw + query->off);
+		*child = le64_to_cpu(index_val->binv_child_oid) + apfs_catalog_base_oid(query);
+	} else {
+		if (query->len != 8) { /* The value on a nonleaf node is the child id */
+			apfs_err(sb, "bad index value length (%d)", query->len);
+			return -EFSCORRUPTED;
+		}
+		*child = le64_to_cpup((__le64 *)(raw + query->off));
+	}
+	return 0;
+}
+
+/**
+ * apfs_omap_cache_lookup - Look for an oid in an omap's cache
+ * @omap:	the object map
+ * @oid:	object id to look up
+ * @bno:	on return, the block number for the oid
+ *
+ * Returns 0 on success, or -1 if this mapping is not cached.
+ */
+static int apfs_omap_cache_lookup(struct apfs_omap *omap, u64 oid, u64 *bno)
+{
+	struct apfs_omap_cache *cache = &omap->omap_cache;
+	struct apfs_omap_rec *record = NULL;
+	int slot;
+	int ret = -1;
+
+	if (cache->disabled)
+		return -1;
+
+	/* Uninitialized cache records use OID 0, so check this just in case */
+	if (!oid)
+		return -1;
+
+	slot = oid & APFS_OMAP_CACHE_SLOT_MASK;
+	record = &cache->recs[slot];
+
+	spin_lock(&cache->lock);
+	if (record->oid == oid) {
+		*bno = record->bno;
+		ret = 0;
+	}
+	spin_unlock(&cache->lock);
+
+	return ret;
+}
+
+/**
+ * apfs_omap_cache_save - Save a record in an omap's cache
+ * @omap:	the object map
+ * @oid:	object id of the record
+ * @bno:	block number for the oid
+ */
+static void apfs_omap_cache_save(struct apfs_omap *omap, u64 oid, u64 bno)
+{
+	struct apfs_omap_cache *cache = &omap->omap_cache;
+	struct apfs_omap_rec *record = NULL;
+	int slot;
+
+	if (cache->disabled)
+		return;
+
+	slot = oid & APFS_OMAP_CACHE_SLOT_MASK;
+	record = &cache->recs[slot];
+
+	spin_lock(&cache->lock);
+	record->oid = oid;
+	record->bno = bno;
+	spin_unlock(&cache->lock);
+}
+
+/**
+ * apfs_omap_cache_delete - Try to delete a record from an omap's cache
+ * @omap:	the object map
+ * @oid:	object id of the record
+ */
+static void apfs_omap_cache_delete(struct apfs_omap *omap, u64 oid)
+{
+	struct apfs_omap_cache *cache = &omap->omap_cache;
+	struct apfs_omap_rec *record = NULL;
+	int slot;
+
+	if (cache->disabled)
+		return;
+
+	slot = oid & APFS_OMAP_CACHE_SLOT_MASK;
+	record = &cache->recs[slot];
+
+	spin_lock(&cache->lock);
+	if (record->oid == oid) {
+		record->oid = 0;
+		record->bno = 0;
+	}
+	spin_unlock(&cache->lock);
+}
+
+/**
+ * apfs_mounted_xid - Returns the mounted xid for this superblock
+ * @sb:	superblock structure
+ *
+ * This function is needed instead of APFS_NXI(@sb)->nx_xid in situations where
+ * we might be working with a snapshot. Snapshots are read-only and should
+ * mostly ignore xids, so this only appears to matter for omap lookups.
+ */
+static inline u64 apfs_mounted_xid(struct super_block *sb)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+
+	return sbi->s_snap_xid ? sbi->s_snap_xid : nxi->nx_xid;
+}
+
+/**
+ * apfs_xid_in_snapshot - Check if an xid is part of a snapshot
+ * @omap:	the object map
+ * @xid:	the xid to check
+ */
+static inline bool apfs_xid_in_snapshot(struct apfs_omap *omap, u64 xid)
+{
+	return xid <= omap->omap_latest_snap;
+}
+
+/**
+ * apfs_omap_lookup_block_with_xid - Find bno of a virtual object from oid/xid
+ * @sb:		filesystem superblock
+ * @omap:	object map to be searched
+ * @id:		id of the node
+ * @xid:	transaction id
+ * @block:	on return, the found block number
+ * @write:	get write access to the object?
+ *
+ * Searches @omap for the most recent matching object with a transaction id
+ * below @xid. Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_omap_lookup_block_with_xid(struct super_block *sb, struct apfs_omap *omap, u64 id, u64 xid, u64 *block, bool write)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_query *query;
+	struct apfs_omap_map map = {0};
+	int ret = 0;
+
+	if (!write) {
+		if (!apfs_omap_cache_lookup(omap, id, block))
+			return 0;
+	}
+
+	query = apfs_alloc_query(omap->omap_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_omap_key(id, xid, &query->key);
+	query->flags |= APFS_QUERY_OMAP;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret) {
+		if (ret != -ENODATA)
+			apfs_err(sb, "query failed for oid 0x%llx, xid 0x%llx", id, xid);
+		goto fail;
+	}
+
+	ret = apfs_omap_map_from_query(query, &map);
+	if (ret) {
+		apfs_alert(sb, "bad object map leaf block: 0x%llx",
+			   query->node->object.block_nr);
+		goto fail;
+	}
+	*block = map.bno;
+
+	if (write) {
+		struct apfs_omap_key key;
+		struct apfs_omap_val val;
+		struct buffer_head *new_bh;
+		bool preserve;
+
+		preserve = apfs_xid_in_snapshot(omap, map.xid);
+
+		new_bh = apfs_read_object_block(sb, *block, write, preserve);
+		if (IS_ERR(new_bh)) {
+			apfs_err(sb, "CoW failed for oid 0x%llx, xid 0x%llx", id, xid);
+			ret = PTR_ERR(new_bh);
+			goto fail;
+		}
+
+		key.ok_oid = cpu_to_le64(id);
+		key.ok_xid = cpu_to_le64(nxi->nx_xid);
+		val.ov_flags = cpu_to_le32(map.flags);
+		val.ov_size = cpu_to_le32(sb->s_blocksize);
+		val.ov_paddr = cpu_to_le64(new_bh->b_blocknr);
+
+		if (preserve)
+			ret = apfs_btree_insert(query, &key, sizeof(key), &val, sizeof(val));
+		else
+			ret = apfs_btree_replace(query, &key, sizeof(key), &val, sizeof(val));
+		if (ret)
+			apfs_err(sb, "CoW omap update failed (oid 0x%llx, xid 0x%llx)", id, xid);
+
+		*block = new_bh->b_blocknr;
+		brelse(new_bh);
+	}
+
+	apfs_omap_cache_save(omap, id, *block);
+
+fail:
+	apfs_free_query(query);
+	return ret;
+}
+
+/**
+ * apfs_omap_lookup_block - Find the block number of a b-tree node from its id
+ * @sb:		filesystem superblock
+ * @omap:	object map to be searched
+ * @id:		id of the node
+ * @block:	on return, the found block number
+ * @write:	get write access to the object?
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+int apfs_omap_lookup_block(struct super_block *sb, struct apfs_omap *omap, u64 id, u64 *block, bool write)
+{
+	return apfs_omap_lookup_block_with_xid(sb, omap, id, apfs_mounted_xid(sb), block, write);
+}
+
+/**
+ * apfs_omap_lookup_newest_block - Find newest bno for a virtual object's oid
+ * @sb:		filesystem superblock
+ * @omap:	object map to be searched
+ * @id:		id of the object
+ * @block:	on return, the found block number
+ * @write:	get write access to the object?
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+int apfs_omap_lookup_newest_block(struct super_block *sb, struct apfs_omap *omap, u64 id, u64 *block, bool write)
+{
+	return apfs_omap_lookup_block_with_xid(sb, omap, id, -1, block, write);
+}
+
+/**
+ * apfs_create_omap_rec - Create a record in the volume's omap tree
+ * @sb:		filesystem superblock
+ * @oid:	object id
+ * @bno:	block number
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+int apfs_create_omap_rec(struct super_block *sb, u64 oid, u64 bno)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_omap *omap = sbi->s_omap;
+	struct apfs_query *query;
+	struct apfs_omap_key raw_key;
+	struct apfs_omap_val raw_val;
+	int ret;
+
+	query = apfs_alloc_query(omap->omap_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_omap_key(oid, nxi->nx_xid, &query->key);
+	query->flags |= APFS_QUERY_OMAP;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret && ret != -ENODATA) {
+		apfs_err(sb, "query failed for oid 0x%llx, bno 0x%llx", oid, bno);
+		goto fail;
+	}
+
+	raw_key.ok_oid = cpu_to_le64(oid);
+	raw_key.ok_xid = cpu_to_le64(nxi->nx_xid);
+	raw_val.ov_flags = 0;
+	raw_val.ov_size = cpu_to_le32(sb->s_blocksize);
+	raw_val.ov_paddr = cpu_to_le64(bno);
+
+	ret = apfs_btree_insert(query, &raw_key, sizeof(raw_key),
+				&raw_val, sizeof(raw_val));
+	if (ret) {
+		apfs_err(sb, "insertion failed for oid 0x%llx, bno 0x%llx", oid, bno);
+		goto fail;
+	}
+
+	apfs_omap_cache_save(omap, oid, bno);
+
+fail:
+	apfs_free_query(query);
+	return ret;
+}
+
+/**
+ * apfs_delete_omap_rec - Delete an existing record from the volume's omap tree
+ * @sb:		filesystem superblock
+ * @oid:	object id for the record
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+int apfs_delete_omap_rec(struct super_block *sb, u64 oid)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_omap *omap = sbi->s_omap;
+	struct apfs_query *query;
+	int ret;
+
+	query = apfs_alloc_query(omap->omap_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_omap_key(oid, nxi->nx_xid, &query->key);
+	query->flags |= APFS_QUERY_OMAP;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret == -ENODATA) {
+		apfs_err(sb, "nonexistent record (oid 0x%llx)", oid);
+		ret = -EFSCORRUPTED;
+		goto fail;
+	}
+	if (ret) {
+		apfs_err(sb, "query failed (oid 0x%llx)", oid);
+		goto fail;
+	}
+	ret = apfs_btree_remove(query);
+	if (ret) {
+		apfs_err(sb, "removal failed (oid 0x%llx)", oid);
+		goto fail;
+	}
+	apfs_omap_cache_delete(omap, oid);
+
+fail:
+	apfs_free_query(query);
+	return ret;
+}
+
+/**
+ * apfs_alloc_query - Allocates a query structure
+ * @node:	node to be searched
+ * @parent:	query for the parent node
+ *
+ * Callers other than apfs_btree_query() should set @parent to NULL, and @node
+ * to the root of the b-tree. They should also initialize most of the query
+ * fields themselves; when @parent is not NULL the query will inherit them.
+ *
+ * Returns the allocated query, or NULL in case of failure.
+ */
+struct apfs_query *apfs_alloc_query(struct apfs_node *node,
+				    struct apfs_query *parent)
+{
+	struct apfs_query *query;
+
+	query = kzalloc(sizeof(*query), GFP_KERNEL);
+	if (!query)
+		return NULL;
+
+	/* To be released by free_query. */
+	query->node = node;
+
+	if (parent) {
+		query->key = parent->key;
+		query->flags = parent->flags & ~(APFS_QUERY_DONE | APFS_QUERY_NEXT);
+		query->parent = parent;
+		query->depth = parent->depth + 1;
+	}
+
+	/*
+	 * We start the search with the last record and go backwards, but
+	 * some queries later use the PREV flag later to list them in order.
+	 */
+	if (query->flags & APFS_QUERY_PREV)
+		query->index = -1;
+	else
+		query->index = node->records;
+
+	return query;
+}
+
+/**
+ * apfs_free_query - Free a query structure
+ * @query: query to free
+ *
+ * Also frees the ancestor queries, if they are kept.
+ */
+void apfs_free_query(struct apfs_query *query)
+{
+	while (query) {
+		struct apfs_query *parent = query->parent;
+
+		/* The caller decides whether to free the root node */
+		if (query->depth != 0)
+			apfs_node_free(query->node);
+		kfree(query);
+		query = parent;
+	}
+}
+
+/**
+ * apfs_query_set_before_first - Set the query to point before the first record
+ * @sb:		superblock structure
+ * @query:	the query to set
+ *
+ * Queries set in this way are used to insert a record before the first one.
+ * Only the leaf gets set to the -1 entry; queries for other levels must be set
+ * to 0, since the first entry in each index node will need to be modified.
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+static int apfs_query_set_before_first(struct super_block *sb, struct apfs_query **query)
+{
+	struct apfs_node *node = NULL;
+	struct apfs_query *parent = NULL;
+	u64 child_id;
+	u32 storage = apfs_query_storage(*query);
+	int err;
+
+	while ((*query)->depth < 12) {
+		if (apfs_node_is_leaf((*query)->node)) {
+			(*query)->index = -1;
+			return 0;
+		}
+		apfs_node_query_first(*query);
+
+		err = apfs_child_from_query(*query, &child_id);
+		if (err) {
+			apfs_alert(sb, "bad index block: 0x%llx",
+				   (*query)->node->object.block_nr);
+			return err;
+		}
+
+		/* Now go a level deeper */
+		node = apfs_read_node(sb, child_id, storage, false /* write */);
+		if (IS_ERR(node)) {
+			apfs_err(sb, "failed to read child 0x%llx of node 0x%llx", child_id, (*query)->node->object.oid);
+			return PTR_ERR(node);
+		}
+
+		parent = *query;
+		*query = apfs_alloc_query(node, parent);
+		if (!*query) {
+			apfs_node_free(node);
+			*query = parent;
+			return -ENOMEM;
+		}
+		node = NULL;
+	}
+
+	apfs_err(sb, "btree is too high");
+	return -EFSCORRUPTED;
+}
+
+/**
+ * apfs_btree_query - Execute a query on a b-tree
+ * @sb:		filesystem superblock
+ * @query:	the query to execute
+ *
+ * Searches the b-tree starting at @query->index in @query->node, looking for
+ * the record corresponding to @query->key.
+ *
+ * Returns 0 in case of success and sets the @query->len, @query->off and
+ * @query->index fields to the results of the query. @query->node will now
+ * point to the leaf node holding the record.
+ *
+ * In case of failure returns an appropriate error code.
+ */
+int apfs_btree_query(struct super_block *sb, struct apfs_query **query)
+{
+	struct apfs_node *node;
+	struct apfs_query *parent;
+	u64 child_id;
+	u32 storage = apfs_query_storage(*query);
+	int err;
+
+next_node:
+	if ((*query)->depth >= 12) {
+		/*
+		 * We need a maximum depth for the tree so we can't loop
+		 * forever if the filesystem is damaged. 12 should be more
+		 * than enough to map every block.
+		 */
+		apfs_err(sb, "btree is too high");
+		err = -EFSCORRUPTED;
+		goto fail;
+	}
+
+	err = apfs_node_query(sb, *query);
+	if (err == -ENODATA && !(*query)->parent && (*query)->index == -1) {
+		/*
+		 * We may be trying to insert a record before all others: don't
+		 * let the query give up at the root node.
+		 */
+		err = apfs_query_set_before_first(sb, query);
+		if (err) {
+			apfs_err(sb, "failed to set before the first record");
+			goto fail;
+		}
+		err = -ENODATA;
+		goto fail;
+	} else if (err == -EAGAIN) {
+		if (!(*query)->parent) {
+			/* We are at the root of the tree */
+			err = -ENODATA;
+			goto fail;
+		}
+
+		/* Move back up one level and continue the query */
+		parent = (*query)->parent;
+		(*query)->parent = NULL; /* Don't free the parent */
+		apfs_free_query(*query);
+		*query = parent;
+		goto next_node;
+	} else if (err) {
+		goto fail;
+	}
+	if (apfs_node_is_leaf((*query)->node)) /* All done */
+		return 0;
+
+	err = apfs_child_from_query(*query, &child_id);
+	if (err) {
+		apfs_alert(sb, "bad index block: 0x%llx",
+			   (*query)->node->object.block_nr);
+		goto fail;
+	}
+
+	/* Now go a level deeper and search the child */
+	node = apfs_read_node(sb, child_id, storage, false /* write */);
+	if (IS_ERR(node)) {
+		apfs_err(sb, "failed to read node 0x%llx", child_id);
+		err = PTR_ERR(node);
+		goto fail;
+	}
+
+	if (node->object.oid != child_id)
+		apfs_debug(sb, "corrupt b-tree");
+
+	/*
+	 * Remember the parent node and index in case the search needs
+	 * to be continued later.
+	 */
+	parent = *query;
+	*query = apfs_alloc_query(node, parent);
+	if (!*query) {
+		apfs_node_free(node);
+		*query = parent;
+		err = -ENOMEM;
+		goto fail;
+	}
+	node = NULL;
+	goto next_node;
+
+fail:
+	/* Don't leave stale record info here or some callers will use it */
+	(*query)->key_len = (*query)->len = 0;
+	return err;
+}
+
+static int __apfs_btree_replace(struct apfs_query *query, void *key, int key_len, void *val, int val_len);
+
+/**
+ * apfs_query_join_transaction - Add the found node to the current transaction
+ * @query: query that found the node
+ */
+int apfs_query_join_transaction(struct apfs_query *query)
+{
+	struct apfs_node *node = query->node;
+	struct super_block *sb = node->object.sb;
+	u64 oid = node->object.oid;
+	u32 storage = apfs_query_storage(query);
+	struct apfs_obj_phys *raw = NULL;
+
+	/*
+	 * Ephemeral objects are checkpoint data, and all of their xids get
+	 * updated on commit. There is no real need to do it here as well, but
+	 * it's better for consistency with the other object types.
+	 */
+	if (storage == APFS_OBJ_EPHEMERAL) {
+		ASSERT(node->object.ephemeral);
+		raw = (void *)node->object.data;
+		raw->o_xid = cpu_to_le64(APFS_NXI(sb)->nx_xid);
+		return 0;
+	}
+
+	if (buffer_trans(node->object.o_bh)) /* Already in the transaction */
+		return 0;
+	/* Root nodes should join the transaction before the query is created */
+	ASSERT(!apfs_node_is_root(node));
+
+	node = apfs_read_node(sb, oid, storage, true /* write */);
+	if (IS_ERR(node)) {
+		apfs_err(sb, "Cow failed for node 0x%llx", oid);
+		return PTR_ERR(node);
+	}
+	apfs_node_free(query->node);
+	query->node = node;
+
+	if (storage == APFS_OBJ_PHYSICAL && query->parent) {
+		__le64 bno = cpu_to_le64(node->object.block_nr);
+
+		/* The parent node needs to report the new location */
+		return __apfs_btree_replace(query->parent, NULL /* key */, 0 /* key_len */, &bno, sizeof(bno));
+	}
+	return 0;
+}
+
+/**
+ * apfs_btree_change_rec_count - Update the b-tree info before a record change
+ * @query:	query used to insert/remove/replace the leaf record
+ * @change:	change in the record count
+ * @key_len:	length of the new leaf record key (0 if removed or unchanged)
+ * @val_len:	length of the new leaf record value (0 if removed or unchanged)
+ *
+ * Don't call this function if @query->parent was reset to NULL, or if the same
+ * is true of any of its ancestor queries.
+ */
+static void apfs_btree_change_rec_count(struct apfs_query *query, int change,
+					int key_len, int val_len)
+{
+	struct super_block *sb;
+	struct apfs_node *root;
+	struct apfs_btree_node_phys *root_raw;
+	struct apfs_btree_info *info;
+
+	if (change == -1)
+		ASSERT(!key_len && !val_len);
+	ASSERT(apfs_node_is_leaf(query->node));
+
+	root = apfs_query_root(query);
+	ASSERT(apfs_node_is_root(root));
+
+	sb = root->object.sb;
+	root_raw = (void *)root->object.data;
+	info = (void *)root_raw + sb->s_blocksize - sizeof(*info);
+
+	apfs_assert_in_transaction(sb, &root_raw->btn_o);
+	if (key_len > le32_to_cpu(info->bt_longest_key))
+		info->bt_longest_key = cpu_to_le32(key_len);
+	if (val_len > le32_to_cpu(info->bt_longest_val))
+		info->bt_longest_val = cpu_to_le32(val_len);
+	le64_add_cpu(&info->bt_key_count, change);
+}
+
+/**
+ * apfs_btree_change_node_count - Change the node count for a b-tree
+ * @query:	query used to remove/create the node
+ * @change:	change in the node count
+ *
+ * Also changes the node count in the volume superblock.  Don't call this
+ * function if @query->parent was reset to NULL, or if the same is true of
+ * any of its ancestor queries.
+ */
+void apfs_btree_change_node_count(struct apfs_query *query, int change)
+{
+	struct super_block *sb;
+	struct apfs_node *root;
+	struct apfs_btree_node_phys *root_raw;
+	struct apfs_btree_info *info;
+
+	root = apfs_query_root(query);
+	ASSERT(apfs_node_is_root(root));
+
+	sb = root->object.sb;
+	root_raw = (void *)root->object.data;
+	info = (void *)root_raw + sb->s_blocksize - sizeof(*info);
+
+	apfs_assert_in_transaction(sb, &root_raw->btn_o);
+	le64_add_cpu(&info->bt_node_count, change);
+}
+
+/**
+ * apfs_query_refresh - Recreate a catalog query invalidated by node splits
+ * @old_query:	query chain to refresh
+ * @root:	root node of the query chain
+ * @nodata:	is the query expected to find nothing?
+ *
+ * On success, @old_query is left pointing to the same leaf record, but with
+ * valid ancestor queries as well. Returns a negative error code in case of
+ * failure, or 0 on success.
+ */
+static int apfs_query_refresh(struct apfs_query *old_query, struct apfs_node *root, bool nodata)
+{
+	struct super_block *sb = NULL;
+	struct apfs_query *new_query = NULL;
+	int err = 0;
+
+	sb = root->object.sb;
+
+	if (!apfs_node_is_leaf(old_query->node)) {
+		apfs_alert(sb, "attempting refresh of non-leaf query");
+		return -EFSCORRUPTED;
+	}
+	if (apfs_node_is_root(old_query->node)) {
+		apfs_alert(sb, "attempting refresh of root query");
+		return -EFSCORRUPTED;
+	}
+
+	new_query = apfs_alloc_query(root, NULL /* parent */);
+	if (!new_query)
+		return -ENOMEM;
+	new_query->key = old_query->key;
+	new_query->flags = old_query->flags & ~(APFS_QUERY_DONE | APFS_QUERY_NEXT);
+
+	err = apfs_btree_query(sb, &new_query);
+	if (!nodata && err == -ENODATA) {
+		apfs_err(sb, "record should exist");
+		err = -EFSCORRUPTED;
+		goto fail;
+	}
+	if (err && err != -ENODATA) {
+		apfs_err(sb, "failed to rerun");
+		goto fail;
+	}
+	err = 0;
+
+	/* Replace the parent of the original query with the new valid one */
+	apfs_free_query(old_query->parent);
+	old_query->parent = new_query->parent;
+	new_query->parent = NULL;
+
+	/*
+	 * The records may have moved around so update this too. TODO: rework
+	 * the query struct so this stuff is not needed.
+	 */
+	ASSERT(old_query->node->object.oid == new_query->node->object.oid);
+	old_query->index = new_query->index;
+	old_query->key_off = new_query->key_off;
+	old_query->key_len = new_query->key_len;
+	old_query->off = new_query->off;
+	old_query->len = new_query->len;
+	old_query->depth = new_query->depth;
+
+fail:
+	apfs_free_query(new_query);
+	return err;
+}
+
+/**
+ * __apfs_btree_insert - Insert a new record into a b-tree (at any level)
+ * @query:	query run to search for the record
+ * @key:	on-disk record key
+ * @key_len:	length of @key
+ * @val:	on-disk record value (NULL for ghost records)
+ * @val_len:	length of @val (0 for ghost records)
+ *
+ * The new record is placed right after the one found by @query.  On success,
+ * returns 0 and sets @query to the new record; returns a negative error code
+ * in case of failure, which may be -EAGAIN if a split happened and the caller
+ * must retry.
+ */
+int __apfs_btree_insert(struct apfs_query *query, void *key, int key_len, void *val, int val_len)
+{
+	struct apfs_node *node = query->node;
+	struct super_block *sb = node->object.sb;
+	struct apfs_btree_node_phys *node_raw;
+	int needed_room;
+	int err;
+
+	apfs_assert_query_is_valid(query);
+
+	err = apfs_query_join_transaction(query);
+	if (err) {
+		apfs_err(sb, "query join failed");
+		return err;
+	}
+
+	node = query->node;
+	node_raw = (void *)node->object.data;
+	apfs_assert_in_transaction(node->object.sb, &node_raw->btn_o);
+
+	needed_room = key_len + val_len;
+	if (!apfs_node_has_room(node, needed_room, false /* replace */)) {
+		if (node->records == 1) {
+			/* The new record just won't fit in the node */
+			err = apfs_create_single_rec_node(query, key, key_len, val, val_len);
+			if (err && err != -EAGAIN)
+				apfs_err(sb, "failed to create single-record node");
+			return err;
+		}
+		err = apfs_node_split(query);
+		if (err && err != -EAGAIN) {
+			apfs_err(sb, "node split failed");
+			return err;
+		}
+		return -EAGAIN;
+	}
+
+	apfs_assert_query_is_valid(query);
+
+	if (query->parent && query->index == -1) {
+		/* We are about to insert a record before all others */
+		err = __apfs_btree_replace(query->parent, key, key_len, NULL /* val */, 0 /* val_len */);
+		if (err) {
+			if (err != -EAGAIN)
+				apfs_err(sb, "parent update failed");
+			return err;
+		}
+	}
+
+	apfs_assert_query_is_valid(query);
+
+	err = apfs_node_insert(query, key, key_len, val, val_len);
+	if (err) {
+		apfs_err(sb, "node record insertion failed");
+		return err;
+	}
+	return 0;
+}
+
+/**
+ * apfs_btree_insert - Insert a new record into a b-tree leaf
+ * @query:	query run to search for the record
+ * @key:	on-disk record key
+ * @key_len:	length of @key
+ * @val:	on-disk record value (NULL for ghost records)
+ * @val_len:	length of @val (0 for ghost records)
+ *
+ * The new record is placed right after the one found by @query.  On success,
+ * returns 0 and sets @query to the new record; returns a negative error code
+ * in case of failure.
+ */
+int apfs_btree_insert(struct apfs_query *query, void *key, int key_len, void *val, int val_len)
+{
+	struct super_block *sb = NULL;
+	struct apfs_node *root = NULL, *leaf = NULL;
+	int err;
+
+	root = apfs_query_root(query);
+	ASSERT(apfs_node_is_root(root));
+	leaf = query->node;
+	ASSERT(apfs_node_is_leaf(leaf));
+	sb = root->object.sb;
+
+	while (true) {
+		err = __apfs_btree_insert(query, key, key_len, val, val_len);
+		if (err != -EAGAIN) {
+			if (err)
+				return err;
+			break;
+		}
+		err = apfs_query_refresh(query, root, true /* nodata */);
+		if (err) {
+			apfs_err(sb, "query refresh failed");
+			return err;
+		}
+	}
+
+	apfs_assert_query_is_valid(query);
+	apfs_btree_change_rec_count(query, 1 /* change */, key_len, val_len);
+	return 0;
+}
+
+/**
+ * __apfs_btree_remove - Remove a record from a b-tree (at any level)
+ * @query:	exact query that found the record
+ *
+ * Returns 0 on success, or a negative error code in case of failure, which may
+ * be -EAGAIN if a split happened and the caller must retry.
+ */
+static int __apfs_btree_remove(struct apfs_query *query)
+{
+	struct apfs_node *node = query->node;
+	struct super_block *sb = node->object.sb;
+	struct apfs_btree_node_phys *node_raw;
+	int later_entries = node->records - query->index - 1;
+	int err;
+
+	apfs_assert_query_is_valid(query);
+
+	err = apfs_query_join_transaction(query);
+	if (err) {
+		apfs_err(sb, "query join failed");
+		return err;
+	}
+
+	node = query->node;
+	node_raw = (void *)query->node->object.data;
+	apfs_assert_in_transaction(node->object.sb, &node_raw->btn_o);
+
+	if (query->parent && node->records == 1) {
+		/* Just get rid of the node */
+		err = __apfs_btree_remove(query->parent);
+		if (err == -EAGAIN)
+			return -EAGAIN;
+		if (err) {
+			apfs_err(sb, "parent index removal failed");
+			return err;
+		}
+		apfs_btree_change_node_count(query, -1 /* change */);
+		err = apfs_delete_node(node, query->flags & APFS_QUERY_TREE_MASK);
+		if (err) {
+			apfs_err(sb, "node deletion failed");
+			return err;
+		}
+		return 0;
+	}
+
+	apfs_assert_query_is_valid(query);
+
+	/* The first key in a node must match the parent record's */
+	if (query->parent && query->index == 0) {
+		int first_key_len, first_key_off;
+		void *key;
+
+		first_key_len = apfs_node_locate_key(node, 1, &first_key_off);
+		if (!first_key_len)
+			return -EFSCORRUPTED;
+		key = (void *)node_raw + first_key_off;
+
+		err = __apfs_btree_replace(query->parent, key, first_key_len, NULL /* val */, 0 /* val_len */);
+		if (err == -EAGAIN)
+			return -EAGAIN;
+		if (err) {
+			apfs_err(sb, "parent update failed");
+			return err;
+		}
+	}
+
+	apfs_assert_query_is_valid(query);
+
+	/* Remove the entry from the table of contents */
+	if (apfs_node_has_fixed_kv_size(node)) {
+		struct apfs_kvoff *toc_entry;
+
+		toc_entry = (struct apfs_kvoff *)node_raw->btn_data +
+								query->index;
+		memmove(toc_entry, toc_entry + 1,
+			later_entries * sizeof(*toc_entry));
+	} else {
+		struct apfs_kvloc *toc_entry;
+
+		toc_entry = (struct apfs_kvloc *)node_raw->btn_data +
+								query->index;
+		memmove(toc_entry, toc_entry + 1,
+			later_entries * sizeof(*toc_entry));
+	}
+
+	apfs_node_free_range(node, query->key_off, query->key_len);
+	apfs_node_free_range(node, query->off, query->len);
+
+	--node->records;
+	if (node->records == 0) {
+		/* All descendants are gone, root is the whole tree */
+		node_raw->btn_level = 0;
+		node->flags |= APFS_BTNODE_LEAF;
+	}
+	apfs_update_node(node);
+
+	--query->index;
+	return 0;
+}
+
+/**
+ * apfs_btree_remove - Remove a record from a b-tree leaf
+ * @query:	exact query that found the record
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+int apfs_btree_remove(struct apfs_query *query)
+{
+	struct super_block *sb = NULL;
+	struct apfs_node *root = NULL, *leaf = NULL;
+	int err;
+
+	root = apfs_query_root(query);
+	ASSERT(apfs_node_is_root(root));
+	leaf = query->node;
+	ASSERT(apfs_node_is_leaf(leaf));
+	sb = root->object.sb;
+
+	while (true) {
+		err = __apfs_btree_remove(query);
+		if (err != -EAGAIN) {
+			if (err)
+				return err;
+			break;
+		}
+		err = apfs_query_refresh(query, root, false /* nodata */);
+		if (err) {
+			apfs_err(sb, "query refresh failed");
+			return err;
+		}
+	}
+
+	apfs_assert_query_is_valid(query);
+	apfs_btree_change_rec_count(query, -1 /* change */, 0 /* key_len */, 0 /* val_len */);
+	return 0;
+}
+
+/**
+ * __apfs_btree_replace - Replace a record in a b-tree (at any level)
+ * @query:	exact query that found the record
+ * @key:	new on-disk record key (NULL if unchanged)
+ * @key_len:	length of @key
+ * @val:	new on-disk record value (NULL if unchanged)
+ * @val_len:	length of @val
+ *
+ * It's important that the order of the records is not changed by the new @key.
+ * This function is not needed to replace an old value with a new one of the
+ * same length: it can just be overwritten in place.
+ *
+ * Returns 0 on success, and @query is left pointing to the same record; returns
+ * a negative error code in case of failure, which may be -EAGAIN if a split
+ * happened and the caller must retry.
+ */
+static int __apfs_btree_replace(struct apfs_query *query, void *key, int key_len, void *val, int val_len)
+{
+	struct apfs_node *node = query->node;
+	struct super_block *sb = node->object.sb;
+	struct apfs_btree_node_phys *node_raw;
+	int needed_room;
+	int err;
+
+	ASSERT(key || val);
+	apfs_assert_query_is_valid(query);
+
+	err = apfs_query_join_transaction(query);
+	if (err) {
+		apfs_err(sb, "query join failed");
+		return err;
+	}
+
+	node = query->node;
+	node_raw = (void *)node->object.data;
+	apfs_assert_in_transaction(sb, &node_raw->btn_o);
+
+	needed_room = key_len + val_len;
+	/* We can reuse the space of the replaced key/value */
+	if (key)
+		needed_room -= query->key_len;
+	if (val)
+		needed_room -= query->len;
+
+	if (!apfs_node_has_room(node, needed_room, true /* replace */)) {
+		if (node->records == 1) {
+			apfs_alert(sb, "no room in empty node?");
+			return -EFSCORRUPTED;
+		}
+		err = apfs_node_split(query);
+		if (err && err != -EAGAIN) {
+			apfs_err(sb, "node split failed");
+			return err;
+		}
+		return -EAGAIN;
+	}
+
+	apfs_assert_query_is_valid(query);
+
+	/* The first key in a node must match the parent record's */
+	if (key && query->parent && query->index == 0) {
+		err = __apfs_btree_replace(query->parent, key, key_len, NULL /* val */, 0 /* val_len */);
+		if (err) {
+			if (err != -EAGAIN)
+				apfs_err(sb, "parent update failed");
+			return err;
+		}
+	}
+
+	apfs_assert_query_is_valid(query);
+
+	err = apfs_node_replace(query, key, key_len, val, val_len);
+	if (err) {
+		apfs_err(sb, "node record replacement failed");
+		return err;
+	}
+	return 0;
+}
+
+/**
+ * apfs_btree_replace - Replace a record in a b-tree leaf
+ * @query:	exact query that found the record
+ * @key:	new on-disk record key (NULL if unchanged)
+ * @key_len:	length of @key
+ * @val:	new on-disk record value (NULL if unchanged)
+ * @val_len:	length of @val
+ *
+ * It's important that the order of the records is not changed by the new @key.
+ * This function is not needed to replace an old value with a new one of the
+ * same length: it can just be overwritten in place.
+ *
+ * Returns 0 on success, and @query is left pointing to the same record; returns
+ * a negative error code in case of failure.
+ */
+int apfs_btree_replace(struct apfs_query *query, void *key, int key_len, void *val, int val_len)
+{
+	struct super_block *sb = NULL;
+	struct apfs_node *root = NULL, *leaf = NULL;
+	int err;
+
+	root = apfs_query_root(query);
+	ASSERT(apfs_node_is_root(root));
+	leaf = query->node;
+	ASSERT(apfs_node_is_leaf(leaf));
+	sb = root->object.sb;
+
+	while (true) {
+		err = __apfs_btree_replace(query, key, key_len, val, val_len);
+		if (err != -EAGAIN) {
+			if (err)
+				return err;
+			break;
+		}
+		err = apfs_query_refresh(query, root, false /* nodata */);
+		if (err) {
+			apfs_err(sb, "query refresh failed");
+			return err;
+		}
+	}
+
+	apfs_assert_query_is_valid(query);
+	apfs_btree_change_rec_count(query, 0 /* change */, key_len, val_len);
+	return 0;
+}
+
+/**
+ * apfs_query_direct_forward - Set a query to start listing records forwards
+ * @query: a successfully executed query
+ *
+ * Multiple queries list records backwards, but queries marked with this
+ * function after execution will go in the opposite direction.
+ */
+void apfs_query_direct_forward(struct apfs_query *query)
+{
+	if (query->flags & APFS_QUERY_PREV)
+		return;
+
+	apfs_assert_query_is_valid(query);
+	ASSERT(apfs_node_is_leaf(query->node));
+
+	while (query) {
+		query->flags |= APFS_QUERY_PREV;
+		query = query->parent;
+	}
+}
diff --git a/drivers/staging/apfs/compress.c b/drivers/staging/apfs/compress.c
new file mode 100644
index 0000000000000000000000000000000000000000..32291b390343970effcb84cd32e98828f14f3583
--- /dev/null
+++ b/drivers/staging/apfs/compress.c
@@ -0,0 +1,442 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 Corellium LLC
+ * Copyright (C) 2025 Ethan Carter Edwards <ethan@ethancedwards.com>
+ */
+
+#include <linux/slab.h>
+#include <linux/zlib.h>
+#include <linux/mutex.h>
+
+#include "apfs.h"
+#include "libzbitmap.h"
+#include "lzfse/lzfse.h"
+#include "lzfse/lzvn_decode_base.h"
+
+struct apfs_compress_file_data {
+	struct apfs_compress_hdr hdr;
+	u8 *buf;
+	ssize_t bufblk;
+	size_t bufsize;
+	struct mutex mtx;
+	struct super_block *sb;
+	struct apfs_compressed_data cdata;
+};
+
+static inline int apfs_compress_is_rsrc(u32 algo)
+{
+	return (algo & 1) == 0;
+}
+
+static inline bool apfs_compress_is_supported(u32 algo)
+{
+	switch (algo) {
+	case APFS_COMPRESS_ZLIB_RSRC:
+	case APFS_COMPRESS_ZLIB_ATTR:
+	case APFS_COMPRESS_LZVN_RSRC:
+	case APFS_COMPRESS_LZVN_ATTR:
+	case APFS_COMPRESS_PLAIN_RSRC:
+	case APFS_COMPRESS_PLAIN_ATTR:
+	case APFS_COMPRESS_LZFSE_RSRC:
+	case APFS_COMPRESS_LZFSE_ATTR:
+	case APFS_COMPRESS_LZBITMAP_RSRC:
+	case APFS_COMPRESS_LZBITMAP_ATTR:
+		return true;
+	default:
+		/* Once will usually be enough, don't flood the console */
+		pr_err_once("APFS: unsupported compression algorithm (%u)\n", algo);
+		return false;
+	}
+}
+
+static int apfs_compress_file_open(struct inode *inode, struct file *filp)
+{
+	struct super_block *sb = inode->i_sb;
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_compress_file_data *fd;
+	ssize_t res;
+	bool is_rsrc;
+
+	/*
+	 * The official implementation seems to transparently decompress files
+	 * when you write to them. Doing that atomically inside the kernel is
+	 * probably a chore, so for now I'll just leave it to the user to make
+	 * an uncompressed copy themselves and replace the original. I might
+	 * fix this in the future, but only if people complain (TODO).
+	 */
+	if (filp->f_mode & FMODE_WRITE) {
+		apfs_warn(sb, "writes to compressed files are not supported");
+		apfs_warn(sb, "you can work with a copy of the file instead");
+		return -EOPNOTSUPP;
+	}
+
+	if (!(filp->f_flags & O_LARGEFILE) && i_size_read(inode) > MAX_NON_LFS)
+		return -EOVERFLOW;
+
+	fd = kzalloc(sizeof(*fd), GFP_KERNEL);
+	if (!fd)
+		return -ENOMEM;
+	mutex_init(&fd->mtx);
+	fd->sb = sb;
+
+	down_read(&nxi->nx_big_sem);
+
+	res = ____apfs_xattr_get(inode, APFS_XATTR_NAME_COMPRESSED, &fd->hdr, sizeof(fd->hdr), 0);
+	if (res != sizeof(fd->hdr)) {
+		apfs_err(sb, "decmpfs header read failed");
+		goto fail;
+	}
+
+	if (!apfs_compress_is_supported(le32_to_cpu(fd->hdr.algo))) {
+		res = -EOPNOTSUPP;
+		goto fail;
+	}
+
+	fd->buf = kvmalloc(APFS_COMPRESS_BLOCK, GFP_KERNEL);
+	if (!fd->buf) {
+		res = -ENOMEM;
+		goto fail;
+	}
+	fd->bufblk = -1;
+
+	is_rsrc = apfs_compress_is_rsrc(le32_to_cpu(fd->hdr.algo));
+	res = apfs_xattr_get_compressed_data(inode, is_rsrc ? APFS_XATTR_NAME_RSRC_FORK : APFS_XATTR_NAME_COMPRESSED, &fd->cdata);
+	if (res) {
+		apfs_err(sb, "failed to get compressed data");
+		goto fail;
+	}
+
+	up_read(&nxi->nx_big_sem);
+
+	filp->private_data = fd;
+	return 0;
+
+fail:
+	apfs_release_compressed_data(&fd->cdata);
+	if (fd->buf)
+		kvfree(fd->buf);
+	up_read(&nxi->nx_big_sem);
+	kfree(fd);
+	if (res > 0)
+		res = -EINVAL;
+	return res;
+}
+
+static int apfs_compress_file_read_block(struct apfs_compress_file_data *fd, loff_t block)
+{
+	struct super_block *sb = fd->sb;
+	struct apfs_compressed_data *comp_data = &fd->cdata;
+	u8 *cdata = NULL;
+	u8 *tmp = fd->buf;
+	u32 doffs = 0, coffs;
+	size_t csize, bsize;
+	int res = 0;
+
+	if (apfs_compress_is_rsrc(le32_to_cpu(fd->hdr.algo)) &&
+	   le32_to_cpu(fd->hdr.algo) != APFS_COMPRESS_LZBITMAP_RSRC &&
+	   le32_to_cpu(fd->hdr.algo) != APFS_COMPRESS_LZVN_RSRC &&
+	   le32_to_cpu(fd->hdr.algo) != APFS_COMPRESS_LZFSE_RSRC) {
+		struct apfs_compress_rsrc_hdr hdr = {0};
+		struct apfs_compress_rsrc_data cd = {0};
+		struct apfs_compress_rsrc_block blk = {0};
+		u32 blk_off;
+
+		res = apfs_compressed_data_read(comp_data, &hdr, sizeof(hdr), 0 /* offset */);
+		if (res) {
+			apfs_err(sb, "failed to read resource header");
+			return res;
+		}
+
+		doffs = be32_to_cpu(hdr.data_offs);
+		res = apfs_compressed_data_read(comp_data, &cd, sizeof(cd), doffs);
+		if (res) {
+			apfs_err(sb, "failed to read resource data header");
+			return res;
+		}
+		if (block >= le32_to_cpu(cd.num))
+			return 0;
+
+		blk_off = doffs + sizeof(cd) + sizeof(blk) * block;
+		res = apfs_compressed_data_read(comp_data, &blk, sizeof(blk), blk_off);
+		if (res) {
+			apfs_err(sb, "failed to read resource block metadata");
+			return res;
+		}
+
+		bsize = le64_to_cpu(fd->hdr.size) - block * APFS_COMPRESS_BLOCK;
+		if (bsize > APFS_COMPRESS_BLOCK)
+			bsize = APFS_COMPRESS_BLOCK;
+
+		csize = le32_to_cpu(blk.size);
+		coffs = le32_to_cpu(blk.offs) + 4;
+	} else if (apfs_compress_is_rsrc(le32_to_cpu(fd->hdr.algo))) {
+		__le32 blks[2];
+		u32 blk_off;
+
+		blk_off = doffs + sizeof(__le32) * block;
+		res = apfs_compressed_data_read(comp_data, blks, sizeof(blks), blk_off);
+		if (res) {
+			apfs_err(sb, "failed to read resource block metadata");
+			return res;
+		}
+
+		bsize = le64_to_cpu(fd->hdr.size) - block * APFS_COMPRESS_BLOCK;
+		if (bsize > APFS_COMPRESS_BLOCK)
+			bsize = APFS_COMPRESS_BLOCK;
+
+		coffs = le32_to_cpu(blks[0]);
+		csize = le32_to_cpu(blks[1]) - coffs;
+	} else {
+		/*
+		 * I think attr compression is only for single-block files, in
+		 * fact none of these files ever seem to decompress to more than
+		 * 2048 bytes.
+		 */
+		bsize = le64_to_cpu(fd->hdr.size);
+		if (block != 0 || bsize > APFS_COMPRESS_BLOCK) {
+			apfs_err(sb, "file too big for inline compression");
+			return -EFSCORRUPTED;
+		}
+
+		/* The first few bytes are the decmpfs header */
+		coffs = sizeof(struct apfs_compress_hdr);
+		csize = comp_data->size - sizeof(struct apfs_compress_hdr);
+	}
+
+	cdata = kvmalloc(csize, GFP_KERNEL);
+	if (!cdata)
+		return -ENOMEM;
+	res = apfs_compressed_data_read(comp_data, cdata, csize, doffs + coffs);
+	if (res) {
+		apfs_err(sb, "failed to read compressed block");
+		goto fail;
+	}
+
+	switch (le32_to_cpu(fd->hdr.algo)) {
+	case APFS_COMPRESS_ZLIB_RSRC:
+	case APFS_COMPRESS_ZLIB_ATTR:
+		if (cdata[0] == 0x78 && csize >= 2) {
+			res = zlib_inflate_blob(tmp, bsize, cdata + 2, csize - 2);
+			if (res <= 0) {
+				apfs_err(sb, "zlib decompression failed");
+				goto fail;
+			}
+			bsize = res;
+			res = 0;
+		} else if ((cdata[0] & 0x0F) == 0x0F) {
+			memcpy(tmp, &cdata[1], csize - 1);
+			bsize = csize - 1;
+		} else {
+			apfs_err(sb, "zlib decompression failed");
+			res = -EINVAL;
+			goto fail;
+		}
+		break;
+	case APFS_COMPRESS_LZVN_RSRC:
+	case APFS_COMPRESS_LZVN_ATTR:
+		if (cdata[0] == 0x06) {
+			memcpy(tmp, &cdata[1], csize - 1);
+			bsize = csize - 1;
+		} else {
+			lzvn_decoder_state dstate = {0};
+
+			dstate.src = cdata;
+			dstate.src_end = dstate.src + csize;
+			dstate.dst = dstate.dst_begin = tmp;
+			dstate.dst_end = dstate.dst + bsize;
+			lzvn_decode(&dstate);
+			bsize = dstate.dst - tmp;
+		}
+		break;
+	case APFS_COMPRESS_LZBITMAP_RSRC:
+	case APFS_COMPRESS_LZBITMAP_ATTR:
+		if (cdata[0] == 0x5a) {
+			res = zbm_decompress(tmp, bsize, cdata, csize, &bsize);
+			if (res < 0) {
+				apfs_err(sb, "lzbitmap decompression failed");
+				goto fail;
+			}
+			res = 0;
+		} else if ((cdata[0] & 0x0F) == 0x0F) {
+			memcpy(tmp, &cdata[1], csize - 1);
+			bsize = csize - 1;
+		} else {
+			apfs_err(sb, "lzbitmap decompression failed");
+			res = -EINVAL;
+			goto fail;
+		}
+		break;
+	case APFS_COMPRESS_LZFSE_RSRC:
+	case APFS_COMPRESS_LZFSE_ATTR:
+		if (cdata[0] == 0x62 && csize >= 2) {
+			res = lzfse_decode_buffer(tmp, bsize, cdata, csize, NULL);
+			if (res == 0) {
+				apfs_err(sb, "lzfse decompression failed");
+				/* Could be ENOMEM too... */
+				res = -EINVAL;
+				goto fail;
+			}
+			bsize = res;
+			res = 0;
+		} else {
+			/* cdata[0] == 0xff, apparently */
+			memcpy(tmp, &cdata[1], csize - 1);
+			bsize = csize - 1;
+		}
+		break;
+	case APFS_COMPRESS_PLAIN_RSRC:
+	case APFS_COMPRESS_PLAIN_ATTR:
+		memcpy(tmp, &cdata[1], csize - 1);
+		bsize = csize - 1;
+		break;
+	default:
+		res = -EINVAL;
+		goto fail;
+	}
+	fd->bufblk = block;
+	fd->bufsize = bsize;
+fail:
+	kvfree(cdata);
+	return res;
+}
+
+static int apfs_compress_file_release(struct inode *inode, struct file *filp)
+{
+	struct apfs_compress_file_data *fd = filp->private_data;
+
+	apfs_release_compressed_data(&fd->cdata);
+	if (fd->buf)
+		kvfree(fd->buf);
+	kfree(fd);
+	return 0;
+}
+
+static ssize_t apfs_compress_file_read_from_block(struct apfs_compress_file_data *fd, char *buf, size_t size, loff_t off)
+{
+	struct super_block *sb = fd->sb;
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_compressed_data cdata = fd->cdata;
+	loff_t block;
+	size_t bsize;
+	ssize_t res;
+
+	/*
+	 * Request reads of all blocks before actually working with any of them.
+	 * The compressed data is typically small enough that this is effective.
+	 * It would be much better to make an inode for the xattr dstream and
+	 * work with readahead as usual, but I'm not confident I can get that
+	 * right (TODO).
+	 */
+	if (cdata.has_dstream && off == 0) {
+		down_read(&nxi->nx_big_sem);
+		apfs_nonsparse_dstream_preread(cdata.dstream);
+		up_read(&nxi->nx_big_sem);
+	}
+
+	if (off >= le64_to_cpu(fd->hdr.size))
+		return 0;
+	if (size > le64_to_cpu(fd->hdr.size) - off)
+		size = le64_to_cpu(fd->hdr.size) - off;
+
+	block = off / APFS_COMPRESS_BLOCK;
+	off -= block * APFS_COMPRESS_BLOCK;
+	if (block != fd->bufblk) {
+		down_read(&nxi->nx_big_sem);
+		res = apfs_compress_file_read_block(fd, block);
+		up_read(&nxi->nx_big_sem);
+		if (res) {
+			apfs_err(sb, "failed to read block into buffer");
+			return res;
+		}
+	}
+	bsize = fd->bufsize;
+
+	if (bsize < off)
+		return 0;
+	bsize -= off;
+	if (size > bsize)
+		size = bsize;
+	memcpy(buf, fd->buf + off, size);
+	return size;
+}
+
+static ssize_t apfs_compress_file_read_page(struct file *filp, char *buf, loff_t off)
+{
+	struct apfs_compress_file_data *fd = filp->private_data;
+	loff_t step;
+	ssize_t block, res;
+	size_t size = PAGE_SIZE;
+
+	step = 0;
+	while (step < size) {
+		block = APFS_COMPRESS_BLOCK - ((off + step) & (APFS_COMPRESS_BLOCK - 1));
+		if (block > size - step)
+			block = size - step;
+		mutex_lock(&fd->mtx);
+		res = apfs_compress_file_read_from_block(fd, buf + step, block, off + step);
+		mutex_unlock(&fd->mtx);
+		if (res < block) {
+			if (res < 0 && !step)
+				return res;
+			step += res > 0 ? res : 0;
+			break;
+		}
+		step += block;
+	}
+	return step;
+}
+
+static int apfs_compress_read_folio(struct file *filp, struct folio *folio)
+{
+	struct page *page = &folio->page;
+	char *addr = NULL;
+	ssize_t ret;
+	loff_t off;
+
+	/* Mostly copied from ext4_read_inline_page() */
+	off = page->index << PAGE_SHIFT;
+	addr = kmap(page);
+	ret = apfs_compress_file_read_page(filp, addr, off);
+	flush_dcache_page(page);
+	kunmap(page);
+	if (ret >= 0) {
+		zero_user_segment(page, ret, PAGE_SIZE);
+		SetPageUptodate(page);
+		ret = 0;
+	}
+
+	unlock_page(page);
+	return ret;
+}
+
+const struct address_space_operations apfs_compress_aops = {
+	.read_folio	= apfs_compress_read_folio,
+};
+
+/* TODO: these operations are all happening without proper locks */
+const struct file_operations apfs_compress_file_operations = {
+	.open		= apfs_compress_file_open,
+	.llseek		= generic_file_llseek,
+	.read_iter	= generic_file_read_iter,
+	.release	= apfs_compress_file_release,
+	.mmap		= apfs_file_mmap,
+};
+
+int apfs_compress_get_size(struct inode *inode, loff_t *size)
+{
+	struct apfs_compress_hdr hdr;
+	int res = ____apfs_xattr_get(inode, APFS_XATTR_NAME_COMPRESSED, &hdr, sizeof(hdr), 0);
+
+	if (res < 0)
+		return res;
+	if (res != sizeof(hdr)) {
+		apfs_err(inode->i_sb, "decmpfs header read failed");
+		return 1;
+	}
+
+	if (!apfs_compress_is_supported(le32_to_cpu(hdr.algo)))
+		return 1;
+
+	*size = le64_to_cpu(hdr.size);
+	return 0;
+}
diff --git a/drivers/staging/apfs/dir.c b/drivers/staging/apfs/dir.c
new file mode 100644
index 0000000000000000000000000000000000000000..688564f7b49c4529dd83733de678e9848e94bc90
--- /dev/null
+++ b/drivers/staging/apfs/dir.c
@@ -0,0 +1,1440 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2018 Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
+ * Copyright (C) 2025 Ethan Carter Edwards <ethan@ethancedwards.com>
+ */
+
+#include <linux/slab.h>
+#include <linux/buffer_head.h>
+#include "apfs.h"
+
+/**
+ * apfs_drec_from_query - Read the directory record found by a successful query
+ * @query:	the query that found the record
+ * @drec:	Return parameter.  The directory record found.
+ * @hashed:	is this record hashed?
+ *
+ * Reads the directory record into @drec and performs some basic sanity checks
+ * as a protection against crafted filesystems.  Returns 0 on success or
+ * -EFSCORRUPTED otherwise.
+ *
+ * The caller must not free @query while @drec is in use, because @drec->name
+ * points to data on disk.
+ */
+static int apfs_drec_from_query(struct apfs_query *query, struct apfs_drec *drec, bool hashed)
+{
+	struct super_block *sb = query->node->object.sb;
+	char *raw = query->node->object.data;
+	struct apfs_drec_hashed_key *de_hkey = NULL;
+	struct apfs_drec_key *de_ukey = NULL;
+	struct apfs_drec_val *de;
+	int namelen, xlen;
+	char *xval = NULL, *name;
+
+	namelen = query->key_len - (hashed ? sizeof(*de_hkey) : sizeof(*de_ukey));
+	if (namelen < 1) {
+		apfs_err(sb, "key is too small (%d)", query->key_len);
+		return -EFSCORRUPTED;
+	}
+	if (query->len < sizeof(*de)) {
+		apfs_err(sb, "value is too small (%d)", query->len);
+		return -EFSCORRUPTED;
+	}
+
+	de = (struct apfs_drec_val *)(raw + query->off);
+	if (hashed) {
+		de_hkey = (struct apfs_drec_hashed_key *)(raw + query->key_off);
+		if (namelen != (le32_to_cpu(de_hkey->name_len_and_hash) & APFS_DREC_LEN_MASK)) {
+			apfs_err(sb, "inconsistent name length");
+			return -EFSCORRUPTED;
+		}
+		name = de_hkey->name;
+	} else {
+		de_ukey = (struct apfs_drec_key *)(raw + query->key_off);
+		if (namelen != le16_to_cpu(de_ukey->name_len)) {
+			apfs_err(sb, "inconsistent name length");
+			return -EFSCORRUPTED;
+		}
+		name = de_ukey->name;
+	}
+
+	/* Filename must be NULL-terminated */
+	if (name[namelen - 1] != 0) {
+		apfs_err(sb, "null termination missing");
+		return -EFSCORRUPTED;
+	}
+
+	/* The dentry may have at most one xfield: the sibling id */
+	drec->sibling_id = 0;
+	xlen = apfs_find_xfield(de->xfields, query->len - sizeof(*de),
+				APFS_DREC_EXT_TYPE_SIBLING_ID, &xval);
+	if (xlen >= sizeof(__le64)) {
+		__le64 *sib_id = (__le64 *)xval;
+
+		drec->sibling_id = le64_to_cpup(sib_id);
+	}
+
+	drec->name = name;
+	drec->name_len = namelen - 1; /* Don't count the NULL termination */
+	drec->ino = le64_to_cpu(de->file_id);
+
+	drec->type = le16_to_cpu(de->flags) & APFS_DREC_TYPE_MASK;
+	if (drec->type != DT_FIFO && drec->type & 1) /* Invalid file type */
+		drec->type = DT_UNKNOWN;
+	return 0;
+}
+
+/**
+ * apfs_dentry_lookup - Lookup a dentry record in the catalog b-tree
+ * @dir:	parent directory
+ * @child:	filename
+ * @drec:	on return, the directory record found
+ *
+ * Runs a catalog query for @name in the @dir directory.  On success, sets
+ * @drec and returns a pointer to the query structure.  On failure, returns
+ * an appropriate error pointer.
+ */
+static struct apfs_query *apfs_dentry_lookup(struct inode *dir,
+					     const struct qstr *child,
+					     struct apfs_drec *drec)
+{
+	struct super_block *sb = dir->i_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_query *query;
+	u64 cnid = apfs_ino(dir);
+	bool hashed = apfs_is_normalization_insensitive(sb);
+	int err;
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query)
+		return ERR_PTR(-ENOMEM);
+	apfs_init_drec_key(sb, cnid, child->name, child->len, &query->key);
+
+	/*
+	 * Distinct filenames in the same directory may (rarely) share the same
+	 * hash. The query code cannot handle that because their order in the
+	 * b-tree would	depend on their unnormalized original names. Just get
+	 * all the candidates and check them one by one.
+	 *
+	 * This is very wasteful for normalization-sensitive filesystems: there
+	 * are no hashes so we just check every single file in the directory for
+	 * no reason. This would be easy to avoid but does it matter? (TODO)
+	 */
+	query->flags |= APFS_QUERY_CAT | APFS_QUERY_ANY_NAME | APFS_QUERY_EXACT;
+	do {
+		err = apfs_btree_query(sb, &query);
+		if (err)
+			goto fail;
+		err = apfs_drec_from_query(query, drec, hashed);
+		if (err)
+			goto fail;
+	} while (unlikely(apfs_filename_cmp(sb, child->name, child->len, drec->name, drec->name_len)));
+
+	/*
+	 * We may need to refresh the query later, but the refresh code doesn't
+	 * know how to deal with hash collisions. Instead set the key to the
+	 * unnormalized name and pretend that this was never a multiple query
+	 * in the first place.
+	 */
+	query->key.name = drec->name;
+	query->flags &= ~(APFS_QUERY_MULTIPLE | APFS_QUERY_DONE | APFS_QUERY_NEXT);
+	return query;
+
+fail:
+	if (err != -ENODATA)
+		apfs_err(sb, "query failed in dir 0x%llx", cnid);
+	apfs_free_query(query);
+	return ERR_PTR(err);
+}
+
+/**
+ * apfs_inode_by_name - Find the cnid for a given filename
+ * @dir:	parent directory
+ * @child:	filename
+ * @ino:	on return, the inode number found
+ *
+ * Returns 0 and the inode number (which is the cnid of the file
+ * record); otherwise, return the appropriate error code.
+ */
+int apfs_inode_by_name(struct inode *dir, const struct qstr *child, u64 *ino)
+{
+	struct super_block *sb = dir->i_sb;
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_query *query;
+	struct apfs_drec drec;
+	int err = 0;
+
+	down_read(&nxi->nx_big_sem);
+	query = apfs_dentry_lookup(dir, child, &drec);
+	if (IS_ERR(query)) {
+		err = PTR_ERR(query);
+		goto out;
+	}
+	*ino = drec.ino;
+	apfs_free_query(query);
+out:
+	up_read(&nxi->nx_big_sem);
+	return err;
+}
+
+static int apfs_readdir(struct file *file, struct dir_context *ctx)
+{
+	struct inode *inode = file_inode(file);
+	struct super_block *sb = inode->i_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_query *query;
+	u64 cnid = apfs_ino(inode);
+	loff_t pos;
+	bool hashed = apfs_is_normalization_insensitive(sb);
+	int err = 0;
+
+	down_read(&nxi->nx_big_sem);
+
+	/* Inode numbers might overflow here; follow btrfs in ignoring that */
+	if (!dir_emit_dots(file, ctx))
+		goto out;
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/* We want all the children for the cnid, regardless of the name */
+	apfs_init_drec_key(sb, cnid, NULL /* name */, 0 /* name_len */, &query->key);
+	query->flags = APFS_QUERY_CAT | APFS_QUERY_MULTIPLE | APFS_QUERY_EXACT;
+
+	pos = ctx->pos - 2;
+	while (1) {
+		struct apfs_drec drec;
+		/*
+		 * We query for the matching records, one by one. After we
+		 * pass ctx->pos we begin to emit them.
+		 *
+		 * TODO: Faster approach for large directories?
+		 */
+
+		err = apfs_btree_query(sb, &query);
+		if (err == -ENODATA) { /* Got all the records */
+			err = 0;
+			break;
+		}
+		if (err)
+			break;
+
+		err = apfs_drec_from_query(query, &drec, hashed);
+		if (err) {
+			apfs_alert(sb, "bad dentry record in directory 0x%llx",
+				   cnid);
+			break;
+		}
+
+		err = 0;
+		if (pos <= 0) {
+			if (!dir_emit(ctx, drec.name, drec.name_len,
+				      drec.ino, drec.type))
+				break;
+			++ctx->pos;
+		}
+		pos--;
+	}
+	apfs_free_query(query);
+
+out:
+	up_read(&nxi->nx_big_sem);
+	return err;
+}
+
+const struct file_operations apfs_dir_operations = {
+	.llseek		= generic_file_llseek,
+	.read		= generic_read_dir,
+	.iterate_shared	= apfs_readdir,
+	.fsync		= apfs_fsync,
+	.unlocked_ioctl	= apfs_dir_ioctl,
+};
+
+/**
+ * apfs_build_dentry_unhashed_key - Allocate and initialize the key for an unhashed dentry record
+ * @qname:	filename
+ * @parent_id:	inode number for the parent of the dentry
+ * @key_p:	on return, a pointer to the new on-disk key structure
+ *
+ * Returns the length of the key, or a negative error code in case of failure.
+ */
+static int apfs_build_dentry_unhashed_key(struct qstr *qname, u64 parent_id,
+					  struct apfs_drec_key **key_p)
+{
+	struct apfs_drec_key *key;
+	u16 namelen = qname->len + 1; /* We count the null-termination */
+	int key_len;
+
+	key_len = sizeof(*key) + namelen;
+	key = kmalloc(key_len, GFP_KERNEL);
+	if (!key)
+		return -ENOMEM;
+
+	apfs_key_set_hdr(APFS_TYPE_DIR_REC, parent_id, key);
+	key->name_len = cpu_to_le16(namelen);
+	strscpy(key->name, qname->name, namelen);
+
+	*key_p = key;
+	return key_len;
+}
+
+/**
+ * apfs_build_dentry_hashed_key - Allocate and initialize the key for a hashed dentry record
+ * @qname:	filename
+ * @hash:	filename hash
+ * @parent_id:	inode number for the parent of the dentry
+ * @key_p:	on return, a pointer to the new on-disk key structure
+ *
+ * Returns the length of the key, or a negative error code in case of failure.
+ */
+static int apfs_build_dentry_hashed_key(struct qstr *qname, u64 hash, u64 parent_id,
+					struct apfs_drec_hashed_key **key_p)
+{
+	struct apfs_drec_hashed_key *key;
+	u16 namelen = qname->len + 1; /* We count the null-termination */
+	int key_len;
+
+	key_len = sizeof(*key) + namelen;
+	key = kmalloc(key_len, GFP_KERNEL);
+	if (!key)
+		return -ENOMEM;
+
+	apfs_key_set_hdr(APFS_TYPE_DIR_REC, parent_id, key);
+	key->name_len_and_hash = cpu_to_le32(namelen | hash);
+	strscpy(key->name, qname->name, namelen);
+
+	*key_p = key;
+	return key_len;
+}
+
+/**
+ * apfs_build_dentry_val - Allocate and initialize the value for a dentry record
+ * @inode:	vfs inode for the dentry
+ * @sibling_id:	sibling id for this hardlink (0 for none)
+ * @val_p:	on return, a pointer to the new on-disk value structure
+ *
+ * Returns the length of the value, or a negative error code in case of failure.
+ */
+static int apfs_build_dentry_val(struct inode *inode, u64 sibling_id,
+				 struct apfs_drec_val **val_p)
+{
+	struct apfs_drec_val *val;
+	struct apfs_x_field xkey;
+	int total_xlen = 0, val_len;
+	__le64 raw_sibling_id = cpu_to_le64(sibling_id);
+	struct timespec64 now = current_time(inode);
+
+	/* The dentry record may have one xfield: the sibling id */
+	if (sibling_id)
+		total_xlen += sizeof(struct apfs_xf_blob) +
+			      sizeof(xkey) + sizeof(raw_sibling_id);
+
+	val_len = sizeof(*val) + total_xlen;
+	val = kmalloc(val_len, GFP_KERNEL);
+	if (!val)
+		return -ENOMEM;
+	*val_p = val;
+
+	val->file_id = cpu_to_le64(apfs_ino(inode));
+	val->date_added = cpu_to_le64(timespec64_to_ns(&now));
+	val->flags = cpu_to_le16((inode->i_mode >> 12) & 15); /* File type */
+
+	if (!sibling_id)
+		return val_len;
+
+	/* The buffer was just allocated: none of these functions should fail */
+	apfs_init_xfields(val->xfields, val_len - sizeof(*val));
+	xkey.x_type = APFS_DREC_EXT_TYPE_SIBLING_ID;
+	xkey.x_flags = 0; /* TODO: proper flags here? */
+	xkey.x_size = cpu_to_le16(sizeof(raw_sibling_id));
+	apfs_insert_xfield(val->xfields, total_xlen, &xkey, &raw_sibling_id);
+	return val_len;
+}
+
+/**
+ * apfs_create_dentry_rec - Create a dentry record in the catalog b-tree
+ * @inode:	vfs inode for the dentry
+ * @qname:	filename
+ * @parent_id:	inode number for the parent of the dentry
+ * @sibling_id:	sibling id for this hardlink (0 for none)
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_create_dentry_rec(struct inode *inode, struct qstr *qname,
+				  u64 parent_id, u64 sibling_id)
+{
+	struct super_block *sb = inode->i_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_query *query;
+	void *raw_key = NULL;
+	struct apfs_drec_val *raw_val = NULL;
+	int key_len, val_len;
+	bool hashed = apfs_is_normalization_insensitive(sb);
+	int ret;
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_drec_key(sb, parent_id, qname->name, qname->len, &query->key);
+	query->flags |= APFS_QUERY_CAT;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret && ret != -ENODATA) {
+		apfs_err(sb, "query failed in dir 0x%llx (hash 0x%llx)", parent_id, query->key.number);
+		goto fail;
+	}
+
+	if (hashed)
+		key_len = apfs_build_dentry_hashed_key(qname, query->key.number, parent_id,
+						       (struct apfs_drec_hashed_key **)&raw_key);
+	else
+		key_len = apfs_build_dentry_unhashed_key(qname, parent_id,
+							 (struct apfs_drec_key **)&raw_key);
+	if (key_len < 0) {
+		ret = key_len;
+		goto fail;
+	}
+
+	val_len = apfs_build_dentry_val(inode, sibling_id, &raw_val);
+	if (val_len < 0) {
+		ret = val_len;
+		goto fail;
+	}
+	/* TODO: deal with hash collisions */
+	ret = apfs_btree_insert(query, raw_key, key_len, raw_val, val_len);
+	if (ret)
+		apfs_err(sb, "insertion failed in dir 0x%llx (hash 0x%llx)", parent_id, query->key.number);
+
+fail:
+	kfree(raw_val);
+	kfree(raw_key);
+	apfs_free_query(query);
+	return ret;
+}
+#define APFS_CREATE_DENTRY_REC_MAXOPS	1
+
+/**
+ * apfs_build_sibling_val - Allocate and initialize a sibling link's value
+ * @dentry:	in-memory dentry for this hardlink
+ * @val_p:	on return, a pointer to the new on-disk value structure
+ *
+ * Returns the length of the value, or a negative error code in case of failure.
+ */
+static int apfs_build_sibling_val(struct dentry *dentry,
+				  struct apfs_sibling_val **val_p)
+{
+	struct apfs_sibling_val *val;
+	struct qstr *qname = &dentry->d_name;
+	u16 namelen = qname->len + 1; /* We count the null-termination */
+	struct inode *parent = d_inode(dentry->d_parent);
+	int val_len;
+
+	val_len = sizeof(*val) + namelen;
+	val = kmalloc(val_len, GFP_KERNEL);
+	if (!val)
+		return -ENOMEM;
+
+	val->parent_id = cpu_to_le64(apfs_ino(parent));
+	val->name_len = cpu_to_le16(namelen);
+	strscpy(val->name, qname->name, namelen);
+
+	*val_p = val;
+	return val_len;
+}
+
+/**
+ * apfs_create_sibling_link_rec - Create a sibling link record for a dentry
+ * @dentry:	the in-memory dentry
+ * @inode:	vfs inode for the dentry
+ * @sibling_id:	sibling id for this hardlink
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_create_sibling_link_rec(struct dentry *dentry,
+					struct inode *inode, u64 sibling_id)
+{
+	struct super_block *sb = dentry->d_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_query *query = NULL;
+	struct apfs_sibling_link_key raw_key;
+	struct apfs_sibling_val *raw_val;
+	int val_len;
+	int ret;
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_sibling_link_key(apfs_ino(inode), sibling_id, &query->key);
+	query->flags |= APFS_QUERY_CAT;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret && ret != -ENODATA) {
+		apfs_err(sb, "query failed for ino 0x%llx, sibling 0x%llx", apfs_ino(inode), sibling_id);
+		goto fail;
+	}
+
+	apfs_key_set_hdr(APFS_TYPE_SIBLING_LINK, apfs_ino(inode), &raw_key);
+	raw_key.sibling_id = cpu_to_le64(sibling_id);
+	val_len = apfs_build_sibling_val(dentry, &raw_val);
+	if (val_len < 0)
+		goto fail;
+
+	ret = apfs_btree_insert(query, &raw_key, sizeof(raw_key), raw_val, val_len);
+	if (ret)
+		apfs_err(sb, "insertion failed for ino 0x%llx, sibling 0x%llx", apfs_ino(inode), sibling_id);
+	kfree(raw_val);
+
+fail:
+	apfs_free_query(query);
+	return ret;
+}
+#define APFS_CREATE_SIBLING_LINK_REC_MAXOPS	1
+
+/**
+ * apfs_create_sibling_map_rec - Create a sibling map record for a dentry
+ * @dentry:	the in-memory dentry
+ * @inode:	vfs inode for the dentry
+ * @sibling_id:	sibling id for this hardlink
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_create_sibling_map_rec(struct dentry *dentry,
+				       struct inode *inode, u64 sibling_id)
+{
+	struct super_block *sb = dentry->d_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_query *query = NULL;
+	struct apfs_sibling_map_key raw_key;
+	struct apfs_sibling_map_val raw_val;
+	int ret;
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_sibling_map_key(sibling_id, &query->key);
+	query->flags |= APFS_QUERY_CAT;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret && ret != -ENODATA) {
+		apfs_err(sb, "query failed for sibling 0x%llx", sibling_id);
+		goto fail;
+	}
+
+	apfs_key_set_hdr(APFS_TYPE_SIBLING_MAP, sibling_id, &raw_key);
+	raw_val.file_id = cpu_to_le64(apfs_ino(inode));
+
+	ret = apfs_btree_insert(query, &raw_key, sizeof(raw_key), &raw_val, sizeof(raw_val));
+	if (ret)
+		apfs_err(sb, "insertion failed for sibling 0x%llx", sibling_id);
+
+fail:
+	apfs_free_query(query);
+	return ret;
+}
+#define APFS_CREATE_SIBLING_MAP_REC_MAXOPS	1
+
+/**
+ * apfs_create_sibling_recs - Create sibling link and map records for a dentry
+ * @dentry:	the in-memory dentry
+ * @inode:	vfs inode for the dentry
+ * @sibling_id:	on return, the sibling id for this hardlink
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_create_sibling_recs(struct dentry *dentry,
+				    struct inode *inode, u64 *sibling_id)
+{
+	struct super_block *sb = dentry->d_sb;
+	struct apfs_superblock *vsb_raw = APFS_SB(sb)->s_vsb_raw;
+	u64 cnid;
+	int ret;
+
+	/* Sibling ids come from the same pool as the inode numbers */
+	apfs_assert_in_transaction(sb, &vsb_raw->apfs_o);
+	cnid = le64_to_cpu(vsb_raw->apfs_next_obj_id);
+	le64_add_cpu(&vsb_raw->apfs_next_obj_id, 1);
+
+	ret = apfs_create_sibling_link_rec(dentry, inode, cnid);
+	if (ret)
+		return ret;
+	ret = apfs_create_sibling_map_rec(dentry, inode, cnid);
+	if (ret)
+		return ret;
+
+	*sibling_id = cnid;
+	return 0;
+}
+#define APFS_CREATE_SIBLING_RECS_MAXOPS	(APFS_CREATE_SIBLING_LINK_REC_MAXOPS + \
+					 APFS_CREATE_SIBLING_MAP_REC_MAXOPS)
+
+/**
+ * apfs_create_dentry - Create all records for a new dentry
+ * @dentry:	the in-memory dentry
+ * @inode:	vfs inode for the dentry
+ *
+ * Creates the dentry record itself, as well as the sibling records if needed;
+ * also updates the child count for the parent inode.  Returns 0 on success or
+ * a negative error code in case of failure.
+ */
+static int apfs_create_dentry(struct dentry *dentry, struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+	struct inode *parent = d_inode(dentry->d_parent);
+	u64 sibling_id = 0;
+	int err;
+
+	if (inode->i_nlink > 1) {
+		/* This is optional for a single link, so don't waste space */
+		err = apfs_create_sibling_recs(dentry, inode, &sibling_id);
+		if (err) {
+			apfs_err(sb, "failed to create sibling recs for ino 0x%llx", apfs_ino(inode));
+			return err;
+		}
+	}
+
+	err = apfs_create_dentry_rec(inode, &dentry->d_name, apfs_ino(parent), sibling_id);
+	if (err) {
+		apfs_err(sb, "failed to create drec for ino 0x%llx", apfs_ino(inode));
+		return err;
+	}
+
+	/* Now update the parent inode */
+	inode_set_mtime_to_ts(parent, inode_set_ctime_current(parent));
+	++APFS_I(parent)->i_nchildren;
+	apfs_inode_join_transaction(parent->i_sb, parent);
+	return 0;
+}
+#define APFS_CREATE_DENTRY_MAXOPS	(APFS_CREATE_SIBLING_RECS_MAXOPS + \
+					 APFS_CREATE_DENTRY_REC_MAXOPS + \
+					 APFS_UPDATE_INODE_MAXOPS())
+
+/**
+ * apfs_undo_create_dentry - Clean up apfs_create_dentry()
+ * @dentry: the in-memory dentry
+ */
+static void apfs_undo_create_dentry(struct dentry *dentry)
+{
+	struct inode *parent = d_inode(dentry->d_parent);
+
+	--APFS_I(parent)->i_nchildren;
+}
+
+int apfs_mkany(struct inode *dir, struct dentry *dentry, umode_t mode,
+	       dev_t rdev, const char *symname)
+{
+	struct super_block *sb = dir->i_sb;
+	struct inode *inode;
+	struct apfs_max_ops maxops;
+	int err;
+
+	maxops.cat = APFS_CREATE_INODE_REC_MAXOPS() + APFS_CREATE_DENTRY_MAXOPS;
+	if (symname)
+		maxops.cat += APFS_XATTR_SET_MAXOPS();
+	maxops.blks = 0;
+
+	err = apfs_transaction_start(sb, maxops);
+	if (err)
+		return err;
+
+	inode = apfs_new_inode(dir, mode, rdev);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		goto out_abort;
+	}
+
+	err = apfs_create_inode_rec(sb, inode, dentry);
+	if (err) {
+		apfs_err(sb, "failed to create inode rec for ino 0x%llx", apfs_ino(inode));
+		goto out_discard_inode;
+	}
+
+	err = apfs_create_dentry(dentry, inode);
+	if (err) {
+		apfs_err(sb, "failed to create dentry recs for ino 0x%llx", apfs_ino(inode));
+		goto out_discard_inode;
+	}
+
+	if (symname) {
+		err = apfs_xattr_set(inode, APFS_XATTR_NAME_SYMLINK, symname,
+				     strlen(symname) + 1, 0 /* flags */);
+		if (err == -ERANGE) {
+			err = -ENAMETOOLONG;
+			goto out_undo_create;
+		}
+		if (err) {
+			apfs_err(sb, "failed to set symlink xattr for ino 0x%llx", apfs_ino(inode));
+			goto out_undo_create;
+		}
+	}
+
+	err = apfs_transaction_commit(sb);
+	if (err)
+		goto out_undo_create;
+
+	d_instantiate_new(dentry, inode);
+
+	return 0;
+
+out_undo_create:
+	apfs_undo_create_dentry(dentry);
+out_discard_inode:
+	/* Don't reset nlink: on-disk cleanup is unneeded and would deadlock */
+	discard_new_inode(inode);
+out_abort:
+	apfs_transaction_abort(sb);
+	return err;
+}
+
+int apfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
+	       struct dentry *dentry, umode_t mode, dev_t rdev)
+{
+	return apfs_mkany(dir, dentry, mode, rdev, NULL /* symname */);
+}
+
+int apfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+	       struct dentry *dentry, umode_t mode)
+{
+	return apfs_mknod(idmap, dir, dentry, mode | S_IFDIR, 0 /* rdev */);
+}
+
+
+int apfs_create(struct mnt_idmap *idmap, struct inode *dir,
+		struct dentry *dentry, umode_t mode, bool excl)
+{
+	return apfs_mknod(idmap, dir, dentry, mode, 0 /* rdev */);
+}
+
+/**
+ * apfs_prepare_dentry_for_link - Assign a sibling id and records to a dentry
+ * @dentry: the in-memory dentry (should be for a primary link)
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+static int apfs_prepare_dentry_for_link(struct dentry *dentry)
+{
+	struct inode *parent = d_inode(dentry->d_parent);
+	struct super_block *sb = parent->i_sb;
+	struct apfs_query *query;
+	struct apfs_drec drec;
+	u64 sibling_id;
+	int ret;
+
+	query = apfs_dentry_lookup(parent, &dentry->d_name, &drec);
+	if (IS_ERR(query)) {
+		apfs_err(sb, "lookup failed in dir 0x%llx", apfs_ino(parent));
+		return PTR_ERR(query);
+	}
+	if (drec.sibling_id) {
+		/* This dentry already has a sibling id xfield */
+		apfs_free_query(query);
+		return 0;
+	}
+
+	/* Don't modify the dentry record, just delete it to make a new one */
+	ret = apfs_btree_remove(query);
+	apfs_free_query(query);
+	if (ret) {
+		apfs_err(sb, "removal failed in dir 0x%llx", apfs_ino(parent));
+		return ret;
+	}
+
+	ret = apfs_create_sibling_recs(dentry, d_inode(dentry), &sibling_id);
+	if (ret) {
+		apfs_err(sb, "failed to create sibling recs in dir 0x%llx", apfs_ino(parent));
+		return ret;
+	}
+	return apfs_create_dentry_rec(d_inode(dentry), &dentry->d_name,
+				      apfs_ino(parent), sibling_id);
+}
+#define APFS_PREPARE_DENTRY_FOR_LINK_MAXOPS	(1 + APFS_CREATE_SIBLING_RECS_MAXOPS + \
+						 APFS_CREATE_DENTRY_REC_MAXOPS)
+
+/**
+ * __apfs_undo_link - Clean up __apfs_link()
+ * @dentry: the in-memory dentry
+ * @inode:  target inode
+ */
+static void __apfs_undo_link(struct dentry *dentry, struct inode *inode)
+{
+	apfs_undo_create_dentry(dentry);
+	drop_nlink(inode);
+}
+
+/**
+ * __apfs_link - Link a dentry
+ * @old_dentry: dentry for the old link
+ * @dentry:	new dentry to link
+ *
+ * Does the same as apfs_link(), but without starting a transaction, taking a
+ * new reference to @old_dentry->d_inode, or instantiating @dentry.
+ */
+static int __apfs_link(struct dentry *old_dentry, struct dentry *dentry)
+{
+	struct inode *inode = d_inode(old_dentry);
+	struct super_block *sb = inode->i_sb;
+	int err;
+
+	/* First update the inode's link count */
+	inc_nlink(inode);
+	inode_set_ctime_current(inode);
+	apfs_inode_join_transaction(inode->i_sb, inode);
+
+	if (inode->i_nlink == 2) {
+		/* A single link may lack sibling records, so create them now */
+		err = apfs_prepare_dentry_for_link(old_dentry);
+		if (err) {
+			apfs_err(sb, "failed to prepare original dentry");
+			goto fail;
+		}
+	}
+
+	err = apfs_create_dentry(dentry, inode);
+	if (err) {
+		apfs_err(sb, "failed to create new dentry");
+		goto fail;
+	}
+	return 0;
+
+fail:
+	drop_nlink(inode);
+	return err;
+}
+#define __APFS_LINK_MAXOPS	(APFS_UPDATE_INODE_MAXOPS() + \
+				 APFS_PREPARE_DENTRY_FOR_LINK_MAXOPS + \
+				 APFS_CREATE_DENTRY_MAXOPS)
+
+int apfs_link(struct dentry *old_dentry, struct inode *dir,
+	      struct dentry *dentry)
+{
+	struct super_block *sb = dir->i_sb;
+	struct inode *inode = d_inode(old_dentry);
+	struct apfs_max_ops maxops;
+	int err;
+
+	maxops.cat = __APFS_LINK_MAXOPS;
+	maxops.blks = 0;
+
+	err = apfs_transaction_start(sb, maxops);
+	if (err)
+		return err;
+
+	err = __apfs_link(old_dentry, dentry);
+	if (err)
+		goto out_abort;
+	ihold(inode);
+
+	err = apfs_transaction_commit(sb);
+	if (err)
+		goto out_undo_link;
+
+	d_instantiate(dentry, inode);
+	return 0;
+
+out_undo_link:
+	iput(inode);
+	__apfs_undo_link(dentry, inode);
+out_abort:
+	apfs_transaction_abort(sb);
+	return err;
+}
+
+/**
+ * apfs_delete_sibling_link_rec - Delete the sibling link record for a dentry
+ * @dentry:	the in-memory dentry
+ * @sibling_id:	sibling id for this hardlink
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_delete_sibling_link_rec(struct dentry *dentry, u64 sibling_id)
+{
+	struct super_block *sb = dentry->d_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct inode *inode = d_inode(dentry);
+	struct apfs_query *query = NULL;
+	int ret;
+
+	ASSERT(sibling_id);
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_sibling_link_key(apfs_ino(inode), sibling_id, &query->key);
+	query->flags |= APFS_QUERY_CAT | APFS_QUERY_EXACT;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret == -ENODATA) {
+		/* A dentry with a sibling id must have sibling records */
+		ret = -EFSCORRUPTED;
+	}
+	if (ret) {
+		apfs_err(sb, "query failed for ino 0x%llx, sibling 0x%llx", apfs_ino(inode), sibling_id);
+		goto fail;
+	}
+	ret = apfs_btree_remove(query);
+	if (ret)
+		apfs_err(sb, "removal failed for ino 0x%llx, sibling 0x%llx", apfs_ino(inode), sibling_id);
+
+fail:
+	apfs_free_query(query);
+	return ret;
+}
+#define APFS_DELETE_SIBLING_LINK_REC_MAXOPS	1
+
+/**
+ * apfs_delete_sibling_map_rec - Delete the sibling map record for a dentry
+ * @dentry:	the in-memory dentry
+ * @sibling_id:	sibling id for this hardlink
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_delete_sibling_map_rec(struct dentry *dentry, u64 sibling_id)
+{
+	struct super_block *sb = dentry->d_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_query *query = NULL;
+	int ret;
+
+	ASSERT(sibling_id);
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_sibling_map_key(sibling_id, &query->key);
+	query->flags |= APFS_QUERY_CAT | APFS_QUERY_EXACT;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret == -ENODATA) {
+		/* A dentry with a sibling id must have sibling records */
+		ret = -EFSCORRUPTED;
+	}
+	if (ret) {
+		apfs_err(sb, "query failed for sibling 0x%llx", sibling_id);
+		goto fail;
+	}
+	ret = apfs_btree_remove(query);
+	if (ret)
+		apfs_err(sb, "removal failed for sibling 0x%llx", sibling_id);
+
+fail:
+	apfs_free_query(query);
+	return ret;
+}
+#define APFS_DELETE_SIBLING_MAP_REC_MAXOPS	1
+
+/**
+ * apfs_delete_dentry - Delete all records for a dentry
+ * @dentry: the in-memory dentry
+ *
+ * Deletes the dentry record itself, as well as the sibling records if they
+ * exist; also updates the child count for the parent inode.  Returns 0 on
+ * success or a negative error code in case of failure.
+ */
+static int apfs_delete_dentry(struct dentry *dentry)
+{
+	struct super_block *sb = dentry->d_sb;
+	struct inode *parent = d_inode(dentry->d_parent);
+	struct apfs_query *query;
+	struct apfs_drec drec;
+	int err;
+
+	query = apfs_dentry_lookup(parent, &dentry->d_name, &drec);
+	if (IS_ERR(query))
+		return PTR_ERR(query);
+	err = apfs_btree_remove(query);
+	apfs_free_query(query);
+	if (err) {
+		apfs_err(sb, "drec removal failed");
+		return err;
+	}
+
+	if (drec.sibling_id) {
+		err = apfs_delete_sibling_link_rec(dentry, drec.sibling_id);
+		if (err) {
+			apfs_err(sb, "sibling link removal failed");
+			return err;
+		}
+		err = apfs_delete_sibling_map_rec(dentry, drec.sibling_id);
+		if (err) {
+			apfs_err(sb, "sibling map removal failed");
+			return err;
+		}
+	}
+
+	/* Now update the parent inode */
+	inode_set_mtime_to_ts(parent, inode_set_ctime_current(parent));
+	--APFS_I(parent)->i_nchildren;
+	apfs_inode_join_transaction(sb, parent);
+	return err;
+}
+#define APFS_DELETE_DENTRY_MAXOPS	(1 + APFS_DELETE_SIBLING_LINK_REC_MAXOPS + \
+					 APFS_DELETE_SIBLING_MAP_REC_MAXOPS + \
+					 APFS_UPDATE_INODE_MAXOPS())
+
+/**
+ * apfs_undo_delete_dentry - Clean up apfs_delete_dentry()
+ * @dentry: the in-memory dentry
+ */
+static inline void apfs_undo_delete_dentry(struct dentry *dentry)
+{
+	struct inode *parent = d_inode(dentry->d_parent);
+
+	/* Cleanup for the on-disk changes will happen on transaction abort */
+	++APFS_I(parent)->i_nchildren;
+}
+
+/**
+ * apfs_sibling_link_from_query - Read the sibling link record found by a query
+ * @query:	the query that found the record
+ * @name:	on return, the name of link
+ * @parent:	on return, the inode number for the link's parent
+ *
+ * Reads the sibling link information into @parent and @name, and performs some
+ * basic sanity checks as a protection against crafted filesystems.  The caller
+ * must free @name after use.  Returns 0 on success or a negative error code in
+ * case of failure.
+ */
+static int apfs_sibling_link_from_query(struct apfs_query *query,
+					char **name, u64 *parent)
+{
+	struct super_block *sb = query->node->object.sb;
+	char *raw = query->node->object.data;
+	struct apfs_sibling_val *siblink;
+	int namelen = query->len - sizeof(*siblink);
+
+	if (namelen < 1) {
+		apfs_err(sb, "value is too small (%d)", query->len);
+		return -EFSCORRUPTED;
+	}
+	siblink = (struct apfs_sibling_val *)(raw + query->off);
+
+	if (namelen != le16_to_cpu(siblink->name_len)) {
+		apfs_err(sb, "inconsistent name length");
+		return -EFSCORRUPTED;
+	}
+	/* Filename must be NULL-terminated */
+	if (siblink->name[namelen - 1] != 0) {
+		apfs_err(sb, "null termination missing");
+		return -EFSCORRUPTED;
+	}
+
+	*name = kmalloc(namelen, GFP_KERNEL);
+	if (!*name)
+		return -ENOMEM;
+	strscpy(*name, siblink->name, namelen);
+	*parent = le64_to_cpu(siblink->parent_id);
+	return 0;
+}
+
+/**
+ * apfs_find_primary_link - Find the primary link for an inode
+ * @inode:	the vfs inode
+ * @name:	on return, the name of the primary link
+ * @parent:	on return, the inode number for the primary parent
+ *
+ * On success, returns 0 and sets @parent and @name; the second must be freed
+ * by the caller after use.  Returns a negative error code in case of failure.
+ */
+static int apfs_find_primary_link(struct inode *inode, char **name, u64 *parent)
+{
+	struct super_block *sb = inode->i_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_query *query;
+	int err;
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_sibling_link_key(apfs_ino(inode), 0 /* sibling_id */, &query->key);
+	query->flags |= APFS_QUERY_CAT | APFS_QUERY_ANY_NUMBER | APFS_QUERY_EXACT;
+
+	/* The primary link is the one with the lowest sibling id */
+	*name = NULL;
+	while (1) {
+		err = apfs_btree_query(sb, &query);
+		if (err == -ENODATA) /* No more link records */
+			break;
+		kfree(*name);
+		if (err) {
+			apfs_err(sb, "query failed for ino 0x%llx", apfs_ino(inode));
+			goto fail;
+		}
+
+		err = apfs_sibling_link_from_query(query, name, parent);
+		if (err) {
+			apfs_err(sb, "bad sibling link record for ino 0x%llx", apfs_ino(inode));
+			goto fail;
+		}
+	}
+	err = *name ? 0 : -EFSCORRUPTED; /* Sibling records must exist */
+	if (err)
+		apfs_err(sb, "query failed for ino 0x%llx", apfs_ino(inode));
+
+fail:
+	apfs_free_query(query);
+	return err;
+}
+
+/**
+ * apfs_orphan_name - Get the name for an orphan inode's invisible link
+ * @ino:	the inode number
+ * @qname:	on return, the name assigned to the link
+ *
+ * Returns 0 on success; the caller must remember to free @qname->name after
+ * use.  Returns a negative error code in case of failure.
+ */
+static int apfs_orphan_name(u64 ino, struct qstr *qname)
+{
+	int max_len;
+	char *name;
+
+	/* The name is the inode number in hex, with '-dead' suffix */
+	max_len = 2 + 16 + 5 + 1;
+	name = kmalloc(max_len, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+	qname->len = snprintf(name, max_len, "0x%llx-dead", ino);
+	qname->name = name;
+	return 0;
+}
+
+/**
+ * apfs_create_orphan_link - Create a link for an orphan inode under private-dir
+ * @inode:	the vfs inode
+ *
+ * On success, returns 0. Returns a negative error code in case of failure.
+ */
+static int apfs_create_orphan_link(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct inode *priv_dir = sbi->s_private_dir;
+	struct qstr qname;
+	int err = 0;
+
+	err = apfs_orphan_name(apfs_ino(inode), &qname);
+	if (err)
+		return err;
+	err = apfs_create_dentry_rec(inode, &qname, apfs_ino(priv_dir), 0 /* sibling_id */);
+	if (err) {
+		apfs_err(sb, "failed to create drec for ino 0x%llx", apfs_ino(inode));
+		goto fail;
+	}
+
+	/* Now update the child count for private-dir */
+	inode_set_mtime_to_ts(priv_dir, inode_set_ctime_current(priv_dir));
+	++APFS_I(priv_dir)->i_nchildren;
+	apfs_inode_join_transaction(sb, priv_dir);
+
+fail:
+	kfree(qname.name);
+	return err;
+}
+#define APFS_CREATE_ORPHAN_LINK_MAXOPS	(APFS_CREATE_DENTRY_REC_MAXOPS + \
+					 APFS_UPDATE_INODE_MAXOPS())
+
+/**
+ * apfs_delete_orphan_link - Delete the link for an orphan inode
+ * @inode: the vfs inode
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+int apfs_delete_orphan_link(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct inode *priv_dir = sbi->s_private_dir;
+	struct apfs_query *query;
+	struct qstr qname;
+	struct apfs_drec drec;
+	int err;
+
+	err = apfs_orphan_name(apfs_ino(inode), &qname);
+	if (err)
+		return err;
+
+	query = apfs_dentry_lookup(priv_dir, &qname, &drec);
+	if (IS_ERR(query)) {
+		apfs_err(sb, "dentry lookup failed");
+		err = PTR_ERR(query);
+		query = NULL;
+		goto fail;
+	}
+	err = apfs_btree_remove(query);
+	if (err) {
+		apfs_err(sb, "dentry removal failed");
+		goto fail;
+	}
+
+	/* Now update the child count for private-dir */
+	inode_set_mtime_to_ts(priv_dir, inode_set_ctime_current(priv_dir));
+	--APFS_I(priv_dir)->i_nchildren;
+	apfs_inode_join_transaction(sb, priv_dir);
+
+fail:
+	apfs_free_query(query);
+	kfree(qname.name);
+	return err;
+}
+int APFS_DELETE_ORPHAN_LINK_MAXOPS(void)
+{
+	return 1 + APFS_UPDATE_INODE_MAXOPS();
+}
+
+/**
+ * __apfs_undo_unlink - Clean up __apfs_unlink()
+ * @dentry: dentry to unlink
+ */
+static void __apfs_undo_unlink(struct dentry *dentry)
+{
+	struct inode *inode = d_inode(dentry);
+
+	inode->i_state |= I_LINKABLE; /* Silence warning about nlink 0->1 */
+	inc_nlink(inode);
+	inode->i_state &= ~I_LINKABLE;
+
+	apfs_undo_delete_dentry(dentry);
+}
+
+/**
+ * apfs_vol_filecnt_dec - Update the volume file count after a new orphaning
+ * @orphan: the new orphan
+ */
+static void apfs_vol_filecnt_dec(struct inode *orphan)
+{
+	struct super_block *sb = orphan->i_sb;
+	struct apfs_superblock *vsb_raw = APFS_SB(sb)->s_vsb_raw;
+
+	apfs_assert_in_transaction(sb, &vsb_raw->apfs_o);
+
+	switch (orphan->i_mode & S_IFMT) {
+	case S_IFREG:
+		le64_add_cpu(&vsb_raw->apfs_num_files, -1);
+		break;
+	case S_IFDIR:
+		le64_add_cpu(&vsb_raw->apfs_num_directories, -1);
+		break;
+	case S_IFLNK:
+		le64_add_cpu(&vsb_raw->apfs_num_symlinks, -1);
+		break;
+	default:
+		le64_add_cpu(&vsb_raw->apfs_num_other_fsobjects, -1);
+		break;
+	}
+}
+
+/**
+ * __apfs_unlink - Unlink a dentry
+ * @dir:    parent directory
+ * @dentry: dentry to unlink
+ *
+ * Does the same as apfs_unlink(), but without starting a transaction.
+ */
+static int __apfs_unlink(struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode = d_inode(dentry);
+	struct super_block *sb = inode->i_sb;
+	struct apfs_inode_info *ai = APFS_I(inode);
+	char *primary_name = NULL;
+	int err;
+
+	err = apfs_delete_dentry(dentry);
+	if (err) {
+		apfs_err(sb, "failed to delete dentry recs for ino 0x%llx", apfs_ino(inode));
+		return err;
+	}
+
+	drop_nlink(inode);
+	if (!inode->i_nlink) {
+		/* Orphaned inodes continue to report their old location */
+		err = apfs_create_orphan_link(inode);
+		/* Orphans are not included in the volume file counts */
+		apfs_vol_filecnt_dec(inode);
+	} else {
+		/* We may have deleted the primary link, so get the new one */
+		err = apfs_find_primary_link(inode, &primary_name,
+					     &ai->i_parent_id);
+	}
+	if (err)
+		goto fail;
+
+	inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
+	/* TODO: defer write of the primary name? */
+	err = apfs_update_inode(inode, primary_name);
+	if (err)
+		apfs_err(sb, "inode update failed for 0x%llx", apfs_ino(inode));
+
+fail:
+	kfree(primary_name);
+	primary_name = NULL;
+	if (err)
+		__apfs_undo_unlink(dentry);
+	return err;
+}
+#define __APFS_UNLINK_MAXOPS	(APFS_DELETE_DENTRY_MAXOPS + \
+				 APFS_CREATE_ORPHAN_LINK_MAXOPS + \
+				 APFS_UPDATE_INODE_MAXOPS())
+
+int apfs_unlink(struct inode *dir, struct dentry *dentry)
+{
+	struct super_block *sb = dir->i_sb;
+	struct apfs_max_ops maxops;
+	int err;
+
+	maxops.cat = __APFS_UNLINK_MAXOPS;
+	maxops.blks = 0;
+
+	err = apfs_transaction_start(sb, maxops);
+	if (err)
+		return err;
+
+	err = __apfs_unlink(dir, dentry);
+	if (err)
+		goto out_abort;
+
+	err = apfs_transaction_commit(sb);
+	if (err)
+		goto out_undo_unlink;
+	return 0;
+
+out_undo_unlink:
+	__apfs_undo_unlink(dentry);
+out_abort:
+	apfs_transaction_abort(sb);
+	return err;
+}
+
+int apfs_rmdir(struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode = d_inode(dentry);
+
+	if (APFS_I(inode)->i_nchildren)
+		return -ENOTEMPTY;
+	return apfs_unlink(dir, dentry);
+}
+
+int apfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
+		struct dentry *old_dentry, struct inode *new_dir,
+		struct dentry *new_dentry, unsigned int flags)
+{
+	struct super_block *sb = old_dir->i_sb;
+	struct inode *old_inode = d_inode(old_dentry);
+	struct inode *new_inode = d_inode(new_dentry);
+	struct apfs_max_ops maxops;
+	int err;
+
+	if (new_inode && APFS_I(new_inode)->i_nchildren)
+		return -ENOTEMPTY;
+
+	if (flags & ~RENAME_NOREPLACE) /* TODO: support RENAME_EXCHANGE */
+		return -EINVAL;
+
+	maxops.cat = __APFS_UNLINK_MAXOPS + __APFS_LINK_MAXOPS;
+	if (new_inode)
+		maxops.cat += __APFS_UNLINK_MAXOPS;
+	maxops.blks = 0;
+
+	err = apfs_transaction_start(sb, maxops);
+	if (err)
+		return err;
+
+	if (new_inode) {
+		err = __apfs_unlink(new_dir, new_dentry);
+		if (err) {
+			apfs_err(sb, "unlink failed for replaced dentry");
+			goto out_abort;
+		}
+	}
+
+	err = __apfs_link(old_dentry, new_dentry);
+	if (err) {
+		apfs_err(sb, "link failed for new dentry");
+		goto out_undo_unlink_new;
+	}
+
+	err = __apfs_unlink(old_dir, old_dentry);
+	if (err) {
+		apfs_err(sb, "unlink failed for old dentry");
+		goto out_undo_link;
+	}
+
+	err = apfs_transaction_commit(sb);
+	if (err)
+		goto out_undo_unlink_old;
+	return 0;
+
+out_undo_unlink_old:
+	__apfs_undo_unlink(old_dentry);
+out_undo_link:
+	__apfs_undo_link(new_dentry, old_inode);
+out_undo_unlink_new:
+	if (new_inode)
+		__apfs_undo_unlink(new_dentry);
+out_abort:
+	apfs_transaction_abort(sb);
+	return err;
+}
+
+/**
+ * apfs_any_orphan_ino - Find the inode number for any orphaned regular file
+ * @sb:		filesytem superblock
+ * @ino_p:	on return, the inode number found
+ *
+ * Returns 0 on success, or a negative error code in case of failure, which may
+ * be -ENODATA if there are no orphan files.
+ */
+u64 apfs_any_orphan_ino(struct super_block *sb, u64 *ino_p)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_query *query = NULL;
+	struct apfs_drec drec = {0};
+	struct qstr qname = {0};
+	bool hashed = apfs_is_normalization_insensitive(sb);
+	bool found = false;
+	int err;
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_drec_key(sb, APFS_PRIV_DIR_INO_NUM, NULL /* name */, 0 /* name_len */, &query->key);
+	query->flags = APFS_QUERY_CAT | APFS_QUERY_MULTIPLE | APFS_QUERY_EXACT;
+
+	while (!found) {
+		err = apfs_btree_query(sb, &query);
+		if (err) {
+			if (err == -ENODATA)
+				goto out;
+			apfs_err(sb, "drec query failed for private dir");
+			goto out;
+		}
+		err = apfs_drec_from_query(query, &drec, hashed);
+		if (err) {
+			apfs_alert(sb, "bad dentry record in private dir");
+			goto out;
+		}
+
+		/* These files are deleted immediately by ->evict_inode() */
+		if (drec.type != DT_REG)
+			continue;
+
+		/*
+		 * Confirm that this is an orphan file, because the official
+		 * reference allows other uses for the private directory.
+		 */
+		err = apfs_orphan_name(drec.ino, &qname);
+		if (err)
+			goto out;
+		found = strcmp(drec.name, qname.name) == 0;
+		kfree(qname.name);
+		qname.name = NULL;
+	}
+	*ino_p = drec.ino;
+
+out:
+	apfs_free_query(query);
+	query = NULL;
+	return err;
+}
diff --git a/drivers/staging/apfs/extents.c b/drivers/staging/apfs/extents.c
new file mode 100644
index 0000000000000000000000000000000000000000..02a5a6c453cf5fccce14e990fb8d262823fa0a42
--- /dev/null
+++ b/drivers/staging/apfs/extents.c
@@ -0,0 +1,2371 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2018 Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
+ * Copyright (C) 2025 Ethan Carter Edwards <ethan@ethancedwards.com>
+ */
+
+#include <linux/buffer_head.h>
+#include <linux/slab.h>
+#include <linux/blk_types.h>
+#include "apfs.h"
+
+/**
+ * apfs_ext_is_hole - Does this extent represent a hole in a sparse file?
+ * @extent: the extent to check
+ */
+static inline bool apfs_ext_is_hole(struct apfs_file_extent *extent)
+{
+	return extent->phys_block_num == 0;
+}
+
+/**
+ * apfs_size_to_blocks - Return the block count for a given size, rounded up
+ * @sb:		filesystem superblock
+ * @size:	size in bytes
+ *
+ * TODO: reuse for inode.c
+ */
+static inline u64 apfs_size_to_blocks(struct super_block *sb, u64 size)
+{
+	return (size + sb->s_blocksize - 1) >> sb->s_blocksize_bits;
+}
+
+/**
+ * apfs_extent_from_query - Read the extent found by a successful query
+ * @query:	the query that found the record
+ * @extent:	Return parameter.  The extent found.
+ *
+ * Reads the extent record into @extent and performs some basic sanity checks
+ * as a protection against crafted filesystems.  Returns 0 on success or
+ * -EFSCORRUPTED otherwise.
+ */
+int apfs_extent_from_query(struct apfs_query *query,
+			   struct apfs_file_extent *extent)
+{
+	struct super_block *sb = query->node->object.sb;
+	char *raw = query->node->object.data;
+	u64 ext_len;
+
+	if (!apfs_is_sealed(sb)) {
+		struct apfs_file_extent_val *ext = NULL;
+		struct apfs_file_extent_key *ext_key = NULL;
+
+		if (query->len != sizeof(*ext) || query->key_len != sizeof(*ext_key)) {
+			apfs_err(sb, "bad length of key (%d) or value (%d)", query->key_len, query->len);
+			return -EFSCORRUPTED;
+		}
+
+		ext = (struct apfs_file_extent_val *)(raw + query->off);
+		ext_key = (struct apfs_file_extent_key *)(raw + query->key_off);
+		ext_len = le64_to_cpu(ext->len_and_flags) & APFS_FILE_EXTENT_LEN_MASK;
+
+		extent->logical_addr = le64_to_cpu(ext_key->logical_addr);
+		extent->phys_block_num = le64_to_cpu(ext->phys_block_num);
+		extent->crypto_id = le64_to_cpu(ext->crypto_id);
+	} else {
+		struct apfs_fext_tree_val *fext_val = NULL;
+		struct apfs_fext_tree_key *fext_key = NULL;
+
+		if (query->len != sizeof(*fext_val) || query->key_len != sizeof(*fext_key)) {
+			apfs_err(sb, "bad length of sealed key (%d) or value (%d)", query->key_len, query->len);
+			return -EFSCORRUPTED;
+		}
+
+		fext_val = (struct apfs_fext_tree_val *)(raw + query->off);
+		fext_key = (struct apfs_fext_tree_key *)(raw + query->key_off);
+		ext_len = le64_to_cpu(fext_val->len_and_flags) & APFS_FILE_EXTENT_LEN_MASK;
+
+		extent->logical_addr = le64_to_cpu(fext_key->logical_addr);
+		extent->phys_block_num = le64_to_cpu(fext_val->phys_block_num);
+		extent->crypto_id = 0;
+	}
+
+	/* Extent length must be a multiple of the block size */
+	if (ext_len & (sb->s_blocksize - 1)) {
+		apfs_err(sb, "invalid length (0x%llx)", ext_len);
+		return -EFSCORRUPTED;
+	}
+	extent->len = ext_len;
+	return 0;
+}
+
+/**
+ * apfs_extent_read - Read the extent record that covers a block
+ * @dstream:	data stream info
+ * @dsblock:	logical number of the wanted block (must be in range)
+ * @extent:	Return parameter.  The extent found.
+ *
+ * Finds and caches the extent record.  On success, returns a pointer to the
+ * cache record; on failure, returns an error code.
+ */
+static int apfs_extent_read(struct apfs_dstream_info *dstream, sector_t dsblock,
+			    struct apfs_file_extent *extent)
+{
+	struct super_block *sb = dstream->ds_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_superblock *vsb_raw = sbi->s_vsb_raw;
+	struct apfs_key key;
+	struct apfs_query *query;
+	struct apfs_file_extent *cache = &dstream->ds_cached_ext;
+	u64 iaddr = dsblock << sb->s_blocksize_bits;
+	struct apfs_node *root = NULL;
+	int ret = 0;
+
+	spin_lock(&dstream->ds_ext_lock);
+	if (iaddr >= cache->logical_addr &&
+	    iaddr < cache->logical_addr + cache->len) {
+		*extent = *cache;
+		spin_unlock(&dstream->ds_ext_lock);
+		return 0;
+	}
+	spin_unlock(&dstream->ds_ext_lock);
+
+	/* We will search for the extent that covers iblock */
+	if (!apfs_is_sealed(sb)) {
+		apfs_init_file_extent_key(dstream->ds_id, iaddr, &key);
+		root = sbi->s_cat_root;
+	} else {
+		apfs_init_fext_key(dstream->ds_id, iaddr, &key);
+		root = apfs_read_node(sb, le64_to_cpu(vsb_raw->apfs_fext_tree_oid), APFS_OBJ_PHYSICAL, false /* write */);
+		if (IS_ERR(root)) {
+			apfs_err(sb, "failed to read fext root 0x%llx", le64_to_cpu(vsb_raw->apfs_fext_tree_oid));
+			return PTR_ERR(root);
+		}
+	}
+
+	query = apfs_alloc_query(root, NULL /* parent */);
+	if (!query) {
+		ret = -ENOMEM;
+		goto done;
+	}
+	query->key = key;
+	query->flags = apfs_is_sealed(sb) ? APFS_QUERY_FEXT : APFS_QUERY_CAT;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret) {
+		apfs_err(sb, "query failed for id 0x%llx, addr 0x%llx", dstream->ds_id, iaddr);
+		if (ret == -ENODATA)
+			ret = -EFSCORRUPTED;
+		goto done;
+	}
+
+	ret = apfs_extent_from_query(query, extent);
+	if (ret) {
+		apfs_err(sb, "bad extent record for dstream 0x%llx", dstream->ds_id);
+		goto done;
+	}
+	if (iaddr < extent->logical_addr || iaddr >= extent->logical_addr + extent->len) {
+		apfs_err(sb, "no extent for addr 0x%llx in dstream 0x%llx", iaddr, dstream->ds_id);
+		ret = -EFSCORRUPTED;
+		goto done;
+	}
+
+	/*
+	 * For now prioritize the deferral of writes.
+	 * i_extent_dirty is protected by the read semaphore.
+	 */
+	if (!dstream->ds_ext_dirty) {
+		spin_lock(&dstream->ds_ext_lock);
+		*cache = *extent;
+		spin_unlock(&dstream->ds_ext_lock);
+	}
+
+done:
+	apfs_free_query(query);
+	if (apfs_is_sealed(sb))
+		apfs_node_free(root);
+	return ret;
+}
+
+/**
+ * apfs_logic_to_phys_bno - Find the physical block number for a dstream block
+ * @dstream:	data stream info
+ * @dsblock:	logical number of the wanted block
+ * @bno:	on return, the physical block number (or zero for holes)
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+int apfs_logic_to_phys_bno(struct apfs_dstream_info *dstream, sector_t dsblock, u64 *bno)
+{
+	struct super_block *sb = dstream->ds_sb;
+	struct apfs_file_extent ext;
+	u64 blk_off;
+	int ret;
+
+	ret = apfs_extent_read(dstream, dsblock, &ext);
+	if (ret)
+		return ret;
+
+	if (apfs_ext_is_hole(&ext)) {
+		*bno = 0;
+		return 0;
+	}
+
+	/* Find the block offset of iblock within the extent */
+	blk_off = dsblock - (ext.logical_addr >> sb->s_blocksize_bits);
+	*bno = ext.phys_block_num + blk_off;
+	return 0;
+}
+
+/* This does the same as apfs_get_block(), but without taking any locks */
+int __apfs_get_block(struct apfs_dstream_info *dstream, sector_t dsblock,
+		     struct buffer_head *bh_result, int create)
+{
+	struct super_block *sb = dstream->ds_sb;
+	struct apfs_file_extent ext;
+	u64 blk_off, bno, map_len;
+	int ret;
+
+	ASSERT(!create);
+
+	if (dsblock >= apfs_size_to_blocks(sb, dstream->ds_size))
+		return 0;
+
+	ret = apfs_extent_read(dstream, dsblock, &ext);
+	if (ret) {
+		apfs_err(sb, "extent read failed");
+		return ret;
+	}
+
+	/* Find the block offset of iblock within the extent */
+	blk_off = dsblock - (ext.logical_addr >> sb->s_blocksize_bits);
+
+	/* Make sure we don't read past the extent boundaries */
+	map_len = ext.len - (blk_off << sb->s_blocksize_bits);
+	if (bh_result->b_size > map_len)
+		bh_result->b_size = map_len;
+
+	/*
+	 * Save the requested mapping length as apfs_map_bh() replaces it with
+	 * the filesystem block size
+	 */
+	map_len = bh_result->b_size;
+	/* Extents representing holes have block number 0 */
+	if (!apfs_ext_is_hole(&ext)) {
+		/* Find the block number of iblock within the disk */
+		bno = ext.phys_block_num + blk_off;
+		apfs_map_bh(bh_result, sb, bno);
+	}
+	bh_result->b_size = map_len;
+	return 0;
+}
+
+int apfs_get_block(struct inode *inode, sector_t iblock,
+		   struct buffer_head *bh_result, int create)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(inode->i_sb);
+	struct apfs_inode_info *ai = APFS_I(inode);
+	int ret;
+
+	down_read(&nxi->nx_big_sem);
+	ret = __apfs_get_block(&ai->i_dstream, iblock, bh_result, create);
+	up_read(&nxi->nx_big_sem);
+	return ret;
+}
+
+/**
+ * apfs_set_extent_length - Set a new length in an extent record's value
+ * @ext: the extent record's value
+ * @len: the new length
+ *
+ * Preserves the flags, though none are defined yet and I don't know if that
+ * will ever be important.
+ */
+static inline void apfs_set_extent_length(struct apfs_file_extent_val *ext, u64 len)
+{
+	u64 len_and_flags = le64_to_cpu(ext->len_and_flags);
+	u64 flags = len_and_flags & APFS_FILE_EXTENT_FLAG_MASK;
+
+	ext->len_and_flags = cpu_to_le64(flags | len);
+}
+
+static int apfs_range_put_reference(struct super_block *sb, u64 paddr, u64 length);
+
+/**
+ * apfs_shrink_extent_head - Shrink an extent record in its head
+ * @query:	the query that found the record
+ * @dstream:	data stream info
+ * @start:	new logical start for the extent
+ *
+ * Also deletes the physical extent records for the head. Returns 0 on success
+ * or a negative error code in case of failure.
+ */
+static int apfs_shrink_extent_head(struct apfs_query *query, struct apfs_dstream_info *dstream, u64 start)
+{
+	struct super_block *sb = query->node->object.sb;
+	struct apfs_file_extent_key key;
+	struct apfs_file_extent_val val;
+	struct apfs_file_extent extent;
+	u64 new_len, head_len;
+	void *raw = NULL;
+	int err = 0;
+
+	err = apfs_extent_from_query(query, &extent);
+	if (err) {
+		apfs_err(sb, "bad extent record for dstream 0x%llx", dstream->ds_id);
+		return err;
+	}
+	raw = query->node->object.data;
+	key = *(struct apfs_file_extent_key *)(raw + query->key_off);
+	val = *(struct apfs_file_extent_val *)(raw + query->off);
+
+	new_len = extent.logical_addr + extent.len - start;
+	head_len = extent.len - new_len;
+
+	/* Delete the physical records for the blocks lost in the shrinkage */
+	if (!apfs_ext_is_hole(&extent)) {
+		err = apfs_range_put_reference(sb, extent.phys_block_num, head_len);
+		if (err) {
+			apfs_err(sb, "failed to put range 0x%llx-0x%llx", extent.phys_block_num, head_len);
+			return err;
+		}
+	} else {
+		dstream->ds_sparse_bytes -= head_len;
+	}
+
+	/* This is the actual shrinkage of the logical extent */
+	key.logical_addr = cpu_to_le64(start);
+	apfs_set_extent_length(&val, new_len);
+	if (!apfs_ext_is_hole(&extent))
+		le64_add_cpu(&val.phys_block_num, head_len >> sb->s_blocksize_bits);
+	return apfs_btree_replace(query, &key, sizeof(key), &val, sizeof(val));
+}
+
+/**
+ * apfs_shrink_extent_tail - Shrink an extent record in its tail
+ * @query:	the query that found the record
+ * @dstream:	data stream info
+ * @end:	new logical end for the extent
+ *
+ * Also puts the physical extent records for the tail. Returns 0 on success or
+ * a negative error code in case of failure.
+ */
+static int apfs_shrink_extent_tail(struct apfs_query *query, struct apfs_dstream_info *dstream, u64 end)
+{
+	struct super_block *sb = query->node->object.sb;
+	struct apfs_file_extent_val *val;
+	struct apfs_file_extent extent;
+	u64 new_len, new_blkcount, tail_len;
+	void *raw;
+	int err = 0;
+
+	ASSERT((end & (sb->s_blocksize - 1)) == 0);
+
+	err = apfs_query_join_transaction(query);
+	if (err) {
+		apfs_err(sb, "query join failed");
+		return err;
+	}
+	raw = query->node->object.data;
+
+	err = apfs_extent_from_query(query, &extent);
+	if (err) {
+		apfs_err(sb, "bad extent record for dstream 0x%llx", dstream->ds_id);
+		return err;
+	}
+	val = raw + query->off;
+
+	new_len = end - extent.logical_addr;
+	new_blkcount = new_len >> sb->s_blocksize_bits;
+	tail_len = extent.len - new_len;
+
+	/* Delete the physical records for the blocks lost in the shrinkage */
+	if (!apfs_ext_is_hole(&extent)) {
+		err = apfs_range_put_reference(sb, extent.phys_block_num + new_blkcount, tail_len);
+		if (err) {
+			apfs_err(sb, "failed to put range 0x%llx-0x%llx", extent.phys_block_num + new_blkcount, tail_len);
+			return err;
+		}
+	} else {
+		dstream->ds_sparse_bytes -= tail_len;
+	}
+
+	/* This is the actual shrinkage of the logical extent */
+	apfs_set_extent_length(val, new_len);
+	return err;
+}
+
+/**
+ * apfs_query_found_extent - Did this query find an extent with the right id?
+ * @query: the (successful) query that found the record
+ */
+static inline bool apfs_query_found_extent(struct apfs_query *query)
+{
+	void *raw = query->node->object.data;
+	struct apfs_key_header *hdr;
+
+	if (query->key_len < sizeof(*hdr))
+		return false;
+	hdr = raw + query->key_off;
+
+	if (apfs_cat_type(hdr) != APFS_TYPE_FILE_EXTENT)
+		return false;
+	if (apfs_cat_cnid(hdr) != query->key.id)
+		return false;
+	return true;
+}
+
+/**
+ * apfs_update_tail_extent - Grow the tail extent for a data stream
+ * @dstream:	data stream info
+ * @extent:	new in-memory extent
+ *
+ * Also takes care of any needed changes to the physical extent records. Returns
+ * 0 on success or a negative error code in case of failure.
+ */
+static int apfs_update_tail_extent(struct apfs_dstream_info *dstream, const struct apfs_file_extent *extent)
+{
+	struct super_block *sb = dstream->ds_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_query *query;
+	struct apfs_file_extent_key raw_key;
+	struct apfs_file_extent_val raw_val;
+	u64 extent_id = dstream->ds_id;
+	int ret;
+	u64 new_crypto;
+
+	apfs_key_set_hdr(APFS_TYPE_FILE_EXTENT, extent_id, &raw_key);
+	raw_key.logical_addr = cpu_to_le64(extent->logical_addr);
+	raw_val.len_and_flags = cpu_to_le64(extent->len);
+	raw_val.phys_block_num = cpu_to_le64(extent->phys_block_num);
+	if (apfs_vol_is_encrypted(sb))
+		new_crypto = extent_id;
+	else
+		new_crypto = 0;
+	raw_val.crypto_id = cpu_to_le64(new_crypto);
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	/* We want the last extent record */
+	apfs_init_file_extent_key(extent_id, -1, &query->key);
+	query->flags = APFS_QUERY_CAT;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret && ret != -ENODATA) {
+		apfs_err(sb, "query failed for last extent of id 0x%llx", extent_id);
+		goto out;
+	}
+
+	if (ret == -ENODATA || !apfs_query_found_extent(query)) {
+		/* We are creating the first extent for the file */
+		ret = apfs_btree_insert(query, &raw_key, sizeof(raw_key), &raw_val, sizeof(raw_val));
+		if (ret) {
+			apfs_err(sb, "insertion failed for id 0x%llx, addr 0x%llx", extent_id, extent->logical_addr);
+			goto out;
+		}
+	} else {
+		struct apfs_file_extent tail;
+
+		ret = apfs_extent_from_query(query, &tail);
+		if (ret) {
+			apfs_err(sb, "bad extent record for dstream 0x%llx", dstream->ds_id);
+			goto out;
+		}
+
+		if (tail.logical_addr > extent->logical_addr) {
+			apfs_alert(sb, "extent is not tail - bug!");
+			ret = -EOPNOTSUPP;
+			goto out;
+		} else if (tail.logical_addr == extent->logical_addr) {
+			ret = apfs_btree_replace(query, &raw_key, sizeof(raw_key), &raw_val, sizeof(raw_val));
+			if (ret) {
+				apfs_err(sb, "update failed for id 0x%llx, addr 0x%llx", extent_id, extent->logical_addr);
+				goto out;
+			}
+			if (apfs_ext_is_hole(&tail)) {
+				dstream->ds_sparse_bytes -= tail.len;
+			} else if (tail.phys_block_num != extent->phys_block_num) {
+				ret = apfs_range_put_reference(sb, tail.phys_block_num, tail.len);
+				if (ret) {
+					apfs_err(sb, "failed to put range 0x%llx-0x%llx", tail.phys_block_num, tail.len);
+					goto out;
+				}
+			}
+			if (new_crypto == tail.crypto_id)
+				goto out;
+			ret = apfs_crypto_adj_refcnt(sb, tail.crypto_id, -1);
+			if (ret) {
+				apfs_err(sb, "failed to put crypto id 0x%llx", tail.crypto_id);
+				goto out;
+			}
+		} else {
+			/*
+			 * TODO: we could actually also continue the tail extent
+			 * if it's right next to the new one (both logically and
+			 * physically), even if they don't overlap. Or maybe we
+			 * should always make sure that the tail extent is in
+			 * the cache before a write...
+			 */
+			if (extent->logical_addr < tail.logical_addr + tail.len) {
+				ret = apfs_shrink_extent_tail(query, dstream, extent->logical_addr);
+				if (ret) {
+					apfs_err(sb, "failed to shrink tail of dstream 0x%llx", extent_id);
+					goto out;
+				}
+			}
+			ret = apfs_btree_insert(query, &raw_key, sizeof(raw_key), &raw_val, sizeof(raw_val));
+			if (ret) {
+				apfs_err(sb, "insertion failed for id 0x%llx, addr 0x%llx", extent_id, extent->logical_addr);
+				goto out;
+			}
+		}
+	}
+
+	ret = apfs_crypto_adj_refcnt(sb, new_crypto, 1);
+	if (ret)
+		apfs_err(sb, "failed to take crypto id 0x%llx", new_crypto);
+
+out:
+	apfs_free_query(query);
+	return ret;
+}
+
+/**
+ * apfs_split_extent - Break an extent in two
+ * @query:	query pointing to the extent
+ * @div:	logical address for the division
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_split_extent(struct apfs_query *query, u64 div)
+{
+	struct super_block *sb = query->node->object.sb;
+	struct apfs_file_extent_val *val1;
+	struct apfs_file_extent_key key2;
+	struct apfs_file_extent_val val2;
+	struct apfs_file_extent extent;
+	u64 len1, len2, blkcount1;
+	void *raw;
+	int err = 0;
+
+	err = apfs_query_join_transaction(query);
+	if (err) {
+		apfs_err(sb, "query join failed");
+		return err;
+	}
+	raw = query->node->object.data;
+
+	err = apfs_extent_from_query(query, &extent);
+	if (err) {
+		apfs_err(sb, "bad extent record");
+		return err;
+	}
+	val1 = raw + query->off;
+	val2 = *(struct apfs_file_extent_val *)(raw + query->off);
+	key2 = *(struct apfs_file_extent_key *)(raw + query->key_off);
+
+	len1 = div - extent.logical_addr;
+	blkcount1 = len1 >> sb->s_blocksize_bits;
+	len2 = extent.len - len1;
+
+	/* Modify the current extent in place to become the first half */
+	apfs_set_extent_length(val1, len1);
+
+	/* Insert the second half right after the first */
+	key2.logical_addr = cpu_to_le64(div);
+	if (!apfs_ext_is_hole(&extent))
+		val2.phys_block_num = cpu_to_le64(extent.phys_block_num + blkcount1);
+	apfs_set_extent_length(&val2, len2);
+	err = apfs_btree_insert(query, &key2, sizeof(key2), &val2, sizeof(val2));
+	if (err) {
+		apfs_err(sb, "insertion failed in division 0x%llx", div);
+		return err;
+	}
+
+	return apfs_crypto_adj_refcnt(sb, extent.crypto_id, 1);
+}
+
+/**
+ * apfs_update_mid_extent - Create or update a non-tail extent for a dstream
+ * @dstream:	data stream info
+ * @extent:	new in-memory extent
+ *
+ * Also takes care of any needed changes to the physical extent records. Returns
+ * 0 on success or a negative error code in case of failure.
+ */
+static int apfs_update_mid_extent(struct apfs_dstream_info *dstream, const struct apfs_file_extent *extent)
+{
+	struct super_block *sb = dstream->ds_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_key key;
+	struct apfs_query *query;
+	struct apfs_file_extent_key raw_key;
+	struct apfs_file_extent_val raw_val;
+	struct apfs_file_extent prev_ext;
+	u64 extent_id = dstream->ds_id;
+	u64 prev_crypto, new_crypto;
+	u64 prev_start, prev_end;
+	bool second_run = false;
+	int ret;
+
+	apfs_key_set_hdr(APFS_TYPE_FILE_EXTENT, extent_id, &raw_key);
+	raw_key.logical_addr = cpu_to_le64(extent->logical_addr);
+	raw_val.len_and_flags = cpu_to_le64(extent->len);
+	raw_val.phys_block_num = cpu_to_le64(extent->phys_block_num);
+	if (apfs_vol_is_encrypted(sb))
+		new_crypto = extent_id;
+	else
+		new_crypto = 0;
+	raw_val.crypto_id = cpu_to_le64(new_crypto);
+
+	apfs_init_file_extent_key(extent_id, extent->logical_addr, &key);
+
+search_and_insert:
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	query->key = key;
+	query->flags = APFS_QUERY_CAT;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret && ret != -ENODATA) {
+		apfs_err(sb, "query failed for id 0x%llx, addr 0x%llx", extent_id, extent->logical_addr);
+		goto out;
+	}
+
+	if (ret == -ENODATA || !apfs_query_found_extent(query)) {
+		/*
+		 * The new extent goes in a hole we just made, right at the
+		 * beginning of the file.
+		 */
+		if (!second_run) {
+			apfs_err(sb, "missing extent on dstream 0x%llx", extent_id);
+			ret = -EFSCORRUPTED;
+		} else {
+			ret = apfs_btree_insert(query, &raw_key, sizeof(raw_key), &raw_val, sizeof(raw_val));
+			if (ret)
+				apfs_err(sb, "insertion failed for id 0x%llx, addr 0x%llx", extent_id, extent->logical_addr);
+		}
+		goto out;
+	}
+
+	if (apfs_extent_from_query(query, &prev_ext)) {
+		apfs_err(sb, "bad mid extent record on dstream 0x%llx", extent_id);
+		ret = -EFSCORRUPTED;
+		goto out;
+	}
+	prev_crypto = prev_ext.crypto_id;
+	prev_start = prev_ext.logical_addr;
+	prev_end = prev_ext.logical_addr + prev_ext.len;
+
+	if (prev_end == extent->logical_addr && second_run) {
+		/* The new extent goes in the hole we just made */
+		ret = apfs_btree_insert(query, &raw_key, sizeof(raw_key), &raw_val, sizeof(raw_val));
+		if (ret) {
+			apfs_err(sb, "insertion failed for id 0x%llx, addr 0x%llx", extent_id, extent->logical_addr);
+			goto out;
+		}
+	} else if (prev_start == extent->logical_addr && prev_ext.len == extent->len) {
+		/* The old and new extents are the same logical block */
+		ret = apfs_btree_replace(query, &raw_key, sizeof(raw_key), &raw_val, sizeof(raw_val));
+		if (ret) {
+			apfs_err(sb, "update failed for id 0x%llx, addr 0x%llx", extent_id, extent->logical_addr);
+			goto out;
+		}
+		if (apfs_ext_is_hole(&prev_ext)) {
+			dstream->ds_sparse_bytes -= prev_ext.len;
+		} else if (prev_ext.phys_block_num != extent->phys_block_num) {
+			ret = apfs_range_put_reference(sb, prev_ext.phys_block_num, prev_ext.len);
+			if (ret) {
+				apfs_err(sb, "failed to put range 0x%llx-0x%llx", prev_ext.phys_block_num, prev_ext.len);
+				goto out;
+			}
+		}
+		ret = apfs_crypto_adj_refcnt(sb, prev_crypto, -1);
+		if (ret) {
+			apfs_err(sb, "failed to put crypto id 0x%llx", prev_crypto);
+			goto out;
+		}
+	} else if (prev_start == extent->logical_addr) {
+		/* The new extent is the first logical block of the old one */
+		if (second_run) {
+			/* I don't know if this is possible, but be safe */
+			apfs_alert(sb, "recursion shrinking extent head for dstream 0x%llx", extent_id);
+			ret = -EFSCORRUPTED;
+			goto out;
+		}
+		ret = apfs_shrink_extent_head(query, dstream, extent->logical_addr + extent->len);
+		if (ret) {
+			apfs_err(sb, "failed to shrink extent in dstream 0x%llx", extent_id);
+			goto out;
+		}
+		/* The query should point to the previous record, start again */
+		apfs_free_query(query);
+		second_run = true;
+		goto search_and_insert;
+	} else if (prev_end == extent->logical_addr + extent->len) {
+		/* The new extent is the last logical block of the old one */
+		ret = apfs_shrink_extent_tail(query, dstream, extent->logical_addr);
+		if (ret) {
+			apfs_err(sb, "failed to shrink extent in dstream 0x%llx", extent_id);
+			goto out;
+		}
+		ret = apfs_btree_insert(query, &raw_key, sizeof(raw_key), &raw_val, sizeof(raw_val));
+		if (ret) {
+			apfs_err(sb, "insertion failed for id 0x%llx, addr 0x%llx", extent_id, extent->logical_addr);
+			goto out;
+		}
+	} else if (prev_start < extent->logical_addr && prev_end > extent->logical_addr + extent->len) {
+		/* The new extent is logically in the middle of the old one */
+		if (second_run) {
+			/* I don't know if this is possible, but be safe */
+			apfs_alert(sb, "recursion when splitting extents for dstream 0x%llx", extent_id);
+			ret = -EFSCORRUPTED;
+			goto out;
+		}
+		ret = apfs_split_extent(query, extent->logical_addr + extent->len);
+		if (ret) {
+			apfs_err(sb, "failed to split extent in dstream 0x%llx", extent_id);
+			goto out;
+		}
+		/* The split may make the query invalid */
+		apfs_free_query(query);
+		second_run = true;
+		goto search_and_insert;
+	} else {
+		/* I don't know what this is, be safe */
+		apfs_alert(sb, "strange extents for dstream 0x%llx", extent_id);
+		ret = -EFSCORRUPTED;
+		goto out;
+	}
+
+	ret = apfs_crypto_adj_refcnt(sb, new_crypto, 1);
+	if (ret)
+		apfs_err(sb, "failed to take crypto id 0x%llx", new_crypto);
+
+out:
+	apfs_free_query(query);
+	return ret;
+}
+
+/**
+ * apfs_update_extent - Create or update the extent record for an extent
+ * @dstream:	data stream info
+ * @extent:	new in-memory file extent
+ *
+ * The @extent must either be a new tail for the dstream, or a single block.
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_update_extent(struct apfs_dstream_info *dstream, const struct apfs_file_extent *extent)
+{
+	struct super_block *sb = dstream->ds_sb;
+
+	if (extent->logical_addr + extent->len >= dstream->ds_size)
+		return apfs_update_tail_extent(dstream, extent);
+	if (extent->len > sb->s_blocksize) {
+		apfs_err(sb, "can't create mid extents of length 0x%llx", extent->len);
+		return -EOPNOTSUPP;
+	}
+	return apfs_update_mid_extent(dstream, extent);
+}
+#define APFS_UPDATE_EXTENTS_MAXOPS	(1 + 2 * APFS_CRYPTO_ADJ_REFCNT_MAXOPS())
+
+static int apfs_extend_phys_extent(struct apfs_query *query, u64 bno, u64 blkcnt, u64 dstream_id)
+{
+	struct apfs_phys_ext_key raw_key;
+	struct apfs_phys_ext_val raw_val;
+	u64 kind = (u64)APFS_KIND_NEW << APFS_PEXT_KIND_SHIFT;
+
+	apfs_key_set_hdr(APFS_TYPE_EXTENT, bno, &raw_key);
+	raw_val.len_and_kind = cpu_to_le64(kind | blkcnt);
+	raw_val.owning_obj_id = cpu_to_le64(dstream_id);
+	raw_val.refcnt = cpu_to_le32(1);
+	return apfs_btree_replace(query, &raw_key, sizeof(raw_key), &raw_val, sizeof(raw_val));
+}
+
+static int apfs_insert_new_phys_extent(struct apfs_query *query, u64 bno, u64 blkcnt, u64 dstream_id)
+{
+	struct apfs_phys_ext_key raw_key;
+	struct apfs_phys_ext_val raw_val;
+	u64 kind = (u64)APFS_KIND_NEW << APFS_PEXT_KIND_SHIFT;
+
+	apfs_key_set_hdr(APFS_TYPE_EXTENT, bno, &raw_key);
+	raw_val.len_and_kind = cpu_to_le64(kind | blkcnt);
+	raw_val.owning_obj_id = cpu_to_le64(dstream_id);
+	raw_val.refcnt = cpu_to_le32(1);
+	return apfs_btree_insert(query, &raw_key, sizeof(raw_key), &raw_val, sizeof(raw_val));
+}
+
+static int apfs_phys_ext_from_query(struct apfs_query *query, struct apfs_phys_extent *pext);
+
+/**
+ * apfs_insert_phys_extent - Create or grow the physical record for an extent
+ * @dstream:	data stream info for the extent
+ * @extent:	new in-memory file extent
+ *
+ * Only works for appending to extents, for now. TODO: reference counting.
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_insert_phys_extent(struct apfs_dstream_info *dstream, const struct apfs_file_extent *extent)
+{
+	struct super_block *sb = dstream->ds_sb;
+	struct apfs_superblock *vsb_raw = APFS_SB(sb)->s_vsb_raw;
+	struct apfs_node *extref_root;
+	struct apfs_query *query = NULL;
+	struct apfs_phys_extent pext;
+	u64 blkcnt = extent->len >> sb->s_blocksize_bits;
+	u64 last_bno, new_base, new_blkcnt;
+	int ret;
+
+	extref_root = apfs_read_node(sb,
+				le64_to_cpu(vsb_raw->apfs_extentref_tree_oid),
+				APFS_OBJ_PHYSICAL, true /* write */);
+	if (IS_ERR(extref_root)) {
+		apfs_err(sb, "failed to read extref root 0x%llx", le64_to_cpu(vsb_raw->apfs_extentref_tree_oid));
+		return PTR_ERR(extref_root);
+	}
+	apfs_assert_in_transaction(sb, &vsb_raw->apfs_o);
+	vsb_raw->apfs_extentref_tree_oid = cpu_to_le64(extref_root->object.oid);
+
+	query = apfs_alloc_query(extref_root, NULL /* parent */);
+	if (!query) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * The cached logical extent may have been split into multiple physical
+	 * extents because of clones. If that happens, we want to grow the last
+	 * one.
+	 */
+	last_bno = extent->phys_block_num + blkcnt - 1;
+	apfs_init_extent_key(last_bno, &query->key);
+	query->flags = APFS_QUERY_EXTENTREF;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret && ret != -ENODATA) {
+		apfs_err(sb, "query failed for paddr 0x%llx", last_bno);
+		goto out;
+	}
+
+	if (ret == -ENODATA) {
+		/* This is a fresh new physical extent */
+		ret = apfs_insert_new_phys_extent(query, extent->phys_block_num, blkcnt, dstream->ds_id);
+		if (ret)
+			apfs_err(sb, "insertion failed for paddr 0x%llx", extent->phys_block_num);
+		goto out;
+	}
+
+	ret = apfs_phys_ext_from_query(query, &pext);
+	if (ret) {
+		apfs_err(sb, "bad pext record for bno 0x%llx", last_bno);
+		goto out;
+	}
+	if (pext.bno + pext.blkcount <= extent->phys_block_num) {
+		/* Also a fresh new physical extent */
+		ret = apfs_insert_new_phys_extent(query, extent->phys_block_num, blkcnt, dstream->ds_id);
+		if (ret)
+			apfs_err(sb, "insertion failed for paddr 0x%llx", extent->phys_block_num);
+		goto out;
+	}
+
+	/*
+	 * There is an existing physical extent that overlaps the new one. The
+	 * cache was dirty, so the existing extent can't cover the whole tail.
+	 */
+	if (pext.bno + pext.blkcount >= extent->phys_block_num + blkcnt) {
+		apfs_err(sb, "dirty cache tail covered by existing physical extent 0x%llx-0x%llx", pext.bno, pext.blkcount);
+		ret = -EFSCORRUPTED;
+		goto out;
+	}
+	if (pext.refcnt == 1) {
+		new_base = pext.bno;
+		new_blkcnt = extent->phys_block_num + blkcnt - new_base;
+		ret = apfs_extend_phys_extent(query, new_base, new_blkcnt, dstream->ds_id);
+		if (ret)
+			apfs_err(sb, "update failed for paddr 0x%llx", new_base);
+	} else {
+		/*
+		 * We can't extend this one, because it would extend the other
+		 * references as well.
+		 */
+		new_base = pext.bno + pext.blkcount;
+		new_blkcnt = extent->phys_block_num + blkcnt - new_base;
+		ret = apfs_insert_new_phys_extent(query, new_base, new_blkcnt, dstream->ds_id);
+		if (ret)
+			apfs_err(sb, "insertion failed for paddr 0x%llx", new_base);
+	}
+
+out:
+	apfs_free_query(query);
+	apfs_node_free(extref_root);
+	return ret;
+}
+
+/**
+ * apfs_phys_ext_from_query - Read the physical extent record found by a query
+ * @query:	the (successful) query that found the record
+ * @pext:	on return, the physical extent read
+ *
+ * Reads the physical extent record into @pext and performs some basic sanity
+ * checks as a protection against crafted filesystems. Returns 0 on success or
+ * -EFSCORRUPTED otherwise.
+ */
+static int apfs_phys_ext_from_query(struct apfs_query *query, struct apfs_phys_extent *pext)
+{
+	struct super_block *sb = query->node->object.sb;
+	struct apfs_phys_ext_key *key;
+	struct apfs_phys_ext_val *val;
+	char *raw = query->node->object.data;
+
+	if (query->len != sizeof(*val) || query->key_len != sizeof(*key)) {
+		apfs_err(sb, "bad length of key (%d) or value (%d)", query->key_len, query->len);
+		return -EFSCORRUPTED;
+	}
+
+	key = (struct apfs_phys_ext_key *)(raw + query->key_off);
+	val = (struct apfs_phys_ext_val *)(raw + query->off);
+
+	pext->bno = apfs_cat_cnid(&key->hdr);
+	pext->blkcount = le64_to_cpu(val->len_and_kind) & APFS_PEXT_LEN_MASK;
+	pext->len = pext->blkcount << sb->s_blocksize_bits;
+	pext->refcnt = le32_to_cpu(val->refcnt);
+	pext->kind = le64_to_cpu(val->len_and_kind) >> APFS_PEXT_KIND_SHIFT;
+	return 0;
+}
+
+/**
+ * apfs_free_phys_ext - Add all blocks in a physical extent to the free queue
+ * @sb:		superblock structure
+ * @pext:	physical range to free
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_free_phys_ext(struct super_block *sb, struct apfs_phys_extent *pext)
+{
+	struct apfs_superblock *vsb_raw = APFS_SB(sb)->s_vsb_raw;
+
+	apfs_assert_in_transaction(sb, &vsb_raw->apfs_o);
+	le64_add_cpu(&vsb_raw->apfs_fs_alloc_count, -pext->blkcount);
+	le64_add_cpu(&vsb_raw->apfs_total_blocks_freed, pext->blkcount);
+
+	return apfs_free_queue_insert(sb, pext->bno, pext->blkcount);
+}
+
+/**
+ * apfs_put_phys_extent - Reduce the reference count for a physical extent
+ * @pext:	physical extent data, already read
+ * @query:	query that found the extent
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_put_phys_extent(struct apfs_phys_extent *pext, struct apfs_query *query)
+{
+	struct super_block *sb = query->node->object.sb;
+	struct apfs_phys_ext_val *val;
+	void *raw;
+	int err;
+
+	if (--pext->refcnt == 0) {
+		err = apfs_btree_remove(query);
+		if (err) {
+			apfs_err(sb, "removal failed for paddr 0x%llx", pext->bno);
+			return err;
+		}
+		return pext->kind == APFS_KIND_NEW ? apfs_free_phys_ext(sb, pext) : 0;
+	}
+
+	err = apfs_query_join_transaction(query);
+	if (err) {
+		apfs_err(sb, "query join failed");
+		return err;
+	}
+	raw = query->node->object.data;
+	val = raw + query->off;
+	val->refcnt = cpu_to_le32(pext->refcnt);
+	return 0;
+}
+
+/**
+ * apfs_take_phys_extent - Increase the reference count for a physical extent
+ * @pext:	physical extent data, already read
+ * @query:	query that found the extent
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_take_phys_extent(struct apfs_phys_extent *pext, struct apfs_query *query)
+{
+	struct super_block *sb = query->node->object.sb;
+	struct apfs_phys_ext_val *val;
+	void *raw;
+	int err;
+
+	/* An update extent may be dropped when a reference is taken */
+	if (++pext->refcnt == 0)
+		return apfs_btree_remove(query);
+
+	err = apfs_query_join_transaction(query);
+	if (err) {
+		apfs_err(sb, "query join failed");
+		return err;
+	}
+	raw = query->node->object.data;
+	val = raw + query->off;
+	val->refcnt = cpu_to_le32(pext->refcnt);
+	return 0;
+}
+
+/**
+ * apfs_set_phys_ext_length - Set new length in a physical extent record's value
+ * @pext:	the physical extent record's value
+ * @len:	the new length (in blocks)
+ *
+ * Preserves the kind, though I doubt that's the right thing to do in general.
+ */
+static inline void apfs_set_phys_ext_length(struct apfs_phys_ext_val *pext, u64 len)
+{
+	u64 len_and_kind = le64_to_cpu(pext->len_and_kind);
+	u64 kind = len_and_kind & APFS_PEXT_KIND_MASK;
+
+	pext->len_and_kind = cpu_to_le64(kind | len);
+}
+
+/**
+ * apfs_split_phys_ext - Break a physical extent in two
+ * @query:	query pointing to the extent
+ * @div:	first physical block number to come after the division
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_split_phys_ext(struct apfs_query *query, u64 div)
+{
+	struct super_block *sb = query->node->object.sb;
+	struct apfs_phys_ext_val *val1;
+	struct apfs_phys_ext_key key2;
+	struct apfs_phys_ext_val val2;
+	struct apfs_phys_extent pextent;
+	u64 blkcount1, blkcount2;
+	void *raw;
+	int err = 0;
+
+	err = apfs_query_join_transaction(query);
+	if (err) {
+		apfs_err(sb, "query join failed");
+		return err;
+	}
+	raw = query->node->object.data;
+
+	err = apfs_phys_ext_from_query(query, &pextent);
+	if (err) {
+		apfs_err(sb, "bad pext record over div 0x%llx", div);
+		return err;
+	}
+	val1 = raw + query->off;
+	val2 = *(struct apfs_phys_ext_val *)(raw + query->off);
+	key2 = *(struct apfs_phys_ext_key *)(raw + query->key_off);
+
+	blkcount1 = div - pextent.bno;
+	blkcount2 = pextent.blkcount - blkcount1;
+
+	/* Modify the current extent in place to become the first half */
+	apfs_set_phys_ext_length(val1, blkcount1);
+
+	/* Insert the second half right after the first */
+	apfs_key_set_hdr(APFS_TYPE_EXTENT, div, &key2);
+	apfs_set_phys_ext_length(&val2, blkcount2);
+	return apfs_btree_insert(query, &key2, sizeof(key2), &val2, sizeof(val2));
+}
+
+/**
+ * apfs_create_update_pext - Create a reference update physical extent record
+ * @query:	query that searched for the physical extent
+ * @extent:	range of physical blocks to update
+ * @diff:	reference count change
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_create_update_pext(struct apfs_query *query, const struct apfs_file_extent *extent, u32 diff)
+{
+	struct super_block *sb = query->node->object.sb;
+	struct apfs_phys_ext_key key = {0};
+	struct apfs_phys_ext_val val = {0};
+
+	apfs_key_set_hdr(APFS_TYPE_EXTENT, extent->phys_block_num, &key);
+	val.len_and_kind = cpu_to_le64((u64)APFS_KIND_UPDATE << APFS_PEXT_KIND_SHIFT | extent->len >> sb->s_blocksize_bits);
+	val.owning_obj_id = cpu_to_le64(APFS_OWNING_OBJ_ID_INVALID);
+	val.refcnt = cpu_to_le32(diff);
+	return apfs_btree_insert(query, &key, sizeof(key), &val, sizeof(val));
+}
+
+/**
+ * apfs_dstream_cache_is_tail - Is the tail of this dstream in its extent cache?
+ * @dstream: dstream to check
+ */
+static inline bool apfs_dstream_cache_is_tail(struct apfs_dstream_info *dstream)
+{
+	struct apfs_file_extent *cache = &dstream->ds_cached_ext;
+
+	/* nx_big_sem provides the locking for the cache here */
+	return cache->len && (dstream->ds_size <= cache->logical_addr + cache->len);
+}
+
+/**
+ * apfs_flush_extent_cache - Write the cached extent to the catalog, if dirty
+ * @dstream: data stream to flush
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+int apfs_flush_extent_cache(struct apfs_dstream_info *dstream)
+{
+	struct super_block *sb = dstream->ds_sb;
+	struct apfs_file_extent *ext = &dstream->ds_cached_ext;
+	int err;
+
+	if (!dstream->ds_ext_dirty)
+		return 0;
+	ASSERT(ext->len > 0);
+
+	err = apfs_update_extent(dstream, ext);
+	if (err) {
+		apfs_err(sb, "extent update failed");
+		return err;
+	}
+	err = apfs_insert_phys_extent(dstream, ext);
+	if (err) {
+		apfs_err(sb, "pext insertion failed");
+		return err;
+	}
+
+	/*
+	 * TODO: keep track of the byte and block count through the use of
+	 * inode_add_bytes() and inode_set_bytes(). This hasn't been done with
+	 * care in the rest of the module and it doesn't seem to matter beyond
+	 * stat(), so I'm ignoring it for now.
+	 */
+
+	dstream->ds_ext_dirty = false;
+	return 0;
+}
+#define APFS_FLUSH_EXTENT_CACHE	APFS_UPDATE_EXTENTS_MAXOPS
+
+/**
+ * apfs_create_hole - Create and insert a hole extent for the dstream
+ * @dstream:	data stream info
+ * @start:	first logical block number for the hole
+ * @end:	first logical block number right after the hole
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ * TODO: what happens to the crypto refcount?
+ */
+static int apfs_create_hole(struct apfs_dstream_info *dstream, u64 start, u64 end)
+{
+	struct super_block *sb = dstream->ds_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_query *query;
+	struct apfs_file_extent_key raw_key;
+	struct apfs_file_extent_val raw_val;
+	u64 extent_id = dstream->ds_id;
+	int ret;
+
+	if (start == end)
+		return 0;
+
+	/* File extent records use addresses, not block numbers */
+	start <<= sb->s_blocksize_bits;
+	end <<= sb->s_blocksize_bits;
+
+	apfs_key_set_hdr(APFS_TYPE_FILE_EXTENT, extent_id, &raw_key);
+	raw_key.logical_addr = cpu_to_le64(start);
+	raw_val.len_and_flags = cpu_to_le64(end - start);
+	raw_val.phys_block_num = cpu_to_le64(0); /* It's a hole... */
+	raw_val.crypto_id = cpu_to_le64(apfs_vol_is_encrypted(sb) ? extent_id : 0);
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_file_extent_key(extent_id, start, &query->key);
+	query->flags = APFS_QUERY_CAT;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret && ret != -ENODATA) {
+		apfs_err(sb, "query failed for id 0x%llx, addr 0x%llx", extent_id, start);
+		goto out;
+	}
+
+	ret = apfs_btree_insert(query, &raw_key, sizeof(raw_key), &raw_val, sizeof(raw_val));
+	if (ret)
+		apfs_err(sb, "insertion failed for id 0x%llx, addr 0x%llx", extent_id, start);
+	dstream->ds_sparse_bytes += end - start;
+
+out:
+	apfs_free_query(query);
+	return ret;
+}
+
+/**
+ * apfs_zero_dstream_tail - Zero out stale bytes in a data stream's last block
+ * @dstream: data stream info
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+static int apfs_zero_dstream_tail(struct apfs_dstream_info *dstream)
+{
+	struct super_block *sb = dstream->ds_sb;
+	struct inode *inode = NULL;
+	struct page *page = NULL;
+	void *fsdata = NULL;
+	int valid_length;
+	int err;
+
+	/* No stale bytes if no actual content */
+	if (dstream->ds_size <= dstream->ds_sparse_bytes)
+		return 0;
+
+	/* No stale tail if the last block is fully used */
+	valid_length = dstream->ds_size & (sb->s_blocksize - 1);
+	if (valid_length == 0)
+		return 0;
+
+	inode = dstream->ds_inode;
+	if (!inode) {
+		/* This should never happen, but be safe */
+		apfs_alert(sb, "attempt to zero the tail of xattr dstream 0x%llx", dstream->ds_id);
+		return -EFSCORRUPTED;
+	}
+
+	/* This will take care of the CoW and zeroing */
+	err = __apfs_write_begin(NULL, inode->i_mapping, inode->i_size, 0, 0, &page, &fsdata);
+	if (err)
+		return err;
+	return __apfs_write_end(NULL, inode->i_mapping, inode->i_size, 0, 0, page, fsdata);
+}
+
+/**
+ * apfs_zero_bh_tail - Zero out stale bytes in a buffer head
+ * @sb:		filesystem superblock
+ * @bh:		buffer head to zero
+ * @length:	length of valid bytes to be left alone
+ */
+static void apfs_zero_bh_tail(struct super_block *sb, struct buffer_head *bh, u64 length)
+{
+	ASSERT(buffer_trans(bh));
+	if (length < sb->s_blocksize)
+		memset(bh->b_data + length, 0, sb->s_blocksize - length);
+}
+
+/**
+ * apfs_range_in_snap - Check if a given block range overlaps a snapshot
+ * @sb:		filesystem superblock
+ * @bno:	first block in the range
+ * @blkcnt:	block count for the range
+ * @in_snap:	on return, the result
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+static int apfs_range_in_snap(struct super_block *sb, u64 bno, u64 blkcnt, bool *in_snap)
+{
+	struct apfs_superblock *vsb_raw = APFS_SB(sb)->s_vsb_raw;
+	struct apfs_node *extref_root = NULL;
+	struct apfs_query *query = NULL;
+	struct apfs_phys_extent pext = {0};
+	int ret;
+
+	/* Avoid the tree queries when we don't even have snapshots */
+	if (vsb_raw->apfs_num_snapshots == 0) {
+		*in_snap = false;
+		return 0;
+	}
+
+	/*
+	 * Now check if the current physical extent tree has an entry for
+	 * these blocks
+	 */
+	extref_root = apfs_read_node(sb, le64_to_cpu(vsb_raw->apfs_extentref_tree_oid), APFS_OBJ_PHYSICAL, false /* write */);
+	if (IS_ERR(extref_root)) {
+		apfs_err(sb, "failed to read extref root 0x%llx", le64_to_cpu(vsb_raw->apfs_extentref_tree_oid));
+		return PTR_ERR(extref_root);
+	}
+
+	query = apfs_alloc_query(extref_root, NULL /* parent */);
+	if (!query) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	apfs_init_extent_key(bno, &query->key);
+	query->flags = APFS_QUERY_EXTENTREF;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret && ret != -ENODATA) {
+		apfs_err(sb, "query failed for paddr 0x%llx", bno);
+		goto out;
+	}
+	if (ret == -ENODATA) {
+		*in_snap = false;
+		ret = 0;
+		goto out;
+	}
+
+	ret = apfs_phys_ext_from_query(query, &pext);
+	if (ret) {
+		apfs_err(sb, "bad pext record for paddr 0x%llx", bno);
+		goto out;
+	}
+
+	if (pext.bno <= bno && pext.bno + pext.blkcount >= bno + blkcnt) {
+		if (pext.kind == APFS_KIND_NEW) {
+			*in_snap = false;
+			goto out;
+		}
+	}
+
+	/*
+	 * I think the file extent could still be covered by two different
+	 * physical extents from the current tree, but it's easier to just
+	 * assume the worst here.
+	 */
+	*in_snap = true;
+
+out:
+	apfs_free_query(query);
+	apfs_node_free(extref_root);
+	return ret;
+}
+
+/**
+ * apfs_dstream_cache_in_snap - Check if the cached extent overlaps a snapshot
+ * @dstream:	the data stream to check
+ * @in_snap:	on return, the result
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+static int apfs_dstream_cache_in_snap(struct apfs_dstream_info *dstream, bool *in_snap)
+{
+	struct super_block *sb = dstream->ds_sb;
+	struct apfs_file_extent *cache = NULL;
+
+	/* All changes to extents get flushed when a snaphot is created */
+	if (dstream->ds_ext_dirty) {
+		*in_snap = false;
+		return 0;
+	}
+
+	cache = &dstream->ds_cached_ext;
+	return apfs_range_in_snap(sb, cache->phys_block_num, cache->len >> sb->s_blocksize_bits, in_snap);
+}
+
+/**
+ * apfs_dstream_get_new_block - Like the get_block_t function, but for dstreams
+ * @dstream:	data stream info
+ * @dsblock:	logical dstream block to map
+ * @bh_result:	buffer head to map (NULL if none)
+ * @bno:	if not NULL, the new block number is returned here
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+static int apfs_dstream_get_new_block(struct apfs_dstream_info *dstream, u64 dsblock, struct buffer_head *bh_result, u64 *bno)
+{
+	struct super_block *sb = dstream->ds_sb;
+	struct apfs_superblock *vsb_raw = APFS_SB(sb)->s_vsb_raw;
+	struct apfs_file_extent *cache = NULL;
+	u64 phys_bno, logical_addr, cache_blks, dstream_blks;
+	bool in_snap = true;
+	int err;
+
+	/* TODO: preallocate tail blocks */
+	logical_addr = dsblock << sb->s_blocksize_bits;
+
+	err = apfs_spaceman_allocate_block(sb, &phys_bno, false /* backwards */);
+	if (err) {
+		apfs_err(sb, "block allocation failed");
+		return err;
+	}
+	apfs_assert_in_transaction(sb, &vsb_raw->apfs_o);
+	le64_add_cpu(&vsb_raw->apfs_fs_alloc_count, 1);
+	le64_add_cpu(&vsb_raw->apfs_total_blocks_alloced, 1);
+	if (bno)
+		*bno = phys_bno;
+
+	if (bh_result) {
+		apfs_map_bh(bh_result, sb, phys_bno);
+		err = apfs_transaction_join(sb, bh_result);
+		if (err)
+			return err;
+
+		if (!buffer_uptodate(bh_result)) {
+			/*
+			 * Truly new buffers need to be marked as such, to get
+			 * zeroed; this also takes care of holes in sparse files
+			 */
+			set_buffer_new(bh_result);
+		} else if (dstream->ds_size > logical_addr) {
+			/*
+			 * The last block may have stale data left from a
+			 * truncation
+			 */
+			apfs_zero_bh_tail(sb, bh_result, dstream->ds_size - logical_addr);
+		}
+	}
+
+	dstream_blks = apfs_size_to_blocks(sb, dstream->ds_size);
+	if (dstream_blks < dsblock) {
+		/*
+		 * This recurses into apfs_dstream_get_new_block() and dirties
+		 * the extent cache, so it must happen before flushing it.
+		 */
+		err = apfs_zero_dstream_tail(dstream);
+		if (err) {
+			apfs_err(sb, "failed to zero tail for dstream 0x%llx", dstream->ds_id);
+			return err;
+		}
+	}
+
+	err = apfs_dstream_cache_in_snap(dstream, &in_snap);
+	if (err)
+		return err;
+
+	cache = &dstream->ds_cached_ext;
+	cache_blks = apfs_size_to_blocks(sb, cache->len);
+
+	/* TODO: allow dirty caches of several blocks in the middle of a file */
+	if (!in_snap && apfs_dstream_cache_is_tail(dstream) &&
+	    logical_addr == cache->logical_addr + cache->len &&
+	    phys_bno == cache->phys_block_num + cache_blks) {
+		cache->len += sb->s_blocksize;
+		dstream->ds_ext_dirty = true;
+		return 0;
+	}
+
+	err = apfs_flush_extent_cache(dstream);
+	if (err) {
+		apfs_err(sb, "extent cache flush failed for dstream 0x%llx", dstream->ds_id);
+		return err;
+	}
+
+	if (dstream_blks < dsblock) {
+		/*
+		 * This puts new extents after the reported end of the file, so
+		 * it must happen after the flush to avoid conflict with those
+		 * extent operations.
+		 */
+		err = apfs_create_hole(dstream, dstream_blks, dsblock);
+		if (err) {
+			apfs_err(sb, "hole creation failed for dstream 0x%llx", dstream->ds_id);
+			return err;
+		}
+	}
+
+	cache->logical_addr = logical_addr;
+	cache->phys_block_num = phys_bno;
+	cache->len = sb->s_blocksize;
+	dstream->ds_ext_dirty = true;
+	return 0;
+}
+int APFS_GET_NEW_BLOCK_MAXOPS(void)
+{
+	return APFS_FLUSH_EXTENT_CACHE;
+}
+
+/**
+ * apfs_dstream_get_new_bno - Allocate a new block inside a dstream
+ * @dstream:	data stream info
+ * @dsblock:	logical dstream block to allocate
+ * @bno:	on return, the new block number
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+int apfs_dstream_get_new_bno(struct apfs_dstream_info *dstream, u64 dsblock, u64 *bno)
+{
+	return apfs_dstream_get_new_block(dstream, dsblock, NULL /* bh_result */, bno);
+}
+
+int apfs_get_new_block(struct inode *inode, sector_t iblock,
+		       struct buffer_head *bh_result, int create)
+{
+	struct apfs_inode_info *ai = APFS_I(inode);
+
+	ASSERT(create);
+	return apfs_dstream_get_new_block(&ai->i_dstream, iblock, bh_result, NULL /* bno */);
+}
+
+/**
+ * apfs_shrink_dstream_last_extent - Shrink last extent of dstream being resized
+ * @dstream:	data stream info
+ * @new_size:	new size for the whole data stream
+ *
+ * Deletes, shrinks or zeroes the last extent, as needed for the truncation of
+ * the data stream.
+ *
+ * Only works with the last extent, so it needs to be called repeatedly to
+ * complete the truncation. Returns -EAGAIN in that case, or 0 when the process
+ * is complete. Returns other negative error codes in case of failure.
+ */
+static int apfs_shrink_dstream_last_extent(struct apfs_dstream_info *dstream, loff_t new_size)
+{
+	struct super_block *sb = dstream->ds_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_query *query;
+	struct apfs_file_extent tail;
+	u64 extent_id = dstream->ds_id;
+	int ret = 0;
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_file_extent_key(extent_id, -1, &query->key);
+	query->flags = APFS_QUERY_CAT;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret && ret != -ENODATA) {
+		apfs_err(sb, "query failed for last extent of id 0x%llx", extent_id);
+		goto out;
+	}
+
+	if (!apfs_query_found_extent(query)) {
+		/* No more extents, we deleted the whole file already? */
+		if (new_size) {
+			apfs_err(sb, "missing extent for dstream 0x%llx", extent_id);
+			ret = -EFSCORRUPTED;
+		} else {
+			ret = 0;
+		}
+		goto out;
+	}
+
+	ret = apfs_extent_from_query(query, &tail);
+	if (ret) {
+		apfs_err(sb, "bad tail extent record on dstream 0x%llx", extent_id);
+		goto out;
+	}
+
+	if (tail.logical_addr + tail.len < new_size) {
+		apfs_err(sb, "missing extent for dstream 0x%llx", extent_id);
+		ret = -EFSCORRUPTED; /* Tail extent missing */
+	} else if (tail.logical_addr + tail.len == new_size) {
+		ret = 0; /* Nothing more to be done */
+	} else if (tail.logical_addr >= new_size) {
+		/* This whole extent needs to go */
+		ret = apfs_btree_remove(query);
+		if (ret) {
+			apfs_err(sb, "removal failed for id 0x%llx, addr 0x%llx", dstream->ds_id, tail.logical_addr);
+			goto out;
+		}
+		if (apfs_ext_is_hole(&tail)) {
+			dstream->ds_sparse_bytes -= tail.len;
+		} else {
+			ret = apfs_range_put_reference(sb, tail.phys_block_num, tail.len);
+			if (ret) {
+				apfs_err(sb, "failed to put range 0x%llx-0x%llx", tail.phys_block_num, tail.len);
+				goto out;
+			}
+		}
+		ret = apfs_crypto_adj_refcnt(sb, tail.crypto_id, -1);
+		if (ret) {
+			apfs_err(sb, "failed to take crypto id 0x%llx", tail.crypto_id);
+			goto out;
+		}
+		ret = tail.logical_addr == new_size ? 0 : -EAGAIN;
+	} else {
+		/*
+		 * The file is being truncated in the middle of this extent.
+		 * TODO: preserve the physical tail to be overwritten later.
+		 */
+		new_size = apfs_size_to_blocks(sb, new_size) << sb->s_blocksize_bits;
+		ret = apfs_shrink_extent_tail(query, dstream, new_size);
+		if (ret)
+			apfs_err(sb, "failed to shrink tail of dstream 0x%llx", extent_id);
+	}
+
+out:
+	apfs_free_query(query);
+	return ret;
+}
+
+/**
+ * apfs_shrink_dstream - Shrink a data stream's extents to a new length
+ * @dstream:	data stream info
+ * @new_size:	the new size
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+static int apfs_shrink_dstream(struct apfs_dstream_info *dstream, loff_t new_size)
+{
+	int ret;
+
+	do {
+		ret = apfs_shrink_dstream_last_extent(dstream, new_size);
+	} while (ret == -EAGAIN);
+
+	return ret;
+}
+
+/**
+ * apfs_truncate - Truncate a data stream's content
+ * @dstream:	data stream info
+ * @new_size:	the new size
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+int apfs_truncate(struct apfs_dstream_info *dstream, loff_t new_size)
+{
+	struct super_block *sb = dstream->ds_sb;
+	u64 old_blks, new_blks;
+	struct apfs_file_extent *cache = &dstream->ds_cached_ext;
+	int err;
+
+	/* TODO: don't write the cached extent if it will be deleted */
+	err = apfs_flush_extent_cache(dstream);
+	if (err) {
+		apfs_err(sb, "extent cache flush failed for dstream 0x%llx", dstream->ds_id);
+		return err;
+	}
+	dstream->ds_ext_dirty = false;
+
+	/* TODO: keep the cache valid on truncation */
+	cache->len = 0;
+
+	/* "<=", because a partial write may have left extents beyond the end */
+	if (new_size <= dstream->ds_size)
+		return apfs_shrink_dstream(dstream, new_size);
+
+	err = apfs_zero_dstream_tail(dstream);
+	if (err) {
+		apfs_err(sb, "failed to zero tail for dstream 0x%llx", dstream->ds_id);
+		return err;
+	}
+	new_blks = apfs_size_to_blocks(sb, new_size);
+	old_blks = apfs_size_to_blocks(sb, dstream->ds_size);
+	return apfs_create_hole(dstream, old_blks, new_blks);
+}
+
+/**
+ * apfs_dstream_delete_front - Deletes as many leading extents as possible
+ * @sb:		filesystem superblock
+ * @ds_id:	id for the dstream to delete
+ *
+ * Returns 0 on success, or a negative error code in case of failure, which may
+ * be -ENODATA if there are no more extents, or -EAGAIN if the free queue is
+ * getting too full.
+ */
+static int apfs_dstream_delete_front(struct super_block *sb, u64 ds_id)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_spaceman *sm = APFS_SM(sb);
+	struct apfs_spaceman_phys *sm_raw = sm->sm_raw;
+	struct apfs_spaceman_free_queue *fq = NULL;
+	struct apfs_query *query = NULL;
+	struct apfs_file_extent head;
+	bool first_match = true;
+	int ret;
+
+	fq = &sm_raw->sm_fq[APFS_SFQ_MAIN];
+	if (le64_to_cpu(fq->sfq_count) > APFS_TRANS_MAIN_QUEUE_MAX)
+		return -EAGAIN;
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_file_extent_key(ds_id, 0, &query->key);
+	query->flags = APFS_QUERY_CAT;
+
+next_extent:
+	ret = apfs_btree_query(sb, &query);
+	if (ret && ret != -ENODATA) {
+		apfs_err(sb, "query failed for first extent of id 0x%llx", ds_id);
+		goto out;
+	}
+	apfs_query_direct_forward(query);
+	if (!apfs_query_found_extent(query)) {
+		/*
+		 * After the original lookup, the query may not be set to the
+		 * first extent, but instead to the record that comes right
+		 * before.
+		 */
+		if (first_match) {
+			first_match = false;
+			goto next_extent;
+		}
+		ret = -ENODATA;
+		goto out;
+	}
+	first_match = false;
+
+	ret = apfs_extent_from_query(query, &head);
+	if (ret) {
+		apfs_err(sb, "bad head extent record on dstream 0x%llx", ds_id);
+		goto out;
+	}
+	ret = apfs_btree_remove(query);
+	if (ret) {
+		apfs_err(sb, "removal failed for id 0x%llx, addr 0x%llx", ds_id, head.logical_addr);
+		goto out;
+	}
+
+	/*
+	 * The official fsck doesn't complain about wrong sparse byte counts
+	 * for orphans, so I guess we don't need to update them here
+	 */
+	if (!apfs_ext_is_hole(&head)) {
+		ret = apfs_range_put_reference(sb, head.phys_block_num, head.len);
+		if (ret) {
+			apfs_err(sb, "failed to put range 0x%llx-0x%llx", head.phys_block_num, head.len);
+			goto out;
+		}
+		ret = apfs_crypto_adj_refcnt(sb, head.crypto_id, -1);
+		if (ret) {
+			apfs_err(sb, "failed to take crypto id 0x%llx", head.crypto_id);
+			goto out;
+		}
+	}
+
+	if (le64_to_cpu(fq->sfq_count) <= APFS_TRANS_MAIN_QUEUE_MAX)
+		goto next_extent;
+	ret = -EAGAIN;
+out:
+	apfs_free_query(query);
+	return ret;
+}
+
+/**
+ * apfs_inode_delete_front - Deletes as many leading extents as possible
+ * @inode:	inode to delete
+ *
+ * Tries to delete all extents for @inode, in which case it returns 0. If the
+ * free queue is getting too full, deletes as much as is reasonable and returns
+ * -EAGAIN. May return other negative error codes as well.
+ */
+int apfs_inode_delete_front(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+	struct apfs_dstream_info *dstream = NULL;
+	struct apfs_inode_info *ai = APFS_I(inode);
+	int ret;
+
+	if (!ai->i_has_dstream)
+		return 0;
+
+	dstream = &ai->i_dstream;
+	ret = apfs_flush_extent_cache(dstream);
+	if (ret) {
+		apfs_err(sb, "extent cache flush failed for dstream 0x%llx", dstream->ds_id);
+		return ret;
+	}
+
+	ret = apfs_dstream_delete_front(sb, dstream->ds_id);
+	if (ret == -ENODATA)
+		return 0;
+	return ret;
+}
+
+loff_t apfs_remap_file_range(struct file *src_file, loff_t off, struct file *dst_file, loff_t destoff, loff_t len, unsigned int remap_flags)
+{
+	struct inode *src_inode = file_inode(src_file);
+	struct inode *dst_inode = file_inode(dst_file);
+	struct apfs_inode_info *src_ai = APFS_I(src_inode);
+	struct apfs_inode_info *dst_ai = APFS_I(dst_inode);
+	struct apfs_dstream_info *src_ds = &src_ai->i_dstream;
+	struct apfs_dstream_info *dst_ds = &dst_ai->i_dstream;
+	struct super_block *sb = src_inode->i_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	/* TODO: remember to update the maxops in the future */
+	struct apfs_max_ops maxops = {0};
+	const u64 xfield_flags = APFS_INODE_MAINTAIN_DIR_STATS | APFS_INODE_IS_SPARSE | APFS_INODE_HAS_PURGEABLE_FLAGS;
+	int err;
+
+	if (remap_flags & ~(REMAP_FILE_ADVISORY))
+		return -EINVAL;
+	if (src_inode == dst_inode)
+		return -EINVAL;
+
+	/* We only want to clone whole files, like in the official driver */
+	if (off != 0 || destoff != 0 || len != 0)
+		return -EINVAL;
+
+	/*
+	 * Clones here work in two steps: first the user creates an empty target
+	 * file, and then the user calls the ioctl, which replaces the file with
+	 * a clone. This is not atomic, of course.
+	 */
+	if (dst_ai->i_has_dstream || dst_ai->i_bsd_flags & APFS_INOBSD_COMPRESSED) {
+		apfs_warn(sb, "clones can only replace freshly created files");
+		return -EOPNOTSUPP;
+	}
+	if (dst_ai->i_int_flags & xfield_flags) {
+		apfs_warn(sb, "clone can't replace a file that has xfields");
+		return -EOPNOTSUPP;
+	}
+
+	if (!src_ai->i_has_dstream) {
+		apfs_warn(sb, "can't clone a file with no dstream");
+		return -EOPNOTSUPP;
+	}
+
+	err = apfs_transaction_start(sb, maxops);
+	if (err)
+		return err;
+	apfs_inode_join_transaction(sb, src_inode);
+	apfs_inode_join_transaction(sb, dst_inode);
+
+	err = apfs_flush_extent_cache(src_ds);
+	if (err) {
+		apfs_err(sb, "extent cache flush failed for dstream 0x%llx", src_ds->ds_id);
+		goto fail;
+	}
+	err = apfs_dstream_adj_refcnt(src_ds, +1);
+	if (err) {
+		apfs_err(sb, "failed to take dstream id 0x%llx", src_ds->ds_id);
+		goto fail;
+	}
+	src_ds->ds_shared = true;
+
+	inode_set_mtime_to_ts(dst_inode, inode_set_ctime_current(dst_inode));
+	dst_inode->i_size = src_inode->i_size;
+	dst_ai->i_key_class = src_ai->i_key_class;
+	dst_ai->i_int_flags = src_ai->i_int_flags;
+	dst_ai->i_bsd_flags = src_ai->i_bsd_flags;
+	dst_ai->i_has_dstream = true;
+
+	dst_ds->ds_sb = src_ds->ds_sb;
+	dst_ds->ds_inode = dst_inode;
+	dst_ds->ds_id = src_ds->ds_id;
+	dst_ds->ds_size = src_ds->ds_size;
+	dst_ds->ds_sparse_bytes = src_ds->ds_sparse_bytes;
+	dst_ds->ds_cached_ext = src_ds->ds_cached_ext;
+	dst_ds->ds_ext_dirty = false;
+	dst_ds->ds_shared = true;
+
+	dst_ai->i_int_flags |= APFS_INODE_WAS_EVER_CLONED | APFS_INODE_WAS_CLONED;
+	src_ai->i_int_flags |= APFS_INODE_WAS_EVER_CLONED;
+
+	/*
+	 * The sparse flag is the important one here: if we need it, it will get
+	 * set later by apfs_update_inode(), after the xfield gets created.
+	 */
+	dst_ai->i_int_flags &= ~xfield_flags;
+
+	/*
+	 * Commit the transaction to make sure all buffers in the source inode
+	 * go through copy-on-write. This is a bit excessive, but I don't expect
+	 * clones to be created often enough for it to matter.
+	 */
+	sbi->s_nxi->nx_transaction.t_state |= APFS_NX_TRANS_FORCE_COMMIT;
+	err = apfs_transaction_commit(sb);
+	if (err)
+		goto fail;
+	return dst_ds->ds_size;
+
+fail:
+	apfs_transaction_abort(sb);
+	return err;
+}
+
+/**
+ * apfs_extent_create_record - Create a logical extent record for a dstream id
+ * @sb:		filesystem superblock
+ * @dstream_id:	the dstream id
+ * @extent:	extent info for the record
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+static int apfs_extent_create_record(struct super_block *sb, u64 dstream_id, struct apfs_file_extent *extent)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_query *query = NULL;
+	struct apfs_file_extent_val raw_val;
+	struct apfs_file_extent_key raw_key;
+	int ret = 0;
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_file_extent_key(dstream_id, extent->logical_addr, &query->key);
+	query->flags = APFS_QUERY_CAT | APFS_QUERY_EXACT;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret && ret != -ENODATA) {
+		apfs_err(sb, "query failed for id 0x%llx, addr 0x%llx", dstream_id, extent->logical_addr);
+		goto out;
+	}
+
+	apfs_key_set_hdr(APFS_TYPE_FILE_EXTENT, dstream_id, &raw_key);
+	raw_key.logical_addr = cpu_to_le64(extent->logical_addr);
+	raw_val.len_and_flags = cpu_to_le64(extent->len);
+	raw_val.phys_block_num = cpu_to_le64(extent->phys_block_num);
+	raw_val.crypto_id = cpu_to_le64(apfs_vol_is_encrypted(sb) ? dstream_id : 0); /* TODO */
+
+	ret = apfs_btree_insert(query, &raw_key, sizeof(raw_key), &raw_val, sizeof(raw_val));
+	if (ret)
+		apfs_err(sb, "insertion failed for id 0x%llx, addr 0x%llx", dstream_id, extent->logical_addr);
+out:
+	apfs_free_query(query);
+	return ret;
+}
+
+/**
+ * apfs_put_single_extent - Put a reference to a single extent
+ * @sb:		filesystem superblock
+ * @paddr_end:	first block after the extent to put
+ * @paddr_min:	don't put references before this block
+ *
+ * Puts a reference to the physical extent range that ends in @paddr_end. Sets
+ * @paddr_end to the beginning of the extent, so that the caller can continue
+ * with the previous one. Returns 0 on success, or a negative error code in
+ * case of failure.
+ *
+ * TODO: unify this with apfs_take_single_extent(), they are almost the same.
+ */
+static int apfs_put_single_extent(struct super_block *sb, u64 *paddr_end, u64 paddr_min)
+{
+	struct apfs_superblock *vsb_raw = APFS_SB(sb)->s_vsb_raw;
+	struct apfs_node *extref_root = NULL;
+	struct apfs_key key;
+	struct apfs_query *query = NULL;
+	struct apfs_phys_extent prev_ext;
+	u64 prev_start, prev_end;
+	bool cropped_head = false, cropped_tail = false;
+	struct apfs_file_extent tmp = {0}; /* TODO: clean up all the fake extent interfaces? */
+	int ret;
+
+	extref_root = apfs_read_node(sb, le64_to_cpu(vsb_raw->apfs_extentref_tree_oid), APFS_OBJ_PHYSICAL, true /* write */);
+	if (IS_ERR(extref_root)) {
+		apfs_err(sb, "failed to read extref root 0x%llx", le64_to_cpu(vsb_raw->apfs_extentref_tree_oid));
+		return PTR_ERR(extref_root);
+	}
+	apfs_assert_in_transaction(sb, &vsb_raw->apfs_o);
+	vsb_raw->apfs_extentref_tree_oid = cpu_to_le64(extref_root->object.oid);
+
+	apfs_init_extent_key(*paddr_end - 1, &key);
+
+restart:
+	query = apfs_alloc_query(extref_root, NULL /* parent */);
+	if (!query) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	query->key = key;
+	query->flags = APFS_QUERY_EXTENTREF;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret && ret != -ENODATA) {
+		apfs_err(sb, "query failed for paddr 0x%llx", *paddr_end - 1);
+		goto out;
+	}
+
+	if (ret == -ENODATA) {
+		/* The whole range to put is part of a snapshot */
+		tmp.phys_block_num = paddr_min;
+		tmp.len = (*paddr_end - paddr_min) << sb->s_blocksize_bits;
+		ret = apfs_create_update_pext(query, &tmp, -1);
+		*paddr_end = paddr_min;
+		goto out;
+	}
+
+	ret = apfs_phys_ext_from_query(query, &prev_ext);
+	if (ret) {
+		apfs_err(sb, "bad pext record over paddr 0x%llx", *paddr_end - 1);
+		goto out;
+	}
+	prev_start = prev_ext.bno;
+	prev_end = prev_ext.bno + prev_ext.blkcount;
+	if (prev_end < *paddr_end) {
+		/* The extent to put is part of a snapshot */
+		tmp.phys_block_num = max(prev_end, paddr_min);
+		tmp.len = (*paddr_end - tmp.phys_block_num) << sb->s_blocksize_bits;
+		ret = apfs_create_update_pext(query, &tmp, -1);
+		*paddr_end = tmp.phys_block_num;
+		goto out;
+	}
+
+	if ((cropped_tail && prev_end > *paddr_end) || (cropped_head && prev_start < paddr_min)) {
+		/* This should never happen, but be safe */
+		apfs_alert(sb, "recursion cropping physical extent 0x%llx-0x%llx", prev_start, prev_end);
+		ret = -EFSCORRUPTED;
+		goto out;
+	}
+
+	if (prev_end > *paddr_end) {
+		ret = apfs_split_phys_ext(query, *paddr_end);
+		if (ret) {
+			apfs_err(sb, "failed to split pext at 0x%llx", *paddr_end);
+			goto out;
+		}
+		/* The split may make the query invalid */
+		apfs_free_query(query);
+		cropped_tail = true;
+		goto restart;
+	}
+
+	if (prev_start < paddr_min) {
+		ret = apfs_split_phys_ext(query, paddr_min);
+		if (ret) {
+			apfs_err(sb, "failed to split pext at 0x%llx", paddr_min);
+			goto out;
+		}
+		/* The split may make the query invalid */
+		apfs_free_query(query);
+		cropped_head = true;
+		goto restart;
+	}
+
+	/* The extent to put already exists */
+	ret = apfs_put_phys_extent(&prev_ext, query);
+	if (ret)
+		apfs_err(sb, "failed to put pext at 0x%llx", prev_ext.bno);
+	*paddr_end = prev_start;
+
+out:
+	apfs_free_query(query);
+	apfs_node_free(extref_root);
+	return ret;
+}
+
+/**
+ * apfs_range_put_reference - Put a reference to a physical range
+ * @sb:		filesystem superblock
+ * @paddr:	first block of the range
+ * @length:	length of the range (in bytes)
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+static int apfs_range_put_reference(struct super_block *sb, u64 paddr, u64 length)
+{
+	u64 extent_end;
+	int err;
+
+	ASSERT(paddr);
+
+	extent_end = paddr + (length >> sb->s_blocksize_bits);
+	while (extent_end > paddr) {
+		err = apfs_put_single_extent(sb, &extent_end, paddr);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+/**
+ * apfs_take_single_extent - Take a reference to a single extent
+ * @sb:		filesystem superblock
+ * @paddr_end:	first block after the extent to take
+ * @paddr_min:	don't take references before this block
+ *
+ * Takes a reference to the physical extent range that ends in @paddr_end. Sets
+ * @paddr_end to the beginning of the extent, so that the caller can continue
+ * with the previous one. Returns 0 on success, or a negative error code in
+ * case of failure.
+ */
+static int apfs_take_single_extent(struct super_block *sb, u64 *paddr_end, u64 paddr_min)
+{
+	struct apfs_superblock *vsb_raw = APFS_SB(sb)->s_vsb_raw;
+	struct apfs_node *extref_root = NULL;
+	struct apfs_key key;
+	struct apfs_query *query = NULL;
+	struct apfs_phys_extent prev_ext;
+	u64 prev_start, prev_end;
+	bool cropped_head = false, cropped_tail = false;
+	struct apfs_file_extent tmp = {0}; /* TODO: clean up all the fake extent interfaces? */
+	int ret;
+
+	extref_root = apfs_read_node(sb, le64_to_cpu(vsb_raw->apfs_extentref_tree_oid), APFS_OBJ_PHYSICAL, true /* write */);
+	if (IS_ERR(extref_root)) {
+		apfs_err(sb, "failed to read extref root 0x%llx", le64_to_cpu(vsb_raw->apfs_extentref_tree_oid));
+		return PTR_ERR(extref_root);
+	}
+	apfs_assert_in_transaction(sb, &vsb_raw->apfs_o);
+	vsb_raw->apfs_extentref_tree_oid = cpu_to_le64(extref_root->object.oid);
+
+	apfs_init_extent_key(*paddr_end - 1, &key);
+
+restart:
+	query = apfs_alloc_query(extref_root, NULL /* parent */);
+	if (!query) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	query->key = key;
+	query->flags = APFS_QUERY_EXTENTREF;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret && ret != -ENODATA) {
+		apfs_err(sb, "query failed for paddr 0x%llx", *paddr_end - 1);
+		goto out;
+	}
+
+	if (ret == -ENODATA) {
+		/* The whole range to take is part of a snapshot */
+		tmp.phys_block_num = paddr_min;
+		tmp.len = (*paddr_end - paddr_min) << sb->s_blocksize_bits;
+		ret = apfs_create_update_pext(query, &tmp, +1);
+		*paddr_end = paddr_min;
+		goto out;
+	}
+
+	ret = apfs_phys_ext_from_query(query, &prev_ext);
+	if (ret) {
+		apfs_err(sb, "bad pext record over paddr 0x%llx", *paddr_end - 1);
+		goto out;
+	}
+	prev_start = prev_ext.bno;
+	prev_end = prev_ext.bno + prev_ext.blkcount;
+	if (prev_end < *paddr_end) {
+		/* The extent to take is part of a snapshot */
+		tmp.phys_block_num = max(prev_end, paddr_min);
+		tmp.len = (*paddr_end - tmp.phys_block_num) << sb->s_blocksize_bits;
+		ret = apfs_create_update_pext(query, &tmp, +1);
+		*paddr_end = tmp.phys_block_num;
+		goto out;
+	}
+
+	if ((cropped_tail && prev_end > *paddr_end) || (cropped_head && prev_start < paddr_min)) {
+		/* This should never happen, but be safe */
+		apfs_alert(sb, "recursion cropping physical extent 0x%llx-0x%llx", prev_start, prev_end);
+		ret = -EFSCORRUPTED;
+		goto out;
+	}
+
+	if (prev_end > *paddr_end) {
+		ret = apfs_split_phys_ext(query, *paddr_end);
+		if (ret) {
+			apfs_err(sb, "failed to split pext at 0x%llx", *paddr_end);
+			goto out;
+		}
+		/* The split may make the query invalid */
+		apfs_free_query(query);
+		cropped_tail = true;
+		goto restart;
+	}
+
+	if (prev_start < paddr_min) {
+		ret = apfs_split_phys_ext(query, paddr_min);
+		if (ret) {
+			apfs_err(sb, "failed to split pext at 0x%llx", paddr_min);
+			goto out;
+		}
+		/* The split may make the query invalid */
+		apfs_free_query(query);
+		cropped_head = true;
+		goto restart;
+	}
+
+	/* The extent to take already exists */
+	ret = apfs_take_phys_extent(&prev_ext, query);
+	if (ret)
+		apfs_err(sb, "failed to take pext at 0x%llx", prev_ext.bno);
+	*paddr_end = prev_start;
+
+out:
+	apfs_free_query(query);
+	apfs_node_free(extref_root);
+	return ret;
+}
+
+/**
+ * apfs_range_take_reference - Take a reference to a physical range
+ * @sb:		filesystem superblock
+ * @paddr:	first block of the range
+ * @length:	length of the range (in bytes)
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+static int apfs_range_take_reference(struct super_block *sb, u64 paddr, u64 length)
+{
+	u64 extent_end;
+	int err;
+
+	ASSERT(paddr);
+
+	extent_end = paddr + (length >> sb->s_blocksize_bits);
+	while (extent_end > paddr) {
+		err = apfs_take_single_extent(sb, &extent_end, paddr);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+/**
+ * apfs_clone_single_extent - Make a copy of an extent in a dstream to a new one
+ * @dstream:	old dstream
+ * @new_id:	id of the new dstream
+ * @log_addr:	logical address for the extent
+ *
+ * Duplicates the logical extent, and updates the references to the physical
+ * extents as required. Sets @addr to the end of the extent, so that the caller
+ * can continue in the same place. Returns 0 on success, or a negative error
+ * code in case of failure.
+ */
+static int apfs_clone_single_extent(struct apfs_dstream_info *dstream, u64 new_id, u64 *log_addr)
+{
+	struct super_block *sb = dstream->ds_sb;
+	struct apfs_file_extent extent;
+	int err;
+
+	err = apfs_extent_read(dstream, *log_addr >> sb->s_blocksize_bits, &extent);
+	if (err) {
+		apfs_err(sb, "failed to read an extent to clone for dstream 0x%llx", dstream->ds_id);
+		return err;
+	}
+	err = apfs_extent_create_record(sb, new_id, &extent);
+	if (err) {
+		apfs_err(sb, "failed to create extent record for clone of dstream 0x%llx", dstream->ds_id);
+		return err;
+	}
+
+	if (!apfs_ext_is_hole(&extent)) {
+		err = apfs_range_take_reference(sb, extent.phys_block_num, extent.len);
+		if (err) {
+			apfs_err(sb, "failed to take a reference to physical range 0x%llx-0x%llx", extent.phys_block_num, extent.len);
+			return err;
+		}
+	}
+
+	*log_addr += extent.len;
+	return 0;
+}
+
+/**
+ * apfs_clone_extents - Make a copy of all extents in a dstream to a new one
+ * @dstream:	old dstream
+ * @new_id:	id for the new dstream
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+int apfs_clone_extents(struct apfs_dstream_info *dstream, u64 new_id)
+{
+	u64 next = 0;
+	int err;
+
+	while (next < dstream->ds_size) {
+		err = apfs_clone_single_extent(dstream, new_id, &next);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+/**
+ * apfs_nonsparse_dstream_read - Read from a dstream without holes
+ * @dstream:	dstream to read
+ * @buf:	destination buffer
+ * @count:	exact number of bytes to read
+ * @offset:	dstream offset to read from
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+int apfs_nonsparse_dstream_read(struct apfs_dstream_info *dstream, void *buf, size_t count, u64 offset)
+{
+	struct super_block *sb = dstream->ds_sb;
+	u64 logical_start_block, logical_end_block, log_bno, blkcnt, idx;
+	struct buffer_head **bhs = NULL;
+	int ret = 0;
+
+	/* Save myself from thinking about overflow here */
+	if (count >= APFS_MAX_FILE_SIZE || offset >= APFS_MAX_FILE_SIZE) {
+		apfs_err(sb, "dstream read overflow (0x%llx-0x%llx)", offset, (unsigned long long)count);
+		return -EFBIG;
+	}
+
+	if (offset + count > dstream->ds_size) {
+		apfs_err(sb, "reading past the end (0x%llx-0x%llx)", offset, (unsigned long long)count);
+		/* No caller is expected to legitimately read out-of-bounds */
+		return -EFSCORRUPTED;
+	}
+
+	logical_start_block = offset >> sb->s_blocksize_bits;
+	logical_end_block = (offset + count + sb->s_blocksize - 1) >> sb->s_blocksize_bits;
+	blkcnt = logical_end_block - logical_start_block;
+	bhs = kcalloc(blkcnt, sizeof(*bhs), GFP_KERNEL);
+	if (!bhs)
+		return -ENOMEM;
+
+	for (log_bno = logical_start_block; log_bno < logical_end_block; log_bno++) {
+		struct buffer_head *bh = NULL;
+		u64 bno = 0;
+
+		idx = log_bno - logical_start_block;
+
+		ret = apfs_logic_to_phys_bno(dstream, log_bno, &bno);
+		if (ret)
+			goto out;
+		if (bno == 0) {
+			apfs_err(sb, "nonsparse dstream has a hole");
+			ret = -EFSCORRUPTED;
+			goto out;
+		}
+
+		bhs[idx] = __apfs_getblk(sb, bno);
+		if (!bhs[idx]) {
+			apfs_err(sb, "failed to map block 0x%llx", bno);
+			ret = -EIO;
+			goto out;
+		}
+
+		bh = bhs[idx];
+		if (!buffer_uptodate(bh)) {
+			get_bh(bh);
+			lock_buffer(bh);
+			bh->b_end_io = end_buffer_read_sync;
+			apfs_submit_bh(REQ_OP_READ, 0, bh);
+		}
+	}
+
+	for (log_bno = logical_start_block; log_bno < logical_end_block; log_bno++) {
+		int off_in_block, left_in_block;
+
+		idx = log_bno - logical_start_block;
+		wait_on_buffer(bhs[idx]);
+		if (!buffer_uptodate(bhs[idx])) {
+			apfs_err(sb, "failed to read a block");
+			ret = -EIO;
+			goto out;
+		}
+
+		if (log_bno == logical_start_block)
+			off_in_block = offset & (sb->s_blocksize - 1);
+		else
+			off_in_block = 0;
+
+		if (log_bno == logical_end_block - 1)
+			left_in_block = count + offset - (log_bno << sb->s_blocksize_bits) - off_in_block;
+		else
+			left_in_block = sb->s_blocksize - off_in_block;
+
+		memcpy(buf, bhs[idx]->b_data + off_in_block, left_in_block);
+		buf += left_in_block;
+	}
+
+out:
+	if (bhs) {
+		for (idx = 0; idx < blkcnt; idx++)
+			brelse(bhs[idx]);
+		kfree(bhs);
+	}
+	return ret;
+}
+
+/**
+ * apfs_nonsparse_dstream_preread - Attempt to preread a dstream without holes
+ * @dstream:	dstream to preread
+ *
+ * Requests reads for all blocks of a dstream, but doesn't wait for the result.
+ */
+void apfs_nonsparse_dstream_preread(struct apfs_dstream_info *dstream)
+{
+	struct super_block *sb = dstream->ds_sb;
+	u64 logical_end_block, log_bno;
+
+	logical_end_block = (dstream->ds_size + sb->s_blocksize - 1) >> sb->s_blocksize_bits;
+
+	for (log_bno = 0; log_bno < logical_end_block; log_bno++) {
+		struct buffer_head *bh = NULL;
+		u64 bno = 0;
+		int ret;
+
+		ret = apfs_logic_to_phys_bno(dstream, log_bno, &bno);
+		if (ret || bno == 0)
+			return;
+
+		bh = __apfs_getblk(sb, bno);
+		if (!bh)
+			return;
+		if (!buffer_uptodate(bh)) {
+			get_bh(bh);
+			lock_buffer(bh);
+			bh->b_end_io = end_buffer_read_sync;
+			apfs_submit_bh(REQ_OP_READ, 0, bh);
+		}
+		brelse(bh);
+		bh = NULL;
+	}
+}
diff --git a/drivers/staging/apfs/file.c b/drivers/staging/apfs/file.c
new file mode 100644
index 0000000000000000000000000000000000000000..49cfd877de2b9d2fd8d8c360c58a433c54fcb676
--- /dev/null
+++ b/drivers/staging/apfs/file.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2018 Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
+ * Copyright (C) 2025 Ethan Carter Edwards <ethan@ethancedwards.com>
+ */
+
+#include "apfs.h"
+
+#include <linux/splice.h>
+
+static vm_fault_t apfs_page_mkwrite(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct page *page = vmf->page;
+	struct folio *folio;
+	struct inode *inode = file_inode(vma->vm_file);
+	struct super_block *sb = inode->i_sb;
+	struct buffer_head *bh, *head;
+	vm_fault_t ret = VM_FAULT_LOCKED;
+	struct apfs_max_ops maxops;
+	int blkcount = PAGE_SIZE >> inode->i_blkbits;
+	unsigned int blocksize, block_start, len;
+	u64 size;
+	int err = 0;
+
+	sb_start_pagefault(inode->i_sb);
+	file_update_time(vma->vm_file);
+
+	/* Placeholder values, I need to get back to this in the future */
+	maxops.cat = APFS_UPDATE_INODE_MAXOPS() +
+		     blkcount * APFS_GET_NEW_BLOCK_MAXOPS();
+	maxops.blks = blkcount;
+
+	err = apfs_transaction_start(sb, maxops);
+	if (err)
+		goto out;
+	apfs_inode_join_transaction(sb, inode);
+
+	err = apfs_inode_create_exclusive_dstream(inode);
+	if (err) {
+		apfs_err(sb, "dstream creation failed for ino 0x%llx", apfs_ino(inode));
+		goto out_abort;
+	}
+
+	lock_page(page);
+	wait_for_stable_page(page);
+	if (page->mapping != inode->i_mapping) {
+		ret = VM_FAULT_NOPAGE;
+		goto out_unlock;
+	}
+
+	if (!page_has_buffers(page)) {
+		folio = page_folio(page);
+		bh = folio_buffers(folio);
+		if (!bh)
+			bh = create_empty_buffers(folio, sb->s_blocksize, 0);
+	}
+
+	size = i_size_read(inode);
+	if (page->index == size >> PAGE_SHIFT)
+		len = size & ~PAGE_MASK;
+	else
+		len = PAGE_SIZE;
+
+	/* The blocks were read on the fault, mark them as unmapped for CoW */
+	head = page_buffers(page);
+	blocksize = head->b_size;
+	for (bh = head, block_start = 0; bh != head || !block_start;
+	     block_start += blocksize, bh = bh->b_this_page) {
+		if (len > block_start) {
+			/* If it's not a hole, the fault read it already */
+			ASSERT(!buffer_mapped(bh) || buffer_uptodate(bh));
+			if (buffer_trans(bh))
+				continue;
+			clear_buffer_mapped(bh);
+		}
+	}
+	unlock_page(page); /* XXX: race? */
+
+	err = block_page_mkwrite(vma, vmf, apfs_get_new_block);
+	if (err) {
+		apfs_err(sb, "mkwrite failed for ino 0x%llx", apfs_ino(inode));
+		goto out_abort;
+	}
+	set_page_dirty(page);
+
+	/* An immediate commit would leave the page unlocked */
+	APFS_SB(sb)->s_nxi->nx_transaction.t_state |= APFS_NX_TRANS_DEFER_COMMIT;
+
+	err = apfs_transaction_commit(sb);
+	if (err)
+		goto out_unlock;
+	goto out;
+
+out_unlock:
+	unlock_page(page);
+out_abort:
+	apfs_transaction_abort(sb);
+out:
+	if (err)
+		ret = vmf_fs_error(err);
+	sb_end_pagefault(inode->i_sb);
+	return ret;
+}
+
+static const struct vm_operations_struct apfs_file_vm_ops = {
+	.fault		= filemap_fault,
+	.map_pages	= filemap_map_pages,
+	.page_mkwrite	= apfs_page_mkwrite,
+};
+
+int apfs_file_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct address_space *mapping = file->f_mapping;
+
+	if (!mapping->a_ops->read_folio)
+		return -ENOEXEC;
+	file_accessed(file);
+	vma->vm_ops = &apfs_file_vm_ops;
+	return 0;
+}
+
+/*
+ * Just flush the whole transaction for now (TODO), since that's technically
+ * correct and easy to implement.
+ */
+int apfs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
+{
+	struct inode *inode = file->f_mapping->host;
+	struct super_block *sb = inode->i_sb;
+
+	return apfs_sync_fs(sb, true /* wait */);
+}
+
+static ssize_t apfs_copy_file_range(struct file *src_file, loff_t src_off,
+				    struct file *dst_file, loff_t dst_off,
+				    size_t len, unsigned int flags)
+{
+	return (splice_copy_file_range(src_file, src_off,
+		dst_file, dst_off, len));
+}
+
+const struct file_operations apfs_file_operations = {
+	.llseek			= generic_file_llseek,
+	.read_iter		= generic_file_read_iter,
+	.write_iter		= generic_file_write_iter,
+	.mmap			= apfs_file_mmap,
+	.open			= generic_file_open,
+	.fsync			= apfs_fsync,
+	.unlocked_ioctl		= apfs_file_ioctl,
+	.copy_file_range	= apfs_copy_file_range,
+	.remap_file_range	= apfs_remap_file_range,
+	.splice_read		= filemap_splice_read,
+	.splice_write		= iter_file_splice_write,
+};
+
+const struct inode_operations apfs_file_inode_operations = {
+	.getattr	= apfs_getattr,
+	.listxattr	= apfs_listxattr,
+	.setattr	= apfs_setattr,
+	.update_time	= apfs_update_time,
+	.fileattr_get	= apfs_fileattr_get,
+	.fileattr_set	= apfs_fileattr_set,
+};
diff --git a/drivers/staging/apfs/inode.c b/drivers/staging/apfs/inode.c
new file mode 100644
index 0000000000000000000000000000000000000000..01e3d5397f5b3b6f4344c51f0836f64deaf61417
--- /dev/null
+++ b/drivers/staging/apfs/inode.c
@@ -0,0 +1,2235 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2018 Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
+ * Copyright (C) 2025 Ethan Carter Edwards <ethan@ethancedwards.com>
+ */
+
+#include <linux/slab.h>
+#include <linux/buffer_head.h>
+#include <linux/mount.h>
+#include <linux/mpage.h>
+#include <linux/blk_types.h>
+#include <linux/sched/mm.h>
+#include <linux/fileattr.h>
+
+#include "apfs.h"
+
+#define MAX_PFK_LEN	512
+
+
+static int apfs_read_folio(struct file *file, struct folio *folio)
+{
+	return mpage_read_folio(folio, apfs_get_block);
+}
+
+static void apfs_readahead(struct readahead_control *rac)
+{
+	mpage_readahead(rac, apfs_get_block);
+}
+
+/**
+ * apfs_create_dstream_rec - Create a data stream record
+ * @dstream: data stream info
+ *
+ * Does nothing if the record already exists.  TODO: support cloned files.
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_create_dstream_rec(struct apfs_dstream_info *dstream)
+{
+	struct super_block *sb = dstream->ds_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_query *query;
+	struct apfs_dstream_id_key raw_key;
+	struct apfs_dstream_id_val raw_val;
+	int ret;
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_dstream_id_key(dstream->ds_id, &query->key);
+	query->flags |= APFS_QUERY_CAT | APFS_QUERY_EXACT;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret != -ENODATA) /* Either an error, or the record already exists */
+		goto out;
+
+	apfs_key_set_hdr(APFS_TYPE_DSTREAM_ID, dstream->ds_id, &raw_key);
+	raw_val.refcnt = cpu_to_le32(1);
+	ret = apfs_btree_insert(query, &raw_key, sizeof(raw_key), &raw_val, sizeof(raw_val));
+	if (ret) {
+		apfs_err(sb, "insertion failed for id 0x%llx", dstream->ds_id);
+		goto out;
+	}
+out:
+	apfs_free_query(query);
+	return ret;
+}
+#define APFS_CREATE_DSTREAM_REC_MAXOPS	1
+
+static int apfs_check_dstream_refcnt(struct inode *inode);
+static int apfs_put_dstream_rec(struct apfs_dstream_info *dstream);
+
+/**
+ * apfs_inode_create_exclusive_dstream - Make an inode's dstream not shared
+ * @inode: the vfs inode
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+int apfs_inode_create_exclusive_dstream(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+	struct apfs_superblock *vsb_raw = APFS_SB(sb)->s_vsb_raw;
+	struct apfs_inode_info *ai = APFS_I(inode);
+	struct apfs_dstream_info *dstream = &ai->i_dstream;
+	u64 new_id;
+	int err;
+
+	if (!ai->i_has_dstream || !dstream->ds_shared)
+		return 0;
+
+	/*
+	 * The ds_shared field is not updated when the other user of the
+	 * dstream puts it, so it could be a false positive. Check it again
+	 * before actually putting the dstream. The double query is wasteful,
+	 * but I don't know if it makes sense to optimize this (TODO).
+	 */
+	err = apfs_check_dstream_refcnt(inode);
+	if (err) {
+		apfs_err(sb, "failed to check refcnt for ino 0x%llx", apfs_ino(inode));
+		return err;
+	}
+	if (!dstream->ds_shared)
+		return 0;
+	err = apfs_put_dstream_rec(dstream);
+	if (err) {
+		apfs_err(sb, "failed to put dstream for ino 0x%llx", apfs_ino(inode));
+		return err;
+	}
+
+	apfs_assert_in_transaction(sb, &vsb_raw->apfs_o);
+	new_id = le64_to_cpu(vsb_raw->apfs_next_obj_id);
+	le64_add_cpu(&vsb_raw->apfs_next_obj_id, 1);
+
+	err = apfs_clone_extents(dstream, new_id);
+	if (err) {
+		apfs_err(sb, "failed clone extents for ino 0x%llx", apfs_ino(inode));
+		return err;
+	}
+
+	dstream->ds_id = new_id;
+	err = apfs_create_dstream_rec(dstream);
+	if (err) {
+		apfs_err(sb, "failed to create dstream for ino 0x%llx", apfs_ino(inode));
+		return err;
+	}
+
+	dstream->ds_shared = false;
+	return 0;
+}
+
+/**
+ * apfs_inode_create_dstream_rec - Create the data stream record for an inode
+ * @inode: the vfs inode
+ *
+ * Does nothing if the record already exists.  TODO: support cloned files.
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_inode_create_dstream_rec(struct inode *inode)
+{
+	struct apfs_inode_info *ai = APFS_I(inode);
+	int err;
+
+	if (ai->i_has_dstream)
+		return apfs_inode_create_exclusive_dstream(inode);
+
+	err = apfs_create_dstream_rec(&ai->i_dstream);
+	if (err)
+		return err;
+
+	ai->i_has_dstream = true;
+	return 0;
+}
+
+/**
+ * apfs_dstream_adj_refcnt - Adjust dstream record refcount
+ * @dstream:	data stream info
+ * @delta:	desired change in reference count
+ *
+ * Deletes the record if the reference count goes to zero. Returns 0 on success
+ * or a negative error code in case of failure.
+ */
+int apfs_dstream_adj_refcnt(struct apfs_dstream_info *dstream, u32 delta)
+{
+	struct super_block *sb = dstream->ds_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_query *query;
+	struct apfs_dstream_id_val raw_val;
+	void *raw = NULL;
+	u32 refcnt;
+	int ret;
+
+	ASSERT(APFS_I(dstream->ds_inode)->i_has_dstream);
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_dstream_id_key(dstream->ds_id, &query->key);
+	query->flags |= APFS_QUERY_CAT | APFS_QUERY_EXACT;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret) {
+		apfs_err(sb, "query failed for id 0x%llx", dstream->ds_id);
+		if (ret == -ENODATA)
+			ret = -EFSCORRUPTED;
+		goto out;
+	}
+
+	if (query->len != sizeof(raw_val)) {
+		apfs_err(sb, "bad value length (%d)", query->len);
+		ret = -EFSCORRUPTED;
+		goto out;
+	}
+	raw = query->node->object.data;
+	raw_val = *(struct apfs_dstream_id_val *)(raw + query->off);
+	refcnt = le32_to_cpu(raw_val.refcnt);
+
+	refcnt += delta;
+	if (refcnt == 0) {
+		ret = apfs_btree_remove(query);
+		if (ret)
+			apfs_err(sb, "removal failed for id 0x%llx", dstream->ds_id);
+		goto out;
+	}
+
+	raw_val.refcnt = cpu_to_le32(refcnt);
+	ret = apfs_btree_replace(query, NULL /* key */, 0 /* key_len */, &raw_val, sizeof(raw_val));
+	if (ret)
+		apfs_err(sb, "update failed for id 0x%llx", dstream->ds_id);
+out:
+	apfs_free_query(query);
+	return ret;
+}
+
+/**
+ * apfs_put_dstream_rec - Put a reference for a data stream record
+ * @dstream: data stream info
+ *
+ * Deletes the record if the reference count goes to zero. Returns 0 on success
+ * or a negative error code in case of failure.
+ */
+static int apfs_put_dstream_rec(struct apfs_dstream_info *dstream)
+{
+	struct apfs_inode_info *ai = APFS_I(dstream->ds_inode);
+
+	if (!ai->i_has_dstream)
+		return 0;
+	return apfs_dstream_adj_refcnt(dstream, -1);
+}
+
+/**
+ * apfs_create_crypto_rec - Create the crypto state record for an inode
+ * @inode: the vfs inode
+ *
+ * Does nothing if the record already exists.  TODO: support cloned files.
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_create_crypto_rec(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_dstream_info *dstream = &APFS_I(inode)->i_dstream;
+	struct apfs_query *query;
+	struct apfs_crypto_state_key raw_key;
+	int ret;
+
+	if (inode->i_size || inode->i_blocks) /* Already has a dstream */
+		return 0;
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_crypto_state_key(dstream->ds_id, &query->key);
+	query->flags |= APFS_QUERY_CAT | APFS_QUERY_EXACT;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret != -ENODATA) /* Either an error, or the record already exists */
+		goto out;
+
+	apfs_key_set_hdr(APFS_TYPE_CRYPTO_STATE, dstream->ds_id, &raw_key);
+	if (sbi->s_dflt_pfk) {
+		struct apfs_crypto_state_val *raw_val = sbi->s_dflt_pfk;
+		unsigned int key_len = le16_to_cpu(raw_val->state.key_len);
+
+		ret = apfs_btree_insert(query, &raw_key, sizeof(raw_key), raw_val, sizeof(*raw_val) + key_len);
+		if (ret)
+			apfs_err(sb, "insertion failed for id 0x%llx", dstream->ds_id);
+	} else {
+		struct apfs_crypto_state_val raw_val;
+
+		raw_val.refcnt = cpu_to_le32(1);
+		raw_val.state.major_version = cpu_to_le16(APFS_WMCS_MAJOR_VERSION);
+		raw_val.state.minor_version = cpu_to_le16(APFS_WMCS_MINOR_VERSION);
+		raw_val.state.cpflags = 0;
+		raw_val.state.persistent_class = cpu_to_le32(APFS_PROTECTION_CLASS_F);
+		raw_val.state.key_os_version = 0;
+		raw_val.state.key_revision = cpu_to_le16(1);
+		raw_val.state.key_len = cpu_to_le16(0);
+		ret = apfs_btree_insert(query, &raw_key, sizeof(raw_key), &raw_val, sizeof(raw_val));
+		if (ret)
+			apfs_err(sb, "insertion failed for id 0x%llx", dstream->ds_id);
+	}
+out:
+	apfs_free_query(query);
+	return ret;
+}
+#define APFS_CREATE_CRYPTO_REC_MAXOPS	1
+
+/**
+ * apfs_dflt_key_class - Returns default key class for files in volume
+ * @sb: volume superblock
+ */
+static unsigned int apfs_dflt_key_class(struct super_block *sb)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+
+	if (!sbi->s_dflt_pfk)
+		return APFS_PROTECTION_CLASS_F;
+
+	return le32_to_cpu(sbi->s_dflt_pfk->state.persistent_class);
+}
+
+/**
+ * apfs_create_crypto_rec - Adjust crypto state record refcount
+ * @sb: volume superblock
+ * @crypto_id: crypto_id to adjust
+ * @delta: desired change in reference count
+ *
+ * This function is used when adding or removing extents, as each extent holds
+ * a reference to the crypto ID. It should also be used when removing inodes,
+ * and in that case it should also remove the crypto record (TODO).
+ */
+int apfs_crypto_adj_refcnt(struct super_block *sb, u64 crypto_id, int delta)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_query *query;
+	struct apfs_crypto_state_val *raw_val;
+	char *raw;
+	int ret;
+
+	if (!crypto_id)
+		return 0;
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_crypto_state_key(crypto_id, &query->key);
+	query->flags |= APFS_QUERY_CAT | APFS_QUERY_EXACT;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret) {
+		apfs_err(sb, "query failed for id 0x%llx", crypto_id);
+		goto out;
+	}
+
+	ret = apfs_query_join_transaction(query);
+	if (ret) {
+		apfs_err(sb, "query join failed");
+		return ret;
+	}
+	raw = query->node->object.data;
+	raw_val = (void *)raw + query->off;
+
+	le32_add_cpu(&raw_val->refcnt, delta);
+
+out:
+	apfs_free_query(query);
+	return ret;
+}
+int APFS_CRYPTO_ADJ_REFCNT_MAXOPS(void)
+{
+	return 1;
+}
+
+/**
+ * apfs_crypto_set_key - Modify content of crypto state record
+ * @sb: volume superblock
+ * @crypto_id: crypto_id to modify
+ * @new_val: new crypto state data; new_val->refcnt is overridden
+ *
+ * This function does not alter the inode's default protection class field.
+ * It needs to be done separately if the class changes.
+ */
+static int apfs_crypto_set_key(struct super_block *sb, u64 crypto_id, struct apfs_crypto_state_val *new_val)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_query *query;
+	struct apfs_crypto_state_val *raw_val;
+	char *raw;
+	int ret;
+	unsigned int pfk_len;
+
+	if (!crypto_id)
+		return 0;
+
+	pfk_len = le16_to_cpu(new_val->state.key_len);
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_crypto_state_key(crypto_id, &query->key);
+	query->flags |= APFS_QUERY_CAT | APFS_QUERY_EXACT;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret) {
+		apfs_err(sb, "query failed for id 0x%llx", crypto_id);
+		goto out;
+	}
+	raw = query->node->object.data;
+	raw_val = (void *)raw + query->off;
+
+	new_val->refcnt = raw_val->refcnt;
+
+	ret = apfs_btree_replace(query, NULL /* key */, 0 /* key_len */, new_val, sizeof(*new_val) + pfk_len);
+	if (ret)
+		apfs_err(sb, "update failed for id 0x%llx", crypto_id);
+
+out:
+	apfs_free_query(query);
+	return ret;
+}
+#define APFS_CRYPTO_SET_KEY_MAXOPS	1
+
+/**
+ * apfs_crypto_get_key - Retrieve content of crypto state record
+ * @sb: volume superblock
+ * @crypto_id: crypto_id to modify
+ * @val: result crypto state data
+ * @max_len: maximum allowed value of val->state.key_len
+ */
+static int apfs_crypto_get_key(struct super_block *sb, u64 crypto_id, struct apfs_crypto_state_val *val,
+			       unsigned int max_len)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_query *query;
+	struct apfs_crypto_state_val *raw_val;
+	char *raw;
+	int ret;
+	unsigned int pfk_len;
+
+	if (!crypto_id)
+		return -ENOENT;
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_crypto_state_key(crypto_id, &query->key);
+	query->flags |= APFS_QUERY_CAT | APFS_QUERY_EXACT;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret)
+		goto out;
+	raw = query->node->object.data;
+	raw_val = (void *)raw + query->off;
+
+	pfk_len = le16_to_cpu(raw_val->state.key_len);
+	if (pfk_len > max_len) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	memcpy(val, raw_val, sizeof(*val) + pfk_len);
+
+out:
+	apfs_free_query(query);
+	return ret;
+}
+
+int __apfs_write_begin(struct file *file, struct address_space *mapping, loff_t pos, unsigned int len, unsigned int flags, struct page **pagep, void **fsdata)
+{
+	struct inode *inode = mapping->host;
+	struct apfs_dstream_info *dstream = &APFS_I(inode)->i_dstream;
+	struct super_block *sb = inode->i_sb;
+	struct page *page;
+	struct folio *folio;
+	struct buffer_head *bh, *head;
+	unsigned int blocksize, block_start, block_end, from, to;
+	pgoff_t index = pos >> PAGE_SHIFT;
+	sector_t iblock = (sector_t)index << (PAGE_SHIFT - inode->i_blkbits);
+	loff_t i_blks_end;
+	int err;
+
+	apfs_inode_join_transaction(sb, inode);
+
+	err = apfs_inode_create_dstream_rec(inode);
+	if (err) {
+		apfs_err(sb, "failed to create dstream for ino 0x%llx", apfs_ino(inode));
+		return err;
+	}
+
+	if (apfs_vol_is_encrypted(sb)) {
+		err = apfs_create_crypto_rec(inode);
+		if (err) {
+			apfs_err(sb, "crypto creation failed for ino 0x%llx", apfs_ino(inode));
+			return err;
+		}
+	}
+
+	flags = memalloc_nofs_save();
+	page = grab_cache_page_write_begin(mapping, index);
+	memalloc_nofs_restore(flags);
+	if (!page)
+		return -ENOMEM;
+	if (!page_has_buffers(page)) {
+		folio = page_folio(page);
+		bh = folio_buffers(folio);
+		if (!bh)
+			bh = create_empty_buffers(folio, sb->s_blocksize, 0);
+	}
+
+	/* CoW moves existing blocks, so read them but mark them as unmapped */
+	head = page_buffers(page);
+	blocksize = head->b_size;
+	i_blks_end = (inode->i_size + sb->s_blocksize - 1) >> inode->i_blkbits;
+	i_blks_end <<= inode->i_blkbits;
+	if (i_blks_end >= pos) {
+		from = pos & (PAGE_SIZE - 1);
+		to = from + min(i_blks_end - pos, (loff_t)len);
+	} else {
+		/* TODO: deal with preallocated tail blocks */
+		from = UINT_MAX;
+		to = 0;
+	}
+	for (bh = head, block_start = 0; bh != head || !block_start;
+	     block_start = block_end, bh = bh->b_this_page, ++iblock) {
+		block_end = block_start + blocksize;
+		if (to > block_start && from < block_end) {
+			if (buffer_trans(bh))
+				continue;
+			if (!buffer_mapped(bh)) {
+				err = __apfs_get_block(dstream, iblock, bh,
+						       false /* create */);
+				if (err) {
+					apfs_err(sb, "failed to map block for ino 0x%llx", apfs_ino(inode));
+					goto out_put_page;
+				}
+			}
+			if (buffer_mapped(bh) && !buffer_uptodate(bh)) {
+				get_bh(bh);
+				lock_buffer(bh);
+				bh->b_end_io = end_buffer_read_sync;
+				apfs_submit_bh(REQ_OP_READ, 0, bh);
+				wait_on_buffer(bh);
+				if (!buffer_uptodate(bh)) {
+					apfs_err(sb, "failed to read block for ino 0x%llx", apfs_ino(inode));
+					err = -EIO;
+					goto out_put_page;
+				}
+			}
+			clear_buffer_mapped(bh);
+		}
+	}
+
+	err = __block_write_begin(page_folio(page), pos, len, apfs_get_new_block);
+	if (err) {
+		apfs_err(sb, "CoW failed in inode 0x%llx", apfs_ino(inode));
+		goto out_put_page;
+	}
+
+	*pagep = page;
+	return 0;
+
+out_put_page:
+	unlock_page(page);
+	put_page(page);
+	return err;
+}
+
+static int apfs_write_begin(struct file *file, struct address_space *mapping,
+			    loff_t pos, unsigned int len,
+			    struct folio **foliop, void **fsdata)
+{
+	struct inode *inode = mapping->host;
+	struct super_block *sb = inode->i_sb;
+	struct page *page = NULL;
+	struct page **pagep = &page;
+	int blkcount = (len + sb->s_blocksize - 1) >> inode->i_blkbits;
+	struct apfs_max_ops maxops;
+	int err;
+	unsigned int flags = 0;
+
+
+	if (unlikely(pos >= APFS_MAX_FILE_SIZE))
+		return -EFBIG;
+
+	maxops.cat = APFS_CREATE_DSTREAM_REC_MAXOPS +
+		     APFS_CREATE_CRYPTO_REC_MAXOPS +
+		     APFS_UPDATE_INODE_MAXOPS() +
+		     blkcount * APFS_GET_NEW_BLOCK_MAXOPS();
+	maxops.blks = blkcount;
+
+	err = apfs_transaction_start(sb, maxops);
+	if (err)
+		return err;
+
+	err = __apfs_write_begin(file, mapping, pos, len, flags, pagep, fsdata);
+	if (err)
+		goto fail;
+	*foliop = page_folio(page);
+
+	return 0;
+
+fail:
+	apfs_transaction_abort(sb);
+	return err;
+}
+
+int __apfs_write_end(struct file *file, struct address_space *mapping, loff_t pos, unsigned int len, unsigned int copied, struct page *page, void *fsdata)
+{
+	struct inode *inode = mapping->host;
+	struct apfs_dstream_info *dstream = &APFS_I(inode)->i_dstream;
+	int ret, err;
+
+	ret = generic_write_end(file, mapping, pos, len, copied, page_folio(page), fsdata);
+	dstream->ds_size = i_size_read(inode);
+	if (ret < len && pos + len > inode->i_size) {
+		truncate_pagecache(inode, inode->i_size);
+		err = apfs_truncate(dstream, inode->i_size);
+		if (err) {
+			apfs_err(inode->i_sb, "truncation failed for ino 0x%llx", apfs_ino(inode));
+			return err;
+		}
+	}
+	return ret;
+}
+
+static int apfs_write_end(struct file *file, struct address_space *mapping,
+			  loff_t pos, unsigned int len, unsigned int copied,
+			  struct folio *folio, void *fsdata)
+{
+	struct inode *inode = mapping->host;
+	struct super_block *sb = inode->i_sb;
+	struct apfs_nx_transaction *trans = &APFS_NXI(sb)->nx_transaction;
+	struct page *page = &folio->page;
+	int ret, err;
+
+	ret = __apfs_write_end(file, mapping, pos, len, copied, page, fsdata);
+	if (ret < 0) {
+		err = ret;
+		goto fail;
+	}
+
+	if ((pos + ret) & (sb->s_blocksize - 1))
+		trans->t_state |= APFS_NX_TRANS_INCOMPLETE_BLOCK;
+	else
+		trans->t_state &= ~APFS_NX_TRANS_INCOMPLETE_BLOCK;
+
+	err = apfs_transaction_commit(sb);
+	if (!err)
+		return ret;
+
+fail:
+	apfs_transaction_abort(sb);
+	return err;
+}
+
+static void apfs_noop_invalidate_folio(struct folio *folio, size_t offset, size_t length)
+{
+}
+
+/* bmap is not implemented to avoid issues with CoW on swapfiles */
+static const struct address_space_operations apfs_aops = {
+	.dirty_folio	= block_dirty_folio,
+	.read_folio	= apfs_read_folio,
+	.readahead	= apfs_readahead,
+	.write_begin	= apfs_write_begin,
+	.write_end	= apfs_write_end,
+
+	/* The intention is to keep bhs around until the transaction is over */
+	.invalidate_folio = apfs_noop_invalidate_folio,
+};
+
+/**
+ * apfs_inode_set_ops - Set up an inode's operations
+ * @inode:	vfs inode to set up
+ * @rdev:	device id (0 if not a device file)
+ * @compressed:	is this a compressed inode?
+ *
+ * For device files, also sets the device id to @rdev.
+ */
+static void apfs_inode_set_ops(struct inode *inode, dev_t rdev, bool compressed)
+{
+	/* A lot of operations still missing, of course */
+	switch (inode->i_mode & S_IFMT) {
+	case S_IFREG:
+		inode->i_op = &apfs_file_inode_operations;
+		if (compressed) {
+			inode->i_fop = &apfs_compress_file_operations;
+			inode->i_mapping->a_ops = &apfs_compress_aops;
+		} else {
+			inode->i_fop = &apfs_file_operations;
+			inode->i_mapping->a_ops = &apfs_aops;
+		}
+		break;
+	case S_IFDIR:
+		inode->i_op = &apfs_dir_inode_operations;
+		inode->i_fop = &apfs_dir_operations;
+		break;
+	case S_IFLNK:
+		inode->i_op = &apfs_symlink_inode_operations;
+		break;
+	default:
+		inode->i_op = &apfs_special_inode_operations;
+		init_special_inode(inode, inode->i_mode, rdev);
+		break;
+	}
+}
+
+/**
+ * apfs_inode_from_query - Read the inode found by a successful query
+ * @query:	the query that found the record
+ * @inode:	vfs inode to be filled with the read data
+ *
+ * Reads the inode record into @inode and performs some basic sanity checks,
+ * mostly as a protection against crafted filesystems.  Returns 0 on success
+ * or a negative error code otherwise.
+ */
+static int apfs_inode_from_query(struct apfs_query *query, struct inode *inode)
+{
+	struct apfs_inode_info *ai = APFS_I(inode);
+	struct apfs_dstream_info *dstream = &ai->i_dstream;
+	struct apfs_inode_val *inode_val;
+	char *raw = query->node->object.data;
+	char *xval = NULL;
+	int xlen;
+	u32 rdev = 0, bsd_flags;
+	bool compressed = false;
+
+	if (query->len < sizeof(*inode_val))
+		goto corrupted;
+
+	inode_val = (struct apfs_inode_val *)(raw + query->off);
+
+	ai->i_parent_id = le64_to_cpu(inode_val->parent_id);
+	dstream->ds_id = le64_to_cpu(inode_val->private_id);
+	inode->i_mode = le16_to_cpu(inode_val->mode);
+	ai->i_key_class = le32_to_cpu(inode_val->default_protection_class);
+	ai->i_int_flags = le64_to_cpu(inode_val->internal_flags);
+
+	ai->i_saved_uid = le32_to_cpu(inode_val->owner);
+	i_uid_write(inode, ai->i_saved_uid);
+	ai->i_saved_gid = le32_to_cpu(inode_val->group);
+	i_gid_write(inode, ai->i_saved_gid);
+
+	ai->i_bsd_flags = bsd_flags = le32_to_cpu(inode_val->bsd_flags);
+	if (bsd_flags & APFS_INOBSD_IMMUTABLE)
+		inode->i_flags |= S_IMMUTABLE;
+	if (bsd_flags & APFS_INOBSD_APPEND)
+		inode->i_flags |= S_APPEND;
+
+	if (!S_ISDIR(inode->i_mode)) {
+		/*
+		 * Directory inodes don't store their link count, so to provide
+		 * it we would have to actually count the subdirectories. The
+		 * HFS/HFS+ modules just leave it at 1, and so do we, for now.
+		 */
+		set_nlink(inode, le32_to_cpu(inode_val->nlink));
+	} else {
+		ai->i_nchildren = le32_to_cpu(inode_val->nchildren);
+	}
+
+	inode_set_ctime_to_ts(inode, ns_to_timespec64(le64_to_cpu(inode_val->change_time)));
+
+	inode_set_atime_to_ts(inode, ns_to_timespec64(le64_to_cpu(inode_val->access_time)));
+	inode_set_mtime_to_ts(inode, ns_to_timespec64(le64_to_cpu(inode_val->mod_time)));
+	ai->i_crtime = ns_to_timespec64(le64_to_cpu(inode_val->create_time));
+
+	dstream->ds_size = inode->i_size = inode->i_blocks = 0;
+	ai->i_has_dstream = false;
+	if ((bsd_flags & APFS_INOBSD_COMPRESSED) && !S_ISDIR(inode->i_mode)) {
+		if (!apfs_compress_get_size(inode, &inode->i_size)) {
+			inode->i_blocks = (inode->i_size + 511) >> 9;
+			compressed = true;
+		}
+	} else {
+		xlen = apfs_find_xfield(inode_val->xfields,
+					query->len - sizeof(*inode_val),
+					APFS_INO_EXT_TYPE_DSTREAM, &xval);
+		if (xlen >= sizeof(struct apfs_dstream)) {
+			struct apfs_dstream *dstream_raw = (struct apfs_dstream *)xval;
+
+			dstream->ds_size = inode->i_size = le64_to_cpu(dstream_raw->size);
+			inode->i_blocks = le64_to_cpu(dstream_raw->alloced_size) >> 9;
+			ai->i_has_dstream = true;
+		}
+	}
+	xval = NULL;
+
+	/* TODO: move each xfield read to its own function */
+	dstream->ds_sparse_bytes = 0;
+	xlen = apfs_find_xfield(inode_val->xfields, query->len - sizeof(*inode_val), APFS_INO_EXT_TYPE_SPARSE_BYTES, &xval);
+	if (xlen >= sizeof(__le64)) {
+		__le64 *sparse_bytes_p = (__le64 *)xval;
+
+		dstream->ds_sparse_bytes = le64_to_cpup(sparse_bytes_p);
+	}
+	xval = NULL;
+
+	rdev = 0;
+	xlen = apfs_find_xfield(inode_val->xfields,
+				query->len - sizeof(*inode_val),
+				APFS_INO_EXT_TYPE_RDEV, &xval);
+	if (xlen >= sizeof(__le32)) {
+		__le32 *rdev_p = (__le32 *)xval;
+
+		rdev = le32_to_cpup(rdev_p);
+	}
+
+	apfs_inode_set_ops(inode, rdev, compressed);
+	return 0;
+
+corrupted:
+	apfs_err(inode->i_sb, "bad inode record for inode 0x%llx", apfs_ino(inode));
+	return -EFSCORRUPTED;
+}
+
+/**
+ * apfs_inode_lookup - Lookup an inode record in the catalog b-tree
+ * @inode:	vfs inode to lookup
+ *
+ * Runs a catalog query for the apfs_ino(@inode) inode record; returns a pointer
+ * to the query structure on success, or an error pointer in case of failure.
+ */
+static struct apfs_query *apfs_inode_lookup(const struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_query *query;
+	int ret;
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query)
+		return ERR_PTR(-ENOMEM);
+	apfs_init_inode_key(apfs_ino(inode), &query->key);
+	query->flags |= APFS_QUERY_CAT | APFS_QUERY_EXACT;
+
+	ret = apfs_btree_query(sb, &query);
+	if (!ret)
+		return query;
+
+	/* Don't complain if an orphan is already gone */
+	if (!current_work() || ret != -ENODATA)
+		apfs_err(sb, "query failed for id 0x%llx", apfs_ino(inode));
+	apfs_free_query(query);
+	return ERR_PTR(ret);
+}
+
+/**
+ * apfs_test_inode - Check if the inode matches a 64-bit inode number
+ * @inode:	inode to test
+ * @cnid:	pointer to the inode number
+ */
+static int apfs_test_inode(struct inode *inode, void *cnid)
+{
+	u64 *ino = cnid;
+
+	return apfs_ino(inode) == *ino;
+}
+
+/**
+ * apfs_set_inode - Set a 64-bit inode number on the given inode
+ * @inode:	inode to set
+ * @cnid:	pointer to the inode number
+ */
+static int apfs_set_inode(struct inode *inode, void *cnid)
+{
+	apfs_set_ino(inode, *(u64 *)cnid);
+	return 0;
+}
+
+/**
+ * apfs_iget_locked - Wrapper for iget5_locked()
+ * @sb:		filesystem superblock
+ * @cnid:	64-bit inode number
+ *
+ * Works the same as iget_locked(), but can handle 64-bit inode numbers on
+ * 32-bit architectures.
+ */
+static struct inode *apfs_iget_locked(struct super_block *sb, u64 cnid)
+{
+	return iget5_locked(sb, cnid, apfs_test_inode, apfs_set_inode, &cnid);
+}
+
+/**
+ * apfs_check_dstream_refcnt - Check if an inode's dstream is shared
+ * @inode:	the inode to check
+ *
+ * Sets the value of ds_shared for the inode's dstream. Returns 0 on success,
+ * or a negative error code in case of failure.
+ */
+static int apfs_check_dstream_refcnt(struct inode *inode)
+{
+	struct apfs_inode_info *ai = APFS_I(inode);
+	struct apfs_dstream_info *dstream = &ai->i_dstream;
+	struct super_block *sb = inode->i_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_query *query = NULL;
+	struct apfs_dstream_id_val raw_val;
+	void *raw = NULL;
+	u32 refcnt;
+	int ret;
+
+	if (!ai->i_has_dstream) {
+		dstream->ds_shared = false;
+		return 0;
+	}
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_dstream_id_key(dstream->ds_id, &query->key);
+	query->flags |= APFS_QUERY_CAT | APFS_QUERY_EXACT;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret) {
+		apfs_err(sb, "query failed for id 0x%llx", dstream->ds_id);
+		if (ret == -ENODATA)
+			ret = -EFSCORRUPTED;
+		goto fail;
+	}
+
+	if (query->len != sizeof(raw_val)) {
+		ret = -EFSCORRUPTED;
+		goto fail;
+	}
+	raw = query->node->object.data;
+	raw_val = *(struct apfs_dstream_id_val *)(raw + query->off);
+	refcnt = le32_to_cpu(raw_val.refcnt);
+
+	dstream->ds_shared = refcnt > 1;
+fail:
+	apfs_free_query(query);
+	return ret;
+}
+
+/**
+ * apfs_iget - Populate inode structures with metadata from disk
+ * @sb:		filesystem superblock
+ * @cnid:	inode number
+ *
+ * Populates the vfs inode and the corresponding apfs_inode_info structure.
+ * Returns a pointer to the vfs inode in case of success, or an appropriate
+ * error pointer otherwise.
+ */
+struct inode *apfs_iget(struct super_block *sb, u64 cnid)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct inode *inode;
+	struct apfs_query *query;
+	int err;
+
+	inode = apfs_iget_locked(sb, cnid);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+	if (!(inode->i_state & I_NEW))
+		return inode;
+
+	down_read(&nxi->nx_big_sem);
+	query = apfs_inode_lookup(inode);
+	if (IS_ERR(query)) {
+		err = PTR_ERR(query);
+		/* Don't complain if an orphan is already gone */
+		if (!current_work() || err != -ENODATA)
+			apfs_err(sb, "lookup failed for ino 0x%llx", cnid);
+		goto fail;
+	}
+	err = apfs_inode_from_query(query, inode);
+	apfs_free_query(query);
+	if (err)
+		goto fail;
+	err = apfs_check_dstream_refcnt(inode);
+	if (err) {
+		apfs_err(sb, "refcnt check failed for ino 0x%llx", cnid);
+		goto fail;
+	}
+	up_read(&nxi->nx_big_sem);
+
+	/* Allow the user to override the ownership */
+	if (uid_valid(sbi->s_uid))
+		inode->i_uid = sbi->s_uid;
+	if (gid_valid(sbi->s_gid))
+		inode->i_gid = sbi->s_gid;
+
+	/* Inode flags are not important for now, leave them at 0 */
+	unlock_new_inode(inode);
+	return inode;
+
+fail:
+	up_read(&nxi->nx_big_sem);
+	iget_failed(inode);
+	return ERR_PTR(err);
+}
+
+int apfs_getattr(struct mnt_idmap *idmap,
+		 const struct path *path, struct kstat *stat, u32 request_mask,
+		 unsigned int query_flags)
+{
+	struct inode *inode = d_inode(path->dentry);
+	struct apfs_inode_info *ai = APFS_I(inode);
+
+	stat->result_mask |= STATX_BTIME;
+	stat->btime = ai->i_crtime;
+
+	if (ai->i_bsd_flags & APFS_INOBSD_APPEND)
+		stat->attributes |= STATX_ATTR_APPEND;
+	if (ai->i_bsd_flags & APFS_INOBSD_IMMUTABLE)
+		stat->attributes |= STATX_ATTR_IMMUTABLE;
+	if (ai->i_bsd_flags & APFS_INOBSD_NODUMP)
+		stat->attributes |= STATX_ATTR_NODUMP;
+	if (ai->i_bsd_flags & APFS_INOBSD_COMPRESSED)
+		stat->attributes |= STATX_ATTR_COMPRESSED;
+
+	stat->attributes_mask |= STATX_ATTR_APPEND;
+	stat->attributes_mask |= STATX_ATTR_IMMUTABLE;
+	stat->attributes_mask |= STATX_ATTR_NODUMP;
+	stat->attributes_mask |= STATX_ATTR_COMPRESSED;
+
+	generic_fillattr(idmap, request_mask, inode, stat);
+
+	stat->dev = APFS_SB(inode->i_sb)->s_anon_dev;
+	stat->ino = apfs_ino(inode);
+	return 0;
+}
+
+/**
+ * apfs_build_inode_val - Allocate and initialize the value for an inode record
+ * @inode:	vfs inode to record
+ * @qname:	filename for primary link
+ * @val_p:	on return, a pointer to the new on-disk value structure
+ *
+ * Returns the length of the value, or a negative error code in case of failure.
+ */
+static int apfs_build_inode_val(struct inode *inode, struct qstr *qname,
+				struct apfs_inode_val **val_p)
+{
+	struct apfs_inode_val *val;
+	struct apfs_x_field xkey;
+	struct timespec64 ts;
+	int total_xlen, val_len;
+	bool is_device = S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode);
+	__le32 rdev;
+
+	/* The only required xfield is the name, and the id if it's a device */
+	total_xlen = sizeof(struct apfs_xf_blob);
+	total_xlen += sizeof(xkey) + round_up(qname->len + 1, 8);
+	if (is_device)
+		total_xlen += sizeof(xkey) + round_up(sizeof(rdev), 8);
+
+	val_len = sizeof(*val) + total_xlen;
+	val = kzalloc(val_len, GFP_KERNEL);
+	if (!val)
+		return -ENOMEM;
+
+	val->parent_id = cpu_to_le64(APFS_I(inode)->i_parent_id);
+	val->private_id = cpu_to_le64(apfs_ino(inode));
+
+	ts = inode_get_mtime(inode);
+	val->mod_time = cpu_to_le64(timespec64_to_ns(&ts));
+	val->create_time = val->change_time = val->access_time = val->mod_time;
+
+	if (S_ISDIR(inode->i_mode))
+		val->nchildren = 0;
+	else
+		val->nlink = cpu_to_le32(1);
+
+	val->owner = cpu_to_le32(i_uid_read(inode));
+	val->group = cpu_to_le32(i_gid_read(inode));
+	val->mode = cpu_to_le16(inode->i_mode);
+
+	/* The buffer was just allocated: none of these functions should fail */
+	apfs_init_xfields(val->xfields, total_xlen);
+	xkey.x_type = APFS_INO_EXT_TYPE_NAME;
+	xkey.x_flags = APFS_XF_DO_NOT_COPY;
+	xkey.x_size = cpu_to_le16(qname->len + 1);
+	apfs_insert_xfield(val->xfields, total_xlen, &xkey, qname->name);
+	if (is_device) {
+		rdev = cpu_to_le32(inode->i_rdev);
+		xkey.x_type = APFS_INO_EXT_TYPE_RDEV;
+		xkey.x_flags = 0; /* TODO: proper flags here? */
+		xkey.x_size = cpu_to_le16(sizeof(rdev));
+		apfs_insert_xfield(val->xfields, total_xlen, &xkey, &rdev);
+	}
+
+	*val_p = val;
+	return val_len;
+}
+
+/*
+ * apfs_inode_rename - Update the primary name reported in an inode record
+ * @inode:	the in-memory inode
+ * @new_name:	name of the new primary link (NULL if unchanged)
+ * @query:	the query that found the inode record
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+static int apfs_inode_rename(struct inode *inode, char *new_name,
+			     struct apfs_query *query)
+{
+	char *raw = query->node->object.data;
+	struct apfs_inode_val *new_val = NULL;
+	int buflen, namelen;
+	struct apfs_x_field xkey;
+	int xlen;
+	int err;
+
+	if (!new_name)
+		return 0;
+
+	namelen = strlen(new_name) + 1; /* Count the null-termination */
+	buflen = query->len;
+	buflen += sizeof(struct apfs_x_field) + round_up(namelen, 8);
+	new_val = kzalloc(buflen, GFP_KERNEL);
+	if (!new_val)
+		return -ENOMEM;
+	memcpy(new_val, raw + query->off, query->len);
+
+	/* TODO: can we assume that all inode records have an xfield blob? */
+	xkey.x_type = APFS_INO_EXT_TYPE_NAME;
+	xkey.x_flags = APFS_XF_DO_NOT_COPY;
+	xkey.x_size = cpu_to_le16(namelen);
+	xlen = apfs_insert_xfield(new_val->xfields, buflen - sizeof(*new_val),
+				  &xkey, new_name);
+	if (!xlen) {
+		/* Buffer has enough space, but the metadata claims otherwise */
+		apfs_err(inode->i_sb, "bad xfields on inode 0x%llx", apfs_ino(inode));
+		err = -EFSCORRUPTED;
+		goto fail;
+	}
+
+	/* Just remove the old record and create a new one */
+	err = apfs_btree_replace(query, NULL /* key */, 0 /* key_len */, new_val, sizeof(*new_val) + xlen);
+	if (err)
+		apfs_err(inode->i_sb, "update failed for ino 0x%llx", apfs_ino(inode));
+
+fail:
+	kfree(new_val);
+	return err;
+}
+#define APFS_INODE_RENAME_MAXOPS	1
+
+/**
+ * apfs_create_dstream_xfield - Create the inode xfield for a new data stream
+ * @inode:	the in-memory inode
+ * @query:	the query that found the inode record
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+static int apfs_create_dstream_xfield(struct inode *inode,
+				      struct apfs_query *query)
+{
+	char *raw = query->node->object.data;
+	struct apfs_inode_val *new_val;
+	struct apfs_dstream dstream_raw = {0};
+	struct apfs_x_field xkey;
+	struct apfs_dstream_info *dstream = &APFS_I(inode)->i_dstream;
+	int xlen;
+	int buflen;
+	int err;
+
+	buflen = query->len;
+	buflen += sizeof(struct apfs_x_field) + sizeof(dstream_raw);
+	new_val = kzalloc(buflen, GFP_KERNEL);
+	if (!new_val)
+		return -ENOMEM;
+	memcpy(new_val, raw + query->off, query->len);
+
+	dstream_raw.size = cpu_to_le64(inode->i_size);
+	dstream_raw.alloced_size = cpu_to_le64(apfs_alloced_size(dstream));
+	if (apfs_vol_is_encrypted(inode->i_sb))
+		dstream_raw.default_crypto_id = cpu_to_le64(dstream->ds_id);
+
+	/* TODO: can we assume that all inode records have an xfield blob? */
+	xkey.x_type = APFS_INO_EXT_TYPE_DSTREAM;
+	xkey.x_flags = APFS_XF_SYSTEM_FIELD;
+	xkey.x_size = cpu_to_le16(sizeof(dstream_raw));
+	xlen = apfs_insert_xfield(new_val->xfields, buflen - sizeof(*new_val),
+				  &xkey, &dstream_raw);
+	if (!xlen) {
+		/* Buffer has enough space, but the metadata claims otherwise */
+		apfs_err(inode->i_sb, "bad xfields on inode 0x%llx", apfs_ino(inode));
+		err = -EFSCORRUPTED;
+		goto fail;
+	}
+
+	/* Just remove the old record and create a new one */
+	err = apfs_btree_replace(query, NULL /* key */, 0 /* key_len */, new_val, sizeof(*new_val) + xlen);
+	if (err)
+		apfs_err(inode->i_sb, "update failed for ino 0x%llx", apfs_ino(inode));
+
+fail:
+	kfree(new_val);
+	return err;
+}
+#define APFS_CREATE_DSTREAM_XFIELD_MAXOPS	1
+
+/**
+ * apfs_inode_resize - Update the sizes reported in an inode record
+ * @inode:	the in-memory inode
+ * @query:	the query that found the inode record
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+static int apfs_inode_resize(struct inode *inode, struct apfs_query *query)
+{
+	struct apfs_inode_info *ai = APFS_I(inode);
+	char *raw;
+	struct apfs_inode_val *inode_raw;
+	char *xval;
+	int xlen;
+	int err;
+
+	/* All dstream records must have a matching xfield, even if empty */
+	if (!ai->i_has_dstream)
+		return 0;
+
+	err = apfs_query_join_transaction(query);
+	if (err) {
+		apfs_err(inode->i_sb, "query join failed");
+		return err;
+	}
+	raw = query->node->object.data;
+	inode_raw = (void *)raw + query->off;
+
+	xlen = apfs_find_xfield(inode_raw->xfields,
+				query->len - sizeof(*inode_raw),
+				APFS_INO_EXT_TYPE_DSTREAM, &xval);
+
+	if (xlen) {
+		struct apfs_dstream *dstream;
+
+		if (xlen != sizeof(*dstream)) {
+			apfs_err(inode->i_sb, "bad xlen (%d) on inode 0x%llx", xlen, apfs_ino(inode));
+			return -EFSCORRUPTED;
+		}
+		dstream = (struct apfs_dstream *)xval;
+
+		/* TODO: count bytes read and written */
+		dstream->size = cpu_to_le64(inode->i_size);
+		dstream->alloced_size = cpu_to_le64(apfs_alloced_size(&ai->i_dstream));
+		return 0;
+	}
+	/* This inode has no dstream xfield, so we need to create it */
+	return apfs_create_dstream_xfield(inode, query);
+}
+#define APFS_INODE_RESIZE_MAXOPS	(1 + APFS_CREATE_DSTREAM_XFIELD_MAXOPS)
+
+/**
+ * apfs_create_sparse_xfield - Create an inode xfield to count sparse bytes
+ * @inode:	the in-memory inode
+ * @query:	the query that found the inode record
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+static int apfs_create_sparse_xfield(struct inode *inode, struct apfs_query *query)
+{
+	struct apfs_dstream_info *dstream = &APFS_I(inode)->i_dstream;
+	char *raw = query->node->object.data;
+	struct apfs_inode_val *new_val;
+	__le64 sparse_bytes;
+	struct apfs_x_field xkey;
+	int xlen;
+	int buflen;
+	int err;
+
+	buflen = query->len;
+	buflen += sizeof(struct apfs_x_field) + sizeof(sparse_bytes);
+	new_val = kzalloc(buflen, GFP_KERNEL);
+	if (!new_val)
+		return -ENOMEM;
+	memcpy(new_val, raw + query->off, query->len);
+
+	sparse_bytes = cpu_to_le64(dstream->ds_sparse_bytes);
+
+	/* TODO: can we assume that all inode records have an xfield blob? */
+	xkey.x_type = APFS_INO_EXT_TYPE_SPARSE_BYTES;
+	xkey.x_flags = APFS_XF_SYSTEM_FIELD | APFS_XF_CHILDREN_INHERIT;
+	xkey.x_size = cpu_to_le16(sizeof(sparse_bytes));
+	xlen = apfs_insert_xfield(new_val->xfields, buflen - sizeof(*new_val), &xkey, &sparse_bytes);
+	if (!xlen) {
+		/* Buffer has enough space, but the metadata claims otherwise */
+		apfs_err(inode->i_sb, "bad xfields on inode 0x%llx", apfs_ino(inode));
+		err = -EFSCORRUPTED;
+		goto fail;
+	}
+
+	/* Just remove the old record and create a new one */
+	err = apfs_btree_replace(query, NULL /* key */, 0 /* key_len */, new_val, sizeof(*new_val) + xlen);
+	if (err)
+		apfs_err(inode->i_sb, "update failed for ino 0x%llx", apfs_ino(inode));
+
+fail:
+	kfree(new_val);
+	return err;
+}
+
+/**
+ * apfs_inode_resize_sparse - Update sparse byte count reported in inode record
+ * @inode:	the in-memory inode
+ * @query:	the query that found the inode record
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ *
+ * TODO: should the xfield be removed if the count reaches 0? Should the inode
+ * flag change?
+ */
+static int apfs_inode_resize_sparse(struct inode *inode, struct apfs_query *query)
+{
+	struct apfs_dstream_info *dstream = &APFS_I(inode)->i_dstream;
+	char *raw;
+	struct apfs_inode_val *inode_raw;
+	char *xval;
+	int xlen;
+	int err;
+
+	err = apfs_query_join_transaction(query);
+	if (err) {
+		apfs_err(inode->i_sb, "query join failed");
+		return err;
+	}
+	raw = query->node->object.data;
+	inode_raw = (void *)raw + query->off;
+
+	xlen = apfs_find_xfield(inode_raw->xfields,
+				query->len - sizeof(*inode_raw),
+				APFS_INO_EXT_TYPE_SPARSE_BYTES, &xval);
+	if (!xlen && !dstream->ds_sparse_bytes)
+		return 0;
+
+	if (xlen) {
+		__le64 *sparse_bytes_p;
+
+		if (xlen != sizeof(*sparse_bytes_p)) {
+			apfs_err(inode->i_sb, "bad xlen (%d) on inode 0x%llx", xlen, apfs_ino(inode));
+			return -EFSCORRUPTED;
+		}
+		sparse_bytes_p = (__le64 *)xval;
+
+		*sparse_bytes_p = cpu_to_le64(dstream->ds_sparse_bytes);
+		return 0;
+	}
+	return apfs_create_sparse_xfield(inode, query);
+}
+
+/**
+ * apfs_update_inode - Update an existing inode record
+ * @inode:	the modified in-memory inode
+ * @new_name:	name of the new primary link (NULL if unchanged)
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+int apfs_update_inode(struct inode *inode, char *new_name)
+{
+	struct super_block *sb = inode->i_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_inode_info *ai = APFS_I(inode);
+	struct apfs_dstream_info *dstream = &ai->i_dstream;
+	struct apfs_query *query;
+	struct apfs_btree_node_phys *node_raw;
+	struct apfs_inode_val *inode_raw;
+	int err;
+
+	err = apfs_flush_extent_cache(dstream);
+	if (err) {
+		apfs_err(sb, "extent cache flush failed for inode 0x%llx", apfs_ino(inode));
+		return err;
+	}
+
+	query = apfs_inode_lookup(inode);
+	if (IS_ERR(query)) {
+		apfs_err(sb, "lookup failed for ino 0x%llx", apfs_ino(inode));
+		return PTR_ERR(query);
+	}
+
+	/* TODO: copy the record to memory and make all xfield changes there */
+	err = apfs_inode_rename(inode, new_name, query);
+	if (err) {
+		apfs_err(sb, "rename failed for ino 0x%llx", apfs_ino(inode));
+		goto fail;
+	}
+
+	err = apfs_inode_resize(inode, query);
+	if (err) {
+		apfs_err(sb, "resize failed for ino 0x%llx", apfs_ino(inode));
+		goto fail;
+	}
+
+	err = apfs_inode_resize_sparse(inode, query);
+	if (err) {
+		apfs_err(sb, "sparse resize failed for ino 0x%llx", apfs_ino(inode));
+		goto fail;
+	}
+	if (dstream->ds_sparse_bytes)
+		ai->i_int_flags |= APFS_INODE_IS_SPARSE;
+
+	/* TODO: just use apfs_btree_replace()? */
+	err = apfs_query_join_transaction(query);
+	if (err) {
+		apfs_err(sb, "query join failed");
+		goto fail;
+	}
+	node_raw = (void *)query->node->object.data;
+	apfs_assert_in_transaction(sb, &node_raw->btn_o);
+	inode_raw = (void *)node_raw + query->off;
+
+	inode_raw->parent_id = cpu_to_le64(ai->i_parent_id);
+	inode_raw->private_id = cpu_to_le64(dstream->ds_id);
+	inode_raw->mode = cpu_to_le16(inode->i_mode);
+	inode_raw->owner = cpu_to_le32(i_uid_read(inode));
+	inode_raw->group = cpu_to_le32(i_gid_read(inode));
+	inode_raw->default_protection_class = cpu_to_le32(ai->i_key_class);
+	inode_raw->internal_flags = cpu_to_le64(ai->i_int_flags);
+	inode_raw->bsd_flags = cpu_to_le32(ai->i_bsd_flags);
+
+	/* Don't persist the uid/gid provided by the user on mount */
+	if (uid_valid(sbi->s_uid))
+		inode_raw->owner = cpu_to_le32(ai->i_saved_uid);
+	if (gid_valid(sbi->s_gid))
+		inode_raw->group = cpu_to_le32(ai->i_saved_gid);
+
+	struct timespec64 ictime = inode_get_ctime(inode);
+	inode_raw->change_time = cpu_to_le64(timespec64_to_ns(&ictime));
+
+	struct timespec64 ts = inode_get_mtime(inode);
+	inode_raw->mod_time = cpu_to_le64(timespec64_to_ns(&ts));
+	ts = inode_get_atime(inode);
+	inode_raw->access_time = cpu_to_le64(timespec64_to_ns(&ts));
+	inode_raw->create_time = cpu_to_le64(timespec64_to_ns(&ai->i_crtime));
+
+	if (S_ISDIR(inode->i_mode)) {
+		inode_raw->nchildren = cpu_to_le32(ai->i_nchildren);
+	} else {
+		/* The remaining link for orphan inodes is not counted */
+		inode_raw->nlink = cpu_to_le32(inode->i_nlink);
+	}
+
+fail:
+	apfs_free_query(query);
+	return err;
+}
+int APFS_UPDATE_INODE_MAXOPS(void)
+{
+	return APFS_INODE_RENAME_MAXOPS + APFS_INODE_RESIZE_MAXOPS + 1;
+}
+
+/**
+ * apfs_delete_inode - Delete an inode record
+ * @inode: the vfs inode to delete
+ *
+ * Returns 0 on success or a negative error code in case of failure, which may
+ * be -EAGAIN if the inode was not deleted in full.
+ */
+static int apfs_delete_inode(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+	struct apfs_inode_info *ai = APFS_I(inode);
+	struct apfs_dstream_info *dstream = NULL;
+	struct apfs_query *query;
+	u64 old_dstream_id;
+	int ret;
+
+	ret = apfs_delete_all_xattrs(inode);
+	if (ret) {
+		apfs_err(sb, "xattr deletion failed for ino 0x%llx", apfs_ino(inode));
+		return ret;
+	}
+
+	dstream = &ai->i_dstream;
+	old_dstream_id = dstream->ds_id;
+
+	/*
+	 * This is very wasteful since all the new extents and references will
+	 * get deleted right away, but it only affects clones, so I don't see a
+	 * big reason to improve it (TODO)
+	 */
+	ret = apfs_inode_create_exclusive_dstream(inode);
+	if (ret) {
+		apfs_err(sb, "dstream creation failed for ino 0x%llx", apfs_ino(inode));
+		return ret;
+	}
+
+	/* TODO: what about partial deletion of xattrs? Is that allowed? */
+	ret = apfs_inode_delete_front(inode);
+	if (ret) {
+		/*
+		 * If the inode had too many extents, only the first few get
+		 * deleted and the inode remains in the orphan list for now.
+		 * I don't know why the deletion starts at the front, but it
+		 * seems to be what the official driver does.
+		 */
+		if (ret != -EAGAIN) {
+			apfs_err(sb, "head deletion failed for ino 0x%llx", apfs_ino(inode));
+			return ret;
+		}
+		if (dstream->ds_id != old_dstream_id) {
+			ret = apfs_update_inode(inode, NULL /* new_name */);
+			if (ret) {
+				apfs_err(sb, "dstream id update failed for orphan 0x%llx", apfs_ino(inode));
+				return ret;
+			}
+		}
+		return -EAGAIN;
+	}
+
+	ret = apfs_put_dstream_rec(dstream);
+	if (ret) {
+		apfs_err(sb, "failed to put dstream for ino 0x%llx", apfs_ino(inode));
+		return ret;
+	}
+	dstream = NULL;
+	ai->i_has_dstream = false;
+
+	query = apfs_inode_lookup(inode);
+	if (IS_ERR(query)) {
+		apfs_err(sb, "lookup failed for ino 0x%llx", apfs_ino(inode));
+		return PTR_ERR(query);
+	}
+	ret = apfs_btree_remove(query);
+	apfs_free_query(query);
+	if (ret) {
+		apfs_err(sb, "removal failed for ino 0x%llx", apfs_ino(inode));
+		return ret;
+	}
+
+	ai->i_cleaned = true;
+	return ret;
+}
+#define APFS_DELETE_INODE_MAXOPS	1
+
+/**
+ * apfs_clean_single_orphan - Clean the given orphan file
+ * @inode:	inode for the file to clean
+ *
+ * Returns 0 on success or a negative error code in case of failure, which may
+ * be -EAGAIN if the file could not be deleted in full.
+ */
+static int apfs_clean_single_orphan(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+	struct apfs_max_ops maxops = {0}; /* TODO: rethink this stuff */
+	u64 ino = apfs_ino(inode);
+	bool eagain = false;
+	int err;
+
+	err = apfs_transaction_start(sb, maxops);
+	if (err)
+		return err;
+	err = apfs_delete_inode(inode);
+	if (err) {
+		if (err != -EAGAIN) {
+			apfs_err(sb, "failed to delete orphan 0x%llx", ino);
+			goto fail;
+		}
+		eagain = true;
+	} else {
+		err = apfs_delete_orphan_link(inode);
+		if (err) {
+			apfs_err(sb, "failed to unlink orphan 0x%llx", ino);
+			goto fail;
+		}
+	}
+	err = apfs_transaction_commit(sb);
+	if (err)
+		goto fail;
+	return eagain ? -EAGAIN : 0;
+
+fail:
+	apfs_transaction_abort(sb);
+	return err;
+}
+
+/**
+ * apfs_clean_any_orphan - Pick an orphan and delete as much as reasonable
+ * @sb:		filesystem superblock
+ *
+ * Returns 0 on success, or a negative error code in case of failure, which may
+ * be -ENODATA if there are no more orphan files or -EAGAIN if a file could not
+ * be deleted in full.
+ */
+static int apfs_clean_any_orphan(struct super_block *sb)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct inode *inode = NULL;
+	int err;
+	u64 ino;
+
+	down_read(&nxi->nx_big_sem);
+	err = apfs_any_orphan_ino(sb, &ino);
+	up_read(&nxi->nx_big_sem);
+	if (err) {
+		if (err == -ENODATA)
+			return -ENODATA;
+		apfs_err(sb, "failed to find orphan inode numbers");
+		return err;
+	}
+
+	inode = apfs_iget(sb, ino);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		if (err != -ENODATA) {
+			apfs_err(sb, "iget failed for orphan 0x%llx", ino);
+			return err;
+		}
+		/*
+		 * This happens rarely for files with no extents, if we hit a
+		 * race with ->evict_inode(). Not a problem: the file is gone.
+		 */
+		apfs_notice(sb, "orphan 0x%llx not found", ino);
+		return 0;
+	}
+
+	if (atomic_read(&inode->i_count) > 1)
+		goto out;
+	err = apfs_clean_single_orphan(inode);
+	if (err && err != -EAGAIN) {
+		apfs_err(sb, "failed to clean orphan 0x%llx", ino);
+		goto out;
+	}
+out:
+	iput(inode);
+	return err;
+}
+
+/**
+ * apfs_clean_orphans - Delete as many orphan files as is reasonable
+ * @sb: filesystem superblock
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_clean_orphans(struct super_block *sb)
+{
+	int ret, i;
+
+	for (i = 0; i < 100; ++i) {
+		ret = apfs_clean_any_orphan(sb);
+		if (ret) {
+			if (ret == -ENODATA)
+				return 0;
+			if (ret == -EAGAIN)
+				break;
+			apfs_err(sb, "failed to delete an orphan file");
+			return ret;
+		}
+	}
+
+	/*
+	 * If a file is too big, or if there are too many files, take a break
+	 * and continue later.
+	 */
+	if (atomic_read(&sb->s_active) != 0)
+		schedule_work(&APFS_SB(sb)->s_orphan_cleanup_work);
+	return 0;
+}
+
+void apfs_evict_inode(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+	struct apfs_inode_info *ai = APFS_I(inode);
+	int err;
+
+	if (is_bad_inode(inode) || inode->i_nlink || ai->i_cleaned)
+		goto out;
+
+	if (!ai->i_has_dstream || ai->i_dstream.ds_size == 0) {
+		/* For files with no extents, scheduled cleanup wastes time */
+		err = apfs_clean_single_orphan(inode);
+		if (err)
+			apfs_err(sb, "failed to clean orphan 0x%llx (err:%d)", apfs_ino(inode), err);
+		goto out;
+	}
+
+	/*
+	 * If the inode still has extents then schedule cleanup for the rest
+	 * of it. Not during unmount though: completing all cleanup could take
+	 * a while so just leave future mounts to handle the orphans.
+	 */
+	if (atomic_read(&sb->s_active))
+		schedule_work(&APFS_SB(sb)->s_orphan_cleanup_work);
+out:
+	truncate_inode_pages_final(&inode->i_data);
+	clear_inode(inode);
+}
+
+void apfs_orphan_cleanup_work(struct work_struct *work)
+{
+	struct super_block *sb = NULL;
+	struct apfs_sb_info *sbi = NULL;
+	struct inode *priv = NULL;
+	int err;
+
+	sbi = container_of(work, struct apfs_sb_info, s_orphan_cleanup_work);
+	priv = sbi->s_private_dir;
+	sb = priv->i_sb;
+
+	if (sb->s_flags & SB_RDONLY) {
+		apfs_alert(sb, "attempt to flush orphans in read-only mount");
+		return;
+	}
+
+	err = apfs_clean_orphans(sb);
+	if (err)
+		apfs_err(sb, "orphan cleanup failed (err:%d)", err);
+}
+
+/**
+ * apfs_insert_inode_locked - Wrapper for insert_inode_locked4()
+ * @inode: vfs inode to insert in cache
+ *
+ * Works the same as insert_inode_locked(), but can handle 64-bit inode numbers
+ * on 32-bit architectures.
+ */
+static int apfs_insert_inode_locked(struct inode *inode)
+{
+	u64 cnid = apfs_ino(inode);
+
+	return insert_inode_locked4(inode, cnid, apfs_test_inode, &cnid);
+}
+
+/**
+ * apfs_new_inode - Create a new in-memory inode
+ * @dir:	parent inode
+ * @mode:	mode bits for the new inode
+ * @rdev:	device id (0 if not a device file)
+ *
+ * Returns a pointer to the new vfs inode on success, or an error pointer in
+ * case of failure.
+ */
+struct inode *apfs_new_inode(struct inode *dir, umode_t mode, dev_t rdev)
+{
+	struct super_block *sb = dir->i_sb;
+	struct apfs_superblock *vsb_raw = APFS_SB(sb)->s_vsb_raw;
+	struct inode *inode;
+	struct apfs_inode_info *ai;
+	struct apfs_dstream_info *dstream;
+	u64 cnid;
+	struct timespec64 now;
+
+	/* Updating on-disk structures here is odd, but it works for now */
+	apfs_assert_in_transaction(sb, &vsb_raw->apfs_o);
+
+	inode = new_inode(sb);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+	ai = APFS_I(inode);
+	dstream = &ai->i_dstream;
+
+	cnid = le64_to_cpu(vsb_raw->apfs_next_obj_id);
+	le64_add_cpu(&vsb_raw->apfs_next_obj_id, 1);
+	apfs_set_ino(inode, cnid);
+
+	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
+
+	ai->i_saved_uid = i_uid_read(inode);
+	ai->i_saved_gid = i_gid_read(inode);
+	ai->i_parent_id = apfs_ino(dir);
+	set_nlink(inode, 1);
+	ai->i_nchildren = 0;
+	if (apfs_vol_is_encrypted(sb) && S_ISREG(mode))
+		ai->i_key_class = apfs_dflt_key_class(sb);
+	else
+		ai->i_key_class = 0;
+	ai->i_int_flags = APFS_INODE_NO_RSRC_FORK;
+	ai->i_bsd_flags = 0;
+
+	ai->i_has_dstream = false;
+	dstream->ds_id = cnid;
+	dstream->ds_size = 0;
+	dstream->ds_sparse_bytes = 0;
+	dstream->ds_shared = false;
+
+	now = current_time(inode);
+	ai->i_crtime = simple_inode_init_ts(inode);
+	vsb_raw->apfs_last_mod_time = cpu_to_le64(timespec64_to_ns(&now));
+
+	if (S_ISREG(mode))
+		le64_add_cpu(&vsb_raw->apfs_num_files, 1);
+	else if (S_ISDIR(mode))
+		le64_add_cpu(&vsb_raw->apfs_num_directories, 1);
+	else if (S_ISLNK(mode))
+		le64_add_cpu(&vsb_raw->apfs_num_symlinks, 1);
+	else
+		le64_add_cpu(&vsb_raw->apfs_num_other_fsobjects, 1);
+
+	if (apfs_insert_inode_locked(inode)) {
+		/* The inode number should have been free, but wasn't */
+		apfs_err(sb, "next obj_id (0x%llx) not free", cnid);
+		make_bad_inode(inode);
+		iput(inode);
+		return ERR_PTR(-EFSCORRUPTED);
+	}
+
+	/* No need to dirty the inode, we'll write it to disk right away */
+	apfs_inode_set_ops(inode, rdev, false /* compressed */);
+	return inode;
+}
+
+/**
+ * apfs_create_inode_rec - Create an inode record in the catalog b-tree
+ * @sb:		filesystem superblock
+ * @inode:	vfs inode to record
+ * @dentry:	dentry for primary link
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+int apfs_create_inode_rec(struct super_block *sb, struct inode *inode,
+			  struct dentry *dentry)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_query *query;
+	struct apfs_inode_key raw_key;
+	struct apfs_inode_val *raw_val;
+	int val_len;
+	int ret;
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_inode_key(apfs_ino(inode), &query->key);
+	query->flags |= APFS_QUERY_CAT;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret && ret != -ENODATA) {
+		apfs_err(sb, "query failed for ino 0x%llx", apfs_ino(inode));
+		goto fail;
+	}
+
+	apfs_key_set_hdr(APFS_TYPE_INODE, apfs_ino(inode), &raw_key);
+
+	val_len = apfs_build_inode_val(inode, &dentry->d_name, &raw_val);
+	if (val_len < 0) {
+		ret = val_len;
+		goto fail;
+	}
+
+	ret = apfs_btree_insert(query, &raw_key, sizeof(raw_key), raw_val, val_len);
+	if (ret)
+		apfs_err(sb, "insertion failed for ino 0x%llx", apfs_ino(inode));
+	kfree(raw_val);
+
+fail:
+	apfs_free_query(query);
+	return ret;
+}
+int APFS_CREATE_INODE_REC_MAXOPS(void)
+{
+	return 1;
+}
+
+/**
+ * apfs_setsize - Change the size of a regular file
+ * @inode:	the vfs inode
+ * @new_size:	the new size
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_setsize(struct inode *inode, loff_t new_size)
+{
+	struct super_block *sb = inode->i_sb;
+	struct apfs_dstream_info *dstream = &APFS_I(inode)->i_dstream;
+	int err;
+
+	if (new_size == inode->i_size)
+		return 0;
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
+
+	err = apfs_inode_create_dstream_rec(inode);
+	if (err) {
+		apfs_err(sb, "failed to create dstream for ino 0x%llx", apfs_ino(inode));
+		return err;
+	}
+
+	/* Must be called before i_size is changed */
+	err = apfs_truncate(dstream, new_size);
+	if (err) {
+		apfs_err(sb, "truncation failed for ino 0x%llx", apfs_ino(inode));
+		return err;
+	}
+
+	truncate_setsize(inode, new_size);
+	dstream->ds_size = i_size_read(inode);
+	return 0;
+}
+
+int apfs_setattr(struct mnt_idmap *idmap,
+		 struct dentry *dentry, struct iattr *iattr)
+{
+	struct inode *inode = d_inode(dentry);
+	struct super_block *sb = inode->i_sb;
+	struct apfs_max_ops maxops;
+	bool resizing = S_ISREG(inode->i_mode) && (iattr->ia_valid & ATTR_SIZE);
+	int err;
+
+	if (resizing && iattr->ia_size > APFS_MAX_FILE_SIZE)
+		return -EFBIG;
+
+	err = setattr_prepare(&nop_mnt_idmap, dentry, iattr);
+	if (err)
+		return err;
+
+	maxops.cat = APFS_UPDATE_INODE_MAXOPS();
+	maxops.blks = 0;
+
+	/* TODO: figure out why ->write_inode() isn't firing */
+	err = apfs_transaction_start(sb, maxops);
+	if (err)
+		return err;
+	apfs_inode_join_transaction(sb, inode);
+
+	if (resizing) {
+		err = apfs_setsize(inode, iattr->ia_size);
+		if (err) {
+			apfs_err(sb, "setsize failed for ino 0x%llx", apfs_ino(inode));
+			goto fail;
+		}
+	}
+
+	setattr_copy(&nop_mnt_idmap, inode, iattr);
+
+	mark_inode_dirty(inode);
+	err = apfs_transaction_commit(sb);
+	if (err)
+		goto fail;
+	return 0;
+
+fail:
+	apfs_transaction_abort(sb);
+	return err;
+}
+
+int apfs_update_time(struct inode *inode, int flags)
+{
+	struct super_block *sb = inode->i_sb;
+	struct apfs_max_ops maxops;
+	int err;
+
+	maxops.cat = APFS_UPDATE_INODE_MAXOPS();
+	maxops.blks = 0;
+
+	err = apfs_transaction_start(sb, maxops);
+	if (err)
+		return err;
+	apfs_inode_join_transaction(sb, inode);
+
+	generic_update_time(inode, flags);
+
+	err = apfs_transaction_commit(sb);
+	if (err)
+		goto fail;
+	return 0;
+
+fail:
+	apfs_transaction_abort(sb);
+	return err;
+}
+
+static int apfs_ioc_set_dflt_pfk(struct file *file, void __user *user_pfk)
+{
+	struct inode *inode = file_inode(file);
+	struct super_block *sb = inode->i_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_wrapped_crypto_state pfk_hdr;
+	struct apfs_crypto_state_val *pfk;
+	unsigned int key_len;
+
+	if (__copy_from_user(&pfk_hdr, user_pfk, sizeof(pfk_hdr)))
+		return -EFAULT;
+	key_len = le16_to_cpu(pfk_hdr.key_len);
+	if (key_len > MAX_PFK_LEN)
+		return -EFBIG;
+	pfk = kmalloc(sizeof(*pfk) + key_len, GFP_KERNEL);
+	if (!pfk)
+		return -ENOMEM;
+	if (__copy_from_user(&pfk->state, user_pfk, sizeof(pfk_hdr) + key_len)) {
+		kfree(pfk);
+		return -EFAULT;
+	}
+	pfk->refcnt = cpu_to_le32(1);
+
+	down_write(&nxi->nx_big_sem);
+
+	if (sbi->s_dflt_pfk)
+		kfree(sbi->s_dflt_pfk);
+	sbi->s_dflt_pfk = pfk;
+
+	up_write(&nxi->nx_big_sem);
+
+	return 0;
+}
+
+static int apfs_ioc_set_dir_class(struct file *file, u32 __user *user_class)
+{
+	struct inode *inode = file_inode(file);
+	struct apfs_inode_info *ai = APFS_I(inode);
+	struct super_block *sb = inode->i_sb;
+	struct apfs_max_ops maxops;
+	u32 class;
+	int err;
+
+	if (get_user(class, user_class))
+		return -EFAULT;
+
+	ai->i_key_class = class;
+
+	maxops.cat = APFS_UPDATE_INODE_MAXOPS();
+	maxops.blks = 0;
+
+	err = apfs_transaction_start(sb, maxops);
+	if (err)
+		return err;
+	apfs_inode_join_transaction(sb, inode);
+	err = apfs_transaction_commit(sb);
+	if (err)
+		goto fail;
+	return 0;
+
+fail:
+	apfs_transaction_abort(sb);
+	return err;
+}
+
+static int apfs_ioc_set_pfk(struct file *file, void __user *user_pfk)
+{
+	struct inode *inode = file_inode(file);
+	struct super_block *sb = inode->i_sb;
+	struct apfs_wrapped_crypto_state pfk_hdr;
+	struct apfs_crypto_state_val *pfk;
+	struct apfs_inode_info *ai = APFS_I(inode);
+	struct apfs_dstream_info *dstream = &ai->i_dstream;
+	struct apfs_max_ops maxops;
+	unsigned int key_len, key_class;
+	int err;
+
+	if (__copy_from_user(&pfk_hdr, user_pfk, sizeof(pfk_hdr)))
+		return -EFAULT;
+	key_len = le16_to_cpu(pfk_hdr.key_len);
+	if (key_len > MAX_PFK_LEN)
+		return -EFBIG;
+	pfk = kmalloc(sizeof(*pfk) + key_len, GFP_KERNEL);
+	if (!pfk)
+		return -ENOMEM;
+	if (__copy_from_user(&pfk->state, user_pfk, sizeof(pfk_hdr) + key_len)) {
+		kfree(pfk);
+		return -EFAULT;
+	}
+	pfk->refcnt = cpu_to_le32(1);
+
+	maxops.cat = APFS_CRYPTO_SET_KEY_MAXOPS + APFS_UPDATE_INODE_MAXOPS();
+	maxops.blks = 0;
+
+	err = apfs_transaction_start(sb, maxops);
+	if (err) {
+		kfree(pfk);
+		return err;
+	}
+
+	err = apfs_crypto_set_key(sb, dstream->ds_id, pfk);
+	if (err)
+		goto fail;
+
+	key_class = le32_to_cpu(pfk_hdr.persistent_class);
+	if (ai->i_key_class != key_class) {
+		ai->i_key_class = key_class;
+		apfs_inode_join_transaction(sb, inode);
+	}
+
+	err = apfs_transaction_commit(sb);
+	if (err)
+		goto fail;
+	kfree(pfk);
+	return 0;
+
+fail:
+	apfs_transaction_abort(sb);
+	kfree(pfk);
+	return err;
+}
+
+static int apfs_ioc_get_class(struct file *file, u32 __user *user_class)
+{
+	struct inode *inode = file_inode(file);
+	struct apfs_inode_info *ai = APFS_I(inode);
+	u32 class;
+
+	class = ai->i_key_class;
+	if (put_user(class, user_class))
+		return -EFAULT;
+	return 0;
+}
+
+static int apfs_ioc_get_pfk(struct file *file, void __user *user_pfk)
+{
+	struct inode *inode = file_inode(file);
+	struct super_block *sb = inode->i_sb;
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_wrapped_crypto_state pfk_hdr;
+	struct apfs_crypto_state_val *pfk;
+	unsigned int max_len, key_len;
+	struct apfs_dstream_info *dstream = &APFS_I(inode)->i_dstream;
+	int err;
+
+	if (__copy_from_user(&pfk_hdr, user_pfk, sizeof(pfk_hdr)))
+		return -EFAULT;
+	max_len = le16_to_cpu(pfk_hdr.key_len);
+	if (max_len > MAX_PFK_LEN)
+		return -EFBIG;
+	pfk = kmalloc(sizeof(*pfk) + max_len, GFP_KERNEL);
+	if (!pfk)
+		return -ENOMEM;
+
+	down_read(&nxi->nx_big_sem);
+
+	err = apfs_crypto_get_key(sb, dstream->ds_id, pfk, max_len);
+	if (err)
+		goto fail;
+
+	up_read(&nxi->nx_big_sem);
+
+	key_len = le16_to_cpu(pfk->state.key_len);
+	if (__copy_to_user(user_pfk, &pfk->state, sizeof(pfk_hdr) + key_len)) {
+		kfree(pfk);
+		return -EFAULT;
+	}
+
+	kfree(pfk);
+	return 0;
+
+fail:
+	up_read(&nxi->nx_big_sem);
+	kfree(pfk);
+	return err;
+}
+
+/**
+ * apfs_getflags - Read an inode's bsd flags in FS_IOC_GETFLAGS format
+ * @inode: the vfs inode
+ */
+static unsigned int apfs_getflags(struct inode *inode)
+{
+	struct apfs_inode_info *ai = APFS_I(inode);
+	unsigned int flags = 0;
+
+	if (ai->i_bsd_flags & APFS_INOBSD_APPEND)
+		flags |= FS_APPEND_FL;
+	if (ai->i_bsd_flags & APFS_INOBSD_IMMUTABLE)
+		flags |= FS_IMMUTABLE_FL;
+	if (ai->i_bsd_flags & APFS_INOBSD_NODUMP)
+		flags |= FS_NODUMP_FL;
+	return flags;
+}
+
+/**
+ * apfs_setflags - Set an inode's bsd flags
+ * @inode: the vfs inode
+ * @flags: flags to set, in FS_IOC_SETFLAGS format
+ */
+static void apfs_setflags(struct inode *inode, unsigned int flags)
+{
+	struct apfs_inode_info *ai = APFS_I(inode);
+	unsigned int i_flags = 0;
+
+	if (flags & FS_APPEND_FL) {
+		ai->i_bsd_flags |= APFS_INOBSD_APPEND;
+		i_flags |= S_APPEND;
+	} else {
+		ai->i_bsd_flags &= ~APFS_INOBSD_APPEND;
+	}
+
+	if (flags & FS_IMMUTABLE_FL) {
+		ai->i_bsd_flags |= APFS_INOBSD_IMMUTABLE;
+		i_flags |= S_IMMUTABLE;
+	} else {
+		ai->i_bsd_flags &= ~APFS_INOBSD_IMMUTABLE;
+	}
+
+	if (flags & FS_NODUMP_FL)
+		ai->i_bsd_flags |= APFS_INOBSD_NODUMP;
+	else
+		ai->i_bsd_flags &= ~APFS_INOBSD_NODUMP;
+
+	inode_set_flags(inode, i_flags, S_IMMUTABLE | S_APPEND);
+}
+
+int apfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+{
+	unsigned int flags = apfs_getflags(d_inode(dentry));
+
+	fileattr_fill_flags(fa, flags);
+	return 0;
+}
+
+int apfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry, struct fileattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+	struct super_block *sb = inode->i_sb;
+	struct apfs_max_ops maxops;
+	int err;
+
+	if (sb->s_flags & SB_RDONLY)
+		return -EROFS;
+
+	if (fa->flags & ~(FS_APPEND_FL | FS_IMMUTABLE_FL | FS_NODUMP_FL))
+		return -EOPNOTSUPP;
+	if (fileattr_has_fsx(fa))
+		return -EOPNOTSUPP;
+
+	lockdep_assert_held_write(&inode->i_rwsem);
+
+	maxops.cat = APFS_UPDATE_INODE_MAXOPS();
+	maxops.blks = 0;
+	err = apfs_transaction_start(sb, maxops);
+	if (err)
+		return err;
+
+	apfs_inode_join_transaction(sb, inode);
+	apfs_setflags(inode, fa->flags);
+	inode_set_ctime_current(inode);
+
+	err = apfs_transaction_commit(sb);
+	if (err)
+		apfs_transaction_abort(sb);
+	return err;
+}
+
+long apfs_dir_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+
+	switch (cmd) {
+	case APFS_IOC_SET_DFLT_PFK:
+		return apfs_ioc_set_dflt_pfk(file, argp);
+	case APFS_IOC_SET_DIR_CLASS:
+		return apfs_ioc_set_dir_class(file, argp);
+	case APFS_IOC_GET_CLASS:
+		return apfs_ioc_get_class(file, argp);
+	case APFS_IOC_TAKE_SNAPSHOT:
+		return apfs_ioc_take_snapshot(file, argp);
+	default:
+		return -ENOTTY;
+	}
+}
+
+long apfs_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+
+	switch (cmd) {
+	case APFS_IOC_SET_PFK:
+		return apfs_ioc_set_pfk(file, argp);
+	case APFS_IOC_GET_CLASS:
+		return apfs_ioc_get_class(file, argp);
+	case APFS_IOC_GET_PFK:
+		return apfs_ioc_get_pfk(file, argp);
+	default:
+		return -ENOTTY;
+	}
+}
diff --git a/drivers/staging/apfs/key.c b/drivers/staging/apfs/key.c
new file mode 100644
index 0000000000000000000000000000000000000000..96cfa4a6ca876565de033bc5ddde36df3a31d420
--- /dev/null
+++ b/drivers/staging/apfs/key.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2018 Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
+ */
+
+#include <linux/crc32c.h>
+#include "apfs.h"
+#include "unicode.h"
+
+/**
+ * apfs_filename_cmp - Normalize and compare two APFS filenames
+ * @sb:		filesystem superblock
+ * @name1:	first name to compare
+ * @len1:	length of @name1
+ * @name2:	second name to compare
+ * @len2:	length of the @name2
+ *
+ * Returns 0 if @name1 and @name2 are equal, or non-zero otherwise.
+ */
+int apfs_filename_cmp(struct super_block *sb,
+		      const char *name1, unsigned int len1,
+		      const char *name2, unsigned int len2)
+{
+	struct apfs_unicursor cursor1, cursor2;
+	bool case_fold = apfs_is_case_insensitive(sb);
+
+	if (!apfs_is_normalization_insensitive(sb)) {
+		if (len1 != len2)
+			return -1;
+		return memcmp(name1, name2, len1);
+	}
+
+	apfs_init_unicursor(&cursor1, name1, len1);
+	apfs_init_unicursor(&cursor2, name2, len2);
+
+	while (1) {
+		unicode_t uni1, uni2;
+
+		uni1 = apfs_normalize_next(&cursor1, case_fold);
+		uni2 = apfs_normalize_next(&cursor2, case_fold);
+
+		if (uni1 != uni2)
+			return uni1 < uni2 ? -1 : 1;
+		if (!uni1)
+			return 0;
+	}
+}
+
+/**
+ * apfs_keycmp - Compare two keys
+ * @k1:	first key to compare
+ * @k2:	second key to compare
+ *
+ * returns   0 if @k1 and @k2 are equal
+ *	   < 0 if @k1 comes before @k2 in the btree
+ *	   > 0 if @k1 comes after @k2 in the btree
+ */
+int apfs_keycmp(struct apfs_key *k1, struct apfs_key *k2)
+{
+	if (k1->id != k2->id)
+		return k1->id < k2->id ? -1 : 1;
+	if (k1->type != k2->type)
+		return k1->type < k2->type ? -1 : 1;
+	if (k1->number != k2->number)
+		return k1->number < k2->number ? -1 : 1;
+	if (!k1->name || !k2->name)
+		return 0;
+
+	/* Normalization seems to be ignored here, even for directory records */
+	return strcmp(k1->name, k2->name);
+}
+
+/**
+ * apfs_read_cat_key - Parse an on-disk catalog key
+ * @raw:	pointer to the raw key
+ * @size:	size of the raw key
+ * @key:	apfs_key structure to store the result
+ * @hashed:	are the directory records hashed?
+ *
+ * Returns 0 on success, or a negative error code otherwise.
+ */
+int apfs_read_cat_key(void *raw, int size, struct apfs_key *key, bool hashed)
+{
+	if (size < sizeof(struct apfs_key_header)) {
+		apfs_err(NULL, "bad key length (%d)", size);
+		return -EFSCORRUPTED;
+	}
+	key->id = apfs_cat_cnid((struct apfs_key_header *)raw);
+	key->type = apfs_cat_type((struct apfs_key_header *)raw);
+
+	switch (key->type) {
+	case APFS_TYPE_DIR_REC:
+		if (hashed) {
+			if (size < sizeof(struct apfs_drec_hashed_key) + 1 ||
+			    *((char *)raw + size - 1) != 0) {
+				/* Filename must have NULL-termination */
+				apfs_err(NULL, "invalid drec key (%d)", size);
+				return -EFSCORRUPTED;
+			}
+			/* Name length is not used in key comparisons, only the hash */
+			key->number = le32_to_cpu(
+			      ((struct apfs_drec_hashed_key *)raw)->name_len_and_hash) &
+								    APFS_DREC_HASH_MASK;
+			key->name = ((struct apfs_drec_hashed_key *)raw)->name;
+		} else {
+			if (size < sizeof(struct apfs_drec_key) + 1 ||
+			    *((char *)raw + size - 1) != 0) {
+				/* Filename must have NULL-termination */
+				apfs_err(NULL, "invalid drec key (%d)", size);
+				return -EFSCORRUPTED;
+			}
+			/* There's no hash */
+			key->number = 0;
+			key->name = ((struct apfs_drec_key *)raw)->name;
+		}
+		break;
+	case APFS_TYPE_XATTR:
+		if (size < sizeof(struct apfs_xattr_key) + 1 ||
+		    *((char *)raw + size - 1) != 0) {
+			/* xattr name must have NULL-termination */
+			apfs_err(NULL, "invalid xattr key (%d)", size);
+			return -EFSCORRUPTED;
+		}
+		key->number = 0;
+		key->name = ((struct apfs_xattr_key *)raw)->name;
+		break;
+	case APFS_TYPE_FILE_EXTENT:
+		if (size != sizeof(struct apfs_file_extent_key)) {
+			apfs_err(NULL, "bad key length (%d)", size);
+			return -EFSCORRUPTED;
+		}
+		key->number = le64_to_cpu(
+			((struct apfs_file_extent_key *)raw)->logical_addr);
+		key->name = NULL;
+		break;
+	case APFS_TYPE_SIBLING_LINK:
+		if (size != sizeof(struct apfs_sibling_link_key)) {
+			apfs_err(NULL, "bad key length (%d)", size);
+			return -EFSCORRUPTED;
+		}
+		key->number = le64_to_cpu(
+			((struct apfs_sibling_link_key *)raw)->sibling_id);
+		key->name = NULL;
+		break;
+	default:
+		key->number = 0;
+		key->name = NULL;
+		break;
+	}
+
+	return 0;
+}
+
+int apfs_read_fext_key(void *raw, int size, struct apfs_key *key)
+{
+	struct apfs_fext_tree_key *raw_key;
+
+	if (size != sizeof(*raw_key)) {
+		apfs_err(NULL, "bad key length (%d)", size);
+		return -EFSCORRUPTED;
+	}
+	raw_key = raw;
+
+	key->id = le64_to_cpu(raw_key->private_id);
+	key->type = 0;
+	key->number = le64_to_cpu(raw_key->logical_addr);
+	key->name = NULL;
+	return 0;
+}
+
+/**
+ * apfs_read_free_queue_key - Parse an on-disk free queue key
+ * @raw:	pointer to the raw key
+ * @size:	size of the raw key
+ * @key:	apfs_key structure to store the result
+ *
+ * Returns 0 on success, or a negative error code otherwise.
+ */
+int apfs_read_free_queue_key(void *raw, int size, struct apfs_key *key)
+{
+	struct apfs_spaceman_free_queue_key *raw_key;
+
+	if (size != sizeof(*raw_key)) {
+		apfs_err(NULL, "bad key length (%d)", size);
+		return -EFSCORRUPTED;
+	}
+	raw_key = raw;
+
+	key->id = le64_to_cpu(raw_key->sfqk_xid);
+	key->type = 0;
+	key->number = le64_to_cpu(raw_key->sfqk_paddr);
+	key->name = NULL;
+
+	return 0;
+}
+
+/**
+ * apfs_read_omap_key - Parse an on-disk object map key
+ * @raw:	pointer to the raw key
+ * @size:	size of the raw key
+ * @key:	apfs_key structure to store the result
+ *
+ * Returns 0 on success, or a negative error code otherwise.
+ */
+int apfs_read_omap_key(void *raw, int size, struct apfs_key *key)
+{
+	struct apfs_omap_key *raw_key;
+
+	if (size != sizeof(*raw_key)) {
+		apfs_err(NULL, "bad key length (%d)", size);
+		return -EFSCORRUPTED;
+	}
+	raw_key = raw;
+
+	key->id = le64_to_cpu(raw_key->ok_oid);
+	key->type = 0;
+	key->number = le64_to_cpu(raw_key->ok_xid);
+	key->name = NULL;
+
+	return 0;
+}
+
+/**
+ * apfs_read_extentref_key - Parse an on-disk extent reference tree key
+ * @raw:	pointer to the raw key
+ * @size:	size of the raw key
+ * @key:	apfs_key structure to store the result
+ *
+ * Returns 0 on success, or a negative error code otherwise.
+ */
+int apfs_read_extentref_key(void *raw, int size, struct apfs_key *key)
+{
+	if (size != sizeof(struct apfs_phys_ext_key)) {
+		apfs_err(NULL, "bad key length (%d)", size);
+		return -EFSCORRUPTED;
+	}
+	key->id = apfs_cat_cnid((struct apfs_key_header *)raw);
+	key->type = apfs_cat_type((struct apfs_key_header *)raw);
+	key->number = 0;
+	key->name = NULL;
+	return 0;
+}
+
+int apfs_read_snap_meta_key(void *raw, int size, struct apfs_key *key)
+{
+	if (size < sizeof(struct apfs_key_header)) {
+		apfs_err(NULL, "bad key length (%d)", size);
+		return -EFSCORRUPTED;
+	}
+	key->id = apfs_cat_cnid((struct apfs_key_header *)raw);
+	key->type = apfs_cat_type((struct apfs_key_header *)raw);
+	key->number = 0;
+
+	switch (key->type) {
+	case APFS_TYPE_SNAP_METADATA:
+		if (size != sizeof(struct apfs_snap_metadata_key)) {
+			apfs_err(NULL, "bad key length (%d)", size);
+			return -EFSCORRUPTED;
+		}
+		key->name = NULL;
+		return 0;
+	case APFS_TYPE_SNAP_NAME:
+		if (size < sizeof(struct apfs_snap_name_key) + 1 || *((char *)raw + size - 1) != 0) {
+			/* snapshot name must have NULL-termination */
+			apfs_err(NULL, "invalid snap name key (%d)", size);
+			return -EFSCORRUPTED;
+		}
+		key->name = ((struct apfs_snap_name_key *)raw)->name;
+		return 0;
+	default:
+		return -EFSCORRUPTED;
+	}
+}
+
+int apfs_read_omap_snap_key(void *raw, int size, struct apfs_key *key)
+{
+	__le64 *xid = NULL;
+
+	if (size != sizeof(*xid)) {
+		apfs_err(NULL, "bad key length (%d)", size);
+		return -EFSCORRUPTED;
+	}
+	xid = raw;
+
+	key->id = le64_to_cpup(xid);
+	key->number = 0;
+	key->name = NULL;
+	key->type = 0;
+	return 0;
+}
+
+/**
+ * apfs_init_drec_key - Initialize an in-memory key for a dentry query
+ * @sb:		filesystem superblock
+ * @ino:	inode number of the parent directory
+ * @name:	filename (NULL for a multiple query)
+ * @name_len:	filename length (0 if NULL)
+ * @key:	apfs_key structure to initialize
+ */
+void apfs_init_drec_key(struct super_block *sb, u64 ino, const char *name,
+			unsigned int name_len, struct apfs_key *key)
+{
+	struct apfs_unicursor cursor;
+	bool case_fold = apfs_is_case_insensitive(sb);
+	u32 hash = 0xFFFFFFFF;
+
+	key->id = ino;
+	key->type = APFS_TYPE_DIR_REC;
+	if (!apfs_is_normalization_insensitive(sb)) {
+		key->name = name;
+		key->number = 0;
+		return;
+	}
+
+	/* To respect normalization, queries can only consider the hash */
+	key->name = NULL;
+
+	if (!name) {
+		key->number = 0;
+		return;
+	}
+
+	apfs_init_unicursor(&cursor, name, name_len);
+
+	while (1) {
+		unicode_t utf32;
+
+		utf32 = apfs_normalize_next(&cursor, case_fold);
+		if (!utf32)
+			break;
+
+		hash = crc32c(hash, &utf32, sizeof(utf32));
+	}
+
+	/* The filename length doesn't matter, so it's left as zero */
+	key->number = hash << APFS_DREC_HASH_SHIFT;
+}
diff --git a/drivers/staging/apfs/message.c b/drivers/staging/apfs/message.c
new file mode 100644
index 0000000000000000000000000000000000000000..fdd74ccb8e37924df14488d1ff3fca6d76c73b3b
--- /dev/null
+++ b/drivers/staging/apfs/message.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2018 Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
+ */
+
+#include <linux/fs.h>
+#include "apfs.h"
+
+void apfs_msg(struct super_block *sb, const char *prefix, const char *func, int line, const char *fmt, ...)
+{
+	char *sb_id = NULL;
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	/* The superblock is not available to all callers */
+	sb_id = sb ? sb->s_id : "?";
+
+	if (func)
+		printk("%sAPFS (%s): %pV (%s:%d)\n", prefix, sb_id, &vaf, func, line);
+	else
+		printk("%sAPFS (%s): %pV\n", prefix, sb_id, &vaf);
+
+	va_end(args);
+}
diff --git a/drivers/staging/apfs/namei.c b/drivers/staging/apfs/namei.c
new file mode 100644
index 0000000000000000000000000000000000000000..d6458c402d228e32d25c91b7560363952b94a7ac
--- /dev/null
+++ b/drivers/staging/apfs/namei.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2018 Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
+ * Copyright (C) 2025 Ethan Carter Edwards <ethan@ethancedwards.com>
+ */
+
+#include <linux/namei.h>
+#include "apfs.h"
+#include "unicode.h"
+
+static struct dentry *apfs_lookup(struct inode *dir, struct dentry *dentry,
+				  unsigned int flags)
+{
+	struct inode *inode = NULL;
+	u64 ino = 0;
+	int err;
+
+	if (dentry->d_name.len > APFS_NAME_LEN)
+		return ERR_PTR(-ENAMETOOLONG);
+
+	err = apfs_inode_by_name(dir, &dentry->d_name, &ino);
+	if (err && err != -ENODATA) {
+		apfs_err(dir->i_sb, "inode lookup by name failed");
+		return ERR_PTR(err);
+	}
+
+	if (!err) {
+		inode = apfs_iget(dir->i_sb, ino);
+		if (IS_ERR(inode)) {
+			apfs_err(dir->i_sb, "iget failed");
+			return ERR_CAST(inode);
+		}
+	}
+
+	return d_splice_alias(inode, dentry);
+}
+
+static int apfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
+			struct dentry *dentry, const char *symname)
+{
+	/* Symlink permissions don't mean anything and their value is fixed */
+	return apfs_mkany(dir, dentry, S_IFLNK | 0x1ed, 0 /* rdev */, symname);
+}
+
+const struct inode_operations apfs_dir_inode_operations = {
+	.create		= apfs_create,
+	.lookup		= apfs_lookup,
+	.link		= apfs_link,
+	.unlink		= apfs_unlink,
+	.symlink	= apfs_symlink,
+	.mkdir		= apfs_mkdir,
+	.rmdir		= apfs_rmdir,
+	.mknod		= apfs_mknod,
+	.rename		= apfs_rename,
+	.getattr	= apfs_getattr,
+	.listxattr      = apfs_listxattr,
+	.setattr	= apfs_setattr,
+	.update_time	= apfs_update_time,
+	.fileattr_get	= apfs_fileattr_get,
+	.fileattr_set	= apfs_fileattr_set,
+};
+
+const struct inode_operations apfs_special_inode_operations = {
+	.getattr	= apfs_getattr,
+	.listxattr      = apfs_listxattr,
+	.setattr	= apfs_setattr,
+	.update_time	= apfs_update_time,
+};
+
+static int apfs_dentry_hash(const struct dentry *dir, struct qstr *child)
+{
+	struct apfs_unicursor cursor;
+	unsigned long hash;
+	bool case_fold = apfs_is_case_insensitive(dir->d_sb);
+
+	if (!apfs_is_normalization_insensitive(dir->d_sb))
+		return 0;
+
+	apfs_init_unicursor(&cursor, child->name, child->len);
+	hash = init_name_hash(dir);
+
+	while (1) {
+		int i;
+		unicode_t utf32;
+
+		utf32 = apfs_normalize_next(&cursor, case_fold);
+		if (!utf32)
+			break;
+
+		/* Hash the unicode character one byte at a time */
+		for (i = 0; i < 4; ++i) {
+			hash = partial_name_hash((u8)utf32, hash);
+			utf32 = utf32 >> 8;
+		}
+	}
+	child->hash = end_name_hash(hash);
+
+	/* TODO: return error instead of truncating invalid UTF-8? */
+	return 0;
+}
+
+static int apfs_dentry_compare(const struct dentry *dentry, unsigned int len,
+			       const char *str, const struct qstr *name)
+{
+	return apfs_filename_cmp(dentry->d_sb, name->name, name->len, str, len);
+}
+
+static int apfs_dentry_revalidate(struct inode *dir, const struct qstr *name, struct dentry *dentry, unsigned int flags)
+{
+	struct super_block *sb = dentry->d_sb;
+
+	if (flags & LOOKUP_RCU)
+		return -ECHILD;
+
+	/*
+	 * If we want to create a link with a name that normalizes to the same
+	 * as an existing negative dentry, then we first need to invalidate the
+	 * dentry; otherwise it would keep the existing name.
+	 */
+	if (d_really_is_positive(dentry))
+		return 1;
+	if (!apfs_is_case_insensitive(sb) && !apfs_is_normalization_insensitive(sb))
+		return 1;
+	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET))
+		return 0;
+	return 1;
+}
+
+const struct dentry_operations apfs_dentry_operations = {
+	.d_revalidate	= apfs_dentry_revalidate,
+	.d_hash		= apfs_dentry_hash,
+	.d_compare	= apfs_dentry_compare,
+};
diff --git a/drivers/staging/apfs/node.c b/drivers/staging/apfs/node.c
new file mode 100644
index 0000000000000000000000000000000000000000..cc332da432fde02b6877e181a497f89cc8ec88b6
--- /dev/null
+++ b/drivers/staging/apfs/node.c
@@ -0,0 +1,2069 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2018 Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
+ */
+
+#include <linux/slab.h>
+#include <linux/buffer_head.h>
+#include "apfs.h"
+
+/**
+ * apfs_node_is_valid - Check basic sanity of the node index
+ * @sb:		filesystem superblock
+ * @node:	node to check
+ *
+ * Verifies that the node index fits in a single block, and that the number
+ * of records fits in the index. Without this check a crafted filesystem could
+ * pretend to have too many records, and calls to apfs_node_locate_key() and
+ * apfs_node_locate_value() would read beyond the limits of the node.
+ */
+static bool apfs_node_is_valid(struct super_block *sb,
+			       struct apfs_node *node)
+{
+	u32 records = node->records;
+	int index_size = node->key - sizeof(struct apfs_btree_node_phys);
+	int entry_size;
+
+	if (node->key > sb->s_blocksize)
+		return false;
+
+	entry_size = (apfs_node_has_fixed_kv_size(node)) ?
+		sizeof(struct apfs_kvoff) : sizeof(struct apfs_kvloc);
+
+	/* Coarse bound to prevent multiplication overflow in final check */
+	if (records > 1 << 16)
+		return false;
+
+	return records * entry_size <= index_size;
+}
+
+void apfs_node_free(struct apfs_node *node)
+{
+	struct apfs_object *obj = NULL;
+
+	if (!node)
+		return;
+	obj = &node->object;
+
+	if (obj->o_bh) {
+		brelse(obj->o_bh);
+		obj->o_bh = NULL;
+	} else if (!obj->ephemeral) {
+		/* Ephemeral data always remains in memory */
+		kfree(obj->data);
+	}
+	obj->data = NULL;
+
+	kfree(node);
+}
+
+/**
+ * apfs_read_node - Read a node header from disk
+ * @sb:		filesystem superblock
+ * @oid:	object id for the node
+ * @storage:	storage type for the node object
+ * @write:	request write access?
+ *
+ * Returns ERR_PTR in case of failure, otherwise return a pointer to the
+ * resulting apfs_node structure with the initial reference taken.
+ *
+ * For now we assume the node has not been read before.
+ */
+struct apfs_node *apfs_read_node(struct super_block *sb, u64 oid, u32 storage,
+				 bool write)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct buffer_head *bh = NULL;
+	struct apfs_ephemeral_object_info *eph_info = NULL;
+	struct apfs_btree_node_phys *raw = NULL;
+	struct apfs_node *node = NULL;
+	struct apfs_nloc *free_head = NULL;
+	u64 bno;
+	int err;
+
+	switch (storage) {
+	case APFS_OBJ_VIRTUAL:
+		/* All virtual nodes are inside a volume, at least for now */
+		err = apfs_omap_lookup_block(sb, sbi->s_omap, oid, &bno, write);
+		if (err) {
+			apfs_err(sb, "omap lookup failed for oid 0x%llx", oid);
+			return ERR_PTR(err);
+		}
+		/* CoW has already been done, don't worry about snapshots */
+		bh = apfs_read_object_block(sb, bno, write, false /* preserve */);
+		if (IS_ERR(bh)) {
+			apfs_err(sb, "object read failed for bno 0x%llx", bno);
+			return (void *)bh;
+		}
+		bno = bh->b_blocknr;
+		raw = (struct apfs_btree_node_phys *)bh->b_data;
+		break;
+	case APFS_OBJ_PHYSICAL:
+		bh = apfs_read_object_block(sb, oid, write, false /* preserve */);
+		if (IS_ERR(bh)) {
+			apfs_err(sb, "object read failed for bno 0x%llx", oid);
+			return (void *)bh;
+		}
+		bno = oid = bh->b_blocknr;
+		raw = (struct apfs_btree_node_phys *)bh->b_data;
+		break;
+	case APFS_OBJ_EPHEMERAL:
+		/* Ephemeral objects are already in memory */
+		eph_info = apfs_ephemeral_object_lookup(sb, oid);
+		if (IS_ERR(eph_info)) {
+			apfs_err(sb, "no ephemeral node for oid 0x%llx", oid);
+			return (void *)eph_info;
+		}
+		if (eph_info->size != sb->s_blocksize) {
+			apfs_err(sb, "unsupported size for ephemeral node (%u)", eph_info->size);
+			return ERR_PTR(-EOPNOTSUPP);
+		}
+		bno = 0; /* In memory, so meaningless */
+		raw = eph_info->object;
+		/* Only for consistency, will happen again on commit */
+		if (write)
+			raw->btn_o.o_xid = cpu_to_le64(nxi->nx_xid);
+		break;
+	default:
+		apfs_alert(sb, "invalid storage type %u - bug!", storage);
+		return ERR_PTR(-EINVAL);
+	}
+
+	node = kmalloc(sizeof(*node), GFP_KERNEL);
+	if (!node) {
+		brelse(bh);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	node->tree_type = le32_to_cpu(raw->btn_o.o_subtype);
+	node->flags = le16_to_cpu(raw->btn_flags);
+	node->records = le32_to_cpu(raw->btn_nkeys);
+	node->key = sizeof(*raw) + le16_to_cpu(raw->btn_table_space.off)
+				+ le16_to_cpu(raw->btn_table_space.len);
+	node->free = node->key + le16_to_cpu(raw->btn_free_space.off);
+	node->val = node->free + le16_to_cpu(raw->btn_free_space.len);
+
+	free_head = &raw->btn_key_free_list;
+	node->key_free_list_len = le16_to_cpu(free_head->len);
+	free_head = &raw->btn_val_free_list;
+	node->val_free_list_len = le16_to_cpu(free_head->len);
+
+	node->object.sb = sb;
+	node->object.block_nr = bno;
+	node->object.oid = oid;
+	node->object.o_bh = bh;
+	node->object.data = (char *)raw;
+	node->object.ephemeral = !bh;
+
+	/* Ephemeral objects already got checked on mount */
+	if (!node->object.ephemeral && nxi->nx_flags & APFS_CHECK_NODES && !apfs_obj_verify_csum(sb, bh)) {
+		/* TODO: don't check this twice for virtual/physical objects */
+		apfs_err(sb, "bad checksum for node in block 0x%llx", (unsigned long long)bno);
+		apfs_node_free(node);
+		return ERR_PTR(-EFSBADCRC);
+	}
+	if (!apfs_node_is_valid(sb, node)) {
+		apfs_err(sb, "bad node in block 0x%llx", (unsigned long long)bno);
+		apfs_node_free(node);
+		return ERR_PTR(-EFSCORRUPTED);
+	}
+
+	return node;
+}
+
+/**
+ * apfs_node_min_table_size - Return the minimum size for a node's toc
+ * @sb:		superblock structure
+ * @type:	tree type for the node
+ * @flags:	flags for the node
+ */
+static int apfs_node_min_table_size(struct super_block *sb, u32 type, u16 flags)
+{
+	bool leaf = flags & APFS_BTNODE_LEAF;
+	int key_size, val_size, toc_size;
+	int space, count;
+
+	/* Preallocate the whole table for trees with fixed key/value sizes */
+	switch (type) {
+	case APFS_OBJECT_TYPE_OMAP:
+		key_size = sizeof(struct apfs_omap_key);
+		val_size = leaf ? sizeof(struct apfs_omap_val) : sizeof(__le64);
+		toc_size = sizeof(struct apfs_kvoff);
+		break;
+	case APFS_OBJECT_TYPE_SPACEMAN_FREE_QUEUE:
+		key_size = sizeof(struct apfs_spaceman_free_queue_key);
+		val_size = sizeof(__le64); /* We assume no ghosts here */
+		toc_size = sizeof(struct apfs_kvoff);
+		break;
+	case APFS_OBJECT_TYPE_OMAP_SNAPSHOT:
+		key_size = sizeof(__le64);
+		val_size = leaf ? sizeof(struct apfs_omap_snapshot) : sizeof(__le64);
+		toc_size = sizeof(struct apfs_kvoff);
+		break;
+	case APFS_OBJECT_TYPE_FEXT_TREE:
+		key_size = sizeof(struct apfs_fext_tree_key);
+		val_size = leaf ? sizeof(struct apfs_fext_tree_val) : sizeof(__le64);
+		toc_size = sizeof(struct apfs_kvoff);
+		break;
+	default:
+		/* Make room for one record at least */
+		toc_size = sizeof(struct apfs_kvloc);
+		return APFS_BTREE_TOC_ENTRY_INCREMENT * toc_size;
+	}
+
+	/* The footer of root nodes is ignored for some reason */
+	space = sb->s_blocksize - sizeof(struct apfs_btree_node_phys);
+	count = space / (key_size + val_size + toc_size);
+	return count * toc_size;
+}
+
+/**
+ * apfs_set_empty_btree_info - Set the info footer for an empty b-tree node
+ * @sb:		filesystem superblock
+ * @info:	pointer to the on-disk info footer
+ * @subtype:	subtype of the root node, i.e., tree type
+ *
+ * For now only supports the extent reference tree.
+ */
+static void apfs_set_empty_btree_info(struct super_block *sb, struct apfs_btree_info *info, u32 subtype)
+{
+	u32 flags;
+
+	ASSERT(subtype == APFS_OBJECT_TYPE_BLOCKREFTREE || subtype == APFS_OBJECT_TYPE_OMAP_SNAPSHOT);
+
+	memset(info, 0, sizeof(*info));
+
+	flags = APFS_BTREE_PHYSICAL;
+	if (subtype == APFS_OBJECT_TYPE_BLOCKREFTREE)
+		flags |= APFS_BTREE_KV_NONALIGNED;
+
+	info->bt_fixed.bt_flags = cpu_to_le32(flags);
+	info->bt_fixed.bt_node_size = cpu_to_le32(sb->s_blocksize);
+	info->bt_key_count = 0;
+	info->bt_node_count = cpu_to_le64(1); /* Only one node: the root */
+	if (subtype == APFS_OBJECT_TYPE_BLOCKREFTREE)
+		return;
+
+	info->bt_fixed.bt_key_size = cpu_to_le32(8);
+	info->bt_longest_key = info->bt_fixed.bt_key_size;
+	info->bt_fixed.bt_val_size = cpu_to_le32(sizeof(struct apfs_omap_snapshot));
+	info->bt_longest_val = info->bt_fixed.bt_val_size;
+}
+
+/**
+ * apfs_make_empty_btree_root - Make an empty root for a b-tree
+ * @sb:		filesystem superblock
+ * @subtype:	subtype of the root node, i.e., tree type
+ * @oid:	on return, the root's object id
+ *
+ * For now only supports the extent reference tree and an omap's snapshot tree.
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+int apfs_make_empty_btree_root(struct super_block *sb, u32 subtype, u64 *oid)
+{
+	struct apfs_superblock *vsb_raw = APFS_SB(sb)->s_vsb_raw;
+	struct apfs_btree_node_phys *root = NULL;
+	struct buffer_head *bh = NULL;
+	u64 bno;
+	u16 flags;
+	int toc_len, free_len, head_len, info_len;
+	int err;
+
+	ASSERT(subtype == APFS_OBJECT_TYPE_BLOCKREFTREE || subtype == APFS_OBJECT_TYPE_OMAP_SNAPSHOT);
+
+	err = apfs_spaceman_allocate_block(sb, &bno, true /* backwards */);
+	if (err) {
+		apfs_err(sb, "block allocation failed");
+		return err;
+	}
+	apfs_assert_in_transaction(sb, &vsb_raw->apfs_o);
+	le64_add_cpu(&vsb_raw->apfs_fs_alloc_count, 1);
+	le64_add_cpu(&vsb_raw->apfs_total_blocks_alloced, 1);
+
+	bh = apfs_getblk(sb, bno);
+	if (!bh)
+		return -EIO;
+	root = (void *)bh->b_data;
+	err = apfs_transaction_join(sb, bh);
+	if (err)
+		goto fail;
+	set_buffer_csum(bh);
+
+	flags = APFS_BTNODE_ROOT | APFS_BTNODE_LEAF;
+	if (subtype == APFS_OBJECT_TYPE_OMAP_SNAPSHOT)
+		flags |= APFS_BTNODE_FIXED_KV_SIZE;
+	root->btn_flags = cpu_to_le16(flags);
+
+	toc_len = apfs_node_min_table_size(sb, subtype, flags);
+	head_len = sizeof(*root);
+	info_len = sizeof(struct apfs_btree_info);
+	free_len = sb->s_blocksize - head_len - toc_len - info_len;
+
+	root->btn_level = 0; /* Root */
+
+	/* No keys and no values, so this is straightforward */
+	root->btn_nkeys = 0;
+	root->btn_table_space.off = 0;
+	root->btn_table_space.len = cpu_to_le16(toc_len);
+	root->btn_free_space.off = 0;
+	root->btn_free_space.len = cpu_to_le16(free_len);
+
+	/* No fragmentation */
+	root->btn_key_free_list.off = cpu_to_le16(APFS_BTOFF_INVALID);
+	root->btn_key_free_list.len = 0;
+	root->btn_val_free_list.off = cpu_to_le16(APFS_BTOFF_INVALID);
+	root->btn_val_free_list.len = 0;
+
+	apfs_set_empty_btree_info(sb, (void *)root + sb->s_blocksize - info_len, subtype);
+
+	root->btn_o.o_oid = cpu_to_le64(bno);
+	root->btn_o.o_xid = cpu_to_le64(APFS_NXI(sb)->nx_xid);
+	root->btn_o.o_type = cpu_to_le32(APFS_OBJECT_TYPE_BTREE | APFS_OBJ_PHYSICAL);
+	root->btn_o.o_subtype = cpu_to_le32(subtype);
+
+	*oid = bno;
+	err = 0;
+fail:
+	root = NULL;
+	brelse(bh);
+	bh = NULL;
+	return err;
+}
+
+/**
+ * apfs_create_node - Allocates a new nonroot b-tree node on disk
+ * @sb:		filesystem superblock
+ * @storage:	storage type for the node object
+ *
+ * On success returns a pointer to the new in-memory node structure; the object
+ * header is initialized, and the node fields are given reasonable defaults.
+ * On failure, returns an error pointer.
+ */
+static struct apfs_node *apfs_create_node(struct super_block *sb, u32 storage)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_nx_superblock *msb_raw = nxi->nx_raw;
+	struct apfs_superblock *vsb_raw = sbi->s_vsb_raw;
+	struct apfs_ephemeral_object_info *eph_info = NULL;
+	struct apfs_node *node = NULL;
+	struct buffer_head *bh = NULL;
+	struct apfs_btree_node_phys *raw = NULL;
+	u64 bno, oid;
+	int err;
+
+	switch (storage) {
+	case APFS_OBJ_VIRTUAL:
+		err = apfs_spaceman_allocate_block(sb, &bno, true /* backwards */);
+		if (err) {
+			apfs_err(sb, "block allocation failed");
+			return ERR_PTR(err);
+		}
+		apfs_assert_in_transaction(sb, &vsb_raw->apfs_o);
+		le64_add_cpu(&vsb_raw->apfs_fs_alloc_count, 1);
+		le64_add_cpu(&vsb_raw->apfs_total_blocks_alloced, 1);
+
+		oid = le64_to_cpu(msb_raw->nx_next_oid);
+		le64_add_cpu(&msb_raw->nx_next_oid, 1);
+		err = apfs_create_omap_rec(sb, oid, bno);
+		if (err) {
+			apfs_err(sb, "omap rec creation failed (0x%llx-0x%llx)", oid, bno);
+			return ERR_PTR(err);
+		}
+		break;
+	case APFS_OBJ_PHYSICAL:
+		err = apfs_spaceman_allocate_block(sb, &bno, true /* backwards */);
+		if (err) {
+			apfs_err(sb, "block allocation failed");
+			return ERR_PTR(err);
+		}
+		/* We don't write to the container's omap */
+		apfs_assert_in_transaction(sb, &vsb_raw->apfs_o);
+		le64_add_cpu(&vsb_raw->apfs_fs_alloc_count, 1);
+		le64_add_cpu(&vsb_raw->apfs_total_blocks_alloced, 1);
+		oid = bno;
+		break;
+	case APFS_OBJ_EPHEMERAL:
+		if (nxi->nx_eph_count >= APFS_EPHEMERAL_LIST_LIMIT) {
+			apfs_err(sb, "creating too many ephemeral objects?");
+			return ERR_PTR(-EOPNOTSUPP);
+		}
+		eph_info = &nxi->nx_eph_list[nxi->nx_eph_count++];
+		eph_info->object = kzalloc(sb->s_blocksize, GFP_KERNEL);
+		if (!eph_info->object)
+			return ERR_PTR(-ENOMEM);
+		eph_info->size = sb->s_blocksize;
+		oid = eph_info->oid = le64_to_cpu(msb_raw->nx_next_oid);
+		le64_add_cpu(&msb_raw->nx_next_oid, 1);
+		break;
+	default:
+		apfs_alert(sb, "invalid storage type %u - bug!", storage);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (storage == APFS_OBJ_EPHEMERAL) {
+		bh = NULL;
+		bno = 0;
+		raw = eph_info->object;
+	} else {
+		bh = apfs_getblk(sb, bno);
+		if (!bh)
+			return ERR_PTR(-EIO);
+		bno = bh->b_blocknr;
+		raw = (void *)bh->b_data;
+		err = apfs_transaction_join(sb, bh);
+		if (err)
+			goto fail;
+		set_buffer_csum(bh);
+	}
+
+	/* Set most of the object header, but the subtype is up to the caller */
+	raw->btn_o.o_oid = cpu_to_le64(oid);
+	raw->btn_o.o_xid = cpu_to_le64(nxi->nx_xid);
+	raw->btn_o.o_type = cpu_to_le32(storage | APFS_OBJECT_TYPE_BTREE_NODE);
+	raw->btn_o.o_subtype = 0;
+
+	/* The caller is expected to change most node fields */
+	raw->btn_flags = 0;
+	raw->btn_level = 0;
+	raw->btn_nkeys = 0;
+	raw->btn_table_space.off = 0; /* Put the toc right after the header */
+	raw->btn_table_space.len = 0;
+	raw->btn_free_space.off = 0;
+	raw->btn_free_space.len = cpu_to_le16(sb->s_blocksize - sizeof(*raw));
+	raw->btn_key_free_list.off = cpu_to_le16(APFS_BTOFF_INVALID);
+	raw->btn_key_free_list.len = 0;
+	raw->btn_val_free_list.off = cpu_to_le16(APFS_BTOFF_INVALID);
+	raw->btn_val_free_list.len = 0;
+
+	node = kmalloc(sizeof(*node), GFP_KERNEL);
+	if (!node) {
+		err = -ENOMEM;
+		goto fail;
+	}
+
+	node->object.sb = sb;
+	node->object.block_nr = bno;
+	node->object.oid = oid;
+	node->object.o_bh = bh;
+	node->object.data = (char *)raw;
+	node->object.ephemeral = !bh;
+	return node;
+
+fail:
+	if (storage == APFS_OBJ_EPHEMERAL)
+		kfree(raw);
+	else
+		brelse(bh);
+	raw = NULL;
+	bh = NULL;
+	return ERR_PTR(err);
+}
+
+/**
+ * apfs_delete_node - Deletes a nonroot node from disk
+ * @node: node to delete
+ * @type: tree type for the query that found the node
+ *
+ * Does nothing to the in-memory node structure.  Returns 0 on success, or a
+ * negative error code in case of failure.
+ */
+int apfs_delete_node(struct apfs_node *node, int type)
+{
+	struct super_block *sb = node->object.sb;
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_superblock *vsb_raw;
+	u64 oid = node->object.oid;
+	u64 bno = node->object.block_nr;
+	struct apfs_ephemeral_object_info *eph_info = NULL, *eph_info_end = NULL;
+	int err;
+
+	switch (type) {
+	case APFS_QUERY_CAT:
+		err = apfs_free_queue_insert(sb, bno, 1);
+		if (err) {
+			apfs_err(sb, "free queue insertion failed for 0x%llx", bno);
+			return err;
+		}
+		err = apfs_delete_omap_rec(sb, oid);
+		if (err) {
+			apfs_err(sb, "omap rec deletion failed (0x%llx)", oid);
+			return err;
+		}
+		vsb_raw = APFS_SB(sb)->s_vsb_raw;
+		apfs_assert_in_transaction(sb, &vsb_raw->apfs_o);
+		le64_add_cpu(&vsb_raw->apfs_fs_alloc_count, -1);
+		le64_add_cpu(&vsb_raw->apfs_total_blocks_freed, 1);
+		return 0;
+	case APFS_QUERY_OMAP:
+	case APFS_QUERY_EXTENTREF:
+	case APFS_QUERY_SNAP_META:
+		err = apfs_free_queue_insert(sb, bno, 1);
+		if (err) {
+			apfs_err(sb, "free queue insertion failed for 0x%llx", bno);
+			return err;
+		}
+		/* We don't write to the container's omap */
+		vsb_raw = APFS_SB(sb)->s_vsb_raw;
+		apfs_assert_in_transaction(sb, &vsb_raw->apfs_o);
+		le64_add_cpu(&vsb_raw->apfs_fs_alloc_count, -1);
+		le64_add_cpu(&vsb_raw->apfs_total_blocks_freed, 1);
+		return 0;
+	case APFS_QUERY_FREE_QUEUE:
+		eph_info_end = &nxi->nx_eph_list[nxi->nx_eph_count];
+		eph_info = apfs_ephemeral_object_lookup(sb, node->object.oid);
+		if (IS_ERR(eph_info)) {
+			apfs_alert(sb, "can't find ephemeral object to delete");
+			return PTR_ERR(eph_info);
+		}
+		kfree(eph_info->object);
+		eph_info->object = NULL;
+		memmove(eph_info, eph_info + 1, (char *)eph_info_end - (char *)(eph_info + 1));
+		eph_info_end->object = NULL;
+		--nxi->nx_eph_count;
+		return 0;
+	default:
+		apfs_alert(sb, "new query type must implement node deletion (%d)", type);
+		return -EOPNOTSUPP;
+	}
+}
+
+/**
+ * apfs_update_node - Update an existing node header
+ * @node: the modified in-memory node
+ */
+void apfs_update_node(struct apfs_node *node)
+{
+	struct super_block *sb = node->object.sb;
+	struct buffer_head *bh = node->object.o_bh;
+	struct apfs_btree_node_phys *raw = (void *)node->object.data;
+	struct apfs_nloc *free_head;
+	u32 tflags, type;
+	int toc_off;
+
+	apfs_assert_in_transaction(sb, &raw->btn_o);
+
+	raw->btn_o.o_oid = cpu_to_le64(node->object.oid);
+
+	/* The node may no longer be a root, so update the object type */
+	tflags = le32_to_cpu(raw->btn_o.o_type) & APFS_OBJECT_TYPE_FLAGS_MASK;
+	type = (node->flags & APFS_BTNODE_ROOT) ? APFS_OBJECT_TYPE_BTREE :
+						  APFS_OBJECT_TYPE_BTREE_NODE;
+	raw->btn_o.o_type = cpu_to_le32(type | tflags);
+	raw->btn_o.o_subtype = cpu_to_le32(node->tree_type);
+
+	raw->btn_flags = cpu_to_le16(node->flags);
+	raw->btn_nkeys = cpu_to_le32(node->records);
+
+	toc_off = sizeof(*raw) + le16_to_cpu(raw->btn_table_space.off);
+	raw->btn_table_space.len = cpu_to_le16(node->key - toc_off);
+	raw->btn_free_space.off = cpu_to_le16(node->free - node->key);
+	raw->btn_free_space.len = cpu_to_le16(node->val - node->free);
+
+	/* Reset the lists on zero length, a defragmentation is taking place */
+	free_head = &raw->btn_key_free_list;
+	free_head->len = cpu_to_le16(node->key_free_list_len);
+	if (!free_head->len)
+		free_head->off = cpu_to_le16(APFS_BTOFF_INVALID);
+	free_head = &raw->btn_val_free_list;
+	free_head->len = cpu_to_le16(node->val_free_list_len);
+	if (!free_head->len)
+		free_head->off = cpu_to_le16(APFS_BTOFF_INVALID);
+
+	if (bh) {
+		ASSERT(buffer_trans(bh));
+		ASSERT(buffer_csum(bh));
+	}
+}
+
+/**
+ * apfs_node_locate_key - Locate the key of a node record
+ * @node:	node to be searched
+ * @index:	number of the entry to locate
+ * @off:	on return will hold the offset in the block
+ *
+ * Returns the length of the key, or 0 in case of failure. The function checks
+ * that this length fits within the block; callers must use it to make sure
+ * they never operate outside its bounds.
+ */
+int apfs_node_locate_key(struct apfs_node *node, int index, int *off)
+{
+	struct super_block *sb = node->object.sb;
+	struct apfs_btree_node_phys *raw;
+	int len;
+
+	if (index >= node->records) {
+		apfs_err(sb, "index out of bounds (%d of %d)", index, node->records);
+		return 0;
+	}
+
+	raw = (struct apfs_btree_node_phys *)node->object.data;
+	if (apfs_node_has_fixed_kv_size(node)) {
+		struct apfs_kvoff *entry;
+
+		entry = (struct apfs_kvoff *)raw->btn_data + index;
+
+		/* TODO: it would be cleaner to read this stuff from disk */
+		if (node->tree_type == APFS_OBJECT_TYPE_OMAP_SNAPSHOT)
+			len = 8;
+		else
+			len = 16;
+
+		/* Translate offset in key area to offset in block */
+		*off = node->key + le16_to_cpu(entry->k);
+	} else {
+		/* These node types have variable length keys and values */
+		struct apfs_kvloc *entry;
+
+		entry = (struct apfs_kvloc *)raw->btn_data + index;
+		len = le16_to_cpu(entry->k.len);
+		/* Translate offset in key area to offset in block */
+		*off = node->key + le16_to_cpu(entry->k.off);
+	}
+
+	if (*off + len > sb->s_blocksize) {
+		apfs_err(sb, "key out of bounds (%d-%d)", *off, len);
+		return 0;
+	}
+	return len;
+}
+
+/**
+ * apfs_node_locate_value - Locate the value of a node record
+ * @node:	node to be searched
+ * @index:	number of the entry to locate
+ * @off:	on return will hold the offset in the block
+ *
+ * Returns the length of the value, which may be 0 in case of corruption or if
+ * the record is a ghost. The function checks that this length fits within the
+ * block; callers must use it to make sure they never operate outside its
+ * bounds.
+ */
+static int apfs_node_locate_value(struct apfs_node *node, int index, int *off)
+{
+	struct super_block *sb = node->object.sb;
+	struct apfs_btree_node_phys *raw;
+	int len;
+
+	if (index >= node->records) {
+		apfs_err(sb, "index out of bounds (%d of %d)", index, node->records);
+		return 0;
+	}
+
+	raw = (struct apfs_btree_node_phys *)node->object.data;
+	if (apfs_node_has_fixed_kv_size(node)) {
+		/* These node types have fixed length keys and values */
+		struct apfs_kvoff *entry;
+
+		entry = (struct apfs_kvoff *)raw->btn_data + index;
+		if (node->tree_type == APFS_OBJECT_TYPE_SPACEMAN_FREE_QUEUE) {
+			/* A free-space queue record may have no value */
+			if (le16_to_cpu(entry->v) == APFS_BTOFF_INVALID) {
+				*off = 0;
+				return 0;
+			}
+			len = 8;
+		} else {
+			/* This is an omap or omap snapshots node */
+			len = apfs_node_is_leaf(node) ? 16 : 8;
+		}
+		/*
+		 * Value offsets are counted backwards from the end of the
+		 * block, or from the beginning of the footer when it exists
+		 */
+		if (apfs_node_is_root(node)) /* has footer */
+			*off = sb->s_blocksize - sizeof(struct apfs_btree_info)
+					- le16_to_cpu(entry->v);
+		else
+			*off = sb->s_blocksize - le16_to_cpu(entry->v);
+	} else {
+		/* These node types have variable length keys and values */
+		struct apfs_kvloc *entry;
+
+		entry = (struct apfs_kvloc *)raw->btn_data + index;
+		len = le16_to_cpu(entry->v.len);
+		/*
+		 * Value offsets are counted backwards from the end of the
+		 * block, or from the beginning of the footer when it exists
+		 */
+		if (apfs_node_is_root(node)) /* has footer */
+			*off = sb->s_blocksize - sizeof(struct apfs_btree_info)
+					- le16_to_cpu(entry->v.off);
+		else
+			*off = sb->s_blocksize - le16_to_cpu(entry->v.off);
+	}
+
+	if (*off < 0 || *off + len > sb->s_blocksize) {
+		apfs_err(sb, "value out of bounds (%d-%d)", *off, len);
+		return 0;
+	}
+	return len;
+}
+
+/**
+ * apfs_create_toc_entry - Create the table-of-contents entry for a record
+ * @query: query pointing to the record
+ *
+ * Creates a toc entry for the record at index @query->index and increases
+ * @node->records.  The caller must ensure enough space in the table.
+ */
+static void apfs_create_toc_entry(struct apfs_query *query)
+{
+	struct apfs_node *node = query->node;
+	struct super_block *sb = node->object.sb;
+	struct apfs_btree_node_phys *raw = (void *)node->object.data;
+	int value_end;
+	int recs = node->records;
+	int index = query->index;
+
+	value_end = sb->s_blocksize;
+	if (apfs_node_is_root(node))
+		value_end -= sizeof(struct apfs_btree_info);
+
+	if (apfs_node_has_fixed_kv_size(node)) {
+		struct apfs_kvoff *kvoff;
+
+		kvoff = (struct apfs_kvoff *)raw->btn_data + query->index;
+		memmove(kvoff + 1, kvoff, (recs - index) * sizeof(*kvoff));
+
+		if (!query->len) /* Ghost record */
+			kvoff->v = cpu_to_le16(APFS_BTOFF_INVALID);
+		else
+			kvoff->v = cpu_to_le16(value_end - query->off);
+		kvoff->k = cpu_to_le16(query->key_off - node->key);
+	} else {
+		struct apfs_kvloc *kvloc;
+
+		kvloc = (struct apfs_kvloc *)raw->btn_data + query->index;
+		memmove(kvloc + 1, kvloc, (recs - index) * sizeof(*kvloc));
+
+		kvloc->v.off = cpu_to_le16(value_end - query->off);
+		kvloc->v.len = cpu_to_le16(query->len);
+		kvloc->k.off = cpu_to_le16(query->key_off - node->key);
+		kvloc->k.len = cpu_to_le16(query->key_len);
+	}
+	node->records++;
+}
+
+/**
+ * apfs_key_from_query - Read the current key from a query structure
+ * @query:	the query, with @query->key_off and @query->key_len already set
+ * @key:	return parameter for the key
+ *
+ * Reads the key into @key and performs some basic sanity checks as a
+ * protection against crafted filesystems.  Returns 0 on success or a
+ * negative error code otherwise.
+ */
+static int apfs_key_from_query(struct apfs_query *query, struct apfs_key *key)
+{
+	struct super_block *sb = query->node->object.sb;
+	char *raw = query->node->object.data;
+	void *raw_key = (void *)(raw + query->key_off);
+	bool hashed;
+	int err = 0;
+
+	switch (query->flags & APFS_QUERY_TREE_MASK) {
+	case APFS_QUERY_CAT:
+		hashed = apfs_is_normalization_insensitive(sb);
+		err = apfs_read_cat_key(raw_key, query->key_len, key, hashed);
+		break;
+	case APFS_QUERY_OMAP:
+		err = apfs_read_omap_key(raw_key, query->key_len, key);
+		break;
+	case APFS_QUERY_FREE_QUEUE:
+		err = apfs_read_free_queue_key(raw_key, query->key_len, key);
+		break;
+	case APFS_QUERY_EXTENTREF:
+		err = apfs_read_extentref_key(raw_key, query->key_len, key);
+		break;
+	case APFS_QUERY_FEXT:
+		err = apfs_read_fext_key(raw_key, query->key_len, key);
+		break;
+	case APFS_QUERY_SNAP_META:
+		err = apfs_read_snap_meta_key(raw_key, query->key_len, key);
+		break;
+	case APFS_QUERY_OMAP_SNAP:
+		err = apfs_read_omap_snap_key(raw_key, query->key_len, key);
+		break;
+	default:
+		apfs_alert(sb, "new query type must implement key reads (%d)", query->flags & APFS_QUERY_TREE_MASK);
+		err = -EOPNOTSUPP;
+		break;
+	}
+	if (err)
+		apfs_err(sb, "bad node key in block 0x%llx", query->node->object.block_nr);
+
+	/* A multiple query must ignore some of these fields */
+	if (query->flags & APFS_QUERY_ANY_NAME)
+		key->name = NULL;
+	if (query->flags & APFS_QUERY_ANY_NUMBER)
+		key->number = 0;
+
+	return err;
+}
+
+/**
+ * apfs_node_prev - Find the previous record in the current node
+ * @sb:		filesystem superblock
+ * @query:	query in execution
+ *
+ * Returns 0 on success, -EAGAIN if the previous record is in another node,
+ * -ENODATA if no more records exist, or another negative error code in case
+ * of failure.
+ *
+ * The meaning of "next" and "previous" is reverted here, because regular
+ * multiple always start with the final record, and then they go backwards.
+ * TODO: consider renaming this for clarity.
+ */
+static int apfs_node_prev(struct super_block *sb, struct apfs_query *query)
+{
+	struct apfs_node *node = query->node;
+
+	if (query->index + 1 == node->records) {
+		/* The next record may be in another node */
+		return -EAGAIN;
+	}
+	++query->index;
+
+	query->key_len = apfs_node_locate_key(node, query->index, &query->key_off);
+	if (query->key_len == 0) {
+		apfs_err(sb, "bad key for index %d", query->index);
+		return -EFSCORRUPTED;
+	}
+	query->len = apfs_node_locate_value(node, query->index, &query->off);
+	if (query->len == 0) {
+		apfs_err(sb, "bad value for index %d", query->index);
+		return -EFSCORRUPTED;
+	}
+	return 0;
+}
+
+/**
+ * apfs_node_next - Find the next matching record in the current node
+ * @sb:		filesystem superblock
+ * @query:	multiple query in execution
+ *
+ * Returns 0 on success, -EAGAIN if the next record is in another node,
+ * -ENODATA if no more matching records exist, or another negative error
+ * code in case of failure.
+ */
+static int apfs_node_next(struct super_block *sb, struct apfs_query *query)
+{
+	struct apfs_node *node = query->node;
+	struct apfs_key curr_key;
+	int cmp, err;
+
+	if (query->flags & APFS_QUERY_DONE)
+		/* Nothing left to search; the query failed */
+		return -ENODATA;
+
+	if (!query->index) /* The next record may be in another node */
+		return -EAGAIN;
+	--query->index;
+
+	query->key_len = apfs_node_locate_key(node, query->index,
+					      &query->key_off);
+	err = apfs_key_from_query(query, &curr_key);
+	if (err) {
+		apfs_err(sb, "bad key for index %d", query->index);
+		return err;
+	}
+
+	cmp = apfs_keycmp(&curr_key, &query->key);
+
+	if (cmp > 0) {
+		apfs_err(sb, "records are out of order");
+		return -EFSCORRUPTED;
+	}
+
+	if (cmp != 0 && apfs_node_is_leaf(node) &&
+	    query->flags & APFS_QUERY_EXACT)
+		return -ENODATA;
+
+	query->len = apfs_node_locate_value(node, query->index, &query->off);
+	if (query->len == 0) {
+		apfs_err(sb, "bad value for index %d", query->index);
+		return -EFSCORRUPTED;
+	}
+
+	if (cmp != 0) {
+		/*
+		 * This is the last entry that can be relevant in this node.
+		 * Keep searching the children, but don't return to this level.
+		 */
+		query->flags |= APFS_QUERY_DONE;
+	}
+
+	return 0;
+}
+
+/**
+ * apfs_node_query - Execute a query on a single node
+ * @sb:		filesystem superblock
+ * @query:	the query to execute
+ *
+ * The search will start at index @query->index, looking for the key that comes
+ * right before @query->key, according to the order given by apfs_keycmp().
+ *
+ * The @query->index will be updated to the last index checked. This is
+ * important when searching for multiple entries, since the query may need
+ * to remember where it was on this level. If we are done with this node, the
+ * query will be flagged as APFS_QUERY_DONE, and the search will end in failure
+ * as soon as we return to this level. The function may also return -EAGAIN,
+ * to signal that the search should go on in a different branch.
+ *
+ * On success returns 0; the offset of the value within the block will be saved
+ * in @query->off, and its length in @query->len. The function checks that this
+ * length fits within the block; callers must use the returned value to make
+ * sure they never operate outside its bounds.
+ *
+ * -ENODATA will be returned if no appropriate entry was found, -EFSCORRUPTED
+ * in case of corruption.
+ */
+int apfs_node_query(struct super_block *sb, struct apfs_query *query)
+{
+	struct apfs_node *node = query->node;
+	int left, right;
+	int cmp;
+	int err;
+
+	if (query->flags & APFS_QUERY_PREV)
+		return apfs_node_prev(sb, query);
+	if (query->flags & APFS_QUERY_NEXT)
+		return apfs_node_next(sb, query);
+
+	/* Search by bisection */
+	cmp = 1;
+	left = 0;
+	do {
+		struct apfs_key curr_key;
+
+		if (cmp > 0) {
+			right = query->index - 1;
+			if (right < left) {
+				query->index = -1;
+				return -ENODATA;
+			}
+			query->index = (left + right) / 2;
+		} else {
+			left = query->index;
+			query->index = DIV_ROUND_UP(left + right, 2);
+		}
+
+		query->key_len = apfs_node_locate_key(node, query->index,
+						      &query->key_off);
+		err = apfs_key_from_query(query, &curr_key);
+		if (err) {
+			apfs_err(sb, "bad key for index %d", query->index);
+			return err;
+		}
+
+		cmp = apfs_keycmp(&curr_key, &query->key);
+		if (cmp == 0 && !(query->flags & APFS_QUERY_MULTIPLE))
+			break;
+	} while (left != right);
+
+	if (cmp > 0) {
+		query->index = -1;
+		return -ENODATA;
+	}
+
+	if (cmp != 0 && apfs_node_is_leaf(query->node) &&
+	    query->flags & APFS_QUERY_EXACT)
+		return -ENODATA;
+
+	if (query->flags & APFS_QUERY_MULTIPLE) {
+		if (cmp != 0) /* Last relevant entry in level */
+			query->flags |= APFS_QUERY_DONE;
+		query->flags |= APFS_QUERY_NEXT;
+	}
+
+	query->len = apfs_node_locate_value(node, query->index, &query->off);
+	return 0;
+}
+
+/**
+ * apfs_node_query_first - Find the first record in a node
+ * @query: on return this query points to the record
+ */
+void apfs_node_query_first(struct apfs_query *query)
+{
+	struct apfs_node *node = query->node;
+
+	query->index = 0;
+	query->key_len = apfs_node_locate_key(node, query->index, &query->key_off);
+	query->len = apfs_node_locate_value(node, query->index, &query->off);
+}
+
+/**
+ * apfs_omap_map_from_query - Read the mapping found by a successful omap query
+ * @query:	the query that found the record
+ * @map:	Return parameter.  The mapping found.
+ *
+ * Returns -EOPNOTSUPP if the object doesn't fit in one block, and -EFSCORRUPTED
+ * if the filesystem appears to be malicious.  Otherwise, reads the mapping info
+ * in the omap record into @map and returns 0.
+ */
+int apfs_omap_map_from_query(struct apfs_query *query, struct apfs_omap_map *map)
+{
+	struct super_block *sb = query->node->object.sb;
+	struct apfs_omap_key *key = NULL;
+	struct apfs_omap_val *val = NULL;
+	char *raw = query->node->object.data;
+
+	if (query->len != sizeof(*val) || query->key_len != sizeof(*key)) {
+		apfs_err(sb, "bad length of key (%d) or value (%d)", query->key_len, query->len);
+		return -EFSCORRUPTED;
+	}
+	key = (struct apfs_omap_key *)(raw + query->key_off);
+	val = (struct apfs_omap_val *)(raw + query->off);
+
+	/* TODO: support objects with multiple blocks */
+	if (le32_to_cpu(val->ov_size) != sb->s_blocksize) {
+		apfs_err(sb, "object size doesn't match block size");
+		return -EOPNOTSUPP;
+	}
+
+	map->xid = le64_to_cpu(key->ok_xid);
+	map->bno = le64_to_cpu(val->ov_paddr);
+	map->flags = le32_to_cpu(val->ov_flags);
+	return 0;
+}
+
+/**
+ * apfs_btree_inc_height - Increase the height of a b-tree
+ * @query: query pointing to the root node
+ *
+ * On success returns 0, and @query is left pointing to the same record.
+ * Returns a negative error code in case of failure.
+ */
+static int apfs_btree_inc_height(struct apfs_query *query)
+{
+	struct apfs_query *root_query;
+	struct apfs_node *root = query->node;
+	struct apfs_node *new_node;
+	struct super_block *sb = root->object.sb;
+	struct apfs_btree_node_phys *root_raw;
+	struct apfs_btree_node_phys *new_raw;
+	struct apfs_btree_info *info;
+	__le64 *raw_oid;
+	u32 storage = apfs_query_storage(query);
+
+	root_raw = (void *)root->object.data;
+	apfs_assert_in_transaction(sb, &root_raw->btn_o);
+
+	if (query->parent || query->depth) {
+		apfs_err(sb, "invalid root query");
+		return -EFSCORRUPTED;
+	}
+
+	/* Create a new child node */
+	new_node = apfs_create_node(sb, storage);
+	if (IS_ERR(new_node)) {
+		apfs_err(sb, "node creation failed");
+		return PTR_ERR(new_node);
+	}
+	new_node->flags = root->flags & ~APFS_BTNODE_ROOT;
+	new_node->tree_type = root->tree_type;
+
+	/* Move all records into the child node; get rid of the info footer */
+	new_node->records = root->records;
+	new_node->key = root->key;
+	new_node->free = root->free;
+	new_node->val = root->val + sizeof(*info);
+	new_node->key_free_list_len = root->key_free_list_len;
+	new_node->val_free_list_len = root->val_free_list_len;
+	new_raw = (void *)new_node->object.data;
+	/* Don't copy the object header, already set by apfs_create_node() */
+	memcpy((void *)new_raw + sizeof(new_raw->btn_o),
+	       (void *)root_raw + sizeof(root_raw->btn_o),
+	       root->free - sizeof(new_raw->btn_o));
+	memcpy((void *)new_raw + new_node->val,
+	       (void *)root_raw + root->val,
+	       sb->s_blocksize - new_node->val);
+	query->off += sizeof(*info);
+	apfs_update_node(new_node);
+
+	/* Add a new level to the query chain */
+	root_query = query->parent = apfs_alloc_query(root, NULL /* parent */);
+	if (!query->parent) {
+		apfs_node_free(new_node);
+		return -ENOMEM;
+	}
+	root_query->key = query->key;
+	root_query->flags = query->flags;
+	query->node = new_node;
+	query->depth = 1;
+
+	/* Now assemble the new root with only the first key */
+	root_query->key_len = apfs_node_locate_key(root, 0 /* index */,
+						   &root_query->key_off);
+	if (!root_query->key_len) {
+		apfs_err(sb, "bad key for index %d", 0);
+		return -EFSCORRUPTED;
+	}
+	root->key = sizeof(*root_raw) +
+		    apfs_node_min_table_size(sb, root->tree_type, root->flags & ~APFS_BTNODE_LEAF);
+	memmove((void *)root_raw + root->key,
+		(void *)root_raw + root_query->key_off, root_query->key_len);
+	root_query->key_off = root->key;
+	root->free = root->key + root_query->key_len;
+
+	/* The new root is a nonleaf node; the record value is the child id */
+	root->flags &= ~APFS_BTNODE_LEAF;
+	root->val = sb->s_blocksize - sizeof(*info) - sizeof(*raw_oid);
+	raw_oid = (void *)root_raw + root->val;
+	*raw_oid = cpu_to_le64(new_node->object.oid);
+	root_query->off = root->val;
+	root_query->len = sizeof(*raw_oid);
+
+	/* With the key and value in place, set the table-of-contents */
+	root->records = 0;
+	root_query->index = 0;
+	apfs_create_toc_entry(root_query);
+
+	/* There is no internal fragmentation */
+	root->key_free_list_len = 0;
+	root->val_free_list_len = 0;
+
+	/* Finally, update the node count in the info footer */
+	apfs_btree_change_node_count(root_query, 1 /* change */);
+
+	le16_add_cpu(&root_raw->btn_level, 1); /* TODO: move to update_node() */
+	apfs_update_node(root);
+	return 0;
+}
+
+/**
+ * apfs_copy_record_range - Copy a range of records to an empty node
+ * @dest_node:	destination node
+ * @src_node:	source node
+ * @start:	index of first record in range
+ * @end:	index of first record after the range
+ *
+ * Doesn't modify the info footer of root nodes. Returns 0 on success or a
+ * negative error code in case of failure.
+ */
+static int apfs_copy_record_range(struct apfs_node *dest_node,
+				  struct apfs_node *src_node,
+				  int start, int end)
+{
+	struct super_block *sb = dest_node->object.sb;
+	struct apfs_btree_node_phys *dest_raw;
+	struct apfs_btree_node_phys *src_raw;
+	struct apfs_query *query = NULL;
+	int toc_size, toc_entry_size;
+	int err;
+	int i;
+
+	dest_raw = (void *)dest_node->object.data;
+	src_raw = (void *)src_node->object.data;
+
+	ASSERT(!dest_node->records);
+	apfs_assert_in_transaction(sb, &dest_raw->btn_o);
+
+	/* Resize the table of contents so that all the records fit */
+	if (apfs_node_has_fixed_kv_size(src_node))
+		toc_entry_size = sizeof(struct apfs_kvoff);
+	else
+		toc_entry_size = sizeof(struct apfs_kvloc);
+	toc_size = apfs_node_min_table_size(sb, src_node->tree_type, src_node->flags);
+	if (toc_size < toc_entry_size * (end - start))
+		toc_size = toc_entry_size * round_up(end - start, APFS_BTREE_TOC_ENTRY_INCREMENT);
+	dest_node->key = sizeof(*dest_raw) + toc_size;
+	dest_node->free = dest_node->key;
+	dest_node->val = sb->s_blocksize;
+	if (apfs_node_is_root(dest_node))
+		dest_node->val -= sizeof(struct apfs_btree_info);
+
+	/* We'll use a temporary query structure to move the records around */
+	query = apfs_alloc_query(dest_node, NULL /* parent */);
+	if (!query) {
+		err = -ENOMEM;
+		goto fail;
+	}
+
+	err = -EFSCORRUPTED;
+	for (i = start; i < end; ++i) {
+		int len, off;
+
+		len = apfs_node_locate_key(src_node, i, &off);
+		if (dest_node->free + len > sb->s_blocksize) {
+			apfs_err(sb, "key of length %d doesn't fit", len);
+			goto fail;
+		}
+		memcpy((char *)dest_raw + dest_node->free,
+		       (char *)src_raw + off, len);
+		query->key_off = dest_node->free;
+		query->key_len = len;
+		dest_node->free += len;
+
+		len = apfs_node_locate_value(src_node, i, &off);
+		dest_node->val -= len;
+		if (dest_node->val < 0) {
+			apfs_err(sb, "value of length %d doesn't fit", len);
+			goto fail;
+		}
+		memcpy((char *)dest_raw + dest_node->val,
+		       (char *)src_raw + off, len);
+		query->off = dest_node->val;
+		query->len = len;
+
+		query->index = i - start;
+		apfs_create_toc_entry(query);
+	}
+	err = 0;
+
+fail:
+	apfs_free_query(query);
+	return err;
+}
+
+/**
+ * apfs_attach_child - Attach a new node to its parent
+ * @query:	query pointing to the previous record in the parent
+ * @child:	the new child node to attach
+ *
+ * Returns 0 on success or a negative error code in case of failure (which may
+ * be -EAGAIN if a node split has happened and the caller must refresh and
+ * retry).
+ */
+static int apfs_attach_child(struct apfs_query *query, struct apfs_node *child)
+{
+	struct apfs_object *object = &child->object;
+	struct apfs_btree_node_phys *raw = (void *)object->data;
+	int key_len, key_off;
+	__le64 raw_oid = cpu_to_le64(object->oid);
+
+	key_len = apfs_node_locate_key(child, 0, &key_off);
+	if (!key_len) {
+		/* This should never happen: @child was made by us */
+		apfs_alert(object->sb, "bad key for index %d", 0);
+		return -EFSCORRUPTED;
+	}
+
+	return __apfs_btree_insert(query, (void *)raw + key_off, key_len, &raw_oid, sizeof(raw_oid));
+}
+
+/**
+ * apfs_node_temp_dup - Make an in-memory duplicate of a node
+ * @original:	node to duplicate
+ * @duplicate:	on success, the duplicate node
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_node_temp_dup(const struct apfs_node *original, struct apfs_node **duplicate)
+{
+	struct super_block *sb = original->object.sb;
+	struct apfs_node *dup = NULL;
+	char *buffer = NULL;
+
+	dup = kmalloc(sizeof(*dup), GFP_KERNEL);
+	if (!dup)
+		return -ENOMEM;
+	*dup = *original;
+	dup->object.o_bh = NULL;
+	dup->object.data = NULL;
+	dup->object.ephemeral = false;
+
+	buffer = kmalloc(sb->s_blocksize, GFP_KERNEL);
+	if (!buffer) {
+		kfree(dup);
+		return -ENOMEM;
+	}
+	memcpy(buffer, original->object.data, sb->s_blocksize);
+	dup->object.data = buffer;
+
+	*duplicate = dup;
+	return 0;
+}
+
+/**
+ * apfs_node_split - Split a b-tree node in two
+ * @query: query pointing to the node
+ *
+ * On success returns 0, and @query is left pointing to the same record on the
+ * tip; to simplify the implementation, @query->parent is set to NULL. Returns
+ * a negative error code in case of failure, which may be -EAGAIN if a node
+ * split has happened and the caller must refresh and retry.
+ */
+int apfs_node_split(struct apfs_query *query)
+{
+	struct super_block *sb = query->node->object.sb;
+	struct apfs_node *old_node = NULL, *new_node = NULL, *tmp_node = NULL;
+	struct apfs_btree_node_phys *new_raw = NULL, *old_raw = NULL;
+	u32 storage = apfs_query_storage(query);
+	int record_count, new_rec_count, old_rec_count;
+	int err;
+
+	apfs_assert_query_is_valid(query);
+
+	if (apfs_node_is_root(query->node)) {
+		err = apfs_btree_inc_height(query);
+		if (err) {
+			apfs_err(sb, "failed to increase tree height");
+			return err;
+		}
+	} else if (!query->parent) {
+		apfs_err(sb, "nonroot node with no parent");
+		return -EFSCORRUPTED;
+	}
+	old_node = query->node;
+
+	old_raw = (void *)old_node->object.data;
+	apfs_assert_in_transaction(sb, &old_raw->btn_o);
+
+	/*
+	 * To defragment the original node, we put all records in a temporary
+	 * in-memory node before dealing them out.
+	 */
+	err = apfs_node_temp_dup(old_node, &tmp_node);
+	if (err)
+		return err;
+
+	record_count = old_node->records;
+	if (record_count == 1) {
+		apfs_alert(sb, "splitting node with a single record");
+		err = -EFSCORRUPTED;
+		goto out;
+	}
+	new_rec_count = record_count / 2;
+	old_rec_count = record_count - new_rec_count;
+
+	/*
+	 * The second half of the records go into a new node. This is done
+	 * before the first half to avoid committing to any actual changes
+	 * until we know for sure that no ancestor splits are expected.
+	 */
+
+	new_node = apfs_create_node(sb, storage);
+	if (IS_ERR(new_node)) {
+		apfs_err(sb, "node creation failed");
+		err = PTR_ERR(new_node);
+		new_node = NULL;
+		goto out;
+	}
+	new_node->tree_type = old_node->tree_type;
+	new_node->flags = old_node->flags;
+	new_node->records = 0;
+	new_node->key_free_list_len = 0;
+	new_node->val_free_list_len = 0;
+	err = apfs_copy_record_range(new_node, tmp_node, old_rec_count, record_count);
+	if (err) {
+		apfs_err(sb, "record copy failed");
+		goto out;
+	}
+	new_raw = (void *)new_node->object.data;
+	apfs_assert_in_transaction(sb, &new_raw->btn_o);
+	new_raw->btn_level = old_raw->btn_level;
+	apfs_update_node(new_node);
+
+	err = apfs_attach_child(query->parent, new_node);
+	if (err) {
+		if (err != -EAGAIN) {
+			apfs_err(sb, "child attachment failed");
+			goto out;
+		}
+		err = apfs_delete_node(new_node, query->flags & APFS_QUERY_TREE_MASK);
+		if (err) {
+			apfs_err(sb, "node cleanup failed for query retry");
+			goto out;
+		}
+		err = -EAGAIN;
+		goto out;
+	}
+	apfs_assert_query_is_valid(query->parent);
+	apfs_btree_change_node_count(query->parent, 1 /* change */);
+
+	/*
+	 * No more risk of ancestor splits, now actual changes can be made. The
+	 * first half of the records go into the original node.
+	 */
+
+	old_node->records = 0;
+	old_node->key_free_list_len = 0;
+	old_node->val_free_list_len = 0;
+	err = apfs_copy_record_range(old_node, tmp_node, 0, old_rec_count);
+	if (err) {
+		apfs_err(sb, "record copy failed");
+		goto out;
+	}
+	apfs_update_node(old_node);
+
+	/* Point the query back to the original record */
+	if (query->index >= old_rec_count) {
+		/* The record got moved to the new node */
+		apfs_node_free(query->node);
+		query->node = new_node;
+		new_node = NULL;
+		query->index -= old_rec_count;
+	}
+
+	/*
+	 * This could be avoided in most cases, and queries could get refreshed
+	 * only when really orphaned. But refreshing queries is probably not a
+	 * bottleneck, and trying to be clever with this stuff has caused me a
+	 * lot of trouble already.
+	 */
+	apfs_free_query(query->parent);
+	query->parent = NULL; /* The caller only gets the leaf */
+
+out:
+	apfs_node_free(new_node);
+	apfs_node_free(tmp_node);
+	return err;
+}
+
+/* TODO: the following 4 functions could be reused elsewhere */
+
+/**
+ * apfs_off_to_val_off - Translate offset in node to offset in value area
+ * @node:	the node
+ * @off:	offset in the node
+ */
+static u16 apfs_off_to_val_off(struct apfs_node *node, u16 off)
+{
+	struct super_block *sb = node->object.sb;
+	u16 val_end;
+
+	val_end = sb->s_blocksize;
+	if (apfs_node_is_root(node)) /* has footer */
+		val_end -= sizeof(struct apfs_btree_info);
+	return val_end - off;
+}
+
+/**
+ * apfs_val_off_to_off - Translate offset in value area to offset in node
+ * @node:	the node
+ * @off:	offset in the value area
+ */
+static u16 apfs_val_off_to_off(struct apfs_node *node, u16 off)
+{
+	return apfs_off_to_val_off(node, off);
+}
+
+/**
+ * apfs_off_to_key_off - Translate offset in node to offset in key area
+ * @node:	the node
+ * @off:	offset in the node
+ */
+static u16 apfs_off_to_key_off(struct apfs_node *node, u16 off)
+{
+	return off - node->key;
+}
+
+/**
+ * apfs_key_off_to_off - Translate offset in key area to offset in node
+ * @node:	the node
+ * @off:	offset in the key area
+ */
+static u16 apfs_key_off_to_off(struct apfs_node *node, u16 off)
+{
+	return off + node->key;
+}
+
+/* The type of the previous four functions, used for node offset calculations */
+typedef u16 (*offcalc)(struct apfs_node *, u16);
+
+/**
+ * apfs_node_free_list_add - Add a free node segment to the proper free list
+ * @node:	node for the segment
+ * @off:	offset of the segment to add
+ * @len:	length of the segment to add
+ *
+ * The caller must ensure that the freed segment fits in the node.
+ */
+static void apfs_node_free_list_add(struct apfs_node *node, u16 off, u16 len)
+{
+	struct super_block *sb = node->object.sb;
+	struct apfs_btree_node_phys *node_raw = (void *)node->object.data;
+	struct apfs_nloc *head, *new;
+	offcalc off_to_rel;
+
+	apfs_assert_in_transaction(sb, &node_raw->btn_o);
+
+	if (off >= node->val) { /* Value area */
+		off_to_rel = apfs_off_to_val_off;
+		head = &node_raw->btn_val_free_list;
+		node->val_free_list_len += len;
+	} else { /* Key area */
+		off_to_rel = apfs_off_to_key_off;
+		head = &node_raw->btn_key_free_list;
+		node->key_free_list_len += len;
+	}
+
+	/* Very small segments are leaked until defragmentation */
+	if (len < sizeof(*new))
+		return;
+
+	/* The free list doesn't seem to be kept in any particular order */
+	new = (void *)node_raw + off;
+	new->off = head->off;
+	new->len = cpu_to_le16(len);
+	head->off = cpu_to_le16(off_to_rel(node, off));
+}
+
+/**
+ * apfs_node_free_range - Free space from a node's key or value areas
+ * @node:	the node
+ * @off:	offset to free
+ * @len:	length to free
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+void apfs_node_free_range(struct apfs_node *node, u16 off, u16 len)
+{
+	struct super_block *sb = node->object.sb;
+	struct apfs_btree_node_phys *raw = (void *)node->object.data;
+
+	apfs_assert_in_transaction(sb, &raw->btn_o);
+
+	if (off == node->val)
+		node->val += len;
+	else if (off + len == node->free)
+		node->free -= len;
+	else
+		apfs_node_free_list_add(node, off, len);
+}
+
+/**
+ * apfs_node_free_list_unlink - Unlink an entry from a node's free list
+ * @prev:	previous entry
+ * @curr:	entry to unlink
+ */
+static void apfs_node_free_list_unlink(struct apfs_nloc *prev, struct apfs_nloc *curr)
+{
+	prev->off = curr->off;
+}
+
+/**
+ * apfs_node_free_list_alloc - Allocate a free segment from a free list
+ * @node:	the node
+ * @len:	length to allocate
+ * @value:	true to allocate in the value area, false for the key area
+ *
+ * Returns the offset in the node on success, or a negative error code in case
+ * of failure, which may be -ENOSPC if the node seems full.
+ */
+static int apfs_node_free_list_alloc(struct apfs_node *node, u16 len, bool value)
+{
+	struct super_block *sb = node->object.sb;
+	struct apfs_btree_node_phys *node_raw = (void *)node->object.data;
+	struct apfs_nloc *head, *curr, *prev;
+	offcalc rel_to_off;
+	int *list_len;
+	int bound = sb->s_blocksize;
+
+	apfs_assert_in_transaction(sb, &node_raw->btn_o);
+
+	if (value) { /* Value area */
+		rel_to_off = apfs_val_off_to_off;
+		head = &node_raw->btn_val_free_list;
+		list_len = &node->val_free_list_len;
+	} else { /* Key area */
+		rel_to_off = apfs_key_off_to_off;
+		head = &node_raw->btn_key_free_list;
+		list_len = &node->key_free_list_len;
+	}
+
+	if (*list_len < len)
+		return -ENOSPC;
+
+	prev = head;
+	while (bound--) {
+		u16 curr_off = le16_to_cpu(prev->off);
+		u16 abs_off = rel_to_off(node, curr_off);
+		u16 curr_len;
+
+		if (curr_off == APFS_BTOFF_INVALID)
+			return -ENOSPC;
+		if (abs_off + sizeof(*curr) > sb->s_blocksize) {
+			apfs_err(sb, "nloc out of bounds (%d-%d)", abs_off, (int)sizeof(*curr));
+			return -EFSCORRUPTED;
+		}
+		curr = (void *)node_raw + abs_off;
+
+		curr_len = le16_to_cpu(curr->len);
+		if (curr_len >= len) {
+			if (abs_off + curr_len > sb->s_blocksize) {
+				apfs_err(sb, "entry out of bounds (%d-%d)", abs_off, curr_len);
+				return -EFSCORRUPTED;
+			}
+			*list_len -= curr_len;
+			apfs_node_free_list_unlink(prev, curr);
+			apfs_node_free_list_add(node, abs_off + len, curr_len - len);
+			return abs_off;
+		}
+
+		prev = curr;
+	}
+
+	/* Don't loop forever if the free list is corrupted and doesn't end */
+	apfs_err(sb, "free list never ends");
+	return -EFSCORRUPTED;
+}
+
+/**
+ * apfs_node_alloc_key - Allocated free space for a new key
+ * @node:	the node to search
+ * @len:	wanted key length
+ *
+ * Returns the offset in the node on success, or a negative error code in case
+ * of failure, which may be -ENOSPC if the node seems full.
+ */
+static int apfs_node_alloc_key(struct apfs_node *node, u16 len)
+{
+	int off;
+
+	if (node->free + len <= node->val) {
+		off = node->free;
+		node->free += len;
+		return off;
+	}
+	return apfs_node_free_list_alloc(node, len, false /* value */);
+}
+
+/**
+ * apfs_node_alloc_val - Allocated free space for a new value
+ * @node:	the node to search
+ * @len:	wanted value length
+ *
+ * Returns the offset in the node on success, or a negative error code in case
+ * of failure, which may be -ENOSPC if the node seems full.
+ */
+static int apfs_node_alloc_val(struct apfs_node *node, u16 len)
+{
+	int off;
+
+	if (node->free + len <= node->val) {
+		off = node->val - len;
+		node->val -= len;
+		return off;
+	}
+	return apfs_node_free_list_alloc(node, len, true /* value */);
+}
+
+/**
+ * apfs_node_total_room - Total free space in a node
+ * @node: the node
+ */
+static int apfs_node_total_room(struct apfs_node *node)
+{
+	return node->val - node->free + node->key_free_list_len + node->val_free_list_len;
+}
+
+/**
+ * apfs_node_has_room - Check if a node has room for insertion or replacement
+ * @node:	node to check
+ * @length:	length of the needed space (may be negative on replace)
+ * @replace:	are we replacing a record?
+ */
+bool apfs_node_has_room(struct apfs_node *node, int length, bool replace)
+{
+	struct apfs_btree_node_phys *node_raw = (void *)node->object.data;
+	int toc_entry_size, needed_room;
+
+	if (apfs_node_has_fixed_kv_size(node))
+		toc_entry_size = sizeof(struct apfs_kvoff);
+	else
+		toc_entry_size = sizeof(struct apfs_kvloc);
+
+	needed_room = length;
+	if (!replace) {
+		if (sizeof(*node_raw) + (node->records + 1) * toc_entry_size > node->key)
+			needed_room += APFS_BTREE_TOC_ENTRY_INCREMENT * toc_entry_size;
+	}
+
+	return apfs_node_total_room(node) >= needed_room;
+}
+
+/**
+ * apfs_defragment_node - Make all free space in a node contiguous
+ * @node: node to defragment
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_defragment_node(struct apfs_node *node)
+{
+	struct super_block *sb = node->object.sb;
+	struct apfs_btree_node_phys *node_raw = (void *)node->object.data;
+	struct apfs_node *tmp_node = NULL;
+	int record_count, err;
+
+	apfs_assert_in_transaction(sb, &node_raw->btn_o);
+
+	/* Put all records in a temporary in-memory node and deal them out */
+	err = apfs_node_temp_dup(node, &tmp_node);
+	if (err)
+		return err;
+	record_count = node->records;
+	node->records = 0;
+	node->key_free_list_len = 0;
+	node->val_free_list_len = 0;
+	err = apfs_copy_record_range(node, tmp_node, 0, record_count);
+	if (err) {
+		apfs_err(sb, "record copy failed");
+		goto fail;
+	}
+	apfs_update_node(node);
+fail:
+	apfs_node_free(tmp_node);
+	return err;
+}
+
+/**
+ * apfs_node_update_toc_entry - Update a table of contents entry in place
+ * @query: query pointing to the toc entry
+ *
+ * The toc entry gets updated with the length and offset for the key/value
+ * provided by @query. Don't call this function for nodes with fixed length
+ * key/values, those never need to update their toc entries.
+ */
+static void apfs_node_update_toc_entry(struct apfs_query *query)
+{
+	struct super_block *sb = NULL;
+	struct apfs_node *node = NULL;
+	struct apfs_btree_node_phys *node_raw = NULL;
+	struct apfs_kvloc *kvloc = NULL;
+	int value_end;
+
+	node = query->node;
+	ASSERT(!apfs_node_has_fixed_kv_size(node));
+	sb = node->object.sb;
+	node_raw = (void *)node->object.data;
+
+	value_end = sb->s_blocksize;
+	if (apfs_node_is_root(node))
+		value_end -= sizeof(struct apfs_btree_info);
+
+	kvloc = (struct apfs_kvloc *)node_raw->btn_data + query->index;
+	kvloc->v.off = cpu_to_le16(value_end - query->off);
+	kvloc->v.len = cpu_to_le16(query->len);
+	kvloc->k.off = cpu_to_le16(query->key_off - node->key);
+	kvloc->k.len = cpu_to_le16(query->key_len);
+}
+
+/**
+ * apfs_node_replace - Replace a record in a node that has enough room
+ * @query:	exact query that found the record
+ * @key:	new on-disk record key (NULL if unchanged)
+ * @key_len:	length of @key
+ * @val:	new on-disk record value (NULL if unchanged)
+ * @val_len:	length of @val
+ *
+ * Returns 0 on success, and @query is left pointing to the same record. Returns
+ * a negative error code in case of failure.
+ */
+int apfs_node_replace(struct apfs_query *query, void *key, int key_len, void *val, int val_len)
+{
+	struct apfs_node *node = query->node;
+	struct super_block *sb = node->object.sb;
+	struct apfs_btree_node_phys *node_raw = (void *)node->object.data;
+	int key_off = 0, val_off = 0, err = 0;
+	bool defragged = false;
+	int qtree = query->flags & APFS_QUERY_TREE_MASK;
+
+	apfs_assert_in_transaction(sb, &node_raw->btn_o);
+
+	/*
+	 * Free queues are weird because their tables of contents don't report
+	 * record lengths, as if they were fixed, but some of the leaf values
+	 * are actually "ghosts", that is, zero-length. Supporting replace of
+	 * such records would require some changes, and so far I've had no need
+	 * for it.
+	 */
+	(void)qtree;
+	ASSERT(!(qtree == APFS_QUERY_FREE_QUEUE && apfs_node_is_leaf(node)));
+
+retry:
+	if (key) {
+		if (key_len <= query->key_len) {
+			u16 end = query->key_off + key_len;
+			u16 diff = query->key_len - key_len;
+
+			apfs_node_free_range(node, end, diff);
+			key_off = query->key_off;
+		} else {
+			apfs_node_free_range(node, query->key_off, query->key_len);
+			key_off = apfs_node_alloc_key(node, key_len);
+			if (key_off < 0) {
+				if (key_off == -ENOSPC)
+					goto defrag;
+				return key_off;
+			}
+		}
+	}
+
+	if (val) {
+		if (val_len <= query->len) {
+			u16 end = query->off + val_len;
+			u16 diff = query->len - val_len;
+
+			apfs_node_free_range(node, end, diff);
+			val_off = query->off;
+		} else {
+			apfs_node_free_range(node, query->off, query->len);
+			val_off = apfs_node_alloc_val(node, val_len);
+			if (val_off < 0) {
+				if (val_off == -ENOSPC)
+					goto defrag;
+				return val_off;
+			}
+		}
+	}
+
+	if (key) {
+		query->key_off = key_off;
+		query->key_len = key_len;
+		memcpy((void *)node_raw + key_off, key, key_len);
+	}
+	if (val) {
+		query->off = val_off;
+		query->len = val_len;
+		memcpy((void *)node_raw + val_off, val, val_len);
+	}
+
+	/* If the key or value were resized, update the table of contents */
+	if (!apfs_node_has_fixed_kv_size(node))
+		apfs_node_update_toc_entry(query);
+
+	apfs_update_node(node);
+	return 0;
+
+defrag:
+	if (defragged) {
+		apfs_alert(sb, "no room in defragged node");
+		return -EFSCORRUPTED;
+	}
+
+	/* Crush the replaced entry, so that defragmentation is complete */
+	if (apfs_node_has_fixed_kv_size(node)) {
+		apfs_alert(sb, "failed to replace a fixed size record");
+		return -EFSCORRUPTED;
+	}
+	if (key)
+		query->key_len = 0;
+	if (val)
+		query->len = 0;
+	apfs_node_update_toc_entry(query);
+
+	err = apfs_defragment_node(node);
+	if (err) {
+		apfs_err(sb, "failed to defragment node");
+		return err;
+	}
+	defragged = true;
+
+	/* The record to replace probably moved around */
+	query->len = apfs_node_locate_value(query->node, query->index, &query->off);
+	query->key_len = apfs_node_locate_key(query->node, query->index, &query->key_off);
+	goto retry;
+}
+
+/**
+ * apfs_node_insert - Insert a new record in a node that has enough room
+ * @query:	query run to search for the record
+ * @key:	on-disk record key
+ * @key_len:	length of @key
+ * @val:	on-disk record value (NULL for ghost records)
+ * @val_len:	length of @val (0 for ghost records)
+ *
+ * The new record is placed right after the one found by @query. On success,
+ * returns 0 and sets @query to the new record. In case of failure, returns a
+ * negative error code and leaves @query pointing to the same record.
+ */
+int apfs_node_insert(struct apfs_query *query, void *key, int key_len, void *val, int val_len)
+{
+	struct apfs_node *node = query->node;
+	struct super_block *sb = node->object.sb;
+	struct apfs_btree_node_phys *node_raw = (void *)node->object.data;
+	int toc_entry_size;
+	int key_off, val_off, err;
+	bool defragged = false;
+
+	apfs_assert_in_transaction(sb, &node_raw->btn_o);
+
+retry:
+	if (apfs_node_has_fixed_kv_size(node))
+		toc_entry_size = sizeof(struct apfs_kvoff);
+	else
+		toc_entry_size = sizeof(struct apfs_kvloc);
+
+	/* Expand the table of contents if necessary */
+	if (sizeof(*node_raw) + (node->records + 1) * toc_entry_size > node->key) {
+		int new_key_base = node->key;
+		int new_free_base = node->free;
+		int inc;
+
+		inc = APFS_BTREE_TOC_ENTRY_INCREMENT * toc_entry_size;
+
+		new_key_base += inc;
+		new_free_base += inc;
+		if (new_free_base > node->val)
+			goto defrag;
+		memmove((void *)node_raw + new_key_base,
+			(void *)node_raw + node->key, node->free - node->key);
+
+		node->key = new_key_base;
+		node->free = new_free_base;
+		query->key_off += inc;
+	}
+
+	key_off = apfs_node_alloc_key(node, key_len);
+	if (key_off < 0) {
+		if (key_off == -ENOSPC)
+			goto defrag;
+		return key_off;
+	}
+
+	if (val) {
+		val_off = apfs_node_alloc_val(node, val_len);
+		if (val_off < 0) {
+			if (val_off == -ENOSPC) {
+				/*
+				 * There is no need for an update of the on-disk
+				 * node before the defrag, since only in-memory
+				 * data should be used there...
+				 */
+				goto defrag;
+			}
+			return val_off;
+		}
+	}
+
+	query->key_len = key_len;
+	query->key_off = key_off;
+	memcpy((void *)node_raw + key_off, key, key_len);
+
+	query->len = val_len;
+	if (val) {
+		query->off = val_off;
+		memcpy((void *)node_raw + val_off, val, val_len);
+	} else {
+		query->off = 0;
+	}
+
+	query->index++; /* The query returned the record right before @key */
+
+	/* Add the new entry to the table of contents */
+	apfs_create_toc_entry(query);
+
+	apfs_update_node(node);
+	return 0;
+
+defrag:
+	if (defragged) {
+		apfs_err(sb, "node reports incorrect free space");
+		return -EFSCORRUPTED;
+	}
+	err = apfs_defragment_node(node);
+	if (err) {
+		apfs_err(sb, "failed to defragment node");
+		return err;
+	}
+	defragged = true;
+	goto retry;
+}
+
+/**
+ * apfs_create_single_rec_node - Creates a new node with a single record
+ * @query:	query run to search for the record
+ * @key:	on-disk record key
+ * @key_len:	length of @key
+ * @val:	on-disk record value
+ * @val_len:	length of @val
+ *
+ * The new node is placed right after the one found by @query, which must have
+ * a single record. On success, returns 0 and sets @query to the new record;
+ * returns a negative error code in case of failure, which may be -EAGAIN if a
+ * node split has happened and the caller must refresh and retry.
+ */
+int apfs_create_single_rec_node(struct apfs_query *query, void *key, int key_len, void *val, int val_len)
+{
+	struct super_block *sb = NULL;
+	struct apfs_node *new_node = NULL, *prev_node = NULL;
+	struct apfs_btree_node_phys *prev_raw = NULL;
+	struct apfs_btree_node_phys *new_raw = NULL;
+	int err;
+
+	prev_node = query->node;
+	sb = prev_node->object.sb;
+
+	ASSERT(query->parent);
+	ASSERT(prev_node->records == 1);
+	ASSERT(val && val_len);
+
+	/* This function should only be needed for huge catalog records */
+	if (prev_node->tree_type != APFS_OBJECT_TYPE_FSTREE) {
+		apfs_err(sb, "huge node records in the wrong tree");
+		return -EFSCORRUPTED;
+	}
+
+	/*
+	 * This will only be called for leaf nodes because it's the values that
+	 * can get huge, not the keys. It will also never be called for root,
+	 * because the catalog always has more than a single record.
+	 */
+	if (apfs_node_is_root(prev_node) || !apfs_node_is_leaf(prev_node)) {
+		apfs_err(sb, "huge record in index node");
+		return -EFSCORRUPTED;
+	}
+
+	new_node = apfs_create_node(sb, apfs_query_storage(query));
+	if (IS_ERR(new_node)) {
+		apfs_err(sb, "node creation failed");
+		return PTR_ERR(new_node);
+	}
+	new_node->tree_type = prev_node->tree_type;
+	new_node->flags = prev_node->flags;
+	new_node->records = 0;
+	new_node->key_free_list_len = 0;
+	new_node->val_free_list_len = 0;
+	new_node->key = new_node->free = sizeof(*new_raw);
+	new_node->val = sb->s_blocksize; /* Nonroot */
+
+	prev_raw = (void *)prev_node->object.data;
+	new_raw = (void *)new_node->object.data;
+	apfs_assert_in_transaction(sb, &new_raw->btn_o);
+	new_raw->btn_level = prev_raw->btn_level;
+	apfs_update_node(new_node);
+
+	query->node = new_node;
+	new_node = NULL;
+	query->index = -1;
+	err = apfs_node_insert(query, key, key_len, val, val_len);
+	if (err) {
+		apfs_err(sb, "node record insertion failed");
+		goto fail;
+	}
+
+	err = apfs_attach_child(query->parent, query->node);
+	if (err) {
+		if (err != -EAGAIN) {
+			apfs_err(sb, "child attachment failed");
+			goto fail;
+		}
+		err = apfs_delete_node(query->node, query->flags & APFS_QUERY_TREE_MASK);
+		if (err) {
+			apfs_err(sb, "node cleanup failed for query retry");
+			goto fail;
+		}
+
+		/*
+		 * The query must remain pointing to the original node for the
+		 * refresh to take place. The index will not matter though.
+		 */
+		new_node = query->node;
+		query->node = prev_node;
+		prev_node = NULL;
+		err = -EAGAIN;
+		goto fail;
+	}
+	apfs_btree_change_node_count(query->parent, 1 /* change */);
+
+fail:
+	apfs_node_free(prev_node);
+	apfs_node_free(new_node);
+	return err;
+}
diff --git a/drivers/staging/apfs/object.c b/drivers/staging/apfs/object.c
new file mode 100644
index 0000000000000000000000000000000000000000..9636a9a29314006fad8552e606a8065048f3de4a
--- /dev/null
+++ b/drivers/staging/apfs/object.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Checksum routines for an APFS object
+ */
+
+#include <linux/buffer_head.h>
+#include <linux/fs.h>
+#include "apfs.h"
+
+/*
+ * Note that this is not a generic implementation of fletcher64, as it assumes
+ * a message length that doesn't overflow sum1 and sum2.  This constraint is ok
+ * for apfs, though, since the block size is limited to 2^16.  For a more
+ * generic optimized implementation, see Nakassis (1988).
+ */
+static u64 apfs_fletcher64(void *addr, size_t len)
+{
+	__le32 *buff = addr;
+	u64 sum1 = 0;
+	u64 sum2 = 0;
+	u64 c1, c2;
+	int i, count_32;
+
+	count_32 = len >> 2;
+	for (i = 0; i < count_32; i++) {
+		sum1 += le32_to_cpu(buff[i]);
+		sum2 += sum1;
+	}
+
+	c1 = sum1 + sum2;
+	c1 = 0xFFFFFFFF - do_div(c1, 0xFFFFFFFF);
+	c2 = sum1 + c1;
+	c2 = 0xFFFFFFFF - do_div(c2, 0xFFFFFFFF);
+
+	return (c2 << 32) | c1;
+}
+
+int apfs_obj_verify_csum(struct super_block *sb, struct buffer_head *bh)
+{
+	/* The checksum may be stale until the transaction is committed */
+	if (buffer_trans(bh))
+		return 1;
+	return apfs_multiblock_verify_csum(bh->b_data, sb->s_blocksize);
+}
+
+/**
+ * apfs_multiblock_verify_csum - Verify an object's checksum
+ * @object:	the object to verify
+ * @size:	size of the object in bytes (may be multiple blocks)
+ *
+ * Returns 1 on success, 0 on failure.
+ */
+int apfs_multiblock_verify_csum(char *object, u32 size)
+{
+	struct apfs_obj_phys *obj = (struct apfs_obj_phys *)object;
+	u64 actual_csum, header_csum;
+
+	header_csum = le64_to_cpu(obj->o_cksum);
+	actual_csum = apfs_fletcher64(object + APFS_MAX_CKSUM_SIZE, size - APFS_MAX_CKSUM_SIZE);
+	return header_csum == actual_csum;
+}
+
+/**
+ * apfs_obj_set_csum - Set the fletcher checksum in an object header
+ * @sb:		superblock structure
+ * @obj:	the object header
+ *
+ * The object must have a length of a single block.
+ */
+void apfs_obj_set_csum(struct super_block *sb, struct apfs_obj_phys *obj)
+{
+	apfs_multiblock_set_csum((char *)obj, sb->s_blocksize);
+}
+
+/**
+ * apfs_multiblock_set_csum - Set an object's checksum
+ * @object:	the object to checksum
+ * @size:	size of the object in bytes (may be multiple blocks)
+ */
+void apfs_multiblock_set_csum(char *object, u32 size)
+{
+	struct apfs_obj_phys *obj = (struct apfs_obj_phys *)object;
+	u64 cksum;
+
+	cksum = apfs_fletcher64(object + APFS_MAX_CKSUM_SIZE, size - APFS_MAX_CKSUM_SIZE);
+	obj->o_cksum = cpu_to_le64(cksum);
+}
+
+/**
+ * apfs_create_cpm_block - Create a new checkpoint-mapping block
+ * @sb:		filesystem superblock
+ * @bno:	block number to use
+ * @bh_p:	on return, the buffer head for the block
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+int apfs_create_cpm_block(struct super_block *sb, u64 bno, struct buffer_head **bh_p)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_checkpoint_map_phys *cpm = NULL;
+	struct buffer_head *bh = NULL;
+	int err;
+
+	bh = apfs_getblk(sb, bno);
+	if (!bh) {
+		apfs_err(sb, "failed to map cpm block");
+		return -EIO;
+	}
+	err = apfs_transaction_join(sb, bh);
+	if (err) {
+		brelse(bh);
+		return err;
+	}
+	set_buffer_csum(bh);
+
+	cpm = (void *)bh->b_data;
+	memset(cpm, 0, sb->s_blocksize);
+	cpm->cpm_o.o_oid = cpu_to_le64(bno);
+	cpm->cpm_o.o_xid = cpu_to_le64(nxi->nx_xid);
+	cpm->cpm_o.o_type = cpu_to_le32(APFS_OBJ_PHYSICAL | APFS_OBJECT_TYPE_CHECKPOINT_MAP);
+	cpm->cpm_o.o_subtype = cpu_to_le32(APFS_OBJECT_TYPE_INVALID);
+
+	/* For now: the caller will have to update these fields */
+	cpm->cpm_flags = cpu_to_le32(APFS_CHECKPOINT_MAP_LAST);
+	cpm->cpm_count = 0;
+
+	*bh_p = bh;
+	return 0;
+}
+
+/**
+ * apfs_create_cpoint_map - Create a checkpoint mapping for an object
+ * @sb:		filesystem superblock
+ * @cpm:	checkpoint mapping block to use
+ * @obj:	header for the ephemeral object
+ * @bno:	block number for the ephemeral object
+ * @size:	size of the ephemeral object in bytes
+ *
+ * Returns 0 on success or a negative error code in case of failure, which may
+ * be -ENOSPC if @cpm is full.
+ */
+int apfs_create_cpoint_map(struct super_block *sb, struct apfs_checkpoint_map_phys *cpm, struct apfs_obj_phys *obj, u64 bno, u32 size)
+{
+	struct apfs_checkpoint_mapping *map = NULL;
+	u32 cpm_count;
+
+	apfs_assert_in_transaction(sb, &cpm->cpm_o);
+
+	cpm_count = le32_to_cpu(cpm->cpm_count);
+	if (cpm_count >= apfs_max_maps_per_block(sb))
+		return -ENOSPC;
+	map = &cpm->cpm_map[cpm_count];
+	le32_add_cpu(&cpm->cpm_count, 1);
+
+	map->cpm_type = obj->o_type;
+	map->cpm_subtype = obj->o_subtype;
+	map->cpm_size = cpu_to_le32(size);
+	map->cpm_pad = 0;
+	map->cpm_fs_oid = 0;
+	map->cpm_oid = obj->o_oid;
+	map->cpm_paddr = cpu_to_le64(bno);
+	return 0;
+}
+
+/**
+ * apfs_index_in_data_area - Get position of block in current checkpoint's data
+ * @sb:		superblock structure
+ * @bno:	block number
+ */
+u32 apfs_index_in_data_area(struct super_block *sb, u64 bno)
+{
+	struct apfs_nx_superblock *raw_sb = APFS_NXI(sb)->nx_raw;
+	u64 data_base = le64_to_cpu(raw_sb->nx_xp_data_base);
+	u32 data_index = le32_to_cpu(raw_sb->nx_xp_data_index);
+	u32 data_blks = le32_to_cpu(raw_sb->nx_xp_data_blocks);
+	u64 tmp;
+
+	tmp = bno - data_base + data_blks - data_index;
+	return do_div(tmp, data_blks);
+}
+
+/**
+ * apfs_data_index_to_bno - Convert index in data area to block number
+ * @sb:		superblock structure
+ * @index:	index of the block in the current checkpoint's data area
+ */
+u64 apfs_data_index_to_bno(struct super_block *sb, u32 index)
+{
+	struct apfs_nx_superblock *raw_sb = APFS_NXI(sb)->nx_raw;
+	u64 data_base = le64_to_cpu(raw_sb->nx_xp_data_base);
+	u32 data_index = le32_to_cpu(raw_sb->nx_xp_data_index);
+	u32 data_blks = le32_to_cpu(raw_sb->nx_xp_data_blocks);
+
+	return data_base + (index + data_index) % data_blks;
+}
+
+/**
+ * apfs_ephemeral_object_lookup - Find an ephemeral object info in memory
+ * @sb:		superblock structure
+ * @oid:	ephemeral object id
+ *
+ * Returns a pointer to the object info on success, or an error pointer in case
+ * of failure.
+ */
+struct apfs_ephemeral_object_info *apfs_ephemeral_object_lookup(struct super_block *sb, u64 oid)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_ephemeral_object_info *list = NULL;
+	int i;
+
+	list = nxi->nx_eph_list;
+	for (i = 0; i < nxi->nx_eph_count; ++i) {
+		if (list[i].oid == oid)
+			return &list[i];
+	}
+	apfs_err(sb, "no mapping for oid 0x%llx", oid);
+	return ERR_PTR(-EFSCORRUPTED);
+}
+
+/**
+ * apfs_read_object_block - Map a non-ephemeral object block
+ * @sb:		superblock structure
+ * @bno:	block number for the object
+ * @write:	request write access?
+ * @preserve:	preserve the old block?
+ *
+ * On success returns the mapped buffer head for the object, which may now be
+ * in a new location if write access was requested.  Returns an error pointer
+ * in case of failure.
+ */
+struct buffer_head *apfs_read_object_block(struct super_block *sb, u64 bno, bool write, bool preserve)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_superblock *vsb_raw = NULL;
+	struct buffer_head *bh, *new_bh;
+	struct apfs_obj_phys *obj;
+	u32 type;
+	u64 new_bno;
+	int err;
+
+	ASSERT(write || !preserve);
+
+	bh = apfs_sb_bread(sb, bno);
+	if (!bh) {
+		apfs_err(sb, "failed to read object block 0x%llx", bno);
+		return ERR_PTR(-EIO);
+	}
+
+	obj = (struct apfs_obj_phys *)bh->b_data;
+	type = le32_to_cpu(obj->o_type);
+	ASSERT(!(type & APFS_OBJ_EPHEMERAL));
+	if (nxi->nx_flags & APFS_CHECK_NODES && !apfs_obj_verify_csum(sb, bh)) {
+		apfs_err(sb, "bad checksum for object in block 0x%llx", bno);
+		err = -EFSBADCRC;
+		goto fail;
+	}
+
+	if (!write)
+		return bh;
+	ASSERT(!(sb->s_flags & SB_RDONLY));
+
+	/* Is the object already part of the current transaction? */
+	if (obj->o_xid == cpu_to_le64(nxi->nx_xid))
+		return bh;
+
+	err = apfs_spaceman_allocate_block(sb, &new_bno, true /* backwards */);
+	if (err) {
+		apfs_err(sb, "block allocation failed");
+		goto fail;
+	}
+	new_bh = apfs_getblk(sb, new_bno);
+	if (!new_bh) {
+		apfs_err(sb, "failed to map block for CoW (0x%llx)", new_bno);
+		err = -EIO;
+		goto fail;
+	}
+	memcpy(new_bh->b_data, bh->b_data, sb->s_blocksize);
+
+	/*
+	 * Don't free the old copy of the object if it's part of a snapshot.
+	 * Also increase the allocation count, except for the volume superblock
+	 * which is never counted there.
+	 */
+	if (!preserve) {
+		err = apfs_free_queue_insert(sb, bh->b_blocknr, 1);
+		if (err)
+			apfs_err(sb, "free queue insertion failed for 0x%llx", (unsigned long long)bh->b_blocknr);
+	} else if ((type & APFS_OBJECT_TYPE_MASK) != APFS_OBJECT_TYPE_FS) {
+		vsb_raw = APFS_SB(sb)->s_vsb_raw;
+		apfs_assert_in_transaction(sb, &vsb_raw->apfs_o);
+		le64_add_cpu(&vsb_raw->apfs_fs_alloc_count, 1);
+		le64_add_cpu(&vsb_raw->apfs_total_blocks_alloced, 1);
+	}
+
+	brelse(bh);
+	bh = new_bh;
+	new_bh = NULL;
+	if (err)
+		goto fail;
+	obj = (struct apfs_obj_phys *)bh->b_data;
+
+	if (type & APFS_OBJ_PHYSICAL)
+		obj->o_oid = cpu_to_le64(new_bno);
+	obj->o_xid = cpu_to_le64(nxi->nx_xid);
+	err = apfs_transaction_join(sb, bh);
+	if (err)
+		goto fail;
+
+	set_buffer_csum(bh);
+	return bh;
+
+fail:
+	brelse(bh);
+	return ERR_PTR(err);
+}
diff --git a/drivers/staging/apfs/snapshot.c b/drivers/staging/apfs/snapshot.c
new file mode 100644
index 0000000000000000000000000000000000000000..6f70d4c1fbff40aa97449edc47261513e0bd68f5
--- /dev/null
+++ b/drivers/staging/apfs/snapshot.c
@@ -0,0 +1,684 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Ernesto A. Fernández <ernesto@corellium.com>
+ * Copyright (C) 2025 Ethan Carter Edwards <ethan@ethancedwards.com>
+ */
+
+#include <linux/mount.h>
+#include <linux/slab.h>
+#include "apfs.h"
+
+/**
+ * apfs_create_superblock_snapshot - Take a snapshot of the volume superblock
+ * @sb:		superblock structure
+ * @bno:	on return, the block number for the new superblock copy
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_create_superblock_snapshot(struct super_block *sb, u64 *bno)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_superblock *vsb_raw = sbi->s_vsb_raw;
+	struct buffer_head *curr_bh = NULL;
+	struct buffer_head *snap_bh = NULL;
+	struct apfs_superblock *snap_raw = NULL;
+	int err;
+
+	err = apfs_spaceman_allocate_block(sb, bno, true /* backwards */);
+	if (err) {
+		apfs_err(sb, "block allocation failed");
+		goto fail;
+	}
+
+	snap_bh = apfs_getblk(sb, *bno);
+	if (!snap_bh) {
+		apfs_err(sb, "failed to map block for volume snap (0x%llx)", *bno);
+		err = -EIO;
+		goto fail;
+	}
+	apfs_assert_in_transaction(sb, &vsb_raw->apfs_o);
+
+	curr_bh = sbi->s_vobject.o_bh;
+	memcpy(snap_bh->b_data, curr_bh->b_data, sb->s_blocksize);
+	curr_bh = NULL;
+
+	err = apfs_transaction_join(sb, snap_bh);
+	if (err)
+		goto fail;
+	set_buffer_csum(snap_bh);
+
+	snap_raw = (struct apfs_superblock *)snap_bh->b_data;
+	/* Volume superblocks in snapshots are physical objects */
+	snap_raw->apfs_o.o_oid = cpu_to_le64p(bno);
+	snap_raw->apfs_o.o_type = cpu_to_le32(APFS_OBJ_PHYSICAL | APFS_OBJECT_TYPE_FS);
+	/* The omap is shared with the current volume */
+	snap_raw->apfs_omap_oid = 0;
+	/* The extent reference tree is given by the snapshot metadata */
+	snap_raw->apfs_extentref_tree_oid = 0;
+	/* No snapshots inside snapshots */
+	snap_raw->apfs_snap_meta_tree_oid = 0;
+
+	err = 0;
+fail:
+	snap_raw = NULL;
+	brelse(snap_bh);
+	snap_bh = NULL;
+	return err;
+}
+
+static int apfs_create_snap_metadata_rec(struct inode *mntpoint, struct apfs_node *snap_root, const char *name, int name_len, u64 sblock_oid)
+{
+	struct super_block *sb = mntpoint->i_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_superblock *vsb_raw = sbi->s_vsb_raw;
+	struct apfs_query *query = NULL;
+	struct apfs_snap_metadata_key raw_key;
+	struct apfs_snap_metadata_val *raw_val = NULL;
+	int val_len;
+	struct timespec64 now;
+	u64 xid = APFS_NXI(sb)->nx_xid;
+	int err;
+
+	query = apfs_alloc_query(snap_root, NULL /* parent */);
+	if (!query) {
+		err = -ENOMEM;
+		goto fail;
+	}
+	apfs_init_snap_metadata_key(xid, &query->key);
+	query->flags |= APFS_QUERY_SNAP_META | APFS_QUERY_EXACT;
+
+	err = apfs_btree_query(sb, &query);
+	if (err == 0) {
+		apfs_err(sb, "record exists for xid 0x%llx", xid);
+		err = -EFSCORRUPTED;
+		goto fail;
+	}
+	if (err != -ENODATA) {
+		apfs_err(sb, "query failed for xid 0x%llx", xid);
+		goto fail;
+	}
+
+	apfs_key_set_hdr(APFS_TYPE_SNAP_METADATA, xid, &raw_key);
+
+	val_len = sizeof(*raw_val) + name_len + 1;
+	raw_val = kzalloc(val_len, GFP_KERNEL);
+	if (!raw_val) {
+		err = -ENOMEM;
+		goto fail;
+	}
+	raw_val->extentref_tree_oid = vsb_raw->apfs_extentref_tree_oid;
+	raw_val->sblock_oid = cpu_to_le64(sblock_oid);
+	now = current_time(mntpoint);
+	raw_val->create_time = cpu_to_le64(timespec64_to_ns(&now));
+	raw_val->change_time = raw_val->create_time;
+	raw_val->extentref_tree_type = vsb_raw->apfs_extentref_tree_type;
+	raw_val->flags = 0;
+	raw_val->name_len = cpu_to_le16(name_len + 1); /* Count the null byte */
+	strscpy(raw_val->name, name, name_len + 1);
+
+	apfs_assert_in_transaction(sb, &vsb_raw->apfs_o);
+	raw_val->inum = vsb_raw->apfs_next_obj_id;
+	le64_add_cpu(&vsb_raw->apfs_next_obj_id, 1);
+
+	err = apfs_btree_insert(query, &raw_key, sizeof(raw_key), raw_val, val_len);
+	if (err)
+		apfs_err(sb, "insertion failed for xid 0x%llx", xid);
+fail:
+	kfree(raw_val);
+	raw_val = NULL;
+	apfs_free_query(query);
+	query = NULL;
+	return err;
+}
+
+static int apfs_create_snap_name_rec(struct apfs_node *snap_root, const char *name, int name_len)
+{
+	struct super_block *sb = snap_root->object.sb;
+	struct apfs_query *query = NULL;
+	struct apfs_snap_name_key *raw_key = NULL;
+	struct apfs_snap_name_val raw_val;
+	int key_len;
+	int err;
+
+	query = apfs_alloc_query(snap_root, NULL /* parent */);
+	if (!query) {
+		err = -ENOMEM;
+		goto fail;
+	}
+	apfs_init_snap_name_key(name, &query->key);
+	query->flags |= APFS_QUERY_SNAP_META | APFS_QUERY_EXACT;
+
+	err = apfs_btree_query(sb, &query);
+	if (err == 0) {
+		/* This should never happen here, the caller has checked */
+		apfs_alert(sb, "snapshot name record already exists");
+		err = -EFSCORRUPTED;
+		goto fail;
+	}
+	if (err != -ENODATA) {
+		apfs_err(sb, "query failed (%s)", name);
+		goto fail;
+	}
+
+	key_len = sizeof(*raw_key) + name_len + 1;
+	raw_key = kzalloc(key_len, GFP_KERNEL);
+	if (!raw_key) {
+		err = -ENOMEM;
+		goto fail;
+	}
+	apfs_key_set_hdr(APFS_TYPE_SNAP_NAME, APFS_SNAP_NAME_OBJ_ID, raw_key);
+	raw_key->name_len = cpu_to_le16(name_len + 1); /* Count the null byte */
+	strscpy(raw_key->name, name, name_len + 1);
+
+	raw_val.snap_xid = cpu_to_le64(APFS_NXI(sb)->nx_xid);
+
+	err = apfs_btree_insert(query, raw_key, key_len, &raw_val, sizeof(raw_val));
+	if (err)
+		apfs_err(sb, "insertion failed (%s)", name);
+fail:
+	kfree(raw_key);
+	raw_key = NULL;
+	apfs_free_query(query);
+	query = NULL;
+	return err;
+}
+
+static int apfs_create_snap_meta_records(struct inode *mntpoint, const char *name, int name_len, u64 sblock_oid)
+{
+	struct super_block *sb = mntpoint->i_sb;
+	struct apfs_superblock *vsb_raw = APFS_SB(sb)->s_vsb_raw;
+	struct apfs_node *snap_root = NULL;
+	int err;
+
+	snap_root = apfs_read_node(sb, le64_to_cpu(vsb_raw->apfs_snap_meta_tree_oid), APFS_OBJ_PHYSICAL, true /* write */);
+	if (IS_ERR(snap_root)) {
+		apfs_err(sb, "failed to read snap meta root 0x%llx", le64_to_cpu(vsb_raw->apfs_snap_meta_tree_oid));
+		return PTR_ERR(snap_root);
+	}
+	apfs_assert_in_transaction(sb, &vsb_raw->apfs_o);
+	vsb_raw->apfs_snap_meta_tree_oid = cpu_to_le64(snap_root->object.oid);
+
+	err = apfs_create_snap_metadata_rec(mntpoint, snap_root, name, name_len, sblock_oid);
+	if (err) {
+		apfs_err(sb, "meta rec creation failed");
+		goto fail;
+	}
+	err = apfs_create_snap_name_rec(snap_root, name, name_len);
+	if (err)
+		apfs_err(sb, "name rec creation failed");
+
+fail:
+	apfs_node_free(snap_root);
+	return err;
+}
+
+static int apfs_create_new_extentref_tree(struct super_block *sb)
+{
+	struct apfs_superblock *vsb_raw = APFS_SB(sb)->s_vsb_raw;
+	u64 oid;
+	int err;
+
+	err = apfs_make_empty_btree_root(sb, APFS_OBJECT_TYPE_BLOCKREFTREE, &oid);
+	if (err) {
+		apfs_err(sb, "failed to make empty root");
+		return err;
+	}
+
+	apfs_assert_in_transaction(sb, &vsb_raw->apfs_o);
+	vsb_raw->apfs_extentref_tree_oid = cpu_to_le64(oid);
+	return 0;
+}
+
+/**
+ * apfs_update_omap_snap_tree - Add the current xid to the omap's snapshot tree
+ * @sb:		filesystem superblock
+ * @oid_p:	pointer to the on-disk block number for the root node
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+static int apfs_update_omap_snap_tree(struct super_block *sb, __le64 *oid_p)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_node *root = NULL;
+	u64 oid = le64_to_cpup(oid_p);
+	struct apfs_query *query = NULL;
+	__le64 raw_key;
+	struct apfs_omap_snapshot raw_val = {0};
+	int err;
+
+	/* An empty snapshots tree may not even have a root yet */
+	if (!oid) {
+		err = apfs_make_empty_btree_root(sb, APFS_OBJECT_TYPE_OMAP_SNAPSHOT, &oid);
+		if (err) {
+			apfs_err(sb, "failed to make empty root");
+			return err;
+		}
+	}
+
+	root = apfs_read_node(sb, oid, APFS_OBJ_PHYSICAL, true /* write */);
+	if (IS_ERR(root)) {
+		apfs_err(sb, "failed to read omap snap root 0x%llx", oid);
+		return PTR_ERR(root);
+	}
+	oid = 0;
+
+	query = apfs_alloc_query(root, NULL /* parent */);
+	if (!query) {
+		err = -ENOMEM;
+		goto fail;
+	}
+	apfs_init_omap_snap_key(nxi->nx_xid, &query->key);
+	query->flags = APFS_QUERY_OMAP_SNAP | APFS_QUERY_EXACT;
+
+	err = apfs_btree_query(sb, &query);
+	if (err == 0) {
+		apfs_err(sb, "record exists for xid 0x%llx", nxi->nx_xid);
+		err = -EFSCORRUPTED;
+		goto fail;
+	}
+	if (err != -ENODATA) {
+		apfs_err(sb, "query failed for xid 0x%llx", nxi->nx_xid);
+		goto fail;
+	}
+
+	raw_key = cpu_to_le64(nxi->nx_xid);
+	err = apfs_btree_insert(query, &raw_key, sizeof(raw_key), &raw_val, sizeof(raw_val));
+	if (err)
+		apfs_err(sb, "insertion failed for xid 0x%llx", nxi->nx_xid);
+	*oid_p = cpu_to_le64(root->object.block_nr);
+
+fail:
+	apfs_free_query(query);
+	query = NULL;
+	apfs_node_free(root);
+	root = NULL;
+	return err;
+}
+
+/**
+ * apfs_update_omap_snapshots - Add the current xid to the omap's snapshots
+ * @sb:	filesystem superblock
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+static int apfs_update_omap_snapshots(struct super_block *sb)
+{
+	struct apfs_superblock *vsb_raw = APFS_SB(sb)->s_vsb_raw;
+	struct buffer_head *bh = NULL;
+	struct apfs_omap_phys *omap = NULL;
+	u64 omap_blk;
+	u64 xid;
+	int err;
+
+	xid = APFS_NXI(sb)->nx_xid;
+
+	omap_blk = le64_to_cpu(vsb_raw->apfs_omap_oid);
+	bh = apfs_read_object_block(sb, omap_blk, true /* write */, false /* preserve */);
+	if (IS_ERR(bh)) {
+		apfs_err(sb, "CoW failed for bno 0x%llx", omap_blk);
+		return PTR_ERR(bh);
+	}
+	omap = (struct apfs_omap_phys *)bh->b_data;
+
+	apfs_assert_in_transaction(sb, &omap->om_o);
+	le32_add_cpu(&omap->om_snap_count, 1);
+	omap->om_most_recent_snap = cpu_to_le64(xid);
+	err = apfs_update_omap_snap_tree(sb, &omap->om_snapshot_tree_oid);
+	if (err)
+		apfs_err(sb, "omap snap tree update failed");
+
+	omap = NULL;
+	brelse(bh);
+	bh = NULL;
+	return err;
+}
+
+/**
+ * apfs_snapshot_name_check - Check if a snapshot with the given name exists
+ * @sb:		filesystem superblock
+ * @name:	name to check
+ * @name_len:	length of @name
+ * @eexist:	on return, whether the name exists or not
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+static int apfs_snapshot_name_check(struct super_block *sb, const char *name, int name_len, bool *eexist)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_superblock *vsb_raw = sbi->s_vsb_raw;
+	struct apfs_node *snap_root = NULL;
+	struct apfs_query *query = NULL;
+	int err;
+
+	snap_root = apfs_read_node(sb, le64_to_cpu(vsb_raw->apfs_snap_meta_tree_oid), APFS_OBJ_PHYSICAL, false /* write */);
+	if (IS_ERR(snap_root)) {
+		apfs_err(sb, "failed to read snap meta root 0x%llx", le64_to_cpu(vsb_raw->apfs_snap_meta_tree_oid));
+		return PTR_ERR(snap_root);
+	}
+	vsb_raw = NULL;
+
+	query = apfs_alloc_query(snap_root, NULL /* parent */);
+	if (!query) {
+		err = -ENOMEM;
+		goto out;
+	}
+	apfs_init_snap_name_key(name, &query->key);
+	query->flags |= APFS_QUERY_SNAP_META | APFS_QUERY_EXACT;
+
+	err = apfs_btree_query(sb, &query);
+	if (err == 0) {
+		*eexist = true;
+	} else if (err == -ENODATA) {
+		*eexist = false;
+		err = 0;
+	} else {
+		apfs_err(sb, "query failed (%s)", name);
+	}
+
+out:
+	apfs_free_query(query);
+	query = NULL;
+	apfs_node_free(snap_root);
+	snap_root = NULL;
+	return err;
+}
+
+/**
+ * apfs_do_ioc_takesnapshot - Actual work for apfs_ioc_take_snapshot()
+ * @mntpoint:	inode of the mount point to snapshot
+ * @name:	label for the snapshot
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+static int apfs_do_ioc_take_snapshot(struct inode *mntpoint, const char *name, int name_len)
+{
+	struct super_block *sb = mntpoint->i_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_superblock *vsb_raw = NULL;
+	struct apfs_omap *omap = sbi->s_omap;
+	/* TODO: remember to update the maxops in the future */
+	struct apfs_max_ops maxops = {0};
+	u64 sblock_oid;
+	bool eexist = false;
+	int err;
+
+	err = apfs_transaction_start(sb, maxops);
+	if (err)
+		return err;
+
+	/*
+	 * This check can fail in normal operation, so run it before making any
+	 * changes and exit the transaction cleanly if necessary. The name
+	 * lookup will have to be repeated later, but it's ok because I don't
+	 * expect snapshot creation to be a bottleneck for anyone.
+	 */
+	err = apfs_snapshot_name_check(sb, name, name_len, &eexist);
+	if (err) {
+		apfs_err(sb, "snapshot name existence check failed");
+		goto fail;
+	}
+	if (eexist) {
+		err = apfs_transaction_commit(sb);
+		if (err)
+			goto fail;
+		apfs_warn(sb, "snapshot name already in use (%s)", name);
+		return -EEXIST;
+	}
+
+	/*
+	 * Flush the extent caches to the extenref tree before it gets moved to
+	 * the snapshot. It seems safer in general to avoid big unpredictable
+	 * changes to the layout after the snapshot is set up.
+	 */
+	err = apfs_transaction_flush_all_inodes(sb);
+	if (err) {
+		apfs_err(sb, "failed to flush all inodes");
+		goto fail;
+	}
+
+	err = apfs_create_superblock_snapshot(sb, &sblock_oid);
+	if (err) {
+		apfs_err(sb, "failed to snapshot superblock");
+		goto fail;
+	}
+
+	err = apfs_create_snap_meta_records(mntpoint, name, name_len, sblock_oid);
+	if (err) {
+		apfs_err(sb, "failed to create snap meta records");
+		goto fail;
+	}
+
+	err = apfs_create_new_extentref_tree(sb);
+	if (err) {
+		apfs_err(sb, "failed to create new extref tree");
+		goto fail;
+	}
+
+	err = apfs_update_omap_snapshots(sb);
+	if (err) {
+		apfs_err(sb, "failed to update omap snapshots");
+		goto fail;
+	}
+
+	/*
+	 * The official reference allows old implementations to ignore extended
+	 * snapshot metadata, so I don't see any reason why we can't do the
+	 * same for now.
+	 */
+
+	vsb_raw = sbi->s_vsb_raw;
+	apfs_assert_in_transaction(sb, &vsb_raw->apfs_o);
+	le64_add_cpu(&vsb_raw->apfs_num_snapshots, 1);
+
+	omap->omap_latest_snap = APFS_NXI(sb)->nx_xid;
+
+	sbi->s_nxi->nx_transaction.t_state |= APFS_NX_TRANS_FORCE_COMMIT;
+	err = apfs_transaction_commit(sb);
+	if (err)
+		goto fail;
+	return 0;
+
+fail:
+	apfs_transaction_abort(sb);
+	return err;
+}
+
+/**
+ * apfs_ioc_take_snapshot - Ioctl handler for APFS_IOC_CREATE_SNAPSHOT
+ * @file:	affected file
+ * @arg:	ioctl argument
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+int apfs_ioc_take_snapshot(struct file *file, void __user *user_arg)
+{
+	struct inode *inode = file_inode(file);
+	struct super_block *sb = inode->i_sb;
+	struct apfs_ioctl_snap_name *arg = NULL;
+	size_t name_len;
+	int err;
+
+	if (apfs_ino(inode) != APFS_ROOT_DIR_INO_NUM) {
+		apfs_info(sb, "snapshot must be requested on mountpoint");
+		return -ENOTTY;
+	}
+
+	if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
+		return -EPERM;
+
+	err = mnt_want_write_file(file);
+	if (err)
+		return err;
+
+	arg = kzalloc(sizeof(*arg), GFP_KERNEL);
+	if (!arg) {
+		err = -ENOMEM;
+		goto fail;
+	}
+
+	if (copy_from_user(arg, user_arg, sizeof(*arg))) {
+		err = -EFAULT;
+		goto fail;
+	}
+
+	name_len = strnlen(arg->name, sizeof(arg->name));
+	if (name_len == sizeof(arg->name)) {
+		apfs_warn(sb, "snapshot name is too long (%d)", (int)name_len);
+		err = -EINVAL;
+		goto fail;
+	}
+
+	err = apfs_do_ioc_take_snapshot(inode, arg->name, name_len);
+fail:
+	kfree(arg);
+	arg = NULL;
+	mnt_drop_write_file(file);
+	return err;
+}
+
+static int apfs_snap_xid_from_query(struct apfs_query *query, u64 *xid)
+{
+	char *raw = query->node->object.data;
+	__le64 *val = NULL;
+
+	if (query->len != sizeof(*val)) {
+		apfs_err(query->node->object.sb, "bad value length (%d)", query->len);
+		return -EFSCORRUPTED;
+	}
+	val = (__le64 *)(raw + query->off);
+
+	*xid = le64_to_cpup(val);
+	return 0;
+}
+
+static int apfs_snapshot_name_to_xid(struct apfs_node *snap_root, const char *name, u64 *xid)
+{
+	struct super_block *sb = snap_root->object.sb;
+	struct apfs_query *query = NULL;
+	int err;
+
+	query = apfs_alloc_query(snap_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_snap_name_key(name, &query->key);
+	query->flags |= APFS_QUERY_SNAP_META | APFS_QUERY_EXACT;
+
+	err = apfs_btree_query(sb, &query);
+	if (err) {
+		if (err != -ENODATA)
+			apfs_err(sb, "query failed (%s)", name);
+		goto fail;
+	}
+
+	err = apfs_snap_xid_from_query(query, xid);
+	if (err)
+		apfs_err(sb, "bad snap name record (%s)", name);
+fail:
+	apfs_free_query(query);
+	query = NULL;
+	return err;
+}
+
+static int apfs_snap_sblock_from_query(struct apfs_query *query, u64 *sblock_oid)
+{
+	struct super_block *sb = query->node->object.sb;
+	char *raw = query->node->object.data;
+	struct apfs_snap_metadata_val *val = NULL;
+
+	if (query->len < sizeof(*val)) {
+		apfs_err(sb, "bad value length (%d)", query->len);
+		return -EFSCORRUPTED;
+	}
+	val = (struct apfs_snap_metadata_val *)(raw + query->off);
+
+	/* I don't know anything about these snapshots, can they be mounted? */
+	if (le32_to_cpu(val->flags) & APFS_SNAP_META_PENDING_DATALESS) {
+		apfs_warn(sb, "the requested snapshot is dataless");
+		return -EOPNOTSUPP;
+	}
+
+	*sblock_oid = le64_to_cpu(val->sblock_oid);
+	return 0;
+}
+
+static int apfs_snapshot_xid_to_sblock(struct apfs_node *snap_root, u64 xid, u64 *sblock_oid)
+{
+	struct super_block *sb = snap_root->object.sb;
+	struct apfs_query *query = NULL;
+	int err;
+
+	query = apfs_alloc_query(snap_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_snap_metadata_key(xid, &query->key);
+	query->flags |= APFS_QUERY_SNAP_META | APFS_QUERY_EXACT;
+
+	err = apfs_btree_query(sb, &query);
+	if (err) {
+		apfs_err(sb, "query failed for xid 0x%llx", xid);
+		goto fail;
+	}
+
+	err = apfs_snap_sblock_from_query(query, sblock_oid);
+	if (err)
+		apfs_err(sb, "bad snap meta record for xid 0x%llx", xid);
+fail:
+	apfs_free_query(query);
+	query = NULL;
+	return err;
+}
+
+/**
+ * apfs_switch_to_snapshot - Start working with the snapshot volume superblock
+ * @sb: superblock structure
+ *
+ * Maps the volume superblock from the snapshot specified in the mount options.
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+int apfs_switch_to_snapshot(struct super_block *sb)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_superblock *vsb_raw = sbi->s_vsb_raw;
+	struct apfs_node *snap_root = NULL;
+	const char *name = NULL;
+	u64 sblock_oid = 0;
+	u64 xid = 0;
+	int err;
+
+	ASSERT(sb->s_flags & SB_RDONLY);
+
+	name = sbi->s_snap_name;
+	if (strlen(name) > APFS_SNAP_MAX_NAMELEN) {
+		apfs_warn(sb, "snapshot name is too long");
+		return -EINVAL;
+	}
+
+	snap_root = apfs_read_node(sb, le64_to_cpu(vsb_raw->apfs_snap_meta_tree_oid), APFS_OBJ_PHYSICAL, false /* write */);
+	if (IS_ERR(snap_root)) {
+		apfs_err(sb, "failed to read snap meta root 0x%llx", le64_to_cpu(vsb_raw->apfs_snap_meta_tree_oid));
+		return PTR_ERR(snap_root);
+	}
+	vsb_raw = NULL;
+
+	err = apfs_snapshot_name_to_xid(snap_root, name, &xid);
+	if (err) {
+		if (err == -ENODATA)
+			apfs_info(sb, "no snapshot under that name (%s)", name);
+		goto fail;
+	}
+	sbi->s_snap_xid = xid;
+
+	err = apfs_snapshot_xid_to_sblock(snap_root, xid, &sblock_oid);
+	if (err)
+		goto fail;
+
+	apfs_unmap_volume_super(sb);
+	err = apfs_map_volume_super_bno(sb, sblock_oid, nxi->nx_flags & APFS_CHECK_NODES);
+	if (err)
+		apfs_err(sb, "failed to map volume block 0x%llx", sblock_oid);
+
+fail:
+	apfs_node_free(snap_root);
+	return err;
+}
diff --git a/drivers/staging/apfs/spaceman.c b/drivers/staging/apfs/spaceman.c
new file mode 100644
index 0000000000000000000000000000000000000000..7667f8733cde5389c6af052c398ac8b763185539
--- /dev/null
+++ b/drivers/staging/apfs/spaceman.c
@@ -0,0 +1,1433 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2019 Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
+ */
+
+#include <linux/buffer_head.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include "apfs.h"
+
+/**
+ * apfs_spaceman_read_cib_addr - Get the address of a cib from the spaceman
+ * @sb:		superblock structure
+ * @index:	index of the chunk-info block
+ *
+ * Returns the block number for the chunk-info block.
+ *
+ * This is not described in the official documentation; credit for figuring it
+ * out should go to Joachim Metz: <https://github.com/libyal/libfsapfs>.
+ */
+static u64 apfs_spaceman_read_cib_addr(struct super_block *sb, int index)
+{
+	struct apfs_spaceman *sm = APFS_SM(sb);
+	struct apfs_spaceman_phys *sm_raw = sm->sm_raw;
+	u32 offset;
+	__le64 *addr_p;
+
+	offset = sm->sm_addr_offset + index * sizeof(*addr_p);
+	addr_p = (void *)sm_raw + offset;
+	return le64_to_cpup(addr_p);
+}
+
+/**
+ * apfs_spaceman_write_cib_addr - Store the address of a cib in the spaceman
+ * @sb:		superblock structure
+ * @index:	index of the chunk-info block
+ * @addr:	address of the chunk-info block
+ */
+static void apfs_spaceman_write_cib_addr(struct super_block *sb,
+					 int index, u64 addr)
+{
+	struct apfs_spaceman *sm = APFS_SM(sb);
+	struct apfs_spaceman_phys *sm_raw = sm->sm_raw;
+	u32 offset;
+	__le64 *addr_p;
+
+	apfs_assert_in_transaction(sb, &sm_raw->sm_o);
+
+	offset = sm->sm_addr_offset + index * sizeof(*addr_p);
+	addr_p = (void *)sm_raw + offset;
+	*addr_p = cpu_to_le64(addr);
+}
+
+/**
+ * apfs_max_chunks_per_cib - Find the maximum chunk count for a chunk-info block
+ * @sb: superblock structure
+ */
+static inline int apfs_max_chunks_per_cib(struct super_block *sb)
+{
+	return (sb->s_blocksize - sizeof(struct apfs_chunk_info_block)) /
+						sizeof(struct apfs_chunk_info);
+}
+
+/**
+ * apfs_read_spaceman_dev - Read a space manager device structure
+ * @sb:		superblock structure
+ * @dev:	on-disk device structure
+ *
+ * Initializes the in-memory spaceman fields related to the main device; fusion
+ * drives are not yet supported.  Returns 0 on success, or a negative error code
+ * in case of failure.
+ */
+static int apfs_read_spaceman_dev(struct super_block *sb,
+				  struct apfs_spaceman_device *dev)
+{
+	struct apfs_spaceman *spaceman = APFS_SM(sb);
+
+	if (dev->sm_cab_count) {
+		apfs_err(sb, "large devices are not supported");
+		return -EINVAL;
+	}
+
+	spaceman->sm_block_count = le64_to_cpu(dev->sm_block_count);
+	spaceman->sm_chunk_count = le64_to_cpu(dev->sm_chunk_count);
+	spaceman->sm_cib_count = le32_to_cpu(dev->sm_cib_count);
+	spaceman->sm_free_count = le64_to_cpu(dev->sm_free_count);
+	spaceman->sm_addr_offset = le32_to_cpu(dev->sm_addr_offset);
+
+	/* Check that all the cib addresses fit in the spaceman object */
+	if ((long long)spaceman->sm_addr_offset +
+	    (long long)spaceman->sm_cib_count * sizeof(u64) > spaceman->sm_size) {
+		apfs_err(sb, "too many cibs (%u)", spaceman->sm_cib_count);
+		return -EFSCORRUPTED;
+	}
+
+	return 0;
+}
+
+/**
+ * apfs_spaceman_get_16 - Get a 16-bit value from an offset in the spaceman
+ * @sb:		superblock structure
+ * @off:	offset for the value
+ *
+ * Returns a pointer to the value, or NULL if it doesn't fit.
+ */
+static __le16 *apfs_spaceman_get_16(struct super_block *sb, size_t off)
+{
+	struct apfs_spaceman *spaceman = APFS_SM(sb);
+	struct apfs_spaceman_phys *sm_raw = spaceman->sm_raw;
+
+	if (off > spaceman->sm_size)
+		return NULL;
+	if (off + sizeof(__le16) > spaceman->sm_size)
+		return NULL;
+	return (void *)sm_raw + off;
+}
+
+/**
+ * apfs_spaceman_get_64 - Get a 64-bit value from an offset in the spaceman
+ * @sb:		superblock structure
+ * @off:	offset for the value
+ *
+ * Returns a pointer to the value, or NULL if it doesn't fit.
+ */
+static __le64 *apfs_spaceman_get_64(struct super_block *sb, size_t off)
+{
+	struct apfs_spaceman *spaceman = APFS_SM(sb);
+	struct apfs_spaceman_phys *sm_raw = spaceman->sm_raw;
+
+	if (off > spaceman->sm_size)
+		return NULL;
+	if (off + sizeof(__le64) > spaceman->sm_size)
+		return NULL;
+	return (void *)sm_raw + off;
+}
+
+/**
+ * apfs_allocate_ip_bitmap - Allocate a free ip bitmap block
+ * @sb:		filesystem superblock
+ * @offset_p:	on return, the offset from sm_ip_bm_base of the allocated block
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_allocate_ip_bitmap(struct super_block *sb, u16 *offset_p)
+{
+	struct apfs_spaceman *spaceman = NULL;
+	struct apfs_spaceman_phys *sm_raw = NULL;
+	u32 free_next_offset, old_head_off;
+	u16 free_head, blkcnt;
+	__le16 *old_head_p = NULL;
+
+	spaceman = APFS_SM(sb);
+	sm_raw = spaceman->sm_raw;
+	free_next_offset = le32_to_cpu(sm_raw->sm_ip_bm_free_next_offset);
+	free_head = le16_to_cpu(sm_raw->sm_ip_bm_free_head);
+	blkcnt = (u16)le32_to_cpu(sm_raw->sm_ip_bm_block_count);
+
+	/*
+	 * The "free_next" array is a linked list of free blocks that starts
+	 * with the "free_head". Allocate this head then, and make the next
+	 * block into the new head.
+	 */
+	old_head_off = free_next_offset + free_head * sizeof(*old_head_p);
+	old_head_p = apfs_spaceman_get_16(sb, old_head_off);
+	if (!old_head_p) {
+		apfs_err(sb, "free_next head offset out of bounds (%u)", old_head_off);
+		return -EFSCORRUPTED;
+	}
+	*offset_p = free_head;
+	free_head = le16_to_cpup(old_head_p);
+	sm_raw->sm_ip_bm_free_head = *old_head_p;
+	/* No longer free, no longer part of the linked list */
+	*old_head_p = cpu_to_le16(APFS_SPACEMAN_IP_BM_INDEX_INVALID);
+
+	/* Just a little sanity check because I've messed this up before */
+	if (free_head >= blkcnt || *offset_p >= blkcnt) {
+		apfs_err(sb, "free next list seems empty or corrupt");
+		return -EFSCORRUPTED;
+	}
+
+	return 0;
+}
+
+/**
+ * apfs_free_ip_bitmap - Free a used ip bitmap block
+ * @sb:		filesystem superblock
+ * @offset:	the offset from sm_ip_bm_base of the block to free
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_free_ip_bitmap(struct super_block *sb, u16 offset)
+{
+	struct apfs_spaceman *spaceman = NULL;
+	struct apfs_spaceman_phys *sm_raw = NULL;
+	u32 free_next_offset, old_tail_off;
+	u16 free_tail;
+	__le16 *old_tail_p = NULL;
+
+	spaceman = APFS_SM(sb);
+	sm_raw = spaceman->sm_raw;
+	free_next_offset = le32_to_cpu(sm_raw->sm_ip_bm_free_next_offset);
+	free_tail = le16_to_cpu(sm_raw->sm_ip_bm_free_tail);
+
+	/*
+	 * The "free_next" array is a linked list of free blocks that ends
+	 * with the "free_tail". The block getting freed will become the new
+	 * tail of the list.
+	 */
+	old_tail_off = free_next_offset + free_tail * sizeof(*old_tail_p);
+	old_tail_p = apfs_spaceman_get_16(sb, old_tail_off);
+	if (!old_tail_p) {
+		apfs_err(sb, "free_next tail offset out of bounds (%u)", old_tail_off);
+		return -EFSCORRUPTED;
+	}
+	*old_tail_p = cpu_to_le16(offset);
+	sm_raw->sm_ip_bm_free_tail = cpu_to_le16(offset);
+	free_tail = offset;
+
+	return 0;
+}
+
+/**
+ * apfs_reallocate_ip_bitmap - Find a new block for an ip bitmap
+ * @sb:		filesystem superblock
+ * @offset_p:	the offset from sm_ip_bm_base of the block to free
+ *
+ * On success returns 0 and updates @offset_p to the new offset allocated for
+ * the ip bitmap. Since blocks are allocated at the head of the list and freed
+ * at the tail, there is no risk of reuse by future reallocations within the
+ * same transaction (under there is some serious corruption, of course).
+ *
+ * Returns a negative error code in case of failure.
+ */
+static int apfs_reallocate_ip_bitmap(struct super_block *sb, __le16 *offset_p)
+{
+	int err;
+	u16 offset;
+
+	offset = le16_to_cpup(offset_p);
+
+	err = apfs_free_ip_bitmap(sb, offset);
+	if (err) {
+		apfs_err(sb, "failed to free ip bitmap %u", offset);
+		return err;
+	}
+	err = apfs_allocate_ip_bitmap(sb, &offset);
+	if (err) {
+		apfs_err(sb, "failed to allocate a new ip bitmap block");
+		return err;
+	}
+
+	*offset_p = cpu_to_le16(offset);
+	return 0;
+}
+
+/**
+ * apfs_write_single_ip_bitmap - Write a single ip bitmap to disk
+ * @sb:		filesystem superblock
+ * @bitmap:	bitmap to write
+ * @idx:	index of the ip bitmap to write
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_write_single_ip_bitmap(struct super_block *sb, char *bitmap, u32 idx)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_spaceman *spaceman = APFS_SM(sb);
+	struct apfs_spaceman_phys *sm_raw = spaceman->sm_raw;
+	struct buffer_head *bh = NULL;
+	u64 ip_bm_base, ip_bitmap_bno;
+	u32 xid_off, ip_bitmap_off;
+	__le64 *xid_p = NULL;
+	__le16 *ip_bitmap_p = NULL;
+	int err;
+
+	ip_bm_base = le64_to_cpu(sm_raw->sm_ip_bm_base);
+
+	/* First update the xid, which is kept in a separate array */
+	xid_off = le32_to_cpu(sm_raw->sm_ip_bm_xid_offset) + idx * sizeof(*xid_p);
+	xid_p = apfs_spaceman_get_64(sb, xid_off);
+	if (!xid_p) {
+		apfs_err(sb, "xid out of bounds (%u)", xid_off);
+		return -EFSCORRUPTED;
+	}
+	*xid_p = cpu_to_le64(nxi->nx_xid);
+
+	/* Now get find new location for the ip bitmap (and free the old one) */
+	ip_bitmap_off = le32_to_cpu(sm_raw->sm_ip_bitmap_offset) + idx * sizeof(*ip_bitmap_p);
+	ip_bitmap_p = apfs_spaceman_get_16(sb, ip_bitmap_off);
+	if (!ip_bitmap_p) {
+		apfs_err(sb, "bmap offset out of bounds (%u)", ip_bitmap_off);
+		return -EFSCORRUPTED;
+	}
+	err = apfs_reallocate_ip_bitmap(sb, ip_bitmap_p);
+	if (err) {
+		apfs_err(sb, "failed to reallocate ip bitmap %u", le16_to_cpup(ip_bitmap_p));
+		return err;
+	}
+
+	/* Finally, write the dirty bitmap to the new location */
+	ip_bitmap_bno = ip_bm_base + le16_to_cpup(ip_bitmap_p);
+	bh = apfs_getblk(sb, ip_bitmap_bno);
+	if (!bh) {
+		apfs_err(sb, "failed to map block for CoW (0x%llx)", ip_bitmap_bno);
+		return -EIO;
+	}
+	memcpy(bh->b_data, bitmap, sb->s_blocksize);
+	err = apfs_transaction_join(sb, bh);
+	if (err)
+		goto fail;
+	bh = NULL;
+
+	spaceman->sm_ip_bmaps[idx].dirty = false;
+	return 0;
+
+fail:
+	brelse(bh);
+	bh = NULL;
+	return err;
+}
+
+/**
+ * apfs_write_ip_bitmaps - Write all dirty ip bitmaps to disk
+ * @sb: superblock structure
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+int apfs_write_ip_bitmaps(struct super_block *sb)
+{
+	struct apfs_spaceman *spaceman = APFS_SM(sb);
+	struct apfs_spaceman_phys *sm_raw = spaceman->sm_raw;
+	struct apfs_ip_bitmap_block_info *info = NULL;
+	u32 bmaps_count = spaceman->sm_ip_bmaps_count;
+	int err;
+	u32 i;
+
+	apfs_assert_in_transaction(sb, &sm_raw->sm_o);
+
+	for (i = 0; i < bmaps_count; ++i) {
+		info = &spaceman->sm_ip_bmaps[i];
+		if (!info->dirty)
+			continue;
+		err = apfs_write_single_ip_bitmap(sb, info->block, i);
+		if (err) {
+			apfs_err(sb, "failed to rotate ip bitmap %u", i);
+			return err;
+		}
+	}
+	return 0;
+}
+
+/**
+* apfs_read_single_ip_bitmap - Read a single ip bitmap to memory
+* @sb:	filesystem superblock
+* @idx:	index of the ip bitmap to read
+*
+* Returns 0 on success or a negative error code in case of failure.
+*/
+static int apfs_read_single_ip_bitmap(struct super_block *sb, u32 idx)
+{
+	struct apfs_spaceman *spaceman = APFS_SM(sb);
+	struct apfs_spaceman_phys *sm_raw = spaceman->sm_raw;
+	struct buffer_head *bh = NULL;
+	char *bitmap = NULL;
+	u64 ip_bm_base, ip_bitmap_bno;
+	u32 ip_bitmap_off;
+	__le16 *ip_bitmap_p = NULL;
+	int err;
+
+	ip_bm_base = le64_to_cpu(sm_raw->sm_ip_bm_base);
+
+	ip_bitmap_off = le32_to_cpu(sm_raw->sm_ip_bitmap_offset) + idx * sizeof(*ip_bitmap_p);
+	ip_bitmap_p = apfs_spaceman_get_16(sb, ip_bitmap_off);
+	if (!ip_bitmap_p) {
+		apfs_err(sb, "bmap offset out of bounds (%u)", ip_bitmap_off);
+		return -EFSCORRUPTED;
+	}
+
+	bitmap = kmalloc(sb->s_blocksize, GFP_KERNEL);
+	if (!bitmap)
+		return -ENOMEM;
+
+	ip_bitmap_bno = ip_bm_base + le16_to_cpup(ip_bitmap_p);
+	bh = apfs_sb_bread(sb, ip_bitmap_bno);
+	if (!bh) {
+		apfs_err(sb, "failed to read ip bitmap (0x%llx)", ip_bitmap_bno);
+		err = -EIO;
+		goto fail;
+	}
+	memcpy(bitmap, bh->b_data, sb->s_blocksize);
+	brelse(bh);
+	bh = NULL;
+
+	spaceman->sm_ip_bmaps[idx].dirty = false;
+	spaceman->sm_ip_bmaps[idx].block = bitmap;
+	bitmap = NULL;
+	return 0;
+
+fail:
+	kfree(bitmap);
+	bitmap = NULL;
+	return err;
+}
+
+/**
+ * apfs_read_ip_bitmaps - Read all the ip bitmaps to memory
+ * @sb: superblock structure
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_read_ip_bitmaps(struct super_block *sb)
+{
+	struct apfs_spaceman *spaceman = APFS_SM(sb);
+	u32 bmaps_count = spaceman->sm_ip_bmaps_count;
+	int err;
+	u32 i;
+
+	for (i = 0; i < bmaps_count; ++i) {
+		err = apfs_read_single_ip_bitmap(sb, i);
+		if (err) {
+			apfs_err(sb, "failed to read ip bitmap %u", i);
+			return err;
+		}
+	}
+	return 0;
+}
+
+/*
+ * Free queue record data
+ */
+struct apfs_fq_rec {
+	u64 xid;
+	u64 bno;
+	u64 len;
+};
+
+/**
+ * apfs_fq_rec_from_query - Read the free queue record found by a query
+ * @query:	the query that found the record
+ * @fqrec:	on return, the free queue record
+ *
+ * Reads the free queue record into @fqrec and performs some basic sanity
+ * checks as a protection against crafted filesystems. Returns 0 on success
+ * or -EFSCORRUPTED otherwise.
+ */
+static int apfs_fq_rec_from_query(struct apfs_query *query, struct apfs_fq_rec *fqrec)
+{
+	char *raw = query->node->object.data;
+	struct apfs_spaceman_free_queue_key *key;
+
+	if (query->key_len != sizeof(*key)) {
+		apfs_err(query->node->object.sb, "bad key length (%d)", query->key_len);
+		return -EFSCORRUPTED;
+	}
+	key = (struct apfs_spaceman_free_queue_key *)(raw + query->key_off);
+
+	fqrec->xid = le64_to_cpu(key->sfqk_xid);
+	fqrec->bno = le64_to_cpu(key->sfqk_paddr);
+
+	if (query->len == 0) {
+		fqrec->len = 1; /* Ghost record */
+		return 0;
+	} else if (query->len == sizeof(__le64)) {
+		fqrec->len = le64_to_cpup((__le64 *)(raw + query->off));
+		return 0;
+	}
+	apfs_err(query->node->object.sb, "bad value length (%d)", query->len);
+	return -EFSCORRUPTED;
+}
+
+/**
+ * apfs_block_in_ip - Does this block belong to the internal pool?
+ * @sm:		in-memory spaceman structure
+ * @bno:	block number to check
+ */
+static inline bool apfs_block_in_ip(struct apfs_spaceman *sm, u64 bno)
+{
+	struct apfs_spaceman_phys *sm_raw = sm->sm_raw;
+	u64 start = le64_to_cpu(sm_raw->sm_ip_base);
+	u64 end = start + le64_to_cpu(sm_raw->sm_ip_block_count);
+
+	return bno >= start && bno < end;
+}
+
+/**
+ * apfs_ip_mark_free - Mark a block in the internal pool as free
+ * @sb:		superblock structure
+ * @bno:	block number (must belong to the ip)
+ */
+static int apfs_ip_mark_free(struct super_block *sb, u64 bno)
+{
+	struct apfs_spaceman *sm = APFS_SM(sb);
+	struct apfs_spaceman_phys *sm_raw = sm->sm_raw;
+	struct apfs_ip_bitmap_block_info *info = NULL;
+
+	bno -= le64_to_cpu(sm_raw->sm_ip_base);
+	info = &sm->sm_ip_bmaps[bno >> sm->sm_ip_bmaps_shift];
+	__clear_bit_le(bno & sm->sm_ip_bmaps_mask, info->block);
+	info->dirty = true;
+
+	return 0;
+}
+
+/*
+ * apfs_main_free - Mark a regular block as free
+ */
+static int apfs_main_free(struct super_block *sb, u64 bno);
+
+/**
+ * apfs_flush_fq_rec - Delete a single fq record and mark its blocks as free
+ * @root:	free queue root node
+ * @xid:	transaction to target
+ * @len:	on return, the number of freed blocks
+ *
+ * Returns 0 on success, or a negative error code in case of failure. -ENODATA
+ * in particular means that there are no matching records left.
+ */
+static int apfs_flush_fq_rec(struct apfs_node *root, u64 xid, u64 *len)
+{
+	struct super_block *sb = root->object.sb;
+	struct apfs_spaceman *sm = APFS_SM(sb);
+	struct apfs_query *query = NULL;
+	struct apfs_fq_rec fqrec = {0};
+	u64 bno;
+	int err;
+
+	query = apfs_alloc_query(root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_free_queue_key(xid, 0 /* paddr */, &query->key);
+	query->flags |= APFS_QUERY_FREE_QUEUE | APFS_QUERY_ANY_NUMBER | APFS_QUERY_EXACT;
+
+	err = apfs_btree_query(sb, &query);
+	if (err) {
+		if (err != -ENODATA)
+			apfs_err(sb, "query failed for xid 0x%llx, paddr 0x%llx", xid, 0ULL);
+		goto fail;
+	}
+	err = apfs_fq_rec_from_query(query, &fqrec);
+	if (err) {
+		apfs_err(sb, "bad free queue rec for xid 0x%llx", xid);
+		goto fail;
+	}
+
+	for (bno = fqrec.bno; bno < fqrec.bno + fqrec.len; ++bno) {
+		if (apfs_block_in_ip(sm, bno))
+			err = apfs_ip_mark_free(sb, bno);
+		else
+			err = apfs_main_free(sb, bno);
+		if (err) {
+			apfs_err(sb, "freeing block 0x%llx failed (%d)", (unsigned long long)bno, err);
+			goto fail;
+		}
+	}
+	err = apfs_btree_remove(query);
+	if (err) {
+		apfs_err(sb, "removal failed for xid 0x%llx", xid);
+		goto fail;
+	}
+	*len = fqrec.len;
+
+fail:
+	apfs_free_query(query);
+	return err;
+}
+
+/**
+ * apfs_free_queue_oldest_xid - Find the oldest xid among the free queue records
+ * @root: free queue root node
+ */
+static u64 apfs_free_queue_oldest_xid(struct apfs_node *root)
+{
+	struct apfs_spaceman_free_queue_key *key;
+	char *raw = root->object.data;
+	int len, off;
+
+	if (root->records == 0)
+		return 0;
+	len = apfs_node_locate_key(root, 0, &off);
+	if (len != sizeof(*key)) {
+		/* TODO: abort transaction */
+		apfs_err(root->object.sb, "bad key length (%d)", len);
+		return 0;
+	}
+	key = (struct apfs_spaceman_free_queue_key *)(raw + off);
+	return le64_to_cpu(key->sfqk_xid);
+}
+
+/**
+ * apfs_flush_free_queue - Free ip blocks queued by old transactions
+ * @sb:		superblock structure
+ * @qid:	queue to be freed
+ * @force:	flush as much as possible
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_flush_free_queue(struct super_block *sb, unsigned int qid, bool force)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_spaceman *sm = APFS_SM(sb);
+	struct apfs_spaceman_phys *sm_raw = sm->sm_raw;
+	struct apfs_spaceman_free_queue *fq = &sm_raw->sm_fq[qid];
+	struct apfs_node *fq_root;
+	u64 oldest = le64_to_cpu(fq->sfq_oldest_xid);
+	int err;
+
+	fq_root = apfs_read_node(sb, le64_to_cpu(fq->sfq_tree_oid),
+				 APFS_OBJ_EPHEMERAL, true /* write */);
+	if (IS_ERR(fq_root)) {
+		apfs_err(sb, "failed to read fq root 0x%llx", le64_to_cpu(fq->sfq_tree_oid));
+		return PTR_ERR(fq_root);
+	}
+
+	while (oldest) {
+		u64 sfq_count;
+
+		/*
+		 * Try to preserve one transaction here. I don't really know
+		 * what free queues are for so this is probably silly.
+		 */
+		if (force) {
+			if (oldest == nxi->nx_xid)
+				break;
+		} else {
+			if (oldest + 1 >= nxi->nx_xid)
+				break;
+		}
+
+		while (true) {
+			u64 count = 0;
+
+			/* Probably not very efficient... */
+			err = apfs_flush_fq_rec(fq_root, oldest, &count);
+			if (err == -ENODATA) {
+				err = 0;
+				break;
+			} else if (err) {
+				apfs_err(sb, "failed to flush fq");
+				goto fail;
+			} else {
+				le64_add_cpu(&fq->sfq_count, -count);
+			}
+		}
+		oldest = apfs_free_queue_oldest_xid(fq_root);
+		fq->sfq_oldest_xid = cpu_to_le64(oldest);
+
+		if (force)
+			continue;
+
+		/*
+		 * Flushing a single transaction may not be enough to avoid
+		 * running out of space in the ip, but it's probably best not
+		 * to flush all the old transactions at once either. We use a
+		 * harsher version of the apfs_transaction_need_commit() check,
+		 * to make sure we won't be forced to commit again right away.
+		 */
+		sfq_count = le64_to_cpu(fq->sfq_count);
+		if (qid == APFS_SFQ_IP && sfq_count * 6 <= le64_to_cpu(sm_raw->sm_ip_block_count))
+			break;
+		if (qid == APFS_SFQ_MAIN && sfq_count <= APFS_TRANS_MAIN_QUEUE_MAX - 200)
+			break;
+	}
+
+fail:
+	apfs_node_free(fq_root);
+	return err;
+}
+
+/**
+ * apfs_allocate_spaceman - Allocate an in-memory spaceman struct, if needed
+ * @sb:		superblock structure
+ * @raw:	on-disk spaceman struct
+ * @size:	size of the on-disk spaceman
+ *
+ * Returns the spaceman and sets it in the superblock info. Also performs all
+ * initializations for the internal pool, including reading all the ip bitmaps.
+ * This is a bit out of place here, but it's convenient because it has to
+ * happen only once.
+ *
+ * On failure, returns an error pointer.
+ */
+static struct apfs_spaceman *apfs_allocate_spaceman(struct super_block *sb, struct apfs_spaceman_phys *raw, u32 size)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_spaceman *spaceman = NULL;
+	int blk_bitcnt = sb->s_blocksize * 8;
+	size_t sm_size;
+	u32 bmap_cnt;
+	int err;
+
+	if (nxi->nx_spaceman)
+		return nxi->nx_spaceman;
+
+	/* We don't expect filesystems this big, it would be like 260 TiB */
+	bmap_cnt = le32_to_cpu(raw->sm_ip_bm_size_in_blocks);
+	if (bmap_cnt > 200) {
+		apfs_err(sb, "too many ip bitmap blocks (%u)", bmap_cnt);
+		return ERR_PTR(-EFSCORRUPTED);
+	}
+	sm_size = sizeof(*spaceman) + bmap_cnt * sizeof(spaceman->sm_ip_bmaps[0]);
+
+	spaceman = nxi->nx_spaceman = kzalloc(sm_size, GFP_KERNEL);
+	if (!spaceman)
+		return ERR_PTR(-ENOMEM);
+	spaceman->sm_nxi = nxi;
+	/*
+	 * These two fields must be set before reading the ip bitmaps, since
+	 * that stuff involves several variable-length arrays inside the
+	 * spaceman object itself.
+	 */
+	spaceman->sm_raw = raw;
+	spaceman->sm_size = size;
+
+	spaceman->sm_ip_bmaps_count = bmap_cnt;
+	spaceman->sm_ip_bmaps_mask = blk_bitcnt - 1;
+	spaceman->sm_ip_bmaps_shift = order_base_2(blk_bitcnt);
+
+	/* This must happen only once, so it's easier to just leave it here */
+	err = apfs_read_ip_bitmaps(sb);
+	if (err) {
+		apfs_err(sb, "failed to read the ip bitmaps");
+		kfree(spaceman);
+		nxi->nx_spaceman = spaceman = NULL;
+		return ERR_PTR(err);
+	}
+
+	return nxi->nx_spaceman;
+}
+
+/**
+ * apfs_read_spaceman - Find and read the space manager
+ * @sb: superblock structure
+ *
+ * Reads the space manager structure from disk and initializes its in-memory
+ * counterpart; returns 0 on success, or a negative error code in case of
+ * failure.
+ */
+int apfs_read_spaceman(struct super_block *sb)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_nx_superblock *raw_sb = nxi->nx_raw;
+	struct apfs_spaceman *spaceman = NULL;
+	struct apfs_ephemeral_object_info *sm_eph_info = NULL;
+	struct apfs_spaceman_phys *sm_raw;
+	u32 sm_flags;
+	u64 oid = le64_to_cpu(raw_sb->nx_spaceman_oid);
+	int err;
+
+	if (sb->s_flags & SB_RDONLY) /* The space manager won't be needed */
+		return 0;
+
+	sm_eph_info = apfs_ephemeral_object_lookup(sb, oid);
+	if (IS_ERR(sm_eph_info)) {
+		apfs_err(sb, "no spaceman object for oid 0x%llx", oid);
+		return PTR_ERR(sm_eph_info);
+	}
+	sm_raw = (struct apfs_spaceman_phys *)sm_eph_info->object;
+	sm_raw->sm_o.o_xid = cpu_to_le64(nxi->nx_xid);
+
+	spaceman = apfs_allocate_spaceman(sb, sm_raw, sm_eph_info->size);
+	if (IS_ERR(spaceman)) {
+		apfs_err(sb, "failed to allocate spaceman");
+		err = PTR_ERR(spaceman);
+		goto fail;
+	}
+
+	spaceman->sm_free_cache_base = spaceman->sm_free_cache_blkcnt = 0;
+
+	sm_flags = le32_to_cpu(sm_raw->sm_flags);
+	/* Undocumented feature, but it's too common to refuse to mount */
+	if (sm_flags & APFS_SM_FLAG_VERSIONED)
+		pr_warn_once("APFS: space manager is versioned\n");
+
+	/* Only read the main device; fusion drives are not yet supported */
+	err = apfs_read_spaceman_dev(sb, &sm_raw->sm_dev[APFS_SD_MAIN]);
+	if (err) {
+		apfs_err(sb, "failed to read main device");
+		goto fail;
+	}
+
+	spaceman->sm_blocks_per_chunk =
+				le32_to_cpu(sm_raw->sm_blocks_per_chunk);
+	spaceman->sm_chunks_per_cib = le32_to_cpu(sm_raw->sm_chunks_per_cib);
+	if (spaceman->sm_chunks_per_cib > apfs_max_chunks_per_cib(sb)) {
+		apfs_err(sb, "too many chunks per cib (%u)", spaceman->sm_chunks_per_cib);
+		err = -EFSCORRUPTED;
+		goto fail;
+	}
+
+	err = apfs_flush_free_queue(sb, APFS_SFQ_IP, false /* force */);
+	if (err) {
+		apfs_err(sb, "failed to flush ip fq");
+		goto fail;
+	}
+	err = apfs_flush_free_queue(sb, APFS_SFQ_MAIN, false /* force */);
+	if (err) {
+		apfs_err(sb, "failed to flush main fq");
+		goto fail;
+	}
+	return 0;
+
+fail:
+	spaceman->sm_raw = NULL;
+	return err;
+}
+
+/**
+ * apfs_write_spaceman - Write the in-memory spaceman fields to the disk buffer
+ * @sm: in-memory spaceman structure
+ *
+ * Copies the updated in-memory fields of the space manager into the on-disk
+ * structure; the buffer is not dirtied.
+ */
+static void apfs_write_spaceman(struct apfs_spaceman *sm)
+{
+	struct apfs_spaceman_phys *sm_raw = sm->sm_raw;
+	struct apfs_spaceman_device *dev_raw = &sm_raw->sm_dev[APFS_SD_MAIN];
+	struct apfs_nxsb_info *nxi;
+
+	nxi = sm->sm_nxi;
+	ASSERT(le64_to_cpu(sm_raw->sm_o.o_xid) == nxi->nx_xid);
+
+	dev_raw->sm_free_count = cpu_to_le64(sm->sm_free_count);
+}
+
+/**
+ * apfs_ip_find_free - Find a free block inside the internal pool
+ * @sb:		superblock structure
+ *
+ * Returns the block number for a free block, or 0 in case of corruption.
+ */
+static u64 apfs_ip_find_free(struct super_block *sb)
+{
+	struct apfs_spaceman *sm = APFS_SM(sb);
+	struct apfs_spaceman_phys *sm_raw = sm->sm_raw;
+	int blk_bitcnt = sb->s_blocksize * 8;
+	u64 full_bitcnt = le64_to_cpu(sm_raw->sm_ip_block_count);
+	u32 i;
+
+	for (i = 0; i < sm->sm_ip_bmaps_count; ++i) {
+		char *bitmap = sm->sm_ip_bmaps[i].block;
+		u64 off_in_bmap_blk, off_in_ip;
+
+		off_in_bmap_blk = find_next_zero_bit_le(bitmap, blk_bitcnt, 0 /* offset */);
+		if (off_in_bmap_blk >= blk_bitcnt) /* No space in this chunk */
+			continue;
+
+		/* We found something, confirm that it's not outside the ip */
+		off_in_ip = (i << sm->sm_ip_bmaps_shift) + off_in_bmap_blk;
+		if (off_in_ip >= full_bitcnt)
+			break;
+		return le64_to_cpu(sm_raw->sm_ip_base) + off_in_ip;
+	}
+	apfs_err(sb, "internal pool seems full");
+	return 0;
+}
+
+/**
+ * apfs_chunk_find_free - Find a free block inside a chunk
+ * @sb:		superblock structure
+ * @bitmap:	allocation bitmap for the chunk, which should have free blocks
+ * @addr:	number of the first block in the chunk
+ *
+ * Returns the block number for a free block, or 0 in case of corruption.
+ */
+static u64 apfs_chunk_find_free(struct super_block *sb, char *bitmap, u64 addr)
+{
+	int bitcount = sb->s_blocksize * 8;
+	u64 bno;
+
+	bno = find_next_zero_bit_le(bitmap, bitcount, 0 /* offset */);
+	if (bno >= bitcount)
+		return 0;
+	return addr + bno;
+}
+
+/**
+ * apfs_ip_mark_used - Mark a block in the internal pool as used
+ * @sb:		superblock strucuture
+ * @bno:	block number (must belong to the ip)
+ */
+static void apfs_ip_mark_used(struct super_block *sb, u64 bno)
+{
+	struct apfs_spaceman *sm = APFS_SM(sb);
+	struct apfs_spaceman_phys *sm_raw = sm->sm_raw;
+	struct apfs_ip_bitmap_block_info *info = NULL;
+
+	bno -= le64_to_cpu(sm_raw->sm_ip_base);
+	info = &sm->sm_ip_bmaps[bno >> sm->sm_ip_bmaps_shift];
+	__set_bit_le(bno & sm->sm_ip_bmaps_mask, info->block);
+	info->dirty = true;
+}
+
+/**
+ * apfs_chunk_mark_used - Mark a block inside a chunk as used
+ * @sb:		superblock structure
+ * @bitmap:	allocation bitmap for the chunk
+ * @bno:	block number (must belong to the chunk)
+ */
+static inline void apfs_chunk_mark_used(struct super_block *sb, char *bitmap,
+					u64 bno)
+{
+	int bitcount = sb->s_blocksize * 8;
+
+	__set_bit_le(bno & (bitcount - 1), bitmap);
+}
+
+/**
+ * apfs_chunk_mark_free - Mark a block inside a chunk as free
+ * @sb:		superblock structure
+ * @bitmap:	allocation bitmap for the chunk
+ * @bno:	block number (must belong to the chunk)
+ */
+static inline int apfs_chunk_mark_free(struct super_block *sb, char *bitmap,
+					u64 bno)
+{
+	int bitcount = sb->s_blocksize * 8;
+
+	return __test_and_clear_bit_le(bno & (bitcount - 1), bitmap);
+}
+
+/**
+ * apfs_free_queue_try_insert - Try to add a block range to its free queue
+ * @sb:		superblock structure
+ * @bno:	first block number to free
+ * @count:	number of consecutive blocks to free
+ *
+ * Same as apfs_free_queue_insert_nocache(), except that this one can also fail
+ * with -EAGAIN if there is no room for the new record, so that the caller can
+ * flush the queue and retry.
+ */
+static int apfs_free_queue_try_insert(struct super_block *sb, u64 bno, u64 count)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_spaceman *sm = APFS_SM(sb);
+	struct apfs_spaceman_phys *sm_raw = sm->sm_raw;
+	struct apfs_spaceman_free_queue *fq;
+	struct apfs_node *fq_root = NULL;
+	struct apfs_btree_info *fq_info = NULL;
+	struct apfs_query *query = NULL;
+	struct apfs_spaceman_free_queue_key raw_key;
+	bool ghost = count == 1;
+	int needed_room;
+	__le64 raw_val;
+	u64 node_count;
+	u16 node_limit;
+	int err;
+
+	if (apfs_block_in_ip(sm, bno))
+		fq = &sm_raw->sm_fq[APFS_SFQ_IP];
+	else
+		fq = &sm_raw->sm_fq[APFS_SFQ_MAIN];
+
+	fq_root = apfs_read_node(sb, le64_to_cpu(fq->sfq_tree_oid),
+				 APFS_OBJ_EPHEMERAL, true /* write */);
+	if (IS_ERR(fq_root)) {
+		apfs_err(sb, "failed to read fq root 0x%llx", le64_to_cpu(fq->sfq_tree_oid));
+		return PTR_ERR(fq_root);
+	}
+
+	query = apfs_alloc_query(fq_root, NULL /* parent */);
+	if (!query) {
+		err = -ENOMEM;
+		goto fail;
+	}
+	apfs_init_free_queue_key(nxi->nx_xid, bno, &query->key);
+	query->flags |= APFS_QUERY_FREE_QUEUE;
+
+	err = apfs_btree_query(sb, &query);
+	if (err && err != -ENODATA) {
+		apfs_err(sb, "query failed for xid 0x%llx, paddr 0x%llx", nxi->nx_xid, bno);
+		goto fail;
+	}
+
+	fq_info = (void *)fq_root->object.data + sb->s_blocksize - sizeof(*fq_info);
+	node_count = le64_to_cpu(fq_info->bt_node_count);
+	node_limit = le16_to_cpu(fq->sfq_tree_node_limit);
+	if (node_count == node_limit) {
+		needed_room = sizeof(raw_key) + (ghost ? 0 : sizeof(raw_val));
+		if (!apfs_node_has_room(query->node, needed_room, false /* replace */)) {
+			err = -EAGAIN;
+			goto fail;
+		}
+	}
+
+	raw_key.sfqk_xid = cpu_to_le64(nxi->nx_xid);
+	raw_key.sfqk_paddr = cpu_to_le64(bno);
+	if (ghost) {
+		/* A lack of value (ghost record) means single-block extent */
+		err = apfs_btree_insert(query, &raw_key, sizeof(raw_key), NULL /* val */, 0 /* val_len */);
+	} else {
+		raw_val = cpu_to_le64(count);
+		err = apfs_btree_insert(query, &raw_key, sizeof(raw_key), &raw_val, sizeof(raw_val));
+	}
+	if (err) {
+		apfs_err(sb, "insertion failed for xid 0x%llx, paddr 0x%llx", nxi->nx_xid, bno);
+		goto fail;
+	}
+
+	if (!fq->sfq_oldest_xid)
+		fq->sfq_oldest_xid = cpu_to_le64(nxi->nx_xid);
+	le64_add_cpu(&fq->sfq_count, count);
+
+fail:
+	apfs_free_query(query);
+	apfs_node_free(fq_root);
+	return err;
+}
+
+/**
+ * apfs_free_queue_insert_nocache - Add a block range to its free queue
+ * @sb:		superblock structure
+ * @bno:	first block number to free
+ * @count:	number of consecutive blocks to free
+ *
+ * Same as apfs_free_queue_insert(), but writes to the free queue directly,
+ * bypassing the cache of the latest freed block range.
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+int apfs_free_queue_insert_nocache(struct super_block *sb, u64 bno, u64 count)
+{
+	struct apfs_spaceman *sm = APFS_SM(sb);
+	unsigned int qid;
+	int err;
+
+	err = apfs_free_queue_try_insert(sb, bno, count);
+	if (err == -EAGAIN) {
+		qid = apfs_block_in_ip(sm, bno) ? APFS_SFQ_IP : APFS_SFQ_MAIN;
+		err = apfs_flush_free_queue(sb, qid, true /* force */);
+		if (err) {
+			apfs_err(sb, "failed to flush fq to make room");
+			return err;
+		}
+		err = apfs_free_queue_try_insert(sb, bno, count);
+	}
+	if (err) {
+		if (err == -EAGAIN) {
+			apfs_alert(sb, "failed to make room in fq - bug!");
+			err = -EFSCORRUPTED;
+		}
+		apfs_err(sb, "fq insert failed (0x%llx-0x%llx)", bno, count);
+		return err;
+	}
+	return 0;
+}
+
+/**
+ * apfs_free_queue_insert - Add a block range to its free queue
+ * @sb:		superblock structure
+ * @bno:	first block number to free
+ * @count:	number of consecutive blocks to free
+ *
+ * Uses a cache to delay the actual tree operations as much as possible.
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+int apfs_free_queue_insert(struct super_block *sb, u64 bno, u64 count)
+{
+	struct apfs_spaceman *sm = APFS_SM(sb);
+	int err;
+
+	if (sm->sm_free_cache_base == 0) {
+		/* Nothing yet cached */
+		sm->sm_free_cache_base = bno;
+		sm->sm_free_cache_blkcnt = count;
+		return 0;
+	}
+
+	/*
+	 * First attempt to extend the cache of freed blocks, but never cache
+	 * a range that doesn't belong to a single free queue.
+	 */
+	if (apfs_block_in_ip(sm, bno) == apfs_block_in_ip(sm, sm->sm_free_cache_base)) {
+		if (bno == sm->sm_free_cache_base + sm->sm_free_cache_blkcnt) {
+			sm->sm_free_cache_blkcnt += count;
+			return 0;
+		}
+		if (bno + count == sm->sm_free_cache_base) {
+			sm->sm_free_cache_base -= count;
+			sm->sm_free_cache_blkcnt += count;
+			return 0;
+		}
+	}
+
+	/* Failed to extend the cache, so flush it and replace it */
+	err = apfs_free_queue_insert_nocache(sb, sm->sm_free_cache_base, sm->sm_free_cache_blkcnt);
+	if (err) {
+		apfs_err(sb, "fq cache flush failed (0x%llx-0x%llx)", sm->sm_free_cache_base, sm->sm_free_cache_blkcnt);
+		return err;
+	}
+	sm->sm_free_cache_base = bno;
+	sm->sm_free_cache_blkcnt = count;
+	return 0;
+}
+
+/**
+ * apfs_chunk_alloc_free - Allocate or free block in given CIB and chunk
+ * @sb:		superblock structure
+ * @cib_bh:	buffer head for the chunk-info block
+ * @index:	index of this chunk's info structure inside @cib
+ * @bno:	block number
+ * @is_alloc:	true to allocate, false to free
+ */
+static int apfs_chunk_alloc_free(struct super_block *sb,
+				 struct buffer_head **cib_bh,
+				 int index, u64 *bno, bool is_alloc)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_spaceman *sm = APFS_SM(sb);
+	struct apfs_chunk_info_block *cib;
+	struct apfs_chunk_info *ci;
+	struct buffer_head *bmap_bh = NULL;
+	char *bmap = NULL;
+	bool old_cib = false;
+	bool old_bmap = false;
+	int err = 0;
+
+	cib = (struct apfs_chunk_info_block *)(*cib_bh)->b_data;
+	ci = &cib->cib_chunk_info[index];
+
+	/* Cibs and bitmaps from old transactions can't be modified in place */
+	if (le64_to_cpu(cib->cib_o.o_xid) < nxi->nx_xid)
+		old_cib = true;
+	if (le64_to_cpu(ci->ci_xid) < nxi->nx_xid)
+		old_bmap = true;
+	if (is_alloc && le32_to_cpu(ci->ci_free_count) < 1)
+		return -ENOSPC;
+
+	/* Read the current bitmap, or allocate it if necessary */
+	if (!ci->ci_bitmap_addr) {
+		u64 bmap_bno;
+
+		if (!is_alloc) {
+			apfs_err(sb, "attempt to free block in all-free chunk");
+			return -EFSCORRUPTED;
+		}
+
+		/* All blocks in this chunk are free */
+		bmap_bno = apfs_ip_find_free(sb);
+		if (!bmap_bno) {
+			apfs_err(sb, "no free blocks in ip");
+			return -EFSCORRUPTED;
+		}
+		bmap_bh = apfs_sb_bread(sb, bmap_bno);
+	} else {
+		bmap_bh = apfs_sb_bread(sb, le64_to_cpu(ci->ci_bitmap_addr));
+	}
+	if (!bmap_bh) {
+		apfs_err(sb, "failed to read bitmap block");
+		return -EIO;
+	}
+	bmap = bmap_bh->b_data;
+	if (!ci->ci_bitmap_addr) {
+		memset(bmap, 0, sb->s_blocksize);
+		old_bmap = false;
+	}
+
+	/* Write the bitmap to its location for the next transaction */
+	if (old_bmap) {
+		struct buffer_head *new_bmap_bh;
+		u64 new_bmap_bno;
+
+		new_bmap_bno = apfs_ip_find_free(sb);
+		if (!new_bmap_bno) {
+			apfs_err(sb, "no free blocks in ip");
+			err = -EFSCORRUPTED;
+			goto fail;
+		}
+
+		new_bmap_bh = apfs_getblk(sb, new_bmap_bno);
+		if (!new_bmap_bh) {
+			apfs_err(sb, "failed to map new bmap block (0x%llx)", new_bmap_bno);
+			err = -EIO;
+			goto fail;
+		}
+		memcpy(new_bmap_bh->b_data, bmap, sb->s_blocksize);
+		err = apfs_free_queue_insert(sb, bmap_bh->b_blocknr, 1);
+		brelse(bmap_bh);
+		bmap_bh = new_bmap_bh;
+		if (err) {
+			apfs_err(sb, "free queue insertion failed");
+			goto fail;
+		}
+		bmap = bmap_bh->b_data;
+	}
+	apfs_ip_mark_used(sb, bmap_bh->b_blocknr);
+
+	/* Write the cib to its location for the next transaction */
+	if (old_cib) {
+		struct buffer_head *new_cib_bh;
+		u64 new_cib_bno;
+
+		new_cib_bno = apfs_ip_find_free(sb);
+		if (!new_cib_bno) {
+			apfs_err(sb, "no free blocks in ip");
+			err = -EFSCORRUPTED;
+			goto fail;
+		}
+
+		new_cib_bh = apfs_getblk(sb, new_cib_bno);
+		if (!new_cib_bh) {
+			apfs_err(sb, "failed to map new cib block (0x%llx)", new_cib_bno);
+			err = -EIO;
+			goto fail;
+		}
+		memcpy(new_cib_bh->b_data, (*cib_bh)->b_data, sb->s_blocksize);
+		err = apfs_free_queue_insert(sb, (*cib_bh)->b_blocknr, 1);
+		brelse(*cib_bh);
+		*cib_bh = new_cib_bh;
+		if (err) {
+			apfs_err(sb, "free queue insertion failed");
+			goto fail;
+		}
+
+		err = apfs_transaction_join(sb, *cib_bh);
+		if (err)
+			goto fail;
+
+		cib = (struct apfs_chunk_info_block *)(*cib_bh)->b_data;
+		ci = &cib->cib_chunk_info[index];
+		cib->cib_o.o_oid = cpu_to_le64(new_cib_bno);
+		cib->cib_o.o_xid = cpu_to_le64(nxi->nx_xid);
+
+		apfs_ip_mark_used(sb, new_cib_bno);
+	}
+
+	/* The chunk info can be updated now */
+	apfs_assert_in_transaction(sb, &cib->cib_o);
+	ci->ci_xid = cpu_to_le64(nxi->nx_xid);
+	le32_add_cpu(&ci->ci_free_count, is_alloc ? -1 : 1);
+	ci->ci_bitmap_addr = cpu_to_le64(bmap_bh->b_blocknr);
+	ASSERT(buffer_trans(*cib_bh));
+	set_buffer_csum(*cib_bh);
+
+	/* Finally, allocate / free the actual block that was requested */
+	if (is_alloc) {
+		*bno = apfs_chunk_find_free(sb, bmap, le64_to_cpu(ci->ci_addr));
+		if (!*bno) {
+			apfs_err(sb, "no free blocks in chunk");
+			err = -EFSCORRUPTED;
+			goto fail;
+		}
+		apfs_chunk_mark_used(sb, bmap, *bno);
+		sm->sm_free_count -= 1;
+	} else {
+		if (!apfs_chunk_mark_free(sb, bmap, *bno)) {
+			apfs_err(sb, "block already marked as free (0x%llx)", *bno);
+			le32_add_cpu(&ci->ci_free_count, -1);
+			set_buffer_csum(*cib_bh);
+			err = -EFSCORRUPTED;
+		} else
+			sm->sm_free_count += 1;
+	}
+	mark_buffer_dirty(bmap_bh);
+
+fail:
+	brelse(bmap_bh);
+	return err;
+}
+
+/**
+ * apfs_chunk_allocate_block - Allocate a single block from a chunk
+ * @sb:		superblock structure
+ * @cib_bh:	buffer head for the chunk-info block
+ * @index:	index of this chunk's info structure inside @cib
+ * @bno:	on return, the allocated block number
+ *
+ * Finds a free block in the chunk and marks it as used; the buffer at @cib_bh
+ * may be replaced if needed for copy-on-write.  Returns 0 on success, or a
+ * negative error code in case of failure.
+ */
+static int apfs_chunk_allocate_block(struct super_block *sb,
+				     struct buffer_head **cib_bh,
+				     int index, u64 *bno)
+{
+	return apfs_chunk_alloc_free(sb, cib_bh, index, bno, true);
+}
+
+/**
+ * apfs_cib_allocate_block - Allocate a single block from a cib
+ * @sb:		superblock structure
+ * @cib_bh:	buffer head for the chunk-info block
+ * @bno:	on return, the allocated block number
+ * @backwards:	start the search on the last chunk
+ *
+ * Finds a free block among all the chunks in the cib and marks it as used; the
+ * buffer at @cib_bh may be replaced if needed for copy-on-write.  Returns 0 on
+ * success, or a negative error code in case of failure.
+ */
+static int apfs_cib_allocate_block(struct super_block *sb,
+				   struct buffer_head **cib_bh, u64 *bno, bool backwards)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_spaceman *sm = APFS_SM(sb);
+	struct apfs_chunk_info_block *cib;
+	u32 chunk_count;
+	int i;
+
+	cib = (struct apfs_chunk_info_block *)(*cib_bh)->b_data;
+	if (nxi->nx_flags & APFS_CHECK_NODES && !apfs_obj_verify_csum(sb, *cib_bh)) {
+		apfs_err(sb, "bad checksum for chunk-info block");
+		return -EFSBADCRC;
+	}
+
+	/* Avoid out-of-bounds operations on corrupted cibs */
+	chunk_count = le32_to_cpu(cib->cib_chunk_info_count);
+	if (chunk_count > sm->sm_chunks_per_cib) {
+		apfs_err(sb, "too many chunks in cib (%u)", chunk_count);
+		return -EFSCORRUPTED;
+	}
+
+	for (i = 0; i < chunk_count; ++i) {
+		int index;
+		int err;
+
+		index = backwards ? chunk_count - 1 - i : i;
+
+		err = apfs_chunk_allocate_block(sb, cib_bh, index, bno);
+		if (err == -ENOSPC) /* This chunk is full */
+			continue;
+		if (err)
+			apfs_err(sb, "error during allocation");
+		return err;
+	}
+	return -ENOSPC;
+}
+
+/**
+ * apfs_spaceman_allocate_block - Allocate a single on-disk block
+ * @sb:		superblock structure
+ * @bno:	on return, the allocated block number
+ * @backwards:	start the search on the last chunk
+ *
+ * Finds a free block among the spaceman bitmaps and marks it as used.  Returns
+ * 0 on success, or a negative error code in case of failure.
+ */
+int apfs_spaceman_allocate_block(struct super_block *sb, u64 *bno, bool backwards)
+{
+	struct apfs_spaceman *sm = APFS_SM(sb);
+	int i;
+
+	for (i = 0; i < sm->sm_cib_count; ++i) {
+		struct buffer_head *cib_bh;
+		u64 cib_bno;
+		int index;
+		int err;
+
+		/* Keep extents and metadata separate to limit fragmentation */
+		index = backwards ? sm->sm_cib_count - 1 - i : i;
+
+		cib_bno = apfs_spaceman_read_cib_addr(sb, index);
+		cib_bh = apfs_sb_bread(sb, cib_bno);
+		if (!cib_bh) {
+			apfs_err(sb, "failed to read cib");
+			return -EIO;
+		}
+
+		err = apfs_cib_allocate_block(sb, &cib_bh, bno, backwards);
+		if (!err) {
+			/* The cib may have been moved */
+			apfs_spaceman_write_cib_addr(sb, index, cib_bh->b_blocknr);
+			/* The free block count has changed */
+			apfs_write_spaceman(sm);
+		}
+		brelse(cib_bh);
+		if (err == -ENOSPC) /* This cib is full */
+			continue;
+		if (err)
+			apfs_err(sb, "error during allocation");
+		return err;
+	}
+	return -ENOSPC;
+}
+
+/**
+ * apfs_chunk_free - Mark a regular block as free given CIB and chunk
+ * @sb:		superblock structure
+ * @cib_bh:	buffer head for the chunk-info block
+ * @index:	index of this chunk's info structure inside @cib
+ * @bno:	block number (must not belong to the ip)
+ */
+static int apfs_chunk_free(struct super_block *sb,
+				struct buffer_head **cib_bh,
+				int index, u64 bno)
+{
+	return apfs_chunk_alloc_free(sb, cib_bh, index, &bno, false);
+}
+
+/**
+ * apfs_main_free - Mark a regular block as free
+ * @sb:		superblock structure
+ * @bno:	block number (must not belong to the ip)
+ */
+static int apfs_main_free(struct super_block *sb, u64 bno)
+{
+	struct apfs_spaceman *sm = APFS_SM(sb);
+	struct apfs_spaceman_phys *sm_raw = sm->sm_raw;
+	u64 cib_idx, chunk_idx;
+	struct buffer_head *cib_bh;
+	u64 cib_bno;
+	int err;
+
+	if (!sm_raw->sm_blocks_per_chunk || !sm_raw->sm_chunks_per_cib) {
+		apfs_err(sb, "block or chunk count not set");
+		return -EINVAL;
+	}
+	/* TODO: use bitshifts instead of do_div() */
+	chunk_idx = bno;
+	do_div(chunk_idx, sm->sm_blocks_per_chunk);
+	cib_idx = chunk_idx;
+	chunk_idx = do_div(cib_idx, sm->sm_chunks_per_cib);
+
+	cib_bno = apfs_spaceman_read_cib_addr(sb, cib_idx);
+	cib_bh = apfs_sb_bread(sb, cib_bno);
+	if (!cib_bh) {
+		apfs_err(sb, "failed to read cib");
+		return -EIO;
+	}
+
+	err = apfs_chunk_free(sb, &cib_bh, chunk_idx, bno);
+	if (!err) {
+		/* The cib may have been moved */
+		apfs_spaceman_write_cib_addr(sb, cib_idx, cib_bh->b_blocknr);
+		/* The free block count has changed */
+		apfs_write_spaceman(sm);
+	}
+	brelse(cib_bh);
+	if (err)
+		apfs_err(sb, "error during free");
+
+	return err;
+}
diff --git a/drivers/staging/apfs/super.c b/drivers/staging/apfs/super.c
new file mode 100644
index 0000000000000000000000000000000000000000..8c351bdf404660f3782cd68b052f5a5ef217985d
--- /dev/null
+++ b/drivers/staging/apfs/super.c
@@ -0,0 +1,2099 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2018 Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
+ * Copyright (C) 2025 Ethan Carter Edwards <ethan@ethancedwards.com>
+ */
+
+#include <linux/backing-dev.h>
+#include <linux/blkdev.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/magic.h>
+#include <linux/slab.h>
+#include <linux/parser.h>
+#include <linux/buffer_head.h>
+#include <linux/statfs.h>
+#include <linux/seq_file.h>
+#include "apfs.h"
+
+// FIXME: decide how to handle this
+#define APFS_MODULE_ID_STRING	"linux-apfs by Ernesto Fernandez and Ethan Carter Edwards"
+
+#include <linux/iversion.h>
+
+/* Keep a list of mounted containers, so that their volumes can share them */
+static LIST_HEAD(nxs);
+/*
+ * The main purpose of this mutex is to protect the list of containers and
+ * their reference counts, but it also has other uses during mounts/unmounts:
+ *   - it prevents new mounts from starting while an unmount is updating the
+ *     backup superblock (apfs_attach_nxi vs apfs_make_super_copy)
+ *   - it prevents a new container superblock read from starting while another
+ *     is taking place, which could cause leaks and other issues if both
+ *     containers are the same (apfs_read_main_super vs itself)
+ *   - it protects the list of volumes for each container, and keeps it
+ *     consistent with the reference count
+ *   - it prevents two different snapshots for a single volume from trying to
+ *     do the first read of their shared omap at the same time
+ *     (apfs_first_read_omap vs itself)
+ *   - it protects the reference count for that shared omap, keeping it
+ *     consistent with the number of volumes that are set with that omap
+ *   - it protects the container mount flags, so that they can only be set by
+ *     the first volume mount to attempt it (apfs_set_nx_flags vs itself)
+ */
+DEFINE_MUTEX(nxs_mutex);
+
+/**
+ * apfs_nx_find_by_dev - Search for a device in the list of mounted containers
+ * @dev:	device number of block device for the wanted container
+ *
+ * Returns a pointer to the container structure in the list, or NULL if the
+ * container isn't currently mounted.
+ */
+static struct apfs_nxsb_info *apfs_nx_find_by_dev(dev_t dev)
+{
+	struct apfs_nxsb_info *curr;
+
+	lockdep_assert_held(&nxs_mutex);
+	list_for_each_entry(curr, &nxs, nx_list) {
+		struct block_device *curr_bdev = curr->nx_blkdev_info->blki_bdev;
+
+		if (curr_bdev->bd_dev == dev)
+			return curr;
+	}
+	return NULL;
+}
+
+/**
+ * apfs_blkdev_set_blocksize - Set the blocksize for a block device
+ * @info:	info struct for the block device
+ * @size:	size to set
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+static int apfs_blkdev_set_blocksize(struct apfs_blkdev_info *info, int size)
+{
+	return set_blocksize(info->blki_bdev_file, size);
+}
+
+/**
+ * apfs_sb_set_blocksize - Set the block size for the container's device
+ * @sb:		superblock structure
+ * @size:	size to set
+ *
+ * This is like sb_set_blocksize(), but it uses the container's device instead
+ * of the nonexistent volume device.
+ */
+static int apfs_sb_set_blocksize(struct super_block *sb, int size)
+{
+	if (apfs_blkdev_set_blocksize(APFS_NXI(sb)->nx_blkdev_info, size))
+		return 0;
+	sb->s_blocksize = size;
+	sb->s_blocksize_bits = blksize_bits(size);
+	return sb->s_blocksize;
+}
+
+/**
+ * apfs_read_super_copy - Read the copy of the container superblock in block 0
+ * @sb: superblock structure
+ *
+ * Returns a pointer to the buffer head, or an error pointer in case of failure.
+ */
+static struct buffer_head *apfs_read_super_copy(struct super_block *sb)
+{
+	struct buffer_head *bh;
+	struct apfs_nx_superblock *msb_raw;
+	int blocksize;
+	int err = -EINVAL;
+
+	/*
+	 * For now assume a small blocksize, we only need it so that we can
+	 * read the actual blocksize from disk.
+	 */
+	if (!apfs_sb_set_blocksize(sb, APFS_NX_DEFAULT_BLOCK_SIZE)) {
+		apfs_err(sb, "unable to set blocksize");
+		return ERR_PTR(err);
+	}
+	bh = apfs_sb_bread(sb, APFS_NX_BLOCK_NUM);
+	if (!bh) {
+		apfs_err(sb, "unable to read superblock");
+		return ERR_PTR(err);
+	}
+	msb_raw = (struct apfs_nx_superblock *)bh->b_data;
+	blocksize = le32_to_cpu(msb_raw->nx_block_size);
+
+	sb->s_magic = le32_to_cpu(msb_raw->nx_magic);
+	if (sb->s_magic != APFS_NX_MAGIC) {
+		apfs_warn(sb, "not an apfs container - are you mounting the right partition?");
+		goto fail;
+	}
+
+	if (sb->s_blocksize != blocksize) {
+		brelse(bh);
+
+		if (!apfs_sb_set_blocksize(sb, blocksize)) {
+			apfs_err(sb, "bad blocksize %d", blocksize);
+			return ERR_PTR(err);
+		}
+		bh = apfs_sb_bread(sb, APFS_NX_BLOCK_NUM);
+		if (!bh) {
+			apfs_err(sb, "unable to read superblock 2nd time");
+			return ERR_PTR(err);
+		}
+		msb_raw = (struct apfs_nx_superblock *)bh->b_data;
+	}
+
+	if (!apfs_obj_verify_csum(sb, bh))
+		apfs_notice(sb, "backup superblock seems corrupted");
+	return bh;
+
+fail:
+	brelse(bh);
+	return ERR_PTR(err);
+}
+
+/**
+ * apfs_make_super_copy - Write a copy of the checkpoint superblock to block 0
+ * @sb:	superblock structure
+ */
+static void apfs_make_super_copy(struct super_block *sb)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_nxsb_info *nxi = sbi->s_nxi;
+	struct buffer_head *bh;
+
+	if (!(nxi->nx_flags & APFS_READWRITE))
+		return;
+
+	/*
+	 * Only update the backup when the last volume is getting unmounted.
+	 * Of course a new mounter could still come along before we actually
+	 * release the nxi.
+	 */
+	mutex_lock(&nxs_mutex);
+	if (nxi->nx_refcnt > 1)
+		goto out_unlock;
+
+	bh = apfs_sb_bread(sb, APFS_NX_BLOCK_NUM);
+	if (!bh) {
+		apfs_err(sb, "failed to write block zero");
+		goto out_unlock;
+	}
+	memcpy(bh->b_data, nxi->nx_raw, sb->s_blocksize);
+	mark_buffer_dirty(bh);
+	brelse(bh);
+out_unlock:
+	mutex_unlock(&nxs_mutex);
+}
+
+static int apfs_check_nx_features(struct super_block *sb);
+static void apfs_set_trans_buffer_limit(struct super_block *sb);
+
+/**
+ * apfs_check_fusion_uuid - Verify that the main and tier 2 devices match
+ * @sb: filesystem superblock
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+static int apfs_check_fusion_uuid(struct super_block *sb)
+{
+	struct apfs_nxsb_info *nxi = NULL;
+	struct apfs_nx_superblock *main_raw = NULL, *tier2_raw = NULL;
+	uuid_t main_uuid, tier2_uuid;
+	struct buffer_head *bh = NULL;
+
+	nxi = APFS_NXI(sb);
+	main_raw = nxi->nx_raw;
+	if (!main_raw) {
+		apfs_alert(sb, "fusion uuid checks are misplaced");
+		return -EINVAL;
+	}
+	import_uuid(&main_uuid, main_raw->nx_fusion_uuid);
+	main_raw = NULL;
+
+	if (!nxi->nx_tier2_info) {
+		/* Not a fusion drive */
+		if (!uuid_is_null(&main_uuid)) {
+			apfs_err(sb, "fusion uuid on a regular drive");
+			return -EFSCORRUPTED;
+		}
+		return 0;
+	}
+	if (uuid_is_null(&main_uuid)) {
+		apfs_err(sb, "no fusion uuid on fusion drive");
+		return -EFSCORRUPTED;
+	}
+
+	/* Tier 2 also has a copy of the superblock in block zero */
+	bh = apfs_sb_bread(sb, nxi->nx_tier2_bno);
+	if (IS_ERR(bh))
+		return PTR_ERR(bh);
+	tier2_raw = (struct apfs_nx_superblock *)bh->b_data;
+	import_uuid(&tier2_uuid, tier2_raw->nx_fusion_uuid);
+	brelse(bh);
+	bh = NULL;
+	tier2_raw = NULL;
+
+	/*
+	 * The only difference between both superblocks (other than the
+	 * checksum) is this one bit here, so it can be used to tell which is
+	 * main and which is tier 2. By the way, the reference seems to have
+	 * this backwards.
+	 */
+	if (main_uuid.b[15] & 0x01) {
+		apfs_warn(sb, "bad bit on main device - are you mixing up main and tier 2?");
+		return -EINVAL;
+	}
+	if (!(tier2_uuid.b[15] & 0x01)) {
+		apfs_warn(sb, "bad bit on tier 2 device - are you mixing up main and tier 2?");
+		return -EINVAL;
+	}
+	tier2_uuid.b[15] &= ~0x01;
+	if (!uuid_equal(&main_uuid, &tier2_uuid)) {
+		apfs_warn(sb, "the devices are not part of the same fusion drive");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/**
+ * apfs_read_main_super - Find the container superblock and read it into memory
+ * @sb:	superblock structure
+ *
+ * Returns a negative error code in case of failure.  On success, returns 0
+ * and sets the nx_raw and nx_xid fields of APFS_NXI(@sb).
+ */
+static int apfs_read_main_super(struct super_block *sb)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct buffer_head *bh = NULL;
+	struct buffer_head *desc_bh = NULL;
+	struct apfs_nx_superblock *msb_raw;
+	u64 xid, bno = APFS_NX_BLOCK_NUM;
+	u64 desc_base;
+	u32 desc_blocks;
+	int err = -EINVAL;
+	int i;
+
+	mutex_lock(&nxs_mutex);
+
+	if (nxi->nx_blocksize) {
+		/* It's already mapped */
+		sb->s_blocksize = nxi->nx_blocksize;
+		sb->s_blocksize_bits = nxi->nx_blocksize_bits;
+		sb->s_magic = le32_to_cpu(nxi->nx_raw->nx_magic);
+		err = 0;
+		goto out;
+	}
+
+	/*
+	 * We won't know the block size until we read the backup superblock,
+	 * so we can't set this up correctly yet. But we do know that the
+	 * backup superblock itself is always in the main device.
+	 */
+	nxi->nx_tier2_bno = APFS_NX_BLOCK_NUM + 1;
+
+	/* Read the superblock from the last clean unmount */
+	bh = apfs_read_super_copy(sb);
+	if (IS_ERR(bh)) {
+		err = PTR_ERR(bh);
+		bh = NULL;
+		goto out;
+	}
+	msb_raw = (struct apfs_nx_superblock *)bh->b_data;
+
+	/*
+	 * Now that we confirmed the block size, we can set this up for real.
+	 * It's important to do this early because I don't know which mount
+	 * objects could get moved to tier 2.
+	 */
+	nxi->nx_tier2_bno = APFS_FUSION_TIER2_DEVICE_BYTE_ADDR >> sb->s_blocksize_bits;
+
+	/* We want to mount the latest valid checkpoint among the descriptors */
+	desc_base = le64_to_cpu(msb_raw->nx_xp_desc_base);
+	if (desc_base >> 63 != 0) {
+		/* The highest bit is set when checkpoints are not contiguous */
+		apfs_err(sb, "checkpoint descriptor tree not yet supported");
+		goto out;
+	}
+	desc_blocks = le32_to_cpu(msb_raw->nx_xp_desc_blocks);
+	if (desc_blocks > 10000) { /* Arbitrary loop limit, is it enough? */
+		apfs_err(sb, "too many checkpoint descriptors?");
+		err = -EFSCORRUPTED;
+		goto out;
+	}
+
+	/* Now we go through the checkpoints one by one */
+	xid = le64_to_cpu(msb_raw->nx_o.o_xid);
+	for (i = 0; i < desc_blocks; ++i) {
+		struct apfs_nx_superblock *desc_raw;
+
+		brelse(desc_bh);
+		desc_bh = apfs_sb_bread(sb, desc_base + i);
+		if (!desc_bh) {
+			apfs_err(sb, "unable to read checkpoint descriptor");
+			goto out;
+		}
+		desc_raw = (struct apfs_nx_superblock *)desc_bh->b_data;
+
+		if (le32_to_cpu(desc_raw->nx_magic) != APFS_NX_MAGIC)
+			continue; /* Not a superblock */
+		if (le64_to_cpu(desc_raw->nx_o.o_xid) <= xid)
+			continue; /* Old */
+		if (!apfs_obj_verify_csum(sb, desc_bh))
+			continue; /* Corrupted */
+
+		xid = le64_to_cpu(desc_raw->nx_o.o_xid);
+		msb_raw = desc_raw;
+		bno = desc_base + i;
+		brelse(bh);
+		bh = desc_bh;
+		desc_bh = NULL;
+	}
+
+	nxi->nx_raw = kmalloc(sb->s_blocksize, GFP_KERNEL);
+	if (!nxi->nx_raw) {
+		err = -ENOMEM;
+		goto out;
+	}
+	memcpy(nxi->nx_raw, bh->b_data, sb->s_blocksize);
+	nxi->nx_bno = bno;
+	nxi->nx_xid = xid;
+
+	/* For now we only support blocksize < PAGE_SIZE */
+	nxi->nx_blocksize = sb->s_blocksize;
+	nxi->nx_blocksize_bits = sb->s_blocksize_bits;
+	apfs_set_trans_buffer_limit(sb);
+
+	err = apfs_check_nx_features(sb);
+	if (err)
+		goto out;
+
+	/*
+	 * This check is technically too late: if main and tier 2 are backwards
+	 * then we have already attempted (and failed) to read the checkpoint
+	 * from tier 2. This may lead to a confusing error message if tier 2
+	 * is absurdly tiny, not a big deal.
+	 */
+	err = apfs_check_fusion_uuid(sb);
+	if (err)
+		goto out;
+
+out:
+	brelse(bh);
+	mutex_unlock(&nxs_mutex);
+	return err;
+}
+
+/**
+ * apfs_update_software_info - Write the module info to a modified volume
+ * @sb: superblock structure
+ *
+ * Writes this module's information to index zero of the apfs_modified_by
+ * array, shifting the rest of the entries to the right.
+ */
+static void apfs_update_software_info(struct super_block *sb)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_superblock *raw = sbi->s_vsb_raw;
+	struct apfs_modified_by *mod_by;
+
+	ASSERT(sbi->s_vsb_raw);
+	apfs_assert_in_transaction(sb, &raw->apfs_o);
+	ASSERT(strlen(APFS_MODULE_ID_STRING) < APFS_MODIFIED_NAMELEN);
+	mod_by = raw->apfs_modified_by;
+
+	memmove(mod_by + 1, mod_by, (APFS_MAX_HIST - 1) * sizeof(*mod_by));
+	memset(mod_by->id, 0, sizeof(mod_by->id));
+	strscpy(mod_by->id, APFS_MODULE_ID_STRING, sizeof(mod_by->id));
+	mod_by->timestamp = cpu_to_le64(ktime_get_real_ns());
+	mod_by->last_xid = cpu_to_le64(APFS_NXI(sb)->nx_xid);
+}
+
+static struct file_system_type apfs_fs_type;
+
+/**
+ * apfs_blkdev_cleanup - Clean up after a block device
+ * @info:	info struct to clean up
+ */
+static void apfs_blkdev_cleanup(struct apfs_blkdev_info *info)
+{
+	if (!info)
+		return;
+
+	fput(info->blki_bdev_file);
+	info->blki_bdev_file = NULL;
+	info->blki_bdev = NULL;
+
+	kfree(info->blki_path);
+	info->blki_path = NULL;
+	kfree(info);
+}
+
+/**
+ * apfs_free_main_super - Clean up apfs_read_main_super()
+ * @sbi:	in-memory superblock info
+ *
+ * It also cleans up after apfs_attach_nxi(), so the name is no longer accurate.
+ */
+static inline void apfs_free_main_super(struct apfs_sb_info *sbi)
+{
+	struct apfs_nxsb_info *nxi = sbi->s_nxi;
+	struct apfs_ephemeral_object_info *eph_list = NULL;
+	struct apfs_spaceman *sm = NULL;
+	u32 bmap_idx;
+	int i;
+
+	mutex_lock(&nxs_mutex);
+
+	list_del(&sbi->list);
+	if (--nxi->nx_refcnt)
+		goto out;
+
+	/* Clean up all the ephemeral objects in memory */
+	eph_list = nxi->nx_eph_list;
+	if (eph_list) {
+		for (i = 0; i < nxi->nx_eph_count; ++i) {
+			kfree(eph_list[i].object);
+			eph_list[i].object = NULL;
+		}
+		kfree(eph_list);
+		eph_list = nxi->nx_eph_list = NULL;
+		nxi->nx_eph_count = 0;
+	}
+
+	kfree(nxi->nx_raw);
+	nxi->nx_raw = NULL;
+
+	apfs_blkdev_cleanup(nxi->nx_blkdev_info);
+	nxi->nx_blkdev_info = NULL;
+	apfs_blkdev_cleanup(nxi->nx_tier2_info);
+	nxi->nx_tier2_info = NULL;
+
+	list_del(&nxi->nx_list);
+	sm = nxi->nx_spaceman;
+	if (sm) {
+		for (bmap_idx = 0; bmap_idx < sm->sm_ip_bmaps_count; ++bmap_idx) {
+			kfree(sm->sm_ip_bmaps[bmap_idx].block);
+			sm->sm_ip_bmaps[bmap_idx].block = NULL;
+		}
+		kfree(sm);
+		nxi->nx_spaceman = sm = NULL;
+	}
+	kfree(nxi);
+out:
+	sbi->s_nxi = NULL;
+	mutex_unlock(&nxs_mutex);
+}
+
+/**
+ * apfs_map_volume_super_bno - Map a block containing a volume superblock
+ * @sb:		superblock structure
+ * @bno:	block to map
+ * @check:	verify the checksum?
+ */
+int apfs_map_volume_super_bno(struct super_block *sb, u64 bno, bool check)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_superblock *vsb_raw = NULL;
+	struct buffer_head *bh = NULL;
+	int err;
+
+	bh = apfs_sb_bread(sb, bno);
+	if (!bh) {
+		apfs_err(sb, "unable to read volume superblock");
+		return -EINVAL;
+	}
+
+	vsb_raw = (struct apfs_superblock *)bh->b_data;
+	if (le32_to_cpu(vsb_raw->apfs_magic) != APFS_MAGIC) {
+		apfs_err(sb, "wrong magic in volume superblock");
+		err = -EINVAL;
+		goto fail;
+	}
+
+	/*
+	 * XXX: apfs_omap_lookup_block() only runs this check when write
+	 * is true, but it should always do it.
+	 */
+	if (check && !apfs_obj_verify_csum(sb, bh)) {
+		apfs_err(sb, "inconsistent volume superblock");
+		err = -EFSBADCRC;
+		goto fail;
+	}
+
+	sbi->s_vsb_raw = vsb_raw;
+	sbi->s_vobject.sb = sb;
+	sbi->s_vobject.block_nr = bno;
+	sbi->s_vobject.oid = le64_to_cpu(vsb_raw->apfs_o.o_oid);
+	brelse(sbi->s_vobject.o_bh);
+	sbi->s_vobject.o_bh = bh;
+	sbi->s_vobject.data = bh->b_data;
+	return 0;
+
+fail:
+	brelse(bh);
+	return err;
+}
+
+/**
+ * apfs_alloc_omap - Allocate and initialize an object map struct
+ *
+ * Returns the struct, or NULL in case of allocation failure.
+ */
+static struct apfs_omap *apfs_alloc_omap(void)
+{
+	struct apfs_omap *omap = NULL;
+	struct apfs_omap_cache *cache = NULL;
+
+	omap = kzalloc(sizeof(*omap), GFP_KERNEL);
+	if (!omap)
+		return NULL;
+	cache = &omap->omap_cache;
+	spin_lock_init(&cache->lock);
+	return omap;
+}
+
+/**
+ * apfs_map_volume_super - Find the volume superblock and map it into memory
+ * @sb:		superblock structure
+ * @write:	request write access?
+ *
+ * Returns a negative error code in case of failure.  On success, returns 0
+ * and sets APFS_SB(@sb)->s_vsb_raw and APFS_SB(@sb)->s_vobject.
+ */
+int apfs_map_volume_super(struct super_block *sb, bool write)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_nx_superblock *msb_raw = nxi->nx_raw;
+	struct apfs_omap_phys *msb_omap_raw;
+	struct apfs_omap *omap = NULL;
+	struct apfs_node *vnode;
+	struct buffer_head *bh;
+	u64 vol_id;
+	u64 vsb;
+	int err;
+
+	ASSERT(msb_raw);
+
+	/* Get the id for the requested volume number */
+	if (sbi->s_vol_nr >= APFS_NX_MAX_FILE_SYSTEMS) {
+		apfs_err(sb, "volume number out of range");
+		return -EINVAL;
+	}
+	vol_id = le64_to_cpu(msb_raw->nx_fs_oid[sbi->s_vol_nr]);
+	if (vol_id == 0) {
+		apfs_err(sb, "requested volume does not exist");
+		return -EINVAL;
+	}
+
+	/* Get the container's object map */
+	bh = apfs_read_object_block(sb, le64_to_cpu(msb_raw->nx_omap_oid),
+				    write, false /* preserve */);
+	if (IS_ERR(bh)) {
+		apfs_err(sb, "unable to read container object map");
+		return PTR_ERR(bh);
+	}
+	if (write) {
+		ASSERT(buffer_trans(bh));
+		msb_raw->nx_omap_oid = cpu_to_le64(bh->b_blocknr);
+	}
+	msb_omap_raw = (struct apfs_omap_phys *)bh->b_data;
+
+	/* Get the root node for the container's omap */
+	vnode = apfs_read_node(sb, le64_to_cpu(msb_omap_raw->om_tree_oid),
+			       APFS_OBJ_PHYSICAL, write);
+	if (IS_ERR(vnode)) {
+		apfs_err(sb, "unable to read volume block");
+		err = PTR_ERR(vnode);
+		goto fail;
+	}
+	if (write) {
+		ASSERT(buffer_trans(bh));
+		msb_omap_raw->om_tree_oid = cpu_to_le64(vnode->object.block_nr);
+	}
+	msb_omap_raw = NULL;
+	brelse(bh);
+	bh = NULL;
+
+	omap = apfs_alloc_omap();
+	if (!omap) {
+		apfs_node_free(vnode);
+		return -ENOMEM;
+	}
+	omap->omap_root = vnode;
+
+	err = apfs_omap_lookup_block(sb, omap, vol_id, &vsb, write);
+	apfs_node_free(vnode);
+	vnode = NULL;
+	kfree(omap);
+	omap = NULL;
+	if (err) {
+		apfs_err(sb, "volume not found, likely corruption");
+		return err;
+	}
+
+	/*
+	 * Snapshots could get mounted during a transaction, so the fletcher
+	 * checksum doesn't have to be valid.
+	 */
+	return apfs_map_volume_super_bno(sb, vsb, !write && !sbi->s_snap_name);
+
+fail:
+	brelse(bh);
+	return err;
+}
+
+/**
+ * apfs_unmap_volume_super - Clean up apfs_map_volume_super()
+ * @sb:	filesystem superblock
+ */
+void apfs_unmap_volume_super(struct super_block *sb)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_object *obj = &sbi->s_vobject;
+
+	obj->data = NULL;
+	brelse(obj->o_bh);
+	obj->o_bh = NULL;
+}
+
+/**
+ * apfs_get_omap - Get a reference to the omap, if it's already read
+ * @sb:	filesystem superblock
+ *
+ * Returns the omap struct, or NULL on failure.
+ */
+static struct apfs_omap *apfs_get_omap(struct super_block *sb)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_sb_info *curr = NULL;
+	struct apfs_omap *omap = NULL;
+	struct apfs_omap_cache *cache = NULL;
+
+	lockdep_assert_held(&nxs_mutex);
+
+	list_for_each_entry(curr, &nxi->vol_list, list) {
+		if (curr == sbi)
+			continue;
+		if (curr->s_vol_nr == sbi->s_vol_nr) {
+			omap = curr->s_omap;
+			if (!omap) {
+				/*
+				 * This volume has already gone through
+				 * apfs_attach_nxi(), but its omap is either
+				 * not yet read or already put.
+				 */
+				continue;
+			}
+			cache = &omap->omap_cache;
+			++omap->omap_refcnt;
+			/* Right now the cache can't be shared like this */
+			cache->disabled = true;
+			return omap;
+		}
+	}
+	return NULL;
+}
+
+/**
+ * apfs_read_omap - Find and read the omap root node
+ * @sb:		superblock structure
+ * @write:	request write access?
+ *
+ * On success, returns 0 and sets the fields of APFS_SB(@sb)->s_omap; on failure
+ * returns a negative error code.
+ */
+int apfs_read_omap(struct super_block *sb, bool write)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_superblock *vsb_raw = sbi->s_vsb_raw;
+	struct apfs_omap_phys *omap_raw;
+	struct apfs_node *omap_root;
+	struct apfs_omap *omap = NULL;
+	struct buffer_head *bh;
+	u64 omap_blk;
+	int err;
+
+	ASSERT(sbi->s_vsb_raw);
+
+	ASSERT(sbi->s_omap);
+	omap = sbi->s_omap;
+
+	/* Get the block holding the volume omap information */
+	omap_blk = le64_to_cpu(vsb_raw->apfs_omap_oid);
+	bh = apfs_read_object_block(sb, omap_blk, write, false /* preserve */);
+	if (IS_ERR(bh)) {
+		apfs_err(sb, "unable to read the volume object map");
+		return PTR_ERR(bh);
+	}
+	if (write) {
+		apfs_assert_in_transaction(sb, &vsb_raw->apfs_o);
+		vsb_raw->apfs_omap_oid = cpu_to_le64(bh->b_blocknr);
+	}
+	omap_raw = (struct apfs_omap_phys *)bh->b_data;
+
+	/* Get the volume's object map */
+	omap_root = apfs_read_node(sb, le64_to_cpu(omap_raw->om_tree_oid),
+				   APFS_OBJ_PHYSICAL, write);
+	if (IS_ERR(omap_root)) {
+		apfs_err(sb, "unable to read the omap root node");
+		err = PTR_ERR(omap_root);
+		goto fail;
+	}
+	if (write) {
+		apfs_assert_in_transaction(sb, &omap_raw->om_o);
+		ASSERT(buffer_trans(bh));
+		omap_raw->om_tree_oid = cpu_to_le64(omap_root->object.block_nr);
+	}
+	omap->omap_latest_snap = le64_to_cpu(omap_raw->om_most_recent_snap);
+	omap_raw = NULL;
+	brelse(bh);
+
+	if (omap->omap_root)
+		apfs_node_free(omap->omap_root);
+	omap->omap_root = omap_root;
+	return 0;
+
+fail:
+	brelse(bh);
+	return err;
+}
+
+/**
+ * apfs_first_read_omap - Find and read the omap root node during mount
+ * @sb:		superblock structure
+ *
+ * On success, returns 0 and sets APFS_SB(@sb)->s_omap; on failure returns a
+ * negative error code.
+ */
+static int apfs_first_read_omap(struct super_block *sb)
+{
+	struct apfs_sb_info *sbi = NULL;
+	struct apfs_omap *omap = NULL;
+	int err;
+
+	/*
+	 * For each volume, the first mount that gets here is responsible
+	 * for reading the omap. Other mounts (for other snapshots) just
+	 * go through the container's volume list to retrieve it. This results
+	 * in coarse locking as usual: with some thought it would be possible
+	 * to allow other volumes to read their own omaps at the same time,
+	 * but I don't see the point.
+	 */
+	mutex_lock(&nxs_mutex);
+
+	sbi = APFS_SB(sb);
+
+	/* The current transaction and all snapshots share a single omap */
+	omap = apfs_get_omap(sb);
+	if (omap) {
+		sbi->s_omap = omap;
+		err = 0;
+		goto out;
+	}
+
+	omap = apfs_alloc_omap();
+	if (!omap) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	sbi->s_omap = omap;
+	err = apfs_read_omap(sb, false /* write */);
+	if (err) {
+		kfree(omap);
+		sbi->s_omap = NULL;
+		goto out;
+	}
+
+	++omap->omap_refcnt;
+	err = 0;
+out:
+	mutex_unlock(&nxs_mutex);
+	return err;
+}
+
+/**
+ * apfs_unset_omap - Unset the object map in a superblock
+ * @sb: superblock structure
+ *
+ * Shrinks the omap reference, frees the omap if needed, and sets the field to
+ * NULL atomically in relation to apfs_first_read_omap(). So, no other mount
+ * can grab a new reference halfway through.
+ */
+static void apfs_unset_omap(struct super_block *sb)
+{
+	struct apfs_omap **omap_p = NULL;
+	struct apfs_omap *omap = NULL;
+
+	omap_p = &APFS_SB(sb)->s_omap;
+	omap = *omap_p;
+	if (!omap)
+		return;
+
+	mutex_lock(&nxs_mutex);
+
+	if (--omap->omap_refcnt != 0)
+		goto out;
+
+	apfs_node_free(omap->omap_root);
+	kfree(omap);
+out:
+	*omap_p = NULL;
+	mutex_unlock(&nxs_mutex);
+}
+
+/**
+ * apfs_read_catalog - Find and read the catalog root node
+ * @sb:		superblock structure
+ * @write:	request write access?
+ *
+ * On success, returns 0 and sets APFS_SB(@sb)->s_cat_root; on failure returns
+ * a negative error code.
+ */
+int apfs_read_catalog(struct super_block *sb, bool write)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_superblock *vsb_raw = sbi->s_vsb_raw;
+	struct apfs_node *root_node;
+
+	ASSERT(sbi->s_omap && sbi->s_omap->omap_root);
+
+	root_node = apfs_read_node(sb, le64_to_cpu(vsb_raw->apfs_root_tree_oid),
+				   APFS_OBJ_VIRTUAL, write);
+	if (IS_ERR(root_node)) {
+		apfs_err(sb, "unable to read catalog root node");
+		return PTR_ERR(root_node);
+	}
+
+	if (sbi->s_cat_root)
+		apfs_node_free(sbi->s_cat_root);
+	sbi->s_cat_root = root_node;
+	return 0;
+}
+
+static void apfs_put_super(struct super_block *sb)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_nx_transaction *trans = NULL;
+
+	/* Cleanups won't reschedule themselves during unmount */
+	flush_work(&sbi->s_orphan_cleanup_work);
+
+	/* We are about to commit anyway */
+	trans = &APFS_NXI(sb)->nx_transaction;
+	cancel_delayed_work_sync(&trans->t_work);
+
+	/* Stop flushing orphans and update the volume as needed */
+	if (!(sb->s_flags & SB_RDONLY)) {
+		struct apfs_superblock *vsb_raw;
+		struct buffer_head *vsb_bh;
+		struct apfs_max_ops maxops = {0};
+		int err;
+
+		err = apfs_transaction_start(sb, maxops);
+		if (err) {
+			apfs_err(sb, "unmount transaction start failed (err:%d)", err);
+			goto fail;
+		}
+		vsb_raw = sbi->s_vsb_raw;
+		vsb_bh = sbi->s_vobject.o_bh;
+
+		apfs_assert_in_transaction(sb, &vsb_raw->apfs_o);
+		ASSERT(buffer_trans(vsb_bh));
+
+		apfs_update_software_info(sb);
+		vsb_raw->apfs_unmount_time = cpu_to_le64(ktime_get_real_ns());
+		set_buffer_csum(vsb_bh);
+
+		/* Guarantee commit */
+		sbi->s_nxi->nx_transaction.t_state |= APFS_NX_TRANS_FORCE_COMMIT;
+		err = apfs_transaction_commit(sb);
+		if (err) {
+			apfs_err(sb, "unmount transaction commit failed (err:%d)", err);
+			apfs_transaction_abort(sb);
+			goto fail;
+		}
+	}
+
+	/*
+	 * Even if this particular volume/snapshot was read-only, the container
+	 * may have changed and need an update here.
+	 */
+	apfs_make_super_copy(sb);
+
+fail:
+	/*
+	 * This is essentially the cleanup for apfs_fill_super(). It goes here
+	 * because generic_shutdown_super() only calls ->put_super() when the
+	 * root dentry has been set, that is, when apfs_fill_super() succeeded.
+	 * The rest of the mount cleanup is done directly by ->kill_sb().
+	 */
+	iput(sbi->s_private_dir);
+	sbi->s_private_dir = NULL;
+	apfs_node_free(sbi->s_cat_root);
+	sbi->s_cat_root = NULL;
+	apfs_unset_omap(sb);
+	apfs_unmap_volume_super(sb);
+}
+
+static struct kmem_cache *apfs_inode_cachep;
+
+static struct inode *apfs_alloc_inode(struct super_block *sb)
+{
+	struct apfs_inode_info *ai;
+	struct apfs_dstream_info *dstream;
+
+	ai = alloc_inode_sb(sb, apfs_inode_cachep, GFP_KERNEL);
+	if (!ai)
+		return NULL;
+	dstream = &ai->i_dstream;
+	inode_set_iversion(&ai->vfs_inode, 1);
+	dstream->ds_sb = sb;
+	dstream->ds_inode = &ai->vfs_inode;
+	dstream->ds_cached_ext.len = 0;
+	dstream->ds_ext_dirty = false;
+	ai->i_nchildren = 0;
+	INIT_LIST_HEAD(&ai->i_list);
+	ai->i_cleaned = false;
+	return &ai->vfs_inode;
+}
+
+static void apfs_i_callback(struct rcu_head *head)
+{
+	struct inode *inode = container_of(head, struct inode, i_rcu);
+
+	kmem_cache_free(apfs_inode_cachep, APFS_I(inode));
+}
+
+static void apfs_destroy_inode(struct inode *inode)
+{
+	call_rcu(&inode->i_rcu, apfs_i_callback);
+}
+
+static void init_once(void *p)
+{
+	struct apfs_inode_info *ai = (struct apfs_inode_info *)p;
+	struct apfs_dstream_info *dstream = &ai->i_dstream;
+
+	spin_lock_init(&dstream->ds_ext_lock);
+	inode_init_once(&ai->vfs_inode);
+}
+
+#define SLAB_MEM_SPREAD	0
+
+static int __init init_inodecache(void)
+{
+	apfs_inode_cachep = kmem_cache_create("apfs_inode_cache",
+					     sizeof(struct apfs_inode_info),
+					     0, (SLAB_RECLAIM_ACCOUNT|
+						SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+					     init_once);
+	if (apfs_inode_cachep == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
+static int apfs_write_inode(struct inode *inode, struct writeback_control *wbc)
+{
+	struct super_block *sb = inode->i_sb;
+	struct apfs_nxsb_info *nxi = APFS_SB(sb)->s_nxi;
+	struct apfs_max_ops maxops;
+	int err;
+
+	maxops.cat = APFS_UPDATE_INODE_MAXOPS();
+	maxops.blks = 0;
+
+	err = apfs_transaction_start(sb, maxops);
+	if (err)
+		return err;
+	err = apfs_update_inode(inode, NULL /* new_name */);
+	if (err)
+		goto fail;
+	/* Don't commit yet, or the inode will get flushed again and lock up */
+	nxi->nx_transaction.t_state |= APFS_NX_TRANS_DEFER_COMMIT;
+	err = apfs_transaction_commit(sb);
+	if (err)
+		goto fail;
+	return 0;
+
+fail:
+	apfs_transaction_abort(sb);
+	return err;
+}
+
+static void destroy_inodecache(void)
+{
+	/*
+	 * Make sure all delayed rcu free inodes are flushed before we
+	 * destroy cache.
+	 */
+	rcu_barrier();
+	kmem_cache_destroy(apfs_inode_cachep);
+}
+
+/**
+ * apfs_count_used_blocks - Count the blocks in use across all volumes
+ * @sb:		filesystem superblock
+ * @count:	on return it will store the block count
+ *
+ * This function probably belongs in a separate file, but for now it is
+ * only called by statfs.
+ */
+static int apfs_count_used_blocks(struct super_block *sb, u64 *count)
+{
+	struct apfs_nx_superblock *msb_raw = APFS_NXI(sb)->nx_raw;
+	struct apfs_node *vnode;
+	struct apfs_omap_phys *msb_omap_raw;
+	struct buffer_head *bh;
+	struct apfs_omap *omap = NULL;
+	u64 msb_omap, vb;
+	int i;
+	int err = 0;
+
+	/* Get the container's object map */
+	msb_omap = le64_to_cpu(msb_raw->nx_omap_oid);
+	bh = apfs_sb_bread(sb, msb_omap);
+	if (!bh) {
+		apfs_err(sb, "unable to read container object map");
+		return -EIO;
+	}
+	msb_omap_raw = (struct apfs_omap_phys *)bh->b_data;
+
+	/* Get the Volume Block */
+	vb = le64_to_cpu(msb_omap_raw->om_tree_oid);
+	msb_omap_raw = NULL;
+	brelse(bh);
+	bh = NULL;
+	vnode = apfs_read_node(sb, vb, APFS_OBJ_PHYSICAL, false /* write */);
+	if (IS_ERR(vnode)) {
+		apfs_err(sb, "unable to read volume block");
+		return PTR_ERR(vnode);
+	}
+
+	omap = apfs_alloc_omap();
+	if (!omap) {
+		err = -ENOMEM;
+		goto fail;
+	}
+	omap->omap_root = vnode;
+
+	/* Iterate through the checkpoint superblocks and add the used blocks */
+	*count = 0;
+	for (i = 0; i < APFS_NX_MAX_FILE_SYSTEMS; i++) {
+		struct apfs_superblock *vsb_raw;
+		u64 vol_id;
+		u64 vol_bno;
+
+		vol_id = le64_to_cpu(msb_raw->nx_fs_oid[i]);
+		if (vol_id == 0) /* All volumes have been checked */
+			break;
+		err = apfs_omap_lookup_newest_block(sb, omap, vol_id, &vol_bno, false /* write */);
+		if (err) {
+			apfs_err(sb, "omap lookup failed for vol id 0x%llx", vol_id);
+			break;
+		}
+
+		bh = apfs_sb_bread(sb, vol_bno);
+		if (!bh) {
+			err = -EIO;
+			apfs_err(sb, "unable to read volume superblock");
+			break;
+		}
+		vsb_raw = (struct apfs_superblock *)bh->b_data;
+		*count += le64_to_cpu(vsb_raw->apfs_fs_alloc_count);
+		brelse(bh);
+	}
+
+fail:
+	kfree(omap);
+	apfs_node_free(vnode);
+	return err;
+}
+
+static int apfs_statfs(struct dentry *dentry, struct kstatfs *buf)
+{
+	struct super_block *sb = dentry->d_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_nx_superblock *msb_raw;
+	struct apfs_superblock *vol;
+	u64 fsid, used_blocks = 0;
+	int err;
+
+	down_read(&nxi->nx_big_sem);
+	msb_raw = nxi->nx_raw;
+	vol = sbi->s_vsb_raw;
+
+	buf->f_type = APFS_NX_MAGIC;
+	/* Nodes are assumed to fit in a page, for now */
+	buf->f_bsize = sb->s_blocksize;
+
+	/* Volumes share the whole disk space */
+	buf->f_blocks = le64_to_cpu(msb_raw->nx_block_count);
+	err = apfs_count_used_blocks(sb, &used_blocks);
+	if (err)
+		goto fail;
+	buf->f_bfree = buf->f_blocks - used_blocks;
+	buf->f_bavail = buf->f_bfree; /* I don't know any better */
+
+	/* The file count is only for the mounted volume */
+	buf->f_files = le64_to_cpu(vol->apfs_num_files) +
+		       le64_to_cpu(vol->apfs_num_directories) +
+		       le64_to_cpu(vol->apfs_num_symlinks) +
+		       le64_to_cpu(vol->apfs_num_other_fsobjects);
+
+	/*
+	 * buf->f_ffree is left undefined for now. Maybe it should report the
+	 * number of available cnids, like hfsplus attempts to do.
+	 */
+
+	buf->f_namelen = APFS_NAME_LEN;
+
+	/* There are no clear rules for the fsid, so we follow ext2 here */
+	fsid = le64_to_cpup((void *)vol->apfs_vol_uuid) ^
+	       le64_to_cpup((void *)vol->apfs_vol_uuid + sizeof(u64));
+	buf->f_fsid.val[0] = fsid & 0xFFFFFFFFUL;
+	buf->f_fsid.val[1] = (fsid >> 32) & 0xFFFFFFFFUL;
+
+fail:
+	up_read(&nxi->nx_big_sem);
+	return err;
+}
+
+static int apfs_show_options(struct seq_file *seq, struct dentry *root)
+{
+	struct apfs_sb_info *sbi = APFS_SB(root->d_sb);
+	struct apfs_nxsb_info *nxi = APFS_NXI(root->d_sb);
+
+	if (sbi->s_vol_nr != 0)
+		seq_printf(seq, ",vol=%u", sbi->s_vol_nr);
+	if (sbi->s_snap_name)
+		seq_printf(seq, ",snap=%s", sbi->s_snap_name);
+	if (uid_valid(sbi->s_uid))
+		seq_printf(seq, ",uid=%u", from_kuid(&init_user_ns,
+						     sbi->s_uid));
+	if (gid_valid(sbi->s_gid))
+		seq_printf(seq, ",gid=%u", from_kgid(&init_user_ns,
+						     sbi->s_gid));
+	if (nxi->nx_flags & APFS_CHECK_NODES)
+		seq_puts(seq, ",cknodes");
+	if (nxi->nx_tier2_info)
+		seq_printf(seq, ",tier2=%s", nxi->nx_tier2_info->blki_path);
+
+	return 0;
+}
+
+int apfs_sync_fs(struct super_block *sb, int wait)
+{
+	struct apfs_max_ops maxops = {0};
+	int err;
+
+	/* TODO: actually start the commit and return without waiting? */
+	if (wait == 0)
+		return 0;
+
+	err = apfs_transaction_start(sb, maxops);
+	if (err)
+		return err;
+	APFS_SB(sb)->s_nxi->nx_transaction.t_state |= APFS_NX_TRANS_FORCE_COMMIT;
+	err = apfs_transaction_commit(sb);
+	if (err)
+		apfs_transaction_abort(sb);
+	return err;
+}
+
+/* Only supports read-only remounts, everything else is silently ignored */
+static int apfs_remount(struct super_block *sb, int *flags, char *data)
+{
+	int err = 0;
+
+	err = sync_filesystem(sb);
+	if (err)
+		return err;
+
+	/* TODO: race? Could a new transaction have started already? */
+	if (*flags & SB_RDONLY)
+		sb->s_flags |= SB_RDONLY;
+
+	/*
+	 * TODO: readwrite remounts seem simple enough, but I worry about
+	 * remounting aborted transactions. I would probably also need a
+	 * dry-run version of parse_options().
+	 */
+	apfs_notice(sb, "all remounts can do is turn a volume read-only");
+	return 0;
+}
+
+static const struct super_operations apfs_sops = {
+	.alloc_inode	= apfs_alloc_inode,
+	.destroy_inode	= apfs_destroy_inode,
+	.write_inode	= apfs_write_inode,
+	.evict_inode	= apfs_evict_inode,
+	.put_super	= apfs_put_super,
+	.sync_fs	= apfs_sync_fs,
+	.statfs		= apfs_statfs,
+	.remount_fs	= apfs_remount,
+	.show_options	= apfs_show_options,
+};
+
+enum {
+	Opt_readwrite, Opt_cknodes, Opt_uid, Opt_gid, Opt_vol, Opt_snap, Opt_tier2, Opt_err,
+};
+
+static const match_table_t tokens = {
+	{Opt_readwrite, "readwrite"},
+	{Opt_cknodes, "cknodes"},
+	{Opt_uid, "uid=%u"},
+	{Opt_gid, "gid=%u"},
+	{Opt_vol, "vol=%u"},
+	{Opt_snap, "snap=%s"},
+	{Opt_tier2, "tier2=%s"},
+	{Opt_err, NULL}
+};
+
+/**
+ * apfs_set_nx_flags - Set the mount flags for the container, if allowed
+ * @sb:		superblock structure
+ * @flags:	flags to set
+ */
+static void apfs_set_nx_flags(struct super_block *sb, unsigned int flags)
+{
+	struct apfs_nxsb_info *nxi = APFS_SB(sb)->s_nxi;
+
+	mutex_lock(&nxs_mutex);
+
+	/* The first mount thet gets here decides the flags for its container */
+	flags |= APFS_FLAGS_SET;
+	if (!(nxi->nx_flags & APFS_FLAGS_SET))
+		nxi->nx_flags = flags;
+	else if (flags != nxi->nx_flags)
+		apfs_warn(sb, "ignoring mount flags - container already mounted");
+
+	mutex_unlock(&nxs_mutex);
+}
+
+/*
+ * Many of the parse_options() functions in other file systems return 0
+ * on error. This one returns an error code, and 0 on success.
+ */
+static int parse_options(struct super_block *sb, char *options)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_nxsb_info *nxi = sbi->s_nxi;
+	char *p;
+	substring_t args[MAX_OPT_ARGS];
+	int option;
+	int err = 0;
+	unsigned int nx_flags;
+
+	/* Set default values before parsing */
+	nx_flags = 0;
+
+	/* Still risky, but some packagers want writable mounts by default */
+	/* TODO: make writing bulletproof */
+	nx_flags |= APFS_READWRITE;
+
+	if (!options)
+		goto out;
+
+	while ((p = strsep(&options, ",")) != NULL) {
+		int token;
+
+		if (!*p)
+			continue;
+		token = match_token(p, tokens, args);
+		switch (token) {
+		case Opt_readwrite:
+			/*
+			 * Write support is not safe yet, so keep it disabled
+			 * unless the user requests it explicitly.
+			 */
+			nx_flags |= APFS_READWRITE;
+			break;
+		case Opt_cknodes:
+			/*
+			 * Right now, node checksums are too costly to enable
+			 * by default.  TODO: try to improve this.
+			 */
+			nx_flags |= APFS_CHECK_NODES;
+			break;
+		case Opt_uid:
+			err = match_int(&args[0], &option);
+			if (err)
+				return err;
+			sbi->s_uid = make_kuid(current_user_ns(), option);
+			if (!uid_valid(sbi->s_uid)) {
+				apfs_err(sb, "invalid uid");
+				return -EINVAL;
+			}
+			break;
+		case Opt_gid:
+			err = match_int(&args[0], &option);
+			if (err)
+				return err;
+			sbi->s_gid = make_kgid(current_user_ns(), option);
+			if (!gid_valid(sbi->s_gid)) {
+				apfs_err(sb, "invalid gid");
+				return -EINVAL;
+			}
+			break;
+		case Opt_vol:
+		case Opt_snap:
+		case Opt_tier2:
+			/* Already read early on mount */
+			break;
+		default:
+			/*
+			 * We should have already checked the mount options in
+			 * apfs_preparse_options(), so this is a bug.
+			 */
+			apfs_alert(sb, "invalid mount option %s", p);
+			return -EINVAL;
+		}
+	}
+
+out:
+	apfs_set_nx_flags(sb, nx_flags);
+	if (!(sb->s_flags & SB_RDONLY)) {
+		if (nxi->nx_flags & APFS_READWRITE) {
+			apfs_notice(sb, "experimental write support is enabled");
+		} else {
+			apfs_warn(sb, "experimental writes disabled to avoid data loss");
+			apfs_warn(sb, "if you really want them, check the README");
+			sb->s_flags |= SB_RDONLY;
+		}
+	}
+	return 0;
+}
+
+/**
+ * apfs_check_nx_features - Check for unsupported features in the container
+ * @sb: superblock structure
+ *
+ * Returns -EINVAL if unsupported incompatible features are found, otherwise
+ * returns 0.
+ */
+static int apfs_check_nx_features(struct super_block *sb)
+{
+	struct apfs_nx_superblock *msb_raw = NULL;
+	u64 features;
+	bool fusion;
+
+	msb_raw = APFS_NXI(sb)->nx_raw;
+	if (!msb_raw) {
+		apfs_alert(sb, "feature checks are misplaced");
+		return -EINVAL;
+	}
+
+	features = le64_to_cpu(msb_raw->nx_incompatible_features);
+	if (features & ~APFS_NX_SUPPORTED_INCOMPAT_MASK) {
+		apfs_warn(sb, "unknown incompatible container features (0x%llx)", features);
+		return -EINVAL;
+	}
+
+	fusion = features & APFS_NX_INCOMPAT_FUSION;
+	if (fusion && !APFS_NXI(sb)->nx_tier2_info) {
+		apfs_warn(sb, "fusion drive - please use the \"tier2\" mount option");
+		return -EINVAL;
+	}
+	if (!fusion && APFS_NXI(sb)->nx_tier2_info) {
+		apfs_warn(sb, "not a fusion drive - what's the second disk for?");
+		return -EINVAL;
+	}
+	if (fusion) {
+		if (!sb_rdonly(sb)) {
+			apfs_warn(sb, "writes to fusion drives not yet supported");
+			sb->s_flags |= SB_RDONLY;
+		}
+	}
+
+	features = le64_to_cpu(msb_raw->nx_readonly_compatible_features);
+	if (features & ~APFS_NX_SUPPORTED_ROCOMPAT_MASK) {
+		apfs_warn(sb, "unknown read-only compatible container features (0x%llx)", features);
+		if (!sb_rdonly(sb)) {
+			apfs_warn(sb, "container can't be mounted read-write");
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+/**
+ * apfs_check_vol_features - Check for unsupported features in the volume
+ * @sb: superblock structure
+ *
+ * Returns -EINVAL if unsupported incompatible features are found, otherwise
+ * returns 0.
+ */
+static int apfs_check_vol_features(struct super_block *sb)
+{
+	struct apfs_superblock *vsb_raw = NULL;
+	u64 features;
+
+	vsb_raw = APFS_SB(sb)->s_vsb_raw;
+	if (!vsb_raw) {
+		apfs_alert(sb, "feature checks are misplaced");
+		return -EINVAL;
+	}
+
+	features = le64_to_cpu(vsb_raw->apfs_incompatible_features);
+	if (features & ~APFS_SUPPORTED_INCOMPAT_MASK) {
+		apfs_warn(sb, "unknown incompatible volume features (0x%llx)", features);
+		return -EINVAL;
+	}
+	if (features & APFS_INCOMPAT_DATALESS_SNAPS) {
+		/*
+		 * I haven't encountered dataless snapshots myself yet (TODO).
+		 * I'm not even sure what they are, so be safe.
+		 */
+		if (!sb_rdonly(sb)) {
+			apfs_warn(sb, "writes to volumes with dataless snapshots not yet supported");
+			return -EINVAL;
+		}
+		apfs_warn(sb, "volume has dataless snapshots");
+	}
+	if (features & APFS_INCOMPAT_ENC_ROLLED) {
+		apfs_warn(sb, "encrypted volumes are not supported");
+		return -EINVAL;
+	}
+	if (features & APFS_INCOMPAT_INCOMPLETE_RESTORE) {
+		apfs_warn(sb, "incomplete restore is not supported");
+		return -EINVAL;
+	}
+	if (features & APFS_INCOMPAT_PFK) {
+		apfs_warn(sb, "PFK is not supported");
+		return -EINVAL;
+	}
+	if (features & APFS_INCOMPAT_SECONDARY_FSROOT) {
+		apfs_warn(sb, "secondary fsroot is not supported");
+		return -EINVAL;
+	}
+	if (features & APFS_INCOMPAT_SEALED_VOLUME) {
+		if (!sb_rdonly(sb)) {
+			apfs_warn(sb, "writes to sealed volumes are not yet supported");
+			return -EINVAL;
+		}
+		apfs_info(sb, "volume is sealed");
+	}
+	/*
+	 * As far as I can see, all this feature seems to do is define a new
+	 * flag (which I call APFS_FILE_EXTENT_PREALLOCATED) for extents that
+	 * are fully after the end of their file. I don't get why this change
+	 * is incompatible instead of read-only compatible, so I fear I might
+	 * be missing something. I will never be certain though, so for now
+	 * allow the mount and hope for the best.
+	 */
+	if (features & APFS_INCOMPAT_EXTENT_PREALLOC_FLAG)
+		apfs_warn(sb, "extent prealloc flag is set");
+
+	features = le64_to_cpu(vsb_raw->apfs_fs_flags);
+	/* Some encrypted volumes are readable anyway */
+	if (!(features & APFS_FS_UNENCRYPTED))
+		apfs_warn(sb, "volume is encrypted, may not be read correctly");
+
+	features = le64_to_cpu(vsb_raw->apfs_readonly_compatible_features);
+	if (features & ~APFS_SUPPORTED_ROCOMPAT_MASK) {
+		apfs_warn(sb, "unknown read-only compatible volume features (0x%llx)", features);
+		if (!sb_rdonly(sb)) {
+			apfs_warn(sb, "volume can't be mounted read-write");
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+/**
+ * apfs_setup_bdi - Set up the bdi for the superblock
+ * @sb: superblock structure
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+static int apfs_setup_bdi(struct super_block *sb)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_blkdev_info *bd_info = NULL;
+	struct backing_dev_info *bdi_dev = NULL, *bdi_sb = NULL;
+	int err;
+
+	bd_info = nxi->nx_blkdev_info;
+	bdi_dev = bd_info->blki_bdev->bd_disk->bdi;
+
+	err = super_setup_bdi(sb);
+	if (err)
+		return err;
+	bdi_sb = sb->s_bdi;
+
+	bdi_sb->ra_pages = bdi_dev->ra_pages;
+	bdi_sb->io_pages = bdi_dev->io_pages;
+
+	bdi_sb->capabilities = bdi_dev->capabilities;
+	bdi_sb->capabilities &= ~BDI_CAP_WRITEBACK;
+
+	return 0;
+}
+
+static void apfs_set_trans_buffer_limit(struct super_block *sb)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	unsigned long memsize_in_blocks;
+	struct sysinfo info = {0};
+
+	si_meminfo(&info);
+	memsize_in_blocks = info.totalram << (PAGE_SHIFT - sb->s_blocksize_bits);
+
+	/*
+	 * Buffer heads are not reclaimed while they are part of the current
+	 * transaction, so systems with little memory will crash if we don't
+	 * commit often enough. This hack should make that happen in general,
+	 * but I still need to get the reclaim to work eventually (TODO).
+	 */
+	if (memsize_in_blocks >= 16 * APFS_TRANS_BUFFERS_MAX)
+		nxi->nx_trans_buffers_max = APFS_TRANS_BUFFERS_MAX;
+	else
+		nxi->nx_trans_buffers_max = memsize_in_blocks / 16;
+}
+
+static int apfs_fill_super(struct super_block *sb, void *data, int silent)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct inode *root = NULL, *priv = NULL;
+	int err;
+
+	/*
+	 * This function doesn't write anything to disk, that happens later
+	 * when an actual transaction begins. So, it's not generally a problem
+	 * if other mounts for the same container fill their own supers at the
+	 * same time (the few critical sections will be protected by
+	 * nxs_mutex), nor is it a problem if other mounted volumes want to
+	 * make reads while the mount is taking place. But we definitely don't
+	 * want any writes, or else we could find ourselves reading stale
+	 * blocks after CoW, among other issues.
+	 */
+	down_read(&APFS_NXI(sb)->nx_big_sem);
+
+	err = apfs_setup_bdi(sb);
+	if (err)
+		goto failed_volume;
+
+	sbi->s_uid = INVALID_UID;
+	sbi->s_gid = INVALID_GID;
+	err = parse_options(sb, data);
+	if (err)
+		goto failed_volume;
+
+	err = apfs_map_volume_super(sb, false /* write */);
+	if (err)
+		goto failed_volume;
+
+	err = apfs_check_vol_features(sb);
+	if (err)
+		goto failed_omap;
+
+	/*
+	 * The omap needs to be set before the call to apfs_read_catalog().
+	 * It's also shared with all the snapshots, so it needs to be read
+	 * before we switch to the old superblock.
+	 */
+	err = apfs_first_read_omap(sb);
+	if (err)
+		goto failed_omap;
+
+	if (sbi->s_snap_name) {
+		err = apfs_switch_to_snapshot(sb);
+		if (err)
+			goto failed_cat;
+	}
+
+	err = apfs_read_catalog(sb, false /* write */);
+	if (err)
+		goto failed_cat;
+
+	sb->s_op = &apfs_sops;
+	sb->s_d_op = &apfs_dentry_operations;
+	sb->s_xattr = apfs_xattr_handlers;
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_time_gran = 1; /* Nanosecond granularity */
+
+	/*
+	 * At this point everything is already set up for the inode reads,
+	 * which take care of their own locking as always.
+	 */
+	up_read(&APFS_NXI(sb)->nx_big_sem);
+
+	sbi->s_private_dir = apfs_iget(sb, APFS_PRIV_DIR_INO_NUM);
+	if (IS_ERR(sbi->s_private_dir)) {
+		apfs_err(sb, "unable to get private-dir inode");
+		err = PTR_ERR(sbi->s_private_dir);
+		goto failed_private_dir;
+	}
+
+	root = apfs_iget(sb, APFS_ROOT_DIR_INO_NUM);
+	if (IS_ERR(root)) {
+		apfs_err(sb, "unable to get root inode");
+		err = PTR_ERR(root);
+		goto failed_mount;
+	}
+
+	sb->s_root = d_make_root(root);
+	if (!sb->s_root) {
+		apfs_err(sb, "unable to get root dentry");
+		err = -ENOMEM;
+		goto failed_mount;
+	}
+
+	INIT_WORK(&sbi->s_orphan_cleanup_work, apfs_orphan_cleanup_work);
+	if (!(sb->s_flags & SB_RDONLY)) {
+		priv = sbi->s_private_dir;
+		if (APFS_I(priv)->i_nchildren)
+			schedule_work(&sbi->s_orphan_cleanup_work);
+	}
+	return 0;
+
+failed_mount:
+	iput(sbi->s_private_dir);
+failed_private_dir:
+	sbi->s_private_dir = NULL;
+	down_read(&APFS_NXI(sb)->nx_big_sem);
+	apfs_node_free(sbi->s_cat_root);
+failed_cat:
+	apfs_unset_omap(sb);
+failed_omap:
+	apfs_unmap_volume_super(sb);
+failed_volume:
+	up_read(&APFS_NXI(sb)->nx_big_sem);
+	return err;
+}
+
+/**
+ * apfs_strings_are_equal - Compare two possible NULL strings
+ * @str1: the first string
+ * @str2: the second string
+ */
+static bool apfs_strings_are_equal(const char *str1, const char *str2)
+{
+	if (str1 == str2) /* Both are NULL */
+		return true;
+	if (!str1 || !str2) /* One is NULL */
+		return false;
+	return strcmp(str1, str2) == 0;
+}
+
+/**
+ * apfs_test_super - Check if two volume superblocks are for the same volume
+ * @sb:		superblock structure for a currently mounted volume
+ * @data:	superblock info for the volume being mounted
+ */
+static int apfs_test_super(struct super_block *sb, void *data)
+{
+	struct apfs_sb_info *sbi_1 = data;
+	struct apfs_sb_info *sbi_2 = APFS_SB(sb);
+
+	if (sbi_1->s_nxi != sbi_2->s_nxi)
+		return false;
+	if (sbi_1->s_vol_nr != sbi_2->s_vol_nr)
+		return false;
+	return apfs_strings_are_equal(sbi_1->s_snap_name, sbi_2->s_snap_name);
+}
+
+/**
+ * apfs_set_super - Assign the device and an info struct to a superblock
+ * @sb:		superblock structure to set
+ * @data:	superblock info for the volume being mounted
+ */
+static int apfs_set_super(struct super_block *sb, void *data)
+{
+	struct apfs_sb_info *sbi = data;
+	struct apfs_nxsb_info *nxi = sbi->s_nxi;
+	int err;
+
+	/*
+	 * This fake device number will be unique to this volume-snapshot
+	 * combination. It gets reported by stat(), so that userland tools can
+	 * use it to tell different mountpoints apart.
+	 */
+	err = get_anon_bdev(&sbi->s_anon_dev);
+	if (err)
+		return err;
+
+	/*
+	 * This is the actual device number, shared by all volumes and
+	 * snapshots. It gets reported by the mountinfo file, and it seems that
+	 * udisks uses it to decide if a device is mounted, so it must be set.
+	 *
+	 * TODO: does this work for fusion drives?
+	 */
+	sb->s_dev = nxi->nx_blkdev_info->blki_bdev->bd_dev;
+
+	sb->s_fs_info = sbi;
+	return 0;
+}
+
+/*
+ * Wrapper for lookup_bdev() that supports older kernels.
+ */
+static int apfs_lookup_bdev(const char *pathname, dev_t *dev)
+{
+	return lookup_bdev(pathname, dev);
+}
+
+/**
+ * apfs_blkdev_setup - Open a block device and set its info struct
+ * @info_p:	info struct to set
+ * @dev_name:	path name for the block device to open
+ * @mode:	FMODE_* mask
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+static int apfs_blkdev_setup(struct apfs_blkdev_info **info_p, const char *dev_name, blk_mode_t mode)
+{
+	struct apfs_blkdev_info *info = NULL;
+	struct file *file = NULL;
+	struct block_device *bdev = NULL;
+	int ret;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	info->blki_path = kstrdup(dev_name, GFP_KERNEL);
+	if (!info->blki_path) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	file = bdev_file_open_by_path(dev_name, mode, &apfs_fs_type, NULL);
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		goto fail;
+	}
+	info->blki_bdev_file = file;
+	bdev = file_bdev(file);
+
+	if (IS_ERR(bdev)) {
+		ret = PTR_ERR(bdev);
+		goto fail;
+	}
+	info->blki_bdev = bdev;
+	*info_p = info;
+	return 0;
+
+fail:
+	kfree(info->blki_path);
+	info->blki_path = NULL;
+	kfree(info);
+	info = NULL;
+	return ret;
+}
+
+/**
+ * apfs_attach_nxi - Attach container sb info to a volume's sb info
+ * @sbi:	new superblock info structure for the volume to be mounted
+ * @dev_name:	path name for the container's block device
+ * @mode:	FMODE_* mask
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+static int apfs_attach_nxi(struct apfs_sb_info *sbi, const char *dev_name, blk_mode_t mode)
+{
+	struct apfs_nxsb_info *nxi = NULL;
+	dev_t dev = 0;
+	int ret;
+
+	mutex_lock(&nxs_mutex);
+
+	ret = apfs_lookup_bdev(dev_name, &dev);
+	if (ret)
+		goto out;
+
+	nxi = apfs_nx_find_by_dev(dev);
+	if (!nxi) {
+		nxi = kzalloc(sizeof(*nxi), GFP_KERNEL);
+		if (!nxi) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		ret = apfs_blkdev_setup(&nxi->nx_blkdev_info, dev_name, mode);
+		if (ret)
+			goto out;
+
+		if (sbi->s_tier2_path) {
+			ret = apfs_blkdev_setup(&nxi->nx_tier2_info, sbi->s_tier2_path, mode);
+			if (ret) {
+				apfs_blkdev_cleanup(nxi->nx_blkdev_info);
+				nxi->nx_blkdev_info = NULL;
+				goto out;
+			}
+			/* We won't need this anymore, so why waste memory? */
+			kfree(sbi->s_tier2_path);
+			sbi->s_tier2_path = NULL;
+		}
+
+		init_rwsem(&nxi->nx_big_sem);
+		list_add(&nxi->nx_list, &nxs);
+		INIT_LIST_HEAD(&nxi->vol_list);
+		apfs_transaction_init(&nxi->nx_transaction);
+	}
+
+	list_add(&sbi->list, &nxi->vol_list);
+	sbi->s_nxi = nxi;
+	++nxi->nx_refcnt;
+	ret = 0;
+out:
+	if (ret) {
+		kfree(nxi);
+		nxi = NULL;
+	}
+	mutex_unlock(&nxs_mutex);
+	return ret;
+}
+
+/**
+ * apfs_preparse_options - Parse the options used to identify a superblock
+ * @sbi:	superblock info
+ * @options:	options string to parse
+ *
+ * Returns 0 on success, or a negative error code in case of failure. Even on
+ * failure, the caller is responsible for freeing all superblock fields.
+ */
+static int apfs_preparse_options(struct apfs_sb_info *sbi, char *options)
+{
+	char *tofree = NULL;
+	char *p;
+	substring_t args[MAX_OPT_ARGS];
+	int err = 0;
+
+	/* Set default values before parsing */
+	sbi->s_vol_nr = 0;
+	sbi->s_snap_name = NULL;
+	sbi->s_tier2_path = NULL;
+
+	if (!options)
+		return 0;
+
+	/* Later parse_options() will need the unmodified options string */
+	options = kstrdup(options, GFP_KERNEL);
+	if (!options)
+		return -ENOMEM;
+	tofree = options;
+
+	while ((p = strsep(&options, ",")) != NULL) {
+		int token;
+
+		if (!*p)
+			continue;
+		token = match_token(p, tokens, args);
+		switch (token) {
+		case Opt_vol:
+			err = match_int(&args[0], &sbi->s_vol_nr);
+			if (err)
+				goto out;
+			break;
+		case Opt_snap:
+			kfree(sbi->s_snap_name);
+			sbi->s_snap_name = match_strdup(&args[0]);
+			if (!sbi->s_snap_name) {
+				err = -ENOMEM;
+				goto out;
+			}
+			break;
+		case Opt_tier2:
+			kfree(sbi->s_tier2_path);
+			sbi->s_tier2_path = match_strdup(&args[0]);
+			if (!sbi->s_tier2_path) {
+				err = -ENOMEM;
+				goto out;
+			}
+			break;
+		case Opt_readwrite:
+		case Opt_cknodes:
+		case Opt_uid:
+		case Opt_gid:
+			/* Not needed for sget(), will be read later */
+			break;
+		default:
+			apfs_warn(NULL, "invalid mount option %s", p);
+			err = -EINVAL;
+			goto out;
+		}
+	}
+	err = 0;
+out:
+	kfree(tofree);
+	return err;
+}
+
+/*
+ * This function is a copy of mount_bdev() that allows multiple mounts.
+ */
+static struct dentry *apfs_mount(struct file_system_type *fs_type, int flags,
+				 const char *dev_name, void *data)
+{
+	struct super_block *sb;
+	struct apfs_sb_info *sbi;
+	struct apfs_blkdev_info *bd_info = NULL, *tier2_info = NULL;
+	blk_mode_t mode = sb_open_mode(flags);
+	int error = 0;
+
+	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
+	if (!sbi)
+		return ERR_PTR(-ENOMEM);
+	/* Set up the fields that sget() will need to id the superblock */
+	error = apfs_preparse_options(sbi, data);
+	if (error)
+		goto out_free_sbi;
+
+	/* Make sure that snapshots are mounted read-only */
+	if (sbi->s_snap_name)
+		flags |= SB_RDONLY;
+
+	error = apfs_attach_nxi(sbi, dev_name, mode);
+	if (error)
+		goto out_free_sbi;
+
+	/* TODO: lockfs stuff? Btrfs doesn't seem to care */
+	sb = sget(fs_type, apfs_test_super, apfs_set_super, flags | SB_NOSEC, sbi);
+	if (IS_ERR(sb)) {
+		error = PTR_ERR(sb);
+		goto out_unmap_super;
+	}
+
+	bd_info = APFS_NXI(sb)->nx_blkdev_info;
+	tier2_info = APFS_NXI(sb)->nx_tier2_info;
+
+	/*
+	 * I'm doing something hacky with s_dev inside ->kill_sb(), so I want
+	 * to find out as soon as possible if I messed it up.
+	 */
+	WARN_ON(sb->s_dev != bd_info->blki_bdev->bd_dev);
+
+	if (sb->s_root) {
+		if ((flags ^ sb->s_flags) & SB_RDONLY) {
+			error = -EBUSY;
+			deactivate_locked_super(sb);
+			goto out_unmap_super;
+		}
+		/* Only one superblock per volume */
+		apfs_free_main_super(sbi);
+		kfree(sbi->s_snap_name);
+		sbi->s_snap_name = NULL;
+		kfree(sbi->s_tier2_path);
+		sbi->s_tier2_path = NULL;
+		kfree(sbi);
+		sbi = NULL;
+	} else {
+		if (!sbi->s_snap_name && !tier2_info)
+			snprintf(sb->s_id, sizeof(sb->s_id), "%pg:%u", bd_info->blki_bdev, sbi->s_vol_nr);
+		else if (!tier2_info)
+			snprintf(sb->s_id, sizeof(sb->s_id), "%pg:%u:%s", bd_info->blki_bdev, sbi->s_vol_nr, sbi->s_snap_name);
+		else if (!sbi->s_snap_name)
+			snprintf(sb->s_id, sizeof(sb->s_id), "%pg+%pg:%u", bd_info->blki_bdev, tier2_info->blki_bdev, sbi->s_vol_nr);
+		else
+			snprintf(sb->s_id, sizeof(sb->s_id), "%pg+%pg:%u:%s", bd_info->blki_bdev, tier2_info->blki_bdev, sbi->s_vol_nr, sbi->s_snap_name);
+		error = apfs_read_main_super(sb);
+		if (error) {
+			deactivate_locked_super(sb);
+			return ERR_PTR(error);
+		}
+		error = apfs_fill_super(sb, data, flags & SB_SILENT ? 1 : 0);
+		if (error) {
+			deactivate_locked_super(sb);
+			return ERR_PTR(error);
+		}
+		sb->s_flags |= SB_ACTIVE;
+	}
+
+	return dget(sb->s_root);
+
+out_unmap_super:
+	apfs_free_main_super(sbi);
+out_free_sbi:
+	kfree(sbi->s_snap_name);
+	kfree(sbi->s_tier2_path);
+	kfree(sbi);
+	return ERR_PTR(error);
+}
+
+/**
+ * apfs_free_sb_info - Free the sb info and release all remaining fields
+ * @sb: superblock structure
+ *
+ * This function does not include the cleanup for apfs_fill_super(), which
+ * already took place inside ->put_super() (or maybe inside apfs_fill_super()
+ * itself if the mount failed).
+ */
+static void apfs_free_sb_info(struct super_block *sb)
+{
+	struct apfs_sb_info *sbi = NULL;
+
+	sbi = APFS_SB(sb);
+	apfs_free_main_super(sbi);
+	sb->s_fs_info = NULL;
+
+	kfree(sbi->s_snap_name);
+	sbi->s_snap_name = NULL;
+	kfree(sbi->s_tier2_path);
+	sbi->s_tier2_path = NULL;
+	if (sbi->s_dflt_pfk)
+		kfree(sbi->s_dflt_pfk);
+	kfree(sbi);
+	sbi = NULL;
+}
+
+static void apfs_kill_sb(struct super_block *sb)
+{
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+
+	/*
+	 * We need to delist the superblock before freeing its info to avoid a
+	 * race with apfs_test_super(), but we can't call kill_super_notify()
+	 * from the driver. The available wrapper is kill_anon_super(), but our
+	 * s_dev is set to the actual device (that gets freed later along with
+	 * the container), not to the anon device that we keep on the sbi. So,
+	 * we change that before the call; this is safe because other mounters
+	 * won't revive this super, even if apfs_test_super() succeeds.
+	 */
+	sb->s_dev = sbi->s_anon_dev;
+	kill_anon_super(sb);
+
+	apfs_free_sb_info(sb);
+}
+
+static struct file_system_type apfs_fs_type = {
+	.owner		= THIS_MODULE,
+	.name		= "apfs",
+	.mount		= apfs_mount,
+	.kill_sb	= apfs_kill_sb,
+	.fs_flags	= FS_REQUIRES_DEV,
+};
+MODULE_ALIAS_FS("apfs");
+
+static int __init init_apfs_fs(void)
+{
+	int err = 0;
+
+	err = init_inodecache();
+	if (err)
+		return err;
+	err = register_filesystem(&apfs_fs_type);
+	if (err)
+		destroy_inodecache();
+	return err;
+}
+
+static void __exit exit_apfs_fs(void)
+{
+	unregister_filesystem(&apfs_fs_type);
+	destroy_inodecache();
+}
+
+MODULE_AUTHOR("Ernesto A. Fernández");
+MODULE_AUTHOR("Ethan Carter Edwards");
+MODULE_DESCRIPTION("Apple File System");
+// Module is GPL2, Apple Compression library is BSD3
+MODULE_LICENSE("Dual BSD/GPL");
+module_init(init_apfs_fs)
+module_exit(exit_apfs_fs)
diff --git a/drivers/staging/apfs/symlink.c b/drivers/staging/apfs/symlink.c
new file mode 100644
index 0000000000000000000000000000000000000000..2564055bcf5b82d765d807606b4f7004f4f2e396
--- /dev/null
+++ b/drivers/staging/apfs/symlink.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2018 Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
+ * Copyright (C) 2025 Ethan Carter Edwards <ethan@ethancedwards.com>
+ */
+
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include "apfs.h"
+
+/**
+ * apfs_get_link - Follow a symbolic link
+ * @dentry:	dentry for the link
+ * @inode:	inode for the link
+ * @done:	delayed call to free the returned buffer after use
+ *
+ * Returns a pointer to a buffer containing the target path, or an appropriate
+ * error pointer in case of failure.
+ */
+static const char *apfs_get_link(struct dentry *dentry, struct inode *inode,
+				 struct delayed_call *done)
+{
+	struct super_block *sb = inode->i_sb;
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	char *target = NULL;
+	int err;
+	int size;
+
+	down_read(&nxi->nx_big_sem);
+
+	if (!dentry) {
+		err = -ECHILD;
+		goto fail;
+	}
+
+	size = __apfs_xattr_get(inode, APFS_XATTR_NAME_SYMLINK,
+				NULL /* buffer */, 0 /* size */);
+	if (size < 0) { /* TODO: return a better error code */
+		apfs_err(sb, "symlink size read failed");
+		err = size;
+		goto fail;
+	}
+
+	target = kmalloc(size, GFP_KERNEL);
+	if (!target) {
+		err = -ENOMEM;
+		goto fail;
+	}
+
+	size = __apfs_xattr_get(inode, APFS_XATTR_NAME_SYMLINK, target, size);
+	if (size < 0) {
+		apfs_err(sb, "symlink read failed");
+		err = size;
+		goto fail;
+	}
+	if (size == 0 || *(target + size - 1) != 0) {
+		/* Target path must be NULL-terminated */
+		apfs_err(sb, "bad link target in inode 0x%llx", apfs_ino(inode));
+		err = -EFSCORRUPTED;
+		goto fail;
+	}
+
+	up_read(&nxi->nx_big_sem);
+	set_delayed_call(done, kfree_link, target);
+	return target;
+
+fail:
+	kfree(target);
+	up_read(&nxi->nx_big_sem);
+	return ERR_PTR(err);
+}
+
+const struct inode_operations apfs_symlink_inode_operations = {
+	.get_link	= apfs_get_link,
+	.getattr	= apfs_getattr,
+	.listxattr	= apfs_listxattr,
+	.update_time	= apfs_update_time,
+};
diff --git a/drivers/staging/apfs/transaction.c b/drivers/staging/apfs/transaction.c
new file mode 100644
index 0000000000000000000000000000000000000000..d6316e676b74070836a1aa6cce59c22d3d79df07
--- /dev/null
+++ b/drivers/staging/apfs/transaction.c
@@ -0,0 +1,959 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2019 Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
+ */
+
+#include <linux/blkdev.h>
+#include <linux/rmap.h>
+#include "apfs.h"
+
+/**
+ * apfs_checkpoint_end - End the new checkpoint
+ * @sb:	filesystem superblock
+ *
+ * Flushes all changes to disk, and commits the new checkpoint by setting the
+ * fletcher checksum on its superblock.  Returns 0 on success, or a negative
+ * error code in case of failure.
+ */
+static int apfs_checkpoint_end(struct super_block *sb)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_obj_phys *obj = &nxi->nx_raw->nx_o;
+	struct buffer_head *bh = NULL;
+	struct apfs_blkdev_info *bd_info = nxi->nx_blkdev_info;
+	struct address_space *bdev_map = bd_info->blki_bdev->bd_mapping;
+	int err;
+
+	ASSERT(!(sb->s_flags & SB_RDONLY));
+
+	bh = apfs_getblk(sb, nxi->nx_bno);
+	if (!bh) {
+		apfs_err(sb, "failed to map new checkpoint superblock");
+		return -EIO;
+	}
+	obj->o_xid = cpu_to_le64(nxi->nx_xid);
+	apfs_obj_set_csum(sb, obj);
+	memcpy(bh->b_data, obj, sb->s_blocksize);
+
+	err = filemap_write_and_wait(bdev_map);
+	if (err)
+		goto out;
+
+	mark_buffer_dirty(bh);
+	err = sync_dirty_buffer(bh);
+	if (err)
+		goto out;
+
+	err = filemap_write_and_wait(bdev_map);
+out:
+	brelse(bh);
+	bh = NULL;
+	return err;
+}
+
+/**
+ * apfs_transaction_has_room - Is there enough free space for this transaction?
+ * @sb:		superblock structure
+ * @maxops:	maximum operations expected
+ */
+static bool apfs_transaction_has_room(struct super_block *sb, struct apfs_max_ops maxops)
+{
+	u64 max_cat_blks, max_omap_blks, max_extref_blks, max_blks;
+	/* I don't know the actual maximum heights, just guessing */
+	const u64 max_cat_height = 8, max_omap_height = 3, max_extref_height = 3;
+
+	/*
+	 * On the worst possible case (a tree of max_height), each new insertion
+	 * to the catalog may both cow and split every node up to the root. The
+	 * root though, is only cowed once.
+	 */
+	max_cat_blks = 1 + 2 * maxops.cat * max_cat_height;
+
+	/*
+	 * Any new catalog node could require a new entry in the object map,
+	 * because the original might belong to a snapshot.
+	 */
+	max_omap_blks = 1 + 2 * max_cat_blks * max_omap_height;
+
+	/* The extent reference tree needs a maximum of one record per block */
+	max_extref_blks = 1 + 2 * maxops.blks * max_extref_height;
+
+	/*
+	 * Ephemeral allocations shouldn't fail, and neither should those in the
+	 * internal pool. So just add the actual file blocks and we are done.
+	 */
+	max_blks = max_cat_blks + max_omap_blks + max_extref_blks + maxops.blks;
+
+	return max_blks < APFS_SM(sb)->sm_free_count;
+}
+
+/**
+ * apfs_read_single_ephemeral_object - Read a single ephemeral object to memory
+ * @sb:		filesystem superblock
+ * @map:	checkpoint mapping for the object
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_read_single_ephemeral_object(struct super_block *sb, struct apfs_checkpoint_mapping *map)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_nx_superblock *raw_sb = NULL;
+	struct apfs_ephemeral_object_info *list = NULL;
+	struct buffer_head *bh = NULL;
+	char *object = NULL;
+	int count;
+	u32 data_blks, size;
+	u64 data_base, bno, oid;
+	int err, i, data_idx;
+
+	raw_sb = nxi->nx_raw;
+	data_base = le64_to_cpu(raw_sb->nx_xp_data_base);
+	data_blks = le32_to_cpu(raw_sb->nx_xp_data_blocks);
+
+	list = nxi->nx_eph_list;
+	count = nxi->nx_eph_count;
+	if (count >= APFS_EPHEMERAL_LIST_LIMIT) {
+		apfs_err(sb, "too many ephemeral objects?");
+		return -EOPNOTSUPP;
+	}
+
+	bno = le64_to_cpu(map->cpm_paddr);
+	oid = le64_to_cpu(map->cpm_oid);
+	size = le32_to_cpu(map->cpm_size);
+	if (size > sb->s_blocksize << 1) {
+		/*
+		 * No reason not to support bigger objects, but there has to be
+		 * a limit somewhere and this is all I've seen so far.
+		 */
+		apfs_warn(sb, "ephemeral object has more than 2 blocks");
+		return -EOPNOTSUPP;
+	}
+	if (!size || (size & (sb->s_blocksize - 1))) {
+		apfs_err(sb, "invalid object size (0x%x)", size);
+		return -EFSCORRUPTED;
+	}
+	object = kmalloc(size, GFP_KERNEL);
+	if (!object)
+		return -ENOMEM;
+
+	data_idx = bno - data_base;
+	for (i = 0; i < size >> sb->s_blocksize_bits; ++i) {
+		bh = apfs_sb_bread(sb, data_base + data_idx);
+		if (!bh) {
+			apfs_err(sb, "failed to read ephemeral block");
+			err = -EIO;
+			goto fail;
+		}
+		memcpy(object + (i << sb->s_blocksize_bits), bh->b_data, sb->s_blocksize);
+		brelse(bh);
+		bh = NULL;
+		/* Somewhat surprisingly, objects can wrap around */
+		if (++data_idx == data_blks)
+			data_idx = 0;
+	}
+
+	/*
+	 * The official reference requires that we always verify ephemeral
+	 * checksums on mount, so do it even if the user didn't ask. We should
+	 * actually try to mount an older checkpoint when this fails (TODO),
+	 * which I guess means that the official driver writes all checkpoint
+	 * blocks at once, instead of leaving the superblock for last like we
+	 * do.
+	 */
+	if (!apfs_multiblock_verify_csum(object, size)) {
+		apfs_err(sb, "bad checksum for ephemeral object 0x%llx", oid);
+		err = -EFSBADCRC;
+		goto fail;
+	}
+
+	list[count].oid = oid;
+	list[count].size = size;
+	list[count].object = object;
+	object = NULL;
+	nxi->nx_eph_count = count + 1;
+	return 0;
+
+fail:
+	kfree(object);
+	object = NULL;
+	return err;
+}
+
+/**
+ * apfs_read_single_cpm_block - Read all ephemeral objects in a cpm block
+ * @sb:		filesystem superblock
+ * @cpm_bno:	block number for the cpm block
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_read_single_cpm_block(struct super_block *sb, u64 cpm_bno)
+{
+	struct buffer_head *bh = NULL;
+	struct apfs_checkpoint_map_phys *cpm = NULL;
+	u32 map_count;
+	int err, i;
+
+	bh = apfs_sb_bread(sb, cpm_bno);
+	if (!bh) {
+		apfs_err(sb, "failed to read cpm block");
+		return -EIO;
+	}
+	if (!apfs_obj_verify_csum(sb, bh)) {
+		/*
+		 * The reference seems to imply that we need to check these on
+		 * mount, and retry an older checkpoint on failure (TODO).
+		 */
+		apfs_err(sb, "bad checksum for cpm block at 0x%llx", cpm_bno);
+		err = -EFSBADCRC;
+		goto out;
+	}
+	cpm = (struct apfs_checkpoint_map_phys *)bh->b_data;
+
+	map_count = le32_to_cpu(cpm->cpm_count);
+	if (map_count > apfs_max_maps_per_block(sb)) {
+		apfs_err(sb, "block has too many maps (%d)", map_count);
+		err = -EFSCORRUPTED;
+		goto out;
+	}
+
+	for (i = 0; i < map_count; ++i) {
+		err = apfs_read_single_ephemeral_object(sb, &cpm->cpm_map[i]);
+		if (err) {
+			apfs_err(sb, "failed to read ephemeral object %u", i);
+			goto out;
+		}
+	}
+
+out:
+	brelse(bh);
+	cpm = NULL;
+	return err;
+}
+
+/**
+ * apfs_read_ephemeral_objects - Read all ephemeral objects to memory
+ * @sb:	superblock structure
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_read_ephemeral_objects(struct super_block *sb)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_nx_superblock *raw_sb = nxi->nx_raw;
+	u64 desc_base;
+	u32 desc_index, desc_blks, desc_len, i;
+	int err;
+
+	if (nxi->nx_eph_list) {
+		apfs_alert(sb, "attempt to reread ephemeral object list");
+		return -EFSCORRUPTED;
+	}
+	nxi->nx_eph_list = kzalloc(APFS_EPHEMERAL_LIST_SIZE, GFP_KERNEL);
+	if (!nxi->nx_eph_list)
+		return -ENOMEM;
+	nxi->nx_eph_count = 0;
+
+	desc_base = le64_to_cpu(raw_sb->nx_xp_desc_base);
+	desc_index = le32_to_cpu(raw_sb->nx_xp_desc_index);
+	desc_blks = le32_to_cpu(raw_sb->nx_xp_desc_blocks);
+	desc_len = le32_to_cpu(raw_sb->nx_xp_desc_len);
+
+	/* Last block in the area is superblock; the rest are mapping blocks */
+	for (i = 0; i < desc_len - 1; ++i) {
+		u64 cpm_bno = desc_base + (desc_index + i) % desc_blks;
+
+		err = apfs_read_single_cpm_block(sb, cpm_bno);
+		if (err) {
+			apfs_err(sb, "failed to read cpm block %u", i);
+			return err;
+		}
+	}
+	return 0;
+}
+
+static void apfs_trans_commit_work(struct work_struct *work)
+{
+	struct super_block *sb = NULL;
+	struct apfs_nxsb_info *nxi = NULL;
+	struct apfs_nx_transaction *trans = NULL;
+	int err;
+
+	trans = container_of(to_delayed_work(work), struct apfs_nx_transaction, t_work);
+	nxi = container_of(trans, struct apfs_nxsb_info, nx_transaction);
+	sb = trans->t_work_sb;
+
+	/*
+	 * If sb is set then the transaction already started, there is no need
+	 * for apfs_transaction_start() here. It would be cleaner to call it
+	 * anyway (and check in there if sb is set), but maxops is a problem
+	 * because we don't need any space. I really need to rethink that stuff
+	 * (TODO).
+	 */
+	down_write(&nxi->nx_big_sem);
+	if (!sb || sb->s_flags & SB_RDONLY) {
+		/* The commit already took place, or there was an abort */
+		up_write(&nxi->nx_big_sem);
+		return;
+	}
+
+	trans->t_state |= APFS_NX_TRANS_FORCE_COMMIT;
+	err = apfs_transaction_commit(sb);
+	if (err) {
+		apfs_err(sb, "queued commit failed (err:%d)", err);
+		apfs_transaction_abort(sb);
+	}
+}
+
+/**
+ * apfs_transaction_init - Initialize the transaction struct for the container
+ * @trans: the transaction structure
+ */
+void apfs_transaction_init(struct apfs_nx_transaction *trans)
+{
+	trans->t_state = 0;
+	INIT_DELAYED_WORK(&trans->t_work, apfs_trans_commit_work);
+	INIT_LIST_HEAD(&trans->t_inodes);
+	INIT_LIST_HEAD(&trans->t_buffers);
+	trans->t_buffers_count = 0;
+	trans->t_starts_count = 0;
+}
+
+/**
+ * apfs_transaction_start - Begin a new transaction
+ * @sb:		superblock structure
+ * @maxops:	maximum operations expected
+ *
+ * Also locks the filesystem for writing; returns 0 on success or a negative
+ * error code in case of failure.
+ */
+int apfs_transaction_start(struct super_block *sb, struct apfs_max_ops maxops)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_nx_transaction *nx_trans = &nxi->nx_transaction;
+	int err;
+
+	down_write(&nxi->nx_big_sem);
+
+	if (sb->s_flags & SB_RDONLY) {
+		/* A previous transaction has failed; this should be rare */
+		up_write(&nxi->nx_big_sem);
+		return -EROFS;
+	}
+
+	/*
+	 * Ephemeral objects are read only once, kept in memory, and committed
+	 * to disk along with each transaction.
+	 */
+	if (!nxi->nx_eph_list) {
+		err = apfs_read_ephemeral_objects(sb);
+		if (err) {
+			up_write(&nxi->nx_big_sem);
+			apfs_err(sb, "failed to read the ephemeral objects");
+			return err;
+		}
+	}
+
+	if (nx_trans->t_starts_count == 0) {
+		++nxi->nx_xid;
+		nxi->nx_raw->nx_next_xid = cpu_to_le64(nxi->nx_xid + 1);
+
+		err = apfs_read_spaceman(sb);
+		if (err) {
+			apfs_err(sb, "failed to read the spaceman");
+			goto fail;
+		}
+	}
+
+	/* Don't start transactions unless we are sure they fit in disk */
+	if (!apfs_transaction_has_room(sb, maxops)) {
+		/* Commit what we have so far to flush the queues */
+		nx_trans->t_state |= APFS_NX_TRANS_FORCE_COMMIT;
+		err = apfs_transaction_commit(sb);
+		if (err) {
+			apfs_err(sb, "commit failed");
+			goto fail;
+		}
+		return -ENOSPC;
+	}
+
+	if (nx_trans->t_starts_count == 0) {
+		err = apfs_map_volume_super(sb, true /* write */);
+		if (err) {
+			apfs_err(sb, "CoW failed for volume super");
+			goto fail;
+		}
+
+		/* TODO: don't copy these nodes for transactions that don't use them */
+		err = apfs_read_omap(sb, true /* write */);
+		if (err) {
+			apfs_err(sb, "CoW failed for omap");
+			goto fail;
+		}
+		err = apfs_read_catalog(sb, true /* write */);
+		if (err) {
+			apfs_err(sb, "Cow failed for catalog");
+			goto fail;
+		}
+	}
+
+	nx_trans->t_starts_count++;
+	return 0;
+
+fail:
+	apfs_transaction_abort(sb);
+	return err;
+}
+
+/**
+ * apfs_transaction_flush_all_inodes - Flush inode metadata to the buffer heads
+ * @sb: superblock structure
+ *
+ * This messes a lot with the disk layout, so it must be called ahead of time
+ * if we need it to be stable for the rest or the transaction (for example, if
+ * we are setting up a snapshot).
+ */
+int apfs_transaction_flush_all_inodes(struct super_block *sb)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_nx_transaction *nx_trans = &nxi->nx_transaction;
+	int err = 0, curr_err;
+
+	ASSERT(!(sb->s_flags & SB_RDONLY));
+
+	while (!list_empty(&nx_trans->t_inodes)) {
+		struct apfs_inode_info *ai = NULL;
+		struct inode *inode = NULL;
+
+		ai = list_first_entry(&nx_trans->t_inodes, struct apfs_inode_info, i_list);
+		inode = &ai->vfs_inode;
+
+		/* This is a bit wasteful if the inode will get deleted */
+		curr_err = apfs_update_inode(inode, NULL /* new_name */);
+		if (curr_err)
+			err = curr_err;
+		inode->i_state &= ~I_DIRTY_ALL;
+
+		/*
+		 * The same inode may get dirtied again as soon as we release
+		 * the lock, and we don't want to miss that.
+		 */
+		list_del_init(&ai->i_list);
+
+		nx_trans->t_state |= APFS_NX_TRANS_COMMITTING;
+		up_write(&nxi->nx_big_sem);
+
+		/* Unlocked, so it may call evict() and wait for writeback */
+		iput(inode);
+
+		down_write(&nxi->nx_big_sem);
+		nx_trans->t_state = 0;
+
+		/* Transaction aborted during writeback, error code is lost */
+		if (sb->s_flags & SB_RDONLY) {
+			apfs_err(sb, "abort during inode writeback");
+			return -EROFS;
+		}
+	}
+
+	return err;
+}
+
+/**
+ * apfs_write_single_ephemeral_object - Write a single ephemeral object to bh's
+ * @sb:		filesystem superblock
+ * @obj_raw:	contents of the object
+ * @map:	checkpoint mapping for the object, already updated
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_write_single_ephemeral_object(struct super_block *sb, struct apfs_obj_phys *obj_raw, const struct apfs_checkpoint_mapping *map)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_nx_superblock *raw_sb = NULL;
+	struct buffer_head *bh = NULL;
+	u64 data_base, bno;
+	u32 data_blks, size;
+	int err, i, data_idx;
+
+	raw_sb = nxi->nx_raw;
+	data_base = le64_to_cpu(raw_sb->nx_xp_data_base);
+	data_blks = le32_to_cpu(raw_sb->nx_xp_data_blocks);
+
+	bno = le64_to_cpu(map->cpm_paddr);
+	size = le32_to_cpu(map->cpm_size);
+	obj_raw->o_xid = cpu_to_le64(nxi->nx_xid);
+	apfs_multiblock_set_csum((char *)obj_raw, size);
+
+	data_idx = bno - data_base;
+	for (i = 0; i < size >> sb->s_blocksize_bits; ++i) {
+		bh = apfs_getblk(sb, data_base + data_idx);
+		if (!bh) {
+			apfs_err(sb, "failed to map ephemeral block");
+			return -EIO;
+		}
+		err = apfs_transaction_join(sb, bh);
+		if (err) {
+			brelse(bh);
+			bh = NULL;
+			return err;
+		}
+		memcpy(bh->b_data, (char *)obj_raw + (i << sb->s_blocksize_bits), sb->s_blocksize);
+		brelse(bh);
+		bh = NULL;
+		/* Somewhat surprisingly, objects can wrap around */
+		if (++data_idx == data_blks)
+			data_idx = 0;
+	}
+	return 0;
+}
+
+/**
+ * apfs_write_ephemeral_objects - Write all ephemeral objects to bh's
+ * @sb: filesystem superblock
+ *
+ * Returns 0 on sucess, or a negative error code in case of failure.
+ */
+static int apfs_write_ephemeral_objects(struct super_block *sb)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_nx_superblock *raw_sb = nxi->nx_raw;
+	struct apfs_checkpoint_map_phys *cpm = NULL;
+	struct buffer_head *cpm_bh = NULL;
+	struct apfs_ephemeral_object_info *eph_info = NULL;
+	u64 cpm_bno;
+	u64 desc_base, data_base;
+	u32 desc_index, desc_blks, desc_len, desc_next;
+	u32 data_index, data_blks, data_len, data_next;
+	u32 desc_limit, data_limit;
+	u32 obj_blkcnt;
+	int err, i, cpm_start;
+
+	if (!nxi->nx_eph_list) {
+		apfs_alert(sb, "missing ephemeral object list");
+		return -EFSCORRUPTED;
+	}
+
+	desc_next = le32_to_cpu(raw_sb->nx_xp_desc_next);
+	desc_base = le64_to_cpu(raw_sb->nx_xp_desc_base);
+	desc_index = desc_next; /* New checkpoint */
+	desc_blks = le32_to_cpu(raw_sb->nx_xp_desc_blocks);
+	desc_len = 0; /* For now */
+
+	data_next = le32_to_cpu(raw_sb->nx_xp_data_next);
+	data_base = le64_to_cpu(raw_sb->nx_xp_data_base);
+	data_index = data_next; /* New checkpoint */
+	data_blks = le32_to_cpu(raw_sb->nx_xp_data_blocks);
+	data_len = 0; /* For now */
+
+	/*
+	 * The reference doesn't mention anything about this, but I need to
+	 * put some sort of a limit or else the rings could wrap around and
+	 * corrupt themselves.
+	 */
+	desc_limit = desc_blks >> 2;
+	data_limit = data_blks >> 2;
+
+	for (i = 0; i < nxi->nx_eph_count; ++i) {
+		if (data_len == data_limit) {
+			apfs_err(sb, "too many checkpoint data blocks");
+			return -EFSCORRUPTED;
+		}
+
+		if (!cpm) {
+			cpm_start = i;
+			if (desc_len == desc_limit) {
+				apfs_err(sb, "too many checkpoint descriptor blocks");
+				return -EFSCORRUPTED;
+			}
+			cpm_bno = desc_base + (desc_index + desc_len) % desc_blks;
+			err = apfs_create_cpm_block(sb, cpm_bno, &cpm_bh);
+			if (err) {
+				apfs_err(sb, "failed to create cpm block");
+				return err;
+			}
+			cpm = (void *)cpm_bh->b_data;
+			desc_len += 1;
+		}
+
+		eph_info = &nxi->nx_eph_list[i];
+		data_next = (data_index + data_len) % data_blks;
+		obj_blkcnt = eph_info->size >> sb->s_blocksize_bits;
+
+		err = apfs_create_cpoint_map(sb, cpm, eph_info->object, data_base + data_next, eph_info->size);
+		if (err) {
+			if (err == -ENOSPC)
+				cpm->cpm_flags = 0; /* No longer the last */
+			brelse(cpm_bh);
+			cpm = NULL;
+			cpm_bh = NULL;
+			if (err == -ENOSPC) {
+				--i;
+				continue;
+			}
+			apfs_err(sb, "failed to create cpm map %d", i);
+			return err;
+		}
+		err = apfs_write_single_ephemeral_object(sb, eph_info->object, &cpm->cpm_map[i - cpm_start]);
+		if (err) {
+			brelse(cpm_bh);
+			cpm = NULL;
+			cpm_bh = NULL;
+			apfs_err(sb, "failed to write ephemeral object %d", i);
+			return err;
+		}
+		data_len += obj_blkcnt;
+	}
+
+	/*
+	 * The checkpoint superblock can't be set until the very end of the
+	 * transaction commit, but allocate its block here already.
+	 */
+	nxi->nx_bno = desc_base + (desc_index + desc_len) % desc_blks;
+	desc_len += 1;
+
+	desc_next = (desc_index + desc_len) % desc_blks;
+	data_next = (data_index + data_len) % data_blks;
+
+	raw_sb->nx_xp_desc_next = cpu_to_le32(desc_next);
+	raw_sb->nx_xp_desc_index = cpu_to_le32(desc_index);
+	raw_sb->nx_xp_desc_len = cpu_to_le32(desc_len);
+
+	raw_sb->nx_xp_data_next = cpu_to_le32(data_next);
+	raw_sb->nx_xp_data_index = cpu_to_le32(data_index);
+	raw_sb->nx_xp_data_len = cpu_to_le32(data_len);
+
+	return 0;
+}
+
+/**
+ * apfs_transaction_commit_nx - Definitely commit the current transaction
+ * @sb: superblock structure
+ */
+static int apfs_transaction_commit_nx(struct super_block *sb)
+{
+	struct apfs_spaceman *sm = APFS_SM(sb);
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_nx_transaction *nx_trans = &nxi->nx_transaction;
+	struct apfs_bh_info *bhi, *tmp;
+	int err = 0;
+
+	ASSERT(!(sb->s_flags & SB_RDONLY));
+
+	/* Before committing the bhs, write all inode metadata to them */
+	err = apfs_transaction_flush_all_inodes(sb);
+	if (err) {
+		apfs_err(sb, "failed to flush all inodes");
+		return err;
+	}
+
+	/*
+	 * Now that nothing else will be freed, flush the last update to the
+	 * free queues so that it can be committed to disk along with all the
+	 * ephemeral objects.
+	 */
+	if (sm->sm_free_cache_base) {
+		err = apfs_free_queue_insert_nocache(sb, sm->sm_free_cache_base, sm->sm_free_cache_blkcnt);
+		if (err) {
+			apfs_err(sb, "fq cache flush failed (0x%llx-0x%llx)", sm->sm_free_cache_base, sm->sm_free_cache_blkcnt);
+			return err;
+		}
+		sm->sm_free_cache_base = sm->sm_free_cache_blkcnt = 0;
+	}
+	/*
+	 * Writing the ip bitmaps modifies the spaceman, so it must happen
+	 * before we commit the ephemeral objects. It must also happen after we
+	 * flush the free queue, in case the last freed range was in the ip.
+	 */
+	err = apfs_write_ip_bitmaps(sb);
+	if (err) {
+		apfs_err(sb, "failed to commit the ip bitmaps");
+		return err;
+	}
+	err = apfs_write_ephemeral_objects(sb);
+	if (err)
+		return err;
+
+	list_for_each_entry(bhi, &nx_trans->t_buffers, list) {
+		struct buffer_head *bh = bhi->bh;
+
+		ASSERT(buffer_trans(bh));
+
+		if (buffer_csum(bh))
+			apfs_obj_set_csum(sb, (void *)bh->b_data);
+
+		clear_buffer_dirty(bh);
+		get_bh(bh);
+		lock_buffer(bh);
+		bh->b_end_io = end_buffer_write_sync;
+		apfs_submit_bh(REQ_OP_WRITE, REQ_SYNC, bh);
+	}
+	list_for_each_entry_safe(bhi, tmp, &nx_trans->t_buffers, list) {
+		struct buffer_head *bh = bhi->bh;
+		struct folio *folio = NULL;
+		bool is_metadata;
+
+		ASSERT(buffer_trans(bh));
+
+		wait_on_buffer(bh);
+		if (!buffer_uptodate(bh)) {
+			apfs_err(sb, "failed to write some blocks");
+			return -EIO;
+		}
+
+		list_del(&bhi->list);
+		clear_buffer_trans(bh);
+		nx_trans->t_buffers_count--;
+
+		bh->b_private = NULL;
+		bhi->bh = NULL;
+		kfree(bhi);
+		bhi = NULL;
+
+		folio = page_folio(bh->b_page);
+		folio_get(folio);
+
+		is_metadata = buffer_csum(bh);
+		clear_buffer_csum(bh);
+		put_bh(bh);
+		bh = NULL;
+
+		folio_lock(folio);
+		folio_mkclean(folio);
+
+		/* XXX: otherwise, the page cache fills up and crashes the machine */
+		if (!is_metadata) {
+			try_to_free_buffers(folio);
+		}
+		folio_unlock(folio);
+		folio_put(folio);
+	}
+	err = apfs_checkpoint_end(sb);
+	if (err) {
+		apfs_err(sb, "failed to end the checkpoint");
+		return err;
+	}
+
+	nx_trans->t_starts_count = 0;
+	nx_trans->t_buffers_count = 0;
+	return 0;
+}
+
+/**
+ * apfs_transaction_need_commit - Evaluate if a commit is required
+ * @sb: superblock structure
+ */
+static bool apfs_transaction_need_commit(struct super_block *sb)
+{
+	struct apfs_spaceman *sm = APFS_SM(sb);
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_nx_transaction *nx_trans = &nxi->nx_transaction;
+
+	if (nx_trans->t_state & APFS_NX_TRANS_DEFER_COMMIT) {
+		nx_trans->t_state &= ~APFS_NX_TRANS_DEFER_COMMIT;
+		return false;
+	}
+
+	/* Avoid nested commits on inode writeback */
+	if (nx_trans->t_state & APFS_NX_TRANS_COMMITTING)
+		return false;
+
+	if (nx_trans->t_state & APFS_NX_TRANS_FORCE_COMMIT) {
+		nx_trans->t_state = 0;
+		return true;
+	}
+
+	if (sm) {
+		struct apfs_spaceman_phys *sm_raw = sm->sm_raw;
+		struct apfs_spaceman_free_queue *fq_ip = &sm_raw->sm_fq[APFS_SFQ_IP];
+		struct apfs_spaceman_free_queue *fq_main = &sm_raw->sm_fq[APFS_SFQ_MAIN];
+		int buffers_max = nxi->nx_trans_buffers_max;
+		int starts_max = APFS_TRANS_STARTS_MAX;
+		int mq_max = APFS_TRANS_MAIN_QUEUE_MAX;
+
+		/*
+		 * Try to avoid committing halfway through a data block write,
+		 * otherwise the block will be put through copy-on-write again,
+		 * causing unnecessary fragmentation.
+		 */
+		if (nx_trans->t_state & APFS_NX_TRANS_INCOMPLETE_BLOCK) {
+			buffers_max += 50;
+			starts_max += 50;
+			mq_max += 20;
+		}
+
+		if (nx_trans->t_buffers_count > buffers_max)
+			return true;
+		if (nx_trans->t_starts_count > starts_max)
+			return true;
+
+		/*
+		 * The internal pool has enough blocks to map the container
+		 * exactly 3 times. Don't allow large transactions if we can't
+		 * be sure the bitmap changes will all fit.
+		 */
+		if (le64_to_cpu(fq_ip->sfq_count) * 3 > le64_to_cpu(sm_raw->sm_ip_block_count))
+			return true;
+
+		/* Don't let the main queue get too full either */
+		if (le64_to_cpu(fq_main->sfq_count) > mq_max)
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ * apfs_transaction_commit - Possibly commit the current transaction
+ * @sb: superblock structure
+ *
+ * On success returns 0 and releases the big filesystem lock. On failure,
+ * returns a negative error code, and the caller is responsibly for aborting
+ * the transaction.
+ */
+int apfs_transaction_commit(struct super_block *sb)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_nx_transaction *trans = NULL;
+	int err = 0;
+
+	trans = &nxi->nx_transaction;
+
+	if (apfs_transaction_need_commit(sb)) {
+		err = apfs_transaction_commit_nx(sb);
+		if (err) {
+			apfs_err(sb, "transaction commit failed");
+			return err;
+		}
+		trans->t_work_sb = NULL;
+		cancel_delayed_work(&trans->t_work);
+	} else {
+		trans->t_work_sb = sb;
+		mod_delayed_work(system_wq, &trans->t_work, msecs_to_jiffies(100));
+	}
+
+	up_write(&nxi->nx_big_sem);
+	return 0;
+}
+
+/**
+ * apfs_inode_join_transaction - Add an inode to the current transaction
+ * @sb:		superblock structure
+ * @inode:	vfs inode to add
+ */
+void apfs_inode_join_transaction(struct super_block *sb, struct inode *inode)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_nx_transaction *nx_trans = &nxi->nx_transaction;
+	struct apfs_inode_info *ai = APFS_I(inode);
+
+	ASSERT(!(sb->s_flags & SB_RDONLY));
+	lockdep_assert_held_write(&nxi->nx_big_sem);
+
+	if (!list_empty(&ai->i_list)) /* Already in the transaction */
+		return;
+
+	ihold(inode);
+	list_add(&ai->i_list, &nx_trans->t_inodes);
+}
+
+/**
+ * apfs_transaction_join - Add a buffer head to the current transaction
+ * @sb:	superblock structure
+ * @bh:	the buffer head
+ */
+int apfs_transaction_join(struct super_block *sb, struct buffer_head *bh)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_nx_transaction *nx_trans = &nxi->nx_transaction;
+	struct apfs_bh_info *bhi;
+
+	ASSERT(!(sb->s_flags & SB_RDONLY));
+	lockdep_assert_held_write(&nxi->nx_big_sem);
+
+	if (buffer_trans(bh)) /* Already part of the only transaction */
+		return 0;
+
+	/* TODO: use a slab cache */
+	bhi = kzalloc(sizeof(*bhi), GFP_NOFS);
+	if (!bhi)
+		return -ENOMEM;
+	get_bh(bh);
+	bhi->bh = bh;
+	list_add(&bhi->list, &nx_trans->t_buffers);
+	nx_trans->t_buffers_count++;
+
+	set_buffer_trans(bh);
+	bh->b_private = bhi;
+	return 0;
+}
+
+/**
+ * apfs_force_readonly - Set the whole container as read-only
+ * @nxi: container superblock info
+ */
+static void apfs_force_readonly(struct apfs_nxsb_info *nxi)
+{
+	struct apfs_sb_info *sbi = NULL;
+	struct super_block *sb = NULL;
+
+	list_for_each_entry(sbi, &nxi->vol_list, list) {
+		sb = sbi->s_vobject.sb;
+		sb->s_flags |= SB_RDONLY;
+	}
+	nxi->nx_flags &= ~APFS_READWRITE;
+}
+
+/**
+ * apfs_transaction_abort - Abort the current transaction
+ * @sb: superblock structure
+ *
+ * Releases the big filesystem lock and clears the in-memory transaction data;
+ * the on-disk changes are irrelevant because the superblock checksum hasn't
+ * been written yet. Leaves the filesystem in read-only state.
+ */
+void apfs_transaction_abort(struct super_block *sb)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_nx_transaction *nx_trans = &nxi->nx_transaction;
+	struct apfs_bh_info *bhi, *tmp;
+	struct apfs_inode_info *ai, *ai_tmp;
+
+	if (sb->s_flags & SB_RDONLY) {
+		/* Transaction already aborted, do nothing */
+		ASSERT(list_empty(&nx_trans->t_inodes));
+		ASSERT(list_empty(&nx_trans->t_buffers));
+		up_write(&nxi->nx_big_sem);
+		return;
+	}
+
+	nx_trans->t_state = 0;
+	apfs_err(sb, "aborting transaction");
+
+	--nxi->nx_xid;
+	list_for_each_entry_safe(bhi, tmp, &nx_trans->t_buffers, list) {
+		struct buffer_head *bh = bhi->bh;
+
+		bh->b_private = NULL;
+		clear_buffer_dirty(bh);
+		clear_buffer_trans(bh);
+		clear_buffer_csum(bh);
+		brelse(bh);
+		bhi->bh = NULL;
+
+		list_del(&bhi->list);
+		kfree(bhi);
+	}
+
+	/*
+	 * It's not possible to undo in-memory changes from old operations in
+	 * the aborted transaction. To avoid corruption, never write again.
+	 */
+	apfs_force_readonly(nxi);
+
+	up_write(&nxi->nx_big_sem);
+
+	list_for_each_entry_safe(ai, ai_tmp, &nx_trans->t_inodes, i_list) {
+		list_del_init(&ai->i_list);
+		iput(&ai->vfs_inode);
+	}
+}
diff --git a/drivers/staging/apfs/xattr.c b/drivers/staging/apfs/xattr.c
new file mode 100644
index 0000000000000000000000000000000000000000..e856556e76fa4afa71d67046defc3f0a067c27eb
--- /dev/null
+++ b/drivers/staging/apfs/xattr.c
@@ -0,0 +1,912 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2018 Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
+ * Copyright (C) 2025 Ethan Carter Edwards <ethan@ethancedwards.com>
+ */
+
+#include <linux/buffer_head.h>
+#include <linux/xattr.h>
+#include <linux/blk_types.h>
+#include "apfs.h"
+
+/**
+ * apfs_xattr_from_query - Read the xattr record found by a successful query
+ * @query:	the query that found the record
+ * @xattr:	Return parameter.  The xattr record found.
+ *
+ * Reads the xattr record into @xattr and performs some basic sanity checks
+ * as a protection against crafted filesystems.  Returns 0 on success or
+ * -EFSCORRUPTED otherwise.
+ *
+ * The caller must not free @query while @xattr is in use, because @xattr->name
+ * and @xattr->xdata point to data on disk.
+ */
+static int apfs_xattr_from_query(struct apfs_query *query,
+				 struct apfs_xattr *xattr)
+{
+	struct super_block *sb = query->node->object.sb;
+	struct apfs_xattr_val *xattr_val;
+	struct apfs_xattr_key *xattr_key;
+	char *raw = query->node->object.data;
+	int datalen = query->len - sizeof(*xattr_val);
+	int namelen = query->key_len - sizeof(*xattr_key);
+
+	if (namelen < 1 || datalen < 0) {
+		apfs_err(sb, "bad length of name (%d) or data (%d)", namelen, datalen);
+		return -EFSCORRUPTED;
+	}
+
+	xattr_val = (struct apfs_xattr_val *)(raw + query->off);
+	xattr_key = (struct apfs_xattr_key *)(raw + query->key_off);
+
+	if (namelen != le16_to_cpu(xattr_key->name_len)) {
+		apfs_err(sb, "inconsistent name length (%d vs %d)", namelen, le16_to_cpu(xattr_key->name_len));
+		return -EFSCORRUPTED;
+	}
+
+	/* The xattr name must be NULL-terminated */
+	if (xattr_key->name[namelen - 1] != 0) {
+		apfs_err(sb, "null termination missing");
+		return -EFSCORRUPTED;
+	}
+
+	xattr->has_dstream = le16_to_cpu(xattr_val->flags) &
+			     APFS_XATTR_DATA_STREAM;
+
+	if (xattr->has_dstream && datalen != sizeof(struct apfs_xattr_dstream)) {
+		apfs_err(sb, "bad data length (%d)", datalen);
+		return -EFSCORRUPTED;
+	}
+	if (!xattr->has_dstream && datalen != le16_to_cpu(xattr_val->xdata_len)) {
+		apfs_err(sb, "inconsistent data length (%d vs %d)", datalen, le16_to_cpu(xattr_val->xdata_len));
+		return -EFSCORRUPTED;
+	}
+
+	xattr->name = xattr_key->name;
+	xattr->name_len = namelen - 1; /* Don't count the NULL termination */
+	xattr->xdata = xattr_val->xdata;
+	xattr->xdata_len = datalen;
+	return 0;
+}
+
+/**
+ * apfs_dstream_from_xattr - Get the dstream info for a dstream xattr
+ * @sb:		filesystem superblock
+ * @xattr:	in-memory xattr record (already sanity-checked)
+ * @dstream:	on return, the data stream info
+ */
+static void apfs_dstream_from_xattr(struct super_block *sb, struct apfs_xattr *xattr, struct apfs_dstream_info *dstream)
+{
+	struct apfs_xattr_dstream *xdata = (void *)xattr->xdata;
+
+	dstream->ds_sb = sb;
+	dstream->ds_inode = NULL;
+	dstream->ds_id = le64_to_cpu(xdata->xattr_obj_id);
+	dstream->ds_size = le64_to_cpu(xdata->dstream.size);
+	dstream->ds_sparse_bytes = 0; /* Irrelevant for xattrs */
+
+	dstream->ds_cached_ext.len = 0;
+	dstream->ds_ext_dirty = false;
+	spin_lock_init(&dstream->ds_ext_lock);
+
+	/* Xattrs can't be cloned */
+	dstream->ds_shared = false;
+}
+
+/**
+ * apfs_xattr_extents_read - Read the value of a xattr from its extents
+ * @parent:	inode the attribute belongs to
+ * @xattr:	the xattr structure
+ * @buffer:	where to copy the attribute value
+ * @size:	size of @buffer
+ * @only_whole:	are partial reads banned?
+ *
+ * Copies the value of @xattr to @buffer, if provided. If @buffer is NULL, just
+ * computes the size of the buffer required.
+ *
+ * Returns the number of bytes used/required, or a negative error code in case
+ * of failure.
+ */
+static int apfs_xattr_extents_read(struct inode *parent,
+				   struct apfs_xattr *xattr,
+				   void *buffer, size_t size, bool only_whole)
+{
+	struct super_block *sb = parent->i_sb;
+	struct apfs_dstream_info *dstream;
+	int length, ret;
+
+	dstream = kzalloc(sizeof(*dstream), GFP_KERNEL);
+	if (!dstream)
+		return -ENOMEM;
+	apfs_dstream_from_xattr(sb, xattr, dstream);
+
+	length = dstream->ds_size;
+	if (length < 0 || length < dstream->ds_size) {
+		/* TODO: avoid overflow here for huge compressed files */
+		apfs_warn(sb, "xattr is too big to read on linux (0x%llx)", dstream->ds_size);
+		ret = -E2BIG;
+		goto out;
+	}
+
+	if (!buffer) {
+		/* All we want is the length */
+		ret = length;
+		goto out;
+	}
+
+	if (only_whole) {
+		if (length > size) {
+			/* xattr won't fit in the buffer */
+			ret = -ERANGE;
+			goto out;
+		}
+	} else {
+		if (length > size)
+			length = size;
+	}
+
+	ret = apfs_nonsparse_dstream_read(dstream, buffer, length, 0 /* offset */);
+	if (ret == 0)
+		ret = length;
+
+out:
+	kfree(dstream);
+	return ret;
+}
+
+/**
+ * apfs_xattr_inline_read - Read the value of an inline xattr
+ * @xattr:	the xattr structure
+ * @buffer:	where to copy the attribute value
+ * @size:	size of @buffer
+ * @only_whole:	are partial reads banned?
+ *
+ * Copies the inline value of @xattr to @buffer, if provided. If @buffer is
+ * NULL, just computes the size of the buffer required.
+ *
+ * Returns the number of bytes used/required, or a negative error code in case
+ * of failure.
+ */
+static int apfs_xattr_inline_read(struct apfs_xattr *xattr, void *buffer, size_t size, bool only_whole)
+{
+	int length = xattr->xdata_len;
+
+	if (!buffer) /* All we want is the length */
+		return length;
+	if (only_whole) {
+		if (length > size) /* xattr won't fit in the buffer */
+			return -ERANGE;
+	} else {
+		if (length > size)
+			length = size;
+	}
+	memcpy(buffer, xattr->xdata, length);
+	return length;
+}
+
+/**
+ * apfs_xattr_get_compressed_data - Get the compressed data in a named attribute
+ * @inode:	inode the attribute belongs to
+ * @name:	name of the attribute
+ * @cdata:	compressed data struct to set on return
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+int apfs_xattr_get_compressed_data(struct inode *inode, const char *name, struct apfs_compressed_data *cdata)
+{
+	struct super_block *sb = inode->i_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_query *query;
+	struct apfs_xattr xattr;
+	u64 cnid = apfs_ino(inode);
+	int ret;
+
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_xattr_key(cnid, name, &query->key);
+	query->flags |= APFS_QUERY_CAT | APFS_QUERY_EXACT;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret) {
+		apfs_err(sb, "query failed for id 0x%llx (%s)", cnid, name);
+		goto done;
+	}
+
+	ret = apfs_xattr_from_query(query, &xattr);
+	if (ret) {
+		apfs_err(sb, "bad xattr record in inode 0x%llx", cnid);
+		goto done;
+	}
+
+	cdata->has_dstream = xattr.has_dstream;
+	if (cdata->has_dstream) {
+		struct apfs_dstream_info *dstream = NULL;
+
+		dstream = kzalloc(sizeof(*dstream), GFP_KERNEL);
+		if (!dstream) {
+			ret = -ENOMEM;
+			goto done;
+		}
+		apfs_dstream_from_xattr(sb, &xattr, dstream);
+
+		cdata->dstream = dstream;
+		cdata->size = dstream->ds_size;
+	} else {
+		void *data = NULL;
+		int len;
+
+		len = xattr.xdata_len;
+		if (len > APFS_XATTR_MAX_EMBEDDED_SIZE) {
+			apfs_err(sb, "inline xattr too big");
+			ret = -EFSCORRUPTED;
+			goto done;
+		}
+		data = kzalloc(len, GFP_KERNEL);
+		if (!data) {
+			ret = -ENOMEM;
+			goto done;
+		}
+		memcpy(data, xattr.xdata, len);
+
+		cdata->data = data;
+		cdata->size = len;
+	}
+	ret = 0;
+
+done:
+	apfs_free_query(query);
+	return ret;
+}
+
+/**
+ * apfs_release_compressed_data - Clean up a compressed data struct
+ * @cdata: struct to clean up (but not free)
+ */
+void apfs_release_compressed_data(struct apfs_compressed_data *cdata)
+{
+	if (!cdata)
+		return;
+
+	if (cdata->has_dstream) {
+		kfree(cdata->dstream);
+		cdata->dstream = NULL;
+	} else {
+		kfree(cdata->data);
+		cdata->data = NULL;
+	}
+}
+
+/**
+ * apfs_compressed_data_read - Read from a compressed data struct
+ * @cdata:	compressed data struct
+ * @buf:	destination buffer
+ * @count:	exact number of bytes to read
+ * @offset:	dstream offset to read from
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+int apfs_compressed_data_read(struct apfs_compressed_data *cdata, void *buf, size_t count, u64 offset)
+{
+	if (cdata->has_dstream)
+		return apfs_nonsparse_dstream_read(cdata->dstream, buf, count, offset);
+
+	if (offset > cdata->size || count > cdata->size - offset) {
+		apfs_err(NULL, "reading past the end (0x%llx-0x%llx)", offset, (unsigned long long)count);
+		/* No caller is expected to legitimately read out-of-bounds */
+		return -EFSCORRUPTED;
+	}
+	memcpy(buf, cdata->data + offset, count);
+	return 0;
+}
+
+/**
+ * __apfs_xattr_get - Find and read a named attribute
+ * @inode:	inode the attribute belongs to
+ * @name:	name of the attribute
+ * @buffer:	where to copy the attribute value
+ * @size:	size of @buffer
+ *
+ * This does the same as apfs_xattr_get(), but without taking any locks.
+ */
+int __apfs_xattr_get(struct inode *inode, const char *name, void *buffer,
+		     size_t size)
+{
+	return ____apfs_xattr_get(inode, name, buffer, size, true /* only_whole */);
+}
+
+/**
+ * ____apfs_xattr_get - Find and read a named attribute, optionally header only
+ * @inode:	inode the attribute belongs to
+ * @name:	name of the attribute
+ * @buffer:	where to copy the attribute value
+ * @size:	size of @buffer
+ * @only_whole:	must read complete (no partial header read allowed)
+ */
+int ____apfs_xattr_get(struct inode *inode, const char *name, void *buffer,
+		       size_t size, bool only_whole)
+{
+	struct super_block *sb = inode->i_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_query *query;
+	struct apfs_xattr xattr;
+	u64 cnid = apfs_ino(inode);
+	int ret;
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_xattr_key(cnid, name, &query->key);
+	query->flags |= APFS_QUERY_CAT | APFS_QUERY_EXACT;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret) {
+		if (ret != -ENODATA)
+			apfs_err(sb, "query failed for id 0x%llx (%s)", cnid, name);
+		goto done;
+	}
+
+	ret = apfs_xattr_from_query(query, &xattr);
+	if (ret) {
+		apfs_err(sb, "bad xattr record in inode 0x%llx", cnid);
+		goto done;
+	}
+
+	if (xattr.has_dstream)
+		ret = apfs_xattr_extents_read(inode, &xattr, buffer, size, only_whole);
+	else
+		ret = apfs_xattr_inline_read(&xattr, buffer, size, only_whole);
+
+done:
+	apfs_free_query(query);
+	return ret;
+}
+
+/**
+ * apfs_xattr_get - Find and read a named attribute
+ * @inode:	inode the attribute belongs to
+ * @name:	name of the attribute
+ * @buffer:	where to copy the attribute value
+ * @size:	size of @buffer
+ *
+ * Finds an extended attribute and copies its value to @buffer, if provided. If
+ * @buffer is NULL, just computes the size of the buffer required.
+ *
+ * Returns the number of bytes used/required, or a negative error code in case
+ * of failure.
+ */
+static int apfs_xattr_get(struct inode *inode, const char *name, void *buffer, size_t size)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(inode->i_sb);
+	int ret;
+
+	down_read(&nxi->nx_big_sem);
+	ret = __apfs_xattr_get(inode, name, buffer, size);
+	up_read(&nxi->nx_big_sem);
+	if (ret > XATTR_SIZE_MAX) {
+		apfs_warn(inode->i_sb, "xattr is too big to read on linux (%d)", ret);
+		return -E2BIG;
+	}
+	return ret;
+}
+
+static int apfs_xattr_osx_get(const struct xattr_handler *handler,
+				struct dentry *unused, struct inode *inode,
+				const char *name, void *buffer, size_t size)
+{
+	/* Ignore the fake 'osx' prefix */
+	return apfs_xattr_get(inode, name, buffer, size);
+}
+
+/**
+ * apfs_delete_xattr - Delete an extended attribute
+ * @query:	successful query pointing to the xattr to delete
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+static int apfs_delete_xattr(struct apfs_query *query)
+{
+	struct super_block *sb = query->node->object.sb;
+	struct apfs_xattr xattr;
+	struct apfs_dstream_info *dstream;
+	int err;
+
+	err = apfs_xattr_from_query(query, &xattr);
+	if (err) {
+		apfs_err(sb, "bad xattr record");
+		return err;
+	}
+
+	if (!xattr.has_dstream)
+		return apfs_btree_remove(query);
+
+	dstream = kzalloc(sizeof(*dstream), GFP_KERNEL);
+	if (!dstream)
+		return -ENOMEM;
+	apfs_dstream_from_xattr(sb, &xattr, dstream);
+
+	/*
+	 * Remove the xattr record before truncation, because truncation creates
+	 * new queries and makes ours invalid. This stuff is all too subtle, I
+	 * really need to add some assertions (TODO).
+	 */
+	err = apfs_btree_remove(query);
+	if (err) {
+		apfs_err(sb, "removal failed");
+		goto fail;
+	}
+	err = apfs_truncate(dstream, 0);
+	if (err)
+		apfs_err(sb, "truncation failed for dstream 0x%llx", dstream->ds_id);
+
+fail:
+	kfree(dstream);
+	return err;
+}
+
+/**
+ * apfs_delete_any_xattr - Delete any single xattr for a given inode
+ * @inode: the vfs inode
+ *
+ * Intended to be called repeatedly, to delete all the xattrs one by one.
+ * Returns -EAGAIN on success until the process is complete, then it returns
+ * 0. Returns other negative error codes in case of failure.
+ */
+static int apfs_delete_any_xattr(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_query *query;
+	int ret;
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query)
+		return -ENOMEM;
+	apfs_init_xattr_key(apfs_ino(inode), NULL /* name */, &query->key);
+	query->flags = APFS_QUERY_CAT | APFS_QUERY_ANY_NAME | APFS_QUERY_EXACT;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret) {
+		if (ret == -ENODATA)
+			ret = 0; /* No more xattrs, we are done */
+		else
+			apfs_err(sb, "query failed for ino 0x%llx", apfs_ino(inode));
+		goto out;
+	}
+
+	ret = apfs_delete_xattr(query);
+	if (!ret)
+		ret = -EAGAIN;
+	else
+		apfs_err(sb, "xattr deletion failed");
+
+out:
+	apfs_free_query(query);
+	return ret;
+}
+
+/**
+ * apfs_delete_all_xattrs - Delete all xattrs for a given inode
+ * @inode: the vfs inode
+ *
+ * Returns 0 on success or a negative error code in case of failure.
+ */
+int apfs_delete_all_xattrs(struct inode *inode)
+{
+	struct apfs_nxsb_info *nxi = APFS_NXI(inode->i_sb);
+	int ret;
+
+	lockdep_assert_held_write(&nxi->nx_big_sem);
+
+	do {
+		ret = apfs_delete_any_xattr(inode);
+	} while (ret == -EAGAIN);
+
+	return ret;
+}
+
+/**
+ * apfs_build_xattr_key - Allocate and initialize the key for a xattr record
+ * @name:	xattr name
+ * @ino:	inode number for xattr's owner
+ * @key_p:	on return, a pointer to the new on-disk key structure
+ *
+ * Returns the length of the key, or a negative error code in case of failure.
+ */
+static int apfs_build_xattr_key(const char *name, u64 ino, struct apfs_xattr_key **key_p)
+{
+	struct apfs_xattr_key *key;
+	u16 namelen = strlen(name) + 1; /* We count the null-termination */
+	int key_len;
+
+	key_len = sizeof(*key) + namelen;
+	key = kmalloc(key_len, GFP_KERNEL);
+	if (!key)
+		return -ENOMEM;
+
+	apfs_key_set_hdr(APFS_TYPE_XATTR, ino, key);
+	key->name_len = cpu_to_le16(namelen);
+	strscpy(key->name, name, namelen);
+
+	*key_p = key;
+	return key_len;
+}
+
+/**
+ * apfs_build_dstream_xattr_val - Allocate and init value for a dstream xattr
+ * @dstream:	data stream info
+ * @val_p:	on return, a pointer to the new on-disk value structure
+ *
+ * Returns the length of the value, or a negative error code in case of failure.
+ */
+static int apfs_build_dstream_xattr_val(struct apfs_dstream_info *dstream, struct apfs_xattr_val **val_p)
+{
+	struct apfs_xattr_val *val;
+	struct apfs_xattr_dstream *dstream_raw;
+	int val_len;
+
+	val_len = sizeof(*val) + sizeof(*dstream_raw);
+	val = kzalloc(val_len, GFP_KERNEL);
+	if (!val)
+		return -ENOMEM;
+
+	val->flags = cpu_to_le16(APFS_XATTR_DATA_STREAM);
+	val->xdata_len = cpu_to_le16(sizeof(*dstream_raw));
+
+	dstream_raw = (void *)val->xdata;
+	dstream_raw->xattr_obj_id = cpu_to_le64(dstream->ds_id);
+	dstream_raw->dstream.size = cpu_to_le64(dstream->ds_size);
+	dstream_raw->dstream.alloced_size = cpu_to_le64(apfs_alloced_size(dstream));
+	if (apfs_vol_is_encrypted(dstream->ds_sb))
+		dstream_raw->dstream.default_crypto_id = cpu_to_le64(dstream->ds_id);
+
+	*val_p = val;
+	return val_len;
+}
+
+/**
+ * apfs_build_inline_xattr_val - Allocate and init value for an inline xattr
+ * @value:	content of the xattr
+ * @size:	size of @value
+ * @val_p:	on return, a pointer to the new on-disk value structure
+ *
+ * Returns the length of the value, or a negative error code in case of failure.
+ */
+static int apfs_build_inline_xattr_val(const void *value, size_t size, struct apfs_xattr_val **val_p)
+{
+	struct apfs_xattr_val *val;
+	int val_len;
+
+	val_len = sizeof(*val) + size;
+	val = kmalloc(val_len, GFP_KERNEL);
+	if (!val)
+		return -ENOMEM;
+
+	val->flags = cpu_to_le16(APFS_XATTR_DATA_EMBEDDED);
+	val->xdata_len = cpu_to_le16(size);
+	memcpy(val->xdata, value, size);
+
+	*val_p = val;
+	return val_len;
+}
+
+/**
+ * apfs_create_xattr_dstream - Create the extents for a dstream xattr
+ * @sb:		filesystem superblock
+ * @value:	value for the attribute
+ * @size:	sizeo of @value
+ *
+ * Returns the info for the created data stream, or an error pointer in case
+ * of failure.
+ */
+static struct apfs_dstream_info *apfs_create_xattr_dstream(struct super_block *sb, const void *value, size_t size)
+{
+	struct apfs_superblock *vsb_raw = APFS_SB(sb)->s_vsb_raw;
+	struct apfs_dstream_info *dstream;
+	int blkcnt, i;
+	int err;
+
+	dstream = kzalloc(sizeof(*dstream), GFP_KERNEL);
+	if (!dstream)
+		return ERR_PTR(-ENOMEM);
+	dstream->ds_sb = sb;
+	spin_lock_init(&dstream->ds_ext_lock);
+
+	apfs_assert_in_transaction(sb, &vsb_raw->apfs_o);
+	dstream->ds_id = le64_to_cpu(vsb_raw->apfs_next_obj_id);
+	le64_add_cpu(&vsb_raw->apfs_next_obj_id, 1);
+
+	blkcnt = (size + sb->s_blocksize - 1) >> sb->s_blocksize_bits;
+	for (i = 0; i < blkcnt; i++) {
+		struct buffer_head *bh;
+		int off, tocopy;
+		u64 bno;
+
+		err = apfs_dstream_get_new_bno(dstream, i, &bno);
+		if (err) {
+			apfs_err(sb, "failed to get new block in dstream 0x%llx", dstream->ds_id);
+			goto fail;
+		}
+		bh = apfs_sb_bread(sb, bno);
+		if (!bh) {
+			apfs_err(sb, "failed to read new block");
+			err = -EIO;
+			goto fail;
+		}
+
+		err = apfs_transaction_join(sb, bh);
+		if (err) {
+			brelse(bh);
+			goto fail;
+		}
+
+		off = i << sb->s_blocksize_bits;
+		tocopy = min(sb->s_blocksize, (unsigned long)(size - off));
+		memcpy(bh->b_data, value + off, tocopy);
+		if (tocopy < sb->s_blocksize)
+			memset(bh->b_data + tocopy, 0, sb->s_blocksize - tocopy);
+		brelse(bh);
+
+		dstream->ds_size += tocopy;
+	}
+
+	err = apfs_flush_extent_cache(dstream);
+	if (err) {
+		apfs_err(sb, "extent cache flush failed for dstream 0x%llx", dstream->ds_id);
+		goto fail;
+	}
+	return dstream;
+
+fail:
+	kfree(dstream);
+	return ERR_PTR(err);
+}
+
+/**
+ * apfs_xattr_dstream_from_query - Extract the dstream from a xattr record
+ * @query:	the query that found the record
+ * @dstream_p:	on return, the newly allocated dstream info (or NULL if none)
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+static int apfs_xattr_dstream_from_query(struct apfs_query *query, struct apfs_dstream_info **dstream_p)
+{
+	struct super_block *sb = query->node->object.sb;
+	struct apfs_dstream_info *dstream = NULL;
+	struct apfs_xattr xattr;
+	int err;
+
+	err = apfs_xattr_from_query(query, &xattr);
+	if (err) {
+		apfs_err(sb, "bad xattr record");
+		return err;
+	}
+
+	if (xattr.has_dstream) {
+		dstream = kzalloc(sizeof(*dstream), GFP_KERNEL);
+		if (!dstream)
+			return -ENOMEM;
+		apfs_dstream_from_xattr(sb, &xattr, dstream);
+	}
+	*dstream_p = dstream;
+	return 0;
+}
+
+/**
+ * apfs_xattr_set - Write a named attribute
+ * @inode:	inode the attribute will belong to
+ * @name:	name for the attribute
+ * @value:	value for the attribute
+ * @size:	size of @value
+ * @flags:	XATTR_REPLACE and XATTR_CREATE
+ *
+ * Returns 0 on success, or a negative error code in case of failure.
+ */
+int apfs_xattr_set(struct inode *inode, const char *name, const void *value,
+		   size_t size, int flags)
+{
+	struct super_block *sb = inode->i_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_query *query = NULL;
+	u64 cnid = apfs_ino(inode);
+	int key_len, val_len;
+	struct apfs_xattr_key *raw_key = NULL;
+	struct apfs_xattr_val *raw_val = NULL;
+	struct apfs_dstream_info *dstream = NULL;
+	struct apfs_dstream_info *old_dstream = NULL;
+	int ret;
+
+	if (size > APFS_XATTR_MAX_EMBEDDED_SIZE) {
+		dstream = apfs_create_xattr_dstream(sb, value, size);
+		if (IS_ERR(dstream)) {
+			apfs_err(sb, "failed to set xattr dstream for ino 0x%llx", apfs_ino(inode));
+			return PTR_ERR(dstream);
+		}
+	}
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query) {
+		ret = -ENOMEM;
+		goto done;
+	}
+	apfs_init_xattr_key(cnid, name, &query->key);
+	query->flags = APFS_QUERY_CAT | APFS_QUERY_EXACT;
+
+	ret = apfs_btree_query(sb, &query);
+	if (ret) {
+		if (ret != -ENODATA) {
+			apfs_err(sb, "query failed for id 0x%llx (%s)", cnid, name);
+			goto done;
+		} else if (flags & XATTR_REPLACE) {
+			goto done;
+		}
+	} else if (flags & XATTR_CREATE) {
+		ret = -EEXIST;
+		goto done;
+	} else if (!value) {
+		ret = apfs_delete_xattr(query);
+		if (ret)
+			apfs_err(sb, "xattr deletion failed");
+		goto done;
+	} else {
+		/* Remember the old dstream to clean it up later */
+		ret = apfs_xattr_dstream_from_query(query, &old_dstream);
+		if (ret) {
+			apfs_err(sb, "failed to get the old dstream");
+			goto done;
+		}
+	}
+
+	key_len = apfs_build_xattr_key(name, cnid, &raw_key);
+	if (key_len < 0) {
+		ret = key_len;
+		goto done;
+	}
+
+	if (dstream)
+		val_len = apfs_build_dstream_xattr_val(dstream, &raw_val);
+	else
+		val_len = apfs_build_inline_xattr_val(value, size, &raw_val);
+	if (val_len < 0) {
+		ret = val_len;
+		goto done;
+	}
+
+	/* For now this is the only system xattr we support */
+	if (strcmp(name, APFS_XATTR_NAME_SYMLINK) == 0)
+		raw_val->flags |= cpu_to_le16(APFS_XATTR_FILE_SYSTEM_OWNED);
+
+	if (ret)
+		ret = apfs_btree_insert(query, raw_key, key_len, raw_val, val_len);
+	else
+		ret = apfs_btree_replace(query, raw_key, key_len, raw_val, val_len);
+	if (ret) {
+		apfs_err(sb, "insertion/update failed for id 0x%llx (%s)", cnid, name);
+		goto done;
+	}
+
+	if (old_dstream) {
+		ret = apfs_truncate(old_dstream, 0);
+		if (ret)
+			apfs_err(sb, "truncation failed for dstream 0x%llx", old_dstream->ds_id);
+	}
+
+done:
+	kfree(dstream);
+	kfree(old_dstream);
+	kfree(raw_val);
+	kfree(raw_key);
+	apfs_free_query(query);
+	return ret;
+}
+int APFS_XATTR_SET_MAXOPS(void)
+{
+	return 1;
+}
+
+static int apfs_xattr_osx_set(const struct xattr_handler *handler,
+		  struct mnt_idmap *idmap, struct dentry *unused,
+		  struct inode *inode, const char *name, const void *value,
+		  size_t size, int flags)
+{
+	struct super_block *sb = inode->i_sb;
+	struct apfs_max_ops maxops;
+	int err;
+
+	maxops.cat = APFS_XATTR_SET_MAXOPS();
+	maxops.blks = 0;
+
+	err = apfs_transaction_start(sb, maxops);
+	if (err)
+		return err;
+
+	/* Ignore the fake 'osx' prefix */
+	err = apfs_xattr_set(inode, name, value, size, flags);
+	if (err)
+		goto fail;
+
+	err = apfs_transaction_commit(sb);
+	if (!err)
+		return 0;
+
+fail:
+	apfs_transaction_abort(sb);
+	return err;
+}
+
+static const struct xattr_handler apfs_xattr_osx_handler = {
+	.prefix	= XATTR_MAC_OSX_PREFIX,
+	.get	= apfs_xattr_osx_get,
+	.set	= apfs_xattr_osx_set,
+};
+
+/* On-disk xattrs have no namespace; use a fake 'osx' prefix in the kernel */
+const struct xattr_handler *apfs_xattr_handlers[] = {
+	&apfs_xattr_osx_handler,
+	NULL
+};
+
+ssize_t apfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
+{
+	struct inode *inode = d_inode(dentry);
+	struct super_block *sb = inode->i_sb;
+	struct apfs_sb_info *sbi = APFS_SB(sb);
+	struct apfs_nxsb_info *nxi = APFS_NXI(sb);
+	struct apfs_query *query;
+	u64 cnid = apfs_ino(inode);
+	size_t free = size;
+	ssize_t ret;
+
+	down_read(&nxi->nx_big_sem);
+
+	query = apfs_alloc_query(sbi->s_cat_root, NULL /* parent */);
+	if (!query) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	/* We want all the xattrs for the cnid, regardless of the name */
+	apfs_init_xattr_key(cnid, NULL /* name */, &query->key);
+	query->flags = APFS_QUERY_CAT | APFS_QUERY_MULTIPLE | APFS_QUERY_EXACT;
+
+	while (1) {
+		struct apfs_xattr xattr;
+
+		ret = apfs_btree_query(sb, &query);
+		if (ret == -ENODATA) { /* Got all the xattrs */
+			ret = size - free;
+			break;
+		}
+		if (ret) {
+			apfs_err(sb, "query failed for id 0x%llx", cnid);
+			break;
+		}
+
+		ret = apfs_xattr_from_query(query, &xattr);
+		if (ret) {
+			apfs_err(sb, "bad xattr key in inode %llx", cnid);
+			break;
+		}
+
+		if (buffer) {
+			/* Prepend the fake 'osx' prefix before listing */
+			if (xattr.name_len + XATTR_MAC_OSX_PREFIX_LEN + 1 >
+									free) {
+				ret = -ERANGE;
+				break;
+			}
+			memcpy(buffer, XATTR_MAC_OSX_PREFIX,
+			       XATTR_MAC_OSX_PREFIX_LEN);
+			buffer += XATTR_MAC_OSX_PREFIX_LEN;
+			memcpy(buffer, xattr.name, xattr.name_len + 1);
+			buffer += xattr.name_len + 1;
+		}
+		free -= xattr.name_len + XATTR_MAC_OSX_PREFIX_LEN + 1;
+	}
+
+fail:
+	apfs_free_query(query);
+	up_read(&nxi->nx_big_sem);
+	return ret;
+}
diff --git a/drivers/staging/apfs/xfield.c b/drivers/staging/apfs/xfield.c
new file mode 100644
index 0000000000000000000000000000000000000000..b8cbe17fd25870f87def56b0229ce2e540d87167
--- /dev/null
+++ b/drivers/staging/apfs/xfield.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2019 Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include "apfs.h"
+
+/**
+ * apfs_find_xfield - Find an extended field value in an inode or dentry record
+ * @xfields:	pointer to the on-disk xfield collection for the record
+ * @len:	length of the collection
+ * @xtype:	type of the xfield to retrieve
+ * @xval:	on return, a pointer to the wanted on-disk xfield value
+ *
+ * Returns the length of @xval on success, or 0 if no matching xfield was found;
+ * the caller must check that the expected structures fit before casting @xval.
+ */
+int apfs_find_xfield(u8 *xfields, int len, u8 xtype, char **xval)
+{
+	struct apfs_xf_blob *blob;
+	struct apfs_x_field *xfield;
+	int count;
+	int rest = len;
+	int i;
+
+	if (!len)
+		return 0; /* No xfield data */
+
+	rest -= sizeof(*blob);
+	if (rest < 0)
+		return 0; /* Corruption */
+	blob = (struct apfs_xf_blob *)xfields;
+
+	count = le16_to_cpu(blob->xf_num_exts);
+	rest -= count * sizeof(*xfield);
+	if (rest < 0)
+		return 0; /* Corruption */
+	xfield = (struct apfs_x_field *)blob->xf_data;
+
+	for (i = 0; i < count; ++i) {
+		int xlen;
+
+		/* Attribute length is padded to a multiple of 8 */
+		xlen = round_up(le16_to_cpu(xfield[i].x_size), 8);
+		if (xlen > rest)
+			return 0; /* Corruption */
+
+		if (xfield[i].x_type == xtype) {
+			*xval = (char *)xfields + len - rest;
+			return xlen;
+		}
+		rest -= xlen;
+	}
+	return 0;
+}
+
+/**
+ * apfs_init_xfields - Set an empty collection of xfields in a buffer
+ * @buffer:	buffer to hold the xfields
+ * @buflen:	length of the buffer; should be enough to fit an xfield blob
+ *
+ * Returns 0 on success, or -1 if the buffer isn't long enough.
+ */
+int apfs_init_xfields(u8 *buffer, int buflen)
+{
+	struct apfs_xf_blob *blob;
+
+	if (buflen < sizeof(*blob))
+		return -1;
+	blob = (struct apfs_xf_blob *)buffer;
+
+	blob->xf_num_exts = 0;
+	blob->xf_used_data = 0;
+	return 0;
+}
+
+/**
+ * apfs_insert_xfield - Add a new xfield to an in-memory collection
+ * @buffer:	buffer holding the collection of xfields
+ * @buflen:	length of the buffer; should be enough to fit the new xfield
+ * @xkey:	metadata for the new xfield
+ * @xval:	value for the new xfield
+ *
+ * Returns the new length of the collection, or 0 if it the allocation would
+ * overflow @buffer.
+ */
+int apfs_insert_xfield(u8 *buffer, int buflen, const struct apfs_x_field *xkey,
+		       const void *xval)
+{
+	struct apfs_xf_blob *blob;
+	struct apfs_x_field *curr_xkey;
+	void *curr_xval;
+	int count;
+	int rest = buflen;
+	u16 used_data;
+	int xlen, padded_xlen;
+	int meta_len, total_len;
+	int i;
+
+	xlen = le16_to_cpu(xkey->x_size);
+	padded_xlen = round_up(xlen, 8);
+
+	if (!buflen)
+		return 0;
+
+	rest -= sizeof(*blob);
+	if (rest < 0)
+		return 0;
+	blob = (struct apfs_xf_blob *)buffer;
+	used_data = le16_to_cpu(blob->xf_used_data);
+
+	count = le16_to_cpu(blob->xf_num_exts);
+	rest -= count * sizeof(*curr_xkey);
+	if (rest < 0)
+		return 0;
+	meta_len = buflen - rest;
+	curr_xkey = (struct apfs_x_field *)blob->xf_data;
+
+	for (i = 0; i < count; ++i, ++curr_xkey) {
+		int curr_xlen;
+
+		/* Attribute length is padded to a multiple of 8 */
+		curr_xlen = round_up(le16_to_cpu(curr_xkey->x_size), 8);
+		if (curr_xlen > rest)
+			return 0;
+		if (curr_xkey->x_type != xkey->x_type) {
+			rest -= curr_xlen;
+			continue;
+		}
+
+		/* The xfield already exists, so just resize it and set it */
+		memcpy(curr_xkey, xkey, sizeof(*curr_xkey));
+		if (padded_xlen > rest)
+			return 0;
+		curr_xval = buffer + buflen - rest;
+		rest -= max(padded_xlen, curr_xlen);
+		memmove(curr_xval + padded_xlen, curr_xval + curr_xlen, rest);
+		memcpy(curr_xval, xval, xlen);
+		memset(curr_xval + xlen, 0, padded_xlen - xlen);
+		used_data += padded_xlen - curr_xlen;
+
+		goto done;
+	}
+
+	/* Create a metadata entry for the new xfield */
+	rest -= sizeof(*curr_xkey);
+	if (rest < 0)
+		return 0;
+	meta_len += sizeof(*curr_xkey);
+	memmove(curr_xkey + 1, curr_xkey, buflen - meta_len);
+	memcpy(curr_xkey, xkey, sizeof(*curr_xkey));
+	++count;
+
+	/* Now set the xfield value */
+	if (padded_xlen > rest)
+		return 0;
+	curr_xval = buffer + buflen - rest;
+	memcpy(curr_xval, xval, xlen);
+	memset(curr_xval + xlen, 0, padded_xlen - xlen);
+	used_data += padded_xlen;
+
+done:
+	total_len = used_data + meta_len;
+	if (total_len > buflen)
+		return 0;
+	blob->xf_num_exts = cpu_to_le16(count);
+	blob->xf_used_data = cpu_to_le16(used_data);
+	return total_len;
+}

-- 
2.48.1


