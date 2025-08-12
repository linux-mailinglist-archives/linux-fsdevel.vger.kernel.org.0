Return-Path: <linux-fsdevel+bounces-57453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BCFB21BE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 05:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161431A2057B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 03:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EA22DE6EA;
	Tue, 12 Aug 2025 03:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Owh/9vCF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359361DF27F;
	Tue, 12 Aug 2025 03:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754971048; cv=none; b=Uk92MvgjtbyqqjswUYAwzLq4YZuVCFCKMGWieilkGXP0x4jexmzZ+l6iHhmIzZU2flfSuAqGy+8BpUeztonKv3PVykLodk1QhnyVzhJobuaLebwPOSwYTtpt9cxcAg62BmLRWcC0OWdOFzkpmFwXY4rkPNTsxlykl3oYdow1uEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754971048; c=relaxed/simple;
	bh=1u6CtnYrRlSWb3/FRIHoEst584jU/lPlU6Z3EO67IJA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=NiqdKRT/T61UYccij7c5kSxXeXSfyl6HLP5qLAuBmwpk6ErfhdKxg5hnD7pG1DNAqu8vKEJ4GVylGa2xk6bml/GGxIgdk1mHpvP1PVapVxIYyWVF2rYcBmc50/yvRYmf8/XQL6RVJY6I6893T0VAtj1J4yYHUWy72/nyHc3ATrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Owh/9vCF; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7426c44e014so4181510b3a.3;
        Mon, 11 Aug 2025 20:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754971046; x=1755575846; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oHPrTUit6799Ukyl327yHbnkbr4IJYMNh4FvhRAhqPE=;
        b=Owh/9vCFdMoz6hNAAsHulGOCcCLVHxgsaxiZa2ayxcfhVYUzL9otbxIjBhMYUI9U8E
         qK5iL8OC68SUM4WyS39wUsEJuZPjtJ9nU+UQzun+/wgF5cbET8A6+s9UsjKeU2WCtdhK
         Q++rlHEZXWCAt9g6XtZH2bSWh9eUUaTEv+9T+6Rx9SVXaWhwxcFXCPNbiF08p+kv2VvR
         3a5XxNk44jnvpYvD6ztdlhncFleTih9ONf+BP+uhRhaVA1PZF8ycwOEOBPNAOW3gRsV9
         5Ug3302IXxIN8HNb7IRrw5sObidCInc5gntolvqyZQMIWUToy206Z7YEwAhSDl5Xz1KQ
         uT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754971046; x=1755575846;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHPrTUit6799Ukyl327yHbnkbr4IJYMNh4FvhRAhqPE=;
        b=CO/ESOtXk85D0NeS9vTArAni5oE1Y6nvUoe1o465QaaDqgU2tHYlBdWx0krF8SI/37
         SvTSVmmcHjARlckziWkdVl7Cz9BRtGtjwfUIWLpmx7bSgfjLiluX3LwLbtUwHkZCbBKB
         8p5yc0g8jsrJOQEDHdGItziXfU7+WIMmrhngRkFHLlcwDopC2pMhjQ2ArbYnFMFZMVcB
         zOJNZy78Q2sEq21CpojN4L48OZnkb3rBUL1Cku6fxxqe2D0/s6rR1hEWEU/jnOkTDcKx
         a62VFKZdtlkz8XV7nHfn37TeBLetZhlAHYrIdXFdvhZabI4C7CTBOdsPTIWxTfdS2mV0
         EiKg==
X-Forwarded-Encrypted: i=1; AJvYcCUpdTlAfblxMDTuo/zZNsV0zanZzDxH7rI+9XwQ1fOWY73DmSTq8/7pz5G3Kb9rrkNSsjDhZHwCkT+0JLToAw==@vger.kernel.org, AJvYcCV4DGNoQtpSDYIpzu87g0ywZB9B7JRv/NtqHjAgR8AB1kmx7w/vm4LUm1YrxrItB12knVEzJteh99DZlQ==@vger.kernel.org, AJvYcCVusMpXGWjFjt9Vwcdx2KxcpYprkHVPFmxfJc7JEOK/QphU5lP47H3672K6zXRMQmWCTpNlEkW4EIqAPyP5@vger.kernel.org
X-Gm-Message-State: AOJu0YyDR3Ym6HeT9jocXDqa2nR7MtlHUvA9RyF67gS/u1yYqhvGutVR
	lyLKV6Jp1mqrW17GUBC6BT4tkeoUdRiQH/1bEoPuT0dsslmSHQGuG0br
X-Gm-Gg: ASbGnctkxutF6J6WNGI39dwbLLo4mZM5YdJFGllX7DprjWiu6huE7LVI5landJWHwVe
	GGVe/fIkWy1O/Dr4tzW5i8iWtWEY2sHuduhvWQ8ZONoBBjZ4PJw0WcK/CPWKPgLM09ZCvliqDYd
	7sJY6ZJ24rpWA6CHeEWJAE6+BzshGqCN+ua3VQ/RwP7amaFuCn2vosKnF+SS4bA+VdvlswdA/VP
	CMV4hJGz31NkmgIy0yy3vxjW1HTCKbH1Hbij9GpfEtkKUtbnXIQhb0WZNpcUTWbSB96fC5Gm48r
	HhtLx5TjvPIRjfXRy7P8v3CbuuVVwm1gtR2ufUHaHg4isSPsPDmCi7sa3i+BHPPPL/snr//S8df
	2DApsMqpL190kE74=
X-Google-Smtp-Source: AGHT+IEkniR3HqY/dwK8Kl26I13c00NtfCllhZC4xMwWhoDZe02+yOvV18spWIGeG2IlgEKVjtPGFg==
X-Received: by 2002:a05:6a00:4b14:b0:76b:dee5:9af4 with SMTP id d2e1a72fcca58-76e0def6cd0mr2882742b3a.13.1754971046534;
        Mon, 11 Aug 2025 20:57:26 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfe50c8sm28095622b3a.120.2025.08.11.20.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 20:57:25 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, David Hildenbrand <david@redhat.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 0/5] add persistent huge zero folio support
In-Reply-To: <hp2wzpu3bgwqyw6almor2x6exgx7t76kch4uec5fbh3xw6sy5w@p6bvhcdhpyea>
Date: Tue, 12 Aug 2025 09:22:30 +0530
Message-ID: <87frdx5h8h.fsf@gmail.com>
References: <20250811084113.647267-1-kernel@pankajraghav.com> <hzk7e52sfhfqvo5bh7btthtyyo2tf4rwe24jxtp3fqd62vxo7k@cylwrbxqj47b> <dfb01243-7251-444c-8ac6-d76666742aa9@redhat.com> <112b4bcd-230a-4482-ae2e-67fa22b3596f@redhat.com> <hp2wzpu3bgwqyw6almor2x6exgx7t76kch4uec5fbh3xw6sy5w@p6bvhcdhpyea>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com> writes:

>> > > > Add a config option PERSISTENT_HUGE_ZERO_FOLIO that will always allocate
>> > > > the huge_zero_folio, and disable the shrinker so that huge_zero_folio is
>> > > > never freed.
>> > > > This makes using the huge_zero_folio without having to pass any mm struct and does
>> > > > not tie the lifetime of the zero folio to anything, making it a drop-in
>> > > > replacement for ZERO_PAGE.
>> > > > 
>> > > > I have converted blkdev_issue_zero_pages() as an example as a part of
>> > > > this series. I also noticed close to 4% performance improvement just by
>> > > > replacing ZERO_PAGE with persistent huge_zero_folio.
>> > > > 
>> > > > I will send patches to individual subsystems using the huge_zero_folio
>> > > > once this gets upstreamed.
>> > > > 
>> > > > Looking forward to some feedback.
>> > > 
>> > > Why does it need to be compile-time? Maybe whoever needs huge zero page
>> > > would just call get_huge_zero_page()/folio() on initialization to get it
>> > > pinned?
>> > 
>> > That's what v2 did, and this way here is cleaner.
>> 
>> Sorry, RFC v2 I think. It got a bit confusing with series names/versions.
>> 
>
> Another reason we made it a compile time config is because not all
> machines would want a PMD sized folio just for zeroing. For example,
> Dave Hansen told in one of the early revisions that a small x86 VM would
> not want this.
>
> So it is a default N, and it will be an opt-in.
>

I looked over the patches and I liked this design. This is much simpler
and cleaner compared to the initial version. 

Thanks!
-ritesh

