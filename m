Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94226CDC4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 16:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjC2OWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 10:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjC2OUf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:20:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538E961A4
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 07:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680099348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pMIF11EWm/8cej/KXQhM8DA1wUu2yCmqcuxOX1F+AiY=;
        b=V86LIBwSGpkib+VJnc4A7sLtmU4N1fe3eRmG35IlpueGTtNSkHJosMJc/Pm3cCiaE6gf2S
        L2BFbpKsaWUHY2LrgQLaMfcHec0LHbQZgpM09+Ew77tZsxynpTXMPetnFjmGARiFeh7cU5
        8zirau/ZGS/QfRE7EctJaMw78GGxw3Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-exPjG2AiPg65VJXx__yQjQ-1; Wed, 29 Mar 2023 10:15:45 -0400
X-MC-Unique: exPjG2AiPg65VJXx__yQjQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99A6F185A7A4;
        Wed, 29 Mar 2023 14:15:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BD31202701E;
        Wed, 29 Mar 2023 14:15:41 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
Subject: [RFC PATCH v2 38/48] rds: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage
Date:   Wed, 29 Mar 2023 15:13:44 +0100
Message-Id: <20230329141354.516864-39-dhowells@redhat.com>
In-Reply-To: <20230329141354.516864-1-dhowells@redhat.com>
References: <20230329141354.516864-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When transmitting data, call down into TCP using a single sendmsg with
MSG_SPLICE_PAGES to indicate that content should be spliced rather than
performing several sendmsg and sendpage calls to transmit header and data
pages.

To make this work, the data is assembled in a bio_vec array and attached to
a BVEC-type iterator.  The header are copied into memory acquired from
zcopy_alloc() which just breaks a page up into small pieces that can be
freed with put_page().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Santosh Shilimkar <santosh.shilimkar@oracle.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-rdma@vger.kernel.org
cc: rds-devel@oss.oracle.com
cc: netdev@vger.kernel.org
---
 net/rds/tcp_send.c | 86 +++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 46 deletions(-)

diff --git a/net/rds/tcp_send.c b/net/rds/tcp_send.c
index 8c4d1d6e9249..660d9f203d99 100644
--- a/net/rds/tcp_send.c
+++ b/net/rds/tcp_send.c
@@ -52,29 +52,24 @@ void rds_tcp_xmit_path_complete(struct rds_conn_path *cp)
 	tcp_sock_set_cork(tc->t_sock->sk, false);
 }
 
-/* the core send_sem serializes this with other xmit and shutdown */
-static int rds_tcp_sendmsg(struct socket *sock, void *data, unsigned int len)
-{
-	struct kvec vec = {
-		.iov_base = data,
-		.iov_len = len,
-	};
-	struct msghdr msg = {
-		.msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL,
-	};
-
-	return kernel_sendmsg(sock, &msg, &vec, 1, vec.iov_len);
-}
-
 /* the core send_sem serializes this with other xmit and shutdown */
 int rds_tcp_xmit(struct rds_connection *conn, struct rds_message *rm,
 		 unsigned int hdr_off, unsigned int sg, unsigned int off)
 {
 	struct rds_conn_path *cp = rm->m_inc.i_conn_path;
 	struct rds_tcp_connection *tc = cp->cp_transport_data;
+	struct msghdr msg = {
+		.msg_flags = MSG_SPLICE_PAGES | MSG_DONTWAIT | MSG_NOSIGNAL,
+	};
+	struct bio_vec *bvec;
+	unsigned int i, size = 0, ix = 0;
+	bool free_hdr = false;
 	int done = 0;
-	int ret = 0;
-	int more;
+	int ret = -ENOMEM;
+
+	bvec = kmalloc_array(1 + sg, sizeof(struct bio_vec), GFP_KERNEL);
+	if (!bvec)
+		goto out;
 
 	if (hdr_off == 0) {
 		/*
@@ -99,43 +94,37 @@ int rds_tcp_xmit(struct rds_connection *conn, struct rds_message *rm,
 
 	if (hdr_off < sizeof(struct rds_header)) {
 		/* see rds_tcp_write_space() */
+		void *p;
+
 		set_bit(SOCK_NOSPACE, &tc->t_sock->sk->sk_socket->flags);
 
-		ret = rds_tcp_sendmsg(tc->t_sock,
-				      (void *)&rm->m_inc.i_hdr + hdr_off,
-				      sizeof(rm->m_inc.i_hdr) - hdr_off);
-		if (ret < 0)
-			goto out;
-		done += ret;
-		if (hdr_off + done != sizeof(struct rds_header))
+		ret = -ENOMEM;
+		p = page_frag_memdup(NULL,
+				     (void *)&rm->m_inc.i_hdr + hdr_off,
+				     sizeof(rm->m_inc.i_hdr) - hdr_off,
+				     GFP_KERNEL, ULONG_MAX);
+		if (!p)
 			goto out;
+		bvec_set_virt(&bvec[ix], p, sizeof(rm->m_inc.i_hdr) - hdr_off);
+		free_hdr = true;
+		size += bvec[ix].bv_len;
+		ix++;
 	}
 
-	more = rm->data.op_nents > 1 ? (MSG_MORE | MSG_SENDPAGE_NOTLAST) : 0;
-	while (sg < rm->data.op_nents) {
-		int flags = MSG_DONTWAIT | MSG_NOSIGNAL | more;
-
-		ret = tc->t_sock->ops->sendpage(tc->t_sock,
-						sg_page(&rm->data.op_sg[sg]),
-						rm->data.op_sg[sg].offset + off,
-						rm->data.op_sg[sg].length - off,
-						flags);
-		rdsdebug("tcp sendpage %p:%u:%u ret %d\n", (void *)sg_page(&rm->data.op_sg[sg]),
-			 rm->data.op_sg[sg].offset + off, rm->data.op_sg[sg].length - off,
-			 ret);
-		if (ret <= 0)
-			break;
-
-		off += ret;
-		done += ret;
-		if (off == rm->data.op_sg[sg].length) {
-			off = 0;
-			sg++;
-		}
-		if (sg == rm->data.op_nents - 1)
-			more = 0;
+	for (i = sg; i < rm->data.op_nents; i++) {
+		bvec_set_page(&bvec[ix],
+			      sg_page(&rm->data.op_sg[i]),
+			      rm->data.op_sg[i].length - off,
+			      rm->data.op_sg[i].offset + off);
+		off = 0;
+		size += bvec[ix].bv_len;
+		ix++;
 	}
 
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, bvec, ix, size);
+	ret = sock_sendmsg(tc->t_sock, &msg);
+	rdsdebug("tcp sendmsg-splice %u,%u ret %d\n", ix, size, ret);
+
 out:
 	if (ret <= 0) {
 		/* write_space will hit after EAGAIN, all else fatal */
@@ -158,6 +147,11 @@ int rds_tcp_xmit(struct rds_connection *conn, struct rds_message *rm,
 	}
 	if (done == 0)
 		done = ret;
+	if (bvec) {
+		if (free_hdr)
+			put_page(bvec[0].bv_page);
+		kfree(bvec);
+	}
 	return done;
 }
 

