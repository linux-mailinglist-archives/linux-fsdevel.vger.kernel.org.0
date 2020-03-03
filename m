Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEC21783C7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 21:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbgCCUPV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 15:15:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:34432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730352AbgCCUPV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 15:15:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 162B920CC7;
        Tue,  3 Mar 2020 20:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583266518;
        bh=KNVnLGdyUhMWXTVbWxn9KbP0sS7e0UnfGOEqTIW/oEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZqAMJW3P72+S7v0gazyt3aVIYN7idSRVWHybc/orGA3aAern4y76oXsuCS1m1Imdl
         eQneEB5bpRCmB6ry43tOwrTRPdPT1WwRxxw2+hmI2W2rKskcKZzpsh/OE76yt/BqrG
         n6iW3ZDy8YL0sJM8HUYqOjHQ6IWsZ9YKbwMgf384=
Date:   Tue, 3 Mar 2020 21:15:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jann Horn <jannh@google.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
Message-ID: <20200303201516.GA1136381@kroah.com>
References: <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
 <20200303113814.rsqhljkch6tgorpu@ws.net.home>
 <20200303130347.GA2302029@kroah.com>
 <20200303131434.GA2373427@kroah.com>
 <CAJfpegt0aQVvoDeBXOu2xZh+atZQ+q5uQ_JRxe46E8cZ7sHRwg@mail.gmail.com>
 <20200303134316.GA2509660@kroah.com>
 <CAJfpegtFyZqSRzo3uuXp1S2_jJJ29DL=xAwKjpEGvyG7=AzabA@mail.gmail.com>
 <20200303142958.GB47158@kroah.com>
 <CAG48ez1sdUJzp85oqBw8vCpc3E4Sb26M9pj2zHhnKpb-1+f4vg@mail.gmail.com>
 <20200303165103.GA731597@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303165103.GA731597@kroah.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 03, 2020 at 05:51:03PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 03, 2020 at 03:40:24PM +0100, Jann Horn wrote:
> > On Tue, Mar 3, 2020 at 3:30 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Tue, Mar 03, 2020 at 03:10:50PM +0100, Miklos Szeredi wrote:
> > > > On Tue, Mar 3, 2020 at 2:43 PM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Tue, Mar 03, 2020 at 02:34:42PM +0100, Miklos Szeredi wrote:
> > > >
> > > > > > If buffer is too small to fit the whole file, return error.
> > > > >
> > > > > Why?  What's wrong with just returning the bytes asked for?  If someone
> > > > > only wants 5 bytes from the front of a file, it should be fine to give
> > > > > that to them, right?
> > > >
> > > > I think we need to signal in some way to the caller that the result
> > > > was truncated (see readlink(2), getxattr(2), getcwd(2)), otherwise the
> > > > caller might be surprised.
> > >
> > > But that's not the way a "normal" read works.  Short reads are fine, if
> > > the file isn't big enough.  That's how char device nodes work all the
> > > time as well, and this kind of is like that, or some kind of "stream" to
> > > read from.
> > >
> > > If you think the file is bigger, then you, as the caller, can just pass
> > > in a bigger buffer if you want to (i.e. you can stat the thing and
> > > determine the size beforehand.)
> > >
> > > Think of the "normal" use case here, a sysfs read with a PAGE_SIZE
> > > buffer.  That way userspace "knows" it will always read all of the data
> > > it can from the file, we don't have to do any seeking or determining
> > > real file size, or anything else like that.
> > >
> > > We return the number of bytes read as well, so we "know" if we did a
> > > short read, and also, you could imply, if the number of bytes read are
> > > the exact same as the number of bytes of the buffer, maybe the file is
> > > either that exact size, or bigger.
> > >
> > > This should be "simple", let's not make it complex if we can help it :)
> > >
> > > > > > Verify that the number of bytes read matches the file size, otherwise
> > > > > > return error (may need to loop?).
> > > > >
> > > > > No, we can't "match file size" as sysfs files do not really have a sane
> > > > > "size".  So I don't want to loop at all here, one-shot, that's all you
> > > > > get :)
> > > >
> > > > Hmm.  I understand the no-size thing.  But looping until EOF (i.e.
> > > > until read return zero) might be a good idea regardless, because short
> > > > reads are allowed.
> > >
> > > If you want to loop, then do a userspace open/read-loop/close cycle.
> > > That's not what this syscall should be for.
> > >
> > > Should we call it: readfile-only-one-try-i-hope-my-buffer-is-big-enough()?  :)
> > 
> > So how is this supposed to work in e.g. the following case?
> > 
> > ========================================
> > $ cat map_lots_and_read_maps.c
> > #include <sys/mman.h>
> > #include <fcntl.h>
> > #include <unistd.h>
> > 
> > int main(void) {
> >   for (int i=0; i<1000; i++) {
> >     mmap(NULL, 0x1000, (i&1)?PROT_READ:PROT_NONE,
> > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
> >   }
> >   int maps = open("/proc/self/maps", O_RDONLY);
> >   static char buf[0x100000];
> >   int res;
> >   do {
> >     res = read(maps, buf, sizeof(buf));
> >   } while (res > 0);
> > }
> > $ gcc -o map_lots_and_read_maps map_lots_and_read_maps.c
> > $ strace -e trace='!mmap' ./map_lots_and_read_maps
> > execve("./map_lots_and_read_maps", ["./map_lots_and_read_maps"],
> > 0x7ffebd297ac0 /* 51 vars */) = 0
> > brk(NULL)                               = 0x563a1184f000
> > access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
> > fstat(3, {st_mode=S_IFREG|0644, st_size=208479, ...}) = 0
> > close(3)                                = 0
> > openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
> > read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\320l\2\0\0\0\0\0"...,
> > 832) = 832
> > fstat(3, {st_mode=S_IFREG|0755, st_size=1820104, ...}) = 0
> > mprotect(0x7fb5c2d1a000, 1642496, PROT_NONE) = 0
> > close(3)                                = 0
> > arch_prctl(ARCH_SET_FS, 0x7fb5c2eb6500) = 0
> > mprotect(0x7fb5c2eab000, 12288, PROT_READ) = 0
> > mprotect(0x563a103e4000, 4096, PROT_READ) = 0
> > mprotect(0x7fb5c2f12000, 4096, PROT_READ) = 0
> > munmap(0x7fb5c2eb7000, 208479)          = 0
> > openat(AT_FDCWD, "/proc/self/maps", O_RDONLY) = 3
> > read(3, "563a103e1000-563a103e2000 r--p 0"..., 1048576) = 4075
> > read(3, "7fb5c2985000-7fb5c2986000 ---p 0"..., 1048576) = 4067
> > read(3, "7fb5c29d8000-7fb5c29d9000 r--p 0"..., 1048576) = 4067
> > read(3, "7fb5c2a2b000-7fb5c2a2c000 ---p 0"..., 1048576) = 4067
> > read(3, "7fb5c2a7e000-7fb5c2a7f000 r--p 0"..., 1048576) = 4067
> > read(3, "7fb5c2ad1000-7fb5c2ad2000 ---p 0"..., 1048576) = 4067
> > read(3, "7fb5c2b24000-7fb5c2b25000 r--p 0"..., 1048576) = 4067
> > read(3, "7fb5c2b77000-7fb5c2b78000 ---p 0"..., 1048576) = 4067
> > read(3, "7fb5c2bca000-7fb5c2bcb000 r--p 0"..., 1048576) = 4067
> > read(3, "7fb5c2c1d000-7fb5c2c1e000 ---p 0"..., 1048576) = 4067
> > read(3, "7fb5c2c70000-7fb5c2c71000 r--p 0"..., 1048576) = 4067
> > read(3, "7fb5c2cc3000-7fb5c2cc4000 ---p 0"..., 1048576) = 4078
> > read(3, "7fb5c2eca000-7fb5c2ecb000 r--p 0"..., 1048576) = 2388
> > read(3, "", 1048576)                    = 0
> > exit_group(0)                           = ?
> > +++ exited with 0 +++
> > $
> > ========================================
> > 
> > The kernel is randomly returning short reads *with different lengths*
> > that are vaguely around PAGE_SIZE, no matter how big the buffer
> > supplied by userspace is. And while repeated read() calls will return
> > consistent state thanks to the seqfile magic, repeated readfile()
> > calls will probably return garbage with half-complete lines.
> 
> Ah crap, I forgot about seqfile, I was only considering the "simple"
> cases that sysfs provides.
> 
> Ok, Miklos, you were totally right, I'll loop and read until the end of
> file or buffer, which ever comes first.

Hm, nope, this works just fine with the single "read" call.  I can read
/proc/self/maps with a single buffer, also larger files like
/sys/kernel/debug/usb/devices work just fine.

So maybe it is all sane without a loop.

I'll try to get rid of the fd now, and despite the interest in io_uring,
this might be a lot more "simple" overall.

thanks,

greg k-h
