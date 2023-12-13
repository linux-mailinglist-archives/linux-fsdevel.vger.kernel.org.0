Return-Path: <linux-fsdevel+bounces-5786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5190C81085C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 03:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC891F21A4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 02:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7DD23AD;
	Wed, 13 Dec 2023 02:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E9K1L8Nk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5B0A1;
	Tue, 12 Dec 2023 18:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702435606; x=1733971606;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=HeA8jqVHlKL8RuAwlVwqlEfSLUf01LuyOK0z4h52XBU=;
  b=E9K1L8NkXiwvE8fDUPMWUEOiMS9H8D41NxJxxGD7pTJwcIqp9QlaqDsq
   h0vDJhhzXywSBBP5IwyqZrCPG3szk7RQ/B+ZdJEbd/6DGfYw/+b6Ua5c4
   JmN2q3cO72YukyM13Kq60uMkctSEzYqBlEm1anIxY6JbmNLjXgVZGDwje
   sPDW3Q/xhfhTa8wlmaMBErgIkgVicdDupxArRzxvj7KxJ2hk0UpZR4nrT
   bzXXWyVOzTdNLIdRZLZxJPZQMdPb23GxAiIiWQEtKpwPGPSuCSxWAT5Z3
   GotW5FtEWlSxoeQwdStJKVDIFnD1ZY3AmcbR1Y7CSEll62/6WkBifmf7e
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="8281547"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="8281547"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 18:46:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="808005595"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="808005595"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 18:46:35 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gregory.price@memverge.com>
Cc: Gregory Price <gourry.memverge@gmail.com>,  <linux-mm@kvack.org>,
  <linux-doc@vger.kernel.org>,  <linux-fsdevel@vger.kernel.org>,
  <linux-api@vger.kernel.org>,  <linux-arch@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <akpm@linux-foundation.org>,
  <arnd@arndb.de>,  <tglx@linutronix.de>,  <luto@kernel.org>,
  <mingo@redhat.com>,  <bp@alien8.de>,  <dave.hansen@linux.intel.com>,
  <x86@kernel.org>,  <hpa@zytor.com>,  <mhocko@kernel.org>,
  <tj@kernel.org>,  <corbet@lwn.net>,  <rakie.kim@sk.com>,
  <hyeongtak.ji@sk.com>,  <honggyu.kim@sk.com>,  <vtavarespetr@micron.com>,
  <peterz@infradead.org>,  <jgroves@micron.com>,
  <ravis.opensrc@micron.com>,  <sthanneeru@micron.com>,
  <emirakhur@micron.com>,  <Hasan.Maruf@amd.com>,
  <seungjun.ha@samsung.com>,  Johannes Weiner <hannes@cmpxchg.org>,  "Hasan
 Al Maruf" <hasanalmaruf@fb.com>,  Hao Wang <haowang3@fb.com>,  Dan
 Williams <dan.j.williams@intel.com>,  Michal Hocko <mhocko@suse.com>,
  Zhongkun He <hezhongkun.hzk@bytedance.com>,  Frank van der Linden
 <fvdl@google.com>,  "John Groves" <john@jagalactic.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 00/11] mempolicy2, mbind2, and weighted interleave
In-Reply-To: <ZXiDSrdNfbv8/Ple@memverge.com> (Gregory Price's message of "Tue,
	12 Dec 2023 10:59:06 -0500")
References: <20231209065931.3458-1-gregory.price@memverge.com>
	<87r0jtxp23.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZXc74yJzXDkCm+BA@memverge.com>
	<87plzbx5hz.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZXiDSrdNfbv8/Ple@memverge.com>
Date: Wed, 13 Dec 2023 10:44:35 +0800
Message-ID: <87zfyestws.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Tue, Dec 12, 2023 at 03:08:24PM +0800, Huang, Ying wrote:
>> Gregory Price <gregory.price@memverge.com> writes:
>> 
>> >> For example, can we use something as below?
>> >> 
>> >>   long set_mempolicy2(int mode, const unsigned long *nodemask, unsigned int *il_weights,
>> >>                           unsigned long maxnode, unsigned long home_node,
>> >>                           unsigned long flags);
>> >> 
>> >>   long mbind2(unsigned long start, unsigned long len,
>> >>                           int mode, const unsigned long *nodemask, unsigned int *il_weights,
>> >>                           unsigned long maxnode, unsigned long home_node,
>> >>                           unsigned long flags);
>> >> 
>> >
>> > Your definition of mbind2 is impossible.
>> >
>> > Neither of these interfaces solve the extensibility issue.  If a new
>> > policy which requires a new format of data arrives, we can look forward
>> > to set_mempolicy3 and mbind3.
>> 
>> IIUC, we will not over-engineering too much.  It's hard to predict the
>> requirements in the future.
>> 
>
> Sure, but having the mempolicy struct at least gives us more flexibility
> than the original interface.
>
>> >> A struct may be defined to hold mempolicy iteself.
>> >> 
>> >> struct mpol {
>> >>         int mode;
>> >>         unsigned int home_node;
>> >>         const unsigned long *nodemask;
>> >>         unsigned int *il_weights;
>> >>         unsigned int maxnode;
>> >> };
>> >> 
>> >
>> > addr could be pulled out for get_mempolicy2, so i will do that
>> >
>> > 'addr_node' and 'policy_node' are warts that came from the original
>> > get_mempolicy.  Removing them increases the complexity of handling
>> > arguments in the common get_mempolicy code.
>> >
>> > I could probably just drop support for retrieving the addr_node from
>> > get_mempolicy2, since it's already possible with get_mempolicy.  So I
>> > will do that.
>> 
>> If it's necessary, we can add another struct for get_mempolicy2().  But
>> I don't think that it's necessary to add get_mempolicy2() specific
>> parameters for set_mempolicy2() or mbind2().
>
> After edits, the only parameter that doesn't have parity between
> interfaces is `addr_node` and `policy_node`.  This was an unfortunate
> wart on the original get_mempolicy() that multiplexed the output of
> (*mode) based on whether MPOL_F_NODE was set.
>
> Example:
> if (MPOL_F_ADDR | MPOL_F_NODE), then get_mempolicy() would return
> details about a VMA mempolicy + the node of that address in (*mode).
>
> Right now in get_mempolicy2() I fetch this unconditionally instead of
> requiring MPOL_F_NODE.  I did not want to multiplexing (*mode) output.
>
> I see two options:
> 1) Get rid of MPOL_F_NODE functionality in get_mempolicy2()
>    If a user wants that information, they can still use get_mempolicy()
>
> 2) Keep MPOL_F_NODE and mpol_args->addr_node/policy_node, but don't allow
>    any future extensions that create this kind of situation.

3) Add another parameter to get_mempolicy2(), such as "unsigned long
*value" to retrieve addr_node or policy_node.  We can extend it to be a
"struct *" in the future if necessary.

> I'm fine with either.  I originally aimed for get_mempolicy2() to be
> all of get_mempolicy() features + new data, but that obviously isn't
> required.

--
Best Regards,
Huang, Ying

