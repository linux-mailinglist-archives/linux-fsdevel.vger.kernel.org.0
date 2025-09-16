Return-Path: <linux-fsdevel+bounces-61548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D31EFB589CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8BE11B25E5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8181DF979;
	Tue, 16 Sep 2025 00:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c35Ypfus"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8949F1DB377;
	Tue, 16 Sep 2025 00:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983120; cv=none; b=gxuV6+1aH46NJuK1Wmz0oa750Cg5ibHZ06dU65XbrR706kC1WP8lJ3ZzVIf1R3XCCBUeCq+vORPqUkm4UGC7VvPJNT4dwzIvv8WEQdD08IvH9uAHzZ46QaF/2eaNvdT9zBnBRMH290NxjgGLeyMnw4R1v/MuV1K+s8GbMPaNFSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983120; c=relaxed/simple;
	bh=2DVvp1/C2EQzHbcMhWU7xHBxVq74WfFM7fhmtdNbSkc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHrKhGR9SDDENWTeW+h0QKWvMRWuDtibNsBzZ2nzULWLCdiMeoC1IsnBnnGwBJ64K4hML+LhmgF5y0GXxFbpwzhwrYjBRMjsW8AQGRcPWVc3JOvzP6hBgLFUbKhws/kO0stC1IkNOYBv1BJXCAPXI2tYrze4SLErbB0imudPKZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c35Ypfus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F8EC4CEF1;
	Tue, 16 Sep 2025 00:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983120;
	bh=2DVvp1/C2EQzHbcMhWU7xHBxVq74WfFM7fhmtdNbSkc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=c35Ypfuse6uk3uDiWmsSnh1nsL9yKU5zFbhLBpw6+WO6cYVkGnr/CYPrgf4/RvoFJ
	 ZsQpxDJYNInxCtxTV0DvKNFz3M0uXL30gPrUKHIPUs7hfBi6yPAiGniZ1kGH6JizFd
	 e2A/S9PMeGjhK7VacbMqAF9vtuKFSegQv3H1QcL1f7aqhVFWC/rVCxuky8yEwOvzvW
	 0WSKnlREswG09SOtIoC0UC8dLtWefvhsupqkLav28cx2CrxUvHga1QnFiQEwFZYUSy
	 VhqTd9AIDsnznUpQQifM0rqZ1S+d+rDlKQlF/ej3sNhZcdpbsbc6KvmX3hKrOvb3O4
	 SsSCYCKN1M/Qw==
Date: Mon, 15 Sep 2025 17:38:39 -0700
Subject: [PATCH 01/10] fuse: cache iomaps
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798152947.384360.733018681948674382.stgit@frogsfrogsfrogs>
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

Cache iomaps to a file so that we don't have to upcall the server.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |   39 +
 fs/fuse/iomap_priv.h      |  135 ++++
 include/uapi/linux/fuse.h |    5 
 fs/fuse/Makefile          |    2 
 fs/fuse/file_iomap.c      |   23 +
 fs/fuse/iomap_cache.c     | 1629 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 1827 insertions(+), 6 deletions(-)
 create mode 100644 fs/fuse/iomap_cache.c


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ae03a898d3aa7d..33b65253b2e9be 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -120,6 +120,24 @@ struct fuse_backing {
 	struct rcu_head rcu;
 };
 
+#if IS_ENABLED(CONFIG_FUSE_IOMAP)
+/*
+ * File incore extent information, present for each of data & attr forks.
+ */
+struct fuse_ifork {
+	int64_t			if_bytes;	/* bytes in if_data */
+	void			*if_data;	/* extent tree root */
+	int			if_height;	/* height of the extent tree */
+};
+
+struct fuse_iomap_cache {
+	struct fuse_ifork	im_read;
+	struct fuse_ifork	*im_write;
+	uint64_t		im_seq;		/* validity counter */
+	struct rw_semaphore	im_lock;	/* mapping lock */
+};
+#endif
+
 /** FUSE inode */
 struct fuse_inode {
 	/** Inode data */
@@ -185,6 +203,9 @@ struct fuse_inode {
 			spinlock_t ioend_lock;
 			struct work_struct ioend_work;
 			struct list_head ioend_list;
+
+			/* cached iomap mappings */
+			struct fuse_iomap_cache cache;
 #endif
 		};
 
@@ -261,6 +282,11 @@ enum {
 	FUSE_I_IOMAP,
 	/* Enable untorn writes */
 	FUSE_I_ATOMIC,
+	/*
+	 * Cache iomaps in the kernel.  This is required for any filesystem
+	 * that needs to synchronize pagecache write and writeback.
+	 */
+	FUSE_I_IOMAP_CACHE,
 };
 
 struct fuse_conn;
@@ -1816,6 +1842,18 @@ int fuse_iomap_dev_inval(struct fuse_conn *fc,
 			 const struct fuse_iomap_dev_inval_out *arg);
 
 int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
+
+static inline bool fuse_inode_caches_iomaps(const struct inode *inode)
+{
+	const struct fuse_inode *fi = get_fuse_inode_c(inode);
+
+	return test_bit(FUSE_I_IOMAP_CACHE, &fi->state);
+}
+
+enum fuse_iomap_iodir {
+	READ_MAPPING,
+	WRITE_MAPPING,
+};
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -1842,6 +1880,7 @@ int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
 # define fuse_iomap_dev_inval(...)		(-ENOSYS)
 # define fuse_iomap_fadvise			NULL
+# define fuse_inode_caches_iomaps(...)		(false)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/iomap_priv.h b/fs/fuse/iomap_priv.h
index 7002eb38f87fe1..8e4a32879025a4 100644
--- a/fs/fuse/iomap_priv.h
+++ b/fs/fuse/iomap_priv.h
@@ -1,5 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * The fuse_iext code comes from xfs_iext_tree.[ch] and is:
+ * Copyright (c) 2017 Christoph Hellwig.
+ *
+ * Everything else is:
  * Copyright (C) 2025 Oracle.  All Rights Reserved.
  * Author: Darrick J. Wong <djwong@kernel.org>
  */
@@ -40,13 +44,134 @@ while (static_branch_unlikely(&fuse_iomap_debug)) {			\
 })
 #endif /* CONFIG_FUSE_IOMAP_DEBUG */
 
-enum fuse_iomap_iodir {
-	READ_MAPPING,
-	WRITE_MAPPING,
-};
-
 #define EFSCORRUPTED	EUCLEAN
 
+void fuse_iomap_cache_lock(struct inode *inode);
+void fuse_iomap_cache_unlock(struct inode *inode);
+void fuse_iomap_cache_lock_shared(struct inode *inode);
+void fuse_iomap_cache_unlock_shared(struct inode *inode);
+
+struct fuse_iext_leaf;
+
+struct fuse_iext_cursor {
+	struct fuse_iext_leaf	*leaf;
+	int			pos;
+};
+
+#define FUSE_IEXT_LEFT_CONTIG	(1u << 0)
+#define FUSE_IEXT_RIGHT_CONTIG	(1u << 1)
+#define FUSE_IEXT_LEFT_FILLING	(1u << 2)
+#define FUSE_IEXT_RIGHT_FILLING	(1u << 3)
+#define FUSE_IEXT_LEFT_VALID	(1u << 4)
+#define FUSE_IEXT_RIGHT_VALID	(1u << 5)
+#define FUSE_IEXT_WRITE_MAPPING	(1u << 6)
+
+struct fuse_ifork *fuse_iext_state_to_fork(struct fuse_iomap_cache *ip,
+		unsigned int state);
+
+uint64_t	fuse_iext_count(const struct fuse_ifork *ifp);
+void		fuse_iext_insert_raw(struct fuse_iomap_cache *ip,
+			struct fuse_ifork *ifp,
+			struct fuse_iext_cursor *cur,
+			const struct fuse_iomap_io *irec);
+void		fuse_iext_insert(struct fuse_iomap_cache *,
+			struct fuse_iext_cursor *cur,
+			const struct fuse_iomap_io *, int);
+void		fuse_iext_remove(struct fuse_iomap_cache *,
+			struct fuse_iext_cursor *,
+			int);
+void		fuse_iext_destroy(struct fuse_ifork *);
+
+bool		fuse_iext_lookup_extent(struct fuse_iomap_cache *ip,
+			struct fuse_ifork *ifp, loff_t bno,
+			struct fuse_iext_cursor *cur,
+			struct fuse_iomap_io *gotp);
+bool		fuse_iext_lookup_extent_before(struct fuse_iomap_cache *ip,
+			struct fuse_ifork *ifp, loff_t *end,
+			struct fuse_iext_cursor *cur,
+			struct fuse_iomap_io *gotp);
+bool		fuse_iext_get_extent(const struct fuse_ifork *ifp,
+			const struct fuse_iext_cursor *cur,
+			struct fuse_iomap_io *gotp);
+void		fuse_iext_update_extent(struct fuse_iomap_cache *ip, int state,
+			struct fuse_iext_cursor *cur,
+			struct fuse_iomap_io *gotp);
+
+void		fuse_iext_first(struct fuse_ifork *, struct fuse_iext_cursor *);
+void		fuse_iext_last(struct fuse_ifork *, struct fuse_iext_cursor *);
+void		fuse_iext_next(struct fuse_ifork *, struct fuse_iext_cursor *);
+void		fuse_iext_prev(struct fuse_ifork *, struct fuse_iext_cursor *);
+
+static inline bool fuse_iext_next_extent(struct fuse_ifork *ifp,
+		struct fuse_iext_cursor *cur, struct fuse_iomap_io *gotp)
+{
+	fuse_iext_next(ifp, cur);
+	return fuse_iext_get_extent(ifp, cur, gotp);
+}
+
+static inline bool fuse_iext_prev_extent(struct fuse_ifork *ifp,
+		struct fuse_iext_cursor *cur, struct fuse_iomap_io *gotp)
+{
+	fuse_iext_prev(ifp, cur);
+	return fuse_iext_get_extent(ifp, cur, gotp);
+}
+
+/*
+ * Return the extent after cur in gotp without updating the cursor.
+ */
+static inline bool fuse_iext_peek_next_extent(struct fuse_ifork *ifp,
+		struct fuse_iext_cursor *cur, struct fuse_iomap_io *gotp)
+{
+	struct fuse_iext_cursor ncur = *cur;
+
+	fuse_iext_next(ifp, &ncur);
+	return fuse_iext_get_extent(ifp, &ncur, gotp);
+}
+
+/*
+ * Return the extent before cur in gotp without updating the cursor.
+ */
+static inline bool fuse_iext_peek_prev_extent(struct fuse_ifork *ifp,
+		struct fuse_iext_cursor *cur, struct fuse_iomap_io *gotp)
+{
+	struct fuse_iext_cursor ncur = *cur;
+
+	fuse_iext_prev(ifp, &ncur);
+	return fuse_iext_get_extent(ifp, &ncur, gotp);
+}
+
+#define for_each_fuse_iext(ifp, ext, got)		\
+	for (fuse_iext_first((ifp), (ext));		\
+	     fuse_iext_get_extent((ifp), (ext), (got));	\
+	     fuse_iext_next((ifp), (ext)))
+
+static inline uint64_t fuse_iext_read_seq(struct fuse_iomap_cache *ip)
+{
+	return (uint64_t)READ_ONCE(ip->im_seq);
+}
+
+int fuse_iomap_cache_remove(struct inode *inode, enum fuse_iomap_iodir iodir,
+			    loff_t off, uint64_t len);
+
+int fuse_iomap_cache_upsert(struct inode *inode, enum fuse_iomap_iodir iodir,
+			    const struct fuse_iomap_io *map);
+
+enum fuse_iomap_lookup_result {
+	LOOKUP_HIT,
+	LOOKUP_MISS,
+	LOOKUP_NOFORK,
+};
+
+struct fuse_iomap_lookup {
+	struct fuse_iomap_io	map;		 /* cached mapping */
+	uint64_t		validity_cookie; /* used with .iomap_valid() */
+};
+
+enum fuse_iomap_lookup_result
+fuse_iomap_cache_lookup(struct inode *inode, enum fuse_iomap_iodir iodir,
+			loff_t off, uint64_t len,
+			struct fuse_iomap_lookup *mval);
+
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_PRIV_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 94ec220beb5f79..d4a257517915fd 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1358,6 +1358,8 @@ struct fuse_uring_cmd_req {
 
 /* fuse-specific mapping type indicating that writes use the read mapping */
 #define FUSE_IOMAP_TYPE_PURE_OVERWRITE	(255)
+/* fuse-specific mapping type saying the server has populated the cache */
+#define FUSE_IOMAP_TYPE_RETRY_CACHE	(254)
 
 #define FUSE_IOMAP_DEV_NULL		(0U)	/* null device cookie */
 
@@ -1500,4 +1502,7 @@ struct fuse_iomap_dev_inval_out {
 	uint64_t length;
 };
 
+/* invalidate all cached iomap mappings up to EOF */
+#define FUSE_IOMAP_INVAL_TO_EOF		(~0ULL)
+
 #endif /* _LINUX_FUSE_H */
diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 27be39317701d6..e3ed1da6cfb6e7 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -18,6 +18,6 @@ fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o
 fuse-$(CONFIG_FUSE_BACKING) += backing.o
 fuse-$(CONFIG_SYSCTL) += sysctl.o
 fuse-$(CONFIG_FUSE_IO_URING) += dev_uring.o
-fuse-$(CONFIG_FUSE_IOMAP) += file_iomap.o
+fuse-$(CONFIG_FUSE_IOMAP) += file_iomap.o iomap_cache.o
 
 virtiofs-y := virtio_fs.o
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 1fc9a9b7b75094..d35e69d03b0940 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -1123,6 +1123,21 @@ static inline void fuse_inode_clear_atomic(struct inode *inode)
 	clear_bit(FUSE_I_ATOMIC, &fi->state);
 }
 
+static inline void fuse_iomap_clear_cache(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	clear_bit(FUSE_I_IOMAP_CACHE, &fi->state);
+
+	fuse_iext_destroy(&fi->cache.im_read);
+	if (fi->cache.im_write) {
+		fuse_iext_destroy(fi->cache.im_write);
+		kfree(fi->cache.im_write);
+	}
+}
+
 void fuse_iomap_init_inode(struct inode *inode, unsigned attr_flags)
 {
 	struct fuse_conn *conn = get_fuse_conn(inode);
@@ -1139,6 +1154,8 @@ void fuse_iomap_evict_inode(struct inode *inode)
 {
 	trace_fuse_iomap_evict_inode(inode);
 
+	if (fuse_inode_caches_iomaps(inode))
+		fuse_iomap_clear_cache(inode);
 	if (fuse_inode_has_atomic(inode))
 		fuse_inode_clear_atomic(inode);
 	if (fuse_inode_has_iomap(inode))
@@ -1785,6 +1802,12 @@ static inline void fuse_inode_set_iomap(struct inode *inode)
 		min_order = inode->i_blkbits - PAGE_SHIFT;
 
 	mapping_set_folio_min_order(inode->i_mapping, min_order);
+
+	memset(&fi->cache.im_read, 0, sizeof(fi->cache.im_read));
+	fi->cache.im_seq = 0;
+	fi->cache.im_write = NULL;
+
+	init_rwsem(&fi->cache.im_lock);
 	set_bit(FUSE_I_IOMAP, &fi->state);
 }
 
diff --git a/fs/fuse/iomap_cache.c b/fs/fuse/iomap_cache.c
new file mode 100644
index 00000000000000..1fec9dcc6d3922
--- /dev/null
+++ b/fs/fuse/iomap_cache.c
@@ -0,0 +1,1629 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * fuse_iext* code adapted from xfs_iext_tree.c:
+ * Copyright (c) 2017 Christoph Hellwig.
+ *
+ * fuse_iomap_cache*lock* code adapted from xfs_inode.c:
+ * Copyright (c) 2000-2006 Silicon Graphics, Inc.
+ * All Rights Reserved.
+ *
+ * Copyright (C) 2025 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#include "fuse_i.h"
+#include "iomap_priv.h"
+#include "fuse_trace.h"
+#include <linux/iomap.h>
+
+/* maximum length of a mapping that we're willing to cache */
+#define FUSE_IOMAP_MAX_LEN	((loff_t)(1ULL << 63))
+
+void fuse_iomap_cache_lock_shared(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_iomap_cache *ip = &fi->cache;
+
+	down_read(&ip->im_lock);
+}
+
+void fuse_iomap_cache_unlock_shared(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_iomap_cache *ip = &fi->cache;
+
+	up_read(&ip->im_lock);
+}
+
+void fuse_iomap_cache_lock(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_iomap_cache *ip = &fi->cache;
+
+	down_write(&ip->im_lock);
+}
+
+void fuse_iomap_cache_unlock(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_iomap_cache *ip = &fi->cache;
+
+	up_write(&ip->im_lock);
+}
+
+static inline void assert_cache_locked_shared(struct fuse_iomap_cache *ip)
+{
+	rwsem_assert_held(&ip->im_lock);
+}
+
+static inline void assert_cache_locked(struct fuse_iomap_cache *ip)
+{
+	rwsem_assert_held_write_nolockdep(&ip->im_lock);
+}
+
+static inline struct fuse_inode *FUSE_I(struct fuse_iomap_cache *ip)
+{
+	return container_of(ip, struct fuse_inode, cache);
+}
+
+static inline struct inode *VFS_I(struct fuse_iomap_cache *ip)
+{
+	struct fuse_inode *fi = FUSE_I(ip);
+
+	return &fi->inode;
+}
+
+static inline uint32_t
+fuse_iomap_fork_to_state(const struct fuse_iomap_cache *ip,
+			 const struct fuse_ifork *ifp)
+{
+	ASSERT(ifp == ip->im_write || ifp == &ip->im_read);
+
+	if (ifp == ip->im_write)
+		return FUSE_IEXT_WRITE_MAPPING;
+	return 0;
+}
+
+/* Convert bmap state flags to an inode fork. */
+struct fuse_ifork *
+fuse_iext_state_to_fork(
+	struct fuse_iomap_cache	*ip,
+	unsigned int		state)
+{
+	if (state & FUSE_IEXT_WRITE_MAPPING)
+		return ip->im_write;
+	return &ip->im_read;
+}
+
+/* The internal iext tree record is a struct fuse_iomap_io */
+
+static bool fuse_iext_rec_is_empty(const struct fuse_iomap_io *rec)
+{
+	return rec->length == 0;
+}
+
+static inline void fuse_iext_rec_clear(struct fuse_iomap_io *rec)
+{
+	memset(rec, 0, sizeof(*rec));
+}
+
+static void
+fuse_iext_set(
+	struct fuse_iomap_io		*rec,
+	const struct fuse_iomap_io	*irec)
+{
+	ASSERT(irec->length > 0);
+
+	*rec = *irec;
+}
+
+static void
+fuse_iext_get(
+	struct fuse_iomap_io		*irec,
+	const struct fuse_iomap_io	*rec)
+{
+	*irec = *rec;
+}
+
+enum {
+	NODE_SIZE	= 256,
+	KEYS_PER_NODE	= NODE_SIZE / (sizeof(uint64_t) + sizeof(void *)),
+	RECS_PER_LEAF	= (NODE_SIZE - (2 * sizeof(struct fuse_iext_leaf *))) /
+				sizeof(struct fuse_iomap_io),
+};
+
+/*
+ * In-core extent btree block layout:
+ *
+ * There are two types of blocks in the btree: leaf and inner (non-leaf) blocks.
+ *
+ * The leaf blocks are made up by %KEYS_PER_NODE extent records, which each
+ * contain the startoffset, blockcount, startblock and unwritten extent flag.
+ * See above for the exact format, followed by pointers to the previous and next
+ * leaf blocks (if there are any).
+ *
+ * The inner (non-leaf) blocks first contain KEYS_PER_NODE lookup keys, followed
+ * by an equal number of pointers to the btree blocks at the next lower level.
+ *
+ *		+-------+-------+-------+-------+-------+----------+----------+
+ * Leaf:	| rec 1 | rec 2 | rec 3 | rec 4 | rec N | prev-ptr | next-ptr |
+ *		+-------+-------+-------+-------+-------+----------+----------+
+ *
+ *		+-------+-------+-------+-------+-------+-------+------+-------+
+ * Inner:	| key 1 | key 2 | key 3 | key N | ptr 1 | ptr 2 | ptr3 | ptr N |
+ *		+-------+-------+-------+-------+-------+-------+------+-------+
+ */
+struct fuse_iext_node {
+	uint64_t		keys[KEYS_PER_NODE];
+#define FUSE_IEXT_KEY_INVALID	(1ULL << 63)
+	void			*ptrs[KEYS_PER_NODE];
+};
+
+struct fuse_iext_leaf {
+	struct fuse_iomap_io	recs[RECS_PER_LEAF];
+	struct fuse_iext_leaf	*prev;
+	struct fuse_iext_leaf	*next;
+};
+
+inline uint64_t fuse_iext_count(const struct fuse_ifork *ifp)
+{
+	return ifp->if_bytes / sizeof(struct fuse_iomap_io);
+}
+
+static inline int fuse_iext_max_recs(const struct fuse_ifork *ifp)
+{
+	if (ifp->if_height == 1)
+		return fuse_iext_count(ifp);
+	return RECS_PER_LEAF;
+}
+
+static inline struct fuse_iomap_io *cur_rec(const struct fuse_iext_cursor *cur)
+{
+	return &cur->leaf->recs[cur->pos];
+}
+
+static inline bool fuse_iext_valid(const struct fuse_ifork *ifp,
+				   const struct fuse_iext_cursor *cur)
+{
+	if (!cur->leaf)
+		return false;
+	if (cur->pos < 0 || cur->pos >= fuse_iext_max_recs(ifp))
+		return false;
+	if (fuse_iext_rec_is_empty(cur_rec(cur)))
+		return false;
+	return true;
+}
+
+static void *
+fuse_iext_find_first_leaf(
+	struct fuse_ifork	*ifp)
+{
+	struct fuse_iext_node	*node = ifp->if_data;
+	int			height;
+
+	if (!ifp->if_height)
+		return NULL;
+
+	for (height = ifp->if_height; height > 1; height--) {
+		node = node->ptrs[0];
+		ASSERT(node);
+	}
+
+	return node;
+}
+
+static void *
+fuse_iext_find_last_leaf(
+	struct fuse_ifork	*ifp)
+{
+	struct fuse_iext_node	*node = ifp->if_data;
+	int			height, i;
+
+	if (!ifp->if_height)
+		return NULL;
+
+	for (height = ifp->if_height; height > 1; height--) {
+		for (i = 1; i < KEYS_PER_NODE; i++)
+			if (!node->ptrs[i])
+				break;
+		node = node->ptrs[i - 1];
+		ASSERT(node);
+	}
+
+	return node;
+}
+
+void
+fuse_iext_first(
+	struct fuse_ifork	*ifp,
+	struct fuse_iext_cursor	*cur)
+{
+	cur->pos = 0;
+	cur->leaf = fuse_iext_find_first_leaf(ifp);
+}
+
+void
+fuse_iext_last(
+	struct fuse_ifork	*ifp,
+	struct fuse_iext_cursor	*cur)
+{
+	int			i;
+
+	cur->leaf = fuse_iext_find_last_leaf(ifp);
+	if (!cur->leaf) {
+		cur->pos = 0;
+		return;
+	}
+
+	for (i = 1; i < fuse_iext_max_recs(ifp); i++) {
+		if (fuse_iext_rec_is_empty(&cur->leaf->recs[i]))
+			break;
+	}
+	cur->pos = i - 1;
+}
+
+void
+fuse_iext_next(
+	struct fuse_ifork	*ifp,
+	struct fuse_iext_cursor	*cur)
+{
+	if (!cur->leaf) {
+		ASSERT(cur->pos <= 0 || cur->pos >= RECS_PER_LEAF);
+		fuse_iext_first(ifp, cur);
+		return;
+	}
+
+	ASSERT(cur->pos >= 0);
+	ASSERT(cur->pos < fuse_iext_max_recs(ifp));
+
+	cur->pos++;
+	if (ifp->if_height > 1 && !fuse_iext_valid(ifp, cur) &&
+	    cur->leaf->next) {
+		cur->leaf = cur->leaf->next;
+		cur->pos = 0;
+	}
+}
+
+void
+fuse_iext_prev(
+	struct fuse_ifork	*ifp,
+	struct fuse_iext_cursor	*cur)
+{
+	if (!cur->leaf) {
+		ASSERT(cur->pos <= 0 || cur->pos >= RECS_PER_LEAF);
+		fuse_iext_last(ifp, cur);
+		return;
+	}
+
+	ASSERT(cur->pos >= 0);
+	ASSERT(cur->pos <= RECS_PER_LEAF);
+
+recurse:
+	do {
+		cur->pos--;
+		if (fuse_iext_valid(ifp, cur))
+			return;
+	} while (cur->pos > 0);
+
+	if (ifp->if_height > 1 && cur->leaf->prev) {
+		cur->leaf = cur->leaf->prev;
+		cur->pos = RECS_PER_LEAF;
+		goto recurse;
+	}
+}
+
+static inline int
+fuse_iext_key_cmp(
+	struct fuse_iext_node	*node,
+	int			n,
+	loff_t			offset)
+{
+	if (node->keys[n] > offset)
+		return 1;
+	if (node->keys[n] < offset)
+		return -1;
+	return 0;
+}
+
+static inline int
+fuse_iext_rec_cmp(
+	struct fuse_iomap_io	*rec,
+	loff_t			offset)
+{
+	if (rec->offset > offset)
+		return 1;
+	if (rec->offset + rec->length <= offset)
+		return -1;
+	return 0;
+}
+
+static void *
+fuse_iext_find_level(
+	struct fuse_ifork	*ifp,
+	loff_t			offset,
+	int			level)
+{
+	struct fuse_iext_node	*node = ifp->if_data;
+	int			height, i;
+
+	if (!ifp->if_height)
+		return NULL;
+
+	for (height = ifp->if_height; height > level; height--) {
+		for (i = 1; i < KEYS_PER_NODE; i++)
+			if (fuse_iext_key_cmp(node, i, offset) > 0)
+				break;
+
+		node = node->ptrs[i - 1];
+		if (!node)
+			break;
+	}
+
+	return node;
+}
+
+static int
+fuse_iext_node_pos(
+	struct fuse_iext_node	*node,
+	loff_t			offset)
+{
+	int			i;
+
+	for (i = 1; i < KEYS_PER_NODE; i++) {
+		if (fuse_iext_key_cmp(node, i, offset) > 0)
+			break;
+	}
+
+	return i - 1;
+}
+
+static int
+fuse_iext_node_insert_pos(
+	struct fuse_iext_node	*node,
+	loff_t			offset)
+{
+	int			i;
+
+	for (i = 0; i < KEYS_PER_NODE; i++) {
+		if (fuse_iext_key_cmp(node, i, offset) > 0)
+			return i;
+	}
+
+	return KEYS_PER_NODE;
+}
+
+static int
+fuse_iext_node_nr_entries(
+	struct fuse_iext_node	*node,
+	int			start)
+{
+	int			i;
+
+	for (i = start; i < KEYS_PER_NODE; i++) {
+		if (node->keys[i] == FUSE_IEXT_KEY_INVALID)
+			break;
+	}
+
+	return i;
+}
+
+static int
+fuse_iext_leaf_nr_entries(
+	struct fuse_ifork	*ifp,
+	struct fuse_iext_leaf	*leaf,
+	int			start)
+{
+	int			i;
+
+	for (i = start; i < fuse_iext_max_recs(ifp); i++) {
+		if (fuse_iext_rec_is_empty(&leaf->recs[i]))
+			break;
+	}
+
+	return i;
+}
+
+static inline uint64_t
+fuse_iext_leaf_key(
+	struct fuse_iext_leaf	*leaf,
+	int			n)
+{
+	return leaf->recs[n].offset;
+}
+
+static inline void *
+fuse_iext_alloc_node(
+	int	size)
+{
+	return kzalloc(size, GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOFAIL);
+}
+
+static void
+fuse_iext_grow(
+	struct fuse_ifork	*ifp)
+{
+	struct fuse_iext_node	*node = fuse_iext_alloc_node(NODE_SIZE);
+	int			i;
+
+	if (ifp->if_height == 1) {
+		struct fuse_iext_leaf *prev = ifp->if_data;
+
+		node->keys[0] = fuse_iext_leaf_key(prev, 0);
+		node->ptrs[0] = prev;
+	} else  {
+		struct fuse_iext_node *prev = ifp->if_data;
+
+		ASSERT(ifp->if_height > 1);
+
+		node->keys[0] = prev->keys[0];
+		node->ptrs[0] = prev;
+	}
+
+	for (i = 1; i < KEYS_PER_NODE; i++)
+		node->keys[i] = FUSE_IEXT_KEY_INVALID;
+
+	ifp->if_data = node;
+	ifp->if_height++;
+}
+
+static void
+fuse_iext_update_node(
+	struct fuse_ifork	*ifp,
+	loff_t			old_offset,
+	loff_t			new_offset,
+	int			level,
+	void			*ptr)
+{
+	struct fuse_iext_node	*node = ifp->if_data;
+	int			height, i;
+
+	for (height = ifp->if_height; height > level; height--) {
+		for (i = 0; i < KEYS_PER_NODE; i++) {
+			if (i > 0 && fuse_iext_key_cmp(node, i, old_offset) > 0)
+				break;
+			if (node->keys[i] == old_offset)
+				node->keys[i] = new_offset;
+		}
+		node = node->ptrs[i - 1];
+		ASSERT(node);
+	}
+
+	ASSERT(node == ptr);
+}
+
+static struct fuse_iext_node *
+fuse_iext_split_node(
+	struct fuse_iext_node	**nodep,
+	int			*pos,
+	int			*nr_entries)
+{
+	struct fuse_iext_node	*node = *nodep;
+	struct fuse_iext_node	*new = fuse_iext_alloc_node(NODE_SIZE);
+	const int		nr_move = KEYS_PER_NODE / 2;
+	int			nr_keep = nr_move + (KEYS_PER_NODE & 1);
+	int			i = 0;
+
+	/* for sequential append operations just spill over into the new node */
+	if (*pos == KEYS_PER_NODE) {
+		*nodep = new;
+		*pos = 0;
+		*nr_entries = 0;
+		goto done;
+	}
+
+
+	for (i = 0; i < nr_move; i++) {
+		new->keys[i] = node->keys[nr_keep + i];
+		new->ptrs[i] = node->ptrs[nr_keep + i];
+
+		node->keys[nr_keep + i] = FUSE_IEXT_KEY_INVALID;
+		node->ptrs[nr_keep + i] = NULL;
+	}
+
+	if (*pos >= nr_keep) {
+		*nodep = new;
+		*pos -= nr_keep;
+		*nr_entries = nr_move;
+	} else {
+		*nr_entries = nr_keep;
+	}
+done:
+	for (; i < KEYS_PER_NODE; i++)
+		new->keys[i] = FUSE_IEXT_KEY_INVALID;
+	return new;
+}
+
+static void
+fuse_iext_insert_node(
+	struct fuse_ifork	*ifp,
+	uint64_t		offset,
+	void			*ptr,
+	int			level)
+{
+	struct fuse_iext_node	*node, *new;
+	int			i, pos, nr_entries;
+
+again:
+	if (ifp->if_height < level)
+		fuse_iext_grow(ifp);
+
+	new = NULL;
+	node = fuse_iext_find_level(ifp, offset, level);
+	pos = fuse_iext_node_insert_pos(node, offset);
+	nr_entries = fuse_iext_node_nr_entries(node, pos);
+
+	ASSERT(pos >= nr_entries || fuse_iext_key_cmp(node, pos, offset) != 0);
+	ASSERT(nr_entries <= KEYS_PER_NODE);
+
+	if (nr_entries == KEYS_PER_NODE)
+		new = fuse_iext_split_node(&node, &pos, &nr_entries);
+
+	/*
+	 * Update the pointers in higher levels if the first entry changes
+	 * in an existing node.
+	 */
+	if (node != new && pos == 0 && nr_entries > 0)
+		fuse_iext_update_node(ifp, node->keys[0], offset, level, node);
+
+	for (i = nr_entries; i > pos; i--) {
+		node->keys[i] = node->keys[i - 1];
+		node->ptrs[i] = node->ptrs[i - 1];
+	}
+	node->keys[pos] = offset;
+	node->ptrs[pos] = ptr;
+
+	if (new) {
+		offset = new->keys[0];
+		ptr = new;
+		level++;
+		goto again;
+	}
+}
+
+static struct fuse_iext_leaf *
+fuse_iext_split_leaf(
+	struct fuse_iext_cursor	*cur,
+	int			*nr_entries)
+{
+	struct fuse_iext_leaf	*leaf = cur->leaf;
+	struct fuse_iext_leaf	*new = fuse_iext_alloc_node(NODE_SIZE);
+	const int		nr_move = RECS_PER_LEAF / 2;
+	int			nr_keep = nr_move + (RECS_PER_LEAF & 1);
+	int			i;
+
+	/* for sequential append operations just spill over into the new node */
+	if (cur->pos == RECS_PER_LEAF) {
+		cur->leaf = new;
+		cur->pos = 0;
+		*nr_entries = 0;
+		goto done;
+	}
+
+	for (i = 0; i < nr_move; i++) {
+		new->recs[i] = leaf->recs[nr_keep + i];
+		fuse_iext_rec_clear(&leaf->recs[nr_keep + i]);
+	}
+
+	if (cur->pos >= nr_keep) {
+		cur->leaf = new;
+		cur->pos -= nr_keep;
+		*nr_entries = nr_move;
+	} else {
+		*nr_entries = nr_keep;
+	}
+done:
+	if (leaf->next)
+		leaf->next->prev = new;
+	new->next = leaf->next;
+	new->prev = leaf;
+	leaf->next = new;
+	return new;
+}
+
+static void
+fuse_iext_alloc_root(
+	struct fuse_ifork	*ifp,
+	struct fuse_iext_cursor	*cur)
+{
+	ASSERT(ifp->if_bytes == 0);
+
+	ifp->if_data = fuse_iext_alloc_node(sizeof(struct fuse_iomap_io));
+	ifp->if_height = 1;
+
+	/* now that we have a node step into it */
+	cur->leaf = ifp->if_data;
+	cur->pos = 0;
+}
+
+static void
+fuse_iext_realloc_root(
+	struct fuse_ifork	*ifp,
+	struct fuse_iext_cursor	*cur)
+{
+	int64_t new_size = ifp->if_bytes + sizeof(struct fuse_iomap_io);
+	void *new;
+
+	/* account for the prev/next pointers */
+	if (new_size / sizeof(struct fuse_iomap_io) == RECS_PER_LEAF)
+		new_size = NODE_SIZE;
+
+	new = krealloc(ifp->if_data, new_size,
+			GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOFAIL);
+	memset(new + ifp->if_bytes, 0, new_size - ifp->if_bytes);
+	ifp->if_data = new;
+	cur->leaf = new;
+}
+
+/*
+ * Increment the sequence counter on extent tree changes. We use WRITE_ONCE
+ * here to ensure the update to the sequence counter is seen before the
+ * modifications to the extent tree itself take effect.
+ */
+static inline void fuse_iext_inc_seq(struct fuse_iomap_cache *ip)
+{
+	WRITE_ONCE(ip->im_seq, READ_ONCE(ip->im_seq) + 1);
+}
+
+void
+fuse_iext_insert_raw(
+	struct fuse_iomap_cache		*ip,
+	struct fuse_ifork		*ifp,
+	struct fuse_iext_cursor		*cur,
+	const struct fuse_iomap_io	*irec)
+{
+	loff_t				offset = irec->offset;
+	struct fuse_iext_leaf		*new = NULL;
+	int				nr_entries, i;
+
+	fuse_iext_inc_seq(ip);
+
+	if (ifp->if_height == 0)
+		fuse_iext_alloc_root(ifp, cur);
+	else if (ifp->if_height == 1)
+		fuse_iext_realloc_root(ifp, cur);
+
+	nr_entries = fuse_iext_leaf_nr_entries(ifp, cur->leaf, cur->pos);
+	ASSERT(nr_entries <= RECS_PER_LEAF);
+	ASSERT(cur->pos >= nr_entries ||
+	       fuse_iext_rec_cmp(cur_rec(cur), irec->offset) != 0);
+
+	if (nr_entries == RECS_PER_LEAF)
+		new = fuse_iext_split_leaf(cur, &nr_entries);
+
+	/*
+	 * Update the pointers in higher levels if the first entry changes
+	 * in an existing node.
+	 */
+	if (cur->leaf != new && cur->pos == 0 && nr_entries > 0) {
+		fuse_iext_update_node(ifp, fuse_iext_leaf_key(cur->leaf, 0),
+				offset, 1, cur->leaf);
+	}
+
+	for (i = nr_entries; i > cur->pos; i--)
+		cur->leaf->recs[i] = cur->leaf->recs[i - 1];
+	fuse_iext_set(cur_rec(cur), irec);
+	ifp->if_bytes += sizeof(struct fuse_iomap_io);
+
+	if (new)
+		fuse_iext_insert_node(ifp, fuse_iext_leaf_key(new, 0), new, 2);
+}
+
+void
+fuse_iext_insert(
+	struct fuse_iomap_cache		*ip,
+	struct fuse_iext_cursor		*cur,
+	const struct fuse_iomap_io	*irec,
+	int				state)
+{
+	struct fuse_ifork		*ifp = fuse_iext_state_to_fork(ip, state);
+
+	fuse_iext_insert_raw(ip, ifp, cur, irec);
+}
+
+static struct fuse_iext_node *
+fuse_iext_rebalance_node(
+	struct fuse_iext_node	*parent,
+	int			*pos,
+	struct fuse_iext_node	*node,
+	int			nr_entries)
+{
+	/*
+	 * If the neighbouring nodes are completely full, or have different
+	 * parents, we might never be able to merge our node, and will only
+	 * delete it once the number of entries hits zero.
+	 */
+	if (nr_entries == 0)
+		return node;
+
+	if (*pos > 0) {
+		struct fuse_iext_node *prev = parent->ptrs[*pos - 1];
+		int nr_prev = fuse_iext_node_nr_entries(prev, 0), i;
+
+		if (nr_prev + nr_entries <= KEYS_PER_NODE) {
+			for (i = 0; i < nr_entries; i++) {
+				prev->keys[nr_prev + i] = node->keys[i];
+				prev->ptrs[nr_prev + i] = node->ptrs[i];
+			}
+			return node;
+		}
+	}
+
+	if (*pos + 1 < fuse_iext_node_nr_entries(parent, *pos)) {
+		struct fuse_iext_node *next = parent->ptrs[*pos + 1];
+		int nr_next = fuse_iext_node_nr_entries(next, 0), i;
+
+		if (nr_entries + nr_next <= KEYS_PER_NODE) {
+			/*
+			 * Merge the next node into this node so that we don't
+			 * have to do an additional update of the keys in the
+			 * higher levels.
+			 */
+			for (i = 0; i < nr_next; i++) {
+				node->keys[nr_entries + i] = next->keys[i];
+				node->ptrs[nr_entries + i] = next->ptrs[i];
+			}
+
+			++*pos;
+			return next;
+		}
+	}
+
+	return NULL;
+}
+
+static void
+fuse_iext_remove_node(
+	struct fuse_ifork	*ifp,
+	loff_t			offset,
+	void			*victim)
+{
+	struct fuse_iext_node	*node, *parent;
+	int			level = 2, pos, nr_entries, i;
+
+	ASSERT(level <= ifp->if_height);
+	node = fuse_iext_find_level(ifp, offset, level);
+	pos = fuse_iext_node_pos(node, offset);
+again:
+	ASSERT(node->ptrs[pos]);
+	ASSERT(node->ptrs[pos] == victim);
+	kfree(victim);
+
+	nr_entries = fuse_iext_node_nr_entries(node, pos) - 1;
+	offset = node->keys[0];
+	for (i = pos; i < nr_entries; i++) {
+		node->keys[i] = node->keys[i + 1];
+		node->ptrs[i] = node->ptrs[i + 1];
+	}
+	node->keys[nr_entries] = FUSE_IEXT_KEY_INVALID;
+	node->ptrs[nr_entries] = NULL;
+
+	if (pos == 0 && nr_entries > 0) {
+		fuse_iext_update_node(ifp, offset, node->keys[0], level, node);
+		offset = node->keys[0];
+	}
+
+	if (nr_entries >= KEYS_PER_NODE / 2)
+		return;
+
+	if (level < ifp->if_height) {
+		/*
+		 * If we aren't at the root yet try to find a neighbour node to
+		 * merge with (or delete the node if it is empty), and then
+		 * recurse up to the next level.
+		 */
+		level++;
+		parent = fuse_iext_find_level(ifp, offset, level);
+		pos = fuse_iext_node_pos(parent, offset);
+
+		ASSERT(pos != KEYS_PER_NODE);
+		ASSERT(parent->ptrs[pos] == node);
+
+		node = fuse_iext_rebalance_node(parent, &pos, node, nr_entries);
+		if (node) {
+			victim = node;
+			node = parent;
+			goto again;
+		}
+	} else if (nr_entries == 1) {
+		/*
+		 * If we are at the root and only one entry is left we can just
+		 * free this node and update the root pointer.
+		 */
+		ASSERT(node == ifp->if_data);
+		ifp->if_data = node->ptrs[0];
+		ifp->if_height--;
+		kfree(node);
+	}
+}
+
+static void
+fuse_iext_rebalance_leaf(
+	struct fuse_ifork	*ifp,
+	struct fuse_iext_cursor	*cur,
+	struct fuse_iext_leaf	*leaf,
+	loff_t			offset,
+	int			nr_entries)
+{
+	/*
+	 * If the neighbouring nodes are completely full we might never be able
+	 * to merge our node, and will only delete it once the number of
+	 * entries hits zero.
+	 */
+	if (nr_entries == 0)
+		goto remove_node;
+
+	if (leaf->prev) {
+		int nr_prev = fuse_iext_leaf_nr_entries(ifp, leaf->prev, 0), i;
+
+		if (nr_prev + nr_entries <= RECS_PER_LEAF) {
+			for (i = 0; i < nr_entries; i++)
+				leaf->prev->recs[nr_prev + i] = leaf->recs[i];
+
+			if (cur->leaf == leaf) {
+				cur->leaf = leaf->prev;
+				cur->pos += nr_prev;
+			}
+			goto remove_node;
+		}
+	}
+
+	if (leaf->next) {
+		int nr_next = fuse_iext_leaf_nr_entries(ifp, leaf->next, 0), i;
+
+		if (nr_entries + nr_next <= RECS_PER_LEAF) {
+			/*
+			 * Merge the next node into this node so that we don't
+			 * have to do an additional update of the keys in the
+			 * higher levels.
+			 */
+			for (i = 0; i < nr_next; i++) {
+				leaf->recs[nr_entries + i] =
+					leaf->next->recs[i];
+			}
+
+			if (cur->leaf == leaf->next) {
+				cur->leaf = leaf;
+				cur->pos += nr_entries;
+			}
+
+			offset = fuse_iext_leaf_key(leaf->next, 0);
+			leaf = leaf->next;
+			goto remove_node;
+		}
+	}
+
+	return;
+remove_node:
+	if (leaf->prev)
+		leaf->prev->next = leaf->next;
+	if (leaf->next)
+		leaf->next->prev = leaf->prev;
+	fuse_iext_remove_node(ifp, offset, leaf);
+}
+
+static void
+fuse_iext_free_last_leaf(
+	struct fuse_ifork	*ifp)
+{
+	ifp->if_height--;
+	kfree(ifp->if_data);
+	ifp->if_data = NULL;
+}
+
+void
+fuse_iext_remove(
+	struct fuse_iomap_cache	*ip,
+	struct fuse_iext_cursor	*cur,
+	int			state)
+{
+	struct fuse_ifork	*ifp = fuse_iext_state_to_fork(ip, state);
+	struct fuse_iext_leaf	*leaf = cur->leaf;
+	loff_t			offset = fuse_iext_leaf_key(leaf, 0);
+	int			i, nr_entries;
+
+	ASSERT(ifp->if_height > 0);
+	ASSERT(ifp->if_data != NULL);
+	ASSERT(fuse_iext_valid(ifp, cur));
+
+	fuse_iext_inc_seq(ip);
+
+	nr_entries = fuse_iext_leaf_nr_entries(ifp, leaf, cur->pos) - 1;
+	for (i = cur->pos; i < nr_entries; i++)
+		leaf->recs[i] = leaf->recs[i + 1];
+	fuse_iext_rec_clear(&leaf->recs[nr_entries]);
+	ifp->if_bytes -= sizeof(struct fuse_iomap_io);
+
+	if (cur->pos == 0 && nr_entries > 0) {
+		fuse_iext_update_node(ifp, offset, fuse_iext_leaf_key(leaf, 0), 1,
+				leaf);
+		offset = fuse_iext_leaf_key(leaf, 0);
+	} else if (cur->pos == nr_entries) {
+		if (ifp->if_height > 1 && leaf->next)
+			cur->leaf = leaf->next;
+		else
+			cur->leaf = NULL;
+		cur->pos = 0;
+	}
+
+	if (nr_entries >= RECS_PER_LEAF / 2)
+		return;
+
+	if (ifp->if_height > 1)
+		fuse_iext_rebalance_leaf(ifp, cur, leaf, offset, nr_entries);
+	else if (nr_entries == 0)
+		fuse_iext_free_last_leaf(ifp);
+}
+
+/*
+ * Lookup the extent covering offset.
+ *
+ * If there is an extent covering offset return the extent index, and store the
+ * expanded extent structure in *gotp, and the extent cursor in *cur.
+ * If there is no extent covering offset, but there is an extent after it (e.g.
+ * it lies in a hole) return that extent in *gotp and its cursor in *cur
+ * instead.
+ * If offset is beyond the last extent return false, and return an invalid
+ * cursor value.
+ */
+bool
+fuse_iext_lookup_extent(
+	struct fuse_iomap_cache	*ip,
+	struct fuse_ifork	*ifp,
+	loff_t			offset,
+	struct fuse_iext_cursor	*cur,
+	struct fuse_iomap_io	*gotp)
+{
+	cur->leaf = fuse_iext_find_level(ifp, offset, 1);
+	if (!cur->leaf) {
+		cur->pos = 0;
+		return false;
+	}
+
+	for (cur->pos = 0; cur->pos < fuse_iext_max_recs(ifp); cur->pos++) {
+		struct fuse_iomap_io *rec = cur_rec(cur);
+
+		if (fuse_iext_rec_is_empty(rec))
+			break;
+		if (fuse_iext_rec_cmp(rec, offset) >= 0)
+			goto found;
+	}
+
+	/* Try looking in the next node for an entry > offset */
+	if (ifp->if_height == 1 || !cur->leaf->next)
+		return false;
+	cur->leaf = cur->leaf->next;
+	cur->pos = 0;
+	if (!fuse_iext_valid(ifp, cur))
+		return false;
+found:
+	fuse_iext_get(gotp, cur_rec(cur));
+	return true;
+}
+
+/*
+ * Returns the last extent before end, and if this extent doesn't cover
+ * end, update end to the end of the extent.
+ */
+bool
+fuse_iext_lookup_extent_before(
+	struct fuse_iomap_cache	*ip,
+	struct fuse_ifork	*ifp,
+	loff_t			*end,
+	struct fuse_iext_cursor	*cur,
+	struct fuse_iomap_io	*gotp)
+{
+	/* could be optimized to not even look up the next on a match.. */
+	if (fuse_iext_lookup_extent(ip, ifp, *end - 1, cur, gotp) &&
+	    gotp->offset <= *end - 1)
+		return true;
+	if (!fuse_iext_prev_extent(ifp, cur, gotp))
+		return false;
+	*end = gotp->offset + gotp->length;
+	return true;
+}
+
+void
+fuse_iext_update_extent(
+	struct fuse_iomap_cache	*ip,
+	int			state,
+	struct fuse_iext_cursor	*cur,
+	struct fuse_iomap_io	*new)
+{
+	struct fuse_ifork	*ifp = fuse_iext_state_to_fork(ip, state);
+
+	fuse_iext_inc_seq(ip);
+
+	if (cur->pos == 0) {
+		struct fuse_iomap_io	old;
+
+		fuse_iext_get(&old, cur_rec(cur));
+		if (new->offset != old.offset) {
+			fuse_iext_update_node(ifp, old.offset,
+					new->offset, 1, cur->leaf);
+		}
+	}
+
+	fuse_iext_set(cur_rec(cur), new);
+}
+
+/*
+ * Return true if the cursor points at an extent and return the extent structure
+ * in gotp.  Else return false.
+ */
+bool
+fuse_iext_get_extent(
+	const struct fuse_ifork		*ifp,
+	const struct fuse_iext_cursor	*cur,
+	struct fuse_iomap_io		*gotp)
+{
+	if (!fuse_iext_valid(ifp, cur))
+		return false;
+	fuse_iext_get(gotp, cur_rec(cur));
+	return true;
+}
+
+/*
+ * This is a recursive function, because of that we need to be extremely
+ * careful with stack usage.
+ */
+static void
+fuse_iext_destroy_node(
+	struct fuse_iext_node	*node,
+	int			level)
+{
+	int			i;
+
+	if (level > 1) {
+		for (i = 0; i < KEYS_PER_NODE; i++) {
+			if (node->keys[i] == FUSE_IEXT_KEY_INVALID)
+				break;
+			fuse_iext_destroy_node(node->ptrs[i], level - 1);
+		}
+	}
+
+	kfree(node);
+}
+
+void
+fuse_iext_destroy(
+	struct fuse_ifork	*ifp)
+{
+	fuse_iext_destroy_node(ifp->if_data, ifp->if_height);
+
+	ifp->if_bytes = 0;
+	ifp->if_height = 0;
+	ifp->if_data = NULL;
+}
+
+static inline struct fuse_ifork *
+fuse_iomap_fork_ptr(
+	struct fuse_iomap_cache	*ip,
+	enum fuse_iomap_iodir	iodir)
+{
+	switch (iodir) {
+	case READ_MAPPING:
+		return &ip->im_read;
+	case WRITE_MAPPING:
+		return ip->im_write;
+	default:
+		ASSERT(0);
+		return NULL;
+	}
+}
+
+static inline bool fuse_iomap_addrs_adjacent(const struct fuse_iomap_io *left,
+					     const struct fuse_iomap_io *right)
+{
+	switch (left->type) {
+	case FUSE_IOMAP_TYPE_MAPPED:
+	case FUSE_IOMAP_TYPE_UNWRITTEN:
+		return left->addr + left->length == right->addr;
+	default:
+		return left->addr  == FUSE_IOMAP_NULL_ADDR &&
+		       right->addr == FUSE_IOMAP_NULL_ADDR;
+	}
+}
+
+static inline bool fuse_iomap_can_merge(const struct fuse_iomap_io *left,
+					const struct fuse_iomap_io *right)
+{
+	return (left->dev == right->dev &&
+		left->offset + left->length == right->offset &&
+		left->type  == right->type &&
+		fuse_iomap_addrs_adjacent(left, right) &&
+		left->flags == right->flags &&
+		left->length + right->length <= FUSE_IOMAP_MAX_LEN);
+}
+
+static inline bool fuse_iomap_can_merge3(const struct fuse_iomap_io *left,
+					 const struct fuse_iomap_io *new,
+					 const struct fuse_iomap_io *right)
+{
+	return left->length + new->length + right->length <= FUSE_IOMAP_MAX_LEN;
+}
+
+#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
+static void fuse_iext_check_mappings(struct inode *inode,
+				      struct fuse_iomap_cache *ip,
+				      struct fuse_ifork *ifp)
+{
+	struct fuse_inode	*fi = FUSE_I(ip);
+	struct fuse_iext_cursor	icur;
+	struct fuse_iomap_io	prev, got;
+	unsigned long long	nr = 0;
+
+	if (!ifp || !static_branch_unlikely(&fuse_iomap_debug))
+		return;
+
+	fuse_iext_first(ifp, &icur);
+	if (!fuse_iext_get_extent(ifp, &icur, &prev))
+		return;
+	nr++;
+
+	fuse_iext_next(ifp, &icur);
+	while (fuse_iext_get_extent(ifp, &icur, &got)) {
+		if (got.length == 0 ||
+		    got.offset < prev.offset + prev.length ||
+		    fuse_iomap_can_merge(&prev, &got)) {
+			printk(KERN_ERR "FUSE IOMAP CORRUPTION ino=%llu nr=%llu",
+			       fi->orig_ino, nr);
+			printk(KERN_ERR "prev: offset=%llu length=%llu type=%u flags=0x%x dev=%u addr=%llu\n",
+			       prev.offset, prev.length, prev.type, prev.flags,
+			       prev.dev, prev.addr);
+			printk(KERN_ERR "curr: offset=%llu length=%llu type=%u flags=0x%x dev=%u addr=%llu\n",
+			       got.offset, got.length, got.type, got.flags,
+			       got.dev, got.addr);
+		}
+
+		prev = got;
+		nr++;
+		fuse_iext_next(ifp, &icur);
+	}
+}
+#else
+# define fuse_iext_check_mappings(...)	((void)0)
+#endif
+
+static void
+fuse_iext_del_mapping(
+	struct fuse_iomap_cache	*ip,
+	struct fuse_ifork	*ifp,
+	struct fuse_iext_cursor	*icur,
+	struct fuse_iomap_io	*got,	/* current extent entry */
+	struct fuse_iomap_io	*del)	/* data to remove from extents */
+{
+	struct fuse_iomap_io	new;	/* new record to be inserted */
+	/* first addr (fsblock aligned) past del */
+	uint64_t		del_endaddr;
+	/* first offset (fsblock aligned) past del */
+	uint64_t		del_endoff = del->offset + del->length;
+	/* first offset (fsblock aligned) past got */
+	uint64_t		got_endoff = got->offset + got->length;
+	uint32_t		state = fuse_iomap_fork_to_state(ip, ifp);
+
+	ASSERT(del->length > 0);
+	ASSERT(got->offset <= del->offset);
+	ASSERT(got_endoff >= del_endoff);
+
+	switch (del->type) {
+	case FUSE_IOMAP_TYPE_MAPPED:
+	case FUSE_IOMAP_TYPE_UNWRITTEN:
+		del_endaddr = del->addr + del->length;
+		break;
+	default:
+		del_endaddr = FUSE_IOMAP_NULL_ADDR;
+		break;
+	}
+
+	if (got->offset == del->offset)
+		state |= FUSE_IEXT_LEFT_FILLING;
+	if (got_endoff == del_endoff)
+		state |= FUSE_IEXT_RIGHT_FILLING;
+
+	switch (state & (FUSE_IEXT_LEFT_FILLING | FUSE_IEXT_RIGHT_FILLING)) {
+	case FUSE_IEXT_LEFT_FILLING | FUSE_IEXT_RIGHT_FILLING:
+		/*
+		 * Matches the whole extent.  Delete the entry.
+		 */
+		fuse_iext_remove(ip, icur, state);
+		fuse_iext_prev(ifp, icur);
+		break;
+	case FUSE_IEXT_LEFT_FILLING:
+		/*
+		 * Deleting the first part of the extent.
+		 */
+		got->offset = del_endoff;
+		got->addr = del_endaddr;
+		got->length -= del->length;
+		fuse_iext_update_extent(ip, state, icur, got);
+		break;
+	case FUSE_IEXT_RIGHT_FILLING:
+		/*
+		 * Deleting the last part of the extent.
+		 */
+		got->length -= del->length;
+		fuse_iext_update_extent(ip, state, icur, got);
+		break;
+	case 0:
+		/*
+		 * Deleting the middle of the extent.
+		 */
+		got->length = del->offset - got->offset;
+		fuse_iext_update_extent(ip, state, icur, got);
+
+		new.offset = del_endoff;
+		new.length = got_endoff - del_endoff;
+		new.type = got->type;
+		new.flags = got->flags;
+		new.addr = del_endaddr;
+		new.dev = got->dev;
+
+		fuse_iext_next(ifp, icur);
+		fuse_iext_insert(ip, icur, &new, state);
+		break;
+	}
+}
+
+int
+fuse_iomap_cache_remove(
+	struct inode		*inode,
+	enum fuse_iomap_iodir	iodir,
+	loff_t			start,		/* first file offset deleted */
+	uint64_t		len)		/* length to unmap */
+{
+	struct fuse_iext_cursor	icur;
+	struct fuse_iomap_io	got;		/* current extent record */
+	struct fuse_iomap_io	del;		/* extent being deleted */
+	loff_t			end;
+	struct fuse_inode	*fi = get_fuse_inode(inode);
+	struct fuse_iomap_cache	*ip = &fi->cache;
+	struct fuse_ifork	*ifp = fuse_iomap_fork_ptr(ip, iodir);
+	bool			wasreal;
+	bool			done = false;
+	int			ret = 0;
+
+	assert_cache_locked(ip);
+
+	if (!ifp || fuse_iext_count(ifp) == 0)
+		return 0;
+
+	/* Fast shortcut if the caller wants to erase everything */
+	if (start == 0 && len >= inode->i_sb->s_maxbytes) {
+		fuse_iext_destroy(ifp);
+		return 0;
+	}
+
+	if (!len)
+		goto out;
+
+	/*
+	 * If the caller wants us to remove everything to EOF, we set the end
+	 * of the removal range to the maximum file offset.  We don't support
+	 * unsigned file offsets.
+	 */
+	if (len == FUSE_IOMAP_INVAL_TO_EOF) {
+		const unsigned int blocksize = i_blocksize(inode);
+
+		len = round_up(inode->i_sb->s_maxbytes, blocksize) - start;
+	}
+
+	/*
+	 * Now that we've settled len, look up the extent before the end of the
+	 * range.
+	 */
+	end = start + len;
+	if (!fuse_iext_lookup_extent_before(ip, ifp, &end, &icur, &got))
+		goto out;
+	end--;
+
+	while (end != -1 && end >= start) {
+		/*
+		 * Is the found extent after a hole in which end lives?
+		 * Just back up to the previous extent, if so.
+		 */
+		if (got.offset > end &&
+		    !fuse_iext_prev_extent(ifp, &icur, &got)) {
+			done = true;
+			break;
+		}
+		/*
+		 * Is the last block of this extent before the range
+		 * we're supposed to delete?  If so, we're done.
+		 */
+		end = min_t(loff_t, end, got.offset + got.length - 1);
+		if (end < start)
+			break;
+		/*
+		 * Then deal with the (possibly delayed) allocated space
+		 * we found.
+		 */
+		del = got;
+		switch (del.type) {
+		case FUSE_IOMAP_TYPE_DELALLOC:
+		case FUSE_IOMAP_TYPE_HOLE:
+		case FUSE_IOMAP_TYPE_INLINE:
+		case FUSE_IOMAP_TYPE_PURE_OVERWRITE:
+			wasreal = false;
+			break;
+		case FUSE_IOMAP_TYPE_MAPPED:
+		case FUSE_IOMAP_TYPE_UNWRITTEN:
+			wasreal = true;
+			break;
+		default:
+			ASSERT(0);
+			ret = -EFSCORRUPTED;
+			goto out;
+		}
+
+		if (got.offset < start) {
+			del.offset = start;
+			del.length -= start - got.offset;
+			if (wasreal)
+				del.addr += start - got.offset;
+		}
+		if (del.offset + del.length > end + 1)
+			del.length = end + 1 - del.offset;
+
+		fuse_iext_del_mapping(ip, ifp, &icur, &got, &del);
+		end = del.offset - 1;
+
+		/*
+		 * If not done go on to the next (previous) record.
+		 */
+		if (end != -1 && end >= start) {
+			if (!fuse_iext_get_extent(ifp, &icur, &got) ||
+			    (got.offset > end &&
+			     !fuse_iext_prev_extent(ifp, &icur, &got))) {
+				done = true;
+				break;
+			}
+		}
+	}
+
+	/* Should have removed everything */
+	if (len == 0 || done || end == (loff_t)-1 || end < start)
+		ret = 0;
+	else
+		ret = -EFSCORRUPTED;
+
+out:
+	fuse_iext_check_mappings(inode, ip, ifp);
+	return ret;
+}
+
+static void
+fuse_iext_add_mapping(
+	struct fuse_iomap_cache		*ip,
+	struct fuse_ifork		*ifp,
+	struct fuse_iext_cursor		*icur,
+	const struct fuse_iomap_io	*new)	/* new extent entry */
+{
+	struct fuse_iomap_io		left;	/* left neighbor extent entry */
+	struct fuse_iomap_io		right;	/* right neighbor extent entry */
+	uint32_t			state = fuse_iomap_fork_to_state(ip, ifp);
+
+	/*
+	 * Check and set flags if this segment has a left neighbor.
+	 */
+	if (fuse_iext_peek_prev_extent(ifp, icur, &left))
+		state |= FUSE_IEXT_LEFT_VALID;
+
+	/*
+	 * Check and set flags if this segment has a current value.
+	 * Not true if we're inserting into the "hole" at eof.
+	 */
+	if (fuse_iext_get_extent(ifp, icur, &right))
+		state |= FUSE_IEXT_RIGHT_VALID;
+
+	/*
+	 * We're inserting a real allocation between "left" and "right".
+	 * Set the contiguity flags.  Don't let extents get too large.
+	 */
+	if ((state & FUSE_IEXT_LEFT_VALID) && fuse_iomap_can_merge(&left, new))
+		state |= FUSE_IEXT_LEFT_CONTIG;
+
+	if ((state & FUSE_IEXT_RIGHT_VALID) &&
+	    fuse_iomap_can_merge(new, &right) &&
+	    (!(state & FUSE_IEXT_LEFT_CONTIG) ||
+	     fuse_iomap_can_merge3(&left, new, &right)))
+		state |= FUSE_IEXT_RIGHT_CONTIG;
+
+	/*
+	 * Select which case we're in here, and implement it.
+	 */
+	switch (state & (FUSE_IEXT_LEFT_CONTIG | FUSE_IEXT_RIGHT_CONTIG)) {
+	case FUSE_IEXT_LEFT_CONTIG | FUSE_IEXT_RIGHT_CONTIG:
+		/*
+		 * New allocation is contiguous with real allocations on the
+		 * left and on the right.
+		 * Merge all three into a single extent record.
+		 */
+		left.length += new->length + right.length;
+
+		fuse_iext_remove(ip, icur, state);
+		fuse_iext_prev(ifp, icur);
+		fuse_iext_update_extent(ip, state, icur, &left);
+		break;
+
+	case FUSE_IEXT_LEFT_CONTIG:
+		/*
+		 * New allocation is contiguous with a real allocation
+		 * on the left.
+		 * Merge the new allocation with the left neighbor.
+		 */
+		left.length += new->length;
+
+		fuse_iext_prev(ifp, icur);
+		fuse_iext_update_extent(ip, state, icur, &left);
+		break;
+
+	case FUSE_IEXT_RIGHT_CONTIG:
+		/*
+		 * New allocation is contiguous with a real allocation
+		 * on the right.
+		 * Merge the new allocation with the right neighbor.
+		 */
+		right.offset = new->offset;
+		right.addr = new->addr;
+		right.length += new->length;
+		fuse_iext_update_extent(ip, state, icur, &right);
+		break;
+
+	case 0:
+		/*
+		 * New allocation is not contiguous with another
+		 * real allocation.
+		 * Insert a new entry.
+		 */
+		fuse_iext_insert(ip, icur, new, state);
+		break;
+	}
+}
+
+static int
+fuse_iomap_cache_add(
+	struct inode			*inode,
+	enum fuse_iomap_iodir		iodir,
+	const struct fuse_iomap_io	*new)
+{
+	struct fuse_iext_cursor		icur;
+	struct fuse_iomap_io		got;
+	struct fuse_inode		*fi = get_fuse_inode(inode);
+	struct fuse_iomap_cache		*ip = &fi->cache;
+	struct fuse_ifork		*ifp = fuse_iomap_fork_ptr(ip, iodir);
+
+	assert_cache_locked(ip);
+	ASSERT(new->length > 0);
+	ASSERT(new->offset < inode->i_sb->s_maxbytes);
+
+	if (!ifp) {
+		ifp = kzalloc(sizeof(struct fuse_ifork),
+			      GFP_KERNEL | __GFP_NOFAIL);
+		if (!ifp)
+			return -ENOMEM;
+
+		ip->im_write = ifp;
+	}
+
+	if (fuse_iext_lookup_extent(ip, ifp, new->offset, &icur, &got)) {
+		/* make sure we only add into a hole. */
+		ASSERT(got.offset > new->offset);
+		ASSERT(got.offset - new->offset >= new->length);
+
+		if (got.offset <= new->offset ||
+		    got.offset - new->offset < new->length)
+			return -EFSCORRUPTED;
+	}
+
+	fuse_iext_add_mapping(ip, ifp, &icur, new);
+	fuse_iext_check_mappings(inode, ip, ifp);
+	return 0;
+}
+
+int
+fuse_iomap_cache_upsert(
+	struct inode			*inode,
+	enum fuse_iomap_iodir		iodir,
+	const struct fuse_iomap_io	*map)
+{
+	struct fuse_inode		*fi = get_fuse_inode(inode);
+	struct fuse_iomap_cache		*ip = &fi->cache;
+	int				err;
+
+	/*
+	 * We interpret no write fork to mean that all writes are pure
+	 * overwrites.  Avoid wasting memory if we're trying to upsert a
+	 * pure overwrite.
+	 */
+	if (iodir == WRITE_MAPPING &&
+	    map->type == FUSE_IOMAP_TYPE_PURE_OVERWRITE &&
+	    ip->im_write == NULL)
+		return 0;
+
+	err = fuse_iomap_cache_remove(inode, iodir, map->offset, map->length);
+	if (err)
+		return err;
+
+	return fuse_iomap_cache_add(inode, iodir, map);
+}
+
+/*
+ * Trim the returned map to the required bounds
+ */
+static void
+fuse_iomap_trim(
+	struct fuse_inode		*fi,
+	struct fuse_iomap_lookup	*mval,
+	const struct fuse_iomap_io	*got,
+	loff_t				off,
+	loff_t				len)
+{
+	struct fuse_iomap_cache		*ip = &fi->cache;
+	const unsigned int blocksize = i_blocksize(&fi->inode);
+	const loff_t aligned_off = round_down(off, blocksize);
+	const loff_t aligned_end = round_up(off + len, blocksize);
+	const loff_t aligned_len = aligned_end - aligned_off;
+
+	ASSERT(aligned_off >= got->offset);
+
+	switch (got->type) {
+	case FUSE_IOMAP_TYPE_MAPPED:
+	case FUSE_IOMAP_TYPE_UNWRITTEN:
+		mval->map.addr = got->addr + (aligned_off - got->offset);
+		break;
+	default:
+		mval->map.addr = FUSE_IOMAP_NULL_ADDR;
+		break;
+	}
+	mval->map.offset = aligned_off;
+	mval->map.length = min_t(loff_t, aligned_len,
+				 got->length - (aligned_off - got->offset));
+	mval->map.type = got->type;
+	mval->map.flags = got->flags;
+	mval->map.dev = got->dev;
+	mval->validity_cookie = fuse_iext_read_seq(ip);
+}
+
+enum fuse_iomap_lookup_result
+fuse_iomap_cache_lookup(
+	struct inode			*inode,
+	enum fuse_iomap_iodir		iodir,
+	loff_t				off,
+	uint64_t			len,
+	struct fuse_iomap_lookup	*mval)
+{
+	struct fuse_iomap_io		got;
+	struct fuse_iext_cursor		icur;
+	struct fuse_inode		*fi = get_fuse_inode(inode);
+	struct fuse_iomap_cache		*ip = &fi->cache;
+	struct fuse_ifork		*ifp = fuse_iomap_fork_ptr(ip, iodir);
+
+	assert_cache_locked_shared(ip);
+
+	if (!ifp) {
+		/*
+		 * No write fork at all means this filesystem doesn't do out of
+		 * place writes.
+		 */
+		return LOOKUP_NOFORK;
+	}
+
+	if (!fuse_iext_lookup_extent(ip, ifp, off, &icur, &got)) {
+		/*
+		 * Write fork does not contain a mapping at or beyond off,
+		 * which is a cache miss.
+		 */
+		return LOOKUP_MISS;
+	}
+
+	if (got.offset > off) {
+		/*
+		 * Found a mapping, but it doesn't cover the start of the
+		 * range, which is effectively a miss.
+		 */
+		return LOOKUP_MISS;
+	}
+
+	/* Found a mapping in the cache, return it */
+	fuse_iomap_trim(fi, mval, &got, off, len);
+	return LOOKUP_HIT;
+}


