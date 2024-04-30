Return-Path: <linux-fsdevel+bounces-18218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6AF8B685A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F763B212CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB22EFC12;
	Tue, 30 Apr 2024 03:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAlCvFG7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF131078F;
	Tue, 30 Apr 2024 03:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447275; cv=none; b=L9Sl4/x9D5ehtjeGMPAO1JYl1sfj4blr9j6otz4WVCCQhGjLX9naKja102ANT9m5oI+48lPXJ7bPHsFYYmNACOFxMW8GrA8FkxMZYChxvNR47EOrpdwDL6Giq9niQBPYhL/LAu5bk1JchObHRVNfE06YlWLcvz7w4jiSf8drLYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447275; c=relaxed/simple;
	bh=Zu/Yeg6lo878sf/tSc0gM3usiAu7t2iS3R+Yj9FDHIk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GshMXBt2w+puZvx38/FqEIVatVBq1FtCXc4YJUOUvBtKqDRxdDwrsVdZLBoiXWxYlqOuY1U+LRnlPPb03st3wN2SfpU124P7+0s5R5V35SBfO2fOtEbkoin0/z+qO3lQ4114hvzCEe2w9GKAVQ8vC7+kYtir1IZ1Amp33IPOAOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAlCvFG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB408C116B1;
	Tue, 30 Apr 2024 03:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447274;
	bh=Zu/Yeg6lo878sf/tSc0gM3usiAu7t2iS3R+Yj9FDHIk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=CAlCvFG7MZoYniWnlYQmBIBK3R2gU1JBp4Ajm84DQ8ddMqKCCVChRhQf685CnKVR4
	 wya0MalgLTrqOZHeXejL2E38XKe7F89eH0FjcmGgJGo86mdY3Fy2pC6oGW3nya6DF3
	 6QoG5qCAuLueBMvbRcn8HCa83VyBe4jatio6zPmlepRgHYxsBJb2YelAkbfA45pHoI
	 0Mt5tokVqSguB3JQXJMONVhQbXQMP3On78U/aWCZqbQtOfEizYQJQszS8qhqCnkz7C
	 6i765qbpIZ2SH8+wcwcCdx1TqBBsXbW9NqNNZv+TkmrJ7Xb6RG0ogqcPZsiNstGIyr
	 ItHCa03X4LH0A==
Date: Mon, 29 Apr 2024 20:21:14 -0700
Subject: [PATCH 07/18] fsverity: add tracepoints
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444679708.955480.2658647320516066145.stgit@frogsfrogsfrogs>
In-Reply-To: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
References: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
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
 fs/verity/verify.c              |    9 ++
 include/trace/events/fsverity.h |  143 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 160 insertions(+)
 create mode 100644 include/trace/events/fsverity.h


diff --git a/MAINTAINERS b/MAINTAINERS
index f6dc90559341f..e5be0b47b93b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8825,6 +8825,7 @@ T:	git https://git.kernel.org/pub/scm/fs/fsverity/linux.git
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
index c1f82a0ea4cfa..c1a306fd1f9b4 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -162,4 +162,6 @@ int fsverity_read_merkle_tree_block(struct inode *inode,
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
index cd0973c88cdba..c4c5e1c082de5 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -123,6 +123,9 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		/* Byte offset of the wanted hash relative to @addr */
 		unsigned int hoffset;
 	} hblocks[FS_VERITY_MAX_LEVELS];
+
+	trace_fsverity_verify_data_block(inode, params, data_pos);
+
 	/*
 	 * The index of the previous level's block within that level; also the
 	 * index of that block's hash within the current level.
@@ -191,6 +194,9 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		if (is_hash_block_verified(inode, block, hblock_idx)) {
 			memcpy(_want_hash, block->kaddr + hoffset, hsize);
 			want_hash = _want_hash;
+			trace_fsverity_merkle_hit(inode, data_pos, hblock_idx,
+					level,
+					hoffset >> params->log_digestsize);
 			fsverity_drop_merkle_tree_block(inode, block);
 			goto descend;
 		}
@@ -225,6 +231,9 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 			SetPageChecked((struct page *)block->context);
 		memcpy(_want_hash, haddr + hoffset, hsize);
 		want_hash = _want_hash;
+		trace_fsverity_verify_merkle_block(inode,
+				block->pos >> params->log_blocksize,
+				level, hoffset >> params->log_digestsize);
 		fsverity_drop_merkle_tree_block(inode, block);
 	}
 
diff --git a/include/trace/events/fsverity.h b/include/trace/events/fsverity.h
new file mode 100644
index 0000000000000..dab220884b897
--- /dev/null
+++ b/include/trace/events/fsverity.h
@@ -0,0 +1,143 @@
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
+	TP_PROTO(const struct inode *inode, u64 data_pos,
+		 unsigned long hblock_idx, unsigned int level,
+		 unsigned int hidx),
+	TP_ARGS(inode, data_pos, hblock_idx, level, hidx),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+		__field(u64, data_pos)
+		__field(unsigned long, hblock_idx)
+		__field(unsigned int, level)
+		__field(unsigned int, hidx)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->data_pos = data_pos;
+		__entry->hblock_idx = hblock_idx;
+		__entry->level = level;
+		__entry->hidx = hidx;
+	),
+	TP_printk("ino %lu data_pos %llu hblock_idx %lu level %u hidx %u",
+		(unsigned long) __entry->ino,
+		__entry->data_pos,
+		__entry->hblock_idx,
+		__entry->level,
+		__entry->hidx)
+);
+
+TRACE_EVENT(fsverity_verify_merkle_block,
+	TP_PROTO(const struct inode *inode, unsigned long index,
+		 unsigned int level, unsigned int hidx),
+	TP_ARGS(inode, index, level, hidx),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+		__field(unsigned long, index)
+		__field(unsigned int, level)
+		__field(unsigned int, hidx)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->index = index;
+		__entry->level = level;
+		__entry->hidx = hidx;
+	),
+	TP_printk("ino %lu index %lu level %u hidx %u",
+		(unsigned long) __entry->ino,
+		__entry->index,
+		__entry->level,
+		__entry->hidx)
+);
+
+#endif /* _TRACE_FSVERITY_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>


