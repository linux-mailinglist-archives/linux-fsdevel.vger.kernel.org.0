Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5CD57D7D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 02:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbiGVApF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 20:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVApE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 20:45:04 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F36C895C1C;
        Thu, 21 Jul 2022 17:45:01 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id E36A310E8310;
        Fri, 22 Jul 2022 10:45:00 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oEgmo-003kqA-Qy; Fri, 22 Jul 2022 10:44:58 +1000
Date:   Fri, 22 Jul 2022 10:44:58 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Message-ID: <20220722004458.GS3600936@dread.disaster.area>
References: <20220715184433.838521-1-anna@kernel.org>
 <20220715184433.838521-7-anna@kernel.org>
 <EC97C20D-A317-49F9-8280-062D1AAEE49A@oracle.com>
 <20220718011552.GK3600936@dread.disaster.area>
 <CAFX2Jf=FrXHMxioWLHFkRHxBNDRe-9SBUmCcco9gkaY8EQOSZg@mail.gmail.com>
 <20220719224434.GL3600936@dread.disaster.area>
 <CF981532-ADC0-43F9-A304-9760244A53D5@oracle.com>
 <20220720023610.GN3600936@dread.disaster.area>
 <CD3CE5B3-1FB7-473A-8D45-EDF3704F10D7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CD3CE5B3-1FB7-473A-8D45-EDF3704F10D7@oracle.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62d9f30d
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=RgO8CyIxsXoA:10 a=7-415B0cAAAA:8
        a=mERPUiANjVKmkJHin7UA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 20, 2022 at 04:18:36AM +0000, Chuck Lever III wrote:
> > On Jul 19, 2022, at 10:36 PM, Dave Chinner <david@fromorbit.com> wrote:
> > On Wed, Jul 20, 2022 at 01:26:13AM +0000, Chuck Lever III wrote:
> >>> On Jul 19, 2022, at 6:44 PM, Dave Chinner <david@fromorbit.com> wrote:
> >>>>> What's the problem with racing with a hole punch here? All it does
> >>>>> is shorten the read data returned to match the new hole, so all it's
> >>>>> doing is making the returned data "more correct".
> >>>> 
> >>>> The problem is we call vfs_llseek() potentially many times when
> >>>> encoding a single reply to READ_PLUS. nfsd4_encode_read_plus() has a
> >>>> loop where we alternate between hole and data segments until we've
> >>>> encoded the requested number of bytes. My attempts at locking the file
> >>>> have resulted in a deadlock since vfs_llseek() also locks the file, so
> >>>> the file could change from underneath us during each iteration of the
> >>>> loop.
> >>> 
> >>> So the problem being solved is that the current encoding is not
> >>> atomic, rather than trying to avoid any computational overhead of
> >>> multiple vfs_llseek calls (which are largely just the same extent
> >>> lookups as we do during the read call)?
> >> 
> >> Reviewing [1] and [2] I don't find any remarks about atomicity
> >> guarantees. If a client needs an uncontended view of a file's
> >> data, it's expected to fence other accessors via a OPEN(deny)
> >> or LOCK operation, or serialize the requests itself.
> > 
> > You've got the wrong "atomicity" scope :)
> > 
> > What I was talking about is the internal server side data operation
> > atomicity. that is, what is returned from the read to the READ_PLUS
> > code is not atomic w.r.t. the vfs_llseek() that are then used to
> > determine where there holes in the data returned by the read are.
> > 
> > Hence after the read has returned data to READ_PLUS, something else
> > can modify the data in the file (e.g. filling a hole or punching a
> > new one out) and then the ranges vfs_llseek() returns to READ_PLUS
> > does not match the data that is has in it's local buffer.
> 
> Architecturally, with the NFS protocol, the client and the application
> running there are responsible for stopping "something else [from]
> modifying the data in the file." NFS operations in and of themselves
> are not usually atomic in that respect.

Sure, but that's not the atomicity scope I'm talking about. I'm
looking purely at what the server is doing and how atomicity within
the underlying filesystem - not the NFS server - changes the result.

> A READ operation has the same issue as READ_PLUS: a hole punch can
> remove data from a file while the server is constructing and
> encoding a READ reply, unless the application on the client has
> taken the trouble to block foreign file modifications.

Yes, at the NFS server that can happen, but it *can't happen in the
underlying filesystem*.

That is, while a read IO is in progress, the hole punch will not
start because we are not allowed to punch out an extent from under
an IO that is currently in progress. If we allow that, then the
extent could be reallocated to a different file and new data written
into before the actual read IO was submitted.

i.e. the filesystem has atomicity guarantees about data IO vs direct
extent manipulations.

Hence in the case of "read entire range then use memchr_inv() to
detect holes", the read IO has been executed without racing
with some other extent manipulation occurring. Hence the read IO is
effectively atomic, even if it needed to do multiple physical IOs
because the read was sparse.

In the case of "read data followed by seek hole/data", the
underlying extent map can be changed by racing modifications
(writes, hole punch, fallocate, truncate, etc) because once the read
is complete there is nothing stopping other operations being
performed.

Hence READ_PLUS via seek_hole/data is a non-atomic operation w.r.t.
the data read from the underlying filesystem, whereas read w/
memchr_inv is atomic w.r.t the data read...

> > i.e. to do what the READ_PLUS operation is doing now, it would
> > somehow need to ensure no modifications can be made between the read
> > starting and the last vfs_llseek() call completing. IOWs, they need
> > to be performed as an atomic operation, not as a set of
> > independently locked (or unlocked!) operations as they are now.
> 
> There is nothing making that guarantee on the server, and as I
> said, there is nothing I've found in the specs that require that
> level of atomicity from a single READ or READ_PLUS operation.

That's my point - the data corruption bug that got fixed by Anna's
patch changes the -data access atomicity- of the server READ_PLUS
encoding operation. i.e. it has nothing to do with the NFS
specification for the operation but rather results from how the
server implementation is retreiving data and metadata
from the underlying filesystem independently and then combining them
as it they were obtained atomically.

IOWs, the information returned by SEEK_HOLE/SEEK_DATA after a data
read does not reflect the state at the time the data was read - the
data is effectively stale at this point. seek hole/data information
is supposed to be used *before* the data is read to find the
locations of the data. That way, if there is a TOCTOU race, the read
still returns valid, correct data that matched the underlying
file layout at the time of the read.

> >>> IOWs, it seems to me that what READ_PLUS really wants is a "sparse
> >>> read operation" from the filesystem rather than the current "read
> >>> that fills holes with zeroes". i.e. a read operation that sets an
> >>> iocb flag like RWF_SPARSE_READ to tell the filesystem to trim the
> >>> read to just the ranges that contain data.
.....
> >> Now how does the server make that choice? Is there an attribute
> >> bit that indicates when a file should be treated as sparse? Can
> >> we assume that immutable files (or compressed files) should
> >> always be treated as sparse? Alternately, the server might use
> >> the file's data : hole ratio.
> > 
> > None of the above. The NFS server has no business knowing intimate
> > details about how the filesystem has laid out the file. All it cares
> > about ranges containing data and ranges that have no data (holes).
> 
> That would be the case if we want nothing more than impermeable
> software layering. That's nice for software developers, but
> maybe not of much benefit to average users.
> 
> I see no efficiency benefit, for example, if a 10MB object file
> has 512 bytes of zeroes at a convenient offset and the server
> returns that as DATA/HOLE/DATA. The amount of extra work it has
> to do to make that happen results in the same latencies as
> transmitting 512 extra bytes on GbE. It might be even worse on
> faster network fabrics.

Welcome to the world of sparse file IO optimisation - NFS may be new
to this, but local filesystems have been optimising this sort of
thing for decades. Don't think we don't know about it - seek time
between 2 discontiguous extents is *much worse* than the few extra
microseconds that DMAing a few extra sectors worth of data in a
single IO. Even on SSDs, there's a noticable latency difference
between a single 16KB IO and two separate 4kB IOs to get the same
data.

As it is, we worry about filesystem block granularity, not sectors.
A filesystem would only report a 512 byte range as a hole if it had
a 512 byte block size. Almost no-one uses such small block sizes -
4kB is the default for ext4 and XFS - so the minimum hole size is
generally 4KB.

Indeed, in this case XFS will not actually have a hole in the file
layout - the underlying extent would have been allocated as a single
contiguous unwritten extent, then when the data gets written it will
convert the two ranges to written, resulting in a physically
contiguous "data-unwritten-data" set of extents. However,
SEEK_HOLE/DATA will see that unwritten extent as a hole, so you'll
get that reported via seek hole/data or sparse reads regardless of
whether it is optimal for READ_PLUS encoding.

However, the physical layout is optimal for XFS - if the hole gets
filled by a future write, it ends up converting the file layout to a
single contiguous data extent that can be read with a single IO
rather than three physically discontigous data extents that require
3 physical IOs to read.

ext4 optimises this in a different way - it will allocate small
holes similar to the way XFS does, but it will also fill the with
real zeros rather than leaving them unwritten. As a result, ext4
will have a single physically contiguous extent on disk too, but it
will -always- report as data even though the data written by the
application is sparse and contains a run of zeroes in it.

IOWs, ext4 and XFS will behave differently for the simple case you
gave because they've optimised small holes in sparse file data
differently. Both have their pros and cons, but it also means that
the READ_PLUS response for the same file data written the same way
can be different because the underlying filesystem on the server is
different.

IOWs, the NFS server cannot rely on a specific behaviour w.r.t.
holes and data from the underlying filesystem. Sparseness of a file
is determined by how the underlying filesystem wants to optimise the
physical layout or the data and IO patterns that data access results
in. The NFS server really cannot influence that, or change the
"sparseness" it reports to the client except by examining the
data it reads from the filesystem....

> On fast networks, the less the server's host CPU has to be
> involved in doing the READ, the better it scales. It's
> better to set up the I/O and step out of the way; use zero
> touch as much as possible.

However, as you demonstrate for the NFS client below, something has
to fill the holes. i.e. if we aren't doing sparse reads on the NFS
server, then the filesystem underneath the NFS server has to spend
the CPU to instantiate pages over the hole in the file in the page
cache, then zero them before it can pass them to the "zero touch"
NFS send path to be encoded into the READ reponse.

IOWs, sending holes as zeroed data from the server is most
definitely not zero touch even if NFS doesn't touch the data.

Hence the "sparse read" from the underlying filesystem, which avoids
the need to populate and zero pages in the server page cache
altogether, as well as enabling NFS to use it's zero-touch
encode/send path for the data that is returned. And with a sparse
read operation, the encoding of hole ranges in READ_PLUS has almost
zero CPU overhead because the calculation is dead simple (i.e. hole
start = end of last data, hole len = start of next data - end of
last data).

IOWs, the lowest server CPU and memory READ processing overhead
comes from using READ_PLUS with sparse reads from the filesystem and
zero-touch READ_PLUS data range encoding.

> Likewise on the client: it might receive a CONTENT_HOLE, but
> then its CPU has to zero out that range, with all the memory
> and cache activity that entails. For small holes, that's going
> to be a lot of memset(0). If the server returns holes only
> when they are large, then the client can use more efficient
> techniques (like marking page cache pages or using ZERO_PAGE).

Yes, if we have sparse files we have to take that page cache
instantiation penalty *somewhere* in the IO stack between the client
and the server.

Indeed, we actually want this overhead in the NFS client, because we
have many more NFS clients than we do NFS servers and hence on
aggregate there is way more CPU and memory to dedicate to
instantiating zeroed data on the client side than on the server
side.

IOWs, if we ship zeroes via RDMA to the NFS client so the NFS client
doesn't need to instantiate holes in the page cache, then we're
actually forcing the server to perform hole instantiation. Forcing
the server to instantiate all the holes for all the files that all
the clients it is serving is prohibitive from a server CPU and
memory POV, even if you have the both the server network bandwidth
and the cross-sectional network bandwidth available to ship all
those zeros to all the clients.

> On networks with large bandwidth-latency products, however,
> it makes sense to trade as much server and client CPU and
> memory for transferred bytes as you can.

Server, yes, client not so much. If you focus purely on single
client<->server throughput, the server is not going to scale when
hundreds or thousands of clients all demand data at the same time.

But, regardless of this, the fact is that the NFS server is a
consumer of the sparseness data stored in the underlying filesystem.
Unless it wants to touch every byte that is read, it can only export
the HOLE/DATA information that the filesystem can provide it with.

What we want is a method that allows the filesystem to provide that
information to the NFS server READ_PLUS operation as efficiently as
possible. AFAICT, that's a sparse read operation....

> The mechanism that handles sparse files needs to be distinct
> from the policy of when to return more than a single
> CONTENT_DATA segment, since one of our goals is to ensure
> that READ_PLUS performs and scales as well as READ on common
> workloads (ie, not HPC / large sparse file workloads).

Yes, so make the server operation as efficient as possible whilst
still being correct (i.e. sparse reads), and push the the CPU and
memory requirements for instantiating and storing zeroes out
to the NFS client.  If the NFS client page cache instantiation can't
keep up with the server sending it encoded ranges of zeros, then
this isn't a server side issue; the client side sparse file support
needs fixing/optimising.

> > If the filesystem can support a sparse read, it returns sparse
> > ranges containing data to the NFS server. If the filesystem can't
> > support it, or it's internal file layout doesn't allow for efficient
> > hole/data discrimination, then it can just return the entire read
> > range.
> > 
> > Alternatively, in this latter case, the filesystem could call a
> > generic "sparse read" implementation that runs memchr_inv() to find
> > the first data range to return. Then the NFS server doesn't have to
> > code things differently, filesystems don't need to advertise
> > support for sparse reads, etc because every filesystem could
> > support sparse reads.
> > 
> > The only difference is that some filesystems will be much more
> > efficient and faster at it than others. We already see that sort
> > of thing with btrfs and seek hole/data on large cached files so I
> > don't see "filesystems perform differently" as a problem here...
> 
> The problem with that approach is that will result in
> performance regressions on NFSv4.2 with exports that reside
> on underperforming filesystem types. We need READ_PLUS to
> perform as well as READ so there is no regression between
> NFSv4.2 without and with READ_PLUS, and no regression when
> migrating from NFSv4.1 to NFSv4.2 with READ_PLUS enabled.

Sure, but fear of regressions is not a valid reason for preventing
change from being made.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
