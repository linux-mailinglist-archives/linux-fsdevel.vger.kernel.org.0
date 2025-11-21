Return-Path: <linux-fsdevel+bounces-69440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 590D8C7B355
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB1874EB23E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA623546E0;
	Fri, 21 Nov 2025 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PD13/yiC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EE2350D4D
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748140; cv=none; b=Sk/Cz3kYWOTeWygL64LHFSmoNsbyveYV4H1fBhljyjGG7M6N5DQ+ZtNoY0oxLQ2a9WR0ian2cj8s69VB6qW8s2Xwvc6d36de5hCeUNgo0chaCK+KAYrSs2dmI5gGURXjMGHijwgo34UvobVTWaw59CI0vrmMbYfqbcaUk6jPN9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748140; c=relaxed/simple;
	bh=YdKu9HrdcJo+olzrZWt2lJmHipf8mk3ZbAxLcKE4o2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mvA1CWn7C+yQ34cyrFE/+aWuTEYH23WqEddGOfVkEH8VIbTJG8aHWRqlqb5vatKrkO51n4ANQh70VGTMRLQTvb+VSVDPkVmcJ729SpL2pgdOqQiaDACUuyXalcuZQg2pZ1MXhcGx6fLOoSAIXE5qFpT+87iPahMNHdqkSZfOKBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PD13/yiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83ACEC116C6;
	Fri, 21 Nov 2025 18:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748140;
	bh=YdKu9HrdcJo+olzrZWt2lJmHipf8mk3ZbAxLcKE4o2I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PD13/yiCITsAwqoRAr69HotBbViMu1tLL0gtbapnXUbVYIiDrtRuT9q11kCcHWAKP
	 d2aZpKORjtsrux+8Mk69R2v34xmuNLcC4PRttYqml0r/UeHlw2hXcuTLw4V8H4LGAx
	 fGUtm39W6G239/2pgn64lfs3cJcBM3R7L0koCqlrQsIIFYAWXqDW9u7zcQJ2yRjdSA
	 VxuUx+3hgkBqy8OB8+Z2MWKDRdbnmhWdIDQhDFQQZG+TXjQRjOzvrnleTy2vPuboPZ
	 BF0LAJBEMzLfXrvPxSzA1JD9mzNC8q3ngtf8LUFQa+G2AXOONDzFxXLun4EsdKRk5E
	 M2BqxbTlwvfEw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:21 +0100
Subject: [PATCH RFC v3 42/47] tty: convert ptm_open_peer() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-42-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1481; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YdKu9HrdcJo+olzrZWt2lJmHipf8mk3ZbAxLcKE4o2I=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLioXftEqX+m1VQLnqnfqh/vNEvk2yJ9obuhZVlAB
 //GQD3bjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIncCmBkOCvz0iDUcL0YQ6q8
 EENM8KM0vSWVawV3xx9xdeEM2qb/iuEPX33NC4Z/OtFd1fsZPqppR/85MCmx4f/6rg8fEy+smP2
 JAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/tty/pty.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 8bb1a01fef2a..f9dd2209cc7b 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -601,42 +601,26 @@ static struct cdev ptmx_cdev;
  */
 int ptm_open_peer(struct file *master, struct tty_struct *tty, int flags)
 {
-	int fd;
-	struct file *filp;
-	int retval = -EINVAL;
+	int ret;
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
+	FD_PREPARE(fdf, flags, dentry_open(&path, flags, current_cred()));
+	ret = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (ret) {
+		mntput(path.mnt);
+		return ret;
 	}
 
-	fd_install(fd, filp);
-	return fd;
-
-err_put:
-	put_unused_fd(fd);
-err:
-	return retval;
+	return fd_publish(fdf);
 }
 
 static int pty_unix98_ioctl(struct tty_struct *tty,

-- 
2.47.3


