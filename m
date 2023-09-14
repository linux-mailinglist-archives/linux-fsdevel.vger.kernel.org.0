Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA74F7A01A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 12:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbjINK1W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 06:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjINK1V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:27:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2311BE9;
        Thu, 14 Sep 2023 03:27:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B139DC433C7;
        Thu, 14 Sep 2023 10:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694687237;
        bh=yDQqvovGnrf78EMpc8cz+BBi0k2m4AVQSZyr7l9ADW8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=W8iroKkhg69TCpAdNcxe1oKdo6zlrTDglMSICWBpFyn+hx4P99OZLodtxCREF+OuE
         RmsWOlcLaAJxSidY2Vx2Ai9hGDnD3AEvKpycGqNpyqRSnvK9WqIJyBHggxpyL9UlH6
         +w7KmRAJlE+wKbRe0tW92UUFOOdzRqorS/m2ZIlLQ/pB3p6Cmzi5GnbAVt8kdl3TDO
         K675pl4gmKZ1n3jklLYyQERAbtFEBvSdzB+bVACAYFT443vPFQvbsTcP33GtY4ffYY
         wg8bIgRstAFQ2aK0qDWcrzo1SQLlOfMF27u2ZjN7x97LJc8dcsUznh1MPgob3qWY2q
         Tr6jSJaZ8JMBg==
Message-ID: <b107db96b12f4ab5b2edfbaa42bc0032205d24cc.camel@kernel.org>
Subject: Re: [PATCH] overlayfs: set ctime when setting mtime and atime
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Nathan Chancellor <nathan@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Sep 2023 06:27:15 -0400
In-Reply-To: <CAOQ4uxhYRnX0NChCU2tsEi7eUPqbqQDeOwQT4ubWUgtCN0OVfA@mail.gmail.com>
References: <20230913-ctime-v1-1-c6bc509cbc27@kernel.org>
         <CAOQ4uxhYRnX0NChCU2tsEi7eUPqbqQDeOwQT4ubWUgtCN0OVfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-09-13 at 20:36 +0300, Amir Goldstein wrote:
> On Wed, Sep 13, 2023 at 4:33=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> >=20
> > Nathan reported that he was seeing the new warning in
> > setattr_copy_mgtime pop when starting podman containers. Overlayfs is
> > trying to set the atime and mtime via notify_change without also
> > setting the ctime.
> >=20
> > POSIX states that when the atime and mtime are updated via utimes() tha=
t
> > we must also update the ctime to the current time. The situation with
> > overlayfs copy-up is analogous, so add ATTR_CTIME to the bitmask.
> > notify_change will fill in the value.
> >=20
>=20
> IDGI, if ctime always needs to be set along with ATIME / MTIME, why not
> let notify_change() set the bit instead of assert and fix all the callers=
?
> But maybe I am missing something.
>=20

Traditionally notify_change has always been given an explicit mask of
attrs to change by the caller. I'm a little hesitant to start putting
POSIX policy in there.

Still, that may be the better thing to do over the long haul. I think
that there are some other bugs in the notify_change callers as well: for
instance, cachefiles_adjust_size truncates files, but doesn't update the
timestamps. I'm pretty sure that's wrong.

I think if we want to change how setattr ctime updates work, we'll
probably need to do it in the context of a larger notify_change
overhaul.

> Anyway, I have no objection to the ovl patch.
> It's fine by me if Christian applies it to the vfs.ctime branch with my A=
CK.
>=20

Many thanks!

> Thanks,
> Amir.
>=20
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > The new WARN_ON_ONCE in setattr_copy_mgtime caught a bug! Fix up
> > overlayfs to ensure that the ctime on the upper inode is also updated
> > when copying up the atime and mtime.
> > ---
> >  fs/overlayfs/copy_up.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> > index d1761ec5866a..ada3fcc9c6d5 100644
> > --- a/fs/overlayfs/copy_up.c
> > +++ b/fs/overlayfs/copy_up.c
> > @@ -337,7 +337,7 @@ static int ovl_set_timestamps(struct ovl_fs *ofs, s=
truct dentry *upperdentry,
> >  {
> >         struct iattr attr =3D {
> >                 .ia_valid =3D
> > -                    ATTR_ATIME | ATTR_MTIME | ATTR_ATIME_SET | ATTR_MT=
IME_SET,
> > +                    ATTR_ATIME | ATTR_MTIME | ATTR_ATIME_SET | ATTR_MT=
IME_SET | ATTR_CTIME,
> >                 .ia_atime =3D stat->atime,
> >                 .ia_mtime =3D stat->mtime,
> >         };
> >=20
> > ---
> > base-commit: 9cb8e7c86ac793862e7bea7904b3426942bbd7ef
> > change-id: 20230913-ctime-299173760dd9
> >=20
> > Best regards,
> > --
> > Jeff Layton <jlayton@kernel.org>
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
