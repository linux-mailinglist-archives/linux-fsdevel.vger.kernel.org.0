Return-Path: <linux-fsdevel+bounces-78099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFD2LGLhnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:23:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E9A17F412
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 023BA3028051
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660E237F750;
	Mon, 23 Feb 2026 23:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t27xqKoB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F55125D0;
	Mon, 23 Feb 2026 23:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888935; cv=none; b=ig9QmpumJK51zM4VjEAcaHrTzjYyFl5XF0DK40x4Z8Xc+EDH73/yGNQUKoxWYE+P7Oq2a23YO3B3une4aWVLXdqJpc+40BnehX/TK/Usy0ksMfK+xljN0cb8T9SHhkQoX5/aPe13M9RUrx+vHCRT8NYIrzc6BLiaEJpKmymrpL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888935; c=relaxed/simple;
	bh=T0K/lCUqFwQBH1YWvXzZPwc3d0RK6MZZZjuotpRxCuU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VAOg7x2dGbOC4lsZihZtHYG02SY1oBKkD2xfSEvJ7/wLqr1ZF3Ir0KoYSfnFiYqxjwDA9jJIDAYXQdhkK2ojkrLi7GNTcupNrUhbGQAP3t9fnb6LWZAtyxoz7UTF1wUarLh7lkchmGiWc54uKJ1JjIctt1CMb9XBnvn/IC4sMtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t27xqKoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6B1C116C6;
	Mon, 23 Feb 2026 23:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888934;
	bh=T0K/lCUqFwQBH1YWvXzZPwc3d0RK6MZZZjuotpRxCuU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=t27xqKoB+PwuXheV/blB6QjNAFPuwY+1yGfpPIdQF5NSL+jRE7hxl//ue9cjKQ4DL
	 t1pOjKTIobKf4cZWA0Z0ilYKNdjOOqOTS+ikYFrZkgTE1+mxn8dMlqydCNNlKgful+
	 WUq+wHQo+wQyg7aiTYIN1w/vqIrc2NClQvZidWh69FQuwg9dOcZgawqLxIvPUjPzJy
	 SzibP3uKaB3mLnQaU1jZeJZlFLXS7eOn06lKOi+6dWhgnFr/4Q1ibkElsaOf0fnBFj
	 FKlO9sUc+m3Aul6Te/mDxo1LKEkwcuTZv0KPPTh+jYxvxbNqjHgNgR0APIL9ad9i1f
	 yr+emowLzPFag==
Date: Mon, 23 Feb 2026 15:22:14 -0800
Subject: [PATCH 07/12] fuse: enable iomap cache management
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188736177.3937557.4177707665253184525.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78099-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 29E9A17F412
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Provide a means for the fuse server to upload iomappings to the kernel
and invalidate them.  This is how we enable iomap caching for better
performance.  This is also required for correct synchronization between
pagecache writes and writeback.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap.h      |    7 +
 include/uapi/linux/fuse.h |   29 +++++
 fs/fuse/dev.c             |   46 ++++++++
 fs/fuse/fuse_iomap.c      |  264 ++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 343 insertions(+), 3 deletions(-)


diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index efc8adbc4f31dc..b13d305ee0508b 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -78,6 +78,11 @@ int fuse_iomap_dev_inval(struct fuse_conn *fc,
 
 int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
 int fuse_dev_ioctl_iomap_set_nofs(struct file *file, uint32_t __user *argp);
+
+int fuse_iomap_upsert_mappings(struct fuse_conn *fc,
+		      const struct fuse_iomap_upsert_mappings_out *outarg);
+int fuse_iomap_inval_mappings(struct fuse_conn *fc,
+		     const struct fuse_iomap_inval_mappings_out *outarg);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -107,6 +112,8 @@ int fuse_dev_ioctl_iomap_set_nofs(struct file *file, uint32_t __user *argp);
 # define fuse_iomap_dev_inval(...)		(-ENOSYS)
 # define fuse_iomap_fadvise			NULL
 # define fuse_dev_ioctl_iomap_set_nofs(...)	(-EOPNOTSUPP)
+# define fuse_iomap_upsert_mappings(...)	(-ENOSYS)
+# define fuse_iomap_inval_mappings(...)		(-ENOSYS)
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index a273838bc20f2f..8c5e67731b21b8 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -251,6 +251,8 @@
  *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
  *  - add FUSE_ATTR_{SYNC,IMMUTABLE,APPEND} for VFS enforcement of file
  *    attributes
+ *  - add FUSE_NOTIFY_IOMAP_{UPSERT,INVAL}_MAPPINGS so fuse servers can cache
+ *    file range mappings in the kernel for iomap
  */
 
 #ifndef _LINUX_FUSE_H
@@ -731,6 +733,8 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_INC_EPOCH = 8,
 	FUSE_NOTIFY_PRUNE = 9,
 	FUSE_NOTIFY_IOMAP_DEV_INVAL = 99,
+	FUSE_NOTIFY_IOMAP_UPSERT_MAPPINGS = 100,
+	FUSE_NOTIFY_IOMAP_INVAL_MAPPINGS = 101,
 	FUSE_NOTIFY_CODE_MAX,
 };
 
@@ -1396,6 +1400,8 @@ struct fuse_uring_cmd_req {
 #define FUSE_IOMAP_TYPE_PURE_OVERWRITE	(255)
 /* fuse-specific mapping type saying the server has populated the cache */
 #define FUSE_IOMAP_TYPE_RETRY_CACHE	(254)
+/* do not upsert this mapping */
+#define FUSE_IOMAP_TYPE_NOCACHE		(253)
 
 #define FUSE_IOMAP_DEV_NULL		(0U)	/* null device cookie */
 
@@ -1556,4 +1562,27 @@ struct fuse_iomap_dev_inval_out {
 /* invalidate all cached iomap mappings up to EOF */
 #define FUSE_IOMAP_INVAL_TO_EOF		(~0ULL)
 
+struct fuse_iomap_inval_mappings_out {
+	uint64_t nodeid;	/* Inode ID */
+	uint64_t attr_ino;	/* matches fuse_attr:ino */
+
+	/*
+	 * Range of read and mappings to invalidate.  Zero length means ignore
+	 * the range; and FUSE_IOMAP_INVAL_TO_EOF can be used for length.
+	 */
+	struct fuse_range read;
+	struct fuse_range write;
+};
+
+struct fuse_iomap_upsert_mappings_out {
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
index 896706c911cf24..b2433dec8cc5e5 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1873,6 +1873,48 @@ static int fuse_notify_iomap_dev_inval(struct fuse_conn *fc, unsigned int size,
 	return err;
 }
 
+static int fuse_notify_iomap_upsert_mappings(struct fuse_conn *fc,
+					     unsigned int size,
+					     struct fuse_copy_state *cs)
+{
+	struct fuse_iomap_upsert_mappings_out outarg;
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
+	return fuse_iomap_upsert_mappings(fc, &outarg);
+err:
+	fuse_copy_finish(cs);
+	return err;
+}
+
+static int fuse_notify_iomap_inval_mappings(struct fuse_conn *fc,
+					    unsigned int size,
+					    struct fuse_copy_state *cs)
+{
+	struct fuse_iomap_inval_mappings_out outarg;
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
+	return fuse_iomap_inval_mappings(fc, &outarg);
+err:
+	fuse_copy_finish(cs);
+	return err;
+}
+
 struct fuse_retrieve_args {
 	struct fuse_args_pages ap;
 	struct fuse_notify_retrieve_in inarg;
@@ -2159,6 +2201,10 @@ static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 
 	case FUSE_NOTIFY_IOMAP_DEV_INVAL:
 		return fuse_notify_iomap_dev_inval(fc, size, cs);
+	case FUSE_NOTIFY_IOMAP_UPSERT_MAPPINGS:
+		return fuse_notify_iomap_upsert_mappings(fc, size, cs);
+	case FUSE_NOTIFY_IOMAP_INVAL_MAPPINGS:
+		return fuse_notify_iomap_inval_mappings(fc, size, cs);
 
 	default:
 		return -EINVAL;
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 4bc2322a4ba796..478c11b90ad4aa 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -132,6 +132,7 @@ static inline bool fuse_iomap_check_type(uint16_t fuse_type)
 	case FUSE_IOMAP_TYPE_INLINE:
 	case FUSE_IOMAP_TYPE_PURE_OVERWRITE:
 	case FUSE_IOMAP_TYPE_RETRY_CACHE:
+	case FUSE_IOMAP_TYPE_NOCACHE:
 		return true;
 	}
 
@@ -241,8 +242,8 @@ static inline bool fuse_iomap_check_mapping(const struct inode *inode,
 	uint64_t end;
 
 	/*
-	 * Type and flags must be known.  Mapping type "retry cache" doesn't
-	 * use any of the other fields.
+	 * Type and flags must be known.  Mapping types "retry cache" and "do
+	 * not insert in cache" don't use any of the other fields.
 	 */
 	if (BAD_DATA(!fuse_iomap_check_type(map->type)))
 		return false;
@@ -255,6 +256,8 @@ static inline bool fuse_iomap_check_mapping(const struct inode *inode,
 			return false;
 		return true;
 	}
+	if (map->type == FUSE_IOMAP_TYPE_NOCACHE)
+		return true;
 	if (BAD_DATA(!fuse_iomap_check_flags(map->flags)))
 		return false;
 
@@ -299,6 +302,7 @@ static inline bool fuse_iomap_check_mapping(const struct inode *inode,
 		if (BAD_DATA(iodir != WRITE_MAPPING))
 			return false;
 		break;
+	case FUSE_IOMAP_TYPE_NOCACHE:
 	case FUSE_IOMAP_TYPE_RETRY_CACHE:
 	default:
 		/* should have been caught already */
@@ -373,6 +377,15 @@ fuse_iomap_begin_validate(const struct inode *inode,
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
@@ -602,9 +615,11 @@ fuse_iomap_cached_validate(const struct inode *inode,
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
@@ -2628,3 +2643,246 @@ void fuse_iomap_copied_file_range(struct inode *inode, loff_t offset,
 
 	fuse_iomap_cache_invalidate_range(inode, offset, written);
 }
+
+static inline int
+fuse_iomap_upsert_validate_dev(
+	const struct fuse_backing	*fb,
+	const struct fuse_iomap_io	*map)
+{
+	uint64_t			map_end;
+	sector_t			device_bytes;
+
+	if (!fb) {
+		if (BAD_DATA(map->addr != FUSE_IOMAP_NULL_ADDR))
+			return -EFSCORRUPTED;
+
+		return 0;
+	}
+
+	if (BAD_DATA(map->addr == FUSE_IOMAP_NULL_ADDR))
+		return -EFSCORRUPTED;
+
+	if (BAD_DATA(check_add_overflow(map->addr, map->length, &map_end)))
+		return -EFSCORRUPTED;
+
+	/*
+	 * bdev_nr_sectors() == 0 usually means the device has gone away from
+	 * underneath us.  We won't cache this mapping, but we'll return
+	 * -EINVAL to signal a softer error to the fuse server than "your fs
+	 * metadata are corrupt".  If the fuse server persists anyway, then
+	 * the worst that happens is that the IO will fail.
+	 */
+	device_bytes = bdev_nr_sectors(fb->bdev) << SECTOR_SHIFT;
+	if (!device_bytes)
+		return -EINVAL;
+
+	if (BAD_DATA(map_end > device_bytes))
+		return -EFSCORRUPTED;
+
+	return 0;
+}
+
+/* Validate one of the incoming upsert mappings */
+static inline int
+fuse_iomap_upsert_validate_mapping(struct inode *inode,
+				   enum fuse_iomap_iodir iodir,
+				   const struct fuse_iomap_io *map)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_backing *fb;
+	int ret;
+
+	if (!fuse_iomap_check_mapping(inode, map, iodir))
+		return -EFSCORRUPTED;
+
+	/*
+	 * A "retry cache" instruction makes no sense when we're adding to
+	 * the mapping cache.
+	 */
+	if (BAD_DATA(map->type == FUSE_IOMAP_TYPE_RETRY_CACHE))
+		return -EFSCORRUPTED;
+
+	/* nocache is allowed, because we ignore it later */
+	if (map->type == FUSE_IOMAP_TYPE_NOCACHE)
+		return 0;
+
+	/* Make sure we can find the device */
+	fb = fuse_iomap_find_dev(fc, map);
+	if (BAD_DATA(IS_ERR(fb)))
+		return -EFSCORRUPTED;
+
+	ret = fuse_iomap_upsert_validate_dev(fb, map);
+	fuse_backing_put(fb);
+	return ret;
+}
+
+/* Check the incoming upsert mappings to make sure they're not nonsense */
+static inline int
+fuse_iomap_upsert_validate_mappings(struct inode *inode,
+		const struct fuse_iomap_upsert_mappings_out *outarg)
+{
+	int ret = fuse_iomap_upsert_validate_mapping(inode, READ_MAPPING,
+						     &outarg->read);
+	if (ret)
+		return ret;
+
+	return fuse_iomap_upsert_validate_mapping(inode, WRITE_MAPPING,
+						  &outarg->write);
+}
+
+static int fuse_iomap_upsert_inode(struct inode *inode,
+		const struct fuse_iomap_upsert_mappings_out *outarg)
+{
+	int ret = fuse_iomap_upsert_validate_mappings(inode, outarg);
+	if (ret)
+		return ret;
+
+	if (!fuse_inode_caches_iomaps(inode)) {
+		ret = fuse_iomap_cache_alloc(inode);
+		if (ret)
+			return ret;
+	}
+
+	fuse_iomap_cache_lock(inode);
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
+	return ret;
+}
+
+int fuse_iomap_upsert_mappings(struct fuse_conn *fc,
+		const struct fuse_iomap_upsert_mappings_out *outarg)
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
+	ret = fuse_iomap_upsert_inode(inode, outarg);
+out_inode:
+	iput(inode);
+out_sb:
+	up_read(&fc->killsb);
+	return ret;
+}
+
+static inline bool
+fuse_iomap_inval_validate_range(const struct inode *inode,
+				const struct fuse_range *range)
+{
+	const unsigned int blocksize = i_blocksize(inode);
+
+	if (range->length == 0)
+		return true;
+
+	/* Range can't start beyond maxbytes */
+	if (BAD_DATA(range->offset >= inode->i_sb->s_maxbytes))
+		return false;
+
+	/* File range must be aligned to blocksize */
+	if (BAD_DATA(!IS_ALIGNED(range->offset, blocksize)))
+		return false;
+	if (range->length != FUSE_IOMAP_INVAL_TO_EOF &&
+	    BAD_DATA(!IS_ALIGNED(range->length, blocksize)))
+		return false;
+
+	return true;
+}
+
+static int fuse_iomap_inval_inode(struct inode *inode,
+		const struct fuse_iomap_inval_mappings_out *outarg)
+{
+	int ret = 0, ret2 = 0;
+
+	if (!fuse_iomap_inval_validate_range(inode, &outarg->write))
+		return -EFSCORRUPTED;
+
+	if (!fuse_iomap_inval_validate_range(inode, &outarg->read))
+		return -EFSCORRUPTED;
+
+	if (!fuse_inode_caches_iomaps(inode))
+		return 0;
+
+	fuse_iomap_cache_lock(inode);
+	if (outarg->read.length)
+		ret2 = fuse_iomap_cache_remove(inode, READ_MAPPING,
+					       outarg->read.offset,
+					       outarg->read.length);
+	if (outarg->write.length)
+		ret = fuse_iomap_cache_remove(inode, WRITE_MAPPING,
+					      outarg->write.offset,
+					      outarg->write.length);
+	fuse_iomap_cache_unlock(inode);
+
+	return ret ? ret : ret2;
+}
+
+int fuse_iomap_inval_mappings(struct fuse_conn *fc,
+		const struct fuse_iomap_inval_mappings_out *outarg)
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
+	ret = fuse_iomap_inval_inode(inode, outarg);
+out_inode:
+	iput(inode);
+out_sb:
+	up_read(&fc->killsb);
+	return ret;
+}


