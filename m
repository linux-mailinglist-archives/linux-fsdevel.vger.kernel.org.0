Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C788346C08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 23:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbhCWWSK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 18:18:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60489 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233790AbhCWWRk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616537859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sTQ4e/xAuzcUxTZmFIaQwY/w13lRQrA/qVwc/tZwtw4=;
        b=OJJm4Tc1gcDd8TZQdMZ0NP8WPF0ojtldG6EfLyMxvCkwxmA7UNa7WtPxvnab9VDsBT13WM
        8uSNZgcJa2ELm0Zk8kzNT9/iv2ZVsBt923Kh3pybbv72H8/2ZpEzZZ1NtBKWRcaqzD/GRT
        CYe7ljpc9PoiynEjD7gn+HCkqstlvjs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-yiMl_McaPYCpOJfY7FAqxQ-1; Tue, 23 Mar 2021 18:17:37 -0400
X-MC-Unique: yiMl_McaPYCpOJfY7FAqxQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 218461853022;
        Tue, 23 Mar 2021 22:17:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E0285DEAD;
        Tue, 23 Mar 2021 22:17:28 +0000 (UTC)
Subject: [PATCH v5 00/28] Network fs helper library & fscache kiocb API
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, ceph-devel@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        v9fs-developer@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        linux-cachefs@redhat.com, linux-nfs@vger.kernel.org,
        dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 23 Mar 2021 22:17:27 +0000
Message-ID: <161653784755.2770958.11820491619308713741.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

The patchset contains the following parts:

 (1) Some helper patches, including provision of an ITER_XARRAY iov
     iterator and a function to do readahead expansion.

 (2) Patches to add the netfs helper library.

 (3) A patch to add the fscache/cachefiles kiocb API.

 (4) Patches to add support in AFS for this.

Jeff Layton has patches to add support in Ceph for this.

Dave Wysochanski also has patches for NFS for this, though they're not
included on this branch as there's an issue with PNFS.

With this, AFS without a cache passes all expected xfstests; with a cache,
there's an extra failure, but that's also there before these patches.
Fixing that probably requires a greater overhaul.  Ceph and NFS also pass
the expected tests.

These patches can be found also on:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-netfs-lib


Changes
=======

ver #5:
      Fixed some review comments from Matthew Wilcox:

      - Put a comment into netfs_readahead() to indicate why there's a loop
        that puts, but doesn't unlock, "unconsumed" pages at the end when
        it could just return said pages to the caller to dispose of[6].
        (This is because where those pages are marked consumed).

      - Use the page_file_mapping() and page_index() helper functions
      	rather than accessing the page struct directly[6].

      - Better names for wrangling functions for PG_private_2 and
        PG_fscache wrangling functions[7].  Came up with
        {set,end,wait_for}_page_private_2() and aliased these for fscache.

      Moved the taking of/dropping a page ref for the PG_private_2 flag
      into the set and end functions.

ver #4:
      Fixed some review comments from Christoph Hellwig, including dropping
      the export of rw_verify_area()[3] and some minor stuff[4].

      Moved the declaration of readahead_expand() to a better location[5].

      Rebased to v5.12-rc2 and added a bunch of references into individual
      commits.

      Dropped Ceph support - that will go through the maintainer's tree.

      Added interface documentation for the netfs helper library.

ver #3:
      Rolled in the bug fixes.

      Adjusted the functions that unlock and wait for PG_fscache according
      to Linus's suggestion[1].

      Hold a ref on a page when PG_fscache is set as per Linus's
      suggestion[2].

      Dropped NFS support and added Ceph support.

ver #2:
      Fixed some bugs and added NFS support.

Link: https://lore.kernel.org/r/CAHk-=wh+2gbF7XEjYc=HV9w_2uVzVf7vs60BPz0gFA=+pUm3ww@mail.gmail.com/ [1]
Link: https://lore.kernel.org/r/CAHk-=wjgA-74ddehziVk=XAEMTKswPu1Yw4uaro1R3ibs27ztw@mail.gmail.com/ [2]
Link: https://lore.kernel.org/r/20210216102614.GA27555@lst.de/ [3]
Link: https://lore.kernel.org/r/20210216084230.GA23669@lst.de/ [4]
Link: https://lore.kernel.org/r/20210217161358.GM2858050@casper.infradead.org/ [5]
Link: https://lore.kernel.org/r/20210321014202.GF3420@casper.infradead.org/ [6]
Link: https://lore.kernel.org/r/20210321105309.GG3420@casper.infradead.org/ [7]

References
==========

These patches have been published for review before, firstly as part of a
larger set:

Link: https://lore.kernel.org/r/158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk/

Link: https://lore.kernel.org/r/159465766378.1376105.11619976251039287525.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/159465821598.1377938.2046362270225008168.stgit@warthog.procyon.org.uk/

Link: https://lore.kernel.org/r/160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk/

Then as a cut-down set:

Link: https://lore.kernel.org/r/161118128472.1232039.11746799833066425131.stgit@warthog.procyon.org.uk/ # v1

Link: https://lore.kernel.org/r/161161025063.2537118.2009249444682241405.stgit@warthog.procyon.org.uk/ # v2

Link: https://lore.kernel.org/r/161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk/ # v3

Link: https://lore.kernel.org/r/161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk/ # v4

Proposals/information about the design has been published here:

Link: https://lore.kernel.org/r/24942.1573667720@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/2758811.1610621106@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/1441311.1598547738@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/160655.1611012999@warthog.procyon.org.uk/

And requests for information:

Link: https://lore.kernel.org/r/3326.1579019665@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/4467.1579020509@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/3577430.1579705075@warthog.procyon.org.uk/

The NFS parts, though not included here, have been tested by someone who's
using fscache in production:

Link: https://listman.redhat.com/archives/linux-cachefs/2020-December/msg00000.html

I've posted partial patches to try and help 9p and cifs along:

Link: https://lore.kernel.org/r/1514086.1605697347@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/1794123.1605713481@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/241017.1612263863@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/270998.1612265397@warthog.procyon.org.uk/

David
---
David Howells (28):
      iov_iter: Add ITER_XARRAY
      mm: Add wait_on_page_writeback_killable()
      mm: Add set/end/wait functions for PG_private_2
      mm: Implement readahead_control pageset expansion
      netfs: Make a netfs helper module
      netfs: Documentation for helper library
      netfs, mm: Move PG_fscache helper funcs to linux/netfs.h
      netfs, mm: Add set/end/wait_on_page_fscache() aliases
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
      afs: Use the fscache_write_begin() helper


 Documentation/filesystems/index.rst         |    1 +
 Documentation/filesystems/netfs_library.rst |  526 +++++++++
 fs/Kconfig                                  |    1 +
 fs/Makefile                                 |    1 +
 fs/afs/Kconfig                              |    1 +
 fs/afs/dir.c                                |  225 ++--
 fs/afs/file.c                               |  483 ++------
 fs/afs/fs_operation.c                       |    4 +-
 fs/afs/fsclient.c                           |  108 +-
 fs/afs/inode.c                              |    7 +-
 fs/afs/internal.h                           |   59 +-
 fs/afs/rxrpc.c                              |  150 +--
 fs/afs/write.c                              |  659 +++++------
 fs/afs/yfsclient.c                          |   82 +-
 fs/cachefiles/Makefile                      |    1 +
 fs/cachefiles/interface.c                   |    5 +-
 fs/cachefiles/internal.h                    |    9 +
 fs/cachefiles/io.c                          |  403 +++++++
 fs/fscache/Kconfig                          |    1 +
 fs/fscache/Makefile                         |    1 +
 fs/fscache/internal.h                       |    4 +
 fs/fscache/io.c                             |  116 ++
 fs/fscache/page.c                           |    2 +-
 fs/fscache/stats.c                          |    1 +
 fs/netfs/Kconfig                            |   23 +
 fs/netfs/Makefile                           |    5 +
 fs/netfs/internal.h                         |   97 ++
 fs/netfs/read_helper.c                      | 1180 +++++++++++++++++++
 fs/netfs/stats.c                            |   59 +
 include/linux/fscache-cache.h               |    4 +
 include/linux/fscache.h                     |   50 +-
 include/linux/netfs.h                       |  228 ++++
 include/linux/pagemap.h                     |   22 +
 include/net/af_rxrpc.h                      |    2 +-
 include/trace/events/afs.h                  |   74 +-
 include/trace/events/netfs.h                |  201 ++++
 mm/filemap.c                                |   59 +
 mm/page-writeback.c                         |   25 +
 mm/readahead.c                              |   70 ++
 net/rxrpc/recvmsg.c                         |    9 +-
 40 files changed, 3888 insertions(+), 1070 deletions(-)
 create mode 100644 Documentation/filesystems/netfs_library.rst
 create mode 100644 fs/cachefiles/io.c
 create mode 100644 fs/fscache/io.c
 create mode 100644 fs/netfs/Kconfig
 create mode 100644 fs/netfs/Makefile
 create mode 100644 fs/netfs/internal.h
 create mode 100644 fs/netfs/read_helper.c
 create mode 100644 fs/netfs/stats.c
 create mode 100644 include/linux/netfs.h
 create mode 100644 include/trace/events/netfs.h


