Return-Path: <linux-fsdevel+bounces-13894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1724E8752B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 16:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2646C1C21D26
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 15:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739D112EBE9;
	Thu,  7 Mar 2024 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OWmOPe1l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2709112D754;
	Thu,  7 Mar 2024 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824017; cv=fail; b=Mu1xQHwW/8IyE4MLQ32XwT5kgAzmlgPID6XBdxZ+AHTARjz0obosLKcOs+lijnw5YTxPCjwyMHG1N5QuVnXU71zwuzEWWzyFUzbyXpm3rQgssAPHkpVD1XhgqnqWYOSNl5RJ3g0BPjPN6zwG+08ytXHcsbcxwf7Ms1ck14AV8+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824017; c=relaxed/simple;
	bh=7U770x2JGyDt3oAKqNrQ/DJ10AM47r7OOfJcGNT9R+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d3hmXA6ErG2qpiQbeAihj2ROdwvztWMogSA+KvvL2MDleUtsllhXxDOg4qMD5Vb7e6Hsnd6glECIBFg+aI+T7wC1l3KcVguCNYqrNlS0mpDCFwjvz37v7dCTzah/vF4nAE69P9vLfk2N+67/bul+Oe/T/IPZMe4aBEoTLGmHQ5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OWmOPe1l; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGF9n/7mFzz4dUMb0hPcBX792nemM9iow3mAhJkyCYANE1TVte71T5cPXOsPl3sZcoZZKhf7rfpTJ6S1K+o994AJplbLLKYoPsRbPABXiBijUxBtOTOgU/AvtHq1/n3PUtNRNlLTmnHjc6aqO+o3rwK3EOnTlwJi0UctqVTr3P9RklOBsIr62TQXBkVmS9RPEkooRo3wvOJx46hh5AgRmKZ6o64s4/tdtmlDnloZxyLKvzCIgLHe+JGPkmRC1SiTL+6TD3k1KUcBifeH5/I7dI4zk5wZ6k55URt++J2ojnWsEJ5Wb3YuuwoldrwpbIr9niBIQU33rDgWWei35AD5Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/t4awHNENCrzT7PXz1EhZuih/n8xxG41+41iHAMOlSs=;
 b=gmcN4d6aj928kb0oURK+xrMrq4CRn3et/r5Sd1vtbfFoYXtwyWEsquJIG7xhCBv28BmEPzWonxrs8+rr30aUorUj2fjwt05Hh45rqtBydHcEx3aE47SWhB5/oS169nSCcgQSQsuYY1GxzBHva6AIP9yZ1kE8PAbv7fDbzPJRTULE6PQRZSxscaRC5gLilo+DLVNL3sSjqapGe0t94M7VKxlaITuvaL/+jQFK3ZEV8mObP+487tAixuGdp38TJVpS06PXZu7fd+itnlf0QOx/+BFKhCo0pqUU7NzKw0mtFFMJyMdssVqxW5O66bVW+k0FEEimmdxqAFm3FYOps1q77g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/t4awHNENCrzT7PXz1EhZuih/n8xxG41+41iHAMOlSs=;
 b=OWmOPe1ldZ63rYSkdLrO4o/44IekUvDuVmcUukYZidlGGAZZNSrE/kkh54KJhCdd6n5TwmayLovz5C/T0WWKP7l8YDIx7AE5GbScrYW54UCr3iZboEGqK9TedAQMKGVAaOd+fP/bv+h4+Op3xMrzoyI+k/rYsjDqG1Dw8dbirhx8X6mTAlXrM4TPPQvI1mtrhf/sGRzZQvnxy9icwJrq6tyeR1OE92uGWMqoraeiRc02kCWI61nBWt9OpzmBxSJt4aCT9DF3ajQZ119NHnhwjFuZDiFtmd/K/e97qOaorids1yA+3Zy1EpMA9qFU07kXoiYOfNp16XzAA75XVtkuTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 7 Mar
 2024 15:06:51 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 15:06:51 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
 "\"Pankaj Raghav (Samsung)\"" <kernel@pankajraghav.com>,
 Zi Yan <ziy@nvidia.com>, "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>,
 Yu Zhao <yuzhao@google.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 =?utf-8?q?=22Michal_Koutn=C3=BD=22?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "\"Zach O'Keefe\"" <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v5 8/8] mm: huge_memory: enable debugfs to split huge
 pages to any order.
Date: Thu, 07 Mar 2024 10:06:48 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <C9E1C776-3861-40EB-A0DC-E2B849F9EF9A@nvidia.com>
In-Reply-To: <20240226205534.1603748-9-zi.yan@sent.com>
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-9-zi.yan@sent.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_5825334D-80CF-42FD-970C-0B4B40F2A616_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0331.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::6) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb2924e-fff7-4cfe-f242-08dc3eb837b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f0OoEb0zdonR8LBnGGj2N2Me3CzGplCKC2gkSZeUwNhWQWXmtmDv6u9U723HcI1lAYz1v7fHJR+mcwn1R7Zk3GVCzDod4okNZBEErl3D7nUvvjNiBT2gMUIKnlKb1NP9wrk/21RdbKeMHb5/q6BWgGS4dBMD83CSWU8eph8m1xGpmflbeS6YR/BfGTEqU3sMytLoFAu0aG72GFrtRgL5R9Few6uEMHOx7xUYXjHYKuYqBlGYoV+iP4qOdYWTp3/vgTBmSJgGc6h22i50xVKqHl/GNFhs/sYiQBpFVHJD4QHUXbmEoWsdM95LkH7nV+taqUqG4Rja0eIG08s/m04fjMEVZOf5sawSobKnRBqa+mZ3lCrT1DfDH6sbQnfCq/D6MbMxu6VMJrnfXT4jUrAyQfUJbLSL/Qn0/ZATQrJDRn7yCwbvmP2SQdZozJYH8DYYLc3a2hFhq8/uNJurMEhs9J6mDpjYp+H3Yi3SIYByjI3PKsW+PPTQ8eDIUDA1NpNwMiO3CM60VR6Jtmvty2zlJL77gPkJU97Hh6mIQEOJNhdBdfFNzRvjIP/Sms9G1CS0LkIk1oVd4v6EDtZu+BTtPmNbvnnXy2D4rSL3zaqEZzjTN/9kIF75yOagWzO02DL1vCCZWQWlwY6INxOdN10SnRSTVL9sltV0dnzRrCXYBbk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H5V5oNRiFEEm3EPyKagUQU9Dd/d/Lc5PJs1hYAR5Tv/Ou64+52h6FvXqrx3K?=
 =?us-ascii?Q?xStwAQzcZQrO1Sus0m0TjsW+XwvhFa/+A7+hD6EDFg7Pd/ejyqFqgK//ee6p?=
 =?us-ascii?Q?OcrvVId1ytyxbpMs91dvzQBPkKiWtyTaDQNwKD5U9o0GXcHrOaj6NFOqLdt+?=
 =?us-ascii?Q?ZmGkxPoW+uJFmHks/EtEM+iWtg/PhyVCZTEi6K9tNGiUyO0DK661Zgmy2Zkr?=
 =?us-ascii?Q?N0O4mMBptM8FUcpH0seT66x9wXJtUff3csGCpcnx8lUJcdVq0d+r+ysGPvRl?=
 =?us-ascii?Q?Ym/okHwOELSUY6lJq4FQAhrYJqe8TDAnDB45zNjVg9MrLww6q+6TBPBnu3zw?=
 =?us-ascii?Q?p8KnD2aS4qxP5T3ohPNQcCcIjLSEX4PdPZIfkpe+ELA2XAKbtEEww2aGn74b?=
 =?us-ascii?Q?k8VO2AhuChzMacWE6OeflbPMrkHRQHwPQjgDCGZgEMHNawKMDoPA52FO+6An?=
 =?us-ascii?Q?QcO976g9rIpCR6T06YFLZCJrc+y0Ge6L6+lfYYPJ3Oe5sihhcvaoH4VTzMNu?=
 =?us-ascii?Q?xw1KIb5LS2OP9WYlrUEYdcqNZt9/9gaLSXZMEd5GUED/a+/NnStLP2lsBro4?=
 =?us-ascii?Q?+5oGeJXYwWycbuwGfW/0O+cUs7L3rbmHElzLp6JyvMVk3HgD5whNmF0xOkTR?=
 =?us-ascii?Q?VlUJq1aRXpTnmXkTy7kMNa8dnbCXajMvSQDyJ851ZN+Mi+6Z4+UFdD1rUUhq?=
 =?us-ascii?Q?YQKRhgr1P/u7t3bSdWjDaFLYJyUsU5c6LIBsHM2PsGf/blUWx41j68kweYt9?=
 =?us-ascii?Q?5QViVzNP9+kELThQmldxLL/u76pD2l2m50nk13Tf7omi5dYfgIn7Wud68za5?=
 =?us-ascii?Q?rwWUGMN685bBKEv9jtbAChQZBcC8SAgHCh305MgJNiYQx1ILf+xpksNWGBzY?=
 =?us-ascii?Q?pxe3vmSzRJpWRK+2Y9Gn1ZspgFEsyWpdur8XLN5kSis3klF4GUZ0h3uyAknO?=
 =?us-ascii?Q?SmpEQy6ORQ/boBk7y5o4rEnaU1jQm0Kc37yMsCYeljENBguRapGk/w/VtmOh?=
 =?us-ascii?Q?EoXOyqwmifr/wVab+kYWEQqqxzxW7aZAOg2e876T6UIJHzT17QX0hRKDWvCr?=
 =?us-ascii?Q?/L3T7E6w3EgtGWioAJWbcqtggA9dcQfxIWQtOfq3Irir0Svhq1HZMAohv4VX?=
 =?us-ascii?Q?PXOugO8diLooztNUFmyxlj2MmmavDXMg5MhNX2AQkqQm1j9X79rNRqEfLEhE?=
 =?us-ascii?Q?1dYRB0kaMyobXSrpoe5G2z0RgoTSLRwE5CnMgz/tpc0EK0bptuUNoHg2EQG1?=
 =?us-ascii?Q?NLXmo2iR9OUafys96xOdYsQ4oLZeUTllpeAoLBQsD29wwIZhSOztpO1wJ9q9?=
 =?us-ascii?Q?/SX5TSVqK57LtkROY9mm99U0E97rIcp/+xqXNocfnQBr8M3MDlLD+yjwblQa?=
 =?us-ascii?Q?13Ce0xTkxasQrM2wG8w79ha1kSv6l4b6eIzHGfaWjhZ0DAiPoJBR28F2Dre9?=
 =?us-ascii?Q?mRWebh35OizYMESZZSUXEgaBYMkOvfoWnb4AVC6vbU5Tj6MJJeosicHa3ukW?=
 =?us-ascii?Q?3gvQbQCa23hfcm8F/MjoVIgcg7Uv3OJWqhj+DTVad8garOHPWSH/AJZLCCjM?=
 =?us-ascii?Q?OzPKAb7gM0VXx/mpXfEA7E39Qi2l4jkYO6MTUUZm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb2924e-fff7-4cfe-f242-08dc3eb837b2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 15:06:51.0745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqP7vBq7S+tJBxUGGQ5L8W8SZVw6Op3MRFlX+VWRcGuAzrTr6vLyhOonPkPLfI1+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510

--=_MailMate_5825334D-80CF-42FD-970C-0B4B40F2A616_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 26 Feb 2024, at 15:55, Zi Yan wrote:

> From: Zi Yan <ziy@nvidia.com>
>
> It is used to test split_huge_page_to_list_to_order for pagecache THPs.=

> Also add test cases for split_huge_page_to_list_to_order via both
> debugfs.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/huge_memory.c                              |  34 ++++--
>  .../selftests/mm/split_huge_page_test.c       | 115 +++++++++++++++++-=

>  2 files changed, 131 insertions(+), 18 deletions(-)

Hi Andrew,

This is the fixup for patch 8. It is based on the discussion
with Dan Carpenter at https://lore.kernel.org/linux-mm/7dda9283-b437-4cf8=
-ab0d-83c330deb9c0@moroto.mountain/. It checks new_order input from
debugfs and skips folios early if new_order is greater than the folio ord=
er.

Thanks.

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a81a09236c16..42d4f62d7760 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3484,6 +3484,9 @@ static int split_huge_pages_pid(int pid, unsigned l=
ong vaddr_start,
                        goto next;

                total++;
+
+               if (new_order >=3D folio_order(folio))
+                       goto next;
                /*
                 * For folios with private, split_huge_page_to_list_to_or=
der()
                 * will try to drop it before split and then check if the=
 folio
@@ -3550,6 +3553,9 @@ static int split_huge_pages_in_file(const char *fil=
e_path, pgoff_t off_start,
                total++;
                nr_pages =3D folio_nr_pages(folio);

+               if (new_order >=3D folio_order(folio))
+                       goto next;
+
                if (!folio_trylock(folio))
                        goto next;



--
Best Regards,
Yan, Zi

--=_MailMate_5825334D-80CF-42FD-970C-0B4B40F2A616_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXp2AgPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUhpsP/RMEOphfsz6mw6X0nPE/lgaxZKEYqpHtRaTu
cewPtaNO9BtcaIEWVvYqHk6gcBEXhsWh0W4cRQC1ONnJciUeZ5lYrA/xKw9W9VyU
dtyTP+Nu6/kBiCeP4Z4baP8T1H0RKeCirYI182CwS9IOqSlr5hwSewEItlhHR3dq
plJdNysUI074Atl/vfExcz+rng9RxLK7g2iy8npcGFykfD4ZhUE4J+519MtXTTdM
jEi+c0ASPpSsgvJGuW+0rqnBu3ziyn70YquyTqd3aYqar9RkqkHE5CUhOtNqnWLC
/VWUQY0pxNJX+4AN4DzWRrIjzd3QByiSJx4O1lPGmHrF10h6bycKFlJjm6BglSbc
mLaN836kOc+z+cUHeUXk7EKatYT9yX7wQt5F7iTBbypGpOVE29VHqvMTRmRZfbgP
V3lyTt7Vrt0/Dj1t+DoR3lUern4uM7s6LCeqNREP3XsapHyq1sJSFRShtCHl40eH
BGCmPD90JQUTklMOaTftf7imTh56OTWSUZmLq7W+ajOtNmHAbyq65IAHKjG5uBX6
REZ+U/8cogbICxvahLqGBY2wCItt9Lz5hdOkBVYlAzy9F1sxvKBg63OM3A9VHaOR
YifGCAOG1J5FpvLQGgFO0HgkNvmCUf/cv1HkF4Kf24GVj4Il1zZSHYoSoNYBmoiq
5Zbv8emL
=QQIE
-----END PGP SIGNATURE-----

--=_MailMate_5825334D-80CF-42FD-970C-0B4B40F2A616_=--

