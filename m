Return-Path: <linux-fsdevel+bounces-69420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8F5C7B2D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021853A21D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1669352936;
	Fri, 21 Nov 2025 18:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAhxB1Vh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A706350A28
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748098; cv=none; b=r+/tJqqwn2mcigGVeTRqQGh5Y4EL9mMHGt+abGz2VHPQ7LC8+BVs9srafO3x3D5l+RPn/TmS3A8C/u7CMgY9ZecJ3XOJg+i9zh96Fy25lXDXFGbNBbLMbhOza8SaIoJ1pIRt42BstlNuDSUhTGhjAynU2aghUGEjB97k4R0Vguc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748098; c=relaxed/simple;
	bh=kilm/TiwpdueWGQfLb9467R1F1pVcxpcqk8qncIl/ao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TpQU6JkSWAJEVU6dm21+/Kxqhn7zNrOjRaBJ4XToJvw33nI4iq0QROYj0grMrbUzCsJ9Fx1J1zzJrR+/3lmrMWuGoXt7QHIK2+LcvMcQX5qEaoXmnO1uIVlddcwxRssv+7+RP53CrVRFx3jZOw3mtPX/MTgOyYJK3MkIljbSB5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAhxB1Vh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C6AC4CEF1;
	Fri, 21 Nov 2025 18:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748098;
	bh=kilm/TiwpdueWGQfLb9467R1F1pVcxpcqk8qncIl/ao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NAhxB1Vh/nEafj+mRFwaQm+hSQdRpCXwSlkyGDNkL3792bDvNhlc3XZHX8T2VhhPY
	 G265nyuTTCvnzCW4pHLerp6b3JIPlUxy59lTJJx/b058Utxy5j0SIs18AMMgMbz1+I
	 8o/zIiDyVgO57tlwlaXWxxiXsC/uIX9h+WnOD9xxfVTpsloo7t2o5w5xsdztlyM7fS
	 Z/Gb/wbSF7zQiu1cj3E0fzKRqOP6rBzp2Nrqo2jlWSQvbTU4JaWi1cbWyRvl8bZ50P
	 XgqVDTuk9CsUzO/bUKwQn+UXQ4SQsqD2rydLxn5NlrsicnzsGCXzGqfmETH4vF/trj
	 lC5i8cyV5si/A==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:01 +0100
Subject: [PATCH RFC v3 22/47] ipc: convert do_mq_open() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-22-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1934; i=brauner@kernel.org;
 h=from:subject:message-id; bh=kilm/TiwpdueWGQfLb9467R1F1pVcxpcqk8qncIl/ao=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLigkXk+fFcEB9+x45eCcy+Wn5ObxbGNNUj2fH/1E
 7adZgevdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkyCdGhj38qQyej5KusCSI
 bJggsUhgknb7w//fBHdyOIfve1yZ+oCR4dSWp5fZv1Zff3Zmij2P4LT4ySntXtP9VW3eZPLVXX8
 kzAcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 ipc/mqueue.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 093551fe66a7..e9890736ba19 100644
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
@@ -908,38 +908,30 @@ static int do_mq_open(const char __user *u_name, int oflag, umode_t mode,
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
+	if (!ret) {
+		FD_PREPARE(fdf, O_CLOEXEC,
+			   dentry_open(&path, oflag, current_cred()));
+		ret = ACQUIRE_ERR(fd_prepare, &fdf);
+		if (!ret)
+			ret = fd_publish(fdf);
 	}
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


