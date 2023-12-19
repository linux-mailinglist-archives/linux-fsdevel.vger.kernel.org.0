Return-Path: <linux-fsdevel+bounces-6466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE4781801C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 04:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86AC21C231A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 03:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB03053BD;
	Tue, 19 Dec 2023 03:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AEcUodUF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9143C14AA2;
	Tue, 19 Dec 2023 03:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702955359; x=1734491359;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=AktSGCecR1q5QvnpMNfkj4bUsaYN+EPOsjyaNXsUfSE=;
  b=AEcUodUFvc8EJ1E1hkUiJjUUq28h/ZTNU5AjQiQdqc4Lc/UwRkeVkL2K
   5PKYawdX9wa6o2MXrBZgAZisf8hp17hB+kn4rB+w//H9wKbguBPXGg/6S
   FodSH5Yvu6aahR2RuJTCIGYgf43JaJW6Yp3DDiaBr1iJy38UJ8vVLSt+f
   Ge0FtIjdPUU1GQm4y7wlah68TlHwfa0YtAdPYy1KUMnzdhSEHtdpaDTiM
   TkiKkJDJzwdG6oyWrxIgjhL4VQCwP03rIaZNIy/jW+uMnQBr45ob4BMLn
   j0cWsZo2vzMjhpSRYiLZ6oWWCEv66Wbbqi/aykp41gPsvHoqzIQMoG9V0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2433218"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="2433218"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 19:09:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="1107194605"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="1107194605"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 19:09:10 -0800
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
  emirakhur@micron.com,  Hasan.Maruf@amd.com,  seungjun.ha@samsung.com
Subject: Re: [PATCH v4 11/11] mm/mempolicy: extend set_mempolicy2 and mbind2
 to support weighted interleave
In-Reply-To: <20231218194631.21667-12-gregory.price@memverge.com> (Gregory
	Price's message of "Mon, 18 Dec 2023 14:46:31 -0500")
References: <20231218194631.21667-1-gregory.price@memverge.com>
	<20231218194631.21667-12-gregory.price@memverge.com>
Date: Tue, 19 Dec 2023 11:07:10 +0800
Message-ID: <87sf3ynb4x.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry.memverge@gmail.com> writes:

> Extend set_mempolicy2 and mbind2 to support weighted interleave, and
> demonstrate the extensibility of the mpol_args structure.
>
> To support weighted interleave we add interleave weight fields to the
> following structures:
>
> Kernel Internal:  (include/linux/mempolicy.h)
> struct mempolicy {
> 	/* task-local weights to apply to weighted interleave */
> 	unsigned char weights[MAX_NUMNODES];
> }
> struct mempolicy_args {
> 	/* Optional: interleave weights for MPOL_WEIGHTED_INTERLEAVE */
> 	unsigned char *il_weights;	/* of size MAX_NUMNODES */
> }
>
> UAPI: (/include/uapi/linux/mempolicy.h)
> struct mpol_args {
> 	/* Optional: interleave weights for MPOL_WEIGHTED_INTERLEAVE */
> 	unsigned char *il_weights;	/* of size pol_max_nodes */
> }
>
> The task-local weights are a single, one-dimensional array of weights
> that apply to all possible nodes on the system.  If a node is set in
> the mempolicy nodemask, the weight in `il_weights` must be >= 1,
> otherwise set_mempolicy2() will return -EINVAL.  If a node is not
> set in pol_nodemask, the weight will default to `1` in the task policy.
>
> The default value of `1` is required to handle the situation where a
> task migrates to a set of nodes for which weights were not set (up to
> and including the local numa node).  For example, a migrated task whose
> nodemask changes entirely will have all its weights defaulted back
> to `1`, or if the nodemask changes to include a mix of nodes that
> were not previously accounted for - the weighted interleave may be
> suboptimal.
>
> If migrations are expected, a task should prefer not to use task-local
> interleave weights, and instead utilize the global settings for natural
> re-weighting on migration.
>
> To support global vs local weighting,  we add the kernel-internal flag:
> MPOL_F_GWEIGHT (1 << 5) /* Utilize global weights */
>
> This flag is set when il_weights is omitted by set_mempolicy2(), or
> when MPOL_WEIGHTED_INTERLEAVE is set by set_mempolicy(). This internal
> mode_flag dictates whether global weights or task-local weights are
> utilized by the the various weighted interleave functions:
>
> * weighted_interleave_nodes
> * weighted_interleave_nid
> * alloc_pages_bulk_array_weighted_interleave
>
> if (pol->flags & MPOL_F_GWEIGHT)
> 	pol_weights = iw_table;
> else
> 	pol_weights = pol->wil.weights;
>
> To simplify creations and duplication of mempolicies, the weights are
> added as a structure directly within mempolicy. This allows the
> existing logic in __mpol_dup to copy the weights without additional
> allocations:
>
> if (old == current->mempolicy) {
> 	task_lock(current);
> 	*new = *old;
> 	task_unlock(current);
> } else
> 	*new = *old
>
> Suggested-by: Rakie Kim <rakie.kim@sk.com>
> Suggested-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> Suggested-by: Honggyu Kim <honggyu.kim@sk.com>
> Suggested-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> Co-developed-by: Rakie Kim <rakie.kim@sk.com>
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> Co-developed-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> Co-developed-by: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> Co-developed-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
> Signed-off-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
> ---
>  .../admin-guide/mm/numa_memory_policy.rst     |  10 ++
>  include/linux/mempolicy.h                     |   2 +
>  include/uapi/linux/mempolicy.h                |   2 +
>  mm/mempolicy.c                                | 129 +++++++++++++++++-
>  4 files changed, 139 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
> index 99e1f732cade..0e91efe9e769 100644
> --- a/Documentation/admin-guide/mm/numa_memory_policy.rst
> +++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
> @@ -254,6 +254,8 @@ MPOL_WEIGHTED_INTERLEAVE
>  	This mode operates the same as MPOL_INTERLEAVE, except that
>  	interleaving behavior is executed based on weights set in
>  	/sys/kernel/mm/mempolicy/weighted_interleave/
> +	when configured to utilize global weights, or based on task-local
> +	weights configured with set_mempolicy2(2) or mbind2(2).
>  
>  	Weighted interleave allocations pages on nodes according to
>  	their weight.  For example if nodes [0,1] are weighted [5,2]
> @@ -261,6 +263,13 @@ MPOL_WEIGHTED_INTERLEAVE
>  	2 pages allocated on node1.  This can better distribute data
>  	according to bandwidth on heterogeneous memory systems.
>  
> +	When utilizing task-local weights, weights are not rebalanced
> +	in the event of a task migration.  If a weight has not been
> +	explicitly set for a node set in the new nodemask, the
> +	value of that weight defaults to "1".  For this reason, if
> +	migrations are expected or possible, users should consider
> +	utilizing global interleave weights.
> +
>  NUMA memory policy supports the following optional mode flags:
>  
>  MPOL_F_STATIC_NODES
> @@ -514,6 +523,7 @@ Extended Mempolicy Arguments::
>  		__u16 mode_flags;
>  		__s32 home_node; /* mbind2: policy home node */
>  		__aligned_u64 pol_nodes; /* nodemask pointer */
> +		__aligned_u64 il_weights;  /* u8 buf of size pol_maxnodes */
>  		__u64 pol_maxnodes;
>  		__s32 policy_node; /* get_mempolicy2: policy node information */
>  	};
> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> index aeac19dfc2b6..387c5c418a66 100644
> --- a/include/linux/mempolicy.h
> +++ b/include/linux/mempolicy.h
> @@ -58,6 +58,7 @@ struct mempolicy {
>  	/* Weighted interleave settings */
>  	struct {
>  		unsigned char cur_weight;
> +		unsigned char weights[MAX_NUMNODES];
>  	} wil;
>  };
>  
> @@ -70,6 +71,7 @@ struct mempolicy_args {
>  	unsigned short mode_flags;	/* policy mode flags */
>  	int home_node;			/* mbind: use MPOL_MF_HOME_NODE */
>  	nodemask_t *policy_nodes;	/* get/set/mbind */
> +	unsigned char *il_weights;	/* for mode MPOL_WEIGHTED_INTERLEAVE */
>  	int policy_node;		/* get: policy node information */
>  };
>  
> diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
> index ec1402dae35b..16fedf966166 100644
> --- a/include/uapi/linux/mempolicy.h
> +++ b/include/uapi/linux/mempolicy.h
> @@ -33,6 +33,7 @@ struct mpol_args {
>  	__u16 mode_flags;
>  	__s32 home_node;	/* mbind2: policy home node */
>  	__aligned_u64 pol_nodes;
> +	__aligned_u64 il_weights; /* size: pol_maxnodes * sizeof(char) */
>  	__u64 pol_maxnodes;
>  	__s32 policy_node;	/* get_mempolicy: policy node info */
>  };

You break the ABI you introduced earlier in the patchset.  Although they
are done within a patchset, I don't think that it's a good idea.  I
suggest to finalize the ABI in the first place.  Otherwise, people check
git log will be confused by ABI broken.  This makes it easier to be
reviewed too.

> @@ -75,6 +76,7 @@ struct mpol_args {
>  #define MPOL_F_SHARED  (1 << 0)	/* identify shared policies */
>  #define MPOL_F_MOF	(1 << 3) /* this policy wants migrate on fault */
>  #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
> +#define MPOL_F_GWEIGHT	(1 << 5) /* Utilize global weights */
>  
>  /*
>   * These bit locations are exposed in the vm.zone_reclaim_mode sysctl

--
Best Regards,
Huang, Ying

[snip]

