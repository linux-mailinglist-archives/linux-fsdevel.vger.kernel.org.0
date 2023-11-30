Return-Path: <linux-fsdevel+bounces-4382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36167FF29E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D25828264B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247F751008
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbiuyWLr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED0B2B9DD
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 12:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF09C433C9;
	Thu, 30 Nov 2023 12:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701348578;
	bh=v8xFV2oXorsf2WY8P2pU/42bWbrkyQrwPNydx5WgnfI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rbiuyWLr/uDEqVeyaiTpR4FpKQlGPmnamnx65+cxjxEzf2WqWm2BoSxwSJ9KuA7P3
	 DbYwVLT7+hHk52KI9ADpn47fdwcF0q1EdBXivvfd+huDq3RebOWVL3mFktjvv5XfXr
	 r4QhBR4xJpJVGV2KQWKF+qVhM4+zLB4CmOTBoURQcZFbZx/zZu6r7nMinD2NqKs++D
	 Whd2RS/eW00mFAET96HR4mjtRcpJutU2QIT7LO7+8pGAKaM1MYcrZ2Qj5su/rApLnv
	 r2Gabf4mAWk2H409fk75fsVRac5jkh1LMhE6Mha64DeasicRcvyahVXtFWs51hx/WH
	 zS2a55iUv1KPw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 30 Nov 2023 13:49:11 +0100
Subject: [PATCH RFC 5/5] file: remove __receive_fd()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231130-vfs-files-fixes-v1-5-e73ca6f4ea83@kernel.org>
References: <20231130-vfs-files-fixes-v1-0-e73ca6f4ea83@kernel.org>
In-Reply-To: <20231130-vfs-files-fixes-v1-0-e73ca6f4ea83@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Jens Axboe <axboe@kernel.dk>, 
 Carlos Llamas <cmllamas@google.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-7edf1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4483; i=brauner@kernel.org;
 h=from:subject:message-id; bh=v8xFV2oXorsf2WY8P2pU/42bWbrkyQrwPNydx5WgnfI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRmtFzdXlnuJ9lwrIbth4p64jxu/RU67kuDlvpfVgwz2
 2MX8M6oo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKK7IwMC9fc11ty8tqtmHWf
 NG8us+k4eLujbdWa05FRjpuP7552ZQYjw4IPOo/efl8pdMLx/ssL7oZrxGuK6k4ofPbQ+Hzl5qe
 kEDYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Honestly, there's little value in having a helper with and without that
int __user *ufd argument. It's just messy and doesn't really give us
anything. Just expose receive_fd() with that argument and get rid of
that helper.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/vdpa/vdpa_user/vduse_dev.c |  2 +-
 fs/file.c                          | 11 +++--------
 include/linux/file.h               |  5 +----
 include/net/scm.h                  |  2 +-
 kernel/pid.c                       |  2 +-
 kernel/seccomp.c                   |  2 +-
 6 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 6cb5ce4a8b9a..1d24da79c399 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1157,7 +1157,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			fput(f);
 			break;
 		}
-		ret = receive_fd(f, perm_to_file_flags(entry.perm));
+		ret = receive_fd(f, NULL, perm_to_file_flags(entry.perm));
 		fput(f);
 		break;
 	}
diff --git a/fs/file.c b/fs/file.c
index c8eaa0b29a08..3b683b9101d8 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1296,7 +1296,7 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
 }
 
 /**
- * __receive_fd() - Install received file into file descriptor table
+ * receive_fd() - Install received file into file descriptor table
  * @file: struct file that was received from another process
  * @ufd: __user pointer to write new fd number to
  * @o_flags: the O_* flags to apply to the new fd entry
@@ -1310,7 +1310,7 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
  *
  * Returns newly install fd or -ve on error.
  */
-int __receive_fd(struct file *file, int __user *ufd, unsigned int o_flags)
+int receive_fd(struct file *file, int __user *ufd, unsigned int o_flags)
 {
 	int new_fd;
 	int error;
@@ -1335,6 +1335,7 @@ int __receive_fd(struct file *file, int __user *ufd, unsigned int o_flags)
 	__receive_sock(file);
 	return new_fd;
 }
+EXPORT_SYMBOL_GPL(receive_fd);
 
 int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags)
 {
@@ -1350,12 +1351,6 @@ int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags)
 	return new_fd;
 }
 
-int receive_fd(struct file *file, unsigned int o_flags)
-{
-	return __receive_fd(file, NULL, o_flags);
-}
-EXPORT_SYMBOL_GPL(receive_fd);
-
 static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
 {
 	int err = -EBADF;
diff --git a/include/linux/file.h b/include/linux/file.h
index c0d5219c2852..a50545ef1197 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -96,10 +96,7 @@ DEFINE_CLASS(get_unused_fd, int, if (_T >= 0) put_unused_fd(_T),
 
 extern void fd_install(unsigned int fd, struct file *file);
 
-extern int __receive_fd(struct file *file, int __user *ufd,
-			unsigned int o_flags);
-
-extern int receive_fd(struct file *file, unsigned int o_flags);
+extern int receive_fd(struct file *file, int __user *ufd, unsigned int o_flags);
 
 int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags);
 
diff --git a/include/net/scm.h b/include/net/scm.h
index 8aae2468bae0..cf68acec4d70 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -214,7 +214,7 @@ static inline int scm_recv_one_fd(struct file *f, int __user *ufd,
 {
 	if (!ufd)
 		return -EFAULT;
-	return __receive_fd(f, ufd, flags);
+	return receive_fd(f, ufd, flags);
 }
 
 #endif /* __LINUX_NET_SCM_H */
diff --git a/kernel/pid.c b/kernel/pid.c
index 6500ef956f2f..b52b10865454 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -700,7 +700,7 @@ static int pidfd_getfd(struct pid *pid, int fd)
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = receive_fd(file, O_CLOEXEC);
+	ret = receive_fd(file, NULL, O_CLOEXEC);
 	fput(file);
 
 	return ret;
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 255999ba9190..aca7b437882e 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1072,7 +1072,7 @@ static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd, struct seccomp_kn
 	 */
 	list_del_init(&addfd->list);
 	if (!addfd->setfd)
-		fd = receive_fd(addfd->file, addfd->flags);
+		fd = receive_fd(addfd->file, NULL, addfd->flags);
 	else
 		fd = receive_fd_replace(addfd->fd, addfd->file, addfd->flags);
 	addfd->ret = fd;

-- 
2.42.0


