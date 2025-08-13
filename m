Return-Path: <linux-fsdevel+bounces-57701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2CCB24ACD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4056C880F90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 13:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB962EAD05;
	Wed, 13 Aug 2025 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N69VCTgc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFFB2EA756;
	Wed, 13 Aug 2025 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092356; cv=none; b=cAZOzqqazsjSuNotJJelPVyT8ycO6FOQkLE0r8QRE2Bt9ilaHr68mgxTcLMCe/5OvMz9au/AeZR64Lb6mDhg/hC9oMQZKxqwZ4J0SIN2Ijn3vOBEegFhnEXSFqy9RAxj+AP5o1+38r96dUFyOhzt16GDVpHblvxm7W3zCFHPiVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092356; c=relaxed/simple;
	bh=MgEKOEyyAEorH8iuoL33yXvGl8kuoAn+H2uLs0OHw6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClURwLywrHkkH3vOmPdX8tFNRtcXFf7Y0q1K+DE9Q6ILam4BOlPbiOnh0OauTmvVKE+eQulRs/FfC6bNz/k0KzxfL1/gUNljyeAIWA4Iay7tWqk+5k+X6E8O/DomNmKUiTqlsXZ/zsAr1XiHur8GB/VQDMErGAA6l7JpzfRmN8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N69VCTgc; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755092355; x=1786628355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MgEKOEyyAEorH8iuoL33yXvGl8kuoAn+H2uLs0OHw6M=;
  b=N69VCTgc2znvvSEUehniANxzpD3hWWSx+47afhTIARX43jRVo1LockXy
   Fl4UCTt5IQrLvPp1bkUwd0Ffi1ZC4WtNBdan/awLrH9Y1hPzN5qFa2100
   21cDiMFxBwz7Ngf34dq/2VXt/6Hm8PKSUC3JZ16/WBYDJYrRaPRjX0FCX
   7DBC9aAAFRwLDMB97htYIxa1ylTavgBIc8WkVvFVX5b6j8HFyKZqmLhky
   EWy1PN23AoV6Icht2ywa2WdUubwJK0dvksYYA4n2Ab+scmqeGEPQuB3P7
   kyptlujCw7GSBDbW3wJ0AGUpa2MXopXryxwx1w9YUIwD3CdzkzYt4xoBW
   A==;
X-CSE-ConnectionGUID: FvYK9XeaSgGqRWn7aFed1g==
X-CSE-MsgGUID: ZrL5Qxo8SP+7ousz5TP85w==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="44964699"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="44964699"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 06:39:14 -0700
X-CSE-ConnectionGUID: N7uaji0FRw66mKcsookEbg==
X-CSE-MsgGUID: sjsF9VtDR4iwOeSVE/y+eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="170683697"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 13 Aug 2025 06:39:10 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 2E07F95; Wed, 13 Aug 2025 15:39:09 +0200 (CEST)
Date: Wed, 13 Aug 2025 15:39:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Maximilian Bosch <maximilian@mbosch.me>,
	Ryan Lahfa <ryan@lahfa.xyz>, Christian Theune <ct@flyingcircus.io>,
	Arnout Engelen <arnout@bzzt.net>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iov_iter: iterate_folioq: fix handling of offset >=
 folio size
Message-ID: <aJyVfWKX2eSMsfrb@black.igk.intel.com>
References: <20250811-iot_iter_folio-v1-1-d9c223adf93c@codewreck.org>
 <202508120250.Eooq2ydr-lkp@intel.com>
 <20250813051633.GA3895812@ax162>
 <aJwj4dQ3b599qKHn@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJwj4dQ3b599qKHn@codewreck.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Aug 13, 2025 at 02:34:25PM +0900, Dominique Martinet wrote:
> Nathan Chancellor wrote on Tue, Aug 12, 2025 at 10:16:33PM -0700:
> > >    1 warning generated.
> > 
> > I see this in -next now, should remain be zero initialized or is there
> > some other fix that is needed?
> 
> A zero-initialization is fine, I sent a v2 with zero-initialization
> fixed yesterday:
> https://lkml.kernel.org/r/20250812-iot_iter_folio-v2-1-f99423309478@codewreck.org
> 
> (and I'll send a v3 with the goto replaced with a bigger if later today
> as per David's request)
> 
> I assume Andrew will pick it up eventually?

I hope this to happen sooner as it broke my builds too (I always do now `make W=1`
and suggest all developers should follow).

-- 
With Best Regards,
Andy Shevchenko



