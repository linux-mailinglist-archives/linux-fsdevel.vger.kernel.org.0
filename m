Return-Path: <linux-fsdevel+bounces-43949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7E6A6055B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AA993BDBBE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909731F582F;
	Thu, 13 Mar 2025 23:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Roq3HjZ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C2E1F8721
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908838; cv=none; b=B6o7piasXNYAaR9IpPoygBL4AJ/KFEY6rMGfHkKV9G9NViTtGlLFoqst5cWFXK4kcQAIo1MyOBX4yXBlbTHzwt4i+vjC6sPd94kYk/ELn0xcUBxuF1QIycnTBcVpv1CH2/qk+dCd8a0sZgzATCDrk9EEVPWfHKC45JomExo2zYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908838; c=relaxed/simple;
	bh=LXsjgeko6//eAqaEigtD+Tzc69BNzf4lhF7ByGtGZT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O4OR0TFQSMwpg8Dhd5cssb50yIdJDmt+lyyD8xEUstVEhTEJgjDueUPC7MYHuXRjOKwipbdD/yjFEZEKDmfJ628YHtGNWnDFrN8h/Q2aRT1aIjmEwnxnzjBVI22I00+l8khNX7FyoZFEWEtP90WI8WMLivAWUrxUutEBVZyB4oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Roq3HjZ2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Pt/qecAJBGqhDhSDrfXYHqZ9iuqSie8AP9R3VN/0np4=;
	b=Roq3HjZ2zPQY/QXm/Hq+BbjQ8ovKwc7kRfgr8ENi08yDwbzVltOIeI74V57mPlPDuS83H3
	QI6qKDLL1DCuahZwMdAqm0TS7MFe2t32lt69dCD570TRHmZV4MSWHLNotB926tq1Ex3exh
	MK+kMRVyr1Q7AbpXJiFBWaOd9TPWAZc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-jW-_ShucMLulKnlbNg3XyA-1; Thu,
 13 Mar 2025 19:33:51 -0400
X-MC-Unique: jW-_ShucMLulKnlbNg3XyA-1
X-Mimecast-MFC-AGG-ID: jW-_ShucMLulKnlbNg3XyA_1741908830
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00A7419560B7;
	Thu, 13 Mar 2025 23:33:50 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0BEB93003770;
	Thu, 13 Mar 2025 23:33:46 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>
Cc: David Howells <dhowells@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 00/35] ceph, rbd, netfs: Make ceph fully use netfslib
Date: Thu, 13 Mar 2025 23:32:52 +0000
Message-ID: <20250313233341.1675324-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Viacheslav, Alex,

[!] NOTE: This is a preview of a work in progress.  rbd works and ceph
    works for plain I/O, but content crypto does not.

[!] NOTE: These patches are based on some other sets of patches not
    included in this posting.  They are, however, included in the git
    branch mentioned below.

These patches do a number of things:

 (1) (Mostly) collapse the different I/O types (PAGES, PAGELIST, BVECS,
     BIO) down to a single one.

     I added a new type, ceph_databuf, to make this easier.  The page list
     is attached to that as a bio_vec[] with an iov_iter, but could also be
     some other type supported by the iov_iter.  The iov_iter defines the
     data or buffer to be used.  I have an additional iov_iter type
     implemented that allows use of a straight folio[] or page[] instead of
     a bio_vec[] that I can deploy if that proves more useful.

 (2) RBD is modified to get rid of the removed page-list types and I think
     now fully works.

 (3) Ceph is mostly converted to using netfslib.  At this point, it can do
     plain reads and writes, but content crypto in currently
     non-functional.

     Multipage folios are enabled and work (all the support for that is
     hidden inside of netfslib).

 (4) The old Ceph VFS/VM I/O API implementation is removed.  With that, as
     the code currently stands, the patches overall result in a ~2500 LoC
     reduction.  That may be reduced as some more bits need transferring
     from the old code to the new code.

The conversion isn't quite complete:

 (1) ceph_osd_linger_request::preply_pages needs switching over to a
     ceph_databuf, but I haven't yet managed to work out how the pages that
     handle_watch_notify() sticks in there come about.

 (2) I haven't altered data transmission in net/ceph/messenger*.c yet.  The
     aim is to reduce it to a single sendmsg() call for each ceph_msg_data
     struct, using the iov_iter therein.

 (3) The data reception routines in net/ceph/messenger*.c also need
     modifying to pass each ceph_msg_data::iter to recvmsg() in turn.

 (4) It might be possible to merge struct ceph_databuf into struct
     ceph_msg_data and eliminate the former.

 (5) fs/ceph/ still needs a bit more work to clean up the use of page
     arrays.

 (6) I would like to change front and middle buffers with a ceph_databuf,
     vmapping them when we need to access them.

I added a kmap_ceph_databuf_page() macro and used that to get a page and
use kmap_local_page() on it to hide the bvec[] inside to make it easier to
replace.

Anyway, if anyone has any thoughts...


I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=ceph-iter

David

David Howells (35):
  ceph: Fix incorrect flush end position calculation
  libceph: Rename alignment to offset
  libceph: Add a new data container type, ceph_databuf
  ceph: Convert ceph_mds_request::r_pagelist to a databuf
  libceph: Add functions to add ceph_databufs to requests
  rbd: Use ceph_databuf for rbd_obj_read_sync()
  libceph: Change ceph_osdc_call()'s reply to a ceph_databuf
  libceph: Unexport osd_req_op_cls_request_data_pages()
  libceph: Remove osd_req_op_cls_response_data_pages()
  libceph: Convert notify_id_pages to a ceph_databuf
  ceph: Use ceph_databuf in DIO
  libceph: Bypass the messenger-v1 Tx loop for databuf/iter data blobs
  rbd: Switch from using bvec_iter to iov_iter
  libceph: Remove bvec and bio data container types
  libceph: Make osd_req_op_cls_init() use a ceph_databuf and map it
  libceph: Convert req_page of ceph_osdc_call() to ceph_databuf
  libceph, rbd: Use ceph_databuf encoding start/stop
  libceph, rbd: Convert some page arrays to ceph_databuf
  libceph, ceph: Convert users of ceph_pagelist to ceph_databuf
  libceph: Remove ceph_pagelist
  libceph: Make notify code use ceph_databuf_enc_start/stop
  libceph, rbd: Convert ceph_osdc_notify() reply to ceph_databuf
  rbd: Use ceph_databuf_enc_start/stop()
  ceph: Make ceph_calc_file_object_mapping() return size as size_t
  ceph: Wrap POSIX_FADV_WILLNEED to get caps
  ceph: Kill ceph_rw_context
  netfs: Pass extra write context to write functions
  netfs: Adjust group handling
  netfs: Allow fs-private data to be handed through to request alloc
  netfs: Make netfs_page_mkwrite() use folio_mkwrite_check_truncate()
  netfs: Fix netfs_unbuffered_read() to return ssize_t rather than int
  netfs: Add some more RMW support for ceph
  ceph: Use netfslib [INCOMPLETE]
  ceph: Enable multipage folios for ceph files
  ceph: Remove old I/O API bits

 drivers/block/rbd.c             |  904 ++++++--------
 fs/9p/vfs_file.c                |    2 +-
 fs/afs/write.c                  |    2 +-
 fs/ceph/Makefile                |    2 +-
 fs/ceph/acl.c                   |   39 +-
 fs/ceph/addr.c                  | 2009 +------------------------------
 fs/ceph/cache.h                 |    5 +
 fs/ceph/caps.c                  |    2 +-
 fs/ceph/crypto.c                |   56 +-
 fs/ceph/file.c                  | 1810 +++-------------------------
 fs/ceph/inode.c                 |  116 +-
 fs/ceph/ioctl.c                 |    2 +-
 fs/ceph/locks.c                 |   23 +-
 fs/ceph/mds_client.c            |  134 +--
 fs/ceph/mds_client.h            |    2 +-
 fs/ceph/rdwr.c                  | 1006 ++++++++++++++++
 fs/ceph/super.h                 |   81 +-
 fs/ceph/xattr.c                 |   69 +-
 fs/netfs/buffered_read.c        |   11 +-
 fs/netfs/buffered_write.c       |   48 +-
 fs/netfs/direct_read.c          |   83 +-
 fs/netfs/direct_write.c         |    3 +-
 fs/netfs/internal.h             |   40 +-
 fs/netfs/main.c                 |    5 +-
 fs/netfs/objects.c              |    4 +
 fs/netfs/read_collect.c         |    2 +
 fs/netfs/read_pgpriv2.c         |    2 +-
 fs/netfs/read_single.c          |    2 +-
 fs/netfs/write_issue.c          |   55 +-
 fs/netfs/write_retry.c          |    5 +-
 fs/smb/client/file.c            |    4 +-
 include/linux/ceph/databuf.h    |  169 +++
 include/linux/ceph/decode.h     |    4 +-
 include/linux/ceph/libceph.h    |    3 +-
 include/linux/ceph/messenger.h  |  122 +-
 include/linux/ceph/osd_client.h |   87 +-
 include/linux/ceph/pagelist.h   |   60 -
 include/linux/ceph/striper.h    |   60 +-
 include/linux/netfs.h           |   89 +-
 include/trace/events/netfs.h    |    3 +
 net/ceph/Makefile               |    5 +-
 net/ceph/cls_lock_client.c      |  200 ++-
 net/ceph/databuf.c              |  200 +++
 net/ceph/messenger.c            |  310 +----
 net/ceph/messenger_v1.c         |   76 +-
 net/ceph/mon_client.c           |   10 +-
 net/ceph/osd_client.c           |  510 +++-----
 net/ceph/pagelist.c             |  133 --
 net/ceph/snapshot.c             |   20 +-
 net/ceph/striper.c              |   57 +-
 50 files changed, 2996 insertions(+), 5650 deletions(-)
 create mode 100644 fs/ceph/rdwr.c
 create mode 100644 include/linux/ceph/databuf.h
 delete mode 100644 include/linux/ceph/pagelist.h
 create mode 100644 net/ceph/databuf.c
 delete mode 100644 net/ceph/pagelist.c


