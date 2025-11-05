Return-Path: <linux-fsdevel+bounces-67042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D3FC33893
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1C29934E532
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47FE23D7F3;
	Wed,  5 Nov 2025 00:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOM7WZnL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A2623BF9B;
	Wed,  5 Nov 2025 00:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762304003; cv=none; b=ddxRpRsXkyovYwnQGSWpwZLpBD+f1LU3qtmtO0xia36AOLu28RPOAoMxnzcjB0xwwYwP5BhbEi4D81tNwOmXbXuXb5dl6as7Hm8kMZCQYNo/6nDea0dGFBuivDXmnlYAalDCSHC2WSm3GLaLTW0VGlKn2TJRKisYsBK7KHvd3dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762304003; c=relaxed/simple;
	bh=eX0KXKBh/d7tUOfpMMVPmc2z/Q0wzq1ZZjFPcGJOWb4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e6MOqtQCbghRGSqhWbqen15T1hxU3Qt/KBnZWw1OqS7FaD/2kdEijXMLX1fgzIRojjDfmW58e+sbdC9KZ1oDolzlapo1GuFgjxYunHS9RCkpEkZaYlQGGPjEny0Z6/LgAK0MwtS3iFrtvnA/zQd3uicF1gfwHdROzDMTijhLkoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOM7WZnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1084C4CEF7;
	Wed,  5 Nov 2025 00:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762304002;
	bh=eX0KXKBh/d7tUOfpMMVPmc2z/Q0wzq1ZZjFPcGJOWb4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UOM7WZnLX4Yk1CG8MShw5pp4wy8mA7wLTbPqU/B2zwhb/r3i6pPqVIo+HuqirVksF
	 KzZc5Jnyz5IutZsQqUKSJVD0wjRaQte3p4e62r0QEXXfkUPspjCOWUb+xeHcyfAUd5
	 d0uJ3Q2/GkswTknk5K1NATRsSKVoJhuStTKeIjY8TFJDlNYcJ9Pi/5kdFX2iF9I/fF
	 AiJsJgoKgQUCPiW5/sAHNQ03h8ZFq4pVuyUx50MublzhwPbRqz3TLN9Dyy0FjD7xTJ
	 mcCcsIKgx4j//tmUYg7jRt/GQOr4zHSwtwH66Z8H7iGmTJ/0qxU3kIPP1abvnAVLWO
	 Z2AURFIJTNb1g==
Date: Tue, 04 Nov 2025 16:53:22 -0800
Subject: [PATCH 19/22] xfs: send uevents when major filesystem events happen
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176230366106.1647136.2960766198659113453.stgit@frogsfrogsfrogs>
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
index 26ed16e67410d7..0b6b178cb8169a 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -522,6 +522,23 @@ xfs_shutdown_hook_setup(
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
@@ -572,6 +589,7 @@ xfs_do_force_shutdown(
 	}
 
 	trace_xfs_force_shutdown(mp, tag, flags, fname, lnnum);
+	xfs_send_shutdown_uevent(mp);
 
 	xfs_alert_tag(mp, tag,
 "%s (0x%x) detected at %pS (%s:%d).  Shutting down filesystem.",
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 54d82f5a5b8863..bfd12ccaa707a8 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -53,6 +53,7 @@
 #include <linux/magic.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/uuid.h>
 
 static const struct super_operations xfs_super_operations;
 
@@ -1244,12 +1245,73 @@ xfs_inodegc_free_percpu(
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
@@ -1667,6 +1729,37 @@ xfs_debugfs_mkdir(
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
@@ -1980,6 +2073,7 @@ xfs_fs_fill_super(
 		mp->m_debugfs_uuid = NULL;
 	}
 
+	xfs_send_mount_uevent(fc, mp);
 	return 0;
 
  out_filestream_unmount:


