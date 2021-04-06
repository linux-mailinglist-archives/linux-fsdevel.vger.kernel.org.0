Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F353556C8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 16:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345233AbhDFOjn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 10:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243274AbhDFOjl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:39:41 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9A6C061756
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Apr 2021 07:39:33 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id l12-20020a9d6a8c0000b0290238e0f9f0d8so14809123otq.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Apr 2021 07:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=A9/oUrZcom6uNGfq8uQSMfL5RjzorysUyhxrrEpOhZQ=;
        b=jVp4LQa5fpfONGeRhMPma1uxlOJ6CXJvy93wnlaGkszijzRZX4GP31qLbOdrFUx9d8
         SN7/z6WwtNVmZgiGOxPPOtCgT1NQH7g3NP6K1uj/d+Cj5DiyhAg9llwoIeBQaQAM7mfK
         7gxshk0yzmOS3ig6OVdDC/A0+bDYmd1+7IYazjMD55ELbrWFzOc5U+f9Ua47SqJiE2ic
         qy3L2qasrr7N5nB6l3tEqmiBFqvfSJc5WoMKGegkuJ45Nl1JSVvxDDJMGiq0a+L0JLgE
         OWxYGV+4WSfrvV+iZ2O7gIN/tkpU4+EMOq2QHye+MWXNdq8mFdSi+zrXV9NFYQtQkQo1
         1iDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=A9/oUrZcom6uNGfq8uQSMfL5RjzorysUyhxrrEpOhZQ=;
        b=Q40rmpc5NhbfOgqgfKmOoKkQs1XlkJuSTmlBW/F8vvrwBnxK6VGw9k1O7qDJskpZBx
         k0BoqJBM89XsVxPFV/Lu/usJ9neY7iS+7ln/VvOuLyOQTuu9XVLCENQmFoCgf0afreir
         H31Y1pt3aualm1BD1VY4vInt7ErSvP3yXfbcYaZvhH2N9nu8FTLY7VP4OUo5E6HF/qHZ
         TNBcdtdy3U1BhiawGg89m7kGrhDsvT0AqBXqAELG/wyCbCrgSnFDT+HiduxWw0zPrAWl
         LmaloIlEuKrpOjy132EWqmf+lwT33zWoN66veSUpshXi5BrtNoDbpTxsxNcKBbtGqntQ
         cysw==
X-Gm-Message-State: AOAM531I7HpcPWguM8l9AHZbRlKbkzFLcpD4pk6h5wDTvezWWLv/dDQs
        K0f64nqDOTugUeD8kGIERBEpEA==
X-Google-Smtp-Source: ABdhPJy8JWc4jZaZX01KbZFfD0qHlJIfjC5GLBU9ob9QnsmfPtoyA8gGMABB2kkmRAhm7/K2AJZ2Dg==
X-Received: by 2002:a05:6830:15d2:: with SMTP id j18mr27564004otr.75.1617719972291;
        Tue, 06 Apr 2021 07:39:32 -0700 (PDT)
Received: from minyard.net ([2001:470:b8f6:1b:f584:ff80:e7e9:e850])
        by smtp.gmail.com with ESMTPSA id a6sm3567669oiw.44.2021.04.06.07.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 07:39:32 -0700 (PDT)
Date:   Tue, 6 Apr 2021 09:39:29 -0500
From:   Corey Minyard <cminyard@mvista.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Joerg Roedel <jroedel@suse.de>, Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-remoteproc@vger.kernel.org, linux-arch@vger.kernel.org,
        kexec@lists.infradead.org, rcu@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Corey Minyard <minyard@acm.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: Re: [PATCH v1 1/1] kernel.h: Split out panic and oops helpers
Message-ID: <20210406143929.GN7167@minyard.net>
Reply-To: cminyard@mvista.com
References: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 06, 2021 at 04:31:58PM +0300, Andy Shevchenko wrote:
> kernel.h is being used as a dump for all kinds of stuff for a long time.
> Here is the attempt to start cleaning it up by splitting out panic and
> oops helpers.
> 
> At the same time convert users in header and lib folder to use new header.
> Though for time being include new header back to kernel.h to avoid twisted
> indirected includes for existing users.

For the IPMI portion:

Acked-by: Corey Minyard <cminyard@mvista.com>

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/powerpc/kernel/setup-common.c   |  1 +
>  arch/x86/include/asm/desc.h          |  1 +
>  arch/x86/kernel/cpu/mshyperv.c       |  1 +
>  arch/x86/kernel/setup.c              |  1 +
>  drivers/char/ipmi/ipmi_msghandler.c  |  1 +
>  drivers/remoteproc/remoteproc_core.c |  1 +
>  include/asm-generic/bug.h            |  3 +-
>  include/linux/kernel.h               | 84 +-----------------------
>  include/linux/panic.h                | 98 ++++++++++++++++++++++++++++
>  include/linux/panic_notifier.h       | 12 ++++
>  kernel/hung_task.c                   |  1 +
>  kernel/kexec_core.c                  |  1 +
>  kernel/panic.c                       |  1 +
>  kernel/rcu/tree.c                    |  2 +
>  kernel/sysctl.c                      |  1 +
>  kernel/trace/trace.c                 |  1 +
>  16 files changed, 126 insertions(+), 84 deletions(-)
>  create mode 100644 include/linux/panic.h
>  create mode 100644 include/linux/panic_notifier.h
> 
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 74a98fff2c2f..046fe21b5c3b 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -9,6 +9,7 @@
>  #undef DEBUG
>  
>  #include <linux/export.h>
> +#include <linux/panic_notifier.h>
>  #include <linux/string.h>
>  #include <linux/sched.h>
>  #include <linux/init.h>
> diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
> index 476082a83d1c..ceb12683b6d1 100644
> --- a/arch/x86/include/asm/desc.h
> +++ b/arch/x86/include/asm/desc.h
> @@ -9,6 +9,7 @@
>  #include <asm/irq_vectors.h>
>  #include <asm/cpu_entry_area.h>
>  
> +#include <linux/debug_locks.h>
>  #include <linux/smp.h>
>  #include <linux/percpu.h>
>  
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 22f13343b5da..9e5c6f2b044d 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -17,6 +17,7 @@
>  #include <linux/irq.h>
>  #include <linux/kexec.h>
>  #include <linux/i8253.h>
> +#include <linux/panic_notifier.h>
>  #include <linux/random.h>
>  #include <asm/processor.h>
>  #include <asm/hypervisor.h>
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 59e5e0903b0c..570699eecf90 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -14,6 +14,7 @@
>  #include <linux/initrd.h>
>  #include <linux/iscsi_ibft.h>
>  #include <linux/memblock.h>
> +#include <linux/panic_notifier.h>
>  #include <linux/pci.h>
>  #include <linux/root_dev.h>
>  #include <linux/hugetlb.h>
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 8a0e97b33cae..e96cb5c4f97a 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -16,6 +16,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/errno.h>
> +#include <linux/panic_notifier.h>
>  #include <linux/poll.h>
>  #include <linux/sched.h>
>  #include <linux/seq_file.h>
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 626a6b90fba2..76dd8e2b1e7e 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -20,6 +20,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/device.h>
> +#include <linux/panic_notifier.h>
>  #include <linux/slab.h>
>  #include <linux/mutex.h>
>  #include <linux/dma-map-ops.h>
> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> index 76a10e0dca9f..719410b93f99 100644
> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h
> @@ -17,7 +17,8 @@
>  #endif
>  
>  #ifndef __ASSEMBLY__
> -#include <linux/kernel.h>
> +#include <linux/panic.h>
> +#include <linux/printk.h>
>  
>  #ifdef CONFIG_BUG
>  
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 09035ac67d4b..6c5a05ac1ecb 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -14,6 +14,7 @@
>  #include <linux/math.h>
>  #include <linux/minmax.h>
>  #include <linux/typecheck.h>
> +#include <linux/panic.h>
>  #include <linux/printk.h>
>  #include <linux/build_bug.h>
>  #include <linux/static_call_types.h>
> @@ -70,7 +71,6 @@
>  #define lower_32_bits(n) ((u32)((n) & 0xffffffff))
>  
>  struct completion;
> -struct pt_regs;
>  struct user;
>  
>  #ifdef CONFIG_PREEMPT_VOLUNTARY
> @@ -175,14 +175,6 @@ void __might_fault(const char *file, int line);
>  static inline void might_fault(void) { }
>  #endif
>  
> -extern struct atomic_notifier_head panic_notifier_list;
> -extern long (*panic_blink)(int state);
> -__printf(1, 2)
> -void panic(const char *fmt, ...) __noreturn __cold;
> -void nmi_panic(struct pt_regs *regs, const char *msg);
> -extern void oops_enter(void);
> -extern void oops_exit(void);
> -extern bool oops_may_print(void);
>  void do_exit(long error_code) __noreturn;
>  void complete_and_exit(struct completion *, long) __noreturn;
>  
> @@ -368,52 +360,8 @@ extern int __kernel_text_address(unsigned long addr);
>  extern int kernel_text_address(unsigned long addr);
>  extern int func_ptr_is_kernel_text(void *ptr);
>  
> -#ifdef CONFIG_SMP
> -extern unsigned int sysctl_oops_all_cpu_backtrace;
> -#else
> -#define sysctl_oops_all_cpu_backtrace 0
> -#endif /* CONFIG_SMP */
> -
>  extern void bust_spinlocks(int yes);
> -extern int panic_timeout;
> -extern unsigned long panic_print;
> -extern int panic_on_oops;
> -extern int panic_on_unrecovered_nmi;
> -extern int panic_on_io_nmi;
> -extern int panic_on_warn;
> -extern unsigned long panic_on_taint;
> -extern bool panic_on_taint_nousertaint;
> -extern int sysctl_panic_on_rcu_stall;
> -extern int sysctl_max_rcu_stall_to_panic;
> -extern int sysctl_panic_on_stackoverflow;
> -
> -extern bool crash_kexec_post_notifiers;
>  
> -/*
> - * panic_cpu is used for synchronizing panic() and crash_kexec() execution. It
> - * holds a CPU number which is executing panic() currently. A value of
> - * PANIC_CPU_INVALID means no CPU has entered panic() or crash_kexec().
> - */
> -extern atomic_t panic_cpu;
> -#define PANIC_CPU_INVALID	-1
> -
> -/*
> - * Only to be used by arch init code. If the user over-wrote the default
> - * CONFIG_PANIC_TIMEOUT, honor it.
> - */
> -static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
> -{
> -	if (panic_timeout == arch_default_timeout)
> -		panic_timeout = timeout;
> -}
> -extern const char *print_tainted(void);
> -enum lockdep_ok {
> -	LOCKDEP_STILL_OK,
> -	LOCKDEP_NOW_UNRELIABLE
> -};
> -extern void add_taint(unsigned flag, enum lockdep_ok);
> -extern int test_taint(unsigned flag);
> -extern unsigned long get_taint(void);
>  extern int root_mountflags;
>  
>  extern bool early_boot_irqs_disabled;
> @@ -432,36 +380,6 @@ extern enum system_states {
>  	SYSTEM_SUSPEND,
>  } system_state;
>  
> -/* This cannot be an enum because some may be used in assembly source. */
> -#define TAINT_PROPRIETARY_MODULE	0
> -#define TAINT_FORCED_MODULE		1
> -#define TAINT_CPU_OUT_OF_SPEC		2
> -#define TAINT_FORCED_RMMOD		3
> -#define TAINT_MACHINE_CHECK		4
> -#define TAINT_BAD_PAGE			5
> -#define TAINT_USER			6
> -#define TAINT_DIE			7
> -#define TAINT_OVERRIDDEN_ACPI_TABLE	8
> -#define TAINT_WARN			9
> -#define TAINT_CRAP			10
> -#define TAINT_FIRMWARE_WORKAROUND	11
> -#define TAINT_OOT_MODULE		12
> -#define TAINT_UNSIGNED_MODULE		13
> -#define TAINT_SOFTLOCKUP		14
> -#define TAINT_LIVEPATCH			15
> -#define TAINT_AUX			16
> -#define TAINT_RANDSTRUCT		17
> -#define TAINT_FLAGS_COUNT		18
> -#define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
> -
> -struct taint_flag {
> -	char c_true;	/* character printed when tainted */
> -	char c_false;	/* character printed when not tainted */
> -	bool module;	/* also show as a per-module taint flag */
> -};
> -
> -extern const struct taint_flag taint_flags[TAINT_FLAGS_COUNT];
> -
>  extern const char hex_asc[];
>  #define hex_asc_lo(x)	hex_asc[((x) & 0x0f)]
>  #define hex_asc_hi(x)	hex_asc[((x) & 0xf0) >> 4]
> diff --git a/include/linux/panic.h b/include/linux/panic.h
> new file mode 100644
> index 000000000000..f5844908a089
> --- /dev/null
> +++ b/include/linux/panic.h
> @@ -0,0 +1,98 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_PANIC_H
> +#define _LINUX_PANIC_H
> +
> +#include <linux/compiler_attributes.h>
> +#include <linux/types.h>
> +
> +struct pt_regs;
> +
> +extern long (*panic_blink)(int state);
> +__printf(1, 2)
> +void panic(const char *fmt, ...) __noreturn __cold;
> +void nmi_panic(struct pt_regs *regs, const char *msg);
> +extern void oops_enter(void);
> +extern void oops_exit(void);
> +extern bool oops_may_print(void);
> +
> +#ifdef CONFIG_SMP
> +extern unsigned int sysctl_oops_all_cpu_backtrace;
> +#else
> +#define sysctl_oops_all_cpu_backtrace 0
> +#endif /* CONFIG_SMP */
> +
> +extern int panic_timeout;
> +extern unsigned long panic_print;
> +extern int panic_on_oops;
> +extern int panic_on_unrecovered_nmi;
> +extern int panic_on_io_nmi;
> +extern int panic_on_warn;
> +
> +extern unsigned long panic_on_taint;
> +extern bool panic_on_taint_nousertaint;
> +
> +extern int sysctl_panic_on_rcu_stall;
> +extern int sysctl_max_rcu_stall_to_panic;
> +extern int sysctl_panic_on_stackoverflow;
> +
> +extern bool crash_kexec_post_notifiers;
> +
> +/*
> + * panic_cpu is used for synchronizing panic() and crash_kexec() execution. It
> + * holds a CPU number which is executing panic() currently. A value of
> + * PANIC_CPU_INVALID means no CPU has entered panic() or crash_kexec().
> + */
> +extern atomic_t panic_cpu;
> +#define PANIC_CPU_INVALID	-1
> +
> +/*
> + * Only to be used by arch init code. If the user over-wrote the default
> + * CONFIG_PANIC_TIMEOUT, honor it.
> + */
> +static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
> +{
> +	if (panic_timeout == arch_default_timeout)
> +		panic_timeout = timeout;
> +}
> +
> +/* This cannot be an enum because some may be used in assembly source. */
> +#define TAINT_PROPRIETARY_MODULE	0
> +#define TAINT_FORCED_MODULE		1
> +#define TAINT_CPU_OUT_OF_SPEC		2
> +#define TAINT_FORCED_RMMOD		3
> +#define TAINT_MACHINE_CHECK		4
> +#define TAINT_BAD_PAGE			5
> +#define TAINT_USER			6
> +#define TAINT_DIE			7
> +#define TAINT_OVERRIDDEN_ACPI_TABLE	8
> +#define TAINT_WARN			9
> +#define TAINT_CRAP			10
> +#define TAINT_FIRMWARE_WORKAROUND	11
> +#define TAINT_OOT_MODULE		12
> +#define TAINT_UNSIGNED_MODULE		13
> +#define TAINT_SOFTLOCKUP		14
> +#define TAINT_LIVEPATCH			15
> +#define TAINT_AUX			16
> +#define TAINT_RANDSTRUCT		17
> +#define TAINT_FLAGS_COUNT		18
> +#define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
> +
> +struct taint_flag {
> +	char c_true;	/* character printed when tainted */
> +	char c_false;	/* character printed when not tainted */
> +	bool module;	/* also show as a per-module taint flag */
> +};
> +
> +extern const struct taint_flag taint_flags[TAINT_FLAGS_COUNT];
> +
> +enum lockdep_ok {
> +	LOCKDEP_STILL_OK,
> +	LOCKDEP_NOW_UNRELIABLE,
> +};
> +
> +extern const char *print_tainted(void);
> +extern void add_taint(unsigned flag, enum lockdep_ok);
> +extern int test_taint(unsigned flag);
> +extern unsigned long get_taint(void);
> +
> +#endif	/* _LINUX_PANIC_H */
> diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
> new file mode 100644
> index 000000000000..41e32483d7a7
> --- /dev/null
> +++ b/include/linux/panic_notifier.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_PANIC_NOTIFIERS_H
> +#define _LINUX_PANIC_NOTIFIERS_H
> +
> +#include <linux/notifier.h>
> +#include <linux/types.h>
> +
> +extern struct atomic_notifier_head panic_notifier_list;
> +
> +extern bool crash_kexec_post_notifiers;
> +
> +#endif	/* _LINUX_PANIC_NOTIFIERS_H */
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index bb2e3e15c84c..2871076e4d29 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -15,6 +15,7 @@
>  #include <linux/kthread.h>
>  #include <linux/lockdep.h>
>  #include <linux/export.h>
> +#include <linux/panic_notifier.h>
>  #include <linux/sysctl.h>
>  #include <linux/suspend.h>
>  #include <linux/utsname.h>
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index f099baee3578..4b34a9aa32bc 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -26,6 +26,7 @@
>  #include <linux/suspend.h>
>  #include <linux/device.h>
>  #include <linux/freezer.h>
> +#include <linux/panic_notifier.h>
>  #include <linux/pm.h>
>  #include <linux/cpu.h>
>  #include <linux/uaccess.h>
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 332736a72a58..edad89660a2b 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -23,6 +23,7 @@
>  #include <linux/reboot.h>
>  #include <linux/delay.h>
>  #include <linux/kexec.h>
> +#include <linux/panic_notifier.h>
>  #include <linux/sched.h>
>  #include <linux/sysrq.h>
>  #include <linux/init.h>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index ce5b4cd6bd18..a58c9c86fa13 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -32,6 +32,8 @@
>  #include <linux/export.h>
>  #include <linux/completion.h>
>  #include <linux/moduleparam.h>
> +#include <linux/panic.h>
> +#include <linux/panic_notifier.h>
>  #include <linux/percpu.h>
>  #include <linux/notifier.h>
>  #include <linux/cpu.h>
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 3601786ddaeb..e5cf9c4ef5e1 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -27,6 +27,7 @@
>  #include <linux/sysctl.h>
>  #include <linux/bitmap.h>
>  #include <linux/signal.h>
> +#include <linux/panic.h>
>  #include <linux/printk.h>
>  #include <linux/proc_fs.h>
>  #include <linux/security.h>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 507a30bf26e4..9612a1d8fa13 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -39,6 +39,7 @@
>  #include <linux/slab.h>
>  #include <linux/ctype.h>
>  #include <linux/init.h>
> +#include <linux/panic_notifier.h>
>  #include <linux/poll.h>
>  #include <linux/nmi.h>
>  #include <linux/fs.h>
> -- 
> 2.30.2
> 
