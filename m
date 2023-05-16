Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD5C7051E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 17:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbjEPPR1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 11:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbjEPPRY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 11:17:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E3C7D8E;
        Tue, 16 May 2023 08:17:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B55963B3A;
        Tue, 16 May 2023 15:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71041C433D2;
        Tue, 16 May 2023 15:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684250239;
        bh=zbsLxnAMj2vSIfOTUoVRyfsNlOWW5Uqw9nion1XeX4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PMTpX/YIRwsa4A8MO42slLD90eYpwk5Grd8dbmfPivPpPaa1JOWehAz+POdgblVEh
         D2laHfSTr4zpFVohDVcUfQfbV2iXxVg2/qSgRoENMhBp4K6MQciHSqd9P5f+bXTsYn
         gDugDHX7qYxEug0WIvsmZsSQo42q4vGEUBe/KagYb8Gq8ZADtQ0aUARE/frffW64xP
         tGfTPg9hxILttqTIwg99VYf4MXvfWPAuuuC4osf00WezPA37h8Tp/z7rW55J+VR938
         qE4WkuZyjG/1nZkz5l+EhlqVV/Oju2SjjDvgJB5Y8YHOWbAEGauCF63DmsD44zDIno
         dg/3E/HgJg8rQ==
Date:   Tue, 16 May 2023 08:17:18 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, hch@infradead.org,
        sandeen@sandeen.net, song@kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        jikos@kernel.org, bvanassche@acm.org, ebiederm@xmission.com,
        mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
        da.gomez@samsung.com, linux-fsdevel@vger.kernel.org,
        kernel@tuxforce.de, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] fs: add automatic kernel fs freeze / thaw and remove
 kthread freezing
Message-ID: <20230516151718.GP858815@frogsfrogsfrogs>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-7-mcgrof@kernel.org>
 <20230509012013.GD2651828@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509012013.GD2651828@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 09, 2023 at 11:20:13AM +1000, Dave Chinner wrote:
> On Sun, May 07, 2023 at 06:17:17PM -0700, Luis Chamberlain wrote:
> > Add support to automatically handle freezing and thawing filesystems
> > during the kernel's suspend/resume cycle.
> > 
> > This is needed so that we properly really stop IO in flight without
> > races after userspace has been frozen. Without this we rely on
> > kthread freezing and its semantics are loose and error prone.
> > For instance, even though a kthread may use try_to_freeze() and end
> > up being frozen we have no way of being sure that everything that
> > has been spawned asynchronously from it (such as timers) have also
> > been stopped as well.
> > 
> > A long term advantage of also adding filesystem freeze / thawing
> > supporting during suspend / hibernation is that long term we may
> > be able to eventually drop the kernel's thread freezing completely
> > as it was originally added to stop disk IO in flight as we hibernate
> > or suspend.
> > 
> > This does not remove the superfluous freezer calls on all filesystems.
> > Each filesystem must remove all the kthread freezer stuff and peg
> > the fs_type flags as supporting auto-freezing with the FS_AUTOFREEZE
> > flag.
> > 
> > Subsequent patches remove the kthread freezer usage from each
> > filesystem, one at a time to make all this work bisectable.
> > Once all filesystems remove the usage of the kthread freezer we
> > can remove the FS_AUTOFREEZE flag.
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  fs/super.c             | 50 ++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/fs.h     | 14 ++++++++++++
> >  kernel/power/process.c | 15 ++++++++++++-
> >  3 files changed, 78 insertions(+), 1 deletion(-)
> 
> .....
> 
> > diff --git a/kernel/power/process.c b/kernel/power/process.c
> > index cae81a87cc91..7ca7688f0b5d 100644
> > --- a/kernel/power/process.c
> > +++ b/kernel/power/process.c
> > @@ -140,6 +140,16 @@ int freeze_processes(void)
> >  
> >  	BUG_ON(in_atomic());
> >  
> > +	pr_info("Freezing filesystems ... ");
> > +	error = iterate_supers_reverse_excl(fs_suspend_freeze_sb, NULL);
> > +	if (error) {
> > +		pr_cont("failed\n");
> > +		iterate_supers_excl(fs_suspend_thaw_sb, NULL);
> > +		thaw_processes();
> > +		return error;
> 
> That looks wrong. i.e. if the sb iteration fails to freeze a
> filesystem (for whatever reason) then every userspace frozen
> filesystem will be thawed by this call, right? i.e. it will thaw
> more than just the filesystems frozen by the suspend freeze
> iteration before it failed.
> 
> Don't we only want to thaw the superblocks we froze before the
> failure occurred? i.e. the "undo" iteration needs to start from the
> last superblock we successfully froze and then only walk to the tail
> of the list we started from?

I think fs_suspend_thaw_sb calls thaw_super(..., false), which will not
undo a userspace freeze.  So strictly speaking the answer to your
question is (AFAICT) "no it won't"

That said, I read this and also had a raised-eyebrow moment -- we
shouldn't (un?)touch superblocks that fs_suspend_freeze_sb didn't touch
in the first place.

I wonder if we should be using that NULL parameter to keep track of the
last super that fs_suspend_freeze_sb didn't fail on?

--D

> > +	}
> > +	pr_cont("done.\n");
> > +
> >  	/*
> >  	 * Now that the whole userspace is frozen we need to disable
> >  	 * the OOM killer to disallow any further interference with
> > @@ -149,8 +159,10 @@ int freeze_processes(void)
> >  	if (!error && !oom_killer_disable(msecs_to_jiffies(freeze_timeout_msecs)))
> >  		error = -EBUSY;
> >  
> > -	if (error)
> > +	if (error) {
> > +		iterate_supers_excl(fs_suspend_thaw_sb, NULL);
> >  		thaw_processes();
> > +	}
> 
> Does this also have the same problem? i.e. if fs_suspend_freeze_sb()
> skips over superblocks that are already userspace frozen without any
> error, then this will incorrectly thaw those userspace frozen
> filesystems.
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
