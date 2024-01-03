Return-Path: <linux-fsdevel+bounces-7232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB8B822FFF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 16:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D53C2861C5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 15:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC491A730;
	Wed,  3 Jan 2024 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AV+D26VQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7821A713
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704293987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s3o3MrTd6nm5lawOB5Ax6jA2uuGzy36Eef5IBUe+5HY=;
	b=AV+D26VQILz2cOKMwox8g/2mhcRPhHN01nFPa87LciragtVm7beV/Cb+82LXtZIJUo+mWR
	Ti/UTs06ne1ObFBUECvgj4yAZnHFrHQipXq/CZc7ug1rKT9XXGNUKbD+p5NbRXwYGT/TP9
	YsV63Pj61e2sdL6D7/GQHPGm9nKgznY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-3VxcmtpCOkq8GL6PiBMlJQ-1; Wed, 03 Jan 2024 09:59:43 -0500
X-MC-Unique: 3VxcmtpCOkq8GL6PiBMlJQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F93C83B821;
	Wed,  3 Jan 2024 14:59:42 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.68])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 24175C15A0C;
	Wed,  3 Jan 2024 14:59:37 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	linux-cachefs@redhat.com,
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
Subject: [PATCH 0/5] netfs, cachefiles, 9p: Additional patches
Date: Wed,  3 Jan 2024 14:59:24 +0000
Message-ID: <20240103145935.384404-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Hi Christian, Jeff, Gao, Dominique,

Here are some additional patches for my netfs-lib tree:

 (1) Fix __cachefiles_prepare_write() to correctly validate against the DIO
     alignment.

 (2) 9p: Fix initialisation of the netfs_inode so that i_size is set before
     netfs_inode_init() is called.

 (3) 9p: Do a couple of cleanups (remove a couple of unused vars and turn a
     BUG_ON() into a warning).

 (4) 9p: Always update remote_i_size, even if we're asked not to update
     i_size in stat2inode.

 (5) 9p: Return the amount written in preference to an error if we wrote
     something.

David

The netfslib postings:
Link: https://lore.kernel.org/r/20231013160423.2218093-1-dhowells@redhat.com/ # v1
Link: https://lore.kernel.org/r/20231117211544.1740466-1-dhowells@redhat.com/ # v2
Link: https://lore.kernel.org/r/20231207212206.1379128-1-dhowells@redhat.com/ # v3
Link: https://lore.kernel.org/r/20231213152350.431591-1-dhowells@redhat.com/ # v4
Link: https://lore.kernel.org/r/20231221132400.1601991-1-dhowells@redhat.com/ # v5

David Howells (5):
  cachefiles: Fix __cachefiles_prepare_write()
  9p: Fix initialisation of netfs_inode for 9p
  9p: Do a couple of cleanups
  9p: Always update remote_i_size in stat2inode
  9p: Use length of data written to the server in preference to error

 fs/9p/v9fs_vfs.h       |  1 +
 fs/9p/vfs_addr.c       | 24 ++++++++++++------------
 fs/9p/vfs_inode.c      |  6 +++---
 fs/9p/vfs_inode_dotl.c |  7 ++++---
 fs/cachefiles/io.c     | 28 +++++++++++++++++-----------
 5 files changed, 37 insertions(+), 29 deletions(-)


