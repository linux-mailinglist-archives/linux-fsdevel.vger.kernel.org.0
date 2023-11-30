Return-Path: <linux-fsdevel+bounces-4379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB2F7FF290
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEE82819FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028B651018
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJ6h0bYz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7E538FB1
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 12:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301F2C433CA;
	Thu, 30 Nov 2023 12:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701348571;
	bh=y5oee8d+LygiNr44hXs874ugh7uQlyFrHx6WyxL7MCI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lJ6h0bYz6CQpNDohEp29rIYEg2DSYrVlQghOo37eYbmaTV0ZNyS75TwhyAG0cBB7H
	 CIkL2mg9h3lrwdkrTKXiBuXN0L/DWpyz8/2atTaBfQCoEDZNxbWv1Nf+6W4DwG//PH
	 /4VNmxyOgOY51U4a80qJlS9d5tecpz3clhsxkGdooaeG8+C/eVWHU1AmWb+wTbgGeD
	 srEkB7mPgpTk6MbIxXj1CMMHMX7ECrSn3VgzqUXZGyWYAJAO9SsYuB0GcH7Z0/8X5O
	 pJtTJ7hC9a/pNCYVdsKoQ9/rdfZaEpGV50iA0aasG+SFFoseHAa/wEntZYRWeCPBWa
	 krdr4ptY09hCg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 30 Nov 2023 13:49:08 +0100
Subject: [PATCH RFC 2/5] file: remove pointless wrapper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231130-vfs-files-fixes-v1-2-e73ca6f4ea83@kernel.org>
References: <20231130-vfs-files-fixes-v1-0-e73ca6f4ea83@kernel.org>
In-Reply-To: <20231130-vfs-files-fixes-v1-0-e73ca6f4ea83@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Jens Axboe <axboe@kernel.dk>, 
 Carlos Llamas <cmllamas@google.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-7edf1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3834; i=brauner@kernel.org;
 h=from:subject:message-id; bh=y5oee8d+LygiNr44hXs874ugh7uQlyFrHx6WyxL7MCI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRmtFztSi0y3XAtMaTYkvmll66Ww5MjjVk/Im+8kuVKP
 lxT99mmo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIOpxn+V6xI6Lm5+gbTd6Oa
 N5J/HE8Hve54L1Wq0H4kkXW3wM9II0aGff4FF9T4DP/91KxREap89enzVvaU6Cjzlc3v4j99/Zj
 OBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Only io_uring uses __close_fd_get_file(). All it does is hide
current->files but io_uring accesses files_struct directly right now
anyway so it's a bit pointless. Just rename pick_file() to
file_close_fd_locked() and let io_uring use it. Add a lockdep assert in
there that we expect the caller to hold file_lock while we're at it.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/file.c            | 23 +++++++++--------------
 fs/internal.h        |  2 +-
 io_uring/openclose.c |  2 +-
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 66f04442a384..c8eaa0b29a08 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -629,19 +629,23 @@ void fd_install(unsigned int fd, struct file *file)
 EXPORT_SYMBOL(fd_install);
 
 /**
- * pick_file - return file associatd with fd
+ * file_close_fd_locked - return file associated with fd
  * @files: file struct to retrieve file from
  * @fd: file descriptor to retrieve file for
  *
+ * Doesn't take a separate reference count.
+ *
  * Context: files_lock must be held.
  *
  * Returns: The file associated with @fd (NULL if @fd is not open)
  */
-static struct file *pick_file(struct files_struct *files, unsigned fd)
+struct file *file_close_fd_locked(struct files_struct *files, unsigned fd)
 {
 	struct fdtable *fdt = files_fdtable(files);
 	struct file *file;
 
+	lockdep_assert_held(&files->file_lock);
+
 	if (fd >= fdt->max_fds)
 		return NULL;
 
@@ -660,7 +664,7 @@ int close_fd(unsigned fd)
 	struct file *file;
 
 	spin_lock(&files->file_lock);
-	file = pick_file(files, fd);
+	file = file_close_fd_locked(files, fd);
 	spin_unlock(&files->file_lock);
 	if (!file)
 		return -EBADF;
@@ -707,7 +711,7 @@ static inline void __range_close(struct files_struct *files, unsigned int fd,
 	max_fd = min(max_fd, n);
 
 	for (; fd <= max_fd; fd++) {
-		file = pick_file(files, fd);
+		file = file_close_fd_locked(files, fd);
 		if (file) {
 			spin_unlock(&files->file_lock);
 			filp_close(file, files);
@@ -795,15 +799,6 @@ int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
 	return 0;
 }
 
-/*
- * See file_close_fd() below, this variant assumes current->files->file_lock
- * is held.
- */
-struct file *__close_fd_get_file(unsigned int fd)
-{
-	return pick_file(current->files, fd);
-}
-
 /**
  * file_close_fd - return file associated with fd
  * @fd: file descriptor to retrieve file for
@@ -818,7 +813,7 @@ struct file *file_close_fd(unsigned int fd)
 	struct file *file;
 
 	spin_lock(&files->file_lock);
-	file = pick_file(files, fd);
+	file = file_close_fd_locked(files, fd);
 	spin_unlock(&files->file_lock);
 
 	return file;
diff --git a/fs/internal.h b/fs/internal.h
index 273e6fd40d1b..a7469ddba9b6 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -179,7 +179,7 @@ extern struct file *do_file_open_root(const struct path *,
 		const char *, const struct open_flags *);
 extern struct open_how build_open_how(int flags, umode_t mode);
 extern int build_open_flags(const struct open_how *how, struct open_flags *op);
-extern struct file *__close_fd_get_file(unsigned int fd);
+struct file *file_close_fd_locked(struct files_struct *files, unsigned fd);
 
 long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
 int chmod_common(const struct path *path, umode_t mode);
diff --git a/io_uring/openclose.c b/io_uring/openclose.c
index fb73adb89067..74fc22461f48 100644
--- a/io_uring/openclose.c
+++ b/io_uring/openclose.c
@@ -241,7 +241,7 @@ int io_close(struct io_kiocb *req, unsigned int issue_flags)
 		return -EAGAIN;
 	}
 
-	file = __close_fd_get_file(close->fd);
+	file = file_close_fd_locked(files, close->fd);
 	spin_unlock(&files->file_lock);
 	if (!file)
 		goto err;

-- 
2.42.0


