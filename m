Return-Path: <linux-fsdevel+bounces-66040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B16C17ABD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FDD44F2726
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D8D2D6E55;
	Wed, 29 Oct 2025 00:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRcXcEOS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BF6258ED8;
	Wed, 29 Oct 2025 00:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699292; cv=none; b=FPw20BSsVptwNbyUN+EPPWWf7sM9963vFPgejBI+eE6ojq/aUfoGlZWU10gpEVugq4Z/g9VMaazQpeAoptYNH2XYug9dxqwL/I2FqJbq1Knm56BBWgBLwbSt2MFVAqtXeHC7aPVNv1P/YBvYrG9G55QL07zV0ZVOmm2WzrGeCug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699292; c=relaxed/simple;
	bh=xUbjlByTH+WFykpMT63WMuyCBB+1dwfUMrQVARvmnb8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+jxm6bHRtFr5ezIsfcodwSXNxs2XTWMTR5eMvm1gtKqniUTfUA+Xj4Cxv48CxaaaNJ4DWu2BLRSXf3ROMH9qoVgcCROVef7nbDi6JJI0E+O0OoPNLtkputoCrbFtZjT6gE1Ist7lKlWfLmNqz1xDh4hL3ejh07vWCdB3N4ummY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRcXcEOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3B8C4CEE7;
	Wed, 29 Oct 2025 00:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699292;
	bh=xUbjlByTH+WFykpMT63WMuyCBB+1dwfUMrQVARvmnb8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DRcXcEOSEKJWWLSRiL+Tlf37wfTNbmWhzP+ZFX39WSvZYmwI4oLLMCvBWRjOQOewG
	 9/GrFU9i8AoPN9lDbs8SpfyQM53unKgqG3lsFE52egf1BVuqa2tvfqkeE66nWDUq+R
	 +0POOOXvbCCzYGjwESfQMOJ6w1yq6k65u+RnKwQg5mLbkiMTJHn/l3FwKlwhqPL7WX
	 0pbtop3XWk6avTa6rEP+jiXqdCC2rcW4WNozk+QueLhjSgf7c8chIwjGY703eLTuXU
	 jlmltaRCVtT89+EDddJom43memPbZnuk0TxdeT8xDT/dH/1eypb3ai9VWuO/c9lO9b
	 bCdetXcBKvocw==
Date: Tue, 28 Oct 2025 17:54:51 -0700
Subject: [PATCH 4/9] fuse_trace: allow local filesystems to set some VFS
 iflags
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169811678.1426244.3641881790453505639.stgit@frogsfrogsfrogs>
In-Reply-To: <176169811533.1426244.7175103913810588669.stgit@frogsfrogsfrogs>
References: <176169811533.1426244.7175103913810588669.stgit@frogsfrogsfrogs>
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
 fs/fuse/ioctl.c      |    7 +++++++
 2 files changed, 36 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 9a52f258ca3b2b..817bb6a5d3a961 100644
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
index bd2caf191ce2e0..5180066678e8c1 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -4,6 +4,7 @@
  */
 
 #include "fuse_i.h"
+#include "fuse_trace.h"
 
 #include <linux/uio.h>
 #include <linux/compat.h>
@@ -530,12 +531,16 @@ static void fuse_fileattr_update_inode(struct inode *inode,
 		update_iflag(inode, S_APPEND, fa->fsx_xflags & FS_XFLAG_APPEND);
 	}
 
+	trace_fuse_fileattr_update_inode(inode, old_iflags);
+
 	if (old_iflags != inode->i_flags)
 		fuse_invalidate_attr(inode);
 }
 
 void fuse_fileattr_init(struct inode *inode, const struct fuse_attr *attr)
 {
+	unsigned int old_iflags = inode->i_flags;
+
 	if (!fuse_inode_is_exclusive(inode))
 		return;
 
@@ -547,6 +552,8 @@ void fuse_fileattr_init(struct inode *inode, const struct fuse_attr *attr)
 
 	if (attr->flags & FUSE_ATTR_APPEND)
 		inode->i_flags |= S_APPEND;
+
+	trace_fuse_fileattr_init(inode, old_iflags);
 }
 
 int fuse_fileattr_get(struct dentry *dentry, struct file_kattr *fa)


