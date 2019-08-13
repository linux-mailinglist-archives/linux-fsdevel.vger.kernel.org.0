Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCF18BCE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 17:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbfHMPT4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 11:19:56 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34794 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729900AbfHMPTz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:19:55 -0400
Received: by mail-ot1-f68.google.com with SMTP id c7so1308025otp.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2019 08:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xuo82W680vfMqA0vjhlKyKy1WIhwCKADAN98TM3xDdg=;
        b=Fk1Dc/CHcXCvYiOTomqNv0zmBWlrR9D+HqfO1gKyIHgLJslb1kPNyTxNdjV/YBUBJl
         VFi0gheINDE48llBE2R/v8PcAapA7TsC2L+tCszHNHE8BMiAnBfyvQ3BeTgrrG7hYJgx
         iOSqRSx60Yi9S8YNoRsU2dXtmT+3WKOrOLCBZVm2uGQjNhhfdJmo6IhY7kn+guA1GqKN
         P/52/JmahNx9K5WuoSrr7/eJLCbdpHYrCDZ9QSF668dGyyLDrs9fygFj+BF+S3srrQam
         srUSgjROBxIq/WxIap+N60Qa6mvdP78oyd3ewOyWuiQkmhYhuq3HD/pCdrVZCjxmnkl7
         u1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xuo82W680vfMqA0vjhlKyKy1WIhwCKADAN98TM3xDdg=;
        b=TgYHpotbEruCaT+8+LJq3LbS7/kRji1WGDZBmUiRR1VkUmIL1b2Npa/y+ZKmbgMV9r
         yNlyBQqH7MCEMjHkcNmkIXa/10JS8hmi59b8Y5TR1Zo5ayy7r2B0WCOXAhonsWPg9I8u
         h75oUcZSKUI2MZroMj2MYoL/PLK/euJ0TPoAr0nELOoOrhGmFqEM4SCen7WtNv2wK64V
         k83/8HjtB3v8ZJ6upE1UA4IRUo8Pzq9TiubSHr7scGEylrk3fw3qVIehpPP46ZpPYXLN
         aSJSXrB5EhE6avFkUlwhQ6FlS5Lpa+DF4TFQ6ngSXnNd1TBe2HdaIpEKNWTVy+Hw300o
         iXeA==
X-Gm-Message-State: APjAAAW0FeBHZzg/0JEtN2G9NncIkh6tKRVrF0MoDGFjkIiT0TbDrtnb
        20sVkxdrrEXSBz2DsQNa7YlooIxgU2/CPXinSzbX4Q==
X-Google-Smtp-Source: APXvYqxcZF4gU1ub1LLFg/qKp1ZrFgTQMzOSzMW6cWHW1kLXjABD4Sai5Y205ckHfgZ5NHx4tWUFsQyWBTGBmxzQkL4=
X-Received: by 2002:aca:3dd7:: with SMTP id k206mr1661128oia.47.1565709594369;
 Tue, 13 Aug 2019 08:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190807171559.182301-1-joel@joelfernandes.org>
 <CAG48ez0ysprvRiENhBkLeV9YPTN_MB18rbu2HDa2jsWo5FYR8g@mail.gmail.com>
 <20190813100856.GF17933@dhcp22.suse.cz> <20190813142527.GD258732@google.com>
In-Reply-To: <20190813142527.GD258732@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 13 Aug 2019 17:19:27 +0200
Message-ID: <CAG48ez2shpP+WMRRJxM_za-701aoc5+i6ZrdpQ8CzjsjEzEsOA@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] mm/page_idle: Add per-pid idle page tracking using
 virtual index
To:     Joel Fernandes <joel@joelfernandes.org>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>
Cc:     Michal Hocko <mhocko@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>,
        Daniel Colascione <dancol@google.com>, fmayer@google.com,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
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

On Tue, Aug 13, 2019 at 4:25 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> On Tue, Aug 13, 2019 at 12:08:56PM +0200, Michal Hocko wrote:
> > On Mon 12-08-19 20:14:38, Jann Horn wrote:
> > > On Wed, Aug 7, 2019 at 7:16 PM Joel Fernandes (Google)
> > > <joel@joelfernandes.org> wrote:
> > > > The page_idle tracking feature currently requires looking up the pagemap
> > > > for a process followed by interacting with /sys/kernel/mm/page_idle.
> > > > Looking up PFN from pagemap in Android devices is not supported by
> > > > unprivileged process and requires SYS_ADMIN and gives 0 for the PFN.
> > > >
> > > > This patch adds support to directly interact with page_idle tracking at
> > > > the PID level by introducing a /proc/<pid>/page_idle file.  It follows
> > > > the exact same semantics as the global /sys/kernel/mm/page_idle, but now
> > > > looking up PFN through pagemap is not needed since the interface uses
> > > > virtual frame numbers, and at the same time also does not require
> > > > SYS_ADMIN.
> > > >
> > > > In Android, we are using this for the heap profiler (heapprofd) which
> > > > profiles and pin points code paths which allocates and leaves memory
> > > > idle for long periods of time. This method solves the security issue
> > > > with userspace learning the PFN, and while at it is also shown to yield
> > > > better results than the pagemap lookup, the theory being that the window
> > > > where the address space can change is reduced by eliminating the
> > > > intermediate pagemap look up stage. In virtual address indexing, the
> > > > process's mmap_sem is held for the duration of the access.
> > >
> > > What happens when you use this interface on shared pages, like memory
> > > inherited from the zygote, library file mappings and so on? If two
> > > profilers ran concurrently for two different processes that both map
> > > the same libraries, would they end up messing up each other's data?
> >
> > Yup PageIdle state is shared. That is the page_idle semantic even now
> > IIRC.
>
> Yes, that's right. This patch doesn't change that semantic. Idle page
> tracking at the core is a global procedure which is based on pages that can
> be shared.
>
> One of the usecases of the heap profiler is to enable profiling of pages that
> are shared between zygote and any processes that are forked. In this case,
> I am told by our team working on the heap profiler, that the monitoring of
> shared pages will help.
>
> > > Can this be used to observe which library pages other processes are
> > > accessing, even if you don't have access to those processes, as long
> > > as you can map the same libraries? I realize that there are already a
> > > bunch of ways to do that with side channels and such; but if you're
> > > adding an interface that allows this by design, it seems to me like
> > > something that should be gated behind some sort of privilege check.
> >
> > Hmm, you need to be priviledged to get the pfn now and without that you
> > cannot get to any page so the new interface is weakening the rules.
> > Maybe we should limit setting the idle state to processes with the write
> > status. Or do you think that even observing idle status is useful for
> > practical side channel attacks? If yes, is that a problem of the
> > profiler which does potentially dangerous things?
>
> The heap profiler is currently unprivileged. Would it help the concern Jann
> raised, if the new interface was limited to only anonymous private/shared
> pages and not to file pages? Or, is this even a real concern?

+Daniel Gruss in case he wants to provide some more detail; he has
been involved in a lot of the public research around this topic.

It is a bit of a concern when code that wasn't hardened as rigorously
as cryptographic library code operates on secret values.
A paper was published this year that abused mincore() in combination
with tricks for flushing the page cache to obtain information about
when shared read-only memory was accessed:
<https://arxiv.org/pdf/1901.01161.pdf>. In response to that, the
semantics of mincore() were changed to prevent that information from
leaking (see commit 134fca9063ad4851de767d1768180e5dede9a881).

On the other hand, an attacker could also use things like cache timing
attacks instead of abusing operating system features; that is more
hardware-specific, but it has a higher spatial granularity (typically
64 bytes instead of 4096 bytes). Timing-granularity-wise, I'm not sure
whether the proposed interface would be more or less bad than existing
cache side-channels on common architectures. There are papers that
demonstrate things like being able to distinguish some classes of
keyboard keys from others on an Android phone:
<https://www.usenix.org/system/files/conference/usenixsecurity16/sec16_paper_lipp.pdf>

I don't think limiting it to anonymous pages is necessarily enough to
completely solve this; in a normal Linux environment, it might be good
enough, but on Android, I'm worried about the CoW private memory from
the zygote.
