Return-Path: <linux-fsdevel+bounces-14002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C04D387658C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 14:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C064286D11
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 13:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447B33BBE5;
	Fri,  8 Mar 2024 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OHG7Pnfr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFBB63B8;
	Fri,  8 Mar 2024 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709905583; cv=none; b=s6ceT02lSEJPvmfpaB+NzfIEBU3mnsCRv+E/yITIbdwQWe9WVOquCEfOA0fsG3Nk+I+RptbXIuG4/QInA2WIdXlK54rSi3WQn4GYJBRyA5CMGPOau75ytqp9dgmaPgICzizB7SHISSqBYRWeVSs0lvNFILmQ7MHiJRTlPK3GoCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709905583; c=relaxed/simple;
	bh=sGl9aK8v77edPNuWaz5o+oHJbqrOE6jPg9RowQSa/EE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cc/VTGjKiYqMFk4AJSVZuhcgjuoanTXSa3RMvqtrpIfcfB+GLstsB/LVpW9q1SBSVT67twtnYV83oQ3VZgrqB1DGOOjBJaSxOh1+sC9j6OY4i5v53RbS/d0C2BZoEzWOx245l63ATjLQLF/qSA0hoLxXwtH+mVxiIx60tkwmP3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OHG7Pnfr; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709905581; x=1741441581;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=sGl9aK8v77edPNuWaz5o+oHJbqrOE6jPg9RowQSa/EE=;
  b=OHG7PnfrcEI3w7jjHfWGnQ7JDLK4jH22S2XN/NsLDOflQ5FEWhkpqWt2
   z3jpQ4xAAP6nY19RpZQfgVxALg9SauiIRG32qJy1iSJaSqCRBGkIw4aHz
   Hb4Fi4Q+lB8Gzps5KwV95igRWdStxNz7VC3bibcxY62qGaM2uOC1cnZ+0
   Ep0KDtHYLVQKl9EZPlHpbeEcY1Bq0Gw70/4kvi80M9YLEJVbyc7qSN69B
   vHnkpS0XdgoOXS8Gy1u6AGXffz5t0w83nSVSLF/kOqmXPIM/kSYWBWxvx
   zEBj5ZqsHUK6Yh6tCAg79h74FcsZYoBXgm9OmfrnR8Sl5g85kfErGNZo7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="27095182"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="27095182"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:46:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15164334"
Received: from unknown (HELO localhost) ([10.252.34.187])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:46:15 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>, tglx@linutronix.de,
 x86@kernel.org, tj@kernel.org, peterz@infradead.org,
 mathieu.desnoyers@efficios.com, paulmck@kernel.org, keescook@chromium.org,
 dave.hansen@linux.intel.com, mingo@redhat.com, will@kernel.org,
 longman@redhat.com, boqun.feng@gmail.com, brauner@kernel.org,
 intel-gfx@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, Daniel
 Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 01/50] drivers/gpu/drm/i915/i915_memcpy.c: fix missing
 includes
In-Reply-To: <20231216024834.3510073-2-kent.overstreet@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216024834.3510073-2-kent.overstreet@linux.dev>
Date: Fri, 08 Mar 2024 15:46:10 +0200
Message-ID: <8734t0vntp.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 15 Dec 2023, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

This seems to have been merged to v6.8-rc1 as commit 86b9357c1bbe
("drivers/gpu/drm/i915/i915_memcpy.c: fix missing includes") without
Cc'ing the relevant lists or people, with no commit message or reviews,
or the CI we mandate for every single patch.

Sure it's trivial, but please extend the same courtesy to us as you'd
expect everyone else to extend to you before just merging stuff in the
trees you maintain.


Thanks,
Jani.


> ---
>  drivers/gpu/drm/i915/i915_memcpy.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/i915_memcpy.c b/drivers/gpu/drm/i915/i915_memcpy.c
> index 1b021a4902de..40b288136841 100644
> --- a/drivers/gpu/drm/i915/i915_memcpy.c
> +++ b/drivers/gpu/drm/i915/i915_memcpy.c
> @@ -23,6 +23,8 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/string.h>
> +#include <asm/cpufeature.h>
>  #include <asm/fpu/api.h>
>  
>  #include "i915_memcpy.h"

-- 
Jani Nikula, Intel

