Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6F75BCCB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 15:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiISNNL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 09:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiISNNJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:13:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0833818B07;
        Mon, 19 Sep 2022 06:13:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3E6ECCE10C5;
        Mon, 19 Sep 2022 13:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5C3C433D6;
        Mon, 19 Sep 2022 13:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663593184;
        bh=zdqdu0iqK3lpkefJfnopHzwRQytsQHl1o57nfALcMmg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lF6uMc92oOq+K1gl/oWQybTPzfvNPS8M3b6CFkhXxto4SGv3tGZgj1tqQqFCZ5QQz
         vOPPOdhl2tWMEHLGAezmh7/B/T+MtC8ky2uy9qdZ1o2DsTHPSeKp51RZ2XJ/YSByx0
         fE3wYAvToilWekqsphVAbWHB5lahMYGkxP8o6C3Scpvr8lvsrFyycjm4x5G3YGE8Mx
         IW6gR/A3YgbHSXV7vF6gqi0+EON1NM43LNG6Vml7g0vImEcDryVfDQPALTao/cSL0m
         jBg7H42N5OzaCH/PNPtkLh7FqEuPCJNCKNcFsg5MKI12RsGgNvJCY3pOewTf4/2byu
         NRLIvHDObfSKg==
Message-ID: <87fb43b117472c0a4c688c37a925ac51738c8826.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Date:   Mon, 19 Sep 2022 09:13:00 -0400
In-Reply-To: <20220918235344.GH3600936@dread.disaster.area>
References: <577b6d8a7243aeee37eaa4bbb00c90799586bc48.camel@hammerspace.com>
         <1a968b8e87f054e360877c9ab8cdfc4cfdfc8740.camel@kernel.org>
         <0646410b6d2a5d19d3315f339b2928dfa9f2d922.camel@hammerspace.com>
         <34e91540c92ad6980256f6b44115cf993695d5e1.camel@kernel.org>
         <871f9c5153ddfe760854ca31ee36b84655959b83.camel@hammerspace.com>
         <e8922bc821a40f5a3f0a1301583288ed19b6891b.camel@kernel.org>
         <166328063547.15759.12797959071252871549@noble.neil.brown.name>
         <YyQdmLpiAMvl5EkU@mit.edu>
         <7027d1c2923053fe763e9218d10ce8634b56e81d.camel@kernel.org>
         <24005713ad25370d64ab5bd0db0b2e4fcb902c1c.camel@kernel.org>
         <20220918235344.GH3600936@dread.disaster.area>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-09-19 at 09:53 +1000, Dave Chinner wrote:
> On Fri, Sep 16, 2022 at 11:11:34AM -0400, Jeff Layton wrote:
> > On Fri, 2022-09-16 at 07:36 -0400, Jeff Layton wrote:
> > > On Fri, 2022-09-16 at 02:54 -0400, Theodore Ts'o wrote:
> > > > On Fri, Sep 16, 2022 at 08:23:55AM +1000, NeilBrown wrote:
> > > > > > > If the answer is that 'all values change', then why store the=
 crash
> > > > > > > counter in the inode at all? Why not just add it as an offset=
 when
> > > > > > > you're generating the user-visible change attribute?
> > > > > > >=20
> > > > > > > i.e. statx.change_attr =3D inode->i_version + (crash counter =
* offset)
> > > >=20
> > > > I had suggested just hashing the crash counter with the file system=
's
> > > > on-disk i_version number, which is essentially what you are suggest=
ed.
> > > >=20
> > > > > > Yes, if we plan to ensure that all the change attrs change afte=
r a
> > > > > > crash, we can do that.
> > > > > >=20
> > > > > > So what would make sense for an offset? Maybe 2**12? One would =
hope that
> > > > > > there wouldn't be more than 4k increments before one of them ma=
de it to
> > > > > > disk. OTOH, maybe that can happen with teeny-tiny writes.
> > > > >=20
> > > > > Leave it up the to filesystem to decide.  The VFS and/or NFSD sho=
uld
> > > > > have not have part in calculating the i_version.  It should be en=
tirely
> > > > > in the filesystem - though support code could be provided if comm=
on
> > > > > patterns exist across filesystems.
> > > >=20
> > > > Oh, *heck* no.  This parameter is for the NFS implementation to
> > > > decide, because it's NFS's caching algorithms which are at stake he=
re.
> > > >=20
> > > > As a the file system maintainer, I had offered to make an on-disk
> > > > "crash counter" which would get updated when the journal had gotten
> > > > replayed, in addition to the on-disk i_version number.  This will b=
e
> > > > available for the Linux implementation of NFSD to use, but that's u=
p
> > > > to *you* to decide how you want to use them.
> > > >=20
> > > > I was perfectly happy with hashing the crash counter and the i_vers=
ion
> > > > because I had assumed that not *that* much stuff was going to be
> > > > cached, and so invalidating all of the caches in the unusual case
> > > > where there was a crash was acceptable.  After all it's a !@#?!@
> > > > cache.  Caches sometimmes get invalidated.  "That is the order of
> > > > things." (as Ramata'Klan once said in "Rocks and Shoals")
> > > >=20
> > > > But if people expect that multiple TB's of data is going to be stor=
ed;
> > > > that cache invalidation is unacceptable; and that a itsy-weeny chan=
ce
> > > > of false negative failures which might cause data corruption might =
be
> > > > acceptable tradeoff, hey, that's for the system which is providing
> > > > caching semantics to determine.
> > > >=20
> > > > PLEASE don't put this tradeoff on the file system authors; I would
> > > > much prefer to leave this tradeoff in the hands of the system which=
 is
> > > > trying to do the caching.
> > > >=20
> > >=20
> > > Yeah, if we were designing this from scratch, I might agree with leav=
ing
> > > more up to the filesystem, but the existing users all have pretty muc=
h
> > > the same needs. I'm going to plan to try to keep most of this in the
> > > common infrastructure defined in iversion.h.
> > >=20
> > > Ted, for the ext4 crash counter, what wordsize were you thinking? I
> > > doubt we'll be able to use much more than 32 bits so a larger integer=
 is
> > > probably not worthwhile. There are several holes in struct super_bloc=
k
> > > (at least on x86_64), so adding this field to the generic structure
> > > needn't grow it.
> >=20
> > That said, now that I've taken a swipe at implementing this, I need mor=
e
> > information than just the crash counter. We need to multiply the crash
> > counter with a reasonable estimate of the maximum number of individual
> > writes that could occur between an i_version being incremented and that
> > value making it to the backing store.
> >=20
> > IOW, given a write that bumps the i_version to X, how many more write
> > calls could race in before X makes it to the platter? I took a SWAG and
> > said 4k in an earlier email, but I don't really have a way to know, and
> > that could vary wildly with different filesystems and storage.
> >=20
> > What I'd like to see is this in struct super_block:
> >=20
> > 	u32		s_version_offset;
>=20
> 	u64		s_version_salt;
>=20

IDK...it _is_ an offset since we're folding it in with addition, and it
has a real meaning. Filesystems do need to be cognizant of that fact, I
think.

Also does anyone have a preference on doing this vs. a get_version_salt
or get_version_offset sb operation? I figured the value should be mostly
static so it'd be nice to avoid an operation for it.

> > ...and then individual filesystems can calculate:
> >=20
> > 	crash_counter * max_number_of_writes
> >=20
> > and put the correct value in there at mount time.
>=20
> Other filesystems might not have a crash counter but have other
> information that can be substituted, like a mount counter or a
> global change sequence number that is guaranteed to increment from
> one mount to the next.=20
>=20

The problem there is that you're going to cause the invalidation of all
of the NFS client's cached regular files, even on clean server reboots.
That's not a desirable outcome.

> Further, have you thought about what "max number of writes" might
> be in ten years time? e.g.  what happens if a filesysetm as "max
> number of writes" being greater than 2^32? I mean, we already have
> machines out there running Linux with 64-128TB of physical RAM, so
> it's already practical to hold > 2^32 individual writes to a single
> inode that each bump i_version in memory....

> So when we consider this sort of scale, the "crash counter * max
> writes" scheme largely falls apart because "max writes" is a really
> large number to begin with. We're going to be stuck with whatever
> algorithm is decided on for the foreseeable future, so we must
> recognise that _we've already overrun 32 bit counter schemes_ in
> terms of tracking "i_version changes in memory vs what we have on
> disk".
>=20
> Hence I really think that we should be leaving the implementation of
> the salt value to the individual filesysetms as different
> filesytsems are aimed at different use cases and so may not
> necessarily have to all care about the same things (like 2^32 bit
> max write overruns).  All the high level VFS code then needs to do
> is add the two together:
>=20
> 	statx.change_attr =3D inode->i_version + sb->s_version_salt;
>=20

Yeah, I have thought about that. I was really hoping that file systems
wouldn't leave so many ephemeral changes lying around before logging
something. It's actually not as bad as it sounds. You'd need that number
of inode changes in memory + queries of i_version, alternating. When
there are no queries, nothing changes. But, the number of queries is
hard to gauge too as it's very dependent on workload, hardware, etc.

If the sky really is the limit on unlogged inode changes, then what do
you suggest? One idea:

We could try to kick off a write_inode in the background when the
i_version gets halfway to the limit. Eventually the nfs server could
just return NFS4ERR_DELAY on a GETATTR if it looked like the reported
version was going to cross the threshold. It'd be ugly, but hopefully
wouldn't happen much if things are tuned well.

Tracking that info might be expensive though. We'd need at least another
u64 field in struct inode for the latest on-disk version. Maybe we can
keep that in the fs-specific part of the inode somehow so we don't need
to grow generic struct inode?
--=20
Jeff Layton <jlayton@kernel.org>
