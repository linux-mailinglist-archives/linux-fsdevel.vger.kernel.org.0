Return-Path: <linux-fsdevel+bounces-15736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F294F892867
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82582B22F8D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D38522F;
	Sat, 30 Mar 2024 00:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnXl6RXR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0094A1D;
	Sat, 30 Mar 2024 00:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711759293; cv=none; b=OZY8+NPPkuUmHAz8yBgtjHsVLMdGjp6E7Pr5mhDIqMEPCTcRocIGpzj5qnDPGnYHaq0WtZ5wBh3nIuhXDNwMSln1YI0zXFDXErBzLp2MgW8zcNpAjMc4KXwhrnHh5b/sb7Pf/SkOhQaH4jQqkJDLgeme3wSqNzZcExw9Q/5K+xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711759293; c=relaxed/simple;
	bh=VR/zE9VYe39MFlp8LaXGtcIjtISby+Mj9e/1mxL7upU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zmqa9AaCEoVWVQueaPtAjax0vv7kJ8D1JJCExbf1+TslamHIfx3TmhbLddoXiRJB0Mupp+zXCCitJHOf4Qqs/dfHzAqh7i30rkhvyM5do2DZfoZofLEGFNk3DGIDELxGUuhVYd6pO+ULbOmp0/c33bS/u0uZcm7CDHxZLZyPDDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnXl6RXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350D0C433C7;
	Sat, 30 Mar 2024 00:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711759293;
	bh=VR/zE9VYe39MFlp8LaXGtcIjtISby+Mj9e/1mxL7upU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=TnXl6RXRXQ0Heaae9rp5zeKs2s0fzHR1fL5OJkYCu3OreJr8EMlvu1k9TERJylQ1V
	 d3iCOvymhBhqXdztntGoGoRuWMWxuF+FUHfr7FMTPvz37ls4aL18VVbF7sQOLM7MzX
	 HoViuEz4z3uOzaCfB3dDon+dZ2MXcAoMg/UccwNESutypohQYHj0vmTEPS+iClA3da
	 q5LsaldBSKq1p99xeayppHCNKEuu2s+CjQ8w6WOOnsQBeZNKehQXp74zD04ZWlSQWd
	 nR+JaeH1t4aRIlmgyNjob3bEBgG2AiihF/SKrKbjQJxIedi4QR7YG7BYTYkYondfag
	 vFEp2NviTkN0g==
Date: Fri, 29 Mar 2024 17:41:32 -0700
Subject: [PATCH 21/29] xfs: add fs-verity ioctls
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868908.1988170.3425887822039650099.stgit@frogsfrogsfrogs>
In-Reply-To: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
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
index 9d161e16ccf32..0aa0ceb9ec153 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -50,6 +50,7 @@
 #include <linux/fileattr.h>
 #include <linux/security.h>
 #include <linux/fsnotify.h>
+#include <linux/fsverity.h>
 
 /*
  * xfs_find_handle maps from userspace xfs_fsop_handlereq structure to
@@ -2711,6 +2712,21 @@ xfs_file_ioctl(
 	case XFS_IOC_MAP_FREESP:
 		return xfs_ioc_map_freesp(filp, arg);
 
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


