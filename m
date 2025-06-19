Return-Path: <linux-fsdevel+bounces-52157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1A6ADFF3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 09:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812843BFE6C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 07:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DF8231837;
	Thu, 19 Jun 2025 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D6WQp2A3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E30A25C71B;
	Thu, 19 Jun 2025 07:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750319783; cv=fail; b=ibu/5Gs190n0UnvI+aQJet9RdPUc9cjiQSkuV+o6UB1vnfqD4JeNHmrzqjX02mMHlNihX6b6kp9A5c36VjASu4+H+dKrmagyi4hrtIgGMOJl0gJVaaASbWc88OylbIyPmEfE4Whlt14B35k/rgQXYtO6rSUkhAK1+LWTBlXZaUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750319783; c=relaxed/simple;
	bh=1QjX+NIPFKJZ6vuX5f3MJJX+8D8kkLouE7mwfPM4eoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ckqzbJWCUsU66DWibK2Y2dw/x25J7Oyfg8jRVZTMJIoMX7ZkNoo4pZiMFthgtAmJ+Vd5aTh2XBUwg8Ml3aBB4RkBi2XLSIxmoccAQpITnLCTVgxADEmQiTysKA/oFcdHF6VHk2mQq16u7NJ+7TgOZQI5vSLROsnWSXFt+v87Cic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D6WQp2A3; arc=fail smtp.client-ip=40.107.212.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6g3cd/zZAOv/5zIzzFvYUEjdFhSMX12f4RQuw7dTdNGzP64La0BgyRpZGTrzacL3jJtRTDQYXBHbS/xNecjuf7k9twwg4Aw9kZonR/1hsvD1k4IwtPFXPkGGnb/01TYgQxpIU7Ymlqz8S448a4vLJhvBoOUwDAQ5By2x7zpJoab1fksHOk/3ahcQM+JWoKx0tr1IF0EnFiYxP5bIOq3KgVLmPsoKCfe/ig/1gCwg9X5HrWstVlC0lnrb24G1Be7MADLQ8hx/CulYoc7LXtI1/u2fYr8WShFLvi8+hUQubh+XkVoOQZKieLY3AjUd3IKmIx1YdXobvqqZyCRn4Zrvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTKySE4b1EFfFWauijegDFEssdPzD7QI+IdR6mlJDVw=;
 b=kCvNiI4zaIdZPl/xVxY4hIrIBHQLG5jkigO649WUXrcs989ARyNYcfE/MPpnOr5J9E+gA2zp4Bd04p5WNhN7fEVAAFwPtpMVNKwMomuzXRX+1OXXkBEhIzTEc/3c8bIUf9WAaQgsM4tD7o29B4eIsWrvb1izaihA3VMGtu07lepcltjZAXDwNyrgHbw0O0frV4oyB3NWeoZAEGoOepjhUIWiBMKAmzH5PXMRExyiuwPbIimzXor4GIZkaEuIaNHvi761gq9HKWTX6oDmjkIE7311LU1Jk/ZrLUhnAPHkUU88n/lsZx1dasQMN0MsOzONLN+2XmS1CRsGOzLFtotYog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTKySE4b1EFfFWauijegDFEssdPzD7QI+IdR6mlJDVw=;
 b=D6WQp2A3Xya76KcbucXMGcZuqKMApmktpawedkgdszrrSa2Cl2nbq+ei02XMnTD8iim0wlo3UZwHzCx/U9gu357Ni1ZH7t5MicQ/KgAM9RhgLV0QdKmuO1e3J+u9nETG+sv6tafsSIECT6qCbmNNqhkzTqTXl5iR1IS4PuQyfz9u2OJMdVCWybWshFU/3xJiBlxGiJPmiGSp8QGBWiRw4Bs5DPhb4FGU3d++cEWIjuLl7dwOC8WfAgndDN3M4c2joOnW0T5WNa0Hhq/0IpjHtZGdbUQYCEB1sqJcBsJaTknCT5KIWgkRKdTifSkiSuKJj6Q6H8QAGq99WTfD/64cQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 07:56:18 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Thu, 19 Jun 2025
 07:56:18 +0000
Date: Thu, 19 Jun 2025 17:56:14 +1000
From: Alistair Popple <apopple@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	gerald.schaefer@linux.ibm.com, dan.j.williams@intel.com, jgg@ziepe.ca, willy@infradead.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de, 
	zhang.lyra@gmail.com, debug@rivosinc.com, bjorn@kernel.org, balbirs@nvidia.com, 
	lorenzo.stoakes@oracle.com, linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-cxl@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, John@groves.net, m.szyprowski@samsung.com, 
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 08/14] mm/khugepaged: Remove redundant pmd_devmap()
 check
Message-ID: <g2w3xqtz6kz3u3c7zxvpv76azlfjwhau7tjbkvfokhbz727hxr@c2po6fgf4gu3>
References: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
 <d4aa84277015fe21978232ed4ac91bd7270e9ee0.1750075065.git-series.apopple@nvidia.com>
 <31bdbfcf-bbfa-46b7-a427-806d42d88cec@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31bdbfcf-bbfa-46b7-a427-806d42d88cec@redhat.com>
X-ClientProxiedBy: SY5PR01CA0047.ausprd01.prod.outlook.com
 (2603:10c6:10:1fc::9) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|IA1PR12MB9030:EE_
X-MS-Office365-Filtering-Correlation-Id: 21437370-7f51-40cd-08e3-08ddaf06c5e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5qxQRc3El/9suMvitA+mp2tFZdWng/nmnoflTNHzEx1Ufoz94k5+kccKjYWz?=
 =?us-ascii?Q?dSzonhcA2o9xLJRjSZktfSDqLxV+JXI3zUEO2CAzTNuAxYip+t9IvQ0RgzI4?=
 =?us-ascii?Q?NY3JgdVPuV/Y+2poxCrCUvDzXwCPacLiU2iamiNZgTCXzVQF9wxCO0Uo445c?=
 =?us-ascii?Q?TVDmHbRSGz7cvlKKhXcZiMDdCnFWa/xNJN1UBpDKy64b8I3oG55eAHclhoIR?=
 =?us-ascii?Q?HGKOFlWbr1a5rwZ60789DhKI4Zqcr/1NDrr/mq5M50OpZqUoyMf80kZ61P+Z?=
 =?us-ascii?Q?euYLAgr7j91pnXllMCvFYsCdXKo82plxGNkyyIS0mfBd3ZGnP0A0idMNExNm?=
 =?us-ascii?Q?iSetwzyQfsTNXx8ZiCXICv6ubMTVewIiVHdiHML1Ep7+1bZ6vMaL9DowKEQn?=
 =?us-ascii?Q?fGHZxmxReZCJUSgjgngeKeqg3F2WaHDksrRvMw02T2urmRw8deog+D38nT2h?=
 =?us-ascii?Q?R+8x0WaU6kiuh/U9KvogmzygvVNy/1/NpZX/RhwSGICGDmABb7xhq7hvnz4P?=
 =?us-ascii?Q?M+caE2TUV2g0mfiZW50TVj2ttMRU9Fxo/rqitT50KSJGc5ZLQjf86LQ6UTUT?=
 =?us-ascii?Q?2h7kOI+nnqsbJRLh1cIcAOLxNDBMGRrZPjZjX5UKf8bwrb21Ih6UsVKcn406?=
 =?us-ascii?Q?Kp5qNR5Gu5qB+he5VCCSOLEnJf5I7JLEgucm1Q4+6Ap8K76DcSJ401yNWkPi?=
 =?us-ascii?Q?agElgcaYQHFwWwHp6QRva8UKWARKHzhUUTmwXVooka/lA7isuwMNfx5sQUlQ?=
 =?us-ascii?Q?Y6/ji4d9b4Vx6ElPLasOt4BKLfvON1OsUpISD4w9T4o+QNQjI73xfTaqcuZ1?=
 =?us-ascii?Q?s4dlgRXoTlfWPqFpLQGtZZY2TRcmqVWSuHJNr/jxBZtwI3eadxPxsUh5JHqq?=
 =?us-ascii?Q?kRDCvCrnBN91/s1nSt4j6v6PlOA+RTQ1b0fAskn/vpTec48fh0kr7FoeoLBY?=
 =?us-ascii?Q?s+7jJRihYdLZV7Wx0rBDbt7SyJ1khzQ2KedwxuQzM0Bhykt/DUEWLSCD61Kg?=
 =?us-ascii?Q?dLavbnOgjA83Q8vogqx0eotTB00ieqKvGvLGyX7/zZesX5KpjNNMipOuiJor?=
 =?us-ascii?Q?14IvJLa+rJafEso9uINa+4surpUWHlP8K4J08TZQDHfSp+Nbt6CAse6Zh2NX?=
 =?us-ascii?Q?b+GRt0AXWYes+iXcKFXebR9TxdwM+yBtfk9s16ExCt/QvCbFzbHE+zqNts8J?=
 =?us-ascii?Q?eDL5bHh+YJcRcwwYjWhjnW45ZT8CtbVs12uTMV9QZo3tNM87UYoGPFY1H0A3?=
 =?us-ascii?Q?Vjp8owtoC0+ykn02oCDgEcX2LWVNhVDFSdVOoKrgNZCGvd5NaEDC5k2S3v8o?=
 =?us-ascii?Q?I7ZQBi8jj+NtYDIO2jORJHneFNSCe5RUJmZ9ANiuecOirp0x4pubhgX1zt0e?=
 =?us-ascii?Q?xZ/yYrsYAnMOptBGPCE56pS2X6gR8e5gNjMdTcFQ2EdVYhnjPUibxXdwgp6l?=
 =?us-ascii?Q?vEA/Ip28FdA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WqL+BMdkA3kSoRZXTFDY91mdv2QDpYvTqnprD0Z/4zxPymPHpjnwU2eTC3Om?=
 =?us-ascii?Q?hesMLh96ZxxSpPSEZkcE3ohbZgqCaUbP8qoFV2FvXQlIzCEKkGZtGoqVp9YT?=
 =?us-ascii?Q?2tJ+94FOndqCRa6r9gST15x1/5vedgnZbsE+dpd6JeK3gLv/xZ0aCCSJLHM/?=
 =?us-ascii?Q?m4OxI3YzB9IUAvCZ+UubZ0FLIZOV/9+JsLm01KBFDSz+yYYNBDfRmPnWRZSM?=
 =?us-ascii?Q?m+7SMfkkdNrO3P9TpXdKCixoR6jZt2KGfIK8iDE7RlUSrDE8LP6HL/UXmEHR?=
 =?us-ascii?Q?ZQ0nr3EYLPNKE7z61y15+J1T0zUi7UtYjDsDlk1KvjxyXGaHcDTxa4eiXCfu?=
 =?us-ascii?Q?aYPK/VWR232VIWvJUPGDMgqT19ie7HNh8vNx6pyABw8x+rcm7BRFw6hnqL7u?=
 =?us-ascii?Q?sAZvkjgG0YXi4l6BnY7RJS2r1yW8Qd2+1m8KLuhCxBGvOy89seVEhfC0apar?=
 =?us-ascii?Q?9CujQObyQDjdAKYFeZD2qSxEI0lI0feqnD/gNdXYp9V0RQJ7XUS3amDM05BP?=
 =?us-ascii?Q?VZnrrJQH1gEjD0nDFYmrx4C3InLFR81wgHD0mVbp3gJwVg2rTTf7dTuYFM30?=
 =?us-ascii?Q?gA4inTnAxoslAkc9j5hI0Ex08UtltxcC7KFSSi9h70FrGvOuVIU2Ic/iiM56?=
 =?us-ascii?Q?jAClLuh4EuNVAHHULDyy9JbOT1bj/ht5pVuLWijURVMlBuRSeKsKIXewaMf0?=
 =?us-ascii?Q?/PoDq1Jv9JXiCtdYgh3S9q93HzVcDEW8hh249uWYve3hHQhksSVhrdtRSN1W?=
 =?us-ascii?Q?fqaNNEky0cyMGmqw1N8kKlHOT8MMJQ8wJz4ZjLEQhC/cfScgG3abhAguVN/I?=
 =?us-ascii?Q?doSd0F004FAvR7OnlOj229MRrAyQEMHoVrUbwq/W6KIYjXIGq5ER8OUUokeO?=
 =?us-ascii?Q?hCpqqXqHZmI6btYJPuoffu8qv2KvCnNIvrbyJuSw7b+FQpI09dbNfEI3KQm3?=
 =?us-ascii?Q?jr1nCodB4L5ajG93og1r+gnK+vVdi3k/JgptSNpOMSA3r3KlJPobKXcPuGnB?=
 =?us-ascii?Q?UaBLfCZTlaXxqIgVu+SJccazklKGI5t9NKsRW5N6WwmxKIJE60csouLMxyES?=
 =?us-ascii?Q?JM6DnTxmSWI+WpU0sXV1MIa5rpCg5QMU8/u9KIriK3PM/cY4KOWqayjIRw7U?=
 =?us-ascii?Q?uB7kBo06XxFF/6kR2kXuiSXOaBWfUDp16zz+kzwVeCZ5e+vRFNZoAuq8jIR3?=
 =?us-ascii?Q?jaLcQlTl5/SOXBI2kBt/TWtwYLL8i1Fpj/vv61tb3mMT94n4y7iWvHtJtbD1?=
 =?us-ascii?Q?LtmOgSApiS3JdiLEBNNs9gYfBSZR8+GFXmvGI6xGj1Zb2ybIOO1E8d4Bg00H?=
 =?us-ascii?Q?7uUYSKN5pm4kHS1Kkl16saR2z/xwop8dHH7mk9v/QiR2Q0jb3Rv9TrG5qLVq?=
 =?us-ascii?Q?/Mf/2QFwb5E/NO1jIkdFDzTw5kg6vvhPBBOnPL9I79Ipv+9uWP/4wVRgBnpt?=
 =?us-ascii?Q?r9tLaC2UZlGx8Y+JhVabTzBDXNLucodiHoaKEg988yEU0ZBff2RGG7OQVco3?=
 =?us-ascii?Q?jAv299aDLy3NUpCBX6JOFA4aY5//pqa86dhLpg1g2R4vL8l5LC8K5Ncug2hS?=
 =?us-ascii?Q?MN2kUCXp48zIOth/vh7yt/AnhDbwW1KnKiojKRQx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21437370-7f51-40cd-08e3-08ddaf06c5e4
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 07:56:18.2916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PF5upqql6Qr0TIVEk3/QA1IsGDrbUF7D48bKagkasURtuCW//680mwCZow/vyzVr4K6NLzZFq9Jj1giQ5kCnvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9030

On Tue, Jun 17, 2025 at 11:44:30AM +0200, David Hildenbrand wrote:
> On 16.06.25 13:58, Alistair Popple wrote:
> > The only users of pmd_devmap were device dax and fs dax. The check for
> > pmd_devmap() in check_pmd_state() is therefore redundant as callers
> > explicitly check for is_zone_device_page(), so this check can be dropped.
> > 
> 
> Looking again, is this true?
> 
> If we return "SCAN_SUCCEED", we assume there is a page table there that we
> can map and walk.
> 
> But I assume we can drop that check because nobody will ever set
> pmd_devmap() anymore?
> 
> So likely just the description+sibject of this patch should be adjusted.

Ugh. I wish I had've documented this better because it's all very "obvious",
but I think the description is still accurate. These devmap checks could never
have been hit and were therefore redundant, because in practice all callers call
thp_vma_allowable_order() either before or after check_pmd_state() (or both).

thp_vma_allowable_order() will eventually (in __thp_vma_allowable_orders())
check for a DAX VMA and bail. But yes, I should call that out in the patch
subject so I don't have to keep relearning this obvious fact :-)

> FWIW, I think check_pmd_state() should be changed to work on pmd_leaf() etc,
> but that's something for another day.

Sure, and I do appreciate these kind of remarks because sometimes I get bored
enough to come back and actually do them. Not very often ... but sometimes.

> -- 
> Cheers,
> 
> David / dhildenb
> 

