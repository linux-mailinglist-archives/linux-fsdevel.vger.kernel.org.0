Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399374320A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 16:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbhJRO5D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 10:57:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25770 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232458AbhJRO5A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634568888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HLyJpHLHgdEk/dLhjAzTgQqnW46fpcyamO0/BfGexg0=;
        b=OtUHS+LK6MCdR7OsylDBtzpSspNoJRuAKP9ejm4jnKoZQuHCQLSnUdtIcHwDiWXQHURghp
        61cy44Bmnj9NUHAbdfh5fFwqEQOM5wehln97xA92mTBAUsMtj6Uwl7PWaSvclf5i2daccX
        HP2nQ0YeL9yrEaR/8MSvRtJEklqggsg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-4SBX_taHOHi2d4qgCr4dFg-1; Mon, 18 Oct 2021 10:54:45 -0400
X-MC-Unique: 4SBX_taHOHi2d4qgCr4dFg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F116800685;
        Mon, 18 Oct 2021 14:54:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F03675DF21;
        Mon, 18 Oct 2021 14:54:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 15/67] fscache: Disable fscache_begin_operation()
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Oct 2021 15:54:39 +0100
Message-ID: <163456887921.2614702.840718814028578881.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Disable fscache_begin_operation() so that the operation manager can be
removed and replaced.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/io.c |   13 ++++++++++++-
 fs/fscache/io.c    |    2 ++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 5ead97de4bb7..4cc57be88f37 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -271,6 +271,7 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
 static enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subrequest *subreq,
 						      loff_t i_size)
 {
+#if 0
 	struct fscache_operation *op = subreq->rreq->cache_resources.cache_priv;
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
@@ -335,6 +336,9 @@ static enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subreque
 out:
 	cachefiles_end_secure(cache, saved_cred);
 	return ret;
+#endif
+	return subreq->start >= i_size ?
+		NETFS_FILL_WITH_ZEROES : NETFS_DOWNLOAD_FROM_SERVER;
 }
 
 /*
@@ -359,6 +363,7 @@ static int cachefiles_prepare_write(struct netfs_cache_resources *cres,
 static int cachefiles_prepare_fallback_write(struct netfs_cache_resources *cres,
 					     pgoff_t index)
 {
+#if 0
 	struct fscache_operation *op = cres->cache_priv;
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
@@ -369,6 +374,8 @@ static int cachefiles_prepare_fallback_write(struct netfs_cache_resources *cres,
 	cache = container_of(object->fscache.cache,
 			     struct cachefiles_cache, cache);
 	return cachefiles_has_space(cache, 0, 1);
+#endif
+	return -ENOBUFS;
 }
 
 /*
@@ -376,6 +383,7 @@ static int cachefiles_prepare_fallback_write(struct netfs_cache_resources *cres,
  */
 static void cachefiles_end_operation(struct netfs_cache_resources *cres)
 {
+#if 0
 	struct fscache_operation *op = cres->cache_priv;
 	struct file *file = cres->cache_priv2;
 
@@ -387,8 +395,8 @@ static void cachefiles_end_operation(struct netfs_cache_resources *cres)
 		fscache_op_complete(op, false);
 		fscache_put_operation(op);
 	}
-
 	_leave("");
+#endif
 }
 
 static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
@@ -406,6 +414,7 @@ static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
 int cachefiles_begin_operation(struct netfs_cache_resources *cres,
 			       struct fscache_operation *op)
 {
+#if 0
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
 	struct path path;
@@ -441,5 +450,7 @@ int cachefiles_begin_operation(struct netfs_cache_resources *cres,
 
 error_file:
 	fput(file);
+#endif
+	cres->ops = &cachefiles_netfs_cache_ops;
 	return -EIO;
 }
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index 7ac34c2e45fe..2547892a6064 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -31,6 +31,7 @@ int __fscache_begin_operation(struct netfs_cache_resources *cres,
 			      struct fscache_cookie *cookie,
 			      bool for_write)
 {
+#if 0
 	struct fscache_operation *op;
 	struct fscache_object *object;
 	bool wake_cookie = false;
@@ -144,6 +145,7 @@ int __fscache_begin_operation(struct netfs_cache_resources *cres,
 		fscache_stat(&fscache_n_stores_nobufs);
 	else
 		fscache_stat(&fscache_n_retrievals_nobufs);
+#endif
 	_leave(" = -ENOBUFS");
 	return -ENOBUFS;
 }


