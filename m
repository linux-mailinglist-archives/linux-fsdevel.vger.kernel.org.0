Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B74437E52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 21:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbhJVTOR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 15:14:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26766 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234741AbhJVTNg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634929878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yNhDFaQpkoLeqIHGmJpRJ/OMZ6xzU1z+T+O80zOAFIo=;
        b=GG0lrTQwPbOnMK1zIbEqjfg70pd7oz87LOjPaUx08Gc3ebFmGmG2prYVOLgzkbG+F2X2aJ
        pOaLmX5Vw4LIKxdFaBbyzRZtzPCEmu0VsJrWp+tJ4YB4mIfhDobscDeFfrtbxVVRoSROtF
        2IAhM5xMauHlCIlM4kgbqdP7iPVQvzs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-Jdwzor5SNmCouewJZucWnw-1; Fri, 22 Oct 2021 15:11:15 -0400
X-MC-Unique: Jdwzor5SNmCouewJZucWnw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D12EE80668B;
        Fri, 22 Oct 2021 19:11:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7A285C1A3;
        Fri, 22 Oct 2021 19:11:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 53/53] fscache, cachefiles: Display stat of culling events
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Oct 2021 20:11:06 +0100
Message-ID: <163492986604.1038219.4728082189061698348.stgit@warthog.procyon.org.uk>
In-Reply-To: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a stat counter of culling events whereby the cache backend culls a file
to make space (when asked by cachefilesd in this case) and display in
/proc/fs/fscache/stats.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/cachefiles/namei.c         |    1 +
 fs/fscache/stats.c            |    7 +++++--
 include/linux/fscache-cache.h |    4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 9b0a14e37cfa..a118074826cd 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -661,6 +661,7 @@ int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 		goto error_unlock;
 
 	/*  actually remove the victim (drops the dir mutex) */
+	fscache_count_culled();
 	_debug("bury");
 
 	ret = cachefiles_bury_object(cache, NULL, dir, victim,
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
index d34fb6e91d57..ee1b611e365d 100644
--- a/fs/fscache/stats.c
+++ b/fs/fscache/stats.c
@@ -48,6 +48,8 @@ atomic_t fscache_n_no_write_space;
 EXPORT_SYMBOL(fscache_n_no_write_space);
 atomic_t fscache_n_no_create_space;
 EXPORT_SYMBOL(fscache_n_no_create_space);
+atomic_t fscache_n_culled;
+EXPORT_SYMBOL(fscache_n_culled);
 
 /*
  * display the general statistics
@@ -90,9 +92,10 @@ int fscache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&fscache_n_relinquishes_retire),
 		   atomic_read(&fscache_n_relinquishes_dropped));
 
-	seq_printf(m, "NoSpace: nwr=%u ncr=%u\n",
+	seq_printf(m, "NoSpace: nwr=%u ncr=%u cull=%u\n",
 		   atomic_read(&fscache_n_no_write_space),
-		   atomic_read(&fscache_n_no_create_space));
+		   atomic_read(&fscache_n_no_create_space),
+		   atomic_read(&fscache_n_culled));
 
 	seq_printf(m, "IO     : rd=%u wr=%u\n",
 		   atomic_read(&fscache_n_read),
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 7b3225c6c22f..e12f4163af61 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -181,15 +181,17 @@ extern atomic_t fscache_n_read;
 extern atomic_t fscache_n_write;
 extern atomic_t fscache_n_no_write_space;
 extern atomic_t fscache_n_no_create_space;
+extern atomic_t fscache_n_culled;
 #define fscache_count_read() atomic_inc(&fscache_n_read)
 #define fscache_count_write() atomic_inc(&fscache_n_write)
 #define fscache_count_no_write_space() atomic_inc(&fscache_n_no_write_space)
 #define fscache_count_no_create_space() atomic_inc(&fscache_n_no_create_space)
+#define fscache_count_culled() atomic_inc(&fscache_n_culled)
 #else
 #define fscache_count_read() do {} while(0)
 #define fscache_count_write() do {} while(0)
 #define fscache_count_no_write_space() do {} while(0)
-#define fscache_count_no_create_space() do {} while(0)
+#define fscache_count_culled() do {} while(0)
 #endif
 
 extern struct workqueue_struct *fscache_wq;


