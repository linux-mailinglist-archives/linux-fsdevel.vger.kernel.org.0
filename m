Return-Path: <linux-fsdevel+bounces-69430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6DBC7B2F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA113A1D44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9520351FB1;
	Fri, 21 Nov 2025 18:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOI/TGXJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231A22D481F
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748119; cv=none; b=MpX9O5F9+Sv6lhTGYJr2DHW0LyJUcPlw3ukhmvVHQTQiagI8Sa2WEuWzQt5ZgGxYMK4aWzcD+uhlpx2rMy28M4ai8woVdJdaab6MA/kX4QQnvI8kbI0qix61My0qWcRI9Qd4YlmKqtw6q6HMdGNmv3eZh1R/DwPGSlAb+DBDFcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748119; c=relaxed/simple;
	bh=DkGukdz/p2Dp7gmMf2bj7Cr5/80yvvJoXoMjV0ssl+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TSN1NKNRB4Yfcf8vu7FqAP+bWJ/LvW4EfpqMXS60Q7/CGZZyNE+z4UsHMCFrDLbvpfIljic3fzcig4rErdsFV/s156aPHZugYeEVHLc9eZRIk6Os54G/oheKw9eTdDTF+v43xpXY1yY5Yn80T06bEmYgmbP2YpoS9xjMWy16I+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOI/TGXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C888C116D0;
	Fri, 21 Nov 2025 18:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748119;
	bh=DkGukdz/p2Dp7gmMf2bj7Cr5/80yvvJoXoMjV0ssl+k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cOI/TGXJyUX3HuTyIiaE8bOEGypbgzvSQdnjqXCKVWqFwBpqcEBlysax8NubaZMl8
	 HUpoRZWAKGavEhnE76dS854Xx2jvIg5Cz9FkeQd5E6MJMX/jS8OPI4ArclhgD3fYqx
	 c9o95RUuj4itt22ajmBStUrsmEyiTaY7IX7lc45+HFcNMDY39CuCZRmO4xoMQY18qh
	 YztWhtdiQyl563j66qTH0XWy8YJNrdUxfAsw/PcUfaisPT8tNTBA0m/qs2SQhGCKY5
	 DWc+7VKwU4fw9zKUMR8+NN8GhTrZn51C5tUicZZyNh8RffkNItI7G46iZ9u91kYPQ/
	 OdrVIcfDQROwg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:11 +0100
Subject: [PATCH RFC v3 32/47] spufs: convert spufs_context_open() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-32-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=brauner@kernel.org;
 h=from:subject:message-id; bh=DkGukdz/p2Dp7gmMf2bj7Cr5/80yvvJoXoMjV0ssl+k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLjwxelIU8mTk0vNkqXlbGX2d6lGrwqovsSlWOdmn
 X6I+3B9RwkLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQO/2P4sdZT1Hy3miufl7L7
 sUX+i95nn59yi5/1hNU2s+tlRzjUGRmWCnR2zlsb09y5ccdq3kTjCzIlM1ZOP9eeKX5LRzOufD4
 TAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 7ec60290abe6..413076bc7e3f 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -268,21 +268,13 @@ spufs_mkdir(struct inode *dir, struct dentry *dentry, unsigned int flags,
 static int spufs_context_open(const struct path *path)
 {
 	int ret;
-	struct file *filp;
 
-	ret = get_unused_fd_flags(0);
-	if (ret < 0)
+	FD_PREPARE(fdf, 0, dentry_open(path, O_RDONLY, current_cred()));
+	ret = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (ret)
 		return ret;
-
-	filp = dentry_open(path, O_RDONLY, current_cred());
-	if (IS_ERR(filp)) {
-		put_unused_fd(ret);
-		return PTR_ERR(filp);
-	}
-
-	filp->f_op = &spufs_context_fops;
-	fd_install(ret, filp);
-	return ret;
+	fd_prepare_file(fdf)->f_op = &spufs_context_fops;
+	return fd_publish(fdf);
 }
 
 static struct spu_context *

-- 
2.47.3


