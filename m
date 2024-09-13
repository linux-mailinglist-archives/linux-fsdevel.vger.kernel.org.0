Return-Path: <linux-fsdevel+bounces-29304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E0E977E44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 13:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE6B286F99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 11:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019711D86E1;
	Fri, 13 Sep 2024 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="klzHJVj/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BEF1C233D
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Sep 2024 11:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726225992; cv=none; b=f71BGzMqBy0yVp2FHjSZUZN1oFELA9Z4n6n1KhypQoKqrN/uOFeQT5VTXWYpLgX+HAo87mQt+c6oTjnel5FqaX6kYOMxTGoVtA+zEONKEoHkxzWz0ExZjqBTvQfzyPgl6TRIsWZo06cC4Q62tmFbmGi0qzsNDOGngc7iZPL5xKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726225992; c=relaxed/simple;
	bh=zbSb+t5ixE8o67cfd6Km/gm2awkmir+u8zpMpsplQGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRUA3QMSfBGjk5CR5lQsFsu/tNZUI/U6hClY9wcO8DTvEqT1WOV0UjJPyeenfugR0oLWPfu28VVIuTvYzhL8Z7v8yJ5vb5SLjRtBW0o89WoLOMsrJvansgLqTSTmNhL345nLn4k9Oq/ae/eFYfbYTAI9RfnYX8kxuuZ6LBtpZvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=klzHJVj/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so10435135e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Sep 2024 04:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1726225988; x=1726830788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzJjhYKjiBT1tuK5nCeEJXIOyuLmQbR7LAo/1rJv49g=;
        b=klzHJVj/UUTnMF96Re4CUcRZ69gPnQBri3voRx28jirjocbJqDbBYYuxYrOzx20yCG
         sfB7Kv92fvpDSwvQ5cce5fpmE+8uY2QctBhO6Trq5TNhTl52egr9yIcSdOjs7TNLPhHZ
         GHVapxEe3v/p4rtgC0fbKZYOKCd5vQvJPgNmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726225988; x=1726830788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzJjhYKjiBT1tuK5nCeEJXIOyuLmQbR7LAo/1rJv49g=;
        b=oelOJtQ8+dHlV6ok+kfKSRhT7RZWJ2qRIl+4czK8D/a0aNE9NdOBzUesLwz6hvgcv+
         JYqw8gxVn9fizzMHtPXJHCRFuZ9v9mIF4/F5JbdOp4wAm1D7kSEhOjHsbIzOLFQACb3E
         R51TbkORIt452gbWSKZiyvSu+IO89LrUYuckkC7JGPGfq0rBgSBgPfwaQunhhwzHDRHz
         QKv+pXdo9MbevmBY4rL/3W0p/sDtLCqmiPRCE8s1t0RSvRspFD2xlBTbyeIOUXZTgnQZ
         EafQEuq9C6OiUibsxW7n/jL3yF/Pq399DmsKtXKI1OzwKOa9mEQnMYBoIeCrnJ1N/WMg
         UcwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAf6X2+CWta2ZTMAMYBwrBiRwjOn8ycSZCOXq2K/eGW+EzbcX8hhXYnXVgEqK7QkxcrTR/gx2gAzTZUax5@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ+5ooiCmVltb2lQdRH1InpxhggVaPM8+VeBJN5cQ85qR7CpsH
	X7ZaEPHjmKrQbC713bbqt72wE2dnPFNfx2N7O68ZphIxpwJ7D440ZLnztMB09nGct/rDM7L+fQN
	qRN6+hsSY11sj1aUU7rQ0b1xs5UMysrrWQYi/Dg==
X-Google-Smtp-Source: AGHT+IF0rWJkt9HIuTWcRdDZRqEprtWplUYLbiPG5xYQ/lFDOTYufWWzrG3a+mmHCYeA967U7HDUbDGp+DRsbj2xwGw=
X-Received: by 2002:a5d:58d4:0:b0:374:c7a5:d610 with SMTP id
 ffacd0b85a97d-378d6236b9cmr1930033f8f.43.1726225987687; Fri, 13 Sep 2024
 04:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913104703.1673180-1-mszeredi@redhat.com> <CAOQ4uxiQxQeAd6oEWkKTyEj1SttkWhOC+uPZMZX6+ziV1FVc+w@mail.gmail.com>
In-Reply-To: <CAOQ4uxiQxQeAd6oEWkKTyEj1SttkWhOC+uPZMZX6+ziV1FVc+w@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 13 Sep 2024 13:12:55 +0200
Message-ID: <CAJfpegsfrfwgqfeap7VkJkxsPzjW+WhjJqjYfDVyCa9WF-40Cg@mail.gmail.com>
Subject: Re: [PATCH] fuse: allow O_PATH fd for FUSE_DEV_IOC_BACKING_OPEN
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Sept 2024 at 13:05, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Fri, Sep 13, 2024 at 12:50=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.=
com> wrote:

> > -       res =3D -EOPNOTSUPP;
> > -       if (!file->f_op->read_iter || !file->f_op->write_iter)
> > -               goto out_fput;
> > -
>
> FWIW, I have made those sanity checks opt-in in my
> fuse-backing-inode-wip branch:
> https://github.com/amir73il/linux/commit/24c9a87bb11d76414b85960c0e3638a6=
55a9c9a1
>
> But that could be added later.

This is the wrong place to check the f_op.

We could do it in backing_file_open(), but this isn't going to be a
common error, so I guess just returning an error at read/write time is
also okay.

Thanks,
Miklos

