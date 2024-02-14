Return-Path: <linux-fsdevel+bounces-11572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5060A854DCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 17:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3D81C2876B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 16:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBCA5FF03;
	Wed, 14 Feb 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s0/oh+F6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E85B6026F;
	Wed, 14 Feb 2024 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927074; cv=fail; b=O5QoT2wHMzrFS/VjbS/jfI/Q3zPZb1AOJpmL0T1JO/cAsvaabzkK7mIXTCXMAn4QTPeux737w9qiG0r2NBfJRpLHF7QZrxnAM9Jw7wJPgYdt//qKqL9B7gufn3CY2BLPpXV6CeYAPVmCU+VQKGfkQyac5OI7usQPh+jWXZ3tUJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927074; c=relaxed/simple;
	bh=nsR7WXaMIwg4qj67QfmVa+kd+k8X1eQqX399ziW+CHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jreHneu0Y/RU7OY3clyk3dTHueHuZHnaHd+kxJNhd0ewe1p46wI0Kzax9WsvSN+qWY1kfxlJkka/sovfKMDpjY0e5vMHLjZZBRMRbo7+uF1iEvrhj8HCbkOVx+RdpcjKUrmg9vzgTgGFhgXNX7Nj/BIFn6z7cfPD6i6dfbCGuZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s0/oh+F6; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1vKb5mleX+Jj2RZnkqZNo7cg2eZhrC10EAQE7r6Qg+O4tbh7HUPSq8EYl3NLTjrlbubF2SL66sISa8Ds/sM7uCBJIUyE2aL+JYeZNbJa9Vh3/nRWAiZo4t1jjs3Jj5vn9BudZwhgd26aDaPd2Ob2UMg4z9vy+GDlNxKE1CxI2rsvj5rimHCQZpLGeSSySlXXCwPPPI4GYIFX3nEXy6xWiANlYzy4aost+mMVb4XWyaFP8NEoGj/G8vU0PXaYf0/NBw5zsEPYwy5nMkmp6xzKo4H31mVpBnhgd8AghcgPXvhw2X+TTxPqbo79LFK48hLy8o7yh/i64RiKVkystsdoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbQKHsXxfcqH5IVve8ihFvpRIHaGHAcf/KG3HKd93Jk=;
 b=Ls7myN6amUlWYQg1Z4w/bvki1QZhNXPHZoJ3va4ns+rW/pKUPmbn8pVj1YDDW5u2AXupE0bnWpq4l9/sWyVBO/nj79Qj22YjW4gT87NFBZOAilcHRP9gAmBeCPNCMWbbUPNPhdM8SD8G+DqYxbsou1pKPeDBOl5qw+NAY5DT39z3RA/p9lymCHRwqujePTKfwCdXclk3dSTL/XfUgLV23Pctz7aJ6WF+uPWB3loulYaSbioCgTxMH80bnZ8RxfCHZoQ6jQk92iACTI3WVMdj9aBKBeXMclhYgXNpFhZLyHSru1e4IgCtt5GnXIP1xB5XEtdQdCiNkOAEg7ZcygJGuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbQKHsXxfcqH5IVve8ihFvpRIHaGHAcf/KG3HKd93Jk=;
 b=s0/oh+F6x+V6vqxgGqCOc+7NIop8rDVBM7qSm24I+XuclmYr99DwklrjdjejccJqwOWH58tu6IltTMLV5YKHQEBcS9QG8//CKKXTjbYlUz/CRk81QGU+3HUmPzN5N+ZxzzOaLV0lvp6FtUdAOwsSmH4/ofKnrse2X5Neb6LXvrl8DefO4Ef1F+qb+dbHp0SYBXHUmKnM1qrOMi18YkfwG+SqghA7Rz3pnSDeNjkRqIvRQzu9ZR9qk7Ne+xUvoR6ELLy3vdz2LlLHNicaHV1hq6LqerHPsRaQCU/EwrmRcST0jfCOypn8KGW+5Hg42YA0TZ4G6S3wKYVDBSI4/iLLwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 16:11:07 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7316.012; Wed, 14 Feb 2024
 16:11:07 +0000
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
 Mcgrof Chamberlain <mcgrof@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 5/7] mm: thp: split huge page to any lower order pages
 (except order-1).
Date: Wed, 14 Feb 2024 11:11:05 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <6859C8DA-5B7F-458E-895C-763BA782F4B9@nvidia.com>
In-Reply-To: <de66b9fb-ee84-473f-a69a-2ac8554f6000@arm.com>
References: <20240213215520.1048625-1-zi.yan@sent.com>
 <20240213215520.1048625-6-zi.yan@sent.com>
 <de66b9fb-ee84-473f-a69a-2ac8554f6000@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_33363929-3563-4370-B6A5-2015B3B96DC5_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR01CA0042.prod.exchangelabs.com (2603:10b6:208:23f::11)
 To DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|BL1PR12MB5111:EE_
X-MS-Office365-Filtering-Correlation-Id: f17e2ea8-b39f-4d46-1af8-08dc2d778d3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VzIAxOjm0N1XmjYjrAbCzz8zGhwi77LkFAyZFWPMcTFW/SZnlxv2yYPy7nEzORVHwQbklu2ts8WvurlxS0xXzZAMlA3AqJ5U+HIOeKmoDvb3KVug2sgJaVTKXdpZ1sF5qdyPwqPtOTW8sNOXWNBJI8cvMLFrdCZ61h3KKiuni+r3wfnpx6vrLMBel95JgDqMjPM20adNS/FvoE6GXyNxRoWM7I8vHyzeFTW1vdkQU9PleWtUooh18jBdty+mFOqHfA74LYN8Z+dYrRZ4/aaHXyAFFPoIotk8U1j4+/0ikL7WIQXsUDLtFHv2TY3nK63ruXOBZZnZGZaUjHOAUpxVTkKbrmntvgWtXkiy0XmltmQWo06jDcdITpg0/TRnQVsipVFl8QQmGXMsn//kba4sIFqGcDmjGKdXV4kO/IGQC3zTWvKExwfx2WhEKK6nUx2DKUojdGRnSTQYNMUeefpO8wHTNS/ybMLDp3icSf+PUhe5O0drktmYgi195TZAGHxU3WLpIhGdOzEDUjWqQdy6gu7bJHFd7zNCIXLXfFnXC3+LNFF2VORanlUHdZISz3Lj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(136003)(376002)(230922051799003)(230273577357003)(1800799012)(451199024)(186009)(64100799003)(235185007)(5660300002)(7416002)(2616005)(6506007)(53546011)(36756003)(6512007)(478600001)(6486002)(38100700002)(83380400001)(26005)(33656002)(4326008)(8676002)(86362001)(8936002)(2906002)(54906003)(316002)(66556008)(6916009)(66946007)(66476007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/LR2FkgGtHnovoKBfhUgx4/XJsuD4Zenb141fPhuGji3F2W4jYNiUlYCRFwP?=
 =?us-ascii?Q?1c6cDq7EeaQvR7zJ3CGStjc76eN5Rdsx1f7VTNofPDJNZKLh5wr6iItgtaea?=
 =?us-ascii?Q?8PPvT8pKGNpTLCTDoVOevUDyHefR5/82ckskMjl03WEcOV+mHbQXqUxWWr5U?=
 =?us-ascii?Q?CIfttiXwnO73LGX9dhthuQa1HVURaJ6eV8wke6shA3B86Rn5Nf0Fp3uhjsf/?=
 =?us-ascii?Q?YRoONR5ebhFUAeWBhjLOo8uxnDGKmC760f+FrwSqtd1Nc/uilVl6DtCD0JtM?=
 =?us-ascii?Q?AzvJvjPhmFxftC7+WEQKhNvR+09IDIqOAxmLpAuxqoVjXgOKo+cTYNFmlw/3?=
 =?us-ascii?Q?XvDwV45PtMoP6F9SDJF6rPep6q6pREu0FMJf17rE+blU5YAPpTb27NTOkK7e?=
 =?us-ascii?Q?pqOf/xkhsV/SNl6y68ZzfhWOy+bb3PcSuKAVPEa25WhXkk5tmAS+mjsVRi+c?=
 =?us-ascii?Q?zjyoWwzffQPDcvoJi1e36lVCNpI2iT+kawm3DyEhMD9mb+nhBGyavru1O8pz?=
 =?us-ascii?Q?Y3Bt9HlhWJ32qodCvLe3gGtgB1BxFRAScJR9onm24wyB0Jd8afda662yqhCn?=
 =?us-ascii?Q?TtXG7ZDzIaU7f53QR6HOTxvY+AYVS8x1yStN9S20EWKvsaqjslhfUN365YJC?=
 =?us-ascii?Q?LmisFL86dCC6/zRISqQrR1sIFLJWKvNBCCn0gjOY5guOcbGO1LqBja/tuRjW?=
 =?us-ascii?Q?U3cvEftJDMvMyWtxdCO3Vi33OhEsP71RHjxM+oo4sry1Lbbb9UK9/Lw2t3xF?=
 =?us-ascii?Q?uT9ps4xcG0NFTZDNHUyVykixf5tPGaYn206nj/0TflyMwlKG5qYYrtEosBSo?=
 =?us-ascii?Q?/2v/FoOzyI3v6C5Jb8BSU48DvZOMWeRxqeWiqDdse6wRk4TCPDZ4hHUlmfUL?=
 =?us-ascii?Q?kylPfOiFZsBoNzx6TzyqZlfWC8wPIidJB8tiqro9tjcIH/03eh69Z1leQjTY?=
 =?us-ascii?Q?wmpacn7XeyL9CAqBDN6lhQN4IL9iVdT4KnavwCmFe8aAAMfqO3VYttpQZ9CQ?=
 =?us-ascii?Q?knc7bLfvautNbVvTYKaJ4I/JDi+RWCouafmDkA/+2BwMJL+VYxoCbtL1AsDT?=
 =?us-ascii?Q?R+ZphiuLQuCh0ZBSqRAbE9iYkiBuGHITf1infn5T3nCnpWC+JQFkw3pCsm0V?=
 =?us-ascii?Q?J+FodvrbrOFSe+dntC9oDqgMMgAFWlvONlE5029jTS9DW3Y5ynfxB6tMVwmY?=
 =?us-ascii?Q?dEqXJ6RJi5+hJFPweg7MbnF6kNg6QaBfhD3AF7DOZRvA7QeQh0+y9fUupzIP?=
 =?us-ascii?Q?c+M5pWTGCy9ZuiMVEEx1dhel71NIq5vBjTgoK51z0lR9FFhthJGDf/+6GtXT?=
 =?us-ascii?Q?bUw/9cPcex8J0rsQZn2Sx8OIhQ2jQTf5ZZqiAWSW+DfsrhvsWmzMyJ11vsUf?=
 =?us-ascii?Q?uOhwAWiRAt7aNwXvys4WsIa77e+jm/sg6ewRenXccBTj7h2g/lVI/z4MZrGZ?=
 =?us-ascii?Q?HNfZmMffo2pI4+yAZP24z60iuhsYS2dq78Td/rSZ7fBmWKlXusSzsyeBQLPi?=
 =?us-ascii?Q?hhYF9yAr5GUTROey++NR673fQJpfBwPsbFqLctkwcfPcJ3jJOvM/p5TcKt2Y?=
 =?us-ascii?Q?5zy87k2NmlRNlAjUe0nN2GdoB2uWmirRR1M9SF+n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17e2ea8-b39f-4d46-1af8-08dc2d778d3f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 16:11:07.5299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90zo/ub/xMjs5nlIW4pbQnwMlUJ7HjHFVQQH4oJeLaucy/aEBaNtP3N87BhyQyoi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111

--=_MailMate_33363929-3563-4370-B6A5-2015B3B96DC5_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 14 Feb 2024, at 5:38, Ryan Roberts wrote:

> On 13/02/2024 21:55, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> To split a THP to any lower order (except order-1) pages, we need to
>> reform THPs on subpages at given order and add page refcount based on =
the
>> new page order. Also we need to reinitialize page_deferred_list after
>> removing the page from the split_queue, otherwise a subsequent split w=
ill
>> see list corruption when checking the page_deferred_list again.
>>
>> It has many uses, like minimizing the number of pages after
>> truncating a huge pagecache page. For anonymous THPs, we can only spli=
t
>> them to order-0 like before until we add support for any size anonymou=
s
>> THPs.
>
> multi-size THP is now upstream. Not sure if this comment still makes se=
nse.
Will change it to reflect the fact that multi-size THP is already upstrea=
m.

> Still its not completely clear to me how you would integrate this new m=
achinery
> and decide what non-zero order to split anon THP to?

Originally, it was developed along with my 1GB THP support. So it was int=
ended
to split order-18 to order-9. But for now, like you and David said in the=
 cover
letter email thread, we might not want to use it for anonymous large foli=
os
until we find a necessary use case.

>>
>> Order-1 folio is not supported because _deferred_list, which is used b=
y
>> partially mapped folios, is stored in subpage 2 and an order-1 folio o=
nly
>> has subpage 0 and 1.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  include/linux/huge_mm.h |  21 +++++---
>>  mm/huge_memory.c        | 114 +++++++++++++++++++++++++++++++--------=
-
>>  2 files changed, 101 insertions(+), 34 deletions(-)
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
>> index ad7133c97428..d0e555a8ea98 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2718,11 +2718,14 @@ void vma_adjust_trans_huge(struct vm_area_stru=
ct *vma,
>>
>>  static void unmap_folio(struct folio *folio)
>>  {
>> -	enum ttu_flags ttu_flags =3D TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD |
>> -		TTU_SYNC | TTU_BATCH_FLUSH;
>> +	enum ttu_flags ttu_flags =3D TTU_RMAP_LOCKED | TTU_SYNC |
>> +		TTU_BATCH_FLUSH;
>>
>>  	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>
>> +	if (folio_test_pmd_mappable(folio))
>> +		ttu_flags |=3D TTU_SPLIT_HUGE_PMD;
>
> Should we split this change out? I think it makes sense independent of =
this series?
>

Sure. Since multi-size THP is upstream, this avoid unnecessary code path =
if
the THP is not PMD-mapped.

>> +
>>  	/*
>>  	 * Anon pages need migration entries to preserve them, but file
>>  	 * pages can simply be left unmapped, then faulted back on demand.
>> @@ -2756,7 +2759,6 @@ static void lru_add_page_tail(struct page *head,=
 struct page *tail,
>>  		struct lruvec *lruvec, struct list_head *list)
>>  {
>>  	VM_BUG_ON_PAGE(!PageHead(head), head);
>> -	VM_BUG_ON_PAGE(PageCompound(tail), head);
>>  	VM_BUG_ON_PAGE(PageLRU(tail), head);
>>  	lockdep_assert_held(&lruvec->lru_lock);
>>
>> @@ -2777,7 +2779,8 @@ static void lru_add_page_tail(struct page *head,=
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
>> @@ -2847,10 +2850,15 @@ static void __split_huge_page_tail(struct foli=
o *folio, int tail,
>>  	 * which needs correct compound_head().
>>  	 */
>>  	clear_compound_head(page_tail);
>> +	if (new_order) {
>> +		prep_compound_page(page_tail, new_order);
>> +		folio_prep_large_rmappable(page_folio(page_tail));
>> +	}
>>
>>  	/* Finally unfreeze refcount. Additional reference from page cache. =
*/
>> -	page_ref_unfreeze(page_tail, 1 + (!folio_test_anon(folio) ||
>> -					  folio_test_swapcache(folio)));
>> +	page_ref_unfreeze(page_tail,
>> +		1 + ((!folio_test_anon(folio) || folio_test_swapcache(folio)) ?
>> +			     folio_nr_pages(page_folio(page_tail)) : 0));
>>
>>  	if (folio_test_young(folio))
>>  		folio_set_young(new_folio);
>> @@ -2868,7 +2876,7 @@ static void __split_huge_page_tail(struct folio =
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
>> @@ -2877,10 +2885,11 @@ static void __split_huge_page(struct page *pag=
e, struct list_head *list,
>>  	unsigned long offset =3D 0;
>>  	unsigned int nr =3D thp_nr_pages(head);
>>  	int i, nr_dropped =3D 0;
>> +	unsigned int new_nr =3D 1 << new_order;
>>  	int order =3D folio_order(folio);
>>
>>  	/* complete memcg works before add pages to LRU */
>> -	split_page_memcg(head, order, 0);
>> +	split_page_memcg(head, order, new_order);
>>
>>  	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
>>  		offset =3D swp_offset(folio->swap);
>> @@ -2893,8 +2902,8 @@ static void __split_huge_page(struct page *page,=
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
>> @@ -2910,29 +2919,41 @@ static void __split_huge_page(struct page *pag=
e, struct list_head *list,
>>  			__xa_store(&head->mapping->i_pages, head[i].index,
>>  					head + i, 0);
>>  		} else if (swap_cache) {
>> +			/*
>> +			 * split anonymous THPs (including swapped out ones) to
>> +			 * non-zero order not supported
>> +			 */
>> +			VM_WARN_ONCE(new_order,
>> +				"Split swap-cached anon folio to non-0 order not supported");
>
> Why isn't it supported? Even if it's not supported, is this level the r=
ight
> place to enforce these kinds of policy decisions? I wonder if we should=
 be
> leaving that to the higher level to decide?

Is the swap-out small-size THP without splitting merged? This needs that =
patchset.
You are right that a warning here is not appropriate. I will fail the spl=
itting
if the folio is swapcached and going to be split into >0 order.

>>  			__xa_store(&swap_cache->i_pages, offset + i,
>>  					head + i, 0);
>>  		}
>>  	}
>>


--
Best Regards,
Yan, Zi

--=_MailMate_33363929-3563-4370-B6A5-2015B3B96DC5_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXM5hkPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUjkcP/2H+gEvZerjyIDQT1a5tjOnBTq3TG3kVyNor
jDvkHfZ2lcHy4n8C4sdyQa+oJ1yjzEMwd6ReAVQ7orSDV8oQp/SNmJok6u6W+Jad
MZfdohB+AoAXMUSUjj2bLhWPSH4YCZtX3LmfNGw4N/pS2CRMGXPp/NPJ0K/95Z3+
LvudZYHx2VqmXMx0tC2jNSHeMWe/HhUDXRdftBRQmQyCt9MLCh1tFTyPJc5yx6N4
YOIbVqGN2lybFE30d9Hge0xohDoKqBPCZnxAlmgS7ZinVwhKBCTcKHmMTQxlFElE
JgqOtRasNZg6/gWWbQzAjW5nqChtftX3YFdrRBtj9DJsSbIMciy3v8XQwISFfXhf
sP0VTQeCljaEgXvkHF/m1cSNBpr8QZA9rJEHwYNUo9PGr1iFQxJMOMGnfVmMelBg
4aeS5GHMAh2xB/LC/g6VUKHp7/F813zJmWPl+Q8OwPsVY02hJ3HOlcMBfvG2p1XD
habeDq26NLQqN6Kq7AjDJoxTP9y7dKRsVPaEeOWbRMaJZzOw4kyvNWOhYEQhZP+N
FRctb8aXW5db5cJLF99xWdzTLVubuAiSwzdN/W1bxM62822jLrejQlJnJhefckDh
8SX9CSdila+buiGSAw5yjvtXAHekOjPexCT5CnlQ1A9A5pDxJLQ5KrkB3fL/Q0jB
nG7zeyx7
=YKm8
-----END PGP SIGNATURE-----

--=_MailMate_33363929-3563-4370-B6A5-2015B3B96DC5_=--

