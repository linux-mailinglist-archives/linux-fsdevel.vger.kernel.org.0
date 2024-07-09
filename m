Return-Path: <linux-fsdevel+bounces-23353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB14392AEFB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 06:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE7C1F22389
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 04:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457F812C53B;
	Tue,  9 Jul 2024 04:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mzzeyy8a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9CE620;
	Tue,  9 Jul 2024 04:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720498525; cv=fail; b=Y703WoVEGtzTBpZN8as+JLsEQ7RNi5GvSYfdR0O5YBOONEuG0mxsQwkOHg2pciM8BYyHll/VdjhU/WY+eNGTZTar9mVhYWqa+Xmc/Wh1Rzyd8oExgS5JlKEKVcziw1jmcUOhGu9GZMh6nQk1Xowm5i9eNJxkJsmzAvyh7Fch8NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720498525; c=relaxed/simple;
	bh=da3TXmrF2wT07A2m4rgRSH2vX2XMWuK8IbiA9iijIgs=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=shSlBzMiVqdOy9ZRremHweawG+0caKFqYykeBKAqySM6Y0vIm1xydT/q27FkHBqGwx1nH8tNGa0cWUPjnrebhTawH4c33Xmqrtkjmqelc/lZCPmsWlUVAxyMoP+z4FU5XCLLFYLMiol5bNEq87n/ZgnHZR/DY3mJMeP8heYB+To=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mzzeyy8a; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WI74JGf1uSwO1QGu+PAY+CRUy6LMQnAVi342cHknl67Zz2r6XJYFbPTg8YZbo9ZvBZ6l0Iz0aeKWjik8Rf/uzLmIdgBbsRicOGJycVqYdH3zjjlfYd0FtsVfD/1lyGYDsgeB4kSkxqSqaGiWzmhOp34H6GlHpk9pp6+T3Ie3CHSbC1GD6zF2W1KDtSSpVsQLn7f4jjwX5gNltMZS21NGi2Gnsb/3yGVgZspdBH2MjiYzyqmWAfvPVJvytgpePoI9JPFiZK05Iyzh+UuCYVjM66bia9nlSfO3h672vkcpBUE23w+01n91eyKRpZ+vYZFkJKYzPUPpyk85+jv5X2cTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJpQ32FMFpHGLNZs2+50f1LMgw7Iy4rRhOXMk7E95dw=;
 b=b/4ClP6tnCGMh3nWhhoxB+ojWyfzLb+4FHgToEsBUluwLUuK5bN2saidqtj0xldVZUsWw85oTLEhqFaHEZaDy7RXG4i7J/rZjo7y3m/KDi8jGmk/MOp6L12pxjdQMeJvvwiJsuJhoOl76CGgRkWkg2J2vu+srfahHF971LC7tKOyA3fObHrQjXmD1PcELc3yjiAUv5mCbIhETr9Oe6yqxcCpAypp251DWFHRZPsE8wYkTlNlDaPI0kJMBBUb6At0QTxwxXwVUeQ3pFqW7nqr0q2ticL6BiiMdi+LTUPoXNhXc15St4hJ8140uMhhdocTp+NJFSISObADc8Pnoo6qCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJpQ32FMFpHGLNZs2+50f1LMgw7Iy4rRhOXMk7E95dw=;
 b=Mzzeyy8a3R9tfvAmseeqSZAGMMGSUkPEDrOCk4apbks7Wig8ewBbg47O5rUoW3bgetawEsZRg1l6ViAE9FxE1vd+khMAW6WifxcY23hphZv+KOHOItspaL2wyFU8n/WLVYt09+s8ahIvAYHTAKr9YC4lgD5CAF9ACuhfJ7Dfy5ILv5bd1Hu6+OAtXEOgvtnpdVr9XgNrGl5gfKiZnJQGmHZOuHvx+srd4Cju7F9I+cY/Yds6iweAqgJcE7gFz9Ad57TF2oKfg9hegIZBx22ujuTL+i+2sQKsaPavBOcnLFyi2bz4fCw7zPfCpokJ0Ezs1Sl7dOLYgREyMn/pWkBtCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.35; Tue, 9 Jul 2024 04:15:19 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%2]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 04:15:18 +0000
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
 <400a4584f6f628998a7093aee49d9f86c592754b.1719386613.git-series.apopple@nvidia.com>
 <ZogCDpfSyCcjVXWH@x1n>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Peter Xu <peterx@redhat.com>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com,
 dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
 jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org,
 mpe@ellerman.id.au, npiggin@gmail.com, dave.hansen@linux.intel.com,
 ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org,
 tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com, Alex Williamson
 <alex.williamson@redhat.com>
Subject: Re: [PATCH 11/13] huge_memory: Remove dead vmf_insert_pXd code
Date: Tue, 09 Jul 2024 14:07:31 +1000
In-reply-to: <ZogCDpfSyCcjVXWH@x1n>
Message-ID: <87zfqrw69i.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0089.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:201::19) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH2PR12MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c06f32-d845-4b64-e016-08dc9fcdbe14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/KqtXncNXswKq8dz6tZVC8OIZJdSdJNugY7sdJfgwAhPRNQihtqM6fx/7X2W?=
 =?us-ascii?Q?f2vneJSLYAZE4goVe2Wls9eNYrU/S9YpnZaSliMC6DgjzyTOBH7tK/CMXpXB?=
 =?us-ascii?Q?WnvCXPaczAB+BiRAoCASMiGKNCbt1nkQC3Hz84vKr/CAxuzSaE+Kkf1PNW4m?=
 =?us-ascii?Q?K2kNrfKfs9QtaY5rI0ftRbGzqwK8gfOI07hEL4fQmS+KaeSZVl8C+HFgzOgi?=
 =?us-ascii?Q?ldJ6+uZs+q7cFaqKkYgmzfZK82sucVKJhlel60up8jFi3Esp+wv5jDmxaNkz?=
 =?us-ascii?Q?ApzF+Dfa8uweZ++b0dOCxmJ8owWvfMHKuS068kcmqts57mKRsNCeGQmpiOPv?=
 =?us-ascii?Q?y4KoeAF3hfa++g8CyXTY324Il7zUBOTMQBJMFBtLqgAnLFtBVK+m6vXkKTON?=
 =?us-ascii?Q?ONyPWJwes/q5QvaDAisxUqUpu1Ms0vqzqdEwzXUAwHrdl4AGnVapMxSYYhNl?=
 =?us-ascii?Q?XGgau8VwCh+TQ6XvTaRiMaPJfDAC0l0aZO3NYeQQeQdMUB6RSB9mI50z5BYc?=
 =?us-ascii?Q?y0cIZR0ZTI05FhFfPRlXvbeUTUb4TXGmQb4g+4Oy+u3ruBNAOUbRPvSdSaf1?=
 =?us-ascii?Q?FMBMP0vKsdup1PruRU+GYd2IO9HKaxN+rpqxYqsDOac2gAyG4C3pGtkYksQS?=
 =?us-ascii?Q?skvo7jYHyNktJbIqHFX2FGAqjYl6+RdwYpyZBgAYIKWtLfqeJbWQfc0CA5B1?=
 =?us-ascii?Q?oyNUxG4zdunNJACPqDEasTvpZC9crq4GB99uUggiEX7RLDFnHWjAGdCz1bHC?=
 =?us-ascii?Q?yh/fhDnRd/uFV07aPj8gi3kC3Nwez0VhXv/SzqryXfELcLjpr9jQ5t7LiUMw?=
 =?us-ascii?Q?mCdkh+kXNVloUHLS9Mlo2i9C1FB37vL+Xl+rHBRsUkNFkOSlTPDxuq6SxkXI?=
 =?us-ascii?Q?ixXf87HwTx36j3q7jC5vUhzxW4pynOnB8UqyvWDXrs+oeTCJZJTTZigi3mJo?=
 =?us-ascii?Q?f78h/FZFoPp+O4NPK/edlLhBZbfqbFG00nJsMK+Zb8EWC4pWIfBU4Hy6YWrr?=
 =?us-ascii?Q?7Ln+0WKCfzI/NPrvhc/ynkJGklu4iTNaWyzJUoLCQn1/d/Q+2zeHBPvwL03k?=
 =?us-ascii?Q?zmTVmQF4Rk3gRsGe6NuUMY6LYxEr0XNsMC9D8QJsriBfnV1Ny2jPbo9Z4A4R?=
 =?us-ascii?Q?oMbo+gKcTVIIbscIZteRmMI1pEnXLdx6MwIrWmiVERzG4VMzAbjOX397iA7I?=
 =?us-ascii?Q?Z/SziTgqsDWaqXO6GXCaa52iGH6ITGu+R6nAyzFPF858pD23yl0g/x36JmL6?=
 =?us-ascii?Q?5dqT9jl1KMUQhAxNKW4cuhKSfGwDBUCoJNQszbcBBjOSwJ1vBK0NrHdn/qZN?=
 =?us-ascii?Q?aLUQdGSOsvkCsoCJxbWJadpj9hCMrJL7k81Dp3uYJ+yRcw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RwhTnUQ3vfGPzBiv3UDrShAD9/YYzhxQJN52lVMLB84KOgdb74dRvL8I9KOU?=
 =?us-ascii?Q?SF5/JOaZMQ3Wfk3/6iI6v1C99MGaVFVteO83CFEat3NwUO22ihGh139P6Xc3?=
 =?us-ascii?Q?ANI9w/XifixVWYRbdJJsb6fzNEdN8uweQBjX/CHszh6NJ6Wb37Fu9jKJ4GhU?=
 =?us-ascii?Q?UK7cUmteMLEMu9Xd8K6/w7kw5sdm9KSSPzKtUxIuXv3hEW1iSvBpVBylLsVt?=
 =?us-ascii?Q?ETIZo+KxOP/jCL2PR0iTKpU3Uy2LO8ojE68BllKw9bvJa+BsMIPOJWY13N1D?=
 =?us-ascii?Q?JRdeiNkAI9ZOZqC/7iDTZUIPEEdiSMFg/lAKXf5fVUOS+TFDvInMQKdYthWn?=
 =?us-ascii?Q?x+kgPOzl43DQ+MXVdgCYN46MOB2xPlMNgncfihcs6StfHH36vLKd7EAqdLi8?=
 =?us-ascii?Q?rp2nKTpDOjrAGfD5dOLL3M8n0YmXpAjlDUPnetfmwXXqCOmXcrdBSlmZqBbd?=
 =?us-ascii?Q?s/w/ttcjUWtcrkQZd7R+OrZm9oVXiWNQ3JR0AdkacP4wHSlPTNb8FhrW3i2F?=
 =?us-ascii?Q?E2kkAQaqZd5sMmDeaoTR8199AJH9BAPzu7gODjrWfOYMFOy/iSvtfLVaX86i?=
 =?us-ascii?Q?avZMluPY0a0RnNq84w4rX1mLR86Z8VisjpmC58U99el2+D4XCv11Nigk079j?=
 =?us-ascii?Q?os5vg0sipHR5a7VFilJ7zFo4oLTvrkgFW87LJF3AEpAy5Hc6i5LoUGAfye+q?=
 =?us-ascii?Q?/7dSjOMVwkD5/a9Lf4pm+zLchr6L2ghl7/8nZE5kxINwOTYCcwgs0ZkT0HxJ?=
 =?us-ascii?Q?mg1lIBXX4Yw2MkhA9S7XtdT416y1nDMg74DL5b0D/Ssp8iIaW/4TyxbSwxS3?=
 =?us-ascii?Q?8DAf9+MVuAkDAIKLI+IKp9vH/fJTizEM8vvi2UWO5HmIyFvhFD4tUAaJ1Xyt?=
 =?us-ascii?Q?/FonYuomE2AgSsQM5XSN6zMgktMBKDxma2Wvgd83nZc7wJKT6iC9D6S0s0/c?=
 =?us-ascii?Q?Ic8w00bdgkl9wJUY36dnk0zugz/nlRW8X2iYZ3He60o/Uz1HxYK1tBcNHxVe?=
 =?us-ascii?Q?wI73sKWQN42m5QBPpWxtLBulgIoRJqndVOd8drUqrOLJBVeLA3etJdD//BTD?=
 =?us-ascii?Q?7V0D2+4iV5pDpapOLawRUI7NeZ2Qb32MpoLV6vNIHXw1ooC039FDvw3inTsb?=
 =?us-ascii?Q?DpTaId0LRQPD/HdRPRmsyzo6+blzJpnEhQZ5zxpU4YeDy+DldjklGjYBi7Y+?=
 =?us-ascii?Q?Ofkvpvf7XBgMJjdeALsPMpKEMG92yNvn2sRKBxTBBge0F3wggReKob4wowsT?=
 =?us-ascii?Q?MYUqVbNIz2gpLYHjUcJOOVX9KJUV8rim+34+A539XueK/WejDDzbZprYaVDi?=
 =?us-ascii?Q?7y0k/wo/hrxW9LiT1VXwsRXiH3v7FHzVfCsq8WY1aGE38T9alVJf0RIRk1EK?=
 =?us-ascii?Q?f73SJU4/rtO+5d8Mv+73s5JIqAmkd7LmiSjMwOHKD2/UCXewsKJ0JhOt1pf6?=
 =?us-ascii?Q?rQMQRnH4DoRnqxfxetS402q7HyAA9j/OeKcR59fKkQuueRuQdOZArL3nVD6b?=
 =?us-ascii?Q?nhUa5EuCkUtiVrCUsst3mamVgmmFb+XMU5DNAJxHNhluNIfLiZuJ4J8xrAGs?=
 =?us-ascii?Q?Xkgt2lZ5Kt4lWpSxIGM2l6WrmRJtqBm1bTrpjLPs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c06f32-d845-4b64-e016-08dc9fcdbe14
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 04:15:18.6781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcjuqAtBP75ly7izmtSUD7FBHGJhXw9TRfoqIc1KQRttqJR7IN5tn5gCYrs00TH3duu9vdS6tsvK8/CPXS3NuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199


Peter Xu <peterx@redhat.com> writes:

> Hi, Alistair,
>
> On Thu, Jun 27, 2024 at 10:54:26AM +1000, Alistair Popple wrote:
>> Now that DAX is managing page reference counts the same as normal
>> pages there are no callers for vmf_insert_pXd functions so remove
>> them.
>> 
>> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>> ---
>>  include/linux/huge_mm.h |   2 +-
>>  mm/huge_memory.c        | 165 +-----------------------------------------
>>  2 files changed, 167 deletions(-)
>> 
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 9207d8e..0fb6bff 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -37,8 +37,6 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>  		    pmd_t *pmd, unsigned long addr, pgprot_t newprot,
>>  		    unsigned long cp_flags);
>>  
>> -vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
>> -vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
>>  vm_fault_t dax_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
>>  vm_fault_t dax_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
>
> There's a plan to support huge pfnmaps in VFIO, which may still make good
> use of these functions.  I think it's fine to remove them but it may mean
> we'll need to add them back when supporting pfnmaps with no memmap.

I'm ok with that. If we need them back in future it shouldn't be too
hard to add them back again. I just couldn't find any callers of them
once DAX stopped using them and the usual policy is to remove unused
functions.

> Is it still possible to make the old API generic to both service the new
> dax refcount plan, but at the meantime working for pfn injections when
> there's no page struct?

I don't think so - this new dax refcount plan relies on having a struct
page to take references on so I don't think it makes much sense to
combine it with something that doesn't have a struct page. It sounds
like the situation is the analogue of vm_insert_page()
vs. vmf_insert_pfn() - it's possible for both to exist but there's not
really anything that can be shared between the two APIs as one has a
page and the other is just a raw PFN.

> Thanks,


