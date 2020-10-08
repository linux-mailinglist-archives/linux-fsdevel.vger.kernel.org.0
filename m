Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FC1287F0B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 01:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbgJHXWv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 19:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730864AbgJHXWu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 19:22:50 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE6AC0613D4
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Oct 2020 16:22:50 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id b142so5809937ybg.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Oct 2020 16:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pfLY6NJMMNBF6tf7lQ1m6FQIX7pTGz4aW6ys+I9FOHQ=;
        b=oCz8NftMVyAUYVB/cnihhjtq4Qb9IYBQ37nbSeEMzmn5jvZOwH7S5seI9m7XxYNVVE
         MCluyGraKb8yKh82/5CgCxXGU6msSNlqp00GtAqLsih/URqyglJxlmsxwAsNA/aGhk23
         pdUosZHgwlnBEZGdePwFVdwv3ZzZ1HbuUQNj0nkpdE/QaVszVmFnJ9PfLe0yXxi4odPh
         0FbEMSb1+/4GC6767e1Z3wwT0/JwJRSCYWXTuT/jKG9GUDhCrmKMCGNygn9Q3DdTO7Me
         tRI+CKHVsa7MoKQPGvcMu7dSi7ZXyaq0xmrpW/27eYJ6qijGo9/sVW0b0kB1/CIG4NiN
         rJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pfLY6NJMMNBF6tf7lQ1m6FQIX7pTGz4aW6ys+I9FOHQ=;
        b=qnSF0W2ezOpPEnNX1yR+VF6Y7DrlHdh54ZjYvn3+YdoyAWFWbRkbydy88tNchdHASP
         3QNablQhPbbuliexUYrBkMDeLG+vsvlPjjAtqwprwjStXAm97U+xt5IO7B46SkjxUObb
         lLOM1jYUJAvqENjg/iB6c8Fenq4RqJmi1E77aOafZhT1TZEolkXuvJrcA3ZyCfeoKJTC
         Et8FurGSrGqD8Xt/XdaB8ZezAMZmgu4TlMzziMtmp4dmUSLN5QeMfboma9CG2hQ1YZF/
         ZErLrh1c2qM3NwlsDPakN90oVOVLnZwu1elgz7n/aLf98Q5/oRavspty3cO7mAeeLMpg
         tBvg==
X-Gm-Message-State: AOAM531YYmmUplGT2xxIwjS2qQPvcorda0CwXxMTqiQnGsNcA8XgXRur
        aIPan9JC+n17likWLgFISFOlb0haURjFMbfijlnas/QNW+MVzRKp
X-Google-Smtp-Source: ABdhPJyX0CDq9kyDz0XCQILMTz1l28FHrncM4bE4cBxgbXwRky7KKKn9fiX0bYuzzWU8KPrslm5Kx7hkU7X0iX8HRnA=
X-Received: by 2002:a5b:d44:: with SMTP id f4mr13535317ybr.153.1602199368952;
 Thu, 08 Oct 2020 16:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200924065606.3351177-1-lokeshgidra@google.com>
 <CA+EESO7kCqtJf+ApoOcceFT+NX8pBwGmOr0q0PVnJf9Dnkrp6A@mail.gmail.com> <20201008040141.GA17076@redhat.com>
In-Reply-To: <20201008040141.GA17076@redhat.com>
From:   Nick Kralevich <nnk@google.com>
Date:   Thu, 8 Oct 2020 16:22:36 -0700
Message-ID: <CAFJ0LnGoD9NaKhbsohdXo5zt5nyMOX=g1aMRX0b0W1zBSNaSBg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Control over userfaultfd kernel-fault handling
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Lokesh Gidra <lokeshgidra@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, Peter Xu <peterx@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Daniel Colascione <dancol@dancol.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Jerome Glisse <jglisse@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nitin Gupta <nigupta@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 7, 2020 at 9:01 PM Andrea Arcangeli <aarcange@redhat.com> wrote=
:
>
> Hello Lokesh,
>
> On Wed, Oct 07, 2020 at 01:26:55PM -0700, Lokesh Gidra wrote:
> > On Wed, Sep 23, 2020 at 11:56 PM Lokesh Gidra <lokeshgidra@google.com> =
wrote:
> > >
> > > This patch series is split from [1]. The other series enables SELinux
> > > support for userfaultfd file descriptors so that its creation and
> > > movement can be controlled.
> > >
> > > It has been demonstrated on various occasions that suspending kernel
> > > code execution for an arbitrary amount of time at any access to
> > > userspace memory (copy_from_user()/copy_to_user()/...) can be exploit=
ed
> > > to change the intended behavior of the kernel. For instance, handling
> > > page faults in kernel-mode using userfaultfd has been exploited in [2=
, 3].
> > > Likewise, FUSE, which is similar to userfaultfd in this respect, has =
been
> > > exploited in [4, 5] for similar outcome.
> > >
> > > This small patch series adds a new flag to userfaultfd(2) that allows
> > > callers to give up the ability to handle kernel-mode faults with the
> > > resulting UFFD file object. It then adds a 'user-mode only' option to
> > > the unprivileged_userfaultfd sysctl knob to require unprivileged
> > > callers to use this new flag.
> > >
> > > The purpose of this new interface is to decrease the chance of an
> > > unprivileged userfaultfd user taking advantage of userfaultfd to
> > > enhance security vulnerabilities by lengthening the race window in
> > > kernel code.
> > >
> > > [1] https://lore.kernel.org/lkml/20200211225547.235083-1-dancol@googl=
e.com/
> > > [2] https://duasynt.com/blog/linux-kernel-heap-spray
> > > [3] https://duasynt.com/blog/cve-2016-6187-heap-off-by-one-exploit
>
> I've looking at those links and I've been trying to verify the link
> [3] is relevant.
>
> Specifically I've been trying to verify if 1) current state of the art
> modern SLUB randomization techniques already enabled in production and
> rightfully wasting some CPU in all enterprise kernels to prevent
> things like above to become an issue in practice 2) combined with the
> fact different memcg need to share the same kmemcaches (which was
> incidentally fixed a few months ago upstream) and 3) further
> robustness enhancements against exploits in the slub metadata, may
> already render the exploit [3] from 2016 irrelevant in practice.

It's quite possible that some other mitigation was helpful against the
technique used by this particular exploit. It's the nature of exploits
that they are fragile and will change as new soft mitigations are
introduced. The effectiveness of a particular exploit mitigation
change is orthogonal to the change presented here.

The purpose of this change is to prevent an attacker from suspending
kernel code execution and having kernel data structures in a
predictable state. This makes it harder for an attacker to "win" race
conditions against various kernel data structures. This change
compliments other kernel hardening changes such as the changes you've
referenced above. Focusing on one particular exploit somewhat misses
the point of this change.

>
> So I started by trying to reproduce [3] by building 4.5.1 with a
> .config with no robustness features and I booted it on fedora-32 or
> gentoo userland and I cannot even invoke call_usermodehelper. Calling
> socket(22, AF_INET, 0) won't invoke such function. Can you reproduce
> on 4.5.1? Which kernel .config should I use to build 4.5.1 in order
> for call_usermodehelper to be invoked by the exploit? Could you help
> to verify it?

I haven't tried to verify this myself. I wonder if the usermode
hardening changes also impacted this exploit? See
https://lkml.org/lkml/2017/1/16/468

But again, focusing on an exploit, which is inherently fragile in
nature and dependent on the state of the kernel tree at a particular
time, is unlikely to be useful to analyze this patch.

>
> It even has uninitialized variable spawning random perrors so it
> doesn't give a warm fuzzy feeling:
>
> =3D=3D=3D=3D
> int main(int argc, char **argv) {
>         void *region, *map;
>                       ^^^^^
>         pthread_t uffd_thread;
>         int uffd, msqid, i;
>
>         region =3D (void *)mmap((void *)0x40000000, 0x2000, PROT_READ|PRO=
T_WRITE,
>                                MAP_FIXED|MAP_PRIVATE|MAP_ANON, -1, 0);
>
>         if (!region) {
>                 perror("mmap");
>                 exit(2);
>         }
>
>         setup_pagefault(region + 0x1000, 0x1000, 1);
>
>         printf("my pid =3D %d\n", getpid());
>
>         if (!map) {
>         ^^^^^^^^
>                 perror("mmap");
> =3D=3D=3D=3D
>
> The whole point of being able to reproduce on 4.5.1 is then to
> simulate if the same exploit would also reproduce on current kernels
> with all enterprise default robustness features enabled. Or did
> anybody already verify it?
>
> Anyway the links I was playing with are all in the cover letter, the
> cover letter is not as important as the actual patches. The actual
> patches looks fine to me.

That's great to hear.

>
> The only improvement I can think of is, what about to add a
> printk_once to suggest to toggle the sysctl if userfaultfd bails out
> because the process lacks the CAP_SYS_PTRACE capability? That would
> facilitate the /etc/sysctl.conf or tuned tweaking in case the apps
> aren't verbose enough.
>
> It's not relevant anymore with this latest patchset, but about the
> previous argument that seccomp couldn't be used in all Android
> processes because of performance concern, I'm slightly confused.

Seccomp causes more problems than just performance. Seccomp is not
designed for whole-of-system protections. Please see my other writeup
at https://lore.kernel.org/lkml/CAFJ0LnEo-7YUvgOhb4pHteuiUW+wPfzqbwXUCGAA35=
ZMx11A-w@mail.gmail.com/

>
> https://android-developers.googleblog.com/2017/07/seccomp-filter-in-andro=
id-o.html
>
> "Android O includes a single seccomp filter installed into zygote, the
> process from which all the Android applications are derived. Because
> the filter is installed into zygote=E2=80=94and therefore all apps=E2=80=
=94the Android
> security team took extra caution to not break existing apps"
>
> Example:
>
> $ uname -mo
> aarch64 Android
> $ cat swapoff.c
> #include <sys/swap.h>
>
> int main()
> {
>         swapoff("");
> }
> $ gcc swapoff.c -o swapoff -O2
> $ ./swapoff
> Bad system call
> $
>
> It's hard to imagine what is more performance critical than the zygote
> process and the actual apps as above?
>
> It's also hard to imagine what kind of performance concern can arise
> by adding seccomp filters also to background system apps that
> generally should consume ~0% of CPU.
>
> If performance is really a concern, the BPF JIT representation with
> the bitmap to be able to run the filter in O(1) sounds a better
> solution than not adding ad-hoc filters and it's being worked on for
> x86-64 and can be ported to aarch64 too. Many of the standalone
> background processes likely wouldn't even use uffd at all so you could
> block the user initiated faults too that way.
>
> Ultimately because of issues as [3] (be them still relevant or not, to
> be double checked), no matter if through selinux, seccomp or a
> different sysctl value, without this patchset applied the default
> behavior of the userfaultfd syscall for all Linux binaries running on
> Android kernels, would deviate from the upstream kernel. So even if we
> would make the pipe mutex logic more complex the deviation would
> remain. Your patchset adds much less risk of breakage than adding a
> timeout to kernel initiated userfaults and it resolves all concerns as
> well as a timeout. We'll also make better use of the "0" value this
> way. So while I'm not certain this is the best for the long term, this
> looks the sweet spot for the short term to resolve many issues at
> once.
>
> Thanks!
> Andrea
>


--=20
Nick Kralevich | nnk@google.com
