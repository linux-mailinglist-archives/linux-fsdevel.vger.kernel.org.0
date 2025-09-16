Return-Path: <linux-fsdevel+bounces-61529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8006AB5899E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0A13B4CBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006731C3BE0;
	Tue, 16 Sep 2025 00:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kt8V0z68"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC012032D;
	Tue, 16 Sep 2025 00:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982823; cv=none; b=h97NFcr7HqZqyo4mqqeB+bESbxWfaCKlAjxV2pYSmWkLmTetvd8gDXTqZAUmU3Ee6EgI4FhMoL20WM3X30ZPC61v0DpFfTFQWSZOTPsm/1L9JvF2N+WLDJKs732xHB0mvv6GnMa0oxZdMmTFF4Hx8c6EGFY8/r24SYD9BrPQ/mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982823; c=relaxed/simple;
	bh=YqTGX1ym7ZE3P8li3dNLWHNlLkHEteyRESL8gvh7z7o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9jZL5s6xhBjB06KnU/x61GcEEn3eIg3vejG3qFVOE0KA7mtfHGWRvdqwtPg03lWyBM1bRtaKhswqpgjbqeCyZKpm3TMUaO2i2yrhCnoHTvQKfQqKWM1k7jCKb/L3/SfsI6pyMAQea5OYUzpOadBmIIuqKHxw9CcfJFqOUXDF7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kt8V0z68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA07C4CEF1;
	Tue, 16 Sep 2025 00:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982822;
	bh=YqTGX1ym7ZE3P8li3dNLWHNlLkHEteyRESL8gvh7z7o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=kt8V0z68ukjNuPf6EBxUzrnd1mVj0QruODHckXW3vOZNuEs9ScdaCs6vq8THBVUAt
	 vqJw4DJhbhmw7jN7vaZaUqCdHvOAKet9A2Tjd/4iTQSRdEhmoQuM/pPNtWayJH6Tou
	 /oiEuyh7ChR+Xew0USTNIrH1hAx9Sur3WiFkAAkDZjBFt1W/Cg9FuHBf/9OLfvqq9j
	 mH5SAWR1oaKJLer9WfTbVg84sPjclIMdM3Z8FS2BOp+9u4XNjER8lmrN9FzoYeM4w7
	 6pRG2VtBjQ4d/AVx0NYX4XrDtoKl1yoHuqRnGXYXoFxWr3o4UH1pwPjbE3/Gye5jpI
	 MVmERzeCnosjw==
Date: Mon, 15 Sep 2025 17:33:42 -0700
Subject: [PATCH 22/28] fuse: invalidate ranges of block devices being used for
 iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798151738.382724.10299504413530460370.stgit@frogsfrogsfrogs>
In-Reply-To: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_i.h          |    3 +++
 include/uapi/linux/fuse.h |   10 ++++++++++
 fs/fuse/dev.c             |   27 +++++++++++++++++++++++++++
 fs/fuse/file_iomap.c      |   40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index d59c19f61d5337..4aa7199dd0cd9f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1789,6 +1789,8 @@ int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
+int fuse_iomap_dev_inval(struct fuse_conn *fc,
+			 const struct fuse_iomap_dev_inval_out *arg);
 
 int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
 #else
@@ -1815,6 +1817,7 @@ int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
+# define fuse_iomap_dev_inval(...)		(-ENOSYS)
 # define fuse_iomap_fadvise			NULL
 #endif
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 19c1ac5006faa9..b63fba0a2c52c9 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -240,6 +240,7 @@
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
+ *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
  */
 
 #ifndef _LINUX_FUSE_H
@@ -689,6 +690,7 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_DELETE = 6,
 	FUSE_NOTIFY_RESEND = 7,
 	FUSE_NOTIFY_INC_EPOCH = 8,
+	FUSE_NOTIFY_IOMAP_DEV_INVAL = 9,
 	FUSE_NOTIFY_CODE_MAX,
 };
 
@@ -1464,4 +1466,12 @@ struct fuse_iomap_config_out {
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
index bb0ec19a368bea..adbe2a65e6fe87 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1868,6 +1868,30 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
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
@@ -2114,6 +2138,9 @@ static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 	case FUSE_NOTIFY_INC_EPOCH:
 		return fuse_notify_inc_epoch(fc);
 
+	case FUSE_NOTIFY_IOMAP_DEV_INVAL:
+		return fuse_notify_iomap_dev_inval(fc, size, cs);
+
 	default:
 		fuse_copy_finish(cs);
 		return -EINVAL;
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index a484cd235d9da2..9c798435e45633 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -1876,3 +1876,43 @@ int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice)
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
+	if (!fc->iomap || arg->dev == FUSE_IOMAP_DEV_NULL)
+		return -EINVAL;
+
+	down_read(&fc->killsb);
+	fb = fuse_backing_lookup(fc, &fuse_iomap_backing_ops, arg->dev);
+	if (!fb) {
+		ret = -ENODEV;
+		goto out_killsb;
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
+	fuse_backing_put(fb);
+out_killsb:
+	up_read(&fc->killsb);
+	return ret;
+}


