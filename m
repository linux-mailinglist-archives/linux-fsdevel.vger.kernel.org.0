Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94B74776A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 17:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238807AbhLPQFy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 11:05:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26715 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238792AbhLPQFy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:05:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639670753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2StRxbNizX8Gdbhg2udTDHkaxelaPX07LE/YtJGTHRE=;
        b=LcuUfRuoZ5tuHO3NtNfaLD51puGEVVnLxATAJonPSq6vw89wF6+t9xOMdM7b+Zdua4ubod
        gQK7vE3QQ9NdRv+p0pg2hF29rQLH/puJDp8N20vDvrfYUBlfTxG08Ce8cDtKHUrF2QERgG
        E2MSPIogkKkrr5+Fmhu9CyHfj891iQY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-Gq2BU7HzNJK2OpTzbFpsoA-1; Thu, 16 Dec 2021 11:05:50 -0500
X-MC-Unique: Gq2BU7HzNJK2OpTzbFpsoA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC2388710FC;
        Thu, 16 Dec 2021 16:05:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 096035BE32;
        Thu, 16 Dec 2021 16:05:39 +0000 (UTC)
Subject: [PATCH v3 00/68] fscache, cachefiles: Rewrite
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     v9fs-developer@lists.sourceforge.net,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Steve French <sfrench@samba.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 16 Dec 2021 16:05:39 +0000
Message-ID: <163967073889.1823006.12237147297060239168.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a set of patches implements a rewrite of the fscache driver and a
matching rewrite of the cachefiles driver, significantly simplifying the
code compared to what's upstream, removing the complex operation scheduling
and object state machine in favour of something much smaller and simpler.

The patchset is structured such that the first few patches disable fscache
use by the network filesystems using it, remove the cachefiles driver
entirely and as much of the fscache driver as can be got away with without
causing build failures in the network filesystems.  The patches after that
recreate fscache and then cachefiles, attempting to add the pieces in a
logical order.  Finally, the filesystems are reenabled and then the very
last patch changes the documentation.


WHY REWRITE?
============

Fscache's operation scheduling API was intended to handle sequencing of
cache operations, which were all required (where possible) to run
asynchronously in parallel with the operations being done by the network
filesystem, whilst allowing the cache to be brought online and offline and
to interrupt service for invalidation.

With the advent of the tmpfile capacity in the VFS, however, an opportunity
arises to do invalidation much more simply, without having to wait for I/O
that's actually in progress: Cachefiles can simply create a tmpfile, cut
over the file pointer for the backing object attached to a cookie and
abandon the in-progress I/O, dismissing it upon completion.

Future work here would involve using Omar Sandoval's vfs_link() with
AT_LINK_REPLACE[1] to allow an extant file to be displaced by a new hard
link from a tmpfile as currently I have to unlink the old file first.

These patches can also simplify the object state handling as I/O operations
to the cache don't all have to be brought to a stop in order to invalidate
a file.  To that end, and with an eye on to writing a new backing cache
model in the future, I've taken the opportunity to simplify the indexing
structure.

I've separated the index cookie concept from the file cookie concept by C
type now.  The former is now called a "volume cookie" (struct
fscache_volume) and there is a container of file cookies.  There are then
just the two levels.  All the index cookie levels are collapsed into a
single volume cookie, and this has a single printable string as a key.  For
instance, an AFS volume would have a key of something like
"afs,example.com,1000555", combining the filesystem name, cell name and
volume ID.  This is freeform, but must not have '/' chars in it.

I've also eliminated all pointers back from fscache into the network
filesystem.  This required the duplication of a little bit of data in the
cookie (cookie key, coherency data and file size), but it's not actually
that much.  This gets rid of problems with making sure we keep netfs data
structures around so that the cache can access them.

These patches mean that most of the code that was in the drivers before is
simply gone and those drivers are now almost entirely new code.  That being
the case, there doesn't seem any particular reason to try and maintain
bisectability across it.  Further, there has to be a point in the middle
where things are cut over as there's a single point everything has to go
through (ie. /dev/cachefiles) and it can't be in use by two drivers at
once.


ISSUES YET OUTSTANDING
======================

There are some issues still outstanding, unaddressed by this patchset, that
will need fixing in future patchsets, but that don't stop this series from
being usable:

 (1) The cachefiles driver needs to stop using the backing filesystem's
     metadata to store information about what parts of the cache are
     populated.  This is not reliable with modern extent-based filesystems.

     Fixing this is deferred to a separate patchset as it involves
     negotiation with the network filesystem and the VM as to how much data
     to download to fulfil a read - which brings me on to (2)...

 (2) NFS and CIFS do not take account of how the cache would like I/O to be
     structured to meet its granularity requirements.  Previously, the
     cache used page granularity, which was fine as the network filesystems
     also dealt in page granularity, and the backing filesystem (ext4, xfs
     or whatever) did whatever it did out of sight.  However, we now have
     folios to deal with and the cache will now have to store its own
     metadata to track its contents.

     The change I'm looking at making for cachefiles is to store content
     bitmaps in one or more xattrs and making a bit in the map correspond
     to something like a 256KiB block.  However, the size of an xattr and
     the fact that they have to be read/updated in one go means that I'm
     looking at covering 1GiB of data per 512-byte map and storing each map
     in an xattr.  Cachefiles has the potential to grow into a fully
     fledged filesystem of its very own if I'm not careful.

     However, I'm also looking at changing things even more radically and
     going to a different model of how the cache is arranged and managed -
     one that's more akin to the way, say, openafs does things - which
     brings me on to (3)...

 (3) The way cachefilesd does culling is very inefficient for large caches
     and it would be better to move it into the kernel if I can as
     cachefilesd has to keep asking the kernel if it can cull a file.
     Changing the way the backend works would allow this to be addressed.


BITS THAT MAY BE CONTROVERSIAL
==============================

There are some bits I've added that may be controversial:

 (1) I've provided a flag, S_KERNEL_FILE, that cachefiles uses to check if
     a files is already being used by some other kernel service (e.g. a
     duplicate cachefiles cache in the same directory) and reject it if it
     is.  This isn't entirely necessary, but it helps prevent accidental
     data corruption.

     I don't want to use S_SWAPFILE as that has other effects, but quite
     possibly swapon() should set S_KERNEL_FILE too.

     Note that it doesn't prevent userspace from interfering, though
     perhaps it should.  (I have made it prevent a marked directory from
     being rmdir-able).

 (2) Cachefiles wants to keep the backing file for a cookie open whilst we
     might need to write to it from network filesystem writeback.  The
     problem is that the network filesystem unuses its cookie when its file
     is closed, and so we have nothing pinning the cachefiles file open and
     it will get closed automatically after a short time to avoid
     EMFILE/ENFILE problems.

     Reopening the cache file, however, is a problem if this is being done
     due to writeback triggered by exit().  Some filesystems will oops if
     we try to open a file in that context because they want to access
     current->fs or suchlike.

     To get around this, I added the following:

     (A) An inode flag, I_PINNING_FSCACHE_WB, to be set on a network
     	 filesystem inode to indicate that we have a usage count on the
     	 cookie caching that inode.

     (B) A flag in struct writeback_control, unpinned_fscache_wb, that is
     	 set when __writeback_single_inode() clears the last dirty page
     	 from i_pages - at which point it clears I_PINNING_FSCACHE_WB and
     	 sets this flag.

	 This has to be done here so that clearing I_PINNING_FSCACHE_WB can
	 be done atomically with the check of PAGECACHE_TAG_DIRTY that
	 clears I_DIRTY_PAGES.

     (C) A function, fscache_set_page_dirty(), which if it is not set, sets
     	 I_PINNING_FSCACHE_WB and calls fscache_use_cookie() to pin the
     	 cache resources.

     (D) A function, fscache_unpin_writeback(), to be called by
     	 ->write_inode() to unuse the cookie.

     (E) A function, fscache_clear_inode_writeback(), to be called when the
     	 inode is evicted, before clear_inode() is called.  This cleans up
     	 any lingering I_PINNING_FSCACHE_WB.

     The network filesystem can then use these tools to make sure that
     fscache_write_to_cache() can write locally modified data to the cache
     as well as to the server.

     For the future, I'm working on write helpers for netfs lib that should
     allow this facility to be removed by keeping track of the dirty
     regions separately - but that's incomplete at the moment and is also
     going to be affected by folios, one way or another, since it deals
     with pages.


These patches can be found also on:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-rewrite

David


Changes
=======
ver #3:
 - Fixed a race in the cookie state machine between LRU discard and
   relinquishment[4].
 - Fixed up the hashing to make it portable[5].
 - Fixed up some netfs coherency data to make it portable.
 - Fixed some missing NFS_FSCACHE=n fallback functions in nfs[6].
 - Added a patch to store volume coherency data in an xattr.
 - Added a check that the cookie is unhashed before being freed.
 - Fixed fscache to use remove_proc_subtree() to remove /proc/fs/fscache/.

ver #2:
 - Fix an unused-var warning due to CONFIG_9P_FSCACHE=n.
 - Use gfpflags_allow_blocking() rather than using flag directly.
 - Fixed some error logging in a couple of cachefiles functions.
 - Fixed an error check in the fscache volume allocation.
 - Need to unmark an inode we've moved to the graveyard before unlocking.
 - Upgraded to -rc4 to allow for upstream changes to cifs.
 - Should only change to inval state if can get access to cache.
 - Don't hold n_accesses elevated whilst cache is bound to a cookie, but
   rather add a flag that prevents the state machine from being queued when
   n_accesses reaches 0.
 - Remove the unused cookie pointer field from the fscache_acquire
   tracepoint. 
 - Added missing transition to LRU_DISCARDING state.
 - Added two ceph patches from Jeff Layton[2].
 - Remove NFS_INO_FSCACHE as it's no longer used.
 - In NFS, need to unuse a cookie on file-release, not inode-clear.
 - Filled in the NFS cache I/O routines, borrowing from the previously posted
   fallback I/O code[3].
 

Link: https://lore.kernel.org/r/cover.1580251857.git.osandov@fb.com/ [1]
Link: https://lore.kernel.org/r/20211207134451.66296-1-jlayton@kernel.org/ [2]
Link: https://lore.kernel.org/r/163189108292.2509237.12615909591150927232.stgit@warthog.procyon.org.uk/ [3]
Link: https://lore.kernel.org/r/599331.1639410068@warthog.procyon.org.uk/ [4]
Link: https://lore.kernel.org/r/CAHk-=whtkzB446+hX0zdLsdcUJsJ=8_-0S1mE_R+YurThfUbLA@mail.gmail.com [5]
Link: https://lore.kernel.org/r/61b90f3d.H1IkoeQfEsGNhvq9%lkp@intel.com/ [6]

References
==========

These patches have been published for review before, firstly as part of a
larger set:

Link: https://lore.kernel.org/r/158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk/

Link: https://lore.kernel.org/r/159465766378.1376105.11619976251039287525.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/159465821598.1377938.2046362270225008168.stgit@warthog.procyon.org.uk/

Link: https://lore.kernel.org/r/160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk/

Then as a cut-down set:

Link: https://lore.kernel.org/r/161118128472.1232039.11746799833066425131.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/161161025063.2537118.2009249444682241405.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk/ # v4
Link: https://lore.kernel.org/r/161653784755.2770958.11820491619308713741.stgit@warthog.procyon.org.uk/ # v5

I split out a set to just restructure the I/O, which got merged back in to
this one:

Link: https://lore.kernel.org/r/163363935000.1980952.15279841414072653108.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/163189104510.2509237.10805032055807259087.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/163363935000.1980952.15279841414072653108.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/163551653404.1877519.12363794970541005441.stgit@warthog.procyon.org.uk/ # v4

... and a larger set to do the conversion, also merged back into this one:

Link: https://lore.kernel.org/r/163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk/ # v2

Older versions of this one:

Link: https://lore.kernel.org/r/163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk/ # v2

Proposals/information about the design have been published here:

Link: https://lore.kernel.org/r/24942.1573667720@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/2758811.1610621106@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/1441311.1598547738@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/160655.1611012999@warthog.procyon.org.uk/

And requests for information:

Link: https://lore.kernel.org/r/3326.1579019665@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/4467.1579020509@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/3577430.1579705075@warthog.procyon.org.uk/

I've posted partial patches to try and help 9p and cifs along:

Link: https://lore.kernel.org/r/1514086.1605697347@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/1794123.1605713481@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/241017.1612263863@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/270998.1612265397@warthog.procyon.org.uk/

---
Dave Wysochanski (1):
      nfs: Convert to new fscache volume/cookie API

David Howells (65):
      fscache, cachefiles: Disable configuration
      cachefiles: Delete the cachefiles driver pending rewrite
      fscache: Remove the contents of the fscache driver, pending rewrite
      netfs: Display the netfs inode number in the netfs_read tracepoint
      netfs: Pass a flag to ->prepare_write() to say if there's no alloc'd space
      fscache: Introduce new driver
      fscache: Implement a hash function
      fscache: Implement cache registration
      fscache: Implement volume registration
      fscache: Implement cookie registration
      fscache: Implement cache-level access helpers
      fscache: Implement volume-level access helpers
      fscache: Implement cookie-level access helpers
      fscache: Implement functions add/remove a cache
      fscache: Provide and use cache methods to lookup/create/free a volume
      fscache: Add a function for a cache backend to note an I/O error
      fscache: Implement simple cookie state machine
      fscache: Implement cookie user counting and resource pinning
      fscache: Implement cookie invalidation
      fscache: Provide a means to begin an operation
      fscache: Count data storage objects in a cache
      fscache: Provide read/write stat counters for the cache
      fscache: Provide a function to let the netfs update its coherency data
      netfs: Pass more information on how to deal with a hole in the cache
      fscache: Implement raw I/O interface
      fscache: Implement higher-level write I/O interface
      vfs, fscache: Implement pinning of cache usage for writeback
      fscache: Provide a function to note the release of a page
      fscache: Provide a function to resize a cookie
      cachefiles: Introduce rewritten driver
      cachefiles: Define structs
      cachefiles: Add some error injection support
      cachefiles: Add a couple of tracepoints for logging errors
      cachefiles: Add cache error reporting macro
      cachefiles: Add security derivation
      cachefiles: Register a miscdev and parse commands over it
      cachefiles: Provide a function to check how much space there is
      vfs, cachefiles: Mark a backing file in use with an inode flag
      cachefiles: Implement a function to get/create a directory in the cache
      cachefiles: Implement cache registration and withdrawal
      cachefiles: Implement volume support
      cachefiles: Add tracepoints for calls to the VFS
      cachefiles: Implement object lifecycle funcs
      cachefiles: Implement key to filename encoding
      cachefiles: Implement metadata/coherency data storage in xattrs
      cachefiles: Mark a backing file in use with an inode flag
      cachefiles: Implement culling daemon commands
      cachefiles: Implement backing file wrangling
      cachefiles: Implement begin and end I/O operation
      cachefiles: Implement cookie resize for truncate
      cachefiles: Implement the I/O routines
      fscache, cachefiles: Store the volume coherency data
      cachefiles: Allow cachefiles to actually function
      fscache, cachefiles: Display stats of no-space events
      fscache, cachefiles: Display stat of culling events
      afs: Handle len being extending over page end in write_begin/write_end
      afs: Fix afs_write_end() to handle len > page size
      afs: Convert afs to use the new fscache API
      afs: Copy local writes to the cache when writing to the server
      afs: Skip truncation on the server of data we haven't written yet
      9p: Use fscache indexing rewrite and reenable caching
      9p: Copy local writes to the cache when writing to the server
      nfs: Implement cache I/O by accessing the cache directly
      cifs: Support fscache indexing rewrite (untested)
      fscache: Rewrite documentation

Jeff Layton (2):
      ceph: conversion to new fscache API
      ceph: add fscache writeback support


 .../filesystems/caching/backend-api.rst       |  850 ++++------
 .../filesystems/caching/cachefiles.rst        |    6 +-
 Documentation/filesystems/caching/fscache.rst |  525 ++----
 Documentation/filesystems/caching/index.rst   |    4 +-
 .../filesystems/caching/netfs-api.rst         | 1136 ++++---------
 Documentation/filesystems/caching/object.rst  |  313 ----
 .../filesystems/caching/operations.rst        |  210 ---
 Documentation/filesystems/netfs_library.rst   |   16 +-
 fs/9p/Kconfig                                 |    2 +-
 fs/9p/cache.c                                 |  195 +--
 fs/9p/cache.h                                 |   25 +-
 fs/9p/v9fs.c                                  |   17 +-
 fs/9p/v9fs.h                                  |   13 +-
 fs/9p/vfs_addr.c                              |   56 +-
 fs/9p/vfs_dir.c                               |   13 +
 fs/9p/vfs_file.c                              |    3 +-
 fs/9p/vfs_inode.c                             |   26 +-
 fs/9p/vfs_inode_dotl.c                        |    3 +-
 fs/9p/vfs_super.c                             |    3 +
 fs/afs/Kconfig                                |    2 +-
 fs/afs/Makefile                               |    3 -
 fs/afs/cache.c                                |   68 -
 fs/afs/cell.c                                 |   12 -
 fs/afs/file.c                                 |   37 +-
 fs/afs/inode.c                                |  101 +-
 fs/afs/internal.h                             |   37 +-
 fs/afs/main.c                                 |   14 -
 fs/afs/super.c                                |    1 +
 fs/afs/volume.c                               |   29 +-
 fs/afs/write.c                                |  100 +-
 fs/cachefiles/Kconfig                         |    7 +
 fs/cachefiles/Makefile                        |    6 +-
 fs/cachefiles/bind.c                          |  278 ----
 fs/cachefiles/cache.c                         |  378 +++++
 fs/cachefiles/daemon.c                        |  180 +--
 fs/cachefiles/error_inject.c                  |   46 +
 fs/cachefiles/interface.c                     |  747 ++++-----
 fs/cachefiles/internal.h                      |  270 ++--
 fs/cachefiles/io.c                            |  330 +++-
 fs/cachefiles/key.c                           |  201 ++-
 fs/cachefiles/main.c                          |   22 +-
 fs/cachefiles/namei.c                         | 1223 ++++++--------
 fs/cachefiles/rdwr.c                          |  972 -----------
 fs/cachefiles/security.c                      |    2 +-
 fs/cachefiles/volume.c                        |  139 ++
 fs/cachefiles/xattr.c                         |  425 +++--
 fs/ceph/Kconfig                               |    2 +-
 fs/ceph/addr.c                                |  101 +-
 fs/ceph/cache.c                               |  218 +--
 fs/ceph/cache.h                               |   97 +-
 fs/ceph/caps.c                                |    3 +-
 fs/ceph/file.c                                |   13 +-
 fs/ceph/inode.c                               |   22 +-
 fs/ceph/super.c                               |   10 +-
 fs/ceph/super.h                               |    3 +-
 fs/cifs/Kconfig                               |    2 +-
 fs/cifs/Makefile                              |    2 +-
 fs/cifs/cache.c                               |  105 --
 fs/cifs/cifsfs.c                              |   11 +-
 fs/cifs/cifsglob.h                            |    5 +-
 fs/cifs/connect.c                             |   12 -
 fs/cifs/file.c                                |   64 +-
 fs/cifs/fscache.c                             |  333 +---
 fs/cifs/fscache.h                             |  126 +-
 fs/cifs/inode.c                               |   36 +-
 fs/fs-writeback.c                             |    8 +
 fs/fscache/Makefile                           |    6 +-
 fs/fscache/cache.c                            |  618 +++----
 fs/fscache/cookie.c                           | 1433 +++++++++--------
 fs/fscache/fsdef.c                            |   98 --
 fs/fscache/internal.h                         |  317 +---
 fs/fscache/io.c                               |  376 ++++-
 fs/fscache/main.c                             |  147 +-
 fs/fscache/netfs.c                            |   74 -
 fs/fscache/object.c                           | 1125 -------------
 fs/fscache/operation.c                        |  633 --------
 fs/fscache/page.c                             | 1242 --------------
 fs/fscache/proc.c                             |   47 +-
 fs/fscache/stats.c                            |  293 +---
 fs/fscache/volume.c                           |  517 ++++++
 fs/namei.c                                    |    3 +-
 fs/netfs/read_helper.c                        |   10 +-
 fs/nfs/Kconfig                                |    2 +-
 fs/nfs/Makefile                               |    2 +-
 fs/nfs/client.c                               |    4 -
 fs/nfs/direct.c                               |    2 +
 fs/nfs/file.c                                 |   13 +-
 fs/nfs/fscache-index.c                        |  140 --
 fs/nfs/fscache.c                              |  490 ++----
 fs/nfs/fscache.h                              |  179 +-
 fs/nfs/inode.c                                |   11 +-
 fs/nfs/nfstrace.h                             |    1 -
 fs/nfs/read.c                                 |   25 +-
 fs/nfs/super.c                                |   28 +-
 fs/nfs/write.c                                |    8 +-
 include/linux/fs.h                            |    4 +
 include/linux/fscache-cache.h                 |  614 ++-----
 include/linux/fscache.h                       | 1022 +++++-------
 include/linux/netfs.h                         |   15 +-
 include/linux/nfs_fs.h                        |    1 -
 include/linux/nfs_fs_sb.h                     |    9 +-
 include/linux/writeback.h                     |    1 +
 include/trace/events/cachefiles.h             |  527 ++++--
 include/trace/events/fscache.h                |  626 ++++---
 include/trace/events/netfs.h                  |    5 +-
 105 files changed, 7356 insertions(+), 13531 deletions(-)
 delete mode 100644 Documentation/filesystems/caching/object.rst
 delete mode 100644 Documentation/filesystems/caching/operations.rst
 delete mode 100644 fs/afs/cache.c
 delete mode 100644 fs/cachefiles/bind.c
 create mode 100644 fs/cachefiles/cache.c
 create mode 100644 fs/cachefiles/error_inject.c
 delete mode 100644 fs/cachefiles/rdwr.c
 create mode 100644 fs/cachefiles/volume.c
 delete mode 100644 fs/cifs/cache.c
 delete mode 100644 fs/fscache/fsdef.c
 delete mode 100644 fs/fscache/netfs.c
 delete mode 100644 fs/fscache/object.c
 delete mode 100644 fs/fscache/operation.c
 delete mode 100644 fs/fscache/page.c
 create mode 100644 fs/fscache/volume.c
 delete mode 100644 fs/nfs/fscache-index.c


