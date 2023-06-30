Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1810A744115
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 19:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjF3RVt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 13:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjF3RVr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:21:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56035107;
        Fri, 30 Jun 2023 10:21:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8EBA617C4;
        Fri, 30 Jun 2023 17:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FF9C433C0;
        Fri, 30 Jun 2023 17:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688145705;
        bh=nP0fbFeP3uVZ92LQd04sMVwYYQdCsLeYKAqxBMnc/KM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VMz2YVafjxOjYkzjJgtlZ0ImcoEGfC2h8Y1pp2Ut7Yo4A8zniR7S0jieSSjXskEN6
         aO3xj0+b4me3m52CNWE+I9kWusLZDPyoP96YpJK7fafm5DzEV7/f7zOtBDXqWgLm/F
         8MBZSuHNDkGDohZUe7A2j5cKHQaaE6QZpCbQdD7scg+dHmIyIoaAFVB1bD5sCSodV1
         iyl/wFGBKCymdAVaQJ/dAgvSxld6gIwUZtHFmfvc9GQg+USupBIDUuquYOp7XIpus4
         Xpbn3wGOd/UBqCM8q+oRmexH+TdBQnKLbl8nrNLwviMIBeXoc7lb717DCnDdZr1GM3
         dILnlyFIaYJvQ==
Date:   Fri, 30 Jun 2023 10:21:43 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Tariq Toukan <ttoukan.linux@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
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
Message-ID: <20230630102143.7deffc30@kernel.org>
In-Reply-To: <7337a904-231d-201d-397a-7bbe7cae929f@gmail.com>
References: <ecbb5d7e-7238-28e2-1a17-686325e2bb50@gmail.com>
        <4c49176f-147a-4283-f1b1-32aac7b4b996@gmail.com>
        <20230522121125.2595254-1-dhowells@redhat.com>
        <20230522121125.2595254-9-dhowells@redhat.com>
        <2267272.1686150217@warthog.procyon.org.uk>
        <5a9d4ffb-a569-3f60-6ac8-070ab5e5f5ad@gmail.com>
        <776549.1687167344@warthog.procyon.org.uk>
        <7337a904-231d-201d-397a-7bbe7cae929f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 27 Jun 2023 19:49:22 +0300 Tariq Toukan wrote:
> Unfortunately, it still happens:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 93427 at net/core/skbuff.c:7013 

I can't repro it on net-next with basic TLS 1.2 sendmsg/stream
test + device offload, let us know if you still see it.
