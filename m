Return-Path: <linux-fsdevel+bounces-73950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D994CD26B73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 18:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 68BE230299F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DF83BF31F;
	Thu, 15 Jan 2026 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="YEhU+4Ug"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93C43C0090
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498039; cv=none; b=Zxmls+g1oBeyriuc3+krZ3ZMdJEvqzohElOQ7qLlbFgO6JvRwOXktAtwV5zRwyh5kMHwGmrQTvXPDjGsP1CVfJRoO8eyAgafElS8wef4rx76DNmgz2cTKqAwfOyBQ00zRR17Wd2cfKSbn9gc7xVZyvIvjUPotnb1wzHBUfSVDCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498039; c=relaxed/simple;
	bh=3UGXrZkeYXLx8IoVJrtniFV8BFbMiKk7p6uPdTyK/0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lo19aIWQneKj97EPXTWG/CrQU4flGeM+VPgnP1fIJs4UsAejhJWiHA2LJT+Wdjlfsgc3D0ysPsaM5Wq+vmkMjoex2UKPxGj1IwqoqPMJIxK7mTGhhu4Zm90lD5Ln8rpIhLASH+CDIWrpXIj3YmXMujWMOxuDMVmCOB6GKe0vBWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=YEhU+4Ug; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8888a1c50e8so13858916d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 09:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768498037; x=1769102837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9FK61OSEd0UmY2wqnN+WlOD2t6xQO8MJ1jOlEc9XBMg=;
        b=YEhU+4UglXlQQlfuFffLzOxZF1W221ljq75jkYmrgBTttcp18/A9wRTucjN8uHZtlg
         ECvh9hd6KBcOEx5heMRX5nNm9jvWUip0I/pctmUUaMroCrdAqRq5x6SccwevxqlziUcX
         +/H3LgzsFU/oXZERrYrlk9fp5ZgtSrDK7Q00NJ/t2elprpDeGFR6002oruyaRiElcG5d
         sUAF/nbeMvK1ehey4jpZKskRdfYrstJtw2//Isjg4oQ2OxNVZwAyWwQEvJPHttBKAazQ
         AW4x6bPH1/49pR8zfHAOhwzWWvy5zr4cmG3+34Ds4SsQxIP76DcO9Ic4xLpCdBW617IF
         5soQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768498037; x=1769102837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FK61OSEd0UmY2wqnN+WlOD2t6xQO8MJ1jOlEc9XBMg=;
        b=By0ujr6AKVzMjyNk+ylFXPiUO03XlUnOoDMM539MT8yqE66kgSv6W1bwJtj8ztSmj5
         tPmfCHEsHkC6KzJlR+kCeLSH00Wq+8HT1kXUHTjN4c9BPSnIvXykGXnqZRFqCgwNz6Sd
         mJ92cwDPDwm+FEm/EBX/auhKhNL1V+sUgiz0Rjj9xFJM3BMLXUktKaFy/MtFHokdcp4R
         xz7gczyA7qX0PrNWizoHrUhvro/rF91cANQT+Ui3z1PiDNcWR56tY+v/z9StiHkVcyDY
         hvH/RQJXJQZa87jbN6nGXff26xhUZI+BbzaHsGAfOLu8PmS533PuwtbqnoFFozTcPt1u
         0kFA==
X-Forwarded-Encrypted: i=1; AJvYcCXqYMoX4RxzllJCen9H7eqHAx2cjY3DSXvUiCm7BuilT74LK6NQCt82C71WxhslkJtp35F+MIH9s8+fnxVY@vger.kernel.org
X-Gm-Message-State: AOJu0YxLPtTEn/TUK2cSBM7x+lLVhZ3hr06jaNqGrSShTiflkpd1dDp7
	768hWHDbbWLE4I7BkKzqDYI99kHsXzsExSsx0IK5/u5ejZ62g5ppg9+YGkNDo45OW0w=
X-Gm-Gg: AY/fxX6+yMbWZBvjRhzWJQje7zRN8kAav+Ki93YcUojUuhiRbuXgMmIs8TecmhhUsks
	5lfxbYPsvJVU2mSKqrLYt6kkRShc0BA6qHR/XtjyIN1i2DreivYbqn2GMuhvedNOpqFBTccN4Hp
	U78g1zCb+YcUOb3TB4+b1vY0B2AO2RBvzIs5Yea/99vj7W9k53X3/vkM3okzKM89jj8Rl7mETDv
	8Qt9nFgix4IE+PtILEv5BUio1P+aeQBOZ8zoLWywe1GXWxyK3ruHesHkODaqlcfMdmrSgAIDonl
	LopSPKN4isQp928m53C1/o5xjYpExtk3AkttlA+hFhyVoWblErNnMhPnU/pXsdbQFRhdq8trOdf
	jIaJ4djfDjabHwrXOORdc6EOGsdSmLZ1IVQLvY1DkS/3uyGN8aVKNJkQ9Ne53KJrxb/ru5BUcdY
	l4DFPfoYcVUu6GCGLS7GUokRuwrJU8E+OwkISs7KJ3owotDqrqCiztLe8Vs0xZHPevCfXBWg==
X-Received: by 2002:a05:6214:4007:b0:889:b6f1:1f30 with SMTP id 6a1803df08f44-8942dbf5199mr2798016d6.18.1768498036628;
        Thu, 15 Jan 2026 09:27:16 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077253305sm219364246d6.41.2026.01.15.09.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 09:27:14 -0800 (PST)
Date: Thu, 15 Jan 2026 12:26:41 -0500
From: Gregory Price <gourry@gourry.net>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, corbet@lwn.net, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, ziy@nvidia.com,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, rientjes@google.com,
	shakeel.butt@linux.dev, chrisl@kernel.org, kasong@tencent.com,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, chengming.zhou@linux.dev,
	roman.gushchin@linux.dev, muchun.song@linux.dev, osalvador@suse.de,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	cl@gentwo.org, harry.yoo@oracle.com, zhengqi.arch@bytedance.com
Subject: Re: [RFC PATCH v3 7/8] mm/zswap: compressed ram direct integration
Message-ID: <aWkjUXpyLEJyc-C0@gourry-fedora-PF4VCD3F>
References: <20260108203755.1163107-1-gourry@gourry.net>
 <20260108203755.1163107-8-gourry@gourry.net>
 <i6o5k4xumd5i3ehl6ifk3554sowd2qe7yul7vhaqlh2zo6y7is@z2ky4m432wd6>
 <aWF1uDdP75gOCGLm@gourry-fedora-PF4VCD3F>
 <4ftthovin57fi4blr2mardw4elwfsiv6vrkhrjqjsfvvuuugjj@uivjc5uzj5ys>
 <aWWEvAaUmpA_0ERP@gourry-fedora-PF4VCD3F>
 <fkxcxh4eilncsbtwt7jmuiaxrfvuidlnbovesa6m7eoif5tmxc@r34c5zy4nr4y>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fkxcxh4eilncsbtwt7jmuiaxrfvuidlnbovesa6m7eoif5tmxc@r34c5zy4nr4y>

> > For the first go, yeah.  A cram.c would need special page table handling
> > bits that will take a while to get right.  We can make use of the
> > hardware differently in the meantime.
> 
> Makes sense.
> 
> I just want to point out that using compressed memory with zswap doesn't
> buy us much in terms of reclaim latency, so the main goal here is just
> saving memory on the top tier, not improving performance, right?
>

Yeah first goal is to just demonstrate such an accelerator can even work
as a top-tier memory saving mechanism.  But hard to say whether reclaim
latency will be affected appreciably - won't know until we get there :]

I'm totally prepared for this to be a science experiment that gets
thrown away.

> > 
> > I will probably need some help to get the accounting right if I'm being
> > honest.  I can't say I fully understanding the implications here, but
> > what you describe makes sense.
> > 
> 
> Yeah it's counter-intuitive. Zswap needs to charge less than PAGE_SIZE
> so that memcg tracking continues to make sense with reclaim (i.e. usage
> goes down), but if zswap consumed a full page from the system
> perspective, the math won't math.
> 
> Separate limits *could* be the answer, but it's harder to configure and
> existing configuration won't "just work" with compressed memory.
>

I think you are right. I am also inquiring whether individual page
compression data is retrievable.  If so, then this actually should be a
trivial integration.

If not then this is probably ending up on the cutting room floor and
going straight to a full cram.c implementation.

~Gregory

