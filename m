Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCBD61A10B0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 17:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgDGPxd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 11:53:33 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:33398 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgDGPxd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:53:33 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id 1F908E8017E;
        Tue,  7 Apr 2020 17:53:30 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id A667E161537; Tue,  7 Apr 2020 17:53:29 +0200 (CEST)
Date:   Tue, 7 Apr 2020 17:53:29 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, andres@anarazel.de,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-ID: <20200407155329.GA39803@gardel-login>
References: <CAJfpegum_PsCfnar8+V2f_VO3k8CJN1LOFJV5OkHRDbQKR=EHg@mail.gmail.com>
 <20200402155020.GA31715@gardel-login>
 <CAJfpeguM__+S6DiD4MWFv5GCf_EUWvGFT0mzuUCCrfQwggqtDQ@mail.gmail.com>
 <20200403110842.GA34663@gardel-login>
 <CAJfpegtYKhXB-HNddUeEMKupR5L=RRuydULrvm39eTung0=yRg@mail.gmail.com>
 <20200403150143.GA34800@gardel-login>
 <CAJfpegudLD8F-25k-k=9G96JKB+5Y=xFT=ZMwiBkNTwkjMDumA@mail.gmail.com>
 <20200406172917.GA37692@gardel-login>
 <a4b5828d73ff097794f63f5f9d0fd1532067941c.camel@themaw.net>
 <CAJfpegvYGB01i9eqCH-95Ynqy0P=CuxPCSAbSpBPa-TV8iXN0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfpegvYGB01i9eqCH-95Ynqy0P=CuxPCSAbSpBPa-TV8iXN0Q@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Di, 07.04.20 15:59, Miklos Szeredi (miklos@szeredi.hu) wrote:

> On Tue, Apr 7, 2020 at 4:22 AM Ian Kent <raven@themaw.net> wrote:
> > > Right now, when you have n mounts, and any mount changes, or one is
> > > added or removed then we have to parse the whole mount table again,
> > > asynchronously, processing all n entries again, every frickin
> > > time. This means the work to process n mounts popping up at boot is
> > > O(n²). That sucks, it should be obvious to anyone. Now if we get that
> > > fixed, by some mount API that can send us minimal notifications about
> > > what happened and where, then this becomes O(n), which is totally OK.
>
> Something's not right with the above statement.  Hint: if there are
> lots of events in quick succession, you can batch them quite easily to
> prevent overloading the system.
>
> Wrote a pair of utilities to check out the capabilities of the current
> API.   The first one just creates N mounts, optionally sleeping
> between each.  The second one watches /proc/self/mountinfo and
> generates individual (add/del/change) events based on POLLPRI and
> comparing contents with previous instance.
>
> First use case: create 10,000 mounts, then start the watcher and
> create 1000 mounts with a 50ms sleep between them.  Total time (user +
> system) consumed by the watcher: 25s.  This is indeed pretty dismal,
> and a per-mount query will help tremendously.  But it's still "just"
> 25ms per mount, so if the mounts are far apart (which is what this
> test is about), this won't thrash the system.  Note, how this is self
> regulating: if the load is high, it will automatically batch more
> requests, preventing overload.  It is also prone to lose pairs of add
> + remove in these case (and so is the ring buffer based one from
> David).

We will batch requests too in systemd, of course, necessarily, given
that the /p/s/mi inotify stuff is async. Thing though is that this
means we buy lower CPU usage — working around the O(n²) issue — by
introducing artifical higher latencies. We usually want to boot
quickly, and not artificially slow.

Sure one can come up with some super smart scheme how to tweak the
artifical latencies, how to grow them, how to shrink them, depending
on a perceived flood of events, some backing off scheme. But that's
just polishing a turd, if all we want is proper queued change
notification without the O(n²) behaviour.

I mean, the fix for an O(n²) algorithm is to make it O(n) or so. By
coalescing wake-up events you just lower the n again, probably
linearly, but that still means we pay O(n²), which sucks.

Lennart

--
Lennart Poettering, Berlin
