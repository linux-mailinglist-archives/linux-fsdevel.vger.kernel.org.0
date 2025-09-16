Return-Path: <linux-fsdevel+bounces-61525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CE7B58992
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6698418913B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831D62BB13;
	Tue, 16 Sep 2025 00:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKxKCdQx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC2335950;
	Tue, 16 Sep 2025 00:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982761; cv=none; b=qbcTw4l/L8c6YJ6ywdbUwxVmhgD1+J9a9Z6aaMv21GA2xp+zk7yK0oqfEfaqaAzcSV/kU6fm4LVd/xDxYvKswQbWai5qcuy/aMblMqTnZWDmVc3WoxhKue2uLupAPPGY2kr/bp52DVplyWUfBgJwVqnjGa+AZ95//SPDNTL0AiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982761; c=relaxed/simple;
	bh=b4bvTxWt9wBescsXc7j13AO9/og7NWS7a50fz0p/izY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PCtqlItlMDlUEQme54n2rmaEyhdl6uh0OTJ2Zva0ecIpTx8liTKMowQB7glktI0uLyt5mhQ+i3OlX5FUHh0QaFjD2pV1Q/UBURaJXkQ+MwzzneCbD5ZL8hE5C4ZNDSuzBCZcLZoCYz0O4AK8Fyjqlrx++j3ZqXCSLDMo61dX+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKxKCdQx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E47C4CEF1;
	Tue, 16 Sep 2025 00:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982760;
	bh=b4bvTxWt9wBescsXc7j13AO9/og7NWS7a50fz0p/izY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=CKxKCdQxpYTBXJI8TsfvqedMkHi8rXSY+5hnBRFMJK7i2QAnwNC9aV7be+0pN6Ula
	 82QpT03gqu2Q5q1CaRSM9IivKD1uLJV0W9PvAf8LCRrtk+jEWV8VILZboZlCgYyf6F
	 nCHtDWrDzOV1dKSskAz2yw9Ww1ToWgmUWQ2YkawBVWlDM0gUzkOmq162BDa3snuiNO
	 MuksmiRxnOhbcQJHj2OE4rdpucYh+Ixkb2V7TtSW86Gs91fubje74WdreQ53N/7yME
	 OLA63zzb24LfpTVFJJTfqHLG/V2gOsQ2P4OYjNTvwmv+xGsD3Bt/dP1JQGNNa7LN4t
	 0auYwmprJfP6Q==
Date: Mon, 15 Sep 2025 17:32:40 -0700
Subject: [PATCH 18/28] fuse: advertise support for iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798151652.382724.14368883407195482424.stgit@frogsfrogsfrogs>
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
index 7581d22de2340c..82191e92c21097 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1781,6 +1781,9 @@ int fuse_iomap_fallocate(struct file *file, int mode, loff_t offset,
 			 loff_t length, loff_t new_size);
 int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 				 loff_t endpos);
+
+int fuse_dev_ioctl_iomap_support(struct file *file,
+				 struct fuse_iomap_support __user *argp);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -1803,6 +1806,7 @@ int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 # define fuse_iomap_setsize_start(...)		(-ENOSYS)
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
+# define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index c0af8a4d3e30d8..675b1d4fdff8db 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1139,6 +1139,13 @@ struct fuse_backing_map {
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
@@ -1146,6 +1153,8 @@ struct fuse_backing_map {
 					     struct fuse_backing_map)
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
 #define FUSE_DEV_IOC_SYNC_INIT		_IO(FUSE_DEV_IOC_MAGIC, 3)
+#define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 99, \
+					     struct fuse_iomap_support)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 871877cac2acf3..bb0ec19a368bea 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2710,6 +2710,9 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 	case FUSE_DEV_IOC_SYNC_INIT:
 		return fuse_dev_ioctl_sync_init(file);
 
+	case FUSE_DEV_IOC_IOMAP_SUPPORT:
+		return fuse_dev_ioctl_iomap_support(file, argp);
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 6cc1f91fe3d5a4..5cefceb267f8f1 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -1695,3 +1695,16 @@ fuse_iomap_fallocate(
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


