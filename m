Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFE976BF01
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 23:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjHAVLK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 17:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjHAVLG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:11:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D703DE67
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 14:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690924216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DI/Y27iYKk+GE2VbFkdqv51tvM927ZHMATm+vJN1hrs=;
        b=e0JDJwbvfoESn9+plrQPt2RroSxZ4ydPvjN7b7vjFgzWHI8aExiLDQ7tEll7ZIjaqYWR+n
        jN2xJRynxdkD64IX907PukxftWDDgo4k6tit5C0GCIX72AFdC1N8SgquFHLRH9LBElly+Q
        zOn2TXGq864BssY+5L9QDpIUgmH2RZ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-rpc81ftLN8q6r6O45lqd1A-1; Tue, 01 Aug 2023 17:10:13 -0400
X-MC-Unique: rpc81ftLN8q6r6O45lqd1A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC98A856F66;
        Tue,  1 Aug 2023 21:10:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03F2240C6CCC;
        Tue,  1 Aug 2023 21:10:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
cc:     dhowells@redhat.com,
        syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com,
        bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH net v2] udp: Fix __ip{,6}_append_data()'s handling of MSG_SPLICE_PAGES
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1569148.1690924207.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 01 Aug 2023 22:10:07 +0100
Message-ID: <1569149.1690924207@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__ip_append_data() can get into an infinite loop when asked to splice into
a partially-built UDP message that has more than the frag-limit data and u=
p
to the MTU limit.  Something like:

        pipe(pfd);
        sfd =3D socket(AF_INET, SOCK_DGRAM, 0);
        connect(sfd, ...);
        send(sfd, buffer, 8161, MSG_CONFIRM|MSG_MORE);
        write(pfd[1], buffer, 8);
        splice(pfd[0], 0, sfd, 0, 0x4ffe0ul, 0);

where the amount of data given to send() is dependent on the MTU size (in
this instance an interface with an MTU of 8192).

The problem is that the calculation of the amount to copy in
__ip_append_data() goes negative in two places, and, in the second place,
this gets subtracted from the length remaining, thereby increasing it.

This happens when pagedlen > 0 (which happens for MSG_ZEROCOPY and
MSG_SPLICE_PAGES), the terms in:

        copy =3D datalen - transhdrlen - fraggap - pagedlen;

then mostly cancel when pagedlen is substituted for, leaving just -fraggap=
.
This causes:

        length -=3D copy + transhdrlen;

to increase the length to more than the amount of data in msg->msg_iter,
which causes skb_splice_from_iter() to be unable to fill the request and i=
t
returns less than 'copied' - which means that length never gets to 0 and w=
e
never exit the loop.

Fix this by:

 (1) Insert a note about the dodgy calculation of 'copy'.

 (2) If MSG_SPLICE_PAGES, clear copy if it is negative from the above
     equation, so that 'offset' isn't regressed and 'length' isn't
     increased, which will mean that length and thus copy should match the
     amount left in the iterator.

 (3) When handling MSG_SPLICE_PAGES, give a warning and return -EIO if
     we're asked to splice more than is in the iterator.  It might be
     better to not give the warning or even just give a 'short' write.

The same problem occurs in __ip6_append_data(), except that there's a chec=
k
in there that errors out with EINVAL if copy < 0.  Fix this function in
much the same way as the ipv4 variant but also skip the erroring out if
copy < 0.

[!] Note that this ought to also affect MSG_ZEROCOPY, but MSG_ZEROCOPY
avoids the problem by simply assuming that everything asked for got copied=
,
not just the amount that was in the iterator.  This is a potential bug for
the future.

Fixes: 7ac7c987850c ("udp: Convert udp_sendpage() to use MSG_SPLICE_PAGES"=
)
Fixes: 6d8192bd69bb ("ip6, udp6: Support MSG_SPLICE_PAGES")
Reported-by: syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/000000000000881d0606004541d1@google.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: David Ahern <dsahern@kernel.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: netdev@vger.kernel.org
---
ver #2)
 - Fix __ip6_append_data() also.

 net/ipv4/ip_output.c  |    9 +++++++++
 net/ipv6/ip6_output.c |   11 ++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)
    =

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 6e70839257f7..91715603cf6e 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1158,10 +1158,15 @@ static int __ip_append_data(struct sock *sk,
 			}
 =

 			copy =3D datalen - transhdrlen - fraggap - pagedlen;
+			/* [!] NOTE: copy will be negative if pagedlen>0
+			 * because then the equation reduces to -fraggap.
+			 */
 			if (copy > 0 && getfrag(from, data + transhdrlen, offset, copy, fragga=
p, skb) < 0) {
 				err =3D -EFAULT;
 				kfree_skb(skb);
 				goto error;
+			} else if (flags & MSG_SPLICE_PAGES) {
+				copy =3D 0;
 			}
 =

 			offset +=3D copy;
@@ -1209,6 +1214,10 @@ static int __ip_append_data(struct sock *sk,
 		} else if (flags & MSG_SPLICE_PAGES) {
 			struct msghdr *msg =3D from;
 =

+			err =3D -EIO;
+			if (WARN_ON_ONCE(copy > msg->msg_iter.count))
+				goto error;
+
 			err =3D skb_splice_from_iter(skb, &msg->msg_iter, copy,
 						   sk->sk_allocation);
 			if (err < 0)
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 1e8c90e97608..bc96559bbf0f 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1693,7 +1693,10 @@ static int __ip6_append_data(struct sock *sk,
 			fraglen =3D datalen + fragheaderlen;
 =

 			copy =3D datalen - transhdrlen - fraggap - pagedlen;
-			if (copy < 0) {
+			/* [!] NOTE: copy may be negative if pagedlen>0
+			 * because then the equation may reduces to -fraggap.
+			 */
+			if (copy < 0 && !(flags & MSG_SPLICE_PAGES)) {
 				err =3D -EINVAL;
 				goto error;
 			}
@@ -1744,6 +1747,8 @@ static int __ip6_append_data(struct sock *sk,
 				err =3D -EFAULT;
 				kfree_skb(skb);
 				goto error;
+			} else if (flags & MSG_SPLICE_PAGES) {
+				copy =3D 0;
 			}
 =

 			offset +=3D copy;
@@ -1791,6 +1796,10 @@ static int __ip6_append_data(struct sock *sk,
 		} else if (flags & MSG_SPLICE_PAGES) {
 			struct msghdr *msg =3D from;
 =

+			err =3D -EIO;
+			if (WARN_ON_ONCE(copy > msg->msg_iter.count))
+				goto error;
+
 			err =3D skb_splice_from_iter(skb, &msg->msg_iter, copy,
 						   sk->sk_allocation);
 			if (err < 0)

