Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394B131537A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 17:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbhBIQLq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 11:11:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49897 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232692AbhBIQLh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612887010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=akGVKWR6XgOFReDZRfWVmsLFvJtRrgKMTMbz030iBEY=;
        b=ZHPVlWFy9MMW/pwt+hxCjtO26f6FTtxzif0+REmGCqF6njMUcEyMqxf/mUhP1PrVcI8vrh
        7VWFRLXVh8Ud0Slh5RjE2qQFayyCeb5g8avMPz9W1S7sx9wd1OZQpZrHa+AkIaiI63O/HK
        IQKb3QZ55OAmgw8C4f2zZCp6XPWhaOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-D-UxzCEtMSabQA39JWulEA-1; Tue, 09 Feb 2021 11:10:08 -0500
X-MC-Unique: D-UxzCEtMSabQA39JWulEA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85F7980364E;
        Tue,  9 Feb 2021 16:10:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98BD010016F6;
        Tue,  9 Feb 2021 16:09:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cachefs@redhat.com, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fscache: I/O API modernisation and netfs helper library
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <591236.1612886997.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 09 Feb 2021 16:09:57 +0000
Message-ID: <591237.1612886997@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Can you pull this during the upcoming merge window?  It provides a more
modern I/O API for fscache and moves some common pieces out of network
filesystems into a common helper library.  This request only includes
modifications for afs and ceph.

Dave Wysochanski has a patch series for nfs.  Normal nfs works fine and
passes various tests, but it turned out pnfs has a problem that wasn't
discovered until quite late - pnfs does splitting of requests itself and
sending them to various places, but it will need to cooperate more closely
with the netfs lib over this.

I've given Dominique Martinet a patch for 9p and Steve French a partial
patch for cifs, but neither of those is going to be ready for this merge
window.

The main features of this request are:

 (1) Institution of a helper library for network filesystems.  The first
     phase of this handles ->readpage(), ->readahead() and part of
     ->write_begin() on behalf of the netfs, requiring the netfs to provid=
e
     a common vector to perform a read to some part of a file.

     This allows handling of the following to be (at least partially) move=
d
     out of all the network filesystems and consolidated in one place:

	- changes in VM vectors (Matthew Wilcox's work)
	  - transparent huge page support
	- shaping of reads
	  - readahead expansion
	  - fs alignment/granularity (ceph, pnfs)
	  - cache alignment/granularity
	- slicing of reads
	  - rsize
	  - keeping multiple read in flight	} Steve French would like
	  - multichannel distribution		} but for the future
	  - multiserver distribution (ceph, pnfs)
	  - stitching together reads from the cache and reads from the net
	- copying data read from the server into the cache
	- retry/reissue handling
	  - fallback after cache failure
     	- short reads
	- fscrypt data crypting (Jeff Layton is considering for the future)

 (2) Adding an alternate cache I/O API for use with the netfs lib that
     makes use of kiocbs in the cache to do direct I/O between the cache
     files and the netfs pages.

     This is intended to replace the current I/O API that calls the backin=
g
     fs readpage op and than snooping the wait queues for completion to
     read and using vfs_write() to write.  It wasn't possible to do
     in-kernel DIO when I first wrote cachefiles - but using kiocbs makes
     it a lot simpler and more robust (and it uses a lot less memory).

 (3) Add an ITER_XARRAY iov_iter that allows I/O iteration to be done on a=
n
     xarray of pinned pages (such as inode->i_mapping->i_pages), thereby
     avoiding the need to allocate a bvec array to represent this.

     This is used to present a set of netfs pages to the cache to do DIO o=
n
     and is also used by afs to present netfs pages to sendmsg.  It could
     also be used by unencrypted cifs to pass the pages to the TCP socket
     it uses (if it's doing TCP) and my patch for 9p (which isn't included
     here) can make use of it too.

 (4) Make afs use the above.  It passes the same xfstests (and has the sam=
e
     failures) as the unpatched afs client.

 (5) Make ceph use the above (I've merged a branch from Jeff Layton for th=
is).
     This also passes xfstests.

David
---
The following changes since commit 9791581c049c10929e97098374dd1716a81fefc=
c:

  Merge tag 'for-5.11-rc4-tag' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/kdave/linux (2021-01-20 14:15:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/fscache-ioapi-20210203

for you to fetch changes up to 1df6bf2cc0fad1a5b2b32b7b0066b13175ad1ce4:

  netfs: Fix kerneldoc on netfs_subreq_terminated() (2021-02-03 11:17:57 +=
0000)

----------------------------------------------------------------
fscache I/O API rework and netfs changes

----------------------------------------------------------------
David Howells (29):
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
      fscache, cachefiles: Add alternate API to use kiocb for read/write t=
o cache
      afs: Disable use of the fscache I/O routines
      afs: Pass page into dirty region helpers to provide THP size
      afs: Print the operation debug_id when logging an unexpected data ve=
rsion
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
      Merge branch 'fscache-netfs-lib' into fscache-next
      Merge branch 'ceph-netfs-lib' of https://git.kernel.org/pub/scm/linu=
x/kernel/git/jlayton/linux into fscache-next
      netfs: Fix various bits of error handling
      afs: Fix error handling in afs_req_issue_op()
      netfs: Fix kerneldoc on netfs_subreq_terminated()

Jeff Layton (7):
      ceph: disable old fscache readpage handling
      ceph: rework PageFsCache handling
      ceph: fix fscache invalidation
      ceph: convert readpage to fscache read helper
      ceph: plug write_begin into read helper
      ceph: convert ceph_readpages to ceph_readahead
      ceph: fix an oops in error handling in ceph_netfs_issue_op

 fs/Kconfig                    |    1 +
 fs/Makefile                   |    1 +
 fs/afs/Kconfig                |    1 +
 fs/afs/dir.c                  |  225 +++++---
 fs/afs/file.c                 |  470 ++++-------------
 fs/afs/fs_operation.c         |    4 +-
 fs/afs/fsclient.c             |  108 ++--
 fs/afs/inode.c                |    7 +-
 fs/afs/internal.h             |   58 +-
 fs/afs/rxrpc.c                |  150 ++----
 fs/afs/write.c                |  610 ++++++++++++----------
 fs/afs/yfsclient.c            |   82 +--
 fs/cachefiles/Makefile        |    1 +
 fs/cachefiles/interface.c     |    5 +-
 fs/cachefiles/internal.h      |    9 +
 fs/cachefiles/rdwr2.c         |  412 +++++++++++++++
 fs/ceph/Kconfig               |    1 +
 fs/ceph/addr.c                |  535 ++++++++-----------
 fs/ceph/cache.c               |  125 -----
 fs/ceph/cache.h               |  101 +---
 fs/ceph/caps.c                |   10 +-
 fs/ceph/inode.c               |    1 +
 fs/ceph/super.h               |    1 +
 fs/fscache/Kconfig            |    1 +
 fs/fscache/Makefile           |    3 +-
 fs/fscache/internal.h         |    3 +
 fs/fscache/page.c             |    2 +-
 fs/fscache/page2.c            |  117 +++++
 fs/fscache/stats.c            |    1 +
 fs/internal.h                 |    5 -
 fs/netfs/Kconfig              |   23 +
 fs/netfs/Makefile             |    5 +
 fs/netfs/internal.h           |   97 ++++
 fs/netfs/read_helper.c        | 1161 ++++++++++++++++++++++++++++++++++++=
+++++
 fs/netfs/stats.c              |   59 +++
 fs/read_write.c               |    1 +
 include/linux/fs.h            |    1 +
 include/linux/fscache-cache.h |    4 +
 include/linux/fscache.h       |   40 +-
 include/linux/netfs.h         |  167 ++++++
 include/linux/pagemap.h       |   16 +
 include/linux/uio.h           |   11 +
 include/net/af_rxrpc.h        |    2 +-
 include/trace/events/afs.h    |   74 ++-
 include/trace/events/netfs.h  |  201 +++++++
 lib/iov_iter.c                |  313 ++++++++++-
 mm/filemap.c                  |   18 +
 mm/readahead.c                |   70 +++
 net/rxrpc/recvmsg.c           |    9 +-
 49 files changed, 3749 insertions(+), 1573 deletions(-)
 create mode 100644 fs/cachefiles/rdwr2.c
 create mode 100644 fs/fscache/page2.c
 create mode 100644 fs/netfs/Kconfig
 create mode 100644 fs/netfs/Makefile
 create mode 100644 fs/netfs/internal.h
 create mode 100644 fs/netfs/read_helper.c
 create mode 100644 fs/netfs/stats.c
 create mode 100644 include/linux/netfs.h
 create mode 100644 include/trace/events/netfs.h

