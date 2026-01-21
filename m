Return-Path: <linux-fsdevel+bounces-74793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gO/XNX90cGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:38:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A13E52264
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 69F364A6B0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525DE43E480;
	Wed, 21 Jan 2026 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hgoy5t6U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D920534B438;
	Wed, 21 Jan 2026 06:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977448; cv=none; b=Bqm/vAvITFYEEjeXcAuxIQIxxyx6eVwK2IftK6AoI8s8y+H+R0rZ1y1+o2gDxPaY9/adjezJsy7WD6Q1Ea79tebE0qobHtjFw9biaxbPhEv/IYgNn+YRDFwtENPt2HiNpHVSa0x9NmuajugP4ie2FV6pYqB/53fN72jQpJLOzrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977448; c=relaxed/simple;
	bh=M3cSpS5wjRRMqDhgUY3rfZLw/c1sEkfXuQDLT5+I6LI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N5rPCc1QE7t9iG0m4xg1Dhr9fhLOlVD10N10C2hECrHEzqd7sslPtbxmVurpGaWBMfBwEGfo8iFXZY/glMaAYULYoULa2nFqqdKtUsjKhMVfclml5e1C5RtDHMeekQwS0X/0D22Em5KStewq5Lem9qhllp/3MHrxVUhFpO8n21U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hgoy5t6U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49679C116D0;
	Wed, 21 Jan 2026 06:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768977446;
	bh=M3cSpS5wjRRMqDhgUY3rfZLw/c1sEkfXuQDLT5+I6LI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Hgoy5t6Uu9IDHSxyXEvRhmWThVtgcSCUhl7Dswig4sH8Eo+la6ano/0XNYrp2SS10
	 c4TikECJowi1WxOq1CLIAreXJxSok7kLLQGhQg3ob3fUs9dY8xj1h5Q/ZSTEEW3UnD
	 2pHio2trImOfVaCenH8r1l6tkvm4AVLyO74l9itDP4e0+AlriSPFPXMNvL8g20wKRE
	 UIdFL8SyTbxk2kf4LMa8dRFJPsPZJLa7wP9FYo36u/fRzXJQLOx/7Zz6Lm5o5aF9D/
	 VNFZicrFMHfSJ90kwrREOkbFJYBnVELrrNbZHykz2GhpK/6kra4yEYqZFeTfowdS8l
	 x0QyoTLA4/erw==
Date: Tue, 20 Jan 2026 22:37:25 -0800
Subject: [PATCH 10/11] xfs: check if an open file is on the health monitored
 fs
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 hch@lst.de
Message-ID: <176897695242.202109.3700962489311478673.stgit@frogsfrogsfrogs>
In-Reply-To: <176897694953.202109.15171131238404759078.stgit@frogsfrogsfrogs>
References: <176897694953.202109.15171131238404759078.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74793-lists,linux-fsdevel=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,lst.de:email]
X-Rspamd-Queue-Id: 9A13E52264
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Darrick J. Wong <djwong@kernel.org>

Create a new ioctl for the healthmon file that checks that a given fd
points to the same filesystem that the healthmon file is monitoring.
This allows xfs_healer to check that when it reopens a mountpoint to
perform repairs, the file that it gets matches the filesystem that
generated the corruption report.

(Note that xfs_healer doesn't maintain an open fd to a filesystem that
it's monitoring so that it doesn't pin the mount.)

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/libxfs/xfs_fs.h |   12 +++++++++++-
 fs/xfs/xfs_healthmon.c |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 4ec1b2aede976f..a01303c5de6ce6 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -1151,6 +1151,15 @@ struct xfs_health_monitor {
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
@@ -1191,7 +1200,8 @@ struct xfs_health_monitor {
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
index 4a8cbd87932201..3030fa93c1e575 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -1090,6 +1090,38 @@ xfs_healthmon_reconfigure(
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
+	if (hm->mount_cookie != (uintptr_t)hms_inode->i_sb) {
+		mutex_unlock(&hm->lock);
+		return -ESTALE;
+	}
+
+	mutex_unlock(&hm->lock);
+	return 0;
+}
+
 /* Handle ioctls for the health monitoring thread. */
 STATIC long
 xfs_healthmon_ioctl(
@@ -1102,6 +1134,8 @@ xfs_healthmon_ioctl(
 	switch (cmd) {
 	case XFS_IOC_HEALTH_MONITOR:
 		return xfs_healthmon_reconfigure(file, cmd, arg);
+	case XFS_IOC_HEALTH_FD_ON_MONITORED_FS:
+		return xfs_healthmon_file_on_monitored_fs(file, cmd, arg);
 	default:
 		break;
 	}


