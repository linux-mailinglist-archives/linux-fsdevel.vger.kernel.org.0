Return-Path: <linux-fsdevel+bounces-61545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCE8B589C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA4A167527
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97D483CC7;
	Tue, 16 Sep 2025 00:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQoe049g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB9ED528;
	Tue, 16 Sep 2025 00:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983073; cv=none; b=htvOCGURlGdhQ00atOy3fo57SbweaYGqh5dnnHX5FGFwMUFkYlTy7Lnca7DyyxRT8AnHIk5gQiuRPcSYICKX1fwSzuVw8FPmv9nziDnLlJD9T5aF1InEZ7sc+AXIbfvIXXnszae+fkXi0Gn0e9IoqyMCd4fYDgVSQVaN9Y2ATzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983073; c=relaxed/simple;
	bh=gU588xLmHYAE4GAPdMxg7xwGOSIhI5LXi8tfA2ymBGk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6XtwVd0khgqIs0+mszBfDatf3CcSm8yF/HdPrfKe+9q1+Mkl6RnXMvlq7hTkIrE0A5Vl4bOWnUIgIidwNAAyttJyInYk23KWyQtjXvyB9ZvnMNdDa6ZtxxbfE2SyEFa2Y85e1CqZX1LB2j49UeWuSnMIgCq2RhJnB/jocIsDnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQoe049g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17ACBC4CEF1;
	Tue, 16 Sep 2025 00:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983073;
	bh=gU588xLmHYAE4GAPdMxg7xwGOSIhI5LXi8tfA2ymBGk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=tQoe049gaxR88Qys1av4Xik5Blul7PzQTqqcjp6+9b+qgZpJlDlOoOz5/csE2kDck
	 0MmlXK9iX60w2svNCOeNAcD3BhsTjoQ55dQWMQk26VsA9rhStuHnUJ395NERrU3Ymx
	 Lrsr8fsbONCF1PrbFlAZLrUGg7tC0mP7aMhvyJgeUHvKqFSBALGFfuNYyBCyi8f82b
	 D5mggcwqhYJ9tsqu32LJGL0xvqfudPKcGBThZBPluNCkoEOIpzbCswcu+WRn15yb6H
	 vSwt76Z5lq3oLim9k0ZQSDaqeHPk9/ZmH+8RpEaDSxhB4hqWRIlGfpaQKS8TOTnqHu
	 G5c6yRJpgw0iw==
Date: Mon, 15 Sep 2025 17:37:52 -0700
Subject: [PATCH 7/9] fuse_trace: let the kernel handle KILL_SUID/KILL_SGID for
 iomap filesystems
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798152588.383971.2067850467365061230.stgit@frogsfrogsfrogs>
In-Reply-To: <175798152384.383971.2031565738833129575.stgit@frogsfrogsfrogs>
References: <175798152384.383971.2031565738833129575.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c        |    5 ++++
 2 files changed, 63 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 2aff78a30503ee..1f900580b14937 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -205,6 +205,64 @@ DEFINE_EVENT(fuse_fileattr_class, name,		\
 DEFINE_FUSE_FILEATTR_EVENT(fuse_fileattr_update_inode);
 DEFINE_FUSE_FILEATTR_EVENT(fuse_fileattr_init);
 
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
 #define FUSE_BACKING_FLAG_STRINGS \
 	{ FUSE_BACKING_TYPE_PASSTHROUGH,	"pass" }, \
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 2e1837b2363e83..58106f49395697 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -7,6 +7,7 @@
 */
 
 #include "fuse_i.h"
+#include "fuse_trace.h"
 
 #include <linux/pagemap.h>
 #include <linux/file.h>
@@ -2002,6 +2003,8 @@ static void fuse_setattr_fill(struct fuse_conn *fc, struct fuse_args *args,
 			      struct fuse_setattr_in *inarg_p,
 			      struct fuse_attr_out *outarg_p)
 {
+	trace_fuse_setattr_fill(inode, inarg_p);
+
 	args->opcode = FUSE_SETATTR;
 	args->nodeid = get_node_id(inode);
 	args->in_numargs = 1;
@@ -2277,6 +2280,8 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 	if (!fuse_allow_current_process(get_fuse_conn(inode)))
 		return -EACCES;
 
+	trace_fuse_setattr(inode, attr);
+
 	if (!is_iomap &&
 	    (attr->ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID))) {
 		attr->ia_valid &= ~(ATTR_KILL_SUID | ATTR_KILL_SGID |


