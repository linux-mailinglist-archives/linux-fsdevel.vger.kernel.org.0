Return-Path: <linux-fsdevel+bounces-16681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2298A151F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7AA81F24DFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 12:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10E7145FFA;
	Thu, 11 Apr 2024 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QsfT7lts"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E5628FD;
	Thu, 11 Apr 2024 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712840252; cv=fail; b=lRV47NVdgQE5FlcIh84c0mrmIB46t+uh9kpwtcbKzjEByCgYb2aRf6Hv0+aZy8ra+qe6/xqvG50x7JW02Rh1EfMm/LkVTD53D8aE0dUe8L0zgrJXfpEfvgJQlXSg6m0w/bOuOSUCHKsFNZKArohizhTg/ITKpRr6Wyk1dNy/BBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712840252; c=relaxed/simple;
	bh=P2n2g7dZHjw6epfdbsTJKiojdNxL3Yc+XjBztrnpMbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pwc5nPKWzNILD+Okw4S6xYErltACfFzCw9DngKv/0cCxXdMNwlg24OO4tHLAQFKKus/vhCXRA7OYjkdm5FF71B+XY+CZmEm//tyfnrxF09bZLvcK6FHtbNvutjky6Hw7fNBLgLxhv6I2q4xCHQabeFp3LMIav24oxSnrQFqO2OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QsfT7lts; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQLWdBcZ5S7AEU9FD11Ezh4+56A6Hj99GkldkIB7xUAEhpX/WSb1gN1uP5ORV5lAODD9MpXAUKDz+QyQop4hZ3GlSJnGJ9igknC/+vFxtwqPVHaJrCC6qyLgB5NnCIM9oW23BYjvsp1KE2z10WNv0Fm7PArMYHCDrPm1xcCHjhG1K66dmU62uulcnH5TCMv6TBhGSXwqDOiNymAnS5OroxMRycaftfWq2RIoUR4F70OzF1MSYEG8lZ017q7D3WcBO3VHzzi3BrqlOTTWPN2Q5oprwjZi8vZaUiDwTrxwePutjfDeXV12ylBJtgFqI6GOLSC4NrA9S0wn2m8mv2StPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVHWYqZ2smotaLZUFdYDaLcUzW/hEGrCRxc7IKLHqA4=;
 b=Vy7S0Vwg2R6tNKmO99/HD7xS6NWJP08ecePTxKr7Nn2g8tBdLY69M29a6k509VASNOx0lMsuEjFHyv9CCOFyWn+LzS8GXVng/4E4O+RBdMSei044pWeDJYh3e1N+O6PGRIlG2zOdHNjU6MwJaDYAd9ZuoF7SiFRwl3Z+6kXckaNScWsLZzGTK3OQqjvXprjSVoIc/5HNMSuAcgupuTa3+whazN6w0zaPatfmAmuyOl8oO6+1O71MtjpYC3dgDV6xdULuZcyJgNTv8c/ZGaEQsgycKAmhEKmIkSohipoZEaK1YVwueqlWiwBDM7zf68zBqG9WDY7V8qMe64jTeOnATg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVHWYqZ2smotaLZUFdYDaLcUzW/hEGrCRxc7IKLHqA4=;
 b=QsfT7ltsG1KZE7pbusk8DRcVOpxePAlptpBtHQ5vkYFMh9W8MsoXa6/LrvzLrj7XfKYdOLdVUDDgW4oWwzjWdbSc2ebrhdCpxBJLpB1iQrP0QdbQZp9HklJ7mtZRye/Dn5jEF2TZv4GdJFErIomf3Ue900//KR21tfn6VL7r/rDsPLyKM/975c26kYru0zyhbWu+Kt5cDvh/BgbNZgKR/dtoJX5MkIehtovaB2iZvlOcfV2qP7nOxm5EJQ4nnT9RGb4PxTGCpGzMM9ji/ws7sqyEh3k3tGBZv2H1ZmxtkIpOozExDMPegpA6+wL9c/Cnc1hZQOLafCH7hgdEBShNxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 12:57:25 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 12:57:25 +0000
Date: Thu, 11 Apr 2024 09:57:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, david@fromorbit.com, dan.j.williams@intel.com,
	jhubbard@nvidia.com, rcampbell@nvidia.com, willy@infradead.org,
	linux-fsdevel@vger.kernel.org, jack@suse.cz, djwong@kernel.org,
	hch@lst.de, david@redhat.com, ruansy.fnst@fujitsu.com,
	nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, jglisse@redhat.com
Subject: Re: [RFC 10/10] mm: Remove pXX_devmap
Message-ID: <20240411125723.GT5383@nvidia.com>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <93e3772f172918a3c489d803f7580309c3a42fff.1712796818.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93e3772f172918a3c489d803f7580309c3a42fff.1712796818.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MN2PR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:208:23d::11) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA1PR12MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: 35cb5d5c-f4ec-44b2-fd46-08dc5a26ef38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1OEiS6Mgk7w3I06HFD+VG0rPcIVO+0A1CA8ChGpPtMiL66/taTPvCHJxV8uRJH+WG53FohC1k7u2HUToANg0hfSjwppLLt+rhmVGkxERBCCQTaP0YOdRe6KAQ0eY3jIbbEmmzGXr2EqglwBay5uUKmUQlJ7e3ohZ8VIVdP0Ns5/LqcFaQD7NDfUzQUvflHFpk0ODADzYLECfdOXi1/zxOSUUm3iyrLl0TUOeAbHn0Bn5WtvWircgq6iwyD7PeLaVv7IGZGawX20XNyduHMzdDJ8Ko67zZD+TaMRY6WHy3hIJpWj0mnY2BbXulLHDWGhaykhu8uSR1x9cPL6hMgp5yVLbG85iW6qlybyjTy5rb+7c5CLScTPPBe3OTt44i/LKGuQV1N0tfGXPDv0TQEIF6SivhUB55RHAzrg4VO+v083mR3bToWaijcUk5YpRgf1QuJueEtkriNqDuuMCNw+lHC5I6G0X0vAPXbl86BQif4bcqA3bzlM3pl71R2Dxxsb8C2P4HRK1xnmPm8MWKOavNHroKkZRFqiOCNTNpkF4iNpTFhLZDE7XJEYrxeA7gxMa/cTJAYMnHxXY8kzOlAd4OcCy87v7UxKDN+xECk8yLNGLkOWjjWmTf6/9gJO3pWj/rBPrLw43w/WjzEHu0vkBKXzwEcLskXcXzU8C22BUK3I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f9DbSThLRrgiUx0FUPjzZHQfypbwrg69X1aHOadTnZrsMNZuRP0ZV2nOu49l?=
 =?us-ascii?Q?bLGVgJgTncsXV4Coqf0htqedS3LvCNX1G7g2NRDZoUPyg+P/6F7kOGhAGZvV?=
 =?us-ascii?Q?TR6CM8y6OFdhps7NXBqnLt9mi4paQXGnkFhsq0nlfqesmJraq0r2wNHSVGak?=
 =?us-ascii?Q?+cU44IPq7iQNQxlOLWmWXSTD2D87hzlJn1cgTblT4usrtu3zV2yorqfz09wo?=
 =?us-ascii?Q?Ex/4/1yfMzWt7G5zYgBN509IodOStwIIqBDJtmBFvsaMlZzYCOItlQk2f5A4?=
 =?us-ascii?Q?36m0V8KWgW6KC/7tF/yHccdYqSxOyCzgsCrOk3auuyQqaR+8OLgg0FSRRqIX?=
 =?us-ascii?Q?S2Ic7z4jN5Q8acmNOrLUc5IfV1qrYrRzZhP4209vIpQvWK6izQW0mC4TuDJG?=
 =?us-ascii?Q?PjViD5snXe3FL/M++A8QJyESgdgPB90n1CdazhCwG38VuSN8UR9s69sd2QaY?=
 =?us-ascii?Q?+65FgKEW4cxCl0XtyC0ktBimHu2lMhcHuV6o7ofhsZlQdpRjtR+yPUwL7Mpo?=
 =?us-ascii?Q?K7/xvHpRzv9m77VvVg8MSVHihde9dPeDw4/xywUre8WzXCSvFWX/e0vz7DO4?=
 =?us-ascii?Q?QG5WRxfcP50jb+N9bo1UQwfqXoyucMdooj6zAJab0UfQJbHcoNKyFhjZOlnD?=
 =?us-ascii?Q?tVDla8keWQrMQ2wxuHyhWxzeTHr/FY17oCYS+3jPHxPsfuwueoGqC0btZBDL?=
 =?us-ascii?Q?kZIX26V0eSakPuLJwb+GhLHcANHTDCUOn5fCGWoi/HLETwDQp5dgWykOMHLG?=
 =?us-ascii?Q?/clvT+VdpMQVtARQvfARHM31dF/epreaYp63LzSezQTl+tBuU47DM1Juk8uh?=
 =?us-ascii?Q?7QdRbtwShZCkHdsWir2y/b+NTUDdHJdVK8y2axvpIr544Qgh40MhXFkvU8/P?=
 =?us-ascii?Q?NHxpK1d9olUPl5D/DiONAI7yjZ3zEMeaulQcTdg6wgDjwNCJQiI6MH0evenR?=
 =?us-ascii?Q?vY22VqaEPWcuRCBdHi+Z65hLcyLqWlp2EAhAiWf4EmkVASMBofhqL4fgPIAI?=
 =?us-ascii?Q?FZ2kXn7s9K+ngDVn93jN1uIObLYXr5cSFWXeDtL95bSC3NdvtlWhrgkbSic4?=
 =?us-ascii?Q?jR49850gEaxfH9s2en8DJ7ttHXNbLxXTYNm98Ci1ZxX8ws86KMG4glVcJkJX?=
 =?us-ascii?Q?zancoy1Bo4r4QfPFdZqPemZNdOFGm0JVvGqvDC9F6OpPSQwx9ryYHGMJH6qh?=
 =?us-ascii?Q?i9aGEnYvPzCICre+m6/57s3/CiBviJYyP3Ike7gZyVOgakbB1is+mvLxKp5e?=
 =?us-ascii?Q?AmApNXfNi96g0hOiJc+USlft+EfT7t0YJB2H65wEZWF9dEur6qoYvEvPjd42?=
 =?us-ascii?Q?fE3XqoSW8t7m2C3blVr2YQCbDs4vZJizeR65V8h+vLr5RqNXITWBhXxFyv4y?=
 =?us-ascii?Q?Si+fMxarPhRjY+BYDXSpnq1kpKgP506aqf5+67/mtOXizTvT3OzevPaNskkJ?=
 =?us-ascii?Q?TBZm7LITgD5owDOXgwm4y23KnDl2wh4tVR7+D0447k7mXvKqyvnWexMOexpC?=
 =?us-ascii?Q?RuOLqUY+Sm+rE6NMHk3sGanoMqBEdWO2h8udCealKsAVjlJ9ZD3aw5g+S1Bi?=
 =?us-ascii?Q?J2MfqzIXxio4k8Bi8u6sI4fBpG51lhUtPJbiXWBH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35cb5d5c-f4ec-44b2-fd46-08dc5a26ef38
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 12:57:25.0076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wUFtcUf9WoDwW/GsdClcgjw/pfBxcR1m1bVeBOEF1UPuUmJgXL8CLXynMzY7jrz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520

On Thu, Apr 11, 2024 at 10:57:31AM +1000, Alistair Popple wrote:
> The devmap PTE special bit was used to detect mappings of FS DAX
> pages. This tracking was required to ensure the generic mm did not
> manipulate the page reference counts as FS DAX implemented it's own
> reference counting scheme.
> 
> Now that FS DAX pages have their references counted the same way as
> normal pages this tracking is no longer needed and can be
> removed.
> 
> Almost all existing uses of pmd_devmap() are paired with a check of
> pmd_trans_huge(). As pmd_trans_huge() now returns true for FS DAX pages
> dropping the check in these cases doesn't change anything.
> 
> However care needs to be taken because pmd_trans_huge() also checks that
> a page is not an FS DAX page. This is dealt with either by checking
> !vma_is_dax() or relying on the fact that the page pointer was obtained
> from a page list. This is possible because zone device pages cannot
> appear in any page list due to sharing page->lru with page->pgmap.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  Documentation/mm/arch_pgtable_helpers.rst    |   6 +-
>  arch/arm64/include/asm/pgtable.h             |  24 +---
>  arch/powerpc/include/asm/book3s/64/pgtable.h |  42 +------
>  arch/powerpc/mm/book3s64/hash_pgtable.c      |   3 +-
>  arch/powerpc/mm/book3s64/pgtable.c           |   8 +-
>  arch/powerpc/mm/book3s64/radix_pgtable.c     |   5 +-
>  arch/powerpc/mm/pgtable.c                    |   2 +-
>  arch/x86/include/asm/pgtable.h               |  31 +----
>  fs/dax.c                                     |   5 +-
>  fs/userfaultfd.c                             |   2 +-
>  include/linux/huge_mm.h                      |  10 +-
>  include/linux/mm.h                           |   7 +-
>  include/linux/pgtable.h                      |  17 +--
>  mm/debug_vm_pgtable.c                        |  51 +-------
>  mm/gup.c                                     | 151 +--------------------
>  mm/hmm.c                                     |   5 +-
>  mm/huge_memory.c                             | 100 +-------------
>  mm/khugepaged.c                              |   2 +-
>  mm/mapping_dirty_helpers.c                   |   4 +-
>  mm/memory.c                                  |  25 +---
>  mm/migrate_device.c                          |   2 +-
>  mm/mprotect.c                                |   2 +-
>  mm/mremap.c                                  |   5 +-
>  mm/page_vma_mapped.c                         |   5 +-
>  mm/pgtable-generic.c                         |   7 +-
>  mm/vmscan.c                                  |   5 +-
>  26 files changed, 48 insertions(+), 478 deletions(-)

This is great

I suggest splitting it up into two parts, remove the functional code
in the core mm calling these functions testing and setting pXX_devmap
(and maybe this needs several patches for clarity) and then remove all
the remaining dead code once all the callers are gone.

Jason

