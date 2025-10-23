Return-Path: <linux-fsdevel+bounces-65262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA0EBFEAD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 02:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D8CD5027D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 00:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A8A1A295;
	Thu, 23 Oct 2025 00:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad7tTBD3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6F6DF76;
	Thu, 23 Oct 2025 00:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177888; cv=none; b=sS3YxA+PXOzeX616H6iICxNFjcyiyFX2pNyUd6a3y7EVE5l7N1Zn4ifjFDm2/yYTR60HuCbymuy0Fi10j8EK0y03IsJ/W1R8Xp/r/Vz6rF5X1OcHhvikBV3fWP7e3Cl7jpiq5WEihoYDydUJfBG44XuGHJ+fD79S5pnvB6okZX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177888; c=relaxed/simple;
	bh=iuNAX9xvk9xMMu/KAlVstLellfOroX+HgSQikMh4mnA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WcKnlOG79HaxS92FZ31CSOu2vBZzpRlH0uHjaUxijMasWMQwBkTvhtHFLtUeQKnl1Np0suDHeahXBL15x/aHBQyQPC9i8OEoN9UbGLdSUMI/glikifa9aX8J1NR2WC3r/WJlxUY0paS8fO9uZu/UtKfb7oj23TYxE76Wg4uXv8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad7tTBD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70528C4CEE7;
	Thu, 23 Oct 2025 00:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761177887;
	bh=iuNAX9xvk9xMMu/KAlVstLellfOroX+HgSQikMh4mnA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ad7tTBD3Jr3IRByUkaf3gggQU9fElYrtYu93Xbc0A3y/M88p1DP5yUz+3q1xWQmUD
	 kE9vti2eICyHs8q3SRdfvrjdM56xLpnXMb/TM/oADlgQ0rtjwXozQJo6iJhCzPchMY
	 S7Iqx9wYXtHydtktSo3CaIBRdq5qUk2uIJF7FUtt/anOWyg+/HsGGNrpKbD+zRbYQc
	 V6vuKe+AaBVnc2n3jf5R0Zk/Ey241Z/NdzA4JbgQhmHV4zmvHCy+rU4w0nk8D+mkyX
	 zhXGSVdQFbuIGOkogqmVyRuMJkQV0gtHnqmNP830mxLy4FJYU4/Jpo4663fK5j9kss
	 XxdNd5JVkmzqg==
Date: Wed, 22 Oct 2025 17:04:47 -0700
Subject: [PATCH 16/19] xfs: allow reconfiguration of the health monitoring
 device
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176117744850.1025409.18051757906856028292.stgit@frogsfrogsfrogs>
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

Make it so that we can reconfigure the health monitoring device by
calling the XFS_IOC_HEALTH_MONITOR ioctl on it.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_healthmon.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)


diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index 74ffb7c4af078c..ce84cd90df2379 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -23,6 +23,8 @@
 #include "xfs_fsops.h"
 #include "xfs_notify_failure.h"
 #include "xfs_file.h"
+#include "xfs_fs.h"
+#include "xfs_ioctl.h"
 
 #include <linux/anon_inodes.h>
 #include <linux/eventpoll.h>
@@ -1540,6 +1542,48 @@ xfs_healthmon_show_fdinfo(
 }
 #endif
 
+/* Reconfigure the health monitor. */
+STATIC long
+xfs_healthmon_reconfigure(
+	struct file			*file,
+	unsigned int			cmd,
+	void __user			*arg)
+{
+	struct xfs_health_monitor	hmo;
+	struct xfs_healthmon		*hm = file->private_data;
+
+	if (copy_from_user(&hmo, arg, sizeof(hmo)))
+		return -EFAULT;
+
+	if (!xfs_healthmon_validate(&hmo))
+		return -EINVAL;
+
+	mutex_lock(&hm->lock);
+	hm->format = hmo.format;
+	hm->verbose = !!(hmo.flags & XFS_HEALTH_MONITOR_VERBOSE);
+	mutex_unlock(&hm->lock);
+	return 0;
+}
+
+/* Handle ioctls for the health monitoring thread. */
+STATIC long
+xfs_healthmon_ioctl(
+	struct file			*file,
+	unsigned int			cmd,
+	unsigned long			p)
+{
+	void __user			*arg = (void __user *)p;
+
+	switch (cmd) {
+	case XFS_IOC_HEALTH_MONITOR:
+		return xfs_healthmon_reconfigure(file, cmd, arg);
+	default:
+		break;
+	}
+
+	return -ENOTTY;
+}
+
 static const struct file_operations xfs_healthmon_fops = {
 	.owner		= THIS_MODULE,
 #ifdef CONFIG_PROC_FS
@@ -1548,6 +1592,7 @@ static const struct file_operations xfs_healthmon_fops = {
 	.read_iter	= xfs_healthmon_read_iter,
 	.poll		= xfs_healthmon_poll,
 	.release	= xfs_healthmon_release,
+	.unlocked_ioctl	= xfs_healthmon_ioctl,
 };
 
 /*


