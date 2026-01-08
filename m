Return-Path: <linux-fsdevel+bounces-72817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBEAD04A42
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 18:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECBE2338B26A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABEC4BED30;
	Thu,  8 Jan 2026 10:44:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DF44BDEB0;
	Thu,  8 Jan 2026 10:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767869058; cv=none; b=tfkSBcQWzCAouzCKmXVQ8FHTboosmMoYruJJLROj0zOhVn/M0hiFBpmXszOdIP4FuoxLwCBkrMbCe7doKUFSfhRyrnM+Olj/zGmRGw/OTLoixbepF1AEmT2rE0ckQH78/qYUNfdLovOg33LRfxlz+xUKh2i6CyqoZeWtRd4s2Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767869058; c=relaxed/simple;
	bh=Ny4RaHcpG7jXWvMNB3ojt451TJHh0rJcIQA3Waucmps=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3cxMdN3Zwa5hatKlzkMpZ5IRGGnwbsfNlEt1C8ck7POU4BGs68Ns1R4/mKkt4hgLlhQywMm++lP0/E6HR6OWzE5JOZ33a07OyUsSM9+6jDpctdBdVCPSljngrQaCs6ORzdr1V1r/AfsXBzS/sKrEmgzTfnEjHF8W63gZclboFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dn1jL4yF8zJ4685;
	Thu,  8 Jan 2026 18:43:50 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 63A5240086;
	Thu,  8 Jan 2026 18:43:55 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 8 Jan
 2026 10:43:53 +0000
Date: Thu, 8 Jan 2026 10:43:52 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: John Groves <John@Groves.net>
CC: Miklos Szeredi <miklos@szeredi.hu>, Dan Williams
	<dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, "Alison
 Schofield" <alison.schofield@intel.com>, John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan
 Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, "David
 Hildenbrand" <david@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, Stefan
 Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, Josef
 Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Chen
 Linxuan <chenlinxuan@uniontech.com>, "James Morse" <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>, "Sean Christopherson" <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>, Aravind Ramesh <arramesh@micron.com>, Ajay
 Joshi <ajayjoshi@micron.com>, <venkataravis@micron.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V3 01/21] dax: move dax_pgoff_to_phys from
 [drivers/dax/] device.c to bus.c
Message-ID: <20260108104352.000079c3@huawei.com>
In-Reply-To: <20260107153332.64727-2-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
	<20260107153332.64727-1-john@groves.net>
	<20260107153332.64727-2-john@groves.net>
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
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed,  7 Jan 2026 09:33:10 -0600
John Groves <John@Groves.net> wrote:

> This function will be used by both device.c and fsdev.c, but both are
> loadable modules. Moving to bus.c puts it in core and makes it available
> to both.
> 
> No code changes - just relocated.
> 
> Signed-off-by: John Groves <john@groves.net>
Hi John,

I don't know the code well enough to offer an opinion on whether this
move causes any issues or if this is the best location, so review is superficial
stuff only.

Jonathan

> ---
>  drivers/dax/bus.c    | 27 +++++++++++++++++++++++++++
>  drivers/dax/device.c | 23 -----------------------
>  2 files changed, 27 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index fde29e0ad68b..a2f9a3cc30a5 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -7,6 +7,9 @@
>  #include <linux/slab.h>
>  #include <linux/dax.h>
>  #include <linux/io.h>
> +#include <linux/backing-dev.h>

I'm not immediately spotting why this one.  Maybe should be in a different
patch?

> +#include <linux/range.h>
> +#include <linux/uio.h>

Why this one?

Style wise, dax seems to use reverse xmas tree for includes, so
this should keep to that.

>  #include "dax-private.h"
>  #include "bus.h"
>  
> @@ -1417,6 +1420,30 @@ static const struct device_type dev_dax_type = {
>  	.groups = dax_attribute_groups,
>  };
>  
> +/* see "strong" declaration in tools/testing/nvdimm/dax-dev.c  */
Bonus space before that */
Curiously that wasn't there in the original.

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
> +}
> +EXPORT_SYMBOL_GPL(dax_pgoff_to_phys);
> +
>  static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
>  {
>  	struct dax_region *dax_region = data->dax_region;
> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> index 22999a402e02..132c1d03fd07 100644
> --- a/drivers/dax/device.c
> +++ b/drivers/dax/device.c
> @@ -57,29 +57,6 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
>  			   vma->vm_file, func);
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
>  static void dax_set_mapping(struct vm_fault *vmf, unsigned long pfn,
>  			      unsigned long fault_size)
>  {


