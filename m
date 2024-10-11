Return-Path: <linux-fsdevel+bounces-31743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF79999AAC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 19:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09565B213B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 17:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171911C175B;
	Fri, 11 Oct 2024 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDqF0DiR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B9C1BB6BB
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728669475; cv=none; b=CYX9U4BINaghIgAX+RXpBEn9VY1fyrntNCSSWSKYk183i4nLM8I5PfOhSy8svG99OCFPpksFVsF0bhbJCR62QLhe7OrfsEJgUv9FhQ/PkICjencDCKyV0NVX+CepnUtatMf+3HRasGrZ0+7XKlwFNcp1691ZshMrLje3Uqcmrew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728669475; c=relaxed/simple;
	bh=yB2JDZVN3ibu67jB7COqvToRjbUGooN0YOPImmiwvwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7WOEwQQc0OpzfLiJ3SaUf/gniOBNZk+H/GAbavnLbRaQ8tBthY8NjZ+Q4ZLa5kkw81xjSQMPG5QD3SaaiPnz3wjn8I41Z8XRcsUWGuzXvIwaeJZmHAbt5xFOKD1zIs/JwH/edbyn+SEh6fO99lSnyKVT/jhoUP0xKq7XPwpD1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDqF0DiR; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b10f2c24f0so228360285a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728669473; x=1729274273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0IX45qBtp7XnfaFa312GgHPMc6dJqIcmn71EIvOrHw=;
        b=kDqF0DiRVlOGVcYxr4dXOFfZGZeCw5bnvo/kr6OEh0CFGd5R2wTn+WX/mO5GWudQZm
         MSEJXG8GFzAOiaKjdqWW2/Y7lbT17ruQBEDcAHA+/5tlKyOvpEy7AsMEhA1Z1bmngQu5
         mkUvjpAzEUU1vbgmrRpq0+9Zytmv0jChlGGQXx2XB1wwsHjFol37SZ/GhFHxa7MXUHBI
         jb0pSHocYbq9XAIvfQNWmFF0Rtm2SS3q2IBdQPbdvzl7Gcp8obqB1uYczzwx/GXGNUaa
         fUFBfjhHki+0xrJk3FxTWC6DVQn4p032aWTZ9vMObCHLAybxRLAWpVlgnyWa09AfOo9i
         Nw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728669473; x=1729274273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0IX45qBtp7XnfaFa312GgHPMc6dJqIcmn71EIvOrHw=;
        b=lK9q9Pk8HcVgy1b4EeyHJd4uZsDKOhTB4N4qBcxwPCWtSqx7SqyxV+GTJhTUhgl+3l
         efSoHQ2vZKxSW1Psbn5pSoResJ5XDEHXhQWLZUji+kVj2pn2pux3xG+8HnDkRGTUvMnp
         l4o9p/yTpBvNC6hspkHe9tbLiUKV3tOnaSot4Vkup1AAOA+wiNP1tsq5fciqneIcKVbJ
         lwWy/Bnu4m3R6o/lRvML3VVsFbtY5zI0bEbE3McI7lNXjK5HNV4c+HYJOYBbVpv/AQ2Z
         MYPmfhgSqoSa3+s2dHU4SdRE/qU2mLh4eH9YMdgcxVLJZuyIGPm3aJobWh3EBqUdnuiP
         lp6A==
X-Forwarded-Encrypted: i=1; AJvYcCVhcgBBf74m2Rpoae14oGQQ3HR57U4EhWdQfWBBp+3VCxPqmgBuqiDROO2TURLOqyNjM19TrN1BTloldbxN@vger.kernel.org
X-Gm-Message-State: AOJu0YxZhn7sueWNZNVycBx5hop8m5hhRA2/W4+A/LFZGSxRwLouzkeQ
	B2HPJjE3R4vEsBiob1mUOZzkkpvk1XVmLv9rsbBgTZDMtkNWgJy/3vTj6qqajoIa9DjSbmuoXLX
	ZvvQJwDaQK8a+QtU7fHRdFX28zW0=
X-Google-Smtp-Source: AGHT+IGScK50AMe6YiNNsStFf8LWJ57RRMW7ynYb9rCeSWgEkYimZdr5P8J/aUSBtTUQG7GSS7gn9RUqhJ067Ce3IlQ=
X-Received: by 2002:a05:620a:28cc:b0:7b1:11f4:d0af with SMTP id
 af79cd13be357-7b120fc3e21mr53510485a.29.1728669472866; Fri, 11 Oct 2024
 10:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011135326.667781-1-amir73il@gmail.com> <CAJfpegsvwqo8N+bOyWaO1+HxoYvSOSdHH=OCLfwj6dcqNqED-A@mail.gmail.com>
In-Reply-To: <CAJfpegsvwqo8N+bOyWaO1+HxoYvSOSdHH=OCLfwj6dcqNqED-A@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Oct 2024 19:57:41 +0200
Message-ID: <CAOQ4uxj1LjzF0GyG3pb+TYHy+L1N+PD59FzBUuy0uuyNLgW+og@mail.gmail.com>
Subject: Re: [PATCH] fuse: update inode size after extending passthrough write
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org, 
	yangyun <yangyun50@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 4:25=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Fri, 11 Oct 2024 at 15:53, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > @@ -20,9 +20,18 @@ static void fuse_file_accessed(struct file *file)
> >
> >  static void fuse_file_modified(struct file *file)
> >  {
> > +       struct fuse_file *ff =3D file->private_data;
> > +       struct file *backing_file =3D fuse_file_passthrough(ff);
> >         struct inode *inode =3D file_inode(file);
> > -
> > -       fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
> > +       loff_t size =3D i_size_read(file_inode(backing_file));
>
> What about passing iocb and res to ->end_write() instead of just the
> file, so that we don't need to touch the underlying inode?
>

I considered that. It was like this in one of my older versions.

But why do we want to avoid copying attributes from the underlying inode?
If anything, I thought that we would want to get closer to ovl_file_modifie=
d()
for backing inodes in some situations like this one.
I understand that brute copy of attributes is a problem, but I don't see th=
e
problem with i_size =3D max(i_size, i_backing_size)

Can you explain the problem?

Thanks,
Amir.

