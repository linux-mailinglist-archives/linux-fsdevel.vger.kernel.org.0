Return-Path: <linux-fsdevel+bounces-6539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E168196D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 03:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1710B24993
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 02:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34858BF9;
	Wed, 20 Dec 2023 02:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hO2svIY8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE278827;
	Wed, 20 Dec 2023 02:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703039356; x=1734575356;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=5P8valVma7379oKA2C4O5u8JYMU/WxLyLWS4JRVSF50=;
  b=hO2svIY8Cqn1Ir3XfrM5pb+m9HJ7Oi4DBmlMNGch9BXTmB9qVXykW4fR
   cIPShyDvi7OwoXInVlLEoRuzGjr6NMe6RDP6+J/VtkECVmuvULc+Z+ZGL
   kHwGUT/Fy4MOgUSGtmVU0fGh/wa3QOsGhVLBFRuaYbbO8ZftSOt0eWp6M
   YkOUXvE7LqnztJAUAs1xzkP1STrb3a0L1vp+S1bIUtSMob9OmDfqyGJGn
   b0tzqKd1FBOEXKl8oaHTIX8i75vN7KfKZPNuJl4RpeHpslqjR9JsfzsYS
   dJ34AxdBq9oN3uz/ku0DILZxu6JKv+o0G4BvPs/tH3FGme9/oZ/MP6KDg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="481940572"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="481940572"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 18:29:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="949378315"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="949378315"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 18:29:06 -0800
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
  <seungjun.ha@samsung.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Hasan
 Al Maruf <hasanalmaruf@fb.com>,  Hao Wang <haowang3@fb.com>,  Dan Williams
 <dan.j.williams@intel.com>,  "Michal Hocko" <mhocko@suse.com>,  Zhongkun
 He <hezhongkun.hzk@bytedance.com>,  "Frank van der Linden"
 <fvdl@google.com>,  John Groves <john@jagalactic.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 00/11] mempolicy2, mbind2, and weighted interleave
In-Reply-To: <ZYHcPiU2IzHr/tbQ@memverge.com> (Gregory Price's message of "Tue,
	19 Dec 2023 13:09:02 -0500")
References: <20231218194631.21667-1-gregory.price@memverge.com>
	<87wmtanba2.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZYHcPiU2IzHr/tbQ@memverge.com>
Date: Wed, 20 Dec 2023 10:27:06 +0800
Message-ID: <87zfy5libp.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Tue, Dec 19, 2023 at 11:04:05AM +0800, Huang, Ying wrote:
>> Gregory Price <gourry.memverge@gmail.com> writes:
>> 
>> > This patch set extends the mempolicy interface to enable new
>> > mempolicies which may require extended data to operate.
>> >
>> > MPOL_WEIGHTED_INTERLEAVE is included as an example extension.
>> 
>> Per my understanding, it's better to describe why we need this patchset
>> at the beginning.  Per my understanding, weighted interleave is used to
>> expand DRAM bandwidth for workloads with real high memory bandwidth
>> requirements.  Without it, DRAM bandwidth will be saturated, which leads
>> to poor performance.
>> 
>
> Will add more details, thanks.
>
>> > struct mempolicy_args {
>> >     unsigned short mode;            /* policy mode */
>> >     unsigned short mode_flags;      /* policy mode flags */
>> >     int home_node;                  /* mbind: use MPOL_MF_HOME_NODE */
>> >     nodemask_t *policy_nodes;       /* get/set/mbind */
>> >     unsigned char *il_weights;      /* for mode MPOL_WEIGHTED_INTERLEAVE */
>> >     int policy_node;                /* get: policy node information */
>> > };
>> 
>> Because we use more and more parameters to describe the mempolicy, I
>> think it's a good idea to replace some parameters with struct.  But I
>> don't think it's a good idea to put unrelated stuff into the struct.
>> For example,
>> 
>> struct mempolicy_param {
>>     unsigned short mode;            /* policy mode */
>>     unsigned short mode_flags;      /* policy mode flags */
>>     int home_node;                  /* mbind: use MPOL_MF_HOME_NODE */
>>     nodemask_t *policy_nodes;
>>     unsigned char *il_weights;      /* for mode MPOL_WEIGHTED_INTERLEAVE */
>> };
>> 
>> describe the parameters to create the mempolicy.  It can be used by
>> set/get_mempolicy() and mbind().  So, I think that it's a good
>> abstraction.  But "policy_node" has nothing to do with set_mempolicy()
>> and mbind().  So I think that we shouldn't add it into the struct.  It's
>> totally OK to use different parameters for different functions.  For
>> example,
>> 
>> long do_set_mempolicy(struct mempolicy_param *mparam);
>> long do_mbind(unsigned long start, unsigned long len,
>>                 struct mempolicy_param *mparam, unsigned long flags);
>> long do_get_task_mempolicy(struct mempolicy_param *mparam, int
>>                 *policy_node);
>> 
>> This isn't the full list.  My point is to use separate parameter for
>> something specific for some function.
>>
>
> this is the internal structure, but i get the point, we can drop it from
> the structure and extend the arg list internally.
>
> I'd originally thought to just remove the policy_node stuff all
> together from get_mempolicy2().  Do you prefer to have a separate struct
> for set/get interfaces so that the get interface struct can be extended?
>
> All the MPOL_F_NODE "alternate data fetch" mechanisms from
> get_mempolicy() feel like more of a wart than a feature.  And presently
> the only data returned in policy_node is the next allocation node for
> interleave.  That's not even particularly useful, so I'm of a mind to
> remove it.
>
> Assuming we remove policy_node altogether... do we still break up the
> set/get interface into separate structures to avoid this in the future?

I have no much experience at ABI definition.  So, I want to get guidance
from more experienced people on this.

Is it good to implement all functionality of get_mempolicy() with
get_mempolicy2(), so we can deprecate get_mempolicy() and remove it
finally?  So, users don't need to use 2 similar syscalls?

And, IIUC, we will not get policy_node, addr_node, and policy config at
the same time, is it better to use a union instead of struct in
get_mempolicy2()?

>> > struct mpol_args {
>> >         /* Basic mempolicy settings */
>> >         __u16 mode;
>> >         __u16 mode_flags;
>> >         __s32 home_node;
>> >         __aligned_u64 pol_nodes;
>> >         __aligned_u64 *il_weights;      /* of size pol_maxnodes */
>> >         __u64 pol_maxnodes;
>> >         __s32 policy_node;
>> > };
>> 
>> Same as my idea above.  I think we shouldn't add policy_node for
>> set_mempolicy2()/mbind2().  That will make users confusing.  We can use
>> a different struct for get_mempolicy2().
>> 
>
> See above.

--
Best Regards,
Huang, Ying

