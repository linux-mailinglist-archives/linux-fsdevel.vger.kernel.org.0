Return-Path: <linux-fsdevel+bounces-63995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 158FCBD5593
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 19:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5138718A4778
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 17:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7A82C0F64;
	Mon, 13 Oct 2025 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uq9AAS7q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013068.outbound.protection.outlook.com [40.93.196.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FAA2C027A;
	Mon, 13 Oct 2025 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375084; cv=fail; b=QtPKfoK1k4z7dy9bDrMDFa3TCSh8WFfCPVlwczQeYH6SYq5wH5LF6Kmj9zYYpfB3CRxpjGNVt7dHE3RWexxOVl4IM7wFvzvp/ISAN2cjNFn/Z7tBdfdNSGbQXNftVmWp4K8G8v1J/JD+vHvCUT8Kcbn/FI7MzXNOemqTJ/MgwPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375084; c=relaxed/simple;
	bh=odVQHX2bItXT/VNX0+w6n2m8ubgcxmwIwsG2fPwDG6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=efccfnop0WTEuef4S0jaSeB9rDGSB/cH1PCbTYgvGuBGdLpUZevHeuXbsifW50OJUcPnu8iQlYXFa4DfeAYM8QF2UJ5ub3WZvITJMOU0aj3JzYiNGkxEd3tmmHyLOu3qiCtSd5cQsYZpFvx29no3LCwQk2HJ5P84Bc0NTQ9vHDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uq9AAS7q; arc=fail smtp.client-ip=40.93.196.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJFgrqTj3W0N3mPO8j+AI3MSny1v2mRs/j1/pkNVlkJ807hVdQkQxG5mzBf3+MymOuvO9Go7sOP+WLkBl8jj3XaDATScBSTVnrUmXn539XySoiDGxM8w7mKu1u+GNzU6fDbCfQ/iAiwKAuJ9aeJXycwHnTnUNJwXdUDm6VzbUPTtum9bbg6UAtbncEMzz8Xy1S5lE1lTs9u3JbHjtvVc0LoTzAZrVV9VwG9fpgkyjTWiw0LaSN4SGb4QSbLHhmSXDz+oqqmLpjqX9F/5h1XoD40LmReWxtOJKAHkHF5JfPNF+0ZNKiRStuL1gLOav7rXtuAwqmvwKk4qYaHZ9ZgkKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRGtHXaUHiqJ38tfbHAqKZZxQdP7KOi9+51mQ6JV86s=;
 b=r3W7no9uAYS5d3LZ/5pb5gDF+6thOVQt17wM20Z0Jsk7wXl2hZ9xQ+qu2RFEUGxUSmWU1I/GTSYmoe71oBzXaVycULqtDB/LE4YAo+KZa1icAE2tH0+CnBA76dSFkAUeTmeldSH6zsBLvKanjcblqiu+M4pf5aCwoUO8285oFHe8iDJ5hseVYpKfgcId2By+G5wSITxBw64J2FrR50DQtscSSORw+tvprfVVxOIKVRiVhxZMIqd/rHVhjeoed9Gt88fVnHFPl2bU7V7Wtz1F1xRjR6okKY455wx8n5nk6h7PShU6HK/VGT35K83LKe4Ww+TriAYR23cgDSJwFVVHug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRGtHXaUHiqJ38tfbHAqKZZxQdP7KOi9+51mQ6JV86s=;
 b=uq9AAS7qgdsJ/iI21xRuAd6PAnhZWrY3hgI+2kX9gTSTF/z0LeuLM6PN3KK0TveiwOabWIbMR1f6nKh3N6Aj0Nw01v8HOvSOUdvqW3Ei6o9j6FJd9QHVpCw3QJud+xHkD1pcwAcUCY04tMNKyiHqlUdJZo+JY1gaWCt0YJ+Hvt47JV2EYuHGA5OP6anoizBeLH46mKI0v4ylG04RNThXMaLk5wIrT17ro/jMmlhS7z/vZhfLPZWwU+1py3ZghrBTn7MFMpQrOoZ8qjY5ZIzyFZbDgAZN6cpgmBEAspCGABXMvHKJ4Fqa6xl9Op3QK1TvXkF8yPJtvN0DtQqCCu6SFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Mon, 13 Oct 2025 17:04:38 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 17:04:38 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
 mcgrof@kernel.org, nao.horiguchi@gmail.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, david@redhat.com, jane.chu@oracle.com,
 kernel@pankajraghav.com,
 syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH 2/2] mm/memory-failure: improve large block size folio
 handling.
Date: Mon, 13 Oct 2025 13:04:36 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <0CC5B8CD-6231-4A72-9225-AAC7D1F43F16@nvidia.com>
In-Reply-To: <aOnkUxWPODofUnRy@casper.infradead.org>
References: <20251010173906.3128789-1-ziy@nvidia.com>
 <20251010173906.3128789-3-ziy@nvidia.com>
 <934db898-5244-50b9-7ef7-b42f1e40ddca@huawei.com>
 <aOnkUxWPODofUnRy@casper.infradead.org>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0251.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::16) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed43273-2171-4abc-ca51-08de0a7a97b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+LztM0miyoVc4urKPhfDg64DrOgFRVjA4BQniBUtxX/5lCXOrrsP8K3sD/hn?=
 =?us-ascii?Q?7/U+rs8qqme6BexImjo/GjR00iRRxJORkY9tmQByKaG+oI1mmJDKi4Y7Jt6j?=
 =?us-ascii?Q?ptNcS+tbcMuX4YWrrQpvAKy1rXUQLBXUmhXN3WzM8RiDKSEdWaSzKPIID4Jn?=
 =?us-ascii?Q?6hYfsKqg5xI2kWiDqGVvUQJiFTvl/7QvkKtzT3yK2e2w42gSfd3lAZ8Qcmf/?=
 =?us-ascii?Q?GS2rMpKZwvwpumuoVSHt2FeytsJgrRaUERGtSMwL46gkhtQHpE8P5T6jhwr/?=
 =?us-ascii?Q?xIqWF7k8uSTmmCY602DqQ9nX/kiM0Md2fZZv/h+QO6YZXayeP6tirQDzZdX6?=
 =?us-ascii?Q?Y0hSaotELVp2qAhQrvnJJsk8YSzHptWiuI/I6IgQEv45xK+4d7FKXSlm8u3b?=
 =?us-ascii?Q?9reiygvYSZz0gjFkN8brnkUMZxvS9wTYXfHFf++gd/qT9J+HmlvKlwBPgqnb?=
 =?us-ascii?Q?bgxjDVVbLYP41VZdv6oNWtZdtp06tvtC/qn0QI75h/Fz15848lRYEzlYVBnO?=
 =?us-ascii?Q?zRxwa5BD8j7ROm5xd0EmA0QDxp4fw1/5y6/XdnFNESSP8ika/uA7o/9Omytq?=
 =?us-ascii?Q?vqgM/DVwjms3/SDI68ah4GDCNoW1LWjqvER3oQpKN637qL6aaxRxKIcvJHS5?=
 =?us-ascii?Q?YIwJ150bKOblz4hwn96wcA7wlp7wLc+I8N0UYYI2NOm6mo182zm8a/gXkNGO?=
 =?us-ascii?Q?GaKQVxMU2uEY54J6WQLyrfHv0xb0phUn0k1h4F9grVETvM4gXX5oJYW/KDJV?=
 =?us-ascii?Q?lPk9rm77m/oD6LoCeElgKgDkTObLgKWrygNNVOYOyQ3JfnmFnJtdnA8XyZvP?=
 =?us-ascii?Q?6zP0BfvsQp3WB613pOGc1sD2iuHnOZt5ZJesEnWrBrCAG2GtMRzH/YD4eXXO?=
 =?us-ascii?Q?oCPgCfK3uWKsnziAu3j8KyVSq+1wZODqITmRjE5YwmrBxwjvWGTahmeVxzsS?=
 =?us-ascii?Q?E9c99Tm0I1iMHKfMyLgWC8aEwBpggN1h8gHWHGeAROuFRNgJg5N9cN7Vw3L3?=
 =?us-ascii?Q?xRRqnAeS8cZ8eQX1BKgIxv+jNmPCGbAD5zv2Ara8zrmKyRiVcHMBhTKbTqOM?=
 =?us-ascii?Q?4Nat3W0LbVGWMvE6CIQPsk6US9OPSnvDBkoxq4a1yCHuNsaOQs5VijR+TIgv?=
 =?us-ascii?Q?RccDTYqnuLhzNsQpNSUIeLUb1pVf62QggZ8aaYtSyCZUMl0zOne6KsjhEeXA?=
 =?us-ascii?Q?bkzYK9anmYl/2X4ux9+Jlv3ijzK55LPJ2s0ee5GaG9I2kn+rtGYYArR8vyKf?=
 =?us-ascii?Q?MrQ1siLzIOU+wj0HMCWhcKZxSuXOxML4056mORcoDdfCy6uAlZrazbs3K063?=
 =?us-ascii?Q?OK3BxHbT0OoDExfHPJkdvdXZ9c/OStPR2YoM9PWDOPY6p7XpCZ2VxSdxT+ap?=
 =?us-ascii?Q?klwwTqaOdvHh+ZLIk9+7dm6SjmFl2cuXQf0U7Wk/LFWPZrHJkOnLLMFKy9hQ?=
 =?us-ascii?Q?3ZxRaNUNMemJlhcrRHdpESBDLRw/EEDy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r/wbm7L7Qa1sbJ6+BNeIoycexEUFcg9xm0vqxCYOoSHU+zsqhK7cBzmHDsUm?=
 =?us-ascii?Q?9kQadDMD6m0s7OD8x1h2HLSAYOrtH6Qo+6qzrs3j+aQJQwjBQCXKBIjlpoDm?=
 =?us-ascii?Q?4O/0fbUx0lhaoGH3gUZLSCdh/CJQZHFUJMI9MHUS24jGHiKs5IXkke3arpWm?=
 =?us-ascii?Q?KvTWl5xx5ooCkIECbyQx1eqO+jfF5KJXR7t+jicV7SVIrSi6QQAxZC0n7pa5?=
 =?us-ascii?Q?l0OAfQT7bNa0xrlQOsoXgewcJDC7ToyjxXQI6ofk98fvtYlw3DK6VbVBBXHT?=
 =?us-ascii?Q?o/uvI+smxhKBRtcWm90Ip+rT9E2739mj4IZA/E52WKVS9KLNtW7Lj57W93n3?=
 =?us-ascii?Q?xe8eijiWr5DEfdE9P7OW9DYgyMORAM0gKPskX7Cl3uo0JIb1pEa8JSJA6Sc0?=
 =?us-ascii?Q?J42ZXPVqJnjoUM9pxKuRk984I7HE7vKbJo5Arnfv2gXC06o0rp4Wev04vfcA?=
 =?us-ascii?Q?ATuGDrkh6Fo3FJUceWjglUniykK1P8IEcsbytkxTD+h6ztUwGJOXCtPhgl4O?=
 =?us-ascii?Q?CROps8PlYIXyJEtsC4ESeFws1Tpr330NsWopnFwovbTBC3n9HqBDRlwkM6xc?=
 =?us-ascii?Q?pFfr2oXXy8XVL17Dm+YIwGdH5m13ANwr7WRmRMXdjbesAi6XlSCtGJn9IaMO?=
 =?us-ascii?Q?hfj/pwl5zsVJhgYGApAbh8NSasBnHc9/gV7EOG5e8RkwLQPc1bmLVZw9exEf?=
 =?us-ascii?Q?LjWtuiDr8WjeVCidOrOs4aylaWIGU2SgswYPD2bEeJX/hvQn9zREbxAVGqtK?=
 =?us-ascii?Q?H0RS7EMvBTa4rYMRcsaEGx35y1uZQde0TacJFQxacX62PmD9F67x4i1mAN87?=
 =?us-ascii?Q?ViBAlnGR8xKSvijZJPkiMApGB7PU5oCcI0cVtHGSB/ExuNSiRb2urteCqs7V?=
 =?us-ascii?Q?st5H0UHjHQijdnu8ek+hQ0wmqQuuu/psBWfmzOEJl5RKNHWctLroNU8CNAEb?=
 =?us-ascii?Q?zk+OBgzc46tu7aWJfEyn5YeNwGsiCA7vXwYfe2/Yk8/6jTC9VIsqoBf/Srrm?=
 =?us-ascii?Q?etWbtNcjbX6r/KpQr529YX7VagzTKpLgNnr+te0LbCRs1uFupQz7O+TzWSG+?=
 =?us-ascii?Q?YcGXWsToVPK3xy4971R4h9pqNDq3m2ggodfQQmc5pYFS2ofhxnImlWjvsQ9i?=
 =?us-ascii?Q?EcDX9Vct6zR31E2DcImcpZa1Z2dbMlZlNIybKbTkzwoHlhm7OoVBzHt9HxfT?=
 =?us-ascii?Q?eAanuC4ikvXGEJykiLN3FWbV/dL+rEBqy7nIvw4vLsRYhaEetjz+EvO84BPf?=
 =?us-ascii?Q?iL0VZ4e0t/zoYlV5qFqVHQWeqXn6B6LCTaXZCDdv8/+P3YDOEUUAagyGw9AF?=
 =?us-ascii?Q?2h/crcEiC6/uh0R/lL1kGEY472y7mcIPfg42BBtPxjbxQFbFSGSAY0plF+vJ?=
 =?us-ascii?Q?3jelNqqbGY0kZjzkKFfoWuC2mfdxCFhCjpzLruL7GFukLB1B/5wPO2XFFxwi?=
 =?us-ascii?Q?424QF7VKz4simhboHi+5dpsTjI3bJUuaDgJtMbvb5Pz0FYSTLt04pFAu8SSq?=
 =?us-ascii?Q?j8W4Ttf+/XYaoxJ6kfJrZj2FNbR0CeLTylA8ULtZxU53Nf8gMfdiF5nd56lG?=
 =?us-ascii?Q?4LhWjouNwKwdbALZBxl74LBFZQfFw2KgF5BgWHzX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed43273-2171-4abc-ca51-08de0a7a97b8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:04:38.2501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2g91MddGeiCcIsO93wtTRh5rnDYijJdCz1VJB+akkaRqQrRjOuMuNedGpJHuG0oh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039

On 11 Oct 2025, at 1:00, Matthew Wilcox wrote:

> On Sat, Oct 11, 2025 at 12:12:12PM +0800, Miaohe Lin wrote:
>>>  		folio_set_has_hwpoisoned(folio);
>>> -		if (try_to_split_thp_page(p, false) < 0) {
>>> +		/*
>>> +		 * If the folio cannot be split to order-0, kill the process,
>>> +		 * but split the folio anyway to minimize the amount of unusable
>>> +		 * pages.
>>> +		 */
>>> +		if (try_to_split_thp_page(p, new_order, false) || new_order) {
>>> +			/* get folio again in case the original one is split */
>>> +			folio = page_folio(p);
>>
>> If original folio A is split and the after-split new folio is B (A != B), will the
>> refcnt of folio A held above be missing? I.e. get_hwpoison_page() held the extra refcnt
>> of folio A, but we put the refcnt of folio B below. Is this a problem or am I miss
>> something?
>
> That's how split works.
>
> Zi Yan, the kernel-doc for folio_split() could use some attention.
> First, it's not kernel-doc; the comment opens with /* instead of /**.

Got it.

> Second, it says:
>
>  * After split, folio is left locked for caller.
>
> which isn't actually true, right?  The folio which contains

No, folio is indeed left locked. Currently folio_split() is
used by truncate_inode_partial_folio() via try_folio_split()
and the folio passed into truncate_inode_partial_folio() is
already locked by the caller and is unlocked by the caller as well.
The caller does not know anything about @split_at, thus
cannot unlock the folio containing @split_at.


> @split_at will be locked.  Also, it will contain the additional
> reference which was taken on @folio by the caller.

The same for the folio reference.

That is the reason we have @split_at and @lock_at for __folio_split().

I can see it is counter-intuitive. To change it, I might need
your help on how to change truncate_inode_partial_folio() callers,
since all of them are use @folio afterwards, without a reference,
I am not sure if their uses are safe anymore.

--
Best Regards,
Yan, Zi

