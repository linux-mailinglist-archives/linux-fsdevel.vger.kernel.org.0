Return-Path: <linux-fsdevel+bounces-74049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2C9D2C15A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 06:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AAFA3027E13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 05:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC62C347BC1;
	Fri, 16 Jan 2026 05:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUDM7sWH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694CD33F8A4;
	Fri, 16 Jan 2026 05:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768542153; cv=none; b=IaryLnKTfdHP0S+MWp+HVcYa5HZEwIGCg9S76dF6G1Q9fUajz/qe5HuSHiNW87ptGgGPMEpsORvjUM/MHFP7efdC+1L521q3ic02r1eCmaLBk9qZayPJZrzp0YyC26dJAJMaEgYdnDrEVmGRP67OP6AaTQcAnntr7FIBWpYvas4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768542153; c=relaxed/simple;
	bh=IqDl1ACTKdJ/L5m8YeBpuIWSEUP7e5ura0U89aQpNko=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDMr640zPrh+VPuYTAuQN95ZOr3wVavupkothDEtTFJqrs6aBp05/CO8uNUya3mLEIQSeqoVhPL17Mbr3cA9vN3jfzMt4N4QAZ6aC3u6tdM0fvoUodwaPCgKDKTqVBT3tt2tlJf9dbi46XT+Mz6n+IFezUtKciQXEd7BlvWe1iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUDM7sWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7EBC116C6;
	Fri, 16 Jan 2026 05:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768542153;
	bh=IqDl1ACTKdJ/L5m8YeBpuIWSEUP7e5ura0U89aQpNko=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=eUDM7sWH/DLxCCCnmzWQGYaRoatR+2jRYnA2VM8pbEQAZU9NFlw/6jwglspSp/UpW
	 8UI1LKt0lodwTG1Zuq3p7ELghcDgkZrHIXqCyaAVgsJFC8gbVMmJbKU+xl/naf4Tgu
	 boC6L3HXoLV7VjqcxeCa4mnQzaSTJ5Vzvkl/EsSFwiyifovbbBvDDUKGiEu+WJ+CsS
	 8d0K9sOcY4plKFCReiHwvfV4wPHgMa4zZfPaOicrk9rIJHaNl4xj5MnoufEAFL/8hW
	 DmYVqM3lubXxjyyMyW5+PgnUQAcq4jqNuyBT7oRBusUNVDUq7QAwncXBq9VIRgN5Ih
	 sST1mTFzqfJDQ==
Date: Thu, 15 Jan 2026 21:42:32 -0800
Subject: [PATCH 02/11] xfs: start creating infrastructure for health
 monitoring
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: hch@lst.de, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 hch@lst.de
Message-ID: <176852588582.2137143.1283636639551788931.stgit@frogsfrogsfrogs>
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

Start creating helper functions and infrastructure to pass filesystem
health events to a health monitoring file.  Since this is an
administrative interface, we only support a single health monitor
process per filesystem, so we don't need to use anything fancy such as
notifier chains (== tons of indirect calls).

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/libxfs/xfs_fs.h |    7 +
 fs/xfs/xfs_healthmon.h |   36 +++++++
 fs/xfs/xfs_mount.h     |    4 +
 fs/xfs/Makefile        |    1 
 fs/xfs/xfs_health.c    |    1 
 fs/xfs/xfs_healthmon.c |  262 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_ioctl.c     |    4 +
 fs/xfs/xfs_mount.c     |    2 
 8 files changed, 317 insertions(+)
 create mode 100644 fs/xfs/xfs_healthmon.h
 create mode 100644 fs/xfs/xfs_healthmon.c


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 12463ba766da05..c58e55b3df4099 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -1003,6 +1003,12 @@ struct xfs_rtgroup_geometry {
 #define XFS_RTGROUP_GEOM_SICK_RMAPBT	(1U << 3)  /* reverse mappings */
 #define XFS_RTGROUP_GEOM_SICK_REFCNTBT	(1U << 4)  /* reference counts */
 
+struct xfs_health_monitor {
+	__u64	flags;		/* flags */
+	__u8	format;		/* output format */
+	__u8	pad[23];	/* zeroes */
+};
+
 /*
  * ioctl commands that are used by Linux filesystems
  */
@@ -1042,6 +1048,7 @@ struct xfs_rtgroup_geometry {
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
index 00000000000000..b7095ea55897c5
--- /dev/null
+++ b/fs/xfs/xfs_healthmon.c
@@ -0,0 +1,262 @@
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
+ * be parsed easily by userspace.  When those internal events occur, the core
+ * filesystem code calls this health monitor to convey the events to userspace.
+ * Userspace reads events from the file descriptor returned by the ioctl.
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
+ * Release the reference to a healthmon object.  If there are no more holders,
+ * free the health monitor after an RCU grace period to eliminate possibility
+ * of races with xfs_healthmon_get.
+ */
+static void
+xfs_healthmon_put(
+	struct xfs_healthmon		*hm)
+{
+	if (refcount_dec_and_test(&hm->ref))
+		kfree_rcu_mightsleep(hm);
+}
+
+/* Attach a health monitor to an xfs_mount.  Only one allowed at a time. */
+STATIC int
+xfs_healthmon_attach(
+	struct xfs_mount	*mp,
+	struct xfs_healthmon	*hm)
+{
+	spin_lock(&xfs_healthmon_lock);
+	if (mp->m_healthmon != NULL) {
+		spin_unlock(&xfs_healthmon_lock);
+		return -EEXIST;
+	}
+
+	refcount_inc(&hm->ref);
+	mp->m_healthmon = hm;
+	hm->mount_cookie = (uintptr_t)mp->m_super;
+	spin_unlock(&xfs_healthmon_lock);
+
+	return 0;
+}
+
+/* Detach a xfs mount from a specific healthmon instance. */
+STATIC void
+xfs_healthmon_detach(
+	struct xfs_healthmon	*hm)
+{
+	spin_lock(&xfs_healthmon_lock);
+	if (hm->mount_cookie == DETACHED_MOUNT_COOKIE) {
+		spin_unlock(&xfs_healthmon_lock);
+		return;
+	}
+
+	XFS_M((struct super_block *)hm->mount_cookie)->m_healthmon = NULL;
+	hm->mount_cookie = DETACHED_MOUNT_COOKIE;
+	spin_unlock(&xfs_healthmon_lock);
+
+	xfs_healthmon_put(hm);
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
+	if (memchr_inv(&hmo->pad, 0, sizeof(hmo->pad)))
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
+			hm->mount_cookie == DETACHED_MOUNT_COOKIE ?
+				"dead" : "alive",
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


