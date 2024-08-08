Return-Path: <linux-fsdevel+bounces-25382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D175C94B451
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 02:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89498282058
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 00:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBCF2C95;
	Thu,  8 Aug 2024 00:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VCt3glXE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8A110E9
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 00:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723078297; cv=none; b=EbLdzKsn9BKX0Y/btRNbzlS2XXxvFg/F87XTWYvNzpwvQHCAc+gXWYWESnCdwy1SkRK1fb/DDkTOB3miL/QLPjb+HECIXSKeufYHIyhi1VFVzXGeXFQsEVDJHRR7xVrgXButFa4+2zHQp7AeMW59fDCucHTt3hMpBSuWvWshutQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723078297; c=relaxed/simple;
	bh=fO2OtSqcuvhoGCa9F8wZkIuKvhlKPxC8Cy59sY0CkuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kb8N6VLLx2PltUrgE2jfSNM77gcvwj98jyOVSxL6mqAsKR5q9rDPHmLXIb+Mhmc4t7RWhJh+mU3gpF/x7hS5rh5ZZwZoiqd9zT7JB5EeqXINOuDDAB/Si8tCdu0RJtCGyMjG1M7nN6FPnKf2zZmOKmRFlGaGDbr3s47TN2WBhY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VCt3glXE; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so4357a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2024 17:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723078294; x=1723683094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEZj0QrLHBrSCw4XztELXFBhncIt17KxJJyw7mNhHBs=;
        b=VCt3glXEBOgwS6A0oWxWzb0+MQgS/VMTFPT8RXv8KEG0i6sZBL7KiDxjcTDtAuaNln
         mtccvhrjt/usMrjjomlsqdzsSxFxG0cxiQS3tfVEDzWjRxwZbAiezEypS/waOlTg3iPa
         9JdT5voqViM8cthBkbosguhxvEgDlg1hg75XkkgDpl3Td8OmAsgQcosilevoI30+HpZi
         Qbh0LsHIC6A5/okskw2Cbeo8CoaVh6HHkY+vT8gFLFQHnwzt9PB2JK4qBnnEWvj5rCrN
         a5xZ5Ts0aCDZZAucu2VnJMcOiWI7lt9+XEov9I8aJuFLqJ/2lMyNt3FfIWVPCP2vlKAx
         5/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723078294; x=1723683094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEZj0QrLHBrSCw4XztELXFBhncIt17KxJJyw7mNhHBs=;
        b=xUURbg8fQEH5yawQSBH3v+T72qVZfsZRyM7Pc9IgdNp9ImOIWNfDgzhWNt+Yi9NUu0
         sl2aFPLvh/2pIb197EfQxUn+5MmVCw2gHpgVxeHIOwQBX+Fzi53pyAXO1ahUspLdXVGj
         xLstjRF/3oG2QnvJjHU7tLsVMzn0yIqMxGAW9NIOmdmaBfU143GkzBeAcTJuDuFIrl47
         dUMZKfL/5mbyhWCvMT0QYvX1LXw7iQlJJCEbOuqItZLHsJepI+gRty3YLO58H3gakZo/
         ufTQsmvQWcIymcQedDS8rkOwXuFJJddJklE51Ikn/eRQRMuSZVGqY2XgfDRQyPl2TqUT
         oFyw==
X-Forwarded-Encrypted: i=1; AJvYcCVfLiybd8vtcMOpWMig7JdJ/+3O4kJdlqvDqABfLS99zHrVdX6K53XuwMCOfgOnsBt0A1J2Qcy2uu1Zi1yo60wLK7ghmtD649hdDZaf0Q==
X-Gm-Message-State: AOJu0YxHHzqMT8/bgyPWzwW0fXP3K68qvnGbx2rTvuf1/ZJxO927hsHW
	HEXxQpxdB6ZqqU5V5RUzTZi+lwr8dSVIn1xBRp87CiBi4I3CiB5vuEiLnzb512GfE8fNWi2kcz5
	Fl6eIyVMESpqDAzI0jJ2CGB+01PI7DRhafet7
X-Google-Smtp-Source: AGHT+IHfdrKcc0tfkNYSV2Jb/ciOoXPfrQKHM9p8Ze6f84qWHElhbcsNyOJ7otmZZkg8k7BAs5st/seTsGSletoFjFw=
X-Received: by 2002:a05:6402:2684:b0:58b:93:b624 with SMTP id
 4fb4d7f45d1cf-5bbb17779e7mr45615a12.1.1723078293786; Wed, 07 Aug 2024
 17:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807234029.456316-1-andrii@kernel.org> <20240807234029.456316-3-andrii@kernel.org>
In-Reply-To: <20240807234029.456316-3-andrii@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 8 Aug 2024 02:50:57 +0200
Message-ID: <CAG48ez3apg4N2JJrNyssE_sDda10yAUHnn1YF_GLHvVCUoLGkw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 02/10] lib/buildid: add single folio-based
 file reader abstraction
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, 
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	linux-fsdevel@vger.kernel.org, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 1:40=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org> =
wrote:
> Add freader abstraction that transparently manages fetching and local
> mapping of the underlying file page(s) and provides a simple direct data
> access interface.
>
> freader_fetch() is the only and single interface necessary. It accepts
> file offset and desired number of bytes that should be accessed, and
> will return a kernel mapped pointer that caller can use to dereference
> data up to requested size. Requested size can't be bigger than the size
> of the extra buffer provided during initialization (because, worst case,
> all requested data has to be copied into it, so it's better to flag
> wrongly sized buffer unconditionally, regardless if requested data range
> is crossing page boundaries or not).
>
> If folio is not paged in, or some of the conditions are not satisfied,
> NULL is returned and more detailed error code can be accessed through
> freader->err field. This approach makes the usage of freader_fetch()
> cleaner.
>
> To accommodate accessing file data that crosses folio boundaries, user
> has to provide an extra buffer that will be used to make a local copy,
> if necessary. This is done to maintain a simple linear pointer data
> access interface.
>
> We switch existing build ID parsing logic to it, without changing or
> lifting any of the existing constraints, yet. This will be done
> separately.
>
> Given existing code was written with the assumption that it's always
> working with a single (first) page of the underlying ELF file, logic
> passes direct pointers around, which doesn't really work well with
> freader approach and would be limiting when removing the single page (fol=
io)
> limitation. So we adjust all the logic to work in terms of file offsets.
>
> There is also a memory buffer-based version (freader_init_from_mem())
> for cases when desired data is already available in kernel memory. This
> is used for parsing vmlinux's own build ID note. In this mode assumption
> is that provided data starts at "file offset" zero, which works great
> when parsing ELF notes sections, as all the parsing logic is relative to
> note section's start.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
[...]
> +static int freader_get_folio(struct freader *r, loff_t file_off)
> +{
> +       /* check if we can just reuse current folio */
> +       if (r->folio && file_off >=3D r->folio_off &&
> +           file_off < r->folio_off + folio_size(r->folio))
> +               return 0;
> +
> +       freader_put_folio(r);
> +
> +       r->folio =3D filemap_get_folio(r->mapping, file_off >> PAGE_SHIFT=
);
> +       if (IS_ERR(r->folio) || !folio_test_uptodate(r->folio)) {

Can you also fix the uptodate stuff in patch 1, or in another
stable-backportable patch? (I guess alternatively we can fix it with a
custom patch in stable after it's been fixed in mainline, but that
feels kinda hacky to me.)

