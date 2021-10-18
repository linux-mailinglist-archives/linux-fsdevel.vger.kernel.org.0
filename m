Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE69432150
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhJRPCs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:02:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56435 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233130AbhJRPCk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d1PPrqrxGOJrlgwg8gulFUWciRFXvDwTO+SwsfF1Gf8=;
        b=TzL3NXnKFFviPj6fqB5Eqh13wWEAfDDtGVVf86yjhFzf35kodNDv72HzcSyJn8jsPWaoSM
        tYzwcxkZHgHIqATluztHahsK2qP+Bmt0c0WnJOZMyjtu4tav1G+x28omFlrS3384slzf86
        MPcJVJ2OMq586dwlkdv8/HRgodadSrs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-HreReUItP1K4SxpQq7cwIA-1; Mon, 18 Oct 2021 11:00:25 -0400
X-MC-Unique: HreReUItP1K4SxpQq7cwIA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC8B6A40C3;
        Mon, 18 Oct 2021 15:00:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73D9360D30;
        Mon, 18 Oct 2021 15:00:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 37/67] fscache: Move fscache_update_cookie() complete inline
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
Date:   Mon, 18 Oct 2021 16:00:19 +0100
Message-ID: <163456921953.2614702.8851027265019457749.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


---

 fs/fscache/cookie.c           |   18 -----------------
 fs/fscache/internal.h         |   18 -----------------
 fs/fscache/stats.c            |    9 +++------
 include/linux/fscache-cache.h |   11 ----------
 include/linux/fscache.h       |   43 ++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 45 insertions(+), 54 deletions(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index c6b553609f33..94976f90dc71 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -748,24 +748,6 @@ void __fscache_invalidate(struct fscache_cookie *cookie)
 }
 EXPORT_SYMBOL(__fscache_invalidate);
 
-/*
- * Update the index entries backing a cookie.  The writeback is done lazily.
- */
-void __fscache_update_cookie(struct fscache_cookie *cookie,
-			     const void *aux_data, const loff_t *object_size)
-{
-	fscache_stat(&fscache_n_updates);
-
-	spin_lock(&cookie->lock);
-
-	fscache_update_aux(cookie, aux_data, object_size);
-	set_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &cookie->flags);
-
-	spin_unlock(&cookie->lock);
-	_leave("");
-}
-EXPORT_SYMBOL(__fscache_update_cookie);
-
 /*
  * Remove a cookie from the hash table.
  */
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 62e6a5bbef8e..1cb1effa7cba 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -107,10 +107,6 @@ extern atomic_t fscache_n_acquires_oom;
 extern atomic_t fscache_n_invalidates;
 extern atomic_t fscache_n_invalidates_run;
 
-extern atomic_t fscache_n_updates;
-extern atomic_t fscache_n_updates_null;
-extern atomic_t fscache_n_updates_run;
-
 extern atomic_t fscache_n_relinquishes;
 extern atomic_t fscache_n_relinquishes_null;
 extern atomic_t fscache_n_relinquishes_retire;
@@ -152,20 +148,6 @@ bool fscache_begin_volume_access(struct fscache_volume *volume,
 				 enum fscache_access_trace why);
 void fscache_create_volume(struct fscache_volume *volume, bool wait);
 
-/*
- * Update the auxiliary data on a cookie.
- */
-static inline
-void fscache_update_aux(struct fscache_cookie *cookie,
-			const void *aux_data, const loff_t *object_size)
-{
-	void *p = fscache_get_aux(cookie);
-
-	if (aux_data && p)
-		memcpy(p, aux_data, cookie->aux_len);
-	if (object_size)
-		cookie->object_size = *object_size;
-}
 
 /*****************************************************************************/
 /*
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
index 5700e5712018..a16473df8be0 100644
--- a/fs/fscache/stats.c
+++ b/fs/fscache/stats.c
@@ -55,8 +55,7 @@ atomic_t fscache_n_invalidates;
 atomic_t fscache_n_invalidates_run;
 
 atomic_t fscache_n_updates;
-atomic_t fscache_n_updates_null;
-atomic_t fscache_n_updates_run;
+EXPORT_SYMBOL(fscache_n_updates);
 
 atomic_t fscache_n_relinquishes;
 atomic_t fscache_n_relinquishes_null;
@@ -105,10 +104,8 @@ int fscache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&fscache_n_invalidates),
 		   atomic_read(&fscache_n_invalidates_run));
 
-	seq_printf(m, "Updates: n=%u nul=%u run=%u\n",
-		   atomic_read(&fscache_n_updates),
-		   atomic_read(&fscache_n_updates_null),
-		   atomic_read(&fscache_n_updates_run));
+	seq_printf(m, "Updates: n=%u\n",
+		   atomic_read(&fscache_n_updates));
 
 	seq_printf(m, "Relinqs: n=%u rtr=%u drop=%u\n",
 		   atomic_read(&fscache_n_relinquishes),
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 657e54b4cd90..bf0d3e862915 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -139,17 +139,6 @@ static inline void *fscache_get_key(struct fscache_cookie *cookie)
 		return cookie->key;
 }
 
-/*
- * Find the auxiliary data on a cookie.
- */
-static inline void *fscache_get_aux(struct fscache_cookie *cookie)
-{
-	if (cookie->aux_len <= sizeof(cookie->inline_aux))
-		return cookie->inline_aux;
-	else
-		return cookie->aux;
-}
-
 /**
  * fscache_cookie_lookup_negative - Note negative lookup
  * @cookie: The cookie that was being looked up
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index c6ee09661351..41e579ff65ee 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -159,7 +159,6 @@ extern struct fscache_cookie *__fscache_acquire_cookie(
 extern void __fscache_use_cookie(struct fscache_cookie *, bool);
 extern void __fscache_unuse_cookie(struct fscache_cookie *, const void *, const loff_t *);
 extern void __fscache_relinquish_cookie(struct fscache_cookie *, bool);
-extern void __fscache_update_cookie(struct fscache_cookie *, const void *, const loff_t *);
 extern void __fscache_invalidate(struct fscache_cookie *);
 #ifdef FSCACHE_USE_NEW_IO_API
 extern int __fscache_begin_read_operation(struct netfs_cache_resources *, struct fscache_cookie *);
@@ -293,6 +292,48 @@ void fscache_relinquish_cookie(struct fscache_cookie *cookie, bool retire)
 		__fscache_relinquish_cookie(cookie, retire);
 }
 
+/*
+ * Find the auxiliary data on a cookie.
+ */
+static inline void *fscache_get_aux(struct fscache_cookie *cookie)
+{
+	if (cookie->aux_len <= sizeof(cookie->inline_aux))
+		return cookie->inline_aux;
+	else
+		return cookie->aux;
+}
+
+/*
+ * Update the auxiliary data on a cookie.
+ */
+static inline
+void fscache_update_aux(struct fscache_cookie *cookie,
+			const void *aux_data, const loff_t *object_size)
+{
+	void *p = fscache_get_aux(cookie);
+
+	if (aux_data && p)
+		memcpy(p, aux_data, cookie->aux_len);
+	if (object_size)
+		cookie->object_size = *object_size;
+}
+
+#ifdef CONFIG_FSCACHE_STATS
+extern atomic_t fscache_n_updates;
+#endif
+
+static inline
+void __fscache_update_cookie(struct fscache_cookie *cookie, const void *aux_data,
+			     const loff_t *object_size)
+{
+#ifdef CONFIG_FSCACHE_STATS
+	atomic_inc(&fscache_n_updates);
+#endif
+	fscache_update_aux(cookie, aux_data, object_size);
+	smp_wmb();
+	set_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &cookie->flags);
+}
+
 /**
  * fscache_update_cookie - Request that a cache object be updated
  * @cookie: The cookie representing the cache object


