Return-Path: <linux-fsdevel+bounces-63087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CCCBABA4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 08:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494BC3C766C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 06:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6964128D836;
	Tue, 30 Sep 2025 06:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9ip+Ggl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74697278E44;
	Tue, 30 Sep 2025 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759213026; cv=none; b=iSUlDOcAByU9QKytv/ipkF+AH6C1nIMm2+P2f6l40tdCOv/OlFK//ZaaE1lMA2WXJRJAjXa0Zu5CdzA72rx4xzG9nzqpZBmaqQ+PBuHi22VPU6CJbxeagfG/2EFUlqwrtb6u1B3xYizbRYChB/vXcE4+WodVSUPxOTOPM9WADJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759213026; c=relaxed/simple;
	bh=9dW9dVgRIEWp+8w17/mEVr0ZTr51MTZfHM6Ci1gK7HM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HejBGeQ/KTcah4sPrKGjbSs5DXz32Z4pKV4BWrXdMLfC4GCtueampFE4Mw0ZE13TGsh2fXjJzg/vVRNT13TwW0dQ8BUEY1AA6kOu9RlTV6UxVVo7nCZwyScZb9wfSpDUdayMvawabuPkpKx21JmH6jubDTtoOPY1A3kmaBXSr/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9ip+Ggl; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759213025; x=1790749025;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9dW9dVgRIEWp+8w17/mEVr0ZTr51MTZfHM6Ci1gK7HM=;
  b=M9ip+Ggl9vZHzjVGHAQAshPIRF/P9Rh6ZN98bekSVG3mBdy1GRxznz6y
   6ERVxvDTVCTiIJSYWwxRm+By2JqY5X27XI8wWVZ5ddRZYpPX77hrRqtha
   Z0pexOFe3rpRD9Pxzr3vMerh3WyEmYX71z4NuyUoITYG1ZM/rSCb261ty
   uxJNaRZztElLPfIIYBtFclKe941KI6zkI0FsH5+8JwjzohVAEh6wmgiX6
   JGEN5SR11nNorfD0tvjT3L/3/F+Timc8jgATrwcad4JSkXLfsm+qblnRk
   lZPdHr/ZmiONvoNOt4PbxLcYsIYMwgqEJXlJ3QgiGxb+lCQ3EWFUt7gGv
   Q==;
X-CSE-ConnectionGUID: XtnikK3jQJqLzkhMb4/9Ng==
X-CSE-MsgGUID: DEb6ZvYoT3uFAwI8Mr73Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="65098525"
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="65098525"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 23:17:04 -0700
X-CSE-ConnectionGUID: 3T9KxZ7xQFKRUAeanVZG1w==
X-CSE-MsgGUID: txAL0+YSTWWBe7P+42Ooog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="177683940"
Received: from alc-skl-a23.sh.intel.com (HELO [10.239.53.6]) ([10.239.53.6])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 23:17:00 -0700
Message-ID: <6bcf9dfe-c231-43aa-8b1c-f699330e143c@linux.intel.com>
Date: Tue, 30 Sep 2025 13:35:43 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/readahead: Skip fully overlapped range
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Nanhai Zou <nanhai.zou@intel.com>,
 Gang Deng <gang.deng@intel.com>, Tianyou Li <tianyou.li@intel.com>,
 Vinicius Gomes <vinicius.gomes@intel.com>,
 Tim Chen <tim.c.chen@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Roman Gushchin <roman.gushchin@linux.dev>
References: <20250923035946.2560876-1-aubrey.li@linux.intel.com>
 <20250922204921.898740570c9a595c75814753@linux-foundation.org>
 <93f7e2ad-563b-4db5-bab6-4ce2e994dbae@linux.intel.com>
 <cghebadvzchca3lo2cakcihwyoexx7fdqtibfywfm4xjo7eyp2@vbccezepgtoe>
Content-Language: en-US
From: Aubrey Li <aubrey.li@linux.intel.com>
In-Reply-To: <cghebadvzchca3lo2cakcihwyoexx7fdqtibfywfm4xjo7eyp2@vbccezepgtoe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/25 17:57, Jan Kara wrote:
> On Tue 23-09-25 13:11:37, Aubrey Li wrote:
>> On 9/23/25 11:49, Andrew Morton wrote:
>>> On Tue, 23 Sep 2025 11:59:46 +0800 Aubrey Li <aubrey.li@linux.intel.com> wrote:
>>>
>>>> RocksDB sequential read benchmark under high concurrency shows severe
>>>> lock contention. Multiple threads may issue readahead on the same file
>>>> simultaneously, which leads to heavy contention on the xas spinlock in
>>>> filemap_add_folio(). Perf profiling indicates 30%~60% of CPU time spent
>>>> there.
>>>>
>>>> To mitigate this issue, a readahead request will be skipped if its
>>>> range is fully covered by an ongoing readahead. This avoids redundant
>>>> work and significantly reduces lock contention. In one-second sampling,
>>>> contention on xas spinlock dropped from 138,314 times to 2,144 times,
>>>> resulting in a large performance improvement in the benchmark.
>>>>
>>>> 				w/o patch       w/ patch
>>>> RocksDB-readseq (ops/sec)
>>>> (32-threads)			1.2M		2.4M
>>>
>>> On which kernel version?  In recent times we've made a few readahead
>>> changes to address issues with high concurrency and a quick retest on
>>> mm.git's current mm-stable branch would be interesting please.
>>
>> I'm on v6.16.7. Thanks Andrew for the information, let me check with mm.git.
> 
> I don't expect much of a change for this load but getting test result with
> mm.git as a confirmation would be nice. Also, based on the fact that the
> patch you propose helps, this looks like there are many threads sharing one
> struct file which race to read the same content. That is actually rather
> problematic for current readahead code because there's *no synchronization*
> on updating file's readhead state. So threads can race and corrupt the
> state in interesting ways under one another's hands. On rare occasions I've
> observed this with heavy NFS workload where the NFS server is
> multithreaded. Since the practical outcome is "just" reduced read
> throughput / reading too much, it was never high enough on my priority list
> to fix properly (I do have some preliminary patch for that laying around
> but there are some open questions that require deeper thinking - like how
> to handle a situation where one threads does readahead, filesystem requests
> some alignment of the request size after the fact, so we'd like to update
> readahead state but another thread has modified the shared readahead state
> in the mean time).  But if we're going to work on improving behavior of
> readahead for multiple threads sharing readahead state, fixing the code so
> that readahead state is at least consistent is IMO the first necessary
> step. And then we can pile more complex logic on top of that.
> 

If I understand this article correctly, especially the following passage:
- https://lwn.net/Articles/888715/

"""
A core idea in readahead is to take a risk and read more than was requested.
If that risk brings rewards and the extra data is accessed, then that
justifies a further risk of reading even more data that hasn't been requested.
When performing a single sequential read through a file, the details of past
behavior can easily be stored in the struct file_ra_state. However if an
application reads from two, three, or more, sections of the file and
interleaves these sequential reads, then file_ra_state cannot keep track
of all that state. Instead we rely on the content already in the page cache.
Specifically we have a flag, PG_readahead, which can be set on a page.
That name should be read in the past tense: the page was read ahead.A risk
was taken when reading that page so, if it pays off and the page is accessed,
then that is justification for taking another risk and reading some more.
"""

file_ra_state is considered a performance hint, not a critical correctness
field. The race conditions on file's readahead state don't affect the
correctness of file I/O because later the page cache mechanisms ensure data
consistency, it won't cause wrong data to be read. I think that's why we do
not lock file_ra_state today, to avoid performance penalties on this hot path.

That said, this patch didn't make things worse, and it does take a risk but
brings the rewards of RocksDB's readseq benchmark.

Thanks,
-Aubrey

