Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8590167B8E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 18:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbjAYR6U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 12:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbjAYR6P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:58:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3249C59261;
        Wed, 25 Jan 2023 09:58:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB4756159E;
        Wed, 25 Jan 2023 17:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85DBC433EF;
        Wed, 25 Jan 2023 17:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674669490;
        bh=shsgJHf6tme56I2MYk+WES+vitl4EEg2XPQH/BBXGSg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LnU1Mpco3dx7BZxywi64lkCc1hxZUNdo9vr90SM7+9T/k18/ozJQKEoa3IZVdH+dK
         8JOs5GDE9exA2kix5USwfiBhl2RSfRxX8mhGXCVYV62z8X0tKLW0Zlyn2NjNFpzGsb
         f76Z7agUMLQgq/U+6pZH0BOEuX7pKpvr8Zg1w8RMQKDBKZHQrr+fhSnI7josPuxhHf
         UycUlEoP+CHJ/S68Ig8HWownImA88FzhRwMw2QVTgPRy1TDngW6ZL2F3kxtCS7mlxF
         3Rwr3rtFaiOKe8dZweF3at1kVCCM57Cetz6fAj4WD/3qHT8XZ7/0F5/+7g/zD3QUuw
         4t0n5OaWZgM3Q==
Message-ID: <4d16f9f9eb678f893d4de695bd7cbff6409c3c5a.camel@kernel.org>
Subject: Re: replacement i_version counter for xfs
From:   Jeff Layton <jlayton@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Wed, 25 Jan 2023 12:58:08 -0500
In-Reply-To: <Y9FZupBCyPGCMFBd@magnolia>
References: <57c413ed362c0beab06b5d83b7fc4b930c7662c4.camel@kernel.org>
         <20230125000227.GM360264@dread.disaster.area>
         <86f993a69a5be276164c4d3fc1951ff4bde881be.camel@kernel.org>
         <Y9FZupBCyPGCMFBd@magnolia>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-01-25 at 08:32 -0800, Darrick J. Wong wrote:
> On Wed, Jan 25, 2023 at 06:47:12AM -0500, Jeff Layton wrote:
> > On Wed, 2023-01-25 at 11:02 +1100, Dave Chinner wrote:
> > > On Tue, Jan 24, 2023 at 07:56:09AM -0500, Jeff Layton wrote:
> > > > A few months ago, I posted a patch to make xfs not bump its i_versi=
on
> > > > counter on atime updates. Dave Chinner NAK'ed that patch, mentionin=
g
> > > > that xfs would need to replace it with an entirely new field as the
> > > > existing counter is used for other purposes and its semantics are s=
et in
> > > > stone.
> > > >=20
> > > > Has anything been done toward that end?
> > >=20
> > > No, because we don't have official specification of the behaviour
> > > the nfsd subsystem requires merged into the kernel yet.
> > >=20
> >=20
> > Ok. Hopefully that will be addressed in v6.3.
> >=20
> > > > Should I file a bug report or something?
> > >=20
> > > There's nothing we can really do until the new specification is set
> > > in stone. Filing a bug report won't change anything material.
> > >=20
> > > As it is, I'm guessing that you desire the behaviour to be as you
> > > described in the iversion patchset you just posted. That is
> > > effectively:
> > >=20
> > >   * The change attribute (i_version) is mandated by NFSv4 and is most=
ly for
> > >   * knfsd, but is also used for other purposes (e.g. IMA). The i_vers=
ion must
> > > - * appear different to observers if there was a change to the inode'=
s data or
> > > - * metadata since it was last queried.
> > > + * appear larger to observers if there was an explicit change to the=
 inode's
> > > + * data or metadata since it was last queried.
> > >=20
> > > i.e. the definition is changing from *any* metadata or data change
> > > to *explicit* metadata/data changes, right? i.e. it should only
> > > change when ctime changes?
> > >=20
> >=20
> > Yes.
> >=20
> > > IIUC the rest of the justification for i_version is that ctime might
> > > lack the timestamp granularity to disambiguate sub-timestamp
> > > granularity changes, so i_version is needed to bridge that gap.
> > >=20
> > > Given that XFS has nanosecond timestamp resolution in the on-disk
> > > format, both i_version and ctime changes are journalled, and
> > > ctime/i_version will always change at exactly the same time in the
> > > same transactions, there are no inherent sub-timestamp granularity
> > > problems with ctime within XFS. Any deficiency in ctime resolution
> > > comes solely from the granularity of the VFS inode timestamp
> > > functions.
> > >=20
> > > And so if current_time() was to provide fine-grained nanosecond
> > > timestamp resolution for exported XFS filesystems (i.e. use
> > > ktime_get_real_ts64() conditionally), then it seems to me that the
> > > nfsd i_version function becomes completely redundant.
> > >=20
> > > i.e. we are pretty much guaranteed that ctime on exported
> > > filesystems will always be different for explicit modifications to
> > > the same inode, and hence we can just use ctime as the version
> > > change identifier without needing any on-disk format changes at all.
> > >=20
> > > And we can optimise away that overhead when the filesystem is not
> > > exported by just using the coarse timestamps because there is no
> > > need for sub-timer-tick disambiguation of single file
> > > modifications....
> > >=20
> >=20
> > Ok, so conditional on (maybe) a per fstype flag, and whether the
> > filesystem is exported?
> >=20
> > It's not trivial to tell whether something is exported though. We
> > typically only do that sort of checking within nfsd. That involves an
> > upcall into mountd, at a minimum.
> >=20
> > I don't think you want to be plumbing calls to exportfs into xfs for
> > this. It may be simpler to just add a new on-disk counter and be done
> > with it.
>=20
> Simpler for you, maybe.  Ondisk format changes are a PITA to evaluate
> and come with a long support burden.  We'd also have to write
> xfs-specific testcases to ensure that the counter updates according to
> specification.
>=20
> Poking the kernel to provide sub-jiffies timestamp granularity when
> required stays within the existing ondisk format, can be added to any
> filesystem with sufficient timestamp granularity, and can be the subject
> of a generic/ vfs test.
>=20
> I also wonder if it's even necessary to use ktime_get_real_ts64 in all
> cases -- can we sample the coarse granularity timestamp, and only go for
> the higher resolution one if the first matches the ctime?
>=20
> > > Hence it appears to me that with the new i_version specification
> > > that there's an avenue out of this problem entirely that is "nfsd
> > > needs to use ctime, not i_version". This solution seems generic
> > > enough that filesystems with existing on-disk nanosecond timestamp
> > > granularity would no longer need explicit on-disk support for the
> > > nfsd i_version functionality, yes?
> > >=20
> >=20
> > Pretty much.
> >=20
> > My understanding has always been that it's not the on-disk format that'=
s
> > the limiting factor, but the resolution of in-kernel timestamp sources.
> > If ktime_get_real_ts64 has real ns granularity, then that should be
> > sufficient (at least for the moment). I'm unclear on the performance
> > implications with such a change though.
>=20
> I bet you can find some arm board or something with a terrible
> clocksource that will take forever to produce high resolution timestamps
> and get it wrong.
>=20
> > You had also mentioned a while back that there was some desire for
> > femtosecond resolution on timestamps. Does that change the calculus her=
e
> > at all? Note that the i_version is not subject to any timestamp
> > granularity issues.
>=20
> I personally don't care to go enlarge xfs timestamps even further to
> support sub-ns resolution, but I see the theoretical argument for
> needing them on an 8GHz Intel i9-13900KS(paceheater)...
>=20
> > If you want nfsd to start using the ctime for i_version with xfs, then
> > you can just turn off the SB_I_IVERSION flag. You will need to do some
> > work though to keep your "special" i_version that also counts atime
> > updates working once you turn that off. You'll probably want to do that
> > anyway though since the semantics for xfs's version counter are
> > different from everyone else's.
> >=20
> > If this is what you choose to do for xfs, then the question becomes: wh=
o
> > is going to do that timestamp rework?
> >=20
> > Note that there are two other lingering issues with i_version. Neither
> > of these are xfs-specific, but they may inform the changes you want to
> > make there:
> >=20
> > 1/ the ctime and i_version can roll backward on a crash.
> >=20
> > 2/ the ctime and i_version are both currently updated before write data
> > is copied to the pagecache. It would be ideal if that were done
> > afterward instead. (FWIW, I have some draft patches for btrfs and ext4
> > for this, but they need a lot more testing.)
>=20
> You might also want some means for xfs to tell the vfs that it already
> did the timestamp update (because, say, we had to allocate blocks).
> I wonder what people will say when we have to run a transaction before
> the write to peel off suid bits and another one after to update ctime.
>=20

That's a great question! There is a related one too once I started
looking at this in more detail:

Most filesystems end up updating the timestamp via a the call to
file_update_time in __generic_file_write_iter. Today, that's called very
early in the function and if it fails, the write fails without changing
anything.

What do we do now if the write succeeds, but update_time fails? We don't
want to return an error on the write() since the data did get copied in.
Ignoring it seems wrong too though. There could even be some way to
exploit that by changing the contents while holding the timestamp and
version constant.

At this point I'm leaning toward leaving the ctime and i_version to be
updated before the write, and just bumping the i_version a second time
after. In most cases the second bump will end up being a no-op, unless
an i_version query races in between.
--=20
Jeff Layton <jlayton@kernel.org>
