Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1C14836F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 19:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbiACSfu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 13:35:50 -0500
Received: from drummond.us ([74.95.14.229]:40377 "EHLO
        talisker.home.drummond.us" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235832AbiACSfl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 13:35:41 -0500
X-Greylist: delayed 810 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jan 2022 13:35:34 EST
Received: from talisker.home.drummond.us (localhost [127.0.0.1])
        by talisker.home.drummond.us (8.15.2/8.15.2/Debian-20) with ESMTP id 203IKZSZ983534;
        Mon, 3 Jan 2022 10:20:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=home.drummond.us;
        s=default; t=1641234035;
        bh=1S4aZEe8E5gnTI2K70dnsEWUGccc1BInmbt849S/duM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WyQCq7DasK4r7khY1NLSZ2054ipNjjssFr3IyHOfjRw5AwqYZ2h1rMu3x89S23nM3
         Ijrf2PSNrKMtHbvM1QVI0uQzA9fHwSQnaNVo9c695mnTtZ5QkdJOh8dsfSfVr/vxdb
         JGzGBT4ajjhJjmYk3jiziZi3ZT/9Lr6ojWfoe4avw5LmxSc9jiAfQs6VbMmEehFDSS
         8LTfFzcx4UeVso+E9qMwpmobvxkvHR/4mx9ZLg2awfdMp7VC6a97ArXtTqHOHQZ3jw
         h5U7DJULvrNd5I4BNEH6jJj88fnGmh+esyJd+r02P1ve4B/RMSGezj7mpD+bfbX1ah
         SqWcHVc1YVwQA==
Received: (from walt@localhost)
        by talisker.home.drummond.us (8.15.2/8.15.2/Submit) id 203IKZXV983533;
        Mon, 3 Jan 2022 10:20:35 -0800
From:   Walt Drummond <walt@drummond.us>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Walt Drummond <walt@drummond.us>,
        linux-alpha@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-scsi@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org
Subject: [RFC PATCH 4/8] signals: Remove sigmask() macro
Date:   Mon,  3 Jan 2022 10:19:52 -0800
Message-Id: <20220103181956.983342-5-walt@drummond.us>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220103181956.983342-1-walt@drummond.us>
References: <20220103181956.983342-1-walt@drummond.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The sigmask() macro can't support signals numbers larger than 64.

Remove the general usage of sigmask() and bit masks as input into the
functions that manipulate or accept sigset_t, with the exceptions of
compatibility cases. Use a comma-separated list of signal numbers as
input to sigaddset()/sigdelset()/... instead.

Signed-off-by: Walt Drummond <walt@drummond.us>
---
 arch/alpha/kernel/signal.c     |   4 +-
 arch/m68k/include/asm/signal.h |   6 +-
 arch/nios2/kernel/signal.c     |   2 -
 arch/x86/include/asm/signal.h  |   6 +-
 drivers/scsi/dpti.h            |   2 -
 fs/ceph/addr.c                 |   2 +-
 fs/jffs2/background.c          |   2 +-
 fs/lockd/svc.c                 |   1 -
 fs/signalfd.c                  |   2 +-
 include/linux/signal.h         | 254 +++++++++++++++++++++------------
 kernel/compat.c                |   6 +-
 kernel/fork.c                  |   2 +-
 kernel/ptrace.c                |   2 +-
 kernel/signal.c                | 115 +++++++--------
 virt/kvm/kvm_main.c            |   2 +-
 15 files changed, 238 insertions(+), 170 deletions(-)

diff --git a/arch/alpha/kernel/signal.c b/arch/alpha/kernel/signal.c
index bc077babafab..cae533594248 100644
--- a/arch/alpha/kernel/signal.c
+++ b/arch/alpha/kernel/signal.c
@@ -33,7 +33,7 @@
 
 #define DEBUG_SIG 0
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
+#define _BLOCKABLE (~(compat_sigmask(SIGKILL) | compat_sigmask(SIGSTOP)))
 
 asmlinkage void ret_from_sys_call(void);
 
@@ -47,7 +47,7 @@ SYSCALL_DEFINE2(osf_sigprocmask, int, how, unsigned long, newmask)
 	sigset_t mask;
 	unsigned long res;
 
-	siginitset(&mask, newmask & _BLOCKABLE);
+	compat_siginitset(&mask, newmask & _BLOCKABLE);
 	res = sigprocmask(how, &mask, &oldmask);
 	if (!res) {
 		force_successful_syscall_return();
diff --git a/arch/m68k/include/asm/signal.h b/arch/m68k/include/asm/signal.h
index 8af85c38d377..464ff863c958 100644
--- a/arch/m68k/include/asm/signal.h
+++ b/arch/m68k/include/asm/signal.h
@@ -24,7 +24,7 @@ typedef struct {
 #ifndef CONFIG_CPU_HAS_NO_BITFIELDS
 #define __HAVE_ARCH_SIG_BITOPS
 
-static inline void sigaddset(sigset_t *set, int _sig)
+static inline void sigset_add(sigset_t *set, int _sig)
 {
 	asm ("bfset %0{%1,#1}"
 		: "+o" (*set)
@@ -32,7 +32,7 @@ static inline void sigaddset(sigset_t *set, int _sig)
 		: "cc");
 }
 
-static inline void sigdelset(sigset_t *set, int _sig)
+static inline void sigset_del(sigset_t *set, int _sig)
 {
 	asm ("bfclr %0{%1,#1}"
 		: "+o" (*set)
@@ -56,7 +56,7 @@ static inline int __gen_sigismember(sigset_t *set, int _sig)
 	return ret;
 }
 
-#define sigismember(set,sig)			\
+#define sigset_ismember(set, sig)		\
 	(__builtin_constant_p(sig) ?		\
 	 __const_sigismember(set,sig) :		\
 	 __gen_sigismember(set,sig))
diff --git a/arch/nios2/kernel/signal.c b/arch/nios2/kernel/signal.c
index 2009ae2d3c3b..c9db511a6989 100644
--- a/arch/nios2/kernel/signal.c
+++ b/arch/nios2/kernel/signal.c
@@ -20,8 +20,6 @@
 #include <asm/ucontext.h>
 #include <asm/cacheflush.h>
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 /*
  * Do a signal return; undo the signal stack.
  *
diff --git a/arch/x86/include/asm/signal.h b/arch/x86/include/asm/signal.h
index 2dfb5fea13af..9bac7c6e524c 100644
--- a/arch/x86/include/asm/signal.h
+++ b/arch/x86/include/asm/signal.h
@@ -46,7 +46,7 @@ typedef sigset_t compat_sigset_t;
 
 #define __HAVE_ARCH_SIG_BITOPS
 
-#define sigaddset(set,sig)		    \
+#define sigset_add(set, sig)		    \
 	(__builtin_constant_p(sig)	    \
 	 ? __const_sigaddset((set), (sig))  \
 	 : __gen_sigaddset((set), (sig)))
@@ -62,7 +62,7 @@ static inline void __const_sigaddset(sigset_t *set, int _sig)
 	set->sig[sig / _NSIG_BPW] |= 1 << (sig % _NSIG_BPW);
 }
 
-#define sigdelset(set, sig)		    \
+#define sigset_del(set, sig)		    \
 	(__builtin_constant_p(sig)	    \
 	 ? __const_sigdelset((set), (sig))  \
 	 : __gen_sigdelset((set), (sig)))
@@ -93,7 +93,7 @@ static inline int __gen_sigismember(sigset_t *set, int _sig)
 	return ret;
 }
 
-#define sigismember(set, sig)			\
+#define sigset_ismember(set, sig)		\
 	(__builtin_constant_p(sig)		\
 	 ? __const_sigismember((set), (sig))	\
 	 : __gen_sigismember((set), (sig)))
diff --git a/drivers/scsi/dpti.h b/drivers/scsi/dpti.h
index 8a079e8d7f65..cfcbb7d98fc0 100644
--- a/drivers/scsi/dpti.h
+++ b/drivers/scsi/dpti.h
@@ -96,8 +96,6 @@ static int adpt_device_reset(struct scsi_cmnd* cmd);
 #define PINFO(fmt, args...) printk(KERN_INFO fmt, ##args)
 #define PCRIT(fmt, args...) printk(KERN_CRIT fmt, ##args)
 
-#define SHUTDOWN_SIGS	(sigmask(SIGKILL)|sigmask(SIGINT)|sigmask(SIGTERM))
-
 // Command timeouts
 #define FOREVER			(0)
 #define TMOUT_INQUIRY 		(20)
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 99b80b5c7a93..238b5ce5ef64 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1333,7 +1333,7 @@ const struct address_space_operations ceph_aops = {
 static void ceph_block_sigs(sigset_t *oldset)
 {
 	sigset_t mask;
-	siginitsetinv(&mask, sigmask(SIGKILL));
+	siginitsetinv(&mask, SIGKILL);
 	sigprocmask(SIG_BLOCK, &mask, oldset);
 }
 
diff --git a/fs/jffs2/background.c b/fs/jffs2/background.c
index 2b4d5013dc5d..bb84a8b2373c 100644
--- a/fs/jffs2/background.c
+++ b/fs/jffs2/background.c
@@ -77,7 +77,7 @@ static int jffs2_garbage_collect_thread(void *_c)
 	struct jffs2_sb_info *c = _c;
 	sigset_t hupmask;
 
-	siginitset(&hupmask, sigmask(SIGHUP));
+	siginitset(&hupmask, SIGHUP);
 	allow_signal(SIGKILL);
 	allow_signal(SIGSTOP);
 	allow_signal(SIGHUP);
diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index b632be3ad57b..3c8b56c094d0 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -45,7 +45,6 @@
 
 #define NLMDBG_FACILITY		NLMDBG_SVC
 #define LOCKD_BUFSIZE		(1024 + NLMSVC_XDRSIZE)
-#define ALLOWED_SIGS		(sigmask(SIGKILL))
 
 static struct svc_program	nlmsvc_program;
 
diff --git a/fs/signalfd.c b/fs/signalfd.c
index 12fdc282e299..ed024d5aad2a 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -270,7 +270,7 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
 	if (flags & ~(SFD_CLOEXEC | SFD_NONBLOCK))
 		return -EINVAL;
 
-	sigdelsetmask(mask, sigmask(SIGKILL) | sigmask(SIGSTOP));
+	sigdelset(mask, SIGKILL, SIGSTOP);
 	signotset(mask);
 
 	if (ufd == -1) {
diff --git a/include/linux/signal.h b/include/linux/signal.h
index a730f3d4615e..eaf7991fffee 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -53,6 +53,12 @@ enum siginfo_layout {
 
 enum siginfo_layout siginfo_layout(unsigned sig, int si_code);
 
+/* Test if 'sig' is valid signal. Use this instead of testing _NSIG directly */
+static inline int valid_signal(unsigned long sig)
+{
+	return sig <= _NSIG ? 1 : 0;
+}
+
 /* Test if 'sig' is a realtime signal.  Use this instead of testing
  * SIGRTMIN/SIGRTMAX directly.
  */
@@ -62,15 +68,20 @@ static inline int realtime_signal(unsigned long sig)
 }
 
 /*
- * Define some primitives to manipulate sigset_t.
+ * Define some primitives to manipulate individual bits in sigset_t.
+ * Don't use these directly.  Architectures can define their own
+ * versions (see arch/x86/include/signal.h)
  */
 
 #ifndef __HAVE_ARCH_SIG_BITOPS
-#include <linux/bitops.h>
+#define sigset_add(set, sig)       __sigset_add(set, sig)
+#define sigset_del(set, sig)       __sigset_del(set, sig)
+#define sigset_ismember(set, sig)  __sigset_ismember(set, sig)
+#endif
 
 /* We don't use <linux/bitops.h> for these because there is no need to
    be atomic.  */
-static inline void sigaddset(sigset_t *set, int _sig)
+static inline void __sigset_add(sigset_t *set, int _sig)
 {
 	unsigned long sig = _sig - 1;
 	if (_NSIG_WORDS == 1)
@@ -79,7 +90,7 @@ static inline void sigaddset(sigset_t *set, int _sig)
 		set->sig[sig / _NSIG_BPW] |= 1UL << (sig % _NSIG_BPW);
 }
 
-static inline void sigdelset(sigset_t *set, int _sig)
+static inline void __sigset_del(sigset_t *set, int _sig)
 {
 	unsigned long sig = _sig - 1;
 	if (_NSIG_WORDS == 1)
@@ -88,33 +99,72 @@ static inline void sigdelset(sigset_t *set, int _sig)
 		set->sig[sig / _NSIG_BPW] &= ~(1UL << (sig % _NSIG_BPW));
 }
 
-static inline int sigismember(sigset_t *set, int _sig)
+static inline int __sigset_ismember(sigset_t *set, int _sig)
 {
 	unsigned long sig = _sig - 1;
 	if (_NSIG_WORDS == 1)
-		return 1 & (set->sig[0] >> sig);
+		return 1UL & (set->sig[0] >> sig);
 	else
-		return 1 & (set->sig[sig / _NSIG_BPW] >> (sig % _NSIG_BPW));
+		return 1UL & (set->sig[sig / _NSIG_BPW] >> (sig % _NSIG_BPW));
 }
 
-#endif /* __HAVE_ARCH_SIG_BITOPS */
+/* Some primitives for setting/deleting signals from sigset_t.  Use these. */
 
-static inline int sigisemptyset(sigset_t *set)
+#define NUM_INTARGS(...) (sizeof((int[]){__VA_ARGS__})/sizeof(int))
+
+#define sigdelset(x, ...) __sigdelset((x), NUM_INTARGS(__VA_ARGS__),	\
+				      __VA_ARGS__)
+static inline void __sigdelset(sigset_t *set, int count, ...)
 {
-	switch (_NSIG_WORDS) {
-	case 4:
-		return (set->sig[3] | set->sig[2] |
-			set->sig[1] | set->sig[0]) == 0;
-	case 2:
-		return (set->sig[1] | set->sig[0]) == 0;
-	case 1:
-		return set->sig[0] == 0;
-	default:
-		BUILD_BUG();
-		return 0;
+	va_list ap;
+	int sig;
+
+	va_start(ap, count);
+	while (count > 0) {
+		sig = va_arg(ap, int);
+		if (valid_signal(sig) && sig != 0)
+			sigset_del(set, sig);
+		count--;
 	}
+	va_end(ap);
+}
+
+#define sigaddset(x, ...) __sigaddset((x), NUM_INTARGS(__VA_ARGS__),	\
+				      __VA_ARGS__)
+static inline void __sigaddset(sigset_t *set, int count, ...)
+{
+	va_list ap;
+	int sig;
+
+	va_start(ap, count);
+	while (count > 0) {
+		sig = va_arg(ap, int);
+		if (valid_signal(sig) && sig != 0)
+			sigset_add(set, sig);
+		count--;
+	}
+	va_end(ap);
+}
+
+static inline int sigismember(sigset_t *set, int sig)
+{
+	if (!valid_signal(sig) || sig == 0)
+		return 0;
+	return sigset_ismember(set, sig);
 }
 
+#define siginitset(set, ...)			\
+do {						\
+	sigemptyset((set));			\
+	sigaddset((set), __VA_ARGS__);		\
+} while (0)
+
+#define siginitsetinv(set, ...)			\
+do {					        \
+	sigfillset((set));			\
+	sigdelset((set), __VA_ARGS__);		\
+} while (0)
+
 static inline int sigequalsets(const sigset_t *set1, const sigset_t *set2)
 {
 	switch (_NSIG_WORDS) {
@@ -128,11 +178,18 @@ static inline int sigequalsets(const sigset_t *set1, const sigset_t *set2)
 			(set1->sig[0] == set2->sig[0]);
 	case 1:
 		return	set1->sig[0] == set2->sig[0];
+	default:
+		return memcmp(set1, set2, sizeof(sigset_t)) == 0;
 	}
 	return 0;
 }
 
-#define sigmask(sig)	(1UL << ((sig) - 1))
+static inline int sigisemptyset(sigset_t *set)
+{
+	sigset_t empty = {0};
+
+	return sigequalsets(set, &empty);
+}
 
 #ifndef __HAVE_ARCH_SIG_SETOPS
 #include <linux/string.h>
@@ -141,6 +198,7 @@ static inline int sigequalsets(const sigset_t *set1, const sigset_t *set2)
 static inline void name(sigset_t *r, const sigset_t *a, const sigset_t *b) \
 {									\
 	unsigned long a0, a1, a2, a3, b0, b1, b2, b3;			\
+	int i;								\
 									\
 	switch (_NSIG_WORDS) {						\
 	case 4:								\
@@ -158,7 +216,9 @@ static inline void name(sigset_t *r, const sigset_t *a, const sigset_t *b) \
 		r->sig[0] = op(a0, b0);					\
 		break;							\
 	default:							\
-		BUILD_BUG();						\
+		for (i = 0; i < _NSIG_WORDS; i++)			\
+			r->sig[i] = op(a->sig[i], b->sig[i]);		\
+		break;							\
 	}								\
 }
 
@@ -179,6 +239,8 @@ _SIG_SET_BINOP(sigandnsets, _sig_andn)
 #define _SIG_SET_OP(name, op)						\
 static inline void name(sigset_t *set)					\
 {									\
+	int i;								\
+									\
 	switch (_NSIG_WORDS) {						\
 	case 4:	set->sig[3] = op(set->sig[3]);				\
 		set->sig[2] = op(set->sig[2]);				\
@@ -188,7 +250,9 @@ static inline void name(sigset_t *set)					\
 	case 1:	set->sig[0] = op(set->sig[0]);				\
 		    break;						\
 	default:							\
-		BUILD_BUG();						\
+		for (i = 0; i < _NSIG_WORDS; i++)			\
+			set->sig[i] = op(set->sig[i]);			\
+		break;							\
 	}								\
 }
 
@@ -224,24 +288,13 @@ static inline void sigfillset(sigset_t *set)
 	}
 }
 
-/* Some extensions for manipulating the low 32 signals in particular.  */
+#endif /* __HAVE_ARCH_SIG_SETOPS */
 
-static inline void sigaddsetmask(sigset_t *set, unsigned long mask)
-{
-	set->sig[0] |= mask;
-}
+/* Primitives for handing the compat (first long) sigset_t */
 
-static inline void sigdelsetmask(sigset_t *set, unsigned long mask)
-{
-	set->sig[0] &= ~mask;
-}
+#define compat_sigmask(sig)       (1UL << ((sig) - 1))
 
-static inline int sigtestsetmask(sigset_t *set, unsigned long mask)
-{
-	return (set->sig[0] & mask) != 0;
-}
-
-static inline void siginitset(sigset_t *set, unsigned long mask)
+static inline void compat_siginitset(sigset_t *set, unsigned long mask)
 {
 	set->sig[0] = mask;
 	switch (_NSIG_WORDS) {
@@ -254,7 +307,7 @@ static inline void siginitset(sigset_t *set, unsigned long mask)
 	}
 }
 
-static inline void siginitsetinv(sigset_t *set, unsigned long mask)
+static inline void compat_siginitsetinv(sigset_t *set, unsigned long mask)
 {
 	set->sig[0] = ~mask;
 	switch (_NSIG_WORDS) {
@@ -267,7 +320,21 @@ static inline void siginitsetinv(sigset_t *set, unsigned long mask)
 	}
 }
 
-#endif /* __HAVE_ARCH_SIG_SETOPS */
+static inline void compat_sigaddsetmask(sigset_t *set, unsigned long mask)
+{
+	set->sig[0] |= mask;
+}
+
+static inline void compat_sigdelsetmask(sigset_t *set, unsigned long mask)
+{
+	set->sig[0] &= ~mask;
+}
+
+static inline int compat_sigtestsetmask(sigset_t *set, unsigned long mask)
+{
+	return (set->sig[0] & mask) != 0;
+}
+
 
 /* Safely copy a sigset_t from user space handling any differences in
  * size between user space and kernel sigset_t.  We don't use
@@ -338,12 +405,6 @@ static inline void init_sigpending(struct sigpending *sig)
 
 extern void flush_sigqueue(struct sigpending *queue);
 
-/* Test if 'sig' is valid signal. Use this instead of testing _NSIG directly */
-static inline int valid_signal(unsigned long sig)
-{
-	return sig <= _NSIG ? 1 : 0;
-}
-
 struct timespec;
 struct pt_regs;
 enum pid_type;
@@ -470,55 +531,72 @@ extern bool unhandled_signal(struct task_struct *tsk, int sig);
  * default action of stopping the process may happen later or never.
  */
 
+static inline int sig_kernel_stop(unsigned long sig)
+{
+	return	sig == SIGSTOP ||
+		sig == SIGTSTP ||
+		sig == SIGTTIN ||
+		sig == SIGTTOU;
+}
+
+static inline int sig_kernel_ignore(unsigned long sig)
+{
+	return	sig == SIGCONT	||
+		sig == SIGCHLD	||
+		sig == SIGWINCH ||
+		sig == SIGURG;
+}
+
+static inline int sig_kernel_only(unsigned long sig)
+{
+	return	sig == SIGKILL ||
+		sig == SIGSTOP;
+}
+
+static inline int sig_kernel_coredump(unsigned long sig)
+{
+	return	sig == SIGQUIT ||
+		sig == SIGILL  ||
+		sig == SIGTRAP ||
+		sig == SIGABRT ||
+		sig == SIGFPE  ||
+		sig == SIGSEGV ||
+		sig == SIGBUS  ||
+		sig == SIGSYS  ||
+		sig == SIGXCPU ||
 #ifdef SIGEMT
-#define SIGEMT_MASK	rt_sigmask(SIGEMT)
-#else
-#define SIGEMT_MASK	0
+		sig == SIGEMT  ||
 #endif
+		sig == SIGXFSZ;
+}
 
-#if SIGRTMIN > BITS_PER_LONG
-#define rt_sigmask(sig)	(1ULL << ((sig)-1))
-#else
-#define rt_sigmask(sig)	sigmask(sig)
+static inline int sig_specific_sicodes(unsigned long sig)
+{
+	return	sig == SIGILL  ||
+		sig == SIGFPE  ||
+		sig == SIGSEGV ||
+		sig == SIGBUS  ||
+		sig == SIGTRAP ||
+		sig == SIGCHLD ||
+		sig == SIGPOLL ||
+#ifdef SIGEMT
+		sig == SIGEMT  ||
 #endif
+		sig == SIGSYS;
+}
 
-#define siginmask(sig, mask) \
-	((sig) > 0 && (sig) < SIGRTMIN && (rt_sigmask(sig) & (mask)))
-
-#define SIG_KERNEL_ONLY_MASK (\
-	rt_sigmask(SIGKILL)   |  rt_sigmask(SIGSTOP))
-
-#define SIG_KERNEL_STOP_MASK (\
-	rt_sigmask(SIGSTOP)   |  rt_sigmask(SIGTSTP)   | \
-	rt_sigmask(SIGTTIN)   |  rt_sigmask(SIGTTOU)   )
-
-#define SIG_KERNEL_COREDUMP_MASK (\
-        rt_sigmask(SIGQUIT)   |  rt_sigmask(SIGILL)    | \
-	rt_sigmask(SIGTRAP)   |  rt_sigmask(SIGABRT)   | \
-        rt_sigmask(SIGFPE)    |  rt_sigmask(SIGSEGV)   | \
-	rt_sigmask(SIGBUS)    |  rt_sigmask(SIGSYS)    | \
-        rt_sigmask(SIGXCPU)   |  rt_sigmask(SIGXFSZ)   | \
-	SIGEMT_MASK				       )
-
-#define SIG_KERNEL_IGNORE_MASK (\
-        rt_sigmask(SIGCONT)   |  rt_sigmask(SIGCHLD)   | \
-	rt_sigmask(SIGWINCH)  |  rt_sigmask(SIGURG)    )
-
-#define SIG_SPECIFIC_SICODES_MASK (\
-	rt_sigmask(SIGILL)    |  rt_sigmask(SIGFPE)    | \
-	rt_sigmask(SIGSEGV)   |  rt_sigmask(SIGBUS)    | \
-	rt_sigmask(SIGTRAP)   |  rt_sigmask(SIGCHLD)   | \
-	rt_sigmask(SIGPOLL)   |  rt_sigmask(SIGSYS)    | \
-	SIGEMT_MASK                                    )
-
-#define sig_kernel_only(sig)		siginmask(sig, SIG_KERNEL_ONLY_MASK)
-#define sig_kernel_coredump(sig)	siginmask(sig, SIG_KERNEL_COREDUMP_MASK)
-#define sig_kernel_ignore(sig)		siginmask(sig, SIG_KERNEL_IGNORE_MASK)
-#define sig_kernel_stop(sig)		siginmask(sig, SIG_KERNEL_STOP_MASK)
-#define sig_specific_sicodes(sig)	siginmask(sig, SIG_SPECIFIC_SICODES_MASK)
+static inline int synchronous_signal(unsigned long sig)
+{
+	return	sig == SIGSEGV ||
+		sig == SIGBUS  ||
+		sig == SIGILL  ||
+		sig == SIGTRAP ||
+		sig == SIGFPE  ||
+		sig == SIGSYS;
+}
 
 #define sig_fatal(t, signr) \
-	(!siginmask(signr, SIG_KERNEL_IGNORE_MASK|SIG_KERNEL_STOP_MASK) && \
+	(!(sig_kernel_ignore(signr) ||	sig_kernel_stop(signr)) &&	\
 	 (t)->sighand->action[(signr)-1].sa.sa_handler == SIG_DFL)
 
 void signals_init(void);
diff --git a/kernel/compat.c b/kernel/compat.c
index cc2438f4070c..26ffd271444c 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -49,16 +49,16 @@ COMPAT_SYSCALL_DEFINE3(sigprocmask, int, how,
 	if (nset) {
 		if (get_user(new_set, nset))
 			return -EFAULT;
-		new_set &= ~(sigmask(SIGKILL) | sigmask(SIGSTOP));
+		new_set &= ~(compat_sigmask(SIGKILL) | compat_sigmask(SIGSTOP));
 
 		new_blocked = current->blocked;
 
 		switch (how) {
 		case SIG_BLOCK:
-			sigaddsetmask(&new_blocked, new_set);
+			compat_sigaddsetmask(&new_blocked, new_set);
 			break;
 		case SIG_UNBLOCK:
-			sigdelsetmask(&new_blocked, new_set);
+			compat_sigdelsetmask(&new_blocked, new_set);
 			break;
 		case SIG_SETMASK:
 			compat_sig_setmask(&new_blocked, new_set);
diff --git a/kernel/fork.c b/kernel/fork.c
index 38681ad44c76..8b07f0090b82 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2032,7 +2032,7 @@ static __latent_entropy struct task_struct *copy_process(
 		 * fatal or STOP
 		 */
 		p->flags |= PF_IO_WORKER;
-		siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
+		siginitsetinv(&p->blocked, SIGKILL, SIGSTOP);
 	}
 
 	/*
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 2f7ee345a629..200b99d39878 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -1102,7 +1102,7 @@ int ptrace_request(struct task_struct *child, long request,
 		if (ret)
 			break;
 
-		sigdelsetmask(&new_set, sigmask(SIGKILL)|sigmask(SIGSTOP));
+		sigdelset(&new_set, SIGKILL, SIGSTOP);
 
 		/*
 		 * Every thread does recalc_sigpending() after resume, so
diff --git a/kernel/signal.c b/kernel/signal.c
index a2f0e38ba934..9421f1112b20 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -64,6 +64,9 @@ static struct kmem_cache *sigqueue_cachep;
 
 int print_fatal_signals __read_mostly;
 
+sigset_t signal_stop_mask;
+sigset_t signal_synchronous_mask;
+
 static void __user *sig_handler(struct task_struct *t, int sig)
 {
 	return t->sighand->action[sig - 1].sa.sa_handler;
@@ -199,55 +202,26 @@ void calculate_sigpending(void)
 }
 
 /* Given the mask, find the first available signal that should be serviced. */
-
-#define SYNCHRONOUS_MASK \
-	(sigmask(SIGSEGV) | sigmask(SIGBUS) | sigmask(SIGILL) | \
-	 sigmask(SIGTRAP) | sigmask(SIGFPE) | sigmask(SIGSYS))
-
 int next_signal(struct sigpending *pending, sigset_t *mask)
 {
-	unsigned long i, *s, *m, x;
-	int sig = 0;
+	int i, sig;
+	sigset_t pend, s;
 
-	s = pending->signal.sig;
-	m = mask->sig;
+	sigandnsets(&pend, &pending->signal, mask);
 
-	/*
-	 * Handle the first word specially: it contains the
-	 * synchronous signals that need to be dequeued first.
-	 */
-	x = *s &~ *m;
-	if (x) {
-		if (x & SYNCHRONOUS_MASK)
-			x &= SYNCHRONOUS_MASK;
-		sig = ffz(~x) + 1;
-		return sig;
-	}
+	/* Handle synchronous signals first */
+	sigandsets(&s, &pend, &signal_synchronous_mask);
+	if (!sigisemptyset(&s))
+		pend = s;
 
-	switch (_NSIG_WORDS) {
-	default:
-		for (i = 1; i < _NSIG_WORDS; ++i) {
-			x = *++s &~ *++m;
-			if (!x)
-				continue;
-			sig = ffz(~x) + i*_NSIG_BPW + 1;
-			break;
+	for (i = 0; i < _NSIG_WORDS; i++) {
+		if (pend.sig[i] != 0) {
+			sig = ffz(~pend.sig[i]) + i*_NSIG_BPW + 1;
+			return sig;
 		}
-		break;
-
-	case 2:
-		x = s[1] &~ m[1];
-		if (!x)
-			break;
-		sig = ffz(~x) + _NSIG_BPW + 1;
-		break;
-
-	case 1:
-		/* Nothing to do */
-		break;
 	}
 
-	return sig;
+	return 0;
 }
 
 static inline void print_dropped_signal(int sig)
@@ -709,11 +683,14 @@ static int dequeue_synchronous_signal(kernel_siginfo_t *info)
 	struct task_struct *tsk = current;
 	struct sigpending *pending = &tsk->pending;
 	struct sigqueue *q, *sync = NULL;
+	sigset_t s;
 
 	/*
 	 * Might a synchronous signal be in the queue?
 	 */
-	if (!((pending->signal.sig[0] & ~tsk->blocked.sig[0]) & SYNCHRONOUS_MASK))
+	sigandnsets(&s, &pending->signal, &tsk->blocked);
+	sigandsets(&s, &s, &signal_synchronous_mask);
+	if (sigisemptyset(&s))
 		return 0;
 
 	/*
@@ -722,7 +699,7 @@ static int dequeue_synchronous_signal(kernel_siginfo_t *info)
 	list_for_each_entry(q, &pending->list, list) {
 		/* Synchronous signals have a positive si_code */
 		if ((q->info.si_code > SI_USER) &&
-		    (sigmask(q->info.si_signo) & SYNCHRONOUS_MASK)) {
+		    synchronous_signal(q->info.si_signo)) {
 			sync = q;
 			goto next;
 		}
@@ -795,6 +772,25 @@ static void flush_sigqueue_mask(sigset_t *mask, struct sigpending *s)
 	}
 }
 
+#define flush_sigqueue_sig(x, ...) __flush_sigqueue_sig((x),		\
+					NUM_INTARGS(__VA_ARGS__), __VA_ARGS__)
+static void __flush_sigqueue_sig(struct sigpending *s, int count, ...)
+{
+	va_list ap;
+	sigset_t mask;
+	int sig;
+
+	sigemptyset(&mask);
+	va_start(ap, count);
+	while (count > 0) {
+		sig = va_arg(ap, int);
+		if (valid_signal(sig) && sig != 0)
+			sigset_add(&mask, sig);
+		count--;
+	}
+	flush_sigqueue_mask(&mask, s);
+}
+
 static inline int is_si_special(const struct kernel_siginfo *info)
 {
 	return info <= SEND_SIG_PRIV;
@@ -913,8 +909,7 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
 		/*
 		 * This is a stop signal.  Remove SIGCONT from all queues.
 		 */
-		siginitset(&flush, sigmask(SIGCONT));
-		flush_sigqueue_mask(&flush, &signal->shared_pending);
+		flush_sigqueue_sig(&signal->shared_pending, SIGCONT);
 		for_each_thread(p, t)
 			flush_sigqueue_mask(&flush, &t->pending);
 	} else if (sig == SIGCONT) {
@@ -922,10 +917,9 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
 		/*
 		 * Remove all stop signals from all queues, wake all threads.
 		 */
-		siginitset(&flush, SIG_KERNEL_STOP_MASK);
-		flush_sigqueue_mask(&flush, &signal->shared_pending);
+		flush_sigqueue_mask(&signal_stop_mask, &signal->shared_pending);
 		for_each_thread(p, t) {
-			flush_sigqueue_mask(&flush, &t->pending);
+			flush_sigqueue_mask(&signal_stop_mask, &t->pending);
 			task_clear_jobctl_pending(t, JOBCTL_STOP_PENDING);
 			if (likely(!(t->ptrace & PT_SEIZED)))
 				wake_up_state(t, __TASK_STOPPED);
@@ -1172,7 +1166,7 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 			sigset_t *signal = &delayed->signal;
 			/* Can't queue both a stop and a continue signal */
 			if (sig == SIGCONT)
-				sigdelsetmask(signal, SIG_KERNEL_STOP_MASK);
+				sigandnsets(signal, signal, &signal_stop_mask);
 			else if (sig_kernel_stop(sig))
 				sigdelset(signal, SIGCONT);
 			sigaddset(signal, sig);
@@ -3023,7 +3017,7 @@ static void __set_task_blocked(struct task_struct *tsk, const sigset_t *newset)
  */
 void set_current_blocked(sigset_t *newset)
 {
-	sigdelsetmask(newset, sigmask(SIGKILL) | sigmask(SIGSTOP));
+	sigdelset(newset, SIGKILL, SIGSTOP);
 	__set_current_blocked(newset);
 }
 
@@ -3150,7 +3144,7 @@ SYSCALL_DEFINE4(rt_sigprocmask, int, how, sigset_t __user *, nset,
 	if (nset) {
 		if (copy_sigset_from_user(&new_set, nset, sigsetsize))
 			return -EFAULT;
-		sigdelsetmask(&new_set, sigmask(SIGKILL)|sigmask(SIGSTOP));
+		sigdelset(&new_set, SIGKILL, SIGSTOP);
 
 		error = sigprocmask(how, &new_set, NULL);
 		if (error)
@@ -3180,7 +3174,7 @@ COMPAT_SYSCALL_DEFINE4(rt_sigprocmask, int, how, compat_sigset_t __user *, nset,
 	if (nset) {
 		if (copy_compat_sigset_from_user(&new_set, nset, sigsetsize))
 			return -EFAULT;
-		sigdelsetmask(&new_set, sigmask(SIGKILL)|sigmask(SIGSTOP));
+		sigdelset(&new_set, SIGKILL, SIGSTOP);
 
 		error = sigprocmask(how, &new_set, NULL);
 		if (error)
@@ -3586,7 +3580,7 @@ static int do_sigtimedwait(const sigset_t *which, kernel_siginfo_t *info,
 	/*
 	 * Invert the set of allowed signals to get those we want to block.
 	 */
-	sigdelsetmask(&mask, sigmask(SIGKILL) | sigmask(SIGSTOP));
+	sigdelset(&mask, SIGKILL, SIGSTOP);
 	signotset(&mask);
 
 	spin_lock_irq(&tsk->sighand->siglock);
@@ -4111,8 +4105,7 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
 	sigaction_compat_abi(act, oact);
 
 	if (act) {
-		sigdelsetmask(&act->sa.sa_mask,
-			      sigmask(SIGKILL) | sigmask(SIGSTOP));
+		sigdelset(&act->sa.sa_mask, SIGKILL, SIGSTOP);
 		*k = *act;
 		/*
 		 * POSIX 3.3.1.3:
@@ -4126,9 +4119,7 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
 		 *   be discarded, whether or not it is blocked"
 		 */
 		if (sig_handler_ignored(sig_handler(p, sig), sig)) {
-			sigemptyset(&mask);
-			sigaddset(&mask, sig);
-			flush_sigqueue_mask(&mask, &p->signal->shared_pending);
+			flush_sigqueue_sig(&p->signal->shared_pending, sig);
 			for_each_thread(p, t)
 				flush_sigqueue_mask(&mask, &t->pending);
 		}
@@ -4332,10 +4323,10 @@ SYSCALL_DEFINE3(sigprocmask, int, how, old_sigset_t __user *, nset,
 
 		switch (how) {
 		case SIG_BLOCK:
-			sigaddsetmask(&new_blocked, new_set);
+			compat_sigaddsetmask(&new_blocked, new_set);
 			break;
 		case SIG_UNBLOCK:
-			sigdelsetmask(&new_blocked, new_set);
+			compat_sigdelsetmask(&new_blocked, new_set);
 			break;
 		case SIG_SETMASK:
 			new_blocked.sig[0] = new_set;
@@ -4724,6 +4715,10 @@ void __init signals_init(void)
 {
 	siginfo_buildtime_checks();
 
+	sigaddset(&signal_stop_mask, SIGSTOP, SIGTSTP, SIGTTIN, SIGTTOU);
+	sigaddset(&signal_synchronous_mask, SIGSEGV, SIGBUS, SIGILL, SIGTRAP,
+		 SIGFPE, SIGSYS);
+
 	sigqueue_cachep = KMEM_CACHE(sigqueue, SLAB_PANIC | SLAB_ACCOUNT);
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c8b3645c9a7d..ab6ba4ec661b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3684,7 +3684,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
 static int kvm_vcpu_ioctl_set_sigmask(struct kvm_vcpu *vcpu, sigset_t *sigset)
 {
 	if (sigset) {
-		sigdelsetmask(sigset, sigmask(SIGKILL)|sigmask(SIGSTOP));
+		sigdelset(sigset, SIGKILL, SIGSTOP);
 		vcpu->sigset_active = 1;
 		vcpu->sigset = *sigset;
 	} else
-- 
2.30.2

