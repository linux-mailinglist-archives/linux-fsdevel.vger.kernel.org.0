Return-Path: <linux-fsdevel+bounces-58466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5982CB2E9DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2621CC3383
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBFF1E98E6;
	Thu, 21 Aug 2025 00:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIF5k51W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4991C3BF7
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737942; cv=none; b=KI+0jx2lTmMdIWhwxIrZCAnxy7XuDIv7c2pr4ThYSs5fjnnH+BwghWLjYZVRehjyKlTuQtn4nKsE/sAkyPWXHk8Nei+SOha8d/Ckd2lpChtgc85zBXMYJOH93oYVBdSMoJ9x8MZAtViBrBgALoSCB3kPHcgZ2qHGWV52Zlwo0AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737942; c=relaxed/simple;
	bh=U+wjoe82RiQIAibAy8/K3n8kLov04oVTpxtqIogJuFQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbJPxtZir2xKwLxE4u8c713zAX5lxJgrWSNPobOYKU7eZy3CoIjlAx9e7mtCM58q0B1ESTEQoDBbmLj0Ap1XQrbgagoEZ90jcbUH66SEECCJIWiq0CwTKQd5Lz87Kh0r+lg1whrJl5CVNk76C7BKsaxhhMNMbi4AI6kk7GfBNI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIF5k51W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B99C4CEE7;
	Thu, 21 Aug 2025 00:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737941;
	bh=U+wjoe82RiQIAibAy8/K3n8kLov04oVTpxtqIogJuFQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=nIF5k51WdkIRNV4/KpQOniZoowfx+D68FXrXnStGWLLnqGAFyLFF21g7+Ec3lxK0/
	 5/dx55UJ6t1loYK8Eui5e3N2fjagt5ZysYsFIWBYLfKZPeBVvV0DmcjNWmHveFHrZ4
	 V6EfAHjGALaJ6XFjaDGqWUzRW6C0YP7fd+VKoF0clfqWzgbO+nd7K2bezHLfaFjbYe
	 B5VuPJRpi0Lms2cG+e1qNSqXhsDmGde57vht3TEJ9HOYnDO8wkv3EGwDRNw/rUwPPn
	 F+QZz75OkJRIfEP3SS2juTNuYgEXtDfGuVXccOBSPKflWWYCX4fp2M/AWkczqX6ZZ6
	 gGQ6+QePPOjgg==
Date: Wed, 20 Aug 2025 17:59:00 -0700
Subject: [PATCH 2/4] fuse: use the iomap cache for iomap_begin
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573709891.18403.13427597741639988313.stgit@frogsfrogsfrogs>
In-Reply-To: <175573709825.18403.10618991015902453439.stgit@frogsfrogsfrogs>
References: <175573709825.18403.10618991015902453439.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Look inside the iomap cache to try to satisfy iomap_begin.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h  |   34 ++++++++
 fs/fuse/iomap_priv.h  |    5 +
 fs/fuse/file_iomap.c  |  221 ++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/iomap_cache.c |    6 +
 4 files changed, 260 insertions(+), 6 deletions(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index eb604eaf3bafad..94e7a4222d2ac2 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -319,6 +319,7 @@ struct fuse_iomap_lookup;
 
 #define FUSE_IOMAP_TYPE_STRINGS \
 	{ FUSE_IOMAP_TYPE_PURE_OVERWRITE,	"overwrite" }, \
+	{ FUSE_IOMAP_TYPE_RETRY_CACHE,		"retry" }, \
 	{ FUSE_IOMAP_TYPE_HOLE,			"hole" }, \
 	{ FUSE_IOMAP_TYPE_DELALLOC,		"delalloc" }, \
 	{ FUSE_IOMAP_TYPE_MAPPED,		"mapped" }, \
@@ -1411,6 +1412,39 @@ TRACE_EVENT(fuse_iomap_cache_lookup_result,
 		  FUSE_IOMAP_MAP_PRINTK_ARGS(got),
 		  __entry->validity_cookie)
 );
+
+TRACE_EVENT(fuse_iomap_invalid,
+	TP_PROTO(const struct inode *inode, const struct iomap *map,
+		 uint64_t validity_cookie),
+	TP_ARGS(inode, map, validity_cookie),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		FUSE_IOMAP_MAP_FIELDS(map)
+		__field(uint64_t,		old_validity_cookie)
+		__field(uint64_t,		validity_cookie)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+
+		__entry->mapoffset	=	map->offset;
+		__entry->maplength	=	map->length;
+		__entry->maptype	=	map->type;
+		__entry->mapflags	=	map->flags;
+		__entry->mapaddr	=	map->addr;
+		__entry->mapdev		=	FUSE_IOMAP_DEV_NULL;
+
+		__entry->old_validity_cookie=	map->validity_cookie;
+		__entry->validity_cookie=	validity_cookie;
+	),
+
+	TP_printk(FUSE_INODE_FMT FUSE_IOMAP_MAP_FMT() " old_cookie 0x%llx new_cookie 0x%llx",
+		  FUSE_INODE_PRINTK_ARGS,
+		  FUSE_IOMAP_MAP_PRINTK_ARGS(map),
+		  __entry->old_validity_cookie,
+		  __entry->validity_cookie)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/iomap_priv.h b/fs/fuse/iomap_priv.h
index 8e4a32879025a4..8f1aef381942b6 100644
--- a/fs/fuse/iomap_priv.h
+++ b/fs/fuse/iomap_priv.h
@@ -145,6 +145,11 @@ static inline bool fuse_iext_peek_prev_extent(struct fuse_ifork *ifp,
 	     fuse_iext_get_extent((ifp), (ext), (got));	\
 	     fuse_iext_next((ifp), (ext)))
 
+/* iomaps that come direct from the fuse server are presumed to be valid */
+#define FUSE_IOMAP_ALWAYS_VALID	((uint64_t)0)
+/* set initial iomap cookie value to avoid ALWAYS_VALID */
+#define FUSE_IOMAP_INIT_COOKIE	((uint64_t)1)
+
 static inline uint64_t fuse_iext_read_seq(struct fuse_iomap_cache *ip)
 {
 	return (uint64_t)READ_ONCE(ip->im_seq);
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 545798f0d915a1..706eff6863d0a7 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -162,6 +162,7 @@ static inline bool fuse_iomap_check_type(uint16_t fuse_type)
 	case FUSE_IOMAP_TYPE_UNWRITTEN:
 	case FUSE_IOMAP_TYPE_INLINE:
 	case FUSE_IOMAP_TYPE_PURE_OVERWRITE:
+	case FUSE_IOMAP_TYPE_RETRY_CACHE:
 		return true;
 	}
 
@@ -267,9 +268,14 @@ static inline bool fuse_iomap_check_mapping(const struct inode *inode,
 	const unsigned int blocksize = i_blocksize(inode);
 	uint64_t end;
 
-	/* Type and flags must be known */
+	/*
+	 * Type and flags must be known.  Mapping type "retry cache" doesn't
+	 * use any of the other fields.
+	 */
 	if (BAD_DATA(!fuse_iomap_check_type(map->type)))
 		return false;
+	if (map->type == FUSE_IOMAP_TYPE_RETRY_CACHE)
+		return true;
 	if (BAD_DATA(!fuse_iomap_check_flags(map->flags)))
 		return false;
 
@@ -300,6 +306,14 @@ static inline bool fuse_iomap_check_mapping(const struct inode *inode,
 		if (BAD_DATA(map->addr == FUSE_IOMAP_NULL_ADDR))
 			return false;
 		break;
+	case FUSE_IOMAP_TYPE_RETRY_CACHE:
+		/*
+		 * We only accept cache retries if we have a cache to query.
+		 * There must not be a device addr.
+		 */
+		if (BAD_DATA(!fuse_inode_caches_iomaps(inode)))
+			return false;
+		fallthrough;
 	case FUSE_IOMAP_TYPE_DELALLOC:
 	case FUSE_IOMAP_TYPE_HOLE:
 	case FUSE_IOMAP_TYPE_INLINE:
@@ -569,6 +583,149 @@ static int fuse_iomap_set_inline(struct inode *inode, unsigned opflags,
 	return 0;
 }
 
+/* Convert a mapping from the cache into something the kernel can use */
+static int fuse_iomap_from_cache(struct inode *inode, struct iomap *iomap,
+				 const struct fuse_iomap_lookup *lmap)
+{
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct fuse_backing *fb;
+
+	fb = fuse_iomap_find_dev(fm->fc, &lmap->map);
+	if (IS_ERR(fb))
+		return PTR_ERR(fb);
+
+	fuse_iomap_from_server(inode, iomap, fb, &lmap->map);
+	iomap->validity_cookie = lmap->validity_cookie;
+
+	fuse_backing_put(fb);
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
+static inline int
+fuse_iomap_cached_validate(const struct inode *inode,
+			   enum fuse_iomap_iodir dir,
+			   const struct fuse_iomap_lookup *lmap)
+{
+	if (!static_branch_unlikely(&fuse_iomap_debug))
+		return 0;
+
+	/* Make sure the mappings aren't garbage */
+	if (!fuse_iomap_check_mapping(inode, &lmap->map, dir))
+		return -EFSCORRUPTED;
+
+	/* The cache should not be storing "retry cache" mappings */
+	if (BAD_DATA(lmap->map.type == FUSE_IOMAP_TYPE_RETRY_CACHE))
+		return -EFSCORRUPTED;
+
+	return 0;
+}
+#else
+# define fuse_iomap_cached_validate(...)	(0)
+#endif
+
+/*
+ * Look up iomappings from the cache.  Returns 1 if iomap and srcmap were
+ * satisfied from cache; 0 if not; or a negative errno.
+ */
+static int fuse_iomap_try_cache(struct inode *inode, loff_t pos, loff_t count,
+				unsigned opflags, struct iomap *iomap,
+				struct iomap *srcmap)
+{
+	struct fuse_iomap_lookup lmap;
+	struct iomap *dest = iomap;
+	enum fuse_iomap_lookup_result res;
+	int ret;
+
+	if (!fuse_inode_caches_iomaps(inode))
+		return 0;
+
+	fuse_iomap_cache_lock_shared(inode);
+
+	if (fuse_is_iomap_file_write(opflags)) {
+		res = fuse_iomap_cache_lookup(inode, WRITE_MAPPING, pos, count,
+					      &lmap);
+		switch (res) {
+		case LOOKUP_HIT:
+			ret = fuse_iomap_cached_validate(inode, WRITE_MAPPING,
+					&lmap);
+			if (ret)
+				goto out_unlock;
+
+			if (lmap.map.type != FUSE_IOMAP_TYPE_PURE_OVERWRITE) {
+				ret = fuse_iomap_from_cache(inode, dest, &lmap);
+				if (ret)
+					goto out_unlock;
+
+				dest = srcmap;
+			}
+			fallthrough;
+		case LOOKUP_NOFORK:
+			/* move on to the read fork */
+			break;
+		case LOOKUP_MISS:
+			ret = 0;
+			goto out_unlock;
+		}
+	}
+
+	res = fuse_iomap_cache_lookup(inode, READ_MAPPING, pos, count, &lmap);
+	switch (res) {
+	case LOOKUP_HIT:
+		break;
+	case LOOKUP_NOFORK:
+		ASSERT(res != LOOKUP_NOFORK);
+		ret = -EFSCORRUPTED;
+		goto out_unlock;
+	case LOOKUP_MISS:
+		ret = 0;
+		goto out_unlock;
+	}
+
+	ret = fuse_iomap_cached_validate(inode, READ_MAPPING, &lmap);
+	if (ret)
+		goto out_unlock;
+
+	ret = fuse_iomap_from_cache(inode, dest, &lmap);
+	if (ret)
+		goto out_unlock;
+
+	if (fuse_is_iomap_file_write(opflags)) {
+		switch (iomap->type) {
+		case IOMAP_HOLE:
+			if (opflags & (IOMAP_ZERO | IOMAP_UNSHARE))
+				ret = 1;
+			else
+				ret = 0;
+			break;
+		case IOMAP_DELALLOC:
+			if (opflags & IOMAP_DIRECT)
+				ret = 0;
+			else
+				ret = 1;
+			break;
+		default:
+			ret = 1;
+			break;
+		}
+	} else {
+		ret = 1;
+	}
+
+out_unlock:
+	fuse_iomap_cache_unlock_shared(inode);
+	if (ret < 1)
+		return ret;
+
+	if (iomap->type == IOMAP_INLINE || srcmap->type == IOMAP_INLINE) {
+		ret = fuse_iomap_set_inline(inode, opflags, pos, count, iomap,
+					    srcmap);
+		if (ret)
+			return ret;
+	}
+	return 1;
+}
+
 static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 			    unsigned opflags, struct iomap *iomap,
 			    struct iomap *srcmap)
@@ -589,6 +746,21 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 
 	trace_fuse_iomap_begin(inode, pos, count, opflags);
 
+	/*
+	 * Try to read mappings from the cache; if we find something then use
+	 * it; otherwise we upcall the fuse server.  For atomic writes we must
+	 * always query the server.
+	 */
+	if (!(opflags & FUSE_IOMAP_OP_ATOMIC)) {
+		err = fuse_iomap_try_cache(inode, pos, count, opflags, iomap,
+					   srcmap);
+		if (err < 0)
+			return err;
+		if (err == 1)
+			return 0;
+	}
+
+retry:
 	args.opcode = FUSE_IOMAP_BEGIN;
 	args.nodeid = get_node_id(inode);
 	args.in_numargs = 1;
@@ -610,6 +782,24 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 	if (err)
 		return err;
 
+	/*
+	 * If the fuse server tells us it populated the cache, we'll try the
+	 * cache lookup again.  Note that we dropped the cache lock, so it's
+	 * entirely possible that another thread could have invalidated the
+	 * cache -- if the cache misses, we'll call the server again.
+	 */
+	if (outarg.read.type == FUSE_IOMAP_TYPE_RETRY_CACHE) {
+		err = fuse_iomap_try_cache(inode, pos, count, opflags, iomap,
+					   srcmap);
+		if (err < 0)
+			return err;
+		if (err == 1)
+			return 0;
+		if (signal_pending(current))
+			return -EINTR;
+		goto retry;
+	}
+
 	read_dev = fuse_iomap_find_dev(fm->fc, &outarg.read);
 	if (IS_ERR(read_dev))
 		return PTR_ERR(read_dev);
@@ -637,6 +827,8 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 		 */
 		fuse_iomap_from_server(inode, iomap, read_dev, &outarg.read);
 	}
+	iomap->validity_cookie = FUSE_IOMAP_ALWAYS_VALID;
+	srcmap->validity_cookie = FUSE_IOMAP_ALWAYS_VALID;
 
 	if (iomap->type == IOMAP_INLINE || srcmap->type == IOMAP_INLINE) {
 		err = fuse_iomap_set_inline(inode, opflags, pos, count, iomap,
@@ -1316,7 +1508,26 @@ static int fuse_iomap_direct_write_sync(struct kiocb *iocb, loff_t start,
 	return err;
 }
 
+static bool fuse_iomap_revalidate(struct inode *inode,
+				  const struct iomap *iomap)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	uint64_t validity_cookie;
+
+	if (iomap->validity_cookie == FUSE_IOMAP_ALWAYS_VALID)
+		return true;
+
+	validity_cookie = fuse_iext_read_seq(&fi->cache);
+	if (iomap->validity_cookie != validity_cookie) {
+		trace_fuse_iomap_invalid(inode, iomap, validity_cookie);
+		return false;
+	}
+
+	return true;
+}
+
 static const struct iomap_write_ops fuse_iomap_write_ops = {
+	.iomap_valid		= fuse_iomap_revalidate,
 };
 
 static int
@@ -1598,14 +1809,14 @@ static void fuse_iomap_end_bio(struct bio *bio)
  * mapping is valid, false otherwise.
  */
 static bool fuse_iomap_revalidate_writeback(struct iomap_writepage_ctx *wpc,
+					    struct inode *inode,
 					    loff_t offset)
 {
 	if (offset < wpc->iomap.offset ||
 	    offset >= wpc->iomap.offset + wpc->iomap.length)
 		return false;
 
-	/* XXX actually use revalidation cookie */
-	return true;
+	return fuse_iomap_revalidate(inode, &wpc->iomap);
 }
 
 /*
@@ -1659,7 +1870,7 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 
 	trace_fuse_iomap_writeback_range(inode, offset, len, end_pos);
 
-	if (!fuse_iomap_revalidate_writeback(wpc, offset)) {
+	if (!fuse_iomap_revalidate_writeback(wpc, inode, offset)) {
 		/* Pretend that this is a directio write */
 		ret = fuse_iomap_begin(inode, offset, len,
 				       IOMAP_DIRECT | IOMAP_WRITE,
@@ -1785,7 +1996,7 @@ static inline void fuse_inode_set_iomap(struct inode *inode)
 	mapping_set_folio_min_order(inode->i_mapping, min_order);
 
 	memset(&fi->cache.im_read, 0, sizeof(fi->cache.im_read));
-	fi->cache.im_seq = 0;
+	fi->cache.im_seq = FUSE_IOMAP_INIT_COOKIE;
 	fi->cache.im_write = NULL;
 
 	init_rwsem(&fi->cache.im_lock);
diff --git a/fs/fuse/iomap_cache.c b/fs/fuse/iomap_cache.c
index 5bfa0e26346d1f..572bccf99a97a8 100644
--- a/fs/fuse/iomap_cache.c
+++ b/fs/fuse/iomap_cache.c
@@ -660,7 +660,11 @@ fuse_iext_realloc_root(
  */
 static inline void fuse_iext_inc_seq(struct fuse_iomap_cache *ip)
 {
-	WRITE_ONCE(ip->im_seq, READ_ONCE(ip->im_seq) + 1);
+	uint64_t new_val = READ_ONCE(ip->im_seq) + 1;
+
+	if (new_val == FUSE_IOMAP_ALWAYS_VALID)
+		new_val++;
+	WRITE_ONCE(ip->im_seq, new_val);
 }
 
 void


