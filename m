Return-Path: <linux-fsdevel+bounces-5209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322058095A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 23:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57C61F21237
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7FF5730A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6aE7Cu8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780E5171A
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 13:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701984136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=obK9oWE6o3VIPZKQ3NT303srS8CJDX4FzQ6SdddDGq4=;
	b=S6aE7Cu8T1hT4Fs4DF103rJwWi2ece3mInIxU4PxgHSaO61xxhix6VQgToJfHMxzkQDLUz
	WYtdmEHA/Rb2bdl2943zPO2BT7MQEEjZdiwwJEGSNM2BPN7e59powz/lCGWaqhimaz5Rhs
	8/6CaYad3rDPpez5RAwMUMcnD/qsMW8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-QUCZvw5GNuCGZBBFt2NHVw-1; Thu, 07 Dec 2023 16:22:12 -0500
X-MC-Unique: QUCZvw5GNuCGZBBFt2NHVw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB64D101A551;
	Thu,  7 Dec 2023 21:22:11 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CE9B02026D66;
	Thu,  7 Dec 2023 21:22:08 +0000 (UTC)
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
Subject: [PATCH v3 00/59] netfs, afs, 9p, cifs: Delegate high-level I/O to netfslib
Date: Thu,  7 Dec 2023 21:21:07 +0000
Message-ID: <20231207212206.1379128-1-dhowells@redhat.com>
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
small patch, write-through buffering in the pagecache).  I can also run a
certain amount of xfstests on CIFS, though I'm running into ksmbd bugs and
not all the tests work correctly because of fallocate issues.  I have a
patch for 9P, but am currently unable to test it.

The patches remove a little over 800 lines from AFS, 300 from 9P and over
2000 from CIFS, albeit with around 3000 lines added to netfs.  Hopefully, I
will be able to remove a bunch of lines from Ceph too.

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

 (5) Support for content encryption.  This isn't supported yet by AFS/CIFS
     but is aimed initially at Ceph.

 (6) ->write_begin() and ->write_end() are ignored in favour of merging all
     of that into one function, netfs_perform_write(), thereby avoiding the
     function pointer traversals.

 (7) Support for write-through caching in the pagecache.
     netfs_perform_write() adds the pages is modifies to an I/O operation
     as it goes and directly marks them writeback rather than dirty.  When
     writing back from write-through, it limits the range written back.
     This should allow CIFS to deal with byte-range mandatory locks
     correctly.

 (8) O_*SYNC and RWF_*SYNC writes use write-through rather than writing to
     the pagecache and then flushing afterwards.  An AIO O_*SYNC write will
     notify of completion when the sub-writes all complete.

 (9) Support for write-streaming where modifed data is held in !uptodate
     folios, with a private struct attached indicating the range that is
     valid.

(10) Support for write grouping, multiplexing a pointer to a group in the
     folio private data with the write-streaming data.  The writepages
     algorithm only writes stuff back that's in the nominated group.  This
     is intended for use by Ceph to write is snaps in order.

(11) Skipping reads for which we know the server could only supply zeros or
     EOF (for instance if we've done a local write that leaves a hole in
     the file and extends the local inode size).

(12) PG_fscache is no longer used; instead, if a folio needs writing to the
     cache after being downloaded, it's marked dirty and a magic value is
     set in folio->private.  writepages is then left to do the writing to
     the cache.  If userspace modifies those pages, that simply supersedes
     the mark and they'll get written to the server also.  One downside is
     that we lose the content-encrypted version of the page and have to
     reencrypt before writing to the cache - though this can be done in the
     background.

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


CIFS notes:

 (1) CIFS is made to use unbuffered I/O for unbuffered caching modes and
     write-through caching for cache=strict.

 (2) Various cifs fallocate() function implementations needed fixing and
     those fixes are upstream or on the way.

 (3) It should be possible to turn on multipage folio support in CIFS now.

 (4) The then-unused CIFS code is removed in three patches, not one, to
     avoid the git patch generator from producing confusing patches in
     which it thinks code is being moved around rather than just being
     removed.


9P notes:

 (1) I haven't managed to test this as I haven't been able to get Ganesha
     to work correctly with 9P.

 (2) Writes should now occur in larger-than-page-sized chunks.

 (3) It should be possible to turn on multipage folio support in 9P now.


Changes
=======
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

David Howells (59):
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
  netfs: Provide minimum blocksize parameter
  netfs: Make netfs_skip_folio_read() take account of blocksize
  netfs: Perform content encryption
  netfs: Decrypt encrypted content
  netfs: Support decryption on ubuffered/DIO read
  netfs: Support encryption on Unbuffered/DIO write
  netfs: Provide a launder_folio implementation
  netfs: Implement a write-through caching option
  netfs: Rearrange netfs_io_subrequest to put request pointer first
  netfs: Optimise away reads above the point at which there can be no
    data
  afs: Use the netfs write helpers
  9p: Use netfslib read/write_iter
  cifs: Replace cifs_readdata with a wrapper around netfs_io_subrequest
  cifs: Share server EOF pos with netfslib
  cifs: Set zero_point in the copy_file_range() and remap_file_range()
  cifs: Replace cifs_writedata with a wrapper around netfs_io_subrequest
  cifs: Use more fields from netfs_io_subrequest
  cifs: Make wait_mtu_credits take size_t args
  cifs: Implement netfslib hooks
  cifs: Move cifs_loose_read_iter() and cifs_file_write_iter() to file.c
  cifs: Cut over to using netfslib
  cifs: Remove some code that's no longer used, part 1
  cifs: Remove some code that's no longer used, part 2
  cifs: Remove some code that's no longer used, part 3
  netfs: Eliminate PG_fscache by setting folio->private and marking
    dirty

 Documentation/filesystems/netfs_library.rst   |   23 +-
 MAINTAINERS                                   |    2 +-
 fs/9p/vfs_addr.c                              |  351 +-
 fs/9p/vfs_file.c                              |   89 +-
 fs/9p/vfs_inode.c                             |    5 +-
 fs/9p/vfs_super.c                             |   14 +-
 fs/Kconfig                                    |    1 -
 fs/Makefile                                   |    1 -
 fs/afs/file.c                                 |  209 +-
 fs/afs/inode.c                                |   26 +-
 fs/afs/internal.h                             |   72 +-
 fs/afs/super.c                                |    2 +-
 fs/afs/write.c                                |  826 +----
 fs/cachefiles/internal.h                      |    2 +-
 fs/cachefiles/io.c                            |   10 +-
 fs/cachefiles/ondemand.c                      |    2 +-
 fs/ceph/addr.c                                |   45 +-
 fs/ceph/cache.h                               |   35 +-
 fs/ceph/inode.c                               |    2 +-
 fs/fs-writeback.c                             |   10 +-
 fs/fscache/Kconfig                            |   40 -
 fs/fscache/Makefile                           |   16 -
 fs/fscache/internal.h                         |  277 --
 fs/netfs/Kconfig                              |   39 +
 fs/netfs/Makefile                             |   23 +-
 fs/netfs/buffered_read.c                      |  299 +-
 fs/netfs/buffered_write.c                     | 1248 +++++++
 fs/netfs/crypto.c                             |  148 +
 fs/netfs/direct_read.c                        |  263 ++
 fs/netfs/direct_write.c                       |  370 +++
 fs/{fscache/cache.c => netfs/fscache_cache.c} |    0
 .../cookie.c => netfs/fscache_cookie.c}       |    0
 fs/netfs/fscache_internal.h                   |   14 +
 fs/{fscache/io.c => netfs/fscache_io.c}       |   46 +-
 fs/{fscache/main.c => netfs/fscache_main.c}   |   25 +-
 fs/{fscache/proc.c => netfs/fscache_proc.c}   |   23 +-
 fs/{fscache/stats.c => netfs/fscache_stats.c} |    4 +-
 .../volume.c => netfs/fscache_volume.c}       |    0
 fs/netfs/internal.h                           |  325 ++
 fs/netfs/io.c                                 |  480 +--
 fs/netfs/iterator.c                           |   97 +
 fs/netfs/locking.c                            |  215 ++
 fs/netfs/main.c                               |  112 +
 fs/netfs/misc.c                               |  252 ++
 fs/netfs/objects.c                            |   65 +-
 fs/netfs/output.c                             |  483 +++
 fs/netfs/stats.c                              |   31 +-
 fs/nfs/Kconfig                                |    4 +-
 fs/nfs/fscache.c                              |    7 -
 fs/smb/client/Kconfig                         |    1 +
 fs/smb/client/cifsfs.c                        |   95 +-
 fs/smb/client/cifsfs.h                        |   10 +-
 fs/smb/client/cifsglob.h                      |   59 +-
 fs/smb/client/cifsproto.h                     |   14 +-
 fs/smb/client/cifssmb.c                       |  111 +-
 fs/smb/client/file.c                          | 2922 +++--------------
 fs/smb/client/fscache.c                       |  109 -
 fs/smb/client/fscache.h                       |   54 -
 fs/smb/client/inode.c                         |   27 +-
 fs/smb/client/smb2ops.c                       |   28 +-
 fs/smb/client/smb2pdu.c                       |  168 +-
 fs/smb/client/smb2proto.h                     |    5 +-
 fs/smb/client/trace.h                         |  144 +-
 fs/smb/client/transport.c                     |   17 +-
 include/linux/fs.h                            |    2 +-
 include/linux/fscache.h                       |   45 -
 include/linux/netfs.h                         |  207 +-
 include/linux/writeback.h                     |    2 +-
 include/trace/events/afs.h                    |   31 -
 include/trace/events/netfs.h                  |  165 +-
 mm/filemap.c                                  |    1 +
 71 files changed, 5677 insertions(+), 5173 deletions(-)
 delete mode 100644 fs/fscache/Kconfig
 delete mode 100644 fs/fscache/Makefile
 delete mode 100644 fs/fscache/internal.h
 create mode 100644 fs/netfs/buffered_write.c
 create mode 100644 fs/netfs/crypto.c
 create mode 100644 fs/netfs/direct_read.c
 create mode 100644 fs/netfs/direct_write.c
 rename fs/{fscache/cache.c => netfs/fscache_cache.c} (100%)
 rename fs/{fscache/cookie.c => netfs/fscache_cookie.c} (100%)
 create mode 100644 fs/netfs/fscache_internal.h
 rename fs/{fscache/io.c => netfs/fscache_io.c} (85%)
 rename fs/{fscache/main.c => netfs/fscache_main.c} (84%)
 rename fs/{fscache/proc.c => netfs/fscache_proc.c} (58%)
 rename fs/{fscache/stats.c => netfs/fscache_stats.c} (97%)
 rename fs/{fscache/volume.c => netfs/fscache_volume.c} (100%)
 create mode 100644 fs/netfs/locking.c
 create mode 100644 fs/netfs/misc.c
 create mode 100644 fs/netfs/output.c


