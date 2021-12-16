Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA5B47775F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 17:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbhLPQMX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 11:12:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21532 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238887AbhLPQMV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639671141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+j2N+6C0zW1Pkb/6ZERucFAmQaa5wZCkjoIGt40/jHw=;
        b=FAE87IYU0rkTqPmlYc/NPIwgQ6gnl+h6b4SMaqagNSVpk93uAMR1qGMf0R79naIudhfg/V
        kCHcqLdOilwstaopsqKKIEnVt2LVjcUl6B978WfwwtXQ+SGHsUBDOTSVkd0XHgFXC3ts5K
        LkdBPZMcEsHhu2/N/vvaOl5f6yWLeSQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-Xifaw1s9NX6CcRB1CsATXA-1; Thu, 16 Dec 2021 11:12:15 -0500
X-MC-Unique: Xifaw1s9NX6CcRB1CsATXA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14C3492532;
        Thu, 16 Dec 2021 16:12:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D06D1037F52;
        Thu, 16 Dec 2021 16:11:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 21/68] fscache: Count data storage objects in a cache
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
Date:   Thu, 16 Dec 2021 16:11:58 +0000
Message-ID: <163967111846.1823006.9868154941573671255.stgit@warthog.procyon.org.uk>
In-Reply-To: <163967073889.1823006.12237147297060239168.stgit@warthog.procyon.org.uk>
References: <163967073889.1823006.12237147297060239168.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Count the data storage objects that are currently allocated in a cache.
This is used to pin certain cache structures until cache withdrawal is
complete.

Three helpers are provided to manage and make use of the count:

 (1) void fscache_count_object(struct fscache_cache *cache);

     This should be called by the cache backend to note that an object has
     been allocated and attached to the cache.

 (2) void fscache_uncount_object(struct fscache_cache *cache);

     This should be called by the backend to note that an object has been
     destroyed.  This sends a wakeup event that allows cache withdrawal to
     proceed if it was waiting for that object.

 (3) void fscache_wait_for_objects(struct fscache_cache *cache);

     This can be used by the backend to wait for all outstanding cache
     object to be destroyed.

Each cache's counter is displayed as part of /proc/fs/fscache/caches.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/163819608594.215744.1812706538117388252.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/163906911646.143852.168184059935530127.stgit@warthog.procyon.org.uk/ # v2
---

 fs/fscache/cache.c            |    2 ++
 include/linux/fscache-cache.h |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/fs/fscache/cache.c b/fs/fscache/cache.c
index 25eac61f1c29..2749933852a9 100644
--- a/fs/fscache/cache.c
+++ b/fs/fscache/cache.c
@@ -13,6 +13,8 @@
 static LIST_HEAD(fscache_caches);
 DECLARE_RWSEM(fscache_addremove_sem);
 EXPORT_SYMBOL(fscache_addremove_sem);
+DECLARE_WAIT_QUEUE_HEAD(fscache_clearance_waiters);
+EXPORT_SYMBOL(fscache_clearance_waiters);
 
 static atomic_t fscache_cache_debug_id;
 
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 566497cf5f13..337335d7a5e2 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -76,6 +76,7 @@ struct fscache_cache_ops {
 };
 
 extern struct workqueue_struct *fscache_wq;
+extern wait_queue_head_t fscache_clearance_waiters;
 
 /*
  * out-of-line cache backend functions
@@ -140,4 +141,42 @@ static inline struct fscache_cookie *fscache_cres_cookie(struct netfs_cache_reso
 	return cres->cache_priv;
 }
 
+/**
+ * fscache_count_object - Tell fscache that an object has been added
+ * @cache: The cache to account to
+ *
+ * Tell fscache that an object has been added to the cache.  This prevents the
+ * cache from tearing down the cache structure until the object is uncounted.
+ */
+static inline void fscache_count_object(struct fscache_cache *cache)
+{
+	atomic_inc(&cache->object_count);
+}
+
+/**
+ * fscache_uncount_object - Tell fscache that an object has been removed
+ * @cache: The cache to account to
+ *
+ * Tell fscache that an object has been removed from the cache and will no
+ * longer be accessed.  After this point, the cache cookie may be destroyed.
+ */
+static inline void fscache_uncount_object(struct fscache_cache *cache)
+{
+	if (atomic_dec_and_test(&cache->object_count))
+		wake_up_all(&fscache_clearance_waiters);
+}
+
+/**
+ * fscache_wait_for_objects - Wait for all objects to be withdrawn
+ * @cache: The cache to query
+ *
+ * Wait for all extant objects in a cache to finish being withdrawn
+ * and go away.
+ */
+static inline void fscache_wait_for_objects(struct fscache_cache *cache)
+{
+	wait_event(fscache_clearance_waiters,
+		   atomic_read(&cache->object_count) == 0);
+}
+
 #endif /* _LINUX_FSCACHE_CACHE_H */


