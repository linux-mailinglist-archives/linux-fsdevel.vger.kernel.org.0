Return-Path: <linux-fsdevel+bounces-66043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FDAC17AD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E63A3BF761
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BB32D7386;
	Wed, 29 Oct 2025 00:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9VJxxVJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B2E283124;
	Wed, 29 Oct 2025 00:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699340; cv=none; b=QyBqvBVCa8zpYb/G7ql5ZRqOuyFFYX9Mm6HMYOS36k9qKHq63pbwwsTZH7f0RdxFrDi/F8ZpjXSqahbYAim9Elfnlww4+YQLogqWg6EB/4CDxvIy/QjOiqjXmjicJ/vgUqHFDEcX9gGIIwZOIqB9pyAlclOa0NyZzTD5bLF6jg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699340; c=relaxed/simple;
	bh=l5p0CETeY5AOCvVD6iiyzJsoACetGxC5acR0ndVGuA4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nW//bY7Qvp+cNBOpXwrA5hnyTP9y+hWtEWyyWJ3HJfPh/vYgURnrijWC0hgM1N00CYHEylX2WLZYv+NKbXDmcXYfnFqshia7fIbAS0YMlw7AproiXmtWfsHeRxjPT969QIc6U0IAIJioLfUOtQLUk4c/HfWq+ezBI+SCtieOdVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9VJxxVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144F2C4CEFD;
	Wed, 29 Oct 2025 00:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699340;
	bh=l5p0CETeY5AOCvVD6iiyzJsoACetGxC5acR0ndVGuA4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=c9VJxxVJ7zshrxwu9ExsM67T9bLuzRwl4ICGjkU7MEeFAPaC3oWIPi1SK83y2w8pw
	 pe3PqHyv/aBTe0NYkc6CYSTUmv+rG2t1O5VoylbfyFW8+JdAxVsnZU/VroFamudYJV
	 Di75/a/np/rSp4Q4Q3HoznBhrivYdJFqYZj7pKt6Nvq5C52pq4Vd5jNfNGoYDPfWet
	 E7yoX9UdpB3zfQNmgdloe8cz/11fdgVf1n2MivcqVbdZsQH7VovyuHdMsJD/fu/ccc
	 qe01gJoSD+e+pBPEzlBo21JqmW/sEVoT1A9XXw00sla4kPBUKWxJeirr/8XsOOX3V9
	 4IgoNG9Hotmkw==
Date: Tue, 28 Oct 2025 17:55:38 -0700
Subject: [PATCH 7/9] fuse_trace: let the kernel handle KILL_SUID/KILL_SGID for
 iomap filesystems
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169811742.1426244.10176905147897769604.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c        |    5 ++++
 2 files changed, 63 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 817bb6a5d3a961..c4bf5a70594cf6 100644
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
index 9435d6b8d14ea4..4fc66ff0231089 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -7,6 +7,7 @@
 */
 
 #include "fuse_i.h"
+#include "fuse_trace.h"
 
 #include <linux/pagemap.h>
 #include <linux/file.h>
@@ -1995,6 +1996,8 @@ static void fuse_setattr_fill(struct fuse_conn *fc, struct fuse_args *args,
 			      struct fuse_setattr_in *inarg_p,
 			      struct fuse_attr_out *outarg_p)
 {
+	trace_fuse_setattr_fill(inode, inarg_p);
+
 	args->opcode = FUSE_SETATTR;
 	args->nodeid = get_node_id(inode);
 	args->in_numargs = 1;
@@ -2270,6 +2273,8 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 	if (!fuse_allow_current_process(get_fuse_conn(inode)))
 		return -EACCES;
 
+	trace_fuse_setattr(inode, attr);
+
 	if (!is_iomap &&
 	    (attr->ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID))) {
 		attr->ia_valid &= ~(ATTR_KILL_SUID | ATTR_KILL_SGID |


