Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A692F75A4C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 05:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjGTDaf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 23:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGTDae (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 23:30:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CB41B9;
        Wed, 19 Jul 2023 20:30:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B222F6126D;
        Thu, 20 Jul 2023 03:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F35FC433C8;
        Thu, 20 Jul 2023 03:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689823832;
        bh=OnSRL/M/dbuk991nGBrfC0/pCCMwx2qMx5t/Th8WDY4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DLP0S+lHKonruVV95NGNwFLFr5aWNx45vINgAd1CVjDbI/PxvcmUv57niu5feAGkY
         AWElUA7x+ISFrYGq/jkvkfn4q6t04zKRia/WReyo9T88T6CNd+m2heMlul2896iWth
         JguL4emjfN7RreQNklhpOSKt4TGwUgNqssc7rhrAOqGdUy0Ixax1p0M54pRFVuyGwE
         i7dgQlwm0YcCQHmSiMSik+TgPhgoWfrExGhO4xVhNqw1sBDlfaokr/47tixTw3D+mM
         IrJc2AQzdNVRpO4QDu4TdwbOA4T2hESliP6LNvOgpqRdMk7YriQ3UqnC9d8w085jmB
         EIvkZAqeEpKSg==
Date:   Wed, 19 Jul 2023 20:30:30 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     netdev@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        Aleksandr Nogikh <nogikh@google.com>,
        syzbot <syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com>,
        dsterba@suse.cz, bakmitopiacibubur@boga.indosterling.com,
        clm@fb.com, davem@davemloft.net, dsahern@kernel.org,
        dsterba@suse.com, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        josef@toxicpanda.com, kadlec@netfilter.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux@armlinux.org.uk, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] [netfilter?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS
 too low! (2)
Message-ID: <20230719203030.1296596a@kernel.org>
In-Reply-To: <20230719231207.GF32192@breakpoint.cc>
References: <20230719170446.GR20457@twin.jikos.cz>
        <00000000000042a3ac0600da1f69@google.com>
        <CANp29Y4Dx3puutrowfZBzkHy1VpWHhQ6tZboBrwq_qNcFRrFGw@mail.gmail.com>
        <20230719231207.GF32192@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PLING_QUERY,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 20 Jul 2023 01:12:07 +0200 Florian Westphal wrote:
> I don't see any netfilter involvement here.
> 
> The repro just creates a massive amount of team devices.
> 
> At the time it hits the LOCKDEP limits on my test vm it has
> created ~2k team devices, system load is at +14 because udev
> is also busy spawing hotplug scripts for the new devices.
> 
> After reboot and suspending the running reproducer after about 1500
> devices (before hitting lockdep limits), followed by 'ip link del' for
> the team devices gets the lockdep entries down to ~8k (from 40k),
> which is in the range that it has on this VM after a fresh boot.
> 
> So as far as I can see this workload is just pushing lockdep
> past what it can handle with the configured settings and is
> not triggering any actual bug.

The lockdep splat because of netdevice stacking is one of our top
reports from syzbot. Is anyone else feeling like we should add 
an artificial but very high limit on netdev stacking? :(
