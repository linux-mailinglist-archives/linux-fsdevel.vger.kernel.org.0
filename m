Return-Path: <linux-fsdevel+bounces-58460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D15B2E9D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB1416D55F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FE91E5B64;
	Thu, 21 Aug 2025 00:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bG9xKpl3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8029C2FB
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737847; cv=none; b=NC+ZVIStM/AygEHCBjWA6asxqR3E2TTkbP6tCyXTZ8H1tc7JD/gz0v3CZHRZIC8vnXgCPKbuYq2ntcj8P3BwMe+ZJdIs27hi2jbGUHMOZ/IpQav3xL4QdlFIszunPJ0pK0ahAdIsQ+xbR+c84LRA4IR3ZzhFwPiyVHGpt965A14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737847; c=relaxed/simple;
	bh=bh/59EBDGlAWv4y67EwlobtDdb7ET0itpWHvUkGSihM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGulxtX1nVvSJp6pW4bhVXts7vbkdzZ3xumX2MF+AIAzIxAluH/nBW5q/LKjX1XphQS84Tv2SGO5Y+ylIsED3occICf4gWIBmY34TLHfZOSVEcEKYtQp/PgYT/m+zFgH5a7YNlWxJH6ErWxsZVDA2YSSluExQZH/kX9RLXqFqrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bG9xKpl3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD90C4CEE7;
	Thu, 21 Aug 2025 00:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737847;
	bh=bh/59EBDGlAWv4y67EwlobtDdb7ET0itpWHvUkGSihM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bG9xKpl3Jo595OceXFQLoIIY5+aXsaLS8Ipzsiu+AXIWc4HAOgDHMI+7FhvYoB8Li
	 coRonYU7Rf/e9cGXfqjmISRDy9qwNKllZ5ZkHo7aQ7vGT1cEpJwKgORAe+cwg87bVH
	 7ky3NT0fCmggTQueDA7FAJi+hFGemFrqi11x07ir0kjobBhk6FF83miLDosb9KKnNr
	 ByYrD43SEcteTlu8xu3tra+tCK09VYqSJJkZacH35+D5KWDjyW4SwpGK3YPziVlll/
	 42Vzmgzbcj16wlrVcGWy7J3ooR1YfICbGU8/bceeVhB3g9htxDt2ONllKox7/ojgLe
	 GhWUxGWHaRSjA==
Date: Wed, 20 Aug 2025 17:57:27 -0700
Subject: [PATCH 19/23] fuse: invalidate ranges of block devices being used for
 iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573709524.17510.15983816227636112639.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
References: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Make it easier to invalidate the page cache for a block device that is
being used in conjunction with iomap.  This allows a fuse server to kill
all cached data for a block that is being freed, so that block reuse
doesn't result in file corruption.  Right now, the only way to do this
is with fadvise, which ignores and doesn't wait for pages undergoing
writeback.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |    4 ++++
 fs/fuse/fuse_trace.h      |   26 +++++++++++++++++++++++++
 include/uapi/linux/fuse.h |   10 ++++++++++
 fs/fuse/dev.c             |   27 ++++++++++++++++++++++++++
 fs/fuse/file_iomap.c      |   47 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 114 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index a81138da1e55f6..362fa87241ac70 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1690,6 +1690,9 @@ int fuse_iomap_backing_close(struct fuse_conn *fc, struct fuse_backing *fb);
 void fuse_iomap_mount(struct fuse_mount *fm);
 void fuse_iomap_unmount(struct fuse_mount *fm);
 
+int fuse_iomap_dev_inval(struct fuse_conn *fc,
+			 const struct fuse_iomap_dev_inval_out *arg);
+
 int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		      u64 start, u64 length);
 loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence);
@@ -1742,6 +1745,7 @@ int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
 # define fuse_iomap_backing_close(...)		(-EOPNOTSUPP)
 # define fuse_iomap_mount(...)			((void)0)
 # define fuse_iomap_unmount(...)		((void)0)
+# define fuse_iomap_dev_inval(...)		(-ENOSYS)
 # define fuse_iomap_fiemap			NULL
 # define fuse_iomap_lseek(...)			(-ENOSYS)
 # define fuse_iomap_bmap(...)			(-ENOSYS)
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 1f2ff30bececd4..2f4c78ba498177 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -1045,6 +1045,32 @@ TRACE_EVENT(fuse_iomap_config,
 		  __entry->time_min, __entry->time_max, __entry->maxbytes,
 		  __entry->uuid_len)
 );
+
+TRACE_EVENT(fuse_iomap_dev_inval,
+	TP_PROTO(const struct fuse_conn *fc,
+		 const struct fuse_iomap_dev_inval_out *arg),
+	TP_ARGS(fc, arg),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+		__field(int,			dev)
+		__field(unsigned long long,	offset)
+		__field(unsigned long long,	length)
+	),
+
+	TP_fast_assign(
+		__entry->connection	=	fc->dev;
+		__entry->dev		=	arg->dev;
+		__entry->offset		=	arg->offset;
+		__entry->length		=	arg->length;
+	),
+
+	TP_printk("connection %u dev %d offset 0x%llx length 0x%llx",
+		  __entry->connection,
+		  __entry->dev,
+		  __entry->offset,
+		  __entry->length)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 1a677e807c2846..1f8e3ba60e7ec5 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -241,6 +241,7 @@
  *    SEEK_{DATA,HOLE}, buffered I/O, and direct I/O
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
+ *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
  */
 
 #ifndef _LINUX_FUSE_H
@@ -691,6 +692,7 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_DELETE = 6,
 	FUSE_NOTIFY_RESEND = 7,
 	FUSE_NOTIFY_INC_EPOCH = 8,
+	FUSE_NOTIFY_IOMAP_DEV_INVAL = 9,
 	FUSE_NOTIFY_CODE_MAX,
 };
 
@@ -1453,4 +1455,12 @@ struct fuse_iomap_config_out {
 	int64_t s_maxbytes;	/* max file size */
 };
 
+struct fuse_iomap_dev_inval_out {
+	uint32_t dev;		/* device cookie */
+	uint32_t reserved;	/* zero */
+
+	uint64_t offset;	/* range to invalidate pagecache, bytes */
+	uint64_t length;
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index d239946a46c463..575cb6e15d84d5 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1833,6 +1833,30 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	return err;
 }
 
+static int fuse_notify_iomap_dev_inval(struct fuse_conn *fc, unsigned int size,
+				       struct fuse_copy_state *cs)
+{
+	struct fuse_iomap_dev_inval_out outarg;
+	int err = -EINVAL;
+
+	if (size != sizeof(outarg))
+		goto err;
+
+	err = fuse_copy_one(cs, &outarg, sizeof(outarg));
+	if (err)
+		goto err;
+	if (outarg.reserved) {
+		err = -EINVAL;
+		goto err;
+	}
+	fuse_copy_finish(cs);
+
+	return fuse_iomap_dev_inval(fc, &outarg);
+err:
+	fuse_copy_finish(cs);
+	return err;
+}
+
 struct fuse_retrieve_args {
 	struct fuse_args_pages ap;
 	struct fuse_notify_retrieve_in inarg;
@@ -2079,6 +2103,9 @@ static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 	case FUSE_NOTIFY_INC_EPOCH:
 		return fuse_notify_inc_epoch(fc);
 
+	case FUSE_NOTIFY_IOMAP_DEV_INVAL:
+		return fuse_notify_iomap_dev_inval(fc, size, cs);
+
 	default:
 		fuse_copy_finish(cs);
 		return -EINVAL;
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index c740fb1420bee0..1b389d7792e965 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -1909,3 +1909,50 @@ int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice)
 		inode_unlock_shared(inode);
 	return ret;
 }
+
+int fuse_iomap_dev_inval(struct fuse_conn *fc,
+			 const struct fuse_iomap_dev_inval_out *arg)
+{
+	struct fuse_backing *fb;
+	struct block_device *bdev;
+	loff_t end;
+	int ret = 0;
+
+	trace_fuse_iomap_dev_inval(fc, arg);
+
+	if (!fc->iomap || arg->dev == FUSE_IOMAP_DEV_NULL)
+		return -EINVAL;
+
+	down_read(&fc->killsb);
+	fb = fuse_backing_lookup(fc, arg->dev);
+	if (!fb) {
+		ret = -ENODEV;
+		goto out_killsb;
+	}
+	if (!fb->iomap) {
+		ret = -ENODEV;
+		goto out_fb;
+	}
+	bdev = fb->bdev;
+
+	inode_lock(bdev->bd_mapping->host);
+	filemap_invalidate_lock(bdev->bd_mapping);
+
+	if (check_add_overflow(arg->offset, arg->length, &end) ||
+	    arg->offset >= bdev_nr_bytes(bdev)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	end = min(end, bdev_nr_bytes(bdev));
+	truncate_inode_pages_range(bdev->bd_mapping, arg->offset, end - 1);
+
+out_unlock:
+	filemap_invalidate_unlock(bdev->bd_mapping);
+	inode_unlock(bdev->bd_mapping->host);
+out_fb:
+	fuse_backing_put(fb);
+out_killsb:
+	up_read(&fc->killsb);
+	return ret;
+}


