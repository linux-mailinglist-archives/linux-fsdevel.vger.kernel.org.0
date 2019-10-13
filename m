Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31884D579D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2019 21:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfJMTKx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Oct 2019 15:10:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34682 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729335AbfJMTKx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Oct 2019 15:10:53 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iJjGU-0007jV-Rk; Sun, 13 Oct 2019 19:10:51 +0000
Date:   Sun, 13 Oct 2019 20:10:50 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Message-ID: <20191013191050.GL26530@ZenIV.linux.org.uk>
References: <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
 <20191008032912.GQ26530@ZenIV.linux.org.uk>
 <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
 <CAHk-=wgOWxqwqCFuP_Bw=Hxxf9njeHJs0OLNGNc63peNd=kRqw@mail.gmail.com>
 <20191010195504.GI26530@ZenIV.linux.org.uk>
 <CAHk-=wgWRQo0m7TUCK4T_J-3Vqte+p-FWzvT3CB1jJHgX-KctA@mail.gmail.com>
 <20191011001104.GJ26530@ZenIV.linux.org.uk>
 <CAHk-=wgg3jzkk-jObm1FLVYGS8JCTiKppEnA00_QX7Wsm5ieLQ@mail.gmail.com>
 <20191013181333.GK26530@ZenIV.linux.org.uk>
 <CAHk-=wgrWGyACBM8N8KP7Pu_2VopuzM4A12yQz6Eo=X2Jpwzcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgrWGyACBM8N8KP7Pu_2VopuzM4A12yQz6Eo=X2Jpwzcw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 13, 2019 at 11:43:57AM -0700, Linus Torvalds wrote:
> On Sun, Oct 13, 2019 at 11:13 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Umm...  TBH, I wonder if we would be better off if restore_sigcontext()
> > (i.e. sigreturn()/rt_sigreturn()) would flat-out copy_from_user() the
> > entire[*] struct sigcontext into a local variable and then copied fields
> > to pt_regs...
> 
> Probably ok., We've generally tried to avoid state that big on the
> stack, but you're right that it's shallow.
>
> > Same for do_sys_vm86(), perhaps.
> >
> > And these (32bit and 64bit restore_sigcontext() and do_sys_vm86())
> > are the only get_user_ex() users anywhere...
> 
> Yeah, that sounds like a solid strategy for getting rid of them.
> 
> Particularly since we can't really make get_user_ex() generate
> particularly good code (at least for now).
> 
> Now, put_user_ex() is a different thing - converting it to
> unsafe_put_user() actually does make it generate very good code - much
> better than copying data twice.

No arguments re put_user_ex side of things...  Below is a completely
untested patch for get_user_ex elimination (it seems to build, but that's
it); in any case, I would really like to see comments from x86 folks
before it goes anywhere.

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 1cee10091b9f..28a32ccc32de 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -46,59 +46,38 @@
 #define get_user_seg(seg)	({ unsigned int v; savesegment(seg, v); v; })
 #define set_user_seg(seg, v)	loadsegment_##seg(v)
 
-#define COPY(x)			{		\
-	get_user_ex(regs->x, &sc->x);		\
-}
-
-#define GET_SEG(seg)		({			\
-	unsigned short tmp;				\
-	get_user_ex(tmp, &sc->seg);			\
-	tmp;						\
-})
+#define COPY(x) regs->x = sc.x
 
-#define COPY_SEG_CPL3(seg)	do {			\
-	regs->seg = GET_SEG(seg) | 3;			\
-} while (0)
+#define COPY_SEG_CPL3(seg) regs->seg = sc.seg | 3
 
 #define RELOAD_SEG(seg)		{		\
-	unsigned int pre = (seg) | 3;		\
+	unsigned int pre = sc.seg | 3;		\
 	unsigned int cur = get_user_seg(seg);	\
 	if (pre != cur)				\
 		set_user_seg(seg, pre);		\
 }
 
 static int ia32_restore_sigcontext(struct pt_regs *regs,
-				   struct sigcontext_32 __user *sc)
+				   struct sigcontext_32 __user *usc)
 {
-	unsigned int tmpflags, err = 0;
-	u16 gs, fs, es, ds;
-	void __user *buf;
-	u32 tmp;
+	struct sigcontext_32 sc;
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
 
-	get_user_try {
-		gs = GET_SEG(gs);
-		fs = GET_SEG(fs);
-		ds = GET_SEG(ds);
-		es = GET_SEG(es);
-
-		COPY(di); COPY(si); COPY(bp); COPY(sp); COPY(bx);
-		COPY(dx); COPY(cx); COPY(ip); COPY(ax);
-		/* Don't touch extended registers */
+	if (unlikely(__copy_from_user(&sc, usc, sizeof(sc))))
+		goto Efault;
 
-		COPY_SEG_CPL3(cs);
-		COPY_SEG_CPL3(ss);
+	COPY(di); COPY(si); COPY(bp); COPY(sp); COPY(bx);
+	COPY(dx); COPY(cx); COPY(ip); COPY(ax);
+	/* Don't touch extended registers */
 
-		get_user_ex(tmpflags, &sc->flags);
-		regs->flags = (regs->flags & ~FIX_EFLAGS) | (tmpflags & FIX_EFLAGS);
-		/* disable syscall checks */
-		regs->orig_ax = -1;
+	COPY_SEG_CPL3(cs);
+	COPY_SEG_CPL3(ss);
 
-		get_user_ex(tmp, &sc->fpstate);
-		buf = compat_ptr(tmp);
-	} get_user_catch(err);
+	regs->flags = (regs->flags & ~FIX_EFLAGS) | (sc.flags & FIX_EFLAGS);
+	/* disable syscall checks */
+	regs->orig_ax = -1;
 
 	/*
 	 * Reload fs and gs if they have changed in the signal
@@ -111,11 +90,15 @@ static int ia32_restore_sigcontext(struct pt_regs *regs,
 	RELOAD_SEG(ds);
 	RELOAD_SEG(es);
 
-	err |= fpu__restore_sig(buf, 1);
+	if (unlikely(fpu__restore_sig(compat_ptr(sc.fpstate), 1)))
+		goto Efault;
 
 	force_iret();
+	return 0;
 
-	return err;
+Efault:
+	force_iret();
+	return -EFAULT;
 }
 
 asmlinkage long sys32_sigreturn(void)
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
index 8eb7193e158d..301d34b256c6 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -47,23 +47,9 @@
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
+#define COPY(x)	regs->x = sc.x
+#define COPY_SEG(seg) regs->seg = sc.seg
+#define COPY_SEG_CPL3(seg) regs->seg = sc.seg | 3
 
 #ifdef CONFIG_X86_64
 /*
@@ -95,50 +81,53 @@ static void force_valid_ss(struct pt_regs *regs)
 #endif
 
 static int restore_sigcontext(struct pt_regs *regs,
-			      struct sigcontext __user *sc,
+			      struct sigcontext __user *usc,
 			      unsigned long uc_flags)
 {
-	unsigned long buf_val;
 	void __user *buf;
-	unsigned int tmpflags;
-	unsigned int err = 0;
+	struct sigcontext sc;
+	enum {
+#ifdef CONFIG_X86_32
+		To_copy = sizeof(struct sigcontext),
+#else
+		To_copy = offsetof(struct sigcontext, reserved1),
+#endif
+	};
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
 
-	get_user_try {
+	if (unlikely(__copy_from_user(&sc, usc, To_copy)))
+		goto Efault;
 
 #ifdef CONFIG_X86_32
-		set_user_gs(regs, GET_SEG(gs));
-		COPY_SEG(fs);
-		COPY_SEG(es);
-		COPY_SEG(ds);
+	set_user_gs(regs, sc.gs);
+	COPY_SEG(fs);
+	COPY_SEG(es);
+	COPY_SEG(ds);
 #endif /* CONFIG_X86_32 */
 
-		COPY(di); COPY(si); COPY(bp); COPY(sp); COPY(bx);
-		COPY(dx); COPY(cx); COPY(ip); COPY(ax);
+	COPY(di); COPY(si); COPY(bp); COPY(sp); COPY(bx);
+	COPY(dx); COPY(cx); COPY(ip); COPY(ax);
 
 #ifdef CONFIG_X86_64
-		COPY(r8);
-		COPY(r9);
-		COPY(r10);
-		COPY(r11);
-		COPY(r12);
-		COPY(r13);
-		COPY(r14);
-		COPY(r15);
+	COPY(r8);
+	COPY(r9);
+	COPY(r10);
+	COPY(r11);
+	COPY(r12);
+	COPY(r13);
+	COPY(r14);
+	COPY(r15);
 #endif /* CONFIG_X86_64 */
 
-		COPY_SEG_CPL3(cs);
-		COPY_SEG_CPL3(ss);
+	COPY_SEG_CPL3(cs);
+	COPY_SEG_CPL3(ss);
 
-		get_user_ex(tmpflags, &sc->flags);
-		regs->flags = (regs->flags & ~FIX_EFLAGS) | (tmpflags & FIX_EFLAGS);
-		regs->orig_ax = -1;		/* disable syscall checks */
+	regs->flags = (regs->flags & ~FIX_EFLAGS) | (sc.flags & FIX_EFLAGS);
+	regs->orig_ax = -1;		/* disable syscall checks */
 
-		get_user_ex(buf_val, &sc->fpstate);
-		buf = (void __user *)buf_val;
-	} get_user_catch(err);
+	buf = (void __user *)sc.fpstate;
 
 #ifdef CONFIG_X86_64
 	/*
@@ -149,11 +138,14 @@ static int restore_sigcontext(struct pt_regs *regs,
 		force_valid_ss(regs);
 #endif
 
-	err |= fpu__restore_sig(buf, IS_ENABLED(CONFIG_X86_32));
-
+	if (unlikely(fpu__restore_sig(buf, IS_ENABLED(CONFIG_X86_32))))
+		goto Efault;
 	force_iret();
+	return 0;
 
-	return err;
+Efault:
+	force_iret();
+	return -EFAULT;
 }
 
 int setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index a76c12b38e92..2b5183f8eb48 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -242,6 +242,7 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
 	struct vm86 *vm86 = tsk->thread.vm86;
 	struct kernel_vm86_regs vm86regs;
 	struct pt_regs *regs = current_pt_regs();
+	struct vm86_struct v;
 	unsigned long err = 0;
 
 	err = security_mmap_addr(0);
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
