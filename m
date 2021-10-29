Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF4644029F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 20:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhJ2S6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 14:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhJ2S6Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 14:58:16 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5FDC061570
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 11:55:47 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id f3so14660377lfu.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 11:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uGPiPKSphOUEs2fEDAQ1oyHUSr8W7H4wPzT5A6mID2k=;
        b=PwcTyiA+l0irgoS20hv3ruCOgqQ9pk+pMaL//cWuIfytOjzpNyUjD0wheL47Rw4p5e
         XrhsN1D22td0eNyy9FTurkcJuSyIf4PSSbRhWBWg03sYd3a5zne0nY8hIhl5wl5Iiq0/
         rwXzrUhn5/fXzh2aHHrpyapZm5QCvdomJAv4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uGPiPKSphOUEs2fEDAQ1oyHUSr8W7H4wPzT5A6mID2k=;
        b=60jl+u2dyWzZ7auv3SJat2zGHWnnTjfYVgscNaCeUHxGW97simc/5oymX+fJE+D6sD
         9ThbUfjhCUaQ+whNOBiPusiEKlfnKvVhssKa98z2SwHKmSHV2+DXDZfh2eGPo1lkyVYh
         vXRA7cAHwRWVYL6m3qW03aQctxPV4qR+JF4XjYv8sLmOLJBatse2DP+CCrpdIEg2qJ8i
         uLNi5wo/lIgnQwhUH0yhm45vtua+SbQx8ctfmMN9a8BifwAM58wuaCbCEzBYLPGDr2cY
         QHLi9PsyduvKOtt04k76xHcTwN5VMRtUH5fiYFCqD1MGR7NiFGak086HeQo+UtCj+ZTz
         VzRg==
X-Gm-Message-State: AOAM533MgzTxJFS6jcKi3oxc72GoWTqSyTPAoMMK9cvgeLb68N3etjJ6
        8haBpqRzdQUQhPxk92UREBFiKx+cuUdmhuvEQ5I=
X-Google-Smtp-Source: ABdhPJxDfcp0KO86m+QU+3JchdiUFbSwUI04IXBKrYq+NMALo01CbtjO609kakX1G8VYCxwrJ/iBBw==
X-Received: by 2002:a19:3846:: with SMTP id d6mr11824624lfj.541.1635533745406;
        Fri, 29 Oct 2021 11:55:45 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id z3sm184155ljm.113.2021.10.29.11.55.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 11:55:45 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id q16so18368862ljg.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 11:55:45 -0700 (PDT)
X-Received: by 2002:a05:651c:17a6:: with SMTP id bn38mr13088470ljb.56.1635533269069;
 Fri, 29 Oct 2021 11:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgP058PNY8eoWW=5uRMox-PuesDMrLsrCWPS+xXhzbQxQ@mail.gmail.com>
 <YXL9tRher7QVmq6N@arm.com> <CAHk-=wg4t2t1AaBDyMfOVhCCOiLLjCB5TFVgZcV4Pr8X2qptJw@mail.gmail.com>
 <CAHc6FU7BEfBJCpm8wC3P+8GTBcXxzDWcp6wAcgzQtuaJLHrqZA@mail.gmail.com>
 <YXhH0sBSyTyz5Eh2@arm.com> <CAHk-=wjWDsB-dDj+x4yr8h8f_VSkyB7MbgGqBzDRMNz125sZxw@mail.gmail.com>
 <YXmkvfL9B+4mQAIo@arm.com> <CAHk-=wjQqi9cw1Guz6a8oBB0xiQNF_jtFzs3gW0k7+fKN-mB1g@mail.gmail.com>
 <YXsUNMWFpmT1eQcX@arm.com> <CAHk-=wgzEKEYKRoR_abQRDO=R8xJX_FK+XC3gNhKfu=KLdxt3g@mail.gmail.com>
 <YXw0a9n+/PLAcObB@arm.com>
In-Reply-To: <YXw0a9n+/PLAcObB@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Oct 2021 11:47:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNV5Ka0yTssic0JbZEcO3wvoTC65budK88k4D-34v0xA@mail.gmail.com>
Message-ID: <CAHk-=wgNV5Ka0yTssic0JbZEcO3wvoTC65budK88k4D-34v0xA@mail.gmail.com>
Subject: Re: [PATCH v8 00/17] gfs2: Fix mmap + page fault deadlocks
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 29, 2021 at 10:50 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> First of all, a uaccess in interrupt should not force such signal as it
> had nothing to do with the interrupted context. I guess we can do an
> in_task() check in the fault handler.

Yeah. It ends up being similar to the thread flag in that you still
end up having to protect against NMI and other users of asynchronous
page faults.

So the suggestion was more of a "mindset" difference and modified
version of the task flag rather than anything fundamentally different.

> Second, is there a chance that we enter the fault-in loop with a SIGSEGV
> already pending? Maybe it's not a problem, we just bail out of the loop
> early and deliver the signal, though unrelated to the actual uaccess in
> the loop.

If we ever run in user space with a pending per-thread SIGSEGV, that
would already be a fairly bad bug. The intent of "force_sig()" is not
only to make sure you can't block the signal, but also that it targets
the particular thread that caused the problem: unlike other random
"send signal to process", a SIGSEGV caused by a bad memory access is
really local to that _thread_, not the signal thread group.

So somebody else sending a SIGSEGV asynchronsly is actually very
different - it goes to the thread group (although you can specify
individual threads too - but once you do that you're already outside
of POSIX).

That said, the more I look at it, the more I think I was wrong. I
think the "we have a SIGSEGV pending" could act as the per-thread
flag, but the complexity of the signal handling is probably an
argument against it.

Not because a SIGSEGV could already be pending, but because so many
other situations could be pending.

In particular, the signal code won't send new signals to a thread if
that thread group is already exiting. So another thread may have
already started the exit and core dump sequence, and is in the process
of killing the shared signal threads, and if one of those threads is
now in the kernel and goes through the copy_from_user() dance, that
whole "thread group is exiting" will mean that the signal code won't
add a new SIGSEGV to the queue.

So the signal could conceptually be used as the flag to stop looping,
but it ends up being such a complicated flag that I think it's
probably not worth it after all. Even if it semantically would be
fairly nice to use pre-existing machinery.

Could it be worked around? Sure. That kernel loop probably has to
check for fatal_signal_pending() anyway, so it would all work even in
the presense of the above kinds of issues. But just the fact that I
went and looked at just how exciting the signal code is made me think
"ok, conceptually nice, but we take a lot of locks and we do a lot of
special things even in the 'simple' force_sig() case".

> Third is the sigcontext.pc presented to the signal handler. Normally for
> SIGSEGV it points to the address of a load/store instruction and a
> handler could disable MTE and restart from that point. With a syscall we
> don't want it to point to the syscall place as it shouldn't be restarted
> in case it copied something.

I think this is actually independent of the whole "how to return
errors". We'll still need to return an error from the system call,
even if we also have a signal pending.

                  Linus
