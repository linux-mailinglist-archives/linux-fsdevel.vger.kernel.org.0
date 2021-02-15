Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9621531BD6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 16:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhBOPsH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 10:48:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30947 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231563AbhBOPqD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613403868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OUcau2RScLJC1sbBhCFeWAqe5oOjO8CLqdBwSyrKW/k=;
        b=aKRRAT0XkQ4dzQv6Uq8SPMZbl7wOGK5G33jAK5jEnHigAg8PSIbS4se1nafW3dbO6OOTwv
        /kzuba03qHiSnFuN4Yw6E/YEdLN5QA/xmjJVL93JrygI5NJmKlO2Vqh9XCaeN+NaCTFJhX
        hVmucm8NGyYkstGu6lmlAHsMhZjqwck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-TJr8slT8P9GEspE4LilBZQ-1; Mon, 15 Feb 2021 10:44:24 -0500
X-MC-Unique: TJr8slT8P9GEspE4LilBZQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 736BB79EC2;
        Mon, 15 Feb 2021 15:44:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-68.rdu2.redhat.com [10.10.119.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38F3B608DB;
        Mon, 15 Feb 2021 15:44:14 +0000 (UTC)
Subject: [PATCH 00/33] Network fs helper library & fscache kiocb API [ver #3]
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-cachefs@redhat.com,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-afs@lists.infradead.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        v9fs-developer@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 15 Feb 2021 15:44:13 +0000
Message-ID: <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

 (3) A patch to add the fscache/cachefiles kiocb API.

 (4) Patches to add support in AFS for this.

 (5) Patches from Jeff Layton to add support in Ceph for this.

Dave Wysochanski also has patches for NFS for this, though they're not
included on this branch as there's an issue with PNFS.

With this, AFS without a cache passes all expected xfstests; with a cache,
there's an extra failure, but that's also there before these patches.
Fixing that probably requires a greater overhaul.  Ceph and NFS also pass
the expected tests.

These patches can be found also on:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-netfs-lib

For diffing reference, the tag for the 9th Feb pull request is
fscache-ioapi-20210203 and can be found in the same repository.



Changes
=======

 (v3) Rolled in the bug fixes.

      Adjusted the functions that unlock and wait for PG_fscache according
      to Linus's suggestion.

      Hold a ref on a page when PG_fscache is set as per Linus's
      suggestion.

      Dropped NFS support and added Ceph support.

 (v2) Fixed some bugs and added NFS support.


References
==========

These patches have been published for review before, firstly as part of a
larger set:

Link: https://lore.kernel.org/linux-fsdevel/158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk/

Link: https://lore.kernel.org/linux-fsdevel/159465766378.1376105.11619976251039287525.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/linux-fsdevel/159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/linux-fsdevel/159465821598.1377938.2046362270225008168.stgit@warthog.procyon.org.uk/

Link: https://lore.kernel.org/linux-fsdevel/160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk/

Then as a cut-down set:

Link: https://lore.kernel.org/linux-fsdevel/161118128472.1232039.11746799833066425131.stgit@warthog.procyon.org.uk/

Link: https://lore.kernel.org/linux-fsdevel/161161025063.2537118.2009249444682241405.stgit@warthog.procyon.org.uk/


Proposals/information about the design has been published here:

Link: https://lore.kernel.org/lkml/24942.1573667720@warthog.procyon.org.uk/
Link: https://lore.kernel.org/linux-fsdevel/2758811.1610621106@warthog.procyon.org.uk/
Link: https://lore.kernel.org/linux-fsdevel/1441311.1598547738@warthog.procyon.org.uk/
Link: https://lore.kernel.org/linux-fsdevel/160655.1611012999@warthog.procyon.org.uk/

And requests for information:

Link: https://lore.kernel.org/linux-fsdevel/3326.1579019665@warthog.procyon.org.uk/
Link: https://lore.kernel.org/linux-fsdevel/4467.1579020509@warthog.procyon.org.uk/
Link: https://lore.kernel.org/linux-fsdevel/3577430.1579705075@warthog.procyon.org.uk/

The NFS parts, though not included here, have been tested by someone who's
using fscache in production:

Link: https://listman.redhat.com/archives/linux-cachefs/2020-December/msg00000.html

I've posted partial patches to try and help 9p and cifs along:

Link: https://lore.kernel.org/linux-fsdevel/1514086.1605697347@warthog.procyon.org.uk/
Link: https://lore.kernel.org/linux-cifs/1794123.1605713481@warthog.procyon.org.uk/
Link: https://lore.kernel.org/linux-fsdevel/241017.1612263863@warthog.procyon.org.uk/
Link: https://lore.kernel.org/linux-cifs/270998.1612265397@warthog.procyon.org.uk/

David
---
David Howells (27):
      iov_iter: Add ITER_XARRAY
      mm: Add an unlock function for PG_private_2/PG_fscache
      mm: Implement readahead_control pageset expansion
      vfs: Export rw_verify_area() for use by cachefiles
      netfs: Make a netfs helper module
      netfs, mm: Move PG_fscache helper funcs to linux/netfs.h
      netfs, mm: Add unlock_page_fscache() and wait_on_page_fscache()
      netfs: Provide readahead and readpage netfs helpers
      netfs: Add tracepoints
      netfs: Gather stats
      netfs: Add write_begin helper
      netfs: Define an interface to talk to a cache
      netfs: Hold a ref on a page when PG_private_2 is set
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

Jeff Layton (6):
      ceph: disable old fscache readpage handling
      ceph: rework PageFsCache handling
      ceph: fix fscache invalidation
      ceph: convert readpage to fscache read helper
      ceph: plug write_begin into read helper
      ceph: convert ceph_readpages to ceph_readahead


 fs/Kconfig                    |    1 +
 fs/Makefile                   |    1 +
 fs/afs/Kconfig                |    1 +
 fs/afs/dir.c                  |  225 ++++---
 fs/afs/file.c                 |  470 ++++---------
 fs/afs/fs_operation.c         |    4 +-
 fs/afs/fsclient.c             |  108 +--
 fs/afs/inode.c                |    7 +-
 fs/afs/internal.h             |   58 +-
 fs/afs/rxrpc.c                |  150 ++---
 fs/afs/write.c                |  610 +++++++++--------
 fs/afs/yfsclient.c            |   82 +--
 fs/cachefiles/Makefile        |    1 +
 fs/cachefiles/interface.c     |    5 +-
 fs/cachefiles/internal.h      |    9 +
 fs/cachefiles/rdwr2.c         |  412 ++++++++++++
 fs/ceph/Kconfig               |    1 +
 fs/ceph/addr.c                |  535 ++++++---------
 fs/ceph/cache.c               |  125 ----
 fs/ceph/cache.h               |  101 +--
 fs/ceph/caps.c                |   10 +-
 fs/ceph/inode.c               |    1 +
 fs/ceph/super.h               |    1 +
 fs/fscache/Kconfig            |    1 +
 fs/fscache/Makefile           |    3 +-
 fs/fscache/internal.h         |    3 +
 fs/fscache/page.c             |    2 +-
 fs/fscache/page2.c            |  117 ++++
 fs/fscache/stats.c            |    1 +
 fs/internal.h                 |    5 -
 fs/netfs/Kconfig              |   23 +
 fs/netfs/Makefile             |    5 +
 fs/netfs/internal.h           |   97 +++
 fs/netfs/read_helper.c        | 1169 +++++++++++++++++++++++++++++++++
 fs/netfs/stats.c              |   59 ++
 fs/read_write.c               |    1 +
 include/linux/fs.h            |    1 +
 include/linux/fscache-cache.h |    4 +
 include/linux/fscache.h       |   40 +-
 include/linux/netfs.h         |  195 ++++++
 include/linux/pagemap.h       |    3 +
 include/net/af_rxrpc.h        |    2 +-
 include/trace/events/afs.h    |   74 +--
 include/trace/events/netfs.h  |  201 ++++++
 mm/filemap.c                  |   20 +
 mm/readahead.c                |   70 ++
 net/rxrpc/recvmsg.c           |    9 +-
 47 files changed, 3473 insertions(+), 1550 deletions(-)
 create mode 100644 fs/cachefiles/rdwr2.c
 create mode 100644 fs/fscache/page2.c
 create mode 100644 fs/netfs/Kconfig
 create mode 100644 fs/netfs/Makefile
 create mode 100644 fs/netfs/internal.h
 create mode 100644 fs/netfs/read_helper.c
 create mode 100644 fs/netfs/stats.c
 create mode 100644 include/linux/netfs.h
 create mode 100644 include/trace/events/netfs.h


