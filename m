Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FB17AEB80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 13:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjIZLcG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 07:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjIZLcF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:32:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1975DE5;
        Tue, 26 Sep 2023 04:31:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FE5C433C8;
        Tue, 26 Sep 2023 11:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695727918;
        bh=VavTLqfwPyOPHMccoFChylXmFFUo8P7qlBTJ/DhQa2w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QV5akLE8cAQWKD8DSqGm3T3eFEgO4cqRzRheD5AXFFAGZjfZohBsvWfJu1z1/3Z/c
         McIfFKUws9d2IsYbPe2f6eQwitPBCTmUwrW8L+rcqrGDI3l8T0XzHzZtyOCqGWUYl3
         w9yvUNiNJnXyLQBL+qr9frj8ed4Fo9NlUQgF3sXPq3XAK2Q+XvDxjFA7kWCxz02wCB
         M6lgQY/XvGaeVFTzeW0DTG+4CUYuOxJvvfSzYX+8mcxjGhE8Se9B9k/Tli5Xoi/Syt
         4KxlktRKXg6+TLBEF1i51FpePUzCV8uSSX4n0yM25izPFG5e0Dv7apQz2Xy0gfGziV
         T90RTT72Nl3gg==
Message-ID: <54e79ca9adfd52a8d39e158bc246173768a0aa0d.camel@kernel.org>
Subject: Re: [PATCH v8 0/5] fs: multigrain timestamps for XFS's change_cookie
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Date:   Tue, 26 Sep 2023 07:31:55 -0400
In-Reply-To: <ZRIKj0E8P46kerqa@dread.disaster.area>
References: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
         <CAOQ4uxiNfPoPiX0AERywqjaBH30MHQPxaZepnKeyEjJgTv8hYg@mail.gmail.com>
         <5e3b8a365160344f1188ff13afb0a26103121f99.camel@kernel.org>
         <CAOQ4uxjrt6ca4VDvPAL7USr6_SspCv0rkRkMJ4_W2S6vzV738g@mail.gmail.com>
         <ZRC1pjwKRzLiD6I3@dread.disaster.area>
         <77d33282068035a3b42ace946b1be57457d2b60b.camel@kernel.org>
         <ZRIKj0E8P46kerqa@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-09-26 at 08:32 +1000, Dave Chinner wrote:
> On Mon, Sep 25, 2023 at 06:14:05AM -0400, Jeff Layton wrote:
> > On Mon, 2023-09-25 at 08:18 +1000, Dave Chinner wrote:
> > > On Sat, Sep 23, 2023 at 05:52:36PM +0300, Amir Goldstein wrote:
> > > > On Sat, Sep 23, 2023 at 1:46=E2=80=AFPM Jeff Layton <jlayton@kernel=
.org> wrote:
> > > > >=20
> > > > > On Sat, 2023-09-23 at 10:15 +0300, Amir Goldstein wrote:
> > > > > > On Fri, Sep 22, 2023 at 8:15=E2=80=AFPM Jeff Layton <jlayton@ke=
rnel.org> wrote:
> > > > > > >=20
> > > > > > > My initial goal was to implement multigrain timestamps on mos=
t major
> > > > > > > filesystems, so we could present them to userland, and use th=
em for
> > > > > > > NFSv3, etc.
> > > > > > >=20
> > > > > > > With the current implementation however, we can't guarantee t=
hat a file
> > > > > > > with a coarse grained timestamp modified after one with a fin=
e grained
> > > > > > > timestamp will always appear to have a later value. This coul=
d confuse
> > > > > > > some programs like make, rsync, find, etc. that depend on str=
ict
> > > > > > > ordering requirements for timestamps.
> > > > > > >=20
> > > > > > > The goal of this version is more modest: fix XFS' change attr=
ibute.
> > > > > > > XFS's change attribute is bumped on atime updates in addition=
 to other
> > > > > > > deliberate changes. This makes it unsuitable for export via n=
fsd.
> > > > > > >=20
> > > > > > > Jan Kara suggested keeping this functionality internal-only f=
or now and
> > > > > > > plumbing the fine grained timestamps through getattr [1]. Thi=
s set takes
> > > > > > > a slightly different approach and has XFS use the fine-graine=
d attr to
> > > > > > > fake up STATX_CHANGE_COOKIE in its getattr routine itself.
> > > > > > >=20
> > > > > > > While we keep fine-grained timestamps in struct inode, when p=
resenting
> > > > > > > the timestamps via getattr, we truncate them at a granularity=
 of number
> > > > > > > of ns per jiffy,
> > > > > >=20
> > > > > > That's not good, because user explicitly set granular mtime wou=
ld be
> > > > > > truncated too and booting with different kernels (HZ) would cha=
nge
> > > > > > the observed timestamps of files.
> > > > > >=20
> > > > >=20
> > > > > Thinking about this some more, I think the first problem is easil=
y
> > > > > addressable:
> > > > >=20
> > > > > The ctime isn't explicitly settable and with this set, we're alre=
ady not
> > > > > truncating the atime. We haven't used any of the extra bits in th=
e mtime
> > > > > yet, so we could just carve out a flag in there that says "this m=
time
> > > > > was explicitly set and shouldn't be truncated before presentation=
".
> > > > >=20
> > > >=20
> > > > I thought about this option too.
> > > > But note that the "mtime was explicitly set" flag needs
> > > > to be persisted to disk so you cannot store it in the high nsec bit=
s.
> > > > At least XFS won't store those bits if you use them - they have to
> > > > be translated to an XFS inode flag and I don't know if changing
> > > > XFS on-disk format was on your wish list.
> > >=20
> > > Remember: this multi-grain timestamp thing was an idea to solve the
> > > NFS change attribute problem without requiring *any* filesystem with
> > > sub-jiffie timestamp capability to change their on-disk format to
> > > implement a persistent change attribute that matches the new
> > > requires of the kernel nfsd.
> > >=20
> > > If we now need to change the on-disk format to support
> > > some whacky new timestamp semantic to do this, then people have
> > > completely lost sight of what problem the multi-grain timestamp idea
> > > was supposed to address.
> > >=20
> >=20
> > Yep. The main impetus for all of this was to fix XFS's change attribute
> > without requiring an on-disk format change. If we have to rev the on-
> > disk format, we're probably better off plumbing in a proper i_version
> > counter and tossing this idea aside.
> >=20
> > That said, I think all we'd need for this scheme is a single flag per
> > inode (to indicate that the mtime shouldn't be truncated before
> > presentation). If that's possible to do without fully revving the inode
> > format, then we could still pursue this. I take it that's probably not
> > the case though.
>=20
> Older kernels that don't know what the flag means, but that should
> be OK for an inode flag. The bigger issue is that none of the
> userspace tools (xfs_db, xfs_repair, etc) know about it, so they
> would have to be taught about it. And then there's testing it, which
> likely means userspace needs visibility of the flag (e.g. FS_XFLAG
> for it) and then there's more work....
>=20
> It's really not worth it.
>=20
>
> I think that Linus's suggestion of the in-memory inode timestamp
> always being a 64bit, 100ns granularity value instead of a timespec
> that gets truncated at sample time has merit as a general solution.
>=20

Changing how we store timestamps in struct inode is a good idea, and
reducing the effective granularity to 100ns seems reasonable, but that
alone won't fix XFS's i_version counter, or the ordering problems that
we hit with the multigrain series that had to be reverted.

> We also must not lose sight of the fact that the lazytime mount
> option makes atime updates on XFS behave exactly as the nfsd/NFS
> client application wants. That is, XFS will do in-memory atime
> updates unless the atime update also sets S_VERSION to explicitly
> bump the i_version counter if required. That leads to another
> potential nfsd specific solution without requiring filesystems to
> change on disk formats: the nfsd explicitly asks operations for lazy
> atime updates...
>=20

Not exactly. The problem with XFS's i_version is that it also bumps it
on atime updates. lazytime reduces the number of atime updates to
~1/day. To be exactly what nfsd wants, you'd need to make that 0. I
suppose you can work around it with noatime, but that has problems of
its own.

> And we must also keep in sight the fact that io_uring wants
> non-blocking timestamp updates to be possible (for all types of
> updates). Hence it looks to me like we have more than one use case
> for per-operation/application specific timestamp update semantics.
> Perhaps there's a generic solution to this problem (e.g.  operation
> specific non-blocking, in-memory pure timestamp updates) that does
> what everyone needs...

--=20
Jeff Layton <jlayton@kernel.org>
