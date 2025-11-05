Return-Path: <linux-fsdevel+bounces-67039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8C0C338A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0717F4F7D44
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19EF23E35E;
	Wed,  5 Nov 2025 00:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZINq44aT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBF323B63E;
	Wed,  5 Nov 2025 00:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303956; cv=none; b=b4NJDVntjvSl3QNgmZJu5TuFjJ45tK7h5d43iWeY+7I23F625k6/LCmoxdBP/3SD3fhBTvIUTaRoAov7X2zDrmf1Wf2esUcJ7YRC8l0iX0VV3IK3xuWqEuCKGr4A539yc4N140IOqX4IV1+kG8GHRUhYLjfejKCT6GwbImFa6Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303956; c=relaxed/simple;
	bh=GOuzss1dAwPz5IjEUZwNNPED615K+O5V7A3zYYIn6OU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYfVqeDI3oSegSs8Cg3/5pUWIrC8D7c4V3nrhcp3flPpZIG3zC/PlBNicPR85Bf6bXofjkkfOhfJOLvhivlMeLWuj3jaxp8J6FJkr3NAy0h1p3knFCrv05ZGotTGdJyAMR2AkrszOkb6laVDfco4B+xhx+Y89SWCf5sbxuKv3Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZINq44aT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8A7C4CEF7;
	Wed,  5 Nov 2025 00:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762303956;
	bh=GOuzss1dAwPz5IjEUZwNNPED615K+O5V7A3zYYIn6OU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ZINq44aTrsPV0IfvJfk1tLLZtjAz/TI634ukuuMGb7BGUd4eVdVIXPim2eA6WM4H3
	 Prq7ztur4kclatUtw8cISX/u1x9Puh3ODh2Sj2x4H17W2LaZJxPSHoDkJ/XIuktXXR
	 LKQYIZPfNIR4FTcfZ2fN7h2vncxfL0HM65+O+SpLuOoHMQaRfjucs3T1mNmhSCdXpC
	 o5mbNVmo+hKwx8LoNdDw/Op2gOYSFFVy+72k/0E4U0BbCL9eWGJCJyYT/vPzFzt3Ku
	 sHDWay2AMrGJtyDqYNi4ykcLcqCAkqChFVnST6vHL8QcOEmarMI+f3OreGdtnOczq/
	 vB8E8KGmrorjg==
Date: Tue, 04 Nov 2025 16:52:35 -0800
Subject: [PATCH 16/22] xfs: allow reconfiguration of the health monitoring
 device
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176230366040.1647136.14580032801657893880.stgit@frogsfrogsfrogs>
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

Make it so that we can reconfigure the health monitoring device by
calling the XFS_IOC_HEALTH_MONITOR ioctl on it.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_healthmon.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)


diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index 31c2f6f43cf474..d3784073494ec6 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -23,6 +23,7 @@
 #include "xfs_fsops.h"
 #include "xfs_notify_failure.h"
 #include "xfs_file.h"
+#include "xfs_ioctl.h"
 
 #include <linux/anon_inodes.h>
 #include <linux/eventpoll.h>
@@ -1140,6 +1141,48 @@ xfs_healthmon_show_fdinfo(
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
@@ -1148,6 +1191,7 @@ static const struct file_operations xfs_healthmon_fops = {
 	.read_iter	= xfs_healthmon_read_iter,
 	.poll		= xfs_healthmon_poll,
 	.release	= xfs_healthmon_release,
+	.unlocked_ioctl	= xfs_healthmon_ioctl,
 };
 
 /*


