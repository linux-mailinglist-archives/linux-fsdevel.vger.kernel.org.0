Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC27976C71F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 09:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjHBHi7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 03:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjHBHiB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:38:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D567535A6
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 00:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690961821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Af46NJKmEBmqy5H958slGnADxdkvZPSFCpD9BIDom1E=;
        b=K8ktEoXkDC0VHvlC8J18KFcIsNz1PRz4+xyG88/SDhQAvtCIr8ZI88Nkg4zOhuBtxMktyn
        Ai0c9JBXyUJgMY6NjeY3BAw6aFH2VCoHZeyixIB/X6Y8E4Ox/6w2tRs+i3wBlhw6kgk1oQ
        /tMf54ghoZvM1aqYEMYIcWwJIyjdT9A=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-pNGBElBeMeG9lip0cBHItQ-1; Wed, 02 Aug 2023 03:36:55 -0400
X-MC-Unique: pNGBElBeMeG9lip0cBHItQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C335E3828887;
        Wed,  2 Aug 2023 07:36:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C433F7820;
        Wed,  2 Aug 2023 07:36:51 +0000 (UTC)
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
Subject: [PATCH net-next] udp6: Fix __ip6_append_data()'s handling of MSG_SPLICE_PAGES
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1580951.1690961810.1@warthog.procyon.org.uk>
Date:   Wed, 02 Aug 2023 08:36:50 +0100
Message-ID: <1580952.1690961810@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__ip6_append_data() can has a similar problem to __ip_append_data()[1] when
asked to splice into a partially-built UDP message that has more than the
frag-limit data and up to the MTU limit, but in the ipv6 case, it errors
out with EINVAL.  This can be triggered with something like:

        pipe(pfd);
        sfd = socket(AF_INET6, SOCK_DGRAM, 0);
        connect(sfd, ...);
        send(sfd, buffer, 8137, MSG_CONFIRM|MSG_MORE);
        write(pfd[1], buffer, 8);
        splice(pfd[0], 0, sfd, 0, 0x4ffe0ul, 0);

where the amount of data given to send() is dependent on the MTU size (in
this instance an interface with an MTU of 8192).

The problem is that the calculation of the amount to copy in
__ip6_append_data() goes negative in two places, but a check has been put
in to give an error in this case.

This happens because when pagedlen > 0 (which happens for MSG_ZEROCOPY and
MSG_SPLICE_PAGES), the terms in:

        copy = datalen - transhdrlen - fraggap - pagedlen;

then mostly cancel when pagedlen is substituted for, leaving just -fraggap.

Fix this by:

 (1) Insert a note about the dodgy calculation of 'copy'.

 (2) If MSG_SPLICE_PAGES, clear copy if it is negative from the above
     equation, so that 'offset' isn't regressed and 'length' isn't
     increased, which will mean that length and thus copy should match the
     amount left in the iterator.

 (3) When handling MSG_SPLICE_PAGES, give a warning and return -EIO if
     we're asked to splice more than is in the iterator.  It might be
     better to not give the warning or even just give a 'short' write.

 (4) If MSG_SPLICE_PAGES, override the copy<0 check.

[!] Note that this should also affect MSG_ZEROCOPY, but that will return
-EINVAL for the range of send sizes that requires the skbuff to be split.

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
Link: https://lore.kernel.org/r/000000000000881d0606004541d1@google.com/ [1]
---
 net/ipv6/ip6_output.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 1e8c90e97608..bc96559bbf0f 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1693,7 +1693,10 @@ static int __ip6_append_data(struct sock *sk,
 			fraglen = datalen + fragheaderlen;
 
 			copy = datalen - transhdrlen - fraggap - pagedlen;
-			if (copy < 0) {
+			/* [!] NOTE: copy may be negative if pagedlen>0
+			 * because then the equation may reduces to -fraggap.
+			 */
+			if (copy < 0 && !(flags & MSG_SPLICE_PAGES)) {
 				err = -EINVAL;
 				goto error;
 			}
@@ -1744,6 +1747,8 @@ static int __ip6_append_data(struct sock *sk,
 				err = -EFAULT;
 				kfree_skb(skb);
 				goto error;
+			} else if (flags & MSG_SPLICE_PAGES) {
+				copy = 0;
 			}
 
 			offset += copy;
@@ -1791,6 +1796,10 @@ static int __ip6_append_data(struct sock *sk,
 		} else if (flags & MSG_SPLICE_PAGES) {
 			struct msghdr *msg = from;
 
+			err = -EIO;
+			if (WARN_ON_ONCE(copy > msg->msg_iter.count))
+				goto error;
+
 			err = skb_splice_from_iter(skb, &msg->msg_iter, copy,
 						   sk->sk_allocation);
 			if (err < 0)

