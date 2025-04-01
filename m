Return-Path: <linux-fsdevel+bounces-45457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1266DA77E40
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 16:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD823AF2F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 14:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB73205506;
	Tue,  1 Apr 2025 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mV08XYM1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975581E47B3;
	Tue,  1 Apr 2025 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743519084; cv=none; b=kC+8CAhSfBNJ1/D7d0qlJjee0138Y80G4JotgfOhPqc56CTkK+lmClomT7qh9dlesyxURT/CaQ1HNs6eP+VK/NgR4mgo2+WfNmgnTZLYg0USu5wnspeMJhVsoBx4HGlGh+gPi4ohh5zBaAusNedVlrr1MSFoXb1TLPkwwW/uzW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743519084; c=relaxed/simple;
	bh=j1fgVaCJnqMGHgW2lJcXX+aTDx2s2m878YtWc0fTvnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eo4lrXEVZ/f2jS47+FDpkPzluw4ztUM1dTrPOSpsNxM6QPgAJ/ynCw+6kBAyez1BYVTNWa4P4OvvNwVqfIWZpC29qnEXtFqf1euXTSf2RQ6eVjTvhS0RMFtsEi6vgy0FbbvMmK2SHX8nOo4pmo/BcqxyxuiLAPuMXOZ4xLLGn1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mV08XYM1; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e8f4c50a8fso50232906d6.1;
        Tue, 01 Apr 2025 07:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743519081; x=1744123881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2PGIUWN8Qg4lwQqZjTaAHNRuRoKwS4SfvGv0EzV/1Q=;
        b=mV08XYM1lIw5hS332jsC+hHH+WOcsyaKGEbwCMrSUTVELy1viaBbEmI7dYRywaPEcy
         pL4ma0YIEvBf6eV8gYtqPCwwAXVrhlctetugzZ0/QZNyov0UOkwLv46n5IqyoWk+jaas
         17ewU5NnS6EadVRLrTXD6Donca02NRrnaUc95oYRkZF3nESoLeo1xgFveuxqNMCkeLUU
         dlsoKibEWRAM59HJFLUx9v9PhTEBngrZBG2ah16GBCfNPW/doKwtut7WouaigHDwWtpV
         oE4+NoQwG280jSTUmk+QLGHnil+pUV0WglZsMxbydexOCeltV0EyOvVcAbx6e3Sy1Vp8
         m2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743519081; x=1744123881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2PGIUWN8Qg4lwQqZjTaAHNRuRoKwS4SfvGv0EzV/1Q=;
        b=vEssNtfrVlYiNt94vTqNiYi/i4ueVRLWCCRyMXKFbON6Uv3QvcDwNQGwkELIJe+jYT
         3xUD1cPRA9WAeHscHhip4hVnyLlTHSMPTBH899kfXOSbN+Fp41R2zKM2nvXbMjPUN2zZ
         5WVXCq8M9REQK4EcARARthgWwNuHPVtCrzYvZQ8/hx7NdiC1MppX8K5ddVWunmRSVm28
         xR0wR7t++pgz0qjw08k17kH6lWIyEdzrxfNUK8a8J49PTO/Aoesg4au61+IsmfNuuc0e
         9ZADf/CdiMaWqTl41j3zFUlwqWD+vtqAjTZQY0ATWP8EfVC/kH7enym6fmu2c6yf91yg
         Qj3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPRHC+r/wI/VDsB6a0kowz4Y4qM2jImHEYIXkZuc5r9gLhb6BV7WC0IhJVvRtzvzdgm3b2a8/1ZECKUq3f@vger.kernel.org, AJvYcCWwTs8Z1z+rmYpJJLMO0CNGoRRU2qXqf4pJvdVRbMYQHweTf4KVs7yCtW0LdfO0iCAbRlk6LYT9UFwqDty3@vger.kernel.org
X-Gm-Message-State: AOJu0YxS0LtfkAuWJJUgOVPI2di80GXiQHY/xR84rnTZM4jSRT7M+8SZ
	qQQXateumFKn26nLaod4loQZx393iVJ1RZ26oCCYavFR1bqCZL1Y8enyxnjmaATOXL/9YHicz1a
	dvrDcB1ZpE38zpmI16v3XtdjE7Jw=
X-Gm-Gg: ASbGncseOfCa0oFjK5F4o31jNf2gJSRyiFwMgncoQaK4rJTmutrtlP6Cm6I8piRrFDt
	Gcvz+9E4Fuki2UOx/PGu6aNE34JTrI0kSU+8CqWXwO498ZL9rb/dmhaBmBGOA16vf2rim4VkcP4
	FmLtb3s6enPF0wTdeuP81d6vsAl9I=
X-Google-Smtp-Source: AGHT+IG7pkQ1GzQpATG8QqTleJB4yNaHwHHE1zgVDQOR+ZgvIB8JI2BkCAG4FIMKSnZH4heOS1hQC/RjR8JUmqaXJsU=
X-Received: by 2002:ad4:5684:0:b0:6e6:61a5:aa57 with SMTP id
 6a1803df08f44-6eed5fcb745mr166993946d6.14.1743519081478; Tue, 01 Apr 2025
 07:51:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401073046.51121-1-laoar.shao@gmail.com> <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org>
In-Reply-To: <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 1 Apr 2025 22:50:45 +0800
X-Gm-Features: AQ5f1JoxFVNGVjpqTbB8efeabk5Z3jz9ZAOuKNxTpHQhuIoFL3zlIvT5_Hlc1yA
Message-ID: <CALOAHbBnC9VVECVUD_-J8q5fXfG6Krc32u+_WeoCj7PdwvspJg@mail.gmail.com>
Subject: Re: [PATCH] proc: Avoid costly high-order page allocations when
 reading proc files
To: Kees Cook <kees@kernel.org>
Cc: joel.granados@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 10:01=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
>
>
> On April 1, 2025 12:30:46 AM PDT, Yafang Shao <laoar.shao@gmail.com> wrot=
e:
> >While investigating a kcompactd 100% CPU utilization issue in production=
, I
> >observed frequent costly high-order (order-6) page allocations triggered=
 by
> >proc file reads from monitoring tools. This can be reproduced with a sim=
ple
> >test case:
> >
> >  fd =3D open(PROC_FILE, O_RDONLY);
> >  size =3D read(fd, buff, 256KB);
> >  close(fd);
> >
> >Although we should modify the monitoring tools to use smaller buffer siz=
es,
> >we should also enhance the kernel to prevent these expensive high-order
> >allocations.
> >
> >Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >Cc: Josef Bacik <josef@toxicpanda.com>
> >---
> > fs/proc/proc_sysctl.c | 10 +++++++++-
> > 1 file changed, 9 insertions(+), 1 deletion(-)
> >
> >diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> >index cc9d74a06ff0..c53ba733bda5 100644
> >--- a/fs/proc/proc_sysctl.c
> >+++ b/fs/proc/proc_sysctl.c
> >@@ -581,7 +581,15 @@ static ssize_t proc_sys_call_handler(struct kiocb *=
iocb, struct iov_iter *iter,
> >       error =3D -ENOMEM;
> >       if (count >=3D KMALLOC_MAX_SIZE)
> >               goto out;
> >-      kbuf =3D kvzalloc(count + 1, GFP_KERNEL);
> >+
> >+      /*
> >+       * Use vmalloc if the count is too large to avoid costly high-ord=
er page
> >+       * allocations.
> >+       */
> >+      if (count < (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
> >+              kbuf =3D kvzalloc(count + 1, GFP_KERNEL);
>
> Why not move this check into kvmalloc family?

good suggestion.

>
> >+      else
> >+              kbuf =3D vmalloc(count + 1);
>
> You dropped the zeroing. This must be vzalloc.

Nice catch.

>
> >       if (!kbuf)
> >               goto out;
> >
>
> Alternatively, why not force count to be <PAGE_SIZE? What uses >PAGE_SIZE=
 writes in proc/sys?

This would break backward compatibility with existing tools, so we
cannot enforce this restriction.

--=20
Regards
Yafang

