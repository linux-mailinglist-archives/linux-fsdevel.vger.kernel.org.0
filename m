Return-Path: <linux-fsdevel+bounces-60400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13483B466E3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 00:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92D7AA4467
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 22:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009D028BAB1;
	Fri,  5 Sep 2025 22:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="PZMkLUUA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514FA1FF1C4
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 22:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757113133; cv=none; b=suVIz0dkI2HAPEGfZI1YWj/++ddgjgD7FoGn+lE0YLXOAsDO0n0930tz/VR8Cm+8qSthXEK67pKchjs/JE+wLbZPGxE3qIf8Bsbl8WZS16D4ZVykXVpRBXWKnE/9TcnK+wTV/LuWeiFJYN0Vfu2c7a0hHMXFuCb9L314vctC4HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757113133; c=relaxed/simple;
	bh=sPSMZDeBrpKfrt8ZUNwzI+PoL28wiPc30Qbx8iKCao0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j1KtDxL4IMa8KCxzft+xCIjPYPNYRKhtMFx9Ocg5kIl2QJDEo2wZdFkaPqybId1/znNzvLfaCgZ8J8v4VPNCYpcoO4Aibuil/suiPRVbaF6r6gMKwiJjowTR+2ZOtG80+5zV+wfA4MuHD9hhRXBvNir9z24RXj/ZhlA9FwLe6PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=PZMkLUUA; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e96c48e7101so2644417276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Sep 2025 15:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757113129; x=1757717929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bMiVVXdhthj+UaAi6z6JyHsYF+9PQ5+S2ypxwK2g/bg=;
        b=PZMkLUUAOaKqCxB8wkkHlsF3wtzyF0ih5rG64iK0afw5gIKEKdxa2UBMBNjmfyP/ZJ
         2sWbtm0Lo9i3eDMdqBEkt2OuU8EKAjZx6+iIn3misTMf4rr8zr/+dJi1A7PV3on2lw37
         /x18CGlF8W9P7vBVMA3GOXoD/97DglvByMuYe9yXJKCqaAKIxCITvhgqWovF8qWBge0R
         mC6rpP2Ei7xDl8Q48YZsHv10Ry6IY71sR+kuBZv7iOEa91Bj48sGFbeToDgRvvcNQ21E
         jGcPoy1fSom/bqqp5EKRY6rU3XV8sifoO2jVv+2ElftirSXvIkLFzmlhkXP00MSv0lmw
         ULXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757113129; x=1757717929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bMiVVXdhthj+UaAi6z6JyHsYF+9PQ5+S2ypxwK2g/bg=;
        b=hYkUujk1CrU6+OnG25CPIJaI6HEItRdrZ73dcwW6Ll39x3Loj0oes5/FeT83fIuJzj
         +ljxtrufNwx5qP9Ps4+lKBjfmKq65p4BKLMDWhUbsh3DVFbnLwCXRRuPaSYw00t37Ddt
         4X9WjPlCacwBoPEC8P4Nj/vh9MFR4/RsQQ6fJ11j5MtC+zL8ou1HA8L+nBiw9ITwqgag
         6QsX2tTDLHhFHiBkJQb6pqOmN3LmjYeJRDAiEbgeAPpXi9PsEnHE3suGDsCgn2opJfW3
         XoRn4N47EA/lec1r5k0jjlE/4seVBXqFr7h2oOnKP2iavp15tdUWp3m3toI80WoFpntw
         geDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPq2w/1gUyK+7RRgRZ38+8IoMD46zcCXJDjYHmyvk/dLwaKLcWxXQyNInrhdmXSn7EimLP3AvYaAXYBXus@vger.kernel.org
X-Gm-Message-State: AOJu0YxHuK6Kmd62MkZS9v8rn2VjAfROmyrb2ZkxSlE7qEt40NZYT53e
	NvCvM7Q2kn/1co8ii5H5pu4hPdjW5yCqdUDRxF3BVxftbnFiMG8v8KTgq14+D6dLJ8k=
X-Gm-Gg: ASbGnctyGgBtpzS/W2xe3jTpcDFKGQKjZbq4M307/pJ1aKTE++3ZEpTxd/rpXxqTxtM
	uGvhuyFWsxgpQy6AEdqVIWZAAasGVIw9Z8A/cCIbRn8GBZ+nSxOHr3eIiIW1QkZt/1iAF1HgDUu
	Gfk6ZSoWQGemOgxjNdQLzTuiiLdqO1QaUVyfsCydgmsXtOC59lycIMEFXfikMMNQvmo2XTF9wyv
	HObvXX9AoBqf3f2Z15gzAMwWzPoryy+6fCkF1MmpMWUg+LRkRgDIdgPpgiduC7eI+ON9khIr/9t
	HQRqfKTqqpmdQWrQSEmtjhYRA/VFpHhmPxdhRuauza3uSbJNtbKYKoLy0InN9lbL7rGw1UVuTXh
	sVDXght8vuCfSJfF4CGia4zBuZk8TbusG8upKpOz7Bra4
X-Google-Smtp-Source: AGHT+IHw7ODfzua2iGvIVgTMgcSawkBN+qqAVcuIydVxF2gIkajQT4c18cX5hN3RPwsbcnYGCNES6Q==
X-Received: by 2002:a05:6902:2089:b0:e96:fdcc:4f94 with SMTP id 3f1490d57ef6-e9f6799080emr436793276.27.1757113129052;
        Fri, 05 Sep 2025 15:58:49 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:558b:a8eb:2672:42af])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9bbe08d6aasm3449930276.24.2025.09.05.15.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 15:58:48 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfsplus: add and rework comments for key metadata structures
Date: Fri,  5 Sep 2025 15:58:28 -0700
Message-Id: <20250905225827.739567-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we have not good enough comments for
HFS+ metadata structures.

Claude AI generated comments for key HFS+ metadata
structures. These comments have been reviewed, checked,
and corrected. This patch adds and reworks comments for
key HFS+ metadata structures.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/hfsplus_fs.h  | 167 ++++++++-
 fs/hfsplus/hfsplus_raw.h | 738 +++++++++++++++++++++++++++++----------
 2 files changed, 723 insertions(+), 182 deletions(-)

diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 96a5c24813dd..039903901c4e 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -70,7 +70,36 @@ enum hfsplus_btree_mutex_classes {
 	ATTR_BTREE_MUTEX,
 };
 
-/* An HFS+ BTree held in memory */
+/*
+ * struct hfs_btree - In-memory HFS+ B-tree representation
+ *
+ * This structure represents a complete HFS+ B-tree in memory, containing
+ * both metadata from the on-disk B-tree header and runtime state needed
+ * for efficient B-tree operations. HFS+ uses B-trees for the catalog
+ * (directory structure), extents overflow (file extent records), and
+ * attributes (extended attributes).
+ *
+ * @sb: Associated superblock
+ * @inode: Inode representing the B-tree file
+ * @keycmp: Key comparison function pointer
+ * @cnid: Catalog Node ID of this B-tree file
+ * @root: Node number of the root node
+ * @leaf_count: Total number of leaf records
+ * @leaf_head: Node number of first leaf node
+ * @leaf_tail: Node number of last leaf node
+ * @node_count: Total number of nodes in B-tree
+ * @free_nodes: Number of unused/available nodes
+ * @attributes: B-tree attributes flags
+ * @node_size: Size of each B-tree node in bytes
+ * @node_size_shift: log2(node_size) for bit shifting
+ * @max_key_len: Maximum key length for this B-tree
+ * @depth: Height of B-tree (levels from root)
+ * @tree_lock: Mutex protecting B-tree operations
+ * @pages_per_bnode: Memory pages per B-tree node
+ * @hash_lock: Spinlock protecting node hash table
+ * @node_hash: Hash table of cached nodes
+ * @node_hash_cnt: Number of nodes in hash table
+ */
 struct hfs_btree {
 	struct super_block *sb;
 	struct inode *inode;
@@ -100,7 +129,29 @@ struct hfs_btree {
 
 struct page;
 
-/* An HFS+ BTree node in memory */
+/*
+ * struct hfs_bnode - In-memory HFS+ B-tree node
+ *
+ * Represents a single HFS+ B-tree node in memory, containing both the
+ * on-disk node metadata and runtime state for caching, locking,
+ * and reference counting. Nodes are cached in a hash table for
+ * efficient access.
+ *
+ * @tree: Parent B-tree this node belongs to
+ * @prev: Node number of previous node at this level
+ * @this: This node's number
+ * @next: Node number of next node at this level
+ * @parent: Node number of parent node
+ * @num_recs: Number of records in this node
+ * @type: Node type (index, leaf, header, map)
+ * @height: Height in B-tree (1=leaf, >1=internal)
+ * @next_hash: Next node in hash chain
+ * @flags: Node state flags (lock, error, dirty, etc.)
+ * @lock_wq: Wait queue for node locking
+ * @refcnt: Reference count for memory management
+ * @page_offset: Offset within first page
+ * @page: Array of memory pages holding node data
+ */
 struct hfs_bnode {
 	struct hfs_btree *tree;
 
@@ -136,7 +187,52 @@ struct hfs_bnode {
 #define HFSPLUS_FAILED_ATTR_TREE	3
 
 /*
- * HFS+ superblock info (built from Volume Header on disk)
+ * struct hfsplus_sb_info - HFS+ superblock information
+ *
+ * This structure contains all HFS+ filesystem metadata, extending the
+ * Linux VFS superblock. It manages the Volume Header, B-trees, allocation
+ * bitmap, and various filesystem parameters and mount options. Data is
+ * organized by access patterns and protection requirements.
+ *
+ * @s_vhdr_buf: Buffer holding primary Volume Header
+ * @s_vhdr: Pointer to parsed Volume Header
+ * @s_backup_vhdr_buf: Buffer holding backup Volume Header
+ * @s_backup_vhdr: Pointer to backup Volume Header
+ * @ext_tree: Extents overflow B-tree
+ * @cat_tree: Catalog B-tree
+ * @attr_tree: Attributes B-tree (extended attributes)
+ * @attr_tree_state: State of attributes tree creation
+ * @alloc_file: Allocation bitmap file inode
+ * @hidden_dir: Hidden directory for metadata files
+ * @nls: Character set conversion table
+ * @blockoffset: Block offset within device (Runtime variables)
+ * @min_io_size: Minimum I/O size for this device
+ * @part_start: Starting sector of HFS+ partition
+ * @sect_count: Total sectors in partition
+ * @fs_shift: log2(block_size) - log2(sector_size)
+ * @alloc_blksz: Allocation block size in bytes (immutable data from volume header)
+ * @alloc_blksz_shift: log2(alloc_blksz) for bit operations
+ * @total_blocks: Total allocation blocks in filesystem
+ * @data_clump_blocks: Default clump size for data forks
+ * @rsrc_clump_blocks: Default clump size for resource forks
+ * @free_blocks: Number of free allocation blocks (mutable data, protected by alloc_mutex)
+ * @alloc_mutex: Mutex protecting allocation operations
+ * @next_cnid: Next catalog node ID to assign (mutable data, protected by vh_mutex)
+ * @file_count: Total number of files in filesystem
+ * @folder_count: Total number of folders in filesystem
+ * @vh_mutex: Mutex protecting volume header updates
+ * @creator: Default creator for new files (Config options)
+ * @type: Default file type for new files
+ * @umask: Permission mask for new files/directories
+ * @uid: Default user ID for files
+ * @gid: Default group ID for files
+ * @part: Partition info for optical media
+ * @session: Session info for optical media
+ * @flags: Mount flags and filesystem state
+ * @work_queued: Flag indicating delayed work is queued
+ * @sync_work: Delayed work for volume header sync
+ * @work_lock: Lock protecting work queue state
+ * @rcu: RCU head for safe deallocation
  */
 
 struct hfsplus_vh;
@@ -189,9 +285,9 @@ struct hfsplus_sb_info {
 	int part, session;
 	unsigned long flags;
 
-	int work_queued;               /* non-zero delayed work is queued */
-	struct delayed_work sync_work; /* FS sync delayed work */
-	spinlock_t work_lock;          /* protects sync_work and work_queued */
+	int work_queued;
+	struct delayed_work sync_work;
+	spinlock_t work_lock;
 	struct rcu_head rcu;
 };
 
@@ -210,6 +306,36 @@ static inline struct hfsplus_sb_info *HFSPLUS_SB(struct super_block *sb)
 }
 
 
+/*
+ * struct hfsplus_inode_info - HFS+ specific inode information
+ *
+ * This structure contains HFS+ specific metadata for each inode,
+ * extending the standard Linux VFS inode. It handles file extents,
+ * resource forks, hard links, and extended attributes. Fields are
+ * grouped by their protection mechanisms and access patterns.
+ *
+ * @opencnt: Number of open file handles
+ * @first_blocks: Blocks in first (catalog) extents
+ * @clump_blocks: Preferred clump size for allocation
+ * @alloc_blocks: Total allocated blocks for file
+ * @cached_start: Starting block of cached extents
+ * @cached_blocks: Number of blocks in cached extents
+ * @first_extents: First 8 extent records from catalog
+ * @cached_extents: Cached extents from overflow tree
+ * @extent_state: State flags for extent management
+ * @extents_lock: Mutex protecting extent information
+ * @rsrc_inode: Resource fork inode (if any) (Immutable data)
+ * @create_date: File creation date (HFS+ format)
+ * @linkid: Hard link identifier for link tracking (Protected by sbi->vh_mutex)
+ * @flags: Inode state flags (dirty, resource, etc.) (Accessed using atomic bitops)
+ * @fs_blocks: File size in filesystem blocks (Protected by i_mutex)
+ * @userflags: BSD user file flags (immutable, etc.)
+ * @subfolders: Subfolder count (HFSX case-sensitive only)
+ * @open_dir_list: List of open directory handles
+ * @open_dir_lock: Lock protecting open_dir_list
+ * @phys_size: Physical size of file on disk
+ * @vfs_inode: Embedded VFS inode structure
+ */
 struct hfsplus_inode_info {
 	atomic_t opencnt;
 
@@ -285,6 +411,24 @@ static inline void hfsplus_mark_inode_dirty(struct inode *inode,
 	mark_inode_dirty(inode);
 }
 
+/*
+ * struct hfs_find_data - HFS+ B-tree search operation context
+ *
+ * This structure maintains the state of an HFS+ B-tree search operation,
+ * tracking the current position, search parameters, and results.
+ * Used by B-tree search and iteration functions to maintain context
+ * across multiple calls.
+ *
+ * @search_key: Key being searched for (filled by caller)
+ * @key: Buffer for current key
+ * @tree: B-tree being searched (filled by find)
+ * @bnode: Current node in search
+ * @record: Current record index within node (filled by findrec)
+ * @keyoffset: Offset of current key
+ * @keylength: Length of current key
+ * @entryoffset: Offset of current data
+ * @entrylength: Length of current data
+ */
 struct hfs_find_data {
 	/* filled by caller */
 	hfsplus_btree_key *search_key;
@@ -298,6 +442,17 @@ struct hfs_find_data {
 	int entryoffset, entrylength;
 };
 
+/*
+ * struct hfsplus_readdir_data - Directory reading state
+ *
+ * Runtime structure used to track the state of HFS+ directory reading
+ * operations. Maintains position and context for readdir() calls to
+ * ensure consistent directory traversal across multiple system calls.
+ *
+ * @list: List linkage for multiple readers
+ * @file: Associated file descriptor
+ * @key: Current position in directory
+ */
 struct hfsplus_readdir_data {
 	struct list_head list;
 	struct file *file;
diff --git a/fs/hfsplus/hfsplus_raw.h b/fs/hfsplus/hfsplus_raw.h
index 68b4240c6191..cd0f45c323f7 100644
--- a/fs/hfsplus/hfsplus_raw.h
+++ b/fs/hfsplus/hfsplus_raw.h
@@ -56,85 +56,188 @@ typedef __be16 hfsplus_unichr;
 #define HFSPLUS_MAX_STRLEN 255
 #define HFSPLUS_ATTR_MAX_STRLEN 127
 
-/* A "string" as used in filenames, etc. */
+/*
+ * struct hfsplus_unistr - HFS+ Unicode string
+ *
+ * HFS+ uses UTF-16 Unicode strings for filenames and other text data.
+ * The length field specifies the number of Unicode characters (not bytes).
+ * Maximum filename length is 255 Unicode characters.
+ *
+ * @length: Number of Unicode characters
+ * @unicode: UTF-16 character array
+ */
 struct hfsplus_unistr {
-	__be16 length;
-	hfsplus_unichr unicode[HFSPLUS_MAX_STRLEN];
+/* 0x000 */
+	__be16 length;					/* 0x00 */
+	hfsplus_unichr unicode[HFSPLUS_MAX_STRLEN];	/* 0x02 */
+/* 0x200 */
 } __packed;
 
 /*
- * A "string" is used in attributes file
- * for name of extended attribute
+ * struct hfsplus_attr_unistr - HFS+ extended attribute name string
+ *
+ * Similar to hfsplus_unistr but with a shorter maximum length for
+ * extended attribute names. Used in the attributes B-tree for
+ * storing extended attribute identifiers.
+ *
+ * @length: Number of Unicode characters
+ * @unicode: UTF-16 characters
  */
 struct hfsplus_attr_unistr {
-	__be16 length;
-	hfsplus_unichr unicode[HFSPLUS_ATTR_MAX_STRLEN];
+/* 0x000 */
+	__be16 length;						/* 0x00 */
+	hfsplus_unichr unicode[HFSPLUS_ATTR_MAX_STRLEN];	/* 0x02 */
+/* 0x100 */
 } __packed;
 
-/* POSIX permissions */
+/*
+ * struct hfsplus_perm - HFS+ POSIX permissions and BSD flags
+ *
+ * Stores POSIX-style permissions along with BSD user and system flags.
+ * This structure provides Unix-style access control for HFS+ files
+ * and directories.
+ *
+ * @owner: User ID of file owner
+ * @group: Group ID of file
+ * @rootflags: BSD system flags (root-only)
+ * @userflags: BSD user flags (immutable, append, etc.)
+ * @mode: POSIX permission mode bits
+ * @dev: Device ID for special files
+ */
 struct hfsplus_perm {
-	__be32 owner;
-	__be32 group;
-	u8  rootflags;
-	u8  userflags;
-	__be16 mode;
-	__be32 dev;
+/* 0x00 */
+	__be32 owner;		/* 0x00 */
+	__be32 group;		/* 0x04 */
+	u8  rootflags;		/* 0x08 */
+	u8  userflags;		/* 0x09 */
+	__be16 mode;		/* 0x0A */
+	__be32 dev;		/* 0x0C */
+/* 0x10 */
 } __packed;
 
 #define HFSPLUS_FLG_NODUMP	0x01
 #define HFSPLUS_FLG_IMMUTABLE	0x02
 #define HFSPLUS_FLG_APPEND	0x04
 
-/* A single contiguous area of a file */
+/*
+ * struct hfsplus_extent - File extent descriptor
+ *
+ * Describes a single contiguous range of allocation blocks belonging
+ * to a file. HFS+ files can be fragmented across multiple extents
+ * to efficiently use disk space.
+ *
+ * @start_block: Starting allocation block number
+ * @block_count: Number of contiguous blocks
+ */
 struct hfsplus_extent {
-	__be32 start_block;
-	__be32 block_count;
+/* 0x00 */
+	__be32 start_block;		/* 0x00 */
+	__be32 block_count;		/* 0x04 */
+/* 0x08 */
 } __packed;
+
+/*
+ * hfsplus_extent_rec - Array of 8 extent descriptors
+ *
+ * HFS+ stores up to 8 extent records directly in catalog entries,
+ * compared to 3 in classic HFS. Additional extents for highly
+ * fragmented files are stored in the extents overflow B-tree.
+ */
 typedef struct hfsplus_extent hfsplus_extent_rec[8];
 
-/* Information for a "Fork" in a file */
+/*
+ * struct hfsplus_fork_raw - HFS+ fork information
+ *
+ * Contains complete information about a file fork (data or resource).
+ * Each HFS+ file can have two forks: a data fork for file content
+ * and a resource fork for metadata, icons, and application data.
+ *
+ * @total_size: Logical size of fork in bytes
+ * @clump_size: Preferred allocation clump size
+ * @total_blocks: Total allocation blocks used by fork
+ * @extents: First 8 extent descriptors
+ */
 struct hfsplus_fork_raw {
-	__be64 total_size;
-	__be32 clump_size;
-	__be32 total_blocks;
-	hfsplus_extent_rec extents;
+/* 0x00 */
+	__be64 total_size;		/* 0x00 */
+	__be32 clump_size;		/* 0x08 */
+	__be32 total_blocks;		/* 0x0C */
+	hfsplus_extent_rec extents;	/* 0x10 */
+/* 0x50 */
 } __packed;
 
-/* HFS+ Volume Header */
+/*
+ * struct hfsplus_vh - HFS+ Volume Header
+ *
+ * The Volume Header is the primary metadata structure of an HFS+ filesystem,
+ * equivalent to a superblock. It contains essential filesystem parameters,
+ * allocation information, timestamps, and fork descriptors for special files.
+ * Located at sector 2 of the HFS+ partition, with a backup copy at the
+ * second-to-last sector.
+ *
+ * @signature: Volume signature (0x482b for HFS+, 0x4858 for HFSX)
+ * @version: Volume format version (4 or 5)
+ * @attributes: Volume attribute flags
+ * @last_mount_vers: Implementation version that last mounted volume
+ * @reserved: Reserved field
+ * @create_date: Volume creation timestamp
+ * @modify_date: Volume modification timestamp
+ * @backup_date: Last backup timestamp
+ * @checked_date: Last filesystem check timestamp
+ * @file_count: Total number of files in filesystem
+ * @folder_count: Total number of folders in filesystem
+ * @blocksize: Allocation block size in bytes
+ * @total_blocks: Total number of allocation blocks
+ * @free_blocks: Number of free allocation blocks
+ * @next_alloc: Next allocation search start point
+ * @rsrc_clump_sz: Default resource fork clump size
+ * @data_clump_sz: Default data fork clump size
+ * @next_cnid: Next available catalog node ID
+ * @write_count: Volume write operation counter
+ * @encodings_bmp: Bitmap of supported text encodings
+ * @finder_info: Finder information and boot parameters
+ * @alloc_file: Allocation bitmap file fork
+ * @ext_file: Extents overflow B-tree file fork
+ * @cat_file: Catalog B-tree file fork
+ * @attr_file: Attributes B-tree file fork
+ * @start_file: Startup file fork (boot support)
+ */
 struct hfsplus_vh {
-	__be16 signature;
-	__be16 version;
-	__be32 attributes;
-	__be32 last_mount_vers;
-	u32 reserved;
-
-	__be32 create_date;
-	__be32 modify_date;
-	__be32 backup_date;
-	__be32 checked_date;
-
-	__be32 file_count;
-	__be32 folder_count;
-
-	__be32 blocksize;
-	__be32 total_blocks;
-	__be32 free_blocks;
-
-	__be32 next_alloc;
-	__be32 rsrc_clump_sz;
-	__be32 data_clump_sz;
-	hfsplus_cnid next_cnid;
-
-	__be32 write_count;
-	__be64 encodings_bmp;
-
-	u32 finder_info[8];
-
-	struct hfsplus_fork_raw alloc_file;
-	struct hfsplus_fork_raw ext_file;
-	struct hfsplus_fork_raw cat_file;
-	struct hfsplus_fork_raw attr_file;
-	struct hfsplus_fork_raw start_file;
+/* 0x000 */
+	__be16 signature;		/* 0x00 */
+	__be16 version;			/* 0x02 */
+	__be32 attributes;		/* 0x04 */
+	__be32 last_mount_vers;		/* 0x08 */
+	u32 reserved;			/* 0x0C */
+
+	__be32 create_date;		/* 0x10 */
+	__be32 modify_date;		/* 0x14 */
+	__be32 backup_date;		/* 0x18 */
+	__be32 checked_date;		/* 0x1C */
+
+	__be32 file_count;		/* 0x20 */
+	__be32 folder_count;		/* 0x24 */
+
+	__be32 blocksize;		/* 0x28 */
+	__be32 total_blocks;		/* 0x2C */
+	__be32 free_blocks;		/* 0x30 */
+
+	__be32 next_alloc;		/* 0x34 */
+	__be32 rsrc_clump_sz;		/* 0x38 */
+	__be32 data_clump_sz;		/* 0x3C */
+	hfsplus_cnid next_cnid;		/* 0x40 */
+
+	__be32 write_count;		/* 0x44 */
+	__be64 encodings_bmp;		/* 0x48 */
+
+	u32 finder_info[8];		/* 0x50 */
+
+	struct hfsplus_fork_raw alloc_file;	/* 0x70 */
+	struct hfsplus_fork_raw ext_file;	/* 0xC0 */
+	struct hfsplus_fork_raw cat_file;	/* 0x110 */
+	struct hfsplus_fork_raw attr_file;	/* 0x160 */
+	struct hfsplus_fork_raw start_file;	/* 0x1B0 */
+/* 0x200 */
 } __packed;
 
 /* HFS+ volume attributes */
@@ -147,14 +250,29 @@ struct hfsplus_vh {
 #define HFSPLUS_VOL_SOFTLOCK		(1 << 15)
 #define HFSPLUS_VOL_UNUSED_NODE_FIX	(1 << 31)
 
-/* HFS+ BTree node descriptor */
+/*
+ * struct hfs_bnode_desc - HFS+ B-tree node descriptor
+ *
+ * This structure appears at the beginning of every HFS+ B-tree node
+ * on disk, providing essential metadata for navigating the B-tree
+ * structure and understanding the node's contents.
+ *
+ * @next: Node ID of next node at same level
+ * @prev: Node ID of previous node at same level
+ * @type: Node type (index/header/map/leaf)
+ * @height: Distance from leaves (leaves=1)
+ * @num_recs: Number of records stored in this node
+ * @reserved: Reserved space for alignment
+ */
 struct hfs_bnode_desc {
-	__be32 next;
-	__be32 prev;
-	s8 type;
-	u8 height;
-	__be16 num_recs;
-	u16 reserved;
+/* 0x00 */
+	__be32 next;			/* 0x00 */
+	__be32 prev;			/* 0x04 */
+	s8 type;			/* 0x08 */
+	u8 height;			/* 0x09 */
+	__be16 num_recs;		/* 0x0A */
+	u16 reserved;			/* 0x0C */
+/* 0x0E */
 } __packed;
 
 /* HFS+ BTree node types */
@@ -163,23 +281,47 @@ struct hfs_bnode_desc {
 #define HFS_NODE_MAP	0x02	/* Holds part of the bitmap of used nodes */
 #define HFS_NODE_LEAF	0xFF	/* A leaf (ndNHeight==1) node */
 
-/* HFS+ BTree header */
+/*
+ * struct hfs_btree_header_rec - HFS+ B-tree header record
+ *
+ * This structure is stored as the first record in the header node
+ * (node 0) of every HFS+ B-tree. It contains essential metadata about
+ * the B-tree structure, organization, and current state.
+ *
+ * @depth: Number of levels in B-tree (root to leaf)
+ * @root: Node ID of the root node
+ * @leaf_count: Total number of data records in leaves
+ * @leaf_head: Node number of first (leftmost) leaf
+ * @leaf_tail: Node number of last (rightmost) leaf
+ * @node_size: Size of each B-tree node in bytes
+ * @max_key_len: Maximum key length for index nodes
+ * @node_count: Total number of nodes allocated
+ * @free_nodes: Number of unused nodes available
+ * @reserved1: Reserved field for future use
+ * @clump_size: Allocation clump size for B-tree growth
+ * @btree_type: Type identifier for this B-tree
+ * @key_type: Key comparison type (case-sensitive/insensitive)
+ * @attributes: B-tree feature flags and attributes
+ * @reserved3: Reserved space for future expansion
+ */
 struct hfs_btree_header_rec {
-	__be16 depth;
-	__be32 root;
-	__be32 leaf_count;
-	__be32 leaf_head;
-	__be32 leaf_tail;
-	__be16 node_size;
-	__be16 max_key_len;
-	__be32 node_count;
-	__be32 free_nodes;
-	u16 reserved1;
-	__be32 clump_size;
-	u8 btree_type;
-	u8 key_type;
-	__be32 attributes;
-	u32 reserved3[16];
+/* 0x00 */
+	__be16 depth;			/* 0x00 */
+	__be32 root;			/* 0x02 */
+	__be32 leaf_count;		/* 0x06 */
+	__be32 leaf_head;		/* 0x0A */
+	__be32 leaf_tail;		/* 0x0E */
+	__be16 node_size;		/* 0x12 */
+	__be16 max_key_len;		/* 0x14 */
+	__be32 node_count;		/* 0x16 */
+	__be32 free_nodes;		/* 0x1A */
+	u16 reserved1;			/* 0x1E */
+	__be32 clump_size;		/* 0x20 */
+	u8 btree_type;			/* 0x24 */
+	u8 key_type;			/* 0x25 */
+	__be32 attributes;		/* 0x26 */
+	u32 reserved3[16];		/* 0x2A */
+/* 0x6A */
 } __packed;
 
 /* BTree attributes */
@@ -209,102 +351,237 @@ struct hfs_btree_header_rec {
 #define HFSPLUS_KEY_CASEFOLDING		0xCF	/* case-insensitive */
 #define HFSPLUS_KEY_BINARY		0xBC	/* case-sensitive */
 
-/* HFS+ catalog entry key */
+/*
+ * struct hfsplus_cat_key - HFS+ catalog B-tree search key
+ *
+ * Key structure used for searching the catalog B-tree. Entries are
+ * organized by parent directory ID and filename, allowing efficient
+ * lookups and directory traversals with Unicode filename support.
+ *
+ * @key_len: Total length of key in bytes
+ * @parent: Catalog Node ID of parent directory
+ * @name: Unicode filename within parent directory
+ */
 struct hfsplus_cat_key {
-	__be16 key_len;
-	hfsplus_cnid parent;
-	struct hfsplus_unistr name;
+/* 0x000 */
+	__be16 key_len;			/* 0x00 */
+	hfsplus_cnid parent;		/* 0x02 */
+	struct hfsplus_unistr name;	/* 0x06 */
+/* 0x206 */
 } __packed;
 
 #define HFSPLUS_CAT_KEYLEN	(sizeof(struct hfsplus_cat_key))
 
-/* Structs from hfs.h */
+/*
+ * struct hfsp_point - 2D coordinate point for Finder display
+ *
+ * Used by the Finder for positioning icons and windows in the
+ * Mac OS graphical interface.
+ *
+ * @v: Vertical coordinate
+ * @h: Horizontal coordinate
+ */
 struct hfsp_point {
-	__be16 v;
-	__be16 h;
+/* 0x00 */
+	__be16 v;			/* 0x00 */
+	__be16 h;			/* 0x02 */
+/* 0x04 */
 } __packed;
 
+/*
+ * struct hfsp_rect - Rectangle coordinates for Finder display
+ *
+ * Defines a rectangular area used by the Finder for windows
+ * and icon positioning in the Mac OS interface.
+ *
+ * @top: Top edge coordinate
+ * @left: Left edge coordinate
+ * @bottom: Bottom edge coordinate
+ * @right: Right edge coordinate
+ */
 struct hfsp_rect {
-	__be16 top;
-	__be16 left;
-	__be16 bottom;
-	__be16 right;
+/* 0x00 */
+	__be16 top;			/* 0x00 */
+	__be16 left;			/* 0x02 */
+	__be16 bottom;			/* 0x04 */
+	__be16 right;			/* 0x06 */
+/* 0x08 */
 } __packed;
 
 
-/* HFS directory info (stolen from hfs.h */
+/*
+ * struct DInfo - Directory Finder information (stolen from hfs.h)
+ *
+ * Contains metadata used by the Mac OS Finder to display directory
+ * windows, including position, size, and view settings.
+ *
+ * @frRect: Directory window rectangle
+ * @frFlags: Directory window flags
+ * @frLocation: Directory window position
+ * @frView: Directory view type (icon, list, etc.)
+ */
 struct DInfo {
-	struct hfsp_rect frRect;
-	__be16 frFlags;
-	struct hfsp_point frLocation;
-	__be16 frView;
+/* 0x00 */
+	struct hfsp_rect frRect;	/* 0x00 */
+	__be16 frFlags;			/* 0x08 */
+	struct hfsp_point frLocation;	/* 0x0A */
+	__be16 frView;			/* 0x0E */
+/* 0x10 */
 } __packed;
 
+/*
+ * struct DXInfo - Extended directory Finder information
+ *
+ * Additional directory display metadata including scroll position
+ * and comment references for the Mac OS Finder.
+ *
+ * @frScroll: Scroll position in directory window
+ * @frOpenChain: Linked list of open directory windows
+ * @frUnused: Reserved/unused field
+ * @frComment: Comment resource ID for directory
+ * @frPutAway: Directory ID for "Put Away" command
+ */
 struct DXInfo {
-	struct hfsp_point frScroll;
-	__be32 frOpenChain;
-	__be16 frUnused;
-	__be16 frComment;
-	__be32 frPutAway;
+/* 0x00 */
+	struct hfsp_point frScroll;	/* 0x00 */
+	__be32 frOpenChain;		/* 0x04 */
+	__be16 frUnused;		/* 0x08 */
+	__be16 frComment;		/* 0x0A */
+	__be32 frPutAway;		/* 0x0C */
+/* 0x10 */
 } __packed;
 
-/* HFS+ folder data (part of an hfsplus_cat_entry) */
+/*
+ * struct hfsplus_cat_folder - HFS+ catalog record for directories (part of an hfsplus_cat_entry)
+ *
+ * Complete metadata for a directory stored in the catalog B-tree.
+ * Contains directory-specific information including item count,
+ * Finder display settings, permissions, and timestamps.
+ *
+ * @type: Record type (HFSPLUS_FOLDER)
+ * @flags: Directory flags
+ * @valence: Number of items in directory
+ * @id: Catalog Node ID (unique directory ID)
+ * @create_date: Directory creation timestamp
+ * @content_mod_date: Content modification timestamp
+ * @attribute_mod_date: Attribute modification timestamp
+ * @access_date: Last access timestamp
+ * @backup_date: Last backup timestamp
+ * @permissions: POSIX permissions and BSD flags
+ * @user_info: Finder display information
+ * @finder_info: Extended Finder information
+ * @text_encoding: Text encoding hint for filenames
+ * @subfolders: Subfolder count (HFSX only, reserved in HFS+)
+ */
 struct hfsplus_cat_folder {
-	__be16 type;
-	__be16 flags;
-	__be32 valence;
-	hfsplus_cnid id;
-	__be32 create_date;
-	__be32 content_mod_date;
-	__be32 attribute_mod_date;
-	__be32 access_date;
-	__be32 backup_date;
-	struct hfsplus_perm permissions;
+/* 0x00 */
+	__be16 type;				/* 0x00 */
+	__be16 flags;				/* 0x02 */
+	__be32 valence;				/* 0x04 */
+	hfsplus_cnid id;			/* 0x08 */
+	__be32 create_date;			/* 0x0C */
+	__be32 content_mod_date;		/* 0x10 */
+	__be32 attribute_mod_date;		/* 0x14 */
+	__be32 access_date;			/* 0x18 */
+	__be32 backup_date;			/* 0x1C */
+	struct hfsplus_perm permissions;	/* 0x20 */
 	struct_group_attr(info, __packed,
-		struct DInfo user_info;
-		struct DXInfo finder_info;
+		struct DInfo user_info;		/* 0x30 */
+		struct DXInfo finder_info;	/* 0x40 */
 	);
-	__be32 text_encoding;
-	__be32 subfolders;	/* Subfolder count in HFSX. Reserved in HFS+. */
+	__be32 text_encoding;			/* 0x50 */
+	__be32 subfolders;			/* 0x54 */
+/* 0x58 */
 } __packed;
 
-/* HFS file info (stolen from hfs.h) */
+/*
+ * struct FInfo - File Finder information (stolen from hfs.h)
+ *
+ * Contains metadata used by the Mac OS Finder to display and
+ * handle files, including type, creator, and display location.
+ *
+ * @fdType: File type (4-character code)
+ * @fdCreator: Creator application (4-character code)
+ * @fdFlags: Finder flags (visibility, lock, etc.)
+ * @fdLocation: Icon position in folder window
+ * @fdFldr: Folder containing the file
+ */
 struct FInfo {
-	__be32 fdType;
-	__be32 fdCreator;
-	__be16 fdFlags;
-	struct hfsp_point fdLocation;
-	__be16 fdFldr;
+/* 0x00 */
+	__be32 fdType;			/* 0x00 */
+	__be32 fdCreator;		/* 0x04 */
+	__be16 fdFlags;			/* 0x08 */
+	struct hfsp_point fdLocation;	/* 0x0A */
+	__be16 fdFldr;			/* 0x0E */
+/* 0x10 */
 } __packed;
 
+/*
+ * struct FXInfo - Extended file Finder information
+ *
+ * Additional file metadata used by the Mac OS Finder, including
+ * custom icon references and comment associations.
+ *
+ * @fdIconID: Custom icon resource ID
+ * @fdUnused: Reserved/unused bytes
+ * @fdComment: Comment resource ID
+ * @fdPutAway: Directory ID for "Put Away" command
+ */
 struct FXInfo {
-	__be16 fdIconID;
-	u8 fdUnused[8];
-	__be16 fdComment;
-	__be32 fdPutAway;
+/* 0x00 */
+	__be16 fdIconID;		/* 0x00 */
+	u8 fdUnused[8];			/* 0x02 */
+	__be16 fdComment;		/* 0x0A */
+	__be32 fdPutAway;		/* 0x0C */
+/* 0x10 */
 } __packed;
 
-/* HFS+ file data (part of a cat_entry) */
+/*
+ * struct hfsplus_cat_file - HFS+ catalog record for files (part of a cat_entry)
+ *
+ * Complete metadata for a regular file stored in the catalog B-tree.
+ * Contains both data and resource fork information, Finder metadata,
+ * timestamps, permissions, and extent records for both forks.
+ *
+ * @type: Record type (HFSPLUS_FILE)
+ * @flags: File flags
+ * @reserved1: Reserved field
+ * @id: Catalog Node ID (unique file ID)
+ * @create_date: File creation timestamp
+ * @content_mod_date: Content modification timestamp
+ * @attribute_mod_date: Attribute modification timestamp
+ * @access_date: Last access timestamp
+ * @backup_date: Last backup timestamp
+ * @permissions: POSIX permissions and BSD flags
+ * @user_info: Finder file information
+ * @finder_info: Extended Finder information
+ * @text_encoding: Text encoding hint for filename
+ * @reserved2: Reserved field
+ * @data_fork: Data fork information and extents
+ * @rsrc_fork: Resource fork information and extents
+ */
 struct hfsplus_cat_file {
-	__be16 type;
-	__be16 flags;
-	u32 reserved1;
-	hfsplus_cnid id;
-	__be32 create_date;
-	__be32 content_mod_date;
-	__be32 attribute_mod_date;
-	__be32 access_date;
-	__be32 backup_date;
-	struct hfsplus_perm permissions;
+/* 0x00 */
+	__be16 type;				/* 0x00 */
+	__be16 flags;				/* 0x02 */
+	u32 reserved1;				/* 0x04 */
+	hfsplus_cnid id;			/* 0x08 */
+	__be32 create_date;			/* 0x0C */
+	__be32 content_mod_date;		/* 0x10 */
+	__be32 attribute_mod_date;		/* 0x14 */
+	__be32 access_date;			/* 0x18 */
+	__be32 backup_date;			/* 0x1C */
+	struct hfsplus_perm permissions;	/* 0x20 */
 	struct_group_attr(info, __packed,
-		struct FInfo user_info;
-		struct FXInfo finder_info;
+		struct FInfo user_info;		/* 0x30 */
+		struct FXInfo finder_info;	/* 0x40 */
 	);
-	__be32 text_encoding;
-	u32 reserved2;
+	__be32 text_encoding;			/* 0x50 */
+	u32 reserved2;				/* 0x54 */
 
-	struct hfsplus_fork_raw data_fork;
-	struct hfsplus_fork_raw rsrc_fork;
+	struct hfsplus_fork_raw data_fork;	/* 0x58 */
+	struct hfsplus_fork_raw rsrc_fork;	/* 0xA8 */
+/* 0xF8 */
 } __packed;
 
 /* File and folder flag bits */
@@ -315,17 +592,41 @@ struct hfsplus_cat_file {
 #define HFSPLUS_HAS_FOLDER_COUNT	0x0010	/* Folder has subfolder count
 						 * (HFSX only) */
 
-/* HFS+ catalog thread (part of a cat_entry) */
+/*
+ * struct hfsplus_cat_thread - HFS+ catalog thread record (part of a cat_entry)
+ *
+ * Thread records provide reverse lookup capability in the catalog
+ * B-tree, allowing navigation from a file/directory ID back to its
+ * parent directory and name. Essential for hard link support.
+ *
+ * @type: Record type (HFSPLUS_*_THREAD)
+ * @reserved: Reserved field for alignment
+ * @parentID: Catalog Node ID of parent directory
+ * @nodeName: Unicode name of file/directory
+ */
 struct hfsplus_cat_thread {
-	__be16 type;
-	s16 reserved;
-	hfsplus_cnid parentID;
-	struct hfsplus_unistr nodeName;
+/* 0x000 */
+	__be16 type;			/* 0x00 */
+	s16 reserved;			/* 0x02 */
+	hfsplus_cnid parentID;		/* 0x04 */
+	struct hfsplus_unistr nodeName;	/* 0x08 */
+/* 0x208 */
 } __packed;
 
 #define HFSPLUS_MIN_THREAD_SZ 10
 
-/* A data record in the catalog tree */
+/*
+ * union hfsplus_cat_entry - Generic HFS+ catalog record
+ *
+ * Union representing any type of catalog B-tree record. The first
+ * field (type) determines which variant to use: folder, file, or
+ * thread record.
+ *
+ * @type: Record type discriminator
+ * @folder: Directory record
+ * @file: File record
+ * @thread: Thread record
+ */
 typedef union {
 	__be16 type;
 	struct hfsplus_cat_folder folder;
@@ -339,13 +640,27 @@ typedef union {
 #define HFSPLUS_FOLDER_THREAD  0x0003
 #define HFSPLUS_FILE_THREAD    0x0004
 
-/* HFS+ extents tree key */
+/*
+ * struct hfsplus_ext_key - HFS+ extents overflow B-tree key
+ *
+ * Key structure for the extents overflow B-tree, which stores
+ * additional extent records when files need more than the 8
+ * extents stored in the catalog record.
+ *
+ * @key_len: Total length of key in bytes
+ * @fork_type: Fork type (data=0x00, resource=0xFF)
+ * @pad: Padding for alignment
+ * @cnid: Catalog Node ID of file
+ * @start_block: Starting allocation block number
+ */
 struct hfsplus_ext_key {
-	__be16 key_len;
-	u8 fork_type;
-	u8 pad;
-	hfsplus_cnid cnid;
-	__be32 start_block;
+/* 0x00 */
+	__be16 key_len;		/* 0x00 */
+	u8 fork_type;		/* 0x02 */
+	u8 pad;			/* 0x03 */
+	hfsplus_cnid cnid;	/* 0x04 */
+	__be32 start_block;	/* 0x08 */
+/* 0x0C */
 } __packed;
 
 #define HFSPLUS_EXT_KEYLEN	sizeof(struct hfsplus_ext_key)
@@ -357,43 +672,103 @@ struct hfsplus_ext_key {
 #define HFSPLUS_ATTR_FORK_DATA   0x20
 #define HFSPLUS_ATTR_EXTENTS     0x30
 
-/* HFS+ attributes tree key */
+/*
+ * struct hfsplus_attr_key - HFS+ attributes B-tree key
+ *
+ * Key structure for the attributes B-tree, which stores extended
+ * attributes (xattrs) for files and directories. Organized by
+ * file ID and attribute name.
+ *
+ * @key_len: Total length of key in bytes
+ * @pad: Padding for alignment
+ * @cnid: Catalog Node ID of file/directory
+ * @start_block: Starting block for extent attributes
+ * @key_name: Unicode attribute name
+ */
 struct hfsplus_attr_key {
-	__be16 key_len;
-	__be16 pad;
-	hfsplus_cnid cnid;
-	__be32 start_block;
-	struct hfsplus_attr_unistr key_name;
+/* 0x000 */
+	__be16 key_len;				/* 0x00 */
+	__be16 pad;				/* 0x02 */
+	hfsplus_cnid cnid;			/* 0x04 */
+	__be32 start_block;			/* 0x08 */
+	struct hfsplus_attr_unistr key_name;	/* 0x0C */
+/* 0x10C */
 } __packed;
 
 #define HFSPLUS_ATTR_KEYLEN	sizeof(struct hfsplus_attr_key)
 
-/* HFS+ fork data attribute */
+/*
+ * struct hfsplus_attr_fork_data - HFS+ fork-based attribute
+ *
+ * Used for large extended attributes that are stored as separate
+ * fork structures with their own extent records.
+ *
+ * @record_type: Record type (HFSPLUS_ATTR_FORK_DATA)
+ * @reserved: Reserved field
+ * @the_fork: Fork information and extents
+ */
 struct hfsplus_attr_fork_data {
-	__be32 record_type;
-	__be32 reserved;
-	struct hfsplus_fork_raw the_fork;
+/* 0x00 */
+	__be32 record_type;			/* 0x00 */
+	__be32 reserved;			/* 0x04 */
+	struct hfsplus_fork_raw the_fork;	/* 0x08 */
+/* 0x58 */
 } __packed;
 
-/* HFS+ extension attribute */
+/*
+ * struct hfsplus_attr_extents - HFS+ attribute extent record
+ *
+ * Used for extended attributes that require additional extent
+ * records beyond what fits in the fork structure.
+ *
+ * @record_type: Record type (HFSPLUS_ATTR_EXTENTS)
+ * @reserved: Reserved field
+ * @extents: Additional extent records
+ */
 struct hfsplus_attr_extents {
-	__be32 record_type;
-	__be32 reserved;
-	struct hfsplus_extent extents;
+/* 0x00 */
+	__be32 record_type;		/* 0x00 */
+	__be32 reserved;		/* 0x04 */
+	struct hfsplus_extent extents;	/* 0x08 */
+/* 0x48 */
 } __packed;
 
 #define HFSPLUS_MAX_INLINE_DATA_SIZE 3802
 
-/* HFS+ attribute inline data */
+/*
+ * struct hfsplus_attr_inline_data - HFS+ inline attribute data
+ *
+ * Used for small extended attributes that can be stored directly
+ * within the attributes B-tree record. Most efficient storage
+ * method for small attributes.
+ *
+ * @record_type: Record type (HFSPLUS_ATTR_INLINE_DATA)
+ * @reserved1: Reserved field
+ * @reserved2: Additional reserved bytes
+ * @length: Length of attribute data
+ * @raw_bytes: Actual attribute data
+ */
 struct hfsplus_attr_inline_data {
-	__be32 record_type;
-	__be32 reserved1;
-	u8 reserved2[6];
-	__be16 length;
-	u8 raw_bytes[HFSPLUS_MAX_INLINE_DATA_SIZE];
+/* 0x000 */
+	__be32 record_type;				/* 0x00 */
+	__be32 reserved1;				/* 0x04 */
+	u8 reserved2[6];				/* 0x08 */
+	__be16 length;					/* 0x0E */
+	u8 raw_bytes[HFSPLUS_MAX_INLINE_DATA_SIZE];	/* 0x10 */
+/* 0xEEA */
 } __packed;
 
-/* A data record in the attributes tree */
+/*
+ * union hfsplus_attr_entry - Generic HFS+ attribute record
+ *
+ * Union representing any type of attributes B-tree record.
+ * The first field (record_type) determines which variant to use.
+ *
+ * @record_type: Record type discriminator
+ * @fork_data: Fork-based attribute
+ * @extents: Extent-based attribute
+ * @inline_data: Inline attribute data
+ */
 typedef union {
 	__be32 record_type;
 	struct hfsplus_attr_fork_data fork_data;
@@ -401,7 +776,18 @@ typedef union {
 	struct hfsplus_attr_inline_data inline_data;
 } __packed hfsplus_attr_entry;
 
-/* HFS+ generic BTree key */
+/*
+ * union hfsplus_btree_key - Generic HFS+ B-tree key
+ *
+ * Union representing any HFS+ B-tree key type. The first field
+ * indicates the key length, and the specific key type is determined
+ * by context (catalog, extents, or attributes B-tree).
+ *
+ * @key_len: Key length (common to all key types)
+ * @cat: Catalog B-tree key
+ * @ext: Extents B-tree key
+ * @attr: Attributes B-tree key
+ */
 typedef union {
 	__be16 key_len;
 	struct hfsplus_cat_key cat;
-- 
2.43.0


