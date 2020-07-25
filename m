Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C17B22D316
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jul 2020 02:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgGYAJP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 20:09:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbgGYAJP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 20:09:15 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3CC42078D
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2020 00:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595635754;
        bh=btOIZU1MW+6PlkkqDJUz7DcCUStR/8qT0xAu53GlQ6s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sxS88DZLD1Ub3RW0YPgyikY7BDShzwcfepCzbZBjkaqBJP77hyvnz9aXpp551L9Pb
         zU2WTGc5yM4bV7AnuKssI6OXXS3oITRb+uD4VVa0gWA1nxKyleZhPlLV48Zgna5QtC
         kYQUX5BdvbpUC+Yv/uFXlOSxeVLIjzbZ7mfuQHwg=
Received: by mail-wm1-f41.google.com with SMTP id 184so9625892wmb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 17:09:13 -0700 (PDT)
X-Gm-Message-State: AOAM533nS17yOT9otJ3FmLJnVF9bXr6pMlQ7s9TTe5Xdx7oY3XE4fZol
        2Oe8IrY0D2JFCA30YE4s2t/y/36QdefrQYE45a4Lhg==
X-Google-Smtp-Source: ABdhPJzODXWRSR4bEqjZdQmjvnAm94COixhWx/ZHwpxi601Bsr0u6vIlMnxzH7evHcvtBmUNUEDn46VTXFtuOAxUs7I=
X-Received: by 2002:a1c:56c3:: with SMTP id k186mr10711218wmb.21.1595635752371;
 Fri, 24 Jul 2020 17:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200717072056.73134-1-ira.weiny@intel.com> <20200717072056.73134-18-ira.weiny@intel.com>
 <87r1t2vwi7.fsf@nanos.tec.linutronix.de> <20200723220435.GI844235@iweiny-DESK2.sc.intel.com>
 <87mu3pvly7.fsf@nanos.tec.linutronix.de> <874kpwtxlh.fsf@nanos.tec.linutronix.de>
In-Reply-To: <874kpwtxlh.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 24 Jul 2020 17:09:00 -0700
X-Gmail-Original-Message-ID: <CALCETrXM1q664Udfq-LnU8SaUxSn-S+FkFRP1M9n3Aav9bjChA@mail.gmail.com>
Message-ID: <CALCETrXM1q664Udfq-LnU8SaUxSn-S+FkFRP1M9n3Aav9bjChA@mail.gmail.com>
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across exceptions
To:     Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 24, 2020 at 2:25 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Ira,
>
> Thomas Gleixner <tglx@linutronix.de> writes:
> > Ira Weiny <ira.weiny@intel.com> writes:
> >> On Thu, Jul 23, 2020 at 09:53:20PM +0200, Thomas Gleixner wrote:
> >> I think, after fixing my code (see below), using idtentry_state could still
> >> work.  If the per-cpu cache and the MSR is updated in idtentry_exit() that
> >> should carry the state to the new cpu, correct?
> >
> > I'm way too tired to think about that now. Will have a look tomorrow
> > with brain awake.
>
> Not that I'm way more awake now, but at least I have the feeling that my
> brain is not completely useless.
>
> Let me summarize what I understood:
>
>   1) A per CPU cache which shadows the current state of the MSR, i.e. the
>      current valid key. You use that to avoid costly MSR writes if the
>      key does not change.
>
>   2) On idtentry you store the key on entry in idtentry_state, clear it
>      in the MSR and shadow state if necessary and restore it on exit.
>
>   3) On context switch out you save the per CPU cache value in the task
>      and on context switch in you restore it from there.
>
> Yes, that works (see below for #2) and sorry for my confusion yesterday
> about storing this in task state.
>
> #2 requires to handle the exceptions which do not go through
> idtentry_enter/exit() seperately, but that's a manageable amount. It's
> the ones which use IDTENTRY_RAW or a variant of it.
>
> #BP, #MC, #NMI, #DB, #DF need extra local storage as all the kernel
> entries for those use nmi_enter()/exit(). So you just can create
> wrappers around those. Somehting like this
>
> static __always_inline idtentry_state_t idtentry_nmi_enter(void)
> {
>         idtentry_state_t state = {};
>
>         nmi_enter();
>         instrumentation_begin();
>         state.key = save_and_clear_key();
>         instrumentation_end();
> }
>
> static __always_inline void idtentry_nmi_exit(idtentry_state_t state)
> {
>         instrumentation_begin();
>         restore_key(state.key);
>         instrumentation_end();
>         nmi_exit();
> }
>
> #UD and #PF are using the raw entry variant as well but still invoke
> idtentry_enter()/exit(). #PF does not need any work. #UD handles
> WARN/BUG without going through idtentry_enter() first, but I don't think
> that's an issue unless a not 0 key would prevent writing to the console
> device. You surely can figure that out.

Putting on my mm maintainer hat for a moment, I really think that we
want oopses to print PKRS along with all the other registers when we
inevitably oops due to a page fault.  And we probably also want it in
the nasty nested case where we get infinite page faults and eventually
double fault.

I'm sure it's *possible* to wire this up if we stick it in
idtentry_state, but it's trivial if we stick it in pt_regs.  I'm okay
with doing the save/restore in C (in fact, I prefer that), but I think
that either the value should be stuck in pt_regs or we should find a
way to teach the unwinder to locate idtentry_state.

And, if we go with idtentry_state, we should make a signature change
to nmi_enter() to also provide idtentry_state or some equivalent
object.

--Andy
