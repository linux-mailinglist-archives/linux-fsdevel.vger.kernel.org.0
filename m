Return-Path: <linux-fsdevel+bounces-71331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F6BCBDD86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 13:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 840DE301ADF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 12:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0642E6CD9;
	Mon, 15 Dec 2025 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="kOveW9b4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F172E7F38
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 12:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765802418; cv=none; b=eFXQXA5IGkfT/Ft7u0L6XVjESTrHZwr9RkuXPX1Ov78YerIxCQcmAda9uGCrGlhzVG4KpuEciFxSJF92HrMw45Y6eFhesQb91UZjS1GUWgTwQ734qD/e5G28lAsos/qFmdjwlB6pc3IYjzx0ZU8pFdkkE9NcMlyq87RU74UEtXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765802418; c=relaxed/simple;
	bh=+PuE2tLBW1rXXQlqEJWcvvhfVKok2O1mj7zgRKhY0aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MN0DYPyWANE4ytzrYYuHfSjYno0n24TBT/qH/n6gOUx2TLBmMksWg/eshz8i0VvTFbAT+KxUp4IQ6qJQ8r6NtUAFv8CHTHNvyeXV0gFjtd3yHUYP92ig9CzSLhwSjhQsJKDBIgrPLcOqyDHxSRn3Rw17EEV+2HlsVKqyWt1EyiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=kOveW9b4; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0833b5aeeso32430585ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 04:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1765802416; x=1766407216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XQ+e85/bUCohfI0SHpL3374mINgtvuKmw5p+42PCaQ0=;
        b=kOveW9b4AXg6kOAhCeUg6CqtwBZDeWCxfd1ra6DiRxiZ3SoTdccPJXq498u45xO3G9
         Wfn/mnRTQd/WuZqCOnNr0K/P3pFa99AoKuNAGyosCFYBvhhLZ+8WugWc6krKHQDRohMa
         go5jfElG2763BSNBUCIAE/etyWGPWZBk9icPuFqDE/AYW6r39SNi3E59gTDbpmcclysl
         R+E8oFV54Ou91W9JTqXg1oUsVRCE+NMMp0kmP1B6ozLMbopPAszenvZ0+nhpD3iERtpC
         ZUgkQBi12GBirC0XgHiAE/Ae8+mihWzELiZyucHnhWi5cjqdUz2HS1th5pWN9uEogorB
         R4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765802416; x=1766407216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQ+e85/bUCohfI0SHpL3374mINgtvuKmw5p+42PCaQ0=;
        b=bFB8Z0xrjyDpL+UUsrhJXpl1Y+RqdXlmOhdxsvZdQOh71P8Wfwy4dqICu/w3+B8ngY
         tgLZ3gVnZxauYf6D9YHXeRBz7en9qZ7zs76jFxXVBSkBuMQM+KPqvxl/cEaP2hNWm8Sp
         1pIA2O8m3h28/h79jtac0uty9XCEIF8oLsFvcxKQMNE5JTlNerh5Lx6W8NcsgUhbKLO9
         VpBlJQ0j/aN2eXWF7+abnNTtuEYCguMSQ1nWJly4bmaQE9v5lIyY5Q7G/XggkWhOUrFv
         X+Bo+aecN6y2Uh1TJwIpIsai0xNePjdSjfAI8WnyenxGwVifUWI4GsJ9BLqcVQ+FpGdC
         WGtg==
X-Forwarded-Encrypted: i=1; AJvYcCW0HuTWHOoIolt7xqiXKsXSpXE5Bzgu96azodgt2LvMpW3lM1G6Ke2lSbCEfN/Y1uJxn+pT7NlXhZ/w7pU8@vger.kernel.org
X-Gm-Message-State: AOJu0YwMTyRFeKLtrioVb87ZCFNUh/bQOQoo3bb/42JcmZDFTVde7R9/
	rXfqi1+OskgQcNIazK7Vra6ozV0C1yoTBYFXYYqUM9i1NmqkVyPNGDFkL9nIkR4ytbo=
X-Gm-Gg: AY/fxX56M4ngHYeAPQa92hqOOqAyTRCSkoTKlnuel7NHKGpBg82RMPfeKl1ZyVL5CKo
	iWbZSlLMutxGhqYHD3bdQ+yZWXBuf3W0D3NDs1GHmu9YC5glgidg/wzpf+CgnHyQp13EyALTkzf
	0Ejl5ne8jKM1ETWn8N/n5WvmUHDMgUT0jealFal9Dde1+t4q6mUawOTFMekB0yXZtdKIbldtyxp
	jkE9y5+IDk9ZMoGbQx+yzI7ZeKnmTB4aLYxtu1gL0BIArcdNgJPrEt+LjvBGVb9WtwkmY+IMzTe
	PBAPikhAKbOH2CAJ2RxTgFJmOid6VQVUDJgkBUSr53ke71QLcNe46RxwptGpKp4os4X2Xwcjb6P
	AvTypDGqYc0N38L0nhl5ZcPPUDa2plLU8Wu96K5NKsNIGhOkGbItIvABfQCYqkgh46aMCtWdYct
	J74biqj5w1wZYjBs4MSNxLMsK2IGCmEw==
X-Google-Smtp-Source: AGHT+IGs9Ux4WT36PFE81Ye+THAzlPoeoI649XuOQnWr/+KqI/OdcXZ3NL6DeXTGnqp6jXKC8WolKA==
X-Received: by 2002:a05:701a:c965:b0:11a:2f10:fa46 with SMTP id a92af1059eb24-11f3484e8cemr6230501c88.0.1765802416021;
        Mon, 15 Dec 2025 04:40:16 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F ([205.220.129.38])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f446460c8sm8475705c88.10.2025.12.15.04.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 04:40:15 -0800 (PST)
Date: Mon, 15 Dec 2025 05:38:47 -0700
From: Gregory Price <gourry@gourry.net>
To: Balbir Singh <balbirs@nvidia.com>
Cc: linux-mm@kvack.org, kernel-team@meta.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, kees@kernel.org, muchun.song@linux.dev,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	rientjes@google.com, jackmanb@google.com, cl@gentwo.org,
	harry.yoo@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev, nphamcs@gmail.com, chengming.zhou@linux.dev,
	fabio.m.de.francesco@linux.intel.com, rrichter@amd.com,
	ming.li@zohomail.com, usamaarif642@gmail.com, brauner@kernel.org,
	oleg@redhat.com, namcao@linutronix.de, escape@linux.alibaba.com,
	dongjoo.seo1@samsung.com
Subject: Re: [RFC PATCH v2 02/11] mm: change callers of __cpuset_zone_allowed
 to cpuset_zone_allowed
Message-ID: <aUABV3sQyaTksz54@gourry-fedora-PF4VCD3F>
References: <20251112192936.2574429-1-gourry@gourry.net>
 <20251112192936.2574429-3-gourry@gourry.net>
 <dda1fab7-5cb9-4d83-8b60-f4ed75a03aa8@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dda1fab7-5cb9-4d83-8b60-f4ed75a03aa8@nvidia.com>

On Mon, Dec 15, 2025 at 05:14:07PM +1100, Balbir Singh wrote:
> On 11/13/25 06:29, Gregory Price wrote:
> > @@ -2829,10 +2829,9 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
> >  					ac->highest_zoneidx, ac->nodemask) {
> >  		enum compact_result status;
> >  
> > -		if (cpusets_enabled() &&
> > -			(alloc_flags & ALLOC_CPUSET) &&
> > -			!__cpuset_zone_allowed(zone, gfp_mask))
> > -				continue;
> > +		if ((alloc_flags & ALLOC_CPUSET) &&
> > +		    !cpuset_zone_allowed(zone, gfp_mask))
> > +			continue;
> >  
> 
> Shouldn't this become one inline helper -- alloc_flags and cpuset_zone_allowed.
>

I actually went back and took a look at this code and I think there was
a corner case I missed by re-ordering cpusets_enabled and ALLOC_CPUSET
when the GFP flag was added.

I will take another look here and see if it can't be fully abstracted
into a helper, but i remember thinking to myself "Damn, i have to open
code this to deal with the cpusets_disabled case".

Will double check on next version.

> Balbir
> <snip>

