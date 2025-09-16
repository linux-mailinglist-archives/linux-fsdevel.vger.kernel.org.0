Return-Path: <linux-fsdevel+bounces-61550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3ABB589D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740F5522C03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752BC1A9FBD;
	Tue, 16 Sep 2025 00:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OURxTnQP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A0F83CC7;
	Tue, 16 Sep 2025 00:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983151; cv=none; b=pnHTlN+aobL/AoGLZxdQp2fXQ44FJFO9PCKzCfHTw4u30RlI2IN6bjvaEn05QFT4draUDCK2jqA72VLP/0+Knya/56zh9/YVyw3hUsMxNXWuFoJOEEm0ihXmGTy/+/zOXCtfxRutFQx2bFuO4Stj6JaMRDuJdSEVS/idqtX5w8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983151; c=relaxed/simple;
	bh=+6y3iuw73DmKAT36iLg38Flbl9yLdeKPU7oKRTVCJAc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wp0barQEz3gwVJd4unpK2EOzvuDK0GGIP9uyuSse2sVCarZ7pn7rSDnwO3s+k0rnctlCgYn1ra+koNIu3YLcfLYMIDoCJ3pUt0BlmPiSFeUgWMwQxnlHHa29zFmPif3EvwwJ4pbe9A9FZLnRYEHA9gF9s/F00fMfne1GTlF73zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OURxTnQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F5BC4CEF1;
	Tue, 16 Sep 2025 00:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983151;
	bh=+6y3iuw73DmKAT36iLg38Flbl9yLdeKPU7oKRTVCJAc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=OURxTnQPpH6Z5Uj7Fmbw8cYwWNmQIYogZHiU7UnHah9Ih7u+0ssR+I6GEqQ3gSmHy
	 yX16SQxiYUOWsCqaXilNYHqR9hDtg1oyl8sGOEKawKmB0DDmDJ6/TQoyCC34+XRUae
	 zL+B6yCkRUFE7v+qmZa4g+LuFfhdNwoh8izMeWwmH8WXmy81bQUEHgD9/bZQFU1QGg
	 iX9A/uEgJ9T4K0KBIcDN4pa7f3LaLK7VZXYa1XlowTSVBnyzp5maLyv4hmnXXBdJGi
	 JWxtOPyJXiO+6AshTzqgYMUMJIAYWN5bNzux5BqB1kULnRAPl/VTBd2nQBNwIRRC16
	 xtxb9v8gT0EDA==
Date: Mon, 15 Sep 2025 17:39:10 -0700
Subject: [PATCH 03/10] fuse: use the iomap cache for iomap_begin
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798152990.384360.17152730168721197156.stgit@frogsfrogsfrogs>
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

Look inside the iomap cache to try to satisfy iomap_begin.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/iomap_priv.h  |    5 +
 fs/fuse/file_iomap.c  |  216 ++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/iomap_cache.c |    6 +
 3 files changed, 221 insertions(+), 6 deletions(-)


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
index d35e69d03b0940..47c82ec29238e3 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -165,6 +165,7 @@ static inline bool fuse_iomap_check_type(uint16_t fuse_type)
 	case FUSE_IOMAP_TYPE_UNWRITTEN:
 	case FUSE_IOMAP_TYPE_INLINE:
 	case FUSE_IOMAP_TYPE_PURE_OVERWRITE:
+	case FUSE_IOMAP_TYPE_RETRY_CACHE:
 		return true;
 	}
 
@@ -270,9 +271,14 @@ static inline bool fuse_iomap_check_mapping(const struct inode *inode,
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
 
@@ -303,6 +309,14 @@ static inline bool fuse_iomap_check_mapping(const struct inode *inode,
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
@@ -568,6 +582,149 @@ static int fuse_iomap_set_inline(struct inode *inode, unsigned opflags,
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
@@ -588,6 +745,21 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 
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
@@ -609,6 +781,24 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
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
@@ -636,6 +826,8 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 		 */
 		fuse_iomap_from_server(inode, iomap, read_dev, &outarg.read);
 	}
+	iomap->validity_cookie = FUSE_IOMAP_ALWAYS_VALID;
+	srcmap->validity_cookie = FUSE_IOMAP_ALWAYS_VALID;
 
 	if (iomap->type == IOMAP_INLINE || srcmap->type == IOMAP_INLINE) {
 		err = fuse_iomap_set_inline(inode, opflags, pos, count, iomap,
@@ -1338,7 +1530,21 @@ static const struct iomap_dio_ops fuse_iomap_dio_write_ops = {
 	.end_io		= fuse_iomap_dio_write_end_io,
 };
 
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
+	return iomap->validity_cookie == validity_cookie;
+}
+
 static const struct iomap_write_ops fuse_iomap_write_ops = {
+	.iomap_valid		= fuse_iomap_revalidate,
 };
 
 static int
@@ -1606,14 +1812,14 @@ static void fuse_iomap_end_bio(struct bio *bio)
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
@@ -1667,7 +1873,7 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 
 	trace_fuse_iomap_writeback_range(inode, offset, len, end_pos);
 
-	if (!fuse_iomap_revalidate_writeback(wpc, offset)) {
+	if (!fuse_iomap_revalidate_writeback(wpc, inode, offset)) {
 		ret = fuse_iomap_begin(inode, offset, len,
 				       FUSE_IOMAP_OP_WRITEBACK,
 				       &write_iomap, &dontcare);
@@ -1804,7 +2010,7 @@ static inline void fuse_inode_set_iomap(struct inode *inode)
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


