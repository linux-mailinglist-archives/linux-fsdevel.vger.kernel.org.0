Return-Path: <linux-fsdevel+bounces-70493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C95C9D586
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 00:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7CFBB34A959
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 23:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385C32FD1A1;
	Tue,  2 Dec 2025 23:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f97PG2Fd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AAE2F7AB1;
	Tue,  2 Dec 2025 23:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764718350; cv=none; b=HjX0MxMZj01L0dqhFQHwDWSCLObZt2WtnBoJM0mQqh6pjb6/8i4uLLCCGkPDtQ2Vl3v7T9kH3C8k/Z/kp6Ij0dr2c299lhZf4Xc5zBtIMqCAa+Q/QdK30g4BFyTuSkrr3Dt4psEeHbCvvDIChU7Y8IB2R1rbkg7SoSjKuvxW2Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764718350; c=relaxed/simple;
	bh=FgR+dGAXoqq8Uln8w08gsGEUZzntgHCN6ndnerHSwBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CYHnZwg9Kn+s6aZL8VIdzhziK/pzePQySjrCXBI2KHs/zOUcSU9S+vEGo2LxKuIH4E1ZBhVrLnwQ7KKehKd/+Uh9MT4nM0SjVXzZTdq1qs+cbMidh/oryHRpgF5MJAHYHUwEUNHhB0oo9NuyPJzdwaYo8JOfiuv/ldHuKKdzJ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f97PG2Fd; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764718349; x=1796254349;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FgR+dGAXoqq8Uln8w08gsGEUZzntgHCN6ndnerHSwBQ=;
  b=f97PG2Fdeg6HHmOhms6OWfEQwXAESQzeTwwFZ2LWDAUkqC1Nnk9NqKmH
   FQ7wJqgXW+L12s2JEP73B4y7tGAl2bAQy/IgKsa35mLlhZi8gzsteRak0
   wd59RU2BfSHmsVbB/v7RZe/yqOp+RZqR/5/LRUfdnsQj2jaP4QBrZapqM
   F2Mdw/kWKNvMa8if6xpDB71jL86G7ZXwhES6mCdI8r3PM2mazcKB2i/WX
   46+xdxTCvlw+/hhjW35zc+niTcdA/Yp2gHes9PWSOfO0OOk0Otz57NDIJ
   1Fv5QAxhSDOstGi7Tz8omJSRgi2sFiqz9jp08KeFfjYwJxysQOKcwCyPP
   A==;
X-CSE-ConnectionGUID: 5Ip8D6pkS2mOUd4ebuKpnA==
X-CSE-MsgGUID: ClMEtR94TGWqM92uHFHuWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="89356375"
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="89356375"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 15:32:28 -0800
X-CSE-ConnectionGUID: 7Wd1OQ3LSTOYg334Vj5lKw==
X-CSE-MsgGUID: PE3hF536SX6iI9l3weR3yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="195304298"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.111.202]) ([10.125.111.202])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 15:32:25 -0800
Message-ID: <f35d86cd-03f8-4e0b-8373-8d8e749aaa8e@intel.com>
Date: Tue, 2 Dec 2025 16:32:24 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] dax/hmem: Gate Soft Reserved deferral on
 DEV_DAX_CXL
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>,
 Ard Biesheuvel <ardb@kernel.org>
References: <20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com>
 <20251120031925.87762-4-Smita.KoralahalliChannabasappa@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251120031925.87762-4-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/19/25 8:19 PM, Smita Koralahalli wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Replace IS_ENABLED(CONFIG_CXL_REGION) with IS_ENABLED(CONFIG_DEV_DAX_CXL)
> so that HMEM only defers Soft Reserved ranges when CXL DAX support is
> enabled. This makes the coordination between HMEM and the CXL stack more
> precise and prevents deferral in unrelated CXL configurations.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  drivers/dax/hmem/hmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index 02e79c7adf75..c2c110b194e5 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -66,7 +66,7 @@ static int hmem_register_device(struct device *host, int target_nid,
>  	long id;
>  	int rc;
>  
> -	if (IS_ENABLED(CONFIG_CXL_REGION) &&
> +	if (IS_ENABLED(CONFIG_DEV_DAX_CXL) &&
>  	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
>  			      IORES_DESC_CXL) != REGION_DISJOINT) {
>  		dev_dbg(host, "deferring range to CXL: %pr\n", res);


