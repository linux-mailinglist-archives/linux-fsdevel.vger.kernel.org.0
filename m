Return-Path: <linux-fsdevel+bounces-69560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75016C7E405
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 250FE3A5314
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72360227B83;
	Sun, 23 Nov 2025 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRCLJ6z9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE59119F40A
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915697; cv=none; b=sNqNPQKV5VuoGB+Vw8d198ai6D35KkuFOKRRpOWR/ia8Ai3odzL77459JrT+2U4j7C0Q8I+hq5Wf/OzWfqADJVZKN2x67Z1wTz6E4XCHb1ADDEu8ASgrj4bN0eyv5V76N23Lzw+QN14SJXU5MT9dBXjWhGoWCU2KO1Zw5bS7Sno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915697; c=relaxed/simple;
	bh=7loW999M62tTx932lXLjik7Bbwyfcw5a7A3/My5g5vg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H0r8Fx2gfjCrp40UxvOMzccrTA6dugu1J8+hHffKyVmdR/8NOQpwxZtewC7uSHamuRvM5VJoxU49hJFZOnl/PnZH3tG0pvaxxc8ddoD7+TK/B00y624X/aEz2wvib6cdzMocDwgCfAc/WGMh6WuVr3A3N7D+6MKoNMl6fhsCoNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRCLJ6z9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABE2C113D0;
	Sun, 23 Nov 2025 16:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915697;
	bh=7loW999M62tTx932lXLjik7Bbwyfcw5a7A3/My5g5vg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sRCLJ6z9qEKgvyAu1FoWhAgNwLjbu53RhxMbznBSDxNfXkVJ8H5YHzH8bBltThEoX
	 T+r+PfVWL8AYXixIHJKxM72kYk7ohC3IJgdrRt34Uhihz54wTwFYPLAqboh6JMzUNt
	 GucjZRw80LAJEvcjsTKjPUDEnU6xtfGGd0L1VdOG2PZTOxrccNh6fq6vvLF2PRVXiG
	 REoSvNTdcCDa5fiePWgaVzMRIM49Lf4qnj4GRisubzVamrFLF4wXlFOqp09JyZIdl6
	 kkR8OW7A/HmhOVKbWPw3IoeixE8UJGU3lc+jlcDELtCPg75iWu54Jf6XjrNIjEClyc
	 GZ/QcutL4F6dg==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:56 +0100
Subject: [PATCH v4 38/47] gpio: convert linehandle_create() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-38-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2378; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7loW999M62tTx932lXLjik7Bbwyfcw5a7A3/My5g5vg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0erK+89f3b6cQW/5W2/p7g8Pe72VeSH7svl5fMzg
 9zlO68ydJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk/lRGhgv7dk56IVxTd/Mi
 g+s7X991kkcu67xlmWw/52wTn8TTiDMM/6Per52x9fDPv0/y1WN+icUfsNu990bWHXXxP0d6Ps2
 xX8kAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/gpio/gpiolib-cdev.c | 58 +++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 34 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 175836467f21..d24cae0c0022 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -298,12 +298,32 @@ static const struct file_operations linehandle_fileops = {
 #endif
 };
 
+static int linehandle_fd_create(struct gpio_device *gdev,
+				struct linehandle_state *lh,
+				struct gpiohandle_request *handlereq,
+				void __user *ip)
+{
+	FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
+		   anon_inode_getfile("gpio-linehandle", &linehandle_fileops,
+				      lh, O_RDONLY | O_CLOEXEC));
+	if (fdf.err)
+		return fdf.err;
+
+	handlereq->fd = fd_prepare_fd(fdf);
+	if (copy_to_user(ip, handlereq, sizeof(*handlereq)))
+		return -EFAULT;
+
+	dev_dbg(&gdev->dev, "registered chardev handle for %d lines\n", lh->num_descs);
+
+	fd_publish(fdf);
+	return 0;
+}
+
 static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 {
 	struct gpiohandle_request handlereq;
 	struct linehandle_state *lh;
-	struct file *file;
-	int fd, i, ret;
+	int i, ret;
 	u32 lflags;
 
 	if (copy_from_user(&handlereq, ip, sizeof(handlereq)))
@@ -377,41 +397,11 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 			offset);
 	}
 
-	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
-	if (fd < 0) {
-		ret = fd;
+	ret = linehandle_fd_create(gdev, lh, &handlereq, ip);
+	if (ret)
 		goto out_free_lh;
-	}
-
-	file = anon_inode_getfile("gpio-linehandle",
-				  &linehandle_fileops,
-				  lh,
-				  O_RDONLY | O_CLOEXEC);
-	if (IS_ERR(file)) {
-		ret = PTR_ERR(file);
-		goto out_put_unused_fd;
-	}
-
-	handlereq.fd = fd;
-	if (copy_to_user(ip, &handlereq, sizeof(handlereq))) {
-		/*
-		 * fput() will trigger the release() callback, so do not go onto
-		 * the regular error cleanup path here.
-		 */
-		fput(file);
-		put_unused_fd(fd);
-		return -EFAULT;
-	}
-
-	fd_install(fd, file);
-
-	dev_dbg(&gdev->dev, "registered chardev handle for %d lines\n",
-		lh->num_descs);
-
 	return 0;
 
-out_put_unused_fd:
-	put_unused_fd(fd);
 out_free_lh:
 	linehandle_free(lh);
 	return ret;

-- 
2.47.3


