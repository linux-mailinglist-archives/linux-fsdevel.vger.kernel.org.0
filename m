Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3B757AE0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 04:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbiGTCgQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 22:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbiGTCgO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:36:14 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 446466E2CB;
        Tue, 19 Jul 2022 19:36:13 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 3BD7762C8CE;
        Wed, 20 Jul 2022 12:36:12 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oDzZK-002zoU-MH; Wed, 20 Jul 2022 12:36:10 +1000
Date:   Wed, 20 Jul 2022 12:36:10 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Message-ID: <20220720023610.GN3600936@dread.disaster.area>
References: <20220715184433.838521-1-anna@kernel.org>
 <20220715184433.838521-7-anna@kernel.org>
 <EC97C20D-A317-49F9-8280-062D1AAEE49A@oracle.com>
 <20220718011552.GK3600936@dread.disaster.area>
 <CAFX2Jf=FrXHMxioWLHFkRHxBNDRe-9SBUmCcco9gkaY8EQOSZg@mail.gmail.com>
 <20220719224434.GL3600936@dread.disaster.area>
 <CF981532-ADC0-43F9-A304-9760244A53D5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CF981532-ADC0-43F9-A304-9760244A53D5@oracle.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62d76a1c
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=RgO8CyIxsXoA:10 a=7-415B0cAAAA:8 a=VwQbUJbxAAAA:8
        a=JDjsHSkAAAAA:8 a=ZmS3FVTDLjWjq5nYNHMA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22 a=AjGcO6oz07-iQ99wixmX:22
        a=dseMxAR1CDlncBZeV_se:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 20, 2022 at 01:26:13AM +0000, Chuck Lever III wrote:
> 
> 
> > On Jul 19, 2022, at 6:44 PM, Dave Chinner <david@fromorbit.com> wrote:
> > 
> > On Tue, Jul 19, 2022 at 04:46:50PM -0400, Anna Schumaker wrote:
> >> On Sun, Jul 17, 2022 at 9:16 PM Dave Chinner <david@fromorbit.com> wrote:
> >>> 
> >>> On Fri, Jul 15, 2022 at 07:08:13PM +0000, Chuck Lever III wrote:
> >>>>> On Jul 15, 2022, at 2:44 PM, Anna Schumaker <anna@kernel.org> wrote:
> >>>>> 
> >>>>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >>>>> 
> >>>>> Rather than relying on the underlying filesystem to tell us where hole
> >>>>> and data segments are through vfs_llseek(), let's instead do the hole
> >>>>> compression ourselves. This has a few advantages over the old
> >>>>> implementation:
> >>>>> 
> >>>>> 1) A single call to the underlying filesystem through nfsd_readv() means
> >>>>>  the file can't change from underneath us in the middle of encoding.
> >>> 
> >>> Hi Anna,
> >>> 
> >>> I'm assuming you mean the vfs_llseek(SEEK_HOLE) call at the start
> >>> of nfsd4_encode_read_plus_data() that is used to trim the data that
> >>> has already been read out of the file?
> >> 
> >> There is also the vfs_llseek(SEEK_DATA) call at the start of
> >> nfsd4_encode_read_plus_hole(). They are used to determine the length
> >> of the current hole or data segment.
> >> 
> >>> 
> >>> What's the problem with racing with a hole punch here? All it does
> >>> is shorten the read data returned to match the new hole, so all it's
> >>> doing is making the returned data "more correct".
> >> 
> >> The problem is we call vfs_llseek() potentially many times when
> >> encoding a single reply to READ_PLUS. nfsd4_encode_read_plus() has a
> >> loop where we alternate between hole and data segments until we've
> >> encoded the requested number of bytes. My attempts at locking the file
> >> have resulted in a deadlock since vfs_llseek() also locks the file, so
> >> the file could change from underneath us during each iteration of the
> >> loop.
> > 
> > So the problem being solved is that the current encoding is not
> > atomic, rather than trying to avoid any computational overhead of
> > multiple vfs_llseek calls (which are largely just the same extent
> > lookups as we do during the read call)?
> 
> Reviewing [1] and [2] I don't find any remarks about atomicity
> guarantees. If a client needs an uncontended view of a file's
> data, it's expected to fence other accessors via a OPEN(deny)
> or LOCK operation, or serialize the requests itself.

You've got the wrong "atomicity" scope :)

What I was talking about is the internal server side data operation
atomicity. that is, what is returned from the read to the READ_PLUS
code is not atomic w.r.t. the vfs_llseek() that are then used to
determine where there holes in the data returned by the read are.

Hence after the read has returned data to READ_PLUS, something else
can modify the data in the file (e.g. filling a hole or punching a
new one out) and then the ranges vfs_llseek() returns to READ_PLUS
does not match the data that is has in it's local buffer.

i.e. to do what the READ_PLUS operation is doing now, it would
somehow need to ensure no modifications can be made between the read
starting and the last vfs_llseek() call completing. IOWs, they need
to be performed as an atomic operation, not as a set of
independently locked (or unlocked!) operations as they are now.

> > The implementation just seems backwards to me - rather than reading
> > data and then trying to work out where the holes are, I suspect it
> > should be working out where the holes are and then reading the data.
> > This is how the IO path in filesystems work, so it would seem like a
> > no-brainer to try to leverage the infrastructure we already have to
> > do that.
> > 
> > The information is there and we have infrastructure that exposes it
> > to the IO path, it's just *underneath* the page cache and the page
> > cache destroys the information that it used to build the data it
> > returns to the NFSD.
> > 
> > IOWs, it seems to me that what READ_PLUS really wants is a "sparse
> > read operation" from the filesystem rather than the current "read
> > that fills holes with zeroes". i.e. a read operation that sets an
> > iocb flag like RWF_SPARSE_READ to tell the filesystem to trim the
> > read to just the ranges that contain data.
> > 
> > That way the read populates the page cache over a single contiguous
> > range of data and returns with the {offset, len} that spans the
> > range that is read and mapped. The caller can then read that region
> > out of the page cache and mark all the non-data regions as holes in
> > whatever manner they need to.
> > 
> > The iomap infrastructure that XFS and other filesystems use provide
> > this exact "map only what contains data" capability - an iomap tells
> > the page cache exactly what underlies the data range (hole, data,
> > unwritten extents, etc) in an efficient manner, so it wouldn't be a
> > huge stretch just to limit read IO ranges to those that contain only
> > DATA extents.
> > 
> > At this point READ_PLUS then just needs to iterate doing sparse
> > reads and recording the ranges that return data as vector of some
> > kind that is then passes to the encoding function to encode it as
> > a sparse READ_PLUS data range....
> 
> The iomap approach

Not actually what I proposed - I'm suggesting a new kiocb flag that
changes what the read passed to the filesystem does. My comments
about iomap are that this infrastructure already provides the extent
range query mechanisms that allow us to efficiently perform such
"restricted range" IO operations.

> seems sensible to me and covers the two basic
> usage scenarios:
> 
> - Large sparse files, where we want to conserve both network
>   bandwidth and client (and intermediate) cache occupancy.
>   These are best served by exposing data and holes.

*nod*

> - Everyday files that are relatively small and generally will
>   continue few, if any, holes. These are best served by using
>   a splice read (where possible) -- that is, READ_PLUS in this
>   case should work exactly like READ.

*nod*

> My impression of client implementations is that, a priori,
> a client does not know whether a file contains holes or not,
> but will probably always use READ_PLUS and let the server
> make the choice for it.

*nod*

> Now how does the server make that choice? Is there an attribute
> bit that indicates when a file should be treated as sparse? Can
> we assume that immutable files (or compressed files) should
> always be treated as sparse? Alternately, the server might use
> the file's data : hole ratio.

None of the above. The NFS server has no business knowing intimate
details about how the filesystem has laid out the file. All it cares
about ranges containing data and ranges that have no data (holes).

If the filesystem can support a sparse read, it returns sparse
ranges containing data to the NFS server. If the filesystem can't
support it, or it's internal file layout doesn't allow for efficient
hole/data discrimination, then it can just return the entire read
range.

Alternatively, in this latter case, the filesystem could call a
generic "sparse read" implementation that runs memchr_inv() to find
the first data range to return. Then the NFS server doesn't have to
code things differently, filesystems don't need to advertise
support for sparse reads, etc because every filesystem could
support sparse reads.

The only difference is that some filesystems will be much more
efficient and faster at it than others. We already see that sort
of thing with btrfs and seek hole/data on large cached files so I
don't see "filesystems perform differently" as a problem here...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
