Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51D5B18F467
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 13:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgCWMVu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 08:21:50 -0400
Received: from foss.arm.com ([217.140.110.172]:48184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727531AbgCWMVu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:21:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1DCC1FB;
        Mon, 23 Mar 2020 05:21:49 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AFEC3F52E;
        Mon, 23 Mar 2020 05:21:46 -0700 (PDT)
Date:   Mon, 23 Mar 2020 12:21:44 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        "H . J . Lu " <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        nd@arm.com
Subject: Re: [PATCH v10 00/13] arm64: Branch Target Identification support
Message-ID: <20200323122143.GB4892@mbp>
References: <20200316165055.31179-1-broonie@kernel.org>
 <20200320173945.GC27072@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320173945.GC27072@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 20, 2020 at 05:39:46PM +0000, Szabolcs Nagy wrote:
> The 03/16/2020 16:50, Mark Brown wrote:
> > This patch series implements support for ARMv8.5-A Branch Target
> > Identification (BTI), which is a control flow integrity protection
> > feature introduced as part of the ARMv8.5-A extensions.
> 
> i was playing with this and it seems the kernel does not add
> PROT_BTI to non-static executables (i.e. there is an interpreter).
> 
> i thought any elf that the kernel maps would get PROT_BTI from the
> kernel. (i want to remove the mprotect in glibc when not necessary)

I haven't followed the early discussions but I think this makes sense.

> i tested by linking a hello world exe with -Wl,-z,force-bti (and
> verified that the property note is there) and expected it to crash
> (with SIGILL) when the dynamic linker jumps to _start in the exe,
> but it executed without errors (if i do the mprotect in glibc then
> i get SIGILL as expected).
> 
> is this deliberate? does the kernel map static exe and dynamic
> linked exe differently?

I think the logic is in patch 5:

+int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
+                        bool has_interp, bool is_interp)
+{
+       if (is_interp != has_interp)
+               return prot;
+
+       if (!(state->flags & ARM64_ELF_BTI))
+               return prot;
+
+       if (prot & PROT_EXEC)
+               prot |= PROT_BTI;
+
+       return prot;
+}

At a quick look, for dynamic binaries we have has_interp == true and
is_interp == false. I don't know why but, either way, the above code
needs a comment with some justification.

-- 
Catalin
