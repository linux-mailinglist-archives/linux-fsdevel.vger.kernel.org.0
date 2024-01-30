Return-Path: <linux-fsdevel+bounces-9487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D74841B62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 06:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D39B1F24EF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 05:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B65381B8;
	Tue, 30 Jan 2024 05:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TEUMk/AC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76DC38391;
	Tue, 30 Jan 2024 05:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706592034; cv=none; b=Z+FNZ+E8ZmWTv8GF6FDaPLVQimJ3+y0lGa3C2fLpc0LRMyWP2ipLqmba1K76fiFlRRt0f79QmeGWWxQkKihhwRozrh23T5CyjUZTptFhqYSoZwovNAB6TmPdgDqG9okzXiMoBaoehwyux3FMGhkEyyi+B9isDjk26SfrHGQWVNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706592034; c=relaxed/simple;
	bh=H+kUUwQrQMb1IwmAFXXv1tRw7HnV6M5rIHAXOc0j4jI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H99DqpYVAry+OBEkikuT3HmWD5eN8Ld2pZWYM1CdXRh7Tl+OgCN+0m3nQnStFrzQyG5yT2TCaYTtQxKx89WXNW2QxtmeyPaaVrrHnUXYpm+qZ4DHhWoRChmtz6nV808BfSgs/HWtl5FEXDk/gac1WUJ+yBsKDPOYz8pmJGyUl4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TEUMk/AC; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706592033; x=1738128033;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=H+kUUwQrQMb1IwmAFXXv1tRw7HnV6M5rIHAXOc0j4jI=;
  b=TEUMk/AC0iWr24N6H/ASEDQF3rZBKzuTMhfM42rDyXjzFMoQM8v3/q2Q
   srOl23H+RAVnRpW7cIVHCPtZcnb8wW8XcfHeX3RM9nMOk9JKPKW0XsMLB
   nTGULwkxghWS6tmO9JkhXyzlU1GvhsYhpKejdXLoGpiZapbjpeUHbey72
   qRTMFbFixpsaVbub9XHxxIQogi0DJXnpBSf3u5Mnti6StRz1SOar1zvJR
   PyGMizGPDyRfH6KjQDUjqcb3qMbHrJ4a7ROKdAWoTg54Wj8lSTpK3ECyv
   YU19rO6Sb4AyvTNl22rg2zdBa4BefgzCcVPcD+IcPNfgphWm/9OrMmF/1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="16560415"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="16560415"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 21:20:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="737657907"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="737657907"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 21:20:27 -0800
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
Subject: Re: [PATCH v3 4/4] mm/mempolicy: change cur_il_weight to atomic and
 carry the node with it
In-Reply-To: <ZbhuJTBp68e8eLRv@memverge.com> (Gregory Price's message of "Mon,
	29 Jan 2024 22:33:57 -0500")
References: <20240125184345.47074-1-gregory.price@memverge.com>
	<20240125184345.47074-5-gregory.price@memverge.com>
	<87sf2klez8.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZbPf6d2cQykdl3Eb@memverge.com>
	<877cjsk0yd.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZbfI3+nhgQlNKMPG@memverge.com> <ZbfqVHA9+38/j3Mq@memverge.com>
	<875xzbika0.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZbhuJTBp68e8eLRv@memverge.com>
Date: Tue, 30 Jan 2024 13:18:30 +0800
Message-ID: <871q9ziel5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Tue, Jan 30, 2024 at 11:15:35AM +0800, Huang, Ying wrote:
>> Gregory Price <gregory.price@memverge.com> writes:
>> 
>> > On Mon, Jan 29, 2024 at 10:48:47AM -0500, Gregory Price wrote:
>> >> On Mon, Jan 29, 2024 at 04:17:46PM +0800, Huang, Ying wrote:
>> >> > Gregory Price <gregory.price@memverge.com> writes:
>> >> > 
>> >> > But, in contrast, it's bad to put task-local "current weight" in
>> >> > mempolicy.  So, I think that it's better to move cur_il_weight to
>> >> > task_struct.  And maybe combine it with current->il_prev.
>> >> > 
>> >> Style question: is it preferable add an anonymous union into task_struct:
>> >> 
>> >> union {
>> >>     short il_prev;
>> >>     atomic_t wil_node_weight;
>> >> };
>> >> 
>> >> Or should I break out that union explicitly in mempolicy.h?
>> >> 
>> >
>> > Having attempted this, it looks like including mempolicy.h into sched.h
>> > is a non-starter.  There are build issues likely associated from the
>> > nested include of uapi/linux/mempolicy.h
>> >
>> > So I went ahead and did the following.  Style-wise If it's better to just
>> > integrate this as an anonymous union in task_struct, let me know, but it
>> > seemed better to add some documentation here.
>> >
>> > I also added static get/set functions to mempolicy.c to touch these
>> > values accordingly.
>> >
>> > As suggested, I changed things to allow 0-weight in il_prev.node_weight
>> > adjusted the logic accordingly. Will be testing this for a day or so
>> > before sending out new patches.
>> >
>> 
>> Thanks about this again.  It seems that we don't need to touch
>> task->il_prev and task->il_weight during rebinding for weighted
>> interleave too.
>> 
>
> It's not clear to me this is the case.  cpusets takes the task_lock to
> change mems_allowed and rebind task->mempolicy, but I do not see the
> task lock access blocking allocations.
>
> Comments from cpusets suggest allocations can happen in parallel.
>
> /*
>  * cpuset_change_task_nodemask - change task's mems_allowed and mempolicy
>  * @tsk: the task to change
>  * @newmems: new nodes that the task will be set
>  *
>  * We use the mems_allowed_seq seqlock to safely update both tsk->mems_allowed
>  * and rebind an eventual tasks' mempolicy. If the task is allocating in
>  * parallel, it might temporarily see an empty intersection, which results in
>  * a seqlock check and retry before OOM or allocation failure.
>  */
>
>
> For normal interleave, this isn't an issue because it always proceeds to
> the next node. The same is not true of weighted interleave, which may
> have a hanging weight in task->il_weight.

So, I added a check as follows,

node_isset(current->il_prev, policy->nodes)

If prev node is removed from nodemask, allocation will proceed to the
next node.  Otherwise, it's safe to use current->il_weight.  

--
Best Regards,
Huang, Ying

> That is why I looked to combine the two, so at least node/weight were
> carried together.
>
>> unsigned int weighted_interleave_nodes(struct mempolicy *policy)
>> {
>>         unsigned int nid;
>>         struct task_struct *me = current;
>> 
>>         nid = me->il_prev;
>>         if (!me->il_weight || !node_isset(nid, policy->nodes)) {
>>                 nid = next_node_in(...);
>>                 me->il_prev = nid;
>>                 me->il_weight = weights[nid];
>>         }
>>         me->il_weight--;
>> 
>>         return nid;
>> }
>
> I ended up with this:
>
> static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
> {
>        unsigned int node;
>        u8 weight;
>
>        get_wil_prev(&node, &weight);
>        /* If nodemask was rebound, just fetch the next node */
>        if (!weight) {
>                node = next_node_in(node, policy->nodes);
>                /* can only happen if nodemask has become invalid */
>                if (node == MAX_NUMNODES)
>                        return node;
>                weight = get_il_weight(node);
>        }
>        weight--;
>        set_wil_prev(node, weight);
>        return node;
> }
>
> ~Gregory

