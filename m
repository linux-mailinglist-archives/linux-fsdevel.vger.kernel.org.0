Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E156332409
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 12:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhCIL2W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 06:28:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24419 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231197AbhCIL2Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 06:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615289296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LvGBiPlaIdzFAXyfsy1qEVyMatChi1ggtZKGPfWh9R0=;
        b=LVNz0z1YXL803AlW9Gs/ynHrnvWU4RjOIPNSJpN5vQ32F89xgpyktcLJuHIXad+HeePI48
        BvjtiUJkYDV5Q5qqEtYG491cFSm2XS80I9WHSikQOO1DntMDYWo5KN49l1KijwoM5Ud1PC
        Cb6GwYpLZ0bF2u+LRsvXeD3BSHsWrVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-p4rhjGRAM9idlqpMeWWWYA-1; Tue, 09 Mar 2021 06:28:12 -0500
X-MC-Unique: p4rhjGRAM9idlqpMeWWWYA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E714881D50;
        Tue,  9 Mar 2021 11:28:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 542A75D9CD;
        Tue,  9 Mar 2021 11:27:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210308223247.GB63242@dread.disaster.area>
References: <20210308223247.GB63242@dread.disaster.area> <CAOQ4uxjYWprb7trvamCx+DaP2yn8HCaZeZx1dSvPyFH2My303w@mail.gmail.com> <2653261.1614813611@warthog.procyon.org.uk> <CAOQ4uxhxwKHLT559f8v5aFTheKgPUndzGufg0E58rkEqa9oQ3Q@mail.gmail.com> <517184.1615194835@warthog.procyon.org.uk> <584529.1615202921@warthog.procyon.org.uk>
To:     Dave Chinner <david@fromorbit.com>
Cc:     dhowells@redhat.com, Amir Goldstein <amir73il@gmail.com>,
        linux-cachefs@redhat.com, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Metadata writtenback notification? -- was Re: fscache: Redesigning the on-disk cache
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <156604.1615289274.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 09 Mar 2021 11:27:54 +0000
Message-ID: <156605.1615289274@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave Chinner <david@fromorbit.com> wrote:

> > > There was a discussion about fsyncing a range of files on LSFMM [1].
> > > In the last comment on the article dchinner argues why we already ha=
ve that
> > > API (and now also with io_uring(), but AFAIK, we do not have a usefu=
l
> > > wait_for_sync() API. And it doesn't need to be exposed to userspace =
at all.
> > > =

> > > [1] https://lwn.net/Articles/789024/
> > =

> > This sounds like an interesting idea.  Actually, what I probably want =
is a
> > notification to say that a particular object has been completely sync'=
d to
> > disk, metadata and all.
> =

> This isn't hard to do yourself in the kernel. All it takes is a
> workqueue to run vfs_fsync() calls asynchronously and for the work
> to queue a local notification/wakeup when the fsync completes...
> =

> That's all aio_fsync() does - the notification it queues on
> completion is the AIO completion event for userspace - so I think
> you could do this in about 50 lines of code if you really needed
> it...

I was thinking more in terms of passively finding out when metadata has be=
en
flushed to disk rather than actively forcing it.  Obviously I can manually
flush from a worker thread, but that ties up a thread per file I want to
flush (unless I want to do a higher-level sync).

Btw, looking at aio_fsync(), is there any reason it copies the current cre=
ds
rather than just taking a ref on them?  (Granted, this may not be a questi=
on
for you)

> > However, there are some performance problems are arising in my fscache=
-iter
> > branch:
> > =

> >  (1) It's doing a lot of synchronous metadata operations (tmpfile, tru=
ncate,
> >      setxattr).
> =

> Async pipelines using unbound workqueues are your friend.

Maybe.  I could just throw everything into a workqueue and let the workque=
ue
deal with it.  There still have to be synchronisation points, though - I c=
an't
schedule a cache-write from a server-read to the cache following a 3rd-par=
ty
induced invalidation until after the invalidation has happened - and that
holds up userspace from writing to the cache.  But maybe it will work.

Btw, how expensive is it to throw an operation off to a workqueue versus d=
oing
it in thread?  Particularly if it's a synchronous op that the thread is go=
ing
to have to wait for (e.g. write_begin()).

> >  (2) It's retaining a lot of open file structs on cache files.  Cachef=
iles
> >      opens the file when it's first asked to access it and retains tha=
t till
> >      the cookie is relinquished or the cache withdrawn (the file* does=
n't
> >      contribute to ENFILE/EMFILE but it still eats memory).
> =

> Sounds similar to the problem that the NFSd open file cache solves.
> (fs/nfsd/filecache.c)

Looks similiarish to what I was thinking of with having a queue of
currently-not-in-use cookies to go through and commit and close.

> >      but if the file is truncated
> >      larger, that excess data now becomes part of the file.
> =

> Keep the actual file size in your tracking xattr.

I do that, but it doesn't help entirely.  If someone truncates the file la=
rger
and then writes non-contiguously, the problem occurs.

I've tried truncating the file down and then truncating it up, but that
requires two synchronous ops - though the latter is relatively cheap.  I'v=
e
also tried fallocate() to clear the block.  What I've found is that the ne=
xt
DIO write then has to sync because these may read data into the pagecache =
of
the backing file.

Apart from clearing the tail of a page on writing, it might be better for =
me
to read the data into a spare page, clear the tail and write it back.

> >      Possibly it's sufficient to just clear the excess page space befo=
re
> >      writing, but that doesn't necessarily stop a writable mmap from
> >      scribbling on it.
> =

> We can't stop mmap from scribbling in it. All filesystems have this
> problem, so to prevent data leaks we have to zero the post-eof tail
> region on every write of the EOF block, anyway.

I meant an mmap scribbling on it after it's been cleared - but I guess tak=
ing
away the PTE-writeable flag and making page_mkwrite() wait should solve th=
at.

> >  (4) Committing outstanding cache metadata at cache withdrawal or netf=
s
> >      unmount.  I've previously mentioned this: it ends up with a whole
> >      slew of synchronous metadata changes being committed to the cache=
 in
> >      one go (truncates, fallocates, fsync, xattrs, unlink+link of tmpf=
ile)
> >      - and this can take quite a long time.  The cache needs to be mor=
e
> >      proactive in getting stuff committed as it goes along.
> =

> Workqueues give you an easy mechanism for async dispatch and
> concurrency for synchronous operations. This is a largely solved
> problem...

Yes and no.  Yes, I can fan out the number of threads doing the committing=
,
but there's still a limit on the I/O bandwidth - and a lot of the operatio=
ns
still have to hit the disk in the right order.  It still stuffs up the use=
r
experience if the cache eats up the entirety of the disk I/O for a few sec=
onds
just because an automount expired.

Probably the progressive committing approach is a better one so that there=
's
less to do at the end.

> >  (5) Attaching to an object requires a pathwalk to it (normally only t=
wo
> >      steps) and then reading various xattrs on it - all synchronous, b=
ut can
> >      be punted to a background threadpool.
> =

> a.k.a. punting to a workqueue :)

I do that, but it doesn't help so much.  Whilst it can mitigate the effect=
 by
running parallel to userspace, userspace tends to move pretty quickly from
open() to read() - at which point we have to wait anyway.

The problem is that all the steps are synchronous and, for the most part, =
have
to be sequential because there's a dependency chain: 2 x dir-lookup, get L=
SM
xattrs, get cache xattrs - then read the data if it's present.  I might be
able to speculate at the end and read two cache xattrs in parallel, but ea=
ch
one requires a separate thread to do it.

On top of that, if the user is running a parallel application such as buil=
ding
a kernel, a CPU running an offloaded I/O thread isn't running a user threa=
d.
What I've found is that increasing the size of the threadpool doesn't actu=
ally
affect the time taken.

What I've done in my fscache-iter branch is to have a small thread pool an=
d
offload work to it if there's a thread free - otherwise process the work i=
n
the calling userspace thread and avoid the context switching.


One reason I was wondering about moving to an approach whereby I have an i=
ndex
that locates all the blocks (which are then kept in a single file) is that=
 I
can probably keep the entire index in RAM and so the lookup costs are vast=
ly
reduced.  The downside as Amir pointed out is that metadata coherency is m=
uch
harder if I don't just want to blow the cache away if cache isn't properly
committed when the machine is rebooted.

Note that OpenAFS has been using a single-index approach, with each 256K b=
lock
of data in its own file.  They then zap any file that's newer than the ind=
ex
file when the cache is started, assuming that that file might be corrupted=
.

David

