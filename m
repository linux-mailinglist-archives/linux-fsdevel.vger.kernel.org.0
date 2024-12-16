Return-Path: <linux-fsdevel+bounces-37564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFDC9F3D6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 23:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A31B16A29E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 22:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A07F1D63D0;
	Mon, 16 Dec 2024 22:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JVlrNm2L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF48A1D618E;
	Mon, 16 Dec 2024 22:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734387960; cv=fail; b=UsY1er3uAy4bonrEpkOwZdOSXi9d5MZWr+esSixMcYir3ySOnt8wi83HZL64odLHtzCf42vSaBba3WiWeqa79X6lvIRGwyY7sKodhBK0PxrNQ+kgCTvWZnEk/lnMihKeNB/Sbkt/hHtN4GyiUxQzF/InFrmD4Io/mt9+iizmX7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734387960; c=relaxed/simple;
	bh=rPlnGDQZgGpvmkTex3U/UGT/virSJj9UnhmSzv6n5p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q1761E5Lr/y3XWqAanEZqpADeoo2JGJq2ORkjAT47xf5YIae7LVLP4D7UEtkG0EsFgQ1A1GpiiPyamqEPBdkSsiJBVTqW3kBH28laB0K9Mck4qt7Pj+xWrMfhPo1H8A5cxUMs5Ma60dDTOO6t4/0dpUq+e97caHfWJ2ox+QjZIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JVlrNm2L; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbj8WlvJLcFePR9p7wdFNx9xl2Q/dvqFPB2oIsRqKccWntvlxFFoQdZWxNeH01Edk9CPYSP/WfBBK2WOZ8teRNq2sNbO16QnHkwX1eyop8diVplCSf7YkRlvVk0MHq58mYAaNJcOa/fri7RgnwBMXfhNx7jWIOVFitVcKvyAIAVxxoAbv5hpdDJmFs/3KCW+1QxYA99tQ6QrAr3yKzcDvEZ1NelxwdbonpMtkRyhihrOKqWsEu69819oAORQ/e+KLIY9O5KZ+8Gd4Lll39znizdyAWPIjRGtRkAijFfAaCKywUQIXXLMKA5HXNXE/gVJ30o2bwc1+DvSCGQNtOmvRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqRGHL+/CZ9ul6m9fa4uXoLIlClOUBWGCbvLUpMs960=;
 b=vVlckW8ZUIXdk3tIyMYKwmHt/H/HEAJR0QG4fbBsJp0EBvJ5eBRBBMoJUGPNWbJV+h1Zf9WH7aWsl+KM5Xr0bHxrdYL7VDf+++No7CD1CG7ByRq/BqwioU8HEWfdyv4On4vlzOjA0PyTGWMCmJe9s9H9o21eVTPryrnWFxHXpTe12LdyWyqdALYWu4J3spPaYzSsq0GBrXz+oMHtU+mFWrbNq72l7eM6ImplnqUihkaFVZrMiUglBpx/0oC950FhsMRVk0YN6ak+XE2WDjcecf/FN4mH9kqMbvANu27cT6PBOLKHgQxfsn2M5KBRWZz1uYpvpKeKP+BX7DZqxvM6/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqRGHL+/CZ9ul6m9fa4uXoLIlClOUBWGCbvLUpMs960=;
 b=JVlrNm2LwOyf8GT0Bc6eda/ryKSzq/boMmohgaoxdf4IaKvlErfe4ET/d+QgnmOWxxkFtmjV95SwR7S/3iRzEueWbOCUDuwyWAzsKElwdoztI7h8nhkVY4uoCMba95eeJKfaCZBw64zMYMhGbnl9xrGXDomtGoTmc89UQqiczcd8RNduuK0ET0INOG6zyJ/kprnruu7rUFCQ97EGCm4524lE8OS6g4Tx95STguCAaPI940GErq0pcsEgO+H9DrKZOJaLqX8ydyAkR2V519VyEF7XBokFwotDKcSZWslTZvaZJcq5au6Wwz28YnvzBp5jvwRKuUWwPblUI+qlVCUxrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA1PR12MB8143.namprd12.prod.outlook.com (2603:10b6:806:333::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 22:25:55 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 22:25:55 +0000
Date: Tue, 17 Dec 2024 09:25:49 +1100
From: Alistair Popple <apopple@nvidia.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] dax: Use folios more widely within DAX
Message-ID: <oepbp7g4qhbovnoquftr4hrddqylfvuxpo5elu2l6wmofiyvuy@ukzkii7dvdie>
References: <20241216155408.8102-1-willy@infradead.org>
 <20241216155408.8102-2-willy@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216155408.8102-2-willy@infradead.org>
X-ClientProxiedBy: SYBPR01CA0154.ausprd01.prod.outlook.com
 (2603:10c6:10:d::22) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA1PR12MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2aaa73-79dd-4a0c-e93c-08dd1e209b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nJZZBRNwtpTSV+Qg7sY/q9sOysfwJuU6WpP0fgMPcOr9eAyVT0nYsHWOdLP+?=
 =?us-ascii?Q?KB3yklv03JtS78SRA8zyrZsOerIOt8NcIT2Kht/F3rvxAn0jpEthF9TyT4jv?=
 =?us-ascii?Q?9WnCBRQtOUL8Bj9mw7GidXiS7rNfFwUzZhvGtKMIXGFr45PI5Ja34hq4HJx5?=
 =?us-ascii?Q?l8myC1C/2EGYw9XyWAooDOxpgX7CAreifH59fyqfysJumiAVd6i+5stLvhfZ?=
 =?us-ascii?Q?etUXJr5VJP0UlXUHTHkflKAaFvtuNQCBQ2F3bIGEuUmltlWSC0BpNoIRzN++?=
 =?us-ascii?Q?u5Z/9LsrEOB25evVjbvRqQWX6y/vhfc/+FsGB7q+8xv69zMN6GSzhvpbAZcv?=
 =?us-ascii?Q?ZcTKW/siDtxGtCL5OJkMHRvuJOMWD5H1eM5qufFNSj76nN2+R/3ZxaYN5N2C?=
 =?us-ascii?Q?YqUACTH4KrmmkLSosT/y7dbk2dBHiwzFAAMgHmfABomM+PYjXjiC8KRwUpdD?=
 =?us-ascii?Q?XeBEcTYlLWiWQCOI6/yvvUASnRPIfCszJkp3gdTo5wmDGXKyYS4rfEliQ4Hz?=
 =?us-ascii?Q?yplAMC7aNja3gBU+Izl8KVwno1SythxRKIqvSVnbnqTdMWAKqZzNoCERQdFG?=
 =?us-ascii?Q?x8Jku4z8xlNqD1pcXSyZQ2U3zbF4bn0Jgd0Gk3TtoPa7cu1JEQ2wKYdKSeqL?=
 =?us-ascii?Q?LzjCs11B6Ww0vkDsTOv/zANaz+NHPJftXObvUM/A7KKXHLLC4QNeWSQ5MSxV?=
 =?us-ascii?Q?VzpmuNf9Y66fd6G7rZF78gMiXi42nhgaLrKuMRftN/udT3yVuEN1GtpFPSBA?=
 =?us-ascii?Q?AyJGLf6TeDRsE6rM5a4B6WQM4462qx+v4w0u6CFuG3QrDjnCBd2HY5lzoysX?=
 =?us-ascii?Q?HadBf/v/PcNchdcgDResjhTq5Qn/5QFrdcqouAkgDaTr621Q6IoDmmQInCA8?=
 =?us-ascii?Q?hKDGJ7hJlQsPIvQ2ukZT6IwNMqJkTAVZgjG/B8+vLgLkRytqVSwZCTK86mFr?=
 =?us-ascii?Q?tJ23Ii1td+AIn3ZlqfyiXP9oasSTtPR39Np/No079x8iyBIqG60sCG1CgHK4?=
 =?us-ascii?Q?A6k7Ka5qfN+QktP0z6y/Q+sat/8BB1eOXAxoL+eYKt5ifsfeK7RVKrjIxmej?=
 =?us-ascii?Q?pySjaVKdvct77+pOwdUoI+H7nopV6123rQTsCfnWB13F5K3vqbSEnfDNJ50g?=
 =?us-ascii?Q?AJjKAQFuZOO5Ei8smyXYXilNKpORgAdkdrlpdFP4j69avsVHUj5UTHWl4+T3?=
 =?us-ascii?Q?PWFR/6G0B2DtaoB7rkJJ/5qyKeF5S9fMDbueChqIbJ9AQEHQG1el3RUjD5AR?=
 =?us-ascii?Q?nch4IZ5oMQppDNpQhCPmVOBSIOQBO9oD9NBwvYUiM6UQGtLQLfOHUqPworaI?=
 =?us-ascii?Q?eWhHkVWn1L7CsJRU/PGD24HoWWwVfcfwhVsaywZp2LDdU8yhNy8gkhBPAmBV?=
 =?us-ascii?Q?hBCWImb7FudRoSc1pw/owoAxVd58?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+nKoz6rJiEbDOa+Ird9SQgxTTtsgiLJNT2n3GRobwSEeHwBVAx3qFvWvipu3?=
 =?us-ascii?Q?fNCf74gC4jQPPUKHPXhK2I+O6zE6CmVMOgNDO0D5a3P3rlrUlxr8cIrJdn53?=
 =?us-ascii?Q?zPs4+RAjrOzI/vJcaPmOGlnnvS7tyfuPJaJRdW3utMEwLq2LGbptKa4HV4rJ?=
 =?us-ascii?Q?tMpRE/iiehLoBg5KOrKkJRCociqXN5JXXkmGJya7KykKlihy6LZm9jAllzPS?=
 =?us-ascii?Q?EkBaLOHmdWaf4QM0CbZtnw2W0QAGZoiv8j/bhXsku0L9TJ3dYqWuEGkewOCA?=
 =?us-ascii?Q?TfAa0GbLf0qVl/nk8J1URfmhnD9PcgxKqj+VmyUVVbpz8hmMYl/VIzBihxTN?=
 =?us-ascii?Q?FNaD+y0KXBNid4gh/4yZX/9E/xRsynycWpgEzIY+ayKn4zrl02yEolNqS5Dx?=
 =?us-ascii?Q?gwyq9TxvKKDETcvK7+GfAA9PxaO1kN8A+X4OCyMFmOqTjXy4wahm57++AAew?=
 =?us-ascii?Q?7Z8biHJu7HTMTrpltGZX179AtcJPZPipr25aVpd9kd2GpQwJY6ZEFo2LEefs?=
 =?us-ascii?Q?w673o36xlqWtRQj//dB378qUhLUoknsb4l6o9qZu1H68MAotr+x7/SGgWioV?=
 =?us-ascii?Q?EKvhC3h3ub968Df/9CXWmc1LYsGJpgOSG7qCxg+iZ2NnvNcjrlfe/xZa6bkH?=
 =?us-ascii?Q?scO4RxgAYK2kf/tmChHjYhD8sF7gB5XVU5DifE509nRtWJ3o+ftpcMRYgpk/?=
 =?us-ascii?Q?YqQ55QsIMcxstbhOFpoRO2rxPN4KcDbl3IZwQRvDO+CDbQ3TMx4yekfOyqMu?=
 =?us-ascii?Q?11c8cL2kSpI340gareXnxFjckNVIyfAactFIfEyReGs1mTFtUbW+tj8CgsPA?=
 =?us-ascii?Q?xbsbdKMF/JR3KvQMbZwOH1FW6D/yq0WLCrRsscfyigRGo1tnTtpYRzOIbqBv?=
 =?us-ascii?Q?3P/yteCcyv93fmuKXgsES7GARsdPQiU2HE06XqvapgQINo8iFZzQZtVGDPb+?=
 =?us-ascii?Q?NzERVC/7+3IBNJrRs7XMRxy2iia+MRv3VSh7dRRdSbRzgrS1XTI6RToczCRO?=
 =?us-ascii?Q?QppPzzwI1TDPP3H3gqx6hsJCUKd2RYqDqqVIElxJJ1kmCCkzWQtnZxMv5fVA?=
 =?us-ascii?Q?rZusIMq1ZrPlnKl6UGxm8iFd5cRxnjG0AtPy87z4GnezBCHHAuNn8zG19at9?=
 =?us-ascii?Q?8z7MynTroI85NZ2HUGqJIpJR/eWVr5PyQFHqVJNe9PFwM9MQPK/OPrx+MqB7?=
 =?us-ascii?Q?Pz2KIKpyTT9VzKVX0HhYDv34BSZja9AiRWmMQYVVSbxqeFfExKdmNcUNA6b3?=
 =?us-ascii?Q?pGJmu1atCfq+KnwXkO8w9jjxTnDnHdyrRbA3YZptdac0DNT8WdCMT9iZ/gYT?=
 =?us-ascii?Q?sTKvaFTl9ivvEzsW4VgTJUjInlO9lfFaousrixLFRJ1v6EWKYnquzBMIqrA5?=
 =?us-ascii?Q?S+XTaBbefrgCDXNOK4sWmUm0mFtwaUzYWnRl3taOqHmcgM4HQ2PGTok3ypSQ?=
 =?us-ascii?Q?2Ve0MY6RtELx2HZvi6tnIJd1bI9gA2Cknp91cSE+bdT4nE66B0vCw88u2wgt?=
 =?us-ascii?Q?MOfttY27aOcLAG2piEMT7TXNunMyxOUjw+Rmcq0cqxz7+B179brMr5H6kt19?=
 =?us-ascii?Q?ZcAu7zCiu5nRxdG00GX6yXP93LqU+ej67qOlE3sd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2aaa73-79dd-4a0c-e93c-08dd1e209b79
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 22:25:55.5832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNIAAR1tZt9F27F5LBHwONtzhLe8DL/YBZWMR6eSDgFhuyYSpBYrkiQNIa6nGo1dDipqyWF2FnwvkNQol8AsTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8143

On Mon, Dec 16, 2024 at 03:53:56PM +0000, Matthew Wilcox (Oracle) wrote:
> Convert from pfn to folio instead of page and use those folios
> throughout to avoid accesses to page->index and page->mapping.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/dax.c | 53 +++++++++++++++++++++++++++--------------------------
>  1 file changed, 27 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 21b47402b3dc..972febc6fb9d 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -320,38 +320,39 @@ static unsigned long dax_end_pfn(void *entry)
>  	for (pfn = dax_to_pfn(entry); \
>  			pfn < dax_end_pfn(entry); pfn++)
>  
> -static inline bool dax_page_is_shared(struct page *page)
> +static inline bool dax_folio_is_shared(struct folio *folio)
>  {
> -	return page->mapping == PAGE_MAPPING_DAX_SHARED;
> +	return folio->mapping == PAGE_MAPPING_DAX_SHARED;

This will conflict with my series which introduces compound ZONE_DEVICE
pages to free up a PTE bit and allow FS DAX pages to be refcounted
normally. The main change is here -
https://lore.kernel.org/ linux-mm/39a896451e59b735f205e34da5510ead5e4cd47d.1732239628.git-series.apopple@nvidia.com/

I'm hoping we can get that in linux-next "soon".

>  }
>  
>  /*
> - * Set the page->mapping with PAGE_MAPPING_DAX_SHARED flag, increase the
> + * Set the folio->mapping with PAGE_MAPPING_DAX_SHARED flag, increase the
>   * refcount.
>   */
> -static inline void dax_page_share_get(struct page *page)
> +static inline void dax_folio_share_get(struct folio *folio)
>  {
> -	if (page->mapping != PAGE_MAPPING_DAX_SHARED) {
> +	if (folio->mapping != PAGE_MAPPING_DAX_SHARED) {
>  		/*
>  		 * Reset the index if the page was already mapped
>  		 * regularly before.
>  		 */
> -		if (page->mapping)
> -			page->share = 1;
> -		page->mapping = PAGE_MAPPING_DAX_SHARED;
> +		if (folio->mapping)
> +			folio->page.share = 1;

It also moves the share accounting to the folio as well so we could remove the
whole page->index/share union once that's merged.

> +		folio->mapping = PAGE_MAPPING_DAX_SHARED;
>  	}
> -	page->share++;
> +	folio->page.share++;
>  }
>  
> -static inline unsigned long dax_page_share_put(struct page *page)
> +static inline unsigned long dax_folio_share_put(struct folio *folio)
>  {
> -	return --page->share;
> +	return --folio->page.share;
>  }
>  
>  /*
> - * When it is called in dax_insert_entry(), the shared flag will indicate that
> - * whether this entry is shared by multiple files.  If so, set the page->mapping
> - * PAGE_MAPPING_DAX_SHARED, and use page->share as refcount.
> + * When it is called in dax_insert_entry(), the shared flag will indicate
> + * that whether this entry is shared by multiple files.  If so, set
> + * the folio->mapping PAGE_MAPPING_DAX_SHARED, and use page->share
> + * as refcount.
>   */
>  static void dax_associate_entry(void *entry, struct address_space *mapping,
>  		struct vm_area_struct *vma, unsigned long address, bool shared)
> @@ -364,14 +365,14 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
>  
>  	index = linear_page_index(vma, address & ~(size - 1));
>  	for_each_mapped_pfn(entry, pfn) {
> -		struct page *page = pfn_to_page(pfn);
> +		struct folio *folio = pfn_folio(pfn);
>  
>  		if (shared) {
> -			dax_page_share_get(page);
> +			dax_folio_share_get(folio);
>  		} else {
> -			WARN_ON_ONCE(page->mapping);
> -			page->mapping = mapping;
> -			page->index = index + i++;
> +			WARN_ON_ONCE(folio->mapping);
> +			folio->mapping = mapping;
> +			folio->index = index + i++;
>  		}
>  	}
>  }
> @@ -385,17 +386,17 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
>  		return;
>  
>  	for_each_mapped_pfn(entry, pfn) {
> -		struct page *page = pfn_to_page(pfn);
> +		struct folio *folio = pfn_folio(pfn);
>  
> -		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
> -		if (dax_page_is_shared(page)) {
> +		WARN_ON_ONCE(trunc && folio_ref_count(folio) > 1);
> +		if (dax_folio_is_shared(folio)) {
>  			/* keep the shared flag if this page is still shared */
> -			if (dax_page_share_put(page) > 0)
> +			if (dax_folio_share_put(folio) > 0)
>  				continue;
>  		} else
> -			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
> -		page->mapping = NULL;
> -		page->index = 0;
> +			WARN_ON_ONCE(folio->mapping && folio->mapping != mapping);
> +		folio->mapping = NULL;
> +		folio->index = 0;
>  	}
>  }
>  
> -- 
> 2.45.2
> 
> 

