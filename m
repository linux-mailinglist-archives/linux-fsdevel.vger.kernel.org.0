Return-Path: <linux-fsdevel+bounces-8215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D9B8310E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 02:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B751F21BF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 01:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0736A23D8;
	Thu, 18 Jan 2024 01:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cMuIYTId"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC416184C;
	Thu, 18 Jan 2024 01:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705541453; cv=none; b=h+Mhk+BesyIVo0jZz8myLbJOFMeKlMjYmavn4XuO9m2dPlU0gyP3/rhz8FvpIB4WlTzr6mjofUQ+y39pKZzV6aWM41iX3XnSW8LweEji5IYhkpZCoN4Ay4rgxLp9A9sYtnOx3MFTz9qzFwSGIiySWWEcI+xXdx1p2jT+e1DPVIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705541453; c=relaxed/simple;
	bh=D229WF9ZvcRgm1yTACUcXfbL9j+/sJR8sCIdjdqxFcU=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:User-Agent:MIME-Version:Content-Type; b=SImT3ZVTVvTEJ8BTRrmQynbopaQvGm7JmniukGnPK+3G7/FasxOXSYBBEtiWwH8HoktfStUR4YZS36bhrc0ciS+gKAAWCo7OMiMlQXn66I0Np5rfRNTmb6EXgjPnzEvmvfkNorp2BFhMAaG+mb5cUAqEH3oRpLr3tWqH9RsKs1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cMuIYTId; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705541452; x=1737077452;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=D229WF9ZvcRgm1yTACUcXfbL9j+/sJR8sCIdjdqxFcU=;
  b=cMuIYTIdO8ojwgDt+sm+VnOyPtBz5SaFAGgH5Jovn5keIGxak9rODqbj
   59ftpfXz1MvSAxSBffMoZMUapYHtjfe1LximiMVXdc1u6+4yTHmmJU5Hx
   zsWUTLxvfIo31HgSs3ksrbzhORldiROBwkvWjzd2c7nSA5B7VHUg5MiaV
   Uxn2n0oCFvbB4C07iv75g2/6SxBPd90ZjAI/MFc0S+SW1VS5RACDtj1yf
   CxBrIWoXFLvOeSXmzaslteAfawQncG7Kzf80TQuPWF4cbBSJQFJzYPxZY
   yr4XJReZGHVQMpTt35JNPq0h/R10D1Lhg2cxrjJEc7VjGU6RGTY/0or+N
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7078968"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="7078968"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 17:30:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="180492"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 17:30:47 -0800
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
Subject: Re: [PATCH 3/3] mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE
 for weighted interleaving
In-Reply-To: <Zadm5r/23tonKeXB@memverge.com> (Gregory Price's message of "Wed,
	17 Jan 2024 00:34:30 -0500")
References: <20240112210834.8035-1-gregory.price@memverge.com>
	<20240112210834.8035-4-gregory.price@memverge.com>
	<87bk9n172k.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<Zadm5r/23tonKeXB@memverge.com>
Date: Thu, 18 Jan 2024 09:28:49 +0800
Message-ID: <87jzo7zay6.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Mon, Jan 15, 2024 at 01:47:31PM +0800, Huang, Ying wrote:
>> Gregory Price <gourry.memverge@gmail.com> writes:
>> 
>> > +	/* Continue allocating from most recent node and adjust the nr_pages */
>> > +	if (pol->wil.cur_weight) {
>> > +		node = next_node_in(me->il_prev, nodes);
>> > +		node_pages = pol->wil.cur_weight;
>> > +		if (node_pages > rem_pages)
>> > +			node_pages = rem_pages;
>> > +		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
>> > +						  NULL, page_array);
> ... snip ...
>> > +			if (delta > weight) {
>> > +				node_pages += weight;
>> > +				delta -= weight;
>> > +			} else {
>> > +				node_pages += delta;
>> > +				delta = 0;
>> > +			}
>> > +		}
>> > +		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
>> > +						  NULL, page_array);
>> 
>> Should we check nr_allocated here?  Allocation may fail anyway.
>> 
>
> I thought about this briefly in both situations.
>
> If you look at alloc_pages_bulk_array_interleave(), it does not fail if
> __alloc_pages_bulk() fails, instead it continues and attempts to
> allocate from the remaining nodes.
>
> Presumably, this is because the caller of the bulk allocator can accept
> a partial-failure and will go ahead and allocate the remaining pages on
> an extra slow path.
>
> Since alloc_pages_bulk_array_interleave() appears to be capable of
> failing in the exact same way, I considered this safe.

You are right.  We should proceed with next node here.

--
Best Regards,
Huang, Ying

>> > +	if (pol->mode == MPOL_WEIGHTED_INTERLEAVE)
>> > +		return alloc_pages_bulk_array_weighted_interleave(gfp, pol,
>> > +								  nr_pages,
>> > +								  page_array);
>> > +
>> 
>> Just nit-pick, may be better to be 
>> 
>> 		return alloc_pages_bulk_array_weighted_interleave(
>>                                 gfp, pol, nr_pages, page_array);
>>
>
> Wasn't sure on style when names get this long lol, will make the change
> :]
>
>
>
> Probably v2 thursday or friday
>
> Regards
> ~Gregory

