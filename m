Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC688275F78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 20:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgIWSJp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 14:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbgIWSJp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 14:09:45 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80EB9238E5
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2020 18:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600884584;
        bh=0sQpYjrO1FEOUdJEyt75wZRgQiNVOyCLQf75CE6PFHk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oGNukZ1XzS6+01unsngiaWE+87lr66kpPInuBoy/nJdJAwRXJ3MMlxk++8egYoI+l
         uYqjaOFRo6XImKO5Xgc7VG7K8JPLOLjY/WBGg+8qNiErRQvMbi06E9ylJM0RYc2rP3
         xNjnr+21fWQcIlSZqvNMaM83CpvisjcgTDpWjjiw=
Received: by mail-wr1-f54.google.com with SMTP id t10so1065282wrv.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2020 11:09:44 -0700 (PDT)
X-Gm-Message-State: AOAM530Z1xfuv7fZoybeN2SUleRBflNAJXhY8oz0+DHvhzsAOYQNldAz
        HDSXwLj11+l2ldr75udibysDpeQn1+5tZWD0ssJKqg==
X-Google-Smtp-Source: ABdhPJwfMfqd9rmUBSaNu+esX7OO7HDQLQ/5mB6cl8BJqHE3Ip+CBSog/eVQL5KyNSbUahOo8NC7kD0pV+eTdSv397I=
X-Received: by 2002:adf:a3c3:: with SMTP id m3mr947291wrb.70.1600884582830;
 Wed, 23 Sep 2020 11:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200922215326.4603-1-madvenka@linux.microsoft.com>
 <20200923081426.GA30279@amd> <20200923091456.GA6177@openwall.com> <87wo0ko8v0.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87wo0ko8v0.fsf@oldenburg2.str.redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 23 Sep 2020 11:09:29 -0700
X-Gmail-Original-Message-ID: <CALCETrUqct4tDrjTSzJG4+=+cEaaDbZ+Mx=LAUdQjVV=CruUcw@mail.gmail.com>
Message-ID: <CALCETrUqct4tDrjTSzJG4+=+cEaaDbZ+Mx=LAUdQjVV=CruUcw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] [RFC] Implement Trampoline File Descriptor
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Solar Designer <solar@openwall.com>, Pavel Machek <pavel@ucw.cz>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 23, 2020 at 7:39 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Solar Designer:
>
> > While I share my opinion here, I don't mean that to block Madhavan's
> > work.  I'd rather defer to people more knowledgeable in current userland
> > and ABI issues/limitations and plans on dealing with those, especially
> > to Florian Weimer.  I haven't seen Florian say anything specific for or
> > against Madhavan's proposal, and I'd like to.  (Have I missed that?)
>
> There was a previous discussion, where I provided feedback (not much
> different from the feedback here, given that the mechanism is mostly the
> same).
>
> I think it's unnecessary for the libffi use case.  Precompiled code can
> be loaded from disk because the libffi trampolines are so regular.  On
> most architectures, it's not even the code that's patched, but some of
> the data driving it, which happens to be located on the same page due to
> a libffi quirk.
>
> The libffi use case is a bit strange anyway: its trampolines are
> type-generic, and the per-call adjustment is data-driven.  This means
> that once you have libffi in the process, you have a generic
> data-to-function-call mechanism available that can be abused (it's even
> fully CET compatible in recent versions).  And then you need to look at
> the processes that use libffi.  A lot of them contain bytecode
> interpreters, and those enable data-driven arbitrary code execution as
> well.  I know that there are efforts under way to harden Python, but
> it's going to be tough to get to the point where things are still
> difficult for an attacker once they have the ability to make mprotect
> calls.
>
> It was pointed out to me that libffi is doing things wrong, and the
> trampolines should not be type-generic, but generated so that they match
> the function being called.  That is, the marshal/unmarshal code would be
> open-coded in the trampoline, rather than using some generic mechanism
> plus run-time dispatch on data tables describing the function type.
> That is a very different design (and typically used by compilers (JIT or
> not JIT) to implement native calls).  Mapping some code page with a
> repeating pattern would no longer work to defeat anti-JIT measures
> because it's closer to real JIT.  I don't know if kernel support could
> make sense in this context, but it would be a completely different
> patch.

I would very much like to see a well-designed kernel facility for
helping userspace do JIT in a safer manner, but designing such a thing
is likely to be distinctly nontrivial.  To throw a half-backed idea
out there, suppose a program could pre-declare a list of JIT
verifiers:

static bool ffi_trampoline_verifier(void *target_address, size_t
target_size, void *source_data, void *context);

struct jit_verifier {
  .magic = 0xMAGIC_HERE,
  .verifier = ffi_trampoline_verifier,
} my_verifier __attribute((section("something special here?)));

and then a system call something like:

instantiate_jit_code(target, source, size, &my_verifier, context);

The idea being that even an attacker that can force a call to
instantiate_jit_code() can only create code that passes verification
by one of the pre-declared verifiers in the process.
