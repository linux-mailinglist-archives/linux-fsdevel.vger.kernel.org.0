Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8140D1A0A96
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 11:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgDGJ6F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 05:58:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:33864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbgDGJ6F (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 05:58:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 51A19AC44;
        Tue,  7 Apr 2020 09:58:01 +0000 (UTC)
Date:   Tue, 7 Apr 2020 11:57:58 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nayna Jain <nayna@linux.ibm.com>,
        Eric Richter <erichte@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Michael Neuling <mikey@neuling.org>,
        Gustavo Luiz Duarte <gustavold@linux.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v12 5/8] powerpc/64: make buildable without CONFIG_COMPAT
Message-ID: <20200407095758.GF25468@kitsune.suse.cz>
References: <20200225173541.1549955-1-npiggin@gmail.com>
 <cover.1584699455.git.msuchanek@suse.de>
 <e5619617020ef3a1f54f0c076e7d74cb9ec9f3bf.1584699455.git.msuchanek@suse.de>
 <b420b304-05e9-df58-7149-31169b0b01e2@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b420b304-05e9-df58-7149-31169b0b01e2@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 07, 2020 at 07:50:30AM +0200, Christophe Leroy wrote:
> 
> 
> Le 20/03/2020 à 11:20, Michal Suchanek a écrit :
> > There are numerous references to 32bit functions in generic and 64bit
> > code so ifdef them out.
> > 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> > v2:
> > - fix 32bit ifdef condition in signal.c
> > - simplify the compat ifdef condition in vdso.c - 64bit is redundant
> > - simplify the compat ifdef condition in callchain.c - 64bit is redundant
> > v3:
> > - use IS_ENABLED and maybe_unused where possible
> > - do not ifdef declarations
> > - clean up Makefile
> > v4:
> > - further makefile cleanup
> > - simplify is_32bit_task conditions
> > - avoid ifdef in condition by using return
> > v5:
> > - avoid unreachable code on 32bit
> > - make is_current_64bit constant on !COMPAT
> > - add stub perf_callchain_user_32 to avoid some ifdefs
> > v6:
> > - consolidate current_is_64bit
> > v7:
> > - remove leftover perf_callchain_user_32 stub from previous series version
> > v8:
> > - fix build again - too trigger-happy with stub removal
> > - remove a vdso.c hunk that causes warning according to kbuild test robot
> > v9:
> > - removed current_is_64bit in previous patch
> > v10:
> > - rebase on top of 70ed86f4de5bd
> > ---
> >   arch/powerpc/include/asm/thread_info.h | 4 ++--
> >   arch/powerpc/kernel/Makefile           | 6 +++---
> >   arch/powerpc/kernel/entry_64.S         | 2 ++
> >   arch/powerpc/kernel/signal.c           | 3 +--
> >   arch/powerpc/kernel/syscall_64.c       | 6 ++----
> >   arch/powerpc/kernel/vdso.c             | 3 ++-
> >   arch/powerpc/perf/callchain.c          | 8 +++++++-
> >   7 files changed, 19 insertions(+), 13 deletions(-)
> > 
> 
> [...]
> 
> > diff --git a/arch/powerpc/kernel/syscall_64.c b/arch/powerpc/kernel/syscall_64.c
> > index 87d95b455b83..2dcbfe38f5ac 100644
> > --- a/arch/powerpc/kernel/syscall_64.c
> > +++ b/arch/powerpc/kernel/syscall_64.c
> > @@ -24,7 +24,6 @@ notrace long system_call_exception(long r3, long r4, long r5,
> >   				   long r6, long r7, long r8,
> >   				   unsigned long r0, struct pt_regs *regs)
> >   {
> > -	unsigned long ti_flags;
> >   	syscall_fn f;
> >   	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
> > @@ -68,8 +67,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
> >   	local_irq_enable();
> > -	ti_flags = current_thread_info()->flags;
> > -	if (unlikely(ti_flags & _TIF_SYSCALL_DOTRACE)) {
> > +	if (unlikely(current_thread_info()->flags & _TIF_SYSCALL_DOTRACE)) {
> >   		/*
> >   		 * We use the return value of do_syscall_trace_enter() as the
> >   		 * syscall number. If the syscall was rejected for any reason
> > @@ -94,7 +92,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
> >   	/* May be faster to do array_index_nospec? */
> >   	barrier_nospec();
> > -	if (unlikely(ti_flags & _TIF_32BIT)) {
> > +	if (unlikely(is_32bit_task())) {
> 
> is_compat() should be used here instead, because we dont want to use
is_compat_task()
> compat_sys_call_table() on PPC32.
> 
> >   		f = (void *)compat_sys_call_table[r0];
> >   		r3 &= 0x00000000ffffffffULL;
> 
That only applies once you use this for 32bit as well. Right now it's
64bit only so the two are the same.

Thanks

Michal
