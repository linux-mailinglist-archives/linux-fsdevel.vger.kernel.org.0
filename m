Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F08F19FB88
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 19:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgDFR3U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 13:29:20 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:60764 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgDFR3U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:29:20 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 28E37E8017E;
        Mon,  6 Apr 2020 19:29:18 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 9177C161537; Mon,  6 Apr 2020 19:29:17 +0200 (CEST)
Date:   Mon, 6 Apr 2020 19:29:17 +0200
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
Message-ID: <20200406172917.GA37692@gardel-login>
References: <20200402143623.GB31529@gardel-login>
 <CAJfpegtRi9epdxAeoVbm+7UxkZfzC6XmD4K_5dg=RKADxy_TVA@mail.gmail.com>
 <20200402152831.GA31612@gardel-login>
 <CAJfpegum_PsCfnar8+V2f_VO3k8CJN1LOFJV5OkHRDbQKR=EHg@mail.gmail.com>
 <20200402155020.GA31715@gardel-login>
 <CAJfpeguM__+S6DiD4MWFv5GCf_EUWvGFT0mzuUCCrfQwggqtDQ@mail.gmail.com>
 <20200403110842.GA34663@gardel-login>
 <CAJfpegtYKhXB-HNddUeEMKupR5L=RRuydULrvm39eTung0=yRg@mail.gmail.com>
 <20200403150143.GA34800@gardel-login>
 <CAJfpegudLD8F-25k-k=9G96JKB+5Y=xFT=ZMwiBkNTwkjMDumA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfpegudLD8F-25k-k=9G96JKB+5Y=xFT=ZMwiBkNTwkjMDumA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mo, 06.04.20 11:22, Miklos Szeredi (miklos@szeredi.hu) wrote:

> > Nah. What I wrote above is drastically simplified. It's IRL more
> > complex. Specific services need to be killed between certain mounts
> > are unmounted, since they are a backend for another mount. NFS, or
> > FUSE or stuff like that usually has some processes backing them
> > around, and we need to stop the mounts they provide before these
> > services, and then the mounts these services reside on after that, and
> > so on. It's a complex dependency tree of stuff that needs to be done
> > in order, so that we can deal with arbitrarily nested mounts, storage
> > subsystems, and backing services.
>
> That still doesn't explain why you need to keep track of all mounts in
> the system.
>
> If you are aware of the dependency, then you need to keep track of
> that particular mount. If not, then why?

it works the other way round in systemd: something happens, i.e. a
device pops up or a mount is established and systemd figures our if
there's something to do. i.e. whether services shall be pulled in or
so.

It's that way for a reason: there are plenty services that want to
instantiated once for each object of a certain kind to pop up (this
happens very often for devices, but could also happen for any other
kind of "unit" systemd manages, and one of those kinds are mount
units). For those we don't know the unit to pull in yet (because it's
not going to be a well-named singleton, but an instance incorporating
some identifier from the source unit) when the unit that pops up does
so, thus we can only wait for the the latter to determine what to pull
in.

> What I'm starting to see is that there's a fundamental conflict
> between how systemd people want to deal with new mounts and how some
> other people want to use mounts (i.e. tens of thousands of mounts in
> an automount map).

Well, I am not sure what automount has to do with anything. You can
have 10K mounts with or without automount, it's orthogonal to that. In
fact, I assumed the point of automount was to pretend there are 10K
mounts but not actually have them most of the time, no?

I mean, whether there's room to optimize D-Bus IPC or not is entirely
orthogonal to anything discussed here regarding fsinfo(). Don't make
this about systemd sending messages over D-Bus, that's a very
different story, and a non-issue if you ask me:

Right now, when you have n mounts, and any mount changes, or one is
added or removed then we have to parse the whole mount table again,
asynchronously, processing all n entries again, every frickin
time. This means the work to process n mounts popping up at boot is
O(n²). That sucks, it should be obvious to anyone. Now if we get that
fixed, by some mount API that can send us minimal notifications about
what happened and where, then this becomes O(n), which is totally OK.

You keep talking about filtering, which will just lower the "n" a bit
in particular cases to some value "m" maybe (with m < n), it does not
address the fact that O(m²) is still a big problem.

hence, filtering is great, no problem, add it if you want it. I
personally don't care about filtering though, and I doubt we'd use it
in systemd, I just care about the O(n²) issue.

If you ask me if D-Bus can handle 10K messages sent over the bus
during boot, then yes, it totally can handle that. Can systemd nicely
process O(n²) mounts internally though equally well? No, obviously not,
if n grows too large. Anyone computer scientist should understand that..

Anyway, I have the suspicion this discussion has stopped being
useful. I think you are trying to fix problems that userspce actually
doesn't have. I can just tell you what we understand the problems are,
but if you are out trying to fix other percieved ones, then great, but
I mostly lost interest.

Lennart

--
Lennart Poettering, Berlin
