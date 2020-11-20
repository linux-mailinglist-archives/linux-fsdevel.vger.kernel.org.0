Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BCC2BAC76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgKTPCz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:02:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27305 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728230AbgKTPCz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:02:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605884572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AvzEbXkWDGq3m4j2v0MYXHV0NRfK51mv7g+MgzcU+jk=;
        b=eZtFKr4wvT6qLjocaSt4JfIlqdqzjiTYXKeqSnuFtpgWNOdCcMZ3njIhuf9AFZ4dTZIiR+
        Irn4b0w6UZyKVzdAcTfh5Y4rV42kIU7LQpfwyMFN3RCkD6tOOGFq3iNHoc9QwtcGrqWwN4
        agnkg5OofL7NoUv03VGj9fExB3Y8Q78=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-i1aNzOicOSyMzP5ogeYp2g-1; Fri, 20 Nov 2020 10:02:44 -0500
X-MC-Unique: i1aNzOicOSyMzP5ogeYp2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C1B263CC2;
        Fri, 20 Nov 2020 15:02:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6061660C05;
        Fri, 20 Nov 2020 15:02:33 +0000 (UTC)
Subject: [RFC PATCH 00/76] fscache: Modernisation
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-cifs@vger.kernel.org, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Latchesar Ionkov <lucho@ionkov.net>,
        Matthew Wilcox <willy@infradead.org>,
        linux-nfs@vger.kernel.org, Eric Van Hensbergen <ericvh@gmail.com>,
        dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:02:32 +0000
Message-ID: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a set of patches that modernises the fscache API by switching to use
the kiocb interface to do async DIO to/from the cache rather than by
snooping the pagecache of the backing filesystem - something that doesn't
seem totally reliable.  This means that the cache uses a lot less memory
than it did and is faster than it was.

A netfs helper library is provided that handles most of the readpage,
readahead and write_begin ops on behalf of the filesystem.  This is
intended to be used unconditionally by the filesystem and provides a common
framework for doing caching, transparent huge pages (which works with AFS)
and, in the future, possibly fscrypt.  It also allows the netfs and the
cache to align, expand and slice up a read request from the VM in various
ways; the netfs need only provide a function to read a stretch of data to
the pagecache and the helper takes care of the rest.

This patch series ports the AFS filesystem to the new API and disables
caching in NFS, Ceph, CIFS and 9P.  Jeff Layton has a port for Ceph that is
solid and Dave Wysochanski has one for NFS that is mostly solid.  I've
given partial ports to 9P and CIFS to Dominique Martinet and Steve French
respectively.

-~-

To this end, the fscache API has been massively overhauled.  Code that was
using the old API is now disabled.  It's not practical to have the two APIs
coexist because they have totally different ways of doing things, but must
share common data.

The following parts have been removed:

    - The object state machine
    - The I/O operation manager
    - All non-transient references from fscache to the netfs's data
    - All non-transient callbacks from fscache to the netfs
    - The backing page I/O monitoring
    - The tracking of netfs pages that fscache knows about
    - The tracking of netfs pages that need writing to the cache
    - The use of bmap to work out if a page is stored in the cache
    - The copy of data to/from backing pages to netfs pages.

Instead, the I/O to the cache is driven much more from the netfs and the
netfs helpers.  There are a number of aspects to the I/O API:

 (1) The lowest level I/O primitives just take an iov_iter and start async
     DIO on the cache objects.  The caller gets a callback upon completion.
     The PG_fscache bit is now just used to indicate that there's a write
     to the cache in progress.  The cache will keep track in xattrs as to
     what areas of the backing file are occupied.

     - fscache_begin_operation(), fscache_end_operation()
     - fscache_read() and fscache_write().

 (2) The cookie that's obtained when an inode is set up must be 'used' when a
     file is opened (with an indication as to whether it might be modified)
     and 'unused' when it is done with.  At the point of unuse, the auxdata
     and file size can be specified.

     - fscache_use_cookie(), fscache_unuse_cookie()

 (3) The cookie can be invalidated at any time, and new auxiliary data and a
     new size provided.  Any in-progress I/O will either cause new I/O to
     wait, or a replacement tmpfile will be created and the in-progress I/O
     will just be abandoned.  The on-disk auxdata (in xattrs, say) are updated
     lazily.

     - fscache_invalidate()

 (4) The netfs helpers for read are provided to combine the (1), (2) above
     and do read-(re)issue to the network in the case that the data isn't
     present or the cache fails.  This requires that an operation
     descriptor be allocated and given some operations.  This needs to be
     used for ->readpage(), ->readahead() and prefetching for
     ->write_begin().  ->readpages() is obsolete and soon to go away.

     - include/linux/netfs.h
     - netfs_readpage(), netfs_readahead(), netfs_begin_write()

 (5) There are some helpers to keep a cookie in use once a file has been
     closed so that writeback can write to the cache.  write_inode and
     evict inode need to clear this.

     - fscache_set_page_dirty(), fscache_unpin_writeback()
     - fscache_write_to_cache()

I've also simplified the cookie management API to remove struct
fscache_cookie_def.  Instead, the pertinent details are supplied when a
cookie is created and the file size, key and auxdata are stored in the
cookie.  Callbacks and backpointers are simply removed.

I've added some pieces outside of the API also:

 (1) An inode flag to mark a backing cachefile as being in use by the
     kernel.  This prevents multiple caches mounted in the same directory
     from fighting over the same files.  It can also be extended to exclude
     other kernel users (such as swap) and could also be used to prevent
     userspace interfering with the file.

 (2) A new I/O iterator class, ITER_XARRAY, that iterates over the
     specified byte range of an xarray.  The caller is required to make
     sure that the pages don't evaporate under the callee (eg. pinning them
     by PG_locked, PG_writeback, PG_fscache or usage count).

     This is better than an ITER_BVEC as no allocation of bio_vec structs
     is required since the xarray holds pointers to all the pages involved.

 (3) Wait and unlock functions for PG_fscache.  These are in the core, so
     no need to call into fscache for it.

Future stuff:

 (1) Avoid the need to double-truncate a backing file on relinquishment.
     The first truncate cuts of rubbish data from the end so that it's not
     retrieved in future; the second expands the EOF back out to DIO block
     size.

 (2) Add a write helper to improve on generic_perform_write(), allowing a
     span of pages to be modified as a block and to take account of cache
     granularity.

 (3) Put in support for versioned monolithic objects (eg. AFS directories).

 (4) Currently it cachefiles only caches large files up to 1GiB.  File data
     beyond that isn't cached.  The problem here is that I'm using an xattr to
     hold the content map, and xattrs may be limited in size and I've limited
     myself to using a 512 byte xattr.  I can easily make it cache a
     non-sparse file of any size with no map, but as soon as it becomes
     sparse, I need a different strategy.

 (5) Change the indexing strategy so that the culling mechanism is brought
     into the kernel, rather than doing that in userspace, and use an index
     table of files with a LRU list.

 (6) Add support for throttling readahead when the server pushes back (cifs
     credits).

These patches can be found also on:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-iter

David
---
David Howells (75):
      nfs, cifs, ceph, 9p: Disable use of fscache prior to its rewrite
      afs: Disable use of the fscache I/O routines
      fscache: Add a cookie debug ID and use that in traces
      fscache: Procfile to display cookies
      fscache: Remove the old I/O API
      fscache: Remove the netfs data from the cookie
      fscache: Remove struct fscache_cookie_def
      fscache: Remove store_limit* from struct fscache_object
      fscache: Remove fscache_check_consistency()
      fscache: Remove fscache_attr_changed()
      fscache: Remove obsolete stats
      fscache: Remove old I/O tracepoints
      fscache: Temporarily disable fscache_invalidate()
      fscache: Remove the I/O operation manager
      fscache: Change %p in format strings to something else
      cachefiles: Change %p in format strings to something else
      iov_iter: Add ITER_XARRAY
      vm: Add wait/unlock functions for PG_fscache
      mm: Implement readahead_control pageset expansion
      mm: Stop generic_file_buffered_read() from grabbing a superfluous page
      vfs: Export rw_verify_area() for use by cachefiles
      vfs: Provide S_CACHE_FILE inode flag
      cachefiles: Remove tree of active files and use S_CACHE_FILE inode flag
      fscache: Provide a simple thread pool for running ops asynchronously
      fscache: Replace the object management state machine
      fscache: Rewrite the I/O API based on iov_iter
      fscache: Keep track of size of a file last set independently on the server
      fscache, cachefiles: Fix disabled histogram warnings
      fscache: Recast assertion in terms of cookie not being an index
      vfs, fscache: Force ->write_inode() to occur if cookie pinned for writeback
      fscache: Allow ->put_super() to be used to wait for cache operations
      netfs: Make a netfs helper module
      netfs: Provide readahead and readpage netfs helpers
      netfs: Use the cache
      fscache: read-helper: Add tracepoints
      cachefiles: Remove some redundant checks on unsigned values
      cachefiles: trace: Log coherency checks
      cachefiles: Split cachefiles_drop_object() up a bit
      cachefiles: Implement new fscache I/O backend API
      cachefiles: Merge object->backer into object->dentry
      cachefiles: Implement a content-present indicator and bitmap
      cachefiles: Shape requests from the fscache read helper
      cachefiles: Round the cachefile size up to DIO block size
      cachefiles: Implement read and write parts of new I/O API
      cachefiles: Add I/O tracepoints
      fscache: Display cache-specific data in /proc/fs/fscache/objects
      fscache: Remove more obsolete stats
      fscache: Always create /proc/fs/fscache/stats if configured
      netfs: Stats
      fscache: New stats
      fscache, cachefiles: Rewrite invalidation
      fscache: Implement "will_modify" parameter on fscache_use_cookie()
      fscache: Provide resize operation
      fscache: Remove the update operation
      afs: Pass page into dirty region helpers to provide THP size
      afs: Print the operation debug_id when logging an unexpected data version
      afs: Move key to afs_read struct
      afs: Don't truncate iter during data fetch
      afs: Log remote unmarshalling errors
      afs: Set up the iov_iter before calling afs_extract_data()
      afs: Use ITER_XARRAY for writing
      afs: Wait on PG_fscache before modifying/releasing a page
      afs: Extract writeback extension into its own function
      afs: Prepare for use of THPs
      afs: Use the fs operation ops to handle FetchData completion
      afs: Use new fscache read helper API
      netfs: Add write_begin helper
      fscache: Add support for writing to the cache
      afs: Use the fscache_write_begin() helper
      afs: Copy local writes to the cache when writing to the server
      afs: Invoke fscache_resize_cookie() when handling ATTR_SIZE for setattr
      afs: Add O_DIRECT read support
      afs: Skip truncation on the server of data we haven't written yet
      afs: Make afs_write_begin() return the THP subpage
      afs: Fix speculative status fetch going out of order wrt to modifications

Jeff Layton (1):
      fscache: disable cookie when doing an invalidation for DIO write


 fs/Kconfig                        |    1 +
 fs/Makefile                       |    1 +
 fs/afs/Kconfig                    |    1 +
 fs/afs/cache.c                    |   54 --
 fs/afs/cell.c                     |    9 +-
 fs/afs/dir.c                      |  226 ++++--
 fs/afs/file.c                     |  562 +++++--------
 fs/afs/fs_operation.c             |    4 +-
 fs/afs/fsclient.c                 |  126 ++-
 fs/afs/inode.c                    |  108 ++-
 fs/afs/internal.h                 |   69 +-
 fs/afs/rxrpc.c                    |  150 ++--
 fs/afs/super.c                    |   25 +
 fs/afs/volume.c                   |    9 +-
 fs/afs/write.c                    |  819 +++++++++++--------
 fs/afs/yfsclient.c                |   94 +--
 fs/cachefiles/Makefile            |    3 +-
 fs/cachefiles/bind.c              |   13 +-
 fs/cachefiles/content-map.c       |  515 ++++++++++++
 fs/cachefiles/daemon.c            |   10 +-
 fs/cachefiles/interface.c         |  597 ++++++++------
 fs/cachefiles/internal.h          |  155 ++--
 fs/cachefiles/io.c                |  360 +++++++++
 fs/cachefiles/key.c               |    2 +-
 fs/cachefiles/main.c              |   12 +-
 fs/cachefiles/namei.c             |  538 +++++--------
 fs/cachefiles/rdwr.c              |  975 ----------------------
 fs/cachefiles/xattr.c             |  271 +++----
 fs/fs-writeback.c                 |    8 +
 fs/fscache/Kconfig                |    2 +
 fs/fscache/Makefile               |   10 +-
 fs/fscache/cache.c                |  171 ++--
 fs/fscache/cache_init.c           |  139 ++++
 fs/fscache/cookie.c               |  939 ++++++++++------------
 fs/fscache/dispatcher.c           |  151 ++++
 fs/fscache/fsdef.c                |   56 +-
 fs/fscache/histogram.c            |    2 +-
 fs/fscache/internal.h             |  268 ++-----
 fs/fscache/io.c                   |  390 +++++++++
 fs/fscache/main.c                 |  151 +---
 fs/fscache/netfs.c                |   10 +-
 fs/fscache/obj.c                  |  360 +++++++++
 fs/fscache/object-list.c          |  129 +--
 fs/fscache/object.c               | 1133 --------------------------
 fs/fscache/object_bits.c          |  120 +++
 fs/fscache/operation.c            |  633 ---------------
 fs/fscache/page.c                 | 1248 -----------------------------
 fs/fscache/proc.c                 |   55 +-
 fs/fscache/stats.c                |  233 ++----
 fs/internal.h                     |    5 -
 fs/netfs/Kconfig                  |   23 +
 fs/netfs/Makefile                 |    5 +
 fs/netfs/internal.h               |   97 +++
 fs/netfs/read_helper.c            | 1125 ++++++++++++++++++++++++++
 fs/netfs/stats.c                  |   57 ++
 fs/nfs/fscache-index.c            |    4 +-
 fs/read_write.c                   |    1 +
 include/linux/fs.h                |    5 +
 include/linux/fscache-cache.h     |  510 +++---------
 include/linux/fscache-obsolete.h  |   13 +
 include/linux/fscache.h           |  814 ++++++++-----------
 include/linux/netfs.h             |  111 +++
 include/linux/pagemap.h           |   16 +
 include/linux/uio.h               |   11 +
 include/linux/writeback.h         |    1 +
 include/net/af_rxrpc.h            |    2 +-
 include/trace/events/afs.h        |   74 +-
 include/trace/events/cachefiles.h |  287 +++++--
 include/trace/events/fscache.h    |  428 ++--------
 include/trace/events/netfs.h      |  202 +++++
 lib/iov_iter.c                    |  312 +++++++-
 mm/filemap.c                      |   20 +
 mm/readahead.c                    |   70 ++
 net/rxrpc/recvmsg.c               |    9 +-
 74 files changed, 7421 insertions(+), 8698 deletions(-)
 create mode 100644 fs/cachefiles/content-map.c
 create mode 100644 fs/cachefiles/io.c
 delete mode 100644 fs/cachefiles/rdwr.c
 create mode 100644 fs/fscache/cache_init.c
 create mode 100644 fs/fscache/dispatcher.c
 create mode 100644 fs/fscache/io.c
 create mode 100644 fs/fscache/obj.c
 delete mode 100644 fs/fscache/object.c
 create mode 100644 fs/fscache/object_bits.c
 delete mode 100644 fs/fscache/operation.c
 delete mode 100644 fs/fscache/page.c
 create mode 100644 fs/netfs/Kconfig
 create mode 100644 fs/netfs/Makefile
 create mode 100644 fs/netfs/internal.h
 create mode 100644 fs/netfs/read_helper.c
 create mode 100644 fs/netfs/stats.c
 create mode 100644 include/linux/fscache-obsolete.h
 create mode 100644 include/linux/netfs.h
 create mode 100644 include/trace/events/netfs.h


