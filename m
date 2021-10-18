Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71D443202D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 16:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhJROwo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 10:52:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59936 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232120AbhJROwn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634568631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fTrNJzajY75aEFgr0IJAERmH1kp8ApEHhoqq1c9QWjk=;
        b=hK5ITbgmAFYVFlH01DXUCaKrr0h7a5xOEYD9AOV3ZBehrOSaeekj1KGtJun5H4SodTLJXl
        wxlnJO80ZLjWFB7m+UxGzUFhEBGwQvS1M1luLOk6+fTi/2k0i31xSlIPimelEqislGnke/
        b0DINVsjInPlPXkV4ju7ACA4Rz8cWKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-PW9s4UWuPtah2KXKgvmwwA-1; Mon, 18 Oct 2021 10:50:30 -0400
X-MC-Unique: PW9s4UWuPtah2KXKgvmwwA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5D1180A5C4;
        Mon, 18 Oct 2021 14:50:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7E005F4F5;
        Mon, 18 Oct 2021 14:50:16 +0000 (UTC)
Subject: [PATCH 00/67] fscache: Rewrite index API and management system
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Dave Wysochanski <dwysocha@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        v9fs-developer@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        Latchesar Ionkov <lucho@ionkov.net>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dominique Martinet <asmadeus@codewreck.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>, dhowells@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Oct 2021 15:50:15 +0100
Message-ID: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a set of patches that rewrites and simplifies the fscache index API
to remove the complex operation scheduling and object state machine in
favour of something much smaller and simpler.  It is built on top of the
set of patches that removes the old API[1].

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


These patches can be found also on:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-rewrite-indexing

David

Link: https://lore.kernel.org/r/163363935000.1980952.15279841414072653108.stgit@warthog.procyon.org.uk [1]
Link: https://lore.kernel.org/r/cover.1580251857.git.osandov@fb.com/ [2]

---
Dave Wysochanski (3):
      NFS: Convert fscache_acquire_cookie and fscache_relinquish_cookie
      NFS: Convert fscache_enable_cookie and fscache_disable_cookie
      NFS: Convert fscache invalidation and update aux_data and i_size

David Howells (63):
      mm: Stop filemap_read() from grabbing a superfluous page
      vfs: Provide S_KERNEL_FILE inode flag
      vfs, fscache: Force ->write_inode() to occur if cookie pinned for writeback
      afs: Handle len being extending over page end in write_begin/write_end
      afs: Fix afs_write_end() to handle len > page size
      nfs, cifs, ceph, 9p: Disable use of fscache prior to its rewrite
      fscache: Remove the netfs data from the cookie
      fscache: Remove struct fscache_cookie_def
      fscache: Remove store_limit* from struct fscache_object
      fscache: Remove fscache_check_consistency()
      fscache: Remove fscache_attr_changed()
      fscache: Remove obsolete stats
      fscache: Remove old I/O tracepoints
      fscache: Temporarily disable fscache_invalidate()
      fscache: Disable fscache_begin_operation()
      fscache: Remove the I/O operation manager
      fscache: Rename fscache_cookie_{get,put,see}()
      cachefiles: Remove tree of active files and use S_CACHE_FILE inode flag
      cachefiles: Don't set an xattr on the root of the cache
      cachefiles: Remove some redundant checks on unsigned values
      cachefiles: Prevent inode from going away when burying a dentry
      cachefiles: Simplify the pathwalk and save the filename for an object
      cachefiles: trace: Improve the lookup tracepoint
      cachefiles: Remove separate backer dentry from cachefiles_object
      cachefiles: Fold fscache_object into cachefiles_object
      cachefiles: Change to storing file* rather than dentry*
      cachefiles: trace: Log coherency checks
      cachefiles: Trace truncations
      cachefiles: Trace read and write operations
      cachefiles: Round the cachefile size up to DIO block size
      cachefiles: Don't use XATTR_ flags with vfs_setxattr()
      fscache: Replace the object management state machine
      cachefiles: Trace decisions in cachefiles_prepare_read()
      cachefiles: Make cachefiles_write_prepare() check for space
      fscache: Automatically close a file that's been unused for a while
      fscache: Add stats for the cookie commit LRU
      fscache: Move fscache_update_cookie() complete inline
      fscache: Remove more obsolete stats
      fscache: Note the object size during invalidation
      vfs, fscache: Force ->write_inode() to occur if cookie pinned for writeback
      afs: Render cache cookie key as big endian
      cachefiles: Use tmpfile/link
      fscache: Rewrite invalidation
      cachefiles: Simplify the file lookup/creation/check code
      fscache: Provide resize operation
      cachefiles: Put more information in the xattr attached to the cache file
      fscache: Implement "will_modify" parameter on fscache_use_cookie()
      fscache: Add support for writing to the cache
      fscache: Make fscache_clear_page_bits() conditional on cookie
      fscache: Make fscache_write_to_cache() conditional on cookie
      afs: Copy local writes to the cache when writing to the server
      afs: Invoke fscache_resize_cookie() when handling ATTR_SIZE for setattr
      afs: Add O_DIRECT read support
      afs: Skip truncation on the server of data we haven't written yet
      afs: Make afs_write_begin() return the THP subpage
      cachefiles, afs: Drive FSCACHE_COOKIE_NO_DATA_TO_READ
      nfs: Convert to new fscache volume/cookie API
      9p: Use fscache indexing rewrite and reenable caching
      9p: Copy local writes to the cache when writing to the server
      netfs: Display the netfs inode number in the netfs_read tracepoint
      cachefiles: Add tracepoints to log errors from ops on the backing fs
      cachefiles: Add error injection support
      cifs: Support fscache indexing rewrite (untested)

Jeff Layton (1):
      fscache: disable cookie when doing an invalidation for DIO write


 fs/9p/cache.c                     |  184 +----
 fs/9p/cache.h                     |   23 +-
 fs/9p/v9fs.c                      |   14 +-
 fs/9p/v9fs.h                      |   13 +-
 fs/9p/vfs_addr.c                  |   55 +-
 fs/9p/vfs_dir.c                   |   13 +-
 fs/9p/vfs_file.c                  |    7 +-
 fs/9p/vfs_inode.c                 |   24 +-
 fs/9p/vfs_inode_dotl.c            |    3 +-
 fs/9p/vfs_super.c                 |    3 +
 fs/afs/Makefile                   |    3 -
 fs/afs/cache.c                    |   68 --
 fs/afs/cell.c                     |   12 -
 fs/afs/file.c                     |   83 +-
 fs/afs/fsclient.c                 |   18 +-
 fs/afs/inode.c                    |  101 ++-
 fs/afs/internal.h                 |   36 +-
 fs/afs/main.c                     |   14 -
 fs/afs/super.c                    |    1 +
 fs/afs/volume.c                   |   15 +-
 fs/afs/write.c                    |  170 +++-
 fs/afs/yfsclient.c                |   12 +-
 fs/cachefiles/Kconfig             |    8 +
 fs/cachefiles/Makefile            |    3 +
 fs/cachefiles/bind.c              |  186 +++--
 fs/cachefiles/daemon.c            |   20 +-
 fs/cachefiles/error_inject.c      |   46 ++
 fs/cachefiles/interface.c         |  660 +++++++--------
 fs/cachefiles/internal.h          |  191 +++--
 fs/cachefiles/io.c                |  310 +++++--
 fs/cachefiles/key.c               |  203 +++--
 fs/cachefiles/main.c              |   20 +-
 fs/cachefiles/namei.c             |  978 ++++++++++------------
 fs/cachefiles/volume.c            |  128 +++
 fs/cachefiles/xattr.c             |  367 +++------
 fs/ceph/Kconfig                   |    2 +-
 fs/cifs/Makefile                  |    2 +-
 fs/cifs/cache.c                   |  105 ---
 fs/cifs/cifsfs.c                  |   11 +-
 fs/cifs/cifsglob.h                |    5 +-
 fs/cifs/connect.c                 |    3 -
 fs/cifs/file.c                    |   37 +-
 fs/cifs/fscache.c                 |  201 ++---
 fs/cifs/fscache.h                 |   51 +-
 fs/cifs/inode.c                   |   18 +-
 fs/fs-writeback.c                 |    8 +
 fs/fscache/Kconfig                |    4 +
 fs/fscache/Makefile               |    6 +-
 fs/fscache/cache.c                |  541 ++++++-------
 fs/fscache/cookie.c               | 1262 ++++++++++++++---------------
 fs/fscache/fsdef.c                |   98 ---
 fs/fscache/internal.h             |  213 +----
 fs/fscache/io.c                   |  405 ++++++---
 fs/fscache/main.c                 |  134 +--
 fs/fscache/netfs.c                |   74 --
 fs/fscache/object.c               | 1123 -------------------------
 fs/fscache/operation.c            |  633 ---------------
 fs/fscache/page.c                 |   84 --
 fs/fscache/proc.c                 |   43 +-
 fs/fscache/stats.c                |  202 ++---
 fs/fscache/volume.c               |  449 ++++++++++
 fs/netfs/read_helper.c            |    2 +-
 fs/nfs/Makefile                   |    2 +-
 fs/nfs/client.c                   |    4 -
 fs/nfs/direct.c                   |    2 +
 fs/nfs/file.c                     |    7 +-
 fs/nfs/fscache-index.c            |  114 ---
 fs/nfs/fscache.c                  |  264 ++----
 fs/nfs/fscache.h                  |   89 +-
 fs/nfs/inode.c                    |   11 +-
 fs/nfs/super.c                    |    7 +-
 fs/nfs/write.c                    |    1 +
 include/linux/fs.h                |    4 +
 include/linux/fscache-cache.h     |  463 +++--------
 include/linux/fscache.h           |  626 +++++++-------
 include/linux/netfs.h             |    4 +-
 include/linux/nfs_fs_sb.h         |    9 +-
 include/linux/writeback.h         |    1 +
 include/trace/events/cachefiles.h |  483 ++++++++---
 include/trace/events/fscache.h    |  631 +++++++--------
 include/trace/events/netfs.h      |    5 +-
 81 files changed, 5140 insertions(+), 7295 deletions(-)
 delete mode 100644 fs/afs/cache.c
 create mode 100644 fs/cachefiles/error_inject.c
 create mode 100644 fs/cachefiles/volume.c
 delete mode 100644 fs/cifs/cache.c
 delete mode 100644 fs/fscache/fsdef.c
 delete mode 100644 fs/fscache/netfs.c
 delete mode 100644 fs/fscache/object.c
 delete mode 100644 fs/fscache/operation.c
 create mode 100644 fs/fscache/volume.c
 delete mode 100644 fs/nfs/fscache-index.c


