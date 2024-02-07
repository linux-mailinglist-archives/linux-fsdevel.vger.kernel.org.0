Return-Path: <linux-fsdevel+bounces-10565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE6A84C4E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 07:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C2B51F26C08
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 06:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEA81CD31;
	Wed,  7 Feb 2024 06:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fd4ls4ap"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C00510788;
	Wed,  7 Feb 2024 06:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707286776; cv=none; b=HBMY84p10kufaqfEyBar2sY2c/0ZQTwhz5/fQSKnPenvNRcv98Il3A2smtgrdnYpMsLfwFwC3gQemFjTrPzoPSGhN0cDeNJwNDbvC/S44lChGZnHIZYL0YPRB28WBMqJjggpNSQU47W5suKGqINj1tl88FrTWk7c0zvfMbiN8Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707286776; c=relaxed/simple;
	bh=Zw+zuvVKn7BHCJYKlJtcd0VYWlBnyG3eURH4PJZTXzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCo9rUNhYbgunmCIClXYKtCjDf2oiN99hr7/d0SDqKl5LQGKgIfTkIkGiTtK0ycIqWoezjXluslHVYI7IelO6UIG5zHqLsh1qO07Y7B8/VCp59fAIsW3Zf4//FE1c/mNRhx1jIGWjPiKoNDI0IK5JrfkUTfxHIEx0YEjSB8Pf0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fd4ls4ap; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6818f3cf00aso1797006d6.0;
        Tue, 06 Feb 2024 22:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707286774; x=1707891574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvxHz8UI4TMnELHil0IULsGrxG7+ElSx4mu4N8xJ1KA=;
        b=Fd4ls4apCZLNIGOwhLeHBb2VwcCzFehgFsvZl2gGdO5Z4wWMs+G7HeWlBU5QLCLUgp
         nlnwMwqUGlQge6/u9CZ1ttHeIM5/917tGheA/uHSWJJ39yUa/DMkfpdFkJjnHl2x1e/T
         7IWqbu1VHX+iNuzHWSbHXrwCRWwfEW2JdPOxfMkaIdLmaUan8YkiryVPDz3KI7ciBxVx
         ahwcsikcWnNTRjxt0sAsoaHUsrsU8XZfmJV4n099HQs35+YcggKWAYd+LPij3MhLB+Km
         /L2VH88jnDB6W8jNLoGz7NBB0VUA3O/hX0IilysOxKUxWuUdakhBsCAJBNQfwtMIRQ3d
         EAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707286774; x=1707891574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvxHz8UI4TMnELHil0IULsGrxG7+ElSx4mu4N8xJ1KA=;
        b=IBN4e9Tr686dGsBXUGw19tdKN5QfK9S3XFzhOoG2JV98xhMIVGVv1a5SMM6eQQ6RVO
         hUPjmwN9p6gEdGXV9ygWr4f4p6DtkbNjppXWpfmL+OnuLbcgOEhHuMG67SiXRGOeKCla
         Qzw8TrZEjjgM7jSs7w66zoUSPImfrr2672nGG/MXNGBFPEggoAnoz7fhrt8k4X8ozFad
         grQHCTw+vVFI9BfsjZIWN16nGdLREkt5r6Q5JmcqbhQHwAshreqGBN4yyJEyWs82Xk44
         5QRqFBKhvc+zlH111Tau4u2xhacow3oGIvJDoueDBtFB07X9XgeX/4vnvyfA8h6d80b/
         t2Yw==
X-Gm-Message-State: AOJu0YyXWIDoIUbIa8lTj3WZH5rt1khUbLzIF7HYnsOKhyVcJW/XOLRI
	vmxfQHZYHSYRuxb7tm7lqwpFZLuFUM75C7S9lptH3KjsbMSYaAJsd9Lb71ydTnZtJgecedDW8Ka
	FFXrCeAjeS+9SC50R2judd03ToP4=
X-Google-Smtp-Source: AGHT+IHH+mNF5lXuZAsuSpyRHnUZd/EhrIFMnrt2+Dexy3XfE0zvOhtGwBQ6/SaFaAed8UpcWIeI6mjNX75zDlSZ560=
X-Received: by 2002:ad4:5cc6:0:b0:68c:8775:7593 with SMTP id
 iu6-20020ad45cc6000000b0068c87757593mr5861197qvb.12.1707286774036; Tue, 06
 Feb 2024 22:19:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
 <20240206201858.952303-3-kent.overstreet@linux.dev> <ZcKpSU9frvTUb2eq@dread.disaster.area>
In-Reply-To: <ZcKpSU9frvTUb2eq@dread.disaster.area>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 7 Feb 2024 08:19:22 +0200
Message-ID: <CAOQ4uxgMY+QeYGn5wH0N9GhJD1h-EWqrng99XxMtXXUCB8zL=g@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] overlayfs: Convert to super_set_uuid()
To: Dave Chinner <david@fromorbit.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 11:49=E2=80=AFPM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Tue, Feb 06, 2024 at 03:18:50PM -0500, Kent Overstreet wrote:
> > We don't want to be settingc sb->s_uuid directly anymore, as there's a
> > length field that also has to be set, and this conversion was not
> > completely trivial.
> >
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: linux-unionfs@vger.kernel.org
> > ---
> >  fs/overlayfs/util.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> > index 0217094c23ea..f1f0ee9a9dff 100644
> > --- a/fs/overlayfs/util.c
> > +++ b/fs/overlayfs/util.c
> > @@ -760,13 +760,14 @@ bool ovl_init_uuid_xattr(struct super_block *sb, =
struct ovl_fs *ofs,
> >                        const struct path *upperpath)
> >  {
> >       bool set =3D false;
> > +     uuid_t uuid;
> >       int res;
> >
> >       /* Try to load existing persistent uuid */
> > -     res =3D ovl_path_getxattr(ofs, upperpath, OVL_XATTR_UUID, sb->s_u=
uid.b,
> > +     res =3D ovl_path_getxattr(ofs, upperpath, OVL_XATTR_UUID, uuid.b,
> >                               UUID_SIZE);
> >       if (res =3D=3D UUID_SIZE)
> > -             return true;
> > +             goto success;
> >
> >       if (res !=3D -ENODATA)
> >               goto fail;
> > @@ -794,14 +795,14 @@ bool ovl_init_uuid_xattr(struct super_block *sb, =
struct ovl_fs *ofs,
> >       }
> >
> >       /* Generate overlay instance uuid */
> > -     uuid_gen(&sb->s_uuid);
> > +     uuid_gen(&uuid);
> >
> >       /* Try to store persistent uuid */
> >       set =3D true;
> > -     res =3D ovl_setxattr(ofs, upperpath->dentry, OVL_XATTR_UUID, sb->=
s_uuid.b,
> > +     res =3D ovl_setxattr(ofs, upperpath->dentry, OVL_XATTR_UUID, uuid=
.b,
> >                          UUID_SIZE);
> >       if (res =3D=3D 0)
> > -             return true;
> > +             goto success;
>
> This is a bit weird. Normally the success case is in line, and we
> jump out of line for the fail case. I think this is more better:
>
>         if (res)
>                 goto fail;
> success:
>         super_set_uuid(sb, uuid.b, sizeof(uuid));
>         return true;
> >
> >  fail:
> >       memset(sb->s_uuid.b, 0, UUID_SIZE);
>
> And then the fail case follows naturally.
>

I agree. Please use the label name
set_uuid:

Also the memset() in fail: case is not needed anymore, because
with your change we do not dirty sb->s_uuid in this function.

Thanks,
Amir.

