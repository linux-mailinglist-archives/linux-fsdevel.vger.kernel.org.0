Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F27B72668F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 18:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjFGQ4t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 12:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjFGQ4r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:56:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08A413D;
        Wed,  7 Jun 2023 09:56:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38712641B1;
        Wed,  7 Jun 2023 16:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9642C433EF;
        Wed,  7 Jun 2023 16:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686157005;
        bh=aPvBZetYhuElDrsk7XgaTFNO0pGltg6x0ZotRqSwJPw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Inki/nRUfVwANPsVcJ1lXwPjALjzfm1hJuhTUtyxbCdDVKiA6DT2hysaQq7YRArkY
         TmcAYk6xx2FxD6ZvT/LxBhyATpqVWXVwoXsxT4L3Fk+VS7tXb7l+Ezz8YYFYq8q3oN
         2VLd8kilvOMvEceRci0tIwOEfxF6ZWhZW6zJpebJLwpnoIu63ZhnwNcgUWuTFd3ibp
         L0MsVZNJ93F5rs2zGgKC/I5saeGGpHAMmCqleqjKHOf2+M7fX4kNpTZjTklqey4w1L
         GcKK0AbFASSEzR05VPsh1SBNgSFAMsHKsDl80TScNufOJ8BAovXa75T/RLI6PZf2dS
         ame/Hiq/DI6ow==
Date:   Wed, 7 Jun 2023 09:56:43 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
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
Subject: Re: [PATCH net-next v5 04/14] splice, net: Add a splice_eof op to
 file-ops and socket-ops
Message-ID: <20230607095643.38c18ef6@kernel.org>
In-Reply-To: <20230607140559.2263470-5-dhowells@redhat.com>
References: <20230607140559.2263470-1-dhowells@redhat.com>
        <20230607140559.2263470-5-dhowells@redhat.com>
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

On Wed,  7 Jun 2023 15:05:49 +0100 David Howells wrote:
> Add an optional method, ->splice_eof(), to allow splice to indicate the
> premature termination of a splice to struct file_operations and struct
> proto_ops.
> 
> This is called if sendfile() or splice() encounters all of the following
> conditions inside splice_direct_to_actor():
> 
>  (1) the user did not set SPLICE_F_MORE (splice only), and
> 
>  (2) an EOF condition occurred (->splice_read() returned 0), and
> 
>  (3) we haven't read enough to fulfill the request (ie. len > 0 still), and
> 
>  (4) we have already spliced at least one byte.
> 
> A further patch will modify the behaviour of SPLICE_F_MORE to always be
> passed to the actor if either the user set it or we haven't yet read
> sufficient data to fulfill the request.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
