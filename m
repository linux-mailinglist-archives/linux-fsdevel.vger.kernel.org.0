Return-Path: <linux-fsdevel+bounces-66024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A19AC17A5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F383BEB65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32D32D6630;
	Wed, 29 Oct 2025 00:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzLdC6Yi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16967239E9E;
	Wed, 29 Oct 2025 00:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699042; cv=none; b=t3cS7Kig9SO39jAVTXL4iFO2T9uNd+9dcgZiAystr/D0Ab03ffWOd2lLLx09D5O2Ea6aAp3h5xSRQ8VWSnneGpBObUzojtcw1Kpvjim07R9epEvTniWxdtaoft/2R61gj447u6klTVmN339N/vLLLkpJhb+VGgbs9iz2onU/8Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699042; c=relaxed/simple;
	bh=PdjQhzQayUt+IkVn3yIrLWd8CbNKmGyL5Pfq/FOZz1I=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENW/4gJULROXD+C++ASNaXCg4CWop4HYJWuGHWkqurhLiOnro9ddCxxlC3pafGsWD4di4eLvostFz6YhOwH+mSMpmBPs4FlWapXZXaf/o8g8yVHO5l26EphUYKL3rsMRLnCEBL6MWVUhNo+iwzDcPIkor+7M0ozw/XOClkDmemI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzLdC6Yi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1759C4CEE7;
	Wed, 29 Oct 2025 00:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699041;
	bh=PdjQhzQayUt+IkVn3yIrLWd8CbNKmGyL5Pfq/FOZz1I=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qzLdC6YiPzlBbm8ZKPyfHxqLY98tPva/7cOfJrKxiM2Pi7fZ/ABW1I1uigDczTM+X
	 41UTH6ATnI2igY8Jm9lbciBXW7wsnZW6UsbGV+Tc99U3uzME4OEsyK4fULp6R3czfA
	 a8Kj+BCPiLwkyOGrcxeAk4OPf+gfj5GavyY5FQtoBwGu9cG8RlvIluBQqZNEordt15
	 vn9mCZSQSQkeXnaVVu81A67LXXJ+t77bFESe1Fgl2JrvbP088H8CEuZtR7to1au7s2
	 SURuUCkurn8CrZ1ftN5Z0bSlYNO65OmhllnBXYsahXYQ5Tei+S71jQ7zbqvskN5XN/
	 bYsfcUQPJ/LzA==
Date: Tue, 28 Oct 2025 17:50:41 -0700
Subject: [PATCH 22/31] fuse: invalidate ranges of block devices being used for
 iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169810830.1424854.6984651193778345181.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
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
 include/uapi/linux/fuse.h |   11 +++++++++++
 fs/fuse/dev.c             |   27 +++++++++++++++++++++++++++
 fs/fuse/file_iomap.c      |   40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 8e3e2e5591c760..e937add0ea7baf 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1792,6 +1792,8 @@ int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
+int fuse_iomap_dev_inval(struct fuse_conn *fc,
+			 const struct fuse_iomap_dev_inval_out *arg);
 
 int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
 #else
@@ -1819,6 +1821,7 @@ int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
+# define fuse_iomap_dev_inval(...)		(-ENOSYS)
 # define fuse_iomap_fadvise			NULL
 #endif
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 7588d55afd34da..976773bb6295ff 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -245,6 +245,7 @@
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
+ *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
  */
 
 #ifndef _LINUX_FUSE_H
@@ -696,6 +697,8 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_RESEND = 7,
 	FUSE_NOTIFY_INC_EPOCH = 8,
 	FUSE_NOTIFY_PRUNE = 9,
+	FUSE_NOTIFY_IOMAP_DEV_INVAL = 99,
+	FUSE_NOTIFY_CODE_MAX,
 };
 
 /* The read buffer is required to be at least 8k, but may be much larger */
@@ -1481,4 +1484,12 @@ struct fuse_iomap_config_out {
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
index 7aa7bf2f8348d2..62babbddcd9865 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1843,6 +1843,30 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
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
@@ -2123,6 +2147,9 @@ static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 	case FUSE_NOTIFY_PRUNE:
 		return fuse_notify_prune(fc, size, cs);
 
+	case FUSE_NOTIFY_IOMAP_DEV_INVAL:
+		return fuse_notify_iomap_dev_inval(fc, size, cs);
+
 	default:
 		return -EINVAL;
 	}
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 9fd2600f599d95..332f41eeaf0a87 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -1897,3 +1897,43 @@ int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice)
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


