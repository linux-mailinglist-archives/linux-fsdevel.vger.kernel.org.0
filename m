Return-Path: <linux-fsdevel+bounces-23601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A033C92F439
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 04:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5819B28432D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 02:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FCBD529;
	Fri, 12 Jul 2024 02:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kgxI2Z3D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9DBBA41;
	Fri, 12 Jul 2024 02:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720753043; cv=fail; b=EDJV3fQGwNm+J36LOp5tCZfDZpsDSiXfy2Tc3sjLhRDy8/jc+QpdfsuOkBpLbOFLtzGACyfH7Samj51+MskOJs6AcEwpffOlBPry+cn9Jn3L7l6MYP/4cnKaXB3fdL3HD4Z9TSmO7+lEch9QZFnLC9VSehYc92hw/Mxw5oDxdig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720753043; c=relaxed/simple;
	bh=Ixsm6B4C+bc7hgI700WqLD472Yy6ysLOP58lINxADkc=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=qp/9Wr7eTf8jkv7yW5j8LSj97kO7GmywGguL/+4rE+VKhW6Fv0oWxgPgaFKAbIM2g1eC2X4MGQCMTuqG+FI7lXmXPgKfiibJTcpjmi6j5HYMvL2FZ7qKcTBIOrLsb7Yz7IgOPpMN08lmLX8ovL1xbE9XARow3gjwF9MKX6PAK0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kgxI2Z3D; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEengKGlulAiPcctVleZLqRN4HuBF4n0q99p84lRtYAQD+MdMONNONtFO9tL91VwqkwfNdMHifi0zWaQDIbO/q8YO2aArUvxx2tCKT9KDLQTKVjW8iN4OmWFzbHUJjOTZhBWxgNO1ACspXBg1I9BFSTZcpcQCV4SCQxJoOFDTRwLQJun6pFOtwSKEehdWKgyknrwDJEcW+MgEZX/9R2aFQEHut6PQki2LuMDc3MtjRjA4909Q3SpS4ZefTeXl3+jymbPCRsffph4NEwJTu1/It5+bRUxYW8UgiNCza5sVXfQ1EwAR6U0PzSYJZjL2XmtDdKs1u/c06g6/sS3GyEWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZDgUYwcLj4KTqeYki9xIFtWtXWvuNOu8Iq63IYvC4g=;
 b=iSHD1djpWo4JluB0K3kngvAkcCnDKhp8+ww7SLLLB5Vxb2o1ERhUsdQPpS7wsl9W1aICWjmSIGHiOP58bqB2NjQAw0uzYU3aBysAQcLkN7F4blzw1/xIcG2SQsJMdZlvYkieE0jN7Ekrp+gqCHaZDOuV6HSXIRa1UIL+ntHOlIJRATxYsGhud4TFZY2/WpIz3pisFOxnnljt3KIuSTFXv183Rl748++TwTlj6DU+eNrZt5/FY4QxAo5gH9Y9kr1kibZmLY++AKoujJ7tVNo3in0AMYosoc6ldKMN6g7rl/37qynjjZI58WTL7ebSKme1lB7ZFq4bSEuBAQ6LePHQgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZDgUYwcLj4KTqeYki9xIFtWtXWvuNOu8Iq63IYvC4g=;
 b=kgxI2Z3DV7DTyaqabop893MqrrlQwa+D7r53Y2BqmDScqsEdrOzmAC9AnVr5AEgHJKZI8DwTfjAq21vi4YBZqlcSsEs+ujsgiVaUCouZAlL1g1B0f8Tc4es3nScXi0v+izve4BG0AEH+arg4VyM/d5Bwsk7obtYgyHkwSTz0FNPA+hBAg/rvuSdQ/mwyZlwUmyBY0YoRk6PBWyT601bUlErvWUesigr6NLdXzwKspgCnxeVou3c7uHZsk05VcG68OMmV3JBsWtBYa8/8fWvGhv9MXB7kqP+042NDkH40W6wp0jt1orqwr3eFFl0bRW9dlNovFMZjrezKn9LbreT2zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Fri, 12 Jul
 2024 02:57:18 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%2]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 02:57:18 +0000
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
 <400a4584f6f628998a7093aee49d9f86c592754b.1719386613.git-series.apopple@nvidia.com>
 <ZogCDpfSyCcjVXWH@x1n> <87zfqrw69i.fsf@nvdebian.thelocal>
 <Zo1dqTPLn_gosrSO@x1n>
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
Date: Fri, 12 Jul 2024 12:40:39 +1000
In-reply-to: <Zo1dqTPLn_gosrSO@x1n>
Message-ID: <87sewf48s6.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0140.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:205::16) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b9b0fbe-f440-496b-3a5d-08dca21e5775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YXSHomOL9R3zN5UMsAXBlzsyDK1/0vOcMRpuYuJvDQeQ3Yn+xovbMIVWLIv6?=
 =?us-ascii?Q?Sh7kGA77t7dn0LpsnXiVBs2bUkgAKU22D9n+13JEAc+1ILrLTsq81AsvWzU6?=
 =?us-ascii?Q?ZLQjy377CmCuxZTOp3JktXerxUIXNfTWAZV2IRMCO5xmtlEuImwmlRRIGynQ?=
 =?us-ascii?Q?0swzN/V32bbP9dp7kvcx5GponB7V55xl/uJAm3ofbodvfsW13+8l0DnGYHIb?=
 =?us-ascii?Q?x1/ZebZrHklnx5UaFQbvC5p16tjoBTGMDPCCHELilAZoCXMiZDwIg/mjG/Yb?=
 =?us-ascii?Q?3CUmz3VAxvT4GwFFXF8FR8SdUiKXfnjQYelBKhY+Mc+K+WjGmdeZO46q/eBp?=
 =?us-ascii?Q?+uoWcdCEqC3pKbwZT8k1Z2bbkSdYDjvSW+asgxCJo/w+UqawjnhWmo+3eXJV?=
 =?us-ascii?Q?yGeiHoadvp280PKkk9FqGcCQ6bZvFk7LA3OWh6R3k8IRyjVRmCBcBjlmb4Ku?=
 =?us-ascii?Q?QuFhj2rONBkz15GYHF3u+OxT5+LewX6ctRJXlY+d7unqZMfWG3ysqRN2rSMc?=
 =?us-ascii?Q?a8ew7r9BkHeBstuE5pNYNkv3geeAdKu3ZiNzORyB8ZaBWRaO5wMxvLw01OCl?=
 =?us-ascii?Q?ww2wr7qu6PFak80oBAjcDq3Ym6XOAEY7qukMa3yTgPSVlXrR3VL2bV06Zz26?=
 =?us-ascii?Q?Ex0RglrPYPwr/ONYKeq7/3SJ3eZV3mRr8/lHqoDG6OxgaTjjMno2raRnnlHg?=
 =?us-ascii?Q?HZbbFSPe8/rUZdpw7n/3s3Av1KWA2gLli4J8+RxO6P9Am475bIc4C7hJGM22?=
 =?us-ascii?Q?zEC+RkNbavvZAvrH0ietWeYHVUvZ8PDtfJFvTpJb7sLA93igE22LFu4jhUe4?=
 =?us-ascii?Q?VLI7Q+pqLEtqZoCkvyGkmmPgnuaNOBg+OlinBQwzItd3/BY54/SPLybCWA0I?=
 =?us-ascii?Q?CihXAwd0Tz78GNnqrXutH6bu0fxBJHwTnurUvaIAmPu+EB5C0uLPAnqIKiNq?=
 =?us-ascii?Q?uR/DURP65sJuSiLdDgJ0v/yy8WqcuokmAcdAgVQ87IDYxnUPuFiS1OOQVzVS?=
 =?us-ascii?Q?zJnM85/J8I8jp71zuDj36GN8+dG1xz67ma0vwH9mgvpalorN+W3oPrPENz5y?=
 =?us-ascii?Q?4pDuQxPEV3m6AcOplzPNDtrNDIcSiy17a2dM6u1IMVh23xJ0E7BK4J/aR9PW?=
 =?us-ascii?Q?OoccZo4ASXx769lP66i2czgX1zaQRB4XUEXeeAJ0QOvupo8LwsmsWvgUNzRZ?=
 =?us-ascii?Q?Tzy4B0EX83941a4HsrrXBfLOpbX0ULDCtFVfujtWMcDfufAXLt/NAd54up0C?=
 =?us-ascii?Q?UotDbQTFa1pxtzexiJ0MoxCJzW2SHIrXhPHihD4gMWwJN+PblTKj+1fctnAQ?=
 =?us-ascii?Q?A8D2fAetx34DtnvozhOaQc++t1AVNwwjCXpvzLqY38FaqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vgtA6iMvqgnAKqilLOMHC+keCd1WuJFIumGppKiWAI7rrrOYPC1DLGGDJ54G?=
 =?us-ascii?Q?9blzK9724yhyk2Lzp298/RIZCSbH5y1TiUAEBjoTzThECaknKb20UmOIfImx?=
 =?us-ascii?Q?62vz9YrU6JyQ7Pt/UW9cN8myt8hpf/awr6iiejLev3FHdr2YvZqcpanD+fWX?=
 =?us-ascii?Q?8toDB2kHgxq+x4cSp1QlDWlOOEskQJ2AjNmzXTkZZGMmhmXNk9vAwwywzPlg?=
 =?us-ascii?Q?dMgHEmTPRGcM1SKaYCqulIhZvsQc4wjXGmLRIHkdJToODM7UI00mB4ummQWU?=
 =?us-ascii?Q?B/a/C096lZUlEDvoSL4PfiX2LkiAN+sof213ah/VRupjyXbOGha0PZ4O+/51?=
 =?us-ascii?Q?mN9EAYvVRiqcOFMp27FvttYaX2zjaSenb5yHIZYRXee1T2MNL9HXP6j+gbgt?=
 =?us-ascii?Q?k+vO7K4iaw7OD+tDTWxtxiQl8QkIMrB8q8yK7jfHBRRTFW9m7vimS8mZswWW?=
 =?us-ascii?Q?wEBVo55cLc9kAh7pi5tbddxKxSI7XVtYbikVLJYUhhNy/dMP+r8hWE8FMTRT?=
 =?us-ascii?Q?55d7CDsJBq7+JPTWHveIf133b0qvS5eTcLD+WQzHnhK5mtcczFfD8PjeHhC3?=
 =?us-ascii?Q?mfzWV+df/RoQWW3GbqhdYEGjV+YrMGz561RO44TKw0YDFCjU1oDQj7BCyVS2?=
 =?us-ascii?Q?HJgYHO/27i2eciyi7PoTYXWSR4tWm9Idyny6iy4OywMkRNxZtqjIOsTnwGTe?=
 =?us-ascii?Q?pHrxcUF2GiI6MhzjHqlJX6X8OGtw44DJ678gxIjRdUXlCu8/pUek9kQn7v6P?=
 =?us-ascii?Q?myLwX3PI0R/koeTTMe0wApEw3mBu5TkVZwhYOvzK8Pq/VawsLlz8OTypF3SC?=
 =?us-ascii?Q?y7UVsTMtmQb2eaF3kxQmJgSGBuWRb/uzPLIXXHDI2WtxcVSvbZ+WLMlEFuix?=
 =?us-ascii?Q?7vqZkrjkkTGmTld7IrFfLotX//HdYnHw3vFyr5DU55HY/KWmc8O8LK3YIdfx?=
 =?us-ascii?Q?v+lc+cH6M+CdWM2iWNUsZVSUo0K8qjong9Pj3LYvFjHQvupafNj4NKiAim3A?=
 =?us-ascii?Q?8B8Nz2Z2Iq/VUyyCZdIx+EGG0TfxQ/2Rv2jC3QUmMXe3K75ZPiriFgdAf79j?=
 =?us-ascii?Q?sRWVOYOR0IgdKOWGYuUMsKLFPLwgxw426SNFI3B/314AnXKIirwd0PNSN6kX?=
 =?us-ascii?Q?1UdWgo3xsmDKpj0hnnVqopfjB9YGqxBTucz3oGrTwXg+0Qwtc4F04NvneDxB?=
 =?us-ascii?Q?66F+Hhc+I1QWe8lro4grbFOu8PmxsaATM85cOTZBmKIegRRG5xrDkOtr2M6A?=
 =?us-ascii?Q?ExVZEDh4JKdBJx1f2O3hKMoECV10ABjqszPGIEx/yAr/edicX9G/JRTWMJtf?=
 =?us-ascii?Q?VSu95kY6Br0iEFkFvUndI+5aloLbtnmVmSZ2obrMNUu1POJMFv5dMMN4U0JL?=
 =?us-ascii?Q?uVrj01QC+YBtOZ525ZHWbI7UegZfhAYx3bVWmnQXPUj3sJyd2wnaE6SpyNJq?=
 =?us-ascii?Q?nRelLlQ8QoXiS8866M6jWl8UopG9XycfqX8YjoFNlsWpOe9HvsGL6oaTkv/T?=
 =?us-ascii?Q?7QGW4YrWeSKqrHNUHNKgSqsrEhJWnLUoK2IlPFPEkpB3fQdwZvGY3IO9YJJ/?=
 =?us-ascii?Q?auQW2S0HbVEzblznM67x/kvx7Ny0R4NC20KtUu0p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9b0fbe-f440-496b-3a5d-08dca21e5775
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 02:57:18.2893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlDee7WbkxGPuO4R3/88Yk1r43LvWGYanshUDQoQB3H6ip3n80+MRLsNwV9XiS83NYyzmcgNwKNIhMIeS1foSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341


Peter Xu <peterx@redhat.com> writes:

> On Tue, Jul 09, 2024 at 02:07:31PM +1000, Alistair Popple wrote:
>> 
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > Hi, Alistair,
>> >
>> > On Thu, Jun 27, 2024 at 10:54:26AM +1000, Alistair Popple wrote:
>> >> Now that DAX is managing page reference counts the same as normal
>> >> pages there are no callers for vmf_insert_pXd functions so remove
>> >> them.
>> >> 
>> >> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>> >> ---
>> >>  include/linux/huge_mm.h |   2 +-
>> >>  mm/huge_memory.c        | 165 +-----------------------------------------
>> >>  2 files changed, 167 deletions(-)
>> >> 
>> >> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> >> index 9207d8e..0fb6bff 100644
>> >> --- a/include/linux/huge_mm.h
>> >> +++ b/include/linux/huge_mm.h
>> >> @@ -37,8 +37,6 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>> >>  		    pmd_t *pmd, unsigned long addr, pgprot_t newprot,
>> >>  		    unsigned long cp_flags);
>> >>  
>> >> -vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
>> >> -vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
>> >>  vm_fault_t dax_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
>> >>  vm_fault_t dax_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
>> >
>> > There's a plan to support huge pfnmaps in VFIO, which may still make good
>> > use of these functions.  I think it's fine to remove them but it may mean
>> > we'll need to add them back when supporting pfnmaps with no memmap.
>> 
>> I'm ok with that. If we need them back in future it shouldn't be too
>> hard to add them back again. I just couldn't find any callers of them
>> once DAX stopped using them and the usual policy is to remove unused
>> functions.
>
> True.  Currently the pmd/pud helpers are only used in dax.
>
>> 
>> > Is it still possible to make the old API generic to both service the new
>> > dax refcount plan, but at the meantime working for pfn injections when
>> > there's no page struct?
>> 
>> I don't think so - this new dax refcount plan relies on having a struct
>> page to take references on so I don't think it makes much sense to
>> combine it with something that doesn't have a struct page. It sounds
>> like the situation is the analogue of vm_insert_page()
>> vs. vmf_insert_pfn() - it's possible for both to exist but there's not
>> really anything that can be shared between the two APIs as one has a
>> page and the other is just a raw PFN.
>
> I still think most of the codes should be shared on e.g. most of sanity
> checks, pgtable injections, pgtable deposits (for pmd) and so on.

Yeah, it was mostly the BUG_ON's that weren't applicable once pXd_devmap
went away.

> To be explicit, I wonder whether something like below diff would be
> applicable on top of the patch "huge_memory: Allow mappings of PMD sized
> pages" in this series, which introduced dax_insert_pfn_pmd() for dax:
>
> $ diff origin new
> 1c1
> < vm_fault_t dax_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
> ---
>> vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
> 55,58c55,60
> <       folio = page_folio(page);
> <       folio_get(folio);
> <       folio_add_file_rmap_pmd(folio, page, vma);
> <       add_mm_counter(mm, mm_counter_file(folio), HPAGE_PMD_NR);
> ---
>>         if (page) {
>>                 folio = page_folio(page);
>>                 folio_get(folio);
>>                 folio_add_file_rmap_pmd(folio, page, vma);
>>                 add_mm_counter(mm, mm_counter_file(folio), HPAGE_PMD_NR);
>>         }

We get the page from calling pfn_t_to_page(pfn). This is safe for the
DAX case but is it safe to use a page returned by this more generally?

From an API perspective it would make more sense for the DAX code to
pass the page rather than the pfn. I didn't do that because device DAX
just had the PFN and this was DAX-specific code. But if we want to make
it generic I'd rather have callers pass the page in.

Of course that probably doesn't help you, because then the call would be
vmf_insert_page_pmd() rather than a raw pfn, but as you point out there
might be some common code we could share.

>
> As most of the rest look very similar to what pfn injections would need..
> and in the PoC of ours we're using vmf_insert_pfn_pmd/pud().

Do you have the PoC posted anywhere so I can get an understanding of how
this might be used?

> That also reminds me on whether it'll be easier to implement the new dax
> support for page struct on top of vmf_insert_pfn_pmd/pud, rather than
> removing the 1st then adding the new one.  Maybe it'll reduce code churns,
> and would that also make reviews easier?

Yeah, that's a good observation. I think it was just a quirk of how I
was developing this and also not caring about the PFN case so I'll see
what that looks like.

> It's also possible I missed something important so the old function must be
> removed.
>
> Thanks,


