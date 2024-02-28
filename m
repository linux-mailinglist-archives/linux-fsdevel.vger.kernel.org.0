Return-Path: <linux-fsdevel+bounces-13098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAC686B37E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 16:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C139C1C20C3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 15:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E4915CD67;
	Wed, 28 Feb 2024 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ajH7HHUR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D7915B990;
	Wed, 28 Feb 2024 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134969; cv=fail; b=mRywoe/7aJ5+0FH+OPeH97dffH0AeZ25j0yb+DYpULZIIz6AcZmUQMKmXjoPTXJkobAmENlCkeV5QE43jrzmnvg4TvDqKCxbmnd+qVjtgfikkObCAcS2BsBRzu21ECJkP5fU9VtZT8+sWIg+j9jNqZIhywNl3RoM0OjzW1stgjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134969; c=relaxed/simple;
	bh=zHZ9Y1ZkW2djjrMWLDyheFradxjwOD9drtVhmEkLbe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OpWJJqFH0S/b7jAnS1HVbTO2oo9z175OlMhypHwcW8Y7rq0gtbVkycIlrmQYvZrDSyU6NwM3MBJSBlumfDjv06nfnEHb0y+71YAyiSynWXZz5SHlbtuaIn3gVVjkd3QYHbFTVXDsWr2YCu2nj3h47RWBkOXFDrGSrPiFOAy11vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ajH7HHUR; arc=fail smtp.client-ip=40.107.212.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+RAp/Dag11P8ZvXAQy52SLcmahpSd64LksPgfajJ1YADDLoNgRvzrj6Q6ryKENnvOn5eAjgwUR6kYd9dnmPTnyjkYyyn1xu1pcSJG/EBAIDjYEeOBTTZzSDpAmqwXWuzcjEopRa/c/gvgdEQ0rLDCIq1tM38i7pv4fnndOife9GUYG9Y/T+Rv/vPW78p5A056azE499/uwwFs241D5Ivbuyuo/7eHYJlASGMF8JfZzBv9TK+MItgIxzeSX+DqAt+WBcU7yTlIDmu4D2Gno9e1FK5uiRd90sQfTx4wTEKZRCe2NWrJf6u2caNUnVI0g14uHgRrsCB4V/cvDncUZgMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7L+HfBKb4LcJ1tRds1NoB0sNHArvlsHFYOICkx+nYPA=;
 b=X4jvq467jMl+MxSGjuKFKZhwn0FhrBukvnMFMc8uFDEXLBeK9EdwTDYUb22HE3JTtUnDONBKvkE2FoMETdcb9JcmlS1XwZV6IUt1XzXg7iMtODeiB0QD4lcHGjfyeSdA0+sRav8j0hOmetKiMLMwOD/DmkZF2EI4NYjODIOonpzFBnzFtiVdRlDrp2Qpo0Xkaftp0/8F6veiOL/LiaIBohWuq15RYlOtalQJQHeVrwcgGwFUvev8i6TCerZ5x37L7iyodO1NQni7YxVkcgdd2ScsQtf+TSs6bNPmmfauNifDAJVsWaIk+EnNDU9Ayg1atwLAyKIV5+KZcrg8mfS5Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7L+HfBKb4LcJ1tRds1NoB0sNHArvlsHFYOICkx+nYPA=;
 b=ajH7HHURy3T0vhBubtaVjDweeYF1xujVkIsNUtPMrMA+Khp12WiJ7Zn4xMGb9ki9x0NPk/A+IGHDuCvYS0LWKuHf8BzEK/FB3tQ0uqEzz8CBHqfItsTqsrzIp78SMcY8AF8yW7V4x/jFsEFx6RMApBTVNIISJxVh13/S4oBLr9KaVJaoYgIUYNhW9qlwKMQQHKoOsYAM/eIoi5Ufi+kLIfDDfzd5S2O6rEyMOHDcL4c4HgO9ThIs3ITRtUUvRPDNppZYTGo8RHSBy/yvLKZtgnH2yqz1VuOIraf/gOXHKAs4eFViTFrehDX7fLRDOjvpzV1t5tCAGATpriNqM+99DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 BL1PR12MB5899.namprd12.prod.outlook.com (2603:10b6:208:397::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 15:42:42 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 15:42:42 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: "\"Pankaj Raghav (Samsung)\"" <kernel@pankajraghav.com>,
 linux-mm@kvack.org, "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>,
 Yu Zhao <yuzhao@google.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 =?utf-8?q?=22Michal_Koutn=C3=BD=22?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "\"Zach O'Keefe\"" <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 7/8] mm: thp: split huge page to any lower order pages
Date: Wed, 28 Feb 2024 10:42:38 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <BD595F60-38C4-42B1-8EB9-9AE5B413C3F9@nvidia.com>
In-Reply-To: <2ce685a2-20c9-4287-a40f-30b0f0c59d49@arm.com>
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-8-zi.yan@sent.com>
 <2ce685a2-20c9-4287-a40f-30b0f0c59d49@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_D23242B2-0CBB-4BA5-A6BF-DC01014EE824_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:208:36e::7) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|BL1PR12MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca0db35-6833-4f6c-ffa0-08dc3873e6d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vYSicHLlocqUhH2t2kmq1ky9gVUUZoSXw2kj/4O+xwqR2CuLWKGrc43c1mwojIlItyNL424WXofK6EDn4y/cOjVbLbC1ooam68NWTD3OC/xtWjxxsJl7iTGqiA3uCpanfeC5P0YJ9xY69ixUSam/vhSfA2QG4psZQrD0aNcQmMNnXU2wNqbj42WuUJjY3iHPWXWgHSDfOUwHRmd2aItiiBgAS7lih+HjDIDduIrtcLl71MpMBrMQip4If3QqUg1ps1zL5VeAiUlBLi2rBbr9cCPtsDchizbsDiVoXByvV68SEHOA3lZDeoJyd17YsMs6B/NSUWDbxhem8I4/8XtuORJ3ptyZvVloTIzhlgmqv8K3VYfJCGC22kl9YUKhITkPUEcRpW6G//TQksfKLkq8HWm3lcNnwSrN5OAGg2AqCib+JkEBziHEVpIqHJu6SHTT8wxF0QSz4DnIrEehIBB+V9Tndx2/O8ZkDieMfcDUa0G/3vQ9GJVi6NvwzZXkIOkTHlXUyujOcP/jsOjwMOZTSmwOJ6jtagwF0kiLHnHz5+qWOrf836fkbHhhI1b+rEDG8mmTSPmU31WirnonMAuGKsfKrdVg4w4B3g28uCIMF/m85FvNLwz5HZzHxbq6GdjGdEXQXntKqFQYzZ/opV4IP94K+j41Ru8t78vUs4Cw6LNhqm84HHtfNSfQVJW1mRevoXJ807hD5UqtWprqvzmWhA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cciEgL7g2qrgZoW/tW6pCcPkhqH0ZAgGm2Qb6k3scnow8OjJxy8Hq5r0/ibQ?=
 =?us-ascii?Q?i8IuhJOWVNZQDzNzOykVx9MiRilQxqKQ6L7RY5Mc9xThLX1BbXnsyvOAJsh4?=
 =?us-ascii?Q?9NtN3sWU37dnl49PjOBw77qzY+HQZeHXtqH5MzBSEyNfTZsBsacRhrp/8NMC?=
 =?us-ascii?Q?hbt+n9sjk3NRYY+B6LOLAqnRpP/ladoY84aHMV7W9XA1hY1/xhabHhBMVP1a?=
 =?us-ascii?Q?KHWG5iAIYq/eNahG1Avj+sJrdltXUzsi4JsiOEO7xCUdyFmYD64n4Pu1wB/K?=
 =?us-ascii?Q?qWj0atyFgn7LSwJrMy7Bo/6EyHl6ydzaEGSszL3QWL8HOVt/VA+cmejhDdku?=
 =?us-ascii?Q?G2k2UQ8EQV8xagGVBbdELCFQyK8qMw+QgnQmXOisMPn76vhhw6mOr4dldJXk?=
 =?us-ascii?Q?4oEGrmrRPV7DO8BONkQGw1u+YhRkio3JR1HukNxwZ9m8CL2YIEac+QvXEIQy?=
 =?us-ascii?Q?VFl/3ZX2MSxEwyTef49g83wr7ci/rgiY98IfgNWCXj6a5rvVT2NBjggc84GF?=
 =?us-ascii?Q?K/p0zzYz2zJkoI6Q6cgI2zwS+sCDMp2ftBrqogbbncrbRzcqWC81fLbTUosS?=
 =?us-ascii?Q?fP/R0gqOfK+HDXnA4gG2Vq0rvQiTD4ilHaNIjyAxudamQxYfbyitq+KefKtG?=
 =?us-ascii?Q?vIfnrr7pLFEtze9p5g7nf+htxFYF42Z/jKjnRpzabpX7uOHQ7KXerI2sEKdU?=
 =?us-ascii?Q?98s+W23xbQ+20b3vIsQ9aS0PbHpvWP0xIa/WUwzCNKkKD3Y/rFlolBKJwikj?=
 =?us-ascii?Q?baNYeoTZz+LU/D1NPT7KtAvSX5GoXLlhifYP+gjm9TdTPzl17i4837RkiMT4?=
 =?us-ascii?Q?wTJApuivZ+/6yO+tfBhHkidXoKDhPY6tAPcBdNFw7cqft971jtuUeYhPiamv?=
 =?us-ascii?Q?2161ZGNzFqkjG/Rb1J/41nIUDn1cY7zSINQxy1gMRIjsQsJICeegs6vVlXmU?=
 =?us-ascii?Q?fhN7b/ggl4Wz+9LTlN4MuK37EMnQA8cwGm+gl7blaa/pMR1FtMGDh12vt/a6?=
 =?us-ascii?Q?tvhdaroSSzAmSIW+y8VHK21C8SCOMBG9jZauX6CkniX5a7VLB/+lAvwKo7X3?=
 =?us-ascii?Q?su2/tjswAAMDnaJdPGCdXFXe7gq3hDqR6mrSPsQf3D/EJPC9ElD04zogFb3u?=
 =?us-ascii?Q?j5Fm7km7urA5mDwjBdOJxl/1MVK5iJZD64Wf2atMjWBoWfK23ju28pMdcLyd?=
 =?us-ascii?Q?WB+URCSy0JGzXfpkAZXmCYduKf3wnPjap1MF/zOAmOwAG3V1A8rcFAzzPsZQ?=
 =?us-ascii?Q?ffJal8wt0SGEhjc1I2+S8jNfhUuuAYCmfhov65Md3B0aurvZvIvlCoLqG+df?=
 =?us-ascii?Q?wyTMx0OBs2izCpUSUHNJzTeP3DmfQ3pKT4Jenla6Biz/+vMrcsIeqB1ditH6?=
 =?us-ascii?Q?ZLalggEGjRG9ThDzGoBMd9Epl8lmbHV84x7Iwmng7yPT6FNtFKM+LqvGV7OB?=
 =?us-ascii?Q?4FRPk3bUGYuWbNM3T2m9SPGbjvVKqu0XtOAhzHDdTJU52w6vKRKwSFvkf18j?=
 =?us-ascii?Q?a7PKs65AKHoNbcl7cQ2gZnguywDz6xiT435VF+Oo5+U+ttic0aPf1nSCBjp7?=
 =?us-ascii?Q?CxVkwIoXl22//+C+YtY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca0db35-6833-4f6c-ffa0-08dc3873e6d8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 15:42:42.6825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDf05N4P6O80mn0gmkO5Zkd8/GFOTAs+SlUnZ6Bs0wGO/U6X8kh6pBBEqKhOa0Pe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5899

--=_MailMate_D23242B2-0CBB-4BA5-A6BF-DC01014EE824_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 28 Feb 2024, at 3:23, Ryan Roberts wrote:

> Hi Zi,
>
>
> On 26/02/2024 20:55, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> To split a THP to any lower order pages, we need to reform THPs on
>> subpages at given order and add page refcount based on the new page
>> order. Also we need to reinitialize page_deferred_list after removing
>> the page from the split_queue, otherwise a subsequent split will
>> see list corruption when checking the page_deferred_list again.
>>
>> Note: Anonymous order-1 folio is not supported because _deferred_list,=

>> which is used by partially mapped folios, is stored in subpage 2 and a=
n
>> order-1 folio only has subpage 0 and 1. File-backed order-1 folios are=

>> fine, since they do not use _deferred_list.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  include/linux/huge_mm.h |  21 +++++---
>>  mm/huge_memory.c        | 110 +++++++++++++++++++++++++++++++--------=
-
>>  2 files changed, 99 insertions(+), 32 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 5adb86af35fc..de0c89105076 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -265,10 +265,11 @@ unsigned long thp_get_unmapped_area(struct file =
*filp, unsigned long addr,
>>
>>  void folio_prep_large_rmappable(struct folio *folio);
>>  bool can_split_folio(struct folio *folio, int *pextra_pins);
>> -int split_huge_page_to_list(struct page *page, struct list_head *list=
);
>> +int split_huge_page_to_list_to_order(struct page *page, struct list_h=
ead *list,
>> +		unsigned int new_order);
>>  static inline int split_huge_page(struct page *page)
>>  {
>> -	return split_huge_page_to_list(page, NULL);
>> +	return split_huge_page_to_list_to_order(page, NULL, 0);
>>  }
>>  void deferred_split_folio(struct folio *folio);
>>
>> @@ -422,7 +423,8 @@ can_split_folio(struct folio *folio, int *pextra_p=
ins)
>>  	return false;
>>  }
>>  static inline int
>> -split_huge_page_to_list(struct page *page, struct list_head *list)
>> +split_huge_page_to_list_to_order(struct page *page, struct list_head =
*list,
>> +		unsigned int new_order)
>>  {
>>  	return 0;
>>  }
>> @@ -519,17 +521,20 @@ static inline bool thp_migration_supported(void)=

>>  }
>>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>
>> -static inline int split_folio_to_list(struct folio *folio,
>> -		struct list_head *list)
>> +static inline int split_folio_to_list_to_order(struct folio *folio,
>> +		struct list_head *list, int new_order)
>>  {
>> -	return split_huge_page_to_list(&folio->page, list);
>> +	return split_huge_page_to_list_to_order(&folio->page, list, new_orde=
r);
>>  }
>>
>> -static inline int split_folio(struct folio *folio)
>> +static inline int split_folio_to_order(struct folio *folio, int new_o=
rder)
>>  {
>> -	return split_folio_to_list(folio, NULL);
>> +	return split_folio_to_list_to_order(folio, NULL, new_order);
>>  }
>>
>> +#define split_folio_to_list(f, l) split_folio_to_list_to_order(f, l, =
0)
>> +#define split_folio(f) split_folio_to_order(f, 0)
>> +
>>  /*
>>   * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP du=
e to
>>   * limitations in the implementation like arm64 MTE can override this=
 to
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index b2df788c11fa..8b47a96a28f9 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2770,7 +2770,6 @@ static void lru_add_page_tail(struct page *head,=
 struct page *tail,
>>  		struct lruvec *lruvec, struct list_head *list)
>>  {
>>  	VM_BUG_ON_PAGE(!PageHead(head), head);
>> -	VM_BUG_ON_PAGE(PageCompound(tail), head);
>>  	VM_BUG_ON_PAGE(PageLRU(tail), head);
>>  	lockdep_assert_held(&lruvec->lru_lock);
>>
>> @@ -2791,7 +2790,8 @@ static void lru_add_page_tail(struct page *head,=
 struct page *tail,
>>  }
>>
>>  static void __split_huge_page_tail(struct folio *folio, int tail,
>> -		struct lruvec *lruvec, struct list_head *list)
>> +		struct lruvec *lruvec, struct list_head *list,
>> +		unsigned int new_order)
>>  {
>>  	struct page *head =3D &folio->page;
>>  	struct page *page_tail =3D head + tail;
>> @@ -2861,10 +2861,15 @@ static void __split_huge_page_tail(struct foli=
o *folio, int tail,
>>  	 * which needs correct compound_head().
>>  	 */
>>  	clear_compound_head(page_tail);
>> +	if (new_order) {
>> +		prep_compound_page(page_tail, new_order);
>> +		folio_prep_large_rmappable(new_folio);
>> +	}
>>
>>  	/* Finally unfreeze refcount. Additional reference from page cache. =
*/
>> -	page_ref_unfreeze(page_tail, 1 + (!folio_test_anon(folio) ||
>> -					  folio_test_swapcache(folio)));
>> +	page_ref_unfreeze(page_tail,
>> +		1 + ((!folio_test_anon(folio) || folio_test_swapcache(folio)) ?
>> +			     folio_nr_pages(new_folio) : 0));
>>
>>  	if (folio_test_young(folio))
>>  		folio_set_young(new_folio);
>> @@ -2882,7 +2887,7 @@ static void __split_huge_page_tail(struct folio =
*folio, int tail,
>>  }
>>
>>  static void __split_huge_page(struct page *page, struct list_head *li=
st,
>> -		pgoff_t end)
>> +		pgoff_t end, unsigned int new_order)
>>  {
>>  	struct folio *folio =3D page_folio(page);
>>  	struct page *head =3D &folio->page;
>> @@ -2890,11 +2895,12 @@ static void __split_huge_page(struct page *pag=
e, struct list_head *list,
>>  	struct address_space *swap_cache =3D NULL;
>>  	unsigned long offset =3D 0;
>>  	int i, nr_dropped =3D 0;
>> +	unsigned int new_nr =3D 1 << new_order;
>>  	int order =3D folio_order(folio);
>>  	unsigned int nr =3D 1 << order;
>>
>>  	/* complete memcg works before add pages to LRU */
>> -	split_page_memcg(head, order, 0);
>> +	split_page_memcg(head, order, new_order);
>>
>>  	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
>>  		offset =3D swp_offset(folio->swap);
>> @@ -2907,8 +2913,8 @@ static void __split_huge_page(struct page *page,=
 struct list_head *list,
>>
>>  	ClearPageHasHWPoisoned(head);
>>
>> -	for (i =3D nr - 1; i >=3D 1; i--) {
>> -		__split_huge_page_tail(folio, i, lruvec, list);
>> +	for (i =3D nr - new_nr; i >=3D new_nr; i -=3D new_nr) {
>> +		__split_huge_page_tail(folio, i, lruvec, list, new_order);
>>  		/* Some pages can be beyond EOF: drop them from page cache */
>>  		if (head[i].index >=3D end) {
>>  			struct folio *tail =3D page_folio(head + i);
>> @@ -2929,24 +2935,30 @@ static void __split_huge_page(struct page *pag=
e, struct list_head *list,
>>  		}
>>  	}
>>
>> -	ClearPageCompound(head);
>> +	if (!new_order)
>> +		ClearPageCompound(head);
>> +	else {
>> +		struct folio *new_folio =3D (struct folio *)head;
>> +
>> +		folio_set_order(new_folio, new_order);
>> +	}
>>  	unlock_page_lruvec(lruvec);
>>  	/* Caller disabled irqs, so they are still disabled here */
>>
>> -	split_page_owner(head, order, 0);
>> +	split_page_owner(head, order, new_order);
>>
>>  	/* See comment in __split_huge_page_tail() */
>>  	if (PageAnon(head)) {
>>  		/* Additional pin to swap cache */
>>  		if (PageSwapCache(head)) {
>> -			page_ref_add(head, 2);
>> +			page_ref_add(head, 1 + new_nr);
>>  			xa_unlock(&swap_cache->i_pages);
>>  		} else {
>>  			page_ref_inc(head);
>>  		}
>>  	} else {
>>  		/* Additional pin to page cache */
>> -		page_ref_add(head, 2);
>> +		page_ref_add(head, 1 + new_nr);
>>  		xa_unlock(&head->mapping->i_pages);
>>  	}
>>  	local_irq_enable();
>> @@ -2958,7 +2970,15 @@ static void __split_huge_page(struct page *page=
, struct list_head *list,
>>  	if (folio_test_swapcache(folio))
>>  		split_swap_cluster(folio->swap);
>>
>> -	for (i =3D 0; i < nr; i++) {
>> +	/*
>> +	 * set page to its compound_head when split to non order-0 pages, so=

>> +	 * we can skip unlocking it below, since PG_locked is transferred to=

>> +	 * the compound_head of the page and the caller will unlock it.
>> +	 */
>> +	if (new_order)
>> +		page =3D compound_head(page);
>> +
>> +	for (i =3D 0; i < nr; i +=3D new_nr) {
>>  		struct page *subpage =3D head + i;
>>  		if (subpage =3D=3D page)
>>  			continue;
>> @@ -2992,29 +3012,36 @@ bool can_split_folio(struct folio *folio, int =
*pextra_pins)
>>  }
>>
>>  /*
>> - * This function splits huge page into normal pages. @page can point =
to any
>> - * subpage of huge page to split. Split doesn't change the position o=
f @page.
>> + * This function splits huge page into pages in @new_order. @page can=
 point to
>> + * any subpage of huge page to split. Split doesn't change the positi=
on of
>> + * @page.
>> + *
>> + * NOTE: order-1 anonymous folio is not supported because _deferred_l=
ist,
>> + * which is used by partially mapped folios, is stored in subpage 2 a=
nd an
>> + * order-1 folio only has subpage 0 and 1. File-backed order-1 folios=
 are OK,
>> + * since they do not use _deferred_list.
>>   *
>>   * Only caller must hold pin on the @page, otherwise split fails with=
 -EBUSY.
>>   * The huge page must be locked.
>>   *
>>   * If @list is null, tail pages will be added to LRU list, otherwise,=
 to @list.
>>   *
>> - * Both head page and tail pages will inherit mapping, flags, and so =
on from
>> - * the hugepage.
>> + * Pages in new_order will inherit mapping, flags, and so on from the=
 hugepage.
>>   *
>> - * GUP pin and PG_locked transferred to @page. Rest subpages can be f=
reed if
>> - * they are not mapped.
>> + * GUP pin and PG_locked transferred to @page or the compound page @p=
age belongs
>> + * to. Rest subpages can be freed if they are not mapped.
>>   *
>>   * Returns 0 if the hugepage is split successfully.
>>   * Returns -EBUSY if the page is pinned or if anon_vma disappeared fr=
om under
>>   * us.
>>   */
>> -int split_huge_page_to_list(struct page *page, struct list_head *list=
)
>> +int split_huge_page_to_list_to_order(struct page *page, struct list_h=
ead *list,
>> +				     unsigned int new_order)
>>  {
>>  	struct folio *folio =3D page_folio(page);
>>  	struct deferred_split *ds_queue =3D get_deferred_split_queue(folio);=

>> -	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
>> +	/* reset xarray order to new order after split */
>> +	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_orde=
r);
>>  	struct anon_vma *anon_vma =3D NULL;
>>  	struct address_space *mapping =3D NULL;
>>  	int extra_pins, ret;
>> @@ -3024,6 +3051,34 @@ int split_huge_page_to_list(struct page *page, =
struct list_head *list)
>>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>>  	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>
>> +	/* Cannot split anonymous THP to order-1 */
>> +	if (new_order =3D=3D 1 && folio_test_anon(folio)) {
>> +		VM_WARN_ONCE(1, "Cannot split to order-1 folio");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (new_order) {
>> +		/* Only swapping a whole PMD-mapped folio is supported */
>> +		if (folio_test_swapcache(folio)) {
>> +			VM_WARN_ONCE(1,
>> +				"Cannot split swap-cached folio to non-0 order");
>
> My understanding may be wrong here, but can't the folio be moved to swa=
pcache
> asynchronously? How does the caller guarrantee that the folio is not in=

> swapcache and will not be moved between the call to
> split_huge_page_to_list_to_order() and this test? If the caller can't p=
revent
> it, then isn't it wrong to raise a warning here? Perhaps you just have =
to fail
> to split?

Right. That is why I only use VM_WARN_ONCE here. You mean it is better to=

get rid of the warning. I have no strong preference about it.

>
> I'm guessing this restriction is because swap only supports order-0 and=

> pmd-order folios currently? (And you only have split_swap_cluster() to =
downgrade
> from pmd-order to order-0). Perhaps you need my series that allows swap=
ping out
> any order THP? Current version at [1] but I'm working on a new version.=

>
> [1] https://lore.kernel.org/linux-mm/20231025144546.577640-1-ryan.rober=
ts@arm.com/

Right. Once your patchset is in, the above check can be removed.

>> +			return -EINVAL;
>> +		}
>> +		/* Split shmem folio to non-zero order not supported */
>> +		if (shmem_mapping(folio->mapping)) {
>> +			VM_WARN_ONCE(1,
>> +				"Cannot split shmem folio to non-0 order");
>> +			return -EINVAL;
>> +		}
>> +		/* No split if the file system does not support large folio */
>> +		if (!mapping_large_folio_support(folio->mapping)) {
>> +			VM_WARN_ONCE(1,
>> +				"Cannot split file folio to non-0 order");
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +
>>  	is_hzp =3D is_huge_zero_page(&folio->page);
>>  	if (is_hzp) {
>>  		pr_warn_ratelimited("Called split_huge_page for huge zero page\n");=

>> @@ -3120,14 +3175,21 @@ int split_huge_page_to_list(struct page *page,=
 struct list_head *list)
>>  		if (folio_order(folio) > 1 &&
>>  		    !list_empty(&folio->_deferred_list)) {
>>  			ds_queue->split_queue_len--;
>> -			list_del(&folio->_deferred_list);
>> +			/*
>> +			 * Reinitialize page_deferred_list after removing the
>> +			 * page from the split_queue, otherwise a subsequent
>> +			 * split will see list corruption when checking the
>> +			 * page_deferred_list.
>> +			 */
>> +			list_del_init(&folio->_deferred_list);
>>  		}
>>  		spin_unlock(&ds_queue->split_queue_lock);
>>  		if (mapping) {
>>  			int nr =3D folio_nr_pages(folio);
>>
>>  			xas_split(&xas, folio, folio_order(folio));
>> -			if (folio_test_pmd_mappable(folio)) {
>> +			if (folio_test_pmd_mappable(folio) &&
>> +			    new_order < HPAGE_PMD_ORDER) {
>>  				if (folio_test_swapbacked(folio)) {
>>  					__lruvec_stat_mod_folio(folio,
>>  							NR_SHMEM_THPS, -nr);
>> @@ -3139,7 +3201,7 @@ int split_huge_page_to_list(struct page *page, s=
truct list_head *list)
>>  			}
>>  		}
>>
>> -		__split_huge_page(page, list, end);
>> +		__split_huge_page(page, list, end, new_order);
>>  		ret =3D 0;
>>  	} else {
>>  		spin_unlock(&ds_queue->split_queue_lock);


--
Best Regards,
Yan, Zi

--=_MailMate_D23242B2-0CBB-4BA5-A6BF-DC01014EE824_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXfVG4PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUquIP/juSfOh9zAsyjGF7tiYA86qfdlGKTiLw3nEi
i/B06HodjEG5U/FW+xcp1aM65JNLuzhTn9owGlbSucj+dTip4DIBVKod5kchyOSe
C01H/ebxZOx/w2FN6tznBwN0GJANiCTtBIZ+j3mZv5sSYOkNRLr+WiMVQKQ8qdPf
M3gIDeThUg76U3uQdb5SEUB5SiawFpheU8G5R34ST4FKNNB0a74Fpb2fzWpmltV0
J4jjFbT0yySTR7+IzkHHk+kSeYNUbVw7GxLPj0bnrhz4PHtHXyWNwm75b4rGq2fF
kJl9EeoGQVr6bgN36/pfmd15/4tv1YwA7H/srDl/Dmt6Kg11ikqHJOgcpjvwZcqI
FHCbQZ33QmLh5XW4eQ7EEnwEgwusFfKdAg3dYZ+SLwem3HnSNYMzuMt5yr+Rdo8V
Ah19IyaCa1SrsjzShMQ2A1Ua4BCL/W2Up3htny8P8So/D47W3VCPJUIn2iEiHJtT
H9xqlq20CbnpwghXmDDvLwnVliCnvzyEbiwoDJYYLPX9Z544mgeH7vv4QW5racHr
d5Npo2L6Kc1aHlxK9LVU9TYeImN+WkOR7BS8WpS8CiqAvmSGgvgoWb7ax3kPxyvw
fqccf1FzUZrw4oys5ycB896fR07jD8p9pClJYaA9ENx6GhM3GgOBq0WZa85IlvkR
P70cOAXe
=SA6G
-----END PGP SIGNATURE-----

--=_MailMate_D23242B2-0CBB-4BA5-A6BF-DC01014EE824_=--

