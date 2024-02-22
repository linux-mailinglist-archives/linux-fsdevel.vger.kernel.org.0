Return-Path: <linux-fsdevel+bounces-12421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FD285F1C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 08:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F65228327D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 07:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F87117BA2;
	Thu, 22 Feb 2024 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="kfpfrpSn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536F4FBF4;
	Thu, 22 Feb 2024 07:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708585705; cv=none; b=fmU1zrJOudW0bPtaMZadLdgkSLprR7tYKkge/XFmqPcput0cnbjEDYfogjI+u+04OC10zvEhU0uLQJ2kzwLEiK8KmkRjgH5Cp/R5id6zryxy2v6l793trWN/SRGCPn3hNlGHS8UgxkXeMTA73p/BULKfg9ViIKwhqaxBIvYeedw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708585705; c=relaxed/simple;
	bh=4zCBJsh7fJS40bmuhRJsZyTvqmWDnPyWNdh+rXA5TBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PNN/hJkXbVU+9gzBgDnwsGZAaUVn+lWvqGhd9R4hhbjNX/Wk5m27/ATumhNgd0ki7tnzeZYB8WIXORPaqWMD/GYjHS+Ufx4uZwHxnl1lDuXKqE4y6maCZv+4wdM+QhSVfAW48uSBjDn7PY0SyECc/wAhm80XfP37aSboSWc9qJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=kfpfrpSn; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1708585697;
	bh=4zCBJsh7fJS40bmuhRJsZyTvqmWDnPyWNdh+rXA5TBE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kfpfrpSn5Sosahn9w0/N4Hwunvz/qC0SqCcA70XH9LYfF11Y1Bvyz/e2FzgXTVI80
	 D89tkTexwvJib32t8Nl+fWegmBEnjtoxweReaKb2iXzisfkAraIAMuHBgU9eAfTww1
	 u7QLIfFaam4nk6FIYvVD656XrP7G0Uta9mIg2B0Y=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 22 Feb 2024 08:07:39 +0100
Subject: [PATCH 4/4] sysctl: remove unnecessary sentinel element
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240222-sysctl-empty-dir-v1-4-45ba9a6352e8@weissschuh.net>
References: <20240222-sysctl-empty-dir-v1-0-45ba9a6352e8@weissschuh.net>
In-Reply-To: <20240222-sysctl-empty-dir-v1-0-45ba9a6352e8@weissschuh.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708585698; l=791;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=4zCBJsh7fJS40bmuhRJsZyTvqmWDnPyWNdh+rXA5TBE=;
 b=WV3z1hGVhUXi4muzHz37oKOsSKmI58FcQqf5wS6HJGnQ+1+6bAHJbYjCw1dcDstuNx872V0W9
 QP2m1pZzqyFBT/bAmcNoZ6/2Z3Nv6g6kx4zPCXWQul/wG9igeJlNI6V
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The previous commits made this sentinel element unnecessary, remove it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/proc/proc_sysctl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 4cdf98c6a9a4..7c0e27dc3d9d 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -30,9 +30,7 @@ static const struct file_operations proc_sys_dir_file_operations;
 static const struct inode_operations proc_sys_dir_operations;
 
 /* Support for permanently empty directories */
-static struct ctl_table sysctl_mount_point[] = {
-	{ }
-};
+static struct ctl_table sysctl_mount_point[] = { };
 
 /**
  * register_sysctl_mount_point() - registers a sysctl mount point

-- 
2.43.2


