Return-Path: <linux-fsdevel+bounces-26500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A804C95A2DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 18:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44E21C21E16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 16:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440FE16A925;
	Wed, 21 Aug 2024 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fBcubZHl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8F55D8F0
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257948; cv=none; b=jvY704ME5ZSprCtTKnIdFoOE47c97tlQ54ncl+5WOlGTuYNx88VWT962AXpSwYKzzopydGYlK8E+uO92Tqfwlgqmotm6EXbo20T38tXPelAnZpzOsg4f+5v04O7DeKoCGuR7pxK02UF0WmsB8U89UcsX3Q0B9TXJvp2Umgjb98g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257948; c=relaxed/simple;
	bh=y0LywhCmh47VypaLFq+kEyR/qD8qT8iwJl5GVT+ZjgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0GzbAXAvpQBbTZq6ASk08yCEIHQ8ebUjS4UrkJqWPm0hfVGDZEVdByyhczLaag9E33vnSaEI+eMHGG8hO+F1daVF0B4HvTq5Hm5AcmsXcNYJG28v9GJh/JkIDAvRM7e9uDoXMg58r3jQHbfp3MSAawwWzgvxYpV6GgoH5vEySY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fBcubZHl; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e1171e57a0dso808661276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 09:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724257945; x=1724862745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKjQ6emtyPrVDj7dWj9Yt0Rk11OdLkP0YY5ZqjmKqLI=;
        b=fBcubZHlN2QMKZFq5CpzyjFAB2tiH9uV96sIzPZKB98i4e/2bsr5SN9faq9iEbK5pN
         4qMwjofgBWfDXHK5pbQm0fuhyFnjfhXvy0d+gs4gPcgkToAFtju/sKhZcQnaOyP5wCNN
         SpiFKG6nZbcyoHFXl04TT9MuKXb8F5gueWYid0M4SrfBV2rmCz0PaVBgn/JTZ2mnlC91
         N5rMEkRLdDSAJ1zSwczEV/KoL5YawJj8Wm+sT80loWm4w6DeueosadS582iMaVci5CCV
         IGKB7458UsdDqrbD2A1+YdOXMAhx0lmOKb09Kfcan9KofMy3afq5zRu5dTnr7eQEYMhE
         stKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724257945; x=1724862745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKjQ6emtyPrVDj7dWj9Yt0Rk11OdLkP0YY5ZqjmKqLI=;
        b=e3bYW7uJ4WALS9KyN9JeR4JZ6LxKxpJg8Ocj8NTOPE1uUlplzInlVOfZGqcxJ7XECX
         xJq7s8Gh4k5EnqCdQNVhcaVuXssKTmY+7upqURtvl4FntKs7ARuv9rEvpuTvEvOyZPsF
         p2NstYjwaxCh+4BLzQlZOAB8j7Dk/ocUHRuYalt85S4OfwVTCKq+8crq91Jhna8iQ3Y5
         piinfIZFqAc9iffOlIFOnvNqz2COScfafkp5kp+QDY5fa/Ls/uDxBufznkzgG6uCwrre
         gfTnPtjACqR1aKMTkXqn+Wm6g7ynKtQtAnNSl/guxE+XCo9r8ve9IYNm3rm3DUnwaUIS
         IJwA==
X-Forwarded-Encrypted: i=1; AJvYcCXaD4OeZ9Bcs9udjxpjAc2IWgSOGhWR17KBs+yc76O5UwJsSXH9XwA/CLNjGcr8y1aMAKEKzMPv2p/M4kpH@vger.kernel.org
X-Gm-Message-State: AOJu0YxTJbn7Q5UgE/M25Jo2zatg1pPRlflJntnqaDtnVYMEX5fS03Lm
	bsowiH5Vje9ZTVqMTlr40Ym5RBfnDfrU2jybdRx4tAwzoNR8EpbeswC6Ui9Dg++Eig74tleRLR8
	6fHlk3/TBe23XrAQjbfqQik1FnaYeKh8V7dw6
X-Google-Smtp-Source: AGHT+IHqtEaRs3bfyjoduUwqbGszfFJZ/MXDKylcokqkjlSrKLoHtDO/7RqpwJwZHHVzLv9J+rL+3ZDsUcQ+ap2YLkU=
X-Received: by 2002:a05:690c:908:b0:627:7f2a:3b0d with SMTP id
 00721157ae682-6c304879b22mr2005647b3.14.1724257944842; Wed, 21 Aug 2024
 09:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821095609.365176-1-mic@digikod.net>
In-Reply-To: <20240821095609.365176-1-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Aug 2024 12:32:17 -0400
Message-ID: <CAHC9VhQ7e50Ya4BNoF-xM2y+MDMW3i_SRPVcZkDZ2vdEMNtk7Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fs: Fix file_set_fowner LSM hook inconsistencies
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Casey Schaufler <casey@schaufler-ca.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 5:56=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> The fcntl's F_SETOWN command sets the process that handle SIGIO/SIGURG
> for the related file descriptor.  Before this change, the
> file_set_fowner LSM hook was always called, ignoring the VFS logic which
> may not actually change the process that handles SIGIO (e.g. TUN, TTY,
> dnotify), nor update the related UID/EUID.
>
> Moreover, because security_file_set_fowner() was called without lock
> (e.g. f_owner.lock), concurrent F_SETOWN commands could result to a race
> condition and inconsistent LSM states (e.g. SELinux's fown_sid) compared
> to struct fown_struct's UID/EUID.
>
> This change makes sure the LSM states are always in sync with the VFS
> state by moving the security_file_set_fowner() call close to the
> UID/EUID updates and using the same f_owner.lock .
>
> Rename f_modown() to __f_setown() to simplify code.
>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Ondrej Mosnacek <omosnace@redhat.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>
> Changes since v2:
> https://lore.kernel.org/r/20240812174421.1636724-1-mic@digikod.net
> - Only keep the LSM hook move.
>
> Changes since v1:
> https://lore.kernel.org/r/20240812144936.1616628-1-mic@digikod.net
> - Add back the file_set_fowner hook (but without user) as
>   requested by Paul, but move it for consistency.
> ---
>  fs/fcntl.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)

This looks reasonable to me, and fixes a potential problem with
existing LSMs.  Unless I hear any strong objections I'll plan to merge
this, and patch 2/2, into the LSM tree tomorrow.

> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 300e5d9ad913..c28dc6c005f1 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -87,8 +87,8 @@ static int setfl(int fd, struct file * filp, unsigned i=
nt arg)
>         return error;
>  }
>
> -static void f_modown(struct file *filp, struct pid *pid, enum pid_type t=
ype,
> -                     int force)
> +void __f_setown(struct file *filp, struct pid *pid, enum pid_type type,
> +               int force)
>  {
>         write_lock_irq(&filp->f_owner.lock);
>         if (force || !filp->f_owner.pid) {
> @@ -98,19 +98,13 @@ static void f_modown(struct file *filp, struct pid *p=
id, enum pid_type type,
>
>                 if (pid) {
>                         const struct cred *cred =3D current_cred();
> +                       security_file_set_fowner(filp);
>                         filp->f_owner.uid =3D cred->uid;
>                         filp->f_owner.euid =3D cred->euid;
>                 }
>         }
>         write_unlock_irq(&filp->f_owner.lock);
>  }
> -
> -void __f_setown(struct file *filp, struct pid *pid, enum pid_type type,
> -               int force)
> -{
> -       security_file_set_fowner(filp);
> -       f_modown(filp, pid, type, force);
> -}
>  EXPORT_SYMBOL(__f_setown);
>
>  int f_setown(struct file *filp, int who, int force)
> @@ -146,7 +140,7 @@ EXPORT_SYMBOL(f_setown);
>
>  void f_delown(struct file *filp)
>  {
> -       f_modown(filp, NULL, PIDTYPE_TGID, 1);
> +       __f_setown(filp, NULL, PIDTYPE_TGID, 1);
>  }
>
>  pid_t f_getown(struct file *filp)
> --
> 2.46.0

--=20
paul-moore.com

