Return-Path: <linux-fsdevel+bounces-9633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F463843AF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 10:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B739296C02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 09:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6512D6773D;
	Wed, 31 Jan 2024 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wohi/Frx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000A260885;
	Wed, 31 Jan 2024 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692928; cv=none; b=J8UJQ5KBv7R7jCcenqwVp4qz+5O1XFaVcfJap4fz6IhcQI5zaQNECnfagKWT/O+8HJYjskkyJLiWA8+zMc8M0nVveTzJmz7tdBhVqaDR+3v0+IcTj5MrZANH7JGMK3cY3246j4ZZyjJZGRPDhdfFRbCgEVBZqEBPC9cfy+snBYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692928; c=relaxed/simple;
	bh=CIUpGUXPv7s5EVwneVuhL8R9G3KLULjDTGG/TKf9KI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C9bZLv4lchSpi5+CYuxQyK7QyqMP3rgimvDaz+cNzAdEM2NpuhRPiqzax3/H24hfWVwEs2/y5j+qzHpgBTcpHXdtn97038XWgNAQco8R5rCiDLD8fH1W3ZQEfKcEXK+sH5v9n4GLyiJQy/sCv2xZl3bEKXdzswxBKa3at8uTfUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wohi/Frx; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706692927; x=1738228927;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=CIUpGUXPv7s5EVwneVuhL8R9G3KLULjDTGG/TKf9KI0=;
  b=Wohi/FrxDs8Yw8IVCJP877C7l70mB6IXxfzpTxQsRRncNWkrsxzmckIO
   7hucbdRJQ72RB5VUtwJpNV+LbLL5jG9qZHTR0QfUi+sG0prPe5HPLCqlS
   cgCSa998yKOmK9ofOdrrMSCj1x9NmrtdhXYGAtK0DXiGXwzE3o7ZR/cNm
   UqkZlfWrzaUdno3VdwOejzNtCjUYWH2yLs4OBgPqatu09Y7CVBKiPpHVF
   Hp0GRlGh49HrNQDxwMtmcrjQJ/rxuSka88NLXrgwub1bnEpEs6dXzvOpl
   6Lx5tiBAbMiS/JGprmhHDUHa++nfXxdIVo3zypXJ1iKUPO9MRo8TeQmqc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="2480966"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="2480966"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 01:21:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="738034755"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="738034755"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 01:21:47 -0800
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
In-Reply-To: <Zbn6FG3346jhrQga@memverge.com> (Gregory Price's message of "Wed,
	31 Jan 2024 02:43:16 -0500")
References: <20240130182046.74278-1-gregory.price@memverge.com>
	<20240130182046.74278-4-gregory.price@memverge.com>
	<877cjqgfzz.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<Zbn6FG3346jhrQga@memverge.com>
Date: Wed, 31 Jan 2024 17:19:51 +0800
Message-ID: <87y1c5g8qw.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Wed, Jan 31, 2024 at 02:43:12PM +0800, Huang, Ying wrote:
>> Gregory Price <gourry.memverge@gmail.com> writes:
>> >  
>> > +static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
>> > +{
>> > +	unsigned int node = current->il_prev;
>> > +
>> > +	if (!current->il_weight || !node_isset(node, policy->nodes)) {
>> > +		node = next_node_in(node, policy->nodes);
>> > +		/* can only happen if nodemask is being rebound */
>> > +		if (node == MAX_NUMNODES)
>> > +			return node;
>> 
>> I feel a little unsafe to read policy->nodes at same time of writing in
>> rebound.  Is it better to use a seqlock to guarantee its consistency?
>> It's unnecessary to be a part of this series though.
>> 
>
> I think this is handled already? It is definitely an explicit race
> condition that is documented elsewhere:
>
> /*
>  * mpol_rebind_policy - Migrate a policy to a different set of nodes
>  *
>  * Per-vma policies are protected by mmap_lock. Allocations using per-task
>  * policies are protected by task->mems_allowed_seq to prevent a premature
>  * OOM/allocation failure due to parallel nodemask modification.
>  */

Thanks for pointing this out!

If we use task->mems_allowed_seq reader side in
weighted_interleave_nodes() we can guarantee the consistency of
policy->nodes.  That may be not deserved, because it's not a big deal to
allocate 1 page in a wrong node.

It makes more sense to do that in
alloc_pages_bulk_array_weighted_interleave(), because a lot of pages may
be allocated there.

> example from slub:
>
> do {
> 	cpuset_mems_cookie = read_mems_allowed_begin();
> 	zonelist = node_zonelist(mempolicy_slab_node(), pc->flags);
> 	...
> } while (read_mems_allowed_retry(cpuset_mems_cookie));
>
> quick perusal through other allocators, show similar checks.
>
> page_alloc.c  -  check_retry_cpusetset()
> filemap.c     -  filemap_alloc_folio()
>
> If we ever want mempolicy to be swappable from outside the current task
> context, this will have to change most likely - but that's another
> feature for another day.
>

--
Best Regards,
Huang, Ying

