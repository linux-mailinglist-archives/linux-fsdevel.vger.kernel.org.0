Return-Path: <linux-fsdevel+bounces-25740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E538794FADC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 02:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BCC3B2184F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 00:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E174E5684;
	Tue, 13 Aug 2024 00:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZzkx2SI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53834EDB;
	Tue, 13 Aug 2024 00:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723510324; cv=none; b=WHRDbNyAkFFlY1Uglx6gbo84tgmiMEB1sCEQLXZ5wZRj02GGHd68SsJMorC0ISpoDgdmM4KiCR77eBSTzDw97Pncq8ghPWy/i2Cg5rMRdmkI/N7NfepsZoa07patQQfmsHJamj+G7QUKmTuY2dj6AymYnjwFD6xYoxrx+edNDFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723510324; c=relaxed/simple;
	bh=d/Aryoz0Lafm8CF1eAjXQtm5vquj+UBZ29XRVxr9V0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTteHSNOWj04iZAC11dCrCXS42tsUlvV0MSbYo+XPJ0GVo8CzIrcTh6u3Y9GIR0rEf9GwIx3X+5ewVzpvQf4oYmgNrGmMXi2g1Lll675Mhg312gFxgwBLW3lvJu7GUHQkWN9QbysEPKTd5lRWzLf58uMTaUUGzHLNIiScAtGzQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZzkx2SI; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723510323; x=1755046323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d/Aryoz0Lafm8CF1eAjXQtm5vquj+UBZ29XRVxr9V0k=;
  b=jZzkx2SIdrphFiS/mrgWX+2++LrsbOeaMWalYnEnF2acpMvBTRiMNkvA
   Qd8CZBuScYUMWEap+YMHq+uRb+YfsyaRLRSz1Yphz2lzQpVX8goCYq5/U
   AvhvkjR4MJAbb0srXLLoeXWXWTkLMyDZYRD7d2WjUGPUjv79E8bp2JDhT
   MtUEi/+9dImj+rsZIviXs8YsJt4xB5frRjUIvNcv5HHBWS7jy3f7Bv1ju
   eB4pApqB+H3nIhfAxCcMhTIx31E5uLYvbknWC41gyXoBcIUCZ7F6ChNeg
   XAD3IqwNOh6X/IoJjf1PLDtd3z5oB48RRL85hXmDmAA0+v4S8goqO28hc
   g==;
X-CSE-ConnectionGUID: QtV+1z2wTVqN1JaiMUSoUw==
X-CSE-MsgGUID: LI54Pp50ScGNHhgtILcv0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="47054924"
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="47054924"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 17:52:02 -0700
X-CSE-ConnectionGUID: bXTSqLZ8QxGfl/VLt+XTNg==
X-CSE-MsgGUID: PhRyyA1jTveb1w25hrwHnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="62643654"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 17:52:01 -0700
Date: Mon, 12 Aug 2024 17:52:00 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	osandov@osandov.com, song@kernel.org, jannh@google.com,
	linux-fsdevel@vger.kernel.org, willy@infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 bpf-next 01/10] lib/buildid: harden build ID parsing
 logic
Message-ID: <ZrquMOQc8vAjYxIB@tassilo>
References: <20240813002932.3373935-1-andrii@kernel.org>
 <20240813002932.3373935-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813002932.3373935-2-andrii@kernel.org>

> @@ -152,6 +160,10 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
>  	page = find_get_page(vma->vm_file->f_mapping, 0);
>  	if (!page)
>  		return -EFAULT;	/* page not mapped */
> +	if (!PageUptodate(page)) {
> +		put_page(page);
> +		return -EFAULT;
> +	}

That change is not described. As I understand it might prevent reading
previous data in the page or maybe junk under an IO error? Anyways I guess it's a
good change.

Reviewed-by: Andi Kleen <ak@linux.intel.com>

-Andi

