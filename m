Return-Path: <linux-fsdevel+bounces-9327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BC683FFEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 09:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1C6BB22A0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 08:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D463452F81;
	Mon, 29 Jan 2024 08:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JIhpEHYY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551C652F7D;
	Mon, 29 Jan 2024 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706516393; cv=none; b=CpRrJAC2ll/imTZJ2P/FSxufAu+JG1YjoHf5cn+/WAmQhKBEc4CgrLI0L+kLpHwW2bGaoHy6KgJYIBSuW9UpIyIErW1jGgZPemP7HpH+04xlHbjUCEEAzhOKh2cG7lDQvL8nGRTmC06l9T85rz2uaPCEz6uAzGI3/t1TqHT/TqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706516393; c=relaxed/simple;
	bh=q9yLJZ27jvLejI0DqUZQHKwFIPnOnNb3BDVtGNN+2V8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RJYQJ6u/J1sVUml+D6zngjlqj+H9vl+rpshN8y15mM9mjYIqMP5KQxFvwkYUsJxKjmdtn7haKMX7sQMpBDnKfi4Xg0qqAdrEs6DiXUhQyP5XHeEkUn3NIUroX5Qu0FHmx7Im6r9F/w4iSQPPiDva1jok24dTk/0VeyhO7YPz/Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JIhpEHYY; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706516391; x=1738052391;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=q9yLJZ27jvLejI0DqUZQHKwFIPnOnNb3BDVtGNN+2V8=;
  b=JIhpEHYYMvTxRTFQDg0GX6eNZ8ZrelCTytzl6lu3MLSj8do4/hyeMKdr
   Pxr61zTtMSIsq6v8Ng5HsbrffwCcCKBWp5xxrRQr4ApC1xndMde+HBIYu
   UcjWBmn+tDgGOQQNyY1A4JYZe39PIvX7c76rGpS97oGoMjBfyUHyv/Yie
   puqXR4o8//dVHWt4KTttEn4MVPMcQDpO5WUUOx+CHi4H82k3hw9uXG1hb
   cXC4HRGKBOrcEv8bpVq//efrh+O6Bjtzk6uWpJNbrOg4xZRtJskdvH2Hn
   MVsMdx/90lTxckoJwhLIlyUYUAFTGCS7axdUQxvy9e07n8i3KHfJHrD3H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="406609298"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="406609298"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 00:19:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="29701150"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 00:19:43 -0800
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
  <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 4/4] mm/mempolicy: change cur_il_weight to atomic and
 carry the node with it
In-Reply-To: <ZbPf6d2cQykdl3Eb@memverge.com> (Gregory Price's message of "Fri,
	26 Jan 2024 11:38:01 -0500")
References: <20240125184345.47074-1-gregory.price@memverge.com>
	<20240125184345.47074-5-gregory.price@memverge.com>
	<87sf2klez8.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZbPf6d2cQykdl3Eb@memverge.com>
Date: Mon, 29 Jan 2024 16:17:46 +0800
Message-ID: <877cjsk0yd.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Fri, Jan 26, 2024 at 03:40:27PM +0800, Huang, Ying wrote:
>> Gregory Price <gourry.memverge@gmail.com> writes:
>> 
>> > Two special observations:
>> > - if the weight is non-zero, cur_il_weight must *always* have a
>> >   valid node number, e.g. it cannot be NUMA_NO_NODE (-1).
>> 
>> IIUC, we don't need that, "MAX_NUMNODES-1" is used instead.
>> 
>
> Correct, I just thought it pertinent to call this out explicitly since
> I'm stealing the top byte, but the node value has traditionally been a
> full integer.
>
> This may be relevant should anyone try to carry, a random node value
> into this field. For example, if someone tried to copy policy->home_node
> into cur_il_weight for whatever reason.
>
> It's worth breaking out a function to defend against this - plus to hide
> the bit operations directly as you recommend below.
>
>> >  	/* Weighted interleave settings */
>> > -	u8 cur_il_weight;
>> > +	atomic_t cur_il_weight;
>> 
>> If we use this field for node and weight, why not change the field name?
>> For example, cur_wil_node_weight.
>> 
>
> ack.
>
>> > +			if (cweight & 0xFF)
>> > +				*policy = cweight >> 8;
>> 
>> Please define some helper functions or macros instead of operate on bits
>> directly.
>> 
>
> ack.
>
>> >  			else
>> >  				*policy = next_node_in(current->il_prev,
>> >  						       pol->nodes);
>> 
>> If we record current node in pol->cur_il_weight, why do we still need
>> curren->il_prev.  Can we only use pol->cur_il_weight?  And if so, we can
>> even make current->il_prev a union.
>> 
>
> I just realized that there's a problem here for shared memory policies.
>
> from weighted_interleave_nodes, I do this:
>
> cur_weight = atomic_read(&policy->cur_il_weight);
> ...
> weight--;
> ...
> atomic_set(&policy->cur_il_weight, cur_weight);
>
> On a shared memory policy, this is a race condition.
>
>
> I don't think we can combine il_prev and cur_wil_node_weight because
> the task policy may be different than the current policy.
>
> i.e. it's totally valid to do the following:
>
> 1) set_mempolicy(MPOL_INTERLEAVE)
> 2) mbind(..., MPOL_WEIGHTED_INTERLEAVE)
>
> Using current->il_prev between these two policies, is just plain incorrect,
> so I will need to rethink this, and the existing code will need to be
> updated such that weighted_interleave does not use current->il_prev.

IIUC, weighted_interleave_nodes() is only used for mempolicy of tasks
(set_mempolicy()), as in the following code.

+		*nid = (ilx == NO_INTERLEAVE_INDEX) ?
+			weighted_interleave_nodes(pol) :
+			weighted_interleave_nid(pol, ilx);

But, in contrast, it's bad to put task-local "current weight" in
mempolicy.  So, I think that it's better to move cur_il_weight to
task_struct.  And maybe combine it with current->il_prev.

--
Best Regards,
Huang, Ying

