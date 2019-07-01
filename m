Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8C85BF92
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 17:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfGAPSM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 11:18:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727379AbfGAPSL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 11:18:11 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00631206A3;
        Mon,  1 Jul 2019 15:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561994290;
        bh=I9NoJt02PXsmcJDDzuEI/tWD1VgTwwOx1iv8E1gSmHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OyA8hpHOEYOMm+i16j4/cyRCkxxqTC1O4EVbVuIZdJfKsr7XK4gDMnDvJBWVgT76p
         3Nq47E6IwTYpxUCu0WfT3D9ryJrkwV1UmGk2GZ6CkUkiiheVSJp9ce4u9bfApiGmfC
         3jLDTfXp6gSIkOu0DGG/uX2pbyXdOUMmwY+TzrX4=
Date:   Mon, 1 Jul 2019 08:18:08 -0700
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
Message-ID: <20190701151808.GA790@sol.localdomain>
References: <000000000000bb362d058b96d54d@google.com>
 <20190618140239.GA17978@ZenIV.linux.org.uk>
 <CACT4Y+ZN8CZq7L1GQANr25extEqPASRERGVh+sD4-55cvWPOSg@mail.gmail.com>
 <20190629203927.GA686@sol.localdomain>
 <CACT4Y+aAqEyJdjTzRksGuFmnTjDHbB9yS6bPsK52sz3+jhxNbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aAqEyJdjTzRksGuFmnTjDHbB9yS6bPsK52sz3+jhxNbw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 01, 2019 at 04:59:04PM +0200, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> >
> > Dmitry, any idea why syzbot found such a bizarre reproducer for this?
> > This is actually reproducible by a simple single threaded program:
> >
> >     #include <unistd.h>
> >
> >     #define __NR_move_mount         429
> >     #define MOVE_MOUNT_F_EMPTY_PATH 0x00000004
> >
> >     int main()
> >     {
> >         int fds[2];
> >
> >         pipe(fds);
> >         syscall(__NR_move_mount, fds[0], "", -1, "/", MOVE_MOUNT_F_EMPTY_PATH);
> >     }
> 
> 
> There is no pipe in the reproducer, so it could not theoretically come
> up with the reproducer with the pipe. During minimization syzkaller
> only tries to remove syscalls and simplify arguments and execution
> mode.
> What would be the simplest reproducer expressed as further
> minimization of this reproducer?
> https://syzkaller.appspot.com/x/repro.syz?x=154e8c2aa00000
> I assume one of the syscalls is still move_mount, but what is the
> other one? If it's memfd_create, or open of the procfs file, then it
> seems that [ab]used heavy threading and syscall colliding as way to do
> an arbitrary mutation of the program. Per se results of
> memfd_create/procfs are not passed to move_mount. But by abusing races
> it probably managed to do so in small percent of cases. It would also
> explain why it's hard to reproduce.

To be clear, memfd_create() works just as well:

	#define _GNU_SOURCE
	#include <sys/mman.h>
	#include <unistd.h>

	#define __NR_move_mount         429
	#define MOVE_MOUNT_F_EMPTY_PATH 0x00000004

	int main()
	{
		int fd = memfd_create("foo", 0);

		syscall(__NR_move_mount, fd, "", -1, "/", MOVE_MOUNT_F_EMPTY_PATH);
	}

I just changed it to pipe() in my example, because pipe() is less obscure.

> 
> 
> > FYI, it also isn't really appropriate for syzbot to bisect all bugs in new
> > syscalls to wiring them up to x86, and then blame all the x86 maintainers.
> > Normally such bugs will be in the syscall itself, regardless of architecture.
> 
> Agree. Do you think it's something worth handling automatically
> (stands out of the long tail of other inappropriate cases)? If so, how
> could we detect such cases? It seems that some of these predicates are
> quite hard to program. Similar things happen with introduction of new
> bug detection tools and checks, wiring any functionality to new access
> points and similar things.
> 

Yes, this case could easily be automatically detected (most of the time) by
listing the filenames changed in the commit, and checking whether they all match
the pattern syscall.*\.tbl.  Sure, it's not common, but it could be alongside
other similar straightforward checks like checking for merge commits and
checking for commits that only modify Documentation/.

I'm not even asking for more correct bisection results at this point, I'm just
asking for fewer bad bisection results.

- Eric
