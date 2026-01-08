Return-Path: <linux-fsdevel+bounces-72825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CD0D03EEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8B113434CD2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEF43F0777;
	Thu,  8 Jan 2026 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiWLMvkF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C880E13FEE
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 12:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767874441; cv=none; b=gbYUvCqpU9JXJbwI2Y+HuV6kFnS+wMbRfAspCQpKqNk0ONkW6wixTPBwzeoVQLFXoaK+avGoKaw1IPHz3Ii2YSesHByTDE30GcZytAywU+ekmOu0KQbA3cw9Jjm+IJaUbx+3Mo1ocWm+jJ1a5LTW9gz4eWX5t5k/9ziDI0yZP6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767874441; c=relaxed/simple;
	bh=u0Rfh59JjBvib8jxFGPAzoq3QQzoRj4RCMEQjAlnJnU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YdgMx8fGG+HwrddR41ZwhA586BwbW81zHfG2fqZBLVZp5QvLAy1C+2umM/+ydriid2okzxQGsY5n2Ca1sgxk6RUr81YqlsbKfa8DVP/KB+oe0RGfniDEObLo1F9kMJgk2N9kWA2YS7fX+KsdkZNdnQ3Bv5QU4KTpKgsvyut9IVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiWLMvkF; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59b710d46ceso1751015e87.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 04:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767874429; x=1768479229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWXsVjPSBACvOUrTWUoZ6i3cfhSX/bnB+GsdyHt4Nog=;
        b=RiWLMvkFvtaKRyO7JmDmUW5gcVOK5RNnf4fjHibwoECzHCqjKrTyuBkQwEBbXBwMDN
         VPAiQ4xW2Rl/E/cG9jU480Go+emlkF1v4zduh3UPsZbWM61Izcwqy3WKoFMxQtd6HOY3
         AbRp/xfwl5FDiZh5Hb5KC/H8E6KoIlDnB3skMfhkNaaTZfZmy5qbtFm34jAJBaAH8Xuc
         4Tk4QYEJYlroh6wHdYd0pJoA0hFn9kNg7gTR2diuEKMbEDJ7uG85gSNRAzi+FnaDH6/F
         dJiVj+duCTFLf3PlF4XUeLTDRLjVgkjNQyiyKAIVLgbJdBKoPe/CSWbWCyoPh6y2Oyme
         WD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767874429; x=1768479229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xWXsVjPSBACvOUrTWUoZ6i3cfhSX/bnB+GsdyHt4Nog=;
        b=aGeG9VT5GxKsGojloRmND4b2YeBymWo4v3VACdDAB+XPDluyC05kyPPfU9G/NhzmAJ
         lZ8e/+HFF48RauFCpA3MF6l7ZiPYgeCeg3wRZbFfVVKym7A7FSaWZgbvvnhwtPpIKLQp
         U2/YM0mg+O+2Ci/nWjKekUpWzCYojkUa6ZaLUp3YkzKiRuPk7CB8nLQGwDskS8A6x3fD
         CX4Z/ejzUz5N6a14krYJIHoUDWyKyOzTIIbEemSVNz5pXbHhT1Ht6c9fdk+tKB4EB8/3
         J7VJFoZj9PTFItEqr257PohTE8O9WoN8H/puhIp3uFsjGDdnFXanQptK93pADMc+oEBB
         r/VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfpDLBs3LiIYtbrKjqGaRFd2lWlcNP2aXRl3ElwzzhDnIQG8/7zxpeV6EwbR/fFZW02DMW+4HQiBUmFN7y@vger.kernel.org
X-Gm-Message-State: AOJu0YyMwSCU0hA/ThdM+V9UVhq1ecmmQ2NUC9mDpYW2I59wSAWSgBmx
	h/7p1jCxVnzNOj24vaI6T6IYfmZLG0CKpLbbzoUE0W9ha8Fkp8wKdyvc9GuxdA==
X-Gm-Gg: AY/fxX44KEcYa9yEfVFBKhmVgYgyBR3fpECNWDTTQzFb5Pl5yHjCte6KAELQWx/pYnQ
	WdzLBctQ/M2Aub2B047onqjFTuVW90kwwhPEaNZv0Amib3nYg0mF+uw0oE2Bkrckm5Y98NNz72z
	+tVVOc8ktRx1AdcjaLAF4DkzTBgmn9UzPfDeNq0ptgVwyym+1NbNo1ASqUmj5duBZxrQHVk8UKU
	XDU93jgXVu4ESGhnSr7RnjozOI45Rkgt11F6aY8hHouR5tIFQJxZeSPltNg4+/caRHH1xKEiu7P
	KBt6/dM2MX6QSzzYIgDCunCZFVtv9jfOtI8Dboxhaj05NCdvx+RgJ44eTDPag0fwOlCdW99XO/y
	dCeWJz4eIlyXe1smkdSg04tvkjIqIXqnP5Dp7lSzCu/LDZnV36Rd4/RnEHN5BjfZpJDvXlfUwOb
	cxaNN2S29l3LK0f7KtYP+G/6QRq4qjNxcOQUdOviFMApsFhdOg2aCB
X-Google-Smtp-Source: AGHT+IFmC/s2zmdOBadT/g4NYT+5EdU6A/sY6V1s9b9j38zaQ6W1AyyE0nBMoGSOz8ZyH3UraVUgxg==
X-Received: by 2002:a05:600c:4f53:b0:477:7991:5d1e with SMTP id 5b1f17b1804b1-47d84b3860fmr58019005e9.25.1767867978798;
        Thu, 08 Jan 2026 02:26:18 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee870sm15478511f8f.36.2026.01.08.02.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:26:18 -0800 (PST)
Date: Thu, 8 Jan 2026 10:26:13 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Sheng Yong
 <shengyong2021@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Dusty Mabe
 <dusty@dustymabe.com>, =?UTF-8?B?VGltb3Row6ll?= Ravier <tim@siosm.fr>,
 =?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>, Alexander Larsson
 <alexl@redhat.com>, Christian Brauner <brauner@kernel.org>, Miklos Szeredi
 <mszeredi@redhat.com>, Zhiguo Niu <niuzhiguo84@gmail.com>,
 shengyong1@xiaomi.com, linux-erofs mailing list
 <linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH v2] erofs: don't bother with s_stack_depth increasing
 for now
Message-ID: <20260108102613.33bbc6d4@pumpkin>
In-Reply-To: <4b427f6f-3b26-4dc8-bf6f-79eeabf6ba84@linux.alibaba.com>
References: <0c34f3fa-c573-4343-b8ea-6832530f0069@linux.alibaba.com>
	<20260106170504.674070-1-hsiangkao@linux.alibaba.com>
	<3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
	<41b8a0bb-96d3-4eba-a5b8-77b0b0ed4730@linux.alibaba.com>
	<121cb490-f13a-4957-97be-ea87baa10827@linux.alibaba.com>
	<CAOQ4uxg14FYhZvdjZ-9UT3jVyLCbM1ReUdESSXgAbezsQx7rqQ@mail.gmail.com>
	<4b427f6f-3b26-4dc8-bf6f-79eeabf6ba84@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 8 Jan 2026 16:05:03 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Amir,
>=20
> On 2026/1/8 16:02, Amir Goldstein wrote:
> > On Thu, Jan 8, 2026 at 4:10=E2=80=AFAM Gao Xiang <hsiangkao@linux.aliba=
ba.com> wrote: =20
>=20
> ...
>=20
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
> >>>> Any thoughts to handle such scenario? =20
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
!sb->s_bdev) || =20
> >>
> >> Sorry it should be `!inode->i_sb->s_bdev`, I've
> >> fixed it in v3 RESEND: =20
> >=20
> > A RESEND implies no changes since v3, so this is bad practice.
> >  =20
> >> https://lore.kernel.org/r/20260108030709.3305545-1-hsiangkao@linux.ali=
baba.com
> >> =20
> >=20
> > Ouch! If the erofs maintainer got this condition wrong... twice...
> > Maybe better using the helper instead of open coding this non trivial c=
heck?
> >=20
> > if ((inode->i_sb->s_op =3D=3D &erofs_sops &&
> >        erofs_is_fileio_mode(EROFS_I_SB(inode))) =20
>=20
> I was thought to use that, but it excludes fscache as the
> backing fs.. so I suggest to use !s_bdev directly to
> cover both file-backed mounts and fscache cases directly.

Is it worth just allocating each fs a 'stack needed' value and then
allowing the mount if the total is low enough.
This is equivalent to counting the recursion depth, but lets erofs only
add (say) 0.5.
Ideally you'd want to do static analysis to find the value to add,
but 'inspired guesswork' is probably good enough.

Isn't there also a big difference between recursive mounts (which need
to do read/write on the underlying file) and overlay mounts (which just
pass the request onto the lower filesystem).

	David

>=20
> Thanks,
> Gao Xiang
>=20
> >=20
> > Thanks,
> > Amir. =20
>=20
>=20


