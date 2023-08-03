Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F63C76DE46
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 04:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjHCCeX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 22:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbjHCCdX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 22:33:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DF46180;
        Wed,  2 Aug 2023 19:30:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7492261BB6;
        Thu,  3 Aug 2023 02:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0AEFC433C7;
        Thu,  3 Aug 2023 02:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691029821;
        bh=aOYpkIHh/DPbsxHUKna75zI7rjpRLM5Mkvu+b1TwdCc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cf3SYePTjJjzCoHKr6jzywybKWLiWijzqWO7GEKNzaQbRKy3Citemkb0V/D3DEUzc
         JIWxXQxMaVLkAdJcmiIQgIp7lZX3X6gC+LPG1ZPumf62DB4l0yO1LkDbSSFZgUxamV
         qerPnacB/KZwef5wuFQr/Plij9BUyydZquQTmaDhoQUuQUUzpF9TEc1AL0Yjx2uSeN
         HPwf8cCtMmCFKIzdYWhAgznNN7vbskpk+5tB4Z9vCl/F4LmuLrAr60E8R+UHYfxc/N
         oVFnTQRYdNMKBJpb8Cw8HYqNBJIDm5EVhFMdZwxAZl8idm1n7NEGTaUOOZZUkj6saZ
         M6NpmDs7zWDtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E318E270D1;
        Thu,  3 Aug 2023 02:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] udp: Fix __ip_append_data()'s handling of
 MSG_SPLICE_PAGES
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169102982164.22584.2159457611636116632.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Aug 2023 02:30:21 +0000
References: <1420063.1690904933@warthog.procyon.org.uk>
In-Reply-To: <1420063.1690904933@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
        syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com,
        bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org
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

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 01 Aug 2023 16:48:53 +0100 you wrote:
> __ip_append_data() can get into an infinite loop when asked to splice into
> a partially-built UDP message that has more than the frag-limit data and up
> to the MTU limit.  Something like:
> 
>         pipe(pfd);
>         sfd = socket(AF_INET, SOCK_DGRAM, 0);
>         connect(sfd, ...);
>         send(sfd, buffer, 8161, MSG_CONFIRM|MSG_MORE);
>         write(pfd[1], buffer, 8);
>         splice(pfd[0], 0, sfd, 0, 0x4ffe0ul, 0);
> 
> [...]

Here is the summary with links:
  - [net] udp: Fix __ip_append_data()'s handling of MSG_SPLICE_PAGES
    https://git.kernel.org/netdev/net/c/0f71c9caf267

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


