Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA430707F8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 13:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjERLg5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 07:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjERLgb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 07:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B515173E
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 04:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684409742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JUrQ0rsOJEKe2VauAy4RSjWfQDMPveXienxXCaL8A+w=;
        b=e56nMR9oNtJcT6aa9S51WkRDLQ4yjMZHCk74AN3zogoIU/lbm7k9a1cSLUby4F60aYhWfe
        0DZ7Kohe5ulWIHsV5UR1c7Q6rPId1n7pElLyuNKL29DK8kRkG/hRkH9pPsiEEBqtrHeNtd
        0rcg7yWluXIsdBfDNE6HAGpXmBeqSaA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-Of9dg0BOOn66lre7Opvf8A-1; Thu, 18 May 2023 07:35:39 -0400
X-MC-Unique: Of9dg0BOOn66lre7Opvf8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D25829DD980;
        Thu, 18 May 2023 11:35:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D496C2166B31;
        Thu, 18 May 2023 11:35:35 +0000 (UTC)
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
        linux-mm@kvack.org, Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH net-next v8 08/16] tls: Inline do_tcp_sendpages()
Date:   Thu, 18 May 2023 12:34:45 +0100
Message-Id: <20230518113453.1350757-9-dhowells@redhat.com>
In-Reply-To: <20230518113453.1350757-1-dhowells@redhat.com>
References: <20230518113453.1350757-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

do_tcp_sendpages() is now just a small wrapper around tcp_sendmsg_locked(),
so inline it, allowing do_tcp_sendpages() to be removed.  This is part of
replacing ->sendpage() with a call to sendmsg() with MSG_SPLICE_PAGES set.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Boris Pismenny <borisp@nvidia.com>
cc: John Fastabend <john.fastabend@gmail.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: netdev@vger.kernel.org
---
 include/net/tls.h  |  2 +-
 net/tls/tls_main.c | 24 +++++++++++++++---------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 6056ce5a2aa5..5791ca7a189c 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -258,7 +258,7 @@ struct tls_context {
 	struct scatterlist *partially_sent_record;
 	u16 partially_sent_offset;
 
-	bool in_tcp_sendpages;
+	bool splicing_pages;
 	bool pending_open_record_frags;
 
 	struct mutex tx_lock; /* protects partially_sent_* fields and
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index f2e7302a4d96..3d45fdb5c4e9 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -125,7 +125,10 @@ int tls_push_sg(struct sock *sk,
 		u16 first_offset,
 		int flags)
 {
-	int sendpage_flags = flags | MSG_SENDPAGE_NOTLAST;
+	struct bio_vec bvec;
+	struct msghdr msg = {
+		.msg_flags = MSG_SENDPAGE_NOTLAST | MSG_SPLICE_PAGES | flags,
+	};
 	int ret = 0;
 	struct page *p;
 	size_t size;
@@ -134,16 +137,19 @@ int tls_push_sg(struct sock *sk,
 	size = sg->length - offset;
 	offset += sg->offset;
 
-	ctx->in_tcp_sendpages = true;
+	ctx->splicing_pages = true;
 	while (1) {
 		if (sg_is_last(sg))
-			sendpage_flags = flags;
+			msg.msg_flags = flags;
 
 		/* is sending application-limited? */
 		tcp_rate_check_app_limited(sk);
 		p = sg_page(sg);
 retry:
-		ret = do_tcp_sendpages(sk, p, offset, size, sendpage_flags);
+		bvec_set_page(&bvec, p, size, offset);
+		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
+
+		ret = tcp_sendmsg_locked(sk, &msg, size);
 
 		if (ret != size) {
 			if (ret > 0) {
@@ -155,7 +161,7 @@ int tls_push_sg(struct sock *sk,
 			offset -= sg->offset;
 			ctx->partially_sent_offset = offset;
 			ctx->partially_sent_record = (void *)sg;
-			ctx->in_tcp_sendpages = false;
+			ctx->splicing_pages = false;
 			return ret;
 		}
 
@@ -169,7 +175,7 @@ int tls_push_sg(struct sock *sk,
 		size = sg->length;
 	}
 
-	ctx->in_tcp_sendpages = false;
+	ctx->splicing_pages = false;
 
 	return 0;
 }
@@ -247,11 +253,11 @@ static void tls_write_space(struct sock *sk)
 {
 	struct tls_context *ctx = tls_get_ctx(sk);
 
-	/* If in_tcp_sendpages call lower protocol write space handler
+	/* If splicing_pages call lower protocol write space handler
 	 * to ensure we wake up any waiting operations there. For example
-	 * if do_tcp_sendpages where to call sk_wait_event.
+	 * if splicing pages where to call sk_wait_event.
 	 */
-	if (ctx->in_tcp_sendpages) {
+	if (ctx->splicing_pages) {
 		ctx->sk_write_space(sk);
 		return;
 	}

