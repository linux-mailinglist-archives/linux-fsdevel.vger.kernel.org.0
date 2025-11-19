Return-Path: <linux-fsdevel+bounces-69084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E02C8C6E93F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 13:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65C3A3A1A9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 12:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120973559D9;
	Wed, 19 Nov 2025 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGczKZbb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D24634BA4E
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555949; cv=none; b=WHqSPvXvcRp78oqXk85je07zq0rrjUJcV8N4VKq7rteJzlYFFpXTk5yVQNFLjj4ucqbNfbkaqx4xGDEou6tPBOUqOWUsC55T8LghHyymzDHAs2OZ2thHuYljYtNteC6UkFaOn/hslLTQ3qLByRnLJimngBvZY5tEgDPW9KvhbqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555949; c=relaxed/simple;
	bh=5gFeZNgqrsMX6jwOkCEQwUdo7/X9FYun+sRtuOCorE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5RBlAvdWHcHFY/V9+UsDYLhht6jfqPztzqWQYx3N4BeDUyU19tU9lMOVZK3CNoRvN6JpoBBDE27UUccKayFdz9Nu116oIg5sY3+7m6CuJo1pHBo0ZLXLRTm8agLAnjj0/DRphP9bdJ0f95Dhvwem6xMTJKEf7cDWs52WjgJ49M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGczKZbb; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso11255772a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 04:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763555946; x=1764160746; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHvebzZNHtF5Uirfhl1zM1fOdHCkj14yEnqWrebk/Qs=;
        b=mGczKZbbtrg7j9IHBeb9yc13GN9Jl/7fc2sWgQUiGhdyTJL2Ai+1nnJTozaO7ntUhX
         kS4Nw1TBTvtzE6Fa8PYeigGREPw2eXzG+5O6mhfMTKTnyNFlOkUXvqvt+rRzGshEx9JJ
         9iPENAOVndT7FPl+bStuDWTtW+oln/R33rXm9FVI30kPMJMacyYH5mTeMaXpnxTglMK8
         QsFg5I1jJJ2TvXl3M5p+lTxyHT/zC0UV8UNDgw0w7eAuI1ffwsOC+l7VzUw8ZsGsDI3x
         X0Ti6ziKqKWUKGbk6VgBSyhdZtgxhXdfInSYMGQy74gPSjtcA75VBVD6N9A0DDelGEbf
         asXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763555946; x=1764160746;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CHvebzZNHtF5Uirfhl1zM1fOdHCkj14yEnqWrebk/Qs=;
        b=ViY77WmdDoqCeCpih7AATYAevK4g7sGWMQpOXrAO15kl93CyPV/ycCAmhKkWynaTyd
         Phk1lLfx29cmWPEzhdV7Z3JWv7c2ee7ZORAz5WFzEHrDgkBFX2/gmQ3UbOBA5g6enUgm
         EJjyFhA1Y4uMuxstQDjJIgyjZru8sxoNrsNNcaq92og4UdNRR/tZ4phNALNrN6cXHwRw
         YpQm4aqhnpe+LSnVveuTJ9BiMf0EXGZLEIk1YG8ROLEC0qx9Gi1MNh8DWg0klyuA8C7b
         AETUt4ncy9qgCQJyMZLtwNnJdcsvZDoB0rsniVbp9/xWMkM1sEZlznNFgBjwSYrTANCR
         F/CA==
X-Forwarded-Encrypted: i=1; AJvYcCXxPvffML4gPh5sHB5Kwx6oB8yjOw6wMsIRacxL2hVyOqRI0VBjLpeOsW79U2hasWKpuqrtoYa9lmw2C0TV@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy4LobB30rZW4zMnoKCWvSS9oJi5lV128kqK5PZwaU+ndYto+6
	XA9IT9IUOYdaKNZJeByeIDnlgClgCG7EaurtM9iPJTLSosj4vDAvGMYv
X-Gm-Gg: ASbGncuC35hPzBvspRYnP0T+Rh139E4Mhn0CIxB4LYw0A6Fx2QceGaFWXy9UT4EGS9g
	ofkdWs4G9c3FRhmiQQa+43eFT9d1DaUi4gUmjtZz5Chxe3LoUVEG9Hb1QbUD07Eb8b9Vgsqmcd5
	suh99VGOwlsXjjy1Px3YoZGjmR081CE0jNwxquVYceM7Cio/BR1KuLvGK8ljC+ANxssiHUr1slC
	rPGygDoVUeKrvx1Md0Ty0LScaALBVofarxJzIY+1eNA4wRdx2SFGbA+z7Ai0Tg2U/zzZ8qlAH1P
	aU9tSUlMBEiF2YSK42ITGml+RavttEgX6DUbXIKkQnQah4+tas0baLkc6+1iddLW2vF7nHUXIh1
	0JeXmZvLTsw9EozuOrSddIZFJjmW6dcsVgdjsZMX/aYTDw2/MglZHWgUSrUnEpE3vbycUQSY02f
	J+3kjvMfWprxJuEnkeZS0kDgOh
X-Google-Smtp-Source: AGHT+IH6kOS0l+EUbnypOaJgGizNY/obs0hzloB1TKPSHs9xqLDPIWs5NS3ucRiDjUds0rraP+UpiA==
X-Received: by 2002:a05:6402:354d:b0:640:ef03:82c9 with SMTP id 4fb4d7f45d1cf-6451e36df53mr2153224a12.11.1763555945740;
        Wed, 19 Nov 2025 04:39:05 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a3f96e2sm14975912a12.16.2025.11.19.04.39.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Nov 2025 04:39:05 -0800 (PST)
Date: Wed, 19 Nov 2025 12:39:05 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Wei Yang <richard.weiyang@gmail.com>,
	willy@infradead.org, akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/huge_memory: consolidate order-related checks into
 folio_split_supported()
Message-ID: <20251119123905.ak67ykufvfr4iulr@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251114075703.10434-1-richard.weiyang@gmail.com>
 <202511151652.GKPwEctt-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202511151652.GKPwEctt-lkp@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Nov 19, 2025 at 03:37:09PM +0300, Dan Carpenter wrote:
>Hi Wei,
>
>kernel test robot noticed the following build warnings:
>
>url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Yang/mm-huge_memory-consolidate-order-related-checks-into-folio_split_supported/20251114-155833
>base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
>patch link:    https://lore.kernel.org/r/20251114075703.10434-1-richard.weiyang%40gmail.com
>patch subject: [PATCH] mm/huge_memory: consolidate order-related checks into folio_split_supported()
>config: i386-randconfig-141-20251115 (https://download.01.org/0day-ci/archive/20251115/202511151652.GKPwEctt-lkp@intel.com/config)
>compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
>
>If you fix the issue in a separate patch/commit (i.e. not just a new version of
>the same patch/commit), kindly add following tags
>| Reported-by: kernel test robot <lkp@intel.com>
>| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>| Closes: https://lore.kernel.org/r/202511151652.GKPwEctt-lkp@intel.com/
>
>smatch warnings:
>mm/huge_memory.c:3696 folio_split_supported() warn: signedness bug returning '(-22)'
>
>vim +3696 mm/huge_memory.c
>
>aa27253af32c74 Wei Yang 2025-11-06  3690  bool folio_split_supported(struct folio *folio, unsigned int new_order,
>                                          ^^^^
>This is a bool function.
>
>aa27253af32c74 Wei Yang 2025-11-06  3691  		enum split_type split_type, bool warns)
>58729c04cf1092 Zi Yan   2025-03-07  3692  {
>ab62f1bb0caaa5 Wei Yang 2025-11-14  3693  	const int old_order = folio_order(folio);
>ab62f1bb0caaa5 Wei Yang 2025-11-14  3694  
>ab62f1bb0caaa5 Wei Yang 2025-11-14  3695  	if (new_order >= old_order)
>ab62f1bb0caaa5 Wei Yang 2025-11-14 @3696  		return -EINVAL;

Thanks, this is noticed.

>
>s/-EINVAL/false/
>
>ab62f1bb0caaa5 Wei Yang 2025-11-14  3697  
>58729c04cf1092 Zi Yan   2025-03-07  3698  	if (folio_test_anon(folio)) {
>58729c04cf1092 Zi Yan   2025-03-07  3699  		/* order-1 is not supported for anonymous THP. */
>58729c04cf1092 Zi Yan   2025-03-07  3700  		VM_WARN_ONCE(warns && new_order == 1,
>58729c04cf1092 Zi Yan   2025-03-07  3701  				"Cannot split to order-1 folio");
>28753037121116 Zi Yan   2025-11-05  3702  		if (new_order == 1)
>28753037121116 Zi Yan   2025-11-05  3703  			return false;
>
>-- 
>0-DAY CI Kernel Test Service
>https://github.com/intel/lkp-tests/wiki

-- 
Wei Yang
Help you, Help me

