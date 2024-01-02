Return-Path: <linux-fsdevel+bounces-7066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB51A82180E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 08:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5198D28282E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 07:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353792108;
	Tue,  2 Jan 2024 07:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CFGwhlRL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D1A53A5;
	Tue,  2 Jan 2024 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704181395; x=1735717395;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=q58h3B9SniKOzHIyVANaPPu7KXRTAPPnTDU3BqNClF4=;
  b=CFGwhlRLciEW9rMP20TaseKWinwxqez3rIYH+wrt4+ZgdGDCAXl271dB
   UqNRRbvZ5WxgLq6hp+C+xgQikOE7NuxX21itV5ikfPOPAxDYgh2vRK8Ac
   ikHKY4zUAk0EQQcjgQ20TNSLJYX4aw3BXggJN98w9W81dQb9pbCLTRQXQ
   wRjkoGloxyBHgfgVTFMKAjmV2+6tIiMLwpT548onV800STYLATN7sKcPY
   S12FvFlqKx3IlkWt+tLSb1ap25ROIM/0LiF7lxn4hczm0TQ7TGE4Mpi/A
   cL+KzejWjpzlxoQcNQzNcfRf729o8hKUpV/j1bTob0s25iy4qdhzmrykQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="381809959"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="381809959"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 23:43:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="783129772"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="783129772"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 23:43:07 -0800
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
In-Reply-To: <ZYp3JbcCPQc4fUrB@memverge.com> (Gregory Price's message of "Tue,
	26 Dec 2023 01:48:05 -0500")
References: <20231223181101.1954-1-gregory.price@memverge.com>
	<20231223181101.1954-2-gregory.price@memverge.com>
	<877cl0f8oo.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZYp3JbcCPQc4fUrB@memverge.com>
Date: Tue, 02 Jan 2024 15:41:08 +0800
Message-ID: <87h6jwdvxn.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Wed, Dec 27, 2023 at 02:42:15PM +0800, Huang, Ying wrote:
>> Gregory Price <gourry.memverge@gmail.com> writes:
>> 
>> > +		These weights only affect new allocations, and changes at runtime
>> > +		will not cause migrations on already allocated pages.
>> > +
>> > +		Writing an empty string resets the weight value to 1.
>> 
>> I still think that it's a good idea to provide some better default
>> weight value with HMAT or CDAT if available.  So, better not to make "1"
>> as part of ABI?
>> 
>
> That's the eventual goal,

Good to know this.

> but this is just the initial mechanism.
>
> My current thought is that the CXL driver will apply weights as the
> system iterates through devices and creates numa nodes.  In the
> meantime, you have to give the "possible" nodes a default value to
> prevent nodes onlined after boot from showing up with 0-value.
>
> Not allowing 0-value weights is simply easier in many respects.
>
>> > +
>> > +		Minimum weight: 1
>> 
>> Can weight be "0"?  Do we need a way to specify that a node don't want
>> to participate weighted interleave?
>> 
>
> In this code, weight cannot be 0.  My thoguht is that removing the node
> from the nodemask is the way to denote 0.
>
> The problem with 0 is hotplug, migration, and cpusets.mems_allowed.  
>
> Example issue:  Use set local weights to [1,0,1,0] for nodes [0-3],
> and has a cpusets.mems_allowed mask of (0, 2).
>
> Lets say the user migrates the task via cgroups from nodes (0,2) to
> (1,3).
>
> The task will instantly crash as basically OOM because weights of
> [1,0,1,0] will prevent memory from being allocations.
>
> Not allowing nodes weights of 0 is defensive.  Instead, simply removing
> the node from the nodemask and/or mems_allowed is both equivalent to and
> the preferred way to apply a weight of 0.

It sounds reasonable to set minimum weight to 1.  But "1" may be not the
default weight, so, I don't think it's a good idea to make "1" as
default in ABI.

>> > +		Maximum weight: 255
>> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> > index 10a590ee1c89..0e77633b07a5 100644
>> > --- a/mm/mempolicy.c
>> > +++ b/mm/mempolicy.c
>> > @@ -131,6 +131,8 @@ static struct mempolicy default_policy = {
>> >  
>> >  static struct mempolicy preferred_node_policy[MAX_NUMNODES];
>> >  
>> > +static char iw_table[MAX_NUMNODES];
>> > +
>> 
>> It's kind of obscure whether "char" is "signed" or "unsigned".  Given
>> the max weight is 255 above, it's better to use "u8"?
>>
>
> bah, stupid mistake.  I will switch this to u8.
>
>> And, we may need a way to specify whether the weight has been overridden
>> by the user.
>> A special value (such as 255) can be used for that.  If
>> so, the maximum weight should be 254 instead of 255.  As a user space
>> interface, is it better to use 100 as the maximum value?
>> 
>
> There's global weights and local weights.  These are the global weights.
>
> Local weights are stored in task->mempolicy.wil.il_weights.
>
> (policy->mode_flags & MPOL_F_GWEIGHT) denotes the override.
> This is set if (mempolicy_args->il_weights) was provided.
>
> This simplifies the interface.
>
> (note: local weights are not introduced until the last patch 11/11)

The global weight is writable via sysfs too, right?  Then, for global
weights, we have 2 sets of values,

iw_table_default[], and iw_table[].

iw_table_default[] is set to "1" now, and will be set to some other
values after we have enabled HMAT/CDAT based default value.

iw_table[] is initialized with a special value (for example, "0", if "1"
is the minimal weight).  And users can change it via sysfs.  Then the
actual global weight for a node becomes

    iw_table[node] ? : iw_table_default[node]


As for global weight and local weight, we may need a way to copy from
the global weights to the local weights to simplify the memory policy
setup.  For example, if users want to use the global weights of node 0,
1, 2 and override the weight of node 3.  They can specify some special
value, for example, 0, in mempolicy_args->il_weights[0], [1], [2] to
copy from the global values, and override [3] via some other value.


Think about the default weight value via HMAT/CDAT again.  It may be not
a good idea to use "1" as default even for now.

For example,

- The memory bandwidth of DRAM is 100GB, whose default weight is "1".

- We hot-plug CXL.mem A with memory bandwidth 20GB.  So, we change the
  weight of DRAM to 5, and use "1" as the weight of CXL.mem A.

- We hot-plug CXL.mem B with memory bandwidth 10GB.  So, we change the
  weight of DRAM to 10, the weight of CXL.mem A to 2, and use "1" as the
  weight of CXL.mem B.

That is, if we use "1" as default weight, we need to change weights of
nodes frequently because we haven't a "base" weight.  The best candidate
base weight is the weight of DRAM node.  For example, if we set the
default weight of DRAM node to be "16" and use that as the base weight,
we don't need to change it in most cases.  The weight of other nodes can
be set according to the ratio of its memory bandwidth to that of DRAM.

This makes it easy to set the default weight via HMAT/CDAT too.

What do you think about that?

>> > +
>> > +static void sysfs_mempolicy_release(struct kobject *mempolicy_kobj)
>> > +{
>> > +	int i;
>> > +
>> > +	for (i = 0; i < MAX_NUMNODES; i++)
>> > +		sysfs_wi_node_release(node_attrs[i], mempolicy_kobj);
>> 
>> IIUC, if this is called in error path (such as, in
>> add_weighted_interleave_group()), some node_attrs[] element may be
>> "NULL"?
>> 
>
> The null check is present in sysfs_wi_node_release
>
> if (!node_attr)
> 	return;

This works.  Sorry for noise.

> Is it preferable to pull this out? Seemed more defensive to put it
> inside the function.

Both are OK for me.

--
Best Regards,
Huang, Ying

