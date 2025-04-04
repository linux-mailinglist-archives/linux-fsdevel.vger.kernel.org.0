Return-Path: <linux-fsdevel+bounces-45760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A7DA7BDE1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 15:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E7C3B860B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 13:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43FD1EF0AD;
	Fri,  4 Apr 2025 13:33:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2812718D656;
	Fri,  4 Apr 2025 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743773581; cv=none; b=Bve+X/+XfmNIeLKM8mA0VlZQjOAsitxrJ+I2Si7eg0L7Q/aOnoVVBCI6TbnW9N/FiIjaAuh7lV975/NArz2Dl+qOs2hg0vEOGBdSo0CnUr1QwS9aOIN7s1AOu+I3W3YcKPfDkSw1tSdHICR97QOb3jQwBGg/SnzUzHwaeuQ+Pis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743773581; c=relaxed/simple;
	bh=x7lhNPOeDPftGyhj/PQXzkwnB0cuPTUxuDGk+lZ+BGA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YJV1dcRPiSMgUJnCywF6bYIGDvI4lg3MKQsv3D6DVzeY/rAYITPerA4Vs7h4x+Y2Hmf06zhjULlzTCUOi+JEW6X5FIX5J9EbSpahF6IAOAIqrHxbFtjd8RvHqLYTYE4VRcZV12qA2kOb7j3uErK440yHwjQOyb7bSybEPnu7eOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTfZx4bsCz6M4M9;
	Fri,  4 Apr 2025 21:29:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7524B140682;
	Fri,  4 Apr 2025 21:32:55 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 15:32:53 +0200
Date: Fri, 4 Apr 2025 14:32:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <willy@infradead.org>, <jack@suse.cz>,
	<rafael@kernel.org>, <len.brown@intel.com>, <pavel@ucw.cz>,
	<ming.li@zohomail.com>, <nathan.fontenot@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <huang.ying.caritas@gmail.com>,
	<yaoxt.fnst@fujitsu.com>, <peterz@infradead.org>,
	<gregkh@linuxfoundation.org>, <quic_jjohnson@quicinc.com>,
	<ilpo.jarvinen@linux.intel.com>, <bhelgaas@google.com>,
	<andriy.shevchenko@linux.intel.com>, <mika.westerberg@linux.intel.com>,
	<akpm@linux-foundation.org>, <gourry@gourry.net>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <rrichter@amd.com>, <benjamin.cheatham@amd.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lizhijian@fujitsu.com>
Subject: Re: [PATCH v3 2/4] cxl: Update Soft Reserved resources upon region
 creation
Message-ID: <20250404143252.00007d06@huawei.com>
In-Reply-To: <20250403183315.286710-3-terry.bowman@amd.com>
References: <20250403183315.286710-1-terry.bowman@amd.com>
	<20250403183315.286710-3-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 3 Apr 2025 13:33:13 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Nathan Fontenot <nathan.fontenot@amd.com>
> 
> Update handling of SOFT RESERVE iomem resources that intersect with
> CXL region resources to remove intersections from the SOFT RESERVE
> resources. The current approach of leaving SOFT RESERVE resources as
> is can cause failures during hotplug replace of CXL devices because
> the resource is not available for reuse after teardown of the CXL device.
> 
> To accomplish this the cxl acpi driver creates a worker thread at the

Inconsistent in capitalization. I'd just use CXL ACPI here given you used CXL PCI
below.

> end of cxl_acpi_probe(). This worker thread first waits for the CXL PCI
> CXL mem drivers have loaded. The cxl core/suspend.c code is updated to
> add a pci_loaded variable, in addition to the mem_active variable, that
> is updated when the pci driver loads. Remove CONFIG_CXL_SUSPEND Kconfig as
> it is no longer needed. A new cxl_wait_for_pci_mem() routine uses a
> waitqueue for both these driver to be loaded. The need to add this
> additional waitqueue is ensure the CXL PCI and CXL mem drivers have loaded
> before we wait for their probe, without it the cxl acpi probe worker thread
> calls wait_for_device_probe() before these drivers are loaded.
> 
> After the CXL PCI and CXL mem drivers load the cxl acpi worker thread
CXL ACPI

> uses wait_for_device_probe() to ensure device probe routines have
> completed.

Does it matter if these drivers go away again?  Everything seems
to be one way at the moment.

> 
> Once probe completes and regions have been created, find all cxl

CXL

> regions that have been created and trim any SOFT RESERVE resources
> that intersect with the region.
> 
> Update cxl_acpi_exit() to cancel pending waitqueue work.
> 
> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>


> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index be8a7dc77719..40835ec692c8 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -858,6 +858,7 @@ bool is_cxl_pmem_region(struct device *dev);
>  struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
>  int cxl_add_to_region(struct cxl_port *root,
>  		      struct cxl_endpoint_decoder *cxled);
> +int cxl_region_srmem_update(void);

As before: srmem is a bit obscure. Maybe spell it out more.

>  struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
>  u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
>  #else
> @@ -902,6 +903,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>  
> +void cxl_wait_for_pci_mem(void);


