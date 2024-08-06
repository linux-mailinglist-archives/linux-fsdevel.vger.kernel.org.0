Return-Path: <linux-fsdevel+bounces-25186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EEA9499E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 23:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308931F222A9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 21:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5521616C6AB;
	Tue,  6 Aug 2024 21:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d98y//Cx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567B31EB2A;
	Tue,  6 Aug 2024 21:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722978520; cv=none; b=OiZPrGL2kz8fjKyz1aWxP3exkdf78CNvcj1O7OmhfFW2YSoWxlEUivpRhDhjuRSPnBiYxU3gQafQOXvX0NKmH/DsTYDkggHotNM5DnI1++CgUGjm6yjevPKq+FnqMTJMo+SEZMT+VKz6Hbt+ETuabP7XuTogeZIcNlRXwwnXnP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722978520; c=relaxed/simple;
	bh=U3DpBlQ40wWqHijbiteh/PUvq86D6Ojkqqerf+Lbke0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZD2p1I8zk4GwwhIUOUWbosJOs86fR6E8MoP2KreavnAd1ppwikSgB+Eb5AhWghrjwNFj4nKt1SADukuk9SDtHPvkZO85acMFRvVHllBNwciM2V5Cjs4lPYDu6isjJMnGuQ6/EF/1D4yH51cos4HjYFKJ1uMis87UwTngTaeJXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d98y//Cx; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2cfdc4deeecso934748a91.3;
        Tue, 06 Aug 2024 14:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722978518; x=1723583318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPDFztU8EEvGIRMjQoMfPc2pyQDFPqx9uMpc17voEHk=;
        b=d98y//CxSYETCC/xWDUEVInPsgkzskpfPyMnN7w3aTHcuaeD8BBRdbNu0s+2kJtcJL
         TuASUg9ps/Fs61yEaHGU9dACxp7DHMA+5p1JjNWmujkF7rfd3/XRwxfesR7TM0+k6ccr
         A7bHWIcUNWWNdfziVYEErH/QS0gxcQa3DH0e1fSpGYlKzX+4MAwX7i1GJLlVCcuFeknw
         aT5VDD8/IseG44cwIQLpSmWImJKKyLhBkFSIe95bgtRMvdxXWcC9uqHAbYM/35kCFkv4
         lPpVIr6ceYeZ0lMhq06wS/rW/e2X7JEP4pIS9J+MBuwNrUsQs69k1AROwsoKcYfWEVp6
         Y5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722978518; x=1723583318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPDFztU8EEvGIRMjQoMfPc2pyQDFPqx9uMpc17voEHk=;
        b=kZseu9WIahrNJOGwPp5kdvKH05KMc5YgVFLZWvwa8QTq7mEmnxqwPGANruXTa6gPcp
         +uUbSeq6STkagU1u9oq24cMi64dd40eRhuBHXZlIpDwKAXcF+ol7xso3t5+GsNRDTelB
         /A2FLuot4K7aWr1AfSQIdn1FkF3B2jAYuiaEA91qDC5+xhF+Jusby3om7sPplnTDvQQk
         CK430OFeVSJ/BRsbPEfg5xLI+5E6kcgr8EK//PpICgCnRRfCxRQ/H3DzZo5/bBV3cgEz
         VIt4E3PUNTIedpqKGyLdoJHtSgSoNTKFAOMY7m3/lmQw57EHcJGCVNP9QZQ2qizA9yp/
         PWPg==
X-Forwarded-Encrypted: i=1; AJvYcCX/23h5DB4C0zDmB6OFv0lhNhB1KI/ONXQrA2dXutTkJtLy4Yzz/DmW/Eky3Wqq13AlAnB2HeyvAq8YUYA6jprtqv9UMn6pibfNBOn25B40ywbXJiThAXMZxMsZ+hcMyggsD+C8R6SApqYdJB9Ec7RZU0nCKpTcXvU80LVs9EPaSz6GZoI/Xh832w==
X-Gm-Message-State: AOJu0YwX8CHzRgiGIQQDxl8eUKd9OaVsET46HP33g0RytMWIZZCPU611
	rqklroSS8nnYkfGzD+Jk9It/9ZuTPoCLCLj22s13CIXeQYcqOaSV4TqqDbMZGHwXDHJCW0UmlLU
	dWBHoSuBqWFuqmpZ+b/40xRVfgxx7YJ5T
X-Google-Smtp-Source: AGHT+IFVHKrm49Cl+S3RHubuY1rqIQ/ciWyH53GdfgbOAbDUnn5faWGt9O2UUP44AAk5gslfMqpigc+h6smZoWk5nLI=
X-Received: by 2002:a17:90a:7307:b0:2c9:6f06:8005 with SMTP id
 98e67ed59e1d1-2cff9524412mr18387005a91.26.1722978518414; Tue, 06 Aug 2024
 14:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730050927.GC5334@ZenIV> <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-16-viro@kernel.org>
In-Reply-To: <20240730051625.14349-16-viro@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 6 Aug 2024 14:08:26 -0700
Message-ID: <CAEf4BzasCg8o2qc14kYkChT78jdkVsYXhGW3zUWjhmoAgDkkKw@mail.gmail.com>
Subject: Re: [PATCH 16/39] convert __bpf_prog_get() to CLASS(fd, ...)
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	brauner@kernel.org, cgroups@vger.kernel.org, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 10:19=E2=80=AFPM <viro@kernel.org> wrote:
>
> From: Al Viro <viro@zeniv.linux.org.uk>
>
> Irregularity here is fdput() not in the same scope as fdget();
> just fold ____bpf_prog_get() into its (only) caller and that's
> it...
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  kernel/bpf/syscall.c | 32 +++++++++++---------------------
>  1 file changed, 11 insertions(+), 21 deletions(-)
>

Folding makes total sense, the logic lgtm (though I find CLASS(fd,
f)(ufd) utterly non-intuitive naming-wise). Extra IS_ERR(prog) check
should be dropped though, see below.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 3093bf2cc266..c5b252c0faa8 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2407,18 +2407,6 @@ int bpf_prog_new_fd(struct bpf_prog *prog)
>                                 O_RDWR | O_CLOEXEC);
>  }
>
> -static struct bpf_prog *____bpf_prog_get(struct fd f)
> -{
> -       if (!fd_file(f))
> -               return ERR_PTR(-EBADF);
> -       if (fd_file(f)->f_op !=3D &bpf_prog_fops) {
> -               fdput(f);
> -               return ERR_PTR(-EINVAL);
> -       }
> -
> -       return fd_file(f)->private_data;
> -}
> -
>  void bpf_prog_add(struct bpf_prog *prog, int i)
>  {
>         atomic64_add(i, &prog->aux->refcnt);
> @@ -2474,20 +2462,22 @@ bool bpf_prog_get_ok(struct bpf_prog *prog,
>  static struct bpf_prog *__bpf_prog_get(u32 ufd, enum bpf_prog_type *atta=
ch_type,
>                                        bool attach_drv)
>  {
> -       struct fd f =3D fdget(ufd);
> +       CLASS(fd, f)(ufd);
>         struct bpf_prog *prog;
>
> -       prog =3D ____bpf_prog_get(f);
> -       if (IS_ERR(prog))
> +       if (fd_empty(f))
> +               return ERR_PTR(-EBADF);
> +       if (fd_file(f)->f_op !=3D &bpf_prog_fops)
> +               return ERR_PTR(-EINVAL);
> +
> +       prog =3D fd_file(f)->private_data;
> +       if (IS_ERR(prog))       // can that actually happen?

no, it can't, private_data will always be a valid pointer, otherwise
that file would never be successfully created

>                 return prog;
> -       if (!bpf_prog_get_ok(prog, attach_type, attach_drv)) {
> -               prog =3D ERR_PTR(-EINVAL);
> -               goto out;
> -       }
> +
> +       if (!bpf_prog_get_ok(prog, attach_type, attach_drv))
> +               return ERR_PTR(-EINVAL);
>
>         bpf_prog_inc(prog);
> -out:
> -       fdput(f);
>         return prog;
>  }
>
> --
> 2.39.2
>
>

