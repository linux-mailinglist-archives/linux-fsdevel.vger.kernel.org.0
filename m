Return-Path: <linux-fsdevel+bounces-6729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF3C81B84E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 14:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92A9284941
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B9B360B2;
	Thu, 21 Dec 2023 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWsIIR3B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C55853A14
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703165177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ewpCLWSgl3LvpkFjSwrnEn/5VMPhz2x5OBI/PxdRkZg=;
	b=iWsIIR3BW9aDwBAr/IXYXfnmNIoaSwK+/8qeBp7CnjkceedcHhL8K4eVC6vdZXGvR29dEL
	uweJ2/E0vv0lQZIwttyw5QQ0lVG1nDiKBr6Y9gyriZrqMuFm2Ll/tYF7zhMuD7V5Nlt6wh
	Ga/UqEj3tpWHJzs5QKzLpbLecsT96TI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-u8s67ptoMuuPRv2VxshyhA-1; Thu,
 21 Dec 2023 08:26:12 -0500
X-MC-Unique: u8s67ptoMuuPRv2VxshyhA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EF5A1C06528;
	Thu, 21 Dec 2023 13:26:11 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 46D122026D66;
	Thu, 21 Dec 2023 13:26:08 +0000 (UTC)
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
Subject: [PATCH v5 33/40] netfs, cachefiles: Pass upper bound length to allow expansion
Date: Thu, 21 Dec 2023 13:23:28 +0000
Message-ID: <20231221132400.1601991-34-dhowells@redhat.com>
In-Reply-To: <20231221132400.1601991-1-dhowells@redhat.com>
References: <20231221132400.1601991-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Make netfslib pass the maximum length to the ->prepare_write() op to tell
the cache how much it can expand the length of a write to.  This allows a
write to the server at the end of a file to be limited to a few bytes
whilst writing an entire block to the cache (something required by direct
I/O).

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/cachefiles/internal.h |  2 +-
 fs/cachefiles/io.c       | 10 ++++++----
 fs/cachefiles/ondemand.c |  2 +-
 fs/netfs/fscache_io.c    |  2 +-
 fs/netfs/io.c            |  2 +-
 fs/netfs/objects.c       |  1 +
 fs/netfs/output.c        | 25 ++++++++++---------------
 fs/smb/client/fscache.c  |  2 +-
 include/linux/netfs.h    |  5 +++--
 9 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 2ad58c465208..1af48d576a34 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -233,7 +233,7 @@ extern bool cachefiles_begin_operation(struct netfs_cache_resources *cres,
 				       enum fscache_want_state want_state);
 extern int __cachefiles_prepare_write(struct cachefiles_object *object,
 				      struct file *file,
-				      loff_t *_start, size_t *_len,
+				      loff_t *_start, size_t *_len, size_t upper_len,
 				      bool no_space_allocated_yet);
 extern int __cachefiles_write(struct cachefiles_object *object,
 			      struct file *file,
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 009d23cd435b..bffffedce4a9 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -518,7 +518,7 @@ cachefiles_prepare_ondemand_read(struct netfs_cache_resources *cres,
  */
 int __cachefiles_prepare_write(struct cachefiles_object *object,
 			       struct file *file,
-			       loff_t *_start, size_t *_len,
+			       loff_t *_start, size_t *_len, size_t upper_len,
 			       bool no_space_allocated_yet)
 {
 	struct cachefiles_cache *cache = object->volume->cache;
@@ -530,6 +530,8 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 	down = start - round_down(start, PAGE_SIZE);
 	*_start = start - down;
 	*_len = round_up(down + len, PAGE_SIZE);
+	if (down < start || *_len > upper_len)
+		return -ENOBUFS;
 
 	/* We need to work out whether there's sufficient disk space to perform
 	 * the write - but we can skip that check if we have space already
@@ -592,8 +594,8 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 }
 
 static int cachefiles_prepare_write(struct netfs_cache_resources *cres,
-				    loff_t *_start, size_t *_len, loff_t i_size,
-				    bool no_space_allocated_yet)
+				    loff_t *_start, size_t *_len, size_t upper_len,
+				    loff_t i_size, bool no_space_allocated_yet)
 {
 	struct cachefiles_object *object = cachefiles_cres_object(cres);
 	struct cachefiles_cache *cache = object->volume->cache;
@@ -609,7 +611,7 @@ static int cachefiles_prepare_write(struct netfs_cache_resources *cres,
 
 	cachefiles_begin_secure(cache, &saved_cred);
 	ret = __cachefiles_prepare_write(object, cachefiles_cres_file(cres),
-					 _start, _len,
+					 _start, _len, upper_len,
 					 no_space_allocated_yet);
 	cachefiles_end_secure(cache, saved_cred);
 	return ret;
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 0254ed39f68c..9301d1eb0504 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -52,7 +52,7 @@ static ssize_t cachefiles_ondemand_fd_write_iter(struct kiocb *kiocb,
 		return -ENOBUFS;
 
 	cachefiles_begin_secure(cache, &saved_cred);
-	ret = __cachefiles_prepare_write(object, file, &pos, &len, true);
+	ret = __cachefiles_prepare_write(object, file, &pos, &len, len, true);
 	cachefiles_end_secure(cache, saved_cred);
 	if (ret < 0)
 		return ret;
diff --git a/fs/netfs/fscache_io.c b/fs/netfs/fscache_io.c
index 79171a687930..ad572f7ee897 100644
--- a/fs/netfs/fscache_io.c
+++ b/fs/netfs/fscache_io.c
@@ -237,7 +237,7 @@ void __fscache_write_to_cache(struct fscache_cookie *cookie,
 				    fscache_access_io_write) < 0)
 		goto abandon_free;
 
-	ret = cres->ops->prepare_write(cres, &start, &len, i_size, false);
+	ret = cres->ops->prepare_write(cres, &start, &len, len, i_size, false);
 	if (ret < 0)
 		goto abandon_end;
 
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 01c7ff27228e..14c18be5aca0 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -199,7 +199,7 @@ static void netfs_rreq_do_write_to_cache(struct netfs_io_request *rreq)
 		}
 
 		ret = cres->ops->prepare_write(cres, &subreq->start, &subreq->len,
-					       rreq->i_size, true);
+					       subreq->len, rreq->i_size, true);
 		if (ret < 0) {
 			trace_netfs_failure(rreq, subreq, ret, netfs_fail_prepare_write);
 			trace_netfs_sreq(subreq, netfs_sreq_trace_write_skip);
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 93f1d7431199..b4e3bd836e5d 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -33,6 +33,7 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 
 	rreq->start	= start;
 	rreq->len	= len;
+	rreq->upper_len	= len;
 	rreq->origin	= origin;
 	rreq->netfs_ops	= ctx->ops;
 	rreq->mapping	= mapping;
diff --git a/fs/netfs/output.c b/fs/netfs/output.c
index 560cbcea0c0a..cc9065733b42 100644
--- a/fs/netfs/output.c
+++ b/fs/netfs/output.c
@@ -280,7 +280,7 @@ EXPORT_SYMBOL(netfs_queue_write_request);
  */
 static void netfs_set_up_write_to_cache(struct netfs_io_request *wreq)
 {
-	struct netfs_cache_resources *cres;
+	struct netfs_cache_resources *cres = &wreq->cache_resources;
 	struct netfs_io_subrequest *subreq;
 	struct netfs_inode *ctx = netfs_inode(wreq->inode);
 	struct fscache_cookie *cookie = netfs_i_cookie(ctx);
@@ -294,26 +294,21 @@ static void netfs_set_up_write_to_cache(struct netfs_io_request *wreq)
 	}
 
 	_debug("write to cache");
-	subreq = netfs_create_write_request(wreq, NETFS_WRITE_TO_CACHE, start, len,
-					    netfs_write_to_cache_op_worker);
-	if (!subreq)
+	ret = fscache_begin_write_operation(cres, cookie);
+	if (ret < 0)
 		return;
 
-	cres = &wreq->cache_resources;
-	ret = fscache_begin_read_operation(cres, cookie);
-	if (ret < 0) {
-		netfs_write_subrequest_terminated(subreq, ret, false);
+	ret = cres->ops->prepare_write(cres, &start, &len, wreq->upper_len,
+				       i_size_read(wreq->inode), true);
+	if (ret < 0)
 		return;
-	}
 
-	ret = cres->ops->prepare_write(cres, &start, &len, i_size_read(wreq->inode),
-				       true);
-	if (ret < 0) {
-		netfs_write_subrequest_terminated(subreq, ret, false);
+	subreq = netfs_create_write_request(wreq, NETFS_WRITE_TO_CACHE, start, len,
+					    netfs_write_to_cache_op_worker);
+	if (!subreq)
 		return;
-	}
 
-	netfs_queue_write_request(subreq);
+	netfs_write_to_cache_op(subreq);
 }
 
 /*
diff --git a/fs/smb/client/fscache.c b/fs/smb/client/fscache.c
index e5cad149f5a2..c4a3cb736881 100644
--- a/fs/smb/client/fscache.c
+++ b/fs/smb/client/fscache.c
@@ -180,7 +180,7 @@ static int fscache_fallback_write_pages(struct inode *inode, loff_t start, size_
 	if (ret < 0)
 		return ret;
 
-	ret = cres.ops->prepare_write(&cres, &start, &len, i_size_read(inode),
+	ret = cres.ops->prepare_write(&cres, &start, &len, len, i_size_read(inode),
 				      no_space_allocated_yet);
 	if (ret == 0)
 		ret = fscache_write(&cres, start, &iter, NULL, NULL);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index a2e53ab06a1b..506c543f6888 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -262,6 +262,7 @@ struct netfs_io_request {
 	atomic_t		nr_copy_ops;	/* Number of copy-to-cache ops in progress */
 	size_t			submitted;	/* Amount submitted for I/O so far */
 	size_t			len;		/* Length of the request */
+	size_t			upper_len;	/* Length can be extended to here */
 	size_t			transferred;	/* Amount to be indicated as transferred */
 	short			error;		/* 0 or error that occurred */
 	enum netfs_io_origin	origin;		/* Origin of the request */
@@ -358,8 +359,8 @@ struct netfs_cache_ops {
 	 * actually do.
 	 */
 	int (*prepare_write)(struct netfs_cache_resources *cres,
-			     loff_t *_start, size_t *_len, loff_t i_size,
-			     bool no_space_allocated_yet);
+			     loff_t *_start, size_t *_len, size_t upper_len,
+			     loff_t i_size, bool no_space_allocated_yet);
 
 	/* Prepare an on-demand read operation, shortening it to a cached/uncached
 	 * boundary as appropriate.


