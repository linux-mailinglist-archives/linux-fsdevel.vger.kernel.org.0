Return-Path: <linux-fsdevel+bounces-69902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B3BC8A978
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 16:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 170994E5AF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 15:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEDF32ED3B;
	Wed, 26 Nov 2025 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mDs5+EKW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58F132ED27;
	Wed, 26 Nov 2025 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764170341; cv=none; b=C+Ztfk1pC3IUfcWzu6DYCtZf1hpBLwiWfs14oFSykDJhahCYusI0Mq6e2+W+ecbB+Jot3TPyWb7/8vQGuJfXKBasOTorik8EsL6iv6xVFUjiifGjugVRfQoRPkWrBhh5ER5JAjuFSR4XLkBabrE5R/CmV+Sj/reCymgCTBGdEps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764170341; c=relaxed/simple;
	bh=ffNKFoUHGPj56IEosVkLTcmqWgQBZdRiG/CnozlgslE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMWwRKv90F0djk5GY4h7yeOOAxgEiRXomksHkVlWNd5E9mzrOIqtPpRYDF4bZKDXymIWEtSU2HGUOgMh6KiCbsrUMUBDfwYIeeawtcNF1lkLRU7jI4YsuClLwfbSSUkmE1P9gTrqT6xQurmZRdnduXI7XxfVrwyZyMiDLAnUYqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mDs5+EKW; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764170336; x=1795706336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ffNKFoUHGPj56IEosVkLTcmqWgQBZdRiG/CnozlgslE=;
  b=mDs5+EKWIe9wWUF/0Mmz2AgSm1Q7G/kqbtmEtpI3hTD4HvuWpKgXQAnM
   SqPnR6JRMdYiT5FQUWn9I7sDu6qTyuZEUJH3H+OaId7i4DNrv6M299/sE
   5+HywSBBIGwnU2aksq6GClAm+4lA+KNhtFpl1xvcc85+CX26BDB/f289Z
   dsyykSJZ5JahdKb5bH5+1YxZDlzU8wrO+UHu2X++KfSzahqGlU8kG6ufR
   ec+CnnSGQQiRbjygS45xbuIoIH09MBlmNPfOKt/iPLwCqgTofoYvvlLga
   73weUbeexyuxNPZKitUEU9p71tpDfeMQ3cqpVLmGGUUrgWf7Jj/4jqIsI
   w==;
X-CSE-ConnectionGUID: h5W5biMoQxWCI3sa7IXbpg==
X-CSE-MsgGUID: EpMLYGx1S9mVoNhzwx7J4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="65215288"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="65215288"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 07:18:49 -0800
X-CSE-ConnectionGUID: v2aSeqmNSBebS0LYaOFvRA==
X-CSE-MsgGUID: RLCRGKtXQUyQ8GsxKBo9wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="193395867"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 26 Nov 2025 07:18:48 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 1EF9BA0; Wed, 26 Nov 2025 16:18:46 +0100 (CET)
Date: Wed, 26 Nov 2025 16:18:46 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com, superm1@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 1/4] fs/nls: Fix utf16 to utf8 conversion
Message-ID: <aScaVgVAk_tH_v-w@black.igk.intel.com>
References: <20251111131125.3379-1-W_Armin@gmx.de>
 <20251111131125.3379-2-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111131125.3379-2-W_Armin@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Nov 11, 2025 at 02:11:22PM +0100, Armin Wolf wrote:
> Currently the function responsible for converting between utf16 and
> utf8 strings will ignore any characters that cannot be converted. This
> however also includes multi-byte characters that do not fit into the
> provided string buffer.
> 
> This can cause problems if such a multi-byte character is followed by
> a single-byte character. In such a case the multi-byte character might
> be ignored when the provided string buffer is too small, but the
> single-byte character might fit and is thus still copied into the
> resulting string.
> 
> Fix this by stop filling the provided string buffer once a character
> does not fit. In order to be able to do this extend utf32_to_utf8()
> to return useful errno codes instead of -1.

Can you also update utf8_to_utf32() to return meaningful error codes?
Without that done we have inconsistent APIs.

-- 
With Best Regards,
Andy Shevchenko



