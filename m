Return-Path: <linux-fsdevel+bounces-61532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9025B589A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63533BC8F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12731A3172;
	Tue, 16 Sep 2025 00:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwPtUr7/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082C42032D;
	Tue, 16 Sep 2025 00:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982870; cv=none; b=LJsjOkjazig7tpKxCuXumXaFkKNyWTRXxrD1tzKdosd7vY2hEXSZRqm0M9p70WjEFSrtIIYAWDRKZvPYGsjV0bjI+cCM231dFHhlhSCLs03TsBhw4FFexutmUcVqcKKY1Hhrl6IAa4sdC5d27813bi0xqRP7fq8TZHiaMnCBh8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982870; c=relaxed/simple;
	bh=MoqOY+YHcj7XW8Igj1LnqNROKnIklzWW3i9c3AAkqi0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pPYU5brSnEZ7JYoqffZLhve+5QChVMsmhmou+JMIMcgwmOQ+Gv9yQxzzMExRslTUXnwzHYcb+ukNGFz3b9r3yrOML5P+GMYpIZ58Se5WB005cGkt8nkDkbBGad8blB1O7v/cB+BTrZ+04BnNbsN8g9ezETDjN1Dq2pmXIZlMyYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwPtUr7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45BDC4CEF1;
	Tue, 16 Sep 2025 00:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982869;
	bh=MoqOY+YHcj7XW8Igj1LnqNROKnIklzWW3i9c3AAkqi0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=RwPtUr7/YxWZDMkjMcdQ7s2NrBQqTmz15S98BxkPy+RoRwq225PwPWowAmGPrmdXu
	 AsYraVH7NrqcwTydWbOmd8MZ7a89TLKw6H8N1MlzD+L903giJl4/gVjbYquK5hNFy3
	 tY2zQV2e8W2kBkJJAeKVZX/OEkhp0uFseN5z3bq/ITYRv5TZl7A23f2tQfSijpLVPJ
	 fDR4AMoTNAYTiS689POWRakiUVGgBIqF/5BQHPPTvMYAT/pd5HPK36v/0NecfXb6++
	 vQayZ0Nj301JOeEOTx9SZQeylkpzmgVwQMlm0YYf7BnZ0JT/vwhH5YCm+nvKyxy9t0
	 Y6MFTK/b3354A==
Date: Mon, 15 Sep 2025 17:34:29 -0700
Subject: [PATCH 25/28] fuse_trace: implement inline data file IO via iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798151801.382724.6884306027898046714.stgit@frogsfrogsfrogs>
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

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |   45 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file_iomap.c |    7 +++++++
 2 files changed, 52 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 1cff42bc5907bf..b1c45abe40b440 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -227,6 +227,7 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
 struct iomap_writepage_ctx;
 struct iomap_ioend;
+struct iomap;
 
 /* tracepoint boilerplate so we don't have to keep doing this */
 #define FUSE_IOMAP_OPFLAGS_FIELD \
@@ -1042,6 +1043,50 @@ TRACE_EVENT(fuse_iomap_dev_inval,
 		  __entry->offset,
 		  __entry->length)
 );
+
+DECLARE_EVENT_CLASS(fuse_iomap_inline_class,
+	TP_PROTO(const struct inode *inode, loff_t pos, uint64_t count,
+		 const struct iomap *map),
+	TP_ARGS(inode, pos, count, map),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		FUSE_IOMAP_MAP_FIELDS(map)
+		__field(bool,			has_buf)
+		__field(uint64_t,		validity_cookie)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	pos;
+		__entry->length		=	count;
+
+		__entry->mapdev		=	FUSE_IOMAP_DEV_NULL;
+		__entry->mapaddr	=	map->addr;
+		__entry->mapoffset	=	map->offset;
+		__entry->maplength	=	map->length;
+		__entry->maptype	=	map->type;
+		__entry->mapflags	=	map->flags;
+
+		__entry->has_buf	=	map->inline_data != NULL;
+		__entry->validity_cookie=	map->validity_cookie;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() FUSE_IOMAP_MAP_FMT() " has_buf? %d cookie 0x%llx",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  FUSE_IOMAP_MAP_PRINTK_ARGS(map),
+		  __entry->has_buf,
+		  __entry->validity_cookie)
+);
+#define DEFINE_FUSE_IOMAP_INLINE_EVENT(name)	\
+DEFINE_EVENT(fuse_iomap_inline_class, name,	\
+	TP_PROTO(const struct inode *inode, loff_t pos, uint64_t count, \
+		 const struct iomap *map), \
+	TP_ARGS(inode, pos, count, map))
+DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_inline_read);
+DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_inline_write);
+DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_iomap);
+DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_srcmap);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 8faf16f58df035..a71de4ea5eb32d 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -452,6 +452,8 @@ static int fuse_iomap_inline_read(struct inode *inode, loff_t pos,
 	if (BAD_DATA(!iomap_inline_data_valid(iomap)))
 		return -EFSCORRUPTED;
 
+	trace_fuse_iomap_inline_read(inode, pos, count, iomap);
+
 	args.opcode = FUSE_READ;
 	args.nodeid = fi->nodeid;
 	args.in_numargs = 1;
@@ -497,6 +499,8 @@ static int fuse_iomap_inline_write(struct inode *inode, loff_t pos,
 	if (BAD_DATA(!iomap_inline_data_valid(iomap)))
 		return -EFSCORRUPTED;
 
+	trace_fuse_iomap_inline_write(inode, pos, count, iomap);
+
 	args.opcode = FUSE_WRITE;
 	args.nodeid = fi->nodeid;
 	args.in_numargs = 2;
@@ -558,6 +562,9 @@ static int fuse_iomap_set_inline(struct inode *inode, unsigned opflags,
 			return err;
 	}
 
+	trace_fuse_iomap_set_inline_iomap(inode, pos, count, iomap);
+	trace_fuse_iomap_set_inline_srcmap(inode, pos, count, srcmap);
+
 	return 0;
 }
 


