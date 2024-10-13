Return-Path: <linux-fsdevel+bounces-31818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF0D99B8F8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2024 11:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B645D28209E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2024 09:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FC713B7B3;
	Sun, 13 Oct 2024 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7LI0dAa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D05336B;
	Sun, 13 Oct 2024 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728812325; cv=none; b=urNo0sYCKXWotUIO5I/JMqx4iuvlF4Vw/a88m/HAMZ3vxlddrPD7UvYoO8gyK2oeSKPmoSaxpTeMGhfcpWQXHHUT9WLfPXgfhgCK6VXOU52lEMjwoCdm/9PZcwcfAUZ2CYXFR65HDbZcWyeMe8sx0PlOjU7oGs59/Ld8pCRAbh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728812325; c=relaxed/simple;
	bh=ns3eiogOPJ10pUA+Drn7hHsSYuxX+yqW/UpkfRM+kuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhUGa9J87B2UCdbmFWxWVxIh176ZSYOpDBJxQsyiZdIIWx0bTiMoJ/8YZkhN9MgUv5mIY9O4Lyzu78NFexRAMMlQH35GEyOmKrDqhV3WK7nvaL7CARfFpla2c5e+J0uEQMh2fndUGwu5o8fnH6oTBadVPQthyCk7tILGnowZwNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7LI0dAa; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4606347c791so6110141cf.2;
        Sun, 13 Oct 2024 02:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728812323; x=1729417123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbljh3QBLaCEU55EyQRUgUXIT24/JvrPOPpKACKjoVM=;
        b=U7LI0dAafhgt7lz4ObKMeOHFYdHeTSFzdjYDoy7AeJvCKZ7Jz99Ju/XIfu2UzDjaIR
         3ClhP4Plou39N+Chj7prn+67D0woYqhiDNh6me1ZJlqPwSrt8b0iFEz+2sbZW8xXDNs2
         lmmTyD7bYoNa8oO3zipmAxVmnuxj1YZaH3zV0TbWuZWB5MUN3vKAS1MmTBznO7/XGp3a
         hejsQFhqDk0jZLwKeXLB6lnRin3Y5r6CZixG0sadDWcLQW7xxss95V6oV1HTUTQx1WBQ
         r1mTf0tktZjkslgdySIJRALg9WE0qIM+0HGninWC5+SNdq8CdKP/ekijq/E/Yo9aTaiK
         tDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728812323; x=1729417123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbljh3QBLaCEU55EyQRUgUXIT24/JvrPOPpKACKjoVM=;
        b=iCvxIFYRKpRTOxwulIDEB8YesLqXntjAM3x+/59goJp5x8CYb654Fhabvk3Va+pymS
         aq+dErPp5RZxh4jTc0w4wfyK1GPfz45UZEhnPTbq5B4KAXCje/ZjaVCe//G/Am0bNgzR
         jCD1R/oXNTeOHTrloPHknV1WZxd5QSoSwuIrDJ7IYKZvnTHc24DaWEL0GtieixCW6PMj
         cyHKpgnK8G7isUwk6tle3g+klz/S52/h8kcM1PPf/YapaObHcxpccA2PT0ZLuR63zL3u
         bzPs2yxQ6eHp7ArIejuHXOMHwiTXhr92lBxTYweOkggkd/Z+Bgh1mizQhddJ6znz4Ib5
         CzkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzIrg+YrMTjMofDMgL2HXu8znGv0TMfn9QIvNkWx4WwaizkyfzTssAsFON9X/dloXpTontxVUCI4P4GuNRd5ejzJiHfE9m@vger.kernel.org, AJvYcCXkWNMXyxitFjLjAKOIGVu0b2q+lni+6vGJrdUO9wLrzRQRTyWk+2GXcuTQT1VNprJAzqj1BHKm6sU+KYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhFR+ug7A8Auw3f464dXL6dsnk8hPOwoTGxy9fwRLPXhGJ5iQD
	BlHjPsoNTUOoGZFrtnsF09EdlDorItfdXu7w2uim21rUww0SzvqGcsxzGNZezR69j5y6foxwdJH
	FTqcyziIS31ghBzVVcvSHte9dCcI=
X-Google-Smtp-Source: AGHT+IFFYUgMvy7TB/FUVUEQ0wgIT3dNYRe2MOn8pw3I6QUuDAkJLQbEVKAqzDvmp+MiR7ldZlrSEeZsSSwzAqDLdeU=
X-Received: by 2002:a05:622a:11c5:b0:45f:d8e0:a380 with SMTP id
 d75a77b69052e-460583fc690mr83389321cf.16.1728812322783; Sun, 13 Oct 2024
 02:38:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241013002248.3984442-1-song@kernel.org>
In-Reply-To: <20241013002248.3984442-1-song@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 13 Oct 2024 11:38:31 +0200
Message-ID: <CAOQ4uxjQ--cBoNNHQYz+AFz2z8g=pCZ0CFDHujuCELOJBg8wzw@mail.gmail.com>
Subject: Re: [PATCH v2] fsnotify, lsm: Decouple fsnotify from lsm
To: Song Liu <song@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 2:23=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> Currently, fsnotify_open_perm() is called from security_file_open(). This
> is not right for CONFIG_SECURITY=3Dn and CONFIG_FSNOTIFY=3Dy case, as
> security_file_open() in this combination will be a no-op and not call
> fsnotify_open_perm(). Fix this by calling fsnotify_open_perm() directly.

Maybe I am missing something.
I like cleaner interfaces, but if it is a report of a problem then
I do not understand what the problem is.
IOW, what does "This is not right" mean?

>
> After this, CONFIG_FANOTIFY_ACCESS_PERMISSIONS does not require
> CONFIG_SECURITY any more. Remove the dependency in the config.
>
> Signed-off-by: Song Liu <song@kernel.org>
> Acked-by: Paul Moore <paul@paul-moore.com>
>
> ---
>
> v1: https://lore.kernel.org/linux-fsdevel/20241011203722.3749850-1-song@k=
ernel.org/
>
> As far as I can tell, it is necessary to back port this to stable. Becaus=
e
> CONFIG_FANOTIFY_ACCESS_PERMISSIONS is the only user of fsnotify_open_perm=
,
> and CONFIG_FANOTIFY_ACCESS_PERMISSIONS depends on CONFIG_SECURITY.
> Therefore, the following tags are not necessary. But I include here as
> these are discussed in v1.

I did not understand why you claim that the tags are or not necessary.
The dependency is due to removal of the fsnotify.h include.

Anyway, I don't think it is critical to backport this fix.
The dependencies would probably fail to apply cleanly to older kernels,
so unless somebody cares, it would stay this way.

>
> Fixes: c4ec54b40d33 ("fsnotify: new fsnotify hooks and events types for a=
ccess decisions")

Because I am not sure what the problem is, I am not sure that a Fixes:
tag is called for.

> Depends-on: 36e28c42187c ("fsnotify: split fsnotify_perm() into two hooks=
")
> Depends-on: d9e5d31084b0 ("fsnotify: optionally pass access range in file=
 permission hooks")

These need to be in the commit message in case AUTOSEL or a developer
would decide to backport your change.

Thanks,
Amir.

> ---
>  fs/notify/fanotify/Kconfig | 1 -
>  fs/open.c                  | 4 ++++
>  security/security.c        | 9 +--------
>  3 files changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/fs/notify/fanotify/Kconfig b/fs/notify/fanotify/Kconfig
> index a511f9d8677b..0e36aaf379b7 100644
> --- a/fs/notify/fanotify/Kconfig
> +++ b/fs/notify/fanotify/Kconfig
> @@ -15,7 +15,6 @@ config FANOTIFY
>  config FANOTIFY_ACCESS_PERMISSIONS
>         bool "fanotify permissions checking"
>         depends on FANOTIFY
> -       depends on SECURITY
>         default n
>         help
>            Say Y here is you want fanotify listeners to be able to make p=
ermissions
> diff --git a/fs/open.c b/fs/open.c
> index acaeb3e25c88..6c4950f19cfb 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -946,6 +946,10 @@ static int do_dentry_open(struct file *f,
>         if (error)
>                 goto cleanup_all;
>
> +       error =3D fsnotify_open_perm(f);
> +       if (error)
> +               goto cleanup_all;
> +
>         error =3D break_lease(file_inode(f), f->f_flags);
>         if (error)
>                 goto cleanup_all;
> diff --git a/security/security.c b/security/security.c
> index 6875eb4a59fc..a72cc62c0a07 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -19,7 +19,6 @@
>  #include <linux/kernel.h>
>  #include <linux/kernel_read_file.h>
>  #include <linux/lsm_hooks.h>
> -#include <linux/fsnotify.h>
>  #include <linux/mman.h>
>  #include <linux/mount.h>
>  #include <linux/personality.h>
> @@ -3102,13 +3101,7 @@ int security_file_receive(struct file *file)
>   */
>  int security_file_open(struct file *file)
>  {
> -       int ret;
> -
> -       ret =3D call_int_hook(file_open, file);
> -       if (ret)
> -               return ret;
> -
> -       return fsnotify_open_perm(file);
> +       return call_int_hook(file_open, file);
>  }
>
>  /**
> --
> 2.43.5
>
>

