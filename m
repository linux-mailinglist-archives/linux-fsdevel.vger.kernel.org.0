Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998211B53C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 06:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgDWEmg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 00:42:36 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:41873 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgDWEmg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 00:42:36 -0400
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 4D0E620004;
        Thu, 23 Apr 2020 04:42:28 +0000 (UTC)
Date:   Wed, 22 Apr 2020 21:42:26 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>, io-uring@vger.kernel.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] fs: openat2: Extend open_how to allow
 userspace-selected fds
Message-ID: <20200423044226.GH161058@localhost>
References: <cover.1587531463.git.josh@joshtriplett.org>
 <9873b8bd7d14ff8cd2a5782b434b39f076679eeb.1587531463.git.josh@joshtriplett.org>
 <CAKgNAkjo3AeA78XqK-RRGqJHNy1H8SbcjQQQs7+jDwuFgq4YSg@mail.gmail.com>
 <CAJfpegt=xe-8AayW2i3AYrk3q-=Pp_A+Hctsk+=sXoMed5hFQA@mail.gmail.com>
 <20200423004807.GC161058@localhost>
 <CAJfpegtSYKsApx2Dc6VGmc5Fm4SsxtAWAP-Zs052umwK1CjJmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtSYKsApx2Dc6VGmc5Fm4SsxtAWAP-Zs052umwK1CjJmQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 23, 2020 at 06:24:14AM +0200, Miklos Szeredi wrote:
> On Thu, Apr 23, 2020 at 2:48 AM Josh Triplett <josh@joshtriplett.org> wrote:
> > On Wed, Apr 22, 2020 at 09:55:56AM +0200, Miklos Szeredi wrote:
> > > On Wed, Apr 22, 2020 at 8:06 AM Michael Kerrisk (man-pages)
> > > <mtk.manpages@gmail.com> wrote:
> > > >
> > > > [CC += linux-api]
> > > >
> > > > On Wed, 22 Apr 2020 at 07:20, Josh Triplett <josh@joshtriplett.org> wrote:
> > > > >
> > > > > Inspired by the X protocol's handling of XIDs, allow userspace to select
> > > > > the file descriptor opened by openat2, so that it can use the resulting
> > > > > file descriptor in subsequent system calls without waiting for the
> > > > > response to openat2.
> > > > >
> > > > > In io_uring, this allows sequences like openat2/read/close without
> > > > > waiting for the openat2 to complete. Multiple such sequences can
> > > > > overlap, as long as each uses a distinct file descriptor.
> > >
> > > If this is primarily an io_uring feature, then why burden the normal
> > > openat2 API with this?
> >
> > This feature was inspired by io_uring; it isn't exclusively of value
> > with io_uring. (And io_uring doesn't normally change the semantics of
> > syscalls.)
> 
> What's the use case of O_SPECIFIC_FD beyond io_uring?

Avoiding a call to dup2 and close, if you need something as a specific
file descriptor, such as when setting up to exec something, or when
debugging a program.

I don't expect it to be as widely used as with io_uring, but I also
don't want io_uring versions of syscalls to diverge from the underlying
syscalls, and this would be a heavy divergence.

> > > This would also allow Implementing a private fd table for io_uring.
> > > I.e. add a flag interpreted by file ops (IORING_PRIVATE_FD), including
> > > openat2 and freely use the private fd space without having to worry
> > > about interactions with other parts of the system.
> >
> > I definitely don't want to add a special kind of file descriptor that
> > doesn't work in normal syscalls taking file descriptors. A file
> > descriptor allocated via O_SPECIFIC_FD is an entirely normal file
> > descriptor, and works anywhere a file descriptor normally works.
> 
> What's the use case of allocating a file descriptor within io_uring
> and using it outside of io_uring?

Calling a syscall not provided via io_uring. Calling a library that
doesn't use io_uring. Passing the file descriptor via UNIX socket to
another program. Passing the file descriptor via exec to another
program. Userspace is modular, and file descriptors are widely used.
