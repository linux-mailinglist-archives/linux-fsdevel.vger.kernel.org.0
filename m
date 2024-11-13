Return-Path: <linux-fsdevel+bounces-34676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25AC9C797D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 18:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9622DB2DD3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 16:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F72165F17;
	Wed, 13 Nov 2024 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfkQdLjS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D1070829;
	Wed, 13 Nov 2024 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731515362; cv=none; b=atbNc8DGrx7N7fUYrXlI7+nhTkY7/9Dfmh/7YSQKLreBH1FCI813SvmhCdZ/lLXGZKkOocJP4GmQKfczLgKJlUX5fr6sXj3sP8Jw89FLPhQgyPhV/CYL58NcezKABUKtGIpIH/05oiryA4x2tg1bYiXKLqVQtkWwDNboCB9ex1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731515362; c=relaxed/simple;
	bh=tFnn4MPom+IWjU1ADzhqF/rS3qqhgmFfg9sGwrHi7Cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBCJsXrfotVQZDWSSE8g9M/Cs0ZX7HhP4HLBkepZGqaUAvE43ZlxoT7nSbf8JcRClp+3VhQIDGqSMBjlBa1vBRKOmq6Y5LcVr7TXQ/Y1g8ls6TgdurmnfpLcKn5T98HS3UZzCUHqZLUpWcZVhvUiYpa81wbuVY+pXeO2NShUL7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfkQdLjS; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb3debdc09so56276831fa.3;
        Wed, 13 Nov 2024 08:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731515359; x=1732120159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usRz3dPuBpi/LeN2CZYAlsEcDzPJkjSfZ89kAYdHUug=;
        b=HfkQdLjSM1S6eTXeV7tkcZRVQD5QYnbkAwVug1gOYAurlfPoNGJP0JLviKf94TUsd5
         QVs4StTVfJ/Ev/3U8HvK0ReaVjkvJw/GxQh08LtvTRth/oa+0MhYe8Y+L4AlBkB1LQ/s
         islJHad80vHCtIeKsNGvzidKqyqZy/jp38Q+uGO+y3lzQ8yWiwmP0iRrnSVZrkC1uMua
         QYvmex+xrEX5wJYTL51zXAdpswGXldY2SeofExcjL7mJoLcrBqqE1i1vvqcpoHR/gRFx
         52iHILRSYeJgnRckpfatEtyAbHIUq5uE1cOc7b6F5/JViQF2BsKpwOKf+TIV9Cx1u6d5
         qQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731515359; x=1732120159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usRz3dPuBpi/LeN2CZYAlsEcDzPJkjSfZ89kAYdHUug=;
        b=wj+UzFfbLGgjypaqIz68Z0c/c3fSztgMPba41Dvf+kOvQ1bFAu/GJfQJAhoBoyc/wk
         bpLQTt+6KkNndcuQtq+jlJ+IveKqOa9ys2t5qqBu3LoiH2ZLNU0MV3uZxdiioLKR7ktQ
         0ulvIvEuWSWa7uv9TMrWfDuwNbdslynvFCxidlSOkNTq9zDOGzKHdsJY/f+CIHJ+5kIS
         mL1g7owAWax/zqzKCAUSjCIx/lY3268BWP6meBzToLHsyfg7aKCug3ep5y0tt3O6e30+
         s6YiSGEKgsnHQ1JD08OMcnqlkRRaL5f5f8B5Sf6RNPbKMTehcbwESUSXSTCwD4SDGDQB
         hM6w==
X-Forwarded-Encrypted: i=1; AJvYcCV+fUW9JN5GfV9BCuhKi4I2MGmkX2Ta4xKUHngshQ69ULxQP3I8qlbHyD+TWWZyv23cCPhrsnWIsw9lmfAj@vger.kernel.org, AJvYcCX1jYmWTdOJo36WcmVdM6VbCWBvdlQWQjo2oAJ/ofrvqMYcUmeZ3qwMCWWB3gWOm3O2LiJpt68S0IA3iw0K@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw/a2niuagmQiLH5If8vJaDBlsALhd839mFp/p11Lo4O1qVsog
	jbS2vkVUjLCPU7zOKJ0MEPBqkjxsDJGa0KExcFqSi/fzJkRx9BhCEiA7Qdjgm6Ny7ka5L4jnLal
	wVv3HxZPJAJs0KWilAhIVFoHVaK4UI7Xv
X-Google-Smtp-Source: AGHT+IFERpYqnlnnH93mQU8lIdV4FBPphbvJOJFd7lo1GHrsp/C9vkMePi0BmLAPJE8CeRUOZmzjxMIciuVxG8YTGvA=
X-Received: by 2002:a05:651c:2228:b0:2fb:6394:d6bd with SMTP id
 38308e7fff4ca-2ff4c5bf80dmr17808541fa.12.1731515358986; Wed, 13 Nov 2024
 08:29:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113155103.4194099-1-mjguzik@gmail.com> <20241113161753.2rtsxuwzgvenwvu4@quack3>
In-Reply-To: <20241113161753.2rtsxuwzgvenwvu4@quack3>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 13 Nov 2024 17:29:07 +0100
Message-ID: <CAGudoHFrg_HexzEvT9M88nFG_ZXn6DuRDC-rSCdZQQUZ-Dgr-A@mail.gmail.com>
Subject: Re: [PATCH] vfs: make evict() use smp_mb__after_spinlock instead of smp_mb
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jlayton@kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 5:17=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 13-11-24 16:51:03, Mateusz Guzik wrote:
> > It literally directly follows a spin_lock() call.
> >
> > This whacks an explicit barrier on x86-64.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
>
> Looks good. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>

thanks

> > This plausibly can go away altogether, but I could not be arsed to
> > convince myself that's correct. Individuals willing to put in time are
> > welcome :)
>
> AFAICS there's nothing else really guaranteeing the last store to
> inode->i_state cannot be reordered up to after the wake up so I think the
> barrier should be there.
>

There is a bunch of lock round trips in this routine alone, including
on i_lock itself, but that aside:

I *suspect* something like spin_wait_unlocked(&inode->i_state)
shipping with a full fence at the beginning of the routine would
correctly allow to check all the possible waiter et al flags without
acquiring the lock anymore, shaving off at least 2 lock trips in the
common case.

However, I don't see such a routine as is and I'm definitely not going
to flame about adding it for the time being.

>                                                                 Honza
> >
> >  fs/inode.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/inode.c b/fs/inode.c
> > index e5a60084a7a9..b3db1234737f 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -817,7 +817,7 @@ static void evict(struct inode *inode)
> >        * ___wait_var_event() either sees the bit cleared or
> >        * waitqueue_active() check in wake_up_var() sees the waiter.
> >        */
> > -     smp_mb();
> > +     smp_mb__after_spinlock();
> >       inode_wake_up_bit(inode, __I_NEW);
> >       BUG_ON(inode->i_state !=3D (I_FREEING | I_CLEAR));
> >       spin_unlock(&inode->i_lock);
> > --
> > 2.43.0
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR



--=20
Mateusz Guzik <mjguzik gmail.com>

