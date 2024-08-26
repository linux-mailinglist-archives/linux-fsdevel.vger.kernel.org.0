Return-Path: <linux-fsdevel+bounces-27250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB1395FBB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 23:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B43B28416F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 21:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52AA19ADA3;
	Mon, 26 Aug 2024 21:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4FpQrjS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB4A3B782;
	Mon, 26 Aug 2024 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707871; cv=none; b=OX2DSSrCGmJ9/i3ZUz3MKR1p/uwc48e7xsvP4PP3EGGOy4Z9IufV7016wUh7PnZuEFOc1HOpAtscflehmougKCqpPabLhGIj3G+XIKfPSS8GLsJhe1yjNvPsYkMMW8GDumGaE9AcQ8/aVUZ2bA8h4pJc6TWIwm+GphAlzuy92fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707871; c=relaxed/simple;
	bh=CGslcxW/Fc3OgcwxasYLSjhCWDJFxMfqqYZBLG8QQnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EElJarWcE7Bfjj/iK3t056igILt0NHFY8WnoAXLDF0l8YfsZb/+vL3FWoTQ2mHJtImRrQr0HjynjjueCH7rPjGSCzES6r3CNBuuO0o5CxNfHBZX/Rv0iRUd8AjOmylNGeosp+R9pux/ha96x4gUwFFMN6YucJu2m9I+euWXZf1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4FpQrjS; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d3d0b06a2dso3969271a91.0;
        Mon, 26 Aug 2024 14:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724707869; x=1725312669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCVK2T5mefzelGSfsT4oRGKRuwqXKKQitg7slLE3ECY=;
        b=P4FpQrjSwGPIEpdOcpsMb6JBg7UhSZ5GHVrOuM8SHapnuXlHYoroJNd5pzOUD0XdZS
         Brg6Ohgbq6qn2oZsyummS7U682LYfytEWC7d19v+KnUp7AqZAyVFgHm//LdqnY7z1RWe
         FttsTNHSkWEI6oh8gXaVy2PQOkPno6+Ogvl/WCpttEfkUC47hVIvrMeigPmkzC7Om0rq
         jInq6WHqTTVBT7ILj3LvmQ3jQMXNnBfONCo1+nGyEtmz05KHmCr4XcXe3+ynUnSKSq5M
         tkp+Sm48xF6Per7++1ceQAf/baEtbj/Y1WPU9vF+TT3zl7xy5bilI3+UG8bWzbn2BAER
         FsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724707869; x=1725312669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCVK2T5mefzelGSfsT4oRGKRuwqXKKQitg7slLE3ECY=;
        b=rDHwhc048VpVf84d0unTo8AP8RCbspglLc4Wm74aM4iZ3gmZS2uWDFWEzmAyqun1vw
         WrQJacO26+708NYKZIiW//XQMVjB1FPAM2CjjLF3FhWvWBxAGVFCQ0U19Qa1SiDv/uQc
         Ftepklw9oM2gYWUC2fsoMajugMRJTlvgdXVDBDzI33QqA7je4Me8Ux5Rfa01X5DFpqln
         mwYLM9eW+PL+6j4//CFoT2KQM2RNWpBhMSeQmywoooivS68Mnch4rSqAhrmrntRCZw54
         v3fKg8c5tzEsiQFrWK9ZR00MMjGgfZjKzx1I2p+bkm41/yygWUPJ1JB7JkiBNM3jVdkG
         Yddw==
X-Forwarded-Encrypted: i=1; AJvYcCVFxbz6ouPE8oFmezKCFT7QEIr4ZQ84elRV9YyC0dW9h3Dp7XpZ0ILbPqnVSBNDZgrxZZCY9l6y8omIWVGsnA==@vger.kernel.org, AJvYcCXodnOl+1reUWus4NhZAeHU917LOy4WXm5FQfpg4c9o5TXtjdypzZiqV5ORIgWqlJokCQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgSj6VT90IDNJ12DNq6eWWcn9ZtmssjeiEY6FEXdPV20VeAU8I
	J8dXRsQdVgO7EtkVFXwaxeT513EcnF0ZvpBn3tr42WS+XRD06nOrQAlrmjC2XYZ5U2NOK8c7Z7h
	1a7nYx89mBK2AGAgUtExo6KvPgCzWBNND
X-Google-Smtp-Source: AGHT+IHWkDyq5UYH7otLklPuUe/TxIXiUqPZd8sTtaVZCuXfdY7+gvyPYpsarlOWcGqvrmP6yfkD+kFudB8aq4Qqk5s=
X-Received: by 2002:a17:90a:d14f:b0:2d3:d7f4:8ace with SMTP id
 98e67ed59e1d1-2d646b946a7mr13646689a91.8.1724707869290; Mon, 26 Aug 2024
 14:31:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814185417.1171430-1-andrii@kernel.org> <d9a46f4d54df8d5ac57011222ebdf21b0f15f52d.camel@gmail.com>
In-Reply-To: <d9a46f4d54df8d5ac57011222ebdf21b0f15f52d.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 26 Aug 2024 14:30:57 -0700
Message-ID: <CAEf4BzZe-dWzqxpnYs7YOfnQ3--CqDEYDOn1LRZzDBTP1hq1yg@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 00/10] Harden and extend ELF build ID parsing logic
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	jannh@google.com, linux-fsdevel@vger.kernel.org, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 4:23=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2024-08-14 at 11:54 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > Andrii Nakryiko (10):
> >   lib/buildid: harden build ID parsing logic
> >   lib/buildid: add single folio-based file reader abstraction
> >   lib/buildid: take into account e_phoff when fetching program headers
> >   lib/buildid: remove single-page limit for PHDR search
> >   lib/buildid: rename build_id_parse() into build_id_parse_nofault()
> >   lib/buildid: implement sleepable build_id_parse() API
> >   lib/buildid: don't limit .note.gnu.build-id to the first page in ELF
>
> Never worked with lib/buildid before, so not sure how valuable my input i=
s.
> Anyways:
> - I compared the resulting parser with ELF specification and available
>   documentation for buildid, all seems correct.
>   (with a small caveat that ELF defines Elf{32,64}_Ehdr->e_ehsize field
>    to encode actual size of the elf header, and e_phentsize
>    to encode actual size of the program header.
>    Parser uses sizeof(Elf{32,64}_{Ehdr,Phdr}) instead,
>    and this is how it was before, so probably does not matter).
>
> - The `freader` abstraction nicely hides away difference between
>   sleepable and non-sleepable contexts.
>   (with a caveat, that freader_get_folio() uses read_cache_folio()
>    which is documented as expecting mapping->invalidate_lock to be held.
>    I assume that this is true for vma's passed to build_id_parse(), right=
?)

No, I don't think it's automatically true. So good catch, I think I'll
need to add filemap_invalidate_lock_shared() +
filemap_invalidate_unlock_shared() around read_cache_folio().

I'll give Matthew and Andrew a chance to reply to Alexei, and will
post a new revision tomorrow. Thanks for a thorough review!

>
> For what it's worth, full patch-set looks good to me.
>
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>

