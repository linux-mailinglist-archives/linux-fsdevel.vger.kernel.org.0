Return-Path: <linux-fsdevel+bounces-11567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EACB5854C81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 16:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B2EB1C27E51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 15:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7ED5C905;
	Wed, 14 Feb 2024 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dejtT5md"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0405A7B4;
	Wed, 14 Feb 2024 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923972; cv=fail; b=IcFoYhGBnLAq6n+wIJJA7YR+/nJ7I3SSWs0PzeIU9kolR2swMTtvMrqVOD0A3mDVTMjy7FocMbucJbpfNA5Tm1kX4ZuyjiMmEaKfJodZGHwrPgbrEXLo+b+jXvXAAHjm/OlKFUIqnHArcRC0xE2MssgMYfYBpngrPXKtu+2R5VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923972; c=relaxed/simple;
	bh=Fsr0B/0GLLArSGtuF5yecwbRD0jbFgqWVkfEjq7uwMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ovNR638svCqQohC9V5QGTzC3Pye1sg4xxTHD6iyMJYplfYLJ9wigHM7KuofA1/lRYEYLJ9KJEb2AmP6wdBO05DJ/IfpItXzV7/c9Um/SZ4r317AU9i2odtTZXSTzJXF1ujlEmppXVUeXf3sIKVjCzlNDTRxHw5/YEuWiGXgqLJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dejtT5md; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kn5vLWy+OvOtMfupsfuoXJf9g+4RPMSqOiGsichYsdg5JGDvKA6LR+JAvY0VH5myjBQKOpLq1njvSPEtt8GQD5LwnzcBgf15VYNKuvFUVy3rfkLR3qaL3e/z3m+Dj9OMuvraQMLNdGSh57gPHNeBHpnZBz53LfOHYivNGcHfZkliGGFJwEZ/+sNBXtAHDoXGsiahXuTcjQR7GFP2NzORBaIxJiY8e2WBG3xfgESdWTi7cYPBxUIBEr0sfrKZ3qfeEg2k91GLIXQRgGXx87w7DrNJ1/dQfNSyBRShHCGsqzdzWX8vAsiK/xKindO4WzikGM+rOCsqU1Y5eskZom5LKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8Ky7f64np0p1muXhNJIEgbsBYkJb/YrLTBP4EWVMn0=;
 b=Ca3vDbgUVmOWj1EkO9gS18Jbb4n7YfkRdYCRpsNk6AB3c58mB5SQGFxtbBYE8TwdZCxqh9PZBSDRKLGqRZ7bjCuPsxysZ+5lNh6MZRDa7hqA8UGwECNe0f4j0H1cKwueWTuJMG9Kav6dcD5v988OiJdHG3ep/FV+VqNTMFtar0ccYsdx1sJ47o1xHsrytFRJKezucrNKAETUgEq8sBTA+D3xZysaItZWzBhTTah4asKKq21FWaPDyvO6KU6zsuE1a1rZjKIhUn44ASw7kIEM3S4TmUL7Y3VRCQnV9FxO7TnN3JlzmPLl2chohB7e9J/B0kv0iqoGnJddtkF6hNHS5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8Ky7f64np0p1muXhNJIEgbsBYkJb/YrLTBP4EWVMn0=;
 b=dejtT5mdKWSm0RMFLHhWsY5sAJvKqn6UMwf+pttflRvbJfcP/pNU0b3NipLwumu+cOVK5Npxzc+1IBW4WBapXiZ3Q96kgsXHDxl+OJvR1ly7OKtfbRTISCBBy9BkVYrdB57cei1/Vcjp6SDtJH0GbKpmuLZDrEqgcM+ROIwbDk0D/g8J6HZcavk5CAc3ZA/A5vHpz0fsIWvdh4QSMbgg/yvgcFamhipZACtg5o/56qZoJpSGnhSJ4WOAMuny1WGUIxHHOlHw1MxqipmUdcV2fw1Sc3z4HbZN67epPOZds0wa99rsZh0beP6kUTUQzn87wsL36dMAcdlqKzM39sUHmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SN7PR12MB7323.namprd12.prod.outlook.com (2603:10b6:806:29a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.26; Wed, 14 Feb 2024 15:19:24 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7316.012; Wed, 14 Feb 2024
 15:19:24 +0000
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
Subject: Re: [PATCH v4 1/7] mm/memcg: use order instead of nr in
 split_page_memcg()
Date: Wed, 14 Feb 2024 10:19:21 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <1110486E-73BE-44AE-A290-BC8AE1F06F8A@nvidia.com>
In-Reply-To: <27691f5d-2218-4247-b688-cd16d46961c3@redhat.com>
References: <20240213215520.1048625-1-zi.yan@sent.com>
 <20240213215520.1048625-2-zi.yan@sent.com>
 <27691f5d-2218-4247-b688-cd16d46961c3@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_6E9AA38E-7372-4581-94C5-3567A0306DC9_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR15CA0061.namprd15.prod.outlook.com
 (2603:10b6:208:237::30) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SN7PR12MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f50121a-1c9d-4915-b584-08dc2d705399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WPn4y/uFnZRRhd2UE2y96n2Hc+ibvBIof9h9av0z7wv654fg9VBNsAJpfP32vD3xEBlOtsBrR0rI0JpIM+McvtvSIzhtKUvspZwSodwSJ1jQw9hk3Nrvqv7dbmk/90ui29k1CnVeQ94p3Rp9uAeQXLH2AG7unzX35tesmC4EfPgmpW4ovIQMteR5q71ux3eF1xn8Om5s2gEiUUkK/WaLFvxB7QRryNsmJf7ajFcflobC84jcVx6UkNQS7Qltvqo/XXcDNNyQ6imtuILed7ToDy4KJy8tpybCkzZDkKVtdxccWY/2NTEI1OIGw6WRU5IxAE59JQvY3A1EFq4drWCwt8akbAS4NuCpI99lCyL2ndSvc3tuHQAq2k0CyCo15rklnqjgaXP994UjtV0CqG1phu484u5o+MoA+yrSbkG6v+s0ZrVoe0e/byx65tsKbPiviay6LbE0xbY2RyPu/CSswTD36FnpOKRnuJQtrITPdch3Hvx7U4aJSBVdBPZ0Q9xrkVQbvaA9OXxNXvVx1XNNU0miX+v7HY4sGPyNNHnmrC6T9fx9J3YkA6Ql/T6oLU47
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(346002)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(7416002)(235185007)(2906002)(5660300002)(36756003)(41300700001)(2616005)(26005)(53546011)(33656002)(478600001)(38100700002)(6512007)(83380400001)(6506007)(66946007)(6486002)(86362001)(66556008)(66476007)(8676002)(6916009)(8936002)(4326008)(54906003)(6666004)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zLK4FmpHNvrrS0eXvOsBJl8AF6XM5T4/+TCr1bmRl3+oaZIaN35gbNxa30be?=
 =?us-ascii?Q?gw1uAthZtz9F2uCCMqOu61ZHBweB8BJmlug/YfCcUrtRDqRPDoJcjD4I0q/O?=
 =?us-ascii?Q?vpmJLoUKxogVcuvL8o2kgkPiv3NiQidgkQfMTbPJ/KCLpstSfkkzkU3ipVd8?=
 =?us-ascii?Q?BhzJ7g1AA8W+i5InLBqEK79M+uPmKQP/I4LEJE2nyGTfU/4jUwUENrS4wvSA?=
 =?us-ascii?Q?lYLzkWuft0qDo2Zz2S2fOQMwcVjGc5vBFdNVFahk/jgomkNVC53J3uLDT7Rs?=
 =?us-ascii?Q?/6VRn3HiC6Eddj+IsgvXX9gzUE9A+FHrayV+NybeA7fTpxKFd6Tt4bXqFkmt?=
 =?us-ascii?Q?+gEV1bfnbJuPn0MbeGX+YIBnWWgsPOQSw0Krzjwu1Wdwj5Pu4NsmCUjcON+u?=
 =?us-ascii?Q?aiKbf1LJv2lTeqwM55wmdSm8ARXYJTTXOk15ogx0i3LpeKQV+/osx6hey/NT?=
 =?us-ascii?Q?UEOOIGGCPQ2L1SirW39n/wpTnjMW8lhs2eTI11xWDKafzJHpzNT7ontDk7ef?=
 =?us-ascii?Q?to8Xztf5/wCWmiaB8hVJs3R7JPJ3MCUDv/e8bh9pZtPTM2gWrdgMWkSNbiJs?=
 =?us-ascii?Q?a6bsjBAunFXEckfMGwr0hnmmbhWBbx1IAHpvA/4ES0H3P+tVl27dyfG5UXCf?=
 =?us-ascii?Q?+bG4B2Im872/M6kTC9L9sUQpdNmSZXIxNkxG9BjVBCtTn8Kbdd6vDvmjdEcs?=
 =?us-ascii?Q?bPvoOAKnchn/WonhZtL7e/fDjIkkHAyTaHFTWzd79l+Hce6Pt1jW7V8VqxPc?=
 =?us-ascii?Q?9HIoxCSDoTnEqUxC13R/bLTk+9Ej/mLoLzMkOdGBbaY3hiG2lrzvd0DtmUGX?=
 =?us-ascii?Q?jx8yKbug5sNf1zMQSD+2orzr6TRz1nNjmLx0QHAIFqvG9MN+s/1+mGf4tJCz?=
 =?us-ascii?Q?+6NXZacbzJYjwE1aq6Uf4uVn633vbKcZT5Q5hCxRf0dcIErmaf5wVVwJ1osH?=
 =?us-ascii?Q?3bQfCN/Ja2F5p2AEBDFtlw5fVYA5gZQoXJLxSLnzz8hHIVuMUcUFhNZfOUxJ?=
 =?us-ascii?Q?9m1bVw5ZxbwlyAJyC6ZtHLwcBZGVn/rSeOHiw8YnispZJRKBHfeUmh4HnwID?=
 =?us-ascii?Q?zW8ZT/kfoDlgdLhceA9Xi5JZw2MebaYBUPjMZJC8bkSxXUgvfnLu8qigYgi/?=
 =?us-ascii?Q?r3SyYK/sHGwXLG/+OmjlWq5UeMOkXFrU7MiHqlXzOTXV/XM6G9LBTeBMbHnL?=
 =?us-ascii?Q?a9h0HPWSWHhg2j+r0GNjZGnQOYQ+eXPTBGxvyiMeJFX9FmRb8VpANR1s1kTW?=
 =?us-ascii?Q?g/+DCrpJbx61R6XQVBl9Sf/EIFwImG3QNzzcGSeTrS1rJGT1BlnQwiJ7h4aN?=
 =?us-ascii?Q?Dyi/JZVRANT64A+IOR3yj2PiZ5HoKp10HwIXpCd1RG3WTk5aYZzYD/woSwxC?=
 =?us-ascii?Q?SR8FM5itAYpqYBHuV24iDICKVnqLTeU17uf+amGsQEvxZxn/GrIBzHr9h+ku?=
 =?us-ascii?Q?VmEEjWL6d3Q88GoZrzx0NUKOqgpsU7jMtRMapBuAJicO98BrqXmRC4Y7I2tM?=
 =?us-ascii?Q?1BOYfUxHxefk6EPRvScQPxhJt98axP/5UI9oXk/fl78Pal6hdNWnCfE1x9Qi?=
 =?us-ascii?Q?kpbUc/k2bxC9xXA2Pbc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f50121a-1c9d-4915-b584-08dc2d705399
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 15:19:24.4366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGQG8jRqjMMFRXgMyg2HsQ5AyhP3lAeq+R+PJfy/AJQgfUu+V3FW7G2CdGa3aa3/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7323

--=_MailMate_6E9AA38E-7372-4581-94C5-3567A0306DC9_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 14 Feb 2024, at 4:12, David Hildenbrand wrote:

> On 13.02.24 22:55, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> We do not have non power of two pages, using nr is error prone if nr
>> is not power-of-two. Use page order instead.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   include/linux/memcontrol.h | 4 ++--
>>   mm/huge_memory.c           | 3 ++-
>>   mm/memcontrol.c            | 3 ++-
>>   mm/page_alloc.c            | 4 ++--
>>   4 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 4e4caeaea404..173bbb53c1ec 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -1163,7 +1163,7 @@ static inline void memcg_memory_event_mm(struct =
mm_struct *mm,
>>   	rcu_read_unlock();
>>   }
>>  -void split_page_memcg(struct page *head, unsigned int nr);
>> +void split_page_memcg(struct page *head, int order);
>>    unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int o=
rder,
>>   						gfp_t gfp_mask,
>> @@ -1621,7 +1621,7 @@ void count_memcg_event_mm(struct mm_struct *mm, =
enum vm_event_item idx)
>>   {
>>   }
>>  -static inline void split_page_memcg(struct page *head, unsigned int =
nr)
>> +static inline void split_page_memcg(struct page *head, int order)
>>   {
>>   }
>>  diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 016e20bd813e..0cd5fba0923c 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2877,9 +2877,10 @@ static void __split_huge_page(struct page *page=
, struct list_head *list,
>>   	unsigned long offset =3D 0;
>>   	unsigned int nr =3D thp_nr_pages(head);
>>   	int i, nr_dropped =3D 0;
>> +	int order =3D folio_order(folio);
>
> You could calculate "nr" from "order" here, removing the usage of thp_n=
r_pages().

Sure.

>
>>    	/* complete memcg works before add pages to LRU */
>> -	split_page_memcg(head, nr);
>> +	split_page_memcg(head, order);
>>    	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_6E9AA38E-7372-4581-94C5-3567A0306DC9_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXM2fkPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUe44P/37IDa1WsWVe9kc3Jon2KS5bBVOe4MWaDCz2
oc/psM4afd3t+UgGcdm6RTqA4b8UJC8+9fKmACHNt+orzXl0lpfpZxwmCgIe0lmj
wCB5vnPbOf8l5p+eg8kyIwwEw8EeitH1dUx3Wp3RS+Q5PPT7gJ5oPctGeHwObbMI
pnie4tDVNTsKVPc7/WZikGfqc/cTqyAPbGMsgUo7OPEsY5viXxTphFs2BPYocTTY
rgARFkXO3g2uF75CHlGXwNqJF3xGkLNXQB6AUqh21Kain5pCrDL1Y2nsUfljvgGw
WX5JR1NBmRY6UFOetvnR3+YMqBUqO8r3nnKgFM03RNZaY/4v7bKwiDlKBmvyiNeZ
22t+hgRUpUauUoCTv+rTAsIUVag5QLinnBL8sfMk5YtZF8+d9Ww4KtjRq1ZwDSG7
bXftHc3VYx0ScTGC45Xg9gqZC09ELraQHfSQPcv2s9+VWW5p6C1iZn6sLwkLcmS7
A/9BkXPtxk/V2sXFWkQss/o6m2qFFAGifrHI5B5kp/OMW8zD6EO3yjBzl3tHL0ye
M/9b3SQ5l6yPryz3CoKkVETDeKvvpLkclOSqf2kZpykD//ImwXUSxQj2Ca9LSgPj
xdQ7cyAUSn2sUbwxOKj9uxSNr4rkzE/4o2+OoAA1hfCIRWJacBiDXFGjRsV8iXVs
8gkI17RI
=+scf
-----END PGP SIGNATURE-----

--=_MailMate_6E9AA38E-7372-4581-94C5-3567A0306DC9_=--

