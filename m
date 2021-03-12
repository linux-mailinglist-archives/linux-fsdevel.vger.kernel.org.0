Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BDF339247
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 16:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhCLPtx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 10:49:53 -0500
Received: from hmm.wantstofly.org ([213.239.204.108]:40306 "EHLO
        mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbhCLPtl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:49:41 -0500
Received: by mail.wantstofly.org (Postfix, from userid 1000)
        id AAFB07F279; Fri, 12 Mar 2021 17:49:40 +0200 (EET)
Date:   Fri, 12 Mar 2021 17:49:40 +0200
From:   Lennert Buytenhek <buytenh@wantstofly.org>
To:     io-uring@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 1/2] readdir: split the core of getdents64(2) out into
 vfs_getdents()
Message-ID: <YEuNlKWpQqGMCtL8@wantstofly.org>
References: <YEuNMc5LlGftOHW6@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEuNMc5LlGftOHW6@wantstofly.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So that IORING_OP_GETDENTS may use it, split out the core of the
getdents64(2) syscall into a helper function, vfs_getdents().

vfs_getdents() calls into filesystems' ->iterate{,_shared}() which
expect serialization on struct file, which means that callers of
vfs_getdents() are responsible for either using fdget_pos() or
performing the equivalent serialization by hand.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
---
 fs/readdir.c       | 25 +++++++++++++++++--------
 include/linux/fs.h |  4 ++++
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/fs/readdir.c b/fs/readdir.c
index 19434b3c982c..f52167c1eb61 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -348,10 +348,9 @@ static int filldir64(struct dir_context *ctx, const char *name, int namlen,
 	return -EFAULT;
 }
 
-SYSCALL_DEFINE3(getdents64, unsigned int, fd,
-		struct linux_dirent64 __user *, dirent, unsigned int, count)
+int vfs_getdents(struct file *file, struct linux_dirent64 __user *dirent,
+		 unsigned int count)
 {
-	struct fd f;
 	struct getdents_callback64 buf = {
 		.ctx.actor = filldir64,
 		.count = count,
@@ -359,11 +358,7 @@ SYSCALL_DEFINE3(getdents64, unsigned int, fd,
 	};
 	int error;
 
-	f = fdget_pos(fd);
-	if (!f.file)
-		return -EBADF;
-
-	error = iterate_dir(f.file, &buf.ctx);
+	error = iterate_dir(file, &buf.ctx);
 	if (error >= 0)
 		error = buf.error;
 	if (buf.prev_reclen) {
@@ -376,6 +371,20 @@ SYSCALL_DEFINE3(getdents64, unsigned int, fd,
 		else
 			error = count - buf.count;
 	}
+	return error;
+}
+
+SYSCALL_DEFINE3(getdents64, unsigned int, fd,
+		struct linux_dirent64 __user *, dirent, unsigned int, count)
+{
+	struct fd f;
+	int error;
+
+	f = fdget_pos(fd);
+	if (!f.file)
+		return -EBADF;
+
+	error = vfs_getdents(f.file, dirent, count);
 	fdput_pos(f);
 	return error;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ec8f3ddf4a6a..c03235883e18 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3227,6 +3227,10 @@ extern const struct inode_operations simple_symlink_inode_operations;
 
 extern int iterate_dir(struct file *, struct dir_context *);
 
+struct linux_dirent64;
+int vfs_getdents(struct file *file, struct linux_dirent64 __user *dirent,
+		 unsigned int count);
+
 int vfs_fstatat(int dfd, const char __user *filename, struct kstat *stat,
 		int flags);
 int vfs_fstat(int fd, struct kstat *stat);
-- 
2.29.2
