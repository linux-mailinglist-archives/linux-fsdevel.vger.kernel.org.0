Return-Path: <linux-fsdevel+bounces-16494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B79A689E425
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 22:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5D51F2195A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 20:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFB8158206;
	Tue,  9 Apr 2024 20:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ND4t0vU0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2107.outbound.protection.outlook.com [40.107.101.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFCDE566;
	Tue,  9 Apr 2024 20:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712693184; cv=fail; b=VN9PVatIY6qmc2zHTL7UkxrgDVPTlhiF2GuonQFSoR60mVJAOPYdO4DdQ+ObU+eBa63YklXU2tAtWYmySwLdOlE+UvBN1R+FiPC/8eTNn4/L3DigQFy9hxnO6JuhtrwxadMabVbk3/+Ps4ymsEXfHUgDL9zZ5o6/kvBzu+nm/+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712693184; c=relaxed/simple;
	bh=Mos54b4ncx5BFoj291fkTyxTjmOEQUJeYum/dUkn0FA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Izm9B08xy++DO4oxKZilJtcPR27noWsDfhfA3+QKDqF4IoCXqeZnLvu4SoKyRSAmbrt3MQQNcRoPeMK7n8gbE2aEDop5qxCVzJrql+XKQeLKx6+tw5UOk3RCA8w9rFGaMBEW7Mc6hxyAGumVLrnGEGanlvSzuQqzc+Ng9AXmytE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ND4t0vU0; arc=fail smtp.client-ip=40.107.101.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6eM1SXMvA79NWtimb3XHG1cnA2QNhFJWKReCnmtaBUurPa0UMn6ApkfHafGk0eNeV6z7QQQTJM1j81Qn/61o2FkL/VQPHFTlFpokJaCB9SSPJcC+qloB87BgJJ4LJNkDeg4crqrtLb5r11hMdqNPUoIAi512/nAyMqMiLHXOwN4KgbMqsOKtYD9EjnWwg747VP7HzV+2iWGMxKGuWfijhKlCZLqlkpv3cDa2aFAR6oUrXH/EqDUvMLcSwKMOPj0SSiLtBJ9tAwAzHdKoLZUR84rnPTC8ZXCNS3PLzoC7VnHpZuFZ1ytxnOJ07rHziwYXzgdBVHbtAbTPmn2MfFZtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOcr5SRPV6K0pEdtYTw5BgNx9AcWWP/Qjzs8xDjfxKU=;
 b=I3schSCOPF33y1RwAt9j9g+LMRk9Ldd/ELmDdgY0rNQJzs08p/XuGh9Uawtx33huj3C7EQ8Mmfbxx2dAMR0uo1nJ9c5nDLy9YjIdP2IIS6ew6vMIWee/gj1ee3U8oNkVdmWd7PeAIFJOtfTK2lLN37sDzmZJDxJbhpzHGZNzFuwgN7/+9GXPXe5lVZ39GZEvZLH3e5RR98yQtZQTs6XmW8Q7rl627AAVdg0xsL2J56KDjf6PO3pF+dE2jjRU/3+KJYJCOf/dKulo7W1zviBCl2pZlHtXLBGShI3kndy1nf4Q3KE4o5Ok0Bjszvtu/QfJqRfZuW6S9kODnCLu93maBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOcr5SRPV6K0pEdtYTw5BgNx9AcWWP/Qjzs8xDjfxKU=;
 b=ND4t0vU0bxaqQUDnb2/qyafTOz7umuVYC2OWqGMDMPFyzUfS7+CXC4xe75fqAvqTIPzxVpyKxnFNtuEQwgoeRw16dEpevHFHiR6fMgOUQnS/ZUiNn6dWJZYr0HsKA2tBUjL3pDhFrfXUur1ph4OuAG9uK6CJtst87o4/jDTnJqphHXvvqZdWVCUY88Tcf76f/6FHa0PU8EJIZ33DPdqVZ1ajkPXmO7t/XpAVA4Pfz5uDCZT9LBghzdsIsLFgseA3kBuW8DA4O8ODvBUJ3mNOXMcXjG1boDeMsRSnAd/4jqfisPg+35a/epMeXzWSyz1Rq/9UKlOBaR/ElqCc2+e8uA==
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ2PR12MB8832.namprd12.prod.outlook.com (2603:10b6:a03:4d0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.54; Tue, 9 Apr 2024 20:06:18 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 20:06:18 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, cgroups@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Yin Fengwei <fengwei.yin@intel.com>,
 Yang Shi <shy828301@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Hugh Dickins <hughd@google.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Muchun Song <muchun.song@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <naoya.horiguchi@nec.com>,
 Richard Chang <richardycc@google.com>
Subject: Re: [PATCH v1 01/18] mm: allow for detecting underflows with
 page_mapcount() again
Date: Tue, 09 Apr 2024 16:06:15 -0400
X-Mailer: MailMate (1.14r6028)
Message-ID: <918813FA-4AC4-4B36-81F4-0066C6334175@nvidia.com>
In-Reply-To: <20240409192301.907377-2-david@redhat.com>
References: <20240409192301.907377-1-david@redhat.com>
 <20240409192301.907377-2-david@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_BFD76C58-D229-401C-8255-4BC7BD4A02AA_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:208:236::11) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ2PR12MB8832:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xVtBSDjv0JFb9MxXxwDEle+dlls6ABllwVvcRWXOJyPC8ZMr6BHUPTBGpmBBZpwNsCV4XcMPbV+ORyPfGm7wlD/RAnH750PONAIYFczTjZD/i8FAVY85VHGkkr7n4mBSIY+dLjnoRzKVWTWEe8qED1iHdBeVG8qm6v1eN7IgWUoLsLWXwRJQ/Uwn2YqXMg1M5SKJgHNYlH6T//N20kt+okBc4GCWHRUVeqQTAD5oSTqOHHpiu77B+3L2UWGmJWpTUkyXORlgNJKxO+uikkK6G1rVxSOmzOF9gQOZAghSlX5Ogl6nE/FgDxDEzklcDpI5C1edohTrvgiONUbdjn6ynpnB02/k3op/gcPa+nCzdKbew70IYTmtqiUNCDCBMtB5FME/3AoQm+pWLFH6PhLmydjPFPJXQNM+dQLENiLARY+awAPqpASRdOX+1EbS7EZUZ3lrC9vL7FgAaPv4FeFWqxGrC/9sfKfVOIjAr66EFjRmTlF08lRGa5wnykEqM7TOMtSgYTXcYqyWBsTbI5Zt/sQ2jkekohigznn6vPU/cQPnUzPsZjv0TBa3hSjTmShiXD3IrJC/oVmE8kggyHqfl6gyjCXXwoKELRSZgqswFdZCG840I/0NgnMymImrQzMNAzqmIaX6kPP2Qfw/+y9FLGb91EyBDcguBIyRAdGHMBE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?svI1XBq91M9w07BCyisqXNFKPtCardxgbcdUqP9yv20dju8GCHhvDSWVHvO8?=
 =?us-ascii?Q?1BnsRgjtLxi4/L0NQ+Oarh4ryZ8IKBUnOIxGcAjJUEmkuIIaC18e9jLg+LTd?=
 =?us-ascii?Q?70cZJltDrkJFD8JaCmBil2QJ9GoAUj2hDhShP2jxPWLLRC2WbFWDASIyyAaI?=
 =?us-ascii?Q?ggP+iKfSIvdzyWUoNVaRSuxWLOECKcuIImtpQShtReRLUFrbCJVkdgZ38Jlt?=
 =?us-ascii?Q?nBS3iZRtHHqBSFbAn9HqP2r48pglSt0PdA96EVJKjwx2CZ2m8/gr3qYg3JjO?=
 =?us-ascii?Q?QuBlClMIyAJjrBL5E5RYpNjxwnwcql8tnHARVp/vPaqBmKHzq5a/eQt0dOjL?=
 =?us-ascii?Q?cXjBQbY3VpkeWjUZvR8a+HTPPl8SjtXbDiX4mX00JmwfNnZD8P6CrYMoizSl?=
 =?us-ascii?Q?Z7Wkonx3VGkaaOcZYNPKU8yYEb59qEjR4r2BBXWEpEER1TaLJIkPdPkHyMz6?=
 =?us-ascii?Q?939MZXrz1fy/2L6KjCe6Zl7f+5FI6oncG/DUdOSgZNlEQo52isxDwlvs6Lxb?=
 =?us-ascii?Q?hAoXJmtjxuFB/wAwh5OSC2sWahHpM9sNBB74xosp8iXH6i/CpkvlUa3beaek?=
 =?us-ascii?Q?fDvp70LsfrufnYM8WA9owme3oRavoISb1bZbvWEMraR0F+4qyG/+tQAtW407?=
 =?us-ascii?Q?eIUoADSo+AVlsVqfBrFjvjeEouYQUv1JPEpZEwvJShvlvIJbwsRLbP01wg7Q?=
 =?us-ascii?Q?VXG3sBDwzXH8PbV6yPpfKPzkAJXxjFeSgnRit095Uf3yH20z1abacqr7BsMx?=
 =?us-ascii?Q?IJCPpAQPQQhbWgQw5gbsNYQJLGeidEWBIJ81oKUCIrVM3qdO9h9dXzOABil/?=
 =?us-ascii?Q?blNZ47dAdnEeYIgWgocoJ3RZZzQP+6Wa/Yfh4OAYqJJFLRKhjMgvsfzgLm6x?=
 =?us-ascii?Q?aBKTkE+92TLA+5mGkQ5SLMMC+YaSrp5ufASYPS7ScL4klwkSwd5d3kfpHyVo?=
 =?us-ascii?Q?ha6hb3eYM1V3TL5GFJEndeJzoXWTfPQzejQS1AysP4XnTMhWoHtcvkpTHeEH?=
 =?us-ascii?Q?nXeUPMVLN1zWHokEspGe7HUzwujOfCRzhiuSm5d69ruGn6AZqmxfjSjt1Mp5?=
 =?us-ascii?Q?XtbbMo5VBzoSOuCia+eoohT2g5/tH4CMzQEFE04aySOiptmPAFSd3VZXPdbU?=
 =?us-ascii?Q?ZhD1zzeGxeY7/oRCaYTxzL0srgDUTGkFF9p/1b0PtL5r9mGLHVk3N3oKfXm3?=
 =?us-ascii?Q?N7js1YDTujCCq9btPXUKWyF+XHxnIBBSH9mWZ93dD0sxy3QFjIdZ7msZqrnZ?=
 =?us-ascii?Q?m5wQlJoPm1PbSzG93fYDdVBBKC/ucVkIKHW8RjiR2DpD42E+DdcHBrJLoK38?=
 =?us-ascii?Q?BizbzWm5fNa721uP9K4fek3Ud66X99CkvVdfrFSvWVeD0w7hCLwGdVOKHx+U?=
 =?us-ascii?Q?voaaPRwHxW9Il46EIvP/Tl/F7hoiLnxM1aD70cs1fxnQaig3hoLM2fE99D6r?=
 =?us-ascii?Q?MI1lBcesgSqarSzZ34pfQL1MZ2Hjk0ROwYmY2x61yMJkqVWMuVyOaPFrInDC?=
 =?us-ascii?Q?23efQ/vgG5Revjy1HucORV2SikYl4/fnPMvnk+qgpV3ZPhSwrt502V0Oz4Km?=
 =?us-ascii?Q?IOokuqvMGnT87HSgp1RZxK1wdbxCtd4mDjNErYaW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b00554b-9613-4d1d-62e1-08dc58d084e4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 20:06:18.6852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENJsijIGN1tzrX5wWirWIXlXa8oNF7O2vVEEljLhzi5CS+Ri1SfpjMKDEBFo38mR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8832

--=_MailMate_BFD76C58-D229-401C-8255-4BC7BD4A02AA_=
Content-Type: text/plain

On 9 Apr 2024, at 15:22, David Hildenbrand wrote:

> Commit 53277bcf126d ("mm: support page_mapcount() on page_has_type()
> pages") made it impossible to detect mapcount underflows by treating
> any negative raw mapcount value as a mapcount of 0.
>
> We perform such underflow checks in zap_present_folio_ptes() and
> zap_huge_pmd(), which would currently no longer trigger.
>
> Let's check against PAGE_MAPCOUNT_RESERVE instead by using
> page_type_has_type(), like page_has_type() would, so we can still catch
> some underflows.
>
> Fixes: 53277bcf126d ("mm: support page_mapcount() on page_has_type() pages")
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/mm.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ef34cf54c14f..0fb8a40f82dd 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1229,11 +1229,10 @@ static inline void page_mapcount_reset(struct page *page)
>   */
>  static inline int page_mapcount(struct page *page)
>  {
> -	int mapcount = atomic_read(&page->_mapcount) + 1;
> +	int mapcount = atomic_read(&page->_mapcount);
>
>  	/* Handle page_has_type() pages */
> -	if (mapcount < 0)
> -		mapcount = 0;
> +	mapcount = page_type_has_type(mapcount) ? 0 : mapcount + 1;
>  	if (unlikely(PageCompound(page)))
>  		mapcount += folio_entire_mapcount(page_folio(page));

LGTM. This could be picked up separately. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_BFD76C58-D229-401C-8255-4BC7BD4A02AA_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYVn7gPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU468P/iMv7TtTxVFI2SJVhKEK/KA+QLDE1xG0g3C/
cR/1hWl4EFowLLGO8vpYM8cD6cnp5ah89fvEVHpTKBhyPRs72biZRLTsnFyHUDtw
w7yqJccqNGWIXXj2cW/STK7XWfY9hOGNHT3f4P51jeooUbX8deU1LyG/yKT9OWkm
gkv99P90KemBzqEgkdurM5oBJHZfl1IMy4GomJSgXkvBPRL8RCOt+mLezEIBYy+s
XkrCOLqPc/arAUleD2v6C5nEcu7RnO6KxTYUQ8tvqafJp+Ao1C/H3hcY+JZ3rDGT
WCC7zaTt3llPThFZgfWST2Qd8gTcDH7SldwIzB9jshdR/WEKDq/c6UmmGV8MORSO
dF94MUAT1qH5dn9CxUcrcY2MT8x4eWu/Dn9ERUwUHf8y3ZeLlbg1nwHOqMVCrmrp
1F8Y1Rsi/6AL0Z7iHUT9lU6+OvdKJvvYaSLMfxSkLE11UFd+AXNtaanLNhGJJd1t
fEwG5WtJYRaaSNrAk3bJrWF6wxcE0rFJ7M08QHxDXfqaTYMclXiJSV7gmbDI0Ev8
Oh4p+bis/I8YxRt2JabThl5lzFsYcdVLc3XOhRvZ/D+RexMHkSOed734GrtX/YVR
xVOzO5JQUTvl2fEHDgOw2YoYtJ/v/pyDcK0uQtGevvqv4CjErBcrTwJkZan8z7Re
RZAouX9w
=dfHW
-----END PGP SIGNATURE-----

--=_MailMate_BFD76C58-D229-401C-8255-4BC7BD4A02AA_=--

