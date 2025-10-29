Return-Path: <linux-fsdevel+bounces-66053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B623C17B1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8872E4ECE6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE89C2D7817;
	Wed, 29 Oct 2025 00:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBcAU49F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340E32D12F1;
	Wed, 29 Oct 2025 00:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699497; cv=none; b=t/OIyyJCNo6Sb2NzjMZJbBrTbEtvh4fvfm9AZ2OOXNArp1cczGbXAN0Q5t/VXVz8206Tb0PAG75aMvvWlmYWMPGmKN3Beh+mejaKCBPGNA0cGlsoRR+8aK2VszzwmHz/iwP9QgwB/8Pxkm9IOqz5tFxPrGBPUmfuBOoL3sr8AtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699497; c=relaxed/simple;
	bh=nIMA/er0JiOVf8nDRkGSrtU0kVm/dAdzBKmtJmJyjA0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tD8NYkaYY/U0Chhg+8KhcEKTciI21/XrKBc61IAgLw0jykbsDDKZCMygLtfui7MHhfzBTGEnXAyRgcw6eDxXI4dHz3vtMMRRWdxtB3hR1gZtWoykEJzhcHJuqzA2RB6MUHNqlzTojbhYbRTXM3QWup1ETgFq6W73BeaDL3lSL7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBcAU49F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BEFC4CEE7;
	Wed, 29 Oct 2025 00:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699496;
	bh=nIMA/er0JiOVf8nDRkGSrtU0kVm/dAdzBKmtJmJyjA0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=BBcAU49FCsliiakK7fvvdNBuiY7bBKoeFPSndUhcbzRMz7n7Si/CbFQbiar4vBdeg
	 JZiaFkE+OD/19T87uQfnfIrCNHtnMaV1xIxYLanBg7BtSWK+zUtkBuWxUwYzJdNaQD
	 Qby57zRaC44EhgmILe9xrMt86CDAABqHBQnRE5NhvSnQp4k5k+Ohyrh/svgu6OowdS
	 yphSgOdLMHFQ+kmEzkY1HFfy6CIQF/5nZANXfxRzSlHp8sU3kelBqYoXl1oEYiw8a7
	 kL8Fxg+kNCjLhNbwZOkhE+Vwv5RtHXdisEVBCj5Wq4FgABDizQ9hZ3yBozViHXt2ZW
	 xzhDJgyviscTg==
Date: Tue, 28 Oct 2025 17:58:16 -0700
Subject: [PATCH 08/10] fuse_trace: enable iomap cache management
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169812251.1426649.15991911169427429810.stgit@frogsfrogsfrogs>
In-Reply-To: <176169812012.1426649.16037866918992398523.stgit@frogsfrogsfrogs>
References: <176169812012.1426649.16037866918992398523.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file_iomap.c |    7 ++++-
 2 files changed, 74 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index e8bc7de25778e0..ef98f082fe1247 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -402,6 +402,7 @@ struct fuse_iomap_lookup;
 #define FUSE_IOMAP_TYPE_STRINGS \
 	{ FUSE_IOMAP_TYPE_PURE_OVERWRITE,	"overwrite" }, \
 	{ FUSE_IOMAP_TYPE_RETRY_CACHE,		"retry" }, \
+	{ FUSE_IOMAP_TYPE_NOCACHE,		"nocache" }, \
 	{ FUSE_IOMAP_TYPE_HOLE,			"hole" }, \
 	{ FUSE_IOMAP_TYPE_DELALLOC,		"delalloc" }, \
 	{ FUSE_IOMAP_TYPE_MAPPED,		"mapped" }, \
@@ -745,6 +746,7 @@ DEFINE_EVENT(fuse_inode_state_class, name,	\
 	TP_ARGS(inode))
 DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_init_inode);
 DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_evict_inode);
+DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_cache_enable);
 
 TRACE_EVENT(fuse_iomap_fiemap,
 	TP_PROTO(const struct inode *inode, u64 start, u64 count,
@@ -1551,6 +1553,72 @@ TRACE_EVENT(fuse_iomap_invalid,
 		  __entry->old_validity_cookie,
 		  __entry->validity_cookie)
 );
+
+TRACE_EVENT(fuse_iomap_upsert,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_iomap_upsert_out *outarg),
+	TP_ARGS(inode, outarg),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(uint64_t,		attr_ino)
+
+		FUSE_IOMAP_MAP_FIELDS(read)
+		FUSE_IOMAP_MAP_FIELDS(write)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->attr_ino	=	outarg->attr_ino;
+		__entry->readoffset	=	outarg->read.offset;
+		__entry->readlength	=	outarg->read.length;
+		__entry->readaddr	=	outarg->read.addr;
+		__entry->readtype	=	outarg->read.type;
+		__entry->readflags	=	outarg->read.flags;
+		__entry->readdev	=	outarg->read.dev;
+		__entry->writeoffset	=	outarg->write.offset;
+		__entry->writelength	=	outarg->write.length;
+		__entry->writeaddr	=	outarg->write.addr;
+		__entry->writetype	=	outarg->write.type;
+		__entry->writeflags	=	outarg->write.flags;
+		__entry->writedev	=	outarg->write.dev;
+	),
+
+	TP_printk(FUSE_INODE_FMT " attr_ino 0x%llx" FUSE_IOMAP_MAP_FMT("read") FUSE_IOMAP_MAP_FMT("write"),
+		  FUSE_INODE_PRINTK_ARGS,
+		  __entry->attr_ino,
+		  FUSE_IOMAP_MAP_PRINTK_ARGS(read),
+		  FUSE_IOMAP_MAP_PRINTK_ARGS(write))
+);
+
+TRACE_EVENT(fuse_iomap_inval,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_iomap_inval_out *outarg),
+	TP_ARGS(inode, outarg),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(uint64_t,		attr_ino)
+
+		FUSE_FILE_RANGE_FIELDS(read)
+		FUSE_FILE_RANGE_FIELDS(write)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->attr_ino	=	outarg->attr_ino;
+		__entry->readoffset	=	outarg->read_offset;
+		__entry->readlength	=	outarg->read_length;
+		__entry->writeoffset	=	outarg->write_offset;
+		__entry->writelength	=	outarg->write_length;
+	),
+
+	TP_printk(FUSE_INODE_FMT " attr_ino 0x%llx" FUSE_FILE_RANGE_FMT("read") FUSE_FILE_RANGE_FMT("write"),
+		  FUSE_INODE_PRINTK_ARGS,
+		  __entry->attr_ino,
+		  FUSE_FILE_RANGE_PRINTK_ARGS(read),
+		  FUSE_FILE_RANGE_PRINTK_ARGS(write))
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 37e00cf36f2705..94a9c51f3d75e5 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -2636,6 +2636,8 @@ int fuse_iomap_upsert(struct fuse_conn *fc,
 		goto out_sb;
 	}
 
+	trace_fuse_iomap_upsert(inode, outarg);
+
 	fi = get_fuse_inode(inode);
 	if (BAD_DATA(fi->orig_ino != outarg->attr_ino)) {
 		ret = -EINVAL;
@@ -2653,7 +2655,8 @@ int fuse_iomap_upsert(struct fuse_conn *fc,
 
 	fuse_iomap_cache_lock(inode);
 
-	set_bit(FUSE_I_IOMAP_CACHE, &fi->state);
+	if (!test_and_set_bit(FUSE_I_IOMAP_CACHE, &fi->state))
+		trace_fuse_iomap_cache_enable(inode);
 
 	if (outarg->read.type != FUSE_IOMAP_TYPE_NOCACHE) {
 		ret = fuse_iomap_cache_upsert(inode, READ_MAPPING,
@@ -2717,6 +2720,8 @@ int fuse_iomap_inval(struct fuse_conn *fc,
 		goto out_sb;
 	}
 
+	trace_fuse_iomap_inval(inode, outarg);
+
 	fi = get_fuse_inode(inode);
 	if (BAD_DATA(fi->orig_ino != outarg->attr_ino)) {
 		ret = -EINVAL;


