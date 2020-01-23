Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A501314689C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 14:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgAWM7z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 07:59:55 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:1683 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgAWM7z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 07:59:55 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 483Mn35jc3z9vB4Y;
        Thu, 23 Jan 2020 13:59:51 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=cMtJQAFE; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id t-xxTia2otsD; Thu, 23 Jan 2020 13:59:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 483Mn34ZCWz9vB4X;
        Thu, 23 Jan 2020 13:59:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579784391; bh=u5CrsfyCaTFJUOottFM+3vIgDy4gsnvhbgkMgcGLTTo=;
        h=From:Subject:To:Cc:Date:From;
        b=cMtJQAFExU8asQxxieqo6GC6YKTxr5Jl/y/t9rbfuWH1sClMhVErgyDQWQPBvuIn+
         GU3xh3j5Te71uKNMI7wyXFIrZ7P1Dv9XDndroFQ8VPN/Vu0YnJjRpZzYPGMhCcpW5d
         W4iqAStZIDFlh0ytcJGyoD2q45EjFOXE792HAeX4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DCE6B8B82C;
        Thu, 23 Jan 2020 13:59:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id yUXeLRtE7w0P; Thu, 23 Jan 2020 13:59:52 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8A9BD8B826;
        Thu, 23 Jan 2020 13:59:52 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3E63F651C0; Thu, 23 Jan 2020 12:59:52 +0000 (UTC)
Message-Id: <fed4f49349913cb6739dac647ba6a61d56b989d2.1579783936.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 1/7] fs/readdir: Fix filldir() and filldir64() use of
 user_access_begin()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Date:   Thu, 23 Jan 2020 12:59:52 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some architectures grant full access to userspace regardless of the
address/len passed to user_access_begin(), but other architectures
only grant access to the requested area.

For example, on 32 bits powerpc (book3s/32), access is granted by
segments of 256 Mbytes.

Modify filldir() and filldir64() to request the real area they need
to get access to, i.e. the area covering the parent dirent (if any)
and the contiguous current dirent.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: 9f79b78ef744 ("Convert filldir[64]() from __put_user() to unsafe_put_user()")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: have user_access_begin() cover both parent dirent (if any) and current dirent
v3: replaced by patch from Linus
---
 fs/readdir.c | 70 +++++++++++++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 36 deletions(-)

diff --git a/fs/readdir.c b/fs/readdir.c
index d26d5ea4de7b..4b466cbb0f3a 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -206,7 +206,7 @@ struct linux_dirent {
 struct getdents_callback {
 	struct dir_context ctx;
 	struct linux_dirent __user * current_dir;
-	struct linux_dirent __user * previous;
+	int prev_reclen;
 	int count;
 	int error;
 };
@@ -214,12 +214,13 @@ struct getdents_callback {
 static int filldir(struct dir_context *ctx, const char *name, int namlen,
 		   loff_t offset, u64 ino, unsigned int d_type)
 {
-	struct linux_dirent __user * dirent;
+	struct linux_dirent __user *dirent, *prev;
 	struct getdents_callback *buf =
 		container_of(ctx, struct getdents_callback, ctx);
 	unsigned long d_ino;
 	int reclen = ALIGN(offsetof(struct linux_dirent, d_name) + namlen + 2,
 		sizeof(long));
+	int prev_reclen;
 
 	buf->error = verify_dirent_name(name, namlen);
 	if (unlikely(buf->error))
@@ -232,28 +233,24 @@ static int filldir(struct dir_context *ctx, const char *name, int namlen,
 		buf->error = -EOVERFLOW;
 		return -EOVERFLOW;
 	}
-	dirent = buf->previous;
-	if (dirent && signal_pending(current))
+	prev_reclen = buf->prev_reclen;
+	if (prev_reclen && signal_pending(current))
 		return -EINTR;
-
-	/*
-	 * Note! This range-checks 'previous' (which may be NULL).
-	 * The real range was checked in getdents
-	 */
-	if (!user_access_begin(dirent, sizeof(*dirent)))
-		goto efault;
-	if (dirent)
-		unsafe_put_user(offset, &dirent->d_off, efault_end);
 	dirent = buf->current_dir;
+	prev = (void __user *)dirent - prev_reclen;
+	if (!user_access_begin(prev, reclen + prev_reclen))
+		goto efault;
+
+	/* This might be 'dirent->d_off', but if so it will get overwritten */
+	unsafe_put_user(offset, &prev->d_off, efault_end);
 	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
 	unsafe_put_user(reclen, &dirent->d_reclen, efault_end);
 	unsafe_put_user(d_type, (char __user *) dirent + reclen - 1, efault_end);
 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
 	user_access_end();
 
-	buf->previous = dirent;
-	dirent = (void __user *)dirent + reclen;
-	buf->current_dir = dirent;
+	buf->current_dir = (void __user *)dirent + reclen;
+	buf->prev_reclen = reclen;
 	buf->count -= reclen;
 	return 0;
 efault_end:
@@ -267,7 +264,6 @@ SYSCALL_DEFINE3(getdents, unsigned int, fd,
 		struct linux_dirent __user *, dirent, unsigned int, count)
 {
 	struct fd f;
-	struct linux_dirent __user * lastdirent;
 	struct getdents_callback buf = {
 		.ctx.actor = filldir,
 		.count = count,
@@ -285,8 +281,10 @@ SYSCALL_DEFINE3(getdents, unsigned int, fd,
 	error = iterate_dir(f.file, &buf.ctx);
 	if (error >= 0)
 		error = buf.error;
-	lastdirent = buf.previous;
-	if (lastdirent) {
+	if (buf.prev_reclen) {
+		struct linux_dirent __user *lastdirent;
+		lastdirent = (void __user *)buf.current_dir - buf.prev_reclen;
+
 		if (put_user(buf.ctx.pos, &lastdirent->d_off))
 			error = -EFAULT;
 		else
@@ -299,7 +297,7 @@ SYSCALL_DEFINE3(getdents, unsigned int, fd,
 struct getdents_callback64 {
 	struct dir_context ctx;
 	struct linux_dirent64 __user * current_dir;
-	struct linux_dirent64 __user * previous;
+	int prev_reclen;
 	int count;
 	int error;
 };
@@ -307,11 +305,12 @@ struct getdents_callback64 {
 static int filldir64(struct dir_context *ctx, const char *name, int namlen,
 		     loff_t offset, u64 ino, unsigned int d_type)
 {
-	struct linux_dirent64 __user *dirent;
+	struct linux_dirent64 __user *dirent, *prev;
 	struct getdents_callback64 *buf =
 		container_of(ctx, struct getdents_callback64, ctx);
 	int reclen = ALIGN(offsetof(struct linux_dirent64, d_name) + namlen + 1,
 		sizeof(u64));
+	int prev_reclen;
 
 	buf->error = verify_dirent_name(name, namlen);
 	if (unlikely(buf->error))
@@ -319,30 +318,28 @@ static int filldir64(struct dir_context *ctx, const char *name, int namlen,
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
 		return -EINVAL;
-	dirent = buf->previous;
-	if (dirent && signal_pending(current))
+	prev_reclen = buf->prev_reclen;
+	if (prev_reclen && signal_pending(current))
 		return -EINTR;
-
-	/*
-	 * Note! This range-checks 'previous' (which may be NULL).
-	 * The real range was checked in getdents
-	 */
-	if (!user_access_begin(dirent, sizeof(*dirent)))
-		goto efault;
-	if (dirent)
-		unsafe_put_user(offset, &dirent->d_off, efault_end);
 	dirent = buf->current_dir;
+	prev = (void __user *)dirent - prev_reclen;
+	if (!user_access_begin(prev, reclen + prev_reclen))
+		goto efault;
+
+	/* This might be 'dirent->d_off', but if so it will get overwritten */
+	unsafe_put_user(offset, &prev->d_off, efault_end);
 	unsafe_put_user(ino, &dirent->d_ino, efault_end);
 	unsafe_put_user(reclen, &dirent->d_reclen, efault_end);
 	unsafe_put_user(d_type, &dirent->d_type, efault_end);
 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
 	user_access_end();
 
-	buf->previous = dirent;
+	buf->prev_reclen = reclen;
 	dirent = (void __user *)dirent + reclen;
 	buf->current_dir = dirent;
 	buf->count -= reclen;
 	return 0;
+
 efault_end:
 	user_access_end();
 efault:
@@ -354,7 +351,6 @@ int ksys_getdents64(unsigned int fd, struct linux_dirent64 __user *dirent,
 		    unsigned int count)
 {
 	struct fd f;
-	struct linux_dirent64 __user * lastdirent;
 	struct getdents_callback64 buf = {
 		.ctx.actor = filldir64,
 		.count = count,
@@ -372,9 +368,11 @@ int ksys_getdents64(unsigned int fd, struct linux_dirent64 __user *dirent,
 	error = iterate_dir(f.file, &buf.ctx);
 	if (error >= 0)
 		error = buf.error;
-	lastdirent = buf.previous;
-	if (lastdirent) {
+	if (buf.prev_reclen) {
+		struct linux_dirent64 __user *lastdirent;
 		typeof(lastdirent->d_off) d_off = buf.ctx.pos;
+
+		lastdirent = (void __user *)buf.current_dir - buf.prev_reclen;
 		if (__put_user(d_off, &lastdirent->d_off))
 			error = -EFAULT;
 		else
-- 
2.25.0

