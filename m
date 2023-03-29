Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19ABF6CDC40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 16:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjC2OVC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 10:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjC2OTc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:19:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10B16184
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 07:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680099345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Zy7MVQlzWaHdY2cAkrhIxWsi1s53LxwKb8sGz4UC6E=;
        b=WmV57YzaV3tCHRF9+Wl1/1rU634Brh2sHJ1frUIysLA+9AQPDR3pySZIPl5jRxbvGWCaz4
        3QrBgDYgPRv6pUkrAPS2dHSRWUN9ER5SOUXIcNJAVr7Ivh5fUC5Sv+T/W20FtgPCk2FWHA
        VeY4GYHEY/efqsbWrWqq1ey8g/GWsNE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-MbBkqL9VMYWp7A_VXkoNTw-1; Wed, 29 Mar 2023 10:15:36 -0400
X-MC-Unique: MbBkqL9VMYWp7A_VXkoNTw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C09D299E75B;
        Wed, 29 Mar 2023 14:15:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B961E492C3E;
        Wed, 29 Mar 2023 14:15:13 +0000 (UTC)
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
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC PATCH v2 28/48] splice: Reimplement splice_to_socket() to pass multiple bufs to sendmsg()
Date:   Wed, 29 Mar 2023 15:13:34 +0100
Message-Id: <20230329141354.516864-29-dhowells@redhat.com>
In-Reply-To: <20230329141354.516864-1-dhowells@redhat.com>
References: <20230329141354.516864-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reimplement splice_to_socket() so that it can pass multiple pipe buffer
pages to sendmsg() in a single go.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 fs/splice.c | 148 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 120 insertions(+), 28 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 23ead122d631..d5bc28b59720 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -411,33 +411,6 @@ const struct pipe_buf_operations nosteal_pipe_buf_ops = {
 };
 EXPORT_SYMBOL(nosteal_pipe_buf_ops);
 
-#ifdef CONFIG_NET
-/*
- * Send 'sd->len' bytes to socket from 'sd->file' at position 'sd->pos'
- * using sendpage(). Return the number of bytes sent.
- */
-static int pipe_to_sendmsg(struct pipe_inode_info *pipe,
-			   struct pipe_buffer *buf, struct splice_desc *sd)
-{
-	struct socket *sock = sock_from_file(sd->u.file);
-	struct bio_vec bvec;
-	struct msghdr msg = {
-		.msg_flags = MSG_SPLICE_PAGES,
-	};
-
-	if (sd->flags & SPLICE_F_MORE)
-		msg.msg_flags |= MSG_MORE;
-
-	if (sd->len < sd->total_len &&
-	    pipe_occupancy(pipe->head, pipe->tail) > 1)
-		msg.msg_flags |= MSG_MORE;
-
-	bvec_set_page(&bvec, buf->page, sd->len, buf->offset);
-	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, sd->len);
-	return sock_sendmsg(sock, &msg);
-}
-#endif
-
 static void wakeup_pipe_writers(struct pipe_inode_info *pipe)
 {
 	smp_mb();
@@ -816,7 +789,126 @@ EXPORT_SYMBOL(iter_file_splice_write);
 ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
 			 loff_t *ppos, size_t len, unsigned int flags)
 {
-	return splice_from_pipe(pipe, out, ppos, len, flags, pipe_to_sendmsg);
+	struct socket *sock = sock_from_file(out);
+	struct bio_vec bvec[16];
+	struct msghdr msg = {};
+	ssize_t ret;
+	size_t spliced = 0;
+	bool need_wakeup = false;
+
+	pipe_lock(pipe);
+
+	while (len > 0) {
+		unsigned int head, tail, mask, bc = 0;
+		size_t remain = len;
+
+		/*
+		 * Check for signal early to make process killable when there
+		 * are always buffers available
+		 */
+		ret = -ERESTARTSYS;
+		if (signal_pending(current))
+			break;
+
+		while (pipe_empty(pipe->head, pipe->tail)) {
+			ret = 0;
+			if (!pipe->writers)
+				goto out;
+
+			if (spliced)
+				goto out;
+
+			ret = -EAGAIN;
+			if (flags & SPLICE_F_NONBLOCK)
+				goto out;
+
+			ret = -ERESTARTSYS;
+			if (signal_pending(current))
+				goto out;
+
+			if (need_wakeup) {
+				wakeup_pipe_writers(pipe);
+				need_wakeup = false;
+			}
+
+			pipe_wait_readable(pipe);
+		}
+
+		head = pipe->head;
+		tail = pipe->tail;
+		mask = pipe->ring_size - 1;
+
+		while (!pipe_empty(head, tail)) {
+			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
+			size_t seg;
+
+			if (!buf->len) {
+				tail++;
+				continue;
+			}
+
+			seg = min_t(size_t, remain, buf->len);
+			seg = min_t(size_t, seg, PAGE_SIZE);
+
+			ret = pipe_buf_confirm(pipe, buf);
+			if (unlikely(ret)) {
+				if (ret == -ENODATA)
+					ret = 0;
+				break;
+			}
+
+			bvec_set_page(&bvec[bc++], buf->page, seg, buf->offset);
+			remain -= seg;
+			if (seg >= buf->len)
+				tail++;
+			if (bc >= ARRAY_SIZE(bvec))
+				break;
+		}
+
+		if (!bc)
+			break;
+
+		msg.msg_flags = 0;
+		if (flags & SPLICE_F_MORE)
+			msg.msg_flags = MSG_MORE;
+		if (remain && pipe_occupancy(pipe->head, tail) > 0)
+			msg.msg_flags = MSG_MORE;
+		msg.msg_flags |= MSG_SPLICE_PAGES;
+
+		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, bvec, bc, len - remain);
+		ret = sock_sendmsg(sock, &msg);
+		if (ret <= 0)
+			break;
+
+		spliced += ret;
+		len -= ret;
+		tail = pipe->tail;
+		while (ret > 0) {
+			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
+			size_t seg = min_t(size_t, ret, buf->len);
+
+			buf->offset += seg;
+			buf->len -= seg;
+			ret -= seg;
+
+			if (!buf->len) {
+				pipe_buf_release(pipe, buf);
+				tail++;
+			}
+		}
+
+		if (tail != pipe->tail) {
+			pipe->tail = tail;
+			if (pipe->files)
+				need_wakeup = true;
+		}
+	}
+
+out:
+	pipe_unlock(pipe);
+	if (need_wakeup)
+		wakeup_pipe_writers(pipe);
+	return spliced ?: ret;
 }
 #endif
 

