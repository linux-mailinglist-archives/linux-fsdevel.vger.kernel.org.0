Return-Path: <linux-fsdevel+bounces-39238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F18EDA11AE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 08:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC14188A53E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 07:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC5F1DB14D;
	Wed, 15 Jan 2025 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dN68DT1A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8961DB136;
	Wed, 15 Jan 2025 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736926075; cv=fail; b=loe0G4N8zRhqRgSS8D18jwQo4ubkq8sl4JbXtpr2uxF1iGsStfrm45lEamRZBlRbW9IPoq36Wwio7LWt29iGa0yCTqrJe72eytcbkzIdh0Cq3OlutI6MDVOIubu9mEzh5HJD7wuQIMYVJQk5sbvcbbalkRQAwcgFn3e/7nXURb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736926075; c=relaxed/simple;
	bh=N2RlK6DoSWn/fuXoBdO2tjoBnkQODjddLrAyr0j/cGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XhmP9xS+h0LhSxrXhEsxqprpeJz8ovrJVGG75pE0CndWqAl76XTp+KbzEbw8dbILX/3iBDqSRo6wDj6tW9CBzlAzvGVQlUt1sM5BmRmPay3li7oR1JhIljHiqlveUM81MiP6Whk7b2qpRLjSDGA1+6Ucl+P+CKK2aZi2hzowHEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dN68DT1A; arc=fail smtp.client-ip=40.107.212.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjapKr1DXQuNDpdQeFd85RBGtRWLc4bQJnlnwZmsrWdlDB47fJVwUJBa+gkt+3Hit90W0DWbzqnEzkitBN2nRrmp1fL/DMgbUlYdkOt0ZEYSS40csCwlezM5iVMCEj5i6NTMHr1jM5EensHrkUEOLTHNX7K8BkrjZRvCAIrL2JCRm+2IuzSv9mi2EO/Y5TPSGy5UqRuN5LLC7wkwHlProiWPaJKmzN6CTJvRq7EuPHDqKKqK1mokeqzcIkBEPuQHhLGUAtR+q61fmduYxLWCsQY4gghJGPH3ZzegOQZJjMd7BCPTAFM4uhLa8TlHRrSrKBy/qMziulOpdqx+teBcxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A66B9NmFpPa+i1K2eVeyxg7K61LGhvjCg7Pii2OCahA=;
 b=OblIuBQpdOa+7si+klnTE9/iV/9ZS6IFpWaFJH3ELWSWfbz5eHpVUZwF/wpp1mhgY0kmNzuAATinfYe91OXOZx16DwfNVf6ZHrp8wv4Mod8qWtLeQ1U0ZieEqQRdvZzOpgPc5R5CrgRS280ZM2VDHNIdCsYfU3Rm19G1DPRzRQgwJ2qairImBvFTWcrQFFiXIl6HS1eyHbX39rKO0dVCIJfBXV+kNJQxGUZHn2Ynub39T+RIk0C4Vx7uzUXI2toESOUNoNnVEugQAU2PKUdc6iXk/CEUy5QGA2xEkhjdc7Rn4QbcHssPOsZqgbBfMRfesNLeobPUb27e1wFhEwPPGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A66B9NmFpPa+i1K2eVeyxg7K61LGhvjCg7Pii2OCahA=;
 b=dN68DT1A2LRHNnM4NgrhnRsSNyVVYKUsSgBNpC2ltak8i4gaPmepXvtyM7Tps/GgkWmP8luvpENSbRiKY4Dw/VQFHgPDqM4UOtOj7t7ayKVysXdeJnCaAlmLh+T/QvGQGbaFhnNPrqSoPLIhYNvBWoNS89ocN7hCQ+XSd0+NxKUaj6VQk6c7aoPa2ndKyaSSO5Knh4jr/GOk9i3bvUD/pRLkGDSWuHCyV1/hus7xApEIsdeipixFqcuviolclMnb6Gv3UQ60deYpSSHNXONjg2hBxk0bONigBONMC3PJpzEBzBlrgmiGH/JiSXQsVY1mww3ObO0a/v9BXcFlJEodYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB9027.namprd12.prod.outlook.com (2603:10b6:610:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Wed, 15 Jan
 2025 07:27:51 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 07:27:51 +0000
Date: Wed, 15 Jan 2025 18:27:47 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	alison.schofield@intel.com, lina@asahilina.net, zhang.lyra@gmail.com, 
	gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com, dave.jiang@intel.com, 
	logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, 
	catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org, 
	tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, loongarch@lists.linux.dev
Subject: Re: [PATCH v6 23/26] mm: Remove pXX_devmap callers
Message-ID: <af6btaxeeodhvqrmjmdmz7vx2f7fvnavepyhweisagl2boitr6@77pwrvms66hg>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <78cb5dce28a7895cc606e76b8e072efe18e24de1.1736488799.git-series.apopple@nvidia.com>
 <6786b209929e2_20f32945c@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6786b209929e2_20f32945c@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SY5P282CA0035.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:206::18) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: 499a17a3-3a74-4d0e-f99b-08dd35361e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eubJ1UyiaxjPo6M0o0rnpohQdu3B0sGMW1M5PwxswSE/reaXq5EK3DUqQt59?=
 =?us-ascii?Q?OCAtBqsfYss2lUQaiX69dU6UsbUSaK+6daSUgtLWmL4W4ql3R7CwIE0i8JXm?=
 =?us-ascii?Q?b6D1nFc3qsfPyPSv8Xz2MjFBqiUB4axLogEDgKYe5Imo7/3utSLui+GObLHW?=
 =?us-ascii?Q?n9bXdJS8ue5VaQbSpiSh6IlWpPsEFN18pv2PoAo8VdEkvAgDVQATgCXgPK5j?=
 =?us-ascii?Q?Ax+ULVpg4Y2FehWkVeQkm9NKjIxUFKsqBX13gpI6JLUwcppNDup71+sos7jX?=
 =?us-ascii?Q?jDIgbtAyiKTwdd1VPvDuVTY9Kqq/VBbAB8gfl+HqjV0NrLC3UYrWIKskBOHx?=
 =?us-ascii?Q?4T7OxpI+z07ICKJ09cyqQ4gMRWFn1Nxr6Bu2umUOh1/p3oZEKHnr4xpc6508?=
 =?us-ascii?Q?VkYDDNJ/5OrxVVO66b68ZnQGHmndmIFd4fU6UAStmx1d+nynkxzmV1bsFgf6?=
 =?us-ascii?Q?RJJIaJhgykt+53mmOraMo1wb3OwswySLjHu72oZDsibxVQrMH0RJvCcK5SLr?=
 =?us-ascii?Q?5cTbBYKIlHW3pAaq7nVYvm/7ARRIbRCjDUuKa2GWq8mkOxfVJRrSywCGbOhP?=
 =?us-ascii?Q?m96gio7K8kkP0GtzxFVibS/jYVIbMbR5uf9FaWMQiiejffdelQWcbtZOUmrp?=
 =?us-ascii?Q?MQdkwIKLWN/DeIOOB+zLS5UwdQO7z+XmGZ1DPKHrF1HL0V/PlVlD2JCjaT/O?=
 =?us-ascii?Q?OR4Cx9f2mlGyLEfsjR1nSWasa8sZXL794iObhg70t0q6UZsocsY2KFUz0K5g?=
 =?us-ascii?Q?mQw0rcBseHqphGdLI87yEkj4gYZWV6oLwmz1RyLx9h3ReVDCS3KEGKQItyiQ?=
 =?us-ascii?Q?gyeq7bkRKoisIn5f8Rm52Fo+Ek9V/uwHT57Xg/djQRat/oA6mFiPDvaa3Inq?=
 =?us-ascii?Q?jT6AT6ObdJ/DHU9t3T9d+HLKX9EABWEsdFnlBHpSAsnMttzRithDPqalqyck?=
 =?us-ascii?Q?kkPwOcU61qnkovn8sIjCZDNCe9k8gKmphlyQC5RbdQNDP3jIK3NkWXkObUv1?=
 =?us-ascii?Q?GB02c03D4GSY4LHb5+YbZglgaZ6+sUvUIrIQIPhug7uUjS9yrqkSEuzenRdc?=
 =?us-ascii?Q?rdqaXKUk/D3wfqoTyCzvPeMsaq+ImaC2AsR1EjLNmJBy+jpvU4tvUk7Go9v5?=
 =?us-ascii?Q?VP3uJGtH5mt2MmStkZutuBcHrrIX4YoxpbtiWHlLffSyL152Ci1lwek+flE3?=
 =?us-ascii?Q?BX6wGOiIRgcYW1Sds9tCy2iUtOmrBTWADeU0S6phBgeEIHkygt9956T+XNx8?=
 =?us-ascii?Q?WR/XvHWc0eRiUOoZQW8WnUVOnHi6Oham861B74BFMyRb46fXitiElHbworRI?=
 =?us-ascii?Q?kJtCy7Yx7Q7v4WL9iumhc0NPqSabdt3huQFOFK4Q/LXH/dTLLFcc/wOUEvMZ?=
 =?us-ascii?Q?n7gtJIe9qEu8F4sZmBPDrl+Ariir?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zh3rT59aq9AyjW1l8oepqWHAr6Usb74JuFN5W7U14O1ffmmt78jYM8rnUF/0?=
 =?us-ascii?Q?4TODiRay4r/nQ2tZ2oK2kNC33gYM/AMw5cBaHGg/gV2IdE0M8ttEj568Ug3E?=
 =?us-ascii?Q?A0oKH3qiXIxD9jOGyc6VIBQPPckleujeRfZTtN7ZftbTaXUBsMXbJK98UUrY?=
 =?us-ascii?Q?lJLz9keiyQiSqNK01eDCdV92oob6nSfCzyS5npTOKVlwnGSlQY3tWYBITbTO?=
 =?us-ascii?Q?4FDC0u96UxE/6lQvZ/U9uFU9+5bHRfNJBHdSN+dwJROlZeVi2yntthGBd1XN?=
 =?us-ascii?Q?k+dl+G7hNpBKTHuyUOnmAQrocJ3KmUlbupicfH8uTi5NysprGq5ANQDXsLAd?=
 =?us-ascii?Q?QjGFp+Zj83nL0/U5vksib03id66g7YmOKvu1IN9HiwLUkmgG0NTFdrRZ2+7c?=
 =?us-ascii?Q?dEJuwS+ltX6MTrsxpPfDNBeELRqkFejyiWiWsRYBzcKmBotxGB4SSi7dnZ3x?=
 =?us-ascii?Q?QubRShwwdNmtYz9bU3puLDxDhV/DLJc77EFQIzpn5g/FM/aXA/549DsxYyQ3?=
 =?us-ascii?Q?UjE8Z+aUqM5W8YP4sLTq7lkspSYl25olxRoNGy2iE3Azw1u4K9X7AHERS/6l?=
 =?us-ascii?Q?uzNwUFJ9BPGv+Os6AzUxJL3+1evOQ+OJSLH4u7+DA6kRTCI4HCGPhxzovoKT?=
 =?us-ascii?Q?zIlyQQRL35vGGxnqFDI137N5hHnq+ptd4425x1ncWbWRjfXgCoo0effis/iY?=
 =?us-ascii?Q?jHVrVIQ898E3dN2r64im1ClAUuUXYqHs3RB7+kNB33xyt6GNLmyL3XsAR9rj?=
 =?us-ascii?Q?NQAm3MKZZKaQBRP4C0GlnwxzX37oqpGIqLjE8Ltm3ZMgtGzYvg0X2lWNz0x7?=
 =?us-ascii?Q?tCjjx5bojrV4hFA4uUXKfDtq9jqUd14lE1U2CV6Pr6pORkeHXYAGcdbv2R0Y?=
 =?us-ascii?Q?YAh8bNhyKS5Hk7gdTSK7AnmkSZQoUUFRAQibvR87Qmmk8Xm4IoYucoiMAz1C?=
 =?us-ascii?Q?ESyUuVoMGKbm+ftF95xwqUIyZafJwshvpNPfl1/7Px0hFsp99p7PHImyJsix?=
 =?us-ascii?Q?1Bs0PLhqGB21roLbJ3pEy0CsEVVnwoXcXX+/gzUPwFOSct/6W4Zd03w4X/BF?=
 =?us-ascii?Q?cvLvN7ME5FUFo73XmU0D+M2vNgzL5iGbBsnLYCGwz073yAmSG1O24nK6nVVT?=
 =?us-ascii?Q?Vu2UNuP9DJtbWgf5uOC+3TzW3be1YX0uyNNHWkIA7ODLgrblA00WRspGSGlw?=
 =?us-ascii?Q?gatfAV8RAkqZ1zSKHdpGHxTjctf3WM0ntxfU/NVNTt1sGXsjyqGUz+KzZnui?=
 =?us-ascii?Q?J1JHKkEt7FxqGnXuQ7oh1khwIiz+WsvBmSz5xXguNc21hl/+ru4mxEszhzs7?=
 =?us-ascii?Q?0j8WyU/wDb1PPQXz9VimxBc/suSzaQ8Fsl8t39d9ZNNBrqZ/cn7AJlNki2GX?=
 =?us-ascii?Q?cs/f1+QFDm7fEBlgOk5+OO/erfc6WIONVKm2XCopH8RPUT9D584biRC4M9ul?=
 =?us-ascii?Q?JF3f0MscT1Bv9J7w2/a6UJ7ZMo35WdACCnHUZMUNkbu7R07UWtWlyGUyBz8S?=
 =?us-ascii?Q?Aub6GFFn5ot/fCamDv9jMdwJjCBrHRqB57dyNLx1q9xUdWc4mcOyrPgOTzP0?=
 =?us-ascii?Q?dvl1MCkdwk4eG71yy9IpZIAUZ1L1+yl2meFwfqpA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499a17a3-3a74-4d0e-f99b-08dd35361e4e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 07:27:51.0644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9a6/eXqwlZxL+vQodIlvZkNR7JhYeWYDoh6gb8In53v3hKMQrsQWZ3j3prbxMIV9MCRQJsj2mi2vmqjbAulxhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9027

On Tue, Jan 14, 2025 at 10:50:49AM -0800, Dan Williams wrote:
> Alistair Popple wrote:
> > The devmap PTE special bit was used to detect mappings of FS DAX
> > pages. This tracking was required to ensure the generic mm did not
> > manipulate the page reference counts as FS DAX implemented it's own
> > reference counting scheme.
> > 
> > Now that FS DAX pages have their references counted the same way as
> > normal pages this tracking is no longer needed and can be
> > removed.
> > 
> > Almost all existing uses of pmd_devmap() are paired with a check of
> > pmd_trans_huge(). As pmd_trans_huge() now returns true for FS DAX pages
> > dropping the check in these cases doesn't change anything.
> > 
> > However care needs to be taken because pmd_trans_huge() also checks that
> > a page is not an FS DAX page. This is dealt with either by checking
> > !vma_is_dax() or relying on the fact that the page pointer was obtained
> > from a page list. This is possible because zone device pages cannot
> > appear in any page list due to sharing page->lru with page->pgmap.
> 
> While the patch looks straightforward I think part of taking "care" in
> this case is to split it such that any of those careful conversions have
> their own bisect point in the history.
> 
> Perhaps this can move to follow-on series to not blow up the patch count
> of the base series? ...but first want to get your reaction to splitting
> for bisect purposes.

TBH I don't feel too strongly about it - I suppose it would make it easier to
bisect to the specific case we weren't careful enough about. However I think if
a bug is bisected to this particular patch it would be relatively easy based on
the context of the bug to narrow it down to a particular file or two.

I do however feel strongly about whether or not that should be done in a
follow-on series :-)

Rebasing such a large series has already become painful and error prone enough
so if we want to split this change up it will definitely need to be a separate
series done once the rest of this has been merged. So I could be pursaded to
roll this and the pfn_t removal (as that depends on devmap going away) together.

Let me know what you think.

