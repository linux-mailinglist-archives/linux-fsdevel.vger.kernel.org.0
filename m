Return-Path: <linux-fsdevel+bounces-15322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AE688C298
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 13:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5072A5A6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 12:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0B874420;
	Tue, 26 Mar 2024 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="axUcjzD2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914507441C
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Mar 2024 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711457493; cv=none; b=oKKcri8UxOevTD8tpflq/A6/ekORl8YVwDjD+2LA8a4TPYNABaBWMq5zz1WYXhmKr0MpItGPXeK1hYaZi38NHgILYjD6De1+xC5Zeh7YNz+srIpIuuzonZl2egRc2ZfIbwTB0JkECBRo/URX+zc1UVKWCKcYLa+sNROpIeSznr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711457493; c=relaxed/simple;
	bh=so6dL+P6dq5Y7OYvRjeRvhwpLxycYRKRO39veYEMi0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlIjov3Vdqib+N0bE8i0mOL4ordueesTlzCnqEvgLPDAhPD/m/FviwW4pBijvW3oj0/dG61N1BG5G3NRBTgb51M7k03DpXoucM9a9aglnHNOz9msKLqNbzJOW6arzK3nA57Z0sFCKU5aNVbRdRHGBOAcr8T085FLohNwbSxAsKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=axUcjzD2; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c3b256ab5eso2832201b6e.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Mar 2024 05:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711457490; x=1712062290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EfoOYG5EQf0UkvMjeqz6CEWwC7DheKH6EhJnW18OMBU=;
        b=axUcjzD2KlaZ1NbWUheLDo0DPud0t5JygAbGoPREqYXRpxJZKn+ohmOMV0uMbXXwrO
         0+8CE7sCpoQvs9rVNDpqTkVqYkRdU7lP7ZQyT9Usv2cAM7etuxnkKq/YSbRuV0gM6pYJ
         236/Lof95B9+TUKdOqScNgBrUGsDuacFF2aocCZ318mNZlfOH4gC5khXIADkSbuTiT/I
         4aWgRuyHGen6oVRBQ8kSxlLdF3ik5juqJNMdK6Uk682GfVAn+kGTYAaXj4yl/ITdGuVK
         r6EqQAHY5mi1uKysVfd9ypbR13ijietcA2D+hRh6Ff2FcaIEAi5dVnnQ0r0M8wZFGxNZ
         28Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711457490; x=1712062290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfoOYG5EQf0UkvMjeqz6CEWwC7DheKH6EhJnW18OMBU=;
        b=Nr611ODrBguQ7HfloD3syTo84B49/pRf7YmAZ9NYtNG6gyyEYct1UbTM5K0M5/OmMs
         8A1Boa5hZ4cgHpmGPoYlgkOxncL9jyuUhWqEV2jDyJyRl4cBSA4aDNSrfoklvkSBPQPJ
         lVarIz76kISmt221NU584wK6jrOtnXaUF6MCsKqFXT/dGQ5yZqcqSmFJeRPKUkHwTn47
         OZBmTZLyLkY5b6pQM1jI8yV+ivr0A54BUMAPAi22pADfYcdjpvo1R0Ue9MLIDFigRDQT
         4m2QFAJ56MBqt9Q/RNlvQagES5RFLslbM+eaZr5cMib5RkFZnKaofaEW8QmN4lIFNJ7x
         fmaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWifHKEy762SmRXx2gDxIKggdEMIQBYPFEvPQ2gjYaGZOON/bSg5HjR9GkxQwlHhvm5h5OOxvs+VGlsatYPYN4Ha4nA1+8Ewx0xD8Cvow==
X-Gm-Message-State: AOJu0Yz2aXToEer7VZpEgIsxS3TeiuhnCYoB5Mw/AHKbNVsKtSorB2bs
	7GnZHiw1QgXlDKGSVvViu7COlu40LSSChUR371e6iE2SvZ/xBGajLBW6mCGE1GU=
X-Google-Smtp-Source: AGHT+IE8wqWbE8dlvgzHGjmsmYkeWHkJ5uMP6CAmnUcUKq0xZRk3/UFNAOnBZTpR00X275iSg87Usw==
X-Received: by 2002:a05:6808:1209:b0:3c3:82a1:e6e with SMTP id a9-20020a056808120900b003c382a10e6emr11024343oil.53.1711457490602;
        Tue, 26 Mar 2024 05:51:30 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id bz23-20020a05622a1e9700b004313bda0329sm3654928qtb.96.2024.03.26.05.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 05:51:30 -0700 (PDT)
Date: Tue, 26 Mar 2024 08:51:20 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, david@redhat.com, hughd@google.com, osandov@fb.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: swapfile: fix SSD detection with swapfile on
 btrfs
Message-ID: <20240326125120.GB229434@cmpxchg.org>
References: <20240322164956.422815-1-hannes@cmpxchg.org>
 <87plvho872.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plvho872.fsf@yhuang6-desk2.ccr.corp.intel.com>

Hi Ying,

Thanks for taking a look!

On Tue, Mar 26, 2024 at 01:47:45PM +0800, Huang, Ying wrote:
> Johannes Weiner <hannes@cmpxchg.org> writes:
> > +static struct swap_cluster_info *setup_clusters(struct swap_info_struct *p,
> > +						unsigned char *swap_map)
> > +{
> > +	unsigned long nr_clusters = DIV_ROUND_UP(p->max, SWAPFILE_CLUSTER);
> > +	unsigned long col = p->cluster_next / SWAPFILE_CLUSTER % SWAP_CLUSTER_COLS;
> > +	struct swap_cluster_info *cluster_info;
> > +	unsigned long i, j, k, idx;
> > +	int cpu, err = -ENOMEM;
> > +
> > +	cluster_info = kvcalloc(nr_clusters, sizeof(*cluster_info), GFP_KERNEL);
> >  	if (!cluster_info)
> > -		return nr_extents;
> > +		goto err;
> > +
> > +	for (i = 0; i < nr_clusters; i++)
> > +		spin_lock_init(&cluster_info[i].lock);
> >  
> > +	p->cluster_next_cpu = alloc_percpu(unsigned int);
> > +	if (!p->cluster_next_cpu)
> > +		goto err_free;
> > +
> > +	/* Random start position to help with wear leveling */
> > +	for_each_possible_cpu(cpu)
> > +		per_cpu(*p->cluster_next_cpu, cpu) =
> > +			get_random_u32_inclusive(1, p->highest_bit);
> > +
> > +	p->percpu_cluster = alloc_percpu(struct percpu_cluster);
> > +	if (!p->percpu_cluster)
> > +		goto err_free;
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		struct percpu_cluster *cluster;
> > +
> > +		cluster = per_cpu_ptr(p->percpu_cluster, cpu);
> > +		cluster_set_null(&cluster->index);
> > +	}
> > +
> > +	/*
> > +	 * Mark unusable pages as unavailable. The clusters aren't
> > +	 * marked free yet, so no list operations are involved yet.
> > +	 */
> > +	for (i = 0; i < round_up(p->max, SWAPFILE_CLUSTER); i++)
> > +		if (i >= p->max || swap_map[i] == SWAP_MAP_BAD)
> > +			inc_cluster_info_page(p, cluster_info, i);
> 
> If p->max is large, it seems better to use an loop like below?
> 
>  	for (i = 0; i < swap_header->info.nr_badpages; i++) {
>                 /* check i and inc_cluster_info_page() */
>         }
> 
> in most cases, swap_header->info.nr_badpages should be much smaller than
> p->max.

Yes, it's a little crappy. I've tried to not duplicate the smarts from
setup_swap_map_and_extents() to avoid bugs if they go out of
sync. Consulting the map directly is a bit more robust. Right now it's
the badpages, but also the header at map[0], that needs to be marked.

But you're right this could be slow with big files. I can send an
update and add a comment to keep the functions in sync.

