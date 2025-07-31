Return-Path: <linux-fsdevel+bounces-56431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CF4B173DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 17:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 867FE7A6C02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 15:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F98A1DED57;
	Thu, 31 Jul 2025 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DlYQcw22"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4510E1C245C;
	Thu, 31 Jul 2025 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753975182; cv=fail; b=qIgOb7BGR+btw0uFZTJC/sJztqIWkZW5V4Kj0dQ5SZztGlRxt+4dEZX8wktVC9GuujN2bIoxgt2iwCWu9iegZVOVb+NmUitqwEkixqJLIUIImSvcpxabR9HC1VJlgmzhh4rADTu6N98MWt9qaAU7ToP4E9HVPYVMUzmCPeIlCi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753975182; c=relaxed/simple;
	bh=E0uOxcxALXmMwDCTMKvsA1DghvUy9O0iIBVx7VVEm7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eWpMy+G40w2vIHTs1FOwq00JRtLu9Q7gss5Bd4fbv7If/Ev+uUubZHBzGy0T5HY0Ijw6vQYGLfbx2qw2vl/PQReKl/TyZ/ZQnoTcF8ARHJMBfqxQJMG4AVEYvOjs28Js270Lg8QTZSV3v6e/M7rmmMO+N1SQHC2XiiD6v0lTpDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DlYQcw22; arc=fail smtp.client-ip=40.107.95.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICvA7wkMIwEEPzpfAv1grhbQSuxbkZ2MRD3hKPo2GAHrtfxdQSyDBYrLDN9mQXH362btXQnthVP52zIryiADMMD+42/nOJ/EFYWFM638XgdZadq9PSZ4sKvzeHSqPtMafnuiDCTMRJV9NmQHM2bFlkoCiBQ5LDZsEzbNaJvUj/QTP7QZ88Y6EgQ+LZqJjpMA2d4rKn6rZOsa2kEuou2VGB4w18v0MtdS/lx2pHLABHlo+4cWgMEShGBRlodM6z+1O6FWhoT99m2hT5x8EM9u4YONtyuIyjFFUgdULO8KW+Hm1ph71p7BeuIyjSWhkQY/DFp0/bPH+3nb4igQO5QPlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6VSDeqQFkSrjoGL24Aoq+0HObUBwF+67C3Ft3kLlk8=;
 b=PtngTfBizMUUj6/2tq+w+R2XoR1reezazT/46PDBm5NicsvJY1EcAUU0RSUErSvZVcZruwlhCch2voM2GUqL4SLTWLuGMKZUl35DxFkOZYyl0r8oxcVNcy5LWL8LfPYNGr5nQeRHlu5xM86/FqiDNR0Vmt4ktP3F6juugTF6NowZQbZ7rnu0vxCDBySI9RaBe0qEkSQGzQpDbAqDo3YDF3ErAF2/lCtm0+nR3o6pt2YH51CN5NU0feMvhUuLAlBbFdPGEkWi7Yk1aq4jyJ90kCp8REMEW33IS4rWYYpaLTBrjg0h82S7m7IUfG7ntfsWbSDeyspFaW/PheucioRS0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6VSDeqQFkSrjoGL24Aoq+0HObUBwF+67C3Ft3kLlk8=;
 b=DlYQcw22qFslv4XoRRZraj+H3CRe5hMb5xL5IPro2yl4zH10OE7435fr6TI5cAqcVXVwlRC/nD17qqXaJWvI9QLn/NbQhNKC+SQBSrUlLyEESDSTSlWscGZ6n9xtC6aPRwQ1mZ7G5qkT6ONP/jqdslyyanl0sjU5tK3jF4PrErqMkre0zyhaNrFC8CTcvG0uDnWUoMoJmvPxcvVEdRPgKvgknSGPq8Mpkle5cVxLchMPqs3AcpJYigzzEYN7loHPKAW4K+LbII+9sbfCtwgDDfb8qc73w9K4xhJWIK+w8OXFIDN9uECBGPwtGx5WhNxb848Xqyp/TUSCXuKO+zDqQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB4102.namprd12.prod.outlook.com (2603:10b6:610:a9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.13; Thu, 31 Jul 2025 15:19:37 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 15:19:37 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Usama Arif <usamaarif642@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org,
 baohua@kernel.org, shakeel.butt@linux.dev, riel@surriel.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 vbabka@suse.cz, jannh@google.com, Arnd Bergmann <arnd@arndb.de>,
 sj@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH v2 2/5] mm/huge_memory: convert "tva_flags" to
 "enum tva_type" for thp_vma_allowable_order*()
Date: Thu, 31 Jul 2025 11:19:30 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <F14C919F-A9AC-4C0E-8AE1-FF292682F1B1@nvidia.com>
In-Reply-To: <c44cb864-3b36-4aa2-8040-60c97bfdc28e@lucifer.local>
References: <20250731122825.2102184-1-usamaarif642@gmail.com>
 <20250731122825.2102184-3-usamaarif642@gmail.com>
 <c44cb864-3b36-4aa2-8040-60c97bfdc28e@lucifer.local>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0058.namprd02.prod.outlook.com
 (2603:10b6:a03:54::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB4102:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ccbbb7-2a1e-43d5-379d-08ddd045a996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C71f1ptZnOf2h6afyg1yMeTYx8wxpgfhTWmNTfH7kPp9jH0F8paWyowLKi6S?=
 =?us-ascii?Q?Y8U9q0Yq0YhwFqjngXDbmgXagtryLZxIVUxmVYOSw18yuP7lGUqDMyoVyRNg?=
 =?us-ascii?Q?A7SEIEVXBVrPavHry8Ru8F3nZT+MHtZyE/uDep1NfBbx23w1EBF15N9o9MWx?=
 =?us-ascii?Q?T6uOcfxf1qHLaPoJHwhGkbdEr4z06kik2qfR+m14BVNfJeXUUe657MTXgi2w?=
 =?us-ascii?Q?se5B5hbNy2rN3Mgy5aGskeGN0YHJduG86n5Srn/DWkZK/DRsklwjvapCRF6x?=
 =?us-ascii?Q?TASdQDZz9YfyfbLxc6BDMtR9aFB9UEHZGh08IILcJcH7bHY0dbyslWgHczqH?=
 =?us-ascii?Q?gWdq164659CXNpFNR5Mv5fZ2EqxXXMugu6FXCCsDWlTFfR3beGPkH2Ae76Xr?=
 =?us-ascii?Q?cFI4tQwQvl69+hVXcOfdtNH/a0izC5GmMmkDPV0nCKsuCogssyxghHMjt+H4?=
 =?us-ascii?Q?KI9lGA8bkvwwOk2vGJBtg/dDhq7C0GB3noWHrSVgCzcedpnQqOWe/wSzJZvt?=
 =?us-ascii?Q?yVZK/DHfPZKG1wrcxOGwclSULA70IUXJ/pBzmEHJaQMaPod+WTpc2UkKeg8j?=
 =?us-ascii?Q?bCou6Qc90kQiD5lri8Wm3PWSsRbpd7L8GSOQ3hFSVh+SgFi2JNgKFxdvFUXX?=
 =?us-ascii?Q?IFIVsxW2J3ia62KoEhqTsUwrn3SLlfArkZpKi9hbMuNoGz2WV0/dxRiRsl2r?=
 =?us-ascii?Q?20dEbEu5uSlnoivVFOiflVnzdVmIpH91QiXsRF+IQ/6rhLBT6e4Yf9kgm5Qv?=
 =?us-ascii?Q?kUheTGV4CGbxVl//9FMZ3Sm7zf08v/Muk8mhEwPiLfDLpEuC6NEzeE3ODUHQ?=
 =?us-ascii?Q?bZkkP9bi7JJD3uFmNYwOYJX5lKpaZX9ajEmzXyBDdd+/G0ZGrDI7c4KSnfE/?=
 =?us-ascii?Q?KdkW45YBce1xQYdvt5CaW0lWSU0C7x/lwVY+Xp4QA1j7IClB8SjViiL6c2Co?=
 =?us-ascii?Q?sppKQYzRjg/XVbv7toFWM3cX/Yf33Fa0YK10X8HPpMRk9ncWoMO1ryqqM3n6?=
 =?us-ascii?Q?Ze9XeqVEZGEpUEgctN5kvVHnXHyGT6hX9zb6TcC/TvbnLIn6pnFff0CW5dQp?=
 =?us-ascii?Q?kE8oUdVCFZC+R6M3g5uQCvXUu8E175Uqp5ndlG3oQp4+gKij4n4eqHuzadEv?=
 =?us-ascii?Q?+Xe7d46GTSRNkchK72cGAxDwOWI0Z8rbPASeZu95DPMY8ESoT0PRJpnGqfhE?=
 =?us-ascii?Q?PaXF0/QuosJjTpAENRxARbGX3+ae8mhWEUo0d6jFLwToBIJEL4TfVWhxt1I8?=
 =?us-ascii?Q?vLwM+GHhv2keO5sxYV9FE5ThpnYquUrb9OIgByby2benRMjCsob0gyGQSQ6V?=
 =?us-ascii?Q?Lj6/Xat5MpgnMH+5dveGpfUH7uAuJZ31bjwEMgZSk8Sx8m46cgN0UYLg9ETD?=
 =?us-ascii?Q?KZ4dKHa1nLJVe9Ag6xYZteVPJWqAF99QWpmehhx84f/hfZPzOET0F7NBmpcI?=
 =?us-ascii?Q?wKMRAu5qLCw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GE2LcIkMwwSwSICC4vp9jL7LxCTJF0Oxb4J1VqmcSQMv7PrMvexLPxQMgnRm?=
 =?us-ascii?Q?L8jIdl+YZvb2hYexFKcEN3ujDAYedJdbbgHuG8k8JP/+8CfC95oW7QIbeKBr?=
 =?us-ascii?Q?WlQeOzfgkokX9zyL+Yef6D+BWsOhuy/TwM/Lj70JBCpV+SuhsHHitn0CXj4c?=
 =?us-ascii?Q?xJZSJvNAznpVqpxmLFb6IRs6rmx94O1b6rkm+sWI38AtaFuX9xEOjPRSV5AS?=
 =?us-ascii?Q?2kz/DIDLp1frp4s4fWYjhG4V07iLmfUcDEhxSzkX8xSRcSeyPIETdCJNF2Z5?=
 =?us-ascii?Q?kNHzgwGVjEhCagMjNSRF8hPeSGX2fr6/b+rffafS+sDUhS4dJuUcBjZWKlbK?=
 =?us-ascii?Q?nDYbc/JNByXbaAbXr5EdIaaZLGarCqT4kyNNpCR6KppawVkDoDsp0f9om1b0?=
 =?us-ascii?Q?5TEyPpwb8Ba2fsOAAJd7RAA5EwonBp81FF23Cs0wquQ1VL2Z3brUSigr1SVP?=
 =?us-ascii?Q?IE6OYLnQSeZW3kuC8OhB775I2UdFjudbDEX5VzhDv8gqj2UBfTLYhm5/RX8k?=
 =?us-ascii?Q?gDbMmTJmclSG9+udrD+ElLX1fwjI2ygAJfjffiwyGwS0TWT1ka1JBGE/LjmC?=
 =?us-ascii?Q?qEFkAbx5/+uYn0KRNMKZjotrcRHInC7OMd+oHl+7a3PtdhQMvcnYAJNs2jfk?=
 =?us-ascii?Q?7xHY1YN4KRwwntiw3j8mvBZ0e0XmOVo0eHtYUNaOend1NhylxKoD5pC6IM8E?=
 =?us-ascii?Q?Ojumg4EWwyHEbILHPqo7dY0d7WX4ZvYbh22XqCYOidPPlJ0LVk7CPr+7MJRB?=
 =?us-ascii?Q?gbtLbHYwKrEy2wlZuSqJPmoRlpK0qqnumZG2KEvQcV4RVw8Y98rgeySjJcpy?=
 =?us-ascii?Q?2ApHUJnFEN7900EguFQTnNTp1JCuju+mqFWgG731IwHpvilV8Zi7P8MP7FdK?=
 =?us-ascii?Q?liXDZWI+NPaCwMkU5OWZCROcogYpDpUoILDCwGGUlk8PWjGHtuK+S0DJUI95?=
 =?us-ascii?Q?e+o8fKBhdKSRj3BX7AcsibHBTuzVd5jU/pKRwoRc9xV2w8RNUgtPs0ZB+8BW?=
 =?us-ascii?Q?+yJWsli5t0n/bYgD2cGwKajbAkFoGAYrxcVKlLZ7tbBtnKrfGs2TyhGBnt7m?=
 =?us-ascii?Q?q4wt2WKMXRTjFdTsvpSaYQjqfresoxfUqtlQhcfpNDaibKBacWN2uKtyiQfC?=
 =?us-ascii?Q?cZ2a+Sm05vAC+tsRZhUo27Ljz+zeQg9u0ooxSX+zqINirShjRfuX5dc7sxnN?=
 =?us-ascii?Q?8CtDHu3GmQSSuv81LYURcdr+yekLhLC1gnDJNHsVKBNj6xgl7ulCnnGWI5xv?=
 =?us-ascii?Q?GKvqIANxo7Vcsb7VJoxeIH223SX/1FcoOpXm+Cdux5TQba8o2EJWfRDJaGbM?=
 =?us-ascii?Q?XtCzEKE3JqzNju18kUuiOo/D6ZXKCS28G9LMeA+u9jMa8aj5ygugf/WoNEkE?=
 =?us-ascii?Q?V7iIxqAEUTcoZ1fQhAeF5dOa/08KJiVYExGVgtdDJy4YzO6hNydXJcsBjM/p?=
 =?us-ascii?Q?17fcUuF/SnvhB+aBDRnCbEB3CkdB9d0pFpb/Fo3kINgI/uWQXO6jjx4XF1MZ?=
 =?us-ascii?Q?16Y3YICNQAnERE85mQuV7a6ZwFaH+4eIgnWEs9Ez8yeOkHTFTkhLbYxYxWPx?=
 =?us-ascii?Q?CwXdfawR5O6gBCwqT1Q=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ccbbb7-2a1e-43d5-379d-08ddd045a996
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 15:19:37.4970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jlyKTb++tsSvEVABUe9lO4cOI2HoeSwFqAEeLeInfO40luST8/sqMkb8cobH5Zkv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4102

On 31 Jul 2025, at 10:00, Lorenzo Stoakes wrote:

> On Thu, Jul 31, 2025 at 01:27:19PM +0100, Usama Arif wrote:
>> From: David Hildenbrand <david@redhat.com>
>>
>> Describing the context through a type is much clearer, and good enough
>> for our case.
>
> This is pretty bare bones. What context, what type? Under what
> circumstances?
>
> This also is missing detail on the key difference here - that actually it
> turns out we _don't_ need these to be flags, rather we can have _distinct_
> modes which are clearer.
>
> I'd say something like:
>
> 	when determining which THP orders are eligiible for a VMA mapping,
> 	we have previously specified tva_flags, however it turns out it is
> 	really not necessary to treat these as flags.
>
> 	Rather, we distinguish between distinct modes.
>
> 	The only case where we previously combined flags was with
> 	TVA_ENFORCE_SYSFS, but we can avoid this by observing that this is
> 	the default, except for MADV_COLLAPSE or an edge cases in
> 	collapse_pte_mapped_thp() and hugepage_vma_revalidate(), and adding
> 	a mode specifically for this case - TVA_FORCED_COLLAPSE.
>
> 	... stuff about the different modes...
>
>>
>> We have:
>> * smaps handling for showing "THPeligible"
>> * Pagefault handling
>> * khugepaged handling
>> * Forced collapse handling: primarily MADV_COLLAPSE, but one other odd case
>
> Can we actually state what this case is? I mean I guess a handwave in the
> form of 'an edge case in collapse_pte_mapped_thp()' will do also.
>
> Hmm actually we do weird stuff with this so maybe just handwave.
>
> Like uprobes calls collapse_pte_mapped_thp()... :/ I'm not sure this 'If we
> are here, we've succeeded in replacing all the native pages in the page
> cache with a single hugepage.' comment is even correct.
>
> Anyway yeah, hand wave I guess...
>
>>
>> Really, we want to ignore sysfs only when we are forcing a collapse
>> through MADV_COLLAPSE, otherwise we want to enforce.
>
> I'd say 'ignoring this edge case, ...'
>
> I think the clearest thing might be to literally list the before/after
> like:
>
> * TVA_SMAPS | TVA_ENFORCE_SYSFS -> TVA_SMAPS
> * TVA_IN_PF | TVA_ENFORCE_SYSFS -> TVA_PAGEFAULT
> * TVA_ENFORCE_SYSFS             -> TVA_KHUGEPAGED
> * 0                             -> TVA_FORCED_COLLAPSE
>
>>
>> With this change, we immediately know if we are in the forced collapse
>> case, which will be valuable next.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> Acked-by: Usama Arif <usamaarif642@gmail.com>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>
> Overall this is a great cleanup, some various nits however.
>
>> ---
>>  fs/proc/task_mmu.c      |  4 ++--
>>  include/linux/huge_mm.h | 30 ++++++++++++++++++------------
>>  mm/huge_memory.c        |  8 ++++----
>>  mm/khugepaged.c         | 18 +++++++++---------
>>  mm/memory.c             | 14 ++++++--------
>>  5 files changed, 39 insertions(+), 35 deletions(-)
>>
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 3d6d8a9f13fc..d440df7b3d59 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -1293,8 +1293,8 @@ static int show_smap(struct seq_file *m, void *v)
>>  	__show_smap(m, &mss, false);
>>
>>  	seq_printf(m, "THPeligible:    %8u\n",
>> -		   !!thp_vma_allowable_orders(vma, vma->vm_flags,
>> -			   TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL));
>> +		   !!thp_vma_allowable_orders(vma, vma->vm_flags, TVA_SMAPS,
>> +					      THP_ORDERS_ALL));
>
> This !! is so gross, wonder if we could have a bool wrapper. But not a big
> deal.
>
> I also sort of _hate_ the smaps flag anyway, invoking this 'allowable
> orders' thing just for smaps reporting with maybe some minor delta is just
> odd.
>
> Something like `bool vma_has_thp_allowed_orders(struct vm_area_struct
> *vma);` would be nicer.
>
> Anyway thoughts for another time... :)

Or just

bool thp_eligible = thp_vma_allowable_orders(...);
seq_printf(m, "THPeligible:    %8u\n", thp_eligible);



Best Regards,
Yan, Zi

