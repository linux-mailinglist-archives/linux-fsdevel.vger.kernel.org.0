Return-Path: <linux-fsdevel+bounces-73340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C18ED160D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 01:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50305309C13D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 00:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ECD258EDE;
	Tue, 13 Jan 2026 00:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGpTtmg2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851F3248F66;
	Tue, 13 Jan 2026 00:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768264317; cv=none; b=Yk79wKar5hANslX/3hx0H90gszuRk0OvlkuiVb0pnmW+9zw/3vTaLsM6GDKKN/Yjs4QKZY5d91AETuRafSzA2lZY0dP2F+41QyJ5r6ycCWLwSk5RMR3RK2UPGk92jpE97OgL3V18Bz2Tq4WVLUpTm+8LRFA0LsQmoT3/ZDTv3E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768264317; c=relaxed/simple;
	bh=UxoH+vL/Ya13WiG7VzQP63/6snVwREld40s/FB7evOo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBhbstz1neVTr/GBxGM/6Jte/t97YH4IqYOkaJziDgwYXzfAArPOveiSKw6EWhrLWnfoVU8FjdhGj+sd2WeUR7MiwoSomNMf0Rx/ODKWJmPz2vQBMb49XBZlS61bOfGkS2XxgUeex+POcidP0aryQbBC/2QnSqRP2hAd/sDh918=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGpTtmg2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186F3C116D0;
	Tue, 13 Jan 2026 00:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768264317;
	bh=UxoH+vL/Ya13WiG7VzQP63/6snVwREld40s/FB7evOo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=AGpTtmg2Tmtl2SOqw5g6p96tJSEiWhjeXQATuYX9yJZ1HAEPvN8UTPrKhYaBE6xdt
	 MdE+jj+IhI9/LxsTMCZDsyb3t+Wsu+ijBhexsjZ/lTHaXH1Jfy2VmrHhjTVwV3wSqD
	 HxhbGyfYgShX9YQ+Hl6NR4vrijD7M4eDR16yYzhKk7n6WCu2gKOUFKQ86w84ZJBrC6
	 4lYB/hKSyrbqLlxVDz21L+KxbacR9V7ID9uK5a0VVuOoN/pYP402GPkFIl25r/YLfQ
	 P7BlAR+ZIe/vou1eTa33BZ6+V5BqmDv+eLKhFEfs/OBzYQIA+5Na7YLY6g2A6bcE+U
	 XteIEBRzKez/g==
Date: Mon, 12 Jan 2026 16:31:56 -0800
Subject: [PATCH 4/6] xfs: report fs metadata errors via fsnotify
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, brauner@kernel.org
Cc: hch@lst.de, linux-xfs@vger.kernel.org, jack@suse.cz,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 gabriel@krisman.be, hch@lst.de, amir73il@gmail.com
Message-ID: <176826402652.3490369.2609467634858507969.stgit@frogsfrogsfrogs>
In-Reply-To: <176826402528.3490369.2415315475116356277.stgit@frogsfrogsfrogs>
References: <176826402528.3490369.2415315475116356277.stgit@frogsfrogsfrogs>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


