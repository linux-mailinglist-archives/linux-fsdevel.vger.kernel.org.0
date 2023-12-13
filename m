Return-Path: <linux-fsdevel+bounces-5954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BEC8117CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56DEEB203CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9A628E20;
	Wed, 13 Dec 2023 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWp6ENr6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA4B112
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 07:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702482110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2oFktIEULbAkj5jUdPt4Q3ozrAu4q3Ve4X5/zahl/is=;
	b=TWp6ENr6RG7nLTTvsE0p+jz5SHqpRkBZXhS8Nu4sCtW1eDAnjAV++FYLKyJxo4tnq1wPrX
	HhOHdRp3qktsrZutXTtuI0UpCa7i40ZgfwAbl8SBHnL+yh6vutNoik4s0oshohAWRwnP4d
	Q5aeslDmdB9Zz2xv0xTFvJ847aT4IKw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-_phzeTv5PSOOLdSf851ClQ-1; Wed, 13 Dec 2023 10:41:47 -0500
X-MC-Unique: _phzeTv5PSOOLdSf851ClQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2FEF101A551;
	Wed, 13 Dec 2023 15:41:45 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3BC0EC15968;
	Wed, 13 Dec 2023 15:41:43 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Christian Brauner <christian@brauner.io>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/13] netfs, cifs: Delegate high-level I/O to netfslib
Date: Wed, 13 Dec 2023 15:41:26 +0000
Message-ID: <20231213154139.432922-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Hi Steve,

Here are patches to convert cifs to use my netfslib helpers.  With this I can
run a certain amount of xfstests on CIFS, though I'm running into occasional
ksmbd issues and not all the tests work correctly because of fallocate issues.

The patches remove around 2000 lines from CIFS

This stacks on top of my netfs-lib branch[1].

CIFS notes:

 (1) CIFS is made to use unbuffered I/O for unbuffered caching modes and
     write-through caching for cache=strict.

 (2) Various cifs fallocate() function implementations needed fixing and
     those fixes are upstream or on the way.

 (3) It should be possible to turn on multipage folio support in CIFS now.

 (4) The then-unused CIFS code is removed in three patches, not one, to
     avoid the git patch generator from producing confusing patches in
     which it thinks code is being moved around rather than just being
     removed.

The patches can be found here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=cifs-netfs

Changes
=======
ver #4)
 - Slimmed down the branch:
   - Split the cifs-related patches off to a separate branch (cifs-netfs)
   - Deferred the content-encryption to the in-progress ceph changes.
   - Deferred the use-PG_writeback rather than PG_fscache patch
 - Rebased on a later linux-next with afs-rotation patches.

ver #3)
 - Moved the fscache module into netfslib to avoid export cycles.
 - Fixed a bunch of bugs.
 - Got CIFS to pass as much of xfstests as possible.
 - Added a patch to make 9P use all the helpers.
 - Added a patch to stop using PG_fscache, but rather dirty pages on
   reading and have writepages write to the cache.

ver #2)
 - Folded the addition of NETFS_RREQ_NONBLOCK/BLOCKED into first patch that
   uses them.
 - Folded addition of rsize member into first user.
 - Don't set rsize in ceph (yet) and set it in kafs to 256KiB.  cifs sets
   it dynamically.
 - Moved direct_bv next to direct_bv_count in struct netfs_io_request and
   labelled it with a __counted_by().
 - Passed flags into netfs_xa_store_and_mark() rather than two bools.
 - Removed netfs_set_up_buffer() as it wasn't used.

David

Link: https://lore.kernel.org/r/20231213152350.431591-1-dhowells@redhat.com/ [1]
Link: https://lore.kernel.org/r/20231013160423.2218093-1-dhowells@redhat.com/ # v1
Link: https://lore.kernel.org/r/20231117211544.1740466-1-dhowells@redhat.com/ # v2
Link: https://lore.kernel.org/r/20231207212206.1379128-1-dhowells@redhat.com/ # v3

David Howells (13):
  netfs: Rearrange netfs_io_subrequest to put request pointer first
  cifs: Replace cifs_readdata with a wrapper around netfs_io_subrequest
  cifs: Share server EOF pos with netfslib
  cifs: Set zero_point in the copy_file_range() and remap_file_range()
  cifs: Replace cifs_writedata with a wrapper around netfs_io_subrequest
  cifs: Use more fields from netfs_io_subrequest
  cifs: Make wait_mtu_credits take size_t args
  cifs: Implement netfslib hooks
  cifs: Move cifs_loose_read_iter() and cifs_file_write_iter() to file.c
  cifs: Cut over to using netfslib
  cifs: Remove some code that's no longer used, part 1
  cifs: Remove some code that's no longer used, part 2
  cifs: Remove some code that's no longer used, part 3

 fs/netfs/buffered_write.c    |    3 +
 fs/netfs/io.c                |    7 +-
 fs/smb/client/Kconfig        |    1 +
 fs/smb/client/cifsfs.c       |   86 +-
 fs/smb/client/cifsfs.h       |   10 +-
 fs/smb/client/cifsglob.h     |   59 +-
 fs/smb/client/cifsproto.h    |   14 +-
 fs/smb/client/cifssmb.c      |  111 +-
 fs/smb/client/file.c         | 2908 ++++++----------------------------
 fs/smb/client/fscache.c      |  109 --
 fs/smb/client/fscache.h      |   54 -
 fs/smb/client/inode.c        |   27 +-
 fs/smb/client/smb2ops.c      |   28 +-
 fs/smb/client/smb2pdu.c      |  168 +-
 fs/smb/client/smb2proto.h    |    5 +-
 fs/smb/client/trace.h        |  144 +-
 fs/smb/client/transport.c    |   17 +-
 include/linux/netfs.h        |    3 +-
 include/trace/events/netfs.h |    1 +
 19 files changed, 883 insertions(+), 2872 deletions(-)


