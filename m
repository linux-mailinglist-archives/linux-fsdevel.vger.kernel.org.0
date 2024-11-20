Return-Path: <linux-fsdevel+bounces-35333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1E19D3F07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 16:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C02282171
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 15:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F861B6555;
	Wed, 20 Nov 2024 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FB60EKDD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FD1156F39;
	Wed, 20 Nov 2024 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732116578; cv=none; b=ASwBJjPalQIps6kYYyFnxQAuVHxcWKJZ9bdRiym9kvV9kQRC3rwDbyT1yEFIDI4V26b4upeSrKWCMDWp6iEubVo7TBHKayDfaQZ1JAcvxw0sMztAvWWf0cX+eStP/A6vAZt8B8geKpninU3flMHauot5hoyrEf8koGa1Drwi+AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732116578; c=relaxed/simple;
	bh=GMJRSIN/jwN1mEeXDPhC5UQ+MYY/wdAISwzlBog0b14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZgH2xvaIENCtMoxTSDThkex3u8pfzFGuFpplYh/h/gxPNzGjUyRTRJwUtSZnWd2W8F+K0URQ8nZ7iZ+E3CwD8qFV4WBr46rsYfc5OtleK8z8Ui6Kjd5KFkP8R5HnBVVjRcyEjNBMQB9HDXS7zT1mWVcsbtil0fBSDM2m1QxRPJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FB60EKDD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732116577; x=1763652577;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=GMJRSIN/jwN1mEeXDPhC5UQ+MYY/wdAISwzlBog0b14=;
  b=FB60EKDD8Uq6AkLoz0qzIidGVOBPGXv72SQL0hFB1F0epi5aeCe7CKOr
   S+Ig+Z4c711LcptxkuQLid1FjZmK3828IRE/2XMV7F+DMvIiN9aib3gIK
   YDUblHFFU1n1wl5/7S4x8bblVYsNh8RlLRW8289EVHYzMTQSrG2KTxJIX
   +hpgAN0pNoGUpPHEC7mOy3Q1k/gIunhLSsvbD83JLIqUY1ppIalGqb4L6
   Z/gMC3q+BuXdYq28zV5UMgbQ8DtZoi8Zcefv22LAt8+pyoxEeUxt2T4Vo
   fe4/JBtoqdwvYlbHpFrW1sGRa+PgT38SCkcdVh/x2Q/dXNZTy51R4DatP
   w==;
X-CSE-ConnectionGUID: 6jH+taCjT8unZgVUUKRdQg==
X-CSE-MsgGUID: HCYBXT2mRky1SBYXQ3ecXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="35856478"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="35856478"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 07:29:36 -0800
X-CSE-ConnectionGUID: JioBrdkvQk2Y5jNMYdMdmw==
X-CSE-MsgGUID: ev1M0HImQeKcY4srIRu0nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="89533919"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by fmviesa006.fm.intel.com with ESMTP; 20 Nov 2024 07:29:35 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id C65E8301B9F; Wed, 20 Nov 2024 07:29:34 -0800 (PST)
From: Andi Kleen <ak@linux.intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  linux-doc@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  cgroups@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  akpm@linux-foundation.org,  corbet@lwn.net,  derek.kiernan@amd.com,
  dragan.cvetic@amd.com,  arnd@arndb.de,  gregkh@linuxfoundation.org,
  viro@zeniv.linux.org.uk,  brauner@kernel.org,  jack@suse.cz,
  tj@kernel.org,  hannes@cmpxchg.org,  mhocko@kernel.org,
  roman.gushchin@linux.dev,  shakeel.butt@linux.dev,
  muchun.song@linux.dev,  Liam.Howlett@oracle.com,
  lorenzo.stoakes@oracle.com,  vbabka@suse.cz,  jannh@google.com,
  shuah@kernel.org,  vegard.nossum@oracle.com,  vattunuru@marvell.com,
  schalla@marvell.com,  david@redhat.com,  willy@infradead.org,
  osalvador@suse.de,  usama.anjum@collabora.com,  andrii@kernel.org,
  ryan.roberts@arm.com,  peterx@redhat.com,  oleg@redhat.com,  tandersen@
Subject: Re: [RFCv1 0/6] Page Detective
In-Reply-To: <20241116175922.3265872-1-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Sat, 16 Nov 2024 17:59:16 +0000")
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
Date: Wed, 20 Nov 2024 07:29:34 -0800
Message-ID: <87wmgxvs81.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pasha Tatashin <pasha.tatashin@soleen.com> writes:

> Page Detective is a new kernel debugging tool that provides detailed
> information about the usage and mapping of physical memory pages.
>
> It is often known that a particular page is corrupted, but it is hard to
> extract more information about such a page from live system. Examples
> are:
>
> - Checksum failure during live migration
> - Filesystem journal failure
> - dump_page warnings on the console log
> - Unexcpected segfaults
>
> Page Detective helps to extract more information from the kernel, so it
> can be used by developers to root cause the associated problem.
>
> It operates through the Linux debugfs interface, with two files: "virt"
> and "phys".
>
> The "virt" file takes a virtual address and PID and outputs information
> about the corresponding page.
>
> The "phys" file takes a physical address and outputs information about
> that page.
>
> The output is presented via kernel log messages (can be accessed with
> dmesg), and includes information such as the page's reference count,
> mapping, flags, and memory cgroup. It also shows whether the page is
> mapped in the kernel page table, and if so, how many times.

A lot of all that is already covered in /proc/kpage{flags,cgroup,count)
Also we already have /proc/pid/pagemap to resolve virtual addresses.

At a minimum you need to discuss why these existing mechanisms are not
suitable for you and how your new one is better.

If something particular is missing perhaps the existing mechanisms
can be extended?

Outputting in the dmesg seems rather clumpsy for a production mechanism.

I personally would just use live crash or live gdb on /proc/kcore to get
extra information, although I can see that might have races.

-Andi

