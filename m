Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 398A2D2755
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2019 12:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbfJJKkB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 06:40:01 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:44364 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726524AbfJJKj5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 06:39:57 -0400
Received: from dread.disaster.area (pa49-195-199-207.pa.nsw.optusnet.com.au [49.195.199.207])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 8EAC7363939;
        Thu, 10 Oct 2019 21:39:50 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iIVrJ-0002Pu-Fz; Thu, 10 Oct 2019 21:39:49 +1100
Date:   Thu, 10 Oct 2019 21:39:49 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, Jeff Layton <jlayton@kernel.org>,
        Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: Lease semantic proposal
Message-ID: <20191010103949.GJ16973@dread.disaster.area>
References: <20190923190853.GA3781@iweiny-DESK2.sc.intel.com>
 <20190923222620.GC16973@dread.disaster.area>
 <20190925234602.GB12748@iweiny-DESK2.sc.intel.com>
 <20190930084233.GO16973@dread.disaster.area>
 <20191001210156.GB5500@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001210156.GB5500@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=U3CgBz6+VuTzJ8lMfNbwVQ==:117 a=U3CgBz6+VuTzJ8lMfNbwVQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=7-415B0cAAAA:8 a=ggloQwHdSGxR348sj_4A:9 a=jAk1Iep39hKxJieh:21
        a=cqC_HWLn8bbLdgcc:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 01, 2019 at 02:01:57PM -0700, Ira Weiny wrote:
> On Mon, Sep 30, 2019 at 06:42:33PM +1000, Dave Chinner wrote:
> > On Wed, Sep 25, 2019 at 04:46:03PM -0700, Ira Weiny wrote:
> > > On Tue, Sep 24, 2019 at 08:26:20AM +1000, Dave Chinner wrote:
> > > > Hence, AFIACT, the above definition of a F_RDLCK|F_LAYOUT lease
> > > > doesn't appear to be compatible with the semantics required by
> > > > existing users of layout leases.
> > > 
> > > I disagree.  Other than the addition of F_UNBREAK, I think this is consistent
> > > with what is currently implemented.  Also, by exporting all this to user space
> > > we can now write tests for it independent of the RDMA pinning.
> > 
> > The current usage of F_RDLCK | F_LAYOUT by the pNFS code allows
> > layout changes to occur to the file while the layout lease is held.
> 
> This was not my understanding.

These are the remote procerdeure calls that the pNFS client uses to
map and/or allocate space in the file it has a lease on:

struct export_operations {
....
        int (*map_blocks)(struct inode *inode, loff_t offset,
                          u64 len, struct iomap *iomap,
                          bool write, u32 *device_generation);
        int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
                             int nr_iomaps, struct iattr *iattr);
};

.map_blocks() allows the pnfs client to allocate blocks in the
storage.  .commit_blocks() is called once the write is complete to
do things like unwritten extent conversion on extents that it
allocated. In the XFS implementation of these methods, they call
directly into the XFS same block mapping code that the
read/write/mmap IO paths call into.

A typical pNFS use case is a HPC clusters, where thousands of nodes
might all be writing to separate parts of a huge sparse file (e.g.
out of core sparse matrix solver) and are reading/writing direct to
the storage via iSER or some other low level IB/RDMA storage
protocol.  Every write on every pNFS client needs space allocation,
so the pNFS server is basically just providing a remote interface to
the XFS space allocation interfaces for direct IO on the pNFS
clients.

IOWs, there can be thousands of concurrent pNFS layout leases on a
single inode at any given time and they can all be allocating space,
too.

> > IOWs, your definition of F_RDLCK | F_LAYOUT not being allowed
> > to change the is in direct contradition to existing users.
> > 
> > I've said this several times over the past few months now: shared
> > layout leases must allow layout modifications to be made.
> 
> I don't understand what the point of having a layout lease is then?

It's a *notification* mechanism.

Multiple processes can modify the file layout at the same time -
XFs was designed as a multi-write filesystem from the ground up and
we make use of that with shared IO locks for direct IO writes. 

The read layout lease model we've used for pNFS is essentially the
same concurrent writer model that direct IO in XFS uses. And to
enable concurrent writers, we use shared locking for the the layout
leases.

IOWs, the pNFS client IO model is very similar to local direct IO,
except for the fact they can remotely cache layout mappings.  Hence
if you do a server-side local buffered write (delayed allocation),
truncate, punch a hole, etc, (or a remote operation through the NFS
server that ends up in these same paths) the mappings those pNFS
clients hold are no longer guaranteed to cover valid data and/or
have correct physical mappings for valid data held on the server.

At this point, the layouts need to be invalidated, and so the layout
lease is broken by the filesystem operations that may cause an
issue. The pNFS server reacts to the lease break by recalling the
client layout(s) and the pNFS client has to request a new layout
from the server to be able to directly access the storage again.

i.e. the layout lease is primarily a *notification* mechanism to
allow safe interop between application level direct access
mechanisms and local filesystem access.

What you are trying to do is turn this multi-writer layout lease
notification mechanism into a single writer access control
mechanism. i.e. F_UNBREAK is all about /control/ of the layout and
who can and can't modify it, regardless of whether they write
permissions have been granted or not.

It seems I have been unable to get this point across despite trying
for months now: access control is not a function provided by layout
leases. If you need to guarantee exclusive access to a file so
nobody else can modify it, direct access or through the filesystem,
then that is what permission bits, ACLs, file locks, LSMs, etc are
for. Don't try to overload a layout change notification mechanism
with data access controls.

> I apologize for not understanding this.  My reading of the code is that layout
> changes require the read layout to be broken prior to proceeding.

There's a difference between additive layout changes (such as
allocating unwritten extents over a hole before a write) that don't
pose any risk of uninitialised data exposure or use-after free.
These sorts of layout changes are allowed while holding a layout
lease.

pNFS clients can only do additive changes to the layout via the
export ops above. Further, technically speaking (because we don't
currently implement this), local direct IO read/write is allowed
without breaking layout leases as DIO writes can only trigger
additive changes to the layout.

The layout changes we need notification about (i.e. lease breaks)
are subtractive layout changes (truncate, hole punch, copy-on-write)
and ethereal layout changes (e.g. delayed allocation, where data is
in memory but has no physical space allocated). Those are the ones
that lead to problems with direct access, either in terms of
in-correct in-memory state (pages mapped into RDMA hardware that no
longer have backing store) or the file mapping the application has
cached (e.g. via fiemap or pNFS file layouts) is no longer valid.

These subtractive/ethereal layout changes are the ones that need to
break _all_ outstanding layout leases, because nobody knows ahead of
time which applications might be impacted by the layout modification
that is about to occur.

IOWs, layout leases are not intended to directly control who can and
who can't modify the layout of a file, they are for issuing
notifications to parties using direct storage access that a
potentially dangerous layout change is about to be made to a file
they are directly accessing....

> The break layout code does this by creating a F_WRLCK of type FL_LAYOUT which
> conflicts with the F_RDLCK of type FL_LAYOUT...

Yes, but that's an internal implementation detail of how leases are
broken. __break_lease(O_WRONLY) means "break all leases", and it
does that by creating a temporary exclusive lease and then breaking
all the leases on the inode that conflict with that lease. Which, by
definition, is all of the leases of the same type. It never attaches
that temporary lease to the inode - it is only used for comparison
and is discarded once the lease break is done.

That doesn't mean this behaviour is intended to be part of the
visible layout lease user API, nor that it means F_WRLCK layout
leases are something that is supposed to provide exlusive
modification access to the file layout. It's just an implementation
mechanism that simplifies breaking existing leases.

> Also, I don't see any code which limits the number of read layout holders which
> can be present

There is no limit on the number of holders that can have read
layouts...

> and all of them will be revoked by the above code.

Yup, that's what breaking leases does right now - it notifies all
lease holders that a potentially problematic layout change is about
to be made.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
