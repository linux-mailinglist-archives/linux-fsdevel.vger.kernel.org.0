Return-Path: <linux-fsdevel+bounces-9788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7F7844EE8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 02:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0DC31C247A4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 01:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06D01079B;
	Thu,  1 Feb 2024 01:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nQ9No+Gv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00040EAE3;
	Thu,  1 Feb 2024 01:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706752632; cv=none; b=VcRa2q8RU2hxghCfgSil8uVkBlrNs259l84jjFDZPRw99ggismNafKeXZtChHDRFua0Q+Kno/0oYbcy6FB1Fzf9auRC0D/Amun2IC3sNDtM4AqJq35ju9eD7AkII0/lS5JR4AgjBvgckMfrndR+vrpaeHYZtUE9wVAHc1Bd5MZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706752632; c=relaxed/simple;
	bh=jg8fsA7gXRgMZuwES+GCMsjZx4lbadXYHh8Ji9UDptE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AXr/ApTQxaN+3NjWe/TDwucjlAUCtuvgzPrdvS+r8Oh6vl/zH4AKmX05mYvy3f1OAJBKqDobaUdLK0A7TAtPpg+ZYxxdgHmuIS99JA1yVw08JDlYJ+l3gcf3n9+jSDqxrOu6114poAA2nwb6gDiYe9yo2m3sYw2T36inBeVzass=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nQ9No+Gv; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706752630; x=1738288630;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=jg8fsA7gXRgMZuwES+GCMsjZx4lbadXYHh8Ji9UDptE=;
  b=nQ9No+GvJtvZHfiYfhzbVedpcnxoQNm7U5i4h2OnpIOj80CBBydLyjcU
   QmmMJuylXYwKDPJEcWY+cv7pGivLZs3Quz9zetoYsUf67JXwj5PGHRH55
   dYPsAU3ADRrqXIJUTUWMQ+qiHa5VzuSBzZbapaK7AYI8KY/C13N/wSG/z
   MgCcYjNgYj+J4vbdp776W3Rsb1WdPvW6lv8oOSDM/6cXHgCMBSG+ddRPu
   e9F+i5QZAuhpjUyCRq0mgokOlLjGA4s/RX1ALqUDEGHPLwdP9I6w+Yhu4
   XXQomyt1rWJuvszRm6SFQIIZGrPcQCwmnMSIss7ylgVCGWnVL0msZNZ8x
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="394228897"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="394228897"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:57:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="4375381"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:57:04 -0800
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
In-Reply-To: <ZbqDgaOsAeXnqRP2@memverge.com> (Gregory Price's message of "Wed,
	31 Jan 2024 12:29:37 -0500")
References: <20240130182046.74278-1-gregory.price@memverge.com>
	<20240130182046.74278-4-gregory.price@memverge.com>
	<877cjqgfzz.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<Zbn6FG3346jhrQga@memverge.com>
	<87y1c5g8qw.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZbqDgaOsAeXnqRP2@memverge.com>
Date: Thu, 01 Feb 2024 09:55:07 +0800
Message-ID: <871q9xeyo4.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Wed, Jan 31, 2024 at 05:19:51PM +0800, Huang, Ying wrote:
>> Gregory Price <gregory.price@memverge.com> writes:
>> 
>> >
>> > I think this is handled already? It is definitely an explicit race
>> > condition that is documented elsewhere:
>> >
>> > /*
>> >  * mpol_rebind_policy - Migrate a policy to a different set of nodes
>> >  *
>> >  * Per-vma policies are protected by mmap_lock. Allocations using per-task
>> >  * policies are protected by task->mems_allowed_seq to prevent a premature
>> >  * OOM/allocation failure due to parallel nodemask modification.
>> >  */
>> 
>> Thanks for pointing this out!
>> 
>> If we use task->mems_allowed_seq reader side in
>> weighted_interleave_nodes() we can guarantee the consistency of
>> policy->nodes.  That may be not deserved, because it's not a big deal to
>> allocate 1 page in a wrong node.
>> 
>> It makes more sense to do that in
>> alloc_pages_bulk_array_weighted_interleave(), because a lot of pages may
>> be allocated there.
>> 
>
> To save the versioning if there are issues, here are the 3 diffs that
> I have left. If you are good with these changes, I'll squash the first
> 2 into the third commit, keep the last one as a separate commit (it
> changes the interleave_nodes() logic too), and submit v5 w/ your
> reviewed tag on all of them.
>
>
> Fix one (pedantic?) warning from syzbot:
> ----------------------------------------
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index b1437396c357..dfd097009606 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2391,7 +2391,7 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
>         unsigned long nr_allocated = 0;
>         unsigned long rounds;
>         unsigned long node_pages, delta;
> -       u8 __rcu *table, *weights, weight;
> +       u8 __rcu *table, __rcu *weights, weight;

The __rcu usage can be checked with `sparse` directly.  For example,

make C=1 mm/mempolicy.o

More details can be found in

https://www.kernel.org/doc/html/latest/dev-tools/sparse.html

Per my understanding, we shouldn't use "__rcu" here.  Please search
"__rcu" in the following document.

https://www.kernel.org/doc/html/latest/RCU/checklist.html

>         unsigned int weight_total = 0;
>         unsigned long rem_pages = nr_pages;
>         nodemask_t nodes;
>
>
>
> Simplifying resume_node/weight logic:
> -------------------------------------
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 2c1aef8eab70..b0ca9bcdd64c 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2405,15 +2405,9 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
>                 page_array += nr_allocated;
>                 total_allocated += nr_allocated;
>                 /* if that's all the pages, no need to interleave */
> -               if (rem_pages < weight) {
> -                       /* stay on current node, adjust il_weight */
> +               if (rem_pages <= weight) {
>                         me->il_weight -= rem_pages;
>                         return total_allocated;
> -               } else if (rem_pages == weight) {
> -                       /* move to next node / weight */
> -                       me->il_prev = next_node_in(node, nodes);
> -                       me->il_weight = get_il_weight(me->il_prev);
> -                       return total_allocated;
>                 }
>                 /* Otherwise we adjust remaining pages, continue from there */
>                 rem_pages -= weight;
> @@ -2460,17 +2454,10 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
>                         node_pages += weight;
>                         delta -= weight;
>                 } else if (delta) {
> +                       /* when delta is deleted, resume from that node */
                                           ~~~~~~~
                                           depleted?


>                         node_pages += delta;
> -                       /* delta may deplete on a boundary or w/ a remainder */
> -                       if (delta == weight) {
> -                               /* boundary: resume from next node/weight */
> -                               resume_node = next_node_in(node, nodes);
> -                               resume_weight = weights[resume_node];
> -                       } else {
> -                               /* remainder: resume this node w/ remainder */
> -                               resume_node = node;
> -                               resume_weight = weight - delta;
> -                       }
> +                       resume_node = node;
> +                       resume_weight = weight - delta;
>                         delta = 0;
>                 }
>                 /* node_pages can be 0 if an allocation fails and rounds == 0 */
>
>
>
>
>
> task->mems_allowed_seq protection (added as 4th patch)
> ------------------------------------------------------
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index b0ca9bcdd64c..b1437396c357 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1879,10 +1879,15 @@ bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
>  static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
>  {
>         unsigned int node = current->il_prev;
> +       unsigned int cpuset_mems_cookie;
>
> +retry:
> +       /* to prevent miscount use tsk->mems_allowed_seq to detect rebind */
> +       cpuset_mems_cookie = read_mems_allowed_begin();
>         if (!current->il_weight || !node_isset(node, policy->nodes)) {
>                 node = next_node_in(node, policy->nodes);

node will be changed in the loop.  So we need to change the logic here.

> -               /* can only happen if nodemask is being rebound */
> +               if (read_mems_allowed_retry(cpuset_mems_cookie))
> +                       goto retry;
>                 if (node == MAX_NUMNODES)
>                         return node;
>                 current->il_prev = node;
> @@ -1896,10 +1901,17 @@ static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
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
> +
>         return nid;
>  }
>
> @@ -2374,6 +2386,7 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
>                 struct page **page_array)
>  {
>         struct task_struct *me = current;
> +       unsigned int cpuset_mems_cookie;
>         unsigned long total_allocated = 0;
>         unsigned long nr_allocated = 0;
>         unsigned long rounds;
> @@ -2388,10 +2401,17 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
>         int prev_node;
>         int i;
>
> +

Change by accident?

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

--
Best Regards,
Huang, Ying

