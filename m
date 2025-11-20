Return-Path: <linux-fsdevel+bounces-69288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48988C7681C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4DB24E36D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89A928B7D7;
	Thu, 20 Nov 2025 22:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2AWGobv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BC32FF660
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677956; cv=none; b=sr8Zvf7Wr8uj4rSwxpq036XDl/Oyyo+z5NKo4NadPt8irskagoRz3hhbf3QdyF+a++QsH0rZvxPoGA1z6TieQyblz9QZFN8osf1dygKFDwDKe0rXwnya6bJo19k1P5Nca6/DB3IRpmXXkPHnv9TtCegHQpwZ6tO3I+cpjsNGn38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677956; c=relaxed/simple;
	bh=e77/aj7THF+655lv8uvvO3GedR5xomFbG9K8AXl1egA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=llSFKo+fWyslch4KxK1NrNGV8Iqlm+Wrs6i3Dtayurrpgfj61zrrh5iktuF+doAPQVIAonRV2eJFNqH1KoO6P11OPZl5yyIkuxBgJhmKxH4hS1cpTXqIEdh2zzp+iwWB8AH4cpy/x0h3JU8lXSOgGT1hIxXjJuCYy1d6EmhU15U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2AWGobv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C08BC116B1;
	Thu, 20 Nov 2025 22:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677956;
	bh=e77/aj7THF+655lv8uvvO3GedR5xomFbG9K8AXl1egA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M2AWGobvemDcgDrs20EJ/icu662H/8vHzyFVLfKp8V3C2Gz5QuI3yTEyUBPXho22/
	 An91JYW/68aM0cDV5oU9CQFZGpOSJ26gWXsl6PHUGFWurKo6rI788yhbJiX62x5/Ss
	 BBCW4sECzgFUT4JlDM0REi3CjnaTtGXwxMXS3wbBHYjbkn8CX6bdDIOtVfeSZIbyfp
	 dEDk2v2SaJSPON2v9ccUe1uLsSA8SqCdR5E/0CQfC09Y7v2y9OJ7HuxWypcp1Ls/hS
	 +rsu6lq9hwFKMzTLigfayKmZhAc4ZztEUJwvuRhnEnt5C7tvXvgeAW2J0Eyrg7Z4Ck
	 4KEui1HTNNuVw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:06 +0100
Subject: [PATCH RFC v2 09/48] nsfs: convert open_namespace() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-9-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1062; i=brauner@kernel.org;
 h=from:subject:message-id; bh=e77/aj7THF+655lv8uvvO3GedR5xomFbG9K8AXl1egA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3tTfGJV9A4GmT2slhdy4jj/XHN8u3mT4Du1bPku0
 fKwv45vO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby7TfDX8HYTdoH/zlU7N14
 af+ZtIBurp3SnwM4HVeqOl3fJZCn5MHIsJ9d9cQ9rW/FnruCfBL/XplSmeBc+nh39ZFzn+aavdi
 9mxcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 79b026a36fb6..ee1b2ecddf0f 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -108,7 +108,6 @@ int ns_get_path(struct path *path, struct task_struct *task,
 int open_namespace(struct ns_common *ns)
 {
 	struct path path __free(path_put) = {};
-	struct file *f;
 	int err;
 
 	/* call first to consume reference */
@@ -116,16 +115,12 @@ int open_namespace(struct ns_common *ns)
 	if (err < 0)
 		return err;
 
-	CLASS(get_unused_fd, fd)(O_CLOEXEC);
-	if (fd < 0)
-		return fd;
+	FD_PREPARE(fdf, O_CLOEXEC, dentry_open(&path, O_RDONLY, current_cred())) {
+		if (fd_prepare_failed(fdf))
+			return fd_prepare_error(fdf);
 
-	f = dentry_open(&path, O_RDONLY, current_cred());
-	if (IS_ERR(f))
-		return PTR_ERR(f);
-
-	fd_install(fd, f);
-	return take_fd(fd);
+		return fd_publish(fdf);
+	}
 }
 
 int open_related_ns(struct ns_common *ns,

-- 
2.47.3


