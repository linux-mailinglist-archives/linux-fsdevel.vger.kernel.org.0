Return-Path: <linux-fsdevel+bounces-17381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7868AC620
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 09:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 761B4B21EFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 07:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48AE4DA0F;
	Mon, 22 Apr 2024 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VpTDjf5j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986C24CB35;
	Mon, 22 Apr 2024 07:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772616; cv=none; b=uSRrlcOBnt1kHFQwvgQ0v+fQ5AYy8De4BBs4JWvqmLgBXoEjZdVFzQ5JUMo728c/4zXK6B4jsTWVF34xn3jd6JU8WEhDR7/YPLqHhe3sy9fdceMMf9FP5ubS+mh436Jl6eoUPvm+9LcFh2oIzIIDDXr6VTtJau9Cg8ywzzGcL/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772616; c=relaxed/simple;
	bh=ReeVKZSFAA2TgPLpJsgH6vWWoeK6ccoz8J1wehOOJc4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fHivx7rH1uZVi+bigB0Q83O7mLJ+JCG3NP9gV0OC8shPSZ78E9Kn1FitJbHwSQr7NH9QaI1CeothHiVRxzhg8/mAmsgqjoc6G9N/hqsYSG9JSmrkmWWhh3T8KGzecv9ERtDStiwq2Kd+MS6WZNQa7pFKu4+aaCaQgDa2pBs8qv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VpTDjf5j; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713772614; x=1745308614;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ReeVKZSFAA2TgPLpJsgH6vWWoeK6ccoz8J1wehOOJc4=;
  b=VpTDjf5jE4SdFYGRJM1J5rjJFewlkwVgYKOoDNkjsUitV5+rhDzDkeRZ
   F9zB2mUDGlTWV9d8n+R2KMX/CvHw8Chc58elj0wG0koL7fDd76yCCOWz3
   hFqxEnx6/ZwkliKRgTWKrF8wTGVGyn8iRC9+nWQDdTmkNak2Q3UmOfxJR
   ImESskXZmtx4ZBzLf9twbsPGVNj+qJdrdOEzc4WXq63dyTdcT7RvTFRd+
   0loWMjZrDryplXjUuYXxWqc0Nl4rzLMc+riGTBI6d94j4N9p6AjSkla4c
   SJm9nUY6tGNpzvyR/sRiBzzS60bJH89QqJInBz+zyGn1qazohsabtVWOj
   Q==;
X-CSE-ConnectionGUID: i94jb0COSDOmwVJLm0wqqQ==
X-CSE-MsgGUID: B3vzWeF3QDeEqHqxIBV06g==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="20437638"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="20437638"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 00:56:53 -0700
X-CSE-ConnectionGUID: MMO+r1HCTdmStEKaAQMcDw==
X-CSE-MsgGUID: svSs77+HQy2ghrhGboEg2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="24015095"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 00:56:50 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Chris Li <chrisl@kernel.org>,  Barry Song
 <v-songbaohua@oppo.com>,  Ryan Roberts <ryan.roberts@arm.com>,  Neil Brown
 <neilb@suse.de>,  Minchan Kim <minchan@kernel.org>,  Hugh Dickins
 <hughd@google.com>,  David Hildenbrand <david@redhat.com>,  Yosry Ahmed
 <yosryahmed@google.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] mm/swap: optimize swap cache search space
In-Reply-To: <20240417160842.76665-1-ryncsn@gmail.com> (Kairui Song's message
	of "Thu, 18 Apr 2024 00:08:34 +0800")
References: <20240417160842.76665-1-ryncsn@gmail.com>
Date: Mon, 22 Apr 2024 15:54:58 +0800
Message-ID: <87zftlx25p.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Kairui,

Kairui Song <ryncsn@gmail.com> writes:

> From: Kairui Song <kasong@tencent.com>
>
> Currently we use one swap_address_space for every 64M chunk to reduce lock
> contention, this is like having a set of smaller swap files inside one
> big swap file. But when doing swap cache look up or insert, we are
> still using the offset of the whole large swap file. This is OK for
> correctness, as the offset (key) is unique.
>
> But Xarray is specially optimized for small indexes, it creates the
> redix tree levels lazily to be just enough to fit the largest key
> stored in one Xarray. So we are wasting tree nodes unnecessarily.
>
> For 64M chunk it should only take at most 3 level to contain everything.
> But we are using the offset from the whole swap file, so the offset (key)
> value will be way beyond 64M, and so will the tree level.
>
> Optimize this by reduce the swap cache search space into 64M scope.

In general, I think that it makes sense to reduce the depth of the
xarray.

One concern is that IIUC we make swap cache behaves like file cache if
possible.  And your change makes swap cache and file cache diverge more.
Is it possible for us to keep them similar?

For example,

Is it possible to return the offset inside 64M range in
__page_file_index() (maybe rename it)?

Is it possible to add "start_offset" support in xarray, so "index"
will subtract "start_offset" before looking up / inserting?

Is it possible to use multiple range locks to protect one xarray to
improve the lock scalability?  This is why we have multiple "struct
address_space" for one swap device.  And, we may have same lock
contention issue for large files too.

I haven't look at the code in details.  So, my idea may not make sense
at all.  If so, sorry about that.

Hi, Matthew,

Can you teach me on this too?

--
Best Regards,
Huang, Ying

