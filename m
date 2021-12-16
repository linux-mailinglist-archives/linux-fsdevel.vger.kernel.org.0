Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34589477736
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 17:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239068AbhLPQK5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 11:10:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60140 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235572AbhLPQK5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639671056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sutZgL9X30MGJK6zq3yqN4N3QXbscUdjoQ7h6zXochA=;
        b=Mm0BxNxK1gwGsd3Uywc5MFvJ5q8Y9DWsmlOoy0pXrJn5+UiLz0g9cMlpVIeCKqvy4j5Pj2
        RKV2s2OJGZ9ZqR/fQU0AMrkapD4vXSvldxeCC0eydC23UyjMAyJQvdDSkVHTe4TikTPzds
        bw6PtR0zVvhc/pbWt7MpEM/873c4eGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-tf_i_P8ROLmG4OY4shUnHA-1; Thu, 16 Dec 2021 11:10:53 -0500
X-MC-Unique: tf_i_P8ROLmG4OY4shUnHA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7482B1853020;
        Thu, 16 Dec 2021 16:10:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1907FE2F0;
        Thu, 16 Dec 2021 16:10:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 16/68] fscache: Add a function for a cache backend to note
 an I/O error
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
Date:   Thu, 16 Dec 2021 16:10:07 +0000
Message-ID: <163967100721.1823006.16435671567428949398.stgit@warthog.procyon.org.uk>
In-Reply-To: <163967073889.1823006.12237147297060239168.stgit@warthog.procyon.org.uk>
References: <163967073889.1823006.12237147297060239168.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a function to the backend API to note an I/O error in a cache.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/163819598741.215744.891281275151382095.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/163906901316.143852.15225412215771586528.stgit@warthog.procyon.org.uk/ # v2
---

 fs/fscache/cache.c            |   20 ++++++++++++++++++++
 include/linux/fscache-cache.h |    2 ++
 2 files changed, 22 insertions(+)

diff --git a/fs/fscache/cache.c b/fs/fscache/cache.c
index bbd102be91c4..25eac61f1c29 100644
--- a/fs/fscache/cache.c
+++ b/fs/fscache/cache.c
@@ -321,6 +321,26 @@ void fscache_end_cache_access(struct fscache_cache *cache, enum fscache_access_t
 		wake_up_var(&cache->n_accesses);
 }
 
+/**
+ * fscache_io_error - Note a cache I/O error
+ * @cache: The record describing the cache
+ *
+ * Note that an I/O error occurred in a cache and that it should no longer be
+ * used for anything.  This also reports the error into the kernel log.
+ *
+ * See Documentation/filesystems/caching/backend-api.rst for a complete
+ * description.
+ */
+void fscache_io_error(struct fscache_cache *cache)
+{
+	if (fscache_set_cache_state_maybe(cache,
+					  FSCACHE_CACHE_IS_ACTIVE,
+					  FSCACHE_CACHE_GOT_IOERROR))
+		pr_err("Cache '%s' stopped due to I/O error\n",
+		       cache->name);
+}
+EXPORT_SYMBOL(fscache_io_error);
+
 /**
  * fscache_withdraw_cache - Withdraw a cache from the active service
  * @cache: The cache cookie
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index a10b66ca3544..936ef731bbc7 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -73,6 +73,8 @@ extern int fscache_add_cache(struct fscache_cache *cache,
 extern void fscache_withdraw_cache(struct fscache_cache *cache);
 extern void fscache_withdraw_volume(struct fscache_volume *volume);
 
+extern void fscache_io_error(struct fscache_cache *cache);
+
 extern void fscache_end_volume_access(struct fscache_volume *volume,
 				      struct fscache_cookie *cookie,
 				      enum fscache_access_trace why);


