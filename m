Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875CA72FA27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 12:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbjFNKKp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 06:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbjFNKKm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:10:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D21DE52
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 03:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686737396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MBrjoJbmEWc/Tn6Mkt7SpycUJkuHckypR5ks5lDPTJ8=;
        b=UGMzHWjCIhqCOtVdgMf3rmjA38B/SrKYCTshUIO1Qw2yx2afgc5w9AKteH4SMXjy9NcF+F
        5Zo1yCFYxua6u6GKRfchl8VcDDMaQ5a4/DYgLEEhmHlGuneoDGkLwfUmx95FypCOSn69c1
        BMQtmu44fsmc3R+FW7IcIX2N5ah4kEE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-DPX2FsP-PxqlW4E_Wy1R1w-1; Wed, 14 Jun 2023 06:09:53 -0400
X-MC-Unique: DPX2FsP-PxqlW4E_Wy1R1w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55518830EFD;
        Wed, 14 Jun 2023 10:09:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AEA7740C6F5D;
        Wed, 14 Jun 2023 10:09:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
cc:     dhowells@redhat.com,
        syzbot+f9e28a23426ac3b24f20@syzkaller.appspotmail.com,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] splice, net: Fix splice_to_socket() to handle pipe bufs larger than a page
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1428984.1686737388.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 14 Jun 2023 11:09:48 +0100
Message-ID: <1428985.1686737388@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

    =

splice_to_socket() assumes that a pipe_buffer won't hold more than a singl=
e
page of data - but this assumption can be violated by skb_splice_bits()
when it splices from a socket into a pipe.

The problem is that splice_to_socket() doesn't advance the pipe_buffer
length and offset when transcribing from the pipe buf into a bio_vec, so i=
f
the buf is >PAGE_SIZE, it keeps repeating the same initial chunk and
doesn't advance the tail index.  It then subtracts this from "remain" and
overcounts the amount of data to be sent.

The cleanup phase then tries to overclean the pipe, hits an unused pipe bu=
f
and a NULL-pointer dereference occurs.

Fix this by not restricting the bio_vec size to PAGE_SIZE and instead
transcribing the entirety of each pipe_buffer into a single bio_vec and
advancing the tail index if remain hasn't hit zero yet.

Large bio_vecs will then be split up by iterator functions such as
iov_iter_extract_pages().

This resulted in a KASAN report looking like:

general protection fault, probably for non-canonical address 0xdffffc00000=
00001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
...
RIP: 0010:pipe_buf_release include/linux/pipe_fs_i.h:203 [inline]
RIP: 0010:splice_to_socket+0xa91/0xe30 fs/splice.c:933

Fixes: 2dc334f1a63a ("splice, net: Use sendmsg(MSG_SPLICE_PAGES) rather th=
an ->sendpage()")
Reported-by: syzbot+f9e28a23426ac3b24f20@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/0000000000000900e905fdeb8e39@google.com/
Tested-by: syzbot+f9e28a23426ac3b24f20@syzkaller.appspotmail.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
cc: David Ahern <dsahern@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christian Brauner <brauner@kernel.org>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: netdev@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/splice.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index e337630aed64..567a1f03ea1e 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -886,7 +886,6 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe,=
 struct file *out,
 			}
 =

 			seg =3D min_t(size_t, remain, buf->len);
-			seg =3D min_t(size_t, seg, PAGE_SIZE);
 =

 			ret =3D pipe_buf_confirm(pipe, buf);
 			if (unlikely(ret)) {
@@ -897,10 +896,9 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe=
, struct file *out,
 =

 			bvec_set_page(&bvec[bc++], buf->page, seg, buf->offset);
 			remain -=3D seg;
-			if (seg >=3D buf->len)
-				tail++;
-			if (bc >=3D ARRAY_SIZE(bvec))
+			if (remain =3D=3D 0 || bc >=3D ARRAY_SIZE(bvec))
 				break;
+			tail++;
 		}
 =

 		if (!bc)

