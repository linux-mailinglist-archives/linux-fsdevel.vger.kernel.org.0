Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E1B76F848
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 05:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjHDDO3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 23:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjHDDNP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 23:13:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D611A49C1;
        Thu,  3 Aug 2023 20:12:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74F5461F20;
        Fri,  4 Aug 2023 03:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049F2C433C7;
        Fri,  4 Aug 2023 03:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691118733;
        bh=JRNDrr8Q5XicQAEnr/UMUDvJf9uks/FyRXeJTq4Lonc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R0WGwn2s0vAe/DsI3XGK11OMvfOJmtznPvIDw84m40aHVTpIpcqb2BBYLuzfuLVXk
         dZ9acA9IAQwtQzTU28t9fuHvoxracxbRDCqOkzLX1LeJe0NAsASu8TMADmINbZgGdd
         BX1P/gy9WCmjlM0BVG0hX4jELQWFjCNAAo0NB2evy4APrirEumPedKRUVDBkxVBYCa
         fUd1SRVIjlviVLoEWElgozH8jaA3DN65SmuYGQbu3LeHFnLKFAiUC4/TJ29BR+GhsW
         RhGkM/EcwsZYTxHL13maI270zR85GYjtNQTRlmot3tdxlHuqRiD6Jvh+6E17duy9Fk
         pAi6/OWVkJa3g==
Date:   Thu, 3 Aug 2023 20:12:12 -0700
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
Message-ID: <20230803201212.1d5dd0f9@kernel.org>
In-Reply-To: <852cef0c-2c1a-fdcd-4ee9-4a0bca3f54c5@gmail.com>
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
        <852cef0c-2c1a-fdcd-4ee9-4a0bca3f54c5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 3 Aug 2023 14:47:35 +0300 Tariq Toukan wrote:
> When applying this patch, repro disappears! :)
> Apparently it is related to the warning.
> Please go on and submit it.

I have no idea how. I found a different bug, staring at this code
for another hour. But I still don't get how we can avoid UaF on
a page by having the TCP take a ref on it rather than copy it.

If anything we should have 2 refs on any page in the sg, one because
it's on the sg, and another held by the re-tx handling.

So I'm afraid we're papering over something here :( We need to keep
digging.
