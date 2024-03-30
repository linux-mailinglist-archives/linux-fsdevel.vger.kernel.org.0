Return-Path: <linux-fsdevel+bounces-15707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2681C892829
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8A61F2223B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7BB15A5;
	Sat, 30 Mar 2024 00:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6QnUtyh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C707E2;
	Sat, 30 Mar 2024 00:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711758839; cv=none; b=d9jx7eYG9XTqbnW/U95lK2Fk55E2uOP/NfJ/RNgBC0NGP+VmE+yki4KvYuuSLbZvfHWhwJw2EWJiP6BMXXOj21SrzPkcCA7Gp766ICm9qkZmOg1HzKe27KAQvh161/0CPM0wxQ6fxcYX/Gk6P3mrBQ+vaF6lpydtFhKcuiqh2h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711758839; c=relaxed/simple;
	bh=uyfcszPMXi6qb94I/M4zs1L7DSTgdq1xEh54Pf2p6bE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2IsZHiz7Ph4FCfwbzFp43vTvVeM9I+1UQRnHS5uMmIh0Q6XVntkjGI8GnDm4XliRxOAWqt2IaeaNtN46FpX/aoWTzDkVjDNT/2RNdLxfTwmDUe6jYuCE/sruGIfygY5cRR86lxNqmwFkgG5EZH2Gx4bVKhnPWpAdswLr/l6uGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6QnUtyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A358C433C7;
	Sat, 30 Mar 2024 00:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711758839;
	bh=uyfcszPMXi6qb94I/M4zs1L7DSTgdq1xEh54Pf2p6bE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Y6QnUtyha8tRkR9ZoirPgoq9s3d4fxObDtcXCUkfiLR+rLZjlL/PRTVwL5j7CyNuF
	 Ui4TxBUK2pLVz0wZ7yXkLRrIrE+p8NP4C5FtfsGXGkrxt+ELnCVgcJDmcvOyqEfVY1
	 36l1XxxPlgPZKnR0/vijJW6hVRq6ujj3UYeckqsh6eWsMZBdkluF6orP2BAfWeaeMn
	 gBhZbJNA4oZL3KUh2yp/aDIs7KN+wZ4Rtxb0yFWpq8opi3xAIMhV4G5KnCWub29EDm
	 WFriax8vfYkVkoe0EFN5nHH4yey9yzaLBJ9e8JJ4aYqysOvOwdBDAyxYj9IpQq5F7P
	 lpalizAk7IXIQ==
Date: Fri, 29 Mar 2024 17:33:58 -0700
Subject: [PATCH 05/13] fsverity: add tracepoints
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175867947.1987804.12550294266527349369.stgit@frogsfrogsfrogs>
In-Reply-To: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
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
 fs/verity/enable.c              |    4 +
 fs/verity/fsverity_private.h    |    2 +
 fs/verity/init.c                |    1 
 fs/verity/verify.c              |    8 ++
 include/trace/events/fsverity.h |  142 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 158 insertions(+)
 create mode 100644 include/trace/events/fsverity.h


diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947fb0801..a301e9fe0c021 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8835,6 +8835,7 @@ T:	git https://git.kernel.org/pub/scm/fs/fsverity/linux.git
 F:	Documentation/filesystems/fsverity.rst
 F:	fs/verity/
 F:	include/linux/fsverity.h
+F:	include/trace/events/fsverity.h
 F:	include/uapi/linux/fsverity.h
 
 FT260 FTDI USB-HID TO I2C BRIDGE DRIVER
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 04e060880b792..9f743f9160100 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -227,6 +227,8 @@ static int enable_verity(struct file *filp,
 	if (err)
 		goto out;
 
+	trace_fsverity_enable(inode, &params);
+
 	/*
 	 * Start enabling verity on this file, serialized by the inode lock.
 	 * Fail if verity is already enabled or is already being enabled.
@@ -269,6 +271,8 @@ static int enable_verity(struct file *filp,
 		goto rollback;
 	}
 
+	trace_fsverity_tree_done(inode, vi, &params);
+
 	/*
 	 * Tell the filesystem to finish enabling verity on the file.
 	 * Serialized with ->begin_enable_verity() by the inode lock.
diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index c9d97c2bebd84..d4a9178f9e827 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -191,4 +191,6 @@ int fsverity_read_merkle_tree_block(struct inode *inode,
 void fsverity_drop_merkle_tree_block(struct inode *inode,
 				     struct fsverity_blockbuf *block);
 
+#include <trace/events/fsverity.h>
+
 #endif /* _FSVERITY_PRIVATE_H */
diff --git a/fs/verity/init.c b/fs/verity/init.c
index cb2c9aac61ed0..3769d2dc9e3b4 100644
--- a/fs/verity/init.c
+++ b/fs/verity/init.c
@@ -5,6 +5,7 @@
  * Copyright 2019 Google LLC
  */
 
+#define CREATE_TRACE_POINTS
 #include "fsverity_private.h"
 
 #include <linux/ratelimit.h>
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 0417862d5bd4a..85d8d2fcce9ab 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -122,6 +122,9 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		/* Byte offset of the wanted hash relative to @addr */
 		unsigned int hoffset;
 	} hblocks[FS_VERITY_MAX_LEVELS];
+
+	trace_fsverity_verify_data_block(inode, params, data_pos);
+
 	/*
 	 * The index of the previous level's block within that level; also the
 	 * index of that block's hash within the current level.
@@ -194,6 +197,9 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		if (is_hash_block_verified(inode, block, hblock_idx)) {
 			memcpy(_want_hash, block->kaddr + hoffset, hsize);
 			want_hash = _want_hash;
+			trace_fsverity_merkle_hit(inode, data_pos, hblock_pos,
+					level,
+					hoffset >> params->log_digestsize);
 			fsverity_drop_merkle_tree_block(inode, block);
 			goto descend;
 		}
@@ -228,6 +234,8 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 			SetPageChecked((struct page *)block->context);
 		memcpy(_want_hash, haddr + hoffset, hsize);
 		want_hash = _want_hash;
+		trace_fsverity_verify_merkle_block(inode, block->offset,
+				level, hoffset >> params->log_digestsize);
 		fsverity_drop_merkle_tree_block(inode, block);
 	}
 
diff --git a/include/trace/events/fsverity.h b/include/trace/events/fsverity.h
new file mode 100644
index 0000000000000..f08d3eb3368f3
--- /dev/null
+++ b/include/trace/events/fsverity.h
@@ -0,0 +1,142 @@
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
+TRACE_EVENT(fsverity_enable,
+	TP_PROTO(const struct inode *inode,
+		 const struct merkle_tree_params *params),
+	TP_ARGS(inode, params),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+		__field(u64, data_size)
+		__field(unsigned int, block_size)
+		__field(unsigned int, num_levels)
+		__field(u64, tree_size)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->data_size = i_size_read(inode);
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
+	TP_PROTO(const struct inode *inode, const struct fsverity_info *vi,
+		 const struct merkle_tree_params *params),
+	TP_ARGS(inode, vi, params),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+		__field(unsigned int, levels)
+		__field(unsigned int, block_size)
+		__field(u64, tree_size)
+		__dynamic_array(u8, root_hash, params->digest_size)
+		__dynamic_array(u8, file_digest, params->digest_size)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->levels = params->num_levels;
+		__entry->block_size = params->block_size;
+		__entry->tree_size = params->tree_size;
+		memcpy(__get_dynamic_array(root_hash), vi->root_hash, __get_dynamic_array_len(root_hash));
+		memcpy(__get_dynamic_array(file_digest), vi->file_digest, __get_dynamic_array_len(file_digest));
+	),
+	TP_printk("ino %lu levels %d block_size %d tree_size %lld root_hash %s digest %s",
+		(unsigned long) __entry->ino,
+		__entry->levels,
+		__entry->block_size,
+		__entry->tree_size,
+		__print_hex_str(__get_dynamic_array(root_hash), __get_dynamic_array_len(root_hash)),
+		__print_hex_str(__get_dynamic_array(file_digest), __get_dynamic_array_len(file_digest)))
+);
+
+TRACE_EVENT(fsverity_verify_data_block,
+	TP_PROTO(const struct inode *inode,
+		 const struct merkle_tree_params *params,
+		 u64 data_pos),
+	TP_ARGS(inode, params, data_pos),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+		__field(u64, data_pos)
+		__field(unsigned int, block_size)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->data_pos = data_pos;
+		__entry->block_size = params->block_size;
+	),
+	TP_printk("ino %lu pos %lld merkle_blocksize %u",
+		(unsigned long) __entry->ino,
+		__entry->data_pos,
+		__entry->block_size)
+);
+
+TRACE_EVENT(fsverity_merkle_hit,
+	TP_PROTO(const struct inode *inode, u64 data_pos, u64 merkle_pos,
+		 unsigned int level, unsigned int hidx),
+	TP_ARGS(inode, data_pos, merkle_pos, level, hidx),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+		__field(u64, data_pos)
+		__field(u64, merkle_pos)
+		__field(unsigned int, level)
+		__field(unsigned int, hidx)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->data_pos = data_pos;
+		__entry->merkle_pos = merkle_pos;
+		__entry->level = level;
+		__entry->hidx = hidx;
+	),
+	TP_printk("ino %lu data_pos %llu merkle_pos %llu level %u hidx %u",
+		(unsigned long) __entry->ino,
+		__entry->data_pos,
+		__entry->merkle_pos,
+		__entry->level,
+		__entry->hidx)
+);
+
+TRACE_EVENT(fsverity_verify_merkle_block,
+	TP_PROTO(const struct inode *inode, u64 merkle_pos, unsigned int level,
+		unsigned int hidx),
+	TP_ARGS(inode, merkle_pos, level, hidx),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+		__field(u64, merkle_pos)
+		__field(unsigned int, level)
+		__field(unsigned int, hidx)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->merkle_pos = merkle_pos;
+		__entry->level = level;
+		__entry->hidx = hidx;
+	),
+	TP_printk("ino %lu merkle_pos %llu level %u hidx %u",
+		(unsigned long) __entry->ino,
+		__entry->merkle_pos,
+		__entry->level,
+		__entry->hidx)
+);
+
+#endif /* _TRACE_FSVERITY_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>


