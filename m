Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE446DD6B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 11:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjDKJcS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 05:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjDKJcQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:32:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7A126AB;
        Tue, 11 Apr 2023 02:32:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8774862341;
        Tue, 11 Apr 2023 09:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3184C4339C;
        Tue, 11 Apr 2023 09:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681205533;
        bh=q0ZTXmT4VfDvhWXXY60IXbSIe33IYr0NpEYnP6exzrk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=p0QNsfAJNOe7++bf3ZN4j0c0u9XyyGox9QS0blCxhkN9s/LSAk96y8hXStyhWIB0v
         jis9vzKmUsmLhkX2xbem+QcJVUaL0nWrr8O1HvZCrEbwgolBTYhLAPfwjbCZ0qWR5S
         tHkw6WFE7cEb4oX6F7uDFCBXDsNnKyz5GergwiTPll21VU1L4PUsdm1llA0VNO5nGU
         ErC5P/dVndFMg6YX9Jb68Z0ADPe8LL0rNnuREsabPNBWOBrOnSDmkLHJ+SexdAM4sj
         SD+pCixTDvjrLhHWUZ5bvGq0CmMHMPapQZkYMO7i7RTccmHN69hPmAZEEwVIR2h/yN
         saZvBbte7aTYg==
Message-ID: <8f5cc243398d5bae731a26e674bdeff465da3968.camel@kernel.org>
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
Date:   Tue, 11 Apr 2023 05:32:11 -0400
In-Reply-To: <20230411-umgewandelt-gastgewerbe-870e4170781c@brauner>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
         <90a25725b4b3c96e84faefdb827b261901022606.camel@kernel.org>
         <20230409-genick-pelikan-a1c534c2a3c1@brauner>
         <b2591695afc11a8924a56865c5cd2d59e125413c.camel@kernel.org>
         <20230411-umgewandelt-gastgewerbe-870e4170781c@brauner>
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

On Tue, 2023-04-11 at 10:38 +0200, Christian Brauner wrote:
> On Sun, Apr 09, 2023 at 06:12:09PM -0400, Jeff Layton wrote:
> > On Sun, 2023-04-09 at 17:22 +0200, Christian Brauner wrote:
> > > On Fri, Apr 07, 2023 at 09:29:29AM -0400, Jeff Layton wrote:
> > > > > > > >=20
> > > > > > > > I would ditch the original proposal in favor of this 2-line=
 patch shown here:
> > > > > > > >=20
> > > > > > > > https://lore.kernel.org/linux-integrity/a95f62ed-8b8a-38e5-=
e468-ecbde3b221af@linux.ibm.com/T/#m3bd047c6e5c8200df1d273c0ad551c645dd4323=
2
> > > > >=20
> > > > > We should cool it with the quick hacks to fix things. :)
> > > > >=20
> > > >=20
> > > > Yeah. It might fix this specific testcase, but I think the way it u=
ses
> > > > the i_version is "gameable" in other situations. Then again, I don'=
t
> > > > know a lot about IMA in this regard.
> > > >=20
> > > > When is it expected to remeasure? If it's only expected to remeasur=
e on
> > > > a close(), then that's one thing. That would be a weird design thou=
gh.
> > > >=20
> > > > > > > >=20
> > > > > > > >=20
> > > > > > >=20
> > > > > > > Ok, I think I get it. IMA is trying to use the i_version from=
 the
> > > > > > > overlayfs inode.
> > > > > > >=20
> > > > > > > I suspect that the real problem here is that IMA is just doin=
g a bare
> > > > > > > inode_query_iversion. Really, we ought to make IMA call
> > > > > > > vfs_getattr_nosec (or something like it) to query the getattr=
 routine in
> > > > > > > the upper layer. Then overlayfs could just propagate the resu=
lts from
> > > > > > > the upper layer in its response.
> > > > > > >=20
> > > > > > > That sort of design may also eventually help IMA work properl=
y with more
> > > > > > > exotic filesystems, like NFS or Ceph.
> > > > > > >=20
> > > > > > >=20
> > > > > > >=20
> > > > > >=20
> > > > > > Maybe something like this? It builds for me but I haven't teste=
d it. It
> > > > > > looks like overlayfs already should report the upper layer's i_=
version
> > > > > > in getattr, though I haven't tested that either:
> > > > > >=20
> > > > > > -----------------------8<---------------------------
> > > > > >=20
> > > > > > [PATCH] IMA: use vfs_getattr_nosec to get the i_version
> > > > > >=20
> > > > > > IMA currently accesses the i_version out of the inode directly =
when it
> > > > > > does a measurement. This is fine for most simple filesystems, b=
ut can be
> > > > > > problematic with more complex setups (e.g. overlayfs).
> > > > > >=20
> > > > > > Make IMA instead call vfs_getattr_nosec to get this info. This =
allows
> > > > > > the filesystem to determine whether and how to report the i_ver=
sion, and
> > > > > > should allow IMA to work properly with a broader class of files=
ystems in
> > > > > > the future.
> > > > > >=20
> > > > > > Reported-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > ---
> > > > >=20
> > > > > So, I think we want both; we want the ovl_copyattr() and the
> > > > > vfs_getattr_nosec() change:
> > > > >=20
> > > > > (1) overlayfs should copy up the inode version in ovl_copyattr().=
 That
> > > > >     is in line what we do with all other inode attributes. IOW, t=
he
> > > > >     overlayfs inode's i_version counter should aim to mirror the
> > > > >     relevant layer's i_version counter. I wouldn't know why that
> > > > >     shouldn't be the case. Asking the other way around there does=
n't
> > > > >     seem to be any use for overlayfs inodes to have an i_version =
that
> > > > >     isn't just mirroring the relevant layer's i_version.
> > > >=20
> > > > It's less than ideal to do this IMO, particularly with an IS_I_VERS=
ION
> > > > inode.
> > > >=20
> > > > You can't just copy=A0up the value from the upper. You'll need to c=
all
> > > > inode_query_iversion(upper_inode), which will flag the upper inode =
for a
> > > > logged i_version update on the next write. IOW, this could create s=
ome
> > > > (probably minor) metadata write amplification in the upper layer in=
ode
> > > > with IS_I_VERSION inodes.
> > >=20
> > > I'm likely just missing context and am curious about this so bear wit=
h me. Why
> > > do we need to flag the upper inode for a logged i_version update? Any=
 required
> > > i_version interactions should've already happened when overlayfs call=
ed into
> > > the upper layer. So all that's left to do is for overlayfs' to mirror=
 the
> > > i_version value after the upper operation has returned.
> >=20
> > > ovl_copyattr() - which copies the inode attributes - is always called=
 after the
> > > operation on the upper inode has finished. So the additional query se=
ems odd at
> > > first glance. But there might well be a good reason for it. In my nai=
ve
> > > approach I would've thought that sm along the lines of:
> > >=20
> > > diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> > > index 923d66d131c1..8b089035b9b3 100644
> > > --- a/fs/overlayfs/util.c
> > > +++ b/fs/overlayfs/util.c
> > > @@ -1119,4 +1119,5 @@ void ovl_copyattr(struct inode *inode)
> > >         inode->i_mtime =3D realinode->i_mtime;
> > >         inode->i_ctime =3D realinode->i_ctime;
> > >         i_size_write(inode, i_size_read(realinode));
> > > +       inode_set_iversion_raw(inode, inode_peek_iversion_raw(realino=
de));
> > >  }
> > >=20
> > > would've been sufficient.
> > >=20
> >=20
> > Nope, because then you wouldn't get any updates to i_version after that
> > point.
> >=20
> > Note that with an IS_I_VERSION inode we only update the i_version when
> > there has been a query since the last update. What you're doing above i=
s
> > circumventing that mechanism. You'll get the i_version at the time of o=
f
> > the ovl_copyattr, but there won't be any updates of it after that point
> > because the QUERIED bit won't end up being set on realinode.
>=20
> I get all that.
> But my understanding had been that the i_version value at the time of
> ovl_copyattr() would be correct. Because when ovl_copyattr() is called
> the expected i_version change will have been done in the relevant layer
> includig raising the QUERIED bit. Since the layers are not allowed to be
> changed outside of the overlayfs mount any change to them can only
> originate from overlayfs which would necessarily call ovl_copyattr()
> again. IOW, overlayfs would by virtue of its implementation keep the
> i_version value in sync.
>
> Overlayfs wouldn't even raise SB_I_VERSION. It would indeed just be a
> cache of i_version of the relevant layer.
>=20
> >=20
> >=20
> > > Since overlayfs' does explicitly disallow changes to the upper and lo=
wer trees
> > > while overlayfs is mounted it seems intuitive that it should just mir=
ror the
> > > relevant layer's i_version.
> > >=20
> > >=20
> > > If we don't do this, then we should probably document that i_version =
doesn't
> > > have a meaning yet for the inodes of stacking filesystems.
> > >=20
> >=20
> > Trying to cache the i_version is counterproductive, IMO, at least with
> > an IS_I_VERSION inode.
> >=20
> > The problem is that a query against the i_version has a side-effect. It
> > has to (atomically) mark the inode for an update on the next change.
> >=20
> > If you try to cache that value, you'll likely end up doing more queries
> > than you really need to (because you'll need to keep the cache up to
> > date) and you'll have an i_version that will necessarily lag the one in
> > the upper layer inode.
> >=20
> > The whole point of the change attribute is to get the value as it is at
> > this very moment so we can check whether there have been changes. A
> > laggy value is not terribly useful.
> >=20
> > Overlayfs should just always call the upper layer's ->getattr to get th=
e
> > version. I wouldn't even bother copying it up in the first place. Doing
> > so is just encouraging someone to try use the value in the overlayfs
> > inode, when they really need to go through ->getattr and get the one
> > from the upper layer.
>=20
> That seems reasonable to me. I read this as an agreeing with my earlier
> suggestion to document that i_version doesn't have a meaning for the
> inodes of stacking filesystems and that we should spell out that
> vfs_getattr()/->getattr() needs to be used to interact with i_version.
>=20

It really has no meaning in the stacked filesystem's _inode_. The only
i_version that has any meaning in a (simple) stacking setup is the upper
layer inode.

> We need to explain to subsystems such as IMA somwhere what the correct
> way to query i_version agnostically is; independent of filesystem
> implementation details.
>=20
> Looking at IMA, it queries the i_version directly without checking
> whether it's an IS_I_VERSION() inode first. This might make a
> difference.
>=20

IMA should just use getattr. That allows the filesystem to present the
i_version to the caller as it sees fit. Fetching i_version directly
without testing for IS_I_VERSION is wrong, because you don't know what
that field contains, or whether the fs supports it at all.

> Afaict, filesystems that persist i_version to disk automatically raise
> SB_I_VERSION. I would guess that it be considered a bug if a filesystem
> would persist i_version to disk and not raise SB_I_VERSION. If so IMA
> should probably be made to check for IS_I_VERSION() and it will probably
> get that by switching to vfs_getattr_nosec().

Not quite. SB_I_VERSION tells the vfs that the filesystem wants the
kernel to manage the increment of the i_version for it. The filesystem
is still responsible for persisting that value to disk (if appropriate).

Switching to vfs_getattr_nosec should make it so IMA doesn't need to
worry about the gory details of all of this. If STATX_CHANGE_COOKIE is
set in the response, then it can trust that value. Otherwise, it's no
good.

--=20
Jeff Layton <jlayton@kernel.org>
