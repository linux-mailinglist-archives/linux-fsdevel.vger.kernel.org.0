Return-Path: <linux-fsdevel+bounces-10877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8777184F015
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 07:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21CE91F27654
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 06:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E596A57300;
	Fri,  9 Feb 2024 06:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMJ10+o9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D767157305
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 06:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707458736; cv=none; b=qrG/Cgid1CquPk/OGmXjOjIa2l2e2CGwltHlNc06Kq62SXf91bLVvclmqHXvFPR0OEeQVSrmv2o8RwH8RHg0yyQpS72z2mdnmPMDc98h4RoIQSxjafAFDpJyyefsVUYI4kaoj7lLwg9f/DTocvUhOqVztCUJw3Sotn3w1OIZRXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707458736; c=relaxed/simple;
	bh=cH83PS7HwdJW8FtjMj80qWZv1lEG21X3ifw1rrIx0/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=baajsPkRjawMW8D5NfQdN/+dqqwmiWVg6x1ZaQ+VkpTnh2J/D0CKtdWCht4obm2l23KZHC1GQXbfrnJa7EacIOoBoCIcyTTLo01ABsKpCIODUowPBpngsXUtHo3KU9+KQz4qmYXYCfN5Xu3d3EAMWVJlsTTjz2yPIrI95tI0Pk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMJ10+o9; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so585462276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 22:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707458734; x=1708063534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRFcZ4ndEy6kiJza1UnB91+knLXtCyyvZjJD4Xyf4H8=;
        b=QMJ10+o9di8GJCC4c5MySg2xPT4cLGAV5uFaHtZAwrlDjWHdIXLDVMq5zR6LBW0BO0
         TPG0e4SCmwRcCLnoPmdf0S+5motqTMPSuGR09rtgdbIQyUn9NFlZRZFcit3E/GwYGBd+
         S5qZR9mauu+hniKNKzGzAu0dLPkV8Khc8/AHFutME9q+plsdysVtpbgKrMWHVP3YSF69
         cAwBV9l3NGvznwy7dCDugSWq//Lc9husVvCx+0Quf7YrFOA6qY3jp2w6fICIinlHrpCo
         mOTrQkWqZ4PZggh8jUAwwu5gwMDlVlT1LUYw/hxZ6guYhQ3jsneNpaB64Zua9sg8Jq+A
         1A3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707458734; x=1708063534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRFcZ4ndEy6kiJza1UnB91+knLXtCyyvZjJD4Xyf4H8=;
        b=ZhYHOYVNxmkR0JM3w4bzbP4O+HZSGn0T+VjRKDTNmkHhpxxbjmCXuHWwi4lbVnbf9C
         s6F6WK8yEzB2JU5FEguHnYmIivPF8G58WID/Rj//W9Xy3ob3bGvABtBJ9h/OUBecvZuP
         hgIeHPBXQ4sOjg29HyYjnJkBPcTl+QciYgkZK+gA7Wz/AqZ4yyxqus0IB3iFjIzLNRM4
         Yw/8xfqBunL5Dtvt5EBtFhLvPLuzgbP5OpV2ymxgzw2jf/NTspc+kXXnH1wk92zftx2n
         zWd5Um3tBboBZKMl8g4YXf2BcWe9G5wZHPb8k5vuG7NUhxbDxN9yT99GIlevGi8LZ0Kt
         2iww==
X-Gm-Message-State: AOJu0Yy7IBe4L0llSiTSvYs15BSeNLd2n9fSeUDktLP9OxlHA59l50OG
	uQuCvFY0izC/rIAA3Tgc3H9KZ6CjvJMghkNa9++w1//60/Q9CTiJrSe+swdtCq0UmOUNJc7LysB
	/cUgI+2zv5ls3vh7LPEBKCicrxwjIoCCu
X-Google-Smtp-Source: AGHT+IEIn5NZFI/BSMEEO3XB2cPlcTghNiuUWrO0vUJJWeFGuiAaWjT+5ky/2h49wE/briObep96gHjIRYDIE2i5FKM=
X-Received: by 2002:a25:9190:0:b0:dc6:aeba:5aaf with SMTP id
 w16-20020a259190000000b00dc6aeba5aafmr499830ybl.19.1707458733662; Thu, 08 Feb
 2024 22:05:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208022134.451490-1-alexhenrie24@gmail.com> <20240208105954.tovgh4borl7qbsqr@quack3>
In-Reply-To: <20240208105954.tovgh4borl7qbsqr@quack3>
From: Alex Henrie <alexhenrie24@gmail.com>
Date: Thu, 8 Feb 2024 23:04:57 -0700
Message-ID: <CAMMLpeSyps-7QfPc5KkiLMcPC3iVnZBAw7-aAaNR3mj8BVURAw@mail.gmail.com>
Subject: Re: [PATCH] isofs: handle CDs with bad root inode but good Joliet
 root directory
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux@rainbow-software.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 3:59=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 07-02-24 19:21:32, Alex Henrie wrote:
> > I have a CD copy of the original Tom Clancy's Ghost Recon game from
> > 2001. The disc mounts without error on Windows, but on Linux mounting
> > fails with the message "isofs_fill_super: get root inode failed". The
> > error originates in isofs_read_inode, which returns -EIO because de_len
> > is 0. The superblock on this disc appears to be intentionally corrupt a=
s
> > a form of copy protection.
> >
> > When the root inode is unusable, instead of giving up immediately, try
> > to continue with the Joliet file table. This fixes the Ghost Recon CD
> > and probably other copy-protected CDs too.
> >
> > Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
>
> Thanks! I've added the patch to my tree. Just made two minor tweaks on
> commit:
>
> > @@ -908,8 +908,22 @@ static int isofs_fill_super(struct super_block *s,=
 void *data, int silent)
> >        * we then decide whether to use the Joliet descriptor.
> >        */
> >       inode =3D isofs_iget(s, sbi->s_firstdatazone, 0);
> > -     if (IS_ERR(inode))
> > -             goto out_no_root;
> > +
> > +     /*
> > +      * Fix for broken CDs with a corrupt root inode but a correct Jol=
iet
> > +      * root directory.
> > +      */
> > +     if (IS_ERR(inode)) {
> > +             if (joliet_level) {
>
> Here I've added "&& sbi->s_firstdatazone !=3D first_data_zone" to make su=
re
> joliet extension has a different inode. Not sure if such media would be
> valid but even if it was not, we should not crash the kernel (which would
> happen in that case because we don't expect inode to be NULL).
>
> > +                     printk(KERN_NOTICE
> > +                             "ISOFS: root inode is unusable. "
> > +                             "Disabling Rock Ridge and switching to Jo=
liet.");
> > +                     sbi->s_rock =3D 0;
> > +                     inode =3D NULL;
> > +             } else {
> > +                     goto out_no_root;
> > +             }
> > +     }
> >
> >       /*
> >        * Fix for broken CDs with Rock Ridge and empty ISO root director=
y but
> > @@ -939,7 +953,8 @@ static int isofs_fill_super(struct super_block *s, =
void *data, int silent)
> >                       sbi->s_firstdatazone =3D first_data_zone;
> >                       printk(KERN_DEBUG
> >                               "ISOFS: changing to secondary root\n");
> > -                     iput(inode);
> > +                     if (inode !=3D NULL)
> > +                             iput(inode);
>
> This isn't needed. iput() handles NULL inode just fine.

I tried out your two changes and the patch still works great. Thank
you for noticing and fixing those details, and thanks for the quick
review!

-Alex

