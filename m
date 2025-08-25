Return-Path: <linux-fsdevel+bounces-59091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B955AB345D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 17:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97857189E496
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB65B2FA0FD;
	Mon, 25 Aug 2025 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKLPdJU0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534F6230BD9;
	Mon, 25 Aug 2025 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756135942; cv=none; b=qhqJoGHJTDr5r+FHl92VAyZ7J7PNer7oPOIOmXiCh1pyWmZK4xhaiX56gpsd2u9r30MrCEDiybXY8WN0hC0X8HF614ohvpNYPuAC9BkU88PQGCQT2FwKbXMyyDn5zIu10EUR98UAYOdQl0LrBs0MxJbvlM+/waKevwC/rVr56Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756135942; c=relaxed/simple;
	bh=mkKkB91Ur//Sd7ZyruLWG2Rnqd2IOHpf5lZzp4GiOx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tj+WutvJHtiI8zaU6pQ1dUDxWph8x+kvrfcLc7Zw6dvny/H+8+9GV21HILJ4Hzx9CRpWzP2l29qtqu1TE3H+Qwl0KdI5IvlRPzHZy/uUmWG7jw7ZWizZPrRHZy/AMlxZEA2AzBrEc4muLyqGzbZdQCyKeQ+3SNBp+9tSWoQ1AzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKLPdJU0; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61c4f73cf20so3257886a12.0;
        Mon, 25 Aug 2025 08:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756135938; x=1756740738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxQitzgjPWhUhk1K8HmrnS+PagF7LZYBblFeGO97j0s=;
        b=TKLPdJU0DOYkfyK2YxytTiZ1PD5BQHtZAvYFQgZgLJe3x4ddGQQ8MHxL7194eg2nUQ
         Q/NsEoClRaj4qOpm/6X9m0UeLV7o2LYMkfoNgyn6LWAeijbuMq8YwmwO0KwCnSjPEBpO
         ju0uLjL9T4qPaalLOmueLBc5V4sh6DlThVvIMlr6sfhqjI5yXme6tTmMUbBo3vd6GWTm
         2smgUz21fqR8iAHFg+jk+rYiPt9PgIYqdiFIL8LTltwashN1xZXFC7e4dVpj01WaATum
         AUkqmZHo5ywKu5zwGcJFFYu3MzG9wNHZMDHUGmCazxo5Gt8fnqPYhZ18Sv5/VFwUMdj5
         ErOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756135938; x=1756740738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxQitzgjPWhUhk1K8HmrnS+PagF7LZYBblFeGO97j0s=;
        b=cx3De38388aFV6hXAKH3ffB95z+gJU3y7ui7QsNzpl5AS4NrUq2HyNSfMEvsFqLtMF
         dKybt7ACrKFIb9FKfFbhQFtaeE3P74LnWoZiwchiNKZkvj4jD0wEbrqLejQrThfCPiNx
         AkPhS2rdZN4I8vaqnOZFPc4Oh4EHLJBAiJVjQgiugYx3RvvaTQERnwdGInlyu8i7+ZAx
         8ARM03HiRD0ixfSU/Jr/NSQlPD2OimtBZBDE2mzCAxiPFbhsQE6QXWxP5ZgATzE6fmAK
         c568rPLGWzLneByprtNo043XrxRs/YqtDMlq0hq9El8Qehh6qXg2PplE0Tj1DEerl9ze
         aaMw==
X-Forwarded-Encrypted: i=1; AJvYcCU/RKXC4JXkfXBqTRyzdHBbBGMvihTxVl2kIwQ1YFtVvndX0g/pfj2w/6U/PS1bpaU6l/PasJ2WAj2ldluh@vger.kernel.org, AJvYcCUkxkJ/YoqowgtmPYqrNXc16zZ51oWMGsq0Yllxbb3t6TrJrWql7KIymUJSqhd0yErktyg39RicdgvwVNvYsA==@vger.kernel.org, AJvYcCV+f2r/SYIIBAL1zAT/pSUSY4R3K0nyRb+pDrNyWTshb55VtHV5BEXdjofTsB7uPptAgL8k163tAyHSAtFk@vger.kernel.org
X-Gm-Message-State: AOJu0YxyNVx8bzil6ZKz6Gw/+v2WC3zT53WI+CzHSFRtz3T+DIa2J5OL
	Hd30ZWMCbDkmx41AewrbNtTcaQws50yhjNe+JYZ9+9B84TbEv1tx4gd73vuGVP0bC3P8kFaDhVA
	+Sloz/RXmSuPde4ZLBwdERv/SWROh8rs=
X-Gm-Gg: ASbGncviI8b2ZHdls/k82++lQmz9BJtnffC2eWS88HR0oOnJGbG6hApy8WHD8Hizerj
	wLAQrqxXo8KNH6eY0wv/bkb9zzqA15s+OigDmORvECZSL/s8G7/FzSlyttLH988d5LDzgX6mVeF
	3jmpBm5ru6WChs2NN5/lNZme7fgfidFKBuXtLKhOE3G2cIO3tULFLKCALxYL6diqrBBn7/daEvJ
	EksU2I=
X-Google-Smtp-Source: AGHT+IEZx0fDou26AjFiKS1mdtAVCp3A9wMYIP89/XpoedbOSIpF8hSUZsxiJRRR4n8kwE1OO9BARmISLY0Flb6zqcI=
X-Received: by 2002:a05:6402:90c:b0:618:196b:1f8a with SMTP id
 4fb4d7f45d1cf-61c1b3b6658mr9060811a12.4.1756135938379; Mon, 25 Aug 2025
 08:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
 <20250822-tonyk-overlayfs-v6-5-8b6e9e604fa2@igalia.com> <871poz647l.fsf@mailhost.krisman.be>
In-Reply-To: <871poz647l.fsf@mailhost.krisman.be>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 25 Aug 2025 17:32:06 +0200
X-Gm-Features: Ac12FXxiY2Kfp3umhkrg_g3f4to8stR6bh8m75fva10AnVbpR53EdWzq4Uyd51E
Message-ID: <CAOQ4uxjexmFyfGuzuVsCmheqM_2drVsLUm3Fifv1we5u39WveA@mail.gmail.com>
Subject: Re: [PATCH v6 5/9] ovl: Ensure that all layers have the same encoding
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 1:17=E2=80=AFPM Gabriel Krisman Bertazi
<gabriel@krisman.be> wrote:
>
> Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:
>
> > When merging layers from different filesystems with casefold enabled,
> > all layers should use the same encoding version and have the same flags
> > to avoid any kind of incompatibility issues.
> >
> > Also, set the encoding and the encoding flags for the ovl super block a=
s
> > the same as used by the first valid layer.
> >
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> > ---
> >  fs/overlayfs/super.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index df85a76597e910d00323018f1d2cd720c5db921d..b1dbd3c79961094d00c7f99=
cc622e515d544d22f 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -991,6 +991,18 @@ static int ovl_get_data_fsid(struct ovl_fs *ofs)
> >       return ofs->numfs;
> >  }
> >
> > +/*
> > + * Set the ovl sb encoding as the same one used by the first layer
> > + */
> > +static void ovl_set_encoding(struct super_block *sb, struct super_bloc=
k *fs_sb)
> > +{
> > +#if IS_ENABLED(CONFIG_UNICODE)
> > +     if (sb_has_encoding(fs_sb)) {
> > +             sb->s_encoding =3D fs_sb->s_encoding;
> > +             sb->s_encoding_flags =3D fs_sb->s_encoding_flags;
> > +     }
> > +#endif
> > +}
> >
> >  static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
> >                         struct ovl_fs_context *ctx, struct ovl_layer *l=
ayers)
> > @@ -1024,6 +1036,9 @@ static int ovl_get_layers(struct super_block *sb,=
 struct ovl_fs *ofs,
> >       if (ovl_upper_mnt(ofs)) {
> >               ofs->fs[0].sb =3D ovl_upper_mnt(ofs)->mnt_sb;
> >               ofs->fs[0].is_lower =3D false;
> > +
> > +             if (ofs->casefold)
> > +                     ovl_set_encoding(sb, ofs->fs[0].sb);
> >       }
> >
> >       nr_merged_lower =3D ctx->nr - ctx->nr_data;
> > @@ -1083,6 +1098,16 @@ static int ovl_get_layers(struct super_block *sb=
, struct ovl_fs *ofs,
> >               l->name =3D NULL;
> >               ofs->numlayer++;
> >               ofs->fs[fsid].is_lower =3D true;
> > +
> > +             if (ofs->casefold) {
> > +                     if (!ovl_upper_mnt(ofs) && !sb_has_encoding(sb))
> > +                             ovl_set_encoding(sb, ofs->fs[fsid].sb);
> > +
> > +                     if (!sb_has_encoding(sb) || !sb_same_encoding(sb,=
 mnt->mnt_sb)) {
>
> Minor nit, but isn't the sb_has_encoding()  check redundant here?  sb_sam=
e_encoding
> will check the sb->encoding matches the mnt_sb already.

Maybe we did something wrong but the intention was:
If all layers root are casefold disabled (or not supported) then
a mix of layers with fs of different encoding (and fs with no encoding supp=
ort)
is allowed because we take care that all directories are always
casefold disabled.

Thanks,
Amir.

