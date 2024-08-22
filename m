Return-Path: <linux-fsdevel+bounces-26844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBB295C0E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 00:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8B7284CDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 22:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A831D175F;
	Thu, 22 Aug 2024 22:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoM3trAo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737DC17BB2F;
	Thu, 22 Aug 2024 22:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724365841; cv=none; b=Pq4xGKo3MnKNU2kaKUvqqNxReGZR1mkkUT8yA7ONOMij2n+zoFZ2BNpU+bjm7lLNbD5clCF3C7sKoarIaNBXdBXgH1P2eSkJJRxiysvEUIo53e6t0jGdmbAotnq3o05koIVMPGQ9OKS6YfiKLYStpfCJeUQnYsWFjQ66Cy/DPGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724365841; c=relaxed/simple;
	bh=voE7vxUsM0OpqVUKfHZIux8Z8WtA3khGAbxLj/LCQGY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qmi/XL6R97+0EKthSatN3Sk3yiWb4kOvkFb7v32ZuR0jYpzcV31iQTYoXtIkRkv3OWWOKhOiw7KqlJHGfcWsIBwQTX8fZtsnSBQPkS496IH+4OK6pkUqMcsWTGsjVcWz09aRkcM2SbdwNC1KOmVg9zCMUt12Af+kEEGipQTSN2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoM3trAo; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cd5d6b2581so1008830a91.2;
        Thu, 22 Aug 2024 15:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724365840; x=1724970640; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sW/t0sobKJ6gt+Jt+LqL+vSC0cTiKO3beFAue2WjAE8=;
        b=CoM3trAoJvrjlUME/WppOau3rGKEDNcX3v8lV1AZB/wmPiKoPNJkMxbqEhFRvWkd/f
         1fpOyJ+ZlriWV1WQ3CFveRtVuR3UV4kPEBEg6hfQG7STutH39vOHF3QxNa/g2ekWnwJu
         Z7QQ5f9r/CVTG/SG9AtYm4HuU482GaaO7AsAdqHSEBBPPXE/6XTKVdIIks2vax48uViZ
         z8+1Q71AQ5Jb9bWjWmmH3aLLqVP574mONVQHrCPAPa1Rb33CPJINV9jIGP+5UnNOHTfu
         7l3Do9S9/V+gBNb1PyqAqJcGF7cYYhclnJ1wJcCmydF48igY6lA6HZIc37dpEcoK2Ojl
         +cYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724365840; x=1724970640;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sW/t0sobKJ6gt+Jt+LqL+vSC0cTiKO3beFAue2WjAE8=;
        b=mVq1gMYCFiX0OW2yzwCfv9Ud2kJmCUVw20Uw9UyM+o46hnAs7J6+LAk3WnhhXZQzbk
         uoPhcOhnhPGQs8YmhpmiOph2a+E4M8d1mC5Je7fT8XNP1WjqzGTZmSs1QtPy6DqNSjAU
         htslqcb4YF8ibIDa+VVbf0ROb99zq3zSFi5RgUqjcTcXUQpdBZm7ENwtrnGgvD7UO+dX
         w8ocFAGwALYerqFemVo6T3ppDPcU9N6Rf9uZ31NGsoI8SYVUC29HWmJesIQDcmmr9Zu3
         bDcti05HF7xjJBMkFrlqDPcfgXV7MB948zIKy42PQbw42A5/6ixBrpiN2QJS9gBW8wqs
         W15Q==
X-Forwarded-Encrypted: i=1; AJvYcCUycKwpJFIm31BucyyP8lDjjd6yOt4rIdqeQCvkNDCXDTTx8bXhphWmWjNh8DIfior2yJ8=@vger.kernel.org, AJvYcCXU6zgiVIvbcE2i58G8pAlMZcbwh898AmEUk0xK0Zk9UwPN1yYIghDOPxdBd5HXrQ1nJ3FPXKXyZtjUWKGSUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGFhKzGN86picF3kSvCl31ZqdPAatISjPClI6N8gVIwO6BV8IB
	BUEVC0lDV2pB4+QFYjBLuKUeFM8mirDq7KwKeuQpl/7C4BujmqkBUeRWpopODls=
X-Google-Smtp-Source: AGHT+IE9KnJ32ikDQZSBjuoml9SWjYbQjceBHdqibR5PrCqPiZtwxBCF0B6ev+f9bqHmk6Ze9wfuuQ==
X-Received: by 2002:a17:90a:3484:b0:2d3:cd5c:15bb with SMTP id 98e67ed59e1d1-2d646c04128mr166380a91.25.1724365839691;
        Thu, 22 Aug 2024 15:30:39 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5ebbb17d9sm4735863a91.43.2024.08.22.15.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 15:30:39 -0700 (PDT)
Message-ID: <e973f93d1dc2ebf54de285a7d83833ea6c47f2a2.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 10/10] selftests/bpf: add build ID tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, adobriyan@gmail.com, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, ak@linux.intel.com, 
	osandov@osandov.com, song@kernel.org, jannh@google.com, 
	linux-fsdevel@vger.kernel.org, willy@infradead.org
Date: Thu, 22 Aug 2024 15:30:34 -0700
In-Reply-To: <20240814185417.1171430-11-andrii@kernel.org>
References: <20240814185417.1171430-1-andrii@kernel.org>
	 <20240814185417.1171430-11-andrii@kernel.org>
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
> Add a new set of tests validating behavior of capturing stack traces
> with build ID. We extend uprobe_multi target binary with ability to
> trigger uprobe (so that we can capture stack traces from it), but also
> we allow to force build ID data to be either resident or non-resident in
> memory (see also a comment about quirks of MADV_PAGEOUT).
>=20
> That way we can validate that in non-sleepable context we won't get
> build ID (as expected), but with sleepable uprobes we will get that
> build ID regardless of it being physically present in memory.
>=20
> Also, we add a small add-on linker script which reorders
> .note.gnu.build-id section and puts it after (big) .text section,
> putting build ID data outside of the very first page of ELF file. This
> will test all the relaxations we did in build ID parsing logic in kernel
> thanks to freader abstraction.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/tools/testing/selftests/bpf/uprobe_multi.c b/tools/testing/s=
elftests/bpf/uprobe_multi.c
> index 7ffa563ffeba..c7828b13e5ff 100644
> --- a/tools/testing/selftests/bpf/uprobe_multi.c
> +++ b/tools/testing/selftests/bpf/uprobe_multi.c

[...]

> +int __attribute__((weak)) trigger_uprobe(bool build_id_resident)
> +{
> +	int page_sz =3D sysconf(_SC_PAGESIZE);
> +	void *addr;
> +
> +	/* page-align build ID start */
> +	addr =3D (void *)((uintptr_t)&build_id_start & ~(page_sz - 1));
> +
> +	/* to guarantee MADV_PAGEOUT work reliably, we need to ensure that
> +	 * memory range is mapped into current process, so we unconditionally
> +	 * do MADV_POPULATE_READ, and then MADV_PAGEOUT, if necessary
> +	 */
> +	madvise(addr, page_sz, MADV_POPULATE_READ);

Nit: check error code?

> +	if (!build_id_resident)
> +		madvise(addr, page_sz, MADV_PAGEOUT);
> +
> +	(void)uprobe();
> +
> +	return 0;
> +}
> +

[...]

Silly question, unrelated to the patch-set itself.
When I do ./test_progs -vvv -t build_id/sleepable five stack frames
are printed:

FRAME #00: BUILD ID =3D 46d2568fe293274105f9dad0cc73de54a176f368 OFFSET =3D=
 2c4156
FRAME #01: BUILD ID =3D 46d2568fe293274105f9dad0cc73de54a176f368 OFFSET =3D=
 393aef
FRAME #02: BUILD ID =3D 8f53abaad945a669f2bdcd25f471d80e077568ef OFFSET =3D=
 2a088
FRAME #03: BUILD ID =3D 8f53abaad945a669f2bdcd25f471d80e077568ef OFFSET =3D=
 2a14b
FRAME #04: BUILD ID =3D 46d2568fe293274105f9dad0cc73de54a176f368 OFFSET =3D=
 2c4095

The ...6f368 is build-id of the uprobe_multi.
How do I check where ...568ef comes from?
Also, why are there 5 frames when nesting level for uprobe() is 3?


