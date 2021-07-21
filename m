Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63DF3D0FDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 15:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbhGUNEh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 09:04:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55046 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238585AbhGUNEV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626875079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BzuOVGKf1jZ4WvJF4y5e6uyCaqNkM1nGR5SXLC4damI=;
        b=Km8RDDOyM0N1fAwBh78NGPoI3auxhQ7TdEuryJw4WlQhhNsfVSv5C5FOrmUL95weoEflZh
        1MR2IwwJWXfxq8yR8f8e4b5vlfJ5M0wzcVb3TQhZA3WgIFZWukXL19xLWbDYkyepQpnvCm
        fh2ib180wZwx1HPC/M1LL7v5AVjbWXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-Q2rA4rYqO8W1oMQhctNvHg-1; Wed, 21 Jul 2021 09:44:37 -0400
X-MC-Unique: Q2rA4rYqO8W1oMQhctNvHg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE7C710150A2;
        Wed, 21 Jul 2021 13:44:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-62.rdu2.redhat.com [10.10.112.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53DFD60583;
        Wed, 21 Jul 2021 13:44:30 +0000 (UTC)
Subject: 
From:   David Howells <dhowells@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 21 Jul 2021 14:44:29 +0100
Message-ID: <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[RFC PATCH 00/12] netfs: Experimental write helpers, fscrypt and compression
Date: 


Hi all,

I've been working on extending the netfs helper library to provide write
support (even VM support) for the filesystems that want to use it, with an
eye to building in transparent content crypto support (eg. fscrypt) - so
that content-encrypted data is stored in fscache in encrypted form - and
also client-side compression (something that cifs/smb supports, I believe,
and something that afs may acquire in the future).

This brings interesting issues with PAGE_SIZE potentially being smaller
than the I/O block size, and thus having to make sure pages that aren't
locally modified stay retained.  Note that whilst folios could, in theory,
help here, a folio requires contiguous RAM.

So here's the changes I have so far (WARNING: it's experimental, so may
contain debugging stuff, notes and extra bits and it's not fully
implemented yet).  The changes can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-regions-experimental

With this, I can do simple reads and writes through afs, and the
modifications can be made encrypted to both the server and the cache
(though I haven't yet written the decryption side of it).


REGION LISTS
============

One of the things that I've been experimenting with is keeping a list of
dirty regions on each inode separate from the dirty bits on the page.
Region records can then be used to manage the spans of pages required to
construct a crypto or compression buffer.

With these records available, other possibilities become available:

 (1) I can use a separate list of regions to keep track of the pending and
     active writes to an inode.  This allows the inode lock to be dropped
     as soon as the region is added, with the record acting as a region
     lock.  (Truncate/fallocate is then just a special sort of direct write
     operation).

 (2) Keeping a list of active writes allows parallel non-overlapping[*]
     write operations to the pagecache and possibly parallel DIO write
     operations to the server (I think cifs to Windows allows this).

     [*] Non-overlapping in the sense that, under some circumstances, they
     	 aren't even allowed to touch the same page/folio.

 (3) After downloading data from the server, we may need to write it to the
     cache.  This can be deferred to the VM writeback mechanism by adding a
     'semi-dirty' region and marking the pages dirty.

 (4) Regions can be grouped so that the groups have to be flushed in order,
     thereby allowing ceph snaps and fsync to be implemented by the same
     mechanism and offering a possible RWF_BARRIER for pwritev2().

 (5) No need for write_begin/write_end in the filesystem - this is handled
     using the region in netfs_perform_write().

 (6) PG_fscache is no longer required as the region record can track this.

 (7) page->private isn't needed to track dirty state.

I also keep a flush list of regions that need writing.  If we can't manage
to lock all the pages in a part of the region we want to change, we drop
the locks we've taken and defer.  Since the following should be true:

 - since a dirty region represents data in the pagecache that needs
   writing, the pages containing that data must be present in RAM;

 - a region in the flushing state acts as an exclusive lock against
   overlapping active writers (which must wait for it);

 - the ->releasepage() and ->migratepage() methods can be used to prevent
   the page from being lost

it might be feasible to access the page *without* taking the page lock.

The flusher can split an active region in order to write out part of it,
provided it does so at a page boundary that's at or less than the dirtied
point.  This prevents an in-progress write pinning the entirety of memory.

An alternative to using region records that I'm pondering is to pull the
NFS code for page handling into the netfs lib.  I'm not sure that this
would make it easier to handle multipage spans, though, as releasepage
would need to look at the pages either side.  "Regions" would also be
concocted on the fly by writepages() - but, again, this may require the
involvement of other pages so I would have to be extremely careful of
deadlock.


PROVISION OF BUFFERING
======================

Another of the things I'm experimenting with is sticking buffers in xarray
form in the read and write request structs.

On the read side, this allows a buffer larger than the requested size to be
employed, with the option to discard the excess data or splice it over into
the pagecache - for instance if we get a compressed blob that we don't know
the size of yet or that is larger than the hole we have available in the
pagecache.  A second buffer can be employed to decrypt or decryption can be
done in place, depending on whether we want to copy the encrypted data to
the pagecache.

On the write side, this can be used to encrypt into, with the buffer then
being written to the cache and the server rather than the original.  If
compression is involved, we might want two buffers: we might need to copy
the original into the first buffer so that it doesn't change during
compression, then compress into the second buffer (which could then be
encrypted - if that makes sense).

With regard to DIO, if crypto is required, the helpers would copy the data
in or out of separate buffers, crypting the buffers and uploading or
downloading the buffers to/from the server.  I could even make it handle
RMW for smaller reads, but that needs to be careful because of the
possibility of collision with remote conflicts.


HOW NETFSLIB WOULD BE USED
==========================

In the scheme I'm experimenting with, I envision that a filesystem would
add a netfs context directly after its inode, e.g.:

	struct afs_vnode {
		struct {
			struct inode	vfs_inode;
			struct netfs_i_context netfs_ctx;
		};
		...
	};

and then point many of its inode, address space and VM methods directly at
netfslib, e.g.:

	const struct file_operations afs_file_operations = {
		.open		= afs_open,
		.release	= afs_release,
		.llseek		= generic_file_llseek,
		.read_iter	= generic_file_read_iter,
		.write_iter	= netfs_file_write_iter,
		.mmap		= afs_file_mmap,
		.splice_read	= generic_file_splice_read,
		.splice_write	= iter_file_splice_write,
		.fsync		= netfs_fsync,
		.lock		= afs_lock,
		.flock		= afs_flock,
	};

	const struct address_space_operations afs_file_aops = {
		.readpage	= netfs_readpage,
		.readahead	= netfs_readahead,
		.releasepage	= netfs_releasepage,
		.invalidatepage	= netfs_invalidatepage,
		.writepage	= netfs_writepage,
		.writepages	= netfs_writepages,
	};

	static const struct vm_operations_struct afs_vm_ops = {
		.fault		= filemap_fault,
		.map_pages	= filemap_map_pages,
		.page_mkwrite	= netfs_page_mkwrite,
	};

though it can, of course, wrap them if it needs to.  The inode context
stores any required caching cookie, crypto management parameters and an
operations table.

The netfs lib would be providing helpers for write_iter, page_mkwrite,
writepage, writepages, fsync, truncation and remote invalidation - the idea
being that the filesystem then just needs to provide hooks to perform read
and write RPC operations plus other optional hooks for the maintenance of
state and to help manage grouping, shaping and slicing I/O operations and
doing content crypto, e.g.:

	const struct netfs_request_ops afs_req_ops = {
		.init_rreq		= afs_init_rreq,
		.begin_cache_operation	= afs_begin_cache_operation,
		.check_write_begin	= afs_check_write_begin,
		.issue_op		= afs_req_issue_op,
		.cleanup		= afs_priv_cleanup,
		.init_dirty_region	= afs_init_dirty_region,
		.free_dirty_region	= afs_free_dirty_region,
		.update_i_size		= afs_update_i_size,
		.init_wreq		= afs_init_wreq,
		.add_write_streams	= afs_add_write_streams,
		.encrypt_block		= afs_encrypt_block,
	};


SERVICES THE HELPERS WOULD PROVIDE
==================================

The helpers are intended to transparently provide a number of services to
all the filesystems that want to use them:

 (1) Handling of multipage folios.  The helpers provide iov_iters to the
     filesystem indicating the pages to be read/written.  These may point
     into the pagecache, may point to userspace for unencrypted DIO or may
     point to a separate buffer for cryption/compression.  The fs doesn't
     see any pages/folios unless it wants to.

 (2) Handling of content encryption (e.g. fscrypt).  Encrypted data should
     be encrypted in fscache.  The helpers will write the downloaded
     encrypted data to the cache and will write modified data to the cache
     after it had been encrypted.

     The filesystem will provide the actual crypto, though the helpers can
     do the block-by-block iteration and setting up of scatterlists.  The
     intention is that if fscrypt is being used, the helper will be there.

 (3) Handling of compressed data.  If the data is stored in compressed
     blocks on the server, whereby the client does the (de)compression
     locally, support for handling that is similar to crypto.

     The helpers will provide the buffers and filesystem will provide the
     compression, though the filesystem can expand the buffers as needed.

 (4) Handling of I/O block sizes larger than page size.  If the filesystem
     needs to perform a block RPC I/O that's larger than page size - say it
     has to deal with full-file crypto or a large compression blocksize -
     the helpers will keep around and gather together larger units to make
     it possible to handle writes.

     For a read of a larger block size, the helpers create a buffer of the
     size required, padding it with extra pages as necessary and read into
     that.  The extra pages can then be spliced into holes in the pagecache
     rather than being discarded.

 (5) Handling of direct I/O.  The helpers will break down DIO requests into
     slices based on the rsize/wsize and can also do content crypto and
     (de)compression on the data.

     In the encrypted case, I would, initially at least, make it so that
     the DIO blocksize is set to a multiple of the crypto blocksize.  I
     could allow it to be smaller: when reading, I can just discard the
     excess, but on writing I would need to implement some sort of RMW
     cycle.

 (6) Handling of remote invalidation.  The helpers would be able to operate
     in a number of modes when local modifications exist:

	- discard all local changes
	- download the new version and reapply local changes
	- keep local version and overwrite server version
	- stash local version and replace with new version

 (7) Handling of disconnected operation.  Given feedback from the
     filesystem to indicate when we're in disconnected operation, the
     helpers would save modified code only to the cache, along with a list
     of modified regions.

     Upon reconnection, we would need to sync back to the server - and then
     the handling of remote invalidation would apply when we hit a conflict.


THE CHANGES I'VE MADE SO FAR
============================

The attached patches make a partial attempt at the above and partially
convert the afs filesystem to use them.  It is by no means complete,
however, and almost certainly contains bugs beyond the bits not yet wholly
implemented.

To this end:

 (1) struct netfs_dirty_region defined a region.  This is primarily used to
     track which portions of an inode's pagecache are dirty and in what
     manner.  Not all dirty regions are equal.

 (2) Contiguous dirty regions may be mergeable or one may supersede part of
     another (a local modification supersedes a download), depending on
     type, state and other stuff.  netfs_merge_dirty_region() deals with
     this.

 (3) A read from the server will generate a semi-dirty region that is to be
     written to the cache only.  Such writes to the cache are then driven
     by the VM, no longer being dispatched automatically on completion of
     the read.

 (4) DSYNC writes supersede ordinary writes, may not be merged and are
     flushed immediately.  The writer then waits for that region to finish
     flushing.  (Untested)

 (5) Every region belongs to a flush group.  This provides the opportunity
     for writes to be grouped and for the groups to be flushed in order.
     netfs_flush_region() will flush older regions.  (Untested)

 (6) The netfs_dirty_region struct is used to manage write operations on an
     inode.  The inode has two lists for this: pending writes and active
     writes.  A write request is initially put onto the pending list until
     the region it wishes to modify becomes free of active writes, then
     it's moved to the active list.

     Writes on the active list are not allowed to overlap in their reserved
     regions.  This acts as a region lock, allowing the inode lock to be
     dropped immediately after the record is queued.

 (7) Each region has a bounding box that indicates where the start and end
     of the pages involved are.  The bounding box is expanded to fit
     crypto, compression and cache blocksize requirements.

     Incompatible writes are not allowed to share bounding boxes (e.g. DIO
     writes may not overlap with other writes as the pagecache needs
     invalidation thereafter).

     This is extra complicated with the advent of THPs/multipage folios are
     the page boundaries are variable.

     It might make sense to keep track of partially invalid regions too and
     require them to be downloaded before allowing them to be read.

 (8) An active write is not permitted to proceed until any flushing regions
     it overlaps with are complete.  At that point, it is also added to the
     dirty list.  As it progresses, its dirty region is expanded and the
     writeback manager may split off part of that to make space.  Once it
     is complete, it becomes an ordinary dirty region (if not DIO).

 (9) When a writeback of part of a region occurs, pages in the bounding box
     may be pinned as well as pages containing the modifications as
     necessary to perform crypto/compression.

(10) We then have the situation where a page may be holding modifications
     from different dirty regions.  Under some circumstances (such as the
     file being freshly created locally), these will be merged, bridging
     the gaps with zeros.

     However, if such regions cannot be merged, if we write out one region,
     we have to be careful not to clear the dirty mark on the page if
     there's another dirty region on it.  Similarly, the writeback mark
     might need maintaining after a region completes writing.

     Note that a 'page' might actually be a multipage folio and could be
     quite large - possibly multiple megabytes.

(11) writepage() is an issue.  The VM might call us to ask for a page in
     the middle of a dirty region be flushed.  However, the page is locked
     by the caller and we might need pages from either side to actually
     perform the write (which might also be locked).

     What I'm thinking of here is to have netfs_writepage() find the dirty
     region(s) contributory to a dirty page and put them on the flush queue
     and then return to the VM saying it couldn't be done at this time.


David

Proposals/information about previous parts of the design have been
published here:

Link: https://lore.kernel.org/r/24942.1573667720@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/2758811.1610621106@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/1441311.1598547738@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/160655.1611012999@warthog.procyon.org.uk/

v5 of the read helper patches was here:

Link: https://lore.kernel.org/r/161653784755.2770958.11820491619308713741.stgit@warthog.procyon.org.uk/


---
David Howells (12):
      afs: Sort out symlink reading
      netfs: Add an iov_iter to the read subreq for the network fs/cache to use
      netfs: Remove netfs_read_subrequest::transferred
      netfs: Use a buffer in netfs_read_request and add pages to it
      netfs: Add a netfs inode context
      netfs: Keep lists of pending, active, dirty and flushed regions
      netfs: Initiate write request from a dirty region
      netfs: Keep dirty mark for pages with more than one dirty region
      netfs: Send write request to multiple destinations
      netfs: Do encryption in write preparatory phase
      netfs: Put a list of regions in /proc/fs/netfs/regions
      netfs: Export some read-request ref functions


 fs/afs/callback.c            |   2 +-
 fs/afs/dir.c                 |   2 +-
 fs/afs/dynroot.c             |   1 +
 fs/afs/file.c                | 193 ++------
 fs/afs/inode.c               |  25 +-
 fs/afs/internal.h            |  27 +-
 fs/afs/super.c               |   9 +-
 fs/afs/write.c               | 397 ++++-----------
 fs/ceph/addr.c               |   2 +-
 fs/netfs/Makefile            |  11 +-
 fs/netfs/dio_helper.c        | 140 ++++++
 fs/netfs/internal.h          | 104 ++++
 fs/netfs/main.c              | 104 ++++
 fs/netfs/objects.c           | 218 +++++++++
 fs/netfs/read_helper.c       | 460 ++++++++++++-----
 fs/netfs/stats.c             |  22 +-
 fs/netfs/write_back.c        | 592 ++++++++++++++++++++++
 fs/netfs/write_helper.c      | 924 +++++++++++++++++++++++++++++++++++
 fs/netfs/write_prep.c        | 160 ++++++
 fs/netfs/xa_iterator.h       | 116 +++++
 include/linux/netfs.h        | 273 ++++++++++-
 include/trace/events/netfs.h | 325 +++++++++++-
 22 files changed, 3488 insertions(+), 619 deletions(-)
 create mode 100644 fs/netfs/dio_helper.c
 create mode 100644 fs/netfs/main.c
 create mode 100644 fs/netfs/objects.c
 create mode 100644 fs/netfs/write_back.c
 create mode 100644 fs/netfs/write_helper.c
 create mode 100644 fs/netfs/write_prep.c
 create mode 100644 fs/netfs/xa_iterator.h


