Return-Path: <linux-fsdevel+bounces-4378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685A37FF28E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E68D8B20AB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7062051006
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVJcARuz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20939168B0
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 12:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABDFC433C7;
	Thu, 30 Nov 2023 12:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701348569;
	bh=Ld6OoEPx+dhBIvzinSbEgyOzoS2jFWZHZ5jQMYDnSG0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DVJcARuzhjWkMTe67xdkJP3PYSnAdn+s9Ofb2SM6hItSG1B1HMYglTd7jU+0Cszij
	 xMh6qSLwRKaF/3P2VkV8lhsOMDNUmJoQjrUeMs7g9R84CXUtoBbZBGnDa23eaDhek8
	 sP6aQNZ/ybpSAiEMyLue58Do2vBAEesMvvPu8hWg64vFdKropz8ZRSmohslrpmgzWN
	 8nLeQgAQdQJN2CW8PvLPNKckF0kKAnDWEDQ1fp7WUgd0yE8WtWULl9IRAiYUKfCgh3
	 4DrwBOqYwr+6dnVnQvFiMzS1+RUmumDmAGlcAUrFYXpUJ2GDxcn3IYur9ALcxIW364
	 QRthb2y45Zueg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 30 Nov 2023 13:49:07 +0100
Subject: [PATCH RFC 1/5] file: s/close_fd_get_file()/file_close_fd()/g
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231130-vfs-files-fixes-v1-1-e73ca6f4ea83@kernel.org>
References: <20231130-vfs-files-fixes-v1-0-e73ca6f4ea83@kernel.org>
In-Reply-To: <20231130-vfs-files-fixes-v1-0-e73ca6f4ea83@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Jens Axboe <axboe@kernel.dk>, 
 Carlos Llamas <cmllamas@google.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-7edf1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3103; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Ld6OoEPx+dhBIvzinSbEgyOzoS2jFWZHZ5jQMYDnSG0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRmtFydu8xk/4lPJs9ESg7OjeDOry3U+jWj9qaKp8elr
 nTLja1LOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyaAMjw2GGbPelVttZJh4M
 5aoNlJ8yS/ODvtDtYOk9eQHqiapVTxkZDt7W/PNPeJFt9Zo58ocrRM5/8t1+6UdUGPec51EtqX3
 MXAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

That really shouldn't have "get" in there as that implies we're bumping
the reference count which we don't do at all. We used to but not anmore.
Now we're just closing the fd and pick that file from the fdtable
without bumping the reference count. Update the wrong documentation
while at it.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/android/binder.c |  2 +-
 fs/file.c                | 14 +++++++++-----
 fs/open.c                |  2 +-
 include/linux/fdtable.h  |  2 +-
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 92128aae2d06..7658103ba760 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1921,7 +1921,7 @@ static void binder_deferred_fd_close(int fd)
 	if (!twcb)
 		return;
 	init_task_work(&twcb->twork, binder_do_fd_close);
-	twcb->file = close_fd_get_file(fd);
+	twcb->file = file_close_fd(fd);
 	if (twcb->file) {
 		// pin it until binder_do_fd_close(); see comments there
 		get_file(twcb->file);
diff --git a/fs/file.c b/fs/file.c
index 50df31e104a5..66f04442a384 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -796,7 +796,7 @@ int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
 }
 
 /*
- * See close_fd_get_file() below, this variant assumes current->files->file_lock
+ * See file_close_fd() below, this variant assumes current->files->file_lock
  * is held.
  */
 struct file *__close_fd_get_file(unsigned int fd)
@@ -804,11 +804,15 @@ struct file *__close_fd_get_file(unsigned int fd)
 	return pick_file(current->files, fd);
 }
 
-/*
- * variant of close_fd that gets a ref on the file for later fput.
- * The caller must ensure that filp_close() called on the file.
+/**
+ * file_close_fd - return file associated with fd
+ * @fd: file descriptor to retrieve file for
+ *
+ * Doesn't take a separate reference count.
+ *
+ * Returns: The file associated with @fd (NULL if @fd is not open)
  */
-struct file *close_fd_get_file(unsigned int fd)
+struct file *file_close_fd(unsigned int fd)
 {
 	struct files_struct *files = current->files;
 	struct file *file;
diff --git a/fs/open.c b/fs/open.c
index 0bd7fce21cbf..328dc6ef1883 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1578,7 +1578,7 @@ SYSCALL_DEFINE1(close, unsigned int, fd)
 	int retval;
 	struct file *file;
 
-	file = close_fd_get_file(fd);
+	file = file_close_fd(fd);
 	if (!file)
 		return -EBADF;
 
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 80bd7789bab1..78c8326d74ae 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -119,7 +119,7 @@ int iterate_fd(struct files_struct *, unsigned,
 
 extern int close_fd(unsigned int fd);
 extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
-extern struct file *close_fd_get_file(unsigned int fd);
+extern struct file *file_close_fd(unsigned int fd);
 extern int unshare_fd(unsigned long unshare_flags, unsigned int max_fds,
 		      struct files_struct **new_fdp);
 

-- 
2.42.0


