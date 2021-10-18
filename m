Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2BF43216F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbhJRPDF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:03:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44169 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233278AbhJRPC7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=De0jqwH/v0yTKtY0BasvsuLkI5xzm/i5IM30qZPwEs0=;
        b=AHap5TL0Uakr/QG3+xNH5cmZ8fI462wxLjK38nDBz5PyEZ9CgsG3VJ7CktT5aXSnAfneZq
        YVuqwHhes46m6J96D71fEU7j5ijDMS3cqrckKu+tPCGz3dYvRpSNK2z8FpjDmaGpj8B5uy
        vzfx6PF9RgKIIEjcHfMv5nhQ/KcIHcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-oRDe2hXsMXKdtd5p2LIFWw-1; Mon, 18 Oct 2021 11:00:44 -0400
X-MC-Unique: oRDe2hXsMXKdtd5p2LIFWw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 228148042E1;
        Mon, 18 Oct 2021 15:00:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D793660BF4;
        Mon, 18 Oct 2021 15:00:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 39/67] fscache: Note the object size during invalidation
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
Date:   Mon, 18 Oct 2021 16:00:37 +0100
Message-ID: <163456923795.2614702.17791069992979263352.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Note the size of the cache object during invalidation.  For AFS, we set
this to the file size when invalidating a file due to third-party
interference.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/inode.c          |    2 +-
 fs/fscache/cookie.c     |    3 ++-
 include/linux/fscache.h |    7 ++++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index c2f4afff9837..c21c1352b149 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -565,7 +565,7 @@ static void afs_zap_data(struct afs_vnode *vnode)
 	_enter("{%llx:%llu}", vnode->fid.vid, vnode->fid.vnode);
 
 #ifdef CONFIG_AFS_FSCACHE
-	fscache_invalidate(vnode->cache);
+	fscache_invalidate(vnode->cache, i_size_read(&vnode->vfs_inode));
 #endif
 
 	/* nuke all the non-dirty pages that aren't locked, mapped or being
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 94976f90dc71..6b49c2321256 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -704,7 +704,7 @@ static void fscache_invalidate_cookie(struct fscache_cookie *cookie)
 /*
  * Invalidate an object.  Callable with spinlocks held.
  */
-void __fscache_invalidate(struct fscache_cookie *cookie)
+void __fscache_invalidate(struct fscache_cookie *cookie, loff_t new_size)
 {
 	bool is_caching;
 
@@ -718,6 +718,7 @@ void __fscache_invalidate(struct fscache_cookie *cookie)
 
 	spin_lock(&cookie->lock);
 	set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
+	cookie->object_size = new_size;
 	cookie->inval_counter++;
 
 	switch (cookie->stage) {
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 41e579ff65ee..fa7eef2674bf 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -159,7 +159,7 @@ extern struct fscache_cookie *__fscache_acquire_cookie(
 extern void __fscache_use_cookie(struct fscache_cookie *, bool);
 extern void __fscache_unuse_cookie(struct fscache_cookie *, const void *, const loff_t *);
 extern void __fscache_relinquish_cookie(struct fscache_cookie *, bool);
-extern void __fscache_invalidate(struct fscache_cookie *);
+extern void __fscache_invalidate(struct fscache_cookie *, loff_t);
 #ifdef FSCACHE_USE_NEW_IO_API
 extern int __fscache_begin_read_operation(struct netfs_cache_resources *, struct fscache_cookie *);
 #endif
@@ -388,6 +388,7 @@ void fscache_unpin_cookie(struct fscache_cookie *cookie)
 /**
  * fscache_invalidate - Notify cache that an object needs invalidation
  * @cookie: The cookie representing the cache object
+ * @size: The revised size of the object.
  *
  * Notify the cache that an object is needs to be invalidated and that it
  * should abort any retrievals or stores it is doing on the cache.  The object
@@ -399,10 +400,10 @@ void fscache_unpin_cookie(struct fscache_cookie *cookie)
  * description.
  */
 static inline
-void fscache_invalidate(struct fscache_cookie *cookie)
+void fscache_invalidate(struct fscache_cookie *cookie, loff_t size)
 {
 	if (fscache_cookie_valid(cookie))
-		__fscache_invalidate(cookie);
+		__fscache_invalidate(cookie, size);
 }
 
 /**


