Return-Path: <linux-fsdevel+bounces-22008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27524910F1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 19:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5F12B24797
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 17:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246F51BB6B7;
	Thu, 20 Jun 2024 17:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5cg7K1m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41C01BB697
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904722; cv=none; b=K0OCmAPLJOFqGG2E0izA9qAwZkQWRJFWU/+8U1+g5Sc2+b69IJYMUQ/gKzPExRgniqvz99E2PkF2gecZ50X0p2OY8F3lyWU0gVfAhR4s8Toc/bZN/SYwJ/FtHFPqUGgNUIxvgc12Jm1whL6kyVzXtij54SOP7963zQ4bNxc6+EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904722; c=relaxed/simple;
	bh=3famu7kM0k0A3eGrbVUf0STnPIu+XHzc/yElIGrJACY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l0KE341/zX6203TT+izXuzO/SdMnpnatw+7q2/IrCvP9k7H9xBfm4DkZjOsstcquKrylS5kOShvkO0t+++aGyh33kST1KU+r7Z6kH0f3N92L4G5ypnITPaaJkiCj1ED7uAWxpplK2nCWXeTLK1we1P12PdQvDgMsuWnRTU1MjrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A5cg7K1m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718904719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A6sdkxC5Rf5cszZ1f7tlsrLiiyuGvZyUxkFS40A7f1I=;
	b=A5cg7K1msGGShLIq/ZowUoALdg8LPLgvcNFeYfakrDl61Xh/0QCi+RovQ4LS1YySOXRNuQ
	2V1/nOARRlhl7X22ngsRkzr9aghJoLkigcyClJnovBY9TVe8V1vQHj0cSA5VR61+5e1bzX
	uRVcOQsk1mUq4cEs7NVYuhQtBQh9Ya0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-OVbXt0VRPAe5lPnpjTGv9A-1; Thu,
 20 Jun 2024 13:31:53 -0400
X-MC-Unique: OVbXt0VRPAe5lPnpjTGv9A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25C6D19560AD;
	Thu, 20 Jun 2024 17:31:49 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.156])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 807EA300022B;
	Thu, 20 Jun 2024 17:31:41 +0000 (UTC)
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
Subject: [PATCH 00/17] netfs, cifs: Miscellaneous fixes and read/write improvements
Date: Thu, 20 Jun 2024 18:31:18 +0100
Message-ID: <20240620173137.610345-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Christian, Steve, Willy,

[!] NOTE: THE LAST PATCH IS INCOMPLETE AND ONLY PARTIALLY WORKS.

[!] Willy: Could you look at the sheaf-adding patch?

This set of patches includes some netfs and cifs fixes:

 (1) Make sure we set the request length when doing an unbuffered/direct
     write.  This was in v2 of the io_uring fix writethrough patch, but v1
     got merged instead.

 (2) Move CIFS_INO_MODIFIED_ATTR to netfs_inode::flags to avoid jumping
     through a function pointer just for that.

 (3) Fix a premature issuing of write ops on a partially dirty page where
     the dirty part is at the end of the page and thus may be contiguous
     with the next page.

A couple of adjustments to the /proc/fs/netfs/stats file:

 (4) All the netfs stats lines begin 'Netfs:'.  Change this to something a
     bit more useful.

 (5) Add a couple of stats counters to track the numbers of skips and waits
     on the per-inode writeback serialisation lock to make it easier to
     check for this as a source of performance loss.

Some miscellaneous bits:

 (6) Enable multipage folios in 9P.

 (7) Reduce the number of conditional branches in netfs_perform_write().

 (8) Delete some unused netfslib functions for dealing with xarrays.

 (9) In cifs, defer read completion.

(10) In cifs, only pick a channel once per read request (as per v6.9) rather
     than per-subrequest.

(11) In cifs, move the 'pid' from the subrequest to the request as it's the
     same for all.

(12) Move the max_len/max_nr_segs members from netfs_io_subrequest to
     netfs_io_request as they're only needed for one subreq at a time.

Then there's the main performance enhancing changes:

(13) Define a structure, struct sheaf, and a new iterator type, ITER_SHEAF, to
     hold a buffer as a replacement for ITER_XARRAY.  See that patch for
     questions about naming and form.

(14) Use sheaves in the write-side helpers instead of xarrays.

(15) Simplify the write-side helpers to use sheaves to skip gaps rather than
     trying to work out where gaps are.

(16) In afs, make the read subrequests asynchronous, putting them into work
     items to allow the next patch to do progressive unlocking/reading.

(17) Overhaul the read-side helpers to improve performance.  [!] NOTE: THIS IS
     INCOMPLETE!  It works for buffered read to a large extent, but not DIO
     and may not cache correctly.

David

David Howells (17):
  netfs: Fix io_uring based write-through
  netfs, cifs: Move CIFS_INO_MODIFIED_ATTR to netfs_inode
  netfs: Fix early issue of write op on partial write to folio tail
  netfs: Adjust labels in /proc/fs/netfs/stats
  netfs: Record contention stats for writeback lock
  9p: Enable multipage folios
  netfs: Reduce number of conditional branches in netfs_perform_write()
  netfs: Delete some xarray-wangling functions that aren't used
  cifs: Defer read completion
  cifs: Only pick a channel once per read request
  cifs: Move the 'pid' from the subreq to the req
  netfs: Move max_len/max_nr_segs from netfs_io_subrequest to
    netfs_io_stream
  mm: Define struct sheaf and ITER_SHEAF to handle a sequence of folios
  netfs: Use new sheaf data type and iterator instead of xarray iter
  netfs: Simplify the writeback code
  afs: Make read subreqs async
  netfs: Speed up buffered reading

 fs/9p/vfs_addr.c             |  13 +-
 fs/9p/vfs_inode.c            |   1 +
 fs/afs/file.c                |  21 +-
 fs/afs/fsclient.c            |   9 +-
 fs/afs/write.c               |   4 +-
 fs/afs/yfsclient.c           |   9 +-
 fs/cachefiles/io.c           |   5 +-
 fs/ceph/addr.c               |  72 ++---
 fs/netfs/Makefile            |   2 +-
 fs/netfs/buffered_read.c     | 510 +++++++++++++++++++++------------
 fs/netfs/buffered_write.c    | 308 ++++++++++----------
 fs/netfs/direct_read.c       |  99 ++++++-
 fs/netfs/direct_write.c      |   3 +-
 fs/netfs/internal.h          |  26 +-
 fs/netfs/io.c                | 528 +----------------------------------
 fs/netfs/iterator.c          |  50 ++++
 fs/netfs/main.c              |   7 +-
 fs/netfs/misc.c              | 115 ++++----
 fs/netfs/objects.c           |   2 +-
 fs/netfs/read_collect.c      | 450 +++++++++++++++++++++++++++++
 fs/netfs/stats.c             |  23 +-
 fs/netfs/write_collect.c     | 242 +++++-----------
 fs/netfs/write_issue.c       |  68 ++---
 fs/nfs/fscache.c             |  31 +-
 fs/nfs/fscache.h             |   7 +-
 fs/smb/client/cifsglob.h     |   4 +-
 fs/smb/client/cifssmb.c      |  14 +-
 fs/smb/client/file.c         | 109 +++-----
 fs/smb/client/smb2pdu.c      |  21 +-
 include/linux/iov_iter.h     |  57 ++++
 include/linux/netfs.h        |  29 +-
 include/linux/sheaf.h        |  83 ++++++
 include/linux/uio.h          |  11 +
 include/trace/events/netfs.h | 124 +++++---
 lib/iov_iter.c               | 222 ++++++++++++++-
 lib/kunit_iov_iter.c         | 259 +++++++++++++++++
 lib/scatterlist.c            |  69 ++++-
 37 files changed, 2251 insertions(+), 1356 deletions(-)
 create mode 100644 fs/netfs/read_collect.c
 create mode 100644 include/linux/sheaf.h


