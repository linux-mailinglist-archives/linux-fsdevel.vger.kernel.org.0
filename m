Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F928A04FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 16:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfH1O3z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 10:29:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:49752 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726428AbfH1O3z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:29:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4D8E1B620;
        Wed, 28 Aug 2019 14:29:51 +0000 (UTC)
Date:   Wed, 28 Aug 2019 16:29:45 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Breno Leitao <leitao@debian.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Allison Randal <allison@lohutok.net>,
        Michael Neuling <mikey@neuling.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] powerpc/64: make buildable without CONFIG_COMPAT
Message-ID: <20190828162945.50b86232@naga>
In-Reply-To: <fb471a46-5598-1c5c-911f-499b1aad259c@c-s.fr>
References: <cover.1566987936.git.msuchanek@suse.de>
        <fbf3f09d2f01e53aceea448ac42578251f424829.1566987936.git.msuchanek@suse.de>
        <fb471a46-5598-1c5c-911f-499b1aad259c@c-s.fr>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 28 Aug 2019 14:49:16 +0200
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> Le 28/08/2019 à 12:30, Michal Suchanek a écrit :
> > There are numerous references to 32bit functions in generic and 64bit
> > code so ifdef them out.  
> 
> As far as possible, avoid opting things out with ifdefs. Ref 
> https://www.kernel.org/doc/html/latest/process/coding-style.html#conditional-compilation
> 
> See comment below.
> 
> > 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> > v2:
> > - fix 32bit ifdef condition in signal.c
> > - simplify the compat ifdef condition in vdso.c - 64bit is redundant
> > - simplify the compat ifdef condition in callchain.c - 64bit is redundant
> > ---
> >   arch/powerpc/include/asm/syscall.h |  2 ++
> >   arch/powerpc/kernel/Makefile       | 15 ++++++++++++---
> >   arch/powerpc/kernel/entry_64.S     |  2 ++
> >   arch/powerpc/kernel/signal.c       |  5 +++--
> >   arch/powerpc/kernel/syscall_64.c   |  5 +++--
> >   arch/powerpc/kernel/vdso.c         |  4 +++-
> >   arch/powerpc/perf/callchain.c      | 14 ++++++++++----
> >   7 files changed, 35 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> > index 38d62acfdce7..3ed3b75541a1 100644
> > --- a/arch/powerpc/include/asm/syscall.h
> > +++ b/arch/powerpc/include/asm/syscall.h
> > @@ -16,7 +16,9 @@
> >   
> >   /* ftrace syscalls requires exporting the sys_call_table */
> >   extern const unsigned long sys_call_table[];
> > +#ifdef CONFIG_COMPAT
> >   extern const unsigned long compat_sys_call_table[];
> > +#endif  
> 
> Leaving the declaration should be harmless.

Yes, it only allows earlier check that the type is not used.

> 
> >   
> >   static inline int syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
> >   {
> > diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> > index 1d646a94d96c..b0db365b83d8 100644
> > --- a/arch/powerpc/kernel/Makefile
> > +++ b/arch/powerpc/kernel/Makefile
> > @@ -44,16 +44,25 @@ CFLAGS_btext.o += -DDISABLE_BRANCH_PROFILING
> >   endif
> >   
> >   obj-y				:= cputable.o ptrace.o syscalls.o \
> > -				   irq.o align.o signal_32.o pmc.o vdso.o \
> > +				   irq.o align.o pmc.o vdso.o \
> >   				   process.o systbl.o idle.o \
> >   				   signal.o sysfs.o cacheinfo.o time.o \
> >   				   prom.o traps.o setup-common.o \
> >   				   udbg.o misc.o io.o misc_$(BITS).o \
> >   				   of_platform.o prom_parse.o
> > -obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
> > -				   signal_64.o ptrace32.o \
> > +ifndef CONFIG_PPC64
> > +obj-y				+= signal_32.o
> > +else
> > +ifdef CONFIG_COMPAT
> > +obj-y				+= signal_32.o
> > +endif
> > +endif
> > +obj-$(CONFIG_PPC64)		+= setup_64.o signal_64.o \
> >   				   paca.o nvram_64.o firmware.o \
> >   				   syscall_64.o  
> 
> That's still a bit messy. You could have:
> 
> obj-y = +=signal_$(BITS).o
> obj-$(CONFIG_COMPAT) += signal_32.o
> 
> > +ifdef CONFIG_COMPAT
> > +obj-$(CONFIG_PPC64)		+= sys_ppc32.o ptrace32.o
> > +endif  
> 
> AFAIK, CONFIG_COMPAT is only defined when CONFIG_PP64 is defined, so 
> could be:
> 
> obj-$(CONFIG_COMPAT)		+= sys_ppc32.o ptrace32.o
> 
> And could be grouped with the above signal_32.o
> 

Looks better.

> 
> >   obj-$(CONFIG_VDSO32)		+= vdso32/
> >   obj-$(CONFIG_PPC_WATCHDOG)	+= watchdog.o
> >   obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
> > diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> > index 2ec825a85f5b..a2dbf216f607 100644
> > --- a/arch/powerpc/kernel/entry_64.S
> > +++ b/arch/powerpc/kernel/entry_64.S
> > @@ -51,8 +51,10 @@
> >   SYS_CALL_TABLE:
> >   	.tc sys_call_table[TC],sys_call_table
> >   
> > +#ifdef CONFIG_COMPAT
> >   COMPAT_SYS_CALL_TABLE:
> >   	.tc compat_sys_call_table[TC],compat_sys_call_table
> > +#endif  
> 
> Can we avoid this ifdef ?

AFAICT it creates reference to non-existent table otherwise.

> 
> >   
> >   /* This value is used to mark exception frames on the stack. */
> >   exception_marker:
> > diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
> > index 60436432399f..ffd045e9fb57 100644
> > --- a/arch/powerpc/kernel/signal.c
> > +++ b/arch/powerpc/kernel/signal.c
> > @@ -277,14 +277,15 @@ static void do_signal(struct task_struct *tsk)
> >   
> >   	rseq_signal_deliver(&ksig, tsk->thread.regs);
> >   
> > +#if !defined(CONFIG_PPC64) || defined(CONFIG_COMPAT)
> >   	if (is32) {
> >           	if (ksig.ka.sa.sa_flags & SA_SIGINFO)
> >   			ret = handle_rt_signal32(&ksig, oldset, tsk);
> >   		else
> >   			ret = handle_signal32(&ksig, oldset, tsk);
> > -	} else {
> > +	} else  
> 
> " if only one branch of a conditional statement is a single statement 
> [...] use braces in both branches"
> 
> Ref 
> https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-braces-and-spaces
> 
> > +#endif /* 32bit */  
> 
> Having an #ifdef in a middle of a if/else is gross.
> 
> Check what are the possible values for is32. It will be always true 
> which CONFIG_PPC32.
> If you can make sure it is always false without CONFIG_COMPAT, you are 
> done. If not, then combine the if(is32) with something involving 
> IS_ENABLED(CONFIG_COMPAT).

The value of is32 is not a problem. References to non-existent
functions could be.

...

> > diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
> > index c84bbd4298a0..b3dacc8bc98d 100644
> > --- a/arch/powerpc/perf/callchain.c
> > +++ b/arch/powerpc/perf/callchain.c
> > @@ -15,7 +15,7 @@
> >   #include <asm/sigcontext.h>
> >   #include <asm/ucontext.h>
> >   #include <asm/vdso.h>
> > -#ifdef CONFIG_PPC64
> > +#ifdef CONFIG_COMPAT
> >   #include "../kernel/ppc32.h"

/srv/kernel/arch/powerpc/perf/../kernel/ppc32.h:50:2: error: unknown type name ‘compat_stack_t’

When required declarations are ifdefed in compat.h

> >   
> >   static inline int valid_user_sp(unsigned long sp, int is_64)
> >   {
> > @@ -341,6 +343,7 @@ static inline int valid_user_sp(unsigned long sp, int is_64)
> >   
> >   #endif /* CONFIG_PPC64 */
> >   
> > +#if !defined(CONFIG_PPC64) || defined(CONFIG_COMPAT)  
> 
> You don't need to opt that out.

You need to opt out here:

/srv/kernel/arch/powerpc/perf/callchain.c:349:22: error: field ‘sctx’ has incomplete type
  struct sigcontext32 sctx;
/srv/kernel/arch/powerpc/perf/callchain.c:359:2: error: unknown type name ‘compat_siginfo_t’
  compat_siginfo_t info;
...
> 
> >   /*
> >    * Layout for non-RT signal frames
> >    */
> > @@ -482,12 +485,15 @@ static void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
> >   		sp = next_sp;
> >   	}
> >   }
> > +#endif /* 32bit */
> >   
> >   void
> >   perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
> >   {
> > -	if (current_is_64bit())
> > -		perf_callchain_user_64(entry, regs);
> > -	else
> > +#if !defined(CONFIG_PPC64) || defined(CONFIG_COMPAT)
> > +	if (!current_is_64bit())
> >   		perf_callchain_user_32(entry, regs);
> > +	else
> > +#endif
> > +		perf_callchain_user_64(entry, regs);  
> 
> Please rewrite using  IS_ENABLED() instead of #ifdefs.

And ifdef here.

The ifdefs could be potentially reduced in some places, though.

Thanks

Michal
