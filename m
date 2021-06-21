Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266413AF7F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 23:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhFUVts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 17:49:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42391 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232273AbhFUVtg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 17:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624312041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X67Q8GBfmyUAFg/sXddhD9amxxTQEAiShPtk48Zkdv0=;
        b=cLrOVpe7YOacb3OydyZ+y5eprqoj8ULYJVbuBMclDW/jKzYvQcoOQQ9x4uTcd+8aFnEQDh
        nzkwuRKJPZq3P1wXqrIUvNrIfllYZK+Qv5fvQ+L9n7xRs1DrXdggFlChl83z6xQorMssaP
        V/buJio+yJdow+V7ctVJPwfiZyb3zqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-9-0FX-8mPA-sWVpCGpjNzw-1; Mon, 21 Jun 2021 17:47:20 -0400
X-MC-Unique: 9-0FX-8mPA-sWVpCGpjNzw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5618C19611A0;
        Mon, 21 Jun 2021 21:47:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF753608BA;
        Mon, 21 Jun 2021 21:47:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 11/12] fscache: Fix fscache_cookie_put() to not deref after
 dec
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 21 Jun 2021 22:47:11 +0100
Message-ID: <162431203107.2908479.3259582550347000088.stgit@warthog.procyon.org.uk>
In-Reply-To: <162431188431.2908479.14031376932042135080.stgit@warthog.procyon.org.uk>
References: <162431188431.2908479.14031376932042135080.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fscache_cookie_put() accesses the cookie it has just put inside the
tracepoint that monitors the change - but this is something it's not
allowed to do if we didn't reduce the count to zero.

Fix this by dropping most of those values from the tracepoint and grabbing
the cookie debug ID before doing the dec.

Also take the opportunity to switch over the usage and where arguments on
the tracepoint to put the reason last.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/cookie.c            |   10 ++++++----
 fs/fscache/internal.h          |    2 +-
 fs/fscache/netfs.c             |    2 +-
 include/trace/events/fscache.h |   24 +++++++-----------------
 4 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 2558814193e9..6df3732cf1b4 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -225,8 +225,8 @@ struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *candidate)
 
 collision:
 	if (test_and_set_bit(FSCACHE_COOKIE_ACQUIRED, &cursor->flags)) {
-		trace_fscache_cookie(cursor, fscache_cookie_collision,
-				     atomic_read(&cursor->usage));
+		trace_fscache_cookie(cursor->debug_id, atomic_read(&cursor->usage),
+				     fscache_cookie_collision);
 		pr_err("Duplicate cookie detected\n");
 		fscache_print_cookie(cursor, 'O');
 		fscache_print_cookie(candidate, 'N');
@@ -305,7 +305,8 @@ struct fscache_cookie *__fscache_acquire_cookie(
 
 	cookie = fscache_hash_cookie(candidate);
 	if (!cookie) {
-		trace_fscache_cookie(candidate, fscache_cookie_discard, 1);
+		trace_fscache_cookie(candidate->debug_id, 1,
+				     fscache_cookie_discard);
 		goto out;
 	}
 
@@ -866,8 +867,9 @@ void fscache_cookie_put(struct fscache_cookie *cookie,
 	_enter("%x", cookie->debug_id);
 
 	do {
+		unsigned int cookie_debug_id = cookie->debug_id;
 		usage = atomic_dec_return(&cookie->usage);
-		trace_fscache_cookie(cookie, where, usage);
+		trace_fscache_cookie(cookie_debug_id, usage, where);
 
 		if (usage > 0)
 			return;
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index a49136c63e4b..345105dbbfd1 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -291,7 +291,7 @@ static inline void fscache_cookie_get(struct fscache_cookie *cookie,
 {
 	int usage = atomic_inc_return(&cookie->usage);
 
-	trace_fscache_cookie(cookie, where, usage);
+	trace_fscache_cookie(cookie->debug_id, usage, where);
 }
 
 /*
diff --git a/fs/fscache/netfs.c b/fs/fscache/netfs.c
index cce92216fa28..d6bdb7b5e723 100644
--- a/fs/fscache/netfs.c
+++ b/fs/fscache/netfs.c
@@ -37,7 +37,7 @@ int __fscache_register_netfs(struct fscache_netfs *netfs)
 	if (!cookie)
 		goto already_registered;
 	if (cookie != candidate) {
-		trace_fscache_cookie(candidate, fscache_cookie_discard, 1);
+		trace_fscache_cookie(candidate->debug_id, 1, fscache_cookie_discard);
 		fscache_free_cookie(candidate);
 	}
 
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index 0b9e058aba4d..55b8802740fa 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -160,37 +160,27 @@ fscache_cookie_traces;
 
 
 TRACE_EVENT(fscache_cookie,
-	    TP_PROTO(struct fscache_cookie *cookie,
-		     enum fscache_cookie_trace where,
-		     int usage),
+	    TP_PROTO(unsigned int cookie_debug_id,
+		     int usage,
+		     enum fscache_cookie_trace where),
 
-	    TP_ARGS(cookie, where, usage),
+	    TP_ARGS(cookie_debug_id, usage, where),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		cookie		)
-		    __field(unsigned int,		parent		)
 		    __field(enum fscache_cookie_trace,	where		)
 		    __field(int,			usage		)
-		    __field(int,			n_children	)
-		    __field(int,			n_active	)
-		    __field(u8,				flags		)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->cookie	= cookie->debug_id;
-		    __entry->parent	= cookie->parent ? cookie->parent->debug_id : 0;
+		    __entry->cookie	= cookie_debug_id;
 		    __entry->where	= where;
 		    __entry->usage	= usage;
-		    __entry->n_children	= atomic_read(&cookie->n_children);
-		    __entry->n_active	= atomic_read(&cookie->n_active);
-		    __entry->flags	= cookie->flags;
 			   ),
 
-	    TP_printk("%s c=%08x u=%d p=%08x Nc=%d Na=%d f=%02x",
+	    TP_printk("%s c=%08x u=%d",
 		      __print_symbolic(__entry->where, fscache_cookie_traces),
-		      __entry->cookie, __entry->usage,
-		      __entry->parent, __entry->n_children, __entry->n_active,
-		      __entry->flags)
+		      __entry->cookie, __entry->usage)
 	    );
 
 TRACE_EVENT(fscache_netfs,


