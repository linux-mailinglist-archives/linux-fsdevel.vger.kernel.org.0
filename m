Return-Path: <linux-fsdevel+bounces-3063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0687EF9D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 22:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E98B1C20AAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 21:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645C2495D2;
	Fri, 17 Nov 2023 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBWIxiEj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837A31738
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 13:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700255790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3JiidRzkKBvkLp798rxmXLVnzVJoyLEMATfdNMMsEo=;
	b=ZBWIxiEjuK7Kp+wWTCkyszX/d9uUyU4AkAJZToY4a1rHfuP8m1mP1uJjRcnfUUkY8mkpN/
	43P55sOKjke5J3+HGI1xEze2+tun2FHxBvnnEw3QMmdxKwjlmAxOC44vHvlxRomfOHYpQU
	t6E3KOlD/8ZW6+z6WCafw45dwEsfHNs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-bttf1UYjO3iFrszJ99mhvQ-1; Fri,
 17 Nov 2023 16:16:27 -0500
X-MC-Unique: bttf1UYjO3iFrszJ99mhvQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 749A628040B3;
	Fri, 17 Nov 2023 21:16:26 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CE580C15881;
	Fri, 17 Nov 2023 21:16:23 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
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
Subject: [PATCH v2 11/51] netfs: Add bounce buffering support
Date: Fri, 17 Nov 2023 21:15:03 +0000
Message-ID: <20231117211544.1740466-12-dhowells@redhat.com>
In-Reply-To: <20231117211544.1740466-1-dhowells@redhat.com>
References: <20231117211544.1740466-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Add a second xarray struct to netfs_io_request for the purposes of holding
a bounce buffer for when we have to deal with encrypted/compressed data or
if we have to up/download data in blocks larger than we were asked for.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/io.c         | 6 +++++-
 fs/netfs/objects.c    | 3 +++
 include/linux/netfs.h | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index e9d408e211b8..d8e9cd6ce338 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -643,7 +643,11 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 		return -EIO;
 	}
 
-	rreq->io_iter = rreq->iter;
+	if (test_bit(NETFS_RREQ_USE_BOUNCE_BUFFER, &rreq->flags))
+		iov_iter_xarray(&rreq->io_iter, ITER_DEST, &rreq->bounce,
+				rreq->start, rreq->len);
+	else
+		rreq->io_iter = rreq->iter;
 
 	INIT_WORK(&rreq->work, netfs_rreq_work);
 
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 4df5e5eeada6..9f3f33c93317 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -35,12 +35,14 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	rreq->inode	= inode;
 	rreq->i_size	= i_size_read(inode);
 	rreq->debug_id	= atomic_inc_return(&debug_ids);
+	xa_init(&rreq->bounce);
 	INIT_LIST_HEAD(&rreq->subrequests);
 	refcount_set(&rreq->ref, 1);
 	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
 	if (rreq->netfs_ops->init_request) {
 		ret = rreq->netfs_ops->init_request(rreq, file);
 		if (ret < 0) {
+			xa_destroy(&rreq->bounce);
 			kfree(rreq);
 			return ERR_PTR(ret);
 		}
@@ -94,6 +96,7 @@ static void netfs_free_request(struct work_struct *work)
 		}
 		kvfree(rreq->direct_bv);
 	}
+	netfs_clear_buffer(&rreq->bounce);
 	kfree_rcu(rreq, rcu);
 	netfs_stat_d(&netfs_n_rh_rreq);
 }
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 47270f5d9e89..0bc90c4035a2 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -196,6 +196,7 @@ struct netfs_io_request {
 	struct iov_iter		iter;		/* Unencrypted-side iterator */
 	struct iov_iter		io_iter;	/* I/O (Encrypted-side) iterator */
 	void			*netfs_priv;	/* Private data for the netfs */
+	struct xarray		bounce;		/* Bounce buffer (eg. for crypto/compression) */
 	struct bio_vec		*direct_bv	/* DIO buffer list (when handling iovec-iter) */
 	__counted_by(direct_bv_count);
 	unsigned int		direct_bv_count; /* Number of elements in direct_bv[] */
@@ -218,6 +219,7 @@ struct netfs_io_request {
 #define NETFS_RREQ_DONT_UNLOCK_FOLIOS	3	/* Don't unlock the folios on completion */
 #define NETFS_RREQ_FAILED		4	/* The request failed */
 #define NETFS_RREQ_IN_PROGRESS		5	/* Unlocked when the request completes */
+#define NETFS_RREQ_USE_BOUNCE_BUFFER	6	/* Use bounce buffer */
 	const struct netfs_request_ops *netfs_ops;
 };
 


