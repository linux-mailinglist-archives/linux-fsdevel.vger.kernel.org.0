Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD9B7B01CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 12:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjI0K0i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 06:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjI0K0g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:26:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADB510E;
        Wed, 27 Sep 2023 03:26:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456BDC433CC;
        Wed, 27 Sep 2023 10:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695810394;
        bh=qRxlBSqDzr7yeWwJNC65BN+ZowrBPiHgdaWqhPek5Zs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GK9pIsMJBCVbcnQvYIdzYN7DIOo7huUoxLXsdxBkvLgYcoVkBveaC6AxF0Y3B3Q9m
         MHrYMMhuIgJKFEb/00jk/U2kwHxT6d+kbNgxL79K8nLLA+CA8qh5WKoL925itv+6Db
         SoYvNPCzuSBZlosnCDC0vDjMimRo1kov6h8Na7eyy/c3Y5Fi4b9SjQlErp0weDgYh2
         JsUnowhXCjeBGVirSbINOY9WypjehZNp9UvmUN3FVnsVT1dZAOb0344f0+JcHjARgN
         O7D4FiHSciPCbj1yrnto/pxqerWZ9SFtkeJ3J6N+Mu+vYH1ExMQPZxbI6rpuDvEHL6
         VafB6sAcT2pQA==
Message-ID: <0f0c9bd9436d8ccf57365a0627b6905e1fa199e1.camel@kernel.org>
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
Date:   Wed, 27 Sep 2023 06:26:31 -0400
In-Reply-To: <ZRNqSvHwkmQoynOc@dread.disaster.area>
References: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
         <CAOQ4uxiNfPoPiX0AERywqjaBH30MHQPxaZepnKeyEjJgTv8hYg@mail.gmail.com>
         <5e3b8a365160344f1188ff13afb0a26103121f99.camel@kernel.org>
         <CAOQ4uxjrt6ca4VDvPAL7USr6_SspCv0rkRkMJ4_W2S6vzV738g@mail.gmail.com>
         <ZRC1pjwKRzLiD6I3@dread.disaster.area>
         <77d33282068035a3b42ace946b1be57457d2b60b.camel@kernel.org>
         <ZRIKj0E8P46kerqa@dread.disaster.area>
         <54e79ca9adfd52a8d39e158bc246173768a0aa0d.camel@kernel.org>
         <ZRNqSvHwkmQoynOc@dread.disaster.area>
Content-Type: text/plain; charset="ISO-8859-15"
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

On Wed, 2023-09-27 at 09:33 +1000, Dave Chinner wrote:
> On Tue, Sep 26, 2023 at 07:31:55AM -0400, Jeff Layton wrote:
> > On Tue, 2023-09-26 at 08:32 +1000, Dave Chinner wrote:
> > > We also must not lose sight of the fact that the lazytime mount
> > > option makes atime updates on XFS behave exactly as the nfsd/NFS
> > > client application wants. That is, XFS will do in-memory atime
> > > updates unless the atime update also sets S_VERSION to explicitly
> > > bump the i_version counter if required. That leads to another
> > > potential nfsd specific solution without requiring filesystems to
> > > change on disk formats: the nfsd explicitly asks operations for lazy
> > > atime updates...
> > >=20
> >=20
> > Not exactly. The problem with XFS's i_version is that it also bumps it
> > on atime updates. lazytime reduces the number of atime updates to
> > ~1/day. To be exactly what nfsd wants, you'd need to make that 0.
>=20
> As long as there are future modifications going to those files,
> lazytime completely elides the visibility of atime updates as they
> get silently aggregated into future modifications and so there are
> 0 i_version changes as a resutl of pure atime updates in those cases.
>=20
> If there are no future modifications, then just like relatime, there
> is a timestamp update every 24hrs. That's no big deal, nobody is
> complaining about this being a problem.
>=20

Right. The main issue here is that (with relatime) we'll still end up
with a cache invalidation once every 24 hours for any r/o files that
have been accessed. It's not a _huge_ problem on most workloads; it's
just not ideal.

> It's the "persistent atime update after modification" heuristic
> implemented by relatime that is causing all the problems here. If
> that behaviour is elided on the server side, then most of the client
> side invalidation problems with these workloads go away.
>=20
> IOWs, nfsd needs direct control over how atime updates should be
> treated by the VFS/filesystem (i.e. as pure in-memory updates)
> rather than leaving it to some heuristic that may do the exact
> opposite of what the nfsd application needs.
>
> That's the point I was making: we have emerging requirements for
> per-operation timestamp update behaviour control with io_uring and
> other non-blocking applications. The nfsd application also has
> specific semantics it wants the VFS/filesystem to implement
> (non-persistent atime unless something else changes)....
>=20
> My point is that we've now failed a couple of times now to implement
> what NFSD requires via trying to change VFS and/or filesystem
> infrastructure to provide i_version or ctime semantics the nfsd
> requires. That's a fairly good sign that we might not be approaching
> this problem from the right direction, and so doubling down and
> considering changing the timestamp infrastructure from the ground up
> just to solve a relatively niche, filesystem specific issue doesn't
> seem like the best approach.
>=20
> OTOH, having the application actually tell the timestamp updates
> exactly what semantics it needs (non blocking, persistent vs in
> memory, etc) will allow the VFS and filesystems can do the right
> thing for the application without having to worry about general
> heuristics that sometimes do exactly the wrong thing....
>=20

I'm a little unclear on exactly what you're proposing here, but I think
that's overstating what's needed. nfsd's needs are pretty simple: it
wants a change attribute that changes any time the ctime would change.

btrfs, ext4 and tmpfs have this. xfs does not because its change
attribute changes when the atime changes as well. With the right mount
options, that problem can be mitigated to some degree, but it's still
not ideal.

We have a couple of options: try to make the ctime behave the way we
need, or just implement a proper change attribute in xfs (which involves
revving the on-disk format).
--=20
Jeff Layton <jlayton@kernel.org>
