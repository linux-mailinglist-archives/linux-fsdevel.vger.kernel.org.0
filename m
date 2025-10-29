Return-Path: <linux-fsdevel+bounces-66051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8953CC17B0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7493E4F06ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696072D6E52;
	Wed, 29 Oct 2025 00:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCtfgrWF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49A7268C40;
	Wed, 29 Oct 2025 00:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699465; cv=none; b=Vq9C6yJarUz5dz2jGubYIQyeaDaji3gXm07NCuOKw7suz8esXOvnG6SZqTOiHklKsM1+IhMUJYsTKA3VAf2DgHqpHPNb0hXv7zcqW4GG+uY5RXZOZWoVkyCzfXh2RKZlv79LiBPqM/AymrrLg8F+xTaGifKZIH4NkQg5oroHs0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699465; c=relaxed/simple;
	bh=FssgNw0juTxVNia4k6jslywJKHyAoQN01yM4AuuJNa4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bs8E51jXNXfqNoh9+2LV99ib8RaAuu1ghvlJtW9t3MobMgFhdP3kH9MjA697Ri2cLm5ULT82Et6OGgb8LBFtkOEStAzPknr+OpzmcxOvSYRgtsPBebopSNVmI1XKr6H/jj4Ega3we1M8Vt7gyCw2qOPXWs3+7/KFxW2XcZyRE0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCtfgrWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447D1C4CEE7;
	Wed, 29 Oct 2025 00:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699465;
	bh=FssgNw0juTxVNia4k6jslywJKHyAoQN01yM4AuuJNa4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=oCtfgrWFjpk3S8jYLDkCo6F0+rGn3UROe+GjD3+Gm1QjRI2I+6us3ykxHFw4WZAI9
	 EbT3KJiW5GeiqydoPaz/g40+pCN6QACWEdBJX+OS6+kGLFUYR8jrf0TxIL/1euY0V8
	 z27v/bdDV3UKnuYo6cAd/0pkZLrz+fFndMWorZ7KJq0V3P16bK8lE+2tFPxbFKapKI
	 inillwOgNV3w2RUu1qzJcXbRYEqojaMuB5g7NZbXzgkxhgE0ACPxxrdT38gWiTGzBF
	 x30Dt4KqkLBHA2JP1xR+ZLaeNlLosVsNP0kQnxaoAFjywH5bC0QIYBU17mOuLrtOEV
	 Pod+/CKfYjt5g==
Date: Tue, 28 Oct 2025 17:57:44 -0700
Subject: [PATCH 06/10] fuse_trace: invalidate iomap cache after file updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169812207.1426649.9681298329609774558.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h  |   43 +++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file_iomap.c  |    6 ++++++
 fs/fuse/iomap_cache.c |    2 ++
 3 files changed, 51 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 8f06a43fd2d69a..e8bc7de25778e0 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -1076,6 +1076,7 @@ DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_truncate_down);
 DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_punch_range);
 DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_setsize);
 DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_flush_unmap_range);
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_cache_invalidate_range);
 
 TRACE_EVENT(fuse_iomap_fallocate,
 	TP_PROTO(const struct inode *inode, int mode, loff_t offset,
@@ -1213,6 +1214,48 @@ DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_inline_write);
 DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_iomap);
 DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_srcmap);
 
+DECLARE_EVENT_CLASS(fuse_iomap_inode_class,
+	TP_PROTO(const struct inode *inode),
+
+	TP_ARGS(inode),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+	),
+
+	TP_printk(FUSE_INODE_FMT,
+		  FUSE_INODE_PRINTK_ARGS)
+);
+#define DEFINE_FUSE_IOMAP_INODE_EVENT(name)	\
+DEFINE_EVENT(fuse_iomap_inode_class, name,	\
+	TP_PROTO(const struct inode *inode), \
+	TP_ARGS(inode))
+DEFINE_FUSE_IOMAP_INODE_EVENT(fuse_iomap_open_truncate);
+DEFINE_FUSE_IOMAP_INODE_EVENT(fuse_iomap_release_truncate);
+
+TRACE_EVENT(fuse_iomap_copied_file_range,
+	TP_PROTO(const struct inode *inode, loff_t offset,
+		 size_t written),
+	TP_ARGS(inode, offset, written),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	offset;
+		__entry->length		=	written;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT(),
+		  FUSE_IO_RANGE_PRINTK_ARGS())
+);
+
 DECLARE_EVENT_CLASS(fuse_iext_class,
 	TP_PROTO(const struct inode *inode, const struct fuse_iext_cursor *cur,
 		 int state, unsigned long caller_ip),
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 25a16d23dd667d..571042ab7b6bc3 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -2503,6 +2503,8 @@ void fuse_iomap_open_truncate(struct inode *inode)
 {
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_open_truncate(inode);
+
 	fuse_iomap_cache_invalidate(inode, 0);
 }
 
@@ -2510,6 +2512,8 @@ void fuse_iomap_release_truncate(struct inode *inode)
 {
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_release_truncate(inode);
+
 	fuse_iomap_cache_invalidate(inode, 0);
 }
 
@@ -2518,5 +2522,7 @@ void fuse_iomap_copied_file_range(struct inode *inode, loff_t offset,
 {
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_copied_file_range(inode, offset, written);
+
 	fuse_iomap_cache_invalidate_range(inode, offset, written);
 }
diff --git a/fs/fuse/iomap_cache.c b/fs/fuse/iomap_cache.c
index 0c8a38bd5723a2..4a751dd1651872 100644
--- a/fs/fuse/iomap_cache.c
+++ b/fs/fuse/iomap_cache.c
@@ -1422,6 +1422,8 @@ int fuse_iomap_cache_invalidate_range(struct inode *inode, loff_t offset,
 	if (!fuse_inode_caches_iomaps(inode))
 		return 0;
 
+	trace_fuse_iomap_cache_invalidate_range(inode, offset, length);
+
 	aligned_offset = round_down(offset, blocksize);
 	if (length != FUSE_IOMAP_INVAL_TO_EOF) {
 		length += offset - aligned_offset;


