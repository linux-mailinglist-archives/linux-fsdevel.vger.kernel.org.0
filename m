Return-Path: <linux-fsdevel+bounces-8636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A37839E71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD151F29AA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 01:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F3B1FB9;
	Wed, 24 Jan 2024 01:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mkF8tY6k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3921860;
	Wed, 24 Jan 2024 01:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706061206; cv=none; b=M32b8EH0YP+ddVDpBPk3fzZ50r/yIfuD89Ugsab7hmnPY0fCzTTfrZFQuDGyE//gD8gPtiGGtLirtlUqq2dtLCxk6JtbujUBewaaQPUApkMXIR8eCWeO7k9mRBlniOpoY12ETUow4v8XlSKqNLwBPI5UQFej15js/Aqmdu7y34E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706061206; c=relaxed/simple;
	bh=6anV9bsED/SQ83dHNmfrmB1sPazrK8p7SLusz+eOn4Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kwrCqbwisiTMakuBvjQxyvJrlzf+0olHGTOxJN1Mau6wb8zwQ6mBdBC+vIOZndhwZRxPuIywBQaA3z6HHxQuBNSKQgUp7KdpN7jnpCpN1dwWxGnDBGVwus4n7x41skdSUKSM888FogYqhJyFhJxh87eYtPbg/GJ0D90WIZ1Ucfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mkF8tY6k; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706061205; x=1737597205;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=6anV9bsED/SQ83dHNmfrmB1sPazrK8p7SLusz+eOn4Q=;
  b=mkF8tY6kXhBA4rmMuxP2coiDvD99jJBJLm2CjCeOzWJpN5GbnTqQYLYl
   SJ6VaHFpRW2eFmkGZPAGpsZA310CB9n+RYPXWBMKj8Utvxsv7cNWiELqi
   GXDL6wHUtvTu0ggikyvPzbZ546VjcWIBiJwDlwuxjzm3GP29xYyYevE0J
   WU/x1nnN7lqn1mmOVcFo+A+1xC3Y9XZLbYjTx9EO3UZPI8Kq8uqsuLgbP
   R7ds2DlwQy/9dqewnGYlthWLhkiva0jnYZOQK6HWodkRNo4TcWeBQWtZd
   BtyejV6DSuLbsQ74EJzoaPps6ELHo7NMb8qSBg6bHZFWLNfzKo4Fk+0Qd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="9101883"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="9101883"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 17:53:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="735757106"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="735757106"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 17:53:17 -0800
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
Subject: Re: [PATCH v2 3/3] mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE
 for weighted interleaving
In-Reply-To: <ZbAvR+U+tyLvsh8R@memverge.com> (Gregory Price's message of "Tue,
	23 Jan 2024 16:27:35 -0500")
References: <20240119175730.15484-1-gregory.price@memverge.com>
	<20240119175730.15484-4-gregory.price@memverge.com>
	<87jzo0vjkk.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<Za9GiqsZtcfKXc5m@memverge.com> <Za9LnN59SBWwdFdW@memverge.com>
	<87a5owv454.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZbAvR+U+tyLvsh8R@memverge.com>
Date: Wed, 24 Jan 2024 09:51:20 +0800
Message-ID: <87jznzts6f.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Tue, Jan 23, 2024 at 04:35:19PM +0800, Huang, Ying wrote:
>> Gregory Price <gregory.price@memverge.com> writes:
>> 
>> > On Mon, Jan 22, 2024 at 11:54:34PM -0500, Gregory Price wrote:
>> >> > 
>> >> > Can the above code be simplified as something like below?
>> >> > 
>> >> >         resume_node = prev_node;
>> > ---         resume_weight = 0;
>> > +++         resume_weight = weights[node];
>> >> >         for (...) {
>> >> >                 ...
>> >> >         }
>> >> > 
>> >> 
>> >> I'll take another look at it, but this logic is annoying because of the
>> >> corner case:  me->il_prev can be NUMA_NO_NODE or an actual numa node.
>> >> 
>> >
>> > After a quick look, as long as no one objects to (me->il_prev) remaining
>> > NUMA_NO_NODE
>> 
>> MAX_NUMNODES-1 ?
>> 
>
> When setting a new policy, the il_prev gets set to NUMA_NO_NODE. It's

IIUC, it is set to MAX_NUMNODES-1 as below,

@@ -846,7 +858,8 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 
 	old = current->mempolicy;
 	current->mempolicy = new;
-	if (new && new->mode == MPOL_INTERLEAVE)
+	if (new && (new->mode == MPOL_INTERLEAVE ||
+		    new->mode == MPOL_WEIGHTED_INTERLEAVE))
 		current->il_prev = MAX_NUMNODES-1;
 	task_unlock(current);
 	mpol_put(old);

I don't think we need to change this.

> not harmful and is just (-1), which is functionally the same as
> (MAX_NUMNODES-1) for the purpose of iterating the nodemask with
> next_node_in(). So it's fine to set (resume_node = me->il_prev)
> as discussed.
>
> I have a cleaned up function I'll push when i fix up a few other spots.
>
>> > while having a weight assigned to pol->wil.cur_weight,
>> 
>> I think that it is OK.
>> 
>> And, IIUC, pol->wil.cur_weight can be 0, as in
>> weighted_interleave_nodes(), if it's 0, it will be assigned to default
>> weight for the node.
>> 
>
> cur_weight is different than the global weights.  cur_weight tells us
> how many pages are remaining to allocate for the current node.
>
> (cur_weight = 0) can happen in two scenarios:
>   - initial setting of mempolicy (NUMA_NO_NODE w/ cur_weight=0)
>   - weighted_interleave_nodes decrements it down to 0
>
> Now that i'm looking at it - the second condition should not exist, and
> we can eliminate it. The logic in weighted_interleave_nodes is actually
> annoyingly unclear at the moment, so I'm going to re-factor it a bit to
> be more explicit.

I am OK with either way.  Just a reminder, the first condition may be
true in alloc_pages_bulk_array_weighted_interleave() and perhaps some
other places.

--
Best Regards,
Huang, Ying

