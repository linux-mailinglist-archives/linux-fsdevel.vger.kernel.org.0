Return-Path: <linux-fsdevel+bounces-6696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C158581B748
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 14:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78588284340
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE09745E1;
	Thu, 21 Dec 2023 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9gV0hGF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68117745CF
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703165050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VKGG1ghrvdfUlFPLPAYO9yXjV2FJkey1fa4FCtV7Sio=;
	b=N9gV0hGF0ui60S0qVh/xL96dB5NkH8shq1mPsOidAG7EPebpcPQDkazX+1I+fFSTf9miic
	pVn9H4y39/AYyGKAeZVSKxrDTro3UalgJXjeqxOjOsF2FLccTCt2eKkcJXhs+NPK8uCspA
	e3guoUMhL7WUGPdwvAU2Ae9ZB+ZN8Mo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-TbNO9znEOMqxxivLbE8A2Q-1; Thu, 21 Dec 2023 08:24:07 -0500
X-MC-Unique: TbNO9znEOMqxxivLbE8A2Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB39088CDCA;
	Thu, 21 Dec 2023 13:24:05 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BDB762026D66;
	Thu, 21 Dec 2023 13:24:02 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/40] netfs, afs, 9p: Delegate high-level I/O to netfslib
Date: Thu, 21 Dec 2023 13:22:55 +0000
Message-ID: <20231221132400.1601991-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Hi Jeff, Steve, Dominique,

I have been working on my netfslib helpers to the point that I can run
xfstests on AFS to completion (both with write-back buffering and, with a
small patch, write-through buffering in the pagecache).  I have a patch for
9P, but am currently unable to test it.

The patches remove a little over 800 lines from AFS, 300 from 9P, albeit with
around 3000 lines added to netfs.  Hopefully, I will be able to remove a bunch
of lines from Ceph too.

I've split the CIFS patches out to a separate branch, cifs-netfs, where a
further 2000+ lines are removed.  I can run a certain amount of xfstests on
CIFS, though I'm running into ksmbd issues and not all the tests work
correctly because of issues between fallocate and what the SMB protocol
actually supports.

I've also dropped the content-crypto patches out for the moment as they're
only usable by the ceph changes which I'm still working on.

The patch to use PG_writeback instead of PG_fscache for writing to the
cache has also been deferred, pending 9p, afs, ceph and cifs all being
converted.

The main aims of these patches are to get high-level I/O and knowledge of
the pagecache out of the filesystem drivers as much as possible and to get
rid, as much of possible, of the knowledge that pages/folios exist.

Further, I would like to see ->write_begin, ->write_end and ->launder_folio
go away.

Features that are added by these patches to that which is already there in
netfslib:

 (1) NFS-style (and Ceph-style) locking around DIO vs buffered I/O calls to
     prevent these from happening at the same time.  mmap'd I/O can, of
     necessity, happen at any time ignoring these locks.

 (2) Support for unbuffered I/O.  The data is kept in the bounce buffer and
     the pagecache is not used.  This can be turned on with an inode flag.

 (3) Support for direct I/O.  This is basically unbuffered I/O with some
     extra restrictions and no RMW.

 (4) Support for using a bounce buffer in an operation.  The bounce buffer
     may be bigger than the target data/buffer, allowing for crypto
     rounding.

 (5) ->write_begin() and ->write_end() are ignored in favour of merging all
     of that into one function, netfs_perform_write(), thereby avoiding the
     function pointer traversals.

 (6) Support for write-through caching in the pagecache.
     netfs_perform_write() adds the pages is modifies to an I/O operation
     as it goes and directly marks them writeback rather than dirty.  When
     writing back from write-through, it limits the range written back.
     This should allow CIFS to deal with byte-range mandatory locks
     correctly.

 (7) O_*SYNC and RWF_*SYNC writes use write-through rather than writing to
     the pagecache and then flushing afterwards.  An AIO O_*SYNC write will
     notify of completion when the sub-writes all complete.

 (8) Support for write-streaming where modifed data is held in !uptodate
     folios, with a private struct attached indicating the range that is
     valid.

 (9) Support for write grouping, multiplexing a pointer to a group in the
     folio private data with the write-streaming data.  The writepages
     algorithm only writes stuff back that's in the nominated group.  This
     is intended for use by Ceph to write is snaps in order.

(10) Skipping reads for which we know the server could only supply zeros or
     EOF (for instance if we've done a local write that leaves a hole in
     the file and extends the local inode size).

General notes:

 (1) The fscache module is merged into the netfslib module to avoid cyclic
     exported symbol usage that prevents either module from being loaded.

 (2) Some helpers from fscache are reassigned to netfslib by name.

 (3) netfslib now makes use of folio->private, which means the filesystem
     can't use it.

 (4) The filesystem provides wrappers to call the write helpers, allowing
     it to do pre-validation, oplock/capability fetching and the passing in
     of write group info.

 (5) I want to try flushing the data when tearing down an inode before
     invalidating it to try and render launder_folio unnecessary.

 (6) Write-through caching will generate and dispatch write subrequests as
     it gathers enough data to hit wsize and has whole pages that at least
     span that size.  This needs to be a bit more flexible, allowing for a
     filesystem such as CIFS to have a variable wsize.

 (7) The filesystem driver is just given read and write calls with an
     iov_iter describing the data/buffer to use.  Ideally, they don't see
     pages or folios at all.  A function, extract_iter_to_sg(), is already
     available to decant part of an iterator into a scatterlist for crypto
     purposes.


AFS notes:

 (1) I pushed a pair of patches that clean up the trace header down to the
     base so that they can be shared with another branch.

9P notes:

 (1) Most of xfstests now pass - more, in fact, since upstream 9p lacks a
     writepages method and can't handle mmap writes.  An occasional oops
     (and sometimes panic) happens somewhere in the pathwalk/FID handling
     code that is unrelated to these changes.

 (2) Writes should now occur in larger-than-page-sized chunks.

 (3) It should be possible to turn on multipage folio support in 9P now.

The patches are tagged as:

  https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/tag/?h=netfs-lib-20231221

and can also be found on the "netfs-lib" branch in the same repo.
	

Changes
=======
ver #5)
 - Dropped bounce-buffer code for now as that's only used by content crypto
   (which got deferred previously).
 - Removed ceph_fscache_note_page_release() also as that is now unused.
 - Cachefiles needs to depend on NETFS_SUPPORT also now.
 - fscache_init/exit() should depend on CONFIG_FSCACHE, not CONFIG_PROC_FS.
 - Adjust MAINTAINERS file.
 - Sank afs trace header cleanup patches to base to share more easily with
   another branch.
 - 9p: Added some missing remote_i_size setting.
 - 9p: Added missing writepages (else mmap write never written back).
 - Use netfs_folio_info() rather than open-coding pointer mangling.
 - Use folio_get_private() rather than using folio->private.
 - Don't check the folio private pointer before taking the folio ref during
   writeback pagecache RCU xarray walk.
 - Change arch defconfigs to have NETFS_SUPPORT=m and FSCACHE=y when
   FSCACHE was m.

ver #4)
 - Slimmed down the branch:
   - Split the cifs-related patches off to a separate branch (cifs-netfs)
   - Deferred the content-encryption to the in-progress ceph changes.
   - Deferred the use-PG_writeback rather than PG_fscache patch
 - Rebased on a later linux-next with afs-rotation patches.

ver #3)
 - Moved the fscache module into netfslib to avoid export cycles.
 - Fixed a bunch of bugs.
 - Got CIFS to pass as much of xfstests as possible.
 - Added a patch to make 9P use all the helpers.
 - Added a patch to stop using PG_fscache, but rather dirty pages on
   reading and have writepages write to the cache.

ver #2)
 - Folded the addition of NETFS_RREQ_NONBLOCK/BLOCKED into first patch that
   uses them.
 - Folded addition of rsize member into first user.
 - Don't set rsize in ceph (yet) and set it in kafs to 256KiB.  cifs sets
   it dynamically.
 - Moved direct_bv next to direct_bv_count in struct netfs_io_request and
   labelled it with a __counted_by().
 - Passed flags into netfs_xa_store_and_mark() rather than two bools.
 - Removed netfs_set_up_buffer() as it wasn't used.

David

Link: https://lore.kernel.org/r/20231013160423.2218093-1-dhowells@redhat.com/ # v1
Link: https://lore.kernel.org/r/20231117211544.1740466-1-dhowells@redhat.com/ # v2
Link: https://lore.kernel.org/r/20231207212206.1379128-1-dhowells@redhat.com/ # v3
Link: https://lore.kernel.org/r/20231213152350.431591-1-dhowells@redhat.com/ # v4

David Howells (40):
  afs: Remove whitespace before most ')' from the trace header
  afs: Automatically generate trace tag enums
  netfs, fscache: Move fs/fscache/* into fs/netfs/
  netfs, fscache: Combine fscache with netfs
  netfs, fscache: Remove ->begin_cache_operation
  netfs, fscache: Move /proc/fs/fscache to /proc/fs/netfs and put in a
    symlink
  netfs: Move pinning-for-writeback from fscache to netfs
  netfs: Add a procfile to list in-progress requests
  netfs: Allow the netfs to make the io (sub)request alloc larger
  netfs: Add a ->free_subrequest() op
  afs: Don't use folio->private to record partial modification
  netfs: Provide invalidate_folio and release_folio calls
  netfs: Implement unbuffered/DIO vs buffered I/O locking
  netfs: Add iov_iters to (sub)requests to describe various buffers
  netfs: Add support for DIO buffering
  netfs: Provide tools to create a buffer in an xarray
  netfs: Add func to calculate pagecount/size-limited span of an
    iterator
  netfs: Limit subrequest by size or number of segments
  netfs: Extend the netfs_io_*request structs to handle writes
  netfs: Add a hook to allow tell the netfs to update its i_size
  netfs: Make netfs_put_request() handle a NULL pointer
  netfs: Make the refcounting of netfs_begin_read() easier to use
  netfs: Prep to use folio->private for write grouping and streaming
    write
  netfs: Dispatch write requests to process a writeback slice
  netfs: Provide func to copy data to pagecache for buffered write
  netfs: Make netfs_read_folio() handle streaming-write pages
  netfs: Allocate multipage folios in the writepath
  netfs: Implement unbuffered/DIO read support
  netfs: Implement unbuffered/DIO write support
  netfs: Implement buffered write API
  netfs: Allow buffered shared-writeable mmap through
    netfs_page_mkwrite()
  netfs: Provide netfs_file_read_iter()
  netfs, cachefiles: Pass upper bound length to allow expansion
  netfs: Provide a writepages implementation
  netfs: Provide a launder_folio implementation
  netfs: Implement a write-through caching option
  netfs: Optimise away reads above the point at which there can be no
    data
  netfs: Export the netfs_sreq tracepoint
  afs: Use the netfs write helpers
  9p: Use netfslib read/write_iter

 Documentation/filesystems/netfs_library.rst   |   23 +-
 MAINTAINERS                                   |   21 +-
 arch/arm/configs/mxs_defconfig                |    3 +-
 arch/csky/configs/defconfig                   |    3 +-
 arch/mips/configs/ip27_defconfig              |    3 +-
 arch/mips/configs/lemote2f_defconfig          |    3 +-
 arch/mips/configs/loongson3_defconfig         |    3 +-
 arch/mips/configs/pic32mzda_defconfig         |    3 +-
 arch/s390/configs/debug_defconfig             |    3 +-
 arch/s390/configs/defconfig                   |    3 +-
 arch/sh/configs/sdk7786_defconfig             |    3 +-
 fs/9p/vfs_addr.c                              |  353 +----
 fs/9p/vfs_file.c                              |   89 +-
 fs/9p/vfs_inode.c                             |    8 +-
 fs/9p/vfs_inode_dotl.c                        |    7 +-
 fs/9p/vfs_super.c                             |   14 +-
 fs/Kconfig                                    |    1 -
 fs/Makefile                                   |    1 -
 fs/afs/file.c                                 |  213 +--
 fs/afs/inode.c                                |   26 +-
 fs/afs/internal.h                             |   72 +-
 fs/afs/super.c                                |    2 +-
 fs/afs/write.c                                |  828 +----------
 fs/cachefiles/Kconfig                         |    2 +-
 fs/cachefiles/internal.h                      |    2 +-
 fs/cachefiles/io.c                            |   10 +-
 fs/cachefiles/ondemand.c                      |    2 +-
 fs/ceph/addr.c                                |   25 +-
 fs/ceph/cache.h                               |   45 +-
 fs/ceph/inode.c                               |    2 +-
 fs/fs-writeback.c                             |   10 +-
 fs/fscache/Kconfig                            |   40 -
 fs/fscache/Makefile                           |   16 -
 fs/fscache/internal.h                         |  277 ----
 fs/netfs/Kconfig                              |   39 +
 fs/netfs/Makefile                             |   22 +-
 fs/netfs/buffered_read.c                      |  229 ++-
 fs/netfs/buffered_write.c                     | 1236 +++++++++++++++++
 fs/netfs/direct_read.c                        |  125 ++
 fs/netfs/direct_write.c                       |  170 +++
 fs/{fscache/cache.c => netfs/fscache_cache.c} |    0
 .../cookie.c => netfs/fscache_cookie.c}       |    0
 fs/netfs/fscache_internal.h                   |   14 +
 fs/{fscache/io.c => netfs/fscache_io.c}       |   42 +-
 fs/{fscache/main.c => netfs/fscache_main.c}   |   25 +-
 fs/{fscache/proc.c => netfs/fscache_proc.c}   |   23 +-
 fs/{fscache/stats.c => netfs/fscache_stats.c} |    4 +-
 .../volume.c => netfs/fscache_volume.c}       |    0
 fs/netfs/internal.h                           |  288 ++++
 fs/netfs/io.c                                 |  211 ++-
 fs/netfs/iterator.c                           |   97 ++
 fs/netfs/locking.c                            |  216 +++
 fs/netfs/main.c                               |  109 ++
 fs/netfs/misc.c                               |  260 ++++
 fs/netfs/objects.c                            |   59 +-
 fs/netfs/output.c                             |  478 +++++++
 fs/netfs/stats.c                              |   31 +-
 fs/nfs/Kconfig                                |    4 +-
 fs/nfs/fscache.c                              |    7 -
 fs/smb/client/cifsfs.c                        |    9 +-
 fs/smb/client/file.c                          |   18 +-
 fs/smb/client/fscache.c                       |    2 +-
 include/linux/fs.h                            |    2 +-
 include/linux/fscache.h                       |   45 -
 include/linux/netfs.h                         |  174 ++-
 include/linux/writeback.h                     |    2 +-
 include/trace/events/afs.h                    |  496 ++-----
 include/trace/events/netfs.h                  |  155 ++-
 mm/filemap.c                                  |    2 +
 69 files changed, 4233 insertions(+), 2477 deletions(-)
 delete mode 100644 fs/fscache/Kconfig
 delete mode 100644 fs/fscache/Makefile
 delete mode 100644 fs/fscache/internal.h
 create mode 100644 fs/netfs/buffered_write.c
 create mode 100644 fs/netfs/direct_read.c
 create mode 100644 fs/netfs/direct_write.c
 rename fs/{fscache/cache.c => netfs/fscache_cache.c} (100%)
 rename fs/{fscache/cookie.c => netfs/fscache_cookie.c} (100%)
 create mode 100644 fs/netfs/fscache_internal.h
 rename fs/{fscache/io.c => netfs/fscache_io.c} (86%)
 rename fs/{fscache/main.c => netfs/fscache_main.c} (84%)
 rename fs/{fscache/proc.c => netfs/fscache_proc.c} (58%)
 rename fs/{fscache/stats.c => netfs/fscache_stats.c} (97%)
 rename fs/{fscache/volume.c => netfs/fscache_volume.c} (100%)
 create mode 100644 fs/netfs/locking.c
 create mode 100644 fs/netfs/misc.c
 create mode 100644 fs/netfs/output.c


