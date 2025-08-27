Return-Path: <linux-fsdevel+bounces-59348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25060B37E96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 11:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205261892BE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 09:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEEA3451D5;
	Wed, 27 Aug 2025 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UokXQx9O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8CF343D96;
	Wed, 27 Aug 2025 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286255; cv=none; b=aaeVkID7zcd9+ccmwcgqu9QLf8jQ2vj1ZEIDq3GlFF90tz+rpetaKdaJBCKv2b1TuTQs0UeNV2/teQk3zeJjXYVytlDFxhZjyT+s/pumj2qPjw5+rsRPScYPS9eEwRncMiphxZM13sGYS6fS8vQsMNW0dg+fwD0XZHBfB7osdJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286255; c=relaxed/simple;
	bh=BytnJqpP1bqW8sTGZWOu0la1KHMkQ4cu5koaSqQNHoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JGpV4sSWx7rMQpMxSeBfGAfPfpvUt7dp9Hi18tC2cEsJ7ir0ertx6TgL9O2kAWcEn4S24KHhHZ1zh1iMxFNP3WqRgySX776rLcRHWyawTOFpwborvuid9+QiMMTjeiEnxo4PTRULrSKJ9PPqVh6d0RJ0LLSJMkI+krMyqRLgx0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UokXQx9O; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61caa266828so1916963a12.1;
        Wed, 27 Aug 2025 02:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756286251; x=1756891051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrfNPHU7ngqdceNPHknWgwTnnVVkSv3XuCrYyWHnIU0=;
        b=UokXQx9OvjRbSrKh6e6LyqJM+vJGzK48jhWTY7uk42zjez1bUwPrsNYE7BlYfx6SG4
         9c+qe9eYXFgsgxPw5Y4ocnIFSteExztv5/cNsYnNoB8Z20WM36tbDueTa4Q+9dayr3uG
         mLXCLAR5uODp/L77gMP0zFBL+nNWK2L+KdehWB9q/l0uABam4uKamg7+j1s1bKO5a9HX
         76DXtpLSlT+wnB8Sj0H44C9qARtcyCmAxZ+OKbsNweG09tfYQO/HggKy1WMzYbQ751As
         0ZNYhhvENwgft85ph6rWsbVSO2kd7Gm6qvs74Foc6GSF472Knvi1yTpKk+0bq0YiYBC7
         NSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756286251; x=1756891051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PrfNPHU7ngqdceNPHknWgwTnnVVkSv3XuCrYyWHnIU0=;
        b=qCij+NmjhEUXm2+TJiaRjOnN0730hglRvuSkmSQGN9Yqm/mw6b06CXqJF+zGjznWlO
         Wj2/jflAR3q8SpF84HLoqU441pOrYo/sa60xUK34GN4v8BIKPbkAxXpR7pH1Wouot0as
         A9sxWknFWKnOINijBI6IYxSJjUUQogAustNiNG8Jq6OrYae1mnkxcroQygMUAhEotMSp
         YTt8Qh4fIUWDPqUXG9JYUnccDtIhOnEXBSvIjaAIkfIV6JRgeeQUhrF0ZT/K9B9pcKVw
         1NJ5b0M9aBXcPPRIDAyqzCnFUdZ1tMROmvO86nSCgSp+qB1mkO5MdnXny5kVsLsnRGO9
         6JzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnc594LX7+NVs+V6jQDznYCWb7011EuBDaxqRE/IEuc2IBWkX9OwP69OBiV9JSAWke8+u1k7Fv10xBJ+3bbQ==@vger.kernel.org, AJvYcCVfdFO8IG95DqqlQFiInHrRxtlZEDorLGTf5IihNtyc4fBgrK5XAaHtTrgOZ9ZpIP31k6Y2K62c9Wl08ZOq@vger.kernel.org, AJvYcCWz3OqK+rxCPpk+X8q/8hWt2v5Q/YJHYwRtHO8rlmoRWlAk9M25yIohzwPFMea1r7jkqFon89WzCLJjizjn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7cV/4w72/p8hQObhMb1U9oTqme/JJ62KOPVd7j+RJ4StT/dC/
	zg8eknNR7MnAWl9XdolDwHUUFi2mIt8ZTNFXXOMrsA3xdFQHkHWYLJzcgdC43UjdZGOw0nQI44H
	a5KKj1Qel3mYN/aTDI5UCwUQpkuVUM3w=
X-Gm-Gg: ASbGnctDzQEUvsetqAMJXbosB88FWef4uQWpjF+Mv8X7Q24moPH1p7saOQNg13rBu18
	M2+OzhmRYJ+icAe+EkXj4PUXQXGpLfBHQNzGh0bY1nBJ6E10noxH9YsHfBY+LSDg/rQwGjfTPAk
	w4TyOWdiOeRv0pDJXVxmnofs1ziEgiBKmgyYfuaoNAUrk1+sPrYYQNrcg0gHvuVxLUPlxl2Pti+
	yMGAMc=
X-Google-Smtp-Source: AGHT+IFL4OimFUsZvHp/dM3oAauwNI5yGL1z8+xQwucHI9//HG/YJ3F7OttMuh0xWMFteLnvnwgZW2F7NTgqp3Mvkb0=
X-Received: by 2002:a05:6402:2112:b0:61c:7ba4:8be9 with SMTP id
 4fb4d7f45d1cf-61c7ba4915emr7680440a12.23.1756286251224; Wed, 27 Aug 2025
 02:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
 <20250822-tonyk-overlayfs-v6-5-8b6e9e604fa2@igalia.com> <871poz647l.fsf@mailhost.krisman.be>
 <CAOQ4uxjexmFyfGuzuVsCmheqM_2drVsLUm3Fifv1we5u39WveA@mail.gmail.com> <bcc8ad0c-669f-4f0d-a795-ec55bb498ef7@igalia.com>
In-Reply-To: <bcc8ad0c-669f-4f0d-a795-ec55bb498ef7@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 27 Aug 2025 11:17:20 +0200
X-Gm-Features: Ac12FXxy0LxanucswszWq8MaRQwaaBPkqN0PTlaGfPkg4Vpn-Nlx-peCR6rzrTE
Message-ID: <CAOQ4uxhjPAO4S4O0ZuOqgFzw9pNSpM0BztRZNpPxoPNfCe473w@mail.gmail.com>
Subject: Re: [PATCH v6 5/9] ovl: Ensure that all layers have the same encoding
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Gabriel Krisman Bertazi <gabriel@krisman.be>, Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 10:12=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@ig=
alia.com> wrote:
>
>
>
> Em 25/08/2025 12:32, Amir Goldstein escreveu:
> > On Mon, Aug 25, 2025 at 1:17=E2=80=AFPM Gabriel Krisman Bertazi
> > <gabriel@krisman.be> wrote:
> >>
> >> Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:
> >>
> >>> When merging layers from different filesystems with casefold enabled,
> >>> all layers should use the same encoding version and have the same fla=
gs
> >>> to avoid any kind of incompatibility issues.
> >>>
> >>> Also, set the encoding and the encoding flags for the ovl super block=
 as
> >>> the same as used by the first valid layer.
> >>>
> >>> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> >>> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> >>> ---
> >>>   fs/overlayfs/super.c | 25 +++++++++++++++++++++++++
> >>>   1 file changed, 25 insertions(+)
> >>>
> >>> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> >>> index df85a76597e910d00323018f1d2cd720c5db921d..b1dbd3c79961094d00c7f=
99cc622e515d544d22f 100644
> >>> --- a/fs/overlayfs/super.c
> >>> +++ b/fs/overlayfs/super.c
> >>> @@ -991,6 +991,18 @@ static int ovl_get_data_fsid(struct ovl_fs *ofs)
> >>>        return ofs->numfs;
> >>>   }
> >>>
> >>> +/*
> >>> + * Set the ovl sb encoding as the same one used by the first layer
> >>> + */
> >>> +static void ovl_set_encoding(struct super_block *sb, struct super_bl=
ock *fs_sb)
> >>> +{
> >>> +#if IS_ENABLED(CONFIG_UNICODE)
> >>> +     if (sb_has_encoding(fs_sb)) {
> >>> +             sb->s_encoding =3D fs_sb->s_encoding;
> >>> +             sb->s_encoding_flags =3D fs_sb->s_encoding_flags;
> >>> +     }
> >>> +#endif
> >>> +}
> >>>
> >>>   static int ovl_get_layers(struct super_block *sb, struct ovl_fs *of=
s,
> >>>                          struct ovl_fs_context *ctx, struct ovl_layer=
 *layers)
> >>> @@ -1024,6 +1036,9 @@ static int ovl_get_layers(struct super_block *s=
b, struct ovl_fs *ofs,
> >>>        if (ovl_upper_mnt(ofs)) {
> >>>                ofs->fs[0].sb =3D ovl_upper_mnt(ofs)->mnt_sb;
> >>>                ofs->fs[0].is_lower =3D false;
> >>> +
> >>> +             if (ofs->casefold)
> >>> +                     ovl_set_encoding(sb, ofs->fs[0].sb);
> >>>        }
> >>>
> >>>        nr_merged_lower =3D ctx->nr - ctx->nr_data;
> >>> @@ -1083,6 +1098,16 @@ static int ovl_get_layers(struct super_block *=
sb, struct ovl_fs *ofs,
> >>>                l->name =3D NULL;
> >>>                ofs->numlayer++;
> >>>                ofs->fs[fsid].is_lower =3D true;
> >>> +
> >>> +             if (ofs->casefold) {
> >>> +                     if (!ovl_upper_mnt(ofs) && !sb_has_encoding(sb)=
)
> >>> +                             ovl_set_encoding(sb, ofs->fs[fsid].sb);
> >>> +
> >>> +                     if (!sb_has_encoding(sb) || !sb_same_encoding(s=
b, mnt->mnt_sb)) {
> >>
> >> Minor nit, but isn't the sb_has_encoding()  check redundant here?  sb_=
same_encoding
> >> will check the sb->encoding matches the mnt_sb already.
> >
> > Maybe we did something wrong but the intention was:
> > If all layers root are casefold disabled (or not supported) then
> > a mix of layers with fs of different encoding (and fs with no encoding =
support)
> > is allowed because we take care that all directories are always
> > casefold disabled.
> >
>
> We are going to reach this code only if ofs->casefold is true, so that
> means that ovl_dentry_casefolded() was true, and that means that
> sb_has_encoding(dentry->d_sb) is also true... so I think that Gabriel is
> right, if we reach this part of the code, that means that casefold is
> enabled and being used by at least one layer, so we can call
> sb_same_encoding() to check if they are consistent for all layers.
>
> For the case that we don't care about the layers having different
> encoding, the code will already skip this because of if (ofs->casefold)

Doh! yeh that was silly. I removed that now.

Thanks,
Amir.

