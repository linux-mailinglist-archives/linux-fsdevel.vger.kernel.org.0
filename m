Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 501FA17786E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 15:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbgCCOKd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 09:10:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:50300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728539AbgCCOKd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:10:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D33D220848;
        Tue,  3 Mar 2020 14:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583244632;
        bh=9Jfg6HbsgoSWln6NNn9YML4X0iSDZRQBv27wug5xFB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0Lvg4+Gpu+ht0zZ2A+IIL6k3suH/0xmPYguJPSvELQeVGX5ZJ4Ci4nR3cajkOc7kZ
         TSprDYs0mDay4u0BKhL88vH5BZMCZEERLOKu6ufN7mHM+knwqPu57q2i/cy3dnFYxi
         TCOmgtjx3zErfoIVtVeywP7qd4LiiB9zD5V87UzY=
Date:   Tue, 3 Mar 2020 15:10:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Karel Zak <kzak@redhat.com>, David Howells <dhowells@redhat.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
Message-ID: <20200303141030.GA2811@kroah.com>
References: <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <1509948.1583226773@warthog.procyon.org.uk>
 <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
 <20200303113814.rsqhljkch6tgorpu@ws.net.home>
 <20200303130347.GA2302029@kroah.com>
 <20200303131434.GA2373427@kroah.com>
 <CAJfpegt0aQVvoDeBXOu2xZh+atZQ+q5uQ_JRxe46E8cZ7sHRwg@mail.gmail.com>
 <20200303134316.GA2509660@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303134316.GA2509660@kroah.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 03, 2020 at 02:43:16PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 03, 2020 at 02:34:42PM +0100, Miklos Szeredi wrote:
> > On Tue, Mar 3, 2020 at 2:14 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > 
> > > > Unlimited beers for a 21-line kernel patch?  Sign me up!
> > > >
> > > > Totally untested, barely compiled patch below.
> > >
> > > Ok, that didn't even build, let me try this for real now...
> > 
> > Some comments on the interface:
> 
> Ok, hey, let's do this proper :)

Alright, how about this patch.

Actually tested with some simple sysfs files.

If people don't strongly object, I'll add "real" tests to it, hook it up
to all arches, write a manpage, and all the fun fluff a new syscall
deserves and submit it "for real".

It feels like I'm doing something wrong in that the actuall syscall
logic is just so small.  Maybe I'll benchmark this thing to see if it
makes any real difference...

thanks,

greg k-h

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] readfile: implement readfile syscall

It's a tiny syscall, meant to allow a user to do a single "open this
file, read into this buffer, and close the file" all in a single shot.

Should be good for reading "tiny" files like sysfs, procfs, and other
"small" files.

There is no restarting the syscall, am trying to keep it simple.  At
least for now.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/entry/syscalls/syscall_32.tbl |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 fs/open.c                              | 21 +++++++++++++++++++++
 include/linux/syscalls.h               |  2 ++
 include/uapi/asm-generic/unistd.h      |  4 +++-
 5 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index c17cb77eb150..a79cd025e72b 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -442,3 +442,4 @@
 435	i386	clone3			sys_clone3			__ia32_sys_clone3
 437	i386	openat2			sys_openat2			__ia32_sys_openat2
 438	i386	pidfd_getfd		sys_pidfd_getfd			__ia32_sys_pidfd_getfd
+439	i386	readfile		sys_readfile			__ia32_sys_readfile
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 44d510bc9b78..4f518f4e0e30 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -359,6 +359,7 @@
 435	common	clone3			__x64_sys_clone3/ptregs
 437	common	openat2			__x64_sys_openat2
 438	common	pidfd_getfd		__x64_sys_pidfd_getfd
+439	common	readfile		__x64_sys_readfile
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/open.c b/fs/open.c
index 0788b3715731..109bad47d542 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1340,3 +1340,24 @@ int stream_open(struct inode *inode, struct file *filp)
 }
 
 EXPORT_SYMBOL(stream_open);
+
+SYSCALL_DEFINE5(readfile, int, dfd, const char __user *, filename,
+		char __user *, buffer, size_t, bufsize, int, flags)
+{
+	int retval;
+	int fd;
+
+	/* Mask off all O_ flags as we only want to read from the file */
+	flags &= ~(VALID_OPEN_FLAGS);
+	flags |= O_RDONLY | O_LARGEFILE;
+
+	fd = do_sys_open(dfd, filename, flags, 0000);
+	if (fd <= 0)
+		return fd;
+
+	retval = ksys_read(fd, buffer, bufsize);
+
+	__close_fd(current->files, fd);
+
+	return retval;
+}
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 1815065d52f3..3a636a913437 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1003,6 +1003,8 @@ asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 				       siginfo_t __user *info,
 				       unsigned int flags);
 asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
+asmlinkage long sys_readfile(int dfd, const char __user *filename,
+			     char __user *buffer, size_t bufsize, int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 3a3201e4618e..31f84500915d 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -855,9 +855,11 @@ __SYSCALL(__NR_clone3, sys_clone3)
 __SYSCALL(__NR_openat2, sys_openat2)
 #define __NR_pidfd_getfd 438
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
+#define __NR_readfile 439
+__SYSCALL(__NR_readfile, sys_readfile)
 
 #undef __NR_syscalls
-#define __NR_syscalls 439
+#define __NR_syscalls 440
 
 /*
  * 32 bit systems traditionally used different
-- 
2.25.1

