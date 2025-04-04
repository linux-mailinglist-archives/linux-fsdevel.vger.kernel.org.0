Return-Path: <linux-fsdevel+bounces-45759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AF5A7BDB4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 15:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02203B3F3F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 13:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93811DF97C;
	Fri,  4 Apr 2025 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VnTM/6Gm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE7C1A314F;
	Fri,  4 Apr 2025 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743773151; cv=none; b=Ui7+jJlKTRNvOTV/ToxT+jZoi6mm8RPxJ6gRVN7aPhwwS4uxASVxsem4raUa7yv0HWrTFOpcB6HPMeEGrZ545RnekIwxjavMWus2JpjCLfJ+ruxPPtdBSnwedMEbI6Ucn2sEhsnoHYxifhttgA2tahdFXDp8uWCW9zQdK7E6Hu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743773151; c=relaxed/simple;
	bh=jrePOXnTF1fSbbzHDZhPGNpau8Mgu/BMTp+loDI1nmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hgfstz8A34qJhrUxZUTw/E2NzrSba91hCq1Cm1s/JQxzGWzfd6ZELJEawwnp9wIvyW8iGMg1UKdq25hc299DGV5V9US7C+w6wmci+mM+U8ggaWReeFpp2EdC9pO16nEo8wVN4JoiCOz7qflOVlwwAl1hkPHkLLGoHtsdmTd728E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VnTM/6Gm; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743773150; x=1775309150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jrePOXnTF1fSbbzHDZhPGNpau8Mgu/BMTp+loDI1nmw=;
  b=VnTM/6GmHX4jlmrpD7RGo7j9VC//cNSqL8zPlf+fI87a8Ss1l0G0bUxn
   wqEOOfXSjGQP77B6jEN3KD3y04QKpqrFg/aGom7E53oxhlicF2TnWSQEj
   79oQS0PKGAC4E3dwmpUmGwDDV63MNwQi7CcNqs5GAW9tKouq1O4dTTuZL
   7UQjsucCid+1ILqN/35PnPQNlU0EKrNK6HvAOCet424CnfzS93DP3P1qg
   R3FlQDzSS+2tPg+sq2CY3owYQ3Sv2NrOHg5J1ICGZt8K+to+ymVnk3Q4p
   1j4aJUlDm0PpCrpBAOEV7whIQrUlm17SgQ7bZrMCoIE5KCk9eVjIVQWxm
   A==;
X-CSE-ConnectionGUID: 4fm/XjB7TWyXgaHwjE69Kw==
X-CSE-MsgGUID: 5jtzNINzT4W6871UT0gtIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11394"; a="49006110"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="49006110"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 06:25:48 -0700
X-CSE-ConnectionGUID: 9/QIpg7RRj2nJrDBCecRGA==
X-CSE-MsgGUID: ehcgN+5LSxKWkvA0BeAJng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="127293161"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 06:25:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u0h3B-0000000990F-1PYD;
	Fri, 04 Apr 2025 16:25:37 +0300
Date: Fri, 4 Apr 2025 16:25:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
	rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
	ming.li@zohomail.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com,
	huang.ying.caritas@gmail.com, yaoxt.fnst@fujitsu.com,
	peterz@infradead.org, gregkh@linuxfoundation.org,
	quic_jjohnson@quicinc.com, ilpo.jarvinen@linux.intel.com,
	bhelgaas@google.com, mika.westerberg@linux.intel.com,
	akpm@linux-foundation.org, gourry@gourry.net,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org, rrichter@amd.com,
	benjamin.cheatham@amd.com, PradeepVineshReddy.Kodamati@amd.com,
	lizhijian@fujitsu.com
Subject: Re: [PATCH v3 1/4] kernel/resource: Provide mem region release for
 SOFT RESERVES
Message-ID: <Z-_d0YCpMiRVB0cA@smile.fi.intel.com>
References: <20250403183315.286710-1-terry.bowman@amd.com>
 <20250403183315.286710-2-terry.bowman@amd.com>
 <20250404141639.00000f59@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404141639.00000f59@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 04, 2025 at 02:16:39PM +0100, Jonathan Cameron wrote:
> On Thu, 3 Apr 2025 13:33:12 -0500 Terry Bowman <terry.bowman@amd.com> wrote:

> > Add a release_Sam_region_adjustable() interface to allow for
> 
> Who is Sam?  (typo)

Somebody's uncle?

...

> >  #ifdef CONFIG_MEMORY_HOTREMOVE
> >  extern void release_mem_region_adjustable(resource_size_t, resource_size_t);
> >  #endif
> > +#ifdef CONFIG_CXL_REGION
> > +extern void release_srmem_region_adjustable(resource_size_t, resource_size_t);
> I'm not sure the srmem is obvious enough.  Maybe it's worth the long
> name to spell it out some more.. e.g. something like

And perhaps drop 'extern' as it's not needed.

> extern void release_softresv_mem_region_adjustable() ?

> >  #ifdef CONFIG_MEMORY_HOTPLUG
> >  extern void merge_system_ram_resource(struct resource *res);
> >  #endif

-- 
With Best Regards,
Andy Shevchenko



