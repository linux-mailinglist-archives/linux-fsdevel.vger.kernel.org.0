Return-Path: <linux-fsdevel+bounces-48642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6DCAB1AA6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 18:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5670188E410
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 16:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7129823643F;
	Fri,  9 May 2025 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="RnX2XLF3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02882F9C1
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746808587; cv=none; b=aWk93CBHa886zHSwYqIMTXGja1G7qEuJgcKf3QXzEqePFIBVQdnjwt+Hu3lZXUX2Z7iU7vCybbK9DRUFaufMvWNdf3OJ1RFgfD3Id5npsDJMLHwawtGq9+t1QYZysZvNzWHlSK1Q9nImXVVHz+IRONtBZWtZrga2Z6Sae3Ks15s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746808587; c=relaxed/simple;
	bh=SElwm06j+DlRR4yCYm42BAqEpJ3JJLetNH0N75LAQZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gR0B5Adzrk1qBcSfxp1lHpIWIsxjX6IC0tuS4WTekp4aOt1aXtUFhyNNjRL/WX1XMNjnfRO8VHylLVDnKgkKMrn+TUAye776R6EQ3qGcXMCLUlBKTqV4AEqlznRaoRkKTXgfws95GYom2wFb7Aq7I5anvpuACLfs1r4IT7GB7j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=RnX2XLF3; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3104ddb8051so23593061fa.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 09:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1746808584; x=1747413384; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zzddh/3eTx6uQ05Z0QrC85lC2xnXc5MveRhZzr/KB1o=;
        b=RnX2XLF3idIdiYQEzvbzFqoxqPfoUkyCGUvSprCsOfMac+aFEygT0GMtuUavCNaxbH
         O9cSRPZVRrzJbBpVj9swKkcgOhcFRQl/wqoTiHHS2Hg7sQC3pRDfiNl3iRv//aAvF+ZM
         UFsdaCtIzqcJS0WoTGfZ/bC9Yswobjm1AwIx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746808584; x=1747413384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zzddh/3eTx6uQ05Z0QrC85lC2xnXc5MveRhZzr/KB1o=;
        b=Gbp2rex1HpDa8ExfxY3iQtQS0SbCyeMCdSpcc5SiRmkLSEJt7/dbrxCUv3bW5XSK7m
         /k7ipvbjlXz9esFGHlG7jw/BR4IwkuDjcl6ovnJVb52iSfMb00+XU+SYdLzRoxsKD6nI
         LW2yRbPSoSWc/cRtIthILbcfLLCXxqENOx5F1koEqSmdmXXnjF6I6Cg4dyByNWnVX52/
         F/vhCZlTRJoJKaIwuC1o+qPd1dW54qtPCCkJ0ZPu456KGHyzOjNQv+MV9djUtocDEbP/
         v7mJMOgfc5s7c/3R1UsHgW8JE+KIRbHS/Nw8G99Y8I2tb+kp80K0CIOyMZOAkPhJkPQG
         /bGw==
X-Gm-Message-State: AOJu0Yys+l8pobJhDyZ9p8owMFQOhk9vz81VGc1zBi/8oUdJX3THiJhT
	sgVaD/aFtuerDlITHlTeJF3uSx3lSF22RSns2ddS57D6a36Tlw7P1gk9CzGS0XO5A2S5dzzTuam
	EDaRumGDEPyllEEh1ULfNIUYAtMwFjRDZ1cWtlg==
X-Gm-Gg: ASbGnctOMYhkfvAzHUnzDvdQpOv7R4pTB93G5KNgaX9BgKaHcIcpoC9i6ELdXEP6e+b
	ZsEybMY3SsY7irgYVqQMgXsR8sNEwuVCm6yZBE3GkHj0tHX9cWA//sQpstyKFpUeC4m0d2llRJJ
	vN2Kt8Ioxlfy6Xf7RjN0LaH90=
X-Google-Smtp-Source: AGHT+IH+OGShjApAd9yBXoPzGyz7erva33bTf7tcbh9TZCZv8N/0Z47UJruRu0/G2XeKDRmeA7pJn36NDyQUl8d5EeY=
X-Received: by 2002:a05:651c:210a:b0:30d:b25d:72d0 with SMTP id
 38308e7fff4ca-326c457585amr16758911fa.17.1746808583777; Fri, 09 May 2025
 09:36:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-work-coredump-socket-v5-0-23c5b14df1bc@kernel.org> <20250509-work-coredump-socket-v5-3-23c5b14df1bc@kernel.org>
In-Reply-To: <20250509-work-coredump-socket-v5-3-23c5b14df1bc@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 9 May 2025 18:36:11 +0200
X-Gm-Features: AX0GCFvUuqDpuhS2JQ9T3QaKQJ6V58kyD4zcgQGwY68-T7tQ-lOHd3RNIb0VEdI
Message-ID: <CAJqdLrotSo_3gdq-eQhiBiA6Y76DV_Vi9x1sTZNjz97PZc=6PA@mail.gmail.com>
Subject: Re: [PATCH v5 3/9] coredump: reflow dump helpers a little
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

Am Fr., 9. Mai 2025 um 12:26 Uhr schrieb Christian Brauner <brauner@kernel.org>:
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
> index 41491dbfafdf..b2eda7b176e4 100644
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

