Return-Path: <linux-fsdevel+bounces-71594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C3CCCA0BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 03:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E66F7304ED95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 02:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E422773F9;
	Thu, 18 Dec 2025 02:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlSS5lJe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88A2274B55;
	Thu, 18 Dec 2025 02:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766023424; cv=none; b=UMKFvskCH+4i3wLJ4gtCpu7O7UjDCiuzMji+Yjiy5aFUDd4qYfdAQT49A1AmoNb8J8I6a712bGVElq1/dsvecFCA850F63YKse2qoQSBUk9e+SW2SYm1+oTs+VtFyDLzINRtytlgiOQUJ3SmjwFhOZ25NZnUKh1B+fip/6Z3W80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766023424; c=relaxed/simple;
	bh=XHkADs3Bj+NcPG0WstSM60RfNisxDzVW7vlJSpqpJWw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ClTkkm4E7hsxO0Yd2lVjwfNq5ig6avS7MU7+yjRPUwh9uc3KMhL47ER0nVM5WqLaCP6acM16sa81eBKQb2JfBABh56mDsrpiJZ0DeFFDXQeJod66DYXezg9iRGmtrnj8YzC0D+CDAitS6PWutE03MzFeYgf8cbbcH3UR8RmLVnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlSS5lJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E34C4CEF5;
	Thu, 18 Dec 2025 02:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766023423;
	bh=XHkADs3Bj+NcPG0WstSM60RfNisxDzVW7vlJSpqpJWw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qlSS5lJeInPPQS+e6Xf59cfSnE3U+41U5KQYWtTORKYAdivDdceKJsBFJH7VFCnph
	 lKerd8g7PW9pwFrkjwn+mMmMTCj+DojInGlaIxmxJ49Hv/INFpUtH7va+U61qkrY2G
	 /EgD3jfcDwHZ2EDZtqC3mCDeRzbLz1HWx8qhg8F62AH/TDNHP/GcelaEdBE19xkMG8
	 3wO26y6M3vvjK1/bKZD02nTQc4qz+sg9sVgShAjmKdjenv13Do7JXcKlJl+zNdl6Yr
	 P0yavPAbRlxXKM7uJxfoS6tPGrtuM/Ymyj24r5EAiEGHuzz+KXzNhAacFUIpgv+eps
	 e2D5vEKPDkceQ==
Date: Wed, 17 Dec 2025 18:03:43 -0800
Subject: [PATCH 4/6] xfs: report fs metadata errors via fsnotify
From: "Darrick J. Wong" <djwong@kernel.org>
To: brauner@kernel.org, djwong@kernel.org
Cc: linux-ext4@vger.kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, gabriel@krisman.be, hch@lst.de,
 amir73il@gmail.com
Message-ID: <176602332214.686273.889498283534575167.stgit@frogsfrogsfrogs>
In-Reply-To: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
References: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Report filesystem corruption problems to the fserror helpers so that
fsnotify can also convey metadata problems to userspace.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_fsops.c  |    4 ++++
 fs/xfs/xfs_health.c |   14 ++++++++++++++
 2 files changed, 18 insertions(+)


diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index 0ada735693945c..b7c21f68edc78d 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -26,6 +26,8 @@
 #include "xfs_rtrefcount_btree.h"
 #include "xfs_metafile.h"
 
+#include <linux/fserror.h>
+
 /*
  * Write new AG headers to disk. Non-transactional, but need to be
  * written and completed prior to the growfs transaction being logged.
@@ -540,6 +542,8 @@ xfs_do_force_shutdown(
 		"Please unmount the filesystem and rectify the problem(s)");
 	if (xfs_error_level >= XFS_ERRLEVEL_HIGH)
 		xfs_stack_trace();
+
+	fserror_report_shutdown(mp->m_super, GFP_KERNEL);
 }
 
 /*
diff --git a/fs/xfs/xfs_health.c b/fs/xfs/xfs_health.c
index 3c1557fb1cf083..fbb8886c72fe5e 100644
--- a/fs/xfs/xfs_health.c
+++ b/fs/xfs/xfs_health.c
@@ -20,6 +20,8 @@
 #include "xfs_quota_defs.h"
 #include "xfs_rtgroup.h"
 
+#include <linux/fserror.h>
+
 static void
 xfs_health_unmount_group(
 	struct xfs_group	*xg,
@@ -111,6 +113,8 @@ xfs_fs_mark_sick(
 	spin_lock(&mp->m_sb_lock);
 	mp->m_fs_sick |= mask;
 	spin_unlock(&mp->m_sb_lock);
+
+	fserror_report_metadata(mp->m_super, -EFSCORRUPTED, GFP_NOFS);
 }
 
 /* Mark per-fs metadata as having been checked and found unhealthy by fsck. */
@@ -126,6 +130,8 @@ xfs_fs_mark_corrupt(
 	mp->m_fs_sick |= mask;
 	mp->m_fs_checked |= mask;
 	spin_unlock(&mp->m_sb_lock);
+
+	fserror_report_metadata(mp->m_super, -EFSCORRUPTED, GFP_NOFS);
 }
 
 /* Mark a per-fs metadata healed. */
@@ -198,6 +204,8 @@ xfs_group_mark_sick(
 	spin_lock(&xg->xg_state_lock);
 	xg->xg_sick |= mask;
 	spin_unlock(&xg->xg_state_lock);
+
+	fserror_report_metadata(xg->xg_mount->m_super, -EFSCORRUPTED, GFP_NOFS);
 }
 
 /*
@@ -215,6 +223,8 @@ xfs_group_mark_corrupt(
 	xg->xg_sick |= mask;
 	xg->xg_checked |= mask;
 	spin_unlock(&xg->xg_state_lock);
+
+	fserror_report_metadata(xg->xg_mount->m_super, -EFSCORRUPTED, GFP_NOFS);
 }
 
 /*
@@ -287,6 +297,8 @@ xfs_inode_mark_sick(
 	spin_lock(&VFS_I(ip)->i_lock);
 	inode_state_clear(VFS_I(ip), I_DONTCACHE);
 	spin_unlock(&VFS_I(ip)->i_lock);
+
+	fserror_report_file_metadata(VFS_I(ip), -EFSCORRUPTED, GFP_NOFS);
 }
 
 /* Mark inode metadata as having been checked and found unhealthy by fsck. */
@@ -311,6 +323,8 @@ xfs_inode_mark_corrupt(
 	spin_lock(&VFS_I(ip)->i_lock);
 	inode_state_clear(VFS_I(ip), I_DONTCACHE);
 	spin_unlock(&VFS_I(ip)->i_lock);
+
+	fserror_report_file_metadata(VFS_I(ip), -EFSCORRUPTED, GFP_NOFS);
 }
 
 /* Mark parts of an inode healed. */


