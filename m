Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F1D7AB1C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 14:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbjIVMEt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 08:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbjIVMEZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:04:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73497CD7
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 05:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695384186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i+29vAFZrXF9naWng0ipN/2z31gEil+IMifE0VymLF4=;
        b=gWD/DoprrCnRcerkEthnvWGdUBNwyXPwE73JNm+b99RoRFMKDMKauY9KUCCxUK/PaCjW9l
        kZ4A5yvsYqAFxXwsfPDs0+eeD3+X+KCrZa5G+bc/CMfQB0uo0oHF/I6dAApPkFaRR+B34S
        Pq8qxlJPFXbjzeXdzHwzQ8f4xevJfnk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-CaRM41xMMG6W6r4YEJltnA-1; Fri, 22 Sep 2023 08:03:00 -0400
X-MC-Unique: CaRM41xMMG6W6r4YEJltnA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3A55811E96;
        Fri, 22 Sep 2023 12:02:59 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA91D20268D6;
        Fri, 22 Sep 2023 12:02:57 +0000 (UTC)
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
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v6 11/13] iov_iter, net: Fold in csum_and_memcpy()
Date:   Fri, 22 Sep 2023 13:02:25 +0100
Message-ID: <20230922120227.1173720-12-dhowells@redhat.com>
In-Reply-To: <20230922120227.1173720-1-dhowells@redhat.com>
References: <20230922120227.1173720-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fold csum_and_memcpy() in to its callers.

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
 include/linux/skbuff.h | 7 -------
 net/core/datagram.c    | 3 ++-
 net/core/skbuff.c      | 3 ++-
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index d0656cc11c16..c81ef5d76953 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3679,13 +3679,6 @@ static inline int __must_check skb_put_padto(struct sk_buff *skb, unsigned int l
 	return __skb_put_padto(skb, len, true);
 }
 
-static inline __wsum csum_and_memcpy(void *to, const void *from, size_t len,
-				     __wsum sum, size_t off)
-{
-	__wsum next = csum_partial_copy_nocheck(from, to, len);
-	return csum_block_add(sum, next, off);
-}
-
 struct csum_state {
 	__wsum csum;
 	size_t off;
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 37c89d0933b7..452620dd41e4 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -732,8 +732,9 @@ size_t memcpy_to_iter_csum(void *iter_to, size_t progress,
 			   size_t len, void *from, void *priv2)
 {
 	__wsum *csum = priv2;
+	__wsum next = csum_partial_copy_nocheck(from, iter_to, len);
 
-	*csum = csum_and_memcpy(iter_to, from + progress, len, *csum, progress);
+	*csum = csum_block_add(*csum, next, progress);
 	return 0;
 }
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 5dbdfce2d05f..3efed86321db 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6938,8 +6938,9 @@ size_t memcpy_from_iter_csum(void *iter_from, size_t progress,
 			     size_t len, void *to, void *priv2)
 {
 	__wsum *csum = priv2;
+	__wsum next = csum_partial_copy_nocheck(iter_from, to + progress, len);
 
-	*csum = csum_and_memcpy(to + progress, iter_from, len, *csum, progress);
+	*csum = csum_block_add(*csum, next, progress);
 	return 0;
 }
 

