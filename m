Return-Path: <linux-fsdevel+bounces-43480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAA8A572F5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 21:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92CD2188C5F2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 20:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242D82571CA;
	Fri,  7 Mar 2025 20:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B45rgLb7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82942571BA;
	Fri,  7 Mar 2025 20:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741379628; cv=fail; b=BcsYGdwk9w/F5tywDmV//Sq/NmG7bCuYVBEpOMAGeA3i1nd7ZEHLsQHXf0uLuzeBa0pCTarbazKb5Vt7mSsaKmXDg0wudHM1arqjxcTYJ0d+Kkxnf2ctyZShRx+cKt78scyo5u7uSE4T2iqZSiTIolWCnhY12wt8/a4YGwI+FF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741379628; c=relaxed/simple;
	bh=UD+UlIrVIplxNh/k8mrRWUWtVAwp3/vcSlLxgGfCzMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uta6QqCnA7qOlcRoB/HFBKzf1r1RBkObYwtIGiyOgtgPQCeIJjLsEJR7Y2gr8nAqW0mp8uiKkUDt1QtJurUz79zPSAx4o+r/XZIdSaVhTs3B1FnSDCRVLALLMdllZktpHxLmThFN4IyefFSIVUjva2lK90T5R2skwdlaMCPRgwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B45rgLb7; arc=fail smtp.client-ip=40.107.212.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cR2psxx+xoWYdYgIIZL6jhFqq/PvSDcGPhNgRsaVAlccsHjR8CPpKuzWxXVSdcLySSad29M+Y0buUt1a1Z1FKooym6mD5Cyo93DmiC1+fMr9EZvPoG0oPklAV8WyBTWp1IJvya1h7NC80WiIEBt5paz0H2TpwR8EuoY2C08PiySaSae+Pb3/iYNVrE/yz6SWFrxOoQYn4jR1zYDa5wvv29jpjel7cJAMPi+n0Pztp+JCrh1fMzZpZuL7iIQ1vZTxnS7fdvXBXclIhuOxlhxsjbALRnk43xYQxUaSUKKQAYAtCcMOBhuPMSoaPcmsvWfiSZE7Svb7pVxiwW+Z3zNRmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wgn/m7suguCe09Rb41OBz3pdsN/TSkEwm6vrKAFS4QY=;
 b=DkTgwdMxOHX4X031T5pPvZWja5LEV30TJs7aAV19dl+q3YdFPnVNKgr+52tkNs+llCoHXPEKD4GebxFzOYp9LON/iUyaTKlAcznhWM8mq0e1YMrNEfhht7R8byjEPfG7c1YTsVgc/t0PFIIubDcD8X+PGF5yeEdF+t/IGH0jmnNXT/WaZjNKBjF0dlt7WECYNp/uc0X5J2B5TkpOavpRMvX+ASds7RMkiVTcgnkZXzPXJs2BlfPpKnJBK0Bd7jujdiIyigC6zR9edn01UcOeL/M9Uy2GW3X6Hyl08mZB4YXXG3wV88FgOOJ9s7E7lQtlFxecF6UEt+b7/oswjrPnAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wgn/m7suguCe09Rb41OBz3pdsN/TSkEwm6vrKAFS4QY=;
 b=B45rgLb72kF4K8L1s+8KH8nn5JCtfGT6DpqS1SXZNU2B4LW9mo0GYopY3KZpBb9QhDkv8s1F/SMKK4NnzsQrUJZlL2ZH5WZlbZ0Lyvv2InN3FLD/gvsTjyTJHEp2rXhuoM65WLY67aBlY7n68owMfZDHOJ2JdiWOrrKNNzz2SD2lp6EZGFicP73rTomz0AWafZ1s94QLruybtsb2Q7QTO/wcyH1a/QbOZQjLyvmGMyi19VJQw8+IjJLlV0yAlt7OPHpDZQd4cimlFu55n3nJ/QGOqwUZDoETr2i1FU/du7cAaXbVT6+afXCC7mtYehnAqaG5oKzqVhAZT9PUnq12tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CYYPR12MB8922.namprd12.prod.outlook.com (2603:10b6:930:b8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.22; Fri, 7 Mar 2025 20:33:44 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 20:33:44 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>, Kairui Song <kasong@tencent.com>,
 Miaohe Lin <linmiaohe@huawei.com>, linux-kernel@vger.kernel.org,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v3 0/2] Minimize xa_node allocation during xarry split
Date: Fri, 07 Mar 2025 15:33:41 -0500
X-Mailer: MailMate (2.0r6233)
Message-ID: <104F428F-B514-401A-931F-182B636026BB@nvidia.com>
In-Reply-To: <20250226210854.2045816-1-ziy@nvidia.com>
References: <20250226210854.2045816-1-ziy@nvidia.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0433.namprd03.prod.outlook.com
 (2603:10b6:408:113::18) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CYYPR12MB8922:EE_
X-MS-Office365-Filtering-Correlation-Id: 3441db00-4be9-442e-274d-08dd5db75ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NzL4lA6ieiYRlTBR+2+r2rewPxKnLJmuFQVYJe5rM1r80FXcuEdw4reoNhKU?=
 =?us-ascii?Q?lQhrN0Ge32XPai285sw8QSG24Uu/U6dlOm+lu9jVqR6H/vSPpz8E2XUnj3tG?=
 =?us-ascii?Q?rrkOVk1+1Jo5fIkZGdYXbM+ItKEeNHw9K5JXfJZlp1902/gGkmaNDQHKsnJH?=
 =?us-ascii?Q?kUzWIBzJTtMPddSCNEij0dhcg5/o7KNi5yn1bp2mWG48pwmhxnkUbIcNLq9C?=
 =?us-ascii?Q?FPxqqPjUyGGlmpMPREd9GTXVdTM9G1nbc9xpClS6bUrOkZ18VZ1Flj64QLOP?=
 =?us-ascii?Q?+NsBvB0iQm93uQk71jen2japWOwv8g1+FvXDvEO07Ctsx0NdvWO1ZCEAh68I?=
 =?us-ascii?Q?oZpko8FzsyRSkF1CqAqHtdrNc9aYBGGnUE6PA3Y7wbW2aCOAipvqVbotIdqQ?=
 =?us-ascii?Q?wdEo4veDRr9Y15D8cPkC9UkTJAzrjMu2Ckgasknr+T9vhfo1dRk2ZMV8G+I7?=
 =?us-ascii?Q?zMWehwx72J0lSgdovl+pCttnx4yVzoVi90admhae9ElSYAGZm6+FPoZEF5Rl?=
 =?us-ascii?Q?DawDG/aSQj0aqRFWrsJK2DRe+LPWsYdnnXR77itlbQLhAm3PI1JmQYqQhcXX?=
 =?us-ascii?Q?H8nV+6vQQgsR6wozb9LrSM+a0ThpOYyVVpB93Mv6jAkyq1ibE/UEmnslP2PI?=
 =?us-ascii?Q?nlmDmsZKUTFGDCqZnRgotPA+fDwS5zseMUUwucJvxhEUdPftP+mH9RvM0P8G?=
 =?us-ascii?Q?Xg/QN0N4ob28/FiDm6sr5pQQkbW6MSUzapAhPe20dl4zV2bPDFlBCuPYVK+i?=
 =?us-ascii?Q?9fdpFrXZWIyEaWke/GOkDCzyJlDoL/9H0i3/jkrP64wjK8LD3Tlv2w2nkkBO?=
 =?us-ascii?Q?tXR8VgkHONJe+CQMHBhgTf6+0gToXmuRt02hlXOKg2b7Qjb26f6rQXYhYr4O?=
 =?us-ascii?Q?WCGJ7P5Y/ZN17CCftBPdKpnzF7yjURUnoh/kTSLiTyMJKpkaCA2K0/3/KDee?=
 =?us-ascii?Q?eRTK1PGRTVT8X/TpfssOPCw1qDqZWWJLerSDvcs4dyydKyu5Jnb0UOdLdayS?=
 =?us-ascii?Q?YQO71BAgGf/qSpZgELSY5/Oc7k7Y0AdKFsTvWJkFsh7x+vu+vkl3xAUVRIVo?=
 =?us-ascii?Q?PdAj2y1jIvsWfFyFqW4GlAfDuGpdq0p5nYdtmMtWvDIz5jm71ec7PDtKY2Q4?=
 =?us-ascii?Q?TXDUwx6DB09NelgT6/yWBnvEodjGiSDzaaxf8OKV7c9oumvRT6NpRK7LewAt?=
 =?us-ascii?Q?TdehHn6WEBdvLxegbHIymRbD7/8WYAJ0+eTlFyUc7NAl5+nkjSLd7mPmqXQt?=
 =?us-ascii?Q?mu5dVcgrSZvnG+ZUfBpcZUMUE8JgVAnuFAV45iLhgWtOjrf05Rjdl/NhRMZw?=
 =?us-ascii?Q?/PKmyLINdUwcNoLCRTWfmWuhbcYdnZKyUWAU5CIM+j3ggmMSNye2PgoF1E0J?=
 =?us-ascii?Q?eQzK2Tn4zzR3MQV4EgzvkXgMCppW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L+1d0gHosxzP0WbZHK6qcTjLoq/yFpJnRiSm0qkVxgQKAtOFn584EuQQ2hWF?=
 =?us-ascii?Q?NKCKnPdbt/z7cQxQlvDTyxe1bY+AMgnwhz16M275mRL4qTK4qAHVcUbGbWxj?=
 =?us-ascii?Q?SUMHf9I5gISsnHrPqW3OFLode73xqp0wBB+EunfNSbnARf7CnwD03yTNU/93?=
 =?us-ascii?Q?eGfsKSbrFn6UCfdXYhpecZ5tjevs61TqmgrNiIk0nfR+6cpYHsgjG7jq4i3m?=
 =?us-ascii?Q?AzsWQS4FJsy/JV3zpGydDIHLXN/hs692t221EyLwmEet9cDqkSdIMKjnz//Y?=
 =?us-ascii?Q?jjhAPwonKsWMvz1CdF2qFl+rnJqeFo7AadSoTaFE2Raa792hoMBeMUHlCpAX?=
 =?us-ascii?Q?iTcCFS2C0Qvygy3Roi5tl/MHIcKdcXuXeyX1ds2MnWHprKEwCddJ2dus81iv?=
 =?us-ascii?Q?fOthgymcuD4b/NG1e9exk1aY4AUphAAQWz09kPefq1He+qQqYsvHHNQ09xJa?=
 =?us-ascii?Q?Tzj2RVEJvdeKWyRreqlBYW3rNqB6kLSpoIjp4m5Y6+tzVh4fjMj7+1o67x59?=
 =?us-ascii?Q?R9j2i24E2L37dDgK+uA0fSKDfAE6vCpuSTlg2/Wzbp1CpD/hQEc7vSTPoZp2?=
 =?us-ascii?Q?95JxXMGq9Dev5H+vZW7dlLrxS0wM9sQJrltnqwSpghZ/XouNfJL/swKXpsqM?=
 =?us-ascii?Q?yYXhZYrH7XrYDoCyFbZkwbkPjfLpAJEaOHDWTw1nPdnmL48vS1+esvG1Z3Yb?=
 =?us-ascii?Q?E3SShQQjPdubE76pVwDo95mrBwjjmep086ctwDaYSL2zvKVED8lxCCPSUUww?=
 =?us-ascii?Q?Olx8EyS0v/J+/vRSeBw/t8T2n+2PIyJ63bnaKiT4o//MboFQ8Z7bz+JGbYI4?=
 =?us-ascii?Q?pygrS5hroZXiHO3eWNR6FU+j0ECJGbXqROgPyWL6+RT9jZT8tEaP9e0iRtDV?=
 =?us-ascii?Q?MKb32rYPjAcgNn/l/E5YhiWMPUZy45wjGvPrk0TemG+BoQPOJ4+xMW3KPa9g?=
 =?us-ascii?Q?onIwpk+OdJjEx0p/E20pnqoroWoCT67R24y/hYFLeSTXsSeSyBnxDmJ0WrNz?=
 =?us-ascii?Q?DOieZZjEuaGbmm/eYfSEErkDF1O7pEiBko6Yorse+VfaP6pyPfgXdMYENhS7?=
 =?us-ascii?Q?f97SMGULCi236VHWQwjEIkeJJFRR8fico/rFnLQX4mREWaBpYQf+CSEpEhEH?=
 =?us-ascii?Q?MWG57cgsRulzWaJMCZ8AKqHzollZ+hrDdC6QKnfB52/nJ628HbDzZIbtxjBX?=
 =?us-ascii?Q?DmENk8Erk719uitkT8jSweOQSfu4xgS9Bkk9zRYGDQbbTJa59xgStThZvzib?=
 =?us-ascii?Q?Xhuaj6erENRVGr5EkXQFLHfC2IpLPnPwjaP+GppOO/o8Ds1ezdHmakizCYgn?=
 =?us-ascii?Q?VuOylvhL52XUeqaQ1cC+If5TqtievF82BxFs+AfbablSjUG1TtIwMgv781Xv?=
 =?us-ascii?Q?OHxdCGQjGM2EYVjUtK6mJI4RhhT2v2FMryES8z1A98nsm5SuyQWuqcHfzHHe?=
 =?us-ascii?Q?20LFnH9TAEfL+88zKS9ezTtJRQBqf/Ltf8yM955bgeERwXI31yewGwxZSVIW?=
 =?us-ascii?Q?geY4jmVtgl3uGMlmHDIJZnr7fApmhU+j6X3/HhmlXL12Uv623x2eM8u5CZsS?=
 =?us-ascii?Q?glM+TrUMq8N3sTep/QIDupHLw5nH2qnmFnQAebD+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3441db00-4be9-442e-274d-08dd5db75ab1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 20:33:43.9547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bViw3jq55AiwHj+BhtPCDbykPA/G4+Vt63K58WaIFs1KHvO7HCJVf2RXvAdkr83d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8922

On 26 Feb 2025, at 16:08, Zi Yan wrote:

> Hi all,
>
> When splitting a multi-index entry in XArray from order-n to order-m,
> existing xas_split_alloc()+xas_split() approach requires
> 2^(n % XA_CHUNK_SHIFT) xa_node allocations. But its callers,
> __filemap_add_folio() and shmem_split_large_entry(), use at most 1 xa_n=
ode.
> To minimize xa_node allocation and remove the limitation of no split fr=
om
> order-12 (or above) to order-0 (or anything between 0 and 5)[1],
> xas_try_split() was added[2], which allocates
> (n / XA_CHUNK_SHIFT - m / XA_CHUNK_SHIFT) xa_node. It is used
> for non-uniform folio split, but can be used by __filemap_add_folio()
> and shmem_split_large_entry().
>
> xas_split_alloc() and xas_split() split an order-9 to order-0:
>
>          ---------------------------------
>          |   |   |   |   |   |   |   |   |
>          | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
>          |   |   |   |   |   |   |   |   |
>          ---------------------------------
>            |   |                   |   |
>      -------   ---               ---   -------
>      |           |     ...       |           |
>      V           V               V           V
> ----------- -----------     ----------- -----------
> | xa_node | | xa_node | ... | xa_node | | xa_node |
> ----------- -----------     ----------- -----------
>
> xas_try_split() splits an order-9 to order-0:
>    ---------------------------------
>    |   |   |   |   |   |   |   |   |
>    | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
>    |   |   |   |   |   |   |   |   |
>    ---------------------------------
>      |
>      |
>      V
> -----------
> | xa_node |
> -----------
>
> xas_try_split() is designed to be called iteratively with n =3D m + 1.
> xas_try_split_mini_order() is added to minmize the number of calls to
> xas_try_split() by telling the caller the next minimal order to split t=
o
> instead of n - 1. Splitting order-n to order-m when m=3D l * XA_CHUNK_S=
HIFT
> does not require xa_node allocation and requires 1 xa_node
> when n=3Dl * XA_CHUNK_SHIFT and m =3D n - 1, so it is OK to use
> xas_try_split() with n > m + 1 when no new xa_node is needed.
>
> xfstests quick group test passed on xfs and tmpfs.
>
> It is on top of Buddy allocator like (or non-uniform)
> folio split V9[2], which is on top of mm-everything-2025-02-26-03-56.
>
> Changelog
> =3D=3D=3D
> From V2[3]:
> 1. Fixed shmem_split_large_entry() by setting swap offset correct.
>    (Thank Baolin for the detailed review)
> 2. Used updated xas_try_split() to avoid a bug when xa_node is allocate=
d
>    by xas_nomem() instead of xas_try_split() itself.
>
> Let me know your comments.
>
>
> [1] https://lore.kernel.org/linux-mm/Z6YX3RznGLUD07Ao@casper.infradead.=
org/
> [2] https://lore.kernel.org/linux-mm/20250226210032.2044041-1-ziy@nvidi=
a.com/
> [3] https://lore.kernel.org/linux-mm/20250218235444.1543173-1-ziy@nvidi=
a.com/

Hi Andrew,

Do you want me to resend this? This still applies cleanly on mm-everythin=
g-2025-03-07-07-55 plus V10.

Thanks.

Best Regards,
Yan, Zi

