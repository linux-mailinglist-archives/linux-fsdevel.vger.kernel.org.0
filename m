Return-Path: <linux-fsdevel+bounces-58455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 596DFB2E9D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19153A08546
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D441E493C;
	Thu, 21 Aug 2025 00:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzFOYHmm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B241632DD
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737770; cv=none; b=a5+hzcJBygjSLjd0CfBmHIVEen8yNWspH9w+v3BFfhnvZLpxsVSsZOeQl+kur0K6T/HcQcao7WMUpsyWfUWy6oLuQIhLVrlLLf5Srfn6Kt/3ZRp37rnQqlnx/NvTGX8eJLZD/XAD7Ehf5JjAfm6PpSUsZibg7lEtZo9diO0JXG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737770; c=relaxed/simple;
	bh=+kMTzRzTOCb5sAxPTV5fvWojyDQ8sVEYLhPbmUgk89A=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=usbkQvisqDDAyoujLQUD3WdYfvCTyOZ/fLdV1gfIkWeEXMEyDae+8Um7rGCwAxCWcH3m8DugNRBd3sfXL3UGvTL62z14kfmFpNsMNyQ3O8MaSbLy7HF74QCXTSiDFZ/7MkIYKl5NJeuCcgPvG8j07I1LqbuqlZ9kMdxhrNH1CTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzFOYHmm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC19C4CEE7;
	Thu, 21 Aug 2025 00:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737769;
	bh=+kMTzRzTOCb5sAxPTV5fvWojyDQ8sVEYLhPbmUgk89A=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bzFOYHmmdDLY64QFTgXSpJNqUUuAch3NE4wByh7/MKDFkFc/nHuN/WQd0ymLx56E1
	 ZakehHAceXXxjGvOzIePJBjjK/y8xDwZO/8ZJSAi2dMCYAAA++5ZXF4xQTQY7t9TU8
	 Y+MIBl4DFnk1fcDc/qErg+5U1NcGSWOLUBWxBCkp3UBz9+qzZWHgR1s/his5ndNsav
	 4Y5aihctt5S7kJs3FfjUiUFbT/psaWd9K5azJBtZSds/dgo7PJ1wkAWOVheHb1EgPB
	 92gElPbqYT7aY3uuE41Bka5/rcronkvcXLeICSkumSy9miNcbNLJ/8C4ExCEZ1ZsH/
	 rsNlX0H/aLE/w==
Date: Wed, 20 Aug 2025 17:56:09 -0700
Subject: [PATCH 14/23] fuse: advertise support for iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573709416.17510.12171755484928849715.stgit@frogsfrogsfrogs>
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

Advertise our new IO paths programmatically by creating an ioctl that
can return the capabilities of the kernel.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |    4 ++++
 include/uapi/linux/fuse.h |    9 +++++++++
 fs/fuse/dev.c             |    3 +++
 fs/fuse/file_iomap.c      |   13 +++++++++++++
 4 files changed, 29 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 74fb5971f8fec7..5380a220741014 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1721,6 +1721,9 @@ int fuse_iomap_fallocate(struct file *file, int mode, loff_t offset,
 			 loff_t length, loff_t new_size);
 int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 				 loff_t endpos);
+
+int fuse_dev_ioctl_iomap_support(struct file *file,
+				 struct fuse_iomap_support __user *argp);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -1746,6 +1749,7 @@ int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 # define fuse_iomap_set_i_blkbits(...)		((void)0)
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
+# define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 12d15c186256f3..d0f71136837068 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1134,12 +1134,21 @@ struct fuse_backing_map {
 	uint64_t	padding;
 };
 
+/* basic file I/O functionality through iomap */
+#define FUSE_IOMAP_SUPPORT_FILEIO	(1ULL << 0)
+struct fuse_iomap_support {
+	uint64_t	flags;
+	uint64_t	padding;
+};
+
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
 #define FUSE_DEV_IOC_BACKING_OPEN	_IOW(FUSE_DEV_IOC_MAGIC, 1, \
 					     struct fuse_backing_map)
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
+#define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 3, \
+					     struct fuse_iomap_support)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 31d9f006836ac1..d239946a46c463 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2664,6 +2664,9 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 	case FUSE_DEV_IOC_BACKING_CLOSE:
 		return fuse_dev_ioctl_backing_close(file, argp);
 
+	case FUSE_DEV_IOC_IOMAP_SUPPORT:
+		return fuse_dev_ioctl_iomap_support(file, argp);
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 701df0d34067ee..5a2910919ba209 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -1756,3 +1756,16 @@ fuse_iomap_fallocate(
 	file_update_time(file);
 	return 0;
 }
+
+int fuse_dev_ioctl_iomap_support(struct file *file,
+				 struct fuse_iomap_support __user *argp)
+{
+	struct fuse_iomap_support ios = { };
+
+	if (fuse_iomap_enabled())
+		ios.flags = FUSE_IOMAP_SUPPORT_FILEIO;
+
+	if (copy_to_user(argp, &ios, sizeof(ios)))
+		return -EFAULT;
+	return 0;
+}


