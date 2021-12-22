Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1A247DB71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 00:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345469AbhLVXbw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Dec 2021 18:31:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56839 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345468AbhLVXbu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Dec 2021 18:31:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640215910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Ei/BkM/HJ1j4nncmgfL05Lirnm7dvMyEthdyELl/08=;
        b=KvH3jH6p0Cv+yO6yfFBKzZ2e7AU7m1cyjq/YhcgslFa0vcmFjFmK4Le/iF3IBbxBMQTDG+
        OgDdhGP1CLqg+Ug7dTNbCP4QBfHVLvelSR6JPJDguYveuxcJy5tUnoNkT82lxJJB6fGsB/
        BuH56eQtS5SGh10jeN3rWNF2qZDLU2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-sMsOBAdZNky_UxhIxqaMBQ-1; Wed, 22 Dec 2021 18:31:44 -0500
X-MC-Unique: sMsOBAdZNky_UxhIxqaMBQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B8B8801ADB;
        Wed, 22 Dec 2021 23:31:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B70E7A3F6;
        Wed, 22 Dec 2021 23:31:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v4 67/68] fscache: Add a tracepoint for cookie use/unuse
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 22 Dec 2021 23:31:26 +0000
Message-ID: <164021588628.640689.12942919367404043608.stgit@warthog.procyon.org.uk>
In-Reply-To: <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
References: <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a tracepoint to track fscache_use/unuse_cookie().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/fscache/cookie.c            |   29 +++++++++++++++++++++++---
 include/trace/events/fscache.h |   44 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index a7ea7d1db032..9bb1ab5fe5ed 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -556,6 +556,7 @@ void __fscache_use_cookie(struct fscache_cookie *cookie, bool will_modify)
 {
 	enum fscache_cookie_state state;
 	bool queue = false;
+	int n_active;
 
 	_enter("c=%08x", cookie->debug_id);
 
@@ -565,7 +566,11 @@ void __fscache_use_cookie(struct fscache_cookie *cookie, bool will_modify)
 
 	spin_lock(&cookie->lock);
 
-	atomic_inc(&cookie->n_active);
+	n_active = atomic_inc_return(&cookie->n_active);
+	trace_fscache_active(cookie->debug_id, refcount_read(&cookie->ref),
+			     n_active, atomic_read(&cookie->n_accesses),
+			     will_modify ?
+			     fscache_active_use_modify : fscache_active_use);
 
 again:
 	state = fscache_cookie_state(cookie);
@@ -638,13 +643,29 @@ static void fscache_unuse_cookie_locked(struct fscache_cookie *cookie)
 void __fscache_unuse_cookie(struct fscache_cookie *cookie,
 			    const void *aux_data, const loff_t *object_size)
 {
+	unsigned int debug_id = cookie->debug_id;
+	unsigned int r = refcount_read(&cookie->ref);
+	unsigned int a = atomic_read(&cookie->n_accesses);
+	unsigned int c;
+
 	if (aux_data || object_size)
 		__fscache_update_cookie(cookie, aux_data, object_size);
 
-	if (atomic_dec_and_lock(&cookie->n_active, &cookie->lock)) {
-		fscache_unuse_cookie_locked(cookie);
-		spin_unlock(&cookie->lock);
+	/* Subtract 1 from counter unless that drops it to 0 (ie. it was 1) */
+	c = atomic_fetch_add_unless(&cookie->n_active, -1, 1);
+	if (c != 1) {
+		trace_fscache_active(debug_id, r, c - 1, a, fscache_active_unuse);
+		return;
 	}
+
+	spin_lock(&cookie->lock);
+	r = refcount_read(&cookie->ref);
+	a = atomic_read(&cookie->n_accesses);
+	c = atomic_dec_return(&cookie->n_active);
+	trace_fscache_active(debug_id, r, c, a, fscache_active_unuse);
+	if (c == 0)
+		fscache_unuse_cookie_locked(cookie);
+	spin_unlock(&cookie->lock);
 }
 EXPORT_SYMBOL(__fscache_unuse_cookie);
 
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index 1594aefadeac..cb3fb337e880 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -71,6 +71,12 @@ enum fscache_cookie_trace {
 	fscache_cookie_see_work,
 };
 
+enum fscache_active_trace {
+	fscache_active_use,
+	fscache_active_use_modify,
+	fscache_active_unuse,
+};
+
 enum fscache_access_trace {
 	fscache_access_acquire_volume,
 	fscache_access_acquire_volume_end,
@@ -146,6 +152,11 @@ enum fscache_access_trace {
 	EM(fscache_cookie_see_withdraw,		"-   x-wth")		\
 	E_(fscache_cookie_see_work,		"-   work ")
 
+#define fscache_active_traces		\
+	EM(fscache_active_use,			"USE          ")	\
+	EM(fscache_active_use_modify,		"USE-m        ")	\
+	E_(fscache_active_unuse,		"UNUSE        ")
+
 #define fscache_access_traces		\
 	EM(fscache_access_acquire_volume,	"BEGIN acq_vol")	\
 	EM(fscache_access_acquire_volume_end,	"END   acq_vol")	\
@@ -264,6 +275,39 @@ TRACE_EVENT(fscache_cookie,
 		      __entry->ref)
 	    );
 
+TRACE_EVENT(fscache_active,
+	    TP_PROTO(unsigned int cookie_debug_id,
+		     int ref,
+		     int n_active,
+		     int n_accesses,
+		     enum fscache_active_trace why),
+
+	    TP_ARGS(cookie_debug_id, ref, n_active, n_accesses, why),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		cookie		)
+		    __field(int,			ref		)
+		    __field(int,			n_active	)
+		    __field(int,			n_accesses	)
+		    __field(enum fscache_active_trace,	why		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->cookie	= cookie_debug_id;
+		    __entry->ref	= ref;
+		    __entry->n_active	= n_active;
+		    __entry->n_accesses	= n_accesses;
+		    __entry->why	= why;
+			   ),
+
+	    TP_printk("c=%08x %s r=%d a=%d c=%d",
+		      __entry->cookie,
+		      __print_symbolic(__entry->why, fscache_active_traces),
+		      __entry->ref,
+		      __entry->n_accesses,
+		      __entry->n_active)
+	    );
+
 TRACE_EVENT(fscache_access_cache,
 	    TP_PROTO(unsigned int cache_debug_id,
 		     int ref,


