Return-Path: <linux-fsdevel+bounces-12794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90769867472
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 13:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB9C287848
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 12:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991B86024F;
	Mon, 26 Feb 2024 12:10:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C865FF15;
	Mon, 26 Feb 2024 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949441; cv=none; b=eFNV8+JmQlkEYLhjEga1zAwWtD7DAga+3Cc0pqCsLSjM7JKVyYqFGpcoP7v32pdAZTFuNr64pP6zWcIUHBwuOj2Cdn4OO03Hn4IFm+Kd+8uvchiOfRm/b9QZzdDLJmp7s3UXyHywfJY0Ub3ZQTZ5SqoTu4kN0K9u1Wm42ocjNuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949441; c=relaxed/simple;
	bh=ghthQB9VdSgFeOK/mgD0fV9zUBPGih/cqEwrsOB0Wyk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=svfR0FZsoNIDLDU6AXpRGbQdjbPcdOWKTcsvmuIRUs6/W3GPHl0YcuVKxqvgR9YbWBIBh2MPj0m7jcXFO9jARjafmsgqJrekMueQ9mgBlo7jBeADINyBLBtZMpWjhq/67cMBh8vdkUGIcy13x5e4wIcIDudAU6qwhc/rO3pJ/KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tjzpz1h6rz6JBSD;
	Mon, 26 Feb 2024 20:06:03 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D2255141388;
	Mon, 26 Feb 2024 20:10:36 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 12:10:36 +0000
Date: Mon, 26 Feb 2024 12:10:35 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: John Groves <John@Groves.net>
CC: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, "Dan
 Williams" <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <john@jagalactic.com>, Dave Chinner
	<david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>,
	<dave.hansen@linux.intel.com>, <gregory.price@memverge.com>
Subject: Re: [RFC PATCH 03/20] dev_dax_iomap: Move dax_pgoff_to_phys from
 device.c to bus.c since both need it now
Message-ID: <20240226121035.00007ca4@Huawei.com>
In-Reply-To: <8d062903cded81cba05cc703f61160a0edb4578a.1708709155.git.john@groves.net>
References: <cover.1708709155.git.john@groves.net>
	<8d062903cded81cba05cc703f61160a0edb4578a.1708709155.git.john@groves.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Feb 2024 11:41:47 -0600
John Groves <John@Groves.net> wrote:

> bus.c can't call functions in device.c - that creates a circular linkage
> dependency.
> 
> Signed-off-by: John Groves <john@groves.net>

This also adds the export which you should mention!

Do they need it already? Seems like tense of patch title
may be wrong.

> ---
>  drivers/dax/bus.c    | 24 ++++++++++++++++++++++++
>  drivers/dax/device.c | 23 -----------------------
>  2 files changed, 24 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 1ff1ab5fa105..664e8c1b9930 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -1325,6 +1325,30 @@ static const struct device_type dev_dax_type = {
>  	.groups = dax_attribute_groups,
>  };
>  
> +/* see "strong" declaration in tools/testing/nvdimm/dax-dev.c  */
> +__weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
> +			      unsigned long size)
> +{
> +	int i;
> +
> +	for (i = 0; i < dev_dax->nr_range; i++) {
> +		struct dev_dax_range *dax_range = &dev_dax->ranges[i];
> +		struct range *range = &dax_range->range;
> +		unsigned long long pgoff_end;
> +		phys_addr_t phys;
> +
> +		pgoff_end = dax_range->pgoff + PHYS_PFN(range_len(range)) - 1;
> +		if (pgoff < dax_range->pgoff || pgoff > pgoff_end)
> +			continue;
> +		phys = PFN_PHYS(pgoff - dax_range->pgoff) + range->start;
> +		if (phys + size - 1 <= range->end)
> +			return phys;
> +		break;
> +	}
> +	return -1;

Not related to your patch but returning -1 in a phys_addr_t isn't ideal.
I assume aim is all bits set as a marker, in which case
PHYS_ADDR_MAX from limits.h would make things clearer.

> +}
> +EXPORT_SYMBOL_GPL(dax_pgoff_to_phys);
> +
>  struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
>  {
>  	struct dax_region *dax_region = data->dax_region;
> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> index 93ebedc5ec8c..40ba660013cf 100644
> --- a/drivers/dax/device.c
> +++ b/drivers/dax/device.c
> @@ -50,29 +50,6 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
>  	return 0;
>  }
>  
> -/* see "strong" declaration in tools/testing/nvdimm/dax-dev.c */
> -__weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
> -		unsigned long size)
> -{
> -	int i;
> -
> -	for (i = 0; i < dev_dax->nr_range; i++) {
> -		struct dev_dax_range *dax_range = &dev_dax->ranges[i];
> -		struct range *range = &dax_range->range;
> -		unsigned long long pgoff_end;
> -		phys_addr_t phys;
> -
> -		pgoff_end = dax_range->pgoff + PHYS_PFN(range_len(range)) - 1;
> -		if (pgoff < dax_range->pgoff || pgoff > pgoff_end)
> -			continue;
> -		phys = PFN_PHYS(pgoff - dax_range->pgoff) + range->start;
> -		if (phys + size - 1 <= range->end)
> -			return phys;
> -		break;
> -	}
> -	return -1;
> -}
> -
>  static void dax_set_mapping(struct vm_fault *vmf, pfn_t pfn,
>  			      unsigned long fault_size)
>  {


