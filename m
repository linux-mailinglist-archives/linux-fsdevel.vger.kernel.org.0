Return-Path: <linux-fsdevel+bounces-37296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AC19F0DCF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 14:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090501884816
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 13:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE221E25EC;
	Fri, 13 Dec 2024 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="foiZoHl6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC46C186607
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097860; cv=none; b=t/YInyLz6VAY53cqDD2PrVtVCHlTZDjhO73HCuLRUHZbGOJMY87BAARj9uBQlJJI2ftkOhUM9mjJ8+6qgGVI7DC1rwaojF0+wWlCJpgZHuSvjMcn68+Fhj0EWkMsxZmz7w15bC15Oeirx9vQxHsOrBpPZvPpdafNUfnyOpIk1xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097860; c=relaxed/simple;
	bh=ee8bCaSWFbPmnDIBL40JFQm2oyep1Gfed/yf6gabDzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWPDm2qQ45ikSFlQcr7UJgXAFFotU37E/reTxfNcrLLNTZj/H5y1PNFpSJzEt+JYHweDO0qEdW4+BseWT6MBJOEB+FFSo8TmXhlV8CN8emXj9zJBPeptfoRshK8W6KkfK7wUOD9PUMuXTEqpvGI7Aylw8JMlXzhPmLU3Ml5/lWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=foiZoHl6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734097857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5M1ENZFbO/mNMn248U1qss6F8q2hwKZC+45ijoUGNaQ=;
	b=foiZoHl6s+w6N1eckcW931PRlE0isUGUZYCXC6ElVqjGPnZk7Y8/TGgwh0fGaCWVz86FdQ
	r9k7AKwXVLMb9ecw7+hr+SsYkoMrBZqBY68fnFDduhAVnrkQVUgE7do0bXRKP8nFYUwkGT
	u8r9O1YOE80THPrjmahQ2hl4MiWe4hw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-komwBIjYNoKdH0VnGk57oA-1; Fri,
 13 Dec 2024 08:50:52 -0500
X-MC-Unique: komwBIjYNoKdH0VnGk57oA-1
X-Mimecast-MFC-AGG-ID: komwBIjYNoKdH0VnGk57oA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D61E71956056;
	Fri, 13 Dec 2024 13:50:49 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC2561956052;
	Fri, 13 Dec 2024 13:50:44 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Anna Schumaker <anna@kernel.org>,
	Dave Wysochanski <dwysocha@redhat.com>
Subject: [PATCH 04/10] nfs: Fix oops in nfs_netfs_init_request() when copying to cache
Date: Fri, 13 Dec 2024 13:50:04 +0000
Message-ID: <20241213135013.2964079-5-dhowells@redhat.com>
In-Reply-To: <20241213135013.2964079-1-dhowells@redhat.com>
References: <20241213135013.2964079-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When netfslib wants to copy some data that has just been read on behalf of
nfs, it creates a new write request and calls nfs_netfs_init_request() to
initialise it, but with a NULL file pointer.  This causes
nfs_file_open_context() to oops - however, we don't actually need the nfs
context as we're only going to write to the cache.

Fix this by just returning if we aren't given a file pointer and emit a
warning if the request was for something other than copy-to-cache.

Further, fix nfs_netfs_free_request() so that it doesn't try to free the
context if the pointer is NULL.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Reported-by: Max Kellermann <max.kellermann@ionos.com>
Closes: https://lore.kernel.org/r/CAKPOu+9DyMbKLhyJb7aMLDTb=Fh0T8Teb9sjuf_pze+XWT1VaQ@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Trond Myklebust <trondmy@kernel.org>
cc: Anna Schumaker <anna@kernel.org>
cc: Dave Wysochanski <dwysocha@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-nfs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/nfs/fscache.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 810269ee0a50..d49e4ce27999 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -263,6 +263,12 @@ int nfs_netfs_readahead(struct readahead_control *ractl)
 static atomic_t nfs_netfs_debug_id;
 static int nfs_netfs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
+	if (!file) {
+		if (WARN_ON_ONCE(rreq->origin != NETFS_PGPRIV2_COPY_TO_CACHE))
+			return -EIO;
+		return 0;
+	}
+
 	rreq->netfs_priv = get_nfs_open_context(nfs_file_open_context(file));
 	rreq->debug_id = atomic_inc_return(&nfs_netfs_debug_id);
 	/* [DEPRECATED] Use PG_private_2 to mark folio being written to the cache. */
@@ -274,7 +280,8 @@ static int nfs_netfs_init_request(struct netfs_io_request *rreq, struct file *fi
 
 static void nfs_netfs_free_request(struct netfs_io_request *rreq)
 {
-	put_nfs_open_context(rreq->netfs_priv);
+	if (rreq->netfs_priv)
+		put_nfs_open_context(rreq->netfs_priv);
 }
 
 static struct nfs_netfs_io_data *nfs_netfs_alloc(struct netfs_io_subrequest *sreq)


