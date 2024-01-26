Return-Path: <linux-fsdevel+bounces-9042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F5C83D546
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 10:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EBBB1C258E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 09:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B0D5EE7C;
	Fri, 26 Jan 2024 07:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YniWX0MJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0265D75B;
	Fri, 26 Jan 2024 07:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706254952; cv=none; b=RTJ+p+9GAzSnVCltgbVyFFgjoTa4UV1vvHenjGlDDEOBFMCZmiLZcaVRU9/n0+i/CQPyNeuBwbioWmOrFZ0Por9JGwXDJQxLmtyrXXGtddXUOmsasDxXoPzObhagx1tVdHfWiOyWVKlfGakXyzl40mjOba0RQENEVKhrxHYrNrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706254952; c=relaxed/simple;
	bh=hB+/FDgOotOkMi7XZ4G7xO3oHXwb0zbrKyD4k6wFPFI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dTbxxbsISoxm4H2Irvd7FUyXML0aaah9Em0niO6bi6BgFVk2bBttHzYGr+vUeIXNEGSJWVONacyDE4iAOFAuJFQYEAafjSeIX8r4IZwK0kMzmxyZlRiHF06PZbLIg9BwjkSL5F/P264Tk2yGJI+D4O1a3WIijL9DxJWBcT15dwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YniWX0MJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706254950; x=1737790950;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=hB+/FDgOotOkMi7XZ4G7xO3oHXwb0zbrKyD4k6wFPFI=;
  b=YniWX0MJzfL6rPSqfBzYn5DGGI+WgQnCOskZrSKhX69BfG0Xg5KmuLK+
   v6crtK8k/9N1u7geJa1cJav/JTp4m0K0jpQU5q39Z6+lFiU6J2WL5pg+u
   O94Gn56jtcaE20OJZ+pUS9yAUZR76LGy7IEpBdpudZrCBfQM2bKv7RxZM
   Yi1LpJJ/DOfRjXtbX/6l8LGy88wWiNfWnbiKKEwFoMwiNDp6YvXjoeKk+
   lBELNnn3y3C/LjM80bUu4ISLdP3WcaDS6NwHapvzlzRLOWMa1jmgkKsBp
   d6VB+XIsanGypc8q+EBZ4L5WTgOCqhe9KMPDJDlxC8b6xDORgUU4IbdUK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="2247860"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2247860"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 23:42:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2523694"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 23:42:24 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gourry.memverge@gmail.com>
Cc: linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-doc@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-api@vger.kernel.org,  corbet@lwn.net,  akpm@linux-foundation.org,
  gregory.price@memverge.com,  honggyu.kim@sk.com,  rakie.kim@sk.com,
  hyeongtak.ji@sk.com,  mhocko@kernel.org,  vtavarespetr@micron.com,
  jgroves@micron.com,  ravis.opensrc@micron.com,  sthanneeru@micron.com,
  emirakhur@micron.com,  Hasan.Maruf@amd.com,  seungjun.ha@samsung.com,
  hannes@cmpxchg.org,  dan.j.williams@intel.com
Subject: Re: [PATCH v3 4/4] mm/mempolicy: change cur_il_weight to atomic and
 carry the node with it
In-Reply-To: <20240125184345.47074-5-gregory.price@memverge.com> (Gregory
	Price's message of "Thu, 25 Jan 2024 13:43:45 -0500")
References: <20240125184345.47074-1-gregory.price@memverge.com>
	<20240125184345.47074-5-gregory.price@memverge.com>
Date: Fri, 26 Jan 2024 15:40:27 +0800
Message-ID: <87sf2klez8.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry.memverge@gmail.com> writes:

> In the prior patch, we carry only the current weight for a weighted
> interleave round with us across calls through the allocator path.
>
> node = next_node_in(current->il_prev, pol->nodemask)
> pol->cur_il_weight <--- this weight applies to the above node
>
> This separation of data can cause a race condition.
>
> If a cgroup-initiated task migration or mems_allowed change occurs
> from outside the context of the task, this can cause the weight to
> become stale, meaning we may end using that weight to allocate
> memory on the wrong node.
>
> Example:
>   1) task A sets (cur_il_weight = 8) and (current->il_prev) to
>      node0. node1 is the next set bit in pol->nodemask
>   2) rebind event occurs, removing node1 from the nodemask.
>      node2 is now the next set bit in pol->nodemask
>      cur_il_weight is now stale.
>   3) allocation occurs, next_node_in(il_prev, nodes) returns
>      node2. cur_il_weight is now applied to the wrong node.
>
> The upper level allocator logic must still enforce mems_allowed,
> so this isn't dangerous, but it is innaccurate.
>
> Just clearing the weight is insufficient, as it creates two more
> race conditions.  The root of the issue is the separation of weight
> and node data between nodemask and cur_il_weight.
>
> To solve this, update cur_il_weight to be an atomic_t, and place the
> node that the weight applies to in the upper bits of the field:
>
> atomic_t cur_il_weight
> 	node bits 32:8
> 	weight bits 7:0
>
> Now retrieving or clearing the active interleave node and weight
> is a single atomic operation, and we are not dependent on the
> potentially changing state of (pol->nodemask) to determine what
> node the weight applies to.
>
> Two special observations:
> - if the weight is non-zero, cur_il_weight must *always* have a
>   valid node number, e.g. it cannot be NUMA_NO_NODE (-1).

IIUC, we don't need that, "MAX_NUMNODES-1" is used instead.

>   This is because we steal the top byte for the weight.
>
> - MAX_NUMNODES is presently limited to 1024 or less on every
>   architecture. This would permanently limit MAX_NUMNODES to
>   an absolute maximum of (1 << 24) to avoid overflows.
>
> Per some reading and discussion, it appears that max nodes is
> limited to 1024 so that zone type still fits in page flags, so
> this method seemed preferable compared to the alternatives of
> trying to make all or part of mempolicy RCU protected (which
> may not be possible, since it is often referenced during code
> chunks which call operations that may sleep).
>
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> ---
>  include/linux/mempolicy.h |  2 +-
>  mm/mempolicy.c            | 93 +++++++++++++++++++++++++--------------
>  2 files changed, 61 insertions(+), 34 deletions(-)
>
> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> index c644d7bbd396..8108fc6e96ca 100644
> --- a/include/linux/mempolicy.h
> +++ b/include/linux/mempolicy.h
> @@ -56,7 +56,7 @@ struct mempolicy {
>  	} w;
>  
>  	/* Weighted interleave settings */
> -	u8 cur_il_weight;
> +	atomic_t cur_il_weight;

If we use this field for node and weight, why not change the field name?
For example, cur_wil_node_weight.

>  };
>  
>  /*
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 5a517511658e..41b5fef0a6f5 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -321,7 +321,7 @@ static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
>  	policy->mode = mode;
>  	policy->flags = flags;
>  	policy->home_node = NUMA_NO_NODE;
> -	policy->cur_il_weight = 0;
> +	atomic_set(&policy->cur_il_weight, 0);
>  
>  	return policy;
>  }
> @@ -356,6 +356,7 @@ static void mpol_rebind_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
>  		tmp = *nodes;
>  
>  	pol->nodes = tmp;
> +	atomic_set(&pol->cur_il_weight, 0);
>  }
>  
>  static void mpol_rebind_preferred(struct mempolicy *pol,
> @@ -973,8 +974,10 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
>  			*policy = next_node_in(current->il_prev, pol->nodes);
>  		} else if (pol == current->mempolicy &&
>  				(pol->mode == MPOL_WEIGHTED_INTERLEAVE)) {
> -			if (pol->cur_il_weight)
> -				*policy = current->il_prev;
> +			int cweight = atomic_read(&pol->cur_il_weight);
> +
> +			if (cweight & 0xFF)
> +				*policy = cweight >> 8;

Please define some helper functions or macros instead of operate on bits
directly.

>  			else
>  				*policy = next_node_in(current->il_prev,
>  						       pol->nodes);

If we record current node in pol->cur_il_weight, why do we still need
curren->il_prev.  Can we only use pol->cur_il_weight?  And if so, we can
even make current->il_prev a union.

--
Best Regards,
Huang, Ying

[snip]

