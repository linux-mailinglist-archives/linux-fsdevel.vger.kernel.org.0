Return-Path: <linux-fsdevel+bounces-66600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BB1C25DEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 16:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C4BB634F558
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 15:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E7F2E0B42;
	Fri, 31 Oct 2025 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BTUs0u7P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011062.outbound.protection.outlook.com [40.107.208.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3736B2E03EC;
	Fri, 31 Oct 2025 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761925346; cv=fail; b=T1BaYPDT0fVBi0dhrY7r5HG0Wv5UfLYIZ6Ir53PJeFGKmpYmEKtj72DmX0Q3iPVA9kGuVZx9vKXfqpgGKZTgHe1eN11ZssWpcrdqyr7LqKPuZYVKIQioqCR8pMzwBu9u1gk2H6Tm+myBzYrj35sYVMcRIlALi6tpiYOD8GQ1MMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761925346; c=relaxed/simple;
	bh=F3XHTlckErJJ1IoSbQFwbjMSCnIZ4hXgb5ZMJtgBS+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gKSRaABVP6Qm5yHzk3v654/O8BqOm4Nt9Gg/ODlv71BMk/GdKtO+9H592VUBflSRkdULB/eTlZ25k6dD5eccq8jYPgW35jqvOJdlYzdyH4grBMXScUgNu4PeUNnGL6J2Ix5yhVZ7opaZFELmIftJut6VXIFVKjfZlRy3vICmHWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BTUs0u7P; arc=fail smtp.client-ip=40.107.208.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFno2QcYgtxZ1CokDMDx7rR+U55zAb2LgIMfIhXs7InILwIenhwEyDb1ThClKLsLMzFjla/7+DzOBl6n4NPjype73RjUbDsR19/M2wVFvk0Tx8NLc3nR0BCSNf2Okpkh4dWlbTXbN4Glg7xOQBTdx1JmFB7SdJ2lGUoY7lxp4G3LePyChYHZcTsY9YL9u00F5PTvb3rIMRYCvIlT0pbuMZr/taQoiQGS2FhZzW9CpbywbWH9iHU8nXtZcLwl4Iq9F5PmDMEKjfqffHtdgNSSsGevjYKS56uJs4rgQ2WU4JicczsDIzB7lcpOnaxG/IW7tEO1d93jo24nWs+RiOV1CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sn1uX4NQLjcde7SH+PGfUJnYc+kHCAHy9AbB3lPCRS0=;
 b=tBeDQxqLrvMrB/ekW/CX2y4T96EGHJQCLr9oVuwgYx3rWCy0+poRuirPklPW6NLXTI1m/gWkzXjaPP6/tZhMfxMljZGm/pPzHf6xNSFgfWqhXCM1kvsCfZRQcGBPmhbpkhmQUK1ocRJlo5h3CIs7D//3/tRr0bNU9oVVhm/g94ACDIyr8KLxe9TobWwE+VqLQJIIA+E2mBDytgG8A6Rx55Vd1xdpDDhUlb5HQxFxYLWrHFI/QoS+E/O33uyC+Mul399PRU1iUi4PpGXrbUatYK7tGul+bLeTQvAkfehyF4tXABBFoyqwq5EJU+spwt8FKGQ8IyGBLZDhP48ExabpvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sn1uX4NQLjcde7SH+PGfUJnYc+kHCAHy9AbB3lPCRS0=;
 b=BTUs0u7PeJ8DHH5kIfz3o7PTieKeNhgXLMJAvOJGFgp+OBSvMOksK8QAFkm/P/L+80oiOJxsKlQhZ257B4Dj9lZduJqIsXE+vGMoeW0C3ypzoHBGCRUAUezlMTjknRnwSHXkFertCikxg12y/HppUQl/SdKDL8Hcc//61NMVyXbT6iuFqbkHBP3r7SpX9XHRMT1eq96oiAcnz1OUvfSpiLfksLr1jMks4+W5YCIyZB9dSwCTK1PjuQyFKoMjIKU5QU8eWR2V+H2R3aPq5y5F/FMn3qz35hDVH6AnyvqmlTEvhyF+gA92+II7TNDuk3nM5IVnfvBP+TOhoW4LwOSIJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB7730.namprd12.prod.outlook.com (2603:10b6:930:85::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.15; Fri, 31 Oct 2025 15:42:21 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 15:42:21 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
 kernel@pankajraghav.com, mcgrof@kernel.org, nao.horiguchi@gmail.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Wei Yang <richard.weiyang@gmail.com>, Yang Shi <shy828301@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v4 0/3] Optimize folio split in memory failure
Date: Fri, 31 Oct 2025 11:42:19 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <2F077EE8-9E34-4EE8-B2BB-90FBE5680C05@nvidia.com>
In-Reply-To: <20251030204257.13590714dfb2deae8c2f193c@linux-foundation.org>
References: <20251030014020.475659-1-ziy@nvidia.com>
 <20251030204257.13590714dfb2deae8c2f193c@linux-foundation.org>
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0015.namprd15.prod.outlook.com
 (2603:10b6:207:17::28) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY8PR12MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: a088ea6d-6dd9-4259-dff3-08de189414b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fa+hRlBOAY/PsS579R+QP0po3I2I1bZnqHm3vOwUY/8d/J8h1gte4CllAuOP?=
 =?us-ascii?Q?Cf+jWYEq/dUqZSmmsbrYgpO9a6c5HtP0O9V0HzK9TKa4UTnSmWC4K2A4/A3c?=
 =?us-ascii?Q?4ylvnkv0saQzVxadu2V68Pwac48nCWo7db0xjyF2TxZIu9ArRS8wj/JthxqJ?=
 =?us-ascii?Q?BUxvKy69EqX+OkBvOvHQzdYuXNW/v2tTpz1yp54xUDaWE0yzDUSZgLuZlLAC?=
 =?us-ascii?Q?nO5ivjcrA8LO5W4JigvWcEV9UU4IJS5CHpB/i9sxcFS8nugsujH9y8MQsDZl?=
 =?us-ascii?Q?8iEsm0uiKc8/12lk/WxUU5930hwUJ8XlmpeeRPv8If+XxR/XDIj89J3E4xv+?=
 =?us-ascii?Q?m6Q5WOWhxieDSmBhYifNJk1RmclJRWKccnEC5Y9peueABqEtPIaAORDtZO77?=
 =?us-ascii?Q?Do/PPIyj0KVdLMoMHj6Qyvg7I75AipbdWWJnVIRuEaNc/OBuarhKmvOxgG5Q?=
 =?us-ascii?Q?FnOwBkDPL48httRgEPbHo69WWE1PofSN0nYjM6wrfB4O0z6DDX4r2fNhRqMH?=
 =?us-ascii?Q?u6WsRAlSL8ZCThlnfEbly4UR3SIWqw/zAeIMG+gSVhqzTmEVmC4Y309OpzQh?=
 =?us-ascii?Q?977xNhh3KFxINrjeuoIRejHW1bBXKscPZyzjvcEHMQCEBcpLvPWMqwpp94Xv?=
 =?us-ascii?Q?SJamo4UwJX3NysCiG3nh5gmNgwwTn71sHZoj9o7pIHFVhwnLQlggOc8I9/v1?=
 =?us-ascii?Q?owvsS+BuZ+BCYORpnRRh1UkMLXL5SrHPL8KIzJEBDJeiTmQ/xetWLeTOVhDb?=
 =?us-ascii?Q?Sm+LIEABdjGz6sWHRRbgrfSoH3nAr7N7bMRdPYSFT3P4Xm/k94bmpV8kIoI1?=
 =?us-ascii?Q?uNJ4rGmBx/kHYyM79pCRYQwTd4YeOX0/H+TcMF+zeRC+A9fjuJw/1g60qkt/?=
 =?us-ascii?Q?5bvE/Q0+9E/wY2c2CfHDLZ2JA2LTCFAh75k/y7HYnM3QDgkIuBFD9ab3yXxk?=
 =?us-ascii?Q?yd7njpcRUjnM7nHplA21S651dkajimQhaHO9He7uca+1BksZ8JZ9tJuuC+Xt?=
 =?us-ascii?Q?VJ6hcxkPEFm8+BAyw9kGo1UgPQlVo5K9Q16bGf9u6+1NRHjLESqh4LwnxHDV?=
 =?us-ascii?Q?JDIB/9KhotZ0PuivU/XhhPyC/wRe7p5lqONMlytEL+8OrS2I44LdABfo97Ap?=
 =?us-ascii?Q?VGdMnNn5AbwRBLcG6l1TbSUdnnaEK2PVaeYNSfU8imHqQl2uX+bSeAegZ9k/?=
 =?us-ascii?Q?saF+gMRLu0dMU3gHxYLBvooBgya2/gY/j2rSAnBrzrgLer204rfQ7eRxC2y1?=
 =?us-ascii?Q?hlBOvgChJNUYCECVE7FkPov0HJaWjIH9v//mMhYNuKSfY8s6dN2UC4EjGQC2?=
 =?us-ascii?Q?Oe57fZBsnO35f9ateDLb23LwqHmzyV+Bq01dLVUQ0by+muRdqXwY9I7WLbPz?=
 =?us-ascii?Q?cImfHHM6T12h+ELck0l+F1lFTA5gLNHZb2BudaIpg3PhLyQ3rwv/Y2RJaRPT?=
 =?us-ascii?Q?fQJ26vlz1//ogu3mv9m+1ZIMVpph9cPe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dwcnOUEaJtk9K3t1lqiTDKhzxNyz/s1UIj8RpFi2Oow6APiMsGZfHiRLybTL?=
 =?us-ascii?Q?+yGZePA/gkggCQyjq4iQKeg8ppZkRsNlH4EuSzdN6o99VAUCpbMkP13anKPs?=
 =?us-ascii?Q?ES4thUfzq2VskeffHDTzrLDMQTqVX0hKc3mrFR61DBW6Su/yHSJP1rcSBKim?=
 =?us-ascii?Q?n3k42/CJ+3LCcxspCHwvwOByQ2TpI0j1fOhARZTDmqoEe6KDzgQCRYjGx8+4?=
 =?us-ascii?Q?eyEqz/k7NP+KnLrjID7pPck/w/C/++GOqR+l6I6D3jFpNlwsZkKWN1FKvjuV?=
 =?us-ascii?Q?m5SzJoiq4Q4yvDsUEvJ7ay0oEZJxQ+blu+AQF9n7cvhfWd4f0jx7NtWXmKEN?=
 =?us-ascii?Q?VEd1rF+MluB16Sy9SzNC0mlc+8TRz2P2C9DdbQZjfhMmnRT+eBMFWnIEZxmK?=
 =?us-ascii?Q?WmYXuT56UjUJnNYVRCU00pee5velrULllaAL5ZhyvGAtnytJid+0Hhf0BOBq?=
 =?us-ascii?Q?D2hXQY70Zom71VO4B3mAVgH8cWUqEJ4Iv+yJ5DDu4Ur9y3Sa2byqW0Atts3A?=
 =?us-ascii?Q?nOay6xrGoCsVomXjRs4z20xJjaS9mBznNNQ/GGKK8TvKo+ume3Gn9FCPbhDf?=
 =?us-ascii?Q?/SCTzWzD/JZUgqFuO8gNQ7ZbVVi5iEA/HlaBvFnxcPc5161awwU0aZhB5E0F?=
 =?us-ascii?Q?NiZcboliZahUR1br+tknXP/bXWma/xbaCdcWcf5Oq3GIaXZ8me7Lo8sC+206?=
 =?us-ascii?Q?dpeDj3N/WHlFBFKszFNNX5y7Z5TfL+Ubn/jfhNnPcyv0ikMEBKB6KwNKwKXq?=
 =?us-ascii?Q?rkbJNJ6UHLWtiBcR35Xp6HaLc9t01p6wIeFFF503U+D5FtTyDQp/UfieNUgc?=
 =?us-ascii?Q?mDp1C0AmBGuoaZPHMcEe9OW5qUeBy6cNlVmAZ/vQWFi11fiItwVFvtgZ1zLo?=
 =?us-ascii?Q?nYo/9G1CFbQTqGwgJQkBb51ARdySLGnPMpQW0VuTONTNbN0NE3HH+Pa1ynD1?=
 =?us-ascii?Q?cvcASKRnAS9YsQXZzfxO7tD8SXeabuFHyW1xubuGj+NH/VaILXp6v9YMZQf2?=
 =?us-ascii?Q?iWC8C4PdVOHfvJCIIWRFA7TCnT5dLwmRZy9ZpXW8t/JPPdpn1yeQTPDG/pgf?=
 =?us-ascii?Q?NI7fqs+yi/3aYZMEdbjJGlf6vR8MDHty2KYXMjU3rLbAerUytUqGc4mtYmZp?=
 =?us-ascii?Q?YNR197niIVEjvkjJ+qz348UPaYb7QW1Yznth/r3IivIpfkmDAwIW4CcvTJsQ?=
 =?us-ascii?Q?ahUvpJrlWTkjCHHpHLEdS73xS14gc7w0xF0I26CXLs/IQrXNWJ1EqmExOgSS?=
 =?us-ascii?Q?i4KjeG9Rl1HGp1uXRF670ol/Joq73+VInFzEAFwvxasR9xNZ5PyRC2ZBu+1P?=
 =?us-ascii?Q?eE1Pq3J1GYW/zXq0AhsUs7VfTfrfTuhUHAI/nKSGsFw/tjjnxrNZD2PNqJ7Q?=
 =?us-ascii?Q?us6mA7zpWoBOw88rdrLWSaafX3c41mJ6Gzz1Jyw2hfH+CbZgn2Yxv9bKvXh7?=
 =?us-ascii?Q?cNeSRzD2YIYkq7uGB2xHJkK68u5LHzgAbzzXKvUzo7J4quGn4l4TWbpaixHb?=
 =?us-ascii?Q?7n6cNM3McxJsOhgfxEjNZqIvo/eTR8dnS3+p7NQjkBfS/g+4/kvvkPi7Ytjb?=
 =?us-ascii?Q?nrZHUR51m0SqAe4XI4jAm2PvEF44SEUat+s3mHQ8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a088ea6d-6dd9-4259-dff3-08de189414b3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 15:42:21.6095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p237PH3K0HakKVyJSC8orepoOuwQZsooEoK3jHuRFksfjh9uZOD37vmZC2xL2udD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7730

On 30 Oct 2025, at 23:42, Andrew Morton wrote:

> On Wed, 29 Oct 2025 21:40:17 -0400 Zi Yan <ziy@nvidia.com> wrote:
>
>> This patchset is a follow-up of "[PATCH v3] mm/huge_memory: do not change
>> split_huge_page*() target order silently."[1] and
>> [PATCH v4] mm/huge_memory: preserve PG_has_hwpoisoned if a folio is split
>> to >0 order[2], since both are separated out as hotfixes. It improves how
>> memory failure code handles large block size(LBS) folios with
>> min_order_for_split() > 0. By splitting a large folio containing HW
>> poisoned pages to min_order_for_split(), the after-split folios without
>> HW poisoned pages could be freed for reuse. To achieve this, folio split
>> code needs to set has_hwpoisoned on after-split folios containing HW
>> poisoned pages and it is done in the hotfix in [2].
>>
>> This patchset includes:
>> 1. A patch adds split_huge_page_to_order(),
>> 2. Patch 2 and Patch 3 of "[PATCH v2 0/3] Do not change split folio target
>>    order"[3],
>
> Sorry, but best I can tell, none of this tells anyone anything about
> this patchset!
>
> Could we please have a [0/N] which provides the usual overview of these
> three patches?
>
> Please put yourself in the position of someone reading Linus's tree in
> 2028 wondering "hm, what does this series do".  All this short-term
> transient patch-timing development-time stuff is of no interest to
> them and is best placed below the ^---$ separator.
>

How about?

The patchset optimizes folio split operations in memory failure code by:
always splitting a folio to min_order_for_split() to minimize unusable
pages, even if min_order_for_split() is non zero and memory failure code
would take the failed path eventually. This means instead of making
the entire original folio unusable memory failure code would only make
its after-split folio, with min_order_for_split() and containing the
page marked as HWPoisoned, unusable. For soft offline case, since the
original folio is still accessible, do not split it. In addition,
add split_huge_page_to_order() to improve code readability and fix
kernel-doc comment format for folio_split() and other related functions.


--
Best Regards,
Yan, Zi

