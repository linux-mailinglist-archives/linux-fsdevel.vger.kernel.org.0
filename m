Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A47B67B6F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 17:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbjAYQdC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 11:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbjAYQdB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:33:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3082BB89;
        Wed, 25 Jan 2023 08:32:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FA5060F78;
        Wed, 25 Jan 2023 16:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21F8C433D2;
        Wed, 25 Jan 2023 16:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674664378;
        bh=kPQD0F+AbRySAe3GWkf8YSP68mkwv/mW9AHC1Kqq6pA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M2MV7GGlujESvU3sOc4Uy1lbhBp0yjFBsj9hw2Wr1voFM/zs60qgEozj6vm2gRR8P
         xYdQoFzXRgOcLS/A2NYg6gblymfjltxvs1HTTslmVNRvvCfwyrlYWBChnfllabrbjm
         YVphdxl52N5i4NrAzGqDhaX8fxuxw6LyXgM8DyfCgSP+JvbSQXsevG4MYrxi0MvENj
         d9sjDijsaqMgDPj+J7+BtgPSVxy1H5D682R3Zoc7blgAnMBNWY5yzq2gTIRim1C1z6
         cAuHEg+xp2irE6IVjViS1V7Jl9shb1KqiDWhpXr3vZT4NgwiuAdI+wOptRckzBWc5J
         iAxIsaIffvMpQ==
Date:   Wed, 25 Jan 2023 08:32:58 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: replacement i_version counter for xfs
Message-ID: <Y9FZupBCyPGCMFBd@magnolia>
References: <57c413ed362c0beab06b5d83b7fc4b930c7662c4.camel@kernel.org>
 <20230125000227.GM360264@dread.disaster.area>
 <86f993a69a5be276164c4d3fc1951ff4bde881be.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86f993a69a5be276164c4d3fc1951ff4bde881be.camel@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 25, 2023 at 06:47:12AM -0500, Jeff Layton wrote:
> On Wed, 2023-01-25 at 11:02 +1100, Dave Chinner wrote:
> > On Tue, Jan 24, 2023 at 07:56:09AM -0500, Jeff Layton wrote:
> > > A few months ago, I posted a patch to make xfs not bump its i_version
> > > counter on atime updates. Dave Chinner NAK'ed that patch, mentioning
> > > that xfs would need to replace it with an entirely new field as the
> > > existing counter is used for other purposes and its semantics are set in
> > > stone.
> > > 
> > > Has anything been done toward that end?
> > 
> > No, because we don't have official specification of the behaviour
> > the nfsd subsystem requires merged into the kernel yet.
> > 
> 
> Ok. Hopefully that will be addressed in v6.3.
> 
> > > Should I file a bug report or something?
> > 
> > There's nothing we can really do until the new specification is set
> > in stone. Filing a bug report won't change anything material.
> > 
> > As it is, I'm guessing that you desire the behaviour to be as you
> > described in the iversion patchset you just posted. That is
> > effectively:
> > 
> >   * The change attribute (i_version) is mandated by NFSv4 and is mostly for
> >   * knfsd, but is also used for other purposes (e.g. IMA). The i_version must
> > - * appear different to observers if there was a change to the inode's data or
> > - * metadata since it was last queried.
> > + * appear larger to observers if there was an explicit change to the inode's
> > + * data or metadata since it was last queried.
> > 
> > i.e. the definition is changing from *any* metadata or data change
> > to *explicit* metadata/data changes, right? i.e. it should only
> > change when ctime changes?
> > 
> 
> Yes.
> 
> > IIUC the rest of the justification for i_version is that ctime might
> > lack the timestamp granularity to disambiguate sub-timestamp
> > granularity changes, so i_version is needed to bridge that gap.
> > 
> > Given that XFS has nanosecond timestamp resolution in the on-disk
> > format, both i_version and ctime changes are journalled, and
> > ctime/i_version will always change at exactly the same time in the
> > same transactions, there are no inherent sub-timestamp granularity
> > problems with ctime within XFS. Any deficiency in ctime resolution
> > comes solely from the granularity of the VFS inode timestamp
> > functions.
> > 
> > And so if current_time() was to provide fine-grained nanosecond
> > timestamp resolution for exported XFS filesystems (i.e. use
> > ktime_get_real_ts64() conditionally), then it seems to me that the
> > nfsd i_version function becomes completely redundant.
> > 
> > i.e. we are pretty much guaranteed that ctime on exported
> > filesystems will always be different for explicit modifications to
> > the same inode, and hence we can just use ctime as the version
> > change identifier without needing any on-disk format changes at all.
> > 
> > And we can optimise away that overhead when the filesystem is not
> > exported by just using the coarse timestamps because there is no
> > need for sub-timer-tick disambiguation of single file
> > modifications....
> > 
> 
> Ok, so conditional on (maybe) a per fstype flag, and whether the
> filesystem is exported?
> 
> It's not trivial to tell whether something is exported though. We
> typically only do that sort of checking within nfsd. That involves an
> upcall into mountd, at a minimum.
> 
> I don't think you want to be plumbing calls to exportfs into xfs for
> this. It may be simpler to just add a new on-disk counter and be done
> with it.

Simpler for you, maybe.  Ondisk format changes are a PITA to evaluate
and come with a long support burden.  We'd also have to write
xfs-specific testcases to ensure that the counter updates according to
specification.

Poking the kernel to provide sub-jiffies timestamp granularity when
required stays within the existing ondisk format, can be added to any
filesystem with sufficient timestamp granularity, and can be the subject
of a generic/ vfs test.

I also wonder if it's even necessary to use ktime_get_real_ts64 in all
cases -- can we sample the coarse granularity timestamp, and only go for
the higher resolution one if the first matches the ctime?

> > Hence it appears to me that with the new i_version specification
> > that there's an avenue out of this problem entirely that is "nfsd
> > needs to use ctime, not i_version". This solution seems generic
> > enough that filesystems with existing on-disk nanosecond timestamp
> > granularity would no longer need explicit on-disk support for the
> > nfsd i_version functionality, yes?
> > 
> 
> Pretty much.
> 
> My understanding has always been that it's not the on-disk format that's
> the limiting factor, but the resolution of in-kernel timestamp sources.
> If ktime_get_real_ts64 has real ns granularity, then that should be
> sufficient (at least for the moment). I'm unclear on the performance
> implications with such a change though.

I bet you can find some arm board or something with a terrible
clocksource that will take forever to produce high resolution timestamps
and get it wrong.

> You had also mentioned a while back that there was some desire for
> femtosecond resolution on timestamps. Does that change the calculus here
> at all? Note that the i_version is not subject to any timestamp
> granularity issues.

I personally don't care to go enlarge xfs timestamps even further to
support sub-ns resolution, but I see the theoretical argument for
needing them on an 8GHz Intel i9-13900KS(paceheater)...

> If you want nfsd to start using the ctime for i_version with xfs, then
> you can just turn off the SB_I_IVERSION flag. You will need to do some
> work though to keep your "special" i_version that also counts atime
> updates working once you turn that off. You'll probably want to do that
> anyway though since the semantics for xfs's version counter are
> different from everyone else's.
> 
> If this is what you choose to do for xfs, then the question becomes: who
> is going to do that timestamp rework?
> 
> Note that there are two other lingering issues with i_version. Neither
> of these are xfs-specific, but they may inform the changes you want to
> make there:
> 
> 1/ the ctime and i_version can roll backward on a crash.
> 
> 2/ the ctime and i_version are both currently updated before write data
> is copied to the pagecache. It would be ideal if that were done
> afterward instead. (FWIW, I have some draft patches for btrfs and ext4
> for this, but they need a lot more testing.)

You might also want some means for xfs to tell the vfs that it already
did the timestamp update (because, say, we had to allocate blocks).
I wonder what people will say when we have to run a transaction before
the write to peel off suid bits and another one after to update ctime.

--D

> 
> -- 
> Jeff Layton <jlayton@kernel.org>
