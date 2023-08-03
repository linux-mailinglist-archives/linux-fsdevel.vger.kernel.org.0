Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D33776E9B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 15:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjHCNNt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 09:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjHCNMi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:12:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AFA55BC;
        Thu,  3 Aug 2023 06:11:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0FD561D94;
        Thu,  3 Aug 2023 13:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 383D2C433C8;
        Thu,  3 Aug 2023 13:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691068221;
        bh=zJq+7MHzjebZFTJ3+CcDRXVZzxlvDho72oqWr9mesO0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SVUCI//OsHkUay0eCPcq7hyihL/dnpSISjlvafir7TNzgKr6krpnN7O1CEzyX1cOs
         0qYKyC5EoL6LmYRC238BW9ddC2U6v53zUgb7LNimftPrKFNB6j36/smZKrrK9LVSLx
         MhGwBwAy/uS5ZCVkb2cYYj5xgOJxbpZLYVZpp32TbOlMTQh79TO+6wQXwADhEgS5rP
         MQFagNyOnOrCzAk43HZ1R6Xwzs1gnBAzp0pAEAVvX/7xLdQDby6iXttC6qnXMhBUdp
         xYSzobqnoSRFrxfB7zfHlB6BEjal51h5jgFmD9XPg7x8iv0qb/SRedoHy8tZaGI/vK
         pJ1b6NUqzoIRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1951CC41620;
        Thu,  3 Aug 2023 13:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] udp6: Fix __ip6_append_data()'s handling of
 MSG_SPLICE_PAGES
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169106822109.11210.4147932489626206535.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Aug 2023 13:10:21 +0000
References: <1580952.1690961810@warthog.procyon.org.uk>
In-Reply-To: <1580952.1690961810@warthog.procyon.org.uk>
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

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 02 Aug 2023 08:36:50 +0100 you wrote:
> __ip6_append_data() can has a similar problem to __ip_append_data()[1] when
> asked to splice into a partially-built UDP message that has more than the
> frag-limit data and up to the MTU limit, but in the ipv6 case, it errors
> out with EINVAL.  This can be triggered with something like:
> 
>         pipe(pfd);
>         sfd = socket(AF_INET6, SOCK_DGRAM, 0);
>         connect(sfd, ...);
>         send(sfd, buffer, 8137, MSG_CONFIRM|MSG_MORE);
>         write(pfd[1], buffer, 8);
>         splice(pfd[0], 0, sfd, 0, 0x4ffe0ul, 0);
> 
> [...]

Here is the summary with links:
  - [net-next] udp6: Fix __ip6_append_data()'s handling of MSG_SPLICE_PAGES
    https://git.kernel.org/netdev/net-next/c/ce650a166335

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


