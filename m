Return-Path: <linux-fsdevel+bounces-68697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D36B9C63650
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 11:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40F074ED554
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9788326959;
	Mon, 17 Nov 2025 09:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiJjkxxy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D8932693E
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763373295; cv=none; b=mKRXwQKERSHBEgX0BoHbNr/oDcUJLr5/W8C4q/B/GS3unS/tf/7KqFZICbwwfSTeI+KXX7TaYGifAe8Ufo4u0ViAnbIkKuTyPUYM/0so/bmMjYtSMJ+MBTvOpBN8mYc+LMVEnxGtGYpQJJuoDi831Hd3UjSMZR/N4riBt+bxnH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763373295; c=relaxed/simple;
	bh=Sq6XqvBZkB8fha8KTcX4NhCd+BWInkkAfhiFpYhrrmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5AGjJmB88volVWTTtuzmGN0J642uRIfWGW50xRp+Bba3XwfhDjejauqxPYOve8tMqUr2+ZRKgslNnBMK0AMUDFqWDOguahV8Uim2nGixJaiQFTvhtg/aWsTLF1I5LdNYxM+rxkw76wlRqvORw3p8210XKgYZK/56yOl2GrHRfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiJjkxxy; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-641977dc00fso6018100a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 01:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763373291; x=1763978091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTg1Eio4X3VqSUi2eoOlE7s1YeLwP1vF9ryfZs49llc=;
        b=RiJjkxxyz7HRuModnWCWhXcWElUW5jv8faunhkPXsf/bKHJso0bgmh96BCyOV1Vbd3
         PLvYj4A7U0IkyykbZGqF8Izu7MiT+nkrXWacipu38idmJ9+4fPjs7BSziwo+KGtXy0wa
         QVg93GvfV6moEidbVDHEUi1ohAuakdLfr6LXMq9/HbFKygF9N2Qq6uv3Z1O8tV+6SUAl
         u9cO5v4zmaMsKbEGdkRIp0eCpsZ2Zp1VJ6WZnQmOG3sdndE/h5EhMQlc4PZl3o3v4E89
         SL9/E0oNSGANf0uB3m4awWhlsP6RneAXHzuzRcLG/FsWGuOjABXOinsgme9tdtzq6GaZ
         eBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763373291; x=1763978091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MTg1Eio4X3VqSUi2eoOlE7s1YeLwP1vF9ryfZs49llc=;
        b=uRMDLiLk37kIgr6BRXdLLPGPTqwzLn9iRF//snsMAlgZhZ7FEfdO86Uah1feTAZNxC
         xVUqOFO3fnk2mNDtW3FQJwj9jz0qQqTqbzLMGBWli0O1w7SHE/YsnU7thcE2eB+lW4Nb
         web34XOpSmZ8fwd8pBoilfZqYjliDkBvDQGCy7m7n0YWeIhO9fakkDnBALYxomBC1Vay
         1BqkNuh4bQ7GLn7unqh2SAVUsgFaP0Jf+iaAT97Tr+GNmxU8JATJ4iUhE2YHSVMWqpN6
         gEwzdlaCM/LY9S47pAaXFAzY/4IIUnPUsxbg7FlyKO+zfZ5J6NCBjLJHV47arqF5QxBl
         uqRg==
X-Forwarded-Encrypted: i=1; AJvYcCV0G3OIraOdBwMaAD4XGAR1JmtGaJbwqohVZIMHv2ZMe0rsdw6CCnWBiz8HWSCglhEFyBceO6iiWRNiTUd3@vger.kernel.org
X-Gm-Message-State: AOJu0YwDM3FiYkfkpUrcmq03rlAgDCUZ/w/d5chPRFPwQZagDbP9xTk8
	x+okZc0sm8AysPk2pLcZfsBiNLSSHCkLSvAo9JKM8t0kI4vfdiprpjHB4j6wlY2/ze+Jeguwz4W
	WYI6Gwljq/YNO0kBPEB6Bn/XC4OIRymQ=
X-Gm-Gg: ASbGncuNKjHrXuZqypMUKMfYBuVNbC0laeb70I+Q0rgamdcgOmndgwqTlpERHM6Ywuj
	L0R6Jb8sbHxpIu5KCspRSVW2UU0xH8CduB7/MAeFut7H1LuzteMYsyqwi1qm3Pena5vscGmYg7p
	ej6Hr/ODQf3+XY/DPDi+1Fg8ZOIa11oEUli26if9Kanxu/LAabsEihwsonLURyczdEyj/49j/4T
	MZnW9hW/89xeqn6Mi4MmZUKMIIZ6/IPWRg2k1/d68KZbXsoIcP85i3TugdWiKe7st/VlDrJS+tl
	FQyh6eaWggbhPJUbJTAKOajSeE28
X-Google-Smtp-Source: AGHT+IGy9DWFWr+RXtz0d8ABvdTZRXDdE0uEFw3LKJbf6mZCjHyTyTh/Kdh2a0a0Mi9SZ22Y72lQbelNwFVMMQRASg8=
X-Received: by 2002:a05:6402:40cd:b0:63e:7149:5155 with SMTP id
 4fb4d7f45d1cf-64350e0357amr10715041a12.2.1763373291081; Mon, 17 Nov 2025
 01:54:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117-work-ovl-cred-guard-prepare-v2-0-bd1c97a36d7b@kernel.org>
 <20251117-work-ovl-cred-guard-prepare-v2-3-bd1c97a36d7b@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-prepare-v2-3-bd1c97a36d7b@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 17 Nov 2025 10:54:39 +0100
X-Gm-Features: AWmQ_bmBoEsDLSNwYFYj7-aDSXZBuBOn8-m887mVkUu_WsT_rXo-drDLD3oyBmk
Message-ID: <CAOQ4uxh_T8uJf389O1Hx42SMCPDhdwfNCXzo5qSD2XUVAyFyCA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] ovl: reflow ovl_create_or_link()
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 10:35=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> Reflow the creation routine in preparation of porting it to a guard.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/overlayfs/dir.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index dad818de4386..150d2ae8e571 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -644,6 +644,15 @@ static const struct cred *ovl_setup_cred_for_create(=
struct dentry *dentry,
>         return override_cred;
>  }
>
> +static int do_ovl_create_or_link(struct dentry *dentry, struct inode *in=
ode,
> +                                struct ovl_cattr *attr)
> +{
> +       if (!ovl_dentry_is_whiteout(dentry))
> +               return ovl_create_upper(dentry, inode, attr);
> +
> +       return ovl_create_over_whiteout(dentry, inode, attr);
> +}
> +
>  static int ovl_create_or_link(struct dentry *dentry, struct inode *inode=
,
>                               struct ovl_cattr *attr, bool origin)
>  {
> @@ -662,7 +671,6 @@ static int ovl_create_or_link(struct dentry *dentry, =
struct inode *inode,
>                                 return err;
>                 }
>
> -               if (!attr->hardlink) {
>                 /*
>                  * In the creation cases(create, mkdir, mknod, symlink),
>                  * ovl should transfer current's fs{u,g}id to underlying
> @@ -676,16 +684,15 @@ static int ovl_create_or_link(struct dentry *dentry=
, struct inode *inode,
>                  * create a new inode, so just use the ovl mounter's
>                  * fs{u,g}id.
>                  */
> +
> +               if (attr->hardlink)
> +                       return do_ovl_create_or_link(dentry, inode, attr)=
;
> +
>                 new_cred =3D ovl_setup_cred_for_create(dentry, inode, att=
r->mode, old_cred);
>                 if (IS_ERR(new_cred))
>                         return PTR_ERR(new_cred);
> -               }
> -
> -               if (!ovl_dentry_is_whiteout(dentry))
> -                       return ovl_create_upper(dentry, inode, attr);
> -
> -               return ovl_create_over_whiteout(dentry, inode, attr);
>
> +               return do_ovl_create_or_link(dentry, inode, attr);
>         }
>         return err;
>  }
>
> --
> 2.47.3
>

