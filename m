Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75965E4DB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 16:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394949AbfJYOBm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 10:01:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38065 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394946AbfJYOBl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:01:41 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iO09O-0000Ei-Aa; Fri, 25 Oct 2019 16:01:10 +0200
Date:   Fri, 25 Oct 2019 16:01:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, x86@kernel.org
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
In-Reply-To: <20191013191050.GL26530@ZenIV.linux.org.uk>
Message-ID: <alpine.DEB.2.21.1910251518150.3726@nanos.tec.linutronix.de>
References: <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com> <20191008032912.GQ26530@ZenIV.linux.org.uk> <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com> <CAHk-=wgOWxqwqCFuP_Bw=Hxxf9njeHJs0OLNGNc63peNd=kRqw@mail.gmail.com>
 <20191010195504.GI26530@ZenIV.linux.org.uk> <CAHk-=wgWRQo0m7TUCK4T_J-3Vqte+p-FWzvT3CB1jJHgX-KctA@mail.gmail.com> <20191011001104.GJ26530@ZenIV.linux.org.uk> <CAHk-=wgg3jzkk-jObm1FLVYGS8JCTiKppEnA00_QX7Wsm5ieLQ@mail.gmail.com> <20191013181333.GK26530@ZenIV.linux.org.uk>
 <CAHk-=wgrWGyACBM8N8KP7Pu_2VopuzM4A12yQz6Eo=X2Jpwzcw@mail.gmail.com> <20191013191050.GL26530@ZenIV.linux.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al,

On Sun, 13 Oct 2019, Al Viro wrote:
> On Sun, Oct 13, 2019 at 11:43:57AM -0700, Linus Torvalds wrote:
> > > And these (32bit and 64bit restore_sigcontext() and do_sys_vm86())
> > > are the only get_user_ex() users anywhere...
> > 
> > Yeah, that sounds like a solid strategy for getting rid of them.
> > 
> > Particularly since we can't really make get_user_ex() generate
> > particularly good code (at least for now).
> > 
> > Now, put_user_ex() is a different thing - converting it to
> > unsafe_put_user() actually does make it generate very good code - much
> > better than copying data twice.
> 
> No arguments re put_user_ex side of things...  Below is a completely
> untested patch for get_user_ex elimination (it seems to build, but that's
> it); in any case, I would really like to see comments from x86 folks
> before it goes anywhere.

I'm fine with the approach, but I'd like to see the macro mess gone as
well. Reworked patch below.

Can you please split that up into several patches (signal, ia32/signal,
vm86 and removal) ?

Thanks,

	tglx

8<------------
diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 1cee10091b9f..00bf8ac1d42a 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -35,70 +35,57 @@
 #include <asm/sighandling.h>
 #include <asm/smap.h>
 
+static inline void reload_segments(struct sigcontext_32 *sc)
+{
+	unsigned int cur;
+
+	savesegment(gs, cur);
+	if ((sc->gs | 0x03) != cur)
+		load_gs_index(sc->gs | 0x03);
+	savesegment(fs, cur);
+	if ((sc->fs | 0x03) != cur)
+		loadsegment(fs, sc->fs | 0x03);
+	savesegment(ds, cur);
+	if ((sc->ds | 0x03) != cur)
+		loadsegment(ds, sc->ds | 0x03);
+	savesegment(es, cur);
+	if ((sc->es | 0x03) != cur)
+		loadsegment(es, sc->es | 0x03);
+}
+
 /*
  * Do a signal return; undo the signal stack.
  */
-#define loadsegment_gs(v)	load_gs_index(v)
-#define loadsegment_fs(v)	loadsegment(fs, v)
-#define loadsegment_ds(v)	loadsegment(ds, v)
-#define loadsegment_es(v)	loadsegment(es, v)
-
-#define get_user_seg(seg)	({ unsigned int v; savesegment(seg, v); v; })
-#define set_user_seg(seg, v)	loadsegment_##seg(v)
-
-#define COPY(x)			{		\
-	get_user_ex(regs->x, &sc->x);		\
-}
-
-#define GET_SEG(seg)		({			\
-	unsigned short tmp;				\
-	get_user_ex(tmp, &sc->seg);			\
-	tmp;						\
-})
-
-#define COPY_SEG_CPL3(seg)	do {			\
-	regs->seg = GET_SEG(seg) | 3;			\
-} while (0)
-
-#define RELOAD_SEG(seg)		{		\
-	unsigned int pre = (seg) | 3;		\
-	unsigned int cur = get_user_seg(seg);	\
-	if (pre != cur)				\
-		set_user_seg(seg, pre);		\
-}
-
 static int ia32_restore_sigcontext(struct pt_regs *regs,
-				   struct sigcontext_32 __user *sc)
+				   struct sigcontext_32 __user *usc)
 {
-	unsigned int tmpflags, err = 0;
-	u16 gs, fs, es, ds;
-	void __user *buf;
-	u32 tmp;
+	struct sigcontext_32 sc;
+	int ret = -EFAULT;
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
 
-	get_user_try {
-		gs = GET_SEG(gs);
-		fs = GET_SEG(fs);
-		ds = GET_SEG(ds);
-		es = GET_SEG(es);
+	if (unlikely(__copy_from_user(&sc, usc, sizeof(sc))))
+		goto out;
 
-		COPY(di); COPY(si); COPY(bp); COPY(sp); COPY(bx);
-		COPY(dx); COPY(cx); COPY(ip); COPY(ax);
-		/* Don't touch extended registers */
+	/* Get only the ia32 registers. */
+	regs->bx = sc.bx;
+	regs->cx = sc.cx;
+	regs->dx = sc.dx;
+	regs->si = sc.si;
+	regs->di = sc.di;
+	regs->bp = sc.bp;
+	regs->ax = sc.ax;
+	regs->sp = sc.sp;
+	regs->ip = sc.ip;
 
-		COPY_SEG_CPL3(cs);
-		COPY_SEG_CPL3(ss);
+	/* Get CS/SS and force CPL3 */
+	regs->cs = sc.cs | 0x03;
+	regs->ss = sc.ss | 0x03;
 
-		get_user_ex(tmpflags, &sc->flags);
-		regs->flags = (regs->flags & ~FIX_EFLAGS) | (tmpflags & FIX_EFLAGS);
-		/* disable syscall checks */
-		regs->orig_ax = -1;
-
-		get_user_ex(tmp, &sc->fpstate);
-		buf = compat_ptr(tmp);
-	} get_user_catch(err);
+	regs->flags = (regs->flags & ~FIX_EFLAGS) | (sc.flags & FIX_EFLAGS);
+	/* disable syscall checks */
+	regs->orig_ax = -1;
 
 	/*
 	 * Reload fs and gs if they have changed in the signal
@@ -106,16 +93,12 @@ static int ia32_restore_sigcontext(struct pt_regs *regs,
 	 * the handler, but does not clobber them at least in the
 	 * normal case.
 	 */
-	RELOAD_SEG(gs);
-	RELOAD_SEG(fs);
-	RELOAD_SEG(ds);
-	RELOAD_SEG(es);
-
-	err |= fpu__restore_sig(buf, 1);
+	reload_segments(&sc);
 
+	ret = fpu__restore_sig(compat_ptr(sc.fpstate), 1);
+out:
 	force_iret();
-
-	return err;
+	return ret;
 }
 
 asmlinkage long sys32_sigreturn(void)
@@ -176,6 +159,8 @@ asmlinkage long sys32_rt_sigreturn(void)
  * Set up a signal frame.
  */
 
+#define get_user_seg(seg)	({ unsigned int v; savesegment(seg, v); v; })
+
 static int ia32_setup_sigcontext(struct sigcontext_32 __user *sc,
 				 void __user *fpstate,
 				 struct pt_regs *regs, unsigned int mask)
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 61d93f062a36..ac81f06f8358 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -335,12 +335,9 @@ do {									\
 		       "i" (errret), "0" (retval));			\
 })
 
-#define __get_user_asm_ex_u64(x, ptr)			(x) = __get_user_bad()
 #else
 #define __get_user_asm_u64(x, ptr, retval, errret) \
 	 __get_user_asm(x, ptr, retval, "q", "", "=r", errret)
-#define __get_user_asm_ex_u64(x, ptr) \
-	 __get_user_asm_ex(x, ptr, "q", "", "=r")
 #endif
 
 #define __get_user_size(x, ptr, size, retval, errret)			\
@@ -390,41 +387,6 @@ do {									\
 		     : "=r" (err), ltype(x)				\
 		     : "m" (__m(addr)), "i" (errret), "0" (err))
 
-/*
- * This doesn't do __uaccess_begin/end - the exception handling
- * around it must do that.
- */
-#define __get_user_size_ex(x, ptr, size)				\
-do {									\
-	__chk_user_ptr(ptr);						\
-	switch (size) {							\
-	case 1:								\
-		__get_user_asm_ex(x, ptr, "b", "b", "=q");		\
-		break;							\
-	case 2:								\
-		__get_user_asm_ex(x, ptr, "w", "w", "=r");		\
-		break;							\
-	case 4:								\
-		__get_user_asm_ex(x, ptr, "l", "k", "=r");		\
-		break;							\
-	case 8:								\
-		__get_user_asm_ex_u64(x, ptr);				\
-		break;							\
-	default:							\
-		(x) = __get_user_bad();					\
-	}								\
-} while (0)
-
-#define __get_user_asm_ex(x, addr, itype, rtype, ltype)			\
-	asm volatile("1:	mov"itype" %1,%"rtype"0\n"		\
-		     "2:\n"						\
-		     ".section .fixup,\"ax\"\n"				\
-                     "3:xor"itype" %"rtype"0,%"rtype"0\n"		\
-		     "  jmp 2b\n"					\
-		     ".previous\n"					\
-		     _ASM_EXTABLE_EX(1b, 3b)				\
-		     : ltype(x) : "m" (__m(addr)))
-
 #define __put_user_nocheck(x, ptr, size)			\
 ({								\
 	__label__ __pu_label;					\
@@ -552,22 +514,6 @@ struct __large_struct { unsigned long buf[100]; };
 #define __put_user(x, ptr)						\
 	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
 
-/*
- * {get|put}_user_try and catch
- *
- * get_user_try {
- *	get_user_ex(...);
- * } get_user_catch(err)
- */
-#define get_user_try		uaccess_try_nospec
-#define get_user_catch(err)	uaccess_catch(err)
-
-#define get_user_ex(x, ptr)	do {					\
-	unsigned long __gue_val;					\
-	__get_user_size_ex((__gue_val), (ptr), (sizeof(*(ptr))));	\
-	(x) = (__force __typeof__(*(ptr)))__gue_val;			\
-} while (0)
-
 #define put_user_try		uaccess_try
 #define put_user_catch(err)	uaccess_catch(err)
 
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 8eb7193e158d..c5c24cee3868 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -47,24 +47,6 @@
 #include <asm/sigframe.h>
 #include <asm/signal.h>
 
-#define COPY(x)			do {			\
-	get_user_ex(regs->x, &sc->x);			\
-} while (0)
-
-#define GET_SEG(seg)		({			\
-	unsigned short tmp;				\
-	get_user_ex(tmp, &sc->seg);			\
-	tmp;						\
-})
-
-#define COPY_SEG(seg)		do {			\
-	regs->seg = GET_SEG(seg);			\
-} while (0)
-
-#define COPY_SEG_CPL3(seg)	do {			\
-	regs->seg = GET_SEG(seg) | 3;			\
-} while (0)
-
 #ifdef CONFIG_X86_64
 /*
  * If regs->ss will cause an IRET fault, change it.  Otherwise leave it
@@ -92,53 +74,59 @@ static void force_valid_ss(struct pt_regs *regs)
 	    ar != (AR_DPL3 | AR_S | AR_P | AR_TYPE_RWDATA_EXPDOWN))
 		regs->ss = __USER_DS;
 }
+# define CONTEXT_COPY_SIZE	offsetof(struct sigcontext, reserved1)
+#else
+# define CONTEXT_COPY_SIZE	sizeof(struct sigcontext)
 #endif
 
 static int restore_sigcontext(struct pt_regs *regs,
-			      struct sigcontext __user *sc,
+			      struct sigcontext __user *usc,
 			      unsigned long uc_flags)
 {
-	unsigned long buf_val;
-	void __user *buf;
-	unsigned int tmpflags;
-	unsigned int err = 0;
+	struct sigcontext sc;
+	int ret = -EFAULT;
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
 
-	get_user_try {
+	if (unlikely(__copy_from_user(&sc, usc, CONTEXT_COPY_SIZE)))
+		goto out;
 
 #ifdef CONFIG_X86_32
-		set_user_gs(regs, GET_SEG(gs));
-		COPY_SEG(fs);
-		COPY_SEG(es);
-		COPY_SEG(ds);
+	set_user_gs(regs, sc.gs);
+	regs->fs = sc.fs;
+	regs->es = sc.es;
+	regs->ds = sc.ds;
 #endif /* CONFIG_X86_32 */
 
-		COPY(di); COPY(si); COPY(bp); COPY(sp); COPY(bx);
-		COPY(dx); COPY(cx); COPY(ip); COPY(ax);
+	regs->bx = sc.bx;
+	regs->cx = sc.cx;
+	regs->dx = sc.dx;
+	regs->si = sc.si;
+	regs->di = sc.di;
+	regs->bp = sc.bp;
+	regs->ax = sc.ax;
+	regs->sp = sc.sp;
+	regs->ip = sc.ip;
 
 #ifdef CONFIG_X86_64
-		COPY(r8);
-		COPY(r9);
-		COPY(r10);
-		COPY(r11);
-		COPY(r12);
-		COPY(r13);
-		COPY(r14);
-		COPY(r15);
+	regs->r8 = sc.r8;
+	regs->r9 = sc.r9;
+	regs->r10 = sc.r10;
+	regs->r11 = sc.r11;
+	regs->r12 = sc.r12;
+	regs->r13 = sc.r13;
+	regs->r14 = sc.r14;
+	regs->r15 = sc.r15;
 #endif /* CONFIG_X86_64 */
 
-		COPY_SEG_CPL3(cs);
-		COPY_SEG_CPL3(ss);
+	/* Get CS/SS and force CPL3 */
+	regs->cs = sc.cs | 0x03;
+	regs->ss = sc.ss | 0x03;
 
-		get_user_ex(tmpflags, &sc->flags);
-		regs->flags = (regs->flags & ~FIX_EFLAGS) | (tmpflags & FIX_EFLAGS);
-		regs->orig_ax = -1;		/* disable syscall checks */
-
-		get_user_ex(buf_val, &sc->fpstate);
-		buf = (void __user *)buf_val;
-	} get_user_catch(err);
+	regs->flags = (regs->flags & ~FIX_EFLAGS) | (sc.flags & FIX_EFLAGS);
+	/* disable syscall checks */
+	regs->orig_ax = -1;
 
 #ifdef CONFIG_X86_64
 	/*
@@ -149,11 +137,11 @@ static int restore_sigcontext(struct pt_regs *regs,
 		force_valid_ss(regs);
 #endif
 
-	err |= fpu__restore_sig(buf, IS_ENABLED(CONFIG_X86_32));
-
+	ret = fpu__restore_sig((void __user *)sc.fpstate,
+			       IS_ENABLED(CONFIG_X86_32));
+out:
 	force_iret();
-
-	return err;
+	return ret;
 }
 
 int setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index a76c12b38e92..11ef9d3c5387 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -243,6 +243,7 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
 	struct kernel_vm86_regs vm86regs;
 	struct pt_regs *regs = current_pt_regs();
 	unsigned long err = 0;
+	struct vm86_struct v;
 
 	err = security_mmap_addr(0);
 	if (err) {
@@ -283,34 +284,32 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
 		       sizeof(struct vm86plus_struct)))
 		return -EFAULT;
 
+	if (unlikely(__copy_from_user(&v, user_vm86,
+			offsetof(struct vm86_struct, int_revectored))))
+		return -EFAULT;
+
 	memset(&vm86regs, 0, sizeof(vm86regs));
-	get_user_try {
-		unsigned short seg;
-		get_user_ex(vm86regs.pt.bx, &user_vm86->regs.ebx);
-		get_user_ex(vm86regs.pt.cx, &user_vm86->regs.ecx);
-		get_user_ex(vm86regs.pt.dx, &user_vm86->regs.edx);
-		get_user_ex(vm86regs.pt.si, &user_vm86->regs.esi);
-		get_user_ex(vm86regs.pt.di, &user_vm86->regs.edi);
-		get_user_ex(vm86regs.pt.bp, &user_vm86->regs.ebp);
-		get_user_ex(vm86regs.pt.ax, &user_vm86->regs.eax);
-		get_user_ex(vm86regs.pt.ip, &user_vm86->regs.eip);
-		get_user_ex(seg, &user_vm86->regs.cs);
-		vm86regs.pt.cs = seg;
-		get_user_ex(vm86regs.pt.flags, &user_vm86->regs.eflags);
-		get_user_ex(vm86regs.pt.sp, &user_vm86->regs.esp);
-		get_user_ex(seg, &user_vm86->regs.ss);
-		vm86regs.pt.ss = seg;
-		get_user_ex(vm86regs.es, &user_vm86->regs.es);
-		get_user_ex(vm86regs.ds, &user_vm86->regs.ds);
-		get_user_ex(vm86regs.fs, &user_vm86->regs.fs);
-		get_user_ex(vm86regs.gs, &user_vm86->regs.gs);
-
-		get_user_ex(vm86->flags, &user_vm86->flags);
-		get_user_ex(vm86->screen_bitmap, &user_vm86->screen_bitmap);
-		get_user_ex(vm86->cpu_type, &user_vm86->cpu_type);
-	} get_user_catch(err);
-	if (err)
-		return err;
+
+	vm86regs.pt.bx = v.regs.ebx;
+	vm86regs.pt.cx = v.regs.ecx;
+	vm86regs.pt.dx = v.regs.edx;
+	vm86regs.pt.si = v.regs.esi;
+	vm86regs.pt.di = v.regs.edi;
+	vm86regs.pt.bp = v.regs.ebp;
+	vm86regs.pt.ax = v.regs.eax;
+	vm86regs.pt.ip = v.regs.eip;
+	vm86regs.pt.cs = v.regs.cs;
+	vm86regs.pt.flags = v.regs.eflags;
+	vm86regs.pt.sp = v.regs.esp;
+	vm86regs.pt.ss = v.regs.ss;
+	vm86regs.es = v.regs.es;
+	vm86regs.ds = v.regs.ds;
+	vm86regs.fs = v.regs.fs;
+	vm86regs.gs = v.regs.gs;
+
+	vm86->flags = v.flags;
+	vm86->screen_bitmap = v.screen_bitmap;
+	vm86->cpu_type = v.cpu_type;
 
 	if (copy_from_user(&vm86->int_revectored,
 			   &user_vm86->int_revectored,

