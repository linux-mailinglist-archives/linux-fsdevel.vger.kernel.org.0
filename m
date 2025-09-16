Return-Path: <linux-fsdevel+bounces-61512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA25B58976
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB931B261E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08708224B01;
	Tue, 16 Sep 2025 00:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eC0phhzX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7331EF39E;
	Tue, 16 Sep 2025 00:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982557; cv=none; b=hKsMD9xeSFZRVQncUu+Hg5AId0PHmhzPdRqmohGW2TEmovhYsA0o+lAmanHpZqsncz+S66a0AlG/M95VhDvLjAPp46nqNUaYMH+cUGx4xW4i5EmChzzIovPwkpb7bVUh7e6Y3okrJsmJeMA0hGJU1VQUYBGyGkIIy8F8UdFMUdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982557; c=relaxed/simple;
	bh=1pDDzsdDFwUy6SvVIJIHPfx10+wUcyl4q2Q9w/9YlvI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MlxxuTvhJnEdzTItZkX+Mz/S7P7Jjz4pqqCcTQ/MvrLoPObQIK6RyvAgwrClXv7kGFfvou2zJgVfBVT6tnlQbUO1x6y4ba7SsRqIEDIFBIIm/xhSTSj7vITM6oIVoi07AVkbBaIMVSYbfToUUdQeGcYY2em+fqXsl13ykapbBC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eC0phhzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B2DC4CEF1;
	Tue, 16 Sep 2025 00:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982557;
	bh=1pDDzsdDFwUy6SvVIJIHPfx10+wUcyl4q2Q9w/9YlvI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=eC0phhzXTqXfjxugqNnPjPocmdys/jGm7kG4ez9ULoxB1PNbipPC7ADWUNdeZ9r2r
	 MPYkXAM+niuCp7zaEWnOi9DiJ8oLJgm8aQoJlMGhK3SowZVfBxEZBww5p+wfhuneZV
	 VldWJgn8ldIs6/Kkq/auIzc/mwre+WBYiIihKHP5El6/fYiP4jf4MqEBkeIAUvDqCp
	 0nIhdebR/htmdn+LeWQnBNK7mDSWVtD7pgfe2uHZZuRCUO4UMg1mjsKsIgkqZns2ne
	 JtOv7m+QufnVYjozIyGVaEBd/sojkY47K/pMk0LSZUwXnrSjea552g8FQh2YbahlyA
	 Q8HP5EZHw6n7A==
Date: Mon, 15 Sep 2025 17:29:16 -0700
Subject: [PATCH 05/28] fuse_trace: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to
 add new iomap devices
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798151374.382724.13838761022839240784.stgit@frogsfrogsfrogs>
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

Enhance the existing backing file tracepoints to report the subsystem
that's actually using the backing file.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |   42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index ef94f07cbbf2d4..d39029b30e0198 100644
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


