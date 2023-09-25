Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E5B7AD5A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 12:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjIYKOU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 06:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjIYKOR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:14:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1559E116;
        Mon, 25 Sep 2023 03:14:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909CAC433C8;
        Mon, 25 Sep 2023 10:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695636848;
        bh=7UV6bur4/QbQSym5hYiqkarACmXRkYQqnW4c6Ky8HHk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=N5rsiOvxZ9rtknK+hvXctsMkbyoCnEqMoS8lNpGJUVLJW7353GaQiTDk9W7a4qcIs
         zHyUednk5p/K/8loD6WBphpKUlx//FitRFDl4D1pab37ZLZL7MxK2/UCst9M7569HZ
         kJMCVcxUj6lgKcqFFxWY4Yr0rMMDA8l9geqykI1+cVIXoZvjnXuxB0iBvGk6Rdyr1W
         kGAWEOoL3iiMv58qJHx1uc/Q/eVqlbOwjsHLhPfc3K3egIyaK+hwiRZfLVOcalpGH2
         XT/gDaODgksxsYULm8lpw3YpwETgU7of4BOihV8QtSZC7y+C5zs/lQQPOMM4aiA3Wy
         PbWv8aL7DtQPw==
Message-ID: <77d33282068035a3b42ace946b1be57457d2b60b.camel@kernel.org>
Subject: Re: [PATCH v8 0/5] fs: multigrain timestamps for XFS's change_cookie
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
Date:   Mon, 25 Sep 2023 06:14:05 -0400
In-Reply-To: <ZRC1pjwKRzLiD6I3@dread.disaster.area>
References: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
         <CAOQ4uxiNfPoPiX0AERywqjaBH30MHQPxaZepnKeyEjJgTv8hYg@mail.gmail.com>
         <5e3b8a365160344f1188ff13afb0a26103121f99.camel@kernel.org>
         <CAOQ4uxjrt6ca4VDvPAL7USr6_SspCv0rkRkMJ4_W2S6vzV738g@mail.gmail.com>
         <ZRC1pjwKRzLiD6I3@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-09-25 at 08:18 +1000, Dave Chinner wrote:
> On Sat, Sep 23, 2023 at 05:52:36PM +0300, Amir Goldstein wrote:
> > On Sat, Sep 23, 2023 at 1:46=E2=80=AFPM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >=20
> > > On Sat, 2023-09-23 at 10:15 +0300, Amir Goldstein wrote:
> > > > On Fri, Sep 22, 2023 at 8:15=E2=80=AFPM Jeff Layton <jlayton@kernel=
.org> wrote:
> > > > >=20
> > > > > My initial goal was to implement multigrain timestamps on most ma=
jor
> > > > > filesystems, so we could present them to userland, and use them f=
or
> > > > > NFSv3, etc.
> > > > >=20
> > > > > With the current implementation however, we can't guarantee that =
a file
> > > > > with a coarse grained timestamp modified after one with a fine gr=
ained
> > > > > timestamp will always appear to have a later value. This could co=
nfuse
> > > > > some programs like make, rsync, find, etc. that depend on strict
> > > > > ordering requirements for timestamps.
> > > > >=20
> > > > > The goal of this version is more modest: fix XFS' change attribut=
e.
> > > > > XFS's change attribute is bumped on atime updates in addition to =
other
> > > > > deliberate changes. This makes it unsuitable for export via nfsd.
> > > > >=20
> > > > > Jan Kara suggested keeping this functionality internal-only for n=
ow and
> > > > > plumbing the fine grained timestamps through getattr [1]. This se=
t takes
> > > > > a slightly different approach and has XFS use the fine-grained at=
tr to
> > > > > fake up STATX_CHANGE_COOKIE in its getattr routine itself.
> > > > >=20
> > > > > While we keep fine-grained timestamps in struct inode, when prese=
nting
> > > > > the timestamps via getattr, we truncate them at a granularity of =
number
> > > > > of ns per jiffy,
> > > >=20
> > > > That's not good, because user explicitly set granular mtime would b=
e
> > > > truncated too and booting with different kernels (HZ) would change
> > > > the observed timestamps of files.
> > > >=20
> > >=20
> > > Thinking about this some more, I think the first problem is easily
> > > addressable:
> > >=20
> > > The ctime isn't explicitly settable and with this set, we're already =
not
> > > truncating the atime. We haven't used any of the extra bits in the mt=
ime
> > > yet, so we could just carve out a flag in there that says "this mtime
> > > was explicitly set and shouldn't be truncated before presentation".
> > >=20
> >=20
> > I thought about this option too.
> > But note that the "mtime was explicitly set" flag needs
> > to be persisted to disk so you cannot store it in the high nsec bits.
> > At least XFS won't store those bits if you use them - they have to
> > be translated to an XFS inode flag and I don't know if changing
> > XFS on-disk format was on your wish list.
>=20
> Remember: this multi-grain timestamp thing was an idea to solve the
> NFS change attribute problem without requiring *any* filesystem with
> sub-jiffie timestamp capability to change their on-disk format to
> implement a persistent change attribute that matches the new
> requires of the kernel nfsd.
>=20
> If we now need to change the on-disk format to support
> some whacky new timestamp semantic to do this, then people have
> completely lost sight of what problem the multi-grain timestamp idea
> was supposed to address.
>=20

Yep. The main impetus for all of this was to fix XFS's change attribute
without requiring an on-disk format change. If we have to rev the on-
disk format, we're probably better off plumbing in a proper i_version
counter and tossing this idea aside.

That said, I think all we'd need for this scheme is a single flag per
inode (to indicate that the mtime shouldn't be truncated before
presentation). If that's possible to do without fully revving the inode
format, then we could still pursue this. I take it that's probably not
the case though.
--=20
Jeff Layton <jlayton@kernel.org>
