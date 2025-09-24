Return-Path: <linux-fsdevel+bounces-62537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5BBB97F7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 03:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4212E4292
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 01:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197061F4CB3;
	Wed, 24 Sep 2025 01:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VONOA13D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD331EE7DC;
	Wed, 24 Sep 2025 01:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758676120; cv=none; b=fd8D3Hngw9Mb1bvFvcVAHSQ4Q/d5a+GQqm4IJ8furNM/0cbfUkgu0qgxIPdmzBKA90ABF/8CRDPXOvHJPWb7CRar4nEFCLKozjej0u1zXFUuNs41Oob1R6x8wH02wQW42rRC2qVR3A2w9N4jvObWCiJZ1BlhOvYHNHVwsmdwf5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758676120; c=relaxed/simple;
	bh=NMr8YHsAc1qYXXZdTcENL3OIhnYEafGh+AtSGRf6TLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgTLpOi6M5qaMY0dbDScLhkQnxIVUvyJn2wODC7raqXfwTwURv+ejB7IwLfyBaqbSGMAy5FfS9rAhKU6xGh7snAxkAlYkQh0koFeVb7euNKtwrYfDJ9ufbg8rMA4lS8sIot3bJInIOAE4ZIHo1J9WmNl9h7a5KSPSjxSvbcKZ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VONOA13D; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758676118; x=1790212118;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NMr8YHsAc1qYXXZdTcENL3OIhnYEafGh+AtSGRf6TLc=;
  b=VONOA13DVQK8LRrcJpWI69WgbqYFcXN0aHxQ0ZW91dIjxBzWBc9cW64n
   j7WGH53MAqXmwNnYbf4H3gRJFSLCx//E3FSD8+3evY3Qzh6a5eMDXKWa3
   1XH0u04KR0sLuwm6Xex9NknfR0yMn+M3r7b0tQKE/s/zVgyw+iAt2BhK+
   oti/psWpXB2NOrRGyRuvQ8dLoHYJgpnKqfvlPbNnTYQBwvn2VueZx/Q0Q
   rD5Z7DPE/WK5uo5zG7xqY+o8X+N3firvwxUIJyB09Jnp5We1VR4mh687N
   k8D41rYE967HFXDZpLLUFoo2O/ti0vLrr4fnrw9sF8mkCDi6uEmyeoJLL
   Q==;
X-CSE-ConnectionGUID: 4gXmTAcnSEWR+wo4jpYy8A==
X-CSE-MsgGUID: cg5Yij6FTiybfhAxGs1Dhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="72391785"
X-IronPort-AV: E=Sophos;i="6.18,289,1751266800"; 
   d="scan'208";a="72391785"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 18:08:37 -0700
X-CSE-ConnectionGUID: fjBTYTLDSiCoIsBzqV7wMQ==
X-CSE-MsgGUID: IyKXHQQ5TJ+72htfqHKDig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,289,1751266800"; 
   d="scan'208";a="214035413"
Received: from alc-skl-a23.sh.intel.com (HELO [10.239.53.6]) ([10.239.53.6])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 18:08:35 -0700
Message-ID: <c7ac8e6f-d24c-4a13-b9a4-c5bd287e9f9f@linux.intel.com>
Date: Wed, 24 Sep 2025 08:27:39 +0800
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
> mm.git as a confirmation would be nice. 

Yes, the hotspot remains on mm.git:mm-stable branch.

   - 88.68% clone3
      - 88.68% start_thread
         - 88.68% reader_thread
            - 88.27% syscall
                 entry_SYSCALL_64_after_hwframe
                 do_syscall_64
                 ksys_readahead
                 generic_fadvise
                 force_page_cache_ra
                 page_cache_ra_unbounded
                 filemap_add_folio
                 __filemap_add_folio
                 _raw_spin_lock_irq
               - do_raw_spin_lock
                    native_queued_spin_lock_slowpath

> Also, based on the fact that the
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

This makes sense. I actually had a version using atomic operations to update
ra in my patch, but I found that ra is also updated in other paths without
synchronization, so I dropped the atomic operations before sending the patch.
Let me check what I can do for this.

Have you put your preliminary patch somewhere?

Thanks,
-Aubrey
> 
> 								Honza


