Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9BA70FC9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 19:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjEXRZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 13:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjEXRZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 13:25:06 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B80E48;
        Wed, 24 May 2023 10:24:53 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-437e1f38b34so12232137.0;
        Wed, 24 May 2023 10:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684949092; x=1687541092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnpeeHIo4duCJDS2YkWsmDNNZEgV5VoiOcy3pffXx18=;
        b=sEp+5TQE0wi7zSWV1kbT9PE6XQ7n1JIIqCCZiFaJEQam2lERjiGxhdWMWuz7mFOxaS
         hCDBmyisjYi52PUcNwe4IAFiHmzRGNlXo2fQ09YLZFEwxohz4pPXWTMBs2hwJE2+fLFH
         OLcIboNxqVRXDK134oRgDEouhzhjej8IXZJ/b08JK5qHHr/XAwOKMOxsF1rcDQRN4Zw9
         zZTmWEv6jRPaaCQRxH25ci1cWE1sKMvsLQ0YwmLc4hFPexV/rFGFPi76JwYlm91QYGl7
         A85tPdeL+PUf72PTurRcxwaD0xnP5OjlmIGGnkxgeB4BvEWqccPecKDXLyuKnRxBiPxE
         EZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684949092; x=1687541092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TnpeeHIo4duCJDS2YkWsmDNNZEgV5VoiOcy3pffXx18=;
        b=FMKSvjgvS+yZlXtUJ9nLE6DG5lxo4FjaHyGrkzRAPZimIk3W14c30LroG7HnJZVwG+
         NwAEAMtGJkFP4UW4x2oozOjsHCMCBQc5CtnPtQdptLiVM5pXLOPyaG9bOMesYwnpG1T0
         FAovLKj4HyyI9PXrc8dZ6ucadx/b1l1ma/QpHnGaVGc5Mx/A6GP0yZJ94B/BQ+ErOCRc
         PkeuAdbamWe7CFHVNRJRF8RayZEnM4PXpWwqrKcGo7W1NOrYWtZx9pUmKh0YrVEsosjk
         7/LA55GriJw2jhUx1b8avJ/XVwd2iIZEd8NweD8PFqdrOnB7RDxpiKBEgVO45p0VHKPD
         D6Hg==
X-Gm-Message-State: AC+VfDziBssc//WuHryB38SPb5/WSrCWy8JKT76Fg2qy34lyAAZvgZah
        yjAr3P7Ic4987Ot00lJU3/aTEu+jQkwO02GyCD/N0tfHHps=
X-Google-Smtp-Source: ACHHUZ4mLj20fpRx9X0z9eHE4r/QekmJixlGYnat8pcjRngSzC5UxFdFY1NU3S4wGAHVGDPkbWOKyABj+x+RxxBwYkc=
X-Received: by 2002:a67:ce1a:0:b0:437:e783:f11d with SMTP id
 s26-20020a67ce1a000000b00437e783f11dmr5360725vsl.12.1684949092295; Wed, 24
 May 2023 10:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230524154825.881414-1-amir73il@gmail.com> <61146b7311e44d89034bd09dee901254a4a6a60b.camel@kernel.org>
In-Reply-To: <61146b7311e44d89034bd09dee901254a4a6a60b.camel@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 May 2023 20:24:41 +0300
Message-ID: <CAOQ4uxjY_KqETNDDXYBGgXvE_7JTWStSaYK2CEjfj_UUzmLbzQ@mail.gmail.com>
Subject: Re: [PATCH] exportfs: check for error return value from exportfs_encode_*()
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023 at 8:05=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Wed, 2023-05-24 at 18:48 +0300, Amir Goldstein wrote:
> > The exportfs_encode_*() helpers call the filesystem ->encode_fh()
> > method which returns a signed int.
> >
> > All the in-tree implementations of ->encode_fh() return a positive
> > integer and FILEID_INVALID (255) for error.
> >
> > Fortify the callers for possible future ->encode_fh() implementation
> > that will return a negative error value.
> >
> > name_to_handle_at() would propagate the returned error to the users
> > if filesystem ->encode_fh() method returns an error.
> >
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Link: https://lore.kernel.org/linux-fsdevel/ca02955f-1877-4fde-b453-3c1=
d22794740@kili.mountain/
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Jan,
> >
> > This patch is on top of the patches you have queued on fsnotify branch.
> >
> > I am not sure about the handling of negative value in nfsfh.c.
> >
> > Jeff/Chuck,
> >
> > Could you please take a look.
> >
> > I've test this patch with fanotify LTP tests, xfstest -g exportfs tests
> > and some sanity xfstest nfs tests, but I did not try to inject errors
> > in encode_fh().
> >
> > Please let me know what you think.
> >
> > Thanks,
> > Amir.
> >
> >
> >
> >  fs/fhandle.c                  | 5 +++--
> >  fs/nfsd/nfsfh.c               | 4 +++-
> >  fs/notify/fanotify/fanotify.c | 2 +-
> >  3 files changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > index 4a635cf787fc..fd0d6a3b3699 100644
> > --- a/fs/fhandle.c
> > +++ b/fs/fhandle.c
> > @@ -57,18 +57,19 @@ static long do_sys_name_to_handle(const struct path=
 *path,
> >       handle_bytes =3D handle_dwords * sizeof(u32);
> >       handle->handle_bytes =3D handle_bytes;
> >       if ((handle->handle_bytes > f_handle.handle_bytes) ||
> > -         (retval =3D=3D FILEID_INVALID) || (retval =3D=3D -ENOSPC)) {
> > +         (retval =3D=3D FILEID_INVALID) || (retval < 0)) {
> >               /* As per old exportfs_encode_fh documentation
> >                * we could return ENOSPC to indicate overflow
> >                * But file system returned 255 always. So handle
> >                * both the values
> >                */
> > +             if (retval =3D=3D FILEID_INVALID || retval =3D=3D -ENOSPC=
)
> > +                     retval =3D -EOVERFLOW;
> >               /*
> >                * set the handle size to zero so we copy only
> >                * non variable part of the file_handle
> >                */
> >               handle_bytes =3D 0;
> > -             retval =3D -EOVERFLOW;
> >       } else
> >               retval =3D 0;
> >       /* copy the mount id */
> > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > index 31e4505c0df3..0f5eacae5f43 100644
> > --- a/fs/nfsd/nfsfh.c
> > +++ b/fs/nfsd/nfsfh.c
> > @@ -416,9 +416,11 @@ static void _fh_update(struct svc_fh *fhp, struct =
svc_export *exp,
> >               int maxsize =3D (fhp->fh_maxsize - fhp->fh_handle.fh_size=
)/4;
> >               int fh_flags =3D (exp->ex_flags & NFSEXP_NOSUBTREECHECK) =
? 0 :
> >                               EXPORT_FH_CONNECTABLE;
> > +             int fileid_type =3D
> > +                     exportfs_encode_fh(dentry, fid, &maxsize, fh_flag=
s);
> >
> >               fhp->fh_handle.fh_fileid_type =3D
> > -                     exportfs_encode_fh(dentry, fid, &maxsize, fh_flag=
s);
> > +                     fileid_type > 0 ? fileid_type : FILEID_INVALID;
> >               fhp->fh_handle.fh_size +=3D maxsize * 4;

Specifically, I wanted to know what nfs developers think that updating
fh_size should be skipped for invalid type? or doesn't matter?

> >       } else {
> >               fhp->fh_handle.fh_fileid_type =3D FILEID_ROOT;
> > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotif=
y.c
> > index d2bbf1445a9e..9dac7f6e72d2 100644
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> > @@ -445,7 +445,7 @@ static int fanotify_encode_fh(struct fanotify_fh *f=
h, struct inode *inode,
> >       dwords =3D fh_len >> 2;
> >       type =3D exportfs_encode_fid(inode, buf, &dwords);
>
> Are you sure this patch is against the HEAD? My tree has this call as
> exportfs_encode_inode_fh.

It isn't

"This patch is on top of the patches you have queued on fsnotify branch."

It could be applied also in the beginning of the encode_fid series
in case anyone would be interested to backport this one.
There is a minor conflict with the first "connectable" flag patch.
If needed, I can post rebased series.

>
> >       err =3D -EINVAL;
> > -     if (!type || type =3D=3D FILEID_INVALID || fh_len !=3D dwords << =
2)
> > +     if (type <=3D 0 || type =3D=3D FILEID_INVALID || fh_len !=3D dwor=
ds << 2)
>
> >               goto out_err;
> >
> >       fh->type =3D type;
>
> I'm generally in favor of better guardrails for these sorts of
> operations, so ACK on the general idea around the patch.
>
> --
> Jeff Layton <jlayton@kernel.org>

Beyond the general idea, do you also ACK my fix to _fh_update()
above? I wasn't 100% sure about it.

Thanks,
Amir.
