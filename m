Return-Path: <linux-fsdevel+bounces-11569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDEA854CCC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 16:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E875C1F298D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 15:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5915D90F;
	Wed, 14 Feb 2024 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JgHbNLk9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0415D8E7;
	Wed, 14 Feb 2024 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924587; cv=fail; b=k3RnVzHQ0SZE66ISKriVcy/I+GimKY3ZD8lp7WcrptHM5+4sPU4iACejkOXhdfZvegwyUrLG5FH1CshG0xj/vgLngWP4fwf8fK5dndKZAJsTV/xUGuhHr2N34WPooFoaDpdgpdAcnMyNRwh1QJ4Uov+0ACydeHShsfdmWZhA9IM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924587; c=relaxed/simple;
	bh=m8qlauRFbSaq+MlEtbGN/c/XVmkFPd8kdjZqBcHgNog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XaajLNdWXbDN0JUCCrrvCUxgKVyVoImt8x1keCj6MJMhlJRUN9nr4cEEp/le5o46DdpRUCsg9lAdDKjsITVPkO93DA5F7OCMmeDrwcoh87IzwtI94YhDuARYzFoQDaIdAk700avoa9BI3M4DoXTHvV8lgLqq9nhM7ImctGMQuUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JgHbNLk9; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6Rw9QoMxdKkPC1PG+H4prlpZgCSDO6zM4v6jYhw6UT+Uo/BdQ0lWkrOs8RYqsAJK6gRuGMqVuL4uaT/YGeH/gSHW3iJ0skUxCJbOQVo0frFhVVgEyFyRCXc2Sq5JadBMIRxNSeaSOltBeC8GfqJQBKHTRFTqnnZ7KXxs3WTtzF9AVRe86ZvDYTiSFaeI7knGhqhzwNm9G1SAKZ8rnW+5zomUHRULJCf2ln9b1rSM+V2G3IOd3D5lwglUYRquz7QwmIMVDVA3/WefcpC7CXSsdkvLshp9bMFFm1qAAlvJg2d3nGtXJ6GNtbcXoRqR839l2cTUTA06fSEXFip3qKE6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vklhXRB16w0gU3JY0qZrZf/x5wtuT8J94bpPXo417W8=;
 b=b530j/TtlM9FPbEUWprgnkbSYKt5ugxyGbVTjy3VWBaVDRP6iM1aBIIfK9DNTG9QCW5sKe9pKW+3SHQ6KGkI/hJqR7XGw61/T1DcQXr/MjBKKAjQuuxtHwE2YFCOLjgK4ty0hfifZQCjlN64qjPrb6UcZ9whnbjGUsaHJ7/BXZkFEnf/Mt5UXAhD8u0li2+g6+XAMd2/OlqjvvpHLNuBRxKGET7sUL6JLfkVmFKYu7WqS4mOmRdbGB5zcC3N7RJA/HilG3/GUYbaR9SWdw1/yMVWrrTbjD5h+qOZ4vYe11M6e5vypYa4ySbozghOsSWhq1vZtOQB6U200O1kamz/3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vklhXRB16w0gU3JY0qZrZf/x5wtuT8J94bpPXo417W8=;
 b=JgHbNLk9PU+l8l4w0A12m6O+2t4uaGXy8IFJF9G/gL3m+8HG3gECPaB0moab3fwg76x0uvsI9Y4P0GoKcTMiF10C2VPenKOekJ617mjpeFUrlQJr4NLheAz1+2VsENytH7CS8qIX7UgR6UX0tJqWxi9tLNYusJ/Nkg9J0tHH4nyOdXg7lkY3fx+C+zz2yiJdWrj49WRaRkAPH0kI3wc0SuHHBaayhSz7x8WMWhWH/VQDlFGzjTPVBf0oZxdqEhk+z5QhxvEENgfnEbz+qgdqprh6SfiKLh8iOhq60BBOy5hbCnhTtpOHRMrsGxo4VB+jOnT+9dG7xs4QPP6ryMxbfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 LV8PR12MB9358.namprd12.prod.outlook.com (2603:10b6:408:201::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 15:29:42 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7316.012; Wed, 14 Feb 2024
 15:29:42 +0000
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
Subject: Re: [PATCH v4 4/7] mm: page_owner: add support for splitting to any
 order in split page_owner.
Date: Wed, 14 Feb 2024 10:29:40 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <904ACE76-6589-449F-B709-010C875DB557@nvidia.com>
In-Reply-To: <48219ffc-62dc-430a-8055-6fb9ab533e7f@redhat.com>
References: <20240213215520.1048625-1-zi.yan@sent.com>
 <20240213215520.1048625-5-zi.yan@sent.com>
 <48219ffc-62dc-430a-8055-6fb9ab533e7f@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_216B4096-9791-4FD1-8174-1CFBBCDB4087_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAP220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::12) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|LV8PR12MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: 09cd3fde-a999-4e27-fd27-08dc2d71c3fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UsNgoWSLRnB/bqiojj1Pu5q9IvDOQiD8y3Kma1ZLF5DZNt03LBmnwErxiJA+dVnlRNYTzXkgw9+Gzs9sGOgabx82swwo6VMRvSIeezyZRrwh8hxQzXii9NAKiyPme83SiMUrgb5umB2SQlh+BPqsKbhC8mfLYkkalNdBfVzOTmMRkA+SzfAaJ1hkH0rwNFbAphIoTqDF1b7//JLAaOPn4xOw/5OYmY5tWn+Xr4PWoiPX14MEu+mfQIUfMkjG4DGf8d11jhz6MNsfiEDGYjAP5D9Gxa5Bj91P4MdT/eocyB+l6OazqUNUIPjU9bGLbTOHsNjyqO5AiOoZYWKw2kv0kOQun5kx7XZacmA3Cl1hgtueOaUk9SkUq3hrCGmhuLv4ItYeKt7CPYM8UZN0MMLvmPAAnpBmEcGjrEkF9R6Sr8KBHRcvok607iuACvCiVvSlkODWb0E1+//YGRIP/NWb6WtuBvNrySd8ANmUQ1Ula+4AxTfp5SZ4rs2iYDUHAaowemcqoMB1lLu8lPlt8u5jA4AvrdatPvuTb0F436oMhq6UUfrwcHUn0fIQSHb8IC4u
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(39860400002)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6486002)(478600001)(86362001)(41300700001)(6506007)(2906002)(5660300002)(7416002)(235185007)(316002)(33656002)(66946007)(6916009)(66476007)(83380400001)(54906003)(53546011)(8936002)(8676002)(66556008)(4326008)(38100700002)(6512007)(26005)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5/zhP+Tm5Jr2VBnIXqggv7wtxCZb32TuAs9seG+cOiippoTo/Hini5R5CVaP?=
 =?us-ascii?Q?/ASmdj8OSbIKWKVO54zOQQtbdL68aK45mVOoFfPR1ZbXFPqS/UDyKBeGhJF7?=
 =?us-ascii?Q?Ri8iVke9mDchiJnddB1kjW1BtBPIfiuWFQ04dtJnAke3rny6lhnsQP8G9GqO?=
 =?us-ascii?Q?48QbD+tvMfYuq4U9lk5O+aCmgp4j/sBeIdlZr4m9D6xQWxG+N/MNibje9umI?=
 =?us-ascii?Q?GNhAbfMoStRjRQDkcu56txmFKM2vzh+nvcwLLS+TxxasQBGR5rdjn/YrFxiz?=
 =?us-ascii?Q?9B4pLZ8rTTzDLSj0Z4KS6Pc53ZFImjILc2NIdHTnpxR3J6fNJ+N8gga9rGlO?=
 =?us-ascii?Q?I8q+WjavknrNCRTpW3/+Wbi89zmlk7rfJ8grrhjTqjCYXBV3uPuiBLEWIEm4?=
 =?us-ascii?Q?f8RK+NHUwaU7zQH/f18UlPCciUX/n7Ml4etRr2pIJANmpxhc8A+8x1mVL0Jk?=
 =?us-ascii?Q?15GZVS4C7wC76M7474KX5vc0xToltS1DiU4jY63aLn+hwC69CJhJ4Mmui4JY?=
 =?us-ascii?Q?qd6nVPJWX+TDP8bwuXmYNfq0QGHmRTszEBZzUPDjncVChHT4VImccNv0D4YK?=
 =?us-ascii?Q?+zObFAuXPOb3oU+wQOmBxLFit6ralc/pLdcBHPhai27JWmhVl516rRZUDVtd?=
 =?us-ascii?Q?gC3XiYPIpQc7bhC9npPl8+Dy5b2xjUx36Eb22Ma07OAqhDW/yrC55qrzn2+a?=
 =?us-ascii?Q?z8VbEtcJwb+6RFuvYnD3qK+rYoJXBWtQX9uLnvQWd0ceodo2ByGE0iN/i6eH?=
 =?us-ascii?Q?AMGPIUoak5hlZVPiECnJpEa4T+tPJKcF6v//IMe97bPf7S9iRmUgQgANlba8?=
 =?us-ascii?Q?ipE/pC21/wl2oEv8p4AIhC7wlhTiTCrwbO4wEeHgKnWyEs00nNn3Ad2vBUyb?=
 =?us-ascii?Q?ZU1FEN2/Quput3cgk4Rnubh9FR4D0L/JpOtZBM/zel1fN8CDv1W36c6uguxP?=
 =?us-ascii?Q?ZO2nnB2qJcr7b63GFYydkrp5cQ7R08Kqa62KCi1YRaGX7HMaIZqUQ+k0McvN?=
 =?us-ascii?Q?W2PhOZAbS83MENdR87QrKYvMke96J0KRPPn1hSiZxqmxq+4bmd2DYiGj/cPt?=
 =?us-ascii?Q?ezOePsQzIyM9+OBqNW1mJCf7Ow+HT1PlipMoar1HKwfXZAVZSvgBYZ5rpf0j?=
 =?us-ascii?Q?WA1vjoQlCqgo11hn3GRxTTmssEL7pesvVjjPGfYby8uVvyVgsGHj8nht9yxU?=
 =?us-ascii?Q?iJaiWfZebuvbRegp3qbnTdDctPSqyYOsSVLjOci9xKqcR+eUbLyqTZsnz0BA?=
 =?us-ascii?Q?geHK0hnqyAk0yDjxDOdtRlUSX2hzW4QhspVrkR2UNobF13+dT+SRE4pAU0GX?=
 =?us-ascii?Q?ntR2UbOSDJ9C/raIJ8SIM7B2KBe1KbgV/wrRoIKh3rQqSiVOL7q4VpEC6R0v?=
 =?us-ascii?Q?YRXjm9vKO9o9bcqTiZopPj3eIELcTIkTWN6leqqXxd6eQMBYdugYdLujxKtK?=
 =?us-ascii?Q?SbsDmWi23TVM22XQZVHWiLJoBBEeqkfeMB3Aqyd0AGhFMxeeGh3qkfjKVbqZ?=
 =?us-ascii?Q?y5MWpRM+XrAczoBJAdH8kWghzcuHzRPSHpVkgjvBYF6ytQRZ543eYQC8tYsq?=
 =?us-ascii?Q?+0wta3E2UZo4saKedtWnopA42Ql27MdnXla2EbPE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cd3fde-a999-4e27-fd27-08dc2d71c3fc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 15:29:42.3778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGT++p3skAjuvEmgaMXhjPSbRy/XXMPKYbuNQ0enOPDlP9jrNmu55q/0dHB6BX8T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9358

--=_MailMate_216B4096-9791-4FD1-8174-1CFBBCDB4087_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 14 Feb 2024, at 4:34, David Hildenbrand wrote:

> On 13.02.24 22:55, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> It adds a new_order parameter to set new page order in page owner.
>> It prepares for upcoming changes to support split huge page to any
>> lower order.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   include/linux/page_owner.h | 10 +++++-----
>>   mm/huge_memory.c           |  2 +-
>>   mm/page_alloc.c            |  4 ++--
>>   mm/page_owner.c            |  9 +++++----
>>   4 files changed, 13 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
>> index d7878523adfc..a784ba69f67f 100644
>> --- a/include/linux/page_owner.h
>> +++ b/include/linux/page_owner.h
>> @@ -11,7 +11,7 @@ extern struct page_ext_operations page_owner_ops;
>>   extern void __reset_page_owner(struct page *page, unsigned short ord=
er);
>>   extern void __set_page_owner(struct page *page,
>>   			unsigned short order, gfp_t gfp_mask);
>> -extern void __split_page_owner(struct page *page, int order);
>> +extern void __split_page_owner(struct page *page, int old_order, int =
new_order);
>>   extern void __folio_copy_owner(struct folio *newfolio, struct folio =
*old);
>>   extern void __set_page_owner_migrate_reason(struct page *page, int r=
eason);
>>   extern void __dump_page_owner(const struct page *page);
>> @@ -31,10 +31,10 @@ static inline void set_page_owner(struct page *pag=
e,
>>   		__set_page_owner(page, order, gfp_mask);
>>   }
>>  -static inline void split_page_owner(struct page *page, int order)
>> +static inline void split_page_owner(struct page *page, int old_order,=
 int new_order)
>>   {
>>   	if (static_branch_unlikely(&page_owner_inited))
>> -		__split_page_owner(page, order);
>> +		__split_page_owner(page, old_order, new_order);
>>   }
>>   static inline void folio_copy_owner(struct folio *newfolio, struct f=
olio *old)
>>   {
>> @@ -56,11 +56,11 @@ static inline void reset_page_owner(struct page *p=
age, unsigned short order)
>>   {
>>   }
>>   static inline void set_page_owner(struct page *page,
>> -			unsigned int order, gfp_t gfp_mask)
>> +			unsigned short order, gfp_t gfp_mask)
>>   {
>>   }
>>   static inline void split_page_owner(struct page *page,
>> -			int order)
>> +			int old_order, int new_order)
>>   {
>>   }
>>   static inline void folio_copy_owner(struct folio *newfolio, struct f=
olio *folio)
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 3d30eccd3a7f..ad7133c97428 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2919,7 +2919,7 @@ static void __split_huge_page(struct page *page,=
 struct list_head *list,
>>   	unlock_page_lruvec(lruvec);
>>   	/* Caller disabled irqs, so they are still disabled here */
>>  -	split_page_owner(head, order);
>> +	split_page_owner(head, order, 0);
>>    	/* See comment in __split_huge_page_tail() */
>>   	if (PageAnon(head)) {
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 9d4dd41d0647..e0f107b21c98 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -2652,7 +2652,7 @@ void split_page(struct page *page, unsigned int =
order)
>>    	for (i =3D 1; i < (1 << order); i++)
>>   		set_page_refcounted(page + i);
>> -	split_page_owner(page, order);
>> +	split_page_owner(page, order, 0);
>>   	split_page_memcg(page, order, 0);
>>   }
>>   EXPORT_SYMBOL_GPL(split_page);
>> @@ -4837,7 +4837,7 @@ static void *make_alloc_exact(unsigned long addr=
, unsigned int order,
>>   		struct page *page =3D virt_to_page((void *)addr);
>>   		struct page *last =3D page + nr;
>>  -		split_page_owner(page, order);
>> +		split_page_owner(page, order, 0);
>>   		split_page_memcg(page, order, 0);
>>   		while (page < --last)
>>   			set_page_refcounted(last);
>> diff --git a/mm/page_owner.c b/mm/page_owner.c
>> index 1319e402c2cf..ebbffa0501db 100644
>> --- a/mm/page_owner.c
>> +++ b/mm/page_owner.c
>> @@ -292,19 +292,20 @@ void __set_page_owner_migrate_reason(struct page=
 *page, int reason)
>>   	page_ext_put(page_ext);
>>   }
>>  -void __split_page_owner(struct page *page, int order)
>> +void __split_page_owner(struct page *page, int old_order, int new_ord=
er)
>>   {
>>   	int i;
>>   	struct page_ext *page_ext =3D page_ext_get(page);
>>   	struct page_owner *page_owner;
>> -	unsigned int nr =3D 1 << order;
>> +	unsigned int old_nr =3D 1 << old_order;
>> +	unsigned int new_nr =3D 1 << new_order;
>>    	if (unlikely(!page_ext))
>>   		return;
>>  -	for (i =3D 0; i < nr; i++) {
>> +	for (i =3D 0; i < old_nr; i +=3D new_nr) {
>>   		page_owner =3D get_page_owner(page_ext);
>> -		page_owner->order =3D 0;
>> +		page_owner->order =3D new_order;
>>   		page_ext =3D page_ext_next(page_ext);
>
> Staring at __set_page_owner_handle(), we do set all 1<<order page_exts =
(corresponding to 1<<order "struct page"s) to have ->order set.
>
> Wouldn't you have to do the same here?
>
> for (i =3D 0; i < 1 << old_order; i++) {
> 	page_owner =3D get_page_owner(page_ext);
> 	page_owner->order =3D new_order;
> 	page_ext =3D page_ext_next(page_ext);
> }

You are right. So page owner is per struct page. I misunderstood the code=
=2E
Thank you for pointing this out. Will fix it.


--
Best Regards,
Yan, Zi

--=_MailMate_216B4096-9791-4FD1-8174-1CFBBCDB4087_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXM3GQPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU7iMQAI6d0iP6FCH6nzfhnUu/yGAXTBeXY0tZQBdz
HCY+1k1+E6OrOZV7/VHI45NvYs8QD69tWTKR5lBHiI+jKGjk1rWz4qQcYlOkkqiV
wQmu1lVA0dqoBwYvft8XkGq1AegmCiSOZFuhbXUzrRWBnxYieuyWgVMhJmZOb9H2
erXzT4rVmUen3qNRJZ+9sAQLXaLe/2UzUIX3MxnzvgGHmYQdOZtcLhhwZbFRgQ1V
ktqTSvqUAf6tyKpdZn/XisxEBsK0Xe49EB2A1D0+NXoymszODPgujEC9yFVQEYuG
gTnC6n2l3eHoTgwKwyWc7OoEMARevR6tYAibdWm0cskvB14mxj/Xq457M84pd12Y
VdRVW1e/qkVDUE35/3ZULDISWq47xC0Gc2C6g/F47TPqdMca/jkWnd+RqeLeeBMQ
vsF/qb7RVT5CKxHJtgT3Eotq65WlJzqFBOg11D9FRetExP1ziRj1rdBQ2TPafwjv
TBl06k0Fh0NdCWRr6Vv0BJBM2t3sVVaesyUoXFOFbxc45Jj2zHZyB65KqcGCmyrH
WQ3dDjMbXLS47F1kiAENENgeYkdaY7FnY5nxZO55f4MnHAHnavIQyolhe1uKUA8q
yotZLEXpiJNro+36tPidTfapNB9+n+iAY7pTsPF8PH5jwQ2ciY5tfCN3g1s0YRnb
/dUiwCB1
=X4XD
-----END PGP SIGNATURE-----

--=_MailMate_216B4096-9791-4FD1-8174-1CFBBCDB4087_=--

