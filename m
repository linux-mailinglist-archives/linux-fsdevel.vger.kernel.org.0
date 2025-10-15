Return-Path: <linux-fsdevel+bounces-64219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0C4BDD8DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 10:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0A3189F1D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 08:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC553319609;
	Wed, 15 Oct 2025 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbewO6QI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153993191BE
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518613; cv=none; b=C004FTyxrlzdur/7Eg5CS7YiMWI7FcwjDq+Lt0DC00ep6BxpcYTtXe+V3FHFKE7xG70vHYxKTPy/mVsQrzZBWp3KR5hrZx4+lKg8EX0mlVwvViBbyMedSWxWnN8MWs4YEzNIauvz0FarbbaRhbh8/WyI8CqotUGAJFMAtEYBSCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518613; c=relaxed/simple;
	bh=xwT/Pl6dmG87t57HfPsPPmRDTlhvJ17+rT6ZCP+etKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bj59hJxC8uwezMuuVFSs0lwNg19pBOSeWU6H740EXV/H4KGeuXTQbirsasJa50ggTWa9m4tVUpovJh/45MVsFFwoMTPfAxBuSOago0Rb6emL02sTILTFU54KBPEqqE02F6HeRTGo6D2WF+D3AUenaps420Dv7GHVAx9fm4a87B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbewO6QI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5568C4CEFE
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 08:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760518612;
	bh=xwT/Pl6dmG87t57HfPsPPmRDTlhvJ17+rT6ZCP+etKo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VbewO6QIniE2Tx9chejq2BKNQIOjVp/lN5GVzA7F9zYlqG7nhwHrcn6PuuFiKnqHp
	 0cJ9ZG85LJoIjPTxBS2WJqhMAFPN15oIvEhMXe65qBWVB0AhSCvZdTuVj7i8qLvtcb
	 mlZ3Xxn34kCpLanSSFnDlFEKtsZ1fERFYyQ6WtXV3rxen+5gALc+y5Ln+QrIOeWgSk
	 V/aU0T9YJdRVNzsEcZVxmD+5J3c3VlH9eb6J2NhWEW/OfekEgtBOwD3fXBNNtQezIH
	 X/AXagmYQ+dawmH1+CAF5JIR5TgBLc12PqDMkb9ilPXYDm4HwySkfOBfEbbwHY7BMv
	 L4C9yiFHRE6nw==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso10960161a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 01:56:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCgC5zdlws3eHVEWjOrd/MAIttkan4hxgbl6k+V4llV2qavV5jrFpHZNx4mKidfHtG7Qvx9Nh0L2sELvI9@vger.kernel.org
X-Gm-Message-State: AOJu0YwrK+/BRNqBtx4Aksp7stioCWP7gbYkSNFqxCS8upAAQnz8yd9I
	5tPIxXdsXxgJ7Mzk9A94BrKUv0Cn1nyRy1UrKFEAHS3N6A40yJLud9VuroqdhSHpSSM2wSgo8fj
	cJ3kGSf6BIghUjX4ZWCWwfzyb96f726g=
X-Google-Smtp-Source: AGHT+IGhos5ASvOTvO3s8luelCPPD4ZQQ0H9zyLRWPX1ufk1biBqDkqw0tTY2aaoZoE0U33eOGcVscjK4CvaiK714y8=
X-Received: by 2002:a17:906:f5a1:b0:b3e:babd:f263 with SMTP id
 a640c23a62f3a-b50aa491464mr3063198066b.3.1760518611266; Wed, 15 Oct 2025
 01:56:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015073454.1505099-1-aha310510@gmail.com>
In-Reply-To: <20251015073454.1505099-1-aha310510@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 15 Oct 2025 17:56:39 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_4AOm2fjyBM5FF=1+aAM2Qj5_34PZzjD+riz3s=SCQQQ@mail.gmail.com>
X-Gm-Features: AS18NWBQhxF-pqQhdXvw_m4G0fuHX1eU8APZBWNzAEAxIKXbabUYguBBpgzMtO8
Message-ID: <CAKYAXd_4AOm2fjyBM5FF=1+aAM2Qj5_34PZzjD+riz3s=SCQQQ@mail.gmail.com>
Subject: Re: [PATCH v4] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
To: Jeongjun Park <aha310510@gmail.com>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, pali@kernel.org, 
	Ethan Ferguson <ethan.ferguson@zetier.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 4:35=E2=80=AFPM Jeongjun Park <aha310510@gmail.com>=
 wrote:
>
> Since the len argument value passed to exfat_ioctl_set_volume_label()
> from exfat_nls_to_utf16() is passed 1 too large, an out-of-bounds read
> occurs when dereferencing p_cstring in exfat_nls_to_ucs2() later.
>
> And because of the NLS_NAME_OVERLEN macro, another error occurs when
> creating a file with a period at the end using utf8 and other iocharsets.
>
> So to avoid this, you should remove the code that uses NLS_NAME_OVERLEN
> macro and make the len argument value be the length of the label string,
> but with a maximum length of FSLABEL_MAX - 1.
>
> Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D98cc76a76de46b3714d4
> Fixes: d01579d590f7 ("exfat: Add support for FS_IOC_{GET,SET}FSLABEL")
> Suggested-by: Pali Roh=C3=A1r <pali@kernel.org>
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  fs/exfat/exfat_fs.h | 1 -
>  fs/exfat/file.c     | 7 ++++---
>  fs/exfat/namei.c    | 2 +-
>  fs/exfat/nls.c      | 3 ---
>  4 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> index 329697c89d09..38210fb6901c 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -29,7 +29,6 @@ enum exfat_error_mode {
>  enum {
>         NLS_NAME_NO_LOSSY =3D     0,      /* no lossy */
>         NLS_NAME_LOSSY =3D        1 << 0, /* just detected incorrect file=
name(s) */
> -       NLS_NAME_OVERLEN =3D      1 << 1, /* the length is over than its =
limit */
>  };
>
>  #define EXFAT_HASH_BITS                8
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> index f246cf439588..adc37b4d7fc2 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -509,8 +509,8 @@ static int exfat_ioctl_get_volume_label(struct super_=
block *sb, unsigned long ar
>  static int exfat_ioctl_set_volume_label(struct super_block *sb,
>                                         unsigned long arg)
>  {
> -       int ret =3D 0, lossy;
> -       char label[FSLABEL_MAX];
> +       int ret =3D 0, lossy, label_len;
> +       char label[FSLABEL_MAX] =3D {0};
>         struct exfat_uni_name uniname;
>
>         if (!capable(CAP_SYS_ADMIN))
> @@ -520,8 +520,9 @@ static int exfat_ioctl_set_volume_label(struct super_=
block *sb,
>                 return -EFAULT;
>
>         memset(&uniname, 0, sizeof(uniname));
> +       label_len =3D strnlen(label, FSLABEL_MAX - 1);
>         if (label[0]) {
> -               ret =3D exfat_nls_to_utf16(sb, label, FSLABEL_MAX,
> +               ret =3D exfat_nls_to_utf16(sb, label, label_len,
>                                          &uniname, &lossy);
>                 if (ret < 0)
>                         return ret;
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
> index 7eb9c67fd35f..a6426a52fd29 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -442,7 +442,7 @@ static int __exfat_resolve_path(struct inode *inode, =
const unsigned char *path,
>                 return namelen; /* return error value */
>
>         if ((lossy && !lookup) || !namelen)
> -               return (lossy & NLS_NAME_OVERLEN) ? -ENAMETOOLONG : -EINV=
AL;
> +               return lossy ? -ENAMETOOLONG : -EINVAL;
+               return -EINVAL;
I have directly changed it and applied it to #dev.
Thanks!
>
>         return 0;
>  }
> diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
> index 8243d94ceaf4..57db08a5271c 100644
> --- a/fs/exfat/nls.c
> +++ b/fs/exfat/nls.c
> @@ -616,9 +616,6 @@ static int exfat_nls_to_ucs2(struct super_block *sb,
>                 unilen++;
>         }
>
> -       if (p_cstring[i] !=3D '\0')
> -               lossy |=3D NLS_NAME_OVERLEN;
> -
>         *uniname =3D '\0';
>         p_uniname->name_len =3D unilen;
>         p_uniname->name_hash =3D exfat_calc_chksum16(upname, unilen << 1,=
 0,
> --

