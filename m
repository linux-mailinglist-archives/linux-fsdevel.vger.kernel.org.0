Return-Path: <linux-fsdevel+bounces-45375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC9AA76C23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 18:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEF4E7A1DBE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 16:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85826214A64;
	Mon, 31 Mar 2025 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nV+T4BbS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6052B86347;
	Mon, 31 Mar 2025 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743439304; cv=none; b=r8kh/K1yWVw+Mca6j+sd7Hi4Fvg9QfsC4mFQR9wPGysoWxK7LuWrxuL97skI34rM8g0SUEdFijmsBQmWcyyFMM3YI3MyQsBv+Maaltgyl9w3l5BYzQc6d2dWr1USPByniXK5n/gDWmoHnSiFePNn15hTMdMVCThlX3a+iesELGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743439304; c=relaxed/simple;
	bh=ET1UFa+3Wjgf7uvHL9C78hcJojeulT+FM9c6IjmbeFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krv4+GmJ1JNEQrq61L2bXEUdUVyF0wS3dhNkA2Zl3H8Jc/sIQ/djixclpaELFCK0w/bbB0sElIaOz7tr84ObI6n6lixBSJSLgQDAjvMTlyamneYtOt0SmAS6qtwBjQ7ZbX1iRgAso72VmW8XmlLh283G0X2eTLh1pDq+zwXbDP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nV+T4BbS; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-476ac73c76fso50575761cf.0;
        Mon, 31 Mar 2025 09:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743439300; x=1744044100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhjC2drV7hv/3QybYj7FN99E2t5t2aYTgdtA/Mp7LGM=;
        b=nV+T4BbSskhN2ysoX/L1ghC86jLMy6o+GpLPQ6aM4dM9prjEqbrIU3XR8/jjuruNEi
         JqS+7vpaeXh4u4AKIVUkDjtKuzYd+1WSIioxBBjVgbj7i57gd5Fv2FOKRH0rYfhx/H5X
         BuiTA0HSCqh8zCckAXfbIqvpihXpi6gLSau/ePXT4+E7qJ2ieRLTINpHuDp43WKFag7J
         iwJP22vNKceNVrcV1ntqwbHhJscZpmWgcul7ci6BUWELJOB1RCGaTmxlLUpo19VvlPdM
         G/FVP22XFbfQfB3uirw/LAWSpwLbzD67QpqgMDTrqnZXy0jvsIg4fLC4ruc4GjTmfGHi
         HutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743439300; x=1744044100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhjC2drV7hv/3QybYj7FN99E2t5t2aYTgdtA/Mp7LGM=;
        b=RfkpPI1njQE6kMNqzUFlR7Tm4xgFQ30D7LZsVDkiE738KVb5LKgmaOA/+nLFVRVVkr
         Li7mPfVsOtlZgtyR2pCYwHk1rnp/XVE9kT8xUiZOHSXnqHfQkSPjJaJ2X01qmJZxEuPK
         JSY6p+o4A+DWAWx76VEeDAMEx3d6vU4O5wJV4AAaZdNUX9sIDukmh2YDGC9pSISc+G+P
         aRkC0qBw7DIpe/mXVJhrdzekIWuhzmNv2wH4Bf7quZfvERccb8i+ij0740ZxnbyePjRb
         AQwzQqVgS2dgBQnf6IjYsTmk0f+Xg6rufQkrVGDzp7/4V0+SsuNlR1MHvNkmVklicaYl
         vMJg==
X-Forwarded-Encrypted: i=1; AJvYcCU2RS0D14V9XNUsfuS9zQzuLpy3YBZdUk0hxExo6mlWFoE5CvBHsMkS6IlGHDNAH0idxmVQIjhinILDeAro@vger.kernel.org, AJvYcCV24u9vTGEhxouiKddRUZyp4+rDAAjqM4kX6NtyrmLH01cfMn26Rrr2L8z5sQNGZ1mSxbqCuw4vNVizfJ4D@vger.kernel.org
X-Gm-Message-State: AOJu0YyItoLkucSMP4jne6V56Xu7wQ0+mxIP00YteZDOjhZvZWceOlHx
	iltNnL852RiVpWGR2dixcUb2cOzqan+srihYPhK3wnbR7bNzYLhLljj2TGSpoYUxYc2sZKg0eg+
	Gb7O4iPFY3XSi0byitw3iaX51f+g=
X-Gm-Gg: ASbGncuHMbnsrO706+oLOQAZg8XrMDxTvCHdpEjvUyfj74X04xANbBMPf2S2Ky6mAak
	22gPkvgsP5crKm2U8gYfT0C9jkR/QG24aIOS8bOsiDMhnpgKF06C9Av53lDKjkbmFClLpXjp7KP
	yGNEiqEoGl5kdsLSRIFGKYtfJwD0FnEIRNvgUTzrNt/g==
X-Google-Smtp-Source: AGHT+IHHJEUa22Lljfh+qr/c2W8KADmjCPftVCyBX/KFRCHjn5FPNDwed7XlfhdYm2s5ycPhZkbJl3RJGqB4ZYF/2q0=
X-Received: by 2002:a05:622a:c5:b0:477:6f2c:a18f with SMTP id
 d75a77b69052e-477e4b1ebf5mr147742861cf.1.1743439300203; Mon, 31 Mar 2025
 09:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230727081237.18217-1-jaco@uls.co.za> <20250314221701.12509-1-jaco@uls.co.za>
 <20250314221701.12509-3-jaco@uls.co.za>
In-Reply-To: <20250314221701.12509-3-jaco@uls.co.za>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 31 Mar 2025 09:41:29 -0700
X-Gm-Features: AQ5f1JqDDcWgqbxUxjp3X73aFi6aMruf6b_h0XmOXin9pAhxqalanAM4c4g4-_A
Message-ID: <CAJnrk1YqO44P077UwJqS+nrSTNe9m9MrbKwnxsSZn2RCQsEvAQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Adjust readdir() buffer to requesting buffer size.
To: Jaco Kroon <jaco@uls.co.za>
Cc: bernd.schubert@fastmail.fm, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, rdunlap@infradead.org, 
	trapexit@spawn.link
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 3:39=E2=80=AFPM Jaco Kroon <jaco@uls.co.za> wrote:
>
> Clamp to min 1 page (4KB) and max 128 pages (512KB).
>
> Glusterfs trial using strace ls -l.
>
> Before:
>
> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 600
> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 616
> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 624
> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 600
> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 600
> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 624
> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 600
> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 600
> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 600
> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 600
> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 608
> getdents64(3, 0x7f2d7d7a7040 /* 1 entries */, 131072) =3D 24
> getdents64(3, 0x7f2d7d7a7040 /* 0 entries */, 131072) =3D 0
>
> After:
>
> getdents64(3, 0x7ffae8eed040 /* 276 entries */, 131072) =3D 6696
> getdents64(3, 0x7ffae8eed040 /* 0 entries */, 131072) =3D 0
>
> Signed-off-by: Jaco Kroon <jaco@uls.co.za>
> ---
>  fs/fuse/readdir.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> index 17ce9636a2b1..a0ccbc84b000 100644
> --- a/fs/fuse/readdir.c
> +++ b/fs/fuse/readdir.c
> @@ -337,11 +337,25 @@ static int fuse_readdir_uncached(struct file *file,=
 struct dir_context *ctx)
>         struct fuse_mount *fm =3D get_fuse_mount(inode);
>         struct fuse_io_args ia =3D {};
>         struct fuse_args_pages *ap =3D &ia.ap;
> -       struct fuse_folio_desc desc =3D { .length =3D PAGE_SIZE };
> +       struct fuse_folio_desc desc =3D { .length =3D ctx->count };
>         u64 attr_version =3D 0, evict_ctr =3D 0;
>         bool locked;
> +       int order;
>
> -       folio =3D folio_alloc(GFP_KERNEL, 0);
> +       if (desc.length < PAGE_SIZE)
> +               desc.length =3D PAGE_SIZE;
> +       else if (desc.length > (PAGE_SIZE << 7)) /* 128 pages, typically =
512KB */
> +               desc.length =3D PAGE_SIZE << 7;
> +

Just wondering, how did 128 pages get decided as the upper bound? It
seems to me to make more sense if the upper bound is fc->max_pages.

Also btw, I think you can just use the clamp() helper from
<linux/minmax.h> to do the clamping

> +       order =3D get_count_order(desc.length >> CONFIG_PAGE_SHIFT);
> +
> +       do {
> +               folio =3D folio_alloc(GFP_KERNEL, order);

Folios can now be larger than one page size for readdir requests with
your change but I don't believe the current page copying code in fuse
supports this yet. For example, I think the kmapping will be
insufficient in fuse_copy_page() where in the current code we kmap
only the first page in the folio. I sent a patch for supporting large
folios page copying [1] and am trying to get this merged in but
haven't heard back about this patchset yet. In your local tests that
used multiple pages for the readdir request, did you run into any
issues or it worked fine?

[1] https://lore.kernel.org/linux-fsdevel/20250123012448.2479372-2-joannelk=
oong@gmail.com/


Thanks,
Joanne

> +               if (folio)
> +                       break;
> +               --order;
> +               desc.length =3D PAGE_SIZE << order;
> +       } while (order >=3D 0);
>         if (!folio)
>                 return -ENOMEM;
>
> @@ -353,10 +367,10 @@ static int fuse_readdir_uncached(struct file *file,=
 struct dir_context *ctx)
>         if (plus) {
>                 attr_version =3D fuse_get_attr_version(fm->fc);
>                 evict_ctr =3D fuse_get_evict_ctr(fm->fc);
> -               fuse_read_args_fill(&ia, file, ctx->pos, PAGE_SIZE,
> +               fuse_read_args_fill(&ia, file, ctx->pos, desc.length,
>                                     FUSE_READDIRPLUS);
>         } else {
> -               fuse_read_args_fill(&ia, file, ctx->pos, PAGE_SIZE,
> +               fuse_read_args_fill(&ia, file, ctx->pos, desc.length,
>                                     FUSE_READDIR);
>         }
>         locked =3D fuse_lock_inode(inode);
> --
> 2.48.1
>
>

