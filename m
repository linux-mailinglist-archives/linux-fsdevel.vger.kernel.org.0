Return-Path: <linux-fsdevel+bounces-18341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDAC8B789A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 16:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CBE9B2564A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 14:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4191C68A3;
	Tue, 30 Apr 2024 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G74Gue6U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8191C2300
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485788; cv=none; b=bZMM9n7G/S8HhPbBmzp3tBHH7D5ueZuTc/yKS7g37IhNwTiYWzN8yoDnDJqFbONt0RgF+RZWcjNXn4uAMr2xAmms6gNSwxHJtPYu/M3R+yhCMInsJt77gx+lUmtQFI4wZhCMapOnDBYIxujP7ETOhuqHRGVhH4XtdNmxvriZuzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485788; c=relaxed/simple;
	bh=1jcywdFFIj6PVu7haQO4pjpdjJMILtdNqUtDZkKjiFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gd8aaV2KvS712z+ygdjusIhtw23rB5OlrLaTvc7qViOm1jyph92xmVLtrNp6kGK5ktOcT1bBgEWOGF73P40yr06eMOS+b0wbRPh393diYG6DnxTwtfXo2dAEYtzlMbgR0gWpWoZJyISBmFbb0YeSZRylkSh7PJsVPEXwFAyCS2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G74Gue6U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Odg3aZxytikbkfbMJrl0CzuPexMShHC0Kl20ZMSfA0U=;
	b=G74Gue6Uuw+Hu/jtZpnDM5Jvc6iGqQaSFuZ1uzleKsmblgyjXTCDaPd4P6vXjmrys0SCvs
	qbhICtZHYM3wzR2P43QnafENeolszxPfs+uF0ajaFch+lLp1L40yK7g4GpUAr6Kg0XFkJQ
	8kRMZmtHL6BNYHeyuSl0+j2JAQtVwLo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-MRk4RIKmNLehtOWuC76kKg-1; Tue, 30 Apr 2024 10:03:00 -0400
X-MC-Unique: MRk4RIKmNLehtOWuC76kKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF5AD18065DC;
	Tue, 30 Apr 2024 14:02:19 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9AF33EC680;
	Tue, 30 Apr 2024 14:02:16 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/22] netfs, cachefiles: Implement helpers for new write code
Date: Tue, 30 Apr 2024 15:00:49 +0100
Message-ID: <20240430140056.261997-19-dhowells@redhat.com>
In-Reply-To: <20240430140056.261997-1-dhowells@redhat.com>
References: <20240430140056.261997-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Implement the helpers for the new write code in cachefiles.  There's now an
optional ->prepare_write() that allows the filesystem to set the parameters
for the next write, such as maximum size and maximum segment count, and an
->issue_write() that is called to initiate an (asynchronous) write
operation.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-erofs@lists.ozlabs.org
cc: linux-fsdevel@vger.kernel.org
---

Notes:
    Changes
    =======
    ver #2)
     - Add missing linux/bio.h for BIO_MAX_VECS.

 fs/cachefiles/io.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 5ba5c7814fe4..e667dbcd20e8 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/file.h>
 #include <linux/uio.h>
+#include <linux/bio.h>
 #include <linux/falloc.h>
 #include <linux/sched/mm.h>
 #include <trace/events/fscache.h>
@@ -622,6 +623,77 @@ static int cachefiles_prepare_write(struct netfs_cache_resources *cres,
 	return ret;
 }
 
+static void cachefiles_prepare_write_subreq(struct netfs_io_subrequest *subreq)
+{
+	struct netfs_io_request *wreq = subreq->rreq;
+	struct netfs_cache_resources *cres = &wreq->cache_resources;
+
+	_enter("W=%x[%x] %llx", wreq->debug_id, subreq->debug_index, subreq->start);
+
+	subreq->max_len = ULONG_MAX;
+	subreq->max_nr_segs = BIO_MAX_VECS;
+
+	if (!cachefiles_cres_file(cres)) {
+		if (!fscache_wait_for_operation(cres, FSCACHE_WANT_WRITE))
+			return netfs_prepare_write_failed(subreq);
+		if (!cachefiles_cres_file(cres))
+			return netfs_prepare_write_failed(subreq);
+	}
+}
+
+static void cachefiles_issue_write(struct netfs_io_subrequest *subreq)
+{
+	struct netfs_io_request *wreq = subreq->rreq;
+	struct netfs_cache_resources *cres = &wreq->cache_resources;
+	struct cachefiles_object *object = cachefiles_cres_object(cres);
+	struct cachefiles_cache *cache = object->volume->cache;
+	const struct cred *saved_cred;
+	size_t off, pre, post, len = subreq->len;
+	loff_t start = subreq->start;
+	int ret;
+
+	_enter("W=%x[%x] %llx-%llx",
+	       wreq->debug_id, subreq->debug_index, start, start + len - 1);
+
+	/* We need to start on the cache granularity boundary */
+	off = start & (CACHEFILES_DIO_BLOCK_SIZE - 1);
+	if (off) {
+		pre = CACHEFILES_DIO_BLOCK_SIZE - off;
+		if (pre >= len) {
+			netfs_write_subrequest_terminated(subreq, len, false);
+			return;
+		}
+		subreq->transferred += pre;
+		start += pre;
+		len -= pre;
+		iov_iter_advance(&subreq->io_iter, pre);
+	}
+
+	/* We also need to end on the cache granularity boundary */
+	post = len & (CACHEFILES_DIO_BLOCK_SIZE - 1);
+	if (post) {
+		len -= post;
+		if (len == 0) {
+			netfs_write_subrequest_terminated(subreq, post, false);
+			return;
+		}
+		iov_iter_truncate(&subreq->io_iter, len);
+	}
+
+	cachefiles_begin_secure(cache, &saved_cred);
+	ret = __cachefiles_prepare_write(object, cachefiles_cres_file(cres),
+					 &start, &len, len, true);
+	cachefiles_end_secure(cache, saved_cred);
+	if (ret < 0) {
+		netfs_write_subrequest_terminated(subreq, ret, false);
+		return;
+	}
+
+	cachefiles_write(&subreq->rreq->cache_resources,
+			 subreq->start, &subreq->io_iter,
+			 netfs_write_subrequest_terminated, subreq);
+}
+
 /*
  * Clean up an operation.
  */
@@ -638,8 +710,10 @@ static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
 	.end_operation		= cachefiles_end_operation,
 	.read			= cachefiles_read,
 	.write			= cachefiles_write,
+	.issue_write		= cachefiles_issue_write,
 	.prepare_read		= cachefiles_prepare_read,
 	.prepare_write		= cachefiles_prepare_write,
+	.prepare_write_subreq	= cachefiles_prepare_write_subreq,
 	.prepare_ondemand_read	= cachefiles_prepare_ondemand_read,
 	.query_occupancy	= cachefiles_query_occupancy,
 };


