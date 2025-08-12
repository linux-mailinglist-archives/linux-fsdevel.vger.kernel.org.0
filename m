Return-Path: <linux-fsdevel+bounces-57551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E50EB230AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 19:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A10E4E369C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 17:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740B92FE562;
	Tue, 12 Aug 2025 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIMfAvgs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FE62FAC02;
	Tue, 12 Aug 2025 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021317; cv=none; b=dGS1pUbJJ8NPVR1/oPhWHAtq7oYd45+27htHQ+9J3LD2RCZWgU7D+Jvw2c5g7rBRGrYO/tzQPt4/bESaeoSckNEQITqNPgsM2kmpkM/S3cGsESj+5jKYYC+XRiaK5+quh9eg4EGKoFYzze3zDEOz2+Xmz391bK36nsc/sdjRUUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021317; c=relaxed/simple;
	bh=PQ92Ps1KLUdy3bH+AaO3wSg7T74mkl3PFwFmSqQ51gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dv/RgAt248ieoBcXEcNwN7peIwbPOL0aOWOZPrxJEA7J2ovAoIIFtvrEw+Qa+ugaqVjqpxCpNnj3hxZMHB1ZtPOeQaCZ+/gN24AJ3WFOISFbTrS2XyIFkXzpVC9xH3Qs3KgubWG9lxNglWU6oWOjpBkNQg4WcSqmeWHQHpJTpvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIMfAvgs; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24049d1643aso42781895ad.3;
        Tue, 12 Aug 2025 10:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755021316; x=1755626116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ymZGpmngRJ7fOyPoIYIbr864BuGgQbxABMyIAp/lv7M=;
        b=dIMfAvgsZ57UsrIZ4/MgyjcOdG8YzxhK0Nas9FRVyfoa2rauXWhwgCrQQkWPiuyfr5
         pAVn5/jo12mWvWYXr1VJ8SmsEJcZzb5PG9vUTA25SBUz8dLYxA/G6ChV/11T9P9V5/Gq
         J2ti1cbKEeLASNK2LG3YfrBCBlbcivrkIWoYu70QafNGOLGIshDyhFkpkFkn4wFOhIID
         hKOZwbQOWji0YKCFtfYwxqmJhB+mCEcE1BVGzRAz7Bc14IRaGZb2LedgkZq8vjZT2gJu
         HCUccuuCB6jPO7M7V5IWAQNQjMyHQ5IyaNJBu8EWHeDNVQElamvo1KKRZYM33tawYRev
         I9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021316; x=1755626116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymZGpmngRJ7fOyPoIYIbr864BuGgQbxABMyIAp/lv7M=;
        b=lcZS+ACgawfOafnK6iMaqClRXfavKqT7lR7C9wrcoZdMkqvrX3UM2Kir0JvsGJi7u/
         O7gpHZPkAAKaAE8wxAcjij5mLJcOLfGfzqzifhy7EuLYwXKPdAue8xlAQNZHZxDDX9L/
         xgAe2PhJAtPkK9vqgKfUjgO2/AA7N2vSZXR6vBoeN5/zbPRaua7r+Nv0V2uTZzn6MiZU
         wDtFBx6VXA3ayeJWe0JkXbrCnoMfWQflcKhkZ1kx4LSGs3pQASQYdWkHVRFqUBwfKbOI
         btODmDumeKlxY5ZYDJcySQLQJXOd5uj6VIEO7cTeW6SkFpTmZ9DDpM5Lgsh0saQ8EyEY
         XlMg==
X-Forwarded-Encrypted: i=1; AJvYcCV9X9vtGseMOumh1vXyMBlJlEm7FtuYQejSuaHcE70wMiya4ymOegyMCYPw8FK0T8bMqNLHwQPv++LU@vger.kernel.org, AJvYcCVVLW+aL/9tTwLzRb3JstnUaYSbMTNezFyEgF1GUUuK46Rs2he6NeTzDggx+p0SaNK/l86atLyhwEgjrxScPw==@vger.kernel.org, AJvYcCXNBj0Hh2FK4siXoah8tA3OiPXUp1mWs0KUb9yG1sJWsd107Dr+2e2R14B/TUlWP7PIVGQm028rnxlHk6aS@vger.kernel.org
X-Gm-Message-State: AOJu0YznBbzpVMU+juDv30UFxCOjg4eXiFr6fSLY6mFTTEUyk76dz/Ay
	nUNitCU3VtoWkADEoYABu3xg+g2yGtFjoC6rmSAeO9V75wfgbFWXzfbR
X-Gm-Gg: ASbGncv00eaiApbOQru2hfVXiJeZdpXIqLqbq8gotjJIH8w/KGaoF41XogA0u7Qw/Cp
	T7l16iTOLVVUv3A3arNTH+k4VmzHhDZcUMXZk/GvAmkdElWwFmVP3ZG7hgud4/Qzw6EI6X6dAhY
	Fjzuu7OAjR548qDgS1KJt1ypx2VKYeT0wv9+GUoBlR1ORicWsdas6oWlJrC7bRHFhcxSh/phls8
	zc6foWeUtcne4h2fEmPgZ2OIiqTlzxG0ZFKiDKUD14l5GUgDCTCZW1k4ZhAV9Gv/RPkK6ZkWFWK
	RRsjeDgG7lw2duMjg6GNzExqSLTnqpnFo3JSJ+XUTDTQq8o3KDNlgtBCsgjq5bKzxDJs9d1aDyo
	KsfAsPUujdCm043rXME1jeqYyTb15QcukKphut7Lq/4v2wxp/AJqf4EPOfpRPro4R
X-Google-Smtp-Source: AGHT+IE18aIbwR3kUmI00of6zx1vDAbhjJri7AMTb1JJykSzC0p6KytmOlYDyZhwco9kF97wduWaUA==
X-Received: by 2002:a17:903:2a8d:b0:243:8f:6db5 with SMTP id d9443c01a7336-2430d0a260amr1715145ad.6.1755021315592;
        Tue, 12 Aug 2025 10:55:15 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2422ba1e09csm279039935ad.16.2025.08.12.10.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:55:15 -0700 (PDT)
Date: Tue, 12 Aug 2025 10:55:11 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Qianfeng Rong <rongqianfeng@vivo.com>, SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] mm: remove redundant __GFP_NOWARN
Message-ID: <aJt__zOHjGcaghNf@fedora>
References: <20250812135225.274316-1-rongqianfeng@vivo.com>
 <b5ca3ef2-bd36-4cb5-a733-a5d4f1fb32fa@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5ca3ef2-bd36-4cb5-a733-a5d4f1fb32fa@lucifer.local>

On Tue, Aug 12, 2025 at 05:46:47PM +0100, Lorenzo Stoakes wrote:
> On Tue, Aug 12, 2025 at 09:52:25PM +0800, Qianfeng Rong wrote:
> > Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
> > GFP_NOWAIT implicitly include __GFP_NOWARN.
> >
> > Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
> > `GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
> > redundant flags across subsystems.
> >
> > No functional changes.
> >
> > Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> > Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> 
> LGTM, I wonder if there are other such redundancies in the kernel?

Looks like theres a lot left for this specific case. At least 48 show up
that are spread out across subsystems when running 'git grep
"GFP_NOWAIT.*GFP_NOWARN"'.

I think they should be cleaned up in sets per-subsystem to minimize
merge conflicts, as suggested in the commit mentioned above (16f5dfbc851b).

