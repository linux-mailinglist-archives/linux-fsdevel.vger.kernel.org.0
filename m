Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31B61E70BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 01:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437769AbgE1XtY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 19:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437705AbgE1XtV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 19:49:21 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EBBC008630;
        Thu, 28 May 2020 16:49:21 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSH1-00HDo0-OU; Thu, 28 May 2020 23:49:19 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/6] readdir.c: get compat_filldir() more or less in sync with filldir()
Date:   Fri, 29 May 2020 00:49:18 +0100
Message-Id: <20200528234919.4104604-2-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200528234919.4104604-1-viro@ZenIV.linux.org.uk>
References: <20200528234832.GA4103769@ZenIV.linux.org.uk>
 <20200528234919.4104604-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/readdir.c | 51 +++++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/fs/readdir.c b/fs/readdir.c
index a9085016a619..9534675880ce 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -473,7 +473,7 @@ struct compat_linux_dirent {
 struct compat_getdents_callback {
 	struct dir_context ctx;
 	struct compat_linux_dirent __user *current_dir;
-	struct compat_linux_dirent __user *previous;
+	int prev_reclen;
 	int count;
 	int error;
 };
@@ -481,13 +481,17 @@ struct compat_getdents_callback {
 static int compat_filldir(struct dir_context *ctx, const char *name, int namlen,
 		loff_t offset, u64 ino, unsigned int d_type)
 {
-	struct compat_linux_dirent __user * dirent;
+	struct compat_linux_dirent __user *dirent, *prev;
 	struct compat_getdents_callback *buf =
 		container_of(ctx, struct compat_getdents_callback, ctx);
 	compat_ulong_t d_ino;
 	int reclen = ALIGN(offsetof(struct compat_linux_dirent, d_name) +
 		namlen + 2, sizeof(compat_long_t));
+	int prev_reclen;
 
+	buf->error = verify_dirent_name(name, namlen);
+	if (unlikely(buf->error))
+		return buf->error;
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
 		return -EINVAL;
@@ -496,29 +500,27 @@ static int compat_filldir(struct dir_context *ctx, const char *name, int namlen,
 		buf->error = -EOVERFLOW;
 		return -EOVERFLOW;
 	}
-	dirent = buf->previous;
-	if (dirent) {
-		if (signal_pending(current))
-			return -EINTR;
-		if (__put_user(offset, &dirent->d_off))
-			goto efault;
-	}
+	prev_reclen = buf->prev_reclen;
+	if (prev_reclen && signal_pending(current))
+		return -EINTR;
 	dirent = buf->current_dir;
-	if (__put_user(d_ino, &dirent->d_ino))
-		goto efault;
-	if (__put_user(reclen, &dirent->d_reclen))
-		goto efault;
-	if (copy_to_user(dirent->d_name, name, namlen))
-		goto efault;
-	if (__put_user(0, dirent->d_name + namlen))
-		goto efault;
-	if (__put_user(d_type, (char  __user *) dirent + reclen - 1))
+	prev = (void __user *) dirent - prev_reclen;
+	if (!user_write_access_begin(prev, reclen + prev_reclen))
 		goto efault;
-	buf->previous = dirent;
-	dirent = (void __user *)dirent + reclen;
-	buf->current_dir = dirent;
+
+	unsafe_put_user(offset, &prev->d_off, efault_end);
+	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
+	unsafe_put_user(reclen, &dirent->d_reclen, efault_end);
+	unsafe_put_user(d_type, (char __user *) dirent + reclen - 1, efault_end);
+	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
+	user_write_access_end();
+
+	buf->prev_reclen = reclen;
+	buf->current_dir = (void __user *)dirent + reclen;
 	buf->count -= reclen;
 	return 0;
+efault_end:
+	user_write_access_end();
 efault:
 	buf->error = -EFAULT;
 	return -EFAULT;
@@ -528,7 +530,6 @@ COMPAT_SYSCALL_DEFINE3(getdents, unsigned int, fd,
 		struct compat_linux_dirent __user *, dirent, unsigned int, count)
 {
 	struct fd f;
-	struct compat_linux_dirent __user * lastdirent;
 	struct compat_getdents_callback buf = {
 		.ctx.actor = compat_filldir,
 		.current_dir = dirent,
@@ -546,8 +547,10 @@ COMPAT_SYSCALL_DEFINE3(getdents, unsigned int, fd,
 	error = iterate_dir(f.file, &buf.ctx);
 	if (error >= 0)
 		error = buf.error;
-	lastdirent = buf.previous;
-	if (lastdirent) {
+	if (buf.prev_reclen) {
+		struct compat_linux_dirent __user * lastdirent;
+		lastdirent = (void __user *)buf.current_dir - buf.prev_reclen;
+
 		if (put_user(buf.ctx.pos, &lastdirent->d_off))
 			error = -EFAULT;
 		else
-- 
2.11.0

