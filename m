Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9000F7429AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 17:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjF2PbU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 11:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjF2PbS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:31:18 -0400
Received: from out-56.mta1.migadu.com (out-56.mta1.migadu.com [95.215.58.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688FE2703
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 08:31:15 -0700 (PDT)
Date:   Thu, 29 Jun 2023 11:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688052673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BLCCCtn3D5Nn10IbdfuE4yo3zVRj7DsJGkX8XNLTb+0=;
        b=hTyWt/Om1RZwzElx6kX2n/DJ9mCVQMdKVsoq35UHoHXkwta8JfPqm2TZvKGvbL18tNzFS7
        //0Ie8gUcyphJKUhvhK6q2gV64Q2vxARZun20Cb7RRq5grI6rcyE6mrK7P5BRpXYkQ/opj
        Bkhx6mHzjup5Y0Jg9YgqCRrK/f82jLk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230629153108.wyn32bvaxmztnakl@moria.home.lan>
References: <e1570c46-68da-22b7-5322-f34f3c2958d9@kernel.dk>
 <2e635579-37ba-ddfc-a2ab-e6c080ab4971@kernel.dk>
 <20230628221342.4j3gr3zscnsu366p@moria.home.lan>
 <d697ec27-8008-2eb6-0950-f612a602dcf5@kernel.dk>
 <20230628225514.n3xtlgmjkgapgnrd@moria.home.lan>
 <1e2134f1-f48b-1459-a38e-eac9597cd64a@kernel.dk>
 <20230628235018.ttvtzpfe42fri4yq@moria.home.lan>
 <ZJzXs6C8G2SL10vq@dread.disaster.area>
 <d6546c44-04db-cbca-1523-a914670a607f@kernel.dk>
 <20230629-fragen-dennoch-fb5265aaba23@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629-fragen-dennoch-fb5265aaba23@brauner>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 29, 2023 at 01:18:11PM +0200, Christian Brauner wrote:
> On Wed, Jun 28, 2023 at 07:33:18PM -0600, Jens Axboe wrote:
> > On 6/28/23 7:00?PM, Dave Chinner wrote:
> > > On Wed, Jun 28, 2023 at 07:50:18PM -0400, Kent Overstreet wrote:
> > >> On Wed, Jun 28, 2023 at 05:14:09PM -0600, Jens Axboe wrote:
> > >>> On 6/28/23 4:55?PM, Kent Overstreet wrote:
> > >>>>> But it's not aio (or io_uring or whatever), it's simply the fact that
> > >>>>> doing an fput() from an exiting task (for example) will end up being
> > >>>>> done async. And hence waiting for task exits is NOT enough to ensure
> > >>>>> that all file references have been released.
> > >>>>>
> > >>>>> Since there are a variety of other reasons why a mount may be pinned and
> > >>>>> fail to umount, perhaps it's worth considering that changing this
> > >>>>> behavior won't buy us that much. Especially since it's been around for
> > >>>>> more than 10 years:
> > >>>>
> > >>>> Because it seems that before io_uring the race was quite a bit harder to
> > >>>> hit - I only started seeing it when things started switching over to
> > >>>> io_uring. generic/388 used to pass reliably for me (pre backpointers),
> > >>>> now it doesn't.
> > >>>
> > >>> I literally just pasted a script that hits it in one second with aio. So
> > >>> maybe generic/388 doesn't hit it as easily, but it's surely TRIVIAL to
> > >>> hit with aio. As demonstrated. The io_uring is not hard to bring into
> > >>> parity on that front, here's one I posted earlier today for 6.5:
> > >>>
> > >>> https://lore.kernel.org/io-uring/20230628170953.952923-4-axboe@kernel.dk/
> > >>>
> > >>> Doesn't change the fact that you can easily hit this with io_uring or
> > >>> aio, and probably more things too (didn't look any further). Is it a
> > >>> realistic thing outside of funky tests? Probably not really, or at least
> > >>> if those guys hit it they'd probably have the work-around hack in place
> > >>> in their script already.
> > >>>
> > >>> But the fact is that it's been around for a decade. It's somehow a lot
> > >>> easier to hit with bcachefs than XFS, which may just be because the
> > >>> former has a bunch of workers and this may be deferring the delayed fput
> > >>> work more. Just hand waving.
> > >>
> > >> Not sure what you're arguing here...?
> > >>
> > >> We've had a long standing bug, it's recently become much easier to hit
> > >> (for multiple reasons); we seem to be in agreement on all that. All I'm
> > >> saying is that the existence of that bug previously is not reason to fix
> > >> it now.
> > > 
> > > I agree with Kent here  - the kernel bug needs to be fixed
> > > regardless of how long it has been around. Blaming the messenger
> > > (userspace, fstests, etc) and saying it should work around a
> > > spurious, unpredictable, undesirable and user-undebuggable kernel
> > > behaviour is not an acceptible solution here...
> > 
> > Not sure why you both are putting words in my mouth, I've merely been
> > arguing pros and cons and the impact of this. I even linked the io_uring
> > addition for ensuring that side will work better once the deferred fput
> > is sorted out. I didn't like the idea of fixing this through umount, and
> > even outlined how it could be fixed properly by ensuring we flush
> > per-task deferred puts on task exit.
> > 
> > Do I think it's a big issue? Not at all, because a) nobody has reported
> > it until now, and b) it's kind of a stupid case. If we can fix it with
> 
> Agreed.

yeah, the rest of this email that I snipped is _severely_ confused about
what is going on here.

Look, the main thing I want to say is - I'm not at all impressed by this
continual evasiveness from you and Jens. It's a bug, it needs to be
fixed.

We are engineers. It is our literal job to do the hard work and solve
the hard problems, and leave behind a system more robust and more
reliable for the people who come after us to use.

Not to kick the can down the line and leave lurking landmines in the
form of "oh you just have to work around this like x..."
