Return-Path: <linux-fsdevel+bounces-8513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2C7838937
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 09:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06621F28DBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 08:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A555787B;
	Tue, 23 Jan 2024 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XnU4Jqo7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A5257327;
	Tue, 23 Jan 2024 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999046; cv=none; b=tT75GUB37yuOPmp3cPGWg1IYLWYz1uTmm+Rq0OQjEXPWqOUs46XYeNDsn3JhUNmyyb2xIPjVT153E64teTYXTH0viArXqkwMrfK88Y6ftiY+nyF1LULQmbRZAYn1VwvKPlG2o7v6EsuronHerJzyppX3JKMXqGiNX1CxDs1bZnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999046; c=relaxed/simple;
	bh=i3fm9I0AtALKEDU1lFQLDOyc8qHvrAP7w0tD+wvw694=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lSUb+JAfWcWKStRypJFoCUQk161iWlI/JGtGnfMohiWJs76vAMaUcHgvuHJmbx6q3hntu/qB1o8vv+5EeDoGupVVaIHsWu/j3iZXy59rR8b2l94US5GPHgqb6cdoB6zLNtvJ6RpLKKU0utulfuIwKFsGGAAJXqCKXl8ZfVxHCrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XnU4Jqo7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705999044; x=1737535044;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=i3fm9I0AtALKEDU1lFQLDOyc8qHvrAP7w0tD+wvw694=;
  b=XnU4Jqo7GuQZuCNyljLjK63RufcYaMzICzcl4HutzhaT7PJ+zhxhbUco
   GwMfyKz9vzRTxaP4umXoujikvDN3RgmCnPf0S++dk0w47926TWlsq5PbY
   hR6eLcGbnleQPY75gpB3stA6MFbFTkZ2SrJLY0c0k2PqywqjzeAx4F499
   ZLLDK5VRvPuD+lfmnSubeZFxEMSxOYGsU01VY6tgTJtXHjNtzTahmEETB
   3UkZwQ3QVxHbhKIBFhJ6eptJPHQrNv0uHf0ym+nROltRv04xdVMCO3VVf
   QO4KeO8roOBovtXd3ZwwnahOL2M/vDJ1R3wD/HuoDdrGNPUAJkXc8NqIs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="1339952"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="1339952"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 00:37:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="20261546"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 00:37:16 -0800
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
In-Reply-To: <Za9LnN59SBWwdFdW@memverge.com> (Gregory Price's message of "Tue,
	23 Jan 2024 00:16:12 -0500")
References: <20240119175730.15484-1-gregory.price@memverge.com>
	<20240119175730.15484-4-gregory.price@memverge.com>
	<87jzo0vjkk.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<Za9GiqsZtcfKXc5m@memverge.com> <Za9LnN59SBWwdFdW@memverge.com>
Date: Tue, 23 Jan 2024 16:35:19 +0800
Message-ID: <87a5owv454.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Mon, Jan 22, 2024 at 11:54:34PM -0500, Gregory Price wrote:
>> > 
>> > Can the above code be simplified as something like below?
>> > 
>> >         resume_node = prev_node;
> ---         resume_weight = 0;
> +++         resume_weight = weights[node];
>> >         for (...) {
>> >                 ...
>> >         }
>> > 
>> 
>> I'll take another look at it, but this logic is annoying because of the
>> corner case:  me->il_prev can be NUMA_NO_NODE or an actual numa node.
>> 
>
> After a quick look, as long as no one objects to (me->il_prev) remaining
> NUMA_NO_NODE

MAX_NUMNODES-1 ?

> while having a weight assigned to pol->wil.cur_weight,

I think that it is OK.

And, IIUC, pol->wil.cur_weight can be 0, as in
weighted_interleave_nodes(), if it's 0, it will be assigned to default
weight for the node.

> then
> this looks like it can be simplified as above.
>
> I don't think it's harmful, but i'll have to take a quick look at what
> happens on rebind to make sure we don't have a stale weight.

Make sense.

--
Best Regards,
Huang, Ying

