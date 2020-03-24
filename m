Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C44271919E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 20:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgCXTbF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 15:31:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:41112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgCXTbF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 15:31:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CAA31AAB8;
        Tue, 24 Mar 2020 19:31:00 +0000 (UTC)
Date:   Tue, 24 Mar 2020 20:30:55 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, Mark Rutland <mark.rutland@arm.com>,
        Gustavo Luiz Duarte <gustavold@linux.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Jiri Olsa <jolsa@redhat.com>, Rob Herring <robh@kernel.org>,
        Michael Neuling <mikey@neuling.org>,
        Eric Richter <erichte@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v11 5/8] powerpc/64: make buildable without CONFIG_COMPAT
Message-ID: <20200324193055.GG25468@kitsune.suse.cz>
References: <20200225173541.1549955-1-npiggin@gmail.com>
 <cover.1584620202.git.msuchanek@suse.de>
 <4b7058eb0f5558fb7e2cee1b8f7cf99ebd03084e.1584620202.git.msuchanek@suse.de>
 <1585039733.dm1rivvych.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585039733.dm1rivvych.astroid@bobo.none>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 24, 2020 at 06:54:20PM +1000, Nicholas Piggin wrote:
> Michal Suchanek's on March 19, 2020 10:19 pm:
> > diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
> > index 4b0152108f61..a264989626fd 100644
> > --- a/arch/powerpc/kernel/signal.c
> > +++ b/arch/powerpc/kernel/signal.c
> > @@ -247,7 +247,6 @@ static void do_signal(struct task_struct *tsk)
> >  	sigset_t *oldset = sigmask_to_save();
> >  	struct ksignal ksig = { .sig = 0 };
> >  	int ret;
> > -	int is32 = is_32bit_task();
> >  
> >  	BUG_ON(tsk != current);
> >  
> > @@ -277,7 +276,7 @@ static void do_signal(struct task_struct *tsk)
> >  
> >  	rseq_signal_deliver(&ksig, tsk->thread.regs);
> >  
> > -	if (is32) {
> > +	if (is_32bit_task()) {
> >          	if (ksig.ka.sa.sa_flags & SA_SIGINFO)
> >  			ret = handle_rt_signal32(&ksig, oldset, tsk);
> >  		else
> 
> Unnecessary?
> 
> > diff --git a/arch/powerpc/kernel/syscall_64.c b/arch/powerpc/kernel/syscall_64.c
> > index 87d95b455b83..2dcbfe38f5ac 100644
> > --- a/arch/powerpc/kernel/syscall_64.c
> > +++ b/arch/powerpc/kernel/syscall_64.c
> > @@ -24,7 +24,6 @@ notrace long system_call_exception(long r3, long r4, long r5,
> >  				   long r6, long r7, long r8,
> >  				   unsigned long r0, struct pt_regs *regs)
> >  {
> > -	unsigned long ti_flags;
> >  	syscall_fn f;
> >  
> >  	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
> > @@ -68,8 +67,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
> >  
> >  	local_irq_enable();
> >  
> > -	ti_flags = current_thread_info()->flags;
> > -	if (unlikely(ti_flags & _TIF_SYSCALL_DOTRACE)) {
> > +	if (unlikely(current_thread_info()->flags & _TIF_SYSCALL_DOTRACE)) {
> >  		/*
> >  		 * We use the return value of do_syscall_trace_enter() as the
> >  		 * syscall number. If the syscall was rejected for any reason
> > @@ -94,7 +92,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
> >  	/* May be faster to do array_index_nospec? */
> >  	barrier_nospec();
> >  
> > -	if (unlikely(ti_flags & _TIF_32BIT)) {
> > +	if (unlikely(is_32bit_task())) {
> 
> Problem is, does this allow the load of ti_flags to be used for both
> tests, or does test_bit make it re-load?
> 
> This could maybe be fixed by testing if(IS_ENABLED(CONFIG_COMPAT) &&
Both points already discussed here:

https://lore.kernel.org/linuxppc-dev/13fa324dc879a7f325290bf2e131b87eb491cd7b.1573576649.git.msuchanek@suse.de/

Thanks

Michal
