Return-Path: <linux-fsdevel+bounces-66010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A34C179F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66061AA6F48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACD12D4807;
	Wed, 29 Oct 2025 00:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ho8PQ4FP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767881DF97F;
	Wed, 29 Oct 2025 00:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698823; cv=none; b=U1XdLAChr21rbPA2kLE0IRFL7D0dTGAE3NWawmbL7SYUy1K7uF9nLWjXUw9iyhVsVrgTefp4tBL9d40QR/pg2s9+2RdtQ9cGXInAh9kPF3/SPCvKr0L7MAWtghIyiW99g30S1IM97GkozTcNyyPqhofr+LiTvnK6KJIYdjGHYTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698823; c=relaxed/simple;
	bh=iWGObAU7zyPdzyZ7ua03gwZfJjef+Dvps8xKChXrPmU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqxK8+ifLZWAXitJhATK1Z+G75tHvZtaKTYxkTsn2g3n5zWvT31hkzFu06J5urFGpCtDQ5SIGMNS1UzZx4z4k+f7KpX+/oFl/OHvKWbKEvtEabNMgf9kHOJDUEt1qnD/VkhaqwIAcviCOO2uow/y3x284XhJ5Opfmdlil4/GoXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ho8PQ4FP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8959C4CEFD;
	Wed, 29 Oct 2025 00:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698823;
	bh=iWGObAU7zyPdzyZ7ua03gwZfJjef+Dvps8xKChXrPmU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Ho8PQ4FPYWz8XYJxePNjGLAy2n4JCnz3R0mUDF+CD2Dp0WFcIApeQAuiO59Nc5VMU
	 BNUSWHMFE0MwsI7Z+H+ZuIIrH/OIltKkbIUs8XiW5AFeogMFxGKrW0+PwVN9UiA/ji
	 kOuWlVBILpxLaTnxmXD66KHM5oFU/hNyowfZInC8jhsCkLk+pJANpDp9WeelBq82yo
	 1tS1uSIcy5hXsIE7nv5T03UrrDM3Nspy9Ufo1vF/69wO+ksm7yPT550/EEhkNh2ExK
	 R6Lt+7+aOwiO6ldDiz7EUcO/L/bo4trD0C0Ow9lDnPXaQhDokwSPZGp/bb3xIpuKhQ
	 HxODV6+/NYn9w==
Date: Tue, 28 Oct 2025 17:47:02 -0700
Subject: [PATCH 08/31] fuse_trace: create a per-inode flag for toggling iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169810525.1424854.9261554714410154355.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   44 ++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file_iomap.c |    6 ++++++
 2 files changed, 50 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index af21654d797f45..fac981e2a30df0 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -300,6 +300,25 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 	{ FUSE_IOMAP_TYPE_UNWRITTEN,		"unwritten" }, \
 	{ FUSE_IOMAP_TYPE_INLINE,		"inline" }
 
+TRACE_DEFINE_ENUM(FUSE_I_ADVISE_RDPLUS);
+TRACE_DEFINE_ENUM(FUSE_I_INIT_RDPLUS);
+TRACE_DEFINE_ENUM(FUSE_I_SIZE_UNSTABLE);
+TRACE_DEFINE_ENUM(FUSE_I_BAD);
+TRACE_DEFINE_ENUM(FUSE_I_BTIME);
+TRACE_DEFINE_ENUM(FUSE_I_CACHE_IO_MODE);
+TRACE_DEFINE_ENUM(FUSE_I_EXCLUSIVE);
+TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
+
+#define FUSE_IFLAG_STRINGS \
+	{ 1 << FUSE_I_ADVISE_RDPLUS,		"advise_rdplus" }, \
+	{ 1 << FUSE_I_INIT_RDPLUS,		"init_rdplus" }, \
+	{ 1 << FUSE_I_SIZE_UNSTABLE,		"size_unstable" }, \
+	{ 1 << FUSE_I_BAD,			"bad" }, \
+	{ 1 << FUSE_I_BTIME,			"btime" }, \
+	{ 1 << FUSE_I_CACHE_IO_MODE,		"cacheio" }, \
+	{ 1 << FUSE_I_EXCLUSIVE,		"excl" }, \
+	{ 1 << FUSE_I_IOMAP,			"iomap" }
+
 DECLARE_EVENT_CLASS(fuse_iomap_check_class,
 	TP_PROTO(const char *func, int line, const char *condition),
 
@@ -488,6 +507,31 @@ TRACE_EVENT(fuse_iomap_dev_add,
 		  __entry->fd,
 		  __entry->flags)
 );
+
+DECLARE_EVENT_CLASS(fuse_inode_state_class,
+	TP_PROTO(const struct inode *inode),
+	TP_ARGS(inode),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(unsigned long,		state)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->state		=	fi->state;
+	),
+
+	TP_printk(FUSE_INODE_FMT " state (%s)",
+		  FUSE_INODE_PRINTK_ARGS,
+		  __print_flags(__entry->state, "|", FUSE_IFLAG_STRINGS))
+);
+#define DEFINE_FUSE_INODE_STATE_EVENT(name)	\
+DEFINE_EVENT(fuse_inode_state_class, name,	\
+	TP_PROTO(const struct inode *inode),	\
+	TP_ARGS(inode))
+DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_init_inode);
+DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_evict_inode);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index fc0d5f135bacf9..66a7b8faa31ac2 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -659,6 +659,8 @@ void fuse_iomap_init_nonreg_inode(struct inode *inode, unsigned attr_flags)
 
 	if (conn->iomap && (attr_flags & FUSE_ATTR_IOMAP))
 		set_bit(FUSE_I_EXCLUSIVE, &fi->state);
+
+	trace_fuse_iomap_init_inode(inode);
 }
 
 void fuse_iomap_init_reg_inode(struct inode *inode, unsigned attr_flags)
@@ -672,6 +674,8 @@ void fuse_iomap_init_reg_inode(struct inode *inode, unsigned attr_flags)
 		set_bit(FUSE_I_EXCLUSIVE, &fi->state);
 		fuse_inode_set_iomap(inode);
 	}
+
+	trace_fuse_iomap_init_inode(inode);
 }
 
 void fuse_iomap_evict_inode(struct inode *inode)
@@ -679,6 +683,8 @@ void fuse_iomap_evict_inode(struct inode *inode)
 	struct fuse_conn *conn = get_fuse_conn(inode);
 	struct fuse_inode *fi = get_fuse_inode(inode);
 
+	trace_fuse_iomap_evict_inode(inode);
+
 	if (fuse_inode_has_iomap(inode))
 		fuse_inode_clear_iomap(inode);
 	if (conn->iomap && fuse_inode_is_exclusive(inode))


