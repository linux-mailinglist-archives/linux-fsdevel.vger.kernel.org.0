Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F377233A17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 22:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbgG3UyU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 16:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbgG3UyT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 16:54:19 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38F982173E
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2020 20:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596142458;
        bh=kjsUMa7W/2716/E66O9BRcoDTvK1hMoraL3jFZhSbhQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o9dMLI7V7xLay/4FEvc5ZBCLpWIPaCqr6MXAhd3v41abR8skQqLAzbrq08+887reU
         wRySApjBQKeQ5VZq/RrsOM5e6cbno9eOfSVO8kC1+jgM4mvZwzHMUrYvd4E6R5+giP
         WaOsgZjN1HyUHoKP9cFT3MNatWBEDqakktTzyWTE=
Received: by mail-wr1-f45.google.com with SMTP id l2so15564250wrc.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2020 13:54:18 -0700 (PDT)
X-Gm-Message-State: AOAM533VeH3gXfXIyft31Cpovtjpy8+v/gy9Ul8ZpRWRQiSWdeAhnJNo
        t7Gdbt2QgE9vyzvFEIYsMuf+Ddnw3VP74tYhfbI5pg==
X-Google-Smtp-Source: ABdhPJzKLFb8fOLe7ajuISL9Za2Aj4/QcGOi3NXA9PDpcRSYfLFS4b/xrq0MWMJYlHADmhXcVVN9ubUqp0AHIqmO1Bk=
X-Received: by 2002:adf:fa85:: with SMTP id h5mr509001wrr.18.1596142456738;
 Thu, 30 Jul 2020 13:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200728131050.24443-1-madvenka@linux.microsoft.com>
 <CALCETrVy5OMuUx04-wWk9FJbSxkrT2vMfN_kANinudrDwC4Cig@mail.gmail.com> <6540b4b7-3f70-adbf-c922-43886599713a@linux.microsoft.com>
In-Reply-To: <6540b4b7-3f70-adbf-c922-43886599713a@linux.microsoft.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 30 Jul 2020 13:54:03 -0700
X-Gmail-Original-Message-ID: <CALCETrWnNR5v3ZCLfBVQGYK8M0jAvQMaAc9uuO05kfZuh-4d6w@mail.gmail.com>
Message-ID: <CALCETrWnNR5v3ZCLfBVQGYK8M0jAvQMaAc9uuO05kfZuh-4d6w@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 7:24 AM Madhavan T. Venkataraman
<madvenka@linux.microsoft.com> wrote:
>
> Sorry for the delay. I just wanted to think about this a little.
> In this email, I will respond to your first suggestion. I will
> respond to the rest in separate emails if that is alright with
> you.
>
> On 7/28/20 12:31 PM, Andy Lutomirski wrote:
>
> On Jul 28, 2020, at 6:11 AM, madvenka@linux.microsoft.com wrote:
>
> =EF=BB=BFFrom: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
>
> The kernel creates the trampoline mapping without any permissions. When
> the trampoline is executed by user code, a page fault happens and the
> kernel gets control. The kernel recognizes that this is a trampoline
> invocation. It sets up the user registers based on the specified
> register context, and/or pushes values on the user stack based on the
> specified stack context, and sets the user PC to the requested target
> PC. When the kernel returns, execution continues at the target PC.
> So, the kernel does the work of the trampoline on behalf of the
> application.
>
> This is quite clever, but now I=E2=80=99m wondering just how much kernel =
help
> is really needed. In your series, the trampoline is an non-executable
> page.  I can think of at least two alternative approaches, and I'd
> like to know the pros and cons.
>
> 1. Entirely userspace: a return trampoline would be something like:
>
> 1:
> pushq %rax
> pushq %rbc
> pushq %rcx
> ...
> pushq %r15
> movq %rsp, %rdi # pointer to saved regs
> leaq 1b(%rip), %rsi # pointer to the trampoline itself
> callq trampoline_handler # see below
>
> You would fill a page with a bunch of these, possibly compacted to get
> more per page, and then you would remap as many copies as needed.  The
> 'callq trampoline_handler' part would need to be a bit clever to make
> it continue to work despite this remapping.  This will be *much*
> faster than trampfd. How much of your use case would it cover?  For
> the inverse, it's not too hard to write a bit of asm to set all
> registers and jump somewhere.
>
> Let me state what I have understood about this suggestion. Correct me if
> I get anything wrong. If you don't mind, I will also take the liberty
> of generalizing and paraphrasing your suggestion.
>
> The goal is to create two page mappings that are adjacent to each other:
>
> - a code page that contains template code for a trampoline. Since the
>  template code would tend to be small in size, pack as many of them
>  as possible within a page to conserve memory. In other words, create
>  an array of the template code fragments. Each element in the array
>  would be used for one trampoline instance.
>
> - a data page that contains an array of data elements. Corresponding
>  to each code element in the code page, there would be a data element
>  in the data page that would contain data that is specific to a
>  trampoline instance.
>
> - Code will access data using PC-relative addressing.
>
> The management of the code pages and allocation for each trampoline
> instance would all be done in user space.
>
> Is this the general idea?

Yes.

>
> Creating a code page
> --------------------
>
> We can do this in one of the following ways:
>
> - Allocate a writable page at run time, write the template code into
>   the page and have execute permissions on the page.
>
> - Allocate a writable page at run time, write the template code into
>   the page and remap the page with just execute permissions.
>
> - Allocate a writable page at run time, write the template code into
>   the page, write the page into a temporary file and map the file with
>   execute permissions.
>
> - Include the template code in a code page at build time itself and
>   just remap the code page each time you need a code page.

This latter part shouldn't need any special permissions as far as I know.

>
> Pros and Cons
> -------------
>
> As long as the OS provides the functionality to do this and the security
> subsystem in the OS allows the actions, this is totally feasible. If not,
> we need something like trampfd.
>
> As Floren mentioned, libffi does implement something like this for MACH.
>
> In fact, in my libffi changes, I use trampfd only after all the other met=
hods
> have failed because of security settings.
>
> But the above approach only solves the problem for this simple type of
> trampoline. It does not provide a framework for addressing more complex t=
ypes
> or even other forms of dynamic code.
>
> Also, each application would need to implement this solution for itself
> as opposed to relying on one implementation provided by the kernel.

I would argue this is a benefit.  If the whole implementation is in
userspace, there is no ABI compatibility issue.  The user program
contains the trampoline code and the code that uses it.

>
> Trampfd-based solution
> ----------------------
>
> I outlined an enhancement to trampfd in a response to David Laight. In th=
is
> enhancement, the kernel is the one that would set up the code page.
>
> The kernel would call an arch-specific support function to generate the
> code required to load registers, push values on the stack and jump to a P=
C
> for a trampoline instance based on its current context. The trampoline
> instance data could be baked into the code.
>
> My initial idea was to only have one trampoline instance per page. But I
> think I can implement multiple instances per page. I just have to manage
> the trampfd file private data and VMA private data accordingly to map an
> element in a code page to its trampoline object.
>
> The two approaches are similar except for the detail about who sets up
> and manages the trampoline pages. In both approaches, the performance pro=
blem
> is addressed. But trampfd can be used even when security settings are
> restrictive.
>
> Is my solution acceptable?

Perhaps.  In general, before adding a new ABI to the kernel, it's nice
to understand how it's better than doing the same thing in userspace.
Saying that it's easier for user code to work with if it's in the
kernel isn't necessarily an adequate justification.

Why would remapping two pages of actual application text ever fail?
