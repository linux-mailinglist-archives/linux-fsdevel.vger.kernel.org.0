Return-Path: <linux-fsdevel+bounces-8239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A642D831892
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 12:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D4F1C230EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 11:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0DC241FC;
	Thu, 18 Jan 2024 11:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="dogkC0Km"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A02241FB
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705577966; cv=none; b=rMsAEgpMuZBd23bPTZS/HFaOgpPIEHIq+SmGo8mxyzOIPe+HFimoX6UCid8LRp5iMyeEQUdJAz5h5BZtC+e/O8Sz1gGUmTavu8NuuhepyAHJXB86CFmRuZ7qbCifLoAGngQpKJGFzLKU9mYOnDsHPS7KHsu7XocIWZvN0QOuOFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705577966; c=relaxed/simple;
	bh=99kVtTQGqgyKdKt5z1Snj70s9KpVAmJhM85T8r2CjFA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=U6RsFQab0awLuAxvlDzfQX+1o7hPra8nqWkALtccq4SYLgfg0xqbgOMoCiCxFQs17c2/9auqbggLG5W1/41hSVT5EX4YYkVWESXFc45MqvNnT6MPEp7RyAg0RDx9lYGIiB7QAmyc3/vZj+eAnmZGjfwRdAHeVrJM8aW2138BFE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=dogkC0Km; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a298accc440so1483148166b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 03:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1705577962; x=1706182762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNpGQogZ6nMvhPzDXLu2EM0aCKz/G7JiTMEfiSYUfUA=;
        b=dogkC0KmP8yKfpA6eZMjsrSeXTdQn8nq01Z7MwT3E+MUFN5Nd5ECDdRTx0jzhdMGtL
         gzxrc1PQwi07xs4f3VejW0qYPCX0kslRDNIE8Tm1+J/TESojJ55Htq3psBBFRkEXa80J
         iL+ZCHX6WBeHjHGBksTvhx2N36woBvb+R0FY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705577962; x=1706182762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNpGQogZ6nMvhPzDXLu2EM0aCKz/G7JiTMEfiSYUfUA=;
        b=Rjlu9pWtJy6/8ngoJFM533frl/NHTW5wynfy2MNS78U9a2C/Vq4MctMhfCKu4rtfTb
         BxYVyYAuqLdiq+LIPYFs6IN5Ku+ddvmcBJpz2ZzKpikCH/DA2tzA0PIlpyuLmlXa/WKF
         ZP/hm2oZO/4sdbyjQlK0d9qscHfBWINvCTDf35z4y+jyaBIQng0g/jgyZ7IwAl7pjAOE
         Cn5WW9abVu2DFW8Nk3VAWK2pbRiDyhhBqF87mfJJKD9FxjD/4mthjAIbvRzXVLi46D8t
         WX+tQz+YdDEoMcatxo7wFzfwmvP+AMcO7QL+q/tAFOgCOXCvL4pUdZe/Xb0tVks0YgHE
         IJYQ==
X-Gm-Message-State: AOJu0Yz5QUsYPm/pKmj4RmmaGHqWU73oipM0yW36kTLynsBpsNCk+fmw
	+YO5XIXa59NflhjWF/ro3bdlXv9mxzQ4ak26SUBOaluNCdYXZJiDaLoP1D/v9+25x7eCYDG2Ul/
	o3aJ703Llrl/YYKvtYMhwmVoZk6EA1dOXJCda8Q==
X-Google-Smtp-Source: AGHT+IGIAFfQAtQ1ZkWClSLiycVAkl7NbcKu86Xz6RojZM2XBh7VfzBIdj0OHoL28DxfRZD6Y2FGWLJVxORXsBi7cBk=
X-Received: by 2002:a17:906:5ac4:b0:a2e:cf45:5a10 with SMTP id
 x4-20020a1709065ac400b00a2ecf455a10mr441879ejs.141.1705577961322; Thu, 18 Jan
 2024 03:39:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118104144.465158-1-mszeredi@redhat.com> <CAOQ4uxgB3qhqtTGsvgLQ6x4taZ4m-V0MD9rXJ_zacTPrCR+bow@mail.gmail.com>
In-Reply-To: <CAOQ4uxgB3qhqtTGsvgLQ6x4taZ4m-V0MD9rXJ_zacTPrCR+bow@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 18 Jan 2024 12:39:09 +0100
Message-ID: <CAJfpegvhWwmHXzo3dd5VYLrCjUhxAesNAha-dOB+PCP8M2rM2g@mail.gmail.com>
Subject: Re: [PATCH] ovl: require xwhiteout feature flag on layer roots
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	Alexander Larsson <alexl@redhat.com>, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Jan 2024 at 12:22, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Jan 18, 2024 at 12:41=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.=
com> wrote:
> >
> > Add a check on each layer for the xwhiteout feature.  This prevents
> > unnecessary checking the overlay.whiteouts xattr when reading a
> > directory if this feature is not enabled, i.e. most of the time.
>
> Does it really have a significant cost or do you just not like the
> unneeded check?

It's probably insignificant.   But I don't know and it would be hard to pro=
ve.

> IIRC, we anyway check for ORIGIN xattr and IMPURE xattr on
> readdir.

We check those on lookup, not at readdir.  Might make sense to check
XWHITEOUTS at lookup regardless of this patch, just for consistency.

> > --- a/fs/overlayfs/overlayfs.h
> > +++ b/fs/overlayfs/overlayfs.h
> > @@ -51,6 +51,7 @@ enum ovl_xattr {
> >         OVL_XATTR_PROTATTR,
> >         OVL_XATTR_XWHITEOUT,
> >         OVL_XATTR_XWHITEOUTS,
> > +       OVL_XATTR_FEATURE_XWHITEOUT,
>
> Can we not add a new OVL_XATTR_FEATURE_XWHITEOUT xattr.
>
> Setting OVL_XATTR_XWHITEOUTS on directories with xwhiteouts is
> anyway the responsibility of the layer composer.
>
> Let's just require the layer composer to set OVL_XATTR_XWHITEOUTS
> on the layer root even if it does not have any immediate xwhiteout
> children as "layer may have xwhiteouts" indication. ok?

Okay.

> > @@ -1414,6 +1414,17 @@ int ovl_fill_super(struct super_block *sb, struc=
t fs_context *fc)
> >         if (err)
> >                 goto out_free_oe;
> >
> > +       for (i =3D 0; i < ofs->numlayer; i++) {
> > +               struct path path =3D { .mnt =3D layers[i].mnt };
> > +
> > +               if (path.mnt) {
> > +                       path.dentry =3D path.mnt->mnt_root;
> > +                       err =3D ovl_path_getxattr(ofs, &path, OVL_XATTR=
_FEATURE_XWHITEOUT, NULL, 0);
> > +                       if (err >=3D 0)
> > +                               layers[i].feature_xwhiteout =3D true;
>
>
> Any reason not to do this in ovl_get_layers() when adding the layer?

Well, ovl_get_layers() is called form ovl_get_lowerstack() implying
that it's part of the lower layer setup.

Otherwise I don't see why it could not be in ovl_get_layers().   Maybe
some renaming can help.

Thanks,
Miklos

