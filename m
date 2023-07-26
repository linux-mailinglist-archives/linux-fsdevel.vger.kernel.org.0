Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6521F763464
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 12:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbjGZK6v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 06:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjGZK6u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:58:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3A09B
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 03:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690369084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jGubfG0J6/LbJU8ZklZwV88L9biaQyHs5qooncbU0FI=;
        b=E6xkEtAimg/2Eu7hWj8ssUd5LebA3rC/z/sm6zcjIwoQknuydLBXxhUyTqXqffTMeHgcfb
        VcWpj72sFpGK2P3ldLL56T6tYiVovtRnJgU20jQR8oQ1pWcLMLQyc1DXDGNKsVfEHAgCRu
        TK1wpi3j6OgJ2xitoX1C33k7jd48uRg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-dqoDG2KSNXWgfEIc4HVvzQ-1; Wed, 26 Jul 2023 06:58:00 -0400
X-MC-Unique: dqoDG2KSNXWgfEIc4HVvzQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7327F801CF3;
        Wed, 26 Jul 2023 10:57:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA5BE2166B25;
        Wed, 26 Jul 2023 10:57:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Steve French <sfrench@samba.org>
cc:     dhowells@redhat.com, akpm@linux-foundation.org,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Layton <jlayton@kernel.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, linux-cachefs@redhat.com,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto, cifs: Fix error handling in extract_iter_to_sg()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20570.1690369076.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 26 Jul 2023 11:57:56 +0100
Message-ID: <20571.1690369076@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

    =

Fix error handling in extract_iter_to_sg().  Pages need to be unpinned, no=
t
put in extract_user_to_sg() when handling IOVEC/UBUF sources.

The bug may result in a warning like the following:

  WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 __lse_atomic_add arch/arm64/i=
nclude/asm/atomic_lse.h:27 [inline]
  WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 arch_atomic_add arch/arm64/in=
clude/asm/atomic.h:28 [inline]
  WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 raw_atomic_add include/linux/=
atomic/atomic-arch-fallback.h:537 [inline]
  WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 atomic_add include/linux/atom=
ic/atomic-instrumented.h:105 [inline]
  WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 try_grab_page+0x108/0x160 mm/=
gup.c:252
  ...
  pc : try_grab_page+0x108/0x160 mm/gup.c:229
  lr : follow_page_pte+0x174/0x3e4 mm/gup.c:651
  ...
  Call trace:
   __lse_atomic_add arch/arm64/include/asm/atomic_lse.h:27 [inline]
   arch_atomic_add arch/arm64/include/asm/atomic.h:28 [inline]
   raw_atomic_add include/linux/atomic/atomic-arch-fallback.h:537 [inline]
   atomic_add include/linux/atomic/atomic-instrumented.h:105 [inline]
   try_grab_page+0x108/0x160 mm/gup.c:252
   follow_pmd_mask mm/gup.c:734 [inline]
   follow_pud_mask mm/gup.c:765 [inline]
   follow_p4d_mask mm/gup.c:782 [inline]
   follow_page_mask+0x12c/0x2e4 mm/gup.c:839
   __get_user_pages+0x174/0x30c mm/gup.c:1217
   __get_user_pages_locked mm/gup.c:1448 [inline]
   __gup_longterm_locked+0x94/0x8f4 mm/gup.c:2142
   internal_get_user_pages_fast+0x970/0xb60 mm/gup.c:3140
   pin_user_pages_fast+0x4c/0x60 mm/gup.c:3246
   iov_iter_extract_user_pages lib/iov_iter.c:1768 [inline]
   iov_iter_extract_pages+0xc8/0x54c lib/iov_iter.c:1831
   extract_user_to_sg lib/scatterlist.c:1123 [inline]
   extract_iter_to_sg lib/scatterlist.c:1349 [inline]
   extract_iter_to_sg+0x26c/0x6fc lib/scatterlist.c:1339
   hash_sendmsg+0xc0/0x43c crypto/algif_hash.c:117
   sock_sendmsg_nosec net/socket.c:725 [inline]
   sock_sendmsg+0x54/0x60 net/socket.c:748
   ____sys_sendmsg+0x270/0x2ac net/socket.c:2494
   ___sys_sendmsg+0x80/0xdc net/socket.c:2548
   __sys_sendmsg+0x68/0xc4 net/socket.c:2577
   __do_sys_sendmsg net/socket.c:2586 [inline]
   __se_sys_sendmsg net/socket.c:2584 [inline]
   __arm64_sys_sendmsg+0x24/0x30 net/socket.c:2584
   __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
   invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
   el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
   do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
   el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
   el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
   el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591

Fixes: 018584697533 ("netfs: Add a function to extract an iterator into a =
scatterlist")
Reported-by: syzbot+9b82859567f2e50c123e@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-mm/000000000000273d0105ff97bf56@google=
.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Sven Schnelle <svens@linux.ibm.com>
cc: akpm@linux-foundation.org
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jeff Layton <jlayton@kernel.org>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-mm@kvack.org
cc: linux-crypto@vger.kernel.org
cc: linux-cachefs@redhat.com
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: netdev@vger.kernel.org
---
 lib/scatterlist.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index e86231a44c3d..c65566b4dc66 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -1148,7 +1148,7 @@ static ssize_t extract_user_to_sg(struct iov_iter *i=
ter,
 =

 failed:
 	while (sgtable->nents > sgtable->orig_nents)
-		put_page(sg_page(&sgtable->sgl[--sgtable->nents]));
+		unpin_user_page(sg_page(&sgtable->sgl[--sgtable->nents]));
 	return res;
 }
 =

