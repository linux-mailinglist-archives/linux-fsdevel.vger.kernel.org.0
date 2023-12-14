Return-Path: <linux-fsdevel+bounces-6076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AC58132A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 15:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0951C21A81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 14:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E224859E3F;
	Thu, 14 Dec 2023 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEf9TAL6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CCB3A8FB;
	Thu, 14 Dec 2023 14:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC68FC433C7;
	Thu, 14 Dec 2023 14:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702563116;
	bh=oXMYUPYrnhRkcD1Zjdpw37mGf3H02Aqr5lM5BV6Wz5U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ZEf9TAL67gutlYiwSsAHy8bbybzBjFfpy4nxbLzhDM3pqQNlVuF158V3H++X6/WUa
	 13uvQzftN8u+QojZ5p8pmf6xdZfpRPxwgiITA/dcsZ0MCn/vEO8ww0MU7ZsQdlaztw
	 PwJ/+dWLO9uiJSMWlSZ2F8msqCX+fbAE32j8rPBZ4dXBUXZcC5HJ4s1WZL2NhVlwiO
	 APQayQ97a3wLquHMK2NT1aH7J3W0NAHEYSEfPggg83G9s+xHzaldyGiBKNtpmLHILZ
	 o/gc69wRhYjxsvSVyu4O5BTVX2AyvTpQlXAEeIEwXtDO7VOnXvBoLM3nBQ00iUoZiT
	 eTTZ3APKx7Jlg==
Message-ID: <ede57e618abfc38229157447fb152f6027eb1b8e.camel@kernel.org>
Subject: Re: [PATCH v4 00/39] netfs, afs, 9p: Delegate high-level I/O to
 netfslib
From: Jeff Layton <jlayton@kernel.org>
To: David Howells <dhowells@redhat.com>, Steve French <smfrench@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Marc Dionne
 <marc.dionne@auristor.com>,  Paulo Alcantara <pc@manguebit.com>, Shyam
 Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Dominique
 Martinet <asmadeus@codewreck.org>, Eric Van Hensbergen <ericvh@kernel.org>,
 Ilya Dryomov <idryomov@gmail.com>, Christian Brauner
 <christian@brauner.io>, linux-cachefs@redhat.com,
 linux-afs@lists.infradead.org,  linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org,  ceph-devel@vger.kernel.org,
 v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,  linux-mm@kvack.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 14 Dec 2023 09:11:53 -0500
In-Reply-To: <20231213152350.431591-1-dhowells@redhat.com>
References: <20231213152350.431591-1-dhowells@redhat.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-13 at 15:23 +0000, David Howells wrote:
> Hi Jeff, Steve, Dominique,
>=20
> I have been working on my netfslib helpers to the point that I can run
> xfstests on AFS to completion (both with write-back buffering and, with a
> small patch, write-through buffering in the pagecache).  I have a patch f=
or
> 9P, but am currently unable to test it.
>=20
> The patches remove a little over 800 lines from AFS, 300 from 9P, albeit =
with
> around 3000 lines added to netfs.  Hopefully, I will be able to remove a =
bunch
> of lines from Ceph too.
>=20
> I've split the CIFS patches out to a separate branch, cifs-netfs, where a
> further 2000+ lines are removed.  I can run a certain amount of xfstests =
on
> CIFS, though I'm running into ksmbd issues and not all the tests work
> correctly because of issues between fallocate and what the SMB protocol
> actually supports.
>=20
> I've also dropped the content-crypto patches out for the moment as they'r=
e
> only usable by the ceph changes which I'm still working on.
>=20
> The patch to use PG_writeback instead of PG_fscache for writing to the
> cache has also been deferred, pending 9p, afs, ceph and cifs all being
> converted.
>=20
> The main aims of these patches are to get high-level I/O and knowledge of
> the pagecache out of the filesystem drivers as much as possible and to ge=
t
> rid, as much of possible, of the knowledge that pages/folios exist.
>=20
> Further, I would like to see ->write_begin, ->write_end and ->launder_fol=
io
> go away.
>=20
> Features that are added by these patches to that which is already there i=
n
> netfslib:
>=20
>  (1) NFS-style (and Ceph-style) locking around DIO vs buffered I/O calls =
to
>      prevent these from happening at the same time.  mmap'd I/O can, of
>      necessity, happen at any time ignoring these locks.
>=20
>  (2) Support for unbuffered I/O.  The data is kept in the bounce buffer a=
nd
>      the pagecache is not used.  This can be turned on with an inode flag=
.
>=20
>  (3) Support for direct I/O.  This is basically unbuffered I/O with some
>      extra restrictions and no RMW.
>=20
>  (4) Support for using a bounce buffer in an operation.  The bounce buffe=
r
>      may be bigger than the target data/buffer, allowing for crypto
>      rounding.
>=20
>  (5) ->write_begin() and ->write_end() are ignored in favour of merging a=
ll
>      of that into one function, netfs_perform_write(), thereby avoiding t=
he
>      function pointer traversals.
>=20
>  (6) Support for write-through caching in the pagecache.
>      netfs_perform_write() adds the pages is modifies to an I/O operation
>      as it goes and directly marks them writeback rather than dirty.  Whe=
n
>      writing back from write-through, it limits the range written back.
>      This should allow CIFS to deal with byte-range mandatory locks
>      correctly.
>=20
>  (7) O_*SYNC and RWF_*SYNC writes use write-through rather than writing t=
o
>      the pagecache and then flushing afterwards.  An AIO O_*SYNC write wi=
ll
>      notify of completion when the sub-writes all complete.
>=20
>  (8) Support for write-streaming where modifed data is held in !uptodate
>      folios, with a private struct attached indicating the range that is
>      valid.
>=20
>  (9) Support for write grouping, multiplexing a pointer to a group in the
>      folio private data with the write-streaming data.  The writepages
>      algorithm only writes stuff back that's in the nominated group.  Thi=
s
>      is intended for use by Ceph to write is snaps in order.
>=20
> (10) Skipping reads for which we know the server could only supply zeros =
or
>      EOF (for instance if we've done a local write that leaves a hole in
>      the file and extends the local inode size).
>=20
> General notes:
>=20
>  (1) The fscache module is merged into the netfslib module to avoid cycli=
c
>      exported symbol usage that prevents either module from being loaded.
>=20
>  (2) Some helpers from fscache are reassigned to netfslib by name.
>=20
>  (3) netfslib now makes use of folio->private, which means the filesystem
>      can't use it.
>=20
>  (4) The filesystem provides wrappers to call the write helpers, allowing
>      it to do pre-validation, oplock/capability fetching and the passing =
in
>      of write group info.
>=20
>  (5) I want to try flushing the data when tearing down an inode before
>      invalidating it to try and render launder_folio unnecessary.
>=20
>  (6) Write-through caching will generate and dispatch write subrequests a=
s
>      it gathers enough data to hit wsize and has whole pages that at leas=
t
>      span that size.  This needs to be a bit more flexible, allowing for =
a
>      filesystem such as CIFS to have a variable wsize.
>=20
>  (7) The filesystem driver is just given read and write calls with an
>      iov_iter describing the data/buffer to use.  Ideally, they don't see
>      pages or folios at all.  A function, extract_iter_to_sg(), is alread=
y
>      available to decant part of an iterator into a scatterlist for crypt=
o
>      purposes.
>=20
>=20
> 9P notes:
>=20
>  (1) I haven't managed to test this as I haven't been able to get Ganesha
>      to work correctly with 9P.
>=20
>  (2) Writes should now occur in larger-than-page-sized chunks.
>=20
>  (3) It should be possible to turn on multipage folio support in 9P now.
>=20
>=20
> Changes
> =3D=3D=3D=3D=3D=3D=3D
> ver #4)
>  - Slimmed down the branch:
>    - Split the cifs-related patches off to a separate branch (cifs-netfs)
>    - Deferred the content-encryption to the in-progress ceph changes.
>    - Deferred the use-PG_writeback rather than PG_fscache patch
>  - Rebased on a later linux-next with afs-rotation patches.
>=20
> ver #3)
>  - Moved the fscache module into netfslib to avoid export cycles.
>  - Fixed a bunch of bugs.
>  - Got CIFS to pass as much of xfstests as possible.
>  - Added a patch to make 9P use all the helpers.
>  - Added a patch to stop using PG_fscache, but rather dirty pages on
>    reading and have writepages write to the cache.
>=20
> ver #2)
>  - Folded the addition of NETFS_RREQ_NONBLOCK/BLOCKED into first patch th=
at
>    uses them.
>  - Folded addition of rsize member into first user.
>  - Don't set rsize in ceph (yet) and set it in kafs to 256KiB.  cifs sets
>    it dynamically.
>  - Moved direct_bv next to direct_bv_count in struct netfs_io_request and
>    labelled it with a __counted_by().
>  - Passed flags into netfs_xa_store_and_mark() rather than two bools.
>  - Removed netfs_set_up_buffer() as it wasn't used.
>=20
> David
>=20
> Link: https://lore.kernel.org/r/20231013160423.2218093-1-dhowells@redhat.=
com/ # v1
> Link: https://lore.kernel.org/r/20231117211544.1740466-1-dhowells@redhat.=
com/ # v2
>=20
> David Howells (39):
>   netfs, fscache: Move fs/fscache/* into fs/netfs/
>   netfs, fscache: Combine fscache with netfs
>   netfs, fscache: Remove ->begin_cache_operation
>   netfs, fscache: Move /proc/fs/fscache to /proc/fs/netfs and put in a
>     symlink
>   netfs: Move pinning-for-writeback from fscache to netfs
>   netfs: Add a procfile to list in-progress requests
>   netfs: Allow the netfs to make the io (sub)request alloc larger
>   netfs: Add a ->free_subrequest() op
>   afs: Don't use folio->private to record partial modification
>   netfs: Provide invalidate_folio and release_folio calls
>   netfs: Implement unbuffered/DIO vs buffered I/O locking
>   netfs: Add iov_iters to (sub)requests to describe various buffers
>   netfs: Add support for DIO buffering
>   netfs: Provide tools to create a buffer in an xarray
>   netfs: Add bounce buffering support
>   netfs: Add func to calculate pagecount/size-limited span of an
>     iterator
>   netfs: Limit subrequest by size or number of segments
>   netfs: Export netfs_put_subrequest() and some tracepoints
>   netfs: Extend the netfs_io_*request structs to handle writes
>   netfs: Add a hook to allow tell the netfs to update its i_size
>   netfs: Make netfs_put_request() handle a NULL pointer
>   netfs: Make the refcounting of netfs_begin_read() easier to use
>   netfs: Prep to use folio->private for write grouping and streaming
>     write
>   netfs: Dispatch write requests to process a writeback slice
>   netfs: Provide func to copy data to pagecache for buffered write
>   netfs: Make netfs_read_folio() handle streaming-write pages
>   netfs: Allocate multipage folios in the writepath
>   netfs: Implement support for unbuffered/DIO read
>   netfs: Implement unbuffered/DIO write support
>   netfs: Implement buffered write API
>   netfs: Allow buffered shared-writeable mmap through
>     netfs_page_mkwrite()
>   netfs: Provide netfs_file_read_iter()
>   netfs, cachefiles: Pass upper bound length to allow expansion
>   netfs: Provide a writepages implementation
>   netfs: Provide a launder_folio implementation
>   netfs: Implement a write-through caching option
>   netfs: Optimise away reads above the point at which there can be no
>     data
>   afs: Use the netfs write helpers
>   9p: Use netfslib read/write_iter
>=20
>  Documentation/filesystems/netfs_library.rst   |   23 +-
>  MAINTAINERS                                   |    2 +-
>  fs/9p/vfs_addr.c                              |  352 +----
>  fs/9p/vfs_file.c                              |   89 +-
>  fs/9p/vfs_inode.c                             |    5 +-
>  fs/9p/vfs_super.c                             |   14 +-
>  fs/Kconfig                                    |    1 -
>  fs/Makefile                                   |    1 -
>  fs/afs/file.c                                 |  213 +--
>  fs/afs/inode.c                                |   26 +-
>  fs/afs/internal.h                             |   72 +-
>  fs/afs/super.c                                |    2 +-
>  fs/afs/write.c                                |  826 +----------
>  fs/cachefiles/internal.h                      |    2 +-
>  fs/cachefiles/io.c                            |   10 +-
>  fs/cachefiles/ondemand.c                      |    2 +-
>  fs/ceph/addr.c                                |   25 +-
>  fs/ceph/cache.h                               |   35 +-
>  fs/ceph/inode.c                               |    2 +-
>  fs/fs-writeback.c                             |   10 +-
>  fs/fscache/Kconfig                            |   40 -
>  fs/fscache/Makefile                           |   16 -
>  fs/fscache/internal.h                         |  277 ----
>  fs/netfs/Kconfig                              |   39 +
>  fs/netfs/Makefile                             |   22 +-
>  fs/netfs/buffered_read.c                      |  229 ++-
>  fs/netfs/buffered_write.c                     | 1247 +++++++++++++++++
>  fs/netfs/direct_read.c                        |  252 ++++
>  fs/netfs/direct_write.c                       |  170 +++
>  fs/{fscache/cache.c =3D> netfs/fscache_cache.c} |    0
>  .../cookie.c =3D> netfs/fscache_cookie.c}       |    0
>  fs/netfs/fscache_internal.h                   |   14 +
>  fs/{fscache/io.c =3D> netfs/fscache_io.c}       |   42 +-
>  fs/{fscache/main.c =3D> netfs/fscache_main.c}   |   25 +-
>  fs/{fscache/proc.c =3D> netfs/fscache_proc.c}   |   23 +-
>  fs/{fscache/stats.c =3D> netfs/fscache_stats.c} |    4 +-
>  .../volume.c =3D> netfs/fscache_volume.c}       |    0
>  fs/netfs/internal.h                           |  288 ++++
>  fs/netfs/io.c                                 |  214 ++-
>  fs/netfs/iterator.c                           |   97 ++
>  fs/netfs/locking.c                            |  215 +++
>  fs/netfs/main.c                               |  110 ++
>  fs/netfs/misc.c                               |  260 ++++
>  fs/netfs/objects.c                            |   63 +-
>  fs/netfs/output.c                             |  478 +++++++
>  fs/netfs/stats.c                              |   31 +-
>  fs/nfs/Kconfig                                |    4 +-
>  fs/nfs/fscache.c                              |    7 -
>  fs/smb/client/cifsfs.c                        |    9 +-
>  fs/smb/client/file.c                          |   18 +-
>  fs/smb/client/fscache.c                       |    2 +-
>  include/linux/fs.h                            |    2 +-
>  include/linux/fscache.h                       |   45 -
>  include/linux/netfs.h                         |  176 ++-
>  include/linux/writeback.h                     |    2 +-
>  include/trace/events/afs.h                    |   31 -
>  include/trace/events/netfs.h                  |  155 +-
>  mm/filemap.c                                  |    1 +
>  58 files changed, 4197 insertions(+), 2123 deletions(-)
>  delete mode 100644 fs/fscache/Kconfig
>  delete mode 100644 fs/fscache/Makefile
>  delete mode 100644 fs/fscache/internal.h
>  create mode 100644 fs/netfs/buffered_write.c
>  create mode 100644 fs/netfs/direct_read.c
>  create mode 100644 fs/netfs/direct_write.c
>  rename fs/{fscache/cache.c =3D> netfs/fscache_cache.c} (100%)
>  rename fs/{fscache/cookie.c =3D> netfs/fscache_cookie.c} (100%)
>  create mode 100644 fs/netfs/fscache_internal.h
>  rename fs/{fscache/io.c =3D> netfs/fscache_io.c} (86%)
>  rename fs/{fscache/main.c =3D> netfs/fscache_main.c} (84%)
>  rename fs/{fscache/proc.c =3D> netfs/fscache_proc.c} (58%)
>  rename fs/{fscache/stats.c =3D> netfs/fscache_stats.c} (97%)
>  rename fs/{fscache/volume.c =3D> netfs/fscache_volume.c} (100%)
>  create mode 100644 fs/netfs/locking.c
>  create mode 100644 fs/netfs/misc.c
>  create mode 100644 fs/netfs/output.c
>=20

This all looks pretty great, David. Nice work! I had a few comments on a
few of them, but most are no big deal. It'd be nice to get this into
linux-next soon.

On the ones where I didn't have comments, you can add:

Reviewed-by: Jeff Layton <jlayton@kernel.org>

