Return-Path: <linux-fsdevel+bounces-35536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B1B9D5872
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 03:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA82F282C7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 02:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825BA22087;
	Fri, 22 Nov 2024 02:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dKQlT9bz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02494C66;
	Fri, 22 Nov 2024 02:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732244259; cv=fail; b=HWR1ZNJxEUUc5QFdc53FSNQ2ZNPTqnvekI28/8EXpvxUtdMimcLX85G+cX+r/sZ+u/vV2kUrkwtTbhZ9injxkBqVnsh8vCWBD8HBoB6ZMPVVkfmVIzjesPWO4pUZTm0gUadrZWygFUW2ObesmrUTZMm9wK0v31gowM2dW06XouM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732244259; c=relaxed/simple;
	bh=q+oeA9+a5rEmoP3J7oNn1zc6pUm6nLo+oOP732lsL8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iOQKH++oS6xLY9bim7nO3g+QC+/QoyFVKwYrlfGhFnMGaMs30uywR85L5Ma9ywqH1mnbFZHWlsCkMpSLpfs60HD/2DTbAxxiE3culk1G3ed5zSBTmXrwKOXQdbHt9vVJZYnIEqQCjdDTsGomyiDw9lqXmGyGtkQcQBA3wME+4ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dKQlT9bz; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVrpOTTaVbAVA8bHDjpAmP+jh/45eONOyfNF2nYcLkwGkYScF0yat5ielO96VD/olLqpRXbHUaw2SvyaSjObd0cDXX9FC30DK2x82V9O9Jl1LGLQd82f8r3CkzpFPpMZrAiYaBrXrW17XTdh4exbs+xI4BCMnwltTRiGFdneInXQZ3njTX9NyhzqXMCTMlRLOZIvXhjSHi8d4TPiKejpSy7eemnhNgQ5TdkKx+P6b5oYvKms5Pgas7b1PZhO4j7F+H63LDWYB/HvuVSDmDXdSu+5HOD3XupPy6S3bUs8rABw++3cOCh0TKnQW7+38i+FZeJS+Oo4aOrTQ2IeMqZwcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30VYJrYa9n9dqrOBYLYdPedn8shgxJ7X+TBgLEuqTXI=;
 b=vp/IacL3neFs5/vWaJaqCfMhrpz9nJ1iQshH6KLjie5hZCDDkPSoMFQXeo+L8V3GFQg5A5gp/hx7v/ZSQCuP/21QTW5DhjNNO+aaMBSyy+Jjac3YfENpzO5Aj8glJeV7YnmumuU0JgpiOmi9GpC3jeuWbaUGnmgI6JtMSXi9NZvxIDp52p9J2rUDNzkDZS90f0J0PR17+AY15Q+ipzc6iH0ddecRsLb8kaVQghu4W4qbFyxyuFaUCb8s0VCzGEWuTBdkZSDw0L/T0vduPCZb9opfRlQCFv+lPrDZrDgLw18fSt3ulVUV1aTXD0EQG/u0UjyvD2WlW5zzQ+rsvztfdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30VYJrYa9n9dqrOBYLYdPedn8shgxJ7X+TBgLEuqTXI=;
 b=dKQlT9bzGyIsiHC6BHEQLLmcDVO/dMPvupnkYvluw7wr74GAgXafFsRQ9U0uOlNrroiYLrn50ymhRruW7G9updyOYISXr33HItfxitN8pY4ecWiPMJ1MD1/zeZQYF5JOqq+yArKe01UP0Y1Gohxf020nnDRKN+RcmzHK5dLrJ6FP2H7e6eGgvqbjBmDexHBN3Lc76ZT6GTG3GGWuPuf5bAxtI7Cl+49MhTouOawFshQNnRdirkxj8aaal3c1Ta0EyxxFQ/K/WGCrpBgP8PmTLkesx+ox+VztEuXZIPc2tgHkBx/Fvt/lzpN8wb/oi5QDdlQB9CGDSYFlHtsrJYlr/w==
Received: from CH2PR08CA0021.namprd08.prod.outlook.com (2603:10b6:610:5a::31)
 by MN0PR12MB6366.namprd12.prod.outlook.com (2603:10b6:208:3c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Fri, 22 Nov
 2024 02:57:30 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::9b) by CH2PR08CA0021.outlook.office365.com
 (2603:10b6:610:5a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend
 Transport; Fri, 22 Nov 2024 02:57:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 02:57:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 21 Nov
 2024 18:57:18 -0800
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 21 Nov
 2024 18:57:17 -0800
Message-ID: <61ff7fe6-9a79-4dd3-8076-7106fe08be5c@nvidia.com>
Date: Thu, 21 Nov 2024 18:57:16 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/25] fs/dax: Create a common implementation to break
 DAX layouts
To: Alistair Popple <apopple@nvidia.com>, <dan.j.williams@intel.com>,
	<linux-mm@kvack.org>
CC: <lina@asahilina.net>, <zhang.lyra@gmail.com>,
	<gerald.schaefer@linux.ibm.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <logang@deltatee.com>, <bhelgaas@google.com>,
	<jack@suse.cz>, <jgg@ziepe.ca>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <willy@infradead.org>, <djwong@kernel.org>,
	<tytso@mit.edu>, <linmiaohe@huawei.com>, <david@redhat.com>,
	<peterx@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxppc-dev@lists.ozlabs.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>, <hch@lst.de>,
	<david@fromorbit.com>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
 <31b18e4f813bf9e661d5d98d928c79556c8c2c57.1732239628.git-series.apopple@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <31b18e4f813bf9e661d5d98d928c79556c8c2c57.1732239628.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|MN0PR12MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: 516fc921-716c-431f-00ff-08dd0aa167fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2xXS1MvSjdEN0E0WWV3ci9JRDVxM2JUMzVQRWhkYmV1MmpYRkNwTDd3bm12?=
 =?utf-8?B?cFRHWDJLbkVnYUlLYU5LcXZPUk9kTmFGT3lPRE5nSjZINldQTXlWa2FrdG1a?=
 =?utf-8?B?S1krdVJEaGhZeGlia085clpicURhOW9TYnZNQ1JNclNZbnRuN1dHeElKWGlD?=
 =?utf-8?B?cWxpbC9wZ1ZKZFFvQ0dhMUorVTl0Mkc2cE5YdHgyUTVRRHNRWDExcWR3Ymtj?=
 =?utf-8?B?TTFmQzRIV293N3IvZUhZM0RUMWRGOTVWUmhZM3FobDcrLzBxRncvNVRXbytp?=
 =?utf-8?B?UiswNGQvcGxGNFFwNW1ZdmQ3WFRIazJPbHJQS0NqZmZVUUhOU1FrOU43NU5V?=
 =?utf-8?B?TWNPM2pRKzRUeHlWTG84cW5yMFo0NmZaU2VzRGI3UTNYOTc3QUg4NmpjU25U?=
 =?utf-8?B?akdLYXFpNUhYc0UvUURhUE9zcDhhQm1ZNEhMUzBvaWRNdzFMWjVVTlNlQUhm?=
 =?utf-8?B?OFB1Z3BKRFRPcHFaUVR2WUVSajJibEZsZ3FLNnFaZzhSMmxrZ0pvUC9mTFNw?=
 =?utf-8?B?RnJyYkpLRTF5Q2d3NU9qQlgzUjRKU2c1Y00yditlR3FCVi90em9pb1R3TitB?=
 =?utf-8?B?ZWdnNE9kekh0RnBNUHVxYnBEOTlsNUdkUkljZDlnUGY0ODR5WFZ1TDA4bzNv?=
 =?utf-8?B?cXhmcFdGZ3d4NklhSmRUZlhGQVpWZUNHbTRNVzZjODNjTlRhdkE0SE5sL3Ax?=
 =?utf-8?B?VVNzWERJVCsvemMyLzdOT0RwWHJYZElGMGVBVHdQSnN6ODFmRG41dnIrVFht?=
 =?utf-8?B?eGZ5VzYxa3VXL3I5a2RHdWxIZ05Jd25MaVpkb051TG1LYnpJMzE2N0hmeU1R?=
 =?utf-8?B?WjdtcEdRUmNGbGkvSzRtVlZ5YjNHYWVTb0VuL2M1OXVCcFhJVVgwL1A4dVJ0?=
 =?utf-8?B?VU9QRDdTMFQxY2YrMm9qRFZ4TEExK1NpaUNCS1lnQ0xLQ1hVeU9MVkV5SENl?=
 =?utf-8?B?QmdkU09pVmw1SzJnalp3UU41dHVHb0FpVDZvaTFuZUkwYTBPL3I1NXVNbG9k?=
 =?utf-8?B?TDNmWUlXOEYzcHlMWTl4ckc4bmJRYnNTWW5kYWJPVmtyNUorS1dyai91R1dI?=
 =?utf-8?B?dDZGdERGNnpsMDNnQ2FaanFnUWpNRHNDY2RpMm9PUE81ZlhoRHNQTkRIK1lI?=
 =?utf-8?B?d1dTVGZDVTM3Tm9GcU96cmxKeXVveFJEN3E2QTMxZmZOS2QvREZMYjFLN3pk?=
 =?utf-8?B?ZzhGMzNRYk00b3dHZnVldE1xcUtrZitqL1pZa1F1cDA3a2V2WEphS05kWXBW?=
 =?utf-8?B?VTV1UXZQUzB3VE83RWdrZUluekJEbEJXWk1VZzZ2R29oc1A1WUREYnVaM1NV?=
 =?utf-8?B?Y1U1NlQxcUxRbG1XOEpVNUxWMVNZbUpkYVZJZjVqUW96NVo4YnNneDdIRThC?=
 =?utf-8?B?VVNaeFlrdE9QTG82U00vc04wNG8wSDZIVE83UThJcXhJdCtyQi85bUI5b2ly?=
 =?utf-8?B?d2doMFJidFJKd1VkQTRCN1d3LzNKcVhoV3FObEtydm1Sa094bkN0UzYvbEpI?=
 =?utf-8?B?c0tnZXRjYW9KMU5uSzJJckNqODJPU0JvNS9wenZRbkZ5RmRmd1RxVCs1MUVB?=
 =?utf-8?B?OGo0L01jRTRKOEZ2RHA1MmljekZNdC95UTMyTlRtc1UwcHA4V1ZXYWE4Rjdn?=
 =?utf-8?B?LzEwcHBNU2VjanpCazRBcnU0bnM1ellNZi9WZC9pQ3JTcDR1dHFGSWNqSkpT?=
 =?utf-8?B?eDZyZE5iUXdaYUg2RHZxcCs1SEI1aS83VGIxSDdPdnVvTnd2M3U5RjJzVTFt?=
 =?utf-8?B?THZjUUl3dTJBNk0xS2tvSUJGZllIem1kMDh3ZE9zNGtOZjNjMCtoaU14elJZ?=
 =?utf-8?B?cS9KRks4TmpuVWpWSGl3VndPeW5iYmF6SndVKzRFNHVkM0pFSDFuWDVVT3VE?=
 =?utf-8?B?UXhsNm84K1B5YjFlZW5Kb1h4QzNZVklZY0Vpc01OSER4RkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 02:57:30.5718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 516fc921-716c-431f-00ff-08dd0aa167fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6366

On 11/21/24 5:40 PM, Alistair Popple wrote:
> Prior to freeing a block file systems supporting FS DAX must check
> that the associated pages are both unmapped from user-space and not
> undergoing DMA or other access from eg. get_user_pages(). This is
> achieved by unmapping the file range and scanning the FS DAX
> page-cache to see if any pages within the mapping have an elevated
> refcount.
> 
> This is done using two functions - dax_layout_busy_page_range() which
> returns a page to wait for the refcount to become idle on. Rather than
> open-code this introduce a common implementation to both unmap and
> wait for the page to become idle.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>   fs/dax.c            | 29 +++++++++++++++++++++++++++++
>   fs/ext4/inode.c     | 10 +---------
>   fs/fuse/dax.c       | 29 +++++------------------------
>   fs/xfs/xfs_inode.c  | 23 +++++------------------
>   fs/xfs/xfs_inode.h  |  2 +-
>   include/linux/dax.h |  7 +++++++
>   6 files changed, 48 insertions(+), 52 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index efc1d56..b1ad813 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -845,6 +845,35 @@ int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index)
>   	return ret;
>   }
>   
> +static int wait_page_idle(struct page *page,
> +			void (cb)(struct inode *),
> +			struct inode *inode)
> +{
> +	return ___wait_var_event(page, page_ref_count(page) == 1,
> +				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
> +}
> +
> +/*
> + * Unmaps the inode and waits for any DMA to complete prior to deleting the
> + * DAX mapping entries for the range.
> + */
> +int dax_break_mapping(struct inode *inode, loff_t start, loff_t end,
> +		void (cb)(struct inode *))
> +{
> +	struct page *page;
> +	int error;
> +
> +	do {
> +		page = dax_layout_busy_page_range(inode->i_mapping, start, end);
> +		if (!page)
> +			break;
> +
> +		error = wait_page_idle(page, cb, inode);
> +	} while (error == 0);
> +
> +	return error;
> +}

Hi Alistair!

This needs to be EXPORT'ed. In fact so do two others, but I thought I'd
reply at the exact point that the first fix needs to be inserted, which
is here. And let you sprinkle the remaining two into the right patches.

The overall diff required for me to build the kernel with this series is:

diff --git a/fs/dax.c b/fs/dax.c
index 0169b356b975..35e3c41eb517 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -921,6 +921,7 @@ void dax_delete_mapping_range(struct address_space *mapping,
  	}
  	xas_unlock_irq(&xas);
  }
+EXPORT_SYMBOL_GPL(dax_delete_mapping_range);
  
  static int wait_page_idle(struct page *page,
  			void (cb)(struct inode *),
@@ -961,6 +962,7 @@ int dax_break_mapping(struct inode *inode, loff_t start, loff_t end,
  
  	return error;
  }
+EXPORT_SYMBOL_GPL(dax_break_mapping);
  
  void dax_break_mapping_uninterruptible(struct inode *inode,
  				void (cb)(struct inode *))
@@ -979,6 +981,7 @@ void dax_break_mapping_uninterruptible(struct inode *inode,
  	if (!page)
  		dax_delete_mapping_range(inode->i_mapping, 0, LLONG_MAX);
  }
+EXPORT_SYMBOL_GPL(dax_break_mapping_uninterruptible);
  
  /*
   * Invalidate DAX entry if it is clean.


thanks,
John Hubbard


> +
>   /*
>    * Invalidate DAX entry if it is clean.
>    */
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index cf87c5b..d42c011 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3885,15 +3885,7 @@ int ext4_break_layouts(struct inode *inode)
>   	if (WARN_ON_ONCE(!rwsem_is_locked(&inode->i_mapping->invalidate_lock)))
>   		return -EINVAL;
>   
> -	do {
> -		page = dax_layout_busy_page(inode->i_mapping);
> -		if (!page)
> -			return 0;
> -
> -		error = dax_wait_page_idle(page, ext4_wait_dax_page, inode);
> -	} while (error == 0);
> -
> -	return error;
> +	return dax_break_mapping_inode(inode, ext4_wait_dax_page);
>   }
>   
>   /*
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index af436b5..2493f9c 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -665,38 +665,19 @@ static void fuse_wait_dax_page(struct inode *inode)
>   	filemap_invalidate_lock(inode->i_mapping);
>   }
>   
> -/* Should be called with mapping->invalidate_lock held exclusively */
> -static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
> -				    loff_t start, loff_t end)
> -{
> -	struct page *page;
> -
> -	page = dax_layout_busy_page_range(inode->i_mapping, start, end);
> -	if (!page)
> -		return 0;
> -
> -	*retry = true;
> -	return dax_wait_page_idle(page, fuse_wait_dax_page, inode);
> -}
> -
> -/* dmap_end == 0 leads to unmapping of whole file */
> +/* Should be called with mapping->invalidate_lock held exclusively.
> + * dmap_end == 0 leads to unmapping of whole file.
> + */
>   int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start,
>   				  u64 dmap_end)
>   {
> -	bool	retry;
> -	int	ret;
> -
> -	do {
> -		retry = false;
> -		ret = __fuse_dax_break_layouts(inode, &retry, dmap_start,
> -					       dmap_end);
> -	} while (ret == 0 && retry);
>   	if (!dmap_end) {
>   		dmap_start = 0;
>   		dmap_end = LLONG_MAX;
>   	}
>   
> -	return ret;
> +	return dax_break_mapping(inode, dmap_start, dmap_end,
> +				fuse_wait_dax_page);
>   }
>   
>   ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index eb12123..120597a 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -2704,21 +2704,17 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
>   	struct xfs_inode	*ip2)
>   {
>   	int			error;
> -	bool			retry;
>   	struct page		*page;
>   
>   	if (ip1->i_ino > ip2->i_ino)
>   		swap(ip1, ip2);
>   
>   again:
> -	retry = false;
>   	/* Lock the first inode */
>   	xfs_ilock(ip1, XFS_MMAPLOCK_EXCL);
> -	error = xfs_break_dax_layouts(VFS_I(ip1), &retry);
> -	if (error || retry) {
> +	error = xfs_break_dax_layouts(VFS_I(ip1));
> +	if (error) {
>   		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
> -		if (error == 0 && retry)
> -			goto again;
>   		return error;
>   	}
>   
> @@ -2977,19 +2973,11 @@ xfs_wait_dax_page(
>   
>   int
>   xfs_break_dax_layouts(
> -	struct inode		*inode,
> -	bool			*retry)
> +	struct inode		*inode)
>   {
> -	struct page		*page;
> -
>   	xfs_assert_ilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL);
>   
> -	page = dax_layout_busy_page(inode->i_mapping);
> -	if (!page)
> -		return 0;
> -
> -	*retry = true;
> -	return dax_wait_page_idle(page, xfs_wait_dax_page, inode);
> +	return dax_break_mapping_inode(inode, xfs_wait_dax_page);
>   }
>   
>   int
> @@ -3007,8 +2995,7 @@ xfs_break_layouts(
>   		retry = false;
>   		switch (reason) {
>   		case BREAK_UNMAP:
> -			error = xfs_break_dax_layouts(inode, &retry);
> -			if (error || retry)
> +			if (xfs_break_dax_layouts(inode))
>   				break;
>   			fallthrough;
>   		case BREAK_WRITE:
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index 97ed912..0db27ba 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -564,7 +564,7 @@ xfs_itruncate_extents(
>   	return xfs_itruncate_extents_flags(tpp, ip, whichfork, new_size, 0);
>   }
>   
> -int	xfs_break_dax_layouts(struct inode *inode, bool *retry);
> +int	xfs_break_dax_layouts(struct inode *inode);
>   int	xfs_break_layouts(struct inode *inode, uint *iolock,
>   		enum layout_break_reason reason);
>   
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 773dfc4..7419c88 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -257,6 +257,13 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
>   int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
>   int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>   				      pgoff_t index);
> +int __must_check dax_break_mapping(struct inode *inode, loff_t start,
> +				loff_t end, void (cb)(struct inode *));
> +static inline int __must_check dax_break_mapping_inode(struct inode *inode,
> +						void (cb)(struct inode *))
> +{
> +	return dax_break_mapping(inode, 0, LLONG_MAX, cb);
> +}
>   int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>   				  struct inode *dest, loff_t destoff,
>   				  loff_t len, bool *is_same,



