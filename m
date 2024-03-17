Return-Path: <linux-fsdevel+bounces-14610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A1687DEA7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DAC7B210BA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830F94C84;
	Sun, 17 Mar 2024 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UW9yt7iK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8A81CD13;
	Sun, 17 Mar 2024 16:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693121; cv=none; b=tk5+gn4ffb5BDgsMMZkVb50SeH044su0Hp/xlrfi9/aPO0S+q7J2UBzY6PNuMtqVRhXVL3xzgBdgOESY4qgwa8sKuQOzDM6DP3ihBdhPZkm1X1ehyYhmsLajfbO7khIGv5iHTsv36vdvdKhLfLd8vH8SYc8SejQaYsx573xs5hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693121; c=relaxed/simple;
	bh=hfNdyLjE0iccOAS0uu/YAdIUW0G4z5hO8bo6TEkRMsk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NbOFhVrhRmIyMkGNRabuV5srcF/tr28wTNLtxdElgeBVHrebz4LzX9nGwLgfNxeWlb6QxUuujDgG6e32vfMIsaAeaCpqoL5JBq+W4P7wCluuX+r8Fihc2J2nOHuX8gkoodxfI+p/hpQzJ384ATGW1R0MnqOhqBpVUWbwbqr5yas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UW9yt7iK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE206C433C7;
	Sun, 17 Mar 2024 16:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693120;
	bh=hfNdyLjE0iccOAS0uu/YAdIUW0G4z5hO8bo6TEkRMsk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UW9yt7iKAojHVHTga1fTtUjGhWvHzJ5pX4KJ/wIhHknWAPa7jm8762UIHTIS1iKBL
	 QkbxqA3/T0/S87HU4t7BUs8LQCh/agTorGx8N+e45TaK2ii2NdGNbX3DMuIbqPWz19
	 gvQKbm77yX/JShbYbYSwv2rBEdlAN96NDre+WtMJgFpBr67+sFk0wR3Oib6MlrxIQC
	 XfUMEgQTAyMtAKszvhe9CnEhlPNNCqMEJ8H7tYBeq9akWc9YYfTF17FNX3c+FaYDe2
	 URsp6meGwPuKA+NVuPRNn9xvv6MqhkPs0Fgnqc+cDizWcCXEs1fiYK93sXBD8ckkfb
	 8WOdz+YdPIPWQ==
Date: Sun, 17 Mar 2024 09:32:00 -0700
Subject: [PATCH 33/40] xfs: add fs-verity ioctls
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069246438.2684506.7350688709329720774.stgit@frogsfrogsfrogs>
In-Reply-To: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Andrey Albershteyn <aalbersh@redhat.com>

Add fs-verity ioctls to enable, dump metadata (descriptor and Merkle
tree pages) and obtain file's digest.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: remove unnecessary casting]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_ioctl.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)


diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index ab61d7d552fb..4b11898728cc 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -43,6 +43,7 @@
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/fileattr.h>
+#include <linux/fsverity.h>
 
 /*
  * xfs_find_handle maps from userspace xfs_fsop_handlereq structure to
@@ -2174,6 +2175,21 @@ xfs_file_ioctl(
 		return error;
 	}
 
+	case FS_IOC_ENABLE_VERITY:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_enable(filp, arg);
+
+	case FS_IOC_MEASURE_VERITY:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_measure(filp, arg);
+
+	case FS_IOC_READ_VERITY_METADATA:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_read_metadata(filp, arg);
+
 	default:
 		return -ENOTTY;
 	}


