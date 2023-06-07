Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0ED272686A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 20:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjFGSVc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 14:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjFGSVG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:21:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC52173B
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 11:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686162020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VfP0KSvbwDpdDK3r99Lo/bGf0PzU9/ETfdNk/1wpqNM=;
        b=XmzZmhrHBvC7TbWUbxI4pImqdBI0VWl8HktIUzdmKIgK9wjD1g5Odb0J1CdK3PY+K7PgJT
        pUkzaD9EsaLUYjq/5nyejZ8Yie5Dy+TslI2sH6qX9JypI50JQJcBT8PXHU3wzEOL//0KSG
        jVAQnIiZwIkcpauj6y2G+FY0raBk3ys=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-JvJ2kpHPNDC1LBuwFYWsFg-1; Wed, 07 Jun 2023 14:20:17 -0400
X-MC-Unique: JvJ2kpHPNDC1LBuwFYWsFg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 665F285A5BA;
        Wed,  7 Jun 2023 18:20:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90EEE2026D49;
        Wed,  7 Jun 2023 18:20:13 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH net-next v6 10/14] splice, net: Fix SPLICE_F_MORE signalling in splice_direct_to_actor()
Date:   Wed,  7 Jun 2023 19:19:16 +0100
Message-ID: <20230607181920.2294972-11-dhowells@redhat.com>
In-Reply-To: <20230607181920.2294972-1-dhowells@redhat.com>
References: <20230607181920.2294972-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

splice_direct_to_actor() doesn't manage SPLICE_F_MORE correctly[1] - and,
as a result, it incorrectly signals/fails to signal MSG_MORE when splicing
to a socket.  The problem I'm seeing happens when a short splice occurs
because we got a short read due to hitting the EOF on a file: as the length
read (read_len) is less than the remaining size to be spliced (len),
SPLICE_F_MORE (and thus MSG_MORE) is set.

The issue is that, for the moment, we have no way to know *why* the short
read occurred and so can't make a good decision on whether we *should* keep
MSG_MORE set.

MSG_SENDPAGE_NOTLAST was added to work around this, but that is also set
incorrectly under some circumstances - for example if a short read fills a
single pipe_buffer, but the next read would return more (seqfile can do
this).

This was observed with the multi_chunk_sendfile tests in the tls kselftest
program.  Some of those tests would hang and time out when the last chunk
of file was less than the sendfile request size:

	build/kselftest/net/tls -r tls.12_aes_gcm.multi_chunk_sendfile

This has been observed before[2] and worked around in AF_TLS[3].

Fix this by making splice_direct_to_actor() always signal SPLICE_F_MORE if
we haven't yet hit the requested operation size.  SPLICE_F_MORE remains
signalled if the user passed it in to splice() but otherwise gets cleared
when we've read sufficient data to fulfill the request.

If, however, we get a premature EOF from ->splice_read(), have sent at
least one byte and SPLICE_F_MORE was not set by the caller, ->splice_eof()
will be invoked.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Matthew Wilcox <willy@infradead.org>
cc: Jan Kara <jack@suse.cz>
cc: Jeff Layton <jlayton@kernel.org>
cc: David Hildenbrand <david@redhat.com>
cc: Christian Brauner <brauner@kernel.org>
cc: Chuck Lever <chuck.lever@oracle.com>
cc: Boris Pismenny <borisp@nvidia.com>
cc: John Fastabend <john.fastabend@gmail.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-mm@kvack.org
cc: netdev@vger.kernel.org

Link: https://lore.kernel.org/r/499791.1685485603@warthog.procyon.org.uk/ [1]
Link: https://lore.kernel.org/r/1591392508-14592-1-git-send-email-pooja.trivedi@stackpath.com/ [2]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=d452d48b9f8b1a7f8152d33ef52cfd7fe1735b0a [3]
---

Notes:
    ver #4)
     - Use ->splice_eof() to signal a premature EOF to the splice output.

 fs/splice.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 67dbd85db207..67ddaac1f5c5 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1063,13 +1063,17 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
 	 */
 	bytes = 0;
 	len = sd->total_len;
+
+	/* Don't block on output, we have to drain the direct pipe. */
 	flags = sd->flags;
+	sd->flags &= ~SPLICE_F_NONBLOCK;
 
 	/*
-	 * Don't block on output, we have to drain the direct pipe.
+	 * We signal MORE until we've read sufficient data to fulfill the
+	 * request and we keep signalling it if the caller set it.
 	 */
-	sd->flags &= ~SPLICE_F_NONBLOCK;
 	more = sd->flags & SPLICE_F_MORE;
+	sd->flags |= SPLICE_F_MORE;
 
 	WARN_ON_ONCE(!pipe_empty(pipe->head, pipe->tail));
 
@@ -1085,14 +1089,12 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
 		sd->total_len = read_len;
 
 		/*
-		 * If more data is pending, set SPLICE_F_MORE
-		 * If this is the last data and SPLICE_F_MORE was not set
-		 * initially, clears it.
+		 * If we now have sufficient data to fulfill the request then
+		 * we clear SPLICE_F_MORE if it was not set initially.
 		 */
-		if (read_len < len)
-			sd->flags |= SPLICE_F_MORE;
-		else if (!more)
+		if (read_len >= len && !more)
 			sd->flags &= ~SPLICE_F_MORE;
+
 		/*
 		 * NOTE: nonblocking mode only applies to the input. We
 		 * must not do the output in nonblocking mode as then we

