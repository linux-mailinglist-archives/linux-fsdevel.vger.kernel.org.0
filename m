Return-Path: <linux-fsdevel+bounces-65265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BFCBFEAE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 02:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 634A550180B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 00:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6AF8821;
	Thu, 23 Oct 2025 00:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQmBQH8N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C0B256D;
	Thu, 23 Oct 2025 00:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177934; cv=none; b=LYmtcgmiGjnJQYKeALxUEOyYpcYDMnkWVej2Vb3WpuxYKDHkTFwQd0qb4F4H64ibrI9FQwA2IgBFhpHRQ9VHEmb9dGSQeaShBuGuewdHtjIFy1fq+a2ftLt4IO18PZEMHgzt3DhA1pmva05jBj5I5ttG5+FEaRcQf8t7xXyJS7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177934; c=relaxed/simple;
	bh=ZejsmaA8niJsoC5cC5YGNuU+P3axiU6zxVq0QGSCi3Q=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cqhw2cjW+EoCFwOpHGNg5+4MM2QBcNUzIQlVEHVTs6E6OP2Re3r5WU3NCsusaiX+jHK2ePnPCTg/F8d2QxEcRipQBvd9skaJ2d/qpsF2+T2JXT+7fQuUS2oSdhxwEu7JkJB0aZ/UxwDOAfGwwcU8KQCoEuHmr6TLkG7W+DGCBjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQmBQH8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57946C4CEE7;
	Thu, 23 Oct 2025 00:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761177934;
	bh=ZejsmaA8niJsoC5cC5YGNuU+P3axiU6zxVq0QGSCi3Q=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=OQmBQH8NNharL6+cHX6WWNBrhQfebK9NbWX/oAzuzqn6X5kcHCxxTM+yjjZbp6kJF
	 uJNbsQYAzPehitg4vOyPXSJt2oOjsfLGUsX+NI7yMMIOCH8NzAS1Rnv19TV4zSdIpV
	 j2kw3cbPyb/tdjLo+Nuiu1vDzCuL2dCksG5n1DSc0x+AX4NE6YITFmFfPNu0AX033V
	 W0J+XqsPV2KPHyWWkGoWBrny74EQ8X1IiePRrtQpEZ/A5kOKNJbrgoSJx800RNR3x3
	 J6Nrdj2SN702H2nGsCuLEY2RowH2hwVG5aW6sPEWg3X9NXfkYmDSOu8ZbKyYnpT8dv
	 X3OybUYDs2ImQ==
Date: Wed, 22 Oct 2025 17:05:33 -0700
Subject: [PATCH 19/19] xfs: send uevents when major filesystem events happen
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176117744915.1025409.1880802310953946111.stgit@frogsfrogsfrogs>
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

Send uevents when we mount, unmount, and shut down the filesystem, so
that we can trigger systemd services when major events happen.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_super.h |   13 +++++++
 fs/xfs/xfs_fsops.c |   18 ++++++++++
 fs/xfs/xfs_super.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+)


diff --git a/fs/xfs/xfs_super.h b/fs/xfs/xfs_super.h
index c0e85c1e42f27d..6d428bd04a0248 100644
--- a/fs/xfs/xfs_super.h
+++ b/fs/xfs/xfs_super.h
@@ -101,4 +101,17 @@ extern struct workqueue_struct *xfs_discard_wq;
 
 struct dentry *xfs_debugfs_mkdir(const char *name, struct dentry *parent);
 
+#define XFS_UEVENT_BUFLEN ( \
+	sizeof("SID=") + sizeof_field(struct super_block, s_id) + \
+	sizeof("UUID=") + UUID_STRING_LEN + \
+	sizeof("META_UUID=") + UUID_STRING_LEN)
+
+#define XFS_UEVENT_STR_PTRS \
+	NULL, /* sid */ \
+	NULL, /* uuid */ \
+	NULL /* metauuid */
+
+int xfs_format_uevent_strings(struct xfs_mount *mp, char *buf, ssize_t buflen,
+		char **env);
+
 #endif	/* __XFS_SUPER_H__ */
diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index 69918cd1ba1dbc..b3a01361318320 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -537,6 +537,23 @@ xfs_shutdown_hook_setup(
 # define xfs_shutdown_hook(...)		((void)0)
 #endif /* CONFIG_XFS_LIVE_HOOKS */
 
+static void
+xfs_send_shutdown_uevent(
+	struct xfs_mount	*mp)
+{
+	char			buf[XFS_UEVENT_BUFLEN];
+	char			*env[] = {
+		"TYPE=shutdown",
+		XFS_UEVENT_STR_PTRS,
+		NULL,
+	};
+	int			error;
+
+	error = xfs_format_uevent_strings(mp, buf, sizeof(buf), &env[2]);
+	if (!error)
+		kobject_uevent_env(&mp->m_kobj.kobject, KOBJ_OFFLINE, env);
+}
+
 /*
  * Force a shutdown of the filesystem instantly while keeping the filesystem
  * consistent. We don't do an unmount here; just shutdown the shop, make sure
@@ -587,6 +604,7 @@ xfs_do_force_shutdown(
 	}
 
 	trace_xfs_force_shutdown(mp, tag, flags, fname, lnnum);
+	xfs_send_shutdown_uevent(mp);
 
 	xfs_alert_tag(mp, tag,
 "%s (0x%x) detected at %pS (%s:%d).  Shutting down filesystem.",
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index b6a6027b4df8d8..5137f4cb8640b8 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -53,6 +53,7 @@
 #include <linux/magic.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/uuid.h>
 
 static const struct super_operations xfs_super_operations;
 
@@ -1238,12 +1239,73 @@ xfs_inodegc_free_percpu(
 	free_percpu(mp->m_inodegc);
 }
 
+int
+xfs_format_uevent_strings(
+	struct xfs_mount	*mp,
+	char			*buf,
+	ssize_t			buflen,
+	char			**env)
+{
+	ssize_t			written;
+
+	ASSERT(buflen >= XFS_UEVENT_BUFLEN);
+
+	written = snprintf(buf, buflen, "SID=%s", mp->m_super->s_id);
+	if (written >= buflen)
+		return -EINVAL;
+
+	*env = buf;
+	env++;
+	buf += written + 1;
+	buflen -= written + 1;
+
+	written = snprintf(buf, buflen, "UUID=%pU", &mp->m_sb.sb_uuid);
+	if (written >= buflen)
+		return EINVAL;
+
+	*env = buf;
+	env++;
+	buf += written + 1;
+	buflen -= written + 1;
+
+	written = snprintf(buf, buflen, "META_UUID=%pU",
+			&mp->m_sb.sb_meta_uuid);
+	if (written >= buflen)
+		return EINVAL;
+
+	*env = buf;
+	env++;
+	buf += written + 1;
+	buflen -= written + 1;
+
+	ASSERT(buflen >= 0);
+	return 0;
+}
+
+static void
+xfs_send_unmount_uevent(
+	struct xfs_mount	*mp)
+{
+	char			buf[XFS_UEVENT_BUFLEN];
+	char			*env[] = {
+		"TYPE=mount",
+		XFS_UEVENT_STR_PTRS,
+		NULL,
+	};
+	int error;
+
+	error = xfs_format_uevent_strings(mp, buf, sizeof(buf), &env[1]);
+	if (!error)
+		kobject_uevent_env(&mp->m_kobj.kobject, KOBJ_REMOVE, env);
+}
+
 static void
 xfs_fs_put_super(
 	struct super_block	*sb)
 {
 	struct xfs_mount	*mp = XFS_M(sb);
 
+	xfs_send_unmount_uevent(mp);
 	xfs_notice(mp, "Unmounting Filesystem %pU", &mp->m_sb.sb_uuid);
 	xfs_filestream_unmount(mp);
 	xfs_unmountfs(mp);
@@ -1661,6 +1723,37 @@ xfs_debugfs_mkdir(
 	return child;
 }
 
+/*
+ * Send a uevent signalling that the mount succeeded so we can use udev rules
+ * to start background services.
+ */
+static void
+xfs_send_mount_uevent(
+	struct fs_context	*fc,
+	struct xfs_mount	*mp)
+{
+	char			*source;
+	char			buf[XFS_UEVENT_BUFLEN];
+	char			*env[] = {
+		"TYPE=mount",
+		NULL, /* source */
+		XFS_UEVENT_STR_PTRS,
+		NULL,
+	};
+	int			error;
+
+	source = kasprintf(GFP_KERNEL, "SOURCE=%s", fc->source);
+	if (!source)
+		return;
+	env[1] = source;
+
+	error = xfs_format_uevent_strings(mp, buf, sizeof(buf), &env[2]);
+	if (!error)
+		kobject_uevent_env(&mp->m_kobj.kobject, KOBJ_ADD, env);
+
+	kfree(source);
+}
+
 static int
 xfs_fs_fill_super(
 	struct super_block	*sb,
@@ -1974,6 +2067,7 @@ xfs_fs_fill_super(
 		mp->m_debugfs_uuid = NULL;
 	}
 
+	xfs_send_mount_uevent(fc, mp);
 	return 0;
 
  out_filestream_unmount:


