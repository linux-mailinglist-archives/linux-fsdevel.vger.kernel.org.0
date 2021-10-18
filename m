Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67D44320B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 16:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhJRO5c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 10:57:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32008 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232824AbhJRO53 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634568918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o6nfl69kMmp16EeJpH9ZZQJrBuBcmVbCxcE6sm4V4PM=;
        b=FKpqJgUMcekfYsp3HNe5WC6LFJiaREbdo5F8DlsEjn3bGw8G6bLSe1UA/+s9OS40e6R2Mf
        CVXno3kIcuH1Yf/dH/BB/3FR4avsGFxJXxRv96DiyC04iFOtNwRNXsORz4UYBf0Z4S5Duy
        k9r3vra2rJxoiA/mciHLuKnGlk/vOC4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-ThBoDkBXP1ukbU5pQpZ9Ww-1; Mon, 18 Oct 2021 10:55:14 -0400
X-MC-Unique: ThBoDkBXP1ukbU5pQpZ9Ww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE7BE10A8E03;
        Mon, 18 Oct 2021 14:55:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F1CC5F93B;
        Mon, 18 Oct 2021 14:55:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 17/67] fscache: Rename fscache_cookie_{get,put,see}()
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
Date:   Mon, 18 Oct 2021 15:55:08 +0100
Message-ID: <163456890801.2614702.13204479150064313791.stgit@warthog.procyon.org.uk>
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

Rename fscache_cookie_{get,put,see}() to fscache_{get,put,see}_cookie() and
make them available to cache backend modules.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/cookie.c           |   14 ++++++++------
 fs/fscache/internal.h         |    6 +-----
 fs/fscache/netfs.c            |    4 ++--
 fs/fscache/object.c           |    4 ++--
 include/linux/fscache-cache.h |    6 ++++++
 5 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 62f3a4f75bad..0dc27f82e910 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -215,7 +215,7 @@ struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *candidate)
 	}
 
 	__set_bit(FSCACHE_COOKIE_ACQUIRED, &candidate->flags);
-	fscache_cookie_get(candidate->parent, fscache_cookie_get_acquire_parent);
+	fscache_get_cookie(candidate->parent, fscache_cookie_get_acquire_parent);
 	atomic_inc(&candidate->parent->n_children);
 	hlist_bl_add_head(&candidate->hash_link, h);
 	hlist_bl_unlock(h);
@@ -232,7 +232,7 @@ struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *candidate)
 		return NULL;
 	}
 
-	fscache_cookie_get(cursor, fscache_cookie_get_reacquire);
+	fscache_get_cookie(cursor, fscache_cookie_get_reacquire);
 	hlist_bl_unlock(h);
 	return cursor;
 }
@@ -330,7 +330,7 @@ struct fscache_cookie *__fscache_acquire_cookie(
 				set_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags);
 			} else {
 				atomic_dec(&parent->n_children);
-				fscache_cookie_put(cookie,
+				fscache_put_cookie(cookie,
 						   fscache_cookie_put_acquire_nobufs);
 				fscache_stat(&fscache_n_acquires_nobufs);
 				_leave(" = NULL");
@@ -793,7 +793,7 @@ void __fscache_relinquish_cookie(struct fscache_cookie *cookie,
 	}
 
 	/* Dispose of the netfs's link to the cookie */
-	fscache_cookie_put(cookie, fscache_cookie_put_relinquish);
+	fscache_put_cookie(cookie, fscache_cookie_put_relinquish);
 
 	_leave("");
 }
@@ -818,7 +818,7 @@ static void fscache_unhash_cookie(struct fscache_cookie *cookie)
 /*
  * Drop a reference to a cookie.
  */
-void fscache_cookie_put(struct fscache_cookie *cookie,
+void fscache_put_cookie(struct fscache_cookie *cookie,
 			enum fscache_cookie_trace where)
 {
 	struct fscache_cookie *parent;
@@ -844,11 +844,12 @@ void fscache_cookie_put(struct fscache_cookie *cookie,
 
 	_leave("");
 }
+EXPORT_SYMBOL(fscache_put_cookie);
 
 /*
  * Get a reference to a cookie.
  */
-struct fscache_cookie *fscache_cookie_get(struct fscache_cookie *cookie,
+struct fscache_cookie *fscache_get_cookie(struct fscache_cookie *cookie,
 					  enum fscache_cookie_trace where)
 {
 	int ref;
@@ -857,6 +858,7 @@ struct fscache_cookie *fscache_cookie_get(struct fscache_cookie *cookie,
 	trace_fscache_cookie(cookie->debug_id, ref + 1, where);
 	return cookie;
 }
+EXPORT_SYMBOL(fscache_get_cookie);
 
 /*
  * Generate a list of extant cookies in /proc/fs/fscache/cookies
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index b8da3fe2d6f1..e78ca3151e41 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -72,12 +72,8 @@ extern struct fscache_cookie *fscache_alloc_cookie(struct fscache_cookie *,
 						   const void *, size_t,
 						   loff_t);
 extern struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *);
-extern struct fscache_cookie *fscache_cookie_get(struct fscache_cookie *,
-						 enum fscache_cookie_trace);
-extern void fscache_cookie_put(struct fscache_cookie *,
-			       enum fscache_cookie_trace);
 
-static inline void fscache_cookie_see(struct fscache_cookie *cookie,
+static inline void fscache_see_cookie(struct fscache_cookie *cookie,
 				      enum fscache_cookie_trace where)
 {
 	trace_fscache_cookie(cookie->debug_id, refcount_read(&cookie->ref),
diff --git a/fs/fscache/netfs.c b/fs/fscache/netfs.c
index 8b0f303a7715..d746365f1daf 100644
--- a/fs/fscache/netfs.c
+++ b/fs/fscache/netfs.c
@@ -43,7 +43,7 @@ int __fscache_register_netfs(struct fscache_netfs *netfs)
 		fscache_free_cookie(candidate);
 	}
 
-	fscache_cookie_get(cookie->parent, fscache_cookie_get_register_netfs);
+	fscache_get_cookie(cookie->parent, fscache_cookie_get_register_netfs);
 	atomic_inc(&cookie->parent->n_children);
 
 	netfs->primary_index = cookie;
@@ -54,7 +54,7 @@ int __fscache_register_netfs(struct fscache_netfs *netfs)
 	return 0;
 
 already_registered:
-	fscache_cookie_put(candidate, fscache_cookie_put_dup_netfs);
+	fscache_put_cookie(candidate, fscache_cookie_put_dup_netfs);
 	_leave(" = -EEXIST");
 	return -EEXIST;
 }
diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index c7fbdcf3e987..761d6dc4aa0f 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -316,7 +316,7 @@ void fscache_object_init(struct fscache_object *object,
 	object->events = 0;
 	object->cache = cache;
 	object->cookie = cookie;
-	fscache_cookie_get(cookie, fscache_cookie_get_attach_object);
+	fscache_get_cookie(cookie, fscache_cookie_get_attach_object);
 	object->parent = NULL;
 #ifdef CONFIG_FSCACHE_OBJECT_LIST
 	RB_CLEAR_NODE(&object->objlist_link);
@@ -769,7 +769,7 @@ static void fscache_put_object(struct fscache_object *object,
 void fscache_object_destroy(struct fscache_object *object)
 {
 	/* We can get rid of the cookie now */
-	fscache_cookie_put(object->cookie, fscache_cookie_put_object);
+	fscache_put_cookie(object->cookie, fscache_cookie_put_object);
 	object->cookie = NULL;
 }
 EXPORT_SYMBOL(fscache_object_destroy);
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index c5d454f340c6..0439dc3021c7 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -23,6 +23,7 @@
 struct fscache_cache;
 struct fscache_cache_ops;
 struct fscache_object;
+enum fscache_cookie_trace;
 
 enum fscache_obj_ref_trace {
 	fscache_obj_get_add_to_deps,
@@ -325,6 +326,11 @@ enum fscache_why_object_killed {
 extern void fscache_object_mark_killed(struct fscache_object *object,
 				       enum fscache_why_object_killed why);
 
+extern struct fscache_cookie *fscache_get_cookie(struct fscache_cookie *cookie,
+						 enum fscache_cookie_trace where);
+extern void fscache_put_cookie(struct fscache_cookie *cookie,
+			       enum fscache_cookie_trace where);
+
 /*
  * Find the key on a cookie.
  */


