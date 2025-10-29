Return-Path: <linux-fsdevel+bounces-66020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A297CC17A3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E953BC56B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6956A2D46B6;
	Wed, 29 Oct 2025 00:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMFkhXAM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C5A19F464;
	Wed, 29 Oct 2025 00:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698979; cv=none; b=YuuPlxzv9Fc0BZgAwWNnaneh1oGH5LxvjzkYpAej8rgNuX0JYr6m/SA7qvYnDOKE/O3YSOV0q4KizwnTaFF0eQPBrgQTsTe6NQh6n+licVJ1fFKluL0NqHGrf+6w8KxCrCkYUerHVTw7EVAVKtK3tuYAtGgKkFJUlvZ6QgA1axM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698979; c=relaxed/simple;
	bh=wc5a1LnmZP94dyfnR9XD0bIsLarjV4A0HqHOwRww1pE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ks/9eselhesf9nVpPH5tgZfTNXFSzJxToyBf+pDEHJMEz2wCLx8IpI+Er5Zxq54aVC6ESKYzcshFT4HyigNEmTrePDTYHIWRqy2eJMiynXAtCByYtbJ/4tG4N9Cg8wANpui/KCIG878S/h12ly9QoK/+G2CyQPtc+aTnZGvwaLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMFkhXAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C962C4CEE7;
	Wed, 29 Oct 2025 00:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698979;
	bh=wc5a1LnmZP94dyfnR9XD0bIsLarjV4A0HqHOwRww1pE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=WMFkhXAMsA8nmoQ/ObN0vgL201vZr5VcWMCeD+FRg9T8v8G73x1L+SQjMTX9ifkls
	 Ph2GW44/lQ6+zBDxFhGiOCRsPM6if6qwxMydYgzJJNQA5fQ9hn3P2vXc4vfKOs3hHs
	 FwXGZjB5EJ02IJNZulPXjgPEG2PC2P7B+TM9qc3qCheq2+obpRQ025sBJqD6nlRm5+
	 glDV90//3fAkebfI3yT8/8KDENL761hAfN8mRU7SfdpG/qTdJ4Be/qggdLWLIsa0ZT
	 KNWNqF7GWzwsbaLy5fWWS5eXX0AQH36OibHSMvUf3/I1gYkzxfFI9puc6CU0kLQRMN
	 bNO3xz+Jz7Vuw==
Date: Tue, 28 Oct 2025 17:49:38 -0700
Subject: [PATCH 18/31] fuse: advertise support for iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169810743.1424854.229610268963069051.stgit@frogsfrogsfrogs>
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
index 5451b0a2b3dc19..590c0fa6763d1e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1784,6 +1784,9 @@ int fuse_iomap_fallocate(struct file *file, int mode, loff_t offset,
 			 loff_t length, loff_t new_size);
 int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 				 loff_t endpos);
+
+int fuse_dev_ioctl_iomap_support(struct file *file,
+				 struct fuse_iomap_support __user *argp);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -1807,6 +1810,7 @@ int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 # define fuse_iomap_setsize_start(...)		(-ENOSYS)
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
+# define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index e02c474ed04bc2..c798aaa6d60884 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1151,6 +1151,13 @@ struct fuse_backing_map {
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
@@ -1158,6 +1165,8 @@ struct fuse_backing_map {
 					     struct fuse_backing_map)
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
 #define FUSE_DEV_IOC_SYNC_INIT		_IO(FUSE_DEV_IOC_MAGIC, 3)
+#define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 99, \
+					     struct fuse_iomap_support)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 12cc673df99151..7aa7bf2f8348d2 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2719,6 +2719,9 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 	case FUSE_DEV_IOC_SYNC_INIT:
 		return fuse_dev_ioctl_sync_init(file);
 
+	case FUSE_DEV_IOC_IOMAP_SUPPORT:
+		return fuse_dev_ioctl_iomap_support(file, argp);
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index a9bacaa0991afa..21f7227c351b89 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -1716,3 +1716,16 @@ fuse_iomap_fallocate(
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


