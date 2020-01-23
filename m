Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4398A146890
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 14:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgAWM75 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 07:59:57 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:3176 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgAWM74 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 07:59:56 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 483Mn46sR5z9vB4Z;
        Thu, 23 Jan 2020 13:59:52 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=cpigVkHf; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ye82euo1eSlt; Thu, 23 Jan 2020 13:59:52 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 483Mn45Rmtz9vB4X;
        Thu, 23 Jan 2020 13:59:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579784392; bh=y3mCq62z8QvBHB/lDe1I9sTNmtZcrMNh5y5Vki0onEE=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=cpigVkHfJgSSTDA00DxU2scK4Rca1sAxhbjcOWb8jiWHowf2s1qShrxF+apnrpyXN
         L93hAuZNOjAXZqV1WnCT8GVRnd8hPVboEyKyK1neBsuGJrcG6uagLhkUCI3C/6/2si
         +I2qMd4mFfI3MY/I7H1HrpG47DrkCldDbPruXlkQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0B6F18B82C;
        Thu, 23 Jan 2020 13:59:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id yFkjLN7K3l7s; Thu, 23 Jan 2020 13:59:53 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6F9738B826;
        Thu, 23 Jan 2020 13:59:53 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3DE38651C0; Thu, 23 Jan 2020 12:59:53 +0000 (UTC)
Message-Id: <e11a8f0670251267f87e3114e0bdbacb1eb72980.1579783936.git.christophe.leroy@c-s.fr>
In-Reply-To: <fed4f49349913cb6739dac647ba6a61d56b989d2.1579783936.git.christophe.leroy@c-s.fr>
References: <fed4f49349913cb6739dac647ba6a61d56b989d2.1579783936.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 2/7] uaccess: Tell user_access_begin() if it's for a write
 or not
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, x86@kernel.org
Date:   Thu, 23 Jan 2020 12:59:53 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 32 bits powerPC (book3s/32), only write accesses to user are
protected and there is no point spending time on unlocking for reads.

On 64 bits powerpc (book3s/64 at least), access can be granted
read only, write only or read/write.

Add an argument to user_access_begin() to tell when it's for write and
return an opaque key that will be used by user_access_end() to know
what was done by user_access_begin().

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v3: new
---
 arch/x86/include/asm/uaccess.h                 |  5 +++--
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 15 ++++++++++-----
 fs/readdir.c                                   | 16 ++++++++++------
 include/linux/uaccess.h                        |  4 ++--
 kernel/compat.c                                | 16 ++++++++++------
 kernel/exit.c                                  | 17 +++++++++++------
 lib/strncpy_from_user.c                        |  6 ++++--
 lib/strnlen_user.c                             |  6 ++++--
 lib/usercopy.c                                 |  8 +++++---
 9 files changed, 59 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 61d93f062a36..05eccdc0366a 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -709,7 +709,8 @@ extern struct movsl_mask {
  * checking before using them, but you have to surround them with the
  * user_access_begin/end() pair.
  */
-static __must_check __always_inline bool user_access_begin(const void __user *ptr, size_t len)
+static __must_check __always_inline unsigned long
+user_access_begin(const void __user *ptr, size_t len, bool write)
 {
 	if (unlikely(!access_ok(ptr,len)))
 		return 0;
@@ -717,7 +718,7 @@ static __must_check __always_inline bool user_access_begin(const void __user *pt
 	return 1;
 }
 #define user_access_begin(a,b)	user_access_begin(a,b)
-#define user_access_end()	__uaccess_end()
+#define user_access_end(x)	__uaccess_end()
 
 #define user_access_save()	smap_save()
 #define user_access_restore(x)	smap_restore(x)
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index bc3a67226163..509bfb6116ac 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -1615,6 +1615,7 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
 	const unsigned int count = eb->buffer_count;
 	unsigned int i;
 	int err;
+	unsigned long key;
 
 	for (i = 0; i < count; i++) {
 		const unsigned int nreloc = eb->exec[i].relocation_count;
@@ -1662,14 +1663,15 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
 		 * happened we would make the mistake of assuming that the
 		 * relocations were valid.
 		 */
-		if (!user_access_begin(urelocs, size))
+		key = user_access_begin(urelocs, size, true);
+		if (!key)
 			goto end;
 
 		for (copied = 0; copied < nreloc; copied++)
 			unsafe_put_user(-1,
 					&urelocs[copied].presumed_offset,
 					end_user);
-		user_access_end();
+		user_access_end(key);
 
 		eb->exec[i].relocs_ptr = (uintptr_t)relocs;
 	}
@@ -1677,7 +1679,7 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
 	return 0;
 
 end_user:
-	user_access_end();
+	user_access_end(key);
 end:
 	kvfree(relocs);
 	err = -EFAULT;
@@ -2906,6 +2908,7 @@ i915_gem_execbuffer2_ioctl(struct drm_device *dev, void *data,
 		struct drm_i915_gem_exec_object2 __user *user_exec_list =
 			u64_to_user_ptr(args->buffers_ptr);
 		unsigned int i;
+		unsigned long key;
 
 		/* Copy the new buffer offsets back to the user's exec list. */
 		/*
@@ -2915,7 +2918,9 @@ i915_gem_execbuffer2_ioctl(struct drm_device *dev, void *data,
 		 * And this range already got effectively checked earlier
 		 * when we did the "copy_from_user()" above.
 		 */
-		if (!user_access_begin(user_exec_list, count * sizeof(*user_exec_list)))
+		key = user_access_begin(user_exec_list,
+					count * sizeof(*user_exec_list), true);
+		if (!key)
 			goto end;
 
 		for (i = 0; i < args->buffer_count; i++) {
@@ -2929,7 +2934,7 @@ i915_gem_execbuffer2_ioctl(struct drm_device *dev, void *data,
 					end_user);
 		}
 end_user:
-		user_access_end();
+		user_access_end(key);
 end:;
 	}
 
diff --git a/fs/readdir.c b/fs/readdir.c
index 4b466cbb0f3a..47b9ef97e16e 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -221,6 +221,7 @@ static int filldir(struct dir_context *ctx, const char *name, int namlen,
 	int reclen = ALIGN(offsetof(struct linux_dirent, d_name) + namlen + 2,
 		sizeof(long));
 	int prev_reclen;
+	unsigned long key;
 
 	buf->error = verify_dirent_name(name, namlen);
 	if (unlikely(buf->error))
@@ -238,7 +239,8 @@ static int filldir(struct dir_context *ctx, const char *name, int namlen,
 		return -EINTR;
 	dirent = buf->current_dir;
 	prev = (void __user *)dirent - prev_reclen;
-	if (!user_access_begin(prev, reclen + prev_reclen))
+	key = user_access_begin(prev, reclen + prev_reclen, true);
+	if (!key)
 		goto efault;
 
 	/* This might be 'dirent->d_off', but if so it will get overwritten */
@@ -247,14 +249,14 @@ static int filldir(struct dir_context *ctx, const char *name, int namlen,
 	unsafe_put_user(reclen, &dirent->d_reclen, efault_end);
 	unsafe_put_user(d_type, (char __user *) dirent + reclen - 1, efault_end);
 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
-	user_access_end();
+	user_access_end(key);
 
 	buf->current_dir = (void __user *)dirent + reclen;
 	buf->prev_reclen = reclen;
 	buf->count -= reclen;
 	return 0;
 efault_end:
-	user_access_end();
+	user_access_end(key);
 efault:
 	buf->error = -EFAULT;
 	return -EFAULT;
@@ -311,6 +313,7 @@ static int filldir64(struct dir_context *ctx, const char *name, int namlen,
 	int reclen = ALIGN(offsetof(struct linux_dirent64, d_name) + namlen + 1,
 		sizeof(u64));
 	int prev_reclen;
+	unsigned long key;
 
 	buf->error = verify_dirent_name(name, namlen);
 	if (unlikely(buf->error))
@@ -323,7 +326,8 @@ static int filldir64(struct dir_context *ctx, const char *name, int namlen,
 		return -EINTR;
 	dirent = buf->current_dir;
 	prev = (void __user *)dirent - prev_reclen;
-	if (!user_access_begin(prev, reclen + prev_reclen))
+	key = user_access_begin(prev, reclen + prev_reclen, true);
+	if (!key)
 		goto efault;
 
 	/* This might be 'dirent->d_off', but if so it will get overwritten */
@@ -332,7 +336,7 @@ static int filldir64(struct dir_context *ctx, const char *name, int namlen,
 	unsafe_put_user(reclen, &dirent->d_reclen, efault_end);
 	unsafe_put_user(d_type, &dirent->d_type, efault_end);
 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
-	user_access_end();
+	user_access_end(key);
 
 	buf->prev_reclen = reclen;
 	dirent = (void __user *)dirent + reclen;
@@ -341,7 +345,7 @@ static int filldir64(struct dir_context *ctx, const char *name, int namlen,
 	return 0;
 
 efault_end:
-	user_access_end();
+	user_access_end(key);
 efault:
 	buf->error = -EFAULT;
 	return -EFAULT;
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 67f016010aad..394f5029a727 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -369,8 +369,8 @@ extern long strnlen_unsafe_user(const void __user *unsafe_addr, long count);
 	probe_kernel_read(&retval, addr, sizeof(retval))
 
 #ifndef user_access_begin
-#define user_access_begin(ptr,len) access_ok(ptr, len)
-#define user_access_end() do { } while (0)
+#define user_access_begin(ptr, len, write) access_ok(ptr, len)
+#define user_access_end(x) do { } while (0)
 #define unsafe_op_wrap(op, err) do { if (unlikely(op)) goto err; } while (0)
 #define unsafe_get_user(x,p,e) unsafe_op_wrap(__get_user(x,p),e)
 #define unsafe_put_user(x,p,e) unsafe_op_wrap(__put_user(x,p),e)
diff --git a/kernel/compat.c b/kernel/compat.c
index 95005f849c68..4bcbe1cd761b 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -258,12 +258,14 @@ long compat_get_bitmap(unsigned long *mask, const compat_ulong_t __user *umask,
 		       unsigned long bitmap_size)
 {
 	unsigned long nr_compat_longs;
+	unsigned long key;
 
 	/* align bitmap up to nearest compat_long_t boundary */
 	bitmap_size = ALIGN(bitmap_size, BITS_PER_COMPAT_LONG);
 	nr_compat_longs = BITS_TO_COMPAT_LONGS(bitmap_size);
 
-	if (!user_access_begin(umask, bitmap_size / 8))
+	key = user_access_begin(umask, bitmap_size / 8, false);
+	if (!key)
 		return -EFAULT;
 
 	while (nr_compat_longs > 1) {
@@ -275,11 +277,11 @@ long compat_get_bitmap(unsigned long *mask, const compat_ulong_t __user *umask,
 	}
 	if (nr_compat_longs)
 		unsafe_get_user(*mask, umask++, Efault);
-	user_access_end();
+	user_access_end(key);
 	return 0;
 
 Efault:
-	user_access_end();
+	user_access_end(key);
 	return -EFAULT;
 }
 
@@ -287,12 +289,14 @@ long compat_put_bitmap(compat_ulong_t __user *umask, unsigned long *mask,
 		       unsigned long bitmap_size)
 {
 	unsigned long nr_compat_longs;
+	unsigned long key;
 
 	/* align bitmap up to nearest compat_long_t boundary */
 	bitmap_size = ALIGN(bitmap_size, BITS_PER_COMPAT_LONG);
 	nr_compat_longs = BITS_TO_COMPAT_LONGS(bitmap_size);
 
-	if (!user_access_begin(umask, bitmap_size / 8))
+	key = user_access_begin(umask, bitmap_size / 8, true);
+	if (!key)
 		return -EFAULT;
 
 	while (nr_compat_longs > 1) {
@@ -303,10 +307,10 @@ long compat_put_bitmap(compat_ulong_t __user *umask, unsigned long *mask,
 	}
 	if (nr_compat_longs)
 		unsafe_put_user((compat_ulong_t)*mask, umask++, Efault);
-	user_access_end();
+	user_access_end(key);
 	return 0;
 Efault:
-	user_access_end();
+	user_access_end(key);
 	return -EFAULT;
 }
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 2833ffb0c211..1cb9c8a879d2 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1553,6 +1553,7 @@ SYSCALL_DEFINE5(waitid, int, which, pid_t, upid, struct siginfo __user *,
 	struct waitid_info info = {.status = 0};
 	long err = kernel_waitid(which, upid, &info, options, ru ? &r : NULL);
 	int signo = 0;
+	unsigned long key;
 
 	if (err > 0) {
 		signo = SIGCHLD;
@@ -1563,7 +1564,8 @@ SYSCALL_DEFINE5(waitid, int, which, pid_t, upid, struct siginfo __user *,
 	if (!infop)
 		return err;
 
-	if (!user_access_begin(infop, sizeof(*infop)))
+	key = user_access_begin(infop, sizeof(*infop), true);
+	if (!key)
 		return -EFAULT;
 
 	unsafe_put_user(signo, &infop->si_signo, Efault);
@@ -1572,10 +1574,10 @@ SYSCALL_DEFINE5(waitid, int, which, pid_t, upid, struct siginfo __user *,
 	unsafe_put_user(info.pid, &infop->si_pid, Efault);
 	unsafe_put_user(info.uid, &infop->si_uid, Efault);
 	unsafe_put_user(info.status, &infop->si_status, Efault);
-	user_access_end();
+	user_access_end(key);
 	return err;
 Efault:
-	user_access_end();
+	user_access_end(key);
 	return -EFAULT;
 }
 
@@ -1673,6 +1675,8 @@ COMPAT_SYSCALL_DEFINE5(waitid,
 	struct waitid_info info = {.status = 0};
 	long err = kernel_waitid(which, pid, &info, options, uru ? &ru : NULL);
 	int signo = 0;
+	unsigned long key;
+
 	if (err > 0) {
 		signo = SIGCHLD;
 		err = 0;
@@ -1690,7 +1694,8 @@ COMPAT_SYSCALL_DEFINE5(waitid,
 	if (!infop)
 		return err;
 
-	if (!user_access_begin(infop, sizeof(*infop)))
+	key = user_access_begin(infop, sizeof(*infop), true);
+	if (!key)
 		return -EFAULT;
 
 	unsafe_put_user(signo, &infop->si_signo, Efault);
@@ -1699,10 +1704,10 @@ COMPAT_SYSCALL_DEFINE5(waitid,
 	unsafe_put_user(info.pid, &infop->si_pid, Efault);
 	unsafe_put_user(info.uid, &infop->si_uid, Efault);
 	unsafe_put_user(info.status, &infop->si_status, Efault);
-	user_access_end();
+	user_access_end(key);
 	return err;
 Efault:
-	user_access_end();
+	user_access_end(key);
 	return -EFAULT;
 }
 #endif
diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index dccb95af6003..7184fb766439 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -113,12 +113,14 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 	if (likely(src_addr < max_addr)) {
 		unsigned long max = max_addr - src_addr;
 		long retval;
+		unsigned long key;
 
 		kasan_check_write(dst, count);
 		check_object_size(dst, count, false);
-		if (user_access_begin(src, max)) {
+		key = user_access_begin(src, max, false);
+		if (key) {
 			retval = do_strncpy_from_user(dst, src, count, max);
-			user_access_end();
+			user_access_end(key);
 			return retval;
 		}
 	}
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 6c0005d5dd5c..819e355b8608 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -108,10 +108,12 @@ long strnlen_user(const char __user *str, long count)
 	if (likely(src_addr < max_addr)) {
 		unsigned long max = max_addr - src_addr;
 		long retval;
+		unsigned long key;
 
-		if (user_access_begin(str, max)) {
+		key = user_access_begin(str, max, false);
+		if (key) {
 			retval = do_strnlen_user(str, count, max);
-			user_access_end();
+			user_access_end(key);
 			return retval;
 		}
 	}
diff --git a/lib/usercopy.c b/lib/usercopy.c
index cbb4d9ec00f2..9e03ca88ad32 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -51,6 +51,7 @@ int check_zeroed_user(const void __user *from, size_t size)
 {
 	unsigned long val;
 	uintptr_t align = (uintptr_t) from % sizeof(unsigned long);
+	unsigned long key;
 
 	if (unlikely(size == 0))
 		return 1;
@@ -58,7 +59,8 @@ int check_zeroed_user(const void __user *from, size_t size)
 	from -= align;
 	size += align;
 
-	if (!user_access_begin(from, size))
+	key = user_access_begin(from, size, false);
+	if (!key)
 		return -EFAULT;
 
 	unsafe_get_user(val, (unsigned long __user *) from, err_fault);
@@ -79,10 +81,10 @@ int check_zeroed_user(const void __user *from, size_t size)
 		val &= aligned_byte_mask(size);
 
 done:
-	user_access_end();
+	user_access_end(key);
 	return (val == 0);
 err_fault:
-	user_access_end();
+	user_access_end(key);
 	return -EFAULT;
 }
 EXPORT_SYMBOL(check_zeroed_user);
-- 
2.25.0

