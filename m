Return-Path: <linux-fsdevel+bounces-79377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mATLM+s8qGl6rQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:08:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 611E9200FC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B28530E52BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 14:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626E1344DB9;
	Wed,  4 Mar 2026 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qq7Azw/W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4F834D4F9
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633032; cv=none; b=GpVVjy2Wz654Lnzu5l7jY8wM9Wfuw2h4LHqEuX9LzIHHrprH8N3yuyhjyvPu6uKMreNH0DjJShSSGkwSinhxnxUqNr00dpqb79WgEkf8CgeNTIEMOIxp2dBn8ecz9AkGSGZWZUu/7GtrqpaVfsu/4qPAebBlUgSdyzt5TMxx9eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633032; c=relaxed/simple;
	bh=1FzlaWuFLHg0MFaCBjxXLnOMEXdljE44wTExL0KRcvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ala+QYxd90vgH/ybfA71+yjox6bsZvNekb4UnleFFHBeCrjajToNhohpcbGJQQCvuPHC7ZxSWlt/c47MnRW8yQJPwYrstvvRpXSgVXzsPDSSqU5rJApK/FquaIqFdXcIEqiBelSxbApd2su8zpMZux+OYcIrJbSvCGv1+rMqP4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qq7Azw/W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772633030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+WIDnIhTkS9nHulT35K3M+7YjDAtdLL5oA2NtnO2on0=;
	b=Qq7Azw/WvCTVlJpKuk6vYHrlbxwXAf7yUw/abRV/TvXuygLlfUWiKiwf5ZIpYWkVly9kRx
	npsCEFor2M3JPrivcxmqQiwvFbQIv3n5liA4LmQx5J3QdMQVIeJqsDXNFKKmeP/pq+FOXQ
	ovOhAFwXKA1Fg0GuswreciXNTry4Dyk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-cUu05l7LOtKvi_H8tPZRUA-1; Wed,
 04 Mar 2026 09:03:47 -0500
X-MC-Unique: cUu05l7LOtKvi_H8tPZRUA-1
X-Mimecast-MFC-AGG-ID: cUu05l7LOtKvi_H8tPZRUA_1772633024
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 698F61955F02;
	Wed,  4 Mar 2026 14:03:39 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.194])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E9373180075F;
	Wed,  4 Mar 2026 14:03:32 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 00/17] netfs: [WIP] Keep track of folios in a segmented bio_vec[] chain
Date: Wed,  4 Mar 2026 14:03:07 +0000
Message-ID: <20260304140328.112636-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 611E9200FC5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79377-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Willy, Christoph, et al.,

[!] This is a preview.  Please don't expect this to fully compile or work.
    It's been somewhat tested with AFS and CIFS, but not 9P, Ceph or NFS -
    and will not build with Ceph or NFS at the moment.

These patches get rid of folio_queue, rolling_buffer and ITER_FOLIOQ,
replacing the folio queue construct used to manage buffers in netfslib with
one based around a segmented chain of bio_vec arrays instead.  There are
three main aims here:

 (1) The kernel file I/O subsystem seems to be moving towards consolidating
     on the use of bio_vec arrays, so embrace this by moving netfslib to
     keep track of its buffers for buffered I/O in bio_vec[] form.

 (2) Netfslib already uses a bio_vec[] to handle unbuffered/DIO, so the
     number of different buffering schemes used can be reduced to just a
     single one.

 (3) Always send an entire filesystem RPC request message to a TCP socket
     with single kernel_sendmsg() call as this is faster, more efficient
     and doesn't require the use of corking as it puts the entire
     transmission loop inside of a single tcp_sendmsg().

For the replacement of folio_queue, a segmented chain of bio_vec arrays
rather than a single monolithic array is provided:

	struct bvecq {
		struct bvecq		*next;
		struct bvecq		*prev;
		unsigned long long	fpos;
		refcount_t		ref;
		u32			priv;
		u16			nr_segs;
		u16			max_segs;
		bool			inline_bv:1;
		bool			free:1;
		bool			unpin:1;
		bool			discontig:1;
		struct bio_vec		*bv;
		struct bio_vec		__bv[];
	};

The fields are:

 (1) next, prev - Link segments together in a list.  I want this to be
     NULL-terminated linear rather than circular to make it possible to
     arbitrarily glue bits on the front.

 (2) fpos, discontig - Note the current file position of the first byte of
     the segment; all the bio_vecs in ->bv[] must be contiguous in the file
     space.  The fpos can be used to find the folio by file position rather
     then from the info in the bio_vec.

     If there's a discontiguity, this should break over into a new bvecq
     segment with the discontig flag set (though this is redundant if you
     keep track of the file position).  Note that the beginning and end
     file positions in a segment need not be aligned to any filesystem
     block size.

 (3) ref - Refcount.  Each bvecq keeps a ref on the next.  I'm not sure
     this is entirely necessary, but it makes sharing slices easier.

 (4) priv - Private data for the owner.  Dispensible; currently only used
     for storing a debug ID for tracing in a patch not included here.

 (5) max_segs, nr_segs.  The size of bv[] and the number of elements used.
     I've assumed a maximum of 65535 bio_vecs in the array (which would
     represent a ~1MiB allocation).

 (6) bv, __bv, inline_bv.  bv points to the bio_vec[] array handled by
     this segment.  This may begin at __bv and if it does inline_bv should
     be set (otherwise it's impossible to distinguish a separately
     allocated bio_vec[] that follows immediately by coincidence).

 (7) free, unpin.  free is set if the memory pointed to by the bio_vecs
     needs freeing in some way upon I/O completion.  unpin is set if this
     means using GUP unpinning rather than put_page().

I've also defined an iov_iter iterator type ITER_BVECQ to walk this sort of
construct so that it can be passed directly to sendmsg() or block-based DIO
(as cachefiles does).

This series makes the following changes to netfslib:

 (1) The folio_queue chain used to hold folios for buffered I/O is replaced
     with a bvecq chain.  Each bio_vec then holds (a portion of) one folio.
     Each bvecq holds a contiguous sequence of folios, but adjacent bvecqs
     in a chain may be discontiguous.

 (2) For unbuffered/DIO, the source iov_iter is extracted into a bvecq
     chain.

 (3) An abstract position representation ('bvecq_pos') is created that can
     used to hold a position in a bvecq chain.  For the moment, this takes
     a ref on the bvecq it points to, but that may be excessive.

 (4) Buffer tracking is managed with three cursors:  The load_cursor, at
     which new folios are added as we go; the dispatch_cursor, at which new
     subrequests' buffers start when they're created; and the
     collect_cursor, the point at which folios are being unlocked.

     Not all cursors are necessarily needed in all situations and during
     buffered writeback, we actually need a dispatch cursor per stream (one
     for the network filesystem and one for the cache).

 (5) ->prepare_read(), buffer setting up and ->issue_read() are merged, as
     are the write variants, with the filesystem calling back up to
     netfslib to prepare its buffer.  This simplifies the process of
     setting up a subrequest.  It may even make sense to have the
     filesystem allocate the subrequest.

 (6) For the moment, dispatch tracking is removed from netfs_io_request and
     netfs_io_stream.  The problem is that we have several different ways
     (including in the retry code) in which we need to track things, some
     of which (e.g. retry) might happen simultaneously with the main
     dispatch, so keeping things separate helps.  Netfslib sets up a
     context struct, passes it to ->issue_read/write(), which passes it
     back to netfs_prepare_read/write_buffer().

 (7) Netfslib dispatches I/O by accumulating enough bufferage to dispatch
     at least one subrequest, then looping to generate as many as the
     filesystem wants to (they may be limited by other constraints,
     e.g. max RDMA segment count or negotiated max size).  This loop could
     be moved down into the filesystem.  A new method is provided by which
     netfslib can ask the filesystem to provide an estimate of the data
     that should be accumulated before dispatch begins.

 (8) Reading from the cache is now managed by querying the cache to provide
     a list of the next data extents within the cache.  For the moment this
     uses FIEMAP, but should at some point into the future transition to
     using a block-fs metadata-independent way of tracking this.

 (9) AFS directories are switched to using a bvecq rather than a
     folio_queue to hold their contents.

(10) Make CIFS use a bvecq rather than a folio_queue for holding a
     temporary encryption buffer.

(11) CIFS RDMA is given the ability to extract ITER_BVECQ and support for
     extracting ITER_FOLIOQ, ITER_BVEC and ITER_KVEC is removed.

(12) All the folio_queue and rolling_buffer code is removed.

Two further things that I'm working on (but not in this branch) are:

 (1) Make it so that a filesystem can be given a copy of a subchain which
     it can then tack header and trailer protocol elements upon to form a
     single message (I have this working for cifs) and even join copies
     together with intervening protocol elements to form compounds.

 (2) Make it so that a filesystem can 'splice' out the contents of the TCP
     receive queue into a bvecq chain.  This allows the socket lock to be
     dropped much more quickly and the copying of data read to the
     destination buffers to happen without the lock.  I have this working
     for cifs too.  Kernel recvmsg() doesn't then block kernel sendmsg()
     for anywhere near as long.

There are also some things I want to consider for the future:

 (1) Create one or more batched iteration functions to 'unlock' all the
     folios in a bio_vec[], where 'unlock' is the appropriate action for
     ending a read or a write.  Batching should hopefully also improve the
     efficiency of wrangling the marks on the xarray.  Very often these
     marks are going to be represented by contiguous bits, so there may be
     a way to change them in bulk.

 (2) Rather than walking the bvecq chain to get each individual folio out
     via bv_page, use the file position stored on the bvecq and the sum of
     bv_len to iterate over the appropriate range in i_pages.

 (3) Change iov_iter to store the initial starting point and for
     iov_iter_revert() to reset to that and advance.  This would (a) help
     prevent over-reversion and (b) dispense with the need for a prev
     pointer.

 (4) Use bvecq to replace scatterlist.  One problem with replacing
     scatterlist is that crypto drivers like to glue bits on the front of
     the scatterlists they're given (something trivial with that API) - and
     this is one way to achieve it.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-next

Thanks,
David

David Howells (17):
  netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict
    sequence
  vfs: Implement a FIEMAP callback
  iov_iter: Add a segmented queue of bio_vec[]
  Add a function to kmap one page of a multipage bio_vec
  netfs: Add some tools for managing bvecq chains
  afs: Use a bvecq to hold dir content rather than folioq
  netfs: Add a function to extract from an iter into a bvecq
  cifs: Use a bvecq for buffering instead of a folioq
  cifs: Support ITER_BVECQ in smb_extract_iter_to_rdma()
  netfs: Switch to using bvecq rather than folio_queue and
    rolling_buffer
  cifs: Remove support for ITER_KVEC/BVEC/FOLIOQ from
    smb_extract_iter_to_rdma()
  netfs: Remove netfs_alloc/free_folioq_buffer()
  netfs: Remove netfs_extract_user_iter()
  iov_iter: Remove ITER_FOLIOQ
  netfs: Remove folio_queue and rolling_buffer
  netfs: Check for too much data being read
  netfs: Combine prepare and issue ops and grab the buffers on request

 Documentation/core-api/folio_queue.rst | 209 ------
 Documentation/core-api/index.rst       |   1 -
 fs/9p/vfs_addr.c                       |  34 +-
 fs/afs/dir.c                           |  41 +-
 fs/afs/dir_edit.c                      |  42 +-
 fs/afs/dir_search.c                    |  33 +-
 fs/afs/file.c                          |  27 +-
 fs/afs/fsclient.c                      |   8 +-
 fs/afs/inode.c                         |  18 +-
 fs/afs/internal.h                      |  16 +-
 fs/afs/write.c                         |  35 +-
 fs/afs/yfsclient.c                     |   6 +-
 fs/cachefiles/io.c                     | 350 +++++----
 fs/ceph/addr.c                         | 109 +--
 fs/ioctl.c                             |  29 +-
 fs/netfs/Makefile                      |   4 +-
 fs/netfs/buffered_read.c               | 495 ++++++++-----
 fs/netfs/buffered_write.c              |   2 +-
 fs/netfs/bvecq.c                       | 634 +++++++++++++++++
 fs/netfs/direct_read.c                 | 123 ++--
 fs/netfs/direct_write.c                | 313 +++++++-
 fs/netfs/fscache_io.c                  |   6 -
 fs/netfs/internal.h                    | 164 ++++-
 fs/netfs/iterator.c                    | 313 +++-----
 fs/netfs/misc.c                        | 145 +---
 fs/netfs/objects.c                     |  17 +-
 fs/netfs/read_collect.c                | 124 ++--
 fs/netfs/read_pgpriv2.c                |  68 +-
 fs/netfs/read_retry.c                  | 226 +++---
 fs/netfs/read_single.c                 | 177 +++--
 fs/netfs/rolling_buffer.c              | 222 ------
 fs/netfs/stats.c                       |   6 +-
 fs/netfs/write_collect.c               |  96 ++-
 fs/netfs/write_issue.c                 | 950 ++++++++++++++-----------
 fs/netfs/write_retry.c                 | 144 ++--
 fs/nfs/fscache.c                       |  13 +-
 fs/smb/client/cifsglob.h               |   2 +-
 fs/smb/client/cifssmb.c                |  13 +-
 fs/smb/client/file.c                   | 149 ++--
 fs/smb/client/smb2ops.c                |  78 +-
 fs/smb/client/smb2pdu.c                |  28 +-
 fs/smb/client/smbdirect.c              | 152 +---
 fs/smb/client/transport.c              |  15 +-
 include/linux/bvec.h                   |  54 ++
 include/linux/fiemap.h                 |   3 +
 include/linux/folio_queue.h            | 282 --------
 include/linux/fscache.h                |  19 +
 include/linux/iov_iter.h               |  66 +-
 include/linux/netfs.h                  | 177 +++--
 include/linux/rolling_buffer.h         |  61 --
 include/linux/uio.h                    |  17 +-
 include/trace/events/netfs.h           | 118 ++-
 lib/iov_iter.c                         | 395 +++++-----
 lib/scatterlist.c                      |  56 +-
 lib/tests/kunit_iov_iter.c             | 183 ++---
 net/9p/client.c                        |   8 +-
 56 files changed, 3815 insertions(+), 3261 deletions(-)
 delete mode 100644 Documentation/core-api/folio_queue.rst
 create mode 100644 fs/netfs/bvecq.c
 delete mode 100644 fs/netfs/rolling_buffer.c
 delete mode 100644 include/linux/folio_queue.h
 delete mode 100644 include/linux/rolling_buffer.h


