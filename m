Return-Path: <linux-fsdevel+bounces-7159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F8182283C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 07:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A22284FDF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 06:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461D7179AB;
	Wed,  3 Jan 2024 06:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YB6gIyGt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40E21798F;
	Wed,  3 Jan 2024 06:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704261915; x=1735797915;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=SADNmv801L5zzCHLukWFMJZ5+gmmqGnOCeM/xTkND3M=;
  b=YB6gIyGtAe9joZUQwDT841tGd7wNo4+NaNpZ4I3mGzQ1jKiWNaGo9Jrm
   86fidOpT0ZDRHDQF9f949kyy8RkvApX+bm19mzDWeqdq6G94rs7ZwT0DR
   M4K2V5Bn23T7d+tiuwK7A9ElaoxavXbv1vuI+cMDqZm0+EUoFeGynBrHg
   qbod+YWINpNNcaRuVeaAYrFje+CO10z2Myymgb+Bo7pOiHUtHgeYAhbwB
   0VwKOoQ3YCKhPQ01tGdVCPfhYCmUBoHEk6IxYPIopYfOz8udW22a8RcLH
   SC/xaVDo9BDgyRpKswpetemEDQbABEMs2lpO3OQYFnutKfqC55StGwfPr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="400770887"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="400770887"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 22:05:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="808732507"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="808732507"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 22:05:07 -0800
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
  <seungjun.ha@samsung.com>
Subject: Re: [PATCH v5 01/11] mm/mempolicy: implement the sysfs-based
 weighted_interleave interface
In-Reply-To: <ZZTNpGhj8EmYBB70@memverge.com> (Gregory Price's message of "Tue,
	2 Jan 2024 21:59:48 -0500")
References: <20231223181101.1954-1-gregory.price@memverge.com>
	<20231223181101.1954-2-gregory.price@memverge.com>
	<877cl0f8oo.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZYp3JbcCPQc4fUrB@memverge.com>
	<87h6jwdvxn.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZZRn04IiZhet8peu@memverge.com>
	<87wmsrcexq.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZZTNpGhj8EmYBB70@memverge.com>
Date: Wed, 03 Jan 2024 14:03:09 +0800
Message-ID: <87il4bc5sy.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Wed, Jan 03, 2024 at 10:45:53AM +0800, Huang, Ying wrote:
>> 
>> > The minimum functionality is everything receiving a default weight of 1,
>> > such that weighted interleave's behavior defaults to round-robin
>> > interleave. This gets the system off the ground.
>> 
>> I don't think that we need to implement all functionalities now.  But,
>> we may need to consider more especially if it may impact the user space
>> interface.  The default base weight is something like that.  If we
>> change the default base weight from "1" to "16" later, users may be
>> surprised.  So, I think it's better to discuss it now.
>>
>
> This is a hill I don't particularly care to die on.  I think the weights
> are likely to end up being set at boot and rebalanced as (rare) hotplug
> events occur.
>
> So if people think the default weight should be 3,16,24 or 123, i don't
> think it's going to matter.
>
>> 
>> We can use a wrapper function to hide the logic.
>>
>
> Done.  I'll push a new set tomorrow.
>
>> > I think it also allows MPOL_F_GWEIGHT to be eliminated.
>> 
>> Do we need a way to distinguish whether to copy the global weights to
>> local weights when the memory policy is created?  That is, when the
>> global weights are changed later, will the changes be used?  One
>> possible solution is
>> 
>> - If no weights are specified in set_mempolicy2(), the global weights
>>   will be used always.
>> 
>> - If at least one weight is specified in set_mempolicy2(), it will be
>>   used, and the other weights in global weights will be copied to the
>>   local weights.  That is, changes to the global weights will not be
>>   used.
>> 
>
> What's confusing about that is that if a user sets a weight to 0,
> they'll get a non-0 weight - always.
>
> In my opinion, if we want to make '0' mean 'use system default', then
> it should mean 'ALWAYS use system default for this node'.
>
> "Use the system default at the time the syscall was called, and do not
> update to use a new system default if that default is changed" is
> confusing.
>
> If you say use a global value, use the global value. Simple.

I mainly have concerns about consistency.  The global weights can be
changed while the local weights are fixed.  For example,

- Weights of node 0,1 is [3, 1] initially

- Process A call set_mempolicy2() to set weights to [4, 0], that is, use
  default weight for node 1.

- After hotplug, the weights of node is changed to [12, 4, 1], now the
  effective weights used in process A becomes [4, 4].  Which is hardly
  desired.

Another choice is to disallow "0" as weight in set_mempolicy2().

--
Best Regards,
Huang, Ying

