Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5B12746EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 18:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgIVQqS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 12:46:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29944 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726563AbgIVQqS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600793174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0COKN6wBh1I0yIB2iVBkVvjKrye7BB9sLEOg7A1yq5o=;
        b=jLDkHi9lwlE+wD3vmHhZ+HyBTji9F7JyO1pvjcSFG8whKc9cb84Ex+C2z7EvKATCHELmYS
        sgJjuSEuggMgL5cvQw4WCkZgYX4DildXCQbEBD+G3a3ltrcExMyMvEKRQJg2OpYw/Zp/s5
        p2AO7XNH/kjvyDjOz8OPJVcHlKd85TU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-nyffALQROuCV1ukoQ6b4eQ-1; Tue, 22 Sep 2020 12:46:10 -0400
X-MC-Unique: nyffALQROuCV1ukoQ6b4eQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A438A800400;
        Tue, 22 Sep 2020 16:46:07 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE70078831;
        Tue, 22 Sep 2020 16:46:06 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 08MGk6J5010231;
        Tue, 22 Sep 2020 12:46:06 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 08MGk59V010215;
        Tue, 22 Sep 2020 12:46:05 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 22 Sep 2020 12:46:05 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Dave Chinner <david@fromorbit.com>
cc:     Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" 
        <rajesh.tadakamadla@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: NVFS XFS metadata (was: [PATCH] pmem: export the symbols
 __copy_user_flushcache and __copy_from_user_flushcache)
In-Reply-To: <20200922050314.GB12096@dread.disaster.area>
Message-ID: <alpine.LRH.2.02.2009220815420.16480@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com> <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com>
 <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gD0ZFkfajKTDnJhEEjf+5Av-GH+cHRFoyhzGe8bNEgAA@mail.gmail.com> <alpine.LRH.2.02.2009161359540.20710@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009191336380.3478@file01.intranet.prod.int.rdu2.redhat.com> <20200922050314.GB12096@dread.disaster.area>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi

Thanks for reviewing NVFS.


On Tue, 22 Sep 2020, Dave Chinner wrote:

> Hi Mikulas,
> 
> I'll say up front that I think you're barking up the wrong tree
> trying to knock down XFS and ext4 to justify NVFS. NVFS will stand
> or fall on it's own merits, not on how you think it's better than
> other filesystems...
> 
> I have some fundamental concerns about the NVFS integrity model,
> they came out as I wrote this response to your characterisations of
> XFS and journalling filesysetms. Maybe I'm missing something about
> NVFS that isn't clearly explained....
> 
> On Mon, Sep 21, 2020 at 12:20:42PM -0400, Mikulas Patocka wrote:
> > On Wed, 16 Sep 2020, Mikulas Patocka wrote:
> > > On Wed, 16 Sep 2020, Dan Williams wrote:
> > > > On Wed, Sep 16, 2020 at 10:24 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
> > > > >
> > > > > > My first question about nvfs is how it compares to a daxfs with
> > > > > > executables and other binaries configured to use page cache with the
> > > > > > new per-file dax facility?
> > > > >
> > > > > nvfs is faster than dax-based filesystems on metadata-heavy operations
> > > > > because it doesn't have the overhead of the buffer cache and bios. See
> > > > > this: http://people.redhat.com/~mpatocka/nvfs/BENCHMARKS
> > > > 
> > > > ...and that metadata problem is intractable upstream? Christoph poked
> > > > at bypassing the block layer for xfs metadata operations [1], I just
> > > > have not had time to carry that further.
> > > > 
> > > > [1]: "xfs: use dax_direct_access for log writes", although it seems
> > > > he's dropped that branch from his xfs.git
> > > 
> > > XFS is very big. I wanted to create something small.
> > 
> > And the another difference is that XFS metadata are optimized for disks 
> > and SSDs.
> 
> Ah, that old chestnut. :)
> 
> > On disks and SSDs, reading one byte is as costly as reading a full block. 
> > So we must put as much information to a block as possible. XFS uses 
> > b+trees for file block mapping and for directories - it is reasonable 
> > decision because b+trees minimize the number of disk accesses.
> 
> Actually, no, that wasn't why XFS was implemented using btrees. The
> btrees are an implementation detail, not a design requirement to
> minimise the number of disk accesses.
> 
> XFS was intended for huge disk arrays (hundreds to thousands on
> individual spindles) and so no attempt was made in the design to
> minimise disk accesses. There was -always- going to be a huge number
> of IOPS available in the intended large scale deployments, so
> concurrency and *efficiency at scale* was far more important at the
> design level than minimising the number of disk ops for any given
> operation.
> 
> To that end, simulations were done that showed that extent based
> trees were much more CPU, memory and IO efficient than bitmaps,
> hybrid tree-bitmaps or multi-layer indirect block referencing when
> trying to index and access large amounts of data.
> 
> To be efficient at scale, all operations need to be O(log N) or
> better, and extent based encoding is much, more compact than direct
> block indexing. Extent trees are also much more effective for finding
> exact fits, identifying large contiguous spaces, and manipulating
> large ranges of indexed data than other filesystem indexing
> mechanisms.  They are also not bound by alignment restrictions like
> hierarchical binary/buddy bitmap schemes are, and their maximum size
> is bounded and can be calculated at runtime.
> 
> IOWs, extent based trees were chosen because of scalability,
> efficiency, and flexibility reasons before the actual tree structure
> that it would be implemented with was decided on.  b+trees were used
> in the implementation because one tree implementation could do
> everything as all that needed to change btree trees was the pointer
> and record format.

I agree that the b+tree were a good choice for XFS.

In RAM-based maps, red-black trees or avl trees are used often. In 
disk-based maps, btrees or b+trees are used. That's because in RAM, you 
are optimizing for the number of cache lines accessed, and on the disk, 
you are optimizing for the number of blocks accessed.

> The result of this is that we have made -zero- changes to the XFS
> structure and algorithms for SSDs. We don't do different things
> based on the blkdev rotational flag, or anything like that. XFS
> behaves exactly the same on spinning disks as it does SSDs as it
> does PMEM and it performs well on all of them. And that performance
> doesn't drop away as you increase the scale and capability of the
> underlying storage.
> 
> That's what happens when storage algorithms are designed for
> concurrency and efficiency at scale rather than optimising for a
> specific storage characteristic.
> 
> NVFS is optimised for a specific storage characteristic (i.e. low
> latency synchronous storage), so I would absolutely expect it to be
> faster than XFS on that specific storage. However, claims like this:
> 
> > On persistent memory, each access has its own cost, so NVFS uses metadata 
> > structures that minimize the number of cache lines accessed (rather than 
> > the number of blocks accessed). For block mapping, NVFS uses the classic 
> > unix dierct/indirect blocks - if a file block is mapped by a 3-rd level 
> > indirect block, we do just three memory accesses and we are done. If we 
> > used b+trees, the number of accesses would be much larger than 3 (we would 
> > have to do binary search in the b+tree nodes).
> 
> ... are kinda naive, because you're clearly optimising the wrong
> aspect of block mapping. Extents solve the block indexing overhead
> problem; optimising the type of tree you use to index the indirect
> blocks doesn't avoid the overhead of having to iterate every block
> for range operations.
> 
> IOWs, we use extents because they are space and time efficient for
> the general use cases. XFS can map 2^21 blocks into a single 16 byte
> extent record (8GiB file mapping for 4k block size) and so the vast
> majority of files in a filesystem are mapped with a single extent.

BTW. How does XFS "predict" the file size? - so that it allocates extent 
of proper size without knowing how big the file will be?

> The NVFS indirect block tree has a fan-out of 16,

No. The top level in the inode contains 16 blocks (11 direct and 5 
indirect). And each indirect block can have 512 pointers (4096/8). You can 
format the device with larger block size and this increases the fanout 
(the NVFS block size must be greater or equal than the system page size).

2 levels can map 1GiB (4096*512^2), 3 levels can map 512 GiB, 4 levels can 
map 256 TiB and 5 levels can map 128 PiB.

> mapping 2^21 blocks requires a 5 level indirect tree. Which one if going 
> to be faster to truncate away - a single record or 2 million individual 
> blocks?
> 
> IOWs, we can take afford to take an extra cacheline miss or two on a
> tree block search, because we're accessing and managing orders of
> magnitude fewer records in the mapping tree than an indirect block
> tree.
> 
> PMEM doesn't change this: extents are more time and space efficient
> at scale for mapping trees than indirect block trees regardless
> of the storage medium in use.

PMEM doesn't have to be read linearly, so the attempts to allocate large 
linear space are not needed. They won't harm but they won't help either.

That's why NVFS has very simple block allocation alrogithm - it uses a 
per-cpu pointer and tries to allocate by a bit scan from this pointer. If 
the group is full, it tries a random group with above-average number of 
free blocks.

EXT4 uses bit scan for allocations and people haven't complained that it's 
inefficient, so it is probably OK.

> > The same for directories - NVFS hashes the file name and uses radix-tree 
> > to locate a directory page where the directory entry is located. XFS 
> > b+trees would result in much more accesses than the radix-tree.
> 
> That's like me saying that XFS hashes the file name and uses a btree
> to index the directory block where the dirent is located, so it will
> be faster than a radix tree.
> 
> It's completely bogus.
> 
> It ignores the fact that both filesysetms use the same hash based
> lookup indexing algorithms and use O(log N) trees for the name hash.
> IOWs, the only real difference is the fan-out and depths of the
> tree.

NVFS has fanout of 512 pointers per block.

> The end result is that algorithmic performance of name ->
> dirent lookups are going to be *very similar* and, as such, the
> performance differential is going to be dominated by other
> implementation differences.
> 
> Such as the fact that XFS has to buffer the directory metadata,
> hence that the initial directory block lookup cost is higher than
> NVFS. Subsequent block lookups hit the buffer cache, so that
> caching overhead is somewhat amortised over multiple directory
> accesses, but it doesn't get rid of it.
> 
> IOWs, difference in memory accesses between a radix tree and btree
> for this algorithm is largely irrelevant, and even your tests
> indicate that.  The modification tests show that metadata lookup
> *and journalling* overhead is not really that significant as the
> number of directory entries increase:
> 
> dir-test /mnt/test/linux-2.6 63000 1048576
> nvfs		6.6s
> ext4 dax	8.4s
> xfs dax		12.2s
> 
> 
> dir-test /mnt/test/linux-2.6 63000 1048576 link
> nvfs		4.7s
> ext4 dax	5.6s
> xfs dax		7.8s
> 
> dir-test /mnt/test/linux-2.6 63000 1048576 dir
> nvfs		8.2s
> ext4 dax	15.1s
> xfs dax		11.8s
> 
> Yes, nvfs is faster than both ext4 and XFS on DAX, but it's  not a
> huge difference - it's not orders of magnitude faster.

If I increase the size of the test directory, NVFS is order of magnitude 
faster:

time dir-test /mnt/test/ 2000000 2000000
NVFS: 0m29,395s
XFS:  1m59,523s
EXT4: 1m14,176s

time dir-test /mnt/test/ 8000000 8000000
NVFS: 2m13,507s
XFS: 14m31,261s
EXT4: reports "file 1976882 can't be created: No space left on device", 
	(although there are free blocks and inodes)
	Is it a bug or expected behavior?

> If XFS and ext4 directory structures were substantially less
> efficient than the NVFS structure, then NVFS should absolutely
> -slaughter- ext4 and XFS in directory modification intensive
> microbenchmarks like this. Especially considering that difference in
> performance also includes the journalling overhead.
> 
> IOWs, the differences in performance are not a result of the
> directory structures or the number of memory fetches their indexing
> algorithms require to do the work - the differences come from
> structural features: ext4 and XFS have more work to do per
> directory operation thanks to their metadata buffer and journalling
> management requirements.
> 
> Also, keep in mind that much of the complexity in the XFS directory
> structure doesn't make XFS go faster at small directory sizes. They
> actually slow it down at small sizes, but they also stop performance
> from falling off a cliff at scale. Hence results might be quite
> different if you are running with millions of directory entries in
> the directories rather that a few thousand....

See above - the ratio between NVFS and XFS grows as we increase directory 
size.

> > Regarding journaling - NVFS doesn't do it because persistent memory is so 
> > fast that we can just check it in the case of crash. NVFS has a 
> > multithreaded fsck that can do 3 million inodes per second.
> 
> Scanning speed means little when it comes to integrity checking.
> 
> Fast storage can hide a multitude of sins, the least of which is
> inefficient algorithms. More importantly, it can hide crash related
> inconsistencies, because timing the crash to land between two
> specific modifications is much harder on fast storage than it is
> slow storage.
> 
> IOWs, just because fsck can iterate inodes at 3M a second doesn't
> mean the filesystem code is crash safe and correct, nor that fsck
> can detect and correct all the inconsistencies that the
> crash left behind and need fixing. More on this later....
> 
> > XFS does 
> > journaling (it was reasonable decision for disks where fsck took hours) 
> > and it will cause overhead for all the filesystem operations.
> 
> Fundamentally, journalling provides guarantees much more important
> than than "does not need fsck". Journalling provides -atomic
> metadata changes-, and that's something you can't do without some
> variant of journalled, log structured or COW metadata. This is
> important, because atomicity of metadata changes is something users
> actually expect from filesystems.
> 
> Take, for example, truncate. If you punch out the space on storage
> before you change the inode size on storage and then crash
> in-between the punch and the inode size reduction, the user file is
> left with a bunch of zeros in it over the range between the new EOF
> and the old EOF. Users will see partial completion state.
> 
> IOWs, the NVFS truncate operation as implemented:
> 
>         if (attr->ia_valid & ATTR_SIZE) {
>                 WARN_ON(!inode_is_locked(&nmi->vfs_inode));
>                 if (attr->ia_size != nmi->vfs_inode.i_size) {
>                         r = nvfs_punch_hole(nmi, attr->ia_size, LLONG_MAX - ((1UL << nvs->log2_page_size) - 1));
>                         if (unlikely(r))
>                                 return r;
>                         nvfs_set_inode_size(nmi, attr->ia_size);
>                 }
>         }
> 
> is not atomic from a user crash recovery perspective as it exposes
> partially complete state to the user. For it to be atomic from the
> user perspective, on truncate down the inode size must be changed on
> disk first, then the space beyond the new EOF needs to get punched
> out. hence if we crash while the punching is occurring, users will
> not see that after remount because the inconsistent state is beyond
> the range they can access. IOWs, they see the file as if the
> truncate down is fully complete, regardless of whether it is
> actually complete or not.

You are right - these operations should be swapped.

BTW. XFS also had (or still has?) a misfeature that it was leaving 
zero-filed files after a crash.

> However, that then potentially breaks truncate up because,
> conversely, truncate up requires that any blocks already allocated
> beyond EOF needs to be zeroed before the inode size is changed so
> stale data is not exposed between the old EOF and the new EOF....
> 
> Yes, this can be fixed by changing the order of the punch vs the
> inode size change based on what type of operation is actually going
> to be performed, but this is just an example of the complexity
> problem "soft updates" bring to otherwise "simple" operations. I
> haven't even mentioned freeing indirect blocks also updates free
> space, inode i_blocks counters, potentially multiple indirect
> blocks, etc. If the order is wrong, then all bets are off for what
> fsck will actually do with the inode when it scans it and finds
> partially complete state. And even if it gets corrected, there's no
> guarantee taht the entire operation was completed from the
> perspective of the user.
> 
> Rename is another operation that has specific "operation has atomic
> behaviour" expectations. I haven't looked at how you've
> implementated that yet, but I suspect it also is extremely difficult
> to implement in an atomic manner using direct pmem updates to the
> directory structures.

There is a small window when renamed inode is neither in source nor in 
target directory. Fsck will reclaim such inode and add it to lost+found - 
just like on EXT2.

> AFAICS, it is easy to get metadata update ordering wrong, and
> without a formal proof that every single write to storage is
> correctly ordered I can't see how this model can be validated and
> reviewed. It is made exceedingly complex by direct storage access.
> instead of doing all the changes to a single block in memory and
> then only having to order block writes to stable storage correctly
> (as per the BSD filesystem that used soft updates), every direct
> pmem modification to an object needs to be ordered correctly against
> all other direct pmem modifications, both within the object and
> across objects.
> 
> And this brings me back to modification atomicity - soft update
> ordering across objects is hard enough, but how do you perform
> dependent modifications to a single object atomically?
> 
> e.g. Looking at nvfs_setattr, why is it correct to write timestamp
> changes to pmem before the truncate is done?
> 
> And if that is correct behavour, then why is it correct to
> change UID/GID _before_ updating the timestamp?
> 
> And if that is also correct behaviour, then why are mode changes
> done _after both_ uid/gid and timestamp changes? What happens if
> setattr is asked to change ATTR_UID|ATTR_GID|ATTR_MODE as an atomic
> change and we crash before the mode has been changed?

There are syscalls chmod,chown,chgrp that update only one of the flag. I 
don't know if something updates all of them.

Even on journaling filesystems, these updates are cached in memory and the 
journal is flushed asynchronously at some time later. Unless the user 
calls fsync(), it is really unspecified when will the changed attributes 
hit the stable storage.

> I think the only right answer can be "->setattr changes are atomic
> at the stable storage level", in which case the way NVFS is updating
> stable storage breaking all sorts of assumptions and expectations
> for changing security and ownership attributes of the inode.
> 
> And to bring this right back to "fsck is fast so we don't need
> journalling": how would running fsck before mounting detect that
> these compound object updates were not fully completed? How does
> running fsck after the crash guarantee compound object modifications
> it knows nothing about are executed atomically?
> 
> That, too me, looks like a fundamental, unfixable flaw in this
> approach...
> 
> I can see how "almost in place" modification can be done by having
> two copies side by side and updating one while the other is the
> active copy and switching atomically between the two objects. That

NVFS uses this "two copies" mechanism to deal with directories. The inode 
has an entry "__le64 i_radix[2][NVFS_RADIX_BLOCKS];" and a flag 
"NVFS_FLAG_SECOND_DIR_BANK" - when the flag is clear, i_radix[0] is valid, 
when the flag is set, i_radix[1] is valid.

Obviously, it is possible to use this method for updating UID, GID and 
MODE as well, but I am not convinced that they need to be updated 
atomically.

Regarding the timestamps - AFAIK POSIX allow them to be updated lazily.

> way a traditional soft-update algorithm would work because the
> exposure of the changes is via ordering the active copy switches.
> That would come at a cost, though, both in metadata footprint and
> CPU overhead.
> 
> So, what have I missed about the way metadata is updated in the pmem
> that allows non-atomic updates to work reliably?
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

If you think that the lack of journaling is show-stopper, I can implement 
it. But then, I'll have something that has complexity of EXT4 and 
performance of EXT4. So that there will no longer be any reason why to use 
NVFS over EXT4. Without journaling, it will be faster than EXT4 and it may 
attract some users who want good performance and who don't care about GID 
and UID being updated atomically, etc.

Another possibility would be to implement only light journaling that deals 
with rename and setattr - that wouldn't harm because these operations are 
not performance-critical - and leave the rest of the code as is - and 
carefully review it for pmem_wmb() placement. (could you list other 
operations that must be done atomically?)

Mikulas

