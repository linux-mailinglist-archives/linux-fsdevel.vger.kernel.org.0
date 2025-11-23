Return-Path: <linux-fsdevel+bounces-69564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE32C7E42C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9FCBF34A9CA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9982DAFD8;
	Sun, 23 Nov 2025 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YM+YI0ut"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5A619F40A
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915706; cv=none; b=QQh5YVuyZimCAYUwXq+9bJeq06/YEBUUr9+xDrWjYbBKsmhHZIxyrQg1tYbE88K1q+oC8bJa3Vvb0UmL5d35bDpHdZ9UrBHmM4hQDXKYJsv96yW00AUfNCc4hGIayvcJFQCHxXd6kJCZv1fhHbIHMBXGNbSF7Wuc9SK0zm2lqUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915706; c=relaxed/simple;
	bh=UpGwPQsUwhdPP7bXy5ERw5PDsH7W0+MeY4wLnReEOM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MgjPeCCgNpkX6G/8O1GtTtaG34sEufK6e5e4UwFNgiWrcYxvyPBzb0DAdzTlaUzTleTdJYAgyBQI7sQIbJX/H0sZ/xAOI5iPAqeOFpdnhWnZteuKhNqoi4mPk1vV3mEt7bTbm38mVi9qGtI+Qsws91HfVMxHwtaKC0wU3FWWtSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YM+YI0ut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE2AC113D0;
	Sun, 23 Nov 2025 16:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915706;
	bh=UpGwPQsUwhdPP7bXy5ERw5PDsH7W0+MeY4wLnReEOM0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YM+YI0ut4rNWUtcI79EpRYlf2XLGoGwrH7k5YSjpxfAaFKHW77VDzd7mzMzKEZTZE
	 kc3a4lLUvTU43hw3I9dYY6/ALF2V/tDSJ5BJqZGSGiD6lus30vPkeM+J1/VF/3piHS
	 vuaIsu4x4u4NQz0WMgr646rI4rRn8iHNxbyhkFsSMPbWUrqDESFD8Ymx4NVYVYqMND
	 +4aXJCdMzNTHSwBcT9Cb1X0Z7bpNG+ScfgYM5tj+oMEjIZS5z+zmabsvwThX4pKlIs
	 aswG7uxyRQ9gI75tfYwWLVOw3c7w1H7O1wq79JHjlHqu+6nUwtR3Z6fkjeYL/o1BK7
	 aOkc4iCKDbcMQ==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:34:00 +0100
Subject: [PATCH v4 42/47] tty: convert ptm_open_peer() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-42-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1373; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UpGwPQsUwhdPP7bXy5ERw5PDsH7W0+MeY4wLnReEOM0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0dfOsucULGCaaPF9ALf01emuMo2nmTi+DD1mfjNO
 vWvPhzmHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZLcLIsF7jss0lt1MCh0NZ
 JzbcfNHdHaXH/93s3aKQ6u2sup8/yzIyfDmgPb82ZI5YRB7rJaXP+yLyPGcudNKeP6UzprJqbmI
 EIwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/tty/pty.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 8bb1a01fef2a..e6249c2b5672 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -602,41 +602,21 @@ static struct cdev ptmx_cdev;
 int ptm_open_peer(struct file *master, struct tty_struct *tty, int flags)
 {
 	int fd;
-	struct file *filp;
-	int retval = -EINVAL;
 	struct path path;
 
 	if (tty->driver != ptm_driver)
 		return -EIO;
 
-	fd = get_unused_fd_flags(flags);
-	if (fd < 0) {
-		retval = fd;
-		goto err;
-	}
-
 	/* Compute the slave's path */
 	path.mnt = devpts_mntget(master, tty->driver_data);
-	if (IS_ERR(path.mnt)) {
-		retval = PTR_ERR(path.mnt);
-		goto err_put;
-	}
+	if (IS_ERR(path.mnt))
+		return PTR_ERR(path.mnt);
 	path.dentry = tty->link->driver_data;
 
-	filp = dentry_open(&path, flags, current_cred());
-	mntput(path.mnt);
-	if (IS_ERR(filp)) {
-		retval = PTR_ERR(filp);
-		goto err_put;
-	}
-
-	fd_install(fd, filp);
+	fd = FD_ADD(flags, dentry_open(&path, flags, current_cred()));
+	if (fd < 0)
+		mntput(path.mnt);
 	return fd;
-
-err_put:
-	put_unused_fd(fd);
-err:
-	return retval;
 }
 
 static int pty_unix98_ioctl(struct tty_struct *tty,

-- 
2.47.3


