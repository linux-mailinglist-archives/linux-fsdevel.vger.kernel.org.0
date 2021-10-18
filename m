Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC1743219F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbhJRPFP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:05:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35481 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232619AbhJRPEl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fCVZMS1f+Fc9xqMTz/jhF/KB+eLizY8P0By1uDIP188=;
        b=jOOinz16A4i5vITm/L7/RquSWmmO8L4CaB6CNbZ7B8qRmubgZ9xAaxY6lgaHLt7UN93286
        WtJ6qXVwJanGhi1PH3zuTNmqD4s/3dQVDTwfpfv5V3+/5X56xWa+CkbYdaSing4uWJs0Wq
        U+ABZ0u2rRujya96LACQChhI34jLhLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-Ul4T-zXEPGq-sz71ZmwD3g-1; Mon, 18 Oct 2021 11:02:24 -0400
X-MC-Unique: Ul4T-zXEPGq-sz71ZmwD3g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA8E3100CCC0;
        Mon, 18 Oct 2021 15:02:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE7D74DA31;
        Mon, 18 Oct 2021 15:02:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 48/67] fscache: Implement "will_modify" parameter on
 fscache_use_cookie()
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
Date:   Mon, 18 Oct 2021 16:02:14 +0100
Message-ID: <163456933400.2614702.3593094196519659430.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the "will_modify" parameter passed to fscache_use_cookie().

Setting this to true will henceforth cause the affected object to be marked
as dirty on disk, subject to conflict resolution in the event that power
failure or a crash occurs or the filesystem operates in disconnected mode.

The dirty flag is removed when the cache object is discarded from memory.

A cache hook is provided to prepare for writing - and this can be used to
mark the object on disk.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/interface.c         |    3 +++
 fs/cachefiles/internal.h          |    2 +-
 fs/cachefiles/xattr.c             |   20 ++++++++++++++++++++
 fs/fscache/cookie.c               |   30 +++++++++++++++++++++++++++++-
 include/linux/fscache-cache.h     |    3 +++
 include/linux/fscache.h           |    2 ++
 include/trace/events/cachefiles.h |    4 ++--
 7 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 751b0fec4591..96f30eba585a 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -211,6 +211,8 @@ static void cachefiles_commit_object(struct cachefiles_object *object,
 {
 	bool update = false;
 
+	if (test_and_clear_bit(FSCACHE_COOKIE_LOCAL_WRITE, &object->cookie->flags))
+		update = true;
 	if (test_and_clear_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &object->cookie->flags))
 		update = true;
 	if (update)
@@ -461,4 +463,5 @@ const struct fscache_cache_ops cachefiles_cache_ops = {
 	.invalidate_cookie	= cachefiles_invalidate_cookie,
 	.resize_cookie		= cachefiles_resize_cookie,
 	.begin_operation	= cachefiles_begin_operation,
+	.prepare_to_write	= cachefiles_prepare_to_write,
 };
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 1d3e37bca087..83cf2ca3a763 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -239,7 +239,7 @@ extern int cachefiles_check_auxdata(struct cachefiles_object *object,
 				    struct file *file);
 extern int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
 					  struct dentry *dentry);
-
+extern void cachefiles_prepare_to_write(struct fscache_cookie *cookie);
 
 /*
  * error handling
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index ba3d050a5174..30adca42883b 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -53,6 +53,8 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
 	buf->zero_point		= 0;
 	buf->type		= CACHEFILES_COOKIE_TYPE_DATA;
 	buf->content		= object->content_info;
+	if (test_bit(FSCACHE_COOKIE_LOCAL_WRITE, &object->cookie->flags))
+		buf->content	= CACHEFILES_CONTENT_DIRTY;
 	if (len > 0)
 		memcpy(buf->data, fscache_get_aux(object->cookie), len);
 
@@ -145,3 +147,21 @@ int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
 	_leave(" = %d", ret);
 	return ret;
 }
+
+/*
+ * Stick a marker on the cache object to indicate that it's dirty.
+ */
+void cachefiles_prepare_to_write(struct fscache_cookie *cookie)
+{
+	const struct cred *saved_cred;
+	struct cachefiles_object *object = cookie->cache_priv;
+	struct cachefiles_cache *cache = object->volume->cache;
+
+	_enter("c=%08x", object->cookie->debug_id);
+
+	if (!test_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags)) {
+		cachefiles_begin_secure(cache, &saved_cred);
+		cachefiles_set_object_xattr(object);
+		cachefiles_end_secure(cache, saved_cred);
+	}
+}
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 70bfbd269652..1420027cfe97 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -402,12 +402,20 @@ struct fscache_cookie *__fscache_acquire_cookie(
 }
 EXPORT_SYMBOL(__fscache_acquire_cookie);
 
+/*
+ * Prepare a cache object to be written to.
+ */
+static void fscache_prepare_to_write(struct fscache_cookie *cookie)
+{
+	cookie->volume->cache->ops->prepare_to_write(cookie);
+}
+
 /*
  * Look up a cookie to the cache.
  */
 static void fscache_lookup_cookie(struct fscache_cookie *cookie)
 {
-	bool changed_stage = false, need_withdraw = false;
+	bool changed_stage = false, need_withdraw = false, prep_write = false;
 
 	_enter("");
 
@@ -429,6 +437,7 @@ static void fscache_lookup_cookie(struct fscache_cookie *cookie)
 
 	spin_lock(&cookie->lock);
 	if (cookie->stage != FSCACHE_COOKIE_STAGE_RELINQUISHING) {
+		prep_write = test_bit(FSCACHE_COOKIE_LOCAL_WRITE, &cookie->flags);
 		__fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_ACTIVE);
 		fscache_see_cookie(cookie, fscache_cookie_see_active);
 		changed_stage = true;
@@ -436,6 +445,8 @@ static void fscache_lookup_cookie(struct fscache_cookie *cookie)
 	spin_unlock(&cookie->lock);
 	if (changed_stage)
 		wake_up_cookie_stage(cookie);
+	if (prep_write)
+		fscache_prepare_to_write(cookie);
 
 out:
 	fscache_end_cookie_access(cookie, fscache_access_lookup_cookie_end);
@@ -467,6 +478,10 @@ void __fscache_use_cookie(struct fscache_cookie *cookie, bool will_modify)
 	stage = cookie->stage;
 	switch (stage) {
 	case FSCACHE_COOKIE_STAGE_QUIESCENT:
+		if (will_modify) {
+			set_bit(FSCACHE_COOKIE_LOCAL_WRITE, &cookie->flags);
+			set_bit(FSCACHE_COOKIE_DO_PREP_TO_WRITE, &cookie->flags);
+		}
 		if (!fscache_begin_volume_access(cookie->volume,
 						 fscache_access_lookup_cookie))
 			break;
@@ -484,8 +499,18 @@ void __fscache_use_cookie(struct fscache_cookie *cookie, bool will_modify)
 
 	case FSCACHE_COOKIE_STAGE_LOOKING_UP:
 	case FSCACHE_COOKIE_STAGE_CREATING:
+		if (will_modify)
+			set_bit(FSCACHE_COOKIE_LOCAL_WRITE, &cookie->flags);
+		break;
 	case FSCACHE_COOKIE_STAGE_ACTIVE:
 	case FSCACHE_COOKIE_STAGE_INVALIDATING:
+		if (will_modify &&
+		    !test_and_set_bit(FSCACHE_COOKIE_LOCAL_WRITE, &cookie->flags)) {
+			set_bit(FSCACHE_COOKIE_DO_PREP_TO_WRITE, &cookie->flags);
+			queue = true;
+		}
+		break;
+
 	case FSCACHE_COOKIE_STAGE_FAILED:
 	case FSCACHE_COOKIE_STAGE_WITHDRAWING:
 		break;
@@ -551,6 +576,8 @@ static void __fscache_cookie_worker(struct fscache_cookie *cookie)
 again:
 	switch (READ_ONCE(cookie->stage)) {
 	case FSCACHE_COOKIE_STAGE_ACTIVE:
+		if (test_and_clear_bit(FSCACHE_COOKIE_DO_PREP_TO_WRITE, &cookie->flags))
+			fscache_prepare_to_write(cookie);
 		break;
 
 	case FSCACHE_COOKIE_STAGE_LOOKING_UP:
@@ -591,6 +618,7 @@ static void __fscache_cookie_worker(struct fscache_cookie *cookie)
 		clear_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &cookie->flags);
 		clear_bit(FSCACHE_COOKIE_DO_WITHDRAW, &cookie->flags);
 		clear_bit(FSCACHE_COOKIE_DO_COMMIT, &cookie->flags);
+		clear_bit(FSCACHE_COOKIE_DO_PREP_TO_WRITE, &cookie->flags);
 		set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
 		fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_QUIESCENT);
 		break;
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 2e7265e24df6..889ae37fae0f 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -76,6 +76,9 @@ struct fscache_cache_ops {
 	/* Begin an operation for the netfs lib */
 	bool (*begin_operation)(struct netfs_cache_resources *cres,
 				enum fscache_want_stage want_stage);
+
+	/* Prepare to write to a live cache object */
+	void (*prepare_to_write)(struct fscache_cookie *cookie);
 };
 
 static inline enum fscache_cache_state fscache_cache_state(const struct fscache_cache *cache)
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 8148193045cd..8ab691e52cc5 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -125,10 +125,12 @@ struct fscache_cookie {
 #define FSCACHE_COOKIE_NEEDS_UPDATE	4		/* T if attrs have been updated */
 #define FSCACHE_COOKIE_HAS_BEEN_CACHED	5		/* T if cookie needs withdraw-on-relinq */
 #define FSCACHE_COOKIE_DISABLED		6		/* T if cookie has been disabled */
+#define FSCACHE_COOKIE_LOCAL_WRITE	7		/* T if cookie has been modified locally */
 #define FSCACHE_COOKIE_NACC_ELEVATED	8		/* T if n_accesses is incremented */
 #define FSCACHE_COOKIE_DO_RELINQUISH	9		/* T if this cookie needs relinquishment */
 #define FSCACHE_COOKIE_DO_WITHDRAW	10		/* T if this cookie needs withdrawing */
 #define FSCACHE_COOKIE_DO_COMMIT	11		/* T if this cookie needs committing */
+#define FSCACHE_COOKIE_DO_PREP_TO_WRITE	12		/* T if cookie needs write preparation */
 
 	enum fscache_cookie_stage	stage;
 	u8				advice;		/* FSCACHE_ADV_* */
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index a7b31b248f2d..11447b20fc83 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -340,7 +340,7 @@ TRACE_EVENT(cachefiles_mark_inactive,
 TRACE_EVENT(cachefiles_coherency,
 	    TP_PROTO(struct cachefiles_object *obj,
 		     ino_t ino,
-		     int content,
+		     enum cachefiles_content content,
 		     enum cachefiles_coherency_trace why),
 
 	    TP_ARGS(obj, ino, content, why),
@@ -349,7 +349,7 @@ TRACE_EVENT(cachefiles_coherency,
 	    TP_STRUCT__entry(
 		    __field(unsigned int,			obj	)
 		    __field(enum cachefiles_coherency_trace,	why	)
-		    __field(int,				content	)
+		    __field(enum cachefiles_content,		content	)
 		    __field(u64,				ino	)
 			     ),
 


