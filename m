Return-Path: <linux-fsdevel+bounces-16675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E42098A14A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137091C2182E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 12:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9942C14D290;
	Thu, 11 Apr 2024 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lhQarAhU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BB014B088;
	Thu, 11 Apr 2024 12:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712838580; cv=fail; b=pNkif0uGQGl3ePGHLwuviO9+MJxj6sAGy/AfyVK8RNTHVzOtWEomgsu7MQP4KXyAlHlbnQIWoNoPKtL8T4KvDw5XLzE3zXGWuriXa1tdeScOU3F0dEakUAGYYIe6rETXmSw00A6BDPVnkpwHcUatUpb2Y8wm3ruA8TZ/Nei3CxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712838580; c=relaxed/simple;
	bh=0PruHwt3xH+dYSS4rTmA9Sn0QsQ5uAGU+4kOLkMGc80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NaDusdB1y18nDwJb6ZzrPUaVfaqr9eGVlfHocVOZDByA5ahkwYm66JjzcKe7qI/qM4NpBtqHPUiXLL8YpEFncOBA+PYSoe14Lw4jR9PJKzGLgra5ZdLpwn46SfCumdVUqjvipAaOzMqt+rKhjea/NJGXtf3+yOCOyoPMthF3K/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lhQarAhU; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtlaR22BfyLVKEP8jwnnFy2l+reqjgOmcL3OGEq8R1+PX+nCF+uqpVv3zq6P6coUpaWWwMtyz0FgFCblRcf+1DRcHw5t5sCfZweUmJdaCTEXsXd6u52dBZ4jW8fmeWwbrP2Dz4B+CMkeCOdgqCCUwhofmtoFE5C+GTk5V2+6AQzuL5aX0S/7HIs1cAz8pyA5McHRfTuYSGeWONwa/RCjbcqDXRdQYfTnG+FXjXpFOKT3ABnQ58RaTp9+oZ40cg+daX8gsBefm+Nj/u0UGKCUu95DAXmF0I/LRyl0DhWSqDK9l2RU4dplrfrZcctD0S4tLt7IF+Q95Pz5hY62ed4/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72fVWKxpL5DknHhtJL6NQajf5ZgJO71nN6LfO8fJy9M=;
 b=fhxWABkZEEDY9soeeAKlU1ETKHzGvThIAfPKFr1VwLt9hQ2Z2dEcxU5TF8Y4sLE9J8pnesQTqS/WeTeuOZL6ytJQ7FDBD7ULR4dg4a5wj7MQ/CwhS7h0/N7DKYym2zkSeyv7hHxGRN2JNh1H0ISDGrBKmuOvl8CK80ENmwMzA67/1SL7zqYk6gCzcIglwcFhqk1kIrrUgM60Y3iD+fvoXGc57JP4q7ZissNLEZ6qEUZ8OOlW5DW74sOjF4Jg3s4m1JAwMjhwXIXLSHPgaMyTCgRSFjCuIQ38FiXMDchnHF2HMvx7sSHacdjuvfwVYxgrY41yWrcpOwOHubjSXfYh/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72fVWKxpL5DknHhtJL6NQajf5ZgJO71nN6LfO8fJy9M=;
 b=lhQarAhU9tvCU+wJ2B9E2uhDjv15kMFIKPC3TvVxzigQtueskaNic5k8IPG0niZfBaHttR61F3GkhfGy2uh0b7uv+0UCmp27tocs++D/yrh3sLBm+kNRT1Q8pUKjxGXVfNnu+2vNZfTneD7GkEdS87JGSp4Dpvh+6orGtOz8gsCaBtdHBpIj3vjITVvYvStFrd+PCLpA6ixrYyD2x8jraSOrWxWfzyYGHcHjEvrrTB35RoSQMQ1dawVi9DrhTZ40UbjKANaZPe4yMY7jHmIlMGbu24/K0eWXDJ4wex7lA0q5PZwDb3aJrkgKfVVvdI9SnPF1w4jYdtAn7CDeR2+v7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH0PR12MB8773.namprd12.prod.outlook.com (2603:10b6:510:28d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 12:29:28 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 12:29:28 +0000
Date: Thu, 11 Apr 2024 09:29:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, david@fromorbit.com, dan.j.williams@intel.com,
	jhubbard@nvidia.com, rcampbell@nvidia.com, willy@infradead.org,
	linux-fsdevel@vger.kernel.org, jack@suse.cz, djwong@kernel.org,
	hch@lst.de, david@redhat.com, ruansy.fnst@fujitsu.com,
	nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, jglisse@redhat.com
Subject: Re: [RFC 03/10] pci/p2pdma: Don't initialise page refcount to one
Message-ID: <20240411122927.GR5383@nvidia.com>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <a443974e64917824e078485d4e755ef04c89d73f.1712796818.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a443974e64917824e078485d4e755ef04c89d73f.1712796818.git-series.apopple@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:208:32f::18) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH0PR12MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b01c31-d922-44fa-6aee-08dc5a2307d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3+MU1hkBVm8G0ROMao0EKCfWg8dYnQm644g84xXcs1hmTuPEPr7HTqONDJ/Vi+NouJ6jlvKkp6tdomLRBK0zeoOVIUCXTpfmm4aTKr2J0jKZgQu5Z9ZE8TxEsvsKL615z5dIDOITfKeU4R0Ae/QBz+OCbsN+ZZZISJ07zX2tXHflDaRsW5DLsVrQlDL7CBzRuZyxeEglKrCh377FE+42NbwAmOdLLSX1NqFHdGM9SmgGMPP5o3sgAyKTNR7TdbD8niauCQJNF141MxX9v2rxdNVHbc26GGBwTOgoQfc2MJbkzktVeNa1hIWhTX6h6c+Ze5yrBrYhFdTNHCFdBQ2wJI8ecbweFrDTrvagfP1lnTNF7JJHQ7Rre7yJhThMziDtuz24GW7IX5ZERNYpf+vHCdyJ0SnT4MZBfGWsugaAdDdWfkHhKe8z/U09qM9fol172ghAfNLh8p2QFY1yeH0qbC+egFKHcoY3PhgWOwjXY7umU3tCZnOA/uzzbmqHSEnxiEhjdUkzLUxbTsHCf/CzHudyus0fDoT8KactPsbbddQ0JheYaBcT26rSTRuNh7CWUA2SvnjAkcoIjqYl/OlzIy8YlaLHNFD51+qDzp84ByhRikoQKyfmIgNVwlv+R6yy3hNKgQ5nBfRhby8Md5/xoiNfbHN0CDBM5KYFUxgPuIg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ngsN4LmrmMB7JCMGJWV7UoYXqhTZm8ZbP78IeTs30Vrq+o70QvdW8IHISWuA?=
 =?us-ascii?Q?q75++o187vy5fGu3fgRLe0eiLbJGWQMsWsLBUO+noo2mBUXnKJSo4U7Ksupc?=
 =?us-ascii?Q?6nro58Vk+B5w+LSKiEhWWYvnfI/b5fjrUpu8AesncAaouvBGIPpSroh57Rpy?=
 =?us-ascii?Q?PCA9NLKwA5m6TZ4Rtv1LCaX84BBDcAhdMMU1iip+YTZU3FCFWMu0zqlQOhEG?=
 =?us-ascii?Q?kpVfyMTnMpQFRVyw5oUmGKL1jx+w/86ll9AJoc9bKOOjYZvZmusC1436y59C?=
 =?us-ascii?Q?orDyd8tIAcuKnnotgrA6jAAN/PQlWW7SqDHczdrE3zpDmghYKLHJ6f6HJ0NI?=
 =?us-ascii?Q?06KjS3pWe66Bxo3eJNXHZ07AHg34Ld5d9y3aF5P9ZWL1lVDsFgteiqztg0+8?=
 =?us-ascii?Q?oqaod1si7VqEguQQMHFe8/6ls9hKXqVY0iJ9zy/w81OXZH4QSM8ZeayNGutu?=
 =?us-ascii?Q?W35vK3YaWBqv99p8J/o7BQ+DB806/7HVjjBEAFxEH5SrpYhWZKFOR14xQ8hU?=
 =?us-ascii?Q?f966vMRHf2kNFH8AY5iXyamW5hj55wHCyN3hjj2DuSOOBNjNQx3xrgLWnzG5?=
 =?us-ascii?Q?kcoyYloK/7dT0pNibSCLJisIvfZ0YqbZfDMV3mhoen1MAjv54QctzufIcwCV?=
 =?us-ascii?Q?RHMU+CuuAPRMv+hWhmyHiEtX9lY+6BGrX2MN6oYb8RMTMseNj3MEHUHXg0zS?=
 =?us-ascii?Q?fsJflme7l+S+M9ZhZ1J1o/TmqLlR9qpeT7HXsL/77eDOM9UXYp1ZqjK0JQGv?=
 =?us-ascii?Q?yojrCcvTPXemoo9AH2g0NI31pLDR6peurvroJ9v2LvQq/aDVLZlTsc64dNoO?=
 =?us-ascii?Q?+7Kpc/yIGjqjPHjTe5Sl6VxXCdNCuhUqEIlApXeMlkSn1te6m5a5hDxNkcY/?=
 =?us-ascii?Q?Irs5T8eX0dulto8KeRDzjnp2fMR/EceuQdi1DfUmhqfpCeYMnDV2py4gT7wb?=
 =?us-ascii?Q?rYQ/ymhdzABsBKcsBZX59daHA1Me2/mbQO1j0t3Qi9klGTdVHnohvsJUZqSd?=
 =?us-ascii?Q?4VNQxu0GN8rYm06SzZ/Ktmr3j63iUAaMV7w36jMfqTTldGYd0LrgpnO0KR6R?=
 =?us-ascii?Q?Hwijr93Kfmf/ETewKTorPdb/yuVBki/M7gsVz4wfUSIScQwzXBkVFfDFZDaC?=
 =?us-ascii?Q?i0+GGNFg6eAILPy8ChIJQYViDZTXQoNb6QqVZyl1eBSeVfpSlyqApTPHTH0r?=
 =?us-ascii?Q?WkwqBQ5QvWIwoeG/CP+MUg/m6ZwfqosNveC+nXAsl731Jmsr08L+7pluOj5q?=
 =?us-ascii?Q?n6GVRoDv1uqhpO2GgPGIaZVOPsLoix0f6Z3qFLP51gM5u/DVvFBJa2HmTaQ4?=
 =?us-ascii?Q?K6w3RXEKL/FEXXBXCtn9EXoJ59fkL0CilXw/3rMeDVWMulstrrb7EiTP28HY?=
 =?us-ascii?Q?hggghhKI8hitis7ITZMxENaErvUQaqMhyPWthpC1KONjgF9KVGFFk2L1QoX5?=
 =?us-ascii?Q?xy52smduGleznFcmB6GveZu574QYOrv55BCujhuTcKAXKW0cWFDl2Bk0Dhde?=
 =?us-ascii?Q?LsqMprTa44HXQCznFUbVi46K3gd1qgpHD4LACcpuh/Q0Af27D3C2N7VL+aX2?=
 =?us-ascii?Q?OUvX//0q8FCGs0Z+INOzDNCsstMIrzfelV6h0Tfn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b01c31-d922-44fa-6aee-08dc5a2307d7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 12:29:28.2740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zltAxAxARGcmFQQEFIc0HPTF1bMjhuHnsgnkaJCbF0y2Sysl9oKqM2KSJqpqYPCR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8773

On Thu, Apr 11, 2024 at 10:57:24AM +1000, Alistair Popple wrote:
> The reference counts for ZONE_DEVICE private pages should be
> initialised by the driver when the page is actually allocated by the
> driver allocator, not when they are first created. This is currently
> the case for MEMORY_DEVICE_PRIVATE and MEMORY_DEVICE_COHERENT pages
> but not MEMORY_DEVICE_PCI_P2PDMA pages so fix that up.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  drivers/pci/p2pdma.c | 2 ++
>  mm/memremap.c        | 8 ++++----
>  mm/mm_init.c         | 4 +++-
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index fa7370f..ab7ef18 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -128,6 +128,8 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
>  		goto out;
>  	}
>  
> +	get_page(virt_to_page(kaddr));
> +

Should this be 

 set_page_count(page, 1)

If the refcount is already known to be 0 ?

> @@ -508,15 +508,15 @@ void free_zone_device_page(struct page *page)
>  	page->mapping = NULL;
>  	page->pgmap->ops->page_free(page);
>  
> -	if (page->pgmap->type != MEMORY_DEVICE_PRIVATE &&
> -	    page->pgmap->type != MEMORY_DEVICE_COHERENT)
> +	if (page->pgmap->type == MEMORY_DEVICE_PRIVATE ||
> +	    page->pgmap->type == MEMORY_DEVICE_COHERENT)
> +		put_dev_pagemap(page->pgmap);

Not related, but we should really be getting rid of this devmap
refcount traffic too, IMHO..

If an implementation wants this then it should hook the page
free/alloc callbacks and do this, not put it in the core code.

Jason

