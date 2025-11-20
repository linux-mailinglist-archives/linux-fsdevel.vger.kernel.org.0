Return-Path: <linux-fsdevel+bounces-69290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED159C76828
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADF504E2F59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90692E62A9;
	Thu, 20 Nov 2025 22:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StdQInro"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1022E8DE2
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677960; cv=none; b=lFjcYQk9j3iIB9jvVtBxzPO8v+HiYtp1octalG/0HOL6lx2zLCXqyCzOPV0orYg4HyfB9d7Uzj4FZ7XWYeYcXgU/qUmZd4+AG/xHKi926MC74tE0UBvdXNUXjohuI9NISIp7JJU2FIH1ACTyCChrulTpv6rTUCvEtIDNJFuzo2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677960; c=relaxed/simple;
	bh=RtSKa/TUjVR6WyuZabvcE1/DpzZ8GC9D+o/FYGsI1q8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hWdPaPu+wUh/1UwDjkCHt6fbdf86u+evG1v8y4gkhzyh7ziapifEbulHsTEw6L6hC14TrB5iQBQaJNusG51wiBxNgufBzt2UQg855O+Z1mTrtzybtP9XiK8jMYO/YNfK4CF2mWTOTounZF3qlL7Ef3RxHwz3+TddVDmIisPh+FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StdQInro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DF2C113D0;
	Thu, 20 Nov 2025 22:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677960;
	bh=RtSKa/TUjVR6WyuZabvcE1/DpzZ8GC9D+o/FYGsI1q8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=StdQInroaTPbjuWKkcVVT3Ubl90r5kozpZHuv453KWsMVMVeyZv1qbKAVfhbLjAAE
	 HDscTMBWzS5g60M0fd6z3MZNlt5nNQLBv42fKPezq6kNet935aZELIhDN60epV5k4z
	 OIsVBoDFzshkYn2W9W0LYwUcwwmAnm7oZ8Atq9/yIfql+fiwhtSwBNq4bi6KtR21MI
	 EiF1V5PQt+32cp4QHegFll8mNqEpV3dOIIfcZQccA2LO7zKYIeZ4UVKbMS09/o3kEj
	 /1MEcZHHhxwVzyqbaoNJlDlJvohZDedND+VlxJDC+O7Y+sLz131fLQI1A8eAg6Qy1l
	 ulCVqYE44MC/w==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:08 +0100
Subject: [PATCH RFC v2 11/48] autofs: convert
 autofs_dev_ioctl_open_mountpoint() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-11-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1371; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RtSKa/TUjVR6WyuZabvcE1/DpzZ8GC9D+o/FYGsI1q8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3vjqdUSsqAp2+WtrGXtFYaQxuINaxd/9851W3tP1
 YFBReFqRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETelDAynLmf76hfpz41LDfD
 6tE2+zrFuGaBig8cTaXVPHx+X/cwMfzP6Z8U5WEmX+P2WWDpX5mO/wy5kxrvfE3sDvmneuestT4
 vAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/autofs/dev-ioctl.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
index d8dd150cbd74..35f1a49e5c1d 100644
--- a/fs/autofs/dev-ioctl.c
+++ b/fs/autofs/dev-ioctl.c
@@ -231,32 +231,19 @@ static int test_by_type(const struct path *path, void *p)
  */
 static int autofs_dev_ioctl_open_mountpoint(const char *name, dev_t devid)
 {
-	int err, fd;
+	struct path path __free(path_put) = {};
+	int err;
 
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (likely(fd >= 0)) {
-		struct file *filp;
-		struct path path;
+	err = find_autofs_mount(name, &path, test_by_dev, &devid);
+	if (err)
+		return err;
 
-		err = find_autofs_mount(name, &path, test_by_dev, &devid);
-		if (err)
-			goto out;
+	FD_PREPARE(fdf, O_CLOEXEC, dentry_open(&path, O_RDONLY, current_cred())) {
+		if (fd_prepare_failed(fdf))
+			return fd_prepare_error(fdf);
 
-		filp = dentry_open(&path, O_RDONLY, current_cred());
-		path_put(&path);
-		if (IS_ERR(filp)) {
-			err = PTR_ERR(filp);
-			goto out;
-		}
-
-		fd_install(fd, filp);
+		return fd_publish(fdf);
 	}
-
-	return fd;
-
-out:
-	put_unused_fd(fd);
-	return err;
 }
 
 /* Open a file descriptor on an autofs mount point */

-- 
2.47.3


