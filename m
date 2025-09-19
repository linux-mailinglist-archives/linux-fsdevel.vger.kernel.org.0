Return-Path: <linux-fsdevel+bounces-62215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DB8B889BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 11:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73AD83ACA40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 09:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD7630748D;
	Fri, 19 Sep 2025 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTok00sK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59552F6187
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758274632; cv=none; b=EQ4crf/IttVrdoR/0b6WGAcGmzt5yLqiRmeRXItzIsGaOPPgcODjNzrRUXXAHchayL55Hs2yPzz9taGpvCUeiofbWhi49dX/qfJkFwGglhN9lFhUqjR9WXu/CWa6J8MZS9P+sJriggRaWNy8cJxbC3k/DcZKaFY4ZKu2x/ap/28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758274632; c=relaxed/simple;
	bh=ux0ULfd3xCncc0cwLZBeo72pmM0oL3gedYheRT0V9BI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZ4pXgoN4LzG6s56HJt7bm32w7p68z/Po4KaR3EtYs3bFqtM6kjmXvkU3KYBsqLREDyG7YKU5v39IwHMOXOq26C1MM+LOWHOzwLDX9VOStMoiKMyBcqtFDRvqp9iliI+kf9O6lGRRA8Zw77w+8pOAxo8JBAvaZQgI5Q+eTEsvw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTok00sK; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62ee43b5e5bso2806375a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 02:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758274629; x=1758879429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nc22zviXbCVE/wfqJE1lji2RZPwM55lMyHr7YuKEqp8=;
        b=kTok00sK0f2gRnxy8RYTfv9Ku957i/oopkXKrZIKIsUK/BTNUXpHY3P9umzxlo+l58
         gmXL7I6+DymDcqn2v4n0zUYYLaC6W+LRgwot0DbA/sDDPxDfF7poA2qbEubTEqqN83Kn
         h+Xqek9K2dr507fBzj7N6fDVnkf/6DfUQlNw8K0PqA6UrM64iI19Euwud9OaiSaaccA6
         41SRbLGEJPwGD67x3lljYYSCkw612YJrkDs3fcB+vW75iyTxOI9I+F1NHsx0lZauww8q
         Tt1r8WMxe1BdRSlL56Wt5TdJPP1v3GDYffXPEUuU/9Lwo0gizWG3J5CCMfFrMsAfriEX
         eq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758274629; x=1758879429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nc22zviXbCVE/wfqJE1lji2RZPwM55lMyHr7YuKEqp8=;
        b=ONiL3AUsN3uHpmOgLSkagUpXPjFkZiNeiYJGCbtMAfZTsKnCRM/zd8MXcVsM7RWEi8
         9uojNb/HXVAlKrDkvyKiAzHIOtHp426wwhpVDaj6gD/PSkiEBpV/eGMY3bOV8lGVfetD
         m07nhu5xzJFcGgQyQaStKz7M/6FaPLdrMt0KYDwEyvf4B0fk+fbeB3TRdhW2VxYfhrEF
         bONMLanbg1QI9mQq29qTjjyFby0SZa3WLKXmIsUENVb+t4mtQbmfLBH4jWw3I5/ZSbVe
         cGdx5PpFwz5Tn7aCW1rdOsR0WhJnqIRes4/bUTJ1WIbRVRNzsA7LPNHgA2CMbwNjIFl9
         emnA==
X-Forwarded-Encrypted: i=1; AJvYcCU8QeBgWC0dZmek5M2ZSGPI2SwwAb3hKlAlcyJBFddkdRAvIE0hjpVlcxuhnghCiXt0TBImrSu7C9SVxYcG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9maDmEcoJM0ESM5/Y3a6sYIv1bSygqNezDJZm9b99AvBnmxGZ
	vGR7AmCCelfOe8sRt0raxuhNLG0+8NZmQQmhbAS4px7qnyOjIlKynpgG6JxqDIgFI2jVFwFOQHL
	yBgLG6MApHWEJsyP9hZM0jJNZ6l5wDPUKvPRTbXk=
X-Gm-Gg: ASbGnctip/FTNqr2IwJgSAzyEbC+h9XpxFIvRZ3pO9awInDZDES+pRoCBVeOLkIk8zx
	lNmNlMqmyZYtNoYcTGtNdCpnotclBPULiR/1hGI1NjqIiYp0Y9rtuo+MgEjaYWJ/j6eYk6CdxQJ
	eA5sN49gu2DZhfvQyMPxMwcerbeIPW2Ir4LCvykUo2AZJQhWAf9ODolOa9jv8uS/0sFjkJJfu1C
	yMNdCYZldBd4r+etUmBaI6TGPQ9cx9H8YGM
X-Google-Smtp-Source: AGHT+IFukV2hHzyYfAw61zA4QToWTJ0gmln+XCIGEGxvWOZGM7oulWjg37nN3xnrdo4Hx0eZ245YAV9OWI8OWD0umUI=
X-Received: by 2002:a05:6402:2344:b0:62f:3135:cafc with SMTP id
 4fb4d7f45d1cf-62fbfeac925mr2202455a12.0.1758274628822; Fri, 19 Sep 2025
 02:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175798150680.382479.9087542564560468560.stgit@frogsfrogsfrogs>
 <175798150773.382479.13993075040890328659.stgit@frogsfrogsfrogs>
 <CAOQ4uxigBL4pCDXjRYX0ftCMyQibRPuRJP7+KhC7Jr=yEM=DUw@mail.gmail.com>
 <20250918180226.GZ8117@frogsfrogsfrogs> <CAJfpegsN32gJohjiqdqKqLqwnu7BOchfqrjJEKVo33M1gMgmgg@mail.gmail.com>
In-Reply-To: <CAJfpegsN32gJohjiqdqKqLqwnu7BOchfqrjJEKVo33M1gMgmgg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 19 Sep 2025 11:36:57 +0200
X-Gm-Features: AS18NWCnD9OqR8OqnJ_FjK5YRfMqJ_5QvxTbXiPNxb6ZHovm0AhEqankCNyCon8
Message-ID: <CAOQ4uxjLJUng7ug0e5V0qcSy1Qq0Fg963u-yAHcTeUJ6G+RPDw@mail.gmail.com>
Subject: Re: [PATCH 3/5] fuse: move the passthrough-specific code back to passthrough.c
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Darrick J. Wong" <djwong@kernel.org>, bernd@bsbernd.com, linux-xfs@vger.kernel.org, 
	John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev, 
	joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 9:34=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Thu, 18 Sept 2025 at 20:02, Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Wed, Sep 17, 2025 at 04:47:19AM +0200, Amir Goldstein wrote:
>
> > > I think at this point in time FUSE_PASSTHROUGH and
> > > FUSE_IOMAP should be mutually exclusive and
> > > fuse_backing_ops could be set at fc level.
> > > If we want to move them for per fuse_backing later
> > > we can always do that when the use cases and tests arrive.
> >
> > With Miklos' ok I'll constrain fuse not to allow passthrough and iomap
> > files on the same filesystem, but as it is now there's no technical
> > reason to make it so that they can't coexist.
>
> Is there a good reason to add the restriction?   If restricting it

I guess "good reason" is subjective.
I do not like to have never tested code, but it's your fs, so up to you.

> doesn't simplify anything or even makes it more complex, then I'd opt
> for leaving it more general, even if it doesn't seem to make sense.

I don't think either restricting or not is more complex.
It's just a matter of whether fuse_backing_ops are per fuse_backing
or per fuse_conn.

It may come handy to limit the number of backing ids per fuse_conn
so that can be negotiated on FUSE_INIT, but that is independent
on the question of mutually excluding the two features.

Thanks,
Amir.

