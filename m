Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD2B1BD4D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 08:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgD2GpC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 02:45:02 -0400
Received: from verein.lst.de ([213.95.11.211]:32815 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbgD2GpB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 02:45:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EB68C68BEB; Wed, 29 Apr 2020 08:44:58 +0200 (CEST)
Date:   Wed, 29 Apr 2020 08:44:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fixup! signal: factor copy_siginfo_to_external32 from
 copy_siginfo_to_user32
Message-ID: <20200429064458.GA31717@lst.de>
References: <20200428074827.GA19846@lst.de> <20200428195645.1365019-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428195645.1365019-1-arnd@arndb.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 09:56:26PM +0200, Arnd Bergmann wrote:
> I think I found a way to improve the x32 handling:
> 
> This is a simplification over Christoph's "[PATCH 2/7] signal: factor
> copy_siginfo_to_external32 from copy_siginfo_to_user32", reducing the
> x32 specifics in the common code to a single #ifdef/#endif check, in
> order to keep it more readable for everyone else.
> 
> Christoph, if you like it, please fold into your patch.

What do you think of this version?  This one always overrides
copy_siginfo_to_user32 for the x86 compat case to keep the churn down,
and improves the copy_siginfo_to_external32 documentation a bit.

---
From 5ca642c4c744ce6460ebb91fe30ec7a064d28e96 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 29 Apr 2020 08:38:07 +0200
Subject: signal: factor copy_siginfo_to_external32 from copy_siginfo_to_user32

To remove the use of set_fs in the coredump code there needs to be a
way to convert a kernel siginfo to a userspace compat siginfo.

Factour out a copy_siginfo_to_external32 helper from
copy_siginfo_to_user32 that fills out the compat_siginfo, but does so
on a kernel space data structure.  Handling of the x32 SIGCHLD magic
is kept out of copy_siginfo_to_external32, as coredumps are never
caused by SIGCHLD.  To simplify the mess that the current
copy_siginfo_to_user32 is, we allow architectures to override it, and
keep thus keep the x32 SIGCHLD magic confined to x86-64.

Contains improvements from Eric W. Biederman <ebiederm@xmission.com>
and Arnd Bergmann <arnd@arndb.de>.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/Kconfig             |   3 ++
 arch/x86/Kconfig         |   1 +
 arch/x86/kernel/signal.c |  22 ++++++++
 include/linux/compat.h   |   2 +
 kernel/signal.c          | 108 ++++++++++++++++++++-------------------
 5 files changed, 83 insertions(+), 53 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 786a85d4ad40d..d5bc9f1ee1747 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -815,6 +815,9 @@ config OLD_SIGACTION
 config COMPAT_OLD_SIGACTION
 	bool
 
+config ARCH_COPY_SIGINFO_TO_USER32
+	bool
+
 config COMPAT_32BIT_TIME
 	bool "Provide system calls for 32-bit time_t"
 	default !64BIT || COMPAT
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1197b5596d5ad..ad13facbe9ffe 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2906,6 +2906,7 @@ config X86_X32
 config COMPAT_32
 	def_bool y
 	depends on IA32_EMULATION || X86_32
+	select ARCH_COPY_SIGINFO_TO_USER32
 	select HAVE_UID16
 	select OLD_SIGSUSPEND3
 
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 83b74fb38c8fc..d2b09866105a2 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -511,6 +511,28 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 }
 #endif /* CONFIG_X86_32 */
 
+#ifdef CONFIG_ARCH_COPY_SIGINFO_TO_USER32
+int __copy_siginfo_to_user32(struct compat_siginfo __user *to,
+			     const struct kernel_siginfo *from, bool x32_ABI)
+{
+	struct compat_siginfo new;
+
+	copy_siginfo_to_external32(&new, from);
+	if (x32_ABI && from->si_signo == SIGCHLD) {
+		new._sifields._sigchld_x32._utime = from->si_utime;
+		new._sifields._sigchld_x32._stime = from->si_stime;
+	}
+	if (copy_to_user(to, &new, sizeof(struct compat_siginfo)))
+		return -EFAULT;
+	return 0;
+}
+int copy_siginfo_to_user32(struct compat_siginfo __user *to,
+			   const struct kernel_siginfo *from)
+{
+	return __copy_siginfo_to_user32(to, from, in_x32_syscall());
+}
+#endif /* CONFIG_ARCH_COPY_SIGINFO_TO_USER32 */
+
 static int x32_setup_rt_frame(struct ksignal *ksig,
 			      compat_sigset_t *set,
 			      struct pt_regs *regs)
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 0480ba4db5929..adbfe8f688d92 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -402,6 +402,8 @@ long compat_get_bitmap(unsigned long *mask, const compat_ulong_t __user *umask,
 		       unsigned long bitmap_size);
 long compat_put_bitmap(compat_ulong_t __user *umask, unsigned long *mask,
 		       unsigned long bitmap_size);
+void copy_siginfo_to_external32(struct compat_siginfo *to,
+		const struct kernel_siginfo *from);
 int copy_siginfo_from_user32(kernel_siginfo_t *to, const struct compat_siginfo __user *from);
 int copy_siginfo_to_user32(struct compat_siginfo __user *to, const kernel_siginfo_t *from);
 int get_compat_sigevent(struct sigevent *event,
diff --git a/kernel/signal.c b/kernel/signal.c
index 284fc1600063b..710655df1269d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3235,96 +3235,98 @@ int copy_siginfo_from_user(kernel_siginfo_t *to, const siginfo_t __user *from)
 }
 
 #ifdef CONFIG_COMPAT
-int copy_siginfo_to_user32(struct compat_siginfo __user *to,
-			   const struct kernel_siginfo *from)
-#if defined(CONFIG_X86_X32_ABI) || defined(CONFIG_IA32_EMULATION)
-{
-	return __copy_siginfo_to_user32(to, from, in_x32_syscall());
-}
-int __copy_siginfo_to_user32(struct compat_siginfo __user *to,
-			     const struct kernel_siginfo *from, bool x32_ABI)
-#endif
+/**
+ * copy_siginfo_to_external32: copy a kernel signinfo into a 32-bit user one
+ * @to: compat siginfo destination
+ * @from: kernel siginfo source
+ *
+ * This function does not work properly for SIGCHLD on x32, but it does not need
+ * to as SIGCHLD never causes a coredump as this function is only intended to
+ * be used either by the coredump code or to implement copy_siginfo_to_user32,
+ * which can have its own arch version to deal with things like x32.
+ */
+void copy_siginfo_to_external32(struct compat_siginfo *to,
+		const struct kernel_siginfo *from)
 {
-	struct compat_siginfo new;
-	memset(&new, 0, sizeof(new));
+	memset(to, 0, sizeof(*to));
 
-	new.si_signo = from->si_signo;
-	new.si_errno = from->si_errno;
-	new.si_code  = from->si_code;
+	to->si_signo = from->si_signo;
+	to->si_errno = from->si_errno;
+	to->si_code  = from->si_code;
 	switch(siginfo_layout(from->si_signo, from->si_code)) {
 	case SIL_KILL:
-		new.si_pid = from->si_pid;
-		new.si_uid = from->si_uid;
+		to->si_pid = from->si_pid;
+		to->si_uid = from->si_uid;
 		break;
 	case SIL_TIMER:
-		new.si_tid     = from->si_tid;
-		new.si_overrun = from->si_overrun;
-		new.si_int     = from->si_int;
+		to->si_tid     = from->si_tid;
+		to->si_overrun = from->si_overrun;
+		to->si_int     = from->si_int;
 		break;
 	case SIL_POLL:
-		new.si_band = from->si_band;
-		new.si_fd   = from->si_fd;
+		to->si_band = from->si_band;
+		to->si_fd   = from->si_fd;
 		break;
 	case SIL_FAULT:
-		new.si_addr = ptr_to_compat(from->si_addr);
+		to->si_addr = ptr_to_compat(from->si_addr);
 #ifdef __ARCH_SI_TRAPNO
-		new.si_trapno = from->si_trapno;
+		to->si_trapno = from->si_trapno;
 #endif
 		break;
 	case SIL_FAULT_MCEERR:
-		new.si_addr = ptr_to_compat(from->si_addr);
+		to->si_addr = ptr_to_compat(from->si_addr);
 #ifdef __ARCH_SI_TRAPNO
-		new.si_trapno = from->si_trapno;
+		to->si_trapno = from->si_trapno;
 #endif
-		new.si_addr_lsb = from->si_addr_lsb;
+		to->si_addr_lsb = from->si_addr_lsb;
 		break;
 	case SIL_FAULT_BNDERR:
-		new.si_addr = ptr_to_compat(from->si_addr);
+		to->si_addr = ptr_to_compat(from->si_addr);
 #ifdef __ARCH_SI_TRAPNO
-		new.si_trapno = from->si_trapno;
+		to->si_trapno = from->si_trapno;
 #endif
-		new.si_lower = ptr_to_compat(from->si_lower);
-		new.si_upper = ptr_to_compat(from->si_upper);
+		to->si_lower = ptr_to_compat(from->si_lower);
+		to->si_upper = ptr_to_compat(from->si_upper);
 		break;
 	case SIL_FAULT_PKUERR:
-		new.si_addr = ptr_to_compat(from->si_addr);
+		to->si_addr = ptr_to_compat(from->si_addr);
 #ifdef __ARCH_SI_TRAPNO
-		new.si_trapno = from->si_trapno;
+		to->si_trapno = from->si_trapno;
 #endif
-		new.si_pkey = from->si_pkey;
+		to->si_pkey = from->si_pkey;
 		break;
 	case SIL_CHLD:
-		new.si_pid    = from->si_pid;
-		new.si_uid    = from->si_uid;
-		new.si_status = from->si_status;
-#ifdef CONFIG_X86_X32_ABI
-		if (x32_ABI) {
-			new._sifields._sigchld_x32._utime = from->si_utime;
-			new._sifields._sigchld_x32._stime = from->si_stime;
-		} else
-#endif
-		{
-			new.si_utime = from->si_utime;
-			new.si_stime = from->si_stime;
-		}
+		to->si_pid    = from->si_pid;
+		to->si_uid    = from->si_uid;
+		to->si_status = from->si_status;
+		to->si_utime = from->si_utime;
+		to->si_stime = from->si_stime;
 		break;
 	case SIL_RT:
-		new.si_pid = from->si_pid;
-		new.si_uid = from->si_uid;
-		new.si_int = from->si_int;
+		to->si_pid = from->si_pid;
+		to->si_uid = from->si_uid;
+		to->si_int = from->si_int;
 		break;
 	case SIL_SYS:
-		new.si_call_addr = ptr_to_compat(from->si_call_addr);
-		new.si_syscall   = from->si_syscall;
-		new.si_arch      = from->si_arch;
+		to->si_call_addr = ptr_to_compat(from->si_call_addr);
+		to->si_syscall   = from->si_syscall;
+		to->si_arch      = from->si_arch;
 		break;
 	}
+}
 
+#ifndef CONFIG_ARCH_COPY_SIGINFO_TO_USER32
+int copy_siginfo_to_user32(struct compat_siginfo __user *to,
+			   const struct kernel_siginfo *from)
+{
+	struct compat_siginfo new;
+
+	copy_siginfo_to_external32(&new, from);
 	if (copy_to_user(to, &new, sizeof(struct compat_siginfo)))
 		return -EFAULT;
-
 	return 0;
 }
+#endif /* ARCH_COPY_SIGINFO_TO_USER32 */
 
 static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
 					 const struct compat_siginfo *from)
-- 
2.26.2

