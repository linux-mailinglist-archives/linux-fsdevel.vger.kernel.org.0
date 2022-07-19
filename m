Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D871157A9F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 00:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbiGSWol (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 18:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiGSWok (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 18:44:40 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9AE375F103;
        Tue, 19 Jul 2022 15:44:37 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id A3D9B10E7ECF;
        Wed, 20 Jul 2022 08:44:36 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oDvxC-002voo-K3; Wed, 20 Jul 2022 08:44:34 +1000
Date:   Wed, 20 Jul 2022 08:44:34 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Anna Schumaker <anna@kernel.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Message-ID: <20220719224434.GL3600936@dread.disaster.area>
References: <20220715184433.838521-1-anna@kernel.org>
 <20220715184433.838521-7-anna@kernel.org>
 <EC97C20D-A317-49F9-8280-062D1AAEE49A@oracle.com>
 <20220718011552.GK3600936@dread.disaster.area>
 <CAFX2Jf=FrXHMxioWLHFkRHxBNDRe-9SBUmCcco9gkaY8EQOSZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFX2Jf=FrXHMxioWLHFkRHxBNDRe-9SBUmCcco9gkaY8EQOSZg@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62d733d4
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=RgO8CyIxsXoA:10 a=7-415B0cAAAA:8 a=VwQbUJbxAAAA:8
        a=JDjsHSkAAAAA:8 a=ar1VmM8jAAAA:8 a=P6JkxrBpAAAA:8 a=Omq8ZIaKN1FLDrBX4RAA:9
        a=CjuIK1q_8ugA:10 a=u37mErDvIGIA:10 a=biEYGPWJfzWAr4FL6Ov7:22
        a=AjGcO6oz07-iQ99wixmX:22 a=dseMxAR1CDlncBZeV_se:22
        a=rFd2LkbIa9bXzCDub527:22 a=dwOG0T2NmQ8MtARghG3a:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 19, 2022 at 04:46:50PM -0400, Anna Schumaker wrote:
> On Sun, Jul 17, 2022 at 9:16 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Fri, Jul 15, 2022 at 07:08:13PM +0000, Chuck Lever III wrote:
> > > > On Jul 15, 2022, at 2:44 PM, Anna Schumaker <anna@kernel.org> wrote:
> > > >
> > > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > >
> > > > Rather than relying on the underlying filesystem to tell us where hole
> > > > and data segments are through vfs_llseek(), let's instead do the hole
> > > > compression ourselves. This has a few advantages over the old
> > > > implementation:
> > > >
> > > > 1) A single call to the underlying filesystem through nfsd_readv() means
> > > >   the file can't change from underneath us in the middle of encoding.
> >
> > Hi Anna,
> >
> > I'm assuming you mean the vfs_llseek(SEEK_HOLE) call at the start
> > of nfsd4_encode_read_plus_data() that is used to trim the data that
> > has already been read out of the file?
> 
> There is also the vfs_llseek(SEEK_DATA) call at the start of
> nfsd4_encode_read_plus_hole(). They are used to determine the length
> of the current hole or data segment.
> 
> >
> > What's the problem with racing with a hole punch here? All it does
> > is shorten the read data returned to match the new hole, so all it's
> > doing is making the returned data "more correct".
> 
> The problem is we call vfs_llseek() potentially many times when
> encoding a single reply to READ_PLUS. nfsd4_encode_read_plus() has a
> loop where we alternate between hole and data segments until we've
> encoded the requested number of bytes. My attempts at locking the file
> have resulted in a deadlock since vfs_llseek() also locks the file, so
> the file could change from underneath us during each iteration of the
> loop.

So the problem being solved is that the current encoding is not
atomic, rather than trying to avoid any computational overhead of
multiple vfs_llseek calls (which are largely just the same extent
lookups as we do during the read call)?

The implementation just seems backwards to me - rather than reading
data and then trying to work out where the holes are, I suspect it
should be working out where the holes are and then reading the data.
This is how the IO path in filesystems work, so it would seem like a
no-brainer to try to leverage the infrastructure we already have to
do that.

The information is there and we have infrastructure that exposes it
to the IO path, it's just *underneath* the page cache and the page
cache destroys the information that it used to build the data it
returns to the NFSD.

IOWs, it seems to me that what READ_PLUS really wants is a "sparse
read operation" from the filesystem rather than the current "read
that fills holes with zeroes". i.e. a read operation that sets an
iocb flag like RWF_SPARSE_READ to tell the filesystem to trim the
read to just the ranges that contain data.

That way the read populates the page cache over a single contiguous
range of data and returns with the {offset, len} that spans the
range that is read and mapped. The caller can then read that region
out of the page cache and mark all the non-data regions as holes in
whatever manner they need to.

The iomap infrastructure that XFS and other filesystems use provide
this exact "map only what contains data" capability - an iomap tells
the page cache exactly what underlies the data range (hole, data,
unwritten extents, etc) in an efficient manner, so it wouldn't be a
huge stretch just to limit read IO ranges to those that contain only
DATA extents.

At this point READ_PLUS then just needs to iterate doing sparse
reads and recording the ranges that return data as vector of some
kind that is then passes to the encoding function to encode it as
a sparse READ_PLUS data range....

> > OTOH, if something allocates over a hole that the read filled with
> > zeros, what's the problem with occasionally returning zeros as data?
> > Regardless, if this has raced with a write to the file that filled
> > that hole, we're already returning stale data/hole information to
> > the client regardless of whether we trim it or not....
> >
> > i.e. I can't see a correctness or data integrity problem here that
> > doesn't already exist, and I have my doubts that hole
> > punching/filling racing with reads happens often enough to create a
> > performance or bandwidth problem OTW. Hence I've really got no idea
> > what the problem that needs to be solved here is.
> >
> > Can you explain what the symptoms of the problem a user would see
> > that this change solves?
> 
> This fixes xfstests generic/091 and generic/263, along with this
> reported bug: https://bugzilla.kernel.org/show_bug.cgi?id=215673

Oh, that bug is mixing mmap() reads and writes with direct IO reads
and writes. We don't guarantee data integrity and coherency when
applications do that, and a multi-part buffered read operation isn't
going to make that any better...

> > > > 2) A single call to the underlying filestem also means that the
> > > >   underlying filesystem only needs to synchronize cached and on-disk
> > > >   data one time instead of potentially many speeding up the reply.
> >
> > SEEK_HOLE/DATA doesn't require cached data to be sync'd to disk to
> > be coherent - that's only a problem FIEMAP has (and syncing cached
> > data doesn't fix the TOCTOU coherency issue!).  i.e. SEEK_HOLE/DATA
> > will check the page cache for data if appropriate (e.g. unwritten
> > disk extents may have data in memory over the top of them) instead
> > of syncing data to disk.
> 
> For some reason, btrfs on virtual hardware has terrible performance
> numbers when using vfs_llseek() with files that are already in the
> server's cache.

IIRC, btrfs has extent lookup scalability problems, so you're going
to see this sort of issue with SEEK_HOLE/DATA on large fragmented
cached files in btrfs, especially if things like compression is
enabled. See this recent btrfs bug report, for example:

https://lore.kernel.org/linux-fsdevel/Yr1QwVW+sHWlAqKj@atmark-techno.com/

The fiemap overhead in the second cached read is effectively what
you'll also see with SEEK_HOLE/DATA as they are similar extent
lookup operations.

> I think it had something to do with how they lock
> extents, and some extra work that needs to be done if the file already
> exists in the server's memory but it's been  a few years since I've
> gone into their code to figure out where the slowdown is coming from.
> See this section of my performance results wiki page:
> https://wiki.linux-nfs.org/wiki/index.php/Read_Plus_May_2022#BTRFS_3

Yup, that's pretty much it - a 1.2GB/s -> 100MB/s perf drop on cached
reads when READ_PLUS is enabled is in line with the above bug
report.

This really is a btrfs extent lookup issue, not a problem with
SEEK_HOLE/DATA, but I think it's a moot point because I suspect that
sparse read capability in the FS IO path would be a much better
solution to this problem than trying to use SEEK_HOLE/DATA to
reconstruct file sparseness post-read...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
