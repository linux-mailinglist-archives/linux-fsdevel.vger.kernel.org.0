Return-Path: <linux-fsdevel+bounces-50227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E66AC90D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 15:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0FA16C215
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 13:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B1D22B8B0;
	Fri, 30 May 2025 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WazTBLjn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F381607A4;
	Fri, 30 May 2025 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748613573; cv=none; b=EwqxyshYV8tqmDH5aPmImwkl96tOnWZcbzTbnIftMZi4lDBt9ONa1NtQT+xu4Wgmi7DW6rUrZ+jTWrqQrGQp4Xvyq5kQv+5NXy5ZtKXPjk2YklZJffyjZS4WoUpJR8GrlrJI/2QgtnhF/aZKKGivi6dg8H+7zKftnGw0tYMrYds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748613573; c=relaxed/simple;
	bh=4lV3t8gZA4cyQiS37QlisNkHL008vb8770Fl3hunJlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WCFIFQLo45lYXFt9vt3AyU1/Ne6ww+5VdnVk7AlkWzkVOsLB8zOO6AQ0OgYMh6lzsIQY2WVUnLqBHkrR23T78sxK4mT3q3F/Bff3FUmjYXc31I7d72l2GHDRz8uRqY9enpVIZTYIKH3/9NHhG9Telz/rXGvOINFmvQkd+h/MgBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WazTBLjn; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748613572; x=1780149572;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4lV3t8gZA4cyQiS37QlisNkHL008vb8770Fl3hunJlA=;
  b=WazTBLjnOdg2aaRWi5rFQdBKQtnPBaH2vKlfMaQ52wXC3eQ/RIJOcS4g
   0pNdjiHa2xs4rxEuYy6F9Vg3BoNTXq902ndME0qnwWA7IcnB3yYBip6Pz
   gwEKBrDFHQ1EtMLj+sQzTvPIaUHLqSEX/JfOb1CJhjmafWQCeVGn6gWPF
   HIOmBm6ThUUmhRnY+LwYBjXNnN6AcOr88VxM2lYwKDCfeAuBKE+FqiI3Y
   JeJgWn/AptDAwZE13w2Lt+nuYLvYjKZH8+oUit0c6Le38wpYmVWrWantW
   SYkKLZUcdrEOFmtvftfgd6rBwtM4zkQH7DB4hhimz0z4Qu7wyZw6u1q7z
   A==;
X-CSE-ConnectionGUID: 2EDjjlA1TzKvdS7E8QWlBw==
X-CSE-MsgGUID: u6HWPZabT5ywlT9hmYP/lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="54500871"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="54500871"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 06:59:31 -0700
X-CSE-ConnectionGUID: tyWIxf77S+eTu8oioRT98w==
X-CSE-MsgGUID: JkoSBStTTryxFNJEypUlRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="144859678"
Received: from mgoodin-mobl2.amr.corp.intel.com (HELO [10.125.110.94]) ([10.125.110.94])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 06:59:30 -0700
Message-ID: <304ea078-0f09-43d6-9dd2-264eb195e33e@intel.com>
Date: Fri, 30 May 2025 06:59:29 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 14/35] RPAL: enable page fault handling
To: Bo Li <libo.gcs85@bytedance.com>, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, luto@kernel.org,
 kees@kernel.org, akpm@linux-foundation.org, david@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, peterz@infradead.org
Cc: dietmar.eggemann@arm.com, hpa@zytor.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, jannh@google.com, pfalcato@suse.de, riel@surriel.com,
 harry.yoo@oracle.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, duanxiongchun@bytedance.com, yinhongbo@bytedance.com,
 dengliang.1214@bytedance.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, songmuchun@bytedance.com, yuanzhu@bytedance.com,
 chengguozhu@bytedance.com, sunjiadong.lff@bytedance.com
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
 <a7c183833cca723238d4173a6df771dd7e340762.1748594840.git.libo.gcs85@bytedance.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <a7c183833cca723238d4173a6df771dd7e340762.1748594840.git.libo.gcs85@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/30/25 02:27, Bo Li wrote:
>  arch/x86/mm/fault.c     | 271 ++++++++++++++++++++++++++++++++++++++++
>  arch/x86/rpal/mm.c      |  34 +++++
>  arch/x86/rpal/service.c |  24 ++++
>  arch/x86/rpal/thread.c  |  23 ++++
>  include/linux/rpal.h    |  81 ++++++++----
>  5 files changed, 412 insertions(+), 21 deletions(-)

I'm actually impressed again that you've managed to get this ported over
to a newer kernel _and_ broken it up.

But just taking a quick peek at _one_ patch, this is far, far below the
standards by which we do kernel development. This appears to have simply
copied chunks of existing code, hacked it to work with "RPAL" and then
#ifdef'd.

This is, unfortunately, copying and pasting at its worst. It creates
dual paths that inevitably bit rot in some way and are hard to maintain.

So, just to be clear: it's a full an unequivocal NAK from me on this
series. This introduces massive change, massive security risk, can't
possibly be backward compatible, has no users (well, maybe one) and the
series is not put together in anything remotely resembling how we like
to do kernel development.

I'd appreciate if you could not cc me on future versions if you choose
to go forward with this. But I urge you to stop now.

