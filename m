Return-Path: <linux-fsdevel+bounces-55344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0002BB09816
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF2F560942
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906A523771E;
	Thu, 17 Jul 2025 23:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lC8gQF64"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6287233D85
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795250; cv=none; b=pJuOsfW2gO1RZBM9Ez3BpeIdgMlmnd2vhQ2VAsOyp1BFgOyd881KVUPKHxIZ5BXGpjdTdWB00SP5cQsK+5lPcCgp/lWkId2VzaZylDJLX1ww0s/EhWIXRDNfYORNE6EzN2nAkrUhYt4sl2SFXh1uLfzBQ/Lr1JyBt+0iCaOvIuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795250; c=relaxed/simple;
	bh=pTXzVldjJPnHehINam94ZOf3KrZF5WWkTM87hLP37yg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gFsYCEFegp6dnVRBQJxHAQTrvI9ovdGhAGU3XZeQxwhT/DuT8KkPcbaN/6C9r45a1hSZMLiUx1xq1BSV40+KnZ2lPqLMlZB7smy+Hb2atkaYUOlpyeE3rgMSUGANaxA6NoBXRsAoh2bBNwGSxcjoM4kJyTxpyl/Y2MCy8GCgWGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lC8gQF64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7188C4CEE3;
	Thu, 17 Jul 2025 23:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795249;
	bh=pTXzVldjJPnHehINam94ZOf3KrZF5WWkTM87hLP37yg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=lC8gQF64l5Z8xBza+HAPPJq9K1sv+wOwbubBXGNZqS1kqCikXQIS4QTuUWPRz1bsh
	 YYRykKxZYYEUoXVIgdojB/KdT+89h9byTOfzr1H0PjWPr9jhV43iulNw9tPFinN34U
	 KkjfPAomlSw0Xf0nZKiP/nQPHN2Y3YzpsLUj2xE6xT+9LjZpuV3XlUd+txivmdbzvv
	 e2bzwGxRsr+1v5ZBCcxLaJ23D5qWX5y6bDfX/f905rbbwW3dqxSk+GUQZFguh1bX94
	 tLpDGFLTQUxJTtYtpgQWEjfHXDfqCf5XQ9xVe/gFCHw/y7QL6SUamReNmm/hRY+08b
	 pKMkcvsYQyrSQ==
Date: Thu, 17 Jul 2025 16:34:09 -0700
Subject: [PATCH 6/7] fuse: let the kernel handle KILL_SUID/KILL_SGID for iomap
 filesystems
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279450911.713693.16017220192619711299.stgit@frogsfrogsfrogs>
In-Reply-To: <175279450745.713693.16690872492281672288.stgit@frogsfrogsfrogs>
References: <175279450745.713693.16690872492281672288.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Let the kernel handle killing the suid/sgid bits because the
write/falloc/truncate/chown code already does this, and we don't have to
worry about external modifications that are only visible to the fuse
server (i.e. we're not a cluster fs).

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c        |   15 ++++++++--
 2 files changed, 84 insertions(+), 3 deletions(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index e5a41be1bfd6cf..c6b6757bd8bc3c 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -159,6 +159,78 @@ TRACE_EVENT(fuse_fileattr_update_inode,
 		  __entry->isize, __entry->old_iflags, __entry->new_iflags)
 );
 
+TRACE_EVENT(fuse_setattr_fill,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_setattr_in *inarg),
+	TP_ARGS(inode, inarg),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+		__field(uint64_t,		ino)
+		__field(uint64_t,		nodeid)
+		__field(umode_t,		mode)
+		__field(loff_t,			isize)
+
+		__field(uint32_t,		valid)
+		__field(umode_t,		new_mode)
+		__field(uint64_t,		new_size)
+	),
+
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->nodeid		=	inode->i_ino;
+		__entry->isize		=	i_size_read(inode);
+		__entry->valid		=	inarg->valid;
+		__entry->new_mode	=	inarg->mode;
+		__entry->new_size	=	inarg->size;
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu mode 0%o isize 0x%llx valid 0x%x new_mode 0%o new_size 0x%llx",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->mode, __entry->isize, __entry->valid,
+		  __entry->new_mode, __entry->new_size)
+);
+
+TRACE_EVENT(fuse_setattr,
+	TP_PROTO(const struct inode *inode,
+		 const struct iattr *inarg),
+	TP_ARGS(inode, inarg),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+		__field(uint64_t,		ino)
+		__field(uint64_t,		nodeid)
+		__field(umode_t,		mode)
+		__field(loff_t,			isize)
+
+		__field(uint32_t,		valid)
+		__field(umode_t,		new_mode)
+		__field(uint64_t,		new_size)
+	),
+
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->nodeid		=	inode->i_ino;
+		__entry->isize		=	i_size_read(inode);
+		__entry->valid		=	inarg->ia_valid;
+		__entry->new_mode	=	inarg->ia_mode;
+		__entry->new_size	=	inarg->ia_size;
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu mode 0%o isize 0x%llx valid 0x%x new_mode 0%o new_size 0x%llx",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->mode, __entry->isize, __entry->valid,
+		  __entry->new_mode, __entry->new_size)
+);
+
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
 struct fuse_iext_cursor;
 
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 4cdd3ef0793379..8422310d070665 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -7,6 +7,7 @@
 */
 
 #include "fuse_i.h"
+#include "fuse_trace.h"
 
 #include <linux/pagemap.h>
 #include <linux/file.h>
@@ -1951,6 +1952,8 @@ static void fuse_setattr_fill(struct fuse_conn *fc, struct fuse_args *args,
 			      struct fuse_setattr_in *inarg_p,
 			      struct fuse_attr_out *outarg_p)
 {
+	trace_fuse_setattr_fill(inode, inarg_p);
+
 	args->opcode = FUSE_SETATTR;
 	args->nodeid = get_node_id(inode);
 	args->in_numargs = 1;
@@ -2219,15 +2222,21 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 	if (!fuse_allow_current_process(get_fuse_conn(inode)))
 		return -EACCES;
 
-	if (attr->ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID)) {
+	trace_fuse_setattr(inode, attr);
+
+	if (!fuse_has_iomap(inode) &&
+	    (attr->ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID))) {
 		attr->ia_valid &= ~(ATTR_KILL_SUID | ATTR_KILL_SGID |
 				    ATTR_MODE);
 
 		/*
 		 * The only sane way to reliably kill suid/sgid is to do it in
-		 * the userspace filesystem
+		 * the userspace filesystem if this isn't an iomap file.  For
+		 * iomap filesystems we let the kernel kill the setuid/setgid
+		 * bits.
 		 *
-		 * This should be done on write(), truncate() and chown().
+		 * This should be done on write(), truncate(), chown(), and
+		 * fallocate().
 		 */
 		if (!fc->handle_killpriv && !fc->handle_killpriv_v2) {
 			/*


