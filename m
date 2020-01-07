Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08145132544
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 12:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgAGLxt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 06:53:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39979 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgAGLxt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 06:53:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so19055820wmi.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2020 03:53:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XjbjW17kr7NfqcigVFZkjzOhHETZWQ0JY8WiwmMR/Ys=;
        b=FOdmlUlWM867hxU9IT83DXXvbBYlPyWlXFWbcJITEBlXr2vVW6ESQkiVmG3Jp+UiPQ
         SHhY9f92jYxnDS0o+XunMwJDWo3Z/iu1NtmTjhQQr9DaaGzsGfiroiQND/NTZnywrpuX
         8W/eeO7PDC+JFS5SYhNbi9kFv5QbS9TLafmPqLIXxSCFvgNuQ4HOZ97RKwdd0rPrT9oA
         dpO0BnGyXlPvc7xAYAcap4CNBM5+5QISg3nFJrSXf7sislGxIRDsqAY5B3Sgxfs2DZMf
         xqFBhTmdlUvc1QU+mvFHErL2k6wkNBay6U6w6IPZH/xeWRTzBVHhV9vDSXAlII0YCSOS
         57GA==
X-Gm-Message-State: APjAAAVseN0AZDUG1KxXYEQ2I5+dl6o3WmqevRfRfHLBwL4vQ12Y29rs
        jl3/F1bsvek1sky7qk2Ia7Q=
X-Google-Smtp-Source: APXvYqzS5v/YyXcNnL6bTaUsQSkd/ylQ/ZoE4YwjI1s08uBKwB5yGAqdvvTJN9ZI1B3gTaL4BdvCzg==
X-Received: by 2002:a05:600c:21c6:: with SMTP id x6mr38239274wmj.177.1578398026761;
        Tue, 07 Jan 2020 03:53:46 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id v83sm26794876wmg.16.2020.01.07.03.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 03:53:46 -0800 (PST)
Date:   Tue, 7 Jan 2020 12:53:45 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        lsf-pc@lists.linux-foundation.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] Congestion
Message-ID: <20200107115345.GG32178@dhcp22.suse.cz>
References: <20191231125908.GD6788@bombadil.infradead.org>
 <20200106115514.GG12699@dhcp22.suse.cz>
 <20200106232100.GL23195@dread.disaster.area>
 <CAJCQCtTPtveHb8gJ7EPdck4WLsN6=RbS+kh0bGN_=-hrrWpuow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtTPtveHb8gJ7EPdck4WLsN6=RbS+kh0bGN_=-hrrWpuow@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 07-01-20 01:23:38, Chris Murphy wrote:
> On Mon, Jan 6, 2020 at 4:21 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Mon, Jan 06, 2020 at 12:55:14PM +0100, Michal Hocko wrote:
> > > On Tue 31-12-19 04:59:08, Matthew Wilcox wrote:
> > > >
> > > > I don't want to present this topic; I merely noticed the problem.
> > > > I nominate Jens Axboe and Michael Hocko as session leaders.  See the
> > > > thread here:
> > >
> > > Thanks for bringing this up Matthew! The change in the behavior came as
> > > a surprise to me. I can lead the session for the MM side.
> > >
> > > > https://lore.kernel.org/linux-mm/20190923111900.GH15392@bombadil.infradead.org/
> > > >
> > > > Summary: Congestion is broken and has been for years, and everybody's
> > > > system is sleeping waiting for congestion that will never clear.
> > > >
> > > > A good outcome for this meeting would be:
> > > >
> > > >  - MM defines what information they want from the block stack.
> > >
> > > The history of the congestion waiting is kinda hairy but I will try to
> > > summarize expectations we used to have and we can discuss how much of
> > > that has been real and what followed up as a cargo cult. Maybe we just
> > > find out that we do not need functionality like that anymore. I believe
> > > Mel would be a great contributor to the discussion.
> >
> > We most definitely do need some form of reclaim throttling based on
> > IO congestion, because it is trivial to drive the system into swap
> > storms and OOM killer invocation when there are large dirty slab
> > caches that require IO to make reclaim progress and there's little
> > in the way of page cache to reclaim.
> >
> > This is one of the biggest issues I've come across trying to make
> > XFS inode reclaim non-blocking - the existing code blocks on inode
> > writeback IO congestion to throttle the overall reclaim rate and
> > so prevents swap storms and OOM killer rampages from occurring.
> >
> > The moment I remove the inode writeback blocking from the reclaim
> > path and move the backoffs to the core reclaim congestion backoff
> > algorithms, I see a sustantial increase in the typical reclaim scan
> > priority. This is because the reclaim code does not have an
> > integrated back-off mechanism that can balance reclaim throttling
> > between slab cache and page cache reclaim. This results in
> > insufficient page reclaim backoff under slab cache backoff
> > conditions, leading to excessive page cache reclaim and swapping out
> > all the anonymous pages in memory. Then performance goes to hell as
> > userspace then starts to block on page faults swap thrashing like
> > this:
> 
> This really caught my attention, however unrelated it may actually be.
> The gist of my question is: what are distributions doing wrong, that
> it's possible for an unprivileged process to take down a system such
> that an ordinary user reaches for the power button? [1]

Well, free ticket to all the available memory is the key here I believe.
Memory cgroups can be of a great help to reduce the amount of memory
for untrusted users. I am not sure whether that would help your example
in the footnote though. It seems your workload is reaching a threshing
state. It would be interesting to get some more data to see whether that
is a result of the real memory demand or the memory reclaim misbehavior
(It would be great to collect /proc/vmstat data while the system is
behaving like that in a separate email thread).

> More helpful
> would be, what should distributions be doing better to avoid the
> problem in the first place? User space oom daemons are now popular,
> and there's talk about avoiding swap thrashing and oom by strict use
> of cgroupsv2 and PSI. Some people say, oh yeah duh, just don't make a
> swap device at all, what are you crazy? Then there's swap on ZRAM. And
> alas zswap too. So what's actually recommended to help with this
> problem?

I believe this will be workload specific and it is always appreciated to
report the behavior as mentioned above.

> I don't have many original thoughts, but I can't find a reference for
> why my brain is telling me the kernel oom-killer is mainly concerned
> about kernel survival in low memory situations, and not user space.

This is indeed the case. It is a last resort measure to survive the
memory depletion. Unfortunately the oom detection doesn't cope well with
the threshing scenarios where the memory is still reclaimable reasonably
easily while the userspace cannot make much progress because it is
refaulting the working set constantly. PSI has been a great step forward
for those workloads. We haven't found a good way to integrate that
information into the oom detection yet, unfortunately because an
acceptable level of refaulting is very workload dependent.

[...]

> [1]
> Fedora 30/31 default installation, 8G RAM, 8G swap (on plain SSD
> partition), and compile webkitgtk. Within ~5 minutes all RAM is
> cosumed, and the "swap storm" begins. The GUI stutters, even the mouse
> pointer starts to gets choppy, and soon after it's pretty much locked
> up and for all practical purposes it's locked up. Most typical, it
> stays this way for 30+ minutes. Occasionally oom-killer kicks in and
> clobbers something. Sometimes it's one of the compile threads. And
> also occasionally it'll be something absurd like sshd, sssd, or
> systemd-journald - which really makes no sense at all.
> 
> [2]
> https://linux-mm.org/OOM_Killer
> 
> --
> Chris Murphy

-- 
Michal Hocko
SUSE Labs
