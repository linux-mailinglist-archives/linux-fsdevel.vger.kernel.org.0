Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C156E74AC9D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 10:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjGGIOU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 04:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjGGIOT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:14:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60E41FC9
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 01:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688717611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ATdjwYLhhg3tk5Jdc0tIUEDjHNNOq472v3zhMI3Sh/s=;
        b=U3BUrOPjkD1phCHwfL34Auy3Twm5OgZi23x+9UwMqiTAKFmg4H2NIHfTxTNqHcTSGDtIi5
        ZlOU8ezXlMdxph6aII6dPi6hEJi702B7Xg/AvhmklFrj5UIF8apGnADsKGh3OY7Itl1iX/
        j18Ymvwtwe8GX4wCxD8efqQXoQpWPPA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-5OhAl37CMDOgCHH0KncknA-1; Fri, 07 Jul 2023 04:13:28 -0400
X-MC-Unique: 5OhAl37CMDOgCHH0KncknA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2ACAA802666;
        Fri,  7 Jul 2023 08:13:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 754FCF6401;
        Fri,  7 Jul 2023 08:13:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <000000000000554b8205ffdea64e@google.com>
References: <000000000000554b8205ffdea64e@google.com>
To:     syzbot <syzbot+689ec3afb1ef07b766b2@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, adilger.kernel@dilger.ca,
        boqun.feng@gmail.com, herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com, mingo@redhat.com,
        netdev@vger.kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu, will@kernel.org
Subject: Re: [syzbot] [ext4?] general protection fault in ext4_finish_bio
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2225032.1688717605.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 07 Jul 2023 09:13:25 +0100
Message-ID: <2225033.1688717605@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master

    crypto: algif/hash: Fix race between MORE and non-MORE sends
    =

    The 'MSG_MORE' state of the previous sendmsg() is fetched without the
    socket lock held, so two sendmsg calls can race.  This can be seen wit=
h a
    large sendfile() as that now does a series of sendmsg() calls, and if =
a
    write() comes in on the same socket at an inopportune time, it can fli=
p the
    state.
    =

    Fix this by moving the fetch of ctx->more inside the socket lock.
    =

    Fixes: c662b043cdca ("crypto: af_alg/hash: Support MSG_SPLICE_PAGES")
    Reported-by: syzbot+689ec3afb1ef07b766b2@syzkaller.appspotmail.com
    Link: https://lore.kernel.org/r/000000000000554b8205ffdea64e@google.co=
m/
    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: Herbert Xu <herbert@gondor.apana.org.au>
    cc: Paolo Abeni <pabeni@redhat.com>
    cc: "David S. Miller" <davem@davemloft.net>
    cc: Eric Dumazet <edumazet@google.com>
    cc: Jakub Kicinski <kuba@kernel.org>
    cc: linux-crypto@vger.kernel.org
    cc: netdev@vger.kernel.org

diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
index 0ab43e149f0e..82c44d4899b9 100644
--- a/crypto/algif_hash.c
+++ b/crypto/algif_hash.c
@@ -68,13 +68,15 @@ static int hash_sendmsg(struct socket *sock, struct ms=
ghdr *msg,
 	struct hash_ctx *ctx =3D ask->private;
 	ssize_t copied =3D 0;
 	size_t len, max_pages, npages;
-	bool continuing =3D ctx->more, need_init =3D false;
+	bool continuing, need_init =3D false;
 	int err;
 =

 	max_pages =3D min_t(size_t, ALG_MAX_PAGES,
 			  DIV_ROUND_UP(sk->sk_sndbuf, PAGE_SIZE));
 =

 	lock_sock(sk);
+	continuing =3D ctx->more;
+
 	if (!continuing) {
 		/* Discard a previous request that wasn't marked MSG_MORE. */
 		hash_free_result(sk, ctx);

