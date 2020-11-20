Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94162BADF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgKTPLx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:11:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21588 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728855AbgKTPLx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:11:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605885111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eTfepikhgIgvT2tP4y4mjh64/na6GCWyLC70rjr0/iU=;
        b=Wxuezv0T+iy92ijJ7bO6JDKtxz8CrYVIPavShJeg5XsQeHSFqfGMPDH9YVTNSmBTM5MGO6
        b1W8skPuGEPozQbBkNP+As/hZqDCVSZDuMCCFshh28uHAQlISpRcJqhFOB5RRWdhdnOneK
        AbqXSOZAPDieIgGaC6BMYADdYLRHkxA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-9b4a-ez4PuKxFJsyLK5zvg-1; Fri, 20 Nov 2020 10:11:47 -0500
X-MC-Unique: 9b4a-ez4PuKxFJsyLK5zvg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D072184215C;
        Fri, 20 Nov 2020 15:11:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83D695D9D0;
        Fri, 20 Nov 2020 15:11:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 42/76] cachefiles: Shape requests from the fscache read
 helper
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:11:38 +0000
Message-ID: <160588509874.3465195.9524914912977235865.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the function that shapes read requests to map onto the granules
in a cache file.

When preparing to fetch data from the server to be cached, the request will
be expanded to align with granule size and cut down so that it doesn't
cross the boundary between a non-present granule and a present granule.

When preparing to read data from the cache, the extent will be cut down so
that it doesn't cross the boundary between a present granule and a
non-present granule.

If no caching is taking place, whatever was requested goes.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/content-map.c |  164 +++++++++++++++++++++++++++++++++++++++++++
 fs/cachefiles/interface.c   |    2 +
 fs/cachefiles/internal.h    |    4 +
 3 files changed, 170 insertions(+)

diff --git a/fs/cachefiles/content-map.c b/fs/cachefiles/content-map.c
index 68fcab313361..4ff8c645817c 100644
--- a/fs/cachefiles/content-map.c
+++ b/fs/cachefiles/content-map.c
@@ -10,6 +10,7 @@
 #include <linux/file.h>
 #include <linux/swap.h>
 #include <linux/xattr.h>
+#include <linux/netfs.h>
 #include "internal.h"
 
 static const char cachefiles_xattr_content_map[] =
@@ -40,6 +41,169 @@ static size_t cachefiles_map_size(loff_t i_size)
 	return map_size;
 }
 
+static bool cachefiles_granule_is_present(struct cachefiles_object *object,
+					  long granule)
+{
+	bool res;
+
+	if (granule / 8 >= object->content_map_size)
+		return false;
+	read_lock_bh(&object->content_map_lock);
+	res = test_bit_le(granule, object->content_map);
+	read_unlock_bh(&object->content_map_lock);
+	return res;
+}
+
+static long cachefiles_find_next_granule(struct cachefiles_object *object,
+					 long start_from, long *_limit)
+{
+	long result, limit;
+
+	read_lock_bh(&object->content_map_lock);
+	*_limit = limit = object->content_map_size * 8;
+	result = find_next_bit_le(object->content_map, limit, start_from);
+	read_unlock_bh(&object->content_map_lock);
+	return result;
+}
+
+static long cachefiles_find_next_hole(struct cachefiles_object *object,
+				      long start_from, long *_limit)
+{
+	long result, limit;
+
+	read_lock_bh(&object->content_map_lock);
+	*_limit = limit = object->content_map_size * 8;
+	result = find_next_zero_bit_le(object->content_map, limit, start_from);
+	read_unlock_bh(&object->content_map_lock);
+	return result;
+}
+
+/*
+ * Expand a readahead proposal from the VM to align with cache limits
+ * and granularity.
+ */
+void cachefiles_expand_readahead(struct fscache_op_resources *opr,
+				 loff_t *_start, size_t *_len, loff_t i_size)
+{
+	loff_t start = *_start, delta;
+	size_t len = *_len;
+
+	if (start >= CACHEFILES_SIZE_LIMIT)
+		return;
+
+	if (len > CACHEFILES_SIZE_LIMIT - start)
+		len = *_len = CACHEFILES_SIZE_LIMIT - start;
+
+	delta = start & (CACHEFILES_GRAN_SIZE - 1);
+	if (start - delta < i_size) {
+		start -= delta;
+		len = round_up(len + delta, CACHEFILES_GRAN_SIZE);
+		if (len > i_size - start) {
+			_debug("overshot eof");
+			len = i_size - start;
+		}
+	}
+
+	*_start = start;
+	*_len = len;
+}
+
+/*
+ * Prepare a I/O subrequest of a read request.  We're asked to retrieve all the
+ * remaining data in the read request, but we are allowed to shrink that and we
+ * set flags to indicate where we want it read from.
+ */
+enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subrequest *subreq,
+					       loff_t i_size)
+{
+	struct cachefiles_object *object =
+		container_of(subreq->rreq->cache_resources.object,
+			     struct cachefiles_object, fscache);
+	loff_t start = subreq->start, len = subreq->len, boundary;
+	long granule, next, limit;
+
+	_enter("%llx,%llx", start, len);
+
+	if (start >= CACHEFILES_SIZE_LIMIT) {
+		if (start >= i_size)
+			goto zero_pages_nocache;
+		goto on_server_nocache;
+	}
+	if (len > CACHEFILES_SIZE_LIMIT - start)
+		len = CACHEFILES_SIZE_LIMIT - start;
+
+	granule = start / CACHEFILES_GRAN_SIZE;
+	if (granule / 8 >= object->content_map_size) {
+		cachefiles_expand_content_map(object, i_size);
+		if (granule / 8 >= object->content_map_size)
+			goto maybe_on_server_nocache;
+	}
+
+	if (start >= i_size)
+		goto zero_pages;
+
+	if (cachefiles_granule_is_present(object, granule)) {
+		/* The start of the request is present in the cache - restrict
+		 * the length to what's available.
+		 */
+		if (start & (CACHEFILES_DIO_BLOCK_SIZE - 1)) {
+			/* We should never see DIO-unaligned requests here. */
+			WARN_ON_ONCE(1);
+			len &= CACHEFILES_DIO_BLOCK_SIZE - 1;
+			goto maybe_on_server;
+		}
+
+		next = cachefiles_find_next_hole(object, granule + 1, &limit);
+		_debug("present %lx %lx", granule, limit);
+		if (granule >= limit)
+			goto maybe_on_server;
+		boundary = next * CACHEFILES_GRAN_SIZE;
+		if (len > boundary - start)
+			len = boundary - start;
+		goto in_cache;
+	} else {
+		/* The start of the request is not present in the cache -
+		 * restrict the length to the size of the hole.
+		 */
+		next = cachefiles_find_next_granule(object, granule + 1, &limit);
+		_debug("hole %lx %lx", granule, limit);
+		if (granule >= limit)
+			goto maybe_on_server;
+		boundary = next * CACHEFILES_GRAN_SIZE;
+		if (len > boundary - start)
+			len = boundary - start;
+		goto maybe_on_server;
+	}
+
+maybe_on_server:
+	/* If the start of the request is beyond the original EOF of the file
+	 * on the server then it's not going to be found on the server.
+	 */
+	if (start >= object->fscache.cookie->zero_point)
+		goto zero_pages;
+	goto on_server;
+maybe_on_server_nocache:
+	if (start >= object->fscache.cookie->zero_point)
+		goto zero_pages_nocache;
+	goto on_server_nocache;
+on_server:
+	__set_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
+on_server_nocache:
+	subreq->len = len;
+	_leave(" = down %llx", len);
+	return NETFS_DOWNLOAD_FROM_SERVER;
+zero_pages:
+	__set_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
+zero_pages_nocache:
+	subreq->len = len;
+	_leave(" = zero %llx", len);
+	return NETFS_FILL_WITH_ZEROES;
+in_cache:
+	subreq->len = len;
+	_leave(" = read %llx", len);
+	return NETFS_READ_FROM_CACHE;
+}
+
 /*
  * Mark the content map to indicate stored granule.
  */
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 1d06cf72eeb0..a20917cb4667 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -462,6 +462,8 @@ static const struct fscache_op_ops cachefiles_io_ops = {
 	.end_operation		= __fscache_end_operation,
 	.read			= cachefiles_read,
 	.write			= cachefiles_write,
+	.expand_readahead	= cachefiles_expand_readahead,
+	.prepare_read		= cachefiles_prepare_read,
 };
 
 static void cachefiles_begin_operation(struct fscache_op_resources *opr)
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index e065550a4bc0..e9f45d5053b1 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -125,6 +125,10 @@ extern void cachefiles_daemon_unbind(struct cachefiles_cache *cache);
 /*
  * content-map.c
  */
+extern void cachefiles_expand_readahead(struct fscache_op_resources *opr,
+					loff_t *_start, size_t *_len, loff_t i_size);
+extern enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subrequest *subreq,
+						      loff_t i_size);
 extern void cachefiles_mark_content_map(struct cachefiles_object *object,
 					loff_t start, loff_t len);
 extern void cachefiles_expand_content_map(struct cachefiles_object *object, loff_t size);


