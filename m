Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283B667B1DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 12:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbjAYLrR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 06:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjAYLrQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:47:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A4E7D8F;
        Wed, 25 Jan 2023 03:47:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6EC0614D6;
        Wed, 25 Jan 2023 11:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE671C433EF;
        Wed, 25 Jan 2023 11:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674647234;
        bh=oFn5r5R1GTY8odJaPAy4DaeYsTt2HlMENdTKOS7Hk94=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FXZNipPmz9o5WyiAyGy5A/zgHJdE+AJ2j7fdTZcna9Vkvf1zMWnu/Gh1fquZhYar1
         v2U5RV4a+HMqNedcJZaCAHnlfm7JgbVUqC7J3rFGfWipdOnr5YaqJaDcp+uztabYxo
         VvuUdORFaK7lgIw+J1GuiETwL6F7DoCCvyYOHjxM4u0Hy8AkAKV6KAWNLz7XVrtNpD
         CzY+Y5SD9XsYMz3LtfSy4JxBQMsdI7j/G3jPT10/1C+wTPunMy7Y5MCOLtDaJ/QQST
         qegtNccMCA1Ey00f05EtgG9MKwzs8rc9Vp/0L/C/3BZXiOhTxy72a0bxNINu51YwZX
         qdb9XuWm0feqg==
Message-ID: <86f993a69a5be276164c4d3fc1951ff4bde881be.camel@kernel.org>
Subject: Re: replacement i_version counter for xfs
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Wed, 25 Jan 2023 06:47:12 -0500
In-Reply-To: <20230125000227.GM360264@dread.disaster.area>
References: <57c413ed362c0beab06b5d83b7fc4b930c7662c4.camel@kernel.org>
         <20230125000227.GM360264@dread.disaster.area>
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

On Wed, 2023-01-25 at 11:02 +1100, Dave Chinner wrote:
> On Tue, Jan 24, 2023 at 07:56:09AM -0500, Jeff Layton wrote:
> > A few months ago, I posted a patch to make xfs not bump its i_version
> > counter on atime updates. Dave Chinner NAK'ed that patch, mentioning
> > that xfs would need to replace it with an entirely new field as the
> > existing counter is used for other purposes and its semantics are set i=
n
> > stone.
> >=20
> > Has anything been done toward that end?
>=20
> No, because we don't have official specification of the behaviour
> the nfsd subsystem requires merged into the kernel yet.
>=20

Ok. Hopefully that will be addressed in v6.3.

> > Should I file a bug report or something?
>=20
> There's nothing we can really do until the new specification is set
> in stone. Filing a bug report won't change anything material.
>=20
> As it is, I'm guessing that you desire the behaviour to be as you
> described in the iversion patchset you just posted. That is
> effectively:
>=20
>   * The change attribute (i_version) is mandated by NFSv4 and is mostly f=
or
>   * knfsd, but is also used for other purposes (e.g. IMA). The i_version =
must
> - * appear different to observers if there was a change to the inode's da=
ta or
> - * metadata since it was last queried.
> + * appear larger to observers if there was an explicit change to the ino=
de's
> + * data or metadata since it was last queried.
>=20
> i.e. the definition is changing from *any* metadata or data change
> to *explicit* metadata/data changes, right? i.e. it should only
> change when ctime changes?
>=20

Yes.

> IIUC the rest of the justification for i_version is that ctime might
> lack the timestamp granularity to disambiguate sub-timestamp
> granularity changes, so i_version is needed to bridge that gap.
>=20
> Given that XFS has nanosecond timestamp resolution in the on-disk
> format, both i_version and ctime changes are journalled, and
> ctime/i_version will always change at exactly the same time in the
> same transactions, there are no inherent sub-timestamp granularity
> problems with ctime within XFS. Any deficiency in ctime resolution
> comes solely from the granularity of the VFS inode timestamp
> functions.
>=20
> And so if current_time() was to provide fine-grained nanosecond
> timestamp resolution for exported XFS filesystems (i.e. use
> ktime_get_real_ts64() conditionally), then it seems to me that the
> nfsd i_version function becomes completely redundant.
>=20
> i.e. we are pretty much guaranteed that ctime on exported
> filesystems will always be different for explicit modifications to
> the same inode, and hence we can just use ctime as the version
> change identifier without needing any on-disk format changes at all.
>=20
> And we can optimise away that overhead when the filesystem is not
> exported by just using the coarse timestamps because there is no
> need for sub-timer-tick disambiguation of single file
> modifications....
>=20

Ok, so conditional on (maybe) a per fstype flag, and whether the
filesystem is exported?

It's not trivial to tell whether something is exported though. We
typically only do that sort of checking within nfsd. That involves an
upcall into mountd, at a minimum.

I don't think you want to be plumbing calls to exportfs into xfs for
this. It may be simpler to just add a new on-disk counter and be done
with it.


> Hence it appears to me that with the new i_version specification
> that there's an avenue out of this problem entirely that is "nfsd
> needs to use ctime, not i_version". This solution seems generic
> enough that filesystems with existing on-disk nanosecond timestamp
> granularity would no longer need explicit on-disk support for the
> nfsd i_version functionality, yes?
>=20

Pretty much.

My understanding has always been that it's not the on-disk format that's
the limiting factor, but the resolution of in-kernel timestamp sources.
If ktime_get_real_ts64 has real ns granularity, then that should be
sufficient (at least for the moment). I'm unclear on the performance
implications with such a change though.

You had also mentioned a while back that there was some desire for
femtosecond resolution on timestamps. Does that change the calculus here
at all? Note that the i_version is not subject to any timestamp
granularity issues.

If you want nfsd to start using the ctime for i_version with xfs, then
you can just turn off the SB_I_IVERSION flag. You will need to do some
work though to keep your "special" i_version that also counts atime
updates working once you turn that off. You'll probably want to do that
anyway though since the semantics for xfs's version counter are
different from everyone else's.

If this is what you choose to do for xfs, then the question becomes: who
is going to do that timestamp rework?

Note that there are two other lingering issues with i_version. Neither
of these are xfs-specific, but they may inform the changes you want to
make there:

1/ the ctime and i_version can roll backward on a crash.

2/ the ctime and i_version are both currently updated before write data
is copied to the pagecache. It would be ideal if that were done
afterward instead. (FWIW, I have some draft patches for btrfs and ext4
for this, but they need a lot more testing.)

--=20
Jeff Layton <jlayton@kernel.org>
