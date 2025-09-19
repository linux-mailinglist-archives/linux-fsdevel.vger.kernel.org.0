Return-Path: <linux-fsdevel+bounces-62214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 745B5B888A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 11:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2396264BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 09:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBE02F3600;
	Fri, 19 Sep 2025 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gO3EkDqm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313C52D239F
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758273863; cv=none; b=GwPnj1KV4iXcLchp7G97LWuM7EuxQRV8yWujfybDXNlfB+AXA8b7AgUEB+82K2KTOr/GITTzaBwtheKd82tlsEzi5yCqCCcTZC1lOw7AayxREVAjlN2vVqWSLzstcPe2yQtQmqgAz2bnR2AK2cC4sT5tSH13U37q1Di6eYrInjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758273863; c=relaxed/simple;
	bh=KQiTAQdiwN+GJ50j+5K2WRjp/AryOxnjKJ+Cu9OgotA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvtwho8G/Ff7PlwT2Q1Xt4Qi4ysJ9mZ5GyMSORZZ19hw7ALqftKUhW0WkSybWL358XA0dUVp2G1cos3bmVobgZyfh0JKqBM+xHbV2f3MF+btJTHy41Cnc0ET55rY+5wNNDvrE8GfezdG/jKnkaAl/umYm4mIfQAJ3TvmBo2mlMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gO3EkDqm; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b58b1b17d7so19859751cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 02:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758273861; x=1758878661; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LGK83wgkCsEHYgUlZnWfhWk+fS3ibzSHWue8+kKX8SI=;
        b=gO3EkDqmrvD38Lo3LtI4ZknKbm3H+aJ2QpJZi/GZ37rNjVp3KjG6S3PWXtmLqtt+qB
         PkPI0s5HJWzQOLQvWYc3Q4x69DxmfIK5ynoF5XFt0ZchFuKy2AXHCWPTvGeTARE6viwc
         IR09W8Tzq4Avp1oc+VzA105UDmRBunA/H8IJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758273861; x=1758878661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LGK83wgkCsEHYgUlZnWfhWk+fS3ibzSHWue8+kKX8SI=;
        b=PEOZEpEE6Qdo6xHoSR3A77B6V/UhFNb7c3KwmgC6IwP4He/y3oYrxlHGBOZXNnWcGU
         UBx4UvvRhgDf02HcHYjG1L71RHKmPfXD1Jh3szMlTkCb4tUwO6HWAcMpm+rOtgZrhfNl
         kMT7bC2OAwm3Qgi7uWNnxTTcDTAAH+keGxKCQa2FVGJB7UpLBk5yZgGSu09RRJmyJ+hZ
         tJfq1XYnj5P5vGkUdE2VqJbtHmLQW9RIxGVetai5CdqSVhRfU7jj3BroTn/w46Pe2b/7
         knpL6WxJpghDXJS1lL+dZy++hQxAE4RHU7q80r6niWy7v88zntMZJp/5gJlNSxP4Iw2A
         wYWw==
X-Forwarded-Encrypted: i=1; AJvYcCUENaBdO3deTQwEIZzcmemB55qcb9/wtmFqa9DY9+m/rfbTJMiulTpx+Ckofg8J5BLPpleW9HpAy7uEaDPd@vger.kernel.org
X-Gm-Message-State: AOJu0YyzST1Y1ZoUMb5pr3xFj8Z/9fHey34VvzH8gbT/1f5ggdE/bBEd
	Z4Z+/uT4KvU7fu8ESw0ZdRa0rtOlAHZYnNhhnn5e9cwZYSXaEbOlAMj9ZviQlXUhlSzCZuko9iu
	iPXZSrFStTGkeqswTPsIgUwPI4znDn9txrtQSSsdZvw==
X-Gm-Gg: ASbGnctOoY683+ZiFmPHtY7c5eNt7DwI4P+aKQzDdcOu6smcidKEgP93ov7HePhoyrE
	YbBvrXRKZGnUdfAVwn9Q84mCQWlknT9U1rCm/F3oww/IWPB+ClzJNkZJ6ZfvD7mtu/SI2Y3OCJ4
	5fmWSAClP4+0SH5KwsUIPN4oXi3/3/SZ/lYAKfCRTHoiNGwul7xQjcioUpB8c7eu6bofp2W2dYo
	kDpeDPPx+7TjRXe8KsUxsE0yicBHe69Iaqs0OI=
X-Google-Smtp-Source: AGHT+IFVKeGNA8iwunayOdCnDn5gUFohC0mpxMLUoxxNAtrXMYz0aKJkUCwQzwld8NOhocQEH/GMZcFPKFcgY7oqbys=
X-Received: by 2002:a05:622a:349:b0:4b7:ad20:9393 with SMTP id
 d75a77b69052e-4c03c19445bmr33624631cf.4.1758273860883; Fri, 19 Sep 2025
 02:24:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
 <175798150113.381990.4002893785000461185.stgit@frogsfrogsfrogs>
 <CAJnrk1YWtEJ2O90Z0+YH346c3FigVJz4e=H6qwRYv7xLdVg1PA@mail.gmail.com> <20250918165227.GX8117@frogsfrogsfrogs>
In-Reply-To: <20250918165227.GX8117@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 19 Sep 2025 11:24:09 +0200
X-Gm-Features: AS18NWCjc_3E0iwkIgU5uLF3JTSa4tc2BBRJoi7PMNgtkSa_UrI5XoMgEJYheE8
Message-ID: <CAJfpegt6YzTSKBWSO8Va6bvf2-BA_9+Yo8g-X=fncZfZEbBZWw@mail.gmail.com>
Subject: Re: [PATCH 4/8] fuse: signal that a fuse filesystem should exhibit
 local fs behaviors
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, bernd@bsbernd.com, linux-xfs@vger.kernel.org, 
	John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 18:52, Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Wed, Sep 17, 2025 at 10:18:40AM -0700, Joanne Koong wrote:

> > If I'm understanding it correctly, fc->local_fs is set to true if it's
> > a fuseblk device? Why do we need a new "ctx->local_fs" instead of
> > reusing ctx->is_bdev?
>
> Eventually, enabling iomap will also set local_fs=1, as Miklos and I
> sort of touched on a couple weeks ago:
>
> https://lore.kernel.org/linux-fsdevel/CAJfpegvmXnZc=nC4UGw5Gya2cAr-kR0s=WNecnMhdTM_mGyuUg@mail.gmail.com/

I think it might be worth making this property per-inode.   I.e. a
distributed filesystem could allow one inode to be completely "owned"
by one client.  This would be similar to NFSv4 delegations and could
be refined to read-only (shared) and read-write (exclusive) ownership.
A local filesystem would have all inodes excusively owned.

This's been long on my todo list and also have some prior experiments,
so it's a good opportunity to start working on it again:)

Thanks,
Miklos






>
> --D
>
> > Thanks,
> > Joanne
> >
> > >         err = -ENOMEM;
> > >         root = fuse_get_root_inode(sb, ctx->rootmode);
> > > @@ -2029,6 +2030,7 @@ static int fuse_init_fs_context(struct fs_context *fsc)
> > >         if (fsc->fs_type == &fuseblk_fs_type) {
> > >                 ctx->is_bdev = true;
> > >                 ctx->destroy = true;
> > > +               ctx->local_fs = true;
> > >         }
> > >  #endif
> > >
> > >

