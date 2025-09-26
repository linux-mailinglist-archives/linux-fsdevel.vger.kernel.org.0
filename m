Return-Path: <linux-fsdevel+bounces-62851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBBCBA25FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 06:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6904A1C03166
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 04:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2596274670;
	Fri, 26 Sep 2025 04:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHTQN0nP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6809027281E
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 04:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758859982; cv=none; b=FP9gz1+ELfIwIHVQfy45GpGnFozV0YciAYiUpl+ylxX8o/3iOoqLfMLSp+RIPM/ACZg5ogvTeVjXk4sLv848ZlBDQ2NocOu93JVkYV4VHrAXgFScr9K9PMO5mtFjsKH9UN0In/xyFZR5U8GUF03W+kvy1E+BwG7jvhvQwAHE7z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758859982; c=relaxed/simple;
	bh=ZgDP20QZkDLxRO/Zf2PvAxrgdmOoIcYDVez/we6Bvqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTg0779pIpxqc7gwic4cULeBjHUJsFdivL9ExdC7FNFjzrYO8PfZIqXgGhAonNM7Hs9C03VDVemWCgyfiXSz205YpIaJEgIvJeU3tC3wxiBoiaNh0vQfw7/4ff3igmUJmMen6j0ef+qshZ3yU/HqVmLXHMZPnAsuz5GjI3EipG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHTQN0nP; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-35c80c1dc3fso987939fac.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 21:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758859979; x=1759464779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNU0Pwk/sruPgAj1NUB1U8UjS7o+0ae15IZer1EFVJI=;
        b=AHTQN0nPrhUy1xrZPA7kt7RtHAJljwRfjHy7m2nERzWciFys2/sFCRmCB6MOd6+xTg
         jcHpoa6R8g1DfJiQiIFIY+HlVnyti4T3vmBIEgYqMTcbTmzUGeWR1tiTRhEec9pQuMYZ
         akA/jMnVYq/kDWW/anDyRAVEDBW2eoAyBtewGsQJduyj9+ty1ZfM4fPni1GchySi4Vgn
         pl5q5Q83asg36bMMNe+d8iGVkMY+aghklJ4rR45GtxKVYPC11U9esYU4J6UHNm5Bidkt
         Ylr3pKw9FovUQUKAYiHlu7OXacGB5pFWW7FGl+T6ikeLUJZKVejLCv2upBxb2wG3lNf0
         oYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758859979; x=1759464779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNU0Pwk/sruPgAj1NUB1U8UjS7o+0ae15IZer1EFVJI=;
        b=Zw6Vk6JOxjD350c5h77Ucyf4kooiS4Ot+cuxDTwfSOqE3Gr2Wlq+g8kztbrLerKXbZ
         /97lAiiEtH/DBgZExxsWF7uP5ixvMucbPVOx6RM3ReEya5PQ9O3uyvhy61OkTFrVcj7N
         ZuS/Ddc3LT5nAK7G8HgJtCnGqmCsSAVskOzmAjv/UC2KFmLEFUaySf3VguvkKc6xfoCv
         DD+lCklLEGDY+VFAQ6NOZ+i0AOCee/tub4guevkCTE7QWLf/Wzj9SW0k2MKzYnepCa3Z
         SmZPa+KIM2a9ziUSUdiE29jaCK7NJn56NqEgWKuTxKNBs39Qg/PW3yKuvr523/j6Cfs5
         362g==
X-Forwarded-Encrypted: i=1; AJvYcCUH4KbsyoOTY5kejQXvyikD42HYMR4CM9/bhKfJsxWrdHTp9CFlZFLdLzKYp3EprpBKJ/QaBtYMD1N++krd@vger.kernel.org
X-Gm-Message-State: AOJu0YwZQm2r4v0ol41lNKu0otvbkXweQeIOAh8iaPXd8CBpdzXuadAt
	xMK9CXMEQNKtGLzcxufQOdqyyfvSIA2UIKcPK3zij7ziRWcxazb674jK/w/pMczhkEroTjcF/V8
	+FRwe5RcxekhJPioG3YQdPaXARf2KISU=
X-Gm-Gg: ASbGncu3eOnIFmG3YVPqe6N7DGcxxpfkcpO0Y6ttfC7x2udK6aqErjfgbp4VnBktSIt
	JHXkSARUKRz1zwspiF9PfhGfY5pQ3N5bRrAyxxPJac6UTXatMaQvNXri56MyFFSXH8meFFDS7Ne
	nLoPEl5fi6sBbpq33yKeO8cPJ+oU96yQBcOTJR8d/pg0liZwIKl946sHaC3ptKlLH26yFY6Of2z
	OezjEJZNYIFeTQ=
X-Google-Smtp-Source: AGHT+IF2ZSJ0PrOhWP3a1p4MhkScvlDxoQUucLjRYTyu2MZcrSzqJaOddDFaJ/50vInQg5NruTmFTTV848f/yACaHPo=
X-Received: by 2002:a05:6871:727:b0:321:2680:2f84 with SMTP id
 586e51a60fabf-35ec39ea6acmr3084580fac.3.1758859979411; Thu, 25 Sep 2025
 21:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PUZPR04MB631693B0709951113DC1B8DB811EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB631693B0709951113DC1B8DB811EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Fri, 26 Sep 2025 13:12:48 +0900
X-Gm-Features: AS18NWAfThZtIbiyKqe5drvdHRAySJdCuOByBkseSv9nGn7WNaJ-8PUNGWI30q8
Message-ID: <CABFDxMEwSNh4Uhit_uPugJe5uyz_w9JfrgZ7qvVJZziUcdVXJQ@mail.gmail.com>
Subject: Re: [PATCH] exfat: move utf8 mount option setup to exfat_parse_param()
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "linkinjeon@kernel.org" <linkinjeon@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 12:40=E2=80=AFPM Yuezhang.Mo@sony.com
<Yuezhang.Mo@sony.com> wrote:
>
> On 2025/9/26 2:40, Sang-Heon Jeon wrote:
> > Currently, exfat utf8 mount option depends on the iocharset option
> > value. After exfat remount, utf8 option may become inconsistent with
> > iocharset option.
> >
> > If the options are inconsistent; (specifically, iocharset=3Dutf8 but
> > utf8=3D0) readdir may reference uninitalized NLS, leading to a null
> > pointer dereference.
> >
> > Move utf8 option setup logic from exfat_fill_super() to
> > exfat_parse_param() to prevent utf8/iocharset option inconsistency
> > after remount.
> >
> > Reported-by: syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D3e9cb93e3c5f90d28e19
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > Fixes: acab02ffcd6b ("exfat: support modifying mount options via remoun=
t")
> > Tested-by: syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com
> > ---
> > Instead of moving `utf8` mount option (also, can resolve this problem)
> > setup to exfat_parse_param(), we can re-setup `utf8` mount option on
> > exfat_reconfigure(). IMHO, it's better to move setup logic to parse
> > section in terms of consistency.
> >
> > If my analysis is wrong or If there is better approach, please let me
> > know. Thanks for your consideration.
>
> It makes sense to put settings utf8 and iocharset together.

Thanks for reviewing, Yuezhang!

> If so, utf8 is also needed to set in exfat_init_fs_context(), otherwise
> utf8 will not be initialized if mounted without specifying iocharset.

Oh, I missed that point. I'd prefer to extract setting utf and
iocharset both to a tiny function, and then call it both
exfat_param_param() and exfa_init_fs_context(), then we can prevent
inconsistency between two values. If you don't have any other
opinions, I'll make a v2 patch this way.

> > ---
> >  fs/exfat/super.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> > index e1cffa46eb73..3b07b2a5502d 100644
> > --- a/fs/exfat/super.c
> > +++ b/fs/exfat/super.c
> > @@ -293,6 +293,12 @@ static int exfat_parse_param(struct fs_context *fc=
, struct fs_parameter *param)
> >       case Opt_charset:
> >               exfat_free_iocharset(sbi);
> >               opts->iocharset =3D param->string;
> > +
> > +             if (!strcmp(opts->iocharset, "utf8"))
> > +                     opts->utf8 =3D 1;
> > +             else
> > +                     opts->utf8 =3D 0;
> > +
> >               param->string =3D NULL;
> >               break;
> >       case Opt_errors:
> > @@ -664,8 +670,8 @@ static int exfat_fill_super(struct super_block *sb,=
 struct fs_context *fc)
> >       /* set up enough so that it can read an inode */
> >       exfat_hash_init(sb);
> >
> > -     if (!strcmp(sbi->options.iocharset, "utf8"))
> > -             opts->utf8 =3D 1;
> > +     if (sbi->options.utf8)
> > +             set_default_d_op(sb, &exfat_utf8_dentry_ops);
> >       else {
> >               sbi->nls_io =3D load_nls(sbi->options.iocharset);
> >               if (!sbi->nls_io) {
> > @@ -674,12 +680,8 @@ static int exfat_fill_super(struct super_block *sb=
, struct fs_context *fc)
> >                       err =3D -EINVAL;
> >                       goto free_table;
> >               }
> > -     }
> > -
> > -     if (sbi->options.utf8)
> > -             set_default_d_op(sb, &exfat_utf8_dentry_ops);
> > -     else
> >               set_default_d_op(sb, &exfat_dentry_ops);
> > +     }
> >
> >       root_inode =3D new_inode(sb);
> >       if (!root_inode) {
>

Best Regards,
Sang-Heon Jeon

