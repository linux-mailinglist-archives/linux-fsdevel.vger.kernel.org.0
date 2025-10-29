Return-Path: <linux-fsdevel+bounces-66007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2EEC179F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00464421019
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0552D320E;
	Wed, 29 Oct 2025 00:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPYy++Ft"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8FE1DF97F;
	Wed, 29 Oct 2025 00:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698776; cv=none; b=rrP9WT5DU0yxPryXOKAulPX8F5Cjkwf2Da9OdtBymYqwS6rYpwkyRfwris+bceZRt3QYxhAxnZ/vWVYaPE+1cCeA2lS9aM7OaFROsdXxk7HWnbctxyHbM7WzLVpmI8k1Gx9b8wY864JP4xQ+9as/Y1AUWdla7ljITjsE+RHCAfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698776; c=relaxed/simple;
	bh=oEs8w5qVI3UZn4t0lpcf/tU0UDILxYde96tBRJcCCzU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/4GGWrXL+H1NCp/Z9R41KetyQIfdlCuLQ6DBZkFcKby9Zty27IwylsVTexUo18Pb2kQAQOYilOsNfypW7wG2tR6bhz3StM9WhvNus8Z2rjXAJ5K+LNqEmgRqbPGL1sj8xmjcn0MGpw1C73C0qJhORgWCPoDjo+v0eWUTQUXjPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPYy++Ft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25772C4CEFD;
	Wed, 29 Oct 2025 00:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698776;
	bh=oEs8w5qVI3UZn4t0lpcf/tU0UDILxYde96tBRJcCCzU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ZPYy++FtXWh9IwUYO1OISZXkFsEUD7q1tWs9p4kE2/Ugsy5FXQMk/wdvgfmax/7wQ
	 qQtvTgHk+wbE0UqJVzMVWlu1o3tlObRYKuo0K/nVUAIsvxLG0Zs0BHTOz+h+LPfhY2
	 TJx0cfVomh8oSG9+UjayEj4I/FSSHFkaTqLag1u9qjtiTBCfZistrGQqb7Dv4iFo8y
	 DRLJEfxRxYIejp0iL2jlC2RBVTS3CBO2ipi0C1AcfCXpcFMIu8NL7TUYXB8ae41ypI
	 /pQUX6KP0M4MMcZQ89954Spe1akMO5cEbT4lgynrpPIsQESRyPZzALo9cIezKMfPM9
	 bb2ncqBPJZCGQ==
Date: Tue, 28 Oct 2025 17:46:15 -0700
Subject: [PATCH 05/31] fuse_trace: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to
 add new iomap devices
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169810459.1424854.2379990384513427528.stgit@frogsfrogsfrogs>
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

Enhance the existing backing file tracepoints to report the subsystem
that's actually using the backing file.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |   42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index c0878253e7c6ad..af21654d797f45 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -175,6 +175,10 @@ TRACE_EVENT(fuse_request_end,
 );
 
 #ifdef CONFIG_FUSE_BACKING
+#define FUSE_BACKING_FLAG_STRINGS \
+	{ FUSE_BACKING_TYPE_PASSTHROUGH,	"pass" }, \
+	{ FUSE_BACKING_TYPE_IOMAP,		"iomap" }
+
 TRACE_EVENT(fuse_backing_class,
 	TP_PROTO(const struct fuse_conn *fc, unsigned int idx,
 		 const struct fuse_backing *fb),
@@ -184,7 +188,9 @@ TRACE_EVENT(fuse_backing_class,
 	TP_STRUCT__entry(
 		__field(dev_t,			connection)
 		__field(unsigned int,		idx)
+		__field(unsigned int,		type)
 		__field(unsigned long,		ino)
+		__field(dev_t,			rdev)
 	),
 
 	TP_fast_assign(
@@ -193,12 +199,19 @@ TRACE_EVENT(fuse_backing_class,
 		__entry->connection	=	fc->dev;
 		__entry->idx		=	idx;
 		__entry->ino		=	inode->i_ino;
+		__entry->type		=	fb->ops->type;
+		if (fb->ops->type == FUSE_BACKING_TYPE_IOMAP)
+			__entry->rdev	=	inode->i_rdev;
+		else
+			__entry->rdev	=	0;
 	),
 
-	TP_printk("connection %u idx %u ino 0x%lx",
+	TP_printk("connection %u idx %u type %s ino 0x%lx rdev %u:%u",
 		  __entry->connection,
 		  __entry->idx,
-		  __entry->ino)
+		  __print_symbolic(__entry->type, FUSE_BACKING_FLAG_STRINGS),
+		  __entry->ino,
+		  MAJOR(__entry->rdev), MINOR(__entry->rdev))
 );
 #define DEFINE_FUSE_BACKING_EVENT(name)		\
 DEFINE_EVENT(fuse_backing_class, name,		\
@@ -210,7 +223,6 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 #endif /* CONFIG_FUSE_BACKING */
 
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
-
 /* tracepoint boilerplate so we don't have to keep doing this */
 #define FUSE_IOMAP_OPFLAGS_FIELD \
 		__field(unsigned,		opflags)
@@ -452,6 +464,30 @@ TRACE_EVENT(fuse_iomap_end_error,
 		  __entry->written,
 		  __entry->error)
 );
+
+TRACE_EVENT(fuse_iomap_dev_add,
+	TP_PROTO(const struct fuse_conn *fc,
+		 const struct fuse_backing_map *map),
+
+	TP_ARGS(fc, map),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+		__field(int,			fd)
+		__field(unsigned int,		flags)
+	),
+
+	TP_fast_assign(
+		__entry->connection	=	fc->dev;
+		__entry->fd		=	map->fd;
+		__entry->flags		=	map->flags;
+	),
+
+	TP_printk("connection %u fd %d flags 0x%x",
+		  __entry->connection,
+		  __entry->fd,
+		  __entry->flags)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */


