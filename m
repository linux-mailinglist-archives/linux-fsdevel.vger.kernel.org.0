Return-Path: <linux-fsdevel+bounces-55336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F604B0980F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493471891577
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61A924A079;
	Thu, 17 Jul 2025 23:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwoSTZ8m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328AB247299
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795125; cv=none; b=K4Zv0uM/itjOhDjmMdAKSh/tPUS1pi7HUA26hyvUQtwFOHzF4Nu4ifEnngdZsIfQejCpRt5ksFVn1TLw0wLIBnvXaWLX27vvUFKvP5wZ+EUzNinPsSDLpiYuLvTkuf96yfgWk1ID3TrK6OiSiX6IEpIL0p09VhJuDe0E9d22pn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795125; c=relaxed/simple;
	bh=WrRofgUKp+urHQ2/mbWjUTJkdkKmz2X6ekYiog2jG4U=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cU05mEkAIW8djaSoXPoP7LuvH84VeclaXb3AXe7ZS5hJxbvhDckxcAH3spuOmJ7oM5FE2/q731gOq1XnA+nOHtdagNeQt8OdP8dwEDJcO7Iz3r1fHi5u0ny7uUYSpyfm31+F2K9d5c6m8upTZa0XPvrPKwEzLypEdZi/XNWIXIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwoSTZ8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC98C4CEF0;
	Thu, 17 Jul 2025 23:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795124;
	bh=WrRofgUKp+urHQ2/mbWjUTJkdkKmz2X6ekYiog2jG4U=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=CwoSTZ8m4U/FYtRLLCSlAOFRazYcA8q9Zb7pNeLgb/W7KdXblorSQOAsIHzf3Kdv7
	 BKCQPeQplFRDfFoS/ikuC/yzSAx+NuAB3HnU1Qy1ZllBytslZU769W/XHCdsFGCRBY
	 k3W7LoBYiUeK9MqR4naUiuRXxwP6WtN4l7pMCl3GaYdm4nhe6PW93qkdmLuS03V8Vx
	 aidYodbfzYRJ7Xs4vttSzI9miuPEnvt4n+EG1AjMB1qUk9F3yEERzGVGiqiNYORc9M
	 sfsQck6kZFhNoyGeXnR2Qmk4Fe77vqTVgmz3EOAAMiXZy9xaY+68ZLrku49EieA7mr
	 yIGrV6CEZ9iYA==
Date: Thu, 17 Jul 2025 16:32:04 -0700
Subject: [PATCH 2/4] fuse: use the iomap cache for iomap_begin
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279450485.713483.15322599456936105872.stgit@frogsfrogsfrogs>
In-Reply-To: <175279450420.713483.16534356247856109745.stgit@frogsfrogsfrogs>
References: <175279450420.713483.16534356247856109745.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h  |   46 ++++++++
 fs/fuse/iomap_cache.h |    3 +
 fs/fuse/file_iomap.c  |  270 ++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/iomap_cache.c |   63 +++++++++++
 4 files changed, 377 insertions(+), 5 deletions(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 598c0e603a32b1..88f1dd2ccbc9d5 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -158,6 +158,7 @@ struct fuse_iext_cursor;
 
 #define FUSE_IOMAP_TYPE_STRINGS \
 	{ FUSE_IOMAP_TYPE_PURE_OVERWRITE,	"overwrite" }, \
+	{ FUSE_IOMAP_TYPE_NULL,			"null" }, \
 	{ FUSE_IOMAP_TYPE_HOLE,			"hole" }, \
 	{ FUSE_IOMAP_TYPE_DELALLOC,		"delalloc" }, \
 	{ FUSE_IOMAP_TYPE_MAPPED,		"mapped" }, \
@@ -1723,6 +1724,51 @@ TRACE_EVENT(fuse_iomap_cache_lookup_result,
 		  __entry->got_length, __entry->got_addr,
 		  __entry->validity_cookie)
 );
+
+TRACE_EVENT(fuse_iomap_invalid,
+	TP_PROTO(const struct inode *inode, const struct iomap *map,
+		 uint64_t validity_cookie),
+	TP_ARGS(inode, map, validity_cookie),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+		__field(uint64_t,		ino)
+		__field(uint64_t,		nodeid)
+		__field(loff_t,			isize)
+		__field(loff_t,			offset)
+		__field(uint64_t,		length)
+		__field(uint16_t,		maptype)
+		__field(uint16_t,		mapflags)
+		__field(uint64_t,		addr)
+		__field(uint64_t,		old_validity_cookie)
+		__field(uint64_t,		validity_cookie)
+	),
+
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->nodeid		=	fi->nodeid;
+		__entry->isize		=	i_size_read(inode);
+		__entry->offset		=	map->offset;
+		__entry->length		=	map->length;
+		__entry->maptype	=	map->type;
+		__entry->mapflags	=	map->flags;
+		__entry->addr		=	map->addr;
+		__entry->old_validity_cookie=	map->validity_cookie;
+		__entry->validity_cookie=	validity_cookie;
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx offset 0x%llx length 0x%llx type %s mapflags (%s) addr 0x%llx old_cookie 0x%llx new_cookie 0x%llx",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize, __entry->offset, __entry->length,
+		  __print_symbolic(__entry->maptype, FUSE_IOMAP_TYPE_STRINGS),
+		  __print_flags(__entry->mapflags, "|", FUSE_IOMAP_F_STRINGS),
+		  __entry->addr, __entry->old_validity_cookie,
+		  __entry->validity_cookie)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/iomap_cache.h b/fs/fuse/iomap_cache.h
index 7efa23be18d155..2edcc8dc94b145 100644
--- a/fs/fuse/iomap_cache.h
+++ b/fs/fuse/iomap_cache.h
@@ -20,6 +20,9 @@
 void fuse_iomap_cache_lock(struct inode *inode, unsigned int lock_flags);
 void fuse_iomap_cache_unlock(struct inode *inode, unsigned int lock_flags);
 
+bool fuse_iomap_check_type(uint16_t type);
+bool fuse_iomap_check_flags(uint16_t flags);
+
 #define FUSE_IOMAP_MAX_LEN	((loff_t)(1ULL << 63))
 
 struct fuse_iext_leaf;
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 66e1be93592023..122860af4bc42f 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -32,7 +32,7 @@ bool fuse_iomap_enabled(void)
 	return enable_iomap && has_capability_noaudit(current, CAP_SYS_RAWIO);
 }
 
-static inline bool fuse_iomap_check_type(uint16_t type)
+inline bool fuse_iomap_check_type(uint16_t type)
 {
 	BUILD_BUG_ON(FUSE_IOMAP_TYPE_HOLE	!= IOMAP_HOLE);
 	BUILD_BUG_ON(FUSE_IOMAP_TYPE_DELALLOC	!= IOMAP_DELALLOC);
@@ -42,6 +42,7 @@ static inline bool fuse_iomap_check_type(uint16_t type)
 
 	switch (type) {
 	case FUSE_IOMAP_TYPE_PURE_OVERWRITE:
+	case FUSE_IOMAP_TYPE_NULL:
 	case FUSE_IOMAP_TYPE_HOLE:
 	case FUSE_IOMAP_TYPE_DELALLOC:
 	case FUSE_IOMAP_TYPE_MAPPED:
@@ -63,7 +64,7 @@ static inline bool fuse_iomap_check_type(uint16_t type)
 			  FUSE_IOMAP_F_ATOMIC_BIO | \
 			  FUSE_IOMAP_F_WANT_IOMAP_END)
 
-static inline bool fuse_iomap_check_flags(uint16_t flags)
+inline bool fuse_iomap_check_flags(uint16_t flags)
 {
 	BUILD_BUG_ON(FUSE_IOMAP_F_NEW		!= IOMAP_F_NEW);
 	BUILD_BUG_ON(FUSE_IOMAP_F_DIRTY		!= IOMAP_F_DIRTY);
@@ -147,6 +148,14 @@ fuse_iomap_begin_validate(const struct fuse_iomap_begin_out *outarg,
 		if (BAD_DATA(outarg->read_addr == FUSE_IOMAP_NULL_ADDR))
 			return -EIO;
 		break;
+	case FUSE_IOMAP_TYPE_NULL:
+		/*
+		 * We only accept null mappings if we have a cache to query.
+		 * There must not be a device addr.
+		 */
+		if (BAD_DATA(!fuse_has_iomap_cache(inode)))
+			return -EIO;
+		fallthrough;
 	case FUSE_IOMAP_TYPE_DELALLOC:
 	case FUSE_IOMAP_TYPE_HOLE:
 	case FUSE_IOMAP_TYPE_INLINE:
@@ -170,6 +179,14 @@ fuse_iomap_begin_validate(const struct fuse_iomap_begin_out *outarg,
 		if (BAD_DATA(outarg->write_addr == FUSE_IOMAP_NULL_ADDR))
 			return -EIO;
 		break;
+	case FUSE_IOMAP_TYPE_NULL:
+		/*
+		 * We only accept null mappings if we have a cache to query.
+		 * There must not be a device addr.
+		 */
+		if (BAD_DATA(!fuse_has_iomap_cache(inode)))
+			return -EIO;
+		fallthrough;
 	case FUSE_IOMAP_TYPE_PURE_OVERWRITE:
 	case FUSE_IOMAP_TYPE_HOLE:
 	case FUSE_IOMAP_TYPE_DELALLOC:
@@ -445,6 +462,220 @@ static int fuse_iomap_set_inline(struct inode *inode, unsigned opflags,
 	return 0;
 }
 
+static bool fuse_iomap_revalidate(struct inode *inode,
+				  const struct iomap *iomap)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	uint64_t validity_cookie = fuse_iext_read_seq(&fi->cache);
+
+	if (iomap->validity_cookie != validity_cookie) {
+		trace_fuse_iomap_invalid(inode, iomap, validity_cookie);
+		return false;
+	}
+
+	return true;
+}
+
+static const struct iomap_folio_ops fuse_iomap_folio_ops = {
+	.iomap_valid		= fuse_iomap_revalidate,
+};
+
+static int fuse_iomap_from_cache(struct inode *inode, struct iomap *iomap,
+				 const struct fuse_iomap *fmap)
+{
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct fuse_iomap_dev *fb;
+
+	fb = fuse_iomap_find_dev(fm->fc, fmap->type, fmap->dev);
+	if (IS_ERR(fb))
+		return PTR_ERR(fb);
+
+	iomap->addr = fmap->addr;
+	iomap->offset = fmap->offset;
+	iomap->length = fmap->length;
+	iomap->type = fmap->type;
+	iomap->flags = fmap->flags;
+	iomap->folio_ops = &fuse_iomap_folio_ops;
+	iomap->validity_cookie = fmap->validity_cookie;
+	fuse_iomap_set_device(iomap, fb);
+
+	fuse_iomap_dev_put(fb);
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
+static inline int fuse_iomap_validate_cached(const struct inode *inode,
+					     enum fuse_iomap_fork whichfork,
+					     unsigned opflags,
+					     const struct fuse_iomap *fmap)
+{
+	uint64_t end;
+
+	/* No garbage mapping types or flags */
+	if (BAD_DATA(!fuse_iomap_check_type(fmap->type)))
+		return -EIO;
+	if (BAD_DATA(!fuse_iomap_check_flags(fmap->flags)))
+		return -EIO;
+
+	/* Must have returned a mapping for the first byte in the range */
+	if (BAD_DATA(fmap->length == 0))
+		return -EIO;
+
+	/* No overflows in the file range */
+	if (BAD_DATA(check_add_overflow(fmap->offset, fmap->length, &end)))
+		return -EIO;
+
+	/* File range cannot start past maxbytes */
+	if (BAD_DATA(fmap->offset >= inode->i_sb->s_maxbytes))
+		return -EIO;
+
+	switch (fmap->type) {
+	case FUSE_IOMAP_TYPE_PURE_OVERWRITE:
+		/* "Pure overwrite" only allowed for write mapping */
+		if (BAD_DATA(whichfork != FUSE_IOMAP_WRITE_FORK))
+			return -EIO;
+		break;
+	case FUSE_IOMAP_TYPE_MAPPED:
+	case FUSE_IOMAP_TYPE_UNWRITTEN:
+		/* Mappings backed by space must have a device/addr */
+		if (BAD_DATA(fmap->dev == FUSE_IOMAP_DEV_NULL))
+			return -EIO;
+		if (BAD_DATA(fmap->addr == FUSE_IOMAP_NULL_ADDR))
+			return -EIO;
+		break;
+	case FUSE_IOMAP_TYPE_DELALLOC:
+	case FUSE_IOMAP_TYPE_HOLE:
+	case FUSE_IOMAP_TYPE_INLINE:
+		/* Mappings not backed by space cannot have a device addr. */
+		if (BAD_DATA(fmap->dev != FUSE_IOMAP_DEV_NULL))
+			return -EIO;
+		if (BAD_DATA(fmap->addr != FUSE_IOMAP_NULL_ADDR))
+			return -EIO;
+		break;
+	case FUSE_IOMAP_TYPE_NULL:
+		/* Cache itself cannot contain null mappings */
+		BAD_DATA(fmap->type == FUSE_IOMAP_TYPE_NULL);
+		return -EIO;
+	default:
+		/* should have been caught already */
+		return -EIO;
+	}
+
+	/* No overflows in the device range, if supplied */
+	if (fmap->addr != FUSE_IOMAP_NULL_ADDR &&
+	    BAD_DATA(check_add_overflow(fmap->addr, fmap->length, &end)))
+		return -EIO;
+
+	return 0;
+}
+#else
+# define fuse_iomap_validate_cached(...)	(0)
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
+	struct fuse_iomap map;
+	struct iomap *dest = iomap;
+	enum fuse_iomap_lookup_result res;
+	int ret;
+
+	if (!fuse_has_iomap_cache(inode))
+		return 0;
+
+	fuse_iomap_cache_lock(inode, FUSE_IOMAP_LOCK_SHARED);
+
+	if (fuse_is_iomap_file_write(opflags)) {
+		res = fuse_iomap_cache_lookup(inode, FUSE_IOMAP_WRITE_FORK,
+					      pos, count, &map);
+		switch (res) {
+		case LOOKUP_HIT:
+			ret = fuse_iomap_validate_cached(inode, opflags,
+					FUSE_IOMAP_WRITE_FORK, &map);
+			if (ret)
+				goto out_unlock;
+
+			if (map.type != FUSE_IOMAP_TYPE_PURE_OVERWRITE) {
+				ret = fuse_iomap_from_cache(inode, dest, &map);
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
+	res = fuse_iomap_cache_lookup(inode, FUSE_IOMAP_READ_FORK, pos, count,
+				      &map);
+	switch (res) {
+	case LOOKUP_HIT:
+		break;
+	case LOOKUP_NOFORK:
+		ASSERT(res != LOOKUP_NOFORK);
+		ret = -EIO;
+		goto out_unlock;
+	case LOOKUP_MISS:
+		ret = 0;
+		goto out_unlock;
+	}
+
+	ret = fuse_iomap_validate_cached(inode, opflags, FUSE_IOMAP_READ_FORK,
+					 &map);
+	if (ret)
+		goto out_unlock;
+
+	ret = fuse_iomap_from_cache(inode, dest, &map);
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
+	fuse_iomap_cache_unlock(inode, FUSE_IOMAP_LOCK_SHARED);
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
@@ -465,6 +696,17 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 
 	trace_fuse_iomap_begin(inode, pos, count, opflags);
 
+	/*
+	 * Try to read mappings from the cache; if we find something then use
+	 * it; otherwise we upcall the fuse server.
+	 */
+	err = fuse_iomap_try_cache(inode, pos, count, opflags, iomap, srcmap);
+	if (err < 0)
+		return err;
+	if (err == 1)
+		return 0;
+
+retry:
 	args.opcode = FUSE_IOMAP_BEGIN;
 	args.nodeid = get_node_id(inode);
 	args.in_numargs = 1;
@@ -486,6 +728,24 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 	if (err)
 		return err;
 
+	/*
+	 * If the fuse server returned null mappings, we'll try the cache again
+	 * assuming that the fuse server populated the cache.  Note that we
+	 * dropped the cache lock, so it's entirely possible that another
+	 * thread could have invalidated the cache.
+	 */
+	if (outarg.read_type == FUSE_IOMAP_TYPE_NULL) {
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
 	read_dev = fuse_iomap_find_dev(fm->fc, outarg.read_type,
 				       outarg.read_dev);
 	if (IS_ERR(read_dev))
@@ -1479,14 +1739,14 @@ static void fuse_iomap_end_bio(struct bio *bio)
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
 
 static int fuse_iomap_map_blocks(struct iomap_writepage_ctx *wpc,
@@ -1503,7 +1763,7 @@ static int fuse_iomap_map_blocks(struct iomap_writepage_ctx *wpc,
 
 	trace_fuse_iomap_map_blocks(inode, offset, len);
 
-	if (fuse_iomap_revalidate_writeback(wpc, offset))
+	if (fuse_iomap_revalidate_writeback(wpc, inode, offset))
 		return 0;
 
 	/* Pretend that this is a directio write */
diff --git a/fs/fuse/iomap_cache.c b/fs/fuse/iomap_cache.c
index 6244352f543f03..239441d2903cc8 100644
--- a/fs/fuse/iomap_cache.c
+++ b/fs/fuse/iomap_cache.c
@@ -1564,6 +1564,67 @@ fuse_iomap_cache_add(
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
+static inline void
+fuse_iomap_cache_validate_lookup(const struct inode *inode,
+				 enum fuse_iomap_fork whichfork,
+				 const struct fuse_iomap *fmap)
+{
+	const unsigned int blocksize = i_blocksize(inode);
+	uint64_t end;
+
+	/* No garbage mapping types or flags */
+	BAD_DATA(!fuse_iomap_check_type(fmap->type));
+	BAD_DATA(!fuse_iomap_check_flags(fmap->flags));
+
+	/* Must have returned a mapping for the first byte in the range */
+	BAD_DATA(fmap->length == 0);
+
+	/* File range must be aligned to blocksize */
+	BAD_DATA(!IS_ALIGNED(fmap->offset, blocksize));
+	BAD_DATA(!IS_ALIGNED(fmap->length, blocksize));
+
+	/* No overflows in the file range */
+	BAD_DATA(check_add_overflow(fmap->offset, fmap->length, &end));
+
+	/* File range cannot start past maxbytes */
+	BAD_DATA(fmap->offset >= inode->i_sb->s_maxbytes);
+
+	switch (fmap->type) {
+	case FUSE_IOMAP_TYPE_PURE_OVERWRITE:
+		/* "Pure overwrite" only allowed for write mapping */
+		BAD_DATA(whichfork != FUSE_IOMAP_WRITE_FORK);
+		break;
+	case FUSE_IOMAP_TYPE_MAPPED:
+	case FUSE_IOMAP_TYPE_UNWRITTEN:
+		/* Mappings backed by space must have a device/addr */
+		BAD_DATA(fmap->dev == FUSE_IOMAP_DEV_NULL);
+		BAD_DATA(fmap->addr == FUSE_IOMAP_NULL_ADDR);
+		break;
+	case FUSE_IOMAP_TYPE_DELALLOC:
+	case FUSE_IOMAP_TYPE_HOLE:
+	case FUSE_IOMAP_TYPE_INLINE:
+		/* Mappings not backed by space cannot have a device addr. */
+		BAD_DATA(fmap->dev != FUSE_IOMAP_DEV_NULL);
+		BAD_DATA(fmap->addr != FUSE_IOMAP_NULL_ADDR);
+		break;
+	case FUSE_IOMAP_TYPE_NULL:
+		/* Cache itself cannot contain null mappings */
+		BAD_DATA(fmap->type == FUSE_IOMAP_TYPE_NULL);
+		break;
+	default:
+		BAD_DATA(1);
+		break;
+	}
+
+	/* No overflows in the device range, if supplied */
+	if (fmap->addr != FUSE_IOMAP_NULL_ADDR)
+		BAD_DATA(check_add_overflow(fmap->addr, fmap->length, &end));
+}
+#else
+# define fuse_iomap_cache_validate_lookup(...)	((void)0)
+#endif
+
 /*
  * Trim the returned map to the required bounds
  */
@@ -1642,6 +1703,8 @@ fuse_iomap_cache_lookup(
 		return LOOKUP_MISS;
 	}
 
+	fuse_iomap_cache_validate_lookup(inode, whichfork, &got);
+
 	/* Found a mapping in the cache, return it */
 	fuse_iomap_trim(inode, mval, &got, off, len);
 	mval->validity_cookie = fuse_iext_read_seq(ip);


