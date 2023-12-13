Return-Path: <linux-fsdevel+bounces-5912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFC481162F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041AF281EED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA253173B;
	Wed, 13 Dec 2023 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGIQNLvE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D17100
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 07:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702481040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nElvBfJsqrTBHn7ca9kS/IDQA0m2TnErz3scXuPoO1A=;
	b=XGIQNLvEWQaVpKybd6AxvYfgG2HjXUkXPuPArQ0JycyDxRITHxwmuQ1Q5kEpOw4i8ghbFo
	13EkKv8R2GJvuU7TfWxH2GqDQ81893uodY8cz5HI4hcRVNPmVCupTZK26HarEHldGKEdrz
	2/JGCtqyuSk1ajo7y8NoQu5pePDWgXI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-bNT4a_5wMzSOH84dTC7R4A-1; Wed, 13 Dec 2023 10:23:57 -0500
X-MC-Unique: bNT4a_5wMzSOH84dTC7R4A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3D8C86301A;
	Wed, 13 Dec 2023 15:23:55 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B84EDC1596E;
	Wed, 13 Dec 2023 15:23:52 +0000 (UTC)
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
Subject: [PATCH v4 00/39] netfs, afs, 9p: Delegate high-level I/O to netfslib
Date: Wed, 13 Dec 2023 15:23:10 +0000
Message-ID: <20231213152350.431591-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

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


9P notes:

 (1) I haven't managed to test this as I haven't been able to get Ganesha
     to work correctly with 9P.

 (2) Writes should now occur in larger-than-page-sized chunks.

 (3) It should be possible to turn on multipage folio support in 9P now.


Changes
=======
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

David Howells (39):
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
  netfs: Add bounce buffering support
  netfs: Add func to calculate pagecount/size-limited span of an
    iterator
  netfs: Limit subrequest by size or number of segments
  netfs: Export netfs_put_subrequest() and some tracepoints
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
  netfs: Implement support for unbuffered/DIO read
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
  afs: Use the netfs write helpers
  9p: Use netfslib read/write_iter

 Documentation/filesystems/netfs_library.rst   |   23 +-
 MAINTAINERS                                   |    2 +-
 fs/9p/vfs_addr.c                              |  352 +----
 fs/9p/vfs_file.c                              |   89 +-
 fs/9p/vfs_inode.c                             |    5 +-
 fs/9p/vfs_super.c                             |   14 +-
 fs/Kconfig                                    |    1 -
 fs/Makefile                                   |    1 -
 fs/afs/file.c                                 |  213 +--
 fs/afs/inode.c                                |   26 +-
 fs/afs/internal.h                             |   72 +-
 fs/afs/super.c                                |    2 +-
 fs/afs/write.c                                |  826 +----------
 fs/cachefiles/internal.h                      |    2 +-
 fs/cachefiles/io.c                            |   10 +-
 fs/cachefiles/ondemand.c                      |    2 +-
 fs/ceph/addr.c                                |   25 +-
 fs/ceph/cache.h                               |   35 +-
 fs/ceph/inode.c                               |    2 +-
 fs/fs-writeback.c                             |   10 +-
 fs/fscache/Kconfig                            |   40 -
 fs/fscache/Makefile                           |   16 -
 fs/fscache/internal.h                         |  277 ----
 fs/netfs/Kconfig                              |   39 +
 fs/netfs/Makefile                             |   22 +-
 fs/netfs/buffered_read.c                      |  229 ++-
 fs/netfs/buffered_write.c                     | 1247 +++++++++++++++++
 fs/netfs/direct_read.c                        |  252 ++++
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
 fs/netfs/io.c                                 |  214 ++-
 fs/netfs/iterator.c                           |   97 ++
 fs/netfs/locking.c                            |  215 +++
 fs/netfs/main.c                               |  110 ++
 fs/netfs/misc.c                               |  260 ++++
 fs/netfs/objects.c                            |   63 +-
 fs/netfs/output.c                             |  478 +++++++
 fs/netfs/stats.c                              |   31 +-
 fs/nfs/Kconfig                                |    4 +-
 fs/nfs/fscache.c                              |    7 -
 fs/smb/client/cifsfs.c                        |    9 +-
 fs/smb/client/file.c                          |   18 +-
 fs/smb/client/fscache.c                       |    2 +-
 include/linux/fs.h                            |    2 +-
 include/linux/fscache.h                       |   45 -
 include/linux/netfs.h                         |  176 ++-
 include/linux/writeback.h                     |    2 +-
 include/trace/events/afs.h                    |   31 -
 include/trace/events/netfs.h                  |  155 +-
 mm/filemap.c                                  |    1 +
 58 files changed, 4197 insertions(+), 2123 deletions(-)
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


