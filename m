Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E92C17769C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 14:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgCCNDv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 08:03:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:49700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729249AbgCCNDu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 08:03:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36E6D20866;
        Tue,  3 Mar 2020 13:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583240629;
        bh=f5TALLM7M04mw4MFMI6suvBwcBH6Hd4opudh07oYOZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HGZKD28dn34LE53PY7JnKdnnaep5PxSNdTqI9Rf14XPqJI6mRPHPh6qiVXbKKyccK
         Cs5GgBp32G+tzfpxv+05TCf4nQAoKK71wdKCP/p860chfn/v9IsbG7IAEwh+XTdJig
         iBvKRptwEaPe33EjTDzrITZpsidZvqdzKAdmvw2g=
Date:   Tue, 3 Mar 2020 14:03:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Karel Zak <kzak@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
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
Message-ID: <20200303130347.GA2302029@kroah.com>
References: <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com>
 <1582644535.3361.8.camel@HansenPartnership.com>
 <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein>
 <107666.1582907766@warthog.procyon.org.uk>
 <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <1509948.1583226773@warthog.procyon.org.uk>
 <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
 <20200303113814.rsqhljkch6tgorpu@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303113814.rsqhljkch6tgorpu@ws.net.home>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 03, 2020 at 12:38:14PM +0100, Karel Zak wrote:
> On Tue, Mar 03, 2020 at 10:26:21AM +0100, Miklos Szeredi wrote:
> > No, I don't think this is going to be a performance issue at all, but
> > if anything we could introduce a syscall
> > 
> >   ssize_t readfile(int dfd, const char *path, char *buf, size_t
> > bufsize, int flags);
> 
> off-topic, but I'll buy you many many beers if you implement it ;-),
> because open + read + close is pretty common for /sys and /proc in
> many userspace tools; for example ps, top, lsblk, lsmem, lsns, udevd
> etc. is all about it.

Unlimited beers for a 21-line kernel patch?  Sign me up!

Totally untested, barely compiled patch below.

Actually, I like this idea (the syscall, not just the unlimited beers).
Maybe this could make a lot of sense, I'll write some actual tests for
it now that syscalls are getting "heavy" again due to CPU vendors
finally paying the price for their madness...

thanks,

greg k-h
-------------------


diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 44d510bc9b78..178cd45340e2 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -359,6 +359,7 @@
 435	common	clone3			__x64_sys_clone3/ptregs
 437	common	openat2			__x64_sys_openat2
 438	common	pidfd_getfd		__x64_sys_pidfd_getfd
+439	common	readfile		__x86_sys_readfile
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/open.c b/fs/open.c
index 0788b3715731..1a830fada750 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1340,3 +1340,23 @@ int stream_open(struct inode *inode, struct file *filp)
 }
 
 EXPORT_SYMBOL(stream_open);
+
+SYSCALL_DEFINE5(readfile, int, dfd, const char __user *, filename,
+		char __user *, buffer, size_t, bufsize, int, flags)
+{
+	int retval;
+	int fd;
+
+	if (force_o_largefile())
+		flags |= O_LARGEFILE;
+
+	fd = do_sys_open(dfd, filename, flags, O_RDONLY);
+	if (fd <= 0)
+		return fd;
+
+	retval = ksys_read(fd, buffer, bufsize);
+
+	__close_fd(current->files, fd);
+
+	return retval;
+}
