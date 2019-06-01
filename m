Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4260731A07
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2019 09:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfFAHWD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Jun 2019 03:22:03 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36677 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfFAHWD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Jun 2019 03:22:03 -0400
Received: by mail-yb1-f195.google.com with SMTP id y2so4520838ybo.3;
        Sat, 01 Jun 2019 00:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eK3RUPlfG8RZUzkSszXzsM4RVb9xYeD1FoLiIv9fPTw=;
        b=CvTTzK8izg+oML32UowEdMvOxWOKiM8AGVdZTsmzRuc9TaP2GTIJRhfXr7oQ5anQrs
         WiVfdg7n82Z2+BK7lhcnFALQkXLFwaBVVrA1D+O2hZPE0v7UWpXDWBf0aAqfAgOEjBcu
         3qhOuqmvY9VmlQi1gobAnz42m+5H0UePdFbdyYAMB/+keRGlot0UcsVXQble3HB51h4/
         Obu6mupxiTgamyP1VlOiOaUvy3QqqlqmuJKIhl8Qh9fNo0VM5m6To40dFr+reomFCClx
         obyuvVvvqxlUWg92CdFm52LhD3U3+nQc4ufZvrzIpIkhjXIdqM25XStaQxo5/RxpUsPN
         v5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eK3RUPlfG8RZUzkSszXzsM4RVb9xYeD1FoLiIv9fPTw=;
        b=UuKmku8HhVkD1jt8Vz0GW5eVhwV/Kg46Yn+PRkhX180EBE9v+wl/X6ioVFiSvXBT7z
         uYH9mfz/3kY6JKt71776atnfpxaWiV5PHujN+kyRNscCM09J4XZ1MCfpogQpz8sIw1/4
         oqBjpnqn/qQcvKdOf9n79wNuFJe+jPUlE21sb7ZN3J4BSfpsjjbEOK3ukOhR2iNLhRJt
         NJL8caAp9dBUjCMpVKP0pPMVeqQ6spNeJFOuo9aduVUqagZADgCl8RDQRKSuJDUcf46O
         gvFdOcCcLvZPJtGH4KG3ogBK5M4+1vbO1LlgqTsOTuviYimvj7tR2Olr8HQGcddGy5PI
         NrqA==
X-Gm-Message-State: APjAAAUH5dm7n1u1JANL19sE8zclxXnyaeD+gvq+QxGiQsnJcwVY+eAA
        t7BJDNLbUuxoO2os7gGZeBUoDIsV9/vCmndHjnQ=
X-Google-Smtp-Source: APXvYqzMHREZD+rkeGcCRwcs0OriuzNy8z8/GjgpQOS1zUt0AuVe4vbsOVZHuz4n54WKpFfg3l+bJMDA35CavTB4rWo=
X-Received: by 2002:a05:6902:4c3:: with SMTP id v3mr7044274ybs.144.1559373721370;
 Sat, 01 Jun 2019 00:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190527172655.9287-1-amir73il@gmail.com> <20190528202659.GA12412@mit.edu>
 <CAOQ4uxgo5jmwQbLAKQre9=7pLQw=CwMgDaWPaJxi-5NGnPEVPQ@mail.gmail.com>
 <CAOQ4uxgj94WR82iHE4PDGSD0UDxG5sCtr+Sv+t1sOHHmnXFYzQ@mail.gmail.com>
 <20190531164136.GA3066@mit.edu> <20190531224549.GF29573@dread.disaster.area>
In-Reply-To: <20190531224549.GF29573@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 1 Jun 2019 10:21:49 +0300
Message-ID: <CAOQ4uxjeGxNsjT9N_X6W+mVbvn2kTaoeLE-tXVYq0-3MwC_+Xg@mail.gmail.com>
Subject: Re: [RFC][PATCH] link.2: AT_ATOMIC_DATA and AT_ATOMIC_METADATA
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Chris Mason <clm@fb.com>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ric Wheeler <rwheeler@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 1, 2019 at 1:46 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Fri, May 31, 2019 at 12:41:36PM -0400, Theodore Ts'o wrote:
> > On Fri, May 31, 2019 at 06:21:45PM +0300, Amir Goldstein wrote:
> > > What do you think of:
> > >
> > > "AT_ATOMIC_DATA (since Linux 5.x)
> > > A filesystem which accepts this flag will guarantee that if the linked file
> > > name exists after a system crash, then all of the data written to the file
> > > and all of the file's metadata at the time of the linkat(2) call will be
> > > visible.
> >
> > ".... will be visible after the the file system is remounted".  (Never
> > hurts to be explicit.)
> >
> > > The way to achieve this guarantee on old kernels is to call fsync (2)
> > > before linking the file, but doing so will also results in flushing of
> > > volatile disk caches.
> > >
> > > A filesystem which accepts this flag does NOT
> > > guarantee that any of the file hardlinks will exist after a system crash,
> > > nor that the last observed value of st_nlink (see stat (2)) will persist."
> > >
> >
> > This is I think more precise:
> >
> >     This guarantee can be achieved by calling fsync(2) before linking
> >     the file, but there may be more performant ways to provide these
> >     semantics.  In particular, note that the use of the AT_ATOMIC_DATA
> >     flag does *not* guarantee that the new link created by linkat(2)
> >     will be persisted after a crash.
>
> So here's the *implementation* problem I see with this definition of
> AT_ATOMIC_DATA. After linkat(dirfd, name, AT_ATOMIC_DATA), there is
> no guarantee that the data is on disk or that the link is present.
>
> However:
>
>         linkat(dirfd, name, AT_ATOMIC_DATA);
>         fsync(dirfd);
>
> Suddenly changes all that.
>
> i.e. when we fsync(dirfd) we guarantee that "name" is present in the
> directory and because we used AT_ATOMIC_DATA it implies that the
> data pointed to by "name" must be present on disk. IOWs, what was
> once a pure directory sync operation now *must* fsync all the child
> inodes that have been linkat(AT_ATOMIC_DATA) since the last time the
> direct has been made stable.
>
> IOWs, the described AT_ATOMIC_DATA "we don't have to write the data
> during linkat() go-fast-get-out-of-gaol-free" behaviour isn't worth
> the pixels it is written on - it just moves all the complexity to
> directory fsync, and that's /already/ a behavioural minefield.

Where does it say we don't have to write the data during linkat()?
I was only talking about avoid FLUSH/FUA caused by fsync().
I wrote in commit message:
"First implementation of AT_ATOMIC_DATA is expected to be
filemap_write_and_wait() for xfs/ext4 and probably fdatasync for btrfs."

I failed to convey the reasoning for this flag to you.
It is *not* about the latency of the "atomic link" for the calling thread
It is about not interfering with other workloads running at the same time.

>
> IMO, the "work-around" of forcing filesystems to write back
> destination inodes during a link() operation is just nasty and will
> just end up with really weird performance anomalies occurring in
> production systems. That's not really a solution, either, especially
> as it is far, far faster for applications to use AIO_FSYNC and then
> on the completion callback run a normal linkat() operation...
>
> Hence, if I've understood these correctly, then I'll be recommending
> that XFS follows this:
>
> > We should also document that a file system which does not implement
> > this flag MUST return EINVAL if it is passed this flag to linkat(2).
>
> and returns -EINVAL to these flags because we do not have the change
> tracking infrastructure to handle these directory fsync semantics.
> I also suspect that, even if we could track this efficiently, we
> can't do the flushing atomically because of locking order
> constraints between directories, regular files, pages in the page
> cache, etc.

That is not at all what I had in mind for XFS with the flag.

>
> Given that we can already use AIO to provide this sort of ordering,
> and AIO is vastly faster than synchronous IO, I don't see any point
> in adding complex barrier interfaces that can be /easily implemented
> in userspace/ using existing AIO primitives. You should start
> thinking about expanding libaio with stuff like
> "link_after_fdatasync()" and suddenly the whole problem of
> filesystem data vs metadata ordering goes away because the
> application directly controls all ordering without blocking and
> doesn't need to care what the filesystem under it does....
>

OK. I can work with that. It's not that simple, but I will reply on
your next email, where you wrote more about this alternative.

Thanks,
Amir.
