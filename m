Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D577AED39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 14:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbjIZMvp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 08:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjIZMvn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:51:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1710CC9;
        Tue, 26 Sep 2023 05:51:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DBBC433C8;
        Tue, 26 Sep 2023 12:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695732696;
        bh=mtr85RxHM9mZq8qeFMIqIrowCy2BKd7P4jzfy9XBNC4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mYhkQYXfdjsr9qRIQELl5UhwK3qgolnEz1lsRq7FQkjh0lUduMuajDmbF69gyjKdX
         redRCeebcFRGhX5V2bvpa0mERpEP7hBxjBsaGPASp+gJa5TQtHh0LfcQyCUqa5aqR4
         V0Rc2QK4Fn7+0Bj3lne5NF1WRGVckNv9JpeRcqqD5/RkDe5teYZDcjXjFOwa909TMQ
         lPS1RK7dVyNSrr1YOUzYsikhvP0cgEqAwouwZ/9IljSpedrwE0EKdJvwvH/8AS08Vy
         l8t2aQBPcxQAw+CoEiqZ4XXx+VZYgVuBGHDJ0wIF9/Sww9/YuWbz0GQ10O8uBmwzmG
         0LqPkG895p7MA==
Message-ID: <9fb2dfe83772ef16a93030cdba6bd575c828d0fb.camel@kernel.org>
Subject: Re: [PATCH v8 0/5] fs: multigrain timestamps for XFS's change_cookie
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>, NeilBrown <neilb@suse.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Chuck Lever <chuck.lever@oracle.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Date:   Tue, 26 Sep 2023 08:51:32 -0400
In-Reply-To: <20230926-boiler-coachen-bafb70e9df18@brauner>
References: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
         <20230924-mitfeiern-vorladung-13092c2af585@brauner>
         <169559548777.19404.13247796879745924682@noble.neil.brown.name>
         <20230926-boiler-coachen-bafb70e9df18@brauner>
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

On Tue, 2023-09-26 at 14:18 +0200, Christian Brauner wrote:
> > > If there's no clear users and workloads depending on this other than =
for
> > > the sake of NFS then we shouldn't expose this to userspace. We've tri=
ed
>=20
> >=20
> > Some NFS servers run in userspace, and they would a "clear user" of thi=
s
> > functionality.
>=20
> See my comment above. We did thist mostly for the sake of NFS as there
> was in itself nothing wrong with timestamps that needed urgent fixing.
>=20
> The end result has been that we caused a regression for four other major
> filesystems when they were switched to fine-grained timestamps.
>=20
> So NFS servers in userspace isn't a sufficient argument to just try
> again with a slightly tweaked solution but without a wholesale fix of
> the actual ordering problem. The bar to merge this will naturally be
> higher the second time around.
>=20
> That's orthogonal to improving the general timestamp infrastructure in
> struct inode ofc.

There are multiple proposals in flight here, and they all sort of
dovetail on one another. I'm not proposing we expose any changes to the
timestamps to users in any way, unless we can fix the ordering issues,
and ensure that we can preserve existing behavior re: utimensat().

I think it's possible to do that, but I'm going to table that work for
the moment, and finish up the atime/mtime accessor conversions first.
That makes experimenting with all of this a lot simpler. I think I can
also put together a nicer implementation of multigrain timestamps too,
if we can first convert the current timespec64's in struct inode into a
single 64-bit word.
--=20
Jeff Layton <jlayton@kernel.org>
