Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537ED4F99F8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 17:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237927AbiDHP55 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 11:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237965AbiDHP5v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:57:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8FA21B2;
        Fri,  8 Apr 2022 08:55:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A06861FEA;
        Fri,  8 Apr 2022 15:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B609C385A1;
        Fri,  8 Apr 2022 15:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649433345;
        bh=z71D8Ftb9RFf7IcaJ0ZqdFqokasCdasRxdzV0agJtrY=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=U2HvdlT609p4kzuyhxP8AluqUQTrPV3CqliPhOt03S26DS6wkkw1mmtOCfk/aDPkq
         /w0XjxZS0Q38PSn4V6GU2WwCTnf/0RZIYoE9p1puooFxPd9+JJRjEdGIYp1Pi19bjZ
         NWOJlFwjHO4/NydFx7hlnKMqIfrnig4qMkSXLkE0pS/47KYFUbKbiGPcLJdIhVId+s
         Y3YIMa9qq0NSOlYX/sl4ZHRblot7TrFzR+1tIxqb07Sdna5N7+hOzzORrJqgRbAKws
         v1aear4KKyTvoWXttHbEhV6JfhlPflr1k/PsSGkazWnKtkZjwMS9bmciiMca+zFiRw
         ncyMSTuAopb6g==
Date:   Fri, 8 Apr 2022 16:55:41 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     dsterba@suse.cz, Thorsten Leemhuis <regressions@leemhuis.info>,
        Bruno Damasceno Freire <bdamasceno@hotmail.com.br>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, fdmanana@suse.com
Subject: Re: [regression] 5.15 kernel triggering 100x more inode evictions
Message-ID: <YlBa/Rc0lvJCm5Rr@debian9.Home>
References: <MN2PR20MB2512314446801B92562E26B5D2169@MN2PR20MB2512.namprd20.prod.outlook.com>
 <07bb78be-1d58-7d88-288b-6516790f3b5d@leemhuis.info>
 <MN2PR20MB251203B4B5445B4B0C4148C9D21D9@MN2PR20MB2512.namprd20.prod.outlook.com>
 <35b62998-e386-2032-5a7a-07e3413b3bc1@leemhuis.info>
 <MN2PR20MB251205164078C367C3FC4166D2E59@MN2PR20MB2512.namprd20.prod.outlook.com>
 <9163b8a9-e852-5786-24fa-d324e3118890@leemhuis.info>
 <20220408145222.GR15609@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408145222.GR15609@twin.jikos.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 08, 2022 at 04:52:22PM +0200, David Sterba wrote:
> On Fri, Apr 08, 2022 at 12:32:20PM +0200, Thorsten Leemhuis wrote:
> > Hi, this is your Linux kernel regression tracker. Top-posting for once,
> > to make this easily accessible to everyone.
> > 
> > Btrfs maintainers, what's up here? Yes, this regression report was a bit
> > confusing in the beginning, but Bruno worked on it. And apparently it's
> > already fixed in 5.16, but still in 5.15. Is this caused by a change
> > that is to big to backport or something?
> 
> I haven't identified possible fixes in 5.16 so I can't tell how much
> backport efforts it could be. As the report is related to performance on
> package updates, my best guess is that the patches fixing it are those
> from Filipe related to fsync/logging, and there are several of such
> improvements in 5.16. Or something else that fixes it indirectly.

So there's a lot of confusion in the thread, and the original openSUSE 
bugzilla [1] is also a bit confusing and large to follow.

Let me try to make it clear:

1) For some reason, outside btrfs' control, inode eviction is triggered
   a lot on 5.15 kernels in Bruno's test machine when doing package
   installations/updates with zypper. It triggers about 100x times more
   compared to 5.13, 5.14, 5.16 kernels, etc. This was measured with the
   bpftrace script I provided him at [1], and he's including part of it
   in his test script from this thread too;

2) If an inode is evicted, reloaded and then we attempt to do a rename on
   it, it can trigger unnecessary log updates, for the inode and/or the
   parent directory. This is just btrfs not knowing if the inode was
   previously logged in the current transaction before the inode was
   evicted - since it doesn't know for sure, it assumes the worst case,
   that is was logged, and then updates the log (partially relog the inode
   and its parent directory), otherwise we could get into an inconsistency
   in case it was logged before and we don't update the log;

3) About the excessive inode eviction, there's nothing we can do in btrfs,
   it's outside btrfs' control;

4) What can be done, and was done in a recent patchset [2] (5.18-rc1), was
   to make the behaviour on rename to not be so pessimistic, and instead
   accurately determine if an inode was logged before or not, even if it was
   recently evicted, and then skip log updates.

   The test scripts in the change logs of the patches of that patchset,
   essentially mimic what was happening with the zypper package
   installations/updates. Bruno's test script basically copies/integrates
   those test scripts;

5) We can not just backport that patchset [2] into 5.15, because that depends
   on several other patchsets that landed in 5.16, 5.17 and 5.18-rc1, which
   mostly do a heavy rework regarding directory logging:

   https://lore.kernel.org/linux-btrfs/cover.1630419897.git.fdmanana@suse.com/ (5.16)
   https://lore.kernel.org/linux-btrfs/cover.1631787796.git.fdmanana@suse.com/ (5.16)
   https://lore.kernel.org/linux-btrfs/cover.1632482680.git.fdmanana@suse.com/ (5.16)
   https://lore.kernel.org/linux-btrfs/cover.1635178668.git.fdmanana@suse.com/ (5.17)
   https://lore.kernel.org/linux-btrfs/cover.1639568905.git.fdmanana@suse.com/ (5.18-rc1)

   And possibly other smaller dependencies in between those patchsets;

6) In short, it is not known what causes the excessive evictions on 5.15
   on his machine for that specific workload - we don't have a commit to
   point at and say it caused a regression. The previously mentioned
   patchset ([2]) will however make things much better, performance wise, in
   case excessive inode eviction happens (regarding renames on btrfs).

This thread is also basically a revamp of an older thread [3].

[1] https://bugzilla.opensuse.org/show_bug.cgi?id=1193549
[2] https://lore.kernel.org/linux-btrfs/cover.1642676248.git.fdmanana@suse.com/
[3] https://lore.kernel.org/linux-fsdevel/MN2PR20MB251235DDB741CD46A9DD5FAAD24E9@MN2PR20MB2512.namprd20.prod.outlook.com/
