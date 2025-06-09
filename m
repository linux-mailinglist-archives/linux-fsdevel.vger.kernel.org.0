Return-Path: <linux-fsdevel+bounces-51024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2C5AD1E64
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 15:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D73D188B0F4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 13:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35216257AFB;
	Mon,  9 Jun 2025 13:01:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B729258CF0;
	Mon,  9 Jun 2025 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749474114; cv=none; b=G6wf2vxUl3UYODwidw9M22fP04rUGlmE/yjgzCoG9BA5aba2avi53FDKrHvJeKLM4IRZo+Xennyc7zFESdK41gEBmGNyWLp40phPjJWLWirK6iXKZQ+yOHGhATcueI3CkPAlfhME68Rdt38T5DrHJaiQQtiGvjDq+NlVmd/17Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749474114; c=relaxed/simple;
	bh=6O2oFoq7/tNbsOXuXUHwAhsSFeAgO9v70mNYRx8wUjA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HoOHXOpF5KqdfYmgdpovbsYmCVK4B7favgDHySQiBf1n6zYKlnRlyczLNXBTvgJc4ZMcA3+UB52k33UviLS4SGlxqpDfUJpfWguxxQLkE6N/wb5uPTCiHIEJofcw9o5ggRV5HrfrxzwFoACpZ+FetpkScQjh4Ha2RYLs/ea5kC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGBrS5fysz6M4tN;
	Mon,  9 Jun 2025 21:01:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2095A1404D8;
	Mon,  9 Jun 2025 21:01:50 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 9 Jun
 2025 15:01:48 +0200
Date: Mon, 9 Jun 2025 14:01:47 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v4 7/7] cxl/dax: Defer DAX consumption of SOFT RESERVED
 resources until after CXL region creation
Message-ID: <20250609140147.00000a1e@huawei.com>
In-Reply-To: <20250603221949.53272-8-Smita.KoralahalliChannabasappa@amd.com>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
	<20250603221949.53272-8-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 3 Jun 2025 22:19:49 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> From: Nathan Fontenot <nathan.fontenot@amd.com>
>=20
> The DAX HMEM driver currently consumes all SOFT RESERVED iomem resources
> during initialization. This interferes with the CXL driver=E2=80=99s abil=
ity to
> create regions and trim overlapping SOFT RESERVED ranges before DAX uses
> them.
>=20
> To resolve this, defer the DAX driver's resource consumption if the
> cxl_acpi driver is enabled. The DAX HMEM initialization skips walking the
> iomem resource tree in this case. After CXL region creation completes,
> any remaining SOFT RESERVED resources are explicitly registered with the
> DAX driver by the CXL driver.
>=20
> This sequencing ensures proper handling of overlaps and fixes hotplug
> failures.
>=20
> Co-developed-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
> Signed-off-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/cxl/core/region.c | 10 +++++++++
>  drivers/dax/hmem/device.c | 43 ++++++++++++++++++++-------------------
>  drivers/dax/hmem/hmem.c   |  3 ++-
>  include/linux/dax.h       |  6 ++++++
>  4 files changed, 40 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3a5ca44d65f3..c6c0c7ba3b20 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -10,6 +10,7 @@
>  #include <linux/sort.h>
>  #include <linux/idr.h>
>  #include <linux/memory-tiers.h>
> +#include <linux/dax.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
>  #include "core.h"
> @@ -3553,6 +3554,11 @@ static struct resource *normalize_resource(struct =
resource *res)
>  	return NULL;
>  }
> =20
> +static int cxl_softreserv_mem_register(struct resource *res, void *unuse=
d)
> +{
> +	return hmem_register_device(phys_to_target_node(res->start), res);
> +}
> +
>  static int __cxl_region_softreserv_update(struct resource *soft,
>  					  void *_cxlr)
>  {
> @@ -3590,6 +3596,10 @@ int cxl_region_softreserv_update(void)
>  				    __cxl_region_softreserv_update);
>  	}
> =20
> +	/* Now register any remaining SOFT RESERVES with DAX */
> +	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED, IORESOURCE_MEM,
> +			    0, -1, NULL, cxl_softreserv_mem_register);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_region_softreserv_update, "CXL");
> diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
> index 59ad44761191..cc1ed7bbdb1a 100644
> --- a/drivers/dax/hmem/device.c
> +++ b/drivers/dax/hmem/device.c
> @@ -8,7 +8,6 @@
>  static bool nohmem;
>  module_param_named(disable, nohmem, bool, 0444);
> =20
> -static bool platform_initialized;
>  static DEFINE_MUTEX(hmem_resource_lock);
>  static struct resource hmem_active =3D {
>  	.name =3D "HMEM devices",
> @@ -35,9 +34,7 @@ EXPORT_SYMBOL_GPL(walk_hmem_resources);
> =20
>  static void __hmem_register_resource(int target_nid, struct resource *re=
s)
>  {
> -	struct platform_device *pdev;
>  	struct resource *new;
> -	int rc;
> =20
>  	new =3D __request_region(&hmem_active, res->start, resource_size(res), =
"",
>  			       0);
> @@ -47,21 +44,6 @@ static void __hmem_register_resource(int target_nid, s=
truct resource *res)
>  	}
> =20
>  	new->desc =3D target_nid;
> -
> -	if (platform_initialized)
> -		return;
> -
> -	pdev =3D platform_device_alloc("hmem_platform", 0);
> -	if (!pdev) {
> -		pr_err_once("failed to register device-dax hmem_platform device\n");
> -		return;
> -	}
> -
> -	rc =3D platform_device_add(pdev);
> -	if (rc)
> -		platform_device_put(pdev);
> -	else
> -		platform_initialized =3D true;
>  }
> =20
>  void hmem_register_resource(int target_nid, struct resource *res)
> @@ -83,9 +65,28 @@ static __init int hmem_register_one(struct resource *r=
es, void *data)
> =20
>  static __init int hmem_init(void)
>  {
> -	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
> -			IORESOURCE_MEM, 0, -1, NULL, hmem_register_one);
> -	return 0;
> +	struct platform_device *pdev;
> +	int rc;
> +
> +	if (!IS_ENABLED(CONFIG_CXL_ACPI)) {
> +		walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
> +				    IORESOURCE_MEM, 0, -1, NULL,
> +				    hmem_register_one);
> +	}
> +
> +	pdev =3D platform_device_alloc("hmem_platform", 0);
> +	if (!pdev) {
> +		pr_err("failed to register device-dax hmem_platform device\n");
> +		return -1;
> +	}
> +
> +	rc =3D platform_device_add(pdev);

platform_device_register_simple("hmem_platform", -1, NULL, 0); or something=
 like
that?  There are quite a few variants of platform_device_register to cover
simple cases.


> +	if (rc) {
> +		pr_err("failed to add device-dax hmem_platform device\n");
> +		platform_device_put(pdev);
> +	}
> +
> +	return rc;
>  }
> =20
>  /*


