Return-Path: <linux-fsdevel+bounces-42551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B74BA43528
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 07:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAA45189EE3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 06:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408A625A2A4;
	Tue, 25 Feb 2025 06:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YGSkuknc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECF5256C9F;
	Tue, 25 Feb 2025 06:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740464624; cv=fail; b=eMjEPcFiVSFUvDUCzWVs8zW3B2Mdh6TIj9eN5H2GhP4c994DvPM9JfWCDCx9VhjK0TtniJMk+rQA5PHmvQo/RybsHLlI97UPWlsBv8Etq2S1Fyk3eLtJDdMDsZowrNIsZILi+GbuVaQfqckMmX4dXLvaP5rTowxGlszgeg4CnKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740464624; c=relaxed/simple;
	bh=y4TsAWAMgfQO+snjM0LpSbZuIZoIfgvONZY0qHsuXMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DziLIBHtXHjq1LpFrU+aI7WhwvCM9D++usXaTbJOrbQAKPce8/32JpVKGRUc62iWsKu/hP3NZVWPrOXFfvfBo1/i8URCSMOaZMhFAWzoDYdZOEHysFfSLZEM4sE/4hsWmpIOST3Q2YqvQRgCeyy1csB9YyvgLj/dLK7NP6GD4VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YGSkuknc; arc=fail smtp.client-ip=40.107.96.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1yLYXOtg5B4M6A1Lp5qqMIZkEZxe6utMO3hX7MI9rQw4d14hekNyjcNRr/Rz/qSx5biWJEJpHv8/lY4k6qGpG4aeJFY7hczDb4b2dUrzukjeSBzT7yfquTB1W9C5RetR8BWkK3MQsldyLvmq5fferYIlasGIrwGFFlC6PyK3Km3TWD+zGcINfG/pJKwDqLmgYFhf2NCAk2VgXhGg9uBleLQ7kfOdFpMReiaIqAxPqr66jQyhs4LqLqsWWfr2e4ZI2pzyGarVVTm+K09kosH5c6YRWYy7+VRANslAedCkFIe19TC5py9YnSn2NHsQDAlA1dTtsZZ373ryCr6hEnkpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAQDT6oY5OcgdSN1C7jHGCMlq8FGau1ZD6szWSbL8XY=;
 b=WpynXwWUEz9McvmL48J+3VPSvVuRmZ8VRMPLzfGOEtj8n5q9YxCAJ7vueOtyD2y/RLS/lXrAiSRE5VaCsnIgIsGtdsTOQka/MZHFP6SPKaNbzOBtxmqR5pLHiDM6oye8rUc4bxu2RymMVkRQq3978+a4iyAUv3KoSzbYwA6oBM98/NGQM+yoGxi1l3yPT/4W8iQCTwtEB2ck3ZL4YGPYKjNzRJq78zOIq1pTscBuRcswsXXjyhOwtXnHHzC0BfWRgR9rBOD75gTkt6CfX9WK8R34H2tx2VIQ4XnVVJBWzGAL53vG1soCCebi+/pLyU8sR1ea5G/fa9g3FcwWCRKajw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAQDT6oY5OcgdSN1C7jHGCMlq8FGau1ZD6szWSbL8XY=;
 b=YGSkukncqxbaaCWA1UlkVkYpVnXJGY2F0ZQEYHeLRwAmFP9h1O6nUuoUvcjifwgRpEhY3QwqbZgBF3hBqz1KKhWYfrlOdDCf1lU41OIMRhBOO+YUqiGJzeqDNHNhp35Ljdi2yOwyu0G+BsSr7/O0a506AjaRjpvZNjhvsfdxd4AK2AXK8UgJwvTrvreFPmttrFFvSNiVJ2keZ8YeC2V8fayFG1rb7DbB8aN4TG3KLvAuEHEvVGD3835mYQbOhUcMlgCvOHsyRVBoEPEHw2G4qjItUKcU1feKFl4RwFn2IBS1NEDe3ronfq8Wp0Hkxt+BrWZuyaMSNWNL6xbEv7y53g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA0PR12MB7076.namprd12.prod.outlook.com (2603:10b6:806:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 06:23:40 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8489.018; Tue, 25 Feb 2025
 06:23:40 +0000
Date: Tue, 25 Feb 2025 17:23:35 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, 
	linux-mm@kvack.org, Alison Schofield <alison.schofield@intel.com>, 
	lina@asahilina.net, zhang.lyra@gmail.com, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, 
	jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, 
	npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com, 
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, 
	david@redhat.com, peterx@redhat.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com, chenhuacai@kernel.org, 
	kernel@xen0n.name, loongarch@lists.linux.dev, vgoyal@redhat.com, 
	stefanha@redhat.com
Subject: Re: [PATCH v8 20/20] device/dax: Properly refcount device dax pages
 when mapping
Message-ID: <asvyejblo43qscvoqv5wpbpdhrjyf6o2tmj2qait2dmqpj7jnw@eqihgijwrkf5>
References: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
 <9d9d33b418dd1aab9323203488305085389f62c1.1739850794.git-series.apopple@nvidia.com>
 <20250220193334.0f7f4071@thinkpad-T15>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220193334.0f7f4071@thinkpad-T15>
X-ClientProxiedBy: SYCPR01CA0011.ausprd01.prod.outlook.com
 (2603:10c6:10:31::23) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA0PR12MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: 48137162-3acb-403f-f57b-08dd5564f17a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kDiscbIc/TMogWEkacpAxOKtdhbNbYxh96mc6yJp19O4KnLokDdHidMTCtnT?=
 =?us-ascii?Q?w3f+p7hyBvExy1BfviNNWCL+CzaU6AFYWImW/wiVjAvBDW8Bp5ET5jzsU6EA?=
 =?us-ascii?Q?pYTIFC9AONL8E0YuBROYP4+N4RsWGugbzCXH0ih4Q1dOhC8Mz6Fz0+cHN4mW?=
 =?us-ascii?Q?B4Vz/KVFO4Ye/9YDykiLQ01YCrBKwHLGQug3GLngTgKTJcVssLuUpHZ05AeE?=
 =?us-ascii?Q?pXULbQEO68LnEPDaqnyP2uKb6deLvKVpErbMff81wqWmKR6jip2LCXESAiQ0?=
 =?us-ascii?Q?Uy+pFePe4u+4UEqKFUykeWokvNfpAHI9aJyg+faFnympp4Xy4KN3N6oozcrG?=
 =?us-ascii?Q?Ku82SjiqqDJVWNzgZ0q8GmmYTuzcI2qsvWiPckfQjLNpIz0NP85iaEOAsDlp?=
 =?us-ascii?Q?nOabidojdPfvgKZG3VaNptzI3ix+133QYaVlNsFeN5YaLdf+FJfqewCnX94e?=
 =?us-ascii?Q?CgYM6ups/SClDbXzsGLbYKUGQx6TCnpVBNzYEcgNi9E2i4pIs82LqxhPdmyy?=
 =?us-ascii?Q?5rTXnNuuVSafoyNsVNeiGU8w/JK+yS/XsvtJrg62DC1VH7xTDFDOanF6iW0/?=
 =?us-ascii?Q?h6IxN3k6/4NVoivIBkho0eDmKhKIzoVmoqMRyVpOPfchFTshTl48mFwICvOW?=
 =?us-ascii?Q?l/ahe5mfTUstzFjtwkgiqL9CyCMstSaaIghRgCXCd6ASCLVP8ae+rel1yb+P?=
 =?us-ascii?Q?pCFT8vSpmdOEgOnO0pRXishocoCBZO6eX1f6eKyQ5OPPY62Txqt+gSN1xExj?=
 =?us-ascii?Q?tcRm0M2vxvUX62oyKND4axY8RkEMLPZ4fRj9VmWsjR9Ohuw6DlJSwzQrLc98?=
 =?us-ascii?Q?JBd7CzqW/+Y7DYbGAEHrzktpjBI9FGI+m/JxePjKDUCfh2aWbpUzB7V6Eif8?=
 =?us-ascii?Q?yDoPdvbYCNCJPYbzALHHeauItW5E1co+kw1ljnzJ4qSoZ/wbB6+rcZTTEiL0?=
 =?us-ascii?Q?xbcCdi9CmV5h5LxDZbnnj4WC44nT6Vve2iTgJNQkfl9YmNmeX3ovY2KFij57?=
 =?us-ascii?Q?CIi+OqCczgUJvIQY1I9LQyAj1FYT58DfLTHAai6Chmjf9+8c74jEoKrSnnvl?=
 =?us-ascii?Q?M7ppF2P/l6hGNS4lErzTAdlPM9RdbHZfcRBcm4w1/sGvb6gXUndTtdREgyLt?=
 =?us-ascii?Q?KQ0kX77kTfgG1Lu63Pr1fyuItxPW5/Rm4i5iVbLysSEaiBuul2fTlUae1fei?=
 =?us-ascii?Q?ae0+7aMbibEsSpt6Hqwyw3NBfxG4qj9huDteHiuti6amvmj7zqtFkSC5du49?=
 =?us-ascii?Q?XZKQbWi/nJqkhASkJpjGYx3sxL22uEyutWtWXhUQoh6XH2n2NEIJ7KTQ53Kz?=
 =?us-ascii?Q?MdrrlGTqx7RF82N9qL1NuAdNEhX3XNoXJaNyzCmV6dL0ZOfldvhOqnTyYz78?=
 =?us-ascii?Q?LREjKyhaOv/tcpCRJ9fkWEcprx10?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K0BHBbo7rHv2DIee0rRFwnef7NRpc+gqFBM57jl9TQ89zJCnPpAvx4fmcMe7?=
 =?us-ascii?Q?w3QpklRHkdk5UuNemsco0/OQ19W35o4FVN26YycpRoXkrhq62KFIcymEgjfa?=
 =?us-ascii?Q?cOGEY/5Qi0tBwXkamKABLYPFFDxNBjWfTAr2DySPiLjlml8kK65ukFrR1c92?=
 =?us-ascii?Q?5YcoqdgUWQO06xnm7j2P2+T5odXDt4Awp7UPm7+xN6yxY2+EIW9N8KhmX0pS?=
 =?us-ascii?Q?MEULP7gKZ5LvL0DIZegK6ABIccYQZG1vGJCpPvFnASDmzcnWHoVv2RCMJNMJ?=
 =?us-ascii?Q?t5S7tybhejJFETpnSaCyELqFWCkeAsJP6i2hW/xhXuQEU2vTR/JfaImnJGya?=
 =?us-ascii?Q?YhSUYArrsvg4VdWEHbY5QMgmnx7NGMz5gG8Aw7ZkL34bjPoCccaLVuO59EzW?=
 =?us-ascii?Q?d2CmVOgnFH11LzAE7dXH0x+cDafGQl5b9HUruBa6Qf0MWD8vMi3B6onfk04P?=
 =?us-ascii?Q?3+zCIlHkViklwinjgcMfE7fEyHAzJo1tb3OtBhcs9F19k65m5aSviqyOSfcw?=
 =?us-ascii?Q?kSI982tQ5Pn80jGCM/Wswe1Jquxe/577+5k7hn5pIhsiTp53/qR3xyimeCnP?=
 =?us-ascii?Q?OWNvlmLLOY2ZuvhPdUCNSK3fG1NWY48ju3Wrx+PuuZB1VJKTOeKqPwB85znU?=
 =?us-ascii?Q?CbqdTZ7s4wLc7aJ/VH1hNRbfwhb9Ib558iZ65O/IBkfO8xiwmo/Jc0cLhY05?=
 =?us-ascii?Q?W6ZJEkyuLqN10zdcKzAkph4EcPWtb3sufX3SkO0zK3ZcPIMTUtTJldxOICVC?=
 =?us-ascii?Q?UhuIEUJHY9mjyIQsnmnnMncrQ25xMEydBZNDtXyaXW/zQTA/wbb8Ar+1vhIr?=
 =?us-ascii?Q?BwldMrt/y3GdLiMyx5pOP+qxhvWMnPx3obfurtF3f6sLyiZ4VJuHz/yru1Ey?=
 =?us-ascii?Q?oWrtlZIpU46KBzjSG6LXDrgvI2feP3T1uhvJM5oYtp3NOo84+9lvxz+DWbhC?=
 =?us-ascii?Q?9tlH9HjzoqruEWIMv2rSEfEkVRXOoBYn+IQQ7h83wN9Xo1Q5TbEsLLloeSbs?=
 =?us-ascii?Q?8kLOlMyT5FwVRWdx9Hj3pK3puG2a8ZiratQealwVUZuQtkvsT3dpO7GBVTTw?=
 =?us-ascii?Q?Jyw7KcUszKm2dz++WnLegKlhl/uxjg21gBAJQG994va7lViCqLa5ZACj7gS9?=
 =?us-ascii?Q?T3k5HI/0TmSSpGOO/Mxc50hXBGCifh96aYRUsk6E+oANJpAtGo90cUbMs1WW?=
 =?us-ascii?Q?ZE2uKkyHMKYURjx5kXEkCBWqF4hjR81VLnKzcDLSwOq5I7ar0Kr6VyOlhI9X?=
 =?us-ascii?Q?INx+mY3EcIR8LTVMdpXufYOZX8Kqmv1mIBJUFlvzqtbIjYi2fEYqpwU6AiYA?=
 =?us-ascii?Q?rl4xW4RqGFjtZ/cpDNXLGJ0O3w9JpHDOnxlVMEgHtllo754ZOSvkXDwT4WAo?=
 =?us-ascii?Q?60kkYbxrM6cxwzLV7sKUBt13czLVbECpbQ7Jt2k8eE+/2dw6+Hl0BZ5WXpPl?=
 =?us-ascii?Q?UsWfWR/6HYQfpzKGFjsjqiO+/NDROEYZSsoVG69DZOkJE2SXEkknvXe2UfV+?=
 =?us-ascii?Q?F4HSlCvys0StzVVnbDPX1mQvrszaajCLWoJOs1hFW7OW+uex3rKWqivj0HUa?=
 =?us-ascii?Q?4iTa1iFsx/QBZRwAuOm8bllr990DP9ahSYWNIZow?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48137162-3acb-403f-f57b-08dd5564f17a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:23:39.9737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PvPd10RDT7xwb8wqf3VkLsOrCUbeBkIIS0HqmXND10Eu9MB6pPYaQ8vaTHqBQJyVuZClzFdhbVUurl2uMrCZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7076

On Thu, Feb 20, 2025 at 07:33:34PM +0100, Gerald Schaefer wrote:
> On Tue, 18 Feb 2025 14:55:36 +1100
> Alistair Popple <apopple@nvidia.com> wrote:
> 
> [...]
> > diff --git a/mm/memremap.c b/mm/memremap.c
> > index 9a8879b..532a52a 100644
> > --- a/mm/memremap.c
> > +++ b/mm/memremap.c
> > @@ -460,11 +460,10 @@ void free_zone_device_folio(struct folio *folio)
> >  {
> >  	struct dev_pagemap *pgmap = folio->pgmap;
> >  
> > -	if (WARN_ON_ONCE(!pgmap->ops))
> > -		return;
> > -
> > -	if (WARN_ON_ONCE(pgmap->type != MEMORY_DEVICE_FS_DAX &&
> > -			 !pgmap->ops->page_free))
> > +	if (WARN_ON_ONCE((!pgmap->ops &&
> > +			  pgmap->type != MEMORY_DEVICE_GENERIC) ||
> > +			 (pgmap->ops && !pgmap->ops->page_free &&
> > +			  pgmap->type != MEMORY_DEVICE_FS_DAX)))
> 
> Playing around with dcssblk, adding devm_memremap_pages() and
> pgmap.type = MEMORY_DEVICE_FS_DAX, similar to the other two existing
> FS_DAX drivers drivers/nvdimm/pmem.c and fs/fuse/virtio_fs.c, I hit
> this warning when executing binaries from DAX-mounted fs.
> 
> I do not set up pgmap->ops, similar to fs/fuse/virtio_fs.c, and I don't see
> why they would be needed here anyway, at least for MEMORY_DEVICE_FS_DAX.
> drivers/nvdimm/pmem.c does set up pgmap->ops, but only ->memory_failure,
> which is still good enough to not trigger the warning here, probably just
> by chance.

Yes, I think so. And you can guess which driver I've done all my testing
with.

> Now I wonder:
> 1) What is this check / warning good for, when this function only ever
>    calls pgmap->ops->page_free(), but not for MEMORY_DEVICE_FS_DAX and
>    not for MEMORY_DEVICE_GENERIC (the latter only after this patch)?
> 2) Is the warning also seen for virtio DAX mappings (added Vivek and
>    Stefan on CC)? No pgmap->ops set up there, so I would guess "yes",
>    and already before this series, with the old check / warning.

Right, I simply updated the warning to reflect what should have been
happening prior to this change. However looking again I don't think
free_zone_device_folio() is ever called for MEMORY_DEVICE_FS_DAX pages. Instead
put_devmap_managed_folio_refs() would have returned false and cause most paths
to skip calling free_zone_device_folio().

The only path that doesn't do that appears to be `folio_put()`. That probably
should also be calling put_devmap_managed_folio_refs(), I'm not sure why it
doesn't.

> 3) Could this be changed to only check / warn if pgmap->ops (or maybe
>    rather pgmap->ops->page_free) is not set up, but not for
>    MEMORY_DEVICE_GENERIC and MEMORY_DEVICE_FS_DAX where this is not
>    being called?

Oh I think I know what actually happened. Earlier versions of my patch series
did define a pgmap->ops->page_free() callback for MEMORY_DEVICE_FS_DAX but
review comments suggested I just do all the was required directly in the switch
statement. Obviously I forgot to update the check when I removed the need
for pgmap->ops->page_free and having pgmap->ops->memory_failure defined was
sufficient to (accidentally) get past the check.

So yeah, the check is wrong. It shouldn't require pgmap->ops to be defined for
MEMORY_DEVICE_FS_DAX or MEMORY_DEVICE_GENERIC.

> 4) Or is there any reason why pgmap->ops would be required for
>    MEMORY_DEVICE_FS_DAX?

Nope.

> Apart from the warning, we would also miss out on the
> wake_up_var(&folio->page) in the MEMORY_DEVICE_FS_DAX case, when no
> pgmap->ops was set up. IIUC, even before this change / series (i.e.
> for virtio DAX only, since dcssblk was not using ZONE_DEVICE before,
> and pmem seems to work by chance because they have ops->memory_failure).

See __put_devmap_managed_folio_refs() - the wake_up_var() was there to intercept
the 2->1 refcount transition. Now the wake_up_var() needs to happen on 1->0,
hence why it got moved to free_zone_device_page().

> >  		return;
> >  
> >  	mem_cgroup_uncharge(folio);
> > @@ -494,7 +493,8 @@ void free_zone_device_folio(struct folio *folio)
> >  	 * zero which indicating the page has been removed from the file
> >  	 * system mapping.
> >  	 */
> > -	if (pgmap->type != MEMORY_DEVICE_FS_DAX)
> > +	if (pgmap->type != MEMORY_DEVICE_FS_DAX &&
> > +	    pgmap->type != MEMORY_DEVICE_GENERIC)
> >  		folio->mapping = NULL;
> >  
> >  	switch (pgmap->type) {
> > @@ -509,7 +509,6 @@ void free_zone_device_folio(struct folio *folio)
> >  		 * Reset the refcount to 1 to prepare for handing out the page
> >  		 * again.
> >  		 */
> > -		pgmap->ops->page_free(folio_page(folio, 0));
> 
> Ok, this is probably the reason why you adjusted the check above, since
> no more pgmap->ops needed for MEMORY_DEVICE_GENERIC.
> Still, the MEMORY_DEVICE_FS_DAX case also does not seem to need
> pgmap->ops, and at least the existing virtio DAX should already be
> affected, and of course future dcssblk DAX.
> 
> But maybe that should be addressed in a separate patch, since your changes
> here seem consistent, and not change or worsen anything wrt !pgmap->ops
> and MEMORY_DEVICE_FS_DAX.

Nah, I think the check is wrong and needs fixing here.

> >  		folio_set_count(folio, 1);
> >  		break;
> >  
> 
> For reference, this is call trace I see when I hit the warning:

Well thanks for testing this and for posting these results.

> [  283.567945] ------------[ cut here ]------------
> [  283.567947] WARNING: CPU: 12 PID: 878 at mm/memremap.c:436 free_zone_device_folio+0x6e/0x140
> [  283.567959] Modules linked in:
> [  283.567963] CPU: 12 UID: 0 PID: 878 Comm: ls Not tainted 6.14.0-rc3-next-20250220-00012-gd072dabf62e8-dirty #44
> [  283.567968] Hardware name: IBM 3931 A01 704 (z/VM 7.4.0)
> [  283.567971] Krnl PSW : 0704d00180000000 000001ec0548b44a (free_zone_device_folio+0x72/0x140)
> [  283.567978]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
> [  283.567982] Krnl GPRS: 0000000000000038 0000000000000000 0000000000000003 000001ec06cc42e8
> [  283.567986]            00000004cc38e400 0000000000000000 0000000000000003 0000000093eacd00
> [  283.567990]            000000009a68413f 0000016614010940 000000009553a640 0000016614010940
> [  283.567994]            0000000000000000 0000000000000000 000001ec0548b416 0000016c05da3bf8
> [  283.568004] Krnl Code: 000001ec0548b43e: a70e0003		chi	%r0,3
>                           000001ec0548b442: a7840006		brc	8,000001ec0548b44e
>                          #000001ec0548b446: af000000		mc	0,0
>                          >000001ec0548b44a: a7f4005f		brc	15,000001ec0548b508
>                           000001ec0548b44e: c00400000008	brcl	0,000001ec0548b45e
>                           000001ec0548b454: b904002b		lgr	%r2,%r11
>                           000001ec0548b458: c0e5001dcd84	brasl	%r14,000001ec05844f60
>                           000001ec0548b45e: 9101b01f		tm	31(%r11),1
> [  283.568035] Call Trace:
> [  283.568038]  [<000001ec0548b44a>] free_zone_device_folio+0x72/0x140 
> [  283.568042] ([<000001ec0548b416>] free_zone_device_folio+0x3e/0x140)
> [  283.568045]  [<000001ec057a4c1c>] wp_page_copy+0x34c/0x6e0 
> [  283.568050]  [<000001ec057ac640>] __handle_mm_fault+0x220/0x4d0 
> [  283.568054]  [<000001ec057ac97e>] handle_mm_fault+0x8e/0x160 
> [  283.568057]  [<000001ec054ca006>] do_exception+0x1a6/0x450 
> [  283.568061]  [<000001ec06264992>] __do_pgm_check+0x132/0x1e0 
> [  283.568065]  [<000001ec0627057e>] pgm_check_handler+0x11e/0x170 
> [  283.568069] Last Breaking-Event-Address:
> [  283.568070]  [<000001ec0548b428>] free_zone_device_folio+0x50/0x140
> [  283.568074] ---[ end trace 0000000000000000 ]---
> 

