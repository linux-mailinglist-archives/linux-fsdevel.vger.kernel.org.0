Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75E86DC1DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Apr 2023 00:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjDIWMQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Apr 2023 18:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDIWMP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Apr 2023 18:12:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD57273A;
        Sun,  9 Apr 2023 15:12:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61E6A60C49;
        Sun,  9 Apr 2023 22:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BF3C433EF;
        Sun,  9 Apr 2023 22:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681078331;
        bh=iKKzZ35bTSCsFycUs3feaPq1NWCyx9wZ4gEzz4E9H8A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TLcYbsnWmSWZ+x4GeoFgnM2PSC5M5CRQInLyKR+UEpobnUhRuIU7wzJHAWSaIRbx9
         +Xh8IbKBWArLh13D+1Lm0orYydVqfsbzcmRlCWVtePKJkABDG2nyik15HUbXRbuFV/
         z5Aef0Fbs80wCVZZb4wYJ8aDyju330OdfbZOXftY5/O+RM/UiNHxHP18ida63sv6WG
         Hs4XMOqaRVQ4o6r6wujf3FB8QLmD6O7T7X220WCAfIfFmJCEgxJQnFGoFJrT5YeLA6
         ZxZNXZZa06h2ZQ8MwFoZWU7jfREzOjUT/V++zJmMarHrQHzEmR5POxVWHdz9sV4cIK
         D35ZqnpGWGk2A==
Message-ID: <b2591695afc11a8924a56865c5cd2d59e125413c.camel@kernel.org>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM
 after writes
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Date:   Sun, 09 Apr 2023 18:12:09 -0400
In-Reply-To: <20230409-genick-pelikan-a1c534c2a3c1@brauner>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
         <90a25725b4b3c96e84faefdb827b261901022606.camel@kernel.org>
         <20230409-genick-pelikan-a1c534c2a3c1@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2023-04-09 at 17:22 +0200, Christian Brauner wrote:
> On Fri, Apr 07, 2023 at 09:29:29AM -0400, Jeff Layton wrote:
> > > > > >=20
> > > > > > I would ditch the original proposal in favor of this 2-line pat=
ch shown here:
> > > > > >=20
> > > > > > https://lore.kernel.org/linux-integrity/a95f62ed-8b8a-38e5-e468=
-ecbde3b221af@linux.ibm.com/T/#m3bd047c6e5c8200df1d273c0ad551c645dd43232
> > >=20
> > > We should cool it with the quick hacks to fix things. :)
> > >=20
> >=20
> > Yeah. It might fix this specific testcase, but I think the way it uses
> > the i_version is "gameable" in other situations. Then again, I don't
> > know a lot about IMA in this regard.
> >=20
> > When is it expected to remeasure? If it's only expected to remeasure on
> > a close(), then that's one thing. That would be a weird design though.
> >=20
> > > > > >=20
> > > > > >=20
> > > > >=20
> > > > > Ok, I think I get it. IMA is trying to use the i_version from the
> > > > > overlayfs inode.
> > > > >=20
> > > > > I suspect that the real problem here is that IMA is just doing a =
bare
> > > > > inode_query_iversion. Really, we ought to make IMA call
> > > > > vfs_getattr_nosec (or something like it) to query the getattr rou=
tine in
> > > > > the upper layer. Then overlayfs could just propagate the results =
from
> > > > > the upper layer in its response.
> > > > >=20
> > > > > That sort of design may also eventually help IMA work properly wi=
th more
> > > > > exotic filesystems, like NFS or Ceph.
> > > > >=20
> > > > >=20
> > > > >=20
> > > >=20
> > > > Maybe something like this? It builds for me but I haven't tested it=
. It
> > > > looks like overlayfs already should report the upper layer's i_vers=
ion
> > > > in getattr, though I haven't tested that either:
> > > >=20
> > > > -----------------------8<---------------------------
> > > >=20
> > > > [PATCH] IMA: use vfs_getattr_nosec to get the i_version
> > > >=20
> > > > IMA currently accesses the i_version out of the inode directly when=
 it
> > > > does a measurement. This is fine for most simple filesystems, but c=
an be
> > > > problematic with more complex setups (e.g. overlayfs).
> > > >=20
> > > > Make IMA instead call vfs_getattr_nosec to get this info. This allo=
ws
> > > > the filesystem to determine whether and how to report the i_version=
, and
> > > > should allow IMA to work properly with a broader class of filesyste=
ms in
> > > > the future.
> > > >=20
> > > > Reported-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > >=20
> > > So, I think we want both; we want the ovl_copyattr() and the
> > > vfs_getattr_nosec() change:
> > >=20
> > > (1) overlayfs should copy up the inode version in ovl_copyattr(). Tha=
t
> > >     is in line what we do with all other inode attributes. IOW, the
> > >     overlayfs inode's i_version counter should aim to mirror the
> > >     relevant layer's i_version counter. I wouldn't know why that
> > >     shouldn't be the case. Asking the other way around there doesn't
> > >     seem to be any use for overlayfs inodes to have an i_version that
> > >     isn't just mirroring the relevant layer's i_version.
> >=20
> > It's less than ideal to do this IMO, particularly with an IS_I_VERSION
> > inode.
> >=20
> > You can't just copy=A0up the value from the upper. You'll need to call
> > inode_query_iversion(upper_inode), which will flag the upper inode for =
a
> > logged i_version update on the next write. IOW, this could create some
> > (probably minor) metadata write amplification in the upper layer inode
> > with IS_I_VERSION inodes.
>=20
> I'm likely just missing context and am curious about this so bear with me=
. Why
> do we need to flag the upper inode for a logged i_version update? Any req=
uired
> i_version interactions should've already happened when overlayfs called i=
nto
> the upper layer. So all that's left to do is for overlayfs' to mirror the
> i_version value after the upper operation has returned.

> ovl_copyattr() - which copies the inode attributes - is always called aft=
er the
> operation on the upper inode has finished. So the additional query seems =
odd at
> first glance. But there might well be a good reason for it. In my naive
> approach I would've thought that sm along the lines of:
>
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 923d66d131c1..8b089035b9b3 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -1119,4 +1119,5 @@ void ovl_copyattr(struct inode *inode)
>         inode->i_mtime =3D realinode->i_mtime;
>         inode->i_ctime =3D realinode->i_ctime;
>         i_size_write(inode, i_size_read(realinode));
> +       inode_set_iversion_raw(inode, inode_peek_iversion_raw(realinode))=
;
>  }
>=20
> would've been sufficient.
>=20

Nope, because then you wouldn't get any updates to i_version after that
point.

Note that with an IS_I_VERSION inode we only update the i_version when
there has been a query since the last update. What you're doing above is
circumventing that mechanism. You'll get the i_version at the time of of
the ovl_copyattr, but there won't be any updates of it after that point
because the QUERIED bit won't end up being set on realinode.


> Since overlayfs' does explicitly disallow changes to the upper and lower =
trees
> while overlayfs is mounted it seems intuitive that it should just mirror =
the
> relevant layer's i_version.
>
>
> If we don't do this, then we should probably document that i_version does=
n't
> have a meaning yet for the inodes of stacking filesystems.
>=20

Trying to cache the i_version is counterproductive, IMO, at least with
an IS_I_VERSION inode.

The problem is that a query against the i_version has a side-effect. It
has to (atomically) mark the inode for an update on the next change.

If you try to cache that value, you'll likely end up doing more queries
than you really need to (because you'll need to keep the cache up to
date) and you'll have an i_version that will necessarily lag the one in
the upper layer inode.

The whole point of the change attribute is to get the value as it is at
this very moment so we can check whether there have been changes. A
laggy value is not terribly useful.

Overlayfs should just always call the upper layer's ->getattr to get the
version. I wouldn't even bother copying it up in the first place. Doing
so is just encouraging someone to try use the value in the overlayfs
inode, when they really need to go through ->getattr and get the one
from the upper layer.
>=20
--=20
Jeff Layton <jlayton@kernel.org>
