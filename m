Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2ED35AD61
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2019 22:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfF2Ujb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jun 2019 16:39:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbfF2Ujb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jun 2019 16:39:31 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5484C214DA;
        Sat, 29 Jun 2019 20:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561840769;
        bh=7JcPwObF+UJSdcsSlwvawJPWjh/a/x2LParpaePs+Y4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gt11Y3wz0ZaE5Hv0IzeV4/TfadqIoe5+LF0bmEIZ7zpNpcwnEwpw32gglcAwlQAaI
         xW2u4mBLjnNvqGqnpwfq18Cc08XU268J2fkmKzkxr1sBm+u3PJlQ4uUg4W+6um4ra5
         EfMaRBcVABXr9Ql6sb8E5IaJu8i+LM5OkaLkPdSU=
Date:   Sat, 29 Jun 2019 13:39:27 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
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
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: general protection fault in do_move_mount (2)
Message-ID: <20190629203927.GA686@sol.localdomain>
References: <000000000000bb362d058b96d54d@google.com>
 <20190618140239.GA17978@ZenIV.linux.org.uk>
 <CACT4Y+ZN8CZq7L1GQANr25extEqPASRERGVh+sD4-55cvWPOSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZN8CZq7L1GQANr25extEqPASRERGVh+sD4-55cvWPOSg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 11:28:18AM +0200, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> On Tue, Jun 18, 2019 at 4:03 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Tue, Jun 18, 2019 at 03:47:10AM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    9e0babf2 Linux 5.2-rc5
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=138b310aa00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=d16883d6c7f0d717
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=6004acbaa1893ad013f0
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154e8c2aa00000
> >
> > IDGI...
> >
> > mkdir(&(0x7f0000632000)='./file0\x00', 0x0)
> > mount(0x0, 0x0, 0x0, 0x0, 0x0)
> > syz_open_procfs(0x0, 0x0)
> > r0 = open(&(0x7f0000032ff8)='./file0\x00', 0x0, 0x0)
> > r1 = memfd_create(&(0x7f00000001c0)='\xb3', 0x0)
> > write$FUSE_DIRENT(r1, &(0x7f0000000080)=ANY=[], 0x29)
> > move_mount(r0, &(0x7f0000000040)='./file0\x00', 0xffffffffffffff9c, &(0x7f0000000100)='./file0\x00', 0x66)
> >
> > reads as if we'd done mkdir ./file0, opened it and then tried
> > to feed move_mount(2) "./file0" relative to that descriptor.
> > How the hell has that avoided an instant -ENOENT?  On the first
> > pair, that is - the second one (AT_FDCWD, "./file0") is fine...
> >
> > Confused...  Incidentally, what the hell is
> >         mount(0x0, 0x0, 0x0, 0x0, 0x0)
> > about?  *IF* that really refers to mount(2) with
> > such arguments, all you'll get is -EFAULT.  Way before
> > it gets to actually doing anything - it won't get past
> >         /* ... and get the mountpoint */
> >         retval = user_path(dir_name, &path);
> >         if (retval)
> >                 return retval;
> > in do_mount(2)...
> 
> Yes, mount(0x0, 0x0, 0x0, 0x0, 0x0) is mount with 0 arguments. Most
> likely it returns EFAULT.
> Since the reproducer have "threaded":true,"collide":true and no C
> repro, most likely this is a subtle race. So it attempted to remove
> mount(0x0, 0x0, 0x0, 0x0, 0x0) but it did not crash, so the conclusion
> was that it's somehow needed. You can actually see that other
> reproducers for this bug do not have this mount, but are otherwise
> similar.
> 
> With "threaded":true,"collide":true the execution mode is not just
> "execute each syscall once one after another".
> The syscalls are executed in separate threads and actually twice. You
> can see the approximate execution mode in this C program:
> https://gist.githubusercontent.com/dvyukov/c3a52f012e7cff9bdebf3935d35245cf/raw/b5587824111a1d982c985b00137ae8609572335b/gistfile1.txt
> Yet using the C program did not trigger the crash somehow (maybe just
> slightly different timings).
> 
> Since syzkaller was able to reproduce it multiple times, it looks like
> a real bug rather than an induced memory corruption or something.
> 

I sent a patch to fix this bug (https://lore.kernel.org/linux-fsdevel/20190629202744.12396-1-ebiggers@kernel.org/T/#u)

Dmitry, any idea why syzbot found such a bizarre reproducer for this?
This is actually reproducible by a simple single threaded program:

    #include <unistd.h>

    #define __NR_move_mount         429
    #define MOVE_MOUNT_F_EMPTY_PATH 0x00000004

    int main()
    {
    	int fds[2];

	pipe(fds);
	syscall(__NR_move_mount, fds[0], "", -1, "/", MOVE_MOUNT_F_EMPTY_PATH);
    }

FYI, it also isn't really appropriate for syzbot to bisect all bugs in new
syscalls to wiring them up to x86, and then blame all the x86 maintainers.
Normally such bugs will be in the syscall itself, regardless of architecture.

- Eric
