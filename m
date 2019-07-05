Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2821360A52
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 18:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbfGEQep (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 12:34:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbfGEQep (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:34:45 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 434AA216E3;
        Fri,  5 Jul 2019 16:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562344483;
        bh=WxYtZKw1jG+OkDIJEaJ79US2WciG6JlSmYHbzdRDPsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NrU5sJQnAVk/UKLGBIJW38TO79AbDIO9bezzKsOrN6PdfElkBwr3Pgy8cVht1YFy0
         c9+oofrJ1jbSkjznRfpSiLO77omqY58EB+rA8gTxluV4PtxkuDLu3XxAfRM1b3Epjh
         bXgxhFM3mpgsoN7WQwGj7D6RBTnwpx+fZ5pFMHY0=
Date:   Fri, 5 Jul 2019 09:34:41 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+6004acbaa1893ad013f0@syzkaller.appspotmail.com>
Subject: Re: general protection fault in do_move_mount (2)
Message-ID: <20190705163441.GA1163@sol.localdomain>
References: <000000000000bb362d058b96d54d@google.com>
 <20190618140239.GA17978@ZenIV.linux.org.uk>
 <CACT4Y+ZN8CZq7L1GQANr25extEqPASRERGVh+sD4-55cvWPOSg@mail.gmail.com>
 <20190629203927.GA686@sol.localdomain>
 <CACT4Y+aAqEyJdjTzRksGuFmnTjDHbB9yS6bPsK52sz3+jhxNbw@mail.gmail.com>
 <20190701151808.GA790@sol.localdomain>
 <CACT4Y+YxjcY2wMJm2THYi6KouQ1dzyGTNEjOe8wSqj8in2qigw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YxjcY2wMJm2THYi6KouQ1dzyGTNEjOe8wSqj8in2qigw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Moved most people to Bcc to avoid spamming them with yet another syzkaller
discussion.  The actual kernel bug here was already fixed in mainline.]

On Fri, Jul 05, 2019 at 02:17:04PM +0200, Dmitry Vyukov wrote:
> On Mon, Jul 1, 2019 at 5:18 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Mon, Jul 01, 2019 at 04:59:04PM +0200, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> > > >
> > > > Dmitry, any idea why syzbot found such a bizarre reproducer for this?
> > > > This is actually reproducible by a simple single threaded program:
> > > >
> > > >     #include <unistd.h>
> > > >
> > > >     #define __NR_move_mount         429
> > > >     #define MOVE_MOUNT_F_EMPTY_PATH 0x00000004
> > > >
> > > >     int main()
> > > >     {
> > > >         int fds[2];
> > > >
> > > >         pipe(fds);
> > > >         syscall(__NR_move_mount, fds[0], "", -1, "/", MOVE_MOUNT_F_EMPTY_PATH);
> > > >     }
> > >
> > >
> > > There is no pipe in the reproducer, so it could not theoretically come
> > > up with the reproducer with the pipe. During minimization syzkaller
> > > only tries to remove syscalls and simplify arguments and execution
> > > mode.
> > > What would be the simplest reproducer expressed as further
> > > minimization of this reproducer?
> > > https://syzkaller.appspot.com/x/repro.syz?x=154e8c2aa00000
> > > I assume one of the syscalls is still move_mount, but what is the
> > > other one? If it's memfd_create, or open of the procfs file, then it
> > > seems that [ab]used heavy threading and syscall colliding as way to do
> > > an arbitrary mutation of the program. Per se results of
> > > memfd_create/procfs are not passed to move_mount. But by abusing races
> > > it probably managed to do so in small percent of cases. It would also
> > > explain why it's hard to reproduce.
> >
> > To be clear, memfd_create() works just as well:
> >
> >         #define _GNU_SOURCE
> >         #include <sys/mman.h>
> >         #include <unistd.h>
> >
> >         #define __NR_move_mount         429
> >         #define MOVE_MOUNT_F_EMPTY_PATH 0x00000004
> >
> >         int main()
> >         {
> >                 int fd = memfd_create("foo", 0);
> >
> >                 syscall(__NR_move_mount, fd, "", -1, "/", MOVE_MOUNT_F_EMPTY_PATH);
> >         }
> >
> > I just changed it to pipe() in my example, because pipe() is less obscure.
> 
> Then I think the reason for the bizarre reproducer is what I described above.

I'm asking why such a bizarre reproducer was generated in the first place, not
why syzkaller couldn't minimize the bizarre reproducer it already generated.

Look at each repro on the syzbot dashboard for this bug
(https://syzkaller.appspot.com/bug?id=bbf8823c8407719f089da130f341ae11d20d1622)

There are 6 repros.  All of them exploit some multithreaded race condition to
pass an empty string to sys_move_mount(), when the literal program text is
passing an nonempty string.

It seems really statistically unlikely that that's the most likely way to
encounter this bug.  It should be *much* more likely for syzkaller to find this
by generating the 2 syscalls sequentially needed to reproduce it.

So I suspect that something is wrong with the syscall definition for
move_mount().  Does syzkaller know the path(s) can be empty, and that the file
descriptor doesn't necessarily have to be a directory?  Or maybe something is
wrong with the algorithms that syzkaller uses to generate programs.

- Eric
