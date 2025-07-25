Return-Path: <linux-fsdevel+bounces-56004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AE4B116BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 04:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E57AC3CE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 02:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE0923ABB0;
	Fri, 25 Jul 2025 02:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rdgvkP6j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3195739FD9;
	Fri, 25 Jul 2025 02:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753411972; cv=fail; b=FDaf2Mwl14ORIFIztpEX3ciPvKDjhSuV3BT6PywCryxnJ3KxTnVHC3/nJtGlvpiQa/wgnd/Blt5K0xiYKdcXsF3E74F7J9GyRhZRafpRy+6WncF5U0Ua+QOMagp3BHbclxRlj+M9nKeXwlx0by6gk85APihMLxbiFnt1NzabXoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753411972; c=relaxed/simple;
	bh=vkM8y0ZMQ/GOSJjKw0pIAn+gj5FWeZF4uQT9EyMKx+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nK6nIZLLEl8i/LQCL79QfzWWuIqZPMCQBJchjP69uVJ4ae9ebfgrl6Nk/QzkXfGWZVLBDoVcBKpH9ZAiamxA/Gug3W5yscv8ru9mer2M40sf0yklOZzjg2HMBQXJYoRBVRBjMx3/vdA0iPb51BTbMpo6sm3RmfJiUdpcPX3QsTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rdgvkP6j; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HC807LyIo8XdCN5kXiXHUDZuZbZi1t3M/65xFQWX6u6Xb6KLWD+h1++dEsRm3XGoXKu/wVwUjjKAo4ttyNGTiBS7uP8gaBiz3pcTKq/CJs2XM3kpjvVGgcLpJ2T+wyjydAqamz4cZ+a3JUjnHimBRNHB4cY1PL5nfulbxsksPG+oVUKh2YgpxLQ40sYtnApXT614ETmEvrhUlX/jKlWZSakplR/V61KmkBZ81CI1zPWsoaSupve7E8XYqs/gFFWjzbmJUlldFQ0Yc8s5Wr1FWx7d25C/3GLShqWhnqNM3n/j/dL3iwaGxpGuvojMGRgvPJxs7VHi3Kiq/CK2avToPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5GLXlMmYIMgJhQq11e4TjdsK1hSZv4U9wSQr1PyNL0=;
 b=e7s9j2IBmtuIXEjXNWYT5MRqiOkklaFZptykm+UevbMkTGvu+4bAeiYBGNwO53dkIbuxCvY3kU6v7V8TG3ec25knBuXtZCp4egAUznyLZo/bJ9PBIDuWcWrKWCaIvKQdz6tF8LN0yeYqSgjVL7XeYbTytENcjfolQgyZNrO8YOfu2tPKxwav8aodMizIj3LbTyCEZStG9HOzoTgfikpvDqcZ/b3fF2ldZt0/edFMVrYi7orV30Nlvsn+MJrwYCQYNulFwQ5U2dq7WXbiTHrF72em7W59AcgkIHpX6uHSHfcQHXzhyogttFipqZnMH6CqmN/5K4Gg/fpsHAhN6R32tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5GLXlMmYIMgJhQq11e4TjdsK1hSZv4U9wSQr1PyNL0=;
 b=rdgvkP6j73OB5XAYNS1OOyoEOFhKuq+U/zCGZwZutkQ1S+3BMvGn/iYxII2a7JlY6kmVgqeTY/aqBk1va1jvFVw4YXDu/hPKpYgt4TmDf9WZZuS7Rh7gv/eZFYlIN2uzdd1xrKfZkZvpCOeis7Q0BG9O5KtsKFboElX7E5ir221SN1aha9NHHEhyIixCbEZJhWhCV/Ki40myC57TAmWdyhKeW/zsY1W713TxD0N0iTQDeQvaGzcEnQJ6jyUTdv6witftyGRqAXNCm7Itu/+Bg26CR5NpycdSOOv6YPzgLB+iim6rcHoWJVvWEovILkYRI5XWRbocJTTuqzdYr+oUMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB7371.namprd12.prod.outlook.com (2603:10b6:806:29a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Fri, 25 Jul
 2025 02:52:48 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Fri, 25 Jul 2025
 02:52:47 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 willy@infradead.org, linux-mm@kvack.org, x86@kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [RFC v2 1/4] mm: rename huge_zero_page_shrinker to
 huge_zero_folio_shrinker
Date: Thu, 24 Jul 2025 22:52:45 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <48AA7622-4E9F-4749-B4DE-82FA9F749D51@nvidia.com>
In-Reply-To: <20250724145001.487878-2-kernel@pankajraghav.com>
References: <20250724145001.487878-1-kernel@pankajraghav.com>
 <20250724145001.487878-2-kernel@pankajraghav.com>
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0398.namprd03.prod.outlook.com
 (2603:10b6:408:111::13) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb5a5a2-2d25-47de-070b-08ddcb26567b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9qFAT/jH+C8QcOPhJ7wXCqDArTRbdMyDyRWUm2Eo+epDSdVH+Qa3mtkewSNN?=
 =?us-ascii?Q?I+oWBgk/5udL3JoIwen/vyjXDq1exuu+VROOIBG302SMxw+bP7ynXJw2Zc73?=
 =?us-ascii?Q?nUlx0YpAfXp0fvn/K5xMAABhNh5F0JK3wwG4oPyz2REUj4whw1J/gmkFlPFL?=
 =?us-ascii?Q?8xUpkl2mbInDLJdBxWTWKZzV5aYu4pQXHbVWDfbGnbHeLRofWmHrxp6sI3ys?=
 =?us-ascii?Q?VqAl9d/S4rTTa8QRSycaN60vMwuneCmfANUgabpElhaPqaSE0ddArZpuDiqj?=
 =?us-ascii?Q?4ttG2NeJtXMyFbRIqO0FSTyQ+k3kPwHrn5vysAoR4x9bll+l1HXxBcvAJXHm?=
 =?us-ascii?Q?1zjsu2TAj/Lk+KNlWhwKr5cfB+x9Z7lgmKVIZIMaYMO9j1gD45GH9f2nfqAy?=
 =?us-ascii?Q?LnyLVz/2LdfRxh/wz4rqMI0wW8j6dUZJu8tBRZ/+A+4B4DYeeiKWJJWF9wVd?=
 =?us-ascii?Q?omJvbcYWs0T/VWJKW/2doce1Fmvl4TqPIgMkMTN/yh12KbYIQw2edrBkv39W?=
 =?us-ascii?Q?aUvk4S9Pojp+0rGoOCpjyu++niSIXb1jrikr9CKR9hS9czDspOwIXlsdIeQP?=
 =?us-ascii?Q?PxhHr79fFp+7NPafrQNm4dGvDMIsUkG7ej1OuB86W/YbnCM4qF3W9frMycwM?=
 =?us-ascii?Q?uuqyAFN60cV/qXbXcmdyqbXT2lUybWRmgu/fOxfijS3auv/GQRtq1gx4aIIm?=
 =?us-ascii?Q?JgvJ92DL989p9Cj3whZlsnzB+DJVO9rlPH8hy7rQBT64aMWyXtVD5+aq7cdU?=
 =?us-ascii?Q?p43tWOJf5LZ0hiZTkHNAN/EZsSET+YnJV6m1G4rAwv8uzdLwOvuwaLvs91qk?=
 =?us-ascii?Q?R/VIX6B/mPW3nsyZWXkCtI0br7XJCQU44c9MMNvM+Tx/HutGKF/oTMxb0IUe?=
 =?us-ascii?Q?0po95xNrwOpYSyBFBV2dqNozaYtsLjECziHbRogV5uXaqG7ISOfXNARMVMCU?=
 =?us-ascii?Q?l/tsbEYsZbHCljuoEAC+IptP79BptAtGMu/b/EoMLtKAjcp6B/3u5zGDeP0r?=
 =?us-ascii?Q?gwbWR0kxSHC2hvgKjhOduZzVo9NgQeFFK6h1py5TEvaxau44yw9s/WcsBcrV?=
 =?us-ascii?Q?xHsdrodzEOGvrpUTsqMdT+ZQ4JzcSJ7oty7pizNuyRctNOK1eZGdTuGItX+8?=
 =?us-ascii?Q?nDwIqz2p8vTozmrX0B/6/+tH+UJtYlbVCwPyzS3zE9BsJC9rHXZwHlnR4qss?=
 =?us-ascii?Q?uktjoui2zQzxWEouZs8QfOV6dA0cEaVi7ubachVzNgkmTF1khe7CBwkNjG5I?=
 =?us-ascii?Q?ZtSyvCRyXDOBDrm3nlqC51twShDuPtiYwQduOs+V+7aAhYtuh9MMnD8bKfy8?=
 =?us-ascii?Q?VgCpJQXS/Gb98l1trK6WftZIDY+algiL0mbRukMZGkc4dSUbLMw0nTHNQC92?=
 =?us-ascii?Q?QAJ1aG0bSRJ3Q4QgXTCnU9N5jatIZwhQ9R6VrrP0Lw8RZLFCHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cXUGOz7OnU+9IH8h5HIhw281NdxZyrLVtcWyl6ziB2gzwRtf97j4ulzUCYF8?=
 =?us-ascii?Q?NXCo9aFVU2/N2sxmuSLorD8X8s+dAu8QbeYdP/zmJWp0P5HUrr/Pn/kQcxgB?=
 =?us-ascii?Q?76P9QLHH0HtKbYQr+366Y9kZdty6ruM9bQjWaGDNFbGR/CiVsPHblfWyRbb5?=
 =?us-ascii?Q?9Q8/L4AWwQeSidu6zeltwWz9urC3DXgDfyYk4+SF/8Rh9FyyTT88dqAtFaVn?=
 =?us-ascii?Q?jLn5OYjWEFCFp1Ir5brEreMcS76aLmX9Riseb1ftXdaYGd6eWQFAAZ4dsHG8?=
 =?us-ascii?Q?iCceznkXPmeHLaPJUTd3BEOTcrp1pfnDtqS2GGE3tlfFsyqaDwehWz9u7qZP?=
 =?us-ascii?Q?TuR/SkzXq6z8MtDOPcB2mUb23M4Gkie1Kbf/FpnmsxTGCI2OO3O03258fiAv?=
 =?us-ascii?Q?Jyx9wPUiqhPLondXV505VjuPJyC/oIhp6zFgqLPI9q8EuVIMBS0a0MQzbPHI?=
 =?us-ascii?Q?detdMcF2ChR3fsoZ2OAPD5GtgNPmuAaD7olS182X+RVmMvFYSILjttTig74x?=
 =?us-ascii?Q?I7t/vWP5YWG5C3x63e1/hpD98nzBkCu5jTGcPxTwafMqkT9337ve+6rHF7AW?=
 =?us-ascii?Q?df6chZjo+psC/pmK7kx0FD3Uq2XREJbR9RLqLtZL58Q0L2gJ4NmeNZhsEVus?=
 =?us-ascii?Q?NV6FQX/FGWMCKRo+nVUrZlc950sbOw/GSHXKDEz0Ul+T0/JspvkI/F2d8PGP?=
 =?us-ascii?Q?kCar1doFswJIPgTfJaj27Fe+HuF9DN7mQKYun1Mq0vln1dKX/CmAbxPLdabF?=
 =?us-ascii?Q?FDlbK3GSGuZWytJ29UKv2J1/Q9E5n0WdnGshZ3mg5whKI/Vh6f2pWSzbrr7H?=
 =?us-ascii?Q?OhldiDVgHLPZEkeZeCfo06AaU0lt/KKBIWf3/MMCGdbM9Cxr5sz9f6PNbl3H?=
 =?us-ascii?Q?p5283Ju17tgakuoJzipxSUoYMNMOQNlSUSGGcS5F1uHt6csV9MTJRAh4Lvn0?=
 =?us-ascii?Q?YP4LNiAuDzAqC2mUBM5X9l34VS+mGNZB8g5fYEZMZXfi+GVjzqb8mQfGQd+S?=
 =?us-ascii?Q?IWayAVCOU9x6uJwflWuXayfwO3ZaTkiMOv8pMabxJI1U0lYRl9ZO9hXsbKqN?=
 =?us-ascii?Q?c+PmLn7f5p1ZhrnQjll3bDbsndEgo4mcEhrQdcikx2IDGRpfm0Y31SSPgPB4?=
 =?us-ascii?Q?u6YE+V0CdRlHcs84xSSxCDCPsLeX35DtyME/lWZ/g8zyp39GnqHwxgYE83Iu?=
 =?us-ascii?Q?kg0K5y5OtCymN3Kh3AFakD7k+uyinshfrDLJ3OZiBJ3da9tzNmvrddeoHtv7?=
 =?us-ascii?Q?GjQ6wpmK1ZfYnf4LkL1KS8YRlZpsZqBCUEyDbtFwUQAqUEs3WWOX0coUrFdH?=
 =?us-ascii?Q?r3CS9ioOjivIuATKrSG4Tx7s+ANW6pUbv6iic08yjWx/5MsrR4QHHxYuq0ZW?=
 =?us-ascii?Q?hRtU0Qcm9tPXO1Z9jadzfISGXye702sV27Xjt79uzfLuPeJA4gQ/ZODcqt7D?=
 =?us-ascii?Q?GL72U8I5/uOI46PUNGQXGRICK8nui1wnh7T/gEdmfUVKqzuf27PXXZPvsw6x?=
 =?us-ascii?Q?4L6jrbADzg8YzLB71iIjK50aVP8WL6/qCYE3GF1j4iJTXuhPsLbIYeF5zRJN?=
 =?us-ascii?Q?OvllVV3nnnx4yFTSwfW5eZzQj5OylptDiLNgUqQ+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb5a5a2-2d25-47de-070b-08ddcb26567b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 02:52:47.7780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ryzb7R173ojaM0Q4ZLxxRrfuD/y6JgNODQ3V3/yKwyU2coS6mzhnI6phAoDIoIpC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7371

On 24 Jul 2025, at 10:49, Pankaj Raghav (Samsung) wrote:

> From: Pankaj Raghav <p.raghav@samsung.com>
>
> As we already moved from exposing huge_zero_page to huge_zero_folio,
> change the name of the shrinker to reflect that.
>
> No functional changes.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  mm/huge_memory.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

