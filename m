Return-Path: <linux-fsdevel+bounces-6947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7907D81ED5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 09:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20061F217DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 08:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8B863AB;
	Wed, 27 Dec 2023 08:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P6tRvl3Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1636E6FA3;
	Wed, 27 Dec 2023 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703666084; x=1735202084;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=QdGWp5q7yrGAzzoC7qrMgmM3dNX52nAWLrh2KO78GdU=;
  b=P6tRvl3ZWcOSDN5wsQfRK9FF9eir/PYV6fhYUVQry2puzgokEIcBAGuI
   VYV0epS9mRYVdWUDMctL7zlKU91MEYKdI/CPVwHWMY8EbTAftqfI/DZ/p
   B+uge+rKhpUz3+MwnPIdPJJbN0fDqzh4J2U3jdihjXpi4mISHkIXPm73B
   tCjEaKeAgiB/D6b4fLLgbieQ3izpEVm7auJLAKhvAH+B6cVmNHhxYFTp3
   hjFyZl4UB8hO3TUE4VtjLK/Uchto+ig4RGOIfus30JAPbw2o1JZGKYCzv
   5nAObyCPieFT8SFHxjNmR0eQQRZpBUMaRp5nw5b2FZ96S54YZDcshT0jo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="3512337"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="3512337"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 00:34:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="20233693"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 00:34:36 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gourry.memverge@gmail.com>
Cc: linux-mm@kvack.org,  linux-doc@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-api@vger.kernel.org,  x86@kernel.org,  akpm@linux-foundation.org,
  arnd@arndb.de,  tglx@linutronix.de,  luto@kernel.org,  mingo@redhat.com,
  bp@alien8.de,  dave.hansen@linux.intel.com,  hpa@zytor.com,
  mhocko@kernel.org,  tj@kernel.org,  gregory.price@memverge.com,
  corbet@lwn.net,  rakie.kim@sk.com,  hyeongtak.ji@sk.com,
  honggyu.kim@sk.com,  vtavarespetr@micron.com,  peterz@infradead.org,
  jgroves@micron.com,  ravis.opensrc@micron.com,  sthanneeru@micron.com,
  emirakhur@micron.com,  Hasan.Maruf@amd.com,  seungjun.ha@samsung.com,
  Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
Subject: Re: [PATCH v5 02/11] mm/mempolicy: introduce
 MPOL_WEIGHTED_INTERLEAVE for weighted interleaving
In-Reply-To: <20231223181101.1954-3-gregory.price@memverge.com> (Gregory
	Price's message of "Sat, 23 Dec 2023 13:10:52 -0500")
References: <20231223181101.1954-1-gregory.price@memverge.com>
	<20231223181101.1954-3-gregory.price@memverge.com>
Date: Wed, 27 Dec 2023 16:32:37 +0800
Message-ID: <8734vof3kq.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> the current MPOL_INTERLEAVE could be an wise option.
>
> However, if those NUMA nodes consist of different types of memory such
> as having local DRAM and CXL memory together, the current round-robin
> based interleaving policy doesn't maximize the overall bandwidth because
> of their different bandwidth characteristics.
>
> Instead, the interleaving can be more efficient when the allocation
> policy follows each NUMA nodes' bandwidth weight rather than having 1:1
> round-robin allocation.
>
> This patch introduces a new memory policy, MPOL_WEIGHTED_INTERLEAVE, which
> enables weighted interleaving between NUMA nodes.  Weighted interleave
> allows for a proportional distribution of memory across multiple numa
> nodes, preferablly apportioned to match the bandwidth capacity of each
> node from the perspective of the accessing node.
>
> For example, if a system has 1 CPU node (0), and 2 memory nodes (0,1),
> with a relative bandwidth of (100GB/s, 50GB/s) respectively, the
> appropriate weight distribution is (2:1).
>
> Weights will be acquired from the global weight matrix exposed by the
> sysfs extension: /sys/kernel/mm/mempolicy/weighted_interleave/
>
> The policy will then allocate the number of pages according to the
> set weights.  For example, if the weights are (2,1), then 2 pages
> will be allocated on node0 for every 1 page allocated on node1.
>
> The new flag MPOL_WEIGHTED_INTERLEAVE can be used in set_mempolicy(2)
> and mbind(2).
>
> There are 3 integration points:
>
> weighted_interleave_nodes:
>     Counts the number of allocations as they occur, and applies the
>     weight for the current node.  When the weight reaches 0, switch
>     to the next node. Applied by `mempolicy_slab_node()` and
>     `policy_nodemask()`
>
> weighted_interleave_nid:
>     Gets the total weight of the nodemask as well as each individual
>     node weight, then calculates the node based on the given index.
>     Applied by `policy_nodemask()` and `mpol_misplaced()`
>
> bulk_array_weighted_interleave:
>     Gets the total weight of the nodemask as well as each individual
>     node weight, then calculates the number of "interleave rounds" as
>     well as any delta ("partial round").  Calculates the number of
>     pages for each node and allocates them.
>
>     If a node was scheduled for interleave via interleave_nodes, the
>     current weight (pol->cur_weight) will be allocated first, before
>     the remaining bulk calculation is done. This simplifies the
>     calculation at the cost of an additional allocation call.
>
> One piece of complexity is the interaction between a recent refactor
> which split the logic to acquire the "ilx" (interleave index) of an
> allocation and the actually application of the interleave.  The
> calculation of the `interleave index` is done by `get_vma_policy()`,
> while the actual selection of the node will be later appliex by the
> relevant weighted_interleave function.
>
> If CONFIG_SYSFS is disabled, the weight table will be initialized
> to set all nodes to weight 1, but the weighting code is still called.
> This is so that task-local weights (future patch) can still be
> engaged cleanly without ifdef spaghetti.
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
>  .../admin-guide/mm/numa_memory_policy.rst     |  11 +
>  include/linux/mempolicy.h                     |   5 +
>  include/uapi/linux/mempolicy.h                |   1 +
>  mm/mempolicy.c                                | 197 +++++++++++++++++-
>  4 files changed, 211 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
> index eca38fa81e0f..d2c8e712785b 100644
> --- a/Documentation/admin-guide/mm/numa_memory_policy.rst
> +++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
> @@ -250,6 +250,17 @@ MPOL_PREFERRED_MANY
>  	can fall back to all existing numa nodes. This is effectively
>  	MPOL_PREFERRED allowed for a mask rather than a single node.
>  
> +MPOL_WEIGHTED_INTERLEAVE
> +	This mode operates the same as MPOL_INTERLEAVE, except that
> +	interleaving behavior is executed based on weights set in
> +	/sys/kernel/mm/mempolicy/weighted_interleave/
> +
> +	Weighted interleave allocations pages on nodes according to
> +	their weight.  For example if nodes [0,1] are weighted [5,2]
> +	respectively, 5 pages will be allocated on node0 for every
> +	2 pages allocated on node1.  This can better distribute data
> +	according to bandwidth on heterogeneous memory systems.
> +
>  NUMA memory policy supports the following optional mode flags:
>  
>  MPOL_F_STATIC_NODES
> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> index 931b118336f4..ba09167e80f7 100644
> --- a/include/linux/mempolicy.h
> +++ b/include/linux/mempolicy.h
> @@ -54,6 +54,11 @@ struct mempolicy {
>  		nodemask_t cpuset_mems_allowed;	/* relative to these nodes */
>  		nodemask_t user_nodemask;	/* nodemask passed by user */
>  	} w;
> +
> +	/* Weighted interleave settings */
> +	struct {
> +		unsigned char cur_weight;
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
> index 0e77633b07a5..0a180c670f0c 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -305,6 +305,7 @@ static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
>  	policy->mode = mode;
>  	policy->flags = flags;
>  	policy->home_node = NUMA_NO_NODE;
> +	policy->wil.cur_weight = 0;
>  
>  	return policy;
>  }
> @@ -417,6 +418,10 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
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
> @@ -838,7 +843,8 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
>  
>  	old = current->mempolicy;
>  	current->mempolicy = new;
> -	if (new && new->mode == MPOL_INTERLEAVE)
> +	if (new && (new->mode == MPOL_INTERLEAVE ||
> +		    new->mode == MPOL_WEIGHTED_INTERLEAVE))
>  		current->il_prev = MAX_NUMNODES-1;
>  	task_unlock(current);
>  	mpol_put(old);
> @@ -864,6 +870,7 @@ static void get_policy_nodemask(struct mempolicy *pol, nodemask_t *nodes)
>  	case MPOL_INTERLEAVE:
>  	case MPOL_PREFERRED:
>  	case MPOL_PREFERRED_MANY:
> +	case MPOL_WEIGHTED_INTERLEAVE:
>  		*nodes = pol->nodes;
>  		break;
>  	case MPOL_LOCAL:
> @@ -948,6 +955,13 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
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
>  		} else {
>  			err = -EINVAL;
>  			goto out;
> @@ -1777,7 +1791,8 @@ struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
>  	pol = __get_vma_policy(vma, addr, ilx);
>  	if (!pol)
>  		pol = get_task_policy(current);
> -	if (pol->mode == MPOL_INTERLEAVE) {
> +	if (pol->mode == MPOL_INTERLEAVE ||
> +	    pol->mode == MPOL_WEIGHTED_INTERLEAVE) {
>  		*ilx += vma->vm_pgoff >> order;
>  		*ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
>  	}
> @@ -1827,6 +1842,24 @@ bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
>  	return zone >= dynamic_policy_zone;
>  }
>  
> +static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
> +{
> +	unsigned int next;
> +	struct task_struct *me = current;
> +
> +	next = next_node_in(me->il_prev, policy->nodes);
> +	if (next == MAX_NUMNODES)
> +		return next;
> +
> +	if (!policy->wil.cur_weight)
> +		policy->wil.cur_weight = iw_table[next];
> +
> +	policy->wil.cur_weight--;
> +	if (!policy->wil.cur_weight)
> +		me->il_prev = next;
> +	return next;
> +}
> +
>  /* Do dynamic interleaving for a process */
>  static unsigned int interleave_nodes(struct mempolicy *policy)
>  {
> @@ -1861,6 +1894,9 @@ unsigned int mempolicy_slab_node(void)
>  	case MPOL_INTERLEAVE:
>  		return interleave_nodes(policy);
>  
> +	case MPOL_WEIGHTED_INTERLEAVE:
> +		return weighted_interleave_nodes(policy);
> +
>  	case MPOL_BIND:
>  	case MPOL_PREFERRED_MANY:
>  	{
> @@ -1885,6 +1921,41 @@ unsigned int mempolicy_slab_node(void)
>  	}
>  }
>  
> +static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
> +{
> +	nodemask_t nodemask = pol->nodes;
> +	unsigned int target, weight_total = 0;
> +	int nid;
> +	unsigned char weights[MAX_NUMNODES];

MAX_NUMNODSE could be as large as 1024.  1KB stack space may be too
large?

> +	unsigned char weight;
> +
> +	barrier();

Memory barrier needs comments.

> +
> +	/* first ensure we have a valid nodemask */
> +	nid = first_node(nodemask);
> +	if (nid == MAX_NUMNODES)
> +		return nid;

It appears that this isn't necessary, because we can check whether
weight_total == 0 after the next loop.

> +
> +	/* Then collect weights on stack and calculate totals */
> +	for_each_node_mask(nid, nodemask) {
> +		weight = iw_table[nid];
> +		weight_total += weight;
> +		weights[nid] = weight;
> +	}
> +
> +	/* Finally, calculate the node offset based on totals */
> +	target = (unsigned int)ilx % weight_total;

Why use type casting?

> +	nid = first_node(nodemask);
> +	while (target) {
> +		weight = weights[nid];
> +		if (target < weight)
> +			break;
> +		target -= weight;
> +		nid = next_node_in(nid, nodemask);
> +	}
> +	return nid;
> +}
> +
>  /*
>   * Do static interleaving for interleave index @ilx.  Returns the ilx'th
>   * node in pol->nodes (starting from ilx=0), wrapping around if ilx
> @@ -1953,6 +2024,11 @@ static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
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
> @@ -2014,6 +2090,7 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
>  	case MPOL_PREFERRED_MANY:
>  	case MPOL_BIND:
>  	case MPOL_INTERLEAVE:
> +	case MPOL_WEIGHTED_INTERLEAVE:
>  		*mask = mempolicy->nodes;
>  		break;
>  
> @@ -2113,7 +2190,8 @@ struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
>  		 * If the policy is interleave or does not allow the current
>  		 * node in its nodemask, we allocate the standard way.
>  		 */
> -		if (pol->mode != MPOL_INTERLEAVE &&
> +		if ((pol->mode != MPOL_INTERLEAVE &&
> +		    pol->mode != MPOL_WEIGHTED_INTERLEAVE) &&
>  		    (!nodemask || node_isset(nid, *nodemask))) {
>  			/*
>  			 * First, try to allocate THP only on local node, but
> @@ -2249,6 +2327,106 @@ static unsigned long alloc_pages_bulk_array_interleave(gfp_t gfp,
>  	return total_allocated;
>  }
>  
> +static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
> +		struct mempolicy *pol, unsigned long nr_pages,
> +		struct page **page_array)
> +{
> +	struct task_struct *me = current;
> +	unsigned long total_allocated = 0;
> +	unsigned long nr_allocated;
> +	unsigned long rounds;
> +	unsigned long node_pages, delta;
> +	unsigned char weight;
> +	unsigned char weights[MAX_NUMNODES];
> +	unsigned int weight_total = 0;
> +	unsigned long rem_pages = nr_pages;
> +	nodemask_t nodes = pol->nodes;
> +	int nnodes, node, prev_node;
> +	int i;
> +
> +	/* Stabilize the nodemask on the stack */
> +	barrier();

I don't think barrier() is needed to wait for memory operations for
stack.  It's usually used for cross-processor memory order.

> +
> +	nnodes = nodes_weight(nodes);
> +
> +	/* Collect weights and save them on stack so they don't change */
> +	for_each_node_mask(node, nodes) {
> +		weight = iw_table[node];
> +		weight_total += weight;
> +		weights[node] = weight;
> +	}
> +
> +	/* Continue allocating from most recent node and adjust the nr_pages */
> +	if (pol->wil.cur_weight) {
> +		node = next_node_in(me->il_prev, nodes);
> +		node_pages = pol->wil.cur_weight;
> +		if (node_pages > rem_pages)
> +			node_pages = rem_pages;
> +		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
> +						  NULL, page_array);
> +		page_array += nr_allocated;
> +		total_allocated += nr_allocated;
> +		/* if that's all the pages, no need to interleave */
> +		if (rem_pages <= pol->wil.cur_weight) {
> +			pol->wil.cur_weight -= rem_pages;
> +			return total_allocated;
> +		}
> +		/* Otherwise we adjust nr_pages down, and continue from there */
> +		rem_pages -= pol->wil.cur_weight;
> +		pol->wil.cur_weight = 0;
> +		prev_node = node;

If pol->wil.cur_weight == 0, prev_node will be used without being
initialized below.

> +	}
> +
> +	/* Now we can continue allocating as if from 0 instead of an offset */
> +	rounds = rem_pages / weight_total;
> +	delta = rem_pages % weight_total;
> +	for (i = 0; i < nnodes; i++) {
> +		node = next_node_in(prev_node, nodes);
> +		weight = weights[node];
> +		node_pages = weight * rounds;
> +		if (delta) {
> +			if (delta > weight) {
> +				node_pages += weight;
> +				delta -= weight;
> +			} else {
> +				node_pages += delta;
> +				delta = 0;
> +			}
> +		}
> +		/* We may not make it all the way around */
> +		if (!node_pages)
> +			break;
> +		/* If an over-allocation would occur, floor it */
> +		if (node_pages + total_allocated > nr_pages) {

Why is this possible?

> +			node_pages = nr_pages - total_allocated;
> +			delta = 0;
> +		}
> +		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
> +						  NULL, page_array);
> +		page_array += nr_allocated;
> +		total_allocated += nr_allocated;
> +		prev_node = node;
> +	}
> +
> +	/*
> +	 * Finally, we need to update me->il_prev and pol->wil.cur_weight
> +	 * if there were overflow pages, but not equivalent to the node
> +	 * weight, set the cur_weight to node_weight - delta and the
> +	 * me->il_prev to the previous node. Otherwise if it was perfect
> +	 * we can simply set il_prev to node and cur_weight to 0
> +	 */
> +	if (node_pages) {
> +		me->il_prev = prev_node;
> +		node_pages %= weight;
> +		pol->wil.cur_weight = weight - node_pages;
> +	} else {
> +		me->il_prev = node;
> +		pol->wil.cur_weight = 0;
> +	}
> +
> +	return total_allocated;
> +}
> +
>  static unsigned long alloc_pages_bulk_array_preferred_many(gfp_t gfp, int nid,
>  		struct mempolicy *pol, unsigned long nr_pages,
>  		struct page **page_array)
> @@ -2289,6 +2467,11 @@ unsigned long alloc_pages_bulk_array_mempolicy(gfp_t gfp,
>  		return alloc_pages_bulk_array_interleave(gfp, pol,
>  							 nr_pages, page_array);
>  
> +	if (pol->mode == MPOL_WEIGHTED_INTERLEAVE)
> +		return alloc_pages_bulk_array_weighted_interleave(gfp, pol,
> +								  nr_pages,
> +								  page_array);
> +
>  	if (pol->mode == MPOL_PREFERRED_MANY)
>  		return alloc_pages_bulk_array_preferred_many(gfp,
>  				numa_node_id(), pol, nr_pages, page_array);
> @@ -2364,6 +2547,7 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
>  	case MPOL_INTERLEAVE:
>  	case MPOL_PREFERRED:
>  	case MPOL_PREFERRED_MANY:
> +	case MPOL_WEIGHTED_INTERLEAVE:
>  		return !!nodes_equal(a->nodes, b->nodes);
>  	case MPOL_LOCAL:
>  		return true;
> @@ -2500,6 +2684,10 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
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
> @@ -2874,6 +3062,7 @@ static const char * const policy_modes[] =
>  	[MPOL_PREFERRED]  = "prefer",
>  	[MPOL_BIND]       = "bind",
>  	[MPOL_INTERLEAVE] = "interleave",
> +	[MPOL_WEIGHTED_INTERLEAVE] = "weighted interleave",
>  	[MPOL_LOCAL]      = "local",
>  	[MPOL_PREFERRED_MANY]  = "prefer (many)",
>  };
> @@ -2933,6 +3122,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
>  		}
>  		break;
>  	case MPOL_INTERLEAVE:
> +	case MPOL_WEIGHTED_INTERLEAVE:
>  		/*
>  		 * Default to online nodes with memory if no nodelist
>  		 */
> @@ -3043,6 +3233,7 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
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

