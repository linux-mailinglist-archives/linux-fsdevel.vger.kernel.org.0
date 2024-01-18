Return-Path: <linux-fsdevel+bounces-8228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D2683122D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 05:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88D2285152
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 04:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D120F79E4;
	Thu, 18 Jan 2024 04:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eaC+mKo5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391F729A2;
	Thu, 18 Jan 2024 04:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705552782; cv=none; b=iAo9rnV+QKsBrcA4XvmSLcveFgt0FIC4piMxFpecEu7FI9CHebP1zxb5lraDbfUcGJfsj2AQHOCqwWtErAdmIa0F5UrBIz4VFkN3j1hQ8jkIcMwdqQ1T9tFdRie8XzbUWZpx/U6dWKeUnKyLmdoMLXHTpaYYdF5gaJKCPsYmjyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705552782; c=relaxed/simple;
	bh=WNBz0nAGev6j0DP23tPtu2NqwCR+QLRtNKY/oIRIW4M=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:User-Agent:MIME-Version:Content-Type; b=G3OGJqLDGzZ/+NmC8ROcRHfzVoLmYW9Wr1pkJBUQMn7tepuNyHfWbnzPZ7nk52qevLZR+CrdgAX16rgyTnYraVrSHV3VctREByXFJzHvzqNQca8BfHNgMt4WnFS3sLh34b1m5Wf4ViKDkWSuhcNui2viGEtQiu2hWKghj3Qxdb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eaC+mKo5; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705552780; x=1737088780;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=WNBz0nAGev6j0DP23tPtu2NqwCR+QLRtNKY/oIRIW4M=;
  b=eaC+mKo5/j399IO5PLQMlDI/plGuijrXP0ydOndcQkCCP8lwKNZ401Qi
   EUrV8qvN46n5YddsZLGqcFvBayfIIPeEbFsUlwmFhn9yQQxoQRUfTreOL
   6aBbbGm4g1ul3qMwhm3Z6xr7n1EgyAfnSMyA/9U1pB/IIF5nBkMJ79eZJ
   toY0yePYEdli1DnqcOCd4ZrhVSfxiJy9NZ3t7GJVtEAiKCzaskDaculRz
   7dU1XubXZCE9dl8KySMLOFitPQ/5bMN4Kh+nnjZb0tLLJg0TP1mejNCLN
   9dKnl/jCeDGlcUMscCxJILqp51OvKVMISnbXuPVQhri2pa4PNtzp5kuP4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="390796593"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="390796593"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 20:39:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="26359903"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 20:39:34 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gregory.price@memverge.com>
Cc: Gregory Price <gourry.memverge@gmail.com>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>,  <linux-doc@vger.kernel.org>,
  <linux-fsdevel@vger.kernel.org>,  <linux-api@vger.kernel.org>,
  <corbet@lwn.net>,  <akpm@linux-foundation.org>,  <honggyu.kim@sk.com>,
  <rakie.kim@sk.com>,  <hyeongtak.ji@sk.com>,  <mhocko@kernel.org>,
  <vtavarespetr@micron.com>,  <jgroves@micron.com>,
  <ravis.opensrc@micron.com>,  <sthanneeru@micron.com>,
  <emirakhur@micron.com>,  <Hasan.Maruf@amd.com>,
  <seungjun.ha@samsung.com>,  <hannes@cmpxchg.org>,
  <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/3] mm/mempolicy: implement the sysfs-based
 weighted_interleave interface
In-Reply-To: <ZagSW5TXzZeKErlW@memverge.com> (Gregory Price's message of "Wed,
	17 Jan 2024 12:46:03 -0500")
References: <20240112210834.8035-1-gregory.price@memverge.com>
	<20240112210834.8035-2-gregory.price@memverge.com>
	<87le8r1dzr.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZadkmWj3Rd483f68@memverge.com>
	<87o7dkzbsv.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZagSW5TXzZeKErlW@memverge.com>
Date: Thu, 18 Jan 2024 12:37:36 +0800
Message-ID: <87bk9jz27j.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Wed, Jan 17, 2024 at 02:58:08PM +0800, Huang, Ying wrote:
>> Gregory Price <gregory.price@memverge.com> writes:
>> 
>> > We haven't had the discussion on how/when this should happen yet,
>> > though, and there's some research to be done.  (i.e. when should DRAM
>> > weights be set? should the entire table be reweighted on hotplug? etc)
>> 
>> Before that, I'm OK to remove default_iw_table and use hard coded "1" as
>> default weight for now.
>> 
>
> Can't quite do that. default_iw_table is a static structure because we
> need a reliable default structure not subject to module initialization
> failure.  Otherwise we can end up in a situation where iw_table is NULL
> during some allocation path if the sysfs structure fails to setup fully.

As the first simplest implementation, we can avoid default_iw_table[].
Becuse it's constant.

> There's no good reason to fail allocations just because sysfs failed to
> initialization for some reason.  I'll leave default_iw_table with a size
> of MAX_NUMNODES for now (nr_node_ids is set up at runtime per your
> reference to `setup_nr_node_ids` below, so we can't use it for this).

We allocate memory during module initialization all over the places in
kernel.  I don't think it will cause any issue in practice.  Just some
additional checking for "default_iw_table == NULL".

And, we cannot make it just static, because we need to use RCU to keep
it consistent.  Otherwise, it may be changed during reading.

>> >
>> >> u8 __rcu *iw_table;
>> >> 
>> >> Then, we only need to allocate nr_node_ids elements now.
>> >> 
>> >
>> > We need nr_possible_nodes to handle hotplug correctly.
>> 
>> nr_node_ids >= num_possible_nodes().  It's larger than any possible node
>> ID.
>>
>
> nr_node_ids gets setup at runtime, while the default_iw_table needs
> to be a static structure (see above).  I can make default_iw_table
> MAX_NUMNODES and subsequent allocations of iw_table be nr_node_ids,
> but that makes iw_table a different size at any given time.
>
> This *will* break if "true hotplug" ever shows up and possible_nodes !=
> MAX_NUMNODES. But I can write it up if it's a sticking point for you.

I don't think it is an issue for "true hotplug".  Because we can set
nr_node_ids = MAX_NUMNODES even if there is something called "true
hotplug".

> Ultimately we're squabbling over, at most, about ~3kb of memory, just
> keep that in mind. (I guess if you spawn 3000 threads and each tries a
> concurrent write to sysfs/node1, you'd eat 3MB view briefly, but that
> is a truly degenerate case and I can think of more denegerate things).

Not just for memory wastage, it's about proper API too.

>> 
>> When "true node hotplug" becomes reality, we can make nr_node_ids ==
>> MAX_NUMNODES.  So, it's safe to use it.  Please take a look at
>> setup_nr_node_ids().
>> 

--
Best Regards,
Huang, Ying

