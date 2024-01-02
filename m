Return-Path: <linux-fsdevel+bounces-7063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1B28216CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 05:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C991F2195B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 04:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871E010FD;
	Tue,  2 Jan 2024 04:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SLiEtvaX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15498EC6;
	Tue,  2 Jan 2024 04:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704168666; x=1735704666;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=F8KbSo88fSGtWCt8yc1dnbNMXI7re2ui4GVuvfw30bo=;
  b=SLiEtvaX4HswfMo5pi60kw6KGENsETSUFGZw5Yv6pEHI80MZVqiE16eR
   6sCSAj1MljZdApazv95JlAwtLIepMSoGe1GfXiCrBib6iaKO6f+6JVYxd
   +wBQGZ6wLdNEJyoRRPRjtUxYmOkyvPWiX9cs71Ea6/KI/E9MiygNxYmfs
   SIPi+GVEXbLe+y8HgE2VxMU/wNIIGpcJN9OO+C/eTh/VmW5u9J+l0gD32
   8er3tQVEB7X6yBdsKREVj79zPgzCSegYF1TXA+DGlJY4NNJhITMAwnZsm
   lqRtDduSLLoNOXZGyPQN7T5fVzO65syY5V/n0QB3GUL+R7ZLGK9tm0nAx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="381794251"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="381794251"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 20:11:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="27966578"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 20:10:56 -0800
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
  <seungjun.ha@samsung.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Hasan
 Al Maruf <hasanalmaruf@fb.com>,  Hao Wang <haowang3@fb.com>,  Dan Williams
 <dan.j.williams@intel.com>,  "Michal Hocko" <mhocko@suse.com>,  Zhongkun
 He <hezhongkun.hzk@bytedance.com>,  "Frank van der Linden"
 <fvdl@google.com>,  John Groves <john@jagalactic.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 00/11] mempolicy2, mbind2, and weighted interleave
In-Reply-To: <ZYqAHesihJ+XCCyy@memverge.com> (Gregory Price's message of "Tue,
	26 Dec 2023 02:26:21 -0500")
References: <20231218194631.21667-1-gregory.price@memverge.com>
	<87wmtanba2.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZYHcPiU2IzHr/tbQ@memverge.com>
	<87zfy5libp.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZYqAHesihJ+XCCyy@memverge.com>
Date: Tue, 02 Jan 2024 12:08:57 +0800
Message-ID: <87plyke5ra.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Wed, Dec 20, 2023 at 10:27:06AM +0800, Huang, Ying wrote:
>> Gregory Price <gregory.price@memverge.com> writes:
>> 
>> > Assuming we remove policy_node altogether... do we still break up the
>> > set/get interface into separate structures to avoid this in the future?
>> 
>> I have no much experience at ABI definition.  So, I want to get guidance
>> from more experienced people on this.
>> 
>> Is it good to implement all functionality of get_mempolicy() with
>> get_mempolicy2(), so we can deprecate get_mempolicy() and remove it
>> finally?  So, users don't need to use 2 similar syscalls?
>> 
>> And, IIUC, we will not get policy_node, addr_node, and policy config at
>> the same time, is it better to use a union instead of struct in
>> get_mempolicy2()?
>> 
>
> We discussed using flags to change the operation of mempolicy earlier
> and it was expressed that multiplexing syscalls via flags is no longer
> a preferred design because it increases complexity in the long term.

In general, I agree with that.  "ioctl" isn't the best pattern to define
syscall.

> The mems_allowed extension to get_mempolicy() is basically this kind of
> multiplexing.  So ultimately I think it better to simply remove that
> functionality from get_mempolicy2().
>
> Further: it's not even technically *part* of mempolicy, it's part of
> cpusets, and is accessible via sysfs through some combination of
> cpuset.mems and cpuset.mems.effective.
>
> So the mems_allowed part of get_mempolicy() has already been deprecated
> in that way.  Doesn't seem worth it to add it to mempolicy2.
>
>
> The `policy_node` is more of a question as to whether it's even useful.
> Right now it only applies to interleave policies... but it's also
> insanely racey.  The moment you pluck the next interleave target, it's
> liable to change.  I don't know how anyone would even use this.

Both sounds reasonable for me.  How about add this into the patch
description?  This will help anyone who want to know why the syscall is
defined this way.

> If we drop it, we can alway add it back in with an extension if someone
> actually has a use-case for it and we decide to fully deprecate
> get_mempolicy() (which seems unlikely, btw).

I still think it's possible, after decades.

> In either case, the extension I made allows get_mempolicy() to be used
> to fetch policy_node via the original method, for new policies, so that
> would cover it if anyone is actually using it.

--
Best Regards,
Huang, Ying

