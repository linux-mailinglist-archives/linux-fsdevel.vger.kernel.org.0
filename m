Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D55E432196
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbhJRPFG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:05:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33444 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233792AbhJRPDz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EuP1b5wi/prrLttPJMaPCO/uxdQhwIzMYqp5U826ZAY=;
        b=WWs1KaNAiw7Emwg7P5gd6MCFXT4ILwsNLmU+fe1SbGbRqBvmaBSZEZFhxK+HK5WtaM0Btn
        evjRMi9T6YK/cmpY2ZAlID2CrbtRf4W8kfiJaH4QG8Y4J7ofRlqsHCVJJqsOxQ7GwT8U5y
        QAAAEq9kmK3Gp9T0TfpVDeLMOaDTr+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-bWgVBC04P6a3jJhJWZ1_LQ-1; Mon, 18 Oct 2021 11:01:40 -0400
X-MC-Unique: bWgVBC04P6a3jJhJWZ1_LQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD1AE101AFC3;
        Mon, 18 Oct 2021 15:01:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B51751A7E9;
        Mon, 18 Oct 2021 15:01:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 44/67] fscache: disable cookie when doing an invalidation for
 DIO write
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Jeff Layton <jlayton@kernel.org>, dhowells@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
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
Date:   Mon, 18 Oct 2021 16:01:24 +0100
Message-ID: <163456928482.2614702.6139737560803005640.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

O_DIRECT I/O is probably a good indicator that we don't need to be
caching this file at the moment. Disable the cookie by treating it
as we would a NULL cookie after the invalidation completes. Reenable
when the last unuse is done.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/file.c           |    2 +-
 fs/fscache/cookie.c     |    5 +++++
 include/linux/fscache.h |   15 ++++++++++-----
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 5e29d433960d..5e674a503c1b 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -357,7 +357,7 @@ static bool afs_is_cache_enabled(struct inode *inode)
 {
 	struct fscache_cookie *cookie = afs_vnode_cache(AFS_FS_I(inode));
 
-	return fscache_cookie_valid(cookie) && cookie->cache_priv;
+	return fscache_cookie_enabled(cookie) && cookie->cache_priv;
 }
 
 static int afs_begin_cache_operation(struct netfs_read_request *rreq)
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 8731188a5ac7..70bfbd269652 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -522,6 +522,7 @@ void __fscache_unuse_cookie(struct fscache_cookie *cookie,
 		__fscache_update_cookie(cookie, aux_data, object_size);
 	cookie->unused_at = jiffies;
 	if (atomic_dec_return(&cookie->n_active) == 0) {
+		clear_bit(FSCACHE_COOKIE_DISABLED, &cookie->flags);
 		if (test_bit(FSCACHE_COOKIE_IS_CACHING, &cookie->flags)) {
 			spin_lock(&fscache_cookie_lru_lock);
 			if (list_empty(&cookie->commit_link)) {
@@ -715,6 +716,10 @@ void __fscache_invalidate(struct fscache_cookie *cookie,
 		 "Trying to invalidate relinquished cookie\n"))
 		return;
 
+	if ((flags & FSCACHE_INVAL_DIO_WRITE) &&
+	    test_and_set_bit(FSCACHE_COOKIE_DISABLED, &cookie->flags))
+		return;
+
 	spin_lock(&cookie->lock);
 	set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
 	fscache_update_aux(cookie, aux_data, &new_size);
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index a29bd81996ea..08663ad7feed 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -28,12 +28,14 @@
 #define fscache_volume_valid(volume) (volume)
 #define fscache_cookie_valid(cookie) (cookie)
 #define fscache_resources_valid(cres) ((cres)->cache_priv)
+#define fscache_cookie_enabled(cookie) (cookie && !test_bit(FSCACHE_COOKIE_DISABLED, &cookie->flags))
 #else
 #define __fscache_available (0)
 #define fscache_available() (0)
 #define fscache_volume_valid(volume) (0)
 #define fscache_cookie_valid(cookie) (0)
 #define fscache_resources_valid(cres) (false)
+#define fscache_cookie_enabled(cookie) (0)
 #endif
 
 struct fscache_cookie;
@@ -43,6 +45,8 @@ struct fscache_cookie;
 #define FSCACHE_ADV_WRITE_NOCACHE	0x02 /* Don't cache if written to locally */
 #define FSCACHE_ADV_FALLBACK_IO		0x04 /* Going to use the fallback I/O API (dangerous) */
 
+#define FSCACHE_INVAL_DIO_WRITE		0x01 /* Invalidate due to DIO write */
+
 enum fscache_want_stage {
 	FSCACHE_WANT_PARAMS,
 	FSCACHE_WANT_WRITE,
@@ -120,6 +124,7 @@ struct fscache_cookie {
 #define FSCACHE_COOKIE_NO_DATA_TO_READ	3		/* T if this cookie has nothing to read */
 #define FSCACHE_COOKIE_NEEDS_UPDATE	4		/* T if attrs have been updated */
 #define FSCACHE_COOKIE_HAS_BEEN_CACHED	5		/* T if cookie needs withdraw-on-relinq */
+#define FSCACHE_COOKIE_DISABLED		6		/* T if cookie has been disabled */
 #define FSCACHE_COOKIE_NACC_ELEVATED	8		/* T if n_accesses is incremented */
 #define FSCACHE_COOKIE_DO_RELINQUISH	9		/* T if this cookie needs relinquishment */
 #define FSCACHE_COOKIE_DO_WITHDRAW	10		/* T if this cookie needs withdrawing */
@@ -352,7 +357,7 @@ static inline
 void fscache_update_cookie(struct fscache_cookie *cookie, const void *aux_data,
 			   const loff_t *object_size)
 {
-	if (fscache_cookie_valid(cookie))
+	if (fscache_cookie_enabled(cookie))
 		__fscache_update_cookie(cookie, aux_data, object_size);
 }
 
@@ -410,7 +415,7 @@ static inline
 void fscache_invalidate(struct fscache_cookie *cookie,
 			const void *aux_data, loff_t size, unsigned int flags)
 {
-	if (fscache_cookie_valid(cookie))
+	if (fscache_cookie_enabled(cookie))
 		__fscache_invalidate(cookie, aux_data, size, flags);
 }
 
@@ -449,7 +454,7 @@ static inline
 int fscache_begin_read_operation(struct netfs_cache_resources *cres,
 				 struct fscache_cookie *cookie)
 {
-	if (fscache_cookie_valid(cookie))
+	if (fscache_cookie_enabled(cookie))
 		return __fscache_begin_read_operation(cres, cookie);
 	return -ENOBUFS;
 }
@@ -578,7 +583,7 @@ static inline void fscache_clear_inode_writeback(struct fscache_cookie *cookie,
 static inline
 int fscache_fallback_read_page(struct fscache_cookie *cookie, struct page *page)
 {
-	if (fscache_cookie_valid(cookie))
+	if (fscache_cookie_enabled(cookie))
 		return __fscache_fallback_read_page(cookie, page);
 	return -ENOBUFS;
 }
@@ -598,7 +603,7 @@ int fscache_fallback_read_page(struct fscache_cookie *cookie, struct page *page)
 static inline
 int fscache_fallback_write_page(struct fscache_cookie *cookie, struct page *page)
 {
-	if (fscache_cookie_valid(cookie))
+	if (fscache_cookie_enabled(cookie))
 		return __fscache_fallback_write_page(cookie, page);
 	return -ENOBUFS;
 }


