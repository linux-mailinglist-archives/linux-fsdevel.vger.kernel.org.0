Return-Path: <linux-fsdevel+bounces-7152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F1C822726
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 03:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69A31C22CB4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 02:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AFE4A13;
	Wed,  3 Jan 2024 02:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kat+3NEX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066B11802F;
	Wed,  3 Jan 2024 02:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704250080; x=1735786080;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=C5JwH9fEKPVEcWQ0YdUxfI3bk6UZvB0UjPBFwXAKdi0=;
  b=Kat+3NEXPr2C8mm53nn5SPdpVXAXm5afVmfKxD/7AyVwnO65i7gjCXIS
   YSaBeVdm4D0BU3TYwH3s8rTmM/iVEZaaiD9RshVfZ/x2F9r8sWAEPwpcM
   qKATnDqbAoiVK7pMb5lX3MDX2bUsZsYs+oyTVssTAWgNfxmhuY4Pj6Yzu
   pkJU/TQrGR0TmxsM6/bBIHK+DnRPyz2FRV5luRANwM/FKwSedYrrGDo9Z
   8XVzrwAn7oe7QNW/t3PYtmDcBKZPy2ADUdBfALlgAyCt5lRa/gDL5a3Uz
   UMGE7INO7OOht5a/PhKKsnMb2kqBAZW6kMlNAsePvIxBXxMp6Z5ksv798
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="4301210"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="4301210"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 18:47:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="814123225"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="814123225"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 18:47:51 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gregory.price@memverge.com>
Cc: Gregory Price <gourry.memverge@gmail.com>,  <linux-mm@kvack.org>,
  <linux-doc@vger.kernel.org>,  <linux-fsdevel@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-api@vger.kernel.org>,
  <x86@kernel.org>,  <akpm@linux-foundation.org>,  <arnd@arndb.de>,
  <tglx@linutronix.de>,  <luto@kernel.org>,  <mingo@redhat.com>,
  <bp@alien8.de>,  <dave.hansen@linux.intel.com>,  <hpa@zytor.com>,
  <mhocko@kernel.org>,  <tj@kernel.org>,  <corbet@lwn.net>,
  <rakie.kim@sk.com>,  <hyeongtak.ji@sk.com>,  <honggyu.kim@sk.com>,
  <vtavarespetr@micron.com>,  <peterz@infradead.org>,
  <jgroves@micron.com>,  <ravis.opensrc@micron.com>,
  <sthanneeru@micron.com>,  <emirakhur@micron.com>,  <Hasan.Maruf@amd.com>,
  <seungjun.ha@samsung.com>
Subject: Re: [PATCH v5 01/11] mm/mempolicy: implement the sysfs-based
 weighted_interleave interface
In-Reply-To: <ZZRn04IiZhet8peu@memverge.com> (Gregory Price's message of "Tue,
	2 Jan 2024 14:45:23 -0500")
References: <20231223181101.1954-1-gregory.price@memverge.com>
	<20231223181101.1954-2-gregory.price@memverge.com>
	<877cl0f8oo.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZYp3JbcCPQc4fUrB@memverge.com>
	<87h6jwdvxn.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZZRn04IiZhet8peu@memverge.com>
Date: Wed, 03 Jan 2024 10:45:53 +0800
Message-ID: <87wmsrcexq.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Tue, Jan 02, 2024 at 03:41:08PM +0800, Huang, Ying wrote:
>> Gregory Price <gregory.price@memverge.com> writes:
>> 
>> That is, if we use "1" as default weight, we need to change weights of
>> nodes frequently because we haven't a "base" weight.  The best candidate
>> base weight is the weight of DRAM node.  For example, if we set the
>> default weight of DRAM node to be "16" and use that as the base weight,
>> we don't need to change it in most cases.  The weight of other nodes can
>> be set according to the ratio of its memory bandwidth to that of DRAM.
>> 
>> This makes it easy to set the default weight via HMAT/CDAT too.
>> 
>> What do you think about that?
>> 
>
> You're getting a bit ahead of the patch set.  There is "what is a
> reasonable default weight" and "what is the minumum functionality".

I totally agree that we need the minimal functionality firstly.

> The minimum functionality is everything receiving a default weight of 1,
> such that weighted interleave's behavior defaults to round-robin
> interleave. This gets the system off the ground.

I don't think that we need to implement all functionalities now.  But,
we may need to consider more especially if it may impact the user space
interface.  The default base weight is something like that.  If we
change the default base weight from "1" to "16" later, users may be
surprised.  So, I think it's better to discuss it now.

> We can then expose an internal interface to drivers for them to set the
> default weight to some reasonable number during system and device
> initialization. The question at that point is what system is responsible
> for setting the default weights... node? cxl? anything? What happens on
> hotplug? etc.  That seems outside the scope of this patch set.
>
>
> If you want me to add the default_iw_table with special value 0 denoting
> "use default" at each layer, I can do that.
>
> The basic change is this snippet:
> ```
> if (pol->flags & MPOL_F_GWEIGHT)
> 	pol_weights = iw_table;
> else
> 	pol_weights = pol->wil.weights;
>
> for_each_node_mask(nid, nodemask) {
> 	weight = pol_weights[nid];
> 	weight_total += weight;
> 	weights[nid] = weight;
> }
> ```
>
> changes to:
> ```
> for_each_node_mask(nid, nodemask) {
> 	weight = pol->wil.weights[node]
> 	if (!weight)
> 		weight = iw_table[node]
> 	if (!weight)
> 		weight = default_iw_table[node]
> 	weight_total += weight;
> 	weights[nid] = weight
> }
> ```
>
> It's a bit ugly,

We can use a wrapper function to hide the logic.

> but it allows a 0 value to represent "use default",
> and default_iw_table just ends up being initialized to `1` for now.

Because the contents of default_iw_table are just "default weight" for
now.  We don't need it for now.  We can add it later.

> I think it also allows MPOL_F_GWEIGHT to be eliminated.

Do we need a way to distinguish whether to copy the global weights to
local weights when the memory policy is created?  That is, when the
global weights are changed later, will the changes be used?  One
possible solution is

- If no weights are specified in set_mempolicy2(), the global weights
  will be used always.

- If at least one weight is specified in set_mempolicy2(), it will be
  used, and the other weights in global weights will be copied to the
  local weights.  That is, changes to the global weights will not be
  used.

--
Best Regards,
Huang, Ying

