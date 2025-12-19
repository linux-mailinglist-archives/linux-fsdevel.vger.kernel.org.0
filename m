Return-Path: <linux-fsdevel+bounces-71722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E060CCF149
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 10:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C632301F5CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 09:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189C72E8DEF;
	Fri, 19 Dec 2025 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jp9qeAux"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61E72D7DDF
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766135227; cv=none; b=pIPBJjT9quC7MvFsnJdKMzZygBHJrjMfSZhrxGpFvKaaRy3O25mTl/t7oexYsntK8zh3CUjsTkTzCFBP9OnKWV3Djuf/W+q85FRqGMKzkSRHhsTyVAjdvb8c8UTw9a4nsXmWr4VUwd6DghvnBu3NRzz/S5rLoNcTQBGlFOy2/Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766135227; c=relaxed/simple;
	bh=IvXHjwzY77XaX7X/U9dF0cDnVYHe1YX3RN/SMu0a+j0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=td7gt9tKaE85IsQiuLoHbRsfR4AN1aQfjJi1zbxX12PwE+0UylOP81ALP29MnZ/PXyEkwX0W1DUN6zX7aZ0uRUh/9NjBTLfR2gKYpgvEDDumUsGV7lu5O9RecCFgVBvseKrPn/RWSZHT85WVvtruL1UFRAPlIU/yh8MafBCYoMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jp9qeAux; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47a8195e515so11837665e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 01:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766135224; x=1766740024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBS6/GkvOknyT7Zpvi8ZpC9HmfcmPlYKsO2XlNLAgug=;
        b=jp9qeAuxAD8Q2HE2+ijX5VzUIL4RQI5rrfccVcWgbBx8bKkIcvb6euKgGm2DPGAb7a
         d2p0z8wuj4gLtl+a4IWXtiRA9GnWgAMS55C1DEOLHdsxrWsn/GEFq1K2a1BYXU1G+VCt
         4qvNMCZtsWSOA/bdb0r+9h9z05dvl71RF22UWdDVSv9Gg8FMXLrzJGN+qV4tXY6hJ/wH
         Bx0tZZO8mwdSptw6Bj8IB0+GnSTkm6DiMFVByoyY+l8wC0YKn9R1I34hGi387/1IceQc
         /Z4NYOYcdTornnkb5o3TdkrQzwNMdAmpj7D6IM6atlrgtel1ugsItyBmwrWlqHwgUNJf
         JANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766135224; x=1766740024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YBS6/GkvOknyT7Zpvi8ZpC9HmfcmPlYKsO2XlNLAgug=;
        b=pzY75TGAjwgcicnkaL23tHGMQll7Vfzq8QxGRC0sPQH3giGDG+upqRsIpX750XfkKc
         NaDNlaZAki/MXeyuVlUo1wiX1i4vk4jUd/5xKJYakjxPnsZMKRhGc8TrKITrwlrFbutL
         wCJxBeQ5makQCBXmWpMJsrfJAByK8e5nMNB6e7qj2+JOtJPZwXO8XAaAC7Eq059EKuiR
         ZCm2LS/Peo4r8wEnQXkGj4QVjIUH5lHvaAVwkwdGGKQkfQKp9XFCehOozeAUob1xuDdS
         67aOoJMvsv23pin8qXY9LmzUZkRVmXeeDfH5uZkCixC8SoQaMJxA0P+mInT9UFiozqKd
         ALfg==
X-Forwarded-Encrypted: i=1; AJvYcCUsmWnrecdru6/PBmJ8pJ0bx0emSsiFPboKjM559qI5T0gGu1AQN9CuyEtb9Z8jRh+ezLMBV1YkESCqmYHs@vger.kernel.org
X-Gm-Message-State: AOJu0YyTKo/X1g5fkL2u5fTMnJWqatsxDT/Cx3xEDPpUt/P5SZk8V7EO
	4T7j9DOd4yDV90BFONDnn0y5DRp1//WcXitxP2oYF6aYk3yUF3RdxnZJ
X-Gm-Gg: AY/fxX7EgR5YEm17DEY/U1Ro5UPYTGNVzrae3VyI5gHKG9PZGRjyfy/FcWpPN9CSh7O
	DSLw+1fIP/LGrkV024J8pFEkdWsUEnAHGbJTi+WFsfB0dYbg8dmZVU1AlC+Ynl4QkM6NvtrQA0k
	GHvhtyudcdJpKPmLaRTklQj0euM+sh8wGu/upG9snBHMyjjLec/HqIWjvylXLFdiiBrECkiOEY8
	TTGMDXzkPvHxbCCm/Gldqx5BzRZJCtUz04wLzf8AhhrUt37vj8KHrBGj6HTd4aB9KOVKi/54TON
	VpLPPDqhxxCgFGSb/8MI8EuU9K8Oxs/1VeS0J+6eEeVz46QEmWoBkMwUzuv1RPFtx88X1NlPUJC
	ne3cP7ppYCNp0MxuBTHX8Pov14Gxv/YmWC7SHneOzTOQ8JXf22vtkaRe4RF1bGMQX9443r4djDU
	Rpmn35n1sAFeskx7ePkPjV27Hm+8idv3broaWCQ11/fAdT+brk6Lwy
X-Google-Smtp-Source: AGHT+IFLmds42d8vq8VOO1M1o+9hrFfg92pPA/nYyB7zACk7trqZpvV3gBxa+GxMMxXj4A+KGeNviw==
X-Received: by 2002:a05:600c:8b0c:b0:475:dcbb:7903 with SMTP id 5b1f17b1804b1-47d19555796mr16725745e9.9.1766135223727;
        Fri, 19 Dec 2025 01:07:03 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a49315sm33171175e9.2.2025.12.19.01.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 01:07:03 -0800 (PST)
Date: Fri, 19 Dec 2025 09:07:01 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi
 <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] fuse: change fuse_wr_pages() to avoid signedness error
 from min()
Message-ID: <20251219090701.58d8141b@pumpkin>
In-Reply-To: <CAJnrk1Zm7+-ha-Oyfamm0D1nEtzmYqP6cDF_mc7JftqWmENewg@mail.gmail.com>
References: <20251216141647.13911-1-david.laight.linux@gmail.com>
	<CAJnrk1Zm7+-ha-Oyfamm0D1nEtzmYqP6cDF_mc7JftqWmENewg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Dec 2025 11:24:23 +0800
Joanne Koong <joannelkoong@gmail.com> wrote:

> On Wed, Dec 17, 2025 at 12:22=E2=80=AFAM <david.laight.linux@gmail.com> w=
rote:
> >
> > From: David Laight <david.laight.linux@gmail.com>
> >
> > On 32bit builds the 'number of pages required' calculation is signed
> > and min() complains because max_pages is unsigned.
> > Change the calcualtion that determines the number of pages by adding the
> > 'offset in page' to 'len' rather than subtracting the end and start pag=
es.
> > Although the 64bit value is still signed, the compiler knows it isn't
> > negative so min() doesn't complain.
> > The generated code is also slightly better.
> >
> > Forcing the calculation to 32 bits (eg len + (size_t)(pos & ...))
> > generates much better code and is probably safe because len should
> > be limited to 'INT_MAX - PAGE_SIZE).
> >
> > Fixes: 0f5bb0cfb0b4 ("fs: use min() or umin() instead of min_t()")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202512160948.O7QqxHj2-lkp=
@intel.com/
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > ---
> >  fs/fuse/file.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 4f71eb5a9bac..98edb6a2255d 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -1323,7 +1323,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_=
io_args *ia,
> >  static inline unsigned int fuse_wr_pages(loff_t pos, size_t len,
> >                                      unsigned int max_pages)
> >  {
> > -       return min(((pos + len - 1) >> PAGE_SHIFT) - (pos >> PAGE_SHIFT=
) + 1,
> > +       return min(((len + (pos & (PAGE_SIZE - 1)) - 1) >> PAGE_SHIFT) =
+ 1,
> >                    max_pages); =20
>=20
> I find this logic a bit confusing to read still, what about something lik=
e:
>=20
> unsigned int nr_pages =3D DIV_ROUND_UP(offset_in_page(pos) + len, PAGE_SI=
ZE);
> return min(nr_pages, max_pages);

You can just do:
	return min(DIV_ROUND_UP(offset_in_page(pos) + len, PAGE_SIZE), max_pages);

or splitting the long line:
	len +=3D offset_in_page(pos);
	return min(DIV_ROUND_UP(len, PAGE_SIZE), max_pages);

Using offset_in_page() and DIV_ROUND_UP adds the 'hidden' requirement that
	'len <=3D MAX_ULONG - 2 * PAGE_SIZE'.
(Should be true - read/write (etc) are bounded to MAX_INT - PAGE_SIZE.)

> instead? I think the compiler will automatically optimize the
> DIV_ROUND_UP to use a bit shift.

Provided it is an unsigned divide - and the LHS is unsigned.

DIV_ROUNDUP(a, b) is '(a + b - 1)/b' which can overflow for large 'a'.
The other option is '(a - 1)/b + 1' which is valid for non-zero 'a'.

	David

>=20
> Thanks,
> Joanne
> >  }
> >
> > --
> > 2.39.5
> >
> > =20


