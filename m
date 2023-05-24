Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5869E70FCC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 19:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbjEXRgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 13:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjEXRgP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 13:36:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D01193;
        Wed, 24 May 2023 10:36:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E42E634A0;
        Wed, 24 May 2023 17:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE2FC433D2;
        Wed, 24 May 2023 17:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684949773;
        bh=FHanwwQRLwF6UFcaR70zYuU5aS6+zr3PVwqkLoN3BJo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Rac00IfWWZjVibDhel2t0kOUs8D5g8w0yRLuVjVpHk/Zh/AQefS4eZUafdQL6Af66
         WN8OKXNSHEMdDxokjnbNCLe0rZ9DP3jmRY0WzgHupRJ0EXA4IsN4mDlkgh5+Tqb+uU
         h88lAo21u8vZOSbNAvkgq1OFIKCLOw/QvoKIUwFUSyFGUEoNZJmFRkbRS5dZewqG8/
         yyk87doUsEAXFKtrOgVYm0nmdMdJyVV8GFAGYvBrkVq8t7r4zfwyAnNK44YCGsSjCT
         rd00fvp9hAMbNtZDMiMrblxbaU9tf/2CidgVUysUjWyyfDYBSPmYrJdTs7HLOWqafY
         hM4vQKe/VopGw==
Message-ID: <0a140464f921baf88a0295e91a43bbd92faa2f2c.camel@kernel.org>
Subject: Re: [PATCH] exportfs: check for error return value from
 exportfs_encode_*()
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Date:   Wed, 24 May 2023 13:36:11 -0400
In-Reply-To: <CAOQ4uxjY_KqETNDDXYBGgXvE_7JTWStSaYK2CEjfj_UUzmLbzQ@mail.gmail.com>
References: <20230524154825.881414-1-amir73il@gmail.com>
         <61146b7311e44d89034bd09dee901254a4a6a60b.camel@kernel.org>
         <CAOQ4uxjY_KqETNDDXYBGgXvE_7JTWStSaYK2CEjfj_UUzmLbzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-05-24 at 20:24 +0300, Amir Goldstein wrote:
> On Wed, May 24, 2023 at 8:05=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> >=20
> > On Wed, 2023-05-24 at 18:48 +0300, Amir Goldstein wrote:
> > > The exportfs_encode_*() helpers call the filesystem ->encode_fh()
> > > method which returns a signed int.
> > >=20
> > > All the in-tree implementations of ->encode_fh() return a positive
> > > integer and FILEID_INVALID (255) for error.
> > >=20
> > > Fortify the callers for possible future ->encode_fh() implementation
> > > that will return a negative error value.
> > >=20
> > > name_to_handle_at() would propagate the returned error to the users
> > > if filesystem ->encode_fh() method returns an error.
> > >=20
> > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > Link: https://lore.kernel.org/linux-fsdevel/ca02955f-1877-4fde-b453-3=
c1d22794740@kili.mountain/
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >=20
> > > Jan,
> > >=20
> > > This patch is on top of the patches you have queued on fsnotify branc=
h.
> > >=20
> > > I am not sure about the handling of negative value in nfsfh.c.
> > >=20
> > > Jeff/Chuck,
> > >=20
> > > Could you please take a look.
> > >=20
> > > I've test this patch with fanotify LTP tests, xfstest -g exportfs tes=
ts
> > > and some sanity xfstest nfs tests, but I did not try to inject errors
> > > in encode_fh().
> > >=20
> > > Please let me know what you think.
> > >=20
> > > Thanks,
> > > Amir.
> > >=20
> > >=20
> > >=20
> > >  fs/fhandle.c                  | 5 +++--
> > >  fs/nfsd/nfsfh.c               | 4 +++-
> > >  fs/notify/fanotify/fanotify.c | 2 +-
> > >  3 files changed, 7 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > > index 4a635cf787fc..fd0d6a3b3699 100644
> > > --- a/fs/fhandle.c
> > > +++ b/fs/fhandle.c
> > > @@ -57,18 +57,19 @@ static long do_sys_name_to_handle(const struct pa=
th *path,
> > >       handle_bytes =3D handle_dwords * sizeof(u32);
> > >       handle->handle_bytes =3D handle_bytes;
> > >       if ((handle->handle_bytes > f_handle.handle_bytes) ||
> > > -         (retval =3D=3D FILEID_INVALID) || (retval =3D=3D -ENOSPC)) =
{
> > > +         (retval =3D=3D FILEID_INVALID) || (retval < 0)) {
> > >               /* As per old exportfs_encode_fh documentation
> > >                * we could return ENOSPC to indicate overflow
> > >                * But file system returned 255 always. So handle
> > >                * both the values
> > >                */
> > > +             if (retval =3D=3D FILEID_INVALID || retval =3D=3D -ENOS=
PC)
> > > +                     retval =3D -EOVERFLOW;
> > >               /*
> > >                * set the handle size to zero so we copy only
> > >                * non variable part of the file_handle
> > >                */
> > >               handle_bytes =3D 0;
> > > -             retval =3D -EOVERFLOW;
> > >       } else
> > >               retval =3D 0;
> > >       /* copy the mount id */
> > > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > > index 31e4505c0df3..0f5eacae5f43 100644
> > > --- a/fs/nfsd/nfsfh.c
> > > +++ b/fs/nfsd/nfsfh.c
> > > @@ -416,9 +416,11 @@ static void _fh_update(struct svc_fh *fhp, struc=
t svc_export *exp,
> > >               int maxsize =3D (fhp->fh_maxsize - fhp->fh_handle.fh_si=
ze)/4;
> > >               int fh_flags =3D (exp->ex_flags & NFSEXP_NOSUBTREECHECK=
) ? 0 :
> > >                               EXPORT_FH_CONNECTABLE;
> > > +             int fileid_type =3D
> > > +                     exportfs_encode_fh(dentry, fid, &maxsize, fh_fl=
ags);
> > >=20
> > >               fhp->fh_handle.fh_fileid_type =3D
> > > -                     exportfs_encode_fh(dentry, fid, &maxsize, fh_fl=
ags);
> > > +                     fileid_type > 0 ? fileid_type : FILEID_INVALID;
> > >               fhp->fh_handle.fh_size +=3D maxsize * 4;
>=20
> Specifically, I wanted to know what nfs developers think that updating
> fh_size should be skipped for invalid type? or doesn't matter?
>=20

It doesn't matter. When the callers see the type set to FILEID_INVALID,
they'll go into error handling anyway and shouldn't try to do anything
further with the size.

> > >       } else {
> > >               fhp->fh_handle.fh_fileid_type =3D FILEID_ROOT;
> > > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanot=
ify.c
> > > index d2bbf1445a9e..9dac7f6e72d2 100644
> > > --- a/fs/notify/fanotify/fanotify.c
> > > +++ b/fs/notify/fanotify/fanotify.c
> > > @@ -445,7 +445,7 @@ static int fanotify_encode_fh(struct fanotify_fh =
*fh, struct inode *inode,
> > >       dwords =3D fh_len >> 2;
> > >       type =3D exportfs_encode_fid(inode, buf, &dwords);
> >=20
> > Are you sure this patch is against the HEAD? My tree has this call as
> > exportfs_encode_inode_fh.
>=20
> It isn't
>=20
> "This patch is on top of the patches you have queued on fsnotify branch."
>=20
> It could be applied also in the beginning of the encode_fid series
> in case anyone would be interested to backport this one.
> There is a minor conflict with the first "connectable" flag patch.
> If needed, I can post rebased series.
>=20

It's not a big deal. I just wanted to make sure we didn't end up with
merge conflicts.

> >=20
> > >       err =3D -EINVAL;
> > > -     if (!type || type =3D=3D FILEID_INVALID || fh_len !=3D dwords <=
< 2)
> > > +     if (type <=3D 0 || type =3D=3D FILEID_INVALID || fh_len !=3D dw=
ords << 2)
> >=20
> > >               goto out_err;
> > >=20
> > >       fh->type =3D type;
> >=20
> > I'm generally in favor of better guardrails for these sorts of
> > operations, so ACK on the general idea around the patch.
> >=20
> > --
> > Jeff Layton <jlayton@kernel.org>
>=20
> Beyond the general idea, do you also ACK my fix to _fh_update()
> above? I wasn't 100% sure about it.
>=20

That looks like the right way to handle _fh_update(). I think that
should also make it also treat a value of 0 as an error, which seems
like the right thing to do (even of no caller tries to do that today).

Reviewed-by: Jeff Layton <jlayton@kernel.org>
