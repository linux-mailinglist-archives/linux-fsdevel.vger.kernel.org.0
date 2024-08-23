Return-Path: <linux-fsdevel+bounces-27004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2328F95D98F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 01:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47D5282DD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 23:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE071C8FD5;
	Fri, 23 Aug 2024 23:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1on0jeT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97227181B83;
	Fri, 23 Aug 2024 23:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724455383; cv=none; b=IDJdg7e5t11OGa/an1RjwKEHH8P82B/FTpE3MTObstnqC8mgRp/s7ftG7Ae93mOs4M2UvG+ZczZt2+OTn4OrdEpDIxznVbsAdUk6EwiedKyFO/rPmf7GznrWDLL2opwmu5CmrTVVyjqqmVBpifFblUQ3Yuah1GEymgcUPpY9cLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724455383; c=relaxed/simple;
	bh=gVE3Tz5d69/fbL2reCmsdaJOTK2gYrPl8YKsLMC2kqE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bQ6cnOmsy1G/ZOULPvjCb0drUJWIZWOU7HZpnKmHqAXXR8eSI37+VGjo9j5i1ZiCFNuSX0ZLqBuaenW1w62fsk1W+zLB29hZYRuUc86acbJ+sSjUopfVUmCPXmTjVkuAwVDMkbRr6c35rHDVg3aPQEJd0Rtmam9NRmzMDn9Z4PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1on0jeT; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7093f3a1af9so2010051a34.1;
        Fri, 23 Aug 2024 16:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724455380; x=1725060180; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=75Q5HaMSUdu3EU9FymdbNmNLbW48t84b3pHVRNCcZTo=;
        b=V1on0jeT3kHg27BzUY1VWL0ByQT6GYcjORaaYrTCFsnA1qyA70gD/aNTdzO19ODt6N
         U48bDgYXMkzozDGtvVOIcxaRA99P9Dpa32dyxp0GSxwpDuS+n89upU1JpsAYkoZ0YST7
         qkoCm793Brp65brGS5fEghBUXffdiBUB9vsIhH3z387yVlh7g+NfWAMGN87OBJXZ2zy8
         2/6nyXjVEJiV2NQhKLoD7+FLFgA6eBH7piilugocLF/oxi3PRmnQaigzgmeq6+CLCbX8
         rNY5j124B4ctmZI43NIx+r2Q1mkFqXP9Kn6d0Z3mVEZPZmNa1PMBZl6mVazUK2Mm5K3C
         CYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724455380; x=1725060180;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=75Q5HaMSUdu3EU9FymdbNmNLbW48t84b3pHVRNCcZTo=;
        b=dfXTi6ai1gUanHXgVcJzNVgx+sgglZVAAOazYamPtNCyN5uJ3KwE2aHzLVY18FrwJ/
         ukod1clVJx3UkMiUCW6gus++MRwLrYMWxTYOL2c93HpPCc/kFTaDkeYK6mcwY6qKNxzu
         mN7mgT/90I1I2Uj/YDLLh/e5hYebzleugC+IoS9Dtz8Tnbs4wBlXN3Ep8hE1h0iBTX9+
         7BS3n3BiQnlu/3YUCYZyiFHFyAZHIiH0FzNRkSBm/UY9LKJhDbZ+AxyneZbfzkEfOPE/
         U+BCqhhucDxGKzwRpKldfGJZFyhT0IBsVtPUnftMfqE3zdlU95fhmM24zG3TGl4nTRdV
         BOPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7Gj44nMPYM8Bl7QMTg79KFIYHH1xYVQZDS9L2ePVvyLpy9p6eRRTAhNLdaFJTwuBWEnu+zJKUtCKFc3PVkg==@vger.kernel.org, AJvYcCWhECgrNxA8mvB/gGyZIEgTbUC2rc9N67nC5GQWe2UC21j3OdG9iaIm/1i1aQe9a7mwYi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqYQVzdxm5J5ytnXNFFttM7HLmoScZzWWTgqaOuWGjNLvYpq/l
	nUDXEqKnC/OPL0bSDjJJKO42fOQkD/QqNrdk0tjSvum6GDFbV4oQ
X-Google-Smtp-Source: AGHT+IGPgZFKvORR0uemPN8WjoadxIopouB2ZymsG1SF5XaMJBA5QA5yWMo7iA+IQ6NsduWa0olgAw==
X-Received: by 2002:a05:6830:6004:b0:70a:9876:b76b with SMTP id 46e09a7af769-70e0ead89c3mr4800606a34.2.1724455380606;
        Fri, 23 Aug 2024 16:23:00 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9abfd5b1sm3722097a12.0.2024.08.23.16.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 16:23:00 -0700 (PDT)
Message-ID: <d9a46f4d54df8d5ac57011222ebdf21b0f15f52d.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 00/10] Harden and extend ELF build ID
 parsing logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, adobriyan@gmail.com, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, ak@linux.intel.com, 
	osandov@osandov.com, song@kernel.org, jannh@google.com, 
	linux-fsdevel@vger.kernel.org, willy@infradead.org
Date: Fri, 23 Aug 2024 16:22:55 -0700
In-Reply-To: <20240814185417.1171430-1-andrii@kernel.org>
References: <20240814185417.1171430-1-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-14 at 11:54 -0700, Andrii Nakryiko wrote:

[...]

> Andrii Nakryiko (10):
>   lib/buildid: harden build ID parsing logic
>   lib/buildid: add single folio-based file reader abstraction
>   lib/buildid: take into account e_phoff when fetching program headers
>   lib/buildid: remove single-page limit for PHDR search
>   lib/buildid: rename build_id_parse() into build_id_parse_nofault()
>   lib/buildid: implement sleepable build_id_parse() API
>   lib/buildid: don't limit .note.gnu.build-id to the first page in ELF

Never worked with lib/buildid before, so not sure how valuable my input is.
Anyways:
- I compared the resulting parser with ELF specification and available
  documentation for buildid, all seems correct.
  (with a small caveat that ELF defines Elf{32,64}_Ehdr->e_ehsize field
   to encode actual size of the elf header, and e_phentsize
   to encode actual size of the program header.
   Parser uses sizeof(Elf{32,64}_{Ehdr,Phdr}) instead,
   and this is how it was before, so probably does not matter).

- The `freader` abstraction nicely hides away difference between
  sleepable and non-sleepable contexts.
  (with a caveat, that freader_get_folio() uses read_cache_folio()
   which is documented as expecting mapping->invalidate_lock to be held.
   I assume that this is true for vma's passed to build_id_parse(), right?)

For what it's worth, full patch-set looks good to me.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


