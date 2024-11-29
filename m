Return-Path: <linux-fsdevel+bounces-36146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 361FD9DE7CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 14:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8633CB22B62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E96C1A254E;
	Fri, 29 Nov 2024 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZ1WXO8h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A100E1A0BDB;
	Fri, 29 Nov 2024 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732887565; cv=none; b=Muj9Phe9ltrc8CW9QEliEfYV4bjEWEQkqiNkR6wIhlxiQYMRSYS7MVrI46dnMRajSVaS/AgHuXujd4UVUISg9Hw3qQ8fe0WnR9jTmxnwH5clLY3BzM4bqjhG6HjXPKkM2HRKhFighnxwMwuJVOzmIgB9sP5zyCYJpcOBR6rA2Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732887565; c=relaxed/simple;
	bh=0ufmttgp29x3cn0TQa3rd5/zer9AJDWgjU/KvQ526oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORDam0xJySMhyyye7fmzVQL/EIPryfYwQMVSiJutQdQzXLW0xMtsUh5sMFHBBuiFeayySSFuSB4ONq5oUxszdtknj3Rbztr+mPtxFeYhr1VeG21H8b79bfX7aVNcTEwcOoJGwYURTAGuxDpKNjk+lB6CEeYTWrWyRAZuObkqfPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZ1WXO8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2A9C4CECF;
	Fri, 29 Nov 2024 13:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732887565;
	bh=0ufmttgp29x3cn0TQa3rd5/zer9AJDWgjU/KvQ526oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MZ1WXO8hR0dY1joxKqSe0XRno+dmoQNbuQQT0xqx8+l0GnrwBMk3XNxiYRvZ5K0is
	 smfIp/Vn1IIYqmTnclmquCv0ciAniY+NvTNUFgZjcz0w3EWl9H4ynQ5ULo0A6fB7i7
	 XreOj1OceRA+viTtDF89etFJLzCWkitMs7BXmKsk6gIQ4QNgaXFfG//WqtMBs9cEpy
	 g/EEs2pExRSLQtJmbGe8GwFPCmqSAvbjPz63p8y8CtTha9wCMg03jrKiBvmzhxcpUM
	 AwPm9dnIkPsrNLOmLlpjUqYSWdaPkA6sWSUzDEvaXW9WNbkHA+KiTjfjuOFw/zpPTY
	 OLDD9swM7dEkA==
From: Christian Brauner <brauner@kernel.org>
To: Erin Shepherd <erin.shepherd@e43.eu>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH RFC 2/6] fhandle: simplify error handling
Date: Fri, 29 Nov 2024 14:38:01 +0100
Message-ID: <20241129-work-pidfs-file_handle-v1-2-87d803a42495@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241129-work-pidfs-file_handle-v1-0-87d803a42495@kernel.org>
References: <20241129-work-pidfs-file_handle-v1-0-87d803a42495@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2177; i=brauner@kernel.org; h=from:subject:message-id; bh=0ufmttgp29x3cn0TQa3rd5/zer9AJDWgjU/KvQ526oo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR7Hj5go3bx9Pm14b/6Be3cpD3t/RUXTAoraOw3XMFmN Znj9CSTjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImsd2H4K6xe7yCjxHaE+4TV x936N+yvJZtuFROYM1lqc4KRw3Lp5wz/K4XNql7fOhX64GRS5g2eTzODzUQO2NqXXhZkXnGkP1S PHwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Rely on our cleanup infrastructure.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fhandle.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index ec9145047dfc9d25e109e72d210987bbf6b36a20..c00d88fb14e16654b5cbbb71760c0478eac20384 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -261,19 +261,20 @@ static int do_handle_to_path(struct file_handle *handle, struct path *path,
 {
 	int handle_dwords;
 	struct vfsmount *mnt = ctx->root.mnt;
+	struct dentry *dentry;
 
 	/* change the handle size to multiple of sizeof(u32) */
 	handle_dwords = handle->handle_bytes >> 2;
-	path->dentry = exportfs_decode_fh_raw(mnt,
-					  (struct fid *)handle->f_handle,
-					  handle_dwords, handle->handle_type,
-					  ctx->fh_flags,
-					  vfs_dentry_acceptable, ctx);
-	if (IS_ERR_OR_NULL(path->dentry)) {
-		if (path->dentry == ERR_PTR(-ENOMEM))
+	dentry = exportfs_decode_fh_raw(mnt, (struct fid *)handle->f_handle,
+					handle_dwords, handle->handle_type,
+					ctx->fh_flags, vfs_dentry_acceptable,
+					ctx);
+	if (IS_ERR_OR_NULL(dentry)) {
+		if (dentry == ERR_PTR(-ENOMEM))
 			return -ENOMEM;
 		return -ESTALE;
 	}
+	path->dentry = dentry;
 	path->mnt = mntget(mnt);
 	return 0;
 }
@@ -398,29 +399,23 @@ static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
 			   int open_flag)
 {
 	long retval = 0;
-	struct path path;
+	struct path path __free(path_put) = {};
 	struct file *file;
-	int fd;
 
 	retval = handle_to_path(mountdirfd, ufh, &path, open_flag);
 	if (retval)
 		return retval;
 
-	fd = get_unused_fd_flags(open_flag);
-	if (fd < 0) {
-		path_put(&path);
+	CLASS(get_unused_fd, fd)(O_CLOEXEC);
+	if (fd < 0)
 		return fd;
-	}
+
 	file = file_open_root(&path, "", open_flag, 0);
-	if (IS_ERR(file)) {
-		put_unused_fd(fd);
-		retval =  PTR_ERR(file);
-	} else {
-		retval = fd;
-		fd_install(fd, file);
-	}
-	path_put(&path);
-	return retval;
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	fd_install(fd, file);
+	return take_fd(fd);
 }
 
 /**

-- 
2.45.2


