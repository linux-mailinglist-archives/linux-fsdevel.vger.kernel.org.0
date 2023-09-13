Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8341879EFA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 18:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjIMQ6u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 12:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjIMQ6T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B90C21FC8
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 09:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694624247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c2st9mzpODW5EfnFYy73QjLkmO48eOaJEcOSoL9qczM=;
        b=ivlDJN+kz2xwguw81cM+m3r/6gt7aCsyPP7E/FAU60iMctT29YeGclvp5qGLXs9IUsIptz
        dcUtCKy+ocg1s5H1wDmwB38d8z6VZlriRqEgdTvA4AR1FP4ye6QJSeQC6j/cUQGB8OKust
        9UubaFqLRNxARlYL00TbfBg3QnyDqI8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-Z0pMlrrIOVKNFRYw1td4xA-1; Wed, 13 Sep 2023 12:57:23 -0400
X-MC-Unique: Z0pMlrrIOVKNFRYw1td4xA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D46F2101FAA0;
        Wed, 13 Sep 2023 16:57:22 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CAFFF40C6EA8;
        Wed, 13 Sep 2023 16:57:20 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v4 12/13] iov_iter, net: Move hash_and_copy_to_iter() to net/
Date:   Wed, 13 Sep 2023 17:56:47 +0100
Message-ID: <20230913165648.2570623-13-dhowells@redhat.com>
In-Reply-To: <20230913165648.2570623-1-dhowells@redhat.com>
References: <20230913165648.2570623-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move hash_and_copy_to_iter() to be with its only caller in networking code.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Christian Brauner <christian@brauner.io>
cc: Matthew Wilcox <willy@infradead.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: David Laight <David.Laight@ACULAB.COM>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
cc: netdev@vger.kernel.org
---
 include/linux/uio.h |  3 ---
 lib/iov_iter.c      | 20 --------------------
 net/core/datagram.c | 19 +++++++++++++++++++
 3 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index c335b95626af..6bb00645fe46 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -326,9 +326,6 @@ iov_iter_npages_cap(struct iov_iter *i, int maxpages, size_t max_bytes)
 	return npages;
 }
 
-size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
-		struct iov_iter *i);
-
 struct iovec *iovec_from_user(const struct iovec __user *uvector,
 		unsigned long nr_segs, unsigned long fast_segs,
 		struct iovec *fast_iov, bool compat);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 5b2d053f057f..77520834ebe4 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <crypto/hash.h>
 #include <linux/export.h>
 #include <linux/bvec.h>
 #include <linux/fault-inject-usercopy.h>
@@ -1071,25 +1070,6 @@ ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
 }
 EXPORT_SYMBOL(iov_iter_get_pages_alloc2);
 
-size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
-		struct iov_iter *i)
-{
-#ifdef CONFIG_CRYPTO_HASH
-	struct ahash_request *hash = hashp;
-	struct scatterlist sg;
-	size_t copied;
-
-	copied = copy_to_iter(addr, bytes, i);
-	sg_init_one(&sg, addr, copied);
-	ahash_request_set_crypt(hash, &sg, NULL, copied);
-	crypto_ahash_update(hash);
-	return copied;
-#else
-	return 0;
-#endif
-}
-EXPORT_SYMBOL(hash_and_copy_to_iter);
-
 static int iov_npages(const struct iov_iter *i, int maxpages)
 {
 	size_t skip = i->iov_offset, size = i->count;
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 722311eeee18..103d46fa0eeb 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -61,6 +61,7 @@
 #include <net/tcp_states.h>
 #include <trace/events/skb.h>
 #include <net/busy_poll.h>
+#include <crypto/hash.h>
 
 /*
  *	Is a socket 'connection oriented' ?
@@ -489,6 +490,24 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 	return 0;
 }
 
+static size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
+				    struct iov_iter *i)
+{
+#ifdef CONFIG_CRYPTO_HASH
+	struct ahash_request *hash = hashp;
+	struct scatterlist sg;
+	size_t copied;
+
+	copied = copy_to_iter(addr, bytes, i);
+	sg_init_one(&sg, addr, copied);
+	ahash_request_set_crypt(hash, &sg, NULL, copied);
+	crypto_ahash_update(hash);
+	return copied;
+#else
+	return 0;
+#endif
+}
+
 /**
  *	skb_copy_and_hash_datagram_iter - Copy datagram to an iovec iterator
  *          and update a hash.

