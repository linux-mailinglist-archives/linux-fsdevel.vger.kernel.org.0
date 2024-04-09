Return-Path: <linux-fsdevel+bounces-16495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA7D89E438
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 22:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24FABB22144
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 20:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA57B158210;
	Tue,  9 Apr 2024 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PKVBky+g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2132.outbound.protection.outlook.com [40.107.94.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8505157E97;
	Tue,  9 Apr 2024 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712693624; cv=fail; b=Iny44OQedwREuFxgnVjsrrm9dH5nPpMpvBtB/4GxNrEEBeI2qNcP/iCMuf4WLAE0BhKessPsALVsJekhRco0Tv5hZvFqVlRYMomx0D68MgRXpsoSDZeKI9bPrgj7b3E0ZXQt/RaRjaEHI1F3y1CmNwSqZXw9WPz6XD3rTmw2ZVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712693624; c=relaxed/simple;
	bh=bY/7XF4fYKg1iIDZsuoM83h7Xt+Qw+iCZNEwX7vjaS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XkCbnTpn5BmzzN2aFoVgCgp99WXo1iY+e0pTzeZ0OkRJSebh5aTRxDhwDC9r1d+IwfRWe7WhhO0kfaFXQ2SKH+RcrMLT6lkJLcJyFm4DJyXsaTwa1xUjFAdJiT+TEgIo2P4ifk9YSSAfdy8tUMx399+6IYx6Js6eu9iKmYuod2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PKVBky+g; arc=fail smtp.client-ip=40.107.94.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdEAF/WyquHhvLsIt18O/OkFmpdEd7Eb4Y/KmanLrV5QQ1+TyzLKqxyaEwzuqmWdT+c/5pxg/SLEZPZfqDKJXfisikQ3efjLG5Pl8eU2J34xS0QUVyvDx+eVyG20XlTUc0wj2eCcnrW0JQ0m8D9rPHu9o/aKXBz2DVZL/Eh5Nygmke4DDT4CG1LGIJH44OiywrdvZBrqrA4FnMX8eo/tuk3QdlQL6F1imYY8aZ1OU+dG1mbCBfuTcezf3H6P7sd1JyIApnKWxPWtZBX2OQES6DJkE05QczmxmNleLDz5Mz0QBdH/Jem1suWIeexZF6UFH/DDbFiHAEg9od2mjdkuBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3aKznSpJIS8+lbXD+3mbKkR6MzyzF2lQs28LZ2Hysg=;
 b=XRXxTyBHV0VG94QKqYC7qwkgZKgz59DvlVwwJrcsV1/uErJZhj/nTGQ1OGw0lD4qGfR29bTeQHugZLA9mqp8dZ2q7S3FQK1gbkuosfcqul2WvmY0F+uuLSYNkLeUT+z5ref4V5dX59oRyqREtSBcgjjeugOjIN0Ni22E6Rshlz0bifpZK/wkruNS8CG5Jc9SHoECubNZmCmxjuN+nTyvseKJSvinrrwq90+zb47KmDlqMDChIEsdWZif6Pzrf6tUjfkd8bckvhI9V5lbioaAsC2DJoouOSHmF2iU+LmDsNHmmKb0bZJyrjwxjtjkJXMU0LJJUwvrQ4xj7Qs/oWpYXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3aKznSpJIS8+lbXD+3mbKkR6MzyzF2lQs28LZ2Hysg=;
 b=PKVBky+gwN13Oyrdo9O85SZnqJ68v2jyCu7Qqa+elQo/SsU+TsB0qIyBz2t+6dH9/5GQ5dM1wlS8AWcwuDHEZYCLSrDB6pvt8gjWtp2ODuAaz7rVk8bKbXHRuguHLri6Mi2Moh23skJAhogcsCPVuCE55BVOQp8Z2beJrbNTqT9rIvECDy/66yhjmjtmyEfmUsUXbc6tmFyD+UQnxIPRLT6Hf1+nO0HtahcoIPx48wD8m6PfF0oR/G60fX3gRpc4pKT3HcuYJoz9luV46Fu+Bm7kfSriQB+fkA1MH6mUJaAYJTdUGtV8s+tM0MsPp3NXp+pjE2pEEfY1jsYIxHiWhw==
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SN7PR12MB7250.namprd12.prod.outlook.com (2603:10b6:806:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.53; Tue, 9 Apr
 2024 20:13:38 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 20:13:38 +0000
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
Subject: Re: [PATCH v1 04/18] mm: track mapcount of large folios in single
 value
Date: Tue, 09 Apr 2024 16:13:35 -0400
X-Mailer: MailMate (1.14r6028)
Message-ID: <1DFEC99F-6BCE-4E6D-9EF2-267E8A94A705@nvidia.com>
In-Reply-To: <20240409192301.907377-5-david@redhat.com>
References: <20240409192301.907377-1-david@redhat.com>
 <20240409192301.907377-5-david@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_BEDB01A4-F93C-4BEA-B07C-1B36C5E3E053_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR20CA0012.namprd20.prod.outlook.com
 (2603:10b6:208:e8::25) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SN7PR12MB7250:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	03dWxGOnOSw7BXDnP1YUe51NAfMuPaIDyDl2/f4OeGL13NteiKVDdnCUkVgaf2FTrWYo7lWl/JQZeMsUJ8OCoo21QfuVvoi80piGrPzGj1dYYY8DmZRTlZLIpbc9husJ4ScL1wOwGySAmaYulG+SUiTTWtaDIFysvBZT78MJ01uA98etLSy9UPGTX0QpGRLGZaUYp0wc5x5KUF8fqlCwwWscHKMlZGenCNJAtsZP80y2KRN4Ab0ZuEylXSNzQ5deHfhD9GUI0kcL2OBipGIV8pK9CdfA2TvhMhQ75zV40mXGQ66Q1ZgUW2uypKlOZ6aNP4hH/+SI8MXgipRb1kK5zQCzL6kiFdalWFKYd8GOmOSqnbQh9OZG1x+X+D/GGU40Hnqq4eWFugAPmS/8jhag3XlzXIAJKAQc100kUsOJ7iQYuDiyH8iCAg16JvwpCHtY31FQ7h0pkDje7Hf2kxQ88g8e6hOPHtX72Kbbn56X50NaXfPR6ObcshGyW8CLdnAvsrNRPMAMb7KxJ20iZnRP0jNdIJl2pTtqrHsyP6+NEgmZRq0v4/Lcqzw3I3lTEEls2aE87oYivYIR+SIn2y3QBJzRD1ovImyQyCh3fnYYxD+GapswEfwIcEq5LoEjDmHjFPZNJ3KQmARD9TyhcYh3ua1s9I1OyZdHlKozzM7muwk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9FaQrJcpl757G7MAChdYV4rCY/0IifCZ/Uhgwt/qZmWaK1cse9a9l5JTkEr5?=
 =?us-ascii?Q?ixe2d5otq5Vgx58izMOn+13d2vAqBE/wQyPJNC8eNWL4s2iIXLRo6zaWhKHu?=
 =?us-ascii?Q?3CrEcBrTMu1lnmwLJhN8UHoK7SN/mfuzsVvgNAmymilYoyL8OLYL2cuwXfSg?=
 =?us-ascii?Q?Nrq88CZmzJI9mtZxt4z4UCuJt+Fb8cHa9zxaE2fg2TPYv+4EeB414nh31EW7?=
 =?us-ascii?Q?1h+UY+qUeI5XTF41ALk4Xt85VGZAoMO+UwT3tE8BkbvLJo4ch5HL9Vas+yC8?=
 =?us-ascii?Q?P2tlA7ZrpyfnynzcBDXU4BjKZypsWvwKIaCTlpbFqCwkRhvoxnj7H/r5SgKY?=
 =?us-ascii?Q?VzAO/qFym/NPpZVczHDXyivjxBcU5SvT1fARON7L5IdRu8hyioUQV+ESz35P?=
 =?us-ascii?Q?lQTpi+UQtdRjvo0EtG1iii7bRxtjF2ymCI4/0+SL2fMR4JdsVyUmXnC1z6ng?=
 =?us-ascii?Q?iFIYKrhAC8dWkHllkTi6kyBUv4wvx09eD1hQT+8Dp7Ks31xPu8RSPqtnDPil?=
 =?us-ascii?Q?Palx9nT4oJwolboyHZiFs3e/LZ6UbEqbmWPwGWlQxeH1q49lTQsMJPDGPlj2?=
 =?us-ascii?Q?kQtG6H0hbXABTN43zEmirXLqNfpanMuXYL3qwwiuFAgRPvLrrG76wIqR7cM6?=
 =?us-ascii?Q?rOQUawnvo5j1f6QybwRwvR0E86X1ef7LjBWV4rEeAOo7/pgA+py+N8n1RVTc?=
 =?us-ascii?Q?0R2RGtvoOkCFz3k5rcOh/o+NPqHtkrZiwfmO0noQ4Qgek34mR6MMx2GFif8F?=
 =?us-ascii?Q?0ZZ6+XDphw1f7e3umTJ+zIIPQXKhauxvLyZNv3x8nPLnTSAnBU0tNwvMnYoz?=
 =?us-ascii?Q?M+OjoTP54aS3M5tvGjl+7VDjolkC4GYXgpQmR3xu51hI6kqafWCUkj5PtGPc?=
 =?us-ascii?Q?sTf/OOYHbQ+6+EDUFGRwJC2FzBxofqd3QHyrop3Yuyrnznr3vRA0oPIXpP1S?=
 =?us-ascii?Q?+U2KWnKYqgzgtUXyM9XMtpyDsCDxnTWHIM/lsrijrYDNb25b3+RyHCpY664z?=
 =?us-ascii?Q?ZNYlUmqdDSI3I62kMgDOv/GYimt0+7bwaQTktC4EKVLfD05qv1qzesRx2st8?=
 =?us-ascii?Q?tvFrWxB+QLYI6IfEeI677wzOpKEntFxOtavemFV4M30d9zpdVBTZMkbHp0Mc?=
 =?us-ascii?Q?Kt/a+mpFt4E/O6E+hy0qjlRqtz+aF8g1QLzhUa7V4xDzMkc+oWGOOKaGpOJv?=
 =?us-ascii?Q?vQqCT3I5eu3Sekg1txy81WuL0sreJUwwoVrHpR2Z9w6vzbWQWok8h0V2g50M?=
 =?us-ascii?Q?C2LRldpkCqfMXbbssXmXVl3S18jBMOinJ8BGL2geLSqNLjTqZRzLa8M6sPfg?=
 =?us-ascii?Q?osO+TZ9porv+SDbiyktf8Zp08dON6QbbHtfAg3eUBpqt9qAyNs/ZPBAzEjMw?=
 =?us-ascii?Q?3OgN6AAWQtzcpLO/gL56SWYTOVuSH2GGnNxJzcsl7pkPBbt1PqjT10Ovl+W0?=
 =?us-ascii?Q?iz9rRCCkOoCcGSCSfhWgK2YmXBLZ0B8rHjFx5mUaenZPUW+sZ9tNbPJPVVn9?=
 =?us-ascii?Q?JmMF/3mbpCA/IU/CGbfFjD+rO+dj7YNNw8x0OMbQ8ctVG7y0h/LMmVgtNWn1?=
 =?us-ascii?Q?xCvbY2KD1T8RNyfpOWE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0279c3b0-15fe-42bf-004f-08dc58d18aee
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 20:13:38.3155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o60nxdNgny3CyCA2LbemLoJ8Vwc90fST6u0v7142k9iTvCQBwWs9MtnaCkgj99UE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250

--=_MailMate_BEDB01A4-F93C-4BEA-B07C-1B36C5E3E053_=
Content-Type: text/plain

On 9 Apr 2024, at 15:22, David Hildenbrand wrote:

> Let's track the mapcount of large folios in a single value. The mapcount of
> a large folio currently corresponds to the sum of the entire mapcount and
> all page mapcounts.
>
> This sum is what we actually want to know in folio_mapcount() and it is
> also sufficient for implementing folio_mapped().
>
> With PTE-mapped THP becoming more important and more widely used, we want
> to avoid looping over all pages of a folio just to obtain the mapcount
> of large folios. The comment "In the common case, avoid the loop when no
> pages mapped by PTE" in folio_total_mapcount() does no longer hold for
> mTHP that are always mapped by PTE.
>
> Further, we are planning on using folio_mapcount() more
> frequently, and might even want to remove page mapcounts for large
> folios in some kernel configs. Therefore, allow for reading the mapcount of
> large folios efficiently and atomically without looping over any pages.
>
> Maintain the mapcount also for hugetlb pages for simplicity. Use the new
> mapcount to implement folio_mapcount() and folio_mapped(). Make
> page_mapped() simply call folio_mapped(). We can now get rid of
> folio_large_is_mapped().
>
> _nr_pages_mapped is now only used in rmap code and for debugging
> purposes. Keep folio_nr_pages_mapped() around, but document that its use
> should be limited to rmap internals and debugging purposes.
>
> This change implies one additional atomic add/sub whenever
> mapping/unmapping (parts of) a large folio.
>
> As we now batch RMAP operations for PTE-mapped THP during fork(),
> during unmap/zap, and when PTE-remapping a PMD-mapped THP, and we adjust
> the large mapcount for a PTE batch only once, the added overhead in the
> common case is small. Only when unmapping individual pages of a large folio
> (e.g., during COW), the overhead might be bigger in comparison, but it's
> essentially one additional atomic operation.
>
> Note that before the new mapcount would overflow, already our refcount
> would overflow: each mapping requires a folio reference. Extend the
> focumentation of folio_mapcount().

s/focumentation/documentation/  ;)

--
Best Regards,
Yan, Zi

--=_MailMate_BEDB01A4-F93C-4BEA-B07C-1B36C5E3E053_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYVoXAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUkTEP+wVZyjGvJVuk2NJsfh3tHj3THhkXQT6JLg4f
Z9ZEUxFY+Qi7f5ZNZtEt+B1Z98we+bRmjTBwplbnuU7gEUOe2s6yJy2INH1PV0LU
8bABPSURC+R1/F2lVj+2SAMk3Zwahv4YtsDfQrtCgcQpAXVXgyAoknMNewoUPy76
ZjwHSn7f0eg/CNCuSvr8usVjicaCkritgN/LFY93RylidI4ySjA0fWIkD9aQLtMI
ykZKxilaqW1PqmYHxDrUPQJpQMyrbnu1HWe6WFHpM+C2KRb7zdc4R+zDAvRwtw9B
Dn4aTB38JhsCCgO6pudcDLXb8UKe9UY5q4wzCtrtKi4qmduN+hxa9Sv7RNYA0AYM
TXaKTst8zlpXPw/dg/TJejbHepwRwmAYHqX0Ks5Nz4PocJv52kfwG4zm7eDFNmAq
4SU2kg9JrkJn5ysPmLTVOVKNd/b+I4ry2PEcAroJfIMkceT4XkPz6Qlb5eQ5/K8O
z2nY4sU7sm8a8hRMq5WrYaIyGoOaCx2mcXFvr1P/Tb0Di0wnCyB6skcp+Ct8lLqh
BaP0k9trLzItOdPYEO94hrBBxODkYb/kpPfmbRCS3S+ONZ44Ji7V4s+Wr+It+ydD
O/YZ8jEqwHJWHNbtiiNJ3D6iJ8EKA9+SaHs0Hyxbb3D9M+5DBeUgBG4m3k3ggR6f
mCcBQLZZ
=1QcW
-----END PGP SIGNATURE-----

--=_MailMate_BEDB01A4-F93C-4BEA-B07C-1B36C5E3E053_=--

