Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A153B2BACD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbgKTPGE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:06:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51970 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728696AbgKTPGD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:06:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605884761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sdKUXuKYWtVJHjOlbInbaNIJNT/e6Kclw7i3k6mZU6E=;
        b=eRvwSzamKAFa4qu3Hhz3icsZwFl0VFY+TCl8/RVPcXOZ/ZH1Ttzf0Adwq6gCmH6FNtMNSL
        P6aOX/NqNqo6+f57/5E0t0AkQ0q1pi0W3glQIbAOvnOoqlAdGkacON8XIN1y3Vpqa5yt6p
        XXNOjxZ4ntpyeuVmyYByl5a9uC4cbRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-PGx-9_kYMYmz8WxJFoyJAg-1; Fri, 20 Nov 2020 10:05:57 -0500
X-MC-Unique: PGx-9_kYMYmz8WxJFoyJAg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 324C2107ACFC;
        Fri, 20 Nov 2020 15:05:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46B025D6CF;
        Fri, 20 Nov 2020 15:05:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 15/76] fscache: Change %p in format strings to something
 else
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
Date:   Fri, 20 Nov 2020 15:05:48 +0000
Message-ID: <160588474843.3465195.5446072310069374803.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change plain %p in format strings in fscache code to something more useful,
since %p is now hashed before printing and thus no longer matches the
contents of an oops register dump.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/cache.c  |    8 ++++----
 fs/fscache/cookie.c |   16 +++++++---------
 fs/fscache/object.c |    1 -
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/fscache/cache.c b/fs/fscache/cache.c
index 92f747b72ec3..60fa68c7da3a 100644
--- a/fs/fscache/cache.c
+++ b/fs/fscache/cache.c
@@ -118,7 +118,7 @@ struct fscache_cache *fscache_select_cache_for_object(
 			cache = NULL;
 
 		spin_unlock(&cookie->lock);
-		_leave(" = %p [parent]", cache);
+		_leave(" = %s [parent]", cache ? cache->tag->name : "NULL");
 		return cache;
 	}
 
@@ -144,14 +144,14 @@ struct fscache_cache *fscache_select_cache_for_object(
 	if (test_bit(FSCACHE_IOERROR, &tag->cache->flags))
 		return NULL;
 
-	_leave(" = %p [specific]", tag->cache);
+	_leave(" = %s [specific]", tag->name);
 	return tag->cache;
 
 no_preference:
 	/* netfs has no preference - just select first cache */
 	cache = list_entry(fscache_cache_list.next,
 			   struct fscache_cache, link);
-	_leave(" = %p [first]", cache);
+	_leave(" = %s [first]", cache->tag->name);
 	return cache;
 }
 
@@ -324,7 +324,7 @@ static void fscache_withdraw_all_objects(struct fscache_cache *cache,
 					    struct fscache_object, cache_link);
 			list_move_tail(&object->cache_link, dying_objects);
 
-			_debug("withdraw %p", object->cookie);
+			_debug("withdraw %x", object->cookie->debug_id);
 
 			/* This must be done under object_list_lock to prevent
 			 * a race with fscache_drop_object().
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index aa33d16711e1..0346bc7f5818 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -369,7 +369,7 @@ void __fscache_enable_cookie(struct fscache_cookie *cookie,
 			     bool (*can_enable)(void *data),
 			     void *data)
 {
-	_enter("%p", cookie);
+	_enter("%x", cookie->debug_id);
 
 	trace_fscache_enable(cookie);
 
@@ -464,10 +464,8 @@ static int fscache_acquire_non_index_cookie(struct fscache_cookie *cookie)
 
 	/* we may be required to wait for lookup to complete at this point */
 	if (!fscache_defer_lookup) {
-		_debug("non-deferred lookup %p", &cookie->flags);
 		wait_on_bit(&cookie->flags, FSCACHE_COOKIE_LOOKING_UP,
 			    TASK_UNINTERRUPTIBLE);
-		_debug("complete");
 		if (test_bit(FSCACHE_COOKIE_UNAVAILABLE, &cookie->flags))
 			goto unavailable;
 	}
@@ -492,7 +490,7 @@ static int fscache_alloc_object(struct fscache_cache *cache,
 	struct fscache_object *object;
 	int ret;
 
-	_enter("%p,%p{%s}", cache, cookie, cookie->type_name);
+	_enter("%s,%x{%s}", cache->tag->name, cookie->debug_id, cookie->type_name);
 
 	spin_lock(&cookie->lock);
 	hlist_for_each_entry(object, &cookie->backing_objects,
@@ -668,7 +666,7 @@ EXPORT_SYMBOL(__fscache_invalidate);
  */
 void __fscache_wait_on_invalidate(struct fscache_cookie *cookie)
 {
-	_enter("%p", cookie);
+	_enter("%x", cookie->debug_id);
 
 	wait_on_bit(&cookie->flags, FSCACHE_COOKIE_INVALIDATING,
 		    TASK_UNINTERRUPTIBLE);
@@ -723,7 +721,7 @@ void __fscache_disable_cookie(struct fscache_cookie *cookie,
 	struct fscache_object *object;
 	bool awaken = false;
 
-	_enter("%p,%u", cookie, invalidate);
+	_enter("%x,%u", cookie->debug_id, invalidate);
 
 	trace_fscache_disable(cookie);
 
@@ -808,8 +806,8 @@ void __fscache_relinquish_cookie(struct fscache_cookie *cookie,
 		return;
 	}
 
-	_enter("%p{%s,%d},%d",
-	       cookie, cookie->type_name,
+	_enter("%x{%s,%d},%d",
+	       cookie->debug_id, cookie->type_name,
 	       atomic_read(&cookie->n_active), retire);
 
 	trace_fscache_relinquish(cookie, retire);
@@ -859,7 +857,7 @@ void fscache_cookie_put(struct fscache_cookie *cookie,
 	struct fscache_cookie *parent;
 	int usage;
 
-	_enter("%p", cookie);
+	_enter("%x", cookie->debug_id);
 
 	do {
 		usage = atomic_dec_return(&cookie->usage);
diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index 5d50976bf379..efdd5309d88e 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -519,7 +519,6 @@ void fscache_object_lookup_negative(struct fscache_object *object)
 		set_bit(FSCACHE_COOKIE_NO_DATA_YET, &cookie->flags);
 		clear_bit(FSCACHE_COOKIE_UNAVAILABLE, &cookie->flags);
 
-		_debug("wake up lookup %p", &cookie->flags);
 		clear_bit_unlock(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags);
 		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_LOOKING_UP);
 	}


