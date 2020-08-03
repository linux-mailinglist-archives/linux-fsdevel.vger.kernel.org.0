Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D77623AA7C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 18:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgHCQao (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 12:30:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37658 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726548AbgHCQan (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596472241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=mr7qr56B9egsGx9uRGRfdmlNyRxpcMInU0RCYxVoelY=;
        b=digWS76W8mNjR4r9qA8BvBxIgw13ODHYUuZ08abXSviSXW4lr4bjMfcPhZSUpsgr1qzTEB
        UR2nwt2K0xUCB5tL5S6Ejxg258hhxQQj6v0JQCZxFNeYiTteMyJj9BM/Ba2IPHNqxIs0J0
        PsbvP6pG1OTL1nNFqVqf6rDenglsywM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-0ifzl7qlNXKlqZKNCDwn0w-1; Mon, 03 Aug 2020 12:30:33 -0400
X-MC-Unique: 0ifzl7qlNXKlqZKNCDwn0w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B87C81009600;
        Mon,  3 Aug 2020 16:30:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0CE927BDC;
        Mon,  3 Aug 2020 16:30:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fscache rewrite
References: <447452.1596109876@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1851199.1596472222.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 03 Aug 2020 17:30:22 +0100
Message-ID: <1851200.1596472222@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Here's a set of patches that massively overhauls fscache and cachefiles.
It improves the code by:

 (*) Ripping out the stuff that uses page cache snooping and kernel_write(=
)
     and using kiocb instead.  This gives multiple wins: uses async DIO
     rather than snooping for updated pages and then copying them, less VM
     overhead.

 (*) Object management is also simplified, getting rid of the state machin=
e
     that was managing things and using a much simplified thread pool
     instead.

 (*) Object invalidation creates a tmpfile and diverts new activity to tha=
t
     so that it doesn't have to synchronise in-flight ADIO.

 (*) Using a bitmap stored in an xattr rather than using bmap to find out =
if
     a block is present in the cache.

     Probing the backing filesystem's metadata to find out is not reliable
     in modern extent-based filesystems as them may insert or remove block=
s
     of zeros.  Even SEEK_HOLE/SEEK_DATA are problematic since they don't
     distinguish transparently-inserted bridging.

The patchset includes a read helper that handles ->readpage, ->readpages,
and preparatory writes in ->write_begin.  Matthew Wilcox is looking at
using this as a way to roll his new ->readahead op out into filesystems.  =
A
good chunk of this will move into MM code.

Note that this patchset does not include documentation changes yet.  I hav=
e
them (mostly) done, but they were based on the plain-text format that got
ReST-ified, and I haven't managed to get around to the conversion yet.  I
can create a follow-up patchset for that if this is taken.

Further note: There's a last minute change due to a bit of debugging code
that got left in mm/filemap.c that needed removing.

However, there are reasons you might not want to take it yet:

 (1) It starts off by disabling fscache support in all the filesystems tha=
t
     use it: afs, nfs, cifs, ceph and 9p.  I've taken care of afs, Dave
     Wysochanski has patches for nfs:

	https://lore.kernel.org/linux-nfs/1596031949-26793-1-git-send-email-dwyso=
cha@redhat.com/

     but Trond and Anna haven't said anything yet, and Jeff Layton has
     patches for ceph:

	https://marc.info/?l=3Dceph-devel&m=3D159541538914631&w=3D2

     and I've briefly discussed cifs with Steve, but nothing has started
     there yet.  9p I haven't looked at yet.

     Are we okay for going a kernel release with 4/5 filesystems with
     caching disabled and then pushing the changes for individual
     filesystems through their respective trees?  I floated this question
     last week, but have no replies either way.

 (2) The patched afs fs passed xfstests -g quick (unlike the upstream code
     that oopses pretty quickly with caching enabled).  Dave and Jeff's nf=
s
     and ceph code is getting close, but not quite there yet.

 (3) Al has objections to the ITER_MAPPING iov_iter type that I added

	https://lore.kernel.org/linux-fsdevel/20200719014436.GG2786714@ZenIV.linu=
x.org.uk/

     but note that iov_iter_for_each_range() is not actually used by anyth=
ing.

     However, Willy likes it and would prefer to make it ITER_XARRAY inste=
ad
     as he might be able to use it in other places, though there's an issu=
e
     where I'm calling find_get_pages_contig() which takes a mapping (thou=
gh
     all it does is then get the xarray out of it).  Willy has made
     suggestions as to how this may be achieved, but I haven't got round t=
o
     looking at them yet.

     Instead I would have to use ITER_BVEC, which has quite a high overhea=
d,
     though it would mean that the RCU read lock wouldn't be necessary.  T=
his
     would require 1K of memory for every 256K block the cache wants to re=
ad;
     for any read >1M, I'd have to use vmalloc() instead.

     I'd also prefer not to use ITER_BVEC because the offset and length ar=
e
     superfluous here.  If ITER_MAPPING is not good, would it be possible =
to
     have an ITER_PAGEARRAY that just takes a page array instead?  Or, eve=
n,
     create a transient xarray?

 (4) The way object culling is managed needs overhauling too, but that's a
     separate patchset in its own right.  We could wait till that's done
     too, but its lack doesn't prevent what we have now from being used.

David
---
The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c6=
8:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/fscache-iter-20200803

for you to fetch changes up to 2f716a79439b100a3ded54b828f9c87582d13f86:

  fscache: disable cookie when doing an invalidation for DIO write (2020-0=
8-03 17:22:36 +0100)

----------------------------------------------------------------
Filesystem caching rewrite

----------------------------------------------------------------
David Howells (59):
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
      iov_iter: Add ITER_MAPPING
      vm: Add wait/unlock functions for PG_fscache
      vfs: Export rw_verify_area() for use by cachefiles
      vfs: Provide S_CACHE_FILE inode flag
      mm: Provide lru_to_last_page() to get last of a page list
      cachefiles: Remove tree of active files and use S_CACHE_FILE inode f=
lag
      fscache: Provide a simple thread pool for running ops asynchronously
      fscache: Replace the object management state machine
      fscache: Rewrite the I/O API based on iov_iter
      fscache: Keep track of size of a file last set independently on the =
server
      fscache, cachefiles: Fix disabled histogram warnings
      fscache: Recast assertion in terms of cookie not being an index
      cachefiles: Remove some redundant checks on unsigned values
      cachefiles: trace: Log coherency checks
      cachefiles: Split cachefiles_drop_object() up a bit
      cachefiles: Implement new fscache I/O backend API
      cachefiles: Merge object->backer into object->dentry
      cachefiles: Implement a content-present indicator and bitmap
      cachefiles: Shape read requests
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
      afs: Fix interruption of operations
      afs: Move key to afs_read struct
      afs: Don't truncate iter during data fetch
      afs: Log remote unmarshalling errors
      afs: Set up the iov_iter before calling afs_extract_data()
      afs: Use ITER_MAPPING for writing
      afs: Interpose struct fscache_io_request into struct afs_read
      afs: Note the amount transferred in fetch-data delivery
      afs: Wait on PG_fscache before modifying/releasing a page
      afs: Use new fscache I/O API
      afs: Copy local writes to the cache when writing to the server
      afs: Invoke fscache_resize_cookie() when handling ATTR_SIZE for seta=
ttr
      afs: Add O_DIRECT read support
      afs: Skip truncation on the server of data we haven't written yet

Jeff Layton (1):
      fscache: disable cookie when doing an invalidation for DIO write

 fs/9p/Kconfig                          |    2 +-
 fs/Makefile                            |    2 +-
 fs/afs/Kconfig                         |    4 +-
 fs/afs/cache.c                         |   54 --
 fs/afs/cell.c                          |    9 +-
 fs/afs/dir.c                           |  242 +++++--
 fs/afs/file.c                          |  577 +++++++--------
 fs/afs/fs_operation.c                  |    4 +-
 fs/afs/fsclient.c                      |  154 ++--
 fs/afs/inode.c                         |  104 ++-
 fs/afs/internal.h                      |   58 +-
 fs/afs/rxrpc.c                         |  150 ++--
 fs/afs/volume.c                        |    9 +-
 fs/afs/write.c                         |  435 +++++++----
 fs/afs/yfsclient.c                     |  113 ++-
 fs/cachefiles/Makefile                 |    3 +-
 fs/cachefiles/bind.c                   |   11 +-
 fs/cachefiles/content-map.c            |  499 +++++++++++++
 fs/cachefiles/daemon.c                 |   10 +-
 fs/cachefiles/interface.c              |  580 ++++++++-------
 fs/cachefiles/internal.h               |  142 ++--
 fs/cachefiles/io.c                     |  325 +++++++++
 fs/cachefiles/main.c                   |   12 +-
 fs/cachefiles/namei.c                  |  508 +++++--------
 fs/cachefiles/rdwr.c                   |  974 -------------------------
 fs/cachefiles/xattr.c                  |  263 +++----
 fs/ceph/Kconfig                        |    2 +-
 fs/cifs/Kconfig                        |    2 +-
 fs/fscache/Kconfig                     |   24 +-
 fs/fscache/Makefile                    |   15 +-
 fs/fscache/cache.c                     |  145 ++--
 fs/fscache/cookie.c                    |  898 ++++++++++-------------
 fs/fscache/dispatcher.c                |  150 ++++
 fs/fscache/fsdef.c                     |   56 +-
 fs/fscache/histogram.c                 |    2 +-
 fs/fscache/internal.h                  |  264 +++----
 fs/fscache/io.c                        |  206 ++++++
 fs/fscache/main.c                      |   35 +-
 fs/fscache/netfs.c                     |   10 +-
 fs/fscache/obj.c                       |  366 ++++++++++
 fs/fscache/object-list.c               |  129 +---
 fs/fscache/object.c                    | 1133 ---------------------------=
--
 fs/fscache/object_bits.c               |  120 +++
 fs/fscache/operation.c                 |  633 ----------------
 fs/fscache/page.c                      | 1248 ---------------------------=
-----
 fs/fscache/proc.c                      |   13 +-
 fs/fscache/read_helper.c               |  701 ++++++++++++++++++
 fs/fscache/stats.c                     |  269 +++----
 fs/internal.h                          |    5 -
 fs/nfs/Kconfig                         |    2 +-
 fs/nfs/fscache-index.c                 |    4 +-
 fs/read_write.c                        |    1 +
 include/linux/fs.h                     |    2 +
 include/linux/fscache-cache.h          |  508 +++----------
 include/linux/fscache-obsolete.h       |   13 +
 include/linux/fscache.h                |  834 +++++++++------------
 include/linux/mm.h                     |    1 +
 include/linux/pagemap.h                |   14 +
 include/linux/uio.h                    |   11 +
 include/net/af_rxrpc.h                 |    2 +-
 include/trace/events/afs.h             |   51 +-
 include/trace/events/cachefiles.h      |  285 ++++++--
 include/trace/events/fscache.h         |  428 ++---------
 include/trace/events/fscache_support.h |   97 +++
 lib/iov_iter.c                         |  286 +++++++-
 mm/filemap.c                           |   18 +
 net/rxrpc/recvmsg.c                    |    9 +-
 67 files changed, 5941 insertions(+), 8295 deletions(-)
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

