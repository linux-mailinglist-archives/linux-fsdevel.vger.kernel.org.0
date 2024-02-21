Return-Path: <linux-fsdevel+bounces-12392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B2685EC7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 00:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A441F23A4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 23:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC85128835;
	Wed, 21 Feb 2024 23:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YaN0kVu6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AED81ABA
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556736; cv=none; b=RpAC2D+TZpz+qgriCsbOiyinpN5WSy81PDBwO99yTNAPaLPr/RTuyZFpAGx2v5Nh4Pnn8xfwagBeLDiC8WbnvY65krFpt+fcsgdw7hHzBlMqsm3YBnWM80WV2RoLHszNKNe/fCUZxyd1dbXuzSoGnxIoumWskamYCXlhBuKKtQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556736; c=relaxed/simple;
	bh=zssxqx37knagHcWIMKikX95cYC9xskvO7oxvfidP8XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqiHcwCExBcc4806C3oscm3wHo1MlUlmUW/sZDVv4YSd6167ilkykBmO9Ad4umMk/Po/oB/lmVyCNOHq0nf16y/dmFfYlEgCCjEJahQ9zAhAYZYBJiX2iuopGDGT1SsBqKCRHf+IFs1ekcpZ7F3unnW7r4k/qh4oGYGZjTyfE3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YaN0kVu6; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc49b00bdbso1423125ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 15:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708556733; x=1709161533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IaQv6IYiHqQsQRwxagN42nrCoy2L36X/io0NIlSKpEE=;
        b=YaN0kVu68tjoY2VWfrn+E6uvbAVTphdtX2sn1L28iRKphMDLBI9svC4bsq2VmT/eR8
         rwRvkCCtNjWgHofEkG8E7Fa9EScJZEtSHQyWJ/LpBDz2lqo6oxVVa3zIO1ynxdFuk3sE
         2H4E1XYMIw5Mwkk//ZqWOw1PorI89LsVlxO/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708556733; x=1709161533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaQv6IYiHqQsQRwxagN42nrCoy2L36X/io0NIlSKpEE=;
        b=DjjFVGpoZ/UXfZG5g/aMsPkNA2YE051DR2DeGBZoQXnmmrIYurURimhSzuyAeoj+D4
         sXnP/Yty/Jn6nWoqdaiBS08hid3rTzCNljshZoQ2nPDoZhFabd+Aqg7UkJhOav4Nmkhl
         U522xPby+x7PYY/JYzr7H9Tm+Y13iqft4q4DRD56WmTSNTa9eQTMJSkJfruiFag1muK3
         eSJMMWqBd8EbqUHJoGolvpEq5tcFoexeuE/zBuJc2300/8LKtNTYPM39QjgcY/KeByO0
         COuCdfRpK9Sde73iNYJiTTDz5mJ6OPd0In12CJYyJdvstVcxG1jIfwco23bgNTLErE0u
         Az9A==
X-Forwarded-Encrypted: i=1; AJvYcCXtIS0zogFYElM2h6xvdCXUtthp5TISuvskhb2HOFwI3GHMYiVefb+SUxU1IIxljmyC9cOM+4aj0J3eSCjQmS0OppqvxzCExGQq/hBhXQ==
X-Gm-Message-State: AOJu0Yyfm+lc4ZfHd47sHBgn9Eb2mE83vNN2dDuq4M9/J6BuUYEuPWzQ
	AbJTlLau7pTGDFJHxFsWE049HdrNx7JB/BfifKCDW8UvKfAs3P/wFyszP78fUg==
X-Google-Smtp-Source: AGHT+IH1309ck0C/2D22VOAASZNUEEf4x9Q57P9Qvk9iAKdRznvrywgHAh+2sanfhM2Axko6bAh9XQ==
X-Received: by 2002:a17:902:c086:b0:1dc:7b6:867a with SMTP id j6-20020a170902c08600b001dc07b6867amr6026373pld.21.1708556733655;
        Wed, 21 Feb 2024 15:05:33 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h18-20020a170902f2d200b001d913992d8csm8631586plc.242.2024.02.21.15.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 15:05:33 -0800 (PST)
Date: Wed, 21 Feb 2024 15:05:32 -0800
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, penguin-kernel@i-love.sakura.ne.jp,
	corbet@lwn.net, void@manifault.com, peterz@infradead.org,
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org,
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
	masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
	tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
	paulmck@kernel.org, pasha.tatashin@soleen.com,
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
	hughd@google.com, andreyknvl@gmail.com, ndesaulniers@google.com,
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com,
	ytcoode@gmail.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
	glider@google.com, elver@google.com, dvyukov@google.com,
	shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
	kernel-team@android.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v4 14/36] lib: add allocation tagging support for memory
 allocation profiling
Message-ID: <202402211449.401382D2AF@keescook>
References: <20240221194052.927623-1-surenb@google.com>
 <20240221194052.927623-15-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221194052.927623-15-surenb@google.com>

On Wed, Feb 21, 2024 at 11:40:27AM -0800, Suren Baghdasaryan wrote:
> [...]
> +struct alloc_tag {
> +	struct codetag			ct;
> +	struct alloc_tag_counters __percpu	*counters;
> +} __aligned(8);
> [...]
> +#define DEFINE_ALLOC_TAG(_alloc_tag)						\
> +	static DEFINE_PER_CPU(struct alloc_tag_counters, _alloc_tag_cntr);	\
> +	static struct alloc_tag _alloc_tag __used __aligned(8)			\
> +	__section("alloc_tags") = {						\
> +		.ct = CODE_TAG_INIT,						\
> +		.counters = &_alloc_tag_cntr };
> [...]
> +static inline struct alloc_tag *alloc_tag_save(struct alloc_tag *tag)
> +{
> +	swap(current->alloc_tag, tag);
> +	return tag;
> +}

Future security hardening improvement idea based on this infrastructure:
it should be possible to implement per-allocation-site kmem caches. For
example, we could create:

struct alloc_details {
	u32 flags;
	union {
		u32 size; /* not valid after __init completes */
		struct kmem_cache *cache;
	};
};

- add struct alloc_details to struct alloc_tag
- move the tags section into .ro_after_init
- extend alloc_hooks() to populate flags and size:
	.flags = __builtin_constant_p(size) ? KMALLOC_ALLOCATE_FIXED
					    : KMALLOC_ALLOCATE_BUCKETS;
	.size = __builtin_constant_p(size) ? size : SIZE_MAX;
- during kernel start or module init, walk the alloc_tag list
  and create either a fixed-size kmem_cache or to allocate a
  full set of kmalloc-buckets, and update the "cache" member.
- adjust kmalloc core routines to use current->alloc_tag->cache instead
  of using the global buckets.

This would get us fully separated allocations, producing better than
type-based levels of granularity, exceeding what we have currently with
CONFIG_RANDOM_KMALLOC_CACHES.

Does this look possible, or am I misunderstanding something in the
infrastructure being created here?

-- 
Kees Cook

