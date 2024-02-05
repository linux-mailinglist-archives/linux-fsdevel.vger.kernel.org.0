Return-Path: <linux-fsdevel+bounces-10239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C43849380
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 06:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC66E282E4F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 05:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ADABE48;
	Mon,  5 Feb 2024 05:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UYbEG4ns"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01EAB667;
	Mon,  5 Feb 2024 05:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707112251; cv=none; b=UntQzH8ZXCDiUsP1PmUus0VIXTHRCvym61TNVEOGU4I1g/AxtJSfBb0GtJXx2QnV4CKXAl7dR1LKvt8/L/2TTfmhfro6qYnYjn7USrk937l8ABzPL/reETL0rzop3rjhu5wW2RnRSxm8w7F8DxKVQbG0hwvK2wLYVg2f99UMJBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707112251; c=relaxed/simple;
	bh=lSM7C+vUc6UhPUqzZ2Tj67xDB4u+cxvZTB1BWRh9jbE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pHSmu5Cx8w+ZBZxNwZjsdBGMuG//PWLCQQrxf6eKcKqR0R5+IoK6nEX17q1I07OaWRKNvgrE3waeSI4wk5ZfyOHBl43EmBX5wp9LgEXgH0xzVyJtWXAnB1pdhIajENb9oS8kIbWatvp9xGzQaIQIjYluFqtEsJGovTiy4WYzFpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UYbEG4ns; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707112249; x=1738648249;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=lSM7C+vUc6UhPUqzZ2Tj67xDB4u+cxvZTB1BWRh9jbE=;
  b=UYbEG4ns4Vr6SuQRLbaWTwCk7SsjxNJslorXD6lbt5q61j9JojRgkQcL
   CjQTy1CSAzlYkpWUKt0ZNA81vMBPg1xARHH/jXwYLph7+vGGGV+5S9eiP
   acpEdVzcDVT9SV1Ev9fD2s281iErCzhxhV4qB8aqdLVM13iSljA8Su477
   BeGd+JZXEeqHYDCzrugQy66/Om8fb4CkAGVVOzWwKizez/ykLdbdom0LN
   TrTguBP8KfIHw66+t+kzHKT3oElPkkv+4xdl/QKerBx2Wxk+sANLtuM1Z
   MZNQg4W8OsKznZjk/2JAjohZUVBd/sNU1UHO+CK4xNi+ywEN86k+FF+kV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="25900774"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="25900774"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 21:50:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="38038147"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 21:50:41 -0800
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
Subject: Re: [PATCH v5 4/4] mm/mempolicy: protect task interleave functions
 with tsk->mems_allowed_seq
In-Reply-To: <20240202170238.90004-5-gregory.price@memverge.com> (Gregory
	Price's message of "Fri, 2 Feb 2024 12:02:38 -0500")
References: <20240202170238.90004-1-gregory.price@memverge.com>
	<20240202170238.90004-5-gregory.price@memverge.com>
Date: Mon, 05 Feb 2024 13:48:44 +0800
Message-ID: <87r0hr31hf.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry.memverge@gmail.com> writes:

> In the event of rebind, pol->nodemask can change at the same time as an
> allocation occurs.  We can detect this with tsk->mems_allowed_seq and
> prevent a miscount or an allocation failure from occurring.
>
> The same thing happens in the allocators to detect failure, but this
> can prevent spurious failures in a much smaller critical section.
>
> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> ---
>  mm/mempolicy.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index d8cc3a577986..ed0d5d2d456a 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1878,11 +1878,17 @@ bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
>  
>  static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
>  {
> -	unsigned int node = current->il_prev;
> -
> -	if (!current->il_weight || !node_isset(node, policy->nodes)) {
> +	unsigned int node;
> +	unsigned int cpuset_mems_cookie;
> +
> +retry:
> +	/* to prevent miscount use tsk->mems_allowed_seq to detect rebind */
> +	cpuset_mems_cookie = read_mems_allowed_begin();
> +	node = current->il_prev;
> +	if (!node || !node_isset(node, policy->nodes)) {
            ~~~~~
            !current->il_weight ?

--
Best Regards,
Huang, Ying

>  		node = next_node_in(node, policy->nodes);
> -		/* can only happen if nodemask is being rebound */
> +		if (read_mems_allowed_retry(cpuset_mems_cookie))
> +			goto retry;
>  		if (node == MAX_NUMNODES)
>  			return node;
>  		current->il_prev = node;
> @@ -1896,8 +1902,14 @@ static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
>  static unsigned int interleave_nodes(struct mempolicy *policy)
>  {
>  	unsigned int nid;
> +	unsigned int cpuset_mems_cookie;
> +
> +	/* to prevent miscount, use tsk->mems_allowed_seq to detect rebind */
> +	do {
> +		cpuset_mems_cookie = read_mems_allowed_begin();
> +		nid = next_node_in(current->il_prev, policy->nodes);
> +	} while (read_mems_allowed_retry(cpuset_mems_cookie));
>  
> -	nid = next_node_in(current->il_prev, policy->nodes);
>  	if (nid < MAX_NUMNODES)
>  		current->il_prev = nid;
>  	return nid;
> @@ -2374,6 +2386,7 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
>  		struct page **page_array)
>  {
>  	struct task_struct *me = current;
> +	unsigned int cpuset_mems_cookie;
>  	unsigned long total_allocated = 0;
>  	unsigned long nr_allocated = 0;
>  	unsigned long rounds;
> @@ -2391,7 +2404,13 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
>  	if (!nr_pages)
>  		return 0;
>  
> -	nnodes = read_once_policy_nodemask(pol, &nodes);
> +	/* read the nodes onto the stack, retry if done during rebind */
> +	do {
> +		cpuset_mems_cookie = read_mems_allowed_begin();
> +		nnodes = read_once_policy_nodemask(pol, &nodes);
> +	} while (read_mems_allowed_retry(cpuset_mems_cookie));
> +
> +	/* if the nodemask has become invalid, we cannot do anything */
>  	if (!nnodes)
>  		return 0;

