Return-Path: <linux-fsdevel+bounces-277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A4E7C8988
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 18:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29AC4282D58
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 16:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9111C697;
	Fri, 13 Oct 2023 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AmgFeiQz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEA01C289
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 16:04:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502FBDD
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 09:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697213072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/T7Rb4XZnpB8qQGskLxctbykFhIHLiOhPwndRDZOESw=;
	b=AmgFeiQzUletldJb0955FzLMJNYR2Hj3rmsIDIJX5uaaLYKaieZnmXIkn1ftklJTpTYmwH
	DuV2AZVyyuYdd1n3/4KKCrFwO6vdLD3y+wPzVw0JKlcKn4ZrA5N/sVrImxcnkxYNPjRSM6
	p+Evaxhr+bXTugp/E1d176daeJZmV5c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-AouhO1vMPQ-JnIcRI0T7Aw-1; Fri, 13 Oct 2023 12:04:29 -0400
X-MC-Unique: AouhO1vMPQ-JnIcRI0T7Aw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA771858F1D;
	Fri, 13 Oct 2023 16:04:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.226])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7CF5D1C060DF;
	Fri, 13 Oct 2023 16:04:25 +0000 (UTC)
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
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 00/53] netfs, afs, cifs: Delegate high-level I/O to netfslib
Date: Fri, 13 Oct 2023 17:03:29 +0100
Message-ID: <20231013160423.2218093-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jeff, Steve,

I have been working on my netfslib helpers to the point that I can run
xfstests on AFS to completion (both with write-back buffering and, with a
small patch, write-through buffering in the pagecache).  I can also run a
certain amount of xfstests on CIFS, though that requires some more
debugging.  However, this seems like a good time to post a preview of the
patches.

The patches remove a little over 800 lines from AFS and over 2000 from
CIFS, albeit with around 3000 lines added to netfs.  Hopefully, I will be
able to remove a bunch of lines from 9P and Ceph too.

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


General notes:

 (1) netfslib now makes use of folio->private, which means the filesystem
     can't use it.

 (2) Use of fscache is not yet tested.  I'm not sure whether to allow a
     cache to be used with a write-through write.

 (3) The filesystem provides wrappers to call the write helpers, allowing
     it to do pre-validation, oplock/capability fetching and the passing in
     of write group info.

 (4) I want to try flushing the data when tearing down an inode before
     invalidating it to try and render launder_folio unnecessary.

 (5) Write-through caching will generate and dispatch write subrequests as
     it gathers enough data to hit wsize and has whole pages that at least
     span that size.  This needs to be a bit more flexible, allowing for a
     filesystem such as CIFS to have a variable wsize.

 (6) The filesystem driver is just given read and write calls with an
     iov_iter describing the data/buffer to use.  Ideally, they don't see
     pages or folios at all.  A function, extract_iter_to_sg(), is already
     available to decant part of an iterator into a scatterlist for crypto
     purposes.


CIFS notes:

 (1) CIFS is made to use unbuffered I/O for unbuffered caching modes and
     write-through caching for cache=strict.

 (2) cifs_init_request() occasionally throws an error that it can't get a
     writable file when trying to do writeback.

 (3) Apparent file corruption frequently appears in the target file when
     cifs_copy_file_range(), even though it doesn't use any netfslib
     helpers and even if it doesn't overlap with any pages in the
     pagecache.

 (4) I should be able to turn multipage folio support on in CIFS now.

 (5) The then-unused CIFS code is removed in three patches, not one, to
     avoid the git patch generator from producing confusing patches in
     which it thinks code is being moved around rather than just being
     removed.

David

David Howells (53):
  netfs: Add a procfile to list in-progress requests
  netfs: Track the fpos above which the server has no data
  netfs: Note nonblockingness in the netfs_io_request struct
  netfs: Allow the netfs to make the io (sub)request alloc larger
  netfs: Add a ->free_subrequest() op
  afs: Don't use folio->private to record partial modification
  netfs: Provide invalidate_folio and release_folio calls
  netfs: Add rsize to netfs_io_request
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
  fscache: Add a function to begin an cache op from a netfslib request
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
  afs: Use the netfs write helpers
  cifs: Replace cifs_readdata with a wrapper around netfs_io_subrequest
  cifs: Share server EOF pos with netfslib
  cifs: Replace cifs_writedata with a wrapper around netfs_io_subrequest
  cifs: Use more fields from netfs_io_subrequest
  cifs: Make wait_mtu_credits take size_t args
  cifs: Implement netfslib hooks
  cifs: Move cifs_loose_read_iter() and cifs_file_write_iter() to file.c
  cifs: Cut over to using netfslib
  cifs: Remove some code that's no longer used, part 1
  cifs: Remove some code that's no longer used, part 2
  cifs: Remove some code that's no longer used, part 3

 fs/9p/vfs_addr.c             |   51 +-
 fs/afs/file.c                |  206 +--
 fs/afs/inode.c               |   15 +-
 fs/afs/internal.h            |   66 +-
 fs/afs/write.c               |  816 +---------
 fs/ceph/addr.c               |   28 +-
 fs/ceph/cache.h              |   12 -
 fs/fscache/io.c              |   42 +
 fs/netfs/Makefile            |    9 +-
 fs/netfs/buffered_read.c     |  245 ++-
 fs/netfs/buffered_write.c    | 1223 ++++++++++++++
 fs/netfs/crypto.c            |  148 ++
 fs/netfs/direct_read.c       |  263 +++
 fs/netfs/direct_write.c      |  359 +++++
 fs/netfs/internal.h          |  121 ++
 fs/netfs/io.c                |  325 +++-
 fs/netfs/iterator.c          |   97 ++
 fs/netfs/locking.c           |  209 +++
 fs/netfs/main.c              |  101 ++
 fs/netfs/misc.c              |  237 +++
 fs/netfs/objects.c           |   64 +-
 fs/netfs/output.c            |  485 ++++++
 fs/netfs/stats.c             |   22 +-
 fs/smb/client/Kconfig        |    1 +
 fs/smb/client/cifsfs.c       |   65 +-
 fs/smb/client/cifsfs.h       |   10 +-
 fs/smb/client/cifsglob.h     |   59 +-
 fs/smb/client/cifsproto.h    |   10 +-
 fs/smb/client/cifssmb.c      |  111 +-
 fs/smb/client/file.c         | 2905 ++++++----------------------------
 fs/smb/client/fscache.c      |  109 --
 fs/smb/client/fscache.h      |   54 -
 fs/smb/client/inode.c        |   25 +-
 fs/smb/client/smb2ops.c      |   20 +-
 fs/smb/client/smb2pdu.c      |  168 +-
 fs/smb/client/smb2proto.h    |    5 +-
 fs/smb/client/trace.h        |  144 +-
 fs/smb/client/transport.c    |   17 +-
 include/linux/fscache.h      |    6 +
 include/linux/netfs.h        |  173 +-
 include/trace/events/afs.h   |   31 -
 include/trace/events/netfs.h |  158 +-
 42 files changed, 5136 insertions(+), 4079 deletions(-)
 create mode 100644 fs/netfs/buffered_write.c
 create mode 100644 fs/netfs/crypto.c
 create mode 100644 fs/netfs/direct_read.c
 create mode 100644 fs/netfs/direct_write.c
 create mode 100644 fs/netfs/locking.c
 create mode 100644 fs/netfs/misc.c
 create mode 100644 fs/netfs/output.c


