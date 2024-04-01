Return-Path: <linux-fsdevel+bounces-15832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9B989414B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 18:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E00A1C20FC7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 16:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D8B4596E;
	Mon,  1 Apr 2024 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ETXFhuXF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A941E86C
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Apr 2024 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989619; cv=none; b=ZAxbrKKLroPRk4FQPz+miv8BOAO8qOrynJ5fEVlZGQEVlDFPkFKs4tSHX4CeA43cYCgRO1jpdP8GtqWMgA8n9RtRp+d6pH1KKXMgXkk5QwtGS3FN/m6l6ZhB554qhTsMeL0mJGW5glCYL2cpVbBYP0fy8ODQaJxzh4UQA+BkwZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989619; c=relaxed/simple;
	bh=mOJrEurQ2Cag7MoBJFEH3T/XZh3COptZr3FEmCGbPLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gcraoAYkkIroveIlohUWjKbuBF3txJz7iaLb0fz0a037FsSdpb82jjfmoGQgBho7/hjU0rexbOKOAHc6Y3oIjbbFDdVUgG296gKEn/tgybqGq2upyAlc0+dOBcl+98eMPgKMfkVBI57fSQJ9TnGGL2U7hlHpqx2v36Yq1evbbxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ETXFhuXF; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 51A6C3F285
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Apr 2024 16:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711989615;
	bh=kyw1q0UdGddbIeiCqeCW+8pgC3ifkxrhttUo3nZlsFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=ETXFhuXFBf3r2Bx69+s1Xse6pGp5O0SrBfIg29uKYOmm9xEFH0LMqBosP7nVhBO6l
	 TXAoZ7lxUycn/iAtPcvIOHZqe9aykh7327rluR2xbbPmG3AwuGn0LkmXjzjK8jv1pS
	 S2Sx3/Xz/Gn/syHM/HXW8jeVlTPQvZpOMUSLQcfKpbi8C6HzVaxFv8Im6uR7VwGYjh
	 XwGTcZ3rShQdPgm0+UwteX2IZYE/xBtpzPtBv+Gll3eCA1liNihPXmQmhe6RG/xbBG
	 Nd7RSuNOgNndDBDP9vfhssDe6M5Rq7HMzB+NDNyzh1NGc6068x7bFnxACgHNoHUBSo
	 /nl5pFIx7u2fw==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a4455ae71fcso260640766b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Apr 2024 09:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711989614; x=1712594414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyw1q0UdGddbIeiCqeCW+8pgC3ifkxrhttUo3nZlsFg=;
        b=DghPvwJf7UiURhs27+GD0l66zYM5vt7uKMBfsSFiR2v6Vv85Wbm7iouYMfiJ2O3lhH
         q8QpB8OM2ykCLIE8aH3ymTX9eZ6A+UdVMoXeeL3sA6DW+yCN3ApXIcR6vD3N9BWavRlI
         +PNeuVag9Cw/b024qTEj+8glLHbtdLNEBqTeZVGsYeAYHm9gJ4jy0ElA2D83dtKUqHu5
         xcJDI/Nd7hzkZZR67cWCn9iyJf0uTTMd1ib7sRo8zYiU0SBeB6oyzWXRISsDRO1LOr0d
         B35UJUKutTxxpUIkkDsCw1vPL9XfMfBsO9mZN8f81Bb1pTfvFOl4XZ/dUmDgmrBk+dXP
         ZHGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXhTQGgatogNRKUIs98suuLcdv4UaUv5W0vMfgkigajG1VgiT4rOA31Z5FqROOAI/Udai6tJPT71roewGWOrs6y7kkps8bBktiIaJCwA==
X-Gm-Message-State: AOJu0YyBWcGfJOMiAR0jtEcLZo0zQwFhP2vLlGRLa9sEdNxZRF60rL1f
	R2KSkJe1MtQG1T9OvBzdA4H4BNpLM8vdwVzZI3ojFIMX76+hXY3N39llNmjxjqwC3u0whu5tOfn
	ZecH8CrUxxPvDjIdN5OW6Sklu9MkU+ctrENSHtJzstlgpNiOf3w3SVn5qygwyGmRXCpqVtjxu8A
	pNJder8Dv7Y/NSelNXg5Zn0OArrxyHyjOqGYFGa+pET5Mu9owfokbezJh1zJZOLA==
X-Received: by 2002:a05:6402:40c2:b0:56b:ff72:e6bb with SMTP id z2-20020a05640240c200b0056bff72e6bbmr6674388edb.40.1711989614775;
        Mon, 01 Apr 2024 09:40:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQZMMgAC2q+xzfVYatcAeJXEQLbSa+Mn87FXyIp1gsrEXa2l5dwlJxB4sf4HiCQ8uLwUu2v1TJ86fJdiabH1w=
X-Received: by 2002:a05:6402:40c2:b0:56b:ff72:e6bb with SMTP id
 z2-20020a05640240c200b0056bff72e6bbmr6674373edb.40.1711989614398; Mon, 01 Apr
 2024 09:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240331215212.522544-1-kent.overstreet@linux.dev>
In-Reply-To: <20240331215212.522544-1-kent.overstreet@linux.dev>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Mon, 1 Apr 2024 11:40:03 -0500
Message-ID: <CAHTA-ubqxnx2FES6tMfuC25VAc_CJ_MZg8YjCU_c6bdF1=N12A@mail.gmail.com>
Subject: Re: [PATCH] aio: Fix null ptr deref in aio_complete() wakeup
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the quick patch!

I just ran my reproducer 50x and did not observe any kernel panics
(either in the ktest environment or on bare metal), so it does seem
that resolves the issue on our end.

-Mitchell Augustin

On Sun, Mar 31, 2024 at 4:52=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> list_del_init_careful() needs to be the last access to the wait queue
> entry - it effectively unlocks access.
>
> Previously, finish_wait() would see the empty list head and skip taking
> the lock, and then we'd return - but the completion path would still
> attempt to do the wakeup after the task_struct pointer had been
> overwritten.
>
> Fixes: 71eb6b6b0ba9 fs/aio: obey min_nr when doing wakeups
> Cc: linux-stable@vger.kernel.org
> Link: https://lore.kernel.org/linux-fsdevel/CAHTA-ubfwwB51A5Wg5M6H_rPEQK9=
pNf8FkAGH=3Dvr=3DFEkyRrtqw@mail.gmail.com/
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  fs/aio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/aio.c b/fs/aio.c
> index 9cdaa2faa536..0f4f531c9780 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1202,8 +1202,8 @@ static void aio_complete(struct aio_kiocb *iocb)
>                 spin_lock_irqsave(&ctx->wait.lock, flags);
>                 list_for_each_entry_safe(curr, next, &ctx->wait.head, w.e=
ntry)
>                         if (avail >=3D curr->min_nr) {
> -                               list_del_init_careful(&curr->w.entry);
>                                 wake_up_process(curr->w.private);
> +                               list_del_init_careful(&curr->w.entry);
>                         }
>                 spin_unlock_irqrestore(&ctx->wait.lock, flags);
>         }
> --
> 2.43.0
>

