Return-Path: <linux-fsdevel+bounces-65264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C425BFEACF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 02:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508EB1A06472
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 00:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D9A2B2DA;
	Thu, 23 Oct 2025 00:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CR6qC47g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BDD29A2;
	Thu, 23 Oct 2025 00:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177918; cv=none; b=bNvdMl0stuwq3bplbbDBxzF+TSsrW2kTltqQu3usJqigZw9oHY6MGpT19QIKv85Kk8KYt5FKHhjte3uZQgi03uTCtGcl5PYWvflM0+t6TehjthmukNEEjResNDC4yCoc0LrIRroukaoKtd59S42Qvo50Xpf451p//8EM9SBUt84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177918; c=relaxed/simple;
	bh=Y8vg07J4nrw2zPs3cjedipEQTrGxrTbE1dSngX+1GLo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7B6fQE1wI0PiXZIzfXGyXhISV0ZECyqfu7G+PgDZrtFIv0hEDGUnnkN7z9Z7j3K0iHYOxEq37sltOWYPw2vQe9PYOU1rnLx+fiFATN2z6MqyTMzXHem92hR7g/udZEydfQn/fmkszEMPVevMrcTvxzrC+1aPuNlRvz5Sgi9rpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CR6qC47g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4910C4CEE7;
	Thu, 23 Oct 2025 00:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761177918;
	bh=Y8vg07J4nrw2zPs3cjedipEQTrGxrTbE1dSngX+1GLo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=CR6qC47gr93AbSSDqTptuzxlAjTe8o9M8iYEjdkqJ71HeP4CyyUC/1HBi5mMfpmh5
	 Mx4ItFqY1Zt5YPprbCse2TqG3Savu4X1iJfwCIdxZJetPHUxrTInPkDeyLQzMblK4E
	 wRepdqZGZFj9nTdi56fl05RSTAjZQOB6QJhfw5IvjgXTF+9SUYeVHa2As1Gd3xGDNo
	 mkvgSHVeClCc21Rgu8F/bxK5AWEkT9Km+g/Q3CHzqXYfIhm4KWUkj+geWYh+Nnrlpi
	 j4IgMEAbqsKeuK7nIY0FDigzKj6X9apuslPADi9Gi2+tUNCsGW8x3tGwok34YA0Y2z
	 n9Nh1NryEdJOQ==
Date: Wed, 22 Oct 2025 17:05:18 -0700
Subject: [PATCH 18/19] xfs: add media error reporting ioctl
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176117744893.1025409.8095049073326826612.stgit@frogsfrogsfrogs>
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

Add a new privileged ioctl so that xfs_scrub can report media errors to
the kernel for further processing.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h      |   16 +++++++++++++
 fs/xfs/xfs_notify_failure.h |    8 ++++++
 fs/xfs/xfs_trace.h          |    2 --
 fs/xfs/Makefile             |    6 +----
 fs/xfs/xfs_healthmon.c      |    2 --
 fs/xfs/xfs_ioctl.c          |    3 ++
 fs/xfs/xfs_notify_failure.c |   53 ++++++++++++++++++++++++++++++++++++++++++-
 7 files changed, 79 insertions(+), 11 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index b5a00ef6ce5fb9..5d35d67b10e153 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -1158,6 +1158,21 @@ struct xfs_health_samefs {
 	__u32		flags;	/* zero for now */
 };
 
+/* Report a media error */
+struct xfs_media_error {
+	__u64	flags;		/* flags */
+	__u64	daddr;		/* disk address of range */
+	__u64	bbcount;	/* length, in 512b blocks */
+	__u64	pad;		/* zero */
+};
+
+#define XFS_MEDIA_ERROR_DATADEV	(1)	/* data device */
+#define XFS_MEDIA_ERROR_LOGDEV	(2)	/* external log device */
+#define XFS_MEDIA_ERROR_RTDEV	(3)	/* realtime device */
+
+/* bottom byte of flags is the device code */
+#define XFS_MEDIA_ERROR_DEVMASK	(0xFF)
+
 /*
  * ioctl commands that are used by Linux filesystems
  */
@@ -1199,6 +1214,7 @@ struct xfs_health_samefs {
 #define XFS_IOC_RTGROUP_GEOMETRY _IOWR('X', 65, struct xfs_rtgroup_geometry)
 #define XFS_IOC_HEALTH_MONITOR	_IOW ('X', 68, struct xfs_health_monitor)
 #define XFS_IOC_HEALTH_SAMEFS	_IOW ('X', 69, struct xfs_health_samefs)
+#define XFS_IOC_MEDIA_ERROR	_IOW ('X', 70, struct xfs_media_error)
 
 /*
  * ioctl commands that replace IRIX syssgi()'s
diff --git a/fs/xfs/xfs_notify_failure.h b/fs/xfs/xfs_notify_failure.h
index 528317ff24320a..e9ee74aa540bff 100644
--- a/fs/xfs/xfs_notify_failure.h
+++ b/fs/xfs/xfs_notify_failure.h
@@ -6,7 +6,9 @@
 #ifndef __XFS_NOTIFY_FAILURE_H__
 #define __XFS_NOTIFY_FAILURE_H__
 
+#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_FS_DAX)
 extern const struct dax_holder_operations xfs_dax_holder_operations;
+#endif
 
 enum xfs_failed_device {
 	XFS_FAILED_DATADEV,
@@ -14,7 +16,7 @@ enum xfs_failed_device {
 	XFS_FAILED_RTDEV,
 };
 
-#if defined(CONFIG_XFS_LIVE_HOOKS) && defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_FS_DAX)
+#if defined(CONFIG_XFS_LIVE_HOOKS)
 struct xfs_media_error_params {
 	struct xfs_mount		*mp;
 	enum xfs_failed_device		fdev;
@@ -46,4 +48,8 @@ struct xfs_media_error_hook { };
 # define xfs_media_error_hook_setup(...)	((void)0)
 #endif /* CONFIG_XFS_LIVE_HOOKS */
 
+struct xfs_media_error;
+int xfs_ioc_media_error(struct xfs_mount *mp,
+		struct xfs_media_error __user *arg);
+
 #endif /* __XFS_NOTIFY_FAILURE_H__ */
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index b23f3c41db1c03..10b1ef735a7c9c 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -6214,7 +6214,6 @@ TRACE_EVENT(xfs_healthmon_metadata_hook,
 		  __entry->lost_prev)
 );
 
-#if defined(CONFIG_XFS_LIVE_HOOKS) && defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_FS_DAX)
 TRACE_EVENT(xfs_healthmon_media_error_hook,
 	TP_PROTO(const struct xfs_media_error_params *p,
 		 unsigned int events, unsigned long long lost_prev),
@@ -6262,7 +6261,6 @@ TRACE_EVENT(xfs_healthmon_media_error_hook,
 		  __entry->events,
 		  __entry->lost_prev)
 );
-#endif
 
 #define XFS_FILE_IOERROR_STRINGS \
 	{ XFS_FILE_IOERROR_BUFFERED_READ,	"readahead" }, \
diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index d4e9070a9326ba..2279cb0b874814 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -98,6 +98,7 @@ xfs-y				+= xfs_aops.o \
 				   xfs_message.o \
 				   xfs_mount.o \
 				   xfs_mru_cache.o \
+				   xfs_notify_failure.o \
 				   xfs_pwork.o \
 				   xfs_reflink.o \
 				   xfs_stats.o \
@@ -148,11 +149,6 @@ xfs-$(CONFIG_SYSCTL)		+= xfs_sysctl.o
 xfs-$(CONFIG_COMPAT)		+= xfs_ioctl32.o
 xfs-$(CONFIG_EXPORTFS_BLOCK_OPS)	+= xfs_pnfs.o
 
-# notify failure
-ifeq ($(CONFIG_MEMORY_FAILURE),y)
-xfs-$(CONFIG_FS_DAX)		+= xfs_notify_failure.o
-endif
-
 xfs-$(CONFIG_XFS_DRAIN_INTENTS)	+= xfs_drain.o
 xfs-$(CONFIG_XFS_LIVE_HOOKS)	+= xfs_hooks.o
 xfs-$(CONFIG_XFS_MEMORY_BUFS)	+= xfs_buf_mem.o
diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index 666c27d73efbdc..3053b2da6b3109 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -527,7 +527,6 @@ xfs_healthmon_shutdown_hook(
 	return NOTIFY_DONE;
 }
 
-#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_FS_DAX)
 /* Add a media error event to the reporting queue. */
 STATIC int
 xfs_healthmon_media_error_hook(
@@ -578,7 +577,6 @@ xfs_healthmon_media_error_hook(
 	mutex_unlock(&hm->lock);
 	return NOTIFY_DONE;
 }
-#endif
 
 /* Add a file io error event to the reporting queue. */
 STATIC int
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 08998d84554f09..7a80a6ad4b2d99 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -42,6 +42,7 @@
 #include "xfs_handle.h"
 #include "xfs_rtgroup.h"
 #include "xfs_healthmon.h"
+#include "xfs_notify_failure.h"
 
 #include <linux/mount.h>
 #include <linux/fileattr.h>
@@ -1424,6 +1425,8 @@ xfs_file_ioctl(
 
 	case XFS_IOC_HEALTH_MONITOR:
 		return xfs_ioc_health_monitor(mp, arg);
+	case XFS_IOC_MEDIA_ERROR:
+		return xfs_ioc_media_error(mp, arg);
 
 	default:
 		return -ENOTTY;
diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index 2098ff452a3b87..00120dd1ddefbd 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -91,9 +91,19 @@ xfs_media_error_hook_setup(
 	xfs_hook_setup(&hook->error_hook, mod_fn);
 }
 #else
-# define xfs_media_error_hook(...)		((void)0)
+static inline void
+xfs_media_error_hook(
+	struct xfs_mount		*mp,
+	enum xfs_failed_device		fdev,
+	xfs_daddr_t			daddr,
+	uint64_t			bbcount,
+	bool				pre_remove)
+{
+	/* empty */
+}
 #endif /* CONFIG_XFS_LIVE_HOOKS */
 
+#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_FS_DAX)
 struct xfs_failure_info {
 	xfs_agblock_t		startblock;
 	xfs_extlen_t		blockcount;
@@ -458,3 +468,44 @@ xfs_dax_notify_failure(
 const struct dax_holder_operations xfs_dax_holder_operations = {
 	.notify_failure		= xfs_dax_notify_failure,
 };
+#endif /* CONFIG_MEMORY_FAILURE && CONFIG_FS_DAX */
+
+#define XFS_VALID_MEDIA_ERROR_FLAGS	(XFS_MEDIA_ERROR_DATADEV | \
+					 XFS_MEDIA_ERROR_LOGDEV | \
+					 XFS_MEDIA_ERROR_RTDEV)
+int
+xfs_ioc_media_error(
+	struct xfs_mount		*mp,
+	struct xfs_media_error __user	*arg)
+{
+	struct xfs_media_error		me;
+	enum xfs_failed_device		fdev;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (copy_from_user(&me, arg, sizeof(me)))
+		return -EFAULT;
+
+	if (me.pad)
+		return -EINVAL;
+	if (me.flags & ~XFS_VALID_MEDIA_ERROR_FLAGS)
+		return -EINVAL;
+
+	switch (me.flags & XFS_MEDIA_ERROR_DEVMASK) {
+	case XFS_MEDIA_ERROR_DATADEV:
+		fdev = XFS_FAILED_DATADEV;
+		break;
+	case XFS_MEDIA_ERROR_LOGDEV:
+		fdev = XFS_FAILED_LOGDEV;
+		break;
+	case XFS_MEDIA_ERROR_RTDEV:
+		fdev = XFS_FAILED_RTDEV;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	xfs_media_error_hook(mp, fdev, me.daddr, me.bbcount, false);
+	return 0;
+}


