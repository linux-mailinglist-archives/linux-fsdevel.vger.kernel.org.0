Return-Path: <linux-fsdevel+bounces-7441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BE9824ED9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 07:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C50D284549
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 06:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C198415EA2;
	Fri,  5 Jan 2024 06:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AyWJmm9l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574D61CA85;
	Fri,  5 Jan 2024 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704437704; x=1735973704;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=itE2hezhzcfYQfYEK/xtymd29CLOFQR5E8uwHsYdpls=;
  b=AyWJmm9lveejbxjpkpvz5fcj/hXGCiHyHBc5Yx08j9VJIh9wfTFzL7Op
   u6sX/UZU1b0MJhf6iDPxT9uWmh9YOncPmLg8EIeqj9FADVWlHkvmnpOna
   aIR036V00vKJkmiMjeyNt5bU608ADuljJBGsnjlC51Npu6rRBAw1Se5rU
   MsmsHntH565dpazd/J3U5y1qgOFtFdTQ57SGPITb1+SJZD4zwBppH5hom
   L22lgye2FSb+R38PkwFDCjvx0iLREkKDfPvrpRGicGGBBRGKqMGxXKdvt
   vF2RZTnK0lzHP48E18SHJ0FuSV29eHx+xCY9Biuam8SCgH3A02U9iH8DS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="10818749"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="10818749"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 22:53:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="773768947"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="773768947"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 22:53:38 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gregory.price@memverge.com>
Cc: Gregory Price <gourry.memverge@gmail.com>,  <linux-mm@kvack.org>,
  <linux-doc@vger.kernel.org>,  <linux-fsdevel@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-api@vger.kernel.org>,
  <x86@kernel.org>,  <akpm@linux-foundation.org>,  <arnd@arndb.de>,
  <tglx@linutronix.de>,  <luto@kernel.org>,  <mingo@redhat.com>,
  <bp@alien8.de>,  <dave.hansen@linux.intel.com>,  <hpa@zytor.com>,
  <mhocko@kernel.org>,  <tj@kernel.org>,  <corbet@lwn.net>,
  <rakie.kim@sk.com>,  <hyeongtak.ji@sk.com>,  <honggyu.kim@sk.com>,
  <vtavarespetr@micron.com>,  <peterz@infradead.org>,
  <jgroves@micron.com>,  <ravis.opensrc@micron.com>,
  <sthanneeru@micron.com>,  <emirakhur@micron.com>,  <Hasan.Maruf@amd.com>,
  <seungjun.ha@samsung.com>,  Srinivasulu Thanneeru
 <sthanneeru.opensrc@micron.com>
Subject: Re: [PATCH v5 02/11] mm/mempolicy: introduce
 MPOL_WEIGHTED_INTERLEAVE for weighted interleaving
In-Reply-To: <ZZcAF4zIpsVN3dLd@memverge.com> (Gregory Price's message of "Thu,
	4 Jan 2024 13:59:35 -0500")
References: <20231223181101.1954-1-gregory.price@memverge.com>
	<20231223181101.1954-3-gregory.price@memverge.com>
	<8734vof3kq.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZYp6ZRLZQVtTHest@memverge.com>
	<878r58dt31.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZZRybDPSoLme8Ldh@memverge.com>
	<87mstnc6jz.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZZXbN4+2nVbE/lRe@memverge.com>
	<875y09d5d8.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZZcAF4zIpsVN3dLd@memverge.com>
Date: Fri, 05 Jan 2024 14:51:40 +0800
Message-ID: <87cyugb7cz.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Thu, Jan 04, 2024 at 01:39:31PM +0800, Huang, Ying wrote:
>> Gregory Price <gregory.price@memverge.com> writes:
>> 
>> > On Wed, Jan 03, 2024 at 01:46:56PM +0800, Huang, Ying wrote:
>> >> Gregory Price <gregory.price@memverge.com> writes:
>> >> > I'm specifically concerned about:
>> >> > 	weighted_interleave_nid
>> >> > 	alloc_pages_bulk_array_weighted_interleave
>> >> >
>> >> > I'm unsure whether kmalloc/kfree is safe (and non-offensive) in those
>> >> > contexts. If kmalloc/kfree is safe fine, this problem is trivial.
>> >> >
>> >> > If not, there is no good solution to this without pre-allocating a
>> >> > scratch area per-task.
>> >> 
>> >> You need to audit whether it's safe for all callers.  I guess that you
>> >> need to allocate pages after calling, so you can use the same GFP flags
>> >> here.
>> >> 
>> >
>> > After picking away i realized that this code is usually going to get
>> > called during page fault handling - duh.  So kmalloc is almost never
>> > safe (or can fail), and we it's nasty to try to handle those errors.
>> 
>> Why not just OOM for allocation failure?
>>
>
> 2 notes:
>
> 1) callers of weighted_interleave_nid do not expect OOM conditions, they
>    expect a node selection.  On error, we would simply return the local
>    numa node without indication of failure.
>
> 2) callers of alloc_pages_bulk_array_weighted_interleave receive the
>    total number of pages allocated, and they are expected to detect
>    pages allocated != pages requested, and then handle whether to
>    OOM or simply retry (allocation may fail for a variety of reasons).
>
> By introducing an allocation into this area, if an allocation failure
> occurs, we would essentially need to silently squash it and return
> either local_node (interleave_nid) or return 0 (bulk allocator) and
> allow the allocation logic to handle any subsequent OOM condition.
>
> That felt less desirable than just allocating a scratch space up front
> in the mempolicy and avoiding the issue altogether.
>
>> > Instead of doing that, I simply chose to implement the scratch space
>> > in the mempolicy structure
>> >
>> > mempolicy->wil.scratch_weights[MAX_NUMNODES].
>> >
>> > We eat an extra 1kb of memory in the mempolicy, but it gives us a safe
>> > scratch space we can use any time the task is allocating memory, and
>> > prevents the need for any fancy error handling.  That seems like a
>> > perfectly reasonable tradeoff.
>> 
>> I don't think that this is a good idea.  The weight array is temporary.
>> 
>
> It's temporary, but it's also only used in the context of the task while
> the alloc lock is held.
>
> If you think it's fine to introduce another potential OOM generating
> spot, then I'll just go ahead and allocate the memory on the fly.
>
> I do want to point out, though, that weighted_interleave_nid is called
> per allocated page.  So now we're not just collecting weights to
> calculate the offset, we're doing an allocation (that can fail) per page
> allocated for that region.
>
> The bulk allocator amortizes the cost of this allocation by doing it
> once while allocating a chunk of pages - but the weighted_interleave_nid
> function is called per-page.
>
> By comparison, the memory cost to just allocate a static scratch area in
> the mempolicy struct is only incurred by tasks with a mempolicy.
>
>
> So we're talking ~1MB for 1024 threads with mempolicies to avoid error
> conditions mid-page-allocation and to reduce the cost associated with
> applying weighted interleave.

Think about this again.  Why do we need weights array on stack?  I think
this is used to keep weights consistent.  If so, we don't need weights
array on stack.  Just use RCU to access global weights array.

--
Best Regards,
Huang, Ying

