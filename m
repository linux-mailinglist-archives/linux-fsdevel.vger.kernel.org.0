Return-Path: <linux-fsdevel+bounces-7068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3E9821880
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 09:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B955D1F22062
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 08:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA783566B;
	Tue,  2 Jan 2024 08:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HV4RtWW3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB5563A6;
	Tue,  2 Jan 2024 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704185089; x=1735721089;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=UvmgInCVS3LhauRxpvGYGqfhEKWYPGEDg6KPf7j+yCc=;
  b=HV4RtWW3zbgsrg7xsd+HrGGdyb8HJTqDUD67gM6K7KSgE8iYYgBrfNWB
   12VNThHGdcAeyvYYkH9WfLZ4uZhsbOTBT1FFrIDTDcb3Qeqrjyn2RAnwD
   c+lOs9WPxbfDVybQQVjNuqc0fyopk7dDdiHrB9jeRZ1bv+94+s+RxcTcd
   UMLBB+hi0ntDi9Im6jSEG584jmCojHq7wu+JE+Ha4FAZIeM0xg6RjHJCt
   MLHj3M4ueAZGzuOgKLSEdkB3kES1Fp9lHcqVobepfg/uAf+ytD8tu7HE8
   sVixbqV0SxLJc+2mrrgbqja78KQM67zVenEUxJtXvlWmkuBLk+IO51qwt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="4189864"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="4189864"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 00:44:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="779632795"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="779632795"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 00:44:41 -0800
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
In-Reply-To: <ZYp6ZRLZQVtTHest@memverge.com> (Gregory Price's message of "Tue,
	26 Dec 2023 02:01:57 -0500")
References: <20231223181101.1954-1-gregory.price@memverge.com>
	<20231223181101.1954-3-gregory.price@memverge.com>
	<8734vof3kq.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZYp6ZRLZQVtTHest@memverge.com>
Date: Tue, 02 Jan 2024 16:42:42 +0800
Message-ID: <878r58dt31.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Wed, Dec 27, 2023 at 04:32:37PM +0800, Huang, Ying wrote:
>> Gregory Price <gourry.memverge@gmail.com> writes:
>> 
>> > +static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
>> > +{
>> > +	nodemask_t nodemask = pol->nodes;
>> > +	unsigned int target, weight_total = 0;
>> > +	int nid;
>> > +	unsigned char weights[MAX_NUMNODES];
>> 
>> MAX_NUMNODSE could be as large as 1024.  1KB stack space may be too
>> large?
>> 
>
> I've been struggling with a good solution to this.  We need a local copy
> of weights to prevent weights from changing out from under us during
> allocation (which may take quite some time), but it seemed unwise to
> to allocate 1KB heap in this particular path.
>
> Is my concern unfounded?  If so, I can go ahead and add the allocation
> code.

Please take a look at NODEMASK_ALLOC().

>> > +	unsigned char weight;
>> > +
>> > +	barrier();
>> 
>> Memory barrier needs comments.
>> 
>
> Barrier is to stabilize nodemask on the stack, but yes i'll carry the
> comment from interleave_nid into this barrier as well.

Please see below.

>> > +
>> > +	/* first ensure we have a valid nodemask */
>> > +	nid = first_node(nodemask);
>> > +	if (nid == MAX_NUMNODES)
>> > +		return nid;
>> 
>> It appears that this isn't necessary, because we can check whether
>> weight_total == 0 after the next loop.
>> 
>
> fair, will snip.
>
>> > +
>> > +	/* Then collect weights on stack and calculate totals */
>> > +	for_each_node_mask(nid, nodemask) {
>> > +		weight = iw_table[nid];
>> > +		weight_total += weight;
>> > +		weights[nid] = weight;
>> > +	}
>> > +
>> > +	/* Finally, calculate the node offset based on totals */
>> > +	target = (unsigned int)ilx % weight_total;
>> 
>> Why use type casting?
>> 
>
> Artifact of old prototypes, snipped.
>
>> > +
>> > +	/* Stabilize the nodemask on the stack */
>> > +	barrier();
>> 
>> I don't think barrier() is needed to wait for memory operations for
>> stack.  It's usually used for cross-processor memory order.
>>
>
> This is present in the old interleave code.  To the best of my
> understanding, the concern is for mempolicy->nodemask rebinding that can
> occur when cgroups.cpusets.mems_allowed changes.
>
> so we can't iterate over (mempolicy->nodemask), we have to take a local
> copy.
>
> My *best* understanding of the barrier here is to prevent the compiler
> from reordering operations such that it attempts to optimize out the
> local copy (or do lazy-fetch).
>
> It is present in the original interleave code, so I pulled it forward to
> this, but I have not tested whether this is a bit paranoid or not.
>
> from `interleave_nid`:
>
>  /*
>   * The barrier will stabilize the nodemask in a register or on
>   * the stack so that it will stop changing under the code.
>   *
>   * Between first_node() and next_node(), pol->nodes could be changed
>   * by other threads. So we put pol->nodes in a local stack.
>   */
>  barrier();

Got it.  This is kind of READ_ONCE() for nodemask.  To avoid to add
comments all over the place.  Can we implement a wrapper for it?  For
example, memcpy_once().  __read_once_size() in
tools/include/linux/compiler.h can be used as reference.

Because node_weights[] may be changed simultaneously too.  We may need
to consider similar issue for it too.  But RCU seems more appropriate
for node_weights[].

>> > +		/* Otherwise we adjust nr_pages down, and continue from there */
>> > +		rem_pages -= pol->wil.cur_weight;
>> > +		pol->wil.cur_weight = 0;
>> > +		prev_node = node;
>> 
>> If pol->wil.cur_weight == 0, prev_node will be used without being
>> initialized below.
>> 
>
> pol->wil.cur_weight is not used below.
>
>> > +	}
>> > +
>> > +	/* Now we can continue allocating as if from 0 instead of an offset */
>> > +	rounds = rem_pages / weight_total;
>> > +	delta = rem_pages % weight_total;
>> > +	for (i = 0; i < nnodes; i++) {
>> > +		node = next_node_in(prev_node, nodes);
>> > +		weight = weights[node];
>> > +		node_pages = weight * rounds;
>> > +		if (delta) {
>> > +			if (delta > weight) {
>> > +				node_pages += weight;
>> > +				delta -= weight;
>> > +			} else {
>> > +				node_pages += delta;
>> > +				delta = 0;
>> > +			}
>> > +		}
>> > +		/* We may not make it all the way around */
>> > +		if (!node_pages)
>> > +			break;
>> > +		/* If an over-allocation would occur, floor it */
>> > +		if (node_pages + total_allocated > nr_pages) {
>> 
>> Why is this possible?
>> 
>
> this may have been a paranoid artifact from an early prototype, will
> snip and validate.

--
Best Regards,
Huang, Ying

