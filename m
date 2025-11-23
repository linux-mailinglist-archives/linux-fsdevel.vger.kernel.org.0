Return-Path: <linux-fsdevel+bounces-69533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7087FC7E3BA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3004A3A50F9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E092D9482;
	Sun, 23 Nov 2025 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhfLnXoN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B5E29993E
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915639; cv=none; b=kldZwe4Drb3kPmZfED5KV6Gx1qrHGp2CPu8e5m5xe4p4QqMZcYVLfmT3fBrvZn/8HPmY4fTW1LLcTw1MKc6b1gUmiamVFBnrqorQ6qtWFxg/7wbtLUFDCMumhQ6ANycPHUemP0mRdosW5eQm6vwoNTbS2hKMUgIEDK9shMYWncA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915639; c=relaxed/simple;
	bh=oGBDtb/rSOu0CmwmsvEU6DFYjr9Sg/qo+19H+7WaP/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B8vMa3nQX5PhkaZ57JAWMExorp457m1An+Bp9TxBp18Uu4JdV1HAkoZwDhiU78cS3IZALjf5I9e4xtuHe/or3VjKOLAFzjqUBzDOrGXvdLmBASSbKmRqSc3yxe4lZYHwf4f5X45HocrZxYURng43AoehUlCn1m9rQeSNhzwASeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhfLnXoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1686C19421;
	Sun, 23 Nov 2025 16:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915638;
	bh=oGBDtb/rSOu0CmwmsvEU6DFYjr9Sg/qo+19H+7WaP/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lhfLnXoNVHpF+fGVngHSJk6lensTM+sgPIyxfEkutRHTzI09MesVxYhz0TcIUJzp2
	 3YLBMrputEdKX6LFdbwoRfNQEA72OkvWNHMDQ31zNtmS4IuO16S46qxeXVrcXoVkmx
	 N82iRTSzM4A34x2FYEYE3BB2Xmm4yylndl6Trqe5/+oR9l7KSS9bFi6SKGv2IGzdq1
	 cye/f0AuU3Qd//0ryNUne5kT4olj8vFaVMMyx0untjiYuPQai+atCYZIMLz0B0tqAP
	 OvKT6LzB4lfhhrS1bSaduS7aGh5OKk1zM+TYIyUM1biLwY76Cq4n9dMXSF1TOToWeW
	 Uc10smlpiHdlg==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:29 +0100
Subject: [PATCH v4 11/47] autofs: convert
 autofs_dev_ioctl_open_mountpoint() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-11-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272; i=brauner@kernel.org;
 h=from:subject:message-id; bh=oGBDtb/rSOu0CmwmsvEU6DFYjr9Sg/qo+19H+7WaP/Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0fGnbKP45NOvfzh4D4PZg316+n5R5//OaXznffQ0
 8hdRxmNOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSIsjI0L7yf3SwTWbXW9m9
 Mz705YqF/ThXKMjnYHxux8OdCoLFFQz/7MOVp560/9GXvr0q8/MqPsGNARn3U6xn7+yqnOTpkr2
 MHQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/autofs/dev-ioctl.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
index d8dd150cbd74..ff67cd776812 100644
--- a/fs/autofs/dev-ioctl.c
+++ b/fs/autofs/dev-ioctl.c
@@ -231,32 +231,14 @@ static int test_by_type(const struct path *path, void *p)
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
+	return FD_ADD(O_CLOEXEC, dentry_open(&path, O_RDONLY, current_cred()));
 }
 
 /* Open a file descriptor on an autofs mount point */

-- 
2.47.3


