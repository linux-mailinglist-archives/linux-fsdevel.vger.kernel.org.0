Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00B5302DE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 22:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732753AbhAYVcq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 16:32:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57938 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732173AbhAYVcf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:32:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611610264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=A6SKlxCDsYxb+LTCgnFQKtSg53KqZyewCqb9ymOXWxY=;
        b=PqaEzviRoe1A7lDZhkaQijpd2O1RfsRzYoMYiEm3d+s2NyEWy+srsHkHNn5rDz4TklPsuL
        ysX++PMM29w5h6ESMdjfkbbCA1ZsR+EfbTzRro7vOlWw73DugUWwieRfXq1D6Wp5cPWIlv
        gIxYGJaEqC2JBC4qPrZUkuW5FLaE4ys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-PBQQrQrpPguFBRI--bmU3w-1; Mon, 25 Jan 2021 16:31:00 -0500
X-MC-Unique: PBQQrQrpPguFBRI--bmU3w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1ECA10054FF;
        Mon, 25 Jan 2021 21:30:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D1FE10013C1;
        Mon, 25 Jan 2021 21:30:51 +0000 (UTC)
Subject: [PATCH 00/32] Network fs helper library & fscache kiocb API [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-afs@lists.infradead.org,
        Dave Wysochanski <dwysocha@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 25 Jan 2021 21:30:50 +0000
Message-ID: <161161025063.2537118.2009249444682241405.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a set of patches to do two things:

 (1) Add a helper library to handle the new VM readahead interface.  This
     is intended to be used unconditionally by the filesystem (whether or
     not caching is enabled) and provides a common framework for doing
     caching, transparent huge pages and, in the future, possibly fscrypt
     and read bandwidth maximisation.  It also allows the netfs and the
     cache to align, expand and slice up a read request from the VM in
     various ways; the netfs need only provide a function to read a stretch
     of data to the pagecache and the helper takes care of the rest.

 (2) Add an alternative fscache/cachfiles I/O API that uses the kiocb
     facility to do async DIO to transfer data to/from the netfs's pages,
     rather than using readpage with wait queue snooping on one side and
     vfs_write() on the other.  It also uses less memory, since it doesn't
     do buffered I/O on the backing file.

     Note that this uses SEEK_HOLE/SEEK_DATA to locate the data available
     to be read from the cache.  Whilst this is an improvement from the
     bmap interface, it still has a problem with regard to a modern
     extent-based filesystem inserting or removing bridging blocks of
     zeros.  Fixing that requires a much greater overhaul.

This is a step towards overhauling the fscache API.  The change is opt-in
on the part of the network filesystem.  A netfs should not try to mix the
old and the new API because of conflicting ways of handling pages and the
PG_fscache page flag and because it would be mixing DIO with buffered I/O.
Further, the helper library can't be used with the old API.

This does not change any of the fscache cookie handling APIs or the way
invalidation is done.

In the near term, I intend to deprecate and remove the old I/O API
(fscache_allocate_page{,s}(), fscache_read_or_alloc_page{,s}(),
fscache_write_page() and fscache_uncache_page()) and eventually replace
most of fscache/cachefiles with something simpler and easier to follow.

The patchset contains five parts:

 (1) Some helper patches, including provision of an ITER_XARRAY iov
     iterator and a function to do readahead expansion.

 (2) Patches to add the netfs helper library.

 (3) A patch to add the fscache/cachefiles kiocb API

 (4) Patches to add support in AFS for this.

 (5) Patches from David Wysochanski to add support in NFS for this.

Jeff Layton also has patches for Ceph for this, though they're not included
on this branch.

With this, AFS without a cache passes all expected xfstests; with a cache,
there's an extra failure, but that's also there before these patches.
Fixing that probably requires a greater overhaul.  Ceph and NFS also pass
the expected tests.

These patches can be found also on:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-netfs-lib


Changes
=======

 (v2) Fix some bugs and add NFS support.

David
---
Dave Wysochanski (8):
      NFS: Clean up nfs_readpage() and nfs_readpages()
      NFS: In nfs_readpage() only increment NFSIOS_READPAGES when read succeeds
      NFS: Refactor nfs_readpage() and nfs_readpage_async() to use nfs_readdesc
      NFS: Call readpage_async_filler() from nfs_readpage_async()
      NFS: Add nfs_pageio_complete_read() and remove nfs_readpage_async()
      NFS: Allow internal use of read structs and functions
      NFS: Convert to the netfs API and nfs_readpage to use netfs_readpage
      NFS: Convert readpage to readahead and use netfs_readahead for fscache

David Howells (24):
      iov_iter: Add ITER_XARRAY
      vm: Add wait/unlock functions for PG_fscache
      mm: Implement readahead_control pageset expansion
      vfs: Export rw_verify_area() for use by cachefiles
      netfs: Make a netfs helper module
      netfs: Provide readahead and readpage netfs helpers
      netfs: Add tracepoints
      netfs: Gather stats
      netfs: Add write_begin helper
      netfs: Define an interface to talk to a cache
      fscache, cachefiles: Add alternate API to use kiocb for read/write to cache
      afs: Disable use of the fscache I/O routines
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


 fs/Kconfig                    |    1 +
 fs/Makefile                   |    1 +
 fs/afs/Kconfig                |    1 +
 fs/afs/dir.c                  |  225 ++++---
 fs/afs/file.c                 |  472 ++++----------
 fs/afs/fs_operation.c         |    4 +-
 fs/afs/fsclient.c             |  108 +--
 fs/afs/inode.c                |    7 +-
 fs/afs/internal.h             |   57 +-
 fs/afs/rxrpc.c                |  150 ++---
 fs/afs/write.c                |  610 +++++++++--------
 fs/afs/yfsclient.c            |   82 +--
 fs/cachefiles/Makefile        |    1 +
 fs/cachefiles/interface.c     |    5 +-
 fs/cachefiles/internal.h      |    9 +
 fs/cachefiles/rdwr2.c         |  412 ++++++++++++
 fs/fscache/Kconfig            |    1 +
 fs/fscache/Makefile           |    3 +-
 fs/fscache/internal.h         |    3 +
 fs/fscache/page.c             |    2 +-
 fs/fscache/page2.c            |  116 ++++
 fs/fscache/stats.c            |    1 +
 fs/internal.h                 |    5 -
 fs/netfs/Kconfig              |   23 +
 fs/netfs/Makefile             |    5 +
 fs/netfs/internal.h           |   97 +++
 fs/netfs/read_helper.c        | 1155 +++++++++++++++++++++++++++++++++
 fs/netfs/stats.c              |   59 ++
 fs/nfs/file.c                 |    2 +-
 fs/nfs/fscache.c              |  206 +++---
 fs/nfs/fscache.h              |   66 +-
 fs/nfs/internal.h             |    8 +
 fs/nfs/pagelist.c             |    2 +
 fs/nfs/read.c                 |  244 ++++---
 fs/read_write.c               |    1 +
 include/linux/fs.h            |    1 +
 include/linux/fscache-cache.h |    4 +
 include/linux/fscache.h       |   28 +-
 include/linux/netfs.h         |  167 +++++
 include/linux/nfs_fs.h        |    5 +-
 include/linux/nfs_iostat.h    |    2 +-
 include/linux/nfs_page.h      |    1 +
 include/linux/nfs_xdr.h       |    1 +
 include/linux/pagemap.h       |   16 +
 include/net/af_rxrpc.h        |    2 +-
 include/trace/events/afs.h    |   74 +--
 include/trace/events/netfs.h  |  201 ++++++
 mm/filemap.c                  |   18 +
 mm/readahead.c                |   70 ++
 net/rxrpc/recvmsg.c           |    9 +-
 50 files changed, 3457 insertions(+), 1286 deletions(-)
 create mode 100644 fs/cachefiles/rdwr2.c
 create mode 100644 fs/fscache/page2.c
 create mode 100644 fs/netfs/Kconfig
 create mode 100644 fs/netfs/Makefile
 create mode 100644 fs/netfs/internal.h
 create mode 100644 fs/netfs/read_helper.c
 create mode 100644 fs/netfs/stats.c
 create mode 100644 include/linux/netfs.h
 create mode 100644 include/trace/events/netfs.h


