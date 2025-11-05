Return-Path: <linux-fsdevel+bounces-67044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE164C338BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 404B94F2A8C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2991223E35E;
	Wed,  5 Nov 2025 00:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htN4IJz2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8618B2248A4;
	Wed,  5 Nov 2025 00:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762304034; cv=none; b=KVEuCCSDfz5yhd47mz7dAyLqJyvBbrnPTM6DiMqce3c1GtQ67PyD78bH4+DksUD0DuhcDj7gUeRQp62AxqfthYY+prlZXMrySh++NK17AC4RUBx8UM8dMgO+8c0DDhDSSJUKVB1GCRsT/9CXxi7Fzyh+A55odzRaPCiTuFstgCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762304034; c=relaxed/simple;
	bh=8Fb7Y0S7KNsIkR7KnjyxQysnHZyuINnRhoMdeYIBi6M=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NGb+I2rDCTnhyqfZqE+M5hGU3X1TLfJaDcDFeOUbn8t2ANBjf3L9HqMXdADGa9Rs0VcoKDAH84fkwGSMBeRwpcaSm3qjzBQ5RUlR/5r+iBTXHeDnbYqO/wQFcNI32iM+sASnAzyashx1+Qh9WOqSWYFzA6P9/N/sJXovSiZFwno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htN4IJz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABC0C116B1;
	Wed,  5 Nov 2025 00:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762304034;
	bh=8Fb7Y0S7KNsIkR7KnjyxQysnHZyuINnRhoMdeYIBi6M=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=htN4IJz22Rcm+CaPal4cafJ4/wGEyyKjgUfpHxfJu3nvynN8G0TGs9LY9MBcPL/6Z
	 yo64JUCNWGhLWyUGsH5jer0D15lzhRCN4UBhjpHN58aEyhpXNzSRW2fqUr+icrbJ7K
	 2MylflJTGlqZBtJBBB0esqE35seg70QjAxrWc/mpdUDkYUgZSe9xw34A7uXPIEzf8j
	 oepgMzg3bSPgvc3sQKe0Is7GIif83+fdIc+IKBs5jVjicG58Dfzb6G23rnyfC4pTgX
	 YA2B/77F+Xw/o6RCmkp2RgGnUBIgdkoy4QNz+uqOpAvfbuT3gf+r22OSo/Np8w60N1
	 dvfNlgTYxSGMQ==
Date: Tue, 04 Nov 2025 16:53:53 -0800
Subject: [PATCH 21/22] xfs: restrict healthmon users further
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176230366149.1647136.13839257774005333441.stgit@frogsfrogsfrogs>
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

Because health monitoring events include file handles and deep
information about the filesystem structure, restrict usage to healthmon
to processes that can open the root directory and run in the initial
user namespace.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_healthmon.h |    4 ++--
 fs/xfs/xfs_healthmon.c |    9 ++++++++-
 fs/xfs/xfs_ioctl.c     |    2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)


diff --git a/fs/xfs/xfs_healthmon.h b/fs/xfs/xfs_healthmon.h
index 1ce49197262b1c..6b650ab0c92238 100644
--- a/fs/xfs/xfs_healthmon.h
+++ b/fs/xfs/xfs_healthmon.h
@@ -99,10 +99,10 @@ struct xfs_healthmon_event {
 };
 
 #ifdef CONFIG_XFS_HEALTH_MONITOR
-long xfs_ioc_health_monitor(struct xfs_mount *mp,
+long xfs_ioc_health_monitor(struct file *file,
 		struct xfs_health_monitor __user *arg);
 #else
-# define xfs_ioc_health_monitor(mp, hmo)	(-ENOTTY)
+# define xfs_ioc_health_monitor(file, hmo)	(-ENOTTY)
 #endif /* CONFIG_XFS_HEALTH_MONITOR */
 
 #endif /* __XFS_HEALTHMON_H__ */
diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index b46b63e62d5143..a8ea6483ca98fb 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -1337,18 +1337,25 @@ static const struct file_operations xfs_healthmon_fops = {
  */
 long
 xfs_ioc_health_monitor(
-	struct xfs_mount		*mp,
+	struct file			*file,
 	struct xfs_health_monitor __user *arg)
 {
 	struct xfs_health_monitor	hmo;
 	struct xfs_healthmon		*hm;
 	struct xfs_healthmon_event	*event;
+	struct xfs_inode		*ip = XFS_I(file_inode(file));
+	struct xfs_mount		*mp = ip->i_mount;
 	int				fd;
 	int				ret;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (ip->i_ino != mp->m_sb.sb_rootino)
+		return -EPERM;
+	if (current_user_ns() != &init_user_ns)
+		return -EPERM;
+
 	if (copy_from_user(&hmo, arg, sizeof(hmo)))
 		return -EFAULT;
 
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 7a80a6ad4b2d99..6c3eecabf09908 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1424,7 +1424,7 @@ xfs_file_ioctl(
 		return xfs_ioc_commit_range(filp, arg);
 
 	case XFS_IOC_HEALTH_MONITOR:
-		return xfs_ioc_health_monitor(mp, arg);
+		return xfs_ioc_health_monitor(filp, arg);
 	case XFS_IOC_MEDIA_ERROR:
 		return xfs_ioc_media_error(mp, arg);
 


