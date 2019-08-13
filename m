Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D76B78BB71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 16:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfHMOZa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 10:25:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37238 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbfHMOZa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:25:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id bj8so2335049plb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2019 07:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cgcBlbXGFsc/om+/smWu+Pn0e+PGsj2TzOvbc6+E86U=;
        b=C6Wd4yxwaQCT0SiFrDTxUSIkFQODTgQV7PQEXI9kmvPnDsR4HFuL/kHGspte6crI3X
         niIRYHkysNGFVRaeTjgdQiq57VbO4gQEWfnYaaLSFYY8xqxSoVaRN0B+Y/u0fOLI71aG
         /pLkgNgZK3s+44ARW92U42yPDfe33KSorJnyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cgcBlbXGFsc/om+/smWu+Pn0e+PGsj2TzOvbc6+E86U=;
        b=KAmRa88YsVuztcLBr0xnwD+02ykzDr9Zboq9YW0PYJuP44bYzdz9+wVvFOuewi4ocu
         a8O1TY47JcQE7Smu/9x8p9Lbe+/qD4csSCRGhyONSEI68nRZAA2ZaWcAnPh1x1xvkj7A
         r4PR0qRA/DRWa5bWJfkBOwy+R6697szlzpC3qDEFBdKMBaXSBCYtsNQq4UkLyGObSaND
         Tj9bT7Yfei1seML6Lzbpk8q5eFPtY/XmgBrXCzSRlF2s2a5k+i3FXMsfNAV/Hh0Tr13A
         obLRe1d6e6klj6oUpKFifCstVTRCBJ8B/nRcpAJoKzO69SzwU3FeyBRrK+maH5xY8Pvl
         HHfw==
X-Gm-Message-State: APjAAAXAq8kXZp//tk+t3PeJYLogX+ZLMe9ujYUb+kb1SS1AVz23SPUy
        kmR/1bPhUtn5LEaXM65Ss8KvvQ==
X-Google-Smtp-Source: APXvYqwTcTitvpJ7cl19fmHfaEht6G7+vMW1EpqZcjp3DkM9u+O42KKZEWe7yKNHPpAxz/5bAy17gQ==
X-Received: by 2002:a17:902:a508:: with SMTP id s8mr14691501plq.280.1565706329107;
        Tue, 13 Aug 2019 07:25:29 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r137sm24048741pfc.145.2019.08.13.07.25.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 07:25:28 -0700 (PDT)
Date:   Tue, 13 Aug 2019 10:25:27 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Jann Horn <jannh@google.com>,
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
Subject: Re: [PATCH v5 1/6] mm/page_idle: Add per-pid idle page tracking
 using virtual index
Message-ID: <20190813142527.GD258732@google.com>
References: <20190807171559.182301-1-joel@joelfernandes.org>
 <CAG48ez0ysprvRiENhBkLeV9YPTN_MB18rbu2HDa2jsWo5FYR8g@mail.gmail.com>
 <20190813100856.GF17933@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813100856.GF17933@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 13, 2019 at 12:08:56PM +0200, Michal Hocko wrote:
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

Yes, that's right. This patch doesn't change that semantic. Idle page
tracking at the core is a global procedure which is based on pages that can
be shared.

One of the usecases of the heap profiler is to enable profiling of pages that
are shared between zygote and any processes that are forked. In this case,
I am told by our team working on the heap profiler, that the monitoring of
shared pages will help.

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

The heap profiler is currently unprivileged. Would it help the concern Jann
raised, if the new interface was limited to only anonymous private/shared
pages and not to file pages? Or, is this even a real concern?

thanks,

 - Joel

