Return-Path: <linux-fsdevel+bounces-25962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E292195236C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 22:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F901C22737
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 20:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB451C4603;
	Wed, 14 Aug 2024 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D6WAcw8a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5D31C37A4
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723667949; cv=none; b=EjJFbddAsKqlB7JkIycM8SYxRDkNpUYB0FBJsLjYcdhHo+P9CjSBwAvYoNhaGbGOsPO4oYY8qju3FzScjr647jzlAw9E2lz3y4nBlF9CNsHqlHErucnH4evry/md3nyXPsb29K8ZaQonZ9cZsLTCXCZJgGxGmLawmYfPEkuyYmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723667949; c=relaxed/simple;
	bh=58NvRL6I3meHI4Ytv/TxU/cXiYub3jbCyc5s3+cIGXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KJoeY6RW3vPTaB9bofku+U56w+1AKyL5rWbA/CHQAkqUIEqa05Xha/nm4/+5ZEP0Nzw+ehJuQKM41WQh7sNbhbfhngo9Cd2SEXix7u/URDnWTyMPRWc70R+hrGSvh3kYP1UFQ86u6gKr1fY4dpmw918Xb2ggYCLbE+TAVWNP5E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D6WAcw8a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723667946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2qkrZ0/6WswDsKwJcP06CqB1C0tA8HBneZAb2bmJdwA=;
	b=D6WAcw8agufnYVePfLhpopM78irXqvITjP3+ZthhmJz9W8vWLc2KT+4M3iKb+MO59+ySg/
	XzfqtpuOAf2ZYFLLYwRCTrXfW5/CnpV+JW6HLNxK++B+qkxbEblhjV1ac0mX7y14oZnUjG
	kifoibOdIOWhfzTzscz8UwhY6j7PTuk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-4Uw9jJb8M_aeO76Ft5VBjg-1; Wed,
 14 Aug 2024 16:39:05 -0400
X-MC-Unique: 4Uw9jJb8M_aeO76Ft5VBjg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06CDE1956095;
	Wed, 14 Aug 2024 20:39:01 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E87101955E8C;
	Wed, 14 Aug 2024 20:38:53 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/25] netfs: Read/write improvements
Date: Wed, 14 Aug 2024 21:38:20 +0100
Message-ID: <20240814203850.2240469-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi Christian, Steve, Willy,

This set of patches includes a couple of fixes:

 (1) Revert the removal of waits on PG_private_2 from netfs_release_page()
     and netfs_invalidate_page().

 (2) Make cachefiles take the sb_writers lock around set/removexattr.

A couple of adjustments to the /proc/fs/netfs/stats file:

 (3) All the netfs stats lines begin 'Netfs:'.  Change this to something a
     bit more useful.

 (4) Add a couple of stats counters to track the numbers of skips and waits
     on the per-inode writeback serialisation lock to make it easier to
     check for this as a source of performance loss.

Some miscellaneous bits:

 (5) Reduce the number of conditional branches in netfs_perform_write().

 (6) Move the CIFS_INO_MODIFIED_ATTR flag to the netfs_inode struct and
     remove cifs_post_modify().

 (7) Move the max_len/max_nr_segs members from netfs_io_subrequest to
     netfs_io_request as they're only needed for one subreq at a time.

 (8) Add an 'unknown' source value for tracing purposes.

 (9) Remove NETFS_COPY_TO_CACHE as it's no longer used.

(10) Set the request work function up front at allocation time.

(11) Use bh-disabling spinlocks for rreq->lock as cachefiles completion may
     be run from block-filesystem DIO completion in softirq context.

Then there's the main performance enhancing changes:

(12) Define a structure, struct folio_queue, and a new iterator type,
     ITER_FOLIOQ, to hold a buffer as a replacement for ITER_XARRAY.  See
     that patch for questions about naming and form.

(13) Provide a copy_folio_from_iter() wrapper.

(14) Make cifs RDMA support ITER_FOLIOQ.

(15) Use folio queues in the write-side helpers instead of xarrays.

(16) Add a function to reset the iterator in a subrequest.

(17) Simplify the write-side helpers to use sheaves to skip gaps rather than
     trying to work out where gaps are.

(18) In afs, make the read subrequests asynchronous, putting them into work
     items to allow the next patch to do progressive unlocking/reading.

(19) Overhaul the read-side helpers to improve performance.

(20) Remove fs/netfs/io.c.

(21) Fix the caching of a partial block at the end of a file.

(22) Allow a store to be cancelled.

Then some changes for cifs to make it use folio queues instead of xarrays
for crypto bufferage:

(23) Use raw iteration functions rather than manually coding iteration when
     hashing data.

(24) Switch to using folio_queue for crypto buffers.

(25) Remove the xarray bits.

Changes
=======
ver #2)
 - Rebase to the merge of vfs.fixes after v6.11-rc3.
 - Add fixes for missing waits on PG_private_2.
 - Make the read-side helper overhaul support PG_private_2-based
   filesystems also.
 - When reading, only limit server downloads to the max download size, not
   cache reads or simple zeroing.
 - Add some missing cases of skipping forward when iterating over a folio
   queue list when the place we're at has the current slot number parked
   just past the last slot (typically, because we're extending the list
   incrementally).
 - Don't use folio_batch_release() to release the refs on pages in the
   folio_queue struct mid-read as we rely on the count in the batch later.
 - Fix the determination of whether an operation can access the cache.

David

David Howells (25):
  netfs, ceph: Partially revert "netfs: Replace PG_fscache by setting
    folio->private and marking dirty"
  cachefiles: Fix non-taking of sb_writers around set/removexattr
  netfs: Adjust labels in /proc/fs/netfs/stats
  netfs: Record contention stats for writeback lock
  netfs: Reduce number of conditional branches in netfs_perform_write()
  netfs, cifs: Move CIFS_INO_MODIFIED_ATTR to netfs_inode
  netfs: Move max_len/max_nr_segs from netfs_io_subrequest to
    netfs_io_stream
  netfs: Reserve netfs_sreq_source 0 as unset/unknown
  netfs: Remove NETFS_COPY_TO_CACHE
  netfs: Set the request work function upon allocation
  netfs: Use bh-disabling spinlocks for rreq->lock
  mm: Define struct folio_queue and ITER_FOLIOQ to handle a sequence of
    folios
  iov_iter: Provide copy_folio_from_iter()
  cifs: Provide the capability to extract from ITER_FOLIOQ to RDMA SGEs
  netfs: Use new folio_queue data type and iterator instead of xarray
    iter
  netfs: Provide an iterator-reset function
  netfs: Simplify the writeback code
  afs: Make read subreqs async
  netfs: Speed up buffered reading
  netfs: Remove fs/netfs/io.c
  cachefiles, netfs: Fix write to partial block at EOF
  netfs: Cancel dirty folios that have no storage destination
  cifs: Use iterate_and_advance*() routines directly for hashing
  cifs: Switch crypto buffer to use a folio_queue rather than an xarray
  cifs: Don't support ITER_XARRAY

 fs/9p/vfs_addr.c             |   5 +-
 fs/afs/file.c                |  30 +-
 fs/afs/fsclient.c            |   9 +-
 fs/afs/write.c               |   4 +-
 fs/afs/yfsclient.c           |   9 +-
 fs/cachefiles/io.c           |  19 +-
 fs/cachefiles/xattr.c        |  34 +-
 fs/ceph/addr.c               |  76 ++--
 fs/ceph/inode.c              |   1 +
 fs/netfs/Makefile            |   4 +-
 fs/netfs/buffered_read.c     | 766 ++++++++++++++++++++-------------
 fs/netfs/buffered_write.c    | 309 +++++++-------
 fs/netfs/direct_read.c       | 147 ++++++-
 fs/netfs/internal.h          |  43 +-
 fs/netfs/io.c                | 796 -----------------------------------
 fs/netfs/iterator.c          |  50 +++
 fs/netfs/main.c              |   7 +-
 fs/netfs/misc.c              | 101 +++++
 fs/netfs/objects.c           |  16 +-
 fs/netfs/read_collect.c      | 544 ++++++++++++++++++++++++
 fs/netfs/read_pgpriv2.c      | 264 ++++++++++++
 fs/netfs/read_retry.c        | 256 +++++++++++
 fs/netfs/stats.c             |  27 +-
 fs/netfs/write_collect.c     | 246 ++++-------
 fs/netfs/write_issue.c       |  93 ++--
 fs/nfs/fscache.c             |  19 +-
 fs/nfs/fscache.h             |   7 +-
 fs/smb/client/cifsencrypt.c  | 144 +------
 fs/smb/client/cifsglob.h     |   3 +-
 fs/smb/client/cifssmb.c      |   6 +-
 fs/smb/client/file.c         |  71 ++--
 fs/smb/client/smb2ops.c      | 218 +++++-----
 fs/smb/client/smb2pdu.c      |  10 +-
 fs/smb/client/smbdirect.c    |  82 ++--
 include/linux/folio_queue.h  | 156 +++++++
 include/linux/iov_iter.h     | 104 +++++
 include/linux/netfs.h        |  45 +-
 include/linux/uio.h          |  18 +
 include/trace/events/netfs.h | 144 +++++--
 lib/iov_iter.c               | 240 ++++++++++-
 lib/kunit_iov_iter.c         | 259 ++++++++++++
 lib/scatterlist.c            |  69 ++-
 42 files changed, 3515 insertions(+), 1936 deletions(-)
 delete mode 100644 fs/netfs/io.c
 create mode 100644 fs/netfs/read_collect.c
 create mode 100644 fs/netfs/read_pgpriv2.c
 create mode 100644 fs/netfs/read_retry.c
 create mode 100644 include/linux/folio_queue.h


