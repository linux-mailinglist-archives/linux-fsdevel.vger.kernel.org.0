Return-Path: <linux-fsdevel+bounces-61559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F2AB589E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07DB716A2D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA741B394F;
	Tue, 16 Sep 2025 00:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOd4hPFK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAC2D528;
	Tue, 16 Sep 2025 00:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983292; cv=none; b=Q+5xImJsu64A73OhIphorPcgV7aJZsidJtBE4RsuQe3+hT8uyR/gjrr5OJgKwGthlZQ/Cy2gK7+yWjnQanrdkBLwSvRJjmNjBoTUYkdFicWZyS6dxS56E6abKFsonLLlgR3zSU34c0z5EiECIoEZ9ZrDyCDTeARDP7I4Ju3+b+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983292; c=relaxed/simple;
	bh=beyfQa9zBFHSfgHdtfPszXYen9pUopqvTwRuR6dahvg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMemgGwifH0Zek6EE8j9toThu/I8vNBDGgjf7XKW3XofPHszCEwfINEg6cxX2lrP1eX66Cuc+kGYQFe3hCug0sPaJq4w9B7YnEE4KffuWbee6eGeWCNkn+/OfWIeCfBJo1MrT51v6yvZakNE1/ol9hQrr2AJNRzGVFlMI5MsXPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOd4hPFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48242C4CEF5;
	Tue, 16 Sep 2025 00:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983292;
	bh=beyfQa9zBFHSfgHdtfPszXYen9pUopqvTwRuR6dahvg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=OOd4hPFK4V5j7AYSFE56zROPT5+0/uTX/cOBnEGXTKMNk4ksWXmKfAJe9e1xdFoo5
	 lPvwstduGQGMJXIrLNZop89NSJPeoCzw2dMkuiC59uMrOyQZZNWhWh9OnE3+RceCOQ
	 8hOGAg1/g09Wr5GApb6tlNIYVBj95qR4hrGRykilkd2YCyqT9JYJhMVwBRzqNueH++
	 JSx51N6BAv7ONHDsCcBOYp0pJ06SKrqSpRcPQONaoVN/TIehsQIk0er7MkkV6BoCAa
	 Hl67tmmtFWqcKV30Hqy4d2XD4xWm2AiBkloKUNKJ/ShthTnsj/MMcgS/Lgr2lqcjxt
	 Z4JJx1nSC3DOg==
Date: Mon, 15 Sep 2025 17:41:31 -0700
Subject: [PATCH 2/2] fuse: set iomap backing device block size
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798153407.384981.8321400280930442750.stgit@frogsfrogsfrogs>
In-Reply-To: <175798153353.384981.9881071302133055510.stgit@frogsfrogsfrogs>
References: <175798153353.384981.9881071302133055510.stgit@frogsfrogsfrogs>
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
index 1a965d3dee6479..faef0efe6a9506 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1853,6 +1853,8 @@ void fuse_iomap_copied_file_range(struct inode *inode, loff_t offset,
 int fuse_dev_ioctl_add_iomap(struct file *file);
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
+int fuse_dev_ioctl_iomap_set_blocksize(struct file *file,
+				struct fuse_iomap_backing_info __user *argp);
 int fuse_iomap_dev_inval(struct fuse_conn *fc,
 			 const struct fuse_iomap_dev_inval_out *arg);
 
@@ -1902,6 +1904,7 @@ int fuse_iomap_inval(struct fuse_conn *fc,
 # define fuse_iomap_copied_file_range(...)	((void)0)
 # define fuse_dev_ioctl_add_iomap(...)		(-EOPNOTSUPP)
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
+# define fuse_dev_ioctl_iomap_set_blocksize(...) (-EOPNOTSUPP)
 # define fuse_iomap_dev_inval(...)		(-ENOSYS)
 # define fuse_iomap_fadvise			NULL
 # define fuse_inode_caches_iomaps(...)		(false)
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index b59ce131513efd..d360c39be43104 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1180,6 +1180,11 @@ struct fuse_iomap_support {
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
@@ -1190,6 +1195,8 @@ struct fuse_iomap_support {
 #define FUSE_DEV_IOC_ADD_IOMAP		_IO(FUSE_DEV_IOC_MAGIC, 99)
 #define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 99, \
 					     struct fuse_iomap_support)
+#define FUSE_DEV_IOC_IOMAP_SET_BLOCKSIZE _IOW(FUSE_DEV_IOC_MAGIC, 99, \
+					      struct fuse_iomap_backing_info)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 7a24fbcdb2f919..5003a862daf37a 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2782,6 +2782,8 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 		return fuse_dev_ioctl_iomap_support(file, argp);
 	case FUSE_DEV_IOC_ADD_IOMAP:
 		return fuse_dev_ioctl_add_iomap(file);
+	case FUSE_DEV_IOC_IOMAP_SET_BLOCKSIZE:
+		return fuse_dev_ioctl_iomap_set_blocksize(file, argp);
 
 	default:
 		return -ENOTTY;
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 70b01638006a2e..a915cc9520b532 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -2721,3 +2721,27 @@ int fuse_iomap_inval(struct fuse_conn *fc,
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


