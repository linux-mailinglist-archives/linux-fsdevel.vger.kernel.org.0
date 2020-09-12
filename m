Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C399F267C66
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Sep 2020 22:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgILU6O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Sep 2020 16:58:14 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:23761 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgILU6L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Sep 2020 16:58:11 -0400
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 7DDAD240003;
        Sat, 12 Sep 2020 20:58:04 +0000 (UTC)
Date:   Sat, 12 Sep 2020 13:58:01 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Michael Larabel <Michael@michaellarabel.com>,
        Ted Ts'o <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Kernel Benchmarking
Message-ID: <20200912205801.GA613714@localhost>
References: <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com>
 <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com>
 <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com>
 <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <CAHk-=whjhYa3ig0U_mtpoU5Zok_2Y5zTCw8f-THkf1vHRBDNuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whjhYa3ig0U_mtpoU5Zok_2Y5zTCw8f-THkf1vHRBDNuA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 12, 2020 at 10:59:40AM -0700, Linus Torvalds wrote:
> So I think the VM people (but perhaps not necessarily all filesystem
> people) have been aware of a long-time problem with certain loads
> causing huge latencies, up to and including watchdogs firing because
> processes wouldn't make progress for over half a minute (or whatever
> the default blocking watchdog timeout is - I would like to say that
> it's some odd number like 22 seconds, but maybe that was RCU).
> 
> We've known it's related to long queues for the page lock, and about
> three years ago now we added a "bookmark" entry to the page wakeup
> queues, because those queues got so long that even just traversing the
> wakeup queue was a big latency hit. But it's generally been some heavy
> private load on a customer machine, and nobody ever really had a good
> test-case for it.

I don't *know* if this is the same bottleneck, but I have an easily
reproducible workload that rather reliably triggers softlockup
watchdogs, massive performance bottlenecks, and processes that hang for
a while without making forward progress, and it seemed worth mentioning
in case it might serve as a reproducer for those private workloads.
(Haven't tested it on a kernel with this fairness fix added; most recent
tests were on 5.7-rc6.)

On a GCP n1-highcpu-96 instance, with nested virtualization enabled,
create a QEMU/KVM VM with the same number of CPUs backed by a disk image
using either NVME or virtio, and in that VM, build a defconfig kernel
with `make -j$(nproc)`. Lots of softlockup warnings, processes that
should be very quick hanging for a long time, and the build on the guest
is up to 5x slower than the host system, with 12-15x the system time.

I've seen similar softlockups with huge VMs running on physical
hardware, not just on cloud systems that allow nested virtualization.
This is *probably* reproducible for anyone who has local hardware with
lots of CPUs, but doing it on GCP should be accessible to anyone.

(I'm not using GCP anymore, and the systems I'm using don't support
nested virtualization, so I don't have this workload readily available
anymore. It was a completely standard Debian image with the cloud kernel
installed, and zero unusual configuration.)

> Fairness is good, but fairness is usually bad for performance even if
> it does get rid of the worst-case issues. In this case, it's _really_
> bad for performance, because that page lock has always been unfair,
> and we have a lot of patterns that have basically come to
> (unintentionally) depend on that unfairness.
> 
> In particular, the page locking is often used for just verifying
> simple things, with the most common example being "lock page, check
> that the mapping is still valid, insert page into page tables, unlock
> page".
[...]
> This is not a new issue. We've had exactly the same thing happen when
> we made spinlocks, semaphores, and rwlocks be fair.
> 
> And like those other times, we had to make them fair because *not*
> making them fair caused those unacceptable outliers under contention,
> to the point of starvation and watchdogs firing.
> 
> Anyway, I don't have a great solution. I have a few options (roughly
> ordered by "simplest to most complex"):
> 
>  (a) just revert
>  (b) add some busy-spinning
>  (c) reader-writer page lock
>  (d) try to de-emphasize the page lock
> 
> but I'd love to hear comments.

[...]

> Honestly, (a) is trivial to do. We've had the problem for years, the
> really *bad* cases are fairly rare, and the workarounds mostly work.
> Yeah, you get watchdogs firing, but it's not exactly _common_.

I feel like every time I run a non-trivial load inside a huge VM, I end
up hitting those watchdogs; they don't *feel* rare.

> Option (c) is, I feel, the best one. Reader-writer locks aren't
> wonderful, but the page lock really tends to have two very distinct
> uses: exclusive for the initial IO and for the (very very unlikely)
> truncate and hole punching issues, and then the above kind of "lock to
> check that it's still valid" use, which is very very common and
> happens on every page fault and then some. And it would be very
> natural to make the latter be a read-lock (or even just a sequence
> counting one with retry rather than a real lock).
> 
> Option (d) is "we already have a locking in many filesystems that give
> us exclusion between faulting in a page, and the truncate/hole punch,
> so we shouldn't use the page lock at all".
> 
> I do think that the locking that filesystems do is in many ways
> inferior - it's done on a per-inode basis rather than on a per-page
> basis. But if the filesystems end up doing that *anyway*, what's the
> advantage of the finer granularity one? And *because* the common case
> is all about the reading case, the bigger granularity tends to work
> very well in practice, and basically never sees contention.
> 
> So I think option (c) is potentially technically better because it has
> smaller locking granularity, but in practice (d) might be easier and
> we already effectively do it for several filesystems.

If filesystems are going to have to have that lock *anyway*, and it
makes the page lock entirely redundant for that use case, then it
doesn't seem like there's any point to making the page lock cheaper if
we can avoid it entirely. On the other hand, that seems like it might
make locking a *lot* more complicated, if the synchronization on a
struct page is "usually the page lock, but if it's a filesystem page,
then a filesystem-specific lock instead".

So, it seems like there'd be two deciding factors between (c) and (d):
- Whether filesystems might ever be able to use the locks in (c) to
  reduce or avoid having to do their own locking for this case. (Seems
  like there might be a brlock-style approach that could work for
  truncate/hole-punch.)
- Whether (d) would make the locking story excessively complicated
  compared to (c).

> This turned out to be a very long email, and probably most people
> didn't get this far. But if you did, comments, opinions, suggestions?
> 
> Any other suggestions than those (a)-(d) ones above?
> 
>                Linus
