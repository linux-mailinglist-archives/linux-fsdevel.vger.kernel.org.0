Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BDA79EF9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 18:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjIMQ6v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 12:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjIMQ6U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B9CA1BF2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 09:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694624246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OEnm3txfdKWMLGG8rrdFEcQBV2WWgkp8Kq4P7DhBB1I=;
        b=gtz1cQEy4OhyJT3WtDOt5PKIo6SoyHfylNP4xox5mx5c/2PjwNRjIqOEE0GlaPTZZ3k29X
        1lnWf2kyC5EJi3ACle/nu/1e3LBQdCwJYd5yZvXTQHvhLuR9vwMbSevlFjIOk6c2kALxBp
        AsVRmoYhzwsuQeRhhS1doumLrbuTN4s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-yGDwbzOOMhetGn8REiVGKQ-1; Wed, 13 Sep 2023 12:57:21 -0400
X-MC-Unique: yGDwbzOOMhetGn8REiVGKQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32F07185A79B;
        Wed, 13 Sep 2023 16:57:20 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D8792026D4B;
        Wed, 13 Sep 2023 16:57:18 +0000 (UTC)
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
Subject: [PATCH v4 11/13] iov_iter, net: Merge csum_and_copy_from_iter{,_full}() together
Date:   Wed, 13 Sep 2023 17:56:46 +0100
Message-ID: <20230913165648.2570623-12-dhowells@redhat.com>
In-Reply-To: <20230913165648.2570623-1-dhowells@redhat.com>
References: <20230913165648.2570623-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move csum_and_copy_from_iter_full() out of line and then merge
csum_and_copy_from_iter() into its only caller.

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
 include/linux/skbuff.h | 19 ++-----------------
 net/core/datagram.c    |  5 +++++
 net/core/skbuff.c      | 20 +++++++++++++-------
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index c81ef5d76953..be402f55f6d6 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3679,23 +3679,8 @@ static inline int __must_check skb_put_padto(struct sk_buff *skb, unsigned int l
 	return __skb_put_padto(skb, len, true);
 }
 
-struct csum_state {
-	__wsum csum;
-	size_t off;
-};
-
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
+bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i)
+	__must_check;
 
 static inline int skb_add_data(struct sk_buff *skb,
 			       struct iov_iter *from, int copy)
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 452620dd41e4..722311eeee18 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -738,6 +738,11 @@ size_t memcpy_to_iter_csum(void *iter_to, size_t progress,
 	return 0;
 }
 
+struct csum_state {
+	__wsum csum;
+	size_t off;
+};
+
 static size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *_csstate,
 				    struct iov_iter *i)
 {
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 3efed86321db..2bfa6a7ba244 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6955,13 +6955,19 @@ size_t copy_from_user_iter_csum(void __user *iter_from, size_t progress,
 	return next ? 0 : len;
 }
 
-size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
-			       struct iov_iter *i)
+bool csum_and_copy_from_iter_full(void *addr, size_t bytes,
+				  __wsum *csum, struct iov_iter *i)
 {
+	size_t copied;
+
 	if (WARN_ON_ONCE(!i->data_source))
-		return 0;
-	return iterate_and_advance2(i, bytes, addr, csum,
-				    copy_from_user_iter_csum,
-				    memcpy_from_iter_csum);
+		return false;
+	copied = iterate_and_advance2(i, bytes, addr, csum,
+				      copy_from_user_iter_csum,
+				      memcpy_from_iter_csum);
+	if (likely(copied == bytes))
+		return true;
+	iov_iter_revert(i, copied);
+	return false;
 }
-EXPORT_SYMBOL(csum_and_copy_from_iter);
+EXPORT_SYMBOL(csum_and_copy_from_iter_full);

