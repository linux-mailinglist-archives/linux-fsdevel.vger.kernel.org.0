Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0C7682BF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 12:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjAaLzs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 06:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjAaLzq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:55:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F214512073;
        Tue, 31 Jan 2023 03:55:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F170614C9;
        Tue, 31 Jan 2023 11:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8530CC4339C;
        Tue, 31 Jan 2023 11:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675166142;
        bh=38TlEiClFKzDoIJDcK+NXxKuKK97b4jG8VzA2Kq7w7s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IImp6gB67SkMXTPWzZ38Z/N8q5l+5u/9T8uzOPwCmnBDyFYXHrIG/ea7kb0mjmDvC
         +aF8c2W+nske6XaT0EasEKkvQ5DXD/bCovFZRC+uTToDlTy8Pep2UFJPlLi3TIpn4O
         XhYkNwiKxqvl/tn0bxNJaenjmTU9a7seGViMk9Oz9O2nPKKIZT0lV/AZ5tLn+1k8x1
         wooG7a+BRx/Uj1qd7g2CBs/iAoH+t2MzXoqW2uGZnX0YR3H7BjCpjKTdy5QxhaP0Xm
         N4JTyPURKet6Jt45X0aoNU2muV6cyeNvpU6zU0nOhTEIStZLWID6b7TvWVad6mOBsp
         nLpoAFixLqqsA==
Message-ID: <2d8e60ea6eb5f8b79e22c0a15d9266a24b4f7995.camel@kernel.org>
Subject: Re: replacement i_version counter for xfs
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Tue, 31 Jan 2023 06:55:41 -0500
In-Reply-To: <20230130015413.GN360264@dread.disaster.area>
References: <57c413ed362c0beab06b5d83b7fc4b930c7662c4.camel@kernel.org>
         <20230125000227.GM360264@dread.disaster.area>
         <86f993a69a5be276164c4d3fc1951ff4bde881be.camel@kernel.org>
         <20230130015413.GN360264@dread.disaster.area>
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

On Mon, 2023-01-30 at 12:54 +1100, Dave Chinner wrote:
> On Wed, Jan 25, 2023 at 06:47:12AM -0500, Jeff Layton wrote:
> > On Wed, 2023-01-25 at 11:02 +1100, Dave Chinner wrote:
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
>=20
> Not sure why a per-fstype flag is necessary?
>=20

I was thinking most filesystems wouldn't need these high-res timestamps,
so we could limit it to those that opt in via a fstype flag.

> >=20
> > It's not trivial to tell whether something is exported though. We
> > typically only do that sort of checking within nfsd. That involves an
> > upcall into mountd, at a minimum.
> >=20
> > I don't think you want to be plumbing calls to exportfs into xfs for
> > this. It may be simpler to just add a new on-disk counter and be done
> > with it.
>=20
> I didn't ever expect for XFS to have to be aware of the fact that a
> user has exported the filesystem. If "filesystem has been exported"
> tracking is required, then we add a flag/counter to the superblock,
> and the NFSd subsystem updates the counter/flag when it is informed
> that part of the filesystem has been exported/unexported.
>=20
> The NFSd/export subsystem is pinning filesystems in memory when they
> are exported. This is evident by the fact we cannot unmount an
> exported filesystem - it has to be unexported before it can be
> unmounted. I suspect that it's the ex_path that is stored in the
> svc_export structure, because stuff like this is done in the
> filehandle code:
>=20
> static bool is_root_export(struct svc_export *exp)
> {
>         return exp->ex_path.dentry =3D=3D exp->ex_path.dentry->d_sb->s_ro=
ot;
> }
>=20
> static struct super_block *exp_sb(struct svc_export *exp)
> {
>         return exp->ex_path.dentry->d_sb;
> }
>=20
> i.e. the file handle code assumes the existence of a pinned path
> that is the root of the exported directory tree. This points to the
> superblock behind the export so that it can do stuff like pull the
> device numbers, check sb->s_type->fs_flags fields (e.g
> FS_REQUIRES_DEV), etc as needed to encode/decode/verify filehandles.
>=20
> Somewhere in the code this path must be pinned to the svc_export for
> the life of the svc_export (svc_export_init()?), and at that point
> the svc_export code could update the struct super_block state
> appropriately....
>=20

No, it doesn't quite work like that. The exports table is loaded on-
demand by nfsd via an upcall to mountd.

If you set up a filesystem to be exported by nfsd, but don't do any nfs
activity against it, you'll still be able to unmount the filesystem
because the export entry won't have been loaded by the kernel yet. Once
a client talks to nfsd and touches the export, the kernel will upcall
and that's when the dentry gets pinned.

This is all _really_ old, crusty code, fwiw.

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
> It's indicated in the documentation:
>=20
> "These are only useful when called in a fast path and one still
> expects better than second accuracy, but can't easily use 'jiffies',
> e.g. for inode timestamps.  Skipping the hardware clock access saves
> around 100 CPU cycles on most modern machines with a reliable cycle
> counter, but up to several microseconds on older hardware with an
> external clocksource."
>=20
> For a modern, high performance machine, 100 CPU cycles for the cycle
> counter read is less costly than a pipeline stall due to a single
> cacheline miss. For older, slower hardware, the transaction overhead
> of a ctime update is already in the order of microseconds, so this
> amount of overhead still isn't a show stopper.
>=20
> As it is, optimising the timestamp read similar to the the iversion
> bump only after it has been queried (i.e. equivalent of
> inode_maybe_inc_iversion()) would remove most of the additional
> overhead for non-NFSd operations. It could be done simply using
> an inode state flag rather than hiding the state bit in the
> i_version value...
>=20
> > You had also mentioned a while back that there was some desire for
> > femtosecond resolution on timestamps. Does that change the calculus her=
e
> > at all? Note that the i_version is not subject to any timestamp
> > granularity issues.
>=20
> [ Reference from 2016 on femptosecond granularity timestamps in
> statx():
>=20
> https://lore.kernel.org/linux-fsdevel/20161117234047.GE28177@dastard/
>=20
> where I ask:
>=20
> "So what happens in ten years time when we want to support
> femptosecond resolution in the timestamp interface?" ]
>=20
> Timestamp granularity changes will require an on-disk format change
> regardless of anything else. We have no plans to do this again in
> the near future - we've just done a revision for >y2038 timestamp
> support in the on disk format, and we'd have to do another to
> support sub-nanosecond timestamp granularity.  Hence we know exactly
> how much time, resources and testing needs to be put into changing
> the on-disk timestamp format.  Given that adding a new i_version
> field is of similar complexity, we don't want to do either if we can
> possibly avoid it.
>=20
> Looking from a slightly higher perspective, in XFS timestamp updates
> are done under exclusive inode locks and so the entire transaction
> will need to be done in sub-nanosecond time before we need to worry
> about timestamp granularity. It's going to be a long, long time into
> the future before that ever happens (if ever!), so I don't think we
> need to change the on-disk timestamp granularity to disambiguate
> individual inode metadata/data changes any time soon.
>=20

Fair enough.

> > If you want nfsd to start using the ctime for i_version with xfs, then
> > you can just turn off the SB_I_IVERSION flag. You will need to do some
> > work though to keep your "special" i_version that also counts atime
> > updates working once you turn that off. You'll probably want to do that
> > anyway though since the semantics for xfs's version counter are
> > different from everyone else's.
>=20
> XFS already uses ->update_time because it is different to other
> filesystems in that pure timestamp updates are always updated
> transactionally rather than just updating the inode in memory. I'm
> not sure there's anything we need to change there right now.
>=20
> Other things would need to change if we don't set SB_I_IVERSION -
> we'd unconditionally bump i_version in xfs_trans_log_inode() rather
> than forcing it through inode_maybe_inc_iversion() because we no
> longer want the VFS or applications to modify i_version.
>=20
> But we do still want to tell external parties that i_version is a
> usable counter that can be used for data and metadata change
> detection, and that stands regardless of the fact that the NFSd
> application doesn't want fine-grained change detection anymore.
> Hence I think whatever gets done needs to be more nuanced than
> "SB_I_VERSION really only means NFSD_CAN_USE_I_VERSION". Perhaps
> a second flag that says "SB_I_VERSION_NFSD_COMPATIBLE" to
> differentiate between the two cases?

With the changes I have queued up for v6.3, responsibility for i_version
queries is moved into the filesystems' getattr routines. The kernel does
still use IS_I_VERSION to indicate that the vfs should attempt to bump
the counter, however. Once that goes in, you should be able to turn off
SB_I_VERSION in xfs, and then we won't try to increment the i_version
anymore in the vfs.

If you want nfsd to just use the ctime for the change attribute at that
point, you won't need to do anything further. If you want to have xfs
provide a new one, you can fill out the change_cookie field in struct
kstat.

>=20
> [ Reflection on terminology: how denigrating does it appear when
> something is called "special" because it is different to others?
> Such terminology would never be allowed if we were talking about
> differences between people. ]
>=20

True, but XFS isn't a person. I wasn't trying to be denigrating here,
just pointing out that XFS has special requirements vs. other
filesystems.

> > If this is what you choose to do for xfs, then the question becomes: wh=
o
> > is going to do that timestamp rework?
>=20
> Depends on what ends up needing to be changed, I'm guessing...
>=20
> > Note that there are two other lingering issues with i_version. Neither
> > of these are xfs-specific, but they may inform the changes you want to
> > make there:
> >=20
> > 1/ the ctime and i_version can roll backward on a crash.
>=20
> Yup, because async transaction engines allow metadata to appear
> changed in memory before it is stable on disk. No difference between
> i_version or ctime here at all.
>=20

There is a little difference. The big danger here is that the i_version
could roll backward after being seen by a client, and then on a
subsequent change, we'd end up with a duplicate i_version that reflects
a different state of the file from what the client has observed.

ctime is probably more resilient here, as to get the same effect you'd
need to crash and roll back, _and_ have the clock roll backward too.

> > 2/ the ctime and i_version are both currently updated before write data
> > is copied to the pagecache. It would be ideal if that were done
> > afterward instead. (FWIW, I have some draft patches for btrfs and ext4
> > for this, but they need a lot more testing.)
>=20
> AFAICT, changing the i_version after the page cache has been written
> to does not fix the visibility and/or crash ordering issue.  The new
> data is published for third party access when the folio the data is
> written into is unlocked, not when the entire write operation
> completes.  Hence we can start writeback on data that is part of a
> write operation before the write operation has completed and updated
> i_version.
>=20
> If we then crash before the write into the page cache completes and
> updates i_version, we can now have changed data on disk without a
> i_version update in the metadata to even recover from the journal.
> Hence with a post-write i_version update, none of the clients will
> see that their caches are stale because i_version/ctime hasn't
> changed despite the data on disk having changed.
>=20
> As such, I don't really see what "update i_version after page cache
> write completion" actually achieves by itself.  Even "update
> i_version before and after write" doesn't entirely close down the
> crash hole in i_version, either - it narrows it down, but it does
> not remove it...
>=20

This issue is not about crash resilience.

The worry we have is that a client could see a change attribute change
and do a read of the data before the writer has copied the data to the
pagecache. If it does that and the i_version doesn't change again, then
the client will be stuck with stale data in its cache.

By bumping the times and/or version after the change, we ensure that
this doesn't happen. The client might briefly associate the wrong data
with a particular change attr, but that situation should be short-lived.
--=20
Jeff Layton <jlayton@kernel.org>
