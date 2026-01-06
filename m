Return-Path: <linux-fsdevel+bounces-72427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BD0CF7011
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 08:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CE3A3060A48
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 07:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE3F309F04;
	Tue,  6 Jan 2026 07:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trUpK1/S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378553043C8;
	Tue,  6 Jan 2026 07:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767683596; cv=none; b=jMq0D7tr1dMX7o3aWkQ0HWu4Yc3FGFg55Z5MGagXKXPQSUU11FiWki8UTTwrf46ltv6sNu1Rzg/lKehDgBidKgQ6G0wyEdUoLnOfnJTvUbXj3PJBypqOVxYwpYLB3O10C6d1eAYhZ4msihkf3SJInpNOek4KAwsvMPDiI2HjhaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767683596; c=relaxed/simple;
	bh=pHRhbYPEuW5Topq6yK87fHOnzvNQK+OAgp3xs5MJ2uw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAhl6CvDCr0EfylHrf1/1U68ZW6cLaSrSuxc7Ttk84E/wvZKCVYw1b7T3Vr8K0iJI/yc0kiBYj5lwVZb6nNfmbOy1qWi1/8UBiKuv/ncZ/I7GW3+9APFmUk0UylfqBYn1T2I/xzDWi66KnoOWaeZL5oajTO/dJz62HyIpq/3xV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trUpK1/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E53C116C6;
	Tue,  6 Jan 2026 07:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767683594;
	bh=pHRhbYPEuW5Topq6yK87fHOnzvNQK+OAgp3xs5MJ2uw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=trUpK1/SIDaMCWMUJQGsbNQ91LcYk0BNOtnMvHX1z63Lk4NT23cxyA7W5SG7zuJiU
	 Fpsw2cpnPRBzbgV8HiaRx5QHleOMQ9gNOGgJpRpQQdr9gyXuwjLCyK4uRzCpE3yQJP
	 JasM5BDVysHqsApVYYrotPvHho70ONAQ1ZyhCLpWcApXrbuNmrPyuNBi9dFpOClJQW
	 FdoBKPiAAlVpanOZ3+aDzwYkgDemcwEVEBFgWEIWgR2NqDZhpIYl0UQh3cpprVL928
	 uHDaUHEc67Bs+Yd9Je6To6BPZ8Kd2wesQSWG50+zeikYYQ5rEzS/p6jjSCz8Iq9Lja
	 UJpopwURGCBzA==
Date: Mon, 05 Jan 2026 23:13:13 -0800
Subject: [PATCH 10/11] xfs: check if an open file is on the health monitored
 fs
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org
Message-ID: <176766637464.774337.1405334167328014704.stgit@frogsfrogsfrogs>
In-Reply-To: <176766637179.774337.3663793412524347917.stgit@frogsfrogsfrogs>
References: <176766637179.774337.3663793412524347917.stgit@frogsfrogsfrogs>
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
 fs/xfs/xfs_healthmon.c |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index ff160a5665601b..f2a7736f4fc0bc 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -1152,6 +1152,15 @@ struct xfs_health_monitor {
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
@@ -1192,7 +1201,8 @@ struct xfs_health_monitor {
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
index 1f1a2682659816..9baa9fd3ebd3a1 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -1155,6 +1155,37 @@ xfs_healthmon_reconfigure(
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
+	int				ret = 0;
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
+	if (!xfs_healthmon_covers_fs(hm, hms_inode->i_sb))
+		ret = -ESTALE;
+	mutex_unlock(&hm->lock);
+
+	return ret;
+}
+
 /* Handle ioctls for the health monitoring thread. */
 STATIC long
 xfs_healthmon_ioctl(
@@ -1167,6 +1198,8 @@ xfs_healthmon_ioctl(
 	switch (cmd) {
 	case XFS_IOC_HEALTH_MONITOR:
 		return xfs_healthmon_reconfigure(file, cmd, arg);
+	case XFS_IOC_HEALTH_FD_ON_MONITORED_FS:
+		return xfs_healthmon_file_on_monitored_fs(file, cmd, arg);
 	default:
 		break;
 	}


