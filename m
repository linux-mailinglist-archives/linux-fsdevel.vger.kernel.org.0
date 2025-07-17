Return-Path: <linux-fsdevel+bounces-55215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D434DB08806
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 10:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A59F4A5158
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 08:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C216227AC41;
	Thu, 17 Jul 2025 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="savuiPVu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786081B425C;
	Thu, 17 Jul 2025 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752741527; cv=fail; b=ZBaH1y5lRkx+Ff3A1VQ+bNpfGgcSSdkP+N3cxKwSow1jssA4kx1sjqnjOlAIrm3M/JBg/YFbemlPfXnukqElHnjcHuMAZVlqLXSJDowWWZEzB3s+xtFuGW/cYpQButh5vdimTUeSpFXPq8gK3ggw5DjKOHtOGzuGfEbr1s3zK40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752741527; c=relaxed/simple;
	bh=SgHsUWmI5t5tmuABUzbzFTSUtmxGgv14n2b5VP56YZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qs0HuryOhuWve36nnAUMGEqHB+ZhM59v0CbuPTaWgXMBsSbmAUYGAdl7D1hvLC4YCxz6xdVTu+yVY22wMWaVLe31M6HxZLBsGNgCTVOYGUA00L8Il7rya51U4ix/LbwX5uC/orfgJVwA+ky72JAdcrT/TpgoRx1oaFClb/Zb1E4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=savuiPVu; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0D+EhujCq2Rs6QWQc+Hx91gKjOa9ElWTeKmY+FfoA7NTa0mi81C2KM9+lN0JejAXtDF9R/DoU6WYQfVFDEyU8Rxz9XB3YGoKGknxRj3VOBulCcpiahY159zXnJMD3+bTgTTgKw36XGwKaeU7cOrDnB1hBqVOBIRYQEAc3BjQwSq5wZ+jmg0fc1XPDDKwA2bRqZxP3jUhBvKRoZL8S3rLAA3UmsMDFHXU21HWOV5uSAvFPuiWMXvkjlX0NYXXbnoNUlaFYUhSkyqVIj8A08PJ+oJloUP+xRx6XJ8F6bXpeHJxUHdGwrVj9adZ61IEfAQuKpECSDV/LI2UW9B8xdDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQi9He8XVkJej9/b4Ng8MPhEEKpfWLON3bRlvZUWyIM=;
 b=c3cixuveHLuqVshk6cyb1J/EDgaG7qh75DkkYIOV8/9HfcIL2vdOAjlxz2HL0TogmbmZXVHyomD5Q+zbvcdqNpKDLqACy612ZS0nL2ybGQcp/BDna2sTmVmTweO0y54MKBcMpPcWGx5XIf749OlegqXNdKlZfeFoTF6f/aIWCYb506xB5fyUPrM7KDcoqBOzNdjD7BArapIIE16oHji+rBQXZsiLbFy06xpbZRCxdLxjSPnk/wEphB/YTPqvfm+rZLAPhcu9ZLVLjEdVaQU1lk4XEmK4CA7hT87JWvV5Awt0Yif3Bo0uuz/ejs8ZM/Elr9vZRHVDiYliGyT4eyIcFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQi9He8XVkJej9/b4Ng8MPhEEKpfWLON3bRlvZUWyIM=;
 b=savuiPVuBXg6eAP/8t0Hvj1ldey6WsTaAQVnes18E5pWqpx1Vijmqc4qVpLGC54tvAsN10hEyoW5DqAUe0uqxKsQ5WiumdlxXTchHNyszxSg8TwYDlwVcY2jPmJJ4n4AJ5Wk/jJ5HcUul0GvTHExg8Cpog5QSH3AS+HWYE6VvAJzSPePkMJuu+KOGddioxLeIAJ7P46LZK0ntwSWk5WxDkTV72/5CXlnQPT/KcapbfbF+C+Z4LmF52VFHzloN9Z+v2nRT3cpc7SfM/VURwA0KsqrFfS9ZX69ev2XIj2hOWH4obrQN3x3WuEeL77rNXtgfHs/Yc9XRsFb+DXv1lSYTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB7989.namprd12.prod.outlook.com (2603:10b6:a03:4c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.37; Thu, 17 Jul
 2025 08:38:41 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 08:38:40 +0000
Date: Thu, 17 Jul 2025 18:38:35 +1000
From: Alistair Popple <apopple@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
	Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>, 
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v1 4/9] fs/dax: use vmf_insert_folio_pmd() to insert the
 huge zero folio
Message-ID: <x32buctb6cdgr7kfwd54blmcqs6d3ixpsujx2qlde2cf6ziayu@mrltytvzg54p>
References: <20250715132350.2448901-1-david@redhat.com>
 <20250715132350.2448901-5-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715132350.2448901-5-david@redhat.com>
X-ClientProxiedBy: SYBPR01CA0120.ausprd01.prod.outlook.com
 (2603:10c6:10:1::36) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 67b9e4c6-3a6d-48a1-7418-08ddc50d545e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eGTJ0d6S9CoEJ39Sy40OpPMZAxB/s8aNdSpaxzaOw7MVgZqmffzPInjmKCgx?=
 =?us-ascii?Q?IxDyj/8fu1vYjPAf5OYfT2gVPsqKA0GRpOq57/ziI0T7xwPziq/cMlmbDbTN?=
 =?us-ascii?Q?davgS0jpA6ASXK+xFE6KvYwo89d60Izaf87iqcLrbOG7cUKtIGTLL9Os2y/h?=
 =?us-ascii?Q?xGN7ANIOofw5JwpCOeuYugFlb2Qo0xrotVy4+ovrNPBSV55JIz0Dgw/JF3V6?=
 =?us-ascii?Q?6ndFcTQs+CPaiMKZZ0YicBIogfZVa149ovPc9Ui7vjI7Jwxir9aO4OIqYaak?=
 =?us-ascii?Q?Y6PrIKKxIy67eXjq33rkPDss+c7bRwi3mIdqCCQUit/1lPX2H1/O2Yd7ylhg?=
 =?us-ascii?Q?aOUDcdLOKDlos2JwO5dC6kP3xIc0oCpQeVrJG6wWlZLkaQcM09Rmf6KnpGiS?=
 =?us-ascii?Q?vCTp3QAvVhk4BSLT1uWsTSw+DAPmgDdaBF//nRl6RWq10t/ufSXHvCRJgMA9?=
 =?us-ascii?Q?Ahk1TdhCVE3Js0cE5fhlGJJ4Gcf0l12PHHE0H0RY7BpyPgze68DIgWhZDYwP?=
 =?us-ascii?Q?1TGbQ89Y9M++17gTNFdwe3am6v7i7NEku5d9K8QkXYRdAe5VXGcE5LPsIryX?=
 =?us-ascii?Q?Vw+J4wylTpFHceYwbgRLOVBrf6eWL5ISBqvYf3Lkz4O8KpMyULLdc4YQYgvZ?=
 =?us-ascii?Q?heDfZRikcPuL5QjvYEQm3rsPiozLS8lijxcAjdReAmNMQB4ZYfIlmXuKLj6b?=
 =?us-ascii?Q?KHqnEmeYOF8azPiqMoETBeRMBQvaEhZ1wja7KmEs2pIu1dEIX78rc4D3iL6G?=
 =?us-ascii?Q?d7pMVzn2XHMO3fC3076gcV6lg5i99gBWx1ziT6DP7MTwReUMZ0dRtY8ohqlQ?=
 =?us-ascii?Q?XjTXAzhZLLow/Nna6bhr/B8zrped0rZNP/lc+Qu4O86EA36XOXRy+IvFKmOb?=
 =?us-ascii?Q?gXkbliWY8NObo7IcqKfH6/KDqdBaQcJLbKM0V1IqJ6FqR8eYFe34kuRn8/P8?=
 =?us-ascii?Q?UUsVKY/l5areunH8VeC15n95vQ0DkqCw09gL840WCRHwOUEddFbqM5HxFY9B?=
 =?us-ascii?Q?dKlqtlXnqa1o/C2TEn4I+gtqJ15cVFF5HxxWi5ehea+2UOXpaUx7PGA31ahZ?=
 =?us-ascii?Q?t+jAiIGlc3jU66KHSYw/Vp4vjyTNA+s81O+6HifRrrgoovkyqiatqIaiBhLa?=
 =?us-ascii?Q?MOxTjOtin5tzCX5SxBYl0ee4ctryMSkID5dS44BDO0TJt1P8fr0ODKdLoZ1t?=
 =?us-ascii?Q?0FB1O4mjixbmn9DGw3GzX1NFzbrzDIF6oYGgoSmQCaBRTCROWlV54OZwEMxM?=
 =?us-ascii?Q?N0bq+IMOtl1JwEynJm1kNBOltQ3CA6Nrts7Fpw6H3gGb+3ClRdYiUmMgYxbr?=
 =?us-ascii?Q?FArWTlRAlM4D4ysVb4Ak0D0+aUD0m4SSbhXTSrushDm9hkC9x/EEBrFd0uY2?=
 =?us-ascii?Q?MMtlhPDV7UOUQfCH+wW2PIrPPqPwExykpRfuxvrGG+7oSdbQLZGuwz/HIkFj?=
 =?us-ascii?Q?EyFIwvCZB4s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uTXM/Bal4Y6zMhRHiow2qgjL747XeOSpLz3r4z2vQLHcNbcggcwjaicwtWAV?=
 =?us-ascii?Q?UDY7mVOe3PFO+zBMCHQ8aPhSXDvr2T7W4EvCElAl46lkJ2U/1NKjs1LAg4Hf?=
 =?us-ascii?Q?pNB/upCW33SVtETpo05hcuQc9izfZsB6ywR5GZkv6KBP7JGxxbTIpgJMmgMv?=
 =?us-ascii?Q?T1wuPuBQdZcnPiz/CNbxeyZ9F/oc/1+N+wPnjhFvNjYyxYQGTEo5SavYHPUJ?=
 =?us-ascii?Q?alveoh5JjGaTNP7R1g0i+qXE9v72krNOD6hFG2l5YhnkzDXmL3aQC1/PJYvi?=
 =?us-ascii?Q?uaNL81IhbebckAJ+A3Deojacm6RoFKrqL+Ci3Tq+rAomfURykFcaM+z9tGtc?=
 =?us-ascii?Q?vSzu8JUMYxcTXfINOGRqTpy/xfNztjMcRv8N6VYwhCJv46hnVAnhXgylUd/M?=
 =?us-ascii?Q?CfOp762ffDACN9myhQ6YrCjLA6AGNj+j7is5hXF49I44GVqgZEIMrqFxf/JA?=
 =?us-ascii?Q?XoJqzE0ps3v/iCCcXvyiRzZwM0q/KgX9d0EQ54vieSiSBbT276CjHNgfWGDM?=
 =?us-ascii?Q?u+b4cot3owNHADT5BGjshxUv57Rnz65VzaTqSMyaAuo5+7vVV1lY2bfLdeJq?=
 =?us-ascii?Q?UJ6/wqoVsOorTfuhmOM2czFVmju+Soi7ET337x6FK+x6+G3bj/3+x7oHY0YT?=
 =?us-ascii?Q?oGd/UhpUR63U3HRKGcJTQLs5zs6644sFFk2h4rMb+2Ei+vj/m1r1erRVRD5C?=
 =?us-ascii?Q?JovcEUntf8FIWGDR+ShZfm9rraGXZzxxHSLA84WpipXjrCfJqHDxuVwhaqYS?=
 =?us-ascii?Q?caQ8nA2noQMw8kIgr/5JNDlvshMT//DqP/KMX1c0q7l7VbEo6DPGmBI4CP+B?=
 =?us-ascii?Q?m87yNcoYus6ThjcuAewyIX1hd6VrR3h4RgaPQ6+fYWICy8G2fRjYH8tvX8Gf?=
 =?us-ascii?Q?GH9ezYmAZqE2yWch1HKUfHFSlZ0iDZ+yn9bQ+Us0RCJcKfSoAOl50xpubxiD?=
 =?us-ascii?Q?Lh1sV4wMvq3u89wm9xapUrFm95riJG4mab6md+sVfNNgXsKabdNXiA6p6us3?=
 =?us-ascii?Q?yuEiWod/s2Hrn0Vfoj+J8DafIaxpBOknqCm9UpYYvtt+rVqtHNazt6JO+FA4?=
 =?us-ascii?Q?3I1pBsLLy/RiOX+CCeeaytISH/fcK2NwNPah88IbrycexMJTsZz1HmDbt8Ow?=
 =?us-ascii?Q?trWAkxM8LZotR6VmPiuaqOTmeH6iW9mpx6jQShQz5k4Z08xw/6Avp6EkAUQy?=
 =?us-ascii?Q?YCeexlswYNmIvTCvphMGdvcRneicnqeEyiC9Qb8IJEoZvArGHtxpR6chUaYv?=
 =?us-ascii?Q?g8t0GvB9e2JCaG69NIEXXpTgSdkbEMG/A8y0NaRUhuYLwum0C0lw5+/wdJuv?=
 =?us-ascii?Q?nEkmH1zcIGH12LcEE7ggImy+/4BkYBFZ4SW5ggkmHVzJ2IwAjCobeYJof1yY?=
 =?us-ascii?Q?zYWzjU4PDTFxoIZTKd2XmzzQS4/xeQmB1tfqU0tR3mm1Sl3drGU8TkTnhOH/?=
 =?us-ascii?Q?IfriDAiKzyam2sepUxW+JbGnzluMf1ldD8358I5lY/GA3fASD/pRV7tTA21E?=
 =?us-ascii?Q?7ENKH03iKWGcXAVWTa9qYHNRnZy+KFDLlAaNdYi70k1515bdxqy+mU+bkTC9?=
 =?us-ascii?Q?6g2njDTG7UpMSlJkqJ51XPH979sLWvm5xnXZOCf3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b9e4c6-3a6d-48a1-7418-08ddc50d545e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 08:38:40.1387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EyNe9zIvcfLiegqn04MDXvjwKH7Ma8b9Ac8wNsZjz5IjbpYKhzDzaWPc7OMq06ZEqBWankCpVepIdz3FtdKOBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7989

On Tue, Jul 15, 2025 at 03:23:45PM +0200, David Hildenbrand wrote:
> Let's convert to vmf_insert_folio_pmd().
> 
> There is a theoretical change in behavior: in the unlikely case there is
> already something mapped, we'll now still call trace_dax_pmd_load_hole()
> and return VM_FAULT_NOPAGE.
> 
> Previously, we would have returned VM_FAULT_FALLBACK, and the caller
> would have zapped the PMD to try a PTE fault.
> 
> However, that behavior was different to other PTE+PMD faults, when there
> would already be something mapped, and it's not even clear if it could
> be triggered.
> 
> Assuming the huge zero folio is already mapped, all good, no need to
> fallback to PTEs.
> 
> Assuming there is already a leaf page table ... the behavior would be
> just like when trying to insert a PMD mapping a folio through
> dax_fault_iter()->vmf_insert_folio_pmd().
> 
> Assuming there is already something else mapped as PMD? It sounds like
> a BUG, and the behavior would be just like when trying to insert a PMD
> mapping a folio through dax_fault_iter()->vmf_insert_folio_pmd().
> 
> So, it sounds reasonable to not handle huge zero folios differently
> to inserting PMDs mapping folios when there already is something mapped.

Yeah, this all sounds reasonable and I was never able to hit this path with the
RFC version of this series anyway. So I suspect it really is impossible to hit
and therefore any change is theoretical.

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  fs/dax.c | 47 ++++++++++-------------------------------------
>  1 file changed, 10 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 4229513806bea..ae90706674a3f 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1375,51 +1375,24 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>  		const struct iomap_iter *iter, void **entry)
>  {
>  	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> -	unsigned long pmd_addr = vmf->address & PMD_MASK;
> -	struct vm_area_struct *vma = vmf->vma;
>  	struct inode *inode = mapping->host;
> -	pgtable_t pgtable = NULL;
>  	struct folio *zero_folio;
> -	spinlock_t *ptl;
> -	pmd_t pmd_entry;
> -	unsigned long pfn;
> +	vm_fault_t ret;
>  
>  	zero_folio = mm_get_huge_zero_folio(vmf->vma->vm_mm);
>  
> -	if (unlikely(!zero_folio))
> -		goto fallback;
> -
> -	pfn = page_to_pfn(&zero_folio->page);
> -	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn,
> -				  DAX_PMD | DAX_ZERO_PAGE);
> -
> -	if (arch_needs_pgtable_deposit()) {
> -		pgtable = pte_alloc_one(vma->vm_mm);
> -		if (!pgtable)
> -			return VM_FAULT_OOM;
> -	}
> -
> -	ptl = pmd_lock(vmf->vma->vm_mm, vmf->pmd);
> -	if (!pmd_none(*(vmf->pmd))) {
> -		spin_unlock(ptl);
> -		goto fallback;
> +	if (unlikely(!zero_folio)) {
> +		trace_dax_pmd_load_hole_fallback(inode, vmf, zero_folio, *entry);
> +		return VM_FAULT_FALLBACK;
>  	}
>  
> -	if (pgtable) {
> -		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
> -		mm_inc_nr_ptes(vma->vm_mm);
> -	}
> -	pmd_entry = folio_mk_pmd(zero_folio, vmf->vma->vm_page_prot);
> -	set_pmd_at(vmf->vma->vm_mm, pmd_addr, vmf->pmd, pmd_entry);
> -	spin_unlock(ptl);
> -	trace_dax_pmd_load_hole(inode, vmf, zero_folio, *entry);
> -	return VM_FAULT_NOPAGE;
> +	*entry = dax_insert_entry(xas, vmf, iter, *entry, folio_pfn(zero_folio),
> +				  DAX_PMD | DAX_ZERO_PAGE);
>  
> -fallback:
> -	if (pgtable)
> -		pte_free(vma->vm_mm, pgtable);
> -	trace_dax_pmd_load_hole_fallback(inode, vmf, zero_folio, *entry);
> -	return VM_FAULT_FALLBACK;
> +	ret = vmf_insert_folio_pmd(vmf, zero_folio, false);
> +	if (ret == VM_FAULT_NOPAGE)
> +		trace_dax_pmd_load_hole(inode, vmf, zero_folio, *entry);
> +	return ret;
>  }
>  #else
>  static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
> -- 
> 2.50.1
> 
> 

