Return-Path: <linux-fsdevel+bounces-72419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC45CF6FC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 08:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7C1F301D62C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 07:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB23309EF9;
	Tue,  6 Jan 2026 07:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4l922Og"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6831C2D541B;
	Tue,  6 Jan 2026 07:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767683469; cv=none; b=K/0H7l18ws2qGK0ap2qCTgL9SlOYie8Zt/aONlJrTxswQwxtY4XUeYl8V+ElFQULHxofRJpUZtKaPqOQzdIsir+Xo1BuFmDwfLqXHmOxB2cn3AIrWh7em7qnSUk5aNUqL2UiTGNw+vdP90KU289Xm6kX/RbadsEUkpy02C5jADw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767683469; c=relaxed/simple;
	bh=Mc0ERzKZyKTQldNu1jLs4uoarbRe4OkA6nTupWU39uA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EU55J48FYbYVdAgYT2Pmpi400MokRxaZ5lqBpQvu49HviP0l7fmwLbBbC/Fmxbm+WMu6Otmlt778hJXj//Ja83Zh/HE3lDSr2G534OHygQcJSO2+ee8lSFZ/D/qLcbk6D1G03oiCbc3siOhYfI0+tRepjdEGJzUTPKqkr4Ceew0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4l922Og; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0610AC116C6;
	Tue,  6 Jan 2026 07:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767683469;
	bh=Mc0ERzKZyKTQldNu1jLs4uoarbRe4OkA6nTupWU39uA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=i4l922OgHSs/YR68w0acfxkFV/Xb+jAWMvcKhwNVKGWv6TTG4q4h9gm/vEvDZtLrY
	 lxxcznndOljL2Z+glJ5WlfWYIt902DGp/IyrKj2TFrVlRP+qAsx81V7EtjbCd7TBEJ
	 gwV6TQ9UV/71OFzFuc3catqRaPrWX7l3SNWHjy1KB8kg2v9UE5rvT4ZKJxbOegSjT0
	 zSLn2+z6+hVHo2wf+Vx1RjlSu8O1i5rUluy6Ta1AnSG4mzfi4RQiGyoE17t2bMN3B+
	 W4UFHwuQRmy/5hEuFjeVEscMhGXcmtDWJiBNL/umBwFhKCqKPfI5WJ5mdfTdMwBwrZ
	 85Uo2TOv7gMKw==
Date: Mon, 05 Jan 2026 23:11:08 -0800
Subject: [PATCH 02/11] xfs: start creating infrastructure for health
 monitoring
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org
Message-ID: <176766637289.774337.11016648296945814848.stgit@frogsfrogsfrogs>
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

Start creating helper functions and infrastructure to pass filesystem
health events to a health monitoring file.  Since this is an
administrative interface, we only support a single health monitor
process per filesystem, so we don't need to use anything fancy such as
notifier chains (== tons of indirect calls).

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h |    8 +
 fs/xfs/xfs_healthmon.h |   36 ++++++
 fs/xfs/xfs_mount.h     |    4 +
 fs/xfs/Makefile        |    1 
 fs/xfs/xfs_health.c    |    1 
 fs/xfs/xfs_healthmon.c |  294 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_ioctl.c     |    4 +
 fs/xfs/xfs_mount.c     |    2 
 8 files changed, 350 insertions(+)
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
index 00000000000000..218d5aac87b012
--- /dev/null
+++ b/fs/xfs/xfs_healthmon.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2024-2026 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#ifndef __XFS_HEALTHMON_H__
+#define __XFS_HEALTHMON_H__
+
+struct xfs_healthmon {
+	/*
+	 * Weak reference to the xfs filesystem that is being monitored.  It
+	 * will be set to zero when the filesystem detaches from the monitor.
+	 * Do not dereference this pointer.
+	 */
+	uintptr_t			mount_cookie;
+
+	/*
+	 * Device number of the filesystem being monitored.  This is for
+	 * consistent tracing even after unmount.
+	 */
+	dev_t				dev;
+
+	/*
+	 * Reference count of this structure.  The open healthmon fd holds one
+	 * ref, the xfs_mount holds another ref if it points to this object,
+	 * and running event handlers hold their own refs.
+	 */
+	refcount_t			ref;
+};
+
+void xfs_healthmon_unmount(struct xfs_mount *mp);
+
+long xfs_ioc_health_monitor(struct file *file,
+		struct xfs_health_monitor __user *arg);
+
+#endif /* __XFS_HEALTHMON_H__ */
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index b871dfde372b52..61c71128d171cb 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -13,6 +13,7 @@ struct xfs_ail;
 struct xfs_quotainfo;
 struct xfs_da_geometry;
 struct xfs_perag;
+struct xfs_healthmon;
 
 /* dynamic preallocation free space thresholds, 5% down to 1% */
 enum {
@@ -342,6 +343,9 @@ typedef struct xfs_mount {
 
 	/* Hook to feed dirent updates to an active online repair. */
 	struct xfs_hooks	m_dir_update_hooks;
+
+	/* Private data referring to a health monitor object. */
+	struct xfs_healthmon	*m_healthmon;
 } xfs_mount_t;
 
 #define M_IGEO(mp)		(&(mp)->m_ino_geo)
diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index 5bf501cf827172..1b7385e23b3463 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -88,6 +88,7 @@ xfs-y				+= xfs_aops.o \
 				   xfs_globals.o \
 				   xfs_handle.o \
 				   xfs_health.o \
+				   xfs_healthmon.o \
 				   xfs_icache.o \
 				   xfs_ioctl.o \
 				   xfs_iomap.o \
diff --git a/fs/xfs/xfs_health.c b/fs/xfs/xfs_health.c
index fbb8886c72fe5e..3d50397f8f7c00 100644
--- a/fs/xfs/xfs_health.c
+++ b/fs/xfs/xfs_health.c
@@ -19,6 +19,7 @@
 #include "xfs_da_btree.h"
 #include "xfs_quota_defs.h"
 #include "xfs_rtgroup.h"
+#include "xfs_healthmon.h"
 
 #include <linux/fserror.h>
 
diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
new file mode 100644
index 00000000000000..3fdac72b478f3f
--- /dev/null
+++ b/fs/xfs/xfs_healthmon.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024-2026 Oracle.  All Rights Reserved.
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
+/* sign of a detached health monitor */
+#define DETACHED_MOUNT_COOKIE		((uintptr_t)0)
+
+/* spinlock for atomically updating xfs_mount <-> xfs_healthmon pointers */
+static DEFINE_SPINLOCK(xfs_healthmon_lock);
+
+/* Grab a reference to the healthmon object for a given mount, if any. */
+static struct xfs_healthmon *
+xfs_healthmon_get(
+	struct xfs_mount		*mp)
+{
+	struct xfs_healthmon		*hm;
+
+	rcu_read_lock();
+	hm = mp->m_healthmon;
+	if (hm && !refcount_inc_not_zero(&hm->ref))
+		hm = NULL;
+	rcu_read_unlock();
+
+	return hm;
+}
+
+/*
+ * Free the health monitor after an RCU grace period to eliminate possibility
+ * of races with xfs_healthmon_get.
+ */
+static inline void
+xfs_healthmon_free(
+	struct xfs_healthmon		*hm)
+{
+	kfree_rcu_mightsleep(hm);
+}
+
+/*
+ * Release the reference to a healthmon object and free it if there are no
+ * more holders.
+ */
+static void
+xfs_healthmon_put(
+	struct xfs_healthmon		*hm)
+{
+	if (refcount_dec_and_test(&hm->ref))
+		xfs_healthmon_free(hm);
+}
+
+/* Is this health monitor active? */
+static inline bool
+xfs_healthmon_activated(
+	struct xfs_healthmon	*hm)
+{
+	return hm->mount_cookie != DETACHED_MOUNT_COOKIE;
+}
+
+/* Is this health monitor watching the given filesystem? */
+static inline bool
+xfs_healthmon_covers_fs(
+	struct xfs_healthmon	*hm,
+	struct super_block	*sb)
+{
+	return hm->mount_cookie == (uintptr_t)sb;
+}
+
+/* Attach a health monitor to an xfs_mount.  Only one allowed at a time. */
+STATIC int
+xfs_healthmon_attach(
+	struct xfs_mount	*mp,
+	struct xfs_healthmon	*hm)
+{
+	int			ret = 0;
+
+	spin_lock(&xfs_healthmon_lock);
+	if (mp->m_healthmon == NULL) {
+		mp->m_healthmon = hm;
+		hm->mount_cookie = (uintptr_t)mp->m_super;
+		refcount_inc(&hm->ref);
+	} else {
+		ret = -EEXIST;
+	}
+	spin_unlock(&xfs_healthmon_lock);
+
+	return ret;
+}
+
+/* Detach a xfs mount from a specific healthmon instance. */
+STATIC void
+xfs_healthmon_detach(
+	struct xfs_healthmon	*hm)
+{
+	spin_lock(&xfs_healthmon_lock);
+	if (xfs_healthmon_activated(hm)) {
+		struct xfs_mount	*mp =
+			XFS_M((struct super_block *)hm->mount_cookie);
+
+		mp->m_healthmon = NULL;
+		hm->mount_cookie = DETACHED_MOUNT_COOKIE;
+	} else {
+		hm = NULL;
+	}
+	spin_unlock(&xfs_healthmon_lock);
+
+	if (hm)
+		xfs_healthmon_put(hm);
+}
+
+/* Detach the xfs mount from this healthmon instance. */
+void
+xfs_healthmon_unmount(
+	struct xfs_mount		*mp)
+{
+	struct xfs_healthmon		*hm = xfs_healthmon_get(mp);
+
+	if (!hm)
+		return;
+
+	xfs_healthmon_detach(hm);
+	xfs_healthmon_put(hm);
+}
+
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
+	/*
+	 * We might be closing the healthmon file before the filesystem
+	 * unmounts, because userspace processes can terminate at any time and
+	 * for any reason.  Null out xfs_mount::m_healthmon so that another
+	 * process can create another health monitor file.
+	 */
+	xfs_healthmon_detach(hm);
+
+	xfs_healthmon_put(hm);
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
+static void
+xfs_healthmon_show_fdinfo(
+	struct seq_file		*m,
+	struct file		*file)
+{
+	struct xfs_healthmon	*hm = file->private_data;
+
+	seq_printf(m, "state:\t%s\ndev:\t%d:%d\n",
+			xfs_healthmon_activated(hm) ? "alive" : "dead",
+			MAJOR(hm->dev), MINOR(hm->dev));
+}
+
+static const struct file_operations xfs_healthmon_fops = {
+	.owner		= THIS_MODULE,
+	.show_fdinfo	= xfs_healthmon_show_fdinfo,
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
+	struct file			*file,
+	struct xfs_health_monitor __user *arg)
+{
+	struct xfs_health_monitor	hmo;
+	struct xfs_healthmon		*hm;
+	struct xfs_inode		*ip = XFS_I(file_inode(file));
+	struct xfs_mount		*mp = ip->i_mount;
+	int				ret;
+
+	/*
+	 * The only intended user of the health monitoring system should be the
+	 * xfs_healer daemon running on behalf of the whole filesystem in the
+	 * initial user namespace.  IOWs, we don't allow unprivileged userspace
+	 * (they can use fsnotify) nor do we allow containers.
+	 */
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	if (ip->i_ino != mp->m_sb.sb_rootino)
+		return -EPERM;
+	if (current_user_ns() != &init_user_ns)
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
+	hm->dev = mp->m_super->s_dev;
+	refcount_set(&hm->ref, 1);
+
+	/*
+	 * Try to attach this health monitor to the xfs_mount.  The monitor is
+	 * considered live and will receive events if this succeeds.
+	 */
+	ret = xfs_healthmon_attach(mp, hm);
+	if (ret)
+		goto out_hm;
+
+	/*
+	 * Create the anonymous file and install a fd for it.  If it succeeds,
+	 * the file owns hm and can go away at any time, so we must not access
+	 * it again.  This must go last because we can't undo a fd table
+	 * installation.
+	 */
+	ret = anon_inode_getfd("xfs_healthmon", &xfs_healthmon_fops, hm,
+			O_CLOEXEC | O_RDONLY);
+	if (ret < 0)
+		goto out_mp;
+
+	return ret;
+
+out_mp:
+	xfs_healthmon_detach(hm);
+out_hm:
+	ASSERT(refcount_read(&hm->ref) == 1);
+	xfs_healthmon_put(hm);
+	return ret;
+}
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 59eaad77437181..c04c41ca924e37 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -41,6 +41,7 @@
 #include "xfs_exchrange.h"
 #include "xfs_handle.h"
 #include "xfs_rtgroup.h"
+#include "xfs_healthmon.h"
 
 #include <linux/mount.h>
 #include <linux/fileattr.h>
@@ -1419,6 +1420,9 @@ xfs_file_ioctl(
 	case XFS_IOC_COMMIT_RANGE:
 		return xfs_ioc_commit_range(filp, arg);
 
+	case XFS_IOC_HEALTH_MONITOR:
+		return xfs_ioc_health_monitor(filp, arg);
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 0953f6ae94abc8..ab67c91915384c 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -41,6 +41,7 @@
 #include "xfs_rtrefcount_btree.h"
 #include "scrub/stats.h"
 #include "xfs_zone_alloc.h"
+#include "xfs_healthmon.h"
 
 static DEFINE_MUTEX(xfs_uuid_table_mutex);
 static int xfs_uuid_table_size;
@@ -625,6 +626,7 @@ xfs_unmount_flush_inodes(
 	cancel_delayed_work_sync(&mp->m_reclaim_work);
 	xfs_reclaim_inodes(mp);
 	xfs_health_unmount(mp);
+	xfs_healthmon_unmount(mp);
 }
 
 static void


