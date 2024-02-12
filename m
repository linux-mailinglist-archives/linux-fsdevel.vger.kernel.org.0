Return-Path: <linux-fsdevel+bounces-11140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCEB851A4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33FA2B20D2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 16:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF393F8D9;
	Mon, 12 Feb 2024 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXu0HhZM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB013E481;
	Mon, 12 Feb 2024 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756971; cv=none; b=eJDLQKOPn0yth200M9h3ZqxCgHxNAPrD+VesrMsBDVy+1bpJhbMPDHrv88f6Feux9lRktejTT0I3tQFC4RusOAqvqhGrMXRRkHNlbmvh5YakW861XARW835+k2RRUFQax0+UDzai1bICfYJfPsdiXfu1WVkSVAo5yamNbapYxUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756971; c=relaxed/simple;
	bh=qEHre5KcrGm7NMQ/uG4bn4q+c/50g4eByXrxSboUeBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AH9dHXVsobzu1/Lv59ouATfbkIr7ck62LPyf7qp0j6gARzOoU456mp7KwBpwNL0WgUKpOgssAHObSp+okWZHO1ltS8E9ABUzWNUXDNph+kh3vgqazHS2rudZFHXY9tAjmRhzaV9AqpP23SutI0SSeMB/FmL/FVFDDKaDQLqxyqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QXu0HhZM; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707756970; x=1739292970;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qEHre5KcrGm7NMQ/uG4bn4q+c/50g4eByXrxSboUeBc=;
  b=QXu0HhZMfNAOmBIhNoUSENurLgynInuKSgdXvAchONnXRZfRvOQkKzh2
   bYOvrcLUAOEUmLdgItF9fLkQky0EvDJGTGYDtFgGWXIs2v82YTtHLc5Dm
   kH9bRGX6CQyNy4YQ5rLWhB9t8WBCTs2cjLKwQgTTAXGtroIpuWcUZSjLF
   re4vjkmzlhMTHFDzVgiatKxV0+8lZo2xYGUn7X1mINieIZ7jR885mV1ZJ
   aPYSql5jj/lc5+O2DrwmQtMCLefrAViGtpgXD53svARAw+9ujubUl/0y9
   m4Nq1gdBCmdINqOAKu/qxBLKSqPeh/x1B5Mk5hC4OR07g+HHpG0FK6TDy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1611216"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="1611216"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 08:55:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="7264524"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.113.42]) ([10.246.113.42])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 08:55:48 -0800
Message-ID: <a25d9e16-4e5e-4a65-af5b-738ad1c72aa3@intel.com>
Date: Mon, 12 Feb 2024 09:55:47 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvdimm/pmem: Fix leak on dax_add_host() failure
Content-Language: en-US
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Alasdair Kergon
 <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Russell King <linux@armlinux.org.uk>, linux-arch@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-xfs@vger.kernel.org, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev
References: <20240212162722.19080-1-mathieu.desnoyers@efficios.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240212162722.19080-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/12/24 9:27 AM, Mathieu Desnoyers wrote:
> Fix a leak on dax_add_host() error, where "goto out_cleanup_dax" is done
> before setting pmem->dax_dev, which therefore issues the two following
> calls on NULL pointers:
> 
> out_cleanup_dax:
>         kill_dax(pmem->dax_dev);
>         put_dax(pmem->dax_dev);
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-cxl@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-xfs@vger.kernel.org
> Cc: dm-devel@lists.linux.dev
> Cc: nvdimm@lists.linux.dev

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/nvdimm/pmem.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 4e8fdcb3f1c8..9fe358090720 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -566,12 +566,11 @@ static int pmem_attach_disk(struct device *dev,
>  	set_dax_nomc(dax_dev);
>  	if (is_nvdimm_sync(nd_region))
>  		set_dax_synchronous(dax_dev);
> +	pmem->dax_dev = dax_dev;
>  	rc = dax_add_host(dax_dev, disk);
>  	if (rc)
>  		goto out_cleanup_dax;
>  	dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
> -	pmem->dax_dev = dax_dev;
> -
>  	rc = device_add_disk(dev, disk, pmem_attribute_groups);
>  	if (rc)
>  		goto out_remove_host;

