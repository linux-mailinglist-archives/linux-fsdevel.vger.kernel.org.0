Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A093707F9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 13:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjERLhd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 07:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjERLgt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 07:36:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E501BE9
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 04:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684409763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=arPLIYOMzcdUPWLjuF22tHo0vP4jVzFFThikgCzP+CE=;
        b=B4YPxMh3mFJwxulLSu8BE1aodJ0RrmckH7IQp04hkT2gstvrC87RKrFOHcI/LUQN6KPTWt
        y2IhjRWZGzAyndnCarDvqNycedPnq/jFbw1ZPccYBN7lgGxnof1JgqlbvBln4cYD4g4bMq
        corbumGWQASnNUrW5Lz3wyZJV5xu1TI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-zr9gaF3vOCeYO5wuwbnLTQ-1; Thu, 18 May 2023 07:35:58 -0400
X-MC-Unique: zr9gaF3vOCeYO5wuwbnLTQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19F6086C60D;
        Thu, 18 May 2023 11:35:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6844440C206F;
        Thu, 18 May 2023 11:35:54 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH net-next v8 13/16] udp: Convert udp_sendpage() to use MSG_SPLICE_PAGES
Date:   Thu, 18 May 2023 12:34:50 +0100
Message-Id: <20230518113453.1350757-14-dhowells@redhat.com>
In-Reply-To: <20230518113453.1350757-1-dhowells@redhat.com>
References: <20230518113453.1350757-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert udp_sendpage() to use sendmsg() with MSG_SPLICE_PAGES rather than
directly splicing in the pages itself.

This allows ->sendpage() to be replaced by something that can handle
multiple multipage folios in a single transaction.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
cc: David Ahern <dsahern@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: netdev@vger.kernel.org
---

Notes:
    ver #6)
     - udp_sendpage() shouldn't lock the socket around udp_sendpage().
     - udp_sendpage() should only set MSG_MORE if MSG_SENDPAGE_NOTLAST is set.

 net/ipv4/udp.c | 51 ++++++--------------------------------------------
 1 file changed, 6 insertions(+), 45 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index aa32afd871ee..2879dc6d66ea 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1332,54 +1332,15 @@ EXPORT_SYMBOL(udp_sendmsg);
 int udp_sendpage(struct sock *sk, struct page *page, int offset,
 		 size_t size, int flags)
 {
-	struct inet_sock *inet = inet_sk(sk);
-	struct udp_sock *up = udp_sk(sk);
-	int ret;
+	struct bio_vec bvec;
+	struct msghdr msg = { .msg_flags = flags | MSG_SPLICE_PAGES };
 
 	if (flags & MSG_SENDPAGE_NOTLAST)
-		flags |= MSG_MORE;
-
-	if (!up->pending) {
-		struct msghdr msg = {	.msg_flags = flags|MSG_MORE };
-
-		/* Call udp_sendmsg to specify destination address which
-		 * sendpage interface can't pass.
-		 * This will succeed only when the socket is connected.
-		 */
-		ret = udp_sendmsg(sk, &msg, 0);
-		if (ret < 0)
-			return ret;
-	}
-
-	lock_sock(sk);
+		msg.msg_flags |= MSG_MORE;
 
-	if (unlikely(!up->pending)) {
-		release_sock(sk);
-
-		net_dbg_ratelimited("cork failed\n");
-		return -EINVAL;
-	}
-
-	ret = ip_append_page(sk, &inet->cork.fl.u.ip4,
-			     page, offset, size, flags);
-	if (ret == -EOPNOTSUPP) {
-		release_sock(sk);
-		return sock_no_sendpage(sk->sk_socket, page, offset,
-					size, flags);
-	}
-	if (ret < 0) {
-		udp_flush_pending_frames(sk);
-		goto out;
-	}
-
-	up->len += size;
-	if (!(READ_ONCE(up->corkflag) || (flags&MSG_MORE)))
-		ret = udp_push_pending_frames(sk);
-	if (!ret)
-		ret = size;
-out:
-	release_sock(sk);
-	return ret;
+	bvec_set_page(&bvec, page, size, offset);
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
+	return udp_sendmsg(sk, &msg, size);
 }
 
 #define UDP_SKB_IS_STATELESS 0x80000000

