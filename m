Return-Path: <linux-fsdevel+bounces-29819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF8397E57B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 06:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074691F21696
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 04:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C9312B63;
	Mon, 23 Sep 2024 04:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3I0p6Wm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57CB17597;
	Mon, 23 Sep 2024 04:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727066713; cv=none; b=PEJKeC2IxScmS1I4JdWAHVyWzFVKzBtImcMcqMudS4mIu++qsJ5PZy39S2w4OWPNlzfKS1PamsEWu7Co9vbJ0uP0FTBEQHVBAHvEGM80boksFbIXWzh+7hG5u6uJHmzYhpaSczO5XxflC6CBE5Q4Vx55qmTbMndeYWR0Vk98lCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727066713; c=relaxed/simple;
	bh=H4lW2GbrSxIbifL9QDRCmNx0sdIMaESBWAmbtjAnK4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DAwZM69QBX7J3ysxQvVXNKWNDZBpvpcW5bb8uFXFigltBLv7mushEC7fOryJ+u94u+StCqGH0edh2/RbL3QGpoba8IjCHfvRUZqqGQsj9Vo/mAQ8W1BR9ZKQUGNdaIfHnXadDxEYEcoMtvhiSc3fkqaHtBh9VwVEiWhrI/UuNMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3I0p6Wm; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-45821eb62daso25259931cf.3;
        Sun, 22 Sep 2024 21:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727066710; x=1727671510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+UDAv8JUuD8CeMJd4evn90rK4F2VqQSJxb+UyTjTm0=;
        b=b3I0p6WmNrwKGJ4sfxuW7MeXFGb3nn/OLfH/psGZ51qTb49NjXK7vD0PGVooXUgmMK
         tDI3uEkbblLizqbU8ANdql0mxIlME2aMUlWIhcORNxn8pi3gCbNfuNmIEMwfDVszUkQB
         ry/zxz3dIZwjVj+DfgkfEPmZW+stRw5zkigXalLyfoIMFb3wo+tALnnjbd/Fby9NmmlG
         qg6/11btFxwURX7gIg0059dgdfk1u3V7yVVubRF0zAQdFND5RUC0tVVVO6rlD9mQzJmr
         J5UFD6Nylf4QuxHWBWo84vn9/T7YT5cruaNq8vRnhYWrGciifMhbQgCHaN4qzizEDanw
         SFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727066710; x=1727671510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+UDAv8JUuD8CeMJd4evn90rK4F2VqQSJxb+UyTjTm0=;
        b=SjxqGP08MimWLYrwZkN142GM+OVoG+OlDcfj4+q9SKKsD1pgTRjo/r03Q7e4Sqcii5
         FKWkdta7RKSkgxQBvxFaKcbPBVHj3pIKXtGzF2PPTElJDVdjncqp68hAxJjNpTQgnqeZ
         +A/a/FY7TrKDyER8FY1liwTG+STNydOqm/OuSbnSwZnbQGi58qpxaega/CxBjuUXVkjv
         1pKsNRRTEX6VChqTk0J8SBwjBnN8R+6mF1cGMbq5IB7Y61J5NSPjx5RfzuxBXZIDn7Qv
         s0fF22dz14W0Xpwkc/bq36VOHIJuc9BPFMhSJyqJezfASEFnJ86TQU/RI8VLRR0Tp3zn
         iOYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZux5oUGaLSjb1rMEajU/kZOC6LRrCEjJXaHdYS0D5PD/ewFBqtiLbO37Ob8z8/GwkaVrdQc+/@vger.kernel.org, AJvYcCXsEfTDMvm2kKlKoDBL8gigcg8gyMmyOJw0W464UoK4+3RfvThlPCCra6C0goIi0PQXetHKQzNGLG1W3uJoTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv5wniMrl6Wi6QJAirOkPBaPiOBQQ3kZiKaDMutRAJBwXCX4jS
	K0lyjw8hXG3PFue83rP8HnO1pVk8cvi/PrOTI5zTQu82Mejpr4PyiBO7vHplQvVYnyGFLkgnv2j
	LyFZzyPrZxjRWHsD0po7dW7yCPw0=
X-Google-Smtp-Source: AGHT+IFCUNNKXhR8Wyqn9c0M40t2qOE+oiVeSi6DK0gS1TmMT+a2pTIlUG58PCLyvyT4IagFnjfHia6qd2C0LPYglKA=
X-Received: by 2002:a05:622a:15d5:b0:453:1afe:c711 with SMTP id
 d75a77b69052e-45b2050e59emr121771071cf.28.1727066710497; Sun, 22 Sep 2024
 21:45:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829165627.2256514-1-david@redhat.com> <20240829165627.2256514-2-david@redhat.com>
In-Reply-To: <20240829165627.2256514-2-david@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 23 Sep 2024 12:44:59 +0800
Message-ID: <CABzRoyb3zNKPKCSWzdK8uy81pzf8MB_-4-kCCAoTeoPHD5tExA@mail.gmail.com>
Subject: Re: [PATCH v1 01/17] mm: factor out large folio handling from
 folio_order() into folio_large_order()
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 12:57=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> Let's factor it out into a simple helper function. This helper will
> also come in handy when working with code where we know that our
> folio is large.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

LGTM. Feel feel to add:

Reviewed-by: Lance Yang <ioworker0@gmail.com>

Thanks,
Lance

> ---
>  include/linux/mm.h | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b31d4bdd65ad5..3c6270f87bdc3 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1071,6 +1071,11 @@ int vma_is_stack_for_current(struct vm_area_struct=
 *vma);
>  struct mmu_gather;
>  struct inode;
>
> +static inline unsigned int folio_large_order(const struct folio *folio)
> +{
> +       return folio->_flags_1 & 0xff;
> +}
> +
>  /*
>   * compound_order() can be called without holding a reference, which mea=
ns
>   * that niceties like page_folio() don't work.  These callers should be
> @@ -1084,7 +1089,7 @@ static inline unsigned int compound_order(struct pa=
ge *page)
>
>         if (!test_bit(PG_head, &folio->flags))
>                 return 0;
> -       return folio->_flags_1 & 0xff;
> +       return folio_large_order(folio);
>  }
>
>  /**
> @@ -1100,7 +1105,7 @@ static inline unsigned int folio_order(const struct=
 folio *folio)
>  {
>         if (!folio_test_large(folio))
>                 return 0;
> -       return folio->_flags_1 & 0xff;
> +       return folio_large_order(folio);
>  }
>
>  #include <linux/huge_mm.h>
> @@ -2035,7 +2040,7 @@ static inline long folio_nr_pages(const struct foli=
o *folio)
>  #ifdef CONFIG_64BIT
>         return folio->_folio_nr_pages;
>  #else
> -       return 1L << (folio->_flags_1 & 0xff);
> +       return 1L << folio_large_order(folio);
>  #endif
>  }
>
> @@ -2060,7 +2065,7 @@ static inline unsigned long compound_nr(struct page=
 *page)
>  #ifdef CONFIG_64BIT
>         return folio->_folio_nr_pages;
>  #else
> -       return 1L << (folio->_flags_1 & 0xff);
> +       return 1L << folio_large_order(folio);
>  #endif
>  }
>
> --
> 2.46.0
>
>

