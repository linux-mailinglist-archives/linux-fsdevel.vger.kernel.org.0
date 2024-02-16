Return-Path: <linux-fsdevel+bounces-11834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACCD857890
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 10:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCCB228442C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 09:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F2D1BC4B;
	Fri, 16 Feb 2024 09:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XMx6/EQZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423401B950;
	Fri, 16 Feb 2024 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708074507; cv=none; b=XYBmf6hK7iGSPUH2akDtai+EAsPGoTH/OAFuEZnwVPhHZOYdYhdQf2a+lqfQfCpiHnq4A9gGOE01xa+GtC1S8PSB++5xCk94L81/K1gWVHCHnVJ42DXp0M2jyNPyfCt5SFhYTK20LiLsY8IOvZRVc6Sv5hslKVjk34b2YIkY9DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708074507; c=relaxed/simple;
	bh=bP0+2GvyJajM/pooFA5KnylYJbVPHA/lz4kwRQQKOaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fL10/wLsOOPIuTSIdxpZUBvCxahs0rTJl5RdXXw3dcRivQn7FdA5S5ZOwXW46Eosu94NgBzhmYm6K34rjdzGZndibScVB2qdlrApsfhfPCQEL8zKTg0AOrR/sN1ykPhTq4tAHwOeM4MNMHG0k/Z9a/4mjm1f9dwrPDJQXB1RluY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XMx6/EQZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708074505; x=1739610505;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=bP0+2GvyJajM/pooFA5KnylYJbVPHA/lz4kwRQQKOaw=;
  b=XMx6/EQZVpBrc2MQd1oW/1USmOq9J9yDmnyE+Pt/uvsZCY+a2B3a6R7o
   3v7kqiHdi5rxg50SsZCxupFoBacT1gsPpzvX7D95XkLwdFbj+TsCX8Qa4
   n2fxG1v53g0TiGa6Oc+yVCD+6ZDzn/ccEWqIcnMoyolK07mP/RtB/7pU0
   fMNGC9IKOJMjyAiRA3xaMu1vk40zIcnSG7dYMrxL53ArcLiH01R7XMsz+
   FbvWDwpeMigWep/bL2jFzqm+1+7/5NHmmg6UHoyfRLCzvKhpb0LBKOzAQ
   XM/HkZWLBpq3EreXBjWdPybUFy3IAmu+IXO7a2p8m6EpZfWkrjg29C23M
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="27650633"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="27650633"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 01:08:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="8431336"
Received: from pshishpo-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.48.79])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 01:08:02 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
 mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
 willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
 void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
 catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
 tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, peterx@redhat.com, david@redhat.com, axboe@kernel.dk,
 mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org,
 dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
 paulmck@kernel.org, pasha.tatashin@soleen.com, yosryahmed@google.com,
 yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
 andreyknvl@gmail.com, keescook@chromium.org, ndesaulniers@google.com,
 vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com,
 ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
 vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com, dvyukov@google.com, shakeelb@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
In-Reply-To: <plijmr6acz2cvrfokgc46bt5budre5d5ed3alpapu4gvhkqkmn@55yhfdhigjp3>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240212213922.783301-1-surenb@google.com>
 <87sf1s4xef.fsf@intel.com>
 <plijmr6acz2cvrfokgc46bt5budre5d5ed3alpapu4gvhkqkmn@55yhfdhigjp3>
Date: Fri, 16 Feb 2024 11:07:59 +0200
Message-ID: <87jzn44w0g.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 16 Feb 2024, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> On Fri, Feb 16, 2024 at 10:38:00AM +0200, Jani Nikula wrote:
>> I wonder if it wouldn't be too much trouble to write at least a brief
>> overview document under Documentation/ describing what this is all
>> about? Even as follow-up. People seeing the patch series have the
>> benefit of the cover letter and the commit messages, but that's hardly
>> documentation.
>> 
>> We have all these great frameworks and tools but their discoverability
>> to kernel developers isn't always all that great.
>
> commit f589b48789de4b8f77bfc70b9f3ab2013c01eaf2
> Author: Kent Overstreet <kent.overstreet@linux.dev>
> Date:   Wed Feb 14 01:13:04 2024 -0500
>
>     memprofiling: Documentation
>     
>     Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

Thanks! Wasn't part of this series and I wasn't aware it existed.

BR,
Jani.


-- 
Jani Nikula, Intel

