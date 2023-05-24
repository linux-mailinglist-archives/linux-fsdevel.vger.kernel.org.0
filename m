Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853E270EC78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 06:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbjEXEUc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 00:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjEXEU2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 00:20:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24768FC;
        Tue, 23 May 2023 21:20:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6273638A9;
        Wed, 24 May 2023 04:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F6A1C433EF;
        Wed, 24 May 2023 04:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684902026;
        bh=GNZhXKomMT54g+LtxRjYbIBwQk2dt/X5HlQu3jjOZZI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gM2mno2MgOChhOSkSovPlMxLYxjoipeN7KkmD4t7OmgDq07CzCzYvbwfVkq0CF1XE
         OKoJULyvIioS1mde9iSOK4qXTB3XWrM7F61AzejUoiX7rsdjKSawUWd4Iy42ZqiIU4
         8C5+2JbcvgTBU9PjkRKn/aJF9wdUcTevPuepr4o+6K7wbxgmaAj0H4PrUcoe7ECbey
         RrijNJVfKTqMHUjjzD69kYlZ341wTdtNpGq0+2k0Inj4kPIETtAUp+Q2eeFWdsuesZ
         s/NsNJ8n26DjwStiP9UxaNIAiQaTZTH3+CLcN6BksluYexGIwQueLU9ZVzSNMIJXrH
         QnCQr9zSFE4hA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF55CC395F8;
        Wed, 24 May 2023 04:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v10 00/16] splice,
 net: Replace sendpage with sendmsg(MSG_SPLICE_PAGES), part 1
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168490202597.21222.4656712429626955049.git-patchwork-notify@kernel.org>
Date:   Wed, 24 May 2023 04:20:25 +0000
References: <20230522121125.2595254-1-dhowells@redhat.com>
In-Reply-To: <20230522121125.2595254-1-dhowells@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        willemdebruijn.kernel@gmail.com, dsahern@kernel.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, hch@infradead.org,
        axboe@kernel.dk, jlayton@kernel.org, brauner@kernel.org,
        chuck.lever@oracle.com, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
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

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 May 2023 13:11:09 +0100 you wrote:
> Here's the first tranche of patches towards providing a MSG_SPLICE_PAGES
> internal sendmsg flag that is intended to replace the ->sendpage() op with
> calls to sendmsg().  MSG_SPLICE_PAGES is a hint that tells the protocol
> that it should splice the pages supplied if it can and copy them if not.
> 
> This will allow splice to pass multiple pages in a single call and allow
> certain parts of higher protocols (e.g. sunrpc, iwarp) to pass an entire
> message in one go rather than having to send them piecemeal.  This should
> also make it easier to handle the splicing of multipage folios.
> 
> [...]

Here is the summary with links:
  - [net-next,v10,01/16] net: Declare MSG_SPLICE_PAGES internal sendmsg() flag
    https://git.kernel.org/netdev/net-next/c/b841b901c452
  - [net-next,v10,02/16] net: Pass max frags into skb_append_pagefrags()
    https://git.kernel.org/netdev/net-next/c/96449f902407
  - [net-next,v10,03/16] net: Add a function to splice pages into an skbuff for MSG_SPLICE_PAGES
    https://git.kernel.org/netdev/net-next/c/2e910b95329c
  - [net-next,v10,04/16] tcp: Support MSG_SPLICE_PAGES
    https://git.kernel.org/netdev/net-next/c/270a1c3de47e
  - [net-next,v10,05/16] tcp: Convert do_tcp_sendpages() to use MSG_SPLICE_PAGES
    https://git.kernel.org/netdev/net-next/c/c5c37af6ecad
  - [net-next,v10,06/16] tcp_bpf: Inline do_tcp_sendpages as it's now a wrapper around tcp_sendmsg
    https://git.kernel.org/netdev/net-next/c/ebf2e8860eea
  - [net-next,v10,07/16] espintcp: Inline do_tcp_sendpages()
    https://git.kernel.org/netdev/net-next/c/7f8816ab4bae
  - [net-next,v10,08/16] tls: Inline do_tcp_sendpages()
    https://git.kernel.org/netdev/net-next/c/e117dcfd646e
  - [net-next,v10,09/16] siw: Inline do_tcp_sendpages()
    https://git.kernel.org/netdev/net-next/c/c2ff29e99a76
  - [net-next,v10,10/16] tcp: Fold do_tcp_sendpages() into tcp_sendpage_locked()
    https://git.kernel.org/netdev/net-next/c/5367f9bbb86a
  - [net-next,v10,11/16] ip, udp: Support MSG_SPLICE_PAGES
    https://git.kernel.org/netdev/net-next/c/7da0dde68486
  - [net-next,v10,12/16] ip6, udp6: Support MSG_SPLICE_PAGES
    https://git.kernel.org/netdev/net-next/c/6d8192bd69bb
  - [net-next,v10,13/16] udp: Convert udp_sendpage() to use MSG_SPLICE_PAGES
    https://git.kernel.org/netdev/net-next/c/7ac7c987850c
  - [net-next,v10,14/16] ip: Remove ip_append_page()
    https://git.kernel.org/netdev/net-next/c/c49cf2663291
  - [net-next,v10,15/16] af_unix: Support MSG_SPLICE_PAGES
    https://git.kernel.org/netdev/net-next/c/a0dbf5f818f9
  - [net-next,v10,16/16] unix: Convert unix_stream_sendpage() to use MSG_SPLICE_PAGES
    https://git.kernel.org/netdev/net-next/c/57d44a354a43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


