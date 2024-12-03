Return-Path: <linux-fsdevel+bounces-36309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 033CC9E1291
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 05:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C21F2827EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 04:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640E515C140;
	Tue,  3 Dec 2024 04:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGck67jD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A35817C68
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 04:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733201864; cv=none; b=bq93V9Mb8n7XvWo+7o/7t7SZhOQ+mhE/NI8Qtq+zBhyncOlpYjbPchiHwcjaifnlQcxTzpm/4ctrMrQ7/VlQzdGsM7rpf98L30KBVROcI2WR1slz2I1rdJ7oz/780sNR9V+GMTgaPzkA+CpycdwDvEB4CzW6NlPikoOjvRWgwcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733201864; c=relaxed/simple;
	bh=IkzlPNWK5jcgQ0IvdqBY6Xof9sTNvTkcwQtMNyoCZHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QeF1wQ0pBwn+o8xfCP0LZr9p4QX2Go7rAu4SH/IIU8Zd6lDOJ30HVtW7s6F869LcyA5JiD50AHUv/4Mg+qBeq0LQLDaQmUIyOWafBHPzLhBW7BjJVtdZm8U/UNC05TUe8jsOSIQPTfc1kSqoaFlAS5iXrdyUt2OY4SqW5hNTRVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGck67jD; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46690cbec70so38875181cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2024 20:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733201862; x=1733806662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NncsbFIRbhK4QVK0FQAsb87cyv5L1SUKpq6k+3UoA/w=;
        b=TGck67jDc19XseNWGbT5xoiv2B72R+RV0otrSYuAs7ektTTVTUNxjreEXdmBt8LT8G
         dleCp5ZjiWPSYa2PHmOpGRdp3lxh/qL9vHlJImr39b5RnsuPgHfKTSrW/NK5zxYb1+0o
         EgWocg1rai4R7qp+A+oOb88+SAUP+qLzR/UZoA0KG0RTUVs/EXybA058pKuXrmj0OOD9
         BLV1khZ5Z7usBfmE8UnqTt4OOH1UpplKCq7tSbC4Ij8m+Xjwut/JE0qXpif7KthZjgrS
         kexigVvVFqlQle5SEejl5UOXnyicBcSGhAAKNNQUSs6uIlwvxmehfqmQB92KHvw/Scc9
         FXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733201862; x=1733806662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NncsbFIRbhK4QVK0FQAsb87cyv5L1SUKpq6k+3UoA/w=;
        b=k3v+b1fklSux+TcJMkH9kTr5lFXJmv+Mpo0SvaFrbFcA02Iaj5lFwAOBpNu85QmYxS
         bAfusaoraoq8B/B7uptMqM/vn2JxML5ld8ey1yvmvPbo1uPFSwtuRdJzSGPB4R9g4mbw
         AveXzAy24211rAZTXVOlU5FG9ioA0eCoUtQgzp77RjkIarjPF+SB4T6u2rEojzl/iv0g
         sf0oWc7Iu71fBa8B2K759F35U0OVl5oq3ERuChpFsdVnRk2NCQdAq5beK1tux6JrhGTd
         3N7Dqplp7gB/qvnMAUK7ZuhiyHyG/k7BDITY/xbZCaOkEY5q65eTBvfs01EOztatRVRv
         DBvw==
X-Forwarded-Encrypted: i=1; AJvYcCW/IiPYYDbWZTecaefECJtsW2e1sJcsy3/UuZn1UoXMqnxReYwYnkmimwiAIvyBQYE85SEgIxfAlAWko0XZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk9nkHi6fu8JnqfHDqRlz0V6PGSJbMw3gzmqGfpzzXHB/ULULo
	CCbjex/vpoJUNJiYba/jCQk8+k8FINgnpYEUxMLWjuZIuzbAJVfD05jaGNQOd0ZavF0FVkLWCFA
	pbmGwdTQnUTkFrteQuTAyIc5ot0o=
X-Gm-Gg: ASbGncvedAAYhmlasPeVoDR/LpK3p94entTN/6BQyWr3p4APNuJtIkmZIF7XebCVVLR
	BaYAbODfzr8DmRRAxTCvVJKrR58o/Ir+RC6kjQMaI90IqoYc=
X-Google-Smtp-Source: AGHT+IEHoTvWrljA9rwVvtYW5DWGk194hMriv3Zjt1TmeGJ/O2r7zaGi77FWKAP33UDdF/SFlUl1Ae3aBRvoK1fJ0wE=
X-Received: by 2002:a05:622a:104:b0:466:aee5:a5b with SMTP id
 d75a77b69052e-4670c041feemr18526611cf.10.1733201862081; Mon, 02 Dec 2024
 20:57:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-fix-fuse_get_user_pages-v2-1-acce8a29d06b@ddn.com>
In-Reply-To: <20241203-fix-fuse_get_user_pages-v2-1-acce8a29d06b@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 2 Dec 2024 20:57:31 -0800
Message-ID: <CAJnrk1aXGqdQfDA9-JXuxdbkjUX6E5i2inxxFuQ1CuXpSmsPjQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Set *nbytesp=0 in fuse_get_user_pages on
 allocation failure
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Josef Bacik <josef@toxicpanda.com>, 
	Nihar Chaithanya <niharchaithanya@gmail.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org, 
	syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 3:01=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> w=
rote:
>
> In fuse_get_user_pages(), set *nbytesp to 0 when struct page **pages
> allocation fails. This prevents the caller (fuse_direct_io) from making
> incorrect assumptions that could lead to NULL pointer dereferences
> when processing the request reply.
>
> Previously, *nbytesp was left unmodified on allocation failure, which
> could cause issues if the caller assumed pages had been added to
> ap->descs[] when they hadn't.
>
> Reported-by: syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D87b8e6ed25dbc41759f7
> Fixes: 3b97c3652d91 ("fuse: convert direct io to use folios")
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> ---
> Changes in v2:
> - Set ret in the (!pages) condition only to avoid returning
>   ENOMEM when the while loop would not do anything
> - Remove the error check in fuse_copy_do(), that is a bit debatable.
>   I had added it to prevent kernel crashes on fuse error, but then
>   it causes 'visual clutter' (Joanne)
> - Link to v1: https://lore.kernel.org/r/20241202-fix-fuse_get_user_pages-=
v1-1-8b5cccaf5bbe@ddn.com
> ---
>  fs/fuse/file.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 88d0946b5bc98705e0d895bc798aa4d9df080c3c..ae74d2b7ad5be14e4d157495e=
7c00fcf3fc40625 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1541,8 +1541,10 @@ static int fuse_get_user_pages(struct fuse_args_pa=
ges *ap, struct iov_iter *ii,
>          */
>         struct page **pages =3D kzalloc(max_pages * sizeof(struct page *)=
,
>                                       GFP_KERNEL);
> -       if (!pages)
> -               return -ENOMEM;
> +       if (!pages) {
> +               ret =3D -ENOMEM;
> +               goto out;
> +       }
>
>         while (nbytes < *nbytesp && nr_pages < max_pages) {
>                 unsigned nfolios, i;
> @@ -1584,6 +1586,7 @@ static int fuse_get_user_pages(struct fuse_args_pag=
es *ap, struct iov_iter *ii,
>         else
>                 ap->args.out_pages =3D true;
>
> +out:
>         *nbytesp =3D nbytes;
>
>         return ret < 0 ? ret : 0;
>

LGTM!

Thanks,
Joanne
> ---
> base-commit: e70140ba0d2b1a30467d4af6bcfe761327b9ec95
> change-id: 20241202-fix-fuse_get_user_pages-6a920cb04184
>
> Best regards,
> --
> Bernd Schubert <bschubert@ddn.com>
>

