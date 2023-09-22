Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011A77AB1CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 14:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbjIVMEw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 08:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbjIVME2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:04:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED7DCCF
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 05:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695384182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wIy5c31/DaOl6Dg3RGFXufcZuyPPQA8lBpT8O0G10n8=;
        b=BuP2CAty9CsK5g33byXSweqJzqKkdSTgWlTz0WbcHFGOY2bEfQjAXT5gfCDtUZ32V272Xa
        1p+hXH8hrglo+nfdVPr5iItMVBq0iJNCLj+sLWraMPcREyVrbj4k5HMFowCcTLMOG5CUyk
        lKMLiAYKYhA/8kKCEjcvyrtM4mACrZA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440-pc8cXPA_OZOHFZz0kV5OcQ-1; Fri, 22 Sep 2023 08:02:57 -0400
X-MC-Unique: pc8cXPA_OZOHFZz0kV5OcQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA1881814507;
        Fri, 22 Sep 2023 12:02:56 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4799F40C6EBF;
        Fri, 22 Sep 2023 12:02:55 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 10/13] iov_iter, net: Move csum_and_copy_to/from_iter() to net/
Date:   Fri, 22 Sep 2023 13:02:24 +0100
Message-ID: <20230922120227.1173720-11-dhowells@redhat.com>
In-Reply-To: <20230922120227.1173720-1-dhowells@redhat.com>
References: <20230922120227.1173720-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move csum_and_copy_to/from_iter() to net code now that the iteration
framework can be #included.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 include/linux/skbuff.h | 25 ++++++++++++
 include/linux/uio.h    | 18 ---------
 lib/iov_iter.c         | 89 ------------------------------------------
 net/core/datagram.c    | 50 +++++++++++++++++++++++-
 net/core/skbuff.c      | 33 ++++++++++++++++
 5 files changed, 107 insertions(+), 108 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 4174c4b82d13..d0656cc11c16 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3679,6 +3679,31 @@ static inline int __must_check skb_put_padto(struct sk_buff *skb, unsigned int l
 	return __skb_put_padto(skb, len, true);
 }
 
+static inline __wsum csum_and_memcpy(void *to, const void *from, size_t len,
+				     __wsum sum, size_t off)
+{
+	__wsum next = csum_partial_copy_nocheck(from, to, len);
+	return csum_block_add(sum, next, off);
+}
+
+struct csum_state {
+	__wsum csum;
+	size_t off;
+};
+
+size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
+
+static __always_inline __must_check
+bool csum_and_copy_from_iter_full(void *addr, size_t bytes,
+				  __wsum *csum, struct iov_iter *i)
+{
+	size_t copied = csum_and_copy_from_iter(addr, bytes, csum, i);
+	if (likely(copied == bytes))
+		return true;
+	iov_iter_revert(i, copied);
+	return false;
+}
+
 static inline int skb_add_data(struct sk_buff *skb,
 			       struct iov_iter *from, int copy)
 {
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 65d9143f83c8..0a5426c97e02 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -338,24 +338,6 @@ iov_iter_npages_cap(struct iov_iter *i, int maxpages, size_t max_bytes)
 	return npages;
 }
 
-struct csum_state {
-	__wsum csum;
-	size_t off;
-};
-
-size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *csstate, struct iov_iter *i);
-size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
-
-static __always_inline __must_check
-bool csum_and_copy_from_iter_full(void *addr, size_t bytes,
-				  __wsum *csum, struct iov_iter *i)
-{
-	size_t copied = csum_and_copy_from_iter(addr, bytes, csum, i);
-	if (likely(copied == bytes))
-		return true;
-	iov_iter_revert(i, copied);
-	return false;
-}
 size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
 		struct iov_iter *i);
 
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 943aa3cfd7b3..fef934a8745d 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -10,7 +10,6 @@
 #include <linux/vmalloc.h>
 #include <linux/splice.h>
 #include <linux/compat.h>
-#include <net/checksum.h>
 #include <linux/scatterlist.h>
 #include <linux/instrumented.h>
 #include <linux/iov_iter.h>
@@ -179,13 +178,6 @@ void iov_iter_init(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_init);
 
-static __wsum csum_and_memcpy(void *to, const void *from, size_t len,
-			      __wsum sum, size_t off)
-{
-	__wsum next = csum_partial_copy_nocheck(from, to, len);
-	return csum_block_add(sum, next, off);
-}
-
 size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
 	if (WARN_ON_ONCE(i->data_source))
@@ -1101,87 +1093,6 @@ ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
 }
 EXPORT_SYMBOL(iov_iter_get_pages_alloc2);
 
-static __always_inline
-size_t copy_from_user_iter_csum(void __user *iter_from, size_t progress,
-				size_t len, void *to, void *priv2)
-{
-	__wsum next, *csum = priv2;
-
-	next = csum_and_copy_from_user(iter_from, to + progress, len);
-	*csum = csum_block_add(*csum, next, progress);
-	return next ? 0 : len;
-}
-
-static __always_inline
-size_t memcpy_from_iter_csum(void *iter_from, size_t progress,
-			     size_t len, void *to, void *priv2)
-{
-	__wsum *csum = priv2;
-
-	*csum = csum_and_memcpy(to + progress, iter_from, len, *csum, progress);
-	return 0;
-}
-
-size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
-			       struct iov_iter *i)
-{
-	if (WARN_ON_ONCE(!i->data_source))
-		return 0;
-	return iterate_and_advance2(i, bytes, addr, csum,
-				    copy_from_user_iter_csum,
-				    memcpy_from_iter_csum);
-}
-EXPORT_SYMBOL(csum_and_copy_from_iter);
-
-static __always_inline
-size_t copy_to_user_iter_csum(void __user *iter_to, size_t progress,
-			      size_t len, void *from, void *priv2)
-{
-	__wsum next, *csum = priv2;
-
-	next = csum_and_copy_to_user(from + progress, iter_to, len);
-	*csum = csum_block_add(*csum, next, progress);
-	return next ? 0 : len;
-}
-
-static __always_inline
-size_t memcpy_to_iter_csum(void *iter_to, size_t progress,
-			   size_t len, void *from, void *priv2)
-{
-	__wsum *csum = priv2;
-
-	*csum = csum_and_memcpy(iter_to, from + progress, len, *csum, progress);
-	return 0;
-}
-
-size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *_csstate,
-			     struct iov_iter *i)
-{
-	struct csum_state *csstate = _csstate;
-	__wsum sum;
-
-	if (WARN_ON_ONCE(i->data_source))
-		return 0;
-	if (unlikely(iov_iter_is_discard(i))) {
-		// can't use csum_memcpy() for that one - data is not copied
-		csstate->csum = csum_block_add(csstate->csum,
-					       csum_partial(addr, bytes, 0),
-					       csstate->off);
-		csstate->off += bytes;
-		return bytes;
-	}
-
-	sum = csum_shift(csstate->csum, csstate->off);
-	
-	bytes = iterate_and_advance2(i, bytes, (void *)addr, &sum,
-				     copy_to_user_iter_csum,
-				     memcpy_to_iter_csum);
-	csstate->csum = csum_shift(sum, csstate->off);
-	csstate->off += bytes;
-	return bytes;
-}
-EXPORT_SYMBOL(csum_and_copy_to_iter);
-
 size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
 		struct iov_iter *i)
 {
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 176eb5834746..37c89d0933b7 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -50,7 +50,7 @@
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/pagemap.h>
-#include <linux/uio.h>
+#include <linux/iov_iter.h>
 #include <linux/indirect_call_wrapper.h>
 
 #include <net/protocol.h>
@@ -716,6 +716,54 @@ int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *from)
 }
 EXPORT_SYMBOL(zerocopy_sg_from_iter);
 
+static __always_inline
+size_t copy_to_user_iter_csum(void __user *iter_to, size_t progress,
+			      size_t len, void *from, void *priv2)
+{
+	__wsum next, *csum = priv2;
+
+	next = csum_and_copy_to_user(from + progress, iter_to, len);
+	*csum = csum_block_add(*csum, next, progress);
+	return next ? 0 : len;
+}
+
+static __always_inline
+size_t memcpy_to_iter_csum(void *iter_to, size_t progress,
+			   size_t len, void *from, void *priv2)
+{
+	__wsum *csum = priv2;
+
+	*csum = csum_and_memcpy(iter_to, from + progress, len, *csum, progress);
+	return 0;
+}
+
+static size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *_csstate,
+				    struct iov_iter *i)
+{
+	struct csum_state *csstate = _csstate;
+	__wsum sum;
+
+	if (WARN_ON_ONCE(i->data_source))
+		return 0;
+	if (unlikely(iov_iter_is_discard(i))) {
+		// can't use csum_memcpy() for that one - data is not copied
+		csstate->csum = csum_block_add(csstate->csum,
+					       csum_partial(addr, bytes, 0),
+					       csstate->off);
+		csstate->off += bytes;
+		return bytes;
+	}
+
+	sum = csum_shift(csstate->csum, csstate->off);
+
+	bytes = iterate_and_advance2(i, bytes, (void *)addr, &sum,
+				     copy_to_user_iter_csum,
+				     memcpy_to_iter_csum);
+	csstate->csum = csum_shift(sum, csstate->off);
+	csstate->off += bytes;
+	return bytes;
+}
+
 /**
  *	skb_copy_and_csum_datagram - Copy datagram to an iovec iterator
  *          and update a checksum.
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4eaf7ed0d1f4..5dbdfce2d05f 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -62,6 +62,7 @@
 #include <linux/if_vlan.h>
 #include <linux/mpls.h>
 #include <linux/kcov.h>
+#include <linux/iov_iter.h>
 
 #include <net/protocol.h>
 #include <net/dst.h>
@@ -6931,3 +6932,35 @@ ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
 	return spliced ?: ret;
 }
 EXPORT_SYMBOL(skb_splice_from_iter);
+
+static __always_inline
+size_t memcpy_from_iter_csum(void *iter_from, size_t progress,
+			     size_t len, void *to, void *priv2)
+{
+	__wsum *csum = priv2;
+
+	*csum = csum_and_memcpy(to + progress, iter_from, len, *csum, progress);
+	return 0;
+}
+
+static __always_inline
+size_t copy_from_user_iter_csum(void __user *iter_from, size_t progress,
+				size_t len, void *to, void *priv2)
+{
+	__wsum next, *csum = priv2;
+
+	next = csum_and_copy_from_user(iter_from, to + progress, len);
+	*csum = csum_block_add(*csum, next, progress);
+	return next ? 0 : len;
+}
+
+size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
+			       struct iov_iter *i)
+{
+	if (WARN_ON_ONCE(!i->data_source))
+		return 0;
+	return iterate_and_advance2(i, bytes, addr, csum,
+				    copy_from_user_iter_csum,
+				    memcpy_from_iter_csum);
+}
+EXPORT_SYMBOL(csum_and_copy_from_iter);

