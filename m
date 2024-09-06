Return-Path: <linux-fsdevel+bounces-28836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B0C96EF21
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 11:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8083B242D4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 09:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E5C1C86EC;
	Fri,  6 Sep 2024 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgnI2meK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EDE1C7B93;
	Fri,  6 Sep 2024 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725614768; cv=none; b=mRn2i9fmA7f3yEZlMpXZpze7cOEwF/nPhdKGF5BoD6zjON6FtdEgHLQdFFCI84cMximtdPhRa7oWy9Uz5m2dVW1iqwFmsU+HurbV+DtaLuGGutXYoxhXPA8SUa9qIRjbGXeDFkX79GHmitCO/41AfNWnunrQ5eeMVg8If2FjtCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725614768; c=relaxed/simple;
	bh=1rf4cNFUJy8d8/dUnLrOK9aVtm01X8NuHJxBam5tXis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWOvCM2oN5iHTEnbxyD+SyBDudAhIW1RUoNxf0SVzztnWLwuLaTsGTzvaundxwz6gT4jqS3FMrYg45VuqPSuXQWEp83LXF06js02u1U4CgXXYmqwojCBy0uuF4qNRCaaNxzVuuFgIuqu/Mbn268TFGLLoRb4BtF9OCHM7nAfWHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgnI2meK; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5010a36e69dso627549e0c.0;
        Fri, 06 Sep 2024 02:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725614765; x=1726219565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Gv7O8iFsLmZOem+ZGCytIr9AEh8K7CayQ/E2g4S4Is=;
        b=AgnI2meKT1OmFG6qTn1lTqwdkAc29RHZSu/HeUcXnSv/5aALiMv4xemhRiQ0I8TQv+
         fT5zsDOCzij6DJNbDvANpixh8w4KOMCdvunlM2u6v6k8odgJlQ9BT61Xo/QufBA33umo
         Cj0bjFTEpbk9PNqoAwMNMTfpA3WF31rgXDvBIyO8XvgCXMiHxhrmJaQBwXYBK3vDhaCa
         gvWexb1hz1ABDFt4rvD40b05+NdfOby4OBxlkN+Ek3BYGcGUMwfIydcjv5O+JNzyFv5A
         pHx+9yPnLFAu9210eVP+AdIN53asco+AZb2K5aqEIdRcOYWbaBiUwxe1yxR4mWsMKDAN
         BD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725614765; x=1726219565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Gv7O8iFsLmZOem+ZGCytIr9AEh8K7CayQ/E2g4S4Is=;
        b=Y7h4YQHChNIM2YXUmvChEOIrwrgN34kT9ufrVDdt8chiYFXZHrnIDYJn7bCJ/RmNbj
         73qaXkVKec5gKX7i8hYJr6AlJJFlHJ/MrH9RqbLGvoTNUCowU8K0kGqTObx2xM3u1LBH
         mVx1KoTzRyI9L3qP8CQ18gcqmrtuUdztSSoMUw4VyiQiOcn7RkitETDqIvSC7UxgxfXM
         zMDvavPnvXIrAm85orlikQAQoCcmI/NKfyACZSxyz5jiAc3JR5pSnCpZntEKwCzmjr9R
         M06zU3d7oXKj5J1TJok61H3JDmd86MnnbVw5SNHnz0P6B4Z1TMMBhUXB9MIlLsbqCHSv
         RoJA==
X-Forwarded-Encrypted: i=1; AJvYcCWqMWm49DmyULLEcbTws67elQ28w74x38BnN/pl6jbXBViF5w/n7MU6uMrziG/YwN6lS/7t03BDT+b/G/uO@vger.kernel.org, AJvYcCXQ+jF+1gtLMnnexRtPT0EV/M3G6Ivw5Xe6J7QEZ7x5XBSCh7JHXQEUhkzQCwbwnV0cVLD93C45FHotJRvN@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1RmwAwPt08I89GDmpzn7ASm0ca9y2kTzvGkFBSzLV9x16Jxjd
	RgwQ8IPPZBcFJx5+2fpMHKnE99qfGBKSrFT819avZXqtoIILhUKd4O9Z8hHVKz+rKms+bwSMH1j
	/wL+XmZp3rlezv5q4fljLdVfK6Wk=
X-Google-Smtp-Source: AGHT+IEr/n+On170K0HW3Vn/ODvTisQwHHgr+zwDAYrGpv66t5zLaAjYy+fbepob8nfgh0T596y+2+5ItisBjEe+9hU=
X-Received: by 2002:a05:6122:1da2:b0:4f6:e87d:5160 with SMTP id
 71dfb90a1353d-502142567e3mr1764345e0c.9.1725614765322; Fri, 06 Sep 2024
 02:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906080047.21409-1-hailong.liu@oppo.com>
In-Reply-To: <20240906080047.21409-1-hailong.liu@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 6 Sep 2024 21:25:50 +1200
Message-ID: <CAGsJ_4yAp=VF4c12soA0U5dzX-ksb3FV4UnC5e7Jtp+D6BO4iw@mail.gmail.com>
Subject: Re: [PATCH] seq_file: replace kzalloc() with kvzalloc()
To: Hailong Liu <hailong.liu@oppo.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 8:06=E2=80=AFPM Hailong Liu <hailong.liu@oppo.com> w=
rote:
>
> __seq_open_private() uses kzalloc() to allocate a private buffer. However=
,
> the size of the buffer might be greater than order-3, which may cause
> allocation failure. To address this issue, use kvzalloc instead.

In general, this patch seems sensible, but do we have a specific example
of a driver that uses such a large amount of private data?
Providing a real-world example of a driver with substantial private data co=
uld
make this patch more convincing:-)

>
> Signed-off-by: Hailong Liu <hailong.liu@oppo.com>
> ---
>  fs/seq_file.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index e676c8b0cf5d..cf23143bbb65 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -621,7 +621,7 @@ int seq_release_private(struct inode *inode, struct f=
ile *file)
>  {
>         struct seq_file *seq =3D file->private_data;
>
> -       kfree(seq->private);
> +       kvfree(seq->private);
>         seq->private =3D NULL;
>         return seq_release(inode, file);
>  }
> @@ -634,7 +634,7 @@ void *__seq_open_private(struct file *f, const struct=
 seq_operations *ops,
>         void *private;
>         struct seq_file *seq;
>
> -       private =3D kzalloc(psize, GFP_KERNEL_ACCOUNT);
> +       private =3D kvzalloc(psize, GFP_KERNEL_ACCOUNT);
>         if (private =3D=3D NULL)
>                 goto out;
>
> @@ -647,7 +647,7 @@ void *__seq_open_private(struct file *f, const struct=
 seq_operations *ops,
>         return private;
>
>  out_free:
> -       kfree(private);
> +       kvfree(private);
>  out:
>         return NULL;
>  }
> --
> 2.30.0
>
>

