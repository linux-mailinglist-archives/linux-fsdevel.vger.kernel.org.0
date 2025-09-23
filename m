Return-Path: <linux-fsdevel+bounces-62479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C888B947A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 07:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE16B18A6ACD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 05:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2837309EEE;
	Tue, 23 Sep 2025 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YQrOyjIc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3ED2571C7;
	Tue, 23 Sep 2025 05:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758606755; cv=none; b=p7Sl9wQdTcTjfJ1BelBTpjDBTpuo6s/iarjV7NFstTdI7smzp9+ot27sqHnOgUjy3w8v8qNneGWvnJwQ4IhiqOAOsnerX5IiCi48/n3cVWd+pGEEuCIqijLquwZ0DoLiBsNnW8ZwggylTwPuM+3nKyvgAGD3lP2m1h5yrcPZpWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758606755; c=relaxed/simple;
	bh=Yv4vxS5FfhjU/zpDBpO1D2UxDxUcGTXGSS0bA5T5eAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qirJmDu3zT5fJ6czHjuy7lE6m3U8vaIRmH90Y+m8PTRRLwkK0Ng/Ub5dgG9eXXEspkXWjHwxWjYoHZsXl3/fxxc0QwIALlr6ziVQi2TwuLvWYeBcbVtAtT9oscTI7LRqOp10rg4nd8KB/5PU976j3DWKxcmriucelOxojim9E+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YQrOyjIc; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758606754; x=1790142754;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Yv4vxS5FfhjU/zpDBpO1D2UxDxUcGTXGSS0bA5T5eAs=;
  b=YQrOyjIcv4IeLn0IRSpIdyt0OxsaF5tbrSRQOWSAW8jmlh0BmciE/MnQ
   Pjh0ZCIafUKUjyR2zKXUhPwZusxPiNdD2hkC4i8U+/bXnXHk6JNPn9tey
   fKZic1sf7fR7yd8YV/MhgeC0I/StvQH1ZIRjkH7yfSCf0H4p6DtnzreN6
   DcYBSBK5EwdS8C8BG7MR5IhIez5ezs9UIao1S8BR4IvngX8bkbti4MVJ0
   ccPeG88GL+jJ0TOnf+2lGI9ERyZqpG5dJk+h+SQt6pfXGrHwmHJhOlRRl
   VmX2OU08BnQEABzgZNtDLU+VWEowMGK8BKv0ZHvuH2cYoldTKpYsbcTFy
   g==;
X-CSE-ConnectionGUID: 09UAVdpnRb2xJLErNKWRcg==
X-CSE-MsgGUID: /Hfo6Kw0SjyJb/rwZZTFqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="71985423"
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="71985423"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 22:52:33 -0700
X-CSE-ConnectionGUID: ey1wUJiRRRmHLQLcgAPe8Q==
X-CSE-MsgGUID: borv5jnjTHC3J6hNV2upxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="180973917"
Received: from alc-skl-a23.sh.intel.com (HELO [10.239.53.6]) ([10.239.53.6])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 22:52:30 -0700
Message-ID: <93f7e2ad-563b-4db5-bab6-4ce2e994dbae@linux.intel.com>
Date: Tue, 23 Sep 2025 13:11:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/readahead: Skip fully overlapped range
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, Nanhai Zou <nanhai.zou@intel.com>,
 Gang Deng <gang.deng@intel.com>, Tianyou Li <tianyou.li@intel.com>,
 Vinicius Gomes <vinicius.gomes@intel.com>,
 Tim Chen <tim.c.chen@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Roman Gushchin <roman.gushchin@linux.dev>
References: <20250923035946.2560876-1-aubrey.li@linux.intel.com>
 <20250922204921.898740570c9a595c75814753@linux-foundation.org>
Content-Language: en-US
From: Aubrey Li <aubrey.li@linux.intel.com>
In-Reply-To: <20250922204921.898740570c9a595c75814753@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/25 11:49, Andrew Morton wrote:
> On Tue, 23 Sep 2025 11:59:46 +0800 Aubrey Li <aubrey.li@linux.intel.com> wrote:
> 
>> RocksDB sequential read benchmark under high concurrency shows severe
>> lock contention. Multiple threads may issue readahead on the same file
>> simultaneously, which leads to heavy contention on the xas spinlock in
>> filemap_add_folio(). Perf profiling indicates 30%~60% of CPU time spent
>> there.
>>
>> To mitigate this issue, a readahead request will be skipped if its
>> range is fully covered by an ongoing readahead. This avoids redundant
>> work and significantly reduces lock contention. In one-second sampling,
>> contention on xas spinlock dropped from 138,314 times to 2,144 times,
>> resulting in a large performance improvement in the benchmark.
>>
>> 				w/o patch       w/ patch
>> RocksDB-readseq (ops/sec)
>> (32-threads)			1.2M		2.4M
> 
> On which kernel version?  In recent times we've made a few readahead
> changes to address issues with high concurrency and a quick retest on
> mm.git's current mm-stable branch would be interesting please.
> 

I'm on v6.16.7. Thanks Andrew for the information, let me check with mm.git.

Thanks,
-Aubrey


