Return-Path: <linux-fsdevel+bounces-14000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E45B876378
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 12:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFBEA1C20B41
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 11:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C7056761;
	Fri,  8 Mar 2024 11:43:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9C256442;
	Fri,  8 Mar 2024 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709898188; cv=none; b=kC0tyEMVaaN21/enNfTZxSGXrUARFE/GVgtBRjM74MvyAKgFrBX0MejgCUoxjnxwHVwBlzj6cP2T5/ZcWlueeYEsqI2KTYaUGmA82ljxMcIBpPbOqglhgNJtzxOuTG3CVUhoL+UzTA18UBa/eGuIn2goY3ZpfQ5GR8Adligfuns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709898188; c=relaxed/simple;
	bh=WTPvxiS0Pg6ITS1Vn/YcEGXqyGDADSyjVlPQRD+qkaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/hBe9M21jQhzI83oBYPUTTFNmWhZqGmaQfxhu/gQQm1n9PAWhBHV8Hy9XmU7qYJFmaeyaVZFYHP+MvdkJjChP0solQqVcISOliHj1dzPir4H44GH+sSpD4UEHXf14vSPt+7QZcVkRYNi2OLGH48NSfOa6JtX8vScbZ6DokZx7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so307699366b.0;
        Fri, 08 Mar 2024 03:43:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709898184; x=1710502984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEeqI5MDotFb9rK23HKrypgCTWc+8alatdFbrADbmRM=;
        b=AIKvBpcnoHbJ1KfnNfYjGnFEYwUvAEmtiqMEyxvtEWindIiNSnVWQJMoiQ82w+5B2+
         KnI/V6HSomH7ZR0uicDWwfKXJkZFpazI9KS6aX25K7cbOB9r7J+wHVN8lOf32a8x9RSY
         UBBB/DfInKLp7YUZNxlczxTbj45V6kGUvo8LvJEkC1u1NvO2cQ04cTza7sZdchpIic1a
         +QkWx9aSOGEnvJCvyKIuB7lCpj40q1sVXir9u3tFeEVSizjbfbMQBtZiNIWf07VZxk70
         55dgrEyhr25rq8/20JFluyd5s/vd0gCvhd/DtIZLix8/1mEKrUQ/0LJfug69MYtLp4eY
         wZIg==
X-Forwarded-Encrypted: i=1; AJvYcCXEn9PSlY4Gzmx69YBZMtnEtdxqk9FfBTaUP9Qq/mCqBJ3ODBHh7kiOkMyk8xygL3uvoqf3wjlsad+5iDXy8WscecB4cgMEgLXbnzMWsmMIuQE4kaLPBdc/+bds5Hh8D5+svKG6Xr2vCaKStjTAxR0hwtKQCpAh60Eb0691Qs93qYuelIbLURyV7Q==
X-Gm-Message-State: AOJu0YyO4e3ICSKxvo3kBjVIoGhx+ki9F5iISUiryKoiferPM8cD8dGf
	0WKaTso/q++RlLczPvH53OkWEKOu2fFOAUWtn9HmlxmZrkhP6N+mSqOdmuwDRuHbSA==
X-Google-Smtp-Source: AGHT+IE3UmlIiSrN6kGt37gheJvIaN9i1n/e1DDihhUotOur3u44x9+yXyxyY24z6Or64iUDH6gLKg==
X-Received: by 2002:a17:906:cc93:b0:a43:3f37:4d94 with SMTP id oq19-20020a170906cc9300b00a433f374d94mr14075198ejb.16.1709898184428;
        Fri, 08 Mar 2024 03:43:04 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id pv25-20020a170907209900b00a3ee9305b02sm9174088ejb.20.2024.03.08.03.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 03:43:04 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3122b70439so263165966b.3;
        Fri, 08 Mar 2024 03:43:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVdymFqckKDeVaAk+9+2ml6OoDpzcbT5z9V7qrC/sSY0GB0s6b/WnWsdnVlP/ajFvk0h57c1TMwL6DfiO/yHzrTkBimmJie8B32BsnWqNGZMo/jC2sff6r5Wvfb4StK28Di6pwLtSID1gbkNbVEDgDSnnHl0Zxj3GrYlHi9KXUN33G4735vcoCwgA==
X-Received: by 2002:a17:907:a786:b0:a45:f33a:1382 with SMTP id
 vx6-20020a170907a78600b00a45f33a1382mr881603ejc.9.1709898184163; Fri, 08 Mar
 2024 03:43:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308022914.196982-1-kent.overstreet@linux.dev>
In-Reply-To: <20240308022914.196982-1-kent.overstreet@linux.dev>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 8 Mar 2024 06:42:27 -0500
X-Gmail-Original-Message-ID: <CAEg-Je96OKs_LOXorNVj1a1=e+1f=-gw34v4VWNOmfKXc6PLSQ@mail.gmail.com>
Message-ID: <CAEg-Je96OKs_LOXorNVj1a1=e+1f=-gw34v4VWNOmfKXc6PLSQ@mail.gmail.com>
Subject: Re: [PATCH v2] statx: stx_subvol
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 9:29=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> Add a new statx field for (sub)volume identifiers, as implemented by
> btrfs and bcachefs.
>
> This includes bcachefs support; we'll definitely want btrfs support as
> well.
>
> Link: https://lore.kernel.org/linux-fsdevel/2uvhm6gweyl7iyyp2xpfryvcu2g3p=
adagaeqcbiavjyiis6prl@yjm725bizncq/
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: David Howells <dhowells@redhat.com>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  fs/bcachefs/fs.c          | 3 +++
>  fs/stat.c                 | 1 +
>  include/linux/stat.h      | 1 +
>  include/uapi/linux/stat.h | 4 +++-
>  4 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> index 3f073845bbd7..6a542ed43e2c 100644
> --- a/fs/bcachefs/fs.c
> +++ b/fs/bcachefs/fs.c
> @@ -840,6 +840,9 @@ static int bch2_getattr(struct mnt_idmap *idmap,
>         stat->blksize   =3D block_bytes(c);
>         stat->blocks    =3D inode->v.i_blocks;
>
> +       stat->subvol    =3D inode->ei_subvol;
> +       stat->result_mask |=3D STATX_SUBVOL;
> +
>         if (request_mask & STATX_BTIME) {
>                 stat->result_mask |=3D STATX_BTIME;
>                 stat->btime =3D bch2_time_to_timespec(c, inode->ei_inode.=
bi_otime);
> diff --git a/fs/stat.c b/fs/stat.c
> index 77cdc69eb422..70bd3e888cfa 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -658,6 +658,7 @@ cp_statx(const struct kstat *stat, struct statx __use=
r *buffer)
>         tmp.stx_mnt_id =3D stat->mnt_id;
>         tmp.stx_dio_mem_align =3D stat->dio_mem_align;
>         tmp.stx_dio_offset_align =3D stat->dio_offset_align;
> +       tmp.stx_subvol =3D stat->subvol;
>
>         return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
>  }
> diff --git a/include/linux/stat.h b/include/linux/stat.h
> index 52150570d37a..bf92441dbad2 100644
> --- a/include/linux/stat.h
> +++ b/include/linux/stat.h
> @@ -53,6 +53,7 @@ struct kstat {
>         u32             dio_mem_align;
>         u32             dio_offset_align;
>         u64             change_cookie;
> +       u64             subvol;
>  };
>
>  /* These definitions are internal to the kernel for now. Mainly used by =
nfsd. */
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 2f2ee82d5517..67626d535316 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -126,8 +126,9 @@ struct statx {
>         __u64   stx_mnt_id;
>         __u32   stx_dio_mem_align;      /* Memory buffer alignment for di=
rect I/O */
>         __u32   stx_dio_offset_align;   /* File offset alignment for dire=
ct I/O */
> +       __u64   stx_subvol;     /* Subvolume identifier */
>         /* 0xa0 */
> -       __u64   __spare3[12];   /* Spare space for future expansion */
> +       __u64   __spare3[11];   /* Spare space for future expansion */
>         /* 0x100 */
>  };
>
> @@ -155,6 +156,7 @@ struct statx {
>  #define STATX_MNT_ID           0x00001000U     /* Got stx_mnt_id */
>  #define STATX_DIOALIGN         0x00002000U     /* Want/got direct I/O al=
ignment info */
>  #define STATX_MNT_ID_UNIQUE    0x00004000U     /* Want/got extended stx_=
mount_id */
> +#define STATX_SUBVOL           0x00008000U     /* Want/got stx_subvol */
>
>  #define STATX__RESERVED                0x80000000U     /* Reserved for f=
uture struct statx expansion */
>
> --
> 2.43.0
>
>

I think it's generally expected that patches that touch different
layers are split up. That is, we should have a patch that adds the
capability and a separate patch that enables it in bcachefs. This also
helps make it clearer to others how a new feature should be plumbed
into a filesystem.

I would prefer it to be split up in this manner for this reason.



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

