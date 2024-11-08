Return-Path: <linux-fsdevel+bounces-34036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 777A39C2338
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 18:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111231F214C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 17:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345EC227BAE;
	Fri,  8 Nov 2024 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXnl7iVz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E884D227B9A
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087214; cv=none; b=gS1yw/hZe6lBlgIubk+nNZEkfqCo1OLqPPNft5QOovO6CaYKnRB0ZEnN6rfa8KRDYn0jU5aMBgoGPlUz+aU2KMMdC7YcijR4GtS77VrQfdg87IRtXUnZsNlJ1KHIE8p0Q6JrxgJiqiZcmCDcS1Uro3Wvj98okLoAcCKmPUkshk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087214; c=relaxed/simple;
	bh=UQe8ZQ4qDdUDDw8GhW5Rtv4v1nSE8XZnkM9jJJQs9Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4valzCyeY4DFvcwDm0OQTW08+WWhHJzNyq4VjaB4tDADODeUZpY4CWZ5gUKMRfpoZk8t131hwSINYKYN8Lydx23GqFybakhIBVyKxBKpf5SZYPdf6x7lB1DG/BA0JTNBU+zD8Oebb0F8twmawZX4x0Qx4NQfOYXdcNKFY2sIrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TXnl7iVz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731087212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DUlYZzbaKUHX76MZjhLNdaJFIvV/RRK5UT5LJFkHe/Y=;
	b=TXnl7iVzbN8FVpQcNNz9EoI20DyvwuxOXT+7pR/9aJIMy57b6SFzIl42Gxf91xNAU+BTwF
	l5bTrMjoG++rlpePAQ7O5KgN0Bt1e9+ZLW0cPeqKGG99pXXnIP1+/wYMXvlfvBTqHz5bPB
	N7RLgJtST1SFdmPYj51e5UOpmlzet4g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-Du4WdgOCP7qkPE5ndOmvBQ-1; Fri,
 08 Nov 2024 12:33:26 -0500
X-MC-Unique: Du4WdgOCP7qkPE5ndOmvBQ-1
X-Mimecast-MFC-AGG-ID: Du4WdgOCP7qkPE5ndOmvBQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4923B1953955;
	Fri,  8 Nov 2024 17:33:23 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA29E195E485;
	Fri,  8 Nov 2024 17:33:17 +0000 (UTC)
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
Subject: [PATCH v4 05/33] netfs: Use a folio_queue allocation and free functions
Date: Fri,  8 Nov 2024 17:32:06 +0000
Message-ID: <20241108173236.1382366-6-dhowells@redhat.com>
In-Reply-To: <20241108173236.1382366-1-dhowells@redhat.com>
References: <20241108173236.1382366-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Provide and use folio_queue allocation and free functions to combine the
allocation, initialisation and stat (un)accounting steps that are repeated
in several places.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c | 12 +++---------
 fs/netfs/misc.c          | 38 ++++++++++++++++++++++++++++++++++----
 include/linux/netfs.h    |  5 +++++
 3 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 7ac34550c403..b5a7beb9d01b 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -131,11 +131,9 @@ static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq)
 			struct folio_queue *tail = rreq->buffer_tail, *new;
 			size_t added;
 
-			new = kmalloc(sizeof(*new), GFP_NOFS);
+			new = netfs_folioq_alloc(GFP_NOFS);
 			if (!new)
 				return -ENOMEM;
-			netfs_stat(&netfs_n_folioq);
-			folioq_init(new);
 			new->prev = tail;
 			tail->next = new;
 			rreq->buffer_tail = new;
@@ -359,11 +357,9 @@ static int netfs_prime_buffer(struct netfs_io_request *rreq)
 	struct folio_batch put_batch;
 	size_t added;
 
-	folioq = kmalloc(sizeof(*folioq), GFP_KERNEL);
+	folioq = netfs_folioq_alloc(GFP_KERNEL);
 	if (!folioq)
 		return -ENOMEM;
-	netfs_stat(&netfs_n_folioq);
-	folioq_init(folioq);
 	rreq->buffer = folioq;
 	rreq->buffer_tail = folioq;
 	rreq->submitted = rreq->start;
@@ -436,12 +432,10 @@ static int netfs_create_singular_buffer(struct netfs_io_request *rreq, struct fo
 {
 	struct folio_queue *folioq;
 
-	folioq = kmalloc(sizeof(*folioq), GFP_KERNEL);
+	folioq = netfs_folioq_alloc(GFP_KERNEL);
 	if (!folioq)
 		return -ENOMEM;
 
-	netfs_stat(&netfs_n_folioq);
-	folioq_init(folioq);
 	folioq_append(folioq, folio);
 	BUG_ON(folioq_folio(folioq, 0) != folio);
 	BUG_ON(folioq_folio_order(folioq, 0) != folio_order(folio));
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 78fe5796b2b2..6cd7e1ee7a14 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -8,6 +8,38 @@
 #include <linux/swap.h>
 #include "internal.h"
 
+/**
+ * netfs_folioq_alloc - Allocate a folio_queue struct
+ * @gfp: Allocation constraints
+ *
+ * Allocate, initialise and account the folio_queue struct.
+ */
+struct folio_queue *netfs_folioq_alloc(gfp_t gfp)
+{
+	struct folio_queue *fq;
+
+	fq = kmalloc(sizeof(*fq), gfp);
+	if (fq) {
+		netfs_stat(&netfs_n_folioq);
+		folioq_init(fq);
+	}
+	return fq;
+}
+EXPORT_SYMBOL(netfs_folioq_alloc);
+
+/**
+ * netfs_folioq_free - Free a folio_queue struct
+ * @folioq: The object to free
+ *
+ * Free and unaccount the folio_queue struct.
+ */
+void netfs_folioq_free(struct folio_queue *folioq)
+{
+	netfs_stat_d(&netfs_n_folioq);
+	kfree(folioq);
+}
+EXPORT_SYMBOL(netfs_folioq_free);
+
 /*
  * Make sure there's space in the rolling queue.
  */
@@ -87,8 +119,7 @@ struct folio_queue *netfs_delete_buffer_head(struct netfs_io_request *wreq)
 
 	if (next)
 		next->prev = NULL;
-	netfs_stat_d(&netfs_n_folioq);
-	kfree(head);
+	netfs_folioq_free(head);
 	wreq->buffer = next;
 	return next;
 }
@@ -111,8 +142,7 @@ void netfs_clear_buffer(struct netfs_io_request *rreq)
 				folio_put(folio);
 			}
 		}
-		netfs_stat_d(&netfs_n_folioq);
-		kfree(p);
+		netfs_folioq_free(p);
 	}
 }
 
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 5eaceef41e6c..b2fa569e875d 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -21,6 +21,7 @@
 
 enum netfs_sreq_ref_trace;
 typedef struct mempool_s mempool_t;
+struct folio_queue;
 
 /**
  * folio_start_private_2 - Start an fscache write on a folio.  [DEPRECATED]
@@ -454,6 +455,10 @@ void netfs_end_io_write(struct inode *inode);
 int netfs_start_io_direct(struct inode *inode);
 void netfs_end_io_direct(struct inode *inode);
 
+/* Miscellaneous APIs. */
+struct folio_queue *netfs_folioq_alloc(gfp_t gfp);
+void netfs_folioq_free(struct folio_queue *folioq);
+
 /**
  * netfs_inode - Get the netfs inode context from the inode
  * @inode: The inode to query


