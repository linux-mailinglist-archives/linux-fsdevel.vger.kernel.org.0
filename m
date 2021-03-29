Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E85B34CCEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Mar 2021 11:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhC2JVt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 05:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231490AbhC2JVe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 05:21:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBE8761934;
        Mon, 29 Mar 2021 09:21:31 +0000 (UTC)
Date:   Mon, 29 Mar 2021 11:21:29 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in filp_close (2)
Message-ID: <20210329092129.g425sscvyfagig7f@wittgenstein>
References: <00000000000069c40405be6bdad4@google.com>
 <CACT4Y+baP24jKmj-trhF8bG_d_zkz8jN7L1kYBnUR=EAY6hOaA@mail.gmail.com>
 <20210326091207.5si6knxs7tn6rmod@wittgenstein>
 <CACT4Y+atQdf_fe3BPFRGVCzT1Ba3V_XjAo6XsRciL8nwt4wasw@mail.gmail.com>
 <CAHrFyr7iUpMh4sicxrMWwaUHKteU=qHt-1O-3hojAAX3d5879Q@mail.gmail.com>
 <20210326135011.wscs4pxal7vvsmmw@wittgenstein>
 <YF/A0eZdQwi0/PJU@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YF/A0eZdQwi0/PJU@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 27, 2021 at 11:33:37PM +0000, Al Viro wrote:
> On Fri, Mar 26, 2021 at 02:50:11PM +0100, Christian Brauner wrote:
> > @@ -632,6 +632,7 @@ EXPORT_SYMBOL(close_fd); /* for ksys_close() */
> >  static inline void __range_cloexec(struct files_struct *cur_fds,
> >  				   unsigned int fd, unsigned int max_fd)
> >  {
> > +	unsigned int cur_max;
> >  	struct fdtable *fdt;
> >  
> >  	if (fd > max_fd)
> > @@ -639,7 +640,12 @@ static inline void __range_cloexec(struct files_struct *cur_fds,
> >  
> >  	spin_lock(&cur_fds->file_lock);
> >  	fdt = files_fdtable(cur_fds);
> > -	bitmap_set(fdt->close_on_exec, fd, max_fd - fd + 1);
> > +	/* make very sure we're using the correct maximum value */
> > +	cur_max = fdt->max_fds;
> > +	cur_max--;
> > +	cur_max = min(max_fd, cur_max);
> > +	if (fd <= cur_max)
> > +		bitmap_set(fdt->close_on_exec, fd, cur_max - fd + 1);
> >  	spin_unlock(&cur_fds->file_lock);
> >  }
> 
> Umm...  That's harder to follow than it ought to be.  What's the point of
> having
>         max_fd = min(max_fd, cur_max);
> done in the caller, anyway?  Note that in __range_close() you have to
> compare with re-fetched ->max_fds (look at pick_file()), so...

Yeah, I'll massage that patch a bit. I wanted to know whether this fixes
the issue first though.

> 
> BTW, I really wonder if the cost of jerking ->file_lock up and down
> in that loop in __range_close() is negligible.  What values do we

Just for the record, I remember you pointing at that originally. Linus
argued that this likely wasn't going to be a problem and that if people
see performance hits we'll optimize.

> typically get from callers and how sparse does descriptor table tend
> to be for those?

Weirdly, I can actually somewhat answer that question since I tend to
regularly "survey" large userspace projects I know or am involved in
that adopt new APIs we added just to see how they use it.

A few users:
1. crun
   https://github.com/containers/crun/blob/a1c0ef1b886ca30c2fb0906c7c43be04b555c52c/src/libcrun/utils.c#L1490
   ret = syscall_close_range (n, UINT_MAX, CLOSE_RANGE_CLOEXEC);

2. LXD
   https://github.com/lxc/lxd/blob/f12f03a4ba4645892ef6cc167c24da49d1217b02/lxd/main_forkexec.go#L293
   ret = close_range(EXEC_PIPE_FD + 1, UINT_MAX, CLOSE_RANGE_UNSHARE);

3. LXC
   https://github.com/lxc/lxc/blob/1718e6d6018d5d6072a01d92a11d5aafc314f98f/src/lxc/rexec.c#L165
   ret = close_range(STDERR_FILENO + 1, MAX_FILENO, CLOSE_RANGE_CLOEXEC);

Of these three 1. and 3. don't matter because they rely on
CLOSE_RANGE_CLOEXEC and exec.
For 2. I can say that the fdtable is likely going to be sparse.
close_range() here is basically used to prevent accidental fd leaks
across an exec. So 2. should never have more > 4 file. In fact, this
could and should probably be switched to CLOSE_RANGE_CLOEXEC too.

The next two cases might be more interesting:

4. systemd
   - https://github.com/systemd/systemd/blob/fe96c0f86d15e844d74d539c6cff7f971078cf84/src/basic/fd-util.c#L228
     close_range(3, -1, 0)
   - https://github.com/systemd/systemd/blob/fe96c0f86d15e844d74d539c6cff7f971078cf84/src/basic/fd-util.c#L271
     https://github.com/systemd/systemd/blob/fe96c0f86d15e844d74d539c6cff7f971078cf84/src/basic/fd-util.c#L288
     /* Close everything between the start and end fds (both of which shall stay open) */
     if (close_range(start + 1, end - 1, 0) < 0) {
     if (close_range(sorted[n_sorted-1] + 1, -1, 0) >= 0)

5. Python
   https://github.com/python/cpython/blob/9976834f807ea63ca51bc4f89be457d734148682/Python/fileutils.c#L2250

systemd has the regular case that others have too where it simply closes
all fds over 3 and it also has the more complicated case where it has an
ordered array of fds closing up to the lower bound and after the upper
bound up to the maximum. PID 1 can have a large number of fds open
because of socket activation so here close_range() will encounter less
sparse fd tables where it needs to close a lot of fds.

For Python's os.closerange() implementation which depends on our syscall
it's harder to say given that this will be used by a lot of projects but
I would _guess_ that if people use closerange() they do so because they
actually have something to close.

In short, I would think that close_range() without the
CLOSE_RANGE_CLOEXEC feature will usually be used in scenarios where
there's work to be done, i.e. where the caller likely knows that they
might inherit a non-trivial number of file descriptors (usually after a
fork) that they want to close and they want to do it either because they
don't exec or they don't know when they'll exec. All others I'd expect
to switch to CLOSE_RANGE_CLOEXEC on kernels where it's supported.

Christian
