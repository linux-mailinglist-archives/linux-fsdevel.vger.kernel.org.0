Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C4A4836E9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 19:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbiACSfM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 13:35:12 -0500
Received: from drummond.us ([74.95.14.229]:40377 "EHLO
        talisker.home.drummond.us" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235681AbiACSfG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 13:35:06 -0500
X-Greylist: delayed 836 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jan 2022 13:34:55 EST
Received: from talisker.home.drummond.us (localhost [127.0.0.1])
        by talisker.home.drummond.us (8.15.2/8.15.2/Debian-20) with ESMTP id 203IKWH6983492;
        Mon, 3 Jan 2022 10:20:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=home.drummond.us;
        s=default; t=1641234032;
        bh=s0/ZBp9Jrtlt/uuSXSFQcrmEVihhU+gaTmMV80bD7Vk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GQhAKvpJMy7NCbgHgjLqOk8bgZX3S+KH52GLsgvI3GmlwB1DChH30sUNhgIvpvgt9
         HVN0P+YwVKbaIXk2Z3aIowaP18Hxs4CBD2QZHHJOF1qPM9lEMLuUdiDOaD0+yksxIe
         a5mAgFp8dD545UVdCRWUvGJqYqMNzlhLd3m0D8AVJCr5ItcRGcj0HJevqga7i/VQ9k
         KyqK1cvlqktZ0WWgL4g5mmW0U6DqU6ysFR6t9WSkfUYqiFBI/Yq9IiisQAIH+K/Rmq
         s/EqkY2v3XWZttQbGkF5QEBMWjFS16B8OLRUUUiGUft0xNyMgWa9R0hi5yu3dSMwT1
         2j/1J/Ep0lpZQ==
Received: (from walt@localhost)
        by talisker.home.drummond.us (8.15.2/8.15.2/Submit) id 203IKW7q983491;
        Mon, 3 Jan 2022 10:20:32 -0800
From:   Walt Drummond <walt@drummond.us>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Walt Drummond <walt@drummond.us>,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org
Subject: [RFC PATCH 1/8] signals: Make the real-time signal system calls accept different sized sigset_t from user space.
Date:   Mon,  3 Jan 2022 10:19:49 -0800
Message-Id: <20220103181956.983342-2-walt@drummond.us>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220103181956.983342-1-walt@drummond.us>
References: <20220103181956.983342-1-walt@drummond.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The real-time signals API provides a mechanism for user space to tell
the kernel how many bytes is has in sigset_t. Make these system calls
use that mechanism and accept differently sized sigset_t.

Add a value to the auxvec to inform user space of the maximum size
sigset_t the kernel can accept.

Signed-off-by: Walt Drummond <walt@drummond.us>
---
 fs/binfmt_elf.c             |   1 +
 fs/binfmt_elf_fdpic.c       |   1 +
 fs/signalfd.c               |  24 +++---
 include/linux/compat.h      |  98 +++++++++++++++++++++---
 include/linux/signal.h      |  62 +++++++++++++++
 include/uapi/linux/auxvec.h |   1 +
 kernel/compat.c             |  24 ------
 kernel/ptrace.c             |  16 ++--
 kernel/signal.c             | 147 +++++++++++++++++++-----------------
 virt/kvm/kvm_main.c         |  16 ++--
 10 files changed, 257 insertions(+), 133 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index a813b70f594e..7133515fd386 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -274,6 +274,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 #ifdef ELF_HWCAP2
 	NEW_AUX_ENT(AT_HWCAP2, ELF_HWCAP2);
 #endif
+	NEW_AUX_ENT(AT_SIGSET_SZ, SIGSETSIZE_MAX);
 	NEW_AUX_ENT(AT_EXECFN, bprm->exec);
 	if (k_platform) {
 		NEW_AUX_ENT(AT_PLATFORM,
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 6d8fd6030cbb..09249dc4364b 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -659,6 +659,7 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	NEW_AUX_ENT(AT_EGID,	(elf_addr_t) from_kgid_munged(cred->user_ns, cred->egid));
 	NEW_AUX_ENT(AT_SECURE,	bprm->secureexec);
 	NEW_AUX_ENT(AT_EXECFN,	bprm->exec);
+	NEW_AUX_ENT(AT_SIGSET_SZ, SIGSETSIZE_MAX);
 
 #ifdef ARCH_DLINFO
 	nr = 0;
diff --git a/fs/signalfd.c b/fs/signalfd.c
index 040e1cf90528..12fdc282e299 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -311,24 +311,24 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
 SYSCALL_DEFINE4(signalfd4, int, ufd, sigset_t __user *, user_mask,
 		size_t, sizemask, int, flags)
 {
+	int ret;
 	sigset_t mask;
 
-	if (sizemask != sizeof(sigset_t))
-		return -EINVAL;
-	if (copy_from_user(&mask, user_mask, sizeof(mask)))
-		return -EFAULT;
+	ret = copy_sigset_from_user(&mask, user_mask, sizemask);
+	if (ret)
+		return ret;
 	return do_signalfd4(ufd, &mask, flags);
 }
 
 SYSCALL_DEFINE3(signalfd, int, ufd, sigset_t __user *, user_mask,
 		size_t, sizemask)
 {
+	int ret;
 	sigset_t mask;
 
-	if (sizemask != sizeof(sigset_t))
-		return -EINVAL;
-	if (copy_from_user(&mask, user_mask, sizeof(mask)))
-		return -EFAULT;
+	ret = copy_sigset_from_user(&mask, user_mask, sizemask);
+	if (ret)
+		return ret;
 	return do_signalfd4(ufd, &mask, 0);
 }
 
@@ -338,11 +338,11 @@ static long do_compat_signalfd4(int ufd,
 			compat_size_t sigsetsize, int flags)
 {
 	sigset_t mask;
+	int ret;
 
-	if (sigsetsize != sizeof(compat_sigset_t))
-		return -EINVAL;
-	if (get_compat_sigset(&mask, user_mask))
-		return -EFAULT;
+	ret = copy_compat_sigset_from_user(&mask, user_mask, sigsetsize);
+	if (ret)
+		return ret;
 	return do_signalfd4(ufd, &mask, flags);
 }
 
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 1c758b0e0359..ecdbff1d2218 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -407,33 +407,109 @@ int __copy_siginfo_to_user32(struct compat_siginfo __user *to,
 int get_compat_sigevent(struct sigevent *event,
 		const struct compat_sigevent __user *u_event);
 
-extern int get_compat_sigset(sigset_t *set, const compat_sigset_t __user *compat);
-
 /*
  * Defined inline such that size can be compile time constant, which avoids
  * CONFIG_HARDENED_USERCOPY complaining about copies from task_struct
  */
 static inline int
-put_compat_sigset(compat_sigset_t __user *compat, const sigset_t *set,
-		  unsigned int size)
+copy_compat_sigset_to_user(compat_sigset_t __user *compat, const sigset_t *set,
+			   size_t sigsetsize)
 {
-	/* size <= sizeof(compat_sigset_t) <= sizeof(sigset_t) */
+	size_t copybytes;
 #if defined(__BIG_ENDIAN) && defined(CONFIG_64BIT)
 	compat_sigset_t v;
+	int i;
+#endif
+
+	if (!valid_sigsetsize(sigsetsize))
+		return -EINVAL;
+
+	copybytes = min(sizeof(compat_sigset_t), sigsetsize);
+
+#if defined(__BIG_ENDIAN) && defined(CONFIG_64BIT)
+	switch (_NSIG_WORDS) {
+	default:
+		for (i = 0; i < _NSIG_WORDS; i++) {
+			v.sig[(i * 2)]     = set->sig[i];
+			v.sig[(i * 2) + 1] = set->sig[i] >> 32;
+		}
+		break;
+	case 4:
+		v.sig[7] = (set->sig[3] >> 32);
+		v.sig[6] =  set->sig[3];
+		fallthrough;
+	case 3:
+		v.sig[5] = (set->sig[2] >> 32);
+		v.sig[4] =  set->sig[2];
+		fallthrough;
+	case 2:
+		v.sig[3] = (set->sig[1] >> 32);
+		v.sig[2] =  set->sig[1];
+		fallthrough;
+	case 1:
+		v.sig[1] = (set->sig[0] >> 32);
+		v.sig[0] =  set->sig[0];
+	}
+	if (copy_to_user(compat, &v, copybytes))
+		return -EFAULT;
+#else
+	if (copy_to_user(compat, set, copybytes))
+		return -EFAULT;
+#endif
+	/* Zero any unused part of mask */
+	if (sigsetsize > sizeof(compat_sigset_t)) {
+		if (clear_user((char *)compat + copybytes,
+			       sigsetsize - sizeof(compat_sigset_t)))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+#define put_compat_sigset(set, compat, size)		\
+	copy_compat_sigset_to_user((set), (compat), (size))
+
+static inline int
+copy_compat_sigset_from_user(sigset_t *set,
+			     const compat_sigset_t __user *compat, size_t size)
+{
+#if defined(__BIG_ENDIAN) && defined(CONFIG_64BIT)
+	compat_sigset_t v;
+	int i;
+#endif
+
+	if (!valid_sigsetsize(size))
+		return -EINVAL;
+
+#if defined(__BIG_ENDIAN) && defined(CONFIG_64BIT)
+	if (copy_from_user(&v, compat, min(sizeof(compat_sigset_t), size)))
+		return -EFAULT;
 	switch (_NSIG_WORDS) {
-	case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
+	default:
+		for (i = 0; i < _NSIG_WORDS; i++) {
+			set->sig[i] =    v.sig[(i * 2)] |
+				(((long) v.sig[(i * 2) + 1]) << 32);
+		}
+		break;
+	case 4:
+		set->sig[3] = v.sig[6] | (((long)v.sig[7]) << 32);
 		fallthrough;
-	case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
+	case 3:
+		set->sig[2] = v.sig[4] | (((long)v.sig[5]) << 32);
 		fallthrough;
-	case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
+	case 2:
+		set->sig[1] = v.sig[2] | (((long)v.sig[3]) << 32);
 		fallthrough;
-	case 1: v.sig[1] = (set->sig[0] >> 32); v.sig[0] = set->sig[0];
+	case 1:
+		set->sig[0] = v.sig[0] | (((long)v.sig[1]) << 32);
 	}
-	return copy_to_user(compat, &v, size) ? -EFAULT : 0;
 #else
-	return copy_to_user(compat, set, size) ? -EFAULT : 0;
+	if (copy_from_user(set, compat, min(sizeof(compat_sigset_t), size)))
+		return -EFAULT;
 #endif
+	return 0;
 }
+#define get_compat_sigset(set, compat)					\
+	copy_compat_sigset_from_user((set), (compat), sizeof(compat_sigset_t))
 
 #ifdef CONFIG_CPU_BIG_ENDIAN
 #define unsafe_put_compat_sigset(compat, set, label) do {		\
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 3f96a6374e4f..c66d4f520228 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -5,6 +5,7 @@
 #include <linux/bug.h>
 #include <linux/signal_types.h>
 #include <linux/string.h>
+#include <linux/uaccess.h>
 
 struct task_struct;
 
@@ -260,6 +261,67 @@ static inline void siginitsetinv(sigset_t *set, unsigned long mask)
 
 #endif /* __HAVE_ARCH_SIG_SETOPS */
 
+/* Safely copy a sigset_t from user space handling any differences in
+ * size between user space and kernel sigset_t.  We don't use
+ * copy_struct_from_user() here as we can't ensure that in the case
+ * where sigisetsize > sizeof(sigset_t), the unused bytes are zeroed.
+ *
+ * SIGSETSIZE_MIN *must* be 8 bytes and cannot change.
+ *
+ * SIGSETSIZE_MAX shouldn't be too small, nor should it be too large.
+ * We've somewhat randomly picked 128 bytes to keep this sync'ed with
+ * glibc and musl; this can be changed as needed.
+ */
+
+#define SIGSETSIZE_MIN 8
+#define SIGSETSIZE_MAX 128
+
+static inline int valid_sigsetsize(size_t sigsetsize)
+{
+	return  sigsetsize >= SIGSETSIZE_MIN &&
+		sigsetsize <= SIGSETSIZE_MAX;
+}
+
+static inline int copy_sigset_from_user(sigset_t *kmask,
+					const sigset_t __user *umask,
+					size_t sigsetsize)
+{
+	if (!valid_sigsetsize(sigsetsize))
+		return -EINVAL;
+
+	if (kmask == NULL)
+		return -EFAULT;
+
+	sigemptyset(kmask);
+
+	if (copy_from_user(kmask, umask, min(sizeof(sigset_t), sigsetsize)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static inline int copy_sigset_to_user(sigset_t __user *umask,
+				      sigset_t *kmask,
+				      size_t sigsetsize)
+{
+	size_t copybytes;
+
+	if (!valid_sigsetsize(sigsetsize))
+		return -EINVAL;
+
+	copybytes = min(sizeof(sigset_t), sigsetsize);
+	if (copy_to_user(umask, kmask, copybytes))
+		return -EFAULT;
+
+	/* Zero unused parts of umask */
+	if (sigsetsize > copybytes) {
+		if (clear_user((char *)umask + copybytes,
+			       sigsetsize - copybytes))
+			return -EFAULT;
+	}
+	return 0;
+}
+
 static inline void init_sigpending(struct sigpending *sig)
 {
 	sigemptyset(&sig->signal);
diff --git a/include/uapi/linux/auxvec.h b/include/uapi/linux/auxvec.h
index c7e502bf5a6f..752184abf620 100644
--- a/include/uapi/linux/auxvec.h
+++ b/include/uapi/linux/auxvec.h
@@ -30,6 +30,7 @@
 				 * differ from AT_PLATFORM. */
 #define AT_RANDOM 25	/* address of 16 random bytes */
 #define AT_HWCAP2 26	/* extension of AT_HWCAP */
+#define AT_SIGSET_SZ 27	/* sizeof(sigset_t) */
 
 #define AT_EXECFN  31	/* filename of program */
 
diff --git a/kernel/compat.c b/kernel/compat.c
index 55551989d9da..cc2438f4070c 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -245,27 +245,3 @@ long compat_put_bitmap(compat_ulong_t __user *umask, unsigned long *mask,
 	user_write_access_end();
 	return -EFAULT;
 }
-
-int
-get_compat_sigset(sigset_t *set, const compat_sigset_t __user *compat)
-{
-#ifdef __BIG_ENDIAN
-	compat_sigset_t v;
-	if (copy_from_user(&v, compat, sizeof(compat_sigset_t)))
-		return -EFAULT;
-	switch (_NSIG_WORDS) {
-	case 4: set->sig[3] = v.sig[6] | (((long)v.sig[7]) << 32 );
-		fallthrough;
-	case 3: set->sig[2] = v.sig[4] | (((long)v.sig[5]) << 32 );
-		fallthrough;
-	case 2: set->sig[1] = v.sig[2] | (((long)v.sig[3]) << 32 );
-		fallthrough;
-	case 1: set->sig[0] = v.sig[0] | (((long)v.sig[1]) << 32 );
-	}
-#else
-	if (copy_from_user(set, compat, sizeof(compat_sigset_t)))
-		return -EFAULT;
-#endif
-	return 0;
-}
-EXPORT_SYMBOL_GPL(get_compat_sigset);
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index f8589bf8d7dc..2f7ee345a629 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -1074,8 +1074,9 @@ int ptrace_request(struct task_struct *child, long request,
 
 	case PTRACE_GETSIGMASK: {
 		sigset_t *mask;
+		size_t sigsetsize = (size_t) addr;
 
-		if (addr != sizeof(sigset_t)) {
+		if (!valid_sigsetsize(sigsetsize) == 0) {
 			ret = -EINVAL;
 			break;
 		}
@@ -1085,7 +1086,7 @@ int ptrace_request(struct task_struct *child, long request,
 		else
 			mask = &child->blocked;
 
-		if (copy_to_user(datavp, mask, sizeof(sigset_t)))
+		if (copy_sigset_to_user(datavp, mask, sigsetsize))
 			ret = -EFAULT;
 		else
 			ret = 0;
@@ -1095,16 +1096,11 @@ int ptrace_request(struct task_struct *child, long request,
 
 	case PTRACE_SETSIGMASK: {
 		sigset_t new_set;
+		size_t sigsetsize = (size_t) addr;
 
-		if (addr != sizeof(sigset_t)) {
-			ret = -EINVAL;
-			break;
-		}
-
-		if (copy_from_user(&new_set, datavp, sizeof(sigset_t))) {
-			ret = -EFAULT;
+		ret = copy_sigset_from_user(&new_set, datavp, sigsetsize);
+		if (ret)
 			break;
-		}
 
 		sigdelsetmask(&new_set, sigmask(SIGKILL)|sigmask(SIGSTOP));
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 487bf4f5dadf..94b1828ae973 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3091,13 +3091,14 @@ EXPORT_SYMBOL(sigprocmask);
 int set_user_sigmask(const sigset_t __user *umask, size_t sigsetsize)
 {
 	sigset_t kmask;
+	int ret;
 
 	if (!umask)
 		return 0;
-	if (sigsetsize != sizeof(sigset_t))
-		return -EINVAL;
-	if (copy_from_user(&kmask, umask, sizeof(sigset_t)))
-		return -EFAULT;
+
+	ret = copy_sigset_from_user(&kmask, umask, sigsetsize);
+	if (ret)
+		return ret;
 
 	set_restore_sigmask();
 	current->saved_sigmask = current->blocked;
@@ -3111,13 +3112,14 @@ int set_compat_user_sigmask(const compat_sigset_t __user *umask,
 			    size_t sigsetsize)
 {
 	sigset_t kmask;
+	int ret;
 
 	if (!umask)
 		return 0;
-	if (sigsetsize != sizeof(compat_sigset_t))
-		return -EINVAL;
-	if (get_compat_sigset(&kmask, umask))
-		return -EFAULT;
+
+	ret = copy_compat_sigset_from_user(&kmask, umask, sigsetsize);
+	if (ret)
+		return ret;
 
 	set_restore_sigmask();
 	current->saved_sigmask = current->blocked;
@@ -3140,14 +3142,13 @@ SYSCALL_DEFINE4(rt_sigprocmask, int, how, sigset_t __user *, nset,
 	sigset_t old_set, new_set;
 	int error;
 
-	/* XXX: Don't preclude handling different sized sigset_t's.  */
-	if (sigsetsize != sizeof(sigset_t))
+	if (!valid_sigsetsize(sigsetsize))
 		return -EINVAL;
 
 	old_set = current->blocked;
 
 	if (nset) {
-		if (copy_from_user(&new_set, nset, sizeof(sigset_t)))
+		if (copy_sigset_from_user(&new_set, nset, sigsetsize))
 			return -EFAULT;
 		sigdelsetmask(&new_set, sigmask(SIGKILL)|sigmask(SIGSTOP));
 
@@ -3157,7 +3158,7 @@ SYSCALL_DEFINE4(rt_sigprocmask, int, how, sigset_t __user *, nset,
 	}
 
 	if (oset) {
-		if (copy_to_user(oset, &old_set, sizeof(sigset_t)))
+		if (copy_sigset_to_user(oset, &old_set, sigsetsize))
 			return -EFAULT;
 	}
 
@@ -3168,16 +3169,16 @@ SYSCALL_DEFINE4(rt_sigprocmask, int, how, sigset_t __user *, nset,
 COMPAT_SYSCALL_DEFINE4(rt_sigprocmask, int, how, compat_sigset_t __user *, nset,
 		compat_sigset_t __user *, oset, compat_size_t, sigsetsize)
 {
-	sigset_t old_set = current->blocked;
+	sigset_t old_set, new_set;
+	int error;
 
-	/* XXX: Don't preclude handling different sized sigset_t's.  */
-	if (sigsetsize != sizeof(sigset_t))
+	if (!valid_sigsetsize(sigsetsize))
 		return -EINVAL;
 
+	old_set = current->blocked;
+
 	if (nset) {
-		sigset_t new_set;
-		int error;
-		if (get_compat_sigset(&new_set, nset))
+		if (copy_compat_sigset_from_user(&new_set, nset, sigsetsize))
 			return -EFAULT;
 		sigdelsetmask(&new_set, sigmask(SIGKILL)|sigmask(SIGSTOP));
 
@@ -3185,7 +3186,12 @@ COMPAT_SYSCALL_DEFINE4(rt_sigprocmask, int, how, compat_sigset_t __user *, nset,
 		if (error)
 			return error;
 	}
-	return oset ? put_compat_sigset(oset, &old_set, sizeof(*oset)) : 0;
+	if (oset) {
+		if (copy_compat_sigset_to_user(oset, &old_set, sigsetsize))
+			return -EFAULT;
+	}
+
+	return 0;
 }
 #endif
 
@@ -3210,12 +3216,12 @@ SYSCALL_DEFINE2(rt_sigpending, sigset_t __user *, uset, size_t, sigsetsize)
 {
 	sigset_t set;
 
-	if (sigsetsize > sizeof(*uset))
+	if (!valid_sigsetsize(sigsetsize))
 		return -EINVAL;
 
 	do_sigpending(&set);
 
-	if (copy_to_user(uset, &set, sigsetsize))
+	if (copy_sigset_to_user(uset, &set, sigsetsize))
 		return -EFAULT;
 
 	return 0;
@@ -3227,12 +3233,15 @@ COMPAT_SYSCALL_DEFINE2(rt_sigpending, compat_sigset_t __user *, uset,
 {
 	sigset_t set;
 
-	if (sigsetsize > sizeof(*uset))
+	if (!valid_sigsetsize(sigsetsize))
 		return -EINVAL;
 
 	do_sigpending(&set);
 
-	return put_compat_sigset(uset, &set, sigsetsize);
+	if (copy_compat_sigset_to_user(uset, &set, sigsetsize))
+		return -EFAULT;
+
+	return 0;
 }
 #endif
 
@@ -3627,12 +3636,9 @@ SYSCALL_DEFINE4(rt_sigtimedwait, const sigset_t __user *, uthese,
 	kernel_siginfo_t info;
 	int ret;
 
-	/* XXX: Don't preclude handling different sized sigset_t's.  */
-	if (sigsetsize != sizeof(sigset_t))
-		return -EINVAL;
-
-	if (copy_from_user(&these, uthese, sizeof(these)))
-		return -EFAULT;
+	ret = copy_sigset_from_user(&these, uthese, sigsetsize);
+	if (ret)
+		return ret;
 
 	if (uts) {
 		if (get_timespec64(&ts, uts))
@@ -3660,11 +3666,9 @@ SYSCALL_DEFINE4(rt_sigtimedwait_time32, const sigset_t __user *, uthese,
 	kernel_siginfo_t info;
 	int ret;
 
-	if (sigsetsize != sizeof(sigset_t))
-		return -EINVAL;
-
-	if (copy_from_user(&these, uthese, sizeof(these)))
-		return -EFAULT;
+	ret = copy_sigset_from_user(&these, uthese, sigsetsize);
+	if (ret)
+		return ret;
 
 	if (uts) {
 		if (get_old_timespec32(&ts, uts))
@@ -3692,11 +3696,9 @@ COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait_time64, compat_sigset_t __user *, uthese,
 	kernel_siginfo_t info;
 	long ret;
 
-	if (sigsetsize != sizeof(sigset_t))
-		return -EINVAL;
-
-	if (get_compat_sigset(&s, uthese))
-		return -EFAULT;
+	ret = copy_compat_sigset_from_user(&s, uthese, sigsetsize);
+	if (ret)
+		return ret;
 
 	if (uts) {
 		if (get_timespec64(&t, uts))
@@ -3723,11 +3725,9 @@ COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait_time32, compat_sigset_t __user *, uthese,
 	kernel_siginfo_t info;
 	long ret;
 
-	if (sigsetsize != sizeof(sigset_t))
-		return -EINVAL;
-
-	if (get_compat_sigset(&s, uthese))
-		return -EFAULT;
+	ret = copy_compat_sigset_from_user(&s, uthese, sigsetsize);
+	if (ret)
+		return ret;
 
 	if (uts) {
 		if (get_old_timespec32(&t, uts))
@@ -4370,21 +4370,36 @@ SYSCALL_DEFINE4(rt_sigaction, int, sig,
 		size_t, sigsetsize)
 {
 	struct k_sigaction new_sa, old_sa;
+	size_t sa_len = sizeof(struct sigaction) - sizeof(sigset_t);
 	int ret;
 
-	/* XXX: Don't preclude handling different sized sigset_t's.  */
-	if (sigsetsize != sizeof(sigset_t))
-		return -EINVAL;
+	/* struct sigaction contains a sigset_t; handle cases where
+	 * user and kernel sizes of sigset_t differ.
+	 */
 
-	if (act && copy_from_user(&new_sa.sa, act, sizeof(new_sa.sa)))
-		return -EFAULT;
+	memset(&new_sa.sa, 0, sizeof(struct sigaction));
+
+	if (act) {
+		if (copy_from_user(&new_sa.sa, act, sa_len))
+			return -EFAULT;
+		ret = copy_sigset_from_user(&new_sa.sa.sa_mask, &act->sa_mask,
+					    sigsetsize);
+		if (ret)
+			return ret;
+	}
 
 	ret = do_sigaction(sig, act ? &new_sa : NULL, oact ? &old_sa : NULL);
 	if (ret)
 		return ret;
 
-	if (oact && copy_to_user(oact, &old_sa.sa, sizeof(old_sa.sa)))
-		return -EFAULT;
+	if (oact) {
+		if (copy_to_user(oact, &old_sa.sa, sa_len))
+			return -EFAULT;
+		ret = copy_sigset_to_user(&oact->sa_mask, &old_sa.sa.sa_mask,
+					  sigsetsize);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -4400,8 +4415,7 @@ COMPAT_SYSCALL_DEFINE4(rt_sigaction, int, sig,
 #endif
 	int ret;
 
-	/* XXX: Don't preclude handling different sized sigset_t's.  */
-	if (sigsetsize != sizeof(compat_sigset_t))
+	if (!valid_sigsetsize(sigsetsize))
 		return -EINVAL;
 
 	if (act) {
@@ -4412,7 +4426,8 @@ COMPAT_SYSCALL_DEFINE4(rt_sigaction, int, sig,
 		ret |= get_user(restorer, &act->sa_restorer);
 		new_ka.sa.sa_restorer = compat_ptr(restorer);
 #endif
-		ret |= get_compat_sigset(&new_ka.sa.sa_mask, &act->sa_mask);
+		ret |= copy_compat_sigset_from_user(&new_ka.sa.sa_mask,
+						    &act->sa_mask, sigsetsize);
 		ret |= get_user(new_ka.sa.sa_flags, &act->sa_flags);
 		if (ret)
 			return -EFAULT;
@@ -4422,8 +4437,8 @@ COMPAT_SYSCALL_DEFINE4(rt_sigaction, int, sig,
 	if (!ret && oact) {
 		ret = put_user(ptr_to_compat(old_ka.sa.sa_handler), 
 			       &oact->sa_handler);
-		ret |= put_compat_sigset(&oact->sa_mask, &old_ka.sa.sa_mask,
-					 sizeof(oact->sa_mask));
+		ret |= copy_compat_sigset_to_user(&oact->sa_mask,
+						  &old_ka.sa.sa_mask, sigsetsize);
 		ret |= put_user(old_ka.sa.sa_flags, &oact->sa_flags);
 #ifdef __ARCH_HAS_SA_RESTORER
 		ret |= put_user(ptr_to_compat(old_ka.sa.sa_restorer),
@@ -4590,13 +4605,11 @@ static int sigsuspend(sigset_t *set)
 SYSCALL_DEFINE2(rt_sigsuspend, sigset_t __user *, unewset, size_t, sigsetsize)
 {
 	sigset_t newset;
+	int ret;
 
-	/* XXX: Don't preclude handling different sized sigset_t's.  */
-	if (sigsetsize != sizeof(sigset_t))
-		return -EINVAL;
-
-	if (copy_from_user(&newset, unewset, sizeof(newset)))
-		return -EFAULT;
+	ret = copy_sigset_from_user(&newset, unewset, sigsetsize);
+	if (ret)
+		return ret;
 	return sigsuspend(&newset);
 }
  
@@ -4604,13 +4617,11 @@ SYSCALL_DEFINE2(rt_sigsuspend, sigset_t __user *, unewset, size_t, sigsetsize)
 COMPAT_SYSCALL_DEFINE2(rt_sigsuspend, compat_sigset_t __user *, unewset, compat_size_t, sigsetsize)
 {
 	sigset_t newset;
+	int ret;
 
-	/* XXX: Don't preclude handling different sized sigset_t's.  */
-	if (sigsetsize != sizeof(sigset_t))
-		return -EINVAL;
-
-	if (get_compat_sigset(&newset, unewset))
-		return -EFAULT;
+	ret = copy_compat_sigset_from_user(&newset, unewset, sigsetsize);
+	if (ret)
+		return ret;
 	return sigsuspend(&newset);
 }
 #endif
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 7851f3a1b5f7..c8b3645c9a7d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3891,8 +3891,10 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			if (copy_from_user(&kvm_sigmask, argp,
 					   sizeof(kvm_sigmask)))
 				goto out;
-			r = -EINVAL;
-			if (kvm_sigmask.len != sizeof(sigset))
+			r = copy_sigset_from_user(&sigset,
+				       (sigset_t __user *) &sigmask_arg->sigset,
+				       kvm_sigmask.len);
+			if (r)
 				goto out;
 			r = -EFAULT;
 			if (copy_from_user(&sigset, sigmask_arg->sigset,
@@ -3963,12 +3965,10 @@ static long kvm_vcpu_compat_ioctl(struct file *filp,
 			if (copy_from_user(&kvm_sigmask, argp,
 					   sizeof(kvm_sigmask)))
 				goto out;
-			r = -EINVAL;
-			if (kvm_sigmask.len != sizeof(compat_sigset_t))
-				goto out;
-			r = -EFAULT;
-			if (get_compat_sigset(&sigset,
-					      (compat_sigset_t __user *)sigmask_arg->sigset))
+			r = copy_compat_sigset_from_user(&sigset,
+				(compat_sigset_t __user *) &sigmask_arg->sigset,
+				kvm_sigmask.len);
+			if (r)
 				goto out;
 			r = kvm_vcpu_ioctl_set_sigmask(vcpu, &sigset);
 		} else
-- 
2.30.2

