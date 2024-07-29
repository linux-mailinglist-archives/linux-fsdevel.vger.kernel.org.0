Return-Path: <linux-fsdevel+bounces-24475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A94ED93FACF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 18:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64CD7287784
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 16:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231F617F4FF;
	Mon, 29 Jul 2024 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQUQrYPx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F88018C357
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270097; cv=none; b=jqZkbwKRTiO31B54b2AQeOXVnjS3LfouFT6RdJXJzwxpQpVWH8tLqQA6MFfJ1o7Oaqso97U51HSUYDrHya533dcqubygkYRIvZomxkZ5ph1c+S8l+FgYC7vYQbk9dHSJFeeWiwjAqpTyGqpDGdANxzlRobrIawqPU9RimHO4GRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270097; c=relaxed/simple;
	bh=6OL5PMa+SlSt8Y5zAH6A5gNRbHcRLAUcUiHqm1VY5z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqOmhpI6EBDQteIi48wXtRbrcwc8KojXWoVmTF414OdKCwHYcaTjQQjaMibzAkN+RBHCpC4QQA8GwWAMbR+RYm1acV7dRi7NCrhFoE9myEBlpXsfqQnYdheN1M22XkVODfBh0aOpcWYPPiLn526YmJov+y4B7o3gKagFoqwqJm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQUQrYPx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722270095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dPT79eRMO93ZrwuayO/GcRsT7PMF2J9kIs2W0R0Ojik=;
	b=EQUQrYPxH7HnG3Y+vkhbr0T5sj3DawoHm2h9vYCW1PbNfxatfZhqwaujj390J5ol6ayG5M
	0m/4sJ9JvQqQ1HOBfEPYMk6mv9p11PSEoMsjXNuUoTlhPEV8lqCFkFFNvNbsSgmlKrN8eY
	G+yH01wvqFBivKlWDcDSpBkX+MKtCbw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-1Lo1BiuPMUe_TUHCooMZgA-1; Mon,
 29 Jul 2024 12:21:32 -0400
X-MC-Unique: 1Lo1BiuPMUe_TUHCooMZgA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0868F1955D52;
	Mon, 29 Jul 2024 16:21:29 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.216])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 436081955D45;
	Mon, 29 Jul 2024 16:21:23 +0000 (UTC)
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
Subject: [PATCH 10/24] netfs: Set the request work function upon allocation
Date: Mon, 29 Jul 2024 17:19:39 +0100
Message-ID: <20240729162002.3436763-11-dhowells@redhat.com>
In-Reply-To: <20240729162002.3436763-1-dhowells@redhat.com>
References: <20240729162002.3436763-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Set the work function in the netfs_io_request work_struct when we allocate
the request rather than doing this later.  This reduces the number of
places we need to set it in future code.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/internal.h    | 1 +
 fs/netfs/io.c          | 4 +---
 fs/netfs/objects.c     | 9 ++++++++-
 fs/netfs/write_issue.c | 1 -
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 9e6e0e59d7e4..f2920b4ee726 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -29,6 +29,7 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 /*
  * io.c
  */
+void netfs_rreq_work(struct work_struct *work);
 int netfs_begin_read(struct netfs_io_request *rreq, bool sync);
 
 /*
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 27dbea0f3867..874bbf2386a4 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -278,7 +278,7 @@ static void netfs_rreq_assess(struct netfs_io_request *rreq, bool was_async)
 	netfs_rreq_completed(rreq, was_async);
 }
 
-static void netfs_rreq_work(struct work_struct *work)
+void netfs_rreq_work(struct work_struct *work)
 {
 	struct netfs_io_request *rreq =
 		container_of(work, struct netfs_io_request, work);
@@ -584,8 +584,6 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 	// TODO: Use bounce buffer if requested
 	rreq->io_iter = rreq->iter;
 
-	INIT_WORK(&rreq->work, netfs_rreq_work);
-
 	/* Chop the read into slices according to what the cache and the netfs
 	 * want and submit each one.
 	 */
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index f4a642727479..1dbcd7f44eca 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -52,9 +52,16 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	INIT_LIST_HEAD(&rreq->io_streams[0].subrequests);
 	INIT_LIST_HEAD(&rreq->io_streams[1].subrequests);
 	INIT_LIST_HEAD(&rreq->subrequests);
-	INIT_WORK(&rreq->work, NULL);
 	refcount_set(&rreq->ref, 1);
 
+	if (origin == NETFS_READAHEAD ||
+	    origin == NETFS_READPAGE ||
+	    origin == NETFS_READ_FOR_WRITE ||
+	    origin == NETFS_DIO_READ)
+		INIT_WORK(&rreq->work, netfs_rreq_work);
+	else
+		INIT_WORK(&rreq->work, netfs_write_collection_worker);
+
 	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
 	if (cached) {
 		__set_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags);
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 2f4f795124a8..6e835670dc58 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -107,7 +107,6 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 
 	wreq->contiguity = wreq->start;
 	wreq->cleaned_to = wreq->start;
-	INIT_WORK(&wreq->work, netfs_write_collection_worker);
 
 	wreq->io_streams[0].stream_nr		= 0;
 	wreq->io_streams[0].source		= NETFS_UPLOAD_TO_SERVER;


