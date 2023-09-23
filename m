Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1EF7AC0CA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Sep 2023 12:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjIWKqu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Sep 2023 06:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjIWKqs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Sep 2023 06:46:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078A6194;
        Sat, 23 Sep 2023 03:46:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12512C433C7;
        Sat, 23 Sep 2023 10:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695466002;
        bh=Fgx42TGJn4SqLTc7ScZeuLRx1lxOlKBCJxp1VQ2ncDI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=n8wR7GtcQlt+Y6uw/B6vII1a/XDIbqd0UdQTMcjBUz2g0/VsKjSwI8inZLq+sX8Js
         ULXksUYHaRuq9sM6QZPqSeyfnv0+rUOLLpb3XQKnjBMkWnvk4waz4wbOzT3zAXsVM6
         EpduFXU6dZSt62GUp0tVVT0Q6bNAwKte47YP3GE+uRNnbkovxlOv4VhAPaUGLhlguS
         EZRee95FVgikS3rPUEhLMdHe8BOnKlzpRssERL4H9tWHU26Xr4cvy0hjbGQx1rmsFJ
         K6rLlE4tGLEMaoshPe4L/ksS9Qpa6YtO2ji7zAGAC7LoVMMHIHcPyb+gMN/+Qn87oS
         HVwwCUdISOQAw==
Message-ID: <5e3b8a365160344f1188ff13afb0a26103121f99.camel@kernel.org>
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
Date:   Sat, 23 Sep 2023 06:46:39 -0400
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

Thinking about this some more, I think the first problem is easily
addressable:

The ctime isn't explicitly settable and with this set, we're already not
truncating the atime. We haven't used any of the extra bits in the mtime
yet, so we could just carve out a flag in there that says "this mtime
was explicitly set and shouldn't be truncated before presentation".

The second problem (booting to older kernel) is a bit tougher to deal
with however. I'll have to think about that one a bit more.
--=20
Jeff Layton <jlayton@kernel.org>
