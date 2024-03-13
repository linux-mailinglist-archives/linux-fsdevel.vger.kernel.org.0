Return-Path: <linux-fsdevel+bounces-14330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC25387B090
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77AF51F26281
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7586FE1E;
	Wed, 13 Mar 2024 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjFosTPO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A5B58112;
	Wed, 13 Mar 2024 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352496; cv=none; b=QirPQg6TbOPUkkLVw2yM677+NpkEMdrWjvFfc3YVHNo0LbP8wV84O3APjie4y+jzIqp54M2QLwWtq8NTE8QMpBx/SKveXiHwR5WqjSIB2jrb8hGMxUN+BZOWmxHxMzypHT3EHcHsVbzQuuuMxZf4wZ1pNAx34gKH+mJVKmMd4jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352496; c=relaxed/simple;
	bh=Cfc8Wh5ih1PbHmvtZBPxYw2Ha/gR/b+FltBbCXvcgOg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m2W43s00basV9ZK9HD0Ua2vV9apbYIKBwI3p+wxXdIqJBC1TKto6nxncFTgMO0AbAgGToQ/FBzCr8IYXFCoib9wH7M++hc2PA1eTNRXCkBXh++WyQiT5R9WxHb9VPwlT4wl1tBdUwZfssJlZi24qRS6G2NFJznhXYiQs4KFMPPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjFosTPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1182EC433F1;
	Wed, 13 Mar 2024 17:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710352496;
	bh=Cfc8Wh5ih1PbHmvtZBPxYw2Ha/gR/b+FltBbCXvcgOg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=JjFosTPOeMaAbfWsbIbbmOWl5Nz9LjqqMMvZOfuYCz6U8uZTbldgV7YXqznCnTnwa
	 Uwisqut4UNw0tSCnIA/L4ROfyJUj1W2VMlPjZO9Vh+C6UpUFNOse1tJrk7SlqO6V8D
	 gfjYE6zAvHwHqZefb3ZLeGishNVSPchnwggqBwb63aYf9SgjqNu2UKenM68g3zLgyf
	 Vs32CkDnOxQ15IrKGvDQJf6yDDKP3MttuOr/W6ROX0kVg/WUHEe2pdjYJXz6GGe0DM
	 znOys9irvMFdkndGT5u7wdblhAYzwfOym3GVa2Evm9tWBEpn8Qrpn/QQjuDWsQ31NF
	 AycE6s+P33KXQ==
Date: Wed, 13 Mar 2024 10:54:55 -0700
Subject: [PATCH 09/29] fsverity: add tracepoints
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, aalbersh@redhat.com, ebiggers@kernel.org
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171035223503.2613863.2210260897626144087.stgit@frogsfrogsfrogs>
In-Reply-To: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
References: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Andrey Albershteyn <aalbersh@redhat.com>

fs-verity previously had debug printk but it was removed. This patch
adds trace points to the same places where printk were used (with a
few additional ones).

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: fix formatting]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 MAINTAINERS                     |    1 
 fs/verity/enable.c              |    3 +
 fs/verity/fsverity_private.h    |    2 
 fs/verity/init.c                |    1 
 fs/verity/signature.c           |    2 
 fs/verity/verify.c              |    7 ++
 include/trace/events/fsverity.h |  181 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 197 insertions(+)
 create mode 100644 include/trace/events/fsverity.h


diff --git a/MAINTAINERS b/MAINTAINERS
index 73d898383e51..f735d3e68514 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8740,6 +8740,7 @@ T:	git https://git.kernel.org/pub/scm/fs/fsverity/linux.git
 F:	Documentation/filesystems/fsverity.rst
 F:	fs/verity/
 F:	include/linux/fsverity.h
+F:	include/trace/events/fsverity.h
 F:	include/uapi/linux/fsverity.h
 
 FT260 FTDI USB-HID TO I2C BRIDGE DRIVER
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 04e060880b79..945eba0092ab 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -227,6 +227,8 @@ static int enable_verity(struct file *filp,
 	if (err)
 		goto out;
 
+	trace_fsverity_enable(inode, desc, &params);
+
 	/*
 	 * Start enabling verity on this file, serialized by the inode lock.
 	 * Fail if verity is already enabled or is already being enabled.
@@ -255,6 +257,7 @@ static int enable_verity(struct file *filp,
 		fsverity_err(inode, "Error %d building Merkle tree", err);
 		goto rollback;
 	}
+	trace_fsverity_tree_done(inode, desc, &params);
 
 	/*
 	 * Create the fsverity_info.  Don't bother trying to save work by
diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index dad33e6ff0d6..fd8f5a8d1f6a 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -162,4 +162,6 @@ void __init fsverity_init_workqueue(void);
 void fsverity_drop_block(struct inode *inode,
 			 struct fsverity_blockbuf *block);
 
+#include <trace/events/fsverity.h>
+
 #endif /* _FSVERITY_PRIVATE_H */
diff --git a/fs/verity/init.c b/fs/verity/init.c
index cb2c9aac61ed..3769d2dc9e3b 100644
--- a/fs/verity/init.c
+++ b/fs/verity/init.c
@@ -5,6 +5,7 @@
  * Copyright 2019 Google LLC
  */
 
+#define CREATE_TRACE_POINTS
 #include "fsverity_private.h"
 
 #include <linux/ratelimit.h>
diff --git a/fs/verity/signature.c b/fs/verity/signature.c
index 90c07573dd77..c1f08bb32ed1 100644
--- a/fs/verity/signature.c
+++ b/fs/verity/signature.c
@@ -53,6 +53,8 @@ int fsverity_verify_signature(const struct fsverity_info *vi,
 	struct fsverity_formatted_digest *d;
 	int err;
 
+	trace_fsverity_verify_signature(inode, signature, sig_size);
+
 	if (sig_size == 0) {
 		if (fsverity_require_signatures) {
 			fsverity_err(inode,
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 4ebdf9d2d7b6..aa1763e8b723 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -118,6 +118,7 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		/* Byte offset of the wanted hash relative to @addr */
 		unsigned int hoffset;
 	} hblocks[FS_VERITY_MAX_LEVELS];
+	trace_fsverity_verify_block(inode, data_pos);
 	/*
 	 * The index of the previous level's block within that level; also the
 	 * index of that block's hash within the current level.
@@ -215,6 +216,8 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		if (is_hash_block_verified(inode, block, hblock_idx)) {
 			memcpy(_want_hash, block->kaddr + hoffset, hsize);
 			want_hash = _want_hash;
+			trace_fsverity_merkle_tree_block_verified(inode,
+					block, FSVERITY_TRACE_DIR_ASCEND);
 			fsverity_drop_block(inode, block);
 			goto descend;
 		}
@@ -248,6 +251,8 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 			SetPageChecked(hpage);
 		memcpy(_want_hash, haddr + hoffset, hsize);
 		want_hash = _want_hash;
+		trace_fsverity_merkle_tree_block_verified(inode, block,
+				FSVERITY_TRACE_DIR_DESCEND);
 		fsverity_drop_block(inode, block);
 	}
 
@@ -405,6 +410,8 @@ void fsverity_invalidate_block(struct inode *inode,
 	struct fsverity_info *vi = inode->i_verity_info;
 	const unsigned int log_blocksize = vi->tree_params.log_blocksize;
 
+	trace_fsverity_invalidate_block(inode, block);
+
 	if (block->offset > vi->tree_params.tree_size) {
 		fsverity_err(inode,
 "Trying to invalidate beyond Merkle tree (tree %lld, offset %lld)",
diff --git a/include/trace/events/fsverity.h b/include/trace/events/fsverity.h
new file mode 100644
index 000000000000..763890e47358
--- /dev/null
+++ b/include/trace/events/fsverity.h
@@ -0,0 +1,181 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM fsverity
+
+#if !defined(_TRACE_FSVERITY_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_FSVERITY_H
+
+#include <linux/tracepoint.h>
+
+struct fsverity_descriptor;
+struct merkle_tree_params;
+struct fsverity_info;
+
+#define FSVERITY_TRACE_DIR_ASCEND	(1ul << 0)
+#define FSVERITY_TRACE_DIR_DESCEND	(1ul << 1)
+#define FSVERITY_HASH_SHOWN_LEN		20
+
+TRACE_EVENT(fsverity_enable,
+	TP_PROTO(struct inode *inode, struct fsverity_descriptor *desc,
+		struct merkle_tree_params *params),
+	TP_ARGS(inode, desc, params),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+		__field(u64, data_size)
+		__field(unsigned int, block_size)
+		__field(unsigned int, num_levels)
+		__field(u64, tree_size)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->data_size = desc->data_size;
+		__entry->block_size = params->block_size;
+		__entry->num_levels = params->num_levels;
+		__entry->tree_size = params->tree_size;
+	),
+	TP_printk("ino %lu data size %llu tree size %llu block size %u levels %u",
+		(unsigned long) __entry->ino,
+		__entry->data_size,
+		__entry->tree_size,
+		__entry->block_size,
+		__entry->num_levels)
+);
+
+TRACE_EVENT(fsverity_tree_done,
+	TP_PROTO(struct inode *inode, struct fsverity_descriptor *desc,
+		struct merkle_tree_params *params),
+	TP_ARGS(inode, desc, params),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+		__field(unsigned int, levels)
+		__field(unsigned int, tree_blocks)
+		__field(u64, tree_size)
+		__array(u8, tree_hash, 64)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->levels = params->num_levels;
+		__entry->tree_blocks =
+			params->tree_size >> params->log_blocksize;
+		__entry->tree_size = params->tree_size;
+		memcpy(__entry->tree_hash, desc->root_hash, 64);
+	),
+	TP_printk("ino %lu levels %d tree_blocks %d tree_size %lld root_hash %s",
+		(unsigned long) __entry->ino,
+		__entry->levels,
+		__entry->tree_blocks,
+		__entry->tree_size,
+		__print_hex(__entry->tree_hash, 64))
+);
+
+TRACE_EVENT(fsverity_verify_block,
+	TP_PROTO(struct inode *inode, u64 offset),
+	TP_ARGS(inode, offset),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+		__field(u64, offset)
+		__field(unsigned int, block_size)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->offset = offset;
+		__entry->block_size =
+			inode->i_verity_info->tree_params.block_size;
+	),
+	TP_printk("ino %lu data offset %lld data block size %u",
+		(unsigned long) __entry->ino,
+		__entry->offset,
+		__entry->block_size)
+);
+
+TRACE_EVENT(fsverity_merkle_tree_block_verified,
+	TP_PROTO(struct inode *inode,
+		 struct fsverity_blockbuf *block,
+		 u8 direction),
+	TP_ARGS(inode, block, direction),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+		__field(u64, offset)
+		__field(u8, direction)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->offset = block->offset;
+		__entry->direction = direction;
+	),
+	TP_printk("ino %lu block offset %llu %s",
+		(unsigned long) __entry->ino,
+		__entry->offset,
+		__entry->direction == 0 ? "ascend" : "descend")
+);
+
+TRACE_EVENT(fsverity_invalidate_block,
+	TP_PROTO(struct inode *inode, struct fsverity_blockbuf *block),
+	TP_ARGS(inode, block),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+		__field(u64, offset)
+		__field(unsigned int, block_size)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->offset = block->offset;
+		__entry->block_size = block->size;
+	),
+	TP_printk("ino %lu block position %llu block size %u",
+		(unsigned long) __entry->ino,
+		__entry->offset,
+		__entry->block_size)
+);
+
+TRACE_EVENT(fsverity_read_merkle_tree_block,
+	TP_PROTO(struct inode *inode, u64 offset, unsigned int log_blocksize),
+	TP_ARGS(inode, offset, log_blocksize),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+		__field(u64, offset)
+		__field(u64, index)
+		__field(unsigned int, block_size)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->offset = offset;
+		__entry->index = offset >> log_blocksize;
+		__entry->block_size = 1 << log_blocksize;
+	),
+	TP_printk("ino %lu tree offset %llu block index %llu block hize %u",
+		(unsigned long) __entry->ino,
+		__entry->offset,
+		__entry->index,
+		__entry->block_size)
+);
+
+TRACE_EVENT(fsverity_verify_signature,
+	TP_PROTO(const struct inode *inode, const u8 *signature, size_t sig_size),
+	TP_ARGS(inode, signature, sig_size),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+		__dynamic_array(u8, signature, sig_size)
+		__field(size_t, sig_size)
+		__field(size_t, sig_size_show)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		memcpy(__get_dynamic_array(signature), signature, sig_size);
+		__entry->sig_size = sig_size;
+		__entry->sig_size_show = (sig_size > FSVERITY_HASH_SHOWN_LEN ?
+			FSVERITY_HASH_SHOWN_LEN : sig_size);
+	),
+	TP_printk("ino %lu sig_size %zu %s%s%s",
+		(unsigned long) __entry->ino,
+		__entry->sig_size,
+		(__entry->sig_size ? "sig " : ""),
+		__print_hex(__get_dynamic_array(signature),
+			__entry->sig_size_show),
+		(__entry->sig_size ? "..." : ""))
+);
+
+#endif /* _TRACE_FSVERITY_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>


