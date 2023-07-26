Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1851B764030
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 22:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjGZUIY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 16:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGZUIX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 16:08:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993652706;
        Wed, 26 Jul 2023 13:08:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FFE761C63;
        Wed, 26 Jul 2023 20:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0861C433C7;
        Wed, 26 Jul 2023 20:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690402101;
        bh=tkm5m6riRK6JiPDBJ3xtHiTEA7gBu5th4OS3XdarM5c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TSpMUIurbr1bdPa/0B6DOsiuTbVYbYdn1w3Y7xsqo/U8GbwvNsc+J4PEbd+BSWgDg
         DfIrSvjcMk6VubAyi5DhS3kIVk1nU/Re2CFRBWg4ziggvxwJAHngCA9FozCAef+xCe
         8VeOB00p7A3EdAdVg8o3k6pTY+Y6zKOkQyFMykrCcZkz4jbdWQjwa3FAlWRdpCvOzR
         vhJ4gkmZ1/ILwHRkxBH9i+ENvEDsISTlBVGM0+iSpMkRzVyYuewU+GapzRblvcE79/
         le+jGJbme2f1E5tR6UmraYRRWhqLC/ZkZi+LF0UnsNew5Ryjz9Eq3FKcLq9Jmcj0Ou
         tkfw6LwxZKPNg==
Date:   Wed, 26 Jul 2023 13:08:19 -0700
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
Message-ID: <20230726130819.6cc6aa0c@kernel.org>
In-Reply-To: <e9c41176-829a-af5a-65d2-78a2f414cd04@gmail.com>
References: <ecbb5d7e-7238-28e2-1a17-686325e2bb50@gmail.com>
        <4c49176f-147a-4283-f1b1-32aac7b4b996@gmail.com>
        <20230522121125.2595254-1-dhowells@redhat.com>
        <20230522121125.2595254-9-dhowells@redhat.com>
        <2267272.1686150217@warthog.procyon.org.uk>
        <5a9d4ffb-a569-3f60-6ac8-070ab5e5f5ad@gmail.com>
        <776549.1687167344@warthog.procyon.org.uk>
        <7337a904-231d-201d-397a-7bbe7cae929f@gmail.com>
        <20230630102143.7deffc30@kernel.org>
        <f0538006-6641-eaf6-b7b5-b3ef57afc652@gmail.com>
        <20230705091914.5bee12f8@kernel.org>
        <bbdce803-0f23-7d3f-f75a-2bc3cfb794af@gmail.com>
        <20230725173036.442ba8ba@kernel.org>
        <e9c41176-829a-af5a-65d2-78a2f414cd04@gmail.com>
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

On Wed, 26 Jul 2023 22:20:42 +0300 Tariq Toukan wrote:
> > There is a small bug in this commit, we should always set SPLICE.
> > But I don't see how that'd cause the warning you're seeing.
> > Does your build have CONFIG_DEBUG_VM enabled?  
> 
> No.
> 
> # CONFIG_DEBUG_VM is not set
> # CONFIG_DEBUG_VM_PGTABLE is not set

Try testing v6.3 with DEBUG_VM enabled or just remove the IS_ENABLED()
from: https://github.com/torvalds/linux/blob/v6.4/net/ipv4/tcp.c#L1051
