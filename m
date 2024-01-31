Return-Path: <linux-fsdevel+bounces-9625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DAC8436F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 07:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA91B1F21A5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 06:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEFB3EA66;
	Wed, 31 Jan 2024 06:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NlQ6RV15"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96394E1A8;
	Wed, 31 Jan 2024 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706683517; cv=none; b=ADWp/K4qIXZJQxfGoVmodEOPDStHphPWO1dSEQyAAWsjoUAs0a671UpgmAmvFlDEOvDC+4izTRYxv2Yp4JDNm1yYDgYZ28wkV9+qGuTQarGR8BWtks0Yw2EjnIHJ3/wR1aggvM1Uttc4Tdzum4+VhJQt3T3y92qbobeGIGz9tMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706683517; c=relaxed/simple;
	bh=62rH2nWT7oZIFy1JA85REPqTaRFFGgCKxs03yS0PYo4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WjPf5Cke35w2Po7DIf9Kyxt22rK0juMUPRt9AZSNWKkjMWNIeW3Ej9LpcEibJILbtd5rBhJuzOyKNSQH8Tio8L1FNf9qiGVLNLb5Y2ift9eQrpXy6et7396uGw3f8ztnjzhOlXnY55Sn1oMzuLr7VsWa6IQV/YItbCRZtk9e+sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NlQ6RV15; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706683515; x=1738219515;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=62rH2nWT7oZIFy1JA85REPqTaRFFGgCKxs03yS0PYo4=;
  b=NlQ6RV15bbX/sEpEJR/MEcWOLJHJpmZAaM2MXkNXzMmgROutp7X68thS
   4/q5IFvr9ukwf+5H6hH/WxYANylQFfF6EjzJnS+NVFB2RRDEon7pbZ6ql
   Cnk7AvyW6ZPXw4Ho63dy7b7ZSY4+NTOz7gQYLP3jRciOE1kaC3sXUFbAa
   /UtWlL1z2tnua4/ZcHjqS/6tR7unImqn5RFa222QjypBr5uxBYa75xmpD
   IEilSHGkL5L4pivJWju4peMuVF20KNSwytOO0SajKSZWCWVcbvp6NyXma
   CCEjTSMFS/yPaMglDjdpA3f8cdxd/NQSNGVW76ILo485YCDSManrzuoRj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="402364620"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="402364620"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 22:45:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="907783072"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="907783072"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 22:45:08 -0800
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
Subject: Re: [PATCH v4 3/3] mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE
 for weighted interleaving
In-Reply-To: <20240130182046.74278-4-gregory.price@memverge.com> (Gregory
	Price's message of "Tue, 30 Jan 2024 13:20:46 -0500")
References: <20240130182046.74278-1-gregory.price@memverge.com>
	<20240130182046.74278-4-gregory.price@memverge.com>
Date: Wed, 31 Jan 2024 14:43:12 +0800
Message-ID: <877cjqgfzz.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> Some high level notes about the pieces of weighted interleave:
>
> current->il_prev:
>     Default interleave uses this to track the last used node.
>     Weighted interleave uses this to track the *current* node, and
>     when weight reaches 0 it will be used to acquire the next node.
>
> current->il_weight:
>     The active weight of the current node (current->il_prev)
>     When this reaches 0, current->il_prev is set to the next node
>     and current->il_weight is set to the next weight.

I still think that my description of the 2 fields above is easier to be
understood.  For weighted interleave,

current->il_prev is the node from which we allocated page in previous
allocation.

current->il_weight is the remaining weight for current->il_prev after
previous allocation.

But I will not force you to use this.  Use it only if you think that
they are better.

> weighted_interleave_nodes:
>     Counts the number of allocations as they occur, and applies the
>     weight for the current node.  When the weight reaches 0, switch
>     to the next node.  Operates only on task->mempolicy.
>
> weighted_interleave_nid:
>     Gets the total weight of the nodemask as well as each individual
>     node weight, then calculates the node based on the given index.
>     Operates on VMA policies.
>
> bulk_array_weighted_interleave:
>     Gets the total weight of the nodemask as well as each individual
>     node weight, then calculates the number of "interleave rounds" as
>     well as any delta ("partial round").  Calculates the number of
>     pages for each node and allocates them.
>
>     If a node was scheduled for interleave via interleave_nodes, the
>     current weight will be allocated first.
>
>     Operates only on the task->mempolicy.
>
> One piece of complexity is the interaction between a recent refactor
> which split the logic to acquire the "ilx" (interleave index) of an
> allocation and the actual application of the interleave. If a call
> to alloc_pages_mpol() were made with a weighted-interleave policy and
> ilx set to NO_INTERLEAVE_INDEX, weighted_interleave_nodes() would
> operate on a VMA policy - violating the description above.
>
> An inspection of all callers of alloc_pages_mpol() shows that all
> external callers set ilx to `0`, an index value, or will call
> get_vma_policy() to acquire the ilx.
>
> For example, mm/shmem.c may call into alloc_pages_mpol. The call stacks
> all set (pgoff_t ilx) or end up in `get_vma_policy()`.  This enforces
> the `weighted_interleave_nodes()` and `weighted_interleave_nid()`
> policy requirements (task/vma respectively).
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
>  include/linux/sched.h                         |   1 +
>  include/uapi/linux/mempolicy.h                |   1 +
>  mm/mempolicy.c                                | 231 +++++++++++++++++-
>  4 files changed, 238 insertions(+), 4 deletions(-)
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
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index ffe8f618ab86..b9ce285d8c9c 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1259,6 +1259,7 @@ struct task_struct {
>  	/* Protected by alloc_lock: */
>  	struct mempolicy		*mempolicy;
>  	short				il_prev;
> +	u8				il_weight;
>  	short				pref_node_fork;
>  #endif
>  #ifdef CONFIG_NUMA_BALANCING
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
> index 3bdfaf03b660..7cd92f4ec0d7 100644
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
> @@ -441,6 +448,10 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
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
> @@ -862,8 +873,11 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
>  
>  	old = current->mempolicy;
>  	current->mempolicy = new;
> -	if (new && new->mode == MPOL_INTERLEAVE)
> +	if (new && (new->mode == MPOL_INTERLEAVE ||
> +		    new->mode == MPOL_WEIGHTED_INTERLEAVE)) {
>  		current->il_prev = MAX_NUMNODES-1;
> +		current->il_weight = 0;
> +	}
>  	task_unlock(current);
>  	mpol_put(old);
>  	ret = 0;
> @@ -888,6 +902,7 @@ static void get_policy_nodemask(struct mempolicy *pol, nodemask_t *nodes)
>  	case MPOL_INTERLEAVE:
>  	case MPOL_PREFERRED:
>  	case MPOL_PREFERRED_MANY:
> +	case MPOL_WEIGHTED_INTERLEAVE:
>  		*nodes = pol->nodes;
>  		break;
>  	case MPOL_LOCAL:
> @@ -972,6 +987,13 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
>  		} else if (pol == current->mempolicy &&
>  				pol->mode == MPOL_INTERLEAVE) {
>  			*policy = next_node_in(current->il_prev, pol->nodes);
> +		} else if (pol == current->mempolicy &&
> +				pol->mode == MPOL_WEIGHTED_INTERLEAVE) {
> +			if (current->il_weight)
> +				*policy = current->il_prev;
> +			else
> +				*policy = next_node_in(current->il_prev,
> +						       pol->nodes);
>  		} else {
>  			err = -EINVAL;
>  			goto out;
> @@ -1336,7 +1358,8 @@ static long do_mbind(unsigned long start, unsigned long len,
>  		 * VMAs, the nodes will still be interleaved from the targeted
>  		 * nodemask, but one by one may be selected differently.
>  		 */
> -		if (new->mode == MPOL_INTERLEAVE) {
> +		if (new->mode == MPOL_INTERLEAVE ||
> +		    new->mode == MPOL_WEIGHTED_INTERLEAVE) {
>  			struct page *page;
>  			unsigned int order;
>  			unsigned long addr = -EFAULT;
> @@ -1784,7 +1807,8 @@ struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
>   * @vma: virtual memory area whose policy is sought
>   * @addr: address in @vma for shared policy lookup
>   * @order: 0, or appropriate huge_page_order for interleaving
> - * @ilx: interleave index (output), for use only when MPOL_INTERLEAVE
> + * @ilx: interleave index (output), for use only when MPOL_INTERLEAVE or
> + *       MPOL_WEIGHTED_INTERLEAVE
>   *
>   * Returns effective policy for a VMA at specified address.
>   * Falls back to current->mempolicy or system default policy, as necessary.
> @@ -1801,7 +1825,8 @@ struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
>  	pol = __get_vma_policy(vma, addr, ilx);
>  	if (!pol)
>  		pol = get_task_policy(current);
> -	if (pol->mode == MPOL_INTERLEAVE) {
> +	if (pol->mode == MPOL_INTERLEAVE ||
> +	    pol->mode == MPOL_WEIGHTED_INTERLEAVE) {
>  		*ilx += vma->vm_pgoff >> order;
>  		*ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
>  	}
> @@ -1851,6 +1876,22 @@ bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
>  	return zone >= dynamic_policy_zone;
>  }
>  
> +static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
> +{
> +	unsigned int node = current->il_prev;
> +
> +	if (!current->il_weight || !node_isset(node, policy->nodes)) {
> +		node = next_node_in(node, policy->nodes);
> +		/* can only happen if nodemask is being rebound */
> +		if (node == MAX_NUMNODES)
> +			return node;

I feel a little unsafe to read policy->nodes at same time of writing in
rebound.  Is it better to use a seqlock to guarantee its consistency?
It's unnecessary to be a part of this series though.

> +		current->il_prev = node;
> +		current->il_weight = get_il_weight(node);
> +	}
> +	current->il_weight--;
> +	return node;
> +}
> +
>  /* Do dynamic interleaving for a process */
>  static unsigned int interleave_nodes(struct mempolicy *policy)
>  {
> @@ -1885,6 +1926,9 @@ unsigned int mempolicy_slab_node(void)
>  	case MPOL_INTERLEAVE:
>  		return interleave_nodes(policy);
>  
> +	case MPOL_WEIGHTED_INTERLEAVE:
> +		return weighted_interleave_nodes(policy);
> +
>  	case MPOL_BIND:
>  	case MPOL_PREFERRED_MANY:
>  	{
> @@ -1923,6 +1967,45 @@ static unsigned int read_once_policy_nodemask(struct mempolicy *pol,
>  	return nodes_weight(*mask);
>  }
>  
> +static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
> +{
> +	nodemask_t nodemask;
> +	unsigned int target, nr_nodes;
> +	u8 __rcu *table;
> +	unsigned int weight_total = 0;
> +	u8 weight;
> +	int nid;
> +
> +	nr_nodes = read_once_policy_nodemask(pol, &nodemask);
> +	if (!nr_nodes)
> +		return numa_node_id();
> +
> +	rcu_read_lock();
> +	table = rcu_dereference(iw_table);
> +	/* calculate the total weight */
> +	for_each_node_mask(nid, nodemask) {
> +		/* detect system default usage */
> +		weight = table ? table[nid] : 1;
> +		weight = weight ? weight : 1;
> +		weight_total += weight;
> +	}
> +
> +	/* Calculate the node offset based on totals */
> +	target = ilx % weight_total;
> +	nid = first_node(nodemask);
> +	while (target) {
> +		/* detect system default usage */
> +		weight = table ? table[nid] : 1;
> +		weight = weight ? weight : 1;

I found duplicated pattern as above in this patch.  Can we define a
function like below to remove the duplication?

u8 __get_il_weight(u8 *table, int nid)
{
        u8 weight;

        weight = table ? table[nid] : 1;
        return weight ? : 1;
}

This can be used in alloc_pages_bulk_array_weighted_interleave() to copy
from global to local weights array too.

But this isn't a big deal.  I will leave it to you to decide.

> +		if (target < weight)
> +			break;
> +		target -= weight;
> +		nid = next_node_in(nid, nodemask);
> +	}
> +	rcu_read_unlock();
> +	return nid;
> +}
> +
>  /*
>   * Do static interleaving for interleave index @ilx.  Returns the ilx'th
>   * node in pol->nodes (starting from ilx=0), wrapping around if ilx
> @@ -1983,6 +2066,11 @@ static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
>  		*nid = (ilx == NO_INTERLEAVE_INDEX) ?
>  			interleave_nodes(pol) : interleave_nid(pol, ilx);
>  		break;
> +	case MPOL_WEIGHTED_INTERLEAVE:
> +		*nid = (ilx == NO_INTERLEAVE_INDEX) ?
> +			weighted_interleave_nodes(pol) :
> +			weighted_interleave_nid(pol, ilx);
> +		break;
>  	}
>  
>  	return nodemask;
> @@ -2044,6 +2132,7 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
>  	case MPOL_PREFERRED_MANY:
>  	case MPOL_BIND:
>  	case MPOL_INTERLEAVE:
> +	case MPOL_WEIGHTED_INTERLEAVE:
>  		*mask = mempolicy->nodes;
>  		break;
>  
> @@ -2144,6 +2233,7 @@ struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
>  		 * node in its nodemask, we allocate the standard way.
>  		 */
>  		if (pol->mode != MPOL_INTERLEAVE &&
> +		    pol->mode != MPOL_WEIGHTED_INTERLEAVE &&
>  		    (!nodemask || node_isset(nid, *nodemask))) {
>  			/*
>  			 * First, try to allocate THP only on local node, but
> @@ -2279,6 +2369,127 @@ static unsigned long alloc_pages_bulk_array_interleave(gfp_t gfp,
>  	return total_allocated;
>  }
>  
> +static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
> +		struct mempolicy *pol, unsigned long nr_pages,
> +		struct page **page_array)
> +{
> +	struct task_struct *me = current;
> +	unsigned long total_allocated = 0;
> +	unsigned long nr_allocated = 0;
> +	unsigned long rounds;
> +	unsigned long node_pages, delta;
> +	u8 __rcu *table, *weights, weight;
> +	unsigned int weight_total = 0;
> +	unsigned long rem_pages = nr_pages;
> +	nodemask_t nodes;
> +	int nnodes, node, next_node;
> +	int resume_node = MAX_NUMNODES - 1;
> +	u8 resume_weight = 0;
> +	int prev_node;
> +	int i;
> +
> +	if (!nr_pages)
> +		return 0;
> +
> +	nnodes = read_once_policy_nodemask(pol, &nodes);
> +	if (!nnodes)
> +		return 0;
> +
> +	/* Continue allocating from most recent node and adjust the nr_pages */
> +	node = me->il_prev;
> +	weight = me->il_weight;
> +	if (weight && node_isset(node, nodes)) {
> +		node_pages = min(rem_pages, weight);
> +		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
> +						  NULL, page_array);
> +		page_array += nr_allocated;
> +		total_allocated += nr_allocated;
> +		/* if that's all the pages, no need to interleave */
> +		if (rem_pages < weight) {
> +			/* stay on current node, adjust il_weight */
> +			me->il_weight -= rem_pages;
> +			return total_allocated;
> +		} else if (rem_pages == weight) {
> +			/* move to next node / weight */
> +			me->il_prev = next_node_in(node, nodes);
> +			me->il_weight = get_il_weight(next_node);
> +			return total_allocated;
> +		}
> +		/* Otherwise we adjust remaining pages, continue from there */
> +		rem_pages -= weight;
> +	}
> +	/* clear active weight in case of an allocation failure */
> +	me->il_weight = 0;
> +	prev_node = node;
> +
> +	/* create a local copy of node weights to operate on outside rcu */
> +	weights = kzalloc(nr_node_ids, GFP_KERNEL);
> +	if (!weights)
> +		return total_allocated;
> +
> +	rcu_read_lock();
> +	table = rcu_dereference(iw_table);
> +	if (table)
> +		memcpy(weights, table, nr_node_ids);
> +	rcu_read_unlock();
> +
> +	/* calculate total, detect system default usage */
> +	for_each_node_mask(node, nodes) {
> +		if (!weights[node])
> +			weights[node] = 1;
> +		weight_total += weights[node];
> +	}
> +
> +	/*
> +	 * Calculate rounds/partial rounds to minimize __alloc_pages_bulk calls.
> +	 * Track which node weighted interleave should resume from.
> +	 *
> +	 * if (rounds > 0) and (delta == 0), resume_node will always be
> +	 * the node following prev_node and its weight.
> +	 */
> +	rounds = rem_pages / weight_total;
> +	delta = rem_pages % weight_total;
> +	resume_node = next_node_in(prev_node, nodes);
> +	resume_weight = weights[resume_node];
> +	for (i = 0; i < nnodes; i++) {
> +		node = next_node_in(prev_node, nodes);
> +		weight = weights[node];
> +		node_pages = weight * rounds;
> +		/* If a delta exists, add this node's portion of the delta */
> +		if (delta > weight) {
> +			node_pages += weight;
> +			delta -= weight;
> +		} else if (delta) {
> +			node_pages += delta;
> +			/* delta may deplete on a boundary or w/ a remainder */
> +			if (delta == weight) {
> +				/* boundary: resume from next node/weight */
> +				resume_node = next_node_in(node, nodes);
> +				resume_weight = weights[resume_node];
> +			} else {
> +				/* remainder: resume this node w/ remainder */
> +				resume_node = node;
> +				resume_weight = weight - delta;
> +			}

If we are comfortable to leave resume_weight == 0, then the above
branch can be simplified to.

        resume_node = node;
        resume_weight = weight - delta;

But, this is a style issue again.  I will leave it to you to decide.

So, except the issue you pointed out already.  All series looks good to
me!  Thanks!  Feel free to add

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

to the whole series.

> +			delta = 0;
> +		}
> +		/* node_pages can be 0 if an allocation fails and rounds == 0 */
> +		if (!node_pages)
> +			break;
> +		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
> +						  NULL, page_array);
> +		page_array += nr_allocated;
> +		total_allocated += nr_allocated;
> +		if (total_allocated == nr_pages)
> +			break;
> +		prev_node = node;
> +	}
> +	me->il_prev = resume_node;
> +	me->il_weight = resume_weight;
> +	kfree(weights);
> +	return total_allocated;
> +}
> +
>  static unsigned long alloc_pages_bulk_array_preferred_many(gfp_t gfp, int nid,
>  		struct mempolicy *pol, unsigned long nr_pages,
>  		struct page **page_array)
> @@ -2319,6 +2530,10 @@ unsigned long alloc_pages_bulk_array_mempolicy(gfp_t gfp,
>  		return alloc_pages_bulk_array_interleave(gfp, pol,
>  							 nr_pages, page_array);
>  
> +	if (pol->mode == MPOL_WEIGHTED_INTERLEAVE)
> +		return alloc_pages_bulk_array_weighted_interleave(
> +				  gfp, pol, nr_pages, page_array);
> +
>  	if (pol->mode == MPOL_PREFERRED_MANY)
>  		return alloc_pages_bulk_array_preferred_many(gfp,
>  				numa_node_id(), pol, nr_pages, page_array);
> @@ -2394,6 +2609,7 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
>  	case MPOL_INTERLEAVE:
>  	case MPOL_PREFERRED:
>  	case MPOL_PREFERRED_MANY:
> +	case MPOL_WEIGHTED_INTERLEAVE:
>  		return !!nodes_equal(a->nodes, b->nodes);
>  	case MPOL_LOCAL:
>  		return true;
> @@ -2530,6 +2746,10 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
>  		polnid = interleave_nid(pol, ilx);
>  		break;
>  
> +	case MPOL_WEIGHTED_INTERLEAVE:
> +		polnid = weighted_interleave_nid(pol, ilx);
> +		break;
> +
>  	case MPOL_PREFERRED:
>  		if (node_isset(curnid, pol->nodes))
>  			goto out;
> @@ -2904,6 +3124,7 @@ static const char * const policy_modes[] =
>  	[MPOL_PREFERRED]  = "prefer",
>  	[MPOL_BIND]       = "bind",
>  	[MPOL_INTERLEAVE] = "interleave",
> +	[MPOL_WEIGHTED_INTERLEAVE] = "weighted interleave",
>  	[MPOL_LOCAL]      = "local",
>  	[MPOL_PREFERRED_MANY]  = "prefer (many)",
>  };
> @@ -2963,6 +3184,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
>  		}
>  		break;
>  	case MPOL_INTERLEAVE:
> +	case MPOL_WEIGHTED_INTERLEAVE:
>  		/*
>  		 * Default to online nodes with memory if no nodelist
>  		 */
> @@ -3073,6 +3295,7 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
>  	case MPOL_PREFERRED_MANY:
>  	case MPOL_BIND:
>  	case MPOL_INTERLEAVE:
> +	case MPOL_WEIGHTED_INTERLEAVE:
>  		nodes = pol->nodes;
>  		break;
>  	default:

--
Best Regards,
Huang, Ying


