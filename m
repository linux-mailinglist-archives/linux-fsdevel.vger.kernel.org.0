Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDBA1C40C9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 19:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbgEDRHa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 13:07:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29625 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729943AbgEDRH3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 13:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jJs/gMuiXKwFJIaZdRryVRU64ZJm+zh0opeiEZj6e6c=;
        b=RTTqX3kbz/AYcuYsnRN45qg4QUMHEF2i5qejdr5c4WCCcHCMoe6xyDSUGeQYp3bN+jVcKH
        7OrNrrrdrJOpFleI/0+Cxwbctq7gKdx6Qf85Eluh45IZey5fZgVW6118Jho2WzRx2tYWvB
        DuvQoIcwPss4h4gBRqWVtxoRpZc/44c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-V2A1h2r8NRuoqW93jjTIsg-1; Mon, 04 May 2020 13:07:23 -0400
X-MC-Unique: V2A1h2r8NRuoqW93jjTIsg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB1CAA0BEB;
        Mon,  4 May 2020 17:07:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 450542DE76;
        Mon,  4 May 2020 17:07:17 +0000 (UTC)
Subject: [RFC PATCH 00/61] fscache,
 cachefiles: Rewrite the I/O interface in terms of kiocb/iov_iter
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, dhowells@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 May 2020 18:07:16 +0100
Message-ID: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a set of patches that massively overhauls the object lifecycle
management and the I/O API of the local caching for network filesystems code
for a reduction of about 3000 LoC and a 1000 line Documentation reduction.
The ability to use async DIO to pass data to/from the cache gives a huge speed
bonus and uses less memory.

So far, only AFS has been ported to use this.  This series disabled fscache
support in all other filesystems that use it.  I'm working on NFS, but it's
tricky and I could use some help.

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

Instead, the I/O to the cache is driven much more from the netfs.  There are a
number of aspects to the I/O API:

 (1) The lowest level I/O primitives just take an iov_iter and start async
     DIO on the cache objects.  The caller gets a callback upon completion.
     The PG_fscache bit is now just used to indicate that there's a write
     to the cache in progress.  The cache will keep track in xattrs as to
     what areas of the backing file are occupied.

     - struct fscache_io_request
     - fscache_read() and fscache_write().

 (2) The cache may require that the I/O fulfil certain alignment and length
     granularity constraints.  This, and whether the cache contains the
     desired data, can be queried.

     - struct fscache_extent
     - fscache_shape_extent()

 (3) The cookie that's obtained when an inode is set up must be 'used' when a
     file is opened (with an indication as to whether it might be modified)
     and 'unused' when it is done with.  At the point of unuse, the auxdata
     and file size can be specified.

     - fscache_use_cookie(), fscache_unuse_cookie()

 (4) The cookie can be invalidated at any time, and new auxiliary data and a
     new size provided.  Any in-progress I/O will either cause new I/O to
     wait, or a replacement tmpfile will be created and the in-progress I/O
     will just be abandoned.  The on-disk auxdata (in xattrs, say) are updated
     lazily.

     - fscache_invalidate()

 (5) A helper API for reads is provided to combine the (1), (2) above and
     read_cache_pages() and also do read-(re)issue to the network in the case
     that the data isn't present or the cache fails.  This requires that an
     operation descriptor be allocated and given some operations.  This needs
     to be used for ->readpage(), ->readpages() and prefetching for
     ->write_begin().

     - struct fscache_io_request
     - fscache_read_helper()

I've also simplified the cookie management API to remove struct
fscache_cookie_def.  Instead, the pertinent details are supplied when a cookie
is created and the file size, key and auxdata are stored in the cookie.
Callbacks and backpointers are simply removed.

I've added some pieces outside of the API also:

 (1) An inode flag to mark a backing cachefile as being in use by the kernel.
     This prevents multiple caches mounted in the same directory from fighting
     over the same files.  It can also be extended to exclude other kernel
     users (such as swap) and could also be used to prevent userspace
     interfering with the file.

 (2) A new I/O iterator class, ITER_MAPPING, that iterates over the specified
     byte range of a mapping.  The caller is required to make sure that the
     pages don't evaporate under the callee (eg. pinning them by PG_locked,
     PG_writeback, PG_fscache or usage count).

     It may make sense to make this more generic and just take an xarray that
     is known to be laden with pages.  The one tricky bit there is that the
     iteration routines call find_get_page_contig() - though the only thing
     the mapping is used for is to find the xarray containing the pages.

     This is better than an ITER_BVEC as no allocation of bio_vec structs is
     required since the xarray holds pointers to all the pages involved.

 (3) Wait and unlock functions for PG_fscache.  These are in the core, so no
     need to call into fscache for it.

So, to be done hopefully before the next merge window:

 (1) Handling CONFIG_FSCACHE=n.  fscache_read_helper() is a bit intrusive,
     since it acts as the middle manager for switching between reading from
     the cache and reading from the network.  I need a no-fscache version as
     well.

     Possibly a chunk of this can/will get absorbed into the VM, since the
     request shaping conflicts with the readahead code.  Especially with
     Matthew Wilcox intending to rewrite the VM interface.

 (2) Need to investigate whether I need to be lazy, but only to an extent,
     about closing up backing files.

 (3) Make NFS, CIFS, Ceph, 9P work with it.  I'm hoping that Jeff Layton will
     do Ceph.  As mentioned, I'm having a crack at NFS, but it's evolved a bit
     since I last looked at it and it might be easier if I can palm that off
     to someone more current in the NFS I/O code.

And beyond that:

 (4) Put in support for versioned monolithic objects (eg. AFS directories).

 (5) Currently it cachefiles only caches large files up to 1GiB.  File data
     beyond that isn't cached.  The problem here is that I'm using an xattr to
     hold the content map, and xattrs may be limited in size and I've limited
     myself to using a 512 byte xattr.  I can easily make it cache a
     non-sparse file of any size with no map, but as soon as it becomes
     sparse, I need a different strategy.

 (6) Change the indexing strategy so that the culling mechanism is brought
     into the kernel, rather than doing that in userspace, and use an index
     table of files with a LRU list.

These patches can be found also on:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-iter

David
---
David Howells (61):
      afs: Make afs_zap_data() static
      iov_iter: Add ITER_MAPPING
      vm: Add wait/unlock functions for PG_fscache
      vfs: Export rw_verify_area() for use by cachefiles
      vfs: Provide S_CACHE_FILE inode flag
      afs: Disable use of the fscache I/O routines
      fscache: Add a cookie debug ID and use that in traces
      fscache: Procfile to display cookies
      fscache: Temporarily disable network filesystems' use of fscache
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
      cachefiles: Remove tree of active files and use S_CACHE_FILE inode flag
      fscache: Provide a simple thread pool for running ops asynchronously
      fscache: Replace the object management state machine
      fscache: Rewrite the I/O API based on iov_iter
      fscache: Remove fscache_wait_on_invalidate()
      fscache: Keep track of size of a file last set independently on the server
      fscache, cachefiles: Fix disabled histogram warnings
      fscache: Recast assertion in terms of cookie not being an index
      cachefiles: Remove some redundant checks on unsigned values
      cachefiles: trace: Log coherency checks
      cachefiles: Split cachefiles_drop_object() up a bit
      cachefiles: Implement new fscache I/O backend API
      cachefiles: Merge object->backer into object->dentry
      cachefiles: Implement a content-present indicator and bitmap
      cachefiles: Implement extent shaper
      cachefiles: Round the cachefile size up to DIO block size
      cachefiles: Implement read and write parts of new I/O API
      cachefiles: Add I/O tracepoints
      fscache: Add read helper
      fscache: Display cache-specific data in /proc/fs/fscache/objects
      fscache: Remove more obsolete stats
      fscache: New stats
      fscache, cachefiles: Rewrite invalidation
      fscache: Implement "will_modify" parameter on fscache_use_cookie()
      fscache: Provide resize operation
      fscache: Remove the update operation
      cachefiles: Shape write requests
      afs: Remove afs_zero_fid as it's not used
      afs: Move key to afs_read struct
      afs: Don't truncate iter during data fetch
      afs: Set up the iov_iter before calling afs_extract_data()
      afs: Use ITER_MAPPING for writing
      afs: Interpose struct fscache_io_request into struct afs_read
      afs: Note the amount transferred in fetch-data delivery
      afs: Wait on PG_fscache before modifying/releasing a page
      afs: Use new fscache I/O API
      afs: Copy local writes to the cache when writing to the server
      afs: Invoke fscache_resize_cookie() when handling ATTR_SIZE for setattr
      fscache: Rewrite the main document
      fscache: Remove the obsolete API bits from the documentation
      fscache: Document the new netfs API
      fscache: Document the rewritten cache backend API


 Documentation/filesystems/caching/backend-api.txt |  520 ++-------
 Documentation/filesystems/caching/fscache.txt     |   51 -
 Documentation/filesystems/caching/netfs-api.txt   |  926 ++++++----------
 Documentation/filesystems/caching/object.txt      |  240 ----
 Documentation/filesystems/caching/operations.txt  |  213 ----
 fs/9p/Kconfig                                     |    2 
 fs/afs/cache.c                                    |   54 -
 fs/afs/cell.c                                     |    9 
 fs/afs/dir.c                                      |  242 +++-
 fs/afs/file.c                                     |  558 ++++-----
 fs/afs/fsclient.c                                 |  127 +-
 fs/afs/inode.c                                    |   45 -
 fs/afs/internal.h                                 |   64 +
 fs/afs/rxrpc.c                                    |  112 --
 fs/afs/volume.c                                   |    9 
 fs/afs/write.c                                    |  306 +++--
 fs/afs/yfsclient.c                                |   99 +-
 fs/cachefiles/Makefile                            |    3 
 fs/cachefiles/bind.c                              |   11 
 fs/cachefiles/content-map.c                       |  489 ++++++++
 fs/cachefiles/daemon.c                            |   10 
 fs/cachefiles/interface.c                         |  558 +++++----
 fs/cachefiles/internal.h                          |  140 +-
 fs/cachefiles/io.c                                |  279 +++++
 fs/cachefiles/main.c                              |   12 
 fs/cachefiles/namei.c                             |  506 +++------
 fs/cachefiles/rdwr.c                              |  974 ----------------
 fs/cachefiles/xattr.c                             |  263 ++--
 fs/ceph/Kconfig                                   |    2 
 fs/cifs/Kconfig                                   |    2 
 fs/fscache/Kconfig                                |    4 
 fs/fscache/Makefile                               |    8 
 fs/fscache/cache.c                                |  136 +-
 fs/fscache/cookie.c                               |  768 +++++--------
 fs/fscache/dispatcher.c                           |  150 +++
 fs/fscache/fsdef.c                                |   56 -
 fs/fscache/histogram.c                            |    2 
 fs/fscache/internal.h                             |  254 +---
 fs/fscache/io.c                                   |  204 +++
 fs/fscache/main.c                                 |   34 -
 fs/fscache/netfs.c                                |   10 
 fs/fscache/obj.c                                  |  343 ++++++
 fs/fscache/object-list.c                          |  129 --
 fs/fscache/object.c                               | 1133 -------------------
 fs/fscache/object_bits.c                          |  120 ++
 fs/fscache/operation.c                            |  633 -----------
 fs/fscache/page.c                                 | 1248 ---------------------
 fs/fscache/proc.c                                 |   13 
 fs/fscache/read_helper.c                          |  580 ++++++++++
 fs/fscache/stats.c                                |  251 +---
 fs/internal.h                                     |    5 
 fs/nfs/Kconfig                                    |    2 
 fs/nfs/fscache-index.c                            |    4 
 fs/read_write.c                                   |    1 
 include/linux/fs.h                                |    2 
 include/linux/fscache-cache.h                     |  507 ++-------
 include/linux/fscache-obsolete.h                  |   13 
 include/linux/fscache.h                           |  784 +++++--------
 include/linux/pagemap.h                           |   14 
 include/linux/uio.h                               |   11 
 include/net/af_rxrpc.h                            |    2 
 include/trace/events/afs.h                        |   51 -
 include/trace/events/cachefiles.h                 |  285 ++++-
 include/trace/events/fscache.h                    |  439 +------
 lib/iov_iter.c                                    |  280 ++++-
 mm/filemap.c                                      |   18 
 net/rxrpc/recvmsg.c                               |    9 
 67 files changed, 5655 insertions(+), 9674 deletions(-)
 delete mode 100644 Documentation/filesystems/caching/operations.txt
 create mode 100644 fs/cachefiles/content-map.c
 create mode 100644 fs/cachefiles/io.c
 delete mode 100644 fs/cachefiles/rdwr.c
 create mode 100644 fs/fscache/dispatcher.c
 create mode 100644 fs/fscache/io.c
 create mode 100644 fs/fscache/obj.c
 delete mode 100644 fs/fscache/object.c
 create mode 100644 fs/fscache/object_bits.c
 delete mode 100644 fs/fscache/operation.c
 delete mode 100644 fs/fscache/page.c
 create mode 100644 fs/fscache/read_helper.c
 create mode 100644 include/linux/fscache-obsolete.h


