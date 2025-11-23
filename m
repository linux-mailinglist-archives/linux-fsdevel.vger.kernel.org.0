Return-Path: <linux-fsdevel+bounces-69544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CAFC7E3D8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A543A4F33
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D48C2D97A6;
	Sun, 23 Nov 2025 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwIshSoB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5772D979C
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915662; cv=none; b=Z7tui9T/claTy5yRzEw+8BOvYOvGzEF4QcrCdG/aog0NY4r3JzG5fVVSMjvwarsBjx0L+ithp/P/gnfKragDp9epmyFAkgUE15YsSglRPr2HI1T7zfzA7QyfLBVZad/BaHMJ3p8H+a8Prv7w9h+hacRtzHS5WevzIZjJxdMi9TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915662; c=relaxed/simple;
	bh=EtJkXQlcmsswFlvQdnG9stLYwFahYIJoOQnJiXWV+Xo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MkYlE2UIlDvBZIWIATQWlkKnLDCaB704VcdOljlZxwQNUgBDlL+EA4kvNgTnHtn/gQ+WBa/8A11PFnwGC99BT4BjIXm3S7+NHNb9TrC+kjO1Hi9CoRDJCrAQP5/j9D6qLy+4ttRHVFzUBgBVgwV2tsWhHJE1PQX5m0PHjpIpZ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwIshSoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31ACC113D0;
	Sun, 23 Nov 2025 16:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915662;
	bh=EtJkXQlcmsswFlvQdnG9stLYwFahYIJoOQnJiXWV+Xo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XwIshSoB12fc+2DbzFXptlQKJ7h2slzBx4qdcPHwvMV2WWn038qoKajWVToITeuM5
	 ug0OARVTNOrvpjBXnffLnkxyBTWrAX/osMG18ewNzX8fuNp5I5sIRb5hD/eX0nLGw2
	 bJnd95wSQuJTSQzeNYTBIcn1lYibiG3RqsdVkhnDWavlYyxQFDiiameDDagSab5AJ/
	 XdmDZaqqvPh7rTyHPLE5JZ66UEsjQ6aV8Cbtgxs8viimjgz6C3YHcGq5loaZBnSse5
	 rnDrJVgi54QvE/DAt/2T++MjbuNBC40V62izo9tfciX/qTtB14iXKj2gGVlZ0QAzoY
	 VtNvUYKphQp9Q==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:40 +0100
Subject: [PATCH v4 22/47] ipc: convert do_mq_open() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-22-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1834; i=brauner@kernel.org;
 h=from:subject:message-id; bh=EtJkXQlcmsswFlvQdnG9stLYwFahYIJoOQnJiXWV+Xo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0ex13Sabywt+1osr6N7x3zPdvMaJQk77ncnU+34m
 ZnUqpZ0lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATKS1ieF/jfCK6uL55hoHTnrt
 Tjm7Q8fCx2XyDQ4fLc2F5w5s5yr7xPBP6eqU/AktQhvPnhT6YnXgCENml9V0ziSrez8+vVy2xiO
 dHwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 ipc/mqueue.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 093551fe66a7..8b9b53db67a2 100644
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
@@ -908,38 +908,25 @@ static int do_mq_open(const char __user *u_name, int oflag, umode_t mode,
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
-	}
+	ret = prepare_open(path.dentry, oflag, ro, mode, name, attr);
+	if (!ret)
+		ret = FD_ADD(O_CLOEXEC, dentry_open(&path, oflag, current_cred()));
 	path_put(&path);
-out_putfd:
-	if (error) {
-		put_unused_fd(fd);
-		fd = error;
-	}
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


