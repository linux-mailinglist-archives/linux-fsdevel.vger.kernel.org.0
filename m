Return-Path: <linux-fsdevel+bounces-74056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A742FD2C1BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 06:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E3C3301996F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 05:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7D3347FD0;
	Fri, 16 Jan 2026 05:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnkdd9fh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197EC33F8A4;
	Fri, 16 Jan 2026 05:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768542263; cv=none; b=Dka+/F3Dunf4miAoUxGZTGYXjEMJwTnLw8xYy20VFtP0VSXRUfrjxPvAHDxOG60hhWQvJdftMOurMBpe+O97Qx+QnkTuqv4L2ZV4zEJUMIOhdbOzYw8ZR2gSzC5N7Js7IQx8YTAyRDQD+pRsNsmYZY0ZimaBB070BFWzmhpuyn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768542263; c=relaxed/simple;
	bh=VBE0BOb1Tvh8w9MhsVbgQ4KdftB6NlrORVTJEIAgahg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQsd32QhhChlbkO8dDW9EcK6UucLRU9TIp3vSBiBELnGWK+kHXC5oniroO80SvC6XHam6gXsbxwpH/Ltf7voJPmD7RqwEJ5N9j258Hdh8r0ODJosYqwSEOOsMI4fY4djXTrp6JubQ2iRplBOeNNoUhhKbBOZBSsJ+fWDWB75diE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnkdd9fh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0AFC116C6;
	Fri, 16 Jan 2026 05:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768542262;
	bh=VBE0BOb1Tvh8w9MhsVbgQ4KdftB6NlrORVTJEIAgahg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=rnkdd9fhMI223yfNx1Eah8ekdrLVM7rtfAHX6FsCSxuw8kf0JdOgSduY+5qt18k1E
	 mf1pwb4+9EKFJl5Aklm0Gw8ICH2ASxcnve2t++fmf1UhIMM0Sa8mjIeJ1i4yFceACs
	 UKOsYC8NW1NHGWmiLT5cc/ZsWWeKWgQHukPHTjHWJX0saSgxtrLdShJe7O3qKKsOpR
	 jCPWbNr1b56LHZPzdT43TtcaSajk+bFagBQL4nox4AJThXhCcMzVfSHNp3r031NhOL
	 E0TAGxW0lq+CyPZuyuIxKhfElAMh5Cj9c3+VqutfuC1139Z4WECoHvM+INc1CtFTWw
	 2Yuzbo0LVZbcg==
Date: Thu, 15 Jan 2026 21:44:22 -0800
Subject: [PATCH 09/11] xfs: allow toggling verbose logging on the health
 monitoring file
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: hch@lst.de, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 hch@lst.de
Message-ID: <176852588735.2137143.709760029441188307.stgit@frogsfrogsfrogs>
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

Make it so that we can reconfigure the health monitoring device by
calling the XFS_IOC_HEALTH_MONITOR ioctl on it.  As of right now we can
only toggle the verbose flag, but this is less annoying than having to
closing the monitor fd and reopen it.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_healthmon.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)


diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index 1bb4b0adf2470e..4a8cbd87932201 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -23,6 +23,7 @@
 #include "xfs_fsops.h"
 #include "xfs_notify_failure.h"
 #include "xfs_file.h"
+#include "xfs_ioctl.h"
 
 #include <linux/anon_inodes.h>
 #include <linux/eventpoll.h>
@@ -1066,12 +1067,55 @@ xfs_healthmon_show_fdinfo(
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


