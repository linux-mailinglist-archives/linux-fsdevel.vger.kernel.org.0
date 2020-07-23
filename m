Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B975822B78B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jul 2020 22:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgGWUWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jul 2020 16:22:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32790 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgGWUWH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:22:07 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595535725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xUfejVCnGJSFUxx4AbkzbVJFCZGcWbz/N8REfPWxQoU=;
        b=3w6pydta60AUDlW71ctlUmfCuxjZwrDBjdn+FnMylpeeRNx3lZdxfaaRT4irOoFTC9CUuh
        PXbbNu0NFQnT2ebz/rTRFFus4A56eVJaHT1Nku6xPVzKWr5/EfpxjeqXE2M8OHYK60mpNZ
        G/1vehBDzGDMsOv9JDLd9t0ZwgJq18uO4GXkwYlXX/XavlQ/d8MeiixW8yeG71ll4tXpXy
        OSNidJ+vtacBscsslNQRCmpPO3hM5Ayd5CFQN/LEVQ+5TWmlgprge1xI1euwEayu59G88G
        Yr4RymiC2f4ktP3jTZXWmeO9OG2t4cANxrJrr3YILRR0osb7reG9Ymiqqc1/bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595535725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xUfejVCnGJSFUxx4AbkzbVJFCZGcWbz/N8REfPWxQoU=;
        b=S6pO3lE+IfHj3HhkeQ26FcQansBJxu9GNSfmIP0x4haRe07iB3E2Ls0tYUMfsjoVnW9XRq
        EEpNr2bboZIhELDQ==
To:     Andy Lutomirski <luto@amacapital.net>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
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
In-Reply-To: <C03DA782-BD1A-42E3-B118-ABB34BC5F2AF@amacapital.net>
References: <20200723165204.GB77434@romley-ivt3.sc.intel.com> <C03DA782-BD1A-42E3-B118-ABB34BC5F2AF@amacapital.net>
Date:   Thu, 23 Jul 2020 22:22:04 +0200
Message-ID: <87imeevv6b.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andy Lutomirski <luto@amacapital.net> writes:

> Suppose some kernel code (a syscall or kernel thread) changes PKRS
> then takes a page fault. The page fault handler needs a fresh
> PKRS. Then the page fault handler (say a VMA=E2=80=99s .fault handler) ch=
anges
> PKRS.  The we get an interrupt. The interrupt *also* needs a fresh
> PKRS and the page fault value needs to be saved somewhere.
>
> So we have more than one saved value per thread, and thread_struct
> isn=E2=80=99t going to solve this problem.

A stack of 7 entries and an index needs 32bytes total which is a
reasonable amount and solves the problem including scheduling from #PF
nicely. Make it 15 and it's still only 64 bytes.

> But idtentry_state is also not great for a couple reasons.  Not all
> entries have idtentry_state, and the unwinder can=E2=80=99t find it for
> debugging. For that matter, the page fault logic probably wants to
> know the previous PKRS, so it should either be stashed somewhere
> findable or it should be explicitly passed around.
>
> My suggestion is to enlarge pt_regs.  The save and restore logic can
> probably be in C, but pt_regs is the logical place to put a register
> that is saved and restored across all entries.

Kinda, but that still sucks because schedule from #PF will get it wrong
unless you do extra nasties.

> Whoever does this work will have the delightful job of figuring out
> whether BPF thinks that the layout of pt_regs is ABI and, if so,
> fixing the resulting mess.
>
> The fact the new fields will go at the beginning of pt_regs will make
> this an entertaining prospect.

Good luck with all of that.

Thanks,

        tglx
