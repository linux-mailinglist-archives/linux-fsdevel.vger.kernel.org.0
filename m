Return-Path: <linux-fsdevel+bounces-67424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF35C3F734
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 11:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F1B34F0486
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 10:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8618308F02;
	Fri,  7 Nov 2025 10:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W6xtD6PM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5365C308F2A;
	Fri,  7 Nov 2025 10:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511401; cv=none; b=A/o2iIvmUukNt5wty0FkWY1kaSqkCPO4Nfg/mG7eobdcv+sN8pmDtqHYgWhq96e6B9BPYbDprrJ7TL+OHuz/LJKB++GgrKjZhPA3RvXiq9NwjJObXIX4lpw5AyDjpbWwRLGck6Jy9EsArgA0nqYl/BKmYEY7oKXX9U8VV5oHlI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511401; c=relaxed/simple;
	bh=txXIGE/eQ4897oeFLXT+Tc1XOy8dh4lQrnt09P4gSbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XF0HnXBmTxtjp0k0MPocD22yiZ3F1Wr1pEK4ViUveuyF4flHfzCc4lSAffyZruuzy2qIY/hN2LTpTxw2Vv0ryK4Jqa+1tVOuz7miXGm64yVLfNuN+DYENnYnQ2GR8/lg+DFZlKuUOu/s+HTqvxx6SdqRgp7M7NDw0hKd8LWXn0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W6xtD6PM; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762511399; x=1794047399;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=txXIGE/eQ4897oeFLXT+Tc1XOy8dh4lQrnt09P4gSbQ=;
  b=W6xtD6PMmwtUVTHtRZ0cErrKyMhCZI26bQDHYFDqVC+5vR92Qq4BnTAp
   VRJO7HZ5THXO0Dk4cBkjZ60FUSCOXBKr0ZbyxTaND3dngkkSpVaEbBP3o
   p7BcY4kwgH5J/UmL90I833Fvpz9d6VvRY7jVP40BZ5PPMOt4Y4ElMEKNy
   nfprKpwkAmANEzn449nTaQYWUao5LFCJ9s8rw9SIsC+HT1pe6RN08qI4C
   TkcMnOEFKa4gyr1kOlbwkw0IRBFUKOpZWsDBZUHrx+ELi1r9r0K6RUB6C
   j7aTJxEbWsX8GHSDM8g49R+CWr1rCxp/R7ykULeLH/qNw+GUMufSS3PZ9
   A==;
X-CSE-ConnectionGUID: 649ds+HfQAys6hkY8J3zXg==
X-CSE-MsgGUID: WoK4wLPFSwWIgrEW3/Mr9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="63867832"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="63867832"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 02:29:50 -0800
X-CSE-ConnectionGUID: UneBQM/oSbub14+VgnqhBg==
X-CSE-MsgGUID: yP1jfGzpScKYNEFY2wOVfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="192268182"
Received: from alc-gnrsp.sh.intel.com (HELO [10.239.53.13]) ([10.239.53.13])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 02:29:46 -0800
Message-ID: <48341947-dd12-4a89-870d-fb73f5121888@linux.intel.com>
Date: Fri, 7 Nov 2025 18:28:00 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/readahead: Skip fully overlapped range
To: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, Nanhai Zou <nanhai.zou@intel.com>,
 Gang Deng <gang.deng@intel.com>, Tianyou Li <tianyou.li@intel.com>,
 Vinicius Gomes <vinicius.gomes@intel.com>,
 Tim Chen <tim.c.chen@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Roman Gushchin <roman.gushchin@linux.dev>
References: <20250923035946.2560876-1-aubrey.li@linux.intel.com>
 <20250922204921.898740570c9a595c75814753@linux-foundation.org>
 <93f7e2ad-563b-4db5-bab6-4ce2e994dbae@linux.intel.com>
 <cghebadvzchca3lo2cakcihwyoexx7fdqtibfywfm4xjo7eyp2@vbccezepgtoe>
 <6bcf9dfe-c231-43aa-8b1c-f699330e143c@linux.intel.com>
 <20251011152042.d0061f174dd934711bc1418b@linux-foundation.org>
 <mze6nnqy2xwwqaz5xpwkthx3x4n6yd5vgbnyateyjlyjefiwde@qclv7inpacqe>
Content-Language: en-US
From: Aubrey Li <aubrey.li@linux.intel.com>
In-Reply-To: <mze6nnqy2xwwqaz5xpwkthx3x4n6yd5vgbnyateyjlyjefiwde@qclv7inpacqe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Really sorry for the late, too. Thunderbird collapsed this thread, but didn't
highlight it as unread, I thought no one response, :(

On 10/17/25 12:21 AM, Jan Kara wrote:
> Sorry for not replying earlier. I wanted make up my mind about this and
> other stuff was keeping preempting me...
> 
> On Sat 11-10-25 15:20:42, Andrew Morton wrote:
>> On Tue, 30 Sep 2025 13:35:43 +0800 Aubrey Li <aubrey.li@linux.intel.com> wrote:
>>
>>> file_ra_state is considered a performance hint, not a critical correctness
>>> field. The race conditions on file's readahead state don't affect the
>>> correctness of file I/O because later the page cache mechanisms ensure data
>>> consistency, it won't cause wrong data to be read. I think that's why we do
>>> not lock file_ra_state today, to avoid performance penalties on this hot path.
>>>
>>> That said, this patch didn't make things worse, and it does take a risk but
>>> brings the rewards of RocksDB's readseq benchmark.
>>
>> So if I may summarize:
>>
>> - you've identifed and addressed an issue with concurrent readahead
>>   against an fd
> 
> Right but let me also note that the patch modifies only
> force_page_cache_ra() which is a pretty peculiar function. It's used at two
> places:
> 1) When page_cache_sync_ra() decides it isn't worth to do a proper
> readahead and just wants to read that one one.
> 
> 2) From POSIX_FADV_WILLNEED - I suppose this is Aubrey's case.
> 
> As such it seems to be fixing mostly a "don't do it when it hurts" kind of
> load from the benchmark than a widely used practical case since I'm not
> sure many programs call POSIX_FADV_WILLNEED from many threads in parallel
> for the same range.
> 
>> - Jan points out that we don't properly handle concurrent access to a
>>   file's ra_state.  This is somewhat offtopic, but we should address
>>   this sometime anyway.  Then we can address the RocksDB issue later.
>>
>> Another practicality: improving a benchmark is nice, but do we have any
>> reasons to believe that this change will improve any real-world
>> workload?  If so, which and by how much?

I only have RocksDB on my side, but this isn't a lab case but a real case.
It's an issue reported by a customer. They use this case to stress test the
system under high-concurrency data workloads, it could have business impact.

> 
> The problem I had with the patch is that it adds more racy updates & checks
> for the shared ra state so it's kind of difficult to say whether some
> workload will not now more often clobber the ra state resulting in poor
> readahead behavior. Also as I looked into the patch now another objection I
> have is that force_page_cache_ra() previously didn't touch the ra state at
> all, it just read the requested pages. After the patch
> force_page_cache_ra() will destroy the readahead state completely. This is
> definitely something we don't want to do.

This is also something I worried about, so I added two trace points at the
entry and exit of force_page_cache_ra(), and I got all ZEROs.

test-9858    [018] .....   554.352691: force_page_cache_ra: force_page_cache_ra entry: ra->start = 0, ra->size = 0
test-9858    [018] .....   554.352695: force_page_cache_ra: force_page_cache_ra exit: ra->start = 0, ra->size = 0
test-9855    [009] .....   554.352701: force_page_cache_ra: force_page_cache_ra entry: ra->start = 0, ra->size = 0
test-9855    [009] .....   554.352705: force_page_cache_ra: force_page_cache_ra exit: ra->start = 0, ra->size = 0

I think for this code path, my patch doesn't break anything. Do we have any
other code paths I can check?

Anyway, thanks Andrew and Jan for the detailed feedback and discussion. if
we later plan to make file_ra_state concurrency-safe first, I'd be happy to
help test or rebase this optimization on top of that work.

Thanks,
-Aubrey

