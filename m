Return-Path: <linux-fsdevel+bounces-68437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBB2C5C1E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 09:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 278E7354458
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 08:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D7A2FE045;
	Fri, 14 Nov 2025 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBNHAVkn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA7512DDA1
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763110706; cv=none; b=GIMQtBWBxGeUHkUJVazDv+k1O3HsjjwqBE4/kf0uLyydr5pKgcwME/0SSt5ZRCxaNaf/ONr2ay6h22g0zE9GClmliUOeVMg4+s46XxfMBSTlVJcLj5c8fz9VpQPauAumDNXMEZ3SylEca3k6y0njGbNv59GROzMavJORTL2IP4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763110706; c=relaxed/simple;
	bh=sT7CmDk36b9P8vSRWRxbwIbOQOaHEdw1tS+A9QbyhZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6uDKPvzBkwFHnmUCMm4HdCA/IyfuBF0lPMFvbUAUtaz8Go2+D4BTBCMLRJG4IoA4x+SiNRGmeIcjdxHK6v01U/QWp3JqXC/OUu+qQ/QMxnNXdrO0xbJI0U/4+qVeQPYJdD5DmkLZZm2MaSTq3vND+wY44hg/833eIyxwBGUaVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBNHAVkn; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso3720471a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 00:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763110703; x=1763715503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XFOdlHqJwohSZc5ij9iHLsD3vkWYlIVMx2QhJPUN7Y=;
        b=hBNHAVknrplz2L+f7Fhy4uLt90os/7oYnxRfawnTzyuio0DeNXwBMmkgzEz2MvIv/o
         RYdZcYYcYEvKiUMqG29sFsK3VKifNSo/lI+V8VGj3gXvgqUv9e5CXNrR6mCbTiP+EAX+
         CSzzqO17puotP/8y7bg6Cif8dmWINTazGC6Qq7ofQUwIZg3ViaFb37edvgISA1hujGLn
         y8sdeQEpcU9w9YHGEW6Wd6QsVrmJXPscMn7e43dBQjly4cBxXxtEl3N3Yte4HT78HKe/
         1FidYfsaJG4KX+eIq4BK93UIITrKGd9JUWI5/mRoiEcxxEnLicZ1AOMV2MpkaukuSN7B
         IRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763110703; x=1763715503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3XFOdlHqJwohSZc5ij9iHLsD3vkWYlIVMx2QhJPUN7Y=;
        b=ZDTzgnnWPb7y3kvXCVLb+Z7XtZsyl5OdIhA9Cj+GmE15uN7P1EkZTXbP/1/S1AZ9zp
         pmXEREfNV6/e2ST607Dk0nvwP9+a0+h9wd/KQZQwHUOqaLmr80Q+csKl0UWFAsQfUc56
         52SgMPDpVPuyMR4mgK8vxsGdZhVkUgfq7rZuAIS+NcRA9RkJ6fL+fsclvTx55tRvQY/n
         5BoH6ERuZqcnC1QNVvVaZqXyj4AhAoloDxj+DxhUbGbPD3apO8BZbqSK1xOUgE9sY8Sp
         3F1kuSRtIfg6cGHPgZK9x+OYsiYJsO4uA5ZIp9MWGPnMvzpThXVSnUS21Jm0VbRJmXdQ
         tFfA==
X-Forwarded-Encrypted: i=1; AJvYcCWb1FtJDZG4SOJhiSzATDT29+Bjax8d1c1wDvZI/EBsA+RNlEC/VJJdh9xyKfqS7iJ40JzbWF3/N2R1n4Vq@vger.kernel.org
X-Gm-Message-State: AOJu0YxmU2yRh4BRhOx+SZbmEELNCtdiq7pZtxfdjlY78NNuq7fb7sk6
	fciX4F/KClUjtuOrmYbl36p+FaL0DrWDpMpxFoAh8zllY4nxqmPTs8rcFxDHKbwsiZ5xXXpcFx+
	blq9fjV/lZX+iH9NS2MBay+x9zJTIBIvewyAn8eL3MA==
X-Gm-Gg: ASbGncuhxrVT0xLbM0PkgzKHg+jVh65sU5lbDQpcXJOeiY38Xnp8TI6jBDnn0OitN+y
	Wc9ovFRE1Xrn3HG3WuMUOAUDB7tb9ch8L0m+xPSGAWIs+X6YPnlYmI9ybwQw/+0xbVD6x9ysLRn
	jlCzsjLSqbWJaeOf36YCEpeghzz29ujRVyVz5SoEWgFiFBUeakDy6kmRdpZptOqbzLpXYEQFcIt
	O+5G6KWYJtLyl625ZhWhA8XYlT3OPBFjpljyXR5cPYryoaU4gD4vnAc7V6ycm6XYqqg7AMieQTn
	zaCUgbzy4510Uzdaimg=
X-Google-Smtp-Source: AGHT+IG3KtZIvMppwUlc1+hhGf4HnZFAzuCh9/nipJX3qbxbEx1Xcv28/5uJEHFWaF3KtakxK4uZwPQchNPM4UOBZBg=
X-Received: by 2002:aa7:d992:0:b0:640:92eb:aa24 with SMTP id
 4fb4d7f45d1cf-64334d04c8emr4103361a12.15.1763110703252; Fri, 14 Nov 2025
 00:58:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
 <20251113-work-ovl-cred-guard-v3-25-b35ec983efc1@kernel.org> <CAJfpeguUirm5Hzrob=pBVgANym9wdJAEN1w7zEEuv-aW3P0ktw@mail.gmail.com>
In-Reply-To: <CAJfpeguUirm5Hzrob=pBVgANym9wdJAEN1w7zEEuv-aW3P0ktw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 14 Nov 2025 09:58:11 +0100
X-Gm-Features: AWmQ_blo-oqTHRHjnLGQ9oKOvC44EMOeiLnOmIbyPeV1nEk5zmvagZiTYche_hY
Message-ID: <CAOQ4uxgXFWHheYCMgy5DPhsk_h4qtQ6Mf+c-jYq7cv78Z31saw@mail.gmail.com>
Subject: Re: [PATCH v3 25/42] ovl: refactor ovl_iterate() and port to cred guard
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 9:40=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Thu, 13 Nov 2025 at 22:32, Christian Brauner <brauner@kernel.org> wrot=
e:
>
> > +       /*
> > +        * With xino, we need to adjust d_ino of lower entries.
> > +        * On same fs, if parent is merge, then need to adjust d_ino fo=
r '..',
> > +        * and if dir is impure then need to adjust d_ino for copied up=
 entries.
> > +        * Otherwise, we can iterate the real dir directly.
> > +        */
> > +       if (!ovl_xino_bits(ofs) &&
> > +           !(ovl_same_fs(ofs) &&
> > +             (ovl_is_impure_dir(file) ||
> > +              OVL_TYPE_MERGE(ovl_path_type(dir->d_parent)))))
> > +               return iterate_dir(od->realfile, ctx);
>
> If this condition was confusing before, it's even more confusing now.

Indeed.

>  What about
>
> static bool ovl_need_adjust_d_ino(struct file *file)
> {
>         struct dentry *dentry =3D file->f_path.dentry;
>         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>
>         /* If parent is merge, then need to adjust d_ino for '..' */
>         if (ovl_xino_bits(ofs))
>                 return true;
>
>         /* Can't do consistent inode numbering */
>         if (!ovl_same_fs(ofs))
>                 return false;
>
>         /* If dir is impure then need to adjust d_ino for copied up entri=
es */
>         if (ovl_is_impure_dir(file) ||
> OVL_TYPE_MERGE(ovl_path_type(dentry->d_parent)))
>                 return true;
>
>         /* Pure: no need to adjust d_ino */
>         return false;
> }
>

I like it.

> >
> > +static int ovl_iterate(struct file *file, struct dir_context *ctx)
> > +{
> > +       struct ovl_dir_file *od =3D file->private_data;
> > +
> > +       if (!ctx->pos)
> > +               ovl_dir_reset(file);
> > +
> > +       with_ovl_creds(file_dentry(file)->d_sb) {
> > +               if (od->is_real)
> > +                       return ovl_iterate_real(file, ctx);
>
>         if (od->is_real) {
>                 if (ovl_need_d_ino_adjust(file))
>                         return ovl_iterate_real(file, ctx);
>                 else
>                         return iterate_dir(od->realfile, ctx);
>         }

I find it very natural code flow that

if (ovl_need_d_ino_adjust(file))
         return ovl_iterate_real(file, ctx);

is inside ovl_iterate_real()
because it is literally the case of iterating real.

but if you insist that it stays out, I'd prefer:

with_ovl_creds(file_dentry(file)->d_sb) {
    if (!od->is_real)
         ovl_iterate_merged(file, ctx);
    else if (ovl_need_d_ino_adjust(file))
         return ovl_iterate_real(file, ctx);
    else
         return iterate_dir(od->realfile, ctx);
}

Thanks,
Amir.

