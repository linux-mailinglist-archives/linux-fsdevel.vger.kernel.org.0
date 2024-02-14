Return-Path: <linux-fsdevel+bounces-11568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8364854C88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 16:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1501F23D66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 15:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420D35B03B;
	Wed, 14 Feb 2024 15:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gdc+JkUy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADA71E862;
	Wed, 14 Feb 2024 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924076; cv=fail; b=Ebp9pKkjQ/Uo3zF6NRe/sG+l85dDTfabcXp4GSRORBv6HnFfdlScWoZNS+K5FBcPVXhsI/SHdnOszeypvB5XSdWIW7/1ENg4xh9ptl0xr/n5CsXrrPG+3+P2F4slq4pj390EuOD11N9+u2tvyAbLBGKzfgWN4h7mtD9pX1YgsVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924076; c=relaxed/simple;
	bh=0CHOV8VSyvqjgSroPGxd05Z8HUagJffoWItgknoikwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W/EMzcOzrJOQLkTWn0WKHg9SHgM2O/vIPlDNiUqOUkGRQ26k2Ea+aVerMoNevK8Rjq1u+iRxWS064+TksV6kBsV5dEVYIwy/Al4rBY8hPn+JFZmhc5D/7Xl97m0UPLQfdu+a1ho8fu9opy9gIh6evvDNFuBKy33yZr/cxaXhib0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gdc+JkUy; arc=fail smtp.client-ip=40.107.96.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Un7/o/6ZfpyOdg1hJspDcTPPSazX/kxt8sdk7CupW1xrMf64wLQYiPc3nHA7+AEhXyxuKOqQGwBj+5uaw9+L+HLrMRI/Bw6AfH72nHR8MDnsYujvEYhJBowTtVI6WfrvLeTMujbh6aAjFDL5jb4oqRsvvAGJsyR09LPu2VR1UlY2dJVZM7xxWKF28PoBvQCLD4tY2cof1HiIkjpid1YCVA2UBvraOfCEQlfHKPyek0/2qB9gt3lG7bnhhFrlHJ6W5QBKccPXDWfkzxoqnBwG2NyIV/JovnNNuGCdysWMApy3bJIJlLJOIZhkanvZZTg470IHQolnZs9oP2Vnsd8mkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIjWTQKbgzelINPM7zLMfjV7qSnxbT90u422OuTB4GE=;
 b=c7yEy3REclEfY2Bktlfdy/0XJEsw1UffqwoJ0ZkupJfbk21iaXa2bGVfxTqR1gJyxmxpQ0nyH9+uM59/W0KuibcYgdrw6zhPR8rQifL+5BLZ5EqRNwktg7sunXCJ62262GiIuIQAfQlHemtks+oIobIHDltHe32U6TooTUqJxUgFGGl7Mmf3+HC9TjKxffOAy9Se+JgXZrhLILSjiT7+Y+NeAb24xvpvGliIX++oKrLDSEL0zlsyaJIPD7B0b89Nv0a6oWN+Of1NqvcVyZ619tYPBYFgtDEJxAeHxgWBrhqaigdAl7BEzeYn9yr/ICkVi2vA0oxJkEESrKjeI20lAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIjWTQKbgzelINPM7zLMfjV7qSnxbT90u422OuTB4GE=;
 b=gdc+JkUyuPjHg0tCrohgrznJQku2MEhGHhWmgak9S1siWWTcFMb1JCFbJdnCUFZmbF87KhI8P3mOEola6i/sK25WW2w+oSHuPMdP/LRnUftJZrqsT3OgiM58MAxOVl6rmfvrlpO/3BBq9TNB2/78C4iWA6/e+p0OD3aMLHeP2Axq5TMj601hiD5fjjFHdfKPgcS01cdTmdvKTuxmaFe3btCmh4ycP1qUG5zfLV2BMzDM6eUdPD4VXpsiH68R36NzHJa+3OsLM89xn4G01T9hzRbdyaOPAzWQMPLa9i/MI8f/7pDXB/3O0BgO4A5xQ01J74Qf8m/kwj1mvo6Ck0QhXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB6609.namprd12.prod.outlook.com (2603:10b6:510:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 15:21:12 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7316.012; Wed, 14 Feb 2024
 15:21:12 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: "\"Pankaj Raghav (Samsung)\"" <kernel@pankajraghav.com>,
 linux-mm@kvack.org, "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 =?utf-8?q?=22Michal_Koutn=C3=BD=22?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "\"Zach O'Keefe\"" <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Mcgrof Chamberlain <mcgrof@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 2/7] mm/page_owner: use order instead of nr in
 split_page_owner()
Date: Wed, 14 Feb 2024 10:21:09 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <C3807575-1599-44A2-80AA-AA67FDC5FCDE@nvidia.com>
In-Reply-To: <73b550a1-05f2-46b2-a0bc-574fabe8460a@redhat.com>
References: <20240213215520.1048625-1-zi.yan@sent.com>
 <20240213215520.1048625-3-zi.yan@sent.com>
 <73b550a1-05f2-46b2-a0bc-574fabe8460a@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_5952DDB1-30AF-47A2-991D-4607F38B8F69_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0053.namprd02.prod.outlook.com
 (2603:10b6:207:3d::30) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 975a3cd7-42fa-423a-1a6f-08dc2d7093eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QWFSnRYPvwGMVKZPygmfPXI+fPNI2i9QSJw8waeYZBSg9+hN9A8JhCKcMlYbVyeXwbo8JwuSORXdpqcYhokaYAERszThdcAiQacZqUlu2tRzsgzIRefbtKrZPnWokMYY/w6H10cO73tgJCUb2jTanxTirR2oLAbloGoUGSuGsW9ZL1q9fDTOSUsTMEIp15BB5SIzNCSWcb9NmQUQ4/G88wHlDEn5AefcOq0KwLqH26MfqK6m/5lA79ovF4tAeAWkHsEQnjBP7KjF5/MGl/mcVuE5QViJnqv1ufitonDb6W+T9SPkpFEGcuJ/W9OJWOH3MXWkX2Rsbp/O/YDbOF4ZKny0GjeeEItTVu+Cyrp9npQDuUhI2wQqOhV8UnyUGgQldhU5MizI2nrAuT95IraUJ17lrNDbRiGyVwbmfI6e9uapPWC0u7LH5a8g4g0Rfana4kOnXgrb7f1zQiLWiiaFDC3sUaSlQyN1T+YE7LjP1qraiTmUrD2OC6k2Z8MiZTDuXpmBgKm4O7nVS+YKAR7ucH31VBzfmBX++lO/L5xwd+asRziuTFCjdZTnxIrOXRt2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(36756003)(2906002)(5660300002)(235185007)(7416002)(8676002)(8936002)(66946007)(66476007)(6916009)(33656002)(66556008)(4326008)(38100700002)(54906003)(6666004)(316002)(6486002)(53546011)(478600001)(6512007)(26005)(2616005)(86362001)(41300700001)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ndFZQEQ2Whs2kpgS3e/Ent0andbycVW4FLE3spdthHd3PfwnwhIEOpNxZ8Dn?=
 =?us-ascii?Q?HmO1FsrTA8bGkGfBqO8T+wGP51QD4KUHIcZfesocdK/oaPTygzLdcxP5PxpL?=
 =?us-ascii?Q?IXrxg0zglO187FPyl6caXclh2+nsm2bPZ2n2wP0uv+QBVqNlbFeuJkQ2yuFZ?=
 =?us-ascii?Q?VKsDkR6XMc273P0TJb0fQHchOA8rf1hgGIfoRkQ0PRQDn1aWCWK0lJwf+sjP?=
 =?us-ascii?Q?aHQr6Dqx3SXViFJk0uKl+kwF7odQ9SbnDxB17bHxzbSuHoFDj1Zgcxa0OG75?=
 =?us-ascii?Q?KcmsDnZsw8W1ALODusLNqh75B8DOMUXFN0RclQkdP8gLOkRBLygnrWA9lkfc?=
 =?us-ascii?Q?rc3cQEc347mwyLV0kRa6KehY2+BgZR4XTfPrg7OVj+sunen+ly4qr1lsRRdA?=
 =?us-ascii?Q?LxcZaIDH8B0Q59ynzfyFQz79v7ZteX+BS4wbe3hnTbnVVu9GTIuEqzu4NiNT?=
 =?us-ascii?Q?i++xPjpZVxUtjNoYegxZ0XboI/3nSZu+rDUVopPl0WPBlwhAyJCr9CBoJhEw?=
 =?us-ascii?Q?tOUr+wINB+kKDY72A2cJsYPIJFfcUVPHtKrnLPI1kVMCDYz7/hklwvjsPcY9?=
 =?us-ascii?Q?eS4vM4rvKqABKIO7AS1gBZyP7uoy6NQSa1mWFvoXLn7dseCHAfFReh2rWBTy?=
 =?us-ascii?Q?/hXHFcUHQSbuE1qSSdL31wJ2lOE0h22GbgC6t1g5xu9Exls9cFhNbDi20Ewq?=
 =?us-ascii?Q?qq9idXsEdjrN0Y6bybgdlZeejq1n6cmULZkLzhOb3dRe170cMmU+eEjmCQDm?=
 =?us-ascii?Q?ZnQ6bw/xuSvP12uxQVw9AzazklTpP/RzlaEl96Lc8CxD5BJDzMRSTY9Lzszi?=
 =?us-ascii?Q?fRHM228AM/pK8bjpbMx3dvWLMi1vPaHLpEbV7EuPbR0nQtdmj+ciD8YVYsP5?=
 =?us-ascii?Q?VDdabTkTl/Ljg5Okf4Mf9VQ5IIa14A99mcFFOpbaSUqiDCTpBGMN/VtqwkUQ?=
 =?us-ascii?Q?2xV6ukOpSxp/951hKyCheVLesu0aFDCRWfY3AmpRy1IEPAFL847OiRoQL50j?=
 =?us-ascii?Q?vhmvQmqCLVgCVsdqckg/F4/Ytbusq/ERkyJbkNz+iYdq8qdwySDe7YMvEM35?=
 =?us-ascii?Q?gBZKYsP76QkDdK22JRwNeoOjE7FTTV23sBT4zfaa9st8AtUrh2xGkOg7wbUq?=
 =?us-ascii?Q?H0SxYZG6EW1ZYzcFoj2Vqq8zkG0TdhLK1U++2cjN0vrQcF0AJgWmPys2y5MM?=
 =?us-ascii?Q?aNoX/jeDvJTjLeRerTNYnS7MessygMcAEvuSu93hzJdSEKeqlZ65VZ/7Ne+4?=
 =?us-ascii?Q?cnVq733m21LGcTkwKEGhu/gJkUKWkDIKGh+VJmELEOC9tUAMaHUFEJLXdT0L?=
 =?us-ascii?Q?3hr4xu4K/GjPOsudDUsf6NPYTsLW7y0C/OKFP+Xz1ZnoKB5DRBAOz8m6wrV1?=
 =?us-ascii?Q?H1dJOrDuhAmV93mRyQhRL0aDm5thY3USDV00Ue3l5Qw3o1V/TPfEIw2hMg8D?=
 =?us-ascii?Q?Cwi6qNuvxigM5LHZoJ88DSq8SlbeFs1lCqo1I0ZXikURuj6OlrALJTjQoq6C?=
 =?us-ascii?Q?dYFrToDsMkSMo67vWNldiywTXyF8e6U3+g1Kh+47Sx5SxbUZRmRHh2uvknB+?=
 =?us-ascii?Q?zvYbop3f1CLcee8oMeMLQ5LOxLE+97gTKr2q/Lm4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975a3cd7-42fa-423a-1a6f-08dc2d7093eb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 15:21:12.2480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4C9S7ZhA2LSjJXCEuX+8U5ZoNOPWQFwwpFxkMOfBsTyh4avAB5wdN/hgj0ysR2P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6609

--=_MailMate_5952DDB1-30AF-47A2-991D-4607F38B8F69_=
Content-Type: text/plain

On 14 Feb 2024, at 4:14, David Hildenbrand wrote:

> On 13.02.24 22:55, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> We do not have non power of two pages, using nr is error prone if nr
>> is not power-of-two. Use page order instead.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   include/linux/page_owner.h | 8 ++++----
>>   mm/huge_memory.c           | 2 +-
>>   mm/page_alloc.c            | 4 ++--
>>   mm/page_owner.c            | 3 ++-
>>   4 files changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
>> index 119a0c9d2a8b..d7878523adfc 100644
>> --- a/include/linux/page_owner.h
>> +++ b/include/linux/page_owner.h
>> @@ -11,7 +11,7 @@ extern struct page_ext_operations page_owner_ops;
>>   extern void __reset_page_owner(struct page *page, unsigned short order);
>>   extern void __set_page_owner(struct page *page,
>>   			unsigned short order, gfp_t gfp_mask);
>> -extern void __split_page_owner(struct page *page, unsigned int nr);
>> +extern void __split_page_owner(struct page *page, int order);
>>   extern void __folio_copy_owner(struct folio *newfolio, struct folio *old);
>>   extern void __set_page_owner_migrate_reason(struct page *page, int reason);
>>   extern void __dump_page_owner(const struct page *page);
>> @@ -31,10 +31,10 @@ static inline void set_page_owner(struct page *page,
>>   		__set_page_owner(page, order, gfp_mask);
>>   }
>>  -static inline void split_page_owner(struct page *page, unsigned int nr)
>> +static inline void split_page_owner(struct page *page, int order)
>>   {
>>   	if (static_branch_unlikely(&page_owner_inited))
>> -		__split_page_owner(page, nr);
>> +		__split_page_owner(page, order);
>>   }
>>   static inline void folio_copy_owner(struct folio *newfolio, struct folio *old)
>>   {
>> @@ -60,7 +60,7 @@ static inline void set_page_owner(struct page *page,
>>   {
>>   }
>>   static inline void split_page_owner(struct page *page,
>> -			unsigned short order)
>> +			int order)
>
> I assume this will fit into a single line now.

Sure.
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_5952DDB1-30AF-47A2-991D-4607F38B8F69_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXM2mUPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUO7MQAJIw3V18hQZLRE71hgMC0xvuHC0wVVdxnS5W
ILnh+/PQ5iRGKPVGXZN5ymyrZ4yfkfRy1m6EaWH60lS2NmMHl9yxIo+ytbCOFa3W
mCGlcJSWrqP6LUmNUnkcw2y8QlTvFKIr8Do/1tHcNcXtDl0cDb9xcJvPfjnRcvvk
EIEFZvCOG7TImJz+fvmAArekkuRD0TJEsSdVX59k3On+N/oyiw4v8PjJsek4GJIr
+A4vsCBhvdDqNiSQB+OMhEM3vphg0LETNcsYBKTxDZWv9D5h57zoBDGu5zwmwSJv
7Ua0Wpby7N304SDGaJtOrscVLi18i9SD91OMXFK0YuT/TV+GriPvmdxL7Ub9+FH8
L9LgPJewpbH469eMYR3ZDbQFczrASKNfdMFJtWRAQOuCFawz4dMZMLnf77NiEuKJ
tczHT5bH1s6i1SfN3C7EsaNeNASH4EZpggjbCtGeb+e6IiWTbn99yuTcuG6BQ1F1
FCKUi2y0TO/o072jky7SiS5WtWD2D1alX5W+x+2NomwzoqD51OaFA8Gsvxaazpkq
MkpxutmPBrqgc+jqjHVFL2NbAmtc1YdXYouW4iZgsiIP7zR55FQVoN0UNcVg4x3D
5rMBfZcQ9m6RiDqAGqrzbp1MbXEYtLNdkmYOtrTgO59R7fyYaK0Q4nPXY/6e5WCf
RkBpPg1q
=CbfZ
-----END PGP SIGNATURE-----

--=_MailMate_5952DDB1-30AF-47A2-991D-4607F38B8F69_=--

