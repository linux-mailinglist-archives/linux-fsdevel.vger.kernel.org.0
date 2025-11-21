Return-Path: <linux-fsdevel+bounces-69409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EACF0C7B2B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 431CE3A3A14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AE434FF50;
	Fri, 21 Nov 2025 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWthMpmf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC0B27FB34
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748076; cv=none; b=rIk+zTq3fOYR6S8QT/FX0DnSfB+CeTCjb2SiDhqJB8wYBRb03BDrufd9QhiBrFpUszjKvhnQgM9omj6FGujsuFpiZYOJ52q9nbOxXls7IcLmiM/Z/2r/ZmsjoONkPLWlJTRS/iMcLQh9FnUgJhSRyE2ktqtbdrn9mi4sKk2tb6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748076; c=relaxed/simple;
	bh=ah5yG9KtS81/ZuZ55fgqmx/JkBzUCT0PcZE9UUZ5WOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D6ThECZx6dat4lE38Oh5p2K5KPfBMprOuJncB+8P4DczZ4Tr3Hi7vjdUPKh6jgUMatgSaCXAoxJzGBa5R/EycTEaXtRDMdqBwZJoP06uvBULYueHgXOl5596Q0ePA/sC3jKkbuQVPUi6SaKS4Tut1c7oJeTuCKdWq6jIk6I/z9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWthMpmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6018FC116D0;
	Fri, 21 Nov 2025 18:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748075;
	bh=ah5yG9KtS81/ZuZ55fgqmx/JkBzUCT0PcZE9UUZ5WOI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TWthMpmfY/p9IDhTsTdEAEjsUqSf8L9FRYOtNspCoKQ1x/V2M5DwJH62V9sJaYlHA
	 NEo80JDQiPRjLAzdqUTNumdz9PXDAcLMhNpsoMINIqXURVfhikSXl4N2XZdR2ApqzP
	 LrI1wnztz+z+eRMC55cvBur7B7TKk2AnaJOKVens/iFZZXC+6ZDIAiXV45QJ2DsLx0
	 vq9E2efdl54+ZZ5gAofedCvy60gZ0pxcc90w/RO+kk2HfIeXsUrUZ80wgLW3Mqej8s
	 OOsaDcIPbUY21hf51g9RxY2XRARGWx/rnFigid0cc+BN618FmYgClFuAsHcWDln9GS
	 9r0QI9Yg87nYQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:00:50 +0100
Subject: [PATCH RFC v3 11/47] autofs: convert
 autofs_dev_ioctl_open_mountpoint() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-11-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1374; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ah5yG9KtS81/ZuZ55fgqmx/JkBzUCT0PcZE9UUZ5WOI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrDg/ofjux/zOp00PuWeb7Z+4dMnPnzGsTo8Oefwve
 nrx7r0jlR2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATKdjP8D/ryIvda80jfAJz
 902qcuqQ6tm+ud3nxFLWCR5br37dpevP8E9J7bzYyh/Lf0f+Otv39rH2RqnL4UtmzpNeV/eA42K
 6WSoHAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/autofs/dev-ioctl.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
index d8dd150cbd74..11a706af13af 100644
--- a/fs/autofs/dev-ioctl.c
+++ b/fs/autofs/dev-ioctl.c
@@ -231,32 +231,18 @@ static int test_by_type(const struct path *path, void *p)
  */
 static int autofs_dev_ioctl_open_mountpoint(const char *name, dev_t devid)
 {
-	int err, fd;
-
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (likely(fd >= 0)) {
-		struct file *filp;
-		struct path path;
-
-		err = find_autofs_mount(name, &path, test_by_dev, &devid);
-		if (err)
-			goto out;
-
-		filp = dentry_open(&path, O_RDONLY, current_cred());
-		path_put(&path);
-		if (IS_ERR(filp)) {
-			err = PTR_ERR(filp);
-			goto out;
-		}
-
-		fd_install(fd, filp);
-	}
+	struct path path __free(path_put) = {};
+	int err;
 
-	return fd;
+	err = find_autofs_mount(name, &path, test_by_dev, &devid);
+	if (err)
+		return err;
 
-out:
-	put_unused_fd(fd);
-	return err;
+	FD_PREPARE(fdf, O_CLOEXEC, dentry_open(&path, O_RDONLY, current_cred()));
+	err = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (err)
+		return err;
+	return fd_publish(fdf);
 }
 
 /* Open a file descriptor on an autofs mount point */

-- 
2.47.3


