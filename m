Return-Path: <linux-fsdevel+bounces-11901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE78858A89
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 01:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F631F22BFE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 00:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE404D266;
	Sat, 17 Feb 2024 00:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FAXamuuN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D314C84
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Feb 2024 00:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708128530; cv=none; b=O8cFiJ7oIoMJ0y/fcJfBNtA9at4dhRl1lwtUxFagjEW7jCFq4E4Dma2FIcvJtjJldsA6fU89yQp6pa4VFSPx49zFqCnmP0j+MuWXIr/HYNZ/bsPTK8kOFDc46jLsfFv6pcnQ86ywyG/ToesMkgd/T/RTRYDZyH2CT4C9zE1ikSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708128530; c=relaxed/simple;
	bh=plU6YhEkyhkbfKgfjHrx3qjSg7IHeMnpyb2DBIHN9Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbDyQLKLT6LjnDclhaLZArborw8NK1DSr1wYfuzjQVD0PZ8jVeE8MurNnohajNCUnEJqbOKeFNNvkGIOrhOLCnrqZEkdQxHnROgMVmtigb5clxsEvCRk81jujXvnSShgGbvgEH3z3i5z4Cq06PHAvPtWkC9aRcT2hywW+DTVF04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FAXamuuN; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso2194645a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 16:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708128528; x=1708733328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S1txfacIBFBZ/O4tjcxs+bfhiTiZyaDvYXwzko6DwYw=;
        b=FAXamuuNv/zQzAsTiczfELCzSiTGSx1i/N2NTp0zupFLDQsEIxjlp36niuZ2AP+LXG
         uwz2r7+1poIRzYwVXiE5dopiurRDvewCRlMU4JDMQz2+foC3MvDRrVkWlpAZZy83/LUv
         Teb8jXfQwKklL/wDFlt/TtF/74WCF3iwL7PHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708128528; x=1708733328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1txfacIBFBZ/O4tjcxs+bfhiTiZyaDvYXwzko6DwYw=;
        b=KLttcjFAIczna+CLySO/YtKa8KAss5uz4L7vzmYFbUgPlEfUstlL6PMSXHiv0G38Dx
         beAL6ZndjKhPAJh9m2qLgCWV/iYf5U2HdjHNjf+5bnaMZRK0KU7B+RjHWvem8CbJH6qv
         rbcIVCTbC+7wWXIYj6e1TcE6DYf+dDEC+bXEyoJ2D6IYYfDv1IPks173rpcRhzEeFmvn
         9pdaKBHgpKmI8dhjqsWXIzSnUA7kTx8JeLFabYLoUqJnyNRv632z0a8Rs+s3txsfWoXv
         SvTI4I8Vfl2OpZDVRgpKwq5xQ8rWEq1paYmZs8dhn4pvVlxTly5qbBwcaR1OZum5DmDq
         4Xaw==
X-Forwarded-Encrypted: i=1; AJvYcCXWoM20OrzVgtgzXvAzd6fvgWeAN7lHcg37HUMvHZ+LnFyu3rSuvKKq1QKS6AXO1fNAcWR/p+pnlDRlEirA/GFq+YGj2Gy0t8oMydvt1A==
X-Gm-Message-State: AOJu0YzZdxkDkSGLqdbptr2NXsgw7m5GAfB9mHFdmKLuVmOu4a8R0DsF
	hbJYA5wCgf47t0zZ1Mf+RWGxN4KcBA7+xkHwpDioMfYDo8QErBhgC9YoFsOL7w==
X-Google-Smtp-Source: AGHT+IF+QQ/9SK4sTlRF7CviXNWL9OdNoE9iSFRsOXGRftVqcaAIHIRUQhIt4OYE39Err1qxKn5GJw==
X-Received: by 2002:a05:6a21:3183:b0:19e:a9e6:c05 with SMTP id za3-20020a056a21318300b0019ea9e60c05mr7276163pzb.43.1708128527870;
        Fri, 16 Feb 2024 16:08:47 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z3-20020aa79903000000b006e094bf05f4sm487826pff.213.2024.02.16.16.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 16:08:47 -0800 (PST)
Date: Fri, 16 Feb 2024 16:08:46 -0800
From: Kees Cook <keescook@chromium.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
	willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
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
Subject: Re: [PATCH v3 13/35] lib: add allocation tagging support for memory
 allocation profiling
Message-ID: <202402161607.0208EB45C@keescook>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-14-surenb@google.com>
 <202402121433.5CC66F34B@keescook>
 <lvrwtp73y2upktswswekhhilrp2i742tmhcxi2c4gayyn24qd2@hdktbg3qutgb>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lvrwtp73y2upktswswekhhilrp2i742tmhcxi2c4gayyn24qd2@hdktbg3qutgb>

On Fri, Feb 16, 2024 at 06:26:06PM -0500, Kent Overstreet wrote:
> On Mon, Feb 12, 2024 at 02:40:12PM -0800, Kees Cook wrote:
> > On Mon, Feb 12, 2024 at 01:38:59PM -0800, Suren Baghdasaryan wrote:
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index ffe8f618ab86..da68a10517c8 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -770,6 +770,10 @@ struct task_struct {
> > >  	unsigned int			flags;
> > >  	unsigned int			ptrace;
> > >  
> > > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > > +	struct alloc_tag		*alloc_tag;
> > > +#endif
> > 
> > Normally scheduling is very sensitive to having anything early in
> > task_struct. I would suggest moving this the CONFIG_SCHED_CORE ifdef
> > area.
> 
> This is even hotter than the scheduler members; we actually do want it
> up front.

It is? I would imagine the scheduler would touch stuff more than the
allocator, but whatever works. :)

-- 
Kees Cook

