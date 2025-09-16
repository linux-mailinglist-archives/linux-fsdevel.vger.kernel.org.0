Return-Path: <linux-fsdevel+bounces-61518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 453B6B5897E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 166494E2710
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A981F95C;
	Tue, 16 Sep 2025 00:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZySWXz4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A56714F125;
	Tue, 16 Sep 2025 00:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982651; cv=none; b=nb5KxyVr5A+e4nWxxLTKJjKt46wOXap28RFsglf3ZJkvw8nlUZjyYqR0iYu+CYs6FmZWqkLWT+M6ncGY4mQpX3y9Zo6gj5BPSmwDGLV3TFj/NG5nQ7CZ9gCbg+xJP6htHti9MGv4sKhPPU3j/Tfgvqzi59qYuiAd1NHTvxJCQRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982651; c=relaxed/simple;
	bh=+IcWCBPtk6fRBOKW56aDmCCP7PLaWqZwsOs9cdHxF4Q=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDulowwQ/JhX97+ezOvx32Q3eTcQBPIJe4sp8EOQxV0V7CaypTGzdusa3wdImsKCCSXrmyFFx8magpfvrQUW2C23WT1XUIcBqaohWohbbX936W66kLU1v89+LbzCUHRZ1BQhSWEka2GCn9I6+KsaP6/M6l58UtQimHAvMNkJuFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZySWXz4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21296C4CEF1;
	Tue, 16 Sep 2025 00:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982651;
	bh=+IcWCBPtk6fRBOKW56aDmCCP7PLaWqZwsOs9cdHxF4Q=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=AZySWXz4wAutpiHcZf3gRnbQvXFzefqVoFGuFUFum4bqDG4s6dBRDrH2WKFSIik3K
	 8BUA+NMSbNsmt2Gw3brmkLYx+kYTm6ALR2s+x7qF5cPE/jfJ/+Ki869/pI0df4kdtt
	 TpgLxOVEQvKSf+GCoPuQHHUDi45ytUViV4HsldL+oeV03S4lJZjWwfZ2ZPa42xumnV
	 1P93klwaOp4VKaz0lJQBi2tVl/U+M6jC9BwnUL+Rdq6EvC93UWVCeOspbdd/9de4rO
	 frC3yCW7N4sSFiXdNJUKf4KWRQnWd6LpXyWk92KUE626rp+V+P46++ksm5qcROzIzt
	 i9hRcT3C6uFPQ==
Date: Mon, 15 Sep 2025 17:30:50 -0700
Subject: [PATCH 11/28] fuse_trace: implement basic iomap reporting such as
 FIEMAP and SEEK_{DATA,HOLE}
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798151502.382724.2944299500596432772.stgit@frogsfrogsfrogs>
In-Reply-To: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file_iomap.c |    4 ++++
 2 files changed, 50 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index cdedaf2b2a0ad5..4fe51be0e65bdc 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -530,6 +530,52 @@ DEFINE_EVENT(fuse_inode_state_class, name,	\
 	TP_ARGS(inode))
 DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_init_inode);
 DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_evict_inode);
+
+TRACE_EVENT(fuse_iomap_fiemap,
+	TP_PROTO(const struct inode *inode, u64 start, u64 count,
+		unsigned int flags),
+
+	TP_ARGS(inode, start, count, flags),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(unsigned int,		flags)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	start;
+		__entry->length		=	count;
+		__entry->flags		=	flags;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT("fiemap") " flags 0x%x",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __entry->flags)
+);
+
+TRACE_EVENT(fuse_iomap_lseek,
+	TP_PROTO(const struct inode *inode, loff_t offset, int whence),
+
+	TP_ARGS(inode, offset, whence),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(loff_t,			offset)
+		__field(int,			whence)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	offset;
+		__entry->whence		=	whence;
+	),
+
+	TP_printk(FUSE_INODE_FMT " offset 0x%llx whence %d",
+		  FUSE_INODE_PRINTK_ARGS,
+		  __entry->offset,
+		  __entry->whence)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 29603eec939589..88d85d572faf97 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -693,6 +693,8 @@ int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (!fuse_allow_current_process(fc))
 		return -EACCES;
 
+	trace_fuse_iomap_fiemap(inode, start, count, fieinfo->fi_flags);
+
 	inode_lock_shared(inode);
 	error = iomap_fiemap(inode, fieinfo, start, count, &fuse_iomap_ops);
 	inode_unlock_shared(inode);
@@ -720,6 +722,8 @@ loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence)
 	if (!fuse_allow_current_process(fc))
 		return -EACCES;
 
+	trace_fuse_iomap_lseek(inode, offset, whence);
+
 	switch (whence) {
 	case SEEK_HOLE:
 		offset = iomap_seek_hole(inode, offset, &fuse_iomap_ops);


