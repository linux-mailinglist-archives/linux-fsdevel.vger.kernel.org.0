Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEA644EE87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 22:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbhKLV1c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 16:27:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:60568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235714AbhKLV1b (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 16:27:31 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEB196108B;
        Fri, 12 Nov 2021 21:24:35 +0000 (UTC)
Date:   Fri, 12 Nov 2021 16:24:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Maciej Rozycki <macro@orcam.me.uk>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Wei Liu <wl@xen.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Laura Abbott <labbott@kernel.org>,
        David S Miller <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Scull <ascull@google.com>,
        Marc Zyngier <maz@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wang Qing <wangqing@vivo.com>, Mel Gorman <mgorman@suse.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Mathieu Chouquet-Stringer <me@mathieu.digital>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stephen Kitt <steve@sk2.org>, Stephen Boyd <sboyd@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mike Rapoport <rppt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, notify@kernel.org
Subject: Re: [PATCH v2 2/2] sysctl: introduce kernel.pkill_on_warn
Message-ID: <20211112162433.3ebbd7c7@gandalf.local.home>
In-Reply-To: <20211027233215.306111-3-alex.popov@linux.com>
References: <20211027233215.306111-1-alex.popov@linux.com>
        <20211027233215.306111-3-alex.popov@linux.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 28 Oct 2021 02:32:15 +0300
Alexander Popov <alex.popov@linux.com> wrote:

> Signed-off-by: Alexander Popov <alex.popov@linux.com>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 14 +++++++++++++
>  include/asm-generic/bug.h                   | 12 ++++++++---
>  include/linux/panic.h                       |  3 +++
>  kernel/panic.c                              | 22 ++++++++++++++++++++-
>  kernel/sysctl.c                             |  9 +++++++++
>  lib/bug.c                                   |  3 +++
>  6 files changed, 59 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 426162009ce9..5faf395fdf8f 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -921,6 +921,20 @@ lives in) pid namespace. When selecting a pid for a next task on fork
>  kernel tries to allocate a number starting from this one.
>  
>  
> +pkill_on_warn
> +=============
> +
> +Kills all threads in a process that provoked a kernel warning.
> +That allows the kernel to stop the process when the first signs
> +of wrong behavior are detected.
> +
> += =====================================================================
> +0 Allows a process to proceed execution after hitting a kernel warning,
> +  this is the default behavior.
> +1 Kills all threads in a process that provoked a kernel warning.
> += =====================================================================
> +
> +
>  powersave-nap (PPC only)
>  ========================
>  
> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> index 881aeaf5a2d5..959000b5856a 100644
> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h
> @@ -94,8 +94,10 @@ void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
>  #ifndef WARN_ON_ONCE
>  #define WARN_ON_ONCE(condition) ({					\
>  	int __ret_warn_on = !!(condition);				\
> -	if (unlikely(__ret_warn_on))					\
> +	if (unlikely(__ret_warn_on)) {					\
>  		DO_ONCE_LITE(__WARN_printf, TAINT_WARN, NULL);		\
> +		do_pkill_on_warn();					\

Should this be a config option so that those that do not want this do not
need to have the added overhead of a function call embedded at every
WARN*() in their code?

That is, do_pkill_on_warn() should be defined as do { } while (0), and not
add any I$ overhead when compiled out?

> +	}								\
>  	unlikely(__ret_warn_on);					\
>  })
>  #endif
> @@ -151,15 +153,19 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
>  
>  #define WARN_ONCE(condition, format...) ({				\
>  	int __ret_warn_on = !!(condition);				\
> -	if (unlikely(__ret_warn_on))					\
> +	if (unlikely(__ret_warn_on)) {					\
>  		DO_ONCE_LITE(__WARN_printf, TAINT_WARN, format);	\
> +		do_pkill_on_warn();					\
> +	}								\
>  	unlikely(__ret_warn_on);					\
>  })
>  
>  #define WARN_TAINT_ONCE(condition, taint, format...) ({			\
>  	int __ret_warn_on = !!(condition);				\
> -	if (unlikely(__ret_warn_on))					\
> +	if (unlikely(__ret_warn_on)) {					\
>  		DO_ONCE_LITE(__WARN_printf, taint, format);		\
> +		do_pkill_on_warn();					\
> +	}								\
>  	unlikely(__ret_warn_on);					\
>  })
>  
> diff --git a/include/linux/panic.h b/include/linux/panic.h
> index f5844908a089..f79c69279859 100644
> --- a/include/linux/panic.h
> +++ b/include/linux/panic.h
> @@ -27,6 +27,9 @@ extern int panic_on_oops;
>  extern int panic_on_unrecovered_nmi;
>  extern int panic_on_io_nmi;
>  extern int panic_on_warn;
> +extern int pkill_on_warn;
> +
> +extern void do_pkill_on_warn(void);
>  
>  extern unsigned long panic_on_taint;
>  extern bool panic_on_taint_nousertaint;
> diff --git a/kernel/panic.c b/kernel/panic.c
> index cefd7d82366f..1323c9e2630f 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -53,6 +53,7 @@ static int pause_on_oops_flag;
>  static DEFINE_SPINLOCK(pause_on_oops_lock);
>  bool crash_kexec_post_notifiers;
>  int panic_on_warn __read_mostly;
> +int pkill_on_warn __read_mostly;
>  unsigned long panic_on_taint;
>  bool panic_on_taint_nousertaint = false;
>  
> @@ -625,13 +626,16 @@ void warn_slowpath_fmt(const char *file, int line, unsigned taint,
>  	if (!fmt) {
>  		__warn(file, line, __builtin_return_address(0), taint,
>  		       NULL, NULL);
> -		return;
> +		goto out;
>  	}
>  
>  	args.fmt = fmt;
>  	va_start(args.args, fmt);
>  	__warn(file, line, __builtin_return_address(0), taint, NULL, &args);
>  	va_end(args.args);
> +
> +out:
> +	do_pkill_on_warn();
>  }
>  EXPORT_SYMBOL(warn_slowpath_fmt);
>  #else
> @@ -732,3 +736,19 @@ static int __init panic_on_taint_setup(char *s)
>  	return 0;
>  }
>  early_param("panic_on_taint", panic_on_taint_setup);
> +
> +void do_pkill_on_warn(void)
> +{
> +	if (!pkill_on_warn)
> +		return;
> +
> +	if (is_global_init(current))
> +		return;
> +
> +	if (current->flags & PF_KTHREAD)
> +		return;
> +
> +	if (system_state >= SYSTEM_RUNNING)
> +		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, current, PIDTYPE_TGID);

I believe this was mentioned before. I'm not sure how safe it is to call
do_send_sig_info() in random areas of the kernel, as that could possibly
cause a deadlock with the locking that is taken.

Best to use irq_work() and have a irq_work interrupt handle the
do_sig_info, because then you know you are safe to call this. Of course,
then you need some way to pass the task to the handler.

Could do some kind of clever trick, where we add a PF_KILL_ME flag to the
task, and the irq worker just loops over all the tasks kill all those with
it set?


> +}
> +EXPORT_SYMBOL(do_pkill_on_warn);
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 083be6af29d7..7fe6f0aaad2b 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2656,6 +2656,15 @@ static struct ctl_table kern_table[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE,
>  	},
> +		{

extra tab?

-- Steve

> +		.procname	= "pkill_on_warn",
> +		.data		= &pkill_on_warn,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},
>  #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
>  	{
>  		.procname	= "timer_migration",
> diff --git a/lib/bug.c b/lib/bug.c
> index 1a91f01412b8..28cc8a5b2ee0 100644
> --- a/lib/bug.c
> +++ b/lib/bug.c
> @@ -214,6 +214,9 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
>  	bug_type = BUG_TRAP_TYPE_BUG;
>  
>  out:
> +	if (bug_type == BUG_TRAP_TYPE_WARN)
> +		do_pkill_on_warn();
> +
>  	return bug_type;
>  }
>  

