Return-Path: <linux-fsdevel+bounces-58472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72D6B2E9E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FC9A25566
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BE01991DD;
	Thu, 21 Aug 2025 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5bfkLIA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DB74315A
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738035; cv=none; b=gJJE1c9fLgUTTIrPwZfVB/vcDGWolbDdEuUJMcI4UaJJv738J4dA43aFueKQm+yk3ohF+QMqf2zAI0l5dCxPt3o3lvoEu9a+b1n40aXPKu7rbQiQzQtmfJai0oQSzqRB28Z8k+4JCiqX1E2kXfrsrYfFBlXUa5GxafZQUx1Kzrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738035; c=relaxed/simple;
	bh=TQv6eHT+kAyPHzYX2TMM2WYEZzB0PbzSVDDlhrwh33k=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HugjiBAuMjnB4fNjMn1B8E1EYDo3laGeEwUjpc6a3DwjwsMf2pXVkTZLhWISBNESFxgsVECCzdVrbRwh3+BsPDb8ri2HpmFsh+ctAhWd0r/Y2+tKk/OLooJUdlK4dynroSlOiQS/CKDlmeZPVeMOy2MMzvnbwp+QcCAQLhQb+aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5bfkLIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEB3C4CEE7;
	Thu, 21 Aug 2025 01:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738035;
	bh=TQv6eHT+kAyPHzYX2TMM2WYEZzB0PbzSVDDlhrwh33k=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=e5bfkLIAwNoSsB75wD2NZgjeAIB4MRPqRwKSxQRjkOHZiIzPUZMx4Il0VZsJ8PTsN
	 BgqxI0l280kEsR/DuJDID8WFUB9tm1HBqZOK9+zmNQc9q6SJJcXehSCg4to1jfSLIR
	 rrGAwa0+ECccVqvMi37ftyEZCjM8LJYfYlJe4zv64oEJFO9yj/h93tudO67YDHpyTG
	 EbK9rkWQA8MDbb8Up/5yuPCJt8INiCt2QQwMXjcY7/92LyLocBuGtTYT3O0ZocwPNu
	 0ZJNP9NuzfsQJ0HVhI7nHLFOavAd9JU7VYNMBhKJdiRGCVkqlhytVJF6oPLKbaM9BQ
	 cCYWqsVkiawbg==
Date: Wed, 20 Aug 2025 18:00:35 -0700
Subject: [PATCH 4/6] fuse: let the kernel handle KILL_SUID/KILL_SGID for iomap
 filesystems
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573710267.18622.654364301804267394.stgit@frogsfrogsfrogs>
In-Reply-To: <175573710148.18622.12330106999267016022.stgit@frogsfrogsfrogs>
References: <175573710148.18622.12330106999267016022.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c        |   15 ++++++++++---
 2 files changed, 70 insertions(+), 3 deletions(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index aea9ea0835d497..18606eb0bf8dd7 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -199,6 +199,64 @@ TRACE_EVENT(fuse_fileattr_update_inode,
 		  __entry->new_iflags)
 );
 
+TRACE_EVENT(fuse_setattr_fill,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_setattr_in *inarg),
+	TP_ARGS(inode, inarg),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(umode_t,		mode)
+		__field(uint32_t,		valid)
+		__field(umode_t,		new_mode)
+		__field(uint64_t,		new_size)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->mode		=	inode->i_mode;
+		__entry->valid		=	inarg->valid;
+		__entry->new_mode	=	inarg->mode;
+		__entry->new_size	=	inarg->size;
+	),
+
+	TP_printk(FUSE_INODE_FMT " mode 0%o valid 0x%x new_mode 0%o new_size 0x%llx",
+		  FUSE_INODE_PRINTK_ARGS,
+		  __entry->mode,
+		  __entry->valid,
+		  __entry->new_mode,
+		  __entry->new_size)
+);
+
+TRACE_EVENT(fuse_setattr,
+	TP_PROTO(const struct inode *inode,
+		 const struct iattr *inarg),
+	TP_ARGS(inode, inarg),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(umode_t,		mode)
+		__field(uint32_t,		valid)
+		__field(umode_t,		new_mode)
+		__field(uint64_t,		new_size)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->mode		=	inode->i_mode;
+		__entry->valid		=	inarg->ia_valid;
+		__entry->new_mode	=	inarg->ia_mode;
+		__entry->new_size	=	inarg->ia_size;
+	),
+
+	TP_printk(FUSE_INODE_FMT " mode 0%o valid 0x%x new_mode 0%o new_size 0x%llx",
+		  FUSE_INODE_PRINTK_ARGS,
+		  __entry->mode,
+		  __entry->valid,
+		  __entry->new_mode,
+		  __entry->new_size)
+);
+
 #ifdef CONFIG_FUSE_BACKING
 #define FUSE_BACKING_PASSTHROUGH	(1U << 0)
 #define FUSE_BACKING_IOMAP		(1U << 1)
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index a3ea50b99054ff..e8eef46d8e1b52 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -7,6 +7,7 @@
 */
 
 #include "fuse_i.h"
+#include "fuse_trace.h"
 
 #include <linux/pagemap.h>
 #include <linux/file.h>
@@ -1999,6 +2000,8 @@ static void fuse_setattr_fill(struct fuse_conn *fc, struct fuse_args *args,
 			      struct fuse_setattr_in *inarg_p,
 			      struct fuse_attr_out *outarg_p)
 {
+	trace_fuse_setattr_fill(inode, inarg_p);
+
 	args->opcode = FUSE_SETATTR;
 	args->nodeid = get_node_id(inode);
 	args->in_numargs = 1;
@@ -2273,15 +2276,21 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
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


