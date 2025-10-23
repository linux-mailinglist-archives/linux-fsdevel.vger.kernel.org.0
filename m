Return-Path: <linux-fsdevel+bounces-65256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D70BFEA75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 02:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E3018947F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 00:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EFD15E97;
	Thu, 23 Oct 2025 00:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlGSW3Qw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF29429A2;
	Thu, 23 Oct 2025 00:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177793; cv=none; b=OJwnd87AEHlrQdpzQ1h1IYqcwp0g+35Otu2aZkS5d5pjJ6j/J6L6JN6wPH32+iUkfABrtCK1cTbNnBgccuFlQY5fRcQKhcuOndNJzp9tbrsr1e00Lg9TNnPyefExC49yoGwL1lxO3Fkbdsrg6R28iOJiTT8hWcmHLWjXIxnMaQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177793; c=relaxed/simple;
	bh=Ed9/wTt3gSUdvxrlHX2ZEGSMGgGGlKTzUywRVDH2tgM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/2Dlu4Big6O9+IUhkx+jYjkVG6Ri6AUhQA/kP++OC0yFr49DUjrdyaOuVYQE4oal3EzM8vacN7YSQpHaH8QN2WFlnu4io6he4bL5AKuvedDBmXeDaqohNsXIdOIT4R/RpVNR1ERbzZ3fAKj7CcPQz+4HNKAGB7WwlvVueAaTFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlGSW3Qw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77245C4CEE7;
	Thu, 23 Oct 2025 00:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761177792;
	bh=Ed9/wTt3gSUdvxrlHX2ZEGSMGgGGlKTzUywRVDH2tgM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=VlGSW3Qw5mp2bXfsOy4BUvhwQrmy7wM54Md0mqnBcjGFvj7F07qqsrfFavvzR+Qv+
	 yjcm/OQbUjxvww++ny9Z2RlGmskgrghFzNdptNiw7sMDSs/Talc0AFMv/zEQW062T/
	 zQ8f/doGuN6c2Vs5HUbyhwQSe3KP9MC3LY5bpSNZImVSeKnD+p2N5Hleow31dEV92/
	 919OIEzAPV4lBPUNXyi64irIGAbWLnRJEb/jMb3P3GUZoPygfVOGhwow4AcBukYqyE
	 bMEmZK9qwkQg0am4snSO8oYYYAONQ5ODWdAHr1Jow9ELwjEaY/foEDL+XToYqtI3VR
	 +X805QG8Mkwcw==
Date: Wed, 22 Oct 2025 17:03:12 -0700
Subject: [PATCH 10/19] xfs: create a special file to pass filesystem health to
 userspace
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176117744716.1025409.3867310682251633368.stgit@frogsfrogsfrogs>
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

Create an ioctl that installs a file descriptor backed by an anon_inode
file that will convey filesystem health events to userspace.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h |    8 ++
 fs/xfs/xfs_healthmon.h |   16 +++++
 fs/xfs/Kconfig         |    8 ++
 fs/xfs/Makefile        |    1 
 fs/xfs/xfs_healthmon.c |  157 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_ioctl.c     |    4 +
 6 files changed, 194 insertions(+)
 create mode 100644 fs/xfs/xfs_healthmon.h
 create mode 100644 fs/xfs/xfs_healthmon.c


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 12463ba766da05..dba7896f716092 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -1003,6 +1003,13 @@ struct xfs_rtgroup_geometry {
 #define XFS_RTGROUP_GEOM_SICK_RMAPBT	(1U << 3)  /* reverse mappings */
 #define XFS_RTGROUP_GEOM_SICK_REFCNTBT	(1U << 4)  /* reference counts */
 
+struct xfs_health_monitor {
+	__u64	flags;		/* flags */
+	__u8	format;		/* output format */
+	__u8	pad1[7];	/* zeroes */
+	__u64	pad2[2];	/* zeroes */
+};
+
 /*
  * ioctl commands that are used by Linux filesystems
  */
@@ -1042,6 +1049,7 @@ struct xfs_rtgroup_geometry {
 #define XFS_IOC_GETPARENTS_BY_HANDLE _IOWR('X', 63, struct xfs_getparents_by_handle)
 #define XFS_IOC_SCRUBV_METADATA	_IOWR('X', 64, struct xfs_scrub_vec_head)
 #define XFS_IOC_RTGROUP_GEOMETRY _IOWR('X', 65, struct xfs_rtgroup_geometry)
+#define XFS_IOC_HEALTH_MONITOR	_IOW ('X', 68, struct xfs_health_monitor)
 
 /*
  * ioctl commands that replace IRIX syssgi()'s
diff --git a/fs/xfs/xfs_healthmon.h b/fs/xfs/xfs_healthmon.h
new file mode 100644
index 00000000000000..07126e39281a0c
--- /dev/null
+++ b/fs/xfs/xfs_healthmon.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2024-2025 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#ifndef __XFS_HEALTHMON_H__
+#define __XFS_HEALTHMON_H__
+
+#ifdef CONFIG_XFS_HEALTH_MONITOR
+long xfs_ioc_health_monitor(struct xfs_mount *mp,
+		struct xfs_health_monitor __user *arg);
+#else
+# define xfs_ioc_health_monitor(mp, hmo)	(-ENOTTY)
+#endif /* CONFIG_XFS_HEALTH_MONITOR */
+
+#endif /* __XFS_HEALTHMON_H__ */
diff --git a/fs/xfs/Kconfig b/fs/xfs/Kconfig
index 8930d5254e1da6..b5d48515236302 100644
--- a/fs/xfs/Kconfig
+++ b/fs/xfs/Kconfig
@@ -121,6 +121,14 @@ config XFS_RT
 
 	  If unsure, say N.
 
+config XFS_HEALTH_MONITOR
+	bool "Report filesystem health events to userspace"
+	depends on XFS_FS
+	select XFS_LIVE_HOOKS
+	default y
+	help
+	  Report health events to userspace programs.
+
 config XFS_DRAIN_INTENTS
 	bool
 	select JUMP_LABEL if HAVE_ARCH_JUMP_LABEL
diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index 5bf501cf827172..d4e9070a9326ba 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -157,6 +157,7 @@ xfs-$(CONFIG_XFS_DRAIN_INTENTS)	+= xfs_drain.o
 xfs-$(CONFIG_XFS_LIVE_HOOKS)	+= xfs_hooks.o
 xfs-$(CONFIG_XFS_MEMORY_BUFS)	+= xfs_buf_mem.o
 xfs-$(CONFIG_XFS_BTREE_IN_MEM)	+= libxfs/xfs_btree_mem.o
+xfs-$(CONFIG_XFS_HEALTH_MONITOR) += xfs_healthmon.o
 
 # online scrub/repair
 ifeq ($(CONFIG_XFS_ONLINE_SCRUB),y)
diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
new file mode 100644
index 00000000000000..7b0d9f78b0a402
--- /dev/null
+++ b/fs/xfs/xfs_healthmon.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024-2025 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#include "xfs.h"
+#include "xfs_fs.h"
+#include "xfs_shared.h"
+#include "xfs_format.h"
+#include "xfs_log_format.h"
+#include "xfs_trans_resv.h"
+#include "xfs_mount.h"
+#include "xfs_inode.h"
+#include "xfs_trace.h"
+#include "xfs_ag.h"
+#include "xfs_btree.h"
+#include "xfs_da_format.h"
+#include "xfs_da_btree.h"
+#include "xfs_quota_defs.h"
+#include "xfs_rtgroup.h"
+#include "xfs_healthmon.h"
+
+#include <linux/anon_inodes.h>
+#include <linux/eventpoll.h>
+#include <linux/poll.h>
+
+/*
+ * Live Health Monitoring
+ * ======================
+ *
+ * Autonomous self-healing of XFS filesystems requires a means for the kernel
+ * to send filesystem health events to a monitoring daemon in userspace.  To
+ * accomplish this, we establish a thread_with_file kthread object to handle
+ * translating internal events about filesystem health into a format that can
+ * be parsed easily by userspace.  Then we hook various parts of the filesystem
+ * to supply those internal events to the kthread.  Userspace reads events
+ * from the file descriptor returned by the ioctl.
+ *
+ * The healthmon abstraction has a weak reference to the host filesystem mount
+ * so that the queueing and processing of the events do not pin the mount and
+ * cannot slow down the main filesystem.  The healthmon object can exist past
+ * the end of the filesystem mount.
+ */
+
+struct xfs_healthmon {
+	struct xfs_mount		*mp;
+};
+
+/*
+ * Convey queued event data to userspace.  First copy any remaining bytes in
+ * the outbuf, then format the oldest event into the outbuf and copy that too.
+ */
+STATIC ssize_t
+xfs_healthmon_read_iter(
+	struct kiocb		*iocb,
+	struct iov_iter		*to)
+{
+	return -EIO;
+}
+
+/* Free the health monitoring information. */
+STATIC int
+xfs_healthmon_release(
+	struct inode		*inode,
+	struct file		*file)
+{
+	struct xfs_healthmon	*hm = file->private_data;
+
+	kfree(hm);
+
+	return 0;
+}
+
+/* Validate ioctl parameters. */
+static inline bool
+xfs_healthmon_validate(
+	const struct xfs_health_monitor	*hmo)
+{
+	if (hmo->flags)
+		return false;
+	if (hmo->format)
+		return false;
+	if (memchr_inv(&hmo->pad1, 0, sizeof(hmo->pad1)))
+		return false;
+	if (memchr_inv(&hmo->pad2, 0, sizeof(hmo->pad2)))
+		return false;
+	return true;
+}
+
+/* Emit some data about the health monitoring fd. */
+#ifdef CONFIG_PROC_FS
+static void
+xfs_healthmon_show_fdinfo(
+	struct seq_file		*m,
+	struct file		*file)
+{
+	struct xfs_healthmon	*hm = file->private_data;
+
+	seq_printf(m, "state:\talive\ndev:\t%s\n",
+			hm->mp->m_super->s_id);
+}
+#endif
+
+static const struct file_operations xfs_healthmon_fops = {
+	.owner		= THIS_MODULE,
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo	= xfs_healthmon_show_fdinfo,
+#endif
+	.read_iter	= xfs_healthmon_read_iter,
+	.release	= xfs_healthmon_release,
+};
+
+/*
+ * Create a health monitoring file.  Returns an index to the fd table or a
+ * negative errno.
+ */
+long
+xfs_ioc_health_monitor(
+	struct xfs_mount		*mp,
+	struct xfs_health_monitor __user *arg)
+{
+	struct xfs_health_monitor	hmo;
+	struct xfs_healthmon		*hm;
+	int				fd;
+	int				ret;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (copy_from_user(&hmo, arg, sizeof(hmo)))
+		return -EFAULT;
+
+	if (!xfs_healthmon_validate(&hmo))
+		return -EINVAL;
+
+	hm = kzalloc(sizeof(*hm), GFP_KERNEL);
+	if (!hm)
+		return -ENOMEM;
+	hm->mp = mp;
+
+	/*
+	 * Create the anonymous file.  If it succeeds, the file owns hm and
+	 * can go away at any time, so we must not access it again.
+	 */
+	fd = anon_inode_getfd("xfs_healthmon", &xfs_healthmon_fops, hm,
+			O_CLOEXEC | O_RDONLY);
+	if (fd < 0) {
+		ret = fd;
+		goto out_hm;
+	}
+
+	return fd;
+
+out_hm:
+	kfree(hm);
+	return ret;
+}
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index a6bb7ee7a27ad5..08998d84554f09 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -41,6 +41,7 @@
 #include "xfs_exchrange.h"
 #include "xfs_handle.h"
 #include "xfs_rtgroup.h"
+#include "xfs_healthmon.h"
 
 #include <linux/mount.h>
 #include <linux/fileattr.h>
@@ -1421,6 +1422,9 @@ xfs_file_ioctl(
 	case XFS_IOC_COMMIT_RANGE:
 		return xfs_ioc_commit_range(filp, arg);
 
+	case XFS_IOC_HEALTH_MONITOR:
+		return xfs_ioc_health_monitor(mp, arg);
+
 	default:
 		return -ENOTTY;
 	}


