Return-Path: <linux-fsdevel+bounces-13884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD179875188
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 15:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CBF6B25061
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 14:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC02A12E1F1;
	Thu,  7 Mar 2024 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="RUIA9eXa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4F612E1D4
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820599; cv=none; b=sZVDCmffKis38enGbI4MdrewXCsCQua25BsYjBAXIS/T0AKBJtlCAPvYXVEiygw49jxTh0hmAzqdFOIUc9hO3p3aEVmhtIqI+sXYPhKxWDO9c4udvQGN0GC0ZJOW8FFaJTv90PoQMHbbGdA2y5XRWWpTkEuTzYQrEy49LBoczxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820599; c=relaxed/simple;
	bh=2ED+9pdp+YlVQvsPdC3jIxYY6GPhCNFl2+qV+Rc3zPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TX4gYvcOIA6CcU0ERGj0EuuCCm+IfsQFZoAtJvy3KGTup1xKTyWLmqGSIgM20TjrNttEcD9xe9Sxgzof9pnt5t8yVbkI4gf/jeH67YvjzpNUUFNw6pEtRIad6qiZfkRxdHVZzd/ERiQHe85CU+FYQIXecR/db6xGZF5nWBcb0z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=RUIA9eXa; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a452877ddcaso132641966b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Mar 2024 06:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709820594; x=1710425394; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5k7ZkrPt1CzNbrUtsGIPmHNYMv0hYyJAkoPlVK0NqiY=;
        b=RUIA9eXaZ/54p7xnPUJb5EOqvPuOyUBPHRpPghlkZVuDDVBTK2+5ksBKvHqZoTISXj
         Dgo3sXOTU/tDjDyFILkY9aY0rm3NGQ9hLqHAeyAe61ky+mQlF6bb2/LOA31APpkHdykx
         JArR8M5Fu484h2MeotpoTGZ/9oBIExoiY9eIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709820594; x=1710425394;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5k7ZkrPt1CzNbrUtsGIPmHNYMv0hYyJAkoPlVK0NqiY=;
        b=azs0ldQtYgbU73+mgBa07cU1rZ7gvJG6tGcctEqpb6jCPaXOXQTjG+2xgo/pwg7/II
         bDfASwRj7PEHb/cATxR39jgWftowK5B3g6SUS+cJATVJnkOCt/2oyIxD3axBTxEq8grg
         tju9GjDp69bPtLNR1gV1s9wo7fg4UbWgYd9TPmtaSTcJZrDrD1FTJLIgVrr4UJGzB0ej
         /t5igFV4IEmt4rrMsKZwu/5rq9y1kYF7KfDa5V31xJXnvM68a6qqsuahX21BpbJoizsF
         tE2ZUVkecXT7yTH8TCjUokOAEVf5e8lLv1M03eLr1gbGHz8f89NwNI2vYzYcOPC+YNKc
         Y3Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXIcWJa2JwperNbiQeChHv7jrOsDX8O9MgQmrJdI9b051Ci1lwLNxzimDk6Rw2QlPxlqHyFdxGT6tkQF9OgK+MI4Y1zHo7R3lOQDj4TPw==
X-Gm-Message-State: AOJu0YxnVpElmnQEFNbFXqvWnBDiI8cIgh998y2i+yLDBkkH4U37xfO7
	U9RCV7wm1bM1GeHouWLFK8bNa908EIbJDf/vObndoOxKbabnxDJzC9hx5DAABMNT0knU1rIKxKO
	vRBwrYnaAZrYBTY1QQLYUSCDjNxh+/yLr5ysRNg==
X-Google-Smtp-Source: AGHT+IHy9vEMpd5ryDhCr2qNIwpuQ3eni1u7LMwkl0/c3KSpoSzMmlX8V/S0jYfU9BwR9jOWmgDVsjfQsGejsR49dZw=
X-Received: by 2002:a17:906:ae95:b0:a44:8f3a:794f with SMTP id
 md21-20020a170906ae9500b00a448f3a794fmr12076477ejb.42.1709820593816; Thu, 07
 Mar 2024 06:09:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307110217.203064-1-mszeredi@redhat.com> <20240307110217.203064-3-mszeredi@redhat.com>
 <CAOQ4uxh9sKB0XyKwzDt74MtaVcBGbZhVJMLZ3fyDTY-TUQo7VA@mail.gmail.com>
In-Reply-To: <CAOQ4uxh9sKB0XyKwzDt74MtaVcBGbZhVJMLZ3fyDTY-TUQo7VA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 7 Mar 2024 15:09:42 +0100
Message-ID: <CAJfpegsQrwuG7Cm=1WaMChUg_ZtBE9eK-jK1m_69THZEG3JkBQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] ovl: only lock readdir for accessing the cache
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 14:11, Amir Goldstein <amir73il@gmail.com> wrote:

> I did not see a cover letter, so I am assuming that the reason for this change
> is to improve concurrent readdir.

That's a nice to have, but the real reason was just to get rid of the FIXME.

> If I am reading this correctly users can only iterate pure real dirs in parallel
> but not merged and impure dirs. Right?

Right.

> Is there a reason why a specific cached readdir version cannot be iterated
> in parallel?

It could, but it would take more thought (ovl _cache_update() may
modify a cache entry).

>
> >
> > Move lock/unlock to only protect the cache.  Exception is the refcount
> > which now uses atomic ops.
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  fs/overlayfs/readdir.c | 34 ++++++++++++++++++++--------------
> >  1 file changed, 20 insertions(+), 14 deletions(-)
> >
> > diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> > index edee9f86f469..b98e0d17f40e 100644
> > --- a/fs/overlayfs/readdir.c
> > +++ b/fs/overlayfs/readdir.c
> > @@ -245,8 +245,10 @@ static void ovl_cache_put(struct ovl_dir_file *od, struct inode *inode)
> >         struct ovl_dir_cache *cache = od->cache;
> >
> >         if (refcount_dec_and_test(&cache->refcount)) {
>
> What is stopping ovl_cache_get() to be called now, find a valid cache
> and increment its refcount and use it while it is being freed?
>
> Do we need refcount_inc_not_zero() in ovl_cache_get()?

Yes.  But it would still be racy (winning ovl_cache_get() would set
oi->cache, then losing ovl_cache_put() would reset it).  It would be a
harmless race, but I find it ugly, so I'll just move the locking
outside of the refcount_dec_and_test().  It's not a performance
sensitive path.


>
> > +               ovl_inode_lock(inode);
> >                 if (ovl_dir_cache(inode) == cache)
> >                         ovl_set_dir_cache(inode, NULL);
> > +               ovl_inode_unlock(inode);
> >
> >                 ovl_cache_free(&cache->entries);
> >                 kfree(cache);
>
> P.S. A guard for ovl_inode_lock() would have been useful in this patch set,
> but it's up to you if you want to define one and use it.

Will look into it.

Thanks for the review.

Miklos

