Return-Path: <linux-fsdevel+bounces-11257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AEC8522F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 01:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378331C233EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 00:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0308816;
	Tue, 13 Feb 2024 00:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ot+1a5Ht"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F71979D9
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 00:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783009; cv=none; b=l6g2uuau3oOLNxKIlMGLnF+X88UuuaLBkOzRFb1CaPlpggal8eGdaFUc+dSerhBVDzAxBsVmaEgDxPBgv1BcPNaer/V3TKGBAvAfRxKbfw7xYPkkfQjyjm47GU4MqYIyDB0cSsCMwEakU/gfakWewLRZHYIbwm0GxsSWVqQAmp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783009; c=relaxed/simple;
	bh=Cn8xM3W1fFtR/5/yiI3lbiK+cKlzcW0/663LC3bcJ3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYXDJ6VEJ/kWSMnPJA9oYkZqKTog8QSfTvTs17DsewlSGsDTihDqOZ5Zp72GCR1vj/Q/zfu5ziB8gdko+2nPovOejb5j/fkAVDjgY9rZNGT3KHFhJ88DQERvxlMVSGR6iV6DXUwrhOZi3NpRmIiK7km6VvDZvaEaAgf3cs+RWOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ot+1a5Ht; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso2581226b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 16:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707783006; x=1708387806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CVCj3/bUzmp/ihK8I5QTojP8ThiaEloYRG+XcmjM3wg=;
        b=Ot+1a5Ht2YLq8o93C5ZvNMpcmu+vM5a8jx35ZLNBWEuvjqlexX5dxLpI6XUDk38aaz
         ycjT1OFWIpKNryOJ9INI1sQACy5QWehca2yoT8Pj5lBGq40SsB9piPEKA8jv+rHYDkm1
         Sf+NDZide1OE5+bxwG/F4R2CUe0ko5rKcn3OI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707783006; x=1708387806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVCj3/bUzmp/ihK8I5QTojP8ThiaEloYRG+XcmjM3wg=;
        b=Ze+g0p61LGzMUY9lBSIyd8r3l6YQau6sQOWm408UAhUFiKJuIRbPAkt3IIkRfo4G9Q
         96RJZEWudb7FIV6riY1twiX4rdGWrJGZ0z6EzjDG1ZfWIs+vlxbfIr+UJ2iZirdkfP26
         xayeW6UQV3SszY5GRItthHZS9gEMBXajcKrTgP8lwy8OUBwiEY7V8S2WO9dGWSgV9EHt
         aiqsZaUf18RD+iy9qdbcc+sI0S9zXZ1CIHqX53Hj6PAqzLES+7q4yn713exdk3efyjiT
         T9hJ5uhAfAiiKLXiuMDXJOgffYcoyGfR0VxXCiIAw+MU/LhkATy4Pq+g1LOJdxXo8P+y
         etLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOsxfE5E5+QoPLuMuTQXnWREBOkwJj/549ZoMCFOFfcBIyGt1kaP1sIf6Ploy9tnY2Z7Ih9zNYkZmQW5Prc4Jjus4yHeNgIlyGkxNBvg==
X-Gm-Message-State: AOJu0YxGoHV5agopyn9a/eQua5sm0BL+VBf5h1o+k0lqY6/dkVHlws3M
	Altl9sf7jzzmI1SCJdNVqN+j7FoCCrwWJt6s+6GMBBGsrewvwxrD9zGQEHzv8g==
X-Google-Smtp-Source: AGHT+IFAb5Y0OjFtRBdBi76LWWap6GYJ2vlFyUiWl2KnT6Jl5dQ3zxzCTPwpD04g4Ayonld7YB9n4A==
X-Received: by 2002:a05:6a20:9585:b0:19e:5fd5:5244 with SMTP id iu5-20020a056a20958500b0019e5fd55244mr1519903pzb.1.1707783006571;
        Mon, 12 Feb 2024 16:10:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXMk5K03F8OvcNP58pCH03c9Xh1q0R3zKG3V6LgreI39ZPp4ENmjuqg9HNOYn2JOhd5i3Dcos9pSuv7mqGH/NV7ZQC6zfETPnz24P3OIOdf/mv6CZgZwY2vYx6EGoiOg2xNJqsbxCHxzRFjiHhrzG/af2rpU2TkVUGVR/tfH57shjxuZFYYCssRTnw/WVDWIzcG9HRqx2oKw1uxIboRc88vlS8FWVbQ3ettKC9j3B8pWVHCT0GOShBVDA8wFQBHmI2e72ZEfLgSrYDoR33l79Kqa0TgiEGqCJYryx4jY7flqGZhOcKbalSLGFs388r+b6v3UcCDPb27pxwP3wBLF+9f5ryy9Qha3cIwlJsboN3MKsbL+mCkb6o5D3+Twe32ozBmQmyoHciMxfwddOjMklF69k5e2wE1tkvkfCeyOXKbED6IaKsd9wY50STBrOsjUT4FjQMhyoPllLfKte7AlgAJqCat+Ey39f7WNHINAStlBqz3CzMiG7HpGoOGFxfhydwk24UUP7aNFQiSPJMnEsgO81x3zQgRT/VQMGSDJpdo1Wmn6CujFLxlh7BgH4MBg7Rl41r4vho5XKHN/yODpxiE07lO6Ns1MgG0Qxxl78Y7wNnjav4kBKco6I/9QWaE+aKs5eRwUZu6MVIyYf9WGJVJouxQdkCiiYxXbc9ppFiLPa1VjNMEkXTbiAHLtC+P7UgZHt9NlwAKBf0U+iMViuzenKLyBs3u481L6eE5M+jOB0BF9KX4TA==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n5-20020a632705000000b005dc36279d6dsm1048821pgn.73.2024.02.12.16.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 16:10:02 -0800 (PST)
Date: Mon, 12 Feb 2024 16:10:02 -0800
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
Message-ID: <202402121606.687E798B@keescook>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-32-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213922.783301-32-surenb@google.com>

On Mon, Feb 12, 2024 at 01:39:17PM -0800, Suren Baghdasaryan wrote:
> Include allocations in show_mem reports.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/alloc_tag.h |  2 ++
>  lib/alloc_tag.c           | 38 ++++++++++++++++++++++++++++++++++++++
>  mm/show_mem.c             | 15 +++++++++++++++
>  3 files changed, 55 insertions(+)
> 
> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> index 3fe51e67e231..0a5973c4ad77 100644
> --- a/include/linux/alloc_tag.h
> +++ b/include/linux/alloc_tag.h
> @@ -30,6 +30,8 @@ struct alloc_tag {
>  
>  #ifdef CONFIG_MEM_ALLOC_PROFILING
>  
> +void alloc_tags_show_mem_report(struct seq_buf *s);
> +
>  static inline struct alloc_tag *ct_to_alloc_tag(struct codetag *ct)
>  {
>  	return container_of(ct, struct alloc_tag, ct);
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 2d5226d9262d..54312c213860 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -96,6 +96,44 @@ static const struct seq_operations allocinfo_seq_op = {
>  	.show	= allocinfo_show,
>  };
>  
> +void alloc_tags_show_mem_report(struct seq_buf *s)
> +{
> +	struct codetag_iterator iter;
> +	struct codetag *ct;
> +	struct {
> +		struct codetag		*tag;
> +		size_t			bytes;
> +	} tags[10], n;
> +	unsigned int i, nr = 0;
> +
> +	codetag_lock_module_list(alloc_tag_cttype, true);
> +	iter = codetag_get_ct_iter(alloc_tag_cttype);
> +	while ((ct = codetag_next_ct(&iter))) {
> +		struct alloc_tag_counters counter = alloc_tag_read(ct_to_alloc_tag(ct));
> +
> +		n.tag	= ct;
> +		n.bytes = counter.bytes;
> +
> +		for (i = 0; i < nr; i++)
> +			if (n.bytes > tags[i].bytes)
> +				break;
> +
> +		if (i < ARRAY_SIZE(tags)) {
> +			nr -= nr == ARRAY_SIZE(tags);
> +			memmove(&tags[i + 1],
> +				&tags[i],
> +				sizeof(tags[0]) * (nr - i));
> +			nr++;
> +			tags[i] = n;
> +		}
> +	}
> +
> +	for (i = 0; i < nr; i++)
> +		alloc_tag_to_text(s, tags[i].tag);
> +
> +	codetag_lock_module_list(alloc_tag_cttype, false);
> +}
> +
>  static void __init procfs_init(void)
>  {
>  	proc_create_seq("allocinfo", 0444, NULL, &allocinfo_seq_op);
> diff --git a/mm/show_mem.c b/mm/show_mem.c
> index 8dcfafbd283c..d514c15ca076 100644
> --- a/mm/show_mem.c
> +++ b/mm/show_mem.c
> @@ -12,6 +12,7 @@
>  #include <linux/hugetlb.h>
>  #include <linux/mm.h>
>  #include <linux/mmzone.h>
> +#include <linux/seq_buf.h>
>  #include <linux/swap.h>
>  #include <linux/vmstat.h>
>  
> @@ -423,4 +424,18 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
>  #ifdef CONFIG_MEMORY_FAILURE
>  	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
>  #endif
> +#ifdef CONFIG_MEM_ALLOC_PROFILING
> +	{
> +		struct seq_buf s;
> +		char *buf = kmalloc(4096, GFP_ATOMIC);

Why 4096? Maybe use PAGE_SIZE instead?

> +
> +		if (buf) {
> +			printk("Memory allocations:\n");

This needs a printk prefix, or better yet, just use pr_info() or similar.

> +			seq_buf_init(&s, buf, 4096);
> +			alloc_tags_show_mem_report(&s);
> +			printk("%s", buf);

Once a seq_buf "consumes" a char *, please don't use any directly any
more. This should be:

			pr_info("%s", seq_buf_str(s));

Otherwise %NUL termination isn't certain. Very likely, given the use
case here, but let's use good hygiene. :)

> +			kfree(buf);
> +		}
> +	}
> +#endif
>  }
> -- 
> 2.43.0.687.g38aa6559b0-goog
> 

-- 
Kees Cook

