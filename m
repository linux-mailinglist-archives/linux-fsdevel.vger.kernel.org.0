Return-Path: <linux-fsdevel+bounces-16682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF68D8A152B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC55A1C2210F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 12:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614FB149C59;
	Thu, 11 Apr 2024 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D/VGu+T1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440901426E;
	Thu, 11 Apr 2024 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712840364; cv=fail; b=RGiA015kzZMNp6Le5HbW0GUumCwwyaZxyLyC6hB9m8X2l1qbjC+7Ovv+sT3uTWgiHtD3tB0s/4UJXnMEPeCFAATL0zy+5y+p62ZuAcJoJ9z3Ei8FXokLUXx3qIX/yUkNJN/HAr9AoROZcHOdItfkF6XjNTxz/zPy4txKoFEZc4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712840364; c=relaxed/simple;
	bh=Ytcga5Zt+nyc5ne7xkzhSSF6Bzi4GvVUD6mvvHKDYIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cuh+nRMRWSKKfQqUNRLEqJBBE51b4ftZbNcjIjB2htxPKFxxhB2hZKusPTv/YePZRZH7oCb+5B9Ht0sftayaEcRBeMYGI4x71XflA/ixT7MWbx3/EMHdCnRc6pnUelbhMWkShb09s04hYlBT5iOQnmRD6j7L+He1pN7illC9MTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D/VGu+T1; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekb5iHVzzw2TONDzt+mXgf0sXI6vm8loZEbh9epFbuorgFuF7RzdWOByUr7SI6EtMa7HFOFmXKe+0hSbgzazWEsWiC+FTgy6umaypcPCKRfV+7BLrHAxhT2pl4qNT7klgEhHuiKH0/b7eNposLDSgIZNBEHkoW1Aaf8bKD8CYt4qELTEmYSmWqYFni1U2b83+ONjgXCEKidz6MbD0LmMsyLhux59Tk9GAiaikrQHaiYF1tzrrSA1g1sOAOkT+TIAi83RaD9euRHfHJpRbLR7fl63afiaZx62nooLFCa79Qs2YtBUbu552u7HT144WWh1e2xnUTlmGD4r+9iZbBXL0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dShLBRNdwnuGgjIuY32YiBXZtaYY9H1aEkeW2OoEfoY=;
 b=cvmT56OHjz1pqBAKpCC77HUJ/5WkVwrmXpI3ojn/6kaZxaN2lDvNHMORizqqWVamSFhvlXVf8+QRyftK6wuf1iaGfgv3wXNfCaCWOTj9zqlEpGHs+cookrWIAsXPzvAap6uLx357/IuAU1210W2G4WiPWmWAKeL12Yuz9du88eM/XxaHKfaOWQ0cY7iMTRYsT/KiIBHg3IOb2IdOA+IU8e0krE6abRanBoZoDuuwlJEfChDuSliaeLf4pCI4QGxm82yVb+hIWlv8kfaHs65utCCCGAVkNNwwRl9aZLWVxS2uElrU1BqyBp9bmA9/w7E2zwHs6GqMVyKKvUBL//GLbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dShLBRNdwnuGgjIuY32YiBXZtaYY9H1aEkeW2OoEfoY=;
 b=D/VGu+T12f8f1idK5FKLgFcMoW86tbrzExKq3GotNrbosSIQQOaxOhjy1dpB4idZYqoOzOC8SmxRHPeafvDQVqPULqWPwYt4Cb7NINaOopT9Wr5Uvd2CZIpjU6Cj+/EjMpXIDOTJS75W7icN8cVVHzFM8lj1cL8+Qapclj8Xl7MXMCvkmkOwyEiODUqsq67f10yLAejd4kVYG+vq8ZRD42bBeUVpo74F1NjBZJu8ikqVL/OqZTPqOxe9ZK5VT93s0cDQB/6oI+ggdkadggTDQQ5uaeZpq8d3OFOgMxEs6PKZ1MlyW/LFUwWR8BoTiCgZGpjWw5Ze8jGlrJJsVdPaUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 12:59:19 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 12:59:18 +0000
Date: Thu, 11 Apr 2024 09:59:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, david@fromorbit.com, dan.j.williams@intel.com,
	jhubbard@nvidia.com, rcampbell@nvidia.com, willy@infradead.org,
	linux-fsdevel@vger.kernel.org, jack@suse.cz, djwong@kernel.org,
	hch@lst.de, david@redhat.com, ruansy.fnst@fujitsu.com,
	nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, jglisse@redhat.com
Subject: Re: [RFC 01/10] mm/gup.c: Remove redundant check for PCI P2PDMA page
Message-ID: <20240411125916.GU5383@nvidia.com>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <ffd72e934eeae28639b636e1e61a9c5109808420.1712796818.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffd72e934eeae28639b636e1e61a9c5109808420.1712796818.git-series.apopple@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0260.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::25) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA1PR12MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: 849d1c3d-184e-4029-f5d3-08dc5a2732ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N0CtncHyoZj/fTHOn/zQqx9AX/wfmXSNwvWRJXYFlciIrt1OT1GPf8bEWc/EjEqtYfu41tLaO+oCefgAw2NNTJ2UDBsfI3IY9ESkMrbK1DX6uSiACNrlg4BrcdS1PKmhpv7VlAzT4mo7I25PHXRGwoPLedUs94v86uv0IaboHvwrV93tCgUDVA9TF09KateYl6X6gL9hhautu6opgcBEarE0tpAoMrds/Kxg5gGslySs+I4Bor861jpch/v1yF1I9NRRrozzkbQd+ouyThfees4iJzXua5auVulQ1EE++HdFV9iugp6FLFBX/3Zvx+bT/MjT98e1Mete10HJGDu5tT63qtWlLNPacZzL0Qf5cGE5/gZzxIY0WWL4/Lcs2TRBImieZzBJ2B08OF8zjhjrSXbFVP58nMV+ittk+iKXVGruAlqDvE/czxDr3vBHE8YGpPp2760aXYBWooDxQ6kfHY0CUHDlReDsSV/Gmz9laogzIUnSEVX0oSSaQTuABRDd/bvJW1UkzLsM0fuwwTaruPRntCkFKh96oh20ds/0uJU46movSjwQAlfwt/f0f6QPhK9WtzX/jkR50GGUWxkgYXDg4nR88et/3jG4KrigsH2TiAC/OTvKBxRGTQr7xsASV40HcKMcpewP3KgA7gpsVpdLVMofwXCKiUpfye0hveU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fgB58fs9mDJ1VGvsCCujWBiTAPX2EkYLZjIhOJPSyJZxFTN5XaiLYT9XQQbb?=
 =?us-ascii?Q?FEEngeuuzt+7LioMJqz+f919UmnLJiFNmRgcS8yrdKMbBgQ2Ddi0OPS7VMjq?=
 =?us-ascii?Q?rRgti4SvnwU/T43oxFOYeGCGMhVfJym8ITO7jbdZwLvJvR9FczfAwBolsuCa?=
 =?us-ascii?Q?K828K8M5V2mtLvUPZJuHY3ocqj/pbh8svbvSRRhue925xIpD90DCjVy+7ahW?=
 =?us-ascii?Q?jA86yASqsYaANzlSkaaD6kfz9pp82i3Bw1V1DXLG+8y4AwY98avciaBCW0zz?=
 =?us-ascii?Q?rEX/O13P5aYb9vodpWZ5Zp3Ug2cH/Eah9Vg7SlcYFUERJ54iBDeYdMkL2s+9?=
 =?us-ascii?Q?6lZBV2uFRwa5iykVehMZMIlvQaNQeNGQgReq7J2pTDd6DMpy9/W0TW1rHluo?=
 =?us-ascii?Q?ktmTQgyyPcEqLZUOIimVYRav7zThofWnwdwEkgOaMKuX9j4dCe9OIY2tdZ/1?=
 =?us-ascii?Q?qauHKSkkoABlpXO0ILDrWJclDO3aOEDU9YHNYjuHhjPl2e0673N8FmJeZ1aD?=
 =?us-ascii?Q?nWrhclGgrUD01GAaa8QkTv+ITA/rQ9AOd+nMEVDXdRnMs38uRlR1KV+aEqBX?=
 =?us-ascii?Q?X/3FORk12Klr8kDseCNkuLATYuQoESbdyJxp2/aCglo6b5l3GUFZYRELvlU+?=
 =?us-ascii?Q?ugzAIK/wtO3RmQTjEopi4l6xdWwHmcVOYk+6gtwBgUIqj97V1oAb4byd6mpj?=
 =?us-ascii?Q?vh76T1bBiZRtix/Ya9egx2pIisN6pIE1gOOnJ0EAtkYoCHl+AyfQrGpnDMgz?=
 =?us-ascii?Q?kwS6yDU3uX6wRPu/de5T5rs6YVYquOC7GzXUNQT8j0BB2MJILQ8M/c5QOEoR?=
 =?us-ascii?Q?pnFEhXLXzNzADH5RYwgVhjswBdOQM6S0bJgeupUJABHn3xb0JrCyDe8BzIMB?=
 =?us-ascii?Q?M2+/cg+dJIVKoyhIit3iwpFza1e+OECrnUepKGf0/8gmk6jJXUwXSitN+xa7?=
 =?us-ascii?Q?mehnXZntk7eRR+aznXbkoG8w/SazK/m+cr8HZVq69YAmn9/sxG7axfr3rs7C?=
 =?us-ascii?Q?ZFQ9DZRyr0fhMM7fesLNe67p0yOOSMSI5N/Q9L3fIQlWS0mSRddywIfV4bki?=
 =?us-ascii?Q?LcgCo1Kokl/a1NPS12HIZpOrKfL5cMx4fD/x7XlQgTPkTBSY22xP43mnB/qO?=
 =?us-ascii?Q?zR1EW4IWuAVyH3Sf7YlYMrWVx9SCSD8gZ+mF8d/YS/g19vbJE7KGzZrPW66F?=
 =?us-ascii?Q?/UpBP3PNlUrvKX59XRkfK5JcFigWIzqunRYNnL7BoieWGQ4gpxK+wlqB9hh2?=
 =?us-ascii?Q?MNO9RDPqA2TWkr8Pe/42xET4WePI3jxMysnxWBAIc1EbABWcX7+0uZfZBVXj?=
 =?us-ascii?Q?rfdQTA3O+E8+YoXt6bhG/sNP7JQ93v22W28jYRPRzfVZGqw3w1lgI0EjpFIN?=
 =?us-ascii?Q?fenKkuTL2z6mVnErELrfynoEfN1oxTbXQYgMra8ystijXWN8UFJQspAHE0tl?=
 =?us-ascii?Q?GOS5ZJa87Y5pxN9/of0nHTDEtBpiao2h52IzUZiz5AN5Q8j4qKtO8VPFbE89?=
 =?us-ascii?Q?oVatcxWpRCRbVxOB+Gugh52keJNjQbb9Wsznlf8BUP+HuVeJhT5Iyl4BTy5h?=
 =?us-ascii?Q?5M0BBWZsZifuIMlpw+MwLdBBKCGtXbDfFGIPY1E6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 849d1c3d-184e-4029-f5d3-08dc5a2732ba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 12:59:18.3239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2iCf1uzb8VoAmmC9y7Rh7h9HU6Z9t4MowGcqbfsGd9DMc6q7k69TBQMkcDp+VlI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520

On Thu, Apr 11, 2024 at 10:57:22AM +1000, Alistair Popple wrote:
> PCI P2PDMA pages are not mapped with pXX_devmap PTEs therefore the
> check in __gup_device_huge() is redundant. Remove it
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  mm/gup.c | 5 -----
>  1 file changed, 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

