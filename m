Return-Path: <linux-fsdevel+bounces-71598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53412CCA0E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 03:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BC98304FBB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 02:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E22277CB8;
	Thu, 18 Dec 2025 02:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjEPA7Xu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F5A274B55;
	Thu, 18 Dec 2025 02:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766023486; cv=none; b=S7FJLQtibT3zR231rLohSMHbJzk93zD98KnBtG2VNqDLYeL1gt5W/A05mvgHLiGOwyjrthUPDe5U6Qbk/hQaZEVxER7B4Q7N1Af/JAMVsAvH6FfM2ePSW/WPKRzKLBAgRBBYeBNN9wneXVIxNphxhyEJhrd7ux33tMWbXoQ7HiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766023486; c=relaxed/simple;
	bh=x+lp2h7J8V0qUVp6PhHsPNPQqoYXixSr5I2KaLJDBC8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JoOt1bCp5+U5FMivZMnddzGNba4UVjCgx+34MhZI2Cmuk2LlCHIyoHe9czKdO4bZ4BhrWryAXNBH7v6+MfFWsNbptMLWF1cvzA9/tXnE3SthpEZ3M2Mbd8T/phu/TAmrdJpi2grTR1zcjdTJKO2cCSCBkuPrLC06vch1DcJ0hd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjEPA7Xu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB7BC4CEF5;
	Thu, 18 Dec 2025 02:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766023486;
	bh=x+lp2h7J8V0qUVp6PhHsPNPQqoYXixSr5I2KaLJDBC8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jjEPA7XuxOOZgvmlYcu06V3apn3Y3CSjyixPTNx6bTu3enDbsAn5P68jDnica7e7d
	 owwNlzzjIQm1cSrviS0cYkAdbhMJ0pX89NiNSEy91MZufSkNchd78id5HlpCGxU/tI
	 j+7iYujdztzx/SKNhfFAfTzcJMnlW5OkTTU7jQLDvij+AriBuZFpn9RN888B1eogXq
	 vpQGe5usJaqiL+aRswjvTqXgo6yLtElN9A/ZFP6UfkNbHKyiYATgytxgUZDdxMHxJ1
	 qzEhdzPG16lBndHOJe9THVTkCJ3qBJ9KIhdnihfg1Zab6wReeiped4cYbaTJAocklH
	 NNJ/LKLhVcSKg==
Date: Wed, 17 Dec 2025 18:04:45 -0800
Subject: [PATCH 2/4] xfs: send uevents when major filesystem events happen
From: "Darrick J. Wong" <djwong@kernel.org>
To: brauner@kernel.org, djwong@kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de,
 linux-fsdevel@vger.kernel.org
Message-ID: <176602332548.688213.501157461742943815.stgit@frogsfrogsfrogs>
In-Reply-To: <176602332484.688213.11232314346072982565.stgit@frogsfrogsfrogs>
References: <176602332484.688213.11232314346072982565.stgit@frogsfrogsfrogs>
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
that we can trigger systemd services when major events happen.  This
enables us to create a udev rule that will start up xfs_healer whenever
a filesystem is mounted.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_fsops.c |    2 ++
 fs/xfs/xfs_super.c |   10 ++++++++++
 2 files changed, 12 insertions(+)


diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index b7c21f68edc78d..bd1022ecd2eb4c 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -27,6 +27,7 @@
 #include "xfs_metafile.h"
 
 #include <linux/fserror.h>
+#include <linux/fsevent.h>
 
 /*
  * Write new AG headers to disk. Non-transactional, but need to be
@@ -544,6 +545,7 @@ xfs_do_force_shutdown(
 		xfs_stack_trace();
 
 	fserror_report_shutdown(mp->m_super, GFP_KERNEL);
+	fsevent_send_shutdown(mp->m_super, &mp->m_kobj.kobject);
 }
 
 /*
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index bc71aa9dcee8d6..bd078c99389bc1 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -53,6 +53,8 @@
 #include <linux/magic.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/uuid.h>
+#include <linux/fsevent.h>
 
 static const struct super_operations xfs_super_operations;
 
@@ -1249,6 +1251,8 @@ xfs_fs_put_super(
 {
 	struct xfs_mount	*mp = XFS_M(sb);
 
+	fsevent_send_unmount(mp->m_super, &mp->m_kobj.kobject);
+
 	xfs_notice(mp, "Unmounting Filesystem %pU", &mp->m_sb.sb_uuid);
 	xfs_filestream_unmount(mp);
 	xfs_unmountfs(mp);
@@ -1972,6 +1976,11 @@ xfs_fs_fill_super(
 		goto out_unmount;
 	}
 
+	/*
+	 * Send a uevent signalling that the mount succeeded so we can use udev
+	 * rules to start background services.
+	 */
+	fsevent_send_mount(mp->m_super, &mp->m_kobj.kobject, fc);
 	return 0;
 
  out_filestream_unmount:
@@ -2217,6 +2226,7 @@ xfs_fs_reconfigure(
 			return error;
 	}
 
+	fsevent_send_remount(mp->m_super, &mp->m_kobj.kobject);
 	return 0;
 }
 


