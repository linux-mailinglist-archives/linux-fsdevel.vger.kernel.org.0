Return-Path: <linux-fsdevel+bounces-60768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBEBB51821
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 15:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C9DE4819CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 13:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E9A31C587;
	Wed, 10 Sep 2025 13:41:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE6B315785;
	Wed, 10 Sep 2025 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757511703; cv=none; b=frsfJ/aZS7tnpu8CDEA0wjQps8ohiYT0/R+OpWtPAxp2DcG5UhMN7QSIO6cGKhpnTa9NYJkGr3ePZPbuwOnKxTzvq5aLAPQMJ0Zvo1pJztStqSX17emCBOtQwkv5hokaj6cl2i87KFq5O48+RpZQ3f8LngD8RN4fV8HesoCe1HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757511703; c=relaxed/simple;
	bh=/60SYAM/5dBbuXfohlZHRDxhelvt0nUOOqE7eCNk7RI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WpTu5qfGw1r2KgV/abdJHTULG4dzXWhcnXkgC2MMQx1zCziR6KMiePPEGqPj5tGB42yF3qxD9+o3pV1D/TUEf7VLuIX+9w8XaZ1epxkQUWYG0X7eByvaTFTa5E4GaAp4cmDNCIyGzx17RrJAR2jiOUri5uahbz+HZgwelgNA+lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cMMGr0P6xz6LDJl;
	Wed, 10 Sep 2025 21:39:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B30F1404FD;
	Wed, 10 Sep 2025 21:41:38 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 10 Sep
 2025 15:41:37 +0200
Date: Wed, 10 Sep 2025 14:41:36 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Ying
 Huang <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	"Peter Zijlstra" <peterz@infradead.org>, Greg KH
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	"Benjamin Cheatham" <benjamin.cheatham@amd.com>, PradeepVineshReddy Kodamati
	<PradeepVineshReddy.Kodamati@amd.com>, Zhijian Li <lizhijian@fujitsu.com>
Subject: Re: [PATCH 5/6] dax/hmem: Reintroduce Soft Reserved ranges back
 into the iomem tree
Message-ID: <20250910144136.000002e2@huawei.com>
In-Reply-To: <20250822034202.26896-6-Smita.KoralahalliChannabasappa@amd.com>
References: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
	<20250822034202.26896-6-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 22 Aug 2025 03:42:01 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> Reworked from a patch by Alison Schofield <alison.schofield@intel.com>
> 
> Reintroduce Soft Reserved range into the iomem_resource tree for dax_hmem
> to consume.
> 
> This restores visibility in /proc/iomem for ranges actively in use, while
> avoiding the early-boot conflicts that occurred when Soft Reserved was
> published into iomem before CXL window and region discovery.
> 
> Link: https://lore.kernel.org/linux-cxl/29312c0765224ae76862d59a17748c8188fb95f1.1692638817.git.alison.schofield@intel.com/
> Co-developed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
A few trivial things inline. Not are important enough to need a change though.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/dax/hmem/hmem.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index 90978518e5f4..24a6e7e3d916 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -93,6 +93,40 @@ static void process_defer_work(struct work_struct *_work)
>  	walk_hmem_resources(&pdev->dev, handle_deferred_cxl);
>  }
>  
> +static void remove_soft_reserved(void *data)
> +{
> +	struct resource *r = data;
> +
> +	remove_resource(r);

Type doesn't really help us here so why not skip the local variable.
	remove_resource(data);
	kfree(data);

Though I'd rename data to r.

> +	kfree(r);
> +}
> +
> +static int add_soft_reserve_into_iomem(struct device *host,
> +				       const struct resource *res)
> +{
> +	struct resource *soft = kzalloc(sizeof(*soft), GFP_KERNEL);
> +	int rc;
> +
> +	if (!soft)
> +		return -ENOMEM;
> +
> +	*soft = DEFINE_RES_NAMED_DESC(res->start, (res->end - res->start + 1),
> +				      "Soft Reserved", IORESOURCE_MEM,
> +				      IORES_DESC_SOFT_RESERVED);
> +
> +	rc = insert_resource(&iomem_resource, soft);
> +	if (rc) {
> +		kfree(soft);

Could use __free() magic here and steal the pointer when you setup the
devm action below.  Only a small simplification in this case, so up to
you.

> +		return rc;
> +	}
> +
> +	rc = devm_add_action_or_reset(host, remove_soft_reserved, soft);
> +	if (rc)
> +		return rc;
> +
> +	return 0;

Trivial:

	return dev_add_action_or_reset(host...)

> +}


