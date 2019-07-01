Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0C385BEE0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 16:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbfGAO7R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 10:59:17 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37055 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfGAO7R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 10:59:17 -0400
Received: by mail-io1-f68.google.com with SMTP id e5so29521262iok.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jul 2019 07:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bFYIDqGnp29Kq9vUU7jzbuDouHlt/KJuN/0yDbdgP6c=;
        b=jpPFbw9BzGFSF+sJ8Jszxd4bkgiIg1QCVv5fW1+zvgNd96wicdRKJM+p3mcTB+WIAI
         8uSsNHlDEq0jtOdmE+6jwqbfVOOPhCi/SkVvF9ZEFW8xQpiyjPKAqfww79siV1oK6zXH
         PCTakRUUSJnwXrEif9BAMNQd/ReLiGJnyiyI1m8J6Eo3QLhPzMVFHibeRxnkxfyXXi/x
         k9DldJ0UPHm1TP1XrKzH8hS+LL7inL1rKlkpf0i1TU4P++RUo25Xypo+hyVUTGtwAv7N
         ddiRm7k9mXF9v+GbpIOf90pnRENC0Dl/gmtrlcW1JlruZj6ptBixzYVO85ribUL2IZi1
         zOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bFYIDqGnp29Kq9vUU7jzbuDouHlt/KJuN/0yDbdgP6c=;
        b=dhk73n2DDbePswJFAkgHWxouJTU0Yx5QVl1Y17rj268akOV+us3X2eusQUdcpNYK3w
         cEugWtiLhDLHODXlhIEtX5fYDxKokK9xVUBJqDmfxHTzTYI1M+xsuQ+vsRx14rzEo2Ck
         yFDdtGPqL2dgU56KxgiFCCTuH+br1Aoyk+5H2xKelg8o1bfBn1lJCNwTGazyStywluM2
         8KLEb9MPF0k31Lz5EFpkDQUm3TdjpWCyjte2KpWBu1bDYX3jLPtMUV5dYsBL416SxSp3
         0F0xCU6g5WQgXyaMBF5E6R1LYcRRRHfwuOFDYLyd2wiJoBge8ja58Wt+Pyikhr47+uH4
         tThg==
X-Gm-Message-State: APjAAAUu+B9CdagPMAl3jSIihpyULZQNwiCNDxK01+uCsFzZ9ZsIHLav
        oE2yP/rwXaz3uKef8vX+bJD74EYe7WKqXRrSxOIWyw==
X-Google-Smtp-Source: APXvYqyVS1F0xPYR5WIhBT+U02Ad3Ng3Iz+0B+lwIgwElcEO0B8oATnjVrSkXQ2fNgwTm3IJFXtrG1fbqhx7ML9OnkY=
X-Received: by 2002:a02:22c6:: with SMTP id o189mr28242629jao.35.1561993155868;
 Mon, 01 Jul 2019 07:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bb362d058b96d54d@google.com> <20190618140239.GA17978@ZenIV.linux.org.uk>
 <CACT4Y+ZN8CZq7L1GQANr25extEqPASRERGVh+sD4-55cvWPOSg@mail.gmail.com> <20190629203927.GA686@sol.localdomain>
In-Reply-To: <20190629203927.GA686@sol.localdomain>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 1 Jul 2019 16:59:04 +0200
Message-ID: <CACT4Y+aAqEyJdjTzRksGuFmnTjDHbB9yS6bPsK52sz3+jhxNbw@mail.gmail.com>
Subject: Re: general protection fault in do_move_mount (2)
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+6004acbaa1893ad013f0@syzkaller.appspotmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Brauner <christian@brauner.io>,
        David Howells <dhowells@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Hannes Reinecke <hare@suse.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 29, 2019 at 10:39 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Mon, Jun 24, 2019 at 11:28:18AM +0200, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> > On Tue, Jun 18, 2019 at 4:03 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Tue, Jun 18, 2019 at 03:47:10AM -0700, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    9e0babf2 Linux 5.2-rc5
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=138b310aa00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=d16883d6c7f0d717
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=6004acbaa1893ad013f0
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154e8c2aa00000
> > >
> > > IDGI...
> > >
> > > mkdir(&(0x7f0000632000)='./file0\x00', 0x0)
> > > mount(0x0, 0x0, 0x0, 0x0, 0x0)
> > > syz_open_procfs(0x0, 0x0)
> > > r0 = open(&(0x7f0000032ff8)='./file0\x00', 0x0, 0x0)
> > > r1 = memfd_create(&(0x7f00000001c0)='\xb3', 0x0)
> > > write$FUSE_DIRENT(r1, &(0x7f0000000080)=ANY=[], 0x29)
> > > move_mount(r0, &(0x7f0000000040)='./file0\x00', 0xffffffffffffff9c, &(0x7f0000000100)='./file0\x00', 0x66)
> > >
> > > reads as if we'd done mkdir ./file0, opened it and then tried
> > > to feed move_mount(2) "./file0" relative to that descriptor.
> > > How the hell has that avoided an instant -ENOENT?  On the first
> > > pair, that is - the second one (AT_FDCWD, "./file0") is fine...
> > >
> > > Confused...  Incidentally, what the hell is
> > >         mount(0x0, 0x0, 0x0, 0x0, 0x0)
> > > about?  *IF* that really refers to mount(2) with
> > > such arguments, all you'll get is -EFAULT.  Way before
> > > it gets to actually doing anything - it won't get past
> > >         /* ... and get the mountpoint */
> > >         retval = user_path(dir_name, &path);
> > >         if (retval)
> > >                 return retval;
> > > in do_mount(2)...
> >
> > Yes, mount(0x0, 0x0, 0x0, 0x0, 0x0) is mount with 0 arguments. Most
> > likely it returns EFAULT.
> > Since the reproducer have "threaded":true,"collide":true and no C
> > repro, most likely this is a subtle race. So it attempted to remove
> > mount(0x0, 0x0, 0x0, 0x0, 0x0) but it did not crash, so the conclusion
> > was that it's somehow needed. You can actually see that other
> > reproducers for this bug do not have this mount, but are otherwise
> > similar.
> >
> > With "threaded":true,"collide":true the execution mode is not just
> > "execute each syscall once one after another".
> > The syscalls are executed in separate threads and actually twice. You
> > can see the approximate execution mode in this C program:
> > https://gist.githubusercontent.com/dvyukov/c3a52f012e7cff9bdebf3935d35245cf/raw/b5587824111a1d982c985b00137ae8609572335b/gistfile1.txt
> > Yet using the C program did not trigger the crash somehow (maybe just
> > slightly different timings).
> >
> > Since syzkaller was able to reproduce it multiple times, it looks like
> > a real bug rather than an induced memory corruption or something.
> >
>
> I sent a patch to fix this bug (https://lore.kernel.org/linux-fsdevel/20190629202744.12396-1-ebiggers@kernel.org/T/#u)
>
> Dmitry, any idea why syzbot found such a bizarre reproducer for this?
> This is actually reproducible by a simple single threaded program:
>
>     #include <unistd.h>
>
>     #define __NR_move_mount         429
>     #define MOVE_MOUNT_F_EMPTY_PATH 0x00000004
>
>     int main()
>     {
>         int fds[2];
>
>         pipe(fds);
>         syscall(__NR_move_mount, fds[0], "", -1, "/", MOVE_MOUNT_F_EMPTY_PATH);
>     }


There is no pipe in the reproducer, so it could not theoretically come
up with the reproducer with the pipe. During minimization syzkaller
only tries to remove syscalls and simplify arguments and execution
mode.
What would be the simplest reproducer expressed as further
minimization of this reproducer?
https://syzkaller.appspot.com/x/repro.syz?x=154e8c2aa00000
I assume one of the syscalls is still move_mount, but what is the
other one? If it's memfd_create, or open of the procfs file, then it
seems that [ab]used heavy threading and syscall colliding as way to do
an arbitrary mutation of the program. Per se results of
memfd_create/procfs are not passed to move_mount. But by abusing races
it probably managed to do so in small percent of cases. It would also
explain why it's hard to reproduce.


> FYI, it also isn't really appropriate for syzbot to bisect all bugs in new
> syscalls to wiring them up to x86, and then blame all the x86 maintainers.
> Normally such bugs will be in the syscall itself, regardless of architecture.

Agree. Do you think it's something worth handling automatically
(stands out of the long tail of other inappropriate cases)? If so, how
could we detect such cases? It seems that some of these predicates are
quite hard to program. Similar things happen with introduction of new
bug detection tools and checks, wiring any functionality to new access
points and similar things.
