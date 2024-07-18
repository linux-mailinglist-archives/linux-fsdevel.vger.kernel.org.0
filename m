Return-Path: <linux-fsdevel+bounces-23911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CF5934ADC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 11:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F1D7B2271D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 09:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F05384DE4;
	Thu, 18 Jul 2024 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NUEZD7rY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6354328DD1
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721294751; cv=none; b=GeOk/eIY1mwu2j2sDMrfAt6CBj58HIPEM2WSv9M+ZAUhTxGYNKXM8/zJ5RrZ2AWrHHNGx1VN4wE+TElbjDUpTEBzbn3XcAkKPF+7dCXieDh0OBil6H1Fxa7lhq8BNNF6hMNIAftdwU6qhvAnMLMBBlw+RqRZPa+g6ksigshYl/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721294751; c=relaxed/simple;
	bh=XdUs22hWj4yPiEVcEpPwpByY3n2QmXcOM+pCzJhqQyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOarCT5JXy5GR51GDSWYRDGssTrxC6+T0gCrtUW9tXvTZc0QbjAicUKw6UQylJoS3xazZkZyfZAQtfOjH3eaES1+GRMbXUYFcK1UTNM1ackYFWc4aXXzi+CCatKz1qUhWIQV/ztVe1IauLc0KRe0fxa0Xp/SRiIgdmg7YLvaW7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NUEZD7rY; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a77b60cafecso49524466b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 02:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721294748; x=1721899548; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+AQXyp5zTd9VUi1GRGHEcdKdd16XlM0Bs2GIA+qkJx8=;
        b=NUEZD7rYYhbHJvg00+12T6yI0Dhi6ebKjYapnfLYAVjXGXagq8C4R3u9/NiDAEPO5v
         HQycH/h7tgielbUKpaoqELX1x6d6Foa5JNn+sQjnHShM9YNoyZtIgByNNpUEtmQd2C0c
         vhdPlLxfHMRWt7X3Yqin4op/NhZxuFfJ3KLnV96uqbM4YTZayZmYKAk7CVzoXrE20p0X
         +6OER3foYqBX3wnaH7zRVyqcNDuYoNjrkKDU8XyT1UvLt++Li1O56QFltslBPEtTqD5z
         wgZKfXWPwZGvlKgBwIRKPv43oi8V97UBfjAMzOuYnaAq7AuPhJbmd2DIf02+IXElI5Nh
         Xv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721294748; x=1721899548;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+AQXyp5zTd9VUi1GRGHEcdKdd16XlM0Bs2GIA+qkJx8=;
        b=itOCTuvuSFYTTgRqAY/TrXEAgtLaR5vaz2hdjlKaaTp+TSJWsm+IQKNxjdu/kHusUu
         kHhIiiC5eyDMyFWicgEFL/Vb662cULD0KlcuOjilVyCmLOoW9fZbAjc9YyMfgqwXFpSD
         yrCH7pW7o6vyZohrZCwGnTckYygpuk9YbVGcaYCoK/kKKn+7h16XUPJKn5S1BNxklA1Y
         C60omBsmA5oqDmHVch47EMMwdsVPIcoHtUedIup05+2BQqNGJM26d5GSzZEQYTlpVa6M
         KrLHWm5/zqLP2OUNJw+mwChPaGE3UvnAusnQzREf9jd8jW3YbFNvt3l5KkXhWXW4prT2
         rMrg==
X-Forwarded-Encrypted: i=1; AJvYcCX3k7KyVtEeO/JIteejQ90DeYB9Dli21neVgSy0sQLi9bMOWNaN3O5WprkXT0m2msUxo7RFQeCe4JKBiXToNUfmr1D3K1HbKlgBSzO8Ww==
X-Gm-Message-State: AOJu0YxuVRyVQsZnCp4Y6gyzAfGuGJ/bnd0R1Ts6AHUHGehNitz7mU2l
	0R7FvLCTtGkTggPARMUhhYGNcVkFcEafQILHQ7w4pWMLZsawdQkfsPRKr6VoJSY=
X-Google-Smtp-Source: AGHT+IFcIaqSCi+C+Us2/WOlLLOFk4vnRTB+ewPkaisAHCGngBiHg0I8w89X2OGpWh4lJCiAB53pmw==
X-Received: by 2002:a17:906:3b87:b0:a6f:593f:d336 with SMTP id a640c23a62f3a-a7a01138dd4mr273782966b.11.1721294747674;
        Thu, 18 Jul 2024 02:25:47 -0700 (PDT)
Received: from localhost (109-81-94-157.rct.o2.cz. [109.81.94.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7ff61bsm544875666b.166.2024.07.18.02.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 02:25:47 -0700 (PDT)
Date: Thu, 18 Jul 2024 11:25:46 +0200
From: Michal Hocko <mhocko@suse.com>
To: Qu Wenruo <wqu@suse.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Cgroups <cgroups@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 0/2] mm: skip memcg for certain address space
Message-ID: <ZpjfmlsikKCKWqOb@tiehlicka>
References: <cover.1720572937.git.wqu@suse.com>
 <8faa191c-a216-4da0-a92c-2456521dcf08@kernel.org>
 <Zpft2A_gzfAYBFfZ@tiehlicka>
 <9c0d7ce7-b17d-4d41-b98a-c50fd0c2c562@gmx.com>
 <9572fc2b-12b0-41a3-82dc-bb273bfdd51d@kernel.org>
 <ZpjDeSrZ40El5ALW@tiehlicka>
 <304fdaa9-81d8-40ae-adde-d1e91b47b4c0@suse.com>
 <ZpjNuWpzH9NC5ni6@tiehlicka>
 <da00aadb-e686-4c47-80fe-cb26f928cf32@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da00aadb-e686-4c47-80fe-cb26f928cf32@suse.com>

On Thu 18-07-24 18:22:11, Qu Wenruo wrote:
> 
> 
> 在 2024/7/18 17:39, Michal Hocko 写道:
> > On Thu 18-07-24 17:27:05, Qu Wenruo wrote:
> > > 
> > > 
> > > 在 2024/7/18 16:55, Michal Hocko 写道:
> > > > On Thu 18-07-24 09:17:42, Vlastimil Babka (SUSE) wrote:
> > > > > On 7/18/24 12:38 AM, Qu Wenruo wrote:
> > > > [...]
> > > > > > Does the folio order has anything related to the problem or just a
> > > > > > higher order makes it more possible?
> > > > > 
> > > > > I didn't spot anything in the memcg charge path that would depend on the
> > > > > order directly, hm. Also what kernel version was showing these soft lockups?
> > > > 
> > > > Correct. Order just defines the number of charges to be reclaimed.
> > > > Unlike the page allocator path we do not have any specific requirements
> > > > on the memory to be released.
> > > 
> > > So I guess the higher folio order just brings more pressure to trigger the
> > > problem?
> > 
> > It increases the reclaim target (in number of pages to reclaim). That
> > might contribute but we are cond_resched-ing in shrink_node_memcgs and
> > also down the path in shrink_lruvec etc. So higher target shouldn't
> > cause soft lockups unless we have a bug there - e.g. not triggering any
> > of those paths with empty LRUs and looping somewhere. Not sure about
> > MGLRU state of things TBH.
> > > > > > And finally, even without the hang problem, does it make any sense to
> > > > > > skip all the possible memcg charge completely, either to reduce latency
> > > > > > or just to reduce GFP_NOFAIL usage, for those user inaccessible inodes?
> > > > 
> > > > Let me just add to the pile of questions. Who does own this memory?
> > > 
> > > A special inode inside btrfs, we call it btree_inode, which is not
> > > accessible out of the btrfs module, and its lifespan is the same as the
> > > mounted btrfs filesystem.
> > 
> > But the memory charge is attributed to the caller unless you tell
> > otherwise.
> 
> By the caller, did you mean the user space program who triggered the
> filesystem operations?

Yes, the current task while these operations are done.

[...]
> > So if this is really an internal use and you use a shared
> > infrastructure which expects the current task to be owner of the charged
> > memory then you need to wrap the initialization into set_active_memcg
> > scope.
> > 
> 
> And for root cgroup I guess it means we will have no memory limits or
> whatever, and filemap_add_folio() should always success (except real -ENOMEM
> situations or -EEXIST error btrfs would handle)?

Yes. try_charge will bypass charging altogether for root cgroup. You
will likely need to ifdef root_mem_cgroup usage by CONFIG_MEMCG.

-- 
Michal Hocko
SUSE Labs

