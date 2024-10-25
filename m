Return-Path: <linux-fsdevel+bounces-32994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6119B139E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 01:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5041F21135
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 23:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CC8213120;
	Fri, 25 Oct 2024 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CjB6bZlE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D701D9324
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 23:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900558; cv=none; b=LJfDHXI+hhyTEWtmowPn+6N5n4/+dHVc32dr/Khy5LRFxAaD/n+92MCJmo191LTb2U+7cU3fBfXdVFY5C4LxPDQn0vgu57FMeByjnaRhL80n8uuneblLVa0ZMa1x3te2BlimrIVRQZKBGXYfJU/s3dJsGxmf+7vHBsL1YnqXuKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900558; c=relaxed/simple;
	bh=g/ZjmhssLmefbyskZUDmYck2pJTO5/2ux7z0QhwR3ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6j5GU660DGKqhm2ZXVWvwGn+nXF5tT+lIuxm1Xj3B27noL1L761pPG8M9C4Drz8WN8XLzB9h7EZI/yW7msNwdC5eJ9+Q1WilBtdEONyZ3zHdFn3CQ3O51fMsYK1TP2KnR8fwxXSNwHr17zP5RlITjYLA+a7PX1Clq2UptXq/e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CjB6bZlE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315a8cff85so40575e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 16:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729900555; x=1730505355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWYP0I4K0/2CtNwosF8xhfAH9y22rupciDgyOMNJgTM=;
        b=CjB6bZlEo8Xq3l4ShEukPVxy35EXpyONpDVAa8o4/GWM9cbTL764nbW41sd5L8bRuB
         xqZZO/Pmmlg84iQpSaHiH68I6nyvCsRH+KYd8Kq1/vp5TfAN63bstaz9AWNx7Il3UM+T
         pK8++n/idVXZRwNC11tR6+VMySn8gSW3Cro/7Z3wnlgcBeZ5fnAcP+6wgMKXTw8CwbM9
         m4XwrvTH2u8kfajf9Q5YQ59M99Z+GFPIEb3igk9smLiy5hbNvu+2PSSQ0+Rqctp0oHmM
         sddVQ8+K/U3kB+N15xQg6WV1MHEbXWXH5dPvoCdP4RfKK9zTv4FewkS9uTDz+wnw3G27
         LJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729900555; x=1730505355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWYP0I4K0/2CtNwosF8xhfAH9y22rupciDgyOMNJgTM=;
        b=Tf+/1Q6BIWGcpAfm1nI1EC0OeGF0/gpURecCXbbQq2rZp6rgJrusahVBGJ7OA3LBea
         Lb78+xXlhKTB0qi2pGxyuAN+T772rtYfhM1rXWyg5HJjY5DCYHc8RN0FIKcYQJVEwk39
         f1L7a7xuXBpo0VluWdxElT4xhPQGEClELOe+0xTeht9xu0zeFXc1UVdqyVrKMN1kz/WA
         koCC4jQhzDDxfnHl8a656m5eOELqkBvVa3Di/XQJrWnXBf9qfJMapcIjkvElEWUNlYvz
         TAFfG+ljXYEXZ2ErcPM+IVQhfuWBgIBexeeLqxTJemanAPfd5p2BrQ8pz25YR71y/LDN
         pMmg==
X-Forwarded-Encrypted: i=1; AJvYcCUHS697PY2Sme6Hrnq0ARRIX03K6kC0WFEGuZpg+ZCxRm3bzZ0bdOHBlRtW/V/XdqywFOzyBql8de50HktY@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy0tY1gEjgBVvv/Fx/U/vnWIMWpiJP5kkbrCw4VEEYLGFcBTkA
	s9GKtaQZL6mmMWa06rfV1cDbv6cVFYRcqth7lrQwuLdDgLLbHwvWmayGwauuRQJZIbNY3dGjYd4
	ZwSuIArGgkb5uY0KPC8Xw5bZPjvs2FMZfx5Qi
X-Google-Smtp-Source: AGHT+IEj8l1jkJ/DZKzKwHCUs/WYIFKhP1QEN2YrkFPSCH2GhKoJwzW8ksRRpT/Ed90TVwmpZ8TOZb0ZG8Ia/N1Uxvc=
X-Received: by 2002:a05:600c:500f:b0:42c:9e35:cde6 with SMTP id
 5b1f17b1804b1-4319abf416fmr1714435e9.2.1729900554381; Fri, 25 Oct 2024
 16:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007-brauner-file-rcuref-v2-0-387e24dc9163@kernel.org>
 <20241007-brauner-file-rcuref-v2-3-387e24dc9163@kernel.org> <CAG48ez045n46OdL5hNn0232moYz4kUNDmScB-1duKMFwKafM3g@mail.gmail.com>
In-Reply-To: <CAG48ez045n46OdL5hNn0232moYz4kUNDmScB-1duKMFwKafM3g@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Sat, 26 Oct 2024 01:55:16 +0200
Message-ID: <CAG48ez3nZfS4F=9dAAJzVabxWQZDqW=y3yLtc56psvA+auanxQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fs: port files to file_ref
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 10:45=E2=80=AFPM Jann Horn <jannh@google.com> wrote=
:
> On Mon, Oct 7, 2024 at 4:23=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
> > Port files to rely on file_ref reference to improve scaling and gain
> > overflow protection.
> [...]
> > diff --git a/fs/file_table.c b/fs/file_table.c
> > index 4b23eb7b79dd9d4ec779f4c01ba2e902988895dc..3f5dc4176b21ff82cc9440e=
d92a0ad962fdb2046 100644
> > --- a/fs/file_table.c
> > +++ b/fs/file_table.c
> > @@ -178,7 +178,7 @@ static int init_file(struct file *f, int flags, con=
st struct cred *cred)
> >          * fget-rcu pattern users need to be able to handle spurious
> >          * refcount bumps we should reinitialize the reused file first.
> >          */
> > -       atomic_long_set(&f->f_count, 1);
> > +       file_ref_init(&f->f_ref, 1);
>
> It is good that you use file_ref_init() here to atomically initialize
> the file_ref; however, I think it is problematic that before this,
> alloc_empty_file() uses kmem_cache_zalloc(filp_cachep, GFP_KERNEL) to
> allocate the file, because that sets __GFP_ZERO, which means that
> slab_post_alloc_hook() will use memset() to zero the file object. That
> causes trouble in two different ways:
>
>
> 1. After the memset() has changed the file ref to zero, I think
> file_ref_get() can return true? Which means __get_file_rcu() could
> believe that it acquired a reference, and we could race like this:
>
> task A                          task B
>                                 __get_file_rcu()
>                                   rcu_dereference_raw()
> close()
>   [frees file]
> alloc_empty_file()
>   kmem_cache_zalloc()
>     [reallocates same file]
>     memset(..., 0, ...)
>                                   file_ref_get()
>                                     [increments 0->1, returns true]
>   init_file()
>     file_ref_init(..., 1)
>       [sets to 0]
>                                   rcu_dereference_raw()
>                                   fput()
>                                     file_ref_put()
>                                       [decrements 0->FILE_REF_NOREF, free=
s file]
>   [UAF]
>
>
> 2. AFAIK the memset() is not guaranteed to atomically update an
> "unsigned long", so you could see an entirely bogus torn counter
> value.
>
> The only reason this worked in the old code is that the refcount value
> stored in freed files is 0.
>
> So I think you need to stop using kmem_cache_zalloc() to allocate
> files, and instead use a constructor function that zeroes the refcount
> field, and manually memset() the rest of the "struct file" to 0 after
> calling kmem_cache_alloc().

Actually, thinking about this again, I guess there's actually no
reason why you'd need a constructor function; if you just avoid
memset()ing the refcount field on allocation, that'd be good enough.

