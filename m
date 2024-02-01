Return-Path: <linux-fsdevel+bounces-9794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F33844F4F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 04:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4B71F2CA90
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 03:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B333A1B4;
	Thu,  1 Feb 2024 03:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HvWjrgRi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B4B39FD8;
	Thu,  1 Feb 2024 03:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706756693; cv=none; b=uzKQhZAlrupgGCZr5waaSg+zoycbWdhy13oU9ozKgxm5y7dNa7avRDbWMSagPF11j9Q7ZUsLhEC4GbpFpLuU+wZgXVRtsMqzcGcQwq87IH0m3QWRVjzyWbJdD/tNKaooAAElIFD6NmJW/yAvXxhUVuzgD8qsHnUR+3JX3XIM7oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706756693; c=relaxed/simple;
	bh=GXFw6LRGTigVHPUohOYoyxlMbD7hcQgUJZ58+lT30Dk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y0A7Vres6jysZPiuGGOuYwNUf5oWCEkJoed5DkZutb6kMtGpvPaASEQ+msRpUNzdyNk+cE11Ar1hTBL2cCYQHJY99WTBFHWhWFVImVUYgKaupSwyTWkZ+ZuHzqXRTkPDPdvRgYsBNScZNsZpw67o1Xzxu3nDCLvS6GPrvKXcq9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HvWjrgRi; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706756692; x=1738292692;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=GXFw6LRGTigVHPUohOYoyxlMbD7hcQgUJZ58+lT30Dk=;
  b=HvWjrgRi96X+IdNR0UlHToOg16/Wpp2iTYKJ+fvxffI8Jq9QsM/ceuHF
   Mrst21doldTBqrapYgI0xUQNOPcGDN66yZKvrEx7VelYOpIAx3hm3QiZx
   HjFoL57Df4UblW+HrC8DrjnBQlNpnn7G3UKjanrih7Py6uAjUdxHZZhl6
   N+6ElD3wfJ6woCShibndnw8AIYz8Qt9oeY4t9qdDSvDKLZ5w5RSy63uDz
   N22X9n/O3GH1vy64JI0cbaPI1z0KOQDzBfjKtXrolTU/wme8v3nVdKVTt
   38NYQ89eEXSFEBxJ2qs3GYemJH4Pf+GNbQ5M80KKdvx2PFhoyOXFkQY3Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="22297689"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="22297689"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 19:04:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="961795024"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="961795024"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 19:04:44 -0800
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
  <dan.j.williams@intel.com>,  Srinivasulu Thanneeru
 <sthanneeru.opensrc@micron.com>
Subject: Re: [PATCH v4 3/3] mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE
 for weighted interleaving
In-Reply-To: <Zbr/iv3IfVqhOglE@memverge.com> (Gregory Price's message of "Wed,
	31 Jan 2024 21:18:50 -0500")
References: <20240130182046.74278-1-gregory.price@memverge.com>
	<20240130182046.74278-4-gregory.price@memverge.com>
	<877cjqgfzz.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<Zbn6FG3346jhrQga@memverge.com>
	<87y1c5g8qw.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZbqDgaOsAeXnqRP2@memverge.com>
	<871q9xeyo4.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<Zbr/iv3IfVqhOglE@memverge.com>
Date: Thu, 01 Feb 2024 11:02:47 +0800
Message-ID: <87wmroevjc.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Thu, Feb 01, 2024 at 09:55:07AM +0800, Huang, Ying wrote:
>> Gregory Price <gregory.price@memverge.com> writes:
>> > -       u8 __rcu *table, *weights, weight;
>> > +       u8 __rcu *table, __rcu *weights, weight;
>> 
>> The __rcu usage can be checked with `sparse` directly.  For example,
>> 
>> make C=1 mm/mempolicy.o
>> 
>
> fixed and squashed, all the __rcu usage i had except the global pointer
> have been used.  Thanks for the reference material, was struggling to
> understand that.
>
>> > task->mems_allowed_seq protection (added as 4th patch)
>> > ------------------------------------------------------
>> >
>> > +       cpuset_mems_cookie = read_mems_allowed_begin();
>> >         if (!current->il_weight || !node_isset(node, policy->nodes)) {
>> >                 node = next_node_in(node, policy->nodes);
>> 
>> node will be changed in the loop.  So we need to change the logic here.
>> 
>
> new patch, if it all looks good i'll ship it in v5
>
> ~Gregory
>
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index d8cc3a577986..4e5a640d10b8 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1878,11 +1878,17 @@ bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
>
>  static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
>  {
> -       unsigned int node = current->il_prev;
> -
> -       if (!current->il_weight || !node_isset(node, policy->nodes)) {
> -               node = next_node_in(node, policy->nodes);
> -               /* can only happen if nodemask is being rebound */
> +       unsigned int node;

IIUC, "node" may be used without initialization.

--
Best Regards,
Huang, Ying

> +       unsigned int cpuset_mems_cookie;
> +
> +retry:
> +       /* to prevent miscount use tsk->mems_allowed_seq to detect rebind */
> +       cpuset_mems_cookie = read_mems_allowed_begin();
> +       if (!current->il_weight ||
> +           !node_isset(current->il_prev, policy->nodes)) {
> +               node = next_node_in(current->il_prev, policy->nodes);
> +               if (read_mems_allowed_retry(cpuset_mems_cookie))
> +                       goto retry;
>                 if (node == MAX_NUMNODES)
>                         return node;
>                 current->il_prev = node;
> @@ -1896,8 +1902,14 @@ static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
>  static unsigned int interleave_nodes(struct mempolicy *policy)
>  {
>         unsigned int nid;
> +       unsigned int cpuset_mems_cookie;
> +
> +       /* to prevent miscount, use tsk->mems_allowed_seq to detect rebind */
> +       do {
> +               cpuset_mems_cookie = read_mems_allowed_begin();
> +               nid = next_node_in(current->il_prev, policy->nodes);
> +       } while (read_mems_allowed_retry(cpuset_mems_cookie));
>
> -       nid = next_node_in(current->il_prev, policy->nodes);
>         if (nid < MAX_NUMNODES)
>                 current->il_prev = nid;
>         return nid;
> @@ -2374,6 +2386,7 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
>                 struct page **page_array)
>  {
>         struct task_struct *me = current;
> +       unsigned int cpuset_mems_cookie;
>         unsigned long total_allocated = 0;
>         unsigned long nr_allocated = 0;
>         unsigned long rounds;
> @@ -2391,7 +2404,13 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
>         if (!nr_pages)
>                 return 0;
>
> -       nnodes = read_once_policy_nodemask(pol, &nodes);
> +       /* read the nodes onto the stack, retry if done during rebind */
> +       do {
> +               cpuset_mems_cookie = read_mems_allowed_begin();
> +               nnodes = read_once_policy_nodemask(pol, &nodes);
> +       } while (read_mems_allowed_retry(cpuset_mems_cookie));
> +
> +       /* if the nodemask has become invalid, we cannot do anything */
>         if (!nnodes)
>                 return 0;

