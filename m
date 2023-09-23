Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5427AC06B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Sep 2023 12:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjIWKXE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Sep 2023 06:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjIWKXD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Sep 2023 06:23:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816849E;
        Sat, 23 Sep 2023 03:22:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D74AC433C8;
        Sat, 23 Sep 2023 10:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695464576;
        bh=3v19yAZ2HhM+OXJVje2cfaZSmXd2NDrwoIrXd/QY1q4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=F6phXQHDr6CMA3hk3upNihCkyDQ/7Op0BuqKEq3zxriC5oyCn1miExZpRcyqp2Aj4
         jI8MGE2LeoA3LMM42AuVaKAqF6zBO0xx1EI6iYwu8QGjYBabMCqhEtjOgbNvr0eAtW
         Qac3FDAZqfvSfvUgcJO0i+dZxgkcy/wD6cDfGle6I1O+VEIXd7VM6+Iv5S94RKksFL
         Youj5QH5bj7PZOhvLwaoJgAsWzi0ys9ie2eDeZ3QCvHdUw28KC83yBI9MwV2g3aSD2
         zELaNPivLbtgjPmrXEnPe2K2sumK6yAWXQSlldoDWvrDNlkvgw+ThfjnBlEavtS2o1
         02g+rVw63PinQ==
Message-ID: <4b106847d5202aec0e14fdbbe93b070b7ea97477.camel@kernel.org>
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
Date:   Sat, 23 Sep 2023 06:22:54 -0400
In-Reply-To: <CAOQ4uxiNfPoPiX0AERywqjaBH30MHQPxaZepnKeyEjJgTv8hYg@mail.gmail.com>
References: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
         <CAOQ4uxiNfPoPiX0AERywqjaBH30MHQPxaZepnKeyEjJgTv8hYg@mail.gmail.com>
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

On Sat, 2023-09-23 at 10:15 +0300, Amir Goldstein wrote:
> On Fri, Sep 22, 2023 at 8:15=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> >=20
> > My initial goal was to implement multigrain timestamps on most major
> > filesystems, so we could present them to userland, and use them for
> > NFSv3, etc.
> >=20
> > With the current implementation however, we can't guarantee that a file
> > with a coarse grained timestamp modified after one with a fine grained
> > timestamp will always appear to have a later value. This could confuse
> > some programs like make, rsync, find, etc. that depend on strict
> > ordering requirements for timestamps.
> >=20
> > The goal of this version is more modest: fix XFS' change attribute.
> > XFS's change attribute is bumped on atime updates in addition to other
> > deliberate changes. This makes it unsuitable for export via nfsd.
> >=20
> > Jan Kara suggested keeping this functionality internal-only for now and
> > plumbing the fine grained timestamps through getattr [1]. This set take=
s
> > a slightly different approach and has XFS use the fine-grained attr to
> > fake up STATX_CHANGE_COOKIE in its getattr routine itself.
> >=20
> > While we keep fine-grained timestamps in struct inode, when presenting
> > the timestamps via getattr, we truncate them at a granularity of number
> > of ns per jiffy,
>=20
> That's not good, because user explicitly set granular mtime would be
> truncated too and booting with different kernels (HZ) would change
> the observed timestamps of files.
>=20

That's a very good point.

> > which allows us to smooth over the fuzz that causes
> > ordering problems.
> >=20
>=20
> The reported ordering problems (i.e. cp -u) is not even limited to the
> scope of a single fs, right?
>=20

It isn't. Most of the tools we're concerned with don't generally care
about filesystem boundaries.

> Thinking out loud - if the QERIED bit was not per inode timestamp
> but instead in a global fs_multigrain_ts variable, then all the inodes
> of all the mgtime fs would be using globally ordered timestamps
>
> That should eliminate the reported issues with time reorder for
> fine vs coarse grained timestamps.
>=20
> The risk of extra unneeded "change cookie" updates compared to
> per inode QUERIED bit may exist, but I think it is a rather small overhea=
d
> and maybe worth the tradeoff of having to maintain a real per inode
> "change cookie" in addition to a "globally ordered mgtime"?
>=20
> If this idea is acceptable, you may still be able to salvage the reverted
> ctime series for 6.7, because the change to use global mgtime should
> be quite trivial?
>=20

This is basically the idea I was going to look at next once I got some
other stuff settled here: Basically, when we apply a fine-grained
timestamp to an inode, we'd advance the coarse-grained clock that
filesystems use to that value.

It could cause some write amplification: if you are streaming writes to
a bunch of files at the same time and someone stats one of them, then
they'd all end up getting an extra inode transaction. That doesn't sound
_too_ bad on its face, but I probably need to implement it and then run
some numbers to see.

--=20
Jeff Layton <jlayton@kernel.org>
