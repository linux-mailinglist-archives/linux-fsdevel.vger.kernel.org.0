Return-Path: <linux-fsdevel+bounces-18205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D21518B680D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 04:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05F6FB229BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 02:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA44DDDA1;
	Tue, 30 Apr 2024 02:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nf8xn/Hn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2D98BF0;
	Tue, 30 Apr 2024 02:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714445231; cv=none; b=nfvCizAR7iz+aljO7dTvuc04+pW/l8mB8p/kTx2awDLwhE3dKJaCbczR1lm56zYvpaZ5l+ZtMdvL7edV03HdC8xN1T5hz4L1sso/20xmRROyYJGzGn5HxMiO5tKM/MnUWBrfBl6CtHFco9SA5XdQLVNa9J71hwzVee5rsZl+qm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714445231; c=relaxed/simple;
	bh=yqRlHXGI+zcTHcl60c+dVEfZpC96njB3zGx9BPPWpyg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N1FeYycjWyYNOgO/SPNnOMnhzi8JMti0fAffR/ITaLjFZklIehqGb7laRSUqspYhkDHALLOCYaIdkTJKPn+5MopuJ7N5fPIZ8oeu0i6ENlkgRmU4oQqH2EqteofIo0D9W6Jc7/iu+H3txW77J0fbKir3GJFCyC+0Gbs1Bb14NXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nf8xn/Hn; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714445230; x=1745981230;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=yqRlHXGI+zcTHcl60c+dVEfZpC96njB3zGx9BPPWpyg=;
  b=nf8xn/Hn2A2mjAlmGHwGowUFH2D8BH0gNjMz/dJFP7/Ud+XQaXMJETxX
   Y407l4UbB/6H9OSynPFdCUuYGeUyIyOQHRrWaQLe49xpqmu++fr6utKDb
   4A1WoCsabo5HVJRmh51VNsw0oNFDFj1DmED5CNiA0hMhLb1grymiRnPPY
   eBtH92AhACwA+Zt7yn7JcaWzHWrzTjkZE/b0J1BEsuKK1oYBQ3rUM0/0f
   OG0n5++ewkDzyzWLIq91WgTWSZFTZAq/E9xJJPBuGR7ACkcYjANiOxbNG
   +HEiHYEP7zThcH19yufbRlYPdx/iOfLxhBcR2B8BOJt+zdGUPckXL1wbr
   A==;
X-CSE-ConnectionGUID: y8/1VuexTFCgV9XxYwGgjQ==
X-CSE-MsgGUID: gZLmWYNXQZKtidZ6HvEG3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10666425"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="10666425"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 19:47:08 -0700
X-CSE-ConnectionGUID: l0ZOVuTRSqOpBTV3PCQXvg==
X-CSE-MsgGUID: WzMZV+kwTUyKYbiPKL8ypA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26379156"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 19:47:05 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Matthew Wilcox <willy@infradead.org>,  Chris
 Li <chrisl@kernel.org>,  Barry Song <v-songbaohua@oppo.com>,  Ryan Roberts
 <ryan.roberts@arm.com>,  Neil Brown <neilb@suse.de>,  Minchan Kim
 <minchan@kernel.org>,  Hugh Dickins <hughd@google.com>,  David Hildenbrand
 <david@redhat.com>,  Yosry Ahmed <yosryahmed@google.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/12] mm/swap: clean up and optimize swap cache index
In-Reply-To: <20240429190500.30979-1-ryncsn@gmail.com> (Kairui Song's message
	of "Tue, 30 Apr 2024 03:04:48 +0800")
References: <20240429190500.30979-1-ryncsn@gmail.com>
Date: Tue, 30 Apr 2024 10:45:12 +0800
Message-ID: <8734r3muvb.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Kairui Song <ryncsn@gmail.com> writes:

> From: Kairui Song <kasong@tencent.com>
>
> This is based on latest mm-unstable. Patch 1/12 might not be needed if
> f2fs converted .readahead to use folio, I included it for easier test
> and review.
>
> Currently we use one swap_address_space for every 64M chunk to reduce lock
> contention, this is like having a set of smaller swap files inside one
> big swap file.

I would rather to say,

"
this is like having a set of smaller files inside a swap device.
"

To avoid possible confusing in this series.  I suggest to avoid to say
"swap file".  Instead, we can use "swap device".

[snip]

--
Best Regards,
Huang, Ying

