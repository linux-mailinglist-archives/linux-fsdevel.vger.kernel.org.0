Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162457028D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 11:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240460AbjEOJg1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 05:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbjEOJf2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 05:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CC310C3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 02:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684143280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Di14zlocOEDECmKOzgXOEyS4sjRLATonTy1WJdIXAUU=;
        b=CfkjLhluWJB3i3QORZCJIz6nD8QoKm7CjjlpTTu1X8VW1ikmPrcgDQaD2y1B5PSwt8eME3
        dJErOD+4He/BBSvd60ipD8uH7zmrfaNCrh5LFczdjv7s2gvM4Qn2YRHV/VIGWSCt8oD5EG
        D373Mm5WIbNVCmK10cLBYabPEeIhXdw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-DqP9KNUYOT-s0mTetspL_g-1; Mon, 15 May 2023 05:34:39 -0400
X-MC-Unique: DqP9KNUYOT-s0mTetspL_g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6ABAF891750;
        Mon, 15 May 2023 09:34:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BC60C15BA0;
        Mon, 15 May 2023 09:34:35 +0000 (UTC)
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
Subject: [PATCH net-next v7 11/16] ip, udp: Support MSG_SPLICE_PAGES
Date:   Mon, 15 May 2023 10:33:40 +0100
Message-Id: <20230515093345.396978-12-dhowells@redhat.com>
In-Reply-To: <20230515093345.396978-1-dhowells@redhat.com>
References: <20230515093345.396978-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make IP/UDP sendmsg() support MSG_SPLICE_PAGES.  This causes pages to be
spliced from the source iterator.

This allows ->sendpage() to be replaced by something that can handle
multiple multipage folios in a single transaction.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
cc: David Ahern <dsahern@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: netdev@vger.kernel.org
---

Notes:
    ver #6)
     - Use common helper.

 net/ipv4/ip_output.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 52fc840898d8..c7db973b5d29 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1048,6 +1048,14 @@ static int __ip_append_data(struct sock *sk,
 				skb_zcopy_set(skb, uarg, &extra_uref);
 			}
 		}
+	} else if ((flags & MSG_SPLICE_PAGES) && length) {
+		if (inet->hdrincl)
+			return -EPERM;
+		if (rt->dst.dev->features & NETIF_F_SG)
+			/* We need an empty buffer to attach stuff to */
+			paged = true;
+		else
+			flags &= ~MSG_SPLICE_PAGES;
 	}
 
 	cork->length += length;
@@ -1207,6 +1215,15 @@ static int __ip_append_data(struct sock *sk,
 				err = -EFAULT;
 				goto error;
 			}
+		} else if (flags & MSG_SPLICE_PAGES) {
+			struct msghdr *msg = from;
+
+			err = skb_splice_from_iter(skb, &msg->msg_iter, copy,
+						   sk->sk_allocation);
+			if (err < 0)
+				goto error;
+			copy = err;
+			wmem_alloc_delta += copy;
 		} else if (!zc) {
 			int i = skb_shinfo(skb)->nr_frags;
 

