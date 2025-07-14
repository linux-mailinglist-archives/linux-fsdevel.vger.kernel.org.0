Return-Path: <linux-fsdevel+bounces-54894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2423BB04AB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 00:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FDEC7B024F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 22:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A3322F152;
	Mon, 14 Jul 2025 22:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="Jz3qc+7T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22537126F0A
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 22:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532382; cv=none; b=Z6rhGMJUVKnqTAPvu9oDPpQNxxVbhi59h9MrEgXaUbk4Qe2wjOSpgXPZB0NSggvypxrbTI3Ktmhgu4svUldqw4SV6JSmH76C25dXx3HwTYU18vy9AQhZcgT9NzkmlQD9tWU1Qcp+nEFWIVMBIq2Xhygp8igO5flMvpojYvIkEo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532382; c=relaxed/simple;
	bh=ntq9cdxa/KFqHjKSAtgldq98ty4Kjh4DoQDv9nCL9o0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fpUY1EcTVz+MH4tO2wVGftdhxi/pkiah4bDNQIam/QRWwO/NEirGKFoDumJF0DD+hkbTd8/Eb6sWcTrgDXdFsr/DOKDAd4oIUAhFwcbso18OLIb826ZHwiDU1IdECZpDPpdHNFkHGZCaX9ixP8lNqsc8qzDQSt0BxDJWTqFwRNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=Jz3qc+7T; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70e23e9aeefso35745047b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 15:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1752532378; x=1753137178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a+LGvlJSlIE28tZiyEF0p8zzN0tWeihM8borYczQsbk=;
        b=Jz3qc+7T4XPbVLnIvM0tmtjU6udEvk5Sm0qZzEToWIZ9um3Hp35lQ0ydClnwAGF/gh
         68H/VfM/UKQW/CBYnOGzaRxPs/aJYNOFR4Up/8xeppzgYRuRMDfsMeionsF4wB2kJP2a
         uYkPzJkujpx+8UbSQv12Ol6yK7g4av/MaWr7DVdUclk2bhiFAMFn4P472mO7oksWtB7K
         0SLODpGJCo0psMhK7m712fFnUYqcOtQ4mvX1e4XFTFLs2UY9yqLqmh511bfiltJtEoKK
         oNxJyDhQhFo3RnJ/dQ6zs358iCQw1ZkbaqpfAg7cDItuuO8vyPG1xnAoeo0vkqpGgQA2
         BMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752532378; x=1753137178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+LGvlJSlIE28tZiyEF0p8zzN0tWeihM8borYczQsbk=;
        b=fVrQF8FWwHu3k021O04aDCbHA1Rr6VJdUPsSEW++/qrx6N85plC3mhMSGhrjNJE7nb
         bd9XRCY651/I1lFv9ou92ne0E7+A6FZs8MPQt8Xfl6eVTBDtwUFkLP8imDieHOAOVR3f
         mBn2cdao1fHBjaOEQzvF0XcXnxdeOZMytXfe3pkeBJo4okWYHKbozy7Y4NBm+YN9TXQ9
         5WyhYhALLZ3al+QtmLf3V4VxS9b6aWug0+9PYk8dpAs5jS4Gy8pWfS3R/qLalQBdLt9i
         Y1SXn1aCjGfzzlh/Ig61vQ+yLNltd2zAcuR2evXNsscviFc60pKLK44kHl2tFCoAI90n
         DcRw==
X-Forwarded-Encrypted: i=1; AJvYcCXrpaYWRoCndLEznqkxJJbmsID5gDLfzoRfMA4BKFo/RusbnXDpXmZtmGtXrX7uK9qnmbIij+JdHYyNxuK+@vger.kernel.org
X-Gm-Message-State: AOJu0YwjU+q19JweCl8bOKBI1x3gUdxK4ugmIrsYkiOIjmm084WfMTx4
	yI9cbaVDdHOItQByF89tyMNdXdz/sCWs2fKNd9ymiVazOh8ATOMMTe60e6yqOwFeBV4VKg7C3bT
	hjZIpJNE=
X-Gm-Gg: ASbGncvekbO2PKhvk50Kv2Av0nPYzNY2myJQGzyV+Rf6MuQqgZMm6wIyWcnB7JtX6sa
	kGa875t36f2SBAIzSkzomaRLBX22o/JVRxxyQcG5QWFOyqUMsT/N0g1LOmkY73WiHqQiAlGgyMQ
	cwpJJeAbGEpGzFVyjUhcLSaBifkdh/3XJRHRQ5H3jzBImGZuwnLqe5NgH/dmiUvTJwvLtH6LnN3
	0qAbYM+GqpLVp7SAHoxBTPaa8BF+qJiAgSAijOvHlEfKXk/z3WcH5aMogABfLZ8KrqIioSx9/7q
	Zq22WJ8M6BwZUl2c9V6yAX2n3ge+NHHw0JlZ0UVqldT29FmypBs+rgUuSiy6dmgkmpWaOEjHRew
	eyFmysAHL0g4za5O1K4Jhi1sV2usDDLtVWQ==
X-Google-Smtp-Source: AGHT+IEeqMxhFn/U364uNBELsGO/tmY1cH+NtogPv0eOhs/OnxObka17E/ImEdDevOC9Jx6jCrLE9Q==
X-Received: by 2002:a05:690c:724a:b0:712:d54e:2209 with SMTP id 00721157ae682-717d5bb212fmr219798617b3.14.1752532377846;
        Mon, 14 Jul 2025 15:32:57 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:8f44:a254:cafc:898c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c61b4d21sm21529497b3.77.2025.07.14.15.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 15:32:57 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com,
	Johannes.Thumshirn@wdc.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v3] hfs/hfsplus: rework debug output subsystem
Date: Mon, 14 Jul 2025 15:32:20 -0700
Message-Id: <20250714223220.263337-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, HFS/HFS+ has very obsolete and inconvenient
debug output subsystem. Also, the code is duplicated
in HFS and HFS+ driver. This patch introduces
linux/hfs_common.h for gathering common declarations,
inline functions, and common short methods. Currently,
this file contains only hfs_dbg() function that
employs pr_debug() with the goal to print a debug-level
messages conditionally.

So, now, it is possible to enable the debug output
by means of:

echo 'file extent.c +p' > /proc/dynamic_debug/control
echo 'func hfsplus_evict_inode +p' > /proc/dynamic_debug/control

And debug output looks like this:

hfs: pid 5831:fs/hfs/catalog.c:228 hfs_cat_delete(): delete_cat: m00,48
hfs: pid 5831:fs/hfs/extent.c:484 hfs_file_truncate(): truncate: 48, 409600 -> 0
hfs: pid 5831:fs/hfs/extent.c:212 hfs_dump_extent():
hfs: pid 5831:fs/hfs/extent.c:214 hfs_dump_extent():  78:4
hfs: pid 5831:fs/hfs/extent.c:214 hfs_dump_extent():  0:0
hfs: pid 5831:fs/hfs/extent.c:214 hfs_dump_extent():  0:0

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
---
 fs/hfs/bfind.c             |  4 ++--
 fs/hfs/bitmap.c            |  4 ++--
 fs/hfs/bnode.c             | 28 ++++++++++++++--------------
 fs/hfs/brec.c              |  8 ++++----
 fs/hfs/btree.c             |  2 +-
 fs/hfs/catalog.c           |  6 +++---
 fs/hfs/extent.c            | 19 ++++++++++---------
 fs/hfs/hfs_fs.h            | 33 +--------------------------------
 fs/hfs/inode.c             |  4 ++--
 fs/hfsplus/attributes.c    |  8 ++++----
 fs/hfsplus/bfind.c         |  4 ++--
 fs/hfsplus/bitmap.c        | 10 +++++-----
 fs/hfsplus/bnode.c         | 28 ++++++++++++++--------------
 fs/hfsplus/brec.c          | 10 +++++-----
 fs/hfsplus/btree.c         |  4 ++--
 fs/hfsplus/catalog.c       |  6 +++---
 fs/hfsplus/extents.c       | 25 +++++++++++++------------
 fs/hfsplus/hfsplus_fs.h    | 35 +----------------------------------
 fs/hfsplus/super.c         | 17 +++++++++++++----
 fs/hfsplus/xattr.c         |  4 ++--
 include/linux/hfs_common.h | 20 ++++++++++++++++++++
 21 files changed, 123 insertions(+), 156 deletions(-)
 create mode 100644 include/linux/hfs_common.h

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index ef9498a6e88a..d76fdb8d94ee 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -23,7 +23,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 		return -ENOMEM;
 	fd->search_key = ptr;
 	fd->key = ptr + tree->max_key_len + 2;
-	hfs_dbg(BNODE_REFS, "find_init: %d (%p)\n",
+	hfs_dbg("tree: %d (%p)\n",
 		tree->cnid, __builtin_return_address(0));
 	switch (tree->cnid) {
 	case HFS_CAT_CNID:
@@ -45,7 +45,7 @@ void hfs_find_exit(struct hfs_find_data *fd)
 {
 	hfs_bnode_put(fd->bnode);
 	kfree(fd->search_key);
-	hfs_dbg(BNODE_REFS, "find_exit: %d (%p)\n",
+	hfs_dbg("tree: %d (%p)\n",
 		fd->tree->cnid, __builtin_return_address(0));
 	mutex_unlock(&fd->tree->tree_lock);
 	fd->tree = NULL;
diff --git a/fs/hfs/bitmap.c b/fs/hfs/bitmap.c
index 28307bc9ec1e..59c7dd854e7b 100644
--- a/fs/hfs/bitmap.c
+++ b/fs/hfs/bitmap.c
@@ -158,7 +158,7 @@ u32 hfs_vbm_search_free(struct super_block *sb, u32 goal, u32 *num_bits)
 		}
 	}
 
-	hfs_dbg(BITMAP, "alloc_bits: %u,%u\n", pos, *num_bits);
+	hfs_dbg("RANGE: %u,%u\n", pos, *num_bits);
 	HFS_SB(sb)->free_ablocks -= *num_bits;
 	hfs_bitmap_dirty(sb);
 out:
@@ -200,7 +200,7 @@ int hfs_clear_vbm_bits(struct super_block *sb, u16 start, u16 count)
 	if (!count)
 		return 0;
 
-	hfs_dbg(BITMAP, "clear_bits: %u,%u\n", start, count);
+	hfs_dbg("RANGE: %u,%u\n", start, count);
 	/* are all of the bits in range? */
 	if ((start + count) > HFS_SB(sb)->fs_ablocks)
 		return -2;
diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index cb823a8a6ba9..26611ffd2f11 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -116,7 +116,7 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node, int dst,
 {
 	struct page *src_page, *dst_page;
 
-	hfs_dbg(BNODE_MOD, "copybytes: %u,%u,%u\n", dst, src, len);
+	hfs_dbg("copybytes: %u,%u,%u\n", dst, src, len);
 	if (!len)
 		return;
 	src += src_node->page_offset;
@@ -133,7 +133,7 @@ void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
 	struct page *page;
 	void *ptr;
 
-	hfs_dbg(BNODE_MOD, "movebytes: %u,%u,%u\n", dst, src, len);
+	hfs_dbg("movebytes: %u,%u,%u\n", dst, src, len);
 	if (!len)
 		return;
 	src += node->page_offset;
@@ -151,16 +151,16 @@ void hfs_bnode_dump(struct hfs_bnode *node)
 	__be32 cnid;
 	int i, off, key_off;
 
-	hfs_dbg(BNODE_MOD, "bnode: %d\n", node->this);
+	hfs_dbg("bnode: %d\n", node->this);
 	hfs_bnode_read(node, &desc, 0, sizeof(desc));
-	hfs_dbg(BNODE_MOD, "%d, %d, %d, %d, %d\n",
+	hfs_dbg("%d, %d, %d, %d, %d\n",
 		be32_to_cpu(desc.next), be32_to_cpu(desc.prev),
 		desc.type, desc.height, be16_to_cpu(desc.num_recs));
 
 	off = node->tree->node_size - 2;
 	for (i = be16_to_cpu(desc.num_recs); i >= 0; off -= 2, i--) {
 		key_off = hfs_bnode_read_u16(node, off);
-		hfs_dbg_cont(BNODE_MOD, " %d", key_off);
+		hfs_dbg(" %d", key_off);
 		if (i && node->type == HFS_NODE_INDEX) {
 			int tmp;
 
@@ -168,18 +168,18 @@ void hfs_bnode_dump(struct hfs_bnode *node)
 				tmp = (hfs_bnode_read_u8(node, key_off) | 1) + 1;
 			else
 				tmp = node->tree->max_key_len + 1;
-			hfs_dbg_cont(BNODE_MOD, " (%d,%d",
-				     tmp, hfs_bnode_read_u8(node, key_off));
+			hfs_dbg(" (%d,%d",
+				tmp, hfs_bnode_read_u8(node, key_off));
 			hfs_bnode_read(node, &cnid, key_off + tmp, 4);
-			hfs_dbg_cont(BNODE_MOD, ",%d)", be32_to_cpu(cnid));
+			hfs_dbg(",%d)", be32_to_cpu(cnid));
 		} else if (i && node->type == HFS_NODE_LEAF) {
 			int tmp;
 
 			tmp = hfs_bnode_read_u8(node, key_off);
-			hfs_dbg_cont(BNODE_MOD, " (%d)", tmp);
+			hfs_dbg(" (%d)", tmp);
 		}
 	}
-	hfs_dbg_cont(BNODE_MOD, "\n");
+	hfs_dbg("\n");
 }
 
 void hfs_bnode_unlink(struct hfs_bnode *node)
@@ -269,7 +269,7 @@ static struct hfs_bnode *__hfs_bnode_create(struct hfs_btree *tree, u32 cnid)
 	node->this = cnid;
 	set_bit(HFS_BNODE_NEW, &node->flags);
 	atomic_set(&node->refcnt, 1);
-	hfs_dbg(BNODE_REFS, "new_node(%d:%d): 1\n",
+	hfs_dbg("bnode(%d:%d): 1\n",
 		node->tree->cnid, node->this);
 	init_waitqueue_head(&node->lock_wq);
 	spin_lock(&tree->hash_lock);
@@ -309,7 +309,7 @@ void hfs_bnode_unhash(struct hfs_bnode *node)
 {
 	struct hfs_bnode **p;
 
-	hfs_dbg(BNODE_REFS, "remove_node(%d:%d): %d\n",
+	hfs_dbg("bnode(%d:%d): %d\n",
 		node->tree->cnid, node->this, atomic_read(&node->refcnt));
 	for (p = &node->tree->node_hash[hfs_bnode_hash(node->this)];
 	     *p && *p != node; p = &(*p)->next_hash)
@@ -454,7 +454,7 @@ void hfs_bnode_get(struct hfs_bnode *node)
 {
 	if (node) {
 		atomic_inc(&node->refcnt);
-		hfs_dbg(BNODE_REFS, "get_node(%d:%d): %d\n",
+		hfs_dbg("bnode(%d:%d): %d\n",
 			node->tree->cnid, node->this,
 			atomic_read(&node->refcnt));
 	}
@@ -467,7 +467,7 @@ void hfs_bnode_put(struct hfs_bnode *node)
 		struct hfs_btree *tree = node->tree;
 		int i;
 
-		hfs_dbg(BNODE_REFS, "put_node(%d:%d): %d\n",
+		hfs_dbg("bnode(%d:%d): %d\n",
 			node->tree->cnid, node->this,
 			atomic_read(&node->refcnt));
 		BUG_ON(!atomic_read(&node->refcnt));
diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
index 896396554bcc..5a296493f1db 100644
--- a/fs/hfs/brec.c
+++ b/fs/hfs/brec.c
@@ -94,7 +94,7 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, int entry_len)
 	end_rec_off = tree->node_size - (node->num_recs + 1) * 2;
 	end_off = hfs_bnode_read_u16(node, end_rec_off);
 	end_rec_off -= 2;
-	hfs_dbg(BNODE_MOD, "insert_rec: %d, %d, %d, %d\n",
+	hfs_dbg("RECORD: %d, %d, %d, %d\n",
 		rec, size, end_off, end_rec_off);
 	if (size > end_rec_off - end_off) {
 		if (new_node)
@@ -191,7 +191,7 @@ int hfs_brec_remove(struct hfs_find_data *fd)
 		mark_inode_dirty(tree->inode);
 	}
 	hfs_bnode_dump(node);
-	hfs_dbg(BNODE_MOD, "remove_rec: %d, %d\n",
+	hfs_dbg("RECORD: %d, %d\n",
 		fd->record, fd->keylength + fd->entrylength);
 	if (!--node->num_recs) {
 		hfs_bnode_unlink(node);
@@ -242,7 +242,7 @@ static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
 	if (IS_ERR(new_node))
 		return new_node;
 	hfs_bnode_get(node);
-	hfs_dbg(BNODE_MOD, "split_nodes: %d - %d - %d\n",
+	hfs_dbg("NODES: %d - %d - %d\n",
 		node->this, new_node->this, node->next);
 	new_node->next = node->next;
 	new_node->prev = node->this;
@@ -378,7 +378,7 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 		newkeylen = (hfs_bnode_read_u8(node, 14) | 1) + 1;
 	else
 		fd->keylength = newkeylen = tree->max_key_len + 1;
-	hfs_dbg(BNODE_MOD, "update_rec: %d, %d, %d\n",
+	hfs_dbg("RECORD: %d, %d, %d\n",
 		rec, fd->keylength, newkeylen);
 
 	rec_off = tree->node_size - (rec + 2) * 2;
diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 2fa4b1f8cc7f..a6bd76ee4d27 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -329,7 +329,7 @@ void hfs_bmap_free(struct hfs_bnode *node)
 	u32 nidx;
 	u8 *data, byte, m;
 
-	hfs_dbg(BNODE_MOD, "btree_free_node: %u\n", node->this);
+	hfs_dbg("bnode: %u\n", node->this);
 	tree = node->tree;
 	nidx = node->this;
 	node = hfs_bnode_find(tree, 0);
diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
index d63880e7d9d6..186e37bb6ea6 100644
--- a/fs/hfs/catalog.c
+++ b/fs/hfs/catalog.c
@@ -87,7 +87,7 @@ int hfs_cat_create(u32 cnid, struct inode *dir, const struct qstr *str, struct i
 	int entry_size;
 	int err;
 
-	hfs_dbg(CAT_MOD, "create_cat: %s,%u(%d)\n",
+	hfs_dbg("entry: %s,%u(%d)\n",
 		str->name, cnid, inode->i_nlink);
 	if (dir->i_size >= HFS_MAX_VALENCE)
 		return -ENOSPC;
@@ -225,7 +225,7 @@ int hfs_cat_delete(u32 cnid, struct inode *dir, const struct qstr *str)
 	struct hfs_readdir_data *rd;
 	int res, type;
 
-	hfs_dbg(CAT_MOD, "delete_cat: %s,%u\n", str ? str->name : NULL, cnid);
+	hfs_dbg("entry: %s,%u\n", str ? str->name : NULL, cnid);
 	sb = dir->i_sb;
 	res = hfs_find_init(HFS_SB(sb)->cat_tree, &fd);
 	if (res)
@@ -294,7 +294,7 @@ int hfs_cat_move(u32 cnid, struct inode *src_dir, const struct qstr *src_name,
 	int entry_size, type;
 	int err;
 
-	hfs_dbg(CAT_MOD, "rename_cat: %u - %lu,%s - %lu,%s\n",
+	hfs_dbg("CNID %u - entry1(%lu,%s) - entry2(%lu,%s)\n",
 		cnid, src_dir->i_ino, src_name->name,
 		dst_dir->i_ino, dst_name->name);
 	sb = src_dir->i_sb;
diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index 4a0ce131e233..f2111d17aa11 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -209,12 +209,12 @@ static void hfs_dump_extent(struct hfs_extent *extent)
 {
 	int i;
 
-	hfs_dbg(EXTENT, "   ");
+	hfs_dbg("EXTENT:   ");
 	for (i = 0; i < 3; i++)
-		hfs_dbg_cont(EXTENT, " %u:%u",
-			     be16_to_cpu(extent[i].block),
-			     be16_to_cpu(extent[i].count));
-	hfs_dbg_cont(EXTENT, "\n");
+		hfs_dbg(" %u:%u",
+			be16_to_cpu(extent[i].block),
+			be16_to_cpu(extent[i].count));
+	hfs_dbg("\n");
 }
 
 static int hfs_add_extent(struct hfs_extent *extent, u16 offset,
@@ -411,10 +411,11 @@ int hfs_extend_file(struct inode *inode)
 		goto out;
 	}
 
-	hfs_dbg(EXTENT, "extend %lu: %u,%u\n", inode->i_ino, start, len);
+	hfs_dbg("ino %lu: start %u, len %u\n", inode->i_ino, start, len);
 	if (HFS_I(inode)->alloc_blocks == HFS_I(inode)->first_blocks) {
 		if (!HFS_I(inode)->first_blocks) {
-			hfs_dbg(EXTENT, "first extents\n");
+			hfs_dbg("first_extents[0]: start %u, len %u\n",
+				start, len);
 			/* no extents yet */
 			HFS_I(inode)->first_extents[0].block = cpu_to_be16(start);
 			HFS_I(inode)->first_extents[0].count = cpu_to_be16(len);
@@ -456,7 +457,7 @@ int hfs_extend_file(struct inode *inode)
 	return res;
 
 insert_extent:
-	hfs_dbg(EXTENT, "insert new extent\n");
+	hfs_dbg("insert new extent\n");
 	res = hfs_ext_write_extent(inode);
 	if (res)
 		goto out;
@@ -481,7 +482,7 @@ void hfs_file_truncate(struct inode *inode)
 	u32 size;
 	int res;
 
-	hfs_dbg(INODE, "truncate: %lu, %Lu -> %Lu\n",
+	hfs_dbg("ino: %lu, phys_size %llu -> i_size %llu\n",
 		inode->i_ino, (long long)HFS_I(inode)->phys_size,
 		inode->i_size);
 	if (inode->i_size > HFS_I(inode)->phys_size) {
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index a0c7cb0f79fc..bc2d1fee4380 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -9,12 +9,6 @@
 #ifndef _LINUX_HFS_FS_H
 #define _LINUX_HFS_FS_H
 
-#ifdef pr_fmt
-#undef pr_fmt
-#endif
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/mutex.h>
@@ -24,35 +18,10 @@
 
 #include <asm/byteorder.h>
 #include <linux/uaccess.h>
+#include <linux/hfs_common.h>
 
 #include "hfs.h"
 
-#define DBG_BNODE_REFS	0x00000001
-#define DBG_BNODE_MOD	0x00000002
-#define DBG_CAT_MOD	0x00000004
-#define DBG_INODE	0x00000008
-#define DBG_SUPER	0x00000010
-#define DBG_EXTENT	0x00000020
-#define DBG_BITMAP	0x00000040
-
-//#define DBG_MASK	(DBG_EXTENT|DBG_INODE|DBG_BNODE_MOD|DBG_CAT_MOD|DBG_BITMAP)
-//#define DBG_MASK	(DBG_BNODE_MOD|DBG_CAT_MOD|DBG_INODE)
-//#define DBG_MASK	(DBG_CAT_MOD|DBG_BNODE_REFS|DBG_INODE|DBG_EXTENT)
-#define DBG_MASK	(0)
-
-#define hfs_dbg(flg, fmt, ...)					\
-do {								\
-	if (DBG_##flg & DBG_MASK)				\
-		printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
-} while (0)
-
-#define hfs_dbg_cont(flg, fmt, ...)				\
-do {								\
-	if (DBG_##flg & DBG_MASK)				\
-		pr_cont(fmt, ##__VA_ARGS__);			\
-} while (0)
-
-
 /*
  * struct hfs_inode_info
  *
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index a81ce7a740b9..e5e40d128f28 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -241,7 +241,7 @@ void hfs_delete_inode(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 
-	hfs_dbg(INODE, "delete_inode: %lu\n", inode->i_ino);
+	hfs_dbg("ino: %lu\n", inode->i_ino);
 	if (S_ISDIR(inode->i_mode)) {
 		HFS_SB(sb)->folder_count--;
 		if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID))
@@ -425,7 +425,7 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	hfs_cat_rec rec;
 	int res;
 
-	hfs_dbg(INODE, "hfs_write_inode: %lu\n", inode->i_ino);
+	hfs_dbg("ino: %lu\n", inode->i_ino);
 	res = hfs_ext_write_extent(inode);
 	if (res)
 		return res;
diff --git a/fs/hfsplus/attributes.c b/fs/hfsplus/attributes.c
index eeebe80c6be4..4682d10f51d1 100644
--- a/fs/hfsplus/attributes.c
+++ b/fs/hfsplus/attributes.c
@@ -139,7 +139,7 @@ int hfsplus_find_attr(struct super_block *sb, u32 cnid,
 {
 	int err = 0;
 
-	hfs_dbg(ATTR_MOD, "find_attr: %s,%d\n", name ? name : NULL, cnid);
+	hfs_dbg("%s,%d\n", name ? name : NULL, cnid);
 
 	if (!HFSPLUS_SB(sb)->attr_tree) {
 		pr_err("attributes file doesn't exist\n");
@@ -201,7 +201,7 @@ int hfsplus_create_attr(struct inode *inode,
 	int entry_size;
 	int err;
 
-	hfs_dbg(ATTR_MOD, "create_attr: %s,%ld\n",
+	hfs_dbg("%s,%ld\n",
 		name ? name : NULL, inode->i_ino);
 
 	if (!HFSPLUS_SB(sb)->attr_tree) {
@@ -310,7 +310,7 @@ int hfsplus_delete_attr(struct inode *inode, const char *name)
 	struct super_block *sb = inode->i_sb;
 	struct hfs_find_data fd;
 
-	hfs_dbg(ATTR_MOD, "delete_attr: %s,%ld\n",
+	hfs_dbg("%s,%ld\n",
 		name ? name : NULL, inode->i_ino);
 
 	if (!HFSPLUS_SB(sb)->attr_tree) {
@@ -356,7 +356,7 @@ int hfsplus_delete_all_attrs(struct inode *dir, u32 cnid)
 	int err = 0;
 	struct hfs_find_data fd;
 
-	hfs_dbg(ATTR_MOD, "delete_all_attrs: %d\n", cnid);
+	hfs_dbg("cnid: %d\n", cnid);
 
 	if (!HFSPLUS_SB(dir->i_sb)->attr_tree) {
 		pr_err("attributes file doesn't exist\n");
diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index 901e83d65d20..1830cec49636 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -23,7 +23,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 		return -ENOMEM;
 	fd->search_key = ptr;
 	fd->key = ptr + tree->max_key_len + 2;
-	hfs_dbg(BNODE_REFS, "find_init: %d (%p)\n",
+	hfs_dbg("CNID: %d (%p)\n",
 		tree->cnid, __builtin_return_address(0));
 	mutex_lock_nested(&tree->tree_lock,
 			hfsplus_btree_lock_class(tree));
@@ -34,7 +34,7 @@ void hfs_find_exit(struct hfs_find_data *fd)
 {
 	hfs_bnode_put(fd->bnode);
 	kfree(fd->search_key);
-	hfs_dbg(BNODE_REFS, "find_exit: %d (%p)\n",
+	hfs_dbg("CNID: %d (%p)\n",
 		fd->tree->cnid, __builtin_return_address(0));
 	mutex_unlock(&fd->tree->tree_lock);
 	fd->tree = NULL;
diff --git a/fs/hfsplus/bitmap.c b/fs/hfsplus/bitmap.c
index bd8dcea85588..91ca16df6f31 100644
--- a/fs/hfsplus/bitmap.c
+++ b/fs/hfsplus/bitmap.c
@@ -31,7 +31,7 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
 	if (!len)
 		return size;
 
-	hfs_dbg(BITMAP, "block_allocate: %u,%u,%u\n", size, offset, len);
+	hfs_dbg("RANGE: %u,%u,%u\n", size, offset, len);
 	mutex_lock(&sbi->alloc_mutex);
 	mapping = sbi->alloc_file->i_mapping;
 	page = read_mapping_page(mapping, offset / PAGE_CACHE_BITS, NULL);
@@ -90,14 +90,14 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
 		else
 			end = pptr + ((size + 31) & (PAGE_CACHE_BITS - 1)) / 32;
 	}
-	hfs_dbg(BITMAP, "bitmap full\n");
+	hfs_dbg("bitmap full\n");
 	start = size;
 	goto out;
 
 found:
 	start = offset + (curr - pptr) * 32 + i;
 	if (start >= size) {
-		hfs_dbg(BITMAP, "bitmap full\n");
+		hfs_dbg("bitmap full\n");
 		goto out;
 	}
 	/* do any partial u32 at the start */
@@ -155,7 +155,7 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
 	*max = offset + (curr - pptr) * 32 + i - start;
 	sbi->free_blocks -= *max;
 	hfsplus_mark_mdb_dirty(sb);
-	hfs_dbg(BITMAP, "-> %u,%u\n", start, *max);
+	hfs_dbg("RANGE-> %u,%u\n", start, *max);
 out:
 	mutex_unlock(&sbi->alloc_mutex);
 	return start;
@@ -174,7 +174,7 @@ int hfsplus_block_free(struct super_block *sb, u32 offset, u32 count)
 	if (!count)
 		return 0;
 
-	hfs_dbg(BITMAP, "block_free: %u,%u\n", offset, count);
+	hfs_dbg("RANGE: %u,%u\n", offset, count);
 	/* are all of the bits in range? */
 	if ((offset + count) > sbi->total_blocks)
 		return -ENOENT;
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 079ea80534f7..e1e9c98efaa6 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -130,7 +130,7 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node, int dst,
 	struct page **src_page, **dst_page;
 	int l;
 
-	hfs_dbg(BNODE_MOD, "copybytes: %u,%u,%u\n", dst, src, len);
+	hfs_dbg("copybytes: %u,%u,%u\n", dst, src, len);
 	if (!len)
 		return;
 	src += src_node->page_offset;
@@ -184,7 +184,7 @@ void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
 	void *src_ptr, *dst_ptr;
 	int l;
 
-	hfs_dbg(BNODE_MOD, "movebytes: %u,%u,%u\n", dst, src, len);
+	hfs_dbg("movebytes: %u,%u,%u\n", dst, src, len);
 	if (!len)
 		return;
 	src += node->page_offset;
@@ -300,16 +300,16 @@ void hfs_bnode_dump(struct hfs_bnode *node)
 	__be32 cnid;
 	int i, off, key_off;
 
-	hfs_dbg(BNODE_MOD, "bnode: %d\n", node->this);
+	hfs_dbg("bnode: %d\n", node->this);
 	hfs_bnode_read(node, &desc, 0, sizeof(desc));
-	hfs_dbg(BNODE_MOD, "%d, %d, %d, %d, %d\n",
+	hfs_dbg("%d, %d, %d, %d, %d\n",
 		be32_to_cpu(desc.next), be32_to_cpu(desc.prev),
 		desc.type, desc.height, be16_to_cpu(desc.num_recs));
 
 	off = node->tree->node_size - 2;
 	for (i = be16_to_cpu(desc.num_recs); i >= 0; off -= 2, i--) {
 		key_off = hfs_bnode_read_u16(node, off);
-		hfs_dbg(BNODE_MOD, " %d", key_off);
+		hfs_dbg(" %d", key_off);
 		if (i && node->type == HFS_NODE_INDEX) {
 			int tmp;
 
@@ -318,17 +318,17 @@ void hfs_bnode_dump(struct hfs_bnode *node)
 				tmp = hfs_bnode_read_u16(node, key_off) + 2;
 			else
 				tmp = node->tree->max_key_len + 2;
-			hfs_dbg_cont(BNODE_MOD, " (%d", tmp);
+			hfs_dbg(" (%d", tmp);
 			hfs_bnode_read(node, &cnid, key_off + tmp, 4);
-			hfs_dbg_cont(BNODE_MOD, ",%d)", be32_to_cpu(cnid));
+			hfs_dbg(",%d)", be32_to_cpu(cnid));
 		} else if (i && node->type == HFS_NODE_LEAF) {
 			int tmp;
 
 			tmp = hfs_bnode_read_u16(node, key_off);
-			hfs_dbg_cont(BNODE_MOD, " (%d)", tmp);
+			hfs_dbg(" (%d)", tmp);
 		}
 	}
-	hfs_dbg_cont(BNODE_MOD, "\n");
+	hfs_dbg("\n");
 }
 
 void hfs_bnode_unlink(struct hfs_bnode *node)
@@ -364,7 +364,7 @@ void hfs_bnode_unlink(struct hfs_bnode *node)
 
 	/* move down? */
 	if (!node->prev && !node->next)
-		hfs_dbg(BNODE_MOD, "hfs_btree_del_level\n");
+		hfs_dbg("btree delete level\n");
 	if (!node->parent) {
 		tree->root = 0;
 		tree->depth = 0;
@@ -419,7 +419,7 @@ static struct hfs_bnode *__hfs_bnode_create(struct hfs_btree *tree, u32 cnid)
 	node->this = cnid;
 	set_bit(HFS_BNODE_NEW, &node->flags);
 	atomic_set(&node->refcnt, 1);
-	hfs_dbg(BNODE_REFS, "new_node(%d:%d): 1\n",
+	hfs_dbg("bnode(%d:%d): 1\n",
 		node->tree->cnid, node->this);
 	init_waitqueue_head(&node->lock_wq);
 	spin_lock(&tree->hash_lock);
@@ -459,7 +459,7 @@ void hfs_bnode_unhash(struct hfs_bnode *node)
 {
 	struct hfs_bnode **p;
 
-	hfs_dbg(BNODE_REFS, "remove_node(%d:%d): %d\n",
+	hfs_dbg("bnode(%d:%d): %d\n",
 		node->tree->cnid, node->this, atomic_read(&node->refcnt));
 	for (p = &node->tree->node_hash[hfs_bnode_hash(node->this)];
 	     *p && *p != node; p = &(*p)->next_hash)
@@ -605,7 +605,7 @@ void hfs_bnode_get(struct hfs_bnode *node)
 {
 	if (node) {
 		atomic_inc(&node->refcnt);
-		hfs_dbg(BNODE_REFS, "get_node(%d:%d): %d\n",
+		hfs_dbg("bnode(%d:%d): %d\n",
 			node->tree->cnid, node->this,
 			atomic_read(&node->refcnt));
 	}
@@ -618,7 +618,7 @@ void hfs_bnode_put(struct hfs_bnode *node)
 		struct hfs_btree *tree = node->tree;
 		int i;
 
-		hfs_dbg(BNODE_REFS, "put_node(%d:%d): %d\n",
+		hfs_dbg("bnode(%d:%d): %d\n",
 			node->tree->cnid, node->this,
 			atomic_read(&node->refcnt));
 		BUG_ON(!atomic_read(&node->refcnt));
diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
index 1918544a7871..3dfff7c4c5df 100644
--- a/fs/hfsplus/brec.c
+++ b/fs/hfsplus/brec.c
@@ -92,7 +92,7 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, int entry_len)
 	end_rec_off = tree->node_size - (node->num_recs + 1) * 2;
 	end_off = hfs_bnode_read_u16(node, end_rec_off);
 	end_rec_off -= 2;
-	hfs_dbg(BNODE_MOD, "insert_rec: %d, %d, %d, %d\n",
+	hfs_dbg("RECORD: %d, %d, %d, %d\n",
 		rec, size, end_off, end_rec_off);
 	if (size > end_rec_off - end_off) {
 		if (new_node)
@@ -193,7 +193,7 @@ int hfs_brec_remove(struct hfs_find_data *fd)
 		mark_inode_dirty(tree->inode);
 	}
 	hfs_bnode_dump(node);
-	hfs_dbg(BNODE_MOD, "remove_rec: %d, %d\n",
+	hfs_dbg("RECORD: %d, %d\n",
 		fd->record, fd->keylength + fd->entrylength);
 	if (!--node->num_recs) {
 		hfs_bnode_unlink(node);
@@ -246,7 +246,7 @@ static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
 	if (IS_ERR(new_node))
 		return new_node;
 	hfs_bnode_get(node);
-	hfs_dbg(BNODE_MOD, "split_nodes: %d - %d - %d\n",
+	hfs_dbg("bnodes: %d - %d - %d\n",
 		node->this, new_node->this, node->next);
 	new_node->next = node->next;
 	new_node->prev = node->this;
@@ -383,7 +383,7 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 		newkeylen = hfs_bnode_read_u16(node, 14) + 2;
 	else
 		fd->keylength = newkeylen = tree->max_key_len + 2;
-	hfs_dbg(BNODE_MOD, "update_rec: %d, %d, %d\n",
+	hfs_dbg("RECORD: %d, %d, %d\n",
 		rec, fd->keylength, newkeylen);
 
 	rec_off = tree->node_size - (rec + 2) * 2;
@@ -395,7 +395,7 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 		end_off = hfs_bnode_read_u16(parent, end_rec_off);
 		if (end_rec_off - end_off < diff) {
 
-			hfs_dbg(BNODE_MOD, "splitting index node\n");
+			hfs_dbg("splitting index node\n");
 			fd->bnode = parent;
 			new_node = hfs_bnode_split(fd);
 			if (IS_ERR(new_node))
diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 9e1732a2b92a..b68d7dccb093 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -428,7 +428,7 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 		kunmap_local(data);
 		nidx = node->next;
 		if (!nidx) {
-			hfs_dbg(BNODE_MOD, "create new bmap node\n");
+			hfs_dbg("create new bmap node\n");
 			next_node = hfs_bmap_new_bmap(node, idx);
 		} else
 			next_node = hfs_bnode_find(tree, nidx);
@@ -454,7 +454,7 @@ void hfs_bmap_free(struct hfs_bnode *node)
 	u32 nidx;
 	u8 *data, byte, m;
 
-	hfs_dbg(BNODE_MOD, "btree_free_node: %u\n", node->this);
+	hfs_dbg("bnode: %u\n", node->this);
 	BUG_ON(!node->this);
 	tree = node->tree;
 	nidx = node->this;
diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index 1995bafee839..cd7d155ec592 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -259,7 +259,7 @@ int hfsplus_create_cat(u32 cnid, struct inode *dir,
 	int entry_size;
 	int err;
 
-	hfs_dbg(CAT_MOD, "create_cat: %s,%u(%d)\n",
+	hfs_dbg("entry: %s,%u(%d)\n",
 		str->name, cnid, inode->i_nlink);
 	err = hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &fd);
 	if (err)
@@ -336,7 +336,7 @@ int hfsplus_delete_cat(u32 cnid, struct inode *dir, const struct qstr *str)
 	int err, off;
 	u16 type;
 
-	hfs_dbg(CAT_MOD, "delete_cat: %s,%u\n", str ? str->name : NULL, cnid);
+	hfs_dbg("entry: %s,%u\n", str ? str->name : NULL, cnid);
 	err = hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &fd);
 	if (err)
 		return err;
@@ -441,7 +441,7 @@ int hfsplus_rename_cat(u32 cnid,
 	int entry_size, type;
 	int err;
 
-	hfs_dbg(CAT_MOD, "rename_cat: %u - %lu,%s - %lu,%s\n",
+	hfs_dbg("entry: %u - %lu,%s - %lu,%s\n",
 		cnid, src_dir->i_ino, src_name->name,
 		dst_dir->i_ino, dst_name->name);
 	err = hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &src_fd);
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index a6d61685ae79..946554ebc923 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -275,7 +275,7 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
 	mutex_unlock(&hip->extents_lock);
 
 done:
-	hfs_dbg(EXTENT, "get_block(%lu): %llu - %u\n",
+	hfs_dbg("ino(%lu): %llu - %u\n",
 		inode->i_ino, (long long)iblock, dblock);
 
 	mask = (1 << sbi->fs_shift) - 1;
@@ -298,12 +298,12 @@ static void hfsplus_dump_extent(struct hfsplus_extent *extent)
 {
 	int i;
 
-	hfs_dbg(EXTENT, "   ");
+	hfs_dbg("EXTENT   ");
 	for (i = 0; i < 8; i++)
-		hfs_dbg_cont(EXTENT, " %u:%u",
-			     be32_to_cpu(extent[i].start_block),
-			     be32_to_cpu(extent[i].block_count));
-	hfs_dbg_cont(EXTENT, "\n");
+		hfs_dbg(" %u:%u",
+			be32_to_cpu(extent[i].start_block),
+			be32_to_cpu(extent[i].block_count));
+	hfs_dbg("\n");
 }
 
 static int hfsplus_add_extent(struct hfsplus_extent *extent, u32 offset,
@@ -363,7 +363,7 @@ static int hfsplus_free_extents(struct super_block *sb,
 			err = hfsplus_block_free(sb, start, count);
 			if (err) {
 				pr_err("can't free extent\n");
-				hfs_dbg(EXTENT, " start: %u count: %u\n",
+				hfs_dbg("EXTENT: start: %u count: %u\n",
 					start, count);
 			}
 			extent->block_count = 0;
@@ -374,7 +374,7 @@ static int hfsplus_free_extents(struct super_block *sb,
 			err = hfsplus_block_free(sb, start + count, block_nr);
 			if (err) {
 				pr_err("can't free extent\n");
-				hfs_dbg(EXTENT, " start: %u count: %u\n",
+				hfs_dbg("EXTENT: start: %u count: %u\n",
 					start, count);
 			}
 			extent->block_count = cpu_to_be32(count);
@@ -481,11 +481,12 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 			goto out;
 	}
 
-	hfs_dbg(EXTENT, "extend %lu: %u,%u\n", inode->i_ino, start, len);
+	hfs_dbg("ino %lu: %u,%u\n", inode->i_ino, start, len);
 
 	if (hip->alloc_blocks <= hip->first_blocks) {
 		if (!hip->first_blocks) {
-			hfs_dbg(EXTENT, "first extents\n");
+			hfs_dbg("first_extents[0]: start %u, len %u\n",
+				start, len);
 			/* no extents yet */
 			hip->first_extents[0].start_block = cpu_to_be32(start);
 			hip->first_extents[0].block_count = cpu_to_be32(len);
@@ -524,7 +525,7 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 	return res;
 
 insert_extent:
-	hfs_dbg(EXTENT, "insert new extent\n");
+	hfs_dbg("insert new extent\n");
 	res = hfsplus_ext_write_extent_locked(inode);
 	if (res)
 		goto out;
@@ -549,7 +550,7 @@ void hfsplus_file_truncate(struct inode *inode)
 	u32 alloc_cnt, blk_cnt, start;
 	int res;
 
-	hfs_dbg(INODE, "truncate: %lu, %llu -> %llu\n",
+	hfs_dbg("ino: %lu, %llu -> %llu\n",
 		inode->i_ino, (long long)hip->phys_size, inode->i_size);
 
 	if (inode->i_size > hip->phys_size) {
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 2f089bff0095..de8c4f0bc808 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -11,47 +11,14 @@
 #ifndef _LINUX_HFSPLUS_FS_H
 #define _LINUX_HFSPLUS_FS_H
 
-#ifdef pr_fmt
-#undef pr_fmt
-#endif
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/fs.h>
 #include <linux/mutex.h>
 #include <linux/buffer_head.h>
 #include <linux/blkdev.h>
 #include <linux/fs_context.h>
+#include <linux/hfs_common.h>
 #include "hfsplus_raw.h"
 
-#define DBG_BNODE_REFS	0x00000001
-#define DBG_BNODE_MOD	0x00000002
-#define DBG_CAT_MOD	0x00000004
-#define DBG_INODE	0x00000008
-#define DBG_SUPER	0x00000010
-#define DBG_EXTENT	0x00000020
-#define DBG_BITMAP	0x00000040
-#define DBG_ATTR_MOD	0x00000080
-
-#if 0
-#define DBG_MASK	(DBG_EXTENT|DBG_INODE|DBG_BNODE_MOD)
-#define DBG_MASK	(DBG_BNODE_MOD|DBG_CAT_MOD|DBG_INODE)
-#define DBG_MASK	(DBG_CAT_MOD|DBG_BNODE_REFS|DBG_INODE|DBG_EXTENT)
-#endif
-#define DBG_MASK	(0)
-
-#define hfs_dbg(flg, fmt, ...)					\
-do {								\
-	if (DBG_##flg & DBG_MASK)				\
-		printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
-} while (0)
-
-#define hfs_dbg_cont(flg, fmt, ...)				\
-do {								\
-	if (DBG_##flg & DBG_MASK)				\
-		pr_cont(fmt, ##__VA_ARGS__);			\
-} while (0)
-
 /* Runtime config options */
 #define HFSPLUS_DEF_CR_TYPE    0x3F3F3F3F  /* '????' */
 
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 948b8aaee33e..6150998b5910 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -150,7 +150,7 @@ static int hfsplus_write_inode(struct inode *inode,
 {
 	int err;
 
-	hfs_dbg(INODE, "hfsplus_write_inode: %lu\n", inode->i_ino);
+	hfs_dbg("ino: %lu\n", inode->i_ino);
 
 	err = hfsplus_ext_write_extent(inode);
 	if (err)
@@ -165,7 +165,7 @@ static int hfsplus_write_inode(struct inode *inode,
 
 static void hfsplus_evict_inode(struct inode *inode)
 {
-	hfs_dbg(INODE, "hfsplus_evict_inode: %lu\n", inode->i_ino);
+	hfs_dbg("ino: %lu\n", inode->i_ino);
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
 	if (HFSPLUS_IS_RSRC(inode)) {
@@ -184,7 +184,7 @@ static int hfsplus_sync_fs(struct super_block *sb, int wait)
 	if (!wait)
 		return 0;
 
-	hfs_dbg(SUPER, "hfsplus_sync_fs\n");
+	hfs_dbg("starting...\n");
 
 	/*
 	 * Explicitly write out the special metadata inodes.
@@ -215,6 +215,11 @@ static int hfsplus_sync_fs(struct super_block *sb, int wait)
 	vhdr->folder_count = cpu_to_be32(sbi->folder_count);
 	vhdr->file_count = cpu_to_be32(sbi->file_count);
 
+	hfs_dbg("free_blocks %u, next_cnid %u, "
+		"folder_count %u, file_count %u\n",
+		sbi->free_blocks, sbi->next_cnid,
+		sbi->folder_count, sbi->file_count);
+
 	if (test_and_clear_bit(HFSPLUS_SB_WRITEBACKUP, &sbi->flags)) {
 		memcpy(sbi->s_backup_vhdr, sbi->s_vhdr, sizeof(*sbi->s_vhdr));
 		write_backup = 1;
@@ -242,6 +247,8 @@ static int hfsplus_sync_fs(struct super_block *sb, int wait)
 	if (!test_bit(HFSPLUS_SB_NOBARRIER, &sbi->flags))
 		blkdev_issue_flush(sb->s_bdev);
 
+	hfs_dbg("finished: err %d\n", error);
+
 	return error;
 }
 
@@ -290,7 +297,7 @@ static void hfsplus_put_super(struct super_block *sb)
 {
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
 
-	hfs_dbg(SUPER, "hfsplus_put_super\n");
+	hfs_dbg("starting...\n");
 
 	cancel_delayed_work_sync(&sbi->sync_work);
 
@@ -312,6 +319,8 @@ static void hfsplus_put_super(struct super_block *sb)
 	kfree(sbi->s_vhdr_buf);
 	kfree(sbi->s_backup_vhdr_buf);
 	call_rcu(&sbi->rcu, delayed_free);
+
+	hfs_dbg("finished\n");
 }
 
 static int hfsplus_statfs(struct dentry *dentry, struct kstatfs *buf)
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 9a1a93e3888b..ae58cc4309eb 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -64,7 +64,7 @@ static void hfsplus_init_header_node(struct inode *attr_file,
 	u32 used_bmp_bytes;
 	u64 tmp;
 
-	hfs_dbg(ATTR_MOD, "init_hdr_attr_file: clump %u, node_size %u\n",
+	hfs_dbg("clump %u, node_size %u\n",
 		clump_size, node_size);
 
 	/* The end of the node contains list of record offsets */
@@ -132,7 +132,7 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 	struct page *page;
 	int old_state = HFSPLUS_EMPTY_ATTR_TREE;
 
-	hfs_dbg(ATTR_MOD, "create_attr_file: ino %d\n", HFSPLUS_ATTR_CNID);
+	hfs_dbg("ino %d\n", HFSPLUS_ATTR_CNID);
 
 check_attr_tree_state_again:
 	switch (atomic_read(&sbi->attr_tree_state)) {
diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
new file mode 100644
index 000000000000..8838ca2f3d08
--- /dev/null
+++ b/include/linux/hfs_common.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * HFS/HFS+ common definitions, inline functions,
+ * and shared functionality.
+ */
+
+#ifndef _HFS_COMMON_H_
+#define _HFS_COMMON_H_
+
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#define hfs_dbg(fmt, ...)							\
+	pr_debug("pid %d:%s:%d %s(): " fmt,					\
+		 current->pid, __FILE__, __LINE__, __func__, ##__VA_ARGS__)	\
+
+#endif /* _HFS_COMMON_H_ */
-- 
2.43.0


