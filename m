Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD3A1B548B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 08:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgDWGEl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 02:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726346AbgDWGEi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 02:04:38 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EA4C08E859
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2020 23:04:38 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id k22so3443079eds.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2020 23:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iJwaTH8LkE8SYFlauVNm3KSXFSKFJXUbSfiZFZKke1g=;
        b=Qwh3upICI/1MLSvIIFDHEVl4679/BheYiJokF6SxrCKujHxyCIMyVvJMtul8/kIzXR
         jzWsdyckkaFni2N5FXBXqI0PdYGeJ+24CGO8SlMIeErnoLWrSSxJHi2Ts5U81nSumB37
         na1q/xSG8NEuO3HU4zpcOtR/g9tX27egrfS3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iJwaTH8LkE8SYFlauVNm3KSXFSKFJXUbSfiZFZKke1g=;
        b=j9G5hokJ5Eu6xSFEXbyM5sYQ1q7+RQa9YqwKPE1ql6bHgXLHT4K6wqAKcXgiuhIZ5E
         536RhRWt0k/RhYCeLPUOl76H3CZbiffqUbWleWuzL+cfYU/G3vaTaCuMXc4TJrgwif8i
         ca7MsTg73ZmVLpdpoQeRxhyIyrmuG0VyD1TAUOFNNB6QtB4c4f4nnDEhpHgirApDoQjN
         UU1V6NYY9hrH5XvUk8sUJc5V22qplC79DIw58W5nKobKo++917/yHyynSuj7OQAUEQZc
         K8k4ZifzogJD/IQAG+qxsXKomGxbesh0WWXqh8IzM+WvAJy9pCXBaOY/mXA2lK23D3WE
         1ovg==
X-Gm-Message-State: AGi0Pubq3o5TBqtXnPGN9xLYSsbmL6wAJPQ2PqVp2rfCVSjxMG4c7ZnL
        oSB3Bel6WNJ3uYkzrmBAhR5SIdhu7HPpxYtMtpU/tg==
X-Google-Smtp-Source: APiQypJl3K/2JBPEthRtkXbw2unzB+VN2R/MXP5Wu9FojQX2m1MempnZ9A91dFlTJEVVFJbAKIYnHMrAACl4CkwwCHs=
X-Received: by 2002:aa7:c312:: with SMTP id l18mr1529317edq.161.1587621876304;
 Wed, 22 Apr 2020 23:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587531463.git.josh@joshtriplett.org> <9873b8bd7d14ff8cd2a5782b434b39f076679eeb.1587531463.git.josh@joshtriplett.org>
 <CAKgNAkjo3AeA78XqK-RRGqJHNy1H8SbcjQQQs7+jDwuFgq4YSg@mail.gmail.com>
 <CAJfpegt=xe-8AayW2i3AYrk3q-=Pp_A+Hctsk+=sXoMed5hFQA@mail.gmail.com>
 <20200423004807.GC161058@localhost> <CAJfpegtSYKsApx2Dc6VGmc5Fm4SsxtAWAP-Zs052umwK1CjJmQ@mail.gmail.com>
 <20200423044226.GH161058@localhost>
In-Reply-To: <20200423044226.GH161058@localhost>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 23 Apr 2020 08:04:25 +0200
Message-ID: <CAJfpeguaVYo-Lf-5Bi=EYJYWdmCfo3BqZA=kj9E5UmDb0mBc1w@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fs: openat2: Extend open_how to allow
 userspace-selected fds
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>, io-uring@vger.kernel.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 23, 2020 at 6:42 AM Josh Triplett <josh@joshtriplett.org> wrote:
>
> On Thu, Apr 23, 2020 at 06:24:14AM +0200, Miklos Szeredi wrote:
> > On Thu, Apr 23, 2020 at 2:48 AM Josh Triplett <josh@joshtriplett.org> wrote:
> > > On Wed, Apr 22, 2020 at 09:55:56AM +0200, Miklos Szeredi wrote:
> > > > On Wed, Apr 22, 2020 at 8:06 AM Michael Kerrisk (man-pages)
> > > > <mtk.manpages@gmail.com> wrote:
> > > > >
> > > > > [CC += linux-api]
> > > > >
> > > > > On Wed, 22 Apr 2020 at 07:20, Josh Triplett <josh@joshtriplett.org> wrote:
> > > > > >
> > > > > > Inspired by the X protocol's handling of XIDs, allow userspace to select
> > > > > > the file descriptor opened by openat2, so that it can use the resulting
> > > > > > file descriptor in subsequent system calls without waiting for the
> > > > > > response to openat2.
> > > > > >
> > > > > > In io_uring, this allows sequences like openat2/read/close without
> > > > > > waiting for the openat2 to complete. Multiple such sequences can
> > > > > > overlap, as long as each uses a distinct file descriptor.
> > > >
> > > > If this is primarily an io_uring feature, then why burden the normal
> > > > openat2 API with this?
> > >
> > > This feature was inspired by io_uring; it isn't exclusively of value
> > > with io_uring. (And io_uring doesn't normally change the semantics of
> > > syscalls.)
> >
> > What's the use case of O_SPECIFIC_FD beyond io_uring?
>
> Avoiding a call to dup2 and close, if you need something as a specific
> file descriptor, such as when setting up to exec something, or when
> debugging a program.
>
> I don't expect it to be as widely used as with io_uring, but I also
> don't want io_uring versions of syscalls to diverge from the underlying
> syscalls, and this would be a heavy divergence.

What are the plans for those syscalls that don't easily lend
themselves to this modification (such as accept(2))?  Do we want to
introduce another variant of these?  Is that really worth it?  If not,
we are faced with the same divergence.

Compared to that, having a common flag for file ops to enable the use
of fixed and private file descriptors is a clean and well contained
interface.

> > > > This would also allow Implementing a private fd table for io_uring.
> > > > I.e. add a flag interpreted by file ops (IORING_PRIVATE_FD), including
> > > > openat2 and freely use the private fd space without having to worry
> > > > about interactions with other parts of the system.
> > >
> > > I definitely don't want to add a special kind of file descriptor that
> > > doesn't work in normal syscalls taking file descriptors. A file
> > > descriptor allocated via O_SPECIFIC_FD is an entirely normal file
> > > descriptor, and works anywhere a file descriptor normally works.
> >
> > What's the use case of allocating a file descriptor within io_uring
> > and using it outside of io_uring?
>
> Calling a syscall not provided via io_uring. Calling a library that
> doesn't use io_uring. Passing the file descriptor via UNIX socket to
> another program. Passing the file descriptor via exec to another
> program. Userspace is modular, and file descriptors are widely used.

I mean, you could open the file descriptor outside of io_uring in such
cases, no?  The point of O_SPECIFIC_FD is to be able to perform short
sequences of open/dosomething/close without having to block and having
to issue separate syscalls.  If you're going to issue separate
syscalls anyway, then I see no point in doing the open within
io_uring.  Or?

Thanks,
Miklos
