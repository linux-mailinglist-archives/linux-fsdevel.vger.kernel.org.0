Return-Path: <linux-fsdevel+bounces-65263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F247BFEAC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 02:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024C13A2DCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 00:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380C522615;
	Thu, 23 Oct 2025 00:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6F8bT53"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901731FC3;
	Thu, 23 Oct 2025 00:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177903; cv=none; b=iQAiOUsOj2iN+7Q5xRfCc5OxG1tD3dqmft/zh2vQkvnv+qCpXdrdn10g2kFmvI3p3mjzxN7M8gsBn/ikyGU0cmuPo0RSOCj0YU3kr05qUOr+tJbO3aW/ChnPLs29YHQ4je9/2CEqTE6JH2MYHJuR+VbEz/Kbx4aRDiYZ40wYNvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177903; c=relaxed/simple;
	bh=NLlUZ8+Bw2RoVw6koIwaaGcQgJwt+GqJPauNvvvfth4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8SlCZL7WoUPN+Ov53BKVlNOHEJNJyf1x24wxV8pQOckkFuZFxaT5rFHtd1vhCtrQ4DkxOAMGZyL/Q9R5X88uPoOeogaMZdgS9+MISUL2bySbid42KVLjQUeOr4nEoBaYYunolpq5rApvepIsUlCXpHKGh+O8paKk2R1z0XJo8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6F8bT53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF98C4CEE7;
	Thu, 23 Oct 2025 00:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761177903;
	bh=NLlUZ8+Bw2RoVw6koIwaaGcQgJwt+GqJPauNvvvfth4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=d6F8bT53qAUYpK4PK+fIRGvPtkBf1q1ImxNFktr7JnZmxHTR8C2Nwmg8R495nmgwa
	 Lo+zcPyEFfKHjbrXabcbIR7Mhek+/A2kWSakECV1Je75nlcCdOb00POszK9pP/Z6rk
	 8O0CAqc9OSMs6LNhTs3mGY+Wl4oA+maTGvbvJig/WhMm/A6eBWzosJvt6YGAMAqvur
	 ZSWls4CDxsegc5cPL+XVpcPx5ht2ibd23mDDpVUE87kd/9dADBy2hPF+GtD4vDJmyH
	 R3+x/EhU8VgMG5hRXUDRXHI4zZnh71sWsS7FmEG2ZKOhTHO3Hh3bhzUlQmAf5IM7O9
	 GgUrwa58sXutw==
Date: Wed, 22 Oct 2025 17:05:02 -0700
Subject: [PATCH 17/19] xfs: validate fds against running healthmon
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176117744871.1025409.4299195373944376428.stgit@frogsfrogsfrogs>
In-Reply-To: <176117744372.1025409.2163337783918942983.stgit@frogsfrogsfrogs>
References: <176117744372.1025409.2163337783918942983.stgit@frogsfrogsfrogs>
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
 fs/xfs/libxfs/xfs_fs.h |   10 ++++++++++
 fs/xfs/xfs_healthmon.c |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 87e915baa875d6..b5a00ef6ce5fb9 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -1149,6 +1149,15 @@ struct xfs_health_monitor {
 /* Return events in JSON format */
 #define XFS_HEALTH_MONITOR_FMT_JSON	(1)
 
+/*
+ * Check that a given fd points to the same filesystem that the health monitor
+ * is monitoring.
+ */
+struct xfs_health_samefs {
+	__s32		fd;
+	__u32		flags;	/* zero for now */
+};
+
 /*
  * ioctl commands that are used by Linux filesystems
  */
@@ -1189,6 +1198,7 @@ struct xfs_health_monitor {
 #define XFS_IOC_SCRUBV_METADATA	_IOWR('X', 64, struct xfs_scrub_vec_head)
 #define XFS_IOC_RTGROUP_GEOMETRY _IOWR('X', 65, struct xfs_rtgroup_geometry)
 #define XFS_IOC_HEALTH_MONITOR	_IOW ('X', 68, struct xfs_health_monitor)
+#define XFS_IOC_HEALTH_SAMEFS	_IOW ('X', 69, struct xfs_health_samefs)
 
 /*
  * ioctl commands that replace IRIX syssgi()'s
diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index ce84cd90df2379..666c27d73efbdc 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -1565,6 +1565,36 @@ xfs_healthmon_reconfigure(
 	return 0;
 }
 
+/* Does the fd point to the same filesystem as the one we're monitoring? */
+STATIC long
+xfs_healthmon_samefs(
+	struct file			*file,
+	unsigned int			cmd,
+	void __user			*arg)
+{
+	struct xfs_health_samefs	hms;
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
+	if (!hm->mp || hm->mp->m_super != hms_inode->i_sb)
+		ret = -ESTALE;
+	mutex_unlock(&hm->lock);
+	return ret;
+}
+
 /* Handle ioctls for the health monitoring thread. */
 STATIC long
 xfs_healthmon_ioctl(
@@ -1577,6 +1607,8 @@ xfs_healthmon_ioctl(
 	switch (cmd) {
 	case XFS_IOC_HEALTH_MONITOR:
 		return xfs_healthmon_reconfigure(file, cmd, arg);
+	case XFS_IOC_HEALTH_SAMEFS:
+		return xfs_healthmon_samefs(file, cmd, arg);
 	default:
 		break;
 	}


