Return-Path: <linux-fsdevel+bounces-66057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCE8C17B3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058F0423BFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8E42D7DDA;
	Wed, 29 Oct 2025 00:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duRLQfrs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3122E24BD1A;
	Wed, 29 Oct 2025 00:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699559; cv=none; b=qac2c6eUQuqXPJtAUdRflunMELfWLrIksSTIrK9TRKYOJNfRM7G+ZvrDSeZFcfQyHX0OOBS68pZc+3dajQHn2CCSuPx+N8fCrrbzj5RSZSbOKo1Wir1LcFlYayCQCGE4286CM/ZDJjCrp8LzX5+Xl6cHBUdXCgvDDKhX/F02BZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699559; c=relaxed/simple;
	bh=x0Du9cCRuizxcvunmkb0jTfV0VuEzav/3FuKhdeurQo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+sJtUcsJGoqwMxgX58n/I4AmQgHuao2qSDiUhzK+MKbbztmT+l1Mf8V64dx9E0/TDNmZtN/UGYIigY1tNotffABIIaZIfZ+tQiH4gX+dfRgW2invvVAmP7/CSvzn0SQ0VoEWAmehWP9v4bmdlKIVppZ/2m49EQBBogu0JcbFS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duRLQfrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D4CC4CEE7;
	Wed, 29 Oct 2025 00:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699559;
	bh=x0Du9cCRuizxcvunmkb0jTfV0VuEzav/3FuKhdeurQo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=duRLQfrsqcaYwWD7tQ31LTxv3Zy4PFED3iaDSvh2qJjx1xOP1yimmIjuY68FxoyoS
	 2EMBKK2jtakPxn+DDGic2Z84JDE4aJXPRqEqkouVZGAX0zKdPeZI6NFw2zMTWm8uuU
	 fSOkKJFUzQeF92WDplx40EVNULvUDRee8IGllkoAHFXwHRaCmGBNHGmOhXEbX0cDxC
	 nsvg7vPz24oqjdeqUKGNdKZAmYpoWuU5x+Jadyr3dZ4PMd1/MKi2YNwuzOwg3QgaIF
	 uL/y0Uh0yqCqjGaJhL8JboIoQ3aWPTm8OrKJka8+SmoPawBOoHEPeNdFekqpJkO5lm
	 pTOXHi/lAvX9g==
Date: Tue, 28 Oct 2025 17:59:18 -0700
Subject: [PATCH 2/2] fuse: set iomap backing device block size
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169812555.1427080.18405773837900501876.stgit@frogsfrogsfrogs>
In-Reply-To: <176169812502.1427080.11949246505492038165.stgit@frogsfrogsfrogs>
References: <176169812502.1427080.11949246505492038165.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add a new ioctl so that an unprivileged fuse server can set the block
size of a bdev that's opened for iomap usage.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |    3 +++
 include/uapi/linux/fuse.h |    7 +++++++
 fs/fuse/dev.c             |    2 ++
 fs/fuse/file_iomap.c      |   24 ++++++++++++++++++++++++
 4 files changed, 36 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f45e59d16d0ebc..4b8c54cced7e07 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1857,6 +1857,8 @@ void fuse_iomap_copied_file_range(struct inode *inode, loff_t offset,
 int fuse_dev_ioctl_add_iomap(struct file *file);
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
+int fuse_dev_ioctl_iomap_set_blocksize(struct file *file,
+				struct fuse_iomap_backing_info __user *argp);
 int fuse_iomap_dev_inval(struct fuse_conn *fc,
 			 const struct fuse_iomap_dev_inval_out *arg);
 
@@ -1908,6 +1910,7 @@ int fuse_iomap_inval(struct fuse_conn *fc,
 # define fuse_iomap_copied_file_range(...)	((void)0)
 # define fuse_dev_ioctl_add_iomap(...)		(-EOPNOTSUPP)
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
+# define fuse_dev_ioctl_iomap_set_blocksize(...) (-EOPNOTSUPP)
 # define fuse_iomap_dev_inval(...)		(-ENOSYS)
 # define fuse_iomap_fadvise			NULL
 # define fuse_inode_caches_iomaps(...)		(false)
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index daf72e46120c24..38e44909370e12 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1197,6 +1197,11 @@ struct fuse_iomap_support {
 	uint64_t	padding;
 };
 
+struct fuse_iomap_backing_info {
+	uint32_t	backing_id;
+	uint32_t	blocksize;
+};
+
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
@@ -1207,6 +1212,8 @@ struct fuse_iomap_support {
 #define FUSE_DEV_IOC_ADD_IOMAP		_IO(FUSE_DEV_IOC_MAGIC, 99)
 #define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 99, \
 					     struct fuse_iomap_support)
+#define FUSE_DEV_IOC_IOMAP_SET_BLOCKSIZE _IOW(FUSE_DEV_IOC_MAGIC, 99, \
+					      struct fuse_iomap_backing_info)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 4dfad6c33fac8f..a457d31d8e252c 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2791,6 +2791,8 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 		return fuse_dev_ioctl_iomap_support(file, argp);
 	case FUSE_DEV_IOC_ADD_IOMAP:
 		return fuse_dev_ioctl_add_iomap(file);
+	case FUSE_DEV_IOC_IOMAP_SET_BLOCKSIZE:
+		return fuse_dev_ioctl_iomap_set_blocksize(file, argp);
 
 	default:
 		return -ENOTTY;
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 08e7e4f924a65a..3e6bdb53b1bfc9 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -2800,3 +2800,27 @@ int fuse_iomap_inval(struct fuse_conn *fc,
 	up_read(&fc->killsb);
 	return ret ? ret : ret2;
 }
+
+int fuse_dev_ioctl_iomap_set_blocksize(struct file *file,
+				struct fuse_iomap_backing_info __user *argp)
+{
+	struct fuse_iomap_backing_info fbi;
+	struct fuse_dev *fud = fuse_get_dev(file);
+	struct fuse_backing *fb;
+	int ret;
+
+	if (IS_ERR(fud))
+		return PTR_ERR(fud);
+
+	if (copy_from_user(&fbi, argp, sizeof(fbi)))
+		return -EFAULT;
+
+	fb = fuse_backing_lookup(fud->fc, &fuse_iomap_backing_ops,
+				 fbi.backing_id);
+	if (!fb)
+		return -ENOENT;
+
+	ret = set_blocksize(fb->file, fbi.blocksize);
+	fuse_backing_put(fb);
+	return ret;
+}


