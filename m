Return-Path: <linux-fsdevel+bounces-61542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6D3B589BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F52C1B25C8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8351A0711;
	Tue, 16 Sep 2025 00:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UY75poJn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0E5D528;
	Tue, 16 Sep 2025 00:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983026; cv=none; b=agGlQzpIgzsZrR2Zav/4YcOYteQaMfoDVsc+WEMXMfoW3153tyWk3J8DCLcEUsrH6z/QdIC+sjZHqnGUOe6Wd6BEmLfgAnDn0V/YyLTbybti8OTMz6z1wygd6PAhSbTp8Tvqes6/ucAWq/+G9b9riOU1qwpXufAoKA19XxiKI6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983026; c=relaxed/simple;
	bh=y2QQaa/qmiStRCXXwa20Udr7L0YfDmYl3ZRACDm3aK4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KF/lTJdT/wINzOZmmTxmprts70G/w3UXRwax1aa8gMppJFGraiaVW2lucJ5IqQPH17KxbCo3zWhnLShbQp2e33FSe7PufMfWVrRtA2hg/Z1dqCuyPXerFbE6KXye06B/7poSRK7S1E99nHjug5EH5+UDbTEo0fd3ruJh3hhg+F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UY75poJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420ADC4CEF1;
	Tue, 16 Sep 2025 00:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983026;
	bh=y2QQaa/qmiStRCXXwa20Udr7L0YfDmYl3ZRACDm3aK4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UY75poJnd7bOHHXHG7oSEcbH36ztgAAP81+mUL2LEZxb/2iHjgU/Gyyo7mjumeCx9
	 y29dmeRYXeakeZ3HwZCiGV2TCdqhIIBWgY3/YUwEwZzfq+rJK3vnwGQVsnxHMmOJE4
	 OCiZ8OJnH0QHPAEZO+a5H/t7jEiteI65l6MrRw28CNpmzNPr5I5VhoNAWGO8x9MDdq
	 WJsvEpYZepsale/R0UNattk/2AORyz9m2mG6cCnEMKJqNXkzfcm88faS/eHfl897VY
	 0sBgry90XbXiX0nJwpELfdX4Q0uE+IgL4W2e3R1YTV41Gl8Ldh8Js1d1vmXIohb7+G
	 7JQyv9rsI8t9Q==
Date: Mon, 15 Sep 2025 17:37:05 -0700
Subject: [PATCH 4/9] fuse_trace: allow local filesystems to set some VFS
 iflags
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798152524.383971.15999169183903801894.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   29 +++++++++++++++++++++++++++++
 fs/fuse/ioctl.c      |    6 ++++++
 2 files changed, 35 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 9c2eb497730b06..2aff78a30503ee 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -176,6 +176,35 @@ TRACE_EVENT(fuse_request_end,
 		  __entry->unique, __entry->len, __entry->error)
 );
 
+DECLARE_EVENT_CLASS(fuse_fileattr_class,
+	TP_PROTO(const struct inode *inode, unsigned int old_iflags),
+
+	TP_ARGS(inode, old_iflags),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(unsigned int,		old_iflags)
+		__field(unsigned int,		new_iflags)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->old_iflags	=	old_iflags;
+		__entry->new_iflags	=	inode->i_flags;
+	),
+
+	TP_printk(FUSE_INODE_FMT " old_iflags 0x%x iflags 0x%x",
+		  FUSE_INODE_PRINTK_ARGS,
+		  __entry->old_iflags,
+		  __entry->new_iflags)
+);
+#define DEFINE_FUSE_FILEATTR_EVENT(name)	\
+DEFINE_EVENT(fuse_fileattr_class, name,		\
+	TP_PROTO(const struct inode *inode, unsigned int old_iflags), \
+	TP_ARGS(inode, old_iflags))
+DEFINE_FUSE_FILEATTR_EVENT(fuse_fileattr_update_inode);
+DEFINE_FUSE_FILEATTR_EVENT(fuse_fileattr_init);
+
 #ifdef CONFIG_FUSE_BACKING
 #define FUSE_BACKING_FLAG_STRINGS \
 	{ FUSE_BACKING_TYPE_PASSTHROUGH,	"pass" }, \
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index fc0c9bac7a5939..2ac1911dc5cc83 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -4,6 +4,7 @@
  */
 
 #include "fuse_i.h"
+#include "fuse_trace.h"
 
 #include <linux/uio.h>
 #include <linux/compat.h>
@@ -531,6 +532,8 @@ static void fuse_fileattr_update_inode(struct inode *inode,
 		update_iflag(inode, S_APPEND, fa->fsx_xflags & FS_XFLAG_APPEND);
 	}
 
+	trace_fuse_fileattr_update_inode(inode, old_iflags);
+
 	if (old_iflags != inode->i_flags)
 		fuse_invalidate_attr(inode);
 }
@@ -538,6 +541,7 @@ static void fuse_fileattr_update_inode(struct inode *inode,
 void fuse_fileattr_init(struct inode *inode, const struct fuse_attr *attr)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	unsigned int old_iflags = inode->i_flags;
 
 	if (!fc->local_fs)
 		return;
@@ -550,6 +554,8 @@ void fuse_fileattr_init(struct inode *inode, const struct fuse_attr *attr)
 
 	if (attr->flags & FUSE_ATTR_APPEND)
 		inode->i_flags |= S_APPEND;
+
+	trace_fuse_fileattr_init(inode, old_iflags);
 }
 
 int fuse_fileattr_get(struct dentry *dentry, struct file_kattr *fa)


