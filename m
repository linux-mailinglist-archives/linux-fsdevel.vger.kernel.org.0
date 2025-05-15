Return-Path: <linux-fsdevel+bounces-49137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A424AB87DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 15:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5201BA8951
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 13:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164D21448D5;
	Thu, 15 May 2025 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="UbHWgPgJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1607F25761
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747315376; cv=none; b=P0XLAISGfMOjBHTHxx6N+MCRKz2o37UJY1H0HwbxtbaC42Qd3keuJGFIpLzJwKG9tGnNa+9ENL0DClSjhgY/K4/A4uqgrzgCySIG+OE9+3tWFDJ52BfiWvrno0YmukMMq2zxmW0X70DCu3WFNa0TbDyT3wZVVWBGBVT0XKYO4Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747315376; c=relaxed/simple;
	bh=EgyG0ArL+HtCA+Jm/wHgbZXmmR3n8RySP1ZgRGQZxWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLYDhSRG0NvAOczgFeOHoGV4rRffz+yfMf/kQHKKd6MPE4GpprJgUzRlFCbsigGpy2MqQvrXLewPG8AgAEHIg2mWYjqyWwyqFYmybPGyzg4752dgjkT2UZgIwc5N3IG42eH1OWvTuLVx7DX/nV7U228ervHQ8pGumbdn9GjJ8pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=UbHWgPgJ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54d6f93316dso986565e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 06:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1747315372; x=1747920172; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xpwhDrJcmdUxr+aMMW8YmzS8jkn0TpvM55yuHoJ1Wh0=;
        b=UbHWgPgJlT4zTzCgy6zO4SjqWDOSZqkfB9SCmeVPKfQ0rlrNfu0HZLugjQIUYDrDNO
         oc1Py+EGVpmlqffPhblY7k7P7Mc7HoxI4VNO6GDySG2D0t6rV/oeLAG8g6wUoN6zU8dz
         hKTpqqzaEV+VxyFVFbtDYgLCu/eLQpSvwtiSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747315372; x=1747920172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xpwhDrJcmdUxr+aMMW8YmzS8jkn0TpvM55yuHoJ1Wh0=;
        b=tC8vqf2YymudzqF3gp/z40nJcRb5mqdnZGyJxpWh/5/VcW/MxbdLjP3LS88aogl/Yc
         RkiijL6r6LBxsvzLznIZgptqTq3tXvLaYcyamCuBT70dp001k/Uvba5y14s/g03Lz5Tb
         6Urcv+T8bnMUVe7vX01ZUsvoUieBEfIx0wdZz3Y7+IlD5S0Ajl8eY1z3AhK7wgg8i/bX
         mZnqMsT7VBHRnTsySztZll4ZjXiSnJXzaO3AVDTunfHUBxLzyX81RKdcQZoVMxY2fZ3y
         sxYHWWgyhsli9FMBLoA/TKWXM0cwInr6g3VTCMEE6OBbdnMl2nLQof8PxxQH4tvLQUiQ
         YbhA==
X-Gm-Message-State: AOJu0Yy+KnT8oJy6amdPGiCQkTO6KLkg1DEDRbGfSd0XjchjjElZx6dN
	iSnc6eSS/ZKKkWWqGry5EgK60VUi4vb72YQMwmdabNpPi8G219YNUJ78eMmMM47qBpf4ZAxkUxt
	5LNxQ3jaUjZE8sIVgRCI3xySOjo0t44scSx2ZsQ==
X-Gm-Gg: ASbGnctkAyJo9vYdpPu+iQRs5JMg2wbIo2Qed+e2EtaSJg6qs4VszfXM83ZkC6ZXlpn
	PT1qSO8wrEJQTmrBp7cqrTvSgK18XOB5oTQ+WA7KtERNSRm0b7ZAbu+aDZx8shcsoMrMx9N1ffM
	lzJIOYglpnGj3b5U37yI+CoJtaoI/tRbyb7A==
X-Google-Smtp-Source: AGHT+IEhwlbgn+32pxYI1ofa/s6/2TQuFwALvt46bLIhQPT10vzlVoBp8hOxpg+dlGoYiEgJcm1faLY456zUlXZ1SjY=
X-Received: by 2002:a05:6512:b03:b0:54f:ca5e:13ac with SMTP id
 2adb3069b0e04-550d5fb8f3amr3444086e87.31.1747315371956; Thu, 15 May 2025
 06:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org> <20250515-work-coredump-socket-v7-3-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-3-0a1329496c31@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 15 May 2025 15:22:40 +0200
X-Gm-Features: AX0GCFuJsLCvWcVGqgJhD9YjQcGy9FnFS3GMK4AhS0yialHNeCeiDfFFREAeYEU
Message-ID: <CAJqdLroB-JGEQTdDzQXZSHCETmY=gvgSr9sKGEza0LaYiuOvqw@mail.gmail.com>
Subject: Re: [PATCH v7 3/9] coredump: reflow dump helpers a little
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Do., 15. Mai 2025 um 00:04 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> They look rather messy right now.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/coredump.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 0e97c21b35e3..a70929c3585b 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -867,10 +867,9 @@ static int __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
>         struct file *file = cprm->file;
>         loff_t pos = file->f_pos;
>         ssize_t n;
> +
>         if (cprm->written + nr > cprm->limit)
>                 return 0;
> -
> -
>         if (dump_interrupted())
>                 return 0;
>         n = __kernel_write(file, addr, nr, &pos);
> @@ -887,20 +886,21 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
>  {
>         static char zeroes[PAGE_SIZE];
>         struct file *file = cprm->file;
> +
>         if (file->f_mode & FMODE_LSEEK) {
> -               if (dump_interrupted() ||
> -                   vfs_llseek(file, nr, SEEK_CUR) < 0)
> +               if (dump_interrupted() || vfs_llseek(file, nr, SEEK_CUR) < 0)
>                         return 0;
>                 cprm->pos += nr;
>                 return 1;
> -       } else {
> -               while (nr > PAGE_SIZE) {
> -                       if (!__dump_emit(cprm, zeroes, PAGE_SIZE))
> -                               return 0;
> -                       nr -= PAGE_SIZE;
> -               }
> -               return __dump_emit(cprm, zeroes, nr);
>         }
> +
> +       while (nr > PAGE_SIZE) {
> +               if (!__dump_emit(cprm, zeroes, PAGE_SIZE))
> +                       return 0;
> +               nr -= PAGE_SIZE;
> +       }
> +
> +       return __dump_emit(cprm, zeroes, nr);
>  }
>
>  int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
>
> --
> 2.47.2
>

