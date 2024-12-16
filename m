Return-Path: <linux-fsdevel+bounces-37567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B49299F3E46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 00:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F46188CFFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 23:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC801D6DB7;
	Mon, 16 Dec 2024 23:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mp2ysIy1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB510139CEF
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 23:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734392185; cv=none; b=sc7y8WweKaClFKL5Cn3FeCBiURNdhQMe5rGeNmeLl7BuwK5z6RGmsmNLIAm5CAfNJwfb4cggoAzB7Kp+DhZ9CSKJ0yFVzbpWAZNMplTVYohKsPANFgn8AxW9+eRHzgbdtKhBB+GOwX+FjdPl9NW5hOeVyXQk67CAYKNLJ4FumO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734392185; c=relaxed/simple;
	bh=9pfkzrTacufylNsr7bTMcalGY+wCq7Nx1FjunqwncEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3vskOOge2G6Nbuf4M7mn8eVF0GWjb5QPbCBhTUdbBD0rihTmhufjRB1S52E3O0co8uQXYhjcAJAtEBvtQPCIZeO6gsmbbmBqC1LCHB1J6vt7W7Gru7ryKTNU2l6d6HlaSUjVkBZ0hvWDMqWXWnkEgy8mHICDTN+bOWafEFNYwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mp2ysIy1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F24AC4CED7
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 23:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734392184;
	bh=9pfkzrTacufylNsr7bTMcalGY+wCq7Nx1FjunqwncEY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Mp2ysIy1w0Up16egt1Teudif0us3ygVYd18PgnZZex7P43at3h+jDfQf61DcvhZFC
	 TKyliKaLR4mDFReeaMQ/+ybQt4s2FQHMKdK+Z3ifLLlOeCZaE3tBlcEx7wt4pmbBku
	 WnHwnMlyedTzpLgZ9SKAgmVEd/4IlAijcGR+sseYDZ+k8MGZ84Ste9dr2azkd+89Tt
	 rZwBp2n8WAv9gMAU7Y/LHTC3y8q/b0yiMqoEFyGa9dvE0SmOrVp5GP2mbquBV+nDC8
	 k9+OneF83pqUHxSuTeRq508V5UiCA3LrhZ1F+0No2rz316aGNrVnxCBqBi2AAihnWa
	 f0q5DQdjyECEg==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71e3167b90dso2148494a34.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 15:36:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWdR2PVkP3lZ6/rjTcpRhimDfadrYxbNB7JkY1AZxEyWkduwFfW0lXmtkYc/SM+aEDR6kOKaaawfatoGcS/@vger.kernel.org
X-Gm-Message-State: AOJu0YzTYfBUUYgRI0bWV/ekJxwgMPNspacMqw2Us3iYLKw+PeHPi6jG
	ED//p71wPzA1be9IHJzdjARaGw+PpR8+duvxrmwdaSFM3kRIFeQUaGJu9J6OuLarTvxeKa3y9KJ
	+3iAot0j5CElMFK3YcPZdfR4nwEQ=
X-Google-Smtp-Source: AGHT+IESkyyskfG8YisQEjc4So10n71vC07Xf8sp0jmWdFTkrui9EoLsITgLGBjd4l4SLR1qvup4CLfJc32nNuUAJ2I=
X-Received: by 2002:a05:6808:2227:b0:3e7:60bd:8b06 with SMTP id
 5614622812f47-3ebcb28412bmr410242b6e.16.1734392183792; Mon, 16 Dec 2024
 15:36:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213161757.1928209-1-dmantipov@yandex.ru>
In-Reply-To: <20241213161757.1928209-1-dmantipov@yandex.ru>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 17 Dec 2024 08:36:12 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8FQDrnX-xAEAH3be_-Ezw2d3iiJixHg9zf8ogMwv8vcQ@mail.gmail.com>
Message-ID: <CAKYAXd8FQDrnX-xAEAH3be_-Ezw2d3iiJixHg9zf8ogMwv8vcQ@mail.gmail.com>
Subject: Re: [PATCH] exfat: bail out on -EIO in exfat_find_empty_entry()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	linux-fsdevel@vger.kernel.org, lvc-project@linuxtesting.org, 
	syzbot+8f8fe64a30c50b289a18@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 1:18=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.ru=
> wrote:
>
> Syzbot has reported the following KASAN splat:
>
> KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
> ...
> Call Trace:
>  <TASK>
>  ...
>  ? exfat_get_dentry_cached+0xb6/0x1b0
>  ? exfat_get_dentry_cached+0x11a/0x1b0
>  ? exfat_get_dentry_cached+0xb6/0x1b0
>  exfat_init_ext_entry+0x1b6/0x3b0
>  exfat_add_entry+0x321/0x7a0
>  ? __pfx_exfat_add_entry+0x10/0x10
>  ? __lock_acquire+0x15a9/0x3c40
>  ? __pfx___lock_acquire+0x10/0x10
>  ? _raw_spin_unlock_irqrestore+0x52/0x80
>  ? do_raw_spin_unlock+0x53/0x230
>  ? _raw_spin_unlock+0x28/0x50
>  ? exfat_set_vol_flags+0x23f/0x2f0
>  exfat_create+0x1cf/0x5c0
>  ...
>  path_openat+0x904/0x2d60
>  ? __pfx_path_openat+0x10/0x10
>  ? __pfx___lock_acquire+0x10/0x10
>  ? lock_acquire.part.0+0x11b/0x380
>  ? find_held_lock+0x2d/0x110
>  do_filp_open+0x20c/0x470
>  ? __pfx_do_filp_open+0x10/0x10
>  ? find_held_lock+0x2d/0x110
>  ? _raw_spin_unlock+0x28/0x50
>  ? alloc_fd+0x41f/0x760
>  do_sys_openat2+0x17a/0x1e0
>  ? __pfx_do_sys_openat2+0x10/0x10
>  ? __pfx_sigprocmask+0x10/0x10
>  __x64_sys_creat+0xcd/0x120
>  ...
> </TASK>
>
> On exFAT with damaged directory structure, 'exfat_search_empty_slot()'
> may issue an attempt to access beyond end of device and return -EIO.
> So catch this error in 'exfat_find_empty_entry()', do not create an
> invalid in-memory directory structure and do not confuse the rest
> of the filesystem code further.
>
> Reported-by: syzbot+8f8fe64a30c50b289a18@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D8f8fe64a30c50b289a18
> Fixes: 5f2aa075070c ("exfat: add inode operations")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  fs/exfat/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
> index 97d2774760fe..73dbc5cdf388 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -331,7 +331,7 @@ static int exfat_find_empty_entry(struct inode *inode=
,
>         while ((dentry =3D exfat_search_empty_slot(sb, &hint_femp, p_dir,
>                                         num_entries, es)) < 0) {
>                 if (dentry =3D=3D -EIO)
> -                       break;
> +                       return -EIO;
Sorry, I have already applied Yuezhang's patch that fixed this issue.
https://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git/commit=
/?h=3Ddev&id=3D744e50c7e25a0e743f30003137f8413dcd107bb0

Thanks.
>
>                 if (exfat_check_max_dentries(inode))
>                         return -ENOSPC;
> --
> 2.47.1
>

