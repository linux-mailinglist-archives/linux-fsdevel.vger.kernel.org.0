Return-Path: <linux-fsdevel+bounces-61549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DC4B589CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0312A3FB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95C21DD0EF;
	Tue, 16 Sep 2025 00:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUWFnh25"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2757C1D9A5F;
	Tue, 16 Sep 2025 00:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983136; cv=none; b=oWcwumiyTVw1OIgMpeKG93CseZhzMgTgio+D4K+H35jtoNU2rsxdb5MDl2B4aX5fqIKXWRYnnyAmziFxZbAhN2hepQtg+Kq5cqQ7wfwjubymF7ow+cK32wCroIEy8Q5QwzWJXR2P7vVmFgS8jV+njDGTMUVAB6H1JSpFnntMWgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983136; c=relaxed/simple;
	bh=xUJD270nzIYv0dOlBjytQCmKLH1tJliFmpFZVkuxz2k=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ypt1ivKWTkCNZhcDmuJfOAxeUZ3zIbd9gBnVBMM9sh/zrOlNI87OZULMiBmXMkoIzXUdYejrd3hUEWEOHhXAOxVMEl++dcuH/Y+XeOWMsTTuto8D73Ia5SOAn3gLpPxITIFhXG5cv/MOVBH8jvAx7hkQCHuxATOhDi8v8ClcjMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUWFnh25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF201C4CEF1;
	Tue, 16 Sep 2025 00:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983135;
	bh=xUJD270nzIYv0dOlBjytQCmKLH1tJliFmpFZVkuxz2k=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=NUWFnh25KnzxTbsfez0OlakEy0wR7Capct3QLtoKtftgwZ+M8qISOygITcgcjOjKZ
	 fI2FA/SXTcZQ0geKmr3wT23uX0IwUoN7ApB48bXDOBJD5zmGba9PeIfKKpRRlvXL3o
	 H2kE28bZx/Ec60gYAThw9cNiZdG6u0VglkhWfe2M4C6b68qzG9Qm8kdTLLfYxnkUDb
	 XZ7UaVLYXF5/O9MLoLp7ghnYJuVq0kkRw2azKWBv5n6sMtoVP2nA8zn5Cag3U9q217
	 Pd9xgGGEZIWqozev52QskbIyeu84VzPdstlGNs3lUaZWAk8l7zLG9OxszmUIdJpgig
	 XMy0ydWo+FqTA==
Date: Mon, 15 Sep 2025 17:38:55 -0700
Subject: [PATCH 02/10] fuse_trace: cache iomaps
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798152968.384360.12009438961131115186.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h  |  295 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/iomap_cache.c |   31 +++++
 2 files changed, 325 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 1f900580b14937..6072ef187f9215 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -315,6 +315,8 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 struct iomap_writepage_ctx;
 struct iomap_ioend;
 struct iomap;
+struct fuse_iext_cursor;
+struct fuse_iomap_lookup;
 
 /* tracepoint boilerplate so we don't have to keep doing this */
 #define FUSE_IOMAP_OPFLAGS_FIELD \
@@ -345,6 +347,16 @@ struct iomap;
 		__entry->prefix##addr, \
 		__print_flags(__entry->prefix##flags, "|", FUSE_IOMAP_F_STRINGS)
 
+#define FUSE_IOMAP_IODIR_FIELD \
+		__field(enum fuse_iomap_iodir,	iodir)
+
+#define FUSE_IOMAP_IODIR_FMT \
+		 " iodir %s"
+
+#define FUSE_IOMAP_IODIR_PRINTK_ARGS \
+		  __print_symbolic(__entry->iodir, FUSE_IOMAP_FORK_STRINGS)
+
+
 /* combinations of boilerplate to reduce typing further */
 #define FUSE_IOMAP_OP_FIELDS(prefix) \
 		FUSE_INODE_FIELDS \
@@ -414,6 +426,7 @@ TRACE_DEFINE_ENUM(FUSE_I_BTIME);
 TRACE_DEFINE_ENUM(FUSE_I_CACHE_IO_MODE);
 TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
 TRACE_DEFINE_ENUM(FUSE_I_ATOMIC);
+TRACE_DEFINE_ENUM(FUSE_I_IOMAP_CACHE);
 
 #define FUSE_IFLAG_STRINGS \
 	{ 1 << FUSE_I_ADVISE_RDPLUS,		"advise_rdplus" }, \
@@ -423,7 +436,8 @@ TRACE_DEFINE_ENUM(FUSE_I_ATOMIC);
 	{ 1 << FUSE_I_BTIME,			"btime" }, \
 	{ 1 << FUSE_I_CACHE_IO_MODE,		"cacheio" }, \
 	{ 1 << FUSE_I_IOMAP,			"iomap" }, \
-	{ 1 << FUSE_I_ATOMIC,			"atomic" }
+	{ 1 << FUSE_I_ATOMIC,			"atomic" }, \
+	{ 1 << FUSE_I_IOMAP_CACHE,		"iomap_cache" }
 
 #define IOMAP_IOEND_STRINGS \
 	{ IOMAP_IOEND_SHARED,			"shared" }, \
@@ -439,6 +453,22 @@ TRACE_DEFINE_ENUM(FUSE_I_ATOMIC);
 	{ FUSE_IOMAP_CONFIG_TIME,		"time" }, \
 	{ FUSE_IOMAP_CONFIG_MAXBYTES,		"maxbytes" }
 
+TRACE_DEFINE_ENUM(READ_MAPPING);
+TRACE_DEFINE_ENUM(WRITE_MAPPING);
+
+#define FUSE_IOMAP_FORK_STRINGS \
+	{ READ_MAPPING,				"read" }, \
+	{ WRITE_MAPPING,			"write" }
+
+#define FUSE_IEXT_STATE_STRINGS \
+	{ FUSE_IEXT_LEFT_CONTIG,		"l_cont" }, \
+	{ FUSE_IEXT_RIGHT_CONTIG,		"r_cont" }, \
+	{ FUSE_IEXT_LEFT_FILLING,		"l_fill" }, \
+	{ FUSE_IEXT_RIGHT_FILLING,		"r_fill" }, \
+	{ FUSE_IEXT_LEFT_VALID,			"l_valid" }, \
+	{ FUSE_IEXT_RIGHT_VALID,		"r_valid" }, \
+	{ FUSE_IEXT_WRITE_MAPPING,		"write" }
+
 DECLARE_EVENT_CLASS(fuse_iomap_check_class,
 	TP_PROTO(const char *func, int line, const char *condition),
 
@@ -1178,6 +1208,269 @@ DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_inline_read);
 DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_inline_write);
 DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_iomap);
 DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_srcmap);
+
+DECLARE_EVENT_CLASS(fuse_iext_class,
+	TP_PROTO(const struct inode *inode, const struct fuse_iext_cursor *cur,
+		 int state, unsigned long caller_ip),
+
+	TP_ARGS(inode, cur, state, caller_ip),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		FUSE_IOMAP_MAP_FIELDS(map)
+		__field(void *,			leaf)
+		__field(int,			pos)
+		__field(int,			iext_state)
+		__field(unsigned long,		caller_ip)
+	),
+	TP_fast_assign(
+		const struct fuse_ifork *ifp;
+		struct fuse_iomap_io r = { };
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+
+		if (state & FUSE_IEXT_WRITE_MAPPING)
+			ifp = fi->cache.im_write;
+		else
+			ifp = &fi->cache.im_read;
+		if (ifp)
+			fuse_iext_get_extent(ifp, cur, &r);
+
+		__entry->mapoffset	=	r.offset;
+		__entry->mapaddr	=	r.addr;
+		__entry->maplength	=	r.length;
+		__entry->mapdev		=	r.dev;
+		__entry->maptype	=	r.type;
+		__entry->mapflags	=	r.flags;
+
+		__entry->leaf		=	cur->leaf;
+		__entry->pos		=	cur->pos;
+
+		__entry->iext_state	=	state;
+		__entry->caller_ip	=	caller_ip;
+	),
+	TP_printk(FUSE_INODE_FMT " state (%s) cur %p/%d " FUSE_IOMAP_MAP_FMT() " caller %pS",
+		  FUSE_INODE_PRINTK_ARGS,
+		  __print_flags(__entry->iext_state, "|", FUSE_IEXT_STATE_STRINGS),
+		  __entry->leaf,
+		  __entry->pos,
+		  FUSE_IOMAP_MAP_PRINTK_ARGS(map),
+		  (void *)__entry->caller_ip)
+)
+
+#define DEFINE_IEXT_EVENT(name) \
+DEFINE_EVENT(fuse_iext_class, name, \
+	TP_PROTO(const struct inode *inode, const struct fuse_iext_cursor *cur, \
+		 int state, unsigned long caller_ip), \
+	TP_ARGS(inode, cur, state, caller_ip))
+DEFINE_IEXT_EVENT(fuse_iext_insert);
+DEFINE_IEXT_EVENT(fuse_iext_remove);
+DEFINE_IEXT_EVENT(fuse_iext_pre_update);
+DEFINE_IEXT_EVENT(fuse_iext_post_update);
+
+TRACE_EVENT(fuse_iext_update_class,
+	TP_PROTO(const struct inode *inode, uint32_t iext_state,
+		 const struct fuse_iomap_io *map),
+	TP_ARGS(inode, iext_state, map),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		FUSE_IOMAP_MAP_FIELDS(map)
+		__field(uint32_t,		iext_state)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->mapoffset	=	map->offset;
+		__entry->maplength	=	map->length;
+		__entry->maptype	=	map->type;
+		__entry->mapflags	=	map->flags;
+		__entry->mapdev		=	map->dev;
+		__entry->mapaddr	=	map->addr;
+
+		__entry->iext_state	=	iext_state;
+	),
+
+	TP_printk(FUSE_INODE_FMT " state (%s)" FUSE_IOMAP_MAP_FMT(),
+		  FUSE_INODE_PRINTK_ARGS,
+		  __print_flags(__entry->iext_state, "|", FUSE_IEXT_STATE_STRINGS),
+		  FUSE_IOMAP_MAP_PRINTK_ARGS(map))
+);
+#define DEFINE_IEXT_UPDATE_EVENT(name) \
+DEFINE_EVENT(fuse_iext_update_class, name, \
+	TP_PROTO(const struct inode *inode, uint32_t iext_state, \
+		 const struct fuse_iomap_io *map), \
+	TP_ARGS(inode, iext_state, map))
+DEFINE_IEXT_UPDATE_EVENT(fuse_iext_del_mapping);
+DEFINE_IEXT_UPDATE_EVENT(fuse_iext_add_mapping);
+
+TRACE_EVENT(fuse_iext_alt_update_class,
+	TP_PROTO(const struct inode *inode, const struct fuse_iomap_io *map),
+	TP_ARGS(inode, map),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		FUSE_IOMAP_MAP_FIELDS(map)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+
+		__entry->mapoffset	=	map->offset;
+		__entry->maplength	=	map->length;
+		__entry->maptype	=	map->type;
+		__entry->mapflags	=	map->flags;
+		__entry->mapdev		=	map->dev;
+		__entry->mapaddr	=	map->addr;
+	),
+
+	TP_printk(FUSE_INODE_FMT FUSE_IOMAP_MAP_FMT(),
+		  FUSE_INODE_PRINTK_ARGS,
+		  FUSE_IOMAP_MAP_PRINTK_ARGS(map))
+);
+#define DEFINE_IEXT_ALT_UPDATE_EVENT(name) \
+DEFINE_EVENT(fuse_iext_alt_update_class, name, \
+	TP_PROTO(const struct inode *inode, const struct fuse_iomap_io *map), \
+	TP_ARGS(inode, map))
+DEFINE_IEXT_ALT_UPDATE_EVENT(fuse_iext_del_mapping_got);
+DEFINE_IEXT_ALT_UPDATE_EVENT(fuse_iext_add_mapping_left);
+DEFINE_IEXT_ALT_UPDATE_EVENT(fuse_iext_add_mapping_right);
+
+TRACE_EVENT(fuse_iomap_cache_remove,
+	TP_PROTO(const struct inode *inode, enum fuse_iomap_iodir iodir,
+		 loff_t offset, uint64_t length, unsigned long caller_ip),
+	TP_ARGS(inode, iodir, offset, length, caller_ip),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		FUSE_IOMAP_IODIR_FIELD
+		__field(unsigned long,		caller_ip)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->iodir		=	iodir;
+		__entry->offset		=	offset;
+		__entry->length		=	length;
+		__entry->caller_ip	=	caller_ip;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() FUSE_IOMAP_IODIR_FMT " caller %pS",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  FUSE_IOMAP_IODIR_PRINTK_ARGS,
+		  (void *)__entry->caller_ip)
+);
+
+TRACE_EVENT(fuse_iomap_cached_mapping_class,
+	TP_PROTO(const struct inode *inode, enum fuse_iomap_iodir iodir,
+		 const struct fuse_iomap_io *map, unsigned long caller_ip),
+	TP_ARGS(inode, iodir, map, caller_ip),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		FUSE_IOMAP_IODIR_FIELD
+		FUSE_IOMAP_MAP_FIELDS(map)
+		__field(unsigned long,		caller_ip)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->iodir		=	iodir;
+
+		__entry->mapoffset	=	map->offset;
+		__entry->maplength	=	map->length;
+		__entry->maptype	=	map->type;
+		__entry->mapflags	=	map->flags;
+		__entry->mapdev		=	map->dev;
+		__entry->mapaddr	=	map->addr;
+
+		__entry->caller_ip	=	caller_ip;
+	),
+
+	TP_printk(FUSE_INODE_FMT FUSE_IOMAP_IODIR_FMT FUSE_IOMAP_MAP_FMT() " caller %pS",
+		  FUSE_INODE_PRINTK_ARGS,
+		  FUSE_IOMAP_IODIR_PRINTK_ARGS,
+		  FUSE_IOMAP_MAP_PRINTK_ARGS(map),
+		  (void *)__entry->caller_ip)
+);
+#define DEFINE_FUSE_IOMAP_CACHED_MAPPING_EVENT(name) \
+DEFINE_EVENT(fuse_iomap_cached_mapping_class, name, \
+	TP_PROTO(const struct inode *inode, enum fuse_iomap_iodir iodir, \
+		 const struct fuse_iomap_io *map, unsigned long caller_ip), \
+	TP_ARGS(inode, iodir, map, caller_ip))
+DEFINE_FUSE_IOMAP_CACHED_MAPPING_EVENT(fuse_iomap_cache_add);
+DEFINE_FUSE_IOMAP_CACHED_MAPPING_EVENT(fuse_iext_check_mapping);
+
+TRACE_EVENT(fuse_iomap_cache_lookup,
+	TP_PROTO(const struct inode *inode, enum fuse_iomap_iodir iodir,
+		 loff_t pos, uint64_t count, unsigned long caller_ip),
+	TP_ARGS(inode, iodir, pos, count, caller_ip),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		FUSE_IOMAP_IODIR_FIELD
+		__field(unsigned long,		caller_ip)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->iodir		=	iodir;
+		__entry->offset		=	pos;
+		__entry->length		=	count;
+		__entry->caller_ip	=	caller_ip;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() FUSE_IOMAP_IODIR_FMT " caller %pS",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  FUSE_IOMAP_IODIR_PRINTK_ARGS,
+		  (void *)__entry->caller_ip)
+);
+
+TRACE_EVENT(fuse_iomap_cache_lookup_result,
+	TP_PROTO(const struct inode *inode, enum fuse_iomap_iodir iodir,
+		 loff_t pos, uint64_t count, const struct fuse_iomap_io *got,
+		 const struct fuse_iomap_lookup *map),
+	TP_ARGS(inode, iodir, pos, count, got, map),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+
+		FUSE_IOMAP_MAP_FIELDS(got)
+		FUSE_IOMAP_MAP_FIELDS(map)
+
+		FUSE_IOMAP_IODIR_FIELD
+		__field(uint64_t,		validity_cookie)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->iodir		=	iodir;
+		__entry->offset		=	pos;
+		__entry->length		=	count;
+
+		__entry->gotoffset	=	got->offset;
+		__entry->gotlength	=	got->length;
+		__entry->gottype	=	got->type;
+		__entry->gotflags	=	got->flags;
+		__entry->gotdev		=	got->dev;
+		__entry->gotaddr	=	got->addr;
+
+		__entry->mapoffset	=	map->map.offset;
+		__entry->maplength	=	map->map.length;
+		__entry->maptype	=	map->map.type;
+		__entry->mapflags	=	map->map.flags;
+		__entry->mapdev		=	map->map.dev;
+		__entry->mapaddr	=	map->map.addr;
+
+		__entry->validity_cookie=	map->validity_cookie;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() FUSE_IOMAP_IODIR_FMT FUSE_IOMAP_MAP_FMT("map") FUSE_IOMAP_MAP_FMT("got") " cookie 0x%llx",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  FUSE_IOMAP_IODIR_PRINTK_ARGS,
+		  FUSE_IOMAP_MAP_PRINTK_ARGS(map),
+		  FUSE_IOMAP_MAP_PRINTK_ARGS(got),
+		  __entry->validity_cookie)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/iomap_cache.c b/fs/fuse/iomap_cache.c
index 1fec9dcc6d3922..5bfa0e26346d1f 100644
--- a/fs/fuse/iomap_cache.c
+++ b/fs/fuse/iomap_cache.c
@@ -717,6 +717,7 @@ fuse_iext_insert(
 	struct fuse_ifork		*ifp = fuse_iext_state_to_fork(ip, state);
 
 	fuse_iext_insert_raw(ip, ifp, cur, irec);
+	trace_fuse_iext_insert(VFS_I(ip), cur, state, _RET_IP_);
 }
 
 static struct fuse_iext_node *
@@ -920,6 +921,8 @@ fuse_iext_remove(
 	loff_t			offset = fuse_iext_leaf_key(leaf, 0);
 	int			i, nr_entries;
 
+	trace_fuse_iext_remove(VFS_I(ip), cur, state, _RET_IP_);
+
 	ASSERT(ifp->if_height > 0);
 	ASSERT(ifp->if_data != NULL);
 	ASSERT(fuse_iext_valid(ifp, cur));
@@ -1042,7 +1045,9 @@ fuse_iext_update_extent(
 		}
 	}
 
+	trace_fuse_iext_pre_update(VFS_I(ip), cur, state, _RET_IP_);
 	fuse_iext_set(cur_rec(cur), new);
+	trace_fuse_iext_post_update(VFS_I(ip), cur, state, _RET_IP_);
 }
 
 /*
@@ -1150,17 +1155,25 @@ static void fuse_iext_check_mappings(struct inode *inode,
 	struct fuse_iext_cursor	icur;
 	struct fuse_iomap_io	prev, got;
 	unsigned long long	nr = 0;
+	enum fuse_iomap_iodir	iodir;
 
 	if (!ifp || !static_branch_unlikely(&fuse_iomap_debug))
 		return;
 
+	if (ifp == ip->im_write)
+		iodir = WRITE_MAPPING;
+	else
+		iodir = READ_MAPPING;
+
 	fuse_iext_first(ifp, &icur);
 	if (!fuse_iext_get_extent(ifp, &icur, &prev))
 		return;
+	trace_fuse_iext_check_mapping(inode, iodir, &prev, _RET_IP_);
 	nr++;
 
 	fuse_iext_next(ifp, &icur);
 	while (fuse_iext_get_extent(ifp, &icur, &got)) {
+		trace_fuse_iext_check_mapping(inode, iodir, &got, _RET_IP_);
 		if (got.length == 0 ||
 		    got.offset < prev.offset + prev.length ||
 		    fuse_iomap_can_merge(&prev, &got)) {
@@ -1219,6 +1232,9 @@ fuse_iext_del_mapping(
 	if (got_endoff == del_endoff)
 		state |= FUSE_IEXT_RIGHT_FILLING;
 
+	trace_fuse_iext_del_mapping(VFS_I(ip), state, del);
+	trace_fuse_iext_del_mapping_got(VFS_I(ip), got);
+
 	switch (state & (FUSE_IEXT_LEFT_FILLING | FUSE_IEXT_RIGHT_FILLING)) {
 	case FUSE_IEXT_LEFT_FILLING | FUSE_IEXT_RIGHT_FILLING:
 		/*
@@ -1283,6 +1299,8 @@ fuse_iomap_cache_remove(
 
 	assert_cache_locked(ip);
 
+	trace_fuse_iomap_cache_remove(inode, iodir, start, len, _RET_IP_);
+
 	if (!ifp || fuse_iext_count(ifp) == 0)
 		return 0;
 
@@ -1427,6 +1445,12 @@ fuse_iext_add_mapping(
 	     fuse_iomap_can_merge3(&left, new, &right)))
 		state |= FUSE_IEXT_RIGHT_CONTIG;
 
+	trace_fuse_iext_add_mapping(VFS_I(ip), state, new);
+	if (state & FUSE_IEXT_LEFT_VALID)
+		trace_fuse_iext_add_mapping_left(VFS_I(ip), &left);
+	if (state & FUSE_IEXT_RIGHT_VALID)
+		trace_fuse_iext_add_mapping_right(VFS_I(ip), &right);
+
 	/*
 	 * Select which case we're in here, and implement it.
 	 */
@@ -1495,6 +1519,8 @@ fuse_iomap_cache_add(
 	ASSERT(new->length > 0);
 	ASSERT(new->offset < inode->i_sb->s_maxbytes);
 
+	trace_fuse_iomap_cache_add(inode, iodir, new, _RET_IP_);
+
 	if (!ifp) {
 		ifp = kzalloc(sizeof(struct fuse_ifork),
 			      GFP_KERNEL | __GFP_NOFAIL);
@@ -1599,6 +1625,8 @@ fuse_iomap_cache_lookup(
 
 	assert_cache_locked_shared(ip);
 
+	trace_fuse_iomap_cache_lookup(inode, iodir, off, len, _RET_IP_);
+
 	if (!ifp) {
 		/*
 		 * No write fork at all means this filesystem doesn't do out of
@@ -1625,5 +1653,8 @@ fuse_iomap_cache_lookup(
 
 	/* Found a mapping in the cache, return it */
 	fuse_iomap_trim(fi, mval, &got, off, len);
+
+	trace_fuse_iomap_cache_lookup_result(inode, iodir, off, len, &got,
+					     mval);
 	return LOOKUP_HIT;
 }


