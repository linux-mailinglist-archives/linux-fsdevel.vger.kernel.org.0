Return-Path: <linux-fsdevel+bounces-58284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E07B5B2BE8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 12:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3261886838
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 10:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152D23218D9;
	Tue, 19 Aug 2025 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaYEIpqG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9181DC9B5;
	Tue, 19 Aug 2025 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598160; cv=none; b=S8cnIN+HrEjlsVwNkRuHfOI0caz279kQ2PO6UEsc1Rj4TXUPdmR4SUeW/DWJ9c48H4uA5UHU2iatFmPN6BWd6x8PHRbviO/XPP+BtwLlBJIjwoqqzeTcn0VPgjJ+H5/kJe40IPXtv4iG1LGQBbuQ6tpWL/gqUXQDgyUCUq9C6Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598160; c=relaxed/simple;
	bh=KVGjnEavjlxs1ctpfC8ZgFHU/UuaJ9aP52A4mz7tWA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d5cFKCR5eyw3DEtKej2aBate8AYWJNriAXPGRABfA1X/NL9Ur49wYr6IkVNAtkZ7236W+uTKTOU7pmV9fbwM8tEy/eFQLzdkrpj9BTgM7CRGQJoltkj/vNcjuWRAJrWfe+IKlYxGhpeJdxcLfyxQ2kP/kq2YWA1mJeSYZia3tcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaYEIpqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BED0C4CEF1;
	Tue, 19 Aug 2025 10:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755598160;
	bh=KVGjnEavjlxs1ctpfC8ZgFHU/UuaJ9aP52A4mz7tWA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YaYEIpqGz7UItd0y42YWhnOifErwpfrmVPxrHHzC7B9+TphzsFG0jun+BCKr1s52u
	 tqxJ+DtYLulz+CUn/glYm4Vpw8KBtL8hPvN+b2yvK4UVHkCwUvrs5IG/fNbFqZQ34m
	 TYyRsl6U4I1IhVo4QMLXf8JIrQV8FgKj6LZnm2R40zFO3o+2k7/yVY75FWRM61Z0RK
	 Ik85KiMUOwj8iubxcJFpQCVH/FwMD/heRi/9r/fTPkQ879dA1Qv2y0cjytb5ulg/dE
	 7KNqsTM78fEEez4DKFP1bnQ+oIJB5oC7CJFy9T3+LUJbgA13qzFQjSLpWIorfpU/zl
	 ReZqc/LpJTwnQ==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net
Subject: [PATCH] kernfs: don't fail listing extended attributes
Date: Tue, 19 Aug 2025 12:08:58 +0200
Message-ID: <20250819-ahndung-abgaben-524a535f8101@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250819-tonstudio-abgas-7feaac93f501@brauner>
References: <20250819-tonstudio-abgas-7feaac93f501@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2099; i=brauner@kernel.org; h=from:subject:message-id; bh=KVGjnEavjlxs1ctpfC8ZgFHU/UuaJ9aP52A4mz7tWA8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQs8XX9+/vXVyuuE8HZgbMTryipX7LjbFAoZHu7IPh50 L13H8t+dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyk4Rwjw49LznUpt8Tib+Ym TZw8+dr91tlRTz88FYrfb3zG1tSF3Znhr7R+T0/mGtM7YnKbOWbkFL0Tq5Vxqr7v7/1O5X3UkZ3 HuQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Userspace doesn't expect a failure to list extended attributes:

  $ ls -lA /sys/
  ls: /sys/: No data available
  ls: /sys/kernel: No data available
  ls: /sys/power: No data available
  ls: /sys/class: No data available
  ls: /sys/devices: No data available
  ls: /sys/dev: No data available
  ls: /sys/hypervisor: No data available
  ls: /sys/fs: No data available
  ls: /sys/bus: No data available
  ls: /sys/firmware: No data available
  ls: /sys/block: No data available
  ls: /sys/module: No data available
  total 0
  drwxr-xr-x   2 root root 0 Jan  1  1970 block
  drwxr-xr-x  52 root root 0 Jan  1  1970 bus
  drwxr-xr-x  88 root root 0 Jan  1  1970 class
  drwxr-xr-x   4 root root 0 Jan  1  1970 dev
  drwxr-xr-x  11 root root 0 Jan  1  1970 devices
  drwxr-xr-x   3 root root 0 Jan  1  1970 firmware
  drwxr-xr-x  10 root root 0 Jan  1  1970 fs
  drwxr-xr-x   2 root root 0 Jul  2 09:43 hypervisor
  drwxr-xr-x  14 root root 0 Jan  1  1970 kernel
  drwxr-xr-x 251 root root 0 Jan  1  1970 module
  drwxr-xr-x   3 root root 0 Jul  2 09:43 power

Fix it by simply reporting success when no extended attributes are
available instead of reporting ENODATA.

Fixes: d1f4e9026007 ("kernfs: remove iattr_mutex") # mainline only
Reported-by: André Draszik <andre.draszik@linaro.org>
Link: https://lore.kernel.org/78b13bcdae82ade95e88f315682966051f461dde.camel@linaro.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/kernfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 3c293a5a21b1..457f91c412d4 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -142,9 +142,9 @@ ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size)
 	struct kernfs_node *kn = kernfs_dentry_node(dentry);
 	struct kernfs_iattrs *attrs;
 
-	attrs = kernfs_iattrs_noalloc(kn);
+	attrs = kernfs_iattrs(kn);
 	if (!attrs)
-		return -ENODATA;
+		return -ENOMEM;
 
 	return simple_xattr_list(d_inode(dentry), &attrs->xattrs, buf, size);
 }
-- 
2.47.2


