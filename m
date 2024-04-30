Return-Path: <linux-fsdevel+bounces-18249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FE98B68A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FA5FB209CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9528C10A35;
	Tue, 30 Apr 2024 03:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edn9rTxr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BFB101CE;
	Tue, 30 Apr 2024 03:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447760; cv=none; b=cG27q7apsaSRnazomZMUQGk55yYKCSjASzhddfDgmzJs+4pvvNH/R4C8Cer3o45xjXdH6vQZiH+HhiCdMOxaQyBa8Gyet6xLQGTPFCdvRkdYscbpHJp/qti6Fv3WJKT/dziwpm0FgWOFSv1kcnHI0knXeI98nYQz/UveyICEdDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447760; c=relaxed/simple;
	bh=4vzfS86MjAQUno/slKxlHnRiVAv9Xab9wuniBakN6gk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XlPAHm5tXfHSGmPNE3L3nie0+PGv6mr5/JbuGMQfk22kpElPD3Xm4kwGu8asLD+3g5m1neCAxKGQV4RtN3ESceB0uZPi3wgnJs1rhiQzYmJnOjH9CvuTaTWn/jds8tl3HUHI8tDxiOV95m5+itwUot9XqyMS/L2fCNdBEi1GDN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edn9rTxr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62AEC116B1;
	Tue, 30 Apr 2024 03:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447759;
	bh=4vzfS86MjAQUno/slKxlHnRiVAv9Xab9wuniBakN6gk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=edn9rTxrZ0joAK5dVExLunU0ll8kP+TK6MnTVloyrblaIZbAi+Gzn1xQLhHRmRp80
	 6WKJSQZbORU12skXe/x5H0SOebrxUgw+vs0for2jLz6rEkb3jkz+slKs7bG2GRHNsf
	 i0oauBQZpdnUaIjcvcJfXywOrwdfch64iihDppPe1gmrmuQhGM8xUWDnZgHfc0Ha1B
	 kMAbp3d2IY7To6gAjNcN4jT9faO4nwWjiH8td9rZ56dKCl+Y1JEMll1UWvz4SpEzzZ
	 QW+rEODWH8tM0K8fe+s1zeI14UP14c46b+PYJv/2H1y5qG+VkJbW7i/qVoIuwMyWSc
	 RJzRMwTj3nqBw==
Date: Mon, 29 Apr 2024 20:29:19 -0700
Subject: [PATCH 20/26] xfs: add fs-verity ioctls
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444680706.957659.16272601344091503994.stgit@frogsfrogsfrogs>
In-Reply-To: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
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
index 6eed1e52d3fde..b05930462f461 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -47,6 +47,7 @@
 #include <linux/fileattr.h>
 #include <linux/security.h>
 #include <linux/fsnotify.h>
+#include <linux/fsverity.h>
 
 /* Return 0 on success or positive error */
 int
@@ -1574,6 +1575,21 @@ xfs_file_ioctl(
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


