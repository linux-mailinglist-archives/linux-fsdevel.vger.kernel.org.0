Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF4E519D587
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 13:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389188AbgDCLIp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 07:08:45 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:51808 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbgDCLIp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 07:08:45 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 5B38AE80689;
        Fri,  3 Apr 2020 13:08:43 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 5120A1614E3; Fri,  3 Apr 2020 13:08:42 +0200 (CEST)
Date:   Fri, 3 Apr 2020 13:08:42 +0200
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
Message-ID: <20200403110842.GA34663@gardel-login>
References: <2590640.1585757211@warthog.procyon.org.uk>
 <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <20200402143623.GB31529@gardel-login>
 <CAJfpegtRi9epdxAeoVbm+7UxkZfzC6XmD4K_5dg=RKADxy_TVA@mail.gmail.com>
 <20200402152831.GA31612@gardel-login>
 <CAJfpegum_PsCfnar8+V2f_VO3k8CJN1LOFJV5OkHRDbQKR=EHg@mail.gmail.com>
 <20200402155020.GA31715@gardel-login>
 <CAJfpeguM__+S6DiD4MWFv5GCf_EUWvGFT0mzuUCCrfQwggqtDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfpeguM__+S6DiD4MWFv5GCf_EUWvGFT0mzuUCCrfQwggqtDQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Do, 02.04.20 19:20, Miklos Szeredi (miklos@szeredi.hu) wrote:

> On Thu, Apr 2, 2020 at 5:50 PM Lennart Poettering <mzxreary@0pointer.de> wrote:
> >
> > On Do, 02.04.20 17:35, Miklos Szeredi (miklos@szeredi.hu) wrote:
> >
> > > > systemd cares about all mount points in PID1's mount namespace.
> > > >
> > > > The fact that mount tables can grow large is why we want something
> > > > better than constantly reparsing the whole /proc/self/mountinfo. But
> > > > filtering subsets of that is something we don't really care about.
> > >
> > > I can accept that, but you haven't given a reason why that's so.
> > >
> > > What does it do with the fact that an automount point was crossed, for
> > > example?  How does that affect the operation of systemd?
> >
> > We don't care how a mount point came to be. If it's autofs or
> > something else, we don't care. We don't access these mount points
> > ourselves ever, we just watch their existance.
> >
> > I mean, it's not just about startup it's also about shutdown. At
> > shutdown we need to unmount everything from the leaves towards the
> > root so that all file systems are in a clean state.
>
> Unfortunately that's not guaranteed by umounting all filesystems from
> the init namespace.  A filesystem is shut down when all references to
> it are gone.  Perhaps you instead want to lazy unmount root (yeah,
> that may not actually be allowed, but anyway, lazy unmounting the top
> level ones should do) and watch for super block shutdown events
> instead.
>
> Does that make any sense?

When all mounts in the init mount namespace are unmounted and all
remaining processes killed we switch root back to the initrd, so that
even the root fs can be unmounted, and then we disassemble any backing
complex storage if there is, i.e. lvm, luks, raid, …

Because the initrd is its own little root fs independent of the actual
root we can fully disassemble everything this way, as we do not retain
any references to it anymore in any way.

Lennart

--
Lennart Poettering, Berlin
