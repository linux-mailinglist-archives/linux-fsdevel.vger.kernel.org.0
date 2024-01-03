Return-Path: <linux-fsdevel+bounces-7157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3631982281C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 06:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5F41F23A90
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 05:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74EA1799A;
	Wed,  3 Jan 2024 05:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S6pasgrL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3711171CC;
	Wed,  3 Jan 2024 05:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704260943; x=1735796943;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=vSVxbwN6/wmar2Lbtj1KTSwlY+xHAKgJbZ0423wPmJs=;
  b=S6pasgrLrzYn/FDv7u7wWpoeflbdAArhcTl5hvmSUN8VnKgigOybVICz
   94/RkaGIszbP0ePkzV7vbUI3GBxoUvJcfpoLmjfVhnH58yTM4rZ8PKAnq
   Gz+XMpmMQHA62cNCi4+W8+hWhvo/v4up7VLnOeBSVNTsdw1UUAB1i5XZ8
   MGSSZdYWIOJg0siY0hhXA4AzxnAmqFjZ8DGbh59cCa21kVal+7+PdcgIV
   YkSgKbLPNWqCRMBOdc3nR1oPVgte6D4tcFfcchRXp09ou6DXfl/XQvwly
   7fV5RVbXaaOX2OAnGZdm7vqo4aCbfTzQzaeqtsd01qO2CCUqvdAKEozNB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="15604294"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="15604294"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 21:49:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="903330999"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="903330999"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 21:48:54 -0800
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
In-Reply-To: <ZZRybDPSoLme8Ldh@memverge.com> (Gregory Price's message of "Tue,
	2 Jan 2024 15:30:36 -0500")
References: <20231223181101.1954-1-gregory.price@memverge.com>
	<20231223181101.1954-3-gregory.price@memverge.com>
	<8734vof3kq.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZYp6ZRLZQVtTHest@memverge.com>
	<878r58dt31.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZZRybDPSoLme8Ldh@memverge.com>
Date: Wed, 03 Jan 2024 13:46:56 +0800
Message-ID: <87mstnc6jz.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Tue, Jan 02, 2024 at 04:42:42PM +0800, Huang, Ying wrote:
>> Gregory Price <gregory.price@memverge.com> writes:
>> 
>> > On Wed, Dec 27, 2023 at 04:32:37PM +0800, Huang, Ying wrote:
>> >> Gregory Price <gourry.memverge@gmail.com> writes:
>> >> 
>> >> > +static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
>> >> > +{
>> >> > +	nodemask_t nodemask = pol->nodes;
>> >> > +	unsigned int target, weight_total = 0;
>> >> > +	int nid;
>> >> > +	unsigned char weights[MAX_NUMNODES];
>> >> 
>> >> MAX_NUMNODSE could be as large as 1024.  1KB stack space may be too
>> >> large?
>> >> 
>> >
>> > I've been struggling with a good solution to this.  We need a local copy
>> > of weights to prevent weights from changing out from under us during
>> > allocation (which may take quite some time), but it seemed unwise to
>> > to allocate 1KB heap in this particular path.
>> >
>> > Is my concern unfounded?  If so, I can go ahead and add the allocation
>> > code.
>> 
>> Please take a look at NODEMASK_ALLOC().
>>
>
> This is not my question. NODEMASK_ALLOC calls kmalloc/kfree. 
>
> Some of the allocations on the stack can be replaced with a scratch
> allocation, that's no big deal.
>
> I'm specifically concerned about:
> 	weighted_interleave_nid
> 	alloc_pages_bulk_array_weighted_interleave
>
> I'm unsure whether kmalloc/kfree is safe (and non-offensive) in those
> contexts. If kmalloc/kfree is safe fine, this problem is trivial.
>
> If not, there is no good solution to this without pre-allocating a
> scratch area per-task.

You need to audit whether it's safe for all callers.  I guess that you
need to allocate pages after calling, so you can use the same GFP flags
here.

>> >> I don't think barrier() is needed to wait for memory operations for
>> >> stack.  It's usually used for cross-processor memory order.
>> >>
>> >
>> > This is present in the old interleave code.  To the best of my
>> > understanding, the concern is for mempolicy->nodemask rebinding that can
>> > occur when cgroups.cpusets.mems_allowed changes.
>> >
>> > so we can't iterate over (mempolicy->nodemask), we have to take a local
>> > copy.
>> >
>> > My *best* understanding of the barrier here is to prevent the compiler
>> > from reordering operations such that it attempts to optimize out the
>> > local copy (or do lazy-fetch).
>> >
>> > It is present in the original interleave code, so I pulled it forward to
>> > this, but I have not tested whether this is a bit paranoid or not.
>> >
>> > from `interleave_nid`:
>> >
>> >  /*
>> >   * The barrier will stabilize the nodemask in a register or on
>> >   * the stack so that it will stop changing under the code.
>> >   *
>> >   * Between first_node() and next_node(), pol->nodes could be changed
>> >   * by other threads. So we put pol->nodes in a local stack.
>> >   */
>> >  barrier();
>> 
>> Got it.  This is kind of READ_ONCE() for nodemask.  To avoid to add
>> comments all over the place.  Can we implement a wrapper for it?  For
>> example, memcpy_once().  __read_once_size() in
>> tools/include/linux/compiler.h can be used as reference.
>> 
>> Because node_weights[] may be changed simultaneously too.  We may need
>> to consider similar issue for it too.  But RCU seems more appropriate
>> for node_weights[].
>> 
>
> Weights are collected individually onto the stack because we have to sum
> them up before we actually apply the weights.
>
> A stale weight is not offensive.  RCU is not needed and doesn't help.

When you copy weights from iw_table[] to stack, it's possible for
compiler to cache its contents in register, or merge, split the memory
operations.  At the same time, iw_table[] may be changed simultaneously
via sysfs interface.  So, we need a mechanism to guarantee that we read
the latest contents consistently.

> The reason the barrier is needed is not weights, it's the nodemask.

Yes.  So I said that we need similar stuff for weights.

> So you basically just want to replace barrier() with this and drop the
> copy/pasted comments:
>
> static void read_once_policy_nodemask(struct mempolicy *pol, nodemask_t *mask)
> {
>         /*
>          * The barrier will stabilize the nodemask in a register or on
>          * the stack so that it will stop changing under the code.
>          *
>          * Between first_node() and next_node(), pol->nodes could be changed
>          * by other threads. So we put pol->nodes in a local stack.
>          */
>         barrier();
>         __builtin_memcpy(mask, &pol->nodes, sizeof(nodemask_t));
>         barrier();
> }
>
> - nodemask_t nodemask = pol->nodemask
> - barrier()
> + nodemask_t nodemask;
> + read_once_policy_nodemask(pol, &nodemask)
>
> Is that right?

Yes.  Something like that.  Or even more general (need to be optimized?),

static inline static void memcpy_once(void *dst, void *src, size_t n)
{
        barrier();
        memcpy(dst, src, n);
        barrier();
}

        memcpy_once(&nodemask, &pol->nodemask, sizeof(nodemask));

The comments can be based on that of READ_ONCE().

--
Best Regards,
Huang, Ying

