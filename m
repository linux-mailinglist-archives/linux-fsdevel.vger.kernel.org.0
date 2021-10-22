Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B601B437CDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 20:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbhJVTBO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 15:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54922 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232411AbhJVTBN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634929135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZMGLfGhTZyg2hCXUGNR5TokdI2tToWsrzMC3UDrJ/Vk=;
        b=Y9jFbRr7o4mfY/sdFWqo91CZsrwWgNJ2lH0KDyzPZ3XP5IkxO4MVdtxVqbfvxQxtxGyZc8
        N7933HEBlhNyosF3ANkYM4Q4GKMYMZqBt0hbKhUJ2S8Ux+CO/fN0IaYNM/SAO85pwkNBBd
        vG0x2FDMAcUNYSBf/UD1cU1TOsypZqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-t5eBudGvNt6zcINrTtdsVw-1; Fri, 22 Oct 2021 14:58:51 -0400
X-MC-Unique: t5eBudGvNt6zcINrTtdsVw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBBDE1005E4D;
        Fri, 22 Oct 2021 18:58:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73C871346F;
        Fri, 22 Oct 2021 18:58:40 +0000 (UTC)
Subject: [PATCH v2 00/53] fscache: Rewrite index API and management system
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     linux-afs@lists.infradead.org,
        Marc Dionne <marc.dionne@auristor.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-cifs@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>,
        Steve French <sfrench@samba.org>,
        Matthew Wilcox <willy@infradead.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, Latchesar Ionkov <lucho@ionkov.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Oct 2021 19:58:39 +0100
Message-ID: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a set of patches implements a rewrite of the fscache driver,
significantly simplifying the code compared to what's upstream, removing
the complex operation scheduling and object state machine in favour of
something much smaller and simpler.  It is built on top of the set of
patches that removes the old API[1].

[!] Note: I've reworked the patches at Jeff Layton's request so that the
    old fscache and cachefiles drivers are moved aside, but retained, and
    the new drivers are built up from empty directories.  I've made it so
    that the end result is practically the same and can be directly diff'd
    against the first version.

    This allows the filesystems to retain access to the old drivers for the
    moment, though you have to decide at configuration time whether you
    want the old drivers or the new.

    The git branch mentioned below also contains a patch to remove the old
    drivers (and disable ceph as that's the only one I don't have patches
    for the conversion of - Jeff is working on that).


The operation scheduling API was intended to handle sequencing of cache
operations, which were all required (where possible) to run asynchronously
in parallel with the operations being done by the network filesystem, while
allowing the cache to be brought online and offline and interrupt service
with invalidation.

However, with the advent of the tmpfile capacity in the VFS, an opportunity
arises to do invalidation much more easily, without having to wait for I/O
that's actually in progress: Cachefiles can simply cut over its file
pointer for the backing object attached to a cookie and abandon the
in-progress I/O, dismissing it upon completion.

Future work there would involve using Omar Sandoval's vfs_link() with
AT_LINK_REPLACE[2] to allow an extant file to be displaced by a new hard
link from a tmpfile as currently I have to unlink the old file first.

These patches can also simplify the object state handling as I/O operations
to the cache don't all have to be brought to a stop in order to invalidate
a file.  To that end, and with an eye on to writing a new backing cache
model in the future, I've taken the opportunity to simplify the indexing
structure.

I've separated the index cookie concept from the file cookie concept by
type now.  The former is now called a "volume cookie" (struct
fscache_volume) and there is a container of file cookies.  There are then
just the two levels.  All the index cookieage is collapsed into a single
volume cookie, and this has a single printable string as a key.  For
instance, an AFS volume would have a key of something like
"afs,example.com,1000555", combining the filesystem name, cell name and
volume ID.  This is freeform, but must not have '/' chars in it.

I've also eliminated all pointers back from fscache into the network
filesystem.  This required the duplication of a little bit of data in the
cookie (cookie key, coherency data and file size), but it's not actually
that much.  This gets rid of problems with making sure we keep netfs data
structures around so that the cache can access them.

I have changed afs throughout the patch series, but I also have patches for
9p, nfs and cifs.  Jeff Layton is handling ceph support.


BITS THAT MAY BE CONTROVERSIAL
==============================

There are some bits I've added that may be controversial:

 (1) I've provided a flag, S_KERNEL_FILE, that cachefiles uses to check if
     a files is already being used by some other kernel service (e.g. a
     duplicate cachefiles cache in the same directory) and reject it if it
     is.  This isn't entirely necessary, but it helps prevent accidental
     data corruption.

     I don't want to use S_SWAPFILE as that has other effects, but quite
     possibly swapon() should set S_KERNEL_FILE too.

     Note that it doesn't prevent userspace from interfering, though
     perhaps it should.

 (2) Cachefiles wants to keep the backing file for a cookie open whilst we
     might need to write to it from network filesystem writeback.  The
     problem is that the network filesystem unuses its cookie when its file
     is closed, and so we have nothing pinning the cachefiles file open and
     it will get closed automatically after a short time to avoid
     EMFILE/ENFILE problems.

     Reopening the cache file, however, is a problem if this is being done
     due to writeback triggered by exit().  Some filesystems will oops if
     we try to open a file in that context because they want to access
     current->fs or suchlike.

     To get around this, I added the following:

     (A) An inode flag, I_PINNING_FSCACHE_WB, to be set on a network
     	 filesystem inode to indicate that we have a usage count on the
     	 cookie caching that inode.

     (B) A flag in struct writeback_control, unpinned_fscache_wb, that is
     	 set when __writeback_single_inode() clears the last dirty page
     	 from i_pages - at which point it clears I_PINNING_FSCACHE_WB and
     	 sets this flag.

	 This has to be done here so that clearing I_PINNING_FSCACHE_WB can
	 be done atomically with the check of PAGECACHE_TAG_DIRTY that
	 clears I_DIRTY_PAGES.

     (C) A function, fscache_set_page_dirty(), which if it is not set, sets
     	 I_PINNING_FSCACHE_WB and calls fscache_use_cookie() to pin the
     	 cache resources.

     (D) A function, fscache_unpin_writeback(), to be called by
     	 ->write_inode() to unuse the cookie.

     (E) A function, fscache_clear_inode_writeback(), to be called when the
     	 inode is evicted, before clear_inode() is called.  This cleans up
     	 any lingering I_PINNING_FSCACHE_WB.

     The network filesystem can then use these tools to make sure that
     fscache_write_to_cache() can write locally modified data to the cache
     as well as to the server.

     For the future, I'm working on write helpers for netfs lib that should
     allow this facility to be removed by keeping track of the dirty
     regions separately - but that's incomplete at the moment and is also
     going to be affected by folios, one way or another, since it deals
     with pages.


Changes
=======
ver #2)
  - Fix fscache_unuse_cookie() to use atomic_dec_and_lock() to avoid a
    potential race.
  - Fix a number of oopses due to the cache not withdrawing the object by
    the correct procedure upon lookup failure.
  - Disable a debugging statement.


These patches can be found also on:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-rewrite-indexing-2

David

Link: https://lore.kernel.org/r/163363935000.1980952.15279841414072653108.stgit@warthog.procyon.org.uk/ [1]
Link: https://lore.kernel.org/r/cover.1580251857.git.osandov@fb.com/ [2]
Link: https://lore.kernel.org/r/163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk/ # v1

---
Dave Wysochanski (1):
      nfs: Convert to new fscache volume/cookie API

David Howells (52):
      fscache_old: Move the old fscache driver to one side
      fscache_old: Rename CONFIG_FSCACHE* to CONFIG_FSCACHE_OLD*
      cachefiles_old:  Move the old cachefiles driver to one side
      cachefiles_old: Rename CONFIG_CACHEFILES* to CONFIG_CACHEFILES_OLD*
      netfs: Display the netfs inode number in the netfs_read tracepoint
      netfs: Pass a flag to ->prepare_write() to say if there's no alloc'd space
      fscache: Introduce new driver
      fscache: Implement a hash function
      fscache: Implement cache registration
      fscache: Implement volume registration
      fscache: Implement cookie registration
      fscache: Implement cache-level access helpers
      fscache: Implement volume-level access helpers
      fscache: Implement cookie-level access helpers
      fscache: Implement functions add/remove a cache
      fscache: Provide and use cache methods to lookup/create/free a volume
      fscache: Add a function for a cache backend to note an I/O error
      fscache: Implement simple cookie state machine
      fscache: Implement cookie user counting and resource pinning
      fscache: Implement cookie invalidation
      fscache: Provide a means to begin an operation
      fscache: Provide read/write stat counters for the cache
      fscache: Provide a function to let the netfs update its coherency data
      fscache: Implement I/O interface
      fscache: Provide fallback I/O functions
      vfs, fscache: Implement pinning of cache usage for writeback
      fscache: Provide a function to note the release of a page
      fscache: Provide a function to resize a cookie
      cachefiles: Introduce new driver
      cachefiles: Add some error injection support
      cachefiles: Define structs
      cachefiles: Add a couple of tracepoints for logging errors
      cachefiles: Add I/O error reporting macros
      cachefiles: Provide a function to check how much space there is
      cachefiles: Implement a function to get/create a directory in the cache
      cachefiles: Implement daemon UAPI and cache registration
      cachefiles: Implement volume support
      cachefiles: Implement data storage object handling
      cachefiles: Implement begin and end I/O
      cachefiles: Implement the I/O routines
      afs: Handle len being extending over page end in write_begin/write_end
      afs: Fix afs_write_end() to handle len > page size
      afs: Make afs_write_begin() return the THP subpage
      afs: Convert afs to use the new fscache API
      afs: Copy local writes to the cache when writing to the server
      afs: Skip truncation on the server of data we haven't written yet
      afs: Add synchronous O_DIRECT support
      9p: Use fscache indexing rewrite and reenable caching
      9p: Copy local writes to the cache when writing to the server
      cifs: Support fscache indexing rewrite (untested)
      fscache, cachefiles: Display stats of no-space events
      fscache, cachefiles: Display stat of culling events


 fs/9p/cache.c                         |  184 +----
 fs/9p/cache.h                         |   25 +-
 fs/9p/v9fs.c                          |   14 +-
 fs/9p/v9fs.h                          |   13 +-
 fs/9p/vfs_addr.c                      |   55 +-
 fs/9p/vfs_dir.c                       |   11 +
 fs/9p/vfs_file.c                      |    7 +-
 fs/9p/vfs_inode.c                     |   24 +-
 fs/9p/vfs_inode_dotl.c                |    3 +-
 fs/9p/vfs_super.c                     |    3 +
 fs/Kconfig                            |    4 +-
 fs/Makefile                           |    4 +-
 fs/afs/Makefile                       |    3 -
 fs/afs/cache.c                        |   68 --
 fs/afs/cell.c                         |   12 -
 fs/afs/file.c                         |   83 +-
 fs/afs/fsclient.c                     |    2 +-
 fs/afs/inode.c                        |  101 ++-
 fs/afs/internal.h                     |   37 +-
 fs/afs/main.c                         |   14 -
 fs/afs/super.c                        |    1 +
 fs/afs/volume.c                       |   15 +-
 fs/afs/write.c                        |  170 ++++-
 fs/cachefiles/Kconfig                 |    7 +
 fs/cachefiles/Makefile                |    3 +
 fs/cachefiles/bind.c                  |  190 +++--
 fs/cachefiles/daemon.c                |   40 +-
 fs/cachefiles/error_inject.c          |   46 ++
 fs/cachefiles/interface.c             |  662 +++++++---------
 fs/cachefiles/internal.h              |  203 +++--
 fs/cachefiles/io.c                    |  315 +++++---
 fs/cachefiles/key.c                   |  205 +++--
 fs/cachefiles/main.c                  |   22 +-
 fs/cachefiles/namei.c                 |  983 ++++++++++--------------
 fs/cachefiles/security.c              |    2 +-
 fs/cachefiles/volume.c                |  128 ++++
 fs/cachefiles/xattr.c                 |  369 +++------
 fs/cachefiles_old/Kconfig             |   25 +
 fs/cachefiles_old/Makefile            |   17 +
 fs/cachefiles_old/bind.c              |  278 +++++++
 fs/cachefiles_old/daemon.c            |  748 ++++++++++++++++++
 fs/cachefiles_old/interface.c         |  557 ++++++++++++++
 fs/cachefiles_old/internal.h          |  312 ++++++++
 fs/cachefiles_old/io.c                |  446 +++++++++++
 fs/cachefiles_old/key.c               |  155 ++++
 fs/cachefiles_old/main.c              |   94 +++
 fs/cachefiles_old/namei.c             | 1018 +++++++++++++++++++++++++
 fs/cachefiles_old/security.c          |  112 +++
 fs/cachefiles_old/xattr.c             |  324 ++++++++
 fs/ceph/Kconfig                       |    2 +-
 fs/cifs/Makefile                      |    2 +-
 fs/cifs/cache.c                       |  105 ---
 fs/cifs/cifsfs.c                      |   11 +-
 fs/cifs/cifsglob.h                    |    5 +-
 fs/cifs/connect.c                     |    3 -
 fs/cifs/file.c                        |   37 +-
 fs/cifs/fscache.c                     |  201 ++---
 fs/cifs/fscache.h                     |   53 +-
 fs/cifs/inode.c                       |   18 +-
 fs/fs-writeback.c                     |    8 +
 fs/fscache/Kconfig                    |   40 +
 fs/fscache/Makefile                   |   16 +
 fs/fscache/cache.c                    |  353 +++++++++
 fs/fscache/cookie.c                   |  990 ++++++++++++++++++++++++
 fs/fscache/internal.h                 |  249 ++++++
 fs/fscache/io.c                       |  381 +++++++++
 fs/fscache/main.c                     |  120 +++
 fs/fscache/proc.c                     |   54 ++
 fs/fscache/stats.c                    |  106 +++
 fs/fscache/volume.c                   |  449 +++++++++++
 fs/fscache_old/Kconfig                |   16 +-
 fs/fscache_old/Makefile               |    4 +-
 fs/fscache_old/internal.h             |    4 +-
 fs/fscache_old/object.c               |    2 +-
 fs/fscache_old/proc.c                 |   12 +-
 fs/netfs/read_helper.c                |    2 +-
 fs/nfs/Makefile                       |    2 +-
 fs/nfs/client.c                       |    4 -
 fs/nfs/direct.c                       |    2 +
 fs/nfs/file.c                         |    7 +-
 fs/nfs/fscache-index.c                |  114 ---
 fs/nfs/fscache.c                      |  264 +++----
 fs/nfs/fscache.h                      |   91 +--
 fs/nfs/inode.c                        |   11 +-
 fs/nfs/super.c                        |    7 +-
 fs/nfs/write.c                        |    1 +
 include/linux/fs.h                    |    4 +
 include/linux/fscache-cache.h         |  199 +++++
 include/linux/fscache.h               |  680 +++++++++++++++++
 include/linux/fscache_old.h           |    1 +
 include/linux/netfs.h                 |    4 +-
 include/linux/nfs_fs_sb.h             |    9 +-
 include/linux/writeback.h             |    1 +
 include/trace/events/cachefiles.h     |  485 +++++++++---
 include/trace/events/cachefiles_old.h |  321 ++++++++
 include/trace/events/fscache.h        |  448 +++++++++++
 include/trace/events/netfs.h          |    5 +-
 97 files changed, 11269 insertions(+), 2748 deletions(-)
 delete mode 100644 fs/afs/cache.c
 create mode 100644 fs/cachefiles/error_inject.c
 create mode 100644 fs/cachefiles/volume.c
 create mode 100644 fs/cachefiles_old/Kconfig
 create mode 100644 fs/cachefiles_old/Makefile
 create mode 100644 fs/cachefiles_old/bind.c
 create mode 100644 fs/cachefiles_old/daemon.c
 create mode 100644 fs/cachefiles_old/interface.c
 create mode 100644 fs/cachefiles_old/internal.h
 create mode 100644 fs/cachefiles_old/io.c
 create mode 100644 fs/cachefiles_old/key.c
 create mode 100644 fs/cachefiles_old/main.c
 create mode 100644 fs/cachefiles_old/namei.c
 create mode 100644 fs/cachefiles_old/security.c
 create mode 100644 fs/cachefiles_old/xattr.c
 delete mode 100644 fs/cifs/cache.c
 create mode 100644 fs/fscache/Kconfig
 create mode 100644 fs/fscache/Makefile
 create mode 100644 fs/fscache/cache.c
 create mode 100644 fs/fscache/cookie.c
 create mode 100644 fs/fscache/internal.h
 create mode 100644 fs/fscache/io.c
 create mode 100644 fs/fscache/main.c
 create mode 100644 fs/fscache/proc.c
 create mode 100644 fs/fscache/stats.c
 create mode 100644 fs/fscache/volume.c
 delete mode 100644 fs/nfs/fscache-index.c
 create mode 100644 include/linux/fscache-cache.h
 create mode 100644 include/linux/fscache.h
 create mode 100644 include/trace/events/cachefiles_old.h
 create mode 100644 include/trace/events/fscache.h


