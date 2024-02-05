Return-Path: <linux-fsdevel+bounces-10324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 785B8849D13
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 15:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2C91C24941
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 14:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634862C1B5;
	Mon,  5 Feb 2024 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI0Xd/8S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858002C19C;
	Mon,  5 Feb 2024 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143487; cv=none; b=BNSow1HwB3M/aHT3rncoAgFInmC1NGfvp9yNyt/DDEAw/4Ylrt8w8nKc0GKF99lFaXUcSCuWl3mKWbUFZ4hFUiZ0pH9kP8z1wtFq+axLtyqdlMllo+3dgeBxJn+L6rNomSWPDIMOG/FtBkqp7MybeaW0HEbGmCckz0SGiHd22C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143487; c=relaxed/simple;
	bh=vB2CucJIHYQw9yXikZUQXpzjmRCNVBBJ96ZHLmXzccA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHhoBuA6BoccLrmT3hcAXBZn0S4gGwxFIBmt8ih/U9lq/9bvc/Uezqm0ULfIeVhLomrbxdG/74VzBp8XJjA19FR7bbbqJoc4mQyZsdfeYAuici7+RyacfGR0PQ7ij0QIEp3Dt7N/ELONHQLhsRB+hz2reRCiuJuuTTbvvyan8kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DI0Xd/8S; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29080973530so3635156a91.1;
        Mon, 05 Feb 2024 06:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707143485; x=1707748285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xeN9yJ2dQGs6jig9OgjqCQqlFO+WtiSIe/SoY3+XhmQ=;
        b=DI0Xd/8SIL1OVHB/ENhm6vG5GaBzrkIghKr5sZ5Z07Jsna+Y7Z50yiARDZwpe7O0j9
         ig9TwbDGmnISqSEKnTeuEynZcHUzP3N1WTfuN/vOjwiCArrwUi41KcfwKSZXnM0my7Da
         Q9G3cSwY04ewdNxckUecPr/elZKkzwWoe+UMhCkZM3Vm4GpL5LzbEQuF8Aed0KJDnpl1
         DRYB1S8t2MC+Vw/dYEQUuESJCR7v39RkuzCd/OXAPq48ILRgx5kbVFtymhdBSqlIvoC6
         KzVIYgoHNVQz1aX5PH0Akbk844Y024HMGtnD1+mhP6DKWo7kNutKl8cI9aR489nx6sQ+
         9fcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707143485; x=1707748285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xeN9yJ2dQGs6jig9OgjqCQqlFO+WtiSIe/SoY3+XhmQ=;
        b=JpuLDi1tIFTU9Tp1PW+5S7Ic5zELptTAPK+mNC+mgpuTXADxe3DwfthvevjkpJgLE+
         4vXBypA2NWq470sH6BKlYKp7Cp0EzdFEkbbNirXAGCBVPW69fUIPcUh0jlo/5q0Ut3Eb
         OxXIy90PzEdafiHjah+NH1yY75r7sAJ/tsT3Se0RHPUxuq4HS8DguKXw7nZNOYxLSZCv
         LUgT+cEJ1cAr5Q+CQ9+9+D6K4F0chgFqzD3DhaG/2BB4rhkaJ40vEMe20Mr+azetFsDG
         zTN4D0K/MKqS2o09INdF9g9cn5TqRejGYAB/zJ+sIj6OOaF3jnkpWnkhVUk6lIs9lhru
         ybXQ==
X-Gm-Message-State: AOJu0YwMPREis+HL71hcbwOUX/hGgLOqw3HKJI28KcF4Hb4gX2EKSxfq
	G7hGCzQdkSk+OzGa7SchYBXu+N2di9A11T2bR3J8UmMQKLT20J1JhGLMgSaCPp2kfMjCr/py0IQ
	kOSpz4uvZE+Iv+mkudJaBGwMG+BltGYC+
X-Google-Smtp-Source: AGHT+IEioUX3dA1lS9t0kJPFYTkeeTRGjpJdaW6VcH7dBGLqReC45Rwpm07BQxt7Nf8HS0ucwqnC87U+i3GIdvyYQuE=
X-Received: by 2002:a17:90a:fc83:b0:296:2d0f:bba8 with SMTP id
 ci3-20020a17090afc8300b002962d0fbba8mr9992598pjb.43.1707143485338; Mon, 05
 Feb 2024 06:31:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118150637.660461-1-jcmvbkbc@gmail.com>
In-Reply-To: <20240118150637.660461-1-jcmvbkbc@gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 5 Feb 2024 06:31:13 -0800
Message-ID: <CAMo8BfL+j5XUit2b7UjmZfZJCGd-gyh3Aia4FhLAm7YHNm0Fdg@mail.gmail.com>
Subject: Re: [PATCH] fs: binfmt_elf_efpic: don't use missing interpreter's properties
To: linux-kernel@vger.kernel.org
Cc: Chris Zankel <chris@zankel.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Greg Ungerer <gerg@linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping?

On Thu, Jan 18, 2024 at 7:07=E2=80=AFAM Max Filippov <jcmvbkbc@gmail.com> w=
rote:
>
> Static FDPIC executable may get an executable stack even when it has
> non-executable GNU_STACK segment. This happens when STACK segment has rw
> permissions, but does not specify stack size. In that case FDPIC loader
> uses permissions of the interpreter's stack, and for static executables
> with no interpreter it results in choosing the arch-default permissions
> for the stack.
>
> Fix that by using the interpreter's properties only when the interpreter
> is actually used.
>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  fs/binfmt_elf_fdpic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index be4e7ac3efbc..f6d72fe3998c 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -322,7 +322,7 @@ static int load_elf_fdpic_binary(struct linux_binprm =
*bprm)
>         else
>                 executable_stack =3D EXSTACK_DEFAULT;
>
> -       if (stack_size =3D=3D 0) {
> +       if (stack_size =3D=3D 0 && interp_params.flags & ELF_FDPIC_FLAG_P=
RESENT) {
>                 stack_size =3D interp_params.stack_size;
>                 if (interp_params.flags & ELF_FDPIC_FLAG_EXEC_STACK)
>                         executable_stack =3D EXSTACK_ENABLE_X;
> --
> 2.39.2
>


--=20
Thanks.
-- Max

