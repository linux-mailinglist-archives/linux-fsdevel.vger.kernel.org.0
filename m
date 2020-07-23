Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903EE22B93B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 00:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgGWWOb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jul 2020 18:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgGWWOb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jul 2020 18:14:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC07C0619D3;
        Thu, 23 Jul 2020 15:14:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595542468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JmyzjmH8/olb4mM6hh3RrBawdAZ1ohRuT2f6HKf6J84=;
        b=V5Z5Rq1nk71rXzhuUOz5ybYySxFdqFcH8dpWSElBd5qV0W8MCoBko+38RNWOwqWv2ju5Ig
        bQIZTjLoRGXb0gRm8ytYEZ+t/kr7TRL00g3qwWdo76SMcfJ4GqUmx1vL6JGaDTvO7FZH+R
        ehWAUFsqGo/fbWIHtNHboBF7FH01EARrdMRiueauNFcaZcnEvopvmfNUwCfpZJv1T5dDwT
        im0DmUgWCCRiLQJaa9slhiO8uBTVN7eOzTJKLsyQvSGFvkDS9iSTv6B55CVKQYzX50pMS/
        92w4HmCS53+4wG2ZzwtaOhcrmTM/WnQ4LlDs75AQoLaiaAd4mZmRHbv65Gb2eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595542468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JmyzjmH8/olb4mM6hh3RrBawdAZ1ohRuT2f6HKf6J84=;
        b=DpE/SglP+UbEOY+9bcINMPHA9y7J8tMcjgmZMJCa1/pPbw5ifZwHGpOKKPr+c+G54aYYVK
        9inwqDxRJmQ+XGDQ==
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Weiny Ira <ira.weiny@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list\:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across exceptions
In-Reply-To: <CALCETrUdxpVP3dZgsZBpCODxW8yaiHguxTu=aHg_AkRbs91dWg@mail.gmail.com>
References: <20200723165204.GB77434@romley-ivt3.sc.intel.com> <C03DA782-BD1A-42E3-B118-ABB34BC5F2AF@amacapital.net> <87imeevv6b.fsf@nanos.tec.linutronix.de> <CALCETrUdxpVP3dZgsZBpCODxW8yaiHguxTu=aHg_AkRbs91dWg@mail.gmail.com>
Date:   Fri, 24 Jul 2020 00:14:28 +0200
Message-ID: <874kpxx4jf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:
>> On Jul 23, 2020, at 1:22 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> =EF=BB=BFAndy Lutomirski <luto@amacapital.net> writes:
>>> My suggestion is to enlarge pt_regs.  The save and restore logic can
>>> probably be in C, but pt_regs is the logical place to put a register
>>> that is saved and restored across all entries.
>>
>> Kinda, but that still sucks because schedule from #PF will get it wrong
>> unless you do extra nasties.
>
> This seems like we=E2=80=99re reinventing the wheel.  PKRS is not
> fundamentally different from, say, RSP.  If we want to save it across
> exceptions, we save it on entry and context-switch-out and restore it
> on exit and context-switch-in.

It's fundamentally different from RSP because it has state (refcount)
attached, which RSP clearly has not. If you get rid of the state then
yes.

>>> Whoever does this work will have the delightful job of figuring out
>>> whether BPF thinks that the layout of pt_regs is ABI and, if so,
>>> fixing the resulting mess.
>>>
>>> The fact the new fields will go at the beginning of pt_regs will make
>>> this an entertaining prospect.
>>
>> Good luck with all of that.
>
> We can always cheat like this:
>
> struct real_pt_regs {
>   unsigned long pkrs;
>   struct pt_regs regs;
> };
>
> and pass a pointer to regs around.  What BPF doesn't know about can't hur=
t it.

Yes, but that's the easy part of the problem :)

Thanks,

        tglx
