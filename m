Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB23418535
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Sep 2021 01:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhIYXod (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Sep 2021 19:44:33 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:34355 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230078AbhIYXob (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Sep 2021 19:44:31 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 08B668A154;
        Sun, 26 Sep 2021 09:42:44 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mUHJb-00GjRM-K9; Sun, 26 Sep 2021 09:42:43 +1000
Date:   Sun, 26 Sep 2021 09:42:43 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     David Howells <dhowells@redhat.com>
Cc:     willy@infradead.org, hch@lst.de, trond.myklebust@primarydata.com,
        Theodore Ts'o <tytso@mit.edu>, linux-block@vger.kernel.org,
        ceph-devel@vger.kernel.org,
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
Message-ID: <20210925234243.GA1756565@dread.disaster.area>
References: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=7-415B0cAAAA:8
        a=MUEH3GQPxMcp5Lh2lNUA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 24, 2021 at 06:17:52PM +0100, David Howells wrote:
> 
> Hi Willy, Trond, Christoph,
> 
> Here's v3 of a change to make reads and writes from the swapfile use async
> DIO, adding a new ->swap_rw() address_space method, rather than readpage()
> or direct_IO(), as requested by Willy.  This allows NFS to bypass the write
> checks that prevent swapfiles from working, plus a bunch of other checks
> that may or may not be necessary.
> 
> Whilst trying to make this work, I found that NFS's support for swapfiles
> seems to have been non-functional since Aug 2019 (I think), so the first
> patch fixes that.  Question is: do we actually *want* to keep this
> functionality, given that it seems that no one's tested it with an upstream
> kernel in the last couple of years?
> 
> There are additional patches to get rid of noop_direct_IO and replace it
> with a feature bitmask, to make btrfs, ext4, xfs and raw blockdevs use the
> new ->swap_rw method and thence remove the direct BIO submission paths from
> swap.
> 
> I kept the IOCB_SWAP flag, using it to enable REQ_SWAP.  I'm not sure if
> that's necessary, but it seems accounting related.
> 
> The synchronous DIO I/O code on NFS, raw blockdev, ext4 swapfile and xfs
> swapfile all seem to work fine.  Btrfs refuses to swapon because the file
> might be CoW'd.  I've tried doing "chattr +C", but that didn't help.

Ok, so if the filesystem is doing block mapping in the IO path now,
why does the swap file still need to map the file into a private
block mapping now?  i.e all the work that iomap_swapfile_activate()
does for filesystems like XFS and ext4 - it's this completely
redundant now that we are doing block mapping during swap file IO
via iomap_dio_rw()?

Actually, that path does all the "can we use this file as a swap
file" checking. So the extent iteration can't go away, just the swap
file mapping part (iomap_swapfile_add_extent()). This is necessary
to ensure there aren't any holes in the file, and we still need that
because the DIO write path will allocate into holes, which leads
me to my main concern here.

Using the DIO path opens up the possibility that the filesystem
could want to run transactions are part of the DIO. Right now we
support unwritten extents for swap files (so they don't have to be
written to allocate the backing store before activation) and that
means we'll be doing DIO to unwritten extents. IO completion of a
DIO write to an unwritten extent will run a transaction to convert
that extent to written. A similar problem with sparse files exists,
because allocation of blocks can be done from the DIO path, and that
requires transactions. File extension is another potential
transaction path we open up by using DIO writes dor swap.

The problem is that a transaction run in swap IO context will will
deadlock the filesystem. Either through the unbound memory demand of
metadata modification, or from needing log space that can't be freed
up because the metadata IO that will free the log space is waiting
on memory allocation that is waiting on swap IO...

I think some more thought needs to be put into controlling the
behaviour/semantics of the DIO path so that it can be safely used
by swap IO, because it's not a direct 1:1 behavioural mapping with
existing DIO and there are potential deadlock vectors we need to
avoid.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
