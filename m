Return-Path: <linux-fsdevel+bounces-11063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734D385085D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Feb 2024 10:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4BD2842C7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Feb 2024 09:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613F759B72;
	Sun, 11 Feb 2024 09:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="14B3Knon"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9190F2E3E1
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Feb 2024 09:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707644461; cv=none; b=lMwhuPgxxEDlJAIp2pDpPuZzz/3R8l8oAwFyJ1CoMFqKBwa/MWbJCvPXqxGvcQe/NwcTU3N9tflAUa9r/FlyrsDB27R3aj76qG4/yikAe3GAn2aRuMT9t0MoR5pAz/PhecxfK/OxRkf+f/VNPsLmfQZBhprOMrx8beHJfauiztE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707644461; c=relaxed/simple;
	bh=/wP9wzwffZbLxrBM8ksZnD/6CWd0SVUf0oUyW7qxhkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzHbdEvjmQ3dAHkSgBYSinM0EbRabShsISK8YBNDD/TW8PnhYzYrGHjAnDzIlZ0Y0vpFJc4FKfnWUlPat50xtMZo2R8WrKrRbIfW1h65jhHofp1i9Xnvb3iOL4pJFuhUbY2tVMwV7jPHf1jOqkSQOc1gwt2QjGpKukH6L5NGo+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=14B3Knon; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56154f4c9c8so13199a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Feb 2024 01:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707644457; x=1708249257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2e/NnACijgdjz/+JmX+cslMM8xhvoVXLCKquNzJcRzM=;
        b=14B3KnonrgagIKm6/aM7vm4zEQf2SvpUbRLnkEike6sWJXyVqTNcV/wrUjC19dl7ED
         fY69uaUb8Lnedi6Eau1rSxYcw/6c43G+tae34EYFdi+RL31fGXOJubU2+XzZpgBCaMS8
         kECDs2n3m4xr0PxIyjHTlPpgoQMtvPQLW26F7lWHUKR5SMi564U9EyH/vScfmr/OSYjc
         6VfRorCHzseJO97C3NwtwARQtBhtnlttcppPLlyez7Rz3ODBikJHIh0YUig+cfhmJvxI
         id1JnRnoEOIY4suzYxzYmVFZVna+n7T/s/0sp9Ec8RtjrfBG0+WI/65lLLX5OrTu7fp5
         ZWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707644457; x=1708249257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2e/NnACijgdjz/+JmX+cslMM8xhvoVXLCKquNzJcRzM=;
        b=ttY+o5MtvOxy9eSOBeYs7Daz7QXoBZrG6hJ+9arlTluegMMEBl4Cmip9gMPtUO6aaH
         tge7g2YjK6S0FoOTkG2Uc80wSsI7BiMWIGATpmghuRcetlrYyID8C0MNfhtgng1FeK3y
         WO52Us9LdnQiyqJRwawAe20xUKvJaellyMw1egphoktGSLJHjQjr6/XqxRkFpl8p9dJI
         0ZdQI/jh3hAzF5rQNTl8HvedAK7Lmzzi2NmxuRohhTOiDk7D9rdFtr8BCjquS0IhwJ1j
         HZ5p7+0Y3uBRNpYGE06Jde5QpeSudu22E5rTUCko0muQscZHQuL3eOtm7XQRMjqzRpKH
         2LfQ==
X-Gm-Message-State: AOJu0YxKrvBmonEbOYSGJIv2p8mhBZEvgtKMWVArAAMXoJZyQlt7ydAO
	WHH9Sb7YGYgVySZptGSR54xaQrUOsTfbJzeZUT6wSODl3Tq0YpCK3f9LPJwrmhKVDv2DSeFrJow
	IhrM/4/iagEnwbdbaIkT6P8saigoqIxSDCQuS
X-Google-Smtp-Source: AGHT+IEDbNDMt9jpuDF0Ep+hJamsdvVE1EBokWa007g0Xi3TxSBxglksRrLcmFQAF8K/0r1VVm9zxQzezPVKUME2T2o=
X-Received: by 2002:a50:c345:0:b0:561:3d1d:e5a0 with SMTP id
 q5-20020a50c345000000b005613d1de5a0mr123434edb.0.1707644456561; Sun, 11 Feb
 2024 01:40:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209211528.51234-1-jdamato@fastly.com> <20240209211528.51234-5-jdamato@fastly.com>
In-Reply-To: <20240209211528.51234-5-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 11 Feb 2024 10:40:45 +0100
Message-ID: <CANn89iKB=_C4kZ1SFF18DXXaOdL4hXcLAZLWMT3w=-nHyWPaoA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 4/4] eventpoll: Add epoll ioctl for epoll_params
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	chuck.lever@oracle.com, jlayton@kernel.org, linux-api@vger.kernel.org, 
	brauner@kernel.org, davem@davemloft.net, alexander.duyck@gmail.com, 
	sridhar.samudrala@intel.com, kuba@kernel.org, willemdebruijn.kernel@gmail.com, 
	weiwan@google.com, David.Laight@aculab.com, arnd@arndb.de, sdf@google.com, 
	amritha.nambiar@intel.com, Jiri Slaby <jirislaby@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nathan Lynch <nathanl@linux.ibm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maik Broemme <mbroemme@libmpq.org>, 
	Steve French <stfrench@microsoft.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Julien Panis <jpanis@baylibre.com>, Thomas Huth <thuth@redhat.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 10:15=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Add an ioctl for getting and setting epoll_params. User programs can use
> this ioctl to get and set the busy poll usec time, packet budget, and
> prefer busy poll params for a specific epoll context.
>
> Parameters are limited:
>   - busy_poll_usecs is limited to <=3D s32_max
>   - busy_poll_budget is limited to <=3D NAPI_POLL_WEIGHT by unprivileged
>     users (!capable(CAP_NET_ADMIN))
>   - prefer_busy_poll must be 0 or 1
>   - __pad must be 0
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Acked-by: Stanislav Fomichev <sdf@google.com>
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> ---
>  .../userspace-api/ioctl/ioctl-number.rst      |  1 +
>  fs/eventpoll.c                                | 72 +++++++++++++++++++
>  include/uapi/linux/eventpoll.h                | 13 ++++
>  3 files changed, 86 insertions(+)
>
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documen=
tation/userspace-api/ioctl/ioctl-number.rst
> index 457e16f06e04..b33918232f78 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -309,6 +309,7 @@ Code  Seq#    Include File                           =
                Comments
>  0x89  0B-DF  linux/sockios.h
>  0x89  E0-EF  linux/sockios.h                                         SIO=
CPROTOPRIVATE range
>  0x89  F0-FF  linux/sockios.h                                         SIO=
CDEVPRIVATE range
> +0x8A  00-1F  linux/eventpoll.h
>  0x8B  all    linux/wireless.h
>  0x8C  00-3F                                                          WiN=
RADiO driver
>                                                                       <ht=
tp://www.winradio.com.au/>
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 1b8d01af0c2c..aa58d42737e6 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -37,6 +37,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/compat.h>
>  #include <linux/rculist.h>
> +#include <linux/capability.h>
>  #include <net/busy_poll.h>
>
>  /*
> @@ -494,6 +495,49 @@ static inline void ep_set_busy_poll_napi_id(struct e=
pitem *epi)
>         ep->napi_id =3D napi_id;
>  }
>
> +static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
> +                                 unsigned long arg)
> +{
> +       struct eventpoll *ep =3D file->private_data;
> +       void __user *uarg =3D (void __user *)arg;
> +       struct epoll_params epoll_params;
> +
> +       switch (cmd) {
> +       case EPIOCSPARAMS:
> +               if (copy_from_user(&epoll_params, uarg, sizeof(epoll_para=
ms)))
> +                       return -EFAULT;
> +
> +               /* pad byte must be zero */
> +               if (epoll_params.__pad)
> +                       return -EINVAL;
> +
> +               if (epoll_params.busy_poll_usecs > S32_MAX)
> +                       return -EINVAL;
> +
> +               if (epoll_params.prefer_busy_poll > 1)
> +                       return -EINVAL;
> +
> +               if (epoll_params.busy_poll_budget > NAPI_POLL_WEIGHT &&
> +                   !capable(CAP_NET_ADMIN))
> +                       return -EPERM;
> +
> +               ep->busy_poll_usecs =3D epoll_params.busy_poll_usecs;

You need WRITE_ONCE(ep->XXX, val); for all these settings.

> +               ep->busy_poll_budget =3D epoll_params.busy_poll_budget;
> +               ep->prefer_busy_poll =3D epoll_params.prefer_busy_poll;
> +               return 0;
> +       case EPIOCGPARAMS:
> +               memset(&epoll_params, 0, sizeof(epoll_params));
> +               epoll_params.busy_poll_usecs =3D ep->busy_poll_usecs;

You need to use READ_ONCE(ep->XXXXX) for the three reads.


> +               epoll_params.busy_poll_budget =3D ep->busy_poll_budget;
> +               epoll_params.prefer_busy_poll =3D ep->prefer_busy_poll;
> +               if (copy_to_user(uarg, &epoll_params, sizeof(epoll_params=
)))
> +                       return -EFAULT;
> +               return 0;
> +       default:
> +               return -ENOIOCTLCMD;
> +       }
> +}
>

