Return-Path: <linux-fsdevel+bounces-73352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF52CD16113
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 01:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7F5D3038CF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 00:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4712157480;
	Tue, 13 Jan 2026 00:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLPF3saG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5897812D1F1;
	Tue, 13 Jan 2026 00:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768264495; cv=none; b=nzzVX7OM22ko3lMagb/+6O84F6Nc1I0PmYDxcLSJrzJWgAovlMy8ZfKDTHlMK0fYyMSOMzQPTEJNdPgcBLJyL/AjLKvrljDoJcVu5DY+IzjzkxLWB7x6HTYLsDpo8O6yeNP2cYtSnzmJb01WnYWKir9087/PHttr+9cABJu18+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768264495; c=relaxed/simple;
	bh=NFvPY0/DafMXng79i5eccSl9JGYchG7gk1Ucqh76p84=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7ewYRBs+mxcIAerdnW2v0uQ7nGu0YCcQmNyMpCun+yR/njTRF1ibGowHaKVFC51Rg9GPV6y+yQ9LBU+p6ZyF/d71r2nL1/ZQ+u6lp8E6M+36ZCsb+YqIE3ClAqJzDyF5739hHDUNr2y8nBPVi0K2/mbMAYvtkjycX6VusXs+s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLPF3saG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A18C116D0;
	Tue, 13 Jan 2026 00:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768264495;
	bh=NFvPY0/DafMXng79i5eccSl9JGYchG7gk1Ucqh76p84=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DLPF3saG87ye7FmjPmpzGFXiRmPnbC78mfk67FXjj2eRouDv6e8M8XPBUi/Ok+0FW
	 fy8wPzF6pDTk24jtThkQZuSkMpk1E3Q8Df0kCnAs5mdRSXnoL0arZUuU/467STrK2c
	 GbySoGGHtFx7qKL/fbjhkzUzXCiuIRoQG5vvyEcwRG6+PC6PHtIGzNCj/r8cMvJnNQ
	 yTAnhdcOgNRdww6oeQS1MeAGw1xxUcO6LJvA8yuGpKuHBMSC9lwCYuDlV805DP0ThM
	 GU/tMEgCfNCO5TE+e7HDarlUXaQ5zCJQxd4Xf5PQNN2O0GF4aGthH/vk7KKAczG4mG
	 FGQPTEYV9sfXQ==
Date: Mon, 12 Jan 2026 16:34:54 -0800
Subject: [PATCH 09/11] xfs: allow reconfiguration of the health monitoring
 device
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176826412900.3493441.14037373299121437005.stgit@frogsfrogsfrogs>
In-Reply-To: <176826412644.3493441.536177954776056129.stgit@frogsfrogsfrogs>
References: <176826412644.3493441.536177954776056129.stgit@frogsfrogsfrogs>
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
calling the XFS_IOC_HEALTH_MONITOR ioctl on it.  As of right now we can
only toggle the verbose flag, but this is less annoying than having to
closing the monitor fd and reopen it.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_healthmon.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)


diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index a4668bb6141530..548c5777d4c596 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -23,6 +23,7 @@
 #include "xfs_fsops.h"
 #include "xfs_notify_failure.h"
 #include "xfs_file.h"
+#include "xfs_ioctl.h"
 
 #include <linux/anon_inodes.h>
 #include <linux/eventpoll.h>
@@ -1082,12 +1083,55 @@ xfs_healthmon_show_fdinfo(
 	mutex_unlock(&hm->lock);
 }
 
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
+	hm->verbose = !!(hmo.flags & XFS_HEALTH_MONITOR_VERBOSE);
+	mutex_unlock(&hm->lock);
+
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
 	.show_fdinfo	= xfs_healthmon_show_fdinfo,
 	.read_iter	= xfs_healthmon_read_iter,
 	.poll		= xfs_healthmon_poll,
 	.release	= xfs_healthmon_release,
+	.unlocked_ioctl	= xfs_healthmon_ioctl,
 };
 
 /*


