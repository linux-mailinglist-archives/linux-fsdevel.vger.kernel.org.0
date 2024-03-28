Return-Path: <linux-fsdevel+bounces-15564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2085D8905B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 17:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4DAB1F25BF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 16:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2490137C55;
	Thu, 28 Mar 2024 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+A/L5Mr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4919137C36
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643824; cv=none; b=XxUYuBvm8aYVU9u3d5C8qzf+vy4RAG2a+woA49G75Fj4a1Mh8icmWEC+C5QdkMnI3yn4uw+QXUlf2VA4tB223YkIJXUd8CdAetxvg1hgD9tGGZ9/CKfLnYP3B3aPFoQU5u8kOMrSAJpiiuG2p7XJScGW9HuBr0H/+IA8ME381ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643824; c=relaxed/simple;
	bh=PB7SnwgwSuhIThU7zY8GpB9n+FiBFKNy4XU+/XyZBBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fp4qbLcc3ndwz3HR7emPh1P3W+r52lUW4j3vVUSeeFD1MLyDQkM8rnJ+pw243bIhn/yWjQxPvdR2ZiSLXfdhHpvOyT4Q7Ne42k4qLQ8VAoHSMQilou0dimmbjWBM/WRwgyo9GnyP95QzwBG5q+uFcZ5uFb0dp/iEA7r/rf0pGnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H+A/L5Mr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=83auCTKPJvOhAjo7iO96K59ucStUj2OSCQeoe5vc/FY=;
	b=H+A/L5Mr1yZh67tOA9+1v4tcw13K/3dtAS7pRfbb13bkf4EUuOvqpuGUntSeO3uDvDFlaB
	7d+OXN8LKM9gJMR1l4Is3/mqE+SK15m/s/IN7sNqkQ68OR7qYxWxvR53VoZ3mOBHM3x/62
	/ihOBX75Kuio9J+tEix0V0uH9NtsVl8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-CkA_MFrAM2-Rxey8z_hUEw-1; Thu,
 28 Mar 2024 12:37:00 -0400
X-MC-Unique: CkA_MFrAM2-Rxey8z_hUEw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BD532824778;
	Thu, 28 Mar 2024 16:36:59 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E197CC37A83;
	Thu, 28 Mar 2024 16:36:55 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
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
	linux-kernel@vger.kernel.org,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: [PATCH 11/26] 9p: Use alternative invalidation to using launder_folio
Date: Thu, 28 Mar 2024 16:34:03 +0000
Message-ID: <20240328163424.2781320-12-dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Use writepages-based flushing invalidation instead of
invalidate_inode_pages2() and ->launder_folio().  This will allow
->launder_folio() to be removed eventually.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: v9fs@lists.linux.dev
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/9p/vfs_addr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 047855033d32..5a943c122d83 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -89,7 +89,6 @@ static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 	bool writing = (rreq->origin == NETFS_READ_FOR_WRITE ||
 			rreq->origin == NETFS_WRITEBACK ||
 			rreq->origin == NETFS_WRITETHROUGH ||
-			rreq->origin == NETFS_LAUNDER_WRITE ||
 			rreq->origin == NETFS_UNBUFFERED_WRITE ||
 			rreq->origin == NETFS_DIO_WRITE);
 
@@ -141,7 +140,6 @@ const struct address_space_operations v9fs_addr_operations = {
 	.dirty_folio		= netfs_dirty_folio,
 	.release_folio		= netfs_release_folio,
 	.invalidate_folio	= netfs_invalidate_folio,
-	.launder_folio		= netfs_launder_folio,
 	.direct_IO		= noop_direct_IO,
 	.writepages		= netfs_writepages,
 };


