Return-Path: <linux-fsdevel+bounces-60277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8B7B43F67
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 16:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1D31C23A76
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 14:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86932307AD9;
	Thu,  4 Sep 2025 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="N+rP+DfZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B308D2FC00A
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996727; cv=none; b=TSk/GKPlm74/LFbvXjsJQ3ScTPgq2krbk63gtWhH4rzZs7gu+CFhYptELv0e/rCXPh8XtbXX0b53nphX/nYG7L3kbbuiaadSNI+hYFQAh0UXukEuHDGfC71Mlvr1WnJJdEfSu692X43zf+jYRYC188gsFsNbGvTvrJJ2sMlgR14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996727; c=relaxed/simple;
	bh=XP39k1oOF1x1pNPvzm2AmYTRAncscIavPUpOD7pfq6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8M/rbpDm8MIwdTu0r8dbeaJiUKO+w+LOY0Lad6aBxuU9W6NZTRJAAeiKg+2k7nhI/GLHWz5iYDUa+PgeM5qv1wgq87Or0TUAwnuPJGr+6+n0BUeNr3FOoguKlcbkXqrtMtp4M5PlIzUL/A4kaii9I4eboQMSjaWylxp5QbIeFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=N+rP+DfZ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b3d3f6360cso12494781cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Sep 2025 07:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756996724; x=1757601524; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sORYZrryBx3X+ZB/P+ONJ1uScfOCSDSJIiEl+3c24kE=;
        b=N+rP+DfZhv0Dan8qbanyT3RrUYDBphsVWPsMJtJ+iicb9bhct5V+txGzxt/NfmBpUa
         umv250Kd6B1c9pcXfcBsQ/WKdCbzCjYkO5yZSyM4L0jctRotOQZIHqaGo07f3lV4RsO8
         jvGVxTCRkWwKB+83KUWPQ60sineoY03C6HKEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756996724; x=1757601524;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sORYZrryBx3X+ZB/P+ONJ1uScfOCSDSJIiEl+3c24kE=;
        b=qQS7v9P8r811+mXlHOu2buWGshpJo4/rsAuI2KKOnud7XjTRDr8OlI/rD8dErTMFu3
         8GkJGzFPFBFVAKgxRZH7b8rvncoSn6TTXoIg9F6SZn2XQ9lVYrH6jy07TsplmrnE5UTt
         kwNzLxRd9N3XmIhHglQqhlohnUcfA1r7aTSWWFXLFjIofCrJRkdDN3Ragw1an+GlyyS+
         NR7UwutUt72/Kc7QyMfZq0kv6LpelVqkJRaGW4kqrPUcOPRgTNn+izdhv4Yl6yg9/y9U
         xAemBWgSojqCsilbylHyJv3Sv+RaXwP/e1P/RYVy+rR9+dbk7WxxCO54GmGToEFgi6Hy
         V2Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVwyS2dnv36tgOsRT/hwjK9PZ+s0ZXLY9QGlBnuPKdZHeCR+YAX49vjFJX/OSRVi0zWtIoss7y5oe6UR569@vger.kernel.org
X-Gm-Message-State: AOJu0YwhjY8pPruMHRZMcxZPA5kqUf63IBUfl176x37agQeiZO87mcJm
	v4GDIR/rjL0Yngf90aCAeWz0rFFUwTWsXmS8ZWe9x7OsfBefOwcEgD/8UJY9ViBUQ20KLUqT9bz
	B6FZBFxtkfTYDF5uYwHrGoqTUYUyaZQ56h4lRK0n3AUuD1U76p8Qa
X-Gm-Gg: ASbGncupRnKtovges8LbUWvMg4/GC5Lgr/nRcFuCXwymP2/3b1blOUuPVGXeR8huoeo
	FUiNXJofRN6rArlhAgeOZkAlfistj9ZYHXvNrXUvdG5KKPlu3jm5cBl6C0fxaUBmrPADAkKY76S
	h7peKcu7c6leo6ttb5Bql30kC/JlelUY4N1AS7GB8YarxR3BPlqdQLrUSOYC917KI/S+/gdaKjd
	iRGT5JGZ3+ckJb8eroMke5ccwoNaM69c6gyB692whmLhxXVfMdC
X-Google-Smtp-Source: AGHT+IH+iqp6nL0b1T6mhc+yoMdRxhuFY9y32p5XWmMDd4VFjp06eMd/Dww4jVhx3Z6Pd2rRHB+kTcMKsEeZWM2DecY=
X-Received: by 2002:a05:622a:1dc7:b0:4b4:9429:cde with SMTP id
 d75a77b69052e-4b494291702mr57042491cf.29.1756996723834; Thu, 04 Sep 2025
 07:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828162951.60437-1-luis@igalia.com> <20250828162951.60437-3-luis@igalia.com>
 <CAJfpegtmmxNozcevgP335nyZui3OAYBkvt-OqA7ei+WTNopbrg@mail.gmail.com> <87tt1il334.fsf@wotan.olymp>
In-Reply-To: <87tt1il334.fsf@wotan.olymp>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 4 Sep 2025 16:38:32 +0200
X-Gm-Features: Ac12FXzZ-2wxsKUJIUDzjsjhjGtjgDnG7zuajNPjeJmgBcv3guSXid3pHorQzTQ
Message-ID: <CAJfpegsyrSPxLK=nVLDSPWq0dyvoMr+s0K-Lep1BvqX1wpZphA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/2] fuse: new work queue to invalidate dentries
 from old epochs
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Laura Promberger <laura.promberger@cern.ch>, 
	Dave Chinner <david@fromorbit.com>, Matt Harvey <mharvey@jumptrading.com>, 
	linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Sept 2025 at 16:11, Luis Henriques <luis@igalia.com> wrote:
>
> On Thu, Sep 04 2025, Miklos Szeredi wrote:
>
> > On Thu, 28 Aug 2025 at 18:30, Luis Henriques <luis@igalia.com> wrote:
> >>
> >> With the infrastructure introduced to periodically invalidate expired
> >> dentries, it is now possible to add an extra work queue to invalidate
> >> dentries when an epoch is incremented.  This work queue will only be
> >> triggered when the 'inval_wq' parameter is set.
> >>
> >> Signed-off-by: Luis Henriques <luis@igalia.com>
> >> ---
> >>  fs/fuse/dev.c    |  7 ++++---
> >>  fs/fuse/dir.c    | 34 ++++++++++++++++++++++++++++++++++
> >>  fs/fuse/fuse_i.h |  4 ++++
> >>  fs/fuse/inode.c  | 41 ++++++++++++++++++++++-------------------
> >>  4 files changed, 64 insertions(+), 22 deletions(-)
> >>
> >> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> >> index e80cd8f2c049..48c5c01c3e5b 100644
> >> --- a/fs/fuse/dev.c
> >> +++ b/fs/fuse/dev.c
> >> @@ -2033,13 +2033,14 @@ static int fuse_notify_resend(struct fuse_conn *fc)
> >>
> >>  /*
> >>   * Increments the fuse connection epoch.  This will result of dentries from
> >> - * previous epochs to be invalidated.
> >> - *
> >> - * XXX optimization: add call to shrink_dcache_sb()?
> >
> > I guess it wouldn't hurt.   Definitely simpler, so I'd opt for this.
>
> So, your suggesting to have the work queue simply calling this instead of
> walking through the dentries?  (Or even *not* having a work queue at all?)

I think doing in in a work queue is useful, since walking the tree
might take a significant amount of time.

Not having to do the walk manually is definitely a simplification.
It might throw out dentries that got looked up since the last epoch,
but it's probably not a big loss in terms of performance.

Thanks,
Miklos

