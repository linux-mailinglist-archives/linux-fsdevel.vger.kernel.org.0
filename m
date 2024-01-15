Return-Path: <linux-fsdevel+bounces-7918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCF782D39A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 05:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C251F2143B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 04:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9C523BE;
	Mon, 15 Jan 2024 04:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VvsjGS18"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E62E1FAA;
	Mon, 15 Jan 2024 04:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705292110; x=1736828110;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=7Qsp5bzx6xNs/s0xoZ3nIM0bf+kfLf2cz6nQNuDrFsc=;
  b=VvsjGS18RWlYBnsJZBVB3KKejYEY43vSAZ5jNrW8c/ySlB0oAEvMpefX
   7ILL2nEj6jYeak5fdRC1GaBpRzsoVqS2MGGgDymqhBlAy9Fc8xxGOpjnU
   Eka9VCAgFoYgrmLUz/5aawYYYy6LV5abM4Q68gp+DaBOGHpHh9LSJqI9U
   /aZVQW5TGf0NHlWCQC7czfv/7kPCCtFylTwab5OJux/44HQky8NSsakzZ
   S2cdxcW4GSSOUdM0Jb46G2RGO5lTDvKW3VxwwDzcK0iHt1ECPFnfgTty2
   UtXQTdiLwmhZA/qsjO9uuVhX0Iu7I3fKXS0fTOoGTFtj639MWBFPSq8xp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="6625112"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="6625112"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 20:15:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="786969049"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="786969049"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 20:15:03 -0800
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
Subject: Re: [PATCH 2/3] mm/mempolicy: refactor a read-once mechanism into a
 function for re-use
In-Reply-To: <20240112210834.8035-3-gregory.price@memverge.com> (Gregory
	Price's message of "Fri, 12 Jan 2024 16:08:33 -0500")
References: <20240112210834.8035-1-gregory.price@memverge.com>
	<20240112210834.8035-3-gregory.price@memverge.com>
Date: Mon, 15 Jan 2024 12:13:06 +0800
Message-ID: <87h6jf1bfx.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry.memverge@gmail.com> writes:

> move the use of barrier() to force policy->nodemask onto the stack into
> a function `read_once_policy_nodemask` so that it may be re-used.
>
> Suggested-by: Huang Ying <ying.huang@intel.com>
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> ---
>  mm/mempolicy.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 5da4fd79fd18..0abd3a3394ef 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1907,6 +1907,20 @@ unsigned int mempolicy_slab_node(void)
>  	}
>  }
>  
> +static unsigned int read_once_policy_nodemask(struct mempolicy *pol,
> +					      nodemask_t *mask)

It may be more useful if we define this as memcpy_once().  That can be
used not only for nodemask, but also other data structure.

> +{
> +	/*
> +	 * barrier stabilizes the nodemask locally so that it can be iterated
> +	 * over safely without concern for changes. Allocators validate node
> +	 * selection does not violate mems_allowed, so this is safe.
> +	 */
> +	barrier();
> +	__builtin_memcpy(mask, &pol->nodes, sizeof(nodemask_t));

We don't use __builtin_memcpy() in kernel itself directly.  Although it
is used in kernel tools.  So, I think it's better to use memcpy() here.

> +	barrier();
> +	return nodes_weight(*mask);
> +}
> +
>  /*
>   * Do static interleaving for interleave index @ilx.  Returns the ilx'th
>   * node in pol->nodes (starting from ilx=0), wrapping around if ilx
> @@ -1914,20 +1928,12 @@ unsigned int mempolicy_slab_node(void)
>   */
>  static unsigned int interleave_nid(struct mempolicy *pol, pgoff_t ilx)
>  {
> -	nodemask_t nodemask = pol->nodes;
> +	nodemask_t nodemask;
>  	unsigned int target, nnodes;
>  	int i;
>  	int nid;
> -	/*
> -	 * The barrier will stabilize the nodemask in a register or on
> -	 * the stack so that it will stop changing under the code.
> -	 *
> -	 * Between first_node() and next_node(), pol->nodes could be changed
> -	 * by other threads. So we put pol->nodes in a local stack.
> -	 */
> -	barrier();
>  
> -	nnodes = nodes_weight(nodemask);
> +	nnodes = read_once_policy_nodemask(pol, &nodemask);
>  	if (!nnodes)
>  		return numa_node_id();
>  	target = ilx % nnodes;

--
Best Regards,
Huang, Ying

