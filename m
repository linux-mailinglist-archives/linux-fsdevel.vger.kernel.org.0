Return-Path: <linux-fsdevel+bounces-78452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM2CCKMOoGnbfQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 10:13:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A65541A334C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 10:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF0813026519
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 09:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442F639A7E1;
	Thu, 26 Feb 2026 09:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+9noE2q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8818F39A7ED
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 09:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772097174; cv=none; b=SkinaBf2kD5bOYZ4N2P6HdT6/Ig22nKIopKRzNGQiOJiLIzlOZvTkkBZdfsYJKtStpVcn86PmAzTHUnXIOyjpfDI+6obukD5E5uyG5zB42GyQbz2zRv5h9VkkYGSJ0ipwC0wf06LorPTAQgsjBL7SYRqTL7i18aElbY1KDeFWR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772097174; c=relaxed/simple;
	bh=o5IFg1Vyd66vcwz3s0bwn9rLJf9YTJGFLGnQA6pztpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=obifAFHrFE4nJvM+SVOlD4FC8zV9jpbgahyGae2Uo5mgNZJFjySBznAx1c4WhjRR9Sl1k0EeL5V4vyxIvLlHlMgNDmHzKVUiEoShCLiobLLn1T7ONGcMbtXXun+xtftGBE0NhZu9NJ9yIUr8ZPVZlvT9Hc/BMUdv+MND1EqW5sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+9noE2q; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-823c56765fdso368722b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 01:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772097172; x=1772701972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGiXuIQEbuf9BXwhueXtToZeIPVu9UDxY4vWexcOij4=;
        b=J+9noE2qxshpd0mzA8OozGNx1iF4Tn0Sht+0XbRHisp8QqJRpFf5aHRu6RQziqqHfo
         Te5lA7xeyPMaDww1dZa8/rLX5zx9XMSfERwxNMMS+PicHq09UygrUy8fVAtyJN6iKLkb
         qBxZis7CVBULdp1N44vsMhpjru+GALjSe/6wt9kefBPgkQLugYE4PZ/c6qq0fcU0jiIv
         QzKjxxsusv9uqNWpN9YJM1qIPVyM267KexU8NW+rCce2vtYBrqJCQH9f1Owa/1XuxW9H
         nSr4mBG+V5Ai7NzfxaLKFAUxOOguaxoC+EiHkp5L839k9RVyvyjd+dRXDmy3pqK8Kna3
         jNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772097172; x=1772701972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PGiXuIQEbuf9BXwhueXtToZeIPVu9UDxY4vWexcOij4=;
        b=FmxGy7fgr4bFqtsUnKddBR1wr+3jorckXx0xlhhNMHlk7ksh/d0QtuW+zQbyJcfWpo
         hMdO2UWjsEDzPVY+L4fV1qHYcsY6lS2UXELo0yA5u1uWb6kq/o7Q/lBqAVs61MNdmTLB
         JL1BOlnTaJLlrhjs6emAsMvR5dj1yYZwsMxzfgX1yduKUxgvwnOpM9grWE6+PJZIDntF
         36SSTGLeori9Der0X4c2Z5XG2dU4stW+tDRMtdWtEhe4ixRjYTrwnLq+VNvNqwhOWPKO
         OLw3MXOqgcsKj6PtLsuQlzZ1EreJkX9L+a8INzzlxqmaPsFocOsZCticBEa/C70wP/0n
         A84Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYffYqtuu6ZXcNoAIpGlZRRTDKrmtiPPzDYljx+/6aG5dYv/W6sef6GoPRjMzd2O3QXbSmDe2bvS2yCmOZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwBZvMB+L1BQ+w7hkDVP+kmOag/z50EoVbN94vx4gpqBd8GQ1YO
	AFrc76AoYdyMGkp1oAOVZgtethjt+gMoH7rYtyQSbEr5eQTMmAW9W0C6hl4bI9Jv
X-Gm-Gg: ATEYQzyj+ixz+D3A9dHjpZXkMVUU14gcNWv17o+s3p+IAvJbL23xbKRKcI5NwbxyBsN
	4Ucaz/EtqQyUzLRv8nkLnOzIxw8MlfXxI8DXb2HfPT7J0+AmA4W4RZcoP+r+NiZ2Q6uWoPZj7Wt
	HOaVGxvbLsLZQG3XlPKzbn5WygJmbszcjyUhn3dqgUEk9DSD+Rjve+MaHKpagf+ILXEkHStWtFf
	C5ZksXNKSI/JQQIErYyddnz6bFwzbSi3LsLDDMFY1cGcNpJWwbjM4XHOjNAMnJOjOC6Fbp/K3rE
	fDpZ/GNPJqIRYskwagOekbrCl3eyzOUt/0sB9902z2Y/SyYgPuf8JQWaLjW+td2lxqUZs1nHSIQ
	8H9pltC2tecW12G72ZNrDfW8B68LWtrbqwrfzyjyFIHVEkdbX06k7MO1gm86vENv/ubwjMMiTky
	HxFDHVzAfKeHTVZn5Q/lajNd/+gIhGYiy2sh2YbcYvzh0Zbg8=
X-Received: by 2002:a05:6a21:6e8a:b0:38d:f745:4d5f with SMTP id adf61e73a8af0-395b47b4e73mr1905944637.24.1772097171578;
        Thu, 26 Feb 2026 01:12:51 -0800 (PST)
Received: from localhost.localdomain ([223.185.37.137])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa5e4aafsm1457484a12.4.2026.02.26.01.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 01:12:51 -0800 (PST)
From: Shardul Bankar <shardulsb08@gmail.com>
X-Google-Original-From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: janak@mpiricsoftware.com,
	janak@mpiric.us,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH v4 1/2] hfsplus: refactor b-tree map page access and add node-type validation
Date: Thu, 26 Feb 2026 14:42:34 +0530
Message-Id: <20260226091235.927749-2-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226091235.927749-1-shardul.b@mpiricsoftware.com>
References: <20260226091235.927749-1-shardul.b@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78452-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[mpiricsoftware.com,mpiric.us,gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[shardulsb08@gmail.com,linux-fsdevel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A65541A334C
X-Rspamd-Action: no action

In HFS+ b-trees, the node allocation bitmap is stored across multiple
records. The first chunk resides in the b-tree Header Node at record
index 2, while all subsequent chunks are stored in dedicated Map Nodes
at record index 0.

This structural quirk forces callers like hfs_bmap_alloc() to duplicate
boilerplate code to validate offsets, correct lengths, and map the
underlying pages via kmap_local_page() for both the initial header node
and the subsequent map nodes in the chain.

Introduce a generic helper, hfs_bmap_get_map_page(), to encapsulate
the map record access. This helper:
1. Automatically validates the node->type against HFS_NODE_HEADER and
   HFS_NODE_MAP to prevent misinterpreting corrupted nodes.
2. Infers the correct record index (2 or 0) based on the node type.
3. Handles the offset calculation, length validation, and page mapping.

Refactor hfs_bmap_alloc() to utilize this helper, stripping out the
redundant setup blocks. As part of this cleanup, the double pointer
iterator (struct page **pagep) is replaced with a simpler unsigned int
index (page_idx) for cleaner page boundary crossing.

This deduplicates the allocator logic, hardens the map traversal against
fuzzed/corrupted images, and provides a generic map-access abstraction
that will be utilized by upcoming mount-time validation checks.

Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 fs/hfsplus/btree.c         | 78 +++++++++++++++++++++++++++-----------
 include/linux/hfs_common.h |  3 ++
 2 files changed, 59 insertions(+), 22 deletions(-)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 1220a2f22737..22efd6517ef4 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -129,6 +129,47 @@ u32 hfsplus_calc_btree_clump_size(u32 block_size, u32 node_size,
 	return clump_size;
 }
 
+/*
+ * Maps the page containing the b-tree map record and calculates offsets.
+ * Automatically handles the difference between header and map nodes.
+ * Returns the mapped data pointer, or an ERR_PTR on failure.
+ * Note: The caller is responsible for calling kunmap_local(data).
+ */
+static u8 *hfs_bmap_get_map_page(struct hfs_bnode *node, u16 *off, u16 *len,
+				unsigned int *page_idx)
+{
+	u16 rec_idx, off16;
+
+	if (node->this == HFSPLUS_TREE_HEAD) {
+		if (node->type != HFS_NODE_HEADER) {
+			pr_err("hfsplus: invalid btree header node\n");
+			return ERR_PTR(-EIO);
+		}
+		rec_idx = HFSPLUS_BTREE_HDR_MAP_REC_INDEX;
+	} else {
+		if (node->type != HFS_NODE_MAP) {
+			pr_err("hfsplus: invalid btree map node\n");
+			return ERR_PTR(-EIO);
+		}
+		rec_idx = HFSPLUS_BTREE_MAP_NODE_REC_INDEX;
+	}
+
+	*len = hfs_brec_lenoff(node, rec_idx, &off16);
+	if (!*len)
+		return ERR_PTR(-ENOENT);
+
+	if (!is_bnode_offset_valid(node, off16))
+		return ERR_PTR(-EIO);
+
+	*len = check_and_correct_requested_length(node, off16, *len);
+
+	off16 += node->page_offset;
+	*page_idx = off16 >> PAGE_SHIFT;
+	*off = off16 & ~PAGE_MASK;
+
+	return kmap_local_page(node->page[*page_idx]);
+}
+
 /* Get a reference to a B*Tree and do some initial checks */
 struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 {
@@ -374,10 +415,9 @@ int hfs_bmap_reserve(struct hfs_btree *tree, u32 rsvd_nodes)
 struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 {
 	struct hfs_bnode *node, *next_node;
-	struct page **pagep;
+	unsigned int page_idx;
 	u32 nidx, idx;
-	unsigned off;
-	u16 off16;
+	u16 off;
 	u16 len;
 	u8 *data, byte, m;
 	int i, res;
@@ -390,30 +430,24 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 	node = hfs_bnode_find(tree, nidx);
 	if (IS_ERR(node))
 		return node;
-	len = hfs_brec_lenoff(node, 2, &off16);
-	off = off16;
-
-	if (!is_bnode_offset_valid(node, off)) {
+	data = hfs_bmap_get_map_page(node, &off, &len, &page_idx);
+	if (IS_ERR(data)) {
+		res = PTR_ERR(data);
 		hfs_bnode_put(node);
-		return ERR_PTR(-EIO);
+		return ERR_PTR(res);
 	}
-	len = check_and_correct_requested_length(node, off, len);
 
-	off += node->page_offset;
-	pagep = node->page + (off >> PAGE_SHIFT);
-	data = kmap_local_page(*pagep);
-	off &= ~PAGE_MASK;
 	idx = 0;
 
 	for (;;) {
 		while (len) {
 			byte = data[off];
 			if (byte != 0xff) {
-				for (m = 0x80, i = 0; i < 8; m >>= 1, i++) {
+				for (m = HFSPLUS_BTREE_NODE0_BIT, i = 0; i < 8; m >>= 1, i++) {
 					if (!(byte & m)) {
 						idx += i;
 						data[off] |= m;
-						set_page_dirty(*pagep);
+						set_page_dirty(node->page[page_idx]);
 						kunmap_local(data);
 						tree->free_nodes--;
 						mark_inode_dirty(tree->inode);
@@ -425,7 +459,7 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 			}
 			if (++off >= PAGE_SIZE) {
 				kunmap_local(data);
-				data = kmap_local_page(*++pagep);
+				data = kmap_local_page(node->page[++page_idx]);
 				off = 0;
 			}
 			idx += 8;
@@ -443,12 +477,12 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 			return next_node;
 		node = next_node;
 
-		len = hfs_brec_lenoff(node, 0, &off16);
-		off = off16;
-		off += node->page_offset;
-		pagep = node->page + (off >> PAGE_SHIFT);
-		data = kmap_local_page(*pagep);
-		off &= ~PAGE_MASK;
+		data = hfs_bmap_get_map_page(node, &off, &len, &page_idx);
+		if (IS_ERR(data)) {
+			res = PTR_ERR(data);
+			hfs_bnode_put(node);
+			return ERR_PTR(res);
+		}
 	}
 }
 
diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
index dadb5e0aa8a3..8238f55dd1d3 100644
--- a/include/linux/hfs_common.h
+++ b/include/linux/hfs_common.h
@@ -510,7 +510,10 @@ struct hfs_btree_header_rec {
 #define HFSPLUS_NODE_MXSZ			32768
 #define HFSPLUS_ATTR_TREE_NODE_SIZE		8192
 #define HFSPLUS_BTREE_HDR_NODE_RECS_COUNT	3
+#define HFSPLUS_BTREE_HDR_MAP_REC_INDEX		2	/* Map (bitmap) record in Header node */
+#define HFSPLUS_BTREE_MAP_NODE_REC_INDEX	0	/* Map record in Map Node */
 #define HFSPLUS_BTREE_HDR_USER_BYTES		128
+#define HFSPLUS_BTREE_NODE0_BIT			(1 << 7)
 
 /* btree key type */
 #define HFSPLUS_KEY_CASEFOLDING		0xCF	/* case-insensitive */
-- 
2.34.1


