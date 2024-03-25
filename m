Return-Path: <linux-fsdevel+bounces-15204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 565EF88B309
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 22:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F20AB2D4DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 14:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0F615B12E;
	Mon, 25 Mar 2024 11:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="a32WMOuD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4CF15B554
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 11:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365680; cv=none; b=PLhe3KIkIJOIbhE+dR2Yrr/41V3Pcdh0oKP+09+UMd0PRX57waLlrc0VRPZGbCztt/tMAACM6l9VwsxY4IwzdzwEmQsS4Cl5TncayoxHmuc1DST4TutpBrWf8O1efyWDcH4ZGHhma46rJzZJrhWKu87qRZO2eRa3urohgdfyYzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365680; c=relaxed/simple;
	bh=xudEe2YJTvWsBm8CpDg5lmI/tLcexD8Blm3Xdr2w+mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0WaxQItRMWYGTJ6PShkOjBR7d+BIdbsY4Cng463cc5fsCEE4wUnIknI1xRNVxaEriFfVMtKSighFzKnXoCOLZYrxNXTbggbvVwJiJE8KCcrkt+huDBI81vTBaasHRPd44L48fWzh5thEgnAw4KX9hw7Cs+D2guypy+OQ6Izfr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=a32WMOuD; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a472f8c6a55so340419766b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 04:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1711365676; x=1711970476; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0c+XedPdeNuNXfU5mtLEzBWBIzV1dWjxq7xb3M/FhvM=;
        b=a32WMOuDNG1J+K0+ytDniSg1jyeS8/N31C2c3T3jacOJYKcl3nZGpfPZgVB0ooFZxQ
         ZKUtEDAIv8oJ0BQ9tx7Z3Dsb0IPFGBcSwPBpk0W7tTQrfrFYOgmRueY6wMlRYk1f77B5
         L1LEQwta/ITK7LqJpJ+0nwzRFOff6DGga+z1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711365676; x=1711970476;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0c+XedPdeNuNXfU5mtLEzBWBIzV1dWjxq7xb3M/FhvM=;
        b=aZG9wzI3l9If+PJkmCJjxIJ8G6GcPs8cTWifaYC0mvtmAyX1Jvp7wgrcI2E2obzb4S
         f+QGw36dIcUDja4d9Dnlzd36eR8wFs4JzyEPrkZIpqYxc00nc/DFSWbdz0a96ANtYHQA
         TbL56jpuDqbhnRvAq9BeBkGqUU1qIqhLdYGBUiBLuC3PlSgv1Axx1rA3h+3Qrqmecwrm
         xh5Zsd5CiDEQ1Hlr7P3FxheofGuslMc+1lQrLrmrqsfjigLYAXqedb0bxgCawi9N7lar
         RrsgfbOKsJPWl3Ay2TimGXdRI6jpw21mYXPzwEx+0WRkGCXBqlAzcHgyRvAfNU2mji0E
         t3bA==
X-Forwarded-Encrypted: i=1; AJvYcCXxmLqMXG9tRaI3a7WV26MUUT4vOBbvZXjchAAxGNPy5ZUUP6/WVSZCNWA5K7SCQZIvD4KV6ag3xLdm6j/k+ymxGXlMFZ3SYrNCskyfdQ==
X-Gm-Message-State: AOJu0YxZwWZIZWnmfIxRiyEfkEQ6V/PrpI53gerIraVjRAxG+ywPqV6B
	2Kjqe6aYuYQgTlcc1533K5A7XMhC80neTSTRE0FABjOBaDrvweB3vgbSnJWJ0cPpHhFMCkLjh+a
	zznFmYPjNWLUk7Xc+8ScKZaMFLcgzzsPFNisimA==
X-Google-Smtp-Source: AGHT+IEHgtn80L49Skt3CEF+hTXCA3FdVG+hC9lS8i92+yyLZZ9XMCkOBIMmlhGWRtndIytDvEiwFaWaIbgkiRj6zl8=
X-Received: by 2002:a17:906:b109:b0:a46:d978:bf02 with SMTP id
 u9-20020a170906b10900b00a46d978bf02mr3970124ejy.34.1711365675733; Mon, 25 Mar
 2024 04:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABOYnLyevJeravW=QrH0JUPYEcDN160aZFb7kwndm-J2rmz0HQ@mail.gmail.com>
 <CAJfpegu8qTARQBftZSaiif0E6dbRcbBvZvW7dQf8sf_ymoogCA@mail.gmail.com>
 <c58a8dc8-5346-4247-9a0a-8b1be286e779@redhat.com> <CAJfpegt3UCsMmxd0taOY11Uaw5U=eS1fE5dn0wZX3HF0oy8-oQ@mail.gmail.com>
 <620f68b0-4fe0-4e3e-856a-dedb4bcdf3a7@redhat.com> <CAJfpegub5Ny9kyX+dDbRwx7kd6ZdxtOeQ9RTK8n=LGGSzA9iOQ@mail.gmail.com>
 <463612f2-5590-4fb3-8273-0d64c3fd3684@redhat.com> <a6632384-c186-4640-8b48-f40d6c4f7d1d@redhat.com>
 <dd3e28b3-647c-4657-9c3f-9778bb046799@redhat.com> <b40eb0b7-7362-4d19-95b3-e06435e6e09c@redhat.com>
In-Reply-To: <b40eb0b7-7362-4d19-95b3-e06435e6e09c@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 25 Mar 2024 12:21:04 +0100
Message-ID: <CAJfpegtssacBQuV0J2cEFYOJQvg-p10thsMEq2W87SEonqLnkg@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in fuse_copy_do
To: David Hildenbrand <david@redhat.com>
Cc: xingwei lee <xrivendell7@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, samsun1006219@gmail.com, 
	syzkaller-bugs@googlegroups.com, linux-mm <linux-mm@kvack.org>, 
	Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Mar 2024 at 22:56, David Hildenbrand <david@redhat.com> wrote:

>  From 85558a46d9f249f26bd77dd3b18d14f248464845 Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Fri, 22 Mar 2024 22:45:36 +0100
> Subject: [PATCH] mm/secretmem: fix GUP-fast succeeding on secretmem folios
>
> folio_is_secretmem() states that secretmem folios cannot be LRU folios:
> so we may only exit early if we find an LRU folio. Yet, we exit early if
> we find a folio that is not a secretmem folio.
>
> Consequently, folio_is_secretmem() fails to detect secretmem folios and,
> therefore, we can succeed in grabbing a secretmem folio during GUP-fast,
> crashing the kernel when we later try reading/writing to the folio, because
> the folio has been unmapped from the directmap.
>
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Reported-by: yue sun <samsun1006219@gmail.com>
> Debugged-by: Miklos Szeredi <miklos@szeredi.hu>
> Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Verified that it's no longer crashing with the reproducers.

Tested-by: Miklos Szeredi <mszeredi@redhat.com>

