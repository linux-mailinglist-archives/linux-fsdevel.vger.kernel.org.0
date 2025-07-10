Return-Path: <linux-fsdevel+bounces-54551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 501E7B00E99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 00:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4381CA409B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 22:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C37229A30F;
	Thu, 10 Jul 2025 22:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="kqRZmXpE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A2C23ED6F
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 22:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752185782; cv=none; b=cWM+k7S0Qs95HO570s44QUK6DkXopxBJCQ77xqfSjnc8+kzy5htcle/DeMYZ4tOWCbbYyinuF12grccdab5YZ+2Z3AVDoNqC6Nx35NbtTM9QgYMywZasYNcQR2MXPmv3V+ZFh1PO4IBXVITAxVV0YZ8gQ48w5sfrz5VRsbz/iK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752185782; c=relaxed/simple;
	bh=nGae19mkHeo+4sdq2PxcmSRXKan0pknJvJOA/KmcSLM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M17IWDz5SyKrTFLIC9tfFeilbNYR0wOG90Glg4jHgoDSHEl9a/XW72hN0QakLNb3aQUQwFCWA7TSEFqfxjRS6NNgXn0yHXln+yfw3NcbiDSfquunIcqpHXl4G6TZgzySU1Po6ihCD8WqgpqoWeS7v4wk9ZmoZGLZL/HrLzB70ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=kqRZmXpE; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-714067ecea3so12608607b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 15:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1752185778; x=1752790578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o4UKz+2IZXpHE9mB88B/LzZ73hphaoWSbFC9OJUN2OU=;
        b=kqRZmXpEFeEmwgV2bWf+msm/ido529DCBACpL+Ln/PO0m6lfyDfv/qxjO0BJyFIpyM
         NE0PDPd1HOKYA8LKAFwGh7Dkm68SmpSVeBj84vpWd+ftf1Mvs0E7gCWaDNH94qAMub+J
         NXbRfunuC2dpf0PxqRxwgur4OJDwuTeIv9ioZuBnssqKQf+pAkQ/vasly3efjpVqxCNV
         V1anGFaHw5KKw5Bw63OhKTRT+LQay8JsVHGQGh3zMKF8RQcMg8nuPr7T+vZBOLhZBt1y
         4h9lMb7dbC74IVDv71wBgKTzTYqym8WAYN11v+yYXpnXLKIeJIO2vl+iAb1BXkoBkJJP
         0QFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752185778; x=1752790578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4UKz+2IZXpHE9mB88B/LzZ73hphaoWSbFC9OJUN2OU=;
        b=m540LasXnLj+Jt0ToBhwOozV3W7Hu3Sh4G5YibUxfHJ7tezKjLBovUqgLXE0OBtuJm
         7CSiJn9OI+A0nm6vRm/ajsRKCvcozdflVIeQkafPYHIyddpSXXdEmsTD1G2oqLyPVoXP
         MlYuFpnCOHTi8uomswy7Qmq34W6UrOlaBpMJtwA+9dE+kglWUtj5uRscJhLJXpcpMoAk
         pytVZm16l4M4QKuGFdvoCspbp2g7/2QjSnO3TCQNxOK2ZtDiPgV7D3LAQtU5rwnRKU4W
         NDBu8QikjsJGIBrbcn7FlQuejHo5MF/KSvgtbIrVQCLOqZPUl6M4ceGjHLfEb+OdS9/U
         0WNw==
X-Forwarded-Encrypted: i=1; AJvYcCWWgBWLGh8cHtThvh9YdeVp4j6Dojg5kChdD+7ioxKWHWuIYeVunwQYdQquIoDStSKj7YSRyTSY8LQ/z00J@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj+1j1nt7iLmwiEnbOBsAt734TQIGmNanDNKwmwXdVlCJWAvWk
	ceVOIGpDoLppqpI4GL6sIC/wLppMeCEZUBvderQgwG6j6wDBbMGVbyRr6kQFdXyUges=
X-Gm-Gg: ASbGncvhIJ6rylidshkFTwS6zbgoRD7dBcyPwoQqEjVtBRfcyRCQ0aMq0Cd0zeKNP0s
	pT/qmTZiWvQRNCU3+Q/iC446FYlTeiXIeU6eKRoJQpliy3UxZFIniAxh6w2/XgvBq0yaI0+uieF
	+VIJjYwzP0D6Kd4hzXV20+LIdOXQQ8G71nYE2KypOJ575hoOdkGip1/w4+oFqir1is8GKbKehUK
	/8USrxYbRueHrzBQ4rG8GvJZamPTx9nIrfhZtDkJvJos1nGs61ujqO3ozMOIdVT4nuzZMStYSFq
	9Jd5rnTzYLAQlDAdtCvw/4mF5lTbQgyh/+IEj8djESS5LiUZpFxez1McbtA2p2s3hHyC5iQWbw=
	=
X-Google-Smtp-Source: AGHT+IEXSOTf+8LwA5fLmeRN3+t3CmkMZQhWqEGDaZaYzfwUjU7aUTKOqu+UWxXltBLVcJEqOdC3Gw==
X-Received: by 2002:a05:690c:7347:b0:70e:7882:ea97 with SMTP id 00721157ae682-717d78c4247mr15398837b3.10.1752185778146;
        Thu, 10 Jul 2025 15:16:18 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:9e89:c5b3:9b71:4f51])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c61b52f3sm4833187b3.71.2025.07.10.15.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:16:17 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com,
	Johannes.Thumshirn@wdc.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2] hfs/hfsplus: rework debug output subsystem
Date: Thu, 10 Jul 2025 15:16:00 -0700
Message-Id: <20250710221600.109153-1-slava@dubeyko.com>
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
 fs/hfs/extent.c            | 18 +++++++++---------
 fs/hfs/hfs_fs.h            | 33 +--------------------------------
 fs/hfs/inode.c             |  4 ++--
 fs/hfsplus/attributes.c    |  8 ++++----
 fs/hfsplus/bfind.c         |  4 ++--
 fs/hfsplus/bitmap.c        | 10 +++++-----
 fs/hfsplus/bnode.c         | 28 ++++++++++++++--------------
 fs/hfsplus/brec.c          | 10 +++++-----
 fs/hfsplus/btree.c         |  4 ++--
 fs/hfsplus/catalog.c       |  6 +++---
 fs/hfsplus/extents.c       | 24 ++++++++++++------------
 fs/hfsplus/hfsplus_fs.h    | 35 +----------------------------------
 fs/hfsplus/super.c         |  8 ++++----
 fs/hfsplus/xattr.c         |  4 ++--
 include/linux/hfs_common.h | 20 ++++++++++++++++++++
 21 files changed, 112 insertions(+), 156 deletions(-)
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
index 28307bc9ec1e..d946304f8ad4 100644
--- a/fs/hfs/bitmap.c
+++ b/fs/hfs/bitmap.c
@@ -158,7 +158,7 @@ u32 hfs_vbm_search_free(struct super_block *sb, u32 goal, u32 *num_bits)
 		}
 	}
 
-	hfs_dbg(BITMAP, "alloc_bits: %u,%u\n", pos, *num_bits);
+	hfs_dbg("alloc_bits: %u,%u\n", pos, *num_bits);
 	HFS_SB(sb)->free_ablocks -= *num_bits;
 	hfs_bitmap_dirty(sb);
 out:
@@ -200,7 +200,7 @@ int hfs_clear_vbm_bits(struct super_block *sb, u16 start, u16 count)
 	if (!count)
 		return 0;
 
-	hfs_dbg(BITMAP, "clear_bits: %u,%u\n", start, count);
+	hfs_dbg("clear_bits: %u,%u\n", start, count);
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
index 4a0ce131e233..69f67e5ecaa7 100644
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
@@ -411,10 +411,10 @@ int hfs_extend_file(struct inode *inode)
 		goto out;
 	}
 
-	hfs_dbg(EXTENT, "extend %lu: %u,%u\n", inode->i_ino, start, len);
+	hfs_dbg("ino %lu: start %u, len %u\n", inode->i_ino, start, len);
 	if (HFS_I(inode)->alloc_blocks == HFS_I(inode)->first_blocks) {
 		if (!HFS_I(inode)->first_blocks) {
-			hfs_dbg(EXTENT, "first extents\n");
+			hfs_dbg("first extents\n");
 			/* no extents yet */
 			HFS_I(inode)->first_extents[0].block = cpu_to_be16(start);
 			HFS_I(inode)->first_extents[0].count = cpu_to_be16(len);
@@ -456,7 +456,7 @@ int hfs_extend_file(struct inode *inode)
 	return res;
 
 insert_extent:
-	hfs_dbg(EXTENT, "insert new extent\n");
+	hfs_dbg("insert new extent\n");
 	res = hfs_ext_write_extent(inode);
 	if (res)
 		goto out;
@@ -481,7 +481,7 @@ void hfs_file_truncate(struct inode *inode)
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
index 901e83d65d20..9a8456e08ea5 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -23,7 +23,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 		return -ENOMEM;
 	fd->search_key = ptr;
 	fd->key = ptr + tree->max_key_len + 2;
-	hfs_dbg(BNODE_REFS, "find_init: %d (%p)\n",
+	hfs_dbg("find_init: %d (%p)\n",
 		tree->cnid, __builtin_return_address(0));
 	mutex_lock_nested(&tree->tree_lock,
 			hfsplus_btree_lock_class(tree));
@@ -34,7 +34,7 @@ void hfs_find_exit(struct hfs_find_data *fd)
 {
 	hfs_bnode_put(fd->bnode);
 	kfree(fd->search_key);
-	hfs_dbg(BNODE_REFS, "find_exit: %d (%p)\n",
+	hfs_dbg("find_exit: %d (%p)\n",
 		fd->tree->cnid, __builtin_return_address(0));
 	mutex_unlock(&fd->tree->tree_lock);
 	fd->tree = NULL;
diff --git a/fs/hfsplus/bitmap.c b/fs/hfsplus/bitmap.c
index bd8dcea85588..658a75669afe 100644
--- a/fs/hfsplus/bitmap.c
+++ b/fs/hfsplus/bitmap.c
@@ -31,7 +31,7 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
 	if (!len)
 		return size;
 
-	hfs_dbg(BITMAP, "block_allocate: %u,%u,%u\n", size, offset, len);
+	hfs_dbg("block_allocate: %u,%u,%u\n", size, offset, len);
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
+	hfs_dbg("-> %u,%u\n", start, *max);
 out:
 	mutex_unlock(&sbi->alloc_mutex);
 	return start;
@@ -174,7 +174,7 @@ int hfsplus_block_free(struct super_block *sb, u32 offset, u32 count)
 	if (!count)
 		return 0;
 
-	hfs_dbg(BITMAP, "block_free: %u,%u\n", offset, count);
+	hfs_dbg("block_free: %u,%u\n", offset, count);
 	/* are all of the bits in range? */
 	if ((offset + count) > sbi->total_blocks)
 		return -ENOENT;
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 079ea80534f7..ff5bbdc197b6 100644
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
+	hfs_dbg("new_node(%d:%d): 1\n",
 		node->tree->cnid, node->this);
 	init_waitqueue_head(&node->lock_wq);
 	spin_lock(&tree->hash_lock);
@@ -459,7 +459,7 @@ void hfs_bnode_unhash(struct hfs_bnode *node)
 {
 	struct hfs_bnode **p;
 
-	hfs_dbg(BNODE_REFS, "remove_node(%d:%d): %d\n",
+	hfs_dbg("remove_node(%d:%d): %d\n",
 		node->tree->cnid, node->this, atomic_read(&node->refcnt));
 	for (p = &node->tree->node_hash[hfs_bnode_hash(node->this)];
 	     *p && *p != node; p = &(*p)->next_hash)
@@ -605,7 +605,7 @@ void hfs_bnode_get(struct hfs_bnode *node)
 {
 	if (node) {
 		atomic_inc(&node->refcnt);
-		hfs_dbg(BNODE_REFS, "get_node(%d:%d): %d\n",
+		hfs_dbg("get_node(%d:%d): %d\n",
 			node->tree->cnid, node->this,
 			atomic_read(&node->refcnt));
 	}
@@ -618,7 +618,7 @@ void hfs_bnode_put(struct hfs_bnode *node)
 		struct hfs_btree *tree = node->tree;
 		int i;
 
-		hfs_dbg(BNODE_REFS, "put_node(%d:%d): %d\n",
+		hfs_dbg("put_node(%d:%d): %d\n",
 			node->tree->cnid, node->this,
 			atomic_read(&node->refcnt));
 		BUG_ON(!atomic_read(&node->refcnt));
diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
index 1918544a7871..05b385231ea2 100644
--- a/fs/hfsplus/brec.c
+++ b/fs/hfsplus/brec.c
@@ -92,7 +92,7 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, int entry_len)
 	end_rec_off = tree->node_size - (node->num_recs + 1) * 2;
 	end_off = hfs_bnode_read_u16(node, end_rec_off);
 	end_rec_off -= 2;
-	hfs_dbg(BNODE_MOD, "insert_rec: %d, %d, %d, %d\n",
+	hfs_dbg("insert_rec: %d, %d, %d, %d\n",
 		rec, size, end_off, end_rec_off);
 	if (size > end_rec_off - end_off) {
 		if (new_node)
@@ -193,7 +193,7 @@ int hfs_brec_remove(struct hfs_find_data *fd)
 		mark_inode_dirty(tree->inode);
 	}
 	hfs_bnode_dump(node);
-	hfs_dbg(BNODE_MOD, "remove_rec: %d, %d\n",
+	hfs_dbg("remove_rec: %d, %d\n",
 		fd->record, fd->keylength + fd->entrylength);
 	if (!--node->num_recs) {
 		hfs_bnode_unlink(node);
@@ -246,7 +246,7 @@ static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
 	if (IS_ERR(new_node))
 		return new_node;
 	hfs_bnode_get(node);
-	hfs_dbg(BNODE_MOD, "split_nodes: %d - %d - %d\n",
+	hfs_dbg("split_nodes: %d - %d - %d\n",
 		node->this, new_node->this, node->next);
 	new_node->next = node->next;
 	new_node->prev = node->this;
@@ -383,7 +383,7 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 		newkeylen = hfs_bnode_read_u16(node, 14) + 2;
 	else
 		fd->keylength = newkeylen = tree->max_key_len + 2;
-	hfs_dbg(BNODE_MOD, "update_rec: %d, %d, %d\n",
+	hfs_dbg("update_rec: %d, %d, %d\n",
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
index 9e1732a2b92a..87098cb599bc 100644
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
+	hfs_dbg("btree_free_node: %u\n", node->this);
 	BUG_ON(!node->this);
 	tree = node->tree;
 	nidx = node->this;
diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index 1995bafee839..1432ede1bfd5 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -259,7 +259,7 @@ int hfsplus_create_cat(u32 cnid, struct inode *dir,
 	int entry_size;
 	int err;
 
-	hfs_dbg(CAT_MOD, "create_cat: %s,%u(%d)\n",
+	hfs_dbg("create_cat: %s,%u(%d)\n",
 		str->name, cnid, inode->i_nlink);
 	err = hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &fd);
 	if (err)
@@ -336,7 +336,7 @@ int hfsplus_delete_cat(u32 cnid, struct inode *dir, const struct qstr *str)
 	int err, off;
 	u16 type;
 
-	hfs_dbg(CAT_MOD, "delete_cat: %s,%u\n", str ? str->name : NULL, cnid);
+	hfs_dbg("delete_cat: %s,%u\n", str ? str->name : NULL, cnid);
 	err = hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &fd);
 	if (err)
 		return err;
@@ -441,7 +441,7 @@ int hfsplus_rename_cat(u32 cnid,
 	int entry_size, type;
 	int err;
 
-	hfs_dbg(CAT_MOD, "rename_cat: %u - %lu,%s - %lu,%s\n",
+	hfs_dbg("rename_cat: %u - %lu,%s - %lu,%s\n",
 		cnid, src_dir->i_ino, src_name->name,
 		dst_dir->i_ino, dst_name->name);
 	err = hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &src_fd);
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index a6d61685ae79..f56985bfe1db 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -275,7 +275,7 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
 	mutex_unlock(&hip->extents_lock);
 
 done:
-	hfs_dbg(EXTENT, "get_block(%lu): %llu - %u\n",
+	hfs_dbg("get_block(%lu): %llu - %u\n",
 		inode->i_ino, (long long)iblock, dblock);
 
 	mask = (1 << sbi->fs_shift) - 1;
@@ -298,12 +298,12 @@ static void hfsplus_dump_extent(struct hfsplus_extent *extent)
 {
 	int i;
 
-	hfs_dbg(EXTENT, "   ");
+	hfs_dbg("   ");
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
+				hfs_dbg(" start: %u count: %u\n",
 					start, count);
 			}
 			extent->block_count = 0;
@@ -374,7 +374,7 @@ static int hfsplus_free_extents(struct super_block *sb,
 			err = hfsplus_block_free(sb, start + count, block_nr);
 			if (err) {
 				pr_err("can't free extent\n");
-				hfs_dbg(EXTENT, " start: %u count: %u\n",
+				hfs_dbg(" start: %u count: %u\n",
 					start, count);
 			}
 			extent->block_count = cpu_to_be32(count);
@@ -481,11 +481,11 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 			goto out;
 	}
 
-	hfs_dbg(EXTENT, "extend %lu: %u,%u\n", inode->i_ino, start, len);
+	hfs_dbg("extend %lu: %u,%u\n", inode->i_ino, start, len);
 
 	if (hip->alloc_blocks <= hip->first_blocks) {
 		if (!hip->first_blocks) {
-			hfs_dbg(EXTENT, "first extents\n");
+			hfs_dbg("first extents\n");
 			/* no extents yet */
 			hip->first_extents[0].start_block = cpu_to_be32(start);
 			hip->first_extents[0].block_count = cpu_to_be32(len);
@@ -524,7 +524,7 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 	return res;
 
 insert_extent:
-	hfs_dbg(EXTENT, "insert new extent\n");
+	hfs_dbg("insert new extent\n");
 	res = hfsplus_ext_write_extent_locked(inode);
 	if (res)
 		goto out;
@@ -549,7 +549,7 @@ void hfsplus_file_truncate(struct inode *inode)
 	u32 alloc_cnt, blk_cnt, start;
 	int res;
 
-	hfs_dbg(INODE, "truncate: %lu, %llu -> %llu\n",
+	hfs_dbg("truncate: %lu, %llu -> %llu\n",
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
index 948b8aaee33e..75ed6f1ae6b4 100644
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
+	hfs_dbg("execute sync_fs\n");
 
 	/*
 	 * Explicitly write out the special metadata inodes.
@@ -290,7 +290,7 @@ static void hfsplus_put_super(struct super_block *sb)
 {
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
 
-	hfs_dbg(SUPER, "hfsplus_put_super\n");
+	hfs_dbg("execute put super\n");
 
 	cancel_delayed_work_sync(&sbi->sync_work);
 
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


