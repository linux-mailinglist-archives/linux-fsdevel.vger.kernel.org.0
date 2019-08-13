Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2B88BD1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 17:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfHMP3h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 11:29:37 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:47046 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbfHMP3h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:29:37 -0400
Received: by mail-ot1-f66.google.com with SMTP id z17so55548143otk.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2019 08:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jMeI5ltMPEKZ0Tj88O24MXE9cWJp6pw2JTg4dO3y4Mo=;
        b=bImk/Y4vshDj5gFBaBVzsjv6Rz+kwzqnWzrOBiLYKXqof3GfeusuSBS3ZiJ0pa2Biz
         +tCSIZX2wDwVr22g3BeKZT3HzY/3F3KR5WgLqESzTmOD6PixUCsy4sgNyuiEqlGA2Bjp
         O3h7Bxpj0KGCCfJLCDX5YuylzaDhD6YWh0+jnG/g8GPay7nwiIg92/zGE80yk/76C2Ir
         tInAOj2kgN2/l0orZzstbjsX+QeiJpnBb75cjQr+tZH8sYPtvAJiOVQTMuMyxL1xu9O/
         oCa/4Px4H0ZvIlllpY5mSai4UcuTIufdPCdutaJGOguKuqlkfxkxQaDhfVzv45rlbMpZ
         AHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jMeI5ltMPEKZ0Tj88O24MXE9cWJp6pw2JTg4dO3y4Mo=;
        b=hOmNEsgr2YL/zyzXoDAChRMSdLlj60JDJxiO78tf4yj3CgKt/CUq0OcmlnjNXz7vw+
         j6935npV/Bw1IHpmTVOK5G1yDCmqXD3aQpXxIAiT8BnHMAeKdwHs+lLDHhhYkWTNyEwd
         GTkwPuggbhbo1OGH1DTaXl2EjBwQIYd8R/GNXcqmpbHQ4jSFo29l6IZI3Si55fxaLyxD
         uDayacPFIV44kPpCro9ATZ+0EMqhWISHtxRkWUp2lIaY8an80cOCwdzHuxtu8Iu+aoKU
         wnHlgQhUjXBDHBEEWUMafkwsDcSRL8VELrJ6dXipf8zuME45mGSG/leNEijpW7YVs5ZB
         n6hQ==
X-Gm-Message-State: APjAAAXoKmKF8YnusJeGNgqNwd0+4GhnR/Og2+pFFpf3UXaUe4sL68Oz
        Rpojsx2kO/7dJfqHIMYvtsoB51CnB72gq5hPhKJPkg==
X-Google-Smtp-Source: APXvYqxQEaHf3X4y40GcHw/mVHg70puR4hMjqYUOR1PPtguEpeRZ2mELIIydxgtCS2soxOtuvIFl0/ZHBeOF0COouWI=
X-Received: by 2002:a9d:5a91:: with SMTP id w17mr35070043oth.32.1565710175793;
 Tue, 13 Aug 2019 08:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190807171559.182301-1-joel@joelfernandes.org>
 <CAG48ez0ysprvRiENhBkLeV9YPTN_MB18rbu2HDa2jsWo5FYR8g@mail.gmail.com> <20190813100856.GF17933@dhcp22.suse.cz>
In-Reply-To: <20190813100856.GF17933@dhcp22.suse.cz>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 13 Aug 2019 17:29:09 +0200
Message-ID: <CAG48ez2cuqe_VYhhaqw8Hcyswv47cmz2XmkqNdvkXEhokMVaXg@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] mm/page_idle: Add per-pid idle page tracking using
 virtual index
To:     Michal Hocko <mhocko@kernel.org>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>,
        Daniel Colascione <dancol@google.com>, fmayer@google.com,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        kernel-team <kernel-team@android.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>, namhyung@google.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Suren Baghdasaryan <surenb@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 13, 2019 at 12:09 PM Michal Hocko <mhocko@kernel.org> wrote:
> On Mon 12-08-19 20:14:38, Jann Horn wrote:
> > On Wed, Aug 7, 2019 at 7:16 PM Joel Fernandes (Google)
> > <joel@joelfernandes.org> wrote:
> > > The page_idle tracking feature currently requires looking up the pagemap
> > > for a process followed by interacting with /sys/kernel/mm/page_idle.
> > > Looking up PFN from pagemap in Android devices is not supported by
> > > unprivileged process and requires SYS_ADMIN and gives 0 for the PFN.
> > >
> > > This patch adds support to directly interact with page_idle tracking at
> > > the PID level by introducing a /proc/<pid>/page_idle file.  It follows
> > > the exact same semantics as the global /sys/kernel/mm/page_idle, but now
> > > looking up PFN through pagemap is not needed since the interface uses
> > > virtual frame numbers, and at the same time also does not require
> > > SYS_ADMIN.
> > >
> > > In Android, we are using this for the heap profiler (heapprofd) which
> > > profiles and pin points code paths which allocates and leaves memory
> > > idle for long periods of time. This method solves the security issue
> > > with userspace learning the PFN, and while at it is also shown to yield
> > > better results than the pagemap lookup, the theory being that the window
> > > where the address space can change is reduced by eliminating the
> > > intermediate pagemap look up stage. In virtual address indexing, the
> > > process's mmap_sem is held for the duration of the access.
> >
> > What happens when you use this interface on shared pages, like memory
> > inherited from the zygote, library file mappings and so on? If two
> > profilers ran concurrently for two different processes that both map
> > the same libraries, would they end up messing up each other's data?
>
> Yup PageIdle state is shared. That is the page_idle semantic even now
> IIRC.
>
> > Can this be used to observe which library pages other processes are
> > accessing, even if you don't have access to those processes, as long
> > as you can map the same libraries? I realize that there are already a
> > bunch of ways to do that with side channels and such; but if you're
> > adding an interface that allows this by design, it seems to me like
> > something that should be gated behind some sort of privilege check.
>
> Hmm, you need to be priviledged to get the pfn now and without that you
> cannot get to any page so the new interface is weakening the rules.
> Maybe we should limit setting the idle state to processes with the write
> status. Or do you think that even observing idle status is useful for
> practical side channel attacks? If yes, is that a problem of the
> profiler which does potentially dangerous things?

I suppose read-only access isn't a real problem as long as the
profiler isn't writing the idle state in a very tight loop... but I
don't see a usecase where you'd actually want that? As far as I can
tell, if you can't write the idle state, being able to read it is
pretty much useless.

If the profiler only wants to profile process-private memory, then
that should be implementable in a safe way in principle, I think, but
since Joel said that they want to profile CoW memory as well, I think
that's inherently somewhat dangerous.
