Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A66274F36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 04:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgIWCpk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 22:45:40 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:57161 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726835AbgIWCpk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 22:45:40 -0400
Received: from dread.disaster.area (pa49-195-191-192.pa.nsw.optusnet.com.au [49.195.191.192])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 7F6393A8CEB;
        Wed, 23 Sep 2020 12:45:29 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kKume-0004Xc-Ho; Wed, 23 Sep 2020 12:45:28 +1000
Date:   Wed, 23 Sep 2020 12:45:28 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
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
Message-ID: <20200923024528.GD12096@dread.disaster.area>
References: <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com>
 <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gD0ZFkfajKTDnJhEEjf+5Av-GH+cHRFoyhzGe8bNEgAA@mail.gmail.com>
 <alpine.LRH.2.02.2009161359540.20710@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009191336380.3478@file01.intranet.prod.int.rdu2.redhat.com>
 <20200922050314.GB12096@dread.disaster.area>
 <alpine.LRH.2.02.2009220815420.16480@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2009220815420.16480@file01.intranet.prod.int.rdu2.redhat.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=vvDRHhr1aDYKXl+H6jx2TA==:117 a=vvDRHhr1aDYKXl+H6jx2TA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=Fs-i7l_7peG8UdicTSAA:9 a=g6CtbXOWDqCCPWMd:21 a=zH6469xZ6M2oP5u4:21
        a=qmLyBrm5o97BmeHu:21 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 22, 2020 at 12:46:05PM -0400, Mikulas Patocka wrote:
> Thanks for reviewing NVFS.

Not a review - I've just had a cursory look and not looked any
deeper after I'd noticed various red flags...

> On Tue, 22 Sep 2020, Dave Chinner wrote:
> > IOWs, extent based trees were chosen because of scalability,
> > efficiency, and flexibility reasons before the actual tree structure
> > that it would be implemented with was decided on.  b+trees were used
> > in the implementation because one tree implementation could do
> > everything as all that needed to change btree trees was the pointer
> > and record format.
> 
> I agree that the b+tree were a good choice for XFS.
> 
> In RAM-based maps, red-black trees or avl trees are used often. In 
> disk-based maps, btrees or b+trees are used. That's because in RAM, you 
> are optimizing for the number of cache lines accessed, and on the disk, 
> you are optimizing for the number of blocks accessed.

https://lore.kernel.org/linux-fsdevel/20190416122240.GN29573@dread.disaster.area/

"FWIW, I'm not convinced about the scalability of the rb/interval
tree, to tell you the truth. We got rid of the rbtree in XFS for
cache indexing because the multi-level pointer chasing was just too
expensive to do under a spinlock - it's just not a cache efficient
structure for random index object storage."

All the work I've done since has reinforced this - small node
RCU-aware btrees (4 cachelines per node) scale much, much better
than rbtrees, and they can be made lockless, too.

One of the reasons that btrees are more efficient in memory is the
behaviour of modern CPUs and their hardware prefetchers. It is
actually more time efficient to do a linear search of a small node
and then move to another small node than it is to do a binary search
of a large node in memory.  The CPU usage trade-off between linear
search overhead and chasing another pointer is currently somewhere
between 4 and 8 cachelines or pointers/records in a node on modern
x86-64 CPUs.

SO, yeah, btrees are actually very efficient for in-memory indexes
for the same reasons they are efficient for on-disk structures -
they pack more information per node than a binary structure, and
it's faster to search within a node than is to fetch another node...

> > The result of this is that we have made -zero- changes to the XFS
> > structure and algorithms for SSDs. We don't do different things
> > based on the blkdev rotational flag, or anything like that. XFS
> > behaves exactly the same on spinning disks as it does SSDs as it
> > does PMEM and it performs well on all of them. And that performance
> > doesn't drop away as you increase the scale and capability of the
> > underlying storage.
> > 
> > That's what happens when storage algorithms are designed for
> > concurrency and efficiency at scale rather than optimising for a
> > specific storage characteristic.
> > 
> > NVFS is optimised for a specific storage characteristic (i.e. low
> > latency synchronous storage), so I would absolutely expect it to be
> > faster than XFS on that specific storage. However, claims like this:
> > 
> > > On persistent memory, each access has its own cost, so NVFS uses metadata 
> > > structures that minimize the number of cache lines accessed (rather than 
> > > the number of blocks accessed). For block mapping, NVFS uses the classic 
> > > unix dierct/indirect blocks - if a file block is mapped by a 3-rd level 
> > > indirect block, we do just three memory accesses and we are done. If we 
> > > used b+trees, the number of accesses would be much larger than 3 (we would 
> > > have to do binary search in the b+tree nodes).
> > 
> > ... are kinda naive, because you're clearly optimising the wrong
> > aspect of block mapping. Extents solve the block indexing overhead
> > problem; optimising the type of tree you use to index the indirect
> > blocks doesn't avoid the overhead of having to iterate every block
> > for range operations.
> > 
> > IOWs, we use extents because they are space and time efficient for
> > the general use cases. XFS can map 2^21 blocks into a single 16 byte
> > extent record (8GiB file mapping for 4k block size) and so the vast
> > majority of files in a filesystem are mapped with a single extent.
> 
> BTW. How does XFS "predict" the file size? - so that it allocates extent 
> of proper size without knowing how big the file will be?

Oh, there's probably 10-15,000 lines of code involved in getting
that right. There's delayed allocation, speculative preallocation,
extent size hints, about 10 distinct allocation policies including
"allocate exactly at this block or fail" that allow complex
poilicies with multiple fallback conditions to select the best
possible allocation for the given state, there's locality separation
that tries to keep individual workloads in different large
contiguous free spaces, etc.

> > The NVFS indirect block tree has a fan-out of 16,
> 
> No. The top level in the inode contains 16 blocks (11 direct and 5 
> indirect). And each indirect block can have 512 pointers (4096/8). You can 
> format the device with larger block size and this increases the fanout 
> (the NVFS block size must be greater or equal than the system page size).
> 
> 2 levels can map 1GiB (4096*512^2), 3 levels can map 512 GiB, 4 levels can 
> map 256 TiB and 5 levels can map 128 PiB.

Ok, so that's not clear from the docco or the code. But it just
means the fanout is the same as a btree block in a 4kB block size
filesystem. It doesn't really change anything....

> > mapping 2^21 blocks requires a 5 level indirect tree. Which one if going 
> > to be faster to truncate away - a single record or 2 million individual 
> > blocks?
> > 
> > IOWs, we can take afford to take an extra cacheline miss or two on a
> > tree block search, because we're accessing and managing orders of
> > magnitude fewer records in the mapping tree than an indirect block
> > tree.
> > 
> > PMEM doesn't change this: extents are more time and space efficient
> > at scale for mapping trees than indirect block trees regardless
> > of the storage medium in use.
> 
> PMEM doesn't have to be read linearly, so the attempts to allocate large 
> linear space are not needed. They won't harm but they won't help either.

I beg to differ. If the application wants to map huge pages (2MB or
1GB) because tehy get a major improvement in performance by reducing
TLB thrashing, then the filesystem needs to be able to allocate
large contiguous ranges and to be able to do it reliably and
repeatedly.

This is one of the things that DAX can do already (i.e. support huge
pages for mmap() file data) that the page cache can't do. You can
use this with XFS e.g. via extent size hints, using the RT device
with a fixed 2MB block size, etc. This really is a major feature
that users want in any DAX capable filesystem....

> That's why NVFS has very simple block allocation alrogithm - it uses a 
> per-cpu pointer and tries to allocate by a bit scan from this pointer. If 
> the group is full, it tries a random group with above-average number of 
> free blocks.
> 
> EXT4 uses bit scan for allocations and people haven't complained that it's 
> inefficient, so it is probably OK.

You haven't been paying attention :)

The ext4 bitmap allocator algorithms fall in a hole as soon as all
the block group bitmaps get space allocated in them. Then the
allocator has to start searching block groups for the "best free
space" to allocate out of and that has substantial overhead. The
larger the filesystem, the bigger the hole it can fall into....

> > > The same for directories - NVFS hashes the file name and uses radix-tree 
> > > to locate a directory page where the directory entry is located. XFS 
> > > b+trees would result in much more accesses than the radix-tree.
> > 
> > That's like me saying that XFS hashes the file name and uses a btree
> > to index the directory block where the dirent is located, so it will
> > be faster than a radix tree.
> > 
> > It's completely bogus.
> > 
> > It ignores the fact that both filesysetms use the same hash based
> > lookup indexing algorithms and use O(log N) trees for the name hash.
> > IOWs, the only real difference is the fan-out and depths of the
> > tree.
> 
> NVFS has fanout of 512 pointers per block.

Sure, but the difference is still only "the fan-out and depths of
the tree". The directory structure algorithms are still the same.

> > IOWs, difference in memory accesses between a radix tree and btree
> > for this algorithm is largely irrelevant, and even your tests
> > indicate that.  The modification tests show that metadata lookup
> > *and journalling* overhead is not really that significant as the
> > number of directory entries increase:
> > 
> > dir-test /mnt/test/linux-2.6 63000 1048576
> > nvfs		6.6s
> > ext4 dax	8.4s
> > xfs dax		12.2s
> > 
> > 
> > dir-test /mnt/test/linux-2.6 63000 1048576 link
> > nvfs		4.7s
> > ext4 dax	5.6s
> > xfs dax		7.8s
> > 
> > dir-test /mnt/test/linux-2.6 63000 1048576 dir
> > nvfs		8.2s
> > ext4 dax	15.1s
> > xfs dax		11.8s
> > 
> > Yes, nvfs is faster than both ext4 and XFS on DAX, but it's  not a
> > huge difference - it's not orders of magnitude faster.
> 
> If I increase the size of the test directory, NVFS is order of magnitude 
> faster:
> 
> time dir-test /mnt/test/ 2000000 2000000
> NVFS: 0m29,395s
> XFS:  1m59,523s
> EXT4: 1m14,176s

What happened to NVFS there? The runtime went up by a factor of 5,
even though the number of ops performed only doubled.

> time dir-test /mnt/test/ 8000000 8000000
> NVFS: 2m13,507s
> XFS: 14m31,261s
> EXT4: reports "file 1976882 can't be created: No space left on device", 
> 	(although there are free blocks and inodes)
> 	Is it a bug or expected behavior?

Exponential increase in runtime for a workload like this indicates
the XFS journal is too small to run large scale operations. I'm
guessing you're just testing on a small device?

That guess is backed up by the ext4 error  - it indicates a
relatively small device/filesystem is being used because it ran out
of inodes.  2 million inodes would indicate a 32GB filesystem with
mkfs.ext4 defaults, IIRC.

In which case, you'd get a 16MB log for XFS, which is tiny and most
definitely will limit performance of any large scale metadta
operation. Performance should improve significantly for large scale
operations with a much larger log, and that should bring the XFS
runtimes down significantly.

However, I suspect that the journalling overhead of randomly modifying
a gigabyte of directory metadata is going to be the dominating
performance factor here for both XFS and ext4. As I said, I expect
that something like NVFS should -slaughter- both ext4 and XFS on
workloads like this....

> > If XFS and ext4 directory structures were substantially less
> > efficient than the NVFS structure, then NVFS should absolutely
> > -slaughter- ext4 and XFS in directory modification intensive
> > microbenchmarks like this. Especially considering that difference in
> > performance also includes the journalling overhead.
> > 
> > IOWs, the differences in performance are not a result of the
> > directory structures or the number of memory fetches their indexing
> > algorithms require to do the work - the differences come from
> > structural features: ext4 and XFS have more work to do per
> > directory operation thanks to their metadata buffer and journalling
> > management requirements.
> > 
> > Also, keep in mind that much of the complexity in the XFS directory
> > structure doesn't make XFS go faster at small directory sizes. They
> > actually slow it down at small sizes, but they also stop performance
> > from falling off a cliff at scale. Hence results might be quite
> > different if you are running with millions of directory entries in
> > the directories rather that a few thousand....
> 
> See above - the ratio between NVFS and XFS grows as we increase directory 
> size.

Yup, journal size limitations will do that :/

> > Take, for example, truncate. If you punch out the space on storage
> > before you change the inode size on storage and then crash
> > in-between the punch and the inode size reduction, the user file is
> > left with a bunch of zeros in it over the range between the new EOF
> > and the old EOF. Users will see partial completion state.
> > 
> > IOWs, the NVFS truncate operation as implemented:
> > 
> >         if (attr->ia_valid & ATTR_SIZE) {
> >                 WARN_ON(!inode_is_locked(&nmi->vfs_inode));
> >                 if (attr->ia_size != nmi->vfs_inode.i_size) {
> >                         r = nvfs_punch_hole(nmi, attr->ia_size, LLONG_MAX - ((1UL << nvs->log2_page_size) - 1));
> >                         if (unlikely(r))
> >                                 return r;
> >                         nvfs_set_inode_size(nmi, attr->ia_size);
> >                 }
> >         }
> > 
> > is not atomic from a user crash recovery perspective as it exposes
> > partially complete state to the user. For it to be atomic from the
> > user perspective, on truncate down the inode size must be changed on
> > disk first, then the space beyond the new EOF needs to get punched
> > out. hence if we crash while the punching is occurring, users will
> > not see that after remount because the inconsistent state is beyond
> > the range they can access. IOWs, they see the file as if the
> > truncate down is fully complete, regardless of whether it is
> > actually complete or not.
> 
> You are right - these operations should be swapped.
> 
> BTW. XFS also had (or still has?) a misfeature that it was leaving 
> zero-filed files after a crash.

That's entirely irrelevant to NVFS and this discussion.

Mikulas, I prefixed my previous comments with "you gain nothing by
putting other filesytsems down to try to make NVFS look good".  You
haven't gained anything by making this comment - it lost you lost a
lot of my goodwill, though...

FYI, that XFS bug was fixed in -2006-.

> > Rename is another operation that has specific "operation has atomic
> > behaviour" expectations. I haven't looked at how you've
> > implementated that yet, but I suspect it also is extremely difficult
> > to implement in an atomic manner using direct pmem updates to the
> > directory structures.
> 
> There is a small window when renamed inode is neither in source nor in 
> target directory. Fsck will reclaim such inode and add it to lost+found - 
> just like on EXT2.

That might have been good enough for the mid 1990s (it wasn't, given
that's when XFS was designed) but it's not good enough for a new
filesystem in 2020.

> > AFAICS, it is easy to get metadata update ordering wrong, and
> > without a formal proof that every single write to storage is
> > correctly ordered I can't see how this model can be validated and
> > reviewed. It is made exceedingly complex by direct storage access.
> > instead of doing all the changes to a single block in memory and
> > then only having to order block writes to stable storage correctly
> > (as per the BSD filesystem that used soft updates), every direct
> > pmem modification to an object needs to be ordered correctly against
> > all other direct pmem modifications, both within the object and
> > across objects.
> > 
> > And this brings me back to modification atomicity - soft update
> > ordering across objects is hard enough, but how do you perform
> > dependent modifications to a single object atomically?
> > 
> > e.g. Looking at nvfs_setattr, why is it correct to write timestamp
> > changes to pmem before the truncate is done?
> > 
> > And if that is correct behavour, then why is it correct to
> > change UID/GID _before_ updating the timestamp?
> > 
> > And if that is also correct behaviour, then why are mode changes
> > done _after both_ uid/gid and timestamp changes? What happens if
> > setattr is asked to change ATTR_UID|ATTR_GID|ATTR_MODE as an atomic
> > change and we crash before the mode has been changed?
> 
> There are syscalls chmod,chown,chgrp that update only one of the flag. I 
> don't know if something updates all of them.

You've missed the point completely.

My point is that anything -external- to the filesystem could build
an arbitrary set of flags and will rightfully expect them to be
changed -atomically- by the filesystem. NVFS does not apply them
atomically to stable storage, so it would appear to violate the
assumption that callers of ->setattr make.

Further, the set of flags or the combinations can change from kernel
to kernel. Hence if you order the operations according to what you
see syscalls currently do, then any future change to the way
->setattr is called can break your integrity model. You might not
even be aware of these changes because they are in compeltely
different parts of the kernel.

IOws, you can't say "this order of non-atomic changes is correct"
because a) you can't control the combinations of changes sent to the
filesystem, and b) you do not know what future changes might occur
to the VFS API that may completely invalidate your inode update
ordering assumptions. IOWs, your integrity model cannot rely on the
external filesystem APIs always behaving as they do in the current
kernel.

> Even on journaling filesystems, these updates are cached in memory and the 
> journal is flushed asynchronously at some time later. Unless the user 
> calls fsync(), it is really unspecified when will the changed attributes 
> hit the stable storage.

That's also missing the point. When journalling, the change is
atomic in memory until the journal is flushed, and then it is
-atomic on stable storage- because the entire set of changes are
contained within a single atomic transaction unit stored in said
stable storage. At no point in time does the modification appear to
either the user or in stable storage in a partial or incomplete
state.

The problem I'm pointing out is that NVFS is not making these
multiple changes in a single atomic operation - it is making them in
multiple disjoint operations and hence creating conditions where
partially modified state can be exposed if the system crashes.  This
state my be undetectable from a filesystem consistency point of
view, but from a system/application point of view it might well be
very incorrect...

> > I think the only right answer can be "->setattr changes are atomic
> > at the stable storage level", in which case the way NVFS is updating
> > stable storage breaking all sorts of assumptions and expectations
> > for changing security and ownership attributes of the inode.
> > 
> > And to bring this right back to "fsck is fast so we don't need
> > journalling": how would running fsck before mounting detect that
> > these compound object updates were not fully completed? How does
> > running fsck after the crash guarantee compound object modifications
> > it knows nothing about are executed atomically?
> > 
> > That, too me, looks like a fundamental, unfixable flaw in this
> > approach...
> > 
> > I can see how "almost in place" modification can be done by having
> > two copies side by side and updating one while the other is the
> > active copy and switching atomically between the two objects. That
> 
> NVFS uses this "two copies" mechanism to deal with directories. The inode 
> has an entry "__le64 i_radix[2][NVFS_RADIX_BLOCKS];" and a flag 
> "NVFS_FLAG_SECOND_DIR_BANK" - when the flag is clear, i_radix[0] is valid, 
> when the flag is set, i_radix[1] is valid.

Great.

But nobody knows this because it's not in your documentation, and
there isn't a single comment in the entire directory implementation
that explains how it works. IOWs, the NVFS code is -unreviewable-
because nobody knows anything about the design it is supposed to be
implementing and the implementation itself is entirely
undocumented...

FWIW, if you duplicated the whole inode instead of just the indirect
block tree, then you could do the "bank switch" at the inode level.
Then all inode updates could be made atomic, along with the indirect
block mapping updates, etc.

> Obviously, it is possible to use this method for updating UID, GID and 
> MODE as well, but I am not convinced that they need to be updated 
> atomically.
> Regarding the timestamps - AFAIK POSIX allow them to be updated lazily.

Again, focusing on a specific exmaple misses the entire point I was
making - inode updates need to be atomic and ordered against things
that the inode update may be dependent on.

> If you think that the lack of journaling is show-stopper, I can implement 
> it.

I did not say that. My comments are about the requirement for
atomicity of object changes, not journalling. Journalling is an
-implementation that can provide change atomicity-, it is not a
design constraint for metadata modification algorithms.

Really, you can chose how to do object update however you want. What
I want to review is the design documentation and a correctness proof
for whatever mechanism you choose to use. Without that information,
we have absolutely no chance of reviewing the filesystem
implementation for correctness. We don't need a proof for something
that uses journalling (because we all know how that works), but for
something that uses soft updates we most definitely need the proof
of correctness for the update algorithm before we can determine if
the implementation is good...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
