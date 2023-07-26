Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710D376344B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 12:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjGZKw3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 06:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjGZKw1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:52:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3A411B
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 03:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690368709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nH9TTmDL5tYRZHJPn+1E0xNR2d1YNoR5WLvvRYGU6fk=;
        b=Z0P/9RUSJLXe9r6LwfFkH9GpWQMvgnR5ZAx3sAjtEvru294VZcZVt1nV2bxSxV4uhPnt1A
        yuDO7jAoa+228ZTTEFS22uQgk6+pRDuVg79ZUgkjwSAZxRTiuLYsjIsYo8ASKBUSTi7+yM
        muYYXII5E8jB57OZZTVQS9FebCRAtN0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-N8PyqojCM_GwkMTgskdm9w-1; Wed, 26 Jul 2023 06:51:45 -0400
X-MC-Unique: N8PyqojCM_GwkMTgskdm9w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0451101A54E;
        Wed, 26 Jul 2023 10:51:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C336B1401C2E;
        Wed, 26 Jul 2023 10:51:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <bbdce803-0f23-7d3f-f75a-2bc3cfb794af@gmail.com>
References: <bbdce803-0f23-7d3f-f75a-2bc3cfb794af@gmail.com> <ecbb5d7e-7238-28e2-1a17-686325e2bb50@gmail.com> <4c49176f-147a-4283-f1b1-32aac7b4b996@gmail.com> <20230522121125.2595254-1-dhowells@redhat.com> <20230522121125.2595254-9-dhowells@redhat.com> <2267272.1686150217@warthog.procyon.org.uk> <5a9d4ffb-a569-3f60-6ac8-070ab5e5f5ad@gmail.com> <776549.1687167344@warthog.procyon.org.uk> <7337a904-231d-201d-397a-7bbe7cae929f@gmail.com> <20230630102143.7deffc30@kernel.org> <f0538006-6641-eaf6-b7b5-b3ef57afc652@gmail.com> <20230705091914.5bee12f8@kernel.org>
To:     Tariq Toukan <ttoukan.linux@gmail.com>
Cc:     dhowells@redhat.com, Jakub Kicinski <kuba@kernel.org>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
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
        linux-mm@kvack.org, Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Gal Pressman <gal@nvidia.com>, ranro@nvidia.com,
        samiram@nvidia.com, drort@nvidia.com,
        Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next v10 08/16] tls: Inline do_tcp_sendpages()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20417.1690368701.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 26 Jul 2023 11:51:41 +0100
Message-ID: <20418.1690368701@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NORMAL_HTTP_TO_IP,
        NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tariq Toukan <ttoukan.linux@gmail.com> wrote:

> We repro the issue on the server side using this client command:
> $ wrk -b2.2.2.2 -t4 -c1000 -d5 --timeout 5s https://2.2.2.3:20443/256000=
b.img

What's wrk?

David

