Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303064321B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbhJRPG7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:06:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42376 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233353AbhJRPF6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K6n7Lxx/u+7TeXaM45gQ3O34r9vcGaUxwGu9AnBokAQ=;
        b=I9vC7QeSmZJVXlf6WnXqncnb464GdK2jfS/FfU/RJbL99JxJG+TNBFnSAtsC92sykf0EYH
        7C3aGo91+wacrbgWdnfO+o5YFMbzbwJrSmK1lQL1OORxsowpuydm6uCuEcsmZUsApDaBoR
        i3ws8KfHh8/a+eP2feftHnVg8K6uTJc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-3SzqldG0NTe8vAbqLe2UXg-1; Mon, 18 Oct 2021 11:03:43 -0400
X-MC-Unique: 3SzqldG0NTe8vAbqLe2UXg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85B2710168DE;
        Mon, 18 Oct 2021 15:03:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7723A60CCC;
        Mon, 18 Oct 2021 15:03:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 50/67] fscache: Make fscache_clear_page_bits() conditional on
 cookie
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
Date:   Mon, 18 Oct 2021 16:03:22 +0100
Message-ID: <163456940271.2614702.17009440990784553871.stgit@warthog.procyon.org.uk>
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

Make fscache_clear_page_bits() conditional on cookie not being NULL, rather
than merely conditional on CONFIG_FSCACHE=[ym].  The problem with the
latter is if a filesystem, say afs, has CONFIG_AFS_FSCACHE=n but calls into
this function - in which it linkage will fail if CONFIG_FSCACHE is less
than CONFIG_AFS.  Analogous problems can affect other filesystems, e.g. 9p.

Making fscache_clear_page_bits() conditional on the cookie achieves two
things:

 (1) If cookie optimised down to constant NULL, the rest of the function is
     thrown away and the slow path is never called.

 (2) __fscache_clear_page_bits() isn't called if there's no cookie - and
     so, in such a case, the pages won't iterated over attempting to clear
     PG_fscache bits that haven't been set.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/io.c         |    5 +++--
 include/linux/fscache.h |    8 +++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index 3910cba65545..bc8d1ac0e85c 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -316,7 +316,8 @@ static void fscache_wreq_done(void *priv, ssize_t transferred_or_error,
 {
 	struct fscache_write_request *wreq = priv;
 
-	fscache_clear_page_bits(wreq->mapping, wreq->start, wreq->len);
+	fscache_clear_page_bits(fscache_cres_cookie(&wreq->cache_resources),
+				wreq->mapping, wreq->start, wreq->len);
 
 	if (wreq->term_func)
 		wreq->term_func(wreq->term_func_priv, transferred_or_error,
@@ -373,7 +374,7 @@ void __fscache_write_to_cache(struct fscache_cookie *cookie,
 abandon_free:
 	kfree(wreq);
 abandon:
-	fscache_clear_page_bits(mapping, start, len);
+	fscache_clear_page_bits(cookie, mapping, start, len);
 	if (term_func)
 		term_func(term_func_priv, ret, false);
 }
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index fe4d588641da..847c076d05a6 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -549,6 +549,7 @@ int fscache_write(struct netfs_cache_resources *cres,
 
 /**
  * fscache_clear_page_bits - Clear the PG_fscache bits from a set of pages
+ * @cookie: The cookie representing the cache object
  * @mapping: The netfs inode to use as the source
  * @start: The start position in @mapping
  * @len: The amount of data to unlock
@@ -556,10 +557,11 @@ int fscache_write(struct netfs_cache_resources *cres,
  * Clear the PG_fscache flag from a sequence of pages and wake up anyone who's
  * waiting.
  */
-static inline void fscache_clear_page_bits(struct address_space *mapping,
+static inline void fscache_clear_page_bits(struct fscache_cookie *cookie,
+					   struct address_space *mapping,
 					   loff_t start, size_t len)
 {
-	if (fscache_available())
+	if (fscache_cookie_valid(cookie))
 		__fscache_clear_page_bits(mapping, start, len);
 }
 
@@ -595,7 +597,7 @@ static inline void fscache_write_to_cache(struct fscache_cookie *cookie,
 		__fscache_write_to_cache(cookie, mapping, start, len, i_size,
 					 term_func, term_func_priv);
 	} else {
-		fscache_clear_page_bits(mapping, start, len);
+		fscache_clear_page_bits(cookie, mapping, start, len);
 		if (term_func)
 			term_func(term_func_priv, -ENOBUFS, false);
 	}


