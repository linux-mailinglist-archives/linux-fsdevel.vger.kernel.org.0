Return-Path: <linux-fsdevel+bounces-19223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7D48C193F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 00:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6902F1C21D03
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 22:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC84E129E75;
	Thu,  9 May 2024 22:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="di5Mko6G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2062F1292E6
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715292623; cv=none; b=dA34OjpEFSRyddSvNvW2eQbcWDb3M8/aHWY/cTKVWA6tndYMbTSuCidiQQwpzJ/kPOzpc3iJCMwS0ARoQNb+DXBe4ladNhfhKj2D/8WkRrK5y8OSz3VkQfa1//8I47o9hKzOBKkz36MzCxTmITw/8N1mo7iNcotP2A7QNOWzxvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715292623; c=relaxed/simple;
	bh=59mEgVC4lkz46VEjh2qNmxWDlTxiAqyCrQSnZR5NBDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dawirr1xBzPnnAejLMCN2tsBfEyz+A5/rhgFvXsmhh91fusF+alZ8oLRzUC9/D2bF3L4sIPlX1+ZYR2OQSWQKMr3lLAcDObetXdbKtwyJ4Gcgc2mlZEI0Ty41AZwh2GrZ5eH9NgyjMTeWbksRBf10+lMf1zYtVqH3O9FfMyZyEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=di5Mko6G; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-47f13801f3aso482147137.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 May 2024 15:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715292620; x=1715897420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKdICX+lX8CE08nIGqEYXYRJN4FhWDTtg4wUvpl3cAY=;
        b=di5Mko6GC7T7epR4LNQTDzrknh0xtFQHeQAXuVd9spUmCnpwF/AZHDFEqRR+lW2AJz
         QEQVTH0+KQXE9z4+MITUgcl21Yw5nSjABKPfQ/GOexgxGBQaDp+Nfi4X2oGcRombOJMZ
         Bkg609DfQZUQNQj2APCsc0t34flj+rl3fFdd1QvKMI/w+m4wFaB86vDkTSQgF54hRnjJ
         zgddmDMEjPGwzcRp1XOeiW2H1CcMx/llFwTsSQYBA4qkCP27EUOezHfiwL1lSnkwDfBc
         XKbZx2TIzujommW622COfx9bohLNHdhyFI4Vi5tulbnJAuASS/M2xyVFHJmRXvFi3kE5
         qAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715292620; x=1715897420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKdICX+lX8CE08nIGqEYXYRJN4FhWDTtg4wUvpl3cAY=;
        b=nFDbiB+irSj8+lr+H7ne/r1s+VgYBUhTXAVaBrBZvinMRh3zInZ6S4RrTqApKFHwiv
         m4QSu6C8LYJ1PsnWr+tPewFXOJ7gLo3ihFDEBT088is6hLp5lDOJBVQcKFnCjYVcgACG
         9DxCNidBOIX/yPADurzExCMWFYw1xN1Td1uGoo9NB8jwJLU2T6icFaC93XgDlwnQZrQk
         m9OuaAK+8/FhaIkkA4AwBCEKoj5o1xh1xz6qQjce+QSBrP8uNNsc30dSl+HoUag1bbVr
         UdJnAwDp6Z+l/5pvJaV4ft6cP/5DParuHUaezzO8omoYPlmtAtNlqdI1v/7LLb7LJe7Z
         IVfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsF1oFNBJJ9wr2KG1uATkEcAm90RhgvUwV1uYZYrfYx6crnMtLUPyvzjtJ2T7d1pszkRxt/S/uxXaDXyrRwVgTILMUvoQfR2PS9745Fw==
X-Gm-Message-State: AOJu0YwB8ZTI6M6+nKs7ASgulc5yS4t2HlaI2+GvBnGpEs/HF597i8Dp
	H7ZDYuqZwqguYCAwwSGu/gOaf1VHZCU5PygOpH5cFqdVr1jNMg7G9+KXvXdZZiBiSBmxvlQMPSr
	PRqWiYe7VTr4Gsq3LNLiKiKc2VByWwmaTkC9T
X-Google-Smtp-Source: AGHT+IG9UCFfCI7smAQh5zYoU5+Q/8AopDE+XLvDQt4XHypQBrcuB26D5dwcSEX6FTb7qgBIbqU5zgrv8BJ4OSYe5Bc=
X-Received: by 2002:a05:6102:3053:b0:47a:22cd:9716 with SMTP id
 ada2fe7eead31-48077e07a05mr1112057137.17.1715292619999; Thu, 09 May 2024
 15:10:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507-b4-sio-vfs_fallocate-v1-1-322f84b97ad5@google.com> <20240509155356.w274h4blmcykxej6@quack3>
In-Reply-To: <20240509155356.w274h4blmcykxej6@quack3>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 9 May 2024 15:10:07 -0700
Message-ID: <CAFhGd8opxHhTdZhDg_hq7XWQFxJ34nLDxTd-nBBgye9BLohnqw@mail.gmail.com>
Subject: Re: [PATCH] fs: remove accidental overflow during wraparound check
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 8:53=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > @@ -319,8 +320,12 @@ int vfs_fallocate(struct file *file, int mode, lof=
f_t offset, loff_t len)
> >       if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
> >               return -ENODEV;
> >
> > -     /* Check for wrap through zero too */
> > -     if (((offset + len) > inode->i_sb->s_maxbytes) || ((offset + len)=
 < 0))
> > +     /* Check for wraparound */
> > +     if (check_add_overflow(offset, len, &sum))
> > +             return -EFBIG;
> > +
> > +     /* Now, check bounds */
> > +     if (sum > inode->i_sb->s_maxbytes || sum < 0)
> >               return -EFBIG;
>
> But why do you check for sum < 0? We know from previous checks offset >=
=3D 0
> && len > 0 so unless we overflow, sum is guaranteed to be > 0.

Fair enough. I suppose with the overflow check in place we can no
longer have a sum less than zero there. If nothing else, it tells
readers of this code what the domain of (offset+len) is. I don't mind
sending a new version, though.

>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

