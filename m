Return-Path: <linux-fsdevel+bounces-13116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E6A86B6CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 19:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DFFB1C22D08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 18:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11D522F1E;
	Wed, 28 Feb 2024 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I26LIUlD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4284379B83
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 18:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143656; cv=none; b=YhLyz7cGbE12XiOe+gFPY3VjDWLQko2jvliqu0axcMR2YiI5DQAunLmwBvxPQXfMXuC6uzIICBucHWjZ0daoty0XA9oV0SUI5l+kGKS2svI4HEQjrlYBJy3Fl4U+6wB6ld3XbDkpt4LxHU+YUdcxTj7XuJa1s0apWEaPkpTlGQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143656; c=relaxed/simple;
	bh=rv47TPwMaL5mB4Ug9VuCbJFQC3RVZQfJetV44+QcIfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdbjSob1t8PMT8Ba3keHx+oOJJbKDCqBBnKjmS+cAXbJ0E7SyUp1VnUbxSh3qNzy/B4xQEllWjJBYm35Ufu/xi2jGUMRAbaAzs7Uhce8lIKerKIkl4H81TIzAk4tYmPAOa0V1E6K5lG33dJd3HV51LY/Swzx5ERghYtUq+L4tnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I26LIUlD; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c19bc08f96so3580098b6e.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 10:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709143653; x=1709748453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpJn79d7ymx24Tp5aF1RCceBrMYpEjjJMLmxKg1qMeo=;
        b=I26LIUlDAHkDBLXz3vWL7AcRTiKr8/ll6mVDEuxWMUsDvyKo6Gs+weBuyHxXp1Y+kO
         yJBVXecvpEki+8OZ1GTubMJYou2eewYBq3M9YCaRXSdVKU9PsBJ74cbni8NTEdQRS04f
         GgSqHdZyP/J47iELtUMR6d2HMQrHv5pA/t6NYXqxTZ48WK0xFLz5yuBUW6WuOoaLRbWl
         LvYIGG4G3PkbFnr3WOMUgnlkPgjAHEsG2px5MAU4lj3hIA7A5qa7UrIUlupai3dN2WnK
         5V1n3s54PerdOa5bqlfwqlX/4xYf8mpNVtE/FHMhpXzZetUrgiPSAHIIE3Kpx5k3pT3E
         cXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143653; x=1709748453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TpJn79d7ymx24Tp5aF1RCceBrMYpEjjJMLmxKg1qMeo=;
        b=qdlmh7qSsHGuqiPFr8qIuB5smNFIVcGjThI/oWacLc/ku1F36tVq1tuCeA1FxRdofI
         hOEb3u4Ipt/cZ8PrXddwI0r9TgU2RW7vN6dnVbZkxnYgigGPy1siq06bwVl7dYCx8W2H
         Dqq7R+Vq3Yf+F7VRkqgHwj5ZZOli+x0BsC2KxOR0acFYbpL9xCNzucRO9YH04w0NoB7r
         +zh6gdK2oCcAMa7mqgGuwF1Sr8tMYwMMAprxZ3kF9rR5Ju7AT6+WXEA4/g7oo3OwRh2g
         Lu1LaXWsovi5RWlWeeEdhYH8aP+vhFWaqA2XaUQ+iIBkWscdrvbMEwQF4qITWtcl8Ata
         Bpzw==
X-Forwarded-Encrypted: i=1; AJvYcCUeA4bndBFxK4SUa259f1jaYqsdOUnCtX/sgOactJFyieF1q7F5C/Ew+xxlwWSn7sjYI2N+g8uRUEUZfq7lmqffFqNOjAFD4ffyKNK4lQ==
X-Gm-Message-State: AOJu0YxVJgPU5lCedBBgwrqZyWJHQp8kdPntC44zQLUyUlBK4goeNEpx
	0cFt6IKxafpuG3ukd8Y++UnjjNhWXahQ7JdD2RrvVltIElIrcujGV9ghqZWU+/G39V61QgpKAIf
	9Mvi0EczmsTGRUtbYnRFp0mYVWj2Fft3QykWz
X-Google-Smtp-Source: AGHT+IE9fAMwB02uuQ94nEpy4LyanC7xT4icsl4y9kTpTBjAiVMb+QVVN/OZ7PFrRjTuaOAC60zwFIwL5MnGwsnXp9Q=
X-Received: by 2002:a05:6358:80a8:b0:17b:521f:b2ae with SMTP id
 a40-20020a05635880a800b0017b521fb2aemr6472rwk.14.1709143652850; Wed, 28 Feb
 2024 10:07:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-15-surenb@google.com>
 <b62d2ace-4619-40ac-8536-c5626e95d87b@suse.cz>
In-Reply-To: <b62d2ace-4619-40ac-8536-c5626e95d87b@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 28 Feb 2024 18:07:18 +0000
Message-ID: <CAJuCfpEsBEK5M72v1MdSBnh_bFgJLRj3JzDdz1X1BGzfJw6sfw@mail.gmail.com>
Subject: Re: [PATCH v4 14/36] lib: add allocation tagging support for memory
 allocation profiling
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 8:41=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Another thing I noticed, dunno how critical
>
> On 2/21/24 20:40, Suren Baghdasaryan wrote:
> > +static inline void __alloc_tag_sub(union codetag_ref *ref, size_t byte=
s)
> > +{
> > +     struct alloc_tag *tag;
> > +
> > +#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
> > +     WARN_ONCE(ref && !ref->ct, "alloc_tag was not set\n");
> > +#endif
> > +     if (!ref || !ref->ct)
> > +             return;
>
> This is quite careful.
>
> > +
> > +     tag =3D ct_to_alloc_tag(ref->ct);
> > +
> > +     this_cpu_sub(tag->counters->bytes, bytes);
> > +     this_cpu_dec(tag->counters->calls);
> > +
> > +     ref->ct =3D NULL;
> > +}
> > +
> > +static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
> > +{
> > +     __alloc_tag_sub(ref, bytes);
> > +}
> > +
> > +static inline void alloc_tag_sub_noalloc(union codetag_ref *ref, size_=
t bytes)
> > +{
> > +     __alloc_tag_sub(ref, bytes);
> > +}
> > +
> > +static inline void alloc_tag_ref_set(union codetag_ref *ref, struct al=
loc_tag *tag)
> > +{
> > +#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
> > +     WARN_ONCE(ref && ref->ct,
> > +               "alloc_tag was not cleared (got tag for %s:%u)\n",\
> > +               ref->ct->filename, ref->ct->lineno);
> > +
> > +     WARN_ONCE(!tag, "current->alloc_tag not set");
> > +#endif
> > +     if (!ref || !tag)
> > +             return;
>
> This too.
>
> > +
> > +     ref->ct =3D &tag->ct;
> > +     /*
> > +      * We need in increment the call counter every time we have a new
> > +      * allocation or when we split a large allocation into smaller on=
es.
> > +      * Each new reference for every sub-allocation needs to increment=
 call
> > +      * counter because when we free each part the counter will be dec=
remented.
> > +      */
> > +     this_cpu_inc(tag->counters->calls);
> > +}
> > +
> > +static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_=
tag *tag, size_t bytes)
> > +{
> > +     alloc_tag_ref_set(ref, tag);
>
> We might have returned from alloc_tag_ref_set() due to !tag
>
> > +     this_cpu_add(tag->counters->bytes, bytes);
>
> But here we still assume it's valid.

Yes, this is a blunder on my side after splitting alloc_tag_ref_set()
into a separate function. I'll fix this in the next version. Thanks!

>
> > +}
> > +
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

