Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525067401BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 18:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjF0Q4r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 12:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjF0Q4p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:56:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8399010D8
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 09:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687884957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zxcgu3g1LzEJDjlBVeiHHZ7/xQjIq5XoswU3EPAmCdo=;
        b=Hz08cGs3L9AzJozSuWjk21P9QWyciK3lcGq4iSN/TgeCiUCvHw9vD9YPuqQ2I23AotVlKQ
        5LoNIjQZOP1fL/tEhnzdjVSAMl9WHg4C20yUCO/JQ8hDHLwpYuogGq0yW0duC0J4mq9Lpn
        pFhGoL9P5QhLevGUeACQ5UqdLnfs5X4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-vzW8LbBLPjKGUB8TJ3-Ntg-1; Tue, 27 Jun 2023 12:55:56 -0400
X-MC-Unique: vzW8LbBLPjKGUB8TJ3-Ntg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70F083C14AA5;
        Tue, 27 Jun 2023 16:55:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD05FF5CC7;
        Tue, 27 Jun 2023 16:55:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <7337a904-231d-201d-397a-7bbe7cae929f@gmail.com>
References: <7337a904-231d-201d-397a-7bbe7cae929f@gmail.com> <ecbb5d7e-7238-28e2-1a17-686325e2bb50@gmail.com> <4c49176f-147a-4283-f1b1-32aac7b4b996@gmail.com> <20230522121125.2595254-1-dhowells@redhat.com> <20230522121125.2595254-9-dhowells@redhat.com> <2267272.1686150217@warthog.procyon.org.uk> <5a9d4ffb-a569-3f60-6ac8-070ab5e5f5ad@gmail.com> <776549.1687167344@warthog.procyon.org.uk>
To:     Tariq Toukan <ttoukan.linux@gmail.com>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
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
        linux-mm@kvack.org, Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Gal Pressman <gal@nvidia.com>, ranro@nvidia.com,
        samiram@nvidia.com, drort@nvidia.com,
        Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next v10 08/16] tls: Inline do_tcp_sendpages()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3280196.1687884949.1@warthog.procyon.org.uk>
Date:   Tue, 27 Jun 2023 17:55:49 +0100
Message-ID: <3280197.1687884949@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tariq Toukan <ttoukan.linux@gmail.com> wrote:

> WARNING: CPU: 2 PID: 93427 at net/core/skbuff.c:7013

Is that this line for you:

			} else if (WARN_ON_ONCE(!sendpage_ok(page))) {

If so, it's not slab data, but we've got a page with a 0 refcount from
somewhere.

David

