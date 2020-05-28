Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE4F1E70BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 01:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437790AbgE1Xtq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 19:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437780AbgE1Xtd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 19:49:33 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996DAC008630;
        Thu, 28 May 2020 16:49:33 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSHE-00HDpK-2l; Thu, 28 May 2020 23:49:32 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/6] uaccess: Selectively open read or write user access
Date:   Fri, 29 May 2020 00:49:30 +0100
Message-Id: <20200528234931.4104686-2-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200528234931.4104686-1-viro@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
 <20200528234931.4104686-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

When opening user access to only perform reads, only open read access.
When opening user access to only perform writes, only open write
access.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/2e73bc57125c2c6ab12a587586a4eed3a47105fc.1585898438.git.christophe.leroy@c-s.fr
---
 fs/readdir.c            | 12 ++++++------
 kernel/compat.c         | 12 ++++++------
 kernel/exit.c           | 12 ++++++------
 lib/strncpy_from_user.c |  4 ++--
 lib/strnlen_user.c      |  4 ++--
 lib/usercopy.c          |  6 +++---
 6 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/fs/readdir.c b/fs/readdir.c
index de2eceffdee8..ed6aaad451aa 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -242,7 +242,7 @@ static int filldir(struct dir_context *ctx, const char *name, int namlen,
 		return -EINTR;
 	dirent = buf->current_dir;
 	prev = (void __user *) dirent - prev_reclen;
-	if (!user_access_begin(prev, reclen + prev_reclen))
+	if (!user_write_access_begin(prev, reclen + prev_reclen))
 		goto efault;
 
 	/* This might be 'dirent->d_off', but if so it will get overwritten */
@@ -251,14 +251,14 @@ static int filldir(struct dir_context *ctx, const char *name, int namlen,
 	unsafe_put_user(reclen, &dirent->d_reclen, efault_end);
 	unsafe_put_user(d_type, (char __user *) dirent + reclen - 1, efault_end);
 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
-	user_access_end();
+	user_write_access_end();
 
 	buf->current_dir = (void __user *)dirent + reclen;
 	buf->prev_reclen = reclen;
 	buf->count -= reclen;
 	return 0;
 efault_end:
-	user_access_end();
+	user_write_access_end();
 efault:
 	buf->error = -EFAULT;
 	return -EFAULT;
@@ -327,7 +327,7 @@ static int filldir64(struct dir_context *ctx, const char *name, int namlen,
 		return -EINTR;
 	dirent = buf->current_dir;
 	prev = (void __user *)dirent - prev_reclen;
-	if (!user_access_begin(prev, reclen + prev_reclen))
+	if (!user_write_access_begin(prev, reclen + prev_reclen))
 		goto efault;
 
 	/* This might be 'dirent->d_off', but if so it will get overwritten */
@@ -336,7 +336,7 @@ static int filldir64(struct dir_context *ctx, const char *name, int namlen,
 	unsafe_put_user(reclen, &dirent->d_reclen, efault_end);
 	unsafe_put_user(d_type, &dirent->d_type, efault_end);
 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
-	user_access_end();
+	user_write_access_end();
 
 	buf->prev_reclen = reclen;
 	buf->current_dir = (void __user *)dirent + reclen;
@@ -344,7 +344,7 @@ static int filldir64(struct dir_context *ctx, const char *name, int namlen,
 	return 0;
 
 efault_end:
-	user_access_end();
+	user_write_access_end();
 efault:
 	buf->error = -EFAULT;
 	return -EFAULT;
diff --git a/kernel/compat.c b/kernel/compat.c
index 843dd17e6078..b8d2800bb4b7 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -199,7 +199,7 @@ long compat_get_bitmap(unsigned long *mask, const compat_ulong_t __user *umask,
 	bitmap_size = ALIGN(bitmap_size, BITS_PER_COMPAT_LONG);
 	nr_compat_longs = BITS_TO_COMPAT_LONGS(bitmap_size);
 
-	if (!user_access_begin(umask, bitmap_size / 8))
+	if (!user_read_access_begin(umask, bitmap_size / 8))
 		return -EFAULT;
 
 	while (nr_compat_longs > 1) {
@@ -211,11 +211,11 @@ long compat_get_bitmap(unsigned long *mask, const compat_ulong_t __user *umask,
 	}
 	if (nr_compat_longs)
 		unsafe_get_user(*mask, umask++, Efault);
-	user_access_end();
+	user_read_access_end();
 	return 0;
 
 Efault:
-	user_access_end();
+	user_read_access_end();
 	return -EFAULT;
 }
 
@@ -228,7 +228,7 @@ long compat_put_bitmap(compat_ulong_t __user *umask, unsigned long *mask,
 	bitmap_size = ALIGN(bitmap_size, BITS_PER_COMPAT_LONG);
 	nr_compat_longs = BITS_TO_COMPAT_LONGS(bitmap_size);
 
-	if (!user_access_begin(umask, bitmap_size / 8))
+	if (!user_write_access_begin(umask, bitmap_size / 8))
 		return -EFAULT;
 
 	while (nr_compat_longs > 1) {
@@ -239,10 +239,10 @@ long compat_put_bitmap(compat_ulong_t __user *umask, unsigned long *mask,
 	}
 	if (nr_compat_longs)
 		unsafe_put_user((compat_ulong_t)*mask, umask++, Efault);
-	user_access_end();
+	user_write_access_end();
 	return 0;
 Efault:
-	user_access_end();
+	user_write_access_end();
 	return -EFAULT;
 }
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 389a88cb3081..2d97cbba512d 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1557,7 +1557,7 @@ SYSCALL_DEFINE5(waitid, int, which, pid_t, upid, struct siginfo __user *,
 	if (!infop)
 		return err;
 
-	if (!user_access_begin(infop, sizeof(*infop)))
+	if (!user_write_access_begin(infop, sizeof(*infop)))
 		return -EFAULT;
 
 	unsafe_put_user(signo, &infop->si_signo, Efault);
@@ -1566,10 +1566,10 @@ SYSCALL_DEFINE5(waitid, int, which, pid_t, upid, struct siginfo __user *,
 	unsafe_put_user(info.pid, &infop->si_pid, Efault);
 	unsafe_put_user(info.uid, &infop->si_uid, Efault);
 	unsafe_put_user(info.status, &infop->si_status, Efault);
-	user_access_end();
+	user_write_access_end();
 	return err;
 Efault:
-	user_access_end();
+	user_write_access_end();
 	return -EFAULT;
 }
 
@@ -1684,7 +1684,7 @@ COMPAT_SYSCALL_DEFINE5(waitid,
 	if (!infop)
 		return err;
 
-	if (!user_access_begin(infop, sizeof(*infop)))
+	if (!user_write_access_begin(infop, sizeof(*infop)))
 		return -EFAULT;
 
 	unsafe_put_user(signo, &infop->si_signo, Efault);
@@ -1693,10 +1693,10 @@ COMPAT_SYSCALL_DEFINE5(waitid,
 	unsafe_put_user(info.pid, &infop->si_pid, Efault);
 	unsafe_put_user(info.uid, &infop->si_uid, Efault);
 	unsafe_put_user(info.status, &infop->si_status, Efault);
-	user_access_end();
+	user_write_access_end();
 	return err;
 Efault:
-	user_access_end();
+	user_write_access_end();
 	return -EFAULT;
 }
 #endif
diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index 706020b06617..b90ec550183a 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -116,9 +116,9 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 
 		kasan_check_write(dst, count);
 		check_object_size(dst, count, false);
-		if (user_access_begin(src, max)) {
+		if (user_read_access_begin(src, max)) {
 			retval = do_strncpy_from_user(dst, src, count, max);
-			user_access_end();
+			user_read_access_end();
 			return retval;
 		}
 	}
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 41670d4a5816..1616710b8a82 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -109,9 +109,9 @@ long strnlen_user(const char __user *str, long count)
 		if (max > count)
 			max = count;
 
-		if (user_access_begin(str, max)) {
+		if (user_read_access_begin(str, max)) {
 			retval = do_strnlen_user(str, count, max);
-			user_access_end();
+			user_read_access_end();
 			return retval;
 		}
 	}
diff --git a/lib/usercopy.c b/lib/usercopy.c
index cbb4d9ec00f2..ca2a697a2061 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -58,7 +58,7 @@ int check_zeroed_user(const void __user *from, size_t size)
 	from -= align;
 	size += align;
 
-	if (!user_access_begin(from, size))
+	if (!user_read_access_begin(from, size))
 		return -EFAULT;
 
 	unsafe_get_user(val, (unsigned long __user *) from, err_fault);
@@ -79,10 +79,10 @@ int check_zeroed_user(const void __user *from, size_t size)
 		val &= aligned_byte_mask(size);
 
 done:
-	user_access_end();
+	user_read_access_end();
 	return (val == 0);
 err_fault:
-	user_access_end();
+	user_read_access_end();
 	return -EFAULT;
 }
 EXPORT_SYMBOL(check_zeroed_user);
-- 
2.11.0

