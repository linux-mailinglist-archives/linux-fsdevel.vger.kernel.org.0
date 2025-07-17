Return-Path: <linux-fsdevel+bounces-55338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C585B09814
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477801C23875
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0C1253359;
	Thu, 17 Jul 2025 23:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEEAW8LG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175AA2AEF5
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795156; cv=none; b=PHWsJUFBarOjnMU5F9xKPBlo+iDbKpQXFgpAT5ir8ZUSWR7YBv36BXJFqxQ5CbQGH/1QF8gwz/rt8OXwu4w4UYR554ZXXzxXG9YTSn+b2l5iarzmN5QoQ+kOgDXswKt/iCKtpCXha5jM5ZSn7mDdtajMzv4+TWHRJIo6KMfvfsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795156; c=relaxed/simple;
	bh=9gC3p0HWNOhIb3ljtq38789JGWgYGl4NRnavfoA7cKY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WorgHS4cKYYtMQlqE30l/snhkTI2SZVM5B4F7pNS+xKUl15gyy+KL+SiGraHcIGYjUxWG82hP7BoL/Mv2QqnTv0qO6qsVGBCRcOLNjUlmDoiS0FmKpEHjI/HOBgMl+JNAQtyoffhuemMlKYXTFlMN+roTDz9IZ5U1WrqrLCJ8cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEEAW8LG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43C7C4CEE3;
	Thu, 17 Jul 2025 23:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795155;
	bh=9gC3p0HWNOhIb3ljtq38789JGWgYGl4NRnavfoA7cKY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hEEAW8LGkpLqQw2aNr4VheDJS7oij2pMPveKbezbjiDVuWfB2fYk5ASRalF70mk6i
	 gcNIScS9RyhFMeYxLZwc2czguidMbzv2puMyfUmL1NXeW16ZzUP8q1RRb25OxjkbGn
	 3j9FiA2K5F9pRPnxOT637eh/fXPhcR5ZcPA5Q/5qroF2YxyyoyvP7ovQwWRX3U+sTJ
	 mdG6yR2DYzZVdpK+Ahkhd5xggm1gaUxuMgrftx0H0yMwmAh+Q/0DxID+uZyh/sHZBU
	 h/n5cmRBTzM5g7Qylk0KnWfSty/A2oH9Fff5X2P9XsVibuuAYhBOaKvFK1ZaGfR2dC
	 m2g9riJjdibuA==
Date: Thu, 17 Jul 2025 16:32:35 -0700
Subject: [PATCH 4/4] fuse: enable iomap cache management
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279450529.713483.2344911513290818986.stgit@frogsfrogsfrogs>
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

Provide a means for the fuse server to upload iomappings to the kernel
and invalidate them.  This is how we enable iomap caching for better
performance.  This is also required for correct synchronization between
pagecache writes and writeback.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |    7 +
 fs/fuse/fuse_trace.h      |  105 ++++++++++++++
 include/uapi/linux/fuse.h |   34 +++++
 fs/fuse/dev.c             |   45 ++++++
 fs/fuse/file_iomap.c      |  335 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 526 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 3b51aa6b50b8ab..e7da75d8a5741d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1811,6 +1811,11 @@ static inline int fuse_iomap_cache_invalidate(struct inode *inode,
 	return fuse_iomap_cache_invalidate_range(inode, offset,
 						 FUSE_IOMAP_INVAL_TO_EOF);
 }
+
+int fuse_iomap_upsert(struct fuse_conn *fc,
+		      const struct fuse_iomap_upsert_out *outarg);
+int fuse_iomap_inval(struct fuse_conn *fc,
+		     const struct fuse_iomap_inval_out *outarg);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -1848,6 +1853,8 @@ static inline int fuse_iomap_cache_invalidate(struct inode *inode,
 # define fuse_iomap_cache_upsert(...)		(-ENOSYS)
 # define fuse_iomap_cache_invalidate_range(...)	(-ENOSYS)
 # define fuse_iomap_cache_invalidate(...)	(-ENOSYS)
+# define fuse_iomap_upsert(...)			(-ENOSYS)
+# define fuse_iomap_inval(...)			(-ENOSYS)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 547c548163ab54..cc22635790b68c 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -841,6 +841,7 @@ DEFINE_EVENT(fuse_inode_state_class, name,	\
 	TP_ARGS(inode))
 DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_init_inode);
 DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_evict_inode);
+DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_cache_enable);
 
 TRACE_EVENT(fuse_iomap_end_ioend,
 	TP_PROTO(const struct iomap_ioend *ioend),
@@ -1828,6 +1829,110 @@ TRACE_EVENT(fuse_iomap_invalid,
 		  __entry->addr, __entry->old_validity_cookie,
 		  __entry->validity_cookie)
 );
+
+TRACE_EVENT(fuse_iomap_upsert,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_iomap_upsert_out *outarg),
+	TP_ARGS(inode, outarg),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+		__field(uint64_t,		ino)
+		__field(uint64_t,		nodeid)
+		__field(loff_t,			isize)
+		__field(uint64_t,		attr_ino)
+
+		__field(uint64_t,		read_offset)
+		__field(uint64_t,		read_length)
+		__field(uint64_t,		read_addr)
+		__field(uint16_t,		read_maptype)
+		__field(uint16_t,		read_mapflags)
+		__field(uint32_t,		read_dev)
+
+		__field(uint64_t,		write_offset)
+		__field(uint64_t,		write_length)
+		__field(uint64_t,		write_addr)
+		__field(uint16_t,		write_maptype)
+		__field(uint16_t,		write_mapflags)
+		__field(uint32_t,		write_dev)
+	),
+
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->nodeid		=	outarg->nodeid;
+		__entry->isize		=	i_size_read(inode);
+		__entry->attr_ino	=	outarg->attr_ino;
+		__entry->read_offset	=	outarg->read_offset;
+		__entry->read_length	=	outarg->read_length;
+		__entry->read_addr	=	outarg->read_addr;
+		__entry->read_maptype	=	outarg->read_type;
+		__entry->read_mapflags	=	outarg->read_flags;
+		__entry->read_dev	=	outarg->read_dev;
+		__entry->write_offset	=	outarg->write_offset;
+		__entry->write_length	=	outarg->write_length;
+		__entry->write_addr	=	outarg->write_addr;
+		__entry->write_maptype	=	outarg->write_type;
+		__entry->write_mapflags	=	outarg->write_flags;
+		__entry->write_dev	=	outarg->write_dev;
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx attr_ino 0x%llx read offset 0x%llx read_length 0x%llx read_addr 0x%llx read_maptype %s read_mapflags (%s) read_dev %u write_offset 0x%llx write_length 0x%llx write_addr 0x%llx write_maptype %s write_mapflags (%s) write_dev %u",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize, __entry->attr_ino, __entry->read_offset,
+		  __entry->read_length, __entry->read_addr,
+		  __print_symbolic(__entry->read_maptype, FUSE_IOMAP_TYPE_STRINGS),
+		  __print_flags(__entry->read_mapflags, "|", FUSE_IOMAP_F_STRINGS),
+		  __entry->read_dev, __entry->write_offset,
+		  __entry->write_length, __entry->write_addr,
+		  __print_symbolic(__entry->write_maptype, FUSE_IOMAP_TYPE_STRINGS),
+		  __print_flags(__entry->write_mapflags, "|", FUSE_IOMAP_F_STRINGS),
+		  __entry->write_dev)
+);
+
+TRACE_EVENT(fuse_iomap_inval,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_iomap_inval_out *outarg),
+	TP_ARGS(inode, outarg),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+		__field(uint64_t,		ino)
+		__field(uint64_t,		nodeid)
+		__field(loff_t,			isize)
+		__field(uint64_t,		attr_ino)
+
+		__field(uint64_t,		read_offset)
+		__field(uint64_t,		read_length)
+
+		__field(uint64_t,		write_offset)
+		__field(uint64_t,		write_length)
+	),
+
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->nodeid		=	outarg->nodeid;
+		__entry->isize		=	i_size_read(inode);
+		__entry->attr_ino	=	outarg->attr_ino;
+		__entry->read_offset	=	outarg->read_offset;
+		__entry->read_length	=	outarg->read_length;
+		__entry->write_offset	=	outarg->write_offset;
+		__entry->write_length	=	outarg->write_length;
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx attr_ino 0x%llx read offset 0x%llx read_length 0x%llx write_offset 0x%llx write_length 0x%llx",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize, __entry->attr_ino, __entry->read_offset,
+		  __entry->read_length, __entry->write_offset,
+		  __entry->write_length)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index a9b2d68b4b79c3..0068bc32a920a7 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -243,6 +243,8 @@
  *  - add FUSE_IOMAP_DIRECTIO/FUSE_ATTR_IOMAP_DIRECTIO for direct I/O support
  *  - add FUSE_IOMAP_FILEIO/FUSE_ATTR_IOMAP_FILEIO for buffered I/O support
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
+ *  - add FUSE_NOTIFY_IOMAP_UPSERT and FUSE_NOTIFY_IOMAP_INVAL so fuse servers
+ *    can cache iomappings in the kernel
  */
 
 #ifndef _LINUX_FUSE_H
@@ -699,6 +701,8 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_DELETE = 6,
 	FUSE_NOTIFY_RESEND = 7,
 	FUSE_NOTIFY_INC_EPOCH = 8,
+	FUSE_NOTIFY_IOMAP_UPSERT = 9,
+	FUSE_NOTIFY_IOMAP_INVAL = 10,
 	FUSE_NOTIFY_CODE_MAX,
 };
 
@@ -1466,4 +1470,34 @@ struct fuse_iomap_config_out {
 /* invalidate all cached iomap mappings up to EOF */
 #define FUSE_IOMAP_INVAL_TO_EOF		(~0ULL)
 
+struct fuse_iomap_inval_out {
+	uint64_t nodeid;	/* Inode ID */
+	uint64_t attr_ino;	/* matches fuse_attr:ino */
+
+	uint64_t read_offset;	/* range to invalidate read iomaps, bytes */
+	uint64_t read_length;	/* can be FUSE_IOMAP_INVAL_TO_EOF */
+
+	uint64_t write_offset;	/* range to invalidate write iomaps, bytes */
+	uint64_t write_length;	/* can be FUSE_IOMAP_INVAL_TO_EOF */
+};
+
+struct fuse_iomap_upsert_out {
+	uint64_t nodeid;	/* Inode ID */
+	uint64_t attr_ino;	/* matches fuse_attr:ino */
+
+	uint64_t read_offset;	/* file offset of mapping, bytes */
+	uint64_t read_length;	/* length of mapping, bytes */
+	uint64_t read_addr;	/* disk offset of mapping, bytes */
+	uint16_t read_type;	/* FUSE_IOMAP_TYPE_* */
+	uint16_t read_flags;	/* FUSE_IOMAP_F_* */
+	uint32_t read_dev;	/* device cookie */
+
+	uint64_t write_offset;	/* file offset of mapping, bytes */
+	uint64_t write_length;	/* length of mapping, bytes */
+	uint64_t write_addr;	/* disk offset of mapping, bytes */
+	uint16_t write_type;	/* FUSE_IOMAP_TYPE_* */
+	uint16_t write_flags;	/* FUSE_IOMAP_F_* */
+	uint32_t write_dev;	/* device cookie * */
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 3dd04c2fdae7ba..abb24f99ed163e 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1835,6 +1835,46 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	return err;
 }
 
+static int fuse_notify_iomap_upsert(struct fuse_conn *fc, unsigned int size,
+				    struct fuse_copy_state *cs)
+{
+	struct fuse_iomap_upsert_out outarg;
+	int err = -EINVAL;
+
+	if (size != sizeof(outarg))
+		goto err;
+
+	err = fuse_copy_one(cs, &outarg, sizeof(outarg));
+	if (err)
+		goto err;
+	fuse_copy_finish(cs);
+
+	return fuse_iomap_upsert(fc, &outarg);
+err:
+	fuse_copy_finish(cs);
+	return err;
+}
+
+static int fuse_notify_iomap_inval(struct fuse_conn *fc, unsigned int size,
+				   struct fuse_copy_state *cs)
+{
+	struct fuse_iomap_inval_out outarg;
+	int err = -EINVAL;
+
+	if (size != sizeof(outarg))
+		goto err;
+
+	err = fuse_copy_one(cs, &outarg, sizeof(outarg));
+	if (err)
+		goto err;
+	fuse_copy_finish(cs);
+
+	return fuse_iomap_inval(fc, &outarg);
+err:
+	fuse_copy_finish(cs);
+	return err;
+}
+
 struct fuse_retrieve_args {
 	struct fuse_args_pages ap;
 	struct fuse_notify_retrieve_in inarg;
@@ -2081,6 +2121,11 @@ static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 	case FUSE_NOTIFY_INC_EPOCH:
 		return fuse_notify_inc_epoch(fc);
 
+	case FUSE_NOTIFY_IOMAP_UPSERT:
+		return fuse_notify_iomap_upsert(fc, size, cs);
+	case FUSE_NOTIFY_IOMAP_INVAL:
+		return fuse_notify_iomap_inval(fc, size, cs);
+
 	default:
 		fuse_copy_finish(cs);
 		return -EINVAL;
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index bffadbf5660bff..7bf522283f2e72 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -2333,3 +2333,338 @@ void fuse_iomap_copied_file_range(struct inode *inode, loff_t offset,
 
 	fuse_iomap_cache_invalidate_range(inode, offset, written);
 }
+
+static inline int
+fuse_iomap_upsert_validate_dev(
+	const struct fuse_iomap_dev	*fb,
+	uint16_t			map_type,
+	uint64_t			map_addr,
+	uint64_t			map_length)
+{
+	uint64_t			map_end;
+	sector_t			device_bytes;
+
+	if (!fb) {
+		if (BAD_DATA(map_addr != FUSE_IOMAP_NULL_ADDR))
+			return -EIO;
+
+		return 0;
+	}
+
+	if (BAD_DATA(map_addr == FUSE_IOMAP_NULL_ADDR))
+		return -EIO;
+
+	if (BAD_DATA(check_add_overflow(map_addr, map_length, &map_end)))
+		return -EIO;
+
+	device_bytes = bdev_nr_sectors(fb->bdev) << SECTOR_SHIFT;
+	if (BAD_DATA(map_end > device_bytes))
+		return -EIO;
+
+	return 0;
+}
+
+/* Check the incoming mappings to make sure they're not nonsense */
+static inline int
+fuse_iomap_upsert_validate(struct fuse_conn *fc,
+			   const struct fuse_iomap_upsert_out *outarg)
+{
+	uint64_t n;
+	int ret;
+
+	/* No garbage mapping types or flags */
+	if (BAD_DATA(!fuse_iomap_check_type(outarg->write_type)))
+		return -EIO;
+	if (BAD_DATA(!fuse_iomap_check_flags(outarg->write_flags)))
+		return -EIO;
+
+	if (BAD_DATA(!fuse_iomap_check_type(outarg->read_type)))
+		return -EIO;
+	if (BAD_DATA(!fuse_iomap_check_flags(outarg->read_flags)))
+		return -EIO;
+
+	/* No zero-length mappings; we'll check offset/maxbytes later */
+	if (BAD_DATA(outarg->read_length == 0))
+		return -EIO;
+	if (BAD_DATA(outarg->write_length == 0))
+		return -EIO;
+
+	/* No overflows in the file range */
+	if (BAD_DATA(check_add_overflow(outarg->read_offset,
+					outarg->read_length, &n)))
+		return -EIO;
+	if (BAD_DATA(check_add_overflow(outarg->write_offset,
+					outarg->write_length, &n)))
+		return -EIO;
+
+	switch (outarg->read_type) {
+	case FUSE_IOMAP_TYPE_PURE_OVERWRITE:
+		/* "Pure overwrite" only allowed for write mapping */
+		BAD_DATA(outarg->read_type == FUSE_IOMAP_TYPE_PURE_OVERWRITE);
+		return -EIO;
+	case FUSE_IOMAP_TYPE_MAPPED:
+	case FUSE_IOMAP_TYPE_UNWRITTEN:
+		/* Mappings backed by space must have a device/addr */
+		if (BAD_DATA(outarg->read_dev == FUSE_IOMAP_DEV_NULL))
+			return -EIO;
+		if (BAD_DATA(outarg->read_addr == FUSE_IOMAP_NULL_ADDR))
+			return -EIO;
+		break;
+	case FUSE_IOMAP_TYPE_DELALLOC:
+	case FUSE_IOMAP_TYPE_HOLE:
+	case FUSE_IOMAP_TYPE_INLINE:
+		/* Mappings not backed by space cannot have a device addr. */
+		if (BAD_DATA(outarg->read_dev != FUSE_IOMAP_DEV_NULL))
+			return -EIO;
+		if (BAD_DATA(outarg->read_addr != FUSE_IOMAP_NULL_ADDR))
+			return -EIO;
+		break;
+	case FUSE_IOMAP_TYPE_NULL:
+		/* We're ignoring this mapping */
+		break;
+	default:
+		/* should have been caught already */
+		return -EIO;
+	}
+
+	switch (outarg->write_type) {
+	case FUSE_IOMAP_TYPE_MAPPED:
+	case FUSE_IOMAP_TYPE_UNWRITTEN:
+		/* Mappings backed by space must have a device/addr */
+		if (BAD_DATA(outarg->write_dev == FUSE_IOMAP_DEV_NULL))
+			return -EIO;
+		if (BAD_DATA(outarg->write_addr == FUSE_IOMAP_NULL_ADDR))
+			return -EIO;
+		break;
+	case FUSE_IOMAP_TYPE_PURE_OVERWRITE:
+	case FUSE_IOMAP_TYPE_DELALLOC:
+	case FUSE_IOMAP_TYPE_HOLE:
+	case FUSE_IOMAP_TYPE_INLINE:
+		/* Mappings not backed by space cannot have a device addr. */
+		if (BAD_DATA(outarg->write_dev != FUSE_IOMAP_DEV_NULL))
+			return -EIO;
+		if (BAD_DATA(outarg->write_addr != FUSE_IOMAP_NULL_ADDR))
+			return -EIO;
+		break;
+	case FUSE_IOMAP_TYPE_NULL:
+		/* We're ignoring this mapping */
+		break;
+	default:
+		/* should have been caught already */
+		return -EIO;
+	}
+
+	if (outarg->read_type != FUSE_IOMAP_TYPE_NULL) {
+		struct fuse_iomap_dev *fb = fuse_iomap_find_dev(fc,
+							outarg->read_type,
+							outarg->read_dev);
+
+		if (IS_ERR(fb))
+			return PTR_ERR(fb);
+
+		ret = fuse_iomap_upsert_validate_dev(fb, outarg->read_type,
+						     outarg->read_addr,
+						     outarg->read_length);
+		fuse_iomap_dev_put(fb);
+		if (ret)
+			return ret;
+	}
+
+	if (outarg->write_type != FUSE_IOMAP_TYPE_NULL) {
+		struct fuse_iomap_dev *fb = fuse_iomap_find_dev(fc,
+							outarg->write_type,
+							outarg->write_dev);
+
+		if (IS_ERR(fb))
+			return PTR_ERR(fb);
+
+		ret = fuse_iomap_upsert_validate_dev(fb, outarg->write_type,
+						     outarg->write_addr,
+						     outarg->write_length);
+		fuse_iomap_dev_put(fb);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static inline int
+fuse_iomap_upsert_validate_range(const struct inode *inode,
+				 const struct fuse_iomap *map)
+{
+	const unsigned int blocksize = i_blocksize(inode);
+
+	/* Mapping can't start beyond maxbytes */
+	if (BAD_DATA(map->offset >= inode->i_sb->s_maxbytes))
+		return -EIO;
+
+	/* File range must be aligned to blocksize */
+	if (BAD_DATA(!IS_ALIGNED(map->offset, blocksize)))
+		return -EIO;
+	if (BAD_DATA(!IS_ALIGNED(map->length, blocksize)))
+		return -EIO;
+
+	return 0;
+}
+
+int fuse_iomap_upsert(struct fuse_conn *fc,
+		      const struct fuse_iomap_upsert_out *outarg)
+{
+	struct inode *inode;
+	struct fuse_inode *fi;
+	struct fuse_iomap read_map = {
+		.offset		= outarg->read_offset,
+		.length		= outarg->read_length,
+		.addr		= outarg->read_addr,
+		.type		= outarg->read_type,
+		.flags		= outarg->read_flags,
+		.dev		= outarg->read_dev,
+	};
+	struct fuse_iomap write_map = {
+		.offset		= outarg->write_offset,
+		.length		= outarg->write_length,
+		.addr		= outarg->write_addr,
+		.type		= outarg->write_type,
+		.flags		= outarg->write_flags,
+		.dev		= outarg->write_dev,
+	};
+	int ret;
+
+	if (!fc->iomap)
+		return -EINVAL;
+
+	ret = fuse_iomap_upsert_validate(fc, outarg);
+	if (ret)
+		return ret;
+
+	down_read(&fc->killsb);
+	inode = fuse_ilookup(fc, outarg->nodeid, NULL);
+	if (!inode) {
+		ret = -ESTALE;
+		goto out_sb;
+	}
+
+	trace_fuse_iomap_upsert(inode, outarg);
+
+	fi = get_fuse_inode(inode);
+	if (fi->orig_ino != outarg->attr_ino) {
+		ret = -EINVAL;
+		goto out_inode;
+	}
+
+	if (fuse_is_bad(inode)) {
+		ret = -EIO;
+		goto out_inode;
+	}
+
+	if (read_map.type != FUSE_IOMAP_TYPE_NULL) {
+		ret = fuse_iomap_upsert_validate_range(inode, &read_map);
+		if (ret)
+			goto out_inode;
+	}
+
+	if (write_map.type != FUSE_IOMAP_TYPE_NULL) {
+		ret = fuse_iomap_upsert_validate_range(inode, &write_map);
+		if (ret)
+			goto out_inode;
+	}
+
+	fuse_iomap_cache_lock(inode, FUSE_IOMAP_LOCK_EXCL);
+
+	if (!test_and_set_bit(FUSE_I_IOMAP_CACHE, &fi->state))
+		trace_fuse_iomap_cache_enable(inode);
+
+	if (read_map.type != FUSE_IOMAP_TYPE_NULL) {
+		ret = fuse_iomap_cache_upsert(inode, FUSE_IOMAP_READ_FORK,
+					      &read_map);
+		if (ret)
+			goto out_unlock;
+	}
+
+	if (write_map.type != FUSE_IOMAP_TYPE_NULL) {
+		ret = fuse_iomap_cache_upsert(inode, FUSE_IOMAP_WRITE_FORK,
+					      &write_map);
+		if (ret)
+			goto out_unlock;
+	}
+
+out_unlock:
+	fuse_iomap_cache_unlock(inode, FUSE_IOMAP_LOCK_EXCL);
+out_inode:
+	iput(inode);
+out_sb:
+	up_read(&fc->killsb);
+	return ret;
+}
+
+static inline int fuse_iomap_inval_validate(const struct inode *inode,
+					    uint64_t offset, uint64_t length)
+{
+	const unsigned int blocksize = i_blocksize(inode);
+
+	/* Range can't start beyond maxbytes */
+	if (BAD_DATA(offset >= inode->i_sb->s_maxbytes))
+		return -EIO;
+
+	/* File range must be aligned to blocksize */
+	if (BAD_DATA(!IS_ALIGNED(offset, blocksize)))
+		return -EIO;
+	if (length != FUSE_IOMAP_INVAL_TO_EOF &&
+	    BAD_DATA(!IS_ALIGNED(length, blocksize)))
+		return -EIO;
+
+	return 0;
+}
+
+int fuse_iomap_inval(struct fuse_conn *fc,
+		     const struct fuse_iomap_inval_out *outarg)
+{
+	struct inode *inode;
+	uint64_t read_length = outarg->read_length;
+	uint64_t write_length = outarg->write_length;
+	int ret = 0, ret2 = 0;
+
+	if (!fc->iomap)
+		return -EINVAL;
+
+	down_read(&fc->killsb);
+	inode = fuse_ilookup(fc, outarg->nodeid, NULL);
+	if (!inode) {
+		ret = -ESTALE;
+		goto out_sb;
+	}
+
+	trace_fuse_iomap_inval(inode, outarg);
+
+	if (fuse_is_bad(inode)) {
+		ret = -EIO;
+		goto out_inode;
+	}
+
+	if (write_length)
+		ret = fuse_iomap_inval_validate(inode, outarg->write_offset,
+						write_length);
+	if (read_length)
+		ret2 = fuse_iomap_inval_validate(inode, outarg->read_offset,
+						 read_length);
+	if (ret || ret2)
+		goto out_inode;
+
+	fuse_iomap_cache_lock(inode, FUSE_IOMAP_LOCK_EXCL);
+	if (read_length)
+		ret2 = fuse_iomap_cache_remove(inode, FUSE_IOMAP_READ_FORK,
+					       outarg->read_offset,
+					       read_length);
+	if (write_length)
+		ret = fuse_iomap_cache_remove(inode, FUSE_IOMAP_WRITE_FORK,
+					      outarg->write_offset,
+					      write_length);
+	fuse_iomap_cache_unlock(inode, FUSE_IOMAP_LOCK_EXCL);
+
+out_inode:
+	iput(inode);
+out_sb:
+	up_read(&fc->killsb);
+	return ret ? ret : ret2;
+}


