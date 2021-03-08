Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8B1331A3C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 23:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhCHWdK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 17:33:10 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:40412 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229627AbhCHWcv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 17:32:51 -0500
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 3A2521041A91;
        Tue,  9 Mar 2021 09:32:48 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lJOQh-000IZX-At; Tue, 09 Mar 2021 09:32:47 +1100
Date:   Tue, 9 Mar 2021 09:32:47 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-cachefs@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
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
Subject: Re: Metadata writtenback notification? -- was Re: fscache:
 Redesigning the on-disk cache
Message-ID: <20210308223247.GB63242@dread.disaster.area>
References: <CAOQ4uxjYWprb7trvamCx+DaP2yn8HCaZeZx1dSvPyFH2My303w@mail.gmail.com>
 <2653261.1614813611@warthog.procyon.org.uk>
 <CAOQ4uxhxwKHLT559f8v5aFTheKgPUndzGufg0E58rkEqa9oQ3Q@mail.gmail.com>
 <517184.1615194835@warthog.procyon.org.uk>
 <584529.1615202921@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <584529.1615202921@warthog.procyon.org.uk>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=dESyimp9J3IA:10 a=pGLkceISAAAA:8 a=07d9gI8wAAAA:8
        a=7-415B0cAAAA:8 a=fLlyUv8SAob-akP86owA:9 a=CjuIK1q_8ugA:10
        a=e2CUPOnPG4QKp8I52DXD:22 a=biEYGPWJfzWAr4FL6Ov7:22
        a=BPzZvq435JnGatEyYwdK:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 08, 2021 at 11:28:41AM +0000, David Howells wrote:
> Amir Goldstein <amir73il@gmail.com> wrote:
> 
> > > But after I've written and sync'd the data, I set the xattr to mark the
> > > file not open.  At the moment I'm doing this too lazily, only doing it
> > > when a netfs file gets evicted or when the cache gets withdrawn, but I
> > > really need to add a queue of objects to be sealed as they're closed.  The
> > > balance is working out how often to do the sealing as something like a
> > > shell script can do a lot of consecutive open/write/close ops.
> > 
> > You could add an internal vfs API wait_for_multiple_inodes_to_be_synced().
> > For example, xfs keeps the "LSN" on each inode, so once the transaction
> > with some LSN has been committed, all the relevant inodes, if not dirty, can
> > be declared as synced, without having to call fsync() on any file and without
> > having to force transaction commit or any IO at all.
> > 
> > Since fscache takes care of submitting the IO, and it shouldn't care about any
> > specific time that the data/metadata hits the disk(?), you can make use of the
> > existing periodic writeback and rolling transaction commit and only ever need
> > to wait for that to happen before marking cache files "closed".
> > 
> > There was a discussion about fsyncing a range of files on LSFMM [1].
> > In the last comment on the article dchinner argues why we already have that
> > API (and now also with io_uring(), but AFAIK, we do not have a useful
> > wait_for_sync() API. And it doesn't need to be exposed to userspace at all.
> > 
> > [1] https://lwn.net/Articles/789024/
> 
> This sounds like an interesting idea.  Actually, what I probably want is a
> notification to say that a particular object has been completely sync'd to
> disk, metadata and all.

This isn't hard to do yourself in the kernel. All it takes is a
workqueue to run vfs_fsync() calls asynchronously and for the work
to queue a local notification/wakeup when the fsync completes...

That's all aio_fsync() does - the notification it queues on
completion is the AIO completion event for userspace - so I think
you could do this in about 50 lines of code if you really needed
it...

> However, there are some performance problems are arising in my fscache-iter
> branch:
> 
>  (1) It's doing a lot of synchronous metadata operations (tmpfile, truncate,
>      setxattr).

Async pipelines using unbound workqueues are your friend.
> 
>  (2) It's retaining a lot of open file structs on cache files.  Cachefiles
>      opens the file when it's first asked to access it and retains that till
>      the cookie is relinquished or the cache withdrawn (the file* doesn't
>      contribute to ENFILE/EMFILE but it still eats memory).

Sounds similar to the problem that the NFSd open file cache solves.
(fs/nfsd/filecache.c)

>  (3) Trimming excess data from the end of the cache file.  The problem with
>      using DIO to write to the cache is that the write has to be rounded up to
>      a multiple of the backing fs DIO blocksize,

Actually, a multiple of the logical sector size of the backing
device behind the backing filesystem.

>      but if the file is truncated
>      larger, that excess data now becomes part of the file.

Keep the actual file size in your tracking xattr.

>      Possibly it's sufficient to just clear the excess page space before
>      writing, but that doesn't necessarily stop a writable mmap from
>      scribbling on it.

We can't stop mmap from scribbling in it. All filesystems have this
problem, so to prevent data leaks we have to zero the post-eof tail
region on every write of the EOF block, anyway.

>  (4) Committing outstanding cache metadata at cache withdrawal or netfs
>      unmount.  I've previously mentioned this: it ends up with a whole slew of
>      synchronous metadata changes being committed to the cache in one go
>      (truncates, fallocates, fsync, xattrs, unlink+link of tmpfile) - and this
>      can take quite a long time.  The cache needs to be more proactive in
>      getting stuff committed as it goes along.

Workqueues give you an easy mechanism for async dispatch and
concurrency for synchronous operations. This is a largely solved
problem...

>  (5) Attaching to an object requires a pathwalk to it (normally only two
>      steps) and then reading various xattrs on it - all synchronous, but can
>      be punted to a background threadpool.

a.k.a. punting to a workqueue :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
