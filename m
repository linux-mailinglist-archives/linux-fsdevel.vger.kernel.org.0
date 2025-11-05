Return-Path: <linux-fsdevel+bounces-67040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 240B0C338AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FF384F0974
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C540C23D7F2;
	Wed,  5 Nov 2025 00:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7CFMhXO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5F523BCF7;
	Wed,  5 Nov 2025 00:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303972; cv=none; b=pUhXohBWb7wkMHryrgC3JgLNM8Io4oT3zIuZEBUFYSYlK2ll9azT25sRNdRgkzyiuk9Wvc5CfA1QTbg1E1qA1oLSPL/nw788HGIh+GhlvNI+xSne+moX6ALioz4rxtgvhAb9wgKfk5ruysC/WqgfCaaax8Qq6hKZKV4LHWwhfr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303972; c=relaxed/simple;
	bh=4jp8T1hYM5oxyGVaAsNh4j4een+0DKZTKlKQjiTgn7E=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMLF5X+m4UXxQcYy/UqwR9w2SDqwWIhAkMMkUpWrE2c4L2N0Sm6SsTSkNmXUBI+knaNVQy+yCHVE5oSPfQSYQsu601IIO6gqDhccE3tMJRLyEhdAi7P4NcIFm9O5pMTszFvktMXeWWGVcdnuNRtnEqElnsoMD3u0vNYNreMiIBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7CFMhXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA3FC4CEF7;
	Wed,  5 Nov 2025 00:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762303971;
	bh=4jp8T1hYM5oxyGVaAsNh4j4een+0DKZTKlKQjiTgn7E=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=P7CFMhXOK3g4jl6JA1GzZnCRaTMk0BXKU+1hJEv6VYIqT25Z3+WEOpBAsSwtMb+m+
	 9JARexoZeGTqdSNT/htp6xKbE6NMBW18j4+y2xDT7qFw+yJndhw+MlQiQUgerfUxRA
	 dHHeU4CVxIxR2mXHk3tsJu00uvskuIddOSnP4PjLHHLYIh7jFWmKJQoVMDIw9t14L1
	 uwmHLzrfhH1y9ljhOaefP8sIzpLvlmEwS+YJjVhMtCDlEcGlu38CnYy50mUQhuSSNn
	 zv9O9cELwhXvbe8NQ96XxpEqLV/kygUK7FOBtA41pljVPuF4WuA25/ibT02Rx1iMPA
	 7r7z9iHttJwRA==
Date: Tue, 04 Nov 2025 16:52:51 -0800
Subject: [PATCH 17/22] xfs: validate fds against running healthmon
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176230366062.1647136.14419850847434451068.stgit@frogsfrogsfrogs>
In-Reply-To: <176230365543.1647136.3601811429298452884.stgit@frogsfrogsfrogs>
References: <176230365543.1647136.3601811429298452884.stgit@frogsfrogsfrogs>
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
index a96f11d9bd9c64..2b82535196cdb0 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -1147,6 +1147,15 @@ struct xfs_health_monitor {
 /* Initial return format version */
 #define XFS_HEALTH_MONITOR_FMT_V0	(0)
 
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
@@ -1187,6 +1196,7 @@ struct xfs_health_monitor {
 #define XFS_IOC_SCRUBV_METADATA	_IOWR('X', 64, struct xfs_scrub_vec_head)
 #define XFS_IOC_RTGROUP_GEOMETRY _IOWR('X', 65, struct xfs_rtgroup_geometry)
 #define XFS_IOC_HEALTH_MONITOR	_IOW ('X', 68, struct xfs_health_monitor)
+#define XFS_IOC_HEALTH_SAMEFS	_IOW ('X', 69, struct xfs_health_samefs)
 
 /*
  * ioctl commands that replace IRIX syssgi()'s
diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index d3784073494ec6..9752b058978995 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -1164,6 +1164,36 @@ xfs_healthmon_reconfigure(
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
@@ -1176,6 +1206,8 @@ xfs_healthmon_ioctl(
 	switch (cmd) {
 	case XFS_IOC_HEALTH_MONITOR:
 		return xfs_healthmon_reconfigure(file, cmd, arg);
+	case XFS_IOC_HEALTH_SAMEFS:
+		return xfs_healthmon_samefs(file, cmd, arg);
 	default:
 		break;
 	}


