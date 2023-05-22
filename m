Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBD770BD17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 14:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjEVMNc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 08:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjEVMNM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 08:13:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A850DCD
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 05:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684757521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tYeoTX9B8dad49qWPHePVLYzX6oyR1jBlVymL6Q5Zsc=;
        b=G1pOCN7LR6Tqu2xzZh1s0WyoLmr5UkQNeNSifvuOCOd1xUIjXMywQ54mahFQ/Vka0LZ6jO
        w0Cip4rYlHibUNuA25E9lQSlfVRS1lqi/Ifc/N6M7pg6++km6Ostbi77YEtjcHwq1UtjFS
        6WQQpSnsCGeaoSxMtLVYHZnY7D6ADwE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-z_k6b1dFNWyCPfMJlHKjGw-1; Mon, 22 May 2023 08:11:55 -0400
X-MC-Unique: z_k6b1dFNWyCPfMJlHKjGw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 096DF811E8F;
        Mon, 22 May 2023 12:11:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9261C54F80;
        Mon, 22 May 2023 12:11:50 +0000 (UTC)
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
        linux-mm@kvack.org,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH net-next v10 07/16] espintcp: Inline do_tcp_sendpages()
Date:   Mon, 22 May 2023 13:11:16 +0100
Message-Id: <20230522121125.2595254-8-dhowells@redhat.com>
In-Reply-To: <20230522121125.2595254-1-dhowells@redhat.com>
References: <20230522121125.2595254-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

do_tcp_sendpages() is now just a small wrapper around tcp_sendmsg_locked(),
so inline it, allowing do_tcp_sendpages() to be removed.  This is part of
replacing ->sendpage() with a call to sendmsg() with MSG_SPLICE_PAGES set.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steffen Klassert <steffen.klassert@secunet.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: David Ahern <dsahern@kernel.org>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: netdev@vger.kernel.org
---
 net/xfrm/espintcp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index 872b80188e83..3504925babdb 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -205,14 +205,16 @@ static int espintcp_sendskb_locked(struct sock *sk, struct espintcp_msg *emsg,
 static int espintcp_sendskmsg_locked(struct sock *sk,
 				     struct espintcp_msg *emsg, int flags)
 {
+	struct msghdr msghdr = { .msg_flags = flags | MSG_SPLICE_PAGES, };
 	struct sk_msg *skmsg = &emsg->skmsg;
 	struct scatterlist *sg;
 	int done = 0;
 	int ret;
 
-	flags |= MSG_SENDPAGE_NOTLAST;
+	msghdr.msg_flags |= MSG_SENDPAGE_NOTLAST;
 	sg = &skmsg->sg.data[skmsg->sg.start];
 	do {
+		struct bio_vec bvec;
 		size_t size = sg->length - emsg->offset;
 		int offset = sg->offset + emsg->offset;
 		struct page *p;
@@ -220,11 +222,13 @@ static int espintcp_sendskmsg_locked(struct sock *sk,
 		emsg->offset = 0;
 
 		if (sg_is_last(sg))
-			flags &= ~MSG_SENDPAGE_NOTLAST;
+			msghdr.msg_flags &= ~MSG_SENDPAGE_NOTLAST;
 
 		p = sg_page(sg);
 retry:
-		ret = do_tcp_sendpages(sk, p, offset, size, flags);
+		bvec_set_page(&bvec, p, size, offset);
+		iov_iter_bvec(&msghdr.msg_iter, ITER_SOURCE, &bvec, 1, size);
+		ret = tcp_sendmsg_locked(sk, &msghdr, size);
 		if (ret < 0) {
 			emsg->offset = offset - sg->offset;
 			skmsg->sg.start += done;

