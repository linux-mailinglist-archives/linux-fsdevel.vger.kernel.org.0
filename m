Return-Path: <linux-fsdevel+bounces-65258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7DCBFEA84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 02:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1D684ED78B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 00:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316E0EEAB;
	Thu, 23 Oct 2025 00:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCZo2dpX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EE679F2;
	Thu, 23 Oct 2025 00:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177825; cv=none; b=ZTniNKVlWORg+yC5hQSnWNo3P8CzOZ/tJ2VUoqOb49zkZ5YeaWvmRQ9squDHBw2Yo7MuQJmurgQFDzCQtNi9DaJGzw34MnjUpPUUnxFU2U43jbMtIC0t/cvjpahsYF0+Lc8942ecKOcIcf7hYPqEe30eCem+T7/0b8qxZFRMc74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177825; c=relaxed/simple;
	bh=ZdthoFySXKVyo6b0u631AkFTWNRamUeJajkhLN/IrOk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wjh5I4EARircinVLgAKDtsfkqQ9hmAsNUnO3ckPppCnPf4gvnqiEeKDEo+PPyBhIZFl0EtU82Vc/DY+C6oJhxSU7wqy9+/K70xMXGBenyqYaRXtMlYpuSIfaF7tmNS86LSDx5ss52uMbEDGX0PpnejPex7p39v0tSqwefwUNkMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCZo2dpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE3FC4CEE7;
	Thu, 23 Oct 2025 00:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761177824;
	bh=ZdthoFySXKVyo6b0u631AkFTWNRamUeJajkhLN/IrOk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hCZo2dpX8SFMfmFPH6kBewxmMP6ZNT686ZFmQZm7dYVhqPHHjGV03PHvtd8zoZJnq
	 s0Y4aJqROulPiMM74zfoEwjlopTpHBxwfS+YXF4Db10U7zmZsK+W1s1iHIeSAenCKZ
	 YYIBYyQZv7PUq37Au4p6fhjs8PmR6iQSbqKaje702i8EUx5phFPT2EZLXocYP2/DCw
	 orxgAHPf5aUTfoxgtdeOKhvvbKFe8t1rCEFfTfLVluGUnJ8REjHUxzJi79N7ExflEY
	 0eDAwN6Kx9cSiT5Ku9iabJbhKjnsF8jPo0AC39NXhyzXGXmCvSDg3lhLHQ4pTi8Mqq
	 O/qgpkT5gOtuQ==
Date: Wed, 22 Oct 2025 17:03:44 -0700
Subject: [PATCH 12/19] xfs: report metadata health events through healthmon
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176117744760.1025409.3346791770590986228.stgit@frogsfrogsfrogs>
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

Set up a metadata health event hook so that we can send events to
userspace as we collect information.  The unmount hook severs the weak
reference between the health monitor and the filesystem it's monitoring;
when this happens, we stop reporting events because there's no longer
any point.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h                  |   38 +++
 fs/xfs/libxfs/xfs_health.h              |    5 
 fs/xfs/xfs_healthmon.h                  |   31 ++
 fs/xfs/xfs_trace.h                      |   98 ++++++-
 fs/xfs/libxfs/xfs_healthmon.schema.json |  315 +++++++++++++++++++++
 fs/xfs/xfs_health.c                     |   67 ++++
 fs/xfs/xfs_healthmon.c                  |  465 +++++++++++++++++++++++++++++++
 7 files changed, 1010 insertions(+), 9 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 4b642eea18b5ca..358abe98776d69 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -1008,17 +1008,52 @@ struct xfs_rtgroup_geometry {
 /* affects the whole fs */
 #define XFS_HEALTH_MONITOR_DOMAIN_MOUNT		(0)
 
+/* metadata health events */
+#define XFS_HEALTH_MONITOR_DOMAIN_FS		(1)
+#define XFS_HEALTH_MONITOR_DOMAIN_AG		(2)
+#define XFS_HEALTH_MONITOR_DOMAIN_INODE		(3)
+#define XFS_HEALTH_MONITOR_DOMAIN_RTGROUP	(4)
+
 /* Health monitor event types */
 
 /* status of the monitor itself */
 #define XFS_HEALTH_MONITOR_TYPE_RUNNING		(0)
 #define XFS_HEALTH_MONITOR_TYPE_LOST		(1)
 
+/* metadata health events */
+#define XFS_HEALTH_MONITOR_TYPE_SICK		(2)
+#define XFS_HEALTH_MONITOR_TYPE_CORRUPT		(3)
+#define XFS_HEALTH_MONITOR_TYPE_HEALTHY		(4)
+
+/* filesystem was unmounted */
+#define XFS_HEALTH_MONITOR_TYPE_UNMOUNT		(5)
+
 /* lost events */
 struct xfs_health_monitor_lost {
 	__u64	count;
 };
 
+/* fs/rt metadata */
+struct xfs_health_monitor_fs {
+	/* XFS_FSOP_GEOM_SICK_* flags */
+	__u32	mask;
+};
+
+/* ag/rtgroup metadata */
+struct xfs_health_monitor_group {
+	/* XFS_{AG,RTGROUP}_SICK_* flags */
+	__u32	mask;
+	__u32	gno;
+};
+
+/* inode metadata */
+struct xfs_health_monitor_inode {
+	/* XFS_BS_SICK_* flags */
+	__u32	mask;
+	__u32	gen;
+	__u64	ino;
+};
+
 struct xfs_health_monitor_event {
 	/* XFS_HEALTH_MONITOR_DOMAIN_* */
 	__u32	domain;
@@ -1036,6 +1071,9 @@ struct xfs_health_monitor_event {
 	 */
 	union {
 		struct xfs_health_monitor_lost lost;
+		struct xfs_health_monitor_fs fs;
+		struct xfs_health_monitor_group group;
+		struct xfs_health_monitor_inode inode;
 	} e;
 
 	/* zeroes */
diff --git a/fs/xfs/libxfs/xfs_health.h b/fs/xfs/libxfs/xfs_health.h
index 39fef33dedc6a8..9ff3bf8ba4ed8f 100644
--- a/fs/xfs/libxfs/xfs_health.h
+++ b/fs/xfs/libxfs/xfs_health.h
@@ -336,4 +336,9 @@ void xfs_health_hook_del(struct xfs_mount *mp, struct xfs_health_hook *hook);
 void xfs_health_hook_setup(struct xfs_health_hook *hook, notifier_fn_t mod_fn);
 #endif /* CONFIG_XFS_LIVE_HOOKS */
 
+unsigned int xfs_healthmon_inode_mask(unsigned int sick_mask);
+unsigned int xfs_healthmon_rtgroup_mask(unsigned int sick_mask);
+unsigned int xfs_healthmon_perag_mask(unsigned int sick_mask);
+unsigned int xfs_healthmon_fs_mask(unsigned int sick_mask);
+
 #endif	/* __XFS_HEALTH_H__ */
diff --git a/fs/xfs/xfs_healthmon.h b/fs/xfs/xfs_healthmon.h
index ea2d6a327dfb16..3f3ba16d5af56a 100644
--- a/fs/xfs/xfs_healthmon.h
+++ b/fs/xfs/xfs_healthmon.h
@@ -9,10 +9,23 @@
 enum xfs_healthmon_type {
 	XFS_HEALTHMON_RUNNING,	/* monitor running */
 	XFS_HEALTHMON_LOST,	/* message lost */
+	XFS_HEALTHMON_UNMOUNT,	/* filesystem is unmounting */
+
+	/* metadata health events */
+	XFS_HEALTHMON_SICK,	/* runtime corruption observed */
+	XFS_HEALTHMON_CORRUPT,	/* fsck reported corruption */
+	XFS_HEALTHMON_HEALTHY,	/* fsck reported healthy structure */
+
 };
 
 enum xfs_healthmon_domain {
 	XFS_HEALTHMON_MOUNT,	/* affects the whole fs */
+
+	/* metadata health events */
+	XFS_HEALTHMON_FS,	/* main filesystem metadata */
+	XFS_HEALTHMON_AG,	/* allocation group metadata */
+	XFS_HEALTHMON_INODE,	/* inode metadata */
+	XFS_HEALTHMON_RTGROUP,	/* realtime group metadata */
 };
 
 struct xfs_healthmon_event {
@@ -32,6 +45,24 @@ struct xfs_healthmon_event {
 		struct {
 			unsigned int	flags;
 		};
+		/* fs/rt metadata */
+		struct {
+			/* XFS_SICK_* flags */
+			unsigned int	fsmask;
+		};
+		/* ag/rtgroup metadata */
+		struct {
+			/* XFS_SICK_* flags */
+			unsigned int	grpmask;
+			unsigned int	group;
+		};
+		/* inode metadata */
+		struct {
+			/* XFS_SICK_INO_* flags */
+			unsigned int	imask;
+			uint32_t	gen;
+			xfs_ino_t	ino;
+		};
 	};
 };
 
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 17af5efee026c9..df09c225e13c2e 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -6011,14 +6011,30 @@ DEFINE_HEALTHMON_EVENT(xfs_healthmon_release);
 DEFINE_HEALTHMON_EVENT(xfs_healthmon_unmount);
 
 #define XFS_HEALTHMON_TYPE_STRINGS \
-	{ XFS_HEALTHMON_LOST,		"lost" }
+	{ XFS_HEALTHMON_LOST,		"lost" }, \
+	{ XFS_HEALTHMON_UNMOUNT,	"unmount" }, \
+	{ XFS_HEALTHMON_SICK,		"sick" }, \
+	{ XFS_HEALTHMON_CORRUPT,	"corrupt" }, \
+	{ XFS_HEALTHMON_HEALTHY,	"healthy" }
 
 #define XFS_HEALTHMON_DOMAIN_STRINGS \
-	{ XFS_HEALTHMON_MOUNT,		"mount" }
+	{ XFS_HEALTHMON_MOUNT,		"mount" }, \
+	{ XFS_HEALTHMON_FS,		"fs" }, \
+	{ XFS_HEALTHMON_AG,		"ag" }, \
+	{ XFS_HEALTHMON_INODE,		"inode" }, \
+	{ XFS_HEALTHMON_RTGROUP,	"rtgroup" }
 
 TRACE_DEFINE_ENUM(XFS_HEALTHMON_LOST);
+TRACE_DEFINE_ENUM(XFS_HEALTHMON_UNMOUNT);
+TRACE_DEFINE_ENUM(XFS_HEALTHMON_SICK);
+TRACE_DEFINE_ENUM(XFS_HEALTHMON_CORRUPT);
+TRACE_DEFINE_ENUM(XFS_HEALTHMON_HEALTHY);
 
 TRACE_DEFINE_ENUM(XFS_HEALTHMON_MOUNT);
+TRACE_DEFINE_ENUM(XFS_HEALTHMON_FS);
+TRACE_DEFINE_ENUM(XFS_HEALTHMON_AG);
+TRACE_DEFINE_ENUM(XFS_HEALTHMON_INODE);
+TRACE_DEFINE_ENUM(XFS_HEALTHMON_RTGROUP);
 
 DECLARE_EVENT_CLASS(xfs_healthmon_event_class,
 	TP_PROTO(const struct xfs_mount *mp, const struct xfs_healthmon_event *event),
@@ -6054,6 +6070,19 @@ DECLARE_EVENT_CLASS(xfs_healthmon_event_class,
 				break;
 			}
 			break;
+		case XFS_HEALTHMON_FS:
+			__entry->mask = event->fsmask;
+			break;
+		case XFS_HEALTHMON_AG:
+		case XFS_HEALTHMON_RTGROUP:
+			__entry->mask = event->grpmask;
+			__entry->group = event->group;
+			break;
+		case XFS_HEALTHMON_INODE:
+			__entry->mask = event->imask;
+			__entry->ino = event->ino;
+			__entry->gen = event->gen;
+			break;
 		}
 	),
 	TP_printk("dev %d:%d type %s domain %s mask 0x%x ino 0x%llx gen 0x%x offset 0x%llx len 0x%llx group 0x%x lost %llu",
@@ -6072,11 +6101,76 @@ DECLARE_EVENT_CLASS(xfs_healthmon_event_class,
 DEFINE_EVENT(xfs_healthmon_event_class, name, \
 	TP_PROTO(const struct xfs_mount *mp, const struct xfs_healthmon_event *event), \
 	TP_ARGS(mp, event))
+DEFINE_HEALTHMONEVENT_EVENT(xfs_healthmon_insert);
 DEFINE_HEALTHMONEVENT_EVENT(xfs_healthmon_push);
 DEFINE_HEALTHMONEVENT_EVENT(xfs_healthmon_pop);
 DEFINE_HEALTHMONEVENT_EVENT(xfs_healthmon_format);
 DEFINE_HEALTHMONEVENT_EVENT(xfs_healthmon_format_overflow);
 DEFINE_HEALTHMONEVENT_EVENT(xfs_healthmon_drop);
+
+#define XFS_HEALTHUP_TYPE_STRINGS \
+	{ XFS_HEALTHUP_UNMOUNT,		"unmount" }, \
+	{ XFS_HEALTHUP_SICK,		"sick" }, \
+	{ XFS_HEALTHUP_CORRUPT,		"corrupt" }, \
+	{ XFS_HEALTHUP_HEALTHY,		"healthy" }
+
+#define XFS_HEALTHUP_DOMAIN_STRINGS \
+	{ XFS_HEALTHUP_FS,		"fs" }, \
+	{ XFS_HEALTHUP_AG,		"ag" }, \
+	{ XFS_HEALTHUP_INODE,		"inode" }, \
+	{ XFS_HEALTHUP_RTGROUP,		"rtgroup" }
+
+TRACE_DEFINE_ENUM(XFS_HEALTHUP_UNMOUNT);
+TRACE_DEFINE_ENUM(XFS_HEALTHUP_SICK);
+TRACE_DEFINE_ENUM(XFS_HEALTHUP_CORRUPT);
+TRACE_DEFINE_ENUM(XFS_HEALTHUP_HEALTHY);
+
+TRACE_DEFINE_ENUM(XFS_HEALTHUP_FS);
+TRACE_DEFINE_ENUM(XFS_HEALTHUP_AG);
+TRACE_DEFINE_ENUM(XFS_HEALTHUP_INODE);
+TRACE_DEFINE_ENUM(XFS_HEALTHUP_RTGROUP);
+
+TRACE_EVENT(xfs_healthmon_metadata_hook,
+	TP_PROTO(const struct xfs_mount *mp, unsigned long type,
+		 const struct xfs_health_update_params *update,
+		 unsigned int events, unsigned long long lost_prev),
+	TP_ARGS(mp, type, update, events, lost_prev),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned long, type)
+		__field(unsigned int, domain)
+		__field(unsigned int, old_mask)
+		__field(unsigned int, new_mask)
+		__field(unsigned long long, ino)
+		__field(unsigned int, gen)
+		__field(unsigned int, group)
+		__field(unsigned int, events)
+		__field(unsigned long long, lost_prev)
+	),
+	TP_fast_assign(
+		__entry->dev = mp ? mp->m_super->s_dev : 0;
+		__entry->type = type;
+		__entry->domain = update->domain;
+		__entry->old_mask = update->old_mask;
+		__entry->new_mask = update->new_mask;
+		__entry->ino = update->ino;
+		__entry->gen = update->gen;
+		__entry->group = update->group;
+		__entry->events = events;
+		__entry->lost_prev = lost_prev;
+	),
+	TP_printk("dev %d:%d type %s domain %s oldmask 0x%x newmask 0x%x ino 0x%llx gen 0x%x group 0x%x events %u lost_prev %llu",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __print_symbolic(__entry->type, XFS_HEALTHUP_TYPE_STRINGS),
+		  __print_symbolic(__entry->domain, XFS_HEALTHUP_DOMAIN_STRINGS),
+		  __entry->old_mask,
+		  __entry->new_mask,
+		  __entry->ino,
+		  __entry->gen,
+		  __entry->group,
+		  __entry->events,
+		  __entry->lost_prev)
+);
 #endif /* CONFIG_XFS_HEALTH_MONITOR */
 
 #endif /* _TRACE_XFS_H */
diff --git a/fs/xfs/libxfs/xfs_healthmon.schema.json b/fs/xfs/libxfs/xfs_healthmon.schema.json
index 68762738b04191..dd78f1b71d587b 100644
--- a/fs/xfs/libxfs/xfs_healthmon.schema.json
+++ b/fs/xfs/libxfs/xfs_healthmon.schema.json
@@ -24,6 +24,18 @@
 		},
 		{
 			"$ref": "#/$events/lost"
+		},
+		{
+			"$ref": "#/$events/fs_metadata"
+		},
+		{
+			"$ref": "#/$events/rtgroup_metadata"
+		},
+		{
+			"$ref": "#/$events/perag_metadata"
+		},
+		{
+			"$ref": "#/$events/inode_metadata"
 		}
 	],
 
@@ -39,6 +51,156 @@
 			"description": "Number of events.",
 			"type": "integer",
 			"minimum": 1
+		},
+		"xfs_agnumber_t": {
+			"description": "Allocation group number",
+			"type": "integer",
+			"minimum": 0,
+			"maximum": 2147483647
+		},
+		"xfs_rgnumber_t": {
+			"description": "Realtime allocation group number",
+			"type": "integer",
+			"minimum": 0,
+			"maximum": 2147483647
+		},
+		"xfs_ino_t": {
+			"description": "Inode number",
+			"type": "integer",
+			"minimum": 1
+		},
+		"i_generation": {
+			"description": "Inode generation number",
+			"type": "integer"
+		}
+	},
+
+	"$comment": "Filesystem metadata event data are defined here.",
+	"$metadata": {
+		"status": {
+			"description": "Metadata health status",
+			"$comment": [
+				"One of:",
+				"",
+				" * sick:    metadata corruption discovered",
+				"            during a runtime operation.",
+				" * corrupt: corruption discovered during",
+				"            an xfs_scrub run.",
+				" * healthy: metadata object was found to be",
+				"            ok by xfs_scrub."
+			],
+			"enum": [
+				"sick",
+				"corrupt",
+				"healthy"
+			]
+		},
+		"fs": {
+			"description": [
+				"Metadata structures that affect the entire",
+				"filesystem.  Options include:",
+				"",
+				" * fscounters: summary counters",
+				" * usrquota:   user quota records",
+				" * grpquota:   group quota records",
+				" * prjquota:   project quota records",
+				" * quotacheck: quota counters",
+				" * nlinks:     file link counts",
+				" * metadir:    metadata directory",
+				" * metapath:   metadata inode paths"
+			],
+			"enum": [
+				"fscounters",
+				"grpquota",
+				"metadir",
+				"metapath",
+				"nlinks",
+				"prjquota",
+				"quotacheck",
+				"usrquota"
+			]
+		},
+		"perag": {
+			"description": [
+				"Metadata structures owned by allocation",
+				"groups on the data device.  Options include:",
+				"",
+				" * agf:        group space header",
+				" * agfl:       per-group free block list",
+				" * agi:        group inode header",
+				" * bnobt:      free space by position btree",
+				" * cntbt:      free space by length btree",
+				" * finobt:     free inode btree",
+				" * inobt:      inode btree",
+				" * rmapbt:     reverse mapping btree",
+				" * refcountbt: reference count btree",
+				" * inodes:     problems were recorded for",
+				"               this group's inodes, but the",
+				"               inodes themselves had to be",
+				"               reclaimed.",
+				" * super:      superblock"
+			],
+			"enum": [
+				"agf",
+				"agfl",
+				"agi",
+				"bnobt",
+				"cntbt",
+				"finobt",
+				"inobt",
+				"inodes",
+				"refcountbt",
+				"rmapbt",
+				"super"
+			]
+		},
+		"rtgroup": {
+			"description": [
+				"Metadata structures owned by allocation",
+				"groups on the realtime volume.  Options",
+				"include:",
+				"",
+				" * bitmap:     free space bitmap contents",
+				"               for this group",
+				" * summary:    realtime free space summary file",
+				" * rmapbt:     reverse mapping btree",
+				" * refcountbt: reference count btree",
+				" * super:      group superblock"
+			],
+			"enum": [
+				"bitmap",
+				"summary",
+				"refcountbt",
+				"rmapbt",
+				"super"
+			]
+		},
+		"inode": {
+			"description": [
+				"Metadata structures owned by file inodes.",
+				"Options include:",
+				"",
+				" * bmapbta:    attr fork",
+				" * bmapbtc:    cow fork",
+				" * bmapbtd:    data fork",
+				" * core:       inode record",
+				" * directory:  directory entries",
+				" * dirtree:    directory tree problems detected",
+				" * parent:     directory parent pointer",
+				" * symlink:    symbolic link target",
+				" * xattr:      extended attributes"
+			],
+			"enum": [
+				"bmapbta",
+				"bmapbtc",
+				"bmapbtd",
+				"core",
+				"directory",
+				"dirtree",
+				"parent",
+				"symlink",
+				"xattr"
+			]
 		}
 	},
 
@@ -124,6 +286,159 @@
 				"time_ns",
 				"domain"
 			]
+		},
+		"fs_metadata": {
+			"title": "Filesystem-wide metadata event",
+			"description": [
+				"Health status updates for filesystem-wide",
+				"metadata objects."
+			],
+			"type": "object",
+
+			"properties": {
+				"type": {
+					"$ref": "#/$metadata/status"
+				},
+				"time_ns": {
+					"$ref": "#/$defs/time_ns"
+				},
+				"domain": {
+					"const": "fs"
+				},
+				"structures": {
+					"type": "array",
+					"items": {
+						"$ref": "#/$metadata/fs"
+					},
+					"minItems": 1
+				}
+			},
+
+			"required": [
+				"type",
+				"time_ns",
+				"domain",
+				"structures"
+			]
+		},
+		"perag_metadata": {
+			"title": "Data device allocation group metadata event",
+			"description": [
+				"Health status updates for data device ",
+				"allocation group metadata."
+			],
+			"type": "object",
+
+			"properties": {
+				"type": {
+					"$ref": "#/$metadata/status"
+				},
+				"time_ns": {
+					"$ref": "#/$defs/time_ns"
+				},
+				"domain": {
+					"const": "perag"
+				},
+				"group": {
+					"$ref": "#/$defs/xfs_agnumber_t"
+				},
+				"structures": {
+					"type": "array",
+					"items": {
+						"$ref": "#/$metadata/perag"
+					},
+					"minItems": 1
+				}
+			},
+
+			"required": [
+				"type",
+				"time_ns",
+				"domain",
+				"group",
+				"structures"
+			]
+		},
+		"rtgroup_metadata": {
+			"title": "Realtime allocation group metadata event",
+			"description": [
+				"Health status updates for realtime allocation",
+				"group metadata."
+			],
+			"type": "object",
+
+			"properties": {
+				"type": {
+					"$ref": "#/$metadata/status"
+				},
+				"time_ns": {
+					"$ref": "#/$defs/time_ns"
+				},
+				"domain": {
+					"const": "rtgroup"
+				},
+				"group": {
+					"$ref": "#/$defs/xfs_rgnumber_t"
+				},
+				"structures": {
+					"type": "array",
+					"items": {
+						"$ref": "#/$metadata/rtgroup"
+					},
+					"minItems": 1
+				}
+			},
+
+			"required": [
+				"type",
+				"time_ns",
+				"domain",
+				"group",
+				"structures"
+			]
+		},
+		"inode_metadata": {
+			"title": "Inode metadata event",
+			"description": [
+				"Health status updates for inode metadata.",
+				"The inode and generation number describe the",
+				"file that is affected by the change."
+			],
+			"type": "object",
+
+			"properties": {
+				"type": {
+					"$ref": "#/$metadata/status"
+				},
+				"time_ns": {
+					"$ref": "#/$defs/time_ns"
+				},
+				"domain": {
+					"const": "inode"
+				},
+				"inumber": {
+					"$ref": "#/$defs/xfs_ino_t"
+				},
+				"generation": {
+					"$ref": "#/$defs/i_generation"
+				},
+				"structures": {
+					"type": "array",
+					"items": {
+						"$ref": "#/$metadata/inode"
+					},
+					"minItems": 1
+				}
+			},
+
+			"required": [
+				"type",
+				"time_ns",
+				"domain",
+				"inumber",
+				"generation",
+				"structures"
+			]
 		}
 	}
 }
diff --git a/fs/xfs/xfs_health.c b/fs/xfs/xfs_health.c
index abf9460ae79953..70e1b098c8b449 100644
--- a/fs/xfs/xfs_health.c
+++ b/fs/xfs/xfs_health.c
@@ -607,6 +607,25 @@ xfs_fsop_geom_health(
 	}
 }
 
+/*
+ * Translate XFS_SICK_FS_* into XFS_FSOP_GEOM_SICK_* except for the rt free
+ * space codes, which are sent via the rtgroup events.
+ */
+unsigned int
+xfs_healthmon_fs_mask(
+	unsigned int			sick_mask)
+{
+	const struct ioctl_sick_map	*m;
+	unsigned int			ioctl_mask = 0;
+
+	for_each_sick_map(fs_map, m) {
+		if (sick_mask & m->sick_mask)
+			ioctl_mask |= m->ioctl_mask;
+	}
+
+	return ioctl_mask;
+}
+
 static const struct ioctl_sick_map ag_map[] = {
 	{ XFS_SICK_AG_SB,	XFS_AG_GEOM_SICK_SB },
 	{ XFS_SICK_AG_AGF,	XFS_AG_GEOM_SICK_AGF },
@@ -643,6 +662,22 @@ xfs_ag_geom_health(
 	}
 }
 
+/* Translate XFS_SICK_AG_* into XFS_AG_GEOM_SICK_*. */
+unsigned int
+xfs_healthmon_perag_mask(
+	unsigned int			sick_mask)
+{
+	const struct ioctl_sick_map	*m;
+	unsigned int			ioctl_mask = 0;
+
+	for_each_sick_map(ag_map, m) {
+		if (sick_mask & m->sick_mask)
+			ioctl_mask |= m->ioctl_mask;
+	}
+
+	return ioctl_mask;
+}
+
 static const struct ioctl_sick_map rtgroup_map[] = {
 	{ XFS_SICK_RG_SUPER,	XFS_RTGROUP_GEOM_SICK_SUPER },
 	{ XFS_SICK_RG_BITMAP,	XFS_RTGROUP_GEOM_SICK_BITMAP },
@@ -673,6 +708,22 @@ xfs_rtgroup_geom_health(
 	}
 }
 
+/* Translate XFS_SICK_RG_* into XFS_RTGROUP_GEOM_SICK_*. */
+unsigned int
+xfs_healthmon_rtgroup_mask(
+	unsigned int			sick_mask)
+{
+	const struct ioctl_sick_map	*m;
+	unsigned int			ioctl_mask = 0;
+
+	for_each_sick_map(rtgroup_map, m) {
+		if (sick_mask & m->sick_mask)
+			ioctl_mask |= m->ioctl_mask;
+	}
+
+	return ioctl_mask;
+}
+
 static const struct ioctl_sick_map ino_map[] = {
 	{ XFS_SICK_INO_CORE,	XFS_BS_SICK_INODE },
 	{ XFS_SICK_INO_BMBTD,	XFS_BS_SICK_BMBTD },
@@ -711,6 +762,22 @@ xfs_bulkstat_health(
 	}
 }
 
+/* Translate XFS_SICK_INO_* into XFS_BS_SICK_*. */
+unsigned int
+xfs_healthmon_inode_mask(
+	unsigned int			sick_mask)
+{
+	const struct ioctl_sick_map	*m;
+	unsigned int			ioctl_mask = 0;
+
+	for_each_sick_map(ino_map, m) {
+		if (sick_mask & m->sick_mask)
+			ioctl_mask |= m->ioctl_mask;
+	}
+
+	return ioctl_mask;
+}
+
 /* Mark a block mapping sick. */
 void
 xfs_bmap_mark_sick(
diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index d5ca6ef8015c0e..05c67fe40f2bac 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -18,6 +18,7 @@
 #include "xfs_da_btree.h"
 #include "xfs_quota_defs.h"
 #include "xfs_rtgroup.h"
+#include "xfs_health.h"
 #include "xfs_healthmon.h"
 
 #include <linux/anon_inodes.h>
@@ -65,8 +66,15 @@ struct xfs_healthmon {
 	struct xfs_healthmon_event	*first_event;
 	struct xfs_healthmon_event	*last_event;
 
+	/* live update hooks */
+	struct xfs_health_hook		hhook;
+
+	/* filesystem mount, or NULL if we've unmounted */
 	struct xfs_mount		*mp;
 
+	/* filesystem type for safe cleanup of hooks; requires module_get */
+	struct file_system_type		*fstyp;
+
 	/* number of events */
 	unsigned int			events;
 
@@ -131,6 +139,23 @@ xfs_healthmon_free_head(
 	return 0;
 }
 
+/* Insert an event onto the start of the list. */
+static inline void
+__xfs_healthmon_insert(
+	struct xfs_healthmon		*hm,
+	struct xfs_healthmon_event	*event)
+{
+	event->next = hm->first_event;
+	if (!hm->first_event)
+		hm->first_event = event;
+	if (!hm->last_event)
+		hm->last_event = event;
+	xfs_healthmon_bump_events(hm);
+	wake_up(&hm->wait);
+
+	trace_xfs_healthmon_insert(hm->mp, event);
+}
+
 /* Push an event onto the end of the list. */
 static inline void
 __xfs_healthmon_push(
@@ -202,6 +227,10 @@ xfs_healthmon_start_live_update(
 {
 	struct xfs_healthmon_event	*event;
 
+	/* Filesystem already unmounted, do nothing. */
+	if (!hm->mp)
+		return -ESHUTDOWN;
+
 	/* If the queue is already full.... */
 	if (hm->events >= XFS_HEALTHMON_MAX_EVENTS) {
 		trace_xfs_healthmon_lost_event(hm->mp, hm->lost_prev_event);
@@ -274,6 +303,185 @@ xfs_healthmon_start_live_update(
 	return 0;
 }
 
+/* Compute the reporting mask. */
+static inline bool
+xfs_healthmon_event_mask(
+	struct xfs_healthmon			*hm,
+	enum xfs_health_update_type		type,
+	const struct xfs_health_update_params	*hup,
+	unsigned int				*mask)
+{
+	/* Always report unmounts. */
+	if (type == XFS_HEALTHUP_UNMOUNT)
+		return true;
+
+	/* If we want all events, return all events. */
+	if (hm->verbose) {
+		*mask = hup->new_mask;
+		return true;
+	}
+
+	switch (type) {
+	case XFS_HEALTHUP_SICK:
+		/* Always report runtime corruptions */
+		*mask = hup->new_mask;
+		break;
+	case XFS_HEALTHUP_CORRUPT:
+		/* Only report new fsck errors */
+		*mask = hup->new_mask & ~hup->old_mask;
+		break;
+	case XFS_HEALTHUP_HEALTHY:
+		/* Only report healthy metadata that got fixed */
+		*mask = hup->new_mask & hup->old_mask;
+		break;
+	case XFS_HEALTHUP_UNMOUNT:
+		/* This is here for static enum checking */
+		break;
+	}
+
+	/* If not in verbose mode, mask state has to change. */
+	return *mask != 0;
+}
+
+static inline enum xfs_healthmon_type
+health_update_to_type(
+	enum xfs_health_update_type	type)
+{
+	switch (type) {
+	case XFS_HEALTHUP_SICK:
+		return XFS_HEALTHMON_SICK;
+	case XFS_HEALTHUP_CORRUPT:
+		return XFS_HEALTHMON_CORRUPT;
+	case XFS_HEALTHUP_HEALTHY:
+		return XFS_HEALTHMON_HEALTHY;
+	case XFS_HEALTHUP_UNMOUNT:
+		/* static checking */
+		break;
+	}
+	return XFS_HEALTHMON_UNMOUNT;
+}
+
+static inline enum xfs_healthmon_domain
+health_update_to_domain(
+	enum xfs_health_update_domain	domain)
+{
+	switch (domain) {
+	case XFS_HEALTHUP_FS:
+		return XFS_HEALTHMON_FS;
+	case XFS_HEALTHUP_AG:
+		return XFS_HEALTHMON_AG;
+	case XFS_HEALTHUP_RTGROUP:
+		return XFS_HEALTHMON_RTGROUP;
+	case XFS_HEALTHUP_INODE:
+		/* static checking */
+		break;
+	}
+	return XFS_HEALTHMON_INODE;
+}
+
+/* Add a health event to the reporting queue. */
+STATIC int
+xfs_healthmon_metadata_hook(
+	struct notifier_block		*nb,
+	unsigned long			action,
+	void				*data)
+{
+	struct xfs_health_update_params	*hup = data;
+	struct xfs_healthmon		*hm;
+	struct xfs_healthmon_event	*event;
+	enum xfs_health_update_type	type = action;
+	unsigned int			mask = 0;
+	int				error;
+
+	hm = container_of(nb, struct xfs_healthmon, hhook.health_hook.nb);
+
+	/* Decode event mask and skip events we don't care about. */
+	if (!xfs_healthmon_event_mask(hm, type, hup, &mask))
+		return NOTIFY_DONE;
+
+	mutex_lock(&hm->lock);
+
+	trace_xfs_healthmon_metadata_hook(hm->mp, action, hup, hm->events,
+			hm->lost_prev_event);
+
+	error = xfs_healthmon_start_live_update(hm);
+	if (error)
+		goto out_unlock;
+
+	if (type == XFS_HEALTHUP_UNMOUNT) {
+		/*
+		 * The filesystem is unmounting, so we must detach from the
+		 * mount.  After this point, the healthmon thread has no
+		 * connection to the mounted filesystem and must not touch its
+		 * hooks.
+		 */
+		trace_xfs_healthmon_unmount(hm->mp, hm->events,
+				hm->lost_prev_event);
+
+		hm->mp = NULL;
+
+		/*
+		 * Try to add an unmount message to the head of the list so
+		 * that userspace will notice the unmount.  If we can't add
+		 * the event, wake up the reader directly.
+		 */
+		event = xfs_healthmon_alloc(hm, XFS_HEALTHMON_UNMOUNT,
+				XFS_HEALTHMON_MOUNT);
+		if (event)
+			__xfs_healthmon_insert(hm, event);
+		else
+			wake_up(&hm->wait);
+
+		goto out_unlock;
+	}
+
+	event = xfs_healthmon_alloc(hm, health_update_to_type(type),
+			  health_update_to_domain(hup->domain));
+	if (!event)
+		goto out_unlock;
+
+	/* Ignore the event if it's only reporting a secondary health state. */
+	switch (event->domain) {
+	case XFS_HEALTHMON_FS:
+		event->fsmask = mask & ~XFS_SICK_FS_SECONDARY;
+		if (!event->fsmask)
+			goto out_event;
+		break;
+	case XFS_HEALTHMON_AG:
+		event->grpmask = mask & ~XFS_SICK_AG_SECONDARY;
+		if (!event->grpmask)
+			goto out_event;
+		event->group = hup->group;
+		break;
+	case XFS_HEALTHMON_RTGROUP:
+		event->grpmask = mask & ~XFS_SICK_RG_SECONDARY;
+		if (!event->grpmask)
+			goto out_event;
+		event->group = hup->group;
+		break;
+	case XFS_HEALTHMON_INODE:
+		event->imask = mask & ~XFS_SICK_INO_SECONDARY;
+		if (!event->imask)
+			goto out_event;
+		event->ino = hup->ino;
+		event->gen = hup->gen;
+		break;
+	default:
+		ASSERT(0);
+		break;
+	}
+	error = xfs_healthmon_push(hm, event);
+	if (error)
+		goto out_event;
+
+out_unlock:
+	mutex_unlock(&hm->lock);
+	return NOTIFY_DONE;
+out_event:
+	kfree(event);
+	goto out_unlock;
+}
+
 /* Render the health update type as a string. */
 STATIC const char *
 xfs_healthmon_typestring(
@@ -282,6 +490,10 @@ xfs_healthmon_typestring(
 	static const char *type_strings[] = {
 		[XFS_HEALTHMON_RUNNING]		= "running",
 		[XFS_HEALTHMON_LOST]		= "lost",
+		[XFS_HEALTHMON_UNMOUNT]		= "unmount",
+		[XFS_HEALTHMON_SICK]		= "sick",
+		[XFS_HEALTHMON_CORRUPT]		= "corrupt",
+		[XFS_HEALTHMON_HEALTHY]		= "healthy",
 	};
 
 	if (event->type >= ARRAY_SIZE(type_strings))
@@ -297,6 +509,10 @@ xfs_healthmon_domstring(
 {
 	static const char *dom_strings[] = {
 		[XFS_HEALTHMON_MOUNT]		= "mount",
+		[XFS_HEALTHMON_FS]		= "fs",
+		[XFS_HEALTHMON_AG]		= "perag",
+		[XFS_HEALTHMON_INODE]		= "inode",
+		[XFS_HEALTHMON_RTGROUP]		= "rtgroup",
 	};
 
 	if (event->domain >= ARRAY_SIZE(dom_strings))
@@ -322,6 +538,11 @@ xfs_healthmon_format_flags(
 		if (!(p->mask & flags))
 			continue;
 
+		if (!p->str) {
+			flags &= ~p->mask;
+			continue;
+		}
+
 		ret = seq_buf_printf(outbuf, "%s\"%s\"",
 				first ? "" : ", ", p->str);
 		if (ret < 0)
@@ -372,6 +593,113 @@ __xfs_healthmon_format_mask(
 #define xfs_healthmon_format_mask(o, d, s, m) \
 	__xfs_healthmon_format_mask((o), (d), (s), ARRAY_SIZE(s), (m))
 
+/* Render fs sickness mask as a string set */
+static int
+xfs_healthmon_format_fs(
+	struct seq_buf			*outbuf,
+	const struct xfs_healthmon_event *event)
+{
+	static const struct flag_string	mask_strings[] = {
+		{ XFS_FSOP_GEOM_SICK_COUNTERS,		"fscounters" },
+		{ XFS_FSOP_GEOM_SICK_UQUOTA,		"usrquota" },
+		{ XFS_FSOP_GEOM_SICK_GQUOTA,		"grpquota" },
+		{ XFS_FSOP_GEOM_SICK_PQUOTA,		"prjquota" },
+		{ XFS_FSOP_GEOM_SICK_QUOTACHECK,	"quotacheck" },
+		{ XFS_FSOP_GEOM_SICK_NLINKS,		"nlinks" },
+		{ XFS_FSOP_GEOM_SICK_METADIR,		"metadir" },
+		{ XFS_FSOP_GEOM_SICK_METAPATH,		"metapath" },
+	};
+
+	return xfs_healthmon_format_mask(outbuf, "structures", mask_strings,
+			xfs_healthmon_fs_mask(event->fsmask));
+}
+
+/* Render rtgroup sickness mask as a string set */
+static int
+xfs_healthmon_format_rtgroup(
+	struct seq_buf			*outbuf,
+	const struct xfs_healthmon_event *event)
+{
+	static const struct flag_string	mask_strings[] = {
+		{ XFS_RTGROUP_GEOM_SICK_SUPER,		"super" },
+		{ XFS_RTGROUP_GEOM_SICK_BITMAP,		"bitmap" },
+		{ XFS_RTGROUP_GEOM_SICK_SUMMARY,	"summary" },
+		{ XFS_RTGROUP_GEOM_SICK_RMAPBT,		"rmapbt" },
+		{ XFS_RTGROUP_GEOM_SICK_REFCNTBT,	"refcountbt" },
+	};
+	ssize_t				ret;
+
+	ret = xfs_healthmon_format_mask(outbuf, "structures", mask_strings,
+			xfs_healthmon_rtgroup_mask(event->grpmask));
+	if (ret < 0)
+		return ret;
+
+	return seq_buf_printf(outbuf, "  \"group\":      %u,\n",
+			event->group);
+}
+
+/* Render perag sickness mask as a string set */
+static int
+xfs_healthmon_format_ag(
+	struct seq_buf			*outbuf,
+	const struct xfs_healthmon_event *event)
+{
+	static const struct flag_string	mask_strings[] = {
+		{ XFS_AG_GEOM_SICK_SB,		"super" },
+		{ XFS_AG_GEOM_SICK_AGF,		"agf" },
+		{ XFS_AG_GEOM_SICK_AGFL,	"agfl" },
+		{ XFS_AG_GEOM_SICK_AGI,		"agi" },
+		{ XFS_AG_GEOM_SICK_BNOBT,	"bnobt" },
+		{ XFS_AG_GEOM_SICK_CNTBT,	"cntbt" },
+		{ XFS_AG_GEOM_SICK_INOBT,	"inobt" },
+		{ XFS_AG_GEOM_SICK_FINOBT,	"finobt" },
+		{ XFS_AG_GEOM_SICK_RMAPBT,	"rmapbt" },
+		{ XFS_AG_GEOM_SICK_REFCNTBT,	"refcountbt" },
+		{ XFS_AG_GEOM_SICK_INODES,	"inodes" },
+	};
+	ssize_t				ret;
+
+	ret = xfs_healthmon_format_mask(outbuf, "structures", mask_strings,
+			xfs_healthmon_perag_mask(event->grpmask));
+	if (ret < 0)
+		return ret;
+
+	return seq_buf_printf(outbuf, "  \"group\":      %u,\n",
+			event->group);
+}
+
+/* Render inode sickness mask as a string set */
+static int
+xfs_healthmon_format_inode(
+	struct seq_buf			*outbuf,
+	const struct xfs_healthmon_event *event)
+{
+	static const struct flag_string	mask_strings[] = {
+		{ XFS_BS_SICK_INODE,		"core" },
+		{ XFS_BS_SICK_BMBTD,		"bmapbtd" },
+		{ XFS_BS_SICK_BMBTA,		"bmapbta" },
+		{ XFS_BS_SICK_BMBTC,		"bmapbtc" },
+		{ XFS_BS_SICK_DIR,		"directory" },
+		{ XFS_BS_SICK_XATTR,		"xattr" },
+		{ XFS_BS_SICK_SYMLINK,		"symlink" },
+		{ XFS_BS_SICK_PARENT,		"parent" },
+		{ XFS_BS_SICK_DIRTREE,		"dirtree" },
+	};
+	ssize_t				ret;
+
+	ret = xfs_healthmon_format_mask(outbuf, "structures", mask_strings,
+			xfs_healthmon_inode_mask(event->imask));
+	if (ret < 0)
+		return ret;
+
+	ret = seq_buf_printf(outbuf, "  \"inumber\":    %llu,\n",
+			event->ino);
+	if (ret < 0)
+		return ret;
+	return seq_buf_printf(outbuf, "  \"generation\": %u,\n",
+			event->gen);
+}
+
 static inline void
 xfs_healthmon_reset_outbuf(
 	struct xfs_healthmon		*hm)
@@ -433,6 +761,18 @@ xfs_healthmon_format_json(
 			break;
 		}
 		break;
+	case XFS_HEALTHMON_FS:
+		ret = xfs_healthmon_format_fs(outbuf, event);
+		break;
+	case XFS_HEALTHMON_RTGROUP:
+		ret = xfs_healthmon_format_rtgroup(outbuf, event);
+		break;
+	case XFS_HEALTHMON_AG:
+		ret = xfs_healthmon_format_ag(outbuf, event);
+		break;
+	case XFS_HEALTHMON_INODE:
+		ret = xfs_healthmon_format_inode(outbuf, event);
+		break;
 	}
 	if (ret < 0)
 		goto overrun;
@@ -461,11 +801,19 @@ xfs_healthmon_format_json(
 
 static const unsigned int domain_map[] = {
 	[XFS_HEALTHMON_MOUNT]		= XFS_HEALTH_MONITOR_DOMAIN_MOUNT,
+	[XFS_HEALTHMON_FS]		= XFS_HEALTH_MONITOR_DOMAIN_FS,
+	[XFS_HEALTHMON_AG]		= XFS_HEALTH_MONITOR_DOMAIN_AG,
+	[XFS_HEALTHMON_INODE]		= XFS_HEALTH_MONITOR_DOMAIN_INODE,
+	[XFS_HEALTHMON_RTGROUP]		= XFS_HEALTH_MONITOR_DOMAIN_RTGROUP,
 };
 
 static const unsigned int type_map[] = {
 	[XFS_HEALTHMON_RUNNING]		= XFS_HEALTH_MONITOR_TYPE_RUNNING,
 	[XFS_HEALTHMON_LOST]		= XFS_HEALTH_MONITOR_TYPE_LOST,
+	[XFS_HEALTHMON_SICK]		= XFS_HEALTH_MONITOR_TYPE_SICK,
+	[XFS_HEALTHMON_CORRUPT]		= XFS_HEALTH_MONITOR_TYPE_CORRUPT,
+	[XFS_HEALTHMON_HEALTHY]		= XFS_HEALTH_MONITOR_TYPE_HEALTHY,
+	[XFS_HEALTHMON_UNMOUNT]		= XFS_HEALTH_MONITOR_TYPE_UNMOUNT,
 };
 
 /* Render event as a C structure */
@@ -501,6 +849,22 @@ xfs_healthmon_format_cstruct(
 			break;
 		}
 		break;
+	case XFS_HEALTHMON_FS:
+		hme.e.fs.mask = xfs_healthmon_fs_mask(event->fsmask);
+		break;
+	case XFS_HEALTHMON_RTGROUP:
+		hme.e.group.mask = xfs_healthmon_rtgroup_mask(event->grpmask);
+		hme.e.group.gno = event->group;
+		break;
+	case XFS_HEALTHMON_AG:
+		hme.e.group.mask = xfs_healthmon_perag_mask(event->grpmask);
+		hme.e.group.gno = event->group;
+		break;
+	case XFS_HEALTHMON_INODE:
+		hme.e.inode.mask = xfs_healthmon_inode_mask(event->imask);
+		hme.e.inode.ino = event->ino;
+		hme.e.inode.gen = event->gen;
+		break;
 	default:
 		break;
 	}
@@ -541,7 +905,7 @@ static inline bool
 xfs_healthmon_has_eventdata(
 	struct xfs_healthmon	*hm)
 {
-	return hm->events > 0 || xfs_healthmon_outbuf_bytes(hm) > 0;
+	return !hm->mp || hm->events > 0 || xfs_healthmon_outbuf_bytes(hm) > 0;
 }
 
 /* Try to copy the rest of the outbuf to the iov iter. */
@@ -584,10 +948,16 @@ xfs_healthmon_peek(
 	struct xfs_healthmon_event *event;
 
 	mutex_lock(&hm->lock);
+	event = hm->first_event;
 	if (hm->mp)
-		event = hm->first_event;
-	else
-		event = NULL;
+		goto done;
+
+	/* If the filesystem is unmounted, only return the unmount event */
+	if (event && event->type == XFS_HEALTHMON_UNMOUNT)
+		goto done;
+	event = NULL;
+
+done:
 	mutex_unlock(&hm->lock);
 	return event;
 }
@@ -722,6 +1092,58 @@ xfs_healthmon_free_events(
 	hm->first_event = hm->last_event = NULL;
 }
 
+/*
+ * Detach all filesystem hooks that were set up for a health monitor.  Only
+ * call this from iterate_super*.
+ */
+STATIC void
+xfs_healthmon_detach_hooks(
+	struct super_block	*sb,
+	void			*arg)
+{
+	struct xfs_healthmon	*hm = arg;
+
+	mutex_lock(&hm->lock);
+
+	/*
+	 * Because health monitors have a weak reference to the filesystem
+	 * they're monitoring, the hook deletions below must not race against
+	 * that filesystem being unmounted because that could lead to UAF
+	 * errors.
+	 *
+	 * If hm->mp is NULL, the health unmount hook already ran and the hook
+	 * chain head (contained within the xfs_mount structure) is gone.  Do
+	 * not detach any hooks; just let them get freed when the healthmon
+	 * object is torn down.
+	 */
+	if (!hm->mp)
+		goto out_unlock;
+
+	/*
+	 * Otherwise, the caller gave us a non-dying @sb with s_umount held in
+	 * shared mode, which means that @sb cannot be running through
+	 * deactivate_locked_super and cannot be freed.  It's safe to compare
+	 * @sb against the super that we snapshotted when we set up the health
+	 * monitor.
+	 */
+	if (hm->mp->m_super != sb)
+		goto out_unlock;
+
+	mutex_unlock(&hm->lock);
+
+	/*
+	 * Now we know that the filesystem @hm->mp is active and cannot be
+	 * deactivated until this function returns.  Unmount events are sent
+	 * through the health monitoring subsystem from xfs_fs_put_super, so
+	 * it is now time to detach the hooks.
+	 */
+	xfs_health_hook_del(hm->mp, &hm->hhook);
+	return;
+
+out_unlock:
+	mutex_unlock(&hm->lock);
+}
+
 /* Free the health monitoring information. */
 STATIC int
 xfs_healthmon_release(
@@ -734,6 +1156,9 @@ xfs_healthmon_release(
 
 	wake_up_all(&hm->wait);
 
+	iterate_supers_type(hm->fstyp, xfs_healthmon_detach_hooks, hm);
+	xfs_health_hook_disable();
+
 	mutex_destroy(&hm->lock);
 	xfs_healthmon_free_events(hm);
 	if (hm->outbuf.size)
@@ -783,11 +1208,18 @@ xfs_healthmon_show_fdinfo(
 	struct xfs_healthmon	*hm = file->private_data;
 
 	mutex_lock(&hm->lock);
+	if (!hm->mp) {
+		seq_printf(m, "state:\tdead\n");
+		goto out_unlock;
+	}
+
 	seq_printf(m, "state:\talive\ndev:\t%s\nformat:\t%s\nevents:\t%llu\nlost:\t%llu\n",
 			hm->mp->m_super->s_id,
 			xfs_healthmon_format_string(hm),
 			hm->total_events,
 			hm->total_lost);
+
+out_unlock:
 	mutex_unlock(&hm->lock);
 }
 #endif
@@ -832,6 +1264,13 @@ xfs_ioc_health_monitor(
 	hm->mp = mp;
 	hm->format = hmo.format;
 
+	/*
+	 * Since we already got a ref to the module, take a reference to the
+	 * fstype to make it easier to detach the hooks when we tear things
+	 * down later.
+	 */
+	hm->fstyp = mp->m_super->s_type;
+
 	seq_buf_init(&hm->outbuf, NULL, 0);
 	mutex_init(&hm->lock);
 	init_waitqueue_head(&hm->wait);
@@ -839,12 +1278,21 @@ xfs_ioc_health_monitor(
 	if (hmo.flags & XFS_HEALTH_MONITOR_VERBOSE)
 		hm->verbose = true;
 
+	/* Enable hooks to receive events, generally. */
+	xfs_health_hook_enable();
+
+	/* Attach specific event hooks to this monitor. */
+	xfs_health_hook_setup(&hm->hhook, xfs_healthmon_metadata_hook);
+	ret = xfs_health_hook_add(mp, &hm->hhook);
+	if (ret)
+		goto out_hooks;
+
 	/* Queue up the first event that lets the client know we're running. */
 	event = xfs_healthmon_alloc(hm, XFS_HEALTHMON_RUNNING,
 			XFS_HEALTHMON_MOUNT);
 	if (!event) {
 		ret = -ENOMEM;
-		goto out_mutex;
+		goto out_healthhook;
 	}
 	__xfs_healthmon_push(hm, event);
 
@@ -856,14 +1304,17 @@ xfs_ioc_health_monitor(
 			O_CLOEXEC | O_RDONLY);
 	if (fd < 0) {
 		ret = fd;
-		goto out_mutex;
+		goto out_healthhook;
 	}
 
 	trace_xfs_healthmon_create(mp, hmo.flags, hmo.format);
 
 	return fd;
 
-out_mutex:
+out_healthhook:
+	xfs_health_hook_del(mp, &hm->hhook);
+out_hooks:
+	xfs_health_hook_disable();
 	mutex_destroy(&hm->lock);
 	xfs_healthmon_free_events(hm);
 	kfree(hm);


