Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864F570BD22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 14:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbjEVMNs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 08:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbjEVMNQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 08:13:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE98C6
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 05:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684757514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2EXLlBUI8HMrlq1LdzuePmnE9vo0jChMg019VHUJEgs=;
        b=aO5M9a8WNqby2WbVFYP6mAZtKIjLpIIPq4vxF/gVXDioL1Dx1FN0VduWtgwMStH3tpQ1kF
        Di+B8+3zZrXCU/YFs/glDRLL8094sgXztFZl3OYgERo5iChZ7TYbNNQovJGB2ZJM93CQje
        5dnAbwxJGTdvttyAN5aEKKfXL9KdODo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-fpogOg9rPfSKKoQ1z-hkZA-1; Mon, 22 May 2023 08:11:51 -0400
X-MC-Unique: fpogOg9rPfSKKoQ1z-hkZA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 298F3802355;
        Mon, 22 May 2023 12:11:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5AD417C52;
        Mon, 22 May 2023 12:11:47 +0000 (UTC)
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
        linux-mm@kvack.org, John Fastabend <john.fastabend@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Subject: [PATCH net-next v10 06/16] tcp_bpf: Inline do_tcp_sendpages as it's now a wrapper around tcp_sendmsg
Date:   Mon, 22 May 2023 13:11:15 +0100
Message-Id: <20230522121125.2595254-7-dhowells@redhat.com>
In-Reply-To: <20230522121125.2595254-1-dhowells@redhat.com>
References: <20230522121125.2595254-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

do_tcp_sendpages() is now just a small wrapper around tcp_sendmsg_locked(),
so inline it.  This is part of replacing ->sendpage() with a call to
sendmsg() with MSG_SPLICE_PAGES set.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: John Fastabend <john.fastabend@gmail.com>
cc: Jakub Sitnicki <jakub@cloudflare.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: David Ahern <dsahern@kernel.org>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: netdev@vger.kernel.org
cc: bpf@vger.kernel.org
---
 net/ipv4/tcp_bpf.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 2e9547467edb..0291d15acd19 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -72,11 +72,13 @@ static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
 {
 	bool apply = apply_bytes;
 	struct scatterlist *sge;
+	struct msghdr msghdr = { .msg_flags = flags | MSG_SPLICE_PAGES, };
 	struct page *page;
 	int size, ret = 0;
 	u32 off;
 
 	while (1) {
+		struct bio_vec bvec;
 		bool has_tx_ulp;
 
 		sge = sk_msg_elem(msg, msg->sg.start);
@@ -88,16 +90,18 @@ static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
 		tcp_rate_check_app_limited(sk);
 retry:
 		has_tx_ulp = tls_sw_has_ctx_tx(sk);
-		if (has_tx_ulp) {
-			flags |= MSG_SENDPAGE_NOPOLICY;
-			ret = kernel_sendpage_locked(sk,
-						     page, off, size, flags);
-		} else {
-			ret = do_tcp_sendpages(sk, page, off, size, flags);
-		}
+		if (has_tx_ulp)
+			msghdr.msg_flags |= MSG_SENDPAGE_NOPOLICY;
 
+		if (flags & MSG_SENDPAGE_NOTLAST)
+			msghdr.msg_flags |= MSG_MORE;
+
+		bvec_set_page(&bvec, page, size, off);
+		iov_iter_bvec(&msghdr.msg_iter, ITER_SOURCE, &bvec, 1, size);
+		ret = tcp_sendmsg_locked(sk, &msghdr, size);
 		if (ret <= 0)
 			return ret;
+
 		if (apply)
 			apply_bytes -= ret;
 		msg->sg.size -= ret;
@@ -404,7 +408,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	long timeo;
 	int flags;
 
-	/* Don't let internal do_tcp_sendpages() flags through */
+	/* Don't let internal sendpage flags through */
 	flags = (msg->msg_flags & ~MSG_SENDPAGE_DECRYPTED);
 	flags |= MSG_NO_SHARED_FRAGS;
 

