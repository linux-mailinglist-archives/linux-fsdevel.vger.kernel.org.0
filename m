Return-Path: <linux-fsdevel+bounces-6948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4EF81ED62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 09:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1CA71F22E40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 08:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A2463AA;
	Wed, 27 Dec 2023 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V6NyIrAF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2876D63A8;
	Wed, 27 Dec 2023 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703666495; x=1735202495;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=58fSFBLJBQoRVtYJ67nH8yMUOjWPticG1ojkRLi14ak=;
  b=V6NyIrAFgCzUf3NSMF5ez+MlOcLlmmPwMVpTIHwf/6kFkHebaR7gig0x
   q0+OkyM+7mJ3FRmvqi14+sREF1Ku/XM1jevplhXrJkadA/T4Dmeo0dbkq
   dUbfjcLL/1zw8TpQQ4lH+MqmNe1+wsasNPidhK4m9Ap5kkenoQzYon/H0
   m5kikL3ii3gjfiJ2jE5zzEpbmHQgJZ2SCXNoXbLLikY6r6vh4WY1N5a0d
   Jw+wQzlTFVPjaLeAB8KR/v/0pxF+nNrC+lDglzk2h6K6cAi0ax7u8HjP7
   UUQScKyd8gRu/ThHq0joZAGpjdn2BhBbeXFN4/rU8GdGl0LlyQURHlNHx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="3261999"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="3261999"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 00:41:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="896828128"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="896828128"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 00:41:27 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gourry.memverge@gmail.com>
Cc: linux-mm@kvack.org,  linux-doc@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-api@vger.kernel.org,  x86@kernel.org,  akpm@linux-foundation.org,
  arnd@arndb.de,  tglx@linutronix.de,  luto@kernel.org,  mingo@redhat.com,
  bp@alien8.de,  dave.hansen@linux.intel.com,  hpa@zytor.com,
  mhocko@kernel.org,  tj@kernel.org,  gregory.price@memverge.com,
  corbet@lwn.net,  rakie.kim@sk.com,  hyeongtak.ji@sk.com,
  honggyu.kim@sk.com,  vtavarespetr@micron.com,  peterz@infradead.org,
  jgroves@micron.com,  ravis.opensrc@micron.com,  sthanneeru@micron.com,
  emirakhur@micron.com,  Hasan.Maruf@amd.com,  seungjun.ha@samsung.com
Subject: Re: [PATCH v5 03/11] mm/mempolicy: refactor sanitize_mpol_flags for
 reuse
In-Reply-To: <20231223181101.1954-4-gregory.price@memverge.com> (Gregory
	Price's message of "Sat, 23 Dec 2023 13:10:53 -0500")
References: <20231223181101.1954-1-gregory.price@memverge.com>
	<20231223181101.1954-4-gregory.price@memverge.com>
Date: Wed, 27 Dec 2023 16:39:29 +0800
Message-ID: <87y1dgdoou.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry.memverge@gmail.com> writes:

> split sanitize_mpol_flags into sanitize and validate.
>
> Sanitize is used by set_mempolicy to split (int mode) into mode
> and mode_flags, and then validates them.
>
> Validate validates already split flags.
>
> Validate will be reused for new syscalls that accept already
> split mode and mode_flags.
>
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> ---
>  mm/mempolicy.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 0a180c670f0c..59ac0da24f56 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1463,24 +1463,39 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
>  	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
>  }
>  
> -/* Basic parameter sanity check used by both mbind() and set_mempolicy() */
> -static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
> +/*
> + * Basic parameter sanity check used by mbind/set_mempolicy
> + * May modify flags to include internal flags (e.g. MPOL_F_MOF/F_MORON)
> + */
> +static inline int validate_mpol_flags(unsigned short mode, unsigned short *flags)
>  {
> -	*flags = *mode & MPOL_MODE_FLAGS;
> -	*mode &= ~MPOL_MODE_FLAGS;
> -
> -	if ((unsigned int)(*mode) >=  MPOL_MAX)
> +	if ((unsigned int)(mode) >= MPOL_MAX)
>  		return -EINVAL;
>  	if ((*flags & MPOL_F_STATIC_NODES) && (*flags & MPOL_F_RELATIVE_NODES))
>  		return -EINVAL;
>  	if (*flags & MPOL_F_NUMA_BALANCING) {
> -		if (*mode != MPOL_BIND)
> +		if (mode != MPOL_BIND)
>  			return -EINVAL;
>  		*flags |= (MPOL_F_MOF | MPOL_F_MORON);
>  	}
>  	return 0;
>  }
>  
> +/*
> + * Used by mbind/set_memplicy to split and validate mode/flags
> + * set_mempolicy combines (mode | flags), split them out into separate

mbind() uses mode flags too.

> + * fields and return just the mode in mode_arg and flags in flags.
> + */
> +static inline int sanitize_mpol_flags(int *mode_arg, unsigned short *flags)
> +{
> +	unsigned short mode = (*mode_arg & ~MPOL_MODE_FLAGS);
> +
> +	*flags = *mode_arg & MPOL_MODE_FLAGS;
> +	*mode_arg = mode;

It appears that it's unnecessary to introduce a local variable to split
mode/flags.  Just reuse the original code?

> +
> +	return validate_mpol_flags(mode, flags);
> +}
> +
>  static long kernel_mbind(unsigned long start, unsigned long len,
>  			 unsigned long mode, const unsigned long __user *nmask,
>  			 unsigned long maxnode, unsigned int flags)

--
Best Regards,
Huang, Ying

