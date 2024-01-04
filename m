Return-Path: <linux-fsdevel+bounces-7344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0042E823BD4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 06:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931761F25426
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 05:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493F118E02;
	Thu,  4 Jan 2024 05:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+1dSZej"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D491D68F;
	Thu,  4 Jan 2024 05:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704346896; x=1735882896;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=zU+PrLqJJBCnhHcPG8wQ+xY16mmjmcFQBKH/0T898HU=;
  b=N+1dSZejAxYbxJJZEYa9eJalXy268cTQyEYhZcS85SE40hWYgb7Olivj
   xw3EbT8rUJEgvYBJJhryZSQmSqUTtcPv8rGmxO+qMGXfs3i0mtTKjlPaH
   dUZo6r9BzUNwtmQYFcOE3WcB5cOeB6cd/bKJL/VXJ5pHq79vRMCgcGB7N
   /tiuhcl8qXiniH+bGsAI2ekH7OwxRdMIFgdy0IkLdyxxws4ZhjOrd/c7l
   WBdvG3fQQ2fsJGGgikU1JlH4EvyUDoedLo/i5V4eW7b0wZTlTcLavHNW8
   YDjCy3fdf7iaS5XM8T7KqoibiD2oFOwbewfIFdLPSq5q56vDyzV9p1Hvk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="4474409"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="4474409"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 21:41:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="1111600089"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="1111600089"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 21:41:28 -0800
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
  <seungjun.ha@samsung.com>,  Srinivasulu Thanneeru
 <sthanneeru.opensrc@micron.com>
Subject: Re: [PATCH v5 02/11] mm/mempolicy: introduce
 MPOL_WEIGHTED_INTERLEAVE for weighted interleaving
In-Reply-To: <ZZXbN4+2nVbE/lRe@memverge.com> (Gregory Price's message of "Wed,
	3 Jan 2024 17:09:59 -0500")
References: <20231223181101.1954-1-gregory.price@memverge.com>
	<20231223181101.1954-3-gregory.price@memverge.com>
	<8734vof3kq.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZYp6ZRLZQVtTHest@memverge.com>
	<878r58dt31.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZZRybDPSoLme8Ldh@memverge.com>
	<87mstnc6jz.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZZXbN4+2nVbE/lRe@memverge.com>
Date: Thu, 04 Jan 2024 13:39:31 +0800
Message-ID: <875y09d5d8.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Wed, Jan 03, 2024 at 01:46:56PM +0800, Huang, Ying wrote:
>> Gregory Price <gregory.price@memverge.com> writes:
>> > I'm specifically concerned about:
>> > 	weighted_interleave_nid
>> > 	alloc_pages_bulk_array_weighted_interleave
>> >
>> > I'm unsure whether kmalloc/kfree is safe (and non-offensive) in those
>> > contexts. If kmalloc/kfree is safe fine, this problem is trivial.
>> >
>> > If not, there is no good solution to this without pre-allocating a
>> > scratch area per-task.
>> 
>> You need to audit whether it's safe for all callers.  I guess that you
>> need to allocate pages after calling, so you can use the same GFP flags
>> here.
>> 
>
> After picking away i realized that this code is usually going to get
> called during page fault handling - duh.  So kmalloc is almost never
> safe (or can fail), and we it's nasty to try to handle those errors.

Why not just OOM for allocation failure?

> Instead of doing that, I simply chose to implement the scratch space
> in the mempolicy structure
>
> mempolicy->wil.scratch_weights[MAX_NUMNODES].
>
> We eat an extra 1kb of memory in the mempolicy, but it gives us a safe
> scratch space we can use any time the task is allocating memory, and
> prevents the need for any fancy error handling.  That seems like a
> perfectly reasonable tradeoff.

I don't think that this is a good idea.  The weight array is temporary.

--
Best Regards,
Huang, Ying

