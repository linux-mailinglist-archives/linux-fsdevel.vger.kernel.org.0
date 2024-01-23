Return-Path: <linux-fsdevel+bounces-8512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75598388AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 09:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 441ABB24A27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 08:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC5156756;
	Tue, 23 Jan 2024 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dBCMBJgn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E926121;
	Tue, 23 Jan 2024 08:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705997748; cv=none; b=PN56ktQ8sVhz3aXw3z2lTFbh7WIjUEJ1VPkwOtRTrDUqAO/iYH3/Op/pndVQSrOGT6i3w4ScWSbyHBf2gHq3GqTGCiwB5j3tmJgEFIpRudkpZ/5MTgiwTctgg0FYbfqT13e3IN6U5YVkPcFVK1UBW99hsNww/n3M6Zr2cxlvQuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705997748; c=relaxed/simple;
	bh=Q9cZM58uRpptNUZAKXZJSLxxlo/oFlDoWc5U0H4XU38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sXAvKcD7Lb9s4xOYOZ155riZrUBaMq2nzCUUv1xlYrJhXZzgyMjjldgmC7S9IUP9OOiJSvPWQA7sqLUtitHFrO9gS/MXAlX6tkRZ+nk4fSYbNHEvXvPZh4uQdpmXkW5xn8Jd6WzW+BoAgAjrVssyBuqRQ/CQfCp80HMP1T91ax4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dBCMBJgn; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705997746; x=1737533746;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Q9cZM58uRpptNUZAKXZJSLxxlo/oFlDoWc5U0H4XU38=;
  b=dBCMBJgnnZxxyK0erbvktvEXpropBlY20o+40ErPDqu2eqqtJsmai7xK
   OkGDNTiOH1BS/M/JGmYjOxb61OLRIqasy7/uWLc6YqiV3Gnd0XUu9l5Go
   JFK7Pgwm7Nzd/WW6Z7ZebVO0PYmQjNUkXlnPNPl5M3tH2/FxoFsp8rki0
   07O/yRWBzxvzEOVKT0jj4C2642kPmxgsyG3QDTYHWzNgx4tAjq3E7brca
   7P9b7fyVIkvdlWxaIp4zM6/KR+JjsOfO0heSqiK8BcEvjE2Eb4qztMcob
   myX0/GR0zkcQ3YBm+BBRrDb8hcJNYtlB/4JqCZ4E4+Nkn3Oz23ugdJ0Pr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="432610289"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="432610289"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 00:15:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="929264349"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="929264349"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 00:15:39 -0800
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
In-Reply-To: <Za9GiqsZtcfKXc5m@memverge.com> (Gregory Price's message of "Mon,
	22 Jan 2024 23:54:34 -0500")
References: <20240119175730.15484-1-gregory.price@memverge.com>
	<20240119175730.15484-4-gregory.price@memverge.com>
	<87jzo0vjkk.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<Za9GiqsZtcfKXc5m@memverge.com>
Date: Tue, 23 Jan 2024 16:13:43 +0800
Message-ID: <87ede8v554.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Tue, Jan 23, 2024 at 11:02:03AM +0800, Huang, Ying wrote:
>> Gregory Price <gourry.memverge@gmail.com> writes:
>> 
>> > +	int prev_node = NUMA_NO_NODE;
>> 
>> It appears that we should initialize prev_node with me->il_prev?
>> Details are as below.
>> 
>
> yeah good catch, was a rebase error from my tested code, where this is
> the case.  patching now.
>
>> > +		if (rem_pages <= pol->wil.cur_weight) {
>> > +			pol->wil.cur_weight -= rem_pages;
>> 
>> If "pol->wil.cur_weight == 0" here, we need to change me->il_prev?
>> 
> you are right, and also need to fetch the next cur_weight.  Seems I
> missed this specific case in my tests.  (had this tested with a single
> node but not 2, so it looked right).
>
> Added to my test suite.
>
>> We can replace "weight_nodes" with "i" and use a "for" loop?
>> 
>> > +	while (weight_nodes < nnodes) {
>> > +		node = next_node_in(prev_node, nodes);
>> 
>> IIUC, "node" will not change in the loop, so all "weight" below will be
>> the same value.  To keep it simple, I think we can just copy weights
>> from the global iw_table and consider the default value?
>> 
>
> another rebase error here from my tested code, this should have been
> node = prev_node;
> while (...)
>     node = next_node_in(node, nodes);
>
> I can change it to a for loop as suggested, but for more info on why I
> did it this way, see the chunk below
>
>> > +		} else if (!delta_depleted) {
>> > +			/* if there was no delta, track last allocated node */
>> > +			resume_node = node;
>> > +			resume_weight = i < (nnodes - 1) ? weights[i+1] :
>> > +							   weights[0];
>                         ^ this line acquires the weight of the *NEXT* node
> 			  another chunk prior to this does the same
> 			  thing.  I suppose i can use next_node_in()
> 			  instead and just copy the entire weigh array
> 			  though, if that is preferable.

Yes.  I think copy the entire weight array make code logic simpler.

--
Best Regards,
Huang, Ying

