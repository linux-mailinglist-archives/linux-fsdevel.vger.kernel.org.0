Return-Path: <linux-fsdevel+bounces-52685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 441A0AE5CCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA353B87AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 06:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EE622FDEA;
	Tue, 24 Jun 2025 06:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCDmyOGi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B0C15442A
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 06:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750746619; cv=none; b=R0y1pd1QxhSfgjDPsnGDto2al1LqVtPD5CAUzNmlF68LDcGlSdZ9VkwVZsAdwioKhJHvV+3FKBa+h9mqFzAuDcKLd7EMnHTApAFmaFGIwAttug3rcPJgOTGnIwIbKsvbAoz3c3sreoEbLz/mPZkl0BO+Iox/dMpKLq7jc++Dnmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750746619; c=relaxed/simple;
	bh=i3ZcMlYpj2cnUeL7Q9XbjpkR+302hagkn7XJoq4WqVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXkj13aMx16h296iAxZ6+eQsZyeizqoDoOej6YOlO+EECM5b4a/4H4rTUsl0jDQwGkJLLRsUUF0diGrlI9PWsSrjwms9D25bVCcYTt5QjAV2QR7psk7J3A00VruJBRzUFX9Ay1KzKS6dcPNds+JuJFH1TAKdwq7IWIT+ylIzrRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCDmyOGi; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-addcea380eeso814527366b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 23:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750746615; x=1751351415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUYzoZAkYh8hngS4JWDC+NRnkggPJHsQmJOeA0SRc30=;
        b=MCDmyOGiWD42BlXjz7K0HpD3SJ1w1JSEqTUkFRDQksU6UD5GYC5HYnIqLds5OiHYvs
         sx0KFJbz7QRl/TXeZ7Vv3djlKpU/z7g3wF6owmx7KLyBKjDdzTrC/YZiGpfNKm8o9fvN
         aKgj3vCWW8xN+k4DZhLB/9mZ2ltBc9S05eZvmDEmjRll4B3oJaEULdD9W6A2bfTiQP3a
         JryH6ZV8PhHIOyQ6J0MnO30Iup/dCJ3RCvIdw3cEZb+J7bPsBwNOvnn5iX1pqlpsdUYA
         iOVVm5S7MO2FV80ydXFCT8waHpVpDfNxUoy/5qfqZMNRGCUcuUn2jnx4CeWDCMzjeQiP
         Qnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750746615; x=1751351415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUYzoZAkYh8hngS4JWDC+NRnkggPJHsQmJOeA0SRc30=;
        b=TZAGcA5R8OyITO5qX7ys8sgxTbKRm4tO426MfjehS7Gwin2Tp2RhsqUo8HSggEg13Q
         fjP99/urNGzFhjpYB5Q1Q6pCi77wEJnQbPHJGnR7q3uMAkQkygxxnEReS1yxSNfIn2tN
         PzCZ64nOBXiF/9RGG4PNeeDexG2SsmFnBHexa079NZGcjXF4AXTg0duXgxdsJKf4vA+N
         16wywyY8sQdq9zOWUtQYMVf9SL/EGlA3nUxOK0YxeMYjUOzJDNzHXC3RU/17UbvamNpk
         U9t0gLsbasYbyX5/AXEwmbSIIKSfPQexHHfFDQk57mMOs+414ny5cbcUUWTLp2LD4fz1
         agIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOpyLgHHBzQtCmMvcXXXk7ylITN4mXie20bCeINkLuZ14DGcMggBdzfOXgV6Mygk3njLmo2/Fpm0j27D3n@vger.kernel.org
X-Gm-Message-State: AOJu0Yw99ihxXecIZoA2AbLikl9NNAtdlF42joCIcRUddUgUsbqU+256
	lxClYQu3eYjBVhYMmG3ZEqz3Lz0MbqCG2e+ICzVDeKBAzfMfkMVO9UkTHg03cA7mBbFTqRDVYNL
	Llf/1ZOZ3VXsyweBhBRcf2pIeqCHsMzc=
X-Gm-Gg: ASbGnctxqhN0cze4HtdabyQiBMFp9yEMHzeZQbinWrDUpJ9or9SZCMH/gQIX2f9bbzM
	5GSBRmrgf3OOdXVXu7mkccXDS3hGV6Q/ynoGrpHIx8iv85E2ongee0ffj7s2ZFKrigqSobmWXku
	65orFLPzM7Z98Mnr7CGX/4jtY5sAc1CzG4wk5AQQrUO6g=
X-Google-Smtp-Source: AGHT+IFfKb/Isg7k3O9s/uaOe7GBRhJUnLGuq5zt+HmfNMH48RIutK5vlj22SNPXB5ZdfhldNWp53OuDZv9NyUX+0/M=
X-Received: by 2002:a17:907:2d91:b0:ae0:adb7:3172 with SMTP id
 a640c23a62f3a-ae0adb734f3mr114690566b.50.1750746615051; Mon, 23 Jun 2025
 23:30:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623192503.2673076-1-ibrahimjirdeh@meta.com>
In-Reply-To: <20250623192503.2673076-1-ibrahimjirdeh@meta.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 24 Jun 2025 08:30:03 +0200
X-Gm-Features: Ac12FXw9KgHd-zCBT3IuIf0jHhH8SGw5Te7ZMF818b_uE_yHHlKJ8ULOfloqVfI
Message-ID: <CAOQ4uxguBgMuUZqs0bT_cDyEX6465YkQkUHFPFE4tndys-y2Wg@mail.gmail.com>
Subject: Re: [PATCH] fanotify: support custom default close response
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 9:26=E2=80=AFPM Ibrahim Jirdeh <ibrahimjirdeh@meta.=
com> wrote:
>
> Currently the default response for pending events is FAN_ALLOW.
> This makes default close response configurable. The main goal
> of these changes would be to provide better handling for pending
> events for lazy file loading use cases which may back fanotify
> events by a long-lived daemon. For earlier discussion see:
> https://lore.kernel.org/linux-fsdevel/6za2mngeqslmqjg3icoubz37hbbxi6bi44c=
anfsg2aajgkialt@c3ujlrjzkppr/

These lore links are typically placed at the commit message tail block
if related to a suggestion you would typically use:

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxi6PvAcT1vL0d0e+7YjvkfU-k=
wFVVMAN-tc-FKXe1wtSg@mail.gmail.com/
Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>

This way reviewers whose response is "what a terrible idea!" can
point their arrows at me instead of you ;)

Note that this is a more accurate link to the message where the default
response API was proposed, so readers won't need to sift through
this long thread to find the reference.

> This implements the first approach outlined there of providing
> configuration for response on group close. This is supported by
> writing a response with
> .fd =3D FAN_NOFD
> .response =3D FAN_DENY | FAN_DEFAULT
> which modifies the group property default_response
>
> Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
> ---
>  fs/notify/fanotify/fanotify_user.c  | 14 ++++++++++++--
>  include/linux/fanotify.h            |  2 +-
>  include/linux/fsnotify_backend.h    |  1 +
>  include/uapi/linux/fanotify.h       |  1 +
>  tools/include/uapi/linux/fanotify.h |  1 +
>  5 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index b192ee068a7a..02669abff4a5 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -378,6 +378,13 @@ static int process_access_response(struct fsnotify_g=
roup *group,
>                 return -EINVAL;
>         }
>
> +       if (response & FAN_DEFAULT) {
> +               if (fd !=3D FAN_NOFD)
> +                       return -EINVAL;

I think we also need to check that no bits other than the allowed bits
for default response
are set, for example, if user attempts to do:
 .response =3D FAN_DENY | FAN_AUDIT | FAN_DEFAULT

But that opens up the question, do we want to also allow custom
error in default response, e.g.:
 .response =3D FAN_DENY_ERRNO(EAGAIN) | FAN_DEFAULT

Anyway, we do not have to implement custom default error from the
start. It will complicate the implementation a bit, but as long as you deny
setting the default response with unsupported flags, we can extend it later=
.

> +               group->default_response =3D response & FANOTIFY_RESPONSE_=
ACCESS;
> +               return 0;
> +       }
> +
>         if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_A=
UDIT))
>                 return -EINVAL;
>
> @@ -1023,7 +1030,8 @@ static int fanotify_release(struct inode *ignored, =
struct file *file)
>                 event =3D list_first_entry(&group->fanotify_data.access_l=
ist,
>                                 struct fanotify_perm_event, fae.fse.list)=
;
>                 list_del_init(&event->fae.fse.list);
> -               finish_permission_event(group, event, FAN_ALLOW, NULL);
> +               finish_permission_event(group, event,
> +                               group->default_response, NULL);
>                 spin_lock(&group->notification_lock);
>         }
>
> @@ -1040,7 +1048,7 @@ static int fanotify_release(struct inode *ignored, =
struct file *file)
>                         fsnotify_destroy_event(group, fsn_event);
>                 } else {
>                         finish_permission_event(group, FANOTIFY_PERM(even=
t),
> -                                               FAN_ALLOW, NULL);
> +                                               group->default_response, =
NULL);
>                 }
>                 spin_lock(&group->notification_lock);
>         }
> @@ -1640,6 +1648,8 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags,=
 unsigned int, event_f_flags)
>                 goto out_destroy_group;
>         }
>
> +       group->default_response =3D FAN_ALLOW;
> +
>         BUILD_BUG_ON(!(FANOTIFY_ADMIN_INIT_FLAGS & FAN_UNLIMITED_QUEUE));
>         if (flags & FAN_UNLIMITED_QUEUE) {
>                 group->max_events =3D UINT_MAX;
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 879cff5eccd4..182fc574b848 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -134,7 +134,7 @@
>
>  /* These masks check for invalid bits in permission responses. */
>  #define FANOTIFY_RESPONSE_ACCESS (FAN_ALLOW | FAN_DENY)
> -#define FANOTIFY_RESPONSE_FLAGS (FAN_AUDIT | FAN_INFO)
> +#define FANOTIFY_RESPONSE_FLAGS (FAN_AUDIT | FAN_INFO | FAN_DEFAULT)
>  #define FANOTIFY_RESPONSE_VALID_MASK \
>         (FANOTIFY_RESPONSE_ACCESS | FANOTIFY_RESPONSE_FLAGS | \
>          (FAN_ERRNO_MASK << FAN_ERRNO_SHIFT))
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_ba=
ckend.h
> index d4034ddaf392..9683396acda6 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -231,6 +231,7 @@ struct fsnotify_group {
>         unsigned int max_events;                /* maximum events allowed=
 on the list */
>         enum fsnotify_group_prio priority;      /* priority for sending e=
vents */
>         bool shutdown;          /* group is being shut down, don't queue =
more events */
> +       unsigned int default_response; /* default response sent on group =
close */
>
>  #define FSNOTIFY_GROUP_USER    0x01 /* user allocated group */
>  #define FSNOTIFY_GROUP_DUPS    0x02 /* allow multiple marks per object *=
/
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.=
h
> index e710967c7c26..7badde273a66 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -254,6 +254,7 @@ struct fanotify_response_info_audit_rule {
>
>  #define FAN_AUDIT      0x10    /* Bitmask to create audit record for res=
ult */
>  #define FAN_INFO       0x20    /* Bitmask to indicate additional informa=
tion */
> +#define FAN_DEFAULT    0x30    /* Bitmask to set default response on clo=
se */
>
>  /* No fd set in event */
>  #define FAN_NOFD       -1
> diff --git a/tools/include/uapi/linux/fanotify.h b/tools/include/uapi/lin=
ux/fanotify.h
> index e710967c7c26..7badde273a66 100644
> --- a/tools/include/uapi/linux/fanotify.h
> +++ b/tools/include/uapi/linux/fanotify.h
> @@ -254,6 +254,7 @@ struct fanotify_response_info_audit_rule {
>
>  #define FAN_AUDIT      0x10    /* Bitmask to create audit record for res=
ult */
>  #define FAN_INFO       0x20    /* Bitmask to indicate additional informa=
tion */
> +#define FAN_DEFAULT    0x30    /* Bitmask to set default response on clo=
se */
>
>  /* No fd set in event */
>  #define FAN_NOFD       -1
> --
> 2.47.1
>

