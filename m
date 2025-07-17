Return-Path: <linux-fsdevel+bounces-55331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F10B1B0980A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956371899F9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480E22690C0;
	Thu, 17 Jul 2025 23:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goTXU94F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DB22451C8
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795046; cv=none; b=d/qstYM/KZLRj6zlB+sSXZvwIzy3y6TuSFzktHUX9kVP4CAu6uBCEQPGSrfNfLfrxe5Mwslxux7aoLuUbeTHDe0yQ4L+B9QXEH1NRDiKNMKx2ItAI/UR3/i2sRe+Nue8T4FdVz12307BpfW7ZKCD/e7Tyy0SljhBcUOTAno/ytY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795046; c=relaxed/simple;
	bh=yM9fTuAm8M47siXaZhhsWK7S+IMp7S75fiqcL5KZipM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WkzzQ9hDwwWu2KTGApH4eKXPlE426F458wMn3546gu7wvkfgrXfkkl/GjdLotmDjKHlkZ3an+/cmvzB/dMAA3nkLQqiJfEOwCe2MfiKsmDJKZEaz/zzPGnzOnc88urXUphIlG6dRWNAVCP3KuS92plnkffB7tqSRf+QZSeeSqDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goTXU94F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C54DC4CEE3;
	Thu, 17 Jul 2025 23:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795046;
	bh=yM9fTuAm8M47siXaZhhsWK7S+IMp7S75fiqcL5KZipM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=goTXU94Feksyr2cnykTDsxHZta9Rv0kBsMTOhxJR+7/mqrG+knUq6jxR6/xsYIec6
	 7xOx1D2p8ZPOjAr2/nJeSRxWISh156KrMCWIz4ePwM53jFbsePoNpHHL2ekCzD1bL8
	 Nx7rqP1AcphqJ4lVFKuMWNVTlXouEN1d8CstrKkGnqbGyBDqXfrv0gE15Uy2L09wfD
	 eVSj99Z5lmhMrp2JDhx/P8bhEEe26IWkRhUvn/Ld8fieVFTYzdGacwh+XWXRik4UZb
	 hSSfyoRJqeYQ6TKNIdgN20P1WnqjbHfOzIl3xAEXjrQh2eumYzi2KRtYyCd3g9YSM9
	 48MsgHxceBYvQ==
Date: Thu, 17 Jul 2025 16:30:45 -0700
Subject: [PATCH 10/13] fuse: advertise support for iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279450152.711291.11621934708652421911.stgit@frogsfrogsfrogs>
In-Reply-To: <175279449855.711291.17231562727952977187.stgit@frogsfrogsfrogs>
References: <175279449855.711291.17231562727952977187.stgit@frogsfrogsfrogs>
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
 include/uapi/linux/fuse.h |   13 +++++++++++++
 fs/fuse/dev.c             |    2 ++
 fs/fuse/file_iomap.c      |   15 +++++++++++++++
 4 files changed, 34 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f33b348d296d5e..136b9e5aabaf51 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1711,6 +1711,9 @@ int fuse_iomap_fallocate(struct file *file, int mode, loff_t offset,
 			 loff_t length, loff_t new_size);
 int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 				 loff_t endpos);
+
+int fuse_dev_ioctl_iomap_support(struct file *file,
+				 struct fuse_iomap_support __user *argp);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -1738,6 +1741,7 @@ int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 # define fuse_iomap_set_i_blkbits(...)		((void)0)
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
+# define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 71129db79a1dd0..cd484de60a7c09 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1142,6 +1142,17 @@ struct fuse_backing_map {
 	uint64_t	padding;
 };
 
+/* basic reporting functionality */
+#define FUSE_IOMAP_SUPPORT_BASICS	(1ULL << 0)
+/* fuse driver can do direct io */
+#define FUSE_IOMAP_SUPPORT_DIRECTIO	(1ULL << 1)
+/* fuse driver can do buffered io */
+#define FUSE_IOMAP_SUPPORT_FILEIO	(1ULL << 2)
+struct fuse_iomap_support {
+	uint64_t	flags;
+	uint64_t	padding;
+};
+
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
@@ -1150,6 +1161,8 @@ struct fuse_backing_map {
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
 #define FUSE_DEV_IOC_IOMAP_DEV_ADD	_IOW(FUSE_DEV_IOC_MAGIC, 3, \
 					     struct fuse_backing_map)
+#define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 4, \
+					     struct fuse_iomap_support)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 49ff2c6654e768..4ad90d212379ff 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2685,6 +2685,8 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 
 	case FUSE_DEV_IOC_IOMAP_DEV_ADD:
 		return fuse_dev_ioctl_iomap_dev_add(file, argp);
+	case FUSE_DEV_IOC_IOMAP_SUPPORT:
+		return fuse_dev_ioctl_iomap_support(file, argp);
 
 	default:
 		return -ENOTTY;
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 6ecca237196ac4..673647ddda0ccd 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -1724,3 +1724,18 @@ fuse_iomap_fallocate(
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
+		ios.flags = FUSE_IOMAP_SUPPORT_BASICS |
+			    FUSE_IOMAP_SUPPORT_DIRECTIO |
+			    FUSE_IOMAP_SUPPORT_FILEIO;
+
+	if (copy_to_user(argp, &ios, sizeof(ios)))
+		return -EFAULT;
+	return 0;
+}


