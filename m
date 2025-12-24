Return-Path: <linux-fsdevel+bounces-72038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D34CDBDDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 10:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E3A4300956E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 09:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA8E33ADAB;
	Wed, 24 Dec 2025 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6IU1+UB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844C130B510
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766569636; cv=none; b=ggL2FO4adHDYlzo0c6nhbuGW+C/iqRAcDrhB1flteRs6TPtpCdYrRwMyGSgJSmY43zUrar/68e7qZcgnt1TegdSRCr+ZPEm0Rjrt5lJUY6cRiao6i+LXOUa92RSS2Qha1UlbhOznJGVhWYn7m+Njk14P1KbjYokm9Y7uTv9soqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766569636; c=relaxed/simple;
	bh=3WwPAi6GWw857Gak2vKffzJbsdsOIPnhdNwDa66xA6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TzNFX9OM6kKevUddSVFImjh5jucPFOVuWAVcr4zdr/NpsAyKrTOgyHTba1iU5El6uW6gs4c4ibtO+89F5SF0gYQuie2CvxlgplCbbjV7yIm2gd3drbHMv+eiJ1jo2MeisgS1OZ++/znybSkyl7S0DfCyx8nX8fEdXSaYSZwzfYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6IU1+UB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47d3ba3a4deso4420625e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 01:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766569633; x=1767174433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6Mw+fgAuYTORZpYlCld7jbQZ0WmIDOv9Eo5eY1hcJo=;
        b=A6IU1+UBUW3KKscDl22DMt8D6fLGuo3a9qnpsTLbBDKLIUuaJQ3wwwszADyolEszEx
         geoyRJQQuKarkZAN7ygYwWeBIcX04jggo5XQPPVbLRToOX1uZjI3UYhiCYYqx6sUNh7X
         RJiMKqsRySbcwtXs/y9v8WNC9c/Z2z2otXHxGjjqtRFFOls2wizdZ7KpyRbcEbn9sb7S
         WQb+44VSbvsoOALFBueAxuviSg16WvoJ4jbsjAAWpRElWaF0/5flbPQOZIyeit9YmbOl
         +nw2LuzWEhjExkMr1Y8OGXanmgU66eR91ZfBTeqWrbGVFuO/eTK/64N90/MikFR8S7vV
         cjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766569633; x=1767174433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K6Mw+fgAuYTORZpYlCld7jbQZ0WmIDOv9Eo5eY1hcJo=;
        b=cCB2OxIPVQPPb6sztNIctf1USASv6nlcGGFR+teuYmg7FFj+zTU/BYDArvUL6Xsi33
         6ruTGWygPEEqwUX5V26oRdpJt0DKVI7ZvV9ZnWex/YgzaQDlA5QPuLRAdis4oT4yG1YL
         BM3IqnJKBEs/cbAvwpESwJIodmF+uX1/9b2hF/0JAkftoq/X7xqH5uWGVtadWw6vdE/E
         qowE3FHx1ABGofaj82o5OXcRt2mVwMGKvbtuhFDgOBOFy8kuB2TQ3cdtOu0JtclqKcpb
         z72AXoL1+wHuDtyEYMUU/MG7GEDH62DjZeHmgWjsz+3UJND6AX398IgOueOzbNik8wC6
         MP7w==
X-Forwarded-Encrypted: i=1; AJvYcCXs2JSs97u7MtnUDIueCSNe8TAKS6duqwy8F44so9Hsx9IdlmlCZb4+CDjyEsxrCxXXPp15patWvfAeQZBL@vger.kernel.org
X-Gm-Message-State: AOJu0YxwhDYjzrD+nquYOXRQb3Qzco/vwoM5Fhtn/cl921st3Ho18OJ7
	6ubMi5G1Kj387EVOD0+MAry2dNyS1+seYbQjxngktxZrDElXktIB9cZa
X-Gm-Gg: AY/fxX5x6UGTslT3JNkCBWeB6KuAVGz3cN6FIxJ83nogskMEasWEyZ//NEouDrI5Fd5
	Jggf8Kt/+fPKZ9aPoWORf6XyAhs9DJbauNOr9PVd01ScrvphGLnWXoV3l+dM5yrKGZSaPJeDwPG
	7Eay1mhEWnnSfT64MqPm2WcrPyhzrLYmlApsPSXn4w+5/JRbzfZZWkuE2+m/aerSorvVemP/9/L
	16W5/aWZl/6jVTLeC6TCVMusmY4hLs7IET5lmW+cDJVQN3tcHlGfoUoxrYOomGHZehdAaWlZjs9
	YeoiYtAg4sSQRd7GF9nttlOTPC2u4y/XVZs0oOwSzHBQWIhUUK6RJgv1Tbe3RhO4PQSFR5irucV
	MexDY7CgBwvgvfpb3TuB85XAknYisKN+RlF9606ji8kj9N4EtM9Vn95bexJoV67/u85pYFNiBbd
	2WSykanEdqwe+vrh2/JjrKR4EmsFoMemsphcVK9TxW0liI5ojGrxAgZWJ56kZEkA==
X-Google-Smtp-Source: AGHT+IHGj8t4k+MaGDBP6naQrG87ugF9YMEAtBRGvCNNU6h1/vj03U7uxdysFQXOCrj2EOEJ1QT8ww==
X-Received: by 2002:a05:600c:45c8:b0:477:8a2a:1244 with SMTP id 5b1f17b1804b1-47d195558bemr165624465e9.11.1766569632612;
        Wed, 24 Dec 2025 01:47:12 -0800 (PST)
Received: from pumpkin (host-2-103-239-165.as13285.net. [2.103.239.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be272e46fsm331672525e9.4.2025.12.24.01.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 01:47:12 -0800 (PST)
Date: Wed, 24 Dec 2025 09:47:10 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
 Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 "Darrick J. Wong" <djwong@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fuse: fix max() of incompatible types
Message-ID: <20251224094710.573cf39b@pumpkin>
In-Reply-To: <CAJnrk1bW+OoiZSFOzO8VAtHjS_Us=-AtuBSZZCvnrdvqK-qqfw@mail.gmail.com>
References: <20251223215442.720828-1-arnd@kernel.org>
	<CAJnrk1bW+OoiZSFOzO8VAtHjS_Us=-AtuBSZZCvnrdvqK-qqfw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Dec 2025 14:58:06 -0800
Joanne Koong <joannelkoong@gmail.com> wrote:

> On Tue, Dec 23, 2025 at 1:54=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> w=
rote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The 'max()' value of a 'long long' and an 'unsigned int' is problematic
> > if the former is negative:
> >
> > In function 'fuse_wr_pages',
> >     inlined from 'fuse_perform_write' at fs/fuse/file.c:1347:27:
> > include/linux/compiler_types.h:652:45: error: call to '__compiletime_as=
sert_390' declared with attribute error: min(((pos + len - 1) >> 12) - (pos=
 >> 12) + 1, max_pages) signedness error
> >   652 |         _compiletime_assert(condition, msg, __compiletime_asser=
t_, __COUNTER__)
> >       |                                             ^
> >
> > Use a temporary variable to make it clearer what is going on here.
> >
> > Fixes: 0f5bb0cfb0b4 ("fs: use min() or umin() instead of min_t()")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de> =20
>=20
> Hi Arnd,
>=20
> I believe there was a patch sent last week [1] by David that addresses
> this as well.

My patch was:
	return min(((len + (pos & (PAGE_SIZE - 1)) - 1) >> PAGE_SHIFT) + 1,
 		   max_pages);

And your suggestion of:

I find this logic a bit confusing to read still, what about something like:
	unsigned int nr_pages =3D DIV_ROUND_UP(offset_in_page(pos) + len, PAGE_SIZ=
E);
	return min(nr_pages, max_pages);

which is the same algorithm coded with some helpers.

	David

>=20
> Thanks,
> Joanne
>=20
> [1] https://lore.kernel.org/linux-fsdevel/20251216141647.13911-1-david.la=
ight.linux@gmail.com/
>=20
> > ---
> >  fs/fuse/file.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 4f71eb5a9bac..d3dec67d73fc 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -1323,8 +1323,10 @@ static ssize_t fuse_fill_write_pages(struct fuse=
_io_args *ia,
> >  static inline unsigned int fuse_wr_pages(loff_t pos, size_t len,
> >                                      unsigned int max_pages)
> >  {
> > -       return min(((pos + len - 1) >> PAGE_SHIFT) - (pos >> PAGE_SHIFT=
) + 1,
> > -                  max_pages);
> > +       unsigned int pages =3D ((pos + len - 1) >> PAGE_SHIFT) -
> > +                            (pos >> PAGE_SHIFT) + 1;
> > +
> > +       return min(pages, max_pages);
> >  }
> >
> >  static ssize_t fuse_perform_write(struct kiocb *iocb, struct iov_iter =
*ii)
> > --
> > 2.39.5
> > =20


