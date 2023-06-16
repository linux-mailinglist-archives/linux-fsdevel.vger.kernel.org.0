Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C424F7326F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 08:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241799AbjFPGA1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 02:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241335AbjFPGAZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959E12D50;
        Thu, 15 Jun 2023 23:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 252F161324;
        Fri, 16 Jun 2023 06:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46FE6C433C9;
        Fri, 16 Jun 2023 06:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686895223;
        bh=nqLqzNx7gUZu0xo6s7uaBOSAsUVCyWFz/UHAUJVeRV4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Pqh6JaPKYMdxV8IfBYl7MWnpUd5cbXHUu55G3vSNWFwKzECHhhcIrAcrRdGwF1aIK
         NBjTx4NN3ONoaCq85T17XCLRoZuY76G/0yoTyqFlYluZ2LRuzEej8q2fjLNOwgDA9m
         leHQF7cuRf8WSTB8wKP+v1hK5jeXMNUf1abiXY33F1o1BAGkjtYKlMKUY24aSPQc0O
         GtGrKdCW8kb86gfhoDSVFYdeyjhk6XAiv7N2su+1IF9cayd7k7MuB5tcfg5qJcFg5f
         fH9GbLJ3/bvZcrKvki3w0fUDq+uMiC4PXhgEH7myyXb7xFJfx+SUhiob2sUPxuyLKv
         f1wp7/7UN9vfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FF97E49BBF;
        Fri, 16 Jun 2023 06:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] splice,
 net: Fix splice_to_socket() to handle pipe bufs larger than a page
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168689522312.30897.4975538278032137122.git-patchwork-notify@kernel.org>
Date:   Fri, 16 Jun 2023 06:00:23 +0000
References: <1428985.1686737388@warthog.procyon.org.uk>
In-Reply-To: <1428985.1686737388@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org,
        syzbot+f9e28a23426ac3b24f20@syzkaller.appspotmail.com,
        willemdebruijn.kernel@gmail.com, dsahern@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, axboe@kernel.dk, willy@infradead.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Jun 2023 11:09:48 +0100 you wrote:
> splice_to_socket() assumes that a pipe_buffer won't hold more than a single
> page of data - but this assumption can be violated by skb_splice_bits()
> when it splices from a socket into a pipe.
> 
> The problem is that splice_to_socket() doesn't advance the pipe_buffer
> length and offset when transcribing from the pipe buf into a bio_vec, so if
> the buf is >PAGE_SIZE, it keeps repeating the same initial chunk and
> doesn't advance the tail index.  It then subtracts this from "remain" and
> overcounts the amount of data to be sent.
> 
> [...]

Here is the summary with links:
  - [net-next] splice, net: Fix splice_to_socket() to handle pipe bufs larger than a page
    https://git.kernel.org/netdev/net-next/c/ca2d49f77ce4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


