Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7148521DC2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 18:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbgGMQaz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 12:30:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25085 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730109AbgGMQaz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594657852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NqgSBe1hMsdhej2UIP9RLhkmrdHOs9kRUk+TlrmQOJ4=;
        b=BgfMFCX+HO5cj1xym1WbncbWH/N9C5m/KsNamV95EonJAUW1mmBfIwPzDfbHsNo/8slkjM
        /ePoqiOIBkao+Uz4ZaEx6VJlHyKm2mOYU2ho9kA4C74EJyrLqt5RjA1fehJqw96tQPDyBi
        AzytxIAd9jtEZXOh7Oy3dhdAtCa2HCQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-sdHPa1YUOVi8XOAOUOVUWA-1; Mon, 13 Jul 2020 12:30:49 -0400
X-MC-Unique: sdHPa1YUOVi8XOAOUOVUWA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D33EF805723;
        Mon, 13 Jul 2020 16:30:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31AB81002391;
        Mon, 13 Jul 2020 16:30:41 +0000 (UTC)
Subject: [PATCH 00/32] fscache: Rewrite 2: Make the I/O interface use
 kiocb/iov_iter
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 13 Jul 2020 17:30:40 +0100
Message-ID: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

     - struct fscache_request_shape
     - fscache_shape_request()

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

 (1) Need to investigate whether I need to be lazy, but only to an extent,
     about closing up backing files.

 (2) Make NFS, CIFS, Ceph, 9P work with it.  Jeff Layton is working on Ceph
     and Dave Wysochanski is working on NFS.

And beyond that:

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

These patches can be found also on:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-iter

David
---
David Howells (1):
      cachefiles: Shape write requests


 fs/9p/Kconfig                          |    2 +-
 fs/Makefile                            |    2 +-
 fs/afs/Kconfig                         |    1 +
 fs/afs/cache.c                         |   54 --
 fs/afs/cell.c                          |    9 +-
 fs/afs/dir.c                           |  242 +++++--
 fs/afs/file.c                          |  575 +++++++--------
 fs/afs/fs_operation.c                  |    4 +-
 fs/afs/fsclient.c                      |  154 ++--
 fs/afs/inode.c                         |   57 +-
 fs/afs/internal.h                      |   58 +-
 fs/afs/rxrpc.c                         |  150 ++--
 fs/afs/volume.c                        |    9 +-
 fs/afs/write.c                         |  413 +++++++----
 fs/afs/yfsclient.c                     |  113 ++-
 fs/cachefiles/Makefile                 |    3 +-
 fs/cachefiles/bind.c                   |   11 +-
 fs/cachefiles/content-map.c            |  476 ++++++++++++
 fs/cachefiles/daemon.c                 |   10 +-
 fs/cachefiles/interface.c              |  564 ++++++++-------
 fs/cachefiles/internal.h               |  139 ++--
 fs/cachefiles/io.c                     |  279 +++++++
 fs/cachefiles/main.c                   |   12 +-
 fs/cachefiles/namei.c                  |  508 +++++--------
 fs/cachefiles/rdwr.c                   |  974 -------------------------
 fs/cachefiles/xattr.c                  |  263 +++----
 fs/ceph/Kconfig                        |    2 +-
 fs/cifs/Kconfig                        |    2 +-
 fs/fscache/Kconfig                     |    8 +
 fs/fscache/Makefile                    |   10 +-
 fs/fscache/cache.c                     |  136 ++--
 fs/fscache/cookie.c                    |  769 ++++++++------------
 fs/fscache/dispatcher.c                |  150 ++++
 fs/fscache/fsdef.c                     |   56 +-
 fs/fscache/histogram.c                 |    2 +-
 fs/fscache/internal.h                  |  260 +++----
 fs/fscache/io.c                        |  201 +++++
 fs/fscache/main.c                      |   35 +-
 fs/fscache/netfs.c                     |   10 +-
 fs/fscache/obj.c                       |  345 +++++++++
 fs/fscache/object-list.c               |  129 +---
 fs/fscache/object.c                    | 1133 -----------------------------
 fs/fscache/object_bits.c               |  120 +++
 fs/fscache/operation.c                 |  633 ----------------
 fs/fscache/page.c                      | 1248 --------------------------------
 fs/fscache/proc.c                      |   13 +-
 fs/fscache/read_helper.c               |  688 ++++++++++++++++++
 fs/fscache/stats.c                     |  265 +++----
 fs/internal.h                          |    5 -
 fs/nfs/Kconfig                         |    2 +-
 fs/nfs/fscache-index.c                 |    4 +-
 fs/read_write.c                        |    1 +
 include/linux/fs.h                     |    2 +
 include/linux/fscache-cache.h          |  508 +++----------
 include/linux/fscache-obsolete.h       |   13 +
 include/linux/fscache.h                |  814 ++++++++-------------
 include/linux/mm.h                     |    1 +
 include/linux/pagemap.h                |   14 +
 include/linux/uio.h                    |   11 +
 include/net/af_rxrpc.h                 |    2 +-
 include/trace/events/afs.h             |   51 +-
 include/trace/events/cachefiles.h      |  285 ++++++--
 include/trace/events/fscache.h         |  421 ++---------
 include/trace/events/fscache_support.h |   91 +++
 lib/iov_iter.c                         |  286 +++++++-
 mm/filemap.c                           |   27 +-
 net/rxrpc/recvmsg.c                    |    9 +-
 67 files changed, 5598 insertions(+), 8246 deletions(-)
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
 create mode 100644 include/trace/events/fscache_support.h


