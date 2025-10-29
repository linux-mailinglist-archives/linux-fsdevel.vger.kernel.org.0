Return-Path: <linux-fsdevel+bounces-66013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE852C17A0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7BA593561C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E16D2D29A9;
	Wed, 29 Oct 2025 00:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCsF2FJp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083AF1DE8B5;
	Wed, 29 Oct 2025 00:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698870; cv=none; b=jlkcMVF4sCe9Z12LV5JFd8+5XU28DVpqLBCou/9+DVj8M0/zVhs0uLGsznkyqMCE2M7yCbe2QnifZN1POgY0bhxF87++Ng7Kkps8UcPdGsGhGp8pK+rsrjW30wSl9QKo17MM2FDeKNXTC4hkEnvSutpvCqFtYVhyjsNUqD4zuHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698870; c=relaxed/simple;
	bh=IkeYak5mcXP70SwIyRy5nPN522zv86sbADZMmzZZ/9E=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nSySx5CRrUAMo420XzJVWhg3PW1wd5KZe6QIxrXRPaqB6mxtiiop/JheyONGLwZj5YUZT7rT7Kgw+HD8AHOMyEdbQg/tFhva/ONGOWenDEVkDWZ3llrOMvuD9oDMGQnapuC2JM5k8ewppsWKEqaic1+CpPgOIb5gKxK6KD3iseU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCsF2FJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB221C4CEE7;
	Wed, 29 Oct 2025 00:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698869;
	bh=IkeYak5mcXP70SwIyRy5nPN522zv86sbADZMmzZZ/9E=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=BCsF2FJpF2dNhyWfrd0GAzPFW3psAwZwZpGlU5OdrH9JX2Y4nPVC+sb3aABnG1RbD
	 P/RTvWSCcFizQqEb2LEOjmefwFJ7s+aszf8MLhuYRozr8FYPO1m8NzCISVAEklwv4r
	 ei/GYcNM4AChy9wl3ETkJmSauz21Q6qAG2ubo+b9LK7DDx/7kaqzeKuvxVubX0m8Mg
	 2BD7MPav/VlCcCLVONai+MdJNt/IMfiMbDJTQ3tvlYQmlSQYnntavcqqaPBSnWBb3T
	 jf4pJ8gTCo85w3HAIjLcie4yt9KSk6/0ZMQHt/lhg154hniB0lMNm2mWKx9IsZNm/s
	 eLau4nU1txq7w==
Date: Tue, 28 Oct 2025 17:47:49 -0700
Subject: [PATCH 11/31] fuse_trace: implement basic iomap reporting such as
 FIEMAP and SEEK_{DATA,HOLE}
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169810591.1424854.7337339383077106776.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
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
index fac981e2a30df0..730ab8bce44450 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -532,6 +532,52 @@ DEFINE_EVENT(fuse_inode_state_class, name,	\
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
index ce64e7c4860ef8..c63527cec0448b 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -714,6 +714,8 @@ int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (!fuse_allow_current_process(fc))
 		return -EACCES;
 
+	trace_fuse_iomap_fiemap(inode, start, count, fieinfo->fi_flags);
+
 	inode_lock_shared(inode);
 	error = iomap_fiemap(inode, fieinfo, start, count, &fuse_iomap_ops);
 	inode_unlock_shared(inode);
@@ -741,6 +743,8 @@ loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence)
 	if (!fuse_allow_current_process(fc))
 		return -EACCES;
 
+	trace_fuse_iomap_lseek(inode, offset, whence);
+
 	switch (whence) {
 	case SEEK_HOLE:
 		offset = iomap_seek_hole(inode, offset, &fuse_iomap_ops);


