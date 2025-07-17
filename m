Return-Path: <linux-fsdevel+bounces-55335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD366B0980E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10EF1C449B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E772266B56;
	Thu, 17 Jul 2025 23:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8DViGoj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB73259CA4
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795109; cv=none; b=ow1yw+TWSaTCHWX1UtYjVMV8jXpph+3lsXsCEQbvKj6kEOIBFYoxGIVHjwq13bMS7qWJbfYPhHS10DcvGlarO9QOWZraFuEUi6UGEuogYMGVonjkmWB9XCK+arDTQDXfqYfJhp2F7TrOo4Dvj5M37PLOflxrYN+6Rl4jjOUA6O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795109; c=relaxed/simple;
	bh=YvzkhZLWdqYj/V+TDNZe0UJIbDUhaJ/gYG1NwwtFOKU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IqXXUofw3pdVAakLlmB8VV0jGXuXwXVKTjP1PWr4+j8HIAywjYTpEwJkURBPqIWv2qvE+y2/MdM+73Gwdz100U3mwMRDD+P560vdiJgFalzg4+47H7gPbnRlauWZy90RBF2s/aksaGnOKtGBl5nH4y2HVS+/UFMhPUV8ykssAsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8DViGoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB2AC4CEE3;
	Thu, 17 Jul 2025 23:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795109;
	bh=YvzkhZLWdqYj/V+TDNZe0UJIbDUhaJ/gYG1NwwtFOKU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=X8DViGojnmdyRZIS9bjXxDXeoetTbf5fT/+uxR3grkhMzTRo7HR8WtbtdIWXKRtXt
	 JwWCcXkSPB0x0xeSNOq2sDcXHaGF8qZmnZ9U5uuzPrvbOLm7bUMKP5+GKrU88h29r6
	 q312tiV6b6AwIjVhot0ICO/rE7blqQgtwOenWTpNk67yWjczNS0u2uwr+uXtcZa/Oh
	 pBzyc+V6m6fQaCYKcsYA4Ah2e0NCemcW7SLKvqepUd2ShZc7s/bjpDRT6zvUijFnaG
	 ictqoQ1b/W3L24paelDm7IAS9FnizUGd7jrIO7ej2d9Sz6dGK4COl1S/FLBKzju3T3
	 dzOnrVA15tOag==
Date: Thu, 17 Jul 2025 16:31:48 -0700
Subject: [PATCH 1/4] fuse: cache iomaps
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279450463.713483.13022259479759690856.stgit@frogsfrogsfrogs>
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

Cache iomaps to a file so that we don't have to upcall the server.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |   87 ++
 fs/fuse/fuse_trace.h      |  436 ++++++++++++
 fs/fuse/iomap_cache.h     |  119 +++
 include/uapi/linux/fuse.h |    4 
 fs/fuse/Makefile          |    2 
 fs/fuse/dev.c             |    1 
 fs/fuse/file_iomap.c      |   32 +
 fs/fuse/iomap_cache.c     | 1651 +++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 2322 insertions(+), 10 deletions(-)
 create mode 100644 fs/fuse/iomap_cache.h
 create mode 100644 fs/fuse/iomap_cache.c


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 5fba84c75f4a64..196d2b57e80bb1 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -106,6 +106,24 @@ struct fuse_backing {
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
@@ -167,6 +185,7 @@ struct fuse_inode {
 			spinlock_t ioend_lock;
 			struct work_struct ioend_work;
 			struct list_head ioend_list;
+			struct fuse_iomap_cache cache;
 #endif
 		};
 
@@ -237,6 +256,11 @@ enum {
 	FUSE_I_IOMAP_DIRECTIO,
 	/* Use iomap for buffered read and writes */
 	FUSE_I_IOMAP_FILEIO,
+	/*
+	 * Cache iomaps in the kernel.  This is required for any filesystem
+	 * that needs to synchronize pagecache write and writeback.
+	 */
+	FUSE_I_IOMAP_CACHE,
 };
 
 struct fuse_conn;
@@ -1716,6 +1740,65 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
 
 int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
+
+enum fuse_iomap_fork {
+	FUSE_IOMAP_READ_FORK,
+	FUSE_IOMAP_WRITE_FORK,
+};
+
+struct fuse_iomap {
+	uint64_t		addr;	/* disk offset of mapping, bytes */
+	loff_t			offset;	/* file offset of mapping, bytes */
+	uint64_t		length;	/* length of mapping, bytes */
+	uint16_t		type;	/* FUSE_IOMAP_TYPE_* */
+	uint16_t		flags;	/* FUSE_IOMAP_F_* */
+	uint32_t		dev;	/* device cookie */
+	uint64_t		validity_cookie; /* used with .iomap_valid() */
+};
+
+static inline bool fuse_has_iomap_cache(const struct inode *inode)
+{
+	const struct fuse_inode *fi = get_fuse_inode_c(inode);
+
+	return test_bit(FUSE_I_IOMAP_CACHE, &fi->state);
+}
+
+int fuse_iomap_cache_remove(struct inode *inode,
+			    enum fuse_iomap_fork whichfork,
+			    loff_t off, uint64_t len);
+
+int fuse_iomap_cache_add(struct inode *inode,
+			 enum fuse_iomap_fork whichfork,
+			 const struct fuse_iomap *map);
+
+static inline int fuse_iomap_cache_upsert(struct inode *inode,
+					  enum fuse_iomap_fork whichfork,
+					  const struct fuse_iomap *map)
+{
+	int err = fuse_iomap_cache_remove(inode, whichfork, map->offset,
+					  map->length);
+	if (err)
+		return err;
+
+	return fuse_iomap_cache_add(inode, whichfork, map);
+}
+
+static inline uint64_t fuse_iext_read_seq(struct fuse_iomap_cache *ip)
+{
+	return (uint64_t)READ_ONCE(ip->im_seq);
+}
+
+enum fuse_iomap_lookup_result {
+	LOOKUP_HIT,
+	LOOKUP_MISS,
+	LOOKUP_NOFORK,
+};
+
+enum fuse_iomap_lookup_result
+fuse_iomap_cache_lookup(struct inode *inode,
+			enum fuse_iomap_fork whichfork,
+			loff_t off, uint64_t len,
+			struct fuse_iomap *mval);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -1745,6 +1828,10 @@ int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
 # define fuse_iomap_fadvise			NULL
+# define fuse_has_iomap_cache(...)		(false)
+# define fuse_iomap_cache_remove(...)		(-ENOSYS)
+# define fuse_iomap_cache_add(...)		(-ENOSYS)
+# define fuse_iomap_cache_upsert(...)		(-ENOSYS)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 20257aed0cd89f..598c0e603a32b1 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -129,6 +129,7 @@ TRACE_EVENT(fuse_request_end,
 );
 
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
+struct fuse_iext_cursor;
 
 #define FUSE_IOMAP_F_STRINGS \
 	{ FUSE_IOMAP_F_NEW,			"new" }, \
@@ -182,6 +183,7 @@ TRACE_DEFINE_ENUM(FUSE_I_BTIME);
 TRACE_DEFINE_ENUM(FUSE_I_CACHE_IO_MODE);
 TRACE_DEFINE_ENUM(FUSE_I_IOMAP_DIRECTIO);
 TRACE_DEFINE_ENUM(FUSE_I_IOMAP_FILEIO);
+TRACE_DEFINE_ENUM(FUSE_I_IOMAP_CACHE);
 
 #define FUSE_IFLAG_STRINGS \
 	{ 1 << FUSE_I_ADVISE_RDPLUS,		"advise_rdplus" }, \
@@ -191,7 +193,8 @@ TRACE_DEFINE_ENUM(FUSE_I_IOMAP_FILEIO);
 	{ 1 << FUSE_I_BTIME,			"btime" }, \
 	{ 1 << FUSE_I_CACHE_IO_MODE,		"cacheio" }, \
 	{ 1 << FUSE_I_IOMAP_DIRECTIO,		"iomap_dio" }, \
-	{ 1 << FUSE_I_IOMAP_FILEIO,		"iomap_fileio" }
+	{ 1 << FUSE_I_IOMAP_FILEIO,		"iomap_fileio" }, \
+	{ 1 << FUSE_I_IOMAP_CACHE,		"iomap_cache" }
 
 #define IOMAP_IOEND_STRINGS \
 	{ IOMAP_IOEND_SHARED,			"shared" }, \
@@ -207,6 +210,26 @@ TRACE_DEFINE_ENUM(FUSE_I_IOMAP_FILEIO);
 	{ FUSE_IOMAP_CONFIG_TIME,		"time" }, \
 	{ FUSE_IOMAP_CONFIG_MAXBYTES,		"maxbytes" }
 
+TRACE_DEFINE_ENUM(FUSE_IOMAP_READ_FORK);
+TRACE_DEFINE_ENUM(FUSE_IOMAP_WRITE_FORK);
+
+#define FUSE_IOMAP_FORK_STRINGS \
+	{ FUSE_IOMAP_READ_FORK,			"read" }, \
+	{ FUSE_IOMAP_WRITE_FORK,		"write" }
+
+#define FUSE_IOMAP_CACHE_LOCK_STRINGS \
+	{ FUSE_IOMAP_LOCK_SHARED,		"shared" }, \
+	{ FUSE_IOMAP_LOCK_EXCL,			"exclusive" }
+
+#define FUSE_IEXT_STATE_STRINGS \
+	{ FUSE_IEXT_LEFT_CONTIG,		"l_cont" }, \
+	{ FUSE_IEXT_RIGHT_CONTIG,		"r_cont" }, \
+	{ FUSE_IEXT_LEFT_FILLING,		"l_fill" }, \
+	{ FUSE_IEXT_RIGHT_FILLING,		"r_fill" }, \
+	{ FUSE_IEXT_LEFT_VALID,			"l_valid" }, \
+	{ FUSE_IEXT_RIGHT_VALID,		"r_valid" }, \
+	{ FUSE_IEXT_WRITEFORK,			"writefork" }
+
 TRACE_EVENT(fuse_iomap_begin,
 	TP_PROTO(const struct inode *inode, loff_t pos, loff_t count,
 		 unsigned opflags),
@@ -1289,6 +1312,417 @@ DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_inline_read);
 DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_inline_write);
 DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_iomap);
 DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_srcmap);
+
+DECLARE_EVENT_CLASS(fuse_iomap_cache_lock_class,
+	TP_PROTO(const struct inode *inode, unsigned int lock_flags,
+		 unsigned long caller_ip),
+	TP_ARGS(inode, lock_flags, caller_ip),
+	TP_STRUCT__entry(
+		__field(dev_t, connection)
+		__field(uint64_t, ino)
+		__field(uint64_t,	nodeid)
+		__field(loff_t,		isize)
+		__field(unsigned int, lock_flags)
+		__field(unsigned long, caller_ip)
+	),
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->nodeid		=	fi->nodeid;
+		__entry->isize		=	i_size_read(inode);
+		__entry->lock_flags	=	lock_flags;
+		__entry->caller_ip	=	caller_ip;
+	),
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx lock (%s) caller %pS",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize,
+		  __print_flags(__entry->lock_flags, "|", FUSE_IOMAP_CACHE_LOCK_STRINGS),
+		  (void *)__entry->caller_ip)
+)
+#define DEFINE_FUSE_IOMAP_CACHE_LOCK_EVENT(name)	\
+DEFINE_EVENT(fuse_iomap_cache_lock_class, name,		\
+	TP_PROTO(const struct inode *inode, unsigned int lock_flags, \
+		 unsigned long caller_ip), \
+	TP_ARGS(inode, lock_flags, caller_ip))
+DEFINE_FUSE_IOMAP_CACHE_LOCK_EVENT(fuse_iomap_cache_lock);
+DEFINE_FUSE_IOMAP_CACHE_LOCK_EVENT(fuse_iomap_cache_unlock);
+
+DECLARE_EVENT_CLASS(fuse_iext_class,
+	TP_PROTO(const struct inode *inode, const struct fuse_iext_cursor *cur,
+		 int state, unsigned long caller_ip),
+
+	TP_ARGS(inode, cur, state, caller_ip),
+
+	TP_STRUCT__entry(
+		__field(dev_t, connection)
+		__field(uint64_t, ino)
+		__field(void *, leaf)
+		__field(int, pos)
+		__field(loff_t, offset)
+		__field(uint64_t, addr)
+		__field(uint64_t, length)
+		__field(uint16_t, type)
+		__field(uint16_t, mapflags)
+		__field(uint32_t, dev)
+		__field(int, iext_state)
+		__field(unsigned long, caller_ip)
+	),
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+		const struct fuse_ifork *ifp;
+		struct fuse_iomap	r = { };
+
+		if (state & FUSE_IEXT_WRITEFORK)
+			ifp = fi->cache.im_write;
+		else
+			ifp = &fi->cache.im_read;
+		if (ifp)
+			fuse_iext_get_extent(ifp, cur, &r);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->leaf		=	cur->leaf;
+		__entry->pos		=	cur->pos;
+		__entry->offset		=	r.offset;
+		__entry->addr		=	r.addr;
+		__entry->length		=	r.length;
+		__entry->dev		=	r.dev;
+		__entry->type		=	r.type;
+		__entry->mapflags	=	r.flags;
+		__entry->iext_state	=	state;
+		__entry->caller_ip	=	caller_ip;
+	),
+	TP_printk("connection %u ino %llu state (%s) cur %p/%d "
+		  "offset 0x%llx addr 0x%llx length 0x%llx type %s mapflags (%s) dev %u caller %pS",
+		  __entry->connection, __entry->ino,
+		  __print_flags(__entry->iext_state, "|", FUSE_IEXT_STATE_STRINGS),
+		  __entry->leaf,
+		  __entry->pos,
+		  __entry->offset,
+		  __entry->addr,
+		  __entry->length,
+		  __print_symbolic(__entry->type, FUSE_IOMAP_TYPE_STRINGS),
+		  __print_flags(__entry->mapflags, "|", FUSE_IOMAP_F_STRINGS),
+		  __entry->dev,
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
+		 const struct fuse_iomap *map),
+	TP_ARGS(inode, iext_state, map),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+		__field(uint64_t,		ino)
+		__field(uint64_t,		nodeid)
+		__field(loff_t,			isize)
+
+		__field(loff_t,			map_offset)
+		__field(loff_t,			map_length)
+		__field(uint16_t,		map_type)
+		__field(uint16_t,		map_flags)
+		__field(uint32_t,		map_dev)
+		__field(uint64_t,		map_addr)
+
+		__field(uint32_t,		iext_state)
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
+
+		__entry->map_offset	=	map->offset;
+		__entry->map_length	=	map->length;
+		__entry->map_type	=	map->type;
+		__entry->map_flags	=	map->flags;
+		__entry->map_dev	=	map->dev;
+		__entry->map_addr	=	map->addr;
+
+		__entry->iext_state	=	iext_state;
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx state (%s) offset 0x%llx length 0x%llx type %s mapflags (%s) dev %u addr 0x%llx",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize,
+		  __print_flags(__entry->iext_state, "|", FUSE_IEXT_STATE_STRINGS),
+		  __entry->map_offset, __entry->map_length,
+		  __print_symbolic(__entry->map_type, FUSE_IOMAP_TYPE_STRINGS),
+		  __print_flags(__entry->map_flags, "|", FUSE_IOMAP_F_STRINGS),
+		  __entry->map_dev, __entry->map_addr)
+);
+#define DEFINE_IEXT_UPDATE_EVENT(name) \
+DEFINE_EVENT(fuse_iext_update_class, name, \
+	TP_PROTO(const struct inode *inode, uint32_t iext_state, \
+		 const struct fuse_iomap *map), \
+	TP_ARGS(inode, iext_state, map))
+DEFINE_IEXT_UPDATE_EVENT(fuse_iext_del_mapping);
+DEFINE_IEXT_UPDATE_EVENT(fuse_iext_add_mapping);
+
+TRACE_EVENT(fuse_iext_alt_update_class,
+	TP_PROTO(const struct inode *inode, const struct fuse_iomap *map),
+	TP_ARGS(inode, map),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+		__field(uint64_t,		ino)
+		__field(uint64_t,		nodeid)
+
+		__field(loff_t,			map_offset)
+		__field(loff_t,			map_length)
+		__field(uint16_t,		map_type)
+		__field(uint16_t,		map_flags)
+		__field(uint32_t,		map_dev)
+		__field(uint64_t,		map_addr)
+	),
+
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->nodeid		=	fi->nodeid;
+
+		__entry->map_offset	=	map->offset;
+		__entry->map_length	=	map->length;
+		__entry->map_type	=	map->type;
+		__entry->map_flags	=	map->flags;
+		__entry->map_dev	=	map->dev;
+		__entry->map_addr	=	map->addr;
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu offset 0x%llx length 0x%llx type %s mapflags (%s) dev %u addr 0x%llx",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->map_offset, __entry->map_length,
+		  __print_symbolic(__entry->map_type, FUSE_IOMAP_TYPE_STRINGS),
+		  __print_flags(__entry->map_flags, "|", FUSE_IOMAP_F_STRINGS),
+		  __entry->map_dev, __entry->map_addr)
+);
+#define DEFINE_IEXT_ALT_UPDATE_EVENT(name) \
+DEFINE_EVENT(fuse_iext_alt_update_class, name, \
+	TP_PROTO(const struct inode *inode, const struct fuse_iomap *map), \
+	TP_ARGS(inode, map))
+DEFINE_IEXT_ALT_UPDATE_EVENT(fuse_iext_del_mapping_got);
+DEFINE_IEXT_ALT_UPDATE_EVENT(fuse_iext_add_mapping_left);
+DEFINE_IEXT_ALT_UPDATE_EVENT(fuse_iext_add_mapping_right);
+
+TRACE_EVENT(fuse_iomap_cache_remove,
+	TP_PROTO(const struct inode *inode, enum fuse_iomap_fork whichfork,
+		 loff_t offset, uint64_t length, unsigned long caller_ip),
+	TP_ARGS(inode, whichfork, offset, length, caller_ip),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+		__field(uint64_t,		ino)
+		__field(uint64_t,		nodeid)
+		__field(loff_t,			isize)
+		__field(enum fuse_iomap_fork,	whichfork)
+		__field(loff_t,			offset)
+		__field(uint64_t,		length)
+		__field(unsigned long,		caller_ip)
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
+		__entry->whichfork	=	whichfork;
+		__entry->offset		=	offset;
+		__entry->length		=	length;
+		__entry->caller_ip	=	caller_ip;
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx whichfork %s offset 0x%llx length 0x%llx caller %pS",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize,
+		  __print_symbolic(__entry->whichfork, FUSE_IOMAP_FORK_STRINGS),
+		  __entry->offset, __entry->length, (void *)__entry->caller_ip)
+);
+
+TRACE_EVENT(fuse_iomap_mapping_class,
+	TP_PROTO(const struct inode *inode, enum fuse_iomap_fork whichfork,
+		 const struct fuse_iomap *map, unsigned long caller_ip),
+	TP_ARGS(inode, whichfork, map, caller_ip),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+		__field(uint64_t,		ino)
+		__field(uint64_t,		nodeid)
+		__field(loff_t,			isize)
+		__field(enum fuse_iomap_fork,	whichfork)
+		__field(loff_t,			offset)
+		__field(loff_t,			length)
+		__field(uint16_t,		maptype)
+		__field(uint16_t,		mapflags)
+		__field(uint32_t,		dev)
+		__field(uint64_t,		addr)
+		__field(unsigned long,		caller_ip)
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
+		__entry->whichfork	=	whichfork;
+		__entry->offset		=	map->offset;
+		__entry->length		=	map->length;
+		__entry->maptype	=	map->type;
+		__entry->mapflags	=	map->flags;
+		__entry->dev		=	map->dev;
+		__entry->addr		=	map->addr;
+		__entry->caller_ip	=	caller_ip;
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx whichfork %s offset 0x%llx length 0x%llx type %s mapflags (%s) dev %u addr 0x%llx caller %pS",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize,
+		  __print_symbolic(__entry->whichfork, FUSE_IOMAP_FORK_STRINGS),
+		  __entry->offset, __entry->length,
+		  __print_symbolic(__entry->maptype, FUSE_IOMAP_TYPE_STRINGS),
+		  __print_flags(__entry->mapflags, "|", FUSE_IOMAP_F_STRINGS),
+		  __entry->dev, __entry->addr, (void *)__entry->caller_ip)
+);
+#define DEFINE_FUSE_IOMAP_MAPPING_EVENT(name) \
+DEFINE_EVENT(fuse_iomap_mapping_class, name, \
+	TP_PROTO(const struct inode *inode, enum fuse_iomap_fork whichfork, \
+		 const struct fuse_iomap *map, unsigned long caller_ip), \
+	TP_ARGS(inode, whichfork, map, caller_ip))
+DEFINE_FUSE_IOMAP_MAPPING_EVENT(fuse_iomap_cache_add);
+DEFINE_FUSE_IOMAP_MAPPING_EVENT(fuse_iext_check_mapping);
+
+TRACE_EVENT(fuse_iomap_cache_lookup,
+	TP_PROTO(const struct inode *inode, enum fuse_iomap_fork whichfork,
+		 loff_t pos, uint64_t count, unsigned long caller_ip),
+	TP_ARGS(inode, whichfork, pos, count, caller_ip),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+		__field(uint64_t,		ino)
+		__field(uint64_t,		nodeid)
+		__field(loff_t,			isize)
+		__field(enum fuse_iomap_fork,	whichfork)
+		__field(loff_t,			pos)
+		__field(uint64_t,		count)
+		__field(unsigned long,		caller_ip)
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
+		__entry->whichfork	=	whichfork;
+		__entry->pos		=	pos;
+		__entry->count		=	count;
+		__entry->caller_ip	=	caller_ip;
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx whichfork %s pos 0x%llx count 0x%llx caller %pS",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize,
+		  __print_symbolic(__entry->whichfork, FUSE_IOMAP_FORK_STRINGS),
+		  __entry->pos, __entry->count,
+		  (void *)__entry->caller_ip)
+);
+
+TRACE_EVENT(fuse_iomap_cache_lookup_result,
+	TP_PROTO(const struct inode *inode, enum fuse_iomap_fork whichfork,
+		 loff_t pos, uint64_t count, const struct fuse_iomap *got,
+		 const struct fuse_iomap *map),
+	TP_ARGS(inode, whichfork, pos, count, got, map),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+		__field(uint64_t,		ino)
+		__field(uint64_t,		nodeid)
+		__field(loff_t,			isize)
+		__field(enum fuse_iomap_fork,	whichfork)
+		__field(loff_t,			pos)
+		__field(uint64_t,		count)
+
+		__field(loff_t,			got_offset)
+		__field(uint64_t,		got_length)
+		__field(uint64_t,		got_addr)
+
+		__field(loff_t,			map_offset)
+		__field(uint64_t,		map_length)
+		__field(uint16_t,		map_type)
+		__field(uint16_t,		map_flags)
+		__field(uint32_t,		map_dev)
+		__field(uint64_t,		map_addr)
+
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
+		__entry->whichfork	=	whichfork;
+		__entry->pos		=	pos;
+		__entry->count		=	count;
+
+		__entry->got_offset	=	got->offset;
+		__entry->got_length	=	got->length;
+		__entry->got_addr	=	got->addr;
+
+		__entry->map_offset	=	map->offset;
+		__entry->map_length	=	map->length;
+		__entry->map_type	=	map->type;
+		__entry->map_flags	=	map->flags;
+		__entry->map_dev	=	map->dev;
+		__entry->map_addr	=	map->addr;
+
+		__entry->validity_cookie=	map->validity_cookie;
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx whichfork %s pos 0x%llx count 0x%llx map offset 0x%llx length 0x%llx type %s mapflags (%s) dev %u addr 0x%llx got offset 0x%llx length 0x%llx addr 0x%llx cookie 0x%llx",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize,
+		  __print_symbolic(__entry->whichfork, FUSE_IOMAP_FORK_STRINGS),
+		  __entry->pos, __entry->count,
+		  __entry->map_offset, __entry->map_length,
+		  __print_symbolic(__entry->map_type, FUSE_IOMAP_TYPE_STRINGS),
+		  __print_flags(__entry->map_flags, "|", FUSE_IOMAP_F_STRINGS),
+		  __entry->map_dev, __entry->map_addr, __entry->got_offset,
+		  __entry->got_length, __entry->got_addr,
+		  __entry->validity_cookie)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/iomap_cache.h b/fs/fuse/iomap_cache.h
new file mode 100644
index 00000000000000..7efa23be18d155
--- /dev/null
+++ b/fs/fuse/iomap_cache.h
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017 Christoph Hellwig.
+ */
+
+#ifndef _FS_FUSE_IOMAP_CACHE_H
+#define _FS_FUSE_IOMAP_CACHE_H
+
+#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
+# define ASSERT(a)		do { WARN(!(a), "Assertion failed: %s, func: %s, line: %d", #a, __func__, __LINE__); } while (0)
+# define BAD_DATA(condition)	(WARN(condition, "Bad mapping: %s, func: %s, line: %d", #condition, __func__, __LINE__))
+#else
+# define ASSERT(a)
+# define BAD_DATA(condition)	(condition)
+#endif
+
+#define FUSE_IOMAP_LOCK_SHARED	(1U << 0)
+#define FUSE_IOMAP_LOCK_EXCL	(1U << 1)
+
+void fuse_iomap_cache_lock(struct inode *inode, unsigned int lock_flags);
+void fuse_iomap_cache_unlock(struct inode *inode, unsigned int lock_flags);
+
+#define FUSE_IOMAP_MAX_LEN	((loff_t)(1ULL << 63))
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
+#define FUSE_IEXT_WRITEFORK	(1u << 6)
+
+struct fuse_ifork *fuse_iext_state_to_fork(struct fuse_iomap_cache *ip,
+		unsigned int state);
+
+uint64_t	fuse_iext_count(const struct fuse_ifork *ifp);
+void		fuse_iext_insert_raw(struct fuse_iomap_cache *ip,
+			struct fuse_ifork *ifp,
+			struct fuse_iext_cursor *cur,
+			const struct fuse_iomap *irec);
+void		fuse_iext_insert(struct fuse_iomap_cache *,
+			struct fuse_iext_cursor *cur,
+			const struct fuse_iomap *, int);
+void		fuse_iext_remove(struct fuse_iomap_cache *,
+			struct fuse_iext_cursor *,
+			int);
+void		fuse_iext_destroy(struct fuse_ifork *);
+
+bool		fuse_iext_lookup_extent(struct fuse_iomap_cache *ip,
+			struct fuse_ifork *ifp, loff_t bno,
+			struct fuse_iext_cursor *cur,
+			struct fuse_iomap *gotp);
+bool		fuse_iext_lookup_extent_before(struct fuse_iomap_cache *ip,
+			struct fuse_ifork *ifp, loff_t *end,
+			struct fuse_iext_cursor *cur,
+			struct fuse_iomap *gotp);
+bool		fuse_iext_get_extent(const struct fuse_ifork *ifp,
+			const struct fuse_iext_cursor *cur,
+			struct fuse_iomap *gotp);
+void		fuse_iext_update_extent(struct fuse_iomap_cache *ip, int state,
+			struct fuse_iext_cursor *cur,
+			struct fuse_iomap *gotp);
+
+void		fuse_iext_first(struct fuse_ifork *, struct fuse_iext_cursor *);
+void		fuse_iext_last(struct fuse_ifork *, struct fuse_iext_cursor *);
+void		fuse_iext_next(struct fuse_ifork *, struct fuse_iext_cursor *);
+void		fuse_iext_prev(struct fuse_ifork *, struct fuse_iext_cursor *);
+
+static inline bool fuse_iext_next_extent(struct fuse_ifork *ifp,
+		struct fuse_iext_cursor *cur, struct fuse_iomap *gotp)
+{
+	fuse_iext_next(ifp, cur);
+	return fuse_iext_get_extent(ifp, cur, gotp);
+}
+
+static inline bool fuse_iext_prev_extent(struct fuse_ifork *ifp,
+		struct fuse_iext_cursor *cur, struct fuse_iomap *gotp)
+{
+	fuse_iext_prev(ifp, cur);
+	return fuse_iext_get_extent(ifp, cur, gotp);
+}
+
+/*
+ * Return the extent after cur in gotp without updating the cursor.
+ */
+static inline bool fuse_iext_peek_next_extent(struct fuse_ifork *ifp,
+		struct fuse_iext_cursor *cur, struct fuse_iomap *gotp)
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
+		struct fuse_iext_cursor *cur, struct fuse_iomap *gotp)
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
+#endif /* _FS_FUSE_IOMAP_CACHE_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 2aac5a0c4cef0a..a9b2d68b4b79c3 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1330,6 +1330,7 @@ struct fuse_uring_cmd_req {
 };
 
 #define FUSE_IOMAP_TYPE_PURE_OVERWRITE	(0xFFFF) /* use read mapping data */
+#define FUSE_IOMAP_TYPE_NULL		(0xFFFE) /* no record here */
 #define FUSE_IOMAP_TYPE_HOLE		0	/* no blocks allocated, need allocation */
 #define FUSE_IOMAP_TYPE_DELALLOC	1	/* delayed allocation blocks */
 #define FUSE_IOMAP_TYPE_MAPPED		2	/* blocks allocated at @addr */
@@ -1462,4 +1463,7 @@ struct fuse_iomap_config_out {
 	int64_t s_maxbytes;	/* max file size */
 };
 
+/* invalidate all cached iomap mappings up to EOF */
+#define FUSE_IOMAP_INVAL_TO_EOF		(~0ULL)
+
 #endif /* _LINUX_FUSE_H */
diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 63a41ef9336aaa..cf5c242be09f84 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -16,6 +16,6 @@ fuse-$(CONFIG_FUSE_DAX) += dax.o
 fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o
 fuse-$(CONFIG_SYSCTL) += sysctl.o
 fuse-$(CONFIG_FUSE_IO_URING) += dev_uring.o
-fuse-$(CONFIG_FUSE_IOMAP) += file_iomap.o
+fuse-$(CONFIG_FUSE_IOMAP) += file_iomap.o iomap_cache.o
 
 virtiofs-y := virtio_fs.o
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 4ad90d212379ff..3dd04c2fdae7ba 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -9,6 +9,7 @@
 #include "dev_uring_i.h"
 #include "fuse_i.h"
 #include "fuse_dev_i.h"
+#include "iomap_cache.h"
 
 #include <linux/init.h>
 #include <linux/module.h>
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 5ef9fa67db807e..66e1be93592023 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -4,6 +4,7 @@
  * Author: Darrick J. Wong <djwong@kernel.org.
  */
 #include "fuse_i.h"
+#include "iomap_cache.h"
 #include "fuse_trace.h"
 #include <linux/iomap.h>
 #include <linux/pagemap.h>
@@ -19,14 +20,6 @@ static bool __read_mostly enable_iomap =
 module_param(enable_iomap, bool, 0644);
 MODULE_PARM_DESC(enable_iomap, "Enable file I/O through iomap");
 
-#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
-# define ASSERT(a)		do { WARN(!(a), "Assertion failed: %s, func: %s, line: %d", #a, __func__, __LINE__); } while (0)
-# define BAD_DATA(condition)	(WARN(condition, "Bad mapping: %s, func: %s, line: %d", #condition, __func__, __LINE__))
-#else
-# define ASSERT(a)
-# define BAD_DATA(condition)	(condition)
-#endif
-
 bool fuse_iomap_enabled(void)
 {
 	/*
@@ -1102,6 +1095,21 @@ static inline void fuse_iomap_clear_fileio(struct inode *inode)
 	clear_bit(FUSE_I_IOMAP_FILEIO, &fi->state);
 }
 
+static inline void fuse_iomap_clear_cache(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	ASSERT(fuse_has_iomap(inode));
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
@@ -1122,6 +1130,8 @@ void fuse_iomap_evict_inode(struct inode *inode)
 		fuse_iomap_clear_directio(inode);
 	if (fuse_has_iomap_fileio(inode))
 		fuse_iomap_clear_fileio(inode);
+	if (fuse_has_iomap_cache(inode))
+		fuse_iomap_clear_cache(inode);
 }
 
 ssize_t fuse_iomap_direct_read(struct kiocb *iocb, struct iov_iter *to)
@@ -1641,6 +1651,12 @@ static inline void fuse_iomap_set_fileio(struct inode *inode)
 		min_order = inode->i_blkbits - PAGE_SHIFT;
 
 	mapping_set_folio_min_order(inode->i_mapping, min_order);
+
+	memset(&fi->cache.im_read, 0, sizeof(fi->cache.im_read));
+	fi->cache.im_seq = 0;
+	fi->cache.im_write = NULL;
+
+	init_rwsem(&fi->cache.im_lock);
 	set_bit(FUSE_I_IOMAP_FILEIO, &fi->state);
 }
 
diff --git a/fs/fuse/iomap_cache.c b/fs/fuse/iomap_cache.c
new file mode 100644
index 00000000000000..6244352f543f03
--- /dev/null
+++ b/fs/fuse/iomap_cache.c
@@ -0,0 +1,1651 @@
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
+ * Author: Darrick J. Wong <djwong@kernel.org.
+ */
+#include "fuse_i.h"
+#include "iomap_cache.h"
+#include "fuse_trace.h"
+#include <linux/iomap.h>
+
+static inline void fuse_iomap_cache_lock_flags_assert(unsigned int lock_flags)
+{
+	ASSERT((lock_flags & (FUSE_IOMAP_LOCK_SHARED | FUSE_IOMAP_LOCK_EXCL)) !=
+		(FUSE_IOMAP_LOCK_SHARED | FUSE_IOMAP_LOCK_EXCL));
+	ASSERT(lock_flags != 0);
+}
+
+void fuse_iomap_cache_lock(struct inode *inode, unsigned int lock_flags)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_iomap_cache *ip = &fi->cache;
+
+	fuse_iomap_cache_lock_flags_assert(lock_flags);
+
+	if (lock_flags & FUSE_IOMAP_LOCK_EXCL)
+		down_write(&ip->im_lock);
+	else if (lock_flags & FUSE_IOMAP_LOCK_SHARED)
+		down_read(&ip->im_lock);
+
+	trace_fuse_iomap_cache_lock(inode, lock_flags, _RET_IP_);
+}
+
+void fuse_iomap_cache_unlock(struct inode *inode, unsigned int lock_flags)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_iomap_cache *ip = &fi->cache;
+
+	fuse_iomap_cache_lock_flags_assert(lock_flags);
+
+	trace_fuse_iomap_cache_unlock(inode, lock_flags, _RET_IP_);
+
+	if (lock_flags & FUSE_IOMAP_LOCK_EXCL)
+		up_write(&ip->im_lock);
+	else if (lock_flags & FUSE_IOMAP_LOCK_SHARED)
+		up_read(&ip->im_lock);
+}
+
+static inline void fuse_iomap_assert_locked(struct fuse_iomap_cache *ip,
+					    unsigned int lock_flags)
+{
+	if (lock_flags & FUSE_IOMAP_LOCK_SHARED)
+		rwsem_assert_held(&ip->im_lock);
+	else if (lock_flags & FUSE_IOMAP_LOCK_EXCL)
+		rwsem_assert_held_write_nolockdep(&ip->im_lock);
+}
+
+struct fuse_iext_rec {
+	uint64_t		addr;	/* disk offset of mapping, bytes */
+	loff_t			offset;	/* file offset of mapping, bytes */
+	uint64_t		length;	/* length of mapping, bytes */
+	uint16_t		type;	/* FUSE_IOMAP_TYPE_* */
+	uint16_t		flags;	/* FUSE_IOMAP_F_* */
+	uint32_t		dev;	/* device cookie */
+};
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
+		return FUSE_IEXT_WRITEFORK;
+	return 0;
+}
+
+/* Convert bmap state flags to an inode fork. */
+struct fuse_ifork *
+fuse_iext_state_to_fork(
+	struct fuse_iomap_cache	*ip,
+	unsigned int		state)
+{
+	if (state & FUSE_IEXT_WRITEFORK)
+		return ip->im_write;
+	return &ip->im_read;
+}
+
+static bool fuse_iext_rec_is_empty(const struct fuse_iext_rec *rec)
+{
+	return rec->length == 0;
+}
+
+static inline void fuse_iext_rec_clear(struct fuse_iext_rec *rec)
+{
+	memset(rec, 0, sizeof(*rec));
+}
+
+static void
+fuse_iext_set(
+	struct fuse_iext_rec	*rec,
+	const struct fuse_iomap	*irec)
+{
+	ASSERT(irec->length > 0);
+
+	rec->addr = irec->addr;
+	rec->offset = irec->offset;
+	rec->length = irec->length;
+	rec->type = irec->type;
+	rec->flags = irec->flags;
+	rec->dev = irec->dev;
+}
+
+static void
+fuse_iext_get(
+	struct fuse_iomap		*irec,
+	const struct fuse_iext_rec	*rec)
+{
+	irec->addr = rec->addr;
+	irec->offset = rec->offset;
+	irec->length = rec->length;
+	irec->type = rec->type;
+	irec->flags = rec->flags;
+	irec->dev = rec->dev;
+	/* validity cookie is set at the end of lookup */
+}
+
+enum {
+	NODE_SIZE	= 256,
+	KEYS_PER_NODE	= NODE_SIZE / (sizeof(uint64_t) + sizeof(void *)),
+	RECS_PER_LEAF	= (NODE_SIZE - (2 * sizeof(struct fuse_iext_leaf *))) /
+				sizeof(struct fuse_iext_rec),
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
+	struct fuse_iext_rec	recs[RECS_PER_LEAF];
+	struct fuse_iext_leaf	*prev;
+	struct fuse_iext_leaf	*next;
+};
+
+inline uint64_t fuse_iext_count(const struct fuse_ifork *ifp)
+{
+	return ifp->if_bytes / sizeof(struct fuse_iext_rec);
+}
+
+static inline int fuse_iext_max_recs(const struct fuse_ifork *ifp)
+{
+	if (ifp->if_height == 1)
+		return fuse_iext_count(ifp);
+	return RECS_PER_LEAF;
+}
+
+static inline struct fuse_iext_rec *cur_rec(const struct fuse_iext_cursor *cur)
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
+	struct fuse_iext_rec	*rec,
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
+	ifp->if_data = fuse_iext_alloc_node(sizeof(struct fuse_iext_rec));
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
+	int64_t new_size = ifp->if_bytes + sizeof(struct fuse_iext_rec);
+	void *new;
+
+	/* account for the prev/next pointers */
+	if (new_size / sizeof(struct fuse_iext_rec) == RECS_PER_LEAF)
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
+	struct fuse_iomap_cache	*ip,
+	struct fuse_ifork	*ifp,
+	struct fuse_iext_cursor	*cur,
+	const struct fuse_iomap	*irec)
+{
+	loff_t			offset = irec->offset;
+	struct fuse_iext_leaf	*new = NULL;
+	int			nr_entries, i;
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
+	ifp->if_bytes += sizeof(struct fuse_iext_rec);
+
+	if (new)
+		fuse_iext_insert_node(ifp, fuse_iext_leaf_key(new, 0), new, 2);
+}
+
+void
+fuse_iext_insert(
+	struct fuse_iomap_cache	*ip,
+	struct fuse_iext_cursor	*cur,
+	const struct fuse_iomap	*irec,
+	int			state)
+{
+	struct fuse_ifork	*ifp = fuse_iext_state_to_fork(ip, state);
+
+	fuse_iext_insert_raw(ip, ifp, cur, irec);
+	trace_fuse_iext_insert(VFS_I(ip), cur, state, _RET_IP_);
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
+	trace_fuse_iext_remove(VFS_I(ip), cur, state, _RET_IP_);
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
+	ifp->if_bytes -= sizeof(struct fuse_iext_rec);
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
+	struct fuse_iomap	*gotp)
+{
+	cur->leaf = fuse_iext_find_level(ifp, offset, 1);
+	if (!cur->leaf) {
+		cur->pos = 0;
+		return false;
+	}
+
+	for (cur->pos = 0; cur->pos < fuse_iext_max_recs(ifp); cur->pos++) {
+		struct fuse_iext_rec *rec = cur_rec(cur);
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
+	struct fuse_iomap	*gotp)
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
+	struct fuse_iomap	*new)
+{
+	struct fuse_ifork	*ifp = fuse_iext_state_to_fork(ip, state);
+
+	fuse_iext_inc_seq(ip);
+
+	if (cur->pos == 0) {
+		struct fuse_iomap	old;
+
+		fuse_iext_get(&old, cur_rec(cur));
+		if (new->offset != old.offset) {
+			fuse_iext_update_node(ifp, old.offset,
+					new->offset, 1, cur->leaf);
+		}
+	}
+
+	trace_fuse_iext_pre_update(VFS_I(ip), cur, state, _RET_IP_);
+	fuse_iext_set(cur_rec(cur), new);
+	trace_fuse_iext_post_update(VFS_I(ip), cur, state, _RET_IP_);
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
+	struct fuse_iomap		*gotp)
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
+	enum fuse_iomap_fork	whichfork)
+{
+	switch (whichfork) {
+	case FUSE_IOMAP_READ_FORK:
+		return &ip->im_read;
+	case FUSE_IOMAP_WRITE_FORK:
+		return ip->im_write;
+	default:
+		ASSERT(0);
+		return NULL;
+	}
+}
+
+static inline bool fuse_iomap_addrs_adjacent(const struct fuse_iomap *left,
+					     const struct fuse_iomap *right)
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
+static inline bool fuse_iomap_can_merge(const struct fuse_iomap *left,
+					const struct fuse_iomap *right)
+{
+	return (left->dev == right->dev &&
+		left->offset + left->length == right->offset &&
+		left->type  == right->type &&
+		fuse_iomap_addrs_adjacent(left, right) &&
+		left->flags == right->flags &&
+		left->length + right->length <= FUSE_IOMAP_MAX_LEN);
+}
+
+static inline bool fuse_iomap_can_merge3(const struct fuse_iomap *left,
+					 const struct fuse_iomap *new,
+					 const struct fuse_iomap *right)
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
+	struct fuse_iomap	prev, got;
+	unsigned long long	nr = 0;
+	enum fuse_iomap_fork	whichfork;
+
+	if (!ifp)
+		return;
+
+	if (ifp == ip->im_write)
+		whichfork = FUSE_IOMAP_WRITE_FORK;
+	else
+		whichfork = FUSE_IOMAP_READ_FORK;
+
+	fuse_iext_first(ifp, &icur);
+	if (!fuse_iext_get_extent(ifp, &icur, &prev))
+		return;
+	trace_fuse_iext_check_mapping(inode, whichfork, &prev, _RET_IP_);
+	nr++;
+
+	fuse_iext_next(ifp, &icur);
+	while (fuse_iext_get_extent(ifp, &icur, &got)) {
+		trace_fuse_iext_check_mapping(inode, whichfork, &got, _RET_IP_);
+		if (got.length == 0 ||
+		    got.offset < prev.offset + prev.length ||
+		    fuse_iomap_can_merge(&prev, &got)) {
+			printk(KERN_ERR "FUSE IOMAP CORRUPTION ino=%llu nr=%llu",
+			       fi->orig_ino, nr);
+			printk(KERN_ERR "prev: offset=%llu length=%llu type=%u flags=0x%x cookie=%llu dev=%u addr=%llu\n",
+			       prev.offset, prev.length, prev.type, prev.flags,
+			       prev.validity_cookie, prev.dev, prev.addr);
+			printk(KERN_ERR "curr: offset=%llu length=%llu type=%u flags=0x%x cookie=%llu dev=%u addr=%llu\n",
+			       got.offset, got.length, got.type, got.flags,
+			       got.validity_cookie, got.dev, got.addr);
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
+	struct fuse_iomap	*got,	/* current extent entry */
+	struct fuse_iomap	*del)	/* data to remove from extents */
+{
+	struct fuse_iomap	new;	/* new record to be inserted */
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
+	trace_fuse_iext_del_mapping(VFS_I(ip), state, del);
+	trace_fuse_iext_del_mapping_got(VFS_I(ip), got);
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
+	enum fuse_iomap_fork	whichfork,
+	loff_t			start,		/* first file offset deleted */
+	uint64_t		len)		/* length to unmap */
+{
+	struct fuse_iext_cursor	icur;
+	struct fuse_iomap	got;		/* current extent record */
+	struct fuse_iomap	del;		/* extent being deleted */
+	loff_t			end;
+	struct fuse_inode	*fi = get_fuse_inode(inode);
+	struct fuse_iomap_cache	*ip = &fi->cache;
+	struct fuse_ifork	*ifp = fuse_iomap_fork_ptr(ip, whichfork);
+	bool			wasreal;
+	bool			done = false;
+	int			ret = 0;
+
+	fuse_iomap_assert_locked(ip, FUSE_IOMAP_LOCK_EXCL);
+
+	trace_fuse_iomap_cache_remove(inode, whichfork, start, len, _RET_IP_);
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
+			ret = -EUCLEAN;
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
+		ret = -EUCLEAN;
+
+out:
+	fuse_iext_check_mappings(inode, ip, ifp);
+	return ret;
+}
+
+static void
+fuse_iext_add_mapping(
+	struct fuse_iomap_cache	*ip,
+	struct fuse_ifork	*ifp,
+	struct fuse_iext_cursor	*icur,
+	const struct fuse_iomap	*new)	/* new extent entry */
+{
+	struct fuse_iomap	left;	/* left neighbor extent entry */
+	struct fuse_iomap	right;	/* right neighbor extent entry */
+	uint32_t		state = fuse_iomap_fork_to_state(ip, ifp);
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
+	trace_fuse_iext_add_mapping(VFS_I(ip), state, new);
+	if (state & FUSE_IEXT_LEFT_VALID)
+		trace_fuse_iext_add_mapping_left(VFS_I(ip), &left);
+	if (state & FUSE_IEXT_RIGHT_VALID)
+		trace_fuse_iext_add_mapping_right(VFS_I(ip), &right);
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
+int
+fuse_iomap_cache_add(
+	struct inode		*inode,
+	enum fuse_iomap_fork	whichfork,
+	const struct fuse_iomap	*new)
+{
+	struct fuse_iext_cursor	icur;
+	struct fuse_iomap	got;
+	struct fuse_inode	*fi = get_fuse_inode(inode);
+	struct fuse_iomap_cache	*ip = &fi->cache;
+	struct fuse_ifork	*ifp = fuse_iomap_fork_ptr(ip, whichfork);
+
+	fuse_iomap_assert_locked(ip, FUSE_IOMAP_LOCK_EXCL);
+	ASSERT(new->length > 0);
+	ASSERT(new->offset < inode->i_sb->s_maxbytes);
+
+	trace_fuse_iomap_cache_add(inode, whichfork, new, _RET_IP_);
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
+			return -EUCLEAN;
+	}
+
+	fuse_iext_add_mapping(ip, ifp, &icur, new);
+	fuse_iext_check_mappings(inode, ip, ifp);
+	return 0;
+}
+
+/*
+ * Trim the returned map to the required bounds
+ */
+static void
+fuse_iomap_trim(
+	struct inode		*inode,
+	struct fuse_iomap	*mval,
+	const struct fuse_iomap	*got,
+	loff_t			off,
+	loff_t			len)
+{
+	const unsigned int blocksize = i_blocksize(inode);
+	const loff_t aligned_off = round_down(off, blocksize);
+	const loff_t aligned_end = round_up(off + len, blocksize);
+	const loff_t aligned_len = aligned_end - aligned_off;
+
+	ASSERT(aligned_off >= got->offset);
+
+	switch (got->type) {
+	case FUSE_IOMAP_TYPE_MAPPED:
+	case FUSE_IOMAP_TYPE_UNWRITTEN:
+		mval->addr = got->addr + (aligned_off - got->offset);
+		break;
+	default:
+		mval->addr = FUSE_IOMAP_NULL_ADDR;
+		break;
+	}
+	mval->offset = aligned_off;
+	mval->length = min_t(loff_t, aligned_len,
+			     got->length - (aligned_off - got->offset));
+	mval->type = got->type;
+	mval->flags = got->flags;
+	mval->dev = got->dev;
+}
+
+enum fuse_iomap_lookup_result
+fuse_iomap_cache_lookup(
+	struct inode		*inode,
+	enum fuse_iomap_fork	whichfork,
+	loff_t			off,
+	uint64_t		len,
+	struct fuse_iomap	*mval)
+{
+	struct fuse_iomap	got;
+	struct fuse_iext_cursor	icur;
+	struct fuse_inode	*fi = get_fuse_inode(inode);
+	struct fuse_iomap_cache	*ip = &fi->cache;
+	struct fuse_ifork	*ifp = fuse_iomap_fork_ptr(ip, whichfork);
+
+	fuse_iomap_assert_locked(ip, FUSE_IOMAP_LOCK_SHARED |
+				     FUSE_IOMAP_LOCK_EXCL);
+
+	trace_fuse_iomap_cache_lookup(inode, whichfork, off, len, _RET_IP_);
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
+	fuse_iomap_trim(inode, mval, &got, off, len);
+	mval->validity_cookie = fuse_iext_read_seq(ip);
+	trace_fuse_iomap_cache_lookup_result(inode, whichfork, off, len, &got,
+					     mval);
+	return LOOKUP_HIT;
+}


