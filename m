Return-Path: <linux-fsdevel+bounces-61555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4DCB589DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EBC47A9CF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB6F1D31B9;
	Tue, 16 Sep 2025 00:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGEar31s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C85E1C4609;
	Tue, 16 Sep 2025 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983229; cv=none; b=TGTuN93j4g0VkS+kBJ3KMRkP52MyZGDEb5iwIQ5f0iUrWA9BiEB0rY0mB7GL4TJ8cWkIq6gcDIYPSg0badk/ka8q2yktiadcLqb81WYGgnlPzBNUNbFiwt7yVgsda2bCJscwbiaW0egnxDX0zn762fu1l2IOAtffAGbBBKZuHn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983229; c=relaxed/simple;
	bh=G9AOLj8udgTmkzjCjjGx0QpoCYQEj6wE8WxvS1P6Wik=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sRZEwfbEXXpwDf4Y6QfHdjApMGM/TXcj/CDG/CNddvkGqyfSSA7D08bIZy09ul6QxqHY6j8FZJqy7wKmwQSYEUh4VYd35dE+mnpFBmd8QQgFGD6NhLb7TLTO9k0nqS1i16SQ13jLsS48/S63Lw+tYfMFyC/LZ19+Zghzq+/DwLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGEar31s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA5CC4CEF5;
	Tue, 16 Sep 2025 00:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983229;
	bh=G9AOLj8udgTmkzjCjjGx0QpoCYQEj6wE8WxvS1P6Wik=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=fGEar31sQeTpgxzi2rpmptAjUibTlWLwow3EZjVDRhn9SR6jPLFp3cf7mMdR6N3cH
	 qOS94B+H+odY5Fvgm1bCsNF7Cmxnl6tE1roBdg5uRrQDYzrJSjCdWZ8Hy+PWPBm1nH
	 +Lo4fj9MIMLNdQwKulzc4cYKU2hD+LWP0j2rq5G8zAyyL0eOiDB5ZMbRu3611Bgtrk
	 6ERUVPEPumsnltdRoO0CMAGgQx85lc98iQM1pg6RHf6HkiEr2uSdJm1xBBOPYk3pQK
	 xlej3FhcLc21dGpbrCRc6pGmLPk5v8YFGNq4y8c59UnpTdPk47Oc6mxpTnOQGuwW/O
	 F9IuTC2LhVsow==
Date: Mon, 15 Sep 2025 17:40:29 -0700
Subject: [PATCH 08/10] fuse_trace: enable iomap cache management
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798153098.384360.7747887764829060757.stgit@frogsfrogsfrogs>
In-Reply-To: <175798152863.384360.10608991871408828112.stgit@frogsfrogsfrogs>
References: <175798152863.384360.10608991871408828112.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file_iomap.c |    7 ++++-
 2 files changed, 74 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 1cfcc64de08817..202fc32f6b02e1 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -401,6 +401,7 @@ struct fuse_iomap_lookup;
 #define FUSE_IOMAP_TYPE_STRINGS \
 	{ FUSE_IOMAP_TYPE_PURE_OVERWRITE,	"overwrite" }, \
 	{ FUSE_IOMAP_TYPE_RETRY_CACHE,		"retry" }, \
+	{ FUSE_IOMAP_TYPE_NOCACHE,		"nocache" }, \
 	{ FUSE_IOMAP_TYPE_HOLE,			"hole" }, \
 	{ FUSE_IOMAP_TYPE_DELALLOC,		"delalloc" }, \
 	{ FUSE_IOMAP_TYPE_MAPPED,		"mapped" }, \
@@ -742,6 +743,7 @@ DEFINE_EVENT(fuse_inode_state_class, name,	\
 	TP_ARGS(inode))
 DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_init_inode);
 DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_evict_inode);
+DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_cache_enable);
 
 TRACE_EVENT(fuse_iomap_fiemap,
 	TP_PROTO(const struct inode *inode, u64 start, u64 count,
@@ -1542,6 +1544,72 @@ TRACE_EVENT(fuse_iomap_invalid,
 		  __entry->old_validity_cookie,
 		  __entry->validity_cookie)
 );
+
+TRACE_EVENT(fuse_iomap_upsert,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_iomap_upsert_out *outarg),
+	TP_ARGS(inode, outarg),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(uint64_t,		attr_ino)
+
+		FUSE_IOMAP_MAP_FIELDS(read)
+		FUSE_IOMAP_MAP_FIELDS(write)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->attr_ino	=	outarg->attr_ino;
+		__entry->readoffset	=	outarg->read.offset;
+		__entry->readlength	=	outarg->read.length;
+		__entry->readaddr	=	outarg->read.addr;
+		__entry->readtype	=	outarg->read.type;
+		__entry->readflags	=	outarg->read.flags;
+		__entry->readdev	=	outarg->read.dev;
+		__entry->writeoffset	=	outarg->write.offset;
+		__entry->writelength	=	outarg->write.length;
+		__entry->writeaddr	=	outarg->write.addr;
+		__entry->writetype	=	outarg->write.type;
+		__entry->writeflags	=	outarg->write.flags;
+		__entry->writedev	=	outarg->write.dev;
+	),
+
+	TP_printk(FUSE_INODE_FMT " attr_ino 0x%llx" FUSE_IOMAP_MAP_FMT("read") FUSE_IOMAP_MAP_FMT("write"),
+		  FUSE_INODE_PRINTK_ARGS,
+		  __entry->attr_ino,
+		  FUSE_IOMAP_MAP_PRINTK_ARGS(read),
+		  FUSE_IOMAP_MAP_PRINTK_ARGS(write))
+);
+
+TRACE_EVENT(fuse_iomap_inval,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_iomap_inval_out *outarg),
+	TP_ARGS(inode, outarg),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(uint64_t,		attr_ino)
+
+		FUSE_FILE_RANGE_FIELDS(read)
+		FUSE_FILE_RANGE_FIELDS(write)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->attr_ino	=	outarg->attr_ino;
+		__entry->readoffset	=	outarg->read_offset;
+		__entry->readlength	=	outarg->read_length;
+		__entry->writeoffset	=	outarg->write_offset;
+		__entry->writelength	=	outarg->write_length;
+	),
+
+	TP_printk(FUSE_INODE_FMT " attr_ino 0x%llx" FUSE_FILE_RANGE_FMT("read") FUSE_FILE_RANGE_FMT("write"),
+		  FUSE_INODE_PRINTK_ARGS,
+		  __entry->attr_ino,
+		  FUSE_FILE_RANGE_PRINTK_ARGS(read),
+		  FUSE_FILE_RANGE_PRINTK_ARGS(write))
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index ff79a30f6ff8d2..c82434674fb52b 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -2557,6 +2557,8 @@ int fuse_iomap_upsert(struct fuse_conn *fc,
 		goto out_sb;
 	}
 
+	trace_fuse_iomap_upsert(inode, outarg);
+
 	fi = get_fuse_inode(inode);
 	if (BAD_DATA(fi->orig_ino != outarg->attr_ino)) {
 		ret = -EINVAL;
@@ -2574,7 +2576,8 @@ int fuse_iomap_upsert(struct fuse_conn *fc,
 
 	fuse_iomap_cache_lock(inode);
 
-	set_bit(FUSE_I_IOMAP_CACHE, &fi->state);
+	if (!test_and_set_bit(FUSE_I_IOMAP_CACHE, &fi->state))
+		trace_fuse_iomap_cache_enable(inode);
 
 	if (outarg->read.type != FUSE_IOMAP_TYPE_NOCACHE) {
 		ret = fuse_iomap_cache_upsert(inode, READ_MAPPING,
@@ -2638,6 +2641,8 @@ int fuse_iomap_inval(struct fuse_conn *fc,
 		goto out_sb;
 	}
 
+	trace_fuse_iomap_inval(inode, outarg);
+
 	fi = get_fuse_inode(inode);
 	if (BAD_DATA(fi->orig_ino != outarg->attr_ino)) {
 		ret = -EINVAL;


