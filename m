Return-Path: <linux-fsdevel+bounces-78094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCNyO8rhnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:24:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9963D17F519
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCF3330FE621
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6104137F74B;
	Mon, 23 Feb 2026 23:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBVXCm0l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9AB37F73D;
	Mon, 23 Feb 2026 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888857; cv=none; b=e3i8/CuOtn1OIL2tdREVYsWaWEltW+clTl1evqr+ba+WeOMnBtCuhxXu/cFvumO5WzEBe0lUkhRQszUAtBOISMAAtFvY/wnGpAA1Z+3eSQcDtvOn8Az085lLpRCHe/WSbqzV9XvqJRVsEgaDBgrlpZF9etERVV5piDEbOyzDJ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888857; c=relaxed/simple;
	bh=MJeJF1oGs1H/c7/y66rWX+Y3/hVn9utTkLZawEdxK8o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iN0YBnRQ1GYFZjp2PIb1ZN7fcwEZvplE+mM9G+C5oVmcq/37FrL23PKvR8B3SzX6R87MqOQC6L2GFboiWrsTDrSN+ryFqz4PQcZFF/7X7Mj9EceMTYNMkDpcLQpmA5M9Rp+4hxuzjhTCnnLQKgOHHtxEPn3mN5EbVMtwLEgGJc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBVXCm0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EF4C116C6;
	Mon, 23 Feb 2026 23:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888856;
	bh=MJeJF1oGs1H/c7/y66rWX+Y3/hVn9utTkLZawEdxK8o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=dBVXCm0lAwlKcBqB/DaBZrUI0Ixa5iZLM5Ur0ctSwJQO8Aezo3zuvsS7ngfrjGEe8
	 jRQ5JTsVLz3dseul2g+2iUJWw3e3Ft5VQLAiRq+gZvqFj41tJ69EZ7EcNa5b7lifhR
	 9vCqqC+5jiBpVKAe0wA/w5rG121rpxKJ9tjoqf4tK8f5PLPHzDMorjkK80pi2qIr9B
	 DKMRfjRwZiRvlq6BwU3/sEoDTNz0ygM6IZYil0+nVPHO5zfalU+5CnsES0eTVij6QK
	 HKexCA8gszpN2BbByKjo3NODIZ5MLsbGpScwJM54Kwp704zgxFq+82/dJnLtxVdZ+X
	 jMuzSCd5m9Nyg==
Date: Mon, 23 Feb 2026 15:20:56 -0800
Subject: [PATCH 02/12] fuse_trace: cache iomaps
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188736069.3937557.445129366457829311.stgit@frogsfrogsfrogs>
In-Reply-To: <177188735954.3937557.841478048197856035.stgit@frogsfrogsfrogs>
References: <177188735954.3937557.841478048197856035.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78094-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9963D17F519
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h       |  293 ++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_iomap_cache.c |   36 +++++
 2 files changed, 329 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index a6374d64a62357..697289c82d0dad 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -318,6 +318,8 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 struct iomap_writepage_ctx;
 struct iomap_ioend;
 struct iomap;
+struct fuse_iext_cursor;
+struct fuse_iomap_lookup;
 
 /* tracepoint boilerplate so we don't have to keep doing this */
 #define FUSE_IOMAP_OPFLAGS_FIELD \
@@ -348,6 +350,16 @@ struct iomap;
 		__entry->prefix##addr, \
 		__print_flags(__entry->prefix##flags, "|", FUSE_IOMAP_F_STRINGS)
 
+#define FUSE_IOMAP_IODIR_FIELD \
+		__field(unsigned int,	iodir)
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
@@ -445,6 +457,22 @@ TRACE_DEFINE_ENUM(FUSE_I_ATOMIC);
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
 
@@ -727,6 +755,8 @@ DEFINE_EVENT(fuse_inode_state_class, name,	\
 	TP_ARGS(inode))
 DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_init_inode);
 DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_evict_inode);
+DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_cache_alloc);
+DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_cache_free);
 
 TRACE_EVENT(fuse_iomap_fiemap,
 	TP_PROTO(const struct inode *inode, u64 start, u64 count,
@@ -1216,6 +1246,269 @@ DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_inline_read);
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
+		const struct fuse_iext_root *ir;
+		struct fuse_iomap_io r = { };
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+
+		if (state & FUSE_IEXT_WRITE_MAPPING)
+			ir = &fi->cache->ic_write;
+		else
+			ir = &fi->cache->ic_read;
+		if (ir)
+			fuse_iext_get_extent(ir, cur, &r);
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
+	TP_PROTO(const struct inode *inode, unsigned int iodir,
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
+	TP_PROTO(const struct inode *inode, unsigned int iodir,
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
+	TP_PROTO(const struct inode *inode, unsigned int iodir, \
+		 const struct fuse_iomap_io *map, unsigned long caller_ip), \
+	TP_ARGS(inode, iodir, map, caller_ip))
+DEFINE_FUSE_IOMAP_CACHED_MAPPING_EVENT(fuse_iomap_cache_add);
+DEFINE_FUSE_IOMAP_CACHED_MAPPING_EVENT(fuse_iext_check_mapping);
+
+TRACE_EVENT(fuse_iomap_cache_lookup,
+	TP_PROTO(const struct inode *inode, unsigned int iodir,
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
+	TP_PROTO(const struct inode *inode, unsigned int iodir,
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
diff --git a/fs/fuse/fuse_iomap_cache.c b/fs/fuse/fuse_iomap_cache.c
index e32de8a5e3c325..a047d7bf95257a 100644
--- a/fs/fuse/fuse_iomap_cache.c
+++ b/fs/fuse/fuse_iomap_cache.c
@@ -763,6 +763,7 @@ fuse_iext_insert(
 	struct fuse_iext_root		*ir = fuse_iext_state_to_fork(ic, state);
 
 	fuse_iext_insert_raw(ic, ir, cur, irec);
+	trace_fuse_iext_insert(ic->ic_inode, cur, state, _RET_IP_);
 }
 
 static struct fuse_iext_node *
@@ -970,6 +971,8 @@ fuse_iext_remove(
 	ASSERT(ir->ir_data != NULL);
 	ASSERT(fuse_iext_valid(ir, cur));
 
+	trace_fuse_iext_remove(ic->ic_inode, cur, state, _RET_IP_);
+
 	fuse_iext_inc_seq(ic);
 
 	nr_entries = fuse_iext_leaf_nr_entries(ir, leaf, cur->pos) - 1;
@@ -1088,7 +1091,9 @@ fuse_iext_update_extent(
 		}
 	}
 
+	trace_fuse_iext_pre_update(ic->ic_inode, cur, state, _RET_IP_);
 	fuse_iext_set(cur_rec(cur), new);
+	trace_fuse_iext_post_update(ic->ic_inode, cur, state, _RET_IP_);
 }
 
 /*
@@ -1180,17 +1185,26 @@ static void fuse_iext_check_mappings(struct fuse_iomap_cache *ic,
 	struct inode		*inode = ic->ic_inode;
 	struct fuse_inode	*fi = get_fuse_inode(inode);
 	unsigned long long	nr = 0;
+	enum fuse_iomap_iodir	iodir;
 
 	if (ir->ir_bytes < 0 || !static_branch_unlikely(&fuse_iomap_debug))
 		return;
 
+	if (ir == &ic->ic_write)
+		iodir = WRITE_MAPPING;
+	else
+		iodir = READ_MAPPING;
+
 	fuse_iext_first(ir, &icur);
 	if (!fuse_iext_get_extent(ir, &icur, &prev))
 		return;
+	trace_fuse_iext_check_mapping(ic->ic_inode, iodir, &prev, _RET_IP_);
 	nr++;
 
 	fuse_iext_next(ir, &icur);
 	while (fuse_iext_get_extent(ir, &icur, &got)) {
+		trace_fuse_iext_check_mapping(ic->ic_inode, iodir, &got,
+					      _RET_IP_);
 		if (got.length == 0 ||
 		    got.offset < prev.offset + prev.length ||
 		    fuse_iomap_can_merge(&prev, &got)) {
@@ -1249,6 +1263,9 @@ fuse_iext_del_mapping(
 	if (got_endoff == del_endoff)
 		state |= FUSE_IEXT_RIGHT_FILLING;
 
+	trace_fuse_iext_del_mapping(ic->ic_inode, state, del);
+	trace_fuse_iext_del_mapping_got(ic->ic_inode, got);
+
 	switch (state & (FUSE_IEXT_LEFT_FILLING | FUSE_IEXT_RIGHT_FILLING)) {
 	case FUSE_IEXT_LEFT_FILLING | FUSE_IEXT_RIGHT_FILLING:
 		/*
@@ -1313,6 +1330,8 @@ fuse_iomap_cache_remove(
 
 	assert_cache_locked(ic);
 
+	trace_fuse_iomap_cache_remove(&fi->inode, iodir, start, len, _RET_IP_);
+
 	/* Fork is not active or has zero mappings */
 	if (ir->ir_bytes < 0 || fuse_iext_count(ir) == 0)
 		return 0;
@@ -1458,6 +1477,12 @@ fuse_iext_add_mapping(
 	     fuse_iomap_can_merge3(&left, new, &right)))
 		state |= FUSE_IEXT_RIGHT_CONTIG;
 
+	trace_fuse_iext_add_mapping(ic->ic_inode, state, new);
+	if (state & FUSE_IEXT_LEFT_VALID)
+		trace_fuse_iext_add_mapping_left(ic->ic_inode, &left);
+	if (state & FUSE_IEXT_RIGHT_VALID)
+		trace_fuse_iext_add_mapping_right(ic->ic_inode, &right);
+
 	/*
 	 * Select which case we're in here, and implement it.
 	 */
@@ -1526,6 +1551,8 @@ fuse_iomap_cache_add(
 	ASSERT(new->length > 0);
 	ASSERT(new->offset < inode->i_sb->s_maxbytes);
 
+	trace_fuse_iomap_cache_add(&fi->inode, iodir, new, _RET_IP_);
+
 	/* Mark this fork as being in use */
 	if (ir->ir_bytes < 0)
 		ir->ir_bytes = 0;
@@ -1563,8 +1590,10 @@ int fuse_iomap_cache_alloc(struct inode *inode)
 	if (!try_cmpxchg(&fi->cache, &old, ic)) {
 		/* Someone created mapping cache before us? Free ours... */
 		kfree(ic);
+		return 0;
 	}
 
+	trace_fuse_iomap_cache_alloc(inode);
 	return 0;
 }
 
@@ -1579,6 +1608,8 @@ void fuse_iomap_cache_free(struct inode *inode)
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_iomap_cache *ic = fi->cache;
 
+	trace_fuse_iomap_cache_free(inode);
+
 	/*
 	 * This is only called from eviction, so we cannot be racing to set or
 	 * clear the pointer.
@@ -1671,6 +1702,8 @@ fuse_iomap_cache_lookup(
 
 	assert_cache_locked_shared(ic);
 
+	trace_fuse_iomap_cache_lookup(ic->ic_inode, iodir, off, len, _RET_IP_);
+
 	if (ir->ir_bytes < 0) {
 		/*
 		 * No write fork at all means this filesystem doesn't do out of
@@ -1697,5 +1730,8 @@ fuse_iomap_cache_lookup(
 
 	/* Found a mapping in the cache, return it */
 	fuse_iomap_trim(fi, mval, &got, off, len);
+
+	trace_fuse_iomap_cache_lookup_result(inode, iodir, off, len, &got,
+					     mval);
 	return LOOKUP_HIT;
 }


