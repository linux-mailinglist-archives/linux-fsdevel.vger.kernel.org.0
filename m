Return-Path: <linux-fsdevel+bounces-61554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A69FFB589DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614552A3EE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A099A1A3172;
	Tue, 16 Sep 2025 00:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJdWeMmg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FFDD528;
	Tue, 16 Sep 2025 00:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983214; cv=none; b=hBbJ8LUbkdAkAiM00ra99cslNAmnjsoTaAcVtTc8RoFs/S5ujNR/TmlbzjZLOJKyzkp6YjzX3oI07UmYIXkvYz/zZ3jT8QGGm0a38xLmCU4hAeM8CtsS9Ed2GsP4/8K4REIm4VoxtJsaJjBdP8TCbzFjfPzCDH/jiSECQSI0CXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983214; c=relaxed/simple;
	bh=NebnTawnKDRNxxkrKFWKNLebtE26ACDiXxtNPBeya94=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KfpNFplBWinCQpgoNjdU6i3DpI0LkCLU4n1FtDJwhKKp85W0i8jkwLcybsxedAm3H4MtRNdfI0TZWjt4IN7IB2mDGzJmWijauRwMVTr7LDX9RzvKk+BRlRxebchW4kJ8WR+mWCgYQmkVcREtnSabyPhB/A/vs/qLsWf61q65Gac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJdWeMmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCF5C4CEF1;
	Tue, 16 Sep 2025 00:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983213;
	bh=NebnTawnKDRNxxkrKFWKNLebtE26ACDiXxtNPBeya94=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=vJdWeMmgSHGiZxkFroGY0A1GTESV/y8nPYrEZ4z7Kcv5qy8CPvb26aA9BKAifu3PA
	 NPNWUURSHBDRLQlYDkPu+gUQaQM4rdeXOG3fPkLYnmZSgfOULaB3VQ+HIOIhVluc+S
	 DT3bAk4eymcaqWeqXuJT7fzEFQfat54sUfUFOHIZgL5cQILzELlB59IEgGH8xiaUN1
	 CRcreTCLyrN3FMudfpk3rbwznRnZ4BhLeJEtMJaPrXzhiIP5IzbmsDP3KGsHSEd4Wb
	 mf0EPGX30iyKEznh01QEbrOYJ57kfnu2E/y+ip3I2+5u2exr7ykhB4TkDV5vAoBu/B
	 0N73WbWviM+uA==
Date: Mon, 15 Sep 2025 17:40:13 -0700
Subject: [PATCH 07/10] fuse: enable iomap cache management
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798153076.384360.18335345699036780578.stgit@frogsfrogsfrogs>
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

Provide a means for the fuse server to upload iomappings to the kernel
and invalidate them.  This is how we enable iomap caching for better
performance.  This is also required for correct synchronization between
pagecache writes and writeback.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |    7 +
 include/uapi/linux/fuse.h |   28 +++++
 fs/fuse/dev.c             |   44 ++++++++
 fs/fuse/file_iomap.c      |  239 ++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 314 insertions(+), 4 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c6ec9383a99ce5..d42737bac0af88 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1858,6 +1858,11 @@ enum fuse_iomap_iodir {
 	READ_MAPPING,
 	WRITE_MAPPING,
 };
+
+int fuse_iomap_upsert(struct fuse_conn *fc,
+		      const struct fuse_iomap_upsert_out *outarg);
+int fuse_iomap_inval(struct fuse_conn *fc,
+		     const struct fuse_iomap_inval_out *outarg);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -1888,6 +1893,8 @@ enum fuse_iomap_iodir {
 # define fuse_iomap_dev_inval(...)		(-ENOSYS)
 # define fuse_iomap_fadvise			NULL
 # define fuse_inode_caches_iomaps(...)		(false)
+# define fuse_iomap_upsert(...)			(-ENOSYS)
+# define fuse_iomap_inval(...)			(-ENOSYS)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d4a257517915fd..5c2c594fc87892 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -244,6 +244,8 @@
  *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
  *  - add FUSE_ATTR_{SYNC,IMMUTABLE,APPEND} for VFS enforcement of file
  *    attributes
+ *  - add FUSE_NOTIFY_IOMAP_UPSERT and FUSE_NOTIFY_IOMAP_INVAL so fuse servers
+ *    can cache iomappings in the kernel
  */
 
 #ifndef _LINUX_FUSE_H
@@ -715,6 +717,8 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_RESEND = 7,
 	FUSE_NOTIFY_INC_EPOCH = 8,
 	FUSE_NOTIFY_IOMAP_DEV_INVAL = 9,
+	FUSE_NOTIFY_IOMAP_UPSERT = 10,
+	FUSE_NOTIFY_IOMAP_INVAL = 11,
 	FUSE_NOTIFY_CODE_MAX,
 };
 
@@ -1360,6 +1364,8 @@ struct fuse_uring_cmd_req {
 #define FUSE_IOMAP_TYPE_PURE_OVERWRITE	(255)
 /* fuse-specific mapping type saying the server has populated the cache */
 #define FUSE_IOMAP_TYPE_RETRY_CACHE	(254)
+/* do not upsert this mapping */
+#define FUSE_IOMAP_TYPE_NOCACHE		(253)
 
 #define FUSE_IOMAP_DEV_NULL		(0U)	/* null device cookie */
 
@@ -1505,4 +1511,26 @@ struct fuse_iomap_dev_inval_out {
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
+	/* read file data from here */
+	struct fuse_iomap_io	read;
+
+	/* write file data to here, if applicable */
+	struct fuse_iomap_io	write;
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index adbe2a65e6fe87..b144f67f06160f 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1892,6 +1892,46 @@ static int fuse_notify_iomap_dev_inval(struct fuse_conn *fc, unsigned int size,
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
@@ -2140,6 +2180,10 @@ static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 
 	case FUSE_NOTIFY_IOMAP_DEV_INVAL:
 		return fuse_notify_iomap_dev_inval(fc, size, cs);
+	case FUSE_NOTIFY_IOMAP_UPSERT:
+		return fuse_notify_iomap_upsert(fc, size, cs);
+	case FUSE_NOTIFY_IOMAP_INVAL:
+		return fuse_notify_iomap_inval(fc, size, cs);
 
 	default:
 		fuse_copy_finish(cs);
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index c7b0026bff75f3..ff79a30f6ff8d2 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -166,6 +166,7 @@ static inline bool fuse_iomap_check_type(uint16_t fuse_type)
 	case FUSE_IOMAP_TYPE_INLINE:
 	case FUSE_IOMAP_TYPE_PURE_OVERWRITE:
 	case FUSE_IOMAP_TYPE_RETRY_CACHE:
+	case FUSE_IOMAP_TYPE_NOCACHE:
 		return true;
 	}
 
@@ -272,12 +273,13 @@ static inline bool fuse_iomap_check_mapping(const struct inode *inode,
 	uint64_t end;
 
 	/*
-	 * Type and flags must be known.  Mapping type "retry cache" doesn't
-	 * use any of the other fields.
+	 * Type and flags must be known.  Mapping types "retry cache" and "do
+	 * not insert in cache" don't use any of the other fields.
 	 */
 	if (BAD_DATA(!fuse_iomap_check_type(map->type)))
 		return false;
-	if (map->type == FUSE_IOMAP_TYPE_RETRY_CACHE)
+	if (map->type == FUSE_IOMAP_TYPE_RETRY_CACHE ||
+	    map->type == FUSE_IOMAP_TYPE_NOCACHE)
 		return true;
 	if (BAD_DATA(!fuse_iomap_check_flags(map->flags)))
 		return false;
@@ -331,6 +333,9 @@ static inline bool fuse_iomap_check_mapping(const struct inode *inode,
 		if (BAD_DATA(iodir != WRITE_MAPPING))
 			return false;
 		break;
+	case FUSE_IOMAP_TYPE_NOCACHE:
+		/* We're ignoring this mapping */
+		break;
 	default:
 		/* should have been caught already */
 		ASSERT(0);
@@ -386,6 +391,15 @@ fuse_iomap_begin_validate(const struct inode *inode,
 	if (!fuse_iomap_check_mapping(inode, &outarg->write, WRITE_MAPPING))
 		return -EFSCORRUPTED;
 
+	/*
+	 * ->iomap_begin requires real mappings or "retry from cache"; "do not
+	 * add to cache" does not apply here.
+	 */
+	if (BAD_DATA(outarg->read.type == FUSE_IOMAP_TYPE_NOCACHE))
+		return -EFSCORRUPTED;
+	if (BAD_DATA(outarg->write.type == FUSE_IOMAP_TYPE_NOCACHE))
+		return -EFSCORRUPTED;
+
 	/*
 	 * Must have returned a mapping for at least the first byte in the
 	 * range.  The main mapping check already validated that the length
@@ -613,9 +627,11 @@ fuse_iomap_cached_validate(const struct inode *inode,
 	if (!fuse_iomap_check_mapping(inode, &lmap->map, dir))
 		return -EFSCORRUPTED;
 
-	/* The cache should not be storing "retry cache" mappings */
+	/* The cache should not be storing cache management mappings */
 	if (BAD_DATA(lmap->map.type == FUSE_IOMAP_TYPE_RETRY_CACHE))
 		return -EFSCORRUPTED;
+	if (BAD_DATA(lmap->map.type == FUSE_IOMAP_TYPE_NOCACHE))
+		return -EFSCORRUPTED;
 
 	return 0;
 }
@@ -2447,3 +2463,218 @@ void fuse_iomap_copied_file_range(struct inode *inode, loff_t offset,
 
 	fuse_iomap_cache_invalidate_range(inode, offset, written);
 }
+
+static inline bool
+fuse_iomap_upsert_validate_dev(
+	const struct fuse_backing	*fb,
+	const struct fuse_iomap_io	*map)
+{
+	uint64_t			map_end;
+	sector_t			device_bytes;
+
+	if (!fb) {
+		if (BAD_DATA(map->addr != FUSE_IOMAP_NULL_ADDR))
+			return false;
+
+		return true;
+	}
+
+	if (BAD_DATA(map->addr == FUSE_IOMAP_NULL_ADDR))
+		return false;
+
+	if (BAD_DATA(check_add_overflow(map->addr, map->length, &map_end)))
+		return false;
+
+	device_bytes = bdev_nr_sectors(fb->bdev) << SECTOR_SHIFT;
+	if (BAD_DATA(map_end > device_bytes))
+		return false;
+
+	return true;
+}
+
+/* Validate one of the incoming upsert mappings */
+static inline bool
+fuse_iomap_upsert_validate_mapping(struct inode *inode,
+				   enum fuse_iomap_iodir iodir,
+				   const struct fuse_iomap_io *map)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_backing *fb;
+	bool ret;
+
+	if (!fuse_iomap_check_mapping(inode, map, iodir))
+		return false;
+
+	/*
+	 * A "retry cache" instruction makes no sense when we're adding to
+	 * the mapping cache.
+	 */
+	if (BAD_DATA(map->type == FUSE_IOMAP_TYPE_RETRY_CACHE))
+		return false;
+
+	if (map->type == FUSE_IOMAP_TYPE_NOCACHE)
+		return true;
+
+	/* Make sure we can find the device */
+	fb = fuse_iomap_find_dev(fc, map);
+	if (IS_ERR(fb))
+		return false;
+
+	ret = fuse_iomap_upsert_validate_dev(fb, map);
+	fuse_backing_put(fb);
+	return ret;
+}
+
+/* Check the incoming upsert mappings to make sure they're not nonsense */
+static inline int
+fuse_iomap_upsert_validate(struct inode *inode,
+			   const struct fuse_iomap_upsert_out *outarg)
+{
+	if (!fuse_iomap_upsert_validate_mapping(inode, READ_MAPPING,
+						&outarg->read))
+		return -EFSCORRUPTED;
+	if (!fuse_iomap_upsert_validate_mapping(inode, WRITE_MAPPING,
+						&outarg->write))
+		return -EFSCORRUPTED;
+
+	return 0;
+}
+
+int fuse_iomap_upsert(struct fuse_conn *fc,
+		      const struct fuse_iomap_upsert_out *outarg)
+{
+	struct inode *inode;
+	struct fuse_inode *fi;
+	int ret;
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
+	fi = get_fuse_inode(inode);
+	if (BAD_DATA(fi->orig_ino != outarg->attr_ino)) {
+		ret = -EINVAL;
+		goto out_inode;
+	}
+
+	if (fuse_is_bad(inode)) {
+		ret = -EIO;
+		goto out_inode;
+	}
+
+	ret = fuse_iomap_upsert_validate(inode, outarg);
+	if (ret)
+		goto out_inode;
+
+	fuse_iomap_cache_lock(inode);
+
+	set_bit(FUSE_I_IOMAP_CACHE, &fi->state);
+
+	if (outarg->read.type != FUSE_IOMAP_TYPE_NOCACHE) {
+		ret = fuse_iomap_cache_upsert(inode, READ_MAPPING,
+					      &outarg->read);
+		if (ret)
+			goto out_unlock;
+	}
+
+	if (outarg->write.type != FUSE_IOMAP_TYPE_NOCACHE) {
+		ret = fuse_iomap_cache_upsert(inode, WRITE_MAPPING,
+					      &outarg->write);
+		if (ret)
+			goto out_unlock;
+	}
+
+out_unlock:
+	fuse_iomap_cache_unlock(inode);
+out_inode:
+	iput(inode);
+out_sb:
+	up_read(&fc->killsb);
+	return ret;
+}
+
+static inline bool fuse_iomap_inval_validate(const struct inode *inode,
+					     uint64_t offset, uint64_t length)
+{
+	const unsigned int blocksize = i_blocksize(inode);
+
+	if (length == 0)
+		return true;
+
+	/* Range can't start beyond maxbytes */
+	if (BAD_DATA(offset >= inode->i_sb->s_maxbytes))
+		return false;
+
+	/* File range must be aligned to blocksize */
+	if (BAD_DATA(!IS_ALIGNED(offset, blocksize)))
+		return false;
+	if (length != FUSE_IOMAP_INVAL_TO_EOF &&
+	    BAD_DATA(!IS_ALIGNED(length, blocksize)))
+		return false;
+
+	return true;
+}
+
+int fuse_iomap_inval(struct fuse_conn *fc,
+		     const struct fuse_iomap_inval_out *outarg)
+{
+	struct inode *inode;
+	struct fuse_inode *fi;
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
+	fi = get_fuse_inode(inode);
+	if (BAD_DATA(fi->orig_ino != outarg->attr_ino)) {
+		ret = -EINVAL;
+		goto out_inode;
+	}
+
+	if (fuse_is_bad(inode)) {
+		ret = -EIO;
+		goto out_inode;
+	}
+
+	if (!fuse_iomap_inval_validate(inode, outarg->write_offset,
+				       outarg->write_length)) {
+		ret = -EFSCORRUPTED;
+		goto out_inode;
+	}
+
+	if (!fuse_iomap_inval_validate(inode, outarg->read_offset,
+				       outarg->read_length)) {
+		ret = -EFSCORRUPTED;
+		goto out_inode;
+	}
+
+	fuse_iomap_cache_lock(inode);
+	if (outarg->read_length)
+		ret2 = fuse_iomap_cache_remove(inode, READ_MAPPING,
+					       outarg->read_offset,
+					       outarg->read_length);
+	if (outarg->write_length)
+		ret = fuse_iomap_cache_remove(inode, WRITE_MAPPING,
+					      outarg->write_offset,
+					      outarg->write_length);
+	fuse_iomap_cache_unlock(inode);
+
+out_inode:
+	iput(inode);
+out_sb:
+	up_read(&fc->killsb);
+	return ret ? ret : ret2;
+}


