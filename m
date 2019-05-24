Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92263295D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2019 12:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390476AbfEXKbt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 May 2019 06:31:49 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55264 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390475AbfEXKbt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 May 2019 06:31:49 -0400
Received: by mail-it1-f195.google.com with SMTP id h20so14899112itk.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 May 2019 03:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t6QPS5lwd7cr471Dg03A0AXuNJ/CrzRoO1xYODuKhbA=;
        b=Vxe1OcgbXiqgWJS2x6TaYm+Cn6jhah0Qj5bXPrvsCh/P7F74y/HXVPKJgfba1esHAh
         pwR5mq5lwAljwztFYdwuQRV8yQdOUdArsoOfy733CwBcrJjtFBZmm+2psNdK9a0f6LRt
         rLVXaIubfp97S/kaUSegG/zw06TKZWV2uGoYdfz/HBZMYvpqO26ETRVlzOvec4BsvfMF
         b/tEWUN6EkieS8aeK40Tf6C3HdOU3ue/E/Pe+SN7+Bn/JSvbY38QUqiXMJBvf9Eosi4J
         jqg/ZTc6HhZAgAgv8MD/8YVQKF6dun5zVxcWHFX4FzRjCjDe6ZiDbFDHVp+8BPV1oxjx
         me4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t6QPS5lwd7cr471Dg03A0AXuNJ/CrzRoO1xYODuKhbA=;
        b=K+neRaQZlHWVdhqJJRrXL6WEjpl+oWrHomr4/qHFT7l+vaf3r2UWjMshjc1/QlKIRr
         ID//tNJTJYBS7yDxzRj7EkWQ7h+ozjSoA0W2grYKlJG+KgbaioPkSh3iL1zWrIDxDJVO
         bOQRn8najp/6e/goZmQqkGK0QYrC5QRCB0udAPnZp+meXuUtRTYPJz4WYGpcc8jIHyLE
         QI75nrT8xhmlDyz6BdNedLfYyhuF2HFT5ZEaojdm9xAbA0Af0rkXr6nyPHxY5tLs2yp/
         lBGfTlvlr3L13evLkqIIT09yhCl4YYPHv90T+dNCDEWDjsviMbSlq/yg0pM9bAsgv1IE
         X7ZA==
X-Gm-Message-State: APjAAAUs4eDnVNV53u8HgzfY9Sqb/YSqV+hDTSvFCDPX4K/runWdzNKP
        pkvIBIq/xcDnEG85/GEDX0qmRA==
X-Google-Smtp-Source: APXvYqzsmLzfolt9XPm7istwtQ8OTvFuPcrdmMMZuaT+6LV9wiCluPiGeCgPdZY3zO0tzizi0DzZng==
X-Received: by 2002:a24:28c1:: with SMTP id h184mr18752225ith.105.1558693908188;
        Fri, 24 May 2019 03:31:48 -0700 (PDT)
Received: from brauner.io ([172.56.12.37])
        by smtp.gmail.com with ESMTPSA id p2sm1028528itb.29.2019.05.24.03.31.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 24 May 2019 03:31:47 -0700 (PDT)
Date:   Fri, 24 May 2019 12:31:39 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        torvalds@linux-foundation.org, fweimer@redhat.com,
        jannh@google.com, oleg@redhat.com, tglx@linutronix.de,
        arnd@arndb.de, shuah@kernel.org, dhowells@redhat.com,
        tkjos@android.com, ldv@altlinux.org, miklos@szeredi.hu,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v1 1/2] open: add close_range()
Message-ID: <20190524103137.otw7tbmagiqnf6u6@brauner.io>
References: <20190522155259.11174-1-christian@brauner.io>
 <67e4458a-9cc4-d1aa-608c-73ebe9e2f7a3@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67e4458a-9cc4-d1aa-608c-73ebe9e2f7a3@yandex-team.ru>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 07:22:17PM +0300, Konstantin Khlebnikov wrote:
> On 22.05.2019 18:52, Christian Brauner wrote:> This adds the close_range() syscall. It allows to efficiently close a range
> > of file descriptors up to all file descriptors of a calling task.
> >
> > The syscall came up in a recent discussion around the new mount API and
> > making new file descriptor types cloexec by default. During this
> > discussion, Al suggested the close_range() syscall (cf. [1]). Note, a
> > syscall in this manner has been requested by various people over time.
> >
> > First, it helps to close all file descriptors of an exec()ing task. This
> > can be done safely via (quoting Al's example from [1] verbatim):
> >
> >          /* that exec is sensitive */
> >          unshare(CLONE_FILES);
> >          /* we don't want anything past stderr here */
> >          close_range(3, ~0U);
> >          execve(....);
> >
> > The code snippet above is one way of working around the problem that file
> > descriptors are not cloexec by default. This is aggravated by the fact that
> > we can't just switch them over without massively regressing userspace. For
> > a whole class of programs having an in-kernel method of closing all file
> > descriptors is very helpful (e.g. demons, service managers, programming
> > language standard libraries, container managers etc.).
> > (Please note, unshare(CLONE_FILES) should only be needed if the calling
> >   task is multi-threaded and shares the file descriptor table with another
> >   thread in which case two threads could race with one thread allocating
> >   file descriptors and the other one closing them via close_range(). For the
> >   general case close_range() before the execve() is sufficient.)
> >
> > Second, it allows userspace to avoid implementing closing all file
> > descriptors by parsing through /proc/<pid>/fd/* and calling close() on each
> > file descriptor. From looking at various large(ish) userspace code bases
> > this or similar patterns are very common in:
> > - service managers (cf. [4])
> > - libcs (cf. [6])
> > - container runtimes (cf. [5])
> > - programming language runtimes/standard libraries
> >    - Python (cf. [2])
> >    - Rust (cf. [7], [8])
> > As Dmitry pointed out there's even a long-standing glibc bug about missing
> > kernel support for this task (cf. [3]).
> > In addition, the syscall will also work for tasks that do not have procfs
> > mounted and on kernels that do not have procfs support compiled in. In such
> > situations the only way to make sure that all file descriptors are closed
> > is to call close() on each file descriptor up to UINT_MAX or RLIMIT_NOFILE,
> > OPEN_MAX trickery (cf. comment [8] on Rust).
> >
> > The performance is striking. For good measure, comparing the following
> > simple close_all_fds() userspace implementation that is essentially just
> > glibc's version in [6]:
> >
> > static int close_all_fds(void)
> > {
> >          int dir_fd;
> >          DIR *dir;
> >          struct dirent *direntp;
> >
> >          dir = opendir("/proc/self/fd");
> >          if (!dir)
> >                  return -1;
> >          dir_fd = dirfd(dir);
> >          while ((direntp = readdir(dir))) {
> >                  int fd;
> >                  if (strcmp(direntp->d_name, ".") == 0)
> >                          continue;
> >                  if (strcmp(direntp->d_name, "..") == 0)
> >                          continue;
> >                  fd = atoi(direntp->d_name);
> >                  if (fd == dir_fd || fd == 0 || fd == 1 || fd == 2)
> >                          continue;
> >                  close(fd);
> >          }
> >          closedir(dir);
> >          return 0;
> > }
> >
> > to close_range() yields:
> > 1. closing 4 open files:
> >     - close_all_fds(): ~280 us
> >     - close_range():    ~24 us
> >
> > 2. closing 1000 open files:
> >     - close_all_fds(): ~5000 us
> >     - close_range():   ~800 us
> >
> > close_range() is designed to allow for some flexibility. Specifically, it
> > does not simply always close all open file descriptors of a task. Instead,
> > callers can specify an upper bound.
> > This is e.g. useful for scenarios where specific file descriptors are
> > created with well-known numbers that are supposed to be excluded from
> > getting closed.
> > For extra paranoia close_range() comes with a flags argument. This can e.g.
> > be used to implement extension. Once can imagine userspace wanting to stop
> > at the first error instead of ignoring errors under certain circumstances.
> 
> > There might be other valid ideas in the future. In any case, a flag
> > argument doesn't hurt and keeps us on the safe side.
> 
> Here is another strange but real-live scenario: crash handler for dumping core.
> 
> If applications has network connections it would be better to close them all,
> otherwise clients will wait until end of dumping process or timeout.
> Also closing normal files might be a good idea for releasing locks.
> 
> But simple closing might race with other threads - closed fd will be reused
> while some code still thinks it refers to original file.
> 
> Our solution closes files without freeing fd: it opens /dev/null and
> replaces all opened descriptors using dup2.
> 
> So, special flag for close_range() could close files without clearing bitmap.
> Effect should be the same - fd wouldn't be reused.
> 
> Actually two flags for two phases: closing files and releasing fd.

Konstantin, I'm sorry, I totally missed that part of your mail
yesterday.
Without speaking to the feasibility of this it's at least a good
illustration that people really do have the possible need for a flag
argument.

Thanks!
Christian
