Return-Path: <linux-fsdevel+bounces-73353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF4ED16119
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 01:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60E823042055
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 00:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AEE173;
	Tue, 13 Jan 2026 00:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bz9qn+hK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A305187346;
	Tue, 13 Jan 2026 00:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768264511; cv=none; b=c2+fjwGav7Q0kH4UJyoEtFUUS7mgDOpMKRaF9dbf635JBhiy0668GqYhh3x05/Z+vvCcMNj4lz5P/BmwBlMC1TsJTp/A5qoLiahU87/ctV0V1+ZduvUUDJy8HXJd+3MZ6sYoCW/GPCZP1nDdlNiZSMtjhAnp/hq3XVAH8nYFylA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768264511; c=relaxed/simple;
	bh=7fX+Vz2N1Jt9l+lHRcNex6NJe5tQrlAwAUYV9gV41c4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OUnMWCWcrkHKhzjsmNtjp2TViCElkDFNNVjzjqA/uwIGXPd34SE6s+Nuh7PN6FW62Is3HI5pvMXM2wgsOpuHH5QjvtFTt4nuUxXxUd0EqVTPCI5fFfBobFvgrPMYg6UxAsffVvsmcMYw+trKwjm6tDaJBCG5wfRjaQd+JWuGth4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bz9qn+hK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9405BC116D0;
	Tue, 13 Jan 2026 00:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768264510;
	bh=7fX+Vz2N1Jt9l+lHRcNex6NJe5tQrlAwAUYV9gV41c4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bz9qn+hKP04OsbnwN+l+JWj7z7fqMI5Zsl3tHvpLt9PjS18+9K78TicHKyZfMd6FY
	 ZvzYFTNeWjF7P3kRGED/1Uc8LVe41neis3IT6RD5Te8laOVpYTWdIqVeSoKaqAfLyw
	 8ZwTJ/ogy2iHZPDSwMJJ8mOsZHsiuqGu/c/3e1Ijrunp5BIucR5ykGT6CzJegR5JjJ
	 aVri7T1OmJtCQ+2IvLprEPj8Y7CXItZrTqfBEhwm3JodlZKtE3UvcXM+Y7t9Ybccj0
	 KfO0Cl+jzqkaVup6DRJsoCL5WEbulabqc5aCWAzC52Hg+fETOT/VWGK5kIFEUo4I0K
	 O3FY1w9ZRx7mw==
Date: Mon, 12 Jan 2026 16:35:10 -0800
Subject: [PATCH 10/11] xfs: check if an open file is on the health monitored
 fs
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176826412920.3493441.8267006007622107509.stgit@frogsfrogsfrogs>
In-Reply-To: <176826412644.3493441.536177954776056129.stgit@frogsfrogsfrogs>
References: <176826412644.3493441.536177954776056129.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a new ioctl for the healthmon file that checks that a given fd
points to the same filesystem that the healthmon file is monitoring.
This allows xfs_healer to check that when it reopens a mountpoint to
perform repairs, the file that it gets matches the filesystem that
generated the corruption report.

(Note that xfs_healer doesn't maintain an open fd to a filesystem that
it's monitoring so that it doesn't pin the mount.)

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h |   12 +++++++++++-
 fs/xfs/xfs_healthmon.c |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 4ec1b2aede976f..a01303c5de6ce6 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -1151,6 +1151,15 @@ struct xfs_health_monitor {
 /* Initial return format version */
 #define XFS_HEALTH_MONITOR_FMT_V0	(0)
 
+/*
+ * Check that a given fd points to the same filesystem that the health monitor
+ * is monitoring.
+ */
+struct xfs_health_file_on_monitored_fs {
+	__s32		fd;
+	__u32		flags;	/* zero for now */
+};
+
 /*
  * ioctl commands that are used by Linux filesystems
  */
@@ -1191,7 +1200,8 @@ struct xfs_health_monitor {
 #define XFS_IOC_SCRUBV_METADATA	_IOWR('X', 64, struct xfs_scrub_vec_head)
 #define XFS_IOC_RTGROUP_GEOMETRY _IOWR('X', 65, struct xfs_rtgroup_geometry)
 #define XFS_IOC_HEALTH_MONITOR	_IOW ('X', 68, struct xfs_health_monitor)
-
+#define XFS_IOC_HEALTH_FD_ON_MONITORED_FS \
+				_IOW ('X', 69, struct xfs_health_file_on_monitored_fs)
 /*
  * ioctl commands that replace IRIX syssgi()'s
  */
diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index 548c5777d4c596..e8e8dc5b489104 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -1106,6 +1106,38 @@ xfs_healthmon_reconfigure(
 	return 0;
 }
 
+/* Does the fd point to the same filesystem as the one we're monitoring? */
+STATIC long
+xfs_healthmon_file_on_monitored_fs(
+	struct file			*file,
+	unsigned int			cmd,
+	void __user			*arg)
+{
+	struct xfs_health_file_on_monitored_fs hms;
+	struct xfs_healthmon		*hm = file->private_data;
+	struct inode			*hms_inode;
+
+	if (copy_from_user(&hms, arg, sizeof(hms)))
+		return -EFAULT;
+
+	if (hms.flags)
+		return -EINVAL;
+
+	CLASS(fd, hms_fd)(hms.fd);
+	if (fd_empty(hms_fd))
+		return -EBADF;
+
+	hms_inode = file_inode(fd_file(hms_fd));
+	mutex_lock(&hm->lock);
+	if (hm->mount_cookie != (uintptr_t)hms_inode->i_sb) {
+		mutex_unlock(&hm->lock);
+		return -ESTALE;
+	}
+
+	mutex_unlock(&hm->lock);
+	return 0;
+}
+
 /* Handle ioctls for the health monitoring thread. */
 STATIC long
 xfs_healthmon_ioctl(
@@ -1118,6 +1150,8 @@ xfs_healthmon_ioctl(
 	switch (cmd) {
 	case XFS_IOC_HEALTH_MONITOR:
 		return xfs_healthmon_reconfigure(file, cmd, arg);
+	case XFS_IOC_HEALTH_FD_ON_MONITORED_FS:
+		return xfs_healthmon_file_on_monitored_fs(file, cmd, arg);
 	default:
 		break;
 	}


