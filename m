Return-Path: <linux-fsdevel+bounces-69303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DB0C76888
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D9F5934935C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA84C2AF1D;
	Thu, 20 Nov 2025 22:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiQVAlsB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1395F30DEDA
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677985; cv=none; b=idM8+uQ2tNSkzoHEpMIxTx87TPZs8yMsIURpQbfa4SY0OqDHduQC1SLsOM9oMCG9V6yuTjijVr6ul9XxLSu3ZHapZHaO0Lq0vea52nqOYX8O5KtiL5gBO7fiA2RJtKZIE+EKODuZTt6ZtlLTQJj4mE7UY+hYVCQezIjEVrSj13s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677985; c=relaxed/simple;
	bh=iAr2rZbsZrom2toYZQ4gDLU2u+m42cBKmc/NoHJXkvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C5WFUZdqDlMumxV0PX8uVhl6m8ZBU9JRZCju/CPCjDinReJSBYA2OWit4wFrEDCYzZSSNLUyDHtd4xxtx+0e025IHXjgYBnsjDaIpPcm6bXs2mltWDNUQZoWf2VJMpM1gl8wrimY4+ADZDvtpfhv+hqBt51uZmTejrGVT0Lerw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiQVAlsB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0A2C4CEF1;
	Thu, 20 Nov 2025 22:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677984;
	bh=iAr2rZbsZrom2toYZQ4gDLU2u+m42cBKmc/NoHJXkvs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TiQVAlsBCy0q6qYI+lAdE+uDQGpmHpqiXkOPb5o0cwBEUBcPrnK/Z4GupN+CwsWqm
	 4j3PFDW/FdcuZqKZHGO9ehFRuRuxhryxIYvu8VdiXkvF8dPlIUBCRtv0j9GKZc1i+9
	 AsxakWtOiYG8p4xPe2eCqmj0gSQvgfAsn5fa9lOKbHkjTPM3rpjeJUI0JQek7FEHaw
	 cCVCDvZ1cP3a1rDSADcyFUrjYYt90EdeAyOyCqrv3LY8oi7yx9JK76kopv0jAj3DUW
	 wzuhvCyrt5RQHivqY1aqLS92vJmEg9jVsY8OFSj6xmDKWT+VAEtYBlGuDgb+1BUe7q
	 j+7HI1NahAIwQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:20 +0100
Subject: [PATCH RFC v2 23/48] ipc: convert do_mq_open() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-23-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2058; i=brauner@kernel.org;
 h=from:subject:message-id; bh=iAr2rZbsZrom2toYZQ4gDLU2u+m42cBKmc/NoHJXkvs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3vrzZldPkFUhuHa13Ozdrns5pxQKxfROcNIQ9/sZ
 nzENRGljlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImEhDIyTFd648nAFlvtc6xL
 e/tX832d3O8blbzCfV85/fh36+nGO4wMDYfM6mKkw9ocOnXuSnV91XyV8IL5i5NWm3+S8QQRjXQ
 OAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 ipc/mqueue.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 093551fe66a7..c17e983a2e6e 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -899,7 +899,7 @@ static int do_mq_open(const char __user *u_name, int oflag, umode_t mode,
 	struct dentry *root = mnt->mnt_root;
 	struct filename *name;
 	struct path path;
-	int fd, error;
+	int ret;
 	int ro;
 
 	audit_mq_open(oflag, mode, attr);
@@ -908,38 +908,36 @@ static int do_mq_open(const char __user *u_name, int oflag, umode_t mode,
 	if (IS_ERR(name))
 		return PTR_ERR(name);
 
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0)
-		goto out_putname;
-
 	ro = mnt_want_write(mnt);	/* we'll drop it in any case */
 	inode_lock(d_inode(root));
 	path.dentry = lookup_noperm(&QSTR(name->name), root);
 	if (IS_ERR(path.dentry)) {
-		error = PTR_ERR(path.dentry);
-		goto out_putfd;
+		ret = PTR_ERR(path.dentry);
+		goto out_unlock;
 	}
 	path.mnt = mntget(mnt);
-	error = prepare_open(path.dentry, oflag, ro, mode, name, attr);
-	if (!error) {
-		struct file *file = dentry_open(&path, oflag, current_cred());
-		if (!IS_ERR(file))
-			fd_install(fd, file);
-		else
-			error = PTR_ERR(file);
+	ret = prepare_open(path.dentry, oflag, ro, mode, name, attr);
+	if (ret) {
+		path_put(&path);
+		goto out_unlock;
 	}
-	path_put(&path);
-out_putfd:
-	if (error) {
-		put_unused_fd(fd);
-		fd = error;
+
+	FD_PREPARE(fdf, O_CLOEXEC, dentry_open(&path, oflag, current_cred())) {
+		path_put(&path);
+		if (fd_prepare_failed(fdf)) {
+			ret = fd_prepare_error(fdf);
+			goto out_unlock;
+		}
+		ret = fd_publish(fdf);
+		goto out_unlock;
 	}
+
+out_unlock:
 	inode_unlock(d_inode(root));
 	if (!ro)
 		mnt_drop_write(mnt);
-out_putname:
 	putname(name);
-	return fd;
+	return ret;
 }
 
 SYSCALL_DEFINE4(mq_open, const char __user *, u_name, int, oflag, umode_t, mode,

-- 
2.47.3


