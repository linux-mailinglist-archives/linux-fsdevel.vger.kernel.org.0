Return-Path: <linux-fsdevel+bounces-41818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 710CCA37A91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 05:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32E1816E602
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 04:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AF61865EB;
	Mon, 17 Feb 2025 04:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FHGXbXyO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3730481E;
	Mon, 17 Feb 2025 04:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739766591; cv=fail; b=rl3mseVobnDZeV7BcRf48+SZN6tOSzDrdxnJkuWtCp4Nw1Y3Yn11hUq1sWUhZ564HkQhdONQNbMlCV90yXMvlVnXRMREUxgzx/rraXujhtGop1HXpqJYNCYN6nkZveoHF7cNwwT22YlranG/7um7MzACiXoAeoOZJ47TUZG3wA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739766591; c=relaxed/simple;
	bh=v5rT378BCqwqJG1S8vtEvKwt6tp3NY6DP0vl+NV3p6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qpF/QSMW6f1BCphnrladyIwxIF2R1IKbor9nxVm4F7bRxwetjJgJulPf7NqCsxZKELK5tNSMDdiS+SiqH6sM6b+HCMNRZ0aWCs54sYTXYgk+/WaKaFojYA6Pcyhbd1pFj1oXjV2s55uCoOeA9Sog6KAL1fbPV/S2qRVVoIBQGnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FHGXbXyO; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJ4M64q4wgq0t1blhS9iqj1byoVzf0LS0O2j51HC9nsaGKGbZiWd7lqpCTfvY6xK5YkYuamfsI6OZeCucztYDlTHn1oKkbKmX8kSI0N6ZS1y14ibHDqpSnjvpB6CmDRzmyFO3UCO/cmV5LhkaBtvA/Wxrj9mgGTKlxmZ7hUAr9dMgoZBQk21VgjJZnWK1Znj0iqR2aBzkBPcBo7Bkm3KcfO0Q8GUxMrbNQwbr/31sCAPhX1wVYi8LDDannnaSBYg2JN763I5IWYvL9fuEyiXouP0YslYz3HmOGTzlqHIipU585ZQLip7sjVeJ6u4UHUVTPzrpxoXxzFvRdyus+gy1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGOimbpfus8MFEfxmpQbaLXermq2/GxsTg/Y4HxAweg=;
 b=P92kl42WnCYB1LP5Fk/5BTZdYrPjXQsXn9BlMpOXxzVFYH6frqxS6bkv6EuSASerg7nIfNr75+/pVPEFgCYSn6Ne7lp7aGMn5BO8ALoFIkuOGX0AOlbOFjgijljMh0LTHfQj4cxi/KJ7O1yssx6z8/Wt0LOEakzmc1cywuVlYLntWeEpYa0UVuAVLGGsYYFeqjCvP/jh5ccZ6O3PumcTRZ8Q5MagTWmRF2eZezY7wwvtRcAgDQKddNkB9iGIqDxkLgcipV0wzXkVDp52PB502L6zYEPEc4eCfl5+SIgnXDeX/pzf7xmq4mqCFVFLPXhoaiUMdgitDo69maUGuELfWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGOimbpfus8MFEfxmpQbaLXermq2/GxsTg/Y4HxAweg=;
 b=FHGXbXyOgMPq8FVRrgX1BDrf5xid9RarP3nlBky2+L0b1KLDZYeCOLQpBZvgY5/AWcl3d7pY99HiyP1vg+8jdUJ3CTGKhBsp4nI2uU2QmriWXVHnJrVCvBN+bLTefEolgsbpsQHKWLCHc/qPMk05GCtTj/xIRgCCaEVlmJhqDX7J52VCYruhHvPJg+SzIaB9QzBDnWiWaZO/4KnxTfCa+PCIIqF220YMnjkivw4XJOXcuaV7kaejO5frcgg453Ebk3IGsgXmJTUmBNAm33xmzq5R3JAj8C6TldJwT406l8jaiC+VZeIyQZ9nKP2YBA2qk3Gv4jozgn3WKPzPFvGlaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.18; Mon, 17 Feb 2025 04:29:47 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 04:29:47 +0000
Date: Mon, 17 Feb 2025 15:29:40 +1100
From: Alistair Popple <apopple@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, 
	linux-mm@kvack.org, Alison Schofield <alison.schofield@intel.com>, 
	lina@asahilina.net, zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com, 
	vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com, 
	jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org, 
	mpe@ellerman.id.au, npiggin@gmail.com, dave.hansen@linux.intel.com, 
	ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org, tytso@mit.edu, 
	linmiaohe@huawei.com, peterx@redhat.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com, chenhuacai@kernel.org, 
	kernel@xen0n.name, loongarch@lists.linux.dev
Subject: Re: [PATCH v7 16/20] huge_memory: Add vmf_insert_folio_pmd()
Message-ID: <6mmjoe27y63cfe5cycqje63gehgumod3bp7zzgvpz7qehgfuv4@uomvqgizba2m>
References: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
 <9f10e88441f3cb26eff6be0c9ef5997844c8c24e.1738709036.git-series.apopple@nvidia.com>
 <afff4368-9401-4943-b802-1b15bdcf5aaa@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afff4368-9401-4943-b802-1b15bdcf5aaa@redhat.com>
X-ClientProxiedBy: SY6PR01CA0052.ausprd01.prod.outlook.com
 (2603:10c6:10:e9::21) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: b215f871-bd3f-4bba-65d2-08dd4f0bb584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6S7xwEV7PjkMlL4FYRDxK/YJYaVjHnvsqv2EFJ1iRof2wO9++oT/sZjvsNiy?=
 =?us-ascii?Q?2QopW/hZUwlVfCOnYaU7pffoXwt15VpsKvsQfjzaiO7XQGp5V7xuV10fGwws?=
 =?us-ascii?Q?zsHFHliiA6qzEJFHub9zwbUeov4USAQ5ddJZONIf5NFNVpFEiBNCusJJCMt1?=
 =?us-ascii?Q?Hmej/SDQyahtdIr6HEymn6h1LXNGtYHGK+PBujTnCqIN/WjmW3q/4ahLRohX?=
 =?us-ascii?Q?GTLS7heZh+c5qdNt806T9sJrGb/4pQQy1ihk4eWzsspJ40JT99HY5kfXXSJ4?=
 =?us-ascii?Q?KSSXmae33XMRheOfj3o+UUUM64H8Ii9Xar/o4cuCpgyPzKBapLrVE3FM6UsN?=
 =?us-ascii?Q?ewrynx0g8EWlrV9sj0mstOSEYXtDu3+Mk6Opj4QZEafOTkqXmJDaM8HuCyGI?=
 =?us-ascii?Q?1L0DTChuOtpr2XC38ySvH/2r9IFOXdc9/TLJ3R2x9YPZzi2MuE+eilOxXsyB?=
 =?us-ascii?Q?+LreZSWL5ZW/ixk1XWqzd2jf5RIhfvexWrSp5UpZKoCFvk/hSOcLBANke6o7?=
 =?us-ascii?Q?gFXBsa+Qp/tK9zMehaNsRPR+FHWfAta7NAhvg76KtM+Q/cWrMkLnzipJQrOF?=
 =?us-ascii?Q?bWGOdVOZ4VKHbLDB1wMplYsIN0lviDPhyCeVKYTdzp1SUHOc37tSdpooFepZ?=
 =?us-ascii?Q?nL/n4bLALvWVjB5UYmWBvs3ramVtqTelletxBiGcu6gAzI6cWdQELJRBA0ZO?=
 =?us-ascii?Q?O5x+r0GZlmZsTyUT5tghWhDZ9zwkg4rqW7JTipNyJQkiSRLWsAovtpP0TKuB?=
 =?us-ascii?Q?4Xb0yU4mOWkREA+W9+mtp0a1cuCNICQiEYab9JHprLJRnY0x3g/vV9gf5/Uu?=
 =?us-ascii?Q?/phqYD4MZ9foii8zRsR0Yh+/RKQLY+BuCDNZoUV6OMT9ThDU5POVQDhoh+yq?=
 =?us-ascii?Q?3hbumzkQkcRXNeeTXd38GUeZNtOGFVIJWrW0Zl98M7FK+3bIZN5YakZ3gXpD?=
 =?us-ascii?Q?4SPV9cGnyCAtoA7Cag3oYiM8JVjFH0IZ7gOP7KoZ6h/Q81KToqXa7Nopyp14?=
 =?us-ascii?Q?YoeRqQmuuVjiUF+CnITDXcuVxj+pnvu/N3AO6GNAiTPM7U9P52FSj+tgzjqt?=
 =?us-ascii?Q?S/r5vxsSl/FEhXFStyeWTY3w7GPERjaYg9wWiDuMag8VvjLXVznzX8m/VFdr?=
 =?us-ascii?Q?KZw/fyakJ1mUQLwPJ0WoCj1UxbEE3nbj5KWC6yKtOhg+tYpasYCEXL+yMUjY?=
 =?us-ascii?Q?nvC6h63aWthJWHlQWqyCU/7Z2zpYYZJofUuywYU+yThkBl5ber26t8+cKhOO?=
 =?us-ascii?Q?+Qsq7gd49yK0+cOXHhs3g76EJgdhMFN1wsDmsSpKy3DLPGZGVojJ8J/VFS5u?=
 =?us-ascii?Q?wZi6fHUtLy4JO0d+LXp9FhjVws9T6IUc0R/dCq5yJL7rPmFG/cj47Mo+O7sX?=
 =?us-ascii?Q?ZxlBSawikZaogzpz64TAIIO2D+f0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LefaUx789c/ZCYo5Ei5asWFeWZMdh6zlBMJCfAt/3vhRFA/qjAoQSiKZOqab?=
 =?us-ascii?Q?JwGy66u822HaLuCKzEvb+vwwiluCFVw6pKO1fSw9nggLu0xu3yPWSis6EvFm?=
 =?us-ascii?Q?vLCSJNrp6qW4Uxcn8OwnyFiYEOo0KmAAiFfKrULcjp7iEbZa4pj+vEVcSy1u?=
 =?us-ascii?Q?TheCSjk+H/kSHlV36NZbAlSyg8nKIKMO+XsH/RadICp9wNWLDsHwEiJl8h7l?=
 =?us-ascii?Q?v8MJKpXegjAVUx/YtDJWYMr0ss/RPq05vP+VsLyjZojdJg9gO+a68YOjplr+?=
 =?us-ascii?Q?Gsmjdo1wn/XfZ27ys82Eh2etVWnZLB+pW0kVeTJma74aFLIlqqKQjnFRXwf6?=
 =?us-ascii?Q?I4muHCgYjmYC1hBrVfGjqrrtNQGSybziRvbuoQbgMXqMnxWnYC8P58+hrA8+?=
 =?us-ascii?Q?c6zRKtd+iodwu8pDryM4yfA//3IqJe/X/wL9wops1IDgkzDxpRgtftekVFty?=
 =?us-ascii?Q?JpoBzPQnTF6sLpdKuPw0tFnomUtID6Xv3tbYf+aB1b9n7c9CTbO/+kzj9BAq?=
 =?us-ascii?Q?wnVbM/Mls1FAnF5hf8Is7Jg4LPyOA4sNm1O9YdNnnd+ggxRSuFDc0PlY6IOR?=
 =?us-ascii?Q?XW3Hma0naa12LqOn4Ww1ymEgKn+MKzThgQyvStU111cPTuO4LgXmz1i0INWY?=
 =?us-ascii?Q?WIltHRKGlolVZVvt7rnPx0SoQiR/WqgYWJaRTBbm9VLRpI2NWpM2sO0IVIYS?=
 =?us-ascii?Q?YjqeLbb7t9h3exIM7qeGXdkXQldydueO+BfocjzzIB383Bk6aiYJHBqrvMd8?=
 =?us-ascii?Q?hnIkYg0sK9D5jD9REtXex0uB65wRb2WZc8KQQXvP2WGInMkPx45zG2H+OSAt?=
 =?us-ascii?Q?smpHQKQkDa2SdWHSec8HUhe396UIgrR6qaGLqYspWpQlMKTqdaCDjC2BEbNP?=
 =?us-ascii?Q?NaLWWw4sdOjrDjtTfK+8bOuC+/F5ENNzTR5p3BAot5+1KkqlCFrQFpp2DTlj?=
 =?us-ascii?Q?X5Iq8SINOA1/TtM1zq0DplFNYvj95wXG8e4Z8rup1NWq+s678++wCPTAZapE?=
 =?us-ascii?Q?UHc5rVAyjgurYJaOPIq05Dj6HqVevLiIEzeX+jH++zZeTzuwyhV1C//iLItG?=
 =?us-ascii?Q?PATExwLPMXSreMVB5qMrE8IQJWJ4W0gJlhhwMP7IgmJLQUcWXjvB1HGwkkfP?=
 =?us-ascii?Q?di59Ec1yrfEOsJ+jDtkeXAsaj0GDB1CYc69fYLblbz4S/9boClvaDVAj8RFb?=
 =?us-ascii?Q?AEae/TP9p0YAvoN5Pn2x2r+NvlRhjZ0NgUig7sJ2pT6nwUYHprcxk276akPX?=
 =?us-ascii?Q?miaVYx2JvMtYuE/t/Y9WcBRKGbegchmCjMqm78AVDPsw8ZBNIOfuXrVZah3t?=
 =?us-ascii?Q?o0+2UKFC6Wd/968jqoUMnTiz8UgdQ7q1AvhZkPYQgtUEQM2I1lMwnQvajgcZ?=
 =?us-ascii?Q?0CZte7yEnoTHPIq5/sr6px5uaqw8gH5m9Wk2p/Gl2Quvq5U0h25RoGY4a6ep?=
 =?us-ascii?Q?zPH3QigZiB4H+lHIqGl2RlhY856LUhFNFq7oYmjtqNbXQtjnvEP7fPb2F6vS?=
 =?us-ascii?Q?IghV2dXl8Ga+Hz5PrlpMIFTrRZjuEB4rt1mxGggkE5gimtfHKPZZ1AOeQkhA?=
 =?us-ascii?Q?KtjBF7ResGA55oasOJKBAjQDEkWmHorWcm6eLxXt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b215f871-bd3f-4bba-65d2-08dd4f0bb584
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 04:29:46.8465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHEouTfMeWI8qlCfgisPUQAP13ny3hcHQu7+Q6+8UpuCZ4IxXBKsJzyMSFXszBrdx3kJMhSr139Pac60/WfxJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629

On Mon, Feb 10, 2025 at 07:45:09PM +0100, David Hildenbrand wrote:
> On 04.02.25 23:48, Alistair Popple wrote:
> > Currently DAX folio/page reference counts are managed differently to normal
> > pages. To allow these to be managed the same as normal pages introduce
> > vmf_insert_folio_pmd. This will map the entire PMD-sized folio and take
> > references as it would for a normally mapped page.
> > 
> > This is distinct from the current mechanism, vmf_insert_pfn_pmd, which
> > simply inserts a special devmap PMD entry into the page table without
> > holding a reference to the page for the mapping.
> > 
> > It is not currently useful to implement a more generic vmf_insert_folio()
> > which selects the correct behaviour based on folio_order(). This is because
> > PTE faults require only a subpage of the folio to be PTE mapped rather than
> > the entire folio. It would be possible to add this context somewhere but
> > callers already need to handle PTE faults and PMD faults separately so a
> > more generic function is not useful.
> > 
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> Nit: patch subject ;)
> 
> > 
> > ---
> > 
> > Changes for v7:
> > 
> >   - Fix bad pgtable handling for PPC64 (Thanks Dan and Dave)
> 
> Is it? ;) insert_pfn_pmd() still doesn't consume a "pgtable_t *"
> 
> But maybe I am missing something ...

At a high-level all I'm trying to do (perhaps badly) is pull the ptl locking one
level up the callstack.

As far as I can tell the pgtable is consumed here:

static int insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
		pmd_t *pmd, pfn_t pfn, pgprot_t prot, bool write,
		pgtable_t pgtable)

[...]

	if (pgtable) {
		pgtable_trans_huge_deposit(mm, pmd, pgtable);
		mm_inc_nr_ptes(mm);
		pgtable = NULL;
	}

[...]

	return 0;

Now I can see I failed to clean up the useless pgtable = NULL asignment, which
is confusing because I'm not trying to look at pgtable in the caller (ie.
vmf_insert_pfn_pmd()/vmf_insert_folio_pmd()) to determine if it needs freeing.
So I will remove this assignment.

Instead callers just look at the return code from insert_pfn_pmd() - if there
was an error pgtable_trans_huge_deposit(pgtable) wasn't called and if the caller
passed a pgtable it should be freed. Otherwise if insert_pfn_pmd() succeeded
then callers can assume the pgtable was consumed by pgtable_trans_huge_deposit()
and therefore should not be freed.

Hopefully that all makes sense, but maybe I've missed something obvious too...

 - Alistair

> -- 
> Cheers,
> 
> David / dhildenb
> 

