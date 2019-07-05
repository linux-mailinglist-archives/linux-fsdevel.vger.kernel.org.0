Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35D34605D1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 14:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfGEMRQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 08:17:16 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37211 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGEMRQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:17:16 -0400
Received: by mail-io1-f66.google.com with SMTP id e5so14326018iok.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jul 2019 05:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=attF657RYtQ1qVlMlhaW4Cdqr/YPSVY99/m/3/stAMA=;
        b=LLVkTWYkTYW1InwoPztrYJ7JNBcPC4tteZxQAWNwP7giTcQztjKskBzsbE/81kmVs9
         tJPiJIWgKBTmjHoqkgkpPgb/XRKjCzgC+BaslDWrp3HuKcQUqJSbD/3q/JbWAU759zWF
         KGDPdJUL1AH3zo4vszQgoU9gEgUkCL43ci/qr1fPVwii+265Gk//CFqLlSTf1Np8XikZ
         l0rwnBKLy13lU2w0qfbbB/ymrhSXuSEsKh8yYB7EXWU1ZmZiRaUbN92IQBimJpE+9FdT
         cao8odFLqN9Rkij4Z2lkeyaFAipCgFd2DC+3Pl7Y+0zD7f07C+QRLDnatHHUR4Qf3BW9
         qjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=attF657RYtQ1qVlMlhaW4Cdqr/YPSVY99/m/3/stAMA=;
        b=RkixLnS9bvMLsWjlE80EyZu5Ayn4RJgf57X4rSgQ7kPc9YDmgIzNUKEPnb4jkWBP3X
         LBu9tRVD6Iu9QiX+IEW+9QdtTBtBCzgKQZPwCLH5oWybbQIqSi4sdSUhJAqZS13tZc7n
         2sTFsi8zpPQQk/qM/LfgZeRSR45b7cGR+xeBSAD76m32lH7ThKACLBHxf4hwfdLebwgL
         Hla1kIezggq4vSGeRhmoZd1JogoD4cyKpZTErfeA2JJkAiuzF37CFPOS+lDR8RcZY8Hr
         jIhhIA2XrQ6RzVov5Mt8H+QRQo/M3xrLvyRjiNe8EkcB+0PHev2Q5nxh/s2+hB3niLq4
         GUIQ==
X-Gm-Message-State: APjAAAUHx4dLY4ACzafVnaaAv2RTs8w9AmnNf/bL/SEKQnueiemDOAuW
        i6DdifkT04k01T30+g1bxKBoxdzQmwhsjENBWKrScg==
X-Google-Smtp-Source: APXvYqz04w6d1Zql9T9Y6gFDzNOmXCVtQOzC3p8gFLr3aw7GqYahW12dxWLaRgWY6ONfrqfA7jBkhAOCY2H0qjY8/IQ=
X-Received: by 2002:a6b:4101:: with SMTP id n1mr4025057ioa.138.1562329035066;
 Fri, 05 Jul 2019 05:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bb362d058b96d54d@google.com> <20190618140239.GA17978@ZenIV.linux.org.uk>
 <CACT4Y+ZN8CZq7L1GQANr25extEqPASRERGVh+sD4-55cvWPOSg@mail.gmail.com>
 <20190629203927.GA686@sol.localdomain> <CACT4Y+aAqEyJdjTzRksGuFmnTjDHbB9yS6bPsK52sz3+jhxNbw@mail.gmail.com>
 <20190701151808.GA790@sol.localdomain>
In-Reply-To: <20190701151808.GA790@sol.localdomain>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 5 Jul 2019 14:17:04 +0200
Message-ID: <CACT4Y+YxjcY2wMJm2THYi6KouQ1dzyGTNEjOe8wSqj8in2qigw@mail.gmail.com>
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

On Mon, Jul 1, 2019 at 5:18 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Mon, Jul 01, 2019 at 04:59:04PM +0200, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> > >
> > > Dmitry, any idea why syzbot found such a bizarre reproducer for this?
> > > This is actually reproducible by a simple single threaded program:
> > >
> > >     #include <unistd.h>
> > >
> > >     #define __NR_move_mount         429
> > >     #define MOVE_MOUNT_F_EMPTY_PATH 0x00000004
> > >
> > >     int main()
> > >     {
> > >         int fds[2];
> > >
> > >         pipe(fds);
> > >         syscall(__NR_move_mount, fds[0], "", -1, "/", MOVE_MOUNT_F_EMPTY_PATH);
> > >     }
> >
> >
> > There is no pipe in the reproducer, so it could not theoretically come
> > up with the reproducer with the pipe. During minimization syzkaller
> > only tries to remove syscalls and simplify arguments and execution
> > mode.
> > What would be the simplest reproducer expressed as further
> > minimization of this reproducer?
> > https://syzkaller.appspot.com/x/repro.syz?x=154e8c2aa00000
> > I assume one of the syscalls is still move_mount, but what is the
> > other one? If it's memfd_create, or open of the procfs file, then it
> > seems that [ab]used heavy threading and syscall colliding as way to do
> > an arbitrary mutation of the program. Per se results of
> > memfd_create/procfs are not passed to move_mount. But by abusing races
> > it probably managed to do so in small percent of cases. It would also
> > explain why it's hard to reproduce.
>
> To be clear, memfd_create() works just as well:
>
>         #define _GNU_SOURCE
>         #include <sys/mman.h>
>         #include <unistd.h>
>
>         #define __NR_move_mount         429
>         #define MOVE_MOUNT_F_EMPTY_PATH 0x00000004
>
>         int main()
>         {
>                 int fd = memfd_create("foo", 0);
>
>                 syscall(__NR_move_mount, fd, "", -1, "/", MOVE_MOUNT_F_EMPTY_PATH);
>         }
>
> I just changed it to pipe() in my example, because pipe() is less obscure.

Then I think the reason for the bizarre reproducer is what I described above.
