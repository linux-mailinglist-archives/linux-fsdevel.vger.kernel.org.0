Return-Path: <linux-fsdevel+bounces-5255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8B98095F5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 23:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BFF41C20BBB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1454F603
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGCJScat"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878A447B0
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 13:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701984322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gDEVNBWkDC1KjDnrtBrbZBZNboYk+5MLxRm91IWt834=;
	b=WGCJScatj1FEL0Ax3kpzJYB2itOBTiV7pEpifee+ygNUc24yWQjMbAZgvNg3GvVUdF5dfJ
	yFKNonDe/lvlPiAjKmtRyipd86Zj3B7d2cAGRSAPdZdvTsTiIQ+YKp82Zt3KBlIXgrcy1c
	RkWNNzqBENxum19BVsA+CKfherO0Suk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-xjZJHMPbPOmQdOv-d-4Uow-1; Thu, 07 Dec 2023 16:24:13 -0500
X-MC-Unique: xjZJHMPbPOmQdOv-d-4Uow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44867101A52A;
	Thu,  7 Dec 2023 21:24:12 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9C42B1C060AF;
	Thu,  7 Dec 2023 21:24:09 +0000 (UTC)
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
	Eric Van Hensbergen <ericvh@kernel.org>,
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
Subject: [PATCH v3 35/59] netfs: Provide minimum blocksize parameter
Date: Thu,  7 Dec 2023 21:21:42 +0000
Message-ID: <20231207212206.1379128-36-dhowells@redhat.com>
In-Reply-To: <20231207212206.1379128-1-dhowells@redhat.com>
References: <20231207212206.1379128-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Add a parameter for minimum blocksize in the netfs_i_context struct.  This
can be used, for instance, to force I/O alignment for content encryption.
It also requires the use of an RMW cycle if a write we want to do doesn't
meet the block alignment requirements.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/buffered_read.c  | 26 ++++++++++++++++++++++----
 fs/netfs/buffered_write.c |  3 ++-
 fs/netfs/direct_read.c    |  3 ++-
 include/linux/netfs.h     |  2 ++
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index a59e7b2edaac..0d47e5ea6870 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -521,14 +521,26 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 	struct address_space *mapping = folio_file_mapping(folio);
 	struct netfs_inode *ctx = netfs_inode(mapping->host);
 	unsigned long long start = folio_pos(folio);
-	size_t flen = folio_size(folio);
+	unsigned long long i_size, rstart, end;
+	size_t rlen;
 	int ret;
 
-	_enter("%zx @%llx", flen, start);
+	DEFINE_READAHEAD(ractl, file, NULL, mapping, folio_index(folio));
+
+	_enter("%zx @%llx", len, start);
 
 	ret = -ENOMEM;
 
-	rreq = netfs_alloc_request(mapping, file, start, flen,
+	i_size = i_size_read(mapping->host);
+	end = round_up(start + len, 1U << ctx->min_bshift);
+	if (end > i_size) {
+		unsigned long long limit = round_up(start + len, PAGE_SIZE);
+		end = max(limit, round_up(i_size, PAGE_SIZE));
+	}
+	rstart = round_down(start, 1U << ctx->min_bshift);
+	rlen   = end - rstart;
+
+	rreq = netfs_alloc_request(mapping, file, rstart, rlen,
 				   NETFS_READ_FOR_WRITE);
 	if (IS_ERR(rreq)) {
 		ret = PTR_ERR(rreq);
@@ -542,7 +554,13 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 		goto error_put;
 
 	netfs_stat(&netfs_n_rh_write_begin);
-	trace_netfs_read(rreq, start, flen, netfs_read_trace_prefetch_for_write);
+	trace_netfs_read(rreq, rstart, rlen, netfs_read_trace_prefetch_for_write);
+
+	/* Expand the request to meet caching requirements and download
+	 * preferences.
+	 */
+	ractl._nr_pages = folio_nr_pages(folio);
+	netfs_rreq_expand(rreq, &ractl);
 
 	/* Set up the output buffer */
 	iov_iter_xarray(&rreq->iter, ITER_DEST, &mapping->i_pages,
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 42f89f8ea8af..8339e3f753af 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -80,7 +80,8 @@ static enum netfs_how_to_modify netfs_how_to_modify(struct netfs_inode *ctx,
 	if (file->f_mode & FMODE_READ)
 		return NETFS_JUST_PREFETCH;
 
-	if (netfs_is_cache_enabled(ctx))
+	if (netfs_is_cache_enabled(ctx) ||
+	    ctx->min_bshift > 0)
 		return NETFS_JUST_PREFETCH;
 
 	if (!finfo)
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index 1d26468aafd9..52ad8fa66dd5 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -185,7 +185,8 @@ static ssize_t netfs_unbuffered_read_iter_locked(struct kiocb *iocb, struct iov_
 	 * will then need to pad the request out to the minimum block size.
 	 */
 	if (test_bit(NETFS_RREQ_USE_BOUNCE_BUFFER, &rreq->flags)) {
-		start = rreq->start;
+		min_bsize = 1ULL << ctx->min_bshift;
+		start = round_down(rreq->start, min_bsize);
 		end = min_t(unsigned long long,
 			    round_up(rreq->start + rreq->len, min_bsize),
 			    ctx->remote_i_size);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index ef17d94a2fbd..69ff5d652931 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -139,6 +139,7 @@ struct netfs_inode {
 	unsigned long		flags;
 #define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
 #define NETFS_ICTX_UNBUFFERED	1		/* I/O should not use the pagecache */
+	unsigned char		min_bshift;	/* log2 min block size for bounding box or 0 */
 };
 
 /*
@@ -462,6 +463,7 @@ static inline void netfs_inode_init(struct netfs_inode *ctx,
 	ctx->ops = ops;
 	ctx->remote_i_size = i_size_read(&ctx->inode);
 	ctx->flags = 0;
+	ctx->min_bshift = 0;
 #if IS_ENABLED(CONFIG_FSCACHE)
 	ctx->cache = NULL;
 #endif


