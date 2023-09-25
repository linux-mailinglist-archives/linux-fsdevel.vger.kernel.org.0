Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063BD7AD562
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 12:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjIYKJD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 06:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjIYKIs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:08:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B001610D2;
        Mon, 25 Sep 2023 03:08:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DA1C433C7;
        Mon, 25 Sep 2023 10:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695636510;
        bh=kxFWm43ha+iaMtKtdh9+7qL4ORfLUkSkxjSaqF2iXTY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XRMieSHePX0qiMEQ+iiyuoyWKuHG9sbzQvoCJyJCudiqnD7IygDQr6JeqptkMUmwJ
         pidxSPVgZQs78KC0SatMWiRydCaSEXuGgBkNmryFSAf9zuSZ9Wi99ESAGz7a5dC+dj
         u6iYA+jxph+GT/H0GALbdb6IBjsYj/tpGYy46P0O9wT3GXRmA/UbHbjdJe+D7UjAr9
         yizphXtHsVb/WcwZJI47tLy/wm89V/bkx+CodQmkZa8QemVjirDBZsg7BwmOnATro5
         urz+iNfVtp3DtWmOUUfr2ND3Nj1TiJkHEHb2oGSNR/mJptjdFnAiFOMJEMj0Z6zaDJ
         XyjoY5W9VnYxw==
Message-ID: <fca8b636ba66f9a4c3eccb41af7bd95801799292.camel@kernel.org>
Subject: Re: [PATCH v8 0/5] fs: multigrain timestamps for XFS's change_cookie
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Date:   Mon, 25 Sep 2023 06:08:27 -0400
In-Reply-To: <CAOQ4uxjfbq=u3PYi_+ZiiAjub92o0-KeNT__ZRKSmRogLtF75Q@mail.gmail.com>
References: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
         <CAOQ4uxiNfPoPiX0AERywqjaBH30MHQPxaZepnKeyEjJgTv8hYg@mail.gmail.com>
         <4b106847d5202aec0e14fdbbe93b070b7ea97477.camel@kernel.org>
         <CAOQ4uxjfbq=u3PYi_+ZiiAjub92o0-KeNT__ZRKSmRogLtF75Q@mail.gmail.com>
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

On Sat, 2023-09-23 at 17:58 +0300, Amir Goldstein wrote:
> On Sat, Sep 23, 2023 at 1:22=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> >=20
> > On Sat, 2023-09-23 at 10:15 +0300, Amir Goldstein wrote:
> > > On Fri, Sep 22, 2023 at 8:15=E2=80=AFPM Jeff Layton <jlayton@kernel.o=
rg> wrote:
> > > >=20
> > > > My initial goal was to implement multigrain timestamps on most majo=
r
> > > > filesystems, so we could present them to userland, and use them for
> > > > NFSv3, etc.
> > > >=20
> > > > With the current implementation however, we can't guarantee that a =
file
> > > > with a coarse grained timestamp modified after one with a fine grai=
ned
> > > > timestamp will always appear to have a later value. This could conf=
use
> > > > some programs like make, rsync, find, etc. that depend on strict
> > > > ordering requirements for timestamps.
> > > >=20
> > > > The goal of this version is more modest: fix XFS' change attribute.
> > > > XFS's change attribute is bumped on atime updates in addition to ot=
her
> > > > deliberate changes. This makes it unsuitable for export via nfsd.
> > > >=20
> > > > Jan Kara suggested keeping this functionality internal-only for now=
 and
> > > > plumbing the fine grained timestamps through getattr [1]. This set =
takes
> > > > a slightly different approach and has XFS use the fine-grained attr=
 to
> > > > fake up STATX_CHANGE_COOKIE in its getattr routine itself.
> > > >=20
> > > > While we keep fine-grained timestamps in struct inode, when present=
ing
> > > > the timestamps via getattr, we truncate them at a granularity of nu=
mber
> > > > of ns per jiffy,
> > >=20
> > > That's not good, because user explicitly set granular mtime would be
> > > truncated too and booting with different kernels (HZ) would change
> > > the observed timestamps of files.
> > >=20
> >=20
> > That's a very good point.
> >=20
> > > > which allows us to smooth over the fuzz that causes
> > > > ordering problems.
> > > >=20
> > >=20
> > > The reported ordering problems (i.e. cp -u) is not even limited to th=
e
> > > scope of a single fs, right?
> > >=20
> >=20
> > It isn't. Most of the tools we're concerned with don't generally care
> > about filesystem boundaries.
> >=20
> > > Thinking out loud - if the QERIED bit was not per inode timestamp
> > > but instead in a global fs_multigrain_ts variable, then all the inode=
s
> > > of all the mgtime fs would be using globally ordered timestamps
> > >=20
> > > That should eliminate the reported issues with time reorder for
> > > fine vs coarse grained timestamps.
> > >=20
> > > The risk of extra unneeded "change cookie" updates compared to
> > > per inode QUERIED bit may exist, but I think it is a rather small ove=
rhead
> > > and maybe worth the tradeoff of having to maintain a real per inode
> > > "change cookie" in addition to a "globally ordered mgtime"?
> > >=20
> > > If this idea is acceptable, you may still be able to salvage the reve=
rted
> > > ctime series for 6.7, because the change to use global mgtime should
> > > be quite trivial?
> > >=20
> >=20
> > This is basically the idea I was going to look at next once I got some
> > other stuff settled here: Basically, when we apply a fine-grained
> > timestamp to an inode, we'd advance the coarse-grained clock that
> > filesystems use to that value.
> >=20
> > It could cause some write amplification: if you are streaming writes to
> > a bunch of files at the same time and someone stats one of them, then
> > they'd all end up getting an extra inode transaction. That doesn't soun=
d
> > _too_ bad on its face, but I probably need to implement it and then run
> > some numbers to see.
> >=20
>=20
> Several journal transactions within a single jiffie tick?
> If ctime/change_cookie of an inode is updated once within the scope
> of a single running transaction, I don't think it matters how many
> times it would be updated, but maybe I am missing something.
>=20
> The problem is probably going to be that the seqlock of the coarse
> grained clock is going to be invalidated way too frequently to be
> "read mostly" in the presence of ls -lR workload, but again, I did
> not study the implementation, so I may be way off.
>=20

That may end up being the case, but I think if we can minimize the
number of fine-grained updates, then the number of invalidations will be
minimal too. I haven't rolled an implementation of this yet. This is all
very much still in the "waving of hands" stage anyway.

Once the dust settles from the atime and mtime API rework, I may still
take a stab at doing this.
--=20
Jeff Layton <jlayton@kernel.org>
