Return-Path: <linux-fsdevel+bounces-72426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D709CF700E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 08:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E660301C3CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 07:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A5F309F02;
	Tue,  6 Jan 2026 07:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGfPKLu1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1209D2C0307;
	Tue,  6 Jan 2026 07:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767683579; cv=none; b=eRVLZrqH1kcydDQEus0aer5Hq4LnrB3cqqOLWq5ETXvrzP+pfsDibqjBO2Z+Fg4Ud8lcsOC87KQRVfSciz6OD5JT1PiZoNZsUV6QjzNywcDDLqtz5Gy3kLFZXwaYz5V4BqEsq4yljQJR+S8++9xhlkFXE1GUQAuqN5RRGpllQjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767683579; c=relaxed/simple;
	bh=t5Lg9TEFy6Gt+0JiHRpLlEc6aQTRYvPweLyQ6vzD+Ag=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWUEsZ/qJ2MtNZ7waN0D8SUIHaGq76oC11pdgDfZTcXP/PRzmz0k7LT/9L9u7bH9LYuolU6AYU2oJJcTIriJT1J7pgFKV6lHqbzLFwrqoFg3wTPuPuu8Gy3Bu3LKJa5fiZs4+mgvFPkeIpeAoGdV61AvG1Ju+7kswjmplLBK4ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGfPKLu1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9295EC116C6;
	Tue,  6 Jan 2026 07:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767683578;
	bh=t5Lg9TEFy6Gt+0JiHRpLlEc6aQTRYvPweLyQ6vzD+Ag=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=eGfPKLu1WMXgJXundupiBGADYsYlhPP7yvBENgf3Pz6ZUSUE6BMOhGanCzwAv51Gh
	 SPKCJnc4Fowyca92TXI9uzJs2ouFIlqBBanjiMA0PiqmNwsgxzYgAuGnAQYi6x/tp9
	 yQ2gOTcUQx/QQFanri93AHVM2dDjUDUHkhhgf54kae6IOFx7fY9oeMfKti8YCsZFRj
	 A4IapHL0ZJkfwBuflnIBp3xd5PhfY2a/uiPiRgf/BwWxlNzn2cVZ4lnVNHpoObB3my
	 4bgzp3hnFqv3v2PxiyYaEoV5mP93yGd/1CcU+vn14lnsre8AYTqKKAn31d9oYm+HVF
	 0r5T0ldIqo5Ug==
Date: Mon, 05 Jan 2026 23:12:58 -0800
Subject: [PATCH 09/11] xfs: allow reconfiguration of the health monitoring
 device
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org
Message-ID: <176766637443.774337.12829092061320010420.stgit@frogsfrogsfrogs>
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

Make it so that we can reconfigure the health monitoring device by
calling the XFS_IOC_HEALTH_MONITOR ioctl on it.  As of right now we can
only toggle the verbose flag, but this is less annoying than having to
closing the monitor fd and reopen it.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_healthmon.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)


diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index 4e785c0120ccfb..1f1a2682659816 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -23,6 +23,7 @@
 #include "xfs_fsops.h"
 #include "xfs_notify_failure.h"
 #include "xfs_file.h"
+#include "xfs_ioctl.h"
 
 #include <linux/anon_inodes.h>
 #include <linux/eventpoll.h>
@@ -1131,12 +1132,55 @@ xfs_healthmon_show_fdinfo(
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


