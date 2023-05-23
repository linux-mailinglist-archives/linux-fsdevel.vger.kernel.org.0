Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0423E70E3C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 19:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237829AbjEWQuv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 12:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237645AbjEWQut (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 12:50:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8D2CD;
        Tue, 23 May 2023 09:50:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06C5D61626;
        Tue, 23 May 2023 16:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44664C4339B;
        Tue, 23 May 2023 16:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684860646;
        bh=lJQMEEaxH+X5TCsKaSBgdt24AuBJP7OZ4bA8D/UqV24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BKfsDvkPX9hnJluM6cAbjJOLhcJatkMyMTm8yIznEEn2FNx68bWLHRCub1RaC5dej
         PwOk+cHFYFi12MwfPUwzp634oqXiVYuGmPWK7kBBq9s0ROlExPS2rt+o4/16zx2dXY
         0+3Hyd+5/M90vVqQTM+8QeBYaLlz+prRXuMZkXjpHB7wUKRV0faZJ1idjK8NcGI+cw
         8PKMPOr7GfnK0H0+txLVbd3zz4fw7c4Z1GppaLmUNyarWsHMtDDDpReaFfAf/7dPo2
         1UkSdyoa+DZCAwKeWuCWDAc/L1OC6/8A4v5MQGtvHUj18FTCbkEhumgZ5JqaOD1IrG
         BENvj0jgLsiUA==
Date:   Tue, 23 May 2023 16:50:44 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Pengfei Xu <pengfei.xu@intel.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, heng.su@intel.com,
        dchinner@redhat.com, lkp@intel.com,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: [Syzkaller & bisect] There is BUG: unable to handle kernel NULL
 pointer dereference in xfs_extent_free_diff_items in v6.4-rc3
Message-ID: <20230523165044.GA862686@google.com>
References: <ZGrOYDZf+k0i4jyM@xpf.sh.intel.com>
 <ZGsOH5D5vLTLWzoB@debian.me>
 <20230522160525.GB11620@frogsfrogsfrogs>
 <20230523000029.GB3187780@google.com>
 <ZGxry4yMn+DKCWcJ@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGxry4yMn+DKCWcJ@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dave,

On Tue, May 23, 2023 at 05:31:23PM +1000, Dave Chinner wrote:
> On Tue, May 23, 2023 at 12:00:29AM +0000, Eric Biggers wrote:
> > On Mon, May 22, 2023 at 09:05:25AM -0700, Darrick J. Wong wrote:
> > > On Mon, May 22, 2023 at 01:39:27PM +0700, Bagas Sanjaya wrote:
> > > > On Mon, May 22, 2023 at 10:07:28AM +0800, Pengfei Xu wrote:
> > > > > Hi Darrick,
> > > > > 
> > > > > Greeting!
> > > > > There is BUG: unable to handle kernel NULL pointer dereference in
> > > > > xfs_extent_free_diff_items in v6.4-rc3:
> > > > > 
> > > > > Above issue could be reproduced in v6.4-rc3 and v6.4-rc2 kernel in guest.
> > > > > 
> > > > > Bisected this issue between v6.4-rc2 and v5.11, found the problem commit is:
> > > > > "
> > > > > f6b384631e1e xfs: give xfs_extfree_intent its own perag reference
> > > > > "
> > > > > 
> > > > > report0, repro.stat and so on detailed info is link: https://github.com/xupengfe/syzkaller_logs/tree/main/230521_043336_xfs_extent_free_diff_items
> > > > > Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230521_043336_xfs_extent_free_diff_items/repro.c
> > > > > Syzkaller reproduced prog: https://github.com/xupengfe/syzkaller_logs/blob/main/230521_043336_xfs_extent_free_diff_items/repro.prog
> > > > > Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230521_043336_xfs_extent_free_diff_items/kconfig_origin
> > > > > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230521_043336_xfs_extent_free_diff_items/bisect_info.log
> > > > > Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230521_043336_xfs_extent_free_diff_items/v6.4-rc3_reproduce_dmesg.log
> > > > > 
> > > > > v6.4-rc3 reproduced info:
> > > 
> > > Diagnosis and patches welcomed.
> > > 
> > > Or are we doing the usual syzbot bullshit where you all assume that I'm
> > > going to do all the fucking work for you?
> > > 
> > 
> > It looks like Pengfei already took the time to manually bisect this issue to a
> > very recent commit authored by you.  Is that not helpful?
> 
> No. The bisect is completely meaningless.
> 
> The cause of the problem is going to be some piece of corrupted
> metadata has got through a verifier check or log recovery and has
> resulted in a perag lookup failing. The bisect landed on the commit
> where the perag dependency was introduced; whatever is letting
> unchecked corrupted metadata throught he verifiers has existed long
> before this recent change was made.
> 
> I've already spent two hours analysing this report - I've got to the
> point where I've isolated the transaction in the trace, I see the
> allocation being run as expected, I see all the right things
> happening, and then it goes splat after the allocation has committed
> and it starts processing defered extent free operations. Neither the
> code nor the trace actually tell me anything about the nature of the
> failure that has occurred.
> 
> At this point, I still don't know where the corrupted metadata is
> coming from. That's the next thing I need to look at, and then I
> realised that this bug report *doesn't include a pointer to the
> corrupted filesystem image that is being mounted*.
> 
> IOWs, the bug report is deficient and not complete, and so I'm
> forced to spend unnecessary time trying to work out how to extract
> the filesystem image from a weird syzkaller report that is basically
> just a bunch of undocumented blobs in a github tree.
> 
> This is the same sort of shit we've been having to deal rigth from
> teh start with syzkaller. It doesn't matter that syzbot might have
> improved it's reporting a bit these days, we still have to deal with
> this sort of poor reporting from all the private syzkaller bot crank
> handles that are being turned by people who know little more than
> how to turn a crank handle.
> 
> To make matters worse, this is a v4 filesystem which has known
> unfixable issues when handling corrupted filesystems in both log
> replay and in runtime detection of corruption. We've repeatedly told
> people running syzkaller (including Pengfei) to stop running it on
> v4 filesystems and only report bugs on V5 format filesystems. This
> is to avoid wasting time triaging these problems back down to v4
> specific format bugs that ican only be fixed by moving to the v5
> format.
> 
> .....
> 
> And now after 4 hours, I have found several corruptions in the on
> disk format that v5 filesystems will have caught and v4 filesystems
> will not.
> 
> The AGFL indexes in the AGF have been corrupted. They are within
> valid bounds, but first + last != count. On a V5 filesystem we catch
> this and trigger an AGFL reset that is done of the first allocation.
> v4 filesystems do not do this last - first = count validation at
> all.
> 
> Further, the AGFL has also been corrupted - it is full of null
> blocks. This is another problem that V5 filesystems can catch and
> report, but v4 filesystems don't because they don't have headers in
> the AGFL that enable verification.
> 
> Yes, there's definitely scope for further improvements in validation
> here, but the unhandled corruptions that I've found still don't
> explain how we got a null perag in the xefi created from a
> referenced perag that is causing the crash.
> 
> So, yeah, the bisect is completely useless, and I've got half a day
> into triage and I still don't have any clue what the corruption is
> that is causing the kernel to crash....
> 
> ----
> 
> Do you see the problem now, Eric?
> 
> Performing root-cause analysis of syzkaller based malicious
> filesystem corruption bugs is anything but simple. It takes hours to
> days just to work through triage of a single bug report, and we're
> getting a couple of these sorts of bug reported every week.
> 
> People who do nothing but turn the bot crank handle throw stuff like
> this over the wall at usi are easy to find. Bots and bot crank
> turners scale really easily. Engineers who can find and fix the
> problems, OTOH, don't.
> 
> And just to rub salt into the wounds, we now have people who turn
> crank handles on other bots to tell everyone else how important
> they think the problem is without having performed any triage at
> all. And then we're expected to make an untriaged bug report our
> highest priority and immediately spend hours of time to make sense
> of the steaming pile that has just been dumped on us.
> 
> Worse, we've had people who track regressions imply that if we don't
> prioritise fixing regressions ahead of anything else we might be
> working on, then we might not get new work merged until the
> regressions have been fixed. In my book, that's akin to extortion,
> and it might give you some insight to why Darrick reacted so
> vigorously to having an untriaged syzkaller bug tracked as a high
> visibility, must fix regression.
> 
> What we really need is more people who are capable to triaging bug
> reports like this instead of having lots of people cranking on bot
> handles and dumping untriaged bug reports on the maintainer.
> Further, if you aren't capable of triaging the bug report, then you
> aren't qualified to classify it as a "must fix" regression.
> 
> It's like people don't have any common sense or decency anymore:
> it's not very nice to classify a bug as a "must fix" regression
> without first having consulted the engineers responsible for that
> code. If you don't know what the cause of the bug is, then don't
> crank handles that cause people to have to address it immediately!
> 
> If nothing changes, then the ever increasing amount of bot cranking
> is going to burn us out completely. Nobody wins when that
> happens....
> 

Thanks for the explanation.  I personally didn't need such a long explanation,
but it should be helpful for Pengfei and others.

I was mostly just concerned that a report of a bug with a reproducer and a
bisection to a recent commit just got a response from the maintainer with
profanities and no helpful information.  ("It's like people don't have any
common sense or decency anymore...")  I think that makes it hard for people like
Pengfei to understand what they did wrong, especially when they might have
gotten very different responses from other kernel subsystems.  So, thank you for
providing a more detailed explanation, though honestly, something much shorter
would have sufficed.  (Maybe you should even have a write-up on the XFS wiki or
in Documentation/ that you point to whenever this sort of thing comes up?)

BTW, given that XFS has a policy of not fixing bugs in XFS v4 filesystems, I
suggest adding a kconfig option that disables the support for mounting XFS v4
filesystems.  Then you could just tell the people fuzzing XFS filesystem images
that they need to use that option.  That would save everyone a lot of time.
(To be clear, I'm not arguing for the XFS policy on v4 filesystems being right
or wrong; that's really not something I'd like to get into again...  I'm just
saying that if that's indeed your policy, this is what you should do.)

- Eric
