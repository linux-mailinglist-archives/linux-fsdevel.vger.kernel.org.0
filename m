Return-Path: <linux-fsdevel+bounces-34030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1899D9C2305
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 18:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2CA1F2313F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 17:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FB61DFD1;
	Fri,  8 Nov 2024 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QosFGMJh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FFF19A28D
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087177; cv=none; b=cFncWA9XL+50c92Lpl2AcDdB2ptrRn5gFOLvBHO29u41Q4K8QVhX8nQjwptUVYDjQsE69RAyvuQjTNLz2GEeqdzYUpGX6xlIsZTIYv9vI7rUEQX408vN2AbshplEol6ZnUHmkrPxCkl/q+CmCzPDQliCelyc22TcL1wHXZjzSW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087177; c=relaxed/simple;
	bh=YVAf6dkVeix+Aa+7/7/fg5vaw8mAaNnK9yzzse1iTD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VWmMejkcu/MGTBBHy6FdYPTxbwIqIewFw9caQswnw0aIWZnahIArO0HRhkITkJd1T6ooSJPnRTXI0uVPxnVzi0andzGWlMRwBbJ+h/jHonIiUTs9FyPW3W7ISjKebPvbBsL+kQb+q+rc2COANpNuj7mvRK2gyKHb3M+SUSzuUhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QosFGMJh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731087175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oU8LmkNk2dSoLHDzCk+jdshwsXPR8nc3vzoyXL8IdME=;
	b=QosFGMJhS/pzI470Pkew7zfGCjKqw8fg1/SRaHwbwB3+l/sRqIvAAUNBKLtywnbvcRGc1t
	59iUKVJxhtL7bCXU6neLobvP/ylhTTDqJ9nh00j9pTRdrA2iKwTl7BSb8VER2TU/RzfJNv
	yGgIezBim/PFNe8t1oF6mbBRQ8gjq48=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-kQ78rOMMOqW5W5e48ndDsg-1; Fri,
 08 Nov 2024 12:32:49 -0500
X-MC-Unique: kQ78rOMMOqW5W5e48ndDsg-1
X-Mimecast-MFC-AGG-ID: kQ78rOMMOqW5W5e48ndDsg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 704391956096;
	Fri,  8 Nov 2024 17:32:45 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E133300019E;
	Fri,  8 Nov 2024 17:32:38 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/33] netfs: Read performance improvements and "single-blob" support
Date: Fri,  8 Nov 2024 17:32:01 +0000
Message-ID: <20241108173236.1382366-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Christian, Steve, Willy,

This set of patches is primarily about two things: improving read
performance and supporting monolithic single-blob objects that have to be
read/written as such (e.g. AFS directory contents).  The implementation of
the two parts is interwoven as each makes the other possible.

READ PERFORMANCE
================

The read performance improvements are intended to speed up some loss of
performance detected in cifs and to a lesser extend in afs.  The problem is
that we queue too many work items during the collection of read results:
each individual subrequest is collected by its own work item, and then they
have to interact with each other when a series of subrequests don't exactly
align with the pattern of folios that are being read by the overall
request.

Whilst the processing of the pages covered by individual subrequests as
they complete potentially allows folios to be woken in parallel and with
minimum delay, it can shuffle wakeups for sequential reads out of order -
and that is the most common I/O pattern.

The final assessment and cleanup of an operation is then held up until the
last I/O completes - and for a synchronous sequential operation, this means
the bouncing around of work items just adds latency.

Two changes have been made to make this work:

 (1) All collection is now done in a single "work item" that works
     progressively through the subrequests as they complete (and also
     dispatches retries as necessary).

 (2) For readahead and AIO, this work item be done on a workqueue and can
     run in parallel with the ultimate consumer of the data; for
     synchronous direct or unbuffered reads, the collection is run in the
     application thread and not offloaded.

Functions such as smb2_readv_callback() then just tell netfslib that the
subrequest has terminated; netfslib does a minimal bit of processing on the
spot - stat counting and tracing mostly - and then queues/wakes up the
worker.  This simplifies the logic as the collector just walks sequentially
through the subrequests as they complete and walks through the folios, if
buffered, unlocking them as it goes.  It also keeps to a minimum the amount
of latency injected into the filesystem's low-level I/O handling


SINGLE-BLOB OBJECT SUPPORT
==========================

Single-blob objects are files for which the content of the file must be
read from or written to the server in a single operation because reading
them in parts may yield inconsistent results.  AFS directories are an
example of this as there exists the possibility that the contents are
generated on the fly and would differ between reads or might change due to
third party interference.

Such objects will be written to and retrieved from the cache if one is
present, though we allow/may need to propose multiple subrequests to do so.
The important part is that read from/write to the *server* is monolithic.

Single blob reading is, for the moment, fully synchronous and does result
collection in the application thread and, also for the moment, the API is
supplied the buffer in the form of a folio_queue chain rather than using
the pagecache.


AFS CHANGES
===========

This series makes a number of changes to the kafs filesystem, primarily in
the area of directory handling:

 (1) AFS's FetchData RPC reply processing is made partially asynchronous
     which allows the netfs_io_request's outstanding operation counter to
     be removed as part of reducing the collection to a single work item.

 (2) Directory and symlink reading are plumbed through netfslib using the
     single-blob object API and are now cacheable with fscache.  This also
     allows the afs_read struct to be eliminated and netfs_io_subrequest to
     be used directly instead.

 (3) Directory and symlink content are now stored in a folio_queue buffer
     rather than in the pagecache.  This means we don't require the RCU
     read lock and xarray iteration to access it, and folios won't randomly
     disappear under us because the VM wants them back.

     There are some downsides to this, though: the storage folios are no
     longer known to the VM, drop_caches can't flush them, the folios are
     not migrateable.  The inode must also be marked dirty manually to get
     the data written to the cache in the background.

 (4) The vnode operation lock is changed from a mutex struct to a private
     lock implementation.  The problem is that the lock now needs to be
     dropped in a separate thread and mutexes don't permit that.

 (5) When a new directory or symlink is created, we now initialise it
     locally and mark it valid rather than downloading it (we know what
     it's likely to look like).

 (6) We now use the in-directory hashtable to reduce the number of entries
     we need to scan when doing a lookup.  The edit routines have to
     maintain the hash chains.

 (7) Cancellation (e.g. by signal) of an async call after the rxrpc_call
     has been set up is now offloaded to the worker thread as there will be
     a notification from rxrpc upon completion.  This avoids a double
     cleanup.


SUPPORTING CHANGES
==================

To support the above some other changes are also made:

 (1) A "rolling buffer" implementation is created to abstract out the two
     separate folio_queue chaining implementations I had (one for read and
     one for write).

 (2) Functions are provided to create/extend a buffer in a folio_queue
     chain and tear it down again.  This is used to handle AFS directories,
     but could also be used to create bounce buffers for content crypto and
     transport crypto.

 (3) The was_async argument is dropped from netfs_read_subreq_terminated().
     Instead we wake the read collection work item by either queuing it or
     waking up the app thread.

 (4) We don't need to use BH-excluding locks when communicating between the
     issuing thread and the collection thread as neither of them now run in
     BH context.


MISCELLANY
==========

Also included are some fixes from Matthew Wilcox that need to be applied
first; a number of new tracepoints; a split of the netfslib write
collection code to put retrying into its own file (it gets more complicated
with content encryption).

There are also some minor fixes AFS included, including fixing the AFS
directory format struct layout, reducing some directory over-invalidation
and making afs_mkdir() translate EEXIST to ENOTEMPY (which is not available
on all systems the servers support).

Finally, there's a patch to try and detect entry into the folio unlock
function with no folio_queue structs in the buffer (which isn't allowed in
the cases that can get there).  This is a debugging patch, but should be
minimal overhead.


The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-writeback


CHANGES
=======

ver #4)
 - Fix abandonment of folios that are contributed to by a failed read
   subreq (such as from an interrupted op).
 - In afs, fix handling of failure between the directory/symlink content
   buffer being allocated and reading into it (thereby making it appear
   valid).

ver #3)
 - In afs, fix a number of issues in asynchronous FetchData handling.
 - In afs, fix a signedness issue in an error check dir editing.
 - To afs, add a patch to fix handling of interruption by a signal whilst
    an async call is being set up.

ver #2)
 - Handle that we might be in RCU pathwalk in afs_get_link().
 - Fix double-call of afs_put_operation() in async FetchData.
 - Don't set ->mapping on directory and symlink folios as they're not in
   the pagecache.
 - Add an afs patch to search the directory's hash table on lookup.
 - Add an afs patch to preset the contents of a new symlink on creation.
 - Add an afs patch to add a tracepoint in the async FetchData response
   processing.
 - Add a patch to report if a NULL folio_queue pointer is seen in
   netfs_writeback_unlock_folios().

Thanks,
David

David Howells (30):
  kheaders: Ignore silly-rename files
  netfs: Use a folio_queue allocation and free functions
  netfs: Add a tracepoint to log the lifespan of folio_queue structs
  netfs: Abstract out a rolling folio buffer implementation
  netfs: Make netfs_advance_write() return size_t
  netfs: Split retry code out of fs/netfs/write_collect.c
  netfs: Drop the error arg from netfs_read_subreq_terminated()
  netfs: Drop the was_async arg from netfs_read_subreq_terminated()
  netfs: Don't use bh spinlock
  afs: Don't use mutex for I/O operation lock
  afs: Fix EEXIST error returned from afs_rmdir() to be ENOTEMPTY
  afs: Fix directory format encoding struct
  netfs: Remove some extraneous directory invalidations
  cachefiles: Add some subrequest tracepoints
  cachefiles: Add auxiliary data trace
  afs: Add more tracepoints to do with tracking validity
  netfs: Add functions to build/clean a buffer in a folio_queue
  netfs: Add support for caching single monolithic objects such as AFS
    dirs
  afs: Make afs_init_request() get a key if not given a file
  afs: Use netfslib for directories
  afs: Use netfslib for symlinks, allowing them to be cached
  afs: Eliminate afs_read
  afs: Fix cleanup of immediately failed async calls
  afs: Make {Y,}FS.FetchData an asynchronous operation
  netfs: Change the read result collector to only use one work item
  afs: Make afs_mkdir() locally initialise a new directory's content
  afs: Use the contained hashtable to search a directory
  afs: Locally initialise the contents of a new symlink on creation
  afs: Add a tracepoint for afs_read_receive()
  netfs: Report on NULL folioq in netfs_writeback_unlock_folios()

Matthew Wilcox (Oracle) (3):
  netfs: Remove call to folio_index()
  netfs: Fix a few minor bugs in netfs_page_mkwrite()
  netfs: Remove unnecessary references to pages

 fs/9p/vfs_addr.c                  |   8 +-
 fs/afs/Makefile                   |   1 +
 fs/afs/callback.c                 |   4 +-
 fs/afs/dir.c                      | 804 +++++++++++++++---------------
 fs/afs/dir_edit.c                 | 383 ++++++++------
 fs/afs/dir_search.c               | 227 +++++++++
 fs/afs/file.c                     | 260 +++++-----
 fs/afs/fs_operation.c             | 113 ++++-
 fs/afs/fsclient.c                 |  62 +--
 fs/afs/inode.c                    | 140 +++++-
 fs/afs/internal.h                 | 143 ++++--
 fs/afs/main.c                     |   2 +-
 fs/afs/mntpt.c                    |  22 +-
 fs/afs/rotate.c                   |   4 +-
 fs/afs/rxrpc.c                    |  37 +-
 fs/afs/super.c                    |   4 +-
 fs/afs/validation.c               |  31 +-
 fs/afs/vlclient.c                 |   1 +
 fs/afs/write.c                    |  16 +-
 fs/afs/xdr_fs.h                   |   2 +-
 fs/afs/yfsclient.c                |  49 +-
 fs/cachefiles/io.c                |   4 +
 fs/cachefiles/xattr.c             |   9 +-
 fs/ceph/addr.c                    |  13 +-
 fs/netfs/Makefile                 |   5 +-
 fs/netfs/buffered_read.c          | 276 ++++------
 fs/netfs/buffered_write.c         |  41 +-
 fs/netfs/direct_read.c            |  80 +--
 fs/netfs/direct_write.c           |  10 +-
 fs/netfs/internal.h               |  36 +-
 fs/netfs/main.c                   |   6 +-
 fs/netfs/misc.c                   | 163 +++---
 fs/netfs/objects.c                |  21 +-
 fs/netfs/read_collect.c           | 708 +++++++++++++++-----------
 fs/netfs/read_pgpriv2.c           |  35 +-
 fs/netfs/read_retry.c             | 209 ++++----
 fs/netfs/read_single.c            | 195 ++++++++
 fs/netfs/rolling_buffer.c         | 225 +++++++++
 fs/netfs/stats.c                  |   4 +-
 fs/netfs/write_collect.c          | 278 ++---------
 fs/netfs/write_issue.c            | 239 ++++++++-
 fs/netfs/write_retry.c            | 233 +++++++++
 fs/nfs/fscache.c                  |   6 +-
 fs/nfs/fscache.h                  |   3 +-
 fs/smb/client/cifssmb.c           |  12 +-
 fs/smb/client/file.c              |   3 +-
 fs/smb/client/smb2ops.c           |   2 +-
 fs/smb/client/smb2pdu.c           |  14 +-
 include/linux/folio_queue.h       |  12 +-
 include/linux/netfs.h             |  55 +-
 include/linux/rolling_buffer.h    |  61 +++
 include/trace/events/afs.h        | 210 +++++++-
 include/trace/events/cachefiles.h |  13 +-
 include/trace/events/netfs.h      |  98 ++--
 kernel/gen_kheaders.sh            |   1 +
 lib/kunit_iov_iter.c              |   4 +-
 56 files changed, 3646 insertions(+), 1951 deletions(-)
 create mode 100644 fs/afs/dir_search.c
 create mode 100644 fs/netfs/read_single.c
 create mode 100644 fs/netfs/rolling_buffer.c
 create mode 100644 fs/netfs/write_retry.c
 create mode 100644 include/linux/rolling_buffer.h


