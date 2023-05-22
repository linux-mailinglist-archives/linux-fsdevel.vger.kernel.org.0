Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B8070BD23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 14:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbjEVMNw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 08:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbjEVMNS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 08:13:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24F9100
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 05:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684757529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FkLIsuWcxLdm5m/RLKw/6bFEvudw3Dbf8/jbJKlIa0s=;
        b=Um/6Ilx/d3wR90NS3HeXVBGZavDfeOTVxwFigPYYgs1iIKY5nPrzdjszdpfK15vEVbC2OF
        887DPZ5ynK4Jhh8lcDwsMn4q9bbvDEK5ZbV40sj3p4O5j+kr/28OianpQCkIiCnen/QINl
        /Pd4zoIfinhcZiGFITQqc/4FRQK/PgQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-cIwQpXAwOju38rvcwCBp5g-1; Mon, 22 May 2023 08:12:07 -0400
X-MC-Unique: cIwQpXAwOju38rvcwCBp5g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCA9C3800E8C;
        Mon, 22 May 2023 12:12:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57ECF7B7C;
        Mon, 22 May 2023 12:12:04 +0000 (UTC)
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
Subject: [PATCH net-next v10 10/16] tcp: Fold do_tcp_sendpages() into tcp_sendpage_locked()
Date:   Mon, 22 May 2023 13:11:19 +0100
Message-Id: <20230522121125.2595254-11-dhowells@redhat.com>
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

Fold do_tcp_sendpages() into its last remaining caller,
tcp_sendpage_locked().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Dumazet <edumazet@google.com>
cc: David Ahern <dsahern@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: netdev@vger.kernel.org
---
 include/net/tcp.h |  2 --
 net/ipv4/tcp.c    | 21 +++++++--------------
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 04a31643cda3..02a6cff1827e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -333,8 +333,6 @@ int tcp_sendpage(struct sock *sk, struct page *page, int offset, size_t size,
 		 int flags);
 int tcp_sendpage_locked(struct sock *sk, struct page *page, int offset,
 			size_t size, int flags);
-ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
-		 size_t size, int flags);
 int tcp_send_mss(struct sock *sk, int *size_goal, int flags);
 void tcp_push(struct sock *sk, int flags, int mss_now, int nonagle,
 	      int size_goal);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f3a0c02678e0..e9506cebecce 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -974,12 +974,17 @@ static int tcp_wmem_schedule(struct sock *sk, int copy)
 	return min(copy, sk->sk_forward_alloc);
 }
 
-ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
-			 size_t size, int flags)
+int tcp_sendpage_locked(struct sock *sk, struct page *page, int offset,
+			size_t size, int flags)
 {
 	struct bio_vec bvec;
 	struct msghdr msg = { .msg_flags = flags | MSG_SPLICE_PAGES, };
 
+	if (!(sk->sk_route_caps & NETIF_F_SG))
+		return sock_no_sendpage_locked(sk, page, offset, size, flags);
+
+	tcp_rate_check_app_limited(sk);  /* is sending application-limited? */
+
 	bvec_set_page(&bvec, page, size, offset);
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
 
@@ -988,18 +993,6 @@ ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
 
 	return tcp_sendmsg_locked(sk, &msg, size);
 }
-EXPORT_SYMBOL_GPL(do_tcp_sendpages);
-
-int tcp_sendpage_locked(struct sock *sk, struct page *page, int offset,
-			size_t size, int flags)
-{
-	if (!(sk->sk_route_caps & NETIF_F_SG))
-		return sock_no_sendpage_locked(sk, page, offset, size, flags);
-
-	tcp_rate_check_app_limited(sk);  /* is sending application-limited? */
-
-	return do_tcp_sendpages(sk, page, offset, size, flags);
-}
 EXPORT_SYMBOL_GPL(tcp_sendpage_locked);
 
 int tcp_sendpage(struct sock *sk, struct page *page, int offset,

