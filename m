Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6357401E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 19:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjF0RJR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 13:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjF0RJQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:09:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CD81726
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 10:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687885719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FwjGo3ptfmf1RlF03vGzPJR/WABEQnl9/WtrBD9kDgg=;
        b=i2pqaQjL3zSpC4OqMLTL1Oeh4Ol5QMZL15YSQHoOZiDX5QGj7gjAOBVWVjsKQUzhlI2oxB
        APSOfeqSCp7yiBk9K16ImprvsUCUUY2h9tHKdXauT5avTzznWLxQ1RLKY/RQB1Wddk9xd8
        VpeZ72N4k/C6AnOeA8QWcPsLlD9dT4E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-Aqtx5LgPOnOYWOA9Z0Mt0Q-1; Tue, 27 Jun 2023 13:08:34 -0400
X-MC-Unique: Aqtx5LgPOnOYWOA9Z0Mt0Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 436EE8C80F2;
        Tue, 27 Jun 2023 17:06:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96D1940F169;
        Tue, 27 Jun 2023 17:06:37 +0000 (UTC)
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
Content-ID: <3280456.1687885596.1@warthog.procyon.org.uk>
Date:   Tue, 27 Jun 2023 18:06:37 +0100
Message-ID: <3280457.1687885597@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Can you try net-next/main?  Parts of the branch you're trying have been
dropped.

David

