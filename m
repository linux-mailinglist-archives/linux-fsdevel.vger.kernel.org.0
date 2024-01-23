Return-Path: <linux-fsdevel+bounces-8515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81606838950
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 09:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A081F2A038
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 08:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EFA57300;
	Tue, 23 Jan 2024 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AgL97WBu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24915677A;
	Tue, 23 Jan 2024 08:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999335; cv=none; b=sXlLEHGCdu12e+3BlDLbqLr1YOSlweWU3qVF3JaNmvUDfFuYjJE58t7JGzw8niiWx3y7cT8u9PM/ob3uiF5ES6zPvLQ2Z4Aao9KY8BYzZNNerFsQMO/C+9tLmYYl7m6rMAbaay/DEMkWcqfpZkewbs44hKdIz6JkjOpV6qLegnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999335; c=relaxed/simple;
	bh=Fuq2GEiIWzWUexLPBFjdb5nRhXQcZ1bIjsCKbaRPh+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MKY/HYmtoxcAJ6EsI6F+7jRBbd4+700Ugc066wxutBliMeX0Oopejl53rQjOsetVixJfwPjx2lJo0wIw5xfUak/2pjDGsn0932ey5gkQMZ6Z7JAk9PjvgW37xhrNXw5NRsva4Lq1aDMkke7kXVvTqxa92dI1pYtNoYZLYw7TIAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AgL97WBu; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705999334; x=1737535334;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Fuq2GEiIWzWUexLPBFjdb5nRhXQcZ1bIjsCKbaRPh+E=;
  b=AgL97WBu3YPQitRxP7UhEZFT13FucbWdO/Wjy7RUEMEz5T2Q07dTUygl
   Wm4BASr087J6m1B58pqTmjZq3bEHHcaE1SbchOX4V1aY9OedkYnPfvtlK
   zGD/Te1jajtkNQzJCnyC2PCxmqT6uVXTNdJgYjakfzwaeVInFfYon2M3C
   QWU8Pzr76fv4x6MfCe/Gphf/c7eUvM3AqCMsLmOH/4o+rTNnHApOj5lwp
   PvOwg44CCixYg7LmHOhV1e4RSmPnqTFy7aW8FddA4SIdJ6ZDHY9TFqiXA
   owz8ZTHa1Wap9c8YYnMJo0Ced6X60eJ4rAL3cu2Wgp7b4z/RuH8OqmFoo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="8129135"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="8129135"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 00:42:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="856248370"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="856248370"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 00:42:06 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gourry.memverge@gmail.com>
Cc: linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-doc@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-api@vger.kernel.org,  corbet@lwn.net,  akpm@linux-foundation.org,
  gregory.price@memverge.com,  honggyu.kim@sk.com,  rakie.kim@sk.com,
  hyeongtak.ji@sk.com,  mhocko@kernel.org,  vtavarespetr@micron.com,
  jgroves@micron.com,  ravis.opensrc@micron.com,  sthanneeru@micron.com,
  emirakhur@micron.com,  Hasan.Maruf@amd.com,  seungjun.ha@samsung.com,
  hannes@cmpxchg.org,  dan.j.williams@intel.com,  Srinivasulu Thanneeru
 <sthanneeru.opensrc@micron.com>
Subject: Re: [PATCH v2 3/3] mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE
 for weighted interleaving
In-Reply-To: <20240119175730.15484-4-gregory.price@memverge.com> (Gregory
	Price's message of "Fri, 19 Jan 2024 12:57:30 -0500")
References: <20240119175730.15484-1-gregory.price@memverge.com>
	<20240119175730.15484-4-gregory.price@memverge.com>
Date: Tue, 23 Jan 2024 16:40:09 +0800
Message-ID: <875xzkv3x2.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry.memverge@gmail.com> writes:

> When a system has multiple NUMA nodes and it becomes bandwidth hungry,
> using the current MPOL_INTERLEAVE could be an wise option.
>
> However, if those NUMA nodes consist of different types of memory such
> as socket-attached DRAM and CXL/PCIe attached DRAM, the round-robin
> based interleave policy does not optimally distribute data to make use
> of their different bandwidth characteristics.
>
> Instead, interleave is more effective when the allocation policy follows
> each NUMA nodes' bandwidth weight rather than a simple 1:1 distribution.
>
> This patch introduces a new memory policy, MPOL_WEIGHTED_INTERLEAVE,
> enabling weighted interleave between NUMA nodes.  Weighted interleave
> allows for proportional distribution of memory across multiple numa
> nodes, preferably apportioned to match the bandwidth of each node.
>
> For example, if a system has 1 CPU node (0), and 2 memory nodes (0,1),
> with bandwidth of (100GB/s, 50GB/s) respectively, the appropriate
> weight distribution is (2:1).
>
> Weights for each node can be assigned via the new sysfs extension:
> /sys/kernel/mm/mempolicy/weighted_interleave/
>
> For now, the default value of all nodes will be `1`, which matches
> the behavior of standard 1:1 round-robin interleave. An extension
> will be added in the future to allow default values to be registered
> at kernel and device bringup time.
>
> The policy allocates a number of pages equal to the set weights. For
> example, if the weights are (2,1), then 2 pages will be allocated on
> node0 for every 1 page allocated on node1.
>
> The new flag MPOL_WEIGHTED_INTERLEAVE can be used in set_mempolicy(2)
> and mbind(2).
>
> There are 3 integration points:
>
> weighted_interleave_nodes:
>     Counts the number of allocations as they occur, and applies the
>     weight for the current node.  When the weight reaches 0, switch
>     to the next node.
>
> weighted_interleave_nid:
>     Gets the total weight of the nodemask as well as each individual
>     node weight, then calculates the node based on the given index.
>
> bulk_array_weighted_interleave:
>     Gets the total weight of the nodemask as well as each individual
>     node weight, then calculates the number of "interleave rounds" as
>     well as any delta ("partial round").  Calculates the number of
>     pages for each node and allocates them.
>
>     If a node was scheduled for interleave via interleave_nodes, the
>     current weight (pol->cur_weight) will be allocated first, before
>     the remaining bulk calculation is done.
>
> One piece of complexity is the interaction between a recent refactor
> which split the logic to acquire the "ilx" (interleave index) of an
> allocation and the actually application of the interleave.  The
> calculation of the `interleave index` is done by `get_vma_policy()`,
> while the actual selection of the node will be later appliex by the
> relevant weighted_interleave function.
>
> Suggested-by: Hasan Al Maruf <Hasan.Maruf@amd.com>
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> Co-developed-by: Rakie Kim <rakie.kim@sk.com>
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> Co-developed-by: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> Co-developed-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> Co-developed-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
> Signed-off-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
> Co-developed-by: Ravi Jonnalagadda <ravis.opensrc@micron.com>
> Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@micron.com>
> ---
>  .../admin-guide/mm/numa_memory_policy.rst     |   9 +
>  include/linux/mempolicy.h                     |   5 +
>  include/uapi/linux/mempolicy.h                |   1 +
>  mm/mempolicy.c                                | 234 +++++++++++++++++-
>  4 files changed, 246 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
> index eca38fa81e0f..a70f20ce1ffb 100644
> --- a/Documentation/admin-guide/mm/numa_memory_policy.rst
> +++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
> @@ -250,6 +250,15 @@ MPOL_PREFERRED_MANY
>  	can fall back to all existing numa nodes. This is effectively
>  	MPOL_PREFERRED allowed for a mask rather than a single node.
>  
> +MPOL_WEIGHTED_INTERLEAVE
> +	This mode operates the same as MPOL_INTERLEAVE, except that
> +	interleaving behavior is executed based on weights set in
> +	/sys/kernel/mm/mempolicy/weighted_interleave/
> +
> +	Weighted interleave allocates pages on nodes according to a
> +	weight.  For example if nodes [0,1] are weighted [5,2], 5 pages
> +	will be allocated on node0 for every 2 pages allocated on node1.
> +
>  NUMA memory policy supports the following optional mode flags:
>  
>  MPOL_F_STATIC_NODES
> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> index 931b118336f4..c1a083eb0dd5 100644
> --- a/include/linux/mempolicy.h
> +++ b/include/linux/mempolicy.h
> @@ -54,6 +54,11 @@ struct mempolicy {
>  		nodemask_t cpuset_mems_allowed;	/* relative to these nodes */
>  		nodemask_t user_nodemask;	/* nodemask passed by user */
>  	} w;
> +
> +	/* Weighted interleave settings */
> +	struct {
> +		u8 cur_weight;
> +	} wil;
>  };
>  
>  /*
> diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
> index a8963f7ef4c2..1f9bb10d1a47 100644
> --- a/include/uapi/linux/mempolicy.h
> +++ b/include/uapi/linux/mempolicy.h
> @@ -23,6 +23,7 @@ enum {
>  	MPOL_INTERLEAVE,
>  	MPOL_LOCAL,
>  	MPOL_PREFERRED_MANY,
> +	MPOL_WEIGHTED_INTERLEAVE,
>  	MPOL_MAX,	/* always last member of enum */
>  };
>  
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 427bddf115df..aa3b2389d3e0 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -19,6 +19,13 @@
>   *                for anonymous memory. For process policy an process counter
>   *                is used.
>   *
> + * weighted interleave
> + *                Allocate memory interleaved over a set of nodes based on
> + *                a set of weights (per-node), with normal fallback if it
> + *                fails.  Otherwise operates the same as interleave.
> + *                Example: nodeset(0,1) & weights (2,1) - 2 pages allocated
> + *                on node 0 for every 1 page allocated on node 1.
> + *
>   * bind           Only allocate memory on a specific set of nodes,
>   *                no fallback.
>   *                FIXME: memory is allocated starting with the first node
> @@ -313,6 +320,7 @@ static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
>  	policy->mode = mode;
>  	policy->flags = flags;
>  	policy->home_node = NUMA_NO_NODE;
> +	policy->wil.cur_weight = 0;
>  
>  	return policy;
>  }
> @@ -425,6 +433,10 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
>  		.create = mpol_new_nodemask,
>  		.rebind = mpol_rebind_preferred,
>  	},
> +	[MPOL_WEIGHTED_INTERLEAVE] = {
> +		.create = mpol_new_nodemask,
> +		.rebind = mpol_rebind_nodemask,
> +	},
>  };
>  
>  static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
> @@ -846,7 +858,8 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
>  
>  	old = current->mempolicy;
>  	current->mempolicy = new;
> -	if (new && new->mode == MPOL_INTERLEAVE)
> +	if (new && (new->mode == MPOL_INTERLEAVE ||
> +		    new->mode == MPOL_WEIGHTED_INTERLEAVE))
>  		current->il_prev = MAX_NUMNODES-1;
>  	task_unlock(current);
>  	mpol_put(old);
> @@ -872,6 +885,7 @@ static void get_policy_nodemask(struct mempolicy *pol, nodemask_t *nodes)
>  	case MPOL_INTERLEAVE:
>  	case MPOL_PREFERRED:
>  	case MPOL_PREFERRED_MANY:
> +	case MPOL_WEIGHTED_INTERLEAVE:
>  		*nodes = pol->nodes;
>  		break;
>  	case MPOL_LOCAL:
> @@ -956,6 +970,13 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
>  		} else if (pol == current->mempolicy &&
>  				pol->mode == MPOL_INTERLEAVE) {
>  			*policy = next_node_in(current->il_prev, pol->nodes);
> +		} else if (pol == current->mempolicy &&
> +				(pol->mode == MPOL_WEIGHTED_INTERLEAVE)) {
> +			if (pol->wil.cur_weight)
> +				*policy = current->il_prev;
> +			else
> +				*policy = next_node_in(current->il_prev,
> +						       pol->nodes);

Per my understanding, we should always use "*policy = next_node_in()"
here, as in weighted_interleave_nodes().

>  		} else {
>  			err = -EINVAL;
>  			goto out;
> @@ -1785,7 +1806,8 @@ struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
>  	pol = __get_vma_policy(vma, addr, ilx);
>  	if (!pol)
>  		pol = get_task_policy(current);
> -	if (pol->mode == MPOL_INTERLEAVE) {
> +	if (pol->mode == MPOL_INTERLEAVE ||
> +	    pol->mode == MPOL_WEIGHTED_INTERLEAVE) {
>  		*ilx += vma->vm_pgoff >> order;
>  		*ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
>  	}
> @@ -1835,6 +1857,28 @@ bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
>  	return zone >= dynamic_policy_zone;
>  }
>  
> +static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
> +{
> +	unsigned int next;
> +	struct task_struct *me = current;
> +	u8 __rcu *table;
> +
> +	next = next_node_in(me->il_prev, policy->nodes);
> +	if (next == MAX_NUMNODES)
> +		return next;
> +
> +	rcu_read_lock();
> +	table = rcu_dereference(iw_table);
> +	if (!policy->wil.cur_weight)
> +		policy->wil.cur_weight = table ? table[next] : 1;
> +	rcu_read_unlock();
> +
> +	policy->wil.cur_weight--;
> +	if (!policy->wil.cur_weight)
> +		me->il_prev = next;
> +	return next;
> +}
> +

[snip]

--
Best Regards,
Huang, Ying

