Return-Path: <linux-fsdevel+bounces-60399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBD4B466E2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 00:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2FC4AA43E9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 22:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9DA29E11D;
	Fri,  5 Sep 2025 22:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="MbIEFDX8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D016928BAB1
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 22:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757113098; cv=none; b=QTRWXAZSCesgysJV+BghHc1K7B7SjafBje8lYv+NmJ//DJXRo/V0GEXvYMMUQCpMXGm6OLZVpg93gZhURiQXU2DtVK7XTNI6UNriaWYrukHFQa3RqEwlmNsHC+HwIp08VaefmwMCwGHhAT08S3ONJ9nt8k2YS4KhwZ9LiU1BvFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757113098; c=relaxed/simple;
	bh=kYdJJPrmFpazS5k7oO81fz7UQ6SbwiJC6MWy1oTKDlE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m7AdCz8FERPA0dZKOPB4T4j5x+eYqpI3W640jvkEOe9Karcqc0vyzOvl6VBi0Hp+TNysFRgqFawiwOk5nysxF3zwjt1jJ+RlUpW4GTD+if8JezSVh1+5x4lrCuOGeyuDU8/JcXmFRciRs8naWRxD5wPGy+9MZN0bteTrqsAlSJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=MbIEFDX8; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e9d6cb1df67so2327194276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Sep 2025 15:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757113094; x=1757717894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GjrfdWnqoMcNuTz0liYpcZJdZZ2ZZWFLMPWcsbH+iVw=;
        b=MbIEFDX88Cs+J1O9UgfiLs+3sD9c+B66wLI1PcEi9Hf7avvfFtjzcshMZeq7of9RiF
         5KI8MOyNefbVTh+ucKn1YdJS7Gvw8guh9LyH933HM73Q1Vj1I8Fez0olEyX3eeL5t35v
         4KgBdhlEzFN9DSBtqtj9Mfx24DNg0ydVzOyQ/YLjKBzapxhI2DgDWJZmsx65ETB1VIK7
         6obOYFMiq0omIKwPZniQVNnf4eoqn9kXsERokbDknPXfKIG7wN3Xxj9yqE4w1x6te759
         7HXylsS2J6vAkWp1shh997HJ9ACPHdQDk5HTA5WrQWvUW15IdCA159/Od6XZbwpKmcBE
         wdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757113094; x=1757717894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjrfdWnqoMcNuTz0liYpcZJdZZ2ZZWFLMPWcsbH+iVw=;
        b=PXfWxJ+tP6dWbiC/20ec6xfAnBWwRFxI6z0n4emthPtcB+U6o8EDzZ6KpmRwZ3Blr0
         662m5Yhje2JGSQZO1mGrja+JX3aa7PNSfhwoPr0L4N3FCFqrpFUoBftjc/6q/uG6Js2w
         +M54coLYJkkQahVSJ0MGzV7nU7SvFFod9G0l6OCfbgQ5nyIQwQOohrERMVilD2yL1/Iu
         JK9jzNb3r0NI+az0pfDdcYNsRdS2xe4/fSaANaTedc3uqPhbVMBludrIuuYwYHl3Jnvx
         bw6OaEfZT6qRGc/dHCZZjolQGjltpDxuCv3ZfvtvmmJBDmAL9xawX3rQr7CeEm8vgTem
         RLLA==
X-Forwarded-Encrypted: i=1; AJvYcCWy39zbU1DVjCLRTW6qYiXcGZAkAG2J7oASa9uRITPWeVkibJGli4pOhlaHy4UxVKBu7dpyMQG/glo4SvVg@vger.kernel.org
X-Gm-Message-State: AOJu0YytAaIl52i+0rFVUj85+MbBfJiXlZK/NHUl2ZTbE/jQv49K7owU
	I9sLxuBLYPaYhUhNPK1TBWWY45PCqU5OHi6S5M8KLpz5b7sGcylkKJ1S9Qzv0YtpyouKxjcveEc
	2AEUGBYw=
X-Gm-Gg: ASbGncs92SoKY3zU5KZFERCRKedr6iPFRszC0mkfaMVJQJrG0hT9/uBlqSPZU/0JNxs
	rdYS8R6LWS0aH/mW52cHCFCcclRRSSsuKqMCTEf1PKfm3NKz97HK2DYPujJaHEixiTQN8y+I4dw
	NfMdArPDFiWwV3AhHqutKZyRuvY0B8okxl06OvUp85q30RD1ZOjVygNc0Wrezofdf7Kk5uS0lOM
	hOrJqgpOsxpJmHXYqO/LcWsnYFc9AJ2LYo9tlq3eoYGHH+DoM/ETQpAQWUUfso0x05yH6S8wdyx
	phq+FojnD9K8StQadIZJIhRpyV255+3/oye7JKYX/IEyT7CjA4W+nLdZ9Q/ndH/ob5J6fBq5ZSy
	vlGUJ2KjOhP1eosXr/3L3ZeIk4s/wsfzsIwbDv4vW8arvmBq3cCT9W8Q=
X-Google-Smtp-Source: AGHT+IFQ8Z+lYQs750eKBDZxwx3jXtoFI2CFKsuefwwjdUGSE7IWRAkaQ0FcF5jxl9PH2c+fvk5uaQ==
X-Received: by 2002:a05:690c:9a90:b0:721:6b2e:a073 with SMTP id 00721157ae682-727f5934195mr5886727b3.45.1757113093491;
        Fri, 05 Sep 2025 15:58:13 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:558b:a8eb:2672:42af])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a8503a56sm33287877b3.45.2025.09.05.15.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 15:58:12 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfs: add and rework comments for key metadata structures
Date: Fri,  5 Sep 2025 15:57:40 -0700
Message-Id: <20250905225739.739533-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we have not good enough comments for
HFS metadata structures.

Claude AI generated comments for key HFS metadata
structures. These comments have been reviewed, checked,
and corrected. This patch adds and reworks comments for
key HFS metadata structures.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfs/btree.h  | 131 +++++++++---
 fs/hfs/hfs.h    | 518 ++++++++++++++++++++++++++++++++++++------------
 fs/hfs/hfs_fs.h | 152 ++++++++------
 3 files changed, 588 insertions(+), 213 deletions(-)

diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
index 0e6baee93245..8c0a61d4f70a 100644
--- a/fs/hfs/btree.h
+++ b/fs/hfs/btree.h
@@ -20,7 +20,35 @@ enum hfs_btree_mutex_classes {
 	ATTR_BTREE_MUTEX,
 };
 
-/* A HFS BTree held in memory */
+/*
+ * struct hfs_btree - In-memory B-tree representation
+ *
+ * This structure represents a complete HFS B-tree in memory, containing
+ * both metadata from the on-disk B-tree header and runtime state needed
+ * for efficient B-tree operations. HFS uses B-trees for the catalog
+ * (directory structure) and extents overflow (file extent records).
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
@@ -49,7 +77,29 @@ struct hfs_btree {
 	int node_hash_cnt;
 };
 
-/* A HFS BTree node in memory */
+/*
+ * struct hfs_bnode - In-memory B-tree node
+ *
+ * Represents a single B-tree node in memory, containing both the
+ * on-disk node metadata and runtime state for caching, locking,
+ * and reference counting. Nodes are cached in a hash table for
+ * efficient access.
+ *
+ * @tree: Parent B-tree this node belongs to
+ * @prev: Node ID of previous node at this level
+ * @this: This node's ID
+ * @next: Node ID of next node at this level
+ * @parent: Node ID of parent node
+ * @num_recs: Number of records in this node
+ * @type: Node type (index, leaf, header, map)
+ * @height: Height in B-tree (1=leaf, >1=internal)
+ * @next_hash: Next node in hash chain
+ * @flags: Node state flags (error, new, deleted)
+ * @lock_wq: Wait queue for node locking
+ * @refcnt: Reference count for memory management
+ * @page_offset: Offset within first page
+ * @page: Array of memory pages holding node data
+ */
 struct hfs_bnode {
 	struct hfs_btree *tree;
 
@@ -74,6 +124,24 @@ struct hfs_bnode {
 #define HFS_BNODE_NEW		1
 #define HFS_BNODE_DELETED	2
 
+/*
+ * struct hfs_find_data - B-tree search operation context
+ *
+ * This structure maintains the state of a B-tree search operation,
+ * tracking the current position, search parameters, and results.
+ * Used by the B-tree search and iteration functions to maintain
+ * context across multiple calls.
+ *
+ * @key: Current key at search position
+ * @search_key: Key being searched for
+ * @tree: B-tree being searched
+ * @bnode: Current node in search
+ * @record: Current record index within node
+ * @keyoffset: Offset of current key
+ * @keylength: Length of current key
+ * @entryoffset: Offset of current data
+ * @entrylength: Length of current data
+ */
 struct hfs_find_data {
 	btree_key *key;
 	btree_key *search_key;
@@ -130,13 +198,21 @@ extern int hfs_brec_read(struct hfs_find_data *, void *, int);
 extern int hfs_brec_goto(struct hfs_find_data *, int);
 
 
+/*
+ * struct hfs_bnode_desc - On-disk B-tree node descriptor
+ *
+ * This structure appears at the beginning of every B-tree node on disk.
+ * It provides essential metadata for navigating the B-tree structure
+ * and understanding the node's contents. Fields marked (V) are variable
+ * and may change; fields marked (F) are fixed at B-tree creation.
+ */
 struct hfs_bnode_desc {
-	__be32 next;		/* (V) Number of the next node at this level */
-	__be32 prev;		/* (V) Number of the prev node at this level */
-	u8 type;		/* (F) The type of node */
-	u8 height;		/* (F) The level of this node (leaves=1) */
-	__be16 num_recs;	/* (V) The number of records in this node */
-	u16 reserved;
+	__be32 next;		/* (V) Node ID of next node at same level */
+	__be32 prev;		/* (V) Node ID of previous node at same level */
+	u8 type;		/* (F) Node type: index/header/map/leaf */
+	u8 height;		/* (F) Distance from leaves (leaves=1) */
+	__be16 num_recs;	/* (V) Number of records stored in this node */
+	u16 reserved;		/* Reserved space for alignment */
 } __packed;
 
 #define HFS_NODE_INDEX	0x00	/* An internal (index) node */
@@ -144,22 +220,31 @@ struct hfs_bnode_desc {
 #define HFS_NODE_MAP	0x02	/* Holds part of the bitmap of used nodes */
 #define HFS_NODE_LEAF	0xFF	/* A leaf (ndNHeight==1) node */
 
+/*
+ * struct hfs_btree_header_rec - B-tree header record
+ *
+ * This structure is stored as the first record in the header node
+ * (node 0) of every HFS B-tree. It contains essential metadata about
+ * the B-tree structure, organization, and current state. Fields marked
+ * (V) are variable and updated during B-tree operations; fields marked
+ * (F) are fixed at B-tree creation time.
+ */
 struct hfs_btree_header_rec {
-	__be16 depth;		/* (V) The number of levels in this B-tree */
-	__be32 root;		/* (V) The node number of the root node */
-	__be32 leaf_count;	/* (V) The number of leaf records */
-	__be32 leaf_head;	/* (V) The number of the first leaf node */
-	__be32 leaf_tail;	/* (V) The number of the last leaf node */
-	__be16 node_size;	/* (F) The number of bytes in a node (=512) */
-	__be16 max_key_len;	/* (F) The length of a key in an index node */
-	__be32 node_count;	/* (V) The total number of nodes */
-	__be32 free_nodes;	/* (V) The number of unused nodes */
-	u16 reserved1;
-	__be32 clump_size;	/* (F) clump size. not usually used. */
-	u8 btree_type;		/* (F) BTree type */
-	u8 reserved2;
-	__be32 attributes;	/* (F) attributes */
-	u32 reserved3[16];
+	__be16 depth;		/* (V) Number of levels in B-tree (root to leaf) */
+	__be32 root;		/* (V) Node ID of the root node */
+	__be32 leaf_count;	/* (V) Total number of data records in leaves */
+	__be32 leaf_head;	/* (V) Node ID of first (leftmost) leaf */
+	__be32 leaf_tail;	/* (V) Node ID of last (rightmost) leaf */
+	__be16 node_size;	/* (F) Size of each B-tree node in bytes (512) */
+	__be16 max_key_len;	/* (F) Maximum key length for index nodes */
+	__be32 node_count;	/* (V) Total number of nodes allocated */
+	__be32 free_nodes;	/* (V) Number of unused nodes available */
+	u16 reserved1;		/* Reserved field for future use */
+	__be32 clump_size;	/* (F) Allocation clump size (rarely used) */
+	u8 btree_type;		/* (F) Type identifier for this B-tree */
+	u8 reserved2;		/* Reserved field for alignment */
+	__be32 attributes;	/* (F) B-tree feature flags and attributes */
+	u32 reserved3[16];	/* Reserved space for future expansion */
 } __packed;
 
 #define BTREE_ATTR_BADCLOSE	0x00000001	/* b-tree not closed properly. not
diff --git a/fs/hfs/hfs.h b/fs/hfs/hfs.h
index 6f194d0768b6..6b14f0ca36aa 100644
--- a/fs/hfs/hfs.h
+++ b/fs/hfs/hfs.h
@@ -83,88 +83,222 @@
 
 /*======== HFS structures as they appear on the disk ========*/
 
-/* Pascal-style string of up to 31 characters */
+/*
+ * struct hfs_name - HFS Pascal-style filename
+ *
+ * HFS uses Pascal-style strings with a length byte followed by
+ * the actual characters. Maximum filename length is 31 characters.
+ *
+ * @len: Length of filename (0-31)
+ * @name: Filename characters (not null-terminated)
+ */
 struct hfs_name {
-	u8 len;
-	u8 name[HFS_NAMELEN];
+/* 0x00 */
+	u8 len;				/* 0x00 */
+	u8 name[HFS_NAMELEN];		/* 0x01 */
+/* 0x20 */
 } __packed;
 
+/*
+ * struct hfs_point - 2D coordinate point for Finder display
+ *
+ * Used by the Finder for positioning icons and windows.
+ *
+ * @v: Vertical coordinate
+ * @h: Horizontal coordinate
+ */
 struct hfs_point {
-	__be16 v;
-	__be16 h;
+/* 0x00 */
+	__be16 v;			/* 0x00 */
+	__be16 h;			/* 0x02 */
+/* 0x04 */
 } __packed;
 
+/*
+ * struct hfs_rect - Rectangle coordinates for Finder display
+ *
+ * Defines a rectangular area used by the Finder for windows
+ * and icon positioning.
+ *
+ * @top: Top edge coordinate
+ * @left: Left edge coordinate
+ * @bottom: Bottom edge coordinate
+ * @right: Right edge coordinate
+ */
 struct hfs_rect {
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
 
+/*
+ * struct hfs_finfo - Finder information for files
+ *
+ * Contains metadata used by the Mac OS Finder to display
+ * and handle files, including type, creator, and location.
+ *
+ * @fdType: File type (4-character code)
+ * @fdCreator: Creator application (4-character code)
+ * @fdFlags: Finder flags (visibility, lock, etc.)
+ * @fdLocation: Icon position in folder window
+ * @fdFldr: Folder containing the file
+ */
 struct hfs_finfo {
-	__be32 fdType;
-	__be32 fdCreator;
-	__be16 fdFlags;
-	struct hfs_point fdLocation;
-	__be16 fdFldr;
+/* 0x00 */
+	__be32 fdType;			/* 0x00 */
+	__be32 fdCreator;		/* 0x04 */
+	__be16 fdFlags;			/* 0x08 */
+	struct hfs_point fdLocation;	/* 0x0A */
+	__be16 fdFldr;			/* 0x0E */
+/* 0x10 */
 } __packed;
 
+/*
+ * struct hfs_fxinfo - Extended Finder information for files
+ *
+ * Additional metadata used by the Finder, including custom
+ * icon references and comment associations.
+ *
+ * @fdIconID: Custom icon resource ID
+ * @fdUnused: Reserved/unused bytes
+ * @fdComment: Comment resource ID
+ * @fdPutAway: Directory ID for "Put Away" command
+ */
 struct hfs_fxinfo {
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
 
+/*
+ * struct hfs_dinfo - Finder information for directories
+ *
+ * Contains metadata used by the Finder to display directory
+ * windows, including position, size, and view settings.
+ *
+ * @frRect: Directory window rectangle
+ * @frFlags: Directory window flags
+ * @frLocation: Directory window position
+ * @frView: Directory view type (icon, list, etc.)
+ */
 struct hfs_dinfo {
-	struct hfs_rect frRect;
-	__be16 frFlags;
-	struct hfs_point frLocation;
-	__be16 frView;
+/* 0x00 */
+	struct hfs_rect frRect;		/* 0x00 */
+	__be16 frFlags;			/* 0x08 */
+	struct hfs_point frLocation;	/* 0x0A */
+	__be16 frView;			/* 0x0E */
+/* 0x10 */
 } __packed;
 
+/*
+ * struct hfs_dxinfo - Extended Finder information for directories
+ *
+ * Additional directory display metadata including scroll position
+ * and comment references.
+ *
+ * @frScroll: Scroll position in directory window
+ * @frOpenChain: Linked list of open directory windows
+ * @frUnused: Reserved/unused field
+ * @frComment: Comment resource ID for directory
+ * @frPutAway: Directory ID for "Put Away" command
+ */
 struct hfs_dxinfo {
-	struct hfs_point frScroll;
-	__be32 frOpenChain;
-	__be16 frUnused;
-	__be16 frComment;
-	__be32 frPutAway;
+/* 0x00 */
+	struct hfs_point frScroll;	/* 0x00 */
+	__be32 frOpenChain;		/* 0x04 */
+	__be16 frUnused;		/* 0x08 */
+	__be16 frComment;		/* 0x0A */
+	__be32 frPutAway;		/* 0x0C */
+/* 0x10 */
 } __packed;
 
+/*
+ * union hfs_finder_info - Combined Finder metadata
+ *
+ * Union containing either file or directory Finder information.
+ * The type of entry determines which variant to use.
+ */
 union hfs_finder_info {
+/* 0x00 */
 	struct {
-		struct hfs_finfo finfo;
-		struct hfs_fxinfo fxinfo;
+		struct hfs_finfo finfo;		/* Basic file Finder info */
+		struct hfs_fxinfo fxinfo;	/* Extended file Finder info */
 	} file;
 	struct {
-		struct hfs_dinfo dinfo;
-		struct hfs_dxinfo dxinfo;
+		struct hfs_dinfo dinfo;		/* Basic directory Finder info */
+		struct hfs_dxinfo dxinfo;	/* Extended directory Finder info */
 	} dir;
+/* 0x20 */
 } __packed;
 
 /* Cast to a pointer to a generic bkey */
 #define	HFS_BKEY(X)	(((void)((X)->KeyLen)), ((struct hfs_bkey *)(X)))
 
-/* The key used in the catalog b-tree: */
+/*
+ * struct hfs_cat_key - Catalog B-tree search key
+ *
+ * Key structure used for searching the catalog B-tree. Entries are
+ * organized by parent directory ID and filename, allowing efficient
+ * lookups and directory traversals.
+ *
+ * @key_len: Total length of key in bytes
+ * @reserved: Padding byte for alignment
+ * @ParID: Catalog Node ID of parent directory
+ * @CName: Filename within the parent directory
+ */
 struct hfs_cat_key {
-	u8 key_len;		/* number of bytes in the key */
-	u8 reserved;		/* padding */
-	__be32 ParID;		/* CNID of the parent dir */
-	struct hfs_name	CName;	/* The filename of the entry */
+/* 0x00 */
+	u8 key_len;		/* 0x00 */
+	u8 reserved;		/* 0x01 */
+	__be32 ParID;		/* 0x02 */
+	struct hfs_name	CName;	/* 0x06 */
+/* 0x26 */
 } __packed;
 
-/* The key used in the extents b-tree: */
+/*
+ * struct hfs_ext_key - Extents overflow B-tree search key
+ *
+ * Key structure for the extents overflow B-tree, which stores
+ * additional extent records when files need more than the 3
+ * extents stored in the catalog record.
+ *
+ * @key_len: Total length of key in bytes
+ * @FkType: Fork type: HFS_FK_DATA or HFS_FK_RSRC
+ * @FNum: Catalog Node ID (File ID) of the file
+ * @FABN: Starting allocation block number for extents
+ */
 struct hfs_ext_key {
-	u8 key_len;		/* number of bytes in the key */
-	u8 FkType;		/* HFS_FK_{DATA,RSRC} */
-	__be32 FNum;		/* The File ID of the file */
-	__be16 FABN;		/* allocation blocks number*/
+/* 0x00 */
+	u8 key_len;		/* 0x00 */
+	u8 FkType;		/* 0x01 */
+	__be32 FNum;		/* 0x02 */
+	__be16 FABN;		/* 0x06 */
+/* 0x08 */
 } __packed;
 
+/*
+ * union hfs_btree_key - Generic B-tree key
+ *
+ * Union representing any HFS B-tree key type. The first byte
+ * indicates the key length, and the specific key type is
+ * determined by context (catalog or extents B-tree).
+ *
+ * @key_len: Key length (common to all key types)
+ * @cat: Catalog B-tree key
+ * @ext: Extents B-tree key
+ */
 typedef union hfs_btree_key {
-	u8 key_len;			/* number of bytes in the key */
+/* 0x00 */
+	u8 key_len;
 	struct hfs_cat_key cat;
 	struct hfs_ext_key ext;
+/* 0x26 */
 } hfs_btree_key;
 
 #define HFS_MAX_CAT_KEYLEN	(sizeof(struct hfs_cat_key) - sizeof(u8))
@@ -172,114 +306,240 @@ typedef union hfs_btree_key {
 
 typedef union hfs_btree_key btree_key;
 
+/*
+ * struct hfs_extent - File extent descriptor
+ *
+ * Describes a contiguous range of allocation blocks belonging
+ * to a file. Multiple extents can describe a fragmented file.
+ *
+ * @block: Starting allocation block number
+ * @count: Number of contiguous blocks
+ */
 struct hfs_extent {
-	__be16 block;
-	__be16 count;
+/* 0x00 */
+	__be16 block;		/* 0x00 */
+	__be16 count;		/* 0x02 */
+/* 0x04 */
 };
+
+/*
+ * hfs_extent_rec - Array of 3 extent descriptors
+ *
+ * HFS stores up to 3 extent records directly in catalog entries.
+ * Additional extents for fragmented files are stored in the
+ * extents overflow B-tree.
+ */
 typedef struct hfs_extent hfs_extent_rec[3];
 
-/* The catalog record for a file */
+/*
+ * struct hfs_cat_file - Catalog record for regular files
+ *
+ * Complete metadata for a regular file stored in the catalog B-tree.
+ * Contains both data and resource fork information, Finder metadata,
+ * timestamps, and the first 3 extent records for each fork.
+ *
+ * @type: Record type (HFS_CDR_FIL)
+ * @reserved: Reserved byte for alignment
+ * @Flags: File flags (locked, open, etc.)
+ * @Typ: File version number (always 0)
+ * @UsrWds: Finder information for file
+ * @FlNum: Catalog Node ID (unique file ID)
+ * @StBlk: Obsolete: starting block (unused)
+ * @LgLen: Logical EOF of data fork (file size)
+ * @PyLen: Physical EOF of data fork (disk space)
+ * @RStBlk: Obsolete: resource fork start block
+ * @RLgLen: Logical EOF of resource fork
+ * @RPyLen: Physical EOF of resource fork
+ * @CrDat: File creation date/time
+ * @MdDat: File modification date/time
+ * @BkDat: Last backup date/time
+ * @FndrInfo: Extended Finder information
+ * @ClpSize: Clump size: bytes to allocate when extending this file
+ * @ExtRec: First 3 extent records for data fork
+ * @RExtRec: First 3 extent records for resource fork
+ * @Resrv: Reserved field for future use
+ */
 struct hfs_cat_file {
-	s8 type;			/* The type of entry */
-	u8 reserved;
-	u8 Flags;			/* Flags such as read-only */
-	s8 Typ;				/* file version number = 0 */
-	struct hfs_finfo UsrWds;	/* data used by the Finder */
-	__be32 FlNum;			/* The CNID */
-	__be16 StBlk;			/* obsolete */
-	__be32 LgLen;			/* The logical EOF of the data fork*/
-	__be32 PyLen;			/* The physical EOF of the data fork */
-	__be16 RStBlk;			/* obsolete */
-	__be32 RLgLen;			/* The logical EOF of the rsrc fork */
-	__be32 RPyLen;			/* The physical EOF of the rsrc fork */
-	__be32 CrDat;			/* The creation date */
-	__be32 MdDat;			/* The modified date */
-	__be32 BkDat;			/* The last backup date */
-	struct hfs_fxinfo FndrInfo;	/* more data for the Finder */
-	__be16 ClpSize;			/* number of bytes to allocate
-					   when extending files */
-	hfs_extent_rec ExtRec;		/* first extent record
-					   for the data fork */
-	hfs_extent_rec RExtRec;		/* first extent record
-					   for the resource fork */
-	u32 Resrv;			/* reserved by Apple */
+/* 0x00 */
+	s8 type;			/* 0x00 */
+	u8 reserved;			/* 0x01 */
+	u8 Flags;			/* 0x02 */
+	s8 Typ;				/* 0x03 */
+	struct hfs_finfo UsrWds;	/* 0x04 */
+	__be32 FlNum;			/* 0x14 */
+	__be16 StBlk;			/* 0x18 */
+	__be32 LgLen;			/* 0x1A */
+	__be32 PyLen;			/* 0x1E */
+	__be16 RStBlk;			/* 0x22 */
+	__be32 RLgLen;			/* 0x24 */
+	__be32 RPyLen;			/* 0x28 */
+	__be32 CrDat;			/* 0x2C */
+	__be32 MdDat;			/* 0x30 */
+	__be32 BkDat;			/* 0x34 */
+	struct hfs_fxinfo FndrInfo;	/* 0x38 */
+	__be16 ClpSize;			/* 0x48 */
+	hfs_extent_rec ExtRec;		/* 0x4A */
+	hfs_extent_rec RExtRec;		/* 0x56 */
+	u32 Resrv;			/* 0x62 */
+/* 0x66 */
 } __packed;
 
-/* the catalog record for a directory */
+/*
+ * struct hfs_cat_dir - Catalog record for directories
+ *
+ * Complete metadata for a directory stored in the catalog B-tree.
+ * Contains directory-specific information including item count,
+ * Finder display settings, and timestamps.
+ *
+ * @type: Record type (HFS_CDR_DIR)
+ * @reserved: Reserved byte for alignment
+ * @Flags: Directory flags (locked, mounted, etc.)
+ * @Val: Valence: total number of items (files + subdirs) in directory
+ * @DirID: Catalog Node ID (unique directory ID)
+ * @CrDat: Directory creation date/time
+ * @MdDat: Directory modification date/time
+ * @BkDat: Last backup date/time
+ * @UsrInfo: Finder display information
+ * @FndrInfo: Extended Finder information
+ * @Resrv: Reserved space for future use
+ */
 struct hfs_cat_dir {
-	s8 type;			/* The type of entry */
-	u8 reserved;
-	__be16 Flags;			/* flags */
-	__be16 Val;			/* Valence: number of files and
-					   dirs in the directory */
-	__be32 DirID;			/* The CNID */
-	__be32 CrDat;			/* The creation date */
-	__be32 MdDat;			/* The modification date */
-	__be32 BkDat;			/* The last backup date */
-	struct hfs_dinfo UsrInfo;	/* data used by the Finder */
-	struct hfs_dxinfo FndrInfo;	/* more data used by Finder */
-	u8 Resrv[16];			/* reserved by Apple */
+/* 0x00 */
+	s8 type;			/* 0x00 */
+	u8 reserved;			/* 0x01 */
+	__be16 Flags;			/* 0x02 */
+	__be16 Val;			/* 0x04 */
+	__be32 DirID;			/* 0x06 */
+	__be32 CrDat;			/* 0x0A */
+	__be32 MdDat;			/* 0x0E */
+	__be32 BkDat;			/* 0x12 */
+	struct hfs_dinfo UsrInfo;	/* 0x16 */
+	struct hfs_dxinfo FndrInfo;	/* 0x26 */
+	u8 Resrv[16];			/* 0x36 */
+/* 0x46 */
 } __packed;
 
-/* the catalog record for a thread */
+/*
+ * struct hfs_cat_thread - Catalog thread record
+ *
+ * Thread records provide reverse lookup capability in the catalog
+ * B-tree, allowing navigation from a file/directory ID back to its
+ * parent directory and name. Required for hard link support.
+ *
+ * @type: Record type (HFS_CDR_THD or HFS_CDR_FTH)
+ * @reserved: Reserved bytes for alignment
+ * @ParID: Catalog Node ID of parent directory
+ * @CName: Name of the file/directory
+ */
 struct hfs_cat_thread {
-	s8 type;			/* The type of entry */
-	u8 reserved[9];			/* reserved by Apple */
-	__be32 ParID;			/* CNID of parent directory */
-	struct hfs_name CName;		/* The name of this entry */
+/* 0x00 */
+	s8 type;			/* 0x00 */
+	u8 reserved[9];			/* 0x01 */
+	__be32 ParID;			/* 0x0A */
+	struct hfs_name CName;		/* 0x0E */
+/* 0x2E */
 }  __packed;
 
-/* A catalog tree record */
+/*
+ * union hfs_cat_rec - Generic catalog record
+ *
+ * Union representing any type of catalog B-tree record.
+ * The first byte (type) determines which variant to use:
+ * HFS_CDR_FIL (file), HFS_CDR_DIR (directory),
+ * HFS_CDR_THD/HFS_CDR_FTH (thread records).
+ */
 typedef union hfs_cat_rec {
-	s8 type;			/* The type of entry */
-	struct hfs_cat_file file;
-	struct hfs_cat_dir dir;
-	struct hfs_cat_thread thread;
+	s8 type;			/* Record type discriminator */
+	struct hfs_cat_file file;	/* File record (type == HFS_CDR_FIL) */
+	struct hfs_cat_dir dir;		/* Directory record (type == HFS_CDR_DIR) */
+	struct hfs_cat_thread thread;	/* Thread record (type == HFS_CDR_*TH) */
 } hfs_cat_rec;
 
+/*
+ * struct hfs_mdb - Master Directory Block (HFS Superblock)
+ *
+ * The Master Directory Block is the primary metadata structure of an HFS
+ * filesystem, equivalent to a superblock in other filesystems. It contains
+ * essential filesystem parameters, allocation information, B-tree locations,
+ * and statistics. Located at block 2 of the HFS partition.
+ *
+ * @drSigWord: Filesystem signature (HFS_SUPER_MAGIC)
+ * @drCrDate: Filesystem creation timestamp
+ * @drLsMod: Last modification timestamp
+ * @drAtrb: Volume attributes flags
+ * @drNmFls: Number of files in root directory
+ * @drVBMSt: Starting block of volume bitmap (in 512-byte sectors)
+ * @drAllocPtr: Next allocation search start point (in allocation blocks)
+ * @drNmAlBlks: Total number of allocation blocks
+ * @drAlBlkSiz: Size of each allocation block in bytes
+ * @drClpSiz: Default clump size: bytes to allocate when extending files
+ * @drAlBlSt: Starting block of allocation area (in 512-byte sectors)
+ * @drNxtCNID: Next available Catalog Node ID for new files/directories
+ * @drFreeBks: Number of free allocation blocks
+ * @drVN: Volume name (Pascal string, 27 chars max)
+ * @drVolBkUp: Volume backup timestamp
+ * @drVSeqNum: Backup sequence number
+ * @drWrCnt: Filesystem write operation counter
+ * @drXTClpSiz: Clump size for extents overflow B-tree
+ * @drCTClpSiz: Clump size for catalog B-tree
+ * @drNmRtDirs: Number of directories in root directory
+ * @drFilCnt: Total number of files in filesystem
+ * @drDirCnt: Total number of directories in filesystem
+ * @drFndrInfo: Finder information and boot parameters
+ * @drEmbedSigWord: Signature of embedded volume (if any)
+ * @drEmbedExtent: Embedded volume extent: starting block number and block count combined
+ * @drXTFlSize: Logical size of extents B-tree file
+ * @drXTExtRec: First 3 extent records for extents B-tree
+ * @drCTFlSize: Logical size of catalog B-tree file
+ * @drCTExtRec: First 3 extent records for catalog B-tree
+ */
 struct hfs_mdb {
-	__be16 drSigWord;		/* Signature word indicating fs type */
-	__be32 drCrDate;		/* fs creation date/time */
-	__be32 drLsMod;			/* fs modification date/time */
-	__be16 drAtrb;			/* fs attributes */
-	__be16 drNmFls;			/* number of files in root directory */
-	__be16 drVBMSt;			/* location (in 512-byte blocks)
-					   of the volume bitmap */
-	__be16 drAllocPtr;		/* location (in allocation blocks)
-					   to begin next allocation search */
-	__be16 drNmAlBlks;		/* number of allocation blocks */
-	__be32 drAlBlkSiz;		/* bytes in an allocation block */
-	__be32 drClpSiz;		/* clumpsize, the number of bytes to
-					   allocate when extending a file */
-	__be16 drAlBlSt;		/* location (in 512-byte blocks)
-					   of the first allocation block */
-	__be32 drNxtCNID;		/* CNID to assign to the next
-					   file or directory created */
-	__be16 drFreeBks;		/* number of free allocation blocks */
-	u8 drVN[28];			/* the volume label */
-	__be32 drVolBkUp;		/* fs backup date/time */
-	__be16 drVSeqNum;		/* backup sequence number */
-	__be32 drWrCnt;			/* fs write count */
-	__be32 drXTClpSiz;		/* clumpsize for the extents B-tree */
-	__be32 drCTClpSiz;		/* clumpsize for the catalog B-tree */
-	__be16 drNmRtDirs;		/* number of directories in
-					   the root directory */
-	__be32 drFilCnt;		/* number of files in the fs */
-	__be32 drDirCnt;		/* number of directories in the fs */
-	u8 drFndrInfo[32];		/* data used by the Finder */
-	__be16 drEmbedSigWord;		/* embedded volume signature */
-	__be32 drEmbedExtent;		/* starting block number (xdrStABN)
-					   and number of allocation blocks
-					   (xdrNumABlks) occupied by embedded
-					   volume */
-	__be32 drXTFlSize;		/* bytes in the extents B-tree */
-	hfs_extent_rec drXTExtRec;	/* extents B-tree's first 3 extents */
-	__be32 drCTFlSize;		/* bytes in the catalog B-tree */
-	hfs_extent_rec drCTExtRec;	/* catalog B-tree's first 3 extents */
+/* 0x00 */
+	__be16 drSigWord;		/* 0x00 */
+	__be32 drCrDate;		/* 0x02 */
+	__be32 drLsMod;			/* 0x06 */
+	__be16 drAtrb;			/* 0x0A */
+	__be16 drNmFls;			/* 0x0C */
+	__be16 drVBMSt;			/* 0x0E */
+	__be16 drAllocPtr;		/* 0x10 */
+	__be16 drNmAlBlks;		/* 0x12 */
+	__be32 drAlBlkSiz;		/* 0x14 */
+	__be32 drClpSiz;		/* 0x18 */
+	__be16 drAlBlSt;		/* 0x1C */
+	__be32 drNxtCNID;		/* 0x1E */
+	__be16 drFreeBks;		/* 0x22 */
+	u8 drVN[28];			/* 0x24 */
+	__be32 drVolBkUp;		/* 0x40 */
+	__be16 drVSeqNum;		/* 0x44 */
+	__be32 drWrCnt;			/* 0x46 */
+	__be32 drXTClpSiz;		/* 0x4A */
+	__be32 drCTClpSiz;		/* 0x4E */
+	__be16 drNmRtDirs;		/* 0x52 */
+	__be32 drFilCnt;		/* 0x54 */
+	__be32 drDirCnt;		/* 0x58 */
+	u8 drFndrInfo[32];		/* 0x5C */
+	__be16 drEmbedSigWord;		/* 0x7C */
+	__be32 drEmbedExtent;		/* 0x7E */
+	__be32 drXTFlSize;		/* 0x82 */
+	hfs_extent_rec drXTExtRec;	/* 0x86 */
+	__be32 drCTFlSize;		/* 0x92 */
+	hfs_extent_rec drCTExtRec;	/* 0x96 */
+/* 0xA2 */
 } __packed;
 
 /*======== Data structures kept in memory ========*/
 
+/*
+ * struct hfs_readdir_data - Directory reading state
+ *
+ * Runtime structure used to track the state of directory reading
+ * operations. Maintains position and context for readdir() calls
+ * to ensure consistent directory traversal.
+ *
+ * @list: List linkage for multiple readers
+ * @file: Associated file descriptor
+ * @key: Current position in directory
+ */
 struct hfs_readdir_data {
 	struct list_head list;
 	struct file *file;
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index 7c5a7ecfa246..3698eca73567 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -54,16 +54,36 @@ do {								\
 
 
 /*
- * struct hfs_inode_info
+ * struct hfs_inode_info - HFS-specific inode information
  *
- * The HFS-specific part of a Linux (struct inode)
+ * This structure contains HFS-specific metadata for each inode,
+ * extending the standard Linux VFS inode with HFS filesystem details.
+ * It handles file extents, resource forks, and catalog information.
+ *
+ * @opencnt: Number of open file handles
+ * @flags: HFS-specific inode flags (HFS_FLG_*)
+ * @tz_secondswest: Timezone offset in seconds west of GMT (to deal with localtime ugliness)
+ * @cat_key: Catalog B-tree key for this inode
+ * @open_dir_list: List of open directory entries
+ * @open_dir_lock: Lock protecting open_dir_list
+ * @rsrc_inode: Resource fork inode (if any)
+ * @extents_lock: Mutex protecting extent information
+ * @alloc_blocks: Number of allocated blocks for file
+ * @clump_blocks: Clump size in allocation blocks
+ * @fs_blocks: File size in filesystem blocks
+ * @first_extents: First 3 extent records from catalog
+ * @first_blocks: Number of blocks in first_extents
+ * @cached_extents: Cached extent records from extents B-tree
+ * @cached_start: Starting allocation block of cached extents
+ * @cached_blocks: Number of blocks in cached_extents
+ * @phys_size: Physical size of file on disk
+ * @vfs_inode: Embedded VFS inode structure
  */
 struct hfs_inode_info {
 	atomic_t opencnt;
 
 	unsigned int flags;
 
-	/* to deal with localtime ugliness */
 	int tz_secondswest;
 
 	struct hfs_cat_key cat_key;
@@ -76,7 +96,6 @@ struct hfs_inode_info {
 
 	u16 alloc_blocks, clump_blocks;
 	sector_t fs_blocks;
-	/* Allocation extents from catlog record or volume header */
 	hfs_extent_rec first_extents;
 	u16 first_blocks;
 	hfs_extent_rec cached_extents;
@@ -93,66 +112,77 @@ struct hfs_inode_info {
 #define HFS_IS_RSRC(inode)	(HFS_I(inode)->flags & HFS_FLG_RSRC)
 
 /*
- * struct hfs_sb_info
+ * struct hfs_sb_info - HFS-specific superblock information
+ *
+ * This structure contains all HFS-specific filesystem metadata,
+ * extending the Linux VFS superblock. It manages the Master Directory
+ * Block (MDB), allocation bitmap, B-trees, and various filesystem
+ * parameters and mount options.
  *
- * The HFS-specific part of a Linux (struct super_block)
+ * @mdb_bh: Buffer holding the Master Directory Block (superblock/VIB/MDB)
+ * @mdb: Pointer to parsed MDB structure
+ * @alt_mdb_bh: Buffer holding the alternate copy of MDB
+ * @alt_mdb: Pointer to alternate MDB
+ * @bitmap: Allocation bitmap for tracking free/used blocks
+ * @ext_tree: Extents overflow B-tree for managing file extents
+ * @cat_tree: Catalog B-tree containing directory structure and metadata
+ * @file_count: Total number of regular files in the filesystem
+ * @folder_count: Total number of directories in the filesystem
+ * @next_id: Next available catalog node ID for new files/directories
+ * @clumpablks: Default clump size in allocation blocks for extending files
+ * @fs_start: First 512-byte block represented in the allocation bitmap
+ * @part_start: Starting block of HFS partition
+ * @root_files: Number of regular files in the root directory
+ * @root_dirs: Number of subdirectories in the root directory
+ * @fs_ablocks: Total allocation blocks in the filesystem
+ * @free_ablocks: Number of free allocation blocks available for allocation
+ * @alloc_blksz: Size in bytes of each allocation block
+ * @s_quiet: Suppress error messages for permission changes
+ * @s_type: Default file type for new files
+ * @s_creator: Default creator for new files
+ * @s_file_umask: Permission mask applied to all regular files
+ * @s_dir_umask: Permission mask applied to all directories
+ * @s_uid: Default user ID for all files
+ * @s_gid: Default group ID for all files
+ * @session: CD-ROM session info
+ * @part: CD-ROM partition info
+ * @nls_io: Character encoding table for I/O
+ * @nls_disk: Character encoding table for disk storage
+ * @bitmap_lock: Mutex protecting bitmap operations
+ * @flags: Filesystem state flags (HFS_FLG_*)
+ * @blockoffset: Block offset within device
+ * @fs_div: Filesystem block size divisor
+ * @sb: Back-pointer to VFS superblock
+ * @work_queued: Flag indicating delayed work is queued
+ * @mdb_work: Delayed work for MDB writeback
+ * @work_lock: Lock protecting work queue state
  */
 struct hfs_sb_info {
-	struct buffer_head *mdb_bh;		/* The hfs_buffer
-						   holding the real
-						   superblock (aka VIB
-						   or MDB) */
+	struct buffer_head *mdb_bh;
 	struct hfs_mdb *mdb;
-	struct buffer_head *alt_mdb_bh;		/* The hfs_buffer holding
-						   the alternate superblock */
+	struct buffer_head *alt_mdb_bh;
 	struct hfs_mdb *alt_mdb;
-	__be32 *bitmap;				/* The page holding the
-						   allocation bitmap */
-	struct hfs_btree *ext_tree;			/* Information about
-						   the extents b-tree */
-	struct hfs_btree *cat_tree;			/* Information about
-						   the catalog b-tree */
-	u32 file_count;				/* The number of
-						   regular files in
-						   the filesystem */
-	u32 folder_count;			/* The number of
-						   directories in the
-						   filesystem */
-	u32 next_id;				/* The next available
-						   file id number */
-	u32 clumpablks;				/* The number of allocation
-						   blocks to try to add when
-						   extending a file */
-	u32 fs_start;				/* The first 512-byte
-						   block represented
-						   in the bitmap */
+	__be32 *bitmap;
+	struct hfs_btree *ext_tree;
+	struct hfs_btree *cat_tree;
+	u32 file_count;
+	u32 folder_count;
+	u32 next_id;
+	u32 clumpablks;
+	u32 fs_start;
 	u32 part_start;
-	u16 root_files;				/* The number of
-						   regular
-						   (non-directory)
-						   files in the root
-						   directory */
-	u16 root_dirs;				/* The number of
-						   directories in the
-						   root directory */
-	u16 fs_ablocks;				/* The number of
-						   allocation blocks
-						   in the filesystem */
-	u16 free_ablocks;			/* the number of unused
-						   allocation blocks
-						   in the filesystem */
-	u32 alloc_blksz;			/* The size of an
-						   "allocation block" */
-	int s_quiet;				/* Silent failure when
-						   changing owner or mode? */
-	__be32 s_type;				/* Type for new files */
-	__be32 s_creator;			/* Creator for new files */
-	umode_t s_file_umask;			/* The umask applied to the
-						   permissions on all files */
-	umode_t s_dir_umask;			/* The umask applied to the
-						   permissions on all dirs */
-	kuid_t s_uid;				/* The uid of all files */
-	kgid_t s_gid;				/* The gid of all files */
+	u16 root_files;
+	u16 root_dirs;
+	u16 fs_ablocks;
+	u16 free_ablocks;
+	u32 alloc_blksz;
+	int s_quiet;
+	__be32 s_type;
+	__be32 s_creator;
+	umode_t s_file_umask;
+	umode_t s_dir_umask;
+	kuid_t s_uid;
+	kgid_t s_gid;
 
 	int session, part;
 	struct nls_table *nls_io, *nls_disk;
@@ -161,9 +191,9 @@ struct hfs_sb_info {
 	u16 blockoffset;
 	int fs_div;
 	struct super_block *sb;
-	int work_queued;		/* non-zero delayed work is queued */
-	struct delayed_work mdb_work;	/* MDB flush delayed work */
-	spinlock_t work_lock;		/* protects mdb_work and work_queued */
+	int work_queued;
+	struct delayed_work mdb_work;
+	spinlock_t work_lock;
 };
 
 #define HFS_FLG_BITMAP_DIRTY	0
-- 
2.43.0


