Return-Path: <linux-fsdevel+bounces-69245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E00C75316
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 16:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 9CF6F332C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 15:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2075D2E8E14;
	Thu, 20 Nov 2025 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQeYuG1G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85631376BD4
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653451; cv=none; b=QL3ESbpIFj6UhwmxjmfMrfOVcy3H2qFmN9fqm2NyGf/V8ZZe+vIYh7Dc2VDPOyIjsSNeyH6amh3U1mNQ7pWSqOSVbFk05ghaXwdaDRJkrvLZW3VaZUKjFMZC08IJW8YuQOWYoFseqq6redIebonqg9E2UZw/LMQK5674JR/b6rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653451; c=relaxed/simple;
	bh=5SJdDsNIzpAiSSWDtnGIqvp7M7NjjLQ9tdPcSngvhOM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bRB43yjjYnE+KkxqlQgIjyKIYrP9eLkdZtGoBXJVBO6UwA/DK6/XJF6lzmczsgA1eFNnhGCG4Oz5DQF66FwI/zoP5F2Wa4uGw0bUD/7ouv9e9TYrVuJjwh+W0OiuBBi540g1mpMtlRQXL3zgAsQAiOQOnGhZvnKFIGSeebZ5lsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQeYuG1G; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477a1c28778so12646395e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 07:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763653448; x=1764258248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/ugw1qh5Js/ttrR8EDVGlYrGkAdfYtHHIqpSwNHbFo=;
        b=MQeYuG1GDX9e3y6vgFW0eeN2eqphzE0xb/h3CH8Q5oNQhsSzdC7+x8wt8xmQ3/QbgH
         Wft7rTbPSsJIz0K7fwhm+dZyF+xoo4fjyp1FH9BNU21NGF3fhevaBQzK0VGM/LHGNP8c
         2Nn5JAjIa9ME+zfKmSPPDqWzVwDpto/2go6a4++gXqGnI+L1EUiCjiJAbHQi9nK0d8Zx
         dHpxzHnxCDlw74ZDYPgXXz0rPbWWNHDGmKhY1aA+jzZ2CMy/fBAMUmDhkMXsJmZyH2ut
         rs6jVIZ6HPewK4EaR/wop1l5UC02yU/c7DPaN/Q60awNQVrA7McDU8/rETJ1o+FUtphT
         t1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763653448; x=1764258248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V/ugw1qh5Js/ttrR8EDVGlYrGkAdfYtHHIqpSwNHbFo=;
        b=smxuc4qkLCqOeFaq2rUvfIb+52QQYcExEZrYiM/0fLxFVvFhO28E2VHdjGgkt0vmRf
         OIsl6Cnj2AgskqCeYln+SiSype6cAoqCPtPv20mVh00xXfu8ZBANXg9rCha7rqdKL072
         22tZOX9tMFCSPjl6SWOdn3QVI1SYR0mPBBVjkV2F1Q+LgEHjeYcawPjjni+J9Ptfnebe
         dy/HhjYW2yQplGYcfwtEasDsSzzVb4H6ORJJ2QIyj6bH3KPkkQkWx/o29A6DfJikA6Vs
         4OhWD1yQjwDtxirDCqtOfAHFe9npplYoKcQdFkSn7yJcq0AKwE8Z/NDesixyLY9a2WB7
         nh2A==
X-Forwarded-Encrypted: i=1; AJvYcCU+oQoHxOOHWFDjhYCXqrFH38tY3XHxDdGvTdycaxs6yd0GYAc7BuGBQYd95KFzsaIrJOst3SJkyAObEZPe@vger.kernel.org
X-Gm-Message-State: AOJu0Yx25UeC3rCtD1aZjqW3OGq6a3OO0/hr5NyTTTo+zxxpeSyBwRlD
	Ey/UpesdIkFQR/dYCFd2OuQE4M2dsy+eXttBEj9i8dYfnwv902o4bKIt
X-Gm-Gg: ASbGnctk5x5/pyOgznSyZJPcdESjf/WuH9PEYC3z+MsnfszPkyxAfVuXfdVPt88gNkL
	xOpvvbCD0W3vXoXqyIOxYlXkxeOzx8IbgSZpKwmKd9f0xfVobvk6lvk3Pkvsn7d7oDtaqEP742H
	VYj63tWJLzolY2OoJS/lXdrRZ76uOay74o9rLcfBk22I5J+rXKzvz/Wz82/IMNAdBhpgkb1BssI
	6YktP64QLz8HBM4Ewgohzx2FTKVQ6oEJP03ujsXFpzFkYo7IW7ep8c3rwVlzomTHwOAMRU+O7Ms
	Ivh0Wu2TBXEhhwuLRk3reRdlOphoEp/3AWIAso6WfxEyhAyI5pCL34jmbtn8V/DZEnrqQVhEscm
	eIy+T3FjzqI4KPxNcQGvEzbgQRGzAFftCp4AFG32Nht7bH4U9+qI7oiM9BFwyDtYZk6lJjtfyeK
	rLN9O4FckIKTG8A+cTf3hnAzmKA8bywK2S+aweTTXH9AvbjFo2JyWT
X-Google-Smtp-Source: AGHT+IHZscOyGXLMcLEwSzXG79SY8Qx2G6gT/YROcc1hUDKG1pZJxcFyYdrYEnvMt+Oi8xS02ts8rg==
X-Received: by 2002:a05:600c:450f:b0:475:e067:f23d with SMTP id 5b1f17b1804b1-477b8a98d52mr31212975e9.25.1763653447408;
        Thu, 20 Nov 2025 07:44:07 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fba20esm5977502f8f.37.2025.11.20.07.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 07:44:07 -0800 (PST)
Date: Thu, 20 Nov 2025 15:44:05 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Axel
 Rasmussen <axelrasmussen@google.com>, Christoph Lameter <cl@gentwo.org>,
 Dennis Zhou <dennis@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Mike Rapoport
 <rppt@kernel.org>, Tejun Heo <tj@kernel.org>, Yuanchu Xie
 <yuanchu@google.com>
Subject: Re: [PATCH 39/44] mm: use min() instead of min_t()
Message-ID: <20251120154405.7bcf9a6e@pumpkin>
In-Reply-To: <e06666bf-6d19-4ed7-a870-012dff1fe077@kernel.org>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
	<20251119224140.8616-40-david.laight.linux@gmail.com>
	<0c264126-b7ff-4509-93a6-582d928769ea@lucifer.local>
	<20251120125505.7ec8dfc6@pumpkin>
	<e06666bf-6d19-4ed7-a870-012dff1fe077@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Nov 2025 14:42:24 +0100
"David Hildenbrand (Red Hat)" <david@kernel.org> wrote:

> >>  
> >>>
> >>> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> >>> ---
> >>>   mm/gup.c      | 4 ++--
> >>>   mm/memblock.c | 2 +-
> >>>   mm/memory.c   | 2 +-
> >>>   mm/percpu.c   | 2 +-
> >>>   mm/truncate.c | 3 +--
> >>>   mm/vmscan.c   | 2 +-
> >>>   6 files changed, 7 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/mm/gup.c b/mm/gup.c
> >>> index a8ba5112e4d0..55435b90dcc3 100644
> >>> --- a/mm/gup.c
> >>> +++ b/mm/gup.c
> >>> @@ -237,8 +237,8 @@ static inline struct folio *gup_folio_range_next(struct page *start,
> >>>   	unsigned int nr = 1;
> >>>
> >>>   	if (folio_test_large(folio))
> >>> -		nr = min_t(unsigned int, npages - i,
> >>> -			   folio_nr_pages(folio) - folio_page_idx(folio, next));
> >>> +		nr = min(npages - i,
> >>> +			 folio_nr_pages(folio) - folio_page_idx(folio, next));  
> >>
> >> There's no cases where any of these would discard significant bits. But we
> >> ultimately cast to unisnged int anyway (nr) so not sure this achieves anything.  
> > 
> > The (implicit) cast to unsigned int is irrelevant - that happens after the min().
> > The issue is that 'npages' is 'unsigned long' so can (in theory) be larger than 4G.
> > Ok that would be a 16TB buffer, but someone must have decided that npages might
> > not fit in 32 bits otherwise they wouldn't have used 'unsigned long'.  
> 
> See commit fa17bcd5f65e ("mm: make folio page count functions return 
> unsigned") why that function used to return "long" instead of "unsigned 
> int" and how we changed it to "unsigned long".
> 
> Until that function actually returns something that large might take a 
> while, so no need to worry about that right now.

Except that it gives a false positive on a compile-time test that finds a
few real bugs.

I've been (slowly) fixing 'allmodconfig' and found 'goodies' like:
	min_t(u32, MAX_UINT, expr)
and
	min_t(u8, expr, 255)

Pretty much all the min_t(unsigned xxx) that compile when changed to min()
are safe changes and might fix an obscure bug.
Probably 99% make no difference.

So I'd like to get rid of the ones that make no difference.

	David



