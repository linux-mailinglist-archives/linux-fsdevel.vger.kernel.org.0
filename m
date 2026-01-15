Return-Path: <linux-fsdevel+bounces-73951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B41E2D26DFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 18:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23BE932F956A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C423C0099;
	Thu, 15 Jan 2026 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DDIQUtMP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40DD1A2389
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498400; cv=none; b=U/EbkPJCywonL01kaow6GYIVQ5w1UTNMpWnKc/HwStPZvzrxbP0DIhd+xuvKtGRIzPXqYQG3+1T6Fpnomd2b/2d9iMPcSIB7tFwlcUlaKXchfqoDAKvjuOaxeeIAugs0jgAxhzF2ESMNWyD5eS8hM5Q0B5iG3/7605UxmQzD/30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498400; c=relaxed/simple;
	bh=gmWxAy5uTUT/UhmfH7kZ4VlAnV5ZizQ7PRjs0zDcgrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOHOa+53J9VEczZtZ+azuvYnZ8/oA/q2GkohMyf+yWIZPKNlmCS+YR+d/bDE3ALWTgSbB4c8neNzC0q1s5sGY24jZDssHDZ7T1iBGamymL3OHed7AqKdmO8lyJfGiYhn9Ivv/NCdiAEnbzdb6k/QpVT7V1zX2dkwhbM0gW0p6Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DDIQUtMP; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88888c41a13so16289276d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 09:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768498398; x=1769103198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HELVBq+JbyCXR2ZFI5M9lAV4vG/kM2Ay1hf/o0jB9SU=;
        b=DDIQUtMPS6qsYgGC4olHxdA2og7hiboMmzlbdkYOPfrQTvla0yrc0UEt7U0a7jUvpL
         JlUSmDECkpRXSGxaapxEyApW/eTYlXf4e/RhQI/ueH/vC9vHEO8TpXRK/JmOaEsxk/8V
         dRqvb1+sPOCkYfume+xdaF9zZhDuHyQWmWLiS9Az9jd7JyjO5JFgNYzWGR0YR0vq6p7g
         L+yqOpuYCyesOqFnbRg5Rea+bHmHwOtJzfIHA7Qv9WGVy9Z9KyVt4H5Yz2vZKQrQkAeU
         ntn7bxStqacS+ix2hXl/3p8oeI5HZd5zJY+6+h6ZsHN0WPWWT0R99Dx8z2+bKie+e4VL
         Zc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768498398; x=1769103198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HELVBq+JbyCXR2ZFI5M9lAV4vG/kM2Ay1hf/o0jB9SU=;
        b=rmD774qJJBF4lDwKt5b8bY/DvHH/uAtclPjqYXvzC3Vy6KuKBLS+RgjUyXkKYaABbt
         3nvxkq6H2+zI+AATwCjUnT3ikZGdz+pIBtdsNylY7HFrRwxleRij0Mr0l5xUIhU+hWRa
         XST1zZrKJLplPSzhLcBBtQoWe+pqmPCmpq2HJoja4twt4Je9zTeUjmVV75Jdgaq8jfHM
         7dOcZLjfGaVUJg60MsGEK3cpkwfeA7uNGO0Pjfj+iZ4q95LJk6+HKC3SavRRRhfI2wc7
         irhP2xaw2bRIgr657FDvhQjBa+GQ2Zdan9tWKBnAuoCawIJiS/9UR0HjdntE/cWPFdGt
         ou8g==
X-Forwarded-Encrypted: i=1; AJvYcCW+73/1XlCUhdt6dvT/noY97iysz72vVKuqGmDumCY7oG1hhaP/VztsZEeckReatH/7E9TnnkIybBDRBlk2@vger.kernel.org
X-Gm-Message-State: AOJu0YwE+P2Eb8kw+BH5k5gTeXvnwvQwesG5KKJuLbxU1ZlWC0ez0bCw
	S+kUXt+2psEjyEyWuMqy/O6wRPXRvZBsbPsRIV2KqsQMS+KuU7labF+9b6lx3JyuEdU=
X-Gm-Gg: AY/fxX7xA+dx9qkSs/jmUz3aUnOMILgsaSFxT6bKNZeAxhtJAPFAahG9nwAKPWxazu0
	hoHLi7gkZ3P//+HquYjmHTVQOpEu5ehAQa632/ZZjnOVvnxxJg822jDawy2buxu8/sQlZw4ebCx
	50F0ZzEEFJw/RlUNRS4YrgY8WOd1Xijj8HsP8btp5VYL+0e5F1TNwC3GNQl8tyxvgVTN93wAybD
	Fs+UqoFIJHMguuN8Uo0rKyvRCXxCg9QYEH88wHoAL0et+d2sl4DnPr1LXg/TlyFhETNJfgnenzB
	dyDmqVsGkFAI6tsvCiO0YCL6qhYnpOhiRlJydl7kA69P4R7P3yT9PUDkvJwAk0Xk/A36+K3lQuK
	C2Yder83twV+GtY9MVxhjkDRkb21bDfUorM3oFC535hXfYF3S5hNKMe5GRThZzf95IxqbAF7GfA
	rfyMw5OHN2l+YURYp0rSZsh9hN6d0CRqcIaDBWgi5sdvht5Az1lqgpKc/Az0ZNfNRU7mobAg==
X-Received: by 2002:ad4:5f8e:0:b0:880:541c:8243 with SMTP id 6a1803df08f44-8942dd060f8mr2986496d6.1.1768498397481;
        Thu, 15 Jan 2026 09:33:17 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e47d897sm548586d6.0.2026.01.15.09.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 09:33:15 -0800 (PST)
Date: Thu, 15 Jan 2026 12:32:41 -0500
From: Gregory Price <gourry@gourry.net>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-cxl@vger.kernel.org,
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
	shikemeng@huaweicloud.com, bhe@redhat.com, baohua@kernel.org,
	chengming.zhou@linux.dev, roman.gushchin@linux.dev,
	muchun.song@linux.dev, osalvador@suse.de, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com, cl@gentwo.org,
	harry.yoo@oracle.com, zhengqi.arch@bytedance.com
Subject: Re: [RFC PATCH v3 7/8] mm/zswap: compressed ram direct integration
Message-ID: <aWkkuaYt0cEyvbGj@gourry-fedora-PF4VCD3F>
References: <20260108203755.1163107-1-gourry@gourry.net>
 <20260108203755.1163107-8-gourry@gourry.net>
 <i6o5k4xumd5i3ehl6ifk3554sowd2qe7yul7vhaqlh2zo6y7is@z2ky4m432wd6>
 <aWF1uDdP75gOCGLm@gourry-fedora-PF4VCD3F>
 <4ftthovin57fi4blr2mardw4elwfsiv6vrkhrjqjsfvvuuugjj@uivjc5uzj5ys>
 <CAKEwX=MftJXOE8H=m1C=_RVL8cu516efixTwcaQMBB9pdj=K+g@mail.gmail.com>
 <CAKEwX=M8=vDO_pg5EJWiaNnJQpob8=NWvbZzssKKPpzs24wj+A@mail.gmail.com>
 <e6eydzdvuiktmalhcmoiwsgzjbw5v7t4532fkbroylwr5cqetx@v6pgjaoxgmyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6eydzdvuiktmalhcmoiwsgzjbw5v7t4532fkbroylwr5cqetx@v6pgjaoxgmyz>

On Thu, Jan 15, 2026 at 05:00:04PM +0000, Yosry Ahmed wrote:
> > 
> > 2. Just enable zswap shrinker and have memory reclaim move these pages
> > into disk swap. This will have a much more drastic performance
> > implications though :)
> 
> I think what you're getting it as that we can still make forward
> progress after memory lands in compressed cxl. But moving memory to
> compressed cxl is already forward progress that reclaim won't capture if
> we charge memory as a full page. I think this is the crux of the issue.
> 
> We need to figure out how to make accounting work such that moving
> memory to compressed cxl is forward progress, but make sure we don't
> break the overall accounting consisteny. If we only charge the actual
> compressed size, then from the system perspective there is a page that
> is only partially charged and the rest of it is more-or-less leaked.

Which is comically fine - because the actual capacity of the node is
functionally a lie anyway :D

~Gregory

