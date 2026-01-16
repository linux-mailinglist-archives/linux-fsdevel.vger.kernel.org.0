Return-Path: <linux-fsdevel+bounces-74057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C55ED2C1CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 06:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 112A43028197
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 05:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5226B347FDE;
	Fri, 16 Jan 2026 05:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuPYhjzN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D6027B34D;
	Fri, 16 Jan 2026 05:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768542278; cv=none; b=o45Dy4Ffd0QtKkJkRADlXq3z5zv6zH8yUMj02CMQ6FeCKDhPOQ8LUYKZb8n1Vt4vj4R+wMY80jUL+LXUFsy7b4VgPAOW9elKA28VpylWVnIiGMvutpAr0+u3nJr27VnkNiSsqifUwB9ixBGQ6BVKiFhyJxHHho6BAtkREG9iTvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768542278; c=relaxed/simple;
	bh=M3cSpS5wjRRMqDhgUY3rfZLw/c1sEkfXuQDLT5+I6LI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AMhSB3HFqqQ5UoIuMJBAk4/R0VFHyPnTwW+I7k+nCdGQkrDMmtttgiB6CDp0krBMJCcbRbInOWi818xX33kb0NQHqWLR1TZjGGBTrfCIVwhUkkJ56G2Ih/qJJjS/BiGraVPfup0Bv4AaJIQ6nLW369MHWbNyzd3FVUcbRifH5Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuPYhjzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61352C116C6;
	Fri, 16 Jan 2026 05:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768542278;
	bh=M3cSpS5wjRRMqDhgUY3rfZLw/c1sEkfXuQDLT5+I6LI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=QuPYhjzNCcePEHlP+MU+RDqXopk2jC9sK4lC4QkjIdBS0OKeFD4BZm6YTVnfdIHHQ
	 Ujpt9tW3TDYzFjqI900ifGxa6tinYMBFJkYDyr/Qw4mR+2yZJHX0tthI1A3+yj0z8Q
	 Kt9yntDzaMUIexNh9cor4FMRvPhE1DEqJSg6rdP9WiCB5VxLHuQy3zwDiFO9lwlXna
	 DLlp7/zV7R+KZAwe3RVUe8CQCVEz2RQfJ4hiLJ+fX8n+biHLzHy6kP7UxmuJQuFF28
	 t6MoTqa8uaLyc/7li7CcsPpuOMRJZIPMLW4eSvO+ekj/bYAY6KS7Amt3HTLDaXNYLa
	 TRusE8n7kdzsg==
Date: Thu, 15 Jan 2026 21:44:37 -0800
Subject: [PATCH 10/11] xfs: check if an open file is on the health monitored
 fs
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: hch@lst.de, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 hch@lst.de
Message-ID: <176852588755.2137143.15605496748994135226.stgit@frogsfrogsfrogs>
In-Reply-To: <176852588473.2137143.1604994842772101197.stgit@frogsfrogsfrogs>
References: <176852588473.2137143.1604994842772101197.stgit@frogsfrogsfrogs>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
index 4a8cbd87932201..3030fa93c1e575 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -1090,6 +1090,38 @@ xfs_healthmon_reconfigure(
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
@@ -1102,6 +1134,8 @@ xfs_healthmon_ioctl(
 	switch (cmd) {
 	case XFS_IOC_HEALTH_MONITOR:
 		return xfs_healthmon_reconfigure(file, cmd, arg);
+	case XFS_IOC_HEALTH_FD_ON_MONITORED_FS:
+		return xfs_healthmon_file_on_monitored_fs(file, cmd, arg);
 	default:
 		break;
 	}


