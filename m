Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25E27028B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 11:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbjEOJfA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 05:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238623AbjEOJew (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 05:34:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2FA10DB
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 02:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684143238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b0te0jKR5ygwGnEzoKAl4ELcEmhdRmxdQq46C0lqTV4=;
        b=KXRqjQ409OSwlSKhm1pUUWIJZHTH5wm0B+TMMC30g31e5ecbuNUc6J5upIhXCDpuaitMUL
        gLfvdZTmQFUS9LlVWaNhHinvxne7st6MWwUwDozzG3v/DCQ2lCdMMbjYLSt633/P/a8IzL
        8yTgcTNLU+Dr+v/V5Xp7865nNaOCBHI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-0XilkyABPe2SO0dMlnANnw-1; Mon, 15 May 2023 05:33:57 -0400
X-MC-Unique: 0XilkyABPe2SO0dMlnANnw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 571E487082A;
        Mon, 15 May 2023 09:33:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DF7E2026D16;
        Mon, 15 May 2023 09:33:53 +0000 (UTC)
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
        linux-mm@kvack.org, Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v7 01/16] net: Declare MSG_SPLICE_PAGES internal sendmsg() flag
Date:   Mon, 15 May 2023 10:33:30 +0100
Message-Id: <20230515093345.396978-2-dhowells@redhat.com>
In-Reply-To: <20230515093345.396978-1-dhowells@redhat.com>
References: <20230515093345.396978-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Declare MSG_SPLICE_PAGES, an internal sendmsg() flag, that hints to a
network protocol that it should splice pages from the source iterator
rather than copying the data if it can.  This flag is added to a list that
is cleared by sendmsg syscalls on entry.

This is intended as a replacement for the ->sendpage() op, allowing a way
to splice in several multipage folios in one go.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: netdev@vger.kernel.org
---

Notes:
    ver #7)
     - In ____sys_sendmsg(), clear internal flags before setting msg_flags.
     - Clear internal flags in uring io_send{,_zc}().

 include/linux/socket.h | 3 +++
 io_uring/net.c         | 2 ++
 net/socket.c           | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 13c3a237b9c9..bd1cc3238851 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -327,6 +327,7 @@ struct ucred {
 					  */
 
 #define MSG_ZEROCOPY	0x4000000	/* Use user data in kernel path */
+#define MSG_SPLICE_PAGES 0x8000000	/* Splice the pages from the iterator in sendmsg() */
 #define MSG_FASTOPEN	0x20000000	/* Send data in TCP SYN */
 #define MSG_CMSG_CLOEXEC 0x40000000	/* Set close_on_exec for file
 					   descriptor received through
@@ -337,6 +338,8 @@ struct ucred {
 #define MSG_CMSG_COMPAT	0		/* We never have 32 bit fixups */
 #endif
 
+/* Flags to be cleared on entry by sendmsg and sendmmsg syscalls */
+#define MSG_INTERNAL_SENDMSG_FLAGS (MSG_SPLICE_PAGES)
 
 /* Setsockoptions(2) level. Thanks to BSD these must match IPPROTO_xxx */
 #define SOL_IP		0
diff --git a/io_uring/net.c b/io_uring/net.c
index 89e839013837..f7cbb3c7a575 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -389,6 +389,7 @@ int io_send(struct io_kiocb *req, unsigned int issue_flags)
 	if (flags & MSG_WAITALL)
 		min_ret = iov_iter_count(&msg.msg_iter);
 
+	flags &= ~MSG_INTERNAL_SENDMSG_FLAGS;
 	msg.msg_flags = flags;
 	ret = sock_sendmsg(sock, &msg);
 	if (ret < min_ret) {
@@ -1136,6 +1137,7 @@ int io_send_zc(struct io_kiocb *req, unsigned int issue_flags)
 		msg_flags |= MSG_DONTWAIT;
 	if (msg_flags & MSG_WAITALL)
 		min_ret = iov_iter_count(&msg.msg_iter);
+	msg_flags &= ~MSG_INTERNAL_SENDMSG_FLAGS;
 
 	msg.msg_flags = msg_flags;
 	msg.msg_ubuf = &io_notif_to_data(zc->notif)->uarg;
diff --git a/net/socket.c b/net/socket.c
index b7e01d0fe082..3df96e9ba4e2 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2138,6 +2138,7 @@ int __sys_sendto(int fd, void __user *buff, size_t len, unsigned int flags,
 		msg.msg_name = (struct sockaddr *)&address;
 		msg.msg_namelen = addr_len;
 	}
+	flags &= ~MSG_INTERNAL_SENDMSG_FLAGS;
 	if (sock->file->f_flags & O_NONBLOCK)
 		flags |= MSG_DONTWAIT;
 	msg.msg_flags = flags;
@@ -2483,6 +2484,7 @@ static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
 		msg_sys->msg_control = ctl_buf;
 		msg_sys->msg_control_is_user = false;
 	}
+	flags &= ~MSG_INTERNAL_SENDMSG_FLAGS;
 	msg_sys->msg_flags = flags;
 
 	if (sock->file->f_flags & O_NONBLOCK)

