Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622A5418B89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 00:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhIZWiq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Sep 2021 18:38:46 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:48333 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230331AbhIZWip (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Sep 2021 18:38:45 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 4810C82C75F;
        Mon, 27 Sep 2021 08:37:00 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mUclW-00H5s5-TN; Mon, 27 Sep 2021 08:36:58 +1000
Date:   Mon, 27 Sep 2021 08:36:58 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>, hch@lst.de,
        trond.myklebust@primarydata.com, Theodore Ts'o <tytso@mit.edu>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Anna Schumaker <anna.schumaker@netapp.com>, linux-mm@kvack.org,
        Bob Liu <bob.liu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Seth Jennings <sjenning@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-cifs@vger.kernel.org, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Steve French <sfrench@samba.org>, NeilBrown <neilb@suse.de>,
        Dan Magenheimer <dan.magenheimer@oracle.com>,
        linux-nfs@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        linux-btrfs@vger.kernel.org, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH v3 0/9] mm: Use DIO for swap and fix NFS swapfiles
Message-ID: <20210926223658.GE1756565@dread.disaster.area>
References: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
 <20210925234243.GA1756565@dread.disaster.area>
 <YU/ks7Sfw5Wj0K1p@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YU/ks7Sfw5Wj0K1p@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=7-415B0cAAAA:8
        a=bMojAixK84Ma9oYoJFgA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 26, 2021 at 04:10:43AM +0100, Matthew Wilcox wrote:
> On Sun, Sep 26, 2021 at 09:42:43AM +1000, Dave Chinner wrote:
> > Ok, so if the filesystem is doing block mapping in the IO path now,
> > why does the swap file still need to map the file into a private
> > block mapping now?  i.e all the work that iomap_swapfile_activate()
> > does for filesystems like XFS and ext4 - it's this completely
> > redundant now that we are doing block mapping during swap file IO
> > via iomap_dio_rw()?
> 
> Hi Dave,
> 
> Thanks for bringing up all these points.  I think they all deserve to go
> into the documentation as "things to consider" for people implementing
> ->swap_rw for their filesystem.
> 
> Something I don't think David perhaps made sufficiently clear is that
> regular DIO from userspace gets handled by ->read_iter and ->write_iter.
> This ->swap_rw op is used exclusive for, as the name suggests, swap DIO.
> So filesystems don't have to handle swap DIO and regular DIO the same
> way, and can split the allocation work between ->swap_activate and the
> iomap callback as they see fit (as long as they can guarantee the lack
> of deadlocks under memory pressure).

I understand this completely.

The point is that the implementation of ->swap_rw is to call
iomap_dio_rw() with the same ops as the normal DIO read/write path
uses. IOWs, apart from the IOCB_SWAP flag, there is no practical
difference between the "swap DIO" and "normal DIO" I/O paths.

> There are several advantages to using the DIO infrastructure for
> swap:
> 
>  - unify block & net swap paths
>  - allow filesystems to _see_ swap IOs instead of being bypassed
>  - get rid of the swap extent rbtree
>  - allow writing compound pages to swap files instead of splitting
>    them
>  - allow ->readpage to be synchronous for better error reporting
>  - remove page_file_mapping() and page_file_offset()
> 
> I suspect there are several problems with this patchset, but I'm not
> likely to have a chance to read it closely for a few days.  If you
> have time to give the XFS parts a good look, that would be fantastic.

That's what I've already done, and all the questions I've raised are
from asking a simple question: what happens if a transaction is
required to complete the iomap_dio_rw() swap write operation?

I mean, this is similar to the problems with IOCB_NOWAIT - we're
supposed to return -EAGAIN if we might block during IO submission,
and one of those situations we have to consider is "do we need to
run a transaction". If we get it wrong (and we do!), then the worst
thing that happens is that there is a long latency for IO
submission. It's a minor performance issue, not the end of the
world.

The difference with IOCB_SWAP is that "don't do transactions during
iomap_dio_rw()" is a _hard requirement_ on both IO submission and
completion. That means, from now and forever, we will have to
guarantee a path through iomap_dio_rw() that will never run
transactions on an IO. That requirement needs to be enforced in
every block mapping callback into each filesystem, as this is
something the iomap infrastructure cannot enforce. Hence we'll have
to plumb IOCB_SWAP into a new IOMAP_SWAP iterator flag to pass to
the ->iomap_begin() DIO methods to ensure they do the right thing.

And then the question becomes: what happens if the filesystem cannot
do the right thing? Can the swap code handle an error? e.g. the
first thing that xfs_direct_write_iomap_begin() and
xfs_read_iomap_begin() do is check if the filesystem is shut down
and returns -EIO in that case. IOWs, we've now got normal filesystem
"reject all IO" corruption protection mechanisms in play. Using
iomap_dio_rw() as it stands means that _all swapfile IO will fail_
if the filesystem shuts down.

Right now the swap file IO can keep going blissfully unaware of the
filesystem failure status. The open swapfile will prevent the
filesystem from being unmounted. Hence to unmount the shutdown
filesystem to correct the problem, first the swap file has to be
turned off, which means we have a fail-safe behaviour. Using the
iomap_dio_rw() path means that swapfile IO _can and will fail_.

AFAICT, swap IO errors are pretty much thrown away by the mm code;
the swap_writepage() return value is ignored or placed on the swap
cache address space and ignored. And it looks like the new read path
just sets PageError() and leaves it to callers to detect and deal
with a swapin failure because swap_readpage() is now void...

So it seems like there's a whole new set of failure cases using the
DIO path introduces into the swap IO path that haven't been
considered here. I can't see why we wouldn't be able to solve them,
but these considerations lead me to think that use of the DIO is
based on an incorrect assumption - DIO is not a "simple low level
IO" interface.

Hence I suspect that we'd be much better off with a new
iomap_swap_rw() implementation that just does what swap needs
without any of the complexity of the DIO API. Internally iomap can
share what it needs to share with the DIO path, but at this point
I'm not sure we should be overloading the iomap_dio_rw() path with
the semantics required by swap.

e.g. we limit iomap_swap_rw() to only accept written or unwritten
block mappings within file size on inodes with clean metadata (i.e.
pure overwrite to guarantee no modification transactions), and then
the fs provided ->iomap_begin callback can ignore shutdown state,
elide inode level locking, do read-only mappings, etc without adding
extra overhead to the existing DIO code path...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
