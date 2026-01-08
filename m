Return-Path: <linux-fsdevel+bounces-72802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B524FD01BF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 10:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9A1337EA651
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 08:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E56F3624D1;
	Thu,  8 Jan 2026 08:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvYKfiFc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C84635BDA6
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 08:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767860672; cv=none; b=qdX+D2rvROw5TUNzAu4d/xR3gsWRX+BnRYnB0TJ4czK/6Yy7vF72lc8PBq/V5vZUmAOeAgZRk/rn8KwtrVw0vU5TqMx0gomMMwgIIrA4VzCaAaPtlIA6NXLV4WE0t0K2FeigeOHXnKJo3vYCXLtexHjqRdb65CcT6rfpLEq3o0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767860672; c=relaxed/simple;
	bh=pZRdMpJGOsjy74uDFjTdLpYm7MaofGdtP+epg3VJAVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7ZqRsakNQOcel2CsGFf19uKW4UbhhtHvb/mKtTA2GfqGZDjybhjisx7oxrUTD1Yc9gyOggookg2xvpBZYRbAV3J5UTQx3zF60v17JLz8ROh/VlV/7F//s1r877k+vsX1elg5Gdo4DccCCnqpSiZesDFqfDaGDd6CxfCP2KWdZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvYKfiFc; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-650854c473fso3191602a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 00:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767860663; x=1768465463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0kq/g9rXrnPRB1mSfblx8o9bXq8xp0GPwblM8E2qws=;
        b=HvYKfiFcFiDzGeXLku02RTLosqpvElClwQ54TNK6/ojMG6T4R93yR2c2FHLByc8yRs
         plyF/UKirR4X2jcRh0usBkZvtUCxnKXFzvOLHCeZeeE8tFPm4qdqkCHNvww7QcujNsIf
         ZkGwglXxvDIXLanpB2zwd52BJeGX+IF722RKiYzge4Vx+Z/bCHHa/xxb4Nuy/9+JcgLE
         eKVwkfxRvcCU8b0Ej6qA6/O5VL5+Y0r0MfuwKlKFoR2C/9qDpIvIYoH0CQwZivvI7awf
         R4/nCvKX2FuDV22DZXZXxuSlA52WOa94x7DxoiKCBGqa+PkU508lIAeJInjqFUvwSaLy
         gUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767860663; x=1768465463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M0kq/g9rXrnPRB1mSfblx8o9bXq8xp0GPwblM8E2qws=;
        b=eHx3X/5/GrzLdXDZzgBb5WT4Dp7z/gu9JWEoFKuDPI7KQKo954W3dDQphu87iJLfP2
         KKeWfAr2wKZKyit5eu4fPISO+7drGoUwXup9qveaxiyuGnVHmsn7Fzr/+N8CFmNb7sVH
         3/wwmqogybNkfGNzvQbbLWfMmNl/tZGscRZuOmu9IW7CLtvMHCPallr3uFPygFEfodVS
         2RLe5gcB7OeQczT+tNsjCKGh/X7GyEJ++mfEcO8D3y71T34MDacQM6N2oAW0pgTLMDB4
         7a3/Q6Se2Zf2TiibwwYhZ6+4p/L3I9Nj2docS7272B0Y6VcQmC0O4jy/aOLas8HhkXEu
         O1ow==
X-Forwarded-Encrypted: i=1; AJvYcCUuKFDQrEK3Ldi6xTRStu0MVY3gBvW+IkdjBrJoBbTDYftOm2yyF+/FosrNZFjXt7DRxbcnyDaleY7gseM0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5EagF75YHE0/K0jQUFzueKOolU0o0UTX94pHiW7WCPg5d0DRv
	kR7/vgpUp+HVls27bzUVrmUBf3XILLSIbGab05Knn/0z7dRlvNJlbhwCPEUH5ybEVezQBAqXx5c
	2hFQyoxuLQY5qjIBe6Obkp+KGTXiv2bY=
X-Gm-Gg: AY/fxX6xz32jePLNCMvlUx0i+b5JwkIiJZgDlkgeR+NEti5szdQShaNIEdzIxB0LbIm
	qUKSI1apVYK/5iiBaUNvT1xgBZqqBXL0PoYlbn1Qic9Z1J4Osih8KdjsiNz5pzOQkPp3aR5ACmd
	yyd+8XhG6yKSeTzJWW+NrkDzJ6l9S2rueZcFbmq/wHluLVUldSiF8jcAADA23Y0t+vpOICH6K9X
	giKej8Jl0PzgOU/nqxu9+Up+PeVewbzEkFB6ut8ucj/QzUFWT+Re1lPSiSGgE0HfQxU4XAeM8Oz
	YJ+zitkSFzfXuhdrDCjOATktD8BnNw==
X-Google-Smtp-Source: AGHT+IGoaDJdrNiEO09pR/OORz2MGC83dXHXdXNvH/C4hxxitjeNsDGXBBSuI3R0yPFQlvG//M05OkqNUDp2Cj1iTkE=
X-Received: by 2002:a05:6402:1288:b0:641:88ff:10ad with SMTP id
 4fb4d7f45d1cf-6507c16e5e4mr6233151a12.14.1767860662681; Thu, 08 Jan 2026
 00:24:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0c34f3fa-c573-4343-b8ea-6832530f0069@linux.alibaba.com>
 <20260106170504.674070-1-hsiangkao@linux.alibaba.com> <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
 <41b8a0bb-96d3-4eba-a5b8-77b0b0ed4730@linux.alibaba.com> <121cb490-f13a-4957-97be-ea87baa10827@linux.alibaba.com>
 <CAOQ4uxg14FYhZvdjZ-9UT3jVyLCbM1ReUdESSXgAbezsQx7rqQ@mail.gmail.com> <4b427f6f-3b26-4dc8-bf6f-79eeabf6ba84@linux.alibaba.com>
In-Reply-To: <4b427f6f-3b26-4dc8-bf6f-79eeabf6ba84@linux.alibaba.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 8 Jan 2026 09:24:11 +0100
X-Gm-Features: AQt7F2pT46wOe25cGycGlgDH7NaWTRhLN1cxNTMu4Gtag81pzvR2eU0rUU1V1nU
Message-ID: <CAOQ4uxgcbauFza8ZsZebhTZJT-zwfydy2ofWOw-hqJbVRF+GCg@mail.gmail.com>
Subject: Re: [PATCH v2] erofs: don't bother with s_stack_depth increasing for now
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Sheng Yong <shengyong2021@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Dusty Mabe <dusty@dustymabe.com>, 
	=?UTF-8?Q?Timoth=C3=A9e_Ravier?= <tim@siosm.fr>, 
	=?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>, 
	Alexander Larsson <alexl@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Zhiguo Niu <niuzhiguo84@gmail.com>, shengyong1@xiaomi.com, 
	linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 9:05=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
>
> Hi Amir,
>
> On 2026/1/8 16:02, Amir Goldstein wrote:
> > On Thu, Jan 8, 2026 at 4:10=E2=80=AFAM Gao Xiang <hsiangkao@linux.aliba=
ba.com> wrote:
>
> ...
>
> >>>>
> >>>> Hi, Xiang
> >>>>
> >>>> In Android APEX scenario, apex images formatted as EROFS are packed =
in
> >>>> system.img which is also EROFS format. As a result, it will always f=
ail
> >>>> to do APEX-file-backed mount since `inode->i_sb->s_op =3D=3D &erofs_=
sops'
> >>>> is true.
> >>>> Any thoughts to handle such scenario?
> >>>
> >>> Sorry, I forgot this popular case, I think it can be simply resolved
> >>> by the following diff:
> >>>
> >>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> >>> index 0cf41ed7ced8..e93264034b5d 100644
> >>> --- a/fs/erofs/super.c
> >>> +++ b/fs/erofs/super.c
> >>> @@ -655,7 +655,7 @@ static int erofs_fc_fill_super(struct super_block=
 *sb, struct fs_context *fc)
> >>>                    */
> >>>                   if (erofs_is_fileio_mode(sbi)) {
> >>>                           inode =3D file_inode(sbi->dif0.file);
> >>> -                       if (inode->i_sb->s_op =3D=3D &erofs_sops ||
> >>> +                       if ((inode->i_sb->s_op =3D=3D &erofs_sops && =
!sb->s_bdev) ||
> >>
> >> Sorry it should be `!inode->i_sb->s_bdev`, I've
> >> fixed it in v3 RESEND:
> >
> > A RESEND implies no changes since v3, so this is bad practice.
> >
> >> https://lore.kernel.org/r/20260108030709.3305545-1-hsiangkao@linux.ali=
baba.com
> >>
> >
> > Ouch! If the erofs maintainer got this condition wrong... twice...
> > Maybe better using the helper instead of open coding this non trivial c=
heck?
> >
> > if ((inode->i_sb->s_op =3D=3D &erofs_sops &&
> >        erofs_is_fileio_mode(EROFS_I_SB(inode)))
>
> I was thought to use that, but it excludes fscache as the
> backing fs.. so I suggest to use !s_bdev directly to
> cover both file-backed mounts and fscache cases directly.

Your fs, your decision.

But what are you actually saying?
Are you saying that reading from file backed fscache has similar
stack usage to reading from file backed erofs?
Isn't filecache doing async file IO?

If we regard fscache an extra unaccounted layer, because of all the
sync operations that it does, then we already allowed this setup a long
time ago, e.g. fscache+nfs+ovl^2.

This could be an argument to support the claim that stack usage of
file+erofs+ovl^2 should also be fine.

Thanks,
Amir.

