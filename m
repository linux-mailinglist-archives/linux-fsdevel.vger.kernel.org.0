Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107B97028E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 11:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238810AbjEOJhV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 05:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239441AbjEOJfz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 05:35:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2A5170E
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 02:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684143304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wF+2b4fBEfy00AN3VDBr6eYpnbX7vBgnsz0rKmJdTGo=;
        b=ZQmILozE5fw8BZWKXiXaBBnuX6H0rKpH/7F8B3lRLudFq6AW+bf18Cbzph1cRKiaHo91Tp
        T0vv4dF2pCPS7uRmvGaD1opsqc/K9Sx5bdwsnKENi6Qq5Cbig1sYi7xO9E32S/xxzdqE+w
        ZT87YFDs/Q+TfGF4AHZM3vqeKfT/XuM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-mv3QcuzZMBiItf3Uupm36w-1; Mon, 15 May 2023 05:34:59 -0400
X-MC-Unique: mv3QcuzZMBiItf3Uupm36w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FEA6101A551;
        Mon, 15 May 2023 09:34:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 880FB4021C6;
        Mon, 15 May 2023 09:34:55 +0000 (UTC)
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
        linux-mm@kvack.org, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net-next v7 16/16] unix: Convert udp_sendpage() to use MSG_SPLICE_PAGES
Date:   Mon, 15 May 2023 10:33:45 +0100
Message-Id: <20230515093345.396978-17-dhowells@redhat.com>
In-Reply-To: <20230515093345.396978-1-dhowells@redhat.com>
References: <20230515093345.396978-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert unix_stream_sendpage() to use sendmsg() with MSG_SPLICE_PAGES
rather than directly splicing in the pages itself.

This allows ->sendpage() to be replaced by something that can handle
multiple multipage folios in a single transaction.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Kuniyuki Iwashima <kuniyu@amazon.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: netdev@vger.kernel.org
---
 net/unix/af_unix.c | 134 +++------------------------------------------
 1 file changed, 7 insertions(+), 127 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 976bc1c5e11b..115436ce1f8a 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1839,24 +1839,6 @@ static void maybe_add_creds(struct sk_buff *skb, const struct socket *sock,
 	}
 }
 
-static int maybe_init_creds(struct scm_cookie *scm,
-			    struct socket *socket,
-			    const struct sock *other)
-{
-	int err;
-	struct msghdr msg = { .msg_controllen = 0 };
-
-	err = scm_send(socket, &msg, scm, false);
-	if (err)
-		return err;
-
-	if (unix_passcred_enabled(socket, other)) {
-		scm->pid = get_pid(task_tgid(current));
-		current_uid_gid(&scm->creds.uid, &scm->creds.gid);
-	}
-	return err;
-}
-
 static bool unix_skb_scm_eq(struct sk_buff *skb,
 			    struct scm_cookie *scm)
 {
@@ -2292,117 +2274,15 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 static ssize_t unix_stream_sendpage(struct socket *socket, struct page *page,
 				    int offset, size_t size, int flags)
 {
-	int err;
-	bool send_sigpipe = false;
-	bool init_scm = true;
-	struct scm_cookie scm;
-	struct sock *other, *sk = socket->sk;
-	struct sk_buff *skb, *newskb = NULL, *tail = NULL;
-
-	if (flags & MSG_OOB)
-		return -EOPNOTSUPP;
+	struct bio_vec bvec;
+	struct msghdr msg = { .msg_flags = flags | MSG_SPLICE_PAGES };
 
-	other = unix_peer(sk);
-	if (!other || sk->sk_state != TCP_ESTABLISHED)
-		return -ENOTCONN;
-
-	if (false) {
-alloc_skb:
-		unix_state_unlock(other);
-		mutex_unlock(&unix_sk(other)->iolock);
-		newskb = sock_alloc_send_pskb(sk, 0, 0, flags & MSG_DONTWAIT,
-					      &err, 0);
-		if (!newskb)
-			goto err;
-	}
-
-	/* we must acquire iolock as we modify already present
-	 * skbs in the sk_receive_queue and mess with skb->len
-	 */
-	err = mutex_lock_interruptible(&unix_sk(other)->iolock);
-	if (err) {
-		err = flags & MSG_DONTWAIT ? -EAGAIN : -ERESTARTSYS;
-		goto err;
-	}
-
-	if (sk->sk_shutdown & SEND_SHUTDOWN) {
-		err = -EPIPE;
-		send_sigpipe = true;
-		goto err_unlock;
-	}
-
-	unix_state_lock(other);
+	if (flags & MSG_SENDPAGE_NOTLAST)
+		msg.msg_flags |= MSG_MORE;
 
-	if (sock_flag(other, SOCK_DEAD) ||
-	    other->sk_shutdown & RCV_SHUTDOWN) {
-		err = -EPIPE;
-		send_sigpipe = true;
-		goto err_state_unlock;
-	}
-
-	if (init_scm) {
-		err = maybe_init_creds(&scm, socket, other);
-		if (err)
-			goto err_state_unlock;
-		init_scm = false;
-	}
-
-	skb = skb_peek_tail(&other->sk_receive_queue);
-	if (tail && tail == skb) {
-		skb = newskb;
-	} else if (!skb || !unix_skb_scm_eq(skb, &scm)) {
-		if (newskb) {
-			skb = newskb;
-		} else {
-			tail = skb;
-			goto alloc_skb;
-		}
-	} else if (newskb) {
-		/* this is fast path, we don't necessarily need to
-		 * call to kfree_skb even though with newskb == NULL
-		 * this - does no harm
-		 */
-		consume_skb(newskb);
-		newskb = NULL;
-	}
-
-	if (skb_append_pagefrags(skb, page, offset, size, MAX_SKB_FRAGS)) {
-		tail = skb;
-		goto alloc_skb;
-	}
-
-	skb->len += size;
-	skb->data_len += size;
-	skb->truesize += size;
-	refcount_add(size, &sk->sk_wmem_alloc);
-
-	if (newskb) {
-		err = unix_scm_to_skb(&scm, skb, false);
-		if (err)
-			goto err_state_unlock;
-		spin_lock(&other->sk_receive_queue.lock);
-		__skb_queue_tail(&other->sk_receive_queue, newskb);
-		spin_unlock(&other->sk_receive_queue.lock);
-	}
-
-	unix_state_unlock(other);
-	mutex_unlock(&unix_sk(other)->iolock);
-
-	other->sk_data_ready(other);
-	scm_destroy(&scm);
-	return size;
-
-err_state_unlock:
-	unix_state_unlock(other);
-err_unlock:
-	mutex_unlock(&unix_sk(other)->iolock);
-err:
-	kfree_skb(newskb);
-	if (send_sigpipe && !(flags & MSG_NOSIGNAL))
-		send_sig(SIGPIPE, current, 0);
-	if (!init_scm)
-		scm_destroy(&scm);
-	return err;
+	bvec_set_page(&bvec, page, size, offset);
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
+	return unix_stream_sendmsg(socket, &msg, size);
 }
 
 static int unix_seqpacket_sendmsg(struct socket *sock, struct msghdr *msg,

