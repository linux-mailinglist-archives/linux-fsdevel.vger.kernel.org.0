Return-Path: <linux-fsdevel+bounces-12669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81895862681
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 18:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B354B1C20B2E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 17:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC773481BA;
	Sat, 24 Feb 2024 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L1KE+2OK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A461362
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 17:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708797352; cv=none; b=ufAU2hTRlzj18w1FOGU4CljaTaaMRHNLZjxGSzBdAsdH/41SRPYJgVj73wz8ZaokJIYhZmmWzjy0X9H8UPpwWVt9REtZNjDAyg47zaZMvJGzp9HTCewl1ddGYbe00SqQooK2VFWPBZR8PPPxL9Lm84C1PIDt4gSxwgeYHCcED8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708797352; c=relaxed/simple;
	bh=nBiLO8qaGT6jrE9IUaOLxioWXT0gW8l2dhpg3gyItiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfRTJWJ8ivFKSl/MrFE6rzqKy/bJIjcSozZEWRqajOzLBQFXhnf3ACFo4Czw1gPQv611OXJNup+SY5vsCAP+4ds2WoF1p7L7JR5pyjWXr9aMVC/Mg9Abhnzv/6pFk7kHioIZ8Kkk8A01BsrDMtZfAQ9p2Ma6FFTxgFTuPJcrD5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L1KE+2OK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XR8nVZl4LpgltHQGkRhk6jUPN/LLTQOfmkb1QXGjz5k=; b=L1KE+2OKmBtW7kaH2huYiLBXD6
	2NWnvoTDFS+WzF8QJqhCRKS1zAlocYZQlT14QgM6ztqse4ZlyoeO5z8xwoikQDkMaAcT39dloBQRU
	HE/aO/oolctuUL/MO/3kojJtzeC413g3uUXdl/7z1f+Wonbqo/zRX8W5SMzQjcthkG2M1Y3NjdNg4
	6/NthdY31g4BwQeBgxA80JayH4ACwziEA5pfL1+2K2EuBJobhswwM9Fx45zt1n298AQMvtdKuMNMy
	3+6wL7x3mWVkB4PSmllZPg0XICpmCKDY55/5liUk/nHhjOjKjgxTzwRMGBfjWcgesISgxeTIhnCUy
	vDhFYumw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdwFX-0000000DNTS-4Adp;
	Sat, 24 Feb 2024 17:55:47 +0000
Date: Sat, 24 Feb 2024 09:55:47 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <Zdoto97K4mjONBeI@bombadil.infradead.org>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <Zdlsr88A6AAlJpcc@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zdlsr88A6AAlJpcc@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Sat, Feb 24, 2024 at 04:12:31AM +0000, Matthew Wilcox wrote:
> On Fri, Feb 23, 2024 at 03:59:58PM -0800, Luis Chamberlain wrote:
> >   ~86 GiB/s on pmem DIO on xfs with 64k block size, 1024 XFS agcount on x86_64
> >      Vs
> >  ~ 7,000 MiB/s with buffered IO
> 
> Profile?  My guess is that you're bottlenecked on the xa_lock between
> memory reclaim removing folios from the page cache and the various
> threads adding folios to the page cache.

If it was lock contention I was hoping to use perf lock record on fio, then
perf lock report -F acquired,contended,avg_wait,wait_total

If the contention was on locking xa_lock, it would creep up here, no?

                Name   acquired  contended     avg wait   total wait 

   cgroup_rstat_lock      90132      90132     26.41 us      2.38 s  
         event_mutex      32538      32538      1.40 ms     45.61 s  
                          23476      23476    123.48 us      2.90 s  
                          20803      20803     47.58 us    989.73 ms 
                          11921      11921     31.19 us    371.82 ms 
                           9389       9389    102.65 us    963.80 ms 
                           7763       7763     21.86 us    169.69 ms 
                           1736       1736     15.49 us     26.89 ms 
                            743        743    308.30 us    229.07 ms 
                            667        667    269.69 us    179.88 ms 
                            522        522     36.64 us     19.13 ms 
                            335        335     19.38 us      6.49 ms 
                            328        328    157.10 us     51.53 ms 
                            296        296    278.22 us     82.35 ms 
                            288        288    214.82 us     61.87 ms 
                            282        282    314.38 us     88.65 ms 
                            275        275    128.98 us     35.47 ms 
                            269        269    141.99 us     38.19 ms 
                            264        264    277.73 us     73.32 ms 
                            260        260    160.02 us     41.61 ms 
         event_mutex        251        251    242.03 us     60.75 ms 
                            248        248     12.47 us      3.09 ms 
                            246        246    328.33 us     80.77 ms 
                            245        245    189.83 us     46.51 ms 
                            245        245    275.17 us     67.42 ms 
                            235        235    152.49 us     35.84 ms 
                            235        235     38.55 us      9.06 ms 
                            228        228    137.27 us     31.30 ms 
                            224        224     94.65 us     21.20 ms 
                            221        221    198.13 us     43.79 ms 
                            220        220    411.64 us     90.56 ms 
                            214        214    291.08 us     62.29 ms 
                            209        209    132.94 us     27.79 ms 
                            207        207    364.20 us     75.39 ms 
                            204        204    346.68 us     70.72 ms 
                            194        194    169.77 us     32.94 ms 
                            181        181    137.87 us     24.95 ms 
                            181        181    154.78 us     28.01 ms 
                            172        172    145.11 us     24.96 ms 
                            169        169    124.30 us     21.01 ms 
                            168        168    378.92 us     63.66 ms 
                            161        161     91.64 us     14.75 ms 
                            161        161    264.51 us     42.59 ms 
                            153        153     85.53 us     13.09 ms 
                            150        150    383.28 us     57.49 ms 
                            148        148     91.24 us     13.50 ms 

I'll have to nose dive some more.. but for the life of me I can't see
the expected xa_lock contention.

  Luis

